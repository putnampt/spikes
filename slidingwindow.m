 function [estimatedRate] = slidingwindow(spikes, bin, overlap)
% %SLIDINGWINDOW Summary of this function goes here
% %   Detailed explanation goes here

estimatedRate = spikes*1000;


if overlap == 0
    step = 1;
else
    step = overlap;
end

for start = 1:step:size(spikes,2)-bin
    stop = start+bin-1;
    estimatedRate(start:stop) = mean(estimatedRate(start:stop));
end

estimatedRate(size(spikes,2)-bin+1:size(estimatedRate,2)) = mean(estimatedRate(size(spikes,2)-bin+1:size(estimatedRate,2)));


