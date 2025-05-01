from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class Students(db.Model):
    __tablename__ = 'students'

    id = db.Column(db.Integer, primary_key=True)
    first_name = db.Column(db.String(100), nullable=False)
    last_name = db.Column(db.String(100), nullable=False)
    program = db.Column(db.String(100))

    subjects = db.relationship('Subjects', backref='student', lazy=True)

    def __repr__(self):
        return f"<Students {self.first_name} {self.last_name}>"

class Subjects(db.Model):
    __tablename__ = 'subjects'

    id = db.Column(db.Integer, primary_key=True)
    course_name = db.Column(db.String(100), nullable=False)
    course_code = db.Column(db.String(10), nullable=False)
    year = db.Column(db.String(100))

    student_id = db.Column(db.Integer, db.ForeignKey('students.id'), nullable=False)

    def __repr__(self):
        return f"<Subjects {self.course_code}>"
