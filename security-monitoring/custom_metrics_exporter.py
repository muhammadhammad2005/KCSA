from prometheus_client import start_http_server, Counter
import random,time

failed = Counter('security_failed_logins_total','failed')

start_http_server(8000)
while True:
    if random.random() < 0.4:
        failed.inc()
    time.sleep(2)
