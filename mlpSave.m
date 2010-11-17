function mlpSave(net, dataFileName)
% Функция сохраняет структуру, описывающую МСП, в файл
%
% mlpSave(net, dataFileName)
%
% Arguments
% net - структура, описывающая сохраняемый МСП
% dataFileName - имя файла пространства 
%
% Example
% mlpSave(net, char(path));
%
% See also
% 
%
% Revisions
% Author: Vulfin Alex, Date: 17/11/2010
% Supervisor: Vulfin Alex, Date: 17/11/2010
% Author: (Next revision author), Date: (Next revision date)

save(dataFileName, 'net');

end %of function