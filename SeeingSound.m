%======================================
%Audio Filter and Visualizer:
%This program takes live audio as an input composed of both amplitude and
%frequency. The program then produces a live plot of the data as the right stereo channel vs the left stereo channel.

clear all; clc;

%Establish audio input port **NOTE: Computer must have access to both (2) stereo
%channels to run program
deviceReader = audioDeviceReader('SampleRate',44100,'NumChannels',2, 'SamplesPerFrame',1024);%establishes the computer mic as the input reader

%find music file and read audio data
[y,fs] = audioread('Zodiac.wav');
player = audioplayer(y, fs);
Audiolook = dsp.AudioFileReader('Zodiac.wav','SamplesPerFrame',1024, 'OutputDataType','double');

Void = nan; %filler for empty inital plot when plot is initalized below

V = 'void';
while V ~= "AROUND" || V~= "SONG"
    fprintf('ERROR: Please Enter "Around" OR "Song"\n')
    V = input('Enter: "Around" OR "Song"\n', 's');
    V = upper(V);
    disp(V);
if V == "AROUND" || V == "SONG"
    break
end
end

if V == "SONG"


figure
h = plot(nan, nan, '.');%create plot 
axis([-1 1 -1 1]);%keep range/domain small when using computer input mic
xlabel('left channel')
ylabel('right channel')
title('See The Sound')
grid on
play(player)
while true
    audioFrame = Audiolook()

    set(h, 'Xdata', audioFrame(:,1), 'Ydata', audioFrame(:,2));
    drawnow limitrate
end
end

if V == "AROUND"

figure
h = plot(Void, Void, '.');%create plot 
axis([-.1 .1 -.1 .1]);%keep range/domain small when using computer input mic
xlabel('left channel')
ylabel('right channel')
title('See The Sound')

while true
    audioFrame = deviceReader()

    set(h, 'Xdata', audioFrame(:,1), 'Ydata', audioFrame(:,2));

    drawnow limitrate
end
end
