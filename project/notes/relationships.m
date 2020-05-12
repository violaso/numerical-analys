% --- PROJEKT KRETSEN ---
% @author Viola Söderlund
% @version 2020-05-12

% --- RELATIONSHIPS ---

% The relationships given by the project instructions,
% U(t) = L(I) * I'(t)
% I(t) = -C * U'(t)
% - diverge.

% By switching -C and L, the relationsships are balanced.
% Since the new relationships fits with the described results of the
% instructions, these are used instead.
% U(t) = -C * I'(t)
% I(t) = L(I) * U'(t)

% L(I) = L0 * I0^2/(I0^2+I^2) = 0.7 * 1/(1+I^2) <= 0.7