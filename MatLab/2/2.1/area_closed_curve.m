function area = area_closed_curve(data)
% compute the area of a region of closed curve
[m,n] = size(data);
area = 0;

for i=2:m
    % sumation of x midpoint plus difference in y
    area = area + ((data(i-1,1) + data(i,1))/2) * (data(i, 2) - data(i-1,2));
end

