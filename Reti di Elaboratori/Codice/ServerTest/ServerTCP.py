from socket import *
from os import *

serverPort = 12000
serverSocket = socket(AF_INET,SOCK_STREAM)  # create TCP welcoming socket
serverSocket.bind(('',serverPort))
serverSocket.listen(1)                      # server begins listening forincoming TCP requests
print "Server Welcome Socket is ready to receive"

try:
  while True:
    connectionSocket, addr = serverSocket.accept()  # server waits on accept() for incoming requests, new socket created on return
    pid = fork()

    if pid == 0:
      while True:
        sentence = connectionSocket.recv(1024).decode()
        capitalizedSentence = sentence.upper()                  # read bytes from connection socket (but not address as in UDP)
        if capitalizedSentence == "STOP":
          print("TCP connection closed")
          break
        connectionSocket.send(capitalizedSentence.encode())
        connectionSocket.listen(1)

    else:


  connectionSocket.close()