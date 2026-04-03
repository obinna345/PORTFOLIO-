# COVID-19 Data Exploration Using SQL

## 📌 Project Overview

This project focuses on exploring and analyzing COVID-19 data using SQL.
The dataset includes information on cases, deaths, and vaccinations
across different countries and continents.

The goal of this analysis is to derive meaningful insights such as
infection rates, death percentages, and vaccination progress worldwide.

------------------------------------------------------------------------

## 🗂️ Dataset Description

### coviddeaths

-   Contains data on COVID-19 cases and deaths
-   Key columns:
    -   location
    -   date
    -   total_cases
    -   new_cases
    -   total_deaths
    -   population
    -   continent

### covidvaccination

-   Contains vaccination data
-   Key columns:
    -   location
    -   date
    -   new_vaccinations

------------------------------------------------------------------------

## 🔍 Key Analysis Performed

### 1. Basic Data Exploration

-   Retrieved and sorted data from both tables
-   Selected relevant columns for analysis

### 2. Death Percentage Analysis

-   Calculated likelihood of death after contracting COVID-19:
    (total_deaths / total_cases) \* 100

### 3. Cases vs Population

-   Measured infection impact relative to population size
-   Calculated percentage of population affected

### 4. Highest Infection Rates by Country

-   Identified countries with the highest infection rates:
    MAX(total_cases / population) \* 100

### 5. Highest Death Counts

-   Ranked countries based on total deaths
-   Excluded aggregate rows using: WHERE continent IS NOT NULL

### 6. Death Count by Continent

-   Aggregated death counts at the continent level

### 7. Global Trends Over Time

-   Daily global totals:
    -   New cases
    -   New deaths
    -   Death percentage

### 8. Overall Global Summary

-   Total global cases and deaths
-   Overall death percentage

### 9. Joining Datasets

-   Combined deaths and vaccination tables

### 10. Vaccination Progress Analysis

-   Used window functions to calculate rolling vaccinations:
    SUM(new_vaccinations) OVER (PARTITION BY location ORDER BY date)

### 11. Common Table Expression (CTE)

-   Simplified complex calculations using a CTE
-   Calculated percentage of vaccinated population

### 12. View Creation

-   Created a reusable SQL view: PercentPopulationVaccinated

------------------------------------------------------------------------

## 📊 Key Insights

-   Infection rates vary significantly across countries
-   Death percentages provide insight into healthcare effectiveness
-   Vaccination rollout trends differ widely by region
-   Window functions are powerful for tracking cumulative metrics

------------------------------------------------------------------------

## 🛠️ Tools Used

-   SQL
-   Window Functions
-   Common Table Expressions (CTEs)
-   Views

------------------------------------------------------------------------

## 🚀 How to Use

1.  Import the datasets into your SQL environment
2.  Run the queries step-by-step
3.  Modify filters (e.g., by country or continent)
4.  Use the created view for visualization in tools like Power BI or
    Tableau

------------------------------------------------------------------------




