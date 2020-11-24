# Bayes-Linear-Discriminant-Function-Based-On-Harris-Cornet-Detection-Algorithm


## 1:

```
As shown in https://github.com/robsonadem/Sobel-Edge-Detector-Harris-Corner-Detector, we were able to implement
the Harris corner detector algorithm to extract points of interests using the
cornerness measure. Following that, we further implemented a method to
classify interest points as corners, edges, and flat using normal distribution
parameters and Mahalanobis distance measure. First, we defined a 2 x 1
vector using the eigenvalues for each interest point. Then, we computed
mean and covariance as the parameters of normal distributions that best fit
the edges, corners, and flat regions. Following that, we used Mahalanobis
distance to classify each point using the estimated distributions and
obtained a confusion matrix for each class as shown below.
```



## 2:

Provided with the NUMdataset of digits with 10 classes (0 – 9), we extracted image
features using the Harris Corner Detection algorithm. For each class, we used
50 images for training and then used different 50 sets of images to test. For
each image, we created a 20 x 1 feature vector using the 10 most positive and
10 most negative R scores. Then, with the training feature vector for each class,
we set up a Bayes linear discriminant function for recognizing each class.
Following that, we obtained a confusion matrix to evaluate the probability of correct
recognition and the probability of error for each class. The results are shown as
follows.

