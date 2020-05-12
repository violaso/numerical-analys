% --- PROJEKT KRETSEN ---
% @author Viola Söderlund
% @version 2020-05-11

load constants.mat;

% --- INTERPOLATION ---

h = 0.000001;
num_p = 1;

for i = 1:length(U0)
    Ustart = U0(i)
    
    [x, I, U] = rk4f(F, Ustart, num_p, h);
    [Imax, T] = plif(x, I)
end