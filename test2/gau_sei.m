function Gk = gau_sei(d_x,d_y,b_x,b_y,lamda,gama,u,uk,height,width)
% gau_sei is one sweep of Gaussian-Seidel operation which solves u problem 
% Follow the solution in paper:
% T. Goldstein, S. Osher, ¡°The Split Bregman Method for L1-Regularized Problems,¡± SIAM
% Journal on Imaging Sciences, vol. 2, no. 2, pp. 323¨C343, 2009. 
% http://dx.doi.org/10.1137/080725891

D_prod = lamda .* u;
lamda_4g = lamda + 4*gama;

coef1 = D_prod./lamda_4g;
coef2 = gama./lamda_4g;

lapla = [0,1,0;1,0,1;0,1,0];
uk_sum = conv2(padarray(uk,[1,1],'replicate','both'),lapla,'same');
uk_sum = uk_sum(2:height+1,2:width+1);

db_sum = diff_row(d_x) + diff_col(d_y)-diff_row(b_x)-diff_col(b_y);


Gk = coef1 + coef2.*(uk_sum + db_sum);