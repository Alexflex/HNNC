function dataSets = loadDataSets(dataSetsName)
% Функция загружает обучающее множество из сохраненного пространства
%
% dataSets = loadDataSets(dataSetsName)
%
% Arguments
% dataSetsName - имя пространства
%
% dataSets - обучающее множество
%
% Example
% ds = loadDataSets(filenames);
%
% See also
% 
% 
% Revisions
% Author: Vulfin Alex, Date: 17/11/2010
% Supervisor: Vulfin Alex, Date: 17/11/2010
% Author: (Next revision author), Date: (Next revision date)

dataSets = load(strcat('./preparedDataSets/', dataSetsName));

end %of function