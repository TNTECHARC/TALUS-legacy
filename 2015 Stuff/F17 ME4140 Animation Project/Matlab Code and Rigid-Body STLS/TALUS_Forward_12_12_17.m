%TALUS
format compact
format short

syms theta1 
syms thetaR2 thetaR3 thetaR4 thetaR5 thetaR6
syms thetaL2 thetaL3 thetaL4 thetaL5 thetaL6
syms a1 a2 a4 d3 d4 d6
syms one
dtr = pi/180;
%% Calculate the Transformation Matrices

%Fixed values
a1 =  -820;  %distance from z0 to z1 along x1
a2 =  -100;  %distance from z1 to z2 along x2
a4 =   50; %For forward
%a4 = 0; %For inverse
d3 =  -200;  %distance from x2 to x3 along z2
d4 =  -700;  %distance from x3 to x4 along z3
d6 =  -800;  %distance form x5 to x6 along z5

%DH Tables
DH_R = [0     a1 0   theta1
      90*dtr  a2 0   thetaR2
      90*dtr  0  d3  thetaR3
      90*dtr  a4 d4  thetaR4
      90*dtr  0  0   thetaR5
      0       0  d6  thetaR6];
n_R = length(DH_R(:,1));

DH_L = [0     a1 0   theta1
      90*dtr  a2 0   thetaL2
      90*dtr  0  d3  thetaL3
      90*dtr  a4 d4  thetaL4
      90*dtr  0  0   thetaL5
      0       0  d6  thetaL6];
n_L = length(DH_L(:,1));

%Transformations between adjacent frames
Ti_R = one*ones(4,4,n_R);
for i = 1:n_R
    Ti_R(:,:,i) = [cos(DH_R(i,4)), -sin(DH_R(i,4))*cos(DH_R(i,1)),  sin(DH_R(i,4))*sin(DH_R(i,1)), DH_R(i,2)*cos(DH_R(i,4))
                 sin(DH_R(i,4)),  cos(DH_R(i,4))*cos(DH_R(i,1)), -cos(DH_R(i,4))*sin(DH_R(i,1)), DH_R(i,2)*sin(DH_R(i,4))
                 0,             sin(DH_R(i,1)),               cos(DH_R(i,1)),              DH_R(i,3)
                 0,             0                           0,                         1];        
end

Ti_L = one*ones(4,4,n_L);
for i = 1:n_L
    Ti_L(:,:,i) = [cos(DH_L(i,4)), -sin(DH_L(i,4))*cos(DH_L(i,1)),  sin(DH_L(i,4))*sin(DH_L(i,1)), DH_L(i,2)*cos(DH_L(i,4))
                 sin(DH_L(i,4)),  cos(DH_L(i,4))*cos(DH_L(i,1)), -cos(DH_L(i,4))*sin(DH_L(i,1)), DH_L(i,2)*sin(DH_L(i,4))
                 0,             sin(DH_L(i,1)),               cos(DH_L(i,1)),              DH_L(i,3)
                 0,             0                           0,                         1];        
end

%Transformations from base frame
T_R = one*ones(4,4,n_R);
T_R(:,:,1) = Ti_R(:,:,1);
for i = 2:n_R
    T_R(:,:,i) = T_R(:,:,i-1)*Ti_R(:,:,i);
    T_R(:,:,i)=(T_R(:,:,i));
end

T_L = one*ones(4,4,n_L);
T_L(:,:,1) = Ti_L(:,:,1);
for i = 2:n_L
    T_L(:,:,i) = T_L(:,:,i-1)*Ti_L(:,:,i);
    T_L(:,:,i)=(T_L(:,:,i));
end

%% Import STLs
L0_import = stlread('LowerStomach.stl');L1_import = stlread('Torso.stl');

LR2_import = stlread('Right_Shoulder1.stl');LR3_import = stlread('Right_Shoulder2.stl');LR4_import = stlread('Right_Bicep.stl');
LR5_import = stlread('Right_Forearm.stl');LR6_import = stlread('Right_Hand.stl');

LL2_import = stlread('Blank.stl');LL3_import = stlread('Left_Shoulder2.stl');LL4_import = stlread('Left_Bicep.stl');
LL5_import = stlread('Blank.stl');LL6_import = stlread('Left_Hand.stl');

LH2_import = stlread('NeckTop.stl');LH3_import = stlread('Face.stl');LH4_import = stlread('Jaw.stl');

%% Align Parts
%**************************************************************************
%Transformations for aligned parts
%**************************************************************************
R0 = [-1  0  0; 0  0 -1; 0 -1  0]';o0 = [-370 170 -140];
R1 = [0.4501 -0.8868 -0.105; 0.893 0.447 0.0529; 0 -0.1175 0.9931]; o1 = [265 -740 365];

RR2 = [ 0 1 0;-1 0 0;0 0 1]';oR2 = [-17 -15 -112];
RR3 = [-0.4226 -0.9062  0.0158; -0.6409  0.3111 -0.7081; 0.6409 -0.2865 -0.7122]';oR3 = [-800 900 2946];
RR4 = [0.9752 -0.0945  0.2; 0.1392  0.9649 -0.2228; -0.1720  0.2451  0.9541]';oR4 = [150 -450 200];
RR5 = [ 0.6691 -0.7431 0; -0.7431 -0.6691 0; 0 0 -1]';oR5 = [190 350 140];


RR6 = [0 -1 0; -1 0 0; 0 0 -1]';oR6 = [-134 -183 400];

RL2 = [ 1 0 0; 0 1 0; 0 0 1]'; oL2 = [0 0 0];
z1 = 18*dtr;
x1 = -48*dtr;
z2 = -29*dtr;
RL3 = [-0.4244 -0.9047 -0.038; 0.6288 -0.3249 0.7064; -0.6515 0.2758 0.7068]'; oL3 = [1492 527.5 -2885];
RL4 = [ 1 0 0; 0 1 0; 0 0 1]'; oL4 = [0 0 0];
RL5 = [ 1 0 0; 0 1 0; 0 0 1]'; oL5 = [0 0 0];
RL6 = [ 1 0 0; 0 1 0; 0 0 1]'; oL6 = [0 0 0];

RH2 = [ 1 0 0; 0 1 0; 0 0 1]'; oH2 = [0 0 0];
RH3 = [ 1 0 0; 0 1 0; 0 0 1]'; oH3 = [0 0 0];
RH4 = [ 1 0 0; 0 1 0; 0 0 1]'; oH4= [0 0 0];
%**************************************************************************
%Ln attached to frame n
%**************************************************************************
L0_o=L0_import; L1_o=L1_import;
LR2_o=LR2_import; LR3_o=LR3_import; LR4_o=LR4_import; LR5_o=LR5_import; LR6_o=LR6_import;
LL2_o=LL2_import; LL3_o=LL3_import; LL4_o=LL4_import; LL5_o=LL5_import; LL6_o=LL6_import; 
LH2_o=LH2_import; LH3_o=LH3_import; LH4_o=LH4_import;

L0_o.vertices = (R0*L0_o.vertices'+o0')'; L1_o.vertices = (R1*L1_o.vertices'+o1')';

LR2_o.vertices = (RR2*LR2_o.vertices'+oR2')';
LR3_o.vertices = (RR3*LR3_o.vertices'+oR3')';
LR4_o.vertices = (RR4*LR4_o.vertices'+oR4')';
LR5_o.vertices = (RR5*LR5_o.vertices'+oR5')';
LR6_o.vertices = (RR6*LR6_o.vertices'+oR6')';

LL2_o.vertices = (RL2*LL2_o.vertices'+oL2')';
LL3_o.vertices = (RL3*LL3_o.vertices'+oL3')';
LL4_o.vertices = (RL4*LL4_o.vertices'+oL4')';
LL5_o.vertices = (RL5*LL5_o.vertices'+oL5')';
LL6_o.vertices = (RL6*LL6_o.vertices'+oL6')';

LH2_o.vertices = (RH2*LH2_o.vertices'+oH2')';
LH3_o.vertices = (RH3*LH3_o.vertices'+oH3')';
LH4_o.vertices = (RH4*LH4_o.vertices'+oH4')';

%Copies Lno into Ln
L0=L0_o; L1=L1_o;
LR2=LR2_o; LR3=LR3_o; LR4=LR4_o; LR5=LR5_o; LR6=LR6_o;
LL2=LL2_o; LL3=LL3_o; LL4=LL4_o; LL5=LL5_o; LL6=LL6_o; 
LH2=LH2_o; LH3=LH3_o; LH4=LH4_o;

%**************************************************************************
% Patch Aligned Parts (Only for checking alignment
%**************************************************************************
close all
%{
figure(1),patch(L0_o, 'FaceAlpha', 1.0, 'EdgeColor', 'None','EdgeAlpha',1.0, ...
    'FaceColor', 0.7*[1,.5,0], 'DiffuseStrength', 1.0); light('Position', [-300 300 300] , 'Style', 'Infinite');
    xlabel('x'),ylabel('y'),zlabel('z'),axis equal
figure(2),patch(L1_o, 'FaceAlpha', 1.0, 'EdgeColor', 'None','EdgeAlpha',1.0, ...
    'FaceColor', 0.7*[1,.5,0], 'DiffuseStrength', 1.0); light('Position', [-300 300 300] , 'Style', 'Infinite');
    xlabel('x'),ylabel('y'),zlabel('z'),axis equal

figure(3),patch(LR2_o, 'FaceAlpha', 1.0, 'EdgeColor', 'None','EdgeAlpha',1.0, ...
    'FaceColor', 0.7*[1,.5,0], 'DiffuseStrength', 1.0); light('Position', [-300 300 300] , 'Style', 'Infinite');
    xlabel('x'),ylabel('y'),zlabel('z'),axis equal
figure(4),patch(LR3_o, 'FaceAlpha', 1.0, 'EdgeColor', 'None','EdgeAlpha',1.0, ...
    'FaceColor', 0.7*[1,.5,0], 'DiffuseStrength', 1.0); light('Position', [-300 300 300] , 'Style', 'Infinite');
    xlabel('x'),ylabel('y'),zlabel('z'),axis equal
figure(5),patch(LR4_o, 'FaceAlpha', 1.0, 'EdgeColor', 'None','EdgeAlpha',1.0, ...
    'FaceColor', 0.7*[1,.5,0], 'DiffuseStrength', 1.0); light('Position', [-300 300 300] , 'Style', 'Infinite');
    xlabel('x'),ylabel('y'),zlabel('z'),axis equal
figure(6),patch(LR5_o, 'FaceAlpha', 1.0, 'EdgeColor', 'None','EdgeAlpha',1.0, ...
    'FaceColor', 0.7*[1,.5,0], 'DiffuseStrength', 1.0); light('Position', [-300 300 300] , 'Style', 'Infinite');
    xlabel('x'),ylabel('y'),zlabel('z'),axis equal
%}
figure(7),patch(LR6_o, 'FaceAlpha', 1.0, 'EdgeColor', 'None','EdgeAlpha',1.0, ...
    'FaceColor', 0.7*[1,.5,0], 'DiffuseStrength', 1.0); light('Position', [-300 300 300] , 'Style', 'Infinite');
    xlabel('x'),ylabel('y'),zlabel('z'),axis equal
%{
figure(8),patch(LL2_o, 'FaceAlpha', 1.0, 'EdgeColor', 'None','EdgeAlpha',1.0, ...
    'FaceColor', 0.7*[1,.5,0], 'DiffuseStrength', 1.0); light('Position', [-300 300 300] , 'Style', 'Infinite');
    xlabel('x'),ylabel('y'),zlabel('z'),axis equal
figure(9),patch(LL3_o, 'FaceAlpha', 1.0, 'EdgeColor', 'None','EdgeAlpha',1.0, ...
    'FaceColor', 0.7*[1,.5,0], 'DiffuseStrength', 1.0); light('Position', [-300 300 300] , 'Style', 'Infinite');
    xlabel('x'),ylabel('y'),zlabel('z'),axis equal
figure(10),patch(LL4_o, 'FaceAlpha', 1.0, 'EdgeColor', 'None','EdgeAlpha',1.0, ...
    'FaceColor', 0.7*[1,.5,0], 'DiffuseStrength', 1.0); light('Position', [-300 300 300] , 'Style', 'Infinite');
    xlabel('x'),ylabel('y'),zlabel('z'),axis equal
figure(11),patch(LL5_o, 'FaceAlpha', 1.0, 'EdgeColor', 'None','EdgeAlpha',1.0, ...
    'FaceColor', 0.7*[1,.5,0], 'DiffuseStrength', 1.0); light('Position', [-300 300 300] , 'Style', 'Infinite');
    xlabel('x'),ylabel('y'),zlabel('z'),axis equal
figure(12),patch(LL6_o, 'FaceAlpha', 1.0, 'EdgeColor', 'None','EdgeAlpha',1.0, ...
    'FaceColor', 0.7*[1,.5,0], 'DiffuseStrength', 1.0); light('Position', [-300 300 300] , 'Style', 'Infinite');
    xlabel('x'),ylabel('y'),zlabel('z'),axis equal

figure(13),patch(LH2_o, 'FaceAlpha', 1.0, 'EdgeColor', 'None','EdgeAlpha',1.0, ...
    'FaceColor', 0.7*[1,.5,0], 'DiffuseStrength', 1.0); light('Position', [-300 300 300] , 'Style', 'Infinite');
    xlabel('x'),ylabel('y'),zlabel('z'),axis equal
figure(14),patch(LH3_o, 'FaceAlpha', 1.0, 'EdgeColor', 'None','EdgeAlpha',1.0, ...
    'FaceColor', 0.7*[1,.5,0], 'DiffuseStrength', 1.0); light('Position', [-300 300 300] , 'Style', 'Infinite');
    xlabel('x'),ylabel('y'),zlabel('z'),axis equal
figure(15),patch(LH4_o, 'FaceAlpha', 1.0, 'EdgeColor', 'None','EdgeAlpha',1.0, ...
    'FaceColor', 0.7*[1,.5,0], 'DiffuseStrength', 1.0); light('Position', [-300 300 300] , 'Style', 'Infinite');
    xlabel('x'),ylabel('y'),zlabel('z'),axis equal
%}
%% Use Forward Kinematics to set to 0 Position
close all
figure(1)
theta1 = 115*dtr;
thetaR2 = 155*dtr;thetaR3 = 90*dtr;thetaR4 = 180*dtr;thetaR5 =100*dtr;thetaR6 = 0;
thetaL2 = 205*dtr;thetaL3 = -90*dtr;thetaL4 = 180*dtr;thetaL5 = 100*dtr;thetaL6 = 0;

T_1 = eval(T_R(:,:,1));L1.vertices = (T_1(1:3,1:3)*L1_o.vertices'+T_1(1:3,4))';

T_R2 = eval(T_R(:,:,2));LR2.vertices = (T_R2(1:3,1:3)*LR2_o.vertices'+T_R2(1:3,4))';
T_R3 = eval(T_R(:,:,3));LR3.vertices = (T_R3(1:3,1:3)*LR3_o.vertices'+T_R3(1:3,4))';
T_R4 = eval(T_R(:,:,4));LR4.vertices = (T_R4(1:3,1:3)*LR4_o.vertices'+T_R4(1:3,4))';
T_R5 = eval(T_R(:,:,5));LR5.vertices = (T_R5(1:3,1:3)*LR5_o.vertices'+T_R5(1:3,4))';
T_R6 = eval(T_R(:,:,6));LR6.vertices = (T_R6(1:3,1:3)*LR6_o.vertices'+T_R6(1:3,4))';

T_L2 = eval(T_L(:,:,2));LL2.vertices = (T_L2(1:3,1:3)*LL2_o.vertices'+T_L2(1:3,4))';
T_L3 = eval(T_L(:,:,3));LL3.vertices = (T_L3(1:3,1:3)*LL3_o.vertices'+T_L3(1:3,4))';
T_L4 = eval(T_L(:,:,4));LL4.vertices = (T_L4(1:3,1:3)*LL4_o.vertices'+T_L4(1:3,4))';
T_L5 = eval(T_L(:,:,5));LL5.vertices = (T_L5(1:3,1:3)*LL5_o.vertices'+T_L5(1:3,4))';
T_L6 = eval(T_L(:,:,6));LL6.vertices = (T_L6(1:3,1:3)*LL6_o.vertices'+T_L6(1:3,4))';

patch(L0, 'FaceAlpha', 1.0, 'EdgeColor', 'None','EdgeAlpha',1.0, ...
       'FaceColor', 0.7*[1,.5,0], 'DiffuseStrength', 1.0);
patch(L1, 'FaceAlpha', 1.0, 'EdgeColor', 'None','EdgeAlpha',1.0, ...
       'FaceColor', 0.7*[1,.5,0], 'DiffuseStrength', 1.0);
patch(LR2, 'FaceAlpha', 1.0, 'EdgeColor', 'None','EdgeAlpha',1.0, ...
    'FaceColor', 0.7*[1,.5,0], 'DiffuseStrength', 1.0);
patch(LR3, 'FaceAlpha', 1.0, 'EdgeColor', 'None','EdgeAlpha',1.0, ...
    'FaceColor', 0.7*[1,.5,0], 'DiffuseStrength', 1.0);
patch(LR4, 'FaceAlpha', 1.0, 'EdgeColor', 'None','EdgeAlpha',1.0, ...
    'FaceColor', 0.7*[1,.5,0], 'DiffuseStrength', 1.0);
patch(LR5, 'FaceAlpha', 1.0, 'EdgeColor', 'None','EdgeAlpha',1.0, ...
    'FaceColor', 0.7*[1,.5,0], 'DiffuseStrength', 1.0);
patch(LR6, 'FaceAlpha', 1.0, 'EdgeColor', 'None','EdgeAlpha',1.0, ...
    'FaceColor', 0.7*[1,.5,0], 'DiffuseStrength', 1.0);
%{
patch(LL2, 'FaceAlpha', 1.0, 'EdgeColor', 'None','EdgeAlpha',1.0, ...
    'FaceColor', 0.7*[1,.5,0], 'DiffuseStrength', 1.0);
patch(LL3, 'FaceAlpha', 1.0, 'EdgeColor', 'None','EdgeAlpha',1.0, ...
    'FaceColor', 0.7*[1,.5,0], 'DiffuseStrength', 1.0);
patch(LL4, 'FaceAlpha', 1.0, 'EdgeColor', 'None','EdgeAlpha',1.0, ...
    'FaceColor', 0.7*[1,.5,0], 'DiffuseStrength', 1.0);
patch(LL5, 'FaceAlpha', 1.0, 'EdgeColor', 'None','EdgeAlpha',1.0, ...
    'FaceColor', 0.7*[1,.5,0], 'DiffuseStrength', 1.0);
patch(LL6, 'FaceAlpha', 1.0, 'EdgeColor', 'None','EdgeAlpha',1.0, ...
    'FaceColor', 0.7*[1,.5,0], 'DiffuseStrength', 1.0);
%}
axis equal
light('Position', [-300 300 300] , 'Style', 'Infinite');
xlabel('x'), ylabel('y'), zlabel('z')

%% Animate

n_R = 2;
t = 0.001;
inc = 1;
sgn2 = 1;sgn3 = 1;sgn4 = 1;sgn5 = -1;sgn = 1;
while(1)
    figure(2)
    theta1 = theta1 + 15*pi/180;
    
    if (thetaR2 <= 130*dtr)||(thetaR2 >= 160*dtr)
        sgn2 = -sgn2;
    end
    thetaR2 = thetaR2 + inc*sgn2*dtr;
    if (thetaR3 <= 0*dtr)||(thetaR3 >= 90*dtr)
        sgn3 = -sgn3;
    end
    thetaR3 = thetaR3 + inc*sgn3*dtr;
    if (thetaR4 <= 70*dtr)||(thetaR4 >= 160*dtr)
        sgn4 = -sgn4;
    end
    thetaR4 = thetaR4 + inc*sgn4*dtr;
    if (thetaR5 <= 100*dtr)||(thetaR5 >= 160*dtr)
        sgn5 = -sgn5;
    end
    
    T_1 = eval(T_R(:,:,1));L1.vertices = (T_1(1:3,1:3)*L1_o.vertices'+T_1(1:3,4))';
    T_R2 = eval(T_R(:,:,2));LR2.vertices = (T_R2(1:3,1:3)*LR2_o.vertices'+T_R2(1:3,4))';
    T_R3 = eval(T_R(:,:,3));LR3.vertices = (T_R3(1:3,1:3)*LR3_o.vertices'+T_R3(1:3,4))';
    T_R4 = eval(T_R(:,:,4));LR4.vertices = (T_R4(1:3,1:3)*LR4_o.vertices'+T_R4(1:3,4))';
    T_R5 = eval(T_R(:,:,5));LR5.vertices = (T_R5(1:3,1:3)*LR5_o.vertices'+T_R5(1:3,4))';
    T_R6 = eval(T_R(:,:,6));LR6.vertices = (T_R6(1:3,1:3)*LR6_o.vertices'+T_R6(1:3,4))';
    %{
    T_L2 = eval(T_L(:,:,2));LL2.vertices = (T_L2(1:3,1:3)*LL2_o.vertices'+T_L2(1:3,4))';
    T_L3 = eval(T_L(:,:,3));LL3.vertices = (T_L3(1:3,1:3)*LL3_o.vertices'+T_L3(1:3,4))';
    T_L4 = eval(T_L(:,:,4));LL4.vertices = (T_L4(1:3,1:3)*LL4_o.vertices'+T_L4(1:3,4))';
    T_L5 = eval(T_L(:,:,5));LL5.vertices = (T_L5(1:3,1:3)*LL5_o.vertices'+T_L5(1:3,4))';
    T_L6 = eval(T_L(:,:,6));LL6.vertices = (T_L6(1:3,1:3)*LL6_o.vertices'+T_L6(1:3,4))';
    %}
    clf(2)
    patch(L0, 'FaceAlpha', 1.0, 'EdgeColor', 'None','EdgeAlpha',1.0, ...
       'FaceColor', 0.7*[1,.5,0], 'DiffuseStrength', 1.0);
    patch(L1, 'FaceAlpha', 1.0, 'EdgeColor', 'None','EdgeAlpha',1.0, ...
           'FaceColor', 0.7*[1,.5,0], 'DiffuseStrength', 1.0);
    patch(LR2, 'FaceAlpha', 1.0, 'EdgeColor', 'None','EdgeAlpha',1.0, ...
        'FaceColor', 0.7*[1,.5,0], 'DiffuseStrength', 1.0);
    patch(LR3, 'FaceAlpha', 1.0, 'EdgeColor', 'None','EdgeAlpha',1.0, ...
        'FaceColor', 0.7*[1,.5,0], 'DiffuseStrength', 1.0);
    patch(LR4, 'FaceAlpha', 1.0, 'EdgeColor', 'None','EdgeAlpha',1.0, ...
        'FaceColor', 0.7*[1,.5,0], 'DiffuseStrength', 1.0);
    patch(LR5, 'FaceAlpha', 1.0, 'EdgeColor', 'None','EdgeAlpha',1.0, ...
        'FaceColor', 0.7*[1,.5,0], 'DiffuseStrength', 1.0);
    patch(LR6, 'FaceAlpha', 1.0, 'EdgeColor', 'None','EdgeAlpha',1.0, ...
        'FaceColor', 0.7*[1,.5,0], 'DiffuseStrength', 1.0);
    %{
    patch(LL2, 'FaceAlpha', 1.0, 'EdgeColor', 'None','EdgeAlpha',1.0, ...
        'FaceColor', 0.7*[1,.5,0], 'DiffuseStrength', 1.0);
    patch(LL3, 'FaceAlpha', 1.0, 'EdgeColor', 'None','EdgeAlpha',1.0, ...
        'FaceColor', 0.7*[1,.5,0], 'DiffuseStrength', 1.0);
    patch(LL4, 'FaceAlpha', 1.0, 'EdgeColor', 'None','EdgeAlpha',1.0, ...
        'FaceColor', 0.7*[1,.5,0], 'DiffuseStrength', 1.0);
    patch(LL5, 'FaceAlpha', 1.0, 'EdgeColor', 'None','EdgeAlpha',1.0, ...
        'FaceColor', 0.7*[1,.5,0], 'DiffuseStrength', 1.0);
    patch(LL6, 'FaceAlpha', 1.0, 'EdgeColor', 'None','EdgeAlpha',1.0, ...
        'FaceColor', 0.7*[1,.5,0], 'DiffuseStrength', 1.0);
    %}
    axis equal
    light('Position', [-300 300 300] , 'Style', 'Infinite');
    xlabel('x'), ylabel('y'), zlabel('z')
    
    pause(t)
end

%% Inverse

%Joint 4 is wrist center
%Will assume a4 = 0 to obtain spherical wrist
%{
r11 = 0; r12 = -1; r13 = 0; 
r21 = -0.9848; r22 = 0; r23 = -0.1736;
r31 = 0.1736; r32 = 0; r33 = -0.9848;
x = 546.547; y = 209.638; z = 816.6308;
T_spec = [r11 r12 r13 x;
    r21 r22 r23 y;
    r31 r32 r33 z;
    0 0 0 1];

%End effector position
p_ee = [x;y;z];

%Wrist center position
p_c = p_ee - T_spec(1:3,3)*d6;
 xp = p_c(1);
 yp = p_c(2);
 zp = p_c(3);

%Joint 4 is wrist center
eqn1 = xp == T(1,4,4);
eqn2 = yp == T(2,4,4);
eqn3 = zp == T(3,4,4);

%Since eqn3 has only theta3, we can solve for it
theta3_1 = acos(-zp/d4)*180/pi;
theta3_2 = -acos(-zp/d4)*180/pi;

 if (theta3_1<=105)&&(theta3_1>=-105)&&(imag(theta3_1)==0)
     theta3 = theta3_1;
 elseif (theta3_2<=105)&&(theta3_2>=-105)&&(imag(theta3_2)==0)
     theta3 = theta3_2;
 else
     error('Position/Orientation not reachable or error in Inverse Kinematics.');
 end

%Square and add eqn1 and eqn2 to leave only theta2
eqn4 = T(1,4,4);
eqn5 = T(2,4,4);
eqn6 = simplify(eqn4^2+eqn5^2);
eqn7 = xp^2+yp^2 == eqn6;

%Apply CST #6 to find theta2
a=2*a1*d3;
b=2*a1*a2+2*a1*d4*sin(theta3);
c=xp^2+yp^2-a1^2-d3^2+d4^2*cos(theta3)^2-2*a2*d4*sin(theta3);
t1 = (2*a+sqrt(4*a^2-4*(c+b)*(c-b)))/(2*(c+b));
t2 = (2*a-sqrt(4*a^2-4*(c+b)*(c-b)))/(2*(c+b));

%Theta2 has two answers since we used the quadratic formula
theta2_1 = 2*atan(t1)*180/pi;
theta2_2 = 2*atan(t2)*180/pi;

 if (theta2_1<=170)&&(theta2_1>=115)&&(imag(theta2_1)==0)
     theta2 = theta2_1
 elseif (theta2_2<=170)&&(theta2_2>=115)&&(imag(theta2_2)==0)
     theta2 = theta2_2
 else
     error('Position/Orientation not reachable or error in Inverse Kinematics.');
 end

%Apply CST #6 to find theta1
a=-a2*sin(theta2)+d3*cos(theta2)-d4*sin(theta2)*sin(theta3);
b=a2*cos(theta2)+d3*sin(theta2)+a1+d4*sin(theta3)*cos(theta2);
c=xp;
t1 = (2*a+sqrt(4*a^2-4*(c+b)*(c-b)))/(2*(c+b));
t2 = (2*a-sqrt(4*a^2-4*(c+b)*(c-b)))/(2*(c+b));

theta1_1 = 2*atan(t1)*180/pi;
theta1_2 = 2*atan(t2)*180/pi;

 if (theta1_1<=145)&&(theta1_1>=85)&&(imag(theta1_1)==0)
     theta1 = theta1_1
 elseif (theta1_2<=145)&&(theta1_2>=85)&&(imag(theta1_2)==0)
     theta1 = theta1_2
 else
     error('Position/Orientation not reachable or error in Inverse Kinematics.');
 end

%Solving for the wrist
R0_3 = T(1:3,1:3,3);
R0_6 = T_spec(1:3,1:3);
R3_6knowns = simplify(transpose(R0_3)*R0_6);
T3_6 = simplify(Ti(:,:,4)*Ti(:,:,5)*Ti(:,:,6));
R3_6FK = T3_6(1:3,1:3);
eqn8 = R3_6knowns(3,3) == R3_6FK(3,3);

%This implies theta5 is:
theta5_1 = acos(-R3_6knowns(3,3));
theta5_1 = eval(theta5_1)*180/pi;
theta5_2 = -acos(-R3_6knowns(3,3));
theta5_2 = eval(theta5_2)*180/pi;

 if (theta5_1<=145)&&(theta5_1>=60)&&(imag(theta5_1)==0)
     theta5 = theta5_1
 elseif (theta5_2<=145)&&(theta5_2>=60)&&(imag(theta5_2)==0)
     theta5 = theta5_2
 else
     error('Position/Orientation not reachable or error in Inverse Kinematics.');
 end

%Using CST #5 to solve for theta4
theta4 = atan2(R3_6knowns(2,3)/sin(theta5),R3_6knowns(1,3)/sin(theta5));
theta4 = eval(theta4)

%Using CST #5 to solve for theta6
theta6 = atan2(-R3_6knowns(3,2)/sin(theta5),R3_6knowns(3,1)/sin(theta5));
theta6 = eval(theta6)
%}