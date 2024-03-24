import pandas as pd
import requests
from bs4 import BeautifulSoup

res = {}

# Specify the Excel file name
excel_file_name = 'assembly.xlsx'

# Specify the path to your text file
file_path = r"C:\Users\anana\Documents\klebsiella-pneumoniae-engine\input2.txt"

# Open the file in read mode
with open(file_path, 'r') as file:
    # Read the content of the file
    file_content = file.read()


def get_species_data(url):
    # Send a GET request to the URL
    response = requests.get(url)
    # Check if the request was successful
    if response.status_code == 200:
        # Parse the HTML content of the page
        soup = BeautifulSoup(file_content, 'html.parser')

        # Find all the links on the page
        links = soup.find_all('a', href=True)

        # Loop through each link
        for link in links:
            # link_url_format = /assembly/GCF_024427225.1
            # Get the URL of the link
            link_url = link['href']
            # # Check if the link leads to a specific page you're interested in
            if '/assembly/GCF' in link_url:
                # res.append(link_url)
                assembly = link_url[14:25]
                # Send a GET request to the specific page
                specific_page_response = requests.get("https://www.ncbi.nlm.nih.gov" + link_url)

                # Check if the request was successful
                if specific_page_response.status_code == 200:
                    # Parse the HTML content of the specific page
                    specific_page_soup = BeautifulSoup(specific_page_response.content, 'html.parser')
                    # print(specific_page_soup.get_text())
                    # Find the data under the "species" section
                    # Find the source name
                    start = specific_page_soup.get_text().find('SAMN1')
                    sample = specific_page_soup.get_text()[start + 4: start + 12]
                    print(sample)

            #         # Find the host name
            #         species_data = specific_page_soup.get_text().find('host')
            #         host = specific_page_soup.get_text()[species_data + 4: species_data + 7]
                    if sample != "ASM":
                        res[assembly] = sample
                    # print(specific_page_soup.get_text())

# Call the function with the URL of the webpage you want to scrape
get_species_data('https://www.ncbi.nlm.nih.gov/biosample?Db=biosample&DbFrom=bioproject&Cmd=Link&LinkName=bioproject_biosample&LinkReadableName=BioSample&ordinalpos=1&IdsFromResult=684769')
print(res)
# # Extract keys, hosts, and sources using zip
keys, values = zip(*res.items())
# hosts, sources = zip(*values)

# # Create a DataFrame
df = pd.DataFrame({
    'Assembly': keys,
    'Biosample': values
})

# Export the DataFrame to an Excel file
df.to_excel(excel_file_name, index=False)

print(f'Dictionary exported to {excel_file_name}')

# Learning source: https://realpython.com/python-web-scraping-practical-introduction/ 