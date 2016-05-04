from sqlalchemy import create_engine, Table, Column, ForeignKey, Integer, String, Text
from sqlalchemy.orm import scoped_session, sessionmaker, relationship
from sqlalchemy.ext.declarative import declarative_base

engine = create_engine('sqlite:////tmp/test.db', convert_unicode=True, echo=True)
db_session = scoped_session(sessionmaker(autocommit=False,
                                         autoflush=False,
                                         bind=engine))
Base = declarative_base()
Base.query = db_session.query_property()

subscription = Table('subscriptions', Base.metadata,
                        Column('producer_id', Integer, ForeignKey('producers.id'), nullable=False),
                        Column('consumer.id', Integer, ForeignKey('consumers.id'), nullable=False),
                        Column('format', Text))

class Producer(Base):
    """Class for things that produce events"""
    __tablename__ = 'producers'
    id = Column(Integer, primary_key=True)
    name = Column(String(140))
    description = Column(Text)
    queue_name = Column(String(50), unique=True)
    consumers = relationship('Consumer', secondary=subscription,
                                back_populates='subscriptions')

    def __init__(self, name, queue_name, description=None):
        super(Producer, self).__init__()
        self.name = name
        self.description = description
        self.queue_name = queue_name

class Consumer(Base):
    """Class for things that consume events"""
    __tablename__ = 'consumers'
    id = Column(Integer, primary_key=True)
    name = Column(String(140))
    description = Column(Text)
    subscriptions = relationship('Producer', secondary=subscription,
                                back_populates='consumers')

    def __init__(self, name, description=None):
        super(Consumer, self).__init__()
        self.name = name
        self.description = description

def init_db():
    Base.metadata.create_all(bind=engine)
