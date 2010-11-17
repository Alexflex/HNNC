function [classes, values] = classesFromOutputs(outputs)
% ��������� ������ ������� �������������� �� ������ �������� ��������
%
% classes = classesFromOutputs(outputs)
%
% Arguments
% outputs - �������� ������ ����
%
% classes - �����, � �������� ���� ������� ������ �������
% values  - ������ �������-����������
%
% Example
% outputs = [    1 -1 -1;
%               -1  1 -1;
%               -1 -1  1;
%                1 -1 -1;
%               -1 -1  1];
% classes = classesFromOutputs(outputs);
% classes
% classes = [   1;
%               2; 
%               3;
%               1;
%               3]
%
% See also
% 
% 
% Revisions
% Author: Vulfin Alex, Date: 17/11/2010
% Supervisor: Vulfin Alex, Date: 17/11/2010
% Author: (Next revision author), Date: (Next revision date)

% ���������� ���������� �������� �� �������� �������
[values, classes] = max(outputs, [], 2);

end %of function