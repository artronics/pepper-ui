module Main exposing (Msg(..), main, update, view)

import Browser
import Component.Toolbar as Toolbar
import Css exposing (..)
import Css.Global exposing (children, typeSelector)
import FontAwesome.Icon as Icon exposing (Icon)
import FontAwesome.Solid as Icon
import Html
import Html.Attributes exposing (classList)
import Html.Events exposing (onClick)
import Html.Styled exposing (Html, a, div, fromUnstyled, li, map, p, text, toUnstyled, ul)
import Html.Styled.Attributes as Attr exposing (css)


main =
    Browser.sandbox { init = { panes = [], toolbar = Toolbar.new }, update = update, view = view >> toUnstyled }



{-
   main =
       Html.div []
           [ Icon.viewIcon Icon.arrowAltCircleRight
           , Html.text " Go!"
           ]
-}


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
    { panes : List Pane
    , toolbar : Toolbar.Model
    }


type Msg
    = FloatPane
    | Direction DockDirection
    | Reset
    | ToolbarMsg Toolbar.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        FloatPane ->
            { panes = [], toolbar = Toolbar.new }

        Direction _ ->
            { panes = [], toolbar = Toolbar.new }

        Reset ->
            { panes = [], toolbar = Toolbar.new }

        ToolbarMsg msg_ ->
            { panes = [], toolbar = Toolbar.update model.toolbar msg_ }



--css [ width (pct 100) ]


view : Model -> Html Msg
view model =
    div
        [ css
            [ backgroundColor (hex "ff34")
            , height (vh 100)
            , width (vw 100)
            , displayFlex
            , flexDirection column
            ]
        ]
        [ menuItem2 "context menu"
        , map ToolbarMsg <| Toolbar.view 2
        , div [ css [ flexGrow (num 1), displayFlex ] ]
            [ div [ css [ flexGrow (num 1), border3 (px 1) solid (hex "ff00e4") ] ] [ text "left" ]
            , div [ css [ flexGrow (num 1), border3 (px 1) solid (hex "ff00e4") ] ] [ text "main" ]
            , div [ css [ flexGrow (num 1), border3 (px 1) solid (hex "ff00e4") ] ] [ text "right" ]
            ]
        , div [ css [ flexGrow (num 1), border3 (px 1) solid (hex "ff00e4") ] ] [ text "terminal" ]
        , div [ css [ height (px 50), border3 (px 1) solid (hex "ff00e4") ] ] [ text "status bar" ]
        ]


icon iconName =
    fromUnstyled <| Icon.viewIcon iconName


f =
    typeSelector "div"
        [ children
            [ typeSelector "p"
                [ fontSize (px 14)
                ]
            ]
        ]


menuItem : String -> Html Msg
menuItem name =
    div []
        [ p [ css [ display inlineBlock ] ] [ icon Icon.star, text " Context menu" ]
        , p [ css [ display inlineBlock ] ] [ text "foo" ]
        ]


menuItem2 : String -> Html Msg
menuItem2 name =
    div
        [ css
            [ position absolute
            , backgroundColor (hex "64ff73")
            , top (px 200)
            ]
        ]
        [ ul
            [ css
                [ padding (px 5)
                , margin (px 0)
                ]
            ]
            [ menuItem name, menuItem name ]
        ]
