from openai import OpenAI
client = OpenAI()

audio_file= open("Thinking Out Loud.wav", "rb")
transcript = client.audio.transcriptions.create(
  model="whisper-1", 
  file=audio_file
)