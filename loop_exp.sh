#!/bin/bash
model=$1
# Base directory where the YAML files are stored
base_dir="./configs/exps/"$model"_wr"

# Loop through each method
for method in "NCC" "finetune" "LR" "matchingnet" "protohead"; do
#for method in  "finetune" "LR" ; do
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
            mkdir results_wr/5-shot/"$model"/"$method"
            python main.py --cfg "$yaml_file" --save-stats results_wr/5-shot/"$model"/"$method"/"$dataset".pt
            
        done
    else
        echo "Directory for method $method and $model does not exist."
    fi
done