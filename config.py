import os

SQLALCHEMY_DATABASE_URI = os.getenv('SQLALCHEMY_DATABASE_URI', 'mysql+pymysql://root:@db/assignment')
SQLALCHEMY_TRACK_MODIFICATIONS = False
