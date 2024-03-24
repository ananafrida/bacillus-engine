import pandas as pd

# Load data from Excel files
all_data = pd.read_excel('assembly.xlsx')
species_data = pd.read_excel('species.xlsx')

# Merge the two dataframes based on "Biosample" column
merged_data = pd.merge(all_data, species_data, on='Biosample', how='left')

# Export merged data to Excel file
merged_data.to_excel('final.xlsx', index=False)

print("Merged data exported to final.xlsx")
