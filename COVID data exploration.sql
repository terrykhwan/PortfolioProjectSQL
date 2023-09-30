/* This is a Covid 19 Data Exploration. 
Using Joins, CTEs, Temp Tables, Windows Functions, Aggregate Functions, Creating Views and Converting Data Types */


Select *
from PortfolioProject..CovidDeaths
where continent is not null
order by 3,4


--Starting data

Select Location, date, total_cases, new_cases, total_deaths, population
from PortfolioProject..CovidDeaths
where continent is not null
order by 1,2

-- Looking at Total Cases vs Total Deaths

Select Location, date, total_cases, total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
from PortfolioProject..CovidDeaths
order by 1,2


-- Checking country of residence, likelihood of dying if infeccted

Select Location, date, total_cases, total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
from PortfolioProject..CovidDeaths
where location like '%emirates%'
order by 1,2


--Looking at total cases vs population
--Showing percentage of population infected with covid
Select Location, date, population, total_cases,(total_cases/population)*100 as PercentagePopulationInfected
from PortfolioProject..CovidDeaths
--where location like '%emirates%'
order by 1,2


-- Countries with highest infection rate compared to population

Select Location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentagePopulationInfected
from PortfolioProject..CovidDeaths
--where location like '%emirates%'
group by location, population
order by PercentagePopulationInfected DESC


--Continents with Highest death count 

Select Location,MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
--where location like '%emirates%'
where continent is null
group by Location, population
order by TotalDeathCount DESC



--Countries with Highest Death Count per population

Select Location,MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
--where location like '%emirates%'
where continent is not null
group by Location
order by TotalDeathCount DESC


--Breaking down by continent, showing highest death count by population 

Select continent,MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
--where location like '%emirates%'
where continent is not null
group by continent
order by TotalDeathCount DESC


--on a Global scale numbers 
Select date, sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(New_cases)*100 as DeathPercentage
from PortfolioProject..CovidDeaths
--where location like '%emirates%'
where continent is not null
group by date
order by 1,2


--Looking at total population vs vaccinations
--Percentage of Population received at least one Covid vaaccine

Select dea.continent, dea.location, dea.date,dea.population, vac.new_vaccinations, 
sum(convert(int, vac.new_vaccinations)) over (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and  dea.date = vac.date
where dea.continent is not null  
order by 2,3


--How many people vaccinated vs population: using CTE
With PopvsVac (continent, location, date, population,new_vaccination, RollingPeopleVaccinated)
as
(Select dea.continent, dea.location, dea.date,dea.population, vac.new_vaccinations, 
sum(convert(int, vac.new_vaccinations)) over (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and  dea.date = vac.date
where dea.continent is not null  
--order by 2,3
)
 Select*, (RollingPeopleVaccinated/population)*100
 from PopvsVac



 --Using Temp table


DROP table if exists #PercentPopulationVaccinated
Create table #PercentPopulationVaccinated
 (
 continent nvarchar(255),
 location nvarchar(255),
 date datetime,
 population numeric,
 new_vaccinations numeric,
 RollingPeopleVaccinated numeric
 )
 
Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date,dea.population, vac.new_vaccinations, 
sum(convert(int, vac.new_vaccinations)) over (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and  dea.date = vac.date
--where dea.continent is not null  
--order by 2,3


 Select*, (RollingPeopleVaccinated/population)*100
 from #PercentPopulationVaccinated

 

--Creating view to store data for later viz

Create view PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date,dea.population, vac.new_vaccinations, 
sum(convert(int, vac.new_vaccinations)) over (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and  dea.date = vac.date
where dea.continent is not null  
--order by 2,3