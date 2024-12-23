# READ ME
## Data:
The interim and raw data are stored in `\Dropbox\1-Political-Claudio-Project\data`. 

### Data Sources:
• GDP per capita: comes from the World Bank’s World Development Indicators. The series that I am
using is the constant 2015 US dollars.

• Data on values and perceptions: comes from the 7th version of the World Values Survey (WVS). The
interviews were done between 2017 and 2022.
 
• We also gathered data regarding perceptions from the Americas, Latino, Arab, African, and Euro from 2022 to 2023.

• Data on the political regime comes from the V-DEM project since 1990.

• Data regarding courts and the rule of law comes from the World Justice Project since 2013.

### Data Interim: 
There are three main data sets: 
1. `wvs_series_gdp_country_year_lvl.dta`: contains information at the country level of the WVS, V-DEM index, and GDP.
2. `barometer_22_23_country_lvl.dta`: contains information at the country level from barometers, V-DEM index, and GDP.
3. `wjp_13_24_country_lvl.dta`: contains information at the country level from WJP, V-DEM index, and GDP.

## Results: 
Results are stored in the Overleaf folder: [https://www.overleaf.com/project/66fb71ad9e2e6d9da7ddcd82] 
   
## Code Location:
To replicate the results follow the pipeline in the `0_master.do` in the `code` folder located in this repository. The pipeline is: 

| Do-file      | Description |
| ----------- | ----------- |
| `1_prepare_WVS_series.do` | Prepares the `wvs_series_gdp_country_year_lvl.dta` |
| `1_prepare_Barometers.do`   | Prepares the `barometer_22_23_country_lvl.dta` |
| `1_prepare_WJP.do`   | Prepares the `wjp_13_24_country_lvl.dta` |
| `2_scatter_coefplots_WVS_vdem.do` | Creates plots of sections 2.4 2.5 3.2 3.3 4.2 4.3 |
| `2_scatter_coefplots_Barometers_vdem.do` | Creates plots of sections 5.2 5.3 |
| `2_scatter_WVS_GDP.do` | Creates plots of sections 2.4, 3.4, 4.4 |
| `2_scatter_barometer_GDP.do` | Creates plots of sections 5.4 8.2| 
| `2_scatter_WJP_GDP.do` | Creates plots of sections 6.1 6.2 |



