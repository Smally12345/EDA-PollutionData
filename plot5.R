# Read Data
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

# Filter data to get motor vehicle related sources of emissions in Baltimore City
vehicleSCC <- SCC[grep("vehicle", SCC$EI.Sector, ignore.case = TRUE), "SCC"]
baltimoreNEI <- NEI[NEI$SCC %in% vehicleSCC & NEI$fips == "24510",]

# Calculate total motor vehicle related emissions in Baltimore City over years 
totalEmissions <- tapply(baltimoreNEI$Emissions, baltimoreNEI$year, FUN=sum)

# Convert matrix to data frame as is required by ggplot2 library
totalEmissions <- data.frame(year = names(totalEmissions), Emissions = totalEmissions)

# Plot
ggplot(data = totalEmissions, aes(x = year, y = Emissions, fill = year)) + geom_bar(stat = "identity") + labs(x = "Year", y = "Emissions(tons)", title = "Emissions from Motor Vehicle Sources over 10 years in Baltimore City") 

dev.copy(png, "plot5.png")
dev.off()