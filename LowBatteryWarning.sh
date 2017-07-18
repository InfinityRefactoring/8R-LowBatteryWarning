#!/bin/bash

#The percentage that indicates the low level.
#Use a value between 0 and 100.
LOW_BATTERY_PERCENTAGE=15;

#The percentage that indicates the critical level.
#Use a value between 0 and 100.
CRITICAL_BATTERY_PERCENTAGE=10;

#Waiting time to run the suspension command.
#Use the time in minutes.
SUSPENSION_TIMER=3;

#Waiting time to next verification.
#Use the time in minutes.
VERIFICATION_INTERVAL=2;

#The path to battery.
BATTERY_PATH="/sys/class/power_supply/BAT0";

#Command to suspend.
#The command need sudo privileges.
SUSPENSION_COMMAND="/usr/sbin/pm-suspend";

#The icon that will displayed if the battery level is low.
LOW_BATTERY_ICON="/usr/share/icons/Mint-X/status/96/battery_low.svg";

#The icon that will displayed if the battery level is critical.
CRITICAL_BATTERY_ICON="/usr/share/icons/Mint-X/status/96/battery_caution.svg";

#The path to the alarm.
#Use files .ogg
ALARM_PATH="/opt/8R-LowBatteryWarning/reverse_alarm_truck_clean.ogg";

isDischarging() {
	if [ $(cat "$BATTERY_PATH/status") = "Discharging" ]; then {
		echo true;
	} else {
		echo false;
	} fi
}

notify() {
	if [ "$lastNotification" != "$1" ]; then {
		notify-send -u "$1" -i "$2" "$3 battery level! $currentCapacity%" "Connect the charger$4";
		if [ "$1" = "critical" ]; then {
			play "$ALARM_PATH";
		} fi
		lastNotification="$1";
	} fi
}

lastNotification="";

while [ true ]
do
	if [ $(isDischarging) = true ]; then {
		currentCapacity=$(cat "$BATTERY_PATH/capacity");
		if [ $currentCapacity -le $LOW_BATTERY_PERCENTAGE ] && [ $currentCapacity -gt $CRITICAL_BATTERY_PERCENTAGE ]; then {
			notify "normal" "$LOW_BATTERY_ICON" "Low" ".";
		} elif [ $currentCapacity -le $CRITICAL_BATTERY_PERCENTAGE ]; then {
			notify "critical" "$CRITICAL_BATTERY_ICON" "Critical" " or the computer will suspend at $SUSPENSION_TIMER minutes.";
			sleep $(($SUSPENSION_TIMER * 60));
			if [ $(isDischarging) = true ]; then {
				lastNotification="";
				sudo "$SUSPENSION_COMMAND";
			} fi
		} fi
	} else {
		lastNotification="";
	} fi
	sleep $(($VERIFICATION_INTERVAL * 60));
done
