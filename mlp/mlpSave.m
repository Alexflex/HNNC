function mlpSave(net, dataFileName)
% Функция сохраняет структуру, описывающую МСП, в файл
% Входные параметры:
%   net - структура, описывающая сохраняемый МСП
%   dataFileName - имя файла пространства
% Выходные параметры:
%   net - МСП   

save(dataFileName, 'net');

end %of function