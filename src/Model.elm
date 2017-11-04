module Model exposing (..)


type Target
    = Twenty
    | Nineteen
    | Eighteen
    | Seventeen
    | Sixteen
    | Fifteen
    | Bullseye


type PlayerTargetStatus
    = Unopened Int
    | Opened


type TargetStatus
    = Active PlayerTargetStatus PlayerTargetStatus
    | Closed


type PlayerId
    = Player1
    | Player2


type alias Score =
    { player1 : Int
    , player2 : Int
    }


type alias Model =
    { status15 : TargetStatus
    , status16 : TargetStatus
    , status17 : TargetStatus
    , status18 : TargetStatus
    , status19 : TargetStatus
    , status20 : TargetStatus
    , statusBullseye : TargetStatus
    , currentTurn : PlayerId
    , currentDart : Int
    , score : Score
    }


type Magnitude
    = Single
    | Double
    | Triple


type BullseyeMagnitude
    = Inner
    | Outer


type Msg
    = Hit Target Magnitude
    | Miss
