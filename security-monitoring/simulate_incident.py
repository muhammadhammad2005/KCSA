import json,time
for i in range(15):
    log={
      "event":"login",
      "success":False,
      "ip":"192.168.1.100"
    }
    with open("logs/security.log","a") as f:
        f.write(json.dumps(log)+"\n")
    time.sleep(0.3)
