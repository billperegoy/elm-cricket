module TargetTests exposing (all)

import Test exposing (..)
import Expect
import String
import Model exposing (..)
import Target


all : List Test
all =
    [ test "Target.value is correct for Fifteen" <|
        \() ->
            Expect.equal (Target.value Fifteen) 15
      --
      --
    , test "Target.value is correct for Sixteen" <|
        \() ->
            Expect.equal (Target.value Sixteen) 16
      --
      --
    , test "Target.value is correct for Seventeen" <|
        \() ->
            Expect.equal (Target.value Seventeen) 17
      --
      --
    , test "Target.value is correct for Eighteen" <|
        \() ->
            Expect.equal (Target.value Eighteen) 18
      --
      --
    , test "Target.value is correct for Nineteen" <|
        \() ->
            Expect.equal (Target.value Nineteen) 19
      --
      --
    , test "Target.value is correct for Twenty" <|
        \() ->
            Expect.equal (Target.value Twenty) 20
      --
      --
    , test "Target.value is correct for Bullseye" <|
        \() ->
            Expect.equal (Target.value Bullseye) 25
    ]
