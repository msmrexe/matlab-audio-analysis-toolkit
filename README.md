# MATLAB Audio Signal Analysis Toolkit

This project provides a toolkit for analyzing audio signals in MATLAB. It loads an audio file, visualizes its waveform and spectrogram, and demonstrates the application of basic digital filters (low-pass and high-pass).

The project was written for a Mathematical Software course and practices MATLAB package development rules.

## Features

* **Modular Package:** All analysis logic (loading, plotting, filtering) is encapsulated in a `+analysis` MATLAB package.
* **Separation of Concerns:** Each function has a single purpose:
    * `load_audio.m`: Handles loading files (both built-in and user-specified) and ensures mono format.
    * `plot_waveform.m`: Generates the time-domain plot.
    * `plot_spectrogram.m`: Generates the time-frequency plot.
    * `apply_filter.m`: Designs and applies digital filters.
* **Data Handling:** Demonstrates loading both built-in `.mat` audio files (`handel.mat`) and standard `.wav` files using `audioread`.
* **Digital Signal Processing (DSP):** Implements core DSP concepts, including the Short-Time Fourier Transform (via `spectrogram`) and FIR filtering (via `designfilt`).
* **Publication-Ready Plots:** All plotting functions return figure handles and save high-quality `.png` images to an `output/` directory.

---

## Core Concepts & Algorithm Analysis

This project is built on a few fundamental concepts from Digital Signal Processing (DSP).

### 1. The Waveform (Time-Domain)

A digital audio signal is a **time-domain** representation. It's a long list of numbers (samples) that represent the amplitude (loudness) of the sound pressure wave at discrete, evenly-spaced moments in time.

* **Math:** We plot Amplitude $y$ as a function of time $t$.
* **Implementation:** The file gives us the signal $y$ (a vector of $N$ samples) and the sample rate $F_s$ (in samples per second, e.g., 44100 Hz). To get the time vector $t$ for our x-axis, we simply calculate:

  $$t = [0, 1/F_s, 2/F_s, \ldots, (N-1)/F_s]$$

  This is done in `plot_waveform.m` with the vectorized code: `t = (0:length(y)-1) / Fs;`

### 2. The Spectrogram (Time-Frequency Domain)

The waveform tells us *when* the sound is loud or quiet, but not *what* the pitches (frequencies) are. A **Fourier Transform (FFT)** can convert the *entire* signal from the time-domain to the **frequency-domain**, telling us which frequencies were present in the *whole file*.

However, this is not very useful for music or speech, where the frequencies change over time. We need a way to see *how frequency content changes over time*. This is solved by the **Short-Time Fourier Transform (STFT)**, which is the algorithm used to create a spectrogram.

#### How the STFT (Spectrogram) Works:

The STFT breaks the "what, not when" problem of the FFT by following these steps:

1.  **Windowing:** Choose a small "window" size (e.g., 512 samples).
2.  **Chunk & FFT:** Take the first chunk of 512 samples from the signal. Apply an FFT to this chunk. This gives you the frequency content *only for that first small slice of time*. The result is one vertical line of the final spectrogram image.
3.  **Slide the Window:** Move the window forward by a "hop size" (e.g., 256 samples, which creates 50% overlap).
4.  **Repeat:** Take the new 512-sample chunk, apply an FFT, and store the result as the *next* vertical line in the spectrogram.
5.  **Assemble:** Continue this process until you've slid the window across the entire signal. The resulting 2D matrix (Time vs. Frequency vs. Intensity) is the spectrogram.

* **Implementation:** We don't have to code this manually. MATLAB's `spectrogram` function does it all for us. We just need to give it the parameters:
    ```matlab
    spectrogram(y, window, noverlap, nfft, Fs, 'yaxis');
    ```
    * `window`: The windowing function to use (we use `hann(512)`).
    * `noverlap`: The "hop size" (we use 50% overlap).
    * `nfft`: The number of points for the FFT.

### 3. Digital Filtering

Filtering is the process of attenuating (reducing the amplitude of) certain frequencies while letting others pass through.

* **Low-Pass Filter:** Allows *low* frequencies to pass and blocks *high* frequencies. This makes the audio sound "muffled" or "duller," as it removes the bright, high-pitched "sizzle."
* **High-Pass Filter:** Allows *high* frequencies to pass and blocks *low* frequencies. This makes the audio sound "tinny" or "thin," as it removes the bass and body.

* **Implementation:** We use MATLAB's modern `designfilt` function to create a filter "object." We specify the filter type (`lowpassfir`), a `FilterOrder` (which controls its "steepness"), the `CutoffFrequency`, and the `SampleRate`.
    ```matlab
    lpFilt = designfilt('lowpassfir', ...
                        'FilterOrder', 70, ...
                        'CutoffFrequency', 4000, ...
                        'SampleRate', Fs);
    ```
    Once the filter is designed, we apply it to our signal $y$ using the `filter` function:
    ```matlab
    y_low = filter(lpFilt, y);
    ```
    The spectrograms for `y_low` and `y_high` clearly show this effect: the low-pass version will have all the high-frequency content (the top half of the plot) blacked out, and the high-pass version will have the low-frequency content (the bottom half) blacked out.

---

## Project Structure

```
matlab-audio-analysis-toolkit/
├── .gitignore                # Ignores MATLAB temp files and 'output/' dir
├── LICENSE
├── README.md                 # This documentation
├── main.m                    # --- The main runnable script ---
└── +analysis/                # The MATLAB package folder
    ├── apply_filter.m        # Function to design and apply a filter
    ├── load_audio.m          # Helper function to load audio
    ├── plot_spectrogram.m    # Function to plot the spectrogram
    └── plot_waveform.m       # Function to plot the time-domain waveform

````

## How to Run

1.  **Clone or Download:** Get the project files onto your computer.
2.  **Open in MATLAB:** Open the `matlab-audio-analysis-toolkit` folder in MATLAB.
3.  **Run `main`:** Open the `main.m` script and press the **Run** button, or type the following in the MATLAB Command Window:

    ```matlab
    >> main
    Loading audio...
    Loaded built-in "handel.mat" audio file.
    Plotting waveform...
    Plotting spectrogram...
    Applying filters...
    Playing original audio...
    (audio plays)
    Playing low-pass filtered audio...
    (audio plays)
    Playing high-pass filtered audio...
    (audio plays)
    Plotting filtered spectrograms...
    Analysis complete. Check the /output folder for plots.
    ```
    
---

## Author

Feel free to connect or reach out if you have any questions!

* **Maryam Rezaee**
* **GitHub:** [@msmrexe](https://github.com/msmrexe)
* **Email:** [ms.maryamrezaee@gmail.com](mailto:ms.maryamrezaee@gmail.com)

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for full details.
