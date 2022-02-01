function plotWidebandBeampattern(array, f, w, el)
%
% Plot wideband beampattern.
% array:        the array
% f:            frequencies (Hz)
% w:            corresponding beamformers as a cell structure
% el:           scanning elevation (degree)
%

az=-180:5:180;
[X, Y]=meshgrid(az, f);
Z=zeros(size(X));
hsv=phased.SteeringVector('SensorArray', array, 'PropagationSpeed', 340, 'IncludeElementResponse', true);

for fi=1:size(Z, 1)
    for azi=1:size(Z, 2)
        a=step(hsv, f(fi), [az(azi); el]);
        Z(fi, azi)=abs(w{fi}'*a);
    end
end

mesh(X, Y, Z);
xlabel('Azimuth (degree)');
ylabel('Frequency (Hz)');
zlabel('Response');
title('Beampattern');

end
