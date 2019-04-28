function x_diff = diff_row(x_data)

[row,~] = size(x_data);

x_data_rowless = [x_data(1,:);x_data(1:row-1,:)];

x_diff = x_data_rowless - x_data ; 


