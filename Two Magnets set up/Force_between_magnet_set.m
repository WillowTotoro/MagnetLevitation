function [torque,FX,FY,X,Y] = Force_between_magnet_set(xy_range,C0,V1,V2,Length_x,Length_y)


FXM = zeros(length(Length_x), length(Length_y));
FYM = zeros(length(Length_x), length(Length_y));
torM = zeros(length(Length_x), length(Length_y));

x_range = [xy_range(1),xy_range(2)];
y_range = [xy_range(3),xy_range(4)];

[gradient1,intersect1,X] = step(x_range,(Length_x)-1);
[gradient2,intersect2,Y] = step(y_range,(Length_y)-1);



X0 = C0(1);
Y0 = C0(2);

for i = Y
	for j = X
		jj = int16(j*gradient1+intersect1);
		ii = int16(i*gradient2+intersect2);
        
%         if sqrt((i-Y0).^2+(j-X0).^2) <= 1.5
%             FYM(ii,jj)= 0;
%             FXM(ii,jj)= 0;
%             torM(ii,jj) = 0;
%         else
            [FXM(ii,jj),FYM(ii,jj),torM(ii,jj)] = magnet(X0,Y0,j,i,V1,V2);
%         end
	end	
end

torque = torM;
FX = FXM;
FY = FYM;

end
