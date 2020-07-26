function [model]=load_model(Label,Features) 

%call svm training for modelling from labelled dataset
training_label_vector=load(Label);
training_instance_matrix=load(Features);
model = svmtrain(training_label_vector, training_instance_matrix,'-c 65536 -g 4.92458 -b 1');

disp('Training Model Generated');