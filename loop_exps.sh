#!/bin/bash

# Base directory where the YAML files are stored
base_dir="./configs/exps"

# Loop through each method
for method in "NCC" "finetune" "LR" "matchingnet"; do
    # Path to the method's directory
    method_dir="$base_dir/$method"

    # Check if the directory exists
    if [ -d "$method_dir" ]; then
        echo "Running experiments for method: $method"
        
        # Loop through each YAML file in the directory
        for yaml_file in "$method_dir"/*.yaml; do
            # Extract dataset name from the YAML filename
            dataset=$(basename "$yaml_file" .yaml)

            echo "Running experiment with config: $yaml_file"
            # Run the Python command with the YAML configuration
            python main.py --cfg "$yaml_file" --save-stats "${method}_${dataset}.pt"
        done
    else
        echo "Directory for method $method does not exist."
    fi
done
