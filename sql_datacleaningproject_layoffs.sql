 select *
 from layoffs;

-- Data Cleaning
-- Aim of the project
-- 1.remove dublicates
-- 2.standardize the data
-- 3.null value or blank values
-- 4.reduce any column if possible

	CREATE TABLE layoffs_staging
    LIKE layoffs;
    
    INSERT layoffs_staging
    SELECT *
    FROM layoffs;
    
    SELECT *
    FROM layoffs_staging;
    
    -- Finding the dublicates
    
    Select *,
    ROW_NUMBER () OVER(
    PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 'date' ,stage, country, funds_raised_millions) AS row_num
    FROM layoffs_staging;
    
    
-- check if dublicate found is correct 
  SELECT *
    FROM layoffs_staging
    WHERE company=' E Inc.';
    
-- listing all the dublicates dublicates

WITH dublicate_cte as (
 Select *,
    ROW_NUMBER () OVER(
    PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 'date' ,stage, country, funds_raised_millions) AS row_num
    FROM layoffs_staging
    )
    SELECT *
    FROM dublicate_cte
    WHERE row_num > 1;
    
    
    CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
   `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

    
SELECT *
FROM layoffs_staging2;

INSERT INTO layoffs_staging2
Select *,
    ROW_NUMBER () OVER(
    PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 'date' ,stage, country, funds_raised_millions) AS row_num
    FROM layoffs_staging;
    
SELECT *
FROM layoffs_staging2
WHERE row_num >1 ;

-- Turning off safe mode temporary
SET SQL_SAFE_UPDATES = 0 ;

-- deleting dublicates
DELETE 
FROM layoffs_staging2
WHERE row_num >1 ;

-- Turning ON safe mode temporary
SET SQL_SAFE_UPDATES = 1 ;

-- CHECKING dublicates after deleting
SELECT *
FROM layoffs_staging2
WHERE row_num >1 ;
# no dublicates found

-- table with no dublicates Table layoffs_staging2
SELECT *
FROM layoffs_staging2;

-- Standardizing data
 SELECT company, TRIM(company)
FROM layoffs_staging2;

SET SQL_SAFE_UPDATES=0;

UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT *
FROM layoffs_staging2;

-- standardize industry
SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

-- checking distinct industry
select distinct industry
from layoffs_staging2
order by 1;

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- now focusing on standardizing location

select distinct location
from layoffs_staging2
order by 1;
# it's clean 

-- standardizing country

select distinct country
from layoffs_staging2
order by 1;

select country
from layoffs_staging2
where country like 'United States%';

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country )
WHERE country LIKE 'United States.' ;

-- Formate date in MM/DD/YYYY we are also changing date from text to date
SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y') AS `date_stand`
FROM layoffs_staging2 ;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y') ;

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE ;

-- Populating the industry
select *
FROM layoffs_staging2
where industry is null or industry = '';

# setting industry = null where it's blank
UPDATE layoffs_staging2
SET industry = NULL 
where industry = '' ;

# populating blank industry

UPDATE layoffs_staging2 as t1
JOIN layoffs_staging2 as t2
	ON t1.company=t2.company
SET t1.industry=t2.industry
where t1.industry is null 
and t2.industry is not null ;

-- delete one row which has no industry data
DELETE 
FROM layoffs_staging2
where company = 'Bally''s Interactive';

-- Deleting where both percentage laid off and total laid off is null
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off is null
and total_laid_off is null ;

DELETE 
FROM layoffs_staging2
WHERE percentage_laid_off is null
and total_laid_off is null ;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num ;

select *
from layoffs_staging2 ; 

-- layoffs_staging2 is our final cleaned and standardized data set
