###################################
##  GLOBAL ACTIVE POWER
# 
# This script works on the
# "Individual household electric power consumption Data Set" 
# extracted from the UC Irvine Machine Learning Repository and available for download
# via the https://github.com/rdpeng/ExData_Plotting1 repository
# 
# Be sure to download the data set to the same path as this script for running this script.
# 
# It plots the frequency of household global minute-averaged active power levels over two days, 
# 2007-02-01 and 2007-02-02
###################################


# get classes of data from the dataset
init_hpc <- read.csv2("household_power_consumption.txt", nrows=100)
classes_hpc <- sapply(init_hpc, class)

#read entire dataset 
hpc_all <- read.csv2("household_power_consumption.txt", colClasses = classes_hpc)

#create a subset of the dataframe
sub1_hpc <- subset(hpc_all, Date == "1/2/2007" | Date == "2/2/2007")

#turn the Global_active_power values into numeric values
sub1_hpc <- transform(sub1_hpc, 
                      Global_active_power = as.numeric(as.vector(Global_active_power)))

#omit NA values
globalActiveValues <- na.omit(sub1_hpc$Global_active_power)


#set up and plot to PNG
png(filename = "plot1.png", width = 480, height = 480)

hist(globalActiveValues, 
     col = "red",
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")

dev.off()


