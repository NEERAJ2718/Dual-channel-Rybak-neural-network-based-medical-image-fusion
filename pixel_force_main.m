function force = pixel_force_main(k, o, ds) %ds represents the square distance

 beta=0.001;
 K=10;
 d=abs(k-o)+beta;


 force=10*((k+beta)*(o+beta))/(d*ds);





end

