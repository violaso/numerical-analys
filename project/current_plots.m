% --- PROJEKT KRETSEN ---
% @author Viola S�derlund
% @version 2020-05-10

% --- CONSTANTS ---

% Inductance [Wb/A (Weber/ampere) = H (Henry)]
% - The ratio of the induced voltage to the rate of change of current.
% - The relationship between the magnetic flux and the current.
L0 = 0.7;

% Current [A (ampere)]
I0 = 1;

% Capacitance [C/V (Coulomb/volt) = F (Farad)]
% - The ratio of the change in electric charge of a system, to the corresponding change in its electric potential.
% - Measure of the ability to store electrical charge.
C = 0.5 * 10^6;

% --- RELATIONSHIPS ---

% U(t) = L(t) * I'(t)
% I(t) = -(C * U'(t))

% --- ASSESS OSCILLATING PERIOD ---

% Seeking the frequency (fq) and period (p) of the circuit, where
% fq = 1 / p

% I is periodic, viz
% I(t) = A*sin(B*x + C), where
% - Amplitude: A
% - Period: 2*pi/B
% - Phase Shift: -C/B
% => I'(t) = A*B*cos(B*t + C)
% => I''(t) = -A*B^2*sin(B*t + C)

% Given the relationships,
% U = L*I' <=> U' = L*I''
% I = -(C*U') <=> I = -(C*L*I'') <=> 1/(-C*L) * I = I''

% => 1/(-C*L) * A*sin(B*x + C) = -A*B^2*sin(B*t + C)
% <=> -B^2 = 1/(-C*L)
% <=> B = sqrt(1/(C*L))

% If
L = L0;
% then
p = 2*pi / sqrt(1/(C*L))
fq = 1 / p

% When L = L0 or t = 0,
P = p;

% --- CURRENT GRAPTHS ---

% Defining I(t) as y' = f(t, y).

% Assuming that the phase shift is constant, since I = 0 when t = 0,
% I(t) = A*sin(2*pi/P*t + C)
% <=> C = 0

% => I'(t) = A*2*pi/p*cos(2*pi/p*t)

% Assuming that the amplitude is constant, and since L = L0 when t = 0,
% U0 = L0*I'(0) = L0*A*2*pi/P*cos(0) = L0*A*2*pi/P
% <=> A = U0/(L0*2*pi/P)

% => I(t) = U0/(L0*2*pi/P) * sin(2*pi/p*t)
% => I'(t) = U0/(L0*2*pi/P) * 2*pi/p*cos(2*pi/p*t)
%          = { sin(x + pi/2) = cos(x) }
%          = 2*pi/p * I(t + p/4)
%          = 2*pi/p * U0/(L0*2*pi/P) * sin(2*pi/p*t + pi/2)
%          = { sin(a + b) = sin(a)*cos(b) + cos(a)*sin(b) }
%          = 2*pi/p * U0/(L0*2*pi/P) * (sin(2*pi/p*t)*cos(pi/2) + cos(2*pi/p*t)*sin(pi/2))
%          = 2*pi/p * (I(t)*cos(pi/2) + U0/(L0*2*pi/P) * cos(2*pi/p*t)*sin(pi/2))
%          = 2*pi/p * U0/(L0*2*pi/P) * cos(2*pi/p*t)
%          = U0*P/(L0*p) * cos(2*pi/p*t)
%          = f(t, I(t))

disp('I(t) = A * sin(B*t), where')
A = U0/(L0*2*pi/P)
B = 2*pi/p

% Runge-Kutta:

h = 0.1;

L = @(I) L0 * I0^2/(I0^2+I^2);
p = @(I) 2*pi / sqrt(1/(C*L(I)));

f = @(t, I, U0) U0*P/(L0*p(I)) * cos(2*pi/p(I)*t);
f = @(t, I, U0) U0*P/(L0) * cos(2*pi/p(I)*t);

runge_kutta(h, f, 220, P, p, L0);
hold on;
%runge_kutta(h, f, 1500, P);
hold on;
%runge_kutta(h, f, 2300, P);

legend('220 V', '1500 V', '2300 V', 'Location', 'southwest');

function runge_kutta(h, f, U0, P, p, L0)
    In = 0;
    y = In;
    
    x = 0;
    tn = x;

    for tn = 0:h:P
        s1 = f(tn, In, U0);
        s2 = f(tn + h/2, In + h/2*s1, U0);
        s3 = f(tn + h/2, In + h/2*s2, U0);
        s4 = f(tn + h, In + h*s3, U0);

        In = In + h/6*(s1 + 2*s2 + 2*s3 + s4);
        
        x = [x; tn];
        y = [y; In];
    end
    
    plot(x, y);
    hold on;
    plot(x, zeros(1, length(x)), '--', 'HandleVisibility', 'off'); % x-axis
end