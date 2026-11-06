function [strong,weak] = double_threshold(E1,highRatio,lowRatio)

highThreshold = highRatio*max(E1(:));
lowThreshold  = lowRatio *highThreshold;

strong = (E1>=highThreshold);
weak   = (E1<highThreshold).*(E1>=lowThreshold);

