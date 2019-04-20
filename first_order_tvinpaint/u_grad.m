    function [x_grad,y_grad] = u_grad(u,D1,D2)
%%% U_GRAD function outputs the two direction gradient of input U
%   D1 D2 sparse difference matrix


%uT = u';

x_grad = u*D1';
y_grad = D2*u;
