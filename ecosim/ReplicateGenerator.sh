#!/bin/bash

# Define input files
FASTA_FILE=ecosim-proc-with-gap.fasta
NEWICK_FILE=tree_file_with_gap_ecosim_proc.newick

# Output directory for XML files
OUTPUT_DIR="results"

# Loop to run ecosim 500 times
for ((i = 1; i <= 500; i++)); do
    OUTPUT_XML_FILE="$OUTPUT_DIR/output_results_$i.xml"

    # Run ecosim with the specified input and output files
    java -jar ecosim.jar -n \
        --sequences="$FASTA_FILE" \
        --phylogeny="$NEWICK_FILE" \
        --output="$OUTPUT_XML_FILE"

    # Check if the command was successful
    if [ $? -eq 0 ]; then
        echo "Ecosim run $i completed successfully. Output saved to $OUTPUT_XML_FILE"
    else
        echo "Ecosim run $i encountered an error."
    fi
done
