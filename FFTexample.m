    % Sampling
    fs = 1000;     % Sampling rate [Hz]
    Ts = 1/fs;     % Sampling period [s]
    fNy = fs / 2;  % Nyquist frequency [Hz]
    duration = 10; % Duration [s]
    t = 0 : Ts : duration-Ts; % Time vector
    noSamples = length(t);    % Number of samples
    A_1 = 20;
    A_2 = 30;
    A_3 = 15;
    f_1 = 100;
    f_2 = 300;
    f_3 = 400;
    s_1 = A_1*sin((2*pi*f_1*t));
    s_2 = A_2*sin((2*pi*f_2*t));
    s_3 = A_3*sin((2*pi*f_3*t));
    % Contaminated signal
    xn = s_1+s_2+s_3;
    x = s_1 + s_2;
    % Frequency analysis
    f = 0 : fs/noSamples : fs - fs/noSamples; % Frequency vector
    % FFT
    raw = fft(/x);
    stem(x);
    x_fft = abs(fft(x)/noSamples);
    xn_fft = abs(fft(xn)/noSamples);
    % Plot
    plot(f,xn_fft);
    xlim([0 fNy]);
    xlabel('Frequency (Hz)')
    ylabel('Amplitude (dB SPL)')
    title('{Spectrum}')