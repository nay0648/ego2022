function [ monitor ] = conformalArray( Coor )
%
% Array with specified coordinates.
%
% Coor:     each row is a (x, y, z) coordinate.
%

Coor=Coor';
En=zeros(2, size(Coor, 2));
En(2, :)=0;

%% construct array
mic=phased.OmnidirectionalMicrophoneElement('FrequencyRange',[0, 25000]);
monitor=phased.ConformalArray('Element',mic,...
    'ElementPosition',Coor,...
    'ElementNormal',En);

end
