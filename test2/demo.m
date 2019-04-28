clear
%% 
u = double(rgb2gray(imread('lena_in.png')));
ori = double(rgb2gray(imread('lena.tif')));
Mask = double(rgb2gray(imread('lena_mask.png')));

[height,width] = size(u);

lamda = 1000;
gama = 0.1;
iter = 150;
mask = Mask;
mask(mask==0) = lamda;
mask(mask==255) = 0;
Lamda = mask;

thresh = 1e-3;

%%
tic
[uk,cost,num] = tv1inpaint(u,ori,Lamda,gama,iter,thresh,height,width);
toc

%%

figure(1)
subplot(1,2,1)
imshow(uint8(u))
title('distorted image')
subplot(1,2,2)
imshow(uint8(uk))
title('restored image')

figure(2)
plot(cost(1:num));
title('RMSE per iteration')
    
    
    
    
    
    
    
    
    
    
    
    
    