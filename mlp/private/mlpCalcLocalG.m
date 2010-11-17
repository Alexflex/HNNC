function net = mlpCalcLocalG(net, input)
% mlpCalcLocalG - функция рассчитывает локальные градиенты
% net = mlpCalcLocalG(net)
% Вход функции: 
%   net    - МСП
% Выход функции:
%   net    - МСП c рассчитанными локальными градиентами для всех нейронов

% Обратный проход: расчет локальных градиентов
% - для нейронов выходного слоя
net.layer(net.numLayers).G = net.layer(net.numLayers).E .* ...
        feval(net.layer(net.numLayers).df, net.layer(net.numLayers).Y);
        
% - для нейронов скрытых слоев
for k = net.numLayers - 1:-1:1
    net.layer(k).E = net.layer(k + 1).G * net.layer(k + 1).W(2:end, :)';
    net.layer(k).G = net.layer(k).E .* ...
                           feval(net.layer(k).df, net.layer(k).Y);
end

% Расчет локальных градиентов dE/dW
net.layer(1).gW = [1 input]' * net.layer(1).G;
for k = 2:net.numLayers
    net.layer(k).gW = [1 net.layer(k - 1).Y]' * net.layer(k).G;
end

end %of functkon