FILES=./images/*
for FILE in $FILES ; do mkdir -p result/$FILE; 


MODEL_PATH=upp-resnet50-upernet
RESULT_PATH=./result/$FILE

ENCODER=$MODEL_PATH/encoder_epoch_40.pth
DECODER=$MODEL_PATH/decoder_epoch_40.pth

if [ ! -e $ENCODER ]; then
  mkdir $MODEL_PATH
fi
if [ ! -e $ENCODER ]; then
  wget -P $MODEL_PATH http://sceneparsing.csail.mit.edu/model/unified_perceptual_parsing/$ENCODER
fi
if [ ! -e $DECODER ]; then
  wget -P $MODEL_PATH http://sceneparsing.csail.mit.edu/model/unified_perceptual_parsing/$DECODER
fi
if [ ! -e $TEST_IMG ]; then
  wget -P $RESULT_PATH http://sceneparsing.csail.mit.edu//data/ADEChallengeData2016/images/validation/$TEST_IMG
fi

python3 -u test.py \
  --model_path $MODEL_PATH \
  --test_img $FILE \
  --arch_encoder resnet50 \
  --arch_decoder upernet \
  --result $RESULT_PATH \
  --gpu_id 0

done
