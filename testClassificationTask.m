function testClassificationTask()
% Функция осуществляет тестирование МСП на базе данных  из каталога
% preparedDataSets на решении задач классификации. Результаты работы 
% выводятся в соответствующий файл каталога testClassificationTask

clc;
clear all;

global flogid;
flogid = 1;

% список имен файлов, содержащих исходные данные для наборов множеств ИНС
filenames = {...   
        'cancer1'%,...
%         'cancer2',...
%         'cancer3',...
%         'card1',...
%         'card2',...
%         'card3',...
%         'diabetes1',...
%         'diabetes2',...
%         'diabetes3',...
%         'gene1',...
%         'gene2',...
%         'gene3',...
%         'glass1',...
%         'glass2',...
%         'glass3',...
%         'horse1',...  
%         'horse2',...  
%         'horse3',...  
%         'mushroom1',...
%         'mushroom2',...
%         'mushroom3',...        
%         'soybean1',...
%         'soybean2',...
%         'soybean3',...        
%         'thyroid1',...
%         'thyroid2',...
%         'thyroid3', ...
%         'textureCR', ...
%         'vowels', ...
%         'covtype'
    };

timeStart = cputime;
fprintf('\nНачало обработки базы тестовых задач...');

for k = 1:length(filenames)  
    clc;
    fprintf('\n\tОбрабатывается %s', char(filenames(k)));        
    
    % загрузка соответствующего набора данных
    ds = loadDataSets(char(filenames(k)));
    
    % создание МСП заданной архитектуры
    net = mlpCreate([ds.numInputs, 10, 8, ds.numOutputs], ...
                    {'tansig'; 'tansig'; 'tansig'});

    % обучение сети
    [net, errors] = mlpTrain(net, ds);  
    
    % сохранение обученной сети в файл
    path = strcat('./learnedTasks/', filenames(k), '_mlp');
    mlpSave(net, char(path));
    
    % сохранение графика обучения в файл
    path = strcat('./learnedTasks/', filenames(k), '_log');
    mlpPlot(char(path), errors);
    
    % сохранение лога обучения в файл
    path = strcat('./learnedTasks/', filenames(k), '_errors');
    save(char(path), 'errors');
    
    % создание обучающего множества для netff
    p = ds.training.inputs;
    t = ds.training.outputs;
    if(ds.hasTest > 0)
        p = [p; ds.test.inputs];
        t = [t; ds.test.outputs];
    end
    if(ds.hasValidation > 0)
        p = [p; ds.validation.inputs];
        t = [t; ds.validation.outputs];
    end
    
    % создание массива ячеек
    netm = newff(p', t', [ds.numInputs, 10, 8], {}, 'trainrp');
    [netm, tr] = train(netm, p', t');
    plotperform(tr);
    h = gcf;
    
    ytst = sim(netm, p');
    etst = t' - ytst;
    MSEtst = mse(etst);
    mclasses = classesFromOutputs(ytst');
    classErrorSet = sum(mclasses ~= ds.training.classes);
    classError = classErrorSet/ds.training.count;
    correct = 100*(1 - classError);
    numErrors = classError*ds.training.count;
    printMessage('Результаты тестирования MATLAB МСП на обучающем множестве');
    printMessage(sprintf('regressError = %g', MSEtst));
    printMessage(sprintf('classError = %g', classError));
    printMessage(sprintf('numErrors = %d', numErrors));
    printMessage(sprintf('correct = %5.2f%', correct));
    
    % сохранение лога обучения в файл
    path = strcat('./learnedTasks/', filenames(k), '_errors_matlab_mlp');
    saveas(h, char(path), 'png');
    close(h);
    
    pause(1);
end

fprintf('\nОбработка базы завершена. %d задач за %8.3f с\n', ...
            length(filenames), ...
            (cputime - timeStart)/60);
end % of function    