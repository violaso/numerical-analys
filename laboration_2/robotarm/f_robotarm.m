% --- LABORATION 2.4bc ---
% @author Jakob Carlsson & whoever wrote the skeleton...
% @version 2020-04-18



% Funktionerna är inte korrekta, man måste sätta ihop dem på korrekt
% sätt, men jag tror detta är rätt byggstenar. Och man måste definiera u,
% som är två olika (ish) i F_0 och F_1.


% eftersom Matlab börjar på 1 måste vi ha u_1 och u_2
% första diffekvationen som system av första ordningens
F_0 = @(t, u) [u(2); -alpha*(u(1) - theta_star) - gamma*u(2) + beta*sin(omega*t)];

% andra diffek
F_1 = @(t, u) [u(2); -alpha*(u(1)-theta_star) - gamma*(u(2) + abs('FÖRRA u(2)')) + beta*sin(omega*t)];

F = [F_0; F_1]; %ungefär så är tanken, fast med parametrar då...



% och just det.. theta_star är vinklarna från get_theta




% nu när jag kollar på kommentaren för funktionen så tror jag att jag vet
% hur man ska ta det jag skrev och faktiskt göra det användbart...
% Jag har lite fysiska anteckningar också som jag inte vet hur bra de
% förmedlades här...


function f=f_robotarm(z0,t,ts1,ts2,alpha,beta,gamma,omega)
%% Computes the right-hand side of the robot differential equation
%
% * z0 is a vector containing [theta1(t);theta1prime(t);theta2(t);theta2prime(t)]
% * t is the current time
% ts1,ts2 is the two wanted angles.
% 
% The return value f is the right-hand side of the differential equation
% (with four variables)
% 


f=zeros(size(z0));
f(1)=z0(2);
f(2)=-alpha*(z0(1)-.... 
f(3)=z0(4);
f(4)=-alpha*(z0(3)-.... 


