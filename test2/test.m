clear all
%%
source_path = 'file_1\depth\';
re_path = 'result\image\';

obj = VideoWriter('result\video.avi','Grayscale AVI');

if ~exist(re_path,'dir')
    mkdir(re_path)
end

index = 0;
lamda = 1000;
gama = 0.1;
iter = 500;
% thresh = 5e-4;

global uk

open(obj)

while true
    
    index_str = num2str(index);
    im_name = ['depth',index_str,'.png'];
    im_path = [source_path,im_name];
    result_name = ['reuslt',index_str,'.png'];
    result_path = [re_path,result_name];
    
    if exist(im_path,'file')==2
        index = index +1;
        
        u = double(imread(im_path));
        Lamda = u;
        Lamda(u ~= 255) = lamda;
        Lamda(u == 255) = 0;
        [height,width] = size(u);
       
        if index>1
            iter = 120;
        end
        
        [cost,num] = tv1inpaint(u,Lamda,gama,iter,height,width);
        
        result = uint8(uk);
        imwrite(result,result_path);
        writeVideo(obj,result)
    else
        break
    end
    
end
close(obj)





