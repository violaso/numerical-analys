% --- PROJEKT KRETSEN ---
% @author Viola Söderlund
% @version 2020-05-11

load mysterysoundlong.mat;

% --- INVESTIGATE MYSTERY SOUND ---

% Play sound:

sound(y);

default_fs = 8192;

% NOTE: Better to save and play.
audiowrite('numerical-analys/project/mysterysoundlong.wav', y, default_fs);
