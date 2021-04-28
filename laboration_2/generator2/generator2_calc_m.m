% --- LABORATION 2.3 ---
% @author Jakob Carlsson & Viola Söderlund
% @version 2020-04-17

format long

% 3. Generator 2

s = 2;
beta = 1;
theta_bar = 40;

% a) Beräknar nämnaren.

disp('--- A. ---');

f = @(t) exp(-beta*t.^2);
denominator = integral(f, -s, s, 'RelTol', eps, 'AbsTol', eps)

% b, c) Beräknar täljaren och m.

% these are the numbers we're changing to get the correct time, remember n=1/h
n_tra = 70;
n_sim = 70;

m = @(t) max(generator(theta_bar + t, 0));
f = @(t) exp(-beta*t^2)*m(t);

disp('--- B. ---');

tic;
enumerator_t = trapezoid(f, n_tra, -s, s);
numerator_t = enumerator_t
m_bar_t = enumerator_t / denominator
toc;

tic;
enumerator_halfh_t = trapezoid(f, n_tra*2, -s, s);
est_error_t = abs(enumerator_halfh_t - enumerator_t)
toc;

disp('--- C. ---');

tic;
enumerator_s = simpson(f, n_sim, -s, s);
numerator_s = enumerator_s
m_bar_s = enumerator_s / denominator
toc;

tic;
enumerator_halfh_s = simpson(f, n_sim*2, -s, s);
est_error_s = abs(enumerator_halfh_s - enumerator_s)
toc;

% -- Simpson's Rule --
% Composite Simpson's 1/3 rule.
% S_even = sum f([2:2:n-2])
% S_odd = sum f([1:2:n-1])
% S = f(0) + 2*S_even + 4*S_odd + f(n)
% I = S * dx/3
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

% -- Trapezoidal Rule --
% Composite quadrature rule for approximtion of integrals.
% S = f(0)/2 + sum f[1..(n-1)] + f(n)/2
% I = S * dx
function value = trapezoid(f, num_intervals, lower_bound, upper_bound)
    h = (upper_bound - lower_bound) / num_intervals;
    
    sum = 0;
    for x_i = (lower_bound + h):h:(upper_bound - h)
        sum = sum + f(x_i);
    end
    
    value = h * (f(lower_bound)/2 + sum + f(upper_bound)/2);
end