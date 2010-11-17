function y = randinit(a, varargin)
% Инициализация весов случайными числами из диапазона [-a; a]

% y = randinit(a, varargin)

% Arguments 
% a	- правая граница диапазона случайной инициализации
% varargin	- перечисление размерностей инициализируемого массива
%
% y    - массив, инициализированный случайными числами из диапазона
%
% Example
% y = randinit(0.25, 3, 3);
%
% See also
% rand
% 
% Revisions
% Author: Vulfin Alex, Date: 17/11/2010
% Supervisor: Vulfin Alex, Date: 17/11/2010
% Author: (Next revision author), Date: (Next revision date)


if(nargin < 2)
    error('randinit: неверно заданы размеры массива инициализации');
end

y = -a + 2*a*rand(varargin{:});

end %of function