library(shiny)
library(shinydashboard)

source("SideBar.R")
source("Body.R")

ui <- dashboardPage(
  dashboardHeader(title = "Proyecto final"),
  sidebar,
  body,
  skin = "green"
)

server <- SERVER

shinyApp(ui, server)