%% pre-processing
sample_rate = 48000; %sampling frequency
symbol_per_second = 10 ;  %symbol duration = 1/symbol_per_second 
freq_for_symbol=[5000 6000 7000 8000]; 

len_for_comm = 4;  % sec.
num_of_symbols= symbol_per_second * len_for_comm;
data =  randi(length(freq_for_symbol),1,num_of_symbols);
symbols = freq_for_symbol(data);
%% embed data
y = [];
duration = 0 : 1/sample_rate : 1/symbol_per_second - 1/sample_rate; % sampling duration
for i = 1 : num_of_symbols
    symbol = symbols(i);
    x = cos(2*pi*symbol*duration);
    y = [y  x] ;
end
%% generate preamble
len_for_preamble = 2; % sec.
symbols_per_preamble= symbol_per_second * len_for_preamble;
freq_for_preamble=[2000 2500 3000 3500]; 
data =  randi(length(freq_for_preamble),1,symbols_per_preamble);
preambles = freq_for_preamble(data);
p = [];
duration = 0 : 1/sample_rate : 1/symbol_per_second - 1/sample_rate;
for i = 1 : symbols_per_preamble
    preamble = preambles(i);
    x = cos(2*pi*preamble*duration);
    p = [p  x] ;
end
%% save as .wav file
audiowrite('./preamble.wav' , p , sample_rate)
y = [p y] ;
audiowrite('./tx.wav' , y , sample_rate)

save('./tx_data','symbols') % save data transmitted
