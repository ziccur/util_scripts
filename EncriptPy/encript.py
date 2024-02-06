# Libraries
from cryptography.fernet import Fernet
import os

# Initialize the list of files to encrypt
fileList= []

# Path of the directory to encrypt
directory = ""

# Files to ignore
ignore_files = ['filekey.key', 'encript.py', 'decript.py']

def key():
    # Generate Key
    key = Fernet.generate_key()
    # Save the key in a file
    with open('filekey.key', 'wb') as filekey:
        filekey.write(key)
def encript_files():
    # opening the key
    with open('filekey.key', 'rb') as filekey:
        key = filekey.read()
    
    # using the generated key
    fernet = Fernet(key)
    
    for item in fileList:
        # opening the original file to encrypt
        with open( item, 'rb') as file:
            original = file.read()
            
        # encrypting the file
        encrypted = fernet.encrypt(original)
        
        # opening the file in write mode and 
        # writing the encrypted data
        with open(item, 'wb') as encrypted_file:
            encrypted_file.write(encrypted)

def desencrypt_files():
    # using the key
    fernet = Fernet(key)
    
    # opening the encrypted file
    with open('nba.csv', 'rb') as enc_file:
        encrypted = enc_file.read()
    
    # decrypting the file
    decrypted = fernet.decrypt(encrypted)
    
    # opening the file in write mode and
    # writing the decrypted data
    with open('nba.csv', 'wb') as dec_file:
        dec_file.write(decrypted)


# Add files to the list
def add_files_to_list(path):
    for item in os.listdir(path):
        #Ignore files
        if item == ignore_files[0] or item == ignore_files[1]  or item == ignore_files[2]:
            continue
        else:
            
            #Store the files in the list 
            full_path = os.path.join(path, item)
            if os.path.isdir(full_path):
                print("["+item + " Directory]")
                #If they are in another directory, calls the function again
                add_files_to_list(full_path)
            else:
                print("["+item + " File]")
                #If is a file, append it to the list
                fileList.append(full_path)

def route():
    #Ask for the directory
    global directory
    directory = input("Enter the directory path: ")
    #Check if the directory exists
    if os.path.exists(directory):
        print("Directory exists")
    else:
        print("Directory does not exist")
        route()

def choose():
    a = input("Encript [1] or Decript [2]: ")
    if(a == "1"):
        #Calling the function
        route()
        add_files_to_list(directory)
        key()
        encript_files()
        print("Encript")
    elif(a == "2"):
        #Calling the function
        add_files_to_list(directory)
        print("Decript")
    else:
        print("Invalid option")
        choose()


choose()

#Checks
for i in fileList:
   print(i)

  #  for o in ignore_files:
  #      print(o)
