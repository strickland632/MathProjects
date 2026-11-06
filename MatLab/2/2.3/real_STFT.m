%compute its spectrogram:

filename = '/Users/sarahstrickland/Documents/MATLAB/2/2.3/StarWars3.wav';
[x,fs] = audioread(filename);
gong = audioplayer(x,fs);
play(gong)

% Calculate the signal length and construct the time vector
signalLength = length(x);
t = (0:signalLength-1) / Fs;

% Downsample the audio signal
downsampleFactor = 10;
x_downsampled = decimate(x, downsampleFactor);
t_downsampled = downsample(t, downsampleFactor);


% Step 4: Modulate the given sound using FM modulation
carrierFreq = 6e3;  % 6 kHz
modulationIndex = 10;

% Generate the carrier signal
carrierSignal = cos(2*pi*carrierFreq*t_downsampled);

% Generate the modulated signal
modulatedSignal = cos(2*pi*carrierFreq*t_downsampled + modulationIndex*cumsum(x_downsampled));
% Step 5: Plot the original sound against time
subplot(2,1,1);
plot(t, x);
xlabel('Time (s)');
ylabel('Amplitude');
title('Original Sound');

% Step 6: Perform FM demodulation to retrieve the original sound
analyticSignal = hilbert(modulatedSignal);
demodulatedSignal = angle(analyticSignal(2:end) .* conj(analyticSignal(1:end-1)));
% Pad the demodulated signal with zeros to match the original size
demodulatedSignal = padarray(demodulatedSignal, [1, 0], 0, 'post');

% Create the downsampled time vector
t_recovered = linspace(0, max(t), length(demodulatedSignal));

% Step 7: Plot the recovered audio against time
subplot(2,1,2);
plot(t_recovered, demodulatedSignal);
xlabel('Time (s)');
ylabel('Amplitude');
title('Recovered Sound');

% Step 8: Listen to the recovered audio in MATLAB
sound(demodulatedSignal, Fs);