#!/bin/bash


#################################################################################################
#
# Name of program: quick_metagenomics_pipeline_v3.sh
# Created by: Majo Galarion
# Date created: 07 February 2023
#
# This script is a pipeline to do quick and dirty analysis on metagenomics samples from MinION / GridION run using Kathy's ONT hybrid cystom barcodes
# Analysis uses kraken2 and minikraken2_v2 database
# Main steps include:
# [1] Concatenate fastq files per barcode and rename to meaningful sample ID
# [2] Create kraken2 output directory
# [3] Run kraken2 -- report output is analyzed and visualized by web-based Pavian shinny app -- https://fbreitwieser.shinyapps.io/pavian/
#
# Version 3 Revision date: 22 February 2024 by Majo Galarion
#           remove concatenation step as there's a separate script for this
#			modified to take usage parameters in command line
#
#################################################################################################
#
# Always run this script inside directory of your input files!
#
### Important dependencies:
# Define tools and database and how you call them in your current system
# Differs with every machine / system
#
kraken="/software/kraken2-v2.1.1/kraken2"
krakendb="/home3/2509094g/kraken-DB/minikraken2_v2/minikraken2_v2_8GB_201904_UPDATE"
#
#################################################################################################


usage() {
	echo "";
	echo "Quick metagenomics analysis";
	echo "";
	echo "Usage $0 -i reads.fastq" 1>&2;
	echo "";
	echo "Optional parameters:";
	echo "-t: number of threads (default: 8)";
	echo "";
	exit 1;
}

if [ $# -eq 0 ]; then usage; exit 1; fi


### These are the default paramters
threads="8";

### Read these arguments when specified in command
while getopts ":i:t:" opt
do
	case "${opt}" in
		i) fq=${OPTARG} ;;
		t) threads=${OPTARG} ;;
		?) echo "Option -${OPTARG} requires an argument" >&2
		exit 1
		;;
	esac
done
shift $((OPTIND-1))

### Define name of sample to be used as prefix
name=${fq%.fastq.gz}
name=${name%.fq.gz}
name=${name%.fq}
name=${name%.fastq}

### Create output directory
mkdir quick_meta_${name}

### Output arguments specified to terminal stdout
echo "";
echo -e "\033[31m Quick metagenomics analysis\033[0m";
echo -e "\033[31m by Majo Galarion\033[0m";
echo "";
echo -e "Input file: \033[33m${fq}\033[0m";
echo -e "Number of threads: \033[33m${threads}\033[0m";


### Classify reads using Kraken2
echo "";
echo -e "\033[32m Classify reads with kraken2...\033[0m"
echo "";

${kraken} --db ${krakendb} --threads ${threads} --use-names --output quick_meta_${name}/${name}.fastq-kraken.output.txt --report quick_meta_${name}/${name}.fastq-kraken.report ${fq}



echo "";
echo -e "\033[31m Analysis finished!\033[0m"
echo "";