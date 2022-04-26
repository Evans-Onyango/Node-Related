#!/bin/tcsh

# Define preferred instrument data
set network = 8J
set chan1 = DP1
set chan2 = DP2
set chan3 = DPZ

# Define generic response file
set genericRESP = generic_RESP.1001.8J._DPZ

# Define output directory
set RESP_dir = instrumentRESPONSES

# Extract generic station and channel data
set genericStation = `grep -w -m 1 Station $genericRESP | awk '{print $3}'`
set genericChannel = `grep -w -m 1 Channel $genericRESP | awk '{print $3}'`

# Create response files from template
foreach station (`cat station_list.txt`)
	echo "Working on station $station"
	mkdir -p $RESP_dir
	# Define names of response files
	set RESP1 = RESP.${station}.${network}._${chan1}
	set RESP2 = RESP.${station}.${network}._${chan2}
	set RESP3 = RESP.${station}.${network}._${chan3}
	# Copy generic response file
	cp $genericRESP $RESP1
	cp $genericRESP $RESP2
	cp $genericRESP $RESP3
end # End each station

# Loop thru the station list and edit created files.
foreach station (`cat station_list.txt`)
	echo "Working on station $station"
	mkdir -p $RESP_dir
	# Define names of response files
	set RESP1 = RESP.${station}.${network}._${chan1}
	set RESP2 = RESP.${station}.${network}._${chan2}
	set RESP3 = RESP.${station}.${network}._${chan3}
	# Copy generic response file
	cp $genericRESP $RESP1
	cp $genericRESP $RESP2
	cp $genericRESP $RESP3
	# Edit new response file
	sed -i "s/$genericStation/$station/g" $RESP1
	sed -i "s/$genericChannel/$chan1/g" $RESP1
	sed -i "s/$genericStation/$station/g" $RESP2
	sed -i "s/$genericChannel/$chan2/g" $RESP2
	sed -i "s/$genericStation/$station/g" $RESP3
	sed -i "s/$genericChannel/$chan3/g" $RESP3
	# Move edited file to output directory
	mv $RESP1 $RESP_dir
	mv $RESP2 $RESP_dir
	mv $RESP3 $RESP_dir
end # End each station

# End of file
