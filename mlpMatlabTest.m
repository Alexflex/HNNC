function mlpMatlabTest(ds, path, varargin)
% ������� ������� ��� ����������� ���������� Matlab � ������������
% ������������ �� ��������� ������ ������
%
% mlpMatlabTest(ds, varargin)
%
% Arguments
% ds          - ��������� ��������
% path        - ���� ��� ���������� ���� ��������
% varargin    - ��������� ������������ ����
%
% Example
% mlpMatlabTest(ds, ds.numInputs, 8, 10);
%
% See also
% 
% Revisions
% Author: Vulfin Alex, Date: 25/11/2010
% Supervisor: Vulfin Alex, Date: 25/11/2010
% Author: (Next revision author), Date: (Next revision date)

% ���������� ����� ������, ��������� ���� � �������, ���� � ������
% global flogid;

% �������� ���������� ��������� ��� netff �� ���������
p = ds.training.inputs;
t = ds.training.outputs;
trainInd = 1:ds.training.count;
if(ds.hasTest)
    p = [p; ds.test.inputs];
    t = [t; ds.test.outputs];
    
    testInd  = ds.training.count + 1:ds.training.count + ds.test.count;
end
if(ds.hasValidation)
    p = [p; ds.validation.inputs];
    t = [t; ds.validation.outputs];
    
    valInd   = ds.training.count + ds.test.count + 1:...
               ds.training.count + ds.test.count + ds.validation.count;
end

% �������� ��� �������� �����������
% netm = newff(p', t', [varargin{:}], {}, 'traingdm');
netm = newff(p', t', [varargin{:}], {}, 'trainrp');

% ������� ���������� �������� - ���������� ��� �������� ������ N ����
netm.trainParam.show = 25;
netm.trainParam.showCommandLine = false;
netm.trainParam.goal = 1e-5;
netm.trainParam.epochs = 1000;
netm.trainParam.max_fail = 10;

% �� ���������� ���������� ������
netm.trainParam.showWindow = 0;  

% ���������� �������� �� ���������, ����������� � �������� ���������
netm.divideFcn = 'divideind';
netm.divideParam.trainInd = trainInd;
if(ds.hasValidation)
    netm.divideParam.valInd   = valInd;
end
if(ds.hasTest)
    netm.divideParam.testInd  = testInd;
end

% �������� ����
[netm, tr] = train(netm, p', t');

% ���������� ������� ��������
plotperform(tr);
h = gcf;

p = [ds.training.inputs];
t = [ds.training.outputs];
ytst = sim(netm, p');
etst = t' - ytst;
MSEtst = mse(etst);
mclasses = classesFromOutputs(ytst');
classErrorSet = sum(mclasses ~= ds.training.classes);
classError = classErrorSet/ds.training.count;
correct = 100*(1 - classError);
numErrors = classError*ds.training.count;
printMessage('\n\t���������� ������������ MATLAB ��� �� ��������� ���������');
printMessage('\n\t\tregressError = %g', MSEtst);
printMessage('\n\t\tclassError = %g', classError);
printMessage('\n\t\tnumErrors = %d', numErrors);
printMessage('\n\t\tcorrect = %5.2f%', correct);

% Obtaining the test MSE
if(ds.hasTest)
    p = [ds.test.inputs];
    t = [ds.test.outputs];
    ytst = sim(netm, p');
    etst = t' - ytst;
    MSEtst = mse(etst);
    mclasses = classesFromOutputs(ytst');
    classErrorSet = sum(mclasses ~= ds.test.classes);
    classError = classErrorSet/ds.test.count;
    correct = 100*(1 - classError);
    numErrors = classError*ds.test.count;
    printMessage('\n\t���������� ������������ MATLAB ��� �� �������� ���������');
    printMessage('\n\t\tregressError = %g', MSEtst);
    printMessage('\n\t\tclassError = %g', classError);
    printMessage('\n\t\tnumErrors = %d', numErrors);
    printMessage('\n\t\tcorrect = %5.2f%', correct);
end

% Obtaining the validation MSE
if(ds.hasValidation)
    p = [ds.validation.inputs];
    t = [ds.validation.outputs];
    ytst = sim(netm, p');
    etst = t' - ytst;
    MSEtst = mse(etst);
    mclasses = classesFromOutputs(ytst');
    classErrorSet = sum(mclasses ~= ds.validation.classes);
    classError = classErrorSet/ds.validation.count;
    correct = 100*(1 - classError);
    numErrors = classError*ds.validation.count;
    printMessage('\n\t���������� ������������ MATLAB ��� �� ����������� ���������');
    printMessage('\n\t\tregressError = %g', MSEtst);
    printMessage('\n\t\tclassError = %g', classError);
    printMessage('\n\t\tnumErrors = %d', numErrors);
    printMessage('\n\t\tcorrect = %5.2f%', correct);
end

saveas(h, char(path), 'png');

pause(1);
close(h);

end %of function