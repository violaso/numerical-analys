% --- LABORATION 2.3 ---
% @author Jakob Carlsson & Viola Söderlund
% @version 2020-04-17

clear;

s = 2;
beta = 1;
denominator = n_denominator(s, beta);

theta_bar = 40;

% these are the numbers we're changing to get the correct time, remember n=1/h
n_tra = 40;
n_sim = 10;

tic;
m = @(t) max(generator(theta_bar + t, 0));
f = @(t) exp(-beta*t^2)*m(t);

% use one of these two following lines:
%enumerator = calc_trapezoid(f, n_tra, -s, s);
enumerator = simpson(f, n_tra, -s, s);

m_bar = enumerator / denominator
toc % there's a stray tic in generator.m that needs to be commented out for this to work

% -- uppskatta felet --

% use one of these two following lines:
%enumerator_halfh = calc_trapezoid(f, n_tra*2, -s, s);
enumerator_halfh = simpson(f, n_tra*2, -s, s);

est_error = abs(enumerator_halfh - enumerator)

% Jag copy-pasteade denna från
% numerical_integration\numerical_integration.m
% och modifierade lite

function sum = simpson(f, num_intervals, lower_bound, upper_bound)
    h = (upper_bound - lower_bound) / num_intervals;
    
    odd_sum = 0;
    for i = 1:2:num_intervals-1
        odd_sum = odd_sum + f(lower_bound + h*i);
    end
    
    even_sum = 0;
    for i = 2:2:num_intervals-2
        even_sum = even_sum + f(lower_bound + h*i);
    end
    
    sum = (f(lower_bound) + 4*odd_sum + 2*even_sum + f(upper_bound)) * h/3;
end

% denna är också i princip en modifikation av den kopierade koden
function value = calc_trapezoid(f, num_intervals, lower_bound, upper_bound)
    h = (upper_bound - lower_bound) / num_intervals;
    
    sum = 0;
    for x_i = (lower_bound + h):h:(upper_bound - h)
        sum = sum + f(x_i);
    end
    
    value = h * (f(lower_bound)/2 + sum + f(upper_bound)/2);
end

function value = n_denominator(s, beta)
    f = @(t) exp(-beta*t.^2);
    %value = simpson(f, 10000, -s, s); % second arg is the number of intervals
    value = integral(f, -s, s, 'RelTol', eps, 'AbsTol', eps);
end
