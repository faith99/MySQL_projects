-- Exploratory Data analysis

SELECT *
FROM layoff_staging2;

-- Maximum people laid off in one day in dataset
SELECT MAX(total_laid_off)
FROM layoff_staging2;

-- Companies that completely went under, in descending order
SELECT *
FROM layoff_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;


-- Companies with the highest lay offs
SELECT company, SUM(total_laid_off)
FROM layoff_staging2
GROUP BY company
ORDER BY 2 DESC;

-- Time period of Layoffs
SELECT MIN(`date`), MAX(`date`)
FROM layoff_staging2;


-- Industries with the most layoffs
SELECT industry, SUM(total_laid_off)
FROM layoff_staging2
GROUP BY industry
ORDER BY 2 DESC;

-- countries with the most layoffs
SELECT country, SUM(total_laid_off)
FROM layoff_staging2
GROUP BY country
ORDER BY 2 DESC;

-- years with the most layoffs
SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoff_staging2
GROUP BY YEAR(`date`)
ORDER BY 2 DESC;

-- stages of companiies with the most layoffs
SELECT stage, SUM(total_laid_off)
FROM layoff_staging2
GROUP BY stage
ORDER BY 2 DESC;

-- countries with the most layoffs
SELECT country, SUM(total_laid_off)
FROM layoff_staging2
GROUP BY country
ORDER BY 2 DESC;

-- layoffs of each month
SELECT SUBSTRING(`date`, 1, 7) AS `MONTH` , SUM(total_laid_off)
FROM layoff_staging2
WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC;

WITH rolling_total as(
SELECT SUBSTRING(`date`, 1, 7) AS `MONTH` , SUM(total_laid_off) as total_off
FROM layoff_staging2
WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
)

-- Rolling total of each month
SELECT `MONTH`, total_off,
SUM(total_off) OVER(ORDER BY `MONTH`) as rolling_sum
FROM rolling_total;


-- Each company's yearly layoffs
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoff_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 1 ASC;

-- Ranking the top 5 companies with the most layoffs each year
WITH company_year (Company, Years, Total_laid_off) as
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoff_staging2
GROUP BY company, YEAR(`date`)
), company_year_rank as
(
SELECT *,
DENSE_RANK () OVER (PARTITION BY Years ORDER BY Total_laid_off DESC) as Ranking
FROM company_year
WHERE Years IS NOT NULL
)
SELECT *
FROM company_year_rank
WHERE Ranking <= 5;