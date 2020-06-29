# Read Data
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

# Filter SCC data to get vehicle related sources of emission
vehicleSCC <- SCC[grep("vehicle", SCC$EI.Sector, ignore.case = TRUE), "SCC"]

# Filter NEI data to get Emission data related to vehicles in counties of Baltimore and Los Angeles 
vehicleNEI <- NEI[NEI$SCC %in% vehicleSCC & NEI$fips %in% c("24510","06037"),]

# Calculate total emissions by year and county
vehicleEmissions <- tapply(vehicleNEI$Emissions, list(vehicleNEI$year, vehicleNEI$fips), FUN=sum)

# Convert matrix to data frame as required by ggplot2 library
vehicleEmissions <- data.frame(county = c(rep("Los Angeles",4), rep("Baltimore City",4)), year = rep(rownames(vehicleEmissions),2), Emissions = c(vehicleEmissions[,1], vehicleEmissions[,2]))

# Plot two graphs showing Emissions over years in Baltimore and Los Angeles
ggplot(data = vehicleEmissions, aes(x = year, y = Emissions, fill = county)) + geom_bar(stat = "identity") + facet_grid(. ~ county) +labs(x = "Year", y = "Emissions(tons) by vehicle related sources", title = "Baltimore City vs Los Angeles") 

dev.copy(png, "plot6.png")
dev.off()