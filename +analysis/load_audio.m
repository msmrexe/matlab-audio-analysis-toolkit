function [y_mono, Fs] = load_audio(filename)
% load_audio Loads an audio file.
%   [y, Fs] = load_audio() loads the built-in MATLAB 'handel.mat' sample.
%   [y, Fs] = load_audio('my_file.wav') loads a specific .wav file.
%
%   The function also converts any stereo audio to mono by averaging channels.

    if nargin < 1
        % Load the built-in demo file 'handel.mat'
        % This file contains two variables: 'y' (the signal) and 'Fs' (sample rate)
        load('handel.mat');
        disp('Loaded built-in "handel.mat" audio file.');
    else
        % Load a user-specified file
        try
            [y, Fs] = audioread(filename);
            fprintf('Loaded user file: %s\n', filename);
        catch ME
            error('Failed to read audio file: %s\n%s', filename, ME.message);
        end
    end

    % --- Ensure Mono Audio ---
    % Check if audio is stereo (2 columns)
    if size(y, 2) == 2
        % Convert to mono by averaging the left and right channels
        y_mono = mean(y, 2);
    else
        y_mono = y;
    end
end
