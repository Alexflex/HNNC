function [net, errors] = mlpTrain(net, dataSets)
% mlpTrain - обучение МСП
% [net, errors] = mlpTrain(net, dataSets)
% Вход функции: 
%   net      - МСП
%   dataSet  - структура, описывающая обучающее/тестовое/контрольное мн-во
% Выход функции:
%   net      - обученный МСП
%   errors   - структура, описывающая процесс обучения МСП

% Инициализация обучения
k = 1;                                  % счетчик эпох обучения
alldone = false;                        % флаг завершения обучения
tic;                                    % таймер начала обучения

% сохранение процесса обучения
errors.test.RE = [];
errors.test.CE = [];
errors.test.NE = [];
errors.test.CR = [];
errors.training.RE = [];
errors.training.CE = [];
errors.training.NE = [];
errors.training.CR = [];
errors.validation.RE = [];
errors.validation.CE = [];
errors.validation.NE = [];
errors.validation.CR = [];

% Перемешивание примеров в каждом непустом множестве
if(dataSets.hasValidation)
    dataSets.validation.index = randperm(dataSets.validation.count);
end   

if(dataSets.hasTest)
    dataSets.test.index = randperm(dataSets.test.count);
end 

dataSets.training.index = randperm(dataSets.training.count);

% ========================================================================
% Цикл по эпохам обучения
% ========================================================================
while ~alldone  

    % Перемешивание примеров в каждом непустом множестве
    if(dataSets.hasValidation && mod(k, net.countShuffleSet) == 0)
        dataSets.validation.index = randperm(dataSets.validation.count);
    end   
    
    if(dataSets.hasTest && mod(k, net.countShuffleSet) == 0)
        dataSets.test.index = randperm(dataSets.test.count);
    end 

    if(mod(k, net.countShuffleSet) == 0)
        dataSets.training.index = randperm(dataSets.training.count);
    end
    
    % Цикл по обучающим примерам
    for p = 1:dataSets.training.count
        
        % Получить пример из обучающего множества
        [input, output, class] = mlpDsGetExample(dataSets.training, p);
        
        % Прямой проход и ошибка обучения для последнего слоя
        net = mlpEval(net, input, output, class);
        
        % Обратный проход: расчет локальных градиентов
        net = mlpCalcLocalG(net, input);
        
        % Обратный проход - корректировка весов
        net = mlpCorrectWeights(net);
    end
    
    % оценка нормы градиента по слоям
    dnorm = mlpEstimateG(net);
    
    % оценка выходов сети после одного цикла корректировки весов на
    % обучающем множестве
    [net, errors.training.RE(k), errors.training.CE(k), ...
          errors.training.NE(k), errors.training.CR(k)] = ...
                                    mlpEvalSet(net, dataSets.training);
    
    % оценка выходов сети после одного цикла корректировки весов на
    % тестовом множестве
    if(dataSets.hasTest)
        [net, errors.test.RE(k), errors.test.CE(k), ...
              errors.test.NE(k), errors.test.CR(k)] = ...
                                    mlpEvalSet(net, dataSets.test);
    end
    
    % оценка выходов сети после одного цикла корректировки весов на
    % контрольном множестве
    if(dataSets.hasValidation)
        [net, errors.validation.RE(k), errors.validation.CE(k), ...
              errors.validation.NE(k), errors.validation.CR(k)] = ...
                                    mlpEvalSet(net, dataSets.validation);
    end   
    
    % вывод лога обучения сети и сохранение самой сети
    if(mod(k, net.printLog) == 0)          
        printMessage('\n\t\tEpochs: %g', k);       
        printMessage('\n\t\t\tTraining:\tre(ce) = %-10g (%-10g) | numErrors = %-5g | correct = %-5.2f', ...
                    errors.training.RE(k), errors.training.CE(k), ...
                    errors.training.NE(k), errors.training.CR(k));
               
        if(dataSets.hasTest)
            printMessage('\n\t\t\tTest:\t\tre(ce) = %-10g (%-10g) | numErrors = %-5g | correct = %-5.2f', ...
                        errors.test.RE(k), errors.test.CE(k), ...
                        errors.test.NE(k), errors.test.CR(k));
        end

        if(dataSets.hasValidation)
            printMessage('\n\t\t\tValidation:\tre(ce) = %-10g (%-10g) | numErrors = %-5g | correct = %-5.2f', ...
                        errors.validation.RE(k), errors.validation.CE(k), ...
                        errors.validation.NE(k), errors.validation.CR(k));
        end  
    end
        
    % условие досрочного выхода из цикла по достижении порога на 
    % контрольном множестве.
    % Построение линейной аппроксимации последних net.numEstimatedEpoch 
    % значений ошибки на проверочном множестве 
    if(dataSets.hasValidation && k > net.numEstimatedEpoch)
        x = k - net.numEstimatedEpoch:1:k;
        y = errors.validation.RE(k - net.numEstimatedEpoch:k);
        pol = polyfit(x, y, 1);
       
        % наклон прямой, аппроксимирующей последние lenEstimatedEpoch точек 
        if(pol(1) > 0)
            net.countValidationFail = net.countValidationFail + 1;
            
        % если возрастание ошибки не является тендецией, то обнулить
        % счетчик ошибок. Если же ошибки идут подряд, то по превышении
        % порога maxValidationFail обучение прекратится
        elseif  ((pol(1) < 0) && ...            
                 (net.countValidationFail > 0))
            net.countValidationFail = 0;
            printMessage('\n\t\tОбнулен счетчик провалов на проверочном множестве');
        end
    end

    % проверка критериев останова процесса обучения
    if(k > net.numEpoch)
        alldone = true;
        printMessage('\n\t\tДостигнуто максимальное количество эпох');
    end
    
    if(dnorm < net.minGradValue)
        alldone = true;
        printMessage('\n\t\tДостигнуто минимальное значение градиента');
    end
    
    if(net.countValidationFail > net.maxValidationFail)
        alldone = true;
        printMessage('\n\t\tРанний останов на проверочном множестве');
    end
    
    if(dataSets.hasValidation && ...
       errors.validation.RE(k) < net.validationStopThreshold)
        alldone = true;
        printMessage('\n\t\tДостигнуто минимальное значение на проверочном множестве');
    end
    
    if(errors.training.RE(k) < net.goal)
        alldone = true;
        printMessage('\n\t\tДостигнуто минимальное значение целевой фукнции на обучающем множестве');
    end
    
    % наращиваем счетчик эпох
    k = k + 1;
end
% ========================================================================

% оценка выходов сети после обучения
[net, errors.training.regression, errors.training.classification, ...
	errors.training.numErrors, errors.training.correct] = ...
    mlpEvalSet(net, dataSets.training);

if(dataSets.hasValidation)
    [net, errors.validation.regression, errors.validation.classification, ...
	errors.validation.numErrors, errors.validation.correct] = ...
    mlpEvalSet(net, dataSets.validation);
end

if(dataSets.hasTest)
    [net, errors.test.regression, errors.test.classification, ...
	errors.test.numErrors, errors.test.correct] = ...
	mlpEvalSet(net, dataSets.test);
end

% вывод длительности процесса обучения и ошибки на множествах
printMessage('\n\tTraining completed: %g s', toc);

printMessage('\n\tTraining:\tre(ce) = %-10g (%-10g) | numErrors = %-5g | correct = %-5.2f', ...
	errors.training.regression, errors.training.classification, ...
	errors.training.numErrors, errors.training.correct);

if(dataSets.hasValidation)
    printMessage('\n\tValidation:\tre(ce) = %-10g (%-10g) | numErrors = %-5g | correct = %-5.2f', ...
        errors.validation.regression, errors.validation.classification, ...
        errors.validation.numErrors, errors.validation.correct);
end

if(dataSets.hasTest)
    printMessage('\n\tTest:\t\tre(ce) = %-10g (%-10g) | numErrors = %-5g | correct = %-5.2f', ...
        errors.test.regression, errors.test.classification, ...
        errors.test.numErrors, errors.test.correct);
end

end % of function