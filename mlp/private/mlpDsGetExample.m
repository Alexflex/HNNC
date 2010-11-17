function [input, output, class] = mlpDsGetExample(dataSet, k, direct)
% mlpDsGetExample - ��������� k ������� �� ��������� ��������
% [input, output, class] = mlpDsGetExample(dataSet, k)
% ���� �������: 
%   dataSet  - ���������, ����������� ���������/��������/����������� ��-��
%   k        - ������ �������
%   direct   - ���� �������� �������, �� ������ ������, ��������� ������
%              index
% ����� �������:
%   input  - ������� ������ �������
%   output - �������� ������ �������
%   class  - �����, � �������� ��������� ������

% ���� �� ������� direct, �� �������� ������ � ���������, ����� ������
% index
if(nargin < 3)
    input  = dataSet.inputs(dataSet.index(k), :);
    output = dataSet.outputs(dataSet.index(k), :);
    class  = dataSet.classes(dataSet.index(k), :);
else
    input  = dataSet.inputs(k, :);
    output = dataSet.outputs(k, :);
    class  = dataSet.classes(k, :);
end

end %of function