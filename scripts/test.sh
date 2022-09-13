#!/bin/bash
for i in 1 2 3
do
docker ps -f name=t4re
TASK_TMP_DIR=TASK_$$_$(date +"%N")
echo "====== TASK $TASK_TMP_DIR started ======"
docker exec -it t4re mkdir \-p ./$TASK_TMP_DIR/

echo "Start $i.png"
docker cp ./ocr-files/$i.png t4re:/home/work/$TASK_TMP_DIR/
#docker cp ./ocr-files/1400.png t4re:/home/work/$TASK_TMP_DIR/

docker exec -it t4re /bin/bash -c "mkdir -p ./$TASK_TMP_DIR/out/; cd ./$TASK_TMP_DIR/out/; tesseract ../$i.png $i -l deu --psm 1 --oem 3 pdf hocr"
mkdir -p ./ocr-files/output/$TASK_TMP_DIR/
docker cp t4re:/home/work/$TASK_TMP_DIR/out/ ./ocr-files/output/$TASK_TMP_DIR/
docker exec -it t4re rm \-r ./$TASK_TMP_DIR/
docker exec -it t4re ls
echo "Done $i.png"
echo "====== Result files was copied to ./ocr-files/output/$TASK_TMP_DIR/ ======"
done
