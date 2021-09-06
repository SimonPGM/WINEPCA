library(shiny)
library(shinydashboard)

source("SideBar.R", encoding = "UTF-8")
source("Body.R", encoding = "UTF-8")

ui <- dashboardPage(
  dashboardHeader(title = "Proyecto final"),
  sidebar,
  body,
  skin = "green"
)

server <- SERVER

shinyApp(ui, server)