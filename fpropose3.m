function [data ,time]=fpropose3(pn,tn,fdelay)

% fpropose3 is fuction for getting the pics for 3d scanner 
% for grad project .. friends and [YY].
% sure fdelay bigger than calfr1 input.
tic
vid = videoinput('winvideo', 1);

% triggerconfig(vid, 'manual')
% Total 10 pics.
vid.FramesPerTrigger=pn;
vid.TriggerRepeat=1;    % doesn't matter as it is one trigger.

                  % suposed to be entered in seconds .. done! [YY]
%fr=calfr1(4);
% OK here fr=30.1;
fr=30.1;
vid.FrameGrabInterval=round(fr)*tn;
% Note: the first delay for the micro must be = (tn/2)+fdelay;
% so we calcalute fdelay according ,but typacilly
% let it tn=3; fdelay=3.5 second ?? so 5.. [YY]
% Ok for YY grad it is 4-(2.02/2)=2.99=fdelay, tn=2; ,pn=48;
a=toc;
pause(fdelay-a)
% here we go for the first pic  [YY]
start(vid)
% trigger(vid)
wait(vid,1000,'logging')
[data,time]=getdata(vid);
% --- data with us So clean -------
stop(vid)
flushdata(vid)
delete(vid)
clear vid
% ------ done cleaning -------------
% disp(diff(time))

montage(data)
end
