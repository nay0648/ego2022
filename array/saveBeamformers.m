function saveBeamformers(looks, W, path)
%
% save beamformers into file
% looks:                look directions (degree) [numlooks]
% W:                    cell contain beamformers {numlooks, numbins} (nummics)
% path:                 output file path
%

numlooks=size(W, 1);
numbins=size(W, 2);
nummics=length(W{1, 1});

fid=fopen(path, 'w');

% save matrix size
fwrite(fid, numlooks, 'int32');
fwrite(fid, numbins, 'int32');
fwrite(fid, nummics, 'int32');

% save look directions
fwrite(fid, looks, 'float32');

% save beamformers
for li=1:numlooks
    for fi=1:numbins
        w=W{li, fi};
        for m=1:nummics
            fwrite(fid, real(w(m)), 'float32');
            fwrite(fid, imag(w(m)), 'float32');
        end
    end
end

fclose(fid);

end
