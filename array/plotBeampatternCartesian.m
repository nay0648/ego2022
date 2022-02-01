function [az, BPDB]=plotBeampatternCartesian(array, f, w, el, epsi)
%
% Plot the 1D beampattern in Cartesian coordinate system.
% array:        the array
% f:            frequencys (Hz), as a vector
% w:            corresponding beamformers, as cell structure
% el:           scanning elevation (degree)
% epsi:         controls the minimal value
%
% az:           the scanning azimuth
% BPDB:         the beampattern, each row is a beampattern
%

hsv=phased.SteeringVector('SensorArray', array, 'PropagationSpeed', 340, 'IncludeElementResponse', true);
az=-180:180;
BP=zeros(length(f), length(az));

for i=1:length(f)
    for j=1:length(az)
        a=step(hsv, f(i), [az(j); el]);
        BP(i, j)=abs(w{i}'*a);
    end
end

% normalize
% bp=bp/max(abs(bp));

BPDB=10*log10(BP.^2+epsi);

hold on
for i=1:length(f)
    plot(az, BPDB(i, :));
end
hold off

xlabel('Azimuth (Degree)');
ylabel('Response (dB)');
% title(['Beampattern (frequency=', num2str(f), ' Hz)']);

end
