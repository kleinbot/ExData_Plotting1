###################################
##  GLOBAL ACTIVE POWER PER DAY 
# 
# This script works on the
# "Individual household electric power consumption Data Set" 
# extracted from the UC Irvine Machine Learning Repository and available for download
# via the https://github.com/rdpeng/ExData_Plotting1 repository
# 
# Be sure to download the data set to the same path as this script for running this script.
# The dplyr package for R is also required.
# 
# It plots the household global minute-averaged active power over two days (in kilowatt), 
# 2007-02-01 and 2007-02-02
###################################



library(dplyr)

# get classes of data from the dataset
init_hpc <- read.csv2("household_power_consumption.txt", nrows=100)
classes_hpc <- sapply(init_hpc, class)

#read entire dataset 
hpc_all <- read.csv2("household_power_consumption.txt", colClasses = classes_hpc)

#create a subset of the dataframe and omit NA values
sub1_hpc <- subset(hpc_all[complete.cases(hpc_all),], Date == "1/2/2007" | Date == "2/2/2007")

#turn the Global_active_power values into numeric values
sub1_hpc <- transform(sub1_hpc, 
                      Global_active_power = as.numeric(as.vector(Global_active_power)))

#concatenate Date and Time values
sub2 <- (mutate(sub1_hpc, DateTime = paste(Date, Time)))

#convert DateTime to POSIXlt objects
sub2$DateTime <- strptime(sub2$DateTime, "%d/%m/%Y %H:%M:%S")

#add a weekday column (not necessary for this plot, I just like adding it)
sub2 <- mutate(sub2, Day = format(DateTime, "%a"))


#set up and plot to PNG
png(filename = "plot2.png", width = 480, height = 480)

with(sub2, plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))

dev.off()


