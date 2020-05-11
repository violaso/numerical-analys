% --- PROJEKT KRETSEN ---
% @author Jakob Carlsson
% @version 2020-05-07


% analytiskt.txt visar hur jag kom fram till detta
% (om L är konstant)

L = 0.7;
C = 0.5e-6;

I = @(t) sin(sqrt(1/(C*L))*t); % this is the correct function, right? Not what I had before.

%plotta
x = 0:1e-4:0.03; % 1e-4 seems like it's good enough, but you could go as high (low) as 1e-10
plot(x, I(x))

%extremt snabb svängningstid, vilket är typ ganska rimligt egentligen
