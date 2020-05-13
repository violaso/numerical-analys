% --- PROJEKT KRETSEN ---
% @author Jakob Carlsson
% @version 2020-05-13

load constants.mat;

% --- SHOW CONSTANT CAPACITANCE ---

h = 1e-6
p = 40

tic;
%calculate
[x220, I220, U220] = rk4f(F, 220, p, h);
[x1500, I1500, U1500] = rk4f(F, 1500, p, h);
[x2300, I2300, U2300] = rk4f(F, 2300, p, h);

% pre-allocate
E220 = x220;
E1500 = x1500;
E2300 = x2300;

for n=1:length(x220)
    E220(n) = (1/2)*C*U220(n)^2 + (1/2)*L0*I0^2*log(I0^2 + I220(n)^2); % log is the nl
end

for n=1:length(x1500)
    E1500(n) = (1/2)*C*U1500(n)^2 + (1/2)*L0*I0^2*log(I0^2 + I1500(n)^2);
end

for n=1:length(x2300)
    E2300(n) = (1/2)*C*U2300(n)^2 + (1/2)*L0*I0^2*log(I0^2 + I2300(n)^2);
end

toc

plot(x220, E220)
hold on;
plot(x1500, E1500)
plot(x2300, E2300)
legend('220 V', '1500 V', '2300 V', 'Location', 'northeast');
