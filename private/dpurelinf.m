function e = dpurelinf(x)
% Производная линейной функции активации 
%
% e = dpurelinf(x)
%
% Arguments
% x	- индуцированное локальное поле нейрона - значение функции активации
% (вектор/матрица)
%
% e	- единичная матрица соответствующего x размера - производная функции
% активации (вектор/матрица)
%
% Example
% e = dpurelinf(x);
%
% See also
% ones
% 
% Revisions
% Author: Vulfin Alex, Date: 17/11/2010
% Supervisor: Vulfin Alex, Date: 17/11/2010
% Author: (Next revision author), Date: (Next revision date)

e = ones(size(x));

end %of function