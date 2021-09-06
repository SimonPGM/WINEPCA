source("Descriptive.R", encoding = "UTF-8")
source("PCASlides.R", encoding = "UTF-8")
source("BootstrapSlides.R", encoding = "UTF-8")

body <- dashboardBody(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
  ),
  tabItems(
    tabItem(tabName = "SIDEMAIN",
            h1("Trabajo Final Introducción al Análisis Multivariado"),
            HTML(
              '
              <img src="logounalslides.png" width="75%" height="75%" style="display: block; margin-left: auto; margin-right: auto;">
              '
            ),
            fluidRow(
              column(6, 
                     h2("Juan José Galeano Arenas")),
              column(5, offset = 1,
                     h2("Sebastián Gaviria Sánchez"))
            ),
            fluidRow(
              column(6,
                    h2("Simón Pedro Galeano Muñoz")),
              column(5, offset = 1,
                     h2("Santiago Zuluaga Ayala"))
            )),
    tabItem(tabName = "NOINT",
            fluidRow(
              column(2,
                     h1("Variables")),
              column(10, offset = 3,
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
            fluidRow(
              plotOutput("plotNOINT")
            )
            ),
    tabItem(tabName = "INT",
            fluidRow(
              column(2,
                     h1("Variables")
                     ),
              column(10, offset = 3,
                     actionButton(inputId = "ButtonINT1",
                                  label = "Acidez volátil"),
                     actionButton(inputId = "ButtonINT2",
                                  label = "Ácido cítrico"),
                     actionButton(inputId = "ButtonINT3",
                                  label = "Densidad"),
                     actionButton(inputId = "ButtonINT4",
                                  label = "Sulfatos"),
                     actionButton(inputId = "ButtonINT5",
                                  label = "Alcohol")
                     )
            ),
            fluidRow(
              plotOutput("plotINT")
            )
            ),
    tabItem(tabName = "NORM",
            fluidRow(
              h1("Resultados del test Anderson-Darling para normalidad")
              ),
            fluidRow(
              HTML('
                   <p style="text-align:center;font-size:x-large">
                    Como se puede observar, todas las variables
                   resultan no poseer distribución normal.
                   Debido a esto, no pueden provenir de una población
                   con distribución normal 11-variada; lo que implica
                   que no se tiene la interpretabilidad del
                   análisis de componentes principales cuando
                   los datos provienen de una población normal
                   multivariada.
                   </p>
                   ')
            ),
            fluidRow(
              tableOutput(outputId = "TABLENORM")
            )
            ),
    tabItem(tabName = "VARACUM",
            h1("Gráficas de varianza acumulada"),
            fluidRow(
              column(4, offset = 2,
                     actionButton("SCREEPLOT",
                                  "Screeplot")),
              column(4, offset = 2,
                     actionButton("VARACUMPLOT",
                                  "Varianza acumulada"))
            ),
            fluidRow(
              plotOutput("PLOTPCA1")
            ),
            fluidRow(
              HTML('
                   <p style="text-align:center">
                   Se puede apreciar que se tomó solo hasta 
                   la séptima componente principal,
                   lo que conlleva a una explicación de 90.88%
                   de la varianza total de los datos.
                   </p>
                   ')
            )
          ),
    tabItem(tabName = "CONTRIBS",
            h1("Gráficos de contribuciones"),
            fluidRow(
              column(4, offset = 1,
                     actionButton("CONTRIBS12",
                                  "Contribuciones componentes uno y dos")),
              column(4, offset = 1,
                     actionButton("CONTRIBSCORR",
                                  "Contribuciones en todas las componentes"))
            ),
            fluidRow(
              plotOutput("PLOTPCA2")
            ),
            fluidRow(
              htmlOutput("CONTRIBTEXT")
            )
            ),
    tabItem(tabName = "CORRC",
            h1("Círculo de correlaciones"),
            fluidRow(
              plotOutput("PLOTPCA3")
            ),
            fluidRow(
              HTML('
                   <p style="text-align:center">
                   Circulo de correlación para cosenos cuadrados.
                   Permite visualizar la contribución y calidad de
                   representación de cada variable en cada componente principal.
                   Claro está, en el plano factorial conformado por las
                   dos primeras componentes principales.
                   </p>
                   ')
            )
            ),
    tabItem(tabName = "RMSEB",
            fluidRow(
            column(5,
            sliderInput("SAMPLENUM", "Número de muestras",
                        min = 500, max = 2000, step = 250, value = 1000)),
            actionButton("CONFIRMBOOT", "Hacer Bootstrap")
              ),
            fluidRow(
              plotOutput("BOOTPLOT")
            ),
            fluidRow(
              tableOutput("BOOTTABLE")
            )
            ),
    tabItem(tabName = "DEFCOMP",
            h1("Comparación final modelos"),
            tableOutput("COMPFMODS"),
            fluidRow(
              HTML('
                   <p style="text-align:center">
                  Como se puede observar, el modelo completo obtiene valores más pequeños en las
                  medidas anteriormente descritas cuando predice sobre el conjunto de prueba, sin embargo el
                  modelo ajustado usando los datos de prueba llevados al espacio de las componentes principales
                  también obtiene medidas muy bajas, de hecho en todas ellas posee un error relativo porcentual
                  no mayor a 6.4 %, por lo que presenta un rendimiento muy similar al modelo original.
                   </p>
                   <br>
                   <p style="text-align:center">
                  Así que al considerar las conclusiones de la prueba Bootstrap (no existen diferencias
                  significativas entre los rendimientos del modelo al predecir) y la tabla, se puede aseverar con
                  total tranquilidad que el modelo ajustado con los datos en el espacio de las componentes
                  principales es igual de bueno que el ajustado sobre los datos en su espacio original, a pesar
                  de que el primero contenía un conjunto que explicaba el 90 % de la variabilidad total del
                  conjunto original. Adicionalmente, se tiene una ganancia a nivel de coste computacional pues
                  al tener menos columnas, el número de operaciones que debe realizar el software para ajustar
                  modelos es menor y por ende esto desemboca en un proceso más rápido y eficiente.
                    </p>
                    <br>
                    <img src="checklogo.png" width="25%" height="25%" style="display: block; margin-left: auto; margin-right: auto;">
                   ')
              )
            ),
    tabItem(tabName = "CONC",
            fluidRow(
              column(2,
                     h1("Conclusiones")
              ),
              column(10, offset = 3,
                     actionButton(inputId = "ButtonCONC1",
                                  label = "Primera"),
                     actionButton(inputId = "ButtonCONC2",
                                  label = "Segunda"),
                     actionButton(inputId = "ButtonCONC3",
                                  label = "Tercera"),
                     actionButton(inputId = "ButtonCONC4",
                                  label = "Cuarta"),
                     actionButton(inputId = "ButtonCONC5",
                                  label = "Quinta")
              )
      ),
      fluidRow(
        htmlOutput("CONCNUMBER")
      )
    )
  )
)

SERVER <- function(input, output) {
  #reactive values
  rvdescplotsINT <- reactiveValues(histg = histgacidezv, 
                                   hist = histacidezv,
                                   boxp = boxpacidezv)
  
  rvdescplotsNOINT <- reactiveValues(histg = histgacidez, 
                                   hist = histacidez,
                                   boxp = boxpacidez)
  
  rvplotsPCA1 <- reactiveValues(
    plot = eigen_plot
  )
  
  rvplotsPCA2 <- reactiveValues(
    plot = contrib_both,
    text = contrib_text[1]
  )
  
  rvconcs <- reactiveValues(
    text = conclusionsvector[1]
  )
  
  #table for normality test
  output$TABLENORM <- renderTable(normalidad)
  
  #handling output for interesting descriptive variables
  observeEvent(input$ButtonINT1, {
    rvdescplotsINT$histg <- histgacidezv
    rvdescplotsINT$boxp <- boxpacidezv
    rvdescplotsINT$hist <- histacidezv
  })
  
  observeEvent(input$ButtonINT2, {
    rvdescplotsINT$histg <- histgacidocit
    rvdescplotsINT$boxp <- boxpacidocit
    rvdescplotsINT$hist <- histacidocit
  })
  
  observeEvent(input$ButtonINT3, {
    rvdescplotsINT$histg <- histgdensity
    rvdescplotsINT$boxp <- boxpdensity
    rvdescplotsINT$hist <- histdensity
  })
  
  observeEvent(input$ButtonINT4, {
    rvdescplotsINT$histg <- histgsulfatos
    rvdescplotsINT$boxp <- boxpsulfatos
    rvdescplotsINT$hist <- histsulfatos
  })
  
  observeEvent(input$ButtonINT5, {
    rvdescplotsINT$histg <- histgalco
    rvdescplotsINT$boxp <- boxpalco
    rvdescplotsINT$hist <- histalco
  })
  
  output$plotINT <- renderPlot({
    ggpubr::ggarrange(rvdescplotsINT$histg,
                      ggpubr::ggarrange(rvdescplotsINT$boxp,
                                        rvdescplotsINT$hist,
                                        nrow = 1, ncol = 2),
                      nrow = 2, ncol = 1
                      )
  })
  
  #handling output for not interesting descriptive variables
  observeEvent(input$ButtonNOINT1, {
    rvdescplotsNOINT$histg <- histgacidez
    rvdescplotsNOINT$boxp <- boxpacidez
    rvdescplotsNOINT$hist <- histacidez
  })
  
  observeEvent(input$ButtonNOINT2, {
    rvdescplotsNOINT$histg <- histgresidsug
    rvdescplotsNOINT$boxp <- boxpresidsug
    rvdescplotsNOINT$hist <- histresidsug
  })
  
  observeEvent(input$ButtonNOINT3, {
    rvdescplotsNOINT$histg <- histgchlorides
    rvdescplotsNOINT$boxp <- boxpchlorides
    rvdescplotsNOINT$hist <- histchlorides
  })
  
  observeEvent(input$ButtonNOINT4, {
    rvdescplotsNOINT$histg <- histgfreeslufdiox
    rvdescplotsNOINT$boxp <- boxpfreeslufdiox
    rvdescplotsNOINT$hist <- histfreeslufdiox
  })
  
  observeEvent(input$ButtonNOINT5, {
    rvdescplotsNOINT$histg <- histgtotalslufdiox
    rvdescplotsNOINT$boxp <- boxptotalslufdiox
    rvdescplotsNOINT$hist <- histtotalslufdiox
  })
  
  observeEvent(input$ButtonNOINT6, {
    rvdescplotsNOINT$histg <- histgph
    rvdescplotsNOINT$boxp <- boxpph
    rvdescplotsNOINT$hist <- histph
  })
  
  output$plotNOINT <- renderPlot({
    ggpubr::ggarrange(rvdescplotsNOINT$histg,
                      ggpubr::ggarrange(rvdescplotsNOINT$boxp,
                                        rvdescplotsNOINT$hist,
                                        nrow = 1, ncol = 2),
                      nrow = 2, ncol = 1
    )
  })
  
  #handling accumulated variance plot
  observeEvent(input$SCREEPLOT, {rvplotsPCA1$plot <- eigen_plot})
  
  observeEvent(input$VARACUMPLOT, {rvplotsPCA1$plot <- cum_por})
  
  output$PLOTPCA1 <- renderPlot({rvplotsPCA1$plot})
  
  #handling contributions plot
  observeEvent(input$CONTRIBS12, 
               {rvplotsPCA2$plot <- contrib_both
               rvplotsPCA2$text <- contrib_text[1]})
  
  observeEvent(input$CONTRIBSCORR,
               {rvplotsPCA2$plot <- NULL
               rvplotsPCA2$text <- contrib_text[2]})
  
  output$PLOTPCA2 <- renderPlot({
    if (is.null(rvplotsPCA2$plot)) {
      corrplot::corrplot(variables$cor, is.corr = F, outline = T, 
                         tl.col = "black")
    } else {
      rvplotsPCA2$plot
    }
      })
  output$CONTRIBTEXT <- renderUI(
    {HTML(rvplotsPCA2$text)}
  )
  
  #correlation circle
  output$PLOTPCA3 <- renderPlot({cos2_circle_anot})
  
  #handlign conclusions
  observeEvent(input$ButtonCONC1, {
    rvconcs$text <- conclusionsvector[1]
  })
  
  observeEvent(input$ButtonCONC2, {
    rvconcs$text <- conclusionsvector[2]
  })
  
  observeEvent(input$ButtonCONC3, {
    rvconcs$text <- conclusionsvector[3]
  })
  
  observeEvent(input$ButtonCONC4, {
    rvconcs$text <- conclusionsvector[4]
  })
  
  observeEvent(input$ButtonCONC5, {
    rvconcs$text <- conclusionsvector[5]
  })
  
  output$CONCNUMBER <- renderUI(
    {HTML(rvconcs$text)}
    )
  
  #plot of bootstrap
  bootdata <- eventReactive(input$CONFIRMBOOT, {Boot(input$SAMPLENUM)})
  output$BOOTPLOT <- renderPlot({bootdata()[["graf"]]})
  output$BOOTTABLE <- renderTable({bootdata()[["datos"]]})
  
  #table of final model comparison
  output$COMPFMODS <- renderTable(dfmeasures)
}