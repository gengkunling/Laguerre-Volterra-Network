# Lagurerre-Volterra-Network (LVN)
The LVN is an advanced method to analyze time seires data and the nonlinear dynamic relationships in the systems. 

LVN combines the idea of Laguerre kernel expansions with Artificial Neural Network (ANN). The Laguerre kernel expansions can be viewed as 1-D convolutional layer in the time domain. 

Unlike Long short-term memory (LSTM) network, LVN is very compact and can learn the nonlinear dynamic patterns from a very limited amount of data. 

## To run this program:

### 1.	Generate Data 
Run [data_gen.m](data_gen.m) to generate the training data [data.mat](data.mat).

### 2.	Show the True System that Generates the Data
Run [trueSystem.m](trueSystem.m). It will display the true PDMs, ANFs, first order and second order kernels.

### 3.	Train LVN
Run [LVN_main.m](LVN_main.m). The program will use the data from [data.mat](data.mat) and optimize the sparse LVN using simulated annealing algorithm.  The training results are summarized in [results.mat](results.mat). 

## If you are looking for using Autoregressive-LVN to train Hodgkin-Huxley Equations:
Please go to: [https://github.com/gengkunling/ASLVN](https://github.com/gengkunling/ASLVN)

## If you find this code useful, please cite:

[Geng, K., & Marmarelis, V. Z. (2015). Pattern recognition of Hodgkin-Huxley equations by auto-regressive Laguerre Volterra network. BMC Neuroscience, 16(Suppl 1), P156.](https://www.researchgate.net/profile/Kunling_Geng/publication/287346598_Pattern_recognition_of_Hodgkin-Huxley_equations_by_auto-regressive_Laguerre_Volterra_network/links/5692cea108aec14fa55da757.pdf?origin=publication_detail)

[Geng, K., & Marmarelis, V. Z. (2016). Methodology of Recurrent Laguerre-Volterra Network for Modeling Nonlinear Dynamic Systems. IEEE Transactions on Neural Networks and Learning Systems.](https://www.researchgate.net/publication/304403209_Methodology_of_Recurrent_Laguerre-Volterra_Network_for_Modeling_Nonlinear_Dynamic_Systems)

