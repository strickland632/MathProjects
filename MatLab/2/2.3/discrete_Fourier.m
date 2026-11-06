function X = discrete_Fourier(x)
%function X = discrete_Fourier(x)
% Calculate the full DFT

N = length(x); % Length of input sequence
X = zeros(1,N); % Initialize output sequence

% (k*Df)*n*Dt = (k/T)*n*(T/N) = k*n/N

for k = 0:N-1 % Loop over all frequency components
    for n = 0:N-1 % Loop over all time-domain samples
        X(k+1) = X(k+1) + x(n+1)*exp(-1i*2*pi*k*n/N);
    end
end

end