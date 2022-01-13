module Component.Toolbar exposing (..)

import Css exposing (..)
import Html.Styled exposing (Html, a, div, text, toUnstyled)
import Html.Styled.Attributes exposing (css)


type alias Model =
    Int


type Msg
    = Foo


new =
    2


update : Model -> Msg -> Model
update model msg =
    4


view : Model -> Html Msg
view model =
    div [ css [ height (px 50), border3 (px 1) solid (hex "ff00e4") ] ] [ text "toolbar" ]
