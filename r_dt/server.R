library(shiny)
library(DT)

server <- function(input, output, session) {
  x = iris
  y <- reactive({
    input$x1_cell_edit
    x
  })
  
  x$Date = Sys.time() + seq_len(nrow(x))
  output$x1 = DT::renderDataTable(x, selection = 'none', editable = TRUE)
  
  proxy = dataTableProxy('x1')
  
  observeEvent(input$x1_cell_edit, {
    info = input$x1_cell_edit
    str(info)
    i = info$row
    j = info$col
    v = info$value
    x[i, j] <<- DT::coerceValue(v, x[i, j])
    replaceData(proxy, x, resetPaging = FALSE)  # important
  })
  
  output$text <- renderText({
    y()[1, 1]
  })
}