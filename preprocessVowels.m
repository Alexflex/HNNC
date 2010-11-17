function preprocessVowels()
% Функция осуществляет разбор файлов базы данных VOWEL из каталога
% Vowels в каталог testExamples в виде набора множеств для ИНС 

clc;

% список имен файлов, содержащих исходные данные для наборов множеств ИНС
filename1 = '../dataSets/vowel/vowel.train';
filename2 = '../dataSets/vowel/vowel.test';

% наборы данных для обучения и тестирования ИНС
preprocessed_name = 'vowels';

timeStart = cputime;
fprintf('\nНачало обработки базы VOWEL...');

fid1 = fopen(filename1, 'r');
fid2 = fopen(filename2, 'r');
if((fid1 ~= -1) && (fid2 ~= -1))
    
    numInputs = 10;
    numOutputs = 11;
       
    data1 = csvread(filename1, 1, 0);
    data2 = csvread(filename2, 1, 0);
    
    % перемещение признака класса в последний столбец
    data1 = [data1(:, 3:end), data1(:, 2)];
    data2 = [data2(:, 3:end), data2(:, 2)];
 
    % перемешивание исходного массива данных
    data1 = data1(randperm(size(data1, 1)), :);
    data2 = data2(randperm(size(data2, 1)), :);
    
    % нормализация входных данных
    data1(:, 1:numInputs) = mapstd(data1(:, 1:numInputs)')';
    data2(:, 1:numInputs) = mapstd(data2(:, 1:numInputs)')';
         
    hasTraining = true;
	training.count = 528;
    training.id = 1:training.count;
    training.index = randperm(training.count);
    training.inputs = data1(1:training.count, 1:numInputs);
    training.classes = data1(1:training.count, (numInputs + 1):end);
    training.sourceClasses = training.classes;
    training.outputs = outputsFromClasses(training.classes, numOutputs);
    
    hasValidation = false;
    validation.count = 0;
    
    hasTest = true;
    test.count = 462;
    test.id = 1:test.count;
    test.index = randperm(test.count);
    test.inputs = data2(1:test.count, 1:numInputs);
    test.classes = data2(1:test.count, (numInputs + 1):end);
    test.sourceClasses = test.classes;
    test.outputs = outputsFromClasses(test.classes, numOutputs);
    
    save(char(strcat('./preparedDataSets/', preprocessed_name)), ...
            'training', ...
            'validation', ...
            'test', 'numInputs', 'numOutputs', ...
            'hasTraining', 'hasValidation', 'hasTest');
else
	fprintf('preprocessVowels: Не могу открыть файл %s %s', fid1, fid2);
end

fprintf('\nОбработка базы Vowels завершена за %8.3f с\n', ...
            cputime - timeStart);

end % of function    
