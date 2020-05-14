% --- PROJEKT KRETSEN ---
% @author Viola Söderlund
% @version 2020-05-11

function [k, a] = trf(t, v, num_k, h)
%  Trapezoidal rule function TRF Returns the fourier serie koefficients for a current curve.
%  inputs:
%   - t is a vector of x-coordinats values of the current curve.
%   - v is a vector of y-coordinats values of the current curve.
%   - num_k number of terms in the serie
%   - h step length of the approximation
%  outputs:
%   - k is the indexation of the koefficients.
%   - a is the serie koefficients.
    a = zeros(num_k, 1);
    k = 1:num_k;
    
    for k_ = k
        f = @(i) v(i) * sin(k_*t(i));

        I = f(1)/2;

        for i = 1:length(t)-1
            I = I + f(i);
        end

        I = h*(I + f(length(t))/2);
        
        a(k_) = 1/pi * I;
    end
end