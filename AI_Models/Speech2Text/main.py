import whisper

model = whisper.load_model("base")
result = model.transcribe("VideoTest.mkv", language = "zh", fp16 = False)

with open("VideoTranscription.txt", "w") as f:
    f.write(result["text"])