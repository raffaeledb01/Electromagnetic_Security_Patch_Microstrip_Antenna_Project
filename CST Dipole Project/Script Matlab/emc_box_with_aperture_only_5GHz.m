clear all;
close all;
clc;

% data for Class A
data_A = [
0.030000000000000 40.000000000000
0.23000000000000 40.000000000000
0.23000000000000 47.000000000000
20.0000000000000 47.000000000000
];

% extraction of the columns from the read data
x_A = data_A(:, 1); % the first column represents the frequency in GHz
y_A = data_A(:, 2); % the second column represents the magnitudine in dB(μV/m)

%data for Class B
data_B = [
0.030000000000000 30.000000000000
0.23000000000000 30.000000000000
0.23000000000000 37.000000000000
20.0000000000000 37.000000000000
];

% extraction of the columns from the read data
x_B = data_B(:, 1); % the first column represents the frequency in GHz
y_B = data_B(:, 2); % the second column represents the magnitudine in dB(μV/m)

% Vector of apertures in mm
aperture = [19.98, 14.99, 9.99, 7.49, 5.99, 4.99, 3.75, 2.50, 1.87];
% E-field values in dB(μV/m) corresponding to 5 GHz
Efield = [68.76, 61.36, 49.95, 41.87, 35.60, 29.90, 21.60, 8.87, -2.23];
 
% Sort the data to ensure correct interpolation
[aperture, idx] = sort(aperture, 'descend');
Efield = Efield(idx);
 
% Create an aperture vector for interpolation
aperture_fine = linspace(min(aperture), max(aperture), 200);
 
% Interpolate the data using the 'spline' method
Efield_interpolated = interp1(aperture, Efield, aperture_fine, 'spline');
 
% Plot the graph
figure;
hold on; grid on; box on;

% Plot Class A
%plot(x_A, y_A, '--', 'LineWidth', 1.5, 'Color', 'r', 'DisplayName', 'Class A'); 
%hold on; % It keeps the figure opened for another plot

% Plot Class B
%plot(x_B, y_B, '--', 'LineWidth', 1.5, 'Color', 'g', 'DisplayName', 'Class B');

% Original points
plot(aperture, Efield, 'bo', 'LineWidth', 1.5, 'MarkerSize', 6, 'HandleVisibility', 'off');
 
% Interpolated curve
plot(aperture_fine, Efield_interpolated, 'b-', 'LineWidth', 1.5, 'HandleVisibility', 'off' );

% Manually add the -o symbol only in the legend
plot(nan, nan, '-ob', 'LineWidth', 1.5, 'DisplayName', 'Radiated E-field at 10 m');
 
xlim([1.5 20.1]);
% Find the interception ponts for Class A and Class B lines
y_limit_A = 47; % Class A value
y_limit_B = 37; % Class B value
 
% Find the indices where the interpolated curve crosses the thresholds
idx_A = find(abs(Efield_interpolated - y_limit_A) == min(abs(Efield_interpolated - y_limit_A)), 1);
idx_B = find(abs(Efield_interpolated - y_limit_B) == min(abs(Efield_interpolated - y_limit_B)), 1);

% Find the intersection points with thresholds 37 and 47 using linear interpolation
x_int_A = interp1(Efield_interpolated, aperture_fine, y_limit_A, 'linear');
x_int_B = interp1(Efield_interpolated, aperture_fine, y_limit_B, 'linear');

% Extract the coordinates of the intersection points
%x_int_A = aperture_fine(idx_A);
y_int_A = Efield_interpolated(idx_A);
 
%x_int_B = aperture_fine(idx_B);
y_int_B = Efield_interpolated(idx_B);



%ticks for y axis
yticks(sort(Efield, 'ascend'));
yticklabels(string(sort(Efield, 'ascend')));

% ticks for x axis
xticks(sort(aperture, 'ascend'));
xticklabels(string(sort(aperture, 'ascend')));

% point of intersection
plot(x_int_A, y_limit_A, 'ro', 'MarkerSize', 8, 'LineWidth', 2, 'DisplayName', 'Intersection with Class A Limit at 10 m');
plot(x_int_B, y_limit_B, 'go', 'MarkerSize', 8, 'LineWidth', 2, 'DisplayName', 'Intersection with Class B Limit at 10 m');
 
% coordinate y label
text(x_int_A, y_limit_A + 0.3, sprintf('y: %.2f ', y_limit_A), ...
    'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'Color', 'k');
 
text(x_int_B, y_limit_B + 0.3, sprintf('y: %.2f  ', y_limit_B), ...
    'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'Color', 'k');

% coordinate x label
text(x_int_A - 0.24, y_limit_A + 3.5, sprintf('x: %.2f ', x_int_A), ...
    'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'Color', 'k');
 
text(x_int_B - 0.24, y_limit_B + 3.5, sprintf('x: %.2f  ', x_int_B), ...
    'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'Color', 'k');

 
% lines for class A and B CISPR limits
yline(y_limit_A, '--r', 'DisplayName', 'Class A Limit at 10 m');
yline(y_limit_B, '--g', 'DisplayName', 'Class B Limit at 10 m');
fontsize(20,"points");


xlabel('Aperture Side [mm]');
ylabel('Radiated E-Field at 5GHz [dB_{\mu V/m}]');
%title('E-Field at 5GHz as a function of the aperture');
legend('Location', 'best');
hold off;