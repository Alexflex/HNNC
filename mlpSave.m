function mlpSave(net, dataFileName)
% ������� ��������� ���������, ����������� ���, � ����
% ������� ���������:
%   net - ���������, ����������� ����������� ���
%   dataFileName - ��� ����� ������������
% �������� ���������:
%   net - ���   

save(dataFileName, 'net');

end %of function