import psycopg2

def check_teachers():
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
        cur.execute("SELECT employee_ptr_id FROM schools_teacher;")
        teachers = [t[0] for t in cur.fetchall()]
        print(f"Teachers IDs: {teachers}")
        cur.close()
        conn.close()
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    check_teachers()
