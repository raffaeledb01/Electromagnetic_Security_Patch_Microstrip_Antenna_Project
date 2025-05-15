clear all;
close all;
clc;

f0 = 5e9;               % Central frequency [Hz]
f = linspace(4.5e9, 5.5e9, 50); % Frequency range [Hz]
c = 3e8;                % Speed of light [m/s]
lam0 = c / f0;          % Central wavelength
d = lam0 / 2;           % Distance between antennas in the array
phase_shift = 0 / 180 * pi; % Phase shift in rad
numAntennas = 3:20; % Number of antennas ranging from 3 to 20
 
MainLobeMag = zeros(size(numAntennas));   % Main lobe magnitude
MainLobeDir = zeros(size(numAntennas));   % Main lobe direction
MainLobeWidth = zeros(size(numAntennas)); % Main lobe width (HPBW)
SideMagnitude = zeros(size(numAntennas)); % Side lobe magnitude
SideLevel = zeros(size(numAntennas));     % Side lobe level

% Fixed Side Lobe Level at 50 dB
SLL_dB = 50;

% Definition of a microstrip antenna with parameters
ant = patchMicrostrip("Length", 0.02878, "Width", 0.037474, "Height", 0.00059958, ...
    "GroundPlaneLength", 0.059958, "GroundPlaneWidth", 0.059958, ...
    "PatchCenterOffset", [0 0], "FeedOffset", [0.006059 0]);

%Rotation of the antenna by 90° along the y-axis
ant.TiltAxis= [0 1 0];
ant.Tilt=90;

%loop across variable numbers of antennas
for idx = 1:length(numAntennas) 
    N = numAntennas(idx); % number of antennas in array
    
    fprintf('Numero di antenne considerate per CHEBYSHEV: %d\n', N); % Print current number of antennas

    % Generation of the Chebyshev window with given 50 dB
    w = chebwin(N, SLL_dB); 
    
    % Creation of the complex taper
    taper = w' .* exp(1i*linspace(0, N-1, N)*phase_shift);
    
    % Creation of ULA 
    array = phased.ULA('NumElements', N, ...
                           'Element', ant, ...
                           'ElementSpacing', d, ...
                           'Taper', taper, ...
                           'ArrayAxis', 'y');
    
    % pattern analysis
    p = patternAzimuth(array, f0, 0);
    angle_polarpattern = -180:1:180;
    D = polarpattern(angle_polarpattern, p);
    D.AntennaMetrics = 1; % Enable antenna performance metrics calculation
    D.Peaks = 3; % Identify up to 3 main peaks (main lobe + side lobes)
    ant_lobes = findLobes(D);

    % Metrics extractione
    MainLobeMag(idx) = ant_lobes.mainLobe.magnitude;
    MainLobeDir(idx) = ant_lobes.mainLobe.angle;
    MainLobeWidth(idx) = ant_lobes.HPBW;
    SideMagnitude(idx) = squeeze(D.PeakMarkers(3).magnitude);
    SideLevel(idx) = ant_lobes.mainLobe.magnitude - SideMagnitude(idx);
    
    %dispaly the pattern
    figure;
    pattern(array,f0);
end


%% Generation of the plots

figure;
plot(numAntennas, MainLobeMag, 'o', 'LineWidth', 1.5);
grid on;
xlabel('Number of Antennas');
ylabel('Main Lobe Magnitude [dB]');
fontsize(20, "points");

figure;
plot(numAntennas, MainLobeWidth, 'o', 'LineWidth', 1.5);
grid on;
xlabel('Number of Antennas');
ylabel('Main Lobe Width (HPBW) [°]');
fontsize(20, "points");

figure;
plot(numAntennas, SideLevel, 'o', 'LineWidth', 1.5);
grid on;
xlabel('Number of Antennas');
ylabel('Side Lobe Level (SLL) [dB]');
fontsize(20, "points");

figure;
plot(numAntennas, MainLobeDir, 'o', 'LineWidth', 1.5);
grid on;
xlabel('Number of Antennas');
ylabel('Main Lobe Direction [°]');
fontsize(20, "points");

figure;
plot(numAntennas, SideMagnitude, 'o', 'LineWidth', 1.5);
grid on;
xlabel('Number of Antennas');
ylabel('Side Lobe Magnitude [dB]')
fontsize(20, "points");