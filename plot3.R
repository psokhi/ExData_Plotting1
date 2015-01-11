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
png("./plot3.png",height = 480, width = 480, bg = "White")

#Get range to set y-axis
global_range <- range(0,
                      sub_power_df$Sub_metering_1,
                      sub_power_df$Sub_metering_2,
                      sub_power_df$Sub_metering_3)

#Open plot 
plot(dtstamp, sub_power_df$Sub_metering_1, ylim = global_range,
     xlab = "", ylab = "Energy sub metering", type ="n")
#Add lines for Submetering 1
lines (dtstamp,sub_power_df$Sub_metering_1, col = "Black")
#Add lines for Submetering 2
lines (dtstamp,sub_power_df$Sub_metering_2, col = "Red")
#Add lines for Submetering 3
lines (dtstamp,sub_power_df$Sub_metering_3, col = "Blue")

#Define legend
legend("topright",c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=rep(1,3), col=c("Black","Red","Blue"))

# close device
dev.off() 
