

shinyServer(function(input, output, session) {
  output$messageMenu <- renderMenu({
    notifications <- list(notificationItem(text = "Metric fell 10% week-over-week", icon = icon("exclamation-triangle")))
    dropdownMenu(type = "notifications", .list = notifications)
  })
})
