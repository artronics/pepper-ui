module Utils exposing (..)

import Html exposing (Html, text)


px : Int -> String
px a =
    String.fromInt a ++ "px"


htmlNone : Html msg
htmlNone =
    text ""
