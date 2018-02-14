classdef exampleRegressionMAELayer < nnet.layer.RegressionLayer
               
    methods
        function layer = exampleRegressionMAELayer(name)
            % Create an exampleRegressionMAELayer

            % Set layer name
            if nargin == 1
                layer.Name = name;
            end

            % Set layer description
            layer.Description = 'Example regression layer with MAE loss';
        end
        
        function loss = forwardLoss(layer, Y, T)
            % Returns the MAE loss between the predictions Y and the
            % training targets T

            % Calculate MAE
            K = size(Y,2);
            meanAbsoluteError = sum(abs(Y-T),3)/K;
    
            % Take mean over mini-batch
            N = size(Y,3);
            loss = sum(meanAbsoluteError)/N;
        end
        
        function dLdY = backwardLoss(layer, Y, T)
            % Returns the derivatives of the MAE loss with respect to the predictions Y

            N = size(Y,3);
            dLdY = sign(Y-T)/N;
        end
    end
end