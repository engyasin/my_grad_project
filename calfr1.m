function [Fr,perr]=calfr1(n)
% give u the frame rate for winvideo and the percentage error.
% yasin & his friends .. mechatronics .. [YY]

vid = videoinput('winvideo', 1);
vid.FramesPerTrigger=inf;
triggerconfig(vid, 'manual')
vid.FrameGrabInterval=1;
start(vid)

trigger(vid)
pause(n)

stop(vid)
s=vid.FramesAcquired;
[~,time]=getdata(vid,s);
flushdata(vid)
Fr=s/(time(end)-time(1));
Fp=1/Fr;
perr=abs(Fp-mean(diff(time)))*100;

delete(vid)
clear vid
