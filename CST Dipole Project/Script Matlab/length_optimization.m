clear all
close all 
clc 
directory='./';

% List of files to read
filePattern = fullfile(directory, '*.txt'); % Use *.txt to read all text files
files = dir(filePattern); % Read the list of files matching the created pattern 

% Custom labels for the legend
customLabels = { ...
    'L=29.974 mm', ...
    'L=26.664 mm', ...
    'L=25.402 mm', ...
    'L=23.998 mm', ...
   
};

% Preparing the plot
figure;
hold on; % To overlay the plots

% For loop to read and plot the data
for i = 1:length(files)
    % Combine the file path with the file name to get the full path
    fileName = fullfile(files(i).folder, files(i).name);
    % Read data from the current file
    % The file is assumed to be a matrix format with two columns
    data = readmatrix(fileName);
    
    % Axis separation
    x = data(:, 1); % The first column represents the frequency [GHz]
    y = data(:, 2); % The second column represents the value of S_1_1 [dB]
    
    % Data plot
    plot(x, y, 'LineWidth', 1.5, 'DisplayName', customLabels{i}); % uses the file name as legend
end

% Improvements to the plot
grid on;
fontsize(20,"points");
box on;
% Set the Y-axis limits to improve visualization
ylim([-22 0]); % Set the range of Y-axis values between -22 and 0 dB
xlabel('Frequency [GHz]');
ylabel('S_1_1 [dB]');
%title('Lenght Optimization');
legend show; % It shows the legend with file names
hold off;