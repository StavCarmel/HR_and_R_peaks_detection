function [R_peaks_idx] = R_detection_type01(ECG_signal,num,fs)
%this functions returns the ECG signal,with the R peaks marked and the R peaks vector

%% time vec:
time= 0:1/fs:(length(ECG_signal)-1)*1/fs;

%% Plot original signal
% figure();
% plot(time(1,10000:13000),ECG_signal(1,10000:13000));
% title('ECG signal '+string(num)); 
% xlabel('sec');
% ylabel('mV');

%% smoothing the signal:
x=0.25;
filtered=(filter(x, [1 x-1], ECG_signal)); 

%% QRS detection:
%setting sizes for loops:
signal_length= length(filtered);

%first derivative:
der1=zeros(1,signal_length-1);
for i= 2:signal_length-1
    der1(i)= abs(ECG_signal(i+1)-ECG_signal(i-1));
end 

%second derivative:
der2=zeros(1,signal_length-2);
for i= 3:signal_length-2
     der2(i)= abs(ECG_signal(i+2)-2*ECG_signal(i)+ECG_signal(i-2));
end

%match the length of the first and second derivatives, to the original
%signal:
der1=[0, der1];
der2=[0,0, der2];

%linear combination of the first and second derivatives:
alpha= 5;
beta=0.5;
y= alpha.*der1 + beta.*der2;

%smooth the linear combination:
comb = filter(x, [1 x-1], y);

%threshold:
thresh=0.8*max(comb(1:200));

%create a binaric vec, 1 will be under the index wich the value exceed the threshold:
thresh_vec=zeros(1,signal_length);
for i=1:signal_length
    if comb(1,i)>=thresh
        thresh_vec(1,i)=1;
    else
        thresh_vec(1,i)=0;
    end
end


 %find the QRS complex, and set 2 under the index wich starts the complex: 
 for i=1:signal_length-40  
    if thresh_vec(1,i)==1
        count=0;
        for j=1:40
            if thresh_vec(1,i+j)==1
               count=count+1;
            end
        end
        if count>=30 %check if at least 30% in the 100 indexes window exceeded the threshold
           thresh_vec(1,i)=2;
        end
    end
 end
 


%% R-peaks detection:
%find max in every QRS complex: 
R_peaks=zeros(1,signal_length);
R_peaks_idx=[];
for i=1:signal_length
    if thresh_vec(1,i)==2
        if thresh_vec(1,i-1)==2
            if thresh_vec(1,i+1)~= 2
                QRS_vec=abs(filtered(1,i-30:i+30));
                [cur_peak,idx_peak]= max(QRS_vec');
                R_peaks(1,i+idx_peak-31)=cur_peak;
                R_peaks_idx=[R_peaks_idx,i+idx_peak-31];
            end
         end
     end
end

R_peaks_dif=diff(R_peaks_idx);
mean_dif=mean(R_peaks_dif);

%if there is more than 1 max in the range of the QRS complex, delete the
%lower one:
for i=1:signal_length-mean_dif
    if R_peaks(1,i)>0
          for j= 1:(2*mean_dif/3)
              if R_peaks(1,i+j)<R_peaks(1,i)
                 R_peaks(1,i+j)=0;
              else 
                 R_peaks(1,i)=0;
                 break;
              end
          end
    end
end

R_peaks(R_peaks==0)=NaN;

%% plot the ECG signal with marked R peaks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure;
% plot(time, abs(filtered), time, R_peaks, 'r.', 'MarkerSize', 20 );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure();
% plot(time(1,30000:37000), abs(filtered(1,30000:37000)), time(1,30000:37000), R_peaks(1,30000:37000), 'r.', 'MarkerSize', 20 );
% title('R peaks signal '+string(num));
% xlabel('sec');
% ylabel('mV');

%% return R_peaks idx vector whithout NaN
R_peaks_idx = find(~isnan(R_peaks));

end

