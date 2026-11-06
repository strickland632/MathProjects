DATA = load('heart-data.txt');

X = DATA(:,1); Y = DATA(:,2);
figure, plot(X,Y,'r-','linewidth',2);

[m,n] = size(DATA);
area = area_closed_curve(DATA);

fprintf('# of points = %d; area = %g\n',m,area);