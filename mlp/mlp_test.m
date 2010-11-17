% clc
% clear all

global flogid;

% filenames = 'textureCR';
filenames = 'vowels';
% filenames = 'soybean1';
% filenames = 'mushroom1';
% filenames = 'soybean1';

% �������� ���������� ��������� �� �����
ds = loadDataSets(filenames);

timeStart = cputime;
fprintf('\n������ ��������� ���� �������� �����...');

path = strcat('./learnedTasks/', filenames, '_text__log.dat');
flogid = fopen(char(path), 'w');
if(flogid == -1)
    error('Test: �� ���� ������� ���� %s', flogid);
end

% �������� ��� �������� �����������
net = mlpCreate([ds.numInputs, 8, 10, ds.numOutputs], ...
                {'tansig'; 'tansig'; 'tansig'});

% �������� ����
net.speedLearn = 0.01;
net.numEpoch = 100;                        
[net, errors] = mlpTrain(net, ds);  

% ���������� ��������� ���� � ����
path = strcat('./learnedTasks/', filenames, '_mlp');
mlpSave(net, char(path));

% ���������� ������� �������� � ����
path = strcat('./learnedTasks/', filenames, '_log');
mlpPlot(char(path), errors);

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

% �������� ���������� ��������� ��� netff
p = ds.training.inputs;
t = ds.training.outputs;
if(ds.hasValidation)
    p = [p; ds.validation.inputs];
    t = [t; ds.validation.outputs];
end

% �������� ������� �����
netm = newff(p', t', [ds.numInputs, 8, 10], {}, 'trainrp');
[netm, tr] = train(netm, p', t');
plotperform(tr);
h = gcf;

p = [ds.training.inputs];
t = [ds.training.outputs];
ytst = sim(netm, p');
etst = t' - ytst;
MSEtst = mse(etst);
mclasses = classesFromOutputs(ytst');
classErrorSet = sum(mclasses ~= ds.training.classes);
classError = classErrorSet/ds.training.count;
correct = 100*(1 - classError);
numErrors = classError*ds.training.count;
printMessage('\n\t���������� ������������ MATLAB ��� �� ��������� ���������');
printMessage(sprintf('\n\t\tregressError = %g', MSEtst));
printMessage(sprintf('\n\t\tclassError = %g', classError));
printMessage(sprintf('\n\t\tnumErrors = %d', numErrors));
printMessage(sprintf('\n\t\tcorrect = %5.2f%', correct));

% Obtaining the test MSE
if(ds.hasTest)
    p = [ds.test.inputs];
    t = [ds.test.outputs];
    ytst = sim(netm, p');
    etst = t' - ytst;
    MSEtst = mse(etst);
    mclasses = classesFromOutputs(ytst');
    classErrorSet = sum(mclasses ~= ds.test.classes);
    classError = classErrorSet/ds.test.count;
    correct = 100*(1 - classError);
    numErrors = classError*ds.test.count;
    printMessage('\n\t���������� ������������ MATLAB ��� �� �������� ���������');
    printMessage(sprintf('\n\t\tregressError = %g', MSEtst));
    printMessage(sprintf('\n\t\tclassError = %g', classError));
    printMessage(sprintf('\n\t\tnumErrors = %d', numErrors));
    printMessage(sprintf('\n\t\tcorrect = %5.2f%', correct));
end

% ���������� ���� �������� � ����
path = strcat('./learnedTasks/', filenames, '_errors_matlab_mlp');
saveas(h, char(path), 'png');

fprintf('\n��������� ���� ���������. %d ����� �� %8.3f �\n', ...
            length(filenames), ...
            (cputime - timeStart)/60);
