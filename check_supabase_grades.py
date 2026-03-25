import psycopg2

def check_grades():
    host = 'aws-1-eu-west-1.pooler.supabase.com'
    dbname = 'postgres'
    user = 'postgres.ouwwhqebjrkojesuyfvv'
    password = '9260@Keyro20'
    port = '5432'
    
    try:
        conn = psycopg2.connect(
            host=host,
            dbname=dbname,
            user=user,
            password=password,
            port=port,
            sslmode='require'
        )
        cur = conn.cursor()
        cur.execute("SELECT id, name, term1_fees FROM schools_grade;")
        grades = cur.fetchall()
        print(f"Grades found: {len(grades)}")
        for grade in grades:
            print(grade)
        cur.close()
        conn.close()
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    check_grades()
