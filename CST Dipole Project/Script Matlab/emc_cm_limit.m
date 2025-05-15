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

% extraction of the columns from the read data
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

% extraction of the columns from the read data
x_B = data_B(:, 1); % the first column represents the frequency in GHz
y_B = data_B(:, 2); % the second column represents the magnitudine in dB(μV/m)

% data for radiated electric field (RE)
data_RE = [
3.0000000000000	73.883633158088;
3.0000000000000	73.883633158088;
3.5000000000000	75.697306983625;
4.0000000000000	77.395646754574;
4.5000000000000	78.997673846360;
5.0000000000000	80.495782939575;
5.0000000000000	80.495782939575;
5.5000000000000	81.864318666785;
6.0000000000000	83.064282197613;
6.5000000000000	84.053643167732;
7.0000000000000	84.805123302140;
7.0000000000000	84.805123302140;
];

% extraction of the columns from the read data
x_RE = data_RE(:, 1); % the first column represents the frequency in GHz
y_RE = data_RE(:, 2); % the second column represents the magnitudine in dB(μV/m)

% Plot the graph
figure;

% Plot Class A
plot(x_A, y_A, '--', 'LineWidth', 1.5, 'Color', 'r', 'DisplayName', 'Class A Limit at 10 m'); 
fontsize(20,"points");
hold on; % It keeps the figure opened for another plot

% Plot Class B
plot(x_B, y_B, '--', 'LineWidth', 1.5, 'Color', 'g', 'DisplayName', 'Class B Limit at 10 m');
fontsize(20,"points");

% Plot RE
plot(x_RE, y_RE, '-o', 'LineWidth', 1.5, 'MarkerSize', 6, 'Color', 'b', 'DisplayName', 'CM Radiated E-field at 10 m');
 % Defining the ticks on the axis 
Efield = [47, 37, 30, 40, 50, 60, 70, 80, 90]; % Defining the tick values on the Y-axis

% Defining the ticks on the Y-axis
yticks(sort(Efield, 'ascend')); % Arrange the tick values in ascending order
yticklabels(string(sort(Efield, 'ascend'))); %converto i tick in stringhe 
% Customizing the graph
grid on;
box on;
xlim([2.5 7]); % Limit the X-axis between 2.5 GHz and 7 GHz
ylim([30 90]); % Limit the Y-axis between 30 dB and 90 dB 
xlabel('Frequency [GHz]');
ylabel('Radiated E-Field [dB_{\mu V/m}]');
%title('Comparison of Class A, Class B, and EMC - Magnitude over Frequency');
legend('show'); % It shows the legend
hold off;

