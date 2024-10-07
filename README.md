# Create a Local BLAST DataBase of Beta-Lactamase Proteins
## Overview
This project provides a script to download all beta-lactamase protein sequences from the Beta-Lactamase Database (BLDB) and create a local BLAST database. The downloaded sequences can be used for various bioinformatics analyses related to antibiotic resistance.
## Prerequisites
1. Linux or macOS (Windows users can use WSL)
2. `Bash` shell
3. `Python3` with `requests` and `tqdm` libraries installed
4. `BLAST+` installed on your system
## Installing Required Python Libraries
1. To install the required Python libraries, run:
```bash
python3 -m pip install requests tqdm
```
2. Installing BLAST+
You can download and install latest BLAST+ from the [NCBI BLAST website](https://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/).
```bash
wget -c https://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/ncbi-blast-2.16.0+-x64-linux.tar.gz
wget -c https://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/ncbi-blast-2.16.0+-x64-linux.tar.gz.md5
md5sum -c ncbi-blast-2.16.0+-x64-linux.tar.gz.md5
tar -xvzf ncbi-blast-2.16.0+-x64-linux.tar.gz
```
Set the path of the `bin` folder from `ncbi-blast-2.16.0+` in your `.bashrc` file.
 
## Script Overview
The main script performs the following steps:
1. Create a local directory to store downloaded data.
2. Fetch HTTP links for beta-lactamase protein sequences from the BLDB webpage.
3. Download the protein sequences using a Python script.
4. Combine all downloaded FASTA files into one file.
5. Create a local BLAST database from the combined sequences.
## Usage Instructions
Clone this repository (if applicable) or create your own directory:
```bash
git clone <repository-url>
cd <repository-name>
```
Run the Bash script:
```bash
./create_local_bldb.sh
```
