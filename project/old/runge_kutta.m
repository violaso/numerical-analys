% --- PROJEKT KRETSEN ---
% @author Jakob Carlsson
% @version 2020-05-06

f = @(t, y) sin(t.*y).*y; % for example
h = 0.01; % for example

y = 100; % y(0)
results = [0 y];

%these two are for later
yFE = y;
resFE = results;

lo = 0;
hi = 5;

for t=lo:h:hi-h
    
    s1 = f(t, y);
    s2 = f(t + h/2, y + h*s1/2);
    s3 = f(t + h/2, y + h*s2/2);
    s4 = f(t+h, y+h*s3);
    
    y = y + (s1 + 2*s2 + 2*s3 + s4)*h/6;
    results = [results; t+h y]; % I believe this is correct... probably?
    
end

plot(results(:,1), results(:,2))




% sanity check because I sort of don't know what I'm doing:

for t=lo:h:hi-h
    yFE = yFE + h*f(t,yFE);
    resFE = [resFE; t+h yFE];
end

diff = zeros(1, length(results));
for n = 1:length(results)
    diff(n) = results(n,2) - resFE(n,2);
end

max_diff = max(diff)
