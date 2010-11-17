function createDataSets()
% Функция осуществляет разбор файлов базы данных proben1 из каталога
% ../dataSets/proben1 в каталог preparedDataSets в виде набора множеств 
%
% preprocessProben1()
%
% Arguments
%
% Example
% preprocessProben1();
%
% See also
% 
% Revisions
% Author: Vulfin Alex, Date: 17/11/2010
% Supervisor: Vulfin Alex, Date: 17/11/2010
% Author: (Next revision author), Date: (Next revision date)

clc;

preprocessProben1();
preprocessELENA_Texture();
preprocessVowels();

end % of function