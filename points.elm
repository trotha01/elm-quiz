module Points (Model, init, Action, update, view) where

import Html exposing (Html, div, button, text, input, span)

-- MODEL

type alias Model = Int

init : Model
init = 0

-- UPDATE

type Action =
    UpdatePoints Int

update : Action -> Model -> Model
update action model =
    case action of
        UpdatePoints x -> model + x

-- VIEW

view : Model -> Html
view model =
    div [] [ text (toString model) ]
