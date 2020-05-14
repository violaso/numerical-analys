% --- PROJEKT KRETSEN ---
% @author Viola Söderlund
% @version 2020-05-11

function U = smf(xn_left, xn_right, F)
%  Secant method function (SMF) Returns voltage for given range of periods.
%   inputs:
%   - xn_left is the lower period guess 
%   - xn_right is the higher period guess
%   - F is the relationship definitions of the circuit current and voltage
%   outputs:
%   - U is approximated voltage
    next_xn = @(xn_left, xn_right) (xn_left - get_period_f(xn_left, F) * (xn_left - xn_right) / (get_period_f(xn_left, F) - get_period_f(xn_right, F)));

    last_approximation = Inf;
    while true
        xn_new = next_xn(xn_left, xn_right);
        approximation = get_period_f(xn_new, F);
   
        if approximation <= eps
            U = xn_new;
            break
        elseif approximation < 0
            xn_left = xn_new;
        else % approximation > 0
            xn_right = xn_new;
        end
        
        last_approximation = approximation;
    end
end