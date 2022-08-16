-- Portfolio Project 1: Cleaning "Marketing Campaign" Dataset

-- Start with creating a database 

CREATE DATABASE IF NOT EXISTS marketing_campaign;
USE marketing_campaign;

-- Import dataset using "Table Data Import Wizard"
-- Verify data imported correctly

SELECT * FROM marketing_campaign.marketing_campaign;

-- Change column names to have cleaner and/or clearer descriptions as needed

ALTER TABLE marketing_campaign.marketing_campaign RENAME COLUMN ID TO Customer_ID;
ALTER TABLE marketing_campaign.marketing_campaign RENAME COLUMN Kidhome TO Child_Home;
ALTER TABLE marketing_campaign.marketing_campaign RENAME COLUMN Teenhome TO Teen_Home;
ALTER TABLE marketing_campaign.marketing_campaign RENAME COLUMN Dt_Customer TO Enroll_Date;

-- Combine Child_Home and Teen_Home columns into one column named "Children"
-- The new column "Children" accounts for any dependents under age 17 living with the customer
-- Delete Child_Home and Teen_Home columns to avoid redundancy 

ALTER TABLE marketing_campaign.marketing_campaign ADD COLUMN Children VARCHAR(10) AFTER Teen_Home;
UPDATE marketing_campaign.marketing_campaign 
SET 
    Children = (Child_Home + Teen_Home);
ALTER TABLE marketing_campaign.marketing_campaign 
DROP COLUMN Child_Home,
DROP COLUMN Teen_Home; 

-- Check if there are any duplicates in Customer ID by comparing count values with other columns in table

SELECT COUNT(DISTINCT Customer_ID)
FROM marketing_campaign.marketing_campaign;
-- 2240 unique Customer IDs
SELECT COUNT(Year_Birth)
FROM marketing_campaign.marketing_campaign;
-- 2240 birthdates associated with customers
SELECT COUNT(*)
FROM marketing_campaign.marketing_campaign;
-- 2240 total rows counted for all columns

-- Replace empty cells with NULL values in Income column

UPDATE marketing_campaign.marketing_campaign 
SET 
    Income = IF(Income = '', NULL, Income);


    