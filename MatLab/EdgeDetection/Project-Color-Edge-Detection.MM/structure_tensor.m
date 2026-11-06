function [grad,theta] = structure_tensor(u)
% For a color image u, apply Structure Tensor (ST) to get
%   the gradient magnitude, grad, &
%   the edge normal direction, theta.

%%--- Sobel Derivatives ---------------------------------
[ux,uy] = sobel_derivatives(u);

%%--- Jacobian: J = (grad u)*(grad u)' ------------------
Jxx = dot(ux,ux,3); Jxy = dot(ux,uy,3); Jyy = dot(uy,uy,3);

%%--- The first eigenvalue-eigenvecor (e1,v1) -----------
D  = (Jxx-Jyy).^2 + 4*Jxy.^2;
e1 = (Jxx+Jyy+sqrt(D))/2;
grad  = sqrt(e1);               % sqrt(e1) = |grad u|

%%--- Pick a row for theta ------------------------------
%theta=atan2(-(Jxx-e1),Jxy); %v1=(Jxy,-(Jxx-e1)), from Row1
%theta=atan2(-Jxy,Jyy-e1);   %v1=(Jyy-e1,-Jxy),   from Row2

%%--- Choose the max from two rows, for theta -----------
% [ Jxx-e1   Jxy   ];   v = [  Jxy      ]  or  [ Jyy-e1 ]
% [  Jxy    Jyy-e1 ];       [ -(Jxx-e1) ]      [  -Jxy  ]

S11 = Jxx-e1;
idx = abs(S11)>=abs(Jxy);
V11 = (idx.*Jxy + (1-idx).*(Jyy-e1));
V12 =-(idx.*S11 + (1-idx).*Jxy);
theta = atan2(V12,V11);

