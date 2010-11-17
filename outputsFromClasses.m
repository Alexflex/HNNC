function outputs = outputsFromClasses(classes, numOutputUnits)
% ‘ормирует набор выходных образцов из массива классов принадлежности
% outputs = outputsFromClasses(classes)
% ¬ходные параметры: 
%   outputs - класс, к которому сеть отнесла данный элемент
% ¬ыходные параметры:
%   classes - выходной вектор сети
%
% Ќапример, данный вектор classes будет перекодирован в матрицу outputs
% classes:
%
% 1
% 2 
% 3 
% 1
% 3
%
% в outputs:
%
%  1 -1 -1
% -1  1 -1
% -1 -1  1
%  1 -1 -1
% -1 -1  1

sampleCount = length(classes);

outputs = -ones(sampleCount, numOutputUnits);

for k = 1:sampleCount
    outputs(k, classes(k)) = 1;
end

end % of function