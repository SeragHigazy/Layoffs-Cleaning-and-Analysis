-- Cleaning Datat

Select * 
From layoffs;

-- 1- Remove Duplicates
-- 2- Standarize The Data
-- 3- Null Values or Blank Values


Create table layoffs_new
Like layoffs ;

Select * 
From layoffs_new;


Insert layoffs_new
Select * 
From layoffs;

Select * 
From layoffs_new;

Select * ,
ROW_NUMBER() OVER(
Partition By company, location, industry, total_laid_off, percentage_laid_off,
 date, stage, country, funds_raised_millions ) As row_num
From layoffs_new;




WITH Duplicates As 
(Select * ,
ROW_NUMBER() OVER(
Partition By company, location, industry, total_laid_off, percentage_laid_off,
 date, stage, country, funds_raised_millions ) As row_num
From layoffs_new
)
Select * 
From Duplicates
Where row_num > 1 ;


Select * 
From layoffs_new
Where company = "Yahoo";


CREATE TABLE `layoffs_new2` (
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


Select * 
From layoffs_new2;


Insert Into layoffs_new2
Select * ,
ROW_NUMBER() OVER(
Partition By company, location, industry, total_laid_off, percentage_laid_off,
 date, stage, country, funds_raised_millions ) As row_num
From layoffs_new;


DELETE 
From layoffs_new2
Where row_num > 1 ;


Select *
From layoffs_new2
Where row_num > 1 ;

Select *
From layoffs_new2 ;


-- Remove Duplicates is Done --

-- NOW 2- Standarize The Data --

Select Distinct(company) 
From layoffs_new2 ;


Update layoffs_new2 
Set Company = Trim(company) ;


Select Distinct(location) 
From layoffs_new2
Order By 1 ;





Select Distinct(industry) 
From layoffs_new2
Order By 1 ;


Select industry
From layoffs_new2
Where industry Like "crypto%" ;


Update layoffs_new2 
Set industry = "Crypto"
Where industry Like "crypto%" ; 


Select Distinct(industry)
From layoffs_new2 ;

Select Distinct(country)
From layoffs_new2
order by 1  ;


Update layoffs_new2
Set country = Trim(Trailing '.' From country)
Where country like 'United States%' ;


Select Distinct(country)
From layoffs_new2
order by 1  ;


Select date ,
str_to_date(date, '%m/%d/%Y')
From layoffs_new2;


Update layoffs_new2
Set date = str_to_date(date, '%m/%d/%Y') ;


Alter Table layoffs_new2
Modify Column date Date ;

Select *
From layoffs_new2;



-- 3- Null Values


Select *
From layoffs_new2
Where industry IS NULL
OR industry = ""
;


Select t1.industry, t2.industry
From layoffs_new2 t1
Join layoffs_new2 t2 
	ON t1.company = t2.company
Where (t1.industry IS NULL OR t1.industry = "")
AND t2.industry IS NOT NULL
;

Update layoffs_new2
Set industry = NULL
Where industry = ""
;


Update layoffs_new2 t1
Join layoffs_new2 t2 
	ON t1.company = t2.company
Set t1.industry = t2.industry
Where t1.industry IS NULL
AND t2.industry IS NOT NULL
;

Select industry 
From layoffs_new2
Where (industry IS NULL OR industry = "")
;


Select *
From layoffs_new2
Where total_laid_off IS NULL
And percentage_laid_off IS NULL
;


DELETE
From layoffs_new2
Where total_laid_off IS NULL
And percentage_laid_off IS NULL
;


Select *
From layoffs_new2
;

ALTER Table layoffs_new2
DROP COLUMN row_num
;


Select *
From layoffs_new2
;
