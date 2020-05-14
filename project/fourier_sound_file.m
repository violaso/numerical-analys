% --- PROJEKT KRETSEN ---
% @author Viola Söderlund
% @version 2020-05-11

load signals.mat;

% --- GENERATE SOUND FILES ---

audiowrite('numerical-analys/project/sound_220V.wav', S220, fs);
audiowrite('numerical-analys/project/sound_1500V.wav', S1500, fs);
audiowrite('numerical-analys/project/sound_2300V.wav', S2300, fs);

clear S220 S1500 S2300;