% --- LABORATION 1 ---
% @author Viola Söderlund
% @version 2020-03-21

% 1. Olinjär skalär ekvation

% Problem: Bestäm samtliga rötter till ekvationen:
% x^2 - 3sin(3x + 2) - 1 = 0

f = @(x) (x^2 - 3*sin(3*x + 2) - 1);
Df = @(x) (2*x - 9*cos(3*x + 2));

% a. Ritar graften till funktionen.

range = [-0.8, 0.5];
fplot(f, range)
hold on
fplot(@(x) 0, range)
hold off

% b. Undersöker vilka av funktionens rötter som kan bestämmas av
%    fixpunktsiterationen next_x(x*) = x*, och beräknar sedan rötterna.

disp('--- b. Fixpunktiterationer ---');

next_x = @(x) (f(x) / 9 + x);
Dnext_x = @(x) (Df(x) / 9 + 1);

    % Fall 1
    xn = -0.6;
    
    disp('Examining function around start guess...');
    xn
    
    [convergens, num_iterations, solution] = get_convergens(next_x, xn);
    
    if convergens
        disp('--> Fixpunktsiterationen konvergerar mot första nollvärdet x* med givet antal iterationer.');
        
        get_is_quadratic(Dnext_x, solution);
    else
        disp('--> Fixpunktsiterationen divergerar mot första nollvärdet.');
    end
        
    % Fall 2
    xn = 0.48;
    
    disp('Examining function around start guess...');
    xn
    
    [convergens, num_iterations, solution] = get_convergens(next_x, xn);
    
    if convergens
        disp('--> Fixpunktsiterationen konvergerar mot andra nollvärdet x* med givet antal iterationer.');
        
        get_is_quadratic(Dnext_x, solution);
    else
        disp('--> Fixpunktsiterationen divergerar mot andra nollvärdet.');
    end
    
    disp('--> Correction: Andra nollvärdet är en falsk lösning! Endast första nollvärdet är sann.')

% c. Beräknar rötterna med Newtons metod.

disp('--- b. Newtons metod ---')

next_x = @(x) (xn - f(x) / Df(x));

    % Fall 1
    xn = -0.73;
    x0 = xn
    
    [num_iterations, solution] = calculate_solution(next_x, xn, next_x(xn));
    
    disp('--> Fixpunktsiterationen konvergerar mot första nollvärdet x* med givet antal iterationer.');
        
    % Fall 2
    xn = 0.5;
    x0 = xn
    
    [num_iterations, solution] = calculate_solution(next_x, xn, next_x(xn));
    
    disp('--> Fixpunktsiterationen konvergerar mot andra nollvärdet x* med givet antal iterationer.');
    
% Checks if iterations are quadratic by examining it's derivitive function.
function is_quadratic = get_is_quadratic(Dnext_x, xn)
    if Dnext_x(xn) == 0
        disp('----> Iterationen konvergerar kvadratiskt.');
        
        is_quadratic = true;
    else
        disp('----> Iterationen konvergerar inte kvadratiskt.');
        
        is_quadratic = false;
    end
end

% Checks if iterations are convergent and if true, calculates the solution.
function [convergens, num_iterations, solution] = get_convergens(next_x, xn)
       
    % Check convergens
    
    xn_incremented = next_x(xn);
        
    if abs(xn_incremented) > 1
        disp('Fixpunksiterationen divergerar runt xn = x0 ? x*.');
        xn
            
        convergens = false;
    elseif abs(xn_incremented) < 0.1
        disp('Fixpunktsiterationen konvergerar snabbt runt xn = x0 ? x*.');
        xn
            
        convergens = true;
    else
        disp('Fixpunktsiterationen konvergerar runt xn = x0 ? x*.');
        xn

        convergens = true;
    end
    
    % Calculate solution
    
    num_iterations = -1;
    solution = Inf;
        
    if convergens
            
        [num_iterations, solution] = calculate_solution(next_x, xn, xn_incremented)
    end
end

% Iterates a soluition given values that converge.
function [num_iterations, solution] = calculate_solution(next_x, xn, xn_incremented)

    max_iterations = 100;
    
    % Calculate solution
    
    iterations = xn;
    
    num_iterations = -1;
    solution = Inf;
    
    disp('Iterating...')
        
    count = 1;
    while xn_incremented ~= xn && count < max_iterations
        xn = xn_incremented;
        xn_incremented = next_x(xn);
                
        count = count + 1;
        
        iterations = [ iterations;xn ];
    end
    
    num_iterations = count;
    solution = xn;
    
    iterations
    num_iterations
       
    solution
end