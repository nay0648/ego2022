function [di]=plotWidebandDirectivityIndex(array, f, w, look)
%
% Plot wideband directivity index.
% array:        the array
% f:            frequencies (Hz)
% w:            corresponding beamformers as a cell structure
% look:         look direction [az; el]
%
% di:           the directivity index
%

hsv=phased.SteeringVector('SensorArray', array, 'PropagationSpeed', 340, 'IncludeElementResponse', true);
di=zeros(1, length(f));

for fi=1:length(f)
    a=step(hsv, f(fi), look);
    C=sphericalDiffuseCorr(array, f(fi));
    di(fi)=10*log10(abs(w{fi}'*a)^2/real(w{fi}'*C*w{fi}));
end

plot(f, di);
xlabel('Frequency (Hz)');
ylabel('Directivity Index (dB)');
grid on;

end
