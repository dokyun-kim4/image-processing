% Apply low pass filtering by multiplication in frequency domain. Show filtered image in spatial domain.
% Apply high pass filtering by multiplication in frequency domain. Show filtered image in spatial domain.
% Add noise to your images. Does spatial domain filtering (median filtering, spatial domain gauss filter, etc.) work better to remove this noise or frequency domain filtering? 
clear all;
close all;

img1 = rgb2gray(imread("../../pictures/cat.jpeg"));
img2 = rgb2gray(imread("../../pictures/dog.png"));

figure();
imshow(img1);
title("Original Image 1");
figure();
imshow(img2);
title("Original Image 2");

% Convert img to frequency domain
I1 = fftshift(fft2(img1));
I2 = fftshift(fft2(img2));

% Make LPF and HPF
LPF1 = make_filter(I1, 30, 'lowpass');
HPF1 = make_filter(I1, 30, 'highpass');

LPF2 = make_filter(I2, 30, 'lowpass');
HPF2 = make_filter(I2, 30, 'highpass');

% Apply LPF
I1_LPF = (ifft2(I1 .* LPF1));
I2_LPF = (ifft2(I2 .* LPF2));

% Apply HPF
I1_HPF = (ifft2(I1 .* HPF1));
I2_HPF = (ifft2(I2 .* HPF2));

% Display filter results
figure();
imshow(real(I1_LPF), []);
title('Low-Pass Filtered Image 1');
figure();
imshow(real(I1_HPF), []);
title('High-Pass Filtered Image 1');

figure();
imshow(real(I2_LPF), []);
title('Low-Pass Filtered Image 2');
figure();
imshow(real(I2_HPF), []);
title('High-Pass Filtered Image 2');

% ------------------------------------------------------- %

% Add noise to the images
noised1 = imnoise(img1, 'gaussian', 0, 0.01);
noised2 = imnoise(img2, 'gaussian', 0, 0.01);

% Display noisy images
figure();
imshow(noised1);
title('Noisy Image 1');
figure();
imshow(noised2);
title('Noisy Image 2');

% Step 7: Spatial domain filtering
% Median filtering
noise1_median = medfilt2(noised1, [3 3]);
noise2_median = medfilt2(noised2, [3 3]);

% Gaussian filtering
h = fspecial('gaussian', [5 5], 1);
noise1_gaussian = imfilter(noised1, h);
noise2_gaussian = imfilter(noised2, h);

% Display spatial filter results
subplot(1, 2, 1);
imshow(noise1_median);
title('Median Filtered Image 1');

subplot(1, 2, 2);
imshow(noise1_gaussian);
title('Gaussian Filtered Image 1');

subplot(1, 2, 1);
imshow(noise2_median);
title('Median Filtered Image 2');

subplot(1, 2, 2);
imshow(noise2_gaussian);
title('Gaussian Filtered Image 2');

% Function to create filter
function filter = make_filter(I, radius, type)
    [rows, cols] = size(I);
    crow = round(rows/2); % Center of circle
    ccol = round(cols/2); % Center of circle
    
    % Create a meshgrid for the filter
    [x, y] = meshgrid(1:cols, 1:rows);
    distance = sqrt((x - ccol).^2 + (y - crow).^2);

    if strcmp(type, "lowpass")
        filter = double(distance <= radius);
    elseif strcmp(type, "highpass")
        filter = double(distance > radius);
    else
        disp("Invalid Filter Type");
    end
end
