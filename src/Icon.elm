module Icon exposing (Icon(..), view)

import FontAwesome.Icon as FAIcon
import FontAwesome.Solid as Solid
import Html exposing (Html, i, span)


type Icon
    = Star


view : Icon -> Html msg
view icon =
    i [] [ FAIcon.viewIcon (mapIcon icon) ]


mapIcon : Icon -> FAIcon.Icon
mapIcon name =
    case name of
        Star ->
            Solid.star
