import json
fails={}
for line in open("logs/security.log"):
    l=json.loads(line)
    if not l["success"]:
        fails[l["ip"]] = fails.get(l["ip"],0)+1
print("Failed logins:")
for ip,c in fails.items():
    if c>=3:
        print("SUSPICIOUS",ip,c)
