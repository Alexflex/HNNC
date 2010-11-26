function preprocessXOR()
% ������� ������� ��������� ��������� ��� ������ n-������� XOR 
%
% preprocessXOR()
%
% Arguments
%
% Example
% preprocessXOR();
%
% See also
% 
% Revisions
% Author: Vulfin Alex, Date: 25/11/2010
% Supervisor: Vulfin Alex, Date: 25/11/2010
% Author: (Next revision author), Date: (Next revision date)

% ������ ������ ��� �������� � ������������ ���
preprocessedName = 'nxor';

tic;
fprintf('\n������ ��������� ���� nXOR...');
    
numInputs = 2;
numOutputs = 1;

hasTraining = true;
training.count = 4;
training.id = 1:training.count;
training.index = randperm(training.count);
training.inputs = [-1 -1; -1 1; 1 -1; 1 1];
training.outputs = [-1; 1; 1; -1];
training.classes = classesFromOutputs(training.outputs);
training.sourceClasses = training.classes;

hasValidation = false;
validation.count = 0;

hasTest = false;
test.count = 0;

save(char(strcat('./preparedDataSets/', preprocessedName)), ...
        'training', ...
        'validation', ...
        'test', 'numInputs', 'numOutputs', ...
        'hasTraining', 'hasValidation', 'hasTest');

fprintf('\n��������� ���� nXOR ��������� �� %8.3f �\n', toc);

end % of function    
