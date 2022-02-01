function [el, BPDB]=plotBeampatternCartesianEl( array, f, w )
%
% Plot the 1D beampattern in Cartesian coordinate system.
% array:        the array
% f:            frequencys (Hz), as a vector
% w:            corresponding beamformers, as cell structure
%
% el:           the scanning elevation
% BPDB:         the beampattern, each row is a beampattern
%

hsv=phased.SteeringVector('SensorArray', array, 'PropagationSpeed', 340, 'IncludeElementResponse', true);
el=-90:90;
BP=zeros(length(f), length(el));

for i=1:length(f)
    for j=1:length(el)
        a=step(hsv, f(i), [0; el(j)]);
        BP(i, j)=abs(w{i}'*a);
    end
end

% normalize
% bp=bp/max(abs(bp));

BPDB=10*log10(BP.^2+1e-5);

hold on
for i=1:length(f)
    plot(el, BPDB(i, :));
end
hold off

xlabel('Elevation (Degree)');
ylabel('Response (dB)');
% title(['Beampattern (frequency=', num2str(f), ' Hz)']);

end
