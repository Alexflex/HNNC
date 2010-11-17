function [classes, values] = classesFromOutputs(outputs)
% Формирует массив классов принадлежности из набора выходных образцов
%
% classes = classesFromOutputs(outputs)
%
% Arguments
% outputs - выходной вектор сети
%
% classes - класс, к которому сеть отнесла данный элемент
% values  - отклик нейрона-победителя
%
% Example
% outputs = [    1 -1 -1;
%               -1  1 -1;
%               -1 -1  1;
%                1 -1 -1;
%               -1 -1  1];
% classes = classesFromOutputs(outputs);
% classes
% classes = [   1;
%               2; 
%               3;
%               1;
%               3]
%
% See also
% 
% 
% Revisions
% Author: Vulfin Alex, Date: 17/11/2010
% Supervisor: Vulfin Alex, Date: 17/11/2010
% Author: (Next revision author), Date: (Next revision date)

% возвращает наибольшие элементы по столбцам массива
[values, classes] = max(outputs, [], 2);

end %of function