function [HR] = HR(R_peaks,num,fs)
%the function return the Heart rate of the signal 

%create RR_interval vector
for i=1:length(R_peaks)-1
    RR_interval(i)=(R_peaks(i+1)-R_peaks(i))/fs;
    HR(i)=1/RR_interval(i);  %HR in beat/sec
end

%% plot the HR signal 
% R_peaks_sec=(1:0.5:(length(RR_interval)+1)/2);
% figure;
% plot(R_peaks_sec,HR);
% xlabel('time [sec]'); ylabel('HR [beat/sec]');
% title('Heart Rate signal '+string(num));
end
