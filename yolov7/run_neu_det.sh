#!/bin/bash


configs=cfg/training/yolov7-e6e.yaml
hyperparams=data/hyp.scratch.p6.yaml
data_yaml=data/neu_det.yaml
tl_weights=yolov7-e6e_training.pt #Transfer learning weights
testDir_root=test/
name=yolov7-e6e_100
batch_size=32
img_size=200
epochs=100

stage=${1:-0} # start from 0 if not specified in command line

#Finetuning step (training yolov6 with our datasets on top of coco-based weights)
if [ $stage -le 0 ]; then
	 python  train_aux.py   --name $name \
	                          --batch $batch_size\
	                          --img $img_size \
							  --epochs $epochs \
	                          --data $data_yaml \
	                          --workers 20 \
                              --cfg $configs \
							  --weights $tl_weights \
							  --hyp $hyperparams \
							  --device 0 

fi 
#Evaluation on validation dataset

echo "-----------------------------Training finished. Starting evaluation...-----------------------------"

if [ $stage -le 1 ]; then
	python3 test.py --batch $batch_size \
	                     --img $img_size \
	                     --data $data_yaml \
	                     --weights runs/train/$name/weights/best.pt \
	                     --task val \
	                     --name $name \
						 --verbose 
						 


fi

echo "----------------------------Evaluation finished. Starting inference...----------------------------"

#Inference on test dataset

if [ $stage -le 2 ]; then
	python detect.py --weights runs/train/$name/weights/best.pt \
	                      --source $testDir_root \
	                      --save-txt \
	                      --project runs/infer \
	                      --name $name 
fi

echo "----------------------------Inference finished.----------------------------"