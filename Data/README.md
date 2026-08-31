# Data Management & Storage Architecture

This directory contains the dataset structure, sample previews, and source documentation for the Sephora Customer Analytics Pipeline.

---

## 1. Source Dataset Access
Due to GitHub's file size limit (100 MB per file), the full raw dataset (~1.1M rows / ~350 MB) is hosted externally.

* **Dataset Source**: [Kaggle - Sephora Products and Skincare Reviews](https://kaggle.com/datasets/nadyinky/sephora-products-and-skincare-reviews)
* **Total Records**: 8,216 Products | 1,094,411 Customer Reviews
* **Time Range**: 2020 – 2023

---

## 2. Directory Layout

```text
Data/
├── Raw/
│   └── product_info.csv         # Product catalog metadata
├── processed/
│   ├── products_sample.csv      # Cleaned sample dataset (100 rows preview)
│   └── reviews_sample.csv       # Cleaned sample dataset (500 rows preview)
└── README.md                    # Data overview & dictionary
