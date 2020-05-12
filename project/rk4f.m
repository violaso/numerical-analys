% --- PROJEKT KRETSEN ---
% @author Viola Söderlund & Jakob Carlsson
% @version 2020-05-12

%load constants.mat;

% --- TEST ---

% L = @(I) L0 * I0^2/(I0^2+I^2);
% F = @(t, y) [y(2)/L(y(1)) y(1)/(-C)];% = [I'(t); U'(t);] 
% 
% [x, I, U] = rk4f(F, 220, 2, 0.0001);
% 
% plot(x, I);
% hold on;
% plot(x, zeros(1, length(x)), '--', 'HandleVisibility', 'off'); % x-axis

function [x, I, U] = rk4f(F, U0, p, h)
%   RK4F Solve a system of ODEs using Runge-Kutta 4
%   inputs:
%   - F is a function handle with [t, [y(n)]] -> [y'(n)]
%   - U0 is the starting value for U, which in this case is what can vary
%   - p is the number of periods to calculate
%   - h is the step length
%   outputs:
%   - x is the x-values of the points we calculated
%   - I is the y-value of the points in the function I
%   - U is the y-value of the points in the function U
    
    I0 = 0;
    yn = [I0 U0];
    y = yn;
    
    tn = 0;
    x = tn; 
    
    counter = 1;

    while counter < 2*p+1
        s1 = F(tn, yn);
        s2 = F(tn + h/2, yn + h/2*s1);
        s3 = F(tn + h/2, yn + h/2*s2);
        s4 = F(tn + h, yn + h*s3);

        old = yn(1);
        yn = yn + h/6*(s1 + 2*s2 + 2*s3 + s4);
        
        if (old < 0 && yn(1) > 0) || (old > 0 && yn(1) < 0) || yn(1) == 0
            % i.e. if the plot passes the x-axis
           counter = counter + 1; 
        else 
            y = [y; yn];
        
            tn = tn + h;
            x = [x; tn];
        end
    end
    
    I = y(:, 1);
    U = y(:, 2);
end
