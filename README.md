# FFR135 Artificial Neural Networks
Labs made in the course for artificial neural networks in the fall of 2016 at Chalmers University of Technology. Written in matlab.
## Labs
- Task 1: A one-dimensional Kohonen network that learns the properties of a distribution of two-dimensional input patterns.
  - Run with ```main```
- Task 2: A two-dimensional Kohonen network with 20x20 output units recognizing wine classes. Wine classes borrowed from https://archive.ics.uci.edu/ml
  - Run with ```main```
- Task 3: A hybrid learning algorithm. Unsupervised training is first performed. Supervised training is performed with 70% of the data points, the other 30% is used to validate the network. Calculates classification error at validation and returns the smallest error. Plots the results for this error.
  - Run with ```main(k, runs)``` where k is the number of radial basis functions and runs the number of trials.
  - Run with ```main_2(k)``` if you want to see how the weight vectors change position during unsupervised training.