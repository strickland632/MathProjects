function [ux,uy] = sobel_derivatives(u)
% This function returns Sobel derivatives, using
% conv2(u,C,'valid') which requires boundary correction.
% input u: either in gray or color

%%--- initialization -------------------------
if isa(u,'uint8'), u = im2double(u); end
[m,n,d] = size(u);
ux = zeros(m,n,d); uy = zeros(m,n,d);
C = [1 2 1; 0 0 0; -1 -2 -1];

%%--- conv2, with 'valid' --------------------
for k = 1:d
    ux(2:end-1,2:end-1,k) = conv2(u(:,:,k),C, 'valid');
    uy(2:end-1,2:end-1,k) = conv2(u(:,:,k),C','valid');
end

%%--- expand, up to the boundary -------------
ux(1,:,:) = ux(2,:,:); ux(end,:,:) = ux(end-1,:,:);
ux(:,1,:) = ux(:,2,:); ux(:,end,:) = ux(:,end-1,:);
uy(1,:,:) = uy(2,:,:); uy(end,:,:) = uy(end-1,:,:);
uy(:,1,:) = uy(:,2,:); uy(:,end,:) = uy(:,end-1,:);

