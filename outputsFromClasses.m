function outputs = outputsFromClasses(classes, numOutputUnits)
% ��������� ����� �������� �������� �� ������� ������� ��������������
% outputs = outputsFromClasses(classes)
% ������� ���������: 
%   outputs - �����, � �������� ���� ������� ������ �������
% �������� ���������:
%   classes - �������� ������ ����
%
% ��������, ������ ������ classes ����� ������������� � ������� outputs
% classes:
%
% 1
% 2 
% 3 
% 1
% 3
%
% � outputs:
%
%  1 -1 -1
% -1  1 -1
% -1 -1  1
%  1 -1 -1
% -1 -1  1

sampleCount = length(classes);

outputs = -ones(sampleCount, numOutputUnits);

for k = 1:sampleCount
    outputs(k, classes(k)) = 1;
end

end % of function