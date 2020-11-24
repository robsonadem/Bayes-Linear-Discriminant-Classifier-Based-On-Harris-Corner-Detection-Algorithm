function [h,b,mean_vector,covar] = HCD_training(start_index,end_index)
    % Get list of all jpg files in this directory
    % DIR returns as a structure array.  You will need to use () and . to get
    % the file names.
    index = 1;
    for i=0:9 % for going through digit data sets 0-9
        cd DigitDataset
        digit = int2str(i);
        cd(digit)
        imagefiles = dir('*.png');      
        nfiles = length(imagefiles);    % Number of files found
        step_size = floor(nfiles/50);
        for ii=1:nfiles
           currentfilename = imagefiles(ii).name;
           currentimage = im2double(imread(currentfilename));
           train_images{ii} = currentimage;
        end
        cd ..
        cd ..
        % pass in each image (the first 50 train_images) and extract features and dumb features to a 50 x20
        % matrix called class. 
        for j=1:50
         class(j,:) = HCD_Features(train_images{1,j}); 
        end
        mean_vector{index} = mean(class);
        % Save the 50 x 20 matrix to our feature vector of the entire data set
        feature_vector{index}= class; 
        index = index + 1; % class increment
    end 
    % Feature Vector at the end of the for loop is 1 x 10 cell where each cell
    % contains 50x20 
    % so feature_vector's transpose should have 10 x 1 cell arrangement then we
    % change this to matrix below. This is also true for mean_vector

    feature_vector = cell2mat(feature_vector'); % Gives us the general feature vector 500 x 20
    covar = cov(feature_vector); 
    mean_vector = (cell2mat(mean_vector'))'; % 10 x 20

    % LDF params
    h = inv(covar)*mean_vector; % 20x10 - h for the 10 classes
    for i=1:10
        mu = mean_vector(:,i);
        b(i)= -0.5*mu'*inv(covar)*mu;
    end 
    b = b'; % b 10 x 1 for 10 classes 
end 