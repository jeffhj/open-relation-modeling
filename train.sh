NAME=k_path_large
WARMUP_UPDATES=1000      
LR=5e-05
MAX_TOKENS=1024
UPDATE_FREQ=16
# BART_PATH=./bart/bart.base/model.pt
BART_PATH=./bart/bart.large/model.pt

CUDA_VISIBLE_DEVICES=0,1,2 fairseq-train "input/$NAME-bin" \
    --restore-file $BART_PATH \
    --reset-optimizer --reset-dataloader --reset-meters \
    --max-epoch 50 \
    --max-tokens $MAX_TOKENS \
    --save-dir tmp/$NAME \
    --no-epoch-checkpoints \
    --task translation \
    --source-lang src --target-lang tgt \
    --layernorm-embedding \
    --share-all-embeddings \
    --share-decoder-input-output-embed \
    --reset-optimizer --reset-dataloader --reset-meters \
    --required-batch-size-multiple 1 \
    --arch bart_large \
    --criterion label_smoothed_cross_entropy \
    --label-smoothing 0.1 \
    --dropout 0.1 --attention-dropout 0.1 \
    --weight-decay 0.001 --optimizer adam --adam-betas "(0.9, 0.999)" --adam-eps 1e-08 \
    --clip-norm 0.1 \
    --lr-scheduler inverse_sqrt --lr $LR --warmup-updates $WARMUP_UPDATES \
    --update-freq $UPDATE_FREQ \
    --skip-invalid-size-inputs-valid-test \
    --find-unused-parameters \
    --fp16 
