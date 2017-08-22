function [theta, J_history] = gradientDescentMulti(X, y, theta, alpha, num_iters)
%GRADIENTDESCENTMULTI Performs gradient descent to learn theta
%   theta = GRADIENTDESCENTMULTI(x, y, theta, alpha, num_iters) updates theta by
%   taking num_iters gradient steps with learning rate alpha

% Initialize some useful values
m = length(y); % number of training examples
J_history = zeros(num_iters, 1);

for iter = 1:num_iters

    % ====================== YOUR CODE HERE ======================
    % Instructions: Perform a single gradient step on the parameter vector
    %               theta. 
    %
    % Hint: While debugging, it can be useful to print out the values
    %       of the cost function (computeCost) and gradient here.
    %
    hyp = X*theta;
    lambda = hyp - y;
    tbuffer = theta;
    for i=1:length(theta)
    tbuffer(i) = tbuffer(i) - alpha * 1/m * sum(lambda.*X(:,i));
    end
    theta = tbuffer;
    % ============================================================   
    J_history(iter) = computeCost(X, y, theta);
end

end
