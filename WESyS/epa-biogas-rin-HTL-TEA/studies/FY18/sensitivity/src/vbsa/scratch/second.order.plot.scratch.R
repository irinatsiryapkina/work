#second order Effects
df <- sensitivity.results.2

df.3 <- subset (sensitivity.results.2, df$lower > 0)

df <- df.3

gg <- ggplot (df, aes (x = df$variable, y = value, colour = df$variable)) +
  theme (axis.text.x = element_text (angle = 75, hjust = 1)) +
  geom_boxplot(notch = TRUE, show.legend = FALSE) + 
  labs (title = "Second Order Index", x = "Model Factor", y = expression ("St"["i"]))

gg
