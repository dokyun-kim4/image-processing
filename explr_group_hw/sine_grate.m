function sine_grate(freq)
    frequency = freq;
    phase = 90; % Phase in degrees
    amplitude = 1;
    
    % Create a meshgrid for the X and Y coordinates
    [X, Y] = meshgrid(0:0.001:1, 0:0.001:1);
    
    % Calculate the Z values for the sine wave
    Z = amplitude * sin((2 * pi * frequency .* X) + deg2rad(phase)); % Convert phase to radians

    % Create the first plot
    fprintf('Sine Wave (Frequency: %.2f Hz)', frequency);
    figure();
    surf(X, Y, Z);
    shading interp;
    view(0, 90);
    axis off;
    axis square;
    
    
    % Perform FFT and plot
    Y = fft2(Z);
    Y_shifted = log(abs(fftshift(Y)) + 1); % Shift FFT and apply log
    fprintf('FFT of Sine Wave (Frequency: %.2f Hz)', frequency);
    figure();
    imshow(Y_shifted, []);
end
