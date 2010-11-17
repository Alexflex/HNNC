function net = mlpCorrectWeights(net)
% mlpCorrectWeights - функция корректирует матрицы весов каждого слоя
% net = mlpCorrectWeights(net)
% Вход функции: 
%   net     - МСП
% Выход функции:
%   net     - МСП c корректированными матрицами весов

% Обратный проход - корректировка весов
for k = 1:net.numLayers
    net.layer(k).dW = net.speedLearn*net.layer(k).gW + ...
                        net.momentum*(net.layer(k).W - net.layer(k).Wp);
    net.layer(k).Wp = net.layer(k).W;
    net.layer(k).W = net.layer(k).W + net.layer(k).dW;
end

end %of function