function net = mlpCorrectWeights(net)
% mlpCorrectWeights - ������� ������������ ������� ����� ������� ����
% net = mlpCorrectWeights(net)
% ���� �������: 
%   net     - ���
% ����� �������:
%   net     - ��� c ����������������� ��������� �����

% �������� ������ - ������������� �����
for k = 1:net.numLayers
    net.layer(k).dW = net.speedLearn*net.layer(k).gW + ...
                        net.momentum*(net.layer(k).W - net.layer(k).Wp);
    net.layer(k).Wp = net.layer(k).W;
    net.layer(k).W = net.layer(k).W + net.layer(k).dW;
end

end %of function