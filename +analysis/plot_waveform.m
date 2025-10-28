function figHandle = plot_waveform(y, Fs)
% plot_waveform Plots the time-domain amplitude of the audio signal.
%   figHandle = plot_waveform(y, Fs)
%
%   y:  Audio signal (a vector)
%   Fs: Sample rate (in Hz)
%   figHandle: Handle to the generated figure

    % Create the time vector
    % t = [0, 1/Fs, 2/Fs, ..., (N-1)/Fs] where N = length(y)
    N = length(y);
    t = (0:N-1) / Fs;

    % Create a new figure
    figHandle = figure;

    % Plot
    plot(t, y);

    % Label the plot
    xlabel('Time (s)');
    ylabel('Amplitude');
    title('Audio Waveform (Time-Domain)');
    grid on;
    axis tight; % Fit axes tightly to the data
end
