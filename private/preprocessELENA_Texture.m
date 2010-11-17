function preprocessELENA_Texture()
% Функция осуществляет разбор файлов базы данных ELENA из каталога
% ELENA в каталог testExamples в виде набора множеств для ИНС 
%
% preprocessELENA_Texture()
%
% Arguments
%
% Example
% preprocessELENA_Texture();
%
% See also
% 
% Revisions
% Author: Vulfin Alex, Date: 17/11/2010
% Supervisor: Vulfin Alex, Date: 17/11/2010
% Author: (Next revision author), Date: (Next revision date)

% список имен файлов, содержащих исходные данные для наборов множеств ИНС
filename = './dataSets/ELENA/texture_CR.dat';

% наборы данных для обучения и тестирования ИНС
preprocessedName = 'textureCR';

tic;
fprintf('\nНачало обработки базы ELENA...');

fid = fopen(filename, 'r');
if fid ~= -1
    
    numInputs = 40;
    numOutputs = 11;
    data = fscanf(fid, '%g', [41, 5500]);
 
    % перемешивание исходного массива данных
    data = data(:, randperm(size(data, 2)))';
    
    % нормализация входных данных
    data(:, 1:numInputs) = mapstd(data(:, 1:numInputs)')';
    
    % преобразование выходных данных - разбор в классы вида 1:numOutputs
    classes = unique(data(:, (numInputs + 1):end));   
    for k = 1:length(classes)
        data(data(:, (numInputs + 1):end) == classes(k), ...
            (numInputs + 1):end) = k;
    end
          
    hasTraining = true;
	training.count = 2700;
    training.id = 1:training.count;
    training.index = randperm(training.count);
    training.inputs = data(1:training.count, 1:numInputs);
    training.classes = data(1:training.count, (numInputs + 1):end);
    training.sourceClasses = training.classes;
    training.outputs = outputsFromClasses(training.classes, numOutputs);
    
    hasValidation = true;
    data(1:training.count, :) = [ ];
    validation.count = 100;
    validation.id = 1:validation.count;
    validation.index = randperm(validation.count);
    validation.inputs = data(1:validation.count, 1:numInputs);
    validation.classes = data(1:validation.count, (numInputs + 1):end);
    validation.sourceClasses = validation.classes;
    validation.outputs = outputsFromClasses(validation.classes, numOutputs);
    
    hasTest = true;
    data(1:validation.count, :) = [ ];
    test.count = 2700;
    test.id = 1:test.count;
    test.index = randperm(test.count);
    test.inputs = data(1:test.count, 1:numInputs);
    test.classes = data(1:test.count, (numInputs + 1):end);
    test.sourceClasses = test.classes;
    test.outputs = outputsFromClasses(test.classes, numOutputs);
    
    save(char(strcat('./preparedDataSets/', preprocessedName)), ...
            'training', ...
            'validation', ...
            'test', ...
            'numInputs', 'numOutputs', ...
            'hasTraining', 'hasValidation', 'hasTest');
else
	error('\npreprocessELENA_Texture: Не могу открыть файл %s', filename);
end

fprintf('\nОбработка базы ELENA завершена за %8.3f с', toc);

end % of function    
