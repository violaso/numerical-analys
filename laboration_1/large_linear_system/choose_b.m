function b=choose_b(n, forcepoint, style)
%CHOOSE_B Sets the righthand-side of the equation (i.e. b)

if style == "det"
    %deterministically choose a point somewhere reasonably high up,
    % and apply to it a rightwards force with value 1.
    b = zeros(n*2, 1); b(forcepoint*2-1) = 1;
elseif style == "rand"
    %randomly set all values in b
    b=randn(n*2, 1);
end