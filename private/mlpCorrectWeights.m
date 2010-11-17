function net = mlpCorrectWeights(net)
% ������� ������������ ������� ����� ������� ����
%
% net = mlpCorrectWeights(net)
%
% Arguments
% net - ���
%
% net - ��� c� ������������������ ��������� �����
%
% Example
% net = mlpCorrectWeights(net);
%
% See also
% 
% Revisions
% Author: Vulfin Alex, Date: 17/11/2010
% Supervisor: Vulfin Alex, Date: 17/11/2010
% Author: (Next revision author), Date: (Next revision date)

% �������� ������ - ������������� �����
for k = 1:net.numLayers
    net.layer(k).dW = net.speedLearn*net.layer(k).gW + ...
                        net.momentum*(net.layer(k).W - net.layer(k).Wp);
    net.layer(k).Wp = net.layer(k).W;
    net.layer(k).W = net.layer(k).W + net.layer(k).dW;
end

end %of function