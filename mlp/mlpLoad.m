function net = mlpLoad(dataFileName)
% ������� ��������� ����������� ���������, ����������� ���, �� �����
% ������� ���������:
%   dataFileName - ��� ����� ������������
% �������� ���������:
%   net - ��� �� �����   

net = load(dataFileName);
net = net.net;

end %of function