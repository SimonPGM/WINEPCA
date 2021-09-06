sidebar <- dashboardSidebar(
  sidebarMenu(id = "SIDEBAR",
    menuItem("Página Principal", tabName = "SIDEMAIN",
             icon = icon("book", lib = "glyphicon")),
    menuItem("Análisis Descriptivo", tabName = "EDAED",
             icon = icon("eye-open", lib = "glyphicon"),
             menuSubItem("Variables sin hallazgos ",
                         tabName = "NOINT"),
             menuSubItem("Variables con hallazgos",
                         tabName = "INT"),
             menuSubItem("Normalidad",
                         tabName = "NORM")
      ),
    menuItem("PCA", tabName = "SIDEPCA",
             icon = icon("stats", lib = "glyphicon"),
             menuSubItem("Variabilidad Acumulada",
                         tabName = "VARACUM"),
             menuSubItem("Contribuciones",
                         tabName = "CONTRIBS"),
             menuSubItem("Círculo de Correlaciones",
                         tabName = "CORRC")
      ),
    menuItem("Random Forest Regressor", tabName = "SIDMOD",
             icon = icon("tasks", lib = "glyphicon"),
             menuSubItem("Bootstrap", tabName = "RMSEB"),
             menuSubItem("Comparación Final", 
                         tabName = "DEFCOMP")
      ),
    menuItem("Conclusiones", tabName = "CONC",
             icon = icon("ok-sign", lib = "glyphicon"))
  )
)
