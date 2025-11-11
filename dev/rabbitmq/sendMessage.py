# example_publisher.py
import pika, os, logging
logging.basicConfig()

# Parse CLODUAMQP_URL (fallback to localhost)
url = os.environ.get('CLOUDAMQP_URL', 'amqp://guest:guest@localhost:32189/%2f')
params = pika.URLParameters(url)
params.socket_timeout = 5

connection = pika.BlockingConnection(params) # Connect to CloudAMQP
channel = connection.channel() # start a channel
channel.queue_declare(queue='ALLDCS') # Declare a queue
# send a message

channel.basic_publish(exchange='', routing_key='ALLDCS', body='Hello Diederick, lets go hack!!!')
print ("[x] Message sent to consumer")
connection.close()
