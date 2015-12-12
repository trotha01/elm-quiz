import Html exposing (Html, div, button, text, input, span)
import Html.Events exposing (onClick, targetValue, on)
import Debug

import Question

import StartApp.Simple as StartApp

-- TODO
{- Add Point System
-}

-- MODEL

type alias Model =
    { question:Question.Model
    , points:Int }

model : Model
model =
    { question=Question.init }

-- UPDATE

type Action = UpdateQuestion Question.Action

update : Action -> Model -> Model
update action model =
  case action of
    UpdateQuestion a ->
        { model | question=Question.update a model.question }

-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
    div []
    [ Question.view
        (Signal.forwardTo address (UpdateQuestion))
        model.question
    ]

-- UPDATE

main =
  StartApp.start { model = model, view = view, update = update }
