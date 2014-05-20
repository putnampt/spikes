function plotbins(h, spikes, width)

spikes = sum(spikes);

bins = zeros(1, ceil(size(spikes,2)/width));

for steps = 1: floor(size(spikes,2)/width)
    bin(steps) = sum(spikes((steps*width)-width+1:(steps*width)-1));
end

if floor(size(spikes,2)/width) ~= size(spikes,2)/width
     bin(steps+1) = sum(spikes((steps*width)-1):size(spikes,2));
end

bar(h, bin, 'BarWidth', 1);

axis tight