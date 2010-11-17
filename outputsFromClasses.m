function outputs = outputsFromClasses(classes, numOutputUnits)
% ��������� ����� �������� �������� �� ������� ������� ��������������
%
% outputs = outputsFromClasses(classes, numOutputUnits)
%
% Arguments
% classes - �������� ������ ����
% numOutputUnits - ����������� ������� �������
%
% outputs - �����, � �������� ���� ������� ������ �������
%
% Example
% classes = [   1;
%               2; 
%               3;
%               1;
%               3];
% outputs = outputsFromClasses(classes, 3);
% outputs = [    1 -1 -1;
%               -1  1 -1;
%               -1 -1  1;
%                1 -1 -1;
%               -1 -1  1];
%
% See also
% 
% Revisions
% Author: Vulfin Alex, Date: 17/11/2010
% Supervisor: Vulfin Alex, Date: 17/11/2010
% Author: (Next revision author), Date: (Next revision date)


sampleCount = length(classes);

outputs = -ones(sampleCount, numOutputUnits);

for k = 1:sampleCount
    outputs(k, classes(k)) = 1;
end

end % of function