function [confmtrx] = HCD_with_mahalanobis_classifier( img )
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

    % Ground Truth Label for the three classes 
    class_edges = [0,0];
    class_corners = [0,0];
    class_flat = [0,0];
    % Index to keep track of the number of points in each class
    flat_index = 1;
    edge_index = 1;
    corner_index = 1;

    %HCD Algorithm
    for i=1:length
        for j=1:width
              % Hessian Matrix
              Hxy=[ Sxx(i,j) , Sxy(i,j);
                    Sxy(i,j),  Syy(i,j)];
              k=0.06; 
              % Cornerness Measure
              R = det(Hxy)- k*trace(Hxy)^2;
              R_img_no_thresholding(i,j) = R;
              %  Thresholidng for Corners 80 is such a nice number for the
              %  corners
              if(R > 80 ) 
                  eigenvalues = eig(Hxy);
                  lambda_1 = eigenvalues(1);
                  lambda_2 = eigenvalues(2);
                  class_corners(corner_index,1) = lambda_1;
                  class_corners(corner_index,2) = lambda_2;
                  corner_index = corner_index + 1;
              end
              %  Thresholidng for Edges
              if(R < -10 ) 
                  eigenvalues = eig(Hxy);
                  lambda_1 = eigenvalues(1);
                  lambda_2 = eigenvalues(2);
                  class_edges(edge_index,1) = lambda_1;
                  class_edges(edge_index,2) = lambda_2;
                  edge_index = edge_index + 1;
              end
              %  Thresholidng for flat regions
              if ( (R > -10) && (R < 80))
                  if( R~=0) %% discard the zero paddings
                      eigenvalues = eig(Hxy);
                      lambda_1 = eigenvalues(1);
                      lambda_2 = eigenvalues(2);
                      class_flat(flat_index,1) = lambda_1;
                      class_flat(flat_index,2) = lambda_2;
                      flat_index = flat_index + 1;
                  end 
              end

        end 
    end
    figure (1);
    scatter(class_corners(:,1),class_corners(:,2))
    hold on 
    scatter(class_edges(:,1),class_edges(:,2))
    scatter(class_flat(:,1),class_flat(:,2))
    legend('Corner','Edges', 'Flat')
    hold off 
    % Classification
    class_of_interest = class_corners;
    confmtrx_corners = mahalnobis_classifier (class_of_interest, class_corners, class_edges, class_flat);

    class_of_interest = class_edges;
    confmtrx_edges = mahalnobis_classifier (class_of_interest, class_corners, class_edges, class_flat);

    class_of_interest = class_flat;
    confmtrx_flat = mahalnobis_classifier (class_of_interest, class_corners, class_edges, class_flat);

    confmtrx = [ confmtrx_corners ; confmtrx_edges ; confmtrx_flat ];

end 
