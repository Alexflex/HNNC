% clc
% clear all

global flogid;

% filenames = 'textureCR';
filenames = 'vowels';
% filenames = 'soybean1';
% filenames = 'mushroom1';
% filenames = 'soybean1';

% загрузка обучающего окружения из файла
ds = loadDataSets(filenames);

timeStart = cputime;
fprintf('\nНачало обработки базы тестовых задач...');

path = strcat('./learnedTasks/', filenames, '_text__log.dat');
flogid = fopen(char(path), 'w');
if(flogid == -1)
    error('Test: Не могу открыть файл %s', flogid);
end

% создание МСП заданной архитектуры
net = mlpCreate([ds.numInputs, 8, 10, ds.numOutputs], ...
                {'tansig'; 'tansig'; 'tansig'});

% обучение сети
net.speedLearn = 0.01;
net.numEpoch = 100;                        
[net, errors] = mlpTrain(net, ds);  

% сохранение обученной сети в файл
path = strcat('./learnedTasks/', filenames, '_mlp');
mlpSave(net, char(path));

% сохранение графика обучения в файл
path = strcat('./learnedTasks/', filenames, '_log');
mlpPlot(char(path), errors);

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

% создание обучающего множества для netff
p = ds.training.inputs;
t = ds.training.outputs;
if(ds.hasValidation)
    p = [p; ds.validation.inputs];
    t = [t; ds.validation.outputs];
end

% создание массива ячеек
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
printMessage('\n\tРезультаты тестирования MATLAB МСП на обучающем множестве');
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
    printMessage('\n\tРезультаты тестирования MATLAB МСП на тестовом множестве');
    printMessage(sprintf('\n\t\tregressError = %g', MSEtst));
    printMessage(sprintf('\n\t\tclassError = %g', classError));
    printMessage(sprintf('\n\t\tnumErrors = %d', numErrors));
    printMessage(sprintf('\n\t\tcorrect = %5.2f%', correct));
end

% сохранение лога обучения в файл
path = strcat('./learnedTasks/', filenames, '_errors_matlab_mlp');
saveas(h, char(path), 'png');

fprintf('\nОбработка базы завершена. %d задач за %8.3f с\n', ...
            length(filenames), ...
            (cputime - timeStart)/60);
