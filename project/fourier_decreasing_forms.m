% --- PROJEKT KRETSEN ---
% @author Viola Söderlund
% @version 2020-05-11

load constants.mat;

% --- CONFIRM DECREASING WAVEFORMS ---

h = 0.000001;
num_k = 10;

odd = 1:2:num_k;

for i = 1:length(U0)
    [t, v] = vf(U0(i), F, h, 2);
    [k, a] = trf(t, v, num_k, h);
    
    semilogy(k(odd), abs(a(odd)));
    hold on;
end

legend('220 V', '1500 V', '2300 V', 'Location', 'northeast');