# aaWhitelister
A bash script that adds the American Airlines AAdvantage eShopping whitelist to Pi-Hole. Pair it with a cron job!
## How it works
The script pulls the official American Airlines eShopping whitelist from https://www.aadvantageeshopping.com/adBlockWhitelist.php, formats it, and uploads it to Pi-Hole using its native commands.

The American Airlines whitelist is designed for AdBlock Plus and has its own formatting. The aaWhitelister script changes the format by removing the ABP delimiters and organizing the domains on a single whitespace delimited line in a separate file. This is necessary as the arguement for Pi-Hole's whitelist command only takes domains in this format. 

The script will read the previously created whitelist file in order to remove the whitelisted domains from Pi-Hole's whitelist database. After removal, it will download the latest whitelist from the website and add those domains to Pi-Hole's whitelist. This ensures there are no unnecessary/outdated domains in the whitelist.

### By default, this script saves the altered and unaltered whitelist file inside your home folder. Feel free to change the path for these files by changing the ```dlpath``` variable.
