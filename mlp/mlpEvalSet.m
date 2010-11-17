function [net, regresError, classError, numErrors, correct] = ...
    mlpEvalSet(net, dataSet)
% mlpEvalSet - ������ ��� ���� � ������ ������ ������������� � ��. ������
% [net, regresError, classError, numErrors, correct] = mlpEvalSet(net, dataSet)
% ���� �������: 
%   net      - ���
%   dataSet  - ���������, ����������� ���������/��������/����������� ��-��
% ����� �������:
%   net         - ���
%   regresError - ������������������ ������ ������� ����
%   classError  - ������� ������ ������������� �������
%   numErrors   - ���������� �������� ������������������ ��������
%   correct     - ������� ��������� ������������������ ��������

% ���� �� �������� ������� ���������
CE = zeros(1, dataSet.count); 
RE = zeros(1, dataSet.count);

for k = 1:dataSet.count
    [input, output, class] = mlpDsGetExample(dataSet, k, true);
    [net, RE(k), CE(k)] = mlpEval(net, input, output, class);
end

% ������ ������� �������� ���������� ��� ������ ��������� ��������
classError = sum(CE)/dataSet.count;
regresError = sum(RE)/dataSet.count;

correct = 100*(1 - classError);
numErrors = classError*dataSet.count;

end %of function