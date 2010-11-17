function printMessage(str, varargin)
% Функция выводит сообщение в поток, определенный глобальным параметром
% flogid
% Входные параметры:
%   str         - строка форматирования
%   varargin    - параметры
% Выходные параметры:  

% глобальный поток вывода, связанный либо с экраном, либо с файлом
global flogid;

fprintf(flogid, str, varargin{:});

end %of function