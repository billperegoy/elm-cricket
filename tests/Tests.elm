module Tests exposing (..)

import Test exposing (..)
import UpdateTests
import StatusTests
import TargetTests
import MagnitudeTests


all : Test
all =
    describe "A Test Suite"
        (UpdateTests.all
            ++ TargetTests.all
            ++ StatusTests.all
            ++ MagnitudeTests.all
        )
