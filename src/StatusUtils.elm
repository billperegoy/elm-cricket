module StatusUtils exposing (..)

import Model exposing (..)


getStatus : Model -> Target -> TargetStatus
getStatus model target =
    case target of
        Fifteen ->
            model.status15

        Sixteen ->
            model.status16

        Seventeen ->
            model.status17

        Eighteen ->
            model.status18

        Nineteen ->
            model.status19

        Twenty ->
            model.status20

        Bullseye ->
            model.statusBullseye


setStatus : Target -> TargetStatus -> Model -> Model
setStatus target status model =
    case target of
        Fifteen ->
            { model | status15 = status }

        Sixteen ->
            { model | status16 = status }

        Seventeen ->
            { model | status17 = status }

        Eighteen ->
            { model | status18 = status }

        Nineteen ->
            { model | status19 = status }

        Twenty ->
            { model | status20 = status }

        Bullseye ->
            { model | statusBullseye = status }
