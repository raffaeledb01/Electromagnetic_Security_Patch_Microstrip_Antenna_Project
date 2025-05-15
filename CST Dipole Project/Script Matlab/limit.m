% Class A
classe_A_CISPR = [
30.000000000000 40.000000000000;
230.00000000000 40.000000000000;
230.00000000000 47.000000000000;
1000.0000000000	47.000000000000;
];

x_A_CISPR = classe_A_CISPR(:, 1); % Frequency in MHz
y_A_CISPR = classe_A_CISPR(:, 2); % Magnitude in dB(μV/m)

classe_A_FCC = [
30.000000000000 39.000000000000;
88.000000000000 39.000000000000;
88.000000000000 43.500000000000;
216.00000000000 43.500000000000;
216.00000000000 46.400000000000;
960.00000000000 46.400000000000;
960.00000000000 49.500000000000;
1000.0000000000 49.500000000000;
];

x_A_FCC = classe_A_FCC(:, 1); % Frequency in MHz
y_A_FCC = classe_A_FCC(:, 2); % Magnitude in dB(μV/m)

% Class B
classe_B_CISPR = [
30.000000000000 30.000000000000;
230.00000000000 30.000000000000;
230.00000000000 37.000000000000;
1000.0000000000	37.000000000000;
];

x_B_CISPR = classe_B_CISPR(:, 1); % Frequency in MHz
y_B_CISPR = classe_B_CISPR(:, 2); % Magnitude in dB(μV/m)

classe_B_FCC = [
30.000000000000 29.500000000000;
88.000000000000 29.500000000000;
88.000000000000 33.000000000000;
216.00000000000 33.000000000000;
216.00000000000 35.500000000000;
960.00000000000 35.500000000000;
960.00000000000 43.500000000000;
1000.0000000000 43.500000000000;
];

x_B_FCC = classe_B_FCC(:, 1); % Frequency in MHz
y_B_FCC = classe_B_FCC(:, 2); % Magnitude in dB(μV/m)

figure;

% Plot Class A CISPR
plot(x_A_CISPR, y_A_CISPR, '--r', 'LineWidth', 1.5, 'DisplayName', 'Class A CISPR Limit at 10 m');
fontsize(20,"points");
hold on;

% Plot Class B CISPR
plot(x_B_CISPR, y_B_CISPR, '--g', 'LineWidth', 1.5, 'DisplayName', 'Class B CISPR Limit at 10 m');
fontsize(20,"points");

Efield_CISPR = [30, 37, 40, 47];

f_CISPR = [30, 230];

% Defining the ticks on the Y-axis
yticks(sort(Efield_CISPR, 'ascend'));
yticklabels(string(sort(Efield_CISPR, 'ascend')));

% Defining the ticks on the X-axis
xticks(sort(f_CISPR, 'ascend'));
xticklabels(string(sort(f_CISPR, 'ascend')));

% Customizing the graph
grid on;
box on;
xlim([30 1000]);
ylim([20 60]);
xlabel('Frequency [MHz]');
ylabel('Radiated E-Field [dB_{\mu V/m}]');
legend('show');
hold off;

figure;

% Plot Class A FCC
plot(x_A_FCC, y_A_FCC, '--r', 'LineWidth', 1.5, 'DisplayName', 'Class A FCC Limit at 10 m'); 
fontsize(20,"points");
hold on;

% Plot Class B FCC
plot(x_B_FCC, y_B_FCC, '--g', 'LineWidth', 1.5, 'DisplayName', 'Class B FCC Limit at 10 m');
fontsize(20,"points");

f_FCC = [30, 88, 216, 960];

Efield_FCC = [29.5, 33, 35.5, 39, 43.5, 46.4, 49.5];

% Defining the ticks on the Y-axis
yticks(sort(Efield_FCC, 'ascend'));
yticklabels(string(sort(Efield_FCC, 'ascend')));

% Defining the ticks on the X-axis
xticks(sort(f_FCC, 'ascend'));
xticklabels(string(sort(f_FCC, 'ascend')));

% Customizing the graph
grid on;
box on;
xlim([30 1000]);
ylim([20 60]);
xlabel('Frequency [MHz]');
ylabel('Radiated E-Field [dB_{\mu V/m}]');
legend('show');
hold off;

