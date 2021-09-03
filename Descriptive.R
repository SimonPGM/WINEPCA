binw <- function(x) {
  n <- length(x)
  k <- round(1 + 3.322*log10(n))
  (max(x) - min(x))/k
}

descriptive <- train_wine %>%
  mutate(labels = as.factor(train_labels))

#Acidez fija (no mucho que decir, no es normal, mismo nivel medio pero variabilidad
#aumenta con el aumento de nivel)
ggplot(descriptive, aes(x = fixed.acidity)) +
  geom_histogram(aes(fill = labels), color = "black",
                 binwidth = binw(descriptive$fixed.acidity)) +
  facet_wrap(~labels)+
  labs(x = "Acidez fija", y = "Frecuencia", title = "F")

ggplot(descriptive, aes(x = fixed.acidity)) +
  geom_boxplot(aes(fill = labels), alpha = 0.3)+
  coord_flip() +
  labs(y = "", x = "Acidez fija", fill = "Calidad del vino")
  
  
ggplot(descriptive, aes(x = fixed.acidity)) +
  geom_histogram(fill = "cyan", color = "black", binwidth = binw(descriptive$fixed.acidity))

#Acidez volatil (diferencia media apreciable no normal)
ggplot(descriptive, aes(x = volatile.acidity)) +
  geom_boxplot(aes(fill = labels), alpha = 0.3)+
  coord_flip() +
  labs(y = "", x = "Acidez volatil", fill = "Calidad del vino")

#acido cítrico (diferencia media apreciable no normal)
ggplot(descriptive, aes(x = citric.acid)) +
  geom_boxplot(aes(fill = labels), alpha = 0.3)+
  coord_flip() +
  labs(y = "", x = "Ácido cítrico", fill = "Calidad del vino") 

#azucar residual (nivel medio igual, no normal, variabilidad igual)
ggplot(descriptive, aes(x = residual.sugar)) +
  geom_histogram(aes(fill = labels), color = "black",
                 binwidth = binw(descriptive$residual.sugar)) +
  facet_wrap(~labels)+
  labs(x = "Azucar residual", y = "Frecuencia", title = "F")

#
write.csv(descriptive, "descriptive.csv", row.names = F)
