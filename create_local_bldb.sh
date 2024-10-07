#!/bin/sh

# Create the main directory for BLDB data
echo "LOG: Creating main directory for BLDB data..."
mkdir -p local_bldb
echo "LOG: Main directory created."

# Switch to main directory
cd local_bldb || { echo "Failed to change directory to local_bldb"; exit 1; }

# Fetch all HTTP links from the BLDB webpage and download each FASTA file
echo "LOG: Fetching HTTP links from BLDB webpage..."
lynx -accept_all_cookies -dump http://www.bldb.eu/seq_prot/ | \
grep "http" | \
sed -e "s/^.*http/http/" | \
grep ".fasta" > all_bla_prot_links
echo "LOG: Links fetched and saved to all_bla_prot_links."

# Download the all URLs using Python script
echo "LOG: Downloading FASTA files using Python script..."
python3 ../download_urls.py || { echo "Python script failed"; exit 1; }
echo "LOG: FASTA files downloaded."

# Combine all downloaded FASTA files into one file
echo "LOG: Combining downloaded FASTA files into one file..."
cat *.fasta > sequences
echo "LOG: Combined FASTA files into sequences."

# Create a BLAST database from the sequences file
echo "LOG: Creating BLAST database from sequences file..."
makeblastdb -in sequences -title "Beta-Lactamase DataBase (BLDB)" -dbtype prot -hash_index -parse_seqids -out bldb -logfile makeblastdb.log
if [ $? -eq 0 ]; then
    echo "LOG: BLAST database created successfully."
else
    echo "Error: Failed to create BLAST database."
    exit 1
fi

cd ../
echo "All tasks completed successfully!"
