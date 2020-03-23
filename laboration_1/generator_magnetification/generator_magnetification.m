% --- LABORATION 1 ---
% @author Viola Söderlund
% @version 2020-03-22

% 2. Magnetisering av generator

% a. Bestämmer det värde defect som ger att den maximala magnetiseringen i hela
%    generatorn är M.

    % Calculating start values

    [left_defect, right_defect] = get_start_guess(false);

    % Calculating solution

    defect = get_defect(left_defect, right_defect, false);
    
    % Checking correctness
    
    max_magnification = calc_max(defect)

% b. Plottar den skadade generatorn.

generator(defect, 1);

disp('Generatorn är mest skadad i området runt (x, y) = (-0.284, -0,2108).')

function [left_defect, right_defect] = get_start_guess(calculate)
    if calculate
        last_max = get_max(0);
        for defect = 1:100
            current_max = get_max(defect);
            if (current_max > 0 && last_max < 0) || (current_max < 0 && last_max > 0)
                left_defect = defect - 1;
                right_defect = defect
                break
            else
                last_max = current_max;
            end
        end
    
        xn = left_defect
        xn_minus = right_defect
    else
        % Calculated by algorithm above
        left_defect = 40;
        right_defect = 41;
    end
end

function defect = get_defect(left_defect, right_defect, calculate)
    
    if calculate
        next_defect = @(left_defect, right_defect) (left_defect - get_max(left_defect) * (left_defect - right_defect) / (get_max(left_defect) - get_max(right_defect)));
    
        disp('Calculating defect variable...')

        last_approximation = Inf;
        while true
            new_defect = next_defect(left_defect, right_defect);
            approximation = get_max(new_defect);
   
            if approximation == 0 || last_approximation == approximation
                defect = new_defect
                break
            elseif approximation < 0
                left_defect = new_defect;
            else % approximation > 0
                right_defect = new_defect;
            end
        
            last_approximation = approximation;
        end
    else
        defect = hex2num('40446f508876e7c8')
    end
end

function max_magnification = get_max(defect)
    M = 1.05*10^4;

    max_magnification = calc_max(defect) - M;
end

function max_magnetification = calc_max(defect)
    magnetification = generator(defect, 0);
    max_magnetification = max(magnetification);
end