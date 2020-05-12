% --- PROJEKT KRETSEN ---
% @author Jakob Carlsson
% @version 2020-05-08

% new file because... it feels better to do it that way

% definitions from the assignment, rewritten:
% This is sort of unhelpful at this stage, but the point is to rewrite it
% to something that can be calculated.
% I_p = @(t) U(t) / L(t);
% U_p = @(t) -I(t) / C;
% L = @(t) 0.7 / (1 + I(t));


% VARY THIS according to the assignment:
U0 = 220;

% set this to whatever is reasonable
lo = 0;
hi = 0.03;
h = 1e-5;

% the functions in a format we can actually use:
C = 0.5e-6;
L = @(w) 0.7 / (1 + w^2);   % w := I because it needs to be called something...

% THE PROBLEM, I think, is that these don't actually depend on t, but I
% feel like it shouldn't matter since we're using the previous value, but
% probably that's where I'm going wrong...
f{1} = @(t, y) y(2) / L(y(1));	% I'(t) (or technically the f(t,y) thing)
f{2} = @(t, y) -1 * y(1)/C;     % U'(t)

y = [0, U0];                    % y(0)

results = y; % inital values, since by definition this is what y is at t=0
tic;
for t=lo:h:hi-h
    
    for n = 1:length(y)
        s1 = f{n}(t, y);
        s2 = f{n}(t + h/2, y + h*s1/2);
        s3 = f{n}(t + h/2, y + h*s2/2);
        s4 = f{n}(t+h, y+h*s3);
        y(n) = y(n) + (s1 + 2*s2 + 2*s3 + s4)*h/6;
    end
    
    results = [results; y]; % maybe actually preallocate? Kind of annoying though since you'd have to change how t works (unless it's possible to do something clever)
    % "something clever" could be having the index as (int)t*(1/h), however
    % you do that if that is indeed a thing. Maybe +1 as well I think?
    
    %I think not storing the t is fine since we can just do (if row index := i) i*h to get it.
    
end
toc

% hold on
% for n = 1:length(y)
%     plot(lo:h:hi, results(:,n), '-x');
% end

% maybe just plot I
plot(lo:h:hi, results(:,1), '-x'); % bra att komma ihåg att detta är linjär interpolation (fast typ bara grafiskt?)

