% --- LABORATION 2 ---
% @author Viola Söderlund
% @version 2020-04-14

% clear

clc;
delete(findall(groot, 'Type', 'figure', 'FileName', []));

% 3. Numerisk integration

f = @(x) sqrt(x + 2);
f_d = @(x) 1 / (2 * sqrt(x + 2));
f_d2 = @(x) -(1 / (4 * (x + 2) * sqrt(x + 2)));

% a) Ritar grafen och beräknar integralen analytiskt.

disp('--- A. ---');

figure;
fplot(f, [-1 1]);

I = integral(f, -1, 1)

% b) Approximerar integralen med trapetsregeln.

disp('--- B. ---');

h = [1 0.5 0.25 0.125 0.0625];
results = zeros(length(h), 3);

disp('results: h, T_h, diff.')

S_h = trapezoidal(f, h(1));
results(1,:) = [ h(1) S_h NaN ];

for i = 2:length(h)
    old = S_h;
    S_h = trapezoidal(f, h(i));
    results(i,:) = [ h(i) S_h (S_h - old) ];
end

results

disp('Approximationen konvergerar när h -> 0.');

% c) Undersöker felet

disp('--- C. ---');

results = zeros(length(h), 4);

disp('results: h, T_h, diff., teoretical_limit')

err = abs(I - trapezoidal(f, h(1)));
results(1,:) = [ h(1) err NaN error(f_d2, h(1)) ];

for i = 2:length(h)
    old = err;
    err = abs(I - trapezoidal(f, h(i)));
    results(i,:) = [ h(i) err (err / old) error(f_d2, h(i)) ];
end

results

disp('Felet minskar ca. 4 gånger då h halveras.');
disp('Teorin säger att felet överensstämmer med felet i styckvis linjär interpolation, vilket visar sig stämma.');

% d) Approximerar integralen med Simpsons formel.

disp('--- D. ---');

results = zeros(length(h), 3);

disp('results: h, S_h, error')

for i = 1:length(h)
    S = simpson(f, h(i));
    results(i,:) = [ h(i) S abs(I - S) ];
end

results

disp('Approximationen konvergerar när h -> 0.');

% e) Plottar felet

% Hämtar felet av trapetsapproximationen och Simpsonsapproximationen.

y_T = zeros(1, length(h));
y_S = y_T;
for i = 1:length(h)
   y_T(i) = abs(trapezoidal(f, h(i)) - I);
   y_S(i) = abs(simpson(f, h(i)) - I);
end
 
% 
% Modellen har ingen konstantterm c, då y -> 0 när h -> 0.

fit_type = fittype( ...
    'a*x^b', ...
    'dependent', { 'y' }, ...
    'independent', { 'x' }, ...
    'coefficients', { 'a', 'b' });

trapezoidal_fitmodel = fit(h', y_T', fit_type)
coefficientValues = coeffvalues(trapezoidal_fitmodel);
a_T = coefficientValues(1);
b_T = coefficientValues(2);

simpson_fitmodel = fit(h', y_S', fit_type)
coefficientValues = coeffvalues(simpson_fitmodel);
a_S = coefficientValues(1);
b_S = coefficientValues(2);

figure;
hold on;
    x = logspace(-2,0);
    
    y = a_T * x.^b_T;
    loglog(x,y);
    
    y = a_S * x.^b_S;
    loglog(x,y);
    
    legend('Trapets', 'Simpsons', 'Location', 'northwest')
    
    grid on
hold off;

disp('Approximationen visar att metoderna kan beskrivas med:');
disp('-- Trapets: e(h) = 0.0172 * h^1.9769 = O(h^1.9769) < O(h^2) --> Stämmer med teorin');
disp('-- Simpsons: e(h) = 1.1536 * h^0.9993 = O(h^0.9993) < O(h)'); % vill ha närmare O(h^4)

% Notis: Eftersom f är fyra gånger deriverbar, borde funktionen ha
% noggrannhetsordning 4.

function app_error = error(f, h)
    f_range = f(-1);
    for x = -0.999:0.001:1
        f_range = [ f_range; abs(f(x)) ];
    end
    
    [y_max ind] = max(f_range);
    
    app_error = abs(y_max * (-1 - 1) / 12 * h*h);
end

function sum = trapezoidal(f, h)
    sum = f(-1) / 2;

    for x_i = (-1 + h):h:(1 - h)
        sum = sum + f(x_i);
    end
    
    sum = (sum + f(1) / 2) * h;
end

function sum = simpson(f, h)
    odd_sum = 0;
    even_sum = 0;
    for x_i = (-1 + h):h*2:(1 - h)
        odd_sum = odd_sum + f(x_i);
        even_sum = even_sum + f(x_i + h);
    end
    
    sum = (f(-1) + 4 * odd_sum + 2 * even_sum + f(1)) * h / 3;
end