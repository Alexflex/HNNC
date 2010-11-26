clc
clear all

global flogid;
flogid = 1;

filenames = 'textureCR';
% filenames = 'vowels';
% filenames = 'soybean1';
% filenames = 'mushroom1';
% filenames = 'nXOR';

% загрузка обучающего окружения из файла
ds = loadDataSets(filenames);

tic;
printMessage('\nНачало обработки тестовой задачи %s', filenames);

path = strcat('./learnedTasks/', filenames, '_text__log.dat');
% flogid = fopen(char(path), 'w');
if(flogid == -1)
    error('Test: Не могу открыть файл %s', flogid);
end

% создание МСП заданной архитектуры
net = mlpCreate([ds.numInputs, 8, 10, ds.numOutputs], ...
                {'tansig'; 'tansig'; 'tansig'});

% обучение сети
net.speedLearn = 0.01;
net.numEpoch = 1000;                        
[net, errors] = mlpTrain(net, ds);  

% сохранение обученной сети в файл
path = strcat('./learnedTasks/', filenames, '_mlp');
mlpSave(net, char(path));

% сохранение графика обучения в файл
path = strcat('./learnedTasks/', filenames, '_log');
mlpPlot(char(path), errors, true);

% сохранение лога обучения в файл
path = strcat('./learnedTasks/', filenames, '_errors');
save(char(path), 'errors');

% тестирование сети
printMessage('\n\tТестирование МСП на обучающем множестве');
printMLPEvalLog(net, ds.training);
if(ds.hasTest)
    printMessage('\n\tТестирование МСП на тестовом множестве');
    printMLPEvalLog(net, ds.test);
end
if(ds.hasValidation)
    printMessage('\n\tТестирование МСП на контрольном множестве');
    printMLPEvalLog(net, ds.validation);
end

% сохранение лога обучения в файл
path = strcat('./learnedTasks/', filenames, '_errors_matlab_mlp');

% создание и обучение МСП Matlab
mlpMatlabTest(ds, path, ds.numInputs, 8, 10);

printMessage('\nОбработка базы завершена за %8.3f с\n', toc);
