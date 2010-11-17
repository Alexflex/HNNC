function net = mlpLoad(dataFileName)
% ������� ��������� ����������� ���������, ����������� ���, �� �����
%
% net = mlpLoad(dataFileName)
%
% Arguments
% dataFileName - ��� ����� ������������
%
% net - ��� �� �����
%
% Example
% net = mlpLoad(char(path));
%
% See also
% 
%
% Revisions
% Author: Vulfin Alex, Date: 17/11/2010
% Supervisor: Vulfin Alex, Date: 17/11/2010
% Author: (Next revision author), Date: (Next revision date)

net = load(dataFileName);
net = net.net;

end %of function