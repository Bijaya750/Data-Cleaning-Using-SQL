select * from
layoffs;

create table layoffs_staging
like layoffs;

select * from
layoffs_staging;

insert layoffs_staging
select * 
from layoffs;

select *,'kaushik' from layoffs;



SELECT *,
row_number() over (partition by company, location, industry, total_laid_off, 
percentage_laid_off, 'date', stage, country, funds_raised_millions) as row_num
from layoffs_staging;

select * from layoffs_staging;

with duplicate_cte as
(SELECT *,
row_number() over (partition by company, location, industry, total_laid_off, 
percentage_laid_off, 'date', stage, country, funds_raised_millions) as row_num
from layoffs_staging)

select * 
from duplicate_cte 
where row_num =1;


with unique_cte as
(SELECT *,
row_number() over (partition by company, location, industry, total_laid_off, 
percentage_laid_off, 'date', stage, country, funds_raised_millions) as row_num
from layoffs_staging)

select *
from unique_cte;

select * from
layoffs_staging
where company = 'Oyster';


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
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * from
layoffs_staging2;

insert layoffs_staging2
SELECT *,
row_number() over (partition by company, location, industry, total_laid_off, 
percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoffs_staging;

delete 
from layoffs_staging2
where row_num > 1;

select *
from layoffs_staging2
where row_num > 1;

-- Standardizing the data

select * from
layoffs_staging2;

select distinct company
from layoffs_staging2;

update layoffs_staging2
set company = trim(company);

select distinct industry 
from layoffs_staging2
order by 1;

select distinct country 
from layoffs_staging2;

update layoffs_staging2
set country = trim(Trailing '.' from country)
where country like 'United States%';

update layoffs_staging2
set `date` = str_to_date(`date`, '%m/%d/%Y');

alter table layoffs_staging2
modify column `date` date;

-- Working with null and blank values

select *
from layoffs_staging2;

update layoffs_staging2
set industry = null
where industry = '';

select *
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

select *
from layoffs_staging2
where industry is null 
or industry = '';

select *
from layoffs_staging2
where company = 'Airbnb';

select t1.industry, t2.industry
from layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company = t2.company
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;

update layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null
and t2.industry is not null;


select *
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

delete
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

select *
from layoffs_staging2;

alter table layoffs_staging2
drop column row_num;




















