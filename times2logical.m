%% times2logical
% This function takes a 1xN or Nx1 matrix of time points (in milliseconds)
% and returns a 1xN length logical matrix where 1 represents a millisecond
% during which a spike occured and 0 represents a millsecond with no spike.
% 
% If there are two events during the same millisecond, only one event is
% represented.
%
% Inputs:
%       _times_ - 1xN matrix of doubles, with each value representing the 
%       time in milliseconds where an event (spike) occured
%
% Outputs:
%      _logical_ - 1xN matrix of doubles, where each value represents a
%      millisecond where a spike occured (1) or did not occur (0)
%


function [logical] = times2logical(times, length)

logical = zeros(length);
logical(round(times)) = 1;