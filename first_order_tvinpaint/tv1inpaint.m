function [uk,cost] = tv1inpaint(u,ori,lamda,gama,iter,thresh,height,width)
cost = zeros(1,iter);
uk = zeros(height,width);
b_x = zeros(height,width);
b_y = zeros(height,width);
rate = 1;

e1 = ones(width,1);
e2 = ones(height,1);

D1 =spdiags([-e1,e1],0:1,width,width);
D1(width,1) = 1;                                  % cyclic convolution
D2 = spdiags([-e2,e2],0:1,height,height);
D2(height,1) = 1;                                 % cyclic convolution

for num = 1:iter
    [x_grad,y_grad] = u_grad(uk,D1,D2);
    
    [d_x,d_y] = shrink(x_grad,y_grad,b_x,b_y,gama);
    
    Gk = gau_sei(d_x,d_y,b_x,b_y,lamda,gama,u,uk);
    uk = Gk;
    
    b_x = b_x + x_grad - d_x;
    b_y = b_y + y_grad - d_y;
    dif = (uk-ori).^2;
    cost(num) = sqrt(mean(dif(:)));
    if num >1
        rate = abs((cost(num-1)-cost(num))/cost(num-1));
    end
    
    if rate < thresh
        break
    end
    
end