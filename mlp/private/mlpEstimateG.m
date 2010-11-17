function dnorm = mlpEstimateG(net)
% mlpEstimateG - оценивает евклидову норму градиентов
% [net, dnorm] = mlpEstimateG(net)
% Вход функции: 
%   net      - МСП
% Выход функции:
%   net      - МСП
%   dnorm    - оценка евклидовой нормы вектора градиетов

grad = [];
for k = 1:net.numLayers
    grad = [net.layer(k).gW(:); grad];
end

dnorm = norm(grad');

end %of function