function [az, bpdb]=plotBeampattern( array, f, w )
%
% Plot the 1D beampattern.
% array:        the array
% f:            frequency (Hz)
% w:            the beamformer
%
% az:           the scanning azimuth
% bpdb:         the beampattern
%

hsv=phased.SteeringVector('SensorArray', array, 'PropagationSpeed', 340);
az=-180:180;
bp=zeros(1, length(az));

for i=1:length(az)
    a=step(hsv, f, [az(i); 0]);
    bp(i)=abs(w'*a);
end

bp=bp/max(abs(bp));
bpdb=10*log10(bp.^2+1e-5);
polarplot(deg2rad(az), bpdb);
rlim([-50 0]);
title(['Beampattern (frequency=', num2str(f), ' Hz)']);

end
