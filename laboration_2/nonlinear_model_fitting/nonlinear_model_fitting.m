% --- LABORATION 2 ---
% @author Viola Söderlund
% @version 2020-04-24

% 3. Olinjär modellanpassning

A = struct('x', 93, 'y', 63, 'r', 55.1);
B = struct('x', 6, 'y', 16, 'r', 46.2);
C = struct('x', 20, 'y', 83, 'r', 46.2);

% Gauss-Newton's method

f = @(x, p) ((x(1) - p.x)^2 + (x(2) - p.y)^2 - p.r^2);
F = @(x) [ f(x, A); f(x, B); f(x, C) ];

f_x = @(x, p_x) (2*(x - p_x));
f_y = @(y, p_y) (2*(y - p_y));
G = @(x, p) [ f_x(x(1), p.x) f_y(x(2), p.y) ];
J = @(x) [ G(x, A); G(x, B); G(x, C) ];

    % Calculate P1
    
    disp('--- P1 ---');
    
    x0 = [ 34; 54 ]
    
        % Gauss-Newton
        
        [xn, iterations_count ] = calc_gn(x0, J, F);
    
        iterations_count_gn = iterations_count

        P_1_gn = struct('x', xn(1), 'y', xn(2))
        
        % Newton
        
        xn = calc_n(x0, J, F);
        
        P_1_n = struct('x', xn(1), 'y', xn(2));
    
    % Calculate P2
    
    disp('--- P2 ---');
    
    x0 = [ 51; 21 ]
    
        % Gauss-Newton
    
        [xn, iterations_count ] = calc_gn(x0, J, F);
    
        iterations_count

        P_2_gn = struct('x', xn(1), 'y', xn(2))
        
        % Newton
        
        xn = calc_n(x0, J, F);

        P_2_n = struct('x', xn(1), 'y', xn(2));

% Plotting the circles

disp('Figuren bör visa samma svar som i laboration_1: nonlinear_equation_system. Detta för att indatan är detsamma som i nämnd föregående uppgift.');

hold on
    radians = 0:pi/50:2 * pi;
    x_unit = @(radius, offset_x) (radius*cos(radians) + offset_x);
    y_unit = @(radius, offset_y) (radius*sin(radians) + offset_y);
    
    radius = A.r; 
    plot(x_unit(radius, A.x), y_unit(radius, A.y));
    
    radius = B.r;
    plot(x_unit(radius, B.x), y_unit(radius, B.y));
    
    radius = C.r;
    plot(x_unit(radius, C.x), y_unit(radius, C.y));
    
    plot([ A.x B.x C.x ], [ A.y B.y C.y ], '.');
    plot([ P_1_n.x P_2_n.x ], [ P_1_n.y P_2_n.y ], '.');
    plot([ P_1_gn.x P_2_gn.x ], [ P_1_gn.y P_2_gn.y ], '.');
hold off

function [ xn, iterations_count ] = calc_gn(xn, J, F) % Gauss-Newton
    diff = [ -Inf, Inf ];
    iterations_count = 0;

    while true
        iterations_count = iterations_count + 1;
        
        J_xn = J(xn);
        diff = (J_xn' * J_xn) \ (J_xn' * F(xn));
        xn = xn - diff;
    
        if norm(diff) <= 10^(-14)
            break
        end
    end
end

function xn = calc_n(xn, J, F) % Gauss
    diff = [ -Inf, Inf ];

    while true
        diff = -J(xn)\F(xn); % J(xn)*sn = -F(xn), x(n+1) = xn + sn
        xn = xn + diff;
    
        if norm(diff) <= 10^(-14)
            break
        end
    end
end
