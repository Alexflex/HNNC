function net = mlpCalcLocalG(net, input)
% ������� ������������ ��������� ���������
%
% net = mlpCalcLocalG(net, input)
%
% Arguments
% net - ���
% input - ������� ������ 
%
% net - ��� c ������������� ���������� ����������� ��� ���� ��������
%
% Example
% net = mlpCalcLocalG(net, input);
%
% See also
% 
% Revisions
% Author: Vulfin Alex, Date: 17/11/2010
% Supervisor: Vulfin Alex, Date: 17/11/2010
% Author: (Next revision author), Date: (Next revision date)

% �������� ������: ������ ��������� ����������
% - ��� �������� ��������� ����
net.layer(net.numLayers).G = net.layer(net.numLayers).E .* ...
        feval(net.layer(net.numLayers).df, net.layer(net.numLayers).Y);
        
% - ��� �������� ������� �����
for k = net.numLayers - 1:-1:1
    net.layer(k).E = net.layer(k + 1).G * net.layer(k + 1).W(2:end, :)';
    net.layer(k).G = net.layer(k).E .* ...
                           feval(net.layer(k).df, net.layer(k).Y);
end

% ������ ��������� ���������� dE/dW
net.layer(1).gW = [1 input]' * net.layer(1).G;
for k = 2:net.numLayers
    net.layer(k).gW = [1 net.layer(k - 1).Y]' * net.layer(k).G;
end

end %of functkon