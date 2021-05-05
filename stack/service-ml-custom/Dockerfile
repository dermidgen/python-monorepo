FROM nvidia/cuda:10.1-cudnn7-runtime-ubuntu18.04

ARG DEBIAN_FRONTEND=noninteractive
RUN \
  apt-get update && apt-get install -y \
  apt-utils wget curl \
  build-essential cmake git pkg-config \
  python-pip python3-pip python3.7 python3.7-dev && \
  rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.7 1
RUN pip install --upgrade pip

COPY ./deps/*.whl ./
RUN pip install *.whl && rm -rf *.whl

COPY ./*.whl ./
RUN pip install *.whl && rm -rf *.whl

CMD ["python", "-m", "service_ml_custom.main"]
