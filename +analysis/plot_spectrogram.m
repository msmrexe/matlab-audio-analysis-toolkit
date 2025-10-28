function figHandle = plot_spectrogram(y, Fs)
% plot_spectrogram Computes and plots the spectrogram of the audio signal.
%   figHandle = plot_spectrogram(y, Fs)
%
%   y:  Audio signal (a vector)
%   Fs: Sample rate (in Hz)
%   figHandle: Handle to the generated figure

    % --- Spectrogram Parameters ---
    % Window: A function applied to each signal chunk (e.g., Hann window)
    % We'll use 512 samples for the window.
    windowLength = 512;
    window = hann(windowLength);

    % Overlap: How much the windows overlap. 50% is common.
    overlapLength = round(windowLength * 0.5);

    % NFFT: Number of points for the FFT.
    % Using the window length is a good default.
    nfft = windowLength;

    % Create a new figure
    figHandle = figure;

    % Compute and plot the spectrogram
    % 'yaxis' plots frequency on the y-axis
    spectrogram(y, window, overlapLength, nfft, Fs, 'yaxis');
    
    % The 'spectrogram' function automatically labels the axes.
    title('Audio Spectrogram (Time-Frequency Domain)');
end
