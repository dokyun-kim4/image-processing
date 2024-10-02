
close all;
clear all;
frequency = 10;
phase = 90;
amplitude = 1;
[X,Y]=meshgrid(0:0.001:1,0:0.001:1);
% X = square(X);
Z = amplitude*sin((2*3.1415*frequency.*X)+(phase));
surf(X,Y,Z)
shading interp
view(0,90)
% colormap gray
axis off
axis square

XX=fft2(Z);
figure(2);
mesh(Z);
% colormap gray
figure(3);
mesh(abs(fftshift(XX)));


% I = imread('image1.jpg');
% Ig = im2gray(I);
% Y = fft2(Ig);
% Y1 = abs(Y);
% Y2 = log(abs(Y));
% Y3 = log(abs(fftshift(Y)));
% imtool(Y1,[]);
% imtool(Y2,[]);
% imtool(Y3,[]);

% figure;
% imshow(Ig);