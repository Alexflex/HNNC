function [net, regresError, classError] = mlpEval(net, input, output, class)
% Прямой ход сети, оценка ошибки классификации и кв. ошибки
%
% [net, regresError, classError] = mlpEval(net, input, output, class)
%
% Arguments
% net      - МСП
% input    - входной вектор для примера 
% output   - выходной вектор для примера 
% class    - класс, к которому относится пример
%
% net         - МСП
% regresError - квадратичная ошибка отклика сети
% classError  - ошибка классификации образца
%
% Example
% [net, regresError, classError] = mlpEval(net, input, output, class);
%
% See also
% 
% Revisions
% Author: Vulfin Alex, Date: 17/11/2010
% Supervisor: Vulfin Alex, Date: 17/11/2010
% Author: (Next revision author), Date: (Next revision date)

% оценка выхода сети
[net, netOutput] = mlpFeedforward(net, input);

% задание ошибок нейронов последнего слоя сети
net.layer(net.numLayers).E = output - netOutput;

% качественная оценка выхода сети
regresError = sum(net.layer(net.numLayers).E .^2) / net.numOutputUnits;
netClasses = classesFromOutputs(netOutput);
classError = sum(netClasses ~= class);

end %of function