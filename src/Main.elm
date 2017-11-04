module Main exposing (main)

import Html exposing (beginnerProgram)
import Model exposing (..)
import Update
import View
import Initialize


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = Initialize.model
        , view = View.view
        , update = Update.update
        }
