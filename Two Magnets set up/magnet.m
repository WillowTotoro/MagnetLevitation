function  [FX,FY,torque]= magnet(X1,Y1,X2,Y2,V1,V2)
L = 7.50e-3;
% Q1 = 1;
% Q2 = 1;
K = 3.66e-5;

% calculate the x and y positions of the four monopoles
C1 = [X1;Y1];%position 1:center of magnet 1
C2 = [X2;Y2];%position 2:center of magnet 2
A1 = [cos(V1);sin(V1)];%angle 1:angle between magnetic moment 1 and x-aixs
A2 = [cos(V2);sin(V2)];%angle 2:angele between magnetic moment 2 and x-aixs

S1 = C1-A1*L/2;%vector of south pole of magnet 1
N1 = C1+A1*L/2;%vector of north pole of magnet 1
S2 = C2-A2*L/2;%vector of south pole of magnet 2
N2 = C2+A2*L/2;%vector of north pole of magnet 2

%calculate the distance between two poles
ds1s2 = -(S1-S2);%vetor of distance between two south poles
dn1n2 = -(N1-N2);%vetor of the  distance between two north poles
ds1n2 = (S1-N2);%vetor of the distance between south pole of 1 and north pole of 2
dn1s2 = (N1-S2);%vetor of the distance between north pole of 1 and south pole of 2

fs1s2 = K*(ds1s2./(norm(ds1s2)^3));%repulsive magnetic force at point S1(the south pole of 2)
fn1n2 = K*(dn1n2./(norm(dn1n2)^3));%repulsive magnetic force at point N1(the north pole of 2)
fs1n2 = K*(ds1n2./(norm(ds1n2)^3));%attractive magnetic force at point S1(the south pole of 2) 
fn1s2 = K*(dn1s2./(norm(dn1s2)^3));%attractive magnetic force at point N1(the north pole of 2)

%add up the x-cocmponent and y-component of the force
F = fs1s2 + fs1n2 + fn1n2 + fn1s2;
FX = F(1); %x-componet of magnetic force
FY = F(2); %y-component of magnetic force
torque = (-1)* (mycross(fs1s2, (-1)*A2) + mycross(fn1n2, A2) + mycross(fn1s2, (-1)*A2) + mycross(fs1n2, A2));

end

