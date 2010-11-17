function mlpPlot(path, learnInfo, showAfterSave)
% Построение графика процесса обучения и тестирования МСП
%
% mlpPlot(path, learnInfo, showAfterSave)
%
% Arguments
% path - имя файла, в который будет сохранен график
% learnInfo - исходные данные о процессе обучения
% showAfterSave - показывать график после сохранения
%
% Example
% mlpPlot(char(path), learnInfo, true);
%
% See also
% 
%
% Revisions
% Author: Vulfin Alex, Date: 17/11/2010
% Supervisor: Vulfin Alex, Date: 17/11/2010
% Author: (Next revision author), Date: (Next revision date)

% Create figure
fig = figure(   'PaperPosition', [0.6345 6.345 20.3 15.23], ...
                'PaperSize', [20.98 29.68]);

hold on;
plot(learnInfo.training.RE, '-r');
plot(learnInfo.training.CE, ':r');
leg = {'Training Regression'}; 
leg{end + 1} = 'Training Classification';
if (~isempty(learnInfo.validation.RE))
    plot(learnInfo.validation.RE, '-g');
    plot(learnInfo.validation.CE, ':g');
    leg{end + 1} = 'Validation Regression'; 
    leg{end + 1} = 'Validation Classification';
end

if (~isempty(learnInfo.test.RE))
    plot(learnInfo.test.RE, '-b');
    plot(learnInfo.test.CE, ':b');
    leg{end + 1} = 'Test Regression'; 
    leg{end + 1} = 'Test Classification';
end
hold off

title('Error vs. Learning Time');
xlabel('Эпохи');
ylabel('СКО');
legend(leg);  

saveas(fig, path, 'png');

% если флаг показа рисунка сброшен, то закрыть рисунок
if(~showAfterSave)
    close(fig);
end

end % of function