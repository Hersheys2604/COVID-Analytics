clear all; close all; clc; fclose all;
%Importing all the data from the owid-covid-data_2020-21.csv csv file
covid_data = importdata("owid-covid-data_2020-21.csv");

%Sorting the data into numerical data and text data.
num_data = covid_data.data;
text_data = string(covid_data.textdata);

%Chaning all the NaN values in the imported num_data to 0. Showing proof
%that all has been changed.
NaN_values = isnan(num_data);
num_data(NaN_values) = 0;
changed_isNAN_proof = find(isnan(num_data),1);

%Categorising the imported num_data nd text_data into their respective
%columns.
iso_code = text_data(2:end,1);
continent = text_data(2:end,2);
location = text_data(2:end,3);
date = text_data(2:end,4);
days_tracked = num_data(:,1);
total_cases = num_data(:,2);
total_deaths = num_data(:,3);
colheaders = text_data(1,:);

%Finding all the unique countries in the provided data and finding the
%number of entries each country has in the provided data.
country_names = unique(location,'stable');
index_1 = 1;
for country_num = 1:length(country_names)
    entries_per_country(index_1) = length(find(location == country_names(country_num)));
    index_1 = index_1 + 1;
end

%Finding all the countries that dont have the required amount of entries:
%396.
required_entries = 396;
non_396_entries = logical(entries_per_country ~= required_entries);
countries_without_req_entries = country_names(non_396_entries);

%For each country that doesnt have the required amount of countries, we are
%finding their recorded start date, their recorded end date and the total
%number of recoderded entries they actually have. We will be printing this
%later.
index_2 = 1;
for non_396_country_num = 1:length(countries_without_req_entries)
    all_dates = date(location == countries_without_req_entries(non_396_country_num));
    start_date(index_2) = all_dates(1,1);
    end_date(index_2) = all_dates(end,1);
    num_records(index_2) = length(all_dates);
    index_2 = index_2 + 1;
end
%Putting the values found in the for loop above into a matrix for printing
%purposes later.
countries_non_req_entries_table = [countries_without_req_entries,transpose(start_date),transpose(end_date),transpose(num_records)];

% Creating a new corrected days tracked variable that acts as a running
% counter representing the day number of each countries recorded covid case
% details (in the right format this time). This is done using the recorded
% start and end date of each country's enries.
corrected_days_tracked = [];
for country_num = 1:length(country_names)
    all_dates_datetime = datetime(date(location == country_names(country_num)),'InputFormat','dd/MM/yy');
    no_days = days(all_dates_datetime(end) - all_dates_datetime(1));
    entry_start = required_entries - no_days;
    counter = entry_start;
    corrected_days_tracked = [corrected_days_tracked;entry_start];
    counter = counter + 1;
    for x = entry_start+1:required_entries
        corrected_days_tracked = [corrected_days_tracked;counter];
        counter = counter + 1;
    end
end
%Finding all the unique countries in the provided data and finding the
%number of entries each country has in the provided data.
country_names = unique(location,'stable');
index_1 = 1;
for country_num = 1:length(country_names)
    entries_per_country(index_1) = length(find(location == country_names(country_num)));
    index_1 = index_1 + 1;
end

%Finding all the countries that dont have the required amount of entries:
%396.
required_entries = 396;
non_396_entries = logical(entries_per_country ~= required_entries);
countries_without_req_entries = country_names(non_396_entries);%For each country that doesnt have the required amount of countries, we are
%finding their recorded start date, their recorded end date and the total
%number of recoderded entries they actually have. We will be printing this
%later.
index_2 = 1;
for non_396_country_num = 1:length(countries_without_req_entries)
    all_dates = date(location == countries_without_req_entries(non_396_country_num));
    start_date(index_2) = all_dates(1,1);
    end_date(index_2) = all_dates(end,1);
    num_records(index_2) = length(all_dates);
    index_2 = index_2 + 1;
end
%Putting the values found in the for loop above into a matrix for printing
%purposes later.
countries_non_req_entries_table = [countries_without_req_entries,transpose(start_date),transpose(end_date),transpose(num_records)];

% Creating a new corrected days tracked variable that acts as a running
% counter representing the day number of each countries recorded covid case
% details (in the right format this time). This is done using the recorded
% start and end date of each country's enries.
corrected_days_tracked = [];
for country_num = 1:length(country_names)
    all_dates_datetime = datetime(date(location == country_names(country_num)),'InputFormat','dd/MM/yy');
    no_days = days(all_dates_datetime(end) - all_dates_datetime(1));
    entry_start = required_entries - no_days;
    counter = entry_start;
    corrected_days_tracked = [corrected_days_tracked;entry_start];
    counter = counter + 1;
    for x = entry_start+1:required_entries
        corrected_days_tracked = [corrected_days_tracked;counter];
        counter = counter + 1;
    end
end

%Creating a new matrix 'date' with all the dates in the original data as
%datetime objects.
date = datetime(text_data(2:end,4),'InputFormat','dd/MM/uuuu');
%Finding the name of evry continent in the data provided.
continent_names = unique(continent,'stable');

%Finding the total number of cases each day in each continent by looping 
%through each date and finding out all the entries in that specific date and
%categorising them into their respectve continents. Creating a new matrix
%with all the information about COVID Cases every day in each continent.
index_1 = 0;
for continent_num = 1:length(continent_names)
    index_1 = index_1 + 1;
    index_2 = 1;
    for day_no = datetime('1/8/20',"InputFormat","dd/MM/uuuu"):datetime('31/8/21',"InputFormat","dd/MM/uuuu")
        dates_specific_continent = date(continent == continent_names(continent_num));
        total_cases_continent = total_cases(continent == continent_names(continent_num));
        total_cases_per_continent(index_2,index_1) = sum(total_cases_continent(dates_specific_continent == day_no));
        index_2 = index_2 + 1;
    end
end

%Finding the total number of Deaths each day in each continent by looping 
%through each date and finding out all the entries in that specific date and
%categorising them into their respectve continents. Creating a new matrix
%with all the information about COVID Deaths every day in each continent.
index_3 = 0;
for continent_num = 1:length(continent_names)
    index_3 = index_3 + 1;
    index_4 = 1;
    for day_no = datetime('1/8/20',"InputFormat","dd/MM/uuuu"):datetime('31/8/21',"InputFormat","dd/MM/uuuu")
        dates_specific_continent = date(continent == continent_names(continent_num));
        total_deaths_continent = total_deaths(continent == continent_names(continent_num));
        total_deaths_per_continent(index_4,index_3) = sum(total_deaths_continent(dates_specific_continent == day_no));
        index_4 = index_4 + 1;
    end
end

%Print results
fprintf('Please take a look at Figure 1\n')
%You should have produced one figure window by the end of this task.
% Plotting the Total Daily Accumalated Cases in Each Continent in the first
% subplot
figure(1)
day_no = 1:length(total_cases_per_continent);
subplot(1,2,1)
for index_no = 1:length(continent_names)
    hold on
    plot(day_no,total_cases_per_continent(:,index_no))
end
legend(sprintf('Total cases in %s',continent_names(1)),sprintf('Total cases in %s',continent_names(2)),sprintf('Total cases in %s',continent_names(3)),sprintf('Total cases in %s',continent_names(4)),sprintf('Total cases in %s',continent_names(5)),sprintf('Total cases in %s',continent_names(6)),Location="best")
xlabel('Days Tracked')
ylabel('Total Daily Accumalated Cases')
set(gca, 'YScale','log') %Setting the y-axis scale to logarithm scale
title('Total Daily Accumalated Cases in Each Continent')

% Plotting the Total Daily Accumalated Deaths in Each Continent in the
% second sublot
subplot(1,2,2)
for index_no = 1:length(continent_names)
    hold on
    plot(day_no,total_deaths_per_continent(:,index_no))
end
legend(sprintf('Total deaths in %s',continent_names(1)),sprintf('Total deaths in %s',continent_names(2)),sprintf('Total deaths in %s',continent_names(3)),sprintf('Total deaths in %s',continent_names(4)),sprintf('Total deaths in %s',continent_names(5)),sprintf('Total deaths in %s',continent_names(6)),Location="best")
xlabel('Days Tracked')
ylabel('Total Daily Accumalated Deaths')
set(gca, 'YScale','log') %Setting the y-axis scale to logarithm scale
title('Total Daily Accumalated Deaths in Each Continent')

%Importing all the population data given to us in Population_data.xlsx
population_data = importdata("Population_data.xlsx");

%Splitting the data imported int relevant parts.
population_per_country = (population_data.data);
location_population = population_data.textdata(2:end,2);

%Finding ou all the unique continents in the first imported data in 1a.
continent_names = unique(continent,'stable');

%Finding the total population of each country then fiding what continent
%that country belongs to then adding teh country's population to the
%continent's overall population.
index_1 = 2;
index_2 = 2;
index_3 = 2;
index_4 = 2;
index_5 = 2;
index_6 = 2;
for country_num = 1:length(country_names)
    continent_of_country = continent(find(location==country_names(country_num)));
    if continent_of_country == continent_names(1)
        continent_country(1,1) = continent_names(1);
        continent_country(index_1,1) = country_names(country_num);
        population_total(1,1) = 1;
        population_1(index_1) = population_per_country(country_names(country_num)==location_population);
        population_total(2,1) = sum(population_1);
        index_1 = index_1 + 1;
    elseif continent_of_country == continent_names(2)
        continent_country(1,2) = continent_names(2);
        continent_country(index_2,2) = country_names(country_num);
        population_total(1,2) = 2;
        population_2(index_2) = population_per_country(country_names(country_num)==location_population);
        population_total(2,2) = sum(population_2);
        index_2 = index_2 + 1;
    elseif continent_of_country == continent_names(3)
        continent_country(1,3) = continent_names(3);
        continent_country(index_3,3) = country_names(country_num);
        population_total(1,3) = 3;
        population_3(index_3) = population_per_country(country_names(country_num)==location_population);
        population_total(2,3) = sum(population_3);
        index_3 = index_3 + 1;
    elseif continent_of_country == continent_names(4)
        continent_country(1,4) = continent_names(4);
        continent_country(index_4,4) = country_names(country_num);
        population_total(1,4) = 4;
        population_4(index_4) = population_per_country(country_names(country_num)==location_population);
        population_total(2,4) = sum(population_4);
        index_4 = index_4 + 1; 
    elseif continent_of_country == continent_names(5)
        continent_country(1,5) = continent_names(5);
        continent_country(index_5,5) = country_names(country_num);
        population_total(1,5) = 5;
        population_5(index_5) = population_per_country(country_names(country_num)==location_population);
        population_total(2,5) = sum(population_5);
        index_5 = index_5 + 1;
    elseif continent_of_country == continent_names(6)
        continent_country(1,6) = continent_names(6);
        continent_country(index_6,6) = country_names(country_num);
        population_total(1,6) = 6;
        population_6(index_6) = population_per_country(country_names(country_num)==location_population);
        population_total(2,6) = sum(population_6);
        index_6 = index_6 + 1; 
    end
end
%Opening world_map.bmp to shade in relative covid cases per million
%population for each countinent
world_map_cases = imread("world_map.bmp");

% Finding the ratio of total COVID cases per million population for each
% continent.
ratio_cases(1) = total_cases_per_continent(end,1)/population_total(2,1);
ratio_cases(2) = total_cases_per_continent(end,2)/population_total(2,2);
ratio_cases(3)= total_cases_per_continent(end,3)/population_total(2,3);
ratio_cases(4)= total_cases_per_continent(end,4)/population_total(2,4);
ratio_cases(5) = total_cases_per_continent(end,5)/population_total(2,5);
ratio_cases(6) = total_cases_per_continent(end,6)/population_total(2,6);

% Using the ratio of total COVID cases per million population for each
% continent to find out the approprate shade for each country (with the
% highest beeing 255). Setting the shade of the oceans to 100 for better
% visualisation
world_map_cases(world_map_cases == 1) = (ratio_cases(1)/max(max(ratio_cases))) * 255;
world_map_cases(world_map_cases == 2) = (ratio_cases(2)/max(max(ratio_cases))) * 255;
world_map_cases(world_map_cases == 3) = (ratio_cases(3)/max(max(ratio_cases))) * 255;
world_map_cases(world_map_cases == 4) = (ratio_cases(4)/max(max(ratio_cases))) * 255;
world_map_cases(world_map_cases == 5) = (ratio_cases(5)/max(max(ratio_cases))) * 255;
world_map_cases(world_map_cases == 6) = (ratio_cases(6)/max(max(ratio_cases))) * 255;
world_map_cases(world_map_cases == 0) = 100;

%Putting all the shade ranges found above into a matrix for printing
%purposes later.
shade_range_cases = [(ratio_cases(1)/max(max(ratio_cases))) * 255, ...
    (ratio_cases(2)/max(max(ratio_cases))) * 255, (ratio_cases(3)/max(max(ratio_cases))) * 255, ...
    (ratio_cases(4)/max(max(ratio_cases))) * 255,...
    (ratio_cases(5)/max(max(ratio_cases))) * 255,...
    (ratio_cases(6)/max(max(ratio_cases))) * 255];

% Finding the ratio of total COVID deaths per million population for each
% continent.
world_map_deaths = imread("world_map.bmp");
ratio_deaths(1) = total_deaths_per_continent(end,1)/population_total(2,1);
ratio_deaths(2) = total_deaths_per_continent(end,2)/population_total(2,2);
ratio_deaths(3)= total_deaths_per_continent(end,3)/population_total(2,3);
ratio_deaths(4)= total_deaths_per_continent(end,4)/population_total(2,4);
ratio_deaths(5) = total_deaths_per_continent(end,5)/population_total(2,5);
ratio_deaths(6) = total_deaths_per_continent(end,6)/population_total(2,6);

% Using the ratio of total COVID deaths per million population for each
% continent to find out the approprate shade for each country (with the
% highest beeing 255). Setting the shade of the oceans to 100 for better
% visualisation
world_map_deaths(world_map_deaths == 1) = (ratio_deaths(1)/max(max(ratio_deaths))) * 255;
world_map_deaths(world_map_deaths == 2) = (ratio_deaths(2)/max(max(ratio_deaths))) * 255;
world_map_deaths(world_map_deaths == 3) = (ratio_deaths(3)/max(max(ratio_deaths))) * 255;
world_map_deaths(world_map_deaths == 4) = (ratio_deaths(4)/max(max(ratio_deaths))) * 255;
world_map_deaths(world_map_deaths == 5) = (ratio_deaths(5)/max(max(ratio_deaths))) * 255;
world_map_deaths(world_map_deaths == 6) = (ratio_deaths(6)/max(max(ratio_deaths))) * 255;
world_map_deaths(world_map_deaths == 0) = 100;

%Putting all the shade ranges found above into a matrix for printing
%purposes later.
shade_range_deaths = [(ratio_deaths(1)/max(max(ratio_deaths))) * 255,...
    (ratio_deaths(2)/max(max(ratio_deaths))) * 255, (ratio_deaths(3)/max(max(ratio_deaths))) * 255, ...
    (ratio_deaths(4)/max(max(ratio_deaths))) * 255, (ratio_deaths(5)/max(max(ratio_deaths))) * 255, ...
    (ratio_deaths(6)/max(max(ratio_deaths))) * 255];



%Print results
fprintf('Continent Names           %s      %13s      %11s      %14s      %11s     %6s\n',transpose(continent_names))
fprintf('Ratio cases/population    %g      %11g      %11g      %10g      %13g     %10g\n',ratio_cases)
fprintf('Shade Range (Cases)       %3g      %12g      %11g      %11g      %13g     %9g\n',round(shade_range_cases))
fprintf('\n')
fprintf('Continent Names           %s      %13s      %11s      %14s      %11s     %6s\n',transpose(continent_names))
fprintf('Ratio deaths/population   %g      %11g      %11g    %12g      %13g     %10g\n',ratio_deaths)
fprintf('Shade Range (Deaths)      %3g      %12g      %11g      %11g      %13g     %9g\n',round(shade_range_deaths))
fprintf('\nPlease take a look at Figure 2\n')
%You should have produced one figure window by the end of this task.
figure(2)
%Plotting COVID cases per million popultion in each continent as shades in
%a world map in subplot 1.
subplot(2,1,1)
imshow(world_map_cases)
colorbar('Ticks',[0,100,255], ...
    TickLabels={sprintf('%g COVID Cases per million population (shade - 9)',min(min(ratio_cases))), 'Shade of Oceans (Please Disregard)',...
    sprintf('%g COVID Cases per million population (shade - 255)',max(max(ratio_cases)))})
xlabel('Lighter shade means more cases per million popolation (disregard ocean shade (100) from shade range)')
title('Map showing cases per million population for each continent')

%Plotting COVID deaths per million popultion in each continent as shades in
%a world map in subplot 1.
hold on
subplot(2,1,2)
imshow(world_map_deaths)
colorbar('Ticks',[0,100,255], ...
    TickLabels={sprintf('%g COVID Deaths per million population (shade - 4)',min(min(ratio_deaths))), 'Shade of Oceans (Please Disregard)', ...
    sprintf('%g COVID Deaths per million population (shade - 255)',max(max(ratio_deaths)))})
title('Map showing deaths per million population for each continent')
xlabel('Lighter shade means more deaths per million popolation (disregard ocean shade (100) from shade range)')

