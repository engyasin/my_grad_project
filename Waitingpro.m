
addpath('C:\Users\HORIZON LINE\Documents\MATLAB\CV3dS\SplashScreen_v1p1\SplashScreen-v1p1')
splsc = SplashScreen( 'Splashscreen', 'nwpic.bmp', ...
                        'ProgressBar', 'on', ...
                         'ProgressPosition',30, ...
                        'ProgressRatio', 0.01 );
                    splsc.addText(55,100, '����������� - ��� - �����', 'FontSize',45, 'Color', [1 1 0] )
                    splsc.addText(150,200, strcat('3D Scanner Project_',date), 'FontSize', 20, 'Color',[1 0 0])
                    
                    splsc.addText(240,250, '����� ������:'...
, 'FontSize', 25, 'Color', [0 1 1] )

       splsc.addText(90,285, '����� ���� ����� ���� ����� �����'...
, 'FontSize', 30, 'Color', [1 1 1] )

        splsc.addText(150,350,'����� �������: ���� ����'...
, 'FontSize', 30, 'Color', [1 1 1] )
       
%        pause(5)
%        delete( splsc )