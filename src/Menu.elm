module Menu exposing (..)

import Debug exposing (toString)
import Html exposing (Attribute, Html, div, text)
import Html.Attributes exposing (class, style)
import Models exposing (Pos)
import Utils


type alias Model =
    { menu : Menu
    , pos : Pos
    }


type alias MenuItemData =
    { name : String

    --, icon : Maybe String
    --, keymap: Maybe String
    }


type MenuItem
    = Item MenuItemData
    | SubMenu (List MenuItemData)


type Menu
    = Menu (List MenuItem)


view : Model -> Html msg
view model =
    overlay <| div (containerAttr model.pos) [ text "yeeyey" ]


containerAttr : Pos -> List (Attribute msg)
containerAttr pos =
    [ class "menu-container", style "top" (Utils.px pos.y), style "left" (Utils.px pos.x) ]


overlay children =
    div [ class "overlay" ] [ children ]


consoleMenu : Menu
consoleMenu =
    Menu [ Item { name = "menu" } ]
