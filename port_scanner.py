import socket
f=open("LOCATION OF THE FILE","THE FUNCTION")
target = "scanme.nmap.org"
ports= [21,22,80,443,8080]
OPorts=[]
f.write("Results\n")
for i in ports :
    s=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
    s.settimeout(1)
    output=s.connect_ex((target,i))
    if output==0:
        P=socket.getservbyport(i)
        OPorts.append((i,P))
        output1=f"[+] port {i} is open\n"
    else:
        output1=f"[-] port {i} is closed\n"
    f.write(output1)

for i,P in OPorts:
    f.write(f"service used in this open port {i} is : {P}\n")
f.close()
s.close()
