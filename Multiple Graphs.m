% Create the main window
fig = uifigure('Name', 'Solar Radiation GUI', 'Position', [100 100 400 400]);

% Create instruction label
instructionLabel = uilabel(fig, 'Position', [20 340 360 30], 'Text', 'Enter latitude and longitude values (in the format "(latitude, longitude)", separated by commas):', 'FontSize', 12, 'FontWeight', 'bold');

% Create latitude and longitude input field
latLongInput = uitextarea(fig, 'Position', [20 190 360 140], 'FontSize', 12);

% Create the "Generate Graph" button
generateButton = uibutton(fig, 'Position', [20 130 180 40], 'Text', 'Generate Graph', 'FontSize', 12, 'ButtonPushedFcn', @(src, event) generateButtonCallback(src, event, latLongInput));

% Create the "Download CSV" button
downloadButton = uibutton(fig, 'Position', [200 130 180 40], 'Text', 'Download CSV', 'FontSize', 12, 'ButtonPushedFcn', @(src, event) downloadButtonCallback(src, event, latLongInput));

% Callback function for the "Generate Graph" butaton
function generateButtonCallback(src, event, latLongInput)
    % Retrieve the latitude and longitude values entered by the user
    latLongValues = char(latLongInput.Value);
    
    % Split the input by comma to get latitude and longitude pairs
    inputPairs = strsplit(latLongValues, ',');
    
    % Iterate over each pair and extract latitude and longitude
    for i = 1:numel(inputPairs)
        % Get the latitude and longitude values
        latLong = strtrim(inputPairs{i});
        [latitude, longitude] = extractLatLong(latLong);
        
        % Skip invalid latitude and longitude pairs
        if isnan(latitude) || isnan(longitude)
            continue;
        end
        
        % Calculate solar radiation data
        [time, solarRadiation] = calculateSolarRadiation(latitude, longitude);

        % Plot the solar radiation graph
        figure;
        plot(time, solarRadiation);
        xlabel('Time', 'FontSize', 12);
        ylabel('Solar Radiation (W/m^2)', 'FontSize', 12);
        title(sprintf('Solar Radiation Throughout the Day\nLatitude: %f, Longitude: %f', latitude, longitude), 'FontSize', 14, 'FontWeight', 'bold');
    end
end

% Callback function for the "Download CSV" button
function downloadButtonCallback(src, event, latLongInput)
    % Retrieve the latitude and longitude values entered by the user
    latLongValues = char(latLongInput.Value);
    
    % Split the input by comma to get latitude and longitude pairs
    inputPairs = strsplit(latLongValues, ',');
    
    % Iterate over each pair and extract latitude and longitude
    for i = 1:numel(inputPairs)
        % Get the latitude and longitude values
        latLong = strtrim(inputPairs{i});
        [latitude, longitude] = extractLatLong(latLong);
        
        % Skip invalid latitude and longitude pairs
        if isnan(latitude) || isnan(longitude)
            continue;
        end
        
        % Calculate solar radiation data
        [time, solarRadiation] = calculateSolarRadiation(latitude, longitude);

        % Create a table with the data
        data = table(time', solarRadiation', 'VariableNames', {'Time', 'SolarRadiation'});
        
        % Create a unique filename based on latitude and longitude
        filename = sprintf('solar_radiation_%f_%f.csv', latitude, longitude);
        
        % Save the data as CSV
        writetable(data, filename);
        
        % Display a message to the user
        disp(['Data for Latitude: ' num2str(latitude) ', Longitude: ' num2str(longitude) ' saved as CSV successfully!']);
    end
end

% Function to extract latitude and longitude from the "(latitude, longitude)" format
function [latitude, longitude] = extractLatLong(latLong)
    % Remove the parentheses and split the string by comma
    latLong = strrep(latLong, '(', '');
    latLong = strrep(latLong, ')', '');
    latLong = strtrim(latLong);
    latLong = strsplit(latLong, ',');
    
    % Remove empty strings and convert latitude and longitude values to numbers
    latLong = strtrim(latLong);
    latLong(cellfun(@isempty, latLong)) = [];
    
    if numel(latLong) >= 2
        latitude = str2double(latLong{1});
        longitude = str2double(latLong{2});
    else
        latitude = NaN;
        longitude = NaN;
    end
end

% Function to calculate solar radiation data
function [time, solarRadiation] = calculateSolarRadiation(latitude, longitude)
    % Calculate solar radiation data
    % Replace this with your own implementation
    % Here, we generate random data for demonstration purposes
    time = 0:0.1:24; % Time in hours
    solarRadiation = rand(size(time)) * 100; % Random solar radiation data
end

% Main function to start the GUI
function main()
    % Nothing needs to be done here for this example
    % The GUI is automatically displayed when the code is run
end
