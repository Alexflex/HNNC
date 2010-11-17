function printMessage(str, varargin)
% Функция выводит сообщение в поток, определенный глобальным параметром
% flogid
%
% printMessage(str, varargin)
%
% Arguments
% str         - строка форматирования
% varargin    - параметры 
%
% Example
% printMessage('\n\t%d', 5);
%
% See also
% 
% Revisions
% Author: Vulfin Alex, Date: 17/11/2010
% Supervisor: Vulfin Alex, Date: 17/11/2010
% Author: (Next revision author), Date: (Next revision date)

% глобальный поток вывода, связанный либо с экраном, либо с файлом
global flogid;

fprintf(flogid, str, varargin{:});

end %of function