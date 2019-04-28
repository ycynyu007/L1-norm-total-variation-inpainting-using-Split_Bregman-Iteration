function [rmse,num] = tv1inpaint(u,lamda,gama,iter,height,width)
% purpose£ºusing first order total variation to inpaint the missing area of 
%          an image based on paper: 
% "Total Variation Inpainting using Split Bregman"
%  Pascal Getreuer

% usage£º[uk,rmse,num] = tv1inpaint(u,ori,lamda,gama,iter,thresh,height,width)

% input£º
%       u: the image waiting for processing
%       ori: ground truth
%       lamda/gama: constant variable used in the minimization equation.
%       iter: number of iteration times
%       thresh: threshold used to break the iteration
%       height/width: size of the input image

% ouput£º
%       uk: inpainted image
%       rmse: root mean square error
%       num: number of iterations that have been conducted
% date£º March 01,2019  
% Chengyun Yang, Tandon School of Engineering, New York University
% Email: cy1231@nyu.edu

% variable initialization
global uk
persistent b_x b_y D1 D2

if isempty(uk)
    b_x = zeros(height,width);
    b_y = zeros(height,width);
    uk = zeros(height,width);
    e1 = ones(width,1);
    e2 = ones(height,1);
    D1 =spdiags([-e1,e1],0:1,width,width);
    D1(width,1) = 1;                                                           
    D1 = D1';                                                                  
    D2 = spdiags([-e2,e2],0:1,height,height);
    D2(height,1) = 1;   
end

rmse = zeros(1,iter);

                                                       

for num = 1:iter
    % d problem solution
    [x_grad,y_grad] = u_grad(uk,D1,D2);
    [d_x,d_y] = shrink(x_grad,y_grad,b_x,b_y,gama);                        % solve d problem by shrinkage
    
    Gk = gau_sei(d_x,d_y,b_x,b_y,lamda,gama,u,uk,height,width);
    dif = (uk-Gk).^2;
    uk = Gk;                                                               % solve u problem by one sweep of Gaussian-Seidel per iteration  
    
    b_x = b_x + x_grad - d_x;                                              % update variable b(b_x,b_y)
    b_y = b_y + y_grad - d_y;
    
    
    rmse(num) = sqrt(mean(dif(:)));                                        % calculate the RMSE of each iteration
%     if num >1
%         rate = abs((rmse(num-1)-rmse(num))/rmse(num-1));
%     end
    
%     if rate < thresh                                                       % break the iteration if threshold is met
%         break
%     end
    
end