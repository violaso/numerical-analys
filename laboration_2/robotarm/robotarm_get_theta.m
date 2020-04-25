% --- LABORATION 2.4a ---
% @author Jakob Carlsson
% @version 2020-04-21

function theta = robotarm_get_theta(x_e, y_e, doPlot)
    % we will have x_e = y_e = 1.3

    % hardcode the things we need for Newton
    F = @(th) [ cos(th(1))+cos(th(2)) - x_e; sin(th(1))+sin(th(2)) - y_e];
    J = @(th) [ -sin(th(1)), -sin(th(2)); cos(th(1)), cos(th(2))]; %double check this because I suck at math

    % start guess based on just looking at the picture
    theta = [pi/3; pi/6];

    % Newton:
    while true
        delta = -J(theta) \ F(theta); 
        theta = theta + delta;
        %plot_robotarm(theta); %probably remove this line but it's kind of nice to see it move into position
        if norm(delta) < 1e-13 %higher precision than called for because it's fast enough anyways
            break;
        end
    end
    
    if doPlot
        plot_robotarm(theta);
    end
end