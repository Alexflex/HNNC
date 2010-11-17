function dnorm = mlpEstimateG(net)
% Функция оценивает евклидову норму градиентов
%
% dnorm = mlpEstimateG(net)
%
% Arguments
% net      - МСП
%
% dnorm    - оценка евклидовой нормы вектора градиетов
%
% Example
% dnorm = mlpEstimateG(net);
%
% See also
% 
% Revisions
% Author: Vulfin Alex, Date: 17/11/2010
% Supervisor: Vulfin Alex, Date: 17/11/2010
% Author: (Next revision author), Date: (Next revision date)


grad = [];
for k = 1:net.numLayers
    grad = [net.layer(k).gW(:); grad];
end

dnorm = norm(grad');

end %of function