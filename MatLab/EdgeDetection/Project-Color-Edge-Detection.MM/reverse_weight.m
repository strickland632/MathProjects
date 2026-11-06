function K = reverse_weight(u,delta)
% Reverse-Transition-Weighting (RTW) filter
% Usage:  function K = reverse_weight(u,delta)
% Output: K = scaled for "center-weight=4"

e2 = 1.e-4; q = 1+delta;
[m,n] = size(u);
K = zeros(m,n);

for i=1:m
    im = i-1; if im==0, im=2; end
    ip = i+1; if ip==m+1, ip=m-1; end
    for j=1:n
        jm = j-1; if jm==0, jm=2; end
        jp = j+1; if jp==n+1, jp=n-1; end
        dW = max(abs(u(i,j)-u(im,j)),e2)^q;
        dE = max(abs(u(i,j)-u(ip,j)),e2)^q;
            scale = 2./(dW+dE);
            aW = dE*scale;
            aE = dW*scale;
        dS = max(abs(u(i,j)-u(i,jm)),e2)^q;
        dN = max(abs(u(i,j)-u(i,jp)),e2)^q;
            scale = 2./(dS+dN);
            aS = dN*scale;
            aN = dS*scale;
        K(i,j) = 4*u(i,j) - (aW*u(im,j) +aE*u(ip,j) +aS*u(i,jm) +aN*u(i,jp));
    end
end

