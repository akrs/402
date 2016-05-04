from utils.db import Producer, Consumer, init_db, db_session

init_db()

p = Producer('Fridge Door', 'Fires when someone opens the fridge door can\'t have them stealing snacks yo', 'fridge_door')

c = Consumer('Kitchen Alarm', 'Ear splitting alarm in the kitchen')
c1 = Consumer('Text Message', 'Send me a text message')

p.consumers = [c, c1]

db_session.add(p)
db_session.add(c)
db_session.add(c1)
db_session.commit()
