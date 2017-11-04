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
        , div [ class "row" ]
            [ --playerColumn model.player1 (UpdateUtils.getCurrentPlayer model)
              centerColumn
              --, playerColumn model.player2 (UpdateUtils.getCurrentPlayer model)
            ]
        ]



{-
   playerStyle : Bool -> List (Html.Attribute Msg)
   playerStyle active =
       if active then
           [ class "alert alert-danger" ]
       else
           [ class "alert alert-warning" ]


   playerColumn : Player -> Player -> Html Msg
   playerColumn player currentPlayer =
       div [ class "col-md-4" ]
           [ div [ class "row" ]
               [ div (playerStyle (player == currentPlayer)) [ text player.name ]
               ]
           , div [ class "row" ]
               [ button [ class "btn btninfo" ] [ text ("Score: " ++ toString player.score) ]
               ]
           ]


-}


buttons : Target -> Html Msg
buttons target =
    let
        value =
            Target.value target
    in
        div [ class "row center-block" ]
            [ div [ class "btn-group" ]
                [ button [ class "btn btn-info", onClick (Hit target Single) ]
                    [ text (toString value ++ " - single") ]
                , button [ class "btn btn-info", onClick (Hit target Double) ]
                    [ text (toString value ++ " - double") ]
                , button [ class "btn btn-info", onClick (Hit target Triple) ]
                    [ text (toString value ++ " - triple") ]
                ]
            ]


centerColumn : Html Msg
centerColumn =
    div [ class "col-md-4" ]
        [ buttons Fifteen
        , buttons Sixteen
        , buttons Seventeen
        , buttons Eighteen
        , buttons Nineteen
        , buttons Twenty
        , button [ class "btn btn-info center-block", onClick Miss ] [ text "Miss" ]
        ]
