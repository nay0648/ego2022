function [looks, W] = loadBeamformers(path)
% load beamformers from file
% path:                 file path
% looks:                look directions
% W:                    cell contain beamformers {numlooks, numbins} (nummics)
%

fid=fopen(path, 'r');
numlooks=fread(fid, 1, 'int32');
numbins=fread(fid, 1, 'int32');
nummics=fread(fid, 1, 'int32');

% load look directions
looks=fread(fid, numlooks, 'float32');

% load beamformers
W=cell(numlooks, numbins);

for li=1:numlooks
    for fi=1:numbins
        w=zeros(nummics, 1);
        
        for m=1:nummics
            re=fread(fid, 1, 'float32');
            im=fread(fid, 1, 'float32');
            w(m)=re+im*1i;
        end
        
        W{li, fi}=w;
    end
end

fclose(fid);

end
