function dataSets = loadDataSets(dataSetsName)
% ������� ��������� ��������� ��������� �� ������������ ������������
% dataSets = loadDataSets(dataSetsName)
% ������� ���������:
%   dataSetsName - ��� ������������
% �������� ���������:
%   dataSets - ��������� ��������� ��� ���   

dataSets = load(strcat('./preparedDataSets/', dataSetsName));

end %of function