module Main exposing (Msg(..), main, update, view)

import Browser
import Component.Toolbar as Toolbar
import Html exposing (Html, a, div, li, map, p, text, ul)
import Html.Attributes exposing (class, classList, id)
import Html.Events exposing (onClick)
import Icon
import Menu exposing (consoleMenu)


main =
    Browser.element { init = init, update = update, view = view, subscriptions = subscriptions }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { toolbar = Toolbar.new, contextMenu = Nothing }, Cmd.none )


type DockType
    = FloatWindow


type DockDirection
    = Down
    | Up
    | Right
    | Left


type alias Pane =
    { dockType : DockType
    , direction : DockDirection
    }


type alias Model =
    { contextMenu : Maybe Menu.Menu
    , toolbar : Toolbar.Model
    }


type Msg
    = ShowContextMenu Menu.Menu ( Int, Int )
    | ToolbarMsg Toolbar.Msg


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        ShowContextMenu menu ( x, y ) ->
            Debug.log "here"
                ( { model | contextMenu = Just menu }, Cmd.none )

        ToolbarMsg msg_ ->
            ( { model | toolbar = Toolbar.update model.toolbar msg_ }, Cmd.none )



--css [ width (pct 100) ]


view : Model -> Html Msg
view model =
    div
        [ id "container" ]
        [ case model.contextMenu of
            Just menu ->
                Menu.view menu

            Nothing ->
                div [] []
        , menuItem2 "context menu"
        , map ToolbarMsg <| Toolbar.view 2

        --, Menu.view consoleMenu
        , div [ class "pane-container" ]
            [ div [] [ text "left" ]
            , div [] [ text "main" ]
            , div [] [ text "right" ]
            ]
        , div [ onClick <| ShowContextMenu consoleMenu ( 1, 2 ) ] [ text "terminal" ]
        , div [] [ text "status bar" ]
        ]


menuItem : String -> Html Msg
menuItem name =
    li []
        [ p [] [ Icon.view Icon.Star, text " Context menu" ]
        , p [] [ text "foo" ]
        ]


menuItem2 : String -> Html Msg
menuItem2 name =
    div [ class "menu-container" ]
        [ ul []
            [ menuItem name, menuItem name ]
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
