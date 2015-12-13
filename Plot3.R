###################################
##  ENERGY SUB METERING PER DAY 
# 
# This script works on the
# "Individual household electric power consumption Data Set" 
# extracted from the UC Irvine Machine Learning Repository and available for download
# via the https://github.com/rdpeng/ExData_Plotting1 repository
# 
# Be sure to download the data set to the same path as this script for running this script.
# The dplyr package for R is also required.
# 
# It plots the active energy of three different sub meters over two days, 
# 2007-02-01 and 2007-02-02.
# 
# Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). 
# It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave 
# (hot plates are not electric but gas powered).
# Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). 
# It corresponds to the laundry room, containing a washing-machine, a tumble-drier, 
# a refrigerator and a light.
# Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). 
# It corresponds to an electric water-heater and an air-conditioner.
###################################


library(dplyr)

# get classes of data from the dataset
init_hpc <- read.csv2("household_power_consumption.txt", nrows=100)
classes_hpc <- sapply(init_hpc, class)

#read entire dataset 
hpc_all <- read.csv2("household_power_consumption.txt", colClasses = classes_hpc)

#create a subset of the dataframe and omit NA values
sub1_hpc <- subset(hpc_all[complete.cases(hpc_all),], Date == "1/2/2007" | Date == "2/2/2007")

#turn the values into numeric values
sub1_hpc <- transform(sub1_hpc, 
                      Global_active_power = as.numeric(as.vector(Global_active_power)),
                      Sub_metering_1 = as.numeric(as.vector(Sub_metering_1)),
                      Sub_metering_2 = as.numeric(as.vector(Sub_metering_2)),
                      Sub_metering_3 = as.numeric(as.vector(Sub_metering_3))
                      )

#concatenate Date and Time values
sub2 <- (mutate(sub1_hpc, DateTime = paste(Date, Time)))

#convert DateTime to POSIXlt objects
sub2$DateTime <- strptime(sub2$DateTime, "%d/%m/%Y %H:%M:%S")

#add a weekday column (not necessary for this plot, I just like adding it)
sub2 <- mutate(sub2, Day = format(DateTime, "%a"))


#set up and plot to PNG
png(filename = "plot3.png", width = 480, height = 480)

with(sub2, plot(DateTime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
with(sub2, points(DateTime, Sub_metering_2, type = "l", col = "red"))
with(sub2, points(DateTime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = names(sub2[7:9]))

dev.off()


