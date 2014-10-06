function [ isihist ] = isihist( spike_times, bins )
%ISI Summary of this function goes here
%   Detailed explanation goes here

isis = diff(spike_times);

isihist   = histc(isis,bins);

end

