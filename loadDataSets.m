function dataSets = loadDataSets(dataSetsName)
% ������� ��������� ��������� ��������� �� ������������ ������������
%
% dataSets = loadDataSets(dataSetsName)
%
% Arguments
% dataSetsName - ��� ������������
%
% dataSets - ��������� ���������
%
% Example
% ds = loadDataSets(filenames);
%
% See also
% 
% 
% Revisions
% Author: Vulfin Alex, Date: 17/11/2010
% Supervisor: Vulfin Alex, Date: 17/11/2010
% Author: (Next revision author), Date: (Next revision date)

dataSets = load(strcat('./preparedDataSets/', dataSetsName));

end %of function