module MagnitudeTests exposing (all)

import Test exposing (..)
import Expect
import String
import Model exposing (..)
import Magnitude


all : List Test
all =
    [ test "Magnitude.value is correct for Single" <|
        \() ->
            Expect.equal (Magnitude.value Single) 1
      --
      --
    , test "Magnitude.value is correct for Double" <|
        \() ->
            Expect.equal (Magnitude.value Double) 2
      --
      --
    , test "Magnitude.value is correct for Triple" <|
        \() ->
            Expect.equal (Magnitude.value Triple) 3
    ]
