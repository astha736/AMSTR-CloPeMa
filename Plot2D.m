function [] = Plot2D(A,B,C,D,E,F,G,J,K,S,R,L,M,O)
%%%%%%%%%%%%%%% Plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1)
% MJ 
plot([M(1) J(1)],[M(2) J(2)],'r');
hold on
% KJ
plot([K(1) J(1)],[K(2) J(2)],'r');
hold on
% KF
plot([K(1) F(1)],[K(2) F(2)],'r');
hold on
% LF
plot([L(1) F(1)],[L(2) F(2)],'g');
hold on
% EF
plot([E(1) F(1)],[E(2) F(2)],'r');
hold on
% DE
plot([D(1) E(1)],[D(2) E(2)],'r');
hold on
% CE
plot([C(1) E(1)],[C(2) E(2)],'r');
hold on
% CB
plot([C(1) B(1)],[C(2) B(2)],'r');
hold on
% OB
plot([O(1) B(1)],[O(2) B(2)],'k');
hold on
% OA
plot([O(1) A(1)],[O(2) A(2)],'k');
hold on
% DA
plot([D(1) A(1)],[D(2) A(2)],'r');
hold on
% RS
plot([R(1) S(1)],[R(2) S(2)],'b');
hold on
% GS
plot([G(1) S(1)],[G(2) S(2)],'r');
hold on 

%%% plotting the points of the mechanism 
X = [C(1) D(1) E(1) F(1) G(1) J(1) K(1) S(1) R(1)];
Y = [C(2) D(2) E(2) F(2) G(2) J(2) K(2) S(2) R(2)];
% labels = {'C','D','E','F','G','J','K','S','R'};
scatter(X,Y,'o','r');
hold on 
scatter(X,Y,'+','r');
hold on 
% text(X,Y,labels);
% hold on 
scatter([O(1) O(1)],[O(2) + 10,O(2) - 10] ,'s','k');
hold on 
scatter((R(1)+S(1))/2,(R(2)+S(2))/2 ,'s','b')
hold on
scatter(O(1),O(2),'x','k');
hold on 

plot([0 0],[-100 100],'k--');
hold on 
plot([-100 200],[0 0],'k--');
hold off
end

