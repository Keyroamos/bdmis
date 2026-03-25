import sqlite3
import random
from datetime import datetime, date

def generate_student():
    conn = sqlite3.connect('db.sqlite3')
    cursor = conn.cursor()

    # Find next admission number
    cursor.execute("SELECT admission_number FROM schools_student WHERE admission_number NOT LIKE '%\_%' ESCAPE '\\' ORDER BY CAST(admission_number AS INTEGER) DESC LIMIT 1;")
    last_num = cursor.fetchone()
    if last_num:
        next_num = int(last_num[0]) + 1
    else:
        next_num = 7000  # Default starting point if not found

    # Get random grade with fees
    cursor.execute("SELECT id, name, term1_fees, term2_fees, term3_fees FROM schools_grade WHERE term1_fees > 0")
    grades = cursor.fetchall()
    grade = random.choice(grades)
    grade_id, grade_name, t1, t2, t3 = grade

    # Random data
    first_names = ["James", "Mary", "John", "Patricia", "Robert", "Jennifer", "Michael", "Linda"]
    last_names = ["Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller", "Davis"]
    
    first_name = random.choice(first_names)
    last_name = random.choice(last_names)
    gender = random.choice(['M', 'F'])
    
    # Birth date (between 5 and 15 years ago)
    year = 2026 - random.randint(5, 15)
    month = random.randint(1, 12)
    day = random.randint(1, 28)
    dob = f"{year}-{month:02d}-{day:02d}"
    
    created_at = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    updated_at = created_at
    
    location = random.choice(['MAIN', 'ANNEX'])
    
    # Insert student
    columns = [
        "admission_number", "first_name", "last_name", "date_of_birth", "gender",
        "parent_name", "parent_phone", "parent_email", "parent_occupation", "parent_id_number",
        "academic_year", "created_at", "updated_at",
        "term_fees", "current_term", "grade_id",
        "term1_fees", "term2_fees", "term3_fees",
        "location"
    ]
    
    values = [
        str(next_num), first_name, last_name, dob, gender,
        f"{last_name} Parent", f"+25470000{random.randint(100, 999)}", f"{first_name.lower()}@example.com", "Business", "12345678",
        "2026", created_at, updated_at,
        t1, 1, grade_id,
        t1, t2, t3,
        location
    ]
    
    placeholders = ", ".join(["?"] * len(values))
    sql = f"INSERT INTO schools_student ({', '.join(columns)}) VALUES ({placeholders})"
    
    try:
        cursor.execute(sql, values)
        conn.commit()
        print(f"Successfully added student: {first_name} {last_name} with admission number {next_num} in grade {grade_name}.")
    except Exception as e:
        print(f"Error: {e}")
    finally:
        conn.close()

if __name__ == "__main__":
    generate_student()
