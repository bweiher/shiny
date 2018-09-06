fluidPage(
  shiny::actionButton("action", "run"),
  DT::DTOutput('x1'),
  DT:::DTOutput("text")
)
