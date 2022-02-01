%
% get the sound signal from far field to array and collected by sensors
% array:    the sensor array
% s:        signal, as a column vector
% fs:       sampling rate
% az:       azimuth in degree
% el:       elevation in degree
%
% X:        signal collected by the array, each column for a sensor
%
function X=collectSound(array, s, fs, az, el)

collector=phased.WidebandCollector('Sensor',array,...
    'PropagationSpeed',soundSpeed(),...
    'SampleRate',fs,...
    'ModulatedInput',false);
X=step(collector,s,[az; el]);

end
