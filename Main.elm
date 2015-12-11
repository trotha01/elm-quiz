import Html exposing (Html, div, button, text, input, span)
import Html.Events exposing (onClick, targetValue, on)
import Debug

import Question

import StartApp.Simple as StartApp

-- TODO
{- Add Point System
-}

main =
  StartApp.start { model = model, view = view, update = update }

-- MODEL

type alias Model =
    {question:Question.Model}

model : Model
model =
    { question=Question.init }

-- UPDATE

type Action = UpdateQuestion Question.Action

update : Action -> Model -> Model
update action model =
  case action of
    UpdateQuestion a ->
        {model|question=Question.update a model.question}

-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
    div []
    [ Question.view
        (Signal.forwardTo address (UpdateQuestion))
        model.question
    ]

{-
question : Model -> Signal.Address Action -> Html
question model address =
    div []
    [ div [] [ text model.question.question ]
    , input
         [ on "input" (targetValue) (Signal.message address << UserInput ) ]
         []
    , button [ onClick address CheckAnswer ] [ text "Submit" ]
    ]

answer : Model -> Html
answer model = 
    case model.state of
        Waiting ->
            span [] []
        Answered ->
            if model.question.isCorrect model.input then
                div []
                [ text "Excellent!!!" ]
            else
                div []
                [ text "Please try again" ]


-}
