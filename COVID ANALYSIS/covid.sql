select * from coviddeaths
order by 3,4


select * from covidvaccination
order by 3,4

--select data that is going to be used

select location, date, total_cases, new_cases, total_deaths, population 
from coviddeaths
order by 1,2

-- Total cases vs Total Deaths shows possibility of dying if you get covid in your country

select location, date, total_cases,  total_deaths, (total_deaths/total_cases) * 100 as DeathPercentage
from coviddeaths
where location ilike '%japan%'
order by 1,2

--Total cases vs population
select location, date, total_cases,  Population, (total_deaths/Population) * 100 as DeathPercentage
from coviddeaths
where location ilike '%africa%'
order by 1,2

--contries with highest infection rate compared to population 

select location,  Population,  MAX(total_cases) as HighestInfectionCount,  Max(total_cases/Population) * 100 as 
PercentageInfectedPopulation
from coviddeaths
--where location ilike '%states%'
group by location, Population
order by PercentageInfectedPopulation desc

--Countries with highest death count 
select location, Max(Total_deaths) as TotalDeathCount
from coviddeaths
--where location ilike '%states%'
where continent is not null
group by location
order by TotalDeathCount desc

--death count by continent
select location, Max(Total_deaths) as TotalDeathCount
from coviddeaths
--where location ilike '%states%'
where continent is null
group by location
order by TotalDeathCount desc


-- Global Numbers

select date,sum(new_cases) as total_cases, sum(new_deaths) as total_deaths, 
sum(new_deaths)/ sum(new_cases) * 100 as DeathPercentage
from coviddeaths
where continent is not null
group by date
order by 1,2

-- Overall Number in the world

select sum(new_cases) as total_cases, sum(new_deaths) as total_deaths, 
sum(new_deaths)/ sum(new_cases) * 100 as DeathPercentage
from coviddeaths
where continent is not null
order by 1,2

-- Join the two tables 'coviddeaths' and 'covidvaccination' for more analysis

select * from coviddeaths dea
join covidvaccination vac
on dea.location = vac.location
and dea.date = vac.date

-- looking at Total Population Vs Vaccinations

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM (vac.new_vaccinations) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From CovidDeaths dea
Join CovidVaccination vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3




-- Using CTE to perform Calculation on Partition By in previous query

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From CovidDeaths dea
Join CovidVaccination vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
--order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac


-- Creating View to store data for later visualizations

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From CovidDeaths dea
Join CovidVaccination vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 




