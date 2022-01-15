module Component.Toolbar exposing (..)

import Html exposing (Html, div, text)
import Html.Attributes exposing (class)


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
    div [ class "toolbar" ] [ text "toolbar" ]
