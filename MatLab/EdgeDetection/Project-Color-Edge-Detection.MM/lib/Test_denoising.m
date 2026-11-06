close all; clear all

USER_PAR;

if exist('OCTAVE_VERSION','builtin'), pkg load image; end
%----------------------------------------------
TheImage = char(DATA(idata));

v0 = im2double(imread(TheImage));
[m,n,d] = size(v0);

ug = zeros(m,n,d); ut = zeros(m,n,d);

ug = gaussfilt2(v0,sigma);
ut = nc_denoising(v0);

if level>=1
    figure, imshow(v0); figure, imshow(ug); figure, imshow(ut);
end
if level>=2
    imwrite(ug,'Lena256_test-Gaussian-filter.png')
    imwrite(ut,'Lena256_test-TV_denoised.png')
end
