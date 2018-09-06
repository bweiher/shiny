library(shiny)
library(DT)

server <- function(input, output, session) {
  
  observeEvent(input$action, {
    x <- iris  
  })
  
  
 # this reactive df will stay current w/ the changes made to DT `x_1`
  y <- reactive({
    input$x1_cell_edit
    x
  })
  
  #x$Date <- Sys.time() + seq_len(nrow(x))
  output$x1 <- DT::renderDataTable({
    if(exists("x"))
    datatable(x, selection = 'single', editable = TRUE, rownames = FALSE)
  })
  
  proxy <- dataTableProxy('x1')
  
  # observe if a cell is edited, then coerce value and replace data
  # underlying table x is modified, NOT the reactive one 
  observeEvent(input$x1_cell_edit, {
    click_info <- input$x1_cell_edit
    # str(info)
    i <- click_info$row
    j <- click_info$col + 1
    v <- click_info$value
    x[i, j] <<- coerceValue(v, x[i, j]) # coerce `v` to the data type of the row/col it was selected from 
    replaceData(proxy, x, resetPaging = FALSE, rownames=FALSE)  # important
  })
  
  # just print the reactive , modified DF 
  output$text <- renderDT({
    y() %>% 
      datatable(rownames=FALSE)
  })
  
  
}