library(tidyverse)
binw <- function(x) {
  n <- length(x)
  k <- round(1 + 3.322*log10(n))
  (max(x) - min(x))/k
}

descriptive <- read.csv("descriptive.csv") %>%
  mutate(labels = factor(labels))

#Acidez fija (no mucho que decir, no es normal, mismo nivel medio pero variabilidad
#aumenta con el aumento de nivel)
histacidez <- ggplot(descriptive, aes(x = fixed.acidity)) +
  geom_histogram(aes(fill = labels), color = "black",
                 binwidth = binw(descriptive$fixed.acidity)) +
  facet_wrap(~labels)+
  labs(x = "Acidez fija", y = "Frecuencia",
       title = "Histograma para la acidez fija",
       fill = "Calidad del vino")+
  theme_minimal()

boxpacidez <- ggplot(descriptive, aes(x = fixed.acidity)) +
  geom_boxplot(aes(fill = labels), alpha = 0.3)+
  coord_flip() +
  labs(y = "", x = "Acidez fija", fill = "Calidad del vino",
       title = "Boxplot para la acidez fija")+
  theme_minimal()
  
histgacidez <- ggplot(descriptive, aes(x = fixed.acidity)) +
  geom_histogram(fill = "cyan", color = "black",
                 binwidth = binw(descriptive$fixed.acidity)) +
  labs(y = "Frecuencia", x = "Acidez fija",
       title = "Histograma para la acidez fija")+
  theme_minimal()


#Acidez volatil (diferencia media apreciable no normal)
histacidezv <- ggplot(descriptive, aes(x = volatile.acidity)) +
  geom_histogram(aes(fill = labels), color = "black",
                 binwidth = binw(descriptive$volatile.acidity)) +
  facet_wrap(~labels)+
  labs(x = "Acidez volátil", y = "Frecuencia",
       title = "Histograma para la acidez volátil", fill = "Calidad del vino")+
  theme_minimal()


boxpacidezv <- ggplot(descriptive, aes(x = volatile.acidity)) +
  geom_boxplot(aes(fill = labels), alpha = 0.3)+
  coord_flip() +
  labs(y = "", x = "Acidez volátil", fill = "Calidad del vino",
       title = "Boxplot para la acidez volatil")+
  theme_minimal()

histgacidezv <- ggplot(descriptive, aes(x = volatile.acidity)) +
  geom_histogram(fill = "cyan", color = "black",
                 binwidth = binw(descriptive$volatile.acidity)) +
  labs(y = "Frecuencia", x = "Acidez volátil",
       title = "Histograma para la acidez volátil")+
  theme_minimal()

#acido cítrico (diferencia media apreciable no normal)
histacidocit <- ggplot(descriptive, aes(x = citric.acid)) +
  geom_histogram(aes(fill = labels), color = "black",
                 binwidth = binw(descriptive$citric.acid)) +
  facet_wrap(~labels)+
  labs(x = "Ácido cítrico", y = "Frecuencia",
       title = "Histograma para el ácido cítrico", fill = "Calidad del vino")+
  theme_minimal()


boxpacidocit <- ggplot(descriptive, aes(x = citric.acid)) +
  geom_boxplot(aes(fill = labels), alpha = 0.3)+
  coord_flip() +
  labs(y = "", x = "Ácido cítrico", fill = "Calidad del vino",
       title = "Boxplot para el ácido cítrico")+
  theme_minimal()

histgacidocit <- ggplot(descriptive, aes(x = citric.acid)) +
  geom_histogram(fill = "cyan", color = "black",
                 binwidth = binw(descriptive$citric.acid)) +
  labs(x = "Ácido cítrico", y = "Frecuencia",
       title = "Histograma para el ácido cítrico")+
  theme_minimal()

#azucar residual (nivel medio igual, no normal, variabilidad igual)
histresidsug <- ggplot(descriptive, aes(x = residual.sugar)) +
  geom_histogram(aes(fill = labels), color = "black",
                 binwidth = binw(descriptive$residual.sugar)) +
  facet_wrap(~labels)+
  labs(x = "Azucar residual", y = "Frecuencia",
       title = "Histograma para el azucar residual",
       fill = "Calidad del vino")+
  theme_minimal()


boxpresidsug <- ggplot(descriptive, aes(x = residual.sugar)) +
  geom_boxplot(aes(fill = labels), alpha = 0.3)+
  coord_flip() +
  labs(y = "", x = "Azucar residual", fill = "Calidad del vino",
       title = "Boxplot para el azucar residual")+
  theme_minimal()

histgresidsug <- ggplot(descriptive, aes(x = residual.sugar)) +
  geom_histogram(fill = "cyan", color = "black",
                 binwidth = binw(descriptive$residual.sugar)) +
  labs(x = "Azucar residual", y = "Frecuencia",
       title = "Histograma para el azucar residual")+
  theme_minimal()

#chlorides (no normal, nada interesante que mostrar)
histchlorides <- ggplot(descriptive, aes(x = chlorides)) +
  geom_histogram(aes(fill = labels), color = "black",
                 binwidth = binw(descriptive$chlorides)) +
  facet_wrap(~labels)+
  labs(x = "Cloruros", y = "Frecuencia",
       title = "Histograma para los cloruros",
       fill = "Calidad del vino")


boxpchlorides <- ggplot(descriptive, aes(x = chlorides)) +
  geom_boxplot(aes(fill = labels), alpha = 0.3)+
  coord_flip() +
  labs(y = "", x = "Cloruros", fill = "Calidad del vino",
       title = "Boxplot para los cloruros")

histgchlorides <- ggplot(descriptive, aes(x = chlorides)) +
  geom_histogram(fill = "cyan", color = "black",
                 binwidth = binw(descriptive$chlorides)) +
  labs(x = "Cloruros", y = "Frecuencia", title = "Histograma para los cloruros")

#dioxido de sulfuro libre(nada interesante para el dioxido de sulfuro)
histfreeslufdiox <- ggplot(descriptive, aes(x = free.sulfur.dioxide)) +
  geom_histogram(aes(fill = labels), color = "black",
                 binwidth = binw(descriptive$free.sulfur.dioxide)) +
  facet_wrap(~labels)+
  labs(x = "Dióxido de azufre libre", y = "Frecuencia",
       title = "Histograma para el dióxido de azufre libre",
       fill = "Calidad del vino")

boxpfreeslufdiox <- ggplot(descriptive, aes(x = free.sulfur.dioxide)) +
  geom_boxplot(aes(fill = labels), alpha = 0.3)+
  coord_flip() +
  labs(y = "", x = "Dióxido de azufre libre", fill = "Calidad del vino",
       title = "Boxplot para el dióxido de azufre libre")

histgfreeslufdiox <- ggplot(descriptive, aes(x = free.sulfur.dioxide)) +
  geom_histogram(fill = "cyan", color = "black",
                 binwidth = binw(descriptive$free.sulfur.dioxide)) +
  labs(x = "Dióxido de azufre libre", y = "Frecuencia",
       title = "Histograma para el dióxido de azufre libre")

#dioxido de sulfuro total (nada interesante)
histtotalslufdiox <- ggplot(descriptive, aes(x = total.sulfur.dioxide)) +
  geom_histogram(aes(fill = labels), color = "black",
                 binwidth = binw(descriptive$total.sulfur.dioxide)) +
  facet_wrap(~labels)+
  labs(x = "Dióxido de azufre total", y = "Frecuencia",
       title = "Histograma para el dióxido de azufre total",
       fill = "Calidad del vino")

boxptotalslufdiox <- ggplot(descriptive, aes(x = total.sulfur.dioxide)) +
  geom_boxplot(aes(fill = labels), alpha = 0.3)+
  coord_flip() +
  labs(y = "", x = "Dióxido de azufre total", fill = "Calidad del vino",
       title = "Boxplot para el dióxido de azufre total")

histgtotalslufdiox <- ggplot(descriptive, aes(x = total.sulfur.dioxide)) +
  geom_histogram(fill = "cyan", color = "black",
                 binwidth = binw(descriptive$total.sulfur.dioxide)) +
  labs(x = "Dióxido de azufre total", y = "Frecuencia",
       title = "Histograma para el dióxido de azufre total")

#densidad(cambio en los niveles de variabilidad, no normal)
histdensity <- ggplot(descriptive, aes(x = density)) +
  geom_histogram(aes(fill = labels), color = "black",
                 binwidth = binw(descriptive$density)) +
  facet_wrap(~labels)+
  labs(x = "Densidad", y = "Frecuencia",
       title = "Histograma para la densidad", fill = "Calidad del vino")+
  theme_minimal()

boxpdensity <- ggplot(descriptive, aes(x = density)) +
  geom_boxplot(aes(fill = labels), alpha = 0.3)+
  coord_flip() +
  labs(y = "", x = "Densidad", fill = "Calidad del vino",
       title = "Boxplot para la densidad")+
  theme_minimal()

histgdensity <- ggplot(descriptive, aes(x = density)) +
  geom_histogram(fill = "cyan", color = "black",
                 binwidth = binw(descriptive$density)) +
  labs(x = "Densidad", y = "Frecuencia",
       title = "Histograma para la densidad")+
  theme_minimal()

#ph (nada interesante)
histph <- ggplot(descriptive, aes(x = pH)) +
  geom_histogram(aes(fill = labels), color = "black",
                 binwidth = binw(descriptive$pH)) +
  facet_wrap(~labels)+
  labs(x = "Ph", y = "Frecuencia",
       title = "Histograma para el Ph",
       fill = "Calidad del vino")

boxpph <- ggplot(descriptive, aes(x = pH)) +
  geom_boxplot(aes(fill = labels), alpha = 0.3)+
  coord_flip() +
  labs(y = "", x = "Ph", fill = "Calidad del vino",
       title = "Boxplot para el Ph")

histgph <- ggplot(descriptive, aes(x = pH)) +
  geom_histogram(fill = "cyan", color = "black",
                 binwidth = binw(descriptive$pH)) +
  labs(x = "Ph", y = "Frecuencia",
       title = "Histograma para el Ph")

#sulfatos (incremento en el nivel medio, no normalidad)
histsulfatos <- ggplot(descriptive, aes(x = sulphates)) +
  geom_histogram(aes(fill = labels), color = "black",
                 binwidth = binw(descriptive$sulphates)) +
  facet_wrap(~labels)+
  labs(x = "Sulfatos", y = "Frecuencia",
       title = "Histograma para los sulfatos", fill = "Calidad del vino")+
  theme_minimal()

boxpsulfatos <- ggplot(descriptive, aes(x = sulphates)) +
  geom_boxplot(aes(fill = labels), alpha = 0.3)+
  coord_flip() +
  labs(y = "", x = "Sulfatos", fill = "Calidad del vino",
       title = "Boxplot para los sulfatos")+
  theme_minimal()

histgsulfatos <- ggplot(descriptive, aes(x = sulphates)) +
  geom_histogram(fill = "cyan", color = "black",
                 binwidth = binw(descriptive$sulphates)) +
  labs(x = "Sulfatos", y = "Frecuencia",
       title = "Histograma para los sulfatos")+
  theme_minimal()

#Alcohol (niveles de variabilidad muy distintos)
histalco <- ggplot(descriptive, aes(x = alcohol)) +
  geom_histogram(aes(fill = labels), color = "black",
                 binwidth = binw(descriptive$alcohol)) +
  facet_wrap(~labels)+
  labs(x = "Alcohol", y = "Frecuencia",
       title = "Histograma para el alcohol", fill = "Calidad del vino")+
  theme_minimal()

boxpalco<- ggplot(descriptive, aes(x = alcohol)) +
  geom_boxplot(aes(fill = labels), alpha = 0.3)+
  coord_flip() +
  labs(y = "", x = "Alcohol", fill = "Calidad del vino",
       title = "Boxplot para el alcohol")+
  theme_minimal()

histgalco <- ggplot(descriptive, aes(x = alcohol)) +
  geom_histogram(fill = "cyan", color = "black",
                 binwidth = binw(descriptive$alcohol)) +
  labs(x = "Alcohol", y = "Frecuencia",
       title = "Histograma para el alcohol")+
  theme_minimal()

normalidad <- MVN::mvn(descriptive[, -12])$univariateNormality
colnames(normalidad) <- c("Prueba", "Variable",
                          "Valor del estadístico de prueba", "Valor P",
                          "Normalidad")
