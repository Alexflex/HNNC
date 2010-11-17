function testClassificationTask()
% ������� ������������ ������������ ��� �� ���� ������  �� ��������
% preparedDataSets �� ������� ����� �������������. ���������� ������ 
% ��������� � ��������������� ���� �������� testClassificationTask

clc;
clear all;

global flogid;
flogid = 1;

% ������ ���� ������, ���������� �������� ������ ��� ������� �������� ���
filenames = {...   
        'cancer1'%,...
%         'cancer2',...
%         'cancer3',...
%         'card1',...
%         'card2',...
%         'card3',...
%         'diabetes1',...
%         'diabetes2',...
%         'diabetes3',...
%         'gene1',...
%         'gene2',...
%         'gene3',...
%         'glass1',...
%         'glass2',...
%         'glass3',...
%         'horse1',...  
%         'horse2',...  
%         'horse3',...  
%         'mushroom1',...
%         'mushroom2',...
%         'mushroom3',...        
%         'soybean1',...
%         'soybean2',...
%         'soybean3',...        
%         'thyroid1',...
%         'thyroid2',...
%         'thyroid3', ...
%         'textureCR', ...
%         'vowels', ...
%         'covtype'
    };

timeStart = cputime;
fprintf('\n������ ��������� ���� �������� �����...');

for k = 1:length(filenames)  
    clc;
    fprintf('\n\t�������������� %s', char(filenames(k)));        
    
    % �������� ���������������� ������ ������
    ds = loadDataSets(char(filenames(k)));
    
    % �������� ��� �������� �����������
    net = mlpCreate([ds.numInputs, 10, 8, ds.numOutputs], ...
                    {'tansig'; 'tansig'; 'tansig'});

    % �������� ����
    [net, errors] = mlpTrain(net, ds);  
    
    % ���������� ��������� ���� � ����
    path = strcat('./learnedTasks/', filenames(k), '_mlp');
    mlpSave(net, char(path));
    
    % ���������� ������� �������� � ����
    path = strcat('./learnedTasks/', filenames(k), '_log');
    mlpPlot(char(path), errors);
    
    % ���������� ���� �������� � ����
    path = strcat('./learnedTasks/', filenames(k), '_errors');
    save(char(path), 'errors');
    
    % �������� ���������� ��������� ��� netff
    p = ds.training.inputs;
    t = ds.training.outputs;
    if(ds.hasTest > 0)
        p = [p; ds.test.inputs];
        t = [t; ds.test.outputs];
    end
    if(ds.hasValidation > 0)
        p = [p; ds.validation.inputs];
        t = [t; ds.validation.outputs];
    end
    
    % �������� ������� �����
    netm = newff(p', t', [ds.numInputs, 10, 8], {}, 'trainrp');
    [netm, tr] = train(netm, p', t');
    plotperform(tr);
    h = gcf;
    
    ytst = sim(netm, p');
    etst = t' - ytst;
    MSEtst = mse(etst);
    mclasses = classesFromOutputs(ytst');
    classErrorSet = sum(mclasses ~= ds.training.classes);
    classError = classErrorSet/ds.training.count;
    correct = 100*(1 - classError);
    numErrors = classError*ds.training.count;
    printMessage('���������� ������������ MATLAB ��� �� ��������� ���������');
    printMessage(sprintf('regressError = %g', MSEtst));
    printMessage(sprintf('classError = %g', classError));
    printMessage(sprintf('numErrors = %d', numErrors));
    printMessage(sprintf('correct = %5.2f%', correct));
    
    % ���������� ���� �������� � ����
    path = strcat('./learnedTasks/', filenames(k), '_errors_matlab_mlp');
    saveas(h, char(path), 'png');
    close(h);
    
    pause(1);
end

fprintf('\n��������� ���� ���������. %d ����� �� %8.3f �\n', ...
            length(filenames), ...
            (cputime - timeStart)/60);
end % of function    