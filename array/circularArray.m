function [ monitor ] = circularArray(diameter, numelements)
%
% Generate a circular array.
%
% diameter:     array diameter in meter
% numelements:  number of array elements
%

Coor=zeros(3,numelements);
r=diameter/2;
daz=2*pi/numelements;

for j=1:size(Coor,2)
    [x,y,z]=sph2cart((j-1)*daz,0,r);
    % the array is in the x-y plane
    Coor(:,j)=[x;y;z];
end

En=zeros(2,size(Coor,2));
En(2,:)=90;

%% construct array
mic=phased.OmnidirectionalMicrophoneElement('FrequencyRange',[0, 25000]);
monitor=phased.ConformalArray('Element',mic,...
    'ElementPosition',Coor,...
    'ElementNormal',En);

end
