% --- LABORATION 1 ---
% @author Jakob Carlsson, Viola Söderlund
% @version 2020-03-27

% 4. Stora linjära ekvationssystem

load eiffel4.mat

style = "det"; % "det" or "rand"
numRuns = 20; % how many runs to take the average time of

n = length(xnod) % it's useful to show the size; double it to get N
forcepoint = n - 50; % this is just to make it interesting, could be anything
b = choose_b(n, forcepoint, style); % forcepoint only relevant if "det"

% Beräknar kalkyleringstider

disp('Tid för inv(A)*b:');
time = 0;
for i=1:numRuns
    tic; 
    x = inv(A)*b; 
    time = time + toc; 
end
time_per_run = time / numRuns

disp('Tid för A\b:');
time = 0;
for i=1:numRuns
    tic; 
    x = A \ b; 
    time = time + toc;
end
time_per_run = time / numRuns

% Visar grafer

xbel = xnod + x(1:2:end); 
ybel = ynod + x(2:2:end);

figure('Name', 'trussplot: xnod/ynod')
hold on
    trussplot(xnod, ynod, bars);
    if style=="det"
        hold on
        plot(xnod(forcepoint), ynod(forcepoint), '*');
    end
hold off

figure('Name', 'trussplot: xbel/ybel')
hold on
    trussplot(xbel, ybel, bars);
    if style=="det"
        hold on
        plot(xbel(forcepoint), ybel(forcepoint), '*');
    end
hold off