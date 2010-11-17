function d = dhyptan(y)
% ����������� ������� ��������� ���� ���������������� 
% ���. ������� (������������ �������� ��, ��� atansigb(+-1) = +-1)
% ��� ���������� �������� ����������� ������������ ������������ �����
% �������� ������� ��������� hyptan(x)
%
% d = dhyptan(y) 
%
% Arguments
% y    - �������� ������� ��������� (������/�������)
%
% d    - ����������� ������� ��������� (������/�������)
%
% Example
% d = dhyptan(10);
%
% See also
% tanh
% ������ ������ ��������� ����: ������ ���� = 
% Neural Networks: A Comprehensive Foundation. � 2-�. � 
% �.: ��������, 2006. � �. 1104. � ISBN 0-13-273350-1
% 
% Revisions
% Author: Vulfin Alex, Date: 17/11/2010
% Supervisor: Vulfin Alex, Date: 17/11/2010
% Author: (Next revision author), Date: (Next revision date)

a = 1.7159;
b = 2/3;
d = b/a .* (a - y) .* (a + y);

end %of function