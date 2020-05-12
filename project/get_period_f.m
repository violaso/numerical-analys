% --- PROJEKT KRETSEN ---
% @author Viola Söderlund
% @version 2020-05-11

function T = get_period_f(U0, F)
%  GET_PERIOD_F Returns the corresponding period of the current curve for a given voltage.
%  inputs:
%   - U0 is the start voltage value for the current approximation
%   - F is the relationship definitions of the circuit current and voltage
%  outputs:
%   - T is the period of the approximated current curve for a given voltage.
    fq = 400;
    T_ = 1 / fq;
    
    h = 0.000001;
    num_p = 1;

    [x, I, U] = rk4f(F, U0, num_p, h);
    [Imax, T] = plif(x, I);
    
    T = T - T_;
end