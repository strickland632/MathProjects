function Z = non_max_suppression(E0,TH)
% function Z = non_max_suppression(E0,TH)

[m,n] = size(E0);
Z = zeros(m,n);

TH(TH<0) = TH(TH<0)+pi;
R = mod(floor((TH+pi/8)/(pi/4)),4);  % region=0,1,2,3

for i=2:m-1, for j=2:n-1
    if R(i,j)==0,                        % around 0 degrees
        a=E0(i-1,j);   b=E0(i+1,j);
    elseif R(i,j)==1,                    % around 45 degrees
        a=E0(i-1,j-1); b=E0(i+1,j+1);
    elseif R(i,j)==2,                    % around 90 degrees
        a=E0(i,j-1);   b=E0(i,j+1);
    else,                                % around 135 degrees
        a=E0(i-1,j+1); b=E0(i+1,j-1);
    end
    if E0(i,j)>=max(a,b), Z(i,j) = E0(i,j); end
end,end

