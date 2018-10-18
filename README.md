#  Acoustic_comm_FSK

Acoustic communication embedding data in high frequency of sound by FSK modulation

## Workflow
### tx.
```
steps:
1.Generate preamble for cross correlation
2.embed data into pre-decided frequency range with FSK modulation
3.output signal as sound file
```

### rx.
```
steps:
1.Execute cross correlation with preamble to locate signal 
2.decode data in frequency domain with moving window and maximum amplitude selection to identify the received data
```

## Instruction for Executing

#### step 1.execute tx.m to generate preamble.wav,tx.wav and data for communication
#### step 2.record the sound wave with microphone
#### step 2.execute rx.m to decode 


## Example

### signal in time domain
![alt text](https://github.com/leduoyang/Acoustic_comm_FSK/blob/master/img/data_in_time_domain.png)


### signal in frequency domian
![alt text](https://github.com/leduoyang/Acoustic_comm_FSK/blob/master/img/data_in_freq_domain.png)

