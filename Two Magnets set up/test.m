
X = -5:0.1:5;
Y = -5:0.1:5;

FXM = zeros(101, 101);
FYM = zeros(101, 101);
torM = zeros(101, 101);

for i = X
	for j = Y
		ii = int16((i/5+1)*50+1);
		jj = int16((j/5+1)*50+1);
		[FYM(ii,jj),FXM(ii,jj),torM(ii,jj)] = exam3(0,0,i,j);
		
	end	
end

totalforce = (FYM.^2+FXM.^2+torM.^2).^0.5;

figure(1);
% contourf(X, Y, totalforce);
% title('totalforce');
subplot(1,2,1);
contourf(X, Y, FXM);
title('FXM');
subplot(1,2,2);
contourf(X, Y, FYM);
title('FYM');
colorbar;

figure(2);

colormap(FXM);
title('FXM');
subplot(1,2,2);
colormap(FYM);
title('FYM');
colorbar;


