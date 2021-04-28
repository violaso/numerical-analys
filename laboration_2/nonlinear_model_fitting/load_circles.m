% clear
clc;
delete(findall(groot, 'Type', 'figure', 'FileName', []));

% --- LABORATION 1 ---
% @author Viola Söderlund
% @version 2020-03-22

% 3. Olinjärt ekvationsystem

A = struct('x', 93, 'y', 63, 'r', 55.1);
B = struct('x', 6, 'y', 16, 'r', 46.2);
C = struct('x', 20, 'y', 83, 'r', 46.2);

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
hold off