function net = mlpCreate(numUnitsLayers, activateFuncs)
% Создает и инициализирует структуру, описывающую многослойный персептрон
%
% net = mlpCreate(numUnitsLayers, activateFuncs)
%
% Arguments
% numUnitsLayers - массив, описывающий количество нейронов по слоям
% activateFuncs - массив, описывающий функции активации нейронов скрытых и 
%   выходного слоев. Размерность на единицу меньше, чем numUnitsLayers. 
%   Состоит из строк вида 'tansig', 'purelin'
%
% net - структура, описывающая МСП заданной архитектуры
%
% Example
% net = mlpCreate([10, 8, 10, 10], {'tansig'; 'tansig'; 'tansig'});
%
% See also
% nntool
% 
% Revisions
% Author: Vulfin Alex, Date: 17/11/2010
% Supervisor: Vulfin Alex, Date: 17/11/2010
% Author: (Next revision author), Date: (Next revision date)

% Разбор аргументов функции
if any([length(numUnitsLayers) < 3, ...     % хотя бы один скрытый слой
        isinteger(numUnitsLayers),  ...     
        find(numUnitsLayers <= 0),  ...
        length(numUnitsLayers) ~= (size(activateFuncs, 1) + 1)])
    error('mlp_net: Неверные входные данные для создания сети');
end

% Инициализация параметров сети по умолчанию
net.numLayers = length(numUnitsLayers) - 1;	% количество слоев 
net.numInputUnits = numUnitsLayers(1);      % размерность входа
net.numOutputUnits = numUnitsLayers(end);	% размерность выхода
net.initValue = 0.25;                       % интервал инициализации
net.numEpoch = 1000;                        % максимальное количество эпох
net.momentum = 0.5;                         % момент обучения
net.speedLearn = 0.01;                      % скорость обучения
% минимальное значение градиента
net.minGradValue = 1e-10;                   
% вывод лога процесса обучения
net.printLog = 10;                          
% перемешивать обучающее множество каждые countShuffleSet эпох
net.countShuffleSet = 5;                    
% значение целевой функции на обучающем множестве
net.goal = 1e-5;                            

% Критерии остановки обучения
net.numEstimatedEpoch = 10;                 % количество оцениваемых эпох
% максимальное количество провалов на множестве оценивания
net.maxValidationFail = 10;                 
% количество провалов на множестве оценивания   
net.countValidationFail = 0;                
% пороговая ошибка на контрольном множестве
net.validationStopThreshold = 1e-5;         

% параметры первого скрытого слоя
% номер скрытого слоя
net.layer(1).number = 1;                    

% кол-во нейронов в слое
net.layer(1).numUnits = numUnitsLayers(2);  

% индуцированные локальные поля нейронов слоя
net.layer(1).V = zeros(1, numUnitsLayers(2));          

% выходы нейронов слоя
net.layer(1).Y = zeros(1, numUnitsLayers(2));          

% сигнал ошибки нейронов слоя
net.layer(1).E = zeros(1, numUnitsLayers(2));          

% локальные градиенты нейронов слоя
net.layer(1).G = zeros(1, numUnitsLayers(2));          

% векторы весов нейронов на итер. n
net.layer(1).W = ...                        
	randinit(net.initValue, net.numInputUnits + 1, numUnitsLayers(2)); 

% векторы весов нейронов на итер. n - 1
net.layer(1).Wp = ...                       
	randinit(net.initValue, net.numInputUnits + 1, numUnitsLayers(2)); 

% частные производные вида dE/dW
net.layer(1).gW = ...                       
	zeros(net.numInputUnits + 1, numUnitsLayers(2)); 

% приращения весов нейронов слоя на итер. n
net.layer(1).dW = ...                       
	zeros(net.numInputUnits + 1, numUnitsLayers(2));

% функция активации и ее производная для нейронов слоя
if (strcmp(activateFuncs(1), 'tansig'))
    net.layer(1).f  = @hyptan;
    net.layer(1).df = @dhyptan;
elseif (strcmp(activateFuncs(1), 'purelin'))
    net.layer(1).f  = @purelinf;
    net.layer(1).df = @dpurelinf;
else
    error('mlp_net: Неверно определены функции активации нейронов');
end
        
printMessage('\nmlp_net: Создан %d слой', 1);

% параметры второго и последующих скрытых слоев
for k = 2:net.numLayers    
    net.layer(k).number = k;                       
    net.layer(k).numUnits = numUnitsLayers(k + 1);              
    net.layer(k).V = zeros(1, numUnitsLayers(k + 1));    
    net.layer(k).Y = zeros(1, numUnitsLayers(k + 1));    
    net.layer(k).E = zeros(1, numUnitsLayers(k + 1));    
    net.layer(k).G = zeros(1, numUnitsLayers(k + 1));   
    
    net.layer(k).W = randinit(net.initValue, ...
                              net.layer(k - 1).numUnits + 1, ...
                              numUnitsLayers(k + 1));
                          
    net.layer(k).Wp = randinit(net.initValue, ...
                               net.layer(k - 1).numUnits + 1, ...
                               numUnitsLayers(k + 1));
                           
    net.layer(k).dW = zeros(net.layer(k - 1).numUnits + 1, ...
                            numUnitsLayers(k + 1)); 
                        
    net.layer(k).gW = zeros(net.layer(k - 1).numUnits + 1, ...
                            numUnitsLayers(k + 1));

    if (strcmp(activateFuncs(k), 'tansig'))
        net.layer(k).f  = @hyptan;
        net.layer(k).df = @dhyptan;
    elseif (strcmp(activateFuncs(1), 'purelin'))
        net.layer(k).f  = @purelinf;
        net.layer(k).df = @dpurelinf;
    else
        error('mlp_net: Неверные определены функции активации нейронов');
    end
    
    printMessage('\nmlp_net: Создан %d слой', k);
end

end % of function