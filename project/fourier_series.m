% --- PROJEKT KRETSEN ---
% @author Viola Söderlund
% @version 2020-05-11

load constants.mat;

% --- ASSESS FOURIER SERIES KOEFFICIENTS ---

h = 0.000001;
num_k = 10;

a = [];

for i = 1:length(U0)
    [t, v] = vf(U0(i), F, h);
    
    a_ = zeros(num_k, 1);
    for k = 1:num_k
       a_(k) = 1/pi * T(h, k, t, v);
    end
    
    a = [a a_];
    
    figure(U0(i));
    
    plot(t, v);
    hold on;
    plot(t, S(t, a_(1:3)))
    hold on;
    plot(t, S(t, a_));
    
    legend('Strömkurvan (v)', 'Fourierutvecklingen (3)', 'Fourierutvecklingen (10)', 'Location', 'northeast');
end

disp('Series koefficients {a_k} for each U0:');
U0
a

function v = S(t, a)
    v = zeros(1, length(t));
    
    for i = 1:length(t)
        v(i) = 0;
        
        for k = 1:length(a)
            v(i) = v(i) + a(k)*sin(k*t(i));
        end
    end
end

function I = T(h, k, t, v)
    f = @(i) v(i) * sin(k*t(i));

    I = f(1)/2;

    for i = 1:length(t)-1
        I = I + f(i);
    end
    
    I = h*(I + f(length(t))/2);
end