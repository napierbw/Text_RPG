import os

file = open('ascii.txt')
if os.path.exists("Output.txt"):
  os.remove("Output.txt")
else:
  print("Output.txt didn't exist")
text_file = open("Output.txt", "w")

j=0
try:
    line = file.readline()
    while line != '':   # The EOF char is an empty string
        text_file.write("echo ")
        for letter in line:
            if letter.isspace():
                text_file.write(letter)
            else:
                text_file.write('^')
                text_file.write(letter)
        line = file.readline()
finally:
    file.close()
    text_file.close()