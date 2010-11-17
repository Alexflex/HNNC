function dnorm = mlpEstimateG(net)
% ������� ��������� ��������� ����� ����������
%
% dnorm = mlpEstimateG(net)
%
% Arguments
% net      - ���
%
% dnorm    - ������ ���������� ����� ������� ���������
%
% Example
% dnorm = mlpEstimateG(net);
%
% See also
% 
% Revisions
% Author: Vulfin Alex, Date: 17/11/2010
% Supervisor: Vulfin Alex, Date: 17/11/2010
% Author: (Next revision author), Date: (Next revision date)


grad = [];
for k = 1:net.numLayers
    grad = [net.layer(k).gW(:); grad];
end

dnorm = norm(grad');

end %of function