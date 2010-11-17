function mlpSave(net, dataFileName)
% ������� ��������� ���������, ����������� ���, � ����
%
% mlpSave(net, dataFileName)
%
% Arguments
% net - ���������, ����������� ����������� ���
% dataFileName - ��� ����� ������������ 
%
% Example
% mlpSave(net, char(path));
%
% See also
% 
%
% Revisions
% Author: Vulfin Alex, Date: 17/11/2010
% Supervisor: Vulfin Alex, Date: 17/11/2010
% Author: (Next revision author), Date: (Next revision date)

save(dataFileName, 'net');

end %of function