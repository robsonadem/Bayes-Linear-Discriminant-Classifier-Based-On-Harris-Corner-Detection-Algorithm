
function [new_img] = convolve(img, kernel)
    % img -image name in the folder e.g 'image2.jpg'
    % kernel- 3x3 matrix kernel
    % By Robson Adem
kernel   = fliplr(flip(kernel,1)); % flipping in the hor and ver direction 
img_size = size(img);% This gives the dimensions of the image in [length,width]
length	 = img_size(1); %extract the length value from the img_size vector
width    = img_size(2); %extract the width value from the img_size
new_img  = zeros(length,width, 'double');% create a blank matrix for the new img

% The nested for loop computes the convolution
    for i=1:length-2 %edge protection
        for j=1:width-2%edge protection
           
           % The 9 multiplications needed for the convlution
           new_pixel= kernel(1,1)*img(i,j)+  kernel(1,2)*img(i,j+1) +  kernel(1,3)*img(i,j+2)+ kernel(2,1)*img(i+1,j)+  kernel(2,2)*img(i+1,j+1) + kernel(2,3)*img(i+1,j+2) + kernel(3,1)*img(i+2,j)+  kernel(3,2)*img(i+2,j+1) +  kernel(3,3)*img(i+2,j+2); 
           new_img(i+1,j+2)= new_pixel; % put the new pixel in the middle 
           % position of the 3x3 kernel overlap with the orginal pixels
           % the edges will be interpolated with 0
        end 
    end 
end

