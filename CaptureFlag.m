classdef CaptureFlag < handle
    properties
        hider
        seeker
        K
        flag_dist
        seek_dist
    end
    methods
        function obj = CaptureFlag(K, hider, seeker)
            obj.K = K;
            obj.hider = hider;
            obj.seeker = seeker;
            obj.flag_dist = zeros(1,K);
            obj.seek_dist = zeros(1,K);
        end
        
        function nextRound(obj)
            flags = obj.hider.sample();
            obj.flag_dist(flags) = obj.flag_dist(flags) + 1;
            guesses = obj.seeker.sample();
            obj.seek_dist(guesses) = obj.seek_dist(guesses) + 1;
            seeker_reward = sum(guesses == flags(1)) + sum(guesses == flags(2));
            hider_reward = 2 - seeker_reward;
            obj.hider.update(hider_reward, flags);
            obj.seeker.update(seeker_reward, guesses);
        end
    end
end