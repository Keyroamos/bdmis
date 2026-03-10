CREATE TABLE IF NOT EXISTS "django_migrations" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "app" varchar(255) NOT NULL, "name" varchar(255) NOT NULL, "applied" datetime NOT NULL);
CREATE TABLE sqlite_sequence(name,seq);
CREATE TABLE IF NOT EXISTS "auth_group_permissions" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "group_id" integer NOT NULL REFERENCES "auth_group" ("id") DEFERRABLE INITIALLY DEFERRED, "permission_id" integer NOT NULL REFERENCES "auth_permission" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE IF NOT EXISTS "auth_user_groups" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "user_id" integer NOT NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "group_id" integer NOT NULL REFERENCES "auth_group" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE IF NOT EXISTS "auth_user_user_permissions" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "user_id" integer NOT NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "permission_id" integer NOT NULL REFERENCES "auth_permission" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE UNIQUE INDEX "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" ("group_id", "permission_id");
CREATE INDEX "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" ("group_id");
CREATE INDEX "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" ("permission_id");
CREATE UNIQUE INDEX "auth_user_groups_user_id_group_id_94350c0c_uniq" ON "auth_user_groups" ("user_id", "group_id");
CREATE INDEX "auth_user_groups_user_id_6a12ed8b" ON "auth_user_groups" ("user_id");
CREATE INDEX "auth_user_groups_group_id_97559544" ON "auth_user_groups" ("group_id");
CREATE UNIQUE INDEX "auth_user_user_permissions_user_id_permission_id_14a6b632_uniq" ON "auth_user_user_permissions" ("user_id", "permission_id");
CREATE INDEX "auth_user_user_permissions_user_id_a95ead1b" ON "auth_user_user_permissions" ("user_id");
CREATE INDEX "auth_user_user_permissions_permission_id_1fbb5f2c" ON "auth_user_user_permissions" ("permission_id");
CREATE TABLE IF NOT EXISTS "django_admin_log" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "object_id" text NULL, "object_repr" varchar(200) NOT NULL, "action_flag" smallint unsigned NOT NULL CHECK ("action_flag" >= 0), "change_message" text NOT NULL, "content_type_id" integer NULL REFERENCES "django_content_type" ("id") DEFERRABLE INITIALLY DEFERRED, "user_id" integer NOT NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "action_time" datetime NOT NULL);
CREATE INDEX "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" ("content_type_id");
CREATE INDEX "django_admin_log_user_id_c564eba6" ON "django_admin_log" ("user_id");
CREATE TABLE IF NOT EXISTS "django_content_type" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "app_label" varchar(100) NOT NULL, "model" varchar(100) NOT NULL);
CREATE UNIQUE INDEX "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" ("app_label", "model");
CREATE TABLE IF NOT EXISTS "auth_permission" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "content_type_id" integer NOT NULL REFERENCES "django_content_type" ("id") DEFERRABLE INITIALLY DEFERRED, "codename" varchar(100) NOT NULL, "name" varchar(255) NOT NULL);
CREATE UNIQUE INDEX "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" ("content_type_id", "codename");
CREATE INDEX "auth_permission_content_type_id_2f476e4b" ON "auth_permission" ("content_type_id");
CREATE TABLE IF NOT EXISTS "auth_group" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(150) NOT NULL UNIQUE);
CREATE TABLE IF NOT EXISTS "auth_user" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "password" varchar(128) NOT NULL, "last_login" datetime NULL, "is_superuser" bool NOT NULL, "username" varchar(150) NOT NULL UNIQUE, "last_name" varchar(150) NOT NULL, "email" varchar(254) NOT NULL, "is_staff" bool NOT NULL, "is_active" bool NOT NULL, "date_joined" datetime NOT NULL, "first_name" varchar(150) NOT NULL);
CREATE TABLE IF NOT EXISTS "schools_school" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(200) NOT NULL, "category" varchar(3) NOT NULL, "address" text NOT NULL, "phone" varchar(20) NOT NULL, "email" varchar(254) NOT NULL, "website" varchar(200) NOT NULL, "motto" varchar(200) NOT NULL, "logo" varchar(100) NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE IF NOT EXISTS "schools_leave" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "leave_type" varchar(20) NOT NULL, "start_date" date NOT NULL, "end_date" date NOT NULL, "reason" text NOT NULL, "status" varchar(20) NOT NULL, "approved_date" datetime NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "approved_by_id" integer NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "employee_id" bigint NOT NULL REFERENCES "schools_employee" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE IF NOT EXISTS "schools_deduction" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "type" varchar(20) NOT NULL, "amount" decimal NOT NULL, "description" varchar(200) NOT NULL, "salary_id" bigint NOT NULL REFERENCES "schools_salary" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE IF NOT EXISTS "schools_allowance" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "type" varchar(20) NOT NULL, "amount" decimal NOT NULL, "description" varchar(200) NOT NULL, "salary_id" bigint NOT NULL REFERENCES "schools_salary" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE IF NOT EXISTS "schools_teacher_subjects" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "teacher_id" bigint NOT NULL REFERENCES "schools_teacher" ("employee_ptr_id") DEFERRABLE INITIALLY DEFERRED, "subject_id" bigint NOT NULL REFERENCES "schools_subject" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE INDEX "schools_leave_approved_by_id_3e4ca239" ON "schools_leave" ("approved_by_id");
CREATE INDEX "schools_leave_employee_id_d762bafd" ON "schools_leave" ("employee_id");
CREATE INDEX "schools_deduction_salary_id_5b107780" ON "schools_deduction" ("salary_id");
CREATE INDEX "schools_allowance_salary_id_de8f9f47" ON "schools_allowance" ("salary_id");
CREATE UNIQUE INDEX "schools_teacher_subjects_teacher_id_subject_id_3915d914_uniq" ON "schools_teacher_subjects" ("teacher_id", "subject_id");
CREATE INDEX "schools_teacher_subjects_teacher_id_e62f6f59" ON "schools_teacher_subjects" ("teacher_id");
CREATE INDEX "schools_teacher_subjects_subject_id_4ec63c67" ON "schools_teacher_subjects" ("subject_id");
CREATE TABLE IF NOT EXISTS "schools_attendance" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "date" date NOT NULL, "status" varchar(10) NOT NULL, "remarks" text NULL, "term" varchar(1) NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "recorded_by_id" integer NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "student_id" bigint NOT NULL REFERENCES "schools_student" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE IF NOT EXISTS "schools_assessmentresult" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "performance_level" varchar(1) NOT NULL, "opener_score" decimal NULL, "midpoint_score" decimal NULL, "endpoint_score" decimal NULL, "assessment_id" bigint NOT NULL REFERENCES "schools_assessment" ("id") DEFERRABLE INITIALLY DEFERRED, "subject_id" bigint NOT NULL REFERENCES "schools_subject" ("id") DEFERRABLE INITIALLY DEFERRED, "remarks" text NULL, "marks" decimal NULL, "weekly_score" decimal NULL);
CREATE UNIQUE INDEX "schools_attendance_student_id_date_f10a29fd_uniq" ON "schools_attendance" ("student_id", "date");
CREATE INDEX "schools_attendance_recorded_by_id_cb69d9f2" ON "schools_attendance" ("recorded_by_id");
CREATE INDEX "schools_attendance_student_id_1aa8fb2b" ON "schools_attendance" ("student_id");
CREATE UNIQUE INDEX "schools_assessmentresult_assessment_id_subject_id_60b333d9_uniq" ON "schools_assessmentresult" ("assessment_id", "subject_id");
CREATE INDEX "schools_assessmentresult_assessment_id_a5fa71f2" ON "schools_assessmentresult" ("assessment_id");
CREATE INDEX "schools_assessmentresult_subject_id_8cd7e420" ON "schools_assessmentresult" ("subject_id");
CREATE TABLE IF NOT EXISTS "django_session" ("session_key" varchar(40) NOT NULL PRIMARY KEY, "session_data" text NOT NULL, "expire_date" datetime NOT NULL);
CREATE INDEX "django_session_expire_date_a5c62663" ON "django_session" ("expire_date");
CREATE TABLE IF NOT EXISTS "schools_subject" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(100) NOT NULL, "description" text NULL, "code" varchar(10) NOT NULL UNIQUE);
CREATE TABLE IF NOT EXISTS "schools_teacher" ("employee_ptr_id" bigint NOT NULL PRIMARY KEY REFERENCES "schools_employee" ("id") DEFERRABLE INITIALLY DEFERRED, "tsc_number" varchar(20) NULL UNIQUE, "years_of_experience" integer unsigned NOT NULL CHECK ("years_of_experience" >= 0), "qualifications" varchar(10) NOT NULL, "certificate" varchar(100) NULL, "is_class_teacher" bool NOT NULL, "grade_id" bigint NULL REFERENCES "schools_grade" ("id") DEFERRABLE INITIALLY DEFERRED, "user_id" integer NULL UNIQUE REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE INDEX "schools_teacher_grade_id_3f8fae20" ON "schools_teacher" ("grade_id");
CREATE TABLE IF NOT EXISTS "schools_salary" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "month" date NOT NULL, "status" varchar(20) NOT NULL, "employee_id" bigint NOT NULL REFERENCES "schools_employee" ("id") DEFERRABLE INITIALLY DEFERRED, "amount" decimal NOT NULL, "created_at" datetime NOT NULL, "remarks" text NOT NULL, "updated_at" datetime NOT NULL, "payment_date" date NULL);
CREATE INDEX "schools_salary_employee_id_df90283d" ON "schools_salary" ("employee_id");
CREATE UNIQUE INDEX "schools_salary_employee_id_month_d36c58f5_uniq" ON "schools_salary" ("employee_id", "month");
CREATE TABLE IF NOT EXISTS "schools_schedule" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "grade_id" bigint NOT NULL REFERENCES "schools_grade" ("id") DEFERRABLE INITIALLY DEFERRED, "subject_id" bigint NOT NULL REFERENCES "schools_subject" ("id") DEFERRABLE INITIALLY DEFERRED, "teacher_id" bigint NOT NULL REFERENCES "schools_teacher" ("employee_ptr_id") DEFERRABLE INITIALLY DEFERRED, "day" varchar(10) NOT NULL, "end_time" time NOT NULL, "term" varchar(20) NULL, "start_time" time NOT NULL);
CREATE INDEX "schools_schedule_grade_id_848a7670" ON "schools_schedule" ("grade_id");
CREATE INDEX "schools_schedule_subject_id_5113dd57" ON "schools_schedule" ("subject_id");
CREATE INDEX "schools_schedule_teacher_id_3e26d6d6" ON "schools_schedule" ("teacher_id");
CREATE TABLE IF NOT EXISTS "schools_grade" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(20) NOT NULL, "description" text NOT NULL, "is_active" bool NOT NULL, "class_teacher_id" bigint NULL UNIQUE REFERENCES "schools_teacher" ("employee_ptr_id") DEFERRABLE INITIALLY DEFERRED, "term1_fees" decimal NOT NULL, "term2_fees" decimal NOT NULL, "term3_fees" decimal NOT NULL);
CREATE TABLE IF NOT EXISTS "schools_announcement" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "title" varchar(200) NOT NULL, "content" text NOT NULL, "priority" varchar(10) NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "expires_at" datetime NULL, "is_active" bool NOT NULL, "author_id" integer NOT NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "specific_grade_id" bigint NULL REFERENCES "schools_grade" ("id") DEFERRABLE INITIALLY DEFERRED, "recipient_type" varchar(10) NOT NULL);
CREATE INDEX "schools_announcement_author_id_fde21a53" ON "schools_announcement" ("author_id");
CREATE INDEX "schools_announcement_specific_grade_id_8bdf1f46" ON "schools_announcement" ("specific_grade_id");
CREATE TABLE IF NOT EXISTS "schools_department" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(100) NOT NULL, "description" text NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "is_active" bool NOT NULL, "head_id" bigint NULL REFERENCES "schools_employee" ("id") DEFERRABLE INITIALLY DEFERRED, "branch_id" bigint NULL REFERENCES "schools_branch" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE INDEX "schools_department_head_id_d6a2eb94" ON "schools_department" ("head_id");
CREATE TABLE IF NOT EXISTS "schools_employeeattendance" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "date" date NOT NULL, "status" varchar(10) NOT NULL, "check_in" time NULL, "check_out" time NULL, "remarks" text NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "employee_id" bigint NOT NULL REFERENCES "schools_employee" ("id") DEFERRABLE INITIALLY DEFERRED, "recorded_by_id" integer NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE UNIQUE INDEX "schools_employeeattendance_employee_id_date_8125ec9e_uniq" ON "schools_employeeattendance" ("employee_id", "date");
CREATE INDEX "schools_employeeattendance_employee_id_7276a174" ON "schools_employeeattendance" ("employee_id");
CREATE INDEX "schools_employeeattendance_recorded_by_id_758faf56" ON "schools_employeeattendance" ("recorded_by_id");
CREATE TABLE IF NOT EXISTS "schools_term" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "number" integer NOT NULL, "year" integer NOT NULL, "end_date" datetime NOT NULL, "is_current" bool NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "start_date" datetime NOT NULL);
CREATE UNIQUE INDEX "schools_term_number_year_fabed8bc_uniq" ON "schools_term" ("number", "year");
CREATE TABLE IF NOT EXISTS "schools_payment" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "amount" decimal NOT NULL, "date" datetime NOT NULL, "payment_method" varchar(10) NOT NULL, "student_id" bigint NOT NULL REFERENCES "schools_student" ("id") DEFERRABLE INITIALLY DEFERRED, "term" integer NOT NULL, "checkout_request_id" varchar(100) NULL, "phone_number" varchar(15) NULL, "status" varchar(10) NOT NULL, "transaction_id" varchar(50) NULL, "reference_number" varchar(20) NOT NULL UNIQUE);
CREATE INDEX "schools_payment_student_id_4c53fbf1" ON "schools_payment" ("student_id");
CREATE TABLE IF NOT EXISTS "schools_assessment" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "assessment_type" varchar(20) NOT NULL, "date" date NOT NULL, "term" integer NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "remarks" text NULL, "recorded_by_id" integer NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "student_id" bigint NOT NULL REFERENCES "schools_student" ("id") DEFERRABLE INITIALLY DEFERRED, "week_number" integer NULL);
CREATE INDEX "schools_assessment_recorded_by_id_28ea24c0" ON "schools_assessment" ("recorded_by_id");
CREATE INDEX "schools_assessment_student_id_5bb34ab0" ON "schools_assessment" ("student_id");
CREATE UNIQUE INDEX "unique_non_weekly_assessment_per_term" ON "schools_assessment" ("student_id", "assessment_type", "term") WHERE NOT ("assessment_type" = 'weekly');
CREATE UNIQUE INDEX "unique_weekly_assessment_per_week" ON "schools_assessment" ("student_id", "assessment_type", "term", "week_number") WHERE "assessment_type" = 'weekly';
CREATE TABLE IF NOT EXISTS "schools_transportfee" (
        "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
        "term" integer NOT NULL,
        "amount" decimal NOT NULL,
        "payment_method" varchar(10) NOT NULL,
        "phone_number" varchar(15) NULL,
        "transaction_id" varchar(50) NULL,
        "reference_number" varchar(20) NOT NULL UNIQUE,
        "status" varchar(10) NOT NULL,
        "date" datetime NOT NULL,
        "notes" text NOT NULL,
        "route_id" bigint NOT NULL REFERENCES "schools_route" ("id") DEFERRABLE INITIALLY DEFERRED,
        "student_id" bigint NOT NULL REFERENCES "schools_student" ("id") DEFERRABLE INITIALLY DEFERRED
    );
CREATE TABLE IF NOT EXISTS "schools_studenttransportassignment" (
        "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
        "pickup_location" varchar(200) NOT NULL,
        "dropoff_location" varchar(200) NOT NULL,
        "pickup_time" time NULL,
        "dropoff_time" time NULL,
        "is_active" bool NOT NULL,
        "start_date" date NOT NULL,
        "end_date" date NULL,
        "notes" text NOT NULL,
        "created_at" datetime NOT NULL,
        "updated_at" datetime NOT NULL,
        "route_id" bigint NOT NULL REFERENCES "schools_route" ("id") DEFERRABLE INITIALLY DEFERRED,
        "student_id" bigint NOT NULL REFERENCES "schools_student" ("id") DEFERRABLE INITIALLY DEFERRED,
        "vehicle_id" bigint NULL REFERENCES "schools_vehicle" ("id") DEFERRABLE INITIALLY DEFERRED
    , "dropoff_latitude" decimal NULL, "dropoff_longitude" decimal NULL, "pickup_latitude" decimal NULL, "pickup_longitude" decimal NULL);
CREATE INDEX "schools_transportfee_route_id_f2584562" 
        ON "schools_transportfee" ("route_id");
CREATE INDEX "schools_transportfee_student_id_ec85a65b" 
        ON "schools_transportfee" ("student_id");
CREATE UNIQUE INDEX "schools_studenttransportassignment_student_id_route_id_feee7d2c_uniq" 
        ON "schools_studenttransportassignment" ("student_id", "route_id");
CREATE INDEX "schools_studenttransportassignment_route_id_5eea36ed" 
        ON "schools_studenttransportassignment" ("route_id");
CREATE INDEX "schools_studenttransportassignment_student_id_32f200c8" 
        ON "schools_studenttransportassignment" ("student_id");
CREATE INDEX "schools_studenttransportassignment_vehicle_id_e597ae9b" 
        ON "schools_studenttransportassignment" ("vehicle_id");
CREATE TABLE IF NOT EXISTS "schools_foodplan" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(200) NOT NULL UNIQUE, "description" text NOT NULL, "meal_type" varchar(50) NOT NULL, "fee_per_term" decimal NOT NULL, "is_active" bool NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE IF NOT EXISTS "schools_foodfee" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "term" integer NOT NULL, "amount" decimal NOT NULL, "payment_method" varchar(10) NOT NULL, "phone_number" varchar(15) NULL, "transaction_id" varchar(50) NULL, "reference_number" varchar(20) NOT NULL UNIQUE, "status" varchar(10) NOT NULL, "date" datetime NOT NULL, "notes" text NOT NULL, "student_id" bigint NOT NULL REFERENCES "schools_student" ("id") DEFERRABLE INITIALLY DEFERRED, "food_plan_id" bigint NOT NULL REFERENCES "schools_foodplan" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE IF NOT EXISTS "schools_studentfoodassignment" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "is_active" bool NOT NULL, "start_date" date NOT NULL, "end_date" date NULL, "notes" text NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "food_plan_id" bigint NOT NULL REFERENCES "schools_foodplan" ("id") DEFERRABLE INITIALLY DEFERRED, "student_id" bigint NOT NULL REFERENCES "schools_student" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE INDEX "schools_foodfee_student_id_14d7ba31" ON "schools_foodfee" ("student_id");
CREATE INDEX "schools_foodfee_food_plan_id_1a5a7872" ON "schools_foodfee" ("food_plan_id");
CREATE UNIQUE INDEX "schools_studentfoodassignment_student_id_food_plan_id_b6a32a41_uniq" ON "schools_studentfoodassignment" ("student_id", "food_plan_id");
CREATE INDEX "schools_studentfoodassignment_food_plan_id_a5cfa5dc" ON "schools_studentfoodassignment" ("food_plan_id");
CREATE INDEX "schools_studentfoodassignment_student_id_785fc822" ON "schools_studentfoodassignment" ("student_id");
CREATE TABLE IF NOT EXISTS "schools_mealconsumption" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "meal_type" varchar(20) NOT NULL, "consumption_date" date NOT NULL, "notes" text NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "meal_payment_id" bigint NOT NULL REFERENCES "schools_studentmealpayment" ("id") DEFERRABLE INITIALLY DEFERRED, "served_by_id" integer NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "student_id" bigint NOT NULL REFERENCES "schools_student" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE UNIQUE INDEX "schools_mealconsumption_student_id_meal_type_consumption_date_16259b88_uniq" ON "schools_mealconsumption" ("student_id", "meal_type", "consumption_date");
CREATE INDEX "schools_mealconsumption_meal_payment_id_730af8fd" ON "schools_mealconsumption" ("meal_payment_id");
CREATE INDEX "schools_mealconsumption_served_by_id_4873344d" ON "schools_mealconsumption" ("served_by_id");
CREATE INDEX "schools_mealconsumption_student_id_5d2412e8" ON "schools_mealconsumption" ("student_id");
CREATE INDEX "schools_mea_student_d067ca_idx" ON "schools_mealconsumption" ("student_id", "meal_type", "consumption_date");
CREATE INDEX "schools_mea_consump_ba0660_idx" ON "schools_mealconsumption" ("consumption_date");
CREATE TABLE IF NOT EXISTS "schools_syncstatus" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "is_online" bool NOT NULL, "last_sync_attempt" datetime NULL, "last_successful_sync" datetime NULL, "pending_count" integer NOT NULL, "failed_count" integer NOT NULL, "auto_sync_enabled" bool NOT NULL, "sync_interval_minutes" integer NOT NULL, "max_retry_attempts" integer NOT NULL, "sync_on_startup" bool NOT NULL);
CREATE TABLE IF NOT EXISTS "schools_syncqueue" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "operation_type" varchar(10) NOT NULL, "model_name" varchar(100) NOT NULL, "model_id" integer NOT NULL, "local_id" integer NOT NULL, "data" text NOT NULL CHECK ((JSON_VALID("data") OR "data" IS NULL)), "status" varchar(10) NOT NULL, "retry_count" integer NOT NULL, "last_error" text NULL, "created_at" datetime NOT NULL, "synced_at" datetime NULL, "updated_at" datetime NOT NULL, "notes" text NOT NULL, "user_id" integer NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE INDEX "schools_syncqueue_user_id_71a529d4" ON "schools_syncqueue" ("user_id");
CREATE INDEX "schools_syn_status_556b41_idx" ON "schools_syncqueue" ("status", "created_at");
CREATE INDEX "schools_syn_model_n_d0e6c4_idx" ON "schools_syncqueue" ("model_name", "model_id");
CREATE TABLE IF NOT EXISTS "schools_employee" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "first_name" varchar(100) NOT NULL, "last_name" varchar(100) NOT NULL, "email" varchar(254) NOT NULL UNIQUE, "phone" varchar(20) NOT NULL, "national_id" varchar(20) NOT NULL UNIQUE, "position" varchar(20) NOT NULL, "date_of_birth" date NOT NULL, "date_joined" date NOT NULL, "address" text NOT NULL, "profile_picture" varchar(100) NULL, "basic_salary" decimal NOT NULL, "status" varchar(20) NOT NULL, "gender" varchar(1) NOT NULL, "religion" varchar(20) NOT NULL, "marital_status" varchar(20) NOT NULL, "nationality" varchar(100) NOT NULL, "department_id" bigint NULL REFERENCES "schools_department" ("id") DEFERRABLE INITIALLY DEFERRED, "location" varchar(10) NOT NULL, "branch_id" bigint NULL REFERENCES "schools_branch" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE INDEX "schools_employee_department_id_19452d0d" ON "schools_employee" ("department_id");
CREATE TABLE IF NOT EXISTS "schools_route" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(200) NOT NULL UNIQUE, "description" text NOT NULL, "start_location" varchar(200) NOT NULL, "end_location" varchar(200) NOT NULL, "distance" decimal NULL, "estimated_time" varchar(50) NOT NULL, "fee_per_term" decimal NOT NULL, "is_active" bool NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "end_latitude" decimal NULL, "end_longitude" decimal NULL, "start_latitude" decimal NULL, "start_longitude" decimal NULL, "school_latitude" decimal NULL, "school_longitude" decimal NULL, "location" varchar(10) NOT NULL);
CREATE TABLE IF NOT EXISTS "schools_student" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "admission_number" varchar(50) NOT NULL UNIQUE, "first_name" varchar(100) NOT NULL, "last_name" varchar(100) NOT NULL, "date_of_birth" date NOT NULL, "gender" varchar(1) NOT NULL, "parent_name" varchar(100) NULL, "parent_phone" varchar(20) NULL, "parent_email" varchar(254) NULL, "parent_occupation" varchar(100) NULL, "parent_id_number" varchar(20) NULL, "academic_year" varchar(9) NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "photo" varchar(100) NULL, "term_fees" decimal NOT NULL, "current_term" integer NOT NULL, "birth_certificate_no" varchar(50) NULL, "grade_id" bigint NULL REFERENCES "schools_grade" ("id") DEFERRABLE INITIALLY DEFERRED, "previous_grade_id" bigint NULL REFERENCES "schools_grade" ("id") DEFERRABLE INITIALLY DEFERRED, "user_id" integer NULL UNIQUE REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "term1_fees" decimal NOT NULL, "term2_fees" decimal NOT NULL, "term3_fees" decimal NOT NULL, "guardian_email" varchar(254) NULL, "guardian_id_number" varchar(20) NULL, "guardian_name" varchar(100) NULL, "guardian_occupation" varchar(100) NULL, "guardian_phone" varchar(20) NULL, "location" varchar(10) NOT NULL, "branch_id" bigint NULL REFERENCES "schools_branch" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE INDEX "schools_student_grade_id_8000fe5e" ON "schools_student" ("grade_id");
CREATE INDEX "schools_student_previous_grade_id_5d1c68e8" ON "schools_student" ("previous_grade_id");
CREATE TABLE IF NOT EXISTS "schools_vehicle" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "vehicle_number" varchar(50) NOT NULL UNIQUE, "vehicle_type" varchar(20) NOT NULL, "make" varchar(100) NOT NULL, "model" varchar(100) NOT NULL, "year" integer NULL, "capacity" integer unsigned NOT NULL CHECK ("capacity" >= 0), "status" varchar(20) NOT NULL, "insurance_expiry" date NULL, "registration_expiry" date NULL, "notes" text NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "driver_id" bigint NULL REFERENCES "schools_employee" ("id") DEFERRABLE INITIALLY DEFERRED, "location" varchar(10) NOT NULL);
CREATE INDEX "schools_vehicle_driver_id_d36200c0" ON "schools_vehicle" ("driver_id");
CREATE TABLE IF NOT EXISTS "schools_mealpricing" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "price_per_day" decimal NOT NULL, "is_active" bool NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "location" varchar(10) NOT NULL, "meal_type" varchar(20) NOT NULL);
CREATE UNIQUE INDEX "schools_mealpricing_meal_type_location_db79594f_uniq" ON "schools_mealpricing" ("meal_type", "location");
CREATE TABLE IF NOT EXISTS "schools_studentmealpayment" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "meal_type" varchar(20) NOT NULL, "payment_frequency" varchar(20) NOT NULL, "amount" decimal NOT NULL, "payment_method" varchar(10) NOT NULL, "status" varchar(10) NOT NULL, "payment_date" date NOT NULL, "start_date" date NOT NULL, "end_date" date NULL, "phone_number" varchar(15) NULL, "transaction_id" varchar(50) NULL, "reference_number" varchar(50) NOT NULL UNIQUE, "notes" text NOT NULL, "is_active" bool NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "student_id" bigint NOT NULL REFERENCES "schools_student" ("id") DEFERRABLE INITIALLY DEFERRED, "number_of_days" integer NOT NULL, "payment_group" varchar(50) NULL, "balance" decimal NOT NULL, "days_consumed" integer NOT NULL, "days_remaining" integer NOT NULL, "location" varchar(10) NOT NULL);
CREATE INDEX "schools_studentmealpayment_student_id_c6954ef9" ON "schools_studentmealpayment" ("student_id");
CREATE INDEX "schools_stu_student_cb8a21_idx" ON "schools_studentmealpayment" ("student_id", "meal_type", "is_active");
CREATE INDEX "schools_stu_payment_2cdcad_idx" ON "schools_studentmealpayment" ("payment_date");
CREATE TABLE IF NOT EXISTS "schools_smsmessage" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "message" text NOT NULL, "recipient_type" varchar(20) NOT NULL, "status" varchar(20) NOT NULL, "sent_at" datetime NULL, "response_data" text NULL CHECK ((JSON_VALID("response_data") OR "response_data" IS NULL)), "created_at" datetime NOT NULL, "sent_by_id" integer NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "specific_grade_id" bigint NULL REFERENCES "schools_grade" ("id") DEFERRABLE INITIALLY DEFERRED, "specific_student_id" bigint NULL REFERENCES "schools_student" ("id") DEFERRABLE INITIALLY DEFERRED, "location" varchar(10) NULL, "recipients_count" integer NOT NULL);
CREATE INDEX "schools_smsmessage_sent_by_id_11b65767" ON "schools_smsmessage" ("sent_by_id");
CREATE INDEX "schools_smsmessage_specific_grade_id_630482ee" ON "schools_smsmessage" ("specific_grade_id");
CREATE INDEX "schools_smsmessage_specific_student_id_988a2c7a" ON "schools_smsmessage" ("specific_student_id");
CREATE TABLE IF NOT EXISTS "schools_branch" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(100) NOT NULL UNIQUE, "address" text NULL, "contact_phone" varchar(20) NULL, "is_active" bool NOT NULL, "slug" varchar(100) NOT NULL UNIQUE, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE INDEX "schools_department_branch_id_c078bc8f" ON "schools_department" ("branch_id");
CREATE INDEX "schools_employee_branch_id_3c7cdeae" ON "schools_employee" ("branch_id");
CREATE INDEX "schools_student_branch_id_8405b84e" ON "schools_student" ("branch_id");
CREATE TABLE IF NOT EXISTS "schools_salaryadvance" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "amount" decimal NOT NULL, "reason" text NOT NULL, "status" varchar(20) NOT NULL, "date_requested" datetime NOT NULL, "date_approved" datetime NULL, "remarks" text NOT NULL, "approved_by_id" integer NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "employee_id" bigint NOT NULL REFERENCES "schools_employee" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE INDEX "schools_salaryadvance_approved_by_id_6d476107" ON "schools_salaryadvance" ("approved_by_id");
CREATE INDEX "schools_salaryadvance_employee_id_57f3f536" ON "schools_salaryadvance" ("employee_id");
CREATE TABLE IF NOT EXISTS "schools_staffdocument" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "document_type" varchar(20) NOT NULL, "title" varchar(200) NOT NULL, "file" varchar(100) NOT NULL, "uploaded_at" datetime NOT NULL, "notes" text NOT NULL, "employee_id" bigint NOT NULL REFERENCES "schools_employee" ("id") DEFERRABLE INITIALLY DEFERRED, "uploaded_by_id" integer NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE IF NOT EXISTS "schools_advanceapproval" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "approval_level" varchar(20) NOT NULL, "status" varchar(20) NOT NULL, "comments" text NOT NULL, "approved_date" datetime NULL, "created_at" datetime NOT NULL, "advance_id" bigint NOT NULL REFERENCES "schools_salaryadvance" ("id") DEFERRABLE INITIALLY DEFERRED, "approver_id" integer NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE IF NOT EXISTS "schools_leaveapproval" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "approval_level" varchar(20) NOT NULL, "status" varchar(20) NOT NULL, "comments" text NOT NULL, "approved_date" datetime NULL, "created_at" datetime NOT NULL, "approver_id" integer NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "leave_id" bigint NOT NULL REFERENCES "schools_leave" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE INDEX "schools_staffdocument_employee_id_75296e04" ON "schools_staffdocument" ("employee_id");
CREATE INDEX "schools_staffdocument_uploaded_by_id_04932dd9" ON "schools_staffdocument" ("uploaded_by_id");
CREATE UNIQUE INDEX "schools_advanceapproval_advance_id_approval_level_0f8bde8b_uniq" ON "schools_advanceapproval" ("advance_id", "approval_level");
CREATE INDEX "schools_advanceapproval_advance_id_ac32b886" ON "schools_advanceapproval" ("advance_id");
CREATE INDEX "schools_advanceapproval_approver_id_c4e917d5" ON "schools_advanceapproval" ("approver_id");
CREATE UNIQUE INDEX "schools_leaveapproval_leave_id_approval_level_1842f0ea_uniq" ON "schools_leaveapproval" ("leave_id", "approval_level");
CREATE INDEX "schools_leaveapproval_approver_id_4be99663" ON "schools_leaveapproval" ("approver_id");
CREATE INDEX "schools_leaveapproval_leave_id_c7704229" ON "schools_leaveapproval" ("leave_id");
CREATE TABLE IF NOT EXISTS "finance_feecategory" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(100) NOT NULL, "description" text NULL);
CREATE TABLE IF NOT EXISTS "finance_studentfinanceaccount" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "total_billed" decimal NOT NULL, "total_paid" decimal NOT NULL, "balance" decimal NOT NULL, "last_updated" datetime NOT NULL, "student_id" bigint NOT NULL UNIQUE REFERENCES "schools_student" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE IF NOT EXISTS "finance_transaction" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "type" varchar(20) NOT NULL, "amount" decimal NOT NULL, "description" varchar(255) NOT NULL, "reference" varchar(100) NULL, "payment_method" varchar(20) NOT NULL, "term" integer NULL, "academic_year" varchar(9) NULL, "date" datetime NOT NULL, "account_id" bigint NOT NULL REFERENCES "finance_studentfinanceaccount" ("id") DEFERRABLE INITIALLY DEFERRED, "recorded_by_id" integer NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE IF NOT EXISTS "finance_feestructure" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "term" integer NOT NULL, "academic_year" varchar(9) NOT NULL, "amount" decimal NOT NULL, "is_mandatory" bool NOT NULL, "description" varchar(200) NOT NULL, "created_at" datetime NOT NULL, "category_id" bigint NOT NULL REFERENCES "finance_feecategory" ("id") DEFERRABLE INITIALLY DEFERRED, "grade_id" bigint NOT NULL REFERENCES "schools_grade" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE INDEX "finance_transaction_account_id_fb4d3f0f" ON "finance_transaction" ("account_id");
CREATE INDEX "finance_transaction_recorded_by_id_ee34a345" ON "finance_transaction" ("recorded_by_id");
CREATE UNIQUE INDEX "finance_feestructure_grade_id_term_academic_year_category_id_706e1de3_uniq" ON "finance_feestructure" ("grade_id", "term", "academic_year", "category_id");
CREATE INDEX "finance_feestructure_category_id_c484f382" ON "finance_feestructure" ("category_id");
CREATE INDEX "finance_feestructure_grade_id_4db87074" ON "finance_feestructure" ("grade_id");
CREATE TABLE IF NOT EXISTS "food_foodstudentaccount" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "balance" decimal NOT NULL, "active" bool NOT NULL, "total_billed" decimal NOT NULL, "total_paid" decimal NOT NULL, "updated_at" datetime NOT NULL, "student_id" bigint NOT NULL UNIQUE REFERENCES "schools_student" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE IF NOT EXISTS "food_foodtransaction" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "type" varchar(10) NOT NULL, "amount" decimal NOT NULL, "description" varchar(255) NOT NULL, "reference" varchar(100) NULL, "payment_method" varchar(10) NOT NULL, "date" datetime NOT NULL, "account_id" bigint NOT NULL REFERENCES "food_foodstudentaccount" ("id") DEFERRABLE INITIALLY DEFERRED, "recorded_by_id" integer NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE IF NOT EXISTS "food_foodsubscription" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "start_date" date NOT NULL, "end_date" date NULL, "active" bool NOT NULL, "account_id" bigint NOT NULL REFERENCES "food_foodstudentaccount" ("id") DEFERRABLE INITIALLY DEFERRED, "meal_item_id" bigint NOT NULL REFERENCES "food_mealitem" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE INDEX "food_foodtransaction_account_id_cd45f68f" ON "food_foodtransaction" ("account_id");
CREATE INDEX "food_foodtransaction_recorded_by_id_01d63439" ON "food_foodtransaction" ("recorded_by_id");
CREATE INDEX "food_foodsubscription_account_id_c2a39b1a" ON "food_foodsubscription" ("account_id");
CREATE INDEX "food_foodsubscription_meal_item_id_a7ec1225" ON "food_foodsubscription" ("meal_item_id");
CREATE TABLE IF NOT EXISTS "food_mealitem" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(100) NOT NULL, "description" text NULL, "cost" decimal NOT NULL, "billing_cycle" varchar(20) NOT NULL, "active" bool NOT NULL, "created_at" datetime NOT NULL, "per_serving_cost" decimal NOT NULL);
CREATE TABLE IF NOT EXISTS "transport_route" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(100) NOT NULL, "description" text NULL, "cost_per_term" decimal NOT NULL, "cost_per_month" decimal NOT NULL, "pickup_points" text NOT NULL, "active" bool NOT NULL, "created_at" datetime NOT NULL, "map_embed_code" text NULL);
CREATE TABLE IF NOT EXISTS "transport_transportstudentaccount" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "balance" decimal NOT NULL, "active" bool NOT NULL, "total_billed" decimal NOT NULL, "total_paid" decimal NOT NULL, "updated_at" datetime NOT NULL, "student_id" bigint NOT NULL UNIQUE REFERENCES "schools_student" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE IF NOT EXISTS "transport_transportassignment" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "start_date" date NOT NULL, "end_date" date NULL, "active" bool NOT NULL, "pickup_point" varchar(200) NOT NULL, "route_id" bigint NOT NULL REFERENCES "transport_route" ("id") DEFERRABLE INITIALLY DEFERRED, "account_id" bigint NOT NULL REFERENCES "transport_transportstudentaccount" ("id") DEFERRABLE INITIALLY DEFERRED, "pickup_location_embed" text NULL, "latitude" real NULL, "longitude" real NULL);
CREATE TABLE IF NOT EXISTS "transport_transporttransaction" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "type" varchar(10) NOT NULL, "amount" decimal NOT NULL, "description" varchar(255) NOT NULL, "reference" varchar(100) NULL, "payment_method" varchar(10) NOT NULL, "date" datetime NOT NULL, "account_id" bigint NOT NULL REFERENCES "transport_transportstudentaccount" ("id") DEFERRABLE INITIALLY DEFERRED, "recorded_by_id" integer NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE INDEX "transport_transportassignment_route_id_9c0b63c1" ON "transport_transportassignment" ("route_id");
CREATE INDEX "transport_transportassignment_account_id_19deb1b9" ON "transport_transportassignment" ("account_id");
CREATE INDEX "transport_transporttransaction_account_id_5e3ffa4e" ON "transport_transporttransaction" ("account_id");
CREATE INDEX "transport_transporttransaction_recorded_by_id_40a74d82" ON "transport_transporttransaction" ("recorded_by_id");
CREATE TABLE IF NOT EXISTS "transport_transportvehicle" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "plate_number" varchar(20) NOT NULL UNIQUE, "model" varchar(100) NOT NULL, "capacity" integer unsigned NOT NULL CHECK ("capacity" >= 0), "status" varchar(20) NOT NULL, "created_at" datetime NOT NULL, "route_id" bigint NULL REFERENCES "transport_route" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE INDEX "transport_transportvehicle_route_id_6871116b" ON "transport_transportvehicle" ("route_id");
CREATE TABLE IF NOT EXISTS "transport_transportdriver" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "first_name" varchar(100) NOT NULL, "last_name" varchar(100) NOT NULL, "license_number" varchar(50) NOT NULL UNIQUE, "status" varchar(20) NOT NULL, "joined_at" date NOT NULL, "vehicle_id" bigint NULL UNIQUE REFERENCES "transport_transportvehicle" ("id") DEFERRABLE INITIALLY DEFERRED, "user_id" integer NULL UNIQUE REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "phone_number" varchar(20) NOT NULL UNIQUE);
CREATE TABLE IF NOT EXISTS "transport_transportadvancerequest" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "amount" decimal NOT NULL, "reason" text NOT NULL, "status" varchar(20) NOT NULL, "action_date" datetime NULL, "created_at" datetime NOT NULL, "action_by_id" integer NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "driver_id" bigint NOT NULL REFERENCES "transport_transportdriver" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE IF NOT EXISTS "transport_transportexpense" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "expense_type" varchar(20) NOT NULL, "amount" decimal NOT NULL, "description" text NOT NULL, "receipt_image" varchar(100) NULL, "date" date NOT NULL, "status" varchar(20) NOT NULL, "action_date" datetime NULL, "created_at" datetime NOT NULL, "action_by_id" integer NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "driver_id" bigint NOT NULL REFERENCES "transport_transportdriver" ("id") DEFERRABLE INITIALLY DEFERRED, "vehicle_id" bigint NULL REFERENCES "transport_transportvehicle" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE IF NOT EXISTS "transport_transportleaverequest" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "start_date" date NOT NULL, "end_date" date NOT NULL, "reason" text NOT NULL, "status" varchar(20) NOT NULL, "action_date" datetime NULL, "created_at" datetime NOT NULL, "action_by_id" integer NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "driver_id" bigint NOT NULL REFERENCES "transport_transportdriver" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE INDEX "transport_transportadvancerequest_action_by_id_7de3af07" ON "transport_transportadvancerequest" ("action_by_id");
CREATE INDEX "transport_transportadvancerequest_driver_id_ebdbdc95" ON "transport_transportadvancerequest" ("driver_id");
CREATE INDEX "transport_transportexpense_action_by_id_c6cb71a5" ON "transport_transportexpense" ("action_by_id");
CREATE INDEX "transport_transportexpense_driver_id_a0277ca3" ON "transport_transportexpense" ("driver_id");
CREATE INDEX "transport_transportexpense_vehicle_id_6fb1f292" ON "transport_transportexpense" ("vehicle_id");
CREATE INDEX "transport_transportleaverequest_action_by_id_2be3f38a" ON "transport_transportleaverequest" ("action_by_id");
CREATE INDEX "transport_transportleaverequest_driver_id_8364a185" ON "transport_transportleaverequest" ("driver_id");
CREATE TABLE IF NOT EXISTS "schools_expense" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "title" varchar(200) NOT NULL, "amount" decimal NOT NULL, "category" varchar(20) NOT NULL, "description" text NOT NULL, "date" date NOT NULL, "vendor" varchar(200) NOT NULL, "payment_method" varchar(20) NOT NULL, "receipt_number" varchar(100) NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "created_by_id" integer NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE INDEX "schools_expense_created_by_id_f67ddd76" ON "schools_expense" ("created_by_id");
CREATE TABLE IF NOT EXISTS "finance_salarystructure" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "base_salary" decimal NOT NULL, "allowances" decimal NOT NULL, "deductions" decimal NOT NULL, "updated_at" datetime NOT NULL, "user_id" integer NOT NULL UNIQUE REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "loans" decimal NOT NULL, "nssf" decimal NOT NULL);
CREATE TABLE IF NOT EXISTS "schools_nonteachingstaff" ("employee_ptr_id" bigint NOT NULL PRIMARY KEY REFERENCES "schools_employee" ("id") DEFERRABLE INITIALLY DEFERRED, "staff_type" varchar(20) NOT NULL, "job_description" text NOT NULL, "emergency_contact_name" varchar(100) NOT NULL, "emergency_contact_phone" varchar(20) NOT NULL, "supervisor_id" bigint NULL REFERENCES "schools_employee" ("id") DEFERRABLE INITIALLY DEFERRED, "user_id" integer NULL UNIQUE REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE INDEX "schools_nonteachingstaff_supervisor_id_266ca559" ON "schools_nonteachingstaff" ("supervisor_id");
CREATE TABLE IF NOT EXISTS "finance_payrollrecord" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "month" date NOT NULL, "base_salary" decimal NOT NULL, "allowances" decimal NOT NULL, "deductions" decimal NOT NULL, "bonus" decimal NOT NULL, "net_salary" decimal NOT NULL, "status" varchar(20) NOT NULL, "payment_method" varchar(20) NULL, "transaction_ref" varchar(100) NULL, "generated_at" datetime NOT NULL, "paid_at" datetime NULL, "user_id" integer NOT NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "loans" decimal NOT NULL, "nssf" decimal NOT NULL, "advances" decimal NOT NULL);
CREATE UNIQUE INDEX "finance_payrollrecord_user_id_month_e56e5f95_uniq" ON "finance_payrollrecord" ("user_id", "month");
CREATE INDEX "finance_payrollrecord_user_id_1a82683c" ON "finance_payrollrecord" ("user_id");
CREATE TABLE IF NOT EXISTS "config_schoolconfig" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "school_name" varchar(200) NOT NULL, "school_code" varchar(20) NOT NULL, "school_email" varchar(254) NOT NULL, "school_phone" varchar(20) NOT NULL, "admission_number_format" varchar(100) NOT NULL, "admission_counter" integer NOT NULL, "current_term" varchar(20) NOT NULL, "current_year" integer NOT NULL, "default_currency" varchar(10) NOT NULL, "school_address" text NOT NULL, "school_logo" varchar(100) NULL);
CREATE TABLE IF NOT EXISTS "django_cache_table" (
    "cache_key" varchar(255) NOT NULL PRIMARY KEY,
    "value" text NOT NULL,
    "expires" datetime NOT NULL
);
CREATE INDEX "django_cache_table_expires" ON "django_cache_table" ("expires");
