function [sdf, tv] = spikeDensityFunction(spikeTimes,varargin)
% [sdf, tv] = spikeDensityFunction(spikeTimes,varargin)
% Returns the spike density function from a spike raster.
% Philip Putnam, 2017
%
%   Inputs:
%   - spikeTimes:	Spike times, either as a vector of timestamps  in seconds
%                   or a logical vector with millisecond resolution (required)
%
%   Optional parameters: 
%   - resolution:	Spike time resolution in milliseconds, i.e. the binning size (ms)
%   - sigma:        Confidence interval of the spike times in milliseconds
%   - max:          The maximal time of the output vector in seconds
%   - plot:         A logical (true or false) option to plot the output
%	- shape:        A string
%   - scale:        A string
%
%   Outputs:
%   - sdf:  Spike density function of 'spikeTimes'
%   - tv:   Time vector accompanying the spike density function with the
%           real time point of each corrispondning index in 'sdf'


% ---------------------- Test settings ----------------------
% clear all
% clc
% load('testSpikeData.mat')
% spikeTimes = thisTrialSpikeLogicalVector;
% varargin = {'plot', true, 'sigma', 50, 'shape', 'Half', 'scale', 'one'};
% -----------------------------------------------------------

% Create input parser object
parserObj = inputParser;

% Set the defaults for the various inputs
defaultSigmaMs = 30;
defaultResolutionMs = 1;
defaultMax = 0;
defaultPlot = false;
defaultShape = 'FULL';
defaultScale = 'NONE';


% Create a function to test if spikeTimes is 1-dimensional
checkSpikeTimes = @(x) size(x,1) == 1 || size(x,2) == 1;
checkShape = @(x) strcmpi(x, 'FULL') || strcmpi(x, 'HALF');
checkScale = @(x) strcmpi(x, 'HZ') || strcmpi(x, 'ONE') || strcmpi(x, 'NONE');

% Set up the parser object with the various parameters
addRequired(parserObj,'spikeTimes',checkSpikeTimes);
addOptional(parserObj,'sigma',defaultSigmaMs,@isnumeric);
addOptional(parserObj,'resolution',defaultResolutionMs,@isnumeric);
addOptional(parserObj,'max',defaultMax,@isnumeric);
addOptional(parserObj,'plot',defaultPlot,@islogical);
addOptional(parserObj,'shape',defaultShape,checkShape);
addOptional(parserObj,'scale',defaultScale,checkScale);

% Parse the input
parse(parserObj,spikeTimes,varargin{:})

% Extract the parameters from the parser object
spikeTimes = parserObj.Results.spikeTimes;
sigmaMs = parserObj.Results.sigma;
resolutionMs = parserObj.Results.resolution;
maxTimeS = parserObj.Results.max;
plotOutput = parserObj.Results.plot;
kernelShape = parserObj.Results.shape;
kernelScale = parserObj.Results.scale;

% Spike times are a logical vector
if islogical(spikeTimes) 
    spikeTimeMs = find(spikeTimes);
    spikeTimeS = spikeTimeMs/1e3;
    
    if maxTimeS == 0
        maxTimeS = numel(spikeTimes)/1e3;
    end

% Spike times are timestamps (in seconds)
else 
    spikeTimeS = spikeTimes;
end

% Spike resolution converted to seconds
resolutionS = resolutionMs/1e3; 

% Sigma converted to seconds
sigmaS = sigmaMs/1e3;           

if maxTimeS == 0
    maxTimeS =  max(spikeTimeS) + (100*resolutionS);
    minTimeS =  min(spikeTimeS) - (100*resolutionS);
else
    minTimeS = resolutionS;
end

% Bin the spikes into an array
spikeBinEdges = (minTimeS:resolutionS:maxTimeS);
spikeBinCounts = histc(spikeTimeS, spikeBinEdges);

% Create a gaussian kernal
kernelEdges = (-3*sigmaS:resolutionS:3*sigmaS);
kernelFunc = normpdf(kernelEdges,0,sigmaS);

% Cleave the kernal into half if so desired
if strcmpi(kernelShape, 'HALF')
    kernelFunc(1:(floor(numel(kernelFunc)/2))) = 0;
end


% Scale the kernal if so desired
if ~strcmpi(kernelScale, 'NONE')
    
    % max(normpdf(x,0,sigma)) == 1/(sigma*sqrt(2*pi))

    switch upper(kernelScale)
        
    case 'HZ' 
          kernelFunc = kernelFunc/(1/(sigmaS*sqrt(2*pi)));
          
          kernelFunc = kernelFunc*(1/sigmaS);
          
          if strcmpi(kernelShape, 'FULL')
              kernelFunc = kernelFunc/2;
          end
    case 'ONE' 
        kernelFunc = kernelFunc/(1/(sigmaS*sqrt(2*pi)));
    otherwise
        warning('(%s)\tUnexpected scaling parameter. Kernal not scaled.', mfilename)
    end
    
end



% Convolve spike data with the kernel to create the spike density function
sdf = conv(spikeBinCounts,kernelFunc, 'same');

% Create the time vector to accompany the spike density function
tv = spikeBinEdges;

% max(normpdf(x,0,sigma)) == 1/(sigma*sqrt(2*pi))


if plotOutput
    figure, clf
    hold on
    
    plot(tv, sdf)
    vline(spikeTimeS)
    xlabel('Time (s)');
    ylabel('Spike density');

end