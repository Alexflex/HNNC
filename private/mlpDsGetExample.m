function [input, output, class] = mlpDsGetExample(dataSet, k, direct)
% mlpDsGetExample - получение k примера из множества примеров
% [input, output, class] = mlpDsGetExample(dataSet, k)
% Вход функции: 
%   dataSet  - структура, описывающая обучающее/тестовое/контрольное мн-во
%   k        - индекс примера
%   direct   - если параметр передан, то доступ прямой, игнорируя массив
%              index
% Выход функции:
%   input  - входной вектор примера
%   output - выходной вектор примера
%   class  - класс, к которому относится пример

% если не передан direct, то непрямой доступ к элементам, через массив
% index
if(nargin < 3)
    input  = dataSet.inputs(dataSet.index(k), :);
    output = dataSet.outputs(dataSet.index(k), :);
    class  = dataSet.classes(dataSet.index(k), :);
else
    input  = dataSet.inputs(k, :);
    output = dataSet.outputs(k, :);
    class  = dataSet.classes(k, :);
end

end %of function