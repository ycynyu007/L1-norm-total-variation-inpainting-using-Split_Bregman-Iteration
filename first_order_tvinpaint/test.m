clear

%%

u = double(imread('depth0.png'));
%u = u(20:460,40:600);
mask = u;
mask(mask ~= 255) = 0;


[height,width] = size(u);

lamda = 1000;
gama = 0.1;
iter = 200;

mask(mask==0) = lamda;
mask(mask==255) = 0;
lamda = mask;

e1 = ones(width,1);
e2 = ones(height,1);

D1 =spdiags([-e1,e1],0:1,width,width);
D1(width,1) = 1;                                  % cyclic convolution
D2 = spdiags([-e2,e2],0:1,height,height);
D2(height,1) = 1; 

%%
cost = zeros(1,iter);
uk = double(imread('init.png'));
b_x = zeros(height,width);
b_y = zeros(height,width);
d_x = zeros(height,width);
d_y = zeros(height,width);

for num = 1:iter
    [x_grad,y_grad] = u_grad(uk,D1,D2);
    
    [d_x,d_y] = shrink(x_grad,y_grad,b_x,b_y,gama);
    
    Gk = gau_sei(d_x,d_y,b_x,b_y,lamda,gama,u,uk);
    uk = Gk;
    
    b_x = b_x + x_grad - d_x;
    b_y = b_y + y_grad - d_y;
    
end

figure(1)
subplot(1,2,1)
imshow(uint8(u))
title('distorted image')
subplot(1,2,2)
imshow(uint8(uk))
title('restored image')
% figure(2)
% plot(cost);
% title('cost')
% xlabel('iteration')
