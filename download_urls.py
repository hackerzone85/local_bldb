import requests
from tqdm import tqdm

def download(url: str, filename: str):
    # Stream the request to avoid loading the entire file into memory
    with requests.get(url, stream=True) as response:
        response.raise_for_status()  # Check for request errors
        total = int(response.headers.get('content-length', 0))  # Get total file size
        
        # Use tqdm to create a progress bar
        with open(filename, 'wb') as file, tqdm(
            desc=filename,
            total=total,
            unit='iB',
            unit_scale=True,
            unit_divisor=1024,
            position=1,  # Position in case of multiple bars
            leave=False,  # Leave space for the progress bar after completion
        ) as bar:
            for data in response.iter_content(chunk_size=8192):  # Read in chunks
                size = file.write(data)  # Write data to file
                bar.update(size)  # Update progress bar

# Read links from the file
with open('all_bla_prot_links') as f:
    links = f.readlines()

# Total number of links for overall progress
total_links = len(links)

# Create a main progress bar for total downloads
with tqdm(total=total_links, desc="Total Downloads", position=0) as main_bar:
    for link in links:
        filename = link.strip().split('/')[-1]  # Extract filename from URL
        download(link.strip(), filename)  # Download each link
        main_bar.update(1)  # Update main progress bar after each download