% --- PROJEKT KRETSEN ---
% @author Viola Söderlund
% @version 2020-05-11

function [t, v] = vf(U0, F, h)
%  VF Returns a balanced current curve with T = 2*pi and Imax = 1.
%  inputs:
%   - U0 is the start voltage value for the current approximation
%   - F is the relationship definitions of the circuit current and voltage
%   - h step length of the approximation
%  outputs:
%   - t is the x-values of the output curve.
%   - v is the y-values of the output curve.
    num_p = 2;
    
    [x, I, U] = rk4f(F, U0, num_p, h);
    [Imax, T] = plif(x, I);
    
    t = 0:h:2*pi;
    tn = 0;
    v = [];
    
    i = 1;
    for tn = t
        target_t = (tn * T / (2*pi));
        
        nearest_t = x(i);
        while x(i+1) < target_t
            i = i + 1;
            nearest_t = x(i);
        end
        
        if abs(nearest_t - target_t) > abs(x(i+1) - target_t)
            i = i + 1;
        end
        
        v = [v I(i)/Imax];
    end
end