from app import db, app
from models import Students, Subjects
import random

first_names = ['hamisi', 'shehe', 'shafii', 'mudi', 'hasan', 'juma', 'elia', 'seleman']
last_names = ['ali', 'mohamed', 'omar', 'juma', 'abubakar', 'rashid', 'abdalla', 'bakar']
programs = ['SE1', 'CS1', 'CE1', 'SNICE']

subject_data = [
    ('LG 102', 'Communication Skills', 'year 1'),
    ('CP 111', 'Principles of Programming Languages', 'year 1'),
    ('DS 102', 'Development Perspectives', 'year 1'),
    ('IT 111', 'Introduction to Information Technology', 'year 1'),
    ('TN 112', 'Linear Algebra for ICT', 'year 1'),
    ('TN 111', 'Discrete Mathematics for ICT', 'year 1'),
    ('IA 112', 'Mathematical Foundations of Information Security', 'year 1'),
    ('TN 113', 'Calculus', 'year 1'),
]

def seed():
    with app.app_context():
        db.drop_all()
        db.create_all()

        for _ in range(5):  # 5 students
            student = Students(
                first_name=random.choice(first_names),
                last_name=random.choice(last_names),
                program=random.choice(programs)
            )
            db.session.add(student)
            db.session.commit()

            # Assign 2 to 4 random subjects to each student
            selected_subjects = random.sample(subject_data, k=random.randint(2, 4))
            for course_code, course_name, year in selected_subjects:
                subject = Subjects(
                    course_code=course_code,
                    course_name=course_name,
                    year=year,
                    student_id=student.id
                )
                db.session.add(subject)

        db.session.commit()
        print("Seeding completed!")

if __name__ == '__main__':
    seed()
