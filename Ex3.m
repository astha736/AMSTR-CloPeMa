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
EF = 17;
DF = DE + EF;
FL = 133;
KL = KF + FL;

rs = 95;

G = [44.6, -22.5];
R = [-40.9, 38];

dMin = 6;
dMax = 10;

rMin = 0;
rMax = 10;


% 6 -> 10 -> 6
signalJ1a1 = linspace(6,10,21);
signalJ1a1_reverse = signalJ1a1(1:20);
signalJ1a1_reverse = flip(signalJ1a1_reverse);
signalJ1A1 = [signalJ1a1 signalJ1a1_reverse];
signalJ1A1 = [signalJ1A1 signalJ1A1(2:41)];

% 10 -> 6 -> 10
signalJ1a2 = linspace(6,10,21);
signalJ1a2_reverse = signalJ1a2(2:21);
signalJ1a2_reverse = flip(signalJ1a2_reverse);
signalJ1A2 = [signalJ1a2_reverse signalJ1a2];
signalJ1A2 = [signalJ1A2 signalJ1A2(2:41)];

% 0 -> 10 -> 0
signalJ2 = linspace(0,10,21);
signalJ2_reverse = signalJ2(1:20);
signalJ2_reverse = flip(signalJ2_reverse);
signalJ2 = [signalJ2 signalJ2_reverse];
signalJ2 = [signalJ2 signalJ2(2:41)];

% plot(time, signalJ2);

% signalJ1A = signalJ1A1; %simulation1
signalJ1A = signalJ1A2; %simulation1
signalJ1B = -signalJ1A;

time = linspace(0,10,81);