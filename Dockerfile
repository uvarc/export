FROM ubuntu:20.04

RUN apt update && apt -y install python3 python3-pip

ENV BASEDIR="/weka"
ENV ID="472"
ENV USER="weka"

RUN adduser --home $BASEDIR --uid $ID --disabled-password --gecos "Weka User" $USER

WORKDIR $BASEDIR

COPY requirements.txt $BASEDIR

RUN pip3 install --no-cache-dir -r $BASEDIR/requirements.txt

COPY export.py $BASEDIR
COPY maps.py $BASEDIR
COPY lokilogs.py $BASEDIR
COPY collector.py $BASEDIR
COPY async_api.py $BASEDIR

EXPOSE 8001

WORKDIR $BASEDIR

USER $USER
ENTRYPOINT ["python3", "/weka/export.py"]