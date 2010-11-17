function d = dhyptan(y)
% Производная функции активации вида масштабированный 
% гип. тангенс (особенностью является то, что atansigb(+-1) = +-1)
% для вычисления значения производной используется рассчитанное ранее
% значение функции активации hyptan(x)
%
% d = dhyptan(y) 
%
% Arguments
% y    - значение функции активации (вектор/матрица)
%
% d    - производная функции активации (вектор/матрица)
%
% Example
% d = dhyptan(10);
%
% See also
% tanh
% Саймон Хайкин Нейронные сети: полный курс = 
% Neural Networks: A Comprehensive Foundation. — 2-е. — 
% М.: «Вильямс», 2006. — С. 1104. — ISBN 0-13-273350-1
% 
% Revisions
% Author: Vulfin Alex, Date: 17/11/2010
% Supervisor: Vulfin Alex, Date: 17/11/2010
% Author: (Next revision author), Date: (Next revision date)

a = 1.7159;
b = 2/3;
d = b/a .* (a - y) .* (a + y);

end %of function