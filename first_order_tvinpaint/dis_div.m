function u_div = dis_div(u_x,u_y)
[height,width] = size(u_x);
u_div = zeros(height,width);
for i =1:height
    for j = 1:width
        if i ==1 || j==1
            u_div(i,j) = 0;
        else
            u_div(i,j) = u_x(i,j)-u_x(i-1,j)+u_y(i,j)-u_y(i,j-1);
        end
    end
end
            

