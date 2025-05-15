%% ARRAY DEFINITION
clear all;
close all;
clc;

% Initial parameters
N = 15; % Number of antennas
f0 = 5e9; % Central frequency [Hz]
f = linspace(4.5e9, 5.5e9, 50); % Frequency range [Hz]
c = 3e8; % Speed of light [m/s]
lam0 = c / f0; % Central wavelength
d = lam0 / 2; % Distance between the antennas in the array
angles = -180:15:180; % Range of angles for the phase shift (0° to 180° with a step of 15°)

% Preallocation of the mectrics
MainLobeMag = zeros(size(angles));
MainLobeDir = zeros(size(angles));
MainLobeWidth = zeros(size(angles));
SideMagnitude = zeros(size(angles));
SideLevel = zeros(size(angles));

% Definition of the antenna
ant = patchMicrostrip("Length", 0.02878, "Width", 0.037474, "Height", 0.00059958, ...
    "GroundPlaneLength", 0.059958, "GroundPlaneWidth", 0.059958, ...
    "PatchCenterOffset", [0 0], "FeedOffset", [0.006059 0]);

ant.TiltAxis= [0 1 0];
ant.Tilt=90;


% Loop for the phase shif values
for idx = 1:length(angles)
    angle = angles(idx); % Current angle
    phase_shift = angle / 180 * pi; % Phase shif in radians
    fprintf('Phase Shift: %d\n', phase_shift); 

    % Power supply currents (taper)
    taper = ones(1, N) .* exp(1i .* linspace(1, N, N) * phase_shift); 

    % Array creation
    array = phased.ULA('NumElements', N, 'Element', ant, 'Taper', taper, ...
        'ElementSpacing', d, 'ArrayAxis', 'y');

    % Lobes analysis
    p = patternAzimuth(array, f0, 0);
    angle_polarpattern = -180:1:180;
    D = polarpattern(angle_polarpattern, p);
    D.AntennaMetrics = 1; % It shpws the antenna metrics
    D.Peaks = 3; % Calculation of the three main peaks
    ant_lobes = findLobes(D);

    % Storage of the metrics
    MainLobeMag(idx) = ant_lobes.mainLobe.magnitude;
    MainLobeDir(idx) = ant_lobes.mainLobe.angle;
    MainLobeWidth(idx) = ant_lobes.HPBW;
    SideMagnitude(idx) = squeeze(D.PeakMarkers(3).magnitude);
    SideLevel(idx) = ant_lobes.mainLobe.magnitude - SideMagnitude(idx);

    figure;
    pattern(array,f0);
end
%% Generation of the plots

% Main Lobe Magnitude
figure;
plot(angles, MainLobeMag, '-o', 'LineWidth', 1.5);
grid on;
xlabel('Phase Shift [°]');
ylabel('Main Lobe Magnitude [dB]');
xticks(-180:15:180);
xlim([-180 180]);
fontsize(20, "points");
%title('Main Lobe Magnitude vs Phase Shift');

% Main Lobe Width (HPBW)
figure;
plot(angles, MainLobeWidth, '-o', 'LineWidth', 1.5);
grid on;
xlabel('Phase Shift [°]');
ylabel('Main Lobe Width [°]');
xticks(-180:15:180);
xlim([-180 180]);
fontsize(20, "points");
%title('Main Lobe Width (HPBW) vs Phase Shift');

% Side Lobe Level (SLL)
figure;
plot(angles, SideLevel, '-o', 'LineWidth', 1.5);
grid on;
xlabel('Phase Shift [°]');
ylabel('Side Lobe Level [dB]');
xticks(-180:15:180);
xlim([-180 180]);
fontsize(20, "points");
%title('Side Lobe Level vs Phase Shift');

%Main Lobe Direction
figure;
plot(angles, MainLobeDir, '-o', 'LineWidth', 1.5);
grid on;
xlabel('Phase Shift [°]');
ylabel('Main Lobe Direction [°]');
xticks(-180:15:180);
xlim([-180 180]);
fontsize(20, "points");
%title('Main Lobe Direction vs Number of Antennas');

%Side Magnitude
figure;
plot(angles, SideMagnitude, '-o', 'LineWidth', 1.5);
grid on;
xlabel('Phase Shift [°]');
ylabel('Side Lobe Magnitude [dB]');
xticks(-180:15:180);
xlim([-180 180]);
fontsize(20, "points");
%title('Side Magnitude vs Number of Antennas');