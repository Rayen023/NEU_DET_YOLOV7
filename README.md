# NET_DET_YOLOV7


=============================================================

### Setup Virtual environment

=============================================================

1. Installing miniconda3 : 
    1. Download the Miniconda installer to your Home directory.
`wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh`
    2. Install Miniconda quietly, accepting defaults, to your Home directory.
`bash ~/miniconda.sh -b -p`
    3. Remove the Miniconda installer from your Home directory.
`rm ~/miniconda.sh`
----------------------------------------------

2. Activating environment :
    1. activate conda for this session
`source $HOME/miniconda3/bin/activate`

    2. Creating environment : #Skip if env already created
`conda create --name yolo_defect --file reauirements.txt python=3.8`

    3. Activating the environment : 
`conda activate yolo_defect`

----------------------------------------------

3. Usefull Commands :
- for deactivating :
`conda deactivate`

- to list created environments :
`conda env list`

=============================================================

### Setting Up YOLOv7 : 

=============================================================

1. Installing YOLOv7
```
git clone https://github.com/WongKinYiu/yolov7.git 
cd yolov7
pip install -r requirements.txt
```

=============================================================

### COnverting from xml format to YOLO format : 

=============================================================

1. If dataset is in xml format run convert_voc_to_yolo.py file else skip this step
NOTE : Some changes to file direcories, class names MIGHT need to be added
`python3 convert_voc_to_yolo.py`


2. Move YOLO Dataset under yolov7/data
Directory Structure :

<pre>
yolov7/
    data/
        labels/
            train/
                Photo_00001.txt
                Photo_00002.txt
            validation/
                Photo_00001.txt
                Photo_00002.txt
        images/
            train/
                Photo_00001.jpg
                Photo_00002.jpg
            validation/
                Photo_00001.jpg
                Photo_00002.jpg
        neu_det.yaml
</pre>

3. Create .yaml file
example : 
```
train: "/home/rayen/projects/NET_DET_YOLOV7/yolov7/data/images/train"
val: "/home/rayen/projects/NET_DET_YOLOV7/yolov7/data/images/validation"

nc: 6
names: ['pitted_surface', 'rolled-in_scale',"scratches","crazing","inclusion","patches"]
```


=============================================================

### Using YOLOv6 v3 : 

=============================================================

1. `cd yolov7/` 

2. modify configuration as needed under ./run_neu_det.sh: 
```
configs=cfg/training/yolov7-tiny.yaml # Model
hyperparams=data/hyp.scratch.tiny.yaml # Default Model Hypermarameters
data_yaml=data/neu_det.yaml # data yaml file
testDir_root=test/ # Test Dataset
name=yolov7-tiny_256_300 # Directory where trained model and results will be saved
batch_size=256 # Total batch size
img_size=200 # image size 
epochs=300 # num of epochs
```

3. Add executable permissions to Shell script :
`sudo chmod +x ./run_neu_det.sh` 

4. For training / Evaluation / inference :

    1. `run ./run_neu_det.sh`

    2. For Evaluation / Inference:
    `run ./run_neu_det.sh 1`

    2. For Inference :
    `run ./run_neu_det.sh 2`

NOTE : for inference move own Test Data under yolov7/test



