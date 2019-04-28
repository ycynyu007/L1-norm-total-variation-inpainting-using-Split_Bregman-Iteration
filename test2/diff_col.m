function y_diff = diff_col(y_data)

[~,col] = size(y_data);

y_data_rowless = [y_data(:,1),y_data(:,1:col-1)];

y_diff = y_data_rowless - y_data ; 