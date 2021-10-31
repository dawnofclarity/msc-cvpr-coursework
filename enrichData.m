%% Enrich the search result data (and normalise into a Result class)
% Input:
%  NIMG         total number of images considered
%  ALLFILES     vector of file names
%  dst          vector of [result index]
%  queryimg     index of search descriptor
function out = enrichData(NIMG, ALLFILES, dst, queryimg)

    % Search image
    search = Score();
    search.index = queryimg;
    search.name = ALLFILES{search.index, 2};
    search.path = ALLFILES{search.index, 1};
    search.groundTruthClass = GroundTruthClass.deriveClassFromFilename(search.name);

    % Count potential relevant results (needed for recall)
    results = repmat(Score, NIMG, 1);
    relevantCount = 0;
    for ii = 1 : NIMG
        result = results(ii);
        result.index = dst(ii,2);
        result.name = ALLFILES{result.index, 2};
        result.path = ALLFILES{result.index, 1};
        result.distanceScore = dst(ii,1);
        result.groundTruthClass = GroundTruthClass.deriveClassFromFilename(result.name);
        if (strcmp(search.groundTruthClass, result.groundTruthClass) == 1)
            result.matched = 1;
            relevantCount = relevantCount + 1;
        end
        results(ii) = result;
    end

    % Evaluate results, computing the precision/recall scores
    foundRunningTotal = 0;
    for ii = 1 : NIMG
        result = results(ii);

        % precesion / recall calcs
        if (result.matched)
            foundRunningTotal = foundRunningTotal + 1;
        end
        result.precisionScore = foundRunningTotal / ii;
        result.recallScore = foundRunningTotal / relevantCount;  
        results(ii) = result;
    end

    % Average Precision => sum(precision(n) * relevant(n)) / relevant count
    averagePrecisionRunningTotal = 0;
    for ii = 1 : NIMG
        result = results(ii);
        if result.matched
            averagePrecisionRunningTotal = averagePrecisionRunningTotal + result.precisionScore;
        end
    end
    averagePrecision = averagePrecisionRunningTotal / relevantCount;

    % package up into return struct
    out.n = NIMG;
    out.search = search;
    out.results = results;
    out.relevantCount = relevantCount;
    out.averagePrecision = averagePrecision;

end