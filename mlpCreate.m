function net = mlpCreate(numUnitsLayers, activateFuncs)
% ������� � �������������� ���������, ����������� ������������ ����������
%
% net = mlpCreate(numUnitsLayers, activateFuncs)
%
% Arguments
% numUnitsLayers - ������, ����������� ���������� �������� �� �����
% activateFuncs - ������, ����������� ������� ��������� �������� ������� � 
%   ��������� �����. ����������� �� ������� ������, ��� numUnitsLayers. 
%   ������� �� ����� ���� 'tansig', 'purelin'
%
% net - ���������, ����������� ��� �������� �����������
%
% Example
% net = mlpCreate([10, 8, 10, 10], {'tansig'; 'tansig'; 'tansig'});
%
% See also
% nntool
% 
% Revisions
% Author: Vulfin Alex, Date: 17/11/2010
% Supervisor: Vulfin Alex, Date: 17/11/2010
% Author: (Next revision author), Date: (Next revision date)

% ������ ���������� �������
if any([length(numUnitsLayers) < 3, ...     % ���� �� ���� ������� ����
        isinteger(numUnitsLayers),  ...     
        find(numUnitsLayers <= 0),  ...
        length(numUnitsLayers) ~= (size(activateFuncs, 1) + 1)])
    error('mlp_net: �������� ������� ������ ��� �������� ����');
end

% ������������� ���������� ���� �� ���������
net.numLayers = length(numUnitsLayers) - 1;	% ���������� ����� 
net.numInputUnits = numUnitsLayers(1);      % ����������� �����
net.numOutputUnits = numUnitsLayers(end);	% ����������� ������
net.initValue = 0.25;                       % �������� �������������
net.numEpoch = 1000;                        % ������������ ���������� ����
net.momentum = 0.5;                         % ������ ��������
net.speedLearn = 0.01;                      % �������� ��������
% ����������� �������� ���������
net.minGradValue = 1e-10;                   
% ����� ���� �������� ��������
net.printLog = 10;                          
% ������������ ��������� ��������� ������ countShuffleSet ����
net.countShuffleSet = 5;                    
% �������� ������� ������� �� ��������� ���������
net.goal = 1e-5;                            

% �������� ��������� ��������
net.numEstimatedEpoch = 10;                 % ���������� ����������� ����
% ������������ ���������� �������� �� ��������� ����������
net.maxValidationFail = 10;                 
% ���������� �������� �� ��������� ����������   
net.countValidationFail = 0;                
% ��������� ������ �� ����������� ���������
net.validationStopThreshold = 1e-5;         

% ��������� ������� �������� ����
% ����� �������� ����
net.layer(1).number = 1;                    

% ���-�� �������� � ����
net.layer(1).numUnits = numUnitsLayers(2);  

% �������������� ��������� ���� �������� ����
net.layer(1).V = zeros(1, numUnitsLayers(2));          

% ������ �������� ����
net.layer(1).Y = zeros(1, numUnitsLayers(2));          

% ������ ������ �������� ����
net.layer(1).E = zeros(1, numUnitsLayers(2));          

% ��������� ��������� �������� ����
net.layer(1).G = zeros(1, numUnitsLayers(2));          

% ������� ����� �������� �� ����. n
net.layer(1).W = ...                        
	randinit(net.initValue, net.numInputUnits + 1, numUnitsLayers(2)); 

% ������� ����� �������� �� ����. n - 1
net.layer(1).Wp = ...                       
	randinit(net.initValue, net.numInputUnits + 1, numUnitsLayers(2)); 

% ������� ����������� ���� dE/dW
net.layer(1).gW = ...                       
	zeros(net.numInputUnits + 1, numUnitsLayers(2)); 

% ���������� ����� �������� ���� �� ����. n
net.layer(1).dW = ...                       
	zeros(net.numInputUnits + 1, numUnitsLayers(2));

% ������� ��������� � �� ����������� ��� �������� ����
if (strcmp(activateFuncs(1), 'tansig'))
    net.layer(1).f  = @hyptan;
    net.layer(1).df = @dhyptan;
elseif (strcmp(activateFuncs(1), 'purelin'))
    net.layer(1).f  = @purelinf;
    net.layer(1).df = @dpurelinf;
else
    error('mlp_net: ������� ���������� ������� ��������� ��������');
end
        
printMessage('\nmlp_net: ������ %d ����', 1);

% ��������� ������� � ����������� ������� �����
for k = 2:net.numLayers    
    net.layer(k).number = k;                       
    net.layer(k).numUnits = numUnitsLayers(k + 1);              
    net.layer(k).V = zeros(1, numUnitsLayers(k + 1));    
    net.layer(k).Y = zeros(1, numUnitsLayers(k + 1));    
    net.layer(k).E = zeros(1, numUnitsLayers(k + 1));    
    net.layer(k).G = zeros(1, numUnitsLayers(k + 1));   
    
    net.layer(k).W = randinit(net.initValue, ...
                              net.layer(k - 1).numUnits + 1, ...
                              numUnitsLayers(k + 1));
                          
    net.layer(k).Wp = randinit(net.initValue, ...
                               net.layer(k - 1).numUnits + 1, ...
                               numUnitsLayers(k + 1));
                           
    net.layer(k).dW = zeros(net.layer(k - 1).numUnits + 1, ...
                            numUnitsLayers(k + 1)); 
                        
    net.layer(k).gW = zeros(net.layer(k - 1).numUnits + 1, ...
                            numUnitsLayers(k + 1));

    if (strcmp(activateFuncs(k), 'tansig'))
        net.layer(k).f  = @hyptan;
        net.layer(k).df = @dhyptan;
    elseif (strcmp(activateFuncs(1), 'purelin'))
        net.layer(k).f  = @purelinf;
        net.layer(k).df = @dpurelinf;
    else
        error('mlp_net: �������� ���������� ������� ��������� ��������');
    end
    
    printMessage('\nmlp_net: ������ %d ����', k);
end

end % of function