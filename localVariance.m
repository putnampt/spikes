function [ LV ] = localVariance( ISI )
%LocalVariance - Calculate local variance of an spike timestamp ISI
%   Assumes the ISI is sorted (what does this mean????)
% Cowenversion - altered from Leroy's version. Vectorized for speeed.
v = (ISI(1:(end-1))-ISI(2:end))./(ISI(1:(end-1))+ISI(2:end));
LV = 3*sum(v.^2)/(length(ISI)-1);
% Old version.
% ISI = [1 3 44 2 5 5 2 4 5 23  5 199];
% % original
% sum_LV = 0;
% for i=1:(length(ISI)-1)
%     var = (ISI(i)-ISI(i+1))/(ISI(i)+ISI(i+1));
%     sum_LV = sum_LV + var^2;
% end
% LV=3*sum_LV/(length(ISI)-1);
%
%
% a = [32.04    96.97   95.24   98.25   91.51   89.29   91.94   81.33   67.46   67.74   59.31   71.79   71.01];
% mean(a(2:end))