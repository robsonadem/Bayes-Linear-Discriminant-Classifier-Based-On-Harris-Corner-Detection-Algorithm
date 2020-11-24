function [ confmtrx ] = mahalnobis_classifier (class_of_interest, class_corners, class_edges, class_flat);
% Given a class of interest and the three classes for ground truthing we
% find a confusion matrix for the target classes versus output classes
        mean_edges = (mean(class_edges))';
        mean_flat = (mean(class_flat))';
        mean_corners = (mean(class_corners))';
        cov_edges = cov(class_edges);
        cov_flat = cov(class_flat);
        cov_corners = cov(class_corners);
        confmtrx = zeros(1,3);
        for feature_index = 1: length(class_of_interest)
            feature_vector = (class_of_interest(feature_index,:))';
            distance_edges = my_mahalanobis( feature_vector, mean_edges, cov_edges);
            distance_corners = my_mahalanobis( feature_vector, mean_corners, cov_corners);
            distance_flat = my_mahalanobis( feature_vector, mean_flat, cov_flat);
            distances = [distance_corners, distance_edges, distance_flat];
            [min_value, min_index] = min(distances);
            confmtrx(1,min_index) = confmtrx(1,min_index) +1;
        end
end 