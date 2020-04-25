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

figure('Name', 'a) Integralen av f i [-1, 1]', 'NumberTitle', 'off');
fplot(f, [-1 1]);

I = 2*sqrt(3) - 2/3;

% b) Approximerar integralen med trapetsregeln.

disp('--- B. ---');

h = [1 0.5 0.25 0.125 0.0625];

results = zeros(length(h), 3);

disp('results: h, T_h, diff.')

T_h = trapezoidal(f, h(1));
results(1,:) = [ h(1) T_h NaN ];

for i = 2:length(h)
    old = T_h;
    T_h = trapezoidal(f, h(i));
    results(i,:) = [ h(i) T_h (T_h - old) ];
end

results

disp('Approximationen konvergerar när h -> 0.');

% c) Undersöker felet

disp('--- C. ---');

results = zeros(length(h), 4);

disp('results: h, err, diff., teoretical_limit')

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

figure('Name', 'e) Verifiera noggrannhetsordning trapetsregeln', 'NumberTitle', 'off');
    x = logspace(-6,0);
    y = zeros(1, length(x));
    
    for i_ = 1:length(x)
        y(i_) = abs(trapezoidal(f, x(i_)) - I);
    end
    loglog(x,y);
    
    hold on;
    
    for i_ = 1:length(x)
        y(i_) = abs(trapezoidal(f, x(i_) / 2) - I);
    end
    loglog(x,y);
    
    hold on;
    
    y = x*2;
    loglog(x, y);
    
    legend('Ch^p', 'C(h/2)^p', 'h^2', 'Location', 'southeast')
    
    grid on
hold off;

figure('Name', 'e) Verifiera noggrannhetsordning Simpsons regel', 'NumberTitle', 'off');
    x = logspace(-6,0);
    y = zeros(1, length(x));
    
    for i_ = 1:length(x)
        y(i_) = abs(simpson(f, x(i_)) - I);
    end
    loglog(x,y);
    
    hold on;
    
    for i_ = 1:length(x)
        y(i_) = abs(simpson(f, x(i_) / 2) - I);
    end
    loglog(x,y);
    
    hold on;
    
    y = x*4;
    loglog(x, y);
    
    legend('Ch^p', 'C(h/2)^p', 'h^4', 'Location', 'southeast')
    
    grid on
hold off;

disp('Approximationen visar att metoderna kan beskrivas med:');
disp('-- Trapets: e(h) = O(h^2)');
disp('-- Simpsons: e(h) = O(h^4)'); 
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