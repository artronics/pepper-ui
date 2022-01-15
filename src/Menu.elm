module Menu exposing (..)

import Html exposing (Html, div, text)
import Html.Attributes exposing (class)


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


view : Menu -> Html msg
view menu =
    overlay <| div [] [ text "yeeyey" ]


overlay children =
    div
        [ class "overlay" ]
        [ children ]


consoleMenu : Menu
consoleMenu =
    Menu [ Item { name = "menu" } ]
