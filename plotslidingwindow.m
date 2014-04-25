function plotslidingwindow(h, spikes, width)


    for row = 1:size(spikes,1)
        for col = 1:size(spikes,2)

            if spikes(row, col)
                hold on;
                xx(1) = col;
                xx(2) = col;
                yy(1) = (row-1);
                yy(2) = (row);
                plot(h, xx,yy, 'LineWidth',width, 'Color','black')
            end
        end
    end
end

