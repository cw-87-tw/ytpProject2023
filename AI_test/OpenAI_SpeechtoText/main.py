import whisper

model = whisper.load_model("base")
result = model.transcribe("Thinking Out Loud.wav")

with open("Transcription.txt", "w") as f:
    f.write(result["text"])