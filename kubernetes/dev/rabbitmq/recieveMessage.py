# example_consumer.py
import pika, os, time

def alldcs_process_function(msg):
#  print(" ALLDCS processing")
#  print(" [x] Received " + str(msg))
  print(str(msg))

  time.sleep(1) # delays for 5 seconds
#  print(" ALLDCS processing finished");
  return;

# Access the CLODUAMQP_URL environment variable and parse it (fallback to localhost)
url = os.environ.get('CLOUDAMQP_URL', 'amqp://guest:guest@localhost:32189/%2f')
params = pika.URLParameters(url)
connection = pika.BlockingConnection(params)
channel = connection.channel() # start a channel
channel.queue_declare(queue='ALLDCS') # Declare a queue

# create a function which is called on incoming messages
def callback(ch, method, properties, body):
  alldcs_process_function(body)

# set up subscription on the queue
channel.basic_consume('ALLDCS',
  callback,
  auto_ack=True)

# start consuming (blocks)
channel.start_consuming()
connection.close()
