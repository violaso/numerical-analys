% --- PROJEKT KRETSEN ---
% @author Viola Söderlund
% @version 2020-05-11

load constants.mat;

% --- ASSESS VOLTAGE FOR FREQUENCY ---

% Seeking U* = U_ for given frquency fq = 400, where
% fq = 1 / T

% Since (refers to assess_max_and_period)
%   period T for U0 = 2300 < seeked T, and
%   period T for U0 = 1500 > seeked T

x0_left = 2300;
x0_right = 1500;

U_ = smf(x0_left, x0_right, F)

% Fault check:

% fq = 400;
% correct_T = 1 / fq
% 
% T = get_period_f(U, F);
% calculated_T = T

h = 0.000001;
num_p = 1;

[x, I, U] = rk4f(F, U_, num_p, h);
[Imax, T] = plif(x, I);

I_max = Imax