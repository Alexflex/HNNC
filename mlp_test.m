clc
clear all

global flogid;
flogid = 1;

filenames = 'textureCR';
% filenames = 'vowels';
% filenames = 'soybean1';
% filenames = 'mushroom1';
% filenames = 'nXOR';

% �������� ���������� ��������� �� �����
ds = loadDataSets(filenames);

tic;
printMessage('\n������ ��������� �������� ������ %s', filenames);

path = strcat('./learnedTasks/', filenames, '_text__log.dat');
% flogid = fopen(char(path), 'w');
if(flogid == -1)
    error('Test: �� ���� ������� ���� %s', flogid);
end

% �������� ��� �������� �����������
net = mlpCreate([ds.numInputs, 8, 10, ds.numOutputs], ...
                {'tansig'; 'tansig'; 'tansig'});

% �������� ����
net.speedLearn = 0.01;
net.numEpoch = 1000;                        
[net, errors] = mlpTrain(net, ds);  

% ���������� ��������� ���� � ����
path = strcat('./learnedTasks/', filenames, '_mlp');
mlpSave(net, char(path));

% ���������� ������� �������� � ����
path = strcat('./learnedTasks/', filenames, '_log');
mlpPlot(char(path), errors, true);

% ���������� ���� �������� � ����
path = strcat('./learnedTasks/', filenames, '_errors');
save(char(path), 'errors');

% ������������ ����
printMessage('\n\t������������ ��� �� ��������� ���������');
printMLPEvalLog(net, ds.training);
if(ds.hasTest)
    printMessage('\n\t������������ ��� �� �������� ���������');
    printMLPEvalLog(net, ds.test);
end
if(ds.hasValidation)
    printMessage('\n\t������������ ��� �� ����������� ���������');
    printMLPEvalLog(net, ds.validation);
end

% ���������� ���� �������� � ����
path = strcat('./learnedTasks/', filenames, '_errors_matlab_mlp');

% �������� � �������� ��� Matlab
mlpMatlabTest(ds, path, ds.numInputs, 8, 10);

printMessage('\n��������� ���� ��������� �� %8.3f �\n', toc);
