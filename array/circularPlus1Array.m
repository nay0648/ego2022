function [array] = circularPlus1Array(diameter, numelements)
%
% Generate a circular array with central sensor.
%
% diameter:     array diameter in meter
% numelements:  number of array elements
%

Coor=zeros(3,numelements-1);
r=diameter/2;
daz=2*pi/(numelements-1);

for j=1:size(Coor,2)
    [x,y,z]=sph2cart((j-1)*daz,0,r);
    % the array is in the x-y plane
    Coor(:,j)=[x;y;z];
end

Coor=[Coor, [0; 0; 0]];

En=zeros(2,size(Coor,2));
En(2,:)=90;

%% construct array
mic=phased.OmnidirectionalMicrophoneElement('FrequencyRange',[0, 25000]);
array=phased.ConformalArray('Element',mic,...
    'ElementPosition',Coor,...
    'ElementNormal',En);

end
