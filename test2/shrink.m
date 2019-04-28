function [d_x,d_y] = shrink(x_grad,y_grad,b_x,b_y,gama)

% Shrinkage is the solution to d problem,di,j =(?ui,j + bi,j)/
% |?ui,j + bi,j |*max(|?ui,j + bi,j | ? 1/¦Ã, 0)

x1 = (x_grad + b_x)./abs(x_grad + b_x);

m1 = abs(x_grad + b_x)-1/gama;
m1 = max(m1,0);

d_x = x1.*m1;
d_x(isnan(d_x)) = 0;

x2 = (y_grad + b_y)./abs(y_grad + b_y);

m2 = abs(y_grad + b_y)-1/gama;
m2 = max(m2,0);

d_y = x2.*m2;
d_y(isnan(d_y)) = 0;