function [ estimatedRate ] = halfgaussconvolve( spikes, width )
%HALFGAUSSCONVOLVE Summary of this function goes here
%   Detailed explanation goes here
wholeWidth =width*2;
alpha = 8;
wholeGauss = gausswin(wholeWidth,alpha);
halfGauss = wholeGauss((size(wholeGauss,1)/2):end);
estimatedRate = conv(halfGauss,spikes);

end

