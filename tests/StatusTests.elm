module StatusTests exposing (all)

import Test exposing (..)
import Expect
import String
import Model exposing (..)
import StatusUtils


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
        [ test "getStatus - 15" <|
            \() ->
                let
                    stimModel =
                        { model | status15 = Active Opened (Unopened 2) }

                    newStatus =
                        StatusUtils.getStatus stimModel Fifteen
                in
                    Expect.equal newStatus (Active Opened (Unopened 2))
          --
          --
        , test "getStatus - 16" <|
            \() ->
                let
                    stimModel =
                        { model | status16 = Active Opened (Unopened 2) }

                    newStatus =
                        StatusUtils.getStatus stimModel Sixteen
                in
                    Expect.equal newStatus (Active Opened (Unopened 2))
          --
          --
        , test "getStatus - 17" <|
            \() ->
                let
                    stimModel =
                        { model | status17 = Active Opened (Unopened 2) }

                    newStatus =
                        StatusUtils.getStatus stimModel Seventeen
                in
                    Expect.equal newStatus (Active Opened (Unopened 2))
          --
          --
        , test "getStatus - 18" <|
            \() ->
                let
                    stimModel =
                        { model | status18 = Active Opened (Unopened 2) }

                    newStatus =
                        StatusUtils.getStatus stimModel Eighteen
                in
                    Expect.equal newStatus (Active Opened (Unopened 2))
          --
          --
        , test "getStatus - 19" <|
            \() ->
                let
                    stimModel =
                        { model | status19 = Active Opened (Unopened 2) }

                    newStatus =
                        StatusUtils.getStatus stimModel Nineteen
                in
                    Expect.equal newStatus (Active Opened (Unopened 2))
          --
          --
        , test "getStatus - 20" <|
            \() ->
                let
                    stimModel =
                        { model | status20 = Active Opened (Unopened 2) }

                    newStatus =
                        StatusUtils.getStatus stimModel Twenty
                in
                    Expect.equal newStatus (Active Opened (Unopened 2))
          --
          --
        , test "getStatus - Bullseye" <|
            \() ->
                let
                    stimModel =
                        { model | statusBullseye = Active Opened (Unopened 2) }

                    newStatus =
                        StatusUtils.getStatus stimModel Bullseye
                in
                    Expect.equal newStatus (Active Opened (Unopened 2))
          --
          --
        , test "setStatus - Fifteen" <|
            \() ->
                let
                    stimModel =
                        model

                    newModel =
                        StatusUtils.setStatus Fifteen (Active Opened (Unopened 2)) stimModel
                in
                    Expect.equal newModel.status15 (Active Opened (Unopened 2))
          --
          --
        , test "setStatus - Sixteen" <|
            \() ->
                let
                    stimModel =
                        model

                    newModel =
                        StatusUtils.setStatus Sixteen (Active Opened (Unopened 2)) stimModel
                in
                    Expect.equal newModel.status16 (Active Opened (Unopened 2))
          --
          --
        , test "setStatus - Seventeen" <|
            \() ->
                let
                    stimModel =
                        model

                    newModel =
                        StatusUtils.setStatus Seventeen (Active Opened (Unopened 2)) stimModel
                in
                    Expect.equal newModel.status17 (Active Opened (Unopened 2))
          --
          --
        , test "setStatus - Eighteen" <|
            \() ->
                let
                    stimModel =
                        model

                    newModel =
                        StatusUtils.setStatus Eighteen (Active Opened (Unopened 2)) stimModel
                in
                    Expect.equal newModel.status18 (Active Opened (Unopened 2))
          --
          --
        , test "setStatus - Nineteen" <|
            \() ->
                let
                    stimModel =
                        model

                    newModel =
                        StatusUtils.setStatus Nineteen (Active Opened (Unopened 2)) stimModel
                in
                    Expect.equal newModel.status19 (Active Opened (Unopened 2))
          --
          --
        , test "setStatus - Twenty" <|
            \() ->
                let
                    stimModel =
                        model

                    newModel =
                        StatusUtils.setStatus Twenty (Active Opened (Unopened 2)) stimModel
                in
                    Expect.equal newModel.status20 (Active Opened (Unopened 2))
          --
          --
        , test "setStatus - Bullseye" <|
            \() ->
                let
                    stimModel =
                        model

                    newModel =
                        StatusUtils.setStatus Bullseye (Active Opened (Unopened 2)) stimModel
                in
                    Expect.equal newModel.statusBullseye (Active Opened (Unopened 2))
        ]
