import Html exposing (Html, div, button, text, input, span)
import Html.Attributes exposing (disabled)
import Html.Events exposing (onClick, targetValue, on)
import Debug

import Question
import Points 

import StartApp.Simple as StartApp

-- TODO
{- Add Point System
-}

-- MODEL

type alias Model =
    { questions: List (Int, Question.Model)
    , currentQuestion: ID
    , points:Points.Model}

type alias ID = Int

init : Model
init =
    { questions = questionsInit
    , currentQuestion = 0
    , points = Points.init
    }

questionsInit =
    [ (0, Question.init "What is the capital of France?" "Paris")
    , (1, Question.init "What is the capital of Nicaragua?" "Managua")
    , (2, Question.init "What is the capital of Australia?" "Canberra")
    ]

-- UPDATE

type Action =
    QuestionUpdate ID Question.Action
    | NextQuestion ID
    | PreviousQuestion ID

update : Action -> Model -> Model
update action model =
  case action of
    QuestionUpdate id action ->
        let updateQuestion (qid, q) =
            if qid == id then
               (id, Question.update action q)
            else
               (qid, q)
         in { model | questions = List.map updateQuestion model.questions }
    NextQuestion currentID ->
        let nextQuestion =
            min (currentID + 1) (List.length model.questions - 1)
         in { model | currentQuestion = nextQuestion}
    PreviousQuestion currentID ->
        let previousQueston =
            max 0 (currentID - 1)
         in { model | currentQuestion = previousQueston }

-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
    let maybeQuestion =
            List.filter (\(id, q) -> id == model.currentQuestion) model.questions 
        questionView =
            case List.head maybeQuestion of
                Just question ->
                    viewQuestion address question
                Nothing ->
                    span [] []
     in div []
        [
          Points.view model.points
        , questionView
        , prevButton address model
        , nextButton address model
        ]

prevButton : Signal.Address Action -> Model -> Html
prevButton address model = 
    let enabled =
        if model.currentQuestion == 0 then
            disabled True
        else
            disabled False
    in button
           [ onClick address (PreviousQuestion model.currentQuestion)
           , enabled
           ]
           [ text "Previous" ]

nextButton : Signal.Address Action -> Model -> Html
nextButton address model = 
    let enabled =
        if model.currentQuestion == (List.length model.questions) - 1 then
            disabled True
        else
            disabled False
    in button
           [ onClick address (NextQuestion model.currentQuestion)
           , enabled
           ]
           [ text "Next" ]

viewQuestion : Signal.Address Action -> (ID, Question.Model) -> Html
viewQuestion address (id, model) =
    Question.view (Signal.forwardTo address (QuestionUpdate id)) model

-- UPDATE

main =
  StartApp.start { model = init, view = view, update = update }

