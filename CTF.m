K = 5;
hider = exp3(K, 0.5);
seeker =  exp3(K, 0.5);
ctf = CaptureFlag(K, hider, seeker);

max_T = 3000;
hider_avg = zeros(max_T, 1);
seeker_avg = zeros(max_T, 1);


for i=1:max_T
    hider_avg(i) = hider.total_reward()/i;
    seeker_avg(i) = seeker.total_reward()/i;
    ctf.nextRound();
end

plot(1:max_T, hider_avg);
hold on
%plot(1:max_T, 4/3);  
plot(1:max_T, seeker_avg);
%plot(1:max_T, 4/3);
%disp(ctf.flag_dist);
%disp(seeker.W);
%disp(seeker.P);
%disp(hider.P);