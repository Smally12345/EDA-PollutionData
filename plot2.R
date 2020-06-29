# Read data
NEI <- readRDS("./summarySCC_PM25.rds")

# Filter data to get Baltimore City data 
BaltimoreNEI <- NEI[NEI$fips == "24510", c(4,6)] 

# Calculate total emissions in Baltimore by year
totalEmissions <- tapply(BaltimoreNEI$Emissions, BaltimoreNEI$year, FUN=sum)

# Plot
barplot(totalEmissions, xlab = "Year", ylab = "Emissions(tons)", main = "Total Annual Emissions Over 10 years in Balitmore City, Maryland")
dev.copy(png, "plot2.png")
dev.off()