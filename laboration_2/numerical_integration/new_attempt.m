% -- LABORATION 2.2e, new attempt / alternate version --


h = [1, 0.5, 0.25, 0.125, 0.0625];
f = @(x) sqrt(x+2);
%f = @(x) x.^2;

I = integral(f, -1, 1, 'RelTol', eps, 'AbsTol', eps)

%x = logspace(-1, 0);

%preallocate for speed because it told me to
y_t = zeros(1,length(h));
y_s = y_t;
for i = 1:length(h) 
    y_t(i) = abs(trapezoidal(f, h(i)) - I);
    y_s(i) = abs(simpson(f, h(i)) - I);
end

loglog(h, y_t, '-s');
hold on;
    loglog(h, y_s, '-s');
    loglog(h, h.^2, '-s');
    loglog(h, h.^4, '-s');
    
    legend('Trapets', 'Simpsons', 'h^2', 'h^4', 'Location', 'southeast');
    grid on;
hold off;




function sum = trapezoidal(f, h)
    sum = f(-1) / 2;

    for x_i = (-1 + h):h:(1 - h)
        sum = sum + f(x_i);
    end
    
    sum = (sum + f(1) / 2) * h;
end

function sum = simpson(f, h)
    n = 2 / h;

    odd_sum = 0;
    for i = 1:2:n-1
        odd_sum = odd_sum + f(-1 + h*i);
    end
    
    even_sum = 0;
    for i = 2:2:n-2
        even_sum = even_sum + f(-1 + h*i);
    end
    
    sum = (f(-1) + 4*odd_sum + 2*even_sum + f(1)) * h/3;
end



% function sum = simpson(f, h, lower_bound, upper_bound)
%     %h = (upper_bound - lower_bound) / num_intervals;
%     odd_sum = 0;
%     even_sum = 0;
%     for x_i = (lower_bound + h):h*2:(upper_bound - h)
%         odd_sum = odd_sum + f(x_i);
%         even_sum = even_sum + f(x_i + h);
%     end
%     
%     sum = (f(lower_bound) + 4 * odd_sum + 2 * even_sum + f(upper_bound)) * h / 3;
% end
% 
% function value = trapezoidal(f, h, lower_bound, upper_bound)
%     %h = (upper_bound - lower_bound) / num_intervals;
%     
%     sum = 0;
%     for x_i = (lower_bound + h):h:(upper_bound - h)
%         sum = sum + f(x_i);
%     end
%     
%     value = h * (f(lower_bound)/2 + sum + f(upper_bound)/2);
% end
