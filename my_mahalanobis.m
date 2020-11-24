function [ d ] = my_mahalanobis( feature_vector, mean, covariance)
% feature_vectro and mean 2x1 and Covariance 2x2
   d = 0.5 * ( log( norm(covariance))+ ( (feature_vector - mean)'*covariance'*(feature_vector - mean)));
end 