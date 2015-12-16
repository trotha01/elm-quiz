import StartApp.Simple as StartApp
import Quiz

-- UPDATE

main =
  StartApp.start { model = Quiz.init, view = Quiz.view, update = Quiz.update }

