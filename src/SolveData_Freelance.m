%Test Neural Network
%clear all
addpath ../
addpath ../NeuralNetwork
load('solve_data.mat')
[rows,cols] = size(Prediction_Data);
x = Prediction_Data(:,1:cols-1);
y = Prediction_Data(:,cols);

NN1 = NeuralNetwork(@SquaredError);
f2 = @(x) LogisticFunc(x);
f1 = @(x) Linear(x);
f = @(x) Quadratic(x);
%Create the layer
NN1.addLayer(Neural_Layer(cols-1,5, f1 ));

NN1.addLayer(Neural_Layer(5,1, f1 ));

NN1.addLayer(Neural_Layer(1,0, f1 ));

Y = zeros(size(y));
i = 1;

NN1.formNetwork(x,y , 100 )

for i = 1:length(y)
    Y(i,:) = NN1.feedforward(x(i,:));
end

Results = [x,Y]