function saveArray(monitor, path)
% 
% Export array geometry into file, each row is a 3D sensor coordinate in XYZ
% coordinate system.
%
% monitor:          the array
% path:             destination path
%

Loc=getElementPosition(monitor)';
save(path,'Loc','-ascii');

end
