function [xi, iter] = modisecant(f, xi, perturbation, precision)
% Written by Harshath Muruganantham, ID: 33114064
% Last Modified 1/5/22
% 
% INPUTS:
%  - f: function handle of the equation to be solved
%  - xi: initial guess
%  - perturbation: Our modifier for x_i each loop.
%  - precision: stopping criteria determined by the user
% 
% OUTPUTS:
%  - xi: the root of the equation
%  - iter: Number of iterations it took to arrive at the solution


iter = 0;
% Iteration for modified secant method starts
while abs(f(xi)) > precision

    % Increment the iteration count by 1
    iter = iter + 1;

    % Recalculating x_i
    xi = xi-perturbation*f(xi)/(f(xi+perturbation)-f(xi));
end

