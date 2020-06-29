# Read Data  
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

# Filter data to get coal related Sources of emission
coalSCC <- SCC[grep("coal", SCC$EI.Sector, ignore.case = TRUE), "SCC"]
coalNEI <- NEI[NEI$SCC %in% coalSCC,]

# Calculate total coal combustion related emissions over years 
totalCoalEmissions <- tapply(coalNEI$Emissions, coalNEI$year, FUN=sum)

# Convert matrix to data frame as is required by ggplot2 library
totalCoalEmissions <- data.frame(year = names(totalCoalEmissions), Emissions = totalCoalEmissions)

# Plot
ggplot(data = totalCoalEmissions, aes(x = year, y = Emissions/1000, fill = year)) + geom_bar(stat = "identity") + labs(x = "Year", y = "Emissions (kilotons)", title = "Coal Combustion related Emissions over 10 years")
dev.copy(png, "plot4.png")
dev.off()