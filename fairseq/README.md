NMT on appa using fairseq
-------------------------

### Training

To train a fairseq NMT transformer using data:

sbatch train.sh WORK_DIR DATA_DIR SRC TGT NUM_EPOCHS

where:
- WORK_DIR is where you want to store the trained model (the directory does not have to already exist)
- DATA_DIR is where to find the training data (see /home/data/mt_data/tpo/eng-ger-svo/data for an example of how the data directory should be structured)
- SRC is the file suffix for the source language files
- TGT is the file suffix for the target language files
- NUM_EPOCHS is the desired number of training epochs

For instance, to train a German-English MT model on artificial data:

sbatch train.sh my_train_dir /home/data/mt_data/tpo/eng-ger-svo/data de en 100


