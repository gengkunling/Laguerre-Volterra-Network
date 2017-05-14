# Lagurerre-Volterra-Network
# To run this program:

1.	Generate Data 
Run data_gen.m to generate the training data data.mat.

2.	Show the True System that Generates the Data
Run trueSystem.m. It will display the true PDMs, ANFs, first order and second order kernels.

3.	Train LVN
Run LVN_main.m. The program will use the data from data.mat and optimize the sparse LVN using simulated annealing algorithm.  The training results are summarized in results.mat. 
 
