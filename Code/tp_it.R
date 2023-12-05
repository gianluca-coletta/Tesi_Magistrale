# Read CSV file
df_TPIt <- read.csv("C:\\Users\\colig\\OneDrive\\Desktop\\Università\\Tesi_Magistrale\\CSV\\ClosingTransaction_TPIT.csv", header = TRUE, sep = ";")

library(lubridate)

# Count the number of rows for each different day in a new df
# Crea una copia temporanea del dataframe
df_TPIt_copy <- df_TPIt

# Estrai la parte della data senza l'orario dalla stringa
df_TPIt_copy$DateOnly <- as.Date(df_TPIt_copy$CreatedDateTime, format = "%d/%m/%Y %H:%M")

# Conta le occorrenze di ciascun giorno
counts_per_day <- table(df_TPIt_copy$DateOnly, useNA = "always")

# Crea un dataframe con le colonne "day" e "count"
result_df <- as.data.frame(counts_per_day)

# Rinomina le colonne
colnames(result_df) <- c("day", "count")

# Stampa il risultato
print(result_df)

# Plot the result for 2018 year
# Carica la libreria ggplot2
library(ggplot2)
library(gridExtra)

# Filtra solo le righe corrispondenti all'anno 2018
result_df_2018 <- result_df[year(result_df$day) == 2018, ]

result_df_2018$day <- as.Date(result_df_2018$day)

# Crea un grafico a linee del trend delle transazioni per giorno nell'anno 2018
ggplot(result_df_2018, aes(x = day, y = count)) +
  geom_line() +
  labs(x = "Day", y = "Closing transaction Count", title = "Transaction Trend in 2018") +
  theme_minimal() +
  scale_x_date(labels = scales::date_format("%b"), date_breaks = "1 month")


# Filtra solo le righe corrispondenti all'anno 2022
result_df_2022 <- result_df[year(result_df$day) == 2022, ]

result_df_2022$day <- as.Date(result_df_2022$day)

# Crea un grafico a linee del trend delle transazioni per giorno nell'anno 2022
ggplot(result_df_2022, aes(x = day, y = count)) +
  geom_line() +
  labs(x = "Day", y = "Closing transaction Count", title = "Transaction Trend in 2022") +
  theme_minimal() +
  scale_x_date(labels = scales::date_format("%b"), date_breaks = "1 month")

# Crea una lista di grafici a linee per ogni anno
plots_list <- lapply(2018:2022, function(year) {
  df_subset <- result_df[year(result_df$day) == year, ]
  ggplot(df_subset, aes(x = day, y = count)) +
    geom_line() +
    labs(x = "Day", y = "Closing transaction Count", title = paste("Transaction Trend in", year)) +
    theme_minimal() +
    scale_x_date(labels = scales::date_format("%b"), date_breaks = "1 month")
})

# Combina i grafici in un multiplot
multiplot <- grid.arrange(grobs = plots_list, ncol = 1)

# Stampa il multiplot
print(multiplot)

