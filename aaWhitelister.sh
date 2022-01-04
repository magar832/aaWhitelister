#!/bin/bash

## This variable is the download path for the whitelist. It also acts
## as the working directory for this script. Change the path as needed. 
dlpath=$HOME

## Firstrun check
FILE=$dlpath/aaWhitelist_formatted.txt
if [ -f "$FILE" ]; then
	echo "$FILE exists."
else
	echo "Creating non-empty whitelist file..."
	echo "example.com" >> $dlpath/aaWhitelist_formatted.txt
fi

## Variable holds finalized file contents
whitelist=$(cat $dlpath/aaWhitelist_formatted.txt)

## Delete current whitelist entries using previously saved whitelist
echo "Removing previous AAdvantage whitelist entries"
pihole -w -d $whitelist

## Download whitelist, format it
echo "Downloading new whitelist..."
curl -L https://www.aadvantageeshopping.com/adBlockWhitelist.php -o $dlpath/aaWhitelist.txt 
sed -i '1,4d' $dlpath/aaWhitelist.txt ## Remove header
sed -i 's/^@@||//g' $dlpath/aaWhitelist.txt ## remove the @@|| in each line
tr '\n' ' ' < $dlpath/aaWhitelist.txt > $dlpath/aaWhitelist_formatted.txt ## Replace newline to whitespace

## Upload whitelist to Gravity
whitelist=$(cat $dlpath/aaWhitelist_formatted.txt)
echo "These domains will be added: " $whitelist
pihole -w --comment "AAdvantage eShopping" $whitelist 
