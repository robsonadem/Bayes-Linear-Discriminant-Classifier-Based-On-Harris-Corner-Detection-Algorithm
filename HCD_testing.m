function [ confmtrx ] = HCD_testing( h, b, start_index,end_index)
    % Get list of all jpg files in this directory
    % DIR returns as a structure array.  You will need to use () and . to get
    % the file names.
    confmtrx = zeros(10,10); 
    class_index = 1;
    for i=0:9 % for going through digit data sets 0-9
        cd DigitDataset % change directory
        digit = int2str(i);
        cd(digit) % change directory
        imagefiles = dir('*.png');      
        nfiles = length(imagefiles);    % Number of files found
        step_size = floor(nfiles/50);
        for ii=1:nfiles
           currentfilename = imagefiles(ii).name;
           currentimage = im2double(imread(currentfilename));
           test_images{ii} = currentimage;
        end
        cd .. % reverse directory change
        cd ..% reverse directory change

        % pass in each images (50 test images) and extract features and dumb features to a 50 x20
        % matrix called class
        k=1; % wanted to use j but I want to start with 0 THIS COUNTS THE IMAGES BEING TESTED
        for j=start_index:end_index % test images
             class(k,:) = HCD_Features(test_images{1,j}); %1x20 FEATURE VECTOR FOR EACH IMAGE
             max_index  = LDF(class(k,:), h, b); % h and b outputs from training
             % LDF spits class_index with maximum g-- DECISION
             confmtrx (class_index, max_index) = confmtrx (class_index, max_index) + 1; 
             % In the confusion matrix for each class we increment the number
             % of decisions from LDF 
             k = k + 1;
        end
        % Save the 50 x 1 matrix to our all_g of the entire data set
        class_index = class_index + 1; % class increment
    end 
end 