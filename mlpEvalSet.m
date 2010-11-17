function [net, regresError, classError, numErrors, correct] = ...
    mlpEvalSet(net, dataSet)
% mlpEvalSet - прямой ход сети и оценка ошибки классификации и кв. ошибки
% [net, regresError, classError, numErrors, correct] = mlpEvalSet(net, dataSet)
% Вход функции: 
%   net      - МСП
%   dataSet  - структура, описывающая обучающее/тестовое/контрольное мн-во
% Выход функции:
%   net         - МСП
%   regresError - среднеквадратичная ошибка отклика сети
%   classError  - средняя ошибка классификации образца
%   numErrors   - количество ошибочно классифицированных примеров
%   correct     - процент корректно классифицированных примеров

% цикл по примерам данного множества
CE = zeros(1, dataSet.count); 
RE = zeros(1, dataSet.count);

for k = 1:dataSet.count
    [input, output, class] = mlpDsGetExample(dataSet, k, true);
    [net, RE(k), CE(k)] = mlpEval(net, input, output, class);
end

% расчет средних значений параметров для целого множества примеров
classError = sum(CE)/dataSet.count;
regresError = sum(RE)/dataSet.count;

correct = 100*(1 - classError);
numErrors = classError*dataSet.count;

end %of function