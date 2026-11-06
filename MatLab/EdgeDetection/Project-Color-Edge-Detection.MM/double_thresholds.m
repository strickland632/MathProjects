function [strong,weak] = double_thresholds(E3,highRatio,lowRatio)

highThreshold = highRatio*max(E3(:));
lowThreshold  = lowRatio *highThreshold;

strong = (E3>=highThreshold);
weak   = (E3<highThreshold).*(E3>=lowThreshold);