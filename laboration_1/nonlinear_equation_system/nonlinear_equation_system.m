% --- LABORATION 1 ---
% @author Viola Söderlund
% @version 2020-03-27

% 3. Olinjärt ekvationsystem

A = struct('x', 93, 'y', 63, 'r', 55.1);
B = struct('x', 6, 'y', 16, 'r', 46.2);

% Newton's method

f = @(x, p) ((x(1) - p.x)^2 + (x(2) - p.y)^2 - p.r^2);
F = @(x) [ f(x, A); f(x, B) ];

f_x = @(x, p_x) (2*(x - p_x));
f_y = @(y, p_y) (2*(y - p_y));
G = @(x, p) [ f_x(x(1), p.x) f_y(x(2), p.y) ];
J = @(x) [ G(x, A); G(x, B) ];

    % Calculate P1
    x0 = [ 34; 54 ]
    xn = calc(x0, J, F);
    
    if J(xn) ~= [ 0 0; 0 0 ]
        disp('Metoden har en kvadratisk konvergens.');
    else
        disp('Metoden har inte kvadratisk konvergens.');
    end

    P_1 = struct('x', xn(1), 'y', xn(2))
    
    % Calculate P2
    x0 = [ 51; 21 ]
    xn = calc(x0, J, F);
    
    if J(xn) ~= [ 0 0; 0 0 ]
        disp('Metoden har en kvadratisk konvergens.');
    else
        disp('Metoden har inte kvadratisk konvergens.');
    end

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
    
    plot([ A.x B.x ], [ A.y B.y ], '.');
    plot([ P_1.x P_2.x ], [ P_1.y P_2.y ], '.');
hold off

function xn = calc(xn, J, F)
    diff = [ -Inf, Inf ];

    while true
        diff = -J(xn)\F(xn); % J(xn)*sn = -F(xn), x(n+1) = xn + sn
        xn = xn + diff;
    
        if sqrt(diff(1)^2 + diff(2)^2) <= 10^(-14)
            break
        end
    end
end
