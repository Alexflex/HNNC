function [net, regresError, classError] = mlpEval(net, input, output, class)
% ������ ��� ����, ������ ������ ������������� � ��. ������
%
% [net, regresError, classError] = mlpEval(net, input, output, class)
%
% Arguments
% net      - ���
% input    - ������� ������ ��� ������� 
% output   - �������� ������ ��� ������� 
% class    - �����, � �������� ��������� ������
%
% net         - ���
% regresError - ������������ ������ ������� ����
% classError  - ������ ������������� �������
%
% Example
% [net, regresError, classError] = mlpEval(net, input, output, class);
%
% See also
% 
% Revisions
% Author: Vulfin Alex, Date: 17/11/2010
% Supervisor: Vulfin Alex, Date: 17/11/2010
% Author: (Next revision author), Date: (Next revision date)

% ������ ������ ����
[net, netOutput] = mlpFeedforward(net, input);

% ������� ������ �������� ���������� ���� ����
net.layer(net.numLayers).E = output - netOutput;

% ������������ ������ ������ ����
regresError = sum(net.layer(net.numLayers).E .^2) / net.numOutputUnits;
netClasses = classesFromOutputs(netOutput);
classError = sum(netClasses ~= class);

end %of function