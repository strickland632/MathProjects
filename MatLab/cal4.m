function area = area_closed_curve(data)
    area = 0;
    for i = 2:length(data)
        x2 = (data(i,1));
        x1 = (data(i-1,1));
        y2 = (data(i,2));
        y1 = (data(i-1,2));
        area = area + ( ((x1+x2)/2) * (y2-y1));
    end
    
end
 

a=2; true_area = a^2*6*pi;
Partition = [ 10, 20, 40, 80];
for n = Partition
    %%generate the data points?
    theta = linspace(0,2*pi,n+1)'; %column vector
    data = [2.*a.*cos(theta).*(1-cos(theta)), 2.*a.*sin(theta).*(1-cos(theta))];

    %% area comp.
    area = area_closed_curve(data); % i make
    fprintf('n = %3d; estimation = %.10f, rel-error = %.10f\n', ...
        size(data,1)-1,area,abs(true_area-area)/true_area);

    %% plot & save
    figure, plot(data(:,1),data(:,2),'r-','linewidth',2);
    daspect([1 1 1]); axis tight;
    xlim([-a a]), ylim([-b b]);
    title(['Approximate Ellipse: n=' int2str(n)])
    image_name = strcat('ellipse-n=',int2str(n),'.png');
    exportgraphics(gca,image_name,'Resolution',100);
end
