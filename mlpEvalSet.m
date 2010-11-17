function [net, regresError, classError, numErrors, correct] = ...
    mlpEvalSet(net, dataSet)
% Прямой ход сети и оценка ошибки классификации и кв. ошибки
%
% [net, regresError, classError, numErrors, correct] = mlpEvalSet(net,
% dataSet)
%
% Arguments
% net      - МСП
% dataSet  - структура, описывающая обучающее/тестовое/контрольное мн-во
%
% net         - МСП
% regresError - среднеквадратичная ошибка отклика сети
% classError  - средняя ошибка классификации образца
% numErrors   - количество ошибочно классифицированных примеров
% correct     - процент корректно классифицированных примеров 
%
% Example
% [net, regresError, classError, numErrors, correct] = mlpEvalSet(net,
% dataSet);
%
% See also
% 
% Revisions
% Author: Vulfin Alex, Date: 17/11/2010
% Supervisor: Vulfin Alex, Date: 17/11/2010
% Author: (Next revision author), Date: (Next revision date)

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