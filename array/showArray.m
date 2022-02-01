function showArray( array )
%
% Show array geometry.
% array:    the monitor array
%
viewArray(array,...
    'ShowNormals',true,...
    'ShowIndex','All');
% viewArray(array);

% plot the phase center of the array
hold on;
scatter3(0,0,0,'rx');
hold off;

end
