function printMessage(str, varargin)
% ������� ������� ��������� � �����, ������������ ���������� ����������
% flogid
%
% printMessage(str, varargin)
%
% Arguments
% str         - ������ ��������������
% varargin    - ��������� 
%
% Example
% printMessage('\n\t%d', 5);
%
% See also
% 
% Revisions
% Author: Vulfin Alex, Date: 17/11/2010
% Supervisor: Vulfin Alex, Date: 17/11/2010
% Author: (Next revision author), Date: (Next revision date)

% ���������� ����� ������, ��������� ���� � �������, ���� � ������
global flogid;

fprintf(flogid, str, varargin{:});

end %of function