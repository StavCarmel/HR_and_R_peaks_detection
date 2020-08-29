%FS1 algorithm Based on First and Second Derivative

tic
%% loading ECG signals
ECG_1=load('ECG_01.mat');
ECG_2=load('ECG_02.mat');
ECG_3=load('ECG_01.mat');
ECG_4=load('ECG_02.mat');

ECG_5=load('ECG_03.mat');
ECG_6=load('ECG_04.mat');
ECG_7=load('ECG_03.mat');
ECG_8=load('ECG_04.mat');
 
%% define ECG signals according to type
type_1_a=ECG_1.sig;
type_2_a=ECG_2.sig;
type_1_b=ECG_3.sig;
type_2_b=ECG_4.sig;

noisy_type_1_b=ECG_5.sig;
noisy_type_2_b=ECG_6.sig;
noisy_type_1_a=ECG_7.sig;
noisy_type_2_a=ECG_8.sig;
 
%% define sampling frequency
fs=1000;

%% R_detection function activation for regular signals- the functions return the ECG signal with the R peaks marked and the R peaks vector
[R_peaks1] = R_detection_type01(type_1_a,1,fs);
[R_peaks2] = R_detection_type02(type_2_a,2,fs);
[R_peaks3] = R_detection_type01(type_1_b,3,fs);
[R_peaks4] = R_detection_type02(type_2_b,4,fs);

%% saving the R_peaks vectors
save('311238729_01.mat','R_peaks1');
save('311238729_02.mat','R_peaks2');
save('312487234_01.mat','R_peaks3');
save('312487234_02.mat','R_peaks4');

%% HR function activation for regular signals - the functions return the heart rate graph
[HR1] = HR(R_peaks1,1,fs);
[HR2] = HR(R_peaks2,2,fs);
[HR3] = HR(R_peaks3,3,fs);
[HR4] = HR(R_peaks4,4,fs);

%% filtering the noisy signals:
[filtered_sig1] = BP_filter( noisy_type_1_b,5,fs);
[filtered_sig2] = BP_filter( noisy_type_2_b,6,fs);
[filtered_sig3] = BP_filter( noisy_type_1_a,7,fs);
[filtered_sig4] = BP_filter(noisy_type_2_a,8,fs);

%% R_detection function activation for noisy signals- the functions return the ECG signal with the R peaks marked and the R peaks vector
[R_peaks5] = R_detection_type01(filtered_sig1,5,fs);
[R_peaks6] = R_detection_type02(filtered_sig2,6,fs);
[R_peaks7] = R_detection_type01(filtered_sig3,7,fs);
[R_peaks8] = R_detection_type02(filtered_sig4,8,fs);

%% HR function activation for regular signals - the functions return the heart rate graph
[HR5] = HR(R_peaks5,5,fs);
[HR6] = HR(R_peaks6,6,fs);
[HR7] = HR(R_peaks7,7,fs);
[HR8] = HR(R_peaks8,8,fs);

%% saving the R_peaks vectors
save('b_03N.mat','R_peaks5');
save('b_04N.mat','R_peaks6');
save('a_03N.mat','R_peaks7');
save('a_04N.mat','R_peaks8');
%% 

toc
