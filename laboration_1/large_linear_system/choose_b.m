% --- LABORATION 1 ---
% @author Jakob Carlsson, Viola Söderlund
% @version 2020-03-27

% 4. Stora linjära ekvationssystem

% CHOOSE_B Sets the righthand-side of the equation (i.e. b)
function b=choose_b(n, forcepoint, style)
    if style == "det"
        % deterministically choose a point somewhere reasonably high up,
        % and apply to it a rightwards force with value 1.
        b = zeros(n*2, 1); 
        b(forcepoint*2-1) = 1;
    elseif style == "rand"
        % randomly set all values in b
        b=randn(n*2, 1);
    end
end