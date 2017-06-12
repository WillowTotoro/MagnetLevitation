
% angle_1 = 0;%fixed
% angle_2 = pi/4;
% angle_3 = 3*pi/4;
angle = [0,3*pi/4,pi/4];
%angle = [0,0,0];
C1 = [0,0];
X1 = C1(1); 
Y1 = C1(2);
magnet2_range = [-4,12,-8,8];
magnet3_range = [-8,8,-8,8];
length_x = 161;
length_y = 161;
% length2_x = 101;
% length2_y = 101;

%Calculate the x-direction force and the y-direction force:
[torque12,FX12,FY12,~,~] = Force_between_magnet_set(magnet2_range,C1,angle(1),angle(2),length_x,length_y);
[torque13,FX13,FY13,~,~] = Force_between_magnet_set(magnet3_range,C1,angle(1),angle(3),length_x,length_y);

[gradient1,intersect1,X] = step([magnet3_range(1),magnet3_range(2)],(length_x)-1);
[gradient2,intersect2,Y] = step([magnet3_range(3),magnet3_range(4)],(length_y)-1);

[gradient_x13,intersect_x13,X13] = step([magnet3_range(1),magnet3_range(2)],(length_x)-1);
[gradient_y13,intersect_y13,Y13] = step([magnet3_range(3),magnet3_range(4)],(length_y)-1);
[gradient_x12,intersect_x12,X12] = step([magnet2_range(1),magnet2_range(2)],(length_x)-1);
[gradient_y12,intersect_y12,Y12] = step([magnet2_range(3),magnet2_range(4)],(length_y)-1);

total_torque = torque13 + torque12;
total_FX = FX13 + FX12;
total_FY = FY13 + FY12;

for i = Y
	for j = X %#ok<ALIGN>
		jj = int16(j*gradient1+intersect1);
		ii = int16(i*gradient2+intersect2);
        if sqrt((i-C1(2))^2+(j-C1(1))^2) <= 1.1||sqrt((j-(C1(1)-4))^2+(i-C1(2))^2) <= 1.1||sqrt((j-(C1(1)-2))^2+(i-C1(2))^2) <= 1.1
            total_FX(ii,jj)= 0;
            total_FY(ii,jj)= 0;
            total_torque(ii,jj)= 0;
        end
    end
end

% [a13,b13] = meshgrid(X13,Y13);
% [a12,b12] = meshgrid(X12,Y12);
% 
% figure
% subplot(2,2,1);
% contourf(a13,b13, torque13);
% title('torque magnet3')
% colorbar;
% 
% subplot(2,2,2);
% quiver(a13, b13, FX13, FY13, 3);
% title('Total Force magnet3')
% 
% subplot(2,2,3);
% contourf(a12,b12, torque12);
% title('torque magnet2')
% colorbar;
% 
% subplot(2,2,4);
% quiver(a12, b12, FX12, FY12, 3);
% title('Total Force magnet2')

[a,b] = meshgrid(X,Y);

figure
contourf(a,b, total_torque);
title('torque angle = 0')
colorbar;

figure
quiver(a,b,total_FX, total_FY, 3);
title('Total Force angle = 0')

