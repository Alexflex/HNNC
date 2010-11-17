function [net, regresError, classError] = mlpEval(net, input, output, class)
% mlpEval - прямой ход сети и оценка ошибки классификации и кв. ошибки
% [net, regresError, classError] = mlpEval(net, dataSet)
% Вход функции: 
%   net      - МСП
%   input    - входной вектор для примера 
%   output   - выходной вектор для примера 
%   class    - класс, к которому относится пример
% Выход функции:
%   net         - МСП
%   regresError - квадратичная ошибка отклика сети
%   classError  - ошибка классификации образца

% оценка выхода сети
[net, netOutput] = mlpFeedforward(net, input);

% задание ошибок нейронов последнего слоя сети
net.layer(net.numLayers).E = output - netOutput;

% качественная оценка выхода сети
regresError = sum(net.layer(net.numLayers).E .^2) / net.numOutputUnits;
netClasses = classesFromOutputs(netOutput);
classError = sum(netClasses ~= class);

end %of function