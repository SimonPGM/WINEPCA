source("Descriptive.R")

body <- dashboardBody(
  tabItems(
    tabItem(tabName = "SIDEMAIN",
            h1("Principal")),
    tabItem(tabName = "NOINT",
            fluidRow(
              actionButton(inputId = "ButtonNOINT1",
                           label = "Acidez fija"),
              actionButton(inputId = "ButtonNOINT2",
                           label = "Azúcar residual"),
              actionButton(inputId = "ButtonNOINT3",
                           label = "Cloruruos"),
              actionButton(inputId = "ButtonNOINT4",
                           label = "Dióxido de azufre libre"),
              actionButton(inputId = "ButtonNOINT5",
                           label = "Dióxido de azufre total"),
              actionButton(inputId = "ButtonNOINT6",
                           label = "pH")
            )
            ),
    tabItem(tabName = "INT",
            h1("Interesantes")),
    tabItem(tabName = "NORM",
            h1("Prueba de normalidad")),
    tabItem(tabName = "VARACUM",
            h1("Gráficas de varianza acumulada")),
    tabItem(tabName = "CONTRIBSCOS",
            h1("Gráficos de contribuciones y cosenos cuadrados")),
    tabItem(tabName = "CORRC",
            h1("Círculo de correlaciones")),
    tabItem(tabName = "PCATABS",
            h1("Tablas de resultados")),
    tabItem(tabName = "RMSEB",
            h1("Pruebas Bootstrap")),
    tabItem(tabName = "DEFCOMP",
            h1("Comparación final modelos")),
    tabItem(tabName = "CONC",
            h1("Conclusiones"))
  )
)

SERVER <- function(input, output) {
  
}