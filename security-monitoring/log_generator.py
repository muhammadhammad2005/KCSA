import json,time,random,datetime
while True:
    log = {
      "event":"login",
      "success": random.choice([True,False]),
      "ip": f"192.168.1.{random.randint(1,254)}",
      "time": datetime.datetime.now().isoformat()
    }
    with open("logs/security.log","a") as f:
        f.write(json.dumps(log)+"\n")
    time.sleep(1)
