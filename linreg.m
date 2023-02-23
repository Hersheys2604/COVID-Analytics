function [a0,a1,r2] = linreg(x,y)
% Written by: Harshath Muruganantham, ID: 33114064
% Last Modified 28/04/22
% Performs linear regression on teh linear x and y data
% 
% INPUTS:
% -x: linear independent data set
% -y: linear dependent data set
% OUTPUT:
% -a0: constant in y=a1*x + a0
% -a1: gradient in y=a1*x + a0
% -r2: coefficcient of determination

% Getting best regression coefficients
n =length(x);
Sx = sum(x);
Sy = sum(y);
Sxx = sum(x.*x);
Sxy = sum(x.*y);
a1 = (n*Sxy - Sx*Sy)/(n*Sxx - Sx^2);
a0 = mean(y) - a1*mean(x);

% Getting r2 value
St = sum((y - mean(y)).^2);
Sr = sum((y - a0 - a1*x).^2);
r2 = (St - Sr)/St;
