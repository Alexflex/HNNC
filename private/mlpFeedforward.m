function [net, output] = mlpFeedforward(net, input)
% mlpFeedforward - ������ ��� ����
% [net, output] = mlpFeedforward(net, input)
% ���� �������: 
%   net    - ���
%   input  - ������� ������
% ����� �������:
%   net    - ���
%   output - ����� ����

% �������� ����������� �����
if (length(input) ~= net.numInputUnits)
    error('mlp_feedforward: ����������� �������� ������� �������');
end

% ������ ������� ������� �������� ���� c ������ �������� ��� ��������
net.layer(1).V = [1 input]*net.layer(1).W;
net.layer(1).Y = feval(net.layer(1).f, net.layer(1).V);

% ������ ������� ������� � ����������� ������� �����
for i = 2:net.numLayers
    net.layer(i).V = [1 net.layer(i - 1).Y]*net.layer(i).W;
    net.layer(i).Y = feval(net.layer(i).f, net.layer(i).V);
end

output = net.layer(net.numLayers).Y;
end %of function