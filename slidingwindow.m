function [estimatedRate] = slidingwindow(spikes, size, overlap)
%SLIDINGWINDOW Summary of this function goes here
%   Detailed explanation goes here

    if unique(spikes) == [0, 1] % If spikes are represented in a logical vector
        
        estimatedRate = zeros(1, size(spikes,2)); % Preallocate _estimatedRate_
 
    else % If spikes are represented in time points
        
    end
    
end

