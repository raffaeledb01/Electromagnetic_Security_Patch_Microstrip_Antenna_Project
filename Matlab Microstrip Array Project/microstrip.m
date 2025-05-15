clear all 
close all 
clc 

%% Antenna Properties 

ant = design(patchMicrostrip, 5*1e9);
ant.Tilt = 90;
ant.TiltAxis = [0, 1, 0];
% Show
figure;
show(ant) 

%% Antenna Analysis 
% Define plot frequency 
plotFrequency = 5*1e9;
% Define frequency range 
freqRange = (4500:50:5500)*1e6;
% Reference Impedance 
refImpedance = 50;
% sparameter
figure;
s = sparameters(ant, freqRange, refImpedance); 
rfplot(s)
ylabel('S_1_1 [dB]');
xlabel('Frequency [GHz]');
fontsize(20, "points");

% 3D pattern
figure;
pattern(ant, plotFrequency)
