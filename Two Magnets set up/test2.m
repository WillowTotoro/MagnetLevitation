[x,y] = meshgrid(-2:.2:2,-1:.15:1);
z = x .* exp(-x.^2 - y.^2); [px,py] = gradient(z,.2,.15);
contour(x,y,z), hold on
quiver(x,y,px,py), hold off, axis image