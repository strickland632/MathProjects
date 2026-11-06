close all

if exist('OCTAVE_VERSION','builtin'), pkg load image; end
%--------------------------------
w1=0.299; w2=0.587; w3=0.114; gray=0.6;
n=256;

image=im2double(zeros(n,n,3));
nblock=8; width=floor(n/nblock);

for i=1:nblock
    i0 = (i-1)*width+1; i1 = i0+width-1;
    for j=1:nblock
        j0 = (j-1)*width+1; j1 = j0+width-1;
        r = 0.1*randi([0,nblock],1,1);
        b = 0.1*randi([0,nblock],1,1);
        g = (gray - w1*r - w3*b)/w2;
        if i==nblock/2 && j==nblock/2, r=1;g=1;b=1; end
        if i==nblock/2+1 && j==nblock/2+1, r=0;g=0;b=0; end
        image(i0:i1,j0:j1,1)=r;
        image(i0:i1,j0:j1,2)=g;
        image(i0:i1,j0:j1,3)=b;
end,end

figure,imshow(image)
imwrite(image,'synthetic-Checkerboard.png')

imageG = rgb2gray(image);
figure,imshow(imageG)

