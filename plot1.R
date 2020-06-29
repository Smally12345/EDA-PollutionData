# Read Data
NEI <- readRDS("./summarySCC_PM25.rds")

# Calculate Total Emissions grouped by years
totalEmissions <- tapply(NEI$Emissions/1000, NEI$year, FUN=sum)

# Plot
barplot(totalEmissions, xlab = "Year", ylab = "Emissions(kilotons)", main = "Total Annual Emissions Over 10 years")
dev.copy(png, "plot1.png")
dev.off()