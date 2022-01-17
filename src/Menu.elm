module Menu exposing (Menu, Model, consoleMenu, positionMenu, view)

import Html exposing (Attribute, Html, div, li, text, ul)
import Html.Attributes exposing (class, classList, id, style)
import Html.Events exposing (onClick, onMouseUp)
import List
import Models exposing (ActionData, Pos, Rect)
import Utils


type alias Model =
    { menu : Menu
    , pos : Pos
    , positioned : Bool
    }


type Anchor
    = Click Pos
    | Actual Pos


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
            li [ onMouseUp <| action data.action ] [ text data.name ]

        ParentNode data _ ->
            li [] [ text (data.name ++ " sdfd sdfdf ") ]


viewSubmenuItem : MenuItemData -> Html msg
viewSubmenuItem data =
    text "sub"


view : (ActionData -> msg) -> Model -> Html msg
view action { pos, menu, positioned } =
    let
        containerAttr =
            [ id "active-menu"
            , classList [ ( "hidden", not positioned ) ]
            , class "menu-container"
            , style "top" (Utils.px pos.y)
            , style "left" (Utils.px pos.x)
            ]
    in
    div containerAttr [ viewMenu action menu ]


positionMenu : Rect -> Rect -> Model -> Model
positionMenu windowSize menuSize model =
    let
        { x, y } =
            model.pos

        { w, h } =
            menuSize

        -- 2px for border. (eyeball)
        border =
            2

        newX =
            if toFloat x + w + border > windowSize.w then
                ceiling <| windowSize.w - w - border

            else
                x

        newY =
            if toFloat y + h + border > windowSize.h then
                ceiling <| windowSize.h - h - border

            else
                y
    in
    { model | pos = { x = newX, y = newY }, positioned = True }


consoleMenu : Menu
consoleMenu =
    [ Node { name = "first", action = { name = "firstAction" } }
    , ParentNode { name = "Second", action = { name = "ParentAction" } } [ Node { name = "sub menu", action = { name = "subAction" } } ]
    ]
