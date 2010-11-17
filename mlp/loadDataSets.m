function dataSets = loadDataSets(dataSetsName)
% Функция загружает обучающее множество из сохраненного пространства
% dataSets = loadDataSets(dataSetsName)
% Входные параметры:
%   dataSetsName - имя пространства
% Выходные параметры:
%   dataSets - обучающее множество для ИНС   

dataSets = load(strcat('./preparedDataSets/', dataSetsName));

end %of function