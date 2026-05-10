# Data_Cleaning_-layoffs-
cleaned and standardized data using SQL

# SQL Data Cleaning Project – Layoffs Dataset

## Overview

This project focuses on cleaning and standardizing a layoffs dataset using SQL. The goal was to prepare raw data for further analysis by removing duplicates, handling null values, standardizing text fields, and formatting inconsistent data.

The project was performed using MySQL and demonstrates practical data cleaning techniques commonly used in data analytics workflows.

---

## Dataset

* **Dataset Name:** Layoffs Dataset
* **Format:** CSV
* **Tools Used:** MySQL

The dataset contains information about company layoffs, including:

* Company name
* Industry
* Location
* Total employees laid off
* Percentage laid off
* Funding raised
* Company stage
* Date of layoffs

---

## Objectives

The main objectives of this project were:

1. Remove duplicate records
2. Standardize inconsistent data
3. Handle null and blank values
4. Convert incorrect data types
5. Prepare clean data for analysis

---

## Data Cleaning Steps

### 1. Created Staging Tables

* Created staging tables to avoid modifying the original dataset.
* Inserted raw data into staging tables for cleaning.

### 2. Removed Duplicates

* Used `ROW_NUMBER()` with `PARTITION BY` to identify duplicate rows.
* Deleted duplicate entries while keeping unique records.

### 3. Standardized Data

Performed standardization on multiple columns:

* Removed extra spaces using `TRIM()`
* Standardized industry names (e.g., `Crypto Currency`, `CryptoCurrency` → `Crypto`)
* Cleaned country names (e.g., removed trailing periods from `United States.`)
* Verified location consistency

### 4. Formatted Dates

* Converted date values from text format to SQL `DATE` format using `STR_TO_DATE()`.
* Modified the column datatype accordingly.

### 5. Handled Null and Blank Values

* Replaced blank industry values with `NULL`
* Populated missing industries using self joins based on matching company names
* Removed rows where critical layoff information was missing

### 6. Final Clean Dataset

* Produced a cleaned and analysis-ready layoffs dataset.

---

## SQL Concepts Used

* `CTE (Common Table Expressions)`
* `ROW_NUMBER()` Window Function
* `PARTITION BY`
* `JOIN`
* `UPDATE`
* `DELETE`
* `ALTER TABLE`
* `STR_TO_DATE()`
* `TRIM()`

---

## Project Structure

```bash
├── layoffs.csv
├── sql_datacleaningproject_layoffs.sql
└── README.md
```

---

## Key Learnings

Through this project, I gained hands-on experience in:

* Real-world SQL data cleaning workflows
* Handling messy datasets
* Writing optimized SQL queries
* Preparing datasets for exploratory data analysis and visualization

---

## Future Improvements

* Perform exploratory data analysis (EDA)
* Create visual dashboards using Power BI or Tableau
* Build predictive insights based on layoff trends

---
