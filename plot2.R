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
png("./plot2.png",height = 480, width = 480, bg = "White")

#concatenate Date and Time variables
dtstamp_paste <- paste(sub_power_df$Date, sub_power_df$Time)

#COnvert to DateTime format
dtstamp <- strptime(dtstamp_paste, "%d/%m/%Y %H:%M:%S")

#Open plot
plot(dtstamp,sub_power_df$Global_active_power,
     xlab = "", ylab = "Global Active Power(kilowatts)", type="n")
#Add lines
lines (dtstamp,sub_power_df$Global_active_power)

# close device
dev.off() 
