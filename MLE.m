function x = MLE(matrix)
w=[1,1,1;1,1,1;1,1,1];
u=matrix.*matrix;
x = conv2(u, w, 'same'); 






