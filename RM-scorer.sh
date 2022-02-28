echo BLEU
cat $1 | sacrebleu --width 4 $2
echo

echo ROUGE
rouge -f -a $1 $2 --stats F --ignore_empty
echo

echo METEOR
java -Xmx2G -jar ./meteor/meteor-*.jar $1 $2 -norm -lower -noPunct | tail -10
echo

echo BERTSCORE
bert-score -r $2 -c $1 --lang en --model roberta-large-mnli
echo
