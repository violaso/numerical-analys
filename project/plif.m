% --- PROJEKT KRETSEN ---
% @author Viola Söderlund
% @version 2020-05-11

function [Imax, T] = plif(x, y)
%  Piecewise linear interpolation (PLIF) Returns Imax and period T given points from runge_kutta.
%   inputs:
%   - x is a vector of x-coordinats values 
%   - y is a vector of y-coordinats values of the same length as 'x'
%   - NOTE: The points must represent a function with an extreme maximum point as well as an nonorigin root.
%   outputs:
%   - Imax is the y-value of the functions extreme maximum point
%   - T is the functions period, assuming that the points represents a portion of a periodic function 
    Imax = 0;
   
    for i = 1:length(x)-1
        k = (y(i+1) - y(i)) / (x(i+1) - x(i));
        
        if Imax == 0 && (k < 0 || k == 0)
            Imax = y(i);
        elseif Imax ~= 0 && y(i) > 0 && y(i + 1) < 0
            x_ = -y(i)/k + x(i); % point-slope form
            
            T = 2*x_;
            
            break;
        end
    end
end