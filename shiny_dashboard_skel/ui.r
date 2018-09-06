# sidebar
sidebar <- dashboardSidebar(
  sidebarMenu(
    id = "tab",
    menuItem("Welcome Page", tabName = "welcome", icon = icon("user", lib = "glyphicon")),
    menuItem("Info",
      tabName = "info_tab", icon = icon("list"),
      menuSubItem("SubItem 1", tabName = "subitem_1", icon = icon("info")),
      menuSubItem("Subitem 2", tabName = "subitem_2", icon = icon("code"))
    )
  )
)

# body
body <- dashboardBody(
  fluidPage(
    tags$head(
      # tags$script(src="mixpanel.js"),
      tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
    ),

    tabItems(
      # welcome tab -----
      tabItem(
        tabName = "welcome",
        tags$h1("Homepage")
      ),
      # info tab -----
      tabItem(
        tabName = "subitem_1",
        box(color = "purple", width = 12, solidHeader = TRUE, title = "Box Title"),
        tabBox(
          title = "TabBox Title", width = 12, side = "right",
          tabPanel("Panel 1"),
          tabPanel("Panel 2")
        )
      ),
      tabItem(
        tabName = "subitem_2",
        tags$h3("Sample Link"),
        tags$h5(tags$li("", tags$a(href = "https://url.com", "Link Name"), ""))
      )
    )
  )
)

header <- dashboardHeader(
  title = "Dashboard Title",
  dropdownMenuOutput("messageMenu")
)



# assemble components ----
ui <- dashboardPage(
  skin = "purple",
  title = "ShinyDashboard Template",
  header = header,
  sidebar = sidebar,
  body = body
)
