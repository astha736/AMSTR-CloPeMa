% Astha Gupta 4899512
clc;
clear;

% Ex1 find the Position of Point L and M given values below
d=4;
r=2;
n = 6; 

%--------------------------------------------------------------------------
% Considering Sub-mechanism OADF - OBCE
syms Ex Ey real

O = [0,0];
A = [0,d+20]; 
B = [0,-(d+20)]; 
C = ([3,0]+B); 
D = ([-11,0]+A); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Finding Point E %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DE = 23 and CE = 55, constant lengths
% using distance formula
eq_E_DE = sqrt((D(1)-Ex)^2 + (D(2)-Ey)^2) == 23;  % length of DE
eq_E_CE = sqrt((C(1)-Ex)^2 + (C(2)-Ey)^2) == 55;  % length of CE

PointE = solve([eq_E_DE,eq_E_CE], [Ex,Ey]);

% taking the positive solutions for coordinates of E
Ex = PointE.Ex(2);
Ey = PointE.Ey(2);
E = double([Ex, Ey]); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Finding Point F %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Line ratio formula to find coordinates of F
EF_unit_vec = (E-D)/23;
F = E + EF_unit_vec*17;

%--------------------------------------------------------------------------
% Considering Sub-mechanism RSGJKFL
G = [44.6,-22.5];
R = [-40.9,38];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Finding Point S %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
syms Sx Sy real

% using the distance formula again
eq_S_SR = sqrt((R(1)-Sx)^2 + (R(2)-Sy)^2) == r+95; % length of RS
eq_S_SG = sqrt((G(1)-Sx)^2 + (G(2)-Sy)^2) == 16; % length of SG

PointS = solve([eq_S_SR,eq_S_SG], [Sx,Sy]);

% taking the positive solution for x coordinate and negative for y coordiante
Sx = PointS.Sx(2);
Sy = PointS.Sy(2);
S = double([Sx, Sy]); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Finding Point J %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
syms Jx Jy real

eq_J_SJ = sqrt((S(1)-Jx)^2 + (S(2)-Jy)^2) == sqrt(65^2+16^2); % length of SJ
eq_J_GJ = sqrt((G(1)-Jx)^2 + (G(2)-Jy)^2) == 65; % length of GJ

PointJ = solve([eq_J_SJ,eq_J_GJ], [Jx,Jy]);

% Determining the correct coordinates for J by ensuring J lies left of S (along X)
if PointJ.Jx(1) < S(1)
    Jx = PointJ.Jx(1);
    Jy = PointJ.Jy(1);
elseif PointJ.Jx(2) < S(1)
    Jx = PointJ.Jx(2);
    Jy = PointJ.Jy(2);
else
    % default
    Jx = PointJ.Jx(1);
    Jy = PointJ.Jy(1);
end

J = double([Jx, Jy]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Finding Point M %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% using the line ratio formula again
GJ_unit_vec = (G-J)/65; 
M = G + GJ_unit_vec*124;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Finding Point K %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
syms Kx Ky real

eq_K_FK = sqrt((F(1)-Kx)^2 + (F(2)-Ky)^2) == 65; % length of FK
eq_K_JK = sqrt((J(1)-Kx)^2 + (J(2)-Ky)^2) == 48; % length of JK
PointK = solve([eq_K_FK,eq_K_JK], [Kx,Ky]);

% Determining the correct coordinates for K by ensuring y coordinate of K is positive
if PointK.Ky(1) > S(2)
    Kx = PointK.Kx(1);
    Ky = PointK.Ky(1);
elseif PointK.Ky(2) > S(2)
    Kx = PointK.Kx(2);
    Ky = PointK.Ky(2);
else
    % default
    Kx = PointK.Kx(1);
    Ky = PointK.Ky(1);
end

K = double([Kx, Ky]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Finding Point K %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% KFL = (n+12)*pi/18; n = 6
% KFL = pi

% using the line ratio again
KF_unit_vec = (F - K)/65;
L = F + 133*KF_unit_vec;

% plotting our mechanism
Plot2D(A,B,C,D,E,F,G,J,K,S,R,L,M,O);