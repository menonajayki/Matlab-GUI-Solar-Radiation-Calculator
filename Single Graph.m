% Create the main window
fig = uifigure('Name', 'Solar Radiation GUI');
fig.Position = [100 100 400 300];

% Create latitude input field
latitudeLabel = uilabel(fig, 'Position', [20 250 100 22], 'Text', 'Latitude:');
latitudeInput = uieditfield(fig, 'numeric', 'Position', [120 250 100 22]);

% Create longitude input field
longitudeLabel = uilabel(fig, 'Position', [20 200 100 22], 'Text', 'Longitude:');
longitudeInput = uieditfield(fig, 'numeric', 'Position', [120 200 100 22]);

% Create date input field
dateLabel = uilabel(fig, 'Position', [20 150 100 22], 'Text', 'Date:');
dateInput = uidatepicker(fig, 'Position', [120 150 100 22]);

% Create the "Generate Graph" button
generateButton = uibutton(fig, 'Position', [20 100 120 30], 'Text', 'Generate Graph', 'ButtonPushedFcn', @(src, event) generateButtonCallback(src, event, latitudeInput, longitudeInput, dateInput));

% Create the "Download CSV" button
downloadButton = uibutton(fig, 'Position', [160 100 120 30], 'Text', 'Download CSV', 'ButtonPushedFcn', @(src, event) downloadButtonCallback(src, event, latitudeInput, longitudeInput, dateInput));

% Callback function for the "Download CSV" button
function downloadButtonCallback(src, event, latitudeInput, longitudeInput, dateInput)
    % Retrieve the latitude, longitude, and date values entered by the user
    latitude = str2double(latitudeInput.Value);
    longitude = str2double(longitudeInput.Value);
    date = dateInput.Value;

    % Calculate solar radiation data
    [time, solarRadiation] = calculateSolarRadiation(latitude, longitude, date);
 % Create a table with the data
    data = table(time', solarRadiation', 'VariableNames', {'Time', 'SolarRadiation'});
    
    % Create a unique filename based on latitude and longitude
    filename = sprintf('solar_radiation_%f_%f.csv', latitude, longitude);
    
    % Save the data as CSV
    writetable(data, filename);
    
    % Display a message to the user
    disp('Data saved as CSV successfully!');
   
end
% Function to calculate solar radiation data
function [time, solarRadiation] = calculateSolarRadiation(latitude, longitude, date)
    % Calculate solar radiation data
    % Replace this with your own implementation
    % Here, we generate random data for demonstration purposes
    time = 0:0.1:24; % Time in hours
    solarRadiation = rand(size(time)) * 100; % Random solar radiation data
       

end
% Callback function for the "Generate Graph" button
function generateButtonCallback(src, event, latitudeInput, longitudeInput, dateInput)
    % Retrieve the latitude, longitude, and date values entered by the user
    latitude = str2double(latitudeInput.Value);
    longitude = str2double(longitudeInput.Value);
    date = dateInput.Value;

    % Calculate solar radiation data
    [time, solarRadiation] = calculateSolarRadiation(latitude, longitude, date);

    % Plot the solar radiation graph
    figure;
    plot(time, solarRadiation);
    xlabel('Time');
    ylabel('Solar Radiation (W/m^2)');
    title('Solar Radiation Throughout the Day');
end

% Call the main function to start the GUI