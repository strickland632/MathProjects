function u = gaussfilt2(v0,sigma)
% function u = gaussfilt2(v0,sigma)

%--- define the kernel ----------------------
fsize = 2*ceil(2*sigma)+1;
x = 1:fsize; c = floor(fsize/2)+1;
r2 = (x-c).^2;
K1 = exp(-r2/(2*sigma))/sqrt(2*pi*sigma);
K1 = K1/sum(K1(:));
K =(K1')*K1;

%--- convolution with padding ---------------
[m,n,d] = size(v0);
p = c-1;
up = zeros(m+2*p,n+2*p,d);
up(c:end-p,c:end-p,:) = v0;
for i=1:p,            up(i,:,:) = up(c,:,:);   end
for i=m+2*p:-1:m+p+1, up(i,:,:) = up(m+p,:,:); end
for j=1:p,            up(:,j,:) = up(:,c,:);   end
for j=n+2*p:-1:n+p+1, up(:,j,:) = up(:,n+p,:); end

u = zeros(m,n,d);
for k=1:d
    u(:,:,k) = filter2(K,up(:,:,k),'valid');
end
