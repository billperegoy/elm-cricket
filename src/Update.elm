module Update exposing (..)

import Model exposing (..)
import Magnitude
import StatusUtils
import Target


update : Msg -> Model -> Model
update msg model =
    case msg of
        Miss ->
            model
                |> updateTurn
                |> updateDart

        Hit target magnitude ->
            model
                |> updateStatusAndScore target magnitude
                |> updateTurn
                |> updateDart


updateDart : Model -> Model
updateDart model =
    if model.currentDart == 3 then
        { model | currentDart = 1 }
    else
        { model | currentDart = model.currentDart + 1 }


updateTurn : Model -> Model
updateTurn model =
    if model.currentDart == 3 then
        { model | currentTurn = changePlayer model.currentTurn }
    else
        model


changePlayer : PlayerId -> PlayerId
changePlayer player =
    case player of
        Player1 ->
            Player2

        Player2 ->
            Player1


updateStatusAndScore : Target -> Magnitude -> Model -> Model
updateStatusAndScore target magnitude model =
    case StatusUtils.getStatus model target of
        Active player1Status player2Status ->
            updateActiveTarget player1Status player2Status target magnitude model

        Closed ->
            model


updateActiveTarget : PlayerTargetStatus -> PlayerTargetStatus -> Target -> Magnitude -> Model -> Model
updateActiveTarget player1Status player2Status target magnitude model =
    let
        currentPlayer =
            case model.currentTurn of
                Player1 ->
                    player1Status

                Player2 ->
                    player2Status

        otherPlayer =
            case model.currentTurn of
                Player1 ->
                    player2Status

                Player2 ->
                    player1Status

        ( newStatus, newScoreIncrement ) =
            buildNewStatus model.currentTurn currentPlayer magnitude otherPlayer

        scoreIncrement =
            newScoreIncrement * (Target.value target)
    in
        StatusUtils.setStatus target newStatus model
            |> incrementPlayerScore model.currentTurn scoreIncrement


incrementPlayerScore : PlayerId -> Int -> Model -> Model
incrementPlayerScore player increment model =
    case player of
        Player1 ->
            { model
                | score =
                    { player1 = model.score.player1 + increment
                    , player2 = model.score.player2
                    }
            }

        Player2 ->
            { model
                | score =
                    { player1 = model.score.player1
                    , player2 = model.score.player2 + increment
                    }
            }


buildNewStatus : PlayerId -> PlayerTargetStatus -> Magnitude -> PlayerTargetStatus -> ( TargetStatus, Int )
buildNewStatus player status magnitude otherPlayerStatus =
    let
        newMagnitude =
            updateMagnitude status magnitude
    in
        case status of
            Opened ->
                case player of
                    Player1 ->
                        ( Active status otherPlayerStatus, (Magnitude.value magnitude) )

                    Player2 ->
                        ( Active otherPlayerStatus status, (Magnitude.value magnitude) )

            Unopened value ->
                let
                    increment =
                        case otherPlayerStatus of
                            Opened ->
                                0

                            Unopened _ ->
                                value + Magnitude.value magnitude - 3
                in
                    if increment > 0 then
                        ( getNewStatus player newMagnitude otherPlayerStatus
                        , increment
                        )
                    else
                        ( getNewStatus player newMagnitude otherPlayerStatus, 0 )


updateMagnitude : PlayerTargetStatus -> Magnitude -> Int
updateMagnitude status magnitude =
    case status of
        Unopened value ->
            value + Magnitude.value magnitude

        Opened ->
            0


getNewStatus : PlayerId -> Int -> PlayerTargetStatus -> TargetStatus
getNewStatus player magnitude otherPlayerStatus =
    if magnitude >= 3 then
        openTarget player otherPlayerStatus
    else
        updateUnopenedTarget player magnitude otherPlayerStatus


openTarget : PlayerId -> PlayerTargetStatus -> TargetStatus
openTarget player otherPlayerStatus =
    if otherPlayerStatus == Opened then
        Closed
    else
        setActivePlayerStatus player Opened otherPlayerStatus


updateUnopenedTarget : PlayerId -> Int -> PlayerTargetStatus -> TargetStatus
updateUnopenedTarget player magnitude otherPlayerStatus =
    setActivePlayerStatus player (Unopened magnitude) otherPlayerStatus


setActivePlayerStatus : PlayerId -> PlayerTargetStatus -> PlayerTargetStatus -> TargetStatus
setActivePlayerStatus player status otherPlayerStatus =
    case player of
        Player1 ->
            Active status otherPlayerStatus

        Player2 ->
            Active otherPlayerStatus status
