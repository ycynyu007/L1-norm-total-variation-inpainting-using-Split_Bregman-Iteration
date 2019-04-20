function Gk = gau_sei(d_x,d_y,b_x,b_y,lamda,gama,u,uk)



[height,width] = size(d_x);

D_prod = lamda .* u;
lamda_4g = lamda + 4*gama;

coef1 = D_prod./lamda_4g;
coef2 = gama./lamda_4g;


lapla = [0,1,0;1,0,1;0,1,0];
uk_sum = conv2(padarray(uk,[1,1],'replicate','both'),lapla,'same');
uk_sum = uk_sum(2:height+1,2:width+1);

db_sum = diff_row(d_x) + diff_col(d_y)-diff_row(b_x)-diff_col(b_y);


Gk = coef1 + coef2.*(uk_sum + db_sum);