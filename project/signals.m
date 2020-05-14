% --- PROJEKT KRETSEN ---
% @author Viola Söderlund
% @version 2020-05-11

load constants.mat;

% --- SIGNALS ---

fs = 1000000;

% Generate sound signals:
% NOTE: Only every 13th value is used, due to "audiowrite"'s limitations. 

h = 0.0001;
fq = 400;
skip = 13;

S220 = get_signal(U0(1), F, h, fq);
S220 = S220(1:skip:length(S220));

S1500 = get_signal(U0(2), F, h, fq);
S1500 = S1500(1:skip:length(S1500));

S2300 = get_signal(U0(3), F, h, fq);
S2300 = S2300(1:skip:length(S2300));

save numerical-analys/project/signals.mat S220 S1500 S2300 fs;

clear S220 S1500 S2300;

% Returns a sound signal of 400 periods.
function y = get_signal(U0, F, h, fq)
    [t, v] = vf(U0, F, h);
    
    y = zeros(1, fq * length(v));
    
    len = length(v);
    
    for l = 0:fq-1
        y(len*l+1:len*(l+1)) = v;
    end
end