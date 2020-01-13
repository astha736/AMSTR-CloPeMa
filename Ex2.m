% Astha Gupta 4899512
clc;
clear;

O = [0, 0];
A = [0, 24];
B = [0, -24];
C = [3, -24];
D = [-11, 24];
G = [44.6, -22.5];
R = [-40.9, 38];
E = [11.091, 30.402];
F = [27.419, 35.133];
S = [45.2827   -6.5146];
J = [-20.3408  -19.7266]; 
M = [168.4871  -27.7907];
K = [-36.8399   25.3486]; 
L = [158.9039   55.1540];


BC = 3; 
AD = 11;
DE = 23;
CE = 55;
OA = 20;
GM = 124;
RS = 97; % 95 + r(=2)
SG = 16;
JK = 48;
GJ = 65;
KF = 65;

r = 2;
d = 4;

%%%%%%%%%%%%%%%%%%%%%%%%%%% Part A %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% find centrode for KL
% Ans 
ic_KL = F;
ic_DF = xPoint(A,D,C,E);

syms vd real
vInput1 = [vd vd 0]'; % vd is d_dot

% finding angle ADE
cosADE = (E(1) - D(1))/DE;
sinADE = (E(2) - D(2))/DE;
% ADE = atan2(sinADE, cosADE);

% finding angle between CE and x axis
cosCEx = (DE*cosADE - BC - AD)/CE;
sinCEx = (2*(OA + d) + DE*sinADE)/CE;

MomentDE = cross([D(1) D(2) 0],[cosADE sinADE 0]);
MomentDE = MomentDE(3);

MomentCE = cross([C(1) C(2) 0],[cosCEx sinCEx 0]);
MomentCE = MomentCE(3);

MomentD = cross([D(1) D(2) 0],[1 0 0]);
MomentD = MomentD(3);

phi_de = [cosADE sinADE MomentDE];
phi_ce = [cosCEx sinCEx MomentCE];
phi_d = [1 0 MomentD];

tau_a = [0 1 0];
tau_b = [0 -1 0];

j11 = dot(phi_de, tau_a);
j12 = dot(phi_ce, tau_b);

% IO equation => constraintLHS*twist = J*vInput1
J1 = [j11 0 0; 0 j12 0; 0 0 1];

constraintLHS = [phi_de; phi_ce; phi_d];

% IO equation => twist = inv(constraintLHS)*J*vInput1
twistJacobian = inv(constraintLHS)*J1;

% IO equation => twist = twistJacobian*vInput1
twistF = twistJacobian*vInput1;

velocityF_dueToRot = cross([0 0 twistF(3)],[F(1) F(2) 0]);
velocityF = twistF + velocityF_dueToRot';

%---------------------------------
syms vR real
vInput2 = [vR 0 0]'; % vR is r_dot

%finding the angle between MG and x axis

cosMGx = (M(1) - G(1))/GM;
sinMGx = (M(2) - G(2))/GM;

% finding the angle between RS and x

cosRSx = (R(1) - S(1))/RS;
sinRSx = (R(2) - S(2))/RS;

MomentRS = cross([R(1) R(2) 0],[cosRSx sinRSx 0]);
MomentRS = MomentRS(3);

MomentG = cross([G(1) G(2) 0], [-sinMGx cosMGx 0]);
MomentG = MomentG(3);

MomentGP = cross([G(1) G(2) 0], [cosMGx sinMGx 0]);
MomentGP = MomentGP(3);

phi_rs = [cosRSx sinRSx MomentRS];
phi_g = [-sinMGx cosMGx MomentG];
phi_gp = [cosMGx sinMGx MomentGP];

tau_r = [cosRSx sinRSx 0];

j21 = dot(phi_rs, tau_r);

J2 = [j21 0 0; 0 1 0; 0 0 1];

constraint2LHS = [phi_rs; phi_g; phi_gp];

twistJacobian2 = inv(constraint2LHS)*J2;

twistG = twistJacobian2*vInput2;

%-------------------------------------------------

% finding the angle between JK and x
cosJKx = (K(1) - J(1))/JK;
sinJKx = (K(2) - J(2))/JK;

% finding the angle of FK with x
cosFKx = (F(1) - K(1))/KF;
sinFKx = (F(2) - K(2))/KF;

% (F(1) - G(1) - JK*cosGJK + GJ*cosMGx)/65

MomentKF = cross([F(1) F(2) 0],[cosFKx sinFKx 0]);
MomentKF = MomentKF(3);

MomentKJ = cross([J(1) J(2) 0],[cosJKx sinJKx 0]);
MomentKJ = MomentKJ(3);

MomentGJ = cross([G(1) G(2) 0],[cosMGx sinMGx 0]);
MomentGJ = MomentGJ(3);

phi_kj = [cosJKx sinJKx MomentKJ];
phi_kf = [cosFKx sinFKx MomentKF];
phi_gj = [cosMGx sinMGx MomentGJ];

% rho_g = [G(2) -G(1) 1];

j31 = dot(phi_kj,twistG);
J3 = [j31 0 0; 0 0 0; 0 0 0];

constraint3LHS = [phi_kj; phi_kf; phi_gj];

twistJacobian3 = inv(constraint3LHS)*J3;
% as j31 has already dot(phi_kj,twistG) 
inputG = [1,0,0]';
velocityK = twistJacobian3*inputG;

velocityL_dueToF = cross([0 0 velocityF(3)],[L(1) L(2) 0]);
velocityL = velocityK + velocityL_dueToF';

disp('velocityF');
disp(vpa(velocityF,5));
disp('velocityL');
disp(vpa(velocityL,5));