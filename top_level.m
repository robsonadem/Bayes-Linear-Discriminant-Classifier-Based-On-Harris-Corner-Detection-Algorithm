clear all 
% Problem #1
img = imread('input_hcd1.jpg'); % Read an image 
[confmtrx_1] = HCD_with_mahalanobis_classifier( img ); % plots distribution and returns confmtrx(3 by 3)

% Problem #2
start_index = 1; end_index=50; %pick a range of images to test with setting indices
% I trained it with the first 50 images
[h,b,mean_vector,covar]  = HCD_training(start_index,end_index); % train the data and extract the LDF params h and b

figure;
plot(mean_vector,'DisplayName','mean_vector')
figure;
surf(covar)
figure;
bar(h,'DisplayName','h')

% first I tested it with the 50 training images
[confmtrx_2] = HCD_testing( h, b, start_index,end_index); % test the data and extract the confmtrx
% Then I tested it with different sets of test images
start_index = 51; end_index=100;
[confmtrx_3] = HCD_testing( h, b, start_index,end_index); % test the data and extract the confmtrx


