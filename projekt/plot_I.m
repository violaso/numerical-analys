% --- PROJEKT KRETSEN ---
% @author Jakob Carlsson
% @version 2020-05-04


% analytiskt.txt visar hur jag kom fram till detta
% (om L är konstant)

L = 0.7;
C = 0.5e-6;

I = @(t) sin(sqrt(L/C)*t);

%plotta
x = 0:0.000000001:0.03;
plot(x, I(x))

%extremt snabb svängningstid, vilket är typ ganska rimligt egentligen
