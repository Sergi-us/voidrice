#!/usr/bin/env python3
# TODO Experementelles Projekt für Spracheingabe

import sounddevice as sd
import vosk
import queue
import sys
import json

# model = vosk.Model("/home/sergi/vosk-model-de/vosk-model-small-de-0.15")
model = vosk.Model("/home/sergi/vosk-model-de/vosk-model-de-0.6")
recognizer = vosk.KaldiRecognizer(model, 16000)
q = queue.Queue()

def callback(indata, frames, time, status):
    if status:
        print(status, file=sys.stderr)
    q.put(bytes(indata))

with sd.RawInputStream(samplerate=16000, blocksize=8000, dtype='int16', channels=1, callback=callback):
    print("Spracheingabe läuft...")
    while True:
        data = q.get()
        if recognizer.AcceptWaveform(data):
            result = json.loads(recognizer.Result())
            print(result["text"])
        else:
            partial = json.loads(recognizer.PartialResult())
            print(partial["partial"])
