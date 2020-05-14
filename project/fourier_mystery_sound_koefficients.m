% --- PROJEKT KRETSEN ---
% @author Viola Söderlund
% @version 2020-05-11

load constants.mat;
load signals.mat;
load mysterysoundlong.mat;

% --- INVESTIGATE MYSTERY SOUND ---

% Calculate a3/a1 for sound:

disp('NOTE: a_3/a_1 = a_');

num_k = 3;
p = 2*pi*400;

h = p / length(y);
x = 0:h:p-h;

[k, a] = trf(x, y, num_k, h);

mystery_a_ = a(3) / a(1)

disp('Simulated sounds:');

U0

% NOTE: Numbers are from 'fourier_series'
[-0.0031/0.9968 -0.1395/0.8231 -0.2269/0.5428]
