function testSubFunctions()
% ������������ ��������������� �������

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

fprintf('\n�������� ������ ��������� �����\n');
disp(matTestArg);

fprintf('\n������� ��������� ��������������� �������\n');
disp(hyptan(matTestArg));
fprintf('\n');
disp(hyptan(matTestArg'));

fprintf('\n������� ��������� ��������\n');
disp(purelinf(matTestArg));
fprintf('\n');
disp(purelinf(matTestArg'));

fprintf('\n����������� ������� ��������� ��������������� �������\n');
disp(dhyptan(matTestArg));
fprintf('\n');
disp(dhyptan(matTestArg'));

fprintf('\n����������� ������� ��������� ��������\n');
disp(dpurelinf(matTestArg));
fprintf('\n');
disp(dpurelinf(matTestArg'));

end %of function