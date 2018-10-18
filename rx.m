[y,sample_rate] = audioread('./rx.wav');
[preamble,~] = audioread('./preamble.wav');
y=y(:,1);
%% cross correlation
[r,lags] = xcorr(y,preamble);
[~,M]=max(r); % get the index having max value of inner product
I=lags(M);  % get the number of shift needed with the index M extracted above
y = y(I+1+length(preamble):end); %locate the position of signal
L=length(y);
%% Decode with FFT
freq_for_symbol=[5000 6000 7000 8000]; 
rx_data = [];
symbol_per_second = 10 ; duration = 1/symbol_per_second ;
count=0;
for i = 0 : floor((L/sample_rate)/duration) - 1 %FFT every 0.1s
    signal = y( i * ( duration * sample_rate ) +1 : (i+1) * ( duration * sample_rate )); %extract the symbol for decoding
    fft_info = fft( signal ); 
    fft_len =length( fft_info );
    fft_info = abs( fft_info ); % default FFT output is complex, we only care about the power instead of phase
    fft_info = fft_info( 1 : fft_len / 2 + 1); % MATLAB FFT L/2:end is a mirror to 1:L/2 if input samples are real numbers 
    [M,I]=max(fft_info(2:end));
    f = ( 0 : fft_len / 2 ) * sample_rate / fft_len;
    
    if  count<40
        [~,index] = min(abs(freq_for_symbol-f(I)));
        rx_data=[rx_data freq_for_symbol(index)];
        count=count+1;
    end
    
    figure(1); %show the frequency distribution after fft
    plot(f,fft_info);
    axis([4000 9000 0 100])
    xlabel('f (Hz)');
    ylabel('|P1(f)|');
   pause();    
end

%%
load('./tx_data.mat')
error = sum(rx_data - symbols);

