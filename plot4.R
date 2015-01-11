#Downloaded file kept in working dir
#Initialize filename
filename <- "household_power_consumption.txt"

#Read file into R
all_power_df <- read.table(filename,header = TRUE, sep =";",
                           na.strings = "?", stringsAsFactors = FALSE)
#Subset Data 
sub_power_df <- all_power_df[
  as.Date(all_power_df$Date,"%d/%m/%Y") >= 
    as.Date("2007-02-01","%Y-%m-%d") 
  & as.Date(all_power_df$Date,"%d/%m/%Y") <= 
    as.Date ("2007-02-02","%Y-%m-%d")
  ,]

#Remove large object; release memory
rm(all_power_df)

#Start plot; open png file device
png("./plot4.png",height = 480, width = 480, bg = "White")

#Define matrix of sub-plots using mfcol
par(mfcol= c(2,2))

#Start detals for sub-plot 1

#Concatenate Date and Time vars; convert to datetime using strptime
dtstamp_paste <- paste(sub_power_df$Date, sub_power_df$Time)
dtstamp <- strptime(dtstamp_paste, "%d/%m/%Y %H:%M:%S")

#Open plot and add lines
plot(dtstamp,sub_power_df$Global_active_power,
     xlab = "", ylab = "Global Active Power", type="n")
lines (dtstamp,sub_power_df$Global_active_power)

#Start details for sub-plot 2

#Define range for y-axis
global_range <- range(0,
                      sub_power_df$Sub_metering_1,
                      sub_power_df$Sub_metering_2,
                      sub_power_df$Sub_metering_3)

#Open plot and add lines
plot(dtstamp, sub_power_df$Sub_metering_1, ylim = global_range,
     xlab = "", ylab = "Energy sub metering", type ="n")
lines (dtstamp,sub_power_df$Sub_metering_1, col = "Black")
lines (dtstamp,sub_power_df$Sub_metering_2, col = "Red")
lines (dtstamp,sub_power_df$Sub_metering_3, col = "Blue")

#Define legend; keep char expansion to 0.8
legend("topright",c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=rep(1,3), col=c("Black","Red","Blue"), bty ="n", cex = 0.8)

#Start details for sub-plot 3

#Open plot and add lines 
plot(dtstamp,sub_power_df$Voltage,
     xlab = "datetime", ylab = "Voltage", type = "n")
lines (dtstamp,sub_power_df$Voltage)

#Start details for sub-plot 4

#Open plot and add lines
plot(dtstamp,sub_power_df$Global_reactive_power,
     xlab = "datetime",ylab="Global_reactive_power", type = "n")
lines(dtstamp,sub_power_df$Global_reactive_power)

# close device
dev.off() 
