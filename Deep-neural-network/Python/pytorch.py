import numpy
from sklearn.preprocessing import normalize, scale
from sklearn.metrics import r2_score
from sklearn.preprocessing import minmax_scale
from datetime import datetime
import torch.nn as nn
import torch
import torch.nn.functional as F
import torch.optim as optim
from torch.utils.data import DataLoader
from torch.utils.data.dataset import Dataset,TensorDataset
#from torch.tensor import FloatTensor



device="cpu"
num_epochs=10
batch_size=128
log_interval=10

class ManipulatorDataset(Dataset):

    def __init__(self, feature, label):
        super(ManipulatorDataset, self).__init__()
        self.feature=feature
        self.label=label
        


    def __getitem__(self, index):
            return self.feature[index,:], self.label[index,:]


    def __len__(self):
        return len(self.feature[:,0])






numpy.random.seed(7)
Xtrain=numpy.loadtxt('feature.csv',dtype='float',delimiter=',')
Ytrain=numpy.loadtxt('label.csv',dtype='float',delimiter=',')
#Xtrain=X[0:50000,:]
#Ytrain=Y[0:50000,:]
#Ｙtrain=minmax_scale(Ytrain, feature_range=(0, 1), axis=0, copy=True)
Xtrain=normalize(Xtrain,axis=1)
#Xtrain = scale( Xtrain, axis=0, with_mean=True, with_std=True, copy=True )
#Ytrain = scale( Ytrain, axis=0, with_mean=True, with_std=True, copy=True )
print(Xtrain)
Xtest=numpy.loadtxt('feature_test.csv',dtype='float',delimiter=',')
Ytest=numpy.loadtxt('label_test.csv',dtype='float',delimiter=',')
#Ｙtest=minmax_scale(Ytest, feature_range=(0, 1), axis=0, copy=True)
Xtest=normalize(Xtest,axis=1)
#Xtest = scale( Xtest, axis=0, with_mean=True, with_std=True, copy=True )
#Ytest = scale( Ytest, axis=0, with_mean=True, with_std=True, copy=True )
#print(type(Xtrain))
#print(type(Ytrain))

train_dataset=ManipulatorDataset(Xtrain,Ytrain)
test_dataset=ManipulatorDataset(Xtest,Ytest)

train_loader = DataLoader(
    train_dataset,
    batch_size=batch_size, shuffle=True)
test_loader = DataLoader(
    test_dataset,
    batch_size=batch_size, shuffle=True)

class Net(nn.Module):
    def __init__(self):
        super(Net, self).__init__()
        num_points = 84


        self.feature = nn.Sequential(
            nn.Linear(num_points, 64),
            nn.PReLU(num_parameters=1, init=0.25),
            nn.BatchNorm1d(64),
            nn.Dropout(p=0.1, inplace=False),
            nn.Linear( 64,  128),
            nn.PReLU(num_parameters=1, init=0.25),
            nn.BatchNorm1d(128),
            nn.Dropout(p=0.1, inplace=False),
            nn.Linear(128,  256),
            nn.PReLU(num_parameters=1, init=0.25),
            nn.BatchNorm1d(256),
            nn.Dropout(p=0.1, inplace=False),
            nn.Linear(256,  512),
            nn.PReLU(num_parameters=1, init=0.25),
            nn.BatchNorm1d(512),
            nn.Dropout(p=0.1, inplace=False),
            nn.Linear(512,  256),
            nn.PReLU(num_parameters=1, init=0.25),
            nn.BatchNorm1d(256),
            nn.Linear(256,  128),
            nn.PReLU(num_parameters=1, init=0.25),
            nn.BatchNorm1d(128),
            nn.Linear(128,   64),
            nn.PReLU(num_parameters=1, init=0.25),
        )

        self.sigmoid = nn.Sequential(
            nn.Linear(64, 9261),
            nn.Sigmoid()
        )
        # self.target = nn.Sequential(
        #     nn.nn.Linear(64, 3)
        # )


    def forward(self, x):
        x = self.feature(x)
        sigmoid  = self.sigmoid(x).view(-1)

        return sigmoid


    """
    def set_mode(self, mode ):
        self.mode = mode
        if mode in ['eval', 'valid', 'test']:
            self.eval()
        elif mode in ['train']:
            self.train()
        else:
            raise NotImplementedError
    """

model = Net().to(device)

optimizer = optim.SGD(model.parameters(), lr=0.01, momentum=0.01)
optimizer = optim.Adam(model.parameters())

def train(epoch):
    model.train()
    for batch_idx, (data, target) in enumerate(train_loader):
        data, target = data.to(device), target.to(device)
        optimizer.zero_grad()
        output = model(data)
        #loss = F.nll_loss(output, target)
        loss = F.binary_cross_entropy_with_logits(output, target)
        loss.backward()
        optimizer.step()
        if batch_idx % log_interval == 0:
            print('Train Epoch: {} [{}/{} ({:.0f}%)]\tLoss: {:.6f}'.format(
                epoch, batch_idx * len(data), len(train_loader.dataset),
                100. * batch_idx / len(train_loader), loss.item()))

def test():
    model.eval()
    test_loss = 0
    correct = 0
    with torch.no_grad():
        for data, target in test_loader:
            data, target = data.to(device), target.to(device)
            output = model(data)
            test_loss += F.binary_cross_entropy_with_logits(output, target, size_average=False).item() # sum up batch loss
            #pred = output.max(1, keepdim=True)[1] # get the index of the max log-probability
            correct += output.eq(target.view_as(output)).sum().item()

    test_loss /= len(test_loader.dataset)
    print('\nTest set: Average loss: {:.4f}, Accuracy: {}/{} ({:.0f}%)\n'.format(
        test_loss, correct, len(test_loader.dataset),
        100. * correct / len(test_loader.dataset)))


for epoch in range(1, num_epochs + 1):
    train(epoch)
    test()
