module Menu exposing (Menu, Model, consoleMenu, repositionMenu, view)

import Debug exposing (toString)
import Html exposing (Attribute, Html, div, li, text, ul)
import Html.Attributes exposing (class, id, style)
import List exposing (map)
import Models exposing (Pos, Rect)
import Utils


type alias Model =
    { menu : Menu
    , pos : Pos
    }


type alias MenuItemData =
    { name : String

    --, icon : Maybe String
    --, keymap : Maybe String
    }


type MenuItem
    = Item MenuItemData
    | SubMenu MenuItemData (List MenuItemData)


type alias Menu =
    List MenuItem


viewMenu : Menu -> Html msg
viewMenu menu =
    menu
        |> List.map viewMenuItem
        |> ul []


viewMenuItem : MenuItem -> Html msg
viewMenuItem item =
    case item of
        Item data ->
            li [] [ text data.name ]

        SubMenu data _ ->
            li [] [ text (data.name ++ " >") ]


viewSubmenuItem : MenuItemData -> Html msg
viewSubmenuItem data =
    text "sub"


view : Model -> Html msg
view { pos, menu } =
    div (containerAttr pos) [ viewMenu menu ]


repositionMenu : Rect -> Rect -> Model -> Model
repositionMenu windowSize menuSize model =
    model


containerAttr : Pos -> List (Attribute msg)
containerAttr pos =
    [ class "menu-container", id "menu", style "top" (Utils.px pos.y), style "left" (Utils.px pos.x) ]


consoleMenu : Menu
consoleMenu =
    [ Item { name = "first" }
    , SubMenu { name = "Second" } [ { name = "sub menu" } ]
    ]
