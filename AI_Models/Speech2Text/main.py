import whisper

model = whisper.load_model("base")
result = model.transcribe("Thinking Out Loud.wav", fp16 = False)

with open("SoundTranscription.txt", "w") as f:
    f.write(result["text"])