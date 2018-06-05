classdef Exp3Combinatorial < handle
    properties
        W
        K
        gamma
        P
        R
        T
        num_arms
        arms
    end
    methods
        function obj = Exp3Combinatorial(K, gamma)
            obj.K = K;
            obj.num_arms = nchoosek(obj.K, 2);
            obj.gamma = gamma;
            obj.W = ones(obj.num_arms, 1);
            obj.P = zeros(obj.num_arms, 1);
            obj.T = 0;
            obj.R = 0;
            obj.arms = buildArms(obj);
        end
        
        function s = sample(obj)
            obj.P = (1-obj.gamma)*obj.W/sum(obj.W) + obj.gamma/obj.num_arms;
            arm_chosen = randsample(1:obj.num_arms, 1, true, obj.P);
            s = obj.arms(arm_chosen, :);
            %s = datasample(1:obj.K, 2, 'Replace',false,'Weights', obj.P);
            %s = randsample(1:obj.K, 2, false, obj.P);
        end
        
        function update(obj, outcome, choices)
            weight_coeff = zeros(obj.num_arms, 1);
            [~, idx] = ismember(choices, obj.arms,'rows');
            weight_coeff(idx) = outcome;
            weight_coeff = weight_coeff / obj.P;
            weight_coeff = weight_coeff*obj.gamma/obj.K;
            obj.W = obj.W .* exp(weight_coeff);
            obj.R = obj.R + outcome;
            obj.T = obj.T + 1;
        end
        
        function reward = total_reward(obj)
            reward = obj.R;
        end
        
        function arms = buildArms(obj)
            arms = zeros(obj.num_arms, 2);
            row_num = 1;
            
            for i=1:obj.K-1
                for j=i+1:obj.K
                    arms(row_num, :) = [i, j];
                    row_num = row_num + 1;
                end
            end
        end
    end
end