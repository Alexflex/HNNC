function printMessage(str, varargin)
% ������� ������� ��������� � �����, ������������ ���������� ����������
% flogid
% ������� ���������:
%   str         - ������ ��������������
%   varargin    - ���������
% �������� ���������:  

% ���������� ����� ������, ��������� ���� � �������, ���� � ������
global flogid;

fprintf(flogid, str, varargin{:});

end %of function