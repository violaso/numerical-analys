% --- LABORATION 2 ---
% @author Viola Söderlund
% @version 2020-04-24

% 1. Olinjär modellanpassning

A = struct('x', 93, 'y', 63, 'r', 55.1);
B = struct('x', 6, 'y', 16, 'r', 46.2);
C = struct('x', 20, 'y', 83, 'r', 46.2);

f = @(x, p) ((x(1) - p.x)^2 + (x(2) - p.y)^2 - p.r^2);
F = @(x) [ f(x, A); f(x, B); f(x, C) ];

d_f = @(x, p) (2*(x - p));
G = @(x, p) [ d_f(x(1), p.x) d_f(x(2), p.y) ];
J = @(x) [ G(x, A); G(x, B); G(x, C) ];

    % Calculate P1
    
    disp('--- P1 ---');
    
    x0 = [ 40; 45 ]
    
        % Gauss-Newton
        
        [xn, iterations_count ] = calc_gn(x0, J, F);
    
        iterations_count

        P_1 = struct('x', xn(1), 'y', xn(2))
    
    % Calculate P2
    
    disp('--- P2 ---');
    
    x0 = [ 51; 21 ]
    
        % Gauss-Newton
    
        [xn, iterations_count ] = calc_gn(x0, J, F);
    
        iterations_count

        P_2 = struct('x', xn(1), 'y', xn(2))

% Plotting the circles

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
    plot([ P_1.x P_2.x ], [ P_1.y P_2.y ], '.');
hold off

% -- Gauss-Newton's Method --
% Uses linear least square method to approximate a minimal error value.
% J(xn)'*J(xn)*g = J(xn)'
% sn = g*F(xn)
% x(x+1) = xn + sn
function [ xn, iterations_count ] = calc_gn(xn, J, F)
    diff = [ -Inf, Inf ];
    iterations_count = 0;

    tolerance = 10^(-14);
    max_step = 100;
    
    for k=1:max_step
        iterations_count = iterations_count + 1;

        Jn = J(xn);
        Jt = Jn';
        Jps = (-Jt*Jn)\Jt; % psudoinverse of J
        diff = Jps*F(xn);
        xn = xn + diff;

        if abs(diff) <= tolerance
            break
        end
    end
end

% -- Newton's method --
% J(xn)*sn = -F(xn)
% x(n+1) = xn + sn
function [ xn, iterations_count ] = calc_n(xn, J, F)
    diff = [ -Inf, Inf ];
    iterations_count = 0;

    tolerance = 10^(-14);
    max_step = 100;
    
    for k=1:max_step
        iterations_count = iterations_count + 1;

        diff = -J(xn)\F(xn); 
        xn = xn + diff;

        if abs(diff) > tolerance
            break
        end
    end
end
