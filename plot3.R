# Import Libraries
library(dplyr)
library(ggplot2)

# Read Data
NEI <- readRDS("./summarySCC_PM25.rds")

# Filter Data to get Baltimore City Data and we only want last 3 columns (Emissions, type, year)
BaltimoreNEI <- NEI[NEI$fips == "24510", 4:6]

# Calculate total Emissions in Baltimore City grouped by year and type that is source of emission
BaltimoreNEI <- BaltimoreNEI %>%
  group_by(year, type) %>%
  summarise(Emissions=sum(Emissions))

# Plot four plots according to type of source over years
plt <- ggplot(data = BaltimoreNEI, aes(x = factor(year), y = Emissions, fill = type)) + geom_bar(stat = "identity") + facet_grid(. ~ type) + labs(x = "Year", y = "Emissions", title = "Emission by different sources over 10 years") + theme(axis.text=element_text(size=7))
print(plt)
dev.copy(png, "plot3.png")
dev.off()