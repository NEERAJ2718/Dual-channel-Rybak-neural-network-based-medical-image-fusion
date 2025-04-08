function [F]=Medical_Fusion(A,B)

addpath(genpath('Shearlet_Transform'));


pfilt = 'maxflat';
shear_parameters.dcomp =[3,3,4,4];
shear_parameters.dsize =[8,8,16,16];

%NSST Decomposition

[y1,shear_f1]=nsst_dec2(A,shear_parameters,pfilt);
[y2,shear_f2]=nsst_dec2(B,shear_parameters,pfilt);



Fused=y1;

ALow1= y1{1};
BLow1 =y2{1};

%  Fusion of Low-pass Subbands

A1=Pixel_Force(ALow1);
AL=MLE(A1);
B1=Pixel_Force(BLow1);
BL=MLE(B1);
map=AL>=BL;

Fused{1}=map.*ALow1+~map.*BLow1;  

 
 
        
%Fusion of High-pass Sub-bands
for m=2:length(shear_parameters.dcomp)+1
    temp=size((y1{m}));temp=temp(3);
    for n=1:temp
        Ahigh=y1{m}(:,:,n);
        Bhigh=y2{m}(:,:,n);
        
                AH=abs(Ahigh);
                BH=abs(Bhigh);
                map=DRNN(AH,BH);  %Improved Dual Channel PCNN (IDCPCNN)
                Fused{m}(:,:,n)=map.*Ahigh+~map.*Bhigh;
        
    end
end


%Inverse NSST Transform
F=nsst_rec2(Fused,shear_f1,pfilt);
        

end








