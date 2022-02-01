function [ er ] = effectiveRank( array, f, Doa )
%
% Calculate the effective rank of an array, to measure the array topology
% quality. The larger value the better. See: V. Tourbabin, B. Rafaely, 
% Theoretical Framework for the Optimization of Microphone Array 
% Configuration for Humanoid Robot Audition, IEEE Trans. Audio, Speech, 
% and Language Processing, vol. 22, no. 12, pp. 1803-1814, 2014.
%
% array:            the microphone array
% f:                interested frequencies
% Doa:              the interested directions, each column is the format of
%                   [az; el]
%
% er:               the effective rank
%

% sound speed
c=340;
m=getNumElements(array);
n=size(Doa,2);

%% prepare the HRTF matrix
hsv=phased.SteeringVector('SensorArray',array,'PropagationSpeed',c);
H=[];
Hf=zeros(m,n);

for fi=1:length(f)
    for j=1:size(Doa,2)
        a=step(hsv,f(fi),Doa(:,j));
        Hf(:,j)=a;
    end
    H=[H; Hf];
end

%% calculate the effective rank
[~, S, ~]=svd(H);

sigma=diag(S);
sigma=sigma(1:rank(H));
sigma=sigma/sum(sigma);

er=exp(-sum(sigma.*log(sigma)));

end
