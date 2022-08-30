#! /bin/tcsh
# Script for extracting a GMT-ready 2D profile from a DEM

## Set parameters and input files
set start_loc = "-152.6576/57.8618"   # track start point
set end_loc = "-152.351562/57.427594" # track end point
set grdfile =  ../../kodiak-project/gmt_plotting/gmt_data/vault/storage/GEODATA/bathy2.nc   # input bathymetry grid file
set dist=0.05  # sample interval along track
set track = track.xyz  # track data file
set profile_2D = 2D_profile.txt

## extract values along track from grid file
gmt project -C$start_loc -E$end_loc -G$dist -Q -V > tmpfile

## Create 2D profile
gmt grdtrack tmpfile -G$grdfile -fg -V > $track
cat $track | awk '{print $3,$4/1000}' > $profile_2D

## Add final two points to close the polygon
set maxX = `cat $track | awk '{print $3,$4/1000}' | awk 'max=="" || $1 > max {max=$1} END{ print max}'`
set minX = `cat $track | awk '{print $3,$4/1000}' | awk 'min=="" || $1 < min {min=$1} END{ print min}'`
set minY = `cat $track | awk '{print $3,$4/1000}' | awk 'min=="" || $2 < min {min=$2} END{ print min}'`
set maxY = `cat $track | awk '{print $3,$4/1000}' | awk 'max=="" || $2 > max {max=$2} END{ print max}'`
echo "$maxX $minY" >> $profile_2D
echo "$minX $minY" >> $profile_2D

## Clean-up
rm track.xyz
rm tmpfile
