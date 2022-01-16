module Main exposing (Msg(..), main, update, view)

import Browser
import Browser.Dom exposing (getViewport)
import Browser.Events as Events
import Component.Toolbar as Toolbar
import Html exposing (Html, a, div, li, map, p, text, ul)
import Html.Attributes exposing (class, classList, id)
import Html.Events exposing (on, onClick, onMouseDown)
import Json.Decode as Decode
import Menu exposing (consoleMenu)
import Models exposing (Pos, Rect)
import Utils exposing (htmlNone)


main =
    Browser.element { init = init, update = update, view = view, subscriptions = subscriptions }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { windowSize = flags.windowSize
      , toolbar = Toolbar.new
      , contextMenu = Nothing
      }
    , Cmd.none
    )


type alias Flags =
    { windowSize : Rect }


type alias Model =
    { windowSize : Rect
    , contextMenu : Maybe Menu.Model
    , toolbar : Toolbar.Model
    }


type Msg
    = WindowResized Rect
    | ShowContextMenu Menu.Menu Pos
    | HideMenu
    | ToolbarMsg Toolbar.Msg


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        WindowResized rect ->
            ( { model | windowSize = rect }, Cmd.none )

        ShowContextMenu menu pos ->
            ( { model | contextMenu = Just { menu = menu, pos = pos, windowSize = model.windowSize } }, Cmd.none )

        HideMenu ->
            ( { model | contextMenu = Nothing }, Cmd.none )

        ToolbarMsg msg_ ->
            ( { model | toolbar = Toolbar.update model.toolbar msg_ }, Cmd.none )


posDecoder : Decode.Decoder Pos
posDecoder =
    Decode.map2 Pos (Decode.field "pageX" Decode.int) (Decode.field "pageY" Decode.int)


viewContextMenu : Maybe Menu.Model -> Html Msg
viewContextMenu menuModel =
    case menuModel of
        Just menu ->
            Menu.view menu

        Nothing ->
            htmlNone


view : Model -> Html Msg
view model =
    div
        [ id "container", onMouseDown HideMenu ]
        [ viewContextMenu model.contextMenu
        , map ToolbarMsg <| Toolbar.view 2
        , div [ class "pane-container" ]
            [ div [] [ text "left" ]
            , div [] [ text "main" ]
            , div [ on "contextmenu" (Decode.map (ShowContextMenu consoleMenu) posDecoder) ] [ text "right" ]
            ]
        , div [] [ text "terminal" ]
        , div [] [ text "status bar" ]
        ]


subscriptions : Model -> Sub Msg
subscriptions _ =
    Events.onResize (\w h -> WindowResized { width = w, height = h })
