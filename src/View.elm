module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import Target


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ div [ class "jumbotron" ] [ h1 [ class "text-center" ] [ text "Cricket Scoreboard" ] ]
        , div [ class "main-body" ]
            [ playerColumn model Player1
            , centerColumn
            , playerColumn model Player2
            ]
        ]


playerColumn : Model -> PlayerId -> Html Msg
playerColumn model player =
    let
        playerActive =
            player == model.currentTurn

        playerScore =
            case player of
                Player1 ->
                    model.score.player1

                Player2 ->
                    model.score.player2
    in
        div [ class "player-column" ]
            [ playerHeading player playerActive playerScore model.currentDart
            , playerTargetStatus model player
            ]


playerTargetStatus : Model -> PlayerId -> Html Msg
playerTargetStatus model player =
    div []
        [ div [] [ text "15", (displayPlayerStatus model.status15 player) ]
        , div [] [ text "16 ", (displayPlayerStatus model.status16 player) ]
        , div [] [ text "17 ", (displayPlayerStatus model.status17 player) ]
        , div [] [ text "18 ", (displayPlayerStatus model.status18 player) ]
        , div [] [ text "19 ", (displayPlayerStatus model.status19 player) ]
        , div [] [ text "20 ", (displayPlayerStatus model.status20 player) ]
        ]


displayPlayerStatus : TargetStatus -> PlayerId -> Html Msg
displayPlayerStatus status player =
    case status of
        Active player1Status player2Status ->
            case player of
                Player1 ->
                    selectImage player1Status

                Player2 ->
                    selectImage player2Status

        Closed ->
            img [ class "hit-icon", src "images/open.svg" ] []


selectImage : PlayerTargetStatus -> Html Msg
selectImage status =
    case status of
        Unopened 0 ->
            span [] []

        Unopened 1 ->
            img [ class "hit-icon", src "images/hit-01.svg" ] []

        Unopened _ ->
            img [ class "hit-icon", src "images/hit-02.svg" ] []

        Opened ->
            img [ class "hit-icon", src "images/open.svg" ] []


playerHeading : PlayerId -> Bool -> Int -> Int -> Html Msg
playerHeading player active score currentDart =
    let
        dart =
            if active then
                "  (" ++ toString currentDart ++ ")"
            else
                ""

        playerName =
            case player of
                Player1 ->
                    "Player 1" ++ dart

                Player2 ->
                    "Player 2" ++ dart
    in
        div []
            [ div (playerHeadingStyle active) [ text playerName ]
            , div [] [ text ("Score: " ++ toString score) ]
            ]


playerHeadingStyle : Bool -> List (Html.Attribute Msg)
playerHeadingStyle active =
    if active then
        [ class "player-heading alert alert-danger" ]
    else
        [ class "player-heading alert alert-warning" ]


buttons : Target -> List (Html Msg)
buttons target =
    let
        value =
            Target.value target

        buttonText =
            (toString value) ++ " - "
    in
        [ button [ class "btn btn-info target-button", onClick (Hit target Single) ]
            [ text (buttonText ++ "Single") ]
        , button [ class "btn btn-info target-button", onClick (Hit target Double) ]
            [ text (buttonText ++ "Double") ]
        , button [ class "btn btn-info target-button", onClick (Hit target Triple) ]
            [ text (buttonText ++ "Triple") ]
        ]


centerColumn : Html Msg
centerColumn =
    div [ class "button-wrapper" ]
        (buttons Fifteen
            ++ buttons Sixteen
            ++ buttons Seventeen
            ++ buttons Eighteen
            ++ buttons Nineteen
            ++ buttons Twenty
            ++ [ button [ class "btn btn-info target-button", onClick Miss ] [ text "Miss" ] ]
        )
