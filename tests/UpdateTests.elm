module UpdateTests exposing (all)

import Test exposing (..)
import Expect
import String
import Model exposing (..)
import Update


all : List Test
all =
    let
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
    in
        [ test "Miss message type increments the currentDart" <|
            \() ->
                let
                    stimModel =
                        model

                    newModel =
                        Update.update Model.Miss stimModel
                in
                    Expect.equal newModel.currentDart 2
          --
          --
        , test "Hit message type increments the currentDart" <|
            \() ->
                let
                    stimModel =
                        model

                    newModel =
                        Update.update (Model.Hit Fifteen Single) stimModel
                in
                    Expect.equal newModel.currentDart 2
          --
          --
        , test "currentDart cannot increment above 3" <|
            \() ->
                let
                    stimModel =
                        { model | currentDart = 3 }

                    newModel =
                        Update.update (Model.Hit Fifteen Single) stimModel
                in
                    Expect.equal newModel.currentDart 1
          --
          --
        , test "Player doesn't change before  dart 3" <|
            \() ->
                let
                    stimModel =
                        model

                    newModel =
                        Update.update Model.Miss stimModel
                in
                    Expect.equal newModel.currentTurn Player1
          --
          --
        , test "Player changes after dart 3" <|
            \() ->
                let
                    stimModel =
                        { model | currentDart = 3 }

                    newModel =
                        Update.update Model.Miss stimModel
                in
                    Expect.equal newModel.currentTurn Player2
          --
          --
        , test "updateTurn before dart 3 - proper player" <|
            \() ->
                let
                    stimModel =
                        model

                    newModel =
                        Update.updateTurn stimModel
                in
                    Expect.equal newModel.currentTurn Player1
          --
          --
        , test "updateTurn dart 3 - proper player" <|
            \() ->
                let
                    stimModel =
                        { model | currentDart = 3 }

                    newModel =
                        Update.updateTurn stimModel
                in
                    Expect.equal newModel.currentTurn Player2
          --
          --
        , test "updateDart before dart 3 - proper dart" <|
            \() ->
                let
                    stimModel =
                        model

                    newModel =
                        Update.updateDart stimModel
                in
                    Expect.equal newModel.currentDart 2
          --
          --
        , test "updateDart dart 3 - proper dart" <|
            \() ->
                let
                    stimModel =
                        { model | currentDart = 3 }

                    newModel =
                        Update.updateDart stimModel
                in
                    Expect.equal newModel.currentDart 1
          --
          --
        , test "single hits properly accumulate on unopened targets" <|
            \() ->
                let
                    stimModel =
                        model

                    newModel =
                        Update.update (Model.Hit Fifteen Single) stimModel

                    newStatus =
                        newModel.status15
                in
                    Expect.equal newStatus
                        (Active (Unopened 1) (Unopened 0))
          --
          --
        , test "double hits properly accumulate on unopened targets" <|
            \() ->
                let
                    stimModel =
                        model

                    newModel =
                        Update.update (Model.Hit Fifteen Double) stimModel

                    newStatus =
                        newModel.status15
                in
                    Expect.equal newStatus
                        (Active (Unopened 2) (Unopened 0))
          --
          --
        , test "triple hits properly accumulate on unopened targets" <|
            \() ->
                let
                    stimModel =
                        model

                    newModel =
                        Update.update (Model.Hit Fifteen Triple) stimModel

                    newStatus =
                        newModel.status15
                in
                    Expect.equal newStatus
                        (Active Opened (Unopened 0))
          --
          --
        , test "player 1 - opened targets remain open after susequent hists" <|
            \() ->
                let
                    stimModel =
                        { model | status15 = Active Opened (Unopened 0) }

                    newModel =
                        Update.update (Model.Hit Fifteen Single) stimModel

                    newStatus =
                        newModel.status15
                in
                    Expect.equal newStatus (Active Opened (Unopened 0))
          --
          --
        , test "player 2 - opened targets remain open after susequent hists" <|
            \() ->
                let
                    stimModel =
                        { model
                            | currentTurn = Player2
                            , status15 = Active (Unopened 0) Opened
                        }

                    newModel =
                        Update.update (Model.Hit Fifteen Single) stimModel

                    newStatus =
                        newModel.status15
                in
                    Expect.equal newStatus (Active (Unopened 0) Opened)
          --
          --
        , test "single hits properly accumulate on unopened targets - not 15" <|
            \() ->
                let
                    stimModel =
                        model

                    newModel =
                        Update.update (Model.Hit Nineteen Single) stimModel

                    newStatus =
                        newModel.status19
                in
                    Expect.equal newStatus
                        (Active (Unopened 1) (Unopened 0))
          --
          --
        , test "single hits properly accumulate on unopened targets - player 2, not 15" <|
            \() ->
                let
                    stimModel =
                        { model | currentTurn = Player2 }

                    newModel =
                        Update.update (Model.Hit Twenty Single) stimModel

                    newStatus =
                        newModel.status20
                in
                    Expect.equal newStatus
                        (Active (Unopened 0) (Unopened 1))
          --
          --
        , test "player2 getting 3 hits on target already opened by player1 closes the target" <|
            \() ->
                let
                    stimModel =
                        { model
                            | status15 = (Active Opened (Unopened 0))
                            , currentTurn = Player2
                        }

                    newModel =
                        Update.update (Model.Hit Fifteen Triple) stimModel

                    newStatus =
                        newModel.status15
                in
                    Expect.equal newStatus Closed
          --
          --
        , test "player1 getting 3 hits on target already opened by player2 closes the target" <|
            \() ->
                let
                    stimModel =
                        { model
                            | status15 = (Active (Unopened 0) Opened)
                            , currentTurn = Player1
                        }

                    newModel =
                        Update.update (Model.Hit Fifteen Triple) stimModel

                    newStatus =
                        newModel.status15
                in
                    Expect.equal newStatus Closed
          --
          --
        , test "hits that do not open a target do not change score" <|
            \() ->
                let
                    stimModel =
                        model

                    newModel =
                        Update.update (Model.Hit Fifteen Triple) stimModel
                in
                    Expect.equal newModel.score
                        { player1 = 0
                        , player2 = 0
                        }
          --
          --
        , test "hits on an open target increase store by all points" <|
            \() ->
                let
                    stimModel =
                        { model | status15 = Active Opened (Unopened 0) }

                    newModel =
                        Update.update (Model.Hit Fifteen Triple) stimModel
                in
                    Expect.equal newModel.score
                        { player1 = 45
                        , player2 = 0
                        }
        , test "hits that open a target increase store by excess points" <|
            \() ->
                let
                    stimModel =
                        { model | status15 = Active (Unopened 2) (Unopened 0) }

                    newModel =
                        Update.update (Model.Hit Fifteen Triple) stimModel
                in
                    Expect.equal newModel.score
                        { player1 = 30
                        , player2 = 0
                        }
          --
          --
        , test "hits target do not score if other player has it open" <|
            \() ->
                let
                    stimModel =
                        { model | status15 = Active (Unopened 2) Opened }

                    newModel =
                        Update.update (Model.Hit Fifteen Triple) stimModel
                in
                    Expect.equal newModel.score
                        { player1 = 0
                        , player2 = 0
                        }
          {-
               --
               --
             , test "opening a target that was open for the other player closes this\n        target for current player" <|
                 \() ->
                     let
                         initModel =
                             { player1 = initPlayer1
                             , player2 = initPlayer2
                             , currentTurn = Player1
                             , currentDart = 0
                             }

                         newModel =
                             Update.update (Model.Hit Sixteen Triple) initModel
                     in
                         Expect.equal newModel.player1.status16 Closed
               --
               --
             , test "opening a target that was open for the other player closes this\n        target for other player" <|
                 \() ->
                     let
                         initModel =
                             { player1 = initPlayer1
                             , player2 = initPlayer2
                             , currentTurn = Player1
                             , currentDart = 0
                             }

                         newModel =
                             Update.update (Model.Hit Sixteen Triple) initModel
                     in
                         Expect.equal newModel.player2.status16 Closed
          -}
        ]
