from socket import *

serverName = "192.168.1.191"#input('Destination IP address: ')
serverPort = 65530
clientSocket = socket(AF_INET, SOCK_DGRAM)
clientSocket.bind(('', 2342))
print("socket created:", clientSocket)
message = input('Input lowercase sentence: ')
clientSocket.sendto(message.encode(),(serverName, serverPort))
print("listening on IP,port: ",clientSocket.getsockname())
modifiedMessage, serverAddress = clientSocket.recvfrom(2048)
print(modifiedMessage.decode())
clientSocket.close()