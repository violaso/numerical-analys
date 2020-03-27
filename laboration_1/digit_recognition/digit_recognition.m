% --- LABORATION 1 ---
% @author Jakob Carlsson
% @version 2020-03-27

% 1. Sifferigenkänning

load minidigits.mat

A = C' * C;
[L, U] = lu(A);

% initalizing the output matrix
xs = zeros(50, 1000);
nv = zeros(1, 1000);

% Löser Cx = b för alla rader av testdata
for i = 1:length(testdata)
    b = testdata(:, i);     
    bp = C' * b;            
    bt = L \ bp;
    xhat = U \ bt; 
    xs(:,i) = xhat;
    nv(i) = norm(C*xhat - b);
end

% Get the average solutions
p = mean([mean(nv) min(nv)]);

% -- CALCULATE IF TESTDATA ARE TWOS --

actualTwos = 0;
correctTwos = 0;
falsePositives = 0;
falseNegatives = 0;
foundTwos = [];

for i = 1:length(testdata)
    isTwo = false;
    shouldBeTwo = false;
    
    if nv(i) < p
        isTwo = true;
        foundTwos = [foundTwos, i];
    end
    
    if testdatad(i) == 2
        shouldBeTwo = true;
        actualTwos = actualTwos + 1;
    end
    
    if isTwo && shouldBeTwo; correctTwos = correctTwos +1; end
    if isTwo && ~shouldBeTwo; falsePositives = falsePositives +1; end
    if ~isTwo && shouldBeTwo; falseNegatives = falseNegatives +1; end
end

percentAllNumsFalsePos = (falsePositives / 1000)*100;
percentTwosMissed = (falseNegatives / actualTwos)*100;
