# Layoff Data Cleaning and Exploratory Analysis Project

Welcome! This project showcases the use of SQL for cleaning and analyzing a real-world dataset on tech layoffs. The data contains company names, layoff counts, industries, countries, dates, and more.

---

## Project Structure

The project is divided into two parts:

1. **Data Cleaning**  
   All cleaning operations were performed using SQL, focusing on removing duplicates, standardizing fields, and handling null values.

2. **Exploratory Data Analysis (EDA)**  
   Performed insightful analysis on trends over time, affected industries, companies, and countries.

---

## 🧹 Part 1: Data Cleaning

### Table: `layoffs` (Raw Data)

| Column Name             | Data Type | Description                                     |
|------------------------|-----------|-------------------------------------------------|
| `company`              | TEXT      | Name of the company                             |
| `location`             | TEXT      | Location of the company                         |
| `industry`             | TEXT      | Industry the company belongs to                 |
| `total_laid_off`       | INT       | Number of employees laid off                    |
| `percentage_laid_off`  | TEXT      | Proportion of the workforce laid off            |
| `date`                 | TEXT      | Layoff event date (in string format)            |
| `stage`                | TEXT      | Startup funding stage (e.g., Seed, Series B)    |
| `country`              | TEXT      | Country where the layoff occurred               |
| `funds_raised_millions`| INT       | Total funds raised by the company (in millions) |

---

### ✅ Cleaning Steps

- **Created a staging table**: to preserve raw data and work safely
- **Removed duplicates**: using `ROW_NUMBER()` with `PARTITION BY` key columns
- **Standardized data**:
  - Trimmed whitespace from text fields
  - Fixed inconsistent values (e.g., “Crypto”, country dots)
  - Converted string dates to proper `DATE` format
- **Handled nulls and blanks**:
  - Replaced blanks with NULL
  - Filled missing industry values using matching company/location records
- **Removed unnecessary data**:
  - Deleted rows with no layoff data
  - Dropped helper columns (e.g., `row_num`)

> 📌 Cleaned data was saved in: `layoff_staging2`

---

## 📊 Part 2: Exploratory Data Analysis

### Key Analyses Performed

- **Layoff Magnitude**:
  - Largest single-day layoff
  - Companies that laid off 100% of staff

- **Top Contributors**:
  - Companies, industries, and countries with the most layoffs
  - Breakdown by startup stage (e.g., Series A, B)

- **Trends Over Time**:
  - Date range of layoffs
  - Monthly layoffs with rolling totals
  - Yearly layoff patterns

- **Company-Specific Trends**:
  - Year-over-year layoffs by company
  - Top 5 companies with most layoffs per year using `DENSE_RANK()`

---

## 🛠️ Tools Used

- **SQL**
  - Data cleaning and transformation
  - Aggregations, window functions, and CTEs
- **MySQL** (or any compatible SQL engine)

---

## 📌 Project Highlights

- Demonstrates end-to-end data wrangling using only SQL
- Strong use of window functions for deduplication and ranking
- Realistic problem-solving on messy real-world data

---

## 📂 File Structure

- Data_cleaning_project.sql - SQL script for data cleaning
- Data_exploratory_project.sql - SQL script for EDA
- README.md - Project documentation (you’re here!)

