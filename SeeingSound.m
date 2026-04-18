%======================================
%Audio Filter and Visualizer:
%This program takes live audio as an input and distinctly filters and
%separates different frequencies into matricies. The program then produces
%a live plot of the data as frequency vs in an x and y component.The
%program also includes a feature that allows the user to have the program
%stop when a certain sound intensity is met.

%Establish audion input port
deviceReader = audioDeviceReader('SampleRate',44100,'NumChannels',2, 'SamplesPerFrame',1024);

figure
h = plot(nan, nan, '.')%create plot 
axis([-1 1 -1 1])
xlabel('left channel')
ylabel('right channel')
title('See The Sound')

ax = gca;
ax.XLimMode = 'manual';
ax.YLimMode = 'manual';

while true
    audioFrame = deviceReader()

    %Normalize??
    audioFrame = audioFrame/ max(abs(audioFrame(:)) + 1e-6)

    set(h, 'Xdata', audioFrame(:,1), 'Ydata', audioFrame(:,2));

    drawnow limitrate

end

