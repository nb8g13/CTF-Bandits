classdef FPL < handle
    properties
        R
        T
        eta
        K
    end
    
    methods
        function obj = FPL(K, eta)
            obj.R = zeros(K, 1);
            obj.eta = eta;
            obj.K = K;
            obj.T = 0;
        end
        
        function s = sample(obj)
            Z = exprnd(obj.eta, obj.K, 1);
            scores = obj.R + Z;
            %{
            [~, order] = sort(scores);
            candidates = 1:obj.K;
            candidates = candidates(order);
            s = candidates(1:2);
            %}
            
            [~, idx] = max(scores);
            scores(idx) = -Inf;
            [~, idx2] = max(scores);
            s = [idx, idx2];
            
        end
        
        function update(obj, outcome, choices)
            outcome = outcome / 2;
            rewards = zeros(obj.K, 1);
            rewards(choices) = outcome;
            obj.R = obj.R + rewards;
            obj.T = obj.T + 1;
        end
        
       function reward = total_reward(obj)
            reward = sum(obj.R);
       end
    end
end 