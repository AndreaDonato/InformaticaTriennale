from ftplib import FTP

# Connetti al server FTP
ftp = FTP("192.168.1.191")
ftp.login(user="Andrea", passwd="12345")

while True:
    choice = input("Elenca (E), Aggiungi (A) o Scarica (S) un file, altimenti chiudi la connessione (X) - ")

    if(choice == 'X'): break

    elif (choice == 'E'):
        # Elenca i file nella directory corrente del server
        print("Elenco dei file nella directory corrente: ")
        ftp.retrlines("LIST")


    elif (choice == 'S'):
        # Scarica un file dal server
        file_name = input("nome_del_file_da_scaricare: ")
        with open(file_name, "wb") as f:
            ftp.retrbinary("RETR " + file_name, f.write)

    elif (choice == 'A'):
        # Carica un file sul server
        file_name = input("nome_del_file_da_aggiungere: ")
        with open(file_name, "rb") as f:
            ftp.storbinary("STOR " + file_name, f)

# Chiudi la connessione FTP
ftp.quit()