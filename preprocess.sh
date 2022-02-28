export DATA=k_path
export NAME=k_path_large
export TEXT=input/$NAME
mkdir -p $TEXT

cp ./$DATA/train.src ./$TEXT/train.src
cp ./$DATA/train.tgt ./$TEXT/train.tgt
cp ./$DATA/dev.src ./$TEXT/dev.src
cp ./$DATA/dev.tgt ./$TEXT/dev.tgt
cp ./$DATA/test.src ./$TEXT/test.src
cp ./$DATA/test.tgt ./$TEXT/test.tgt


for SPLIT in train dev test
do
  for LANG in src tgt
  do
    python multiprocessing_bpe_encoder.py \
    --encoder-json encoder.json \
    --vocab-bpe vocab.bpe \
    --inputs "./$TEXT/$SPLIT.$LANG" \
    --outputs "./$TEXT/$SPLIT.bpe.$LANG" \
    --workers 30 \
    --keep-empty;
  done
done


# base
# fairseq-preprocess   --source-lang "src"   --target-lang "tgt" --trainpref "./$TEXT/train.bpe" --validpref "./$TEXT/dev.bpe" --testpref "./$TEXT/test.bpe"  --destdir "./$TEXT-bin/"   --workers 30   --srcdict dict-base.txt   --tgtdict dict-base.txt

# large
fairseq-preprocess   --source-lang "src"   --target-lang "tgt" --trainpref "./$TEXT/train.bpe" --validpref "./$TEXT/dev.bpe" --testpref "./$TEXT/test.bpe"  --destdir "./$TEXT-bin/"   --workers 30   --srcdict dict.txt   --tgtdict dict.txt