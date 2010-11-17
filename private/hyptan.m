function y = hyptan(x)
% ������� ��������� ���� ���������������� ���. �������
% ������������ �������� ��, ��� hyptan(+-1) = +-1
%
% y = hyptan(x)
%
% Arguments
% x - �������������� ��������� ���� �������
%
% y - ����� ������� 
%
% Example
% y = hyptan(x);
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

% �������������� ������������
a = 1.7159;
b = 2/3;

y = a*tanh(b*x);

end %of function