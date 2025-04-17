-- Data Cleaning Project!!!
-- Step 1. Remove Duplicates
-- Step 2. Standardize the Data
-- Step 3. Null Values or blank values
-- Step 4. Remove unnecessary Columns

SELECT*
FROM layoffs;

-- Don't work on the raw data, create a staging and work there
CREATE TABLE layoff_staging
LIKE layoffs;

INSERT layoff_staging
SELECT*
FROM layoffS;

SELECT*
FROM layoff_staging;

-- Removing Duplicates

SELECT*,
 ROW_NUMBER() OVER (PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
FROM layoff_staging;

WITH duplicate_cte as
(
SELECT*,
 ROW_NUMBER() OVER (PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
FROM layoff_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1
;

CREATE TABLE `layoff_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoff_staging2
WHERE row_num > 1;

INSERT INTO layoff_staging2
SELECT*,
 ROW_NUMBER() OVER (PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
FROM layoff_staging;

DELETE
FROM layoff_staging2
WHERE row_num > 1;

SELECT *
FROM layoff_staging2
WHERE row_num > 1;

-- Standardising Data

SELECT company, TRIM(company)
FROM layoff_staging2;

UPDATE layoff_staging2
SET company = TRIM(company);

SELECT company
FROM layoff_staging2;

SELECT *
FROM layoff_staging2
WHERE industry LIKE 'Crypto%';



UPDATE layoff_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoff_staging2
ORDER BY 1;

UPDATE layoff_staging2
SET country = TRIM(TRAILING '.' FROM country);

SELECT DISTINCT country
FROM layoff_staging2
ORDER BY 1;

-- Changing the date format
SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoff_staging2;

UPDATE layoff_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

SELECT `date`
FROM layoff_staging2;

ALTER TABLE layoff_staging2
MODIFY COLUMN `date` DATE;

-- FIXING NULL VALUES OR BLANK VALUES
SELECT*
FROM layoff_staging2
WHERE industry IS NULL
or industry = ''
ORDER BY 1;

UPDATE layoff_staging2
SET industry = NULL
WHERE industry = '';

SELECT*
FROM layoff_staging2
WHERE company = 'Airbnb';

SELECT *
FROM layoff_staging2 as t1
JOIN layoff_staging2 as t2
	ON t1.company = t2.company
    AND t1.location = t2.location
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

UPDATE layoff_staging2 as t1
JOIN layoff_staging2 as t2
	ON t1.company = t2.company
    AND t1.location = t2.location
SET T1.industry = t2.industry
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;


-- REMOVING UNECESSARY COLUMNS OR ROWS
-- for rows
SELECT *
FROM layoff_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE
FROM layoff_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT*
FROM layoff_staging2;

-- for columns
ALTER TABLE layoff_staging2
DROP COLUMN row_num;