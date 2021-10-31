
%
% Class to compute PR stats from algarithmic results vs anticipated results.
%
classdef Score
    
    properties
        index;
        name;
        path;
        distanceScore;
        groundTruthClass;
        matched;
        precisionScore;
        recallScore;
    end
    
    methods
        function obj = Score()
            obj.index = 0;
            obj.name = '';
            obj.path = '';
            obj.distanceScore = 9999;
            obj.groundTruthClass = 'unknown';
            obj.precisionScore = 0;
            obj.recallScore = 0;
            obj.matched = 0;
        end
    end
    
end
