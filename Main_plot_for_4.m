%CONSTANT:
% angle_1 = (-1) * pi/4;
% angle_2 = 5 * pi/4;
% angle_3 = 5 * pi/4;
% angle_4 = (-1) * pi/4;
moving_angles = [(-1) * pi/4, 5 * pi/4];
fixed_angles = [5 * pi/4, (-1) * pi/4];
C3 = [-3.5,0];
C4 = [3.5,0];
length = 161;
%ranges = [-12 8 -8 8; ranges(1)+4,ranges(2)+4,-8,8];
ranges = [-12 8 -8 8; -8,12,-8,8];
%Calculate the x-direction force and the y-direction force:        
[torque13,FX13,FY13,X13,Y13] = Force_between_magnet_set(ranges(1,:),C3,moving_angles(1),fixed_angles(1),length,length);
[torque23,FX23,FY23,X23,Y23] = Force_between_magnet_set(ranges(2,:),C3,moving_angles(2),fixed_angles(1),length,length);
[torque14,FX14,FY14,X14,Y14] = Force_between_magnet_set(ranges(1,:),C4,moving_angles(1),fixed_angles(2),length,length);
[torque24,FX24,FY24,X24,Y24] = Force_between_magnet_set(ranges(2,:),C4,moving_angles(2),fixed_angles(2),length,length);

x_range = [ranges(1,1),ranges(1,2)];
y_range = [ranges(1,3),ranges(1,4)];
[gradient1,intersect1,X] = step(x_range,length-1);
[gradient2,intersect2,Y] = step(y_range,length-1);

total_torque = torque13 + torque14 + torque23 + torque24;
FX = FX13 + FX14 + FX23 + FX24;
FY = FY13 + FY14 + FY23 + FY24;

for i = Y
	for j = X
		jj = int16(j*gradient1+intersect1);
		ii = int16(i*gradient2+intersect2);
        if sqrt((j-C3(1)).^2+(i-C3(2)).^2) <= 1.1||sqrt((j-C4(1)).^2+(i-C4(2)).^2) <= 1.1||sqrt((j-(C4(1)-4)).^2+(i-C4(2)).^2) <= 1.1||sqrt((j-(C3(1)-4)).^2+(i-C3(2)).^2) <= 1.1
            FX(ii,jj)= 0;
            FY(ii,jj)= 0;
            total_torque(ii,jj)= 0;
        end
	end	
end

% [a13,b13] = meshgrid(X13,Y13);
% [a23,b23] = meshgrid(X23,Y23);
% [a14,b14] = meshgrid(X14,Y14);
% [a24,b24] = meshgrid(X24,Y24);
% 
% figure
% subplot(4,2,1);
% contourf(a13,b13, torque13);
% title('torque magnet13')
% colorbar;
% 
% subplot(4,2,2);
% quiver(a13, b13, FX13, FY13, 1);
% title('Total Force magnet13')
% 
% subplot(4,2,3);
% contourf(a23,b23, torque23);
% title('torque magnet23')
% colorbar;
% 
% subplot(4,2,4);
% quiver(a23, b23, FX23, FY23, 1);
% title('Total Force magnet23')
% 
% subplot(4,2,5);
% contourf(a24,b24, torque24);
% title('torque magnet24')
% colorbar;
% 
% subplot(4,2,6);
% quiver(a24, b24, FX24, FY24, 3);
% title('Total Force magnet23')
% 
% subplot(4,2,7);
% contourf(a14,b14, torque14);
% title('torque magnet14')
% colorbar;
% 
% subplot(4,2,8);
% quiver(a14, b14, FX14, FY14, 3);
% title('Total Force magnet14')

[a,b] = meshgrid(X,Y);

figure
contourf(a,b, total_torque);
title('torque')
colorbar;

figure
quiver(a,b, FX, FY, 3);
title('Total Force')


