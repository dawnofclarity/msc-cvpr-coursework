%% 4) Visualise the results
% Displays a figure, split into a grid with the "search" candiate, the top
% 20 results, and other search criteria.
%
% Input:
%  enrichedData
function showSingleSearchResult(data, elapsedTime, figureTitle)
THUMB_ROWS=4;
THUMB_COLS=5;
CANVAS_ROWS=4;
CANVAS_COLS=7;
SHOW=THUMB_ROWS * THUMB_COLS; % Show top 20 results

% create figure
fResult = figure('ToolBar','none');

% set the figure size, making sure the figure titlebar is at least displayed onscreen
tmp = fResult.Position(2);
fResult.Position(2) = (fResult.Position(2) + fResult.Position(4)) - 600;
fResult.Position(3) = 1024;
fResult.Position(4) = 600;

% create a tiled layout for the figure
tlResult = tiledlayout(fResult, CANVAS_ROWS, CANVAS_COLS, 'TileSpacing', 'none', 'Padding', 'none');
tlResult.Title.String = figureTitle;

% Show the results
tile = nexttile(tlResult, 1, [1 2]);
axis('off');
imshow(imread(data.search.path));
title({'Query Image', "\color{blue}(" + data.search.groundTruthClass + ")"});

tile = nexttile(tlResult, 1 + CANVAS_COLS, [2 2]);
y = [data.results(:).precisionScore];
x = [data.results(:).recallScore];
plot(x, y, '-');
axis([0 1 0 1]);
title('Precision-Recall Curve');
xlabel('Recall');
ylabel('Precision');


tile = nexttile(tlResult, 1 + 3*CANVAS_COLS, [1 2]);
axis('off');
title([sprintf("AP: %.3f", data.averagePrecision), sprintf("Elapsed time: %.3f", elapsedTime), sprintf("Relevant: %d", data.relevantCount)]);

for ii = 1 : SHOW
    result = data.results(ii);
    
    col = mod(ii - 1, THUMB_COLS);
    row = (ii - col - 1) / THUMB_COLS;
   
    tile = nexttile(tlResult, ((row) * CANVAS_COLS) + col + 3);
    axis('off');
    imshow(imread(result.path));
   
    title({sprintf('Result: %i [%.3f]', ii, result.distanceScore), "\color{blue}(" + result.groundTruthClass + ")", "\color{darkgreen}" + sprintf("P: %.3f, R: %.3f", result.precisionScore, result.recallScore)});
end

end