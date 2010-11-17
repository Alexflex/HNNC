function [net, errors] = mlpTrain(net, dataSets)
% mlpTrain - �������� ���
% [net, errors] = mlpTrain(net, dataSets)
% ���� �������: 
%   net      - ���
%   dataSet  - ���������, ����������� ���������/��������/����������� ��-��
% ����� �������:
%   net      - ��������� ���
%   errors   - ���������, ����������� ������� �������� ���

% ������������� ��������
k = 1;                                  % ������� ���� ��������
alldone = false;                        % ���� ���������� ��������
tic;                                    % ������ ������ ��������

% ���������� �������� ��������
errors.test.RE = [];
errors.test.CE = [];
errors.test.NE = [];
errors.test.CR = [];
errors.training.RE = [];
errors.training.CE = [];
errors.training.NE = [];
errors.training.CR = [];
errors.validation.RE = [];
errors.validation.CE = [];
errors.validation.NE = [];
errors.validation.CR = [];

% ������������� �������� � ������ �������� ���������
if(dataSets.hasValidation)
    dataSets.validation.index = randperm(dataSets.validation.count);
end   

if(dataSets.hasTest)
    dataSets.test.index = randperm(dataSets.test.count);
end 

dataSets.training.index = randperm(dataSets.training.count);

% ========================================================================
% ���� �� ������ ��������
% ========================================================================
while ~alldone  

    % ������������� �������� � ������ �������� ���������
    if(dataSets.hasValidation && mod(k, net.countShuffleSet) == 0)
        dataSets.validation.index = randperm(dataSets.validation.count);
    end   
    
    if(dataSets.hasTest && mod(k, net.countShuffleSet) == 0)
        dataSets.test.index = randperm(dataSets.test.count);
    end 

    if(mod(k, net.countShuffleSet) == 0)
        dataSets.training.index = randperm(dataSets.training.count);
    end
    
    % ���� �� ��������� ��������
    for p = 1:dataSets.training.count
        
        % �������� ������ �� ���������� ���������
        [input, output, class] = mlpDsGetExample(dataSets.training, p);
        
        % ������ ������ � ������ �������� ��� ���������� ����
        net = mlpEval(net, input, output, class);
        
        % �������� ������: ������ ��������� ����������
        net = mlpCalcLocalG(net, input);
        
        % �������� ������ - ������������� �����
        net = mlpCorrectWeights(net);
    end
    
    % ������ ����� ��������� �� �����
    dnorm = mlpEstimateG(net);
    
    % ������ ������� ���� ����� ������ ����� ������������� ����� ��
    % ��������� ���������
    [net, errors.training.RE(k), errors.training.CE(k), ...
          errors.training.NE(k), errors.training.CR(k)] = ...
                                    mlpEvalSet(net, dataSets.training);
    
    % ������ ������� ���� ����� ������ ����� ������������� ����� ��
    % �������� ���������
    if(dataSets.hasTest)
        [net, errors.test.RE(k), errors.test.CE(k), ...
              errors.test.NE(k), errors.test.CR(k)] = ...
                                    mlpEvalSet(net, dataSets.test);
    end
    
    % ������ ������� ���� ����� ������ ����� ������������� ����� ��
    % ����������� ���������
    if(dataSets.hasValidation)
        [net, errors.validation.RE(k), errors.validation.CE(k), ...
              errors.validation.NE(k), errors.validation.CR(k)] = ...
                                    mlpEvalSet(net, dataSets.validation);
    end   
    
    % ����� ���� �������� ���� � ���������� ����� ����
    if(mod(k, net.printLog) == 0)          
        printMessage('\n\t\tEpochs: %g', k);       
        printMessage('\n\t\t\tTraining:\tre(ce) = %-10g (%-10g) | numErrors = %-5g | correct = %-5.2f', ...
                    errors.training.RE(k), errors.training.CE(k), ...
                    errors.training.NE(k), errors.training.CR(k));
               
        if(dataSets.hasTest)
            printMessage('\n\t\t\tTest:\t\tre(ce) = %-10g (%-10g) | numErrors = %-5g | correct = %-5.2f', ...
                        errors.test.RE(k), errors.test.CE(k), ...
                        errors.test.NE(k), errors.test.CR(k));
        end

        if(dataSets.hasValidation)
            printMessage('\n\t\t\tValidation:\tre(ce) = %-10g (%-10g) | numErrors = %-5g | correct = %-5.2f', ...
                        errors.validation.RE(k), errors.validation.CE(k), ...
                        errors.validation.NE(k), errors.validation.CR(k));
        end  
    end
        
    % ������� ���������� ������ �� ����� �� ���������� ������ �� 
    % ����������� ���������.
    % ���������� �������� ������������� ��������� net.numEstimatedEpoch 
    % �������� ������ �� ����������� ��������� 
    if(dataSets.hasValidation && k > net.numEstimatedEpoch)
        x = k - net.numEstimatedEpoch:1:k;
        y = errors.validation.RE(k - net.numEstimatedEpoch:k);
        pol = polyfit(x, y, 1);
       
        % ������ ������, ���������������� ��������� lenEstimatedEpoch ����� 
        if(pol(1) > 0)
            net.countValidationFail = net.countValidationFail + 1;
            
        % ���� ����������� ������ �� �������� ���������, �� ��������
        % ������� ������. ���� �� ������ ���� ������, �� �� ����������
        % ������ maxValidationFail �������� �����������
        elseif  ((pol(1) < 0) && ...            
                 (net.countValidationFail > 0))
            net.countValidationFail = 0;
            printMessage('\n\t\t������� ������� �������� �� ����������� ���������');
        end
    end

    % �������� ��������� �������� �������� ��������
    if(k > net.numEpoch)
        alldone = true;
        printMessage('\n\t\t���������� ������������ ���������� ����');
    end
    
    if(dnorm < net.minGradValue)
        alldone = true;
        printMessage('\n\t\t���������� ����������� �������� ���������');
    end
    
    if(net.countValidationFail > net.maxValidationFail)
        alldone = true;
        printMessage('\n\t\t������ ������� �� ����������� ���������');
    end
    
    if(dataSets.hasValidation && ...
       errors.validation.RE(k) < net.validationStopThreshold)
        alldone = true;
        printMessage('\n\t\t���������� ����������� �������� �� ����������� ���������');
    end
    
    if(errors.training.RE(k) < net.goal)
        alldone = true;
        printMessage('\n\t\t���������� ����������� �������� ������� ������� �� ��������� ���������');
    end
    
    % ���������� ������� ����
    k = k + 1;
end
% ========================================================================

% ������ ������� ���� ����� ��������
[net, errors.training.regression, errors.training.classification, ...
	errors.training.numErrors, errors.training.correct] = ...
    mlpEvalSet(net, dataSets.training);

if(dataSets.hasValidation)
    [net, errors.validation.regression, errors.validation.classification, ...
	errors.validation.numErrors, errors.validation.correct] = ...
    mlpEvalSet(net, dataSets.validation);
end

if(dataSets.hasTest)
    [net, errors.test.regression, errors.test.classification, ...
	errors.test.numErrors, errors.test.correct] = ...
	mlpEvalSet(net, dataSets.test);
end

% ����� ������������ �������� �������� � ������ �� ����������
printMessage('\n\tTraining completed: %g s', toc);

printMessage('\n\tTraining:\tre(ce) = %-10g (%-10g) | numErrors = %-5g | correct = %-5.2f', ...
	errors.training.regression, errors.training.classification, ...
	errors.training.numErrors, errors.training.correct);

if(dataSets.hasValidation)
    printMessage('\n\tValidation:\tre(ce) = %-10g (%-10g) | numErrors = %-5g | correct = %-5.2f', ...
        errors.validation.regression, errors.validation.classification, ...
        errors.validation.numErrors, errors.validation.correct);
end

if(dataSets.hasTest)
    printMessage('\n\tTest:\t\tre(ce) = %-10g (%-10g) | numErrors = %-5g | correct = %-5.2f', ...
        errors.test.regression, errors.test.classification, ...
        errors.test.numErrors, errors.test.correct);
end

end % of function