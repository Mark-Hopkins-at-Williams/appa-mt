#!/usr/bin/env bash
#
# Adapted from https://github.com/facebookresearch/MIXER/blob/master/prepareData.sh

BPE_TOKENS=2000

###########
# THIS PART OF THE CODE FIGURES OUT THE DIRECTORY OF THE SHELL SCRIPT.
# THIS IS SOMEWHAT COMPLICATED WHEN WE RUN THROUGH SLURM.
# check if script is started via SLURM or bash
# if with SLURM: there variable '$SLURM_JOB_ID' will exist
# `if [ -n $SLURM_JOB_ID ]` checks if $SLURM_JOB_ID is not an empty string
if [ -n $SLURM_JOB_ID ];  then
    # check the original location through scontrol and $SLURM_JOB_ID
    SCRIPT_COMMAND=$(scontrol show job $SLURM_JOBID | awk -F= '/Command=/{print $2}')
else
    # otherwise: started with bash. Get the real location.
    SCRIPT_COMMAND=$(realpath $0)
fi
SCRIPT_COMMAND_ARRAY=($SCRIPT_COMMAND)
SCRIPT_NAME=${SCRIPT_COMMAND_ARRAY[0]}
SCRIPT_PATH=$(dirname $SCRIPT_NAME)
#
###########

BPEROOT=$SCRIPT_PATH/subword-nmt/subword_nmt

src=fr
tgt=en
lang=fr-en
orig=$1/data
prep=$1/data-tokenized

mkdir -p $prep

TRAIN=$orig/train.en-fr
BPE_CODE=$prep/code
rm -f $TRAIN
for l in $src $tgt; do
    cat $orig/train.$l >> $TRAIN
done

echo "learn_bpe.py on ${TRAIN}..."
python $BPEROOT/learn_bpe.py -s $BPE_TOKENS < $TRAIN > $BPE_CODE

for L in $src $tgt; do
    for f in train.$L dev.$L test.$L; do
        echo "apply_bpe.py to ${f}..."
        python $BPEROOT/apply_bpe.py -c $BPE_CODE < $orig/$f > $prep/$f
    done
done
