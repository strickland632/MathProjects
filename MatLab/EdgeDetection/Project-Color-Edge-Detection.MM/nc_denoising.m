function u = nc_denoising(v0)
% function u = nc_denoising(v0)
% A non-convex denoising (noise reduction, preserving edge strength)

global beta delta Dt nmax level

[m,n,d] = size(v0);

for k=1:d
    u1 = v0(:,:,k);
    for n = 1:nmax
        u1 = u1 + Dt*(beta*(v0(:,:,d)-u1) - reverse_weight(u1,delta));
    end
    u(:,:,k) = u1;
end

