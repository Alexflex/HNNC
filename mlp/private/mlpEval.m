function [net, regresError, classError] = mlpEval(net, input, output, class)
% mlpEval - ������ ��� ���� � ������ ������ ������������� � ��. ������
% [net, regresError, classError] = mlpEval(net, dataSet)
% ���� �������: 
%   net      - ���
%   input    - ������� ������ ��� ������� 
%   output   - �������� ������ ��� ������� 
%   class    - �����, � �������� ��������� ������
% ����� �������:
%   net         - ���
%   regresError - ������������ ������ ������� ����
%   classError  - ������ ������������� �������

% ������ ������ ����
[net, netOutput] = mlpFeedforward(net, input);

% ������� ������ �������� ���������� ���� ����
net.layer(net.numLayers).E = output - netOutput;

% ������������ ������ ������ ����
regresError = sum(net.layer(net.numLayers).E .^2) / net.numOutputUnits;
netClasses = classesFromOutputs(netOutput);
classError = sum(netClasses ~= class);

end %of function