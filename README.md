# Lagurerre-Volterra-Network (LVN)
The LVN is an advanced method to analyze input output relationship in the nonlinear dynamic systems. LVN combines the idea of Laguerre kernel expansions with the connectionist modeling notion of Artificial Neural Network (ANN).

## To run this program:

1.	Generate Data 
Run [data_gen.m](data_gen.m) to generate the training data data.mat.

2.	Show the True System that Generates the Data
Run [trueSystem.m](trueSystem.m). It will display the true PDMs, ANFs, first order and second order kernels.

3.	Train LVN
Run [LVN_main.m](LVN_main.m). The program will use the data from [data.mat](data.mat) and optimize the sparse LVN using simulated annealing algorithm.  The training results are summarized in [results.mat]. 

## Using Autoregressive-LVN to train Hodgkin-Huxley Equation:
Please go to: [https://github.com/gengkunling/ASLVN](https://github.com/gengkunling/ASLVN)

## If you find this code useful, please cite:

[Geng, K., & Marmarelis, V. Z. (2015). Pattern recognition of Hodgkin-Huxley equations by auto-regressive Laguerre Volterra network. BMC Neuroscience, 16(Suppl 1), P156.](https://www.researchgate.net/profile/Kunling_Geng/publication/287346598_Pattern_recognition_of_Hodgkin-Huxley_equations_by_auto-regressive_Laguerre_Volterra_network/links/5692cea108aec14fa55da757.pdf?origin=publication_detail)

[Geng, K., & Marmarelis, V. Z. (2016). Methodology of Recurrent Laguerre-Volterra Network for Modeling Nonlinear Dynamic Systems. IEEE Transactions on Neural Networks and Learning Systems.](https://www.researchgate.net/publication/304403209_Methodology_of_Recurrent_Laguerre-Volterra_Network_for_Modeling_Nonlinear_Dynamic_Systems)

