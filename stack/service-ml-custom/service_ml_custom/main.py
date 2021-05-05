import tensorflow_hub as hub
import tensorflow as tf
from sentence_transformers import SentenceTransformer, util

from libtelemetry.main import main as lib_one_main

model = hub.load('https://tfhub.dev/google/universal-sentence-encoder/4')


def main():
    lib_one_main()


if __name__ == '__main__':
    main()
