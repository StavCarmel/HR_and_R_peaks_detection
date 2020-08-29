# HR_and_R_peaks_detection
In this project I used signal processing tools in order to create an algorithm that detects the R peaks of an ECG signal and calculated the HR (heart rate)

Functions an Scripts:
main - this script loads the signals calls the functions and detects the R-peaks and HR of the ECG signal.
HR - this function calculated the heart rate of the signal.
BP_filter - this function builds a BPF in a required range and filters the inpute signal.
R_detection_type01 - this functions returns the ECG signal, with the R peaks marked and the R peaks vector. matches to signal of type01, that the R peaks are above the baseline.
R_detection_type02 - this functions returns the ECG signal, with the R peaks marked and the R peaks vector. matches to signal of type02, that the R peaks are belowe the baseline.

