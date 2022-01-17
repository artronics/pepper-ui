module Utils exposing (..)

import Browser.Dom exposing (Viewport)
import Html exposing (Html, text)
import Html.Events
import Json.Decode as Decode
import Models exposing (Pos, Rect)


px : Int -> String
px a =
    String.fromInt a ++ "px"


htmlNone : Html msg
htmlNone =
    text ""


rectOfViewport : Viewport -> Rect
rectOfViewport vp =
    { w = vp.viewport.width, h = vp.viewport.height }


onClickNoBubble : msg -> Html.Attribute msg
onClickNoBubble message =
    Html.Events.custom "click" (Decode.succeed { message = message, stopPropagation = True, preventDefault = True })


pageXYDecoder : Decode.Decoder Pos
pageXYDecoder =
    Decode.map2 Pos (Decode.field "pageX" Decode.int) (Decode.field "pageY" Decode.int)
