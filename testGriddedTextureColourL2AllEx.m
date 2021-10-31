%% Gridded Colour Euclidian L2 Distance All searches
% NB: Requires that the descriptor generation for griddedColour has been completed
%
% Searches all combinations of image, computing AP for each to yield MAP

close all;
clear all;

gvalues = [6, 8, 10, 12];
qvalues = [6, 8, 10];

figure

legendText = cell(1,0);
for ii = 1 : size(qvalues, 2)
    Q = qvalues(ii);
    for jj = 1 : size(gvalues, 2)
        G = gvalues(jj);

        % progress...
        fprintf("Q: %d, G: %d:\n", Q, G);

        
        %% 1) Load all the descriptors
        % each row of ALLFEAT is a descriptor (is an image)
        [ALLFEAT, ALLFILES] = loadDescriptors(sprintf('griddedTextureColourQ%dG%d', Q, G));
        NIMG=size(ALLFEAT,1);           % number of images in collection

        %% 2) For each image
        tic
        averagePrecisionRunningTotal = 0;
        p = zeros(NIMG, NIMG);
        r = zeros(NIMG, NIMG);
        for queryimg = 1 : NIMG

            %% 3) Compute the distance of image to the query
            dst=zeros(NIMG, 2);
            for ii=1:NIMG
                candidate=ALLFEAT(ii,:);
                query=ALLFEAT(queryimg,:);
                thedst=compareL2Norm(query, candidate);
                dst(ii,:) = [thedst ii];
            end
            dst=sortrows(dst,1);  % sort the results

            %% 4) Enrich the search result data
            % calculates classes of images, Precision / Recall, Average Precision
            data = enrichData(NIMG, ALLFILES, dst, queryimg);

            averagePrecisionRunningTotal = averagePrecisionRunningTotal + data.averagePrecision;

            p(queryimg,:) = [data.results(:).precisionScore];
            r(queryimg,:) = [data.results(:).recallScore];

        end
        elapsedTime = toc;

        %% 5) post image figures
        map = averagePrecisionRunningTotal / NIMG;
        mp = mean(p,1);
        mr = mean(r,1);

        %% 6) Visualise the results
        fprintf("descriptor: %d\n", size(candidate, 2));
        fprintf("MAP: %0.3f\n", map);
        fprintf("Elapsed time: %.3f\n", elapsedTime)
        legendText = [legendText; sprintf('Q: %d, G: %d', Q, G)];
        plot(mr, mp, '-');
        hold on;
        axis([0 1 0 1]);

    end
end

title('Precision-Recall Curve');
xlabel('Recall');
ylabel('Precision');
legend(legendText);

hold off;