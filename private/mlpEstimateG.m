function dnorm = mlpEstimateG(net)
% mlpEstimateG - ��������� ��������� ����� ����������
% [net, dnorm] = mlpEstimateG(net)
% ���� �������: 
%   net      - ���
% ����� �������:
%   net      - ���
%   dnorm    - ������ ���������� ����� ������� ���������

grad = [];
for k = 1:net.numLayers
    grad = [net.layer(k).gW(:); grad];
end

dnorm = norm(grad');

end %of function