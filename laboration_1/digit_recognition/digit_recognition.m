load minidigits.mat

A = C' * C;
[L, U] = lu(A);

%declaring/initalizing the "output" matrix, etc.
xs = zeros(50, 1000); %TODO: generalize this.
nv = zeros(1, 1000);

for i = 1:length(testdata)
    %I'll do this with lots of vars first, condense it later.
    b = testdata(:,i);
    bp = C' * b;
    bt = L\bp;
    xhat = U\bt; %xhat should just magically be the best solution
    xs(:,i) = xhat; %unnecessary line unless you want to look at xs
    nv(i) = norm(C*xhat - b);
end

p = mean([mean(nv) min(nv)]);



actualTwos = 0;
correctTwos = 0;
falsePositives = 0;
falseNegatives = 0;
foundTwos = []; %not actually required for the task but just out of interest

for i = 1:length(testdata)
    isTwo = false;
    shouldBeTwo = false;
    if nv(i) < p
        isTwo = true;
        foundTwos = [foundTwos, i];
    end
    if testdatad(i) == 2
        shouldBeTwo = true;
        actualTwos = actualTwos + 1; %ffs
    end
    
    if isTwo && shouldBeTwo; correctTwos = correctTwos +1; end
    if isTwo && ~shouldBeTwo; falsePositives = falsePositives +1; end
    if ~isTwo && shouldBeTwo; falseNegatives = falseNegatives +1; end
end

percentAllNumsFalsePos = (falsePositives / 1000)*100;
percentTwosMissed = (falseNegatives/actualTwos)*100;
