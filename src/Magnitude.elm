module Magnitude exposing (..)

import Model exposing (..)


value : Magnitude -> Int
value magnitude =
    case magnitude of
        Single ->
            1

        Double ->
            2

        Triple ->
            3
