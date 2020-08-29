function [filtered_sig] = BP_filter( ECG_signal,num,fs )
%The function builds a BPF in a required range
%Then, filters the inpute signal and returns the filtered signal

% time vec:
time= 0:1/fs:(length(ECG_signal)-1)*1/fs;
 
% creating FIR BPF filte
BPF=fir1(5000,[1 80]/(fs/2));
% fvtool(BPF);

% using filtfilt to remove the transients delay
filtered_sig=filtfilt(BPF,1,ECG_signal); 

%% Plot original signal vs filtered signal
% figure();
% subplot(2,1,1);
% plot(time(1,30000:38000),ECG_signal(1,30000:38000));
% title('Filtered ECG signal '+string(num)+'-Original signal'); 
% xlabel('sec');
% ylabel('mV');
% subplot(2,1,2);
% plot(time(1,30000:38000),filtered_sig(1,30000:38000));
% title('Filtered ECG signal '+string(num)+'-Filtered signal');
% xlabel('sec');
% ylabel('mV');
end
