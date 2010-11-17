function [input, output, class] = mlpDsGetExample(dataSet, k, takeDirect)
% ������� ��������� k ������� �� ��������� ��������
%
% [input, output, class] = mlpDsGetExample(dataSet, k, takeDirect);
%
% Arguments
% dataSet - ���������, ����������� ���������/��������/����������� ��-��
% k - ������ �������
% takeDirect - ���� �������� �������, �� ������ ������, ��������� ������ index
%
% input  - ������� ������ �������
% output - �������� ������ �������
% class  - �����, � �������� ��������� ������
%
% Example
% [input, output, class] = mlpDsGetExample(dataSet, k, true);
%
% See also
% 
% Revisions
% Author: Vulfin Alex, Date: 17/11/2010
% Supervisor: Vulfin Alex, Date: 17/11/2010
% Author: (Next revision author), Date: (Next revision date)

% ���� �� ������� direct, �� �������� ������ � ���������, ����� ������
% index
if(~takeDirect)
    input  = dataSet.inputs(dataSet.index(k), :);
    output = dataSet.outputs(dataSet.index(k), :);
    class  = dataSet.classes(dataSet.index(k), :);
else
    input  = dataSet.inputs(k, :);
    output = dataSet.outputs(k, :);
    class  = dataSet.classes(k, :);
end

end %of function