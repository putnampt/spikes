%function [ output_args ] = raster(h, spikes)
%RASTER Summary of this function goes here
%   Detailed explanation goes here

%function plotRaster(h, spk, identity, subplots)

% keep spk
% identity = [1,1];
% subplots = [3,3,1];
% h = figure(1);

trialCount =size(spk.trials.t,2);
electrodeNum = identity(1);
unitNum = identity(2);
figure(h);
title(strcat('Electrode:',num2str(electrodeNum),' Unit:',num2str(unitNum)));

for trialDex = 1:trialCount
    row = trialDex;
    
    events = spk.trials.t(trialDex).electrode(electrodeNum).unit(unitNum).relativeSpikes';
    
    for i = 1:size(events,2)
       hold on;

       xx(1) = events(i);
       xx(2) = events(i);

       yy(1) = (row-1);
        yy(2) = (row);


       subplot(subplots(1), subplots(2), subplots(3)),plot(xx,yy);
    end
end

end

