function [er] = effectiveRankSpherical(array)
%
% Calculate the effective rank of an array, to measure the array topology
% quality. The larger value the better. See: V. Tourbabin, B. Rafaely, 
% Theoretical Framework for the Optimization of Microphone Array 
% Configuration for Humanoid Robot Audition, IEEE Trans. Audio, Speech, 
% and Language Processing, vol. 22, no. 12, pp. 1803-1814, 2014.
%
% array:            the microphone array
% er:               the effective rank
%

% sound speed
c=340;
f=0:25:7975;
m=getNumElements(array);

% directions from unit sphere
[V, ~]=icosphere(3);

Doa=zeros(2, size(V, 1));
n=size(Doa,2);
for i=1:size(V, 1)
    [az, el, ~] = cart2sph(V(i, 1), V(i, 2), V(i, 3));
    Doa(:, i)=[az*180/pi; el*180/pi];
end

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
