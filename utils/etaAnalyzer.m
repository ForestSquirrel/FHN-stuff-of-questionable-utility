classdef etaAnalyzer
    properties
        maxCtr
        windowSize
        nextUpdate

        ctr
        iterationTimes
        nextUpdateThreshold
        iterationStartTime
    end

    methods
        % Constructor
        function obj = etaAnalyzer(maxCtr, windowSize, nextUpdate)
            if nargin < 3
                nextUpdate = 0; % Default value to display ETA every iteration if unspecified
            end
            
            obj.maxCtr = maxCtr;
            obj.windowSize = windowSize;
            obj.nextUpdate = nextUpdate;
            obj.ctr = 0;
            obj.iterationTimes = [];
            obj.nextUpdateThreshold = nextUpdate;
            obj.iterationStartTime = 0;
        end

        % Method to start the iteration timer
        function obj = startIter(obj)
            obj.ctr = obj.ctr + 1;
            obj.iterationStartTime = tic;
        end

        % Method to end the iteration, calculate ETA, and print progress
        function obj = endIter(obj)
            iterationTime = toc(obj.iterationStartTime);
            obj.iterationTimes = [obj.iterationTimes, iterationTime];
            if length(obj.iterationTimes) > obj.windowSize
                obj.iterationTimes = obj.iterationTimes(end-obj.windowSize+1:end);
            end

            avgIterationTime = mean(obj.iterationTimes);
            eta = avgIterationTime * (obj.maxCtr - obj.ctr);
            
            eta_hours = floor(eta / 3600);
            eta_minutes = floor(mod(eta, 3600) / 60);
            eta_seconds = mod(eta, 60);
            eta_str = sprintf('%02d:%02d:%02d', eta_hours, eta_minutes, eta_seconds);

            progressPercent = (obj.ctr / obj.maxCtr) * 100;
            if obj.nextUpdate == 0 || progressPercent >= obj.nextUpdateThreshold
                fprintf("Current progress: %.1f%% (%d/%d), ETA: %s\n", progressPercent, obj.ctr, obj.maxCtr, eta_str);
                obj.nextUpdateThreshold = obj.nextUpdateThreshold + obj.nextUpdate;
            end
        end

        % Method to finalize and clean up
        function obj = finish(obj)
            obj.ctr = [];
            obj.iterationTimes = [];
            obj.nextUpdateThreshold = [];
        end
    end
end
