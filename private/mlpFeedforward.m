function [net, output] = mlpFeedforward(net, input)
% ������ ��� ����
%
% [net, output] = mlpFeedforward(net, input)
%
% Arguments
% net      - ���
% input    - ������� ������ ��� ������� 
%
% net      - ���
% output   - �������� ������ ��� ������� 
%
% Example
% [net, output] = mlpFeedforward(net, input);
%
% See also
% 
% Revisions
% Author: Vulfin Alex, Date: 17/11/2010
% Supervisor: Vulfin Alex, Date: 17/11/2010
% Author: (Next revision author), Date: (Next revision date)

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