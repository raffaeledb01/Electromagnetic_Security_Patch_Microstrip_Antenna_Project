clear all;
close all;
clc;

% Initial parameters
f0 = 5e9; % Center frequency [Hz]
f = linspace(4.5e9, 5.5e9, 50); % Frequency range [Hz]
c = 3e8; % Speed of light [m/s]
lam0 = c / f0; % Central wavelength
d = lam0 / 2; % Distance between the antennas in the array
phase_shift = 0 / 180 * pi; % Phase shift in radians

% Preallocation of the mectrics
numAntennas = 3:20; % Number of antennas variation
MainLobeMag = zeros(size(numAntennas));
MainLobeDir = zeros(size(numAntennas));
MainLobeWidth = zeros(size(numAntennas));
SideMagnitude = zeros(size(numAntennas));
SideLevel = zeros(size(numAntennas));

% Loop over the number of antennas
for idx = 1:length(numAntennas)
    N = numAntennas(idx); % Number of antennas
    fprintf('Numero di antenne considerate: %d\n', N); % Prints the number of antennas
    taper = ones(1, N) .* exp(1i .* linspace(1, N, N) * phase_shift); % Power supply currents
    
    % Definition of the antenna and the array
    ant = patchMicrostrip("Length", 0.02878, "Width", 0.037474, "Height", 0.00059958, ...
        "GroundPlaneLength", 0.059958, "GroundPlaneWidth", 0.059958, ...
        "PatchCenterOffset", [0 0], "FeedOffset", [0.006059 0]);

    ant.TiltAxis= [0 1 0];
    ant.Tilt=90;

    array = phased.ULA('NumElements', N, 'Element', ant, 'Taper', taper, ...
        'ElementSpacing', d, 'ArrayAxis', 'y');
    
    % Pattern analysis
    p = patternAzimuth(array, f0, 0);
    angle_polarpattern = -180:1:180;
    D = polarpattern(angle_polarpattern, p);
    D.AntennaMetrics = 1; % Calculation of metrics
    D.Peaks = 3; % Calculation of the three main peaks
    
    % Extraction of the metrics
    ant_lobes = findLobes(D);
    MainLobeMag(idx) = ant_lobes.mainLobe.magnitude;
    MainLobeDir(idx) = ant_lobes.mainLobe.angle;
    MainLobeWidth(idx) = ant_lobes.HPBW;
    SideMagnitude(idx) = squeeze(D.PeakMarkers(3).magnitude);
    SideLevel(idx) = ant_lobes.mainLobe.magnitude - SideMagnitude(idx);

    figure;
    pattern(array,f0);
end
%%
% Generation of the plots
figure;
plot(numAntennas, MainLobeMag, 'o', 'LineWidth', 1.5);
grid on;
xlabel('Number of Antennas');
ylabel('Main Lobe Magnitude [dB]');
xticks(2:1:20); % Manually set the values on the X-axis
fontsize(20, "points");
%title('Main Lobe Magnitude vs Number of Antennas');

figure;
plot(numAntennas, MainLobeWidth, 'o', 'LineWidth', 1.5);
grid on;
xlabel('Number of Antennas');
ylabel('Main Lobe Width (HPBW) [°]');
xticks(2:1:20); % Manually set the values on the X-axis
fontsize(20, "points");
%title('Main Lobe Width vs Number of Antennas');

figure;
plot(numAntennas, SideLevel, 'o', 'LineWidth', 1.5);
grid on;
xlabel('Number of Antennas');
ylabel('Side Lobe Level (SLL) [dB]');
xticks(2:1:20); % Manually set the values on the X-axis
fontsize(20, "points");
%title('Side Lobe Level vs Number of Antennas');

figure;
plot(numAntennas, MainLobeDir, 'o', 'LineWidth', 1.5);
grid on;
xlabel('Number of Antennas');
ylabel('Main Lobe Direction [°]');
xticks(2:1:20); % Manually set the values on the X-axis
fontsize(20, "points");
%title('Main Lobe Direction vs Number of Antennas');

figure;
plot(numAntennas, SideMagnitude, 'o', 'LineWidth', 1.5);
grid on;
xlabel('Number of Antennas');
ylabel('Side Lobe Magnitude [dB]');
xticks(2:1:20); % Manually set the values on the X-axis
fontsize(20, "points");
%title('Side Magnitude vs Number of Antennas');
