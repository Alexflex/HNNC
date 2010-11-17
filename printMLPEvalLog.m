function [regresError, classError, numErrors, correct] = printMLPEvalLog(net, ds)
% Функция выводит результаты тестирования МСП на определенном множестве
% примеров
%
% [regresError, classError, numErrors, correct] = printMLPEvalLog(net, ds)
%
% Arguments
% net     - обученный МСП
% ds      - множество примеров
%
% Example
% [regresError, classError, numErrors, correct] = printMLPEvalLog(net, ds);
%
% See also
% 
% Revisions
% Author: Vulfin Alex, Date: 17/11/2010
% Supervisor: Vulfin Alex, Date: 17/11/2010
% Author: (Next revision author), Date: (Next revision date)

[net, regresError, classError] = ...
    mlpEvalSet(net, ds);

correct = 100*(1 - classError);
numErrors = classError*ds.count;
printMessage('\n\t\tregressError = %g', regresError);
printMessage('\n\t\tclassError = %g', classError);
printMessage('\n\t\tnumErrors = %d', numErrors);
printMessage('\n\t\tcorrect = %5.2f%', correct);

end %of function