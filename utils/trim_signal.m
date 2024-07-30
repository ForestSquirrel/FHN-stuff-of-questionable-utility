function [t_trimmed, sig_trimmed] = trim_signal(t, sig, fs, targetTmax)
    % Calculate the original duration of the signal
    originalDuration = numel(t) / fs;
    
    % Check if the original duration is less than the target duration
    if originalDuration < targetTmax
        error('The original signal duration is less than the target duration.');
    end
    
    % If the original duration is equal to the target duration, return the original signal
    if originalDuration == targetTmax
        t_trimmed = t;
        sig_trimmed = sig;
        return;
    end
    
    % Calculate the number of samples for the target duration
    targetSamples = round(targetTmax * fs);
    
    % Trim the signal
    t_trimmed = t(1:targetSamples);
    sig_trimmed = sig(1:targetSamples);
end