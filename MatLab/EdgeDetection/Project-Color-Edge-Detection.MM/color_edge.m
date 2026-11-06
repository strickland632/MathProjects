function ES = color_edge(v0,Name)
% function ES = color_edge(v0,Name)
% Edge detection for color images,

global beta Dt sigma delta nmax id_smooth id_grad level

[m,n,d] = size(v0);
vs = zeros(m,n,d); grad = zeros(m,n,d); theta = zeros(m,n,d);
TH = zeros(m,n); ES = zeros(m,n);

%---------------------------------------------------
%--- Step 1: Channel-by-Channel --------------------
%---------------------------------------------------
if id_smooth==1, E1 = nc_denoising(v0);
else,            E1 = gaussfilt2(v0,sigma); end
    if level>=4, imagesave(E1,Name,'1smoothing'); end

%---------------------------------------------------
%--- Step 2 ----------------------------------------
%---------------------------------------------------
if id_grad==1
    [E2,TH] = structure_tensor(E1);
elseif id_grad>=2
    %--- Channel-by-Channel ----------
    [m,n,d] = size(E1);
    [ux,uy] = sobel_derivatives(E1);
    grad = sqrt(ux.^2+uy.^2); theta = atan2(uy,ux);
    %--- Combine ---------------------
    [E2,I] = max(grad,[],3);
    for i=1:m, for j=1:n, TH(i,j) = theta(i,j,I(i,j)); end,end

    if id_grad==3, E2 = vecnorm(grad,2,3); end
end
maxE2 = max(E2(:));
    if level>=4, imagesave(E2/maxE2,Name,'2grad'); end
    if level>=4 && id_grad>=2, grad = grad/max(grad(:));
        imagesave(grad(:,:,1),Name,'2gradient-R');
        imagesave(grad(:,:,2),Name,'2gradient-G');
        imagesave(grad(:,:,3),Name,'2gradient-B'); end

%---------------------------------------------------
%--- Step 3: Edge Thinning -------------------------
%---------------------------------------------------
E3 = non_max_suppression(E2,TH);
    if level>=4, imagesave(E3/maxE2,Name,'3nonmax-supress'); end

%---------------------------------------------------
%--- Step 4: Double Threshold ----------------------
%---------------------------------------------------
highRatio = 0.07; %mess with this
lowRatio = 0.5;   %fix this up- after histaria stuff?
[strong,weak] = double_thresholds(E3,highRatio,lowRatio);
    if level>=3, figure, imshow(strong); figure, imshow(0.5*weak); end
    if level>=4,
        imagesave(strong,Name,'4TH-strong');
        imagesave(weak*0.5,Name,'4TH-weak');
        imagesave(strong+0.5*weak,Name,'4TH-strong-weak'); end

% YOU SHOULD COMPLETE BELOW
%---------------------------------------------------
%--- Step 5: Edge Tracking by Hysteresis -----------
%---------------------------------------------------
E5 = hysteresis(strong,weak);

%---------------------------------------------------
%--- Step 6: (Extra Step) Edge-Trim ----------------
%---------------------------------------------------
E6 = edgetrim(E5);
% AT THE END, "ES" SHOULD BE ASSIGNED Appropriately

ES = E6; % Final edge map after trimming