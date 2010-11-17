function [input, output, class] = mlpDsGetExample(dataSet, k, takeDirect)
% Функция получения k примера из множества примеров
%
% [input, output, class] = mlpDsGetExample(dataSet, k, takeDirect);
%
% Arguments
% dataSet - структура, описывающая обучающее/тестовое/контрольное мн-во
% k - индекс примера
% takeDirect - если параметр передан, то доступ прямой, игнорируя массив index
%
% input  - входной вектор примера
% output - выходной вектор примера
% class  - класс, к которому относится пример
%
% Example
% [input, output, class] = mlpDsGetExample(dataSet, k, true);
%
% See also
% 
% Revisions
% Author: Vulfin Alex, Date: 17/11/2010
% Supervisor: Vulfin Alex, Date: 17/11/2010
% Author: (Next revision author), Date: (Next revision date)

% если не передан direct, то непрямой доступ к элементам, через массив
% index
if(~takeDirect)
    input  = dataSet.inputs(dataSet.index(k), :);
    output = dataSet.outputs(dataSet.index(k), :);
    class  = dataSet.classes(dataSet.index(k), :);
else
    input  = dataSet.inputs(k, :);
    output = dataSet.outputs(k, :);
    class  = dataSet.classes(k, :);
end

end %of function