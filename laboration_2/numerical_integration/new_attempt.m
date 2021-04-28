% --- LABORATION 2 ---
% @author Jakob Carlsson & Viola Söderlund
% @version 2020-04-25

format long

% 2. Numerisk integration

h = [1, 0.5, 0.25, 0.125, 0.0625];
f = @(x) sqrt(x+2);

% a) Ritar grafen och ber�knar integralen analytiskt.

disp('--- A. ---');

figure('Name', 'a) Integralen av f i [-1, 1]', 'NumberTitle', 'off');
fplot(f, [-1 1]);

I = integral(f, -1, 1, 'RelTol', eps, 'AbsTol', eps)

% b, c, d) Approximerar integralen med trapetsregeln.

disp('--- B-D. ---');

y_t = zeros(1, length(h));
y_s = y_t;
e_t = y_t;
e_s = y_t;
for i = 1:length(h) 
    y_t(i) = trapezoidal(f, h(i));
    y_s(i) = simpson(f, h(i));
    e_t(i) = abs(y_t(i) - I);
    e_s(i) = abs(y_s(i) - I);
end

Th = [h; y_t; e_t]'
Sh = [h; y_s; e_s]'

figure('Name', 'e) Verifiera noggrannhetsordning', 'NumberTitle', 'off');
loglog(h, e_t, '-s');
hold on;
    loglog(h, e_s, '-s');
    loglog(h, h.^2, '-s');
    loglog(h, h.^4, '-s');
    
    legend('Trapets', 'Simpsons', 'h^2', 'h^4', 'Location', 'southeast');
    grid on;
hold off;

% -- Trapezoidal Rule --
% Composite quadrature rule for approximtion of integrals.
% S = f(0)/2 + sum f[1..(n-1)] + f(n)/2
% I = S * dx
function sum = trapezoidal(f, h)
    sum = f(-1) / 2;

    for x_i = (-1 + h):h:(1 - h)
        sum = sum + f(x_i);
    end
    
    sum = (sum + f(1) / 2) * h;
end

% -- Simpson's Rule --
% Composite Simpson's 1/3 rule.
% S_even = sum f([2:2:n-2])
% S_odd = sum f([1:2:n-1])
% S = f(0) + 2*S_even + 4*S_odd + f(n)
% I = S * dx/3
function sum = simpson(f, h)
    n = 2 / h;

    odd_sum = 0;
    for i = 1:2:n-1
        odd_sum = odd_sum + f(-1 + h*i);
    end
    
    even_sum = 0;
    for i = 2:2:n-2
        even_sum = even_sum + f(-1 + h*i);
    end
    
    sum = (f(-1) + 4*odd_sum + 2*even_sum + f(1)) * h/3;
end