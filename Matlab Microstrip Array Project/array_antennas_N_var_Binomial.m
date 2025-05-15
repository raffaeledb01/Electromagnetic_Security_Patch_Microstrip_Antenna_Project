clear all;
close all;
clc;

% Function definition
function w = binomialTaper(N)
    % Compute the binomial coefficients for an array of N elements
    w = arrayfun(@(k) nchoosek(N-1, k), 0:N-1); % Iteratively calculate each coefficient
    
    % OPTIONAL: Normalize the binomial coefficients so that max(w) = 1
    w = w / max(w); 
    
    % The resulting vector w has length N.
    % If you want the sum of the coefficients to be 1, you could do instead:
    % w = w / sum(w);
end

% Initial parameters
f0 = 5e9;               % Center frequency [Hz]
f = linspace(4.5e9, 5.5e9, 50); % Frequency range [Hz]
c = 3e8;                % Speed of light [m/s]
lam0 = c / f0;          % Central wavelength
d = lam0 / 2;           % Distance between the antennas in the array
phase_shift = 0 / 180 * pi;  % Phase shift in radians

% Preallocation of the mectrics
numAntennas = 3:20; 
MainLobeMag   = zeros(size(numAntennas));
MainLobeDir   = zeros(size(numAntennas));
MainLobeWidth = zeros(size(numAntennas));
SideMagnitude = zeros(size(numAntennas));
SideLevel     = zeros(size(numAntennas));

for idx = 1:length(numAntennas)
    N = numAntennas(idx); 
    fprintf('Numero di antenne considerate: %d\n', N);
    
    %BINOMIAL TAPER
    % 1) Get binomial coefficients
    binomialCoeff = binomialTaper(N);
    
    % 2) Incorporate desired phase progression
    %    Here we multiply each binomial amplitude by e^(j*k*phase_shift).
    %    The factor (k-1) in the exponent ensures the first element is zero phase.
    %    Adjust as needed for your specific phase distribution.
    taper = binomialCoeff .* exp(1i * (0:N-1) * phase_shift);
    
    % Definition of the antenna and the array
    ant = patchMicrostrip("Length", 0.02878, "Width", 0.037474, ...
        "Height", 0.00059958, ...
        "GroundPlaneLength", 0.059958, "GroundPlaneWidth", 0.059958, ...
        "PatchCenterOffset", [0 0], "FeedOffset", [0.006059 0]);

    ant.TiltAxis= [0 1 0];
    ant.Tilt=90;
    
    array = phased.ULA('NumElements', N, ...
        'Element', ant, ...
        'Taper', taper, ...
        'ElementSpacing', d, ...
        'ArrayAxis', 'y');
    
    % Pattern analysis
    p = patternAzimuth(array, f0, 0);
    angle_polarpattern = -180:1:180;
    D = polarpattern(angle_polarpattern, p);
    D.AntennaMetrics = 1;  % Calculation of metrics
    D.Peaks = 3; 
    ant_lobes = findLobes(D);
    MainLobeMag(idx)   = ant_lobes.mainLobe.magnitude;
    MainLobeDir(idx)   = ant_lobes.mainLobe.angle;
    MainLobeWidth(idx) = ant_lobes.HPBW;
    
    % Initialize SideMagnitude with NaN (or 0)
    SideMagnitude(idx) = NaN;  
    SideLevel(idx)     = NaN;
    
    % Verifies how many peaks were fownd
    numPeaksFound = numel(D.PeakMarkers);
    if numPeaksFound >= 3
        SideMagnitude(idx) = D.PeakMarkers(3).magnitude;
        SideLevel(idx)     = ant_lobes.mainLobe.magnitude - SideMagnitude(idx);
    elseif numPeaksFound == 2
        % If you want at least the second peak
        SideMagnitude(idx) = D.PeakMarkers(2).magnitude;
        SideLevel(idx)     = ant_lobes.mainLobe.magnitude - SideMagnitude(idx);
    else
        % If there is only one peak, do not calculate the side lobes
        % Or assign a default value
    end

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

figure;
plot(numAntennas, MainLobeWidth, 'o', 'LineWidth', 1.5);
grid on;
xlabel('Number of Antennas');
ylabel('Main Lobe Width (HPBW) [\circ]');
xticks(2:1:20); % Manually set the values on the X-axis
fontsize(20, "points");

figure;
plot(numAntennas, SideLevel, 'o', 'LineWidth', 1.5);
grid on;
xlabel('Number of Antennas');
ylabel('Side Lobe Level (SLL) [dB]');
xticks(2:1:20); % Manually set the values on the X-axis
fontsize(20, "points");

figure;
plot(numAntennas, MainLobeDir, 'o', 'LineWidth', 1.5);
grid on;
xlabel('Number of Antennas');
ylabel('Main Lobe Direction [\circ]');
xticks(2:1:20); % Manually set the values on the X-axis
fontsize(20, "points");

figure;
plot(numAntennas, SideMagnitude, 'o', 'LineWidth', 1.5);
grid on;
xlabel('Number of Antennas');
ylabel('Side Lobe Magnitude [dB]');
xticks(2:1:20); % Manually set the values on the X-axis
fontsize(20, "points");