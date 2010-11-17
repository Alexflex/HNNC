function [classes, values] = classesFromOutputs(outputs)
% ��������� ������ ������� �������������� �� ������ �������� ��������
% classes = classesFromOutputs(outputs)
% ������� ���������: 
%   outputs - �������� ������ ����
% �������� ���������:
%   classes - �����, � �������� ���� ������� ������ �������
%   values  - ������ �������-����������
%
% ��������, ������ ������� outputs ����� �������������� � ������ classes
% outputs:
%  1 -1 -1
% -1  1 -1
% -1 -1  1
%  1 -1 -1
% -1 -1  1
% 
% � classes:
%
% 1
% 2 
% 3 
% 1
% 3

% ���������� ���������� �������� �� �������� �������
[values, classes] = max(outputs, [], 2);

end %of function