function preprocessELENA_Texture()
% ������� ������������ ������ ������ ���� ������ ELENA �� ��������
% ELENA � ������� testExamples � ���� ������ �������� ��� ��� 
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

% ������ ���� ������, ���������� �������� ������ ��� ������� �������� ���
filename = './dataSets/ELENA/texture_CR.dat';

% ������ ������ ��� �������� � ������������ ���
preprocessedName = 'textureCR';

tic;
fprintf('\n������ ��������� ���� ELENA...');

fid = fopen(filename, 'r');
if fid ~= -1
    
    numInputs = 40;
    numOutputs = 11;
    data = fscanf(fid, '%g', [41, 5500]);
 
    % ������������� ��������� ������� ������
    data = data(:, randperm(size(data, 2)))';
    
    % ������������ ������� ������
    data(:, 1:numInputs) = mapstd(data(:, 1:numInputs)')';
    
    % �������������� �������� ������ - ������ � ������ ���� 1:numOutputs
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
	error('\npreprocessELENA_Texture: �� ���� ������� ���� %s', filename);
end

fprintf('\n��������� ���� ELENA ��������� �� %8.3f �', toc);

end % of function    
