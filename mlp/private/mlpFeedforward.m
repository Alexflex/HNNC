function [net, output] = mlpFeedforward(net, input)
% mlpFeedforward - прямой ход сети
% [net, output] = mlpFeedforward(net, input)
% Вход функции: 
%   net    - МСП
%   input  - входной вектор
% Выход функции:
%   net    - МСП
%   output - выход сети

% Проверка размерности входа
if (length(input) ~= net.numInputUnits)
    error('mlp_feedforward: Размерность входного вектора неверна');
end

% Расчет выходов первого скрытого слоя c учетом смещения для нейронов
net.layer(1).V = [1 input]*net.layer(1).W;
net.layer(1).Y = feval(net.layer(1).f, net.layer(1).V);

% Расчет выходов второго и последующих скрытых слоев
for i = 2:net.numLayers
    net.layer(i).V = [1 net.layer(i - 1).Y]*net.layer(i).W;
    net.layer(i).Y = feval(net.layer(i).f, net.layer(i).V);
end

output = net.layer(net.numLayers).Y;
end %of function