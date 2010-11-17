function net = mlpLoad(dataFileName)
% Функция загружает сохраненную структуру, описывающую МСП, из файла
% Входные параметры:
%   dataFileName - имя файла пространства
% Выходные параметры:
%   net - МСП из файла   

net = load(dataFileName);
net = net.net;

end %of function