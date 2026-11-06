close all
syms x y real


z = x + 1i*y;

%if i didnt calculate by hand:
%g = z^3 - 2*z^2 + z - 2;
%A_sym = simplify(real(g));
%B_sym = simplify(imag(g));
%A = matlabFunction(A_sym);
%B = matlabFunction(B_sym);

%a and b i calculated by hand:
A = @(x,y) x.^3 - 2*x.^2 + x - 3*x.*y.^2 + 2*y.^2-2;
B = @(x,y) -y.^3+x.^2*y - 4*x.*y + y;
T = 'z^3 - 2*z^2 + z - 2=0';

figure,
np=41; X=linspace(-5,5,np); Y=linspace(-5,5,np);
mesh(X,Y,A(X,Y'),'EdgeColor','r'), hold on
mesh(X,Y,B(X,Y'),'EdgeColor','b'),
mesh(X,Y,zeros(np,np),'EdgeColor','k'),
legend("A","B","0"),
xlabel('x'), ylabel('y'), title(['A and B for ' T])
hold off
print('-dpng', 'complex-solutions-A-B-fmesh.png');

%%--- Solve A=0 and B=0 --------------
[xs,ys] = solve(A(x,y)==0,B(x,y)==0,x,y);

figure
np=101; X=linspace(-5,5,np); Y=linspace(-5,5,np);
contour(X,Y,A(X,Y'), [0 0],'r','linewidth',2), hold on
contour(X,Y,B(X,Y'), [0 0],'b--','linewidth',2)
plot(double(xs),double(ys),'r.','MarkerSize',30) % the solutions
grid on

%ax=gca; ax.GridAlpha=0.5; ax.FontSize=13;
legend("A=0","B=0")
xlabel('x'), ylabel('yi'), title(['Compex solutions of' T])
hold off
print ('-dpng', 'complex-solutions-A-B=0.png')

