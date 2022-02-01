function [wng]=plotWidebandWhiteNoiseGain(array, f, w, look)
%
% Plot wideband white noise gain.
% array:        the array
% f:            frequencies (Hz)
% w:            corresponding beamformers as a cell structure
% look:         look direction [az; el]
%

hsv=phased.SteeringVector('SensorArray', array, 'PropagationSpeed', 340, 'IncludeElementResponse', true);
wng=zeros(1, length(f));

for fi=1:length(f)
    a=step(hsv, f(fi), look);
    wng(fi)=10*log10(abs(w{fi}'*a)^2/real(w{fi}'*w{fi}));
end

plot(f, wng);
xlabel('Frequency (Hz)');
ylabel('White Noise Gain (dB)');
grid on;

end
