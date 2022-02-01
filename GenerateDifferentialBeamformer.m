%
% Generate differential beamformers.
%
clear;
addpath('array');

%% generate array
% circular microphone array diameter (m)
d=0.065;
% number of microphones
M=6;

array=circularArray(d, M);
% save microphone coordinates
saveArray(array, 'array.txt');
showArray(array);

%% generate beamformers
% fft block size
fftsize=640;
F=fftsize/2;
% frequency (Hz) of each fft bin
f=0:25:7975;
% white noise gain (dB)
% wngthdb=5;
wngthdb = -10;
% look directions (azimuth) (degree)
% az=-180:120:180-120;
az = 0;
% look direction (elevation) (degree)
% el=45;
el = 0;

W=cell(length(az), F);
wngth=10^(wngthdb/10);
hsv=phased.SteeringVector('SensorArray', array, 'PropagationSpeed', 340);

for fi=1:F    
    for azi=1:length(az)
        %
        % Synthetic noise covariance matrix, with three nulls at the left, 
        % right, and back side of the look direction.
        %
        a1=step(hsv, f(fi), [doaMod(az(azi)-180); el]);
        a2=step(hsv, f(fi), [doaMod(az(azi)-90); el]);
        a3=step(hsv, f(fi), [doaMod(az(azi)+90); el]);
        C=(a1*a1')+(a2*a2')+(a3*a3');
        % make covariance matrix Hermitian
        C=(C+C')/2;
        
        % steering vector for the look direction
        a=step(hsv, f(fi), [az(azi); el]);
        
        % solve beamformer by CVX
        cvx_begin
            variable w(M) complex
            minimize(w'*C*w)
            subject to
                % distortionless constraint
                w'*a == 1;
                % white noise gain constraint
                w'*w <= 1/wngth;
        cvx_end
        
        W{azi, fi}=w;
    end
end

%% plot performance indices
W0=cell(F, 1);
idx0=1;
for fi=1:F
    W0{fi}=W{idx0, fi};
end

figure(2);
plotWidebandBeampattern(array, f, W0, el);

figure(3);
ff=[f(41); f(81); f(161); f(241)];
ww={W0{41}; W0{81}; W0{161}; W0{241}};
plotBeampatternCartesian(array, ff, ww, el, 1e-3);
legend('1k', '2k', '4k', '6k');

% directivity index
figure(4);
plotWidebandDirectivityIndex(array, f, W0, [az(idx0); el]);

% white noise gain
figure(5);
plotWidebandWhiteNoiseGain(array, f, W0, [az(idx0); el]);

%
% save beamformers into file
% looks:                look directions (degree) [numlooks]
% W:                    cell contain beamformers {numlooks, numbins} (nummics)
% path:                 output file path
%
saveBeamformers(az, W, 'differential.f32');

%
% mod degrees in the range of [-180, 180]
% degree:               input degree
%
function doa = doaMod(degree)
doa = mod(degree, 360.0);
if doa < -180.0
    doa = doa + 360.0;
elseif doa > 180.0
    doa = doa - 360.0;
end
end
