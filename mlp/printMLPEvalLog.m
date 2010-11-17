function [regresError, classError, numErrors, correct] = printMLPEvalLog(net, ds)
% ������� ������� ���������� ������������ ��� �� ������������ ���������
% ��������
% ������� ���������:
%   net     - ��������� ���
%   ds      - ��������� ��������
% �������� ���������:  

[net, regresError, classError] = ...
    mlpEvalSet(net, ds);

correct = 100*(1 - classError);
numErrors = classError*ds.count;
printMessage(sprintf('\n\tregressError = %g', regresError), 2);
printMessage(sprintf('\n\tclassError = %g', classError), 2);
printMessage(sprintf('\n\tnumErrors = %d', numErrors), 2);
printMessage(sprintf('\n\tcorrect = %5.2f%', correct), 2);

end %of function