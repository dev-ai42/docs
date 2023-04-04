#!/bin/bash
#Original script by afnfyz
#Contribution last few lines to ouput to terminal in cron or at job

script_dir=$(dirname $0)


# Display welcome message.
cat ./ascii/clock.txt

# Check if which command finds the at command.
# The /dev/null removes the PATH output from the which command.
if ! which at > /dev/null; # The ! is the NOT logical operator which reverses the exit status of command.
	then
  echo "Error: at command not installed."
  echo "Please install or use crontab to set reminders"
  exit
fi

# Set msg variable from input.
read -p "Enter reminder message: " msg
echo ""

# Set time variable from input.
#echo "Remind you in how long?"
#echo "(e.g. 1 hour or 30 minutes or 1 hour + 30 minutes etc)"
#read time

# Set time variable from input.
echo "Enter when you would like to be reminded."
read datetime
echo ""

# Convert datetime to at format.
# The date command is used to convert the date and time into a different format.
# The -d option tells date to use the value of the $datetime variable as the input date and time
# The +"%m/%d/%Y %H:%M" option specifies the output format that the command should use.
#at_time=$(date -d "$datetime" +"%Y%m%d%H%M")

at -M $datetime << EOF
echo "Reminder Message: ${msg}" > "$script_dir/reminder.txt"
cat  "$script_dir/reminder.txt"
EOF

#------------------------------------------------------------
#!/bin/bash

# Set msg variable from input.
read -p "Enter reminder message: " msg
echo ""

# Set time variable from input.
echo "Enter when you would like to be reminded."
read datetime
echo ""

at -M $datetime << EOF
echo "Reminder Message: ${msg}" > "reminder.txt"
echo -ne "\n" >  $(tty)
cat "reminder.txt"  > $(tty)
kill -s SIGINT  $(pidof bash)
EOF