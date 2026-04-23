%======================================
%Audio Filter and Visualizer:
%This program takes live audio as an input and distinctly filters and
%separates different frequencies into matricies. The program then produces
%a live plot of the data as frequency vs in an x and y component.The
%program also includes a feature that allows the user to have the program
%stop when a certain sound intensity is met.



% fileReader = dsp.AudioFileReader('Replay_I_Y_A_Z_Naijapals.mp3');%
% deviceWriter = AudioFileWriter('SampleRate',fileReader.SampleRate);%
% 
% crossFilt = crossoverFilter('SampleRate',fileReader.SampleRate)
% visualize(crossFilt);
% parameterTuner(crossFilt);

% %Establish audion input port **NOTE: Computer must have access to both (2) stereo
%channels to run program
clear all; clc;

deviceReader = audioDeviceReader('SampleRate',44100,'NumChannels',2, 'SamplesPerFrame',1024);%establishes the computer mic as the input reader

[y,fs] = audioread('Replay_I_Y_A_Z_Naijapals.mp3');
player = audioplayer(y, fs);


Void = nan;

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

play(player);


figure
h = plot(Void, Void, '.');%create plot 
axis([-1 1 -1 1]);%keep range/domain small when using computer input mic (also when normalize is off)
xlabel('left channel')
ylabel('right channel')
title('See The Sound')

while true
    % fr = matlab.io.datastore.DsFileReader('Replay_I_Y_A_Z_Naijapals.mp3')
    audioFrame = player()
    % deviceWriter(audioFrame);

    %Normalize??
    % audioFrame = audsioFrame/ max(abs(audioFrame(:)) + 1e-6)

    set(h, 'Xdata', audioFrame(:,1), 'Ydata', audioFrame(:,2));

    drawnow limitrate
end
end

% ax = gca;
% ax.XLimMode = 'manual';
% ax.YLimMode = 'manual';

if V == "AROUND"

figure
h = plot(Void, Void, '.');%create plot 
axis([-.1 .1 -.1 .1]);%keep range/domain small when using computer input mic (also when normalize is off)
xlabel('left channel')
ylabel('right channel')
title('See The Sound')

while true
    audioFrame = deviceReader()

    %Normalize??
    % audioFrame = audioFrame/ max(abs(audioFrame(:)) + 1e-6)

    set(h, 'Xdata', audioFrame(:,1), 'Ydata', audioFrame(:,2));

    drawnow limitrate
end
end
