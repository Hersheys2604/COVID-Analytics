function I = comp_simp13(f,a,b,n)
% Written by Harshath Muruganantham, ID: 33114064
% Last Modified 8/5/22
% 
% Performs composite simpson's 1/3 rule
% 
% INPUTS:
%  -f: function handle of equation
%  -a: starting integral limit
%  -b: ending integral limit
%  -n: number of points
% 
% OUTPUTS:
%  -I: Integral value

% Error checking
if (n < 3) || (rem(n,2) == 0)
    error('Inappropriate number of points for integration')
end

% creating x vector and determining width
h = (b-a)/(n-1);
x = linspace(a,b,n);

% Evaluating integral
even_sum = 4*sum(f(x(2:2:end-1)));
odd_sum = 2*sum(f(x(3:2:end-2)));
I = h/3*(f(a) + even_sum + odd_sum + f(b));