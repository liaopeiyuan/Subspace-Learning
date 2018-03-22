# Subspace Learning - a Deep Neural Network Algorithm

ICCAIRO 2018 Candidate

An algorithm that learns pertinent subspaces of the original high-dimensional distribution mapping

Original Paper: Deep neural network based subspace learning of robotic manipulator workspace mapping

## Abstract:
The manipulator workspace mapping is an important problem in robotics
and has attracted significant attention in the community. However, most
of the pre-existing algorithms have expensive time complexity due to the
reliance on sophisticated kinematic equations. To solve this problem,
this paper introduces subspace learning (SL), a variant of subspace
embedding, where a set of robot and scope parameters is mapped to the
corresponding workspace by a deep neural network (DNN). Trained on a
large dataset of around **6** **×** **10**<sup>**4**</sup> samples
obtained from a MATLAB implementation of a classical method and sampling
of designed uniform distributions, the experiments demonstrate that the
embedding significantly reduces run-time from
**5.23** **×** **10**<sup>**3**</sup> s of traditional discretization
method to **0.224** s, with high accuracies (average F-measure is
**0.9665** with batch gradient descent and resilient backpropagation).