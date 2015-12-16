module Question (Model, init, Action, update, view) where

import Html exposing (Html, div, button, text, input, span)
import Html.Events exposing (onClick, targetValue, on)

-- Model

type alias Model = 
    { question: String
    , isCorrect: String -> Bool
    , input: String
    , state: State }

type State =
    Waiting | Answered

init : String -> String -> Model
init question answer =
    { state=Waiting
    , question=question
    , isCorrect=\s -> s == answer
    , input=""
    }

-- Update

type Action =
    CheckAnswer
    | UserInput String
    | AddPoints Int

update : Action -> Model -> Model
update action model =
  case action of
    CheckAnswer ->
        {model|state=Answered}
    UserInput s ->
        {model|input=s}
    AddPoints _ ->
        model

-- View

question : Model -> Signal.Address Action -> Html
question model address =
    div []
    [ text model.question
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
            if model.isCorrect model.input then
                div []
                [ text "Excellent!!!" ]
            else
                div []
                [ text "Please try again" ]

view : Signal.Address Action -> Model -> Html
view address model =
    div []
    [ question model address
    , answer model
    ]
