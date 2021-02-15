 function TE()


%% Units
micro = 10^(-6);
pico = 10^(-12);
aem = 87;

%% Specifications
Vdd = 1.8+0.003 * aem; 
Vss = -Vdd;
Cl = (2+0.01*aem)*pico;
SR = (18+0.01*aem) *1/micro; 
GB = (7+0.01*aem)*10^6;
A = (20+0.01*aem); 
P = (50+0.01*aem); 

%% Transistor's Values
kp       = 2.9352 * 10^(-5);
kn       = 9.6379 * 10^(-5);
uop      = 180.2*10^-4;
uon      = 591.7*10^-4;
Cox      = kp/uop
VToP     = -0.9056;
VToN     = 0.7860;
Vin_max   = 0.1;
Vin_min   = - Vin_max;
lp       = 0.05;
ln       = 0.04;

%% step 1
l = 1 * micro;

%% step 2
Cc = 0.22 * Cl;

%% step 3
I5 = Cc * SR;

%% step 4
S3 = I5 /(kn * (Vdd - Vin_max - abs(VToP) - VToN)^2 ); 
if S3 < 1 
    S3 = 1 ;
    I5 = (kn * (Vdd - Vin_max - abs(VToP) - VToN)^2 ); 
end
S4 = S3;

%% step 5
p3=sqrt(kn*S3*I5)/(2*0.667*S3*(l^2)*Cox);
if((p3/(2*pi))<10*GB)
    disp('Caution: p3 must be more than 10 GB')
end

%% step 6
gm1 = 2 * pi* GB * Cc; % [2*pi -> rad]
gm2 = gm1;
S1 = gm1^2 / (kp*I5);
S2 = S1;

%% step 7
Vds5_sat = Vin_min - Vss - sqrt(I5/(S1*kp))-abs(VToP) ;
S5 = 2 * I5 /(kp *Vds5_sat^2);

%% step 8
gm6 = 2.2 * gm2 * Cl/Cc;
gm4 = sqrt(2*kn*S4*I5)/2;
S6 = S4*gm6/gm4;
I6 = (gm6)^2 / (2* kn*S6);

%% step 9
%  Alternative step for step 8 -> not needed
%  Vds6 = Vdd-Vout_max;
%  S6 = gm6/(Kn*Vds6);
%  I6 = (gm6)^2 / (2* kn*S6);

%% step 10
S7 = I6*S5/I5;

%% step 11
Av = 2*gm2*gm6 / (I5*(lp+ln)*I6*(ln+lp));
Pdiss = (I5+I6)*(Vdd + abs(Vss));
if(Av>A)
    disp('Av > A !! -> A is ok')
end
if(Pdiss<P)
    disp('Pdiss < P !! -> P is ok')
end

%% W's Values
W1 = S1 * l;
W2 = S2 * l;
W3 = S3 * l;
W4 = S4 * l;
W5 = S5 * l;
W6 = S6 * l;
W7 = S7 * l;
W8 = W5;

%% Results Display
disp('  ')
disp(' *VALUES* ')
disp(['l = ', num2str(l)])
disp(['W1 = ', num2str(W1)])
disp(['W2 = ', num2str(W2)])
disp(['W3 = ', num2str(W3)])
disp(['W4 = ', num2str(W4)])
disp(['W5 = ', num2str(W5)])
disp(['W6 = ', num2str(W6)])
disp(['W7 = ', num2str(W7)])
disp(['W8 = ', num2str(W5)])
disp('  ')
disp(['Vdd = ', num2str(Vdd), ' V'])
disp(['Vss = ', num2str(Vss), ' V'])
disp(['Cl = ', num2str(Cl), ' F']) 
disp(['Cc = ', num2str(Cc), ' F'])
disp(['SR > ', num2str(SR), ' V/s'])
disp(['GB > ', num2str(GB), ' Hz'])
disp(['A > ', num2str(A), ' dB'])
disp(['P < ', num2str(P), ' mW']) 
disp(['I5 = ', num2str(I5), ' A'])









