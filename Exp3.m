classdef Exp3 < handle
    properties
        W
        K
        gamma
        P
        R
        T
    end
    methods
        function obj = Exp3(K, gamma)
            obj.K = K;
            obj.gamma = gamma;
            obj.W = ones(K, 1);
            disp(size(obj.W));
            obj.P = zeros(K, 1);
            obj.T = 0;
            obj.R = 0;
        end
        
        function s = sample(obj)
            obj.P = (1-obj.gamma)*obj.W/sum(obj.W) + obj.gamma/obj.K;
            s = datasample(1:obj.K, 2, 'Replace',false,'Weights', obj.P);
            %s = randsample(1:obj.K, 2, false, obj.P);
        end
        
        function update(obj, outcome, choices)
            obj.R = obj.R + outcome;
            outcome = outcome / 2;
            weight_coeff = zeros(obj.K, 1);
            weight_coeff(choices) = outcome;
            weight_coeff = weight_coeff ./ obj.P;
            weight_coeff = weight_coeff*obj.gamma/obj.K;
            obj.W = obj.W .* exp(weight_coeff);
            obj.T = obj.T + 1;
        end
        
        function reward = total_reward(obj)
            reward = obj.R;
        end
    end
end
    