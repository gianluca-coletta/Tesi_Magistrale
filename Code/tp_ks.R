# Read CSV file
df_TPKS <- read.csv("C:\\Users\\colig\\OneDrive\\Desktop\\Università\\Tesi_Magistrale\\CSV\\ClosingTransaction_TPKS.csv", header = TRUE, sep = ";")

library(lubridate)

# Count the number of rows for each different day in a new df
# Crea una copia temporanea del dataframe
df_TPKS_copy <- df_TPKS

# Estrai la parte della data senza l'orario dalla stringa
df_TPKS_copy$DateOnly <- as.Date(df_TPKS_copy$CreatedDateTime, format = "%d/%m/%Y %H:%M")

# Conta le occorrenze di ciascun giorno
counts_per_day <- table(df_TPKS_copy$DateOnly, useNA = "always")

# Crea un dataframe con le colonne "day" e "count"
result_df <- as.data.frame(counts_per_day)

# Rinomina le colonne
colnames(result_df) <- c("day", "count")

# Stampa il risultato
print(result_df)

# Plot the result for 2018 year
# Carica la libreria ggplot2
library(ggplot2)

# Filtra solo le righe corrispondenti all'anno 2022
result_df_2022 <- result_df[year(result_df$day) == 2022, ]

result_df_2022$day <- as.Date(result_df_2022$day)

# Crea un grafico a linee del trend delle transazioni per giorno nell'anno 2022
ggplot(result_df_2022, aes(x = day, y = count)) +
  geom_line() +
  labs(x = "Day", y = "Closing transaction Count", title = "Transaction Trend in 2022") +
  theme_minimal() +
  scale_x_date(labels = scales::date_format("%b"), date_breaks = "1 month")

