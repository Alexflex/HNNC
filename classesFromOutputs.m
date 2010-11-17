function [classes, values] = classesFromOutputs(outputs)
% Формирует массив классов принадлежности из набора выходных образцов
% classes = classesFromOutputs(outputs)
% Входные параметры: 
%   outputs - выходной вектор сети
% Выходные параметры:
%   classes - класс, к которому сеть отнесла данный элемент
%   values  - отклик нейрона-победителя
%
% Например, данная матрица outputs будет перекодирована в вектор classes
% outputs:
%  1 -1 -1
% -1  1 -1
% -1 -1  1
%  1 -1 -1
% -1 -1  1
% 
% в classes:
%
% 1
% 2 
% 3 
% 1
% 3

% возвращает наибольшие элементы по столбцам массива
[values, classes] = max(outputs, [], 2);

end %of function