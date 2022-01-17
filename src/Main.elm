module Main exposing (Msg(..), main, update, view)

import Browser
import Browser.Dom exposing (Error, Viewport, getViewportOf)
import Browser.Events as Events
import Component.Toolbar as Toolbar
import Html exposing (Html, div, map, text)
import Html.Attributes exposing (class, id)
import Html.Events exposing (on, onClick, onMouseDown, onMouseUp)
import Json.Decode as Decode
import Menu exposing (consoleMenu, positionMenu)
import Models exposing (ActionData, Pos, Rect)
import Task exposing (Task)
import Utils exposing (htmlNone, pageXYDecoder, rectOfViewport)


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
    | Action ActionData
    | RenderMenu Menu.Menu Pos
    | HideMenu
    | PositionMenu (Result Error Viewport)
    | ToolbarMsg Toolbar.Msg


getMenuSize : Cmd Msg
getMenuSize =
    getViewportOf "active-menu"
        |> Task.attempt PositionMenu


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ({ contextMenu } as model) =
    case msg of
        WindowResized rect ->
            ( { model | windowSize = rect }, Cmd.none )

        RenderMenu menu pos ->
            ( { model | contextMenu = Just { menu = menu, pos = pos, positioned = False } }, getMenuSize )

        PositionMenu (Result.Ok viewport) ->
            ( { model
                | contextMenu =
                    contextMenu
                        |> Maybe.map (positionMenu model.windowSize <| rectOfViewport viewport)
              }
            , Cmd.none
            )

        PositionMenu (Result.Err _) ->
            ( model, Cmd.none )

        Action name ->
            -- TODO: Add different Actions so we close menu only if relevant
            ( { model | contextMenu = Nothing }, Cmd.none )

        HideMenu ->
            ( { model | contextMenu = Nothing }, Cmd.none )

        ToolbarMsg msg_ ->
            ( { model | toolbar = Toolbar.update model.toolbar msg_ }, Cmd.none )


viewContextMenu : Maybe Menu.Model -> Html Msg
viewContextMenu menuModel =
    case menuModel of
        Just menu ->
            Menu.view (\actionData -> Action actionData) menu

        Nothing ->
            htmlNone


view : Model -> Html Msg
view model =
    div
        [ id "root" ]
        [ div [ onClick HideMenu ] [ viewContextMenu model.contextMenu ]
        , div [ id "container", onMouseDown HideMenu ]
            [ map ToolbarMsg <| Toolbar.view 2
            , div [ class "pane-container" ]
                [ div [] [ text "left" ]
                , div [] [ text "main" ]
                , div [ on "contextmenu" (Decode.map (RenderMenu consoleMenu) pageXYDecoder) ] [ text "right" ]
                ]
            , div [] [ text "terminal" ]
            , div [ on "contextmenu" (Decode.map (RenderMenu consoleMenu) pageXYDecoder) ] [ text "status bar" ]
            ]
        ]


subscriptions : Model -> Sub Msg
subscriptions _ =
    Events.onResize (\w h -> WindowResized { w = toFloat w, h = toFloat h })
