function [max_index]= LDF(feature_vector, h, b)
    % feature_vector 1x20
    %  h 20x10 20x1 h vector for 10 classes
    %  b 10x1  b value for 10 classes
    for class_index=1:10
     g(class_index) = feature_vector*h(:,class_index) + b(class_index); %LDF
    end 
    [max_value,max_index] = max(g); 
    % find the maximum g LDF 
    % and return its index which corresponds to class_index
    % Think of this as the DECISION MAKER
end