library(tidyverse)

PCA.MOD <- read.csv("DatoscompPCA.csv")[, -1]
NORM.MOD <- read.csv("DatoscompNorm.csv")[, -1]
mean_train0 <- mean(PCA.MOD$mean_score_train) - mean(NORM.MOD$mean_score_train)
mean_test0 <- mean(PCA.MOD$mean_score_test) - mean(NORM.MOD$mean_score_test)
binw <- function(x) {
  n <- length(x)
  k <- round(1 + 3.322*log10(n))
  (max(x) - min(x))/k
}

Boot <- function(n, trainpca = PCA.MOD$mean_score_train,
                 trainnorm = NORM.MOD$mean_score_train,
                 testpca = PCA.MOD$mean_score_test,
                 testnorm = NORM.MOD$mean_score_test) {
boot_mean_train <- c()
boot_mean_test <- c()
for (i in 1:n) {
  boot_mean_train[i] <- mean(sample(trainpca, 1920, replace = T)) - mean(sample(trainnorm, 1920, replace = T))
  boot_mean_test[i] <- mean(sample(testpca, 1920, replace = T)) - mean(sample(testnorm, 1920, replace = T))
}
pvalue_train <- 2*min(mean(boot_mean_train <= mean_train0),mean(boot_mean_train >= mean_train0))
pvalue_test <- 2*min(mean(boot_mean_test <= mean_test0),mean(boot_mean_test >= mean_test0))

histboot1 <- ggplot(data.frame(x = boot_mean_train), aes(x))+
  geom_histogram(binwidth = binw(boot_mean_train), col = "black", fill = "cyan")+
  labs(x = "", y = "Frecuencia",
       title = paste("Histograma para la diferencia del RMSE medio en el conjunto de\nentrenamiento del k-fold cross validation con", as.character(n), "muestras Bootstrap"))+
  geom_segment(data = data.frame(x = c(quantile(boot_mean_train, c(0.025, 0.975)), mean_train0),
                                 y = c(0,0,0), Clase = c("Confianza", "Confianza",
                                                         "Estadístico de prueba")),
               mapping = aes(x = x,
                             xend = x,
                             y = y, yend = c(600, 600, 600), color = Clase, linetype = Clase))+
  scale_colour_manual(values = c("black", "red"))

histboot2 <- ggplot(data.frame(x = boot_mean_test), aes(x))+
  geom_histogram(binwidth = binw(boot_mean_test), col = "black", fill = "cyan")+
  labs(x = "", y = "Frecuencia",
       title = paste("Histograma para la diferencia del RMSE medio en el conjunto de\nprueba del k-fold cross validation con", as.character(n), "muestras Bootstrap"))+
  geom_segment(data = data.frame(x = c(quantile(boot_mean_test, c(0.025, 0.975)), mean_test0),
                                 y = c(0,0,0), Clase = c("Confianza", "Confianza",
                                                         "Estadístico de prueba")),
               mapping = aes(x = x,
                             xend = x,
                             y = y, yend = c(600, 600, 600), color = Clase, linetype = Clase))+
  scale_colour_manual(values = c("black", "red"))


grafico <- ggpubr::ggarrange(histboot1, histboot2, nrow = 2, ncol = 1)
df <- data.frame(conj = c("Entrenamiento", "Prueba"), pvalor = round(c(pvalue_train, pvalue_test),4))
colnames(df) <- c("Conjunto de datos", "Valor P")
list(graf = grafico, datos = df)
}

dfmeasures <- read.csv("Compfinal.csv", row.names = 1)

dfmeasures <- dfmeasures %>% round(4) %>%
  mutate(medida = rownames(dfmeasures),
         ) %>%
  select(medida, everything()) %>%
  mutate(Porcentaje_de_error = paste(as.character(Porcentaje_de_error), "%",
                                     sep = ""))

colnames(dfmeasures) <- c("Métrica", "Modelo Completo", "Modelo PCA", "Porcentaje de error")
