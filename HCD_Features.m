function [feature_vector] = HCD_Features (img)
        % given an image finds a 1 x 20 feature vector with the 10 most positive R
        % and 10 most negative R - 
        img=im2double(img); 

        sobel_kernel_x=[1,0,-1;
                        2,0,-2;
                        1,0,-1]; %sobel edge operatort for blurring

        sobel_kernel_y=[1, 2, 1;
                        0, 0, 0;
                       -1,-2,-1]; %sobel edge operatort for blurring

        % Image gradients
        img_x=convolve(img, sobel_kernel_x); % custom convolution function for kernel 3x3
        img_y=convolve(img, sobel_kernel_y); % custom convolution function for kernel 3x3

        % Pixel by Pixel products of the images
        Ixx=img_x.*img_x;
        Iyy=img_y.*img_y;
        Ixy=img_x.*img_y;

        window = [1,1,1;
                  1,1,1;
                  1,1,1]; % smoothing window

        img_size=size(img);% This gives the dimensions of the image in [length,width]
        length=img_size(1); %extract the length value from the img_size vector
        width=img_size(2); %extract the width value from the img_size
        R_img = zeros(length,width, 'double');% create a blank matrix for the new img
        R_img_no_thresholding = zeros(length,width, 'double');% create a blank matrix for the new img

        % Smoothed Images 
        Sxx = convolve(Ixx,window);
        Syy = convolve(Iyy,window);
        Sxy = convolve(Ixy,window);
        
        % Features
        class_positive = [0];
        class_negative = [0];
        
        % Index to keep track of the number of points in each class
        index_positive = 1;
        index_negative = 1;

        %% HCD Algorithm
        for i=1:length
            for j=1:width
                  % Hessian Matrix
                  Hxy=[ Sxx(i,j) , Sxy(i,j);
                        Sxy(i,j),  Syy(i,j)];
                  k=0.06; 
                  % Cornerness Measure
                  R = det(Hxy)- k*trace(Hxy)^2;
                  R_img_no_thresholding(i,j) = R;
                  %  Thresholidng for postive R values
                  if(R > 0 ) 
                     class_positive(index_positive,1) = R;
                     index_positive = index_positive + 1;
                  end
                  %  Thresholidng for negative R values
                  if(R < 0 ) 
                     class_negative(index_negative,1) = R;
                     index_negative = index_negative + 1;
                  end

            end 
        end
        class_positive = sort(class_positive,'descend'); % to extract the most positives or the max
        class_negative = sort(class_negative) ; % the most negatives or the mins
        
        feature_vector (1:10) = class_positive ((1:10)) ; 
        feature_vector (11:20) = class_negative((1:10)); 
        
        feature_vector = sort(feature_vector); % 1x20 and then sort
end 