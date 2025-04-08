function R=DRNN(A,B)

FS=[0 0 0 0 0;0 1 1 1 0; 0 1 0 1 0; 0 1 1 1 0; 0 0 0 0 0];
FI=[1 1 1 0 0; 1 1 0 0 1;1 1 0 1 1; 1 0 0 1 1; 0 0 1 1 1];
alpha_e=0.001;
phi_c=1.2;
h=0.28;
alpha_p=0.7;
V_S=1;
V_E=30;
alpha=1.5;

[p,q]=size(A);
P=zeros(p,q);
Z=zeros(p,q);
E=ones(p,q);

XSA = V_S*conv2(A,FS,'same');
XSB = V_S*conv2(B,FS,'same');

iteration_times=200;

for n=1:iteration_times
    XIA = alpha*conv2(Z,FI,'same')+A;
    XIB = alpha*conv2(Z,FI,'same')+B;
    PA=XSA-(1/phi_c)*XIA+h;
    PB=XSB-(1/phi_c)*XIB+h;
    map=(PA>=PB);
    PI=map.*PA+~map.*PB;
    P = exp(-alpha_p) * P + PI;
    Z = im2double( P > E );
    E = exp(-alpha_e) * E + V_E * Z;  
end


R =(PA>=PB);
end


