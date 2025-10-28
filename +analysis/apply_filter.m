function [y_low, y_high] = apply_filter(y, Fs, cutoff)
% apply_filter Designs and applies low-pass and high-pass FIR filters.
%   [y_low, y_high] = apply_filter(y, Fs, cutoff)
%
%   y:      Input signal
%   Fs:     Sample rate (in Hz)
%   cutoff: The cutoff frequency for both filters (in Hz)
%
%   y_low:  The low-pass filtered signal
%   y_high: The high-pass filtered signal

    % --- Design the Low-Pass Filter ---
    % We use a simple FIR (Finite Impulse Response) filter.
    % 'FilterOrder' controls the steepness of the cutoff. Higher is steeper.
    filterOrder = 70;
    
    lpFilt = designfilt('lowpassfir', ...
        'FilterOrder', filterOrder, ...
        'CutoffFrequency', cutoff, ...
        'SampleRate', Fs);

    % --- Design the High-Pass Filter ---
    hpFilt = designfilt('highpassfir', ...
        'FilterOrder', filterOrder, ...
        'CutoffFrequency', cutoff, ...
        'SampleRate', Fs);

    % --- Apply the Filters ---
    % 'filter' is the function that applies the designed filter to the signal.
    y_low = filter(lpFilt, y);
    y_high = filter(hpFilt, y);
end
