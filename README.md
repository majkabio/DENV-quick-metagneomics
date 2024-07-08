# DENV quick metagneomics
This script is a custom metagenomics pipeline that performs kmer-based classification on reads in nanopore FASTQ files using Kraken2 with a user-specified Kraken2 database<br/>
by **M Galarion**
<br/>
<br/>
## IMPORTANT DEPENDENCIES
Make sure the following tools are installed:<br/>
&emsp;**kraken2**  https://github.com/DerrickWood/kraken2<br/>
&emsp;**kraken database**<br/>
<br/>
Once these tools are installed, you need to explicitly define the command usage for each tool and specify the location of the databases <br/>
To do this, open the latest version of the bash script in a text editor <br/>
Starting from around line 29, edit the line that corresponds to the tool definition (inside the quotation marks) <br/>
 <br/>
For example:
```

### Define tools and how you call them in your current system

kraken = "/software/kraken2-v2.1.1/kraken2"
krakendb = "/home/user/kraken-DB/minikraken2_v2/minikraken2_v2_8GB_201904_UPDATE"    # directory of kraken2 database

```
The tool definition inside the quotation marks should correspond to how you call them in your current system<br/>
Save the bash file and close<br/>

<br/>

### Command line usage:
```

bash quick_metagenomics_pipeline_v3.sh -i raw_reads.fastq

```
**NOTE:** Always run the script inside the directory where your -i files are located.

<br/>
