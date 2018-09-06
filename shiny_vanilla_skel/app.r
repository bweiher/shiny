library(shiny)
library(shinythemes)

# interface --------
ui <- navbarPage(
  title = "Dashboard Title", theme = shinytheme("yeti"),
  tabPanel(
    "Tab 1",
    tags$h1("Ordered List"),
    tags$ol(
      tags$li("First point"),
      tags$li("Second point")
    ),
    tags$hr(),
    tags$h1("Sub Section")
  ),
  tabPanel(
    "Tab 2",
    tags$h1("Title"),
    tags$br(),
    sidebarPanel(
       downloadButton("download")
    )
  )
)



# server ------------
server <- function(input, output, session) {
  
}


shinyApp(ui = ui, server = server)
