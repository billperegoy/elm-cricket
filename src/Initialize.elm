module Initialize exposing (model)

import Model exposing (..)


initScore : Score
initScore =
    { player1 = 0
    , player2 = 0
    }


model : Model
model =
    { status15 = Active (Unopened 0) (Unopened 0)
    , status16 = Active (Unopened 0) (Unopened 0)
    , status17 = Active (Unopened 0) (Unopened 0)
    , status18 = Active (Unopened 0) (Unopened 0)
    , status19 = Active (Unopened 0) (Unopened 0)
    , status20 = Active (Unopened 0) (Unopened 0)
    , statusBullseye = Active (Unopened 0) (Unopened 0)
    , currentTurn = Player1
    , currentDart = 1
    , score = initScore
    }
