function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));
                
% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
%feedforward
layer1 = [ones(m,1) X];
z2 = layer1 * Theta1';
a2 = sigmoid(z2);

layer2 = [ones(m,1) a2];
z3 = layer2 * Theta2';
a3 = sigmoid(z3); 

hyp = a3;


%Cons Function
yVec = zeros(m,num_labels);
for k=1:m
  yVec(k,y(k,:)) = 1; 
  s1 =  sum( yVec(k,:) .* log(hyp(k,:)) + (1 - yVec(k,:)) .* (log(1 - hyp(k,:))) );
  J = J + s1;
end
J = - J / m;

% regularization
J = J + lambda / (2 * m) * ( sum(sum (Theta1(:,2:end) .^2, 2 )) + sum(sum (Theta2(:,2:end) .^2, 2 )) );

%Backpropagation
sigma3 = a3 .- yVec;
sigma2 = sigma3  * Theta2 .* sigmoidGradient([ones(m,1) z2]);

delta1 = sigma2(:,2:end)' * layer1;
delta2 = sigma3' * layer2;

Theta1_grad = 1/m * delta1;
Theta2_grad = 1/m * delta2;


% regularization of Neural Network
Theta1_grad(:,2:end) = Theta1_grad(:,2:end) + lambda / m * Theta1(:,2:end);
Theta2_grad(:,2:end) = Theta2_grad(:,2:end) + lambda / m * Theta2(:,2:end);

% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%



% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
