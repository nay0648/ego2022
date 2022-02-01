function [ C ] = sphericalDiffuseCorr( array, f )
% Correlation matrix in ideal spherical diffuse noise field
%
% array:            the array
% f:                frequency (Hz)
%
% C:                the correlation matrix
%
v=340;

M=getNumElements(array);
C=zeros(M, M);

for i=1:M
    for j=i:M
        d=norm(getElementPosition(array, i)-getElementPosition(array, j));
        c=2*pi*f*d/v;
%         if c<eps
%             c=1;
%         else
%             c=sin(c)/c;
%         end

        %
        % !!!
        % Matlab's sinc is not real sinc function.
        % !!!
        %
        c=sinc(c/pi);
        
        C(i, j)=c;
        C(j, i)=c;
    end
end

end
