function y = randinit(a, varargin)
% ������������� ����� ���������� ������� �� ��������� [-a; a]

% y = randinit(a, varargin)

% Arguments 
% a	- ������ ������� ��������� ��������� �������������
% varargin	- ������������ ������������ ����������������� �������
%
% y    - ������, ������������������ ���������� ������� �� ���������
%
% Example
% y = randinit(0.25, 3, 3);
%
% See also
% rand
% 
% Revisions
% Author: Vulfin Alex, Date: 17/11/2010
% Supervisor: Vulfin Alex, Date: 17/11/2010
% Author: (Next revision author), Date: (Next revision date)


if(nargin < 2)
    error('randinit: ������� ������ ������� ������� �������������');
end

y = -a + 2*a*rand(varargin{:});

end %of function