module Utils exposing (..)

import Browser.Dom exposing (Viewport)
import Html exposing (Html, text)
import Models exposing (Rect)


px : Int -> String
px a =
    String.fromInt a ++ "px"


htmlNone : Html msg
htmlNone =
    text ""


rectOfViewport : Viewport -> Rect
rectOfViewport vp =
    { width = vp.viewport.width, height = vp.viewport.height }
