function testSubFunctions()
% Тестирование вспомогательных функций

% res = testSubFunctions()

% Arguments 
%
% Example
% testSubFunctions();
%
% See also
% 
% Revisions
% Author: Vulfin Alex, Date: 17/11/2010
% Supervisor: Vulfin Alex, Date: 17/11/2010
% Author: (Next revision author), Date: (Next revision date)

sizeRows = 3;
sizeCols = 5;
matTestArg = randinit(1, sizeRows, sizeCols);

fprintf('\nИсходный массив случайных чисел\n');
disp(matTestArg);

fprintf('\nФункция активации Гиперболический тангенс\n');
disp(hyptan(matTestArg));
fprintf('\n');
disp(hyptan(matTestArg'));

fprintf('\nФункция активации линейная\n');
disp(purelinf(matTestArg));
fprintf('\n');
disp(purelinf(matTestArg'));

fprintf('\nПроизводная функции активации Гиперболический тангенс\n');
disp(dhyptan(matTestArg));
fprintf('\n');
disp(dhyptan(matTestArg'));

fprintf('\nПроизводная функции активации линейная\n');
disp(dpurelinf(matTestArg));
fprintf('\n');
disp(dpurelinf(matTestArg'));

fprintf('\nПриведение произвольного массива к нулевому среднему и ед СКО\n');
matTestArg = [  1 2 3 4 5 6 7 8 9 10; ...
                1 2 3 4 5 6 7 8 9 10; ...
                1 2 3 4 5 6 7 8 9 10];
            
matTestArg = matTestArg(randperm(size(matTestArg, 1)), :);
disp(matTestArg);

classes = unique(matTestArg(:, (9 + 1):end));   
disp(classes);

disp(mapstd(matTestArg));

end %of function