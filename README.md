# Lagurerre-Volterra-Network
## To run this program:

1.	Generate Data 
Run data_gen.m to generate the training data data.mat.

2.	Show the True System that Generates the Data
Run trueSystem.m. It will display the true PDMs, ANFs, first order and second order kernels.

3.	Train LVN
Run LVN_main.m. The program will use the data from data.mat and optimize the sparse LVN using simulated annealing algorithm.  The training results are summarized in results.mat. 


## If you find this code useful, please cite:

Geng, K., & Marmarelis, V. Z. (2015). Pattern recognition of Hodgkin-Huxley equations by auto-regressive Laguerre Volterra network. BMC Neuroscience, 16(Suppl 1), P156.

Geng, K., & Marmarelis, V. Z. (2016). Methodology of Recurrent Laguerre-Volterra Network for Modeling Nonlinear Dynamic Systems. IEEE Transactions on Neural Networks and Learning Systems.

