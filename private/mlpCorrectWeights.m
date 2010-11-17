function net = mlpCorrectWeights(net)
% Функция корректирует матрицы весов каждого слоя
%
% net = mlpCorrectWeights(net)
%
% Arguments
% net - МСП
%
% net - МСП cо скорректированными матрицами весов
%
% Example
% net = mlpCorrectWeights(net);
%
% See also
% 
% Revisions
% Author: Vulfin Alex, Date: 17/11/2010
% Supervisor: Vulfin Alex, Date: 17/11/2010
% Author: (Next revision author), Date: (Next revision date)

% Обратный проход - корректировка весов
for k = 1:net.numLayers
    net.layer(k).dW = net.speedLearn*net.layer(k).gW + ...
                        net.momentum*(net.layer(k).W - net.layer(k).Wp);
    net.layer(k).Wp = net.layer(k).W;
    net.layer(k).W = net.layer(k).W + net.layer(k).dW;
end

end %of function