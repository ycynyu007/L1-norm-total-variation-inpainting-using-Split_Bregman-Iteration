function u_lap = laplacian(u)
[height,width] = size(u);
u_lap = zeros(height,width);
for i = 1:height
    for j = 1:width
        if i==1 || j==1 || i == height || j == width
            u_lap(i,j) = 0;
        else
            u_lap(i,j) = -4*u(i,j)+u(i+1,j)+u(i-1,j)+u(i,j+1)+u(i,j-1);
        end
    end
end

            