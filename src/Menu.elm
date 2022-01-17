module Menu exposing (Menu, Model, consoleMenu, repositionMenu, view)

import Html exposing (Attribute, Html, div, li, text, ul)
import Html.Attributes exposing (class, id, style)
import Html.Events exposing (onClick)
import List
import Models exposing (ActionData, Pos, Rect)
import Utils


type alias Model =
    { menu : Menu
    , pos : Pos
    }


type alias MenuItemData =
    { name : String
    , action : ActionData

    --, icon : Maybe String
    --, keymap : Maybe String
    }


type Item
    = Node MenuItemData
    | ParentNode MenuItemData (List Item)


type alias Menu =
    List Item


viewMenu action menu =
    menu
        |> List.map (viewMenuItem action)
        |> ul []


viewMenuItem action item =
    case item of
        Node data ->
            li [ onClick <| action data.action ] [ text data.name ]

        ParentNode data _ ->
            li [] [ text (data.name ++ " >") ]


viewSubmenuItem : MenuItemData -> Html msg
viewSubmenuItem data =
    text "sub"


view : (ActionData -> msg) -> Model -> Html msg
view action { pos, menu } =
    div (containerAttr pos) [ viewMenu action menu ]


repositionMenu : Rect -> Rect -> Model -> Model
repositionMenu windowSize menuSize model =
    model


containerAttr : Pos -> List (Attribute msg)
containerAttr pos =
    [ class "menu-container", id "menu", style "top" (Utils.px pos.y), style "left" (Utils.px pos.x) ]


consoleMenu : Menu
consoleMenu =
    [ Node { name = "first", action = { name = "firstAction" } }
    , ParentNode { name = "Second", action = { name = "ParentAction" } } [ Node { name = "sub menu", action = { name = "subAction" } } ]
    ]
