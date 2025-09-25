# RMaCzek_KKZMBM2023

# Code

This directory contains the R scripts used for verification experiments related to our manuscript.  
The scripts include procedures for running clustering experiments, evaluating clustering accuracy, and generating plots.  

## Files

### `experiments.R`
- Runs clustering experiments on datasets (WBC, WDBC, WPBC).  
- Implements both **exact clustering** and **fuzzy clustering** (comment/uncomment in code).  
- Performs multiple runs (default: 500 iterations) with different ordering methods:  
  - `SPIN_NH`, `OLO_ward`, `GW_ward`, `HC_ward`, `OLO_average`.  
- Saves results such as cluster order, predicted labels, and accuracy values to CSV files.  

### `metrics.R`
- Provides utility functions for evaluating clustering results.  
- `acc()`: calculates clustering accuracy by testing all permutations of cluster labels.  
- `metric()`: computes additional evaluation metrics:  
  - Accuracy, Precision, Recall, F1 score  
  - True Positive Rate (TPR), False Positive Rate (FPR)  
  - Cohen’s Kappa statistic, Matthews correlation coefficient (Phi).  

### `plots.R`
- Demonstrates how to generate clustering plots for different datasets.  
- Uses the `czek_matrix` and `plot.czek_matrix` functions to visualize results.  
- Includes example code for WBC, WDBC, and WPBC datasets.  

---

## Notes
- In the **published paper**, only the **WBC dataset** was used.  
- The WDBC and WPBC datasets are included here only for testing and verification purposes.  
- Data files should be placed in the `Data/` directory (see [Data section](../Data/README.md) for details).

## Data

This repository includes three public datasets from the UCI Machine Learning Repository.  
In the **published paper**, only **WBC** was used; **WDBC** and **WPBC** are kept here only for testing/verification.

- **WBC (Breast Cancer Wisconsin – Original)**  
  Source: <https://archive.ics.uci.edu/dataset/15/breast+cancer+wisconsin+original>  
  Files: `wbc.csv`, `wbc.names`

- **WDBC (Breast Cancer Wisconsin – Diagnostic)**  
  Source: <https://archive.ics.uci.edu/dataset/17/breast+cancer+wisconsin+diagnostic>  
  Files: `wdbc.csv`, `wdbc.names`

- **WPBC (Breast Cancer Wisconsin – Prognostic)**  
  Source: <https://archive.ics.uci.edu/dataset/16/breast+cancer+wisconsin+prognostic>  
  Files: `wpbc.csv`, `wpbc.names`

**Notes**

- The CSV/name files mirror the UCI distributions and are provided for convenience.  
- Preprocessing steps follow the scripts in `Code/` (e.g., dropping ID/label columns before modeling, simple NA filtering where noted).  
- If you prefer to download data yourself, use the UCI links above and keep the same filenames expected by the scripts.

---

## Experiment Results

Experimental outputs are organized by dataset and by result type (plots vs. metrics).  
Directory layout:

