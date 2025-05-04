SELECT * 
FROM layoffs_new2;

SELECT MAX(total_laid_off) 
FROM layoffs_new2;

-- Looking at Percentage to see how big these layoffs were
SELECT MAX(percentage_laid_off) Max_percentage,  MIN(percentage_laid_off) Min_percentage
FROM layoffs_new2
WHERE  percentage_laid_off IS NOT NULL;

-- companies had 1 which is basically 100 percent of they company laid off
SELECT L.company,L.location,L.country, L.funds_raised_millions, L.industry, L.stage
FROM layoffs_new2 L
WHERE  percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

-- Companies with the most Total Layoffs
SELECT company, SUM(total_laid_off) Total_laid_off
FROM layoffs_new2
GROUP BY company
ORDER BY 2 DESC
LIMIT 10;

-- by location
SELECT location, SUM(total_laid_off) Total_laid_off
FROM layoffs_new2
GROUP BY location
ORDER BY 2 DESC
LIMIT 10;

-- by Date
SELECT Year(L.date) 'Year', SUM(total_laid_off) Total_laid_off
FROM layoffs_new2 L
Where Year(L.date)  IS NOT NULL
GROUP BY Year(L.date)
ORDER BY 1 ;

-- by industry
SELECT industry, SUM(total_laid_off) Total_laid_off
FROM layoffs_new2
GROUP BY industry
ORDER BY 2 DESC
LIMIT 10;

-- by Stage
SELECT stage, SUM(total_laid_off) Total_laid_off
FROM layoffs_new2
GROUP BY stage
ORDER BY 2 DESC
LIMIT 10;

-- Top 3 company Total laid off Every year
 
WITH Company_Year AS 
(
  SELECT company, YEAR(date) AS years, SUM(total_laid_off) AS total_laid_off
  FROM layoffs_new2
  GROUP BY company, YEAR(date)
)
, Company_Year_Rank AS (
  SELECT company, years, total_laid_off, DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
  FROM Company_Year
)
SELECT company, years, total_laid_off, ranking
FROM Company_Year_Rank
WHERE ranking <= 3
AND years IS NOT NULL
ORDER BY years ASC, total_laid_off DESC;














































































































