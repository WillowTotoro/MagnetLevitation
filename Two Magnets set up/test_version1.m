%test 
angle_1 = (-1) * pi/4;
angle_2 = 5 * pi/4;
angle_3 = 5 * pi/4;
angle_4 = (-1) * pi/4;

X1 = -3;
Y1 = 0;
X2 = 3;
Y2 = 0;


% Calculate the x-direction force and the y-direction force:

[torque13,FX13,FY13,X13,Y13] = Force_between_magnet_set(-8,8,-5,5,X1,Y1,angle_1,angle_3);
[torque23,FX23,FY23,X23,Y23] = Force_between_magnet_set(-6,10,-5,5,X1,Y1,angle_2,angle_3);
[torque14,FX14,FY14,X14,Y14] = Force_between_magnet_set(-8,8,-5,5,X2,Y2,angle_1,angle_4);
[torque24,FX24,FY24,X24,Y24] = Force_between_magnet_set(-6,10,-5,5,X2,Y2,angle_2,angle_4);
% [a13,b13] = meshgrid(Y13,X13);
% [a23,b23] = meshgrid(Y23,X23);
% [a14,b14] = meshgrid(Y14,X14);
% [a24,b24] = meshgrid(Y24,X24);
[ Shifted_FX13 ] = move_up(FX13);
[ Shifted_FX14 ] = move_up(FX14);
[ Shifted_FX23 ] = move_down(FX23);
[ Shifted_FX24 ] = move_down(FX24);
[ Shifted_FY13 ] = move_up(FY13);
[ Shifted_FY14 ] = move_up(FY14);
[ Shifted_FY23 ] = move_down(FY23);
[ Shifted_FY24 ] = move_down(FY24);
[ Shifted_torque13 ] = move_up(torque13);
[ Shifted_torque24 ] = move_down(torque24);
[ Shifted_torque14 ] = move_up(torque14);
[ Shifted_torque23 ] = move_down(torque23);

FX = Shifted_FX13 + Shifted_FX14 + Shifted_FX23 + Shifted_FX24;
FY = Shifted_FY13 + Shifted_FY14 + Shifted_FY23 + Shifted_FY24;
total_torque = Shifted_torque13 + Shifted_torque23 + Shifted_torque14 + Shifted_torque24 ;  

[gradient1,intersect1,X] = step(-8,10,180);
[gradient2,intersect2,Y] = step(-5,5,100);

% FX = FX13 + FX14 + FX23 + FX24;
% FY = FY13 + FY14 + FY23 + FY24;
% total_torque = torque13 + torque23 + torque14 + torque24 ; 

% 
% for i = X
% 	for j = Y
% 		ii = int16(i*gradient1+intersect1);
% 		jj = int16(j*gradient2+intersect2);
%         if sqrt((i-X1).^2+(j-Y1).^2) <= 1.5||sqrt((i-X2).^2+(j-Y2).^2) <= 1.5
%             FY(ii,jj)= 0;
%             FX(ii,jj)= 0;
%             total_torque(ii,jj) = 0;
%         end
%         
%         if isnan(FY(ii,jj)) == true||isnan(FX(ii,jj)) == true||isnan(total_torque(ii,jj)) == true
%             FY(ii,jj)= 0;
%             FX(ii,jj)= 0;
%             total_torque(ii,jj) = 0;
%         end
%             
% 	end	
% end
[a,b] = meshgrid(Y,X);

figure
contourf(b, a, total_torque);
title('torque')
colorbar;

figure
quiver(b, a, FX, FY);
title('Total Force')

figure

subplot(4,2,1);

contourf(b,a, Shifted_torque13);
title('torque13')
colorbar;


subplot(4,2,2);
quiver(b, a, Shifted_FX13,Shifted_FY13)
title('force13')

subplot(4,2,3);
contourf(b, a, Shifted_torque23);
title('torque23')
colorbar;


subplot(4,2,4);
quiver(b, a, Shifted_FX23, Shifted_FY23)
title('force23')


subplot(4,2,5);
contourf(b, a, Shifted_torque14);
title('torque14')
colorbar;


subplot(4,2,6);
quiver(b, a, Shifted_FX14, Shifted_FY14)
title('force14')


subplot(4,2,7);
contourf(b, a, Shifted_torque24);
title('torque24')
colorbar;


subplot(4,2,8);
quiver(b, a, Shifted_FX24, Shifted_FY24)
title('force13')
