function [ isis ] = isi( spike_times )
%ISI Summary of this function goes here
%   Detailed explanation goes here

isis = diff(spike_times);

end

