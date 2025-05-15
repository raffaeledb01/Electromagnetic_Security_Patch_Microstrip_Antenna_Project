clear all;
close all;
clc;

% data for Class A
data_A = [
0.030000000000000 40.000000000000
0.23000000000000 40.000000000000
0.23000000000000 47.000000000000
7.0000000000000	47.000000000000
];

% extraction of the columns from the read data
x_A = data_A(:, 1); % the first column represents the frequency in GHz
y_A = data_A(:, 2); % the second column represents the magnitudine in dB(μV/m)

% data for Class B
data_B = [
0.030000000000000 30.000000000000
0.23000000000000 30.000000000000
0.23000000000000 37.000000000000
7.0000000000000	37.000000000000
];

% extraction of the columns from the read data
x_B = data_B(:, 1);  % the first column represents the frequency in GHz
y_B = data_B(:, 2);  % the second column represents the magnitudine in dB(μV/m)

% Data for the radiated electric field (RE) with an aperture of 19.98 mm
data_RE3 = [
3.0000000000000	49.800955344682
3.0000000000000	49.800955344682
3.5000000000000	55.081794234499
4.0000000000000	59.722892684606
4.5000000000000	64.547576100253
5.0000000000000	68.755693810840
5.0000000000000	68.755693810840
5.5000000000000	74.315610566202
6.0000000000000	78.643604899537
6.5000000000000	61.508853130562
7.0000000000000	77.462030890733
7.0000000000000	77.462030890733
]

% extraction of the columns from the read data
x_RE3 = data_RE3(:, 1); % the first column represents the frequency in GHz
y_RE3 = data_RE3(:, 2); % the second column represents the magnitudine in dB(μV/m)

% Data for the radiated electric field (RE) with an aperture of 14.99 mm
data_RE4 = [
3.0000000000000	43.722411651383
3.0000000000000	43.722411651383
3.5000000000000	47.843523604338
4.0000000000000	53.167663678883
4.5000000000000	57.630317684987
5.0000000000000	61.354951198442
5.0000000000000	61.354951198442
5.5000000000000	65.573261269428
6.0000000000000	73.868897342430
6.5000000000000	59.589905004319
7.0000000000000	73.016918393606
7.0000000000000	73.016918393606
]

% extraction of the columns from the read data
x_RE4 = data_RE4(:, 1); % the first column represents the frequency in GHz
y_RE4 = data_RE4(:, 2); % the second column represents the magnitudine in dB(μV/m)

% Data for the radiated electric field (RE) with an aperture of 9.99 mm
data_RE6 = [
3.0000000000000	36.529078054588
3.0000000000000	36.529078054588
3.5000000000000	38.161457442925
4.0000000000000	42.830013779564
4.5000000000000	47.022314561842
5.0000000000000	49.945341850755
5.0000000000000	49.945341850755
5.5000000000000	52.771366271080
6.0000000000000	57.275515784872
6.5000000000000	52.757520115453
7.0000000000000	63.349094132710
7.0000000000000	63.349094132710
]

% extraction of the columns from the read data
x_RE6 = data_RE6(:, 1); % the first column represents the frequency in GHz
y_RE6 = data_RE6(:, 2); % the second column represents the magnitudine in dB(μV/m)

% Data for the radiated electric field (RE) with an aperture of 7.49 mm
data_RE8 = [
3.0000000000000	26.682177809589
3.0000000000000	26.682177809589
3.5000000000000	31.135472172394
4.0000000000000	35.138794146922
4.5000000000000	38.838356414548
5.0000000000000	41.867948802207
5.0000000000000	41.867948802207
5.5000000000000	44.577504070015
6.0000000000000	47.276763826909
6.5000000000000	48.537714980834
7.0000000000000	53.208561166515
7.0000000000000	53.208561166515
]

% extraction of the columns from the read data
x_RE8 = data_RE8(:, 1); % the first column represents the frequency in GHz
y_RE8 = data_RE8(:, 2); % the second column represents the magnitudine in dB(μV/m)

% Data for the radiated electric field (RE) with an aperture of 5.99 mm
data_RE10 = [
3.0000000000000	21.153384976894
3.0000000000000	21.153384976894
3.5000000000000	24.959929354295
4.0000000000000	28.975213394914
4.5000000000000	32.720693602797
5.0000000000000	35.599308036645
5.0000000000000	35.599308036645
5.5000000000000	38.077852702265
6.0000000000000	40.725190564085
6.5000000000000	41.430011451743
7.0000000000000	47.216648699982
7.0000000000000	47.216648699982
]

% extraction of the columns from the read data
x_RE10 = data_RE10(:, 1); % the first column represents the frequency in GHz
y_RE10 = data_RE10(:, 2); % the second column represents the magnitudine in dB(μV/m)

% Data for the radiated electric field (RE) with an aperture of 4.99 mm
data_RE12 = [
3.0000000000000	15.384989778977
3.0000000000000	15.384989778977
3.5000000000000	19.323402825420
4.0000000000000	23.405131978772
4.5000000000000	27.245583943665
5.0000000000000	29.903519643427
5.0000000000000	29.903519643427
5.5000000000000	32.350331032665
6.0000000000000	35.290658812526
6.5000000000000	38.065591614435
7.0000000000000	41.632681720352
7.0000000000000	41.632681720352
]

% extraction of the columns from the read data
x_RE12 = data_RE12(:, 1); % the first column represents the frequency in GHz
y_RE12 = data_RE12(:, 2); % the second column represents the magnitudine in dB(μV/m)

% Data for the radiated electric field (RE) with an aperture of 3.75 mm
data_RE16 = [
3.0000000000000	7.4984287971583
3.0000000000000	7.4984287971583
3.5000000000000	11.095864081086
4.0000000000000	15.213864489545
4.5000000000000	18.980911792042
5.0000000000000	21.598856988163
5.0000000000000	21.598856988163
5.5000000000000	23.993878559971
6.0000000000000	26.784676310638
6.5000000000000	29.652080101428
7.0000000000000	33.251820399316
7.0000000000000	33.251820399316
]

% extraction of the columns from the read data
x_RE16 = data_RE16(:, 1); % the first column represents the frequency in GHz
y_RE16 = data_RE16(:, 2); % the second column represents the magnitudine in dB(μV/m)

% Data for the radiated electric field (RE) with an aperture of 2.50 mm
data_RE24 = [
3.0000000000000	-4.9832007433621
3.0000000000000	-4.9832007433621
3.5000000000000	-1.6115633590613
4.0000000000000	2.5592167447476
4.5000000000000	6.2572853857883
5.0000000000000	8.8682372362542
5.0000000000000	8.8682372362542
5.5000000000000	11.233800045659
6.0000000000000	13.946514124448
6.5000000000000	16.877136793557
7.0000000000000	20.582329068596
7.0000000000000	20.582329068596
]

% extraction of the columns from the read data
x_RE24 = data_RE24(:, 1); % the first column represents the frequency in GHz
y_RE24 = data_RE24(:, 2); % the second column represents the magnitudine in dB(μV/m)

% Data for the radiated electric field (RE) with an aperture of 1.87 mm
data_RE32 = [
3.0000000000000	-16.100759235809
3.0000000000000	-16.100759235809
3.5000000000000	-12.641421768993
4.0000000000000	-8.5214253381662
4.5000000000000	-4.8118664700841
5.0000000000000	-2.2326945534059
5.0000000000000	-2.2326945534059
5.5000000000000	0.11745366703559
6.0000000000000	2.7931046415449
6.5000000000000	5.7095668341675
7.0000000000000	9.3919005790795
7.0000000000000	9.3919005790795
]

% extraction of the columns from the read data
x_RE32 = data_RE32(:, 1); % the first column represents the frequency in GHz
y_RE32 = data_RE32(:, 2); % the second column represents the magnitudine in dB(μV/m)

% Plot creation
figure;

% Plot Class A
plot(x_A, y_A, '--', 'LineWidth', 1.5, 'Color', 'r', 'DisplayName', 'Class A Limit at 10 m'); 
fontsize(20,"points");
hold on; % It keeps the figure opened for another plot

% Plot Class B
plot(x_B, y_B, '--', 'LineWidth', 1.5, 'Color', 'g', 'DisplayName', 'Class B Limit at 10 m');
fontsize(20,"points");

% Plot RE3
plot(x_RE3, y_RE3, '-o', 'LineWidth', 1.5, 'MarkerSize', 6, 'Color', 'b', 'DisplayName', 'L_a_p_e_r_t_u_r_e = 19.98 mm');
fontsize(20,"points");

% Plot RE4
plot(x_RE4, y_RE4, '-o', 'LineWidth', 1.5, 'MarkerSize', 6, 'Color', '#B4A7D6', 'DisplayName', 'L_a_p_e_r_t_u_r_e = 14.99 mm');
fontsize(20,"points");

% Plot RE6
plot(x_RE6, y_RE6, '-o', 'LineWidth', 1.5, 'MarkerSize', 6, 'Color', 'm', 'DisplayName', 'L_a_p_e_r_t_u_r_e = 9.99 mm');
fontsize(20,"points");

% Plot RE8
plot(x_RE8, y_RE8, '-o', 'LineWidth', 1.5, 'MarkerSize', 6, 'Color', 'c', 'DisplayName', 'L_a_p_e_r_t_u_r_e = 7.49 mm');
fontsize(20,"points");

% Plot RE8
plot(x_RE10, y_RE10, '-o', 'LineWidth', 1.5, 'MarkerSize', 6, 'Color', '#fc6f03', 'DisplayName', 'L_a_p_e_r_t_u_r_e = 5.99 mm');
fontsize(20,"points");

% Plot RE12
plot(x_RE12, y_RE12, '-o', 'LineWidth', 1.5, 'MarkerSize', 6, 'Color', '#9807E8', 'DisplayName', 'L_a_p_e_r_t_u_r_e = 4.99 mm');
fontsize(20,"points");

% Plot RE16
plot(x_RE16, y_RE16, '-o', 'LineWidth', 1.5, 'MarkerSize', 6, 'Color', '#FFBE00', 'DisplayName', 'L_a_p_e_r_t_u_r_e = 3.75 mm');
fontsize(20,"points");

% Plot RE24
plot(x_RE24, y_RE24, '-o', 'LineWidth', 1.5, 'MarkerSize', 6, 'Color', 'k', 'DisplayName', 'L_a_p_e_r_t_u_r_e = 2.50 mm');
fontsize(20,"points");

% Plot RE32
plot(x_RE32, y_RE32, '-o', 'LineWidth', 1.5, 'MarkerSize', 6, 'Color', '#6AA84F', 'DisplayName', 'L_a_p_e_r_t_u_r_e = 1.87 mm');
fontsize(20,"points");

% Customizing the plot
grid on;
box on;
xlim([0 7]);
xlabel('Frequency [GHz]');
ylabel('Radiated E-Field at 5GHz [dB_{\mu V/m}]');
%title('Comparison of Class A, Class B, and EMC - Magnitude over Frequency');
legend('show', 'NumColumns', 2); % It shows the legend
set(legend, 'FontSize', 12);
hold off;