function net = mlpLoad(dataFileName)
% Функция загружает сохраненную структуру, описывающую МСП, из файла
%
% net = mlpLoad(dataFileName)
%
% Arguments
% dataFileName - имя файла пространства
%
% net - МСП из файла
%
% Example
% net = mlpLoad(char(path));
%
% See also
% 
%
% Revisions
% Author: Vulfin Alex, Date: 17/11/2010
% Supervisor: Vulfin Alex, Date: 17/11/2010
% Author: (Next revision author), Date: (Next revision date)

net = load(dataFileName);
net = net.net;

end %of function