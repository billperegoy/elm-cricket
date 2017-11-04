module Target exposing (..)

import Model exposing (..)


value : Target -> Int
value target =
    case target of
        Fifteen ->
            15

        Sixteen ->
            16

        Seventeen ->
            17

        Eighteen ->
            18

        Nineteen ->
            19

        Twenty ->
            20

        Bullseye ->
            25
