% --- LABORATION 2.4b ---
% @author Viola Söderlund
% @version 2020-04-19

format long

% 4. Robotarm

disp('--- A. ---');

th_ = robotarm_get_theta(1.3, 1.3, false);

theta = th_

disp('--- B. ---');

f = 4;
amp = 0.5;
fq = 3*pi;
alpha = 2;

% Standardform
% - Format required to solve with Euler method. 
% y'' = f(t,y,y'), y(0) = y0, y'(0) = y1
% u0(t) = y(t), u1(t)=y'(t), u(t) = [u0(t); u1(t)]
% u' = [u0'; u1'] = [y'; y''] = [y'; f(t,y,y')] = [u1; f(t,u0,u1)] = F(t,u)
% u(0) = [y(0); y'(0)] = [y0; y1] = u-0
% u' = F(t,u), u(0) = u-0

% Angle 1
f_1 = @(t, th, D_th) -alpha*(th - th_(1)) - f*D_th + amp*sin(fq*t);
F_1 = @(t, th, D_th) [ D_th; f_1(t, th, D_th) ];
D_u_1 = @(t, u) F_1(t, u(1), u(2))

% Angle 2
f_2 = @(t, th, D_th, D_th_1) -alpha*(th - th_(2)) - f*(D_th + abs(D_th_1)) + amp*sin(fq*t);
F_2 = @(t, th, D_th, D_th_1) [ D_th; f_2(t, th, D_th, D_th_1) ];
D_u_2 = @(t, u, D_th_1) F_2(t, u(1), u(2), D_th_1)

disp('--- C. ---');

% Angle 1
th0 = pi / 2;
D_th0 = 0;
u_1 = [th0; D_th0];

% Angle 2
th0 = pi / 6;
D_th0 = 0;
u_2 = [th0; D_th0];

h = 0.1;

% Forward Euler method
% - Simplest Runge-Kutta method for solving ordinary 
%   differential equations (ODEs).
% y_n+1 = y_n + hf(t_n, y_n)
% u_n+1 = u_n + hF(t_n, y_n, D_y_n)

figure('Name', 'Robotarm', 'NumberTitle', 'off');

for t=0:h:15
    u_2 = u_2 + h*D_u_2(t, u_2, u_1(2));
    u_1 = u_1 + h*D_u_1(t, u_1);
    
    plot_robotarm([ u_1(1), u_2(1) ]);
end

u = [ u_1(1), u_2(2) ]