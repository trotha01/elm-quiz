import StartApp.Simple as StartApp
import Quiz

main =
  StartApp.start { model = Quiz.init, view = Quiz.view, update = Quiz.update }

