k = 0.5;
l = 5;
q = 0.045;
X = k:q:l;
Y = k:q:l;
size = 100;
gradient = size/(l-k);
intersect = 1 - k*gradient;
y = int16(gradient*X+ intersect);
plot(X,y)