function [gradient,intersect,X] = step(range,number)
%  How to find the corresponding xy values
step = (range(2) - range(1))/number;
gradient = number/(range(2) - range(1));
intersect = 1 - range(1)*gradient;
X = range(1) : step : range(2);
% figure
% Y = X*gradient+intersect;
% plot(X,Y)
end

