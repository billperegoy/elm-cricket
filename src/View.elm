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
        div [ class "player-column" ] [ playerHeading player playerActive playerScore ]


playerHeading : PlayerId -> Bool -> Int -> Html Msg
playerHeading player active score =
    let
        playerName =
            case player of
                Player1 ->
                    "Player 1"

                Player2 ->
                    "Player 2"
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
