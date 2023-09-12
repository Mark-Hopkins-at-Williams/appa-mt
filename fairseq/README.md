NMT on appa using fairseq
-------------------------

### Training

To train a fairseq NMT transformer using data:

sbatch train.sh WORK_DIR DATA_DIR

where:
- WORK_DIR is where you want to store the trained model (the directory does not have to already exist)
- DATA_DIR is where to find the training data (see /home/data/mt_data/tpo/eng-nah-svo/data for an example of how the data directory should be structured)


