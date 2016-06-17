# MLP

Multi Layer Perceptron (C++) with ONE hidden layer.

To compile it, use the "make" command (Makefile included).

To run: ./MLP nInput nHiddenNeurons nOutputNeurons testFile trainingFile learningRate error
  - nInput: number of inputs (i.e., number of attributes).
  - nHiddenNeurons: number of neurons in the hidden layer.
  - nOutputNeurons: number of neurons in the output layer.
  - testFile: file with the test cases (must have the correct class in front of each case).
  - trainingFile: file with the training cases (must have the correct class in front of each case).
  - learning_rate: learning rate of the neural network.
  - error: used as a convergence criterion.
  
Data preprocessing performed using Matlab (data standardization: mean = 0 and std_dev = 1).

There is a Python (version 2.7) script used to perform 10-fold cross-validation. To run it, simply type "python run_cross-validation.py". Please take a look at the file to see how it works (don't worry, it's well documented).
  
