library(FactoMineR)
library(factoextra)

#Leyendo y partiendo la BD
wine <- read.csv("winequality-red.csv", header = T)
labels <- wine[, 12]
data <- wine[, -12]

#Partiendo los datos para train y test
n <- dim(data)[1]
set.seed(123)
train_index <- sample(1:n, floor(0.8*n))
train_wine <- data[train_index, ]
test_wine <- data[-train_index, ]

#labels
train_labels <- labels[train_index]
test_label <- labels[-train_index]

#Creando PCA
wine_pca <- PCA(train_wine, graph = F, ncp = 7)

#Valores propios del PCA
eigen_wine <- get_eigenvalue(wine_pca)

#Obteniendo los individuos
individuos <- get_pca_ind(wine_pca)
variables <- get_pca_var(wine_pca)

#Screeplot
eigen_plot <- fviz_eig(wine_pca, addlabels = T)

#Porcentaje acumulado
cum_por <- ggplot(mapping = aes(x = 1:11, y = eigen_wine[, 3])) +
  geom_line() + xlim(1,11) +
  scale_x_continuous(breaks= 1:11) +
  geom_segment(mapping = aes(x = c(1, 7), xend = c(7, 7),
                             y = c(90.8761, 0), 
                             yend = c(90.8761, 90.8761)), 
               color = "red", linetype = "dashed")

cum_por <- ggpubr::ggpar(cum_por, title = "Variabilidad acumulada",
                         xlab = "Componente principal",
                         ylab = "Porcentaje (%)",
                         ggtheme = theme_minimal())

#Plots de variables que mas contribuyen a las PCs
contrib_plot_pc1 <- fviz_contrib(wine_pca, choice = "var", top = 11)
contrib_plot_pc2 <- fviz_contrib(wine_pca, choice = "var", axes = 2,
                                 top = 11)

#Renombrando ejes y demas
contrib_plot_pc1 <- ggpubr::ggpar(contrib_plot_pc1,
                                  title = "Contribución de las variables a la\ncomponente principal 1", ylab = "Contribuciones (%)") 
contrib_plot_pc2 <-ggpubr::ggpar(contrib_plot_pc2,
                                 title = "Contribución de las variables a la\ncomponente principal 2", ylab = "Contribuciones (%)") 

contrib_both <- ggpubr::ggarrange(contrib_plot_pc1, contrib_plot_pc2,
                  ncol = 2, nrow = 1)

# contrib_corr <- corrplot::corrplot(variables$cor, is.corr = F, outline = T, 
#                                    tl.col = "black", add = T)
contrib_text <- c('
                   <p style="text-align:center">
                   Las barras indican el porcentaje de contribución de cada variable a cada componente principal.
                   La linea roja punteada indica el porcentaje medio de contribución esperado.
                   </p>
                   ',
                  '
                  <ul>
                  <li>Puntos grandes y azules indican alta correlación positiva entre variables y componentes principales. </li>
                  <li>Puntos grandes y rojos indican alta correlación negativa entre variables y componentes principales.</li>
                  <li>Puntos pequeños y palidos indican baja correlación entre variables y componentes principales. </li>
                  </ul>
                  '
                  )

#circulo de correlaciones
cos2_circle <- fviz_pca_var(wine_pca, repel = T, 
                            col.var = "cos2",
                            gradient.cols = c("#00AFBB",
                                              "#E7B800",
                                              "#FC4E07")) 
cos2_circle <- ggpubr::ggpar(cos2_circle,
                             title = "Circulo de correlación",
                             xlab = "Componente principal 1",
                             ylab = "Componente principal 2",
                             legend.title = "Coseno cuadrado")
# Anotaciones cos2
cos2_circle_anot <- cos2_circle + 
  annotate(
    geom = "curve", x = 0.3, y = 0.9, xend = 0.55, yend = 1, 
    colour = "blue",
    curvature = -.3, arrow = arrow(length = unit(2, "mm"))
  ) + 
  annotate(geom = "text", x = 0.56, y = 0.9, label = "Alta contribución \n Alta calidad \n Respecto \n a la CP2", hjust = "left", size = 3) +
  annotate(
    geom = "curve", x = -0.4, y = 0.42, xend = -0.75, yend = 0.52, 
    colour = "blue",
    curvature = 0.1, arrow = arrow(length = unit(2, "mm"))
  ) +
  annotate(geom = "text", x = -0.51, y = 0.76, label = "Baja calidad \n respecto a \n ambas \n componentes ", hjust = "right", size = 3) + 
  annotate(
    geom = "curve", x = -0.75, y = -0.05, xend = -0.5, yend = -0.25, 
    colour = "blue",
    curvature = -.3, arrow = arrow(length = unit(2, "mm"))
  ) +
  annotate(geom = "text", x = -0.55, y = -0.56,
           label = "Alta calidad \n respecto a CP1. \n Calidad cercana \n a cero respecto a \n CP2",
           hjust = "center", size = 3)

#conclusiones 

conclusionsvector <- c(
                  '
                   <p style="text-align:center;margin-top:15%;font-size:x-large">
                  Concretizando, como se vio en el apartado del informe técnico, fueron necesarias 7
                  covariables para explicar el 90.88 % de la variación de los datos, por lo cual, se obtiene
                  una reducción considerable en la dimensionalidad del sistema, resultado deseable para
                  el propósito de este proyecto.
                   </p>
                   ',
                  '
                   <p style="text-align:center;margin-top:15%;font-size:x-large">
                  En segundo lugar se tiene una alta influencia de las variables relacionadas con la
                  acidez a la hora de explicar la componente principal 1, dichas variables se encuentran
                  correlacionadas de manera fuerte con el pH, el cual es una medida de acidez.
                   </p>
                   ',
                  '
                   <p style="text-align:center;margin-top:15%;font-size:x-large">
                    Dado el ángulo y la norma de la variable acidez fija, se puede afirmar que esta es la que
                    mejor explica la componente principal 1, seguida a su vez de la variable ácido cítrico.
                    Cabe destacar también que el pH aporta gran calidad a esta componente porque aunque
                    su longitud en el circulo de correlación no es tan alta como la de las variables anteriores,
                    su ángulo respecto al eje formado por dicha componente es mínimo.
                   </p>
                   ',
                  '
                   <p style="text-align:center;margin-top:15%;font-size:x-large">
                    Las variables relacionadas con dioxido de azufre son las que explican de mejor manera la
                    componente principal 2, adicionalmente son aquellas con mejor calidad de representación
                    en dicha componente porque el ángulo que forman con dicho eje es pequeño y tienen
                    una gran magnitud. Además están altamente correlacionadas.
                   </p>
                   ',
                  '
                   <p style="text-align:center;margin-top:15%;font-size:x-large">
                    Finalmente, respecto a la implementación de los modelos descritos anteriormente, se
                    puede afirmar que el análisis de componentes principales para esa causa fue de gran
                    provecho, puesto que, como se mostró en los respectivos resultados, el modelo ajustado
                    con el conjunto completo de covariables tiene un rendimiento similar al modelo con
                    componentes principales, a pesar de que éste último explica aproximadamente el 91 %
                    de la variabilidad total de los datos originales, y además ganando terreno en términos
                    de parsimonia y eficiencia computacional.
                   </p>
                   '
)
