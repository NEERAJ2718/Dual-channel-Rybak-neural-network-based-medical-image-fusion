function R=Pixel_Force(A)
A1=im2double(A);

h=size(A1,1); 
w=size(A1,2);
g=zeros(h,w);
ATemp=zeros(h+2,w+2);
ATemp(2:h+1,2:w+1)=A1;

   for i=2: (h+1)
        for j=2: (w+1)
        %  //First assignment for RGB values before each loop
        mask=zeros(1,9) ;

       
     
          for b=1:9;
          [x]=ikomsu(b,i);
          [y]=jkomsu(b,j);
                            
                        mask (b) =ATemp(x,y); 
                                     
          end
          squaredistance=[2 1 2 1 1 2 1 2];
           
force=0;
force_sum=0;

              for k=1:8
                  
                    force=pixel_force_main(mask(9),mask(k),squaredistance(k));
                    
                   force_sum=force_sum+force;
                   
               end

R(i-1,j-1)=force_sum;   
 
     end
   end


   