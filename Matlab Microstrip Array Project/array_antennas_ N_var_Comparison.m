clc;
clear all;
close all;

f0=5e9;
f = linspace(4.5e9, 5.5e9, 50); % Range of frequency [Hz]
c = 3e8;% [m/s] speed of ligth
lam0 = c / f0; % [m] wavelength
d = lam0 / 2; % distance between antennas in the array
phase_shift = 0 / 180 * pi; % Phase shif in radians
numAntennas = 3:20; % Variation of the number of antennas

% Definition of the antenna and array
ant = patchMicrostrip("Length", 0.02878, "Width", 0.037474, "Height", 0.00059958, ...
    "GroundPlaneLength", 0.059958, "GroundPlaneWidth", 0.059958, ...
    "PatchCenterOffset", [0 0], "FeedOffset", [0.006059 0]);

ant.TiltAxis= [0 1 0];
ant.Tilt=90;


%% Sweep N in ULA array 

close all;

MainLobeMag_ULA = zeros(size(numAntennas));
MainLobeDir_ULA = zeros(size(numAntennas));
MainLobeWidth_ULA = zeros(size(numAntennas));
SideMagnitude_ULA = zeros(size(numAntennas));
SideLevel_ULA = zeros(size(numAntennas));

for idx = 1:length(numAntennas) %number of antennas in array

    N = numAntennas(idx);
    fprintf('Numero di antenne considerate per ULA: %d\n', N); % Print the number of antennas

    taper_ULA = ones(1, N) .* exp(1i .* linspace(1, N, N) * phase_shift); % Power supply currents
    
    array_ULA = phased.ULA('NumElements', N, 'Element', ant, 'Taper', taper_ULA, ...
        'ElementSpacing', d, 'ArrayAxis', 'y');

    % Pattern analysis
    p_ULA = patternAzimuth(array_ULA, f0, 0);
    angle_polarpattern = -180:1:180;
    D = polarpattern(angle_polarpattern, p_ULA);
    D.AntennaMetrics = 1; % Calculation of the antenna metrics
    D.Peaks = 3; % Calculation of the three main peaks
    
    % Metrics extraction
    ant_lobes = findLobes(D);
    MainLobeMag_ULA(idx) = ant_lobes.mainLobe.magnitude;
    MainLobeDir_ULA(idx) = ant_lobes.mainLobe.angle;
    MainLobeWidth_ULA(idx) = ant_lobes.HPBW;
    SideMagnitude_ULA(idx) = squeeze(D.PeakMarkers(3).magnitude);
    SideLevel_ULA(idx) = ant_lobes.mainLobe.magnitude - SideMagnitude_ULA(idx);

    figure;
    pattern(array_ULA,f0);
end

%% Sweep N in Binomial array

MainLobeMag_BINOMIAL = zeros(size(numAntennas));
MainLobeDir_BINOMIAL = zeros(size(numAntennas));
MainLobeWidth_BINOMIAL = zeros(size(numAntennas));
SideMagnitude_BINOMIAL = zeros(size(numAntennas));
SideLevel_BINOMIAL = zeros(size(numAntennas));

% Defining the function
function w = binomialTaper(N)
    % Compute the binomial coefficients for an array of N elements
    w = arrayfun(@(k) nchoosek(N-1, k), 0:N-1); % Iteratively calculate each coefficient
    
    % OPTIONAL: Normalize the binomial coefficients so that max(w) = 1
    w = w / max(w); 
end

for idx = 1:length(numAntennas)
    N = numAntennas(idx); %number of antennas in array
   
    fprintf('Numero di antenne considerate per BINOMIAL: %d\n', N); % Prints the number of antennas

    binomialCoeff = binomialTaper(N);

    % Create the complex taper = binomial amplitude * exp(j*phase)
    % % In our case, the phase is 0, so: exp(j*0) = 1
    taper_BINOMIAL = binomialCoeff .* exp(1i * (0:N-1) * phase_shift);
    
    array_BINOMIAL = phased.ULA('NumElements', N,'Element', ant, 'Taper', taper_BINOMIAL, 'ElementSpacing', d, 'ArrayAxis', 'y');
    
    % Pattern analysis
    p_BINOMIAL = patternAzimuth(array_BINOMIAL, f0, 0);
    angle_polarpattern = -180:1:180;
    D = polarpattern(angle_polarpattern, p_BINOMIAL);
    D.AntennaMetrics = 1;  % Calcolo delle metriche
    D.Peaks = 3;
    ant_lobes = findLobes(D);
    MainLobeMag_BINOMIAL(idx)   = ant_lobes.mainLobe.magnitude;
    MainLobeDir_BINOMIAL(idx)   = ant_lobes.mainLobe.angle;
    MainLobeWidth_BINOMIAL(idx) = ant_lobes.HPBW;
    
    % Initialize SideMagnitude with NaN (or 0)
    SideMagnitude_BINOMIAL(idx) = NaN;  
    SideLevel_BINOMIAL(idx)     = NaN;
    
    % Verifies how many peaks were fownd
    numPeaksFound = numel(D.PeakMarkers);
    if numPeaksFound >= 3
        SideMagnitude_BINOMIAL(idx) = D.PeakMarkers(3).magnitude;
        SideLevel_BINOMIAL(idx)     = ant_lobes.mainLobe.magnitude - SideMagnitude_BINOMIAL(idx);
    elseif numPeaksFound == 2
        % If you want at least the second peak
        SideMagnitude_BINOMIAL(idx) = D.PeakMarkers(2).magnitude;
        SideLevel_BINOMIAL(idx)     = ant_lobes.mainLobe.magnitude - SideMagnitude_BINOMIAL(idx);
    else
        % If there is only one peak, do not calculate the side lobes
        % Or assign a default value
    end

    figure;
    pattern(array_BINOMIAL,f0);
end

%% Sweep N in Chebyshev array 

% Initialize array for metrics
MainLobeMag_CHEBYSHEV = zeros(size(numAntennas));
MainLobeDir_CHEBYSHEV = zeros(size(numAntennas));
MainLobeWidth_CHEBYSHEV = zeros(size(numAntennas));
SideMagnitude_CHEBYSHEV = zeros(size(numAntennas));
SideLevel_CHEBYSHEV = zeros(size(numAntennas));

% Sidelobe level desired
SLL_dB = 50;

for idx = 1:length(numAntennas)

    N = numAntennas(idx); %number of antennas in array
    
    fprintf('Numero di antenne considerate per CHEBYSHEV: %d\n', N); % Prints the number of antennas

    % Generate the Chebyshev window with sidelobe level set
    w = chebwin(N, SLL_dB);  % Restituisce un vettore colonna solo modulo

    % Create the complex taper = Chebyshev weights * exp(j*phase)
    % In our case, the phase is 0, so: exp(j*0) = 1
    taper_CHEBYSHEV = w' .* exp(1i*linspace(0, N-1, N)*phase_shift);
    
    % Array creation
    array_CHEBYSHEV = phased.ULA('NumElements', N, 'Element', ant, 'ElementSpacing', d, 'Taper', taper_CHEBYSHEV, 'ArrayAxis', 'y');
    
    % Pattern analysis
    p_CHEBYSHEV = patternAzimuth(array_CHEBYSHEV, f0, 0);
    angle_polarpattern = -180:1:180;
    D = polarpattern(angle_polarpattern, p_CHEBYSHEV);
    D.AntennaMetrics = 1; % Calculation of the antenna metrics
    D.Peaks = 3; % Calculation of the three main peaks
    
    % Extraction of the metrics
    ant_lobes = findLobes(D);
    MainLobeMag_CHEBYSHEV(idx) = ant_lobes.mainLobe.magnitude;
    MainLobeDir_CHEBYSHEV(idx) = ant_lobes.mainLobe.angle;
    MainLobeWidth_CHEBYSHEV(idx) = ant_lobes.HPBW;
    SideMagnitude_CHEBYSHEV(idx) = squeeze(D.PeakMarkers(3).magnitude);
    SideLevel_CHEBYSHEV(idx) = ant_lobes.mainLobe.magnitude - SideMagnitude_CHEBYSHEV(idx);

    figure;
    pattern(array_CHEBYSHEV,f0);
end


%% Comparison of antenna metrics for different arrays 

figure;
scatter(numAntennas, MainLobeMag_ULA,"filled",'r');
xlabel('Number of Antennas');
ylabel('Main Lobe Magnitude [dB]');
xticks(2:1:20); % Manually set the values on the X-axis
grid on;
hold on
scatter(numAntennas, MainLobeMag_BINOMIAL, "filled",'g');
hold on
scatter(numAntennas, MainLobeMag_CHEBYSHEV,"filled",'b');
legend('ULA', 'BINOMIAL', 'CHEBYSHEV','Location', 'best');
fontsize(20, "points");

figure;
scatter(numAntennas, MainLobeDir_ULA,"filled",'r');
xlabel('Number of Antennas');
ylabel('Main Lobe Direction [\circ]');
xticks(2:1:20); % Manually set the values on the X-axis
grid on;
hold on
scatter(numAntennas, MainLobeDir_BINOMIAL,"filled",'g');
hold on
scatter(numAntennas, MainLobeDir_CHEBYSHEV,"filled",'b');
legend('ULA', 'BINOMIAL', 'CHEBYSHEV','Location', 'best');
fontsize(20, "points");

figure;
scatter(numAntennas, MainLobeWidth_ULA,"filled",'r');
xlabel('Number of Antennas');
ylabel('Main Lobe Width (HPBW) [\circ]');
xticks(2:1:20); % Manually set the values on the X-axis
grid on;
hold on
scatter(numAntennas, MainLobeWidth_BINOMIAL,"filled",'g');
hold on
scatter(numAntennas, MainLobeWidth_CHEBYSHEV,"filled",'b');
legend('ULA', 'BINOMIAL', 'CHEBYSHEV','Location', 'best');
fontsize(20, "points");

figure;
scatter(numAntennas, SideMagnitude_ULA,"filled",'r');
xlabel('Number of Antennas');
ylabel('Side Lobe Magnitude [dB]');
xticks(2:1:20); % Manually set the values on the X-axis
grid on;
hold on
scatter(numAntennas, SideMagnitude_BINOMIAL,"filled",'g');
hold on
scatter(numAntennas, SideMagnitude_CHEBYSHEV,"filled",'b');
legend('ULA', 'BINOMIAL', 'CHEBYSHEV','Location', 'best');
fontsize(20, "points");

figure;
scatter(numAntennas, SideLevel_ULA,"filled",'r');
xlabel('Number of Antennas');
ylabel('Side Lobe Level (SLL) [dB]');
xticks(2:1:20); % Manually set the values on the X-axis
grid on;
hold on
scatter(numAntennas, SideLevel_BINOMIAL,"filled",'g');
hold on
scatter(numAntennas, SideLevel_CHEBYSHEV,"filled",'b');
legend('ULA', 'BINOMIAL', 'CHEBYSHEV','Location', 'best');
fontsize(20, "points");