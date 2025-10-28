% main.m
%
% This script runs the full audio analysis pipeline:
% 1. Loads an audio file.
% 2. Plots its time-domain waveform.
% 3. Computes and plots its time-frequency spectrogram.
% 4. Designs and applies low-pass and high-pass filters.
% 5. Plays the original and filtered audio.
% 6. Plots the spectrograms of the filtered audio.
%
% All plots are saved to the 'output/' directory.

% --- Setup ---
clear; clc; close all; % Start fresh
addpath(genpath(pwd)); % Add all subfolders (like +analysis) to path

% --- Configuration ---
outputDir = 'output';
if ~exist(outputDir, 'dir'), mkdir(outputDir); end % Create output folder if it doesn't exist
cutoffFreq = 4000; % Cutoff frequency for filters (in Hz)

% --- 1. Load Audio ---
% We use the built-in 'handel.mat' file for this demo.
% The load_audio function handles loading and ensures it's mono.
disp('Loading audio...');
[y, Fs] = analysis.load_audio; % Fs = Sampling Frequency

% --- 2. Plot Waveform ---
disp('Plotting waveform...');
h1 = analysis.plot_waveform(y, Fs);
saveas(h1, fullfile(outputDir, '1_waveform.png'));

% --- 3. Plot Spectrogram ---
disp('Plotting spectrogram...');
h2 = analysis.plot_spectrogram(y, Fs);
saveas(h2, fullfile(outputDir, '2_spectrogram_original.png'));

% --- 4. Apply Filters ---
disp('Applying filters...');
[y_low, y_high] = analysis.apply_filter(y, Fs, cutoffFreq);

% --- 5. Play Audio ---
% Note: sound() is non-blocking, so we pause.
disp('Playing original audio...');
sound(y, Fs);
pause(length(y)/Fs + 1); % Pause for audio duration + 1s buffer

disp('Playing low-pass filtered audio...');
sound(y_low, Fs);
pause(length(y_low)/Fs + 1);

disp('Playing high-pass filtered audio...');
sound(y_high, Fs);
pause(length(y_high)/Fs + 1);

% --- 6. Plot Filtered Spectrograms ---
disp('Plotting filtered spectrograms...');
h3 = analysis.plot_spectrogram(y_low, Fs);
title(sprintf('Spectrogram (Low-Pass Filter @ %d Hz)', cutoffFreq));
saveas(h3, fullfile(outputDir, '3_spectrogram_lowpass.png'));

h4 = analysis.plot_spectrogram(y_high, Fs);
title(sprintf('Spectrogram (High-Pass Filter @ %d Hz)', cutoffFreq));
saveas(h4, fullfile(outputDir, '4_spectrogram_highpass.png'));

disp('Analysis complete. Check the /output folder for plots.');
