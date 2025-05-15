clear all;
close all;
clc;

% data for Class A
data_A = [
0.030000000000000 40.000000000000;
0.23000000000000 40.000000000000;
0.23000000000000 47.000000000000;
1.0000000000000	47.000000000000;
7.0000000000000	47.000000000000;
];

%extraction of the columns from the read data
x_A = data_A(:, 1); % the first column represents the frequency in GHz
y_A = data_A(:, 2); % the second column represents the magnitudine in dB(μV/m)

% data for Class B
data_B = [
0.030000000000000 30.000000000000;
0.23000000000000 30.000000000000;
0.23000000000000 37.000000000000;
1.0000000000000	37.000000000000;
7.0000000000000	37.000000000000;
];

%extraction of the columns from the read data
x_B = data_B(:, 1); % the first column represents the frequency in GHz
y_B = data_B(:, 2); % the second column represents the magnitudine in dB(μV/m)

% data for radiated electric field (RE)
data_RE = [
3.0000000000000	-200.00000000000;
3.0000000000000	-200.00000000000;
3.5000000000000	-200.00000000000;
4.0000000000000	-200.00000000000;
4.5000000000000	-200.00000000000;
5.0000000000000	-200.00000000000;
5.0000000000000	-200.00000000000;
5.5000000000000	-200.00000000000;
6.0000000000000	-200.00000000000;
6.5000000000000	-200.00000000000;
7.0000000000000	-200.00000000000;
7.0000000000000	-200.00000000000;
]

%extraction of the columns from the read data
x_RE = data_RE(:, 1); % the first column represents the frequency in GHz
y_RE = data_RE(:, 2); % the second column represents the magnitudine in dB(μV/m)

% Plot creation
figure;

% Plotting Class A graph
plot(x_A, y_A, '--', 'LineWidth', 1.5, 'Color', 'r', 'DisplayName', 'Class A Limit at 10 m'); 
fontsize(20,"points");
hold on; % It keeps the figure opened for another plot

% Plotting Class B graph
plot(x_B, y_B, '--', 'LineWidth', 1.5, 'Color', 'g', 'DisplayName', 'Class B Limit at 10 m');
fontsize(20,"points");

% Plotting radiated electric field (RE) graph 
plot(x_RE, y_RE, '-o', 'LineWidth', 1.5, 'MarkerSize', 6, 'Color', 'b', 'DisplayName', 'Radiated E-field at 10 m');
fontsize(20,"points");

% Customizing the plot 
Efield = [47, 37, 0, -50, -100, -150, -200]; % Reference values for the Y-axis ticks

% Set the Y-axis ticks in ascending order
yticks(sort(Efield, 'ascend'));
yticklabels(string(sort(Efield, 'ascend')));

% Customizing the plot
grid on;
box on;
xlim([2.5 7]); % Set the X-axis data between 2.5 GHz and 7 GHz
xlabel('Frequency [GHz]'); % X-axis label- frequency 
ylabel('Radiated E-Field [dB_{\mu V/m}]'); % Y-axis label- radiated electric field
%title('Comparison of Class A, Class B, and EMC - Magnitude over Frequency');
legend('show'); % It shows the legend to identify the curves
hold off;

