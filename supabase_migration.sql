-- ============================================================
-- BDMIS Supabase Migration SQL (PostgreSQL)
-- Generated: 2026-03-10 10:58:26
-- Strategy: Tables created WITHOUT FK constraints first,
--           data inserted, then FKs added via ALTER TABLE.
--           This avoids ALL circular dependency errors.
-- ============================================================

SET session_replication_role = 'replica';

-- ============================================================
-- SECTION 0: DROP EXISTING TABLES (clean slate for re-runs)
-- ============================================================
-- Drops tables in reverse dependency order with CASCADE

DROP TABLE IF EXISTS "transport_transportleaverequest" CASCADE;
DROP TABLE IF EXISTS "transport_transportexpense" CASCADE;
DROP TABLE IF EXISTS "transport_transportadvancerequest" CASCADE;
DROP TABLE IF EXISTS "transport_transporttransaction" CASCADE;
DROP TABLE IF EXISTS "transport_transportassignment" CASCADE;
DROP TABLE IF EXISTS "transport_transportstudentaccount" CASCADE;
DROP TABLE IF EXISTS "transport_transportdriver" CASCADE;
DROP TABLE IF EXISTS "transport_transportvehicle" CASCADE;
DROP TABLE IF EXISTS "transport_route" CASCADE;
DROP TABLE IF EXISTS "food_foodsubscription" CASCADE;
DROP TABLE IF EXISTS "food_foodtransaction" CASCADE;
DROP TABLE IF EXISTS "food_foodstudentaccount" CASCADE;
DROP TABLE IF EXISTS "food_mealitem" CASCADE;
DROP TABLE IF EXISTS "finance_payrollrecord" CASCADE;
DROP TABLE IF EXISTS "finance_salarystructure" CASCADE;
DROP TABLE IF EXISTS "finance_transaction" CASCADE;
DROP TABLE IF EXISTS "finance_studentfinanceaccount" CASCADE;
DROP TABLE IF EXISTS "finance_feestructure" CASCADE;
DROP TABLE IF EXISTS "finance_feecategory" CASCADE;
DROP TABLE IF EXISTS "schools_expense" CASCADE;
DROP TABLE IF EXISTS "schools_employeeattendance" CASCADE;
DROP TABLE IF EXISTS "schools_syncqueue" CASCADE;
DROP TABLE IF EXISTS "schools_syncstatus" CASCADE;
DROP TABLE IF EXISTS "schools_mealconsumption" CASCADE;
DROP TABLE IF EXISTS "schools_studentmealpayment" CASCADE;
DROP TABLE IF EXISTS "schools_mealpricing" CASCADE;
DROP TABLE IF EXISTS "schools_studentfoodassignment" CASCADE;
DROP TABLE IF EXISTS "schools_foodfee" CASCADE;
DROP TABLE IF EXISTS "schools_foodplan" CASCADE;
DROP TABLE IF EXISTS "schools_studenttransportassignment" CASCADE;
DROP TABLE IF EXISTS "schools_transportfee" CASCADE;
DROP TABLE IF EXISTS "schools_smsmessage" CASCADE;
DROP TABLE IF EXISTS "schools_announcement" CASCADE;
DROP TABLE IF EXISTS "schools_schedule" CASCADE;
DROP TABLE IF EXISTS "schools_assessmentresult" CASCADE;
DROP TABLE IF EXISTS "schools_assessment" CASCADE;
DROP TABLE IF EXISTS "schools_attendance" CASCADE;
DROP TABLE IF EXISTS "schools_payment" CASCADE;
DROP TABLE IF EXISTS "schools_student" CASCADE;
DROP TABLE IF EXISTS "schools_vehicle" CASCADE;
DROP TABLE IF EXISTS "schools_route" CASCADE;
DROP TABLE IF EXISTS "schools_term" CASCADE;
DROP TABLE IF EXISTS "schools_staffdocument" CASCADE;
DROP TABLE IF EXISTS "schools_leaveapproval" CASCADE;
DROP TABLE IF EXISTS "schools_leave" CASCADE;
DROP TABLE IF EXISTS "schools_advanceapproval" CASCADE;
DROP TABLE IF EXISTS "schools_salaryadvance" CASCADE;
DROP TABLE IF EXISTS "schools_deduction" CASCADE;
DROP TABLE IF EXISTS "schools_allowance" CASCADE;
DROP TABLE IF EXISTS "schools_salary" CASCADE;
DROP TABLE IF EXISTS "schools_nonteachingstaff" CASCADE;
DROP TABLE IF EXISTS "schools_subject" CASCADE;
DROP TABLE IF EXISTS "schools_teacher_subjects" CASCADE;
DROP TABLE IF EXISTS "schools_teacher" CASCADE;
DROP TABLE IF EXISTS "schools_grade" CASCADE;
DROP TABLE IF EXISTS "schools_employee" CASCADE;
DROP TABLE IF EXISTS "schools_department" CASCADE;
DROP TABLE IF EXISTS "schools_branch" CASCADE;
DROP TABLE IF EXISTS "schools_school" CASCADE;
DROP TABLE IF EXISTS "config_schoolconfig" CASCADE;
DROP TABLE IF EXISTS "django_admin_log" CASCADE;
DROP TABLE IF EXISTS "django_migrations" CASCADE;
DROP TABLE IF EXISTS "auth_user_user_permissions" CASCADE;
DROP TABLE IF EXISTS "auth_user_groups" CASCADE;
DROP TABLE IF EXISTS "auth_group_permissions" CASCADE;
DROP TABLE IF EXISTS "auth_user" CASCADE;
DROP TABLE IF EXISTS "auth_group" CASCADE;
DROP TABLE IF EXISTS "auth_permission" CASCADE;
DROP TABLE IF EXISTS "django_content_type" CASCADE;

-- ============================================================
-- SECTION 1: CREATE TABLES (no FK constraints)
-- ============================================================

-- Table: django_content_type
CREATE TABLE IF NOT EXISTS "django_content_type" (
  "id" BIGSERIAL PRIMARY KEY,
  "app_label" TEXT,
  "model" TEXT
);

-- Table: auth_permission
CREATE TABLE IF NOT EXISTS "auth_permission" (
  "id" BIGSERIAL PRIMARY KEY,
  "content_type_id" BIGINT,
  "codename" TEXT,
  "name" TEXT
);

-- Table: auth_group
CREATE TABLE IF NOT EXISTS "auth_group" (
  "id" BIGSERIAL PRIMARY KEY,
  "name" TEXT
);

-- Table: auth_user
CREATE TABLE IF NOT EXISTS "auth_user" (
  "id" BIGSERIAL PRIMARY KEY,
  "password" TEXT,
  "last_login" TIMESTAMPTZ,
  "is_superuser" BOOLEAN,
  "username" TEXT,
  "last_name" TEXT,
  "email" TEXT,
  "is_staff" BOOLEAN,
  "is_active" BOOLEAN,
  "date_joined" TIMESTAMPTZ,
  "first_name" TEXT
);

-- Table: auth_group_permissions
CREATE TABLE IF NOT EXISTS "auth_group_permissions" (
  "id" BIGSERIAL PRIMARY KEY,
  "group_id" BIGINT,
  "permission_id" BIGINT
);

-- Table: auth_user_groups
CREATE TABLE IF NOT EXISTS "auth_user_groups" (
  "id" BIGSERIAL PRIMARY KEY,
  "user_id" BIGINT,
  "group_id" BIGINT
);

-- Table: auth_user_user_permissions
CREATE TABLE IF NOT EXISTS "auth_user_user_permissions" (
  "id" BIGSERIAL PRIMARY KEY,
  "user_id" BIGINT,
  "permission_id" BIGINT
);

-- Table: django_migrations
CREATE TABLE IF NOT EXISTS "django_migrations" (
  "id" BIGSERIAL PRIMARY KEY,
  "app" TEXT,
  "name" TEXT,
  "applied" TIMESTAMPTZ
);

-- Table: django_admin_log
CREATE TABLE IF NOT EXISTS "django_admin_log" (
  "id" BIGSERIAL PRIMARY KEY,
  "object_id" TEXT,
  "object_repr" TEXT,
  "action_flag" TEXT,
  "change_message" TEXT,
  "content_type_id" BIGINT,
  "user_id" BIGINT,
  "action_time" TIMESTAMPTZ
);

-- Table: config_schoolconfig
CREATE TABLE IF NOT EXISTS "config_schoolconfig" (
  "id" BIGSERIAL PRIMARY KEY,
  "school_name" TEXT,
  "school_code" TEXT,
  "school_email" TEXT,
  "school_phone" TEXT,
  "admission_number_format" TEXT,
  "admission_counter" BIGINT,
  "current_term" TEXT,
  "current_year" BIGINT,
  "default_currency" TEXT,
  "school_address" TEXT,
  "school_logo" TEXT
);

-- Table: schools_school
CREATE TABLE IF NOT EXISTS "schools_school" (
  "id" BIGSERIAL PRIMARY KEY,
  "name" TEXT,
  "category" TEXT,
  "address" TEXT,
  "phone" TEXT,
  "email" TEXT,
  "website" TEXT,
  "motto" TEXT,
  "logo" TEXT,
  "created_at" TIMESTAMPTZ,
  "updated_at" TIMESTAMPTZ
);

-- Table: schools_branch
CREATE TABLE IF NOT EXISTS "schools_branch" (
  "id" BIGSERIAL PRIMARY KEY,
  "name" TEXT,
  "address" TEXT,
  "contact_phone" TEXT,
  "is_active" BOOLEAN,
  "slug" TEXT,
  "created_at" TIMESTAMPTZ,
  "updated_at" TIMESTAMPTZ
);

-- Table: schools_department
CREATE TABLE IF NOT EXISTS "schools_department" (
  "id" BIGSERIAL PRIMARY KEY,
  "name" TEXT,
  "description" TEXT,
  "created_at" TIMESTAMPTZ,
  "updated_at" TIMESTAMPTZ,
  "is_active" BOOLEAN,
  "head_id" BIGINT,
  "branch_id" BIGINT
);

-- Table: schools_employee
CREATE TABLE IF NOT EXISTS "schools_employee" (
  "id" BIGSERIAL PRIMARY KEY,
  "first_name" TEXT,
  "last_name" TEXT,
  "email" TEXT,
  "phone" TEXT,
  "national_id" TEXT,
  "position" TEXT,
  "date_of_birth" DATE,
  "date_joined" DATE,
  "address" TEXT,
  "profile_picture" TEXT,
  "basic_salary" NUMERIC,
  "status" TEXT,
  "gender" TEXT,
  "religion" TEXT,
  "marital_status" TEXT,
  "nationality" TEXT,
  "department_id" BIGINT,
  "location" TEXT,
  "branch_id" BIGINT
);

-- Table: schools_grade
CREATE TABLE IF NOT EXISTS "schools_grade" (
  "id" BIGSERIAL PRIMARY KEY,
  "name" TEXT,
  "description" TEXT,
  "is_active" BOOLEAN,
  "class_teacher_id" BIGINT,
  "term1_fees" NUMERIC,
  "term2_fees" NUMERIC,
  "term3_fees" NUMERIC
);

-- Table: schools_teacher
CREATE TABLE IF NOT EXISTS "schools_teacher" (
  "employee_ptr_id" BIGSERIAL PRIMARY KEY,
  "tsc_number" TEXT,
  "years_of_experience" TEXT,
  "qualifications" TEXT,
  "certificate" TEXT,
  "is_class_teacher" BOOLEAN,
  "grade_id" BIGINT,
  "user_id" BIGINT
);

-- Table: schools_teacher_subjects
CREATE TABLE IF NOT EXISTS "schools_teacher_subjects" (
  "id" BIGSERIAL PRIMARY KEY,
  "teacher_id" BIGINT,
  "subject_id" BIGINT
);

-- Table: schools_subject
CREATE TABLE IF NOT EXISTS "schools_subject" (
  "id" BIGSERIAL PRIMARY KEY,
  "name" TEXT,
  "description" TEXT,
  "code" TEXT
);

-- Table: schools_nonteachingstaff
CREATE TABLE IF NOT EXISTS "schools_nonteachingstaff" (
  "employee_ptr_id" BIGSERIAL PRIMARY KEY,
  "staff_type" TEXT,
  "job_description" TEXT,
  "emergency_contact_name" TEXT,
  "emergency_contact_phone" TEXT,
  "supervisor_id" BIGINT,
  "user_id" BIGINT
);

-- Table: schools_salary
CREATE TABLE IF NOT EXISTS "schools_salary" (
  "id" BIGSERIAL PRIMARY KEY,
  "month" DATE,
  "status" TEXT,
  "employee_id" BIGINT,
  "amount" NUMERIC,
  "created_at" TIMESTAMPTZ,
  "remarks" TEXT,
  "updated_at" TIMESTAMPTZ,
  "payment_date" DATE
);

-- Table: schools_allowance
CREATE TABLE IF NOT EXISTS "schools_allowance" (
  "id" BIGSERIAL PRIMARY KEY,
  "type" TEXT,
  "amount" NUMERIC,
  "description" TEXT,
  "salary_id" BIGINT
);

-- Table: schools_deduction
CREATE TABLE IF NOT EXISTS "schools_deduction" (
  "id" BIGSERIAL PRIMARY KEY,
  "type" TEXT,
  "amount" NUMERIC,
  "description" TEXT,
  "salary_id" BIGINT
);

-- Table: schools_salaryadvance
CREATE TABLE IF NOT EXISTS "schools_salaryadvance" (
  "id" BIGSERIAL PRIMARY KEY,
  "amount" NUMERIC,
  "reason" TEXT,
  "status" TEXT,
  "date_requested" TIMESTAMPTZ,
  "date_approved" TIMESTAMPTZ,
  "remarks" TEXT,
  "approved_by_id" BIGINT,
  "employee_id" BIGINT
);

-- Table: schools_advanceapproval
CREATE TABLE IF NOT EXISTS "schools_advanceapproval" (
  "id" BIGSERIAL PRIMARY KEY,
  "approval_level" TEXT,
  "status" TEXT,
  "comments" TEXT,
  "approved_date" TIMESTAMPTZ,
  "created_at" TIMESTAMPTZ,
  "advance_id" BIGINT,
  "approver_id" BIGINT
);

-- Table: schools_leave
CREATE TABLE IF NOT EXISTS "schools_leave" (
  "id" BIGSERIAL PRIMARY KEY,
  "leave_type" TEXT,
  "start_date" DATE,
  "end_date" DATE,
  "reason" TEXT,
  "status" TEXT,
  "approved_date" TIMESTAMPTZ,
  "created_at" TIMESTAMPTZ,
  "updated_at" TIMESTAMPTZ,
  "approved_by_id" BIGINT,
  "employee_id" BIGINT
);

-- Table: schools_leaveapproval
CREATE TABLE IF NOT EXISTS "schools_leaveapproval" (
  "id" BIGSERIAL PRIMARY KEY,
  "approval_level" TEXT,
  "status" TEXT,
  "comments" TEXT,
  "approved_date" TIMESTAMPTZ,
  "created_at" TIMESTAMPTZ,
  "approver_id" BIGINT,
  "leave_id" BIGINT
);

-- Table: schools_staffdocument
CREATE TABLE IF NOT EXISTS "schools_staffdocument" (
  "id" BIGSERIAL PRIMARY KEY,
  "document_type" TEXT,
  "title" TEXT,
  "file" TEXT,
  "uploaded_at" TIMESTAMPTZ,
  "notes" TEXT,
  "employee_id" BIGINT,
  "uploaded_by_id" BIGINT
);

-- Table: schools_term
CREATE TABLE IF NOT EXISTS "schools_term" (
  "id" BIGSERIAL PRIMARY KEY,
  "number" BIGINT,
  "year" BIGINT,
  "end_date" TIMESTAMPTZ,
  "is_current" BOOLEAN,
  "created_at" TIMESTAMPTZ,
  "updated_at" TIMESTAMPTZ,
  "start_date" TIMESTAMPTZ
);

-- Table: schools_route
CREATE TABLE IF NOT EXISTS "schools_route" (
  "id" BIGSERIAL PRIMARY KEY,
  "name" TEXT,
  "description" TEXT,
  "start_location" TEXT,
  "end_location" TEXT,
  "distance" NUMERIC,
  "estimated_time" TEXT,
  "fee_per_term" NUMERIC,
  "is_active" BOOLEAN,
  "created_at" TIMESTAMPTZ,
  "updated_at" TIMESTAMPTZ,
  "end_latitude" NUMERIC,
  "end_longitude" NUMERIC,
  "start_latitude" NUMERIC,
  "start_longitude" NUMERIC,
  "school_latitude" NUMERIC,
  "school_longitude" NUMERIC,
  "location" TEXT
);

-- Table: schools_vehicle
CREATE TABLE IF NOT EXISTS "schools_vehicle" (
  "id" BIGSERIAL PRIMARY KEY,
  "vehicle_number" TEXT,
  "vehicle_type" TEXT,
  "make" TEXT,
  "model" TEXT,
  "year" BIGINT,
  "capacity" TEXT,
  "status" TEXT,
  "insurance_expiry" DATE,
  "registration_expiry" DATE,
  "notes" TEXT,
  "created_at" TIMESTAMPTZ,
  "updated_at" TIMESTAMPTZ,
  "driver_id" BIGINT,
  "location" TEXT
);

-- Table: schools_student
CREATE TABLE IF NOT EXISTS "schools_student" (
  "id" BIGSERIAL PRIMARY KEY,
  "admission_number" TEXT,
  "first_name" TEXT,
  "last_name" TEXT,
  "date_of_birth" DATE,
  "gender" TEXT,
  "parent_name" TEXT,
  "parent_phone" TEXT,
  "parent_email" TEXT,
  "parent_occupation" TEXT,
  "parent_id_number" TEXT,
  "academic_year" TEXT,
  "created_at" TIMESTAMPTZ,
  "updated_at" TIMESTAMPTZ,
  "photo" TEXT,
  "term_fees" NUMERIC,
  "current_term" BIGINT,
  "birth_certificate_no" TEXT,
  "grade_id" BIGINT,
  "previous_grade_id" BIGINT,
  "user_id" BIGINT,
  "term1_fees" NUMERIC,
  "term2_fees" NUMERIC,
  "term3_fees" NUMERIC,
  "guardian_email" TEXT,
  "guardian_id_number" TEXT,
  "guardian_name" TEXT,
  "guardian_occupation" TEXT,
  "guardian_phone" TEXT,
  "location" TEXT,
  "branch_id" BIGINT
);

-- Table: schools_payment
CREATE TABLE IF NOT EXISTS "schools_payment" (
  "id" BIGSERIAL PRIMARY KEY,
  "amount" NUMERIC,
  "date" TIMESTAMPTZ,
  "payment_method" TEXT,
  "student_id" BIGINT,
  "term" BIGINT,
  "checkout_request_id" TEXT,
  "phone_number" TEXT,
  "status" TEXT,
  "transaction_id" TEXT,
  "reference_number" TEXT
);

-- Table: schools_attendance
CREATE TABLE IF NOT EXISTS "schools_attendance" (
  "id" BIGSERIAL PRIMARY KEY,
  "date" DATE,
  "status" TEXT,
  "remarks" TEXT,
  "term" TEXT,
  "created_at" TIMESTAMPTZ,
  "updated_at" TIMESTAMPTZ,
  "recorded_by_id" BIGINT,
  "student_id" BIGINT
);

-- Table: schools_assessment
CREATE TABLE IF NOT EXISTS "schools_assessment" (
  "id" BIGSERIAL PRIMARY KEY,
  "assessment_type" TEXT,
  "date" DATE,
  "term" BIGINT,
  "created_at" TIMESTAMPTZ,
  "updated_at" TIMESTAMPTZ,
  "remarks" TEXT,
  "recorded_by_id" BIGINT,
  "student_id" BIGINT,
  "week_number" BIGINT
);

-- Table: schools_assessmentresult
CREATE TABLE IF NOT EXISTS "schools_assessmentresult" (
  "id" BIGSERIAL PRIMARY KEY,
  "performance_level" TEXT,
  "opener_score" NUMERIC,
  "midpoint_score" NUMERIC,
  "endpoint_score" NUMERIC,
  "assessment_id" BIGINT,
  "subject_id" BIGINT,
  "remarks" TEXT,
  "marks" NUMERIC,
  "weekly_score" NUMERIC
);

-- Table: schools_schedule
CREATE TABLE IF NOT EXISTS "schools_schedule" (
  "id" BIGSERIAL PRIMARY KEY,
  "grade_id" BIGINT,
  "subject_id" BIGINT,
  "teacher_id" BIGINT,
  "day" TEXT,
  "end_time" TIME,
  "term" TEXT,
  "start_time" TIME
);

-- Table: schools_announcement
CREATE TABLE IF NOT EXISTS "schools_announcement" (
  "id" BIGSERIAL PRIMARY KEY,
  "title" TEXT,
  "content" TEXT,
  "priority" TEXT,
  "created_at" TIMESTAMPTZ,
  "updated_at" TIMESTAMPTZ,
  "expires_at" TIMESTAMPTZ,
  "is_active" BOOLEAN,
  "author_id" BIGINT,
  "specific_grade_id" BIGINT,
  "recipient_type" TEXT
);

-- Table: schools_smsmessage
CREATE TABLE IF NOT EXISTS "schools_smsmessage" (
  "id" BIGSERIAL PRIMARY KEY,
  "message" TEXT,
  "recipient_type" TEXT,
  "status" TEXT,
  "sent_at" TIMESTAMPTZ,
  "response_data" TEXT,
  "created_at" TIMESTAMPTZ,
  "sent_by_id" BIGINT,
  "specific_grade_id" BIGINT,
  "specific_student_id" BIGINT,
  "location" TEXT,
  "recipients_count" BIGINT
);

-- Table: schools_transportfee
CREATE TABLE IF NOT EXISTS "schools_transportfee" (
  "id" BIGSERIAL PRIMARY KEY,
  "term" BIGINT,
  "amount" NUMERIC,
  "payment_method" TEXT,
  "phone_number" TEXT,
  "transaction_id" TEXT,
  "reference_number" TEXT,
  "status" TEXT,
  "date" TIMESTAMPTZ,
  "notes" TEXT,
  "route_id" BIGINT,
  "student_id" BIGINT
);

-- Table: schools_studenttransportassignment
CREATE TABLE IF NOT EXISTS "schools_studenttransportassignment" (
  "id" BIGSERIAL PRIMARY KEY,
  "pickup_location" TEXT,
  "dropoff_location" TEXT,
  "pickup_time" TIME,
  "dropoff_time" TIME,
  "is_active" BOOLEAN,
  "start_date" DATE,
  "end_date" DATE,
  "notes" TEXT,
  "created_at" TIMESTAMPTZ,
  "updated_at" TIMESTAMPTZ,
  "route_id" BIGINT,
  "student_id" BIGINT,
  "vehicle_id" BIGINT,
  "dropoff_latitude" NUMERIC,
  "dropoff_longitude" NUMERIC,
  "pickup_latitude" NUMERIC,
  "pickup_longitude" NUMERIC
);

-- Table: schools_foodplan
CREATE TABLE IF NOT EXISTS "schools_foodplan" (
  "id" BIGSERIAL PRIMARY KEY,
  "name" TEXT,
  "description" TEXT,
  "meal_type" TEXT,
  "fee_per_term" NUMERIC,
  "is_active" BOOLEAN,
  "created_at" TIMESTAMPTZ,
  "updated_at" TIMESTAMPTZ
);

-- Table: schools_foodfee
CREATE TABLE IF NOT EXISTS "schools_foodfee" (
  "id" BIGSERIAL PRIMARY KEY,
  "term" BIGINT,
  "amount" NUMERIC,
  "payment_method" TEXT,
  "phone_number" TEXT,
  "transaction_id" TEXT,
  "reference_number" TEXT,
  "status" TEXT,
  "date" TIMESTAMPTZ,
  "notes" TEXT,
  "student_id" BIGINT,
  "food_plan_id" BIGINT
);

-- Table: schools_studentfoodassignment
CREATE TABLE IF NOT EXISTS "schools_studentfoodassignment" (
  "id" BIGSERIAL PRIMARY KEY,
  "is_active" BOOLEAN,
  "start_date" DATE,
  "end_date" DATE,
  "notes" TEXT,
  "created_at" TIMESTAMPTZ,
  "updated_at" TIMESTAMPTZ,
  "food_plan_id" BIGINT,
  "student_id" BIGINT
);

-- Table: schools_mealpricing
CREATE TABLE IF NOT EXISTS "schools_mealpricing" (
  "id" BIGSERIAL PRIMARY KEY,
  "price_per_day" NUMERIC,
  "is_active" BOOLEAN,
  "created_at" TIMESTAMPTZ,
  "updated_at" TIMESTAMPTZ,
  "location" TEXT,
  "meal_type" TEXT
);

-- Table: schools_studentmealpayment
CREATE TABLE IF NOT EXISTS "schools_studentmealpayment" (
  "id" BIGSERIAL PRIMARY KEY,
  "meal_type" TEXT,
  "payment_frequency" TEXT,
  "amount" NUMERIC,
  "payment_method" TEXT,
  "status" TEXT,
  "payment_date" DATE,
  "start_date" DATE,
  "end_date" DATE,
  "phone_number" TEXT,
  "transaction_id" TEXT,
  "reference_number" TEXT,
  "notes" TEXT,
  "is_active" BOOLEAN,
  "created_at" TIMESTAMPTZ,
  "updated_at" TIMESTAMPTZ,
  "student_id" BIGINT,
  "number_of_days" BIGINT,
  "payment_group" TEXT,
  "balance" NUMERIC,
  "days_consumed" BIGINT,
  "days_remaining" BIGINT,
  "location" TEXT
);

-- Table: schools_mealconsumption
CREATE TABLE IF NOT EXISTS "schools_mealconsumption" (
  "id" BIGSERIAL PRIMARY KEY,
  "meal_type" TEXT,
  "consumption_date" DATE,
  "notes" TEXT,
  "created_at" TIMESTAMPTZ,
  "updated_at" TIMESTAMPTZ,
  "meal_payment_id" BIGINT,
  "served_by_id" BIGINT,
  "student_id" BIGINT
);

-- Table: schools_syncstatus
CREATE TABLE IF NOT EXISTS "schools_syncstatus" (
  "id" BIGSERIAL PRIMARY KEY,
  "is_online" BOOLEAN,
  "last_sync_attempt" TIMESTAMPTZ,
  "last_successful_sync" TIMESTAMPTZ,
  "pending_count" BIGINT,
  "failed_count" BIGINT,
  "auto_sync_enabled" BOOLEAN,
  "sync_interval_minutes" BIGINT,
  "max_retry_attempts" BIGINT,
  "sync_on_startup" BOOLEAN
);

-- Table: schools_syncqueue
CREATE TABLE IF NOT EXISTS "schools_syncqueue" (
  "id" BIGSERIAL PRIMARY KEY,
  "operation_type" TEXT,
  "model_name" TEXT,
  "model_id" BIGINT,
  "local_id" BIGINT,
  "data" TEXT,
  "status" TEXT,
  "retry_count" BIGINT,
  "last_error" TEXT,
  "created_at" TIMESTAMPTZ,
  "synced_at" TIMESTAMPTZ,
  "updated_at" TIMESTAMPTZ,
  "notes" TEXT,
  "user_id" BIGINT
);

-- Table: schools_employeeattendance
CREATE TABLE IF NOT EXISTS "schools_employeeattendance" (
  "id" BIGSERIAL PRIMARY KEY,
  "date" DATE,
  "status" TEXT,
  "check_in" TIME,
  "check_out" TIME,
  "remarks" TEXT,
  "created_at" TIMESTAMPTZ,
  "updated_at" TIMESTAMPTZ,
  "employee_id" BIGINT,
  "recorded_by_id" BIGINT
);

-- Table: schools_expense
CREATE TABLE IF NOT EXISTS "schools_expense" (
  "id" BIGSERIAL PRIMARY KEY,
  "title" TEXT,
  "amount" NUMERIC,
  "category" TEXT,
  "description" TEXT,
  "date" DATE,
  "vendor" TEXT,
  "payment_method" TEXT,
  "receipt_number" TEXT,
  "created_at" TIMESTAMPTZ,
  "updated_at" TIMESTAMPTZ,
  "created_by_id" BIGINT
);

-- Table: finance_feecategory
CREATE TABLE IF NOT EXISTS "finance_feecategory" (
  "id" BIGSERIAL PRIMARY KEY,
  "name" TEXT,
  "description" TEXT
);

-- Table: finance_feestructure
CREATE TABLE IF NOT EXISTS "finance_feestructure" (
  "id" BIGSERIAL PRIMARY KEY,
  "term" BIGINT,
  "academic_year" TEXT,
  "amount" NUMERIC,
  "is_mandatory" BOOLEAN,
  "description" TEXT,
  "created_at" TIMESTAMPTZ,
  "category_id" BIGINT,
  "grade_id" BIGINT
);

-- Table: finance_studentfinanceaccount
CREATE TABLE IF NOT EXISTS "finance_studentfinanceaccount" (
  "id" BIGSERIAL PRIMARY KEY,
  "total_billed" NUMERIC,
  "total_paid" NUMERIC,
  "balance" NUMERIC,
  "last_updated" TIMESTAMPTZ,
  "student_id" BIGINT
);

-- Table: finance_transaction
CREATE TABLE IF NOT EXISTS "finance_transaction" (
  "id" BIGSERIAL PRIMARY KEY,
  "type" TEXT,
  "amount" NUMERIC,
  "description" TEXT,
  "reference" TEXT,
  "payment_method" TEXT,
  "term" BIGINT,
  "academic_year" TEXT,
  "date" TIMESTAMPTZ,
  "account_id" BIGINT,
  "recorded_by_id" BIGINT
);

-- Table: finance_salarystructure
CREATE TABLE IF NOT EXISTS "finance_salarystructure" (
  "id" BIGSERIAL PRIMARY KEY,
  "base_salary" NUMERIC,
  "allowances" NUMERIC,
  "deductions" NUMERIC,
  "updated_at" TIMESTAMPTZ,
  "user_id" BIGINT,
  "loans" NUMERIC,
  "nssf" NUMERIC
);

-- Table: finance_payrollrecord
CREATE TABLE IF NOT EXISTS "finance_payrollrecord" (
  "id" BIGSERIAL PRIMARY KEY,
  "month" DATE,
  "base_salary" NUMERIC,
  "allowances" NUMERIC,
  "deductions" NUMERIC,
  "bonus" NUMERIC,
  "net_salary" NUMERIC,
  "status" TEXT,
  "payment_method" TEXT,
  "transaction_ref" TEXT,
  "generated_at" TIMESTAMPTZ,
  "paid_at" TIMESTAMPTZ,
  "user_id" BIGINT,
  "loans" NUMERIC,
  "nssf" NUMERIC,
  "advances" NUMERIC
);

-- Table: food_mealitem
CREATE TABLE IF NOT EXISTS "food_mealitem" (
  "id" BIGSERIAL PRIMARY KEY,
  "name" TEXT,
  "description" TEXT,
  "cost" NUMERIC,
  "billing_cycle" TEXT,
  "active" BOOLEAN,
  "created_at" TIMESTAMPTZ,
  "per_serving_cost" NUMERIC
);

-- Table: food_foodstudentaccount
CREATE TABLE IF NOT EXISTS "food_foodstudentaccount" (
  "id" BIGSERIAL PRIMARY KEY,
  "balance" NUMERIC,
  "active" BOOLEAN,
  "total_billed" NUMERIC,
  "total_paid" NUMERIC,
  "updated_at" TIMESTAMPTZ,
  "student_id" BIGINT
);

-- Table: food_foodtransaction
CREATE TABLE IF NOT EXISTS "food_foodtransaction" (
  "id" BIGSERIAL PRIMARY KEY,
  "type" TEXT,
  "amount" NUMERIC,
  "description" TEXT,
  "reference" TEXT,
  "payment_method" TEXT,
  "date" TIMESTAMPTZ,
  "account_id" BIGINT,
  "recorded_by_id" BIGINT
);

-- Table: food_foodsubscription
CREATE TABLE IF NOT EXISTS "food_foodsubscription" (
  "id" BIGSERIAL PRIMARY KEY,
  "start_date" DATE,
  "end_date" DATE,
  "active" BOOLEAN,
  "account_id" BIGINT,
  "meal_item_id" BIGINT
);

-- Table: transport_route
CREATE TABLE IF NOT EXISTS "transport_route" (
  "id" BIGSERIAL PRIMARY KEY,
  "name" TEXT,
  "description" TEXT,
  "cost_per_term" NUMERIC,
  "cost_per_month" NUMERIC,
  "pickup_points" TEXT,
  "active" BOOLEAN,
  "created_at" TIMESTAMPTZ,
  "map_embed_code" TEXT
);

-- Table: transport_transportvehicle
CREATE TABLE IF NOT EXISTS "transport_transportvehicle" (
  "id" BIGSERIAL PRIMARY KEY,
  "plate_number" TEXT,
  "model" TEXT,
  "capacity" TEXT,
  "status" TEXT,
  "created_at" TIMESTAMPTZ,
  "route_id" BIGINT
);

-- Table: transport_transportdriver
CREATE TABLE IF NOT EXISTS "transport_transportdriver" (
  "id" BIGSERIAL PRIMARY KEY,
  "first_name" TEXT,
  "last_name" TEXT,
  "license_number" TEXT,
  "status" TEXT,
  "joined_at" DATE,
  "vehicle_id" BIGINT,
  "user_id" BIGINT,
  "phone_number" TEXT
);

-- Table: transport_transportstudentaccount
CREATE TABLE IF NOT EXISTS "transport_transportstudentaccount" (
  "id" BIGSERIAL PRIMARY KEY,
  "balance" NUMERIC,
  "active" BOOLEAN,
  "total_billed" NUMERIC,
  "total_paid" NUMERIC,
  "updated_at" TIMESTAMPTZ,
  "student_id" BIGINT
);

-- Table: transport_transportassignment
CREATE TABLE IF NOT EXISTS "transport_transportassignment" (
  "id" BIGSERIAL PRIMARY KEY,
  "start_date" DATE,
  "end_date" DATE,
  "active" BOOLEAN,
  "pickup_point" TEXT,
  "route_id" BIGINT,
  "account_id" BIGINT,
  "pickup_location_embed" TEXT,
  "latitude" DOUBLE PRECISION,
  "longitude" DOUBLE PRECISION
);

-- Table: transport_transporttransaction
CREATE TABLE IF NOT EXISTS "transport_transporttransaction" (
  "id" BIGSERIAL PRIMARY KEY,
  "type" TEXT,
  "amount" NUMERIC,
  "description" TEXT,
  "reference" TEXT,
  "payment_method" TEXT,
  "date" TIMESTAMPTZ,
  "account_id" BIGINT,
  "recorded_by_id" BIGINT
);

-- Table: transport_transportadvancerequest
CREATE TABLE IF NOT EXISTS "transport_transportadvancerequest" (
  "id" BIGSERIAL PRIMARY KEY,
  "amount" NUMERIC,
  "reason" TEXT,
  "status" TEXT,
  "action_date" TIMESTAMPTZ,
  "created_at" TIMESTAMPTZ,
  "action_by_id" BIGINT,
  "driver_id" BIGINT
);

-- Table: transport_transportexpense
CREATE TABLE IF NOT EXISTS "transport_transportexpense" (
  "id" BIGSERIAL PRIMARY KEY,
  "expense_type" TEXT,
  "amount" NUMERIC,
  "description" TEXT,
  "receipt_image" TEXT,
  "date" DATE,
  "status" TEXT,
  "action_date" TIMESTAMPTZ,
  "created_at" TIMESTAMPTZ,
  "action_by_id" BIGINT,
  "driver_id" BIGINT,
  "vehicle_id" BIGINT
);

-- Table: transport_transportleaverequest
CREATE TABLE IF NOT EXISTS "transport_transportleaverequest" (
  "id" BIGSERIAL PRIMARY KEY,
  "start_date" DATE,
  "end_date" DATE,
  "reason" TEXT,
  "status" TEXT,
  "action_date" TIMESTAMPTZ,
  "created_at" TIMESTAMPTZ,
  "action_by_id" BIGINT,
  "driver_id" BIGINT
);

-- ============================================================
-- SECTION 2: INSERT DATA
-- ============================================================

-- django_content_type (65 rows)
INSERT INTO "django_content_type" ("id", "app_label", "model") VALUES
  (1, 'admin', 'logentry'),
  (2, 'auth', 'permission'),
  (3, 'auth', 'group'),
  (4, 'auth', 'user'),
  (5, 'contenttypes', 'contenttype'),
  (6, 'sessions', 'session'),
  (7, 'schools', 'employee'),
  (8, 'schools', 'grade'),
  (9, 'schools', 'school'),
  (10, 'schools', 'subject'),
  (11, 'schools', 'term'),
  (12, 'schools', 'student'),
  (13, 'schools', 'salary'),
  (14, 'schools', 'payment'),
  (15, 'schools', 'leave'),
  (16, 'schools', 'deduction'),
  (17, 'schools', 'assessment'),
  (18, 'schools', 'allowance'),
  (19, 'schools', 'teacher'),
  (20, 'schools', 'schedule'),
  (21, 'schools', 'attendance'),
  (22, 'schools', 'assessmentresult'),
  (23, 'schools', 'announcement'),
  (24, 'schools', 'smsmessage'),
  (25, 'schools', 'department'),
  (26, 'schools', 'employeeattendance'),
  (27, 'schools', 'route'),
  (28, 'schools', 'transportfee'),
  (29, 'schools', 'vehicle'),
  (30, 'schools', 'studenttransportassignment'),
  (31, 'schools', 'foodfee'),
  (32, 'schools', 'studentfoodassignment'),
  (33, 'schools', 'foodplan'),
  (34, 'schools', 'studentmealpayment'),
  (35, 'schools', 'mealpricing'),
  (36, 'schools', 'mealconsumption'),
  (37, 'schools', 'syncstatus'),
  (38, 'schools', 'syncqueue'),
  (39, 'config', 'schoolconfig'),
  (40, 'schools', 'branch'),
  (41, 'schools', 'salaryadvance'),
  (42, 'schools', 'leaveapproval'),
  (43, 'schools', 'advanceapproval'),
  (44, 'schools', 'nonteachingstaff'),
  (45, 'schools', 'staffdocument'),
  (46, 'finance', 'studentfinanceaccount'),
  (47, 'finance', 'transaction'),
  (48, 'finance', 'feestructure'),
  (49, 'finance', 'feecategory'),
  (50, 'food', 'foodsubscription'),
  (51, 'food', 'foodtransaction'),
  (52, 'food', 'mealitem'),
  (53, 'food', 'foodstudentaccount'),
  (54, 'transport', 'route'),
  (55, 'transport', 'transportassignment'),
  (56, 'transport', 'transportstudentaccount'),
  (57, 'transport', 'transporttransaction'),
  (58, 'transport', 'transportdriver'),
  (59, 'transport', 'transportvehicle'),
  (60, 'transport', 'transportexpense'),
  (61, 'transport', 'transportleaverequest'),
  (62, 'transport', 'transportadvancerequest'),
  (63, 'finance', 'salarystructure'),
  (64, 'finance', 'payrollrecord'),
  (65, 'schools', 'expense')
ON CONFLICT DO NOTHING;

-- auth_permission (260 rows)
INSERT INTO "auth_permission" ("id", "content_type_id", "codename", "name") VALUES
  (1, 1, 'add_logentry', 'Can add log entry'),
  (2, 1, 'change_logentry', 'Can change log entry'),
  (3, 1, 'delete_logentry', 'Can delete log entry'),
  (4, 1, 'view_logentry', 'Can view log entry'),
  (5, 2, 'add_permission', 'Can add permission'),
  (6, 2, 'change_permission', 'Can change permission'),
  (7, 2, 'delete_permission', 'Can delete permission'),
  (8, 2, 'view_permission', 'Can view permission'),
  (9, 3, 'add_group', 'Can add group'),
  (10, 3, 'change_group', 'Can change group'),
  (11, 3, 'delete_group', 'Can delete group'),
  (12, 3, 'view_group', 'Can view group'),
  (13, 4, 'add_user', 'Can add user'),
  (14, 4, 'change_user', 'Can change user'),
  (15, 4, 'delete_user', 'Can delete user'),
  (16, 4, 'view_user', 'Can view user'),
  (17, 5, 'add_contenttype', 'Can add content type'),
  (18, 5, 'change_contenttype', 'Can change content type'),
  (19, 5, 'delete_contenttype', 'Can delete content type'),
  (20, 5, 'view_contenttype', 'Can view content type'),
  (21, 6, 'add_session', 'Can add session'),
  (22, 6, 'change_session', 'Can change session'),
  (23, 6, 'delete_session', 'Can delete session'),
  (24, 6, 'view_session', 'Can view session'),
  (25, 7, 'add_employee', 'Can add employee'),
  (26, 7, 'change_employee', 'Can change employee'),
  (27, 7, 'delete_employee', 'Can delete employee'),
  (28, 7, 'view_employee', 'Can view employee'),
  (29, 8, 'add_grade', 'Can add grade'),
  (30, 8, 'change_grade', 'Can change grade'),
  (31, 8, 'delete_grade', 'Can delete grade'),
  (32, 8, 'view_grade', 'Can view grade'),
  (33, 9, 'add_school', 'Can add school'),
  (34, 9, 'change_school', 'Can change school'),
  (35, 9, 'delete_school', 'Can delete school'),
  (36, 9, 'view_school', 'Can view school'),
  (37, 10, 'add_subject', 'Can add subject'),
  (38, 10, 'change_subject', 'Can change subject'),
  (39, 10, 'delete_subject', 'Can delete subject'),
  (40, 10, 'view_subject', 'Can view subject'),
  (41, 11, 'add_term', 'Can add term'),
  (42, 11, 'change_term', 'Can change term'),
  (43, 11, 'delete_term', 'Can delete term'),
  (44, 11, 'view_term', 'Can view term'),
  (45, 12, 'add_student', 'Can add student'),
  (46, 12, 'change_student', 'Can change student'),
  (47, 12, 'delete_student', 'Can delete student'),
  (48, 12, 'view_student', 'Can view student'),
  (49, 13, 'add_salary', 'Can add salary'),
  (50, 13, 'change_salary', 'Can change salary'),
  (51, 13, 'delete_salary', 'Can delete salary'),
  (52, 13, 'view_salary', 'Can view salary'),
  (53, 14, 'add_payment', 'Can add payment'),
  (54, 14, 'change_payment', 'Can change payment'),
  (55, 14, 'delete_payment', 'Can delete payment'),
  (56, 14, 'view_payment', 'Can view payment'),
  (57, 15, 'add_leave', 'Can add leave'),
  (58, 15, 'change_leave', 'Can change leave'),
  (59, 15, 'delete_leave', 'Can delete leave'),
  (60, 15, 'view_leave', 'Can view leave'),
  (61, 16, 'add_deduction', 'Can add deduction'),
  (62, 16, 'change_deduction', 'Can change deduction'),
  (63, 16, 'delete_deduction', 'Can delete deduction'),
  (64, 16, 'view_deduction', 'Can view deduction'),
  (65, 17, 'add_assessment', 'Can add assessment'),
  (66, 17, 'change_assessment', 'Can change assessment'),
  (67, 17, 'delete_assessment', 'Can delete assessment'),
  (68, 17, 'view_assessment', 'Can view assessment'),
  (69, 18, 'add_allowance', 'Can add allowance'),
  (70, 18, 'change_allowance', 'Can change allowance'),
  (71, 18, 'delete_allowance', 'Can delete allowance'),
  (72, 18, 'view_allowance', 'Can view allowance'),
  (73, 19, 'add_teacher', 'Can add teacher'),
  (74, 19, 'change_teacher', 'Can change teacher'),
  (75, 19, 'delete_teacher', 'Can delete teacher'),
  (76, 19, 'view_teacher', 'Can view teacher'),
  (77, 20, 'add_schedule', 'Can add schedule'),
  (78, 20, 'change_schedule', 'Can change schedule'),
  (79, 20, 'delete_schedule', 'Can delete schedule'),
  (80, 20, 'view_schedule', 'Can view schedule'),
  (81, 21, 'add_attendance', 'Can add attendance'),
  (82, 21, 'change_attendance', 'Can change attendance'),
  (83, 21, 'delete_attendance', 'Can delete attendance'),
  (84, 21, 'view_attendance', 'Can view attendance'),
  (85, 22, 'add_assessmentresult', 'Can add assessment result'),
  (86, 22, 'change_assessmentresult', 'Can change assessment result'),
  (87, 22, 'delete_assessmentresult', 'Can delete assessment result'),
  (88, 22, 'view_assessmentresult', 'Can view assessment result'),
  (89, 23, 'add_announcement', 'Can add announcement'),
  (90, 23, 'change_announcement', 'Can change announcement'),
  (91, 23, 'delete_announcement', 'Can delete announcement'),
  (92, 23, 'view_announcement', 'Can view announcement'),
  (93, 24, 'add_smsmessage', 'Can add sms message'),
  (94, 24, 'change_smsmessage', 'Can change sms message'),
  (95, 24, 'delete_smsmessage', 'Can delete sms message'),
  (96, 24, 'view_smsmessage', 'Can view sms message'),
  (97, 25, 'add_department', 'Can add department'),
  (98, 25, 'change_department', 'Can change department'),
  (99, 25, 'delete_department', 'Can delete department'),
  (100, 25, 'view_department', 'Can view department'),
  (101, 26, 'add_employeeattendance', 'Can add employee attendance'),
  (102, 26, 'change_employeeattendance', 'Can change employee attendance'),
  (103, 26, 'delete_employeeattendance', 'Can delete employee attendance'),
  (104, 26, 'view_employeeattendance', 'Can view employee attendance'),
  (105, 27, 'add_route', 'Can add route'),
  (106, 27, 'change_route', 'Can change route'),
  (107, 27, 'delete_route', 'Can delete route'),
  (108, 27, 'view_route', 'Can view route'),
  (109, 28, 'add_transportfee', 'Can add transport fee'),
  (110, 28, 'change_transportfee', 'Can change transport fee'),
  (111, 28, 'delete_transportfee', 'Can delete transport fee'),
  (112, 28, 'view_transportfee', 'Can view transport fee'),
  (113, 29, 'add_vehicle', 'Can add vehicle'),
  (114, 29, 'change_vehicle', 'Can change vehicle'),
  (115, 29, 'delete_vehicle', 'Can delete vehicle'),
  (116, 29, 'view_vehicle', 'Can view vehicle'),
  (117, 30, 'add_studenttransportassignment', 'Can add student transport assignment'),
  (118, 30, 'change_studenttransportassignment', 'Can change student transport assignment'),
  (119, 30, 'delete_studenttransportassignment', 'Can delete student transport assignment'),
  (120, 30, 'view_studenttransportassignment', 'Can view student transport assignment'),
  (121, 31, 'add_foodfee', 'Can add food fee'),
  (122, 31, 'change_foodfee', 'Can change food fee'),
  (123, 31, 'delete_foodfee', 'Can delete food fee'),
  (124, 31, 'view_foodfee', 'Can view food fee'),
  (125, 32, 'add_studentfoodassignment', 'Can add student food assignment'),
  (126, 32, 'change_studentfoodassignment', 'Can change student food assignment'),
  (127, 32, 'delete_studentfoodassignment', 'Can delete student food assignment'),
  (128, 32, 'view_studentfoodassignment', 'Can view student food assignment'),
  (129, 33, 'add_foodplan', 'Can add food plan'),
  (130, 33, 'change_foodplan', 'Can change food plan'),
  (131, 33, 'delete_foodplan', 'Can delete food plan'),
  (132, 33, 'view_foodplan', 'Can view food plan'),
  (133, 34, 'add_studentmealpayment', 'Can add student meal payment'),
  (134, 34, 'change_studentmealpayment', 'Can change student meal payment'),
  (135, 34, 'delete_studentmealpayment', 'Can delete student meal payment'),
  (136, 34, 'view_studentmealpayment', 'Can view student meal payment'),
  (137, 35, 'add_mealpricing', 'Can add meal pricing'),
  (138, 35, 'change_mealpricing', 'Can change meal pricing'),
  (139, 35, 'delete_mealpricing', 'Can delete meal pricing'),
  (140, 35, 'view_mealpricing', 'Can view meal pricing'),
  (141, 36, 'add_mealconsumption', 'Can add meal consumption'),
  (142, 36, 'change_mealconsumption', 'Can change meal consumption'),
  (143, 36, 'delete_mealconsumption', 'Can delete meal consumption'),
  (144, 36, 'view_mealconsumption', 'Can view meal consumption'),
  (145, 37, 'add_syncstatus', 'Can add Sync Status'),
  (146, 37, 'change_syncstatus', 'Can change Sync Status'),
  (147, 37, 'delete_syncstatus', 'Can delete Sync Status'),
  (148, 37, 'view_syncstatus', 'Can view Sync Status'),
  (149, 38, 'add_syncqueue', 'Can add sync queue'),
  (150, 38, 'change_syncqueue', 'Can change sync queue'),
  (151, 38, 'delete_syncqueue', 'Can delete sync queue'),
  (152, 38, 'view_syncqueue', 'Can view sync queue'),
  (153, 39, 'add_schoolconfig', 'Can add School Configuration'),
  (154, 39, 'change_schoolconfig', 'Can change School Configuration'),
  (155, 39, 'delete_schoolconfig', 'Can delete School Configuration'),
  (156, 39, 'view_schoolconfig', 'Can view School Configuration'),
  (157, 40, 'add_branch', 'Can add branch'),
  (158, 40, 'change_branch', 'Can change branch'),
  (159, 40, 'delete_branch', 'Can delete branch'),
  (160, 40, 'view_branch', 'Can view branch'),
  (161, 41, 'add_salaryadvance', 'Can add salary advance'),
  (162, 41, 'change_salaryadvance', 'Can change salary advance'),
  (163, 41, 'delete_salaryadvance', 'Can delete salary advance'),
  (164, 41, 'view_salaryadvance', 'Can view salary advance'),
  (165, 42, 'add_leaveapproval', 'Can add leave approval'),
  (166, 42, 'change_leaveapproval', 'Can change leave approval'),
  (167, 42, 'delete_leaveapproval', 'Can delete leave approval'),
  (168, 42, 'view_leaveapproval', 'Can view leave approval'),
  (169, 43, 'add_advanceapproval', 'Can add advance approval'),
  (170, 43, 'change_advanceapproval', 'Can change advance approval'),
  (171, 43, 'delete_advanceapproval', 'Can delete advance approval'),
  (172, 43, 'view_advanceapproval', 'Can view advance approval'),
  (173, 44, 'add_nonteachingstaff', 'Can add Non-Teaching Staff'),
  (174, 44, 'change_nonteachingstaff', 'Can change Non-Teaching Staff'),
  (175, 44, 'delete_nonteachingstaff', 'Can delete Non-Teaching Staff'),
  (176, 44, 'view_nonteachingstaff', 'Can view Non-Teaching Staff'),
  (177, 45, 'add_staffdocument', 'Can add staff document'),
  (178, 45, 'change_staffdocument', 'Can change staff document'),
  (179, 45, 'delete_staffdocument', 'Can delete staff document'),
  (180, 45, 'view_staffdocument', 'Can view staff document'),
  (181, 46, 'add_studentfinanceaccount', 'Can add student finance account'),
  (182, 46, 'change_studentfinanceaccount', 'Can change student finance account'),
  (183, 46, 'delete_studentfinanceaccount', 'Can delete student finance account'),
  (184, 46, 'view_studentfinanceaccount', 'Can view student finance account'),
  (185, 47, 'add_transaction', 'Can add transaction'),
  (186, 47, 'change_transaction', 'Can change transaction'),
  (187, 47, 'delete_transaction', 'Can delete transaction'),
  (188, 47, 'view_transaction', 'Can view transaction'),
  (189, 48, 'add_feestructure', 'Can add fee structure'),
  (190, 48, 'change_feestructure', 'Can change fee structure'),
  (191, 48, 'delete_feestructure', 'Can delete fee structure'),
  (192, 48, 'view_feestructure', 'Can view fee structure'),
  (193, 49, 'add_feecategory', 'Can add fee category'),
  (194, 49, 'change_feecategory', 'Can change fee category'),
  (195, 49, 'delete_feecategory', 'Can delete fee category'),
  (196, 49, 'view_feecategory', 'Can view fee category'),
  (197, 50, 'add_foodsubscription', 'Can add food subscription'),
  (198, 50, 'change_foodsubscription', 'Can change food subscription'),
  (199, 50, 'delete_foodsubscription', 'Can delete food subscription'),
  (200, 50, 'view_foodsubscription', 'Can view food subscription')
ON CONFLICT DO NOTHING;
INSERT INTO "auth_permission" ("id", "content_type_id", "codename", "name") VALUES
  (201, 51, 'add_foodtransaction', 'Can add food transaction'),
  (202, 51, 'change_foodtransaction', 'Can change food transaction'),
  (203, 51, 'delete_foodtransaction', 'Can delete food transaction'),
  (204, 51, 'view_foodtransaction', 'Can view food transaction'),
  (205, 52, 'add_mealitem', 'Can add meal item'),
  (206, 52, 'change_mealitem', 'Can change meal item'),
  (207, 52, 'delete_mealitem', 'Can delete meal item'),
  (208, 52, 'view_mealitem', 'Can view meal item'),
  (209, 53, 'add_foodstudentaccount', 'Can add food student account'),
  (210, 53, 'change_foodstudentaccount', 'Can change food student account'),
  (211, 53, 'delete_foodstudentaccount', 'Can delete food student account'),
  (212, 53, 'view_foodstudentaccount', 'Can view food student account'),
  (213, 54, 'add_route', 'Can add route'),
  (214, 54, 'change_route', 'Can change route'),
  (215, 54, 'delete_route', 'Can delete route'),
  (216, 54, 'view_route', 'Can view route'),
  (217, 55, 'add_transportassignment', 'Can add transport assignment'),
  (218, 55, 'change_transportassignment', 'Can change transport assignment'),
  (219, 55, 'delete_transportassignment', 'Can delete transport assignment'),
  (220, 55, 'view_transportassignment', 'Can view transport assignment'),
  (221, 56, 'add_transportstudentaccount', 'Can add transport student account'),
  (222, 56, 'change_transportstudentaccount', 'Can change transport student account'),
  (223, 56, 'delete_transportstudentaccount', 'Can delete transport student account'),
  (224, 56, 'view_transportstudentaccount', 'Can view transport student account'),
  (225, 57, 'add_transporttransaction', 'Can add transport transaction'),
  (226, 57, 'change_transporttransaction', 'Can change transport transaction'),
  (227, 57, 'delete_transporttransaction', 'Can delete transport transaction'),
  (228, 57, 'view_transporttransaction', 'Can view transport transaction'),
  (229, 58, 'add_transportdriver', 'Can add transport driver'),
  (230, 58, 'change_transportdriver', 'Can change transport driver'),
  (231, 58, 'delete_transportdriver', 'Can delete transport driver'),
  (232, 58, 'view_transportdriver', 'Can view transport driver'),
  (233, 59, 'add_transportvehicle', 'Can add transport vehicle'),
  (234, 59, 'change_transportvehicle', 'Can change transport vehicle'),
  (235, 59, 'delete_transportvehicle', 'Can delete transport vehicle'),
  (236, 59, 'view_transportvehicle', 'Can view transport vehicle'),
  (237, 60, 'add_transportexpense', 'Can add transport expense'),
  (238, 60, 'change_transportexpense', 'Can change transport expense'),
  (239, 60, 'delete_transportexpense', 'Can delete transport expense'),
  (240, 60, 'view_transportexpense', 'Can view transport expense'),
  (241, 61, 'add_transportleaverequest', 'Can add transport leave request'),
  (242, 61, 'change_transportleaverequest', 'Can change transport leave request'),
  (243, 61, 'delete_transportleaverequest', 'Can delete transport leave request'),
  (244, 61, 'view_transportleaverequest', 'Can view transport leave request'),
  (245, 62, 'add_transportadvancerequest', 'Can add transport advance request'),
  (246, 62, 'change_transportadvancerequest', 'Can change transport advance request'),
  (247, 62, 'delete_transportadvancerequest', 'Can delete transport advance request'),
  (248, 62, 'view_transportadvancerequest', 'Can view transport advance request'),
  (249, 63, 'add_salarystructure', 'Can add salary structure'),
  (250, 63, 'change_salarystructure', 'Can change salary structure'),
  (251, 63, 'delete_salarystructure', 'Can delete salary structure'),
  (252, 63, 'view_salarystructure', 'Can view salary structure'),
  (253, 64, 'add_payrollrecord', 'Can add payroll record'),
  (254, 64, 'change_payrollrecord', 'Can change payroll record'),
  (255, 64, 'delete_payrollrecord', 'Can delete payroll record'),
  (256, 64, 'view_payrollrecord', 'Can view payroll record'),
  (257, 65, 'add_expense', 'Can add expense'),
  (258, 65, 'change_expense', 'Can change expense'),
  (259, 65, 'delete_expense', 'Can delete expense'),
  (260, 65, 'view_expense', 'Can view expense')
ON CONFLICT DO NOTHING;

-- auth_group (3 rows)
INSERT INTO "auth_group" ("id", "name") VALUES
  (1, 'Students'),
  (2, 'Teachers'),
  (3, 'Admin Staff')
ON CONFLICT DO NOTHING;

-- auth_user (783 rows)
INSERT INTO "auth_user" ("id", "password", "last_login", "is_superuser", "username", "last_name", "email", "is_staff", "is_active", "date_joined", "first_name") VALUES
  (1, 'pbkdf2_sha256$1000000$czGn6vyEpnZl3mn9KRc7zV$2Q/kdZ/UTC0qK2YmHbnntSkTg+/kiQ5KBNozLRwTrGw=', '2025-12-12 12:18:57.006334', TRUE, 'Administration', 'Schools', 'amosorupia24@gmail.com', TRUE, TRUE, '2025-01-18 15:21:20', 'The Ransomed'),
  (12, 'pbkdf2_sha256$600000$GnypT0lSMbZ7NSnbc939Hc$T61NBMn4p20AfzUQ86PdwRX3VPV+vJZxYxA26nHJhbE=', NULL, FALSE, 'STD25005', 'Britamu', 'asiashiu@gmail.com', FALSE, TRUE, '2025-02-04 12:30:45.034060', 'Amos'),
  (15, 'pbkdf2_sha256$600000$12BRNjEl9pdE3FuEDKG7DF$x45OnCGHnfVTuxRCxpM6AvdjgEHAPvmfr1nli0Cxwu8=', NULL, FALSE, 'STD25006', 'MISANGO', 'puritynjoroge8702@gmail.com', FALSE, TRUE, '2025-02-05 10:38:08.169055', 'DICKSON'),
  (17, 'pbkdf2_sha256$600000$ZDB7kNZKFlWhfMrmNts1L7$mvmQ/xD6Kr8B718jJYU0b9OMfGOoPH3WimjtNFX9e9o=', '2025-02-06 12:05:59.943928', FALSE, 'STD25007', 'Nick', 'phanice@gmail.com', FALSE, TRUE, '2025-02-06 11:55:10.156491', 'Hamara'),
  (18, 'pbkdf2_sha256$600000$ar8s8AAqv5740PZJu15wGz$9C+ROjw9jepyMNGmD9QwJ88mKkLbyI/oxdObpOrqWeA=', '2025-08-01 11:06:17.565019', FALSE, 'HT', 'Iss', 'raelissa@gmail.com', TRUE, TRUE, '2025-02-06 14:38:21', 'Rachael'),
  (20, 'pbkdf2_sha256$870000$dHpeaqmzftf7RkZGOiVXO4$LAGUfOzIA9/qjlTcnSwRKQS0/wYLkJ0n7c+lC1L+ELg=', '2025-02-10 15:02:18.048548', FALSE, 'STD25001', 'Muturiiko', 'puritynjoroge8780@gmail.com', FALSE, TRUE, '2025-02-06 17:17:27.210118', 'Krisk'),
  (21, 'pbkdf2_sha256$600000$NwVI5Kb2qiSTF8HPsUYIe2$e9O3N/qcAjzcClYogkWl/osEXiKvElDrSuYw9EWouJU=', '2025-02-06 17:41:39.032208', FALSE, 'STD25002', 'Nick', 'amos@gmail.com', FALSE, TRUE, '2025-02-06 17:29:27.994786', 'Gremmy'),
  (22, 'pbkdf2_sha256$870000$3D0VlkC1zm3mCm0tQcl0xw$0pLbbKdGvPqnfVGdfr8OX2OvD6EDWU6nBz8UER53ReA=', NULL, FALSE, 'STD250011', 'Muturio', 'krismuturi@gmail.com', FALSE, TRUE, '2025-02-10 13:35:35.936564', 'Kris'),
  (23, 'pbkdf2_sha256$870000$7F9MsTQRfhaWmHBsUyHswj$EQiMLoUBk9OJZ7PykCbjdo2gaBJZj8YG6jnvZ8pi5Gg=', NULL, FALSE, 'STD250021', 'Nick', 'samuelekirapa@gmail.com', FALSE, TRUE, '2025-02-10 15:25:51.248493', 'Gremmy'),
  (24, 'pbkdf2_sha256$870000$UkR2Lp2agGwH12rE2m8d66$COYrzR5QEQixYdPd0xgKzWuOe3H8f08EUnnlgZkfLiU=', '2025-02-10 15:37:46.755088', FALSE, 'STD250022', 'Nick', 'amoskkiroro@gmail.com', FALSE, TRUE, '2025-02-10 15:37:08.770730', 'Gremmy'),
  (25, 'pbkdf2_sha256$600000$djdS20Rh3LoqBtC6LTzVhK$DzS0Wk0HmTMcruVrE93iRt3NctPI57HLcQSajN03XEw=', '2025-09-28 16:09:37.857721', TRUE, 'Director', 'MBAND', 'apostlemichaelmband@gmsil.com', TRUE, TRUE, '2025-02-10 17:19:22', 'MICHAEL'),
  (26, 'pbkdf2_sha256$600000$oAhr56Au9oEXDRtF4JFwp4$05bJU6jGbA2RLEIdHf6invGchYkPyVp560p4OEeeEdM=', '2025-08-01 11:58:17.947176', FALSE, 'paulinefaith988@gmail.com', 'Onyango', 'paulinefaith988@gmail.com', TRUE, TRUE, '2025-02-11 04:33:43.265427', 'Pauline'),
  (27, 'pbkdf2_sha256$600000$jrLZfDeQla2Yobs66fVF3L$8/rDfsdE5u3S2YJ+Y+kGJ41i/o6k/xB14s6NE/Bptyk=', NULL, FALSE, 'STD250012', 'MARUTI', 'amosorupia24@gmail.com', FALSE, TRUE, '2025-02-11 04:43:06.414537', 'ADRIAN'),
  (28, 'pbkdf2_sha256$600000$zoPJW7wsXq6K9Gkl7w5I2K$ufk5/1Gzzv04tlTlKoAI/LZFt24fCAi+SHyEp1n0hTc=', NULL, FALSE, 'STD250023', 'NIYONYISHU', 'amosorupia24@gmail.com', FALSE, TRUE, '2025-02-11 05:10:24.958320', 'TIERY'),
  (29, 'pbkdf2_sha256$600000$8dX1yyuly8QKZ6vgk22Uqc$jcZPK7f0J5yDdlD3rmndx+uD2QyC0Si117F8cJSsUDw=', NULL, FALSE, 'STD25003', 'MUEMI', 'amosorupia24@gmail.com', FALSE, TRUE, '2025-02-11 05:51:17.663030', 'DANIEL'),
  (30, 'pbkdf2_sha256$600000$hPaMylqV5Lg8v2uPNpQrqB$/wiJOQbC6fyvrNfSGCoADHvO6v1HgMmvQjE/vtpj2Qo=', NULL, FALSE, 'STD25004', 'OBISA', 'ian1@gmail.com', FALSE, TRUE, '2025-02-11 05:56:40.545045', 'IAN'),
  (31, 'pbkdf2_sha256$600000$Npiwr7KPHvIYc5C0n6IdEc$f4fja/PgeElZvPaMFuAyczX7x46w3zC8E2bJ38GKxAI=', NULL, FALSE, 'STD250051', 'MWASAME', 'Lawrence@gmail.com', FALSE, TRUE, '2025-02-11 06:01:30.666677', 'LAWRENCE'),
  (32, 'pbkdf2_sha256$600000$gHsn6eQK3TaDF1RGlVJ9Rv$/MO5z0iDmF3Y4LQx4RvLiRngQVu7gHqboNUpEWA+wlo=', NULL, FALSE, 'STD250061', 'ADEL', 'rio1@gmail.com', FALSE, TRUE, '2025-02-11 06:40:40.327789', 'RIO'),
  (33, 'pbkdf2_sha256$600000$m64toVtKrY9JSPwjqDVI9F$qZ2Cx7AXa/x+HLrTq6ru5wgZqEjA/QY79W07oANBwoU=', NULL, FALSE, 'STD250071', 'MARLEEN', 'arianna@gmail.com', FALSE, TRUE, '2025-02-11 07:15:27.111354', 'ARIANNA'),
  (34, 'pbkdf2_sha256$600000$eadbHMvDK7VPzfJP7IMkI9$NhBBz0N6DCLsOxP50uL60kDMXk9fJ3yCy7aTiuimV8s=', NULL, FALSE, 'STD25008', 'NDANU', 'arianna@gmail.com', FALSE, TRUE, '2025-02-11 07:26:04.924751', 'CHRISTINE'),
  (35, 'pbkdf2_sha256$600000$oMnd3wgDNVgG87rxvSdsnN$mh69fRiLYhyRXksODbN7BDK5bMHMEEsboBCRRTxarug=', NULL, FALSE, 'STD25009', 'PENDO', 'angel@gmail.com', FALSE, TRUE, '2025-02-11 07:29:43.514619', 'ANGEL'),
  (36, 'pbkdf2_sha256$600000$vLQklIf0SqngaLXuz7mTKK$PzJYfjQ/vTCLAVSSIWzypn/K+Y4jpyJDA7iTKxHvtvg=', NULL, FALSE, 'STD25010', 'KIRITI', '', FALSE, TRUE, '2025-02-11 07:38:03.327525', 'ANGEL'),
  (37, 'pbkdf2_sha256$600000$o9DP2cpVcBY1iQIWhfd67A$Va4AFvmLGNuOLk7IxZO3r2n6YzNj/MUZtAFAmp8uieo=', NULL, FALSE, 'STD25011', 'KHASIMWA', 'khasimwa@gmail.com', FALSE, TRUE, '2025-02-11 07:42:55.746743', 'BLUE IVY'),
  (38, 'pbkdf2_sha256$600000$rX8vmwr44h6ASLIvkNYPy0$pCPPZQnoqB18fXxyUrXUN4TzAFc0pA6GK0eekRz78g4=', NULL, FALSE, 'STD25012', 'WEKESA', '', FALSE, TRUE, '2025-02-11 08:21:51.609302', 'EMMANUEL'),
  (39, 'pbkdf2_sha256$600000$s25SgEhCdKD9pukxXnUpaw$7H+E60WohdESPnLwtmpI8AhlyFrMjqfqtnKBLZ/G2FI=', NULL, FALSE, 'STD25013', 'WANGUI', 'abigael@gmail.com', FALSE, TRUE, '2025-02-11 08:27:10.909451', 'ABIGAEL'),
  (40, 'pbkdf2_sha256$600000$Ks2JrL1kREdvsjBNLNtcm8$ActPPUCqc8O68V1ekBbvtGBDZV2+OxPFqJVV88ypYhg=', NULL, FALSE, 'STD25014', 'TRIXIE', 'lovely@gmail.com', FALSE, TRUE, '2025-02-11 08:30:02.506483', 'LOVELY'),
  (41, 'pbkdf2_sha256$600000$1GRn233HsMtm1T1BToajvd$FxqKJgRLsSNjnOTTiEyuCAXERHf+JluPvE6o+oYlaWc=', NULL, FALSE, 'STD25015', 'BUSOKA', 'lovely@gmail.com', FALSE, TRUE, '2025-02-11 08:33:51.894850', 'DAN'),
  (42, 'pbkdf2_sha256$600000$6BTWGSzKC4Ay14Hz4LHARF$oMBoUfluxWoBaiIs3+LsMusdbP8lVSYLMZXxK/WNiS0=', NULL, FALSE, 'STD250017', 'Nantume', 'lovely@gmail.com', FALSE, TRUE, '2025-02-11 08:36:43.621995', 'Jackline'),
  (43, 'pbkdf2_sha256$600000$HMGgqKYxmfWi9LEfGTUeDO$gv5MlcNRriA56GPyJULIsZ1X2XXpyB3CRJp63Nf3jkk=', NULL, FALSE, 'STD250018', 'NYAMBURA', 'jaz@gmail.com', FALSE, TRUE, '2025-02-11 08:43:55.726445', 'JAZMINE'),
  (44, 'pbkdf2_sha256$600000$MW0MJne32kjRT1gqiByiX2$C2FtKgOpWxU2SDDQJL9057oAkoF+505I5+l6ZYJnloM=', NULL, FALSE, 'STD25016', 'NANTUME', 'jackline@gmail.com', FALSE, TRUE, '2025-02-11 08:48:38.762051', 'JACKLINE'),
  (45, 'pbkdf2_sha256$600000$K4g8gwjSJRMrrUF14MhdbM$Tbl5KdNA31qVFgo1Qq4s8iKUrTD76IQtLNtvTc8adpE=', NULL, FALSE, 'STD25017', 'NYAMBURA', 'jazzmine@gmail.com', FALSE, TRUE, '2025-02-11 08:54:14.422157', 'JAZMINE'),
  (46, 'pbkdf2_sha256$600000$JeouQivB55WWSAMXFsDj9x$QTisZIUdDlTZ6nqPIWB1Yjw6TLnkBTfNFFgxIMmczD8=', NULL, FALSE, 'STD25018', 'OGOLLA', 'ogolla@gmail.com', FALSE, TRUE, '2025-02-11 09:00:05.061461', 'ANTHONY'),
  (47, 'pbkdf2_sha256$600000$VQH9xFGbwa9XLSwAidKQsc$jAT1NTpX26wbStUc37vvH+xTlgnGXQi/5i9QpJu5LQ8=', NULL, FALSE, 'STD25019', 'OMBUNA', 'iyan@gmail.com', FALSE, TRUE, '2025-02-11 09:05:14.568030', 'IAN'),
  (48, 'pbkdf2_sha256$600000$WT597xguQx9Epk5OMqusKV$2zwGArfT9On+UQTbEVv1347R9TeIlS0AqrnJju36O/c=', NULL, FALSE, 'STD25020', 'ODIEKI', 'larry@gmail.com', FALSE, TRUE, '2025-02-11 09:10:22.324385', 'LARRY'),
  (49, 'pbkdf2_sha256$600000$ooJCILXyXSB7EqMoVrSrET$kXVOzkqTLOea6JGAgRqDPE7TZP24MKMTgq76Ddddxwc=', NULL, FALSE, 'STD22021', 'NYAKARO', 'nyakaro@gmail.com', FALSE, TRUE, '2025-02-11 09:29:26.246609', 'ESTHER'),
  (50, 'pbkdf2_sha256$600000$sSbxnY7B1uFU5rWqUEkF0Z$zF6V0jEZX6itx/MF5c3UkR3FxRdIpPCRjYCgk6FszJ0=', NULL, FALSE, 'STD25022', 'WEKESA', '', FALSE, TRUE, '2025-02-11 09:45:52.954807', 'GIDEON'),
  (51, 'pbkdf2_sha256$600000$EXdmlgYG8aFqVi4h7so6hY$9SyuO4xhPv2QXyMACM8ra9hj1MPqrplipVBpJiK8+v0=', NULL, FALSE, 'STD25024', 'UWASE', 'naomi@gmail.com', FALSE, TRUE, '2025-02-11 09:50:42.052593', 'NAOMI'),
  (52, 'pbkdf2_sha256$600000$83YXCv63zmFMwwrZEcP2Ij$Dkt0sz9dmxNiLot1YsYnriM2QzclN+1mcq+Bt/GGHMM=', NULL, FALSE, 'STD22023', 'BAHATI', 'alicia@gmail.com', FALSE, TRUE, '2025-02-11 09:57:05.222228', 'ALICIA'),
  (53, 'pbkdf2_sha256$600000$giWpd98UMcbp5kGxrF9CX5$LRNzmM/lZZ+n5SZu9JOv638XqVXH92IbnrwcUAgnf7M=', NULL, FALSE, 'STD25023', 'BAHATI', 'alicia@gmail.com', FALSE, TRUE, '2025-02-11 09:59:44.473894', 'ALICIA'),
  (54, 'pbkdf2_sha256$600000$Olc00Spw4YVs0lyuZ1WAtT$RZdzE4Kues+YkVafXC1vl3pVtyDy6diDj+JZ9c/V7Sw=', NULL, FALSE, 'STD250241', 'UWASE', '', FALSE, TRUE, '2025-02-11 10:01:25.965746', 'NAOMI'),
  (55, 'pbkdf2_sha256$600000$J2ewrnxR2jfCeJB4qegOnA$VSOvWPbaBOn0Cu1XGMHhDJF20h2ArK9BJUj2p4yHHnI=', NULL, FALSE, 'STD25025', 'ATIENO', '', FALSE, TRUE, '2025-02-11 10:03:58.966815', 'SHANYQUE'),
  (56, 'pbkdf2_sha256$600000$FvifVGYFAbH9qGLSo9pS6k$BgdY+4wEQf4hcf4IGFNY9pBPY40tqLaSlxJ8C5BJRV0=', NULL, FALSE, 'STD25026', 'MUTHEU', '', FALSE, TRUE, '2025-02-11 10:08:32.940619', 'GLORIA'),
  (57, 'pbkdf2_sha256$600000$M2nX4FrQcwAW7v0LVP9QoO$FJiEOtvL+O4zAHJRjBuyjVVaecsj88hbdgFcCTs64NM=', NULL, FALSE, 'STD25027', 'MUTONI', 'esther@gmail.com', FALSE, TRUE, '2025-02-11 10:13:41.170100', 'ESTHER'),
  (58, 'pbkdf2_sha256$600000$UwLI1qA785m00oD6xtpc4u$Nm/BOQUucjCBaYkl2N8AyeKJXwesvNm9Z5DgRs+73AE=', NULL, FALSE, 'STD25028', 'OWITI', 'jonathan@gmail.com', FALSE, TRUE, '2025-02-11 10:31:27.523343', 'JONATHAN'),
  (59, 'pbkdf2_sha256$600000$wgBv1H8B8R3DWjBn95hpaa$wuRKIV2Eg6Y14XGrT9vaj6pqIzptGGjjT/KeoPwNt9I=', NULL, FALSE, 'STD25029', 'MUNISHI', 'ethan@gmail.com', FALSE, TRUE, '2025-02-11 10:37:52.171099', 'ETHAN'),
  (60, 'pbkdf2_sha256$600000$abvHjsAstiHhXQurxPgSIB$EzFtctshKddUR1E/8Zv2NoxE1arYCisOdBkuGPddOGo=', NULL, FALSE, 'STD25030', 'KIRITI', 'andrew@gmail.com', FALSE, TRUE, '2025-02-11 11:55:09.213593', 'ANDREW'),
  (61, 'pbkdf2_sha256$600000$omaJJdLIUZvM4MqvgsOUmw$Zd5+rtn/rHSjPie+k1Zign/KIbnPVceZRR6QJ0gmH0Y=', NULL, FALSE, 'robibeneti99@gmail.com', 'Robi', 'robibeneti99@gmail.com', FALSE, TRUE, '2025-02-11 12:00:20.723017', 'Stella'),
  (62, 'pbkdf2_sha256$600000$MvfzsIZxCujSdIef8W6NkB$he4Qy6XSVdW0EG9VRvj0irOA9+cy32ksRJZUFSPcvRM=', NULL, FALSE, 'STD25031', 'BOSIBORI', 'mary@gmail.com', FALSE, TRUE, '2025-02-11 12:00:30.375625', 'MARY ANNE'),
  (63, 'pbkdf2_sha256$600000$3794qC0QiUsm6M77SeB4Ja$8AvTcZHFUdMbMGxxZYdSXMDIsr7SGbbdLZiifzU5vps=', NULL, FALSE, 'STD25032', 'NYANCHAMA', 'orpha@gmail.com', FALSE, TRUE, '2025-02-11 12:09:48.738460', 'ORPHA'),
  (64, 'pbkdf2_sha256$600000$NGtar8Lc2icOmPupCztVmH$HwtjmKVcEeRfeg9i+pPnx6H1kMrnaKjqzomB4XtUe+M=', NULL, FALSE, 'STD25033', 'IDD', 'Marrie@gmail.com', FALSE, TRUE, '2025-02-11 12:12:54.604119', 'MARIA'),
  (65, 'pbkdf2_sha256$600000$dJkeChpowxU3CQcQUW29Pr$kSGLeYLjgKuBJC+gdVKOAzgIt82D3vNbkcqAX5xl4xg=', NULL, FALSE, 'STD25034', 'NJAMBI', 'liz@gmail.com', FALSE, TRUE, '2025-02-11 12:16:53.236691', 'ELIZABETH'),
  (66, 'pbkdf2_sha256$600000$bNjUtw1pYCrGsCipoyOIiV$nxz5iQxN1kv17wvsqg434VA2k5UPjv5pOlG+fsbQ4LQ=', NULL, FALSE, 'STD25036', 'ISHIMWE', 'manzi@gmail.com', FALSE, TRUE, '2025-02-11 12:25:48.440758', 'MANZI'),
  (67, 'pbkdf2_sha256$600000$5WfYBXnGW9knlpZDJlp7IU$gQxWmqx48UeT2n0LNiHKsNQcjkJ3w/FhEcR4YKnT5Ac=', NULL, FALSE, 'STD25037', 'AMELIA', 'liz@gmail.com', FALSE, TRUE, '2025-02-11 12:36:12.406138', 'ELIZABETH'),
  (68, 'pbkdf2_sha256$600000$ZEToBCRqOCTrR3myMsHoKH$T/VGvBWptfV9moSYrc7hh+td/gHlpazpPKyi98+nG/Q=', '2025-09-08 13:29:48.596399', FALSE, 'luciamwikali254@gmail.com', 'Mwikali', 'luciamwikali254@gmail.com', FALSE, TRUE, '2025-02-11 13:16:40.320819', 'Lucia'),
  (69, 'pbkdf2_sha256$600000$RH45WKTygpFmkT9cyiQXAg$8vaqS5LP6P/VIPnxQjJbq/Mxub4M6zuATAH9gxETkYc=', NULL, FALSE, 'STD25039', 'MOKUA', 'edith@gmail.com', FALSE, TRUE, '2025-02-11 13:19:09.038460', 'OLENNA'),
  (70, 'pbkdf2_sha256$600000$SsoZ3a8HnMBlr9eGwrVDEJ$E2oXkLFSKSLeqtrB6g3t5YoTWlyQP39m4STwboYBDNg=', NULL, FALSE, 'STD25040', 'VINOLIA', 'bridgit@gmail.com', FALSE, TRUE, '2025-02-11 13:22:35.379228', 'BRIDGIT'),
  (71, 'pbkdf2_sha256$600000$ATErF1dyMI9tdgDigUjuqD$n2obkPi6SyaVvB1LM7t9e8Y8UY0DsZg+ez1TxfetfAA=', NULL, FALSE, 'STD25041', 'IRAKIZA', 'josh@gmail.com', FALSE, TRUE, '2025-02-11 13:28:32.325992', 'JOSHUA'),
  (72, 'pbkdf2_sha256$600000$r3eWZ884V06XywnBfer8EC$/gxJ5IoCtCqo4lOGhoRiSyXwA738EpAmrkI4gfTvVgQ=', '2025-09-01 15:54:13.434002', FALSE, 'nacellejoy2@gmail.com', 'Musa', 'nacellejoy2@gmail.com', FALSE, TRUE, '2025-02-11 13:32:45.358886', 'Maxwell'),
  (73, 'pbkdf2_sha256$600000$IGHBKPkmUHD116F37E0WWU$BJ7woMjf7qiWZzeiep8DE/nMp0tJfnOoTaGvAnVL8lk=', '2025-09-01 16:09:55.666182', FALSE, 'bibianamurunga@gmail.com', 'MURUNGA', 'bibianamurunga@gmail.com', FALSE, TRUE, '2025-02-11 13:43:52.126770', 'BIBIANA'),
  (74, 'pbkdf2_sha256$600000$CzL8XsZFW3DoaPCoo34gdK$i39z21FL1KCQAkz5P5LsCRqYDwtqZD76M2ZF0VDmzGM=', '2025-09-01 05:48:55.654125', FALSE, 'esthermutuku939@gmail.com', 'MUTUKU', 'esthermutuku939@gmail.com', FALSE, TRUE, '2025-02-11 13:51:45.619416', 'ESTHER'),
  (76, 'pbkdf2_sha256$600000$Pvk6Q6P2ZQLB0WKgz40N06$xUrT1yQMCwxUectaV3M9I/4vSbKH+j0yo0B8us5lGsM=', '2025-10-17 10:05:49.766113', FALSE, 'issarael277@gmail.com', 'RAEL', 'issarael277@gmail.com', FALSE, TRUE, '2025-02-11 14:11:51.326352', 'ISSA'),
  (77, 'pbkdf2_sha256$600000$JJVVqdduvT2J5j6WiEuuvK$7KInpgoEXBaUx1JdHE/P17jq63gRxJbffhTzOVaGMzo=', '2025-09-23 05:08:30.307038', FALSE, 'sharonakei@gmail.com', 'AKINYI', 'sharonakei@gmail.com', FALSE, TRUE, '2025-02-11 14:18:36.548710', 'SHARON'),
  (78, 'pbkdf2_sha256$1000000$jixjWIZcDZGOfIAFNRbzz9$ikPNEfdUFkQPv33+QhtKDlgCHsglBUdPPi9qpjd6jIo=', '2025-12-19 07:32:50.356111', FALSE, 'mdorcas@gmail.com', 'MULWA', 'mdorcas@gmail.com', FALSE, TRUE, '2025-02-11 14:27:06.749286', 'DORCAS'),
  (79, 'pbkdf2_sha256$600000$CQnq0LLKyCQWNIbLSoHpqO$RuzsZvMs0i2u4HUBf3KAsx1sXC6bG7iynmxPAnjg5HE=', NULL, FALSE, 'STD25038', 'ALFRED', 'amber@gmail.com', FALSE, TRUE, '2025-02-12 05:03:59.010379', 'AMBER MAY'),
  (80, 'pbkdf2_sha256$600000$eIpFMoCVje6B9W6oQrGTBe$rK8vFXBoEqE4L8laZmugaIGx49anpNiNwT3bLbQkYhw=', NULL, FALSE, 'STD250391', 'MOKUA', 'edith@gmail.com', FALSE, TRUE, '2025-02-12 05:14:37.576725', 'OLENNA'),
  (81, 'pbkdf2_sha256$600000$2Y6EXdYfZUeoUdCaMoxmTD$3DqKyINuAKeaxVa6vEWrNPPdLeDyQJHyZxLf5nDj2v8=', NULL, FALSE, 'STD250401', 'VINOLIA', '', FALSE, TRUE, '2025-02-12 05:17:36.156734', 'BRIDGIT'),
  (82, 'pbkdf2_sha256$600000$dVdEMJPQ1W4uGTJudNse13$pZfI9zvAO/QhcvfwDE4O7IKjIHuCmLhFdwzMhcO1wDQ=', NULL, FALSE, 'STD250411', 'IRAKIZA', '', FALSE, TRUE, '2025-02-12 05:19:34.843894', 'JOSHUA'),
  (83, 'pbkdf2_sha256$600000$Cco1Yc0PchzxiduV7M7kKN$nLZ9E7YeB7Aj+UMgB+RRaUmZrzFFhy7Xjmt+VNFo16A=', NULL, FALSE, 'STD25042', 'BUSOKA', 'ngabo@gmail.com', FALSE, TRUE, '2025-02-12 05:31:10.141354', 'NGABO'),
  (84, 'pbkdf2_sha256$600000$iojqstikFPcJWTVZVrS5Rw$6WIrZhOzG/H1GHu4MhMUVYWiNVxktn8KE7M6ie/WqEg=', NULL, FALSE, 'STD25043', 'ISHIMWE', 'christian@gmail.com', FALSE, TRUE, '2025-02-12 05:40:26.635244', 'CHRISTIAN'),
  (85, 'pbkdf2_sha256$600000$zKbarehdL8tZQkrTplsKRZ$Zh03I/4uqBlYCtE7LJm/ZQI5f5m/5KshH3gCrJNxwyk=', NULL, FALSE, 'STD25044', 'GENTIL', '', FALSE, TRUE, '2025-02-12 05:46:57.031871', 'NKINGI'),
  (86, 'pbkdf2_sha256$600000$nc8wr588H9ScpeZBY9C2mq$Ikbg0qWF7C1/Waq4UIjtbWu/N/uliQsw10Rij4zu2NM=', NULL, FALSE, 'STD25045', 'SHEMA', 'king@gmail.com', FALSE, TRUE, '2025-02-12 05:50:03.875634', 'KING'),
  (87, 'pbkdf2_sha256$600000$1GRG3ftJ2e3zYz677E0kEE$uB4IwcnZugQnIss2hJnsF9C3DcpfuwnDI1wfaP1rGc4=', NULL, FALSE, 'STD25046', 'MASIKA', '', FALSE, TRUE, '2025-02-12 05:55:07.511680', 'GENESIS'),
  (88, 'pbkdf2_sha256$600000$s7S41oW5fmuKlThYsffWNI$eBLBlmEL1ob05QyZ4o+jILSdC39RWT1lI+nPNaFzKYc=', NULL, FALSE, 'STD25047', 'GANZA', '', FALSE, TRUE, '2025-02-12 05:59:30.808586', 'OSBORNE'),
  (89, 'pbkdf2_sha256$600000$Z1ZkMKMh3x6krYgTepfamD$HtHtAEgmSictWXX8EBsLYLa1b3ECcf5pppiXbZf4R5I=', NULL, FALSE, 'STD25048', 'AJWANG', 'leila@gmail.com', FALSE, TRUE, '2025-02-12 06:04:40.207258', 'LEILA'),
  (90, 'pbkdf2_sha256$600000$I1CoNVQgzP5zmDtLSE0BAH$vCdvXiwLcj2ZJn2oJXSSX1XubuifGqNJReVDJtH+NzU=', NULL, FALSE, 'STD25049', 'AMBANI', 'reagan@gmail.com', FALSE, TRUE, '2025-02-12 06:07:58.001495', 'ALFRED'),
  (91, 'pbkdf2_sha256$600000$ma78H7pQYFdGv283OpgOJN$/R62c9cBi4GnGwg40VEFLf/q0qd/W2J5Zyxd9yKAUFo=', '2025-08-01 10:40:56.149087', FALSE, 'STD25050', 'NJERI', 'njeri@gmail.com', FALSE, TRUE, '2025-02-12 06:12:14.297596', 'MITCHELL'),
  (92, 'pbkdf2_sha256$600000$xqJj69eTI5HKcuAD67gbA7$Q3jo+OK4GD1P+gaM2jmBv6RGnK5IqA6r7AqXLMd/JhY=', NULL, FALSE, 'STD25051', 'ESTHER', 'princess@gmail.com', FALSE, TRUE, '2025-02-12 06:17:33.230413', 'PRINCESS'),
  (93, 'pbkdf2_sha256$600000$u60oXkDKP2aXcAHuQZtb9J$KXqeagwutkKYqcgVLWTAcdfgfYt2p2ieWwkKxjEEUoM=', NULL, FALSE, 'STD25052', 'NIYONKURU', 'david@gmail.com', FALSE, TRUE, '2025-02-12 06:20:57.575205', 'DAVID'),
  (94, 'pbkdf2_sha256$600000$FMIPoF5e3FeQnrDK6ILKXR$NdaGYoXICh/+968ASyo0Oah1uXxc9J3dZiaax3ld93k=', NULL, FALSE, 'STD25053', 'LATAVIA', 'angel1@gmail.com', FALSE, TRUE, '2025-02-12 06:28:49.214768', 'ANGEL'),
  (95, 'pbkdf2_sha256$600000$VKMQ93MGLkYHMa8UbNHPTa$pdEgQKe89sxi01j5NleOIdN2PZ4k5yt2WTcE948ZtM4=', NULL, FALSE, 'STD25054', 'PASCAL', 'zachary@gmail.com', FALSE, TRUE, '2025-02-12 06:31:34.064663', 'ZACHARY'),
  (96, 'pbkdf2_sha256$600000$TVRGQ86Z1BasvF6i1ZPjpu$qnIh65fUZZ//l1Rh+6q2Vi6l0WYPiel4Ba2npqbdSAk=', NULL, FALSE, 'STD25055', 'OBISA', '', FALSE, TRUE, '2025-02-12 06:33:59.242593', 'ROBIN'),
  (97, 'pbkdf2_sha256$600000$gMxOzBj6J41iTCnIsIoEHj$jtbpLuz++7hgumx49mxoskbEhH4mELdPd6l2ghOP9IE=', NULL, FALSE, 'STD25056', 'ARLEY', 'nicheva@gmail.com', FALSE, TRUE, '2025-02-12 06:36:59.506203', 'NICHEVA'),
  (98, 'pbkdf2_sha256$600000$mpHsifakBZeuRzkLXzzGqj$mWdBMkAnL+MEgU4RwzFUv7WOWn8wJNbMhnF89SVcskY=', NULL, FALSE, 'STD25057', 'HANNAH', 'alicia@gmail.com', FALSE, TRUE, '2025-02-12 06:38:52.070128', 'ALICIA'),
  (99, 'pbkdf2_sha256$600000$QUcvvh8JUrenMtOgsklLT9$gHlik2SVBvDrLmnfZ2EK3Qy4t+6osRMEc88ZbsE5e5g=', NULL, FALSE, 'STD25058', 'MESHACK', 'samuel@gmail.com', FALSE, TRUE, '2025-02-12 07:28:35.528757', 'SAMUEL'),
  (100, 'pbkdf2_sha256$600000$5DLQdg84MOQsNzvZ5OTYBh$olQzdOkLYWvaim9qKv+9kYXyoOGmm2Qvau6Eoj/c9Ag=', NULL, FALSE, 'STD23059', 'NGUWENEZA', 'moses@gmail.com', FALSE, TRUE, '2025-02-12 07:36:37.517040', 'MOSES'),
  (101, 'pbkdf2_sha256$600000$jozIffUGQdpjtR7Vvl1cHc$mWnuJohW/TGhbAiZJ9TRia+cRPUSIGjRghtGxG79AGY=', NULL, FALSE, 'STD25060', 'GALEA', 'galea@gmail.com', FALSE, TRUE, '2025-02-12 07:52:48.197348', 'NDUMFUTSE'),
  (102, 'pbkdf2_sha256$600000$tnnNsferQQwEX5OUWArPK0$USc+SaCbTzL16JNu88ZIlTg1ohH8digIvcmeEq8U5x0=', NULL, FALSE, 'STD23061', 'JAYDEN', 'ramsom@gmail.com', FALSE, TRUE, '2025-02-12 07:57:51.094707', 'RAMSOM'),
  (103, 'pbkdf2_sha256$600000$6AsQyHfTW4qjeN3mpltr56$G7ARV6dLLCMucormDv3Tb0Fn9TMxVxQEHKpeC795IaM=', NULL, FALSE, 'STD23062', 'MUTHEU', 'mercy@gmail.com', FALSE, TRUE, '2025-02-12 08:33:13.401436', 'MERCY'),
  (104, 'pbkdf2_sha256$600000$4MNjmFdNcu4DkBHxOEz676$Vq3ZTffnSg6WJtIGVlsRd0LLugotUtg86a+REFnM/yc=', NULL, FALSE, 'STD23063', 'CHEPTOO', 'cynthia@gmail.com', FALSE, TRUE, '2025-02-12 09:22:39.281364', 'CYNTHIA'),
  (105, 'pbkdf2_sha256$600000$z557Ll5fXyHNDLzegBDGAs$gONCwBY5CbAhwUfV6BIhRbcB5WJV3E2VS8IaxerNhD4=', NULL, FALSE, 'STD23064', 'QUEEN', 'naomi1@gmail.com', FALSE, TRUE, '2025-02-12 09:31:08.398649', 'NAOMI'),
  (106, 'pbkdf2_sha256$600000$gDIHfGTDovvvab2cmnsTZa$HP42c8u74Sei9nCDCw9lTJURlt6Dfea7zVBfrqYLnaI=', NULL, FALSE, 'STD23065', 'OTIENO', 'caleb@gmail.com', FALSE, TRUE, '2025-02-12 09:35:54.885261', 'CALEB'),
  (107, 'pbkdf2_sha256$600000$aKQ0e6JnYZpNZBRY1NdNls$7lH9Nho9a2e/DwCE+qtGqIDDG58y7YJHSjpvw6HOHHA=', NULL, FALSE, 'STD23066', 'NYABOKE', 'flavian@gmail.com', FALSE, TRUE, '2025-02-12 09:39:18.987502', 'FLAVIAN'),
  (108, 'pbkdf2_sha256$600000$L8i7lCty8XSL7xIRtVNaWu$G51qPjATokOK84jCLoaEzCdlfy0eksVv6yTykPrmN2A=', NULL, FALSE, 'STD23067', 'BLESSED', 'favor@gmail.com', FALSE, TRUE, '2025-02-12 09:45:58.483705', 'FAVOR'),
  (109, 'pbkdf2_sha256$600000$afWbbTyPaqS33FFZTP0P1X$8GvTeMlflqaJicNGXSdlH5LCclrOlT2cuChx194u+UI=', NULL, FALSE, 'STD25068', 'MANZI', 'blaise@gmail.com', FALSE, TRUE, '2025-02-12 09:53:46.903606', 'BLAISE'),
  (110, 'pbkdf2_sha256$600000$DeILJcaYB3MyrBNkH06wwo$xcQmkR36n3Gc0OvmdWR51lg/FQh3R1segt/2MSs2YPw=', NULL, FALSE, 'STD23069', 'NTINZI', 'addi@gmail.com', FALSE, TRUE, '2025-02-12 09:56:06.824168', 'ADDI'),
  (111, 'pbkdf2_sha256$600000$jS5KsNeXnYsmymg0CgIajE$S7lVVxb5UKY9MyUXCgwodJTB/J4GrgIYzv2Wd73MzCY=', NULL, FALSE, 'STD23070', 'OMOLLO', 'bryden@gmail.com', FALSE, TRUE, '2025-02-12 10:04:39.912835', 'BRYDEN'),
  (112, 'pbkdf2_sha256$600000$FclM3EF2kxe9OrYaDlDwXZ$45i523l9Fsk2K6HXZX0neij0QL1K9HuQ8daIQg56CAQ=', NULL, FALSE, 'STD25071', 'ATUNDO', 'ezra@gmail.com', FALSE, TRUE, '2025-02-12 10:11:11.001025', 'EZRA'),
  (113, 'pbkdf2_sha256$600000$3U4S0pTaOyHNh7i5znDfVd$nAkIBALHq4ZWWEjnEMB7rNpusCF1rgjoGWtRp5ugXaI=', NULL, FALSE, 'STD25072', 'GABRIELLA', 'gaby@gmail.com', FALSE, TRUE, '2025-02-12 10:14:45.004389', 'NGABIRE'),
  (114, 'pbkdf2_sha256$600000$CLiVXj0w4VTZFrfPzVhUzn$NB8zan7gLuZVR+GtGrnFUEHekAmHeIBnT/MwvRFxKLo=', NULL, FALSE, 'STD25073', 'MWANGI', 'liam@gmail.com', FALSE, TRUE, '2025-02-12 10:35:00.688350', 'LIAM'),
  (115, 'pbkdf2_sha256$600000$yDHYXHZNF0ODENZ7sRwJUX$7/ppOY30gqaxSKyrnDL/AssKDfoJdbmOSXmY4Itq4mI=', NULL, FALSE, 'STD23074', 'NDUNGE', 'jerry@gmail.com', FALSE, TRUE, '2025-02-12 10:38:50.164951', 'JERADINE'),
  (116, 'pbkdf2_sha256$600000$EakBw4V6wG158m0qKmPpVk$mZl8sgTAenG5vKwusLp+RsUmnlJT+QuwZIcqnjNMqQg=', NULL, FALSE, 'STD25075', 'AMANI', 'israel@gmail.com', FALSE, TRUE, '2025-02-12 11:56:38.527627', 'ISRAEL'),
  (117, 'pbkdf2_sha256$600000$XvYGTom37JJMtE8ODiyI5P$1yN0Y8l6N3i+lQ7/nRJ4vhluiKgzHOiWZ+Q75NQQmWg=', NULL, FALSE, 'STD25076', 'MOKUA', 'dylan@gmail.com', FALSE, TRUE, '2025-02-12 12:07:20.466625', 'DYLAN'),
  (118, 'pbkdf2_sha256$600000$PhvrJEl3AEvKpbAbjHukv5$01WoL46hElh3y/VoORr2GoU9L1L8Nl8bFeyDk3ViBdY=', NULL, FALSE, 'STD25077', 'PRESENCE', 'heman@gmail.com', FALSE, TRUE, '2025-02-12 12:12:09.809321', 'HEMAN'),
  (119, 'pbkdf2_sha256$600000$IxBV3YwfSIg7l8m23u57FB$AMfuETHh33Kh3NEdAoj/J2KPYmZQuQRNidC06MFcfaI=', NULL, FALSE, 'STD25078', 'ALFRED', 'don@gmail.com', FALSE, TRUE, '2025-02-12 12:15:44.757904', 'DONGENIUS'),
  (120, 'pbkdf2_sha256$600000$sb0LTQe02XHIxe6m2etBFu$susCX1EN4SwZIp4R1gTJiY3yLUESpkuR2g9l51brss8=', NULL, FALSE, 'STD25079', 'KAMAU', 'stella@gmail.com', FALSE, TRUE, '2025-02-12 12:22:30.707164', 'VICTOR'),
  (121, 'pbkdf2_sha256$600000$7XlzglP0Br2gWCrZyi7MZn$tB0SfKtXAPMMVqEYw81/JP0Glib9kgMwIG2/53aDBa0=', NULL, FALSE, 'STD25080', 'MWAKA', 'mark@gmail.com', FALSE, TRUE, '2025-02-12 12:26:44.045155', 'TYLER'),
  (122, 'pbkdf2_sha256$600000$XnKvpfGVVBg5R5MgPrqD4A$Aq4LAAtPj0xBPFFy0FHPsUpso7kz0/M/wntlGi0zFsc=', NULL, FALSE, 'STD25081', 'PENDO', 'rael@gmail.com', FALSE, TRUE, '2025-02-12 12:34:47.953641', 'KEYLA'),
  (123, 'pbkdf2_sha256$600000$oBM5T5cyByGBY4F3vctpoS$9nJhlP+czDv924ojKxXcN+HlQ/PRjS5OfMuaKFObFao=', NULL, FALSE, 'STD25082', 'MIRIAM', 'rael@gmail.com', FALSE, TRUE, '2025-02-12 12:37:21.018970', 'PRECIOUS'),
  (124, 'pbkdf2_sha256$600000$eyFNh9jkQnVCy24G2D696M$H8QA0fZDGyuTVaBIM70S1FjuZC4JQIv695GkmL+qtl4=', NULL, FALSE, 'STD25083', 'MUZINGA', 'rael@gmail.com', FALSE, TRUE, '2025-02-12 13:20:53.205646', 'KEN'),
  (125, 'pbkdf2_sha256$600000$9cgCWo6X8ue0gH4XpQpfLJ$BWcpbe1V5bY4P8A5Q9ikgtLQdFlgr7mvKp/fHb0Bqwo=', NULL, FALSE, 'STD25084', 'JOY', 'hezekiah@gmail.com', FALSE, TRUE, '2025-02-12 13:30:04.523684', 'BENEDICT'),
  (126, 'pbkdf2_sha256$600000$PQlpZpL91wbjl8OHR3R4gN$PJl7TTD5St/w43tvwtvtLpfwTNZkR1Q77gYa4If3NeI=', NULL, FALSE, 'STD25085', 'CLEVER', 'rael@gmail.com', FALSE, TRUE, '2025-02-13 06:24:19.185971', 'NGABIRE'),
  (127, 'pbkdf2_sha256$600000$Zc9GgNGUO1A125pY9xAsCZ$r0cyL0C0iBFfqdJggDiYG17zXVyNBv+M1HUQuo1rJj0=', NULL, FALSE, 'STD25086', 'MUGWE', 'samuel@gmail.com', FALSE, TRUE, '2025-02-13 07:14:21.216901', 'JAYSON'),
  (128, 'pbkdf2_sha256$600000$GCR4BZu2OHel91wb8k85sA$0xaQkcB9KRlkSK/QtsDkbJSqOX/2NJhvWr2y5+YgqzA=', NULL, FALSE, 'STD25087', 'MUTONI', 'rael@gmail.com', FALSE, TRUE, '2025-02-13 07:16:02.394342', 'JOYCE'),
  (129, 'pbkdf2_sha256$600000$Vbtc4zJkN9gKQWGfvtVsWV$SuKXra7koyX0059UH8/a+ptP3EtVl89ga1gxkSl9Lkw=', NULL, FALSE, 'STD25088', 'MATSEU', 'rael@gmail.com', FALSE, TRUE, '2025-02-13 07:19:21.477323', 'HIRWA MIGUEL'),
  (130, 'pbkdf2_sha256$600000$sIRzow7iC7cw5DeSkhqod6$7pyhBxdcek6hrKcCvTCGhInEkIbgr2Z+Osok1jK2C8A=', NULL, FALSE, 'STD25089', 'IRUNVA', 'josh@gmail.com', FALSE, TRUE, '2025-02-13 07:22:43.767264', 'ANDY KINGS'),
  (131, 'pbkdf2_sha256$600000$pt45xDc7TqcBJZbYmV2rQx$vXEbScbpFhTM3R79OKtf/Eb44rrs9xZnphCPKfO5HLQ=', NULL, FALSE, 'STD25090', 'AUKA', 'alfred@gmail.com', FALSE, TRUE, '2025-02-13 07:25:52.063958', 'RAYDEN'),
  (132, 'pbkdf2_sha256$600000$GKRWD1DYvlOZpld3WG8t8T$EDbvnSe1sQyp7mxjgaVj+4DD+jzUT0McwbDS5r7He14=', NULL, FALSE, 'STD25091', 'GAEL', 'divine@gmail.com', FALSE, TRUE, '2025-02-13 07:28:01.361675', 'GISA'),
  (133, 'pbkdf2_sha256$600000$j1pYVq6uyE42c5Spv2fvyM$QCui1V3DKa1tM2pvYDezoySrQHf65h2wUPRWA77sRA8=', NULL, FALSE, 'STD25092', 'EDIMO', 'alice@gmail.com', FALSE, TRUE, '2025-02-13 07:30:01.166447', 'MOSES'),
  (134, 'pbkdf2_sha256$600000$CAhogUgeEJVvs9P8vWisBM$d3664+A4jY0TyQywmEkGPDImEI4xhJwhZPgOLdi8VFQ=', NULL, FALSE, 'STD25093', 'GABRIEL', 'gentil@gmail.com', FALSE, TRUE, '2025-02-13 07:33:55.221496', 'MODESTE'),
  (135, 'pbkdf2_sha256$600000$8lho2glgGKthK6GWbzfmqY$bMzxrXrkpvLjoJ/vFoKVJX9d9g1Z+LK8eCa6SrP1Va0=', NULL, FALSE, 'STD25094', 'ISHEMA', 'rael@gmail.com', FALSE, TRUE, '2025-02-13 07:41:57.547079', 'AVISHA'),
  (136, 'pbkdf2_sha256$600000$FyNi5E5H1G23o0MxEnAqZY$qycFiEaPlooAFZ2dF25BD0fsRSpoXxHdAwdNzdZ8bNU=', '2025-08-01 10:39:42.086147', FALSE, 'STD25095', 'OKINYI', 'rael@gmail.com', FALSE, TRUE, '2025-02-13 08:02:50.928302', 'YUSUF'),
  (137, 'pbkdf2_sha256$600000$cyN0ld0Vj3KqIa5CVTJIby$olZILWIxvwzAp/wqGTXwKgRTS7PRa87zkZVYcVqgVHQ=', NULL, FALSE, 'STD25096', 'MUTANU', 'reg@gmail.com', FALSE, TRUE, '2025-02-13 08:08:10.493653', 'AMELIA'),
  (138, 'pbkdf2_sha256$600000$tu8RUSNv2ZU3VoLuFF8LL5$u2mMNLrNcHio7h851eDk+xM13gfITJ5gxcXDO8QBI2Q=', NULL, FALSE, 'STD25097', 'ACHIENG', 'sylvia@gmail.com', FALSE, TRUE, '2025-02-13 08:21:06.916073', 'ANGEL'),
  (139, 'pbkdf2_sha256$600000$fR0EP9x0WevbK6mcxIcw13$eQhL2WgwhRvlC5KSbVjVHu5gzDaZy5QrTzY8dY3vF6I=', NULL, FALSE, 'STD25099', 'DEBORAH', 'rael@gmail.com', FALSE, TRUE, '2025-02-13 08:22:47.338880', 'TETA'),
  (140, 'pbkdf2_sha256$600000$UyhI25DQfl2vsuUHrAyq8z$dtScZ2541lbm+/atLi4R+Xof0tHm/hOhDfCToEe2KBA=', NULL, FALSE, 'STD250991', 'DEBORAH', 'rael@gmail.com', FALSE, TRUE, '2025-02-13 08:26:01.158304', 'TETA'),
  (141, 'pbkdf2_sha256$600000$MvyUQMnFPspv7nBHEWcbG8$/ax6Dpjjpwpxo0+DV7bqHTFaKC9+4H9XQN8DPu9JMfc=', NULL, FALSE, 'STD25098', 'WAFULA', 'rael@gmail.com', FALSE, TRUE, '2025-02-13 08:27:45.805623', 'GIFTON'),
  (142, 'pbkdf2_sha256$600000$5QTZuJbH13YilHWBYDX5n4$wC9NN0Jdh8KKQVhbhqibBo82/uFqrmIT1wUaZXDYJbk=', NULL, FALSE, 'STD250992', 'DEBORAH', 'rael@gmail.com', FALSE, TRUE, '2025-02-13 08:30:13.041037', 'TETA'),
  (143, 'pbkdf2_sha256$600000$Ku6zIgm7eXTqxfwMoehbLU$Qx4hz+S38XlR+H8qXRb4FRy30vqJx8CPtMrCAGI/5bo=', NULL, FALSE, 'STD25100', 'WANJIRU', 'Lilian@gmail.com', FALSE, TRUE, '2025-02-13 08:33:10.142272', 'RAVEN'),
  (144, 'pbkdf2_sha256$600000$qat2rRSSPyHwKnDA74FsDp$Sc4wWBkXFV0SmS5dmge+cPlXFZ8Rgge0aur7oBn7WN8=', NULL, FALSE, 'STD25101', 'SAKWA', 'hillary@gmail.com', FALSE, TRUE, '2025-02-13 08:35:46.146752', 'FOUR'),
  (145, 'pbkdf2_sha256$600000$NvSXrxQ81yXUGf3e6TAynY$RW5++4xDn0sIeI8FeY3JDT/0mFQ9UHDXcQgbZFR1efA=', NULL, FALSE, 'STD250102', 'WEKESA', 'moses@gmail.com', FALSE, TRUE, '2025-02-13 08:36:59.389788', 'DAVID'),
  (146, 'pbkdf2_sha256$600000$m1bik27efsD04O3UdG0ExF$rjmdPLAInTka9WACVF9qP29MWZSeyDoEXpSOBTyVoiI=', NULL, FALSE, 'STD25103', 'GIFTON', 'rael@gmail.com', FALSE, TRUE, '2025-02-13 08:39:41.664098', 'PAUL'),
  (147, 'pbkdf2_sha256$600000$r6UzT2E8LwjcHZMD8H0Gic$B5zqM9s5njins43giSi4RPrVpwLsC//ucRgOaqeV77g=', NULL, FALSE, 'STD25104', 'GAELA', 'rael@gmail.com', FALSE, TRUE, '2025-02-13 08:42:07.443466', 'ATETE'),
  (148, 'pbkdf2_sha256$600000$TZLfNf8Uk4JII03X9hrpx8$HULOvXe9Mc53uqRYssz6PdlVGZ1jUdacmrtn+EhoRic=', NULL, FALSE, 'STD25105', 'NDANYUNZWE', 'rael@gmail.com', FALSE, TRUE, '2025-02-13 09:15:16.926897', 'ALLAN'),
  (149, 'pbkdf2_sha256$600000$TKxli4KoAspqcI0Wdyv46J$UdQhS5SVuCPyLOGzWl1gbzsUOGhlYI3e/aPrUIQfET0=', NULL, FALSE, 'STD25106', 'GAEL', 'moses@gmail.com', FALSE, TRUE, '2025-02-13 09:16:55.773447', 'PRINCE'),
  (150, 'pbkdf2_sha256$600000$yC1iHBW6xh17yCvERdOiVM$0wnDfxs5aVPYmECTz7Pybdbg0otRim3EpJeNyBda2fY=', NULL, FALSE, 'STD25107', 'CANDACE', 'catherine@gmail.com', FALSE, TRUE, '2025-02-13 09:20:09.199561', 'JEWEL'),
  (151, 'pbkdf2_sha256$600000$qRmWwdHi2BQQ9V5B7gtUoe$gmLGEGmKRGSszAVfAzcliw9zX1rfEp8KXB6rweTYtas=', NULL, FALSE, 'STD25108', 'KIPROP', 'linet@gmail.com', FALSE, TRUE, '2025-02-13 09:22:53.836615', 'BRYSON'),
  (152, 'pbkdf2_sha256$600000$6Se63kxB1Wex6ZMJh98wPP$uYaP7JTO5F88A6vw4nqu1UpFIoHmOdY/XUUIi6jW/ng=', NULL, FALSE, 'STD25109', 'JANINE', 'rael@gmail.com', FALSE, TRUE, '2025-02-13 09:24:14.196969', 'KAYLEIGH'),
  (153, 'pbkdf2_sha256$600000$blD3nhRBEfQ9nxqSf9MEpf$JiqMgWY6ryQVfLsfnMfcdro6zoykFixIgE0e9i4HXb8=', NULL, FALSE, 'STD25111', 'KIMARI', 'rael@gmail.com', FALSE, TRUE, '2025-02-13 09:26:10.548098', 'MYLES'),
  (154, 'pbkdf2_sha256$600000$NBw4EGG6WIWriSSPvX6npA$o1KfrqRsYghFD+AsToH+eC7/qXFCn84lE7/cQXSLhtQ=', NULL, FALSE, 'STD25110', 'KIMARI', 'rael@gmail.com', FALSE, TRUE, '2025-02-13 09:30:09.427939', 'MYLES'),
  (155, 'pbkdf2_sha256$600000$ZG8Qn2k68grVIO7q4loBG5$BXGbK54UQ6rrlusKgMYnr8J1n5gfP4Y0lGRDt3cfYFA=', NULL, FALSE, 'STD251111', 'OKEO', 'rael@gmail.com', FALSE, TRUE, '2025-02-13 09:31:30.548168', 'DAMIAN'),
  (156, 'pbkdf2_sha256$600000$uRmZuzM5yZtgL5WeWKZRNM$iHmR8VVx1wYIkqJ7QrKpp3HqJ5OKCV7TNav6hs2Z56Y=', NULL, FALSE, 'STD25112', 'LENNA', 'rael@gmail.com', FALSE, TRUE, '2025-02-13 09:33:47.074997', 'SOFIA'),
  (157, 'pbkdf2_sha256$600000$GHgPjeD3F7DP69JyHoRlse$u7OlysNcfJX+Uop/iFZzGGJIwijY4VmRGWUq90eQrsU=', NULL, FALSE, 'STD25113', 'BARAKA', 'rael@gmail.com', FALSE, TRUE, '2025-02-13 09:36:29.085280', 'DANIEL'),
  (158, 'pbkdf2_sha256$600000$1lMUVDgsp6h3ke7bokYMom$9NTCboli5hMrJi++if6N9kE+d4f+LLBF7x+9YX9wtQs=', NULL, FALSE, 'STD25114', 'WANJIKU', 'rael@gmail.com', FALSE, TRUE, '2025-02-13 09:37:38.667141', 'JANE'),
  (159, 'pbkdf2_sha256$600000$D2GksVMKcinecJRzpEwVcl$KCDioKNOqnC1hOtK1vD0Kn/XrShrUJSPVo8av58nhdY=', NULL, FALSE, 'STD25115', 'AMINA', 'rael@gmail.com', FALSE, TRUE, '2025-02-13 09:55:34.217890', 'SAMIRA'),
  (160, 'pbkdf2_sha256$600000$oSPGTZz7lrVHCnuQbnrZ4M$73NExID8k2glF9d/JMooNb39AatkuntKa7flTIPwm+c=', NULL, FALSE, 'STD25116', 'ARIELA', 'rael@gmail.com', FALSE, TRUE, '2025-02-13 10:19:12.038787', 'TATIANA'),
  (161, 'pbkdf2_sha256$600000$mvKs69HCKD7yvjZ2ACLN4k$jbdr0gs5Rzzpew4GWDm0ZssiMTpOv1P/Dq8Z6koEGq4=', NULL, FALSE, 'STD25117', 'KERUBO', 'rael@gmail.com', FALSE, TRUE, '2025-02-13 11:19:05.298013', 'BLESSINGS'),
  (162, 'pbkdf2_sha256$600000$QhRXPQE4MI8Q7V6QKnErEe$p7uhKitGAGGLO9GypC7EMCQ7MWVuybMC7r32bA54bjc=', NULL, FALSE, 'STD25118', 'IRAKOZE', 'rael@gmail.com', FALSE, TRUE, '2025-02-13 11:23:00.622220', 'SINCERE'),
  (163, 'pbkdf2_sha256$600000$OY4Gbw2bkrBLyI90cTklvo$BeCuch3A3pg5A0K9D5hc9JsiTfD8mJPTKU1/O2lOND4=', NULL, FALSE, 'STD25119', 'NTUGUTSE', 'rael@gmail.com', FALSE, TRUE, '2025-02-13 11:24:57.037752', 'DANIEL'),
  (164, 'pbkdf2_sha256$600000$zuiShBReLjUbKYEVfIcEFK$ZiHH0xyI5GMx35+LPWJmToy2scgTUC00Ju73ayJ4Izg=', NULL, FALSE, 'STD25120', 'OUMA', 'rael@gmail.com', FALSE, TRUE, '2025-02-13 11:26:59.063345', 'CHARLES'),
  (165, 'pbkdf2_sha256$600000$wABC4Ug75Zf7U787eEaRqZ$I0NJSjw2T9/YCITm3KwBPdNax9jhFNkduSMGW3HXHDU=', NULL, FALSE, 'STD25121', 'MARANGO', 'rael@gmail.com', FALSE, TRUE, '2025-02-13 11:30:11.613781', 'LEWIS'),
  (166, 'pbkdf2_sha256$600000$QFNVtf9xi93YxKVcxBGApb$xvnX4SATD807MM0MtexHZftNQAgdE4s64tY04R1jp7A=', NULL, FALSE, 'STD25122', 'GANZA', 'rael@gmail.com', FALSE, TRUE, '2025-02-13 11:31:26.621831', 'IVAN'),
  (167, 'pbkdf2_sha256$600000$25faSEEeFaR8etpoqXWgXh$5UCYCM0c+PnkbL7FviwsbCUnlKotqclGPdTQu2yiAuQ=', NULL, FALSE, 'STD25123', 'HIRWA', 'rael@gmail.com', FALSE, TRUE, '2025-02-13 11:38:11.815316', 'JAYDEN'),
  (168, 'pbkdf2_sha256$600000$cYViY4T6w6wGFRebwWoo98$hFrlD+UGISccOMtr6cstxcKHa1FYhPI9twpZey9T1Ww=', NULL, FALSE, 'STD25124', 'PROMISE', 'rael@gmail.com', FALSE, TRUE, '2025-02-13 11:41:38.757779', 'JAYDEN'),
  (169, 'pbkdf2_sha256$600000$UsVwLHixHDuHGnokJ8dUzn$HVo3A2hkdYeiniPK7bZlcpnS75jVpi0szwFgR/Kpz18=', '2025-08-01 10:38:54.260243', FALSE, 'STD25125', 'SANTIAGO', 'rael@gmail.com', FALSE, TRUE, '2025-02-13 11:43:03.194808', 'MILAN'),
  (170, 'pbkdf2_sha256$600000$iuGFdZtn75Mx1DTgM3k5Be$yrW+miC0SBB4+LhdZP42KqL0jqqfu8SpaxhT0CUPkJ8=', NULL, FALSE, 'STD25126', 'MUGISHA', 'rael@gmail.com', FALSE, TRUE, '2025-02-13 11:44:35.156510', 'BEN'),
  (171, 'pbkdf2_sha256$600000$29QboQc8ExL8m8MYVjI8rW$1m8dlY4zGAT4GOyFoGPxmtdZqp6hzlHzquNxG2qMzTg=', NULL, FALSE, 'STD25127', 'MUKASIA', 'rael@gmail.com', FALSE, TRUE, '2025-02-13 11:46:03.548042', 'ELYN'),
  (172, 'pbkdf2_sha256$600000$XJgMfNZoNqpm4nxzf0TqhD$G+6s+Bemk1QAr5lbmFmi21uHtxLhkLi9CvisyBC+Eqs=', NULL, FALSE, 'STD25128', 'OKEO', 'rael@gmail.com', FALSE, TRUE, '2025-02-13 11:50:47.410062', 'DAMIAN'),
  (173, 'pbkdf2_sha256$600000$Hpe0b1stpsAiWjuz1occVG$OFWivFI5E0PFHXnGuK1sopEr/X/jdVmO0dQsAjhtCdc=', NULL, FALSE, 'STD25129', 'KIMARI', 'rael@gmail.com', FALSE, TRUE, '2025-02-13 11:54:58.447391', 'MYLES'),
  (174, 'pbkdf2_sha256$600000$uFQ8OxU7sKVxTbE2McWFX6$6dBhCDSPvK1OaakhjYKpei4oq3dpn69ldhgUJyf2iiE=', NULL, FALSE, 'STD25130', 'LENNA', 'rael@gmail.com', FALSE, TRUE, '2025-02-13 11:57:39.763076', 'SOFIA'),
  (175, 'pbkdf2_sha256$600000$fXBan2W3PppSub3NiK8ywb$SEGbNSjAd2KJzrPrxmg/ECzB1o+YgQO67FBJjGBMeF0=', NULL, FALSE, 'STD25131', 'ONGARO', 'rael@gmail.com', FALSE, TRUE, '2025-02-13 11:59:12.318930', 'GAVIN'),
  (176, 'pbkdf2_sha256$600000$3BnCJpAeL8KQ0j1rEfIzND$NWlaZfUUSdOC7ejIEtElaxh+NMVpp0pU41P/tSlSTRI=', NULL, FALSE, 'STD25132', 'BITUTU', 'rael@gmail.com', FALSE, TRUE, '2025-02-13 12:01:04.054768', 'ARIELLA'),
  (177, 'pbkdf2_sha256$600000$uc2yFrvhIHl4jBUQ1J520w$MeNrOy9jpbLQWK3ZpvrNimOwsaL/wO2Xxgriafc3QMQ=', NULL, FALSE, 'STD25133', 'KWAMBOKA', 'rael@gmail.com', FALSE, TRUE, '2025-02-13 12:02:50.122497', 'SOLEEN KLAIR'),
  (178, 'pbkdf2_sha256$600000$v701tGkFgRqvIL2WxJaeFr$sj/rZ+h/2ZD3AwUJI5B2crtvn1LvLXJJYEx0uJwPwp0=', NULL, FALSE, 'STD25021', 'NYAKARO', 'samuelmiringu@gmail.com', FALSE, TRUE, '2025-02-13 13:12:53.261886', 'ESTHER'),
  (179, 'pbkdf2_sha256$600000$pWnW6ZO3jMLjdVDVMEXQKq$cmfKxGQCPQavlZwfEOOa9NFtFfL/7W8IZ02W2SGTziM=', '2025-08-01 10:17:07.879263', FALSE, 'STD25035', 'ISHIMWE', 'fannynyangaju@gmail.com', FALSE, TRUE, '2025-02-13 13:17:00.928544', 'MANZI'),
  (180, 'pbkdf2_sha256$600000$J46XZdUwg1LRPxUemnJ6um$vad30kcz7C1vS8CrjUvlN3eHthymNpIHVZ+vZU+oHbg=', NULL, FALSE, 'STD25059', 'NGUWENEZA', 'tellygaudimo@gmail.com', FALSE, TRUE, '2025-02-13 13:21:11.889223', 'MOSES'),
  (181, 'pbkdf2_sha256$600000$EUdTcTIytSEdfwcHmHZtAi$kLN8ZkiL3C5LOkVoWZa+GUBKszu0U3xdzsrKSx7T5DY=', NULL, FALSE, 'STD25061', 'Jayden', 'teraxgaudim@gmail.com', FALSE, TRUE, '2025-02-13 13:26:54.898451', 'Ramsom'),
  (182, 'pbkdf2_sha256$600000$fxl0b8MjaHTxy64Bgha1bY$orUGMv/9SY0MX/f74jkuE0sarjJVQMrbjo9XJGHdrEE=', NULL, FALSE, 'STD25069', 'NTINZI', 'rael@gmail.com', FALSE, TRUE, '2025-02-13 13:39:40.931245', 'ADDI'),
  (183, 'pbkdf2_sha256$600000$GiB5K77K5n2RbUHBOlTTWM$SvrVZWkab0/JeARRqY8E9jq9ZK2pCZogvOwSgoj4fuA=', NULL, FALSE, 'STD25062', 'MUTHEU', 'marysyombau@gmail.com', FALSE, TRUE, '2025-02-13 13:40:54.326383', 'MERCY'),
  (184, 'pbkdf2_sha256$600000$doU2QrHGNrq7qNXNMas0sL$3Yhxax1x8ofJllEhaygQhcJWVHc5VlPgnUhfLHCRgzk=', NULL, FALSE, 'STD25070', 'OMOLLO', 'janet@gmail.com', FALSE, TRUE, '2025-02-13 13:41:55.853497', 'BRYDEN'),
  (185, 'pbkdf2_sha256$600000$Ygp5UeAK4Dabb9eYgEYWYn$PD0ohyQPQ7dGRtbUmjtYz4/7UlJxPjV+JLxMYB0OewE=', NULL, FALSE, 'STD25063', 'CHEPTOO', 'dmariskilimo@gmail.com', FALSE, TRUE, '2025-02-13 13:43:50.393646', 'CYNTHIA'),
  (186, 'pbkdf2_sha256$600000$XgtKQR7HrCV9z4aTTPeKRD$+XN1oBc5y9FA2hd+aXkvED+9Y43iwvXRvFjrzlZxCoI=', NULL, FALSE, 'STD25064', 'QUEEN', 'justinnyagapfizi@gmail.com', FALSE, TRUE, '2025-02-13 13:46:55.741964', 'NAOMI'),
  (187, 'pbkdf2_sha256$600000$xY4UvYk9RryGEQTUclnmup$17e0TKYHCEuK01gKwBOU+IrF8BpiSgms8KrtHaPHous=', NULL, FALSE, 'STD25074', 'NDUNGE', 'rael@gmail.com', FALSE, TRUE, '2025-02-13 13:48:19.329917', 'JERADINE'),
  (188, 'pbkdf2_sha256$600000$iOhBiJGY6ClXx4yoXGgmck$w6c31bWOCHKRal5zSvNbLfPg0I17OAmvuyOKjBfysPk=', NULL, FALSE, 'STD25065', 'OTIENO', 'eliasoketch@gmail.com', FALSE, TRUE, '2025-02-13 13:49:47.783468', 'CALEB'),
  (189, 'pbkdf2_sha256$600000$0KDZ4QvirAfKKSrsoLF0j1$3P6MY4Gv7phksSYUxDH0bjilMRuDwfjnpb6yi7wcxJw=', NULL, FALSE, 'STD25066', 'NYABOKE', 'lazarusongangi@gmail.com', FALSE, TRUE, '2025-02-13 13:52:14.602892', 'FLAVIAN'),
  (190, 'pbkdf2_sha256$600000$XOEqUPvHTemR3zjPnEmN60$WugH0mD2H0SNcaFGc5ZGCX+/ErIe7s0XOpHI7eoS348=', NULL, FALSE, 'STD25067', 'BLESSED', 'bibianamurunga@gmail.com', FALSE, TRUE, '2025-02-13 13:54:53.344185', 'FAVOR'),
  (191, 'pbkdf2_sha256$600000$61F2g5BfHDhIz8KlnT4ZkB$XAlcpzzLWOJoSFFGL1+t0fr7xl77WQ35GeAsRN+QId0=', NULL, FALSE, 'STD251101', 'OKEO', 'tellygaush@gmail.com', FALSE, TRUE, '2025-02-13 13:59:07.603429', 'DAMIAN'),
  (192, 'pbkdf2_sha256$600000$AJLamiB31uBU40TYu5GSo9$b5QPdkdGxJ+c5RYdZPTdQWNn/1FcmH5AWNAIPlJ3fTc=', NULL, FALSE, 'STD251112', 'KIMARE', 'mwikilydia@gmail.com', FALSE, TRUE, '2025-02-13 14:02:18.142386', 'MYLES'),
  (193, 'pbkdf2_sha256$600000$DY86OevWwMDNaUpbxYLKHH$z/cuF+653rYK60qEfMfpmMKtOl/ook1dVEg3DpD19Ck=', '2025-07-31 07:19:52.606552', FALSE, 'mwalimuopiyo1@gmail.com', 'OPIYO', 'mwalimuopiyo1@gmail.com', FALSE, TRUE, '2025-07-14 15:04:28.995970', 'DICKSON'),
  (194, 'pbkdf2_sha256$600000$TwjsiGKbNgpTDmpAwemhts$0XtVlqHAsIbMKsyF8b1HXbBLRcppERwk+8Wft9Vig5A=', '2025-10-17 10:20:06.222674', FALSE, 'robibeneti9@gmail.com', 'ROBI', 'robibeneti9@gmail.com', FALSE, TRUE, '2025-07-31 07:57:00.570553', 'BENETI'),
  (195, 'pbkdf2_sha256$600000$R3M28vaJJXZzbbWxDsUIoX$KO+prDrKg1GuIRcqoznqm6gOpz1Pk10GboADPeoi5DY=', NULL, FALSE, 'STD250120', 'OUMA', 'Paulinefaith988@gmail.com', FALSE, TRUE, '2025-07-31 11:37:08.165326', 'CHARLES'),
  (196, 'pbkdf2_sha256$600000$ktsJmPTlqWRuKYqBs2Ewwn$tJRmvedOagCb0vKib5eK17Wcyhcc3w5S4L0OxzYqePw=', '2025-08-01 10:09:13.784396', FALSE, 'STD25134', 'OUMA', 'Paulinefaith988@gmail.com', FALSE, TRUE, '2025-07-31 13:35:11.282112', 'CHARLES'),
  (197, 'pbkdf2_sha256$600000$WRmxIfKoXj1SITnGvgpcj5$5lDV+tUoZXPTH22HU8BIQJLKaG3gUKlyJvCtr4/Im2c=', NULL, FALSE, 'STD25135', 'MARANGO', 'Paulinefaith988@gmail.com', FALSE, TRUE, '2025-07-31 13:37:36.549448', 'LEWIS'),
  (198, 'pbkdf2_sha256$600000$xp6Q9NFF6Y8b4Gn8f1O19D$8ajVfXVQEe8KgbAFuPz6mISSp1sGPLBaNkX1yd8HJIU=', NULL, FALSE, 'STD25138', 'GANZA', 'Paulinefaith988@gmail.com', FALSE, TRUE, '2025-07-31 14:25:01.329442', 'IVAN'),
  (199, 'pbkdf2_sha256$600000$ZuUpd3V86kbivWcw3WvvxN$lP2lYttdS+vGeoZDEL+e6hK1XytSox5sEC9eYeI+mVA=', NULL, FALSE, 'STD251341', 'PROMISE', 'Paulinefaith988@gmail.com', FALSE, TRUE, '2025-08-01 09:33:03.159556', 'JAYDEN'),
  (200, 'pbkdf2_sha256$600000$ZMFGU9jrOHMvtyb9A8mlwg$BYNjeWb4Zt6BLCw9OKEVTJyjpuAXweep8zGrnwoBKJQ=', NULL, FALSE, 'STD25136', 'IRAKOZE', 'Paulinefaith988@gmail.com', FALSE, TRUE, '2025-08-01 10:00:41.921472', 'SINCERE'),
  (201, 'pbkdf2_sha256$600000$mjIwYAAojrS2eSmBV8kATf$1zMLR1bmhe2+zxyAzSOxpIKlQ8DDaD6inhm6tRM/64o=', NULL, FALSE, 'STD25139', 'HIRWA', 'Paulinefaith988@gmail.com', FALSE, TRUE, '2025-08-01 10:02:51.013383', 'JAYDEN'),
  (202, 'pbkdf2_sha256$600000$EuEqiYupubDeY69Sy8iQBa$G4qrYYM3ttVLHk08KYWfN7x8pYa4aqPKM0KyNuVwZyo=', NULL, FALSE, 'STD25140', 'Roberts', 'Paulinefaith988@gmail.com', FALSE, TRUE, '2025-08-01 10:07:52.483823', 'Emmanuel'),
  (203, 'pbkdf2_sha256$600000$9F5tCweLFZ36YgO6dFmSRx$ZqVrB2oK76TgdX2w+WVQMfdi7T9ien9N3PCSOe/GzZM=', '2025-08-01 10:43:10.964706', FALSE, 'STD25141', 'ONGARO', 'Paulinefaith988@gmail.com', FALSE, TRUE, '2025-08-01 10:13:07.260540', 'GAVIN'),
  (204, 'pbkdf2_sha256$600000$hnGNuTW9lsqg4bFIWg9Qmk$vG3oE02uiW0+nOppS8MvQdlgGmpkZYveGpLyspK47TI=', NULL, FALSE, 'STD25142', 'Ntugutse', 'Paulinefaith988@gmail.com', FALSE, TRUE, '2025-08-01 10:15:38.839808', 'Daniel'),
  (205, 'pbkdf2_sha256$600000$tfuMa50tQM9K4NNeQcj2Fu$ZrtO2GIQ7PdppKeZCC51+IbRYau5CWMFB6LEz25OTyk=', NULL, FALSE, 'STD251201', 'EDEN', 'Paulinefaith988@gmail.com', FALSE, TRUE, '2025-08-05 12:42:40.502948', 'NATHAN'),
  (206, 'pbkdf2_sha256$600000$GSplc3U1gIgfE5oNm1FISU$dLFtTNtX2GQFcoR3WqjuywTTG9OfyOudmRFmag6MK1k=', NULL, FALSE, 'STD251281', 'KARL', 'Paulinefaith988@gmail.com', FALSE, TRUE, '2025-08-05 12:47:20.165812', 'ROMAN'),
  (207, 'pbkdf2_sha256$600000$KnJYgOVmGOVqIQPjmuTqGG$mmufFHRekjuAIPvkBkZEArDb1DvSoKJbPQIdWDIRW7k=', NULL, FALSE, 'STD251342', 'IDRIS', 'Paulinefaith988@gmail.com', FALSE, TRUE, '2025-08-05 12:53:00.116721', 'ZAMI'),
  (208, 'pbkdf2_sha256$600000$ibTn0n7iOB973a2gfdVwJz$JYZKE6A5eFxmnzD9y1lQdk+FCHuYfi8JWwmQZD5jVmk=', NULL, FALSE, 'STD251351', 'IGIRANEZA', 'Paulinefaith988@gmail.com', FALSE, TRUE, '2025-08-05 12:58:24.295768', 'STEPHANIE'),
  (209, 'pbkdf2_sha256$600000$qZoTVQUYvjaEzBC3ftwY5x$99zx4+9yd4g0IYVW0lxHu4KDWugg2Uc6hkbjB5oP1cc=', NULL, FALSE, 'STD251391', 'EVERLYNE', 'Paulinefaith988@gmail.com', FALSE, TRUE, '2025-08-05 13:03:21.455227', 'HEYDEH'),
  (210, 'pbkdf2_sha256$600000$LoLh78z8roptUqZZYLxV0d$26dkJuujmFamS94raioW7DBN4PcuKXYhw6heX2BHj8s=', NULL, FALSE, 'STD25143', 'WATIRI', '', FALSE, TRUE, '2025-08-19 12:34:00.979948', 'VICTORIA'),
  (211, 'pbkdf2_sha256$600000$dNXOq2vGuKRvVJZXuPcqmx$iwsUnLlIS5C30Eg9jtoXSTGmLU98wcOyuJrRs+iLtkg=', NULL, FALSE, 'STD25144', 'WANGUI', '', FALSE, TRUE, '2025-08-19 12:44:18.501230', 'SHARLEEN'),
  (212, 'pbkdf2_sha256$600000$jHBLDu1ruwoz3DXltFVOHa$Xr2ASFH1dEa239UebZghWqeq04VL2dqTnU7cNbtOoVk=', NULL, FALSE, 'STD25145', 'NTINZI', '', FALSE, TRUE, '2025-08-22 07:52:24.725616', 'ADDY'),
  (213, 'pbkdf2_sha256$600000$o5Q53ppqtOItOeqQeQGJ1s$V0lKtL88e8M790Sa12NC3qKklT8psli2NPppvvmgzX4=', NULL, FALSE, 'STD25146', 'BUTOTO', '', FALSE, TRUE, '2025-08-22 10:15:44.358003', 'PRINCESS'),
  (214, 'pbkdf2_sha256$600000$Km32H1gqBoIa5c64m0AQDX$uLHa9WDWjFoDH5ApCs1X8YNsL+EZjBZcayKDQ6QbJks=', NULL, FALSE, 'STD25147', 'BUKURU', '', FALSE, TRUE, '2025-08-22 10:19:13.947478', 'PRINCE'),
  (215, 'pbkdf2_sha256$600000$0itJgwkJ59H7F4YUCGMum2$4n0Kx1FbZxEf1buUQ6kOp3nL3qy23kzCK3CZ+q3q1ZE=', NULL, FALSE, 'STD25148', 'DIVINE', '', FALSE, TRUE, '2025-08-22 10:32:06.948578', 'KIRENGA')
ON CONFLICT DO NOTHING;
INSERT INTO "auth_user" ("id", "password", "last_login", "is_superuser", "username", "last_name", "email", "is_staff", "is_active", "date_joined", "first_name") VALUES
  (216, 'pbkdf2_sha256$600000$XVyu0PzYuyvfTykM737qUV$Z+fRMXXy8Cu0txQosKd0bH+Mz0ThfNkky+zGwkZWy3k=', NULL, FALSE, 'STD25149', 'IRABARUTA', '', FALSE, TRUE, '2025-08-22 10:36:10.626430', 'NICHEVA'),
  (217, 'pbkdf2_sha256$600000$evPCn4lhAHw0OPP4j5Evzh$9J1G7sjaC0tc8kV18XSCk5a6w+ev+aukOKmDcb21d98=', NULL, FALSE, 'STD25150', 'MACHARIA', '', FALSE, TRUE, '2025-08-22 12:43:38.369694', 'REAGAN'),
  (218, 'pbkdf2_sha256$600000$w1fF3x1UnHvPW9d6KPUDcn$EZf030xDAxEoA+PJM4BzizLEzXF4/ZYyIr7m6Wr/8hk=', NULL, FALSE, 'STD25151', 'MUMO', '', FALSE, TRUE, '2025-09-01 12:11:23.820977', 'LYNASHER'),
  (219, 'pbkdf2_sha256$600000$QTMeIkFDpBrMa8NGzCyFih$04xHs0ISHTsdxTCZeBoP8HoeRgcX8TgwaxImZcb1Mf4=', NULL, FALSE, 'STD250231', 'WANYAMA', '', FALSE, TRUE, '2025-09-01 12:18:21.016366', 'NOAH'),
  (220, 'pbkdf2_sha256$600000$yzYXJJtMauaKC1dItGevGl$8nMbUprLlHNVjWmw3MCkWMninWNbr0FZmLqqplqyRm0=', NULL, FALSE, 'STD250211', 'ROBERT', 'Paulinefaith988@gmail.com', FALSE, TRUE, '2025-09-01 14:47:11.391554', 'BONFACE'),
  (221, 'pbkdf2_sha256$600000$E6acrD1bjF9wmrp9lPAyYg$kEolmhGCThPeYFBS9W/JMF10bKC1WC8757aEflJC1Kg=', NULL, FALSE, 'STD250531', 'NAMAI', '', FALSE, TRUE, '2025-09-01 14:58:23.719673', 'HUMPHREY'),
  (222, 'pbkdf2_sha256$600000$gcE1gY8RTaiOo7Vw2n6Gah$uSnq7zRAlN6Zewzxt94YqJG4/Kz15ICit50Lgh1bxes=', NULL, FALSE, 'STD250431', 'WATIRI', '', FALSE, TRUE, '2025-09-01 15:05:04.193500', 'VICTORIA'),
  (223, 'pbkdf2_sha256$600000$2zRA3Aj9XwbV5o7sAiRn4Z$8stzHFREhvIyD6H7PpPTroX5mvlfzKP4m03t0AhHHrI=', NULL, FALSE, 'STD250501', 'CHEGE', '', FALSE, TRUE, '2025-09-03 04:34:07.450783', 'YANCY'),
  (224, 'pbkdf2_sha256$600000$j1aR70qQ9FTBwv4EOhdYYn$MYX4kj0wSr9YFHFiqZsK5NBNWFLeTybxH6ilIH8gk4M=', NULL, FALSE, 'STD251491', 'SAMUEL', '', FALSE, TRUE, '2025-09-08 12:10:19.768637', 'ANGEL'),
  (225, 'pbkdf2_sha256$1000000$jmBDZGElnlHn2c1sUSvhne$UTGij5K58wlI4dWWbYOS6d9n6C64QIztKztV2Bg3hu8=', '2025-10-17 10:56:34.049308', TRUE, 'admin3', '', 'admin@gmail.com', TRUE, TRUE, '2025-10-17 10:56:21.569922', ''),
  (226, 'pbkdf2_sha256$600000$8gx1z3uj704AekVbZ3dCRM$pk7RNE6yyYpEyQndqHkuI1P6DOxmhAiYpw//UVF44+s=', '2026-02-02 16:53:46.108159', TRUE, 'school', '', 'school@gmail.com', TRUE, TRUE, '2025-11-20 12:15:10.575734', ''),
  (227, 'pbkdf2_sha256$1000000$LOS2cThycPY0D33PGFYlSc$MeLJpneDUEtYPSyWzsmxjm6fDyH9xqwe/USQMTx9GX4=', NULL, FALSE, 'STD70001', 'Hamisi', 'school@gmail.com', FALSE, TRUE, '2025-11-25 13:13:50.563649', 'Saida'),
  (228, 'pbkdf2_sha256$1000000$LDh067BvzCsXZFYaCdx7Y3$NJhSKpeq2etuC2CUlAoycA7NCZaVY/ULz2ZAQlVwMf4=', NULL, FALSE, 'STD70002', 'Jamila', 'amosorupia24@gmail.com', FALSE, TRUE, '2025-11-25 15:39:53.070004', 'Saidah'),
  (229, 'pbkdf2_sha256$1000000$276RtHYvIVqeWtqVHqjm1B$nS35QpxuUNBmaWOab6KVEmVMICXvyBmRlTq335bkbz8=', NULL, FALSE, 'STD7008', 'Hamisi', 'nyinzoka@gmail.com', FALSE, TRUE, '2025-11-26 16:41:31.886780', 'DANIEL'),
  (240, 'pbkdf2_sha256$1000000$sZfKgLxlWWSULmxcDWNxnm$2aYYdfqwAaaXlG/V2oA1lhifp09zdvF/eb6AZ3lxEIc=', '2026-01-20 15:36:37.856617', TRUE, 'admin', '', 'admink@gmail.com', TRUE, TRUE, '2026-01-12 22:27:13.369919', ''),
  (241, 'pbkdf2_sha256$1000000$EOGYgaX8jF7bxaLXIikIwb$q+Szx8inCu4xEMQ+J0jbh7VXqm14U8jNwaTc0tQNFRE=', '2026-01-14 15:26:50.090397', FALSE, '0749738248', 'Hamisi', '', FALSE, TRUE, '2026-01-13 11:06:04.520628', 'Saidah'),
  (780, 'pbkdf2_sha256$1000000$NhcZYanSBmaOlGWAwuB3zL$QNJyIOYdyjd1G6BUuQvMDdRYFlO5euWv5V37Msw3+f8=', NULL, FALSE, 'STD7621', 'Jasmin baraka', 'student7621@example.com', FALSE, TRUE, '2026-01-14 04:53:08.653913', 'Alvin'),
  (781, 'pbkdf2_sha256$1000000$LBxOe9SSyVlcyYCPwIoqRD$IyUstVVdU3Cld8ZzqrxyZgqcl2EmPGMubtCypqTIp7U=', NULL, FALSE, 'STD7622', 'njuguini', 'student7622@example.com', FALSE, TRUE, '2026-01-14 04:53:10.305973', 'Natasha'),
  (782, 'pbkdf2_sha256$1000000$UjSb81bE7tAzTlmjLrXyQM$bt3Sp7xggi0/O5Rkz9m2hEVHuw6dhbn5LJsVX8HSqMk=', NULL, FALSE, 'STD7599', 'kungu', 'student7599@example.com', FALSE, TRUE, '2026-01-14 04:53:11.731530', 'Liam'),
  (783, 'pbkdf2_sha256$1000000$LAPqNLyhv9re4tlssUBFke$h0px61gkzSiXzy/AQfkjiG16b2WKF+vd5vzqmd37h/g=', NULL, FALSE, 'STD7515', 'Gitau', 'student7515@example.com', FALSE, TRUE, '2026-01-14 04:53:13.494553', 'Jessin'),
  (784, 'pbkdf2_sha256$1000000$K98ucaVUbHKf0bLdUOHVv8$oDFSfhRdb0JBTZzYKm5+UUD+0z/Zc9g9sg5RwQue5Y8=', NULL, FALSE, 'STD7608', 'wanjiku', 'student7608@example.com', FALSE, TRUE, '2026-01-14 04:53:15.434570', 'Ainsley'),
  (785, 'pbkdf2_sha256$1000000$BEdodj95ck1ygjtuNt8ZSE$ljVT2OHOJaZzirpUTN5B5Fjoma4pge6rv0DclbFXqQE=', NULL, FALSE, 'STD7464', 'isack muriuki', 'student7464@example.com', FALSE, TRUE, '2026-01-14 04:53:16.772837', 'Ethan'),
  (786, 'pbkdf2_sha256$1000000$j48jWSJ7OPUJ0hHXTxd7jH$s7YfkoHziSymMtbpujv2bMI578lGTeH6ob1QH0mkH5I=', NULL, FALSE, 'STD7558', 'Natasha wangari', 'student7558@example.com', FALSE, TRUE, '2026-01-14 04:53:18.322210', 'Joy'),
  (787, 'pbkdf2_sha256$1000000$G4CW201YZblTddVbDWNjCf$WBy4FUqSGbFqXtiLFJf8Wa6tlujNPomMzmkldRUUqdU=', NULL, FALSE, 'STD7473', 'njeri', 'student7473@example.com', FALSE, TRUE, '2026-01-14 04:53:20.064986', 'Allaine'),
  (788, 'pbkdf2_sha256$1000000$xm685uV8ekGMdPYL4IKgBL$is82xOI/WxxJ5nI3KFCFsuS/N++z0mBW/zl4k4D6w04=', NULL, FALSE, 'STD7467', 'nduku mutisya', 'student7467@example.com', FALSE, TRUE, '2026-01-14 04:53:21.452811', 'Favour'),
  (789, 'pbkdf2_sha256$1000000$zTFK5FLYXC51rgefrxkzA9$XubjbLjaZTQ0fkubvqjZrtHh8CAWZFy50N9m/5t6Ifs=', NULL, FALSE, 'STD7598', 'gikonyo', 'student7598@example.com', FALSE, TRUE, '2026-01-14 04:53:23.131299', 'Archie'),
  (790, 'pbkdf2_sha256$1000000$Ap7Cfs4EMYJyHvgHzRCiTf$3/7lqxofQEY9Nd04aCvuF384z1HWAwOaZYeov7ymaRA=', NULL, FALSE, 'STD7466', 'wangeci', 'student7466@example.com', FALSE, TRUE, '2026-01-14 04:53:24.685125', 'Ivy'),
  (791, 'pbkdf2_sha256$1000000$u5ps7Ioh5pVNFyU1qQFZr2$2FTONFemdxBHf6tnmRyPm45oD88B4S8LvqqZQgADAhs=', NULL, FALSE, 'STD7600', 'marya mwaluko', 'student7600@example.com', FALSE, TRUE, '2026-01-14 04:53:26.816948', 'Cacey'),
  (792, 'pbkdf2_sha256$1000000$68cPS2CkpONhM68U9vfPGQ$r4cKGjj0UOO2KYiqIsuWgUmIYbauwpAM0R3jiJ9dOzg=', NULL, FALSE, 'STD7512', 'gathoni', 'student7512@example.com', FALSE, TRUE, '2026-01-14 04:53:28.437562', 'Annabel'),
  (793, 'pbkdf2_sha256$1000000$ns5pWxLRP1fzZTsQwvX9OS$At0UA2Mvs2eUM3vVM5CvrGDBGK9/vCvWmGGFxey8trg=', NULL, FALSE, 'STD7623', 'induvil', 'student7623@example.com', FALSE, TRUE, '2026-01-14 04:53:30.055915', 'Johnson'),
  (794, 'pbkdf2_sha256$1000000$itxOpbhyLUBu4thmDoGNlr$m4Df81gMTb5gDFWE0A+23SGAYl/GI0d4rmbVabjYef4=', NULL, FALSE, 'STD7479', 'njeri', 'student7479@example.com', FALSE, TRUE, '2026-01-14 04:53:31.870368', 'Shaniz'),
  (795, 'pbkdf2_sha256$1000000$RarPMoL1fAyzoBDu8koBL1$t6iLKTjXszTvdMp7QYnEtr7SyoJJCJXgwElSHeuJfPQ=', NULL, FALSE, 'STD7597', 'mutheu', 'student7597@example.com', FALSE, TRUE, '2026-01-14 04:53:33.575294', 'Jasmine'),
  (796, 'pbkdf2_sha256$1000000$PShrHJp3CW0Zyw66YlQESu$aYB9Z27SAwS0o1N7qF/45nxWc++9EA13Pzh/ZphQzLg=', NULL, FALSE, 'STD7609', 'Joshua syonthi', 'student7609@example.com', FALSE, TRUE, '2026-01-14 04:53:35.065350', 'Nelsa'),
  (797, 'pbkdf2_sha256$1000000$yrTNhMFkUwZtiZrwuv11QQ$cgrVGtLJ0Dfjz0LgFj8PwGNVHOpsrreBXcKHnT8ER6A=', NULL, FALSE, 'STD7555', 'james', 'student7555@example.com', FALSE, TRUE, '2026-01-14 04:53:36.842420', 'Dylan'),
  (798, 'pbkdf2_sha256$1000000$8l95IUcjnyjgybfTTR9oyz$2jdcB6xspFcza2GczdkUB4Ih02FD9TbePAI+pQOJ0L8=', NULL, FALSE, 'STD7469', 'gitahi', 'student7469@example.com', FALSE, TRUE, '2026-01-14 04:53:38.481598', 'Justin'),
  (799, 'pbkdf2_sha256$1000000$C78iW1Fmqjyb5fWSjNP0XJ$ys4UPFyMHt+hHN0u2FaQF20iUdEBM6el9MqGQUC3Yfw=', NULL, FALSE, 'STD7492', 'fadhila', 'student7492@example.com', FALSE, TRUE, '2026-01-14 04:53:39.934985', 'Raziella'),
  (800, 'pbkdf2_sha256$1000000$UcdMEiSC8MCGsHvHcTMEMt$OW+sgUxIIB/z3/w7iGwJ/LxMDLeW/g6TQsjBPhIVXwQ=', NULL, FALSE, 'STD7484', 'mbula', 'student7484@example.com', FALSE, TRUE, '2026-01-14 04:53:42.346029', 'Victoria'),
  (801, 'pbkdf2_sha256$1000000$z1bPcZhFK6C4udc9tgkUOb$jrHtB609LaskCtnJgwWFuXWAPZl0g4Zv1mmF1iuzZhE=', NULL, FALSE, 'STD7617', 'njoki', 'student7617@example.com', FALSE, TRUE, '2026-01-14 04:53:43.949245', 'Octavia'),
  (802, 'pbkdf2_sha256$1000000$TuR74mvQ6XVzXsd7JUuCPb$gAVuuVtSI5aMCd0X4W4gMFmx9lkp4VdunKj/3Degq3A=', NULL, FALSE, 'STD7561', 'mwithaga', 'student7561@example.com', FALSE, TRUE, '2026-01-14 04:53:45.330780', 'Sherleen'),
  (803, 'pbkdf2_sha256$1000000$NBTZZdbCUbCT2OwHUQr8vi$Mq+crlw8o3cb7IqyLOjJMENx3jctD+Sl2uAm0pHAcEY=', NULL, FALSE, 'STD7485', 'wanjira', 'student7485@example.com', FALSE, TRUE, '2026-01-14 04:53:46.897653', 'Sophia'),
  (804, 'pbkdf2_sha256$1000000$XwAMPou3M3qRWcIliyAYqy$4B5TgvrutoBl9rHMtfABBp+ImBmnnhY4819Dyhc54sg=', NULL, FALSE, 'STD7624', 'gachemba', 'student7624@example.com', FALSE, TRUE, '2026-01-14 04:53:48.484042', 'Tallia'),
  (805, 'pbkdf2_sha256$1000000$6imOoNDdQC7bfatKLRlMoJ$TUEPut59OeT5+06hrTM3c0OvSCoXGFdLirIHMftug08=', NULL, FALSE, 'STD7497', 'muthoni', 'student7497@example.com', FALSE, TRUE, '2026-01-14 04:53:50.259612', 'Lucy'),
  (806, 'pbkdf2_sha256$1000000$ioSIqCYnIfLeDorFYIJQYI$4n0wS2eKswA2irgVoI8F88clMZEb5c2J9KBMbVe7nmM=', NULL, FALSE, 'STD7610', 'nyambura', 'student7610@example.com', FALSE, TRUE, '2026-01-14 04:53:52.148944', 'Precious'),
  (807, 'pbkdf2_sha256$1000000$Alge87N90eYtrqxC4yhJKo$5ObLfJ0Xoql4S4owJpb7OwhmEtk2mJm5P6JCaAWN5xY=', NULL, FALSE, 'STD7521', 'njeri', 'student7521@example.com', FALSE, TRUE, '2026-01-14 04:53:53.757870', 'Ivanna'),
  (808, 'pbkdf2_sha256$1000000$30Sp738iHJ3KlTS9F4qLWM$7ou/aaR4QVeW0/iGW6w3hx90blvikokGebTJyZkUaBY=', NULL, FALSE, 'STD7297', 'wanjiru', 'student7297@example.com', FALSE, TRUE, '2026-01-14 04:53:55.177738', 'Mary'),
  (809, 'pbkdf2_sha256$1000000$8Xp1Ihuur1paaOUbledVDm$bOw+hCxCNahArEkRbhShT+L9P/jEUMlMvZPyjjUMYJM=', NULL, FALSE, 'STD7593', 'wangari', 'student7593@example.com', FALSE, TRUE, '2026-01-14 04:53:56.766360', 'Abigael'),
  (810, 'pbkdf2_sha256$1000000$9cYThSHuQ6OhL7iLFTY1OZ$l7o+L8nnKEP0GtUOA8knr5dbW4wE37hwhLtD3FFMrWg=', NULL, FALSE, 'STD7495', 'njambi', 'student7495@example.com', FALSE, TRUE, '2026-01-14 04:53:58.344998', 'Annerlisah'),
  (811, 'pbkdf2_sha256$1000000$6Vj1sz0JGQYbMGWij6zpug$9Crtp0DMLBhSri47cWzd9rvtQmGzhfW5080kO9iQDg0=', NULL, FALSE, 'STD7604', 'monthe', 'student7604@example.com', FALSE, TRUE, '2026-01-14 04:53:59.800888', 'Felicia'),
  (812, 'pbkdf2_sha256$1000000$M5m3ty3E5QW8kRBK7wbdA8$/DIZVO9Sugu7cMQhUYGO6WZdKkH6247N48XB6AxIJEs=', NULL, FALSE, 'STD7295', 'watiri', 'student7295@example.com', FALSE, TRUE, '2026-01-14 04:54:01.451979', 'Favour'),
  (813, 'pbkdf2_sha256$1000000$HSHQZmHMasxKt7ishV7MVI$CrO+251DdQyfaZcglfZj9f2Ohgvzn7gXCVvj8Fiqhgg=', NULL, FALSE, 'STD7625', 'ryan', 'student7625@example.com', FALSE, TRUE, '2026-01-14 04:54:03.150016', 'Ashley'),
  (814, 'pbkdf2_sha256$1000000$RpmkL8OFc3wHwMV5JC8XwH$1OeuK6IV/+6GdJ9AYOjmU/xFxxR8sa0QehdFebgkGtM=', NULL, FALSE, 'STD7608_2', 'mueni', 'student7608_2@example.com', FALSE, TRUE, '2026-01-14 04:54:04.540979', 'Stacy'),
  (815, 'pbkdf2_sha256$1000000$tCCEu4zqKq5zhmPsAFIrox$yFXKJbOZKJGVFD8oO4rRFbpmZeDMJxuS39t32/b/bFw=', NULL, FALSE, 'STD7626', 'ngina', 'student7626@example.com', FALSE, TRUE, '2026-01-14 04:54:06.247247', 'Keziah'),
  (816, 'pbkdf2_sha256$1000000$ztLoLWbx2uJPMAjI8z8oxx$JRsNhYw/QlNQ9YT4SsvjeEtG1azvuv5uz7hIaRl2KUE=', NULL, FALSE, 'STD7513', 'kiguru', 'student7513@example.com', FALSE, TRUE, '2026-01-14 04:54:07.825370', 'Ethan'),
  (817, 'pbkdf2_sha256$1000000$EDdRXgPHgZbnf4VFuNgbQ8$96Bbs+pJWvJDQu2rniZqO76zt7/AmOvEH4FYzSGNEQ4=', NULL, FALSE, 'STD7553', 'maina', 'student7553@example.com', FALSE, TRUE, '2026-01-14 04:54:09.200692', 'Jason'),
  (818, 'pbkdf2_sha256$1000000$ZqrpKgxe0e9AzhTLTFDpb2$J/8k7OxlMkf1yPTrKtuKVkB4DKbpiDF5t3nBqCbkOkg=', NULL, FALSE, 'STD7587', 'mwangi', 'student7587@example.com', FALSE, TRUE, '2026-01-14 04:54:10.819694', 'Willson'),
  (819, 'pbkdf2_sha256$1000000$W0EfYmKbBOhbOEkg5xK5ex$QHnnr3y53iKaxVI47uU8K/AEKxK00KgspMoKtLNRYm4=', NULL, FALSE, 'STD7531', 'musembi', 'student7531@example.com', FALSE, TRUE, '2026-01-14 04:54:12.350478', 'Vincent'),
  (820, 'pbkdf2_sha256$1000000$EE7RcXwD1ClTSziRXYifxC$96h4JKS+uCJWtAIkKA/gw2q2CE3WrEA6kdtNx685V1M=', NULL, FALSE, 'STD7602', 'kilonzo', 'student7602@example.com', FALSE, TRUE, '2026-01-14 04:54:13.741799', 'Savior'),
  (821, 'pbkdf2_sha256$1000000$9OSoTJDpllx64FWcXWGVUN$VqUeivsH/pBH3iBfO03URRKWEB8Z7Kmz7WC730UQn5A=', NULL, FALSE, 'STD7545', 'mwenda', 'student7545@example.com', FALSE, TRUE, '2026-01-14 04:54:15.623490', 'Erick'),
  (822, 'pbkdf2_sha256$1000000$3CFFlsdEWgX8xsDbUJE0fa$GMCSwXLyEzsQUhS+17JjQahI0CmvFs8HW3vhoTG9Eko=', NULL, FALSE, 'STD7549', 'githiga', 'student7549@example.com', FALSE, TRUE, '2026-01-14 04:54:17.297582', 'Caleb'),
  (823, 'pbkdf2_sha256$1000000$8GfubCqD8cKhcfaFBP4TBS$ZvbcE8nJT3zHe/COSJc32dI+FGrjEwPr4r+/EtNHJL8=', NULL, FALSE, 'STD7557', 'Wekesa', 'student7557@example.com', FALSE, TRUE, '2026-01-14 04:54:18.760300', 'Vincent'),
  (824, 'pbkdf2_sha256$1000000$5zvWYU9tg40qNc3hxhO66U$IkNC9Qlo+8/wy52h2gTEXzmpr4musf8Wapil+dQNwxc=', NULL, FALSE, 'STD7480', 'reign munene', 'student7480@example.com', FALSE, TRUE, '2026-01-14 04:54:20.327009', 'Mark'),
  (825, 'pbkdf2_sha256$1000000$XyvTTG0ulYqBSDSm8iZfQx$3w7lFf1RPiUlNNt6c/9SlbmPPmbERH+IQdSWbfNRois=', NULL, FALSE, 'STD7618', 'warui', 'student7618@example.com', FALSE, TRUE, '2026-01-14 04:54:21.989437', 'Ayaan'),
  (826, 'pbkdf2_sha256$1000000$k5ggTmXMJHe6fDOPXeuS3G$XDaBKjdIT0vLzaxo3ijiYnn1TWN5IlOrtxT+HdNoBpc=', NULL, FALSE, 'STD7607', 'munene', 'student7607@example.com', FALSE, TRUE, '2026-01-14 04:54:23.373407', 'Prosper'),
  (827, 'pbkdf2_sha256$1000000$yrwwA9wRmF2mG0uHdJZvXl$rmYsI9UxZBEd2xtq+xAp15hvY4G3T6kQHwphtfdaH54=', NULL, FALSE, 'STD7505', 'tsiro', 'student7505@example.com', FALSE, TRUE, '2026-01-14 04:54:24.942350', 'Kyshia'),
  (828, 'pbkdf2_sha256$1000000$Oyyxq8e8Tqx3Yw0RjplHKp$TI2goE1cAE8SAJtI2OF5F/jkbBuPVAC8gE+D7WnHQ0o=', NULL, FALSE, 'STD7468', 'ndanu', 'student7468@example.com', FALSE, TRUE, '2026-01-14 04:54:26.621187', 'Blessing'),
  (829, 'pbkdf2_sha256$1000000$zqPSeA3ZIctSbzjCAyZHh1$7y68G6rVWRve0rpUYplJX6iokPGIZzaLqeE/7wVStVI=', NULL, FALSE, 'STD7498', 'kaloki', 'student7498@example.com', FALSE, TRUE, '2026-01-14 04:54:27.993795', 'Abigael'),
  (830, 'pbkdf2_sha256$1000000$nZrD80ZC8TGAFoJ6sDxa0s$t3H7coyxpyysIueUQiKh/JfU7tkoyoWe4X+ewsF0hYw=', NULL, FALSE, 'STD7501', 'wangeci', 'student7501@example.com', FALSE, TRUE, '2026-01-14 04:54:29.549700', 'Abigael'),
  (831, 'pbkdf2_sha256$1000000$EFEWfHGh25L9I7sENNZcSR$Rrtqi48lewGXNsupiztUmyvnlqHa2rUAuWcsglnWQm8=', NULL, FALSE, 'STD7499', 'wangari', 'student7499@example.com', FALSE, TRUE, '2026-01-14 04:54:31.407261', 'Talia'),
  (832, 'pbkdf2_sha256$1000000$k2dvtKe1k8T9cMFJKIZkyB$h9rwai/6FILn1ro8Ft4K/l1Nd/0kltE8i7O86fYA/bw=', NULL, FALSE, 'STD7509', 'nduta', 'student7509@example.com', FALSE, TRUE, '2026-01-14 04:54:32.816552', 'Tauriel'),
  (833, 'pbkdf2_sha256$1000000$0GqmTkwCJzGB66aHqC9mgl$FvdM/vdPrX1jCP6FBIGMe6dn4Yigm7Qq97ik2kzwf4I=', NULL, FALSE, 'STD7552', 'wangari', 'student7552@example.com', FALSE, TRUE, '2026-01-14 04:54:34.386042', 'Lillyann'),
  (834, 'pbkdf2_sha256$1000000$2UTse6VfvilzCB5IwPfnIb$hyKnBSCYuebfdeVoyPD3v3hp4fvpHlgqzymLq5ufC4k=', NULL, FALSE, 'STD7530', 'mutanu', 'student7530@example.com', FALSE, TRUE, '2026-01-14 04:54:35.988959', 'Miriam'),
  (835, 'pbkdf2_sha256$1000000$LeFsxCkDVTmre1xNNKVdJP$cY+GSRCV268UtAPqaTjquHZ8Yw1vcnYD6aasSeqAMF8=', NULL, FALSE, 'STD7488', 'wamucii', 'student7488@example.com', FALSE, TRUE, '2026-01-14 04:54:37.364835', 'Shani'),
  (836, 'pbkdf2_sha256$1000000$9Twf7g5MFPrDIBASldpRzT$YotiQl9x9cIyRubiuaC35CDe7FJXnf4WK7QQttdDPvU=', NULL, FALSE, 'STD7596', 'mutanu', 'student7596@example.com', FALSE, TRUE, '2026-01-14 04:54:38.943637', 'Precious'),
  (837, 'pbkdf2_sha256$1000000$7uBprfsH2Vh0nphwhhAP8M$55kk1W6o3EO6Np2c3u1qFLCRUalB1pxAp09wP3c26pE=', NULL, FALSE, 'STD7519', 'zawadi', 'student7519@example.com', FALSE, TRUE, '2026-01-14 04:54:40.541976', 'Sydel'),
  (838, 'pbkdf2_sha256$1000000$CJcFLb6IUgtSP1lZm13MHB$yHY1g+uIez5QJDNCde8H8Un7Ug7vgCOc6G2EyD/1pIU=', NULL, FALSE, 'STD7472', 'akinyi', 'student7472@example.com', FALSE, TRUE, '2026-01-14 04:54:41.987883', 'Kayla'),
  (839, 'pbkdf2_sha256$1000000$diZsqkoYNO8xGMmsF2IuD9$SoXqyH9+641pukuaxlbubNOkXYYjHUM2OHMpFcuxDDA=', NULL, FALSE, 'STD7588', 'Wambui', 'student7588@example.com', FALSE, TRUE, '2026-01-14 04:54:43.576335', 'Tesslar'),
  (840, 'pbkdf2_sha256$1000000$HhkQw3WP34u7DyZxJ328Ik$DepWSBzA1PMgyb6wynEEF34FA5TEBr7dve5FOho43bo=', NULL, FALSE, 'STD7606', 'wamugunda', 'student7606@example.com', FALSE, TRUE, '2026-01-14 04:54:45.211752', 'Jian'),
  (841, 'pbkdf2_sha256$1000000$1GrJZPu119PuwslFSStFg2$YzVB+AIv2kEn8RJ1/KOlS0zddEHn8mFCyv6fGEwLvqo=', NULL, FALSE, 'STD7544', 'tumaini', 'student7544@example.com', FALSE, TRUE, '2026-01-14 04:54:46.955264', 'Hansel'),
  (842, 'pbkdf2_sha256$1000000$fTyVKGw400D1r6oCo2Renu$jUiFIVytwsJupjWXd+D4EalrXzI2s5YouLwZ1RsDea0=', NULL, FALSE, 'STD7546', 'waweru', 'student7546@example.com', FALSE, TRUE, '2026-01-14 04:54:48.630110', 'Fabian'),
  (843, 'pbkdf2_sha256$1000000$uLti0bQlrxFuZIpfqBKPXX$NalkDmR1/UxRCNS4XHIToBz+t7c+tm5ngGJ2goV+Nvo=', NULL, FALSE, 'STD7619', 'rugumi', 'student7619@example.com', FALSE, TRUE, '2026-01-14 04:54:50.203558', 'Nolan'),
  (844, 'pbkdf2_sha256$1000000$vLcFYTfJw1vC9kWz0DjbZ4$1e3dNBsCdJ5n11mEHRTWMuT5o6o2roVODCqxtaOWjfo=', NULL, FALSE, 'STD7496', 'njuguna', 'student7496@example.com', FALSE, TRUE, '2026-01-14 04:54:51.569122', 'Maxwell'),
  (845, 'pbkdf2_sha256$1000000$cf2e6IXLEHqNHx90NQRQ7T$2JZsYJ3Pojk6TAjwlEhaS1QI81TeAxtaF23qZqWEZDc=', NULL, FALSE, 'STD7527', 'warware', 'student7527@example.com', FALSE, TRUE, '2026-01-14 04:54:53.208752', 'Raphael'),
  (846, 'pbkdf2_sha256$1000000$7Y6GWuFq0FF8q4VgsLaOUI$Ag2jVN7UYp0E6CI55hpkGBFlYb7Z0phOpS3sEDMHzFs=', NULL, FALSE, 'STD7529', 'njagi', 'student7529@example.com', FALSE, TRUE, '2026-01-14 04:54:54.744891', 'Jakim'),
  (847, 'pbkdf2_sha256$1000000$TV6TQdkBXZaOdRmU45wftt$84y3bRdHkq4QhriP2bz7/6EJzPHnC5y+GRUqbJk6hHw=', NULL, FALSE, 'STD7627', 'james', 'student7627@example.com', FALSE, TRUE, '2026-01-14 04:54:56.174691', 'Bravin'),
  (848, 'pbkdf2_sha256$1000000$XYLUywb6Sd1eBQ33R58qOg$fwx1DGRJXgSwLHiFW0LQhYBxv/n/QlXXmbdgZEAYFvo=', NULL, FALSE, 'STD7612', 'George', 'student7612@example.com', FALSE, TRUE, '2026-01-14 04:54:57.784654', 'Calvin'),
  (849, 'pbkdf2_sha256$1000000$ZvAK5OiVacg2tkArVYg51C$bANcKNHk0l/By6ZhQjQdKH+uCTLgwx5lB4b39RoYuno=', NULL, FALSE, 'STD7613', 'mutiso', 'student7613@example.com', FALSE, TRUE, '2026-01-14 04:54:59.353230', 'Nathan'),
  (850, 'pbkdf2_sha256$1000000$5379j9L9NfieZgNkcgQSJC$fc97jtFHs/3KCHoBF9Gl3LmHeQrW7YyipsOp4No+6EE=', NULL, FALSE, 'STD7605', 'koome', 'student7605@example.com', FALSE, TRUE, '2026-01-14 04:55:00.897619', 'Jayden'),
  (851, 'pbkdf2_sha256$1000000$BMhcapmNJPDQ1eDF1eAi0v$29PVHDf0qVI98jCFrCjN5jso3AO1NbGUfrhMiLqS/5c=', NULL, FALSE, 'STD7517', 'njilani', 'student7517@example.com', FALSE, TRUE, '2026-01-14 04:55:02.995166', 'Chrysolite'),
  (852, 'pbkdf2_sha256$1000000$hl6F9rkURp9BLTSGvhZ1k0$W2h1gxhUqAJaUR08vFoJ49aRpm5ewtupebCvvU64VJk=', NULL, FALSE, 'STD7594', 'm. Mwololo', 'student7594@example.com', FALSE, TRUE, '2026-01-14 04:55:04.550296', 'Lewis'),
  (853, 'pbkdf2_sha256$1000000$THsckYg6hXtVpjDld4bOf1$PPxh9g5x5fMyfX+Gh09rTJVY8VbzwkM+vIu+Y4Yw9Vg=', NULL, FALSE, 'STD7595', 'mutisya', 'student7595@example.com', FALSE, TRUE, '2026-01-14 04:55:05.894879', 'Prince'),
  (854, 'pbkdf2_sha256$1000000$1sqH1Ll0McTaozsllqZnmb$ePXzZ9ZPV/C9n7vUzCFSrwCLfSLj9+4uK+qva8IDZjw=', NULL, FALSE, 'STD7189', 'muuo', 'student7189@example.com', FALSE, TRUE, '2026-01-14 04:55:07.525040', 'Emmanuel'),
  (855, 'pbkdf2_sha256$1000000$dDLhnJzcW7IqpJAH6gAYM5$ZYNE5yrmuSwyTwZN81BZ9pKDqG8Cxc9bC6oBO19WHwo=', NULL, FALSE, 'STD7538', 'baraka', 'student7538@example.com', FALSE, TRUE, '2026-01-14 04:55:09.105889', 'Liam'),
  (856, 'pbkdf2_sha256$1000000$5ovRTL2V3a14HtNOgaQUBZ$PHeMJtpOeP4XXEvY815S81wsy91DxCwAWMTqf6gWGR0=', NULL, FALSE, 'STD7489', 'gikima wainaina', 'student7489@example.com', FALSE, TRUE, '2026-01-14 04:55:10.480648', 'Jayden'),
  (857, 'pbkdf2_sha256$1000000$XV4UASc6wuukgf5M7bSwMa$GBKHg2IidIhVnOfrBnb52yFadGOBHa5i7vjeF8LFvwI=', NULL, FALSE, 'STD7615', 'njeri', 'student7615@example.com', FALSE, TRUE, '2026-01-14 04:55:12.025467', 'Shakainah'),
  (858, 'pbkdf2_sha256$1000000$dnMam9hmtt0HLOk8fi1LdH$vSd1FVufqPQpfgMHzIoGNQrfOQsDsYJshbl2OryzK18=', NULL, FALSE, 'STD7583', 'Titus', 'student7583@example.com', FALSE, TRUE, '2026-01-14 04:55:13.791816', 'Prince'),
  (859, 'pbkdf2_sha256$1000000$kZQxWa0baJOp2rLDAD3hjv$kAg7noyz08Ec0bP+xqx+/3VaoKPWg5WZdyBk6HIXvuc=', NULL, FALSE, 'STD7507', 'akello', 'student7507@example.com', FALSE, TRUE, '2026-01-14 04:55:15.304079', 'Eremino'),
  (860, 'pbkdf2_sha256$1000000$9fMyT8UnKfzxruA2ZqEPem$vUMKZKRLAl16/o7l0nL7/Y9JwJiMn16LUtsf9WlleMc=', NULL, FALSE, 'STD7532', 'kaloki', 'student7532@example.com', FALSE, TRUE, '2026-01-14 04:55:17.279652', 'Brandon'),
  (861, 'pbkdf2_sha256$1000000$TMGuq03Yc9suiQfHDXUL2t$+eNIInzPzb9pRSe4d2UX2IXHIG9h0bN/x7cfcENlhN0=', NULL, FALSE, 'STD7585', 'ndungo', 'student7585@example.com', FALSE, TRUE, '2026-01-14 04:55:18.937103', 'Roshan'),
  (862, 'pbkdf2_sha256$1000000$HrpAJGT9wHy7Knu5mcTLgU$lI08c5W6P62Cb2eJTUO5L3SlJUaFN0vtjqtIDBbi2lE=', NULL, FALSE, 'STD7535', 'Margret', 'student7535@example.com', FALSE, TRUE, '2026-01-14 04:55:20.370073', 'Wendy'),
  (863, 'pbkdf2_sha256$1000000$9RPE9PSAFsdd7SwRC9kqi9$fijdNjbumWNAxjKQUBUmgdWcun/yhxbD01H4qzkdczk=', NULL, FALSE, 'STD7441', 'warigia', 'student7441@example.com', FALSE, TRUE, '2026-01-14 04:55:21.941699', 'Asleen'),
  (864, 'pbkdf2_sha256$1000000$M7f2PyMIsHbNgmRnJ6awgj$AT9Kc2DoVoo6eYbQqdGqzMD2V2q+W4NjAu0HHDtmvys=', NULL, FALSE, 'STD7374', 'wanjiru', 'student7374@example.com', FALSE, TRUE, '2026-01-14 04:55:23.654224', 'Aryanna'),
  (865, 'pbkdf2_sha256$1000000$b552O3xFKqMPayEf6ZiXQv$C3DDS0yOyPioHa4HiE26QzMPlA+cphB+3PuqPOjvtW8=', NULL, FALSE, 'STD7478', 'moseti', 'student7478@example.com', FALSE, TRUE, '2026-01-14 04:55:25.234264', 'Patience'),
  (866, 'pbkdf2_sha256$1000000$Q2KYlUI4mcfM9PUvuAvedW$EaVSwYyYavy5HQBV235QNKDGO4/Oe75bYCf3R2XacKc=', NULL, FALSE, 'STD7368', 'karanja', 'student7368@example.com', FALSE, TRUE, '2026-01-14 04:55:27.072598', 'Leon'),
  (867, 'pbkdf2_sha256$1000000$7KbPOGiSALzPdU9tCOfWyh$dZAa/Y6N6JnVE5ZYpoc7u7HAUggRLJ4QmF7mjAi6fhg=', NULL, FALSE, 'STD7383', 'makena', 'student7383@example.com', FALSE, TRUE, '2026-01-14 04:55:28.649305', 'Ummy'),
  (868, 'pbkdf2_sha256$1000000$bIOAysm6bHhUs3YWdw9bB4$nikjTAGbEkKggKobtylfYKcWESo5IP50HkghqI/+2nY=', NULL, FALSE, 'STD7438', 'njeri', 'student7438@example.com', FALSE, TRUE, '2026-01-14 04:55:29.984142', 'Joy'),
  (869, 'pbkdf2_sha256$1000000$OqruYV6eQfcyFGmsPaCC2S$yXmZxKe0rXF4ONoUkbjTCDk9lPU1FQODMdC8UfDrkVQ=', NULL, FALSE, 'STD7425', 'ndungu', 'student7425@example.com', FALSE, TRUE, '2026-01-14 04:55:31.578863', 'Francis'),
  (870, 'pbkdf2_sha256$1000000$ww5d3CMLlBwNyjr30JnuQP$87OrBtMRnYGOWtXIOha7aw/0nspmHl0CC7V+blBkuQU=', NULL, FALSE, 'STD7384', 'muuo', 'student7384@example.com', FALSE, TRUE, '2026-01-14 04:55:33.149987', 'Satrine'),
  (871, 'pbkdf2_sha256$1000000$cLcOcrH2sKxgx39TmNH0sf$PbE7nZwtf5AoXjqRqKBIUkcsTo+TnL1OW4mUJOOOk7M=', NULL, FALSE, 'STD7310', 'mumo', 'student7310@example.com', FALSE, TRUE, '2026-01-14 04:55:34.942270', 'Alex'),
  (872, 'pbkdf2_sha256$1000000$QXpPL0ESDATcGoHPWMkj9X$xN+RRAOgchcqadbgnktz+vWNtVnxKqPKH3LgCFExqGc=', NULL, FALSE, 'STD7409', 'makena', 'student7409@example.com', FALSE, TRUE, '2026-01-14 04:55:36.846488', 'Patience'),
  (873, 'pbkdf2_sha256$1000000$ZyqcYAbq5WMsHHRgSQ62du$MmHF16YPhBZkR0/tXPk6bT+lMBwkP7fzF1JaQyMDGj4=', NULL, FALSE, 'STD7351', 'wayua', 'student7351@example.com', FALSE, TRUE, '2026-01-14 04:55:38.550083', 'Abigael'),
  (874, 'pbkdf2_sha256$1000000$uokbwqecSxg3hw2OZTYEAi$J8/P4gHXCze+J0almlPgxlGyH2/TklCErkoEYy2ULOo=', NULL, FALSE, 'STD7330', 'wanjiku', 'student7330@example.com', FALSE, TRUE, '2026-01-14 04:55:40.005505', 'Belina'),
  (875, 'pbkdf2_sha256$1000000$UKeF2oOd0jFwcWQkIhAf8S$RjV06+2Pjy0Q27HL0jkzoOd5lhJKRSirz2dq1zvx3S8=', NULL, FALSE, 'STD7543', 'ray', 'student7543@example.com', FALSE, TRUE, '2026-01-14 04:55:41.591364', 'Darrel'),
  (876, 'pbkdf2_sha256$1000000$aq1QGxoXFv7zke68gDUhfr$BAwoXe7Yj2r44cz3OBaHwxWMglS96MO4igWe3H4UlRo=', NULL, FALSE, 'STD7347', 'munene', 'student7347@example.com', FALSE, TRUE, '2026-01-14 04:55:43.248861', 'Sebastian'),
  (877, 'pbkdf2_sha256$1000000$g980cOg9bjnafZrRk9hzlk$Te66mMpU8ZzRiNxafywOJMTHOQ1kxVx7RlXsZBDYpFg=', NULL, FALSE, 'STD7581', 'francis', 'student7581@example.com', FALSE, TRUE, '2026-01-14 04:55:44.622136', 'Ryker'),
  (878, 'pbkdf2_sha256$1000000$vN9aAmumNQbaVNm7t0qwvR$DRzuau1etIf+60FdsxGvBSAEtJDAsGGbdLbzrKB5luE=', NULL, FALSE, 'STD7574', 'sanaipei', 'student7574@example.com', FALSE, TRUE, '2026-01-14 04:55:46.198530', 'Chloe'),
  (879, 'pbkdf2_sha256$1000000$aU5KrYZgxQuQyhtbtzzetC$JOcepbysOrOal9rkx/x1W477WuJutkuH2YpuvxNqejk=', NULL, FALSE, 'STD7440', 'mwirigi', 'student7440@example.com', FALSE, TRUE, '2026-01-14 04:55:47.749968', 'Nathan'),
  (880, 'pbkdf2_sha256$1000000$Wz10Qn5fiZq2Bi1tf40tRN$uvL0thVJBSwrjIE/StfugQGQ2ZxJZSUFyKZX948ds8w=', NULL, FALSE, 'STD7452', 'mbuthia', 'student7452@example.com', FALSE, TRUE, '2026-01-14 04:55:49.152986', 'Jayden'),
  (881, 'pbkdf2_sha256$1000000$8Lyti6tPpi5M9KepjlOkRx$5GTx5YtIvor4RMxM0TbDovcsJDmOFssWf9NwqThxFO0=', NULL, FALSE, 'STD7424', 'katilo', 'student7424@example.com', FALSE, TRUE, '2026-01-14 04:55:51.074422', 'Shanell'),
  (882, 'pbkdf2_sha256$1000000$MSDFwpM7VmN3IQRQVNMd0K$E7vLXy7nP3uV6XjF4a2UkyViC8YtmYWAOcCK9Jbbqtc=', NULL, FALSE, 'STD7572', 'kerubo', 'student7572@example.com', FALSE, TRUE, '2026-01-14 04:55:52.644503', 'Louisa'),
  (883, 'pbkdf2_sha256$1000000$XZKo0uhAYFLwuLZ7Qyfort$FQfr253CQ9tDKbcbajQWxotdQUevG/3droDl8m/I1Ls=', NULL, FALSE, 'STD7582', 'macharia', 'student7582@example.com', FALSE, TRUE, '2026-01-14 04:55:54.031344', 'Victor'),
  (884, 'pbkdf2_sha256$1000000$mKEaKBNz5UtalxyX0B0j4O$pPB8wg0+pSK75PTVcrotBvMuoyC5aIjHY7VaHAMNVkc=', NULL, FALSE, 'STD7363', 'prince', 'student7363@example.com', FALSE, TRUE, '2026-01-14 04:55:55.645896', 'Roy'),
  (885, 'pbkdf2_sha256$1000000$yso74CRRJ6YhtURajhlPoY$lVO7/LCRaysURYa9BAcnsl9ItopwY91lAVBXoPcgjNQ=', NULL, FALSE, 'STD7377', 'nyaata', 'student7377@example.com', FALSE, TRUE, '2026-01-14 04:55:57.278688', 'Adrian'),
  (886, 'pbkdf2_sha256$1000000$UOxnw8RWV3YW0QabpFh6MT$bq7w079EXpnUf9zZoklCpElQo71NVbMTgSXiUzFC4u0=', NULL, FALSE, 'STD7408', 'Githinji', 'student7408@example.com', FALSE, TRUE, '2026-01-14 04:55:58.665236', 'Jayden'),
  (887, 'pbkdf2_sha256$1000000$2OWo8jgRZcwYe8R3Ohsp3n$IeBxOviSFBuccT7mv4n1Gc3y18uDLnFP7iWbHEevbD0=', NULL, FALSE, 'STD7226', 'onsando', 'student7226@example.com', FALSE, TRUE, '2026-01-14 04:56:00.270282', 'Dazzel'),
  (888, 'pbkdf2_sha256$1000000$dVOa8oLzzVA9slkGuJ2Bec$jSqCBJKNm1dUl6tR2t5vT8ppvIT31ayyYzoCIt30r0I=', NULL, FALSE, 'STD7426', 'mukolwe', 'student7426@example.com', FALSE, TRUE, '2026-01-14 04:56:01.820354', 'Galvin'),
  (889, 'pbkdf2_sha256$1000000$yCSN3fxdIgODTxLovkq4mZ$AcUHljZ9h+GgW4Wbd99Gp2nt2c5WFdnsu2FwF2SfCk8=', NULL, FALSE, 'STD7311', 'thuranira', 'student7311@example.com', FALSE, TRUE, '2026-01-14 04:56:03.175300', 'Jayden'),
  (890, 'pbkdf2_sha256$1000000$4T8HifevrlwR6J7nu64lfD$LhS1UK1q0Ubq0qz9dLID7zUiVLqsXNT/FE2a7XqlN1M=', NULL, FALSE, 'STD7331', 'mweti', 'student7331@example.com', FALSE, TRUE, '2026-01-14 04:56:04.718601', 'Elvis'),
  (891, 'pbkdf2_sha256$1000000$GfgoD9MSZ0sEMKOypML6yq$cNW0TqoQVwz4izHKzwZ7WQ/+FR+6gt1jD+e2jNqjFSo=', NULL, FALSE, 'STD7304', 'kioko', 'student7304@example.com', FALSE, TRUE, '2026-01-14 04:56:06.472186', 'Alvin'),
  (892, 'pbkdf2_sha256$1000000$RURAR9qwsEwEvpOEgw2LDB$yolbN1M7Q+JDUMEROKSwLuRVp9oonO1n8AM5sVWYggI=', NULL, FALSE, 'STD7399', 'nerian', 'student7399@example.com', FALSE, TRUE, '2026-01-14 04:56:08.408232', 'Adrick'),
  (893, 'pbkdf2_sha256$1000000$Qz1UIlOmrjk1yHLuwLVLOH$aHtM2BsEPoCukeRwpkDab+tBmeo8bnvO21kNBpasmaU=', NULL, FALSE, 'STD7371', 'muthini', 'student7371@example.com', FALSE, TRUE, '2026-01-14 04:56:10.398378', 'Leroy'),
  (894, 'pbkdf2_sha256$1000000$Mm0WUanZShGtDdFWS0GgSD$WddY5kFyGngO1AW2VH6SaCJIJtEnLsO7lehUokbCvYY=', NULL, FALSE, 'STD7332', 'kabogo', 'student7332@example.com', FALSE, TRUE, '2026-01-14 04:56:12.091920', 'Myles'),
  (895, 'pbkdf2_sha256$1000000$FtVhRpAeIgpY3egoYOz5D6$BfamnHNKFGPXEBQyWeJaIMp/c9HzE7Ry37hjheIdy5M=', NULL, FALSE, 'STD7389', 'baraka', 'student7389@example.com', FALSE, TRUE, '2026-01-14 04:56:14.678123', 'Psalmist'),
  (896, 'pbkdf2_sha256$1000000$Dve0laMq1vsWRpfpjISoOD$bTwCO8tAWoQ8MKie7CNAR0Und3ZbFz90N2qKmg0RoEY=', NULL, FALSE, 'STD7401', 'chege', 'student7401@example.com', FALSE, TRUE, '2026-01-14 04:56:16.880905', 'Sebastian'),
  (897, 'pbkdf2_sha256$1000000$R4eMPiXfQoatv5fGrODAPV$TXa7icp3j5oKbkTbKMoZhl9Y8+rbmUVZfpCK931GYh4=', NULL, FALSE, 'STD7419', 'mbaru', 'student7419@example.com', FALSE, TRUE, '2026-01-14 04:56:18.583287', 'Samuel'),
  (898, 'pbkdf2_sha256$1000000$tWXaSb91ClDa9y5hUQiWWo$huAhuWd1honbSitO/JGuoRaAjphsQgkUWjx/KZJ56dY=', NULL, FALSE, 'STD7569', 'mwangi', 'student7569@example.com', FALSE, TRUE, '2026-01-14 04:56:20.787574', 'Nash'),
  (899, 'pbkdf2_sha256$1000000$uNpJ5pDaOE4Qha4MWduafI$Y+4jsz5gfyXYXoD1pvYrHl3yHuRae95n/WpiibL9XdE=', NULL, FALSE, 'STD7569_2', 'mwangi', 'student7569_2@example.com', FALSE, TRUE, '2026-01-14 04:56:22.452232', 'Nash'),
  (900, 'pbkdf2_sha256$1000000$BegGxP69sLHUXLYJnLlY1V$6Dcj7U7S+nV1e+BAAOlG2mrMJ+oW+17QiwsMgfwWHBw=', NULL, FALSE, 'STD7312', 'kamau', 'student7312@example.com', FALSE, TRUE, '2026-01-14 04:56:24.259347', 'Liam'),
  (901, 'pbkdf2_sha256$1000000$8ejgd6wFKm7L5R9nUaK7rx$spyTmN6xdVtypQ8eidYnPctm8eDAF0k+S0rwkJXYzGM=', NULL, FALSE, 'STD7454', 'baraka', 'student7454@example.com', FALSE, TRUE, '2026-01-14 04:56:25.994575', 'Leon'),
  (902, 'pbkdf2_sha256$1000000$0w2H5PHOiApdHuD90M6dLC$LEboO+6ujU3Yd1Sd92awloUW5do/AvFunKD5ZXVecZg=', NULL, FALSE, 'STD7411', 'musili', 'student7411@example.com', FALSE, TRUE, '2026-01-14 04:56:27.671643', 'Alvin'),
  (903, 'pbkdf2_sha256$1000000$FBoQBCvUlT6GPfIZAA9ytc$WYzXIlmPd5b89Y1eoXeY9O9Nyl7kjlXlp4OGEHkVCys=', NULL, FALSE, 'STD7471', 'taji', 'student7471@example.com', FALSE, TRUE, '2026-01-14 04:56:29.117646', 'Myles'),
  (904, 'pbkdf2_sha256$1000000$wj11YfzubgtS9uC6VDjIj0$im6fxTJ4Xwa0t6a1i+olRYhY6dW9u9U8t7JUOm/320s=', NULL, FALSE, 'STD7589', 'Margaret', 'student7589@example.com', FALSE, TRUE, '2026-01-14 04:56:30.707694', 'Nadia'),
  (905, 'pbkdf2_sha256$1000000$ZIlQswFoDGbnB54iHfYTga$OotuheJP2/zpQws+C+rIakjlozZ2Ho071AiM7IzwGDQ=', NULL, FALSE, 'STD7402', 'wanjiru', 'student7402@example.com', FALSE, TRUE, '2026-01-14 04:56:32.356403', 'Eunice'),
  (906, 'pbkdf2_sha256$1000000$0RYmdjV8yAixkVc0IT7xeZ$xA1iJaO+OUWHERu2gPG5zyGoiLmudHUixQuCRHOO5n8=', NULL, FALSE, 'STD7414', 'Reene njeri', 'student7414@example.com', FALSE, TRUE, '2026-01-14 04:56:33.712461', 'Taisha'),
  (907, 'pbkdf2_sha256$1000000$FHDaZbrgFOLFp9upldfDxw$AhcTbGCY9EHFZ2RWASjYyuVWhEVYvRZAxMd67MuHRD8=', NULL, FALSE, 'STD7356', 'wacera', 'student7356@example.com', FALSE, TRUE, '2026-01-14 04:56:35.298861', 'Maryann'),
  (908, 'pbkdf2_sha256$1000000$H69kvR9J9fShzPCLteOxKJ$CNaFPA1uYOhJJIAibPN0bneSIQL+ZA567OFwa18ySmg=', NULL, FALSE, 'STD7430', 'njeri', 'student7430@example.com', FALSE, TRUE, '2026-01-14 04:56:36.842705', 'Shirleen'),
  (909, 'pbkdf2_sha256$1000000$WYUZH5BdZTbgitqshV2Vc4$NJ+Mh9424bgtmW1CRKdB5PuGSVySGq24VHDDxIyGCVo=', NULL, FALSE, 'STD7320', 'moraa', 'student7320@example.com', FALSE, TRUE, '2026-01-14 04:56:38.362481', 'Sharon'),
  (910, 'pbkdf2_sha256$1000000$iFMwF1a33XsnDrbAVixGHm$iHM5S6KlyqBKy5ONWVAmKo28hDKNbWSPs0uaAXmcoxg=', NULL, FALSE, 'STD7559', 'chelegat', 'student7559@example.com', FALSE, TRUE, '2026-01-14 04:56:40.158272', 'Princess'),
  (911, 'pbkdf2_sha256$1000000$RJGoOZoesfEUFSXLN2pWYi$3kQm2TV1bfrROd0jodXpIUArpA5z5HSvibzzQ8YcyKk=', NULL, FALSE, 'STD7447', 'nyambura', 'student7447@example.com', FALSE, TRUE, '2026-01-14 04:56:42.086547', 'Princess'),
  (912, 'pbkdf2_sha256$1000000$tOLOgk4QY4IWctoNukuouJ$Z+QNXZbyO0unP4NExyEEov2e3+dJagwd2oxk13q1VtA=', NULL, FALSE, 'STD7447_2', 'nyambura', 'student7447_2@example.com', FALSE, TRUE, '2026-01-14 04:56:43.926323', 'Blessing'),
  (913, 'pbkdf2_sha256$1000000$MA7VEk9d72fanigtr27X6I$3TzckgBjlFMfJMME6axqx1hUtiDUuPJXEiFSOW2fZTA=', NULL, FALSE, 'STD7477', 'mutheu', 'student7477@example.com', FALSE, TRUE, '2026-01-14 04:56:45.689432', 'Prudence'),
  (914, 'pbkdf2_sha256$1000000$zW6BLlHks8YMN3lw05qBsh$5HWhXTtpoG/JCpa9ZRGTlBiz+iqAz9NbMFvU2kE/Bbo=', NULL, FALSE, 'STD7380', 'makena', 'student7380@example.com', FALSE, TRUE, '2026-01-14 04:56:47.365864', 'Varelie'),
  (915, 'pbkdf2_sha256$1000000$1FOMC7Lf7jLOT1mgE2eNUz$sZT0fPZoTXEZmxq4LdK3sFS4jNolTkhIma4cJW1sfbg=', NULL, FALSE, 'STD7405', 'mutheu', 'student7405@example.com', FALSE, TRUE, '2026-01-14 04:56:48.739474', 'Grace'),
  (916, 'pbkdf2_sha256$1000000$iaDi4cPfMlAzsKmDPgKBKP$v5bNRNday3dKKKzTB/TekrDVeF3ONnOnWBgR6RSIE9A=', NULL, FALSE, 'STD7378', 'kirathi', 'student7378@example.com', FALSE, TRUE, '2026-01-14 04:56:50.507018', 'Andy'),
  (917, 'pbkdf2_sha256$1000000$5RPW7VkzJWErouMc5Sh11W$nFaKkxNUuRJLvTUT9R/A6S1UjjAY1oyHMKqbPJ7bezs=', NULL, FALSE, 'STD7565', 'waiti', 'student7565@example.com', FALSE, TRUE, '2026-01-14 04:56:52.191842', 'Levis'),
  (918, 'pbkdf2_sha256$1000000$suQqqnWRitAVLpVogrX1Ix$geexsaF2crGM+mv6D1aGWAl7mqlQTnf1wLT2T3GlKaU=', NULL, FALSE, 'STD7554', 'muuo', 'student7554@example.com', FALSE, TRUE, '2026-01-14 04:56:53.825206', 'Caleb'),
  (919, 'pbkdf2_sha256$1000000$XMTPUDjNR3zN5cHUGFqboA$ypRygTPyae2x3aNa3aJOaSm/cNPW6aiSaVYVs9It6So=', NULL, FALSE, 'STD7355', 'myles', 'student7355@example.com', FALSE, TRUE, '2026-01-14 04:56:55.500362', 'John'),
  (920, 'pbkdf2_sha256$1000000$DGK8VnWNpvx76MjC0cuUV1$EyPmqQiwuKiAouCC6Y1KvxGn/DNdGAN6/mzutrpwjSc=', NULL, FALSE, 'STD7313', 'zion', 'student7313@example.com', FALSE, TRUE, '2026-01-14 04:56:57.290857', 'Mike'),
  (921, 'pbkdf2_sha256$1000000$PnkTuGEvQX0f9wu1mwB7vw$U40b+1fu7EcgJkEn+yroWsEsjQFKSaenpcWxtnt8HnA=', NULL, FALSE, 'STD7372', 'baraka', 'student7372@example.com', FALSE, TRUE, '2026-01-14 04:56:59.252184', 'Jayden'),
  (922, 'pbkdf2_sha256$1000000$maJfbPL9ftmkZuPjBNryzk$iY1WeqlGJrZ1vMsn7ufLcTCtmwEvVbPZ9rvNxrW9BmE=', NULL, FALSE, 'STD7547', 'kamande', 'student7547@example.com', FALSE, TRUE, '2026-01-14 04:57:00.849702', 'Luiz'),
  (923, 'pbkdf2_sha256$1000000$qUrnE0qEYPiyLofBsyHijp$JlU+pTHZy7YYiaUrl7L0qsEEvvaKbdlnWSkE/DoExT0=', NULL, FALSE, 'STD7382', 'Richard', 'student7382@example.com', FALSE, TRUE, '2026-01-14 04:57:02.483904', 'Keith'),
  (924, 'pbkdf2_sha256$1000000$3SrVQuwtzkhH3a2qXKSy3J$7J5gjMGwNQwanReC09to0E/vIfe2Jh6KG8Un5JAxLJA=', NULL, FALSE, 'STD7326', 'irungu', 'student7326@example.com', FALSE, TRUE, '2026-01-14 04:57:03.937536', 'Samuel'),
  (925, 'pbkdf2_sha256$1000000$twErdps108MRsr3Dt4UPVK$OMhr3JPHG1WWxUckQf2IYI6wbSzJDzzXbleklwg1064=', NULL, FALSE, 'STD7439', 'nuthu', 'student7439@example.com', FALSE, TRUE, '2026-01-14 04:57:05.540202', 'Brayden'),
  (926, 'pbkdf2_sha256$1000000$3bqPmVbzKNAywIx96oR3Xe$ZVamjCXDcPoevKkID4v9NNjSuLbpuzoQQa52wqel1Es=', NULL, FALSE, 'STD7381', 'muturi', 'student7381@example.com', FALSE, TRUE, '2026-01-14 04:57:07.136650', 'Jayden'),
  (927, 'pbkdf2_sha256$1000000$EFAOBWkox3MuEdwBBBP18B$Bk0xesgjTy/q3U6ehoLbTK1247OFtyTtKSKJk5MB+tk=', NULL, FALSE, 'STD7448', 'mwangi', 'student7448@example.com', FALSE, TRUE, '2026-01-14 04:57:08.590687', 'Liam'),
  (928, 'pbkdf2_sha256$1000000$Ojd2lr5IAUvAAnJHzhdhCx$hV3tGTb0KhDGEoIgPWs3czPg1NEePPEfj5vzRIY6U4k=', NULL, FALSE, 'STD7448_2', 'mwangi', 'student7448_2@example.com', FALSE, TRUE, '2026-01-14 04:57:10.126538', 'Liam'),
  (929, 'pbkdf2_sha256$1000000$xuX3WBHHbsdqHffIqwYwj2$UPEZuc2S2F7lU6cIlw++Zb1Wkee+sjs61MsrZUD78HU=', NULL, FALSE, 'STD7528', 'wanjiru', 'student7528@example.com', FALSE, TRUE, '2026-01-14 04:57:12.079723', 'Shannah'),
  (930, 'pbkdf2_sha256$1000000$Awfu7unhKRzuNVOHy2TSOV$OYwPxKx/RM53NMhdHjUZLwIV4baqBi2mOODRP3Kr7Ug=', NULL, FALSE, 'STD7359', 'wamuhu', 'student7359@example.com', FALSE, TRUE, '2026-01-14 04:57:13.938728', 'Mercy'),
  (931, 'pbkdf2_sha256$1000000$wAlQvQ3kU2JiWmpp4pSzLW$I0ZtsIT95ZufjTcX0RDkg/7ktyPxeDOA9LGyQ44okB0=', NULL, FALSE, 'STD7358', 'murugi', 'student7358@example.com', FALSE, TRUE, '2026-01-14 04:57:15.808469', 'Shanell'),
  (932, 'pbkdf2_sha256$1000000$AmymZTQTJ8Tw2nCIzoUOKy$3vn4IKLGKkRl7zl+byIbP+xdfWQWjwp79OWIhbl0rP4=', NULL, FALSE, 'STD7578', 'rukia', 'student7578@example.com', FALSE, TRUE, '2026-01-14 04:57:17.359394', 'Latifa'),
  (933, 'pbkdf2_sha256$1000000$Ylvr1cG2w1kqoU6mb8hqCs$vWC4TrMRODoPHqdvs+QmDTnp00+2msFyfgIqcbudH5s=', NULL, FALSE, 'STD7563', 'favor', 'student7563@example.com', FALSE, TRUE, '2026-01-14 04:57:18.829471', 'Silver'),
  (934, 'pbkdf2_sha256$1000000$h0PMSEGxjtIJTLMZxvSl45$/GP1sprnxOZamQVwy/7xa0VKzItJghuPghwRGeQ7mUk=', NULL, FALSE, 'STD7453', 'bonareri', 'student7453@example.com', FALSE, TRUE, '2026-01-14 04:57:20.498874', 'Adah'),
  (935, 'pbkdf2_sha256$1000000$NZedHltBPyOuc8t0MDu8mj$b8uCQcfuIWoidVtozwvcOkBTAp9A/6NVHS4EWVV3ED4=', NULL, FALSE, 'STD7539', 'G Richard', 'student7539@example.com', FALSE, TRUE, '2026-01-14 04:57:22.109958', 'Whitney'),
  (936, 'pbkdf2_sha256$1000000$C7TY1FaxWJegAhhTVyrqhM$wkdLdz9YMAzb1Te1JJdkRTtnbRikW5vSZOMiZEYDKPw=', NULL, FALSE, 'STD7573', 'nyambura', 'student7573@example.com', FALSE, TRUE, '2026-01-14 04:57:23.546465', 'Yazmin'),
  (937, 'pbkdf2_sha256$1000000$qoHvcm8lGKFPJUKCanRObu$8Hq1L7J9HC08/XuYEtvbj6Gfdn7fMi2hw6+BicvhkSg=', NULL, FALSE, 'STD7314', 'Wambui', 'student7314@example.com', FALSE, TRUE, '2026-01-14 04:57:25.290922', 'Queenshi'),
  (938, 'pbkdf2_sha256$1000000$WNqoc8vLN3CZBZb3a1P27j$h4wKx7/Jd/LICNfCHa9f1Ujh3bjM/J8lIh6pM+vNgB4=', NULL, FALSE, 'STD7376', 'wanjiku', 'student7376@example.com', FALSE, TRUE, '2026-01-14 04:57:26.892388', 'Chloe'),
  (939, 'pbkdf2_sha256$1000000$YDZ4IrQvVUNHPhsEZZWICc$naDU4K7C/vNnRR1Pmfn4Q0lrC0oQQNCzfWq1K05Csjc=', NULL, FALSE, 'STD7494', 'Nkatha', 'student7494@example.com', FALSE, TRUE, '2026-01-14 04:57:28.297227', 'Magdalene'),
  (940, 'pbkdf2_sha256$1000000$Nl3fddEmWClyOOpm0BkQNC$V8Ha7cYZSbsDPMNJ7puGDaH91VOvdR0KMIHDoapehx0=', NULL, FALSE, 'STD7620', 'nyakerario', 'student7620@example.com', FALSE, TRUE, '2026-01-14 04:57:29.868625', 'Mary'),
  (941, 'pbkdf2_sha256$1000000$c3f0z31b7xVz40Modv5EMs$eWkmBXplhKWzjQLWxSBu4N9hiCg/h/uWH2W/JgXDd60=', NULL, FALSE, 'STD7334', 'mwende', 'student7334@example.com', FALSE, TRUE, '2026-01-14 04:57:31.583738', 'Precious'),
  (942, 'pbkdf2_sha256$1000000$2uQkZILg4JWsL2yzSvNC1S$92eMGyLjtAnhMnUa+IItqLy4kyDxdxRYxfckS4soTbs=', NULL, FALSE, 'STD7321', 'ndanu', 'student7321@example.com', FALSE, TRUE, '2026-01-14 04:57:32.986591', 'Natalia'),
  (943, 'pbkdf2_sha256$1000000$qEA77cnWAYMAGBVXtDPNEP$aV54CYKw2BsLGVGvr5xS5/cy7KGSTmDrR0loaN9VvAo=', NULL, FALSE, 'STD7305', 'wambui', 'student7305@example.com', FALSE, TRUE, '2026-01-14 04:57:34.594757', 'Tracey'),
  (944, 'pbkdf2_sha256$1000000$Pta0PEsawYpAipqwJhLgQE$3ttKT3urv/k6RC1fGbNNdTToOUB9QOejiA29tCLhHmU=', NULL, FALSE, 'STD7511', 'nekesa', 'student7511@example.com', FALSE, TRUE, '2026-01-14 04:57:36.193068', 'Claire'),
  (945, 'pbkdf2_sha256$1000000$SDe1EpuS4Z1iHbAZIh3o0G$467g0Yh7LxxC37k46iwc1TF9ZICNKW/B1Udf9CmxFfU=', NULL, FALSE, 'STD7360', 'wanjiku', 'student7360@example.com', FALSE, TRUE, '2026-01-14 04:57:37.563620', 'Maryann'),
  (946, 'pbkdf2_sha256$1000000$3J4QkUf38CPVQNQpJ9oOKa$m/gs+RQbmrto0bBwD0bcmUV+zGlaBTDxAKLxXO86WV0=', NULL, FALSE, 'STD7611', 'kavoki', 'student7611@example.com', FALSE, TRUE, '2026-01-14 04:57:39.183385', 'Brilliantine'),
  (947, 'pbkdf2_sha256$1000000$zJ0YdWte2jZtCy1qMoZdDP$YmzL5Xrm9JNUYWzmHOhqIBzGoLkvlA5Sr1saFqe3tkY=', NULL, FALSE, 'STD7551', 'muindi', 'student7551@example.com', FALSE, TRUE, '2026-01-14 04:57:40.878607', 'Henry'),
  (948, 'pbkdf2_sha256$1000000$5Ftt3Ri1kTtsbGUvcFPomH$lsn954vIQBZc7krRgPV9T+wni98WDJcrVO3JJFWr+3U=', NULL, FALSE, 'STD7443', 'zawadi', 'student7443@example.com', FALSE, TRUE, '2026-01-14 04:57:42.956955', 'Miriam'),
  (949, 'pbkdf2_sha256$1000000$Qd5qASmvlQIVst0dkpenca$ndV3IC5fJmQZvj24Lx1rSodg8tSI/YB7yONwpswvtns=', NULL, FALSE, 'STD7432', 'njeri', 'student7432@example.com', FALSE, TRUE, '2026-01-14 04:57:44.593416', 'Abigeal'),
  (950, 'pbkdf2_sha256$1000000$HhfIqzUZEHJpUmaDMhgJ1a$3Oo5Qj2CsRq+pI9WVZUhUU5svJG+6kKJa6qTQaFfx6Q=', NULL, FALSE, 'STD7397', 'kirira', 'student7397@example.com', FALSE, TRUE, '2026-01-14 04:57:45.991008', 'Briton'),
  (951, 'pbkdf2_sha256$1000000$rCdP6jxm0FqZJ9d6sJQux0$R+dhboprv/a1ZhlXRogDPFtQZfOjk+++QQ/4IT1ORzg=', NULL, FALSE, 'STD7293', 'Waithira', 'student7293@example.com', FALSE, TRUE, '2026-01-14 04:57:47.682269', 'Ann'),
  (952, 'pbkdf2_sha256$1000000$9kkTwbbWWrjBuoRlLAK8bG$HA16S2TANV1qpBJUDTpn7GaFNpyROuqbSDwXFciqnEQ=', NULL, FALSE, 'STD7221', 'wanjiku', 'student7221@example.com', FALSE, TRUE, '2026-01-14 04:57:49.280601', 'Beth'),
  (953, 'pbkdf2_sha256$1000000$Yis80sEIYftwlDJNXs37Xe$fyqOHSMik5+0oVDumgV3NezCwuB2TITLSq64R3z2MqI=', NULL, FALSE, 'STD7475', 'samuel', 'student7475@example.com', FALSE, TRUE, '2026-01-14 04:57:50.699578', 'Blessed'),
  (954, 'pbkdf2_sha256$1000000$mCTXavcykLz10qdPC967ea$jgM87eQ/0HM3SM0llgRYKmYdjiS3MkJDS0by013+yDg=', NULL, FALSE, 'STD7564', 'ngugi', 'student7564@example.com', FALSE, TRUE, '2026-01-14 04:57:52.311538', 'Melvin'),
  (955, 'pbkdf2_sha256$1000000$KNZiEi2Jai3vwG7hsRYGu4$RdAfbs99JkTVagmUoFr9hn1cxtwyE/FBlhyiM45lFmI=', NULL, FALSE, 'STD7247', 'muteti', 'student7247@example.com', FALSE, TRUE, '2026-01-14 04:57:53.933240', 'Victor'),
  (956, 'pbkdf2_sha256$1000000$djPsRwF6q6dNlecbZxNqPT$JDAnwoI6X2uy98S/12zu7F0sn/pTcXS5kyUTZQDJAmg=', NULL, FALSE, 'STD7193', 'mboche', 'student7193@example.com', FALSE, TRUE, '2026-01-14 04:57:55.372007', 'Simon'),
  (957, 'pbkdf2_sha256$1000000$DxhA3lvEShU34HVd8oFrzG$NumbJPe3TSEeu7etpxurjL0J1qy93r974DJCZV21csg=', NULL, FALSE, 'STD7268', 'maina', 'student7268@example.com', FALSE, TRUE, '2026-01-14 04:57:56.954471', 'Gyan'),
  (958, 'pbkdf2_sha256$1000000$uJ8rK8DSMgQybwL9RmyPN9$GPywlaxTlmGvGnKHSeAWKqES3NKotAFKnYjHQ4av498=', NULL, FALSE, 'STD7520', 'otanga', 'student7520@example.com', FALSE, TRUE, '2026-01-14 04:57:58.773745', 'Bryson'),
  (959, 'pbkdf2_sha256$1000000$D8W9rU6R3fQ3Jw31OAel8h$du+LDFVPWtN/UxM3/8HUmki3J+uO5I/79tM4RoRB0Fc=', NULL, FALSE, 'STD7437', 'bahati', 'student7437@example.com', FALSE, TRUE, '2026-01-14 04:58:00.222417', 'Haysen'),
  (960, 'pbkdf2_sha256$1000000$KJs7tyv6xY1I2pshVZhJ1a$TodlYYYJNxLQRmRcMNd5aJ82K1v0d2SLVIAa6UKTOXQ=', NULL, FALSE, 'STD7256', 'kingori', 'student7256@example.com', FALSE, TRUE, '2026-01-14 04:58:01.814131', 'Elvis'),
  (961, 'pbkdf2_sha256$1000000$EEsqART5sWhgHk467P3Azt$w+8jgeV9l093Q04i+vOvhsl7gPh3mCHC/tV0kKTEv4s=', NULL, FALSE, 'STD7233', 'wafula', 'student7233@example.com', FALSE, TRUE, '2026-01-14 04:58:03.541163', 'Dylan'),
  (962, 'pbkdf2_sha256$1000000$qcPjUJT79vYQORK4gy6Lf8$tYyjJSTnqJmGg1mdBQicaD0GITm7SKFphwHmXhiAfXM=', NULL, FALSE, 'STD7211', 'wambugu', 'student7211@example.com', FALSE, TRUE, '2026-01-14 04:58:04.947496', 'Ryan'),
  (963, 'pbkdf2_sha256$1000000$rzpQPpJIEmGfW0OtLCwldn$GUmrpqQS83+/Xfz25XaQCzH3gy4uuwq7a+JBD0XkL+8=', NULL, FALSE, 'STD7548', 'kyan jabulani', 'student7548@example.com', FALSE, TRUE, '2026-01-14 04:58:06.537552', 'Ray')
ON CONFLICT DO NOTHING;
INSERT INTO "auth_user" ("id", "password", "last_login", "is_superuser", "username", "last_name", "email", "is_staff", "is_active", "date_joined", "first_name") VALUES
  (964, 'pbkdf2_sha256$1000000$DEmL39bHHk5RQXHlDhGwFC$fiFusZB15GoCiin0KiMA+m1CYOgS23fT2MYqZi+SiNs=', NULL, FALSE, 'STD7286', 'njuguna', 'student7286@example.com', FALSE, TRUE, '2026-01-14 04:58:08.155272', 'Liam'),
  (965, 'pbkdf2_sha256$1000000$GM42dWgHFpYKkBwqE9xooZ$WlaZSuheyj4TcNslg5GJbdCUNj9rZTLXPgMoaWiUFvk=', NULL, FALSE, 'STD7222', 'mutua', 'student7222@example.com', FALSE, TRUE, '2026-01-14 04:58:09.598267', 'Liam'),
  (966, 'pbkdf2_sha256$1000000$2rvoANO6O4w1ziwiKgKJGc$NaD+HBDXFbcI1wEWEmcXkuiiK1+b+xTG2wrpV5gMOdA=', NULL, FALSE, 'STD7267', 'musyimi', 'student7267@example.com', FALSE, TRUE, '2026-01-14 04:58:11.207749', 'Brandon'),
  (967, 'pbkdf2_sha256$1000000$Xloee18v3LikpekC5pi3m1$NA986Vz+US6L91sSiPAA/fFPYabUdybQbAilrhxBKac=', NULL, FALSE, 'STD7206', 'ogola', 'student7206@example.com', FALSE, TRUE, '2026-01-14 04:58:13.015628', 'John'),
  (968, 'pbkdf2_sha256$1000000$bRlwzF8bbDITBNugNf9bHG$dsW2Idk8ZZSdqLp/xWrs587DKGrmlESBEc/nVUjwUT8=', NULL, FALSE, 'STD7481', 'mwihaki', 'student7481@example.com', FALSE, TRUE, '2026-01-14 04:58:14.471584', 'Rahab'),
  (969, 'pbkdf2_sha256$1000000$fGIk7oLkBW3wherE851dxf$CCeK2egARsJQY5Q6JhuxtpZaFVvIh1qiHd3wJm6zbCs=', NULL, FALSE, 'STD7486', 'Waithira', 'student7486@example.com', FALSE, TRUE, '2026-01-14 04:58:16.067837', 'Susan'),
  (970, 'pbkdf2_sha256$1000000$DGYMZoIuwu3gyxqfiDcOim$cp6O0yhsApg3Hs+S8vJ03sXKRfDVHNO56g8g+0oQBhg=', NULL, FALSE, 'STD7269', 'nyambura', 'student7269@example.com', FALSE, TRUE, '2026-01-14 04:58:17.692826', 'Kaylee'),
  (971, 'pbkdf2_sha256$1000000$SFPSPNUhdABMYrPkwQ6S1u$eB5HyN93hiSNBo35CHWeDeDk3mGdltHAFINI8UiplCw=', NULL, FALSE, 'STD7415', 'nyawira', 'student7415@example.com', FALSE, TRUE, '2026-01-14 04:58:19.159161', 'Tiffany'),
  (972, 'pbkdf2_sha256$1000000$pD4aagz9f0FcFZBnFMwNFW$MWdI9ybyegpw7VNcOgigccR1wNyDlQE+IK6GM2QtWfU=', NULL, FALSE, 'STD7301', 'aliyah', 'student7301@example.com', FALSE, TRUE, '2026-01-14 04:58:20.716147', 'Natasha'),
  (973, 'pbkdf2_sha256$1000000$heftiienYRZxLp2dtW57Qg$pAZ3t1S6x8G2orLWVYmCMv3leGRUJd2ivlEdC5O6VTg=', NULL, FALSE, 'STD7279', 'wanjiru', 'student7279@example.com', FALSE, TRUE, '2026-01-14 04:58:22.357497', 'Favour'),
  (974, 'pbkdf2_sha256$1000000$8WEasi3RMYEasCvuVI32eZ$hIOOM7besE8yKZa3pBSz2KHVzbnsTytCOGEq/Rh1KTM=', NULL, FALSE, 'STD7277', 'waruiru', 'student7277@example.com', FALSE, TRUE, '2026-01-14 04:58:23.738360', 'Gianna'),
  (975, 'pbkdf2_sha256$1000000$9XFXaQDLcBdccdIjmxZjd4$AgXlbtZmE2TjF0H8otgbIL+FG8bPd0EVuXeI12mI9+o=', NULL, FALSE, 'STD7196', 'zawadi', 'student7196@example.com', FALSE, TRUE, '2026-01-14 04:58:25.520891', 'Ivanna'),
  (976, 'pbkdf2_sha256$1000000$eCtDn0BkA5aNBoRmCBqmoo$Y4z+o6aMQUqgLG1vPDhLlaaZCIlvpMJSKxZJeqH13Vs=', NULL, FALSE, 'STD7244', 'pendo', 'student7244@example.com', FALSE, TRUE, '2026-01-14 04:58:27.064314', 'Jianna'),
  (977, 'pbkdf2_sha256$1000000$uLslQjVCAdOdPx96Bbo4Ad$kzYd7V/FoZBKpAbnSFLhMBnhiWoy4Xl1unynP36B+u0=', NULL, FALSE, 'STD7461', 'kemuma', 'student7461@example.com', FALSE, TRUE, '2026-01-14 04:58:28.497945', 'Brevian'),
  (978, 'pbkdf2_sha256$1000000$pDomAkGdNEOU0WSXfc3SY3$tr5bjs1w7csjAk4pwpnaJJu9O6dZMGagD3TgIkW28Rg=', NULL, FALSE, 'STD7236', 'wanjiku', 'student7236@example.com', FALSE, TRUE, '2026-01-14 04:58:30.203606', 'Neema'),
  (979, 'pbkdf2_sha256$1000000$liWRh70JTfKQqg1VdfOcHW$UAnSG+5XWPbt0eRXIzq030DjaVet7SqNMmk+EWHAcsg=', NULL, FALSE, 'STD7280', 'wanjiru', 'student7280@example.com', FALSE, TRUE, '2026-01-14 04:58:31.808347', 'Joy'),
  (980, 'pbkdf2_sha256$1000000$SgNTgAHF3LGuzXOKHiKkyJ$k2uMKWDASn+s+GcKAgW36kE6+1jm4q5wRFPmKPu+Rnc=', NULL, FALSE, 'STD7077', 'karimi', 'student7077@example.com', FALSE, TRUE, '2026-01-14 04:58:33.218324', 'Blessing'),
  (981, 'pbkdf2_sha256$1000000$AHngSUobihGun7r0OIdv9Z$I30i03nOUEukQ30d1IafzyYqgZvbvVv5CSY2jfygHps=', NULL, FALSE, 'STD7205', 'wanjiru', 'student7205@example.com', FALSE, TRUE, '2026-01-14 04:58:34.924814', 'Blessing'),
  (982, 'pbkdf2_sha256$1000000$80QgNfhBb2wJWHxRrbQMsw$bHy8RS+avMwY8LmMdxGebvIywiuJRdXN0DY3q66Z6D0=', NULL, FALSE, 'STD7404', 'sophia', 'student7404@example.com', FALSE, TRUE, '2026-01-14 04:58:36.567185', 'Princess'),
  (983, 'pbkdf2_sha256$1000000$ebh5iS3lhVrhYZLV3ds96t$xYNkRo5WGcLV7T89suK3KszHjEiruAFOpLByF/chInE=', NULL, FALSE, 'STD7245', 'Wambui', 'student7245@example.com', FALSE, TRUE, '2026-01-14 04:58:37.922608', 'Tamara'),
  (984, 'pbkdf2_sha256$1000000$MVlkBWPczjcyAEAsiov9rx$Lz1vr/PC+84rfeF+PFnL8SHeTVx0V8n4o+LEw162U3Y=', NULL, FALSE, 'STD7223', 'akinyi', 'student7223@example.com', FALSE, TRUE, '2026-01-14 04:58:39.756715', 'Paisley'),
  (985, 'pbkdf2_sha256$1000000$5d4yTdaQ9GIjhIwn6UhODB$3qzGYiBOu9zqVbuni7020MtgKdGl89TcSQQdWZlIZQA=', NULL, FALSE, 'STD7255', 'wambui', 'student7255@example.com', FALSE, TRUE, '2026-01-14 04:58:41.354489', 'Angel'),
  (986, 'pbkdf2_sha256$1000000$CdpWzpJ45wmudTH4wkbNUw$KJyEsxEIBovL9FHXvO5Mb0NpOMDlrNyM0VJ/Y5YOCAg=', NULL, FALSE, 'STD7218', 'Telia', 'student7218@example.com', FALSE, TRUE, '2026-01-14 04:58:43.178259', 'Jewel'),
  (987, 'pbkdf2_sha256$1000000$MMH3Z0xHChRemjFCHUtAe1$G2WfpT0VIq8A2WaZGjpgM2Rk+NP6UmdP6cTDwK5uDgc=', NULL, FALSE, 'STD7252', 'Georgina', 'student7252@example.com', FALSE, TRUE, '2026-01-14 04:58:44.883576', 'Neema'),
  (988, 'pbkdf2_sha256$1000000$cS17FP9shHPkd74YtKXaMQ$20S/PmHEmIiscv7lDJ7wkG0bZoQYh8FxdoDfxmt4ekY=', NULL, FALSE, 'STD7235', 'wamaitha', 'student7235@example.com', FALSE, TRUE, '2026-01-14 04:58:46.476053', 'Angel'),
  (989, 'pbkdf2_sha256$1000000$qMTpGLHZK8OZTkfiVp4GK4$/ObqQnjV3JFbfsOJa8cslZfOEeQlhyPMIeYuqomajRk=', NULL, FALSE, 'STD7215', 'zamar', 'student7215@example.com', FALSE, TRUE, '2026-01-14 04:58:47.865119', 'Olivia'),
  (990, 'pbkdf2_sha256$1000000$RFGj5h3WGipXK3dH2wMw0a$UEZ9SJDm5iBqFpGO4ccLcqvIgLG9N4Ed1DzTNNuEjoc=', NULL, FALSE, 'STD7248', 'Nduku', 'student7248@example.com', FALSE, TRUE, '2026-01-14 04:58:49.433721', 'Natalia'),
  (991, 'pbkdf2_sha256$1000000$0kNjwlogLK0bN6eaxiKf5D$Llh1C2pwDrF7awCq4qQn0Xs9JFNunWgSnQb2qGD7kDc=', NULL, FALSE, 'STD7213', 'Wambui', 'student7213@example.com', FALSE, TRUE, '2026-01-14 04:58:51.245770', 'Cynthia'),
  (992, 'pbkdf2_sha256$1000000$hUckRVq24c9gtMq7UQAuwo$jcA8bU3P2fh+YOGA7NmH8VYiLfqaX22nOxmyVpWLJLQ=', NULL, FALSE, 'STD7336', 'wanjiku', 'student7336@example.com', FALSE, TRUE, '2026-01-14 04:58:52.684759', 'Mitchel'),
  (993, 'pbkdf2_sha256$1000000$hcaEOARNdAmtQep90MniVx$mn/Vcd4rQjscrs4J7aktxujV0HQ6onpEt72nkF82lTI=', NULL, FALSE, 'STD7601', 'Wairimu', 'student7601@example.com', FALSE, TRUE, '2026-01-14 04:58:54.352916', 'Everlyne'),
  (994, 'pbkdf2_sha256$1000000$7xybuC3sBPw2HKApUVSTLw$P0Ce7oiz1honrqCiJ2S80dBmJz8DJlthaCLmlC7uzko=', NULL, FALSE, 'STD7209', 'Wairimu', 'student7209@example.com', FALSE, TRUE, '2026-01-14 04:58:55.904570', 'Shelby'),
  (995, 'pbkdf2_sha256$1000000$C7REBITf8y7te02igpWZR3$T4/ZNrxwrYKYNLfsarZ91Ah0TovfohictiSTmQxmWRA=', NULL, FALSE, 'STD7287', 'wanjiru', 'student7287@example.com', FALSE, TRUE, '2026-01-14 04:58:57.309886', 'Skylar'),
  (996, 'pbkdf2_sha256$1000000$UfDLGvZ1NJePzEQ5PmLMWs$sXeWr7NqBDvUjPPKCjPJSLluK0QjJ+2cVEXLnGplhrw=', NULL, FALSE, 'STD7254', 'makena', 'student7254@example.com', FALSE, TRUE, '2026-01-14 04:58:58.941519', 'Lesley'),
  (997, 'pbkdf2_sha256$1000000$0dDNgcJWczpwZoFBOxFOwO$KILjI0tWAIE0auOvc+3SO9YdRglHDSAzOfJavKy03xE=', NULL, FALSE, 'STD7379', 'nyambura', 'student7379@example.com', FALSE, TRUE, '2026-01-14 04:59:00.522021', 'Abigael'),
  (998, 'pbkdf2_sha256$1000000$rm66UbUAM9Hd7WCpN5U1i0$UnEGzUTgx69t4r0pv5SoDmC1VTPPlf93zMxLyM5VyKE=', NULL, FALSE, 'STD7446', 'Wairimu', 'student7446@example.com', FALSE, TRUE, '2026-01-14 04:59:01.927018', 'Olivia'),
  (999, 'pbkdf2_sha256$1000000$zT8Kz8iSNw8zFaxgRSmBfZ$N1uu3vZnmfEVV6RNy+ySyjlGhbL3mYn0U0EGwVofXqU=', NULL, FALSE, 'STD7450', 'nyakundi', 'student7450@example.com', FALSE, TRUE, '2026-01-14 04:59:03.629448', 'Nash'),
  (1000, 'pbkdf2_sha256$1000000$gQR93v68nqztTRq0vuUoRt$PTLCBXmVfv9sgmjjqglSlgjA7/CMoVQQ2nL7OjDNWYk=', NULL, FALSE, 'STD7249', 'Kanja', 'student7249@example.com', FALSE, TRUE, '2026-01-14 04:59:05.248821', 'Jesse'),
  (1001, 'pbkdf2_sha256$1000000$Oh2LcD8DHoPUdvZ7yOLDtf$UH+mLE8kRWS1JI1Ogzmc6rpo/gGBEFmAk68RiyhLfeE=', NULL, FALSE, 'STD7357', 'Kaaria', 'student7357@example.com', FALSE, TRUE, '2026-01-14 04:59:06.881046', 'Darlington'),
  (1002, 'pbkdf2_sha256$1000000$DUXvy2VqYO9v1DRQdZBKiH$g3cHiLdM/24EsD/eZaEpFtfawS/A3xYKTkcWYianJno=', NULL, FALSE, 'STD7289', 'andega', 'student7289@example.com', FALSE, TRUE, '2026-01-14 04:59:08.607088', 'Clement'),
  (1003, 'pbkdf2_sha256$1000000$QFNBz0P6GPaqGaGFcHEhEc$DuT8KryqFxwo67skJRHOc1ZzdJoX0W07WaF4Tcjo/Vw=', NULL, FALSE, 'STD7260', 'mwangi', 'student7260@example.com', FALSE, TRUE, '2026-01-14 04:59:10.198096', 'Lian'),
  (1004, 'pbkdf2_sha256$1000000$JTgmbbx6jOgjr0orwv8Osj$FHhk5Ykk7iBtUZFRzm3eyqvlyeus2l4Vsc50euiQcWU=', NULL, FALSE, 'STD7232', 'Leon', 'student7232@example.com', FALSE, TRUE, '2026-01-14 04:59:11.648474', 'Richard'),
  (1005, 'pbkdf2_sha256$1000000$XSPxcB7B2WeVZnds24xmfA$k6mozJe4rFM7/Pc1Zth2RKlXSSupRhLjpVenOzm7HFI=', NULL, FALSE, 'STD7300', 'mucheke', 'student7300@example.com', FALSE, TRUE, '2026-01-14 04:59:13.319510', 'Alexander'),
  (1006, 'pbkdf2_sha256$1000000$RsM23T9iT1uf7Fe0ZXyURt$yP8A2oyru+U0+JyUllsKNB/DnccCEmWVhm1XjOF2d6c=', NULL, FALSE, 'STD7238', 'mburu', 'student7238@example.com', FALSE, TRUE, '2026-01-14 04:59:14.933367', 'Timothy'),
  (1007, 'pbkdf2_sha256$1000000$pctz7y5H2zFHO8ja3iRAHR$YjgJQitMc1zMJXvQofuhpIBKnNJKA1cuIq1KNSlOROk=', NULL, FALSE, 'STD7201', 'kamiti', 'student7201@example.com', FALSE, TRUE, '2026-01-14 04:59:16.542295', 'James'),
  (1008, 'pbkdf2_sha256$1000000$ONzhw0WNyCrvXicjknGB3s$QqJso/pah0uR7mqTWdShMyCzcqwGbJMLa67nieC1B9Q=', NULL, FALSE, 'STD7237', 'mwangi', 'student7237@example.com', FALSE, TRUE, '2026-01-14 04:59:18.254772', 'Austin'),
  (1009, 'pbkdf2_sha256$1000000$I8inT0F3UfvY68D8jeLJye$4c/xtsiF6AVrLAPaBPXcTvxH/9HRZI+FUnsidVlX+pI=', NULL, FALSE, 'STD7194', 'chege', 'student7194@example.com', FALSE, TRUE, '2026-01-14 04:59:19.815154', 'Alpha'),
  (1010, 'pbkdf2_sha256$1000000$9v7xQsOZAIBbFk4z5vuAfW$SvwkJxoiBoEOTeoacKYuSYpX3eistOR61bilSgGUIkk=', NULL, FALSE, 'STD7294', 'ndambuki', 'student7294@example.com', FALSE, TRUE, '2026-01-14 04:59:21.370045', 'Victor'),
  (1011, 'pbkdf2_sha256$1000000$SePXPRfe4GvMvQPgJnHqLs$8T0minwxWaNuEU0vq1enMm/Q+t1WAqQKj2K4oyuWkss=', NULL, FALSE, 'STD7229', 'wanjiku', 'student7229@example.com', FALSE, TRUE, '2026-01-14 04:59:23.215377', 'Abigael'),
  (1012, 'pbkdf2_sha256$1000000$dijjIEfhXXDyu8tVPyYorW$yP+jFDaXvVdbKQ18LnNcrZASyvzKovW0IGev6IKUmwo=', NULL, FALSE, 'STD7227', 'nyambura', 'student7227@example.com', FALSE, TRUE, '2026-01-14 04:59:24.771448', 'Teresiah'),
  (1013, 'pbkdf2_sha256$1000000$OWB6YL9ez4qQBsiwtBbnFr$LvKbsHoQVxonRJfBFvpGJyJk/5yDZdvZ2qT9Tp6lgQk=', NULL, FALSE, 'STD7150', 'Wambui', 'student7150@example.com', FALSE, TRUE, '2026-01-14 04:59:26.160920', 'Angeliz'),
  (1014, 'pbkdf2_sha256$1000000$QmcIloOVglds6N6sJxlNO8$EUK7Z8DrVxsoiHJpXdtyFpi3nC1lrJJkk30gkIg9sGo=', NULL, FALSE, 'STD7188', 'keya', 'student7188@example.com', FALSE, TRUE, '2026-01-14 04:59:27.778871', 'Gift'),
  (1015, 'pbkdf2_sha256$1000000$UsqjbNC9cwVOy9xpIrKQnh$LUpKvYkZJajDPQq6+SWNyz+4nSMNH2RXAZVxZaD1+8M=', NULL, FALSE, 'STD7108', 'nyambura', 'student7108@example.com', FALSE, TRUE, '2026-01-14 04:59:29.491905', 'Banice'),
  (1016, 'pbkdf2_sha256$1000000$lpgu0U7184wXRMm61Jz8tO$mdh3u9B8UqxCxaGsNcc+OrVBzAvDzmZ9Z09YozQANpA=', NULL, FALSE, 'STD7176', 'mbithe', 'student7176@example.com', FALSE, TRUE, '2026-01-14 04:59:30.865082', 'Christiana'),
  (1017, 'pbkdf2_sha256$1000000$XVmiXcRz01c55g99P87iSP$dNa43UyVe67zORUAnVhfB0fO52m/sBpckR2zMHl1mVQ=', NULL, FALSE, 'STD7115', 'nderitu', 'student7115@example.com', FALSE, TRUE, '2026-01-14 04:59:32.609429', 'Teddy'),
  (1018, 'pbkdf2_sha256$1000000$XZPDDvrzIWrfwMpP56iH7F$qHLmVFyHYsa7CxA/SIV67CHIwxfneda8JNOwS7pUUy8=', NULL, FALSE, 'STD7428', 'mumo', 'student7428@example.com', FALSE, TRUE, '2026-01-14 04:59:34.282036', 'Elishah'),
  (1019, 'pbkdf2_sha256$1000000$eWxOXHCnIhRwuy3yUqjDou$fP6tloF6CRUbuok2/+v7TzqDLRPI2x1MAnAsRhOqL4Q=', NULL, FALSE, 'STD7586', 'kawayi', 'student7586@example.com', FALSE, TRUE, '2026-01-14 04:59:35.741717', 'Kaylie'),
  (1020, 'pbkdf2_sha256$1000000$uFIajI79RguWcXCqXCZo8N$43kyw8Yg7hwiUootutHk3ezQeFC6WF3JjOccFRgeago=', NULL, FALSE, 'STD7080', 'braham', 'student7080@example.com', FALSE, TRUE, '2026-01-14 04:59:37.391285', 'Billy'),
  (1021, 'pbkdf2_sha256$1000000$hUhU8T4m6XHs032KjDa8Z5$qQn+LL8TCygLPuu4H28wAWpDWmZsvDgJy3IqziEOVxs=', NULL, FALSE, 'STD7183', 'mellisa', 'student7183@example.com', FALSE, TRUE, '2026-01-14 04:59:39.113835', 'Jane'),
  (1022, 'pbkdf2_sha256$1000000$3zZmj8KdpWnyzaE9tbE7ff$K2phYRqvbGo/TRHUlqt3dt4BKhXvIr9xG5PyqMCNwsk=', NULL, FALSE, 'STD7178', 'njoki', 'student7178@example.com', FALSE, TRUE, '2026-01-14 04:59:40.563158', 'Linet'),
  (1023, 'pbkdf2_sha256$1000000$1r4fSjiXTEkofNAdQWo31h$yrxaA3geq0hoAWo/EkMunC0K+RYeRjrpiZFbPN+ukPg=', NULL, FALSE, 'STD7524', 'Riccardo', 'student7524@example.com', FALSE, TRUE, '2026-01-14 04:59:42.576089', 'Richard'),
  (1024, 'pbkdf2_sha256$1000000$7akqwPARskiRuj2E9E1kk3$PYginY/g/M+qdnS2PMJ9Pt8JpgZcMZ7N2ugGsfSu7kQ=', NULL, FALSE, 'STD7493', 'muturo', 'student7493@example.com', FALSE, TRUE, '2026-01-14 04:59:44.327291', 'John'),
  (1025, 'pbkdf2_sha256$1000000$cghgXs1oXp9TiP51w9wPsQ$k8W6qQh5JWWhX8A0VdPjFY1evEkShGXgKXk/FWdATf0=', NULL, FALSE, 'STD7422', 'munyalo', 'student7422@example.com', FALSE, TRUE, '2026-01-14 04:59:45.738852', 'Ryan'),
  (1026, 'pbkdf2_sha256$1000000$6PL0j58l33MuUFUB8KGNSl$qauuCbPluq3s66dAZaxlgXsofxmQrBXRjDZ6pgSogSY=', NULL, FALSE, 'STD7131', 'murangili', 'student7131@example.com', FALSE, TRUE, '2026-01-14 04:59:47.300344', 'Ryan'),
  (1027, 'pbkdf2_sha256$1000000$ZErSJP31EeIiRNTLPdOACu$dOcbjI7N2Q8+zoB8nQAQfAUqbDrkfyBk1z2eAVvnxe8=', NULL, FALSE, 'STD7187', 'kimani', 'student7187@example.com', FALSE, TRUE, '2026-01-14 04:59:48.889373', 'Kent'),
  (1028, 'pbkdf2_sha256$1000000$NuhhEii3G77BnJoPW4F4wO$g9lfSfczNuC6VJB+rvCu051BMb5WusqRZJH6Dq4wFdM=', NULL, FALSE, 'STD7119', 'kariuki', 'student7119@example.com', FALSE, TRUE, '2026-01-14 04:59:50.326515', 'Ryan'),
  (1029, 'pbkdf2_sha256$1000000$CuEIj2YA4WkFsKNpMdiS1w$x/wrVYY5SBEam47Jk0vm6O0ahTHMAXIIm8f0ycOKOzI=', NULL, FALSE, 'STD7123', 'baraka', 'student7123@example.com', FALSE, TRUE, '2026-01-14 04:59:51.941622', 'Ignitious'),
  (1030, 'pbkdf2_sha256$1000000$VAFoZjtYyJUZSszCsUZcRp$iLT2bCslZcLfqO9Orim9LyfiDsmL3/TNeEZo3angMhk=', NULL, FALSE, 'STD7242', 'mutwiri', 'student7242@example.com', FALSE, TRUE, '2026-01-14 04:59:53.632316', 'Millan'),
  (1031, 'pbkdf2_sha256$1000000$dTQoCQIP3NbZraSIoAIHOO$4DomQel5JBYGvd7SRd4YkhY1qQyNjhGFRFk2IgZ1OoA=', NULL, FALSE, 'STD7210', 'mucheru', 'student7210@example.com', FALSE, TRUE, '2026-01-14 04:59:55.438259', 'Edward'),
  (1032, 'pbkdf2_sha256$1000000$l0zBB5IcmKNx9ZtqsB8tZ8$7p4sF4/QIh7YM1Ty5KZbd7MVdAtdzm18rSUp8c3AhxY=', NULL, FALSE, 'STD7137', 'maina', 'student7137@example.com', FALSE, TRUE, '2026-01-14 04:59:57.066673', 'Leon'),
  (1033, 'pbkdf2_sha256$1000000$8Pw3HrLZaGxO7d4tOdpu9W$ZL18RF0d4cxVBYlhXQqVhjeAIyoHF+lJkbA4sRveQx0=', NULL, FALSE, 'STD7161', 'kimani', 'student7161@example.com', FALSE, TRUE, '2026-01-14 04:59:58.632967', 'Jeff'),
  (1034, 'pbkdf2_sha256$1000000$F3pr6hv3JiPww1cE2QVjAn$zVgZmk5fbxjnp8zX9qIvL9LFGc5Av5HEhAh88eKGdLU=', NULL, FALSE, 'STD7129', 'Njoroge', 'student7129@example.com', FALSE, TRUE, '2026-01-14 05:00:00.043659', 'Mike'),
  (1035, 'pbkdf2_sha256$1000000$oFssrX1E7Ji5sPAxyPO0Fp$zPi09N1FWJLK0ZweBP4YVkEn6iM/Mw+vuUT3w2dZpf4=', NULL, FALSE, 'STD7483', 'k nyabuto', 'student7483@example.com', FALSE, TRUE, '2026-01-14 05:00:01.641273', 'Daniel'),
  (1036, 'pbkdf2_sha256$1000000$dp88nwRl7VOA3gkwGXhdw3$B1iyu8cfTx1bl4xKL4IA2xR7TV88x3qdf7GpZzZ/3tk=', NULL, FALSE, 'STD7476', 'Stephen', 'student7476@example.com', FALSE, TRUE, '2026-01-14 05:00:03.217905', 'Owen'),
  (1037, 'pbkdf2_sha256$1000000$S1AX2gwTtI2Sgosw5N5TKq$oGnEf6LB6pgv/mjYh8p+9NRSCdf5ycynJNiDuNKH5NM=', NULL, FALSE, 'STD7459', 'kamau', 'student7459@example.com', FALSE, TRUE, '2026-01-14 05:00:04.669229', 'Ryan'),
  (1038, 'pbkdf2_sha256$1000000$MgClLS7YAIzj3iP2LOTSq7$zFezsSP4FtCvmiYhrd5QP+pN6jDZIXIKzEoJmym4kVQ=', NULL, FALSE, 'STD7491', 'Gatabi', 'student7491@example.com', FALSE, TRUE, '2026-01-14 05:00:06.334879', 'Angel'),
  (1039, 'pbkdf2_sha256$1000000$mN9nzTm8U6dMMo82CTxgtD$txr2G4gu51gu/6UiLZAKIrtKZzHOuvI+A1fJOHhx/vM=', NULL, FALSE, 'STD7130', 'Grace', 'student7130@example.com', FALSE, TRUE, '2026-01-14 05:00:07.958451', 'Laura'),
  (1040, 'pbkdf2_sha256$1000000$dyJcE9HrqwfvA5lG0VEuri$NRyOqid2i8MvllWKZ2n68kF2gSOdNibGXSBSGYzs/JA=', NULL, FALSE, 'STD7140', 'warau', 'student7140@example.com', FALSE, TRUE, '2026-01-14 05:00:09.430641', 'Evarose'),
  (1041, 'pbkdf2_sha256$1000000$2529QO0UvXbl6QYUBU4sf4$6wou0VfSt6Hpv4JFenCOIR7RP1q1bJ3jqQRBtO99PkI=', NULL, FALSE, 'STD7198', 'amani', 'student7198@example.com', FALSE, TRUE, '2026-01-14 05:00:11.276183', 'Jedidah'),
  (1042, 'pbkdf2_sha256$1000000$fLkPdvuZtJi6zRlIHDH6cN$HgN49xH6XVk80wipgug00YaXSEhWtaWQGoPBoiMztDE=', NULL, FALSE, 'STD7181', 'amalia', 'student7181@example.com', FALSE, TRUE, '2026-01-14 05:00:12.912797', 'Judith'),
  (1043, 'pbkdf2_sha256$1000000$rTFuimOw3RLCLP7xd6gZwo$D1WOStTTLsXOxRLNvbUQsnJmE0g8H3B6hD+9lhWD2UI=', NULL, FALSE, 'STD7139', 'Wambui kingori', 'student7139@example.com', FALSE, TRUE, '2026-01-14 05:00:14.353091', 'Blessing'),
  (1044, 'pbkdf2_sha256$1000000$cQnxyHTFUl4MCknFdFWXqb$PBwpEsIa8V8Mpffg12Ae24RFDIZm4nHwGsDIRLe5kvU=', NULL, FALSE, 'STD7120', 'waithera', 'student7120@example.com', FALSE, TRUE, '2026-01-14 05:00:16.126290', 'Claire'),
  (1045, 'pbkdf2_sha256$1000000$UwGkL3SIJbrE8EUQvX7RUC$bnkZm40aBwPoeIVbeb6n3KorrFXPb7+itX5NhjDGkG8=', NULL, FALSE, 'STD7100', 'Wambui', 'student7100@example.com', FALSE, TRUE, '2026-01-14 05:00:17.734541', 'Christabel'),
  (1046, 'pbkdf2_sha256$1000000$mDQOGV9ZxWQAHTVMR46VOJ$kRiKMnlVzOQeGnGYVj0ZfIQwrUdSPKNu5KICxh0Rxf8=', NULL, FALSE, 'STD7580', 'Njeri', 'student7580@example.com', FALSE, TRUE, '2026-01-14 05:00:19.157079', 'Telaviv'),
  (1047, 'pbkdf2_sha256$1000000$8ANyy07Fc9XltE2LYbxYrc$7dftKxq4ZESkPwQQ4+P5h9tvwjVKeOtL5IQG6RuKOh0=', NULL, FALSE, 'STD7124', 'Lexi wanjiku', 'student7124@example.com', FALSE, TRUE, '2026-01-14 05:00:20.751064', 'Grace'),
  (1048, 'pbkdf2_sha256$1000000$Zindz3nIvkVgNRZEP2Otux$XF15GIZELYI8sY67BDxTN3yYbMQpw2usIBJBtWRdwcw=', NULL, FALSE, 'STD7462', 'makena', 'student7462@example.com', FALSE, TRUE, '2026-01-14 05:00:22.401773', 'Rael'),
  (1049, 'pbkdf2_sha256$1000000$MMW6YzOZRBSpOidhWCjSDf$RpP8lZKHRo77fLq6dTBS5nE0vW7paMuSPFhRBT2xwaY=', NULL, FALSE, 'STD7111', 'mwende', 'student7111@example.com', FALSE, TRUE, '2026-01-14 05:00:23.823042', 'Talia'),
  (1050, 'pbkdf2_sha256$1000000$5DswNkBFqM3ITJySDQIv2F$f9zQifMQ2yF83IddKtzrwilug1FBY9nnGJ45QJh/MYg=', NULL, FALSE, 'STD7112', 'wanjiku', 'student7112@example.com', FALSE, TRUE, '2026-01-14 05:00:25.441218', 'Jasmine'),
  (1051, 'pbkdf2_sha256$1000000$U5Ov93u7jkt3Sri2btmwWR$2CXAJPmJQM5+CVsU5DkY+jC+bdDZ1a9jBdeFxoG1aBQ=', NULL, FALSE, 'STD7106', 'Wambui', 'student7106@example.com', FALSE, TRUE, '2026-01-14 05:00:27.238099', 'Daisy'),
  (1052, 'pbkdf2_sha256$1000000$ZoCwDylHDdK3fPMSIZKgrB$XO3f7j4Tg+8Kij1eyXK9RyuaqjobSzAGpva2IYeQv8I=', NULL, FALSE, 'STD7179', 'wangui', 'student7179@example.com', FALSE, TRUE, '2026-01-14 05:00:29.090321', 'Natalia'),
  (1053, 'pbkdf2_sha256$1000000$GlPW69uv8dtlIsOAO3KfRq$9r0++NOpGwf8SKH5THqUaNi2GgS93CW7UKDq7+2WdfQ=', NULL, FALSE, 'STD7110', 'wamaitha', 'student7110@example.com', FALSE, TRUE, '2026-01-14 05:00:30.847441', 'Ivy'),
  (1054, 'pbkdf2_sha256$1000000$JKt8g6GemAjQDLn24qJ6y7$cjeG4VHC/p+Eo/5SmeyNraP4mqKzu3xrvvMIIrr3yJ8=', NULL, FALSE, 'STD7575', 'nanjala', 'student7575@example.com', FALSE, TRUE, '2026-01-14 05:00:32.438362', 'Maryjoy'),
  (1055, 'pbkdf2_sha256$1000000$onMuX2CCKDzbX9Vx9wxDAx$MYONGlWRgRX6omaZsDchVO1v8MiXxLRG63v0V0A76iU=', NULL, FALSE, 'STD7190', 'ndira', 'student7190@example.com', FALSE, TRUE, '2026-01-14 05:00:33.883416', 'Trevin'),
  (1056, 'pbkdf2_sha256$1000000$TpJHVnjUbrUJuKL699ejjj$JeZBVC98NP9HQ+CNiwrM2NaQkeL406+zl8y8/82SaMQ=', NULL, FALSE, 'STD7525', 'onyoit anericho', 'student7525@example.com', FALSE, TRUE, '2026-01-14 05:00:35.440807', 'Aristotle'),
  (1057, 'pbkdf2_sha256$1000000$L8qWxkE8KTLi5j6yjgLlH6$Mk9U9MWRcGEIvDs/0Ptu36xc+VT17XLlMO3F1mxV/dI=', NULL, FALSE, 'STD7127', 'katisya', 'student7127@example.com', FALSE, TRUE, '2026-01-14 05:00:37.063448', 'Daniel'),
  (1058, 'pbkdf2_sha256$1000000$7ytzchSAlcFFXkasfltXUw$SgZrEZuroFeWPbLT8qcb2jtKwj5wQejx18g3+ndSkJU=', NULL, FALSE, 'STD7128', 'muigai', 'student7128@example.com', FALSE, TRUE, '2026-01-14 05:00:38.590517', 'Chabel'),
  (1059, 'pbkdf2_sha256$1000000$lIglGym4js8H1LZLIDlRWn$Oiq7AtvtJ8Axh5B2l8sWSFee+aHLLOqKKxf/pDMubbM=', NULL, FALSE, 'STD7518', 'kioko', 'student7518@example.com', FALSE, TRUE, '2026-01-14 05:00:40.418867', 'Freedom'),
  (1060, 'pbkdf2_sha256$1000000$xiXt06L6cY7WOwiuENSOwi$I/ZlP/076XfTL2ieRSYhLyJZltYAH2yKdoeNATiNCDc=', NULL, FALSE, 'STD7274', 'kamau', 'student7274@example.com', FALSE, TRUE, '2026-01-14 05:00:42.142501', 'Christopher'),
  (1061, 'pbkdf2_sha256$1000000$udkuk2tmxYnYT4TF2JWs4C$bulqoOCNI7SYsAQALgjsWT60PHAw53fy49RvvUbfwVw=', NULL, FALSE, 'STD7121', 'Gichane', 'student7121@example.com', FALSE, TRUE, '2026-01-14 05:00:44.168526', 'Stephen'),
  (1062, 'pbkdf2_sha256$1000000$UwZ3NDhsseZrsXMtT4VBvG$0FMvsgAbSzBR4S3REmWODnnsFtW6YEn6M1xXBGbKJA4=', NULL, FALSE, 'STD7122', 'maingi', 'student7122@example.com', FALSE, TRUE, '2026-01-14 05:00:45.816092', 'Boniface'),
  (1063, 'pbkdf2_sha256$1000000$vlzWqOTxy3PWOYbwZYuFtn$JJh2xl8nF+m6N1iuNHuqgFJIcLxIpH52jJ2Zyuwx6h0=', NULL, FALSE, 'STD7200', 'chira', 'student7200@example.com', FALSE, TRUE, '2026-01-14 05:00:47.252898', 'Simon'),
  (1064, 'pbkdf2_sha256$1000000$FjRVJ3ECQB2ybAD0ENFKXZ$+WQVPmC0eNKS+wuEq3PoUHbb7/8/8Ts50H3QvkwfKKk=', NULL, FALSE, 'STD7109', 'kuria', 'student7109@example.com', FALSE, TRUE, '2026-01-14 05:00:48.820141', 'Garvin'),
  (1065, 'pbkdf2_sha256$1000000$iWBRHC7bgR8wisKtzzi2gJ$Yhx9pW0svUmxr5s+mFbgJjunuOMoV0iYBFAV/dlr4Jg=', NULL, FALSE, 'STD7219', 'rakita', 'student7219@example.com', FALSE, TRUE, '2026-01-14 05:00:50.441073', 'Levis'),
  (1066, 'pbkdf2_sha256$1000000$j6KqgJkpgGm7JU3CIqY4VM$adb2RIO83zdBqEmrgspdOEQmq5iBi4yojYVCyLYn7Ig=', NULL, FALSE, 'STD7217', 'nyandega', 'student7217@example.com', FALSE, TRUE, '2026-01-14 05:00:51.833094', 'Lovren'),
  (1067, 'pbkdf2_sha256$1000000$i9x6kOw1XxKwuDWd1qQ1sZ$xOcu4Aw0x7Js07zm4kNLZdJoL0qExe7kAfjxm56wMnA=', NULL, FALSE, 'STD7298', 'mburu', 'student7298@example.com', FALSE, TRUE, '2026-01-14 05:00:53.404765', 'Jayden'),
  (1068, 'pbkdf2_sha256$1000000$wsFfCZOLIzbaBhVrMwV5RS$FbhjH8kcQx4rvJDGs0wyTFn9uSo15bnaHXbxFbQYuXk=', NULL, FALSE, 'STD7540', 'brook', 'student7540@example.com', FALSE, TRUE, '2026-01-14 05:00:55.001108', 'Israel'),
  (1069, 'pbkdf2_sha256$1000000$S9NHXovgXJBI2PwYAkommk$qEEl3HXDm9AMhlF5cW7qkcGYHS4vYBvP1MRZSdtKqdM=', NULL, FALSE, 'STD7113', 'Boaz', 'student7113@example.com', FALSE, TRUE, '2026-01-14 05:00:56.409629', 'Justin'),
  (1070, 'pbkdf2_sha256$1000000$CEen0uZ9OcuBQhtPIeHgzO$FzPGt8ZbOGy8VwiumoGRXNRJOtF7tOWKYoHv+Gid+XU=', NULL, FALSE, 'STD7134', 'maina', 'student7134@example.com', FALSE, TRUE, '2026-01-14 05:00:58.020201', 'Gilbert'),
  (1071, 'pbkdf2_sha256$1000000$grEwV6hQsMFvGPmmHgCoJZ$m/2nhtp4wDrSLUoDZ8Q2huaVUWvap8sJ28EW3OEQTug=', NULL, FALSE, 'STD7116', 'maverick wamai', 'student7116@example.com', FALSE, TRUE, '2026-01-14 05:00:59.941661', 'Ethan'),
  (1072, 'pbkdf2_sha256$1000000$uVzsymjESlvze1r68vCCnJ$3xHPRtja65Ez59hsTE+T9YUbpYREggrR/vHpCxn+NSg=', NULL, FALSE, 'STD7251', 'njora', 'student7251@example.com', FALSE, TRUE, '2026-01-14 05:01:01.418417', 'Francis'),
  (1073, 'pbkdf2_sha256$1000000$x9Sl1lwOJznrpHDE95gxGi$I18XzlEbbkF+WwEzT9OTE8hjB08GauwLeSCQTUQM3Ks=', NULL, FALSE, 'STD7132', 'wanyoike', 'student7132@example.com', FALSE, TRUE, '2026-01-14 05:01:03.055259', 'Treyvion'),
  (1074, 'pbkdf2_sha256$1000000$7MN6LcYDFpyR0ceGZETTFj$L8Tlw6ecWvlfCp5kxVwcf8sz9S+9q96plALfovUr5Ak=', NULL, FALSE, 'STD7117', 'Nduku', 'student7117@example.com', FALSE, TRUE, '2026-01-14 05:01:04.717647', 'Abigael'),
  (1075, 'pbkdf2_sha256$1000000$xS8JWfdsYlycOdQ93GqciK$KrKCmXdnnnhkVH09Oduq+QijdUivYYlPey/uetsAYcI=', NULL, FALSE, 'STD7616', 'mbesa', 'student7616@example.com', FALSE, TRUE, '2026-01-14 05:01:06.076032', 'Blessing'),
  (1076, 'pbkdf2_sha256$1000000$LT4UV8vBKfQqG0TAKPNst8$VgsbvVKxHFky9FI63SwJ+b4grA2+BHHGYfyY0E9Wo9Q=', NULL, FALSE, 'STD7386', 'wanjiku', 'student7386@example.com', FALSE, TRUE, '2026-01-14 05:01:07.697145', 'Veronica'),
  (1077, 'pbkdf2_sha256$1000000$zwj5ib74S7Rp86FvbVI6mv$nCne0LCtp5FesoHpM9g07AAKJR9+SBEz0CNt65LNyAY=', NULL, FALSE, 'STD7241', 'kathure', 'student7241@example.com', FALSE, TRUE, '2026-01-14 05:01:09.436791', 'Precious'),
  (1078, 'pbkdf2_sha256$1000000$11GwzjAsbFu4w4xqTCMAen$blQHn42XkaSuh+D53miRbbU55lwLfLzfcua5Ky2JB4w=', NULL, FALSE, 'STD7118', 'mukami', 'student7118@example.com', FALSE, TRUE, '2026-01-14 05:01:10.827999', 'Liser'),
  (1079, 'pbkdf2_sha256$1000000$q8wCD1kuCU9Oue4wMO208o$eoCYIcacn1eTO2XsRD4dpE/L6lHsSejudqaf4NgLN88=', NULL, FALSE, 'STD7628', 'Wambui', 'student7628@example.com', FALSE, TRUE, '2026-01-14 05:01:12.747824', 'Lucy'),
  (1080, 'pbkdf2_sha256$1000000$QYNFCILFdstDgNEhnWHgSv$vX/vyX4KqJuby+PX+bEDpVId51B480mCUFhswYdrF3g=', NULL, FALSE, 'STD7114', 'nyakeru', 'student7114@example.com', FALSE, TRUE, '2026-01-14 05:01:14.441573', 'Maryer'),
  (1081, 'pbkdf2_sha256$1000000$sjqA1opQ2RAs9mFhVx2Hvh$qLRwgwzGtNMJN6Q/juIeFQCsOOapVEYLx+XkqtD4GwI=', NULL, FALSE, 'STD7362', 'Wambui', 'student7362@example.com', FALSE, TRUE, '2026-01-14 05:01:16.267279', 'Blessing'),
  (1082, 'pbkdf2_sha256$1000000$jAvuKz2STBualvAo0e5ao3$MKcBlTPOA0jmR7j/k6KS5FyY/pD12CBXQhEbRHM8RTY=', NULL, FALSE, 'STD7177', 'nduku', 'student7177@example.com', FALSE, TRUE, '2026-01-14 05:01:18.262796', 'Jasmine'),
  (1083, 'pbkdf2_sha256$1000000$KB10yUKKXqBuC21iLlyY0h$/SZbW7Jfv9mGsihD8slky8NEdXSmOOE0P2jW9JECyRw=', NULL, FALSE, 'STD7125', 'mumbe', 'student7125@example.com', FALSE, TRUE, '2026-01-14 05:01:20.533005', 'Destiny'),
  (1084, 'pbkdf2_sha256$1000000$8ZbMWrClxVnqOHZAhGPR0W$ThnRLjtGnFnvtQOGM6qGDtTkQg9Byd+ZjBWjkjHWNBc=', NULL, FALSE, 'STD7216', 'mwikali', 'student7216@example.com', FALSE, TRUE, '2026-01-14 05:01:23.151926', 'Joy'),
  (1085, 'pbkdf2_sha256$1000000$RZ4mnkqCTDjTALOYgQEEkn$opAHymSTjNImprtRLNYl3H5lFjzYACwt2qvHJzgMqFI=', NULL, FALSE, 'STD7126', 'kwamboka', 'student7126@example.com', FALSE, TRUE, '2026-01-14 05:01:25.864250', 'Lorna'),
  (1086, 'pbkdf2_sha256$1000000$k32eXqUY1COzGH8yr3ZXJD$dIUnhzBH5ra5eOBSTnMBi4Am1ugwsZX9pfc70ogJy34=', NULL, FALSE, 'STD7180', 'wairimu', 'student7180@example.com', FALSE, TRUE, '2026-01-14 05:01:27.771066', 'Zuri'),
  (1087, 'pbkdf2_sha256$1000000$O5MAPEQqGkuVpLufPsoEPK$sJZacSbvlmDgW4VPvQ37hkbdQh3Qbe9B8Dp+jRgKBCI=', NULL, FALSE, 'STD7338', 'Muthoni', 'student7338@example.com', FALSE, TRUE, '2026-01-14 05:01:29.653860', 'Princess'),
  (1088, 'pbkdf2_sha256$1000000$HG0jejLKsUSYSom1X2NudQ$0O6vr6NSWmn1nCK26VLgaE7ii9c2c/e3tY/PhU2Ajfc=', NULL, FALSE, 'STD7142', 'Kingori', 'student7142@example.com', FALSE, TRUE, '2026-01-14 05:01:31.515950', 'Emmanuel'),
  (1089, 'pbkdf2_sha256$1000000$yQmYr7tESFyTpnAok1a1oU$gnhmPo3616Hxlx+ubFut3Nbg2F3T91kkVRC90H+XW6Q=', NULL, FALSE, 'STD7162', 'juliet', 'student7162@example.com', FALSE, TRUE, '2026-01-14 05:01:33.091614', 'Precious'),
  (1090, 'pbkdf2_sha256$1000000$O01X7qJF8F34GiFSCQ4rIv$0zBwFtWvE0mbwwkYEZ0J0bmupTBFxBU4WneUZESNhco=', NULL, FALSE, 'STD7502', 'mumo', 'student7502@example.com', FALSE, TRUE, '2026-01-14 05:01:34.613763', 'Jaison'),
  (1091, 'pbkdf2_sha256$1000000$eNrdcsCcL8XTCKeMuVHx1k$duiuMfY2S1IhuJudXGK3VkZyI8h99NFHsqPRaAUUbk0=', NULL, FALSE, 'STD7523', 'Wairimu', 'student7523@example.com', FALSE, TRUE, '2026-01-14 05:01:36.686647', 'Georgia'),
  (1092, 'pbkdf2_sha256$1000000$Omp9szHaRHEyCtbKXDZKqm$J96LdEmGxP8oiq0Te1rE6nv9bVHbSa03oDW+viwgsrU=', NULL, FALSE, 'STD7328', 'Reyna wariara', 'student7328@example.com', FALSE, TRUE, '2026-01-14 05:01:38.638293', 'Zoe'),
  (1093, 'pbkdf2_sha256$1000000$aiVfZJRZRfsKf8SeyTg0II$qur9eCEeYCgpwe5LV8Km3CwD234FGh185wqekmzG1Sw=', NULL, FALSE, 'STD7195', 'Arthur', 'student7195@example.com', FALSE, TRUE, '2026-01-14 05:01:40.860769', 'Louis'),
  (1094, 'pbkdf2_sha256$1000000$lnC5fZ9JAdIoVYgm9uCmTG$Qf42VY/GtMiX5UjQsJI1rxuxqM+N1on4k7Lu9vJOrQM=', NULL, FALSE, 'STD7590', 'kamau', 'student7590@example.com', FALSE, TRUE, '2026-01-14 05:01:43.228700', 'Stephen'),
  (1095, 'pbkdf2_sha256$1000000$KzLyr25ITcBHDEOqFkQg1B$xEyjwwzZR+s+qwv65eqGY85c4GsVU7vCYizxwys4xCY=', NULL, FALSE, 'STD7028', 'mwendwa', 'student7028@example.com', FALSE, TRUE, '2026-01-14 05:01:45.511514', 'Kylie'),
  (1096, 'pbkdf2_sha256$1000000$mcyZRfhPDyZ73Ox1SL51ys$tX4GAVMfz50uEUixrUIdrcR9vJvEB4TI+dksnLXsbrE=', NULL, FALSE, 'STD7295_2', 'nyambura joshua', 'student7295_2@example.com', FALSE, TRUE, '2026-01-14 05:01:47.706899', 'Abigael'),
  (1097, 'pbkdf2_sha256$1000000$jVa4DFk4tkiHzBqlIWYiwZ$aCuzT66lMikeGR0VlHyngN8Rp0DOLJYYWBNRRQD1s8Y=', NULL, FALSE, 'STD7526', 'muuo', 'student7526@example.com', FALSE, TRUE, '2026-01-14 05:01:49.857074', 'Quizon'),
  (1098, 'pbkdf2_sha256$1000000$S5mFdzvnq8ulFOdzZ4Cpgb$Vzt6NYhoTEyzgxmrqNGJ63a0HBWh4VQUHPt7/OXCYPg=', NULL, FALSE, 'STD7063', 'wanjiku', 'student7063@example.com', FALSE, TRUE, '2026-01-14 05:01:51.659162', 'Hope'),
  (1099, 'pbkdf2_sha256$1000000$4Kt4OIDTCXjxuEyNyOAT8q$cgiiFGcahKLIiofnm6yU/xRHj9lLxLjy5G1uI949jT0=', NULL, FALSE, 'STD7069', 'Flavian', 'student7069@example.com', FALSE, TRUE, '2026-01-14 05:01:53.499472', 'Abigael'),
  (1100, 'pbkdf2_sha256$1000000$H6b1bojQ45KSkPV0bRsT5n$FuE+ZEdOt5IfZQWJbOKq5wr9kGDXsOPywg8DZFEmsZI=', NULL, FALSE, 'STD7629', 'mwema', 'student7629@example.com', FALSE, TRUE, '2026-01-14 05:01:56.109015', 'Enelique'),
  (1101, 'pbkdf2_sha256$1000000$CR68JKGY0PbYHdOfCtivQQ$ePcE4IdvI8u7DRmJmsf41oqvrzF/GDi4FzLHrBwFP6Y=', NULL, FALSE, 'STD7536', 'gatune', 'student7536@example.com', FALSE, TRUE, '2026-01-14 05:01:58.013480', 'Zoe'),
  (1102, 'pbkdf2_sha256$1000000$wzN2eNZsknkBSJvpfyTl3d$5C/50XeJvQJ7JzZ3gybdWg5VYz7nTz1g1+YYKcLEoOo=', NULL, FALSE, 'STD7456', 'njama', 'student7456@example.com', FALSE, TRUE, '2026-01-14 05:01:59.747069', 'Jean'),
  (1103, 'pbkdf2_sha256$1000000$CoUy9c2teTTg0X75dI0UGY$5XXvOME5xWy3heUqu+lMBQFtXuC2Csxxr+VxQni9gu0=', NULL, FALSE, 'STD7145', 'mutunga', 'student7145@example.com', FALSE, TRUE, '2026-01-14 05:02:01.397323', 'Dylan'),
  (1104, 'pbkdf2_sha256$1000000$QnWA9mnxkq6k0FOnVnxyRh$hHJE6yDDaWrPcNkMyzqIGKhvq3+3AnQPHN+UgbK/JqQ=', NULL, FALSE, 'STD7072', 'wema', 'student7072@example.com', FALSE, TRUE, '2026-01-14 05:02:03.237523', 'Janice'),
  (1105, 'pbkdf2_sha256$1000000$GAIcmHvESKoQifF7enDWow$wSIvf9hgZoSgvuubKIujI3cqRrtLD+IpZRFXe/AisiE=', NULL, FALSE, 'STD7060', 'kibaki', 'student7060@example.com', FALSE, TRUE, '2026-01-14 05:02:04.927362', 'Daren'),
  (1106, 'pbkdf2_sha256$1000000$XMURsb6N0SL0Spy4xFSqb0$Ni1RINa/qTPqqCvQwFILxnkrsF7EdHzQjcot0p8xH80=', NULL, FALSE, 'STD7079', 'njihia', 'student7079@example.com', FALSE, TRUE, '2026-01-14 05:02:06.394757', 'Ryan'),
  (1107, 'pbkdf2_sha256$1000000$MUksuQODjUaUEOYALLmitn$vw0PM3OzPjmYbA1+zSzzraGb3IpNMk9GNtFwOVYOg3s=', NULL, FALSE, 'STD7076', 'irungu', 'student7076@example.com', FALSE, TRUE, '2026-01-14 05:02:08.035158', 'Jason'),
  (1108, 'pbkdf2_sha256$1000000$NsfF37PeGwPj2i8PjJ3WPs$S2cfdv7vMMaXph2P6ZmwJRTzPMHOUl9LNpcAGBuycnY=', NULL, FALSE, 'STD7073', 'kimani', 'student7073@example.com', FALSE, TRUE, '2026-01-14 05:02:09.683506', 'Liam'),
  (1109, 'pbkdf2_sha256$1000000$6dlj7vYh4UR5I2mI6maVO5$TSBCcWG5RzZE/NjC0ldzlF4RJ+pw6zqL0N761ewY14E=', NULL, FALSE, 'STD7303', 'njuguna', 'student7303@example.com', FALSE, TRUE, '2026-01-14 05:02:11.103724', 'Shem'),
  (1110, 'pbkdf2_sha256$1000000$e75zWeFVM16qhdCa2WQQ76$H91oS+0LSMzatMW+gkGWv1MGxqbOBxJ+ABaOYtO6rM0=', NULL, FALSE, 'STD7050', 'kinuthia', 'student7050@example.com', FALSE, TRUE, '2026-01-14 05:02:12.785909', 'Patrick'),
  (1111, 'pbkdf2_sha256$1000000$BR6RxZImROg6a2aPqSSsBg$3gQxvbc+34eUyVm9VqPRZC1Vt5O4tFovURaCRDRW2+0=', NULL, FALSE, 'STD7087', 'mulei', 'student7087@example.com', FALSE, TRUE, '2026-01-14 05:02:14.722501', 'Boniface'),
  (1112, 'pbkdf2_sha256$1000000$QUAoHcboYCk9ek7wqv8jEb$ehMi3vy57cL+rWgVURKAy5ovb5xWf5HTN7/BNoVAf2A=', NULL, FALSE, 'STD7323', 'kamau', 'student7323@example.com', FALSE, TRUE, '2026-01-14 05:02:16.171076', 'Victor'),
  (1113, 'pbkdf2_sha256$1000000$xSZf3s43ZIhXf7oZekeRyO$NjxLM6TNkOnq00pbZrE4LSszqePd3bnLp9gzj5d4Nd0=', NULL, FALSE, 'STD7059', 'wambua', 'student7059@example.com', FALSE, TRUE, '2026-01-14 05:02:17.758178', 'John'),
  (1114, 'pbkdf2_sha256$1000000$toWReppghLt89y0FkiUWAa$KObHv//gNvQrxvbRAzdSGHI5bTouXnI8Or5HW6LqX/E=', NULL, FALSE, 'STD7159', 'mawang', 'student7159@example.com', FALSE, TRUE, '2026-01-14 05:02:19.438661', 'Testimony'),
  (1115, 'pbkdf2_sha256$1000000$rdC8xokwAgagzoLZ1WONW2$L0oKBym/NAHV6E5y2/LBHFEUX17W9TKbPZOypWtPRTc=', NULL, FALSE, 'STD7393', 'shelvin', 'student7393@example.com', FALSE, TRUE, '2026-01-14 05:02:20.886176', 'Bradley'),
  (1116, 'pbkdf2_sha256$1000000$gXpmJrAeHEQnPkN7G4JVtg$QFtFKw5mn+Rlai5Zm/CpFap5ma0SaHeWX7gfkZVpbP0=', NULL, FALSE, 'STD7071', 'macharia', 'student7071@example.com', FALSE, TRUE, '2026-01-14 05:02:22.452915', 'Prince'),
  (1117, 'pbkdf2_sha256$1000000$CxNKdlJEWcuBIkCemwQvQ5$56JXudSkfKYWses7Hp9mvmdKEZzDkOSkc3N266rsmc4=', NULL, FALSE, 'STD7084', 'Njoroge', 'student7084@example.com', FALSE, TRUE, '2026-01-14 05:02:24.118061', 'Brandon'),
  (1118, 'pbkdf2_sha256$1000000$gYWCQ6JJBfB07i33t8OAOI$vHW/cH5u6sSe1xJUbQX8E/Opnu2VEQDKKgH7vnJyUHE=', NULL, FALSE, 'STD7276', 'onyango', 'student7276@example.com', FALSE, TRUE, '2026-01-14 05:02:25.591092', 'Goodluck'),
  (1119, 'pbkdf2_sha256$1000000$p5NC87FXehZR8OJeWheeKE$cNdAB2hd70EABdsu7HOOLVrBlPPG91CGI2HqdJyQHNk=', NULL, FALSE, 'STD7070', 'peter muniu', 'student7070@example.com', FALSE, TRUE, '2026-01-14 05:02:27.304729', 'Liam'),
  (1120, 'pbkdf2_sha256$1000000$XbgxJBKn0LC2INnYIp4Dra$9iwuTB5aIMg6HyC2V6S4d6bR7MHDxRXkr4AJJXdcWrk=', NULL, FALSE, 'STD7075', 'Arthur kimanzi', 'student7075@example.com', FALSE, TRUE, '2026-01-14 05:02:29.006493', 'Zayn'),
  (1121, 'pbkdf2_sha256$1000000$2aJ5yLuLolAKDWzwgtzxmV$ARjIjnPSkhnV1RrzwFChoSo3WiRTTrh2X+3tgUKcnmg=', NULL, FALSE, 'STD7086', 'B mulei', 'student7086@example.com', FALSE, TRUE, '2026-01-14 05:02:30.842744', 'Liam'),
  (1122, 'pbkdf2_sha256$1000000$rBGNVPTdbVHT2kI2lgHdHD$G+r927HR+rIjk2KCA+fpeHBm+2oDsnqva3xIKu/XBnQ=', NULL, FALSE, 'STD7146', 'ngethe', 'student7146@example.com', FALSE, TRUE, '2026-01-14 05:02:32.484287', 'Theophilus'),
  (1123, 'pbkdf2_sha256$1000000$758zVHzQXZQVOvVSYRoxdr$cx+OuHpMTBAqSjtIdyQlePd0H+FDgNDHXkzYPwYx5og=', NULL, FALSE, 'STD7066', 'katisya', 'student7066@example.com', FALSE, TRUE, '2026-01-14 05:02:34.008853', 'Joseph'),
  (1124, 'pbkdf2_sha256$1000000$nf8SYwfCb5yNVckYyU9IcM$OLtB+D/Yuz5iOvZ3Ww8HggQaNJWjakkZVTnxRJJ9mJw=', NULL, FALSE, 'STD7592', 'mwangi', 'student7592@example.com', FALSE, TRUE, '2026-01-14 05:02:35.446189', 'Emmanuel'),
  (1125, 'pbkdf2_sha256$1000000$Eusj9aNauBHlJGuHzMzkjs$4TE8VLWQh9T8dIiT2NcWYHCIEAkwEW0kyelX3eP2CoI=', NULL, FALSE, 'STD7160', 'Ann Melissa', 'student7160@example.com', FALSE, TRUE, '2026-01-14 05:02:37.097596', 'Jay'),
  (1126, 'pbkdf2_sha256$1000000$4nFKhTYKvlh7T4yj5aORIx$hM2jsSYR+nzgrUGeWVXSH60Zx8HsO03Hn6b4dbNk94o=', NULL, FALSE, 'STD7329', 'nyangasi', 'student7329@example.com', FALSE, TRUE, '2026-01-14 05:02:38.789691', 'Flavin'),
  (1127, 'pbkdf2_sha256$1000000$kYerXgFZuR35nHErGQDnzL$Gpsh6+6N9o+deTZggJA2wMY1CHHhpwPjySL5c9QKu9g=', NULL, FALSE, 'STD7065', 'wanjiku', 'student7065@example.com', FALSE, TRUE, '2026-01-14 05:02:40.287719', 'Peris'),
  (1128, 'pbkdf2_sha256$1000000$xoZwOZk61mtDu27iYZdXKc$NrnM0Jq1GZ5KhBqfhfDNBfaaJCjfcyPO2FVnfwN+hdA=', NULL, FALSE, 'STD7081', 'gathoni', 'student7081@example.com', FALSE, TRUE, '2026-01-14 05:02:41.937896', 'Grace'),
  (1129, 'pbkdf2_sha256$1000000$ShCIWiO0wYlqwS7cXnoJq2$w3tGA25vu+1DlQS2r41akVG3xCjcwfk6awRIL3McVzE=', NULL, FALSE, 'STD7062', 'Muthoni', 'student7062@example.com', FALSE, TRUE, '2026-01-14 05:02:43.702563', 'Doreen'),
  (1130, 'pbkdf2_sha256$1000000$iecmXsVHdUHnHUPoDWAHSQ$RIfatraHPe5rRng/2iMQ90rSMYIUTk4w3Sda6iLaezY=', NULL, FALSE, 'STD7350', 'mbithe', 'student7350@example.com', FALSE, TRUE, '2026-01-14 05:02:45.150977', 'Zipporah'),
  (1131, 'pbkdf2_sha256$1000000$WC7WVd9Ie1EhJ0IJFkR0vw$EuEjvoIQfLBFawuA/ASWSwMFEizdEsWH/o5qysdTeSg=', NULL, FALSE, 'STD7152', 'favour', 'student7152@example.com', FALSE, TRUE, '2026-01-14 05:02:47.025808', 'Tamara'),
  (1132, 'pbkdf2_sha256$1000000$ZO6sx95pxgrKn77I4vXMOf$Eya/tZeQXdAzMuzFNbmLeP08d39SKsw07SYPyYysNHU=', NULL, FALSE, 'STD7460', 'kwamboka', 'student7460@example.com', FALSE, TRUE, '2026-01-14 05:02:48.621077', 'Nevian'),
  (1133, 'pbkdf2_sha256$1000000$WDi2AuamhgUvXvyJ1jngQG$QKaQxkVD7/2bsGvICm0mNaqlwtn6Qptxy81mMpAgIJI=', NULL, FALSE, 'STD7090', 'mercy', 'student7090@example.com', FALSE, TRUE, '2026-01-14 05:02:50.033501', 'Arianna'),
  (1134, 'pbkdf2_sha256$1000000$9avbENzMPxC7RulD8SM7U2$b432VaV1PJwG8y7eJUo7BvFIb3MrfcboXwqDHgRH92s=', NULL, FALSE, 'STD7064', 'wambui', 'student7064@example.com', FALSE, TRUE, '2026-01-14 05:02:51.683882', 'Snowie'),
  (1135, 'pbkdf2_sha256$1000000$CsgNOANGGzFKt6KQbBpMrc$CgLHk8BQhbwOO8+ex/l0/eu2PpMEcGYO5oJOj7Hhawo=', NULL, FALSE, 'STD7078', 'naiyoma', 'student7078@example.com', FALSE, TRUE, '2026-01-14 05:02:53.228200', 'Achsa'),
  (1136, 'pbkdf2_sha256$1000000$bFvpWkP81Tl4ReDCtb36Xg$Joq3DBkynbcnO+gj9Fo5Gte3RNOjI1kikr2Y7jGdERs=', NULL, FALSE, 'STD7533', 'nyiva', 'student7533@example.com', FALSE, TRUE, '2026-01-14 05:02:54.635162', 'Grace'),
  (1137, 'pbkdf2_sha256$1000000$fukOepyYkz9jdaqJEzbAPn$6vFtbjab3CuHTfOXUjWk+vKqw+F8T0lfV2cyyOdJD/I=', NULL, FALSE, 'STD7169', 'mwende', 'student7169@example.com', FALSE, TRUE, '2026-01-14 05:02:56.286025', 'caroline'),
  (1138, 'pbkdf2_sha256$1000000$oF1HvvF1P55QgiRPcVbVQE$JjBw14LFBmUAdjxmjHHC3X7r0m4SEprCM5R8VyAYL7s=', NULL, FALSE, 'STD7012', 'wangui', 'student7012@example.com', FALSE, TRUE, '2026-01-14 05:02:57.852987', 'Abigael'),
  (1139, 'pbkdf2_sha256$1000000$GninqKqhIxmN0JNfbVflRz$BY2AW8a5aPjf3kknhu0HhR/vMmtp7BYNLYj4toxeKCE=', NULL, FALSE, 'STD7327', 'Bliss wangari', 'student7327@example.com', FALSE, TRUE, '2026-01-14 05:02:59.258157', 'Stella'),
  (1140, 'pbkdf2_sha256$1000000$WYtmJ6cQswW2XZA0xheI8d$ziU1okniRHlrKTYFnRH/K7Id9l4TZuL9ZSip78p5W5w=', NULL, FALSE, 'STD7463', 'Ryan mwenda', 'student7463@example.com', FALSE, TRUE, '2026-01-14 05:03:00.947423', 'Victor'),
  (1141, 'pbkdf2_sha256$1000000$SWcrg7ALqOCmXhwtxzPGYQ$L3su9asJ4mB9R3a01n1LsUMcqofHnWguNoy92tKOejQ=', NULL, FALSE, 'STD7506', 'Paul fundi', 'student7506@example.com', FALSE, TRUE, '2026-01-14 05:03:02.692369', 'Godwill'),
  (1142, 'pbkdf2_sha256$1000000$uhoSx02iVxNGWXeFjo5sk0$EKj5WUAFtKmxA+O2R88dXzXohWGt+URoHh5tJUpIyEk=', NULL, FALSE, 'STD7173', 'mulinge', 'student7173@example.com', FALSE, TRUE, '2026-01-14 05:03:04.118928', 'Boniface'),
  (1143, 'pbkdf2_sha256$1000000$EEimQMC2s818gRD97prT8h$bpkSx7H4xpotyz9GgLMYEd3YyxlwLaMWz3ylaLOOiUo=', NULL, FALSE, 'STD7715', 'musyoki', 'student7715@example.com', FALSE, TRUE, '2026-01-14 05:03:05.726016', 'Nathan'),
  (1144, 'pbkdf2_sha256$1000000$kp9clum20gzTQGbe3ODFv9$nUiOreMeWAwPth5lD+pHpBcpua6iB+zC+hwv9EQlwvE=', NULL, FALSE, 'STD7317', 'amanya', 'student7317@example.com', FALSE, TRUE, '2026-01-14 05:03:07.336385', 'Amarah'),
  (1145, 'pbkdf2_sha256$1000000$IOmrzKjGfEKHM6R5tGUm81$gBWA/z3DvQUV5+fjDrX6MdrhqGAOP+S9TkEMLpTc9SA=', NULL, FALSE, 'STD7474', 'Muthoni', 'student7474@example.com', FALSE, TRUE, '2026-01-14 05:03:08.802909', 'Delaney'),
  (1146, 'pbkdf2_sha256$1000000$zL2V8Ddx0MrNkxVSjwosX1$PrqhhmTyWHYQKPxx2upwSr8Q34FBsLx0fE7nj480V2g=', NULL, FALSE, 'STD7579', 'wasimbi', 'student7579@example.com', FALSE, TRUE, '2026-01-14 05:03:10.413700', 'Griffins'),
  (1147, 'pbkdf2_sha256$1000000$hJvSfrEB7AiJSeUZelWtxe$So5DZAJv7MTuT21rAQhCZ0QBwaPsDBCRcx1Cy5JxxSk=', NULL, FALSE, 'STD7018', 'kamau', 'student7018@example.com', FALSE, TRUE, '2026-01-14 05:03:12.055145', 'Alvin'),
  (1148, 'pbkdf2_sha256$1000000$2sPQHTLkSUARgUvXluvT3I$h1u6ltZDd2aHUlfRbbXC1X5iYIWT2ToxeGxY/1jAEik=', NULL, FALSE, 'STD7098', 'wathari', 'student7098@example.com', FALSE, TRUE, '2026-01-14 05:03:13.437828', 'Jayden'),
  (1149, 'pbkdf2_sha256$1000000$2a6quWXyz6yV3WNtbUZo8w$4I9jFZC7EpDSOnhlkcc+ztOi7c7XKup1hBBlGgNdqoM=', NULL, FALSE, 'STD7504', 'Odongo', 'student7504@example.com', FALSE, TRUE, '2026-01-14 05:03:15.192309', 'Sabenzia'),
  (1150, 'pbkdf2_sha256$1000000$9nO23aZrefnjgOYluK7f3z$3cL1+wy+hvHXiE9F4NLKeKNbFV8BRGl1fWiOGJR3LDQ=', NULL, FALSE, 'STD7503', 'Akoth', 'student7503@example.com', FALSE, TRUE, '2026-01-14 05:03:16.811185', 'Esther'),
  (1151, 'pbkdf2_sha256$1000000$2Fu290oxxxn5dsVZsXjYZW$9LW1bWzp+nxd6MFy+u+gh5pYWnTSFD4YmorTYiY1/Ik=', NULL, FALSE, 'STD7005', 'murugu', 'student7005@example.com', FALSE, TRUE, '2026-01-14 05:03:18.856415', 'Jeremy'),
  (1152, 'pbkdf2_sha256$1000000$i2mDWHnmtLvIwdPO33rmJ3$vvqkYbFuzgZsZZZu3JNp6MIFl9019VvBxi0EgLf5l0U=', NULL, FALSE, 'STD7096', 'Muthomi', 'student7096@example.com', FALSE, TRUE, '2026-01-14 05:03:20.495474', 'Ezra'),
  (1153, 'pbkdf2_sha256$1000000$Ph8ywZwvK1GWwDC9JAyDj7$tJuZ9qej8eMIM9aCuiTXLLy02VBSZ5GrrJC8mYfJckY=', NULL, FALSE, 'STD7191', 'Romain', 'student7191@example.com', FALSE, TRUE, '2026-01-14 05:03:21.897105', 'Harvey'),
  (1154, 'pbkdf2_sha256$1000000$M8QLwRuOr49y3TRklpVHya$2Yeg3I61f2iEKA9rBv0IP3vKyj+PVh0mFnWEq657rw0=', NULL, FALSE, 'STD7095', 'Mulandi', 'student7095@example.com', FALSE, TRUE, '2026-01-14 05:03:23.523464', 'Nathaniel'),
  (1155, 'pbkdf2_sha256$1000000$F3xgSsSgictHs1pUbt0B5x$esa2hyLMIuRSqn5femWK/Yp6hevZbEZP1+yr+xkCK5E=', NULL, FALSE, 'STD7010', 'ndungu', 'student7010@example.com', FALSE, TRUE, '2026-01-14 05:03:25.109832', 'Melvin'),
  (1156, 'pbkdf2_sha256$1000000$QmSBnHSNd43KEtJayXckP1$AoNEn6191yWU0o3PCGCJUC2LzawvuSUbcinSAEfe/cs=', NULL, FALSE, 'STD7007', 'njeri', 'student7007@example.com', FALSE, TRUE, '2026-01-14 05:03:26.498509', 'Lilian'),
  (1157, 'pbkdf2_sha256$1000000$J36bhSwIm9QIlAtUN7jypr$ySOatOy8q5nv1EQ+JcK/Fe/vVt3cq0dxszHXYKc9Rb8=', NULL, FALSE, 'STD7019', 'Muthoni', 'student7019@example.com', FALSE, TRUE, '2026-01-14 05:03:27.987642', 'Belinda'),
  (1158, 'pbkdf2_sha256$1000000$0264ssh9CC9tB5GnKhTjt4$0DtRrk3EhzVcI1twtoIOoGQqvsggw2w9otD5ohyEXFA=', NULL, FALSE, 'STD7398', 'Natasha', 'student7398@example.com', FALSE, TRUE, '2026-01-14 05:03:29.596508', 'Caren'),
  (1159, 'pbkdf2_sha256$1000000$1NLgmMYK8i4zYRBR9tAblG$4q3SXAPcb3fur4Vcuww2thjUmbhAq3agB8PgWzo6I5g=', NULL, FALSE, 'STD7055', 'Ayieta', 'student7055@example.com', FALSE, TRUE, '2026-01-14 05:03:31.086991', 'Ivy'),
  (1160, 'pbkdf2_sha256$1000000$DPt7dhvPZX1t6gU3x8N6fC$+6kzCuJg7mNBk/2yeiqmkH7HNPi6kggspH/mxFx/8HM=', NULL, FALSE, 'STD7197', 'Wangari', 'student7197@example.com', FALSE, TRUE, '2026-01-14 05:03:32.749271', 'Elsie'),
  (1161, 'pbkdf2_sha256$1000000$L9kcAIAnfWuBNltesS16X3$tCnh4hwOtLglFNUQhkmPTfsLt1rw8fwUsZPc7w9931s=', NULL, FALSE, 'STD7207', 'Ariana', 'student7207@example.com', FALSE, TRUE, '2026-01-14 05:03:34.547757', 'Kourtney'),
  (1162, 'pbkdf2_sha256$1000000$umJYxS3xHhmV6E2YWx3izW$lnvJRB3iSfFaS8Bo2jr6hhRrqNgHoMGh1dhhn0KPAK8=', NULL, FALSE, 'STD7395', 'favour', 'student7395@example.com', FALSE, TRUE, '2026-01-14 05:03:35.934792', 'Deborah'),
  (1163, 'pbkdf2_sha256$1000000$BIeHxucEHPrecyqlYvbua1$iRF7s1gUWi6K3OZuPys71BevZFpzEr7GrxDpu+KMLG8=', NULL, FALSE, 'STD7291', 'Wambui m', 'student7291@example.com', FALSE, TRUE, '2026-01-14 05:03:37.520769', 'Susan')
ON CONFLICT DO NOTHING;
INSERT INTO "auth_user" ("id", "password", "last_login", "is_superuser", "username", "last_name", "email", "is_staff", "is_active", "date_joined", "first_name") VALUES
  (1164, 'pbkdf2_sha256$1000000$fnJ6oqECCaMPzqk6t7HOVR$hfJDnXyNxr/TcBp6irldqCFSKDFRM7QZ3eNkw8mjTtA=', NULL, FALSE, 'STD7427', 'Amanya', 'student7427@example.com', FALSE, TRUE, '2026-01-14 05:03:39.048643', 'Shirniece'),
  (1165, 'pbkdf2_sha256$1000000$Acc1XLLi8iQ0mdy5I14wjO$AIyD/lSHxYlxqyz0YrDVCcjYx4OGvxda8zXcIFSuw+g=', NULL, FALSE, 'STD7234', 'Njambi', 'student7234@example.com', FALSE, TRUE, '2026-01-14 05:03:40.470230', 'Blessing'),
  (1166, 'pbkdf2_sha256$1000000$2zQCCgiBp1hRfrdNshuyeX$9SlR8qLvTkGd7LAVs/ixO16XVibEvzJn3G32BjhmILM=', NULL, FALSE, 'STD7196_2', 'shadia Njeri', 'student7196_2@example.com', FALSE, TRUE, '2026-01-14 05:03:42.044956', 'Lilly'),
  (1167, 'pbkdf2_sha256$1000000$YPxYNosd8Zz3KqCAmGyMbT$VF6/xAywMsk0E1Ar7r+tZKvleGbD1wJ7LgjIFt8VnGU=', NULL, FALSE, 'STD7023', 'koki', 'student7023@example.com', FALSE, TRUE, '2026-01-14 05:03:43.712374', 'Mitchell'),
  (1168, 'pbkdf2_sha256$1000000$YyxuZlCIvGy1O3LzpEkd6p$MCywc/P7sotoLPwXNFF3nYWhqTThepo5FevX1o8dIi4=', NULL, FALSE, 'STD7017', 'Wairimu', 'student7017@example.com', FALSE, TRUE, '2026-01-14 05:03:45.207175', 'Princess'),
  (1169, 'pbkdf2_sha256$1000000$2vqN2Bv8kDPWmkeyYtPjJ9$TFneF47DiwSB6eaVyAeNGcKPc8MVlx+Lca4ls6UL6Hk=', NULL, FALSE, 'STD7445', 'njeri', 'student7445@example.com', FALSE, TRUE, '2026-01-14 05:03:47.200371', 'Faith'),
  (1170, 'pbkdf2_sha256$1000000$va86LEQKP220UuyK1nAgDa$pM+mdohbn76V2PIzc1Bgm2bRAZ3+yUvoiAGDIGJxFFs=', NULL, FALSE, 'STD7022', 'Njeri Njoroge', 'student7022@example.com', FALSE, TRUE, '2026-01-14 05:03:48.789934', 'Annet'),
  (1171, 'pbkdf2_sha256$1000000$Bs5SH5EqIUyLWFZraw1yHA$eEZnjEMMESeBaT9SV+kTh7ihZG/4pF9R17T4zQbeHec=', NULL, FALSE, 'STD7516', 'munyiru', 'student7516@example.com', FALSE, TRUE, '2026-01-14 05:03:50.403756', 'Chalcedony'),
  (1172, 'pbkdf2_sha256$1000000$afsAdIeIQIoCYXQSKmtchJ$dqkjzuKuPil0iOpQ7TJ6bmqoln4YMmaZCOLDKyxM764=', NULL, FALSE, 'STD7008_2', 'wanjiru', 'student7008_2@example.com', FALSE, TRUE, '2026-01-14 05:03:52.093009', 'Shekinah'),
  (1173, 'pbkdf2_sha256$1000000$8IYbC4A47DKq68Ys8k9TjF$yUbH9eLyHMdS4+aTgUeRBEQlHVRm7zNEUTqGcmnH+dA=', NULL, FALSE, 'STD7032', 'Wambui', 'student7032@example.com', FALSE, TRUE, '2026-01-14 05:03:53.780750', 'Chloe'),
  (1174, 'pbkdf2_sha256$1000000$szQJ5OpzZboTy5sShTcCIZ$6RR6kiPPNn98vUHW0pKtt4m6Qx72Eq4EYPCc9/2BkIA=', NULL, FALSE, 'STD7025', 'gathoni', 'student7025@example.com', FALSE, TRUE, '2026-01-14 05:03:55.130369', 'Blessings'),
  (1175, 'pbkdf2_sha256$1000000$X5IPFwwhCHj5wjFS8MqKt3$TMi25hSnK/aviY/odPc6yW/an+510m6n3OflBu+nWkU=', NULL, FALSE, 'STD7369', 'gakii', 'student7369@example.com', FALSE, TRUE, '2026-01-14 05:03:56.685184', 'Ednah'),
  (1176, 'pbkdf2_sha256$1000000$HqJToqOTJzaYaU4Ag7L8GJ$5IKtCR5gjumxMQTkpRBrG12grnRWD8x8+x2zYeGmfEI=', NULL, FALSE, 'STD7373', 'gathoni', 'student7373@example.com', FALSE, TRUE, '2026-01-14 05:03:58.315090', 'Mary'),
  (1177, 'pbkdf2_sha256$1000000$eGQjypACIPuvOLjEt6LtTy$7ybfKafzPWDeMNzKXhtBfaWRXwfmQ94iLv6KtIFPAqI=', NULL, FALSE, 'STD7560', 'Ngina Wangari', 'student7560@example.com', FALSE, TRUE, '2026-01-14 05:04:00.186725', 'Angel'),
  (1178, 'pbkdf2_sha256$1000000$0jFitEVkPcmZ0i4CPfULo8$3gBxPIdy6SLpPfBs/XX8nEbMzSvfcM/HC8mMX+xlMY8=', NULL, FALSE, 'STD7004', 'nzilani', 'student7004@example.com', FALSE, TRUE, '2026-01-14 05:04:02.253586', 'Elizabeth'),
  (1179, 'pbkdf2_sha256$1000000$4AH1ysbN0NafCGNaH9affa$qVCPtbw8Cx2xngYFLtPuDLjF/Yc0eGgmkIfaz5U9JxY=', NULL, FALSE, 'STD7014', 'nyokabi', 'student7014@example.com', FALSE, TRUE, '2026-01-14 05:04:04.062550', 'Blessing'),
  (1180, 'pbkdf2_sha256$1000000$4vzcM1g23GyRosReBVClvV$p+6zMGr/WJZnCLVjugeA/GsDn+SWpTxPc4zL31zvV8g=', NULL, FALSE, 'STD7015', 'wamburu', 'student7015@example.com', FALSE, TRUE, '2026-01-14 05:04:05.596311', 'John'),
  (1181, 'pbkdf2_sha256$1000000$qf4GgGzxG62aZebnCAaEjm$xkd5l7BNYuWaLhDfpBoSz0tuzJrQA/Z2EWQJ3huTmoU=', NULL, FALSE, 'STD7104', 'Reign Mulwa', 'student7104@example.com', FALSE, TRUE, '2026-01-14 05:04:07.558445', 'Aristaricho'),
  (1182, 'pbkdf2_sha256$1000000$20uIC31Hho8SosCpIF9Y0t$pxi7/zEmRIpc0wWa/3YfH+MhWhL6wxbRtyX53Iie984=', NULL, FALSE, 'STD7199', 'maina', 'student7199@example.com', FALSE, TRUE, '2026-01-14 05:04:09.250588', 'Jamal'),
  (1183, 'pbkdf2_sha256$1000000$monxadfEkjiMpChI1nqfLN$LB2Fy24FCvnzpv0O8Vn9wFZLdFW3BU9B4dfhcqUmwO4=', NULL, FALSE, 'STD7339', 'junior getachi', 'student7339@example.com', FALSE, TRUE, '2026-01-14 05:04:11.114983', 'Sam'),
  (1184, 'pbkdf2_sha256$1000000$Q1O8qR8GOOp2ke0GCe5HBK$KTNbvc6GqyJAovcw01zgoiUuxpNNRrSs8Vm1qIrQU6w=', NULL, FALSE, 'STD7003', 'Kariithi', 'student7003@example.com', FALSE, TRUE, '2026-01-14 05:04:13.001029', 'Jeremy'),
  (1185, 'pbkdf2_sha256$1000000$obvIkk7QpmH0kjL5Kf1nnH$b+TQOY+DNvF1aXOfiIG8f2HzjgSlTfdZD7dFkIultAY=', NULL, FALSE, 'STD7630', 'mubiru', 'student7630@example.com', FALSE, TRUE, '2026-01-14 05:04:14.891858', 'Asiel'),
  (1186, 'pbkdf2_sha256$1000000$FvjPqmKUHqZSrNK4WSYrsL$Qa5rxLml/RQ3dCcRbWXABwTb6CMPRlz2moXcjyuAqB8=', NULL, FALSE, 'STD7027', 'gitau', 'student7027@example.com', FALSE, TRUE, '2026-01-14 05:04:17.159138', 'Caesar'),
  (1187, 'pbkdf2_sha256$1000000$zj9hloaiF0XkdjFAq782DR$gbXL8hy8oZLeRCo45HBnJ5zeGqriT/S/MxjluZ6pQxo=', NULL, FALSE, 'STD7212', 'mbae', 'student7212@example.com', FALSE, TRUE, '2026-01-14 05:04:18.874869', 'Leon'),
  (1188, 'pbkdf2_sha256$1000000$YvlKKlk5N0HGvgrOG05IAh$JTiNpYcaK/Xf8+YhLvbmWfzpDpYrtH3zJ1nSCIMnmxE=', NULL, FALSE, 'STD7577', 'wangari', 'student7577@example.com', FALSE, TRUE, '2026-01-14 05:04:20.369229', 'Mary'),
  (1189, 'pbkdf2_sha256$1000000$EifkvH4kK8qsGagxpWud2V$IXF9ozGhlHz594ObGkRAuQypNV8PVciD5jKdEY3QI/Y=', NULL, FALSE, 'STD7534', 'mutua', 'student7534@example.com', FALSE, TRUE, '2026-01-14 05:04:21.905035', 'James'),
  (1190, 'pbkdf2_sha256$1000000$cfHbWXSjSmtAUiIntfZ0G4$tlt1x9ZlkY1lmgvhECUnesmJW5e8lDjG/P4QpmLEFF8=', NULL, FALSE, 'STD7392', 'Wambui', 'student7392@example.com', FALSE, TRUE, '2026-01-14 05:04:23.486603', 'Lavinia'),
  (1191, 'pbkdf2_sha256$1000000$2uSVMMcv4t1UlD8xoQyCl4$ZZKo3CNtSWkE5bLC8TG/ybKvZA9iOqdt1PiNvbJJ1Ns=', NULL, FALSE, 'STD7001', 'makau', 'student7001@example.com', FALSE, TRUE, '2026-01-14 05:04:24.890805', 'Joshua'),
  (1192, 'pbkdf2_sha256$1000000$gOtHGDKd3WMIm0020R2fo4$g4DFmQB/MMC0Xl+ir9XkPV3V/zApwozlxZlC1ofCKTk=', NULL, FALSE, 'STD7403', 'Njambi', 'student7403@example.com', FALSE, TRUE, '2026-01-14 05:04:26.680043', 'Zoe'),
  (1193, 'pbkdf2_sha256$1000000$NcboHyajcN4ScptSH7Xfze$cYCP2qIt9GeNgaQGQ+tGt8PQFRartX6kvWJuCA0b1/c=', NULL, FALSE, 'STD7591', 'nyambura', 'student7591@example.com', FALSE, TRUE, '2026-01-14 05:04:28.290279', 'Irene'),
  (1194, 'pbkdf2_sha256$1000000$ucJCJxnuMj2aJvzBTcViFH$9+BUVPkesU5o9iHjnFNtsBmYQbGS8YwHuvjxodXBfMI=', NULL, FALSE, 'STD7034', 'mugo', 'student7034@example.com', FALSE, TRUE, '2026-01-14 05:04:29.711161', 'Kennedy'),
  (1195, 'pbkdf2_sha256$1000000$7YeXUSfRQV6CPnqUduJyv0$SbRDA1SFXtK8B0tGj4uoYC6cHzieJTIdYKtxBVQypis=', NULL, FALSE, 'STD7208', 'kalondu', 'student7208@example.com', FALSE, TRUE, '2026-01-14 05:04:31.543840', 'Corazon'),
  (1196, 'pbkdf2_sha256$1000000$gbiaS68lyfdbXfhHzSo27w$FtkrVHWE5FEzAdoCokNCVfDmomZLYlwUJkSSQCs5J+0=', NULL, FALSE, 'STD7031', 'Njeri', 'student7031@example.com', FALSE, TRUE, '2026-01-14 05:04:33.448827', 'Terryann'),
  (1197, 'pbkdf2_sha256$1000000$iE6t2uJKXLph9QKMLhJ0bF$/CuIg5SDiZiwjv93bXbYNqL94WLWwP7Vf4eNKc4JEAY=', NULL, FALSE, 'STD7228', 'wanjiru mwaura', 'student7228@example.com', FALSE, TRUE, '2026-01-14 05:04:35.193899', 'Shaleen'),
  (1198, 'pbkdf2_sha256$1000000$WwYKSNqWvPxuU4rUkJGtMG$IGT41dBs6j1txUEQ1YrJ+9ZHDXxp24/9feF+D28JFgo=', NULL, FALSE, 'STD7319', 'mueni', 'student7319@example.com', FALSE, TRUE, '2026-01-14 05:04:37.096009', 'Joy'),
  (1199, 'pbkdf2_sha256$1000000$8LxZsWP4QCSdXfmMns1EN6$A2r90DBLYQIe5dO6tf1wjn2Tqrz7zrtb65jpn2DEweE=', NULL, FALSE, 'STD7354', 'Wangui', 'student7354@example.com', FALSE, TRUE, '2026-01-14 05:04:41.077974', 'Shaniece'),
  (1200, 'pbkdf2_sha256$1000000$QhPXrR3sxRj6z6JlTJUkDB$u3wK3cZoeB5UVK/didMkDokgK93sgKG3U/Rg9cDKqe4=', NULL, FALSE, 'STD7103', 'mueni', 'student7103@example.com', FALSE, TRUE, '2026-01-14 05:04:43.939382', 'Celestine'),
  (1201, 'pbkdf2_sha256$1000000$c4wCeq4TbnpzT5vaI1CUuk$ZDrO8cSsfyRCZbV9/wdhMLVbpRzp/3e9wvhE7VU09yU=', NULL, FALSE, 'STD7175', 'Muthoni', 'student7175@example.com', FALSE, TRUE, '2026-01-14 05:04:46.854937', 'Immaculate'),
  (1202, 'pbkdf2_sha256$1000000$BRDTAU0C2ttkNnnKFUKUsM$mlMOVd6ZylMLCNqBYz26Q9wqtplIDqlR1jg4N2NYoto=', NULL, FALSE, 'STD7037', 'Wambui', 'student7037@example.com', FALSE, TRUE, '2026-01-14 05:04:49.325438', 'Patience'),
  (1203, 'pbkdf2_sha256$1000000$88T9t7VQewwKn0kipC8Cm3$iVUXBtjmK4F/9+S8Y0I55tYTfmPh83KmpP+Njv4pZas=', NULL, FALSE, 'STD7490', 'mukuhi', 'student7490@example.com', FALSE, TRUE, '2026-01-14 05:04:51.733620', 'Shantel'),
  (1204, 'pbkdf2_sha256$1000000$SNGyWcIhAVVKmosh01x9S0$ViLX17tF/GZ7sxYcQGtWo3xH8As+ZkHbkacA2JccIJU=', NULL, FALSE, 'STD7562', 'maingi', 'student7562@example.com', FALSE, TRUE, '2026-01-14 05:04:54.885941', 'Brandon'),
  (1205, 'pbkdf2_sha256$1000000$xg4TsT3dDwaWoSGamJSl4Y$GiOS/fFQHqBrPwft17YaakBmAyLEAoaDcAXPMvc/bVA=', NULL, FALSE, 'STD7370', 'kabau', 'student7370@example.com', FALSE, TRUE, '2026-01-14 05:04:58.589971', 'Collins'),
  (1206, 'pbkdf2_sha256$1000000$9HHtzY6RSvcAPvfHfr4GQz$KcUDbUL2dRXpGZ7WHW+dYcFSOhQnDL07nFpNVbcVaN8=', NULL, FALSE, 'STD7153', 'Gitau', 'student7153@example.com', FALSE, TRUE, '2026-01-14 05:05:02.468236', 'Sanchez'),
  (1207, 'pbkdf2_sha256$1000000$C3lhmuBqGYoVLyo2LrY46j$79z0EZIPFyd+8J8GcluLmWNa4ZpI3uDm/PTQI8TEwhY=', NULL, FALSE, 'STD7375', 'Kiage', 'student7375@example.com', FALSE, TRUE, '2026-01-14 05:05:04.851932', 'Raymond'),
  (1208, 'pbkdf2_sha256$1000000$KKhINA5ArKCTpSoglFWKuW$aSgLx31oVf9WSGG7SM5iOsRWVM/RH/a3MbSir6flj7g=', NULL, FALSE, 'STD7458', 'munene', 'student7458@example.com', FALSE, TRUE, '2026-01-14 05:05:07.272489', 'Davis'),
  (1209, 'pbkdf2_sha256$1000000$kgxKT1YJF15Rfal3172hB4$4TGpw3nUcI3b66SSRn+aV9d9pHpCr4/oZXhx0KZ8dAg=', NULL, FALSE, 'STD7102', 'Lincoln Kingori', 'student7102@example.com', FALSE, TRUE, '2026-01-14 05:05:10.504210', 'Abraham'),
  (1210, 'pbkdf2_sha256$1000000$cBIuMgvd43ZcjizBAG7Ddl$91ZmnvAdlAn/6IogP0H/GBWsMB4+QWIC6smKl6ZNLZs=', NULL, FALSE, 'STD7361', 'ndede', 'student7361@example.com', FALSE, TRUE, '2026-01-14 05:05:12.629807', 'Ryan'),
  (1211, 'pbkdf2_sha256$1000000$bky99obr1xuuhVKy2xTxLs$c/JNgV4GaHCs47SJxYSU8kC6woyiO4EyZ5pZa9QOL/Y=', NULL, FALSE, 'STD7038', 'were', 'student7038@example.com', FALSE, TRUE, '2026-01-14 05:05:14.990774', 'Hope'),
  (1212, 'pbkdf2_sha256$1000000$rjg6kYLDzULlGRKThrPh3q$PlaykKh2kZIuSwoUGzP+8J2YEAbWXu5OBiAmQffeppc=', NULL, FALSE, 'STD7337', 'wanjiku', 'student7337@example.com', FALSE, TRUE, '2026-01-14 05:05:16.919377', 'Angel'),
  (1213, 'pbkdf2_sha256$1000000$i3owVGiSRb8E6egkrddmfV$PzYAZeUWHFhz1RISwb05ByRwDpExp/pYS6Epvd5ZnJ4=', NULL, FALSE, 'STD7429', 'mwikali', 'student7429@example.com', FALSE, TRUE, '2026-01-14 05:05:19.005665', 'Chloe'),
  (1214, 'pbkdf2_sha256$1000000$8JkYYK7NqF4IqOtiqj6ns3$tLSSOKaocCpA4D+IC2HG4xcWIBH7NlW7GZzfbDDaekQ=', NULL, FALSE, 'STD7230', 'kalekye', 'student7230@example.com', FALSE, TRUE, '2026-01-14 05:05:21.196142', 'Sheilah'),
  (1215, 'pbkdf2_sha256$1000000$pCXHZF0Ff9aNJJbKhup7J2$CR3xyy345AqvQaBlv5mRo8BnwBZBNDTIiVyL38zdPW8=', NULL, FALSE, 'STD7039', 'Luke', 'student7039@example.com', FALSE, TRUE, '2026-01-14 05:05:23.342543', 'Alvin'),
  (1216, 'pbkdf2_sha256$1000000$7e1VI6OMmG0nG3wQdbJRLm$pcjbTqz7U2b/uwe6xorJQNw/8Whjnl6XaVhR87OF1nk=', NULL, FALSE, 'STD7631', 'Ngugi', 'student7631@example.com', FALSE, TRUE, '2026-01-14 05:05:25.278578', 'Alvin'),
  (1217, 'pbkdf2_sha256$1000000$YAMtXKLxOku5VecSon5vQ5$PL9vPAloOcMMRvipLTYR+kGJuabmm6lJWuz9Ym0orfo=', NULL, FALSE, 'STD7044', 'Mukoya', 'student7044@example.com', FALSE, TRUE, '2026-01-14 05:05:27.068485', 'Davian'),
  (1218, 'pbkdf2_sha256$1000000$RsdGrkminnRc7XNDnfMVfv$Hjs4+RNTFw9UipUZ/F33WoTinXndf6kk6ZpjDLqnrTA=', NULL, FALSE, 'STD7576', 'Wekesa', 'student7576@example.com', FALSE, TRUE, '2026-01-14 05:05:28.853515', 'Darius'),
  (1219, 'pbkdf2_sha256$1000000$S5HtR9LFuwOM5GYEXYI5oU$2X9uN8C6nnYdQKR5KbdBP0wPqN9V+bSgE1vTEU2ynqA=', NULL, FALSE, 'STD7266', 'kagema', 'student7266@example.com', FALSE, TRUE, '2026-01-14 05:05:30.770006', 'Godwin'),
  (1220, 'pbkdf2_sha256$1000000$rnxdKTNdhGRPUvsYSS47vk$+3s5hjayRxG+PrL/IPYr5zBRi3AU/tgE8YPrO4xj1Fk=', NULL, FALSE, 'STD7192', 'Rugumi', 'student7192@example.com', FALSE, TRUE, '2026-01-14 05:05:32.383551', 'Kendrick'),
  (1221, 'pbkdf2_sha256$1000000$poBNqdF59qhpxpTgLDcogD$nYlY/2q6MkjHRXef9yRdtP5p+Cyfcq73sSbCDytz99k=', NULL, FALSE, 'STD7040', 'wanjiku', 'student7040@example.com', FALSE, TRUE, '2026-01-14 05:05:34.532779', 'Precious'),
  (1222, 'pbkdf2_sha256$1000000$fJwYTf5s2tdEWVRvMIsGV0$6x9cUUZ8FVjXSPUCm5wdszDgrLmPdrCYjmqW01LY6eU=', NULL, FALSE, 'STD7191_2', 'waithera', 'student7191_2@example.com', FALSE, TRUE, '2026-01-14 05:05:36.493456', 'Nadia'),
  (1223, 'pbkdf2_sha256$1000000$8AKVXS2YsYn6QGvZhQq98q$IdY4yrnKolxzRENSvH8hH899imZ0zy0kFueR2kOVosw=', NULL, FALSE, 'STD7099', 'Njeri', 'student7099@example.com', FALSE, TRUE, '2026-01-14 05:05:38.519130', 'Faith'),
  (1224, 'pbkdf2_sha256$1000000$pup1adYDe3QpHoEjmxy2pA$+bSXj/CTCvIe/wOWfQP7Sk5vki/teAYpIX9/z1AOza4=', NULL, FALSE, 'STD7042', 'Catherine', 'student7042@example.com', FALSE, TRUE, '2026-01-14 05:05:40.294877', 'Precious'),
  (1225, 'pbkdf2_sha256$1000000$oMCdFioyAg8L5DPytxSeDu$PXOQuL7RFZYFBmPWQYs2zOHlf4V1INGk+pGa2rci3mE=', NULL, FALSE, 'STD7394', 'mercy', 'student7394@example.com', FALSE, TRUE, '2026-01-14 05:05:42.264823', 'Angel'),
  (1226, 'pbkdf2_sha256$1000000$hZPuVATICSMeVZKtY7DB6A$Tb9I6vUe1v3KXvt5vN30P+pB+fLpj9AJXnih0XieKfk=', NULL, FALSE, 'STD7434', 'Njambi', 'student7434@example.com', FALSE, TRUE, '2026-01-14 05:05:44.225442', 'Queenstar'),
  (1227, 'pbkdf2_sha256$1000000$jc9iK5mNs3pz708t3enXTw$OEx3hMR4ox577mll9OHL1JRz3JxSjeKL0FzYpZAk6Vs=', NULL, FALSE, 'STD7105', 'mbula', 'student7105@example.com', FALSE, TRUE, '2026-01-14 05:05:46.092954', 'Blessings'),
  (1228, 'pbkdf2_sha256$1000000$MkYzb44QIAdSaD64EVmql8$J8mSdGY/yX1hdkTZ3nFpUjD25Wv2uMBH6k+ZROoksiY=', NULL, FALSE, 'STD7052', 'Waithira', 'student7052@example.com', FALSE, TRUE, '2026-01-14 05:05:47.688202', 'Emmeldah'),
  (1229, 'pbkdf2_sha256$1000000$REpeSDJdKbjsNk5wQQUtxd$JPt2jITV9XpuZjNu6tG8ols4XBgi9+wUDaQbH36YC+I=', NULL, FALSE, 'STD7046', 'waithera', 'student7046@example.com', FALSE, TRUE, '2026-01-14 05:05:49.767203', 'Natasha'),
  (1230, 'pbkdf2_sha256$1000000$fLBb6nZ0BC2WXs26HTrEBc$DCljXIg8ncU2tvAtcd2UC4VHE/HLoh62d8Yl3OPlwKk=', NULL, FALSE, 'STD7171', 'njoki', 'student7171@example.com', FALSE, TRUE, '2026-01-14 05:05:51.625720', 'Abigael'),
  (1231, 'pbkdf2_sha256$1000000$XT7mCCr4XD3cyr0KFijr7U$u5lQ2K2JcSOqPrcfTyQMCFx9S9aPOvBD9h/Edf5fEx8=', NULL, FALSE, 'STD7048', 'Makena', 'student7048@example.com', FALSE, TRUE, '2026-01-14 05:05:53.779995', 'Hope'),
  (1232, 'pbkdf2_sha256$1000000$zi4osfoXCmMnLg0FXLvbtu$mglf4Gy5g9N5YszPrpsHB00sHEIRfTrXRkVveJI8Pfk=', NULL, FALSE, 'STD7444', 'Mungai', 'student7444@example.com', FALSE, TRUE, '2026-01-14 05:05:55.370899', 'Carlos'),
  (1233, 'pbkdf2_sha256$1000000$pT0YVikBF7grIZzr5Q7fnv$C01ItK8gLnMg4fdKlKXgfNLql7RlmsFNIIBxyodOqcg=', NULL, FALSE, 'STD7412', 'Ndegwa', 'student7412@example.com', FALSE, TRUE, '2026-01-14 05:05:56.824164', 'Felix'),
  (1234, 'pbkdf2_sha256$1000000$4Ul3povPQged4RQT1CvuT5$+2WkjhkjH8gFoN5HAPB9t1NNUXK0QIYD4WuU6ml7lFo=', NULL, FALSE, 'STD7051', 'kamau', 'student7051@example.com', FALSE, TRUE, '2026-01-14 05:05:58.472999', 'Maxwell'),
  (1235, 'pbkdf2_sha256$1000000$BSw44DU89Qea63tOacYtGr$hLFn4QebCIYSzKq8mo+OK5mKtZ8YSoRgqkpiTQxPMUo=', NULL, FALSE, 'STD7566', 'kimani', 'student7566@example.com', FALSE, TRUE, '2026-01-14 05:06:00.070726', 'Blessing'),
  (1236, 'pbkdf2_sha256$1000000$Ess4yDAUz2clzygGd9Do3e$MBKceYVxN/tNehTtcGW7VHhsFzRZFIE/7WhLlg40RBs=', NULL, FALSE, 'STD7047', 'odera', 'student7047@example.com', FALSE, TRUE, '2026-01-14 05:06:01.582001', 'Milton'),
  (1237, 'pbkdf2_sha256$1000000$RHSH0DOMChJDLVbR6buOOe$AcGItjCs0DKxIm8yLnkzUS2m9VwoWp61BRzCwHtl7zE=', NULL, FALSE, 'STD7166', 'Karue', 'student7166@example.com', FALSE, TRUE, '2026-01-14 05:06:03.341686', 'Adrian'),
  (1238, 'pbkdf2_sha256$1000000$hB6iChx8yk883FXsfYQW8c$CaGdc14M4zXhRWL4+P4U7XzzEug03fc6GX1SoTsnDTk=', NULL, FALSE, 'STD7641', 'mbatha', 'student7641@example.com', FALSE, TRUE, '2026-01-14 05:06:04.954430', 'Ladasha'),
  (1239, 'pbkdf2_sha256$1000000$vcn3EDv9cdG9npxxNYPS8V$OP12J82CM4OVyr0V6HFdWctdz2IyC5zOdAucJAG7hp0=', NULL, FALSE, 'STD7642', 'mwirigi', 'student7642@example.com', FALSE, TRUE, '2026-01-14 05:06:06.424272', 'Logan-lee'),
  (1240, 'pbkdf2_sha256$1000000$lPYei2BtbOZFaOysBc2Ppq$3zCzDt4QkH+j2AX7j/DK0FOW25SXUg5RVhN6UrHXoM4=', NULL, FALSE, 'STD7643', 'wambua', 'student7643@example.com', FALSE, TRUE, '2026-01-14 05:06:08.079813', 'Magdalene'),
  (1241, 'pbkdf2_sha256$1000000$CZJunZwb0XoIGG1RFEqsN4$h7K94A6H83h71MquoBgJxRzGv9VvkB9BEfxyUAQ3efM=', NULL, FALSE, 'STD7644', 'nyachio', 'student7644@example.com', FALSE, TRUE, '2026-01-14 05:06:10.007747', 'Neymar'),
  (1242, 'pbkdf2_sha256$1000000$5Qn2PlOH58Kg0REr1pTTAy$4MH4DKDpoSTi4q6q4vl3UExxsUTvFDHqpIOehd4OvNs=', NULL, FALSE, 'STD7645', 'munene', 'student7645@example.com', FALSE, TRUE, '2026-01-14 05:06:11.746664', 'Nillan'),
  (1243, 'pbkdf2_sha256$1000000$iNkk0XSiiimQ1vvo6cgE6s$og7tdms7c6Fq3vhaRt2OiDh3IqJVQQd5pqKY9bynNYA=', NULL, FALSE, 'STD7646', 'melia', 'student7646@example.com', FALSE, TRUE, '2026-01-14 05:06:13.634059', 'Atsue'),
  (1244, 'pbkdf2_sha256$1000000$UlUgLDKOar1RcpGrfJoiPs$flly26+lMdcxBcU1mHB1hgBg8FRDLn0jCXWqNhMr0go=', NULL, FALSE, 'STD7647', 'waithera', 'student7647@example.com', FALSE, TRUE, '2026-01-14 05:06:15.351849', 'Erin'),
  (1245, 'pbkdf2_sha256$1000000$vPwKNEfsUoHBOkHuw0Db9S$heGea4pbxKEJO5DW+oFSL2bj+uDvEDXcQXO0xhr7WUs=', NULL, FALSE, 'STD7648', 'Juma', 'student7648@example.com', FALSE, TRUE, '2026-01-14 05:06:16.856206', 'Elsie'),
  (1246, 'pbkdf2_sha256$1000000$TZGnObibbH8koCyCed7Jfl$DxfKwHahKINX9ioiE233U+v0JFCgodGd8gYgaGf8gMI=', NULL, FALSE, 'STD7649', 'mambo', 'student7649@example.com', FALSE, TRUE, '2026-01-14 05:06:18.442641', 'Ethan'),
  (1247, 'pbkdf2_sha256$1000000$EmdOAgCFiomSemPFawyOQy$KGTcnWf5ODkF8qSw/1kq5XgLuXrMP6P4nudbXS7s/O8=', NULL, FALSE, 'STD7650', 'Jabari munene', 'student7650@example.com', FALSE, TRUE, '2026-01-14 05:06:20.035950', 'Edwin'),
  (1248, 'pbkdf2_sha256$1000000$u3oSrXFDaaqMD6T1iMgnLy$tcWFV/5lVQhkOm21TU27WfW/Sp94DgNTjIe3pUYIORM=', NULL, FALSE, 'STD7651', 'maingi', 'student7651@example.com', FALSE, TRUE, '2026-01-14 05:06:22.523034', 'Dalvin'),
  (1249, 'pbkdf2_sha256$1000000$J2dTCMhs6kcijYcTTkPIAA$aMXO1eya2Q5M9f2ATWmzf9acV0jMaUiGHcuwK05c+ok=', NULL, FALSE, 'STD7652', 'kamau', 'student7652@example.com', FALSE, TRUE, '2026-01-14 05:06:24.635554', 'Hillel'),
  (1250, 'pbkdf2_sha256$1000000$CjSeLN0IlS8xZulMu3l0xt$rpdqjB0qTw/sggQm2zRCV2ghbrXmcIzmcCKzxMUtdgk=', NULL, FALSE, 'STD7653', 'Joy', 'student7653@example.com', FALSE, TRUE, '2026-01-14 05:06:26.930668', 'Precious'),
  (1251, 'pbkdf2_sha256$1000000$NumCgSz9bRBUiGNbxk1CNi$xOOPfJlL9DzmvpZ+AnxiCSFoudZ8IZDphA5W3Pkoxq8=', NULL, FALSE, 'STD7654', 'Kamau', 'student7654@example.com', FALSE, TRUE, '2026-01-14 05:06:30.190840', 'Pascal'),
  (1252, 'pbkdf2_sha256$1000000$3MzEt04MN1z5CgIkcw2KrX$2HgKq6j9CssbvbKsGpMNW0lGu9N00h/F6rHZAJIEcIQ=', NULL, FALSE, 'STD7655', 'natania', 'student7655@example.com', FALSE, TRUE, '2026-01-14 05:06:31.962996', 'Kiersten'),
  (1253, 'pbkdf2_sha256$1000000$Et7Qd3DCXAsp4eQ7KJNuAx$qFxsALBLIJRAoP9R5Wtg36flWXgsKz8gGOH/cYg2boU=', NULL, FALSE, 'STD7656', 'm christine', 'student7656@example.com', FALSE, TRUE, '2026-01-14 05:06:33.361921', 'Ethan'),
  (1254, 'pbkdf2_sha256$1000000$BuR9jPkgK6r6KbXKXXfVwV$pphQX58ibBmdW8pofjXS3UkPebTA3Hv0Wqp0CjSyvrc=', NULL, FALSE, 'STD7657', 'wanjiru', 'student7657@example.com', FALSE, TRUE, '2026-01-14 05:06:34.954620', 'Aliciah'),
  (1255, 'pbkdf2_sha256$1000000$hSUEtHV0gz06V3g9V7652z$VDmDAcfCOKRCd4/7aOO5K+4YWnfhLgUzRvJGUxCHeCU=', NULL, FALSE, 'STD7658', 'nyamai', 'student7658@example.com', FALSE, TRUE, '2026-01-14 05:06:36.623603', 'Blessing'),
  (1256, 'pbkdf2_sha256$1000000$g2rZGGfNwKTf14sC48jJLS$y+iN+l+bXmwycRcdcswBQWzEitwAN5PMH3u/VvxVXP4=', NULL, FALSE, 'STD7659', 'Rin', 'student7659@example.com', FALSE, TRUE, '2026-01-14 05:06:38.042443', 'Gia'),
  (1257, 'pbkdf2_sha256$1000000$CWZC3n9i8B2rRxue5z0Hwu$/uLp9XpSH/q0sF6AbpyFV3dY/6HYslcDA21dvOqhn2Y=', NULL, FALSE, 'STD7660', 'mawia', 'student7660@example.com', FALSE, TRUE, '2026-01-14 05:06:39.669187', 'Patience'),
  (1258, 'pbkdf2_sha256$1000000$KV27ldZ7v27EGCVUYOpJVF$RcAxlql5VwU6+pE5x/3CxFSDttOUfZuuQAHqNvabQGI=', NULL, FALSE, 'STD7661', 'wanjiru', 'student7661@example.com', FALSE, TRUE, '2026-01-14 05:06:41.602423', 'Adassah'),
  (1259, 'pbkdf2_sha256$1000000$MgiwhbSLUX9bJn1OV4Ilm7$nLvNhpxqYLI8RpI4I3Z0lW2qqLtM+iVUt1GZ1G4Hfig=', NULL, FALSE, 'STD7662', 'wawira', 'student7662@example.com', FALSE, TRUE, '2026-01-14 05:06:43.360812', 'Gianna'),
  (1260, 'pbkdf2_sha256$1000000$Kbip9T4LdSZGYZ27YRe5fp$ZvVsVC/YXPFiHlMK5N3RzMh1AfYS83hXiUVBcINdg7o=', NULL, FALSE, 'STD7663', 'mutana', 'student7663@example.com', FALSE, TRUE, '2026-01-14 05:06:45.324383', 'Ella'),
  (1261, 'pbkdf2_sha256$1000000$bLFDOg1mdhkZDmi7rdSgR3$y/etqVmXgKQujp2+3GzI1jH++kSHOS9yVBDvp7Bv8Tc=', NULL, FALSE, 'STD7664', 'achieng', 'student7664@example.com', FALSE, TRUE, '2026-01-14 05:06:50.080031', 'Victorlyn'),
  (1262, 'pbkdf2_sha256$1000000$M0dBlC5e9aeDLaJiprK1F1$Zpbj4nGcbQO29c4nJ0iz4myhbyedep8Ribsp+ncG3vg=', NULL, FALSE, 'STD7665', 'Favour', 'student7665@example.com', FALSE, TRUE, '2026-01-14 05:06:53.503970', 'Blessing'),
  (1263, 'pbkdf2_sha256$1000000$KbngS7dzkuoDD7T3NYTcwC$6XmJHOXYRCZg/GNPbfDWsHEwsyUrJUtmcyNWcuw0PJQ=', NULL, FALSE, 'STD7666', 'waeni', 'student7666@example.com', FALSE, TRUE, '2026-01-14 05:06:57.556741', 'Faith'),
  (1264, 'pbkdf2_sha256$1000000$CtZAMjf7XHR9Du6ilts28s$AvGrJv0bey5DD2bJJ/vmD3XiDnCTd9aItNcXVrIyeew=', NULL, FALSE, 'STD7667', 'Harrier', 'student7667@example.com', FALSE, TRUE, '2026-01-14 05:07:00.186394', 'Lindsey'),
  (1265, 'pbkdf2_sha256$1000000$RhhfwrNP024e8wPULKVimD$KtJrondJlw7/udTTL/Z2m0cMmhNFhzKwTU7fbSWDHS8=', NULL, FALSE, 'STD7668', 'Wambui', 'student7668@example.com', FALSE, TRUE, '2026-01-14 05:07:02.665777', 'Kelcy'),
  (1266, 'pbkdf2_sha256$1000000$Yd8hGp8Mp67iezMNPbEkqd$X9t1disgZRfRWIASXukokZXpE1SSi9JYgsUt8Q4PE68=', NULL, FALSE, 'STD7669', 'wakanyi', 'student7669@example.com', FALSE, TRUE, '2026-01-14 05:07:06.896978', 'Phoebe'),
  (1267, 'pbkdf2_sha256$1000000$b5DEBExVOIBBSfdHZXVQKJ$y9To48muW5W7m8klU72YZudfNSveDqBfUN7Bdt2cTsY=', NULL, FALSE, 'STD7670', 'mutuku', 'student7670@example.com', FALSE, TRUE, '2026-01-14 05:07:09.349969', 'Liam'),
  (1268, 'pbkdf2_sha256$1000000$SNEmQJCn7Q3zl68p4utB5t$qZqtJPj84AZ/Hxxi/NhYylIW80/MBlmokCH3io//eZE=', NULL, FALSE, 'STD7671', 'nduta', 'student7671@example.com', FALSE, TRUE, '2026-01-14 05:07:11.997026', 'Shantel'),
  (1269, 'pbkdf2_sha256$1000000$oe4Mqhk1CAFcJHeWprUgm0$YHq4rz02ML07D6iqUC1p/SQJdPvWm1P98SZ2HI+9hh4=', NULL, FALSE, 'STD7672', 'Ibrahim', 'student7672@example.com', FALSE, TRUE, '2026-01-14 05:07:14.016690', 'Munira'),
  (1270, 'pbkdf2_sha256$1000000$ONeUqit58W7iPfJj9hr42N$yRc/2gSIRvLE/Tnfvl9gPZsCfhLgfi7splNopx9jHkY=', NULL, FALSE, 'STD7673', 'hamisi Joseph', 'student7673@example.com', FALSE, TRUE, '2026-01-14 05:07:16.457009', 'Travis'),
  (1271, 'pbkdf2_sha256$1000000$SDHc5YAJXYeDo9O6waSZXZ$Zf0z809ZQf6NbxEVypjS22DaShoPVCeXh2RcOXsWgq0=', NULL, FALSE, 'STD7674', 'mwikali', 'student7674@example.com', FALSE, TRUE, '2026-01-14 05:07:18.833761', 'Princess'),
  (1272, 'pbkdf2_sha256$1000000$0wF6ZFWuXPUEdF2GXuUwA8$lmzIMxyJusqLG3AtJ27G2zjlP8B41eMuCiPZxvkY/WA=', NULL, FALSE, 'STD7675', 'Wambui', 'student7675@example.com', FALSE, TRUE, '2026-01-14 05:07:21.014440', 'Abigael'),
  (1273, 'pbkdf2_sha256$1000000$kx0Fsc2OiBxmCXE7wzITWk$h6SHpuAd/j2CTJHS6z9L9nFeRwdgfTGEMmk0eQ8Oi+s=', NULL, FALSE, 'STD7676', 'ndungu', 'student7676@example.com', FALSE, TRUE, '2026-01-14 05:07:23.267402', 'Kieran'),
  (1274, 'pbkdf2_sha256$1000000$EeZGkj4kBuixRtegvd7TGg$u8ODS9oXa1WbxbDxKJMM/8gOToC0Ik1EopN/ui+N8sc=', NULL, FALSE, 'STD7677', 'muuo', 'student7677@example.com', FALSE, TRUE, '2026-01-14 05:07:25.272231', 'Caleb'),
  (1275, 'pbkdf2_sha256$1000000$80aXi69DaivXqgkhPcgkdl$2rU3Iu3r+SOYqC7blRvoe/2gtrYm3NYlehl2ideALyc=', NULL, FALSE, 'STD7678', 'mumo', 'student7678@example.com', FALSE, TRUE, '2026-01-14 05:07:28.076887', 'Emmanuel'),
  (1276, 'pbkdf2_sha256$1000000$f7e87BZiqcMFEXytkC0aht$ebmOdxM0xrAI9K2amwPEHXiPk5LQ9FFxK441rrelPw4=', NULL, FALSE, 'STD7679', 'kenan', 'student7679@example.com', FALSE, TRUE, '2026-01-14 05:07:30.139253', 'Alexander'),
  (1277, 'pbkdf2_sha256$1000000$6EigCCRnV3vJdqeNbbtEoM$rcT2PgQRaA5u8pT9qKt3/lbDvl3tVEQ8QiIaQlTBBuo=', NULL, FALSE, 'STD7680', 'fadhili', 'student7680@example.com', FALSE, TRUE, '2026-01-14 05:07:33.502805', 'Glen'),
  (1278, 'pbkdf2_sha256$1000000$JCaicTorpcPjJ8cWrSTbci$q1UpO4W5CcBJUeaA7fmtFC2h6s3rWxqf9/qp78ej8Ts=', NULL, FALSE, 'STD7681', 'mutana', 'student7681@example.com', FALSE, TRUE, '2026-01-14 05:07:35.890921', 'Ella'),
  (1279, 'pbkdf2_sha256$1000000$95oQi0ZD4gwHFJosTxCXAZ$9omKnIhvFxal3ApxL+PM709UmN/LOF8lXOrz/22IYz4=', NULL, FALSE, 'STD7682', 'mbugua', 'student7682@example.com', FALSE, TRUE, '2026-01-14 05:07:38.529567', 'Sydney'),
  (1280, 'pbkdf2_sha256$1000000$9Lt87FmXo1ScBMqIAQaopl$bzx3p24IfJq13BZdFHuacs0UEI6o3dkR+m+Zch83mfY=', NULL, FALSE, 'STD7683', 'nyambura', 'student7683@example.com', FALSE, TRUE, '2026-01-14 05:07:40.827594', 'Ricca'),
  (1281, 'pbkdf2_sha256$1000000$uGi9t3MnYccBfzxXFAVZET$Gm2NbaV0XKRu1BaSoXkxmGFl/oZy6cYokpIGXtuGOn8=', NULL, FALSE, 'STD7684', 'Reigns', 'student7684@example.com', FALSE, TRUE, '2026-01-14 05:07:43.249653', 'Gian'),
  (1282, 'pbkdf2_sha256$1000000$iStrjtOW4dDOz7ZseSVNWE$4GQbjkj5t+PBSZgWcq4EeA+WKLdEzu0X5v0Ysd4ZNEQ=', NULL, FALSE, 'STD7685', 'Peter', 'student7685@example.com', FALSE, TRUE, '2026-01-14 05:07:45.269433', 'Anywil'),
  (1283, 'pbkdf2_sha256$1000000$UGPCoNC4z9f1PSY9UjwFBf$n8Ql+4OBqsnp7ZGKgj9Az2AOAp4wGIif6X3h6qS+gSo=', NULL, FALSE, 'STD7686', 'mutheu', 'student7686@example.com', FALSE, TRUE, '2026-01-14 05:07:47.521094', 'Blessing'),
  (1284, 'pbkdf2_sha256$1000000$KsoxUzskVcSHenONjV2OOD$O0Zuw1/V9Zgq5gHLzpRkj4QPXRWGs9DE+Fn9rcV+lOo=', NULL, FALSE, 'STD7687', 'chege', 'student7687@example.com', FALSE, TRUE, '2026-01-14 05:07:50.318020', 'Gaddiel'),
  (1285, 'pbkdf2_sha256$1000000$qA4J2abqgSehLMzYXHDibQ$+HRLlqbK2xQooMRNMu7IP6ELjvQ33j6tsIMcmzIwtd0=', NULL, FALSE, 'STD7688', 'Reign', 'student7688@example.com', FALSE, TRUE, '2026-01-14 05:07:56.073957', 'Russel'),
  (1286, 'pbkdf2_sha256$1000000$lhg1mRFqurXSbGQTs3BXn4$sPpFvG9N6467yvQFc1HCTuwmySiP3vRnUSin3aSms04=', NULL, FALSE, 'STD7689', 'Muthoni', 'student7689@example.com', FALSE, TRUE, '2026-01-14 05:08:00.474924', 'Octavia'),
  (1287, 'pbkdf2_sha256$1000000$oiqXvHBYMEpW7y1i8913RF$v60tEIonw0QIF2gg8Hg1+iPVeDjReceJOEEkh+s/rxg=', NULL, FALSE, 'STD7690', 'mueni', 'student7690@example.com', FALSE, TRUE, '2026-01-14 05:08:02.985687', 'Sharon'),
  (1288, 'pbkdf2_sha256$1000000$MaWArq8FQPr6ox1LZHluB7$aFM+UzBMXVt5YYkFuNcMypLhmYy5MFoxeZ7j4Gr+Uz0=', NULL, FALSE, 'STD7691', 'Nzioka', 'student7691@example.com', FALSE, TRUE, '2026-01-14 05:08:05.744396', 'Gift'),
  (1289, 'pbkdf2_sha256$1000000$gS8P3e5Z8Lmnc8Ix1FUqEy$LJQVuiA1846dN8V1yuSC/pB4STTgd/t394P/Fa+npig=', NULL, FALSE, 'STD7692', 'Ibrahim', 'student7692@example.com', FALSE, TRUE, '2026-01-14 05:08:08.191269', 'Azra'),
  (1290, 'pbkdf2_sha256$1000000$Akmd3H3pSgcf9ateaz4RIS$P0dIasI30GboMu7ZbCj1fz5CrMccoQXIksBcTplIgNA=', NULL, FALSE, 'STD7693', 'Ganza', 'student7693@example.com', FALSE, TRUE, '2026-01-14 05:08:10.671255', 'Amizero'),
  (1291, 'pbkdf2_sha256$1000000$QrD9hRW9O7fuIgvzLMTHv9$2dsiJ7lIqo7CUxZz3eP/4msDZb1sQzyw8/FiX7BbzKc=', NULL, FALSE, 'STD7694', 'kanyuguta', 'student7694@example.com', FALSE, TRUE, '2026-01-14 05:08:13.095727', 'Leon'),
  (1292, 'pbkdf2_sha256$1000000$8hKltNpW4EXswqlpWKFaJv$i5ijkueHExVlnokEI8mP3MugO6YWC5aN4mwcdbA9TZ4=', NULL, FALSE, 'STD7695', 'natsami', 'student7695@example.com', FALSE, TRUE, '2026-01-14 05:08:14.832066', 'Delmax'),
  (1293, 'pbkdf2_sha256$1000000$fsb5wHzXpImfrN8nl6Vb49$GEK1l9EH+qqmp327eWMuc3A74m2990ywbnYgi6jJ5sc=', NULL, FALSE, 'STD7696', 'Muthoni', 'student7696@example.com', FALSE, TRUE, '2026-01-14 05:08:16.570434', 'Jane'),
  (1294, 'pbkdf2_sha256$1000000$kMj2eMhRH54eWbFTkbZ2Q5$9prlcjFgPPxOBmoPSCJfPeCSs5dKR4FJaQZpvfF7QcU=', NULL, FALSE, 'STD7697', 'Aluoch', 'student7697@example.com', FALSE, TRUE, '2026-01-14 05:08:19.685969', 'Grasher'),
  (1295, 'pbkdf2_sha256$1000000$4Zu8GnfKI9vsARFK37V7Vn$k1z6BjGKPX1LNbW0lmOZ41EcnFDISePuXy2Gin75yAc=', NULL, FALSE, 'STD7698', 'Kamau', 'student7698@example.com', FALSE, TRUE, '2026-01-14 05:08:24.888002', 'Dylan'),
  (1296, 'pbkdf2_sha256$1000000$TL8D5wKruflAwssG1f11Ft$lUQKGqUOPWVYS3U46TziqNEdQzRaafeXJllcdKvJV9c=', NULL, FALSE, 'STD7699', 'Kyalo', 'student7699@example.com', FALSE, TRUE, '2026-01-14 05:08:27.884428', 'Bernard'),
  (1297, 'pbkdf2_sha256$1000000$lYE60Nt1sECXNLWbxkVvFA$GbRk2BDYq9sITl07uppIIzA1fKLWwkw6q5E0D66lAi4=', NULL, FALSE, 'STD7700', 'Muthoni', 'student7700@example.com', FALSE, TRUE, '2026-01-14 05:08:30.682411', 'Angel'),
  (1298, 'pbkdf2_sha256$1000000$uM3TZFSqmnYR4aVjaRNmLm$JOcx+uUJCFLLCRB6gsfZZKKzX/+wYdzaAsVGbp0adjc=', NULL, FALSE, 'STD7701', 'ndomba', 'student7701@example.com', FALSE, TRUE, '2026-01-14 05:08:32.936878', 'Gedion'),
  (1299, 'pbkdf2_sha256$1000000$CVkVyCdYZNvs5Wx59Hv86e$y3sBnmSLtevbc3ug00TCC2P+nJmNqQZgg3CtTY0sJRA=', NULL, FALSE, 'STD7702', 'bahati', 'student7702@example.com', FALSE, TRUE, '2026-01-14 05:08:35.805975', 'Deborah'),
  (1300, 'pbkdf2_sha256$1000000$gkPXhQ6airhEGsdTEnN7Pt$+gDucO3OfuZ/8+KYEarqb71OU9cwD4OEd+AI6vrM4R8=', NULL, FALSE, 'STD7703', 'wairegi', 'student7703@example.com', FALSE, TRUE, '2026-01-14 05:08:37.794941', 'Patrick'),
  (1301, 'pbkdf2_sha256$1000000$QmVmWfcxl0W0pktvoXXyYQ$6ikO2T/GnKvsWv2CeCSt0atrSzGy6YVuN5BY29wc52M=', NULL, FALSE, 'STD7704', 'mwende', 'student7704@example.com', FALSE, TRUE, '2026-01-14 05:08:41.290161', 'Christine'),
  (1302, 'pbkdf2_sha256$1000000$Pd1FbUpRqanP4BQRbLiN44$g4zsLj6AhXO+/qSBegsNcJ2XPyt6qoKQ/QGdw5jVpP4=', NULL, FALSE, 'STD7705', 'ikhavi', 'student7705@example.com', FALSE, TRUE, '2026-01-14 05:08:43.535638', 'Nathaniel'),
  (1303, 'pbkdf2_sha256$1000000$8iCBdzhlYwsS47mLNl6TgP$lRlUY3iAs1vcosl8x+IIyyMB4bNvBiMlRm/AsVD4CSo=', NULL, FALSE, 'STD7706', 'mburu', 'student7706@example.com', FALSE, TRUE, '2026-01-14 05:08:45.732917', 'Victor'),
  (1304, 'pbkdf2_sha256$1000000$jYzgs5UbfTat58BGczpf0h$WR8/raVv1S7o7khCXaYGdvokOZu0oBKIgsD8j1dMACs=', NULL, FALSE, 'STD7707', 'Maina', 'student7707@example.com', FALSE, TRUE, '2026-01-14 05:08:49.225122', 'Stephen'),
  (1305, 'pbkdf2_sha256$1000000$WSrxSSrfy3nvDngm696T2v$UjMQ4Gi0QuTsBs9q7uZAa/8G3SIELqws7EOaFsYcxRI=', NULL, FALSE, 'STD7708', 'Muthomi', 'student7708@example.com', FALSE, TRUE, '2026-01-14 05:08:51.742735', 'Travis'),
  (1306, 'pbkdf2_sha256$1000000$MNJIym9S0YisSWjPiWsaus$KYnJaaCE9oxcecViOrb7WO/jCFvEYDWGSWY/TtXuoMM=', NULL, FALSE, 'STD7709', 'simiyu', 'student7709@example.com', FALSE, TRUE, '2026-01-14 05:08:54.149196', 'Joles'),
  (1307, 'pbkdf2_sha256$1000000$LILLuwO8hAuA0rN3laUufF$BTgwZAUElTanXkqBCU2tFP5XR1vQXV3tItUCOX28q8M=', NULL, FALSE, 'STD7710', 'mueni', 'student7710@example.com', FALSE, TRUE, '2026-01-14 05:08:56.385869', 'Nellius'),
  (1308, 'pbkdf2_sha256$1000000$zj7xbxQyJCX1cqOaKNNwbO$cmHn709N7kNGDpl05WwcYevavAf4A5jW5k3mCdvj8HE=', NULL, FALSE, 'STD7711', 'waringia', 'student7711@example.com', FALSE, TRUE, '2026-01-14 05:08:58.446772', 'Joy'),
  (1309, 'pbkdf2_sha256$1000000$kp36uuO54SzSLWB84jEGBp$FpVJnywhPg4MSq6bds+jW2T7CvFelb7YlHw29yVni1k=', NULL, FALSE, 'STD7712', 'mweu', 'student7712@example.com', FALSE, TRUE, '2026-01-14 05:09:00.564961', 'Allan'),
  (1310, 'pbkdf2_sha256$1000000$debYi7CybHL97BloyjuLqS$TiBPgwqai+9z3mb8KbpF/RdFgLNHnBDOfwD2KIO47zk=', NULL, FALSE, 'STD7713', 'kyago', 'student7713@example.com', FALSE, TRUE, '2026-01-14 05:09:02.936591', 'Kaylan'),
  (1311, 'pbkdf2_sha256$1000000$gNPYC2vSfA0xPo7iyvbJNN$nnHxUe7fuNRk8dWiwn1oMoDjxRRksVTHbNh6Rr2VLpI=', NULL, FALSE, 'STD7714', 'shimata', 'student7714@example.com', FALSE, TRUE, '2026-01-14 05:09:05.289826', 'Ephraim'),
  (1312, 'pbkdf2_sha256$1000000$9UUDQeohctcUcXuzbg4npx$DveEgQdD+6SaG8ukSxUgFJ0y6Shu6Z1u0s8hpnjCiI8=', NULL, FALSE, 'STD7715_2', 'Godwil', 'student7715_2@example.com', FALSE, TRUE, '2026-01-14 05:09:07.581203', 'Genuine'),
  (1313, 'pbkdf2_sha256$1000000$ypbBb5Lj4JTwRsBud5y29t$teu7V6CJXfiaQg3PjAzameyy1Y5eyaoXfr61UmXFxzs=', NULL, FALSE, 'STD7716', 'Gitau', 'student7716@example.com', FALSE, TRUE, '2026-01-14 05:09:09.784693', 'Stephen'),
  (1314, 'pbkdf2_sha256$1000000$DlcvqKA86CRDWSfuaETLDQ$5qLQnnrFvY+xS1IskxERh+/X6J0UjaYOv68RtfawlLg=', NULL, FALSE, 'STD7717', 'Nduku', 'student7717@example.com', FALSE, TRUE, '2026-01-14 05:09:12.271615', 'Shantel'),
  (1315, 'pbkdf2_sha256$1000000$KXz4EisOu1jYjY1DDY4G2i$G9rEmbnzCgKKtCJKLUTEPOusML1X0TCGNwT6Q8AvvwU=', NULL, FALSE, 'STD7718', 'Mutunga', 'student7718@example.com', FALSE, TRUE, '2026-01-14 05:09:14.936406', 'Antony'),
  (1316, 'pbkdf2_sha256$1000000$cKQJTewmSaBkKKyBErUxua$IGZWJNHh99CdVq2StSi0ToJZeAcghUOjqgvKvXaiQhY=', NULL, FALSE, 'STD7719', 'Gathecha', 'student7719@example.com', FALSE, TRUE, '2026-01-14 05:09:17.066518', 'Clement'),
  (1317, 'pbkdf2_sha256$1000000$cGZhSxyFDqr0pXEAyIpdrU$4VNxyMECVnwYI8rffPfdUGWwD1CEfPNt7NVuL9vEu/k=', NULL, FALSE, 'STD7720', 'Mutugi', 'student7720@example.com', FALSE, TRUE, '2026-01-14 05:09:19.327204', 'Aiden'),
  (1318, 'pbkdf2_sha256$1000000$8lyvWVW68P9aNgtPVpVcbQ$MGVzs3ujAC9Js7jGsofkKdxO3iZLoEiA49vUnI5Vrtc=', NULL, FALSE, 'STD7721', 'Njeri', 'student7721@example.com', FALSE, TRUE, '2026-01-14 05:09:21.381647', 'Tammian'),
  (1319, 'pbkdf2_sha256$1000000$Ir2CHpdInKCDs9MWtgkOVS$6gH6K5UZt6qTlmkuZoYr6ifyOXmIdDHqchvZbtCqbJc=', NULL, FALSE, 'STD7722', 'Favour', 'student7722@example.com', FALSE, TRUE, '2026-01-14 05:09:25.488489', 'Sylvia'),
  (1320, 'pbkdf2_sha256$1000000$l1Hnpz1apvy3iOUYGn44F4$LP4lAwpWnThxxwpuJM9Kztk7ab5P7ToY4Takfyz7Ux0=', NULL, FALSE, 'STD7723', 'wanjiru', 'student7723@example.com', FALSE, TRUE, '2026-01-14 05:09:28.670356', 'Favour'),
  (1321, 'pbkdf2_sha256$1000000$dgsxCM3HQoo77xvbeLi1nW$VI19wpTiNKxfzqowJgbhDK3QVimlXNInJMNc0S0f9vI=', NULL, FALSE, 'STD7724', 'Njoroge', 'student7724@example.com', FALSE, TRUE, '2026-01-14 05:09:31.639968', 'Vincent'),
  (1322, 'pbkdf2_sha256$1000000$ug0LAUfEzyFknSXLO7N3r8$ZcwowKh2jLrCqW6TdN2DcUOHYXKG/yT9IulniVRTlHU=', NULL, FALSE, 'STD7725', 'mutwiri', 'student7725@example.com', FALSE, TRUE, '2026-01-14 05:09:34.012163', 'Samhenry'),
  (1323, 'pbkdf2_sha256$1000000$zPVgy3QQcxhD8ySJQWc37Z$kpViUMJxnAEVftlVFPeQDF8avmiH6dmMaoDj5N6ZJIA=', NULL, FALSE, 'STD7726', 'mutindi', 'student7726@example.com', FALSE, TRUE, '2026-01-14 05:09:36.594266', 'Blessing'),
  (1324, 'pbkdf2_sha256$1000000$yC2dDF9015kg26DRN0FZVn$JS/vhqAXXtqo8k/o7OoE8MUXjE8AB/kybVuV3kAUUYo=', NULL, FALSE, 'STD7727', 'wema', 'student7727@example.com', FALSE, TRUE, '2026-01-14 05:09:39.419836', 'Talia'),
  (1325, 'pbkdf2_sha256$1000000$9GTxB7CFOvbARoXD2ZzF7n$+QJdg/9gAF+j+7t38EnLv4O2zO2Our79jAeb1vtjc48=', NULL, FALSE, 'STD7728', 'mutio', 'student7728@example.com', FALSE, TRUE, '2026-01-14 05:09:41.828414', 'Pascaline'),
  (1326, 'pbkdf2_sha256$1000000$jwe3fhzX3qHeYaDa0AdPdl$sMyAeElKkETKcWUfH1gSqIe4OyIFd5pD/tTmh18geok=', NULL, FALSE, 'STD7729', 'murimi', 'student7729@example.com', FALSE, TRUE, '2026-01-14 05:09:44.728370', 'Bryson'),
  (1327, 'pbkdf2_sha256$1000000$qhoIo94wPzBURSMvYCGqur$/05fXJ/BYM9rkWbnzoureElqClkPFZG3qP6jTb76fOw=', '2026-01-14 05:42:22.126659', FALSE, 'virbridgetnyokabi@bdmis.co.ke', 'NYOKABI', 'virbridgetnyokabi@bdmis.co.ke', FALSE, TRUE, '2026-01-14 05:40:52.915674', 'BRIDGET'),
  (1328, 'pbkdf2_sha256$1000000$OxaPwtV7A5NEE8pDrcpMFR$6tZ13Yk7T+FkUU7TAyjY8XWjC0xBaLpxmcF43xh0x4k=', '2026-01-14 19:50:46.512929', FALSE, 'dadarita@bdmis.co.ke', 'Rita', 'dadarita@bdmis.co.ke', FALSE, TRUE, '2026-01-14 05:40:55.941784', 'Dada'),
  (1329, 'pbkdf2_sha256$1000000$HBOTKFSwr9laVY4lHr4ncp$CRNSyqUahltpORsCWlpon2L/41YsHGFBt+NGumPuJt8=', NULL, FALSE, 'elizabethbarasa@bdmis.co.ke', 'Barasa', 'elizabethbarasa@bdmis.co.ke', FALSE, TRUE, '2026-01-14 05:40:57.941897', 'Elizabeth'),
  (1330, 'pbkdf2_sha256$1000000$7DJPy0vbduZAZrU5JT8Vb3$uk+fpvmbJrrKsjdMiO3kzFzuPPiEPuTRhr/mDCv0kv0=', NULL, FALSE, 'estherwaithera@bdmis.co.ke', 'Waithera', 'estherwaithera@bdmis.co.ke', FALSE, TRUE, '2026-01-14 05:40:59.945211', 'Esther'),
  (1331, 'pbkdf2_sha256$1000000$hkA58NCzrmSMbKwNQViZIJ$U+bZwUmJJZq2tf4WDyl47AXCllHVy6lL4888LnDTHso=', NULL, FALSE, 'faithgicheru@bdmis.co.ke', 'GICHERU', 'faithgicheru@bdmis.co.ke', FALSE, TRUE, '2026-01-14 05:41:02.568306', 'FAITH'),
  (1332, 'pbkdf2_sha256$1000000$3tb8Nq7G5mwUXEIZtRhrSp$YrGiMpM4n0SMa8O10cDdAsYIW26WU22zdP3w0xxY1mY=', '2026-01-14 05:57:41.719953', FALSE, 'jacklinenzisa@bdmis.co.ke', 'Nzisa', 'jacklinenzisa@bdmis.co.ke', FALSE, TRUE, '2026-01-14 05:41:05.333160', 'Jackline'),
  (1333, 'pbkdf2_sha256$1000000$p1gZVVf1o5yZcHYsviHk2F$yjztbBtm14XG6Y00H+xjqbstLAbnQvyFdeQsUFFKBKo=', NULL, FALSE, 'lilianwaithira@bdmis.co.ke', 'WAITHERA', 'lilianwaithira@bdmis.co.ke', FALSE, TRUE, '2026-01-14 05:41:07.850322', 'LILIAN'),
  (1334, 'pbkdf2_sha256$1000000$mSVwXg99NOYO5CQc7ZewIX$smAuqBuJQuw7XBdN/Kl1kitju5YoBSOL+TKPKoFLudg=', NULL, FALSE, 'nellywanjiru@bdmis.co.ke', 'Wanjiru', 'nellywanjiru@bdmis.co.ke', FALSE, TRUE, '2026-01-14 05:41:09.880797', 'Nelly'),
  (1335, 'pbkdf2_sha256$1000000$Hp1DvnVIMWpDQQUovRwrDo$bkH96s3+OlfhCHKE9FjclSRECH+z63FY4LVX+fJtxfw=', NULL, FALSE, 'rosenjeri@bdmis.co.ke', 'NJERI', 'rosenjeri@bdmis.co.ke', FALSE, TRUE, '2026-01-14 05:41:12.444855', 'ROSE'),
  (1336, 'pbkdf2_sha256$1000000$teAdyk7MY41uTsWNEAuzno$WlzMusHusDdNVqJ5lQeRb0Rw9F1wACiCUvQH9MjloMk=', NULL, FALSE, 'salomeogai@bdmis.co.ke', 'Ogai', 'salomeogai@bdmis.co.ke', FALSE, TRUE, '2026-01-14 05:41:15.284412', 'Salome'),
  (1337, 'pbkdf2_sha256$1000000$PMD1JMQsOa5dNDtx5DPkTP$1CXE/5RzzDqG0/Ga8dfbZ/udzOI8REv2M/L/qIf2dZ0=', NULL, FALSE, 'salomeshivona@bdmis.co.ke', 'Shivona', 'salomeshivona@bdmis.co.ke', FALSE, TRUE, '2026-01-14 05:41:17.569433', 'Salome'),
  (1338, 'pbkdf2_sha256$1000000$dQ7PDLwIOkHNdElQpB1Acs$1Iq5qzmCvdI/101EwWUZD5QMoeDCqYkQNC/mHY84e+M=', NULL, FALSE, 'teryynyambura@bdmis.co.ke', 'TERYY', 'teryynyambura@bdmis.co.ke', FALSE, TRUE, '2026-01-14 05:41:20.046216', 'TERYY'),
  (1339, 'pbkdf2_sha256$1000000$sBRSitu9YW9E3xSmEDCF75$72egyBrYGfGwOx8d3oJGfRjFs/ftLp64D7McoCs70sA=', NULL, FALSE, 'virginiawanja@bdmis.co.ke', 'WANJA', 'virginiawanja@bdmis.co.ke', FALSE, TRUE, '2026-01-14 05:41:23.871230', 'VIRGINIA'),
  (1340, 'pbkdf2_sha256$1000000$5qjv4d5na314z2iBw2TxGL$Sl8rUM+HXARAppZyUpxyc44NHFPagmAsahQV7XUBrMg=', NULL, FALSE, 'STD7000', 'Hamisi', 'saidahhamisi618@gmail.com', FALSE, TRUE, '2026-01-14 06:00:08.835891', 'TIERY'),
  (1341, 'pbkdf2_sha256$1000000$INQTAiPUccwYp7X2FpMgLu$dgdXWZ+gG/6AG0w48rsSw2UqFigooWq5yp77BN9xWug=', NULL, FALSE, 'STD7730', 'Hamisi', 'saidahhamisi618@gmail.com', FALSE, TRUE, '2026-01-14 06:10:18.795898', 'Saida'),
  (1342, 'pbkdf2_sha256$1000000$wcE9ZL1SXUzKBJcgpYXlZ5$wgEDuczCU708UooFdTjoTZ6I27ChSbc3SZ3146DUTgM=', '2026-01-22 08:38:07.631493', FALSE, 'accountant', '', 'accountant@school.com', TRUE, TRUE, '2026-01-14 06:18:59.107779', ''),
  (1343, 'pbkdf2_sha256$1000000$xZ4jW8GsJSanHikpZC8rDt$g+ZU1zhLmPPNRlFjjyqvg00L0whE1X1Qd6ULRafJZ2U=', '2026-01-14 15:39:05.292400', FALSE, 'foodmanager', '', 'foodmanager@school.com', TRUE, TRUE, '2026-01-14 06:23:56.467310', ''),
  (1344, 'pbkdf2_sha256$1000000$5aYOKygGWFQhZMzoyXtlxl$TYMoXx5xuyBcgJ5WCEUgv2oTXV8+FoCmkzQ57OVK+kE=', '2026-01-14 19:48:32.499302', FALSE, 'transportmanager', '', 'transportmanager@school.com', TRUE, TRUE, '2026-01-14 06:23:58.172638', ''),
  (1345, 'pbkdf2_sha256$1000000$EwKcc8svm6EGIXE5tJ5TC6$0UEd5Z29GtnUg+MIwSYY2QwxncvGzhpBUl5qBxr82Ow=', '2026-01-14 15:34:43.005097', FALSE, 'Accountant', 'Officer', 'accountant@school.com', TRUE, TRUE, '2026-01-14 14:39:06.124749', 'Finance'),
  (1346, 'pbkdf2_sha256$1000000$EdPAm10yIct5QbF9HSBdFP$2h+A3ifk4/SDvrR8WUXLELkulKXcoGqSNQCGSLu4a3Q=', '2026-01-14 15:39:51.577074', TRUE, 'TransportAdmin', '', 'transport@school.com', TRUE, TRUE, '2026-01-14 15:36:05.886069', '')
ON CONFLICT DO NOTHING;

-- auth_user_groups (772 rows)
INSERT INTO "auth_user_groups" ("id", "user_id", "group_id") VALUES
  (11, 12, 1),
  (14, 15, 1),
  (16, 17, 1),
  (17, 18, 3),
  (19, 20, 1),
  (20, 21, 1),
  (21, 22, 1),
  (22, 23, 1),
  (23, 24, 1),
  (24, 26, 3),
  (25, 27, 1),
  (26, 28, 1),
  (27, 29, 1),
  (28, 30, 1),
  (29, 31, 1),
  (30, 32, 1),
  (31, 33, 1),
  (32, 34, 1),
  (33, 35, 1),
  (34, 36, 1),
  (35, 37, 1),
  (36, 38, 1),
  (37, 39, 1),
  (38, 40, 1),
  (39, 41, 1),
  (40, 42, 1),
  (41, 43, 1),
  (42, 44, 1),
  (43, 45, 1),
  (44, 46, 1),
  (45, 47, 1),
  (46, 48, 1),
  (47, 49, 1),
  (48, 50, 1),
  (49, 51, 1),
  (50, 52, 1),
  (51, 53, 1),
  (52, 54, 1),
  (53, 55, 1),
  (54, 56, 1),
  (55, 57, 1),
  (56, 58, 1),
  (57, 59, 1),
  (58, 60, 1),
  (59, 61, 2),
  (60, 62, 1),
  (61, 63, 1),
  (62, 64, 1),
  (63, 65, 1),
  (64, 66, 1),
  (65, 67, 1),
  (66, 68, 2),
  (67, 69, 1),
  (68, 70, 1),
  (69, 71, 1),
  (70, 72, 2),
  (71, 73, 2),
  (72, 74, 2),
  (74, 76, 2),
  (75, 77, 2),
  (76, 78, 2),
  (77, 79, 1),
  (78, 80, 1),
  (79, 81, 1),
  (80, 82, 1),
  (81, 83, 1),
  (82, 84, 1),
  (83, 85, 1),
  (84, 86, 1),
  (85, 87, 1),
  (86, 88, 1),
  (87, 89, 1),
  (88, 90, 1),
  (89, 91, 1),
  (90, 92, 1),
  (91, 93, 1),
  (92, 94, 1),
  (93, 95, 1),
  (94, 96, 1),
  (95, 97, 1),
  (96, 98, 1),
  (97, 99, 1),
  (98, 100, 1),
  (99, 101, 1),
  (100, 102, 1),
  (101, 103, 1),
  (102, 104, 1),
  (103, 105, 1),
  (104, 106, 1),
  (105, 107, 1),
  (106, 108, 1),
  (107, 109, 1),
  (108, 110, 1),
  (109, 111, 1),
  (110, 112, 1),
  (111, 113, 1),
  (112, 114, 1),
  (113, 115, 1),
  (114, 116, 1),
  (115, 117, 1),
  (116, 118, 1),
  (117, 119, 1),
  (118, 120, 1),
  (119, 121, 1),
  (120, 122, 1),
  (121, 123, 1),
  (122, 124, 1),
  (123, 125, 1),
  (124, 126, 1),
  (125, 127, 1),
  (126, 128, 1),
  (127, 129, 1),
  (128, 130, 1),
  (129, 131, 1),
  (130, 132, 1),
  (131, 133, 1),
  (132, 134, 1),
  (133, 135, 1),
  (134, 136, 1),
  (135, 137, 1),
  (136, 138, 1),
  (137, 139, 1),
  (138, 140, 1),
  (139, 141, 1),
  (140, 142, 1),
  (141, 143, 1),
  (142, 144, 1),
  (143, 145, 1),
  (144, 146, 1),
  (145, 147, 1),
  (146, 148, 1),
  (147, 149, 1),
  (148, 150, 1),
  (149, 151, 1),
  (150, 152, 1),
  (151, 153, 1),
  (152, 154, 1),
  (153, 155, 1),
  (154, 156, 1),
  (155, 157, 1),
  (156, 158, 1),
  (157, 159, 1),
  (158, 160, 1),
  (159, 161, 1),
  (160, 162, 1),
  (161, 163, 1),
  (162, 164, 1),
  (163, 165, 1),
  (164, 166, 1),
  (165, 167, 1),
  (166, 168, 1),
  (167, 169, 1),
  (168, 170, 1),
  (169, 171, 1),
  (170, 172, 1),
  (171, 173, 1),
  (172, 174, 1),
  (173, 175, 1),
  (174, 176, 1),
  (175, 177, 1),
  (176, 178, 1),
  (177, 179, 1),
  (178, 180, 1),
  (179, 181, 1),
  (180, 182, 1),
  (181, 183, 1),
  (182, 184, 1),
  (183, 185, 1),
  (184, 186, 1),
  (185, 187, 1),
  (186, 188, 1),
  (187, 189, 1),
  (188, 190, 1),
  (189, 191, 1),
  (190, 192, 1),
  (191, 193, 2),
  (192, 194, 2),
  (193, 195, 1),
  (194, 196, 1),
  (195, 197, 1),
  (196, 198, 1),
  (197, 199, 1),
  (198, 200, 1),
  (199, 201, 1),
  (200, 202, 1),
  (201, 203, 1),
  (202, 204, 1),
  (203, 205, 1),
  (204, 206, 1),
  (205, 207, 1),
  (206, 208, 1),
  (207, 209, 1),
  (208, 210, 1),
  (209, 211, 1),
  (210, 212, 1),
  (211, 213, 1),
  (212, 214, 1),
  (213, 215, 1),
  (214, 216, 1),
  (215, 217, 1)
ON CONFLICT DO NOTHING;
INSERT INTO "auth_user_groups" ("id", "user_id", "group_id") VALUES
  (216, 218, 1),
  (217, 219, 1),
  (218, 220, 1),
  (219, 221, 1),
  (220, 222, 1),
  (221, 223, 1),
  (222, 224, 1),
  (223, 227, 1),
  (224, 228, 1),
  (225, 229, 1),
  (784, 780, 1),
  (785, 781, 1),
  (786, 782, 1),
  (787, 783, 1),
  (788, 784, 1),
  (789, 785, 1),
  (790, 786, 1),
  (791, 787, 1),
  (792, 788, 1),
  (793, 789, 1),
  (794, 790, 1),
  (795, 791, 1),
  (796, 792, 1),
  (797, 793, 1),
  (798, 794, 1),
  (799, 795, 1),
  (800, 796, 1),
  (801, 797, 1),
  (802, 798, 1),
  (803, 799, 1),
  (804, 800, 1),
  (805, 801, 1),
  (806, 802, 1),
  (807, 803, 1),
  (808, 804, 1),
  (809, 805, 1),
  (810, 806, 1),
  (811, 807, 1),
  (812, 808, 1),
  (813, 809, 1),
  (814, 810, 1),
  (815, 811, 1),
  (816, 812, 1),
  (817, 813, 1),
  (818, 814, 1),
  (819, 815, 1),
  (820, 816, 1),
  (821, 817, 1),
  (822, 818, 1),
  (823, 819, 1),
  (824, 820, 1),
  (825, 821, 1),
  (826, 822, 1),
  (827, 823, 1),
  (828, 824, 1),
  (829, 825, 1),
  (830, 826, 1),
  (831, 827, 1),
  (832, 828, 1),
  (833, 829, 1),
  (834, 830, 1),
  (835, 831, 1),
  (836, 832, 1),
  (837, 833, 1),
  (838, 834, 1),
  (839, 835, 1),
  (840, 836, 1),
  (841, 837, 1),
  (842, 838, 1),
  (843, 839, 1),
  (844, 840, 1),
  (845, 841, 1),
  (846, 842, 1),
  (847, 843, 1),
  (848, 844, 1),
  (849, 845, 1),
  (850, 846, 1),
  (851, 847, 1),
  (852, 848, 1),
  (853, 849, 1),
  (854, 850, 1),
  (855, 851, 1),
  (856, 852, 1),
  (857, 853, 1),
  (858, 854, 1),
  (859, 855, 1),
  (860, 856, 1),
  (861, 857, 1),
  (862, 858, 1),
  (863, 859, 1),
  (864, 860, 1),
  (865, 861, 1),
  (866, 862, 1),
  (867, 863, 1),
  (868, 864, 1),
  (869, 865, 1),
  (870, 866, 1),
  (871, 867, 1),
  (872, 868, 1),
  (873, 869, 1),
  (874, 870, 1),
  (875, 871, 1),
  (876, 872, 1),
  (877, 873, 1),
  (878, 874, 1),
  (879, 875, 1),
  (880, 876, 1),
  (881, 877, 1),
  (882, 878, 1),
  (883, 879, 1),
  (884, 880, 1),
  (885, 881, 1),
  (886, 882, 1),
  (887, 883, 1),
  (888, 884, 1),
  (889, 885, 1),
  (890, 886, 1),
  (891, 887, 1),
  (892, 888, 1),
  (893, 889, 1),
  (894, 890, 1),
  (895, 891, 1),
  (896, 892, 1),
  (897, 893, 1),
  (898, 894, 1),
  (899, 895, 1),
  (900, 896, 1),
  (901, 897, 1),
  (902, 898, 1),
  (903, 899, 1),
  (904, 900, 1),
  (905, 901, 1),
  (906, 902, 1),
  (907, 903, 1),
  (908, 904, 1),
  (909, 905, 1),
  (910, 906, 1),
  (911, 907, 1),
  (912, 908, 1),
  (913, 909, 1),
  (914, 910, 1),
  (915, 911, 1),
  (916, 912, 1),
  (917, 913, 1),
  (918, 914, 1),
  (919, 915, 1),
  (920, 916, 1),
  (921, 917, 1),
  (922, 918, 1),
  (923, 919, 1),
  (924, 920, 1),
  (925, 921, 1),
  (926, 922, 1),
  (927, 923, 1),
  (928, 924, 1),
  (929, 925, 1),
  (930, 926, 1),
  (931, 927, 1),
  (932, 928, 1),
  (933, 929, 1),
  (934, 930, 1),
  (935, 931, 1),
  (936, 932, 1),
  (937, 933, 1),
  (938, 934, 1),
  (939, 935, 1),
  (940, 936, 1),
  (941, 937, 1),
  (942, 938, 1),
  (943, 939, 1),
  (944, 940, 1),
  (945, 941, 1),
  (946, 942, 1),
  (947, 943, 1),
  (948, 944, 1),
  (949, 945, 1),
  (950, 946, 1),
  (951, 947, 1),
  (952, 948, 1),
  (953, 949, 1),
  (954, 950, 1),
  (955, 951, 1),
  (956, 952, 1),
  (957, 953, 1),
  (958, 954, 1),
  (959, 955, 1),
  (960, 956, 1),
  (961, 957, 1),
  (962, 958, 1),
  (963, 959, 1),
  (964, 960, 1),
  (965, 961, 1),
  (966, 962, 1),
  (967, 963, 1),
  (968, 964, 1),
  (969, 965, 1),
  (970, 966, 1),
  (971, 967, 1),
  (972, 968, 1),
  (973, 969, 1)
ON CONFLICT DO NOTHING;
INSERT INTO "auth_user_groups" ("id", "user_id", "group_id") VALUES
  (974, 970, 1),
  (975, 971, 1),
  (976, 972, 1),
  (977, 973, 1),
  (978, 974, 1),
  (979, 975, 1),
  (980, 976, 1),
  (981, 977, 1),
  (982, 978, 1),
  (983, 979, 1),
  (984, 980, 1),
  (985, 981, 1),
  (986, 982, 1),
  (987, 983, 1),
  (988, 984, 1),
  (989, 985, 1),
  (990, 986, 1),
  (991, 987, 1),
  (992, 988, 1),
  (993, 989, 1),
  (994, 990, 1),
  (995, 991, 1),
  (996, 992, 1),
  (997, 993, 1),
  (998, 994, 1),
  (999, 995, 1),
  (1000, 996, 1),
  (1001, 997, 1),
  (1002, 998, 1),
  (1003, 999, 1),
  (1004, 1000, 1),
  (1005, 1001, 1),
  (1006, 1002, 1),
  (1007, 1003, 1),
  (1008, 1004, 1),
  (1009, 1005, 1),
  (1010, 1006, 1),
  (1011, 1007, 1),
  (1012, 1008, 1),
  (1013, 1009, 1),
  (1014, 1010, 1),
  (1015, 1011, 1),
  (1016, 1012, 1),
  (1017, 1013, 1),
  (1018, 1014, 1),
  (1019, 1015, 1),
  (1020, 1016, 1),
  (1021, 1017, 1),
  (1022, 1018, 1),
  (1023, 1019, 1),
  (1024, 1020, 1),
  (1025, 1021, 1),
  (1026, 1022, 1),
  (1027, 1023, 1),
  (1028, 1024, 1),
  (1029, 1025, 1),
  (1030, 1026, 1),
  (1031, 1027, 1),
  (1032, 1028, 1),
  (1033, 1029, 1),
  (1034, 1030, 1),
  (1035, 1031, 1),
  (1036, 1032, 1),
  (1037, 1033, 1),
  (1038, 1034, 1),
  (1039, 1035, 1),
  (1040, 1036, 1),
  (1041, 1037, 1),
  (1042, 1038, 1),
  (1043, 1039, 1),
  (1044, 1040, 1),
  (1045, 1041, 1),
  (1046, 1042, 1),
  (1047, 1043, 1),
  (1048, 1044, 1),
  (1049, 1045, 1),
  (1050, 1046, 1),
  (1051, 1047, 1),
  (1052, 1048, 1),
  (1053, 1049, 1),
  (1054, 1050, 1),
  (1055, 1051, 1),
  (1056, 1052, 1),
  (1057, 1053, 1),
  (1058, 1054, 1),
  (1059, 1055, 1),
  (1060, 1056, 1),
  (1061, 1057, 1),
  (1062, 1058, 1),
  (1063, 1059, 1),
  (1064, 1060, 1),
  (1065, 1061, 1),
  (1066, 1062, 1),
  (1067, 1063, 1),
  (1068, 1064, 1),
  (1069, 1065, 1),
  (1070, 1066, 1),
  (1071, 1067, 1),
  (1072, 1068, 1),
  (1073, 1069, 1),
  (1074, 1070, 1),
  (1075, 1071, 1),
  (1076, 1072, 1),
  (1077, 1073, 1),
  (1078, 1074, 1),
  (1079, 1075, 1),
  (1080, 1076, 1),
  (1081, 1077, 1),
  (1082, 1078, 1),
  (1083, 1079, 1),
  (1084, 1080, 1),
  (1085, 1081, 1),
  (1086, 1082, 1),
  (1087, 1083, 1),
  (1088, 1084, 1),
  (1089, 1085, 1),
  (1090, 1086, 1),
  (1091, 1087, 1),
  (1092, 1088, 1),
  (1093, 1089, 1),
  (1094, 1090, 1),
  (1095, 1091, 1),
  (1096, 1092, 1),
  (1097, 1093, 1),
  (1098, 1094, 1),
  (1099, 1095, 1),
  (1100, 1096, 1),
  (1101, 1097, 1),
  (1102, 1098, 1),
  (1103, 1099, 1),
  (1104, 1100, 1),
  (1105, 1101, 1),
  (1106, 1102, 1),
  (1107, 1103, 1),
  (1108, 1104, 1),
  (1109, 1105, 1),
  (1110, 1106, 1),
  (1111, 1107, 1),
  (1112, 1108, 1),
  (1113, 1109, 1),
  (1114, 1110, 1),
  (1115, 1111, 1),
  (1116, 1112, 1),
  (1117, 1113, 1),
  (1118, 1114, 1),
  (1119, 1115, 1),
  (1120, 1116, 1),
  (1121, 1117, 1),
  (1122, 1118, 1),
  (1123, 1119, 1),
  (1124, 1120, 1),
  (1125, 1121, 1),
  (1126, 1122, 1),
  (1127, 1123, 1),
  (1128, 1124, 1),
  (1129, 1125, 1),
  (1130, 1126, 1),
  (1131, 1127, 1),
  (1132, 1128, 1),
  (1133, 1129, 1),
  (1134, 1130, 1),
  (1135, 1131, 1),
  (1136, 1132, 1),
  (1137, 1133, 1),
  (1138, 1134, 1),
  (1139, 1135, 1),
  (1140, 1136, 1),
  (1141, 1137, 1),
  (1142, 1138, 1),
  (1143, 1139, 1),
  (1144, 1140, 1),
  (1145, 1141, 1),
  (1146, 1142, 1),
  (1147, 1143, 1),
  (1148, 1144, 1),
  (1149, 1145, 1),
  (1150, 1146, 1),
  (1151, 1147, 1),
  (1152, 1148, 1),
  (1153, 1149, 1),
  (1154, 1150, 1),
  (1155, 1151, 1),
  (1156, 1152, 1),
  (1157, 1153, 1),
  (1158, 1154, 1),
  (1159, 1155, 1),
  (1160, 1156, 1),
  (1161, 1157, 1),
  (1162, 1158, 1),
  (1163, 1159, 1),
  (1164, 1160, 1),
  (1165, 1161, 1),
  (1166, 1162, 1),
  (1167, 1163, 1),
  (1168, 1164, 1),
  (1169, 1165, 1),
  (1170, 1166, 1),
  (1171, 1167, 1),
  (1172, 1168, 1),
  (1173, 1169, 1)
ON CONFLICT DO NOTHING;
INSERT INTO "auth_user_groups" ("id", "user_id", "group_id") VALUES
  (1174, 1170, 1),
  (1175, 1171, 1),
  (1176, 1172, 1),
  (1177, 1173, 1),
  (1178, 1174, 1),
  (1179, 1175, 1),
  (1180, 1176, 1),
  (1181, 1177, 1),
  (1182, 1178, 1),
  (1183, 1179, 1),
  (1184, 1180, 1),
  (1185, 1181, 1),
  (1186, 1182, 1),
  (1187, 1183, 1),
  (1188, 1184, 1),
  (1189, 1185, 1),
  (1190, 1186, 1),
  (1191, 1187, 1),
  (1192, 1188, 1),
  (1193, 1189, 1),
  (1194, 1190, 1),
  (1195, 1191, 1),
  (1196, 1192, 1),
  (1197, 1193, 1),
  (1198, 1194, 1),
  (1199, 1195, 1),
  (1200, 1196, 1),
  (1201, 1197, 1),
  (1202, 1198, 1),
  (1203, 1199, 1),
  (1204, 1200, 1),
  (1205, 1201, 1),
  (1206, 1202, 1),
  (1207, 1203, 1),
  (1208, 1204, 1),
  (1209, 1205, 1),
  (1210, 1206, 1),
  (1211, 1207, 1),
  (1212, 1208, 1),
  (1213, 1209, 1),
  (1214, 1210, 1),
  (1215, 1211, 1),
  (1216, 1212, 1),
  (1217, 1213, 1),
  (1218, 1214, 1),
  (1219, 1215, 1),
  (1220, 1216, 1),
  (1221, 1217, 1),
  (1222, 1218, 1),
  (1223, 1219, 1),
  (1224, 1220, 1),
  (1225, 1221, 1),
  (1226, 1222, 1),
  (1227, 1223, 1),
  (1228, 1224, 1),
  (1229, 1225, 1),
  (1230, 1226, 1),
  (1231, 1227, 1),
  (1232, 1228, 1),
  (1233, 1229, 1),
  (1234, 1230, 1),
  (1235, 1231, 1),
  (1236, 1232, 1),
  (1237, 1233, 1),
  (1238, 1234, 1),
  (1239, 1235, 1),
  (1240, 1236, 1),
  (1241, 1237, 1),
  (1242, 1238, 1),
  (1243, 1239, 1),
  (1244, 1240, 1),
  (1245, 1241, 1),
  (1246, 1242, 1),
  (1247, 1243, 1),
  (1248, 1244, 1),
  (1249, 1245, 1),
  (1250, 1246, 1),
  (1251, 1247, 1),
  (1252, 1248, 1),
  (1253, 1249, 1),
  (1254, 1250, 1),
  (1255, 1251, 1),
  (1256, 1252, 1),
  (1257, 1253, 1),
  (1258, 1254, 1),
  (1259, 1255, 1),
  (1260, 1256, 1),
  (1261, 1257, 1),
  (1262, 1258, 1),
  (1263, 1259, 1),
  (1264, 1260, 1),
  (1265, 1261, 1),
  (1266, 1262, 1),
  (1267, 1263, 1),
  (1268, 1264, 1),
  (1269, 1265, 1),
  (1270, 1266, 1),
  (1271, 1267, 1),
  (1272, 1268, 1),
  (1273, 1269, 1),
  (1274, 1270, 1),
  (1275, 1271, 1),
  (1276, 1272, 1),
  (1277, 1273, 1),
  (1278, 1274, 1),
  (1279, 1275, 1),
  (1280, 1276, 1),
  (1281, 1277, 1),
  (1282, 1278, 1),
  (1283, 1279, 1),
  (1284, 1280, 1),
  (1285, 1281, 1),
  (1286, 1282, 1),
  (1287, 1283, 1),
  (1288, 1284, 1),
  (1289, 1285, 1),
  (1290, 1286, 1),
  (1291, 1287, 1),
  (1292, 1288, 1),
  (1293, 1289, 1),
  (1294, 1290, 1),
  (1295, 1291, 1),
  (1296, 1292, 1),
  (1297, 1293, 1),
  (1298, 1294, 1),
  (1299, 1295, 1),
  (1300, 1296, 1),
  (1301, 1297, 1),
  (1302, 1298, 1),
  (1303, 1299, 1),
  (1304, 1300, 1),
  (1305, 1301, 1),
  (1306, 1302, 1),
  (1307, 1303, 1),
  (1308, 1304, 1),
  (1309, 1305, 1),
  (1310, 1306, 1),
  (1311, 1307, 1),
  (1312, 1308, 1),
  (1313, 1309, 1),
  (1314, 1310, 1),
  (1315, 1311, 1),
  (1316, 1312, 1),
  (1317, 1313, 1),
  (1318, 1314, 1),
  (1319, 1315, 1),
  (1320, 1316, 1),
  (1321, 1317, 1),
  (1322, 1318, 1),
  (1323, 1319, 1),
  (1324, 1320, 1),
  (1325, 1321, 1),
  (1326, 1322, 1),
  (1327, 1323, 1),
  (1328, 1324, 1),
  (1329, 1325, 1),
  (1330, 1326, 1),
  (1331, 1327, 2),
  (1332, 1328, 2),
  (1333, 1329, 2),
  (1334, 1330, 2),
  (1335, 1331, 2),
  (1336, 1332, 2),
  (1337, 1333, 2),
  (1338, 1334, 2),
  (1339, 1335, 2),
  (1340, 1336, 2),
  (1341, 1337, 2),
  (1342, 1338, 2),
  (1343, 1339, 2),
  (1344, 1340, 1),
  (1345, 1341, 1)
ON CONFLICT DO NOTHING;

-- django_migrations (97 rows)
INSERT INTO "django_migrations" ("id", "app", "name", "applied") VALUES
  (1, 'contenttypes', '0001_initial', '2025-01-18 15:20:57.762015'),
  (2, 'auth', '0001_initial', '2025-01-18 15:20:57.780442'),
  (3, 'admin', '0001_initial', '2025-01-18 15:20:57.792680'),
  (4, 'admin', '0002_logentry_remove_auto_add', '2025-01-18 15:20:57.804705'),
  (5, 'admin', '0003_logentry_add_action_flag_choices', '2025-01-18 15:20:57.812762'),
  (6, 'contenttypes', '0002_remove_content_type_name', '2025-01-18 15:20:57.831991'),
  (7, 'auth', '0002_alter_permission_name_max_length', '2025-01-18 15:20:57.842029'),
  (8, 'auth', '0003_alter_user_email_max_length', '2025-01-18 15:20:57.853667'),
  (9, 'auth', '0004_alter_user_username_opts', '2025-01-18 15:20:57.862796'),
  (10, 'auth', '0005_alter_user_last_login_null', '2025-01-18 15:20:57.875566'),
  (11, 'auth', '0006_require_contenttypes_0002', '2025-01-18 15:20:57.880149'),
  (12, 'auth', '0007_alter_validators_add_error_messages', '2025-01-18 15:20:57.888525'),
  (13, 'auth', '0008_alter_user_username_max_length', '2025-01-18 15:20:57.900836'),
  (14, 'auth', '0009_alter_user_last_name_max_length', '2025-01-18 15:20:57.910933'),
  (15, 'auth', '0010_alter_group_name_max_length', '2025-01-18 15:20:57.921356'),
  (16, 'auth', '0011_update_proxy_permissions', '2025-01-18 15:20:57.934806'),
  (17, 'auth', '0012_alter_user_first_name_max_length', '2025-01-18 15:20:57.946400'),
  (18, 'schools', '0001_initial', '2025-01-18 15:20:58.103549'),
  (19, 'sessions', '0001_initial', '2025-01-18 15:20:58.111993'),
  (20, 'schools', '0002_populate_subjects', '2025-01-18 15:50:18.346318'),
  (21, 'schools', '0003_employee_gender_employee_marital_status_and_more', '2025-01-18 15:50:18.459650'),
  (22, 'schools', '0003_populate_grades', '2025-01-18 15:52:43.010413'),
  (23, 'schools', '0004_merge_20250118_0652', '2025-01-18 15:52:43.013593'),
  (24, 'schools', '0005_assessmentresult_remarks', '2025-01-18 18:26:28.834221'),
  (25, 'schools', '0002_add_assessment_remarks', '2025-01-18 19:24:17.855896'),
  (26, 'schools', '0006_merge_20250118_1023', '2025-01-18 19:24:17.859138'),
  (27, 'schools', '0004_add_salary_status', '2025-01-19 15:07:48.286906'),
  (28, 'schools', '0007_merge_0004_add_salary_status_0006_merge_20250118_1023', '2025-01-19 15:07:48.291422'),
  (29, 'schools', '0008_remove_salary_net_salary_alter_salary_month_and_more', '2025-01-19 15:18:05.147454'),
  (30, 'schools', '0009_alter_payment_options_alter_payment_date', '2025-01-19 22:07:11.021039'),
  (31, 'schools', '0002_alter_grade_name', '2025-01-20 21:28:23.664887'),
  (32, 'schools', '0003_teacher_id_number_alter_grade_name', '2025-01-20 21:28:23.694334'),
  (33, 'schools', '0004_alter_schedule_teacher', '2025-01-20 21:28:23.713709'),
  (34, 'schools', '0002_student_user', '2025-01-26 05:00:03.065648'),
  (35, 'schools', '0003_teacher_user', '2025-01-26 18:13:27.541751'),
  (36, 'schools', '0004_remove_teacher_user', '2025-01-26 18:19:41.317605'),
  (37, 'schools', '0005_alter_schedule_options_remove_schedule_date_and_more', '2025-01-26 20:19:25.077361'),
  (38, 'schools', '0006_alter_salary_options_and_more', '2025-01-26 20:55:12.244517'),
  (39, 'schools', 'XXXX_add_user_to_teacher', '2025-01-27 15:09:25.865737'),
  (40, 'schools', '0007_merge_20250127_0609', '2025-01-27 15:09:25.869800'),
  (41, 'schools', '0008_alter_salary_options_teacher_user_and_more', '2025-01-27 17:02:06.942119'),
  (42, 'schools', '0009_alter_leave_options_and_more', '2025-01-27 17:03:29.543520'),
  (43, 'schools', '0010_schedule_term_alter_schedule_day_and_more', '2025-01-27 18:11:18.997673'),
  (44, 'schools', '0002_alter_employee_position_announcement', '2025-01-30 21:00:07.174185'),
  (45, 'schools', '0003_smsmessage', '2025-01-30 21:09:25.663862'),
  (46, 'schools', 'XXXX_update_term_fees', '2025-02-03 05:34:13.859076'),
  (47, 'schools', '0004_merge_0003_smsmessage_XXXX_update_term_fees', '2025-02-03 05:34:13.869080'),
  (48, 'schools', '0005_grade_term3_fees_alter_grade_term_fees', '2025-02-03 07:04:41.798273'),
  (49, 'schools', '0002_check_db_state', '2025-02-03 08:23:36.657872'),
  (50, 'schools', '0002_grade_term1_fees_grade_term2_fees_grade_term3_fees', '2025-02-03 08:37:30.530141'),
  (51, 'schools', '0003_student_term1_fees_student_term2_fees_and_more', '2025-02-03 08:40:47.019073'),
  (52, 'schools', '0004_payment_term', '2025-02-03 09:20:35.662799'),
  (53, 'schools', '0005_alter_announcement_recipient_type_department_and_more', '2025-02-05 08:04:44.207345'),
  (54, 'schools', '0006_employeeattendance', '2025-02-05 08:07:17.530481'),
  (55, 'schools', '0007_alter_announcement_priority', '2025-02-06 06:35:38.131101'),
  (56, 'schools', '0008_alter_payment_date', '2025-02-07 09:48:35.483590'),
  (57, 'schools', '0009_alter_term_end_date_alter_term_start_date', '2025-02-07 12:00:52.105237'),
  (58, 'schools', '0010_remove_payment_created_at_remove_payment_description_and_more', '2025-02-10 07:54:38.969679'),
  (59, 'schools', '0011_assessmentresult_marks_assessmentresult_weekly_score_and_more', '2025-08-01 09:10:49.679395'),
  (60, 'schools', '0012_alter_assessment_created_at_alter_assessment_date_and_more', '2025-08-01 09:10:50.430709'),
  (61, 'schools', '0012_assessment_week_number_and_constraints', '2025-09-09 07:13:32.347443'),
  (62, 'schools', '0013_merge_20250909_0713', '2025-09-09 07:13:32.708978'),
  (63, 'schools', '0015_route_transportfee_vehicle_and_more', '2025-11-20 18:59:25.749446'),
  (64, 'schools', '0016_alter_assessment_unique_together', '2025-11-20 19:00:32.990227'),
  (65, 'schools', '0017_foodplan_alter_attendance_student_foodfee_and_more', '2025-11-21 11:31:05.921414'),
  (66, 'schools', '0018_remove_unique_constraints_transport_food_fees', '2025-11-21 12:11:12.130352'),
  (67, 'schools', '0019_studentmealpayment', '2025-11-25 07:17:47.010672'),
  (68, 'schools', '0020_mealpricing_studentmealpayment_number_of_days_and_more', '2025-11-25 08:24:12.763585'),
  (69, 'schools', '0021_studentmealpayment_balance_and_more', '2025-11-25 10:30:17.858038'),
  (70, 'schools', '0022_fix_payment_frequency', '2025-11-25 10:40:08.961756'),
  (71, 'schools', '0023_student_guardian_email_student_guardian_id_number_and_more', '2025-11-25 13:09:07.430795'),
  (72, 'schools', '0024_syncstatus_syncqueue', '2025-11-25 16:47:24.499053'),
  (73, 'schools', '0025_route_end_latitude_route_end_longitude_and_more', '2025-11-25 17:51:28.831592'),
  (74, 'schools', '0026_remove_vehicle_current_latitude_and_more', '2025-11-25 17:51:32.190282'),
  (75, 'schools', '0027_add_location_fields', '2025-11-26 10:45:57.069427'),
  (76, 'schools', '0028_add_location_to_student_meal_payment', '2025-11-26 10:45:57.293173'),
  (77, 'schools', '0029_update_sms_message_model', '2025-11-27 09:06:42.000581'),
  (78, 'config', '0001_initial', '2026-01-09 17:20:56.867561'),
  (79, 'schools', '0030_branch_department_branch_employee_branch_and_more', '2026-01-10 09:53:47.279185'),
  (80, 'schools', '0031_salaryadvance', '2026-01-10 16:48:33.230117'),
  (81, 'schools', '0032_nonteachingstaff_staffdocument_advanceapproval_and_more', '2026-01-10 17:58:37.806051'),
  (82, 'finance', '0001_initial', '2026-01-12 23:20:59.931607'),
  (83, 'food', '0001_initial', '2026-01-13 00:29:20.166818'),
  (84, 'food', '0002_mealitem_per_serving_cost', '2026-01-13 01:02:15.963750'),
  (85, 'transport', '0001_initial', '2026-01-13 01:25:15.960427'),
  (86, 'transport', '0002_route_map_embed_code_and_more', '2026-01-13 09:34:09.098325'),
  (87, 'transport', '0003_transportvehicle_transportdriver', '2026-01-13 10:29:57.109392'),
  (88, 'transport', '0004_transportdriver_user_and_more', '2026-01-13 10:53:14.205188'),
  (89, 'transport', '0005_transportassignment_latitude_and_more', '2026-01-13 10:54:08.078675'),
  (90, 'transport', '0006_transportadvancerequest_transportexpense_and_more', '2026-01-13 11:28:51.401748'),
  (91, 'finance', '0002_salarystructure_payrollrecord', '2026-01-13 12:10:51.920747'),
  (92, 'schools', '0033_expense', '2026-01-14 15:48:56.754184'),
  (93, 'finance', '0003_payrollrecord_loans_payrollrecord_nssf_and_more', '2026-01-20 21:15:18.296327'),
  (94, 'schools', '0034_nonteachingstaff_user', '2026-01-20 21:30:19.776724'),
  (95, 'finance', '0004_payrollrecord_advances', '2026-01-21 22:02:19.212277'),
  (96, 'config', '0002_schoolconfig_school_address', '2026-01-23 10:29:57.978777'),
  (97, 'config', '0003_schoolconfig_school_logo', '2026-01-23 11:36:27.679452')
ON CONFLICT DO NOTHING;

-- django_admin_log (231 rows)
INSERT INTO "django_admin_log" ("id", "object_id", "object_repr", "action_flag", "change_message", "content_type_id", "user_id", "action_time") VALUES
  (1, '4', 'Grade 1', 2, '[{"changed": {"fields": ["Term1 fees", "Term2 fees", "Term3 fees"]}}]', 8, 1, '2025-02-03 08:39:24.003900'),
  (2, '4', 'Grade 1', 2, '[{"changed": {"fields": ["Term3 fees"]}}]', 8, 1, '2025-02-03 08:55:26.118956'),
  (3, '4', 'Grade 1', 2, '[{"changed": {"fields": ["Term1 fees", "Term2 fees", "Term3 fees"]}}]', 8, 1, '2025-02-03 08:57:55.033844'),
  (4, '3', 'PP2', 2, '[{"changed": {"fields": ["Term1 fees", "Term2 fees", "Term3 fees"]}}]', 8, 1, '2025-02-03 08:57:55.037281'),
  (5, '2', 'PP1', 2, '[{"changed": {"fields": ["Term1 fees", "Term2 fees", "Term3 fees"]}}]', 8, 1, '2025-02-06 12:03:49.951596'),
  (6, '4', 'Grade 1', 2, '[{"changed": {"fields": ["Term1 fees"]}}]', 8, 1, '2025-02-06 13:02:10.868074'),
  (7, '2', 'Amos Ekirapa', 3, '', 19, 1, '2025-02-06 14:05:04.715777'),
  (8, '7', 'Amosr Ekirapar', 3, '', 19, 1, '2025-02-06 14:05:04.719308'),
  (9, '6', 'Dante Idahosa', 3, '', 19, 1, '2025-02-06 14:05:04.722945'),
  (10, '4', 'Dave Nick', 3, '', 19, 1, '2025-02-06 14:05:04.727505'),
  (11, '8', 'Gremmyuu Nick', 3, '', 19, 1, '2025-02-06 14:05:04.730477'),
  (12, '9', 'Gremmyw Nicke', 3, '', 19, 1, '2025-02-06 14:05:04.733703'),
  (13, '10', 'Jane Wanjiku', 3, '', 19, 1, '2025-02-06 14:05:04.736789'),
  (14, '5', 'Kris Muturi', 3, '', 19, 1, '2025-02-06 14:05:04.739638'),
  (15, '1', 'PURITY WANJIRU NJOROGE', 3, '', 19, 1, '2025-02-06 14:05:04.744046'),
  (16, '3', 'Lmos Ekirapca', 3, '', 7, 1, '2025-02-06 14:05:51.661010'),
  (17, '1', 'Playgroup', 2, '[{"changed": {"fields": ["Term1 fees", "Term2 fees", "Term3 fees"]}}]', 8, 1, '2025-02-06 17:25:47.912183'),
  (18, '12', 'PURITY WANJIRU NJOROGE', 3, '', 7, 1, '2025-02-10 18:27:58.505970'),
  (19, '11', 'Rachael Iss', 3, '', 7, 1, '2025-02-10 18:28:00.012259'),
  (20, '4', 'Grade 1', 2, '[{"changed": {"fields": ["Term1 fees"]}}]', 8, 1, '2025-02-11 09:02:11.169927'),
  (21, '5', 'Grade 2', 2, '[{"changed": {"fields": ["Term1 fees", "Term2 fees", "Term3 fees"]}}]', 8, 1, '2025-02-11 09:02:11.172627'),
  (22, '6', 'Grade 3', 2, '[{"changed": {"fields": ["Term1 fees", "Term2 fees", "Term3 fees"]}}]', 8, 1, '2025-02-11 09:02:11.175263'),
  (23, '7', 'Grade 4', 2, '[{"changed": {"fields": ["Term1 fees", "Term2 fees", "Term3 fees"]}}]', 8, 1, '2025-02-11 09:02:11.178432'),
  (24, '8', 'Grade 5', 2, '[{"changed": {"fields": ["Term1 fees", "Term2 fees", "Term3 fees"]}}]', 8, 1, '2025-02-11 09:02:11.181522'),
  (25, '1', 'Playgroup', 2, '[{"changed": {"fields": ["Term1 fees", "Term2 fees", "Term3 fees"]}}]', 8, 1, '2025-02-11 09:02:11.183857'),
  (26, '2', 'PP1', 2, '[{"changed": {"fields": ["Term1 fees", "Term2 fees", "Term3 fees"]}}]', 8, 1, '2025-02-11 09:02:11.186134'),
  (27, '19', 'Doreen Afwande', 3, '', 19, 1, '2025-07-15 14:11:59.034930'),
  (28, '23', 'DICKSON OPIYO', 2, '[{"changed": {"fields": ["Is class teacher"]}}]', 19, 1, '2025-07-15 14:13:38.205909'),
  (29, '14', 'Stella Robi', 2, '[{"changed": {"fields": ["Is class teacher"]}}]', 19, 1, '2025-07-15 14:21:46.681114'),
  (30, '1', 'Games and Sports', 1, '[{"added": {}}]', 25, 1, '2025-07-15 14:27:17.247654'),
  (31, '2', 'Debate', 1, '[{"added": {}}]', 25, 1, '2025-07-15 14:27:47.751449'),
  (32, '3', 'Guidance and Councelling', 1, '[{"added": {}}]', 25, 1, '2025-07-15 14:28:30.676162'),
  (33, '4', 'Academics Upper', 1, '[{"added": {}}]', 25, 1, '2025-07-15 14:28:57.837591'),
  (34, '5', 'Academics Lower', 1, '[{"added": {}}]', 25, 1, '2025-07-15 14:30:10.518000'),
  (35, '6', 'Chapel', 1, '[{"added": {}}]', 25, 1, '2025-07-15 14:33:42.918623'),
  (36, '14', 'Stella Robi', 2, '[{"changed": {"fields": ["Grade"]}}]', 19, 1, '2025-07-31 07:30:46.486616'),
  (37, '23', 'DICKSON OPIYO', 2, '[{"changed": {"fields": ["Is class teacher"]}}]', 19, 1, '2025-07-31 07:31:14.099260'),
  (38, '14', 'Stella Robi', 3, '', 19, 1, '2025-07-31 07:35:44.462775'),
  (39, '24', 'BENETI ROBI', 2, '[{"changed": {"fields": ["Profile picture", "Department", "Basic salary"]}}]', 7, 1, '2025-08-01 10:28:43.247197'),
  (40, '23', 'DICKSON OPIYO', 2, '[{"changed": {"fields": ["Department"]}}]', 7, 1, '2025-08-01 10:29:36.963773'),
  (41, '23', 'DICKSON OPIYO', 2, '[{"changed": {"fields": ["Is class teacher"]}}]', 19, 1, '2025-08-01 10:30:03.305243'),
  (42, '9', '25001', 3, '', 4, 1, '2025-08-01 10:45:04.439428'),
  (43, '10', '25002', 3, '', 4, 1, '2025-08-01 10:45:04.857942'),
  (44, '11', '25003', 3, '', 4, 1, '2025-08-01 10:45:05.159010'),
  (45, '2', '25004', 3, '', 4, 1, '2025-08-01 10:45:05.900996'),
  (46, '8', '25005', 3, '', 4, 1, '2025-08-01 10:45:06.423815'),
  (47, '25', 'Director', 2, '[{"changed": {"fields": ["First name", "Last name"]}}]', 4, 1, '2025-08-01 10:46:33.492938'),
  (48, '25', 'Director', 2, '[{"changed": {"fields": ["password"]}}]', 4, 1, '2025-08-01 10:47:36.707711'),
  (49, '26', 'paulinefaith988@gmail.com', 2, '[{"changed": {"fields": ["password"]}}]', 4, 1, '2025-08-01 10:51:17.457150'),
  (50, '26', 'paulinefaith988@gmail.com', 2, '[{"changed": {"fields": ["password"]}}]', 4, 1, '2025-08-01 10:52:45.356780'),
  (51, '1', 'admin', 2, '[{"changed": {"fields": ["password"]}}]', 4, 1, '2025-08-01 10:58:05.452128'),
  (52, '1', 'Administration', 2, '[{"changed": {"fields": ["Username", "First name", "Last name"]}}]', 4, 1, '2025-08-01 10:58:55.819605'),
  (53, '18', 'raelissa@gmail.com', 2, '[{"changed": {"fields": ["password"]}}]', 4, 1, '2025-08-01 11:05:32.079997'),
  (54, '18', 'HT', 2, '[{"changed": {"fields": ["Username"]}}]', 4, 1, '2025-08-01 11:05:53.779891'),
  (55, '4', 'amosorupia24', 3, '', 4, 1, '2025-08-01 11:11:52.068304'),
  (56, '7', 'amosorupia241@gmail.com', 3, '', 4, 1, '2025-08-01 11:11:52.258626'),
  (57, '75', 'janedoreenafwande@gmail.com', 3, '', 4, 1, '2025-08-01 11:11:52.508137'),
  (58, '16', 'janewanjiku@gmail.com', 3, '', 4, 1, '2025-08-01 11:11:52.704755'),
  (59, '5', 'mommyneedschai', 3, '', 4, 1, '2025-08-01 11:11:52.871464'),
  (60, '3', 'mommyneedschai@gmail.com', 3, '', 4, 1, '2025-08-01 11:11:53.346209'),
  (61, '6', 'puritynjoroge878', 3, '', 4, 1, '2025-08-01 11:11:53.632628'),
  (62, '14', 'puritynjoroge8782@gmail.com', 3, '', 4, 1, '2025-08-01 11:11:53.820878'),
  (63, '19', 'puritynjoroge878@gmail.com', 3, '', 4, 1, '2025-08-01 11:11:53.915791'),
  (64, '13', 'puritynjorogey878@gmail.com', 3, '', 4, 1, '2025-08-01 11:11:54.145711'),
  (65, '20', 'ISSA RAEL', 2, '[{"changed": {"fields": ["Profile picture"]}}]', 19, 1, '2025-09-01 15:23:54.283643'),
  (66, '23', 'DICKSON OPIYO', 2, '[{"changed": {"fields": ["Profile picture"]}}]', 19, 1, '2025-09-01 15:24:32.967599'),
  (67, '15', 'Lucia Mwikali', 2, '[{"changed": {"fields": ["Profile picture"]}}]', 19, 1, '2025-09-01 15:25:04.676165'),
  (68, '22', 'DORCAS MULWA', 2, '[{"changed": {"fields": ["Profile picture"]}}]', 19, 1, '2025-09-01 15:25:43.650484'),
  (69, '17', 'BIBIANA MURUNGA', 2, '[{"changed": {"fields": ["Profile picture"]}}]', 19, 1, '2025-09-01 15:26:17.192519'),
  (70, '16', 'Maxwell Musa', 2, '[{"changed": {"fields": ["Profile picture"]}}]', 19, 1, '2025-09-01 15:27:28.640283'),
  (71, '18', 'ADRIAN MARUTI (25001)', 2, '[{"changed": {"fields": ["Profile Photo"]}}]', 12, 1, '2025-09-01 15:38:45.598946'),
  (72, '23', 'DICKSON OPIYO', 2, '[{"changed": {"fields": ["Is class teacher"]}}]', 19, 1, '2025-09-17 07:03:36.919976'),
  (73, '78', 'mdorcas@gmail.com', 2, '[{"changed": {"fields": ["password"]}}]', 4, 226, '2025-11-20 12:16:24.958973'),
  (74, '208', 'DANIEL Hamisi (7008)', 3, '', 12, 226, '2025-12-19 09:14:21.103938'),
  (75, '207', 'Saidah Jamila (70002)', 3, '', 12, 226, '2025-12-19 09:14:21.103998'),
  (76, '206', 'Saida Hamisi (70001)', 3, '', 12, 226, '2025-12-19 09:14:21.104019'),
  (77, '205', 'Test Student (TEST-20251121201201)', 3, '', 12, 226, '2025-12-19 09:14:21.104036'),
  (78, '204', 'ANGEL SAMUEL (25149)', 3, '', 12, 226, '2025-12-19 09:14:21.104051'),
  (79, '203', 'YANCY CHEGE (25050)', 3, '', 12, 226, '2025-12-19 09:14:21.104066'),
  (80, '202', 'VICTORIA WATIRI (25043)', 3, '', 12, 226, '2025-12-19 09:14:21.104080'),
  (81, '201', 'HUMPHREY NAMAI (25053)', 3, '', 12, 226, '2025-12-19 09:14:21.104093'),
  (82, '200', 'BONFACE ROBERT (25021)', 3, '', 12, 226, '2025-12-19 09:14:21.104107'),
  (83, '199', 'NOAH WANYAMA (25023)', 3, '', 12, 226, '2025-12-19 09:14:21.104120'),
  (84, '198', 'LYNASHER MUMO (25151)', 3, '', 12, 226, '2025-12-19 09:14:21.104134'),
  (85, '197', 'REAGAN MACHARIA (25150)', 3, '', 12, 226, '2025-12-19 09:14:21.104148'),
  (86, '195', 'KIRENGA DIVINE (25148)', 3, '', 12, 226, '2025-12-19 09:14:21.104162'),
  (87, '194', 'PRINCE BUKURU (25147)', 3, '', 12, 226, '2025-12-19 09:14:21.104176'),
  (88, '193', 'PRINCESS BUTOTO (25146)', 3, '', 12, 226, '2025-12-19 09:14:21.104189'),
  (89, '192', 'ADDY NTINZI (25145)', 3, '', 12, 226, '2025-12-19 09:14:21.104203'),
  (90, '191', 'SHARLEEN WANGUI (25144)', 3, '', 12, 226, '2025-12-19 09:14:21.104217'),
  (91, '190', 'VICTORIA WATIRI (25143)', 3, '', 12, 226, '2025-12-19 09:14:21.104231'),
  (92, '189', 'HEYDEH EVERLYNE (25139)', 3, '', 12, 226, '2025-12-19 09:14:21.104244'),
  (93, '188', 'STEPHANIE IGIRANEZA (25135)', 3, '', 12, 226, '2025-12-19 09:14:21.104258'),
  (94, '187', 'ZAMI IDRIS (25134)', 3, '', 12, 226, '2025-12-19 09:14:21.104271'),
  (95, '186', 'ROMAN KARL (25128)', 3, '', 12, 226, '2025-12-19 09:14:21.104285'),
  (96, '185', 'NATHAN EDEN (25120)', 3, '', 12, 226, '2025-12-19 09:14:21.104298'),
  (97, '182', 'Emmanuel Roberts (25140)', 3, '', 12, 226, '2025-12-19 09:14:21.104312'),
  (98, '174', 'MYLES KIMARE (25111)', 3, '', 12, 226, '2025-12-19 09:14:21.104325'),
  (99, '173', 'DAMIAN OKEO (25110)', 3, '', 12, 226, '2025-12-19 09:14:21.104338'),
  (100, '172', 'FAVOR BLESSED (25067)', 3, '', 12, 226, '2025-12-19 09:14:21.104352'),
  (101, '171', 'FLAVIAN NYABOKE (25066)', 3, '', 12, 226, '2025-12-19 09:14:21.104366'),
  (102, '170', 'CALEB OTIENO (25065)', 3, '', 12, 226, '2025-12-19 09:14:21.104379'),
  (103, '169', 'JERADINE NDUNGE (25074)', 3, '', 12, 226, '2025-12-19 09:14:21.104392'),
  (104, '168', 'NAOMI QUEEN (25064)', 3, '', 12, 226, '2025-12-19 09:14:21.104405'),
  (105, '167', 'CYNTHIA CHEPTOO (25063)', 3, '', 12, 226, '2025-12-19 09:14:21.104418'),
  (106, '166', 'BRYDEN OMOLLO (25070)', 3, '', 12, 226, '2025-12-19 09:14:21.104431'),
  (107, '165', 'MERCY MUTHEU (25062)', 3, '', 12, 226, '2025-12-19 09:14:21.104444'),
  (108, '164', 'ADDI NTINZI (25069)', 3, '', 12, 226, '2025-12-19 09:14:21.104457'),
  (109, '163', 'Ramsom Jayden (25061)', 3, '', 12, 226, '2025-12-19 09:14:21.104470'),
  (110, '162', 'MOSES NGUWENEZA (25059)', 3, '', 12, 226, '2025-12-19 09:14:21.104484'),
  (111, '161', 'MANZI ISHIMWE (25035)', 3, '', 12, 226, '2025-12-19 09:14:21.104498'),
  (112, '159', 'SOLEEN KLAIR KWAMBOKA (25133)', 3, '', 12, 226, '2025-12-19 09:14:21.104511'),
  (113, '158', 'ARIELLA BITUTU (25132)', 3, '', 12, 226, '2025-12-19 09:14:21.104538'),
  (114, '157', 'GAVIN ONGARO (25131)', 3, '', 12, 226, '2025-12-19 09:14:21.104570'),
  (115, '156', 'SOFIA LENNA (25130)', 3, '', 12, 226, '2025-12-19 09:14:21.104604'),
  (116, '155', 'MYLES KIMARI (25129)', 3, '', 12, 226, '2025-12-19 09:14:21.104636'),
  (117, '153', 'ELYN MUKASIA (25127)', 3, '', 12, 226, '2025-12-19 09:14:21.104668'),
  (118, '152', 'BEN MUGISHA (25126)', 3, '', 12, 226, '2025-12-19 09:14:21.104716'),
  (119, '151', 'MILAN SANTIAGO (25125)', 3, '', 12, 226, '2025-12-19 09:14:21.104748'),
  (120, '150', 'JAYDEN PROMISE (25124)', 3, '', 12, 226, '2025-12-19 09:14:21.104784'),
  (121, '149', 'JAYDEN HIRWA (25123)', 3, '', 12, 226, '2025-12-19 09:14:21.104819'),
  (122, '148', 'IVAN GANZA (25122)', 3, '', 12, 226, '2025-12-19 09:14:21.104855'),
  (123, '147', 'LEWIS MARANGO (25121)', 3, '', 12, 226, '2025-12-19 09:14:21.104889'),
  (124, '145', 'DANIEL NTUGUTSE (25119)', 3, '', 12, 226, '2025-12-19 09:14:21.104923'),
  (125, '144', 'SINCERE IRAKOZE (25118)', 3, '', 12, 226, '2025-12-19 09:14:21.104965'),
  (126, '143', 'BLESSINGS KERUBO (25117)', 3, '', 12, 226, '2025-12-19 09:14:21.105003'),
  (127, '142', 'TATIANA ARIELA (25116)', 3, '', 12, 226, '2025-12-19 09:14:21.105038'),
  (128, '141', 'SAMIRA AMINA (25115)', 3, '', 12, 226, '2025-12-19 09:14:21.105072'),
  (129, '140', 'JANE WANJIKU (25114)', 3, '', 12, 226, '2025-12-19 09:14:21.105106'),
  (130, '139', 'DANIEL BARAKA (25113)', 3, '', 12, 226, '2025-12-19 09:14:21.105139'),
  (131, '133', 'BRYSON KIPROP (25108)', 3, '', 12, 226, '2025-12-19 09:14:21.105171'),
  (132, '132', 'JEWEL CANDACE (25107)', 3, '', 12, 226, '2025-12-19 09:14:21.105194'),
  (133, '131', 'PRINCE GAEL (25106)', 3, '', 12, 226, '2025-12-19 09:14:21.105217'),
  (134, '130', 'ALLAN NDANYUNZWE (25105)', 3, '', 12, 226, '2025-12-19 09:14:21.105239'),
  (135, '129', 'ATETE GAELA (25104)', 3, '', 12, 226, '2025-12-19 09:14:21.105261'),
  (136, '127', 'DAVID WEKESA (250102)', 3, '', 12, 226, '2025-12-19 09:14:21.105292'),
  (137, '126', 'FOUR SAKWA (25101)', 3, '', 12, 226, '2025-12-19 09:14:21.105323'),
  (138, '125', 'RAVEN WANJIRU (25100)', 3, '', 12, 226, '2025-12-19 09:14:21.105346'),
  (139, '124', 'TETA DEBORAH (25099)', 3, '', 12, 226, '2025-12-19 09:14:21.105384'),
  (140, '123', 'GIFTON WAFULA (25098)', 3, '', 12, 226, '2025-12-19 09:14:21.105405'),
  (141, '120', 'ANGEL ACHIENG (25097)', 3, '', 12, 226, '2025-12-19 09:14:21.105426'),
  (142, '119', 'AMELIA MUTANU (25096)', 3, '', 12, 226, '2025-12-19 09:14:21.105448'),
  (143, '118', 'YUSUF OKINYI (25095)', 3, '', 12, 226, '2025-12-19 09:14:21.105470'),
  (144, '117', 'AVISHA ISHEMA (25094)', 3, '', 12, 226, '2025-12-19 09:14:21.105495'),
  (145, '116', 'MODESTE GABRIEL (25093)', 3, '', 12, 226, '2025-12-19 09:14:21.105518'),
  (146, '114', 'GISA GAEL (25091)', 3, '', 12, 226, '2025-12-19 09:14:21.105539'),
  (147, '113', 'RAYDEN AUKA (25090)', 3, '', 12, 226, '2025-12-19 09:14:21.105560'),
  (148, '110', 'JOYCE MUTONI (25087)', 3, '', 12, 226, '2025-12-19 09:14:21.105582'),
  (149, '109', 'JAYSON MUGWE (25086)', 3, '', 12, 226, '2025-12-19 09:14:21.105603'),
  (150, '108', 'NGABIRE CLEVER (25085)', 3, '', 12, 226, '2025-12-19 09:14:21.105624'),
  (151, '107', 'BENEDICT JOY (25084)', 3, '', 12, 226, '2025-12-19 09:14:21.105647'),
  (152, '106', 'KEN MUZINGA (25083)', 3, '', 12, 226, '2025-12-19 09:14:21.105669'),
  (153, '104', 'KEYLA PENDO (25081)', 3, '', 12, 226, '2025-12-19 09:14:21.105690'),
  (154, '102', 'VICTOR KAMAU (25079)', 3, '', 12, 226, '2025-12-19 09:14:21.105711'),
  (155, '101', 'DONGENIUS ALFRED (25078)', 3, '', 12, 226, '2025-12-19 09:14:21.105732'),
  (156, '100', 'HEMAN PRESENCE (25077)', 3, '', 12, 226, '2025-12-19 09:14:21.105753'),
  (157, '99', 'DYLAN MOKUA (25076)', 3, '', 12, 226, '2025-12-19 09:14:21.105775'),
  (158, '98', 'ISRAEL AMANI (25075)', 3, '', 12, 226, '2025-12-19 09:14:21.105797'),
  (159, '97', 'JERADINE NDUNGE (23074)', 3, '', 12, 226, '2025-12-19 09:14:21.105818'),
  (160, '96', 'LIAM MWANGI (25073)', 3, '', 12, 226, '2025-12-19 09:14:21.105839'),
  (161, '95', 'NGABIRE GABRIELLA (25072)', 3, '', 12, 226, '2025-12-19 09:14:21.105861'),
  (162, '93', 'BRYDEN OMOLLO (23070)', 3, '', 12, 226, '2025-12-19 09:14:21.105883'),
  (163, '92', 'ADDI NTINZI (23069)', 3, '', 12, 226, '2025-12-19 09:14:21.105904'),
  (164, '91', 'BLAISE MANZI (25068)', 3, '', 12, 226, '2025-12-19 09:14:21.105926'),
  (165, '90', 'FAVOR BLESSED (23067)', 3, '', 12, 226, '2025-12-19 09:14:21.105958'),
  (166, '89', 'FLAVIAN NYABOKE (23066)', 3, '', 12, 226, '2025-12-19 09:14:21.105980'),
  (167, '88', 'CALEB OTIENO (23065)', 3, '', 12, 226, '2025-12-19 09:14:21.106003'),
  (168, '87', 'NAOMI QUEEN (23064)', 3, '', 12, 226, '2025-12-19 09:14:21.106024'),
  (169, '86', 'CYNTHIA CHEPTOO (23063)', 3, '', 12, 226, '2025-12-19 09:14:21.106046'),
  (170, '85', 'MERCY MUTHEU (23062)', 3, '', 12, 226, '2025-12-19 09:14:21.106067'),
  (171, '84', 'RAMSOM JAYDEN (23061)', 3, '', 12, 226, '2025-12-19 09:14:21.106089'),
  (172, '83', 'NDUMFUTSE GALEA (25060)', 3, '', 12, 226, '2025-12-19 09:14:21.106110'),
  (173, '82', 'MOSES NGUWENEZA (23059)', 3, '', 12, 226, '2025-12-19 09:14:21.106131'),
  (174, '81', 'SAMUEL MESHACK (25058)', 3, '', 12, 226, '2025-12-19 09:14:41.179536'),
  (175, '80', 'ALICIA HANNAH (25057)', 3, '', 12, 226, '2025-12-19 09:14:41.179580'),
  (176, '79', 'NICHEVA ARLEY (25056)', 3, '', 12, 226, '2025-12-19 09:14:41.179602'),
  (177, '78', 'ROBIN OBISA (25055)', 3, '', 12, 226, '2025-12-19 09:14:41.179618'),
  (178, '77', 'ZACHARY PASCAL (25054)', 3, '', 12, 226, '2025-12-19 09:14:41.179633'),
  (179, '75', 'DAVID NIYONKURU (25052)', 3, '', 12, 226, '2025-12-19 09:14:41.179647'),
  (180, '74', 'PRINCESS ESTHER (25051)', 3, '', 12, 226, '2025-12-19 09:14:41.179661'),
  (181, '71', 'LEILA AJWANG (25048)', 3, '', 12, 226, '2025-12-19 09:14:41.179675'),
  (182, '70', 'OSBORNE GANZA (25047)', 3, '', 12, 226, '2025-12-19 09:14:41.179689'),
  (183, '69', 'GENESIS MASIKA (25046)', 3, '', 12, 226, '2025-12-19 09:14:41.179703'),
  (184, '68', 'KING SHEMA (25045)', 3, '', 12, 226, '2025-12-19 09:14:41.179716'),
  (185, '67', 'NKINGI GENTIL (25044)', 3, '', 12, 226, '2025-12-19 09:14:41.179730'),
  (186, '65', 'NGABO BUSOKA (25042)', 3, '', 12, 226, '2025-12-19 09:14:41.179744'),
  (187, '64', 'JOSHUA IRAKIZA (25041)', 3, '', 12, 226, '2025-12-19 09:14:41.179758'),
  (188, '63', 'BRIDGIT VINOLIA (25040)', 3, '', 12, 226, '2025-12-19 09:14:41.179771'),
  (189, '62', 'OLENNA MOKUA (25039)', 3, '', 12, 226, '2025-12-19 09:14:41.179785'),
  (190, '61', 'AMBER MAY ALFRED (25038)', 3, '', 12, 226, '2025-12-19 09:14:41.179798'),
  (191, '57', 'ELIZABETH AMELIA (25037)', 3, '', 12, 226, '2025-12-19 09:14:41.179812'),
  (192, '56', 'MANZI ISHIMWE (25036)', 3, '', 12, 226, '2025-12-19 09:14:41.179825'),
  (193, '55', 'ELIZABETH NJAMBI (25034)', 3, '', 12, 226, '2025-12-19 09:14:41.179839'),
  (194, '54', 'MARIA IDD (25033)', 3, '', 12, 226, '2025-12-19 09:14:41.179853'),
  (195, '53', 'ORPHA NYANCHAMA (25032)', 3, '', 12, 226, '2025-12-19 09:14:41.179867'),
  (196, '52', 'MARY ANNE BOSIBORI (25031)', 3, '', 12, 226, '2025-12-19 09:14:41.179880'),
  (197, '51', 'ANDREW KIRITI (25030)', 3, '', 12, 226, '2025-12-19 09:14:41.179894'),
  (198, '50', 'ETHAN MUNISHI (25029)', 3, '', 12, 226, '2025-12-19 09:14:41.179908'),
  (199, '49', 'JONATHAN OWITI (25028)', 3, '', 12, 226, '2025-12-19 09:14:41.179921'),
  (200, '47', 'GLORIA MUTHEU (25026)', 3, '', 12, 226, '2025-12-19 09:14:41.179936')
ON CONFLICT DO NOTHING;
INSERT INTO "django_admin_log" ("id", "object_id", "object_repr", "action_flag", "change_message", "content_type_id", "user_id", "action_time") VALUES
  (201, '46', 'SHANYQUE ATIENO (25025)', 3, '', 12, 226, '2025-12-19 09:14:41.179950'),
  (202, '45', 'NAOMI UWASE (25024)', 3, '', 12, 226, '2025-12-19 09:14:41.179964'),
  (203, '41', 'GIDEON WEKESA (25022)', 3, '', 12, 226, '2025-12-19 09:14:41.179977'),
  (204, '40', 'ESTHER NYAKARO (22021)', 3, '', 12, 226, '2025-12-19 09:14:41.179991'),
  (205, '39', 'LARRY ODIEKI (25020)', 3, '', 12, 226, '2025-12-19 09:14:41.180005'),
  (206, '38', 'IAN OMBUNA (25019)', 3, '', 12, 226, '2025-12-19 09:14:41.180019'),
  (207, '37', 'ANTHONY OGOLLA (25018)', 3, '', 12, 226, '2025-12-19 09:14:41.180033'),
  (208, '36', 'JAZMINE NYAMBURA (25017)', 3, '', 12, 226, '2025-12-19 09:14:41.180059'),
  (209, '35', 'JACKLINE NANTUME (25016)', 3, '', 12, 226, '2025-12-19 09:14:41.180083'),
  (210, '32', 'DAN BUSOKA (25015)', 3, '', 12, 226, '2025-12-19 09:14:41.180105'),
  (211, '31', 'LOVELY TRIXIE (25014)', 3, '', 12, 226, '2025-12-19 09:14:41.180127'),
  (212, '29', 'EMMANUEL WEKESA (25012)', 3, '', 12, 226, '2025-12-19 09:14:41.180148'),
  (213, '28', 'BLUE IVY KHASIMWA (25011)', 3, '', 12, 226, '2025-12-19 09:14:41.180172'),
  (214, '27', 'ANGEL KIRITI (25010)', 3, '', 12, 226, '2025-12-19 09:14:41.180205'),
  (215, '26', 'ANGEL PENDO (25009)', 3, '', 12, 226, '2025-12-19 09:14:41.180237'),
  (216, '25', 'CHRISTINE NDANU (25008)', 3, '', 12, 226, '2025-12-19 09:14:41.180271'),
  (217, '24', 'ARIANNA MARLEEN (25007)', 3, '', 12, 226, '2025-12-19 09:14:41.180303'),
  (218, '22', 'LAWRENCE MWASAME (25005)', 3, '', 12, 226, '2025-12-19 09:14:41.180336'),
  (219, '21', 'IAN OBISA (25004)', 3, '', 12, 226, '2025-12-19 09:14:41.180371'),
  (220, '20', 'DANIEL MUEMI (25003)', 3, '', 12, 226, '2025-12-19 09:14:41.180403'),
  (221, '19', 'TIERY NIYONYISHU (25002)', 3, '', 12, 226, '2025-12-19 09:14:41.180434'),
  (222, '18', 'ADRIAN MARUTI (25001)', 3, '', 12, 226, '2025-12-19 09:14:41.180466'),
  (223, '24', 'BENETI ROBI', 3, '', 19, 226, '2025-12-19 09:15:10.175622'),
  (224, '17', 'BIBIANA MURUNGA', 3, '', 19, 226, '2025-12-19 09:15:10.175721'),
  (225, '23', 'DICKSON OPIYO', 3, '', 19, 226, '2025-12-19 09:15:10.175780'),
  (226, '22', 'DORCAS MULWA', 3, '', 19, 226, '2025-12-19 09:15:10.175877'),
  (227, '18', 'ESTHER MUTUKU', 3, '', 19, 226, '2025-12-19 09:15:10.176004'),
  (228, '20', 'ISSA RAEL', 3, '', 19, 226, '2025-12-19 09:15:10.176079'),
  (229, '15', 'Lucia Mwikali', 3, '', 19, 226, '2025-12-19 09:15:10.176140'),
  (230, '16', 'Maxwell Musa', 3, '', 19, 226, '2025-12-19 09:15:10.176206'),
  (231, '21', 'SHARON AKINYI', 3, '', 19, 226, '2025-12-19 09:15:10.176376')
ON CONFLICT DO NOTHING;

-- config_schoolconfig (1 rows)
INSERT INTO "config_schoolconfig" ("id", "school_name", "school_code", "school_email", "school_phone", "admission_number_format", "admission_counter", "current_term", "current_year", "default_currency", "school_address", "school_logo") VALUES
  (1, 'Bishop Dr. Mando International School', '', '', '', '70000', 1386511, 'TERM_1', 2024, 'KES', '', 'school_logos/logom.jpg')
ON CONFLICT DO NOTHING;

-- schools_branch (1 rows)
INSERT INTO "schools_branch" ("id", "name", "address", "contact_phone", "is_active", "slug", "created_at", "updated_at") VALUES
  (2, 'Annex', '', '', TRUE, 'annex', '2026-01-14 05:34:41.574987', '2026-01-14 05:34:41.575038')
ON CONFLICT DO NOTHING;

-- schools_department (6 rows)
INSERT INTO "schools_department" ("id", "name", "description", "created_at", "updated_at", "is_active", "head_id", "branch_id") VALUES
  (1, 'Games and Sports', '', '2025-07-15 14:27:17.246200', '2025-07-15 14:27:17.246229', TRUE, NULL, NULL),
  (2, 'Debate', '', '2025-07-15 14:27:47.749383', '2025-07-15 14:27:47.749412', TRUE, NULL, NULL),
  (3, 'Guidance and Councelling', '', '2025-07-15 14:28:30.674373', '2025-07-15 14:28:30.674403', TRUE, NULL, NULL),
  (4, 'Academics Upper', '', '2025-07-15 14:28:57.835533', '2025-07-15 14:28:57.835566', TRUE, NULL, NULL),
  (5, 'Academics Lower', '', '2025-07-15 14:30:10.515919', '2025-07-15 14:30:10.515949', TRUE, NULL, NULL),
  (6, 'Chapel', '', '2025-07-15 14:33:42.916606', '2025-07-15 14:33:42.916634', TRUE, NULL, NULL)
ON CONFLICT DO NOTHING;

-- schools_employee (14 rows)
INSERT INTO "schools_employee" ("id", "first_name", "last_name", "email", "phone", "national_id", "position", "date_of_birth", "date_joined", "address", "profile_picture", "basic_salary", "status", "gender", "religion", "marital_status", "nationality", "department_id", "location", "branch_id") VALUES
  (13, 'Pauline', 'Onyango', 'paulinefaith988@gmail.com', '0111844749', '39093654', 'ADMIN', '2002-01-11', '2025-02-11', 'PO BOX 6675-001000', 'employee_profiles/logo.jpg', 21000, 'ACTIVE', 'F', 'CHRISTIAN', 'SINGLE', 'Kenyan', NULL, 'MAIN', NULL),
  (35, 'BRIDGET', 'NYOKABI', 'virbridgetnyokabi@bdmis.co.ke', '0797965687', '39300841', 'TEACHER', '2000-12-07', '2025-12-23', '3101 Thika', '', 0, 'ACTIVE', 'F', 'CHRISTIAN', 'SINGLE', 'Kenyan', NULL, 'MAIN', NULL),
  (36, 'Dada', 'Rita', 'dadarita@bdmis.co.ke', '0701685360', '30700602', 'PRINCIPAL', '1992-12-06', '2025-12-23', '3101-Thika', '', 0, 'ACTIVE', 'F', 'CHRISTIAN', 'MARRIED', 'Kenyan', NULL, 'MAIN', NULL),
  (37, 'Elizabeth', 'Barasa', 'elizabethbarasa@bdmis.co.ke', '0740436588', '37018780', 'TEACHER', '1999-12-16', '2025-12-23', '3101- Thika', '', 0, 'ACTIVE', 'F', 'CHRISTIAN', 'MARRIED', 'Kenyan', NULL, 'MAIN', NULL),
  (38, 'Esther', 'Waithera', 'estherwaithera@bdmis.co.ke', '0713069548', '29825106', 'TEACHER', '1993-12-05', '2024-01-19', '3101-Thika', '', 0, 'ACTIVE', 'F', 'CHRISTIAN', 'MARRIED', 'Kenyan', NULL, 'MAIN', NULL),
  (39, 'FAITH', 'GICHERU', 'faithgicheru@bdmis.co.ke', '0722691981', '14714028', 'TEACHER', '1977-05-28', '2025-12-23', '3101 THIKA', '', 0, 'ACTIVE', 'F', 'CHRISTIAN', 'SINGLE', 'Kenyan', NULL, 'MAIN', NULL),
  (40, 'Jackline', 'Nzisa', 'jacklinenzisa@bdmis.co.ke', '0708430101', '41407148', 'TEACHER', '2002-06-11', '2023-12-19', '3101-Thika', '', 0, 'ACTIVE', 'F', 'CHRISTIAN', 'SINGLE', 'Kenyan', NULL, 'MAIN', NULL),
  (41, 'LILIAN', 'WAITHERA', 'lilianwaithira@bdmis.co.ke', '0723807730', '24649881', 'PRINCIPAL', '1985-01-01', '2025-12-19', '3101 THIKA', '', 0, 'ACTIVE', 'F', 'CHRISTIAN', 'MARRIED', 'Kenyan', NULL, 'MAIN', NULL),
  (42, 'Nelly', 'Wanjiru', 'nellywanjiru@bdmis.co.ke', '0759457106', '37925422', 'TEACHER', '2000-10-31', '2022-12-19', '3101-Thika', '', 0, 'ACTIVE', 'F', 'CHRISTIAN', 'SINGLE', 'Kenyan', NULL, 'MAIN', NULL),
  (43, 'ROSE', 'NJERI', 'rosenjeri@bdmis.co.ke', '0703331080', '33889045', 'TEACHER', '1995-10-12', '2025-12-19', '3101 THIKA', '', 0, 'ACTIVE', 'F', 'CHRISTIAN', 'MARRIED', 'Kenyan', NULL, 'MAIN', NULL),
  (44, 'Salome', 'Ogai', 'salomeogai@bdmis.co.ke', '0706678821', '33206951', 'TEACHER', '1996-02-05', '2025-12-23', '3101-Thika', '', 0, 'ACTIVE', 'F', 'CHRISTIAN', 'SINGLE', 'Kenyan', NULL, 'ANNEX', NULL),
  (45, 'Salome', 'Shivona', 'salomeshivona@bdmis.co.ke', '0792649368', '33771943', 'TEACHER', '1997-02-23', '2023-04-19', '3101-Thika', '', 0, 'ACTIVE', 'F', 'CHRISTIAN', 'SINGLE', 'Kenyan', NULL, 'MAIN', NULL),
  (46, 'TERYY', 'TERYY', 'teryynyambura@bdmis.co.ke', '0703528458', '29294250', 'DEPUTY', '1990-11-14', '2025-12-19', '3101 THIKA', '', 0, 'ACTIVE', 'F', 'CHRISTIAN', 'MARRIED', 'Kenyan', NULL, 'MAIN', NULL),
  (47, 'VIRGINIA', 'WANJA', 'virginiawanja@bdmis.co.ke', '0705592781', '33769634', 'TEACHER', '1996-12-23', '2025-12-23', '3101 THIKA', '', 0, 'ACTIVE', 'F', 'CHRISTIAN', 'MARRIED', 'Kenyan', NULL, 'ANNEX', NULL)
ON CONFLICT DO NOTHING;

-- schools_grade (15 rows)
INSERT INTO "schools_grade" ("id", "name", "description", "is_active", "class_teacher_id", "term1_fees", "term2_fees", "term3_fees") VALUES
  (1, 'PG', 'CBC Playgroup', TRUE, 35, 5500, 5500, 5000),
  (2, 'PP1', 'CBC PP1', TRUE, 47, 6500, 6500, 6000),
  (3, 'PP2', 'CBC PP2', TRUE, 44, 1000, 6500, 6000),
  (4, 'G1', 'CBC Grade 1', TRUE, 46, 5000, 3000, 2599),
  (5, 'G2', 'CBC Grade 2', TRUE, 43, 7000, 7000, 6500),
  (6, 'G3', 'CBC Grade 3', TRUE, 38, 7000, 7000, 6500),
  (7, 'G4', 'CBC Grade 4', TRUE, 36, 8000, 8000, 7500),
  (8, 'G5', 'CBC Grade 5', TRUE, NULL, 8000, 8000, 7500),
  (9, 'G6', 'CBC Grade 6', TRUE, NULL, 0, 0, 0),
  (10, 'G7', 'CBC Grade 7', TRUE, NULL, 7500, 6500, 6500),
  (11, 'G8', 'CBC Grade 8', TRUE, NULL, 0, 0, 0),
  (12, 'G9', 'CBC Grade 9', TRUE, NULL, 0, 0, 0),
  (13, 'G10', 'CBC Grade 10', TRUE, NULL, 0, 0, 0),
  (14, 'G11', 'CBC Grade 11', TRUE, NULL, 0, 0, 0),
  (15, 'G12', 'CBC Grade 12', TRUE, NULL, 0, 0, 0)
ON CONFLICT DO NOTHING;

-- schools_teacher (13 rows)
INSERT INTO "schools_teacher" ("employee_ptr_id", "tsc_number", "years_of_experience", "qualifications", "certificate", "is_class_teacher", "grade_id", "user_id") VALUES
  (35, NULL, 3, 'CERT', '', TRUE, 1, 1327),
  (36, '982734', 7, 'CERT', '', TRUE, 7, 1328),
  (37, '979047', 1, 'DIP', '', TRUE, 5, 1329),
  (38, NULL, 5, 'CERT', '', TRUE, 6, 1330),
  (39, NULL, 20, 'CERT', '', TRUE, 3, 1331),
  (40, NULL, 2, 'DEG', '', TRUE, 3, 1332),
  (41, NULL, 0, 'DEG', '', TRUE, 4, 1333),
  (42, NULL, 4, 'CERT', '', TRUE, 2, 1334),
  (43, NULL, 5, 'CERT', '', TRUE, 5, 1335),
  (44, '810334', 8, 'DIP', '', TRUE, 3, 1336),
  (45, '1064982', 3, 'DEG', '', TRUE, 4, 1337),
  (46, '864586', 7, 'DIP', '', TRUE, 4, 1338),
  (47, NULL, 8, 'CERT', '', TRUE, 2, 1339)
ON CONFLICT DO NOTHING;

-- schools_teacher_subjects (108 rows)
INSERT INTO "schools_teacher_subjects" ("id", "teacher_id", "subject_id") VALUES
  (189, 35, 10),
  (190, 35, 6),
  (191, 35, 2),
  (192, 35, 3),
  (193, 35, 1),
  (194, 35, 11),
  (195, 35, 9),
  (196, 35, 5),
  (197, 36, 10),
  (198, 36, 6),
  (199, 36, 2),
  (200, 36, 3),
  (201, 36, 1),
  (202, 36, 11),
  (203, 36, 9),
  (204, 36, 5),
  (205, 37, 12),
  (206, 37, 10),
  (207, 37, 6),
  (208, 37, 2),
  (209, 37, 3),
  (210, 37, 1),
  (211, 37, 11),
  (212, 37, 9),
  (213, 37, 5),
  (214, 38, 10),
  (215, 38, 6),
  (216, 38, 2),
  (217, 38, 3),
  (218, 38, 1),
  (219, 38, 11),
  (220, 38, 9),
  (221, 38, 5),
  (222, 39, 10),
  (223, 39, 6),
  (224, 39, 2),
  (225, 39, 3),
  (226, 39, 1),
  (227, 39, 11),
  (228, 39, 9),
  (229, 39, 5),
  (230, 40, 12),
  (231, 40, 2),
  (232, 40, 3),
  (233, 40, 1),
  (234, 40, 11),
  (235, 40, 9),
  (236, 40, 5),
  (237, 41, 12),
  (238, 41, 10),
  (239, 41, 6),
  (240, 41, 2),
  (241, 41, 3),
  (242, 41, 1),
  (243, 41, 11),
  (244, 41, 9),
  (245, 41, 5),
  (246, 42, 10),
  (247, 42, 6),
  (248, 42, 2),
  (249, 42, 3),
  (250, 42, 1),
  (251, 42, 11),
  (252, 42, 9),
  (253, 42, 5),
  (254, 43, 12),
  (255, 43, 10),
  (256, 43, 6),
  (257, 43, 2),
  (258, 43, 3),
  (259, 43, 1),
  (260, 43, 11),
  (261, 43, 9),
  (262, 43, 5),
  (263, 44, 10),
  (264, 44, 6),
  (265, 44, 2),
  (266, 44, 3),
  (267, 44, 1),
  (268, 44, 11),
  (269, 44, 9),
  (270, 44, 5),
  (271, 45, 10),
  (272, 45, 6),
  (273, 45, 2),
  (274, 45, 3),
  (275, 45, 1),
  (276, 45, 11),
  (277, 45, 9),
  (278, 45, 5),
  (279, 46, 12),
  (280, 46, 10),
  (281, 46, 6),
  (282, 46, 2),
  (283, 46, 3),
  (284, 46, 1),
  (285, 46, 11),
  (286, 46, 9),
  (287, 46, 5),
  (288, 47, 10),
  (289, 47, 6),
  (290, 47, 2),
  (291, 47, 3),
  (292, 47, 1),
  (293, 47, 11),
  (294, 47, 9),
  (295, 47, 4),
  (296, 47, 5)
ON CONFLICT DO NOTHING;

-- schools_subject (12 rows)
INSERT INTO "schools_subject" ("id", "name", "description", "code") VALUES
  (1, 'Mathematics', 'CBC Mathematics subject', 'MATH'),
  (2, 'English', 'CBC English subject', 'ENG'),
  (3, 'Kiswahili', 'CBC Kiswahili subject', 'KIS'),
  (4, 'Science & Technology', 'CBC Science & Technology subject', 'SCI'),
  (5, 'Social Studies', 'CBC Social Studies subject', 'SST'),
  (6, 'Christian Religious Education', 'CBC Christian Religious Education subject', 'CRE'),
  (7, 'Islamic Religious Education', 'CBC Islamic Religious Education subject', 'IRE'),
  (8, 'Hindu Religious Education', 'CBC Hindu Religious Education subject', 'HRE'),
  (9, 'Physical & Health Education', 'CBC Physical & Health Education subject', 'PHE'),
  (10, 'Art & Craft', 'CBC Art & Craft subject', 'ART'),
  (11, 'Music', 'CBC Music subject', 'MUS'),
  (12, 'Agriculture', 'CBC Agriculture subject', 'AGR')
ON CONFLICT DO NOTHING;

-- schools_term (1 rows)
INSERT INTO "schools_term" ("id", "number", "year", "end_date", "is_current", "created_at", "updated_at", "start_date") VALUES
  (1, 1, 2025, '2025-04-30', TRUE, '2025-02-05 09:35:27.532406', '2025-02-05 09:35:27.532421', '2025-01-01')
ON CONFLICT DO NOTHING;

-- schools_route (3 rows)
INSERT INTO "schools_route" ("id", "name", "description", "start_location", "end_location", "distance", "estimated_time", "fee_per_term", "is_active", "created_at", "updated_at", "end_latitude", "end_longitude", "start_latitude", "start_longitude", "school_latitude", "school_longitude", "location") VALUES
  (1, 'Kisii Estate', '', 'Kamenu', 'Kisii Estate', 30, '40', 3500, TRUE, '2025-11-21 05:40:39.834163', '2025-11-21 05:40:39.834210', NULL, NULL, NULL, NULL, NULL, NULL, 'MAIN'),
  (2, 'Kisii Estatet', '', 'Bishop Dr. Mando International School Kamenu,BAT Kiganjo Road, Off Garissa Rd, Thika', 'Ananas Mall Thika', 50, '40', 6000, TRUE, '2025-11-26 07:29:42.493710', '2025-11-26 07:40:42.272186', NULL, NULL, NULL, NULL, NULL, NULL, 'MAIN'),
  (3, 'Kiganjo', '', 'Bishop Dr. Mando International School Kamenu,BAT Kiganjo Road, Off Garissa Rd, Thika', 'kiganjo', 30, '40', 3400, TRUE, '2025-12-02 13:38:03.988902', '2025-12-02 13:38:03.988925', NULL, NULL, NULL, NULL, NULL, NULL, 'MAIN')
ON CONFLICT DO NOTHING;

-- schools_vehicle (1 rows)
INSERT INTO "schools_vehicle" ("id", "vehicle_number", "vehicle_type", "make", "model", "year", "capacity", "status", "insurance_expiry", "registration_expiry", "notes", "created_at", "updated_at", "driver_id", "location") VALUES
  (1, 'KDK', 'BUS', 'SCANIA', 'R-T', 2021, 33, 'ACTIVE', '2026-06-10', '2025-11-27', '', '2025-11-21 05:35:40.881403', '2025-11-21 05:35:40.881449', 13, 'MAIN')
ON CONFLICT DO NOTHING;

-- schools_student (547 rows)
INSERT INTO "schools_student" ("id", "admission_number", "first_name", "last_name", "date_of_birth", "gender", "parent_name", "parent_phone", "parent_email", "parent_occupation", "parent_id_number", "academic_year", "created_at", "updated_at", "photo", "term_fees", "current_term", "birth_certificate_no", "grade_id", "previous_grade_id", "user_id", "term1_fees", "term2_fees", "term3_fees", "guardian_email", "guardian_id_number", "guardian_name", "guardian_occupation", "guardian_phone", "location", "branch_id") VALUES
  (769, '7621', 'Alvin', 'Jasmin baraka', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:53:10.292614', '2026-01-14 04:53:10.292648', '', 15000, 2, NULL, 2, NULL, 780, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (770, '7622', 'Natasha', 'njuguini', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:53:11.717718', '2026-01-14 04:53:11.717767', '', 15000, 2, NULL, 2, NULL, 781, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (771, '7599', 'Liam', 'kungu', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:53:13.480275', '2026-01-14 04:53:13.480312', '', 15000, 2, NULL, 2, NULL, 782, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (772, '7515', 'Jessin', 'Gitau', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:53:15.423400', '2026-01-14 04:53:15.423432', '', 15000, 2, NULL, 2, NULL, 783, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (773, '7608', 'Ainsley', 'wanjiku', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:53:16.761688', '2026-01-14 05:50:08.842443', '', 15000, 2, NULL, 2, NULL, 784, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (774, '7464', 'Ethan', 'isack muriuki', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:53:18.310609', '2026-01-14 04:53:18.310642', '', 15000, 2, NULL, 2, NULL, 785, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (775, '7558', 'Joy', 'Natasha wangari', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:53:20.047831', '2026-01-14 05:50:08.873296', '', 15000, 2, NULL, 2, NULL, 786, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (776, '7473', 'Allaine', 'njeri', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:53:21.439747', '2026-01-14 05:50:08.888187', '', 15000, 2, NULL, 2, NULL, 787, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (777, '7467', 'Favour', 'nduku mutisya', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:53:23.120128', '2026-01-14 05:50:08.904151', '', 15000, 2, NULL, 2, NULL, 788, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (778, '7598', 'Archie', 'gikonyo', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:53:24.665446', '2026-01-14 04:53:24.665479', '', 15000, 2, NULL, 2, NULL, 789, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (779, '7466', 'Ivy', 'wangeci', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:53:26.804688', '2026-01-14 04:53:26.804720', '', 15000, 2, NULL, 2, NULL, 790, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (780, '7600', 'Cacey', 'marya mwaluko', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:53:28.425366', '2026-01-14 04:53:28.425394', '', 15000, 2, NULL, 2, NULL, 791, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (781, '7512', 'Annabel', 'gathoni', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:53:30.042668', '2026-01-14 05:50:08.919318', '', 15000, 2, NULL, 2, NULL, 792, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (782, '7623', 'Johnson', 'induvil', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:53:31.858213', '2026-01-14 04:53:31.858241', '', 15000, 2, NULL, 2, NULL, 793, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (783, '7479', 'Shaniz', 'njeri', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:53:33.560575', '2026-01-14 05:50:08.944584', '', 15000, 2, NULL, 2, NULL, 794, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (784, '7597', 'Jasmine', 'mutheu', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:53:35.051607', '2026-01-14 04:53:35.051630', '', 15000, 2, NULL, 2, NULL, 795, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (785, '7609', 'Nelsa', 'Joshua syonthi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:53:36.830730', '2026-01-14 04:53:36.830762', '', 15000, 2, NULL, 2, NULL, 796, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (786, '7555', 'Dylan', 'james', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:53:38.470849', '2026-01-14 04:53:38.470873', '', 15000, 2, NULL, 2, NULL, 797, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (787, '7469', 'Justin', 'gitahi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:53:39.915930', '2026-01-14 04:53:39.915953', '', 15000, 2, NULL, 2, NULL, 798, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (788, '7492', 'Raziella', 'fadhila', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:53:42.333276', '2026-01-14 04:53:42.333309', '', 15000, 2, NULL, 2, NULL, 799, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (789, '7484', 'Victoria', 'mbula', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:53:43.937510', '2026-01-14 04:53:43.937541', '', 15000, 2, NULL, 2, NULL, 800, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (790, '7617', 'Octavia', 'njoki', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:53:45.318610', '2026-01-14 05:50:08.961312', '', 15000, 2, NULL, 2, NULL, 801, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (791, '7561', 'Sherleen', 'mwithaga', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:53:46.881529', '2026-01-14 04:53:46.881567', '', 15000, 2, NULL, 2, NULL, 802, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (792, '7485', 'Sophia', 'wanjira', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:53:48.472666', '2026-01-14 04:53:48.472716', '', 15000, 2, NULL, 2, NULL, 803, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (793, '7624', 'Tallia', 'gachemba', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:53:50.242837', '2026-01-14 04:53:50.243420', '', 15000, 2, NULL, 2, NULL, 804, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (794, '7497', 'Lucy', 'muthoni', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:53:52.135537', '2026-01-14 05:50:08.976135', '', 15000, 2, NULL, 2, NULL, 805, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (795, '7610', 'Precious', 'nyambura', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:53:53.744082', '2026-01-14 05:50:08.992484', '', 15000, 2, NULL, 2, NULL, 806, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (796, '7521', 'Ivanna', 'njeri', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:53:55.163879', '2026-01-14 05:50:09.004126', '', 15000, 2, NULL, 2, NULL, 807, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (797, '7297', 'Mary', 'wanjiru', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:53:56.754328', '2026-01-14 05:50:09.019337', '', 15000, 2, NULL, 2, NULL, 808, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (798, '7593', 'Abigael', 'wangari', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:53:58.331008', '2026-01-14 05:50:09.034993', '', 15000, 2, NULL, 2, NULL, 809, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (799, '7495', 'Annerlisah', 'njambi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:53:59.782217', '2026-01-14 04:53:59.782241', '', 15000, 2, NULL, 2, NULL, 810, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (800, '7604', 'Felicia', 'monthe', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:54:01.430551', '2026-01-14 04:54:01.430585', '', 15000, 2, NULL, 2, NULL, 811, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (801, '7295', 'Favour', 'watiri', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:54:03.138069', '2026-01-14 05:50:09.051540', '', 15000, 2, NULL, 2, NULL, 812, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (802, '7625', 'Ashley', 'ryan', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:54:04.527065', '2026-01-14 04:54:04.527092', '', 15000, 2, NULL, 2, NULL, 813, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (803, '7608_2', 'Stacy', 'mueni', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:54:06.235463', '2026-01-14 05:50:09.069455', '', 15000, 2, NULL, 2, NULL, 814, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (804, '7626', 'Keziah', 'ngina', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:54:07.805990', '2026-01-14 04:54:07.806019', '', 15000, 2, NULL, 2, NULL, 815, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (805, '7513', 'Ethan', 'kiguru', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:54:09.188182', '2026-01-14 04:54:09.188214', '', 15000, 2, NULL, 2, NULL, 816, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (806, '7553', 'Jason', 'maina', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:54:10.802860', '2026-01-14 04:54:10.802887', '', 15000, 2, NULL, 2, NULL, 817, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (807, '7587', 'Willson', 'mwangi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:54:12.338494', '2026-01-14 04:54:12.338526', '', 15000, 2, NULL, 2, NULL, 818, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (808, '7531', 'Vincent', 'musembi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:54:13.727531', '2026-01-14 04:54:13.727562', '', 15000, 2, NULL, 2, NULL, 819, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (809, '7602', 'Savior', 'kilonzo', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:54:15.612401', '2026-01-14 04:54:15.612431', '', 15000, 2, NULL, 2, NULL, 820, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (810, '7545', 'Erick', 'mwenda', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:54:17.283192', '2026-01-14 04:54:17.283229', '', 15000, 2, NULL, 2, NULL, 821, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (811, '7549', 'Caleb', 'githiga', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:54:18.747772', '2026-01-14 04:54:18.747804', '', 15000, 2, NULL, 2, NULL, 822, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (812, '7557', 'Vincent', 'Wekesa', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:54:20.316660', '2026-01-14 04:54:20.316714', '', 15000, 2, NULL, 2, NULL, 823, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (813, '7480', 'Mark', 'reign munene', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:54:21.976557', '2026-01-14 04:54:21.976587', '', 15000, 2, NULL, 2, NULL, 824, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (814, '7618', 'Ayaan', 'warui', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:54:23.361951', '2026-01-14 04:54:23.361975', '', 15000, 2, NULL, 2, NULL, 825, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (815, '7607', 'Prosper', 'munene', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:54:24.930577', '2026-01-14 04:54:24.930602', '', 15000, 2, NULL, 2, NULL, 826, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (816, '7505', 'Kyshia', 'tsiro', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:54:26.609338', '2026-01-14 04:54:26.609363', '', 15000, 2, NULL, 2, NULL, 827, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (817, '7468', 'Blessing', 'ndanu', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:54:27.982253', '2026-01-14 05:50:09.084320', '', 15000, 2, NULL, 2, NULL, 828, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (818, '7498', 'Abigael', 'kaloki', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:54:29.537559', '2026-01-14 05:50:09.098313', '', 15000, 2, NULL, 2, NULL, 829, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (819, '7501', 'Abigael', 'wangeci', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:54:31.395697', '2026-01-14 05:50:09.110163', '', 15000, 2, NULL, 2, NULL, 830, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (820, '7499', 'Talia', 'wangari', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:54:32.802494', '2026-01-14 05:50:09.122005', '', 15000, 2, NULL, 2, NULL, 831, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (821, '7509', 'Tauriel', 'nduta', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:54:34.369641', '2026-01-14 05:50:09.134407', '', 15000, 2, NULL, 2, NULL, 832, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (822, '7552', 'Lillyann', 'wangari', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:54:35.976229', '2026-01-14 05:50:09.145201', '', 15000, 2, NULL, 2, NULL, 833, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (823, '7530', 'Miriam', 'mutanu', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:54:37.352712', '2026-01-14 04:54:37.352744', '', 15000, 2, NULL, 2, NULL, 834, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (824, '7488', 'Shani', 'wamucii', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:54:38.925216', '2026-01-14 04:54:38.926485', '', 15000, 2, NULL, 2, NULL, 835, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (825, '7596', 'Precious', 'mutanu', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:54:40.530139', '2026-01-14 04:54:40.530169', '', 15000, 2, NULL, 2, NULL, 836, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (826, '7519', 'Sydel', 'zawadi', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:54:41.976177', '2026-01-14 05:50:09.156201', '', 15000, 2, NULL, 2, NULL, 837, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (827, '7472', 'Kayla', 'akinyi', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:54:43.564876', '2026-01-14 05:50:09.168011', '', 15000, 2, NULL, 2, NULL, 838, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (828, '7588', 'Tesslar', 'Wambui', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:54:45.198323', '2026-01-14 05:50:09.181642', '', 15000, 2, NULL, 2, NULL, 839, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (829, '7606', 'Jian', 'wamugunda', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:54:46.941900', '2026-01-14 04:54:46.941934', '', 15000, 2, NULL, 2, NULL, 840, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (830, '7544', 'Hansel', 'tumaini', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:54:48.618784', '2026-01-14 04:54:48.618815', '', 15000, 2, NULL, 2, NULL, 841, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (831, '7546', 'Fabian', 'waweru', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:54:50.191839', '2026-01-14 04:54:50.191874', '', 15000, 2, NULL, 2, NULL, 842, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (832, '7619', 'Nolan', 'rugumi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:54:51.556768', '2026-01-14 04:54:51.556803', '', 15000, 2, NULL, 2, NULL, 843, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (833, '7496', 'Maxwell', 'njuguna', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:54:53.196459', '2026-01-14 04:54:53.196491', '', 15000, 2, NULL, 2, NULL, 844, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (834, '7527', 'Raphael', 'warware', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:54:54.733208', '2026-01-14 04:54:54.733235', '', 15000, 2, NULL, 2, NULL, 845, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (835, '7529', 'Jakim', 'njagi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:54:56.161709', '2026-01-14 04:54:56.161737', '', 15000, 2, NULL, 2, NULL, 846, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (836, '7627', 'Bravin', 'james', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:54:57.770813', '2026-01-14 04:54:57.770846', '', 15000, 2, NULL, 2, NULL, 847, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (837, '7612', 'Calvin', 'George', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:54:59.340936', '2026-01-14 04:54:59.340991', '', 15000, 2, NULL, 2, NULL, 848, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (838, '7613', 'Nathan', 'mutiso', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:55:00.874677', '2026-01-14 04:55:00.874709', '', 15000, 2, NULL, 2, NULL, 849, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (839, '7605', 'Jayden', 'koome', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:55:02.975230', '2026-01-14 04:55:02.975267', '', 15000, 2, NULL, 2, NULL, 850, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (840, '7517', 'Chrysolite', 'njilani', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:55:04.534921', '2026-01-14 04:55:04.534954', '', 15000, 2, NULL, 2, NULL, 851, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (841, '7594', 'Lewis', 'm. Mwololo', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:55:05.883451', '2026-01-14 04:55:05.883475', '', 15000, 2, NULL, 2, NULL, 852, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (842, '7595', 'Prince', 'mutisya', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:55:07.513279', '2026-01-14 04:55:07.513315', '', 15000, 2, NULL, 2, NULL, 853, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (843, '7189', 'Emmanuel', 'muuo', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:55:09.092582', '2026-01-14 04:55:09.092599', '', 15000, 2, NULL, 2, NULL, 854, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (844, '7538', 'Liam', 'baraka', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:55:10.469516', '2026-01-14 04:55:10.469555', '', 15000, 2, NULL, 2, NULL, 855, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (845, '7489', 'Jayden', 'gikima wainaina', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:55:12.013840', '2026-01-14 04:55:12.013896', '', 15000, 2, NULL, 2, NULL, 856, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (846, '7615', 'Shakainah', 'njeri', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:55:13.779361', '2026-01-14 05:50:09.194974', '', 15000, 2, NULL, 2, NULL, 857, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (847, '7583', 'Prince', 'Titus', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:55:15.292430', '2026-01-14 04:55:15.292453', '', 15000, 2, NULL, 2, NULL, 858, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (848, '7507', 'Eremino', 'akello', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:55:17.266764', '2026-01-14 04:55:17.266803', '', 15000, 2, NULL, 2, NULL, 859, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (849, '7532', 'Brandon', 'kaloki', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:55:18.921961', '2026-01-14 04:55:18.921987', '', 15000, 2, NULL, 2, NULL, 860, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (850, '7585', 'Roshan', 'ndungo', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:55:20.359343', '2026-01-14 04:55:20.359380', '', 15000, 2, NULL, 2, NULL, 861, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (851, '7535', 'Wendy', 'Margret', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:55:21.928706', '2026-01-14 04:55:21.928742', '', 15000, 2, NULL, 2, NULL, 862, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (852, '7441', 'Asleen', 'warigia', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:55:23.642880', '2026-01-23 09:45:07.587758', '', 15000, 2, NULL, 3, NULL, 863, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (853, '7374', 'Aryanna', 'wanjiru', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:55:25.198113', '2026-01-23 09:45:07.669155', '', 15000, 2, NULL, 3, NULL, 864, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (854, '7478', 'Patience', 'moseti', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:55:27.061522', '2026-01-23 09:45:07.713575', '', 15000, 2, NULL, 3, NULL, 865, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (855, '7368', 'Leon', 'karanja', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:55:28.636627', '2026-01-23 09:45:07.725480', '', 15000, 2, NULL, 3, NULL, 866, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (856, '7383', 'Ummy', 'makena', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:55:29.971936', '2026-01-23 09:45:07.739102', '', 15000, 2, NULL, 3, NULL, 867, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (857, '7438', 'Joy', 'njeri', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:55:31.568103', '2026-01-23 09:45:07.918577', '', 15000, 2, NULL, 3, NULL, 868, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (858, '7425', 'Francis', 'ndungu', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:55:33.135793', '2026-01-23 09:45:08.023591', '', 15000, 2, NULL, 3, NULL, 869, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (859, '7384', 'Satrine', 'muuo', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:55:34.928165', '2026-01-23 09:45:08.035261', '', 15000, 2, NULL, 3, NULL, 870, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (860, '7310', 'Alex', 'mumo', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:55:36.832904', '2026-01-23 09:45:08.053006', '', 15000, 2, NULL, 3, NULL, 871, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (861, '7409', 'Patience', 'makena', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:55:38.538024', '2026-01-23 09:45:08.065083', '', 15000, 2, NULL, 3, NULL, 872, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (862, '7351', 'Abigael', 'wayua', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:55:39.993599', '2026-01-23 09:45:08.079775', '', 15000, 2, NULL, 3, NULL, 873, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (863, '7330', 'Belina', 'wanjiku', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:55:41.580064', '2026-01-23 09:45:08.095521', '', 15000, 2, NULL, 3, NULL, 874, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (864, '7543', 'Darrel', 'ray', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:55:43.237555', '2026-01-23 09:45:08.108340', '', 15000, 2, NULL, 3, NULL, 875, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (865, '7347', 'Sebastian', 'munene', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:55:44.610709', '2026-01-23 09:45:08.120449', '', 15000, 2, NULL, 3, NULL, 876, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (866, '7581', 'Ryker', 'francis', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:55:46.188201', '2026-01-23 09:45:08.169277', '', 15000, 2, NULL, 3, NULL, 877, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (867, '7574', 'Chloe', 'sanaipei', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:55:47.738011', '2026-01-23 09:45:08.263000', '', 15000, 2, NULL, 3, NULL, 878, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (868, '7440', 'Nathan', 'mwirigi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:55:49.140024', '2026-01-23 09:45:08.282105', '', 15000, 2, NULL, 3, NULL, 879, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (869, '7452', 'Jayden', 'mbuthia', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:55:51.061457', '2026-01-23 09:45:08.296866', '', 15000, 2, NULL, 3, NULL, 880, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (870, '7424', 'Shanell', 'katilo', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:55:52.632755', '2026-01-23 09:45:08.312636', '', 15000, 2, NULL, 3, NULL, 881, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (871, '7572', 'Louisa', 'kerubo', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:55:54.018743', '2026-01-23 09:45:08.334844', '', 15000, 2, NULL, 3, NULL, 882, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (872, '7582', 'Victor', 'macharia', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:55:55.634688', '2026-01-23 09:45:08.363320', '', 15000, 2, NULL, 3, NULL, 883, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (873, '7363', 'Roy', 'prince', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:55:57.267794', '2026-01-23 09:45:08.388777', '', 15000, 2, NULL, 3, NULL, 884, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (874, '7377', 'Adrian', 'nyaata', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:55:58.650054', '2026-01-23 09:45:08.417666', '', 15000, 2, NULL, 3, NULL, 885, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (875, '7408', 'Jayden', 'Githinji', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:56:00.258804', '2026-01-23 09:45:08.455685', '', 15000, 2, NULL, 3, NULL, 886, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (876, '7226', 'Dazzel', 'onsando', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:56:01.809636', '2026-01-23 09:45:08.477938', '', 15000, 2, NULL, 3, NULL, 887, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (877, '7426', 'Galvin', 'mukolwe', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:56:03.164784', '2026-01-23 09:45:08.577627', '', 15000, 2, NULL, 3, NULL, 888, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (878, '7311', 'Jayden', 'thuranira', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:56:04.706352', '2026-01-23 09:45:08.614859', '', 15000, 2, NULL, 3, NULL, 889, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (879, '7331', 'Elvis', 'mweti', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:56:06.460265', '2026-01-23 09:45:08.635654', '', 15000, 2, NULL, 3, NULL, 890, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (880, '7304', 'Alvin', 'kioko', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:56:08.396288', '2026-01-23 09:45:08.648398', '', 15000, 2, NULL, 3, NULL, 891, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (881, '7399', 'Adrick', 'nerian', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:56:10.387919', '2026-01-23 09:45:08.662312', '', 15000, 2, NULL, 3, NULL, 892, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (882, '7371', 'Leroy', 'muthini', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:56:12.079343', '2026-01-23 09:45:08.674485', '', 15000, 2, NULL, 3, NULL, 893, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (883, '7332', 'Myles', 'kabogo', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:56:14.664677', '2026-01-23 09:45:08.686900', '', 15000, 2, NULL, 3, NULL, 894, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (884, '7389', 'Psalmist', 'baraka', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:56:16.868840', '2026-01-23 09:45:08.730921', '', 15000, 2, NULL, 3, NULL, 895, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (885, '7401', 'Sebastian', 'chege', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:56:18.571542', '2026-01-23 09:45:08.742780', '', 15000, 2, NULL, 3, NULL, 896, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (886, '7419', 'Samuel', 'mbaru', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:56:20.772343', '2026-01-23 09:45:08.768989', '', 15000, 2, NULL, 3, NULL, 897, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (887, '7569', 'Nash', 'mwangi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:56:22.438503', '2026-01-14 04:56:22.438533', '', 15000, 2, NULL, 2, NULL, 898, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (888, '7569_2', 'Nash', 'mwangi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:56:24.243789', '2026-01-23 09:45:08.797694', '', 15000, 2, NULL, 3, NULL, 899, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (889, '7312', 'Liam', 'kamau', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:56:25.981640', '2026-01-23 09:45:08.823914', '', 15000, 2, NULL, 3, NULL, 900, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (890, '7454', 'Leon', 'baraka', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:56:27.660642', '2026-01-23 09:45:08.867468', '', 15000, 2, NULL, 3, NULL, 901, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (891, '7411', 'Alvin', 'musili', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:56:29.104319', '2026-01-23 09:45:08.887353', '', 15000, 2, NULL, 3, NULL, 902, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (892, '7471', 'Myles', 'taji', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:56:30.695621', '2026-01-23 09:45:08.898095', '', 15000, 2, NULL, 3, NULL, 903, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (893, '7589', 'Nadia', 'Margaret', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:56:32.345768', '2026-01-23 09:45:08.909662', '', 15000, 2, NULL, 3, NULL, 904, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (894, '7402', 'Eunice', 'wanjiru', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:56:33.701592', '2026-01-23 09:45:08.921415', '', 15000, 2, NULL, 3, NULL, 905, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (895, '7414', 'Taisha', 'Reene njeri', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:56:35.287050', '2026-01-23 09:45:08.932453', '', 15000, 2, NULL, 3, NULL, 906, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (896, '7356', 'Maryann', 'wacera', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:56:36.831681', '2026-01-23 09:45:08.944295', '', 15000, 2, NULL, 3, NULL, 907, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (897, '7430', 'Shirleen', 'njeri', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:56:38.339663', '2026-01-23 09:45:08.955918', '', 15000, 2, NULL, 3, NULL, 908, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (898, '7320', 'Sharon', 'moraa', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:56:40.145221', '2026-01-23 09:45:08.967225', '', 15000, 2, NULL, 3, NULL, 909, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (899, '7559', 'Princess', 'chelegat', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:56:42.072719', '2026-01-23 09:45:08.979635', '', 15000, 2, NULL, 3, NULL, 910, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (900, '7447', 'Princess', 'nyambura', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:56:43.910509', '2026-01-23 09:45:08.996251', '', 15000, 2, NULL, 3, NULL, 911, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (901, '7447_2', 'Blessing', 'nyambura', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:56:45.673924', '2026-01-23 09:45:09.008256', '', 15000, 2, NULL, 3, NULL, 912, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (902, '7477', 'Prudence', 'mutheu', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:56:47.352453', '2026-01-23 09:45:09.020019', '', 15000, 2, NULL, 3, NULL, 913, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (903, '7380', 'Varelie', 'makena', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:56:48.728413', '2026-01-23 09:45:09.032064', '', 15000, 2, NULL, 3, NULL, 914, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (904, '7405', 'Grace', 'mutheu', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:56:50.493025', '2026-01-23 09:45:09.047725', '', 15000, 2, NULL, 3, NULL, 915, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (905, '7378', 'Andy', 'kirathi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:56:52.179157', '2026-01-23 09:45:09.060948', '', 15000, 2, NULL, 3, NULL, 916, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (906, '7565', 'Levis', 'waiti', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:56:53.812349', '2026-01-23 09:45:09.072544', '', 15000, 2, NULL, 3, NULL, 917, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (907, '7554', 'Caleb', 'muuo', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:56:55.489386', '2026-01-23 09:45:09.143008', '', 15000, 2, NULL, 3, NULL, 918, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (908, '7355', 'John', 'myles', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:56:57.276027', '2026-01-23 09:45:09.153037', '', 15000, 2, NULL, 3, NULL, 919, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (909, '7313', 'Mike', 'zion', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:56:59.240077', '2026-01-23 09:45:09.164609', '', 15000, 2, NULL, 3, NULL, 920, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (910, '7372', 'Jayden', 'baraka', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:57:00.833111', '2026-01-23 09:45:09.176364', '', 15000, 2, NULL, 3, NULL, 921, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (911, '7547', 'Luiz', 'kamande', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:57:02.472269', '2026-01-23 09:45:09.187941', '', 15000, 2, NULL, 3, NULL, 922, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (912, '7382', 'Keith', 'Richard', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:57:03.914581', '2026-01-23 09:45:09.198772', '', 15000, 2, NULL, 3, NULL, 923, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (913, '7326', 'Samuel', 'irungu', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:57:05.527728', '2026-01-23 09:45:09.210135', '', 15000, 2, NULL, 3, NULL, 924, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (914, '7439', 'Brayden', 'nuthu', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:57:07.125453', '2026-01-23 09:45:09.221934', '', 15000, 2, NULL, 3, NULL, 925, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (915, '7381', 'Jayden', 'muturi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:57:08.578582', '2026-01-23 09:45:09.233020', '', 15000, 2, NULL, 3, NULL, 926, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (916, '7448', 'Liam', 'mwangi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:57:10.113312', '2026-01-23 09:45:09.245603', '', 15000, 2, NULL, 3, NULL, 927, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (917, '7448_2', 'Liam', 'mwangi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:57:12.068379', '2026-01-23 09:45:09.257358', '', 15000, 2, NULL, 3, NULL, 928, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (918, '7528', 'Shannah', 'wanjiru', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:57:13.919825', '2026-01-23 09:45:09.269266', '', 15000, 2, NULL, 3, NULL, 929, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (919, '7359', 'Mercy', 'wamuhu', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:57:15.791707', '2026-01-23 09:45:09.285654', '', 15000, 2, NULL, 3, NULL, 930, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (920, '7358', 'Shanell', 'murugi', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:57:17.344109', '2026-01-23 09:45:09.298819', '', 15000, 2, NULL, 3, NULL, 931, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (921, '7578', 'Latifa', 'rukia', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:57:18.816188', '2026-01-23 09:45:09.313787', '', 15000, 2, NULL, 3, NULL, 932, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (922, '7563', 'Silver', 'favor', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:57:20.487076', '2026-01-23 09:45:09.337643', '', 15000, 2, NULL, 3, NULL, 933, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (923, '7453', 'Adah', 'bonareri', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:57:22.094957', '2026-01-23 09:45:09.352904', '', 15000, 2, NULL, 3, NULL, 934, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (924, '7539', 'Whitney', 'G Richard', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:57:23.536259', '2026-01-23 09:45:09.366880', '', 15000, 2, NULL, 3, NULL, 935, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (925, '7573', 'Yazmin', 'nyambura', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:57:25.278656', '2026-01-23 09:45:09.380053', '', 15000, 2, NULL, 3, NULL, 936, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (926, '7314', 'Queenshi', 'Wambui', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:57:26.880325', '2026-01-23 09:45:09.395505', '', 15000, 2, NULL, 3, NULL, 937, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (927, '7376', 'Chloe', 'wanjiku', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:57:28.286507', '2026-01-23 09:45:09.408328', '', 15000, 2, NULL, 3, NULL, 938, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (928, '7494', 'Magdalene', 'Nkatha', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:57:29.854175', '2026-01-23 09:45:09.430678', '', 15000, 2, NULL, 3, NULL, 939, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (929, '7620', 'Mary', 'nyakerario', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:57:31.569870', '2026-01-23 09:45:09.443615', '', 15000, 2, NULL, 3, NULL, 940, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (930, '7334', 'Precious', 'mwende', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:57:32.969569', '2026-01-23 09:45:09.596933', '', 15000, 2, NULL, 3, NULL, 941, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (931, '7321', 'Natalia', 'ndanu', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:57:34.581006', '2026-01-23 09:45:09.634875', '', 15000, 2, NULL, 3, NULL, 942, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (932, '7305', 'Tracey', 'wambui', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:57:36.177173', '2026-01-23 09:45:09.648840', '', 15000, 2, NULL, 3, NULL, 943, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (933, '7511', 'Claire', 'nekesa', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:57:37.552695', '2026-01-23 09:45:09.663558', '', 15000, 2, NULL, 3, NULL, 944, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (934, '7360', 'Maryann', 'wanjiku', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:57:39.169036', '2026-01-23 09:45:09.694553', '', 15000, 2, NULL, 3, NULL, 945, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (935, '7611', 'Brilliantine', 'kavoki', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:57:40.866471', '2026-01-23 09:45:09.767358', '', 15000, 2, NULL, 3, NULL, 946, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (936, '7551', 'Henry', 'muindi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:57:42.941428', '2026-01-23 09:45:09.791236', '', 15000, 2, NULL, 3, NULL, 947, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (937, '7443', 'Miriam', 'zawadi', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:57:44.582207', '2026-01-23 09:45:09.805484', '', 15000, 2, NULL, 3, NULL, 948, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (938, '7432', 'Abigeal', 'njeri', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:57:45.978132', '2026-01-23 09:45:09.827143', '', 15000, 2, NULL, 3, NULL, 949, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (939, '7397', 'Briton', 'kirira', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:57:47.667762', '2026-01-23 09:45:09.840028', '', 15000, 2, NULL, 3, NULL, 950, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (940, '7293', 'Ann', 'Waithira', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:57:49.268895', '2026-01-23 09:45:09.854597', '', 15000, 2, NULL, 3, NULL, 951, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (941, '7221', 'Beth', 'wanjiku', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:57:50.688562', '2026-01-24 17:51:59.660678', '', 3000, 2, NULL, 4, NULL, 952, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (942, '7475', 'Blessed', 'samuel', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:57:52.298754', '2026-01-24 17:51:59.679501', '', 3000, 2, NULL, 4, NULL, 953, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (943, '7564', 'Melvin', 'ngugi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:57:53.922108', '2026-01-24 17:51:59.690735', '', 3000, 2, NULL, 4, NULL, 954, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (944, '7247', 'Victor', 'muteti', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:57:55.360363', '2026-01-24 17:51:59.702353', '', 3000, 2, NULL, 4, NULL, 955, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (945, '7193', 'Simon', 'mboche', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:57:56.941847', '2026-01-24 17:51:59.713266', '', 3000, 2, NULL, 4, NULL, 956, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (946, '7268', 'Gyan', 'maina', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:57:58.757972', '2026-01-24 17:51:59.724625', '', 3000, 2, NULL, 4, NULL, 957, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (947, '7520', 'Bryson', 'otanga', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:58:00.210454', '2026-01-24 17:51:59.734760', '', 3000, 2, NULL, 4, NULL, 958, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (948, '7437', 'Haysen', 'bahati', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:58:01.799500', '2026-01-24 17:51:59.745371', '', 3000, 2, NULL, 4, NULL, 959, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (949, '7256', 'Elvis', 'kingori', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:58:03.528892', '2026-01-24 17:51:59.757746', '', 3000, 2, NULL, 4, NULL, 960, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (950, '7233', 'Dylan', 'wafula', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:58:04.935568', '2026-01-24 17:51:59.769416', '', 3000, 2, NULL, 4, NULL, 961, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (951, '7211', 'Ryan', 'wambugu', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:58:06.524589', '2026-01-24 17:51:59.781388', '', 3000, 2, NULL, 4, NULL, 962, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (952, '7548', 'Ray', 'kyan jabulani', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:58:08.143135', '2026-01-24 17:51:59.801186', '', 3000, 2, NULL, 4, NULL, 963, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (953, '7286', 'Liam', 'njuguna', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:58:09.585491', '2026-01-24 17:51:59.816564', '', 3000, 2, NULL, 4, NULL, 964, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (954, '7222', 'Liam', 'mutua', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:58:11.195735', '2026-01-24 17:51:59.833490', '', 3000, 2, NULL, 4, NULL, 965, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (955, '7267', 'Brandon', 'musyimi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:58:13.004020', '2026-01-24 17:51:59.855827', '', 3000, 2, NULL, 4, NULL, 966, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (956, '7206', 'John', 'ogola', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:58:14.459763', '2026-01-24 17:51:59.877809', '', 3000, 2, NULL, 4, NULL, 967, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (957, '7481', 'Rahab', 'mwihaki', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:58:16.055600', '2026-01-24 17:51:59.894255', '', 3000, 2, NULL, 4, NULL, 968, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (958, '7486', 'Susan', 'Waithira', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:58:17.681733', '2026-01-24 17:51:59.906355', '', 3000, 2, NULL, 4, NULL, 969, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (959, '7269', 'Kaylee', 'nyambura', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:58:19.148133', '2026-01-24 17:51:59.917433', '', 3000, 2, NULL, 4, NULL, 970, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (960, '7415', 'Tiffany', 'nyawira', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:58:20.696383', '2026-01-24 17:51:59.927480', '', 3000, 2, NULL, 4, NULL, 971, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (961, '7301', 'Natasha', 'aliyah', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:58:22.345537', '2026-01-24 17:51:59.937839', '', 3000, 2, NULL, 4, NULL, 972, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (962, '7279', 'Favour', 'wanjiru', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:58:23.726522', '2026-01-24 17:51:59.948276', '', 3000, 2, NULL, 4, NULL, 973, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (963, '7277', 'Gianna', 'waruiru', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:58:25.510074', '2026-01-24 17:51:59.958748', '', 3000, 2, NULL, 4, NULL, 974, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (964, '7196', 'Ivanna', 'zawadi', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:58:27.053107', '2026-01-24 17:51:59.970581', '', 3000, 2, NULL, 4, NULL, 975, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (965, '7244', 'Jianna', 'pendo', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:58:28.486921', '2026-01-24 17:51:59.980984', '', 3000, 2, NULL, 4, NULL, 976, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (966, '7461', 'Brevian', 'kemuma', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:58:30.191219', '2026-01-24 17:51:59.991708', '', 3000, 2, NULL, 4, NULL, 977, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (967, '7236', 'Neema', 'wanjiku', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:58:31.797445', '2026-01-24 17:52:00.001674', '', 3000, 2, NULL, 4, NULL, 978, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (968, '7280', 'Joy', 'wanjiru', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:58:33.207039', '2026-01-24 17:52:00.012364', '', 3000, 2, NULL, 4, NULL, 979, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL)
ON CONFLICT DO NOTHING;
INSERT INTO "schools_student" ("id", "admission_number", "first_name", "last_name", "date_of_birth", "gender", "parent_name", "parent_phone", "parent_email", "parent_occupation", "parent_id_number", "academic_year", "created_at", "updated_at", "photo", "term_fees", "current_term", "birth_certificate_no", "grade_id", "previous_grade_id", "user_id", "term1_fees", "term2_fees", "term3_fees", "guardian_email", "guardian_id_number", "guardian_name", "guardian_occupation", "guardian_phone", "location", "branch_id") VALUES
  (969, '7077', 'Blessing', 'karimi', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:58:34.911065', '2026-01-24 17:52:00.023787', '', 3000, 2, NULL, 4, NULL, 980, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (970, '7205', 'Blessing', 'wanjiru', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:58:36.554815', '2026-01-24 17:52:00.036179', '', 3000, 2, NULL, 4, NULL, 981, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (971, '7404', 'Princess', 'sophia', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:58:37.910742', '2026-01-24 17:52:00.049538', '', 3000, 2, NULL, 4, NULL, 982, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (972, '7245', 'Tamara', 'Wambui', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:58:39.744161', '2026-01-24 17:52:00.060682', '', 3000, 2, NULL, 4, NULL, 983, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (973, '7223', 'Paisley', 'akinyi', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:58:41.342754', '2026-01-24 17:52:00.128600', '', 3000, 2, NULL, 4, NULL, 984, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (974, '7255', 'Angel', 'wambui', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:58:43.159586', '2026-01-24 17:52:00.156102', '', 3000, 2, NULL, 4, NULL, 985, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (975, '7218', 'Jewel', 'Telia', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:58:44.870234', '2026-01-24 17:52:00.166825', '', 3000, 2, NULL, 4, NULL, 986, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (976, '7252', 'Neema', 'Georgina', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:58:46.463389', '2026-01-24 17:52:00.183373', '', 3000, 2, NULL, 4, NULL, 987, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (977, '7235', 'Angel', 'wamaitha', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:58:47.851955', '2026-01-24 17:52:00.217440', '', 3000, 2, NULL, 4, NULL, 988, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (978, '7215', 'Olivia', 'zamar', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:58:49.420738', '2026-01-24 17:52:00.232404', '', 3000, 2, NULL, 4, NULL, 989, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (979, '7248', 'Natalia', 'Nduku', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:58:51.234292', '2026-01-24 17:52:00.244084', '', 3000, 2, NULL, 4, NULL, 990, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (980, '7213', 'Cynthia', 'Wambui', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:58:52.669246', '2026-01-24 17:52:00.257211', '', 3000, 2, NULL, 4, NULL, 991, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (981, '7336', 'Mitchel', 'wanjiku', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:58:54.341319', '2026-01-24 17:52:00.382925', '', 3000, 2, NULL, 4, NULL, 992, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (982, '7601', 'Everlyne', 'Wairimu', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:58:55.892522', '2026-01-24 17:52:00.399545', '', 3000, 2, NULL, 4, NULL, 993, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (983, '7209', 'Shelby', 'Wairimu', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:58:57.297318', '2026-01-24 17:52:00.412665', '', 3000, 2, NULL, 4, NULL, 994, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (984, '7287', 'Skylar', 'wanjiru', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:58:58.925852', '2026-01-24 17:52:00.424731', '', 3000, 2, NULL, 4, NULL, 995, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (985, '7254', 'Lesley', 'makena', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:59:00.509908', '2026-01-24 17:52:00.434427', '', 3000, 2, NULL, 4, NULL, 996, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (986, '7379', 'Abigael', 'nyambura', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:59:01.915301', '2026-01-24 17:52:00.445834', '', 3000, 2, NULL, 4, NULL, 997, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (987, '7446', 'Olivia', 'Wairimu', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:59:03.616962', '2026-01-24 17:52:00.459428', '', 3000, 2, NULL, 4, NULL, 998, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (988, '7450', 'Nash', 'nyakundi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:59:05.234662', '2026-01-24 17:52:00.471593', '', 3000, 2, NULL, 4, NULL, 999, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (989, '7249', 'Jesse', 'Kanja', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:59:06.866628', '2026-01-24 17:52:00.484717', '', 3000, 2, NULL, 4, NULL, 1000, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (990, '7357', 'Darlington', 'Kaaria', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:59:08.592174', '2026-01-24 17:52:00.495598', '', 3000, 2, NULL, 4, NULL, 1001, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (991, '7289', 'Clement', 'andega', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:59:10.186534', '2026-01-24 17:52:00.581991', '', 3000, 2, NULL, 4, NULL, 1002, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (992, '7260', 'Lian', 'mwangi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:59:11.634345', '2026-01-24 17:52:00.593063', '', 3000, 2, NULL, 4, NULL, 1003, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (993, '7232', 'Richard', 'Leon', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:59:13.307702', '2026-01-24 17:52:00.603218', '', 3000, 2, NULL, 4, NULL, 1004, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (994, '7300', 'Alexander', 'mucheke', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:59:14.916047', '2026-01-24 17:52:00.612389', '', 3000, 2, NULL, 4, NULL, 1005, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (995, '7238', 'Timothy', 'mburu', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:59:16.529245', '2026-01-24 17:52:00.623020', '', 3000, 2, NULL, 4, NULL, 1006, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (996, '7201', 'James', 'kamiti', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:59:18.242027', '2026-01-24 17:52:00.633063', '', 3000, 2, NULL, 4, NULL, 1007, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (997, '7237', 'Austin', 'mwangi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:59:19.803915', '2026-01-24 17:52:00.643575', '', 3000, 2, NULL, 4, NULL, 1008, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (998, '7194', 'Alpha', 'chege', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:59:21.350470', '2026-01-24 17:52:00.654553', '', 3000, 2, NULL, 4, NULL, 1009, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (999, '7294', 'Victor', 'ndambuki', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:59:23.203767', '2026-01-24 17:52:00.664822', '', 3000, 2, NULL, 4, NULL, 1010, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1000, '7229', 'Abigael', 'wanjiku', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:59:24.760754', '2026-01-24 17:52:00.675212', '', 3000, 2, NULL, 4, NULL, 1011, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1001, '7227', 'Teresiah', 'nyambura', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:59:26.149132', '2026-01-24 17:52:00.686250', '', 3000, 2, NULL, 4, NULL, 1012, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1002, '7150', 'Angeliz', 'Wambui', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:59:27.763519', '2026-01-14 05:50:12.823156', '', 15000, 2, NULL, 5, NULL, 1013, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1003, '7188', 'Gift', 'keya', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:59:29.479726', '2026-01-14 04:59:29.479763', '', 15000, 2, NULL, 5, NULL, 1014, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1004, '7108', 'Banice', 'nyambura', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:59:30.853241', '2026-01-14 05:50:12.874704', '', 15000, 2, NULL, 5, NULL, 1015, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1005, '7176', 'Christiana', 'mbithe', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:59:32.597877', '2026-01-14 04:59:32.597907', '', 15000, 2, NULL, 5, NULL, 1016, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1006, '7115', 'Teddy', 'nderitu', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:59:34.269275', '2026-01-14 04:59:34.269310', '', 15000, 2, NULL, 5, NULL, 1017, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1007, '7428', 'Elishah', 'mumo', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:59:35.730110', '2026-01-14 04:59:35.730140', '', 15000, 2, NULL, 5, NULL, 1018, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1008, '7586', 'Kaylie', 'kawayi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:59:37.379364', '2026-01-14 04:59:37.379391', '', 15000, 2, NULL, 5, NULL, 1019, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1009, '7080', 'Billy', 'braham', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:59:39.100651', '2026-01-14 04:59:39.100678', '', 15000, 2, NULL, 5, NULL, 1020, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1010, '7183', 'Jane', 'mellisa', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:59:40.551636', '2026-01-14 05:50:12.890513', '', 15000, 2, NULL, 5, NULL, 1021, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1011, '7178', 'Linet', 'njoki', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:59:42.565075', '2026-01-14 05:50:12.918255', '', 15000, 2, NULL, 5, NULL, 1022, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1012, '7524', 'Richard', 'Riccardo', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:59:44.315805', '2026-01-14 04:59:44.315840', '', 15000, 2, NULL, 5, NULL, 1023, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1013, '7493', 'John', 'muturo', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:59:45.725376', '2026-01-14 04:59:45.725410', '', 15000, 2, NULL, 5, NULL, 1024, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1014, '7422', 'Ryan', 'munyalo', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:59:47.288916', '2026-01-14 04:59:47.288942', '', 15000, 2, NULL, 5, NULL, 1025, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1015, '7131', 'Ryan', 'murangili', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:59:48.877532', '2026-01-14 04:59:48.877566', '', 15000, 2, NULL, 5, NULL, 1026, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1016, '7187', 'Kent', 'kimani', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:59:50.315423', '2026-01-14 04:59:50.315473', '', 15000, 2, NULL, 5, NULL, 1027, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1017, '7119', 'Ryan', 'kariuki', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:59:51.923421', '2026-01-14 04:59:51.923446', '', 15000, 2, NULL, 5, NULL, 1028, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1018, '7123', 'Ignitious', 'baraka', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:59:53.619333', '2026-01-14 04:59:53.619362', '', 15000, 2, NULL, 5, NULL, 1029, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1019, '7242', 'Millan', 'mutwiri', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:59:55.421710', '2026-01-14 04:59:55.421746', '', 15000, 2, NULL, 5, NULL, 1030, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1020, '7210', 'Edward', 'mucheru', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:59:57.055370', '2026-01-14 04:59:57.055397', '', 15000, 2, NULL, 5, NULL, 1031, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1021, '7137', 'Leon', 'maina', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 04:59:58.621347', '2026-01-14 04:59:58.621374', '', 15000, 2, NULL, 5, NULL, 1032, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1022, '7161', 'Jeff', 'kimani', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:00:00.032289', '2026-01-14 05:00:00.032321', '', 15000, 2, NULL, 5, NULL, 1033, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1023, '7129', 'Mike', 'Njoroge', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:00:01.629551', '2026-01-14 05:00:01.629583', '', 15000, 2, NULL, 5, NULL, 1034, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1024, '7483', 'Daniel', 'k nyabuto', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:00:03.206129', '2026-01-14 05:00:03.206163', '', 15000, 2, NULL, 5, NULL, 1035, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1025, '7476', 'Owen', 'Stephen', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:00:04.658145', '2026-01-14 05:00:04.658179', '', 15000, 2, NULL, 5, NULL, 1036, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1026, '7459', 'Ryan', 'kamau', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:00:06.323602', '2026-01-14 05:00:06.323634', '', 15000, 2, NULL, 5, NULL, 1037, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1027, '7491', 'Angel', 'Gatabi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:00:07.937740', '2026-01-14 05:00:07.937771', '', 15000, 2, NULL, 5, NULL, 1038, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1028, '7130', 'Laura', 'Grace', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:00:09.418172', '2026-01-14 05:50:12.936907', '', 15000, 2, NULL, 5, NULL, 1039, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1029, '7140', 'Evarose', 'warau', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:00:11.265225', '2026-01-14 05:00:11.265257', '', 15000, 2, NULL, 5, NULL, 1040, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1030, '7198', 'Jedidah', 'amani', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:00:12.901465', '2026-01-14 05:00:12.901490', '', 15000, 2, NULL, 5, NULL, 1041, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1031, '7181', 'Judith', 'amalia', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:00:14.341418', '2026-01-14 05:00:14.341445', '', 15000, 2, NULL, 5, NULL, 1042, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1032, '7139', 'Blessing', 'Wambui kingori', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:00:16.115328', '2026-01-14 05:50:12.956734', '', 15000, 2, NULL, 5, NULL, 1043, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1033, '7120', 'Claire', 'waithera', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:00:17.724450', '2026-01-14 05:50:12.980465', '', 15000, 2, NULL, 5, NULL, 1044, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1034, '7100', 'Christabel', 'Wambui', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:00:19.144402', '2026-01-14 05:50:13.000753', '', 15000, 2, NULL, 5, NULL, 1045, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1035, '7580', 'Telaviv', 'Njeri', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:00:20.739445', '2026-01-14 05:50:13.030172', '', 15000, 2, NULL, 5, NULL, 1046, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1036, '7124', 'Grace', 'Lexi wanjiku', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:00:22.390494', '2026-01-14 05:50:13.048127', '', 15000, 2, NULL, 5, NULL, 1047, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1037, '7462', 'Rael', 'makena', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:00:23.800576', '2026-01-14 05:50:13.074637', '', 15000, 2, NULL, 5, NULL, 1048, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1038, '7111', 'Talia', 'mwende', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:00:25.427704', '2026-01-14 05:00:25.428198', '', 15000, 2, NULL, 5, NULL, 1049, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1039, '7112', 'Jasmine', 'wanjiku', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:00:27.226562', '2026-01-14 05:50:13.091499', '', 15000, 2, NULL, 5, NULL, 1050, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1040, '7106', 'Daisy', 'Wambui', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:00:29.077928', '2026-01-14 05:50:13.119499', '', 15000, 2, NULL, 5, NULL, 1051, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1041, '7179', 'Natalia', 'wangui', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:00:30.835406', '2026-01-14 05:50:13.147511', '', 15000, 2, NULL, 5, NULL, 1052, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1042, '7110', 'Ivy', 'wamaitha', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:00:32.427681', '2026-01-14 05:00:32.427717', '', 15000, 2, NULL, 5, NULL, 1053, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1043, '7575', 'Maryjoy', 'nanjala', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:00:33.869605', '2026-01-14 05:00:33.869642', '', 15000, 2, NULL, 5, NULL, 1054, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1044, '7190', 'Trevin', 'ndira', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:00:35.429454', '2026-01-14 05:00:35.429486', '', 15000, 2, NULL, 5, NULL, 1055, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1045, '7525', 'Aristotle', 'onyoit anericho', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:00:37.051138', '2026-01-14 05:00:37.051171', '', 15000, 2, NULL, 5, NULL, 1056, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1046, '7127', 'Daniel', 'katisya', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:00:38.569845', '2026-01-14 05:00:38.569891', '', 15000, 2, NULL, 5, NULL, 1057, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1047, '7128', 'Chabel', 'muigai', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:00:40.405650', '2026-01-14 05:00:40.405686', '', 15000, 2, NULL, 5, NULL, 1058, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1048, '7518', 'Freedom', 'kioko', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:00:42.130124', '2026-01-14 05:00:42.130220', '', 15000, 2, NULL, 5, NULL, 1059, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1049, '7274', 'Christopher', 'kamau', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:00:44.155967', '2026-01-14 05:00:44.155993', '', 15000, 2, NULL, 5, NULL, 1060, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1050, '7121', 'Stephen', 'Gichane', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:00:45.793366', '2026-01-14 05:00:45.793402', '', 15000, 2, NULL, 5, NULL, 1061, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1051, '7122', 'Boniface', 'maingi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:00:47.241539', '2026-01-14 05:00:47.241565', '', 15000, 2, NULL, 5, NULL, 1062, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1052, '7200', 'Simon', 'chira', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:00:48.807038', '2026-01-14 05:00:48.807066', '', 15000, 2, NULL, 5, NULL, 1063, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1053, '7109', 'Garvin', 'kuria', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:00:50.429819', '2026-01-14 05:00:50.429853', '', 15000, 2, NULL, 5, NULL, 1064, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1054, '7219', 'Levis', 'rakita', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:00:51.821705', '2026-01-14 05:00:51.821736', '', 15000, 2, NULL, 5, NULL, 1065, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1055, '7217', 'Lovren', 'nyandega', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:00:53.392743', '2026-01-14 05:00:53.392768', '', 15000, 2, NULL, 5, NULL, 1066, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1056, '7298', 'Jayden', 'mburu', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:00:54.986808', '2026-01-14 05:00:54.986841', '', 15000, 2, NULL, 5, NULL, 1067, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1057, '7540', 'Israel', 'brook', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:00:56.397539', '2026-01-14 05:00:56.397592', '', 15000, 2, NULL, 5, NULL, 1068, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1058, '7113', 'Justin', 'Boaz', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:00:58.003480', '2026-01-14 05:00:58.003515', '', 15000, 2, NULL, 5, NULL, 1069, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1059, '7134', 'Gilbert', 'maina', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:00:59.929881', '2026-01-14 05:00:59.929915', '', 15000, 2, NULL, 5, NULL, 1070, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1060, '7116', 'Ethan', 'maverick wamai', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:01:01.407531', '2026-01-14 05:01:01.407565', '', 15000, 2, NULL, 5, NULL, 1071, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1061, '7251', 'Francis', 'njora', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:01:03.041852', '2026-01-14 05:01:03.041878', '', 15000, 2, NULL, 5, NULL, 1072, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1062, '7132', 'Treyvion', 'wanyoike', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:01:04.705353', '2026-01-14 05:01:04.705385', '', 15000, 2, NULL, 5, NULL, 1073, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1063, '7117', 'Abigael', 'Nduku', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:01:06.055767', '2026-01-14 05:50:13.164726', '', 15000, 2, NULL, 5, NULL, 1074, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1064, '7616', 'Blessing', 'mbesa', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:01:07.685289', '2026-01-14 05:50:13.187950', '', 15000, 2, NULL, 5, NULL, 1075, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1065, '7386', 'Veronica', 'wanjiku', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:01:09.424599', '2026-01-14 05:50:13.206390', '', 15000, 2, NULL, 5, NULL, 1076, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1066, '7241', 'Precious', 'kathure', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:01:10.816098', '2026-01-14 05:01:10.816156', '', 15000, 2, NULL, 5, NULL, 1077, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1067, '7118', 'Liser', 'mukami', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:01:12.734999', '2026-01-14 05:50:13.279879', '', 15000, 2, NULL, 5, NULL, 1078, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1068, '7628', 'Lucy', 'Wambui', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:01:14.428705', '2026-01-14 05:50:13.363934', '', 15000, 2, NULL, 5, NULL, 1079, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1069, '7114', 'Maryer', 'nyakeru', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:01:16.249886', '2026-01-14 05:01:16.249922', '', 15000, 2, NULL, 5, NULL, 1080, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1070, '7362', 'Blessing', 'Wambui', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:01:18.248615', '2026-01-14 05:50:13.446497', '', 15000, 2, NULL, 5, NULL, 1081, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1071, '7177', 'Jasmine', 'nduku', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:01:20.512375', '2026-01-14 05:01:20.512409', '', 15000, 2, NULL, 5, NULL, 1082, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1072, '7125', 'Destiny', 'mumbe', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:01:23.134589', '2026-01-14 05:01:23.134634', '', 15000, 2, NULL, 5, NULL, 1083, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1073, '7216', 'Joy', 'mwikali', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:01:25.849215', '2026-01-14 05:50:13.487593', '', 15000, 2, NULL, 5, NULL, 1084, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1074, '7126', 'Lorna', 'kwamboka', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:01:27.759199', '2026-01-14 05:50:13.500253', '', 15000, 2, NULL, 5, NULL, 1085, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1075, '7180', 'Zuri', 'wairimu', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:01:29.640456', '2026-01-14 05:50:13.514438', '', 15000, 2, NULL, 5, NULL, 1086, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1076, '7338', 'Princess', 'Muthoni', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:01:31.499555', '2026-01-14 05:50:13.529285', '', 15000, 2, NULL, 5, NULL, 1087, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1077, '7142', 'Emmanuel', 'Kingori', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:01:33.079617', '2026-01-14 05:01:33.079652', '', 15000, 2, NULL, 5, NULL, 1088, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1078, '7162', 'Precious', 'juliet', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:01:34.583499', '2026-01-14 05:50:13.544958', '', 15000, 2, NULL, 5, NULL, 1089, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1079, '7502', 'Jaison', 'mumo', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:01:36.671197', '2026-01-14 05:01:36.671235', '', 15000, 2, NULL, 5, NULL, 1090, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1080, '7523', 'Georgia', 'Wairimu', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:01:38.626206', '2026-01-14 05:50:13.560924', '', 15000, 2, NULL, 5, NULL, 1091, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1081, '7328', 'Zoe', 'Reyna wariara', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:01:40.845899', '2026-01-14 05:01:40.845930', '', 15000, 2, NULL, 6, NULL, 1092, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1082, '7195', 'Louis', 'Arthur', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:01:43.213751', '2026-01-14 05:01:43.213776', '', 15000, 2, NULL, 6, NULL, 1093, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1083, '7590', 'Stephen', 'kamau', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:01:45.493645', '2026-01-14 05:01:45.493675', '', 15000, 2, NULL, 6, NULL, 1094, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1084, '7028', 'Kylie', 'mwendwa', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:01:47.692237', '2026-01-14 05:01:47.692274', '', 15000, 2, NULL, 6, NULL, 1095, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1085, '7295_2', 'Abigael', 'nyambura joshua', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:01:49.842325', '2026-01-14 05:50:13.579241', '', 15000, 2, NULL, 6, NULL, 1096, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1086, '7526', 'Quizon', 'muuo', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:01:51.642228', '2026-01-14 05:01:51.642255', '', 15000, 2, NULL, 6, NULL, 1097, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1087, '7063', 'Hope', 'wanjiku', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:01:53.482742', '2026-01-14 05:50:13.595303', '', 15000, 2, NULL, 6, NULL, 1098, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1088, '7069', 'Abigael', 'Flavian', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:01:56.091117', '2026-01-14 05:50:13.611906', '', 15000, 2, NULL, 6, NULL, 1099, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1089, '7629', 'Enelique', 'mwema', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:01:57.991180', '2026-01-14 05:01:57.991213', '', 15000, 2, NULL, 6, NULL, 1100, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1090, '7536', 'Zoe', 'gatune', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:01:59.734533', '2026-01-14 05:01:59.734567', '', 15000, 2, NULL, 6, NULL, 1101, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1091, '7456', 'Jean', 'njama', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:02:01.383533', '2026-01-14 05:02:01.383563', '', 15000, 2, NULL, 6, NULL, 1102, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1092, '7145', 'Dylan', 'mutunga', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:02:03.225324', '2026-01-14 05:02:03.225351', '', 15000, 2, NULL, 6, NULL, 1103, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1093, '7072', 'Janice', 'wema', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:02:04.913471', '2026-01-14 05:02:04.913505', '', 15000, 2, NULL, 6, NULL, 1104, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1094, '7060', 'Daren', 'kibaki', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:02:06.383366', '2026-01-14 05:02:06.383391', '', 15000, 2, NULL, 6, NULL, 1105, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1095, '7079', 'Ryan', 'njihia', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:02:08.024118', '2026-01-14 05:02:08.024152', '', 15000, 2, NULL, 6, NULL, 1106, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1096, '7076', 'Jason', 'irungu', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:02:09.671465', '2026-01-14 05:02:09.671499', '', 15000, 2, NULL, 6, NULL, 1107, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1097, '7073', 'Liam', 'kimani', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:02:11.091946', '2026-01-14 05:02:11.091980', '', 15000, 2, NULL, 6, NULL, 1108, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1098, '7303', 'Shem', 'njuguna', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:02:12.774105', '2026-01-14 05:02:12.774132', '', 15000, 2, NULL, 6, NULL, 1109, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1099, '7050', 'Patrick', 'kinuthia', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:02:14.711001', '2026-01-14 05:02:14.711035', '', 15000, 2, NULL, 6, NULL, 1110, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1100, '7087', 'Boniface', 'mulei', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:02:16.159017', '2026-01-14 05:02:16.159055', '', 15000, 2, NULL, 6, NULL, 1111, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1101, '7323', 'Victor', 'kamau', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:02:17.746957', '2026-01-14 05:02:17.747011', '', 15000, 2, NULL, 6, NULL, 1112, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1102, '7059', 'John', 'wambua', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:02:19.426714', '2026-01-14 05:02:19.426747', '', 15000, 2, NULL, 6, NULL, 1113, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1103, '7159', 'Testimony', 'mawang', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:02:20.873606', '2026-01-14 05:02:20.873641', '', 15000, 2, NULL, 6, NULL, 1114, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1104, '7393', 'Bradley', 'shelvin', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:02:22.440756', '2026-01-14 05:02:22.440785', '', 15000, 2, NULL, 6, NULL, 1115, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1105, '7071', 'Prince', 'macharia', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:02:24.105942', '2026-01-14 05:02:24.105975', '', 15000, 2, NULL, 6, NULL, 1116, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1106, '7084', 'Brandon', 'Njoroge', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:02:25.577502', '2026-01-14 05:02:25.577536', '', 15000, 2, NULL, 6, NULL, 1117, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1107, '7276', 'Goodluck', 'onyango', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:02:27.290544', '2026-01-14 05:02:27.290578', '', 15000, 2, NULL, 6, NULL, 1118, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1108, '7070', 'Liam', 'peter muniu', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:02:28.954067', '2026-01-14 05:02:28.954103', '', 15000, 2, NULL, 6, NULL, 1119, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1109, '7075', 'Zayn', 'Arthur kimanzi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:02:30.829566', '2026-01-14 05:02:30.829757', '', 15000, 2, NULL, 6, NULL, 1120, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1110, '7086', 'Liam', 'B mulei', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:02:32.473358', '2026-01-14 05:02:32.473418', '', 15000, 2, NULL, 6, NULL, 1121, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1111, '7146', 'Theophilus', 'ngethe', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:02:33.996661', '2026-01-14 05:02:33.996690', '', 15000, 2, NULL, 6, NULL, 1122, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1112, '7066', 'Joseph', 'katisya', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:02:35.435174', '2026-01-14 05:02:35.435216', '', 15000, 2, NULL, 6, NULL, 1123, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1113, '7592', 'Emmanuel', 'mwangi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:02:37.082884', '2026-01-14 05:02:37.082915', '', 15000, 2, NULL, 6, NULL, 1124, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1114, '7160', 'Jay', 'Ann Melissa', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:02:38.774289', '2026-01-14 05:50:13.627803', '', 15000, 2, NULL, 6, NULL, 1125, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1115, '7329', 'Flavin', 'nyangasi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:02:40.276472', '2026-01-14 05:02:40.276505', '', 15000, 2, NULL, 6, NULL, 1126, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1116, '7065', 'Peris', 'wanjiku', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:02:41.927474', '2026-01-14 05:50:13.913105', '', 15000, 2, NULL, 6, NULL, 1127, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1117, '7081', 'Grace', 'gathoni', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:02:43.691733', '2026-01-14 05:50:14.147173', '', 15000, 2, NULL, 6, NULL, 1128, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1118, '7062', 'Doreen', 'Muthoni', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:02:45.139997', '2026-01-14 05:50:14.412482', '', 15000, 2, NULL, 6, NULL, 1129, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1119, '7350', 'Zipporah', 'mbithe', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:02:47.014244', '2026-01-14 05:50:14.604586', '', 15000, 2, NULL, 6, NULL, 1130, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1120, '7152', 'Tamara', 'favour', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:02:48.609126', '2026-01-14 05:50:14.639331', '', 15000, 2, NULL, 6, NULL, 1131, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1121, '7460', 'Nevian', 'kwamboka', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:02:50.020541', '2026-01-14 05:50:14.709713', '', 15000, 2, NULL, 6, NULL, 1132, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1122, '7090', 'Arianna', 'mercy', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:02:51.671706', '2026-01-14 05:50:14.759718', '', 15000, 2, NULL, 6, NULL, 1133, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1123, '7064', 'Snowie', 'wambui', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:02:53.216740', '2026-01-14 05:50:14.859900', '', 15000, 2, NULL, 6, NULL, 1134, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1124, '7078', 'Achsa', 'naiyoma', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:02:54.623996', '2026-01-14 05:02:54.624027', '', 15000, 2, NULL, 6, NULL, 1135, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1125, '7533', 'Grace', 'nyiva', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:02:56.267762', '2026-01-14 05:50:14.935218', '', 15000, 2, NULL, 6, NULL, 1136, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1126, '7169', 'caroline', 'mwende', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:02:57.839798', '2026-01-14 05:50:14.967126', '', 15000, 2, NULL, 7, NULL, 1137, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1127, '7012', 'Abigael', 'wangui', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:02:59.246609', '2026-01-14 05:50:14.995830', '', 15000, 2, NULL, 7, NULL, 1138, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1128, '7327', 'Stella', 'Bliss wangari', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:03:00.931046', '2026-01-14 05:50:15.013183', '', 15000, 2, NULL, 7, NULL, 1139, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1129, '7463', 'Victor', 'Ryan mwenda', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:03:02.680828', '2026-01-14 05:03:02.680875', '', 15000, 2, NULL, 7, NULL, 1140, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1130, '7506', 'Godwill', 'Paul fundi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:03:04.107850', '2026-01-14 05:03:04.107883', '', 15000, 2, NULL, 7, NULL, 1141, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1131, '7173', 'Boniface', 'mulinge', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:03:05.714252', '2026-01-14 05:03:05.714311', '', 15000, 2, NULL, 7, NULL, 1142, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1132, '7715', 'Nathan', 'musyoki', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:03:07.324487', '2026-01-14 05:03:07.324520', '', 15000, 2, NULL, 7, NULL, 1143, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1133, '7317', 'Amarah', 'amanya', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:03:08.792114', '2026-01-14 05:03:08.792144', '', 15000, 2, NULL, 7, NULL, 1144, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1134, '7474', 'Delaney', 'Muthoni', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:03:10.401110', '2026-01-14 05:50:15.030363', '', 15000, 2, NULL, 7, NULL, 1145, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1135, '7579', 'Griffins', 'wasimbi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:03:12.024796', '2026-01-14 05:03:12.024832', '', 15000, 2, NULL, 7, NULL, 1146, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1136, '7018', 'Alvin', 'kamau', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:03:13.426680', '2026-01-14 05:03:13.426707', '', 15000, 2, NULL, 7, NULL, 1147, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1137, '7098', 'Jayden', 'wathari', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:03:15.180166', '2026-01-14 05:03:15.180195', '', 15000, 2, NULL, 7, NULL, 1148, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1138, '7504', 'Sabenzia', 'Odongo', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:03:16.800327', '2026-01-14 05:03:16.800346', '', 15000, 2, NULL, 7, NULL, 1149, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1139, '7503', 'Esther', 'Akoth', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:03:18.843631', '2026-01-14 05:50:15.052613', '', 15000, 2, NULL, 7, NULL, 1150, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1140, '7005', 'Jeremy', 'murugu', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:03:20.484259', '2026-01-14 05:03:20.484292', '', 15000, 2, NULL, 7, NULL, 1151, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1141, '7096', 'Ezra', 'Muthomi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:03:21.883967', '2026-01-14 05:03:21.884029', '', 15000, 2, NULL, 7, NULL, 1152, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1142, '7191', 'Harvey', 'Romain', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:03:23.507393', '2026-01-14 05:03:23.507426', '', 15000, 2, NULL, 7, NULL, 1153, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1143, '7095', 'Nathaniel', 'Mulandi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:03:25.098595', '2026-01-14 05:03:25.098640', '', 15000, 2, NULL, 7, NULL, 1154, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1144, '7010', 'Melvin', 'ndungu', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:03:26.486957', '2026-01-14 05:03:26.486990', '', 15000, 2, NULL, 7, NULL, 1155, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1145, '7007', 'Lilian', 'njeri', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:03:27.975663', '2026-01-14 05:50:15.070224', '', 15000, 2, NULL, 7, NULL, 1156, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1146, '7019', 'Belinda', 'Muthoni', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:03:29.585116', '2026-01-14 05:50:15.095944', '', 15000, 2, NULL, 7, NULL, 1157, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1147, '7398', 'Caren', 'Natasha', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:03:31.072447', '2026-01-14 05:03:31.072480', '', 15000, 2, NULL, 7, NULL, 1158, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1148, '7055', 'Ivy', 'Ayieta', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:03:32.736797', '2026-01-14 05:03:32.736830', '', 15000, 2, NULL, 7, NULL, 1159, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1149, '7197', 'Elsie', 'Wangari', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:03:34.535676', '2026-01-14 05:50:15.119593', '', 15000, 2, NULL, 7, NULL, 1160, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1150, '7207', 'Kourtney', 'Ariana', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:03:35.921562', '2026-01-14 05:03:35.921595', '', 15000, 2, NULL, 7, NULL, 1161, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1151, '7395', 'Deborah', 'favour', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:03:37.509513', '2026-01-14 05:50:15.134876', '', 15000, 2, NULL, 7, NULL, 1162, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1152, '7291', 'Susan', 'Wambui m', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:03:39.036649', '2026-01-14 05:50:15.149492', '', 15000, 2, NULL, 7, NULL, 1163, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1153, '7427', 'Shirniece', 'Amanya', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:03:40.453766', '2026-01-14 05:03:40.453792', '', 15000, 2, NULL, 7, NULL, 1164, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1154, '7234', 'Blessing', 'Njambi', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:03:42.032059', '2026-01-14 05:50:15.172205', '', 15000, 2, NULL, 7, NULL, 1165, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1155, '7196_2', 'Lilly', 'shadia Njeri', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:03:43.701330', '2026-01-14 05:50:15.195499', '', 15000, 2, NULL, 7, NULL, 1166, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1156, '7023', 'Mitchell', 'koki', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:03:45.194692', '2026-01-14 05:03:45.194732', '', 15000, 2, NULL, 7, NULL, 1167, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1157, '7017', 'Princess', 'Wairimu', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:03:47.188929', '2026-01-14 05:50:15.224571', '', 15000, 2, NULL, 7, NULL, 1168, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1158, '7445', 'Faith', 'njeri', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:03:48.775668', '2026-01-14 05:50:15.241722', '', 15000, 2, NULL, 6, NULL, 1169, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1159, '7022', 'Annet', 'Njeri Njoroge', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:03:50.391673', '2026-01-14 05:50:15.262719', '', 15000, 2, NULL, 7, NULL, 1170, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1160, '7516', 'Chalcedony', 'munyiru', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:03:52.079593', '2026-01-14 05:03:52.079681', '', 15000, 2, NULL, 7, NULL, 1171, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1161, '7008_2', 'Shekinah', 'wanjiru', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:03:53.770482', '2026-01-14 05:50:15.281009', '', 15000, 2, NULL, 7, NULL, 1172, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1162, '7032', 'Chloe', 'Wambui', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:03:55.118532', '2026-01-14 05:50:15.302978', '', 15000, 2, NULL, 7, NULL, 1173, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1163, '7025', 'Blessings', 'gathoni', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:03:56.671450', '2026-01-14 05:50:15.321338', '', 15000, 2, NULL, 7, NULL, 1174, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1164, '7369', 'Ednah', 'gakii', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:03:58.303096', '2026-01-14 05:03:58.303132', '', 15000, 2, NULL, 7, NULL, 1175, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1165, '7373', 'Mary', 'gathoni', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:04:00.174947', '2026-01-14 05:50:15.338203', '', 15000, 2, NULL, 7, NULL, 1176, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1166, '7560', 'Angel', 'Ngina Wangari', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:04:02.239025', '2026-01-14 05:50:15.366995', '', 15000, 2, NULL, 7, NULL, 1177, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1167, '7004', 'Elizabeth', 'nzilani', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:04:04.050609', '2026-01-14 05:50:15.396811', '', 15000, 2, NULL, 7, NULL, 1178, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1168, '7014', 'Blessing', 'nyokabi', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:04:05.573313', '2026-01-14 05:50:15.426508', '', 15000, 2, NULL, 7, NULL, 1179, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL)
ON CONFLICT DO NOTHING;
INSERT INTO "schools_student" ("id", "admission_number", "first_name", "last_name", "date_of_birth", "gender", "parent_name", "parent_phone", "parent_email", "parent_occupation", "parent_id_number", "academic_year", "created_at", "updated_at", "photo", "term_fees", "current_term", "birth_certificate_no", "grade_id", "previous_grade_id", "user_id", "term1_fees", "term2_fees", "term3_fees", "guardian_email", "guardian_id_number", "guardian_name", "guardian_occupation", "guardian_phone", "location", "branch_id") VALUES
  (1169, '7015', 'John', 'wamburu', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:04:07.543655', '2026-01-14 05:04:07.543695', '', 15000, 2, NULL, 7, NULL, 1180, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1170, '7104', 'Aristaricho', 'Reign Mulwa', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:04:09.238973', '2026-01-14 05:04:09.239007', '', 15000, 2, NULL, 7, NULL, 1181, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1171, '7199', 'Jamal', 'maina', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:04:11.093452', '2026-01-14 05:04:11.093485', '', 15000, 2, NULL, 7, NULL, 1182, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1172, '7339', 'Sam', 'junior getachi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:04:12.989840', '2026-01-14 05:04:12.989872', '', 15000, 2, NULL, 7, NULL, 1183, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1173, '7003', 'Jeremy', 'Kariithi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:04:14.874622', '2026-01-14 05:04:14.874714', '', 15000, 2, NULL, 7, NULL, 1184, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1174, '7630', 'Asiel', 'mubiru', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:04:17.145883', '2026-01-14 05:04:17.145911', '', 15000, 2, NULL, 7, NULL, 1185, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1175, '7027', 'Caesar', 'gitau', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:04:18.857270', '2026-01-14 05:04:18.857304', '', 15000, 2, NULL, 7, NULL, 1186, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1176, '7212', 'Leon', 'mbae', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:04:20.357975', '2026-01-14 05:04:20.358009', '', 15000, 2, NULL, 7, NULL, 1187, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1177, '7577', 'Mary', 'wangari', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:04:21.891222', '2026-01-14 05:50:15.451417', '', 15000, 2, NULL, 7, NULL, 1188, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1178, '7534', 'James', 'mutua', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:04:23.474449', '2026-01-14 05:04:23.474483', '', 15000, 2, NULL, 7, NULL, 1189, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1179, '7392', 'Lavinia', 'Wambui', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:04:24.879069', '2026-01-14 05:50:15.490269', '', 15000, 2, NULL, 7, NULL, 1190, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1180, '7001', 'Joshua', 'makau', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:04:26.668945', '2026-01-14 05:04:26.669002', '', 15000, 2, NULL, 7, NULL, 1191, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1181, '7403', 'Zoe', 'Njambi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:04:28.277407', '2026-01-14 05:04:28.277435', '', 15000, 2, NULL, 8, NULL, 1192, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1182, '7591', 'Irene', 'nyambura', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:04:29.700072', '2026-01-14 05:50:15.523026', '', 15000, 2, NULL, 8, NULL, 1193, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1183, '7034', 'Kennedy', 'mugo', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:04:31.529064', '2026-01-14 05:04:31.529100', '', 15000, 2, NULL, 8, NULL, 1194, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1184, '7208', 'Corazon', 'kalondu', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:04:33.435871', '2026-01-14 05:04:33.435899', '', 15000, 2, NULL, 8, NULL, 1195, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1185, '7031', 'Terryann', 'Njeri', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:04:35.166821', '2026-01-14 05:50:15.611928', '', 15000, 2, NULL, 8, NULL, 1196, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1186, '7228', 'Shaleen', 'wanjiru mwaura', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:04:37.076358', '2026-01-14 05:04:37.076387', '', 15000, 2, NULL, 8, NULL, 1197, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1187, '7319', 'Joy', 'mueni', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:04:40.851738', '2026-01-14 05:50:15.720645', '', 15000, 2, NULL, 8, NULL, 1198, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1188, '7354', 'Shaniece', 'Wangui', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:04:43.908857', '2026-01-14 05:50:15.994518', '', 15000, 2, NULL, 8, NULL, 1199, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1189, '7103', 'Celestine', 'mueni', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:04:46.831625', '2026-01-14 05:04:46.831746', '', 15000, 2, NULL, 8, NULL, 1200, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1190, '7175', 'Immaculate', 'Muthoni', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:04:49.296076', '2026-01-14 05:50:16.117239', '', 15000, 2, NULL, 8, NULL, 1201, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1191, '7037', 'Patience', 'Wambui', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:04:51.717244', '2026-01-14 05:50:16.149901', '', 15000, 2, NULL, 8, NULL, 1202, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1192, '7490', 'Shantel', 'mukuhi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:04:54.861967', '2026-01-14 05:04:54.862057', '', 15000, 2, NULL, 8, NULL, 1203, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1193, '7562', 'Brandon', 'maingi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:04:58.573948', '2026-01-14 05:04:58.573989', '', 15000, 2, NULL, 8, NULL, 1204, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1194, '7370', 'Collins', 'kabau', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:05:02.431634', '2026-01-14 05:05:02.431669', '', 15000, 2, NULL, 8, NULL, 1205, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1195, '7153', 'Sanchez', 'Gitau', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:05:04.813311', '2026-01-14 05:05:04.813343', '', 15000, 2, NULL, 8, NULL, 1206, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1196, '7375', 'Raymond', 'Kiage', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:05:07.260438', '2026-01-14 05:05:07.260495', '', 15000, 2, NULL, 8, NULL, 1207, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1197, '7458', 'Davis', 'munene', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:05:10.485100', '2026-01-14 05:05:10.485125', '', 15000, 2, NULL, 8, NULL, 1208, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1198, '7102', 'Abraham', 'Lincoln Kingori', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:05:12.614685', '2026-01-14 05:05:12.614720', '', 15000, 2, NULL, 8, NULL, 1209, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1199, '7361', 'Ryan', 'ndede', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:05:14.974173', '2026-01-14 05:05:14.974206', '', 15000, 2, NULL, 8, NULL, 1210, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1200, '7038', 'Hope', 'were', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:05:16.895090', '2026-01-14 05:05:16.895117', '', 15000, 2, NULL, 8, NULL, 1211, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1201, '7337', 'Angel', 'wanjiku', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:05:18.991750', '2026-01-14 05:50:16.176393', '', 15000, 2, NULL, 8, NULL, 1212, 8000, 8000, 7500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1202, '7429', 'Chloe', 'mwikali', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:05:21.181717', '2026-01-14 05:50:16.199498', '', 15000, 2, NULL, 9, NULL, 1213, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1203, '7230', 'Sheilah', 'kalekye', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:05:23.329651', '2026-01-14 05:05:23.329683', '', 15000, 2, NULL, 9, NULL, 1214, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1204, '7039', 'Alvin', 'Luke', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:05:25.265671', '2026-01-14 05:05:25.265707', '', 15000, 2, NULL, 9, NULL, 1215, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1205, '7631', 'Alvin', 'Ngugi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:05:27.043426', '2026-01-14 05:05:27.043459', '', 15000, 2, NULL, 9, NULL, 1216, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1206, '7044', 'Davian', 'Mukoya', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:05:28.838941', '2026-01-14 05:05:28.838973', '', 15000, 2, NULL, 9, NULL, 1217, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1207, '7576', 'Darius', 'Wekesa', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:05:30.752894', '2026-01-14 05:05:30.753160', '', 15000, 2, NULL, 9, NULL, 1218, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1208, '7266', 'Godwin', 'kagema', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:05:32.362789', '2026-01-14 05:05:32.362827', '', 15000, 2, NULL, 9, NULL, 1219, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1209, '7192', 'Kendrick', 'Rugumi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:05:34.515708', '2026-01-14 05:05:34.515742', '', 15000, 2, NULL, 9, NULL, 1220, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1210, '7040', 'Precious', 'wanjiku', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:05:36.480570', '2026-01-14 05:50:16.216075', '', 15000, 2, NULL, 9, NULL, 1221, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1211, '7191_2', 'Nadia', 'waithera', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:05:38.505924', '2026-01-14 05:50:16.239114', '', 15000, 2, NULL, 9, NULL, 1222, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1212, '7099', 'Faith', 'Njeri', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:05:40.278157', '2026-01-14 05:50:16.270952', '', 15000, 2, NULL, 9, NULL, 1223, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1213, '7042', 'Precious', 'Catherine', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:05:42.252159', '2026-01-14 05:50:16.293129', '', 15000, 2, NULL, 9, NULL, 1224, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1214, '7394', 'Angel', 'mercy', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:05:44.213229', '2026-01-14 05:50:16.332945', '', 15000, 2, NULL, 9, NULL, 1225, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1215, '7434', 'Queenstar', 'Njambi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:05:46.077239', '2026-01-14 05:05:46.077264', '', 15000, 2, NULL, 9, NULL, 1226, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1216, '7105', 'Blessings', 'mbula', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:05:47.658188', '2026-01-14 05:05:47.658248', '', 15000, 2, NULL, 10, NULL, 1227, 7500, 6500, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1217, '7052', 'Emmeldah', 'Waithira', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:05:49.750835', '2026-01-14 05:05:49.750869', '', 15000, 2, NULL, 10, NULL, 1228, 7500, 6500, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1218, '7046', 'Natasha', 'waithera', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:05:51.601410', '2026-01-14 05:50:16.361298', '', 15000, 2, NULL, 10, NULL, 1229, 7500, 6500, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1219, '7171', 'Abigael', 'njoki', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:05:53.766289', '2026-01-14 05:50:16.390433', '', 15000, 2, NULL, 10, NULL, 1230, 7500, 6500, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1220, '7048', 'Hope', 'Makena', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:05:55.357386', '2026-01-14 05:50:16.451210', '', 15000, 2, NULL, 10, NULL, 1231, 7500, 6500, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1221, '7444', 'Carlos', 'Mungai', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:05:56.812846', '2026-01-14 05:05:56.812876', '', 15000, 2, NULL, 10, NULL, 1232, 7500, 6500, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1222, '7412', 'Felix', 'Ndegwa', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:05:58.461963', '2026-01-14 05:05:58.462003', '', 15000, 2, NULL, 10, NULL, 1233, 7500, 6500, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1223, '7051', 'Maxwell', 'kamau', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:06:00.057384', '2026-01-14 05:06:00.057420', '', 15000, 2, NULL, 10, NULL, 1234, 7500, 6500, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1224, '7566', 'Blessing', 'kimani', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:06:01.563950', '2026-01-14 05:50:16.589826', '', 15000, 2, NULL, 10, NULL, 1235, 7500, 6500, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1225, '7047', 'Milton', 'odera', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:06:03.329898', '2026-01-14 05:06:03.329930', '', 15000, 2, NULL, 10, NULL, 1236, 7500, 6500, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1226, '7166', 'Adrian', 'Karue', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:06:04.942348', '2026-01-14 05:06:04.942378', '', 15000, 2, NULL, 10, NULL, 1237, 7500, 6500, 6500, NULL, NULL, NULL, NULL, NULL, 'MAIN', NULL),
  (1227, '7641', 'Ladasha', 'mbatha', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:06:06.412634', '2026-01-14 05:06:06.412669', '', 15000, 2, NULL, 2, NULL, 1238, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1228, '7642', 'Logan-lee', 'mwirigi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:06:08.065510', '2026-01-14 05:06:08.065543', '', 15000, 2, NULL, 2, NULL, 1239, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1229, '7643', 'Magdalene', 'wambua', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:06:09.995904', '2026-01-14 05:06:09.995939', '', 15000, 2, NULL, 2, NULL, 1240, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1230, '7644', 'Neymar', 'nyachio', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:06:11.732227', '2026-01-14 05:06:11.732254', '', 15000, 2, NULL, 2, NULL, 1241, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1231, '7645', 'Nillan', 'munene', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:06:13.622069', '2026-01-14 05:06:13.622123', '', 15000, 2, NULL, 2, NULL, 1242, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1232, '7646', 'Atsue', 'melia', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:06:15.341067', '2026-01-14 05:06:15.341093', '', 15000, 2, NULL, 2, NULL, 1243, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1233, '7647', 'Erin', 'waithera', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:06:16.844312', '2026-01-14 05:50:16.624144', '', 15000, 2, NULL, 2, NULL, 1244, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1234, '7648', 'Elsie', 'Juma', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:06:18.431428', '2026-01-14 05:06:18.431453', '', 15000, 2, NULL, 2, NULL, 1245, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1235, '7649', 'Ethan', 'mambo', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:06:20.021768', '2026-01-14 05:06:20.021797', '', 15000, 2, NULL, 2, NULL, 1246, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1236, '7650', 'Edwin', 'Jabari munene', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:06:22.511067', '2026-01-14 05:06:22.511101', '', 15000, 2, NULL, 2, NULL, 1247, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1237, '7651', 'Dalvin', 'maingi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:06:24.623953', '2026-01-14 05:06:24.623987', '', 15000, 2, NULL, 2, NULL, 1248, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1238, '7652', 'Hillel', 'kamau', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:06:26.908046', '2026-01-14 05:06:26.908085', '', 15000, 2, NULL, 2, NULL, 1249, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1239, '7653', 'Precious', 'Joy', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:06:30.172272', '2026-01-14 05:50:16.647849', '', 15000, 2, NULL, 2, NULL, 1250, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1240, '7654', 'Pascal', 'Kamau', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:06:31.949806', '2026-01-14 05:06:31.949840', '', 15000, 2, NULL, 2, NULL, 1251, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1241, '7655', 'Kiersten', 'natania', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:06:33.349912', '2026-01-14 05:06:33.349938', '', 15000, 2, NULL, 2, NULL, 1252, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1242, '7656', 'Ethan', 'm christine', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:06:34.941028', '2026-01-14 05:06:34.941062', '', 15000, 2, NULL, 2, NULL, 1253, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1243, '7657', 'Aliciah', 'wanjiru', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:06:36.612178', '2026-01-14 05:06:36.612213', '', 15000, 2, NULL, 2, NULL, 1254, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1244, '7658', 'Blessing', 'nyamai', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:06:38.031554', '2026-01-14 05:50:16.709223', '', 15000, 2, NULL, 2, NULL, 1255, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1245, '7659', 'Gia', 'Rin', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:06:39.655639', '2026-01-14 05:06:39.655667', '', 15000, 2, NULL, 2, NULL, 1256, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1246, '7660', 'Patience', 'mawia', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:06:41.588174', '2026-01-14 05:06:41.588200', '', 15000, 2, NULL, 2, NULL, 1257, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1247, '7661', 'Adassah', 'wanjiru', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:06:43.331003', '2026-01-14 05:06:43.331040', '', 15000, 2, NULL, 2, NULL, 1258, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1248, '7662', 'Gianna', 'wawira', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:06:45.293433', '2026-01-14 05:50:16.815229', '', 15000, 2, NULL, 2, NULL, 1259, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1249, '7663', 'Ella', 'mutana', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:06:50.055176', '2026-01-14 05:06:50.055211', '', 15000, 2, NULL, 2, NULL, 1260, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1250, '7664', 'Victorlyn', 'achieng', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:06:53.483965', '2026-01-14 05:50:16.834360', '', 15000, 2, NULL, 2, NULL, 1261, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1251, '7665', 'Blessing', 'Favour', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:06:57.538995', '2026-01-14 05:50:16.850770', '', 15000, 2, NULL, 2, NULL, 1262, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1252, '7666', 'Faith', 'waeni', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:07:00.169525', '2026-01-14 05:50:16.880639', '', 15000, 2, NULL, 2, NULL, 1263, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1253, '7667', 'Lindsey', 'Harrier', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:07:02.647944', '2026-01-14 05:07:02.647978', '', 15000, 2, NULL, 2, NULL, 1264, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1254, '7668', 'Kelcy', 'Wambui', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:07:06.864928', '2026-01-14 05:50:16.916042', '', 15000, 2, NULL, 2, NULL, 1265, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1255, '7669', 'Phoebe', 'wakanyi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:07:09.338256', '2026-01-14 05:07:09.338277', '', 15000, 2, NULL, 2, NULL, 1266, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1256, '7670', 'Liam', 'mutuku', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:07:11.979689', '2026-01-14 05:07:11.979724', '', 15000, 2, NULL, 2, NULL, 1267, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1257, '7671', 'Shantel', 'nduta', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:07:14.002334', '2026-01-14 05:50:16.943979', '', 15000, 2, NULL, 2, NULL, 1268, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1258, '7672', 'Munira', 'Ibrahim', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:07:16.435258', '2026-01-14 05:07:16.435285', '', 15000, 2, NULL, 2, NULL, 1269, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1259, '7673', 'Travis', 'hamisi Joseph', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:07:18.815648', '2026-01-14 05:07:18.815691', '', 15000, 2, NULL, 2, NULL, 1270, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1260, '7674', 'Princess', 'mwikali', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:07:20.988010', '2026-01-14 05:50:16.984597', '', 15000, 2, NULL, 2, NULL, 1271, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1261, '7675', 'Abigael', 'Wambui', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:07:23.256038', '2026-01-14 05:50:17.016135', '', 15000, 2, NULL, 2, NULL, 1272, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1262, '7676', 'Kieran', 'ndungu', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:07:25.256660', '2026-01-14 05:07:25.256687', '', 15000, 2, NULL, 2, NULL, 1273, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1263, '7677', 'Caleb', 'muuo', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:07:28.061357', '2026-01-14 05:07:28.061386', '', 15000, 2, NULL, 2, NULL, 1274, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1264, '7678', 'Emmanuel', 'mumo', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:07:30.125663', '2026-01-14 05:07:30.125699', '', 15000, 2, NULL, 2, NULL, 1275, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1265, '7679', 'Alexander', 'kenan', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:07:33.488405', '2026-01-14 05:07:33.488432', '', 15000, 2, NULL, 2, NULL, 1276, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1266, '7680', 'Glen', 'fadhili', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:07:35.875481', '2026-01-14 05:07:35.875518', '', 15000, 2, NULL, 2, NULL, 1277, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1267, '7681', 'Ella', 'mutana', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:07:38.512354', '2026-01-14 05:07:38.512377', '', 15000, 2, NULL, 2, NULL, 1278, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1268, '7682', 'Sydney', 'mbugua', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:07:40.805421', '2026-01-14 05:07:40.805474', '', 15000, 2, NULL, 2, NULL, 1279, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1269, '7683', 'Ricca', 'nyambura', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:07:43.234570', '2026-01-14 05:50:17.042618', '', 15000, 2, NULL, 2, NULL, 1280, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1270, '7684', 'Gian', 'Reigns', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:07:45.256261', '2026-01-14 05:07:45.256279', '', 15000, 2, NULL, 2, NULL, 1281, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1271, '7685', 'Anywil', 'Peter', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:07:47.505478', '2026-01-14 05:07:47.505507', '', 15000, 2, NULL, 2, NULL, 1282, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1272, '7686', 'Blessing', 'mutheu', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:07:50.297170', '2026-01-14 05:50:17.128464', '', 15000, 2, NULL, 2, NULL, 1283, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1273, '7687', 'Gaddiel', 'chege', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:07:56.058338', '2026-01-14 05:07:56.058374', '', 15000, 2, NULL, 2, NULL, 1284, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1274, '7688', 'Russel', 'Reign', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:08:00.435593', '2026-01-14 05:08:00.435629', '', 15000, 2, NULL, 2, NULL, 1285, 6500, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1275, '7689', 'Octavia', 'Muthoni', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:08:02.967593', '2026-01-23 09:45:09.878563', '', 15000, 2, NULL, 3, NULL, 1286, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1276, '7690', 'Sharon', 'mueni', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:08:05.727815', '2026-01-23 09:45:09.894537', '', 15000, 2, NULL, 3, NULL, 1287, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1277, '7691', 'Gift', 'Nzioka', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:08:08.174438', '2026-01-23 09:45:09.930635', '', 15000, 2, NULL, 3, NULL, 1288, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1278, '7692', 'Azra', 'Ibrahim', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:08:10.648424', '2026-01-23 09:45:09.943106', '', 15000, 2, NULL, 3, NULL, 1289, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1279, '7693', 'Amizero', 'Ganza', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:08:13.076013', '2026-01-23 09:45:09.956125', '', 15000, 2, NULL, 3, NULL, 1290, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1280, '7694', 'Leon', 'kanyuguta', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:08:14.816607', '2026-01-23 09:45:09.968794', '', 15000, 2, NULL, 3, NULL, 1291, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1281, '7695', 'Delmax', 'natsami', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:08:16.536694', '2026-01-23 09:45:10.029554', '', 15000, 2, NULL, 3, NULL, 1292, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1282, '7696', 'Jane', 'Muthoni', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:08:19.664580', '2026-01-23 09:45:10.068192', '', 15000, 2, NULL, 3, NULL, 1293, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1283, '7697', 'Grasher', 'Aluoch', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:08:24.852346', '2026-01-23 09:45:10.125562', '', 15000, 2, NULL, 3, NULL, 1294, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1284, '7698', 'Dylan', 'Kamau', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:08:27.865069', '2026-01-23 09:45:10.138308', '', 15000, 2, NULL, 3, NULL, 1295, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1285, '7699', 'Bernard', 'Kyalo', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:08:30.668902', '2026-01-23 09:45:10.150545', '', 15000, 2, NULL, 3, NULL, 1296, 1000, 6500, 6000, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1286, '7700', 'Angel', 'Muthoni', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:08:32.917875', '2026-01-24 17:52:00.697418', '', 3000, 2, NULL, 4, NULL, 1297, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1287, '7701', 'Gedion', 'ndomba', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:08:35.789783', '2026-01-24 17:52:00.708354', '', 3000, 2, NULL, 4, NULL, 1298, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1288, '7702', 'Deborah', 'bahati', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:08:37.763615', '2026-01-24 17:52:00.739926', '', 3000, 2, NULL, 4, NULL, 1299, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1289, '7703', 'Patrick', 'wairegi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:08:41.258104', '2026-01-24 17:52:00.749526', '', 3000, 2, NULL, 4, NULL, 1300, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1290, '7704', 'Christine', 'mwende', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:08:43.518573', '2026-01-24 17:52:00.761006', '', 3000, 2, NULL, 4, NULL, 1301, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1291, '7705', 'Nathaniel', 'ikhavi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:08:45.719471', '2026-01-24 17:52:00.772374', '', 3000, 2, NULL, 4, NULL, 1302, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1292, '7706', 'Victor', 'mburu', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:08:49.208542', '2026-01-24 17:52:00.785719', '', 3000, 2, NULL, 4, NULL, 1303, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1293, '7707', 'Stephen', 'Maina', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:08:51.722598', '2026-01-24 17:52:00.797990', '', 3000, 2, NULL, 4, NULL, 1304, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1294, '7708', 'Travis', 'Muthomi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:08:54.131736', '2026-01-24 17:52:00.816285', '', 3000, 2, NULL, 4, NULL, 1305, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1295, '7709', 'Joles', 'simiyu', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:08:56.371297', '2026-01-24 17:52:00.933527', '', 3000, 2, NULL, 4, NULL, 1306, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1296, '7710', 'Nellius', 'mueni', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:08:58.432739', '2026-01-24 17:52:00.950744', '', 3000, 2, NULL, 4, NULL, 1307, 5000, 3000, 2599, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1297, '7711', 'Joy', 'waringia', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:09:00.548383', '2026-01-14 05:50:17.424770', '', 15000, 2, NULL, 5, NULL, 1308, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1298, '7712', 'Allan', 'mweu', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:09:02.915235', '2026-01-14 05:09:02.915274', '', 15000, 2, NULL, 5, NULL, 1309, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1299, '7713', 'Kaylan', 'kyago', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:09:05.267676', '2026-01-14 05:09:05.267706', '', 15000, 2, NULL, 5, NULL, 1310, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1300, '7714', 'Ephraim', 'shimata', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:09:07.565851', '2026-01-14 05:09:07.565883', '', 15000, 2, NULL, 5, NULL, 1311, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1301, '7715_2', 'Genuine', 'Godwil', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:09:09.746788', '2026-01-14 05:09:09.746827', '', 15000, 2, NULL, 5, NULL, 1312, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1302, '7716', 'Stephen', 'Gitau', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:09:12.259773', '2026-01-14 05:09:12.259797', '', 15000, 2, NULL, 5, NULL, 1313, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1303, '7717', 'Shantel', 'Nduku', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:09:14.908783', '2026-01-14 05:09:14.909052', '', 15000, 2, NULL, 5, NULL, 1314, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1304, '7718', 'Antony', 'Mutunga', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:09:17.053982', '2026-01-14 05:09:17.054013', '', 15000, 2, NULL, 5, NULL, 1315, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1305, '7719', 'Clement', 'Gathecha', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:09:19.314372', '2026-01-14 05:09:19.314391', '', 15000, 2, NULL, 5, NULL, 1316, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1306, '7720', 'Aiden', 'Mutugi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:09:21.364375', '2026-01-14 05:09:21.364402', '', 15000, 2, NULL, 5, NULL, 1317, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1307, '7721', 'Tammian', 'Njeri', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:09:25.442775', '2026-01-14 05:50:17.458515', '', 15000, 2, NULL, 5, NULL, 1318, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1308, '7722', 'Sylvia', 'Favour', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:09:28.612762', '2026-01-14 05:50:17.489688', '', 15000, 2, NULL, 6, NULL, 1319, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1309, '7723', 'Favour', 'wanjiru', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:09:31.627156', '2026-01-14 05:50:17.526592', '', 15000, 2, NULL, 6, NULL, 1320, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1310, '7724', 'Vincent', 'Njoroge', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:09:33.992038', '2026-01-14 05:09:33.992074', '', 15000, 2, NULL, 6, NULL, 1321, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1311, '7725', 'Samhenry', 'mutwiri', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:09:36.581606', '2026-01-14 05:09:36.581640', '', 15000, 2, NULL, 6, NULL, 1322, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1312, '7726', 'Blessing', 'mutindi', '2020-01-01', 'F', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:09:39.400911', '2026-01-14 05:50:17.551459', '', 15000, 2, NULL, 6, NULL, 1323, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1313, '7727', 'Talia', 'wema', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:09:41.805193', '2026-01-14 05:09:41.805224', '', 15000, 2, NULL, 6, NULL, 1324, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1314, '7728', 'Pascaline', 'mutio', '2020-01-01', 'Female', '', '', '', NULL, NULL, '2026', '2026-01-14 05:09:44.715954', '2026-01-21 19:18:48.605040', 'student_photos/IMG-20260117-WA0005.jpg', 15000, 2, NULL, 6, NULL, 1325, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL),
  (1315, '7729', 'Bryson', 'murimi', '2020-01-01', 'M', NULL, NULL, NULL, NULL, NULL, '2026', '2026-01-14 05:09:47.496021', '2026-01-14 05:09:47.496063', '', 15000, 2, NULL, 6, NULL, 1326, 7000, 7000, 6500, NULL, NULL, NULL, NULL, NULL, 'ANNEX', NULL)
ON CONFLICT DO NOTHING;

-- schools_attendance (2 rows)
INSERT INTO "schools_attendance" ("id", "date", "status", "remarks", "term", "created_at", "updated_at", "recorded_by_id", "student_id") VALUES
  (65, '2026-01-21', 'PRESENT', '', '1', '2026-01-21 20:20:30.800405', '2026-01-21 20:28:13.429555', 226, 1314),
  (66, '2026-01-20', 'PRESENT', '', '1', '2026-01-21 20:23:18.142752', '2026-01-21 20:23:18.142782', 226, 1314)
ON CONFLICT DO NOTHING;

-- schools_schedule (1 rows)
INSERT INTO "schools_schedule" ("id", "grade_id", "subject_id", "teacher_id", "day", "end_time", "term", "start_time") VALUES
  (11, 1, 6, 35, 'MONDAY', '09:00:00', NULL, '08:00:00')
ON CONFLICT DO NOTHING;

-- schools_announcement (1 rows)
INSERT INTO "schools_announcement" ("id", "title", "content", "priority", "created_at", "updated_at", "expires_at", "is_active", "author_id", "specific_grade_id", "recipient_type") VALUES
  (22, 'Closing', 'Closing', 'HIGH', '2025-07-31 08:41:58.891915', '2025-07-31 08:41:58.891943', '2025-08-01 12:40:00', TRUE, 1, NULL, 'STUDENTS')
ON CONFLICT DO NOTHING;

-- schools_smsmessage (16 rows)
INSERT INTO "schools_smsmessage" ("id", "message", "recipient_type", "status", "sent_at", "response_data", "created_at", "sent_by_id", "specific_grade_id", "specific_student_id", "location", "recipients_count") VALUES
  (1, 'vdbgdrgf devr', 'ALL', 'PENDING', NULL, NULL, '2025-01-30 21:09:54.468243', 1, NULL, NULL, NULL, 0),
  (2, 'vdbgdrgf devr', 'ALL', 'SENT', '2025-01-30 21:11:11.473605', '{"status": "success", "message": "SMS would be sent to 1 recipients", "recipients": ["+254713428517"]}', '2025-01-30 21:11:11.462618', 1, NULL, NULL, NULL, 0),
  (3, 'hgtfcrv', 'GRADE', 'SENT', '2025-01-30 21:13:16.820061', '{"status": "success", "message": "SMS would be sent to 1 recipients", "recipients": ["+254720990929"]}', '2025-01-30 21:13:16.809409', 1, 3, NULL, NULL, 0),
  (4, 'jghhgv', 'GRADE', 'PENDING', NULL, NULL, '2025-01-30 21:22:36.605216', 1, 3, NULL, NULL, 0),
  (5, 'jghhgv', 'GRADE', 'PENDING', NULL, NULL, '2025-01-30 21:23:15.079288', 1, 3, NULL, NULL, 0),
  (6, 'jghhgv', 'GRADE', 'FAILED', NULL, '"The supplied authentication is invalid"', '2025-01-30 21:24:48.956613', 1, 3, NULL, NULL, 0),
  (7, 'hugyfghuj', 'GRADE', 'FAILED', NULL, '"Invalid API credentials. Please check your Africa''s Talking settings."', '2025-01-30 21:25:53.437126', 1, 3, NULL, NULL, 0),
  (8, 'edededed', 'ALL', 'FAILED', NULL, '"Invalid API credentials. Please check your Africa''s Talking settings."', '2025-02-02 11:41:37.299721', 1, NULL, NULL, NULL, 0),
  (9, 'dc', 'ALL', 'FAILED', NULL, '"Invalid API credentials. Please check your Africa''s Talking settings."', '2025-02-02 11:43:19.407344', 1, NULL, NULL, NULL, 0),
  (10, 'rggrg', 'ALL', 'FAILED', NULL, '"Invalid API credentials. Please check your Africa''s Talking settings."', '2025-02-02 11:49:44.244574', 1, NULL, NULL, NULL, 0),
  (11, 'Hello, i am just testing', 'INDIVIDUAL', 'PENDING', NULL, NULL, '2025-11-27 09:15:22.186553', 226, NULL, NULL, NULL, 0),
  (12, 'Hello, i am just testing', 'INDIVIDUAL', 'FAILED', NULL, '"Invalid API credentials. Please check your Africa''s Talking settings."', '2025-11-27 09:19:38.301614', 226, NULL, NULL, NULL, 1),
  (13, 'Hello, i am just testing', 'INDIVIDUAL', 'FAILED', NULL, '"Invalid API credentials: The supplied authentication is invalid. Please verify your username ''BDMIS'' and API key in settings.py match your Africa''s Talking dashboard."', '2025-11-27 09:31:10.683291', 226, NULL, NULL, NULL, 1),
  (14, 'hello jus', 'INDIVIDUAL', 'FAILED', NULL, '"Failed to send SMS: ''Settings'' object has no attribute ''SMS_SENDER_ID''"', '2025-11-27 09:32:24.821743', 226, NULL, NULL, NULL, 1),
  (15, 'Hello, testing hh', 'INDIVIDUAL', 'FAILED', NULL, '"Invalid API credentials: The supplied authentication is invalid. Please verify your username ''BDMIS'' and API key in settings.py match your Africa''s Talking dashboard."', '2025-11-27 09:37:20.283887', 226, NULL, NULL, NULL, 1),
  (16, 'testing', 'INDIVIDUAL', 'FAILED', NULL, '"Invalid API credentials: The supplied authentication is invalid. Please verify your username ''BDMIS'' and API key in settings.py match your Africa''s Talking dashboard."', '2025-11-27 09:54:30.656388', 226, NULL, NULL, NULL, 1)
ON CONFLICT DO NOTHING;

-- schools_foodplan (1 rows)
INSERT INTO "schools_foodplan" ("id", "name", "description", "meal_type", "fee_per_term", "is_active", "created_at", "updated_at") VALUES
  (1, 'Fast Food', '', 'BREAKFAST', 3000, TRUE, '2025-11-21 12:25:16.056103', '2025-11-21 12:25:16.056280')
ON CONFLICT DO NOTHING;

-- schools_mealpricing (3 rows)
INSERT INTO "schools_mealpricing" ("id", "price_per_day", "is_active", "created_at", "updated_at", "location", "meal_type") VALUES
  (1, 20, TRUE, '2025-11-25 09:36:24.608855', '2025-12-02 13:42:54.056836', 'MAIN', 'TEA_BREAK'),
  (2, 50, TRUE, '2025-11-25 09:36:24.620816', '2025-12-02 13:42:54.071327', 'MAIN', 'LUNCH'),
  (3, 10, TRUE, '2025-11-25 09:36:24.633205', '2025-12-02 13:42:54.078958', 'MAIN', 'FRUITS')
ON CONFLICT DO NOTHING;

-- schools_syncstatus (1 rows)
INSERT INTO "schools_syncstatus" ("id", "is_online", "last_sync_attempt", "last_successful_sync", "pending_count", "failed_count", "auto_sync_enabled", "sync_interval_minutes", "max_retry_attempts", "sync_on_startup") VALUES
  (1, TRUE, NULL, NULL, 0, 0, TRUE, 5, 3, TRUE)
ON CONFLICT DO NOTHING;

-- finance_feecategory (4 rows)
INSERT INTO "finance_feecategory" ("id", "name", "description") VALUES
  (1, 'Tuition', NULL),
  (2, 'Transport', NULL),
  (3, 'Lunch', NULL),
  (4, 'Activities', NULL)
ON CONFLICT DO NOTHING;

-- finance_feestructure (45 rows)
INSERT INTO "finance_feestructure" ("id", "term", "academic_year", "amount", "is_mandatory", "description", "created_at", "category_id", "grade_id") VALUES
  (1, 1, '2024', 5000, TRUE, '', '2026-01-20 22:01:12.708244', 1, 4),
  (3, 1, '2024', 35000, TRUE, '', '2026-01-20 22:01:12.730609', 1, 13),
  (5, 1, '2024', 37000, TRUE, '', '2026-01-20 22:01:12.752001', 1, 14),
  (7, 1, '2024', 39000, TRUE, '', '2026-01-20 22:01:12.782362', 1, 15),
  (9, 1, '2024', 19000, TRUE, '', '2026-01-20 22:01:12.804919', 1, 5),
  (11, 1, '2024', 21000, TRUE, '', '2026-01-20 22:01:12.822007', 1, 6),
  (13, 1, '2024', 23000, TRUE, '', '2026-01-20 22:01:12.843915', 1, 7),
  (15, 1, '2024', 25000, TRUE, '', '2026-01-20 22:01:12.863971', 1, 8),
  (17, 1, '2024', 27000, TRUE, '', '2026-01-20 22:01:12.883232', 1, 9),
  (19, 1, '2024', 29000, TRUE, '', '2026-01-20 22:01:12.901941', 1, 10),
  (21, 1, '2024', 31000, TRUE, '', '2026-01-20 22:01:12.942977', 1, 11),
  (23, 1, '2024', 33000, TRUE, '', '2026-01-20 22:01:12.970364', 1, 12),
  (25, 1, '2024', 15000, TRUE, '', '2026-01-20 22:01:12.993282', 1, 1),
  (27, 1, '2024', 12000, TRUE, '', '2026-01-20 22:01:13.016824', 1, 2),
  (29, 1, '2024', 1000, TRUE, '', '2026-01-20 22:01:13.033680', 1, 3),
  (31, 2, '2024', 3000, TRUE, '', '2026-01-24 17:41:16.292778', 1, 4),
  (32, 3, '2024', 2599, TRUE, '', '2026-01-24 17:41:16.303237', 1, 4),
  (33, 2, '2024', 0, TRUE, '', '2026-01-24 17:41:16.320335', 1, 13),
  (34, 3, '2024', 0, TRUE, '', '2026-01-24 17:41:16.330466', 1, 13),
  (35, 2, '2024', 0, TRUE, '', '2026-01-24 17:41:16.395515', 1, 14),
  (36, 3, '2024', 0, TRUE, '', '2026-01-24 17:41:16.427246', 1, 14),
  (37, 2, '2024', 0, TRUE, '', '2026-01-24 17:41:16.460468', 1, 15),
  (38, 3, '2024', 0, TRUE, '', '2026-01-24 17:41:16.481378', 1, 15),
  (39, 2, '2024', 0, TRUE, '', '2026-01-24 17:41:16.511602', 1, 5),
  (40, 3, '2024', 0, TRUE, '', '2026-01-24 17:41:16.535699', 1, 5),
  (41, 2, '2024', 0, TRUE, '', '2026-01-24 17:41:16.552464', 1, 6),
  (42, 3, '2024', 0, TRUE, '', '2026-01-24 17:41:16.570938', 1, 6),
  (43, 2, '2024', 0, TRUE, '', '2026-01-24 17:41:16.590000', 1, 7),
  (44, 3, '2024', 0, TRUE, '', '2026-01-24 17:41:16.604736', 1, 7),
  (45, 2, '2024', 0, TRUE, '', '2026-01-24 17:41:16.624039', 1, 8),
  (46, 3, '2024', 0, TRUE, '', '2026-01-24 17:41:16.644138', 1, 8),
  (47, 2, '2024', 0, TRUE, '', '2026-01-24 17:41:16.663149', 1, 9),
  (48, 3, '2024', 0, TRUE, '', '2026-01-24 17:41:16.675272', 1, 9),
  (49, 2, '2024', 0, TRUE, '', '2026-01-24 17:41:16.695324', 1, 10),
  (50, 3, '2024', 0, TRUE, '', '2026-01-24 17:41:16.708058', 1, 10),
  (51, 2, '2024', 0, TRUE, '', '2026-01-24 17:41:16.724058', 1, 11),
  (52, 3, '2024', 0, TRUE, '', '2026-01-24 17:41:16.737631', 1, 11),
  (53, 2, '2024', 0, TRUE, '', '2026-01-24 17:41:16.752508', 1, 12),
  (54, 3, '2024', 0, TRUE, '', '2026-01-24 17:41:16.763450', 1, 12),
  (55, 2, '2024', 0, TRUE, '', '2026-01-24 17:41:16.779829', 1, 1),
  (56, 3, '2024', 0, TRUE, '', '2026-01-24 17:41:16.798702', 1, 1),
  (57, 2, '2024', 0, TRUE, '', '2026-01-24 17:41:16.814090', 1, 2),
  (58, 3, '2024', 0, TRUE, '', '2026-01-24 17:41:16.829895', 1, 2),
  (59, 2, '2024', 0, TRUE, '', '2026-01-24 17:41:16.846643', 1, 3),
  (60, 3, '2024', 0, TRUE, '', '2026-01-24 17:41:16.863944', 1, 3)
ON CONFLICT DO NOTHING;

-- finance_studentfinanceaccount (547 rows)
INSERT INTO "finance_studentfinanceaccount" ("id", "total_billed", "total_paid", "balance", "last_updated", "student_id") VALUES
  (1109, 6500, 0, 6500, '2026-01-24 11:45:40.500551', 769),
  (1110, 6500, 0, 6500, '2026-01-24 11:45:40.530741', 770),
  (1111, 6500, 0, 6500, '2026-01-24 11:45:40.556381', 771),
  (1112, 6500, 0, 6500, '2026-01-24 11:45:40.580430', 772),
  (1113, 6500, 0, 6500, '2026-01-24 11:45:40.639483', 773),
  (1114, 6500, 0, 6500, '2026-01-24 11:45:40.664272', 774),
  (1115, 6500, 0, 6500, '2026-01-24 11:45:40.690064', 775),
  (1116, 6500, 0, 6500, '2026-01-24 11:45:40.713991', 776),
  (1117, 6500, 0, 6500, '2026-01-24 11:45:40.736941', 777),
  (1118, 6500, 0, 6500, '2026-01-24 11:45:40.759717', 778),
  (1119, 6500, 0, 6500, '2026-01-24 11:45:40.782007', 779),
  (1120, 6500, 0, 6500, '2026-01-24 11:45:40.804577', 780),
  (1121, 6500, 0, 6500, '2026-01-24 11:45:40.827037', 781),
  (1122, 6500, 0, 6500, '2026-01-24 11:45:40.850893', 782),
  (1123, 6500, 0, 6500, '2026-01-24 11:45:40.874410', 783),
  (1124, 6500, 0, 6500, '2026-01-24 11:45:40.897551', 784),
  (1125, 6500, 0, 6500, '2026-01-24 11:45:40.921421', 785),
  (1126, 6500, 0, 6500, '2026-01-24 11:45:40.945321', 786),
  (1127, 6500, 0, 6500, '2026-01-24 11:45:40.970410', 787),
  (1128, 6500, 0, 6500, '2026-01-24 11:45:40.996329', 788),
  (1129, 6500, 0, 6500, '2026-01-24 11:45:41.021767', 789),
  (1130, 6500, 0, 6500, '2026-01-24 11:45:41.045550', 790),
  (1131, 6500, 0, 6500, '2026-01-24 11:45:41.069918', 791),
  (1132, 6500, 0, 6500, '2026-01-24 11:45:41.093650', 792),
  (1133, 6500, 0, 6500, '2026-01-24 11:45:41.117071', 793),
  (1134, 6500, 0, 6500, '2026-01-24 11:45:41.141126', 794),
  (1135, 6500, 0, 6500, '2026-01-24 11:45:41.164821', 795),
  (1136, 6500, 0, 6500, '2026-01-24 11:45:41.190455', 796),
  (1137, 6500, 0, 6500, '2026-01-24 11:45:41.215881', 797),
  (1138, 6500, 0, 6500, '2026-01-24 11:45:41.244430', 798),
  (1139, 6500, 0, 6500, '2026-01-24 11:45:41.271382', 799),
  (1140, 6500, 0, 6500, '2026-01-24 11:45:41.297764', 800),
  (1141, 6500, 0, 6500, '2026-01-24 11:45:41.325573', 801),
  (1142, 6500, 0, 6500, '2026-01-24 11:45:41.350323', 802),
  (1143, 6500, 0, 6500, '2026-01-24 11:45:41.376033', 803),
  (1144, 6500, 0, 6500, '2026-01-24 11:45:41.400245', 804),
  (1145, 6500, 0, 6500, '2026-01-24 11:45:41.422712', 805),
  (1146, 6500, 0, 6500, '2026-01-24 11:45:41.446700', 806),
  (1147, 6500, 0, 6500, '2026-01-24 11:45:41.471463', 807),
  (1148, 6500, 0, 6500, '2026-01-24 11:45:41.495827', 808),
  (1149, 6500, 0, 6500, '2026-01-24 11:45:41.530999', 809),
  (1150, 6500, 0, 6500, '2026-01-24 11:45:41.556715', 810),
  (1151, 6500, 0, 6500, '2026-01-24 11:45:41.579442', 811),
  (1152, 6500, 0, 6500, '2026-01-24 11:45:41.602653', 812),
  (1153, 6500, 0, 6500, '2026-01-24 11:45:41.625274', 813),
  (1154, 6500, 0, 6500, '2026-01-24 11:45:41.648410', 814),
  (1155, 6500, 0, 6500, '2026-01-24 11:45:41.672070', 815),
  (1156, 6500, 0, 6500, '2026-01-24 11:45:41.694871', 816),
  (1157, 6500, 0, 6500, '2026-01-24 11:45:41.717837', 817),
  (1158, 6500, 0, 6500, '2026-01-24 11:45:41.742746', 818),
  (1159, 6500, 0, 6500, '2026-01-24 11:45:41.766719', 819),
  (1160, 6500, 0, 6500, '2026-01-24 11:45:41.841808', 820),
  (1161, 6500, 0, 6500, '2026-01-24 11:45:41.865922', 821),
  (1162, 6500, 0, 6500, '2026-01-24 11:45:41.890768', 822),
  (1163, 6500, 0, 6500, '2026-01-24 11:45:41.923970', 823),
  (1164, 6500, 0, 6500, '2026-01-24 11:45:41.947173', 824),
  (1165, 6500, 0, 6500, '2026-01-24 11:45:41.986329', 825),
  (1166, 6500, 0, 6500, '2026-01-24 11:45:42.010491', 826),
  (1167, 6500, 0, 6500, '2026-01-24 11:45:42.034741', 827),
  (1168, 6500, 0, 6500, '2026-01-24 11:45:42.061296', 828),
  (1169, 6500, 0, 6500, '2026-01-24 11:45:42.085885', 829),
  (1170, 6500, 0, 6500, '2026-01-24 11:45:42.110191', 830),
  (1171, 6500, 0, 6500, '2026-01-24 11:45:42.143370', 831),
  (1172, 6500, 0, 6500, '2026-01-24 11:45:42.168309', 832),
  (1173, 6500, 0, 6500, '2026-01-24 11:45:42.213842', 833),
  (1174, 6500, 0, 6500, '2026-01-24 11:45:42.236848', 834),
  (1175, 6500, 0, 6500, '2026-01-24 11:45:42.261859', 835),
  (1176, 6500, 0, 6500, '2026-01-24 11:45:42.287836', 836),
  (1177, 6500, 0, 6500, '2026-01-24 11:45:42.310703', 837),
  (1178, 6500, 0, 6500, '2026-01-24 11:45:42.335814', 838),
  (1179, 6500, 0, 6500, '2026-01-24 11:45:42.388289', 839),
  (1180, 6500, 0, 6500, '2026-01-24 11:45:42.412843', 840),
  (1181, 6500, 0, 6500, '2026-01-24 11:45:42.445912', 841),
  (1182, 6500, 0, 6500, '2026-01-24 11:45:42.470503', 842),
  (1183, 6500, 0, 6500, '2026-01-24 11:45:42.493507', 843),
  (1184, 6500, 0, 6500, '2026-01-24 11:45:42.540528', 844),
  (1185, 6500, 0, 6500, '2026-01-24 11:45:42.572177', 845),
  (1186, 6500, 0, 6500, '2026-01-24 11:45:42.597528', 846),
  (1187, 6500, 0, 6500, '2026-01-24 11:45:42.621555', 847),
  (1188, 6500, 0, 6500, '2026-01-24 11:45:42.646923', 848),
  (1189, 6500, 0, 6500, '2026-01-24 11:45:42.676987', 849),
  (1190, 6500, 0, 6500, '2026-01-24 11:45:42.706563', 850),
  (1191, 6500, 0, 6500, '2026-01-24 11:45:42.734028', 851),
  (1192, 1000, 0, 1000, '2026-01-24 11:45:42.758436', 852),
  (1193, 1000, 0, 1000, '2026-01-24 11:45:42.782128', 853),
  (1194, 1000, 0, 1000, '2026-01-24 11:45:42.809607', 854),
  (1195, 1000, 0, 1000, '2026-01-24 11:45:42.835239', 855),
  (1196, 1000, 0, 1000, '2026-01-24 11:45:42.859689', 856),
  (1197, 1000, 0, 1000, '2026-01-24 11:45:42.884981', 857),
  (1198, 1000, 0, 1000, '2026-01-24 11:45:42.936810', 858),
  (1199, 1000, 0, 1000, '2026-01-24 11:45:42.962314', 859),
  (1200, 1000, 0, 1000, '2026-01-24 11:45:42.988879', 860),
  (1201, 1000, 0, 1000, '2026-01-24 11:45:43.014572', 861),
  (1202, 1000, 0, 1000, '2026-01-24 11:45:43.038583', 862),
  (1203, 1000, 0, 1000, '2026-01-24 11:45:43.062723', 863),
  (1204, 1000, 0, 1000, '2026-01-24 11:45:43.087096', 864),
  (1205, 1000, 0, 1000, '2026-01-24 11:45:43.114840', 865),
  (1206, 1000, 0, 1000, '2026-01-24 11:45:43.138930', 866),
  (1207, 1000, 0, 1000, '2026-01-24 11:45:43.162459', 867),
  (1208, 1000, 0, 1000, '2026-01-24 11:45:43.185756', 868),
  (1209, 1000, 0, 1000, '2026-01-24 11:45:43.209187', 869),
  (1210, 1000, 0, 1000, '2026-01-24 11:45:43.238676', 870),
  (1211, 1000, 0, 1000, '2026-01-24 11:45:43.262884', 871),
  (1212, 1000, 0, 1000, '2026-01-24 11:45:43.286831', 872),
  (1213, 1000, 0, 1000, '2026-01-24 11:45:43.339204', 873),
  (1214, 1000, 0, 1000, '2026-01-24 11:45:43.366218', 874),
  (1215, 1000, 0, 1000, '2026-01-24 11:45:43.402140', 875),
  (1216, 1000, 0, 1000, '2026-01-24 11:45:43.427195', 876),
  (1217, 1000, 0, 1000, '2026-01-24 11:45:43.449597', 877),
  (1218, 1000, 0, 1000, '2026-01-24 11:45:43.472848', 878),
  (1219, 1000, 0, 1000, '2026-01-24 11:45:43.496948', 879),
  (1220, 1000, 0, 1000, '2026-01-24 11:45:43.521153', 880),
  (1221, 1000, 0, 1000, '2026-01-24 11:45:43.586660', 881),
  (1222, 1000, 0, 1000, '2026-01-24 11:45:43.768628', 882),
  (1223, 1000, 0, 1000, '2026-01-24 11:45:43.792028', 883),
  (1224, 1000, 0, 1000, '2026-01-24 11:45:43.815438', 884),
  (1225, 1000, 0, 1000, '2026-01-24 11:45:43.843680', 885),
  (1226, 1000, 0, 1000, '2026-01-24 11:45:43.869705', 886),
  (1227, 6500, 0, 6500, '2026-01-24 11:45:43.894573', 887),
  (1228, 1000, 0, 1000, '2026-01-24 11:45:43.918223', 888),
  (1229, 1000, 0, 1000, '2026-01-24 11:45:43.943459', 889),
  (1230, 1000, 0, 1000, '2026-01-24 11:45:43.967277', 890),
  (1231, 1000, 0, 1000, '2026-01-24 11:45:44.017348', 891),
  (1232, 1000, 0, 1000, '2026-01-24 11:45:44.041026', 892),
  (1233, 1000, 0, 1000, '2026-01-24 11:45:44.065395', 893),
  (1234, 1000, 0, 1000, '2026-01-24 11:45:44.089647', 894),
  (1235, 1000, 0, 1000, '2026-01-24 11:45:44.113747', 895),
  (1236, 1000, 0, 1000, '2026-01-24 11:45:44.136713', 896),
  (1237, 1000, 0, 1000, '2026-01-24 11:45:44.160626', 897),
  (1238, 1000, 0, 1000, '2026-01-24 11:45:44.188001', 898),
  (1239, 1000, 0, 1000, '2026-01-24 11:45:44.211723', 899),
  (1240, 1000, 0, 1000, '2026-01-24 11:45:44.235392', 900),
  (1241, 1000, 0, 1000, '2026-01-24 11:45:44.258762', 901),
  (1242, 1000, 0, 1000, '2026-01-24 11:45:44.282539', 902),
  (1243, 1000, 0, 1000, '2026-01-24 11:45:44.306708', 903),
  (1244, 1000, 0, 1000, '2026-01-24 11:45:44.337318', 904),
  (1245, 1000, 0, 1000, '2026-01-24 11:45:44.362526', 905),
  (1246, 1000, 0, 1000, '2026-01-24 11:45:44.388315', 906),
  (1247, 1000, 0, 1000, '2026-01-24 11:45:44.412478', 907),
  (1248, 1000, 0, 1000, '2026-01-24 11:45:44.441283', 908),
  (1249, 1000, 0, 1000, '2026-01-24 11:45:44.464986', 909),
  (1250, 1000, 0, 1000, '2026-01-24 11:45:44.489571', 910),
  (1251, 1000, 0, 1000, '2026-01-24 11:45:44.519921', 911),
  (1252, 1000, 0, 1000, '2026-01-24 11:45:44.552705', 912),
  (1253, 1000, 0, 1000, '2026-01-24 11:45:44.577332', 913),
  (1254, 1000, 0, 1000, '2026-01-24 11:45:44.605340', 914),
  (1255, 1000, 0, 1000, '2026-01-24 11:45:44.630240', 915),
  (1256, 1000, 0, 1000, '2026-01-24 11:45:44.654451', 916),
  (1257, 1000, 0, 1000, '2026-01-24 11:45:44.682884', 917),
  (1258, 1000, 0, 1000, '2026-01-24 11:45:44.707622', 918),
  (1259, 1000, 0, 1000, '2026-01-24 11:45:44.732143', 919),
  (1260, 1000, 0, 1000, '2026-01-24 11:45:44.754908', 920),
  (1261, 1000, 0, 1000, '2026-01-24 11:45:44.779208', 921),
  (1262, 1000, 0, 1000, '2026-01-24 11:45:44.807421', 922),
  (1263, 1000, 0, 1000, '2026-01-24 11:45:44.830972', 923),
  (1264, 1000, 0, 1000, '2026-01-24 11:45:44.854901', 924),
  (1265, 1000, 0, 1000, '2026-01-24 11:45:44.881525', 925),
  (1266, 1000, 0, 1000, '2026-01-24 11:45:44.906880', 926),
  (1267, 1000, 0, 1000, '2026-01-24 11:45:44.931723', 927),
  (1268, 1000, 0, 1000, '2026-01-24 11:45:44.954563', 928),
  (1269, 1000, 0, 1000, '2026-01-24 11:45:44.981206', 929),
  (1270, 1000, 0, 1000, '2026-01-24 11:45:45.009094', 930),
  (1271, 1000, 0, 1000, '2026-01-24 11:45:45.034382', 931),
  (1272, 1000, 0, 1000, '2026-01-24 11:45:45.058023', 932),
  (1273, 1000, 0, 1000, '2026-01-24 11:45:45.082372', 933),
  (1274, 1000, 0, 1000, '2026-01-24 11:45:45.160860', 934),
  (1275, 1000, 0, 1000, '2026-01-24 11:45:45.189410', 935),
  (1276, 1000, 0, 1000, '2026-01-24 11:45:45.213366', 936),
  (1277, 1000, 0, 1000, '2026-01-24 11:45:45.236161', 937),
  (1278, 1000, 0, 1000, '2026-01-24 11:45:45.261968', 938),
  (1279, 1000, 0, 1000, '2026-01-24 11:45:45.289505', 939),
  (1280, 1000, 0, 1000, '2026-01-24 11:45:45.316309', 940),
  (1281, 15599, 0, 15599, '2026-01-24 17:52:00.984417', 941),
  (1282, 15599, 0, 15599, '2026-01-24 17:52:01.018288', 942),
  (1283, 15599, 0, 15599, '2026-01-24 17:52:01.086257', 943),
  (1284, 15599, 0, 15599, '2026-01-24 17:52:01.107577', 944),
  (1285, 15599, 0, 15599, '2026-01-24 17:52:01.142442', 945),
  (1286, 15599, 0, 15599, '2026-01-24 17:52:01.162086', 946),
  (1287, 15599, 0, 15599, '2026-01-24 17:52:01.187396', 947),
  (1288, 15599, 0, 15599, '2026-01-24 17:52:01.209890', 948),
  (1289, 15599, 0, 15599, '2026-01-24 17:52:01.244106', 949),
  (1290, 15599, 0, 15599, '2026-01-24 17:52:01.264852', 950),
  (1291, 15599, 0, 15599, '2026-01-24 17:52:01.287570', 951),
  (1292, 15599, 0, 15599, '2026-01-24 17:52:01.320179', 952),
  (1293, 15599, 0, 15599, '2026-01-24 17:52:01.358943', 953),
  (1294, 15599, 0, 15599, '2026-01-24 17:52:01.385330', 954),
  (1295, 15599, 0, 15599, '2026-01-24 17:52:01.407404', 955),
  (1296, 15599, 0, 15599, '2026-01-24 17:52:01.428360', 956),
  (1297, 15599, 0, 15599, '2026-01-24 17:52:01.478413', 957),
  (1298, 15599, 0, 15599, '2026-01-24 17:52:01.498505', 958),
  (1299, 15599, 0, 15599, '2026-01-24 17:52:01.518998', 959),
  (1300, 15599, 0, 15599, '2026-01-24 17:52:01.539220', 960),
  (1301, 15599, 0, 15599, '2026-01-24 17:52:01.586446', 961),
  (1302, 15599, 0, 15599, '2026-01-24 17:52:01.640757', 962),
  (1303, 15599, 0, 15599, '2026-01-24 17:52:01.668837', 963),
  (1304, 15599, 0, 15599, '2026-01-24 17:52:01.701418', 964),
  (1305, 15599, 0, 15599, '2026-01-24 17:52:01.736873', 965),
  (1306, 15599, 0, 15599, '2026-01-24 17:52:01.765191', 966),
  (1307, 15599, 0, 15599, '2026-01-24 17:52:01.795036', 967),
  (1308, 15599, 0, 15599, '2026-01-24 17:52:01.826765', 968)
ON CONFLICT DO NOTHING;
INSERT INTO "finance_studentfinanceaccount" ("id", "total_billed", "total_paid", "balance", "last_updated", "student_id") VALUES
  (1309, 15599, 0, 15599, '2026-01-24 17:52:01.853188', 969),
  (1310, 15599, 0, 15599, '2026-01-24 17:52:01.884868', 970),
  (1311, 15599, 0, 15599, '2026-01-24 17:52:01.925317', 971),
  (1312, 15599, 0, 15599, '2026-01-24 17:52:01.969356', 972),
  (1313, 15599, 0, 15599, '2026-01-24 17:52:02.022420', 973),
  (1314, 15599, 0, 15599, '2026-01-24 17:52:02.092332', 974),
  (1315, 15599, 0, 15599, '2026-01-24 17:52:02.131369', 975),
  (1316, 15599, 0, 15599, '2026-01-24 17:52:02.180468', 976),
  (1317, 15599, 0, 15599, '2026-01-24 17:52:02.251442', 977),
  (1318, 15599, 0, 15599, '2026-01-24 17:52:02.296236', 978),
  (1319, 15599, 0, 15599, '2026-01-24 17:52:02.419686', 979),
  (1320, 15599, 0, 15599, '2026-01-24 17:52:02.444751', 980),
  (1321, 15599, 0, 15599, '2026-01-24 17:52:02.465912', 981),
  (1322, 15599, 0, 15599, '2026-01-24 17:52:02.489080', 982),
  (1323, 15599, 0, 15599, '2026-01-24 17:52:02.508553', 983),
  (1324, 15599, 0, 15599, '2026-01-24 17:52:02.547726', 984),
  (1325, 15599, 0, 15599, '2026-01-24 17:52:02.593356', 985),
  (1326, 15599, 0, 15599, '2026-01-24 17:52:02.623863', 986),
  (1327, 15599, 0, 15599, '2026-01-24 17:52:02.645133', 987),
  (1328, 15599, 0, 15599, '2026-01-24 17:52:02.664638', 988),
  (1329, 15599, 0, 15599, '2026-01-24 17:52:02.688191', 989),
  (1330, 15599, 0, 15599, '2026-01-24 17:52:02.714600', 990),
  (1331, 15599, 0, 15599, '2026-01-24 17:52:02.735287', 991),
  (1332, 15599, 0, 15599, '2026-01-24 17:52:02.775275', 992),
  (1333, 15599, 0, 15599, '2026-01-24 17:52:02.796308', 993),
  (1334, 15599, 0, 15599, '2026-01-24 17:52:02.819807', 994),
  (1335, 15599, 0, 15599, '2026-01-24 17:52:02.853095', 995),
  (1336, 15599, 0, 15599, '2026-01-24 17:52:02.878978', 996),
  (1337, 15599, 0, 15599, '2026-01-24 17:52:02.899910', 997),
  (1338, 15599, 0, 15599, '2026-01-24 17:52:02.927733', 998),
  (1339, 15599, 0, 15599, '2026-01-24 17:52:02.968648', 999),
  (1340, 15599, 0, 15599, '2026-01-24 17:52:02.989843', 1000),
  (1341, 15599, 0, 15599, '2026-01-24 17:52:03.015613', 1001),
  (1342, 7000, 0, 7000, '2026-01-24 11:45:47.138418', 1002),
  (1343, 7000, 0, 7000, '2026-01-24 11:45:47.161803', 1003),
  (1344, 7000, 0, 7000, '2026-01-24 11:45:47.185904', 1004),
  (1345, 7000, 0, 7000, '2026-01-24 11:45:47.210086', 1005),
  (1346, 7000, 0, 7000, '2026-01-24 11:45:47.233854', 1006),
  (1347, 7000, 0, 7000, '2026-01-24 11:45:47.257067', 1007),
  (1348, 7000, 0, 7000, '2026-01-24 11:45:47.298374', 1008),
  (1349, 7000, 0, 7000, '2026-01-24 11:45:47.324519', 1009),
  (1350, 7000, 0, 7000, '2026-01-24 11:45:47.350160', 1010),
  (1351, 7000, 0, 7000, '2026-01-24 11:45:47.374892', 1011),
  (1352, 7000, 0, 7000, '2026-01-24 11:45:47.398588', 1012),
  (1353, 7000, 0, 7000, '2026-01-24 11:45:47.456564', 1013),
  (1354, 7000, 0, 7000, '2026-01-24 11:45:47.511741', 1014),
  (1355, 7000, 0, 7000, '2026-01-24 11:45:47.535533', 1015),
  (1356, 7000, 0, 7000, '2026-01-24 11:45:47.564309', 1016),
  (1357, 7000, 0, 7000, '2026-01-24 11:45:47.599606', 1017),
  (1358, 7000, 0, 7000, '2026-01-24 11:45:47.624762', 1018),
  (1359, 7000, 0, 7000, '2026-01-24 11:45:47.647881', 1019),
  (1360, 7000, 0, 7000, '2026-01-24 11:45:47.670303', 1020),
  (1361, 7000, 0, 7000, '2026-01-24 11:45:47.695959', 1021),
  (1362, 7000, 0, 7000, '2026-01-24 11:45:47.722140', 1022),
  (1363, 7000, 0, 7000, '2026-01-24 11:45:47.746197', 1023),
  (1364, 7000, 0, 7000, '2026-01-24 11:45:47.771139', 1024),
  (1365, 7000, 0, 7000, '2026-01-24 11:45:47.796008', 1025),
  (1366, 7000, 0, 7000, '2026-01-24 11:45:47.820254', 1026),
  (1367, 7000, 0, 7000, '2026-01-24 11:45:47.847800', 1027),
  (1368, 7000, 0, 7000, '2026-01-24 11:45:47.870929', 1028),
  (1369, 7000, 0, 7000, '2026-01-24 11:45:47.896086', 1029),
  (1370, 7000, 0, 7000, '2026-01-24 11:45:47.925617', 1030),
  (1371, 7000, 0, 7000, '2026-01-24 11:45:47.949149', 1031),
  (1372, 7000, 0, 7000, '2026-01-24 11:45:47.972256', 1032),
  (1373, 7000, 0, 7000, '2026-01-24 11:45:47.996360', 1033),
  (1374, 7000, 0, 7000, '2026-01-24 11:45:48.039212', 1034),
  (1375, 7000, 0, 7000, '2026-01-24 11:45:48.063396', 1035),
  (1376, 7000, 0, 7000, '2026-01-24 11:45:48.094217', 1036),
  (1377, 7000, 0, 7000, '2026-01-24 11:45:48.117802', 1037),
  (1378, 7000, 0, 7000, '2026-01-24 11:45:48.141417', 1038),
  (1379, 7000, 0, 7000, '2026-01-24 11:45:48.166521', 1039),
  (1380, 7000, 0, 7000, '2026-01-24 11:45:48.189743', 1040),
  (1381, 7000, 0, 7000, '2026-01-24 11:45:48.212926', 1041),
  (1382, 7000, 0, 7000, '2026-01-24 11:45:48.235218', 1042),
  (1383, 7000, 0, 7000, '2026-01-24 11:45:48.258780', 1043),
  (1384, 7000, 0, 7000, '2026-01-24 11:45:48.281745', 1044),
  (1385, 7000, 0, 7000, '2026-01-24 11:45:48.304597', 1045),
  (1386, 7000, 0, 7000, '2026-01-24 11:45:48.328677', 1046),
  (1387, 7000, 0, 7000, '2026-01-24 11:45:48.352424', 1047),
  (1388, 7000, 0, 7000, '2026-01-24 11:45:48.375991', 1048),
  (1389, 7000, 0, 7000, '2026-01-24 11:45:48.399574', 1049),
  (1390, 7000, 0, 7000, '2026-01-24 11:45:48.422481', 1050),
  (1391, 7000, 0, 7000, '2026-01-24 11:45:48.445629', 1051),
  (1392, 7000, 0, 7000, '2026-01-24 11:45:48.468745', 1052),
  (1393, 7000, 0, 7000, '2026-01-24 11:45:48.491977', 1053),
  (1394, 7000, 0, 7000, '2026-01-24 11:45:48.516180', 1054),
  (1395, 7000, 0, 7000, '2026-01-24 11:45:48.540851', 1055),
  (1396, 7000, 0, 7000, '2026-01-24 11:45:48.565206', 1056),
  (1397, 7000, 0, 7000, '2026-01-24 11:45:48.589450', 1057),
  (1398, 7000, 0, 7000, '2026-01-24 11:45:48.612472', 1058),
  (1399, 7000, 0, 7000, '2026-01-24 11:45:48.634401', 1059),
  (1400, 7000, 0, 7000, '2026-01-24 11:45:48.716242', 1060),
  (1401, 7000, 0, 7000, '2026-01-24 11:45:48.753960', 1061),
  (1402, 7000, 0, 7000, '2026-01-24 11:45:48.782279', 1062),
  (1403, 7000, 0, 7000, '2026-01-24 11:45:48.805174', 1063),
  (1404, 7000, 0, 7000, '2026-01-24 11:45:48.829985', 1064),
  (1405, 7000, 0, 7000, '2026-01-24 11:45:48.853952', 1065),
  (1406, 7000, 0, 7000, '2026-01-24 11:45:48.876922', 1066),
  (1407, 7000, 0, 7000, '2026-01-24 11:45:48.899913', 1067),
  (1408, 7000, 0, 7000, '2026-01-24 11:45:48.923530', 1068),
  (1409, 7000, 0, 7000, '2026-01-24 11:45:48.946851', 1069),
  (1410, 7000, 0, 7000, '2026-01-24 11:45:49.000715', 1070),
  (1411, 7000, 0, 7000, '2026-01-24 11:45:49.026657', 1071),
  (1412, 7000, 0, 7000, '2026-01-24 11:45:49.049183', 1072),
  (1413, 7000, 0, 7000, '2026-01-24 11:45:49.091181', 1073),
  (1414, 7000, 0, 7000, '2026-01-24 11:45:49.113982', 1074),
  (1415, 7000, 0, 7000, '2026-01-24 11:45:49.377889', 1075),
  (1416, 7000, 0, 7000, '2026-01-24 11:45:49.404033', 1076),
  (1417, 7000, 0, 7000, '2026-01-24 11:45:49.428220', 1077),
  (1418, 7000, 0, 7000, '2026-01-24 11:45:49.450781', 1078),
  (1419, 7000, 0, 7000, '2026-01-24 11:45:49.473678', 1079),
  (1420, 7000, 0, 7000, '2026-01-24 11:45:49.496890', 1080),
  (1421, 7000, 0, 7000, '2026-01-24 11:45:49.522220', 1081),
  (1422, 7000, 0, 7000, '2026-01-24 11:45:49.546535', 1082),
  (1423, 7000, 0, 7000, '2026-01-24 11:45:49.570047', 1083),
  (1424, 7000, 0, 7000, '2026-01-24 11:45:49.595425', 1084),
  (1425, 7000, 0, 7000, '2026-01-24 11:45:49.618855', 1085),
  (1426, 7000, 0, 7000, '2026-01-24 11:45:49.652670', 1086),
  (1427, 7000, 0, 7000, '2026-01-24 11:45:49.685990', 1087),
  (1428, 7000, 0, 7000, '2026-01-24 11:45:49.749302', 1088),
  (1429, 7000, 0, 7000, '2026-01-24 11:45:49.774172', 1089),
  (1430, 7000, 0, 7000, '2026-01-24 11:45:49.798169', 1090),
  (1431, 7000, 0, 7000, '2026-01-24 11:45:49.821819', 1091),
  (1432, 7000, 0, 7000, '2026-01-24 11:45:49.844349', 1092),
  (1433, 7000, 0, 7000, '2026-01-24 11:45:49.868306', 1093),
  (1434, 7000, 0, 7000, '2026-01-24 11:45:49.891706', 1094),
  (1435, 7000, 0, 7000, '2026-01-24 11:45:49.914891', 1095),
  (1436, 7000, 0, 7000, '2026-01-24 11:45:49.938039', 1096),
  (1437, 7000, 0, 7000, '2026-01-24 11:45:49.961111', 1097),
  (1438, 7000, 0, 7000, '2026-01-24 11:45:49.984564', 1098),
  (1439, 7000, 0, 7000, '2026-01-24 11:45:50.009433', 1099),
  (1440, 7000, 0, 7000, '2026-01-24 11:45:50.035774', 1100),
  (1441, 7000, 0, 7000, '2026-01-24 11:45:50.063791', 1101),
  (1442, 7000, 0, 7000, '2026-01-24 11:45:50.089069', 1102),
  (1443, 7000, 0, 7000, '2026-01-24 11:45:50.116745', 1103),
  (1444, 7000, 0, 7000, '2026-01-24 11:45:50.144775', 1104),
  (1445, 7000, 0, 7000, '2026-01-24 11:45:50.171154', 1105),
  (1446, 7000, 0, 7000, '2026-01-24 11:45:50.196883', 1106),
  (1447, 7000, 0, 7000, '2026-01-24 11:45:50.223487', 1107),
  (1448, 7000, 0, 7000, '2026-01-24 11:45:50.245860', 1108),
  (1449, 7000, 0, 7000, '2026-01-24 11:45:50.267889', 1109),
  (1450, 7000, 0, 7000, '2026-01-24 11:45:50.291943', 1110),
  (1451, 7000, 0, 7000, '2026-01-24 11:45:50.318129', 1111),
  (1452, 7000, 0, 7000, '2026-01-24 11:45:50.342048', 1112),
  (1453, 7000, 0, 7000, '2026-01-24 11:45:50.365917', 1113),
  (1454, 7000, 0, 7000, '2026-01-24 11:45:50.418996', 1114),
  (1455, 7000, 0, 7000, '2026-01-24 11:45:50.443512', 1115),
  (1456, 7000, 0, 7000, '2026-01-24 11:45:50.468089', 1116),
  (1457, 7000, 0, 7000, '2026-01-24 11:45:50.492921', 1117),
  (1458, 7000, 0, 7000, '2026-01-24 11:45:50.517570', 1118),
  (1459, 7000, 0, 7000, '2026-01-24 11:45:50.543164', 1119),
  (1460, 7000, 0, 7000, '2026-01-24 11:45:50.568008', 1120),
  (1461, 7000, 0, 7000, '2026-01-24 11:45:50.592004', 1121),
  (1462, 7000, 0, 7000, '2026-01-24 11:45:50.615465', 1122),
  (1463, 7000, 0, 7000, '2026-01-24 11:45:50.638325', 1123),
  (1464, 7000, 0, 7000, '2026-01-24 11:45:50.662725', 1124),
  (1465, 7000, 0, 7000, '2026-01-24 11:45:50.711333', 1125),
  (1466, 8000, 0, 8000, '2026-01-24 11:45:50.744829', 1126),
  (1467, 8000, 0, 8000, '2026-01-24 11:45:50.769730', 1127),
  (1468, 8000, 0, 8000, '2026-01-24 11:45:50.794472', 1128),
  (1469, 8000, 0, 8000, '2026-01-24 11:45:50.817997', 1129),
  (1470, 8000, 0, 8000, '2026-01-24 11:45:50.845768', 1130),
  (1471, 8000, 0, 8000, '2026-01-24 11:45:50.872119', 1131),
  (1472, 8000, 0, 8000, '2026-01-24 11:45:50.896407', 1132),
  (1473, 8000, 0, 8000, '2026-01-24 11:45:50.920150', 1133),
  (1474, 8000, 0, 8000, '2026-01-24 11:45:50.944427', 1134),
  (1475, 8000, 0, 8000, '2026-01-24 11:45:50.968553', 1135),
  (1476, 8000, 0, 8000, '2026-01-24 11:45:50.992369', 1136),
  (1477, 8000, 0, 8000, '2026-01-24 11:45:51.016493', 1137),
  (1478, 8000, 0, 8000, '2026-01-24 11:45:51.043388', 1138),
  (1479, 8000, 0, 8000, '2026-01-24 11:45:51.067667', 1139),
  (1480, 8000, 0, 8000, '2026-01-24 11:45:51.107035', 1140),
  (1481, 8000, 0, 8000, '2026-01-24 11:45:51.130442', 1141),
  (1482, 8000, 0, 8000, '2026-01-24 11:45:51.153748', 1142),
  (1483, 8000, 0, 8000, '2026-01-24 11:45:51.178217', 1143),
  (1484, 8000, 0, 8000, '2026-01-24 11:45:51.202975', 1144),
  (1485, 8000, 0, 8000, '2026-01-24 11:45:51.226593', 1145),
  (1486, 8000, 0, 8000, '2026-01-24 11:45:51.249773', 1146),
  (1487, 8000, 0, 8000, '2026-01-24 11:45:51.274293', 1147),
  (1488, 8000, 0, 8000, '2026-01-24 11:45:51.298460', 1148),
  (1489, 8000, 0, 8000, '2026-01-24 11:45:51.323315', 1149),
  (1490, 8000, 0, 8000, '2026-01-24 11:45:51.347271', 1150),
  (1491, 8000, 0, 8000, '2026-01-24 11:45:51.371732', 1151),
  (1492, 8000, 0, 8000, '2026-01-24 11:45:51.394623', 1152),
  (1493, 8000, 0, 8000, '2026-01-24 11:45:51.417460', 1153),
  (1494, 8000, 0, 8000, '2026-01-24 11:45:51.440396', 1154),
  (1495, 8000, 0, 8000, '2026-01-24 11:45:51.469349', 1155),
  (1496, 8000, 0, 8000, '2026-01-24 11:45:51.496628', 1156),
  (1497, 8000, 0, 8000, '2026-01-24 11:45:51.537606', 1157),
  (1498, 7000, 0, 7000, '2026-01-24 11:45:51.565247', 1158),
  (1499, 8000, 0, 8000, '2026-01-24 11:45:51.592918', 1159),
  (1500, 8000, 0, 8000, '2026-01-24 11:45:51.617631', 1160),
  (1501, 8000, 0, 8000, '2026-01-24 11:45:51.641140', 1161),
  (1502, 8000, 0, 8000, '2026-01-24 11:45:51.664635', 1162),
  (1503, 8000, 0, 8000, '2026-01-24 11:45:51.690110', 1163),
  (1504, 8000, 0, 8000, '2026-01-24 11:45:51.714306', 1164),
  (1505, 8000, 0, 8000, '2026-01-24 11:45:51.742498', 1165),
  (1506, 8000, 0, 8000, '2026-01-24 11:45:51.765936', 1166),
  (1507, 8000, 0, 8000, '2026-01-24 11:45:51.789530', 1167),
  (1508, 8000, 0, 8000, '2026-01-24 11:45:51.812760', 1168)
ON CONFLICT DO NOTHING;
INSERT INTO "finance_studentfinanceaccount" ("id", "total_billed", "total_paid", "balance", "last_updated", "student_id") VALUES
  (1509, 8000, 0, 8000, '2026-01-24 11:45:51.837650', 1169),
  (1510, 8000, 0, 8000, '2026-01-24 11:45:51.869324', 1170),
  (1511, 8000, 0, 8000, '2026-01-24 11:45:51.896595', 1171),
  (1512, 8000, 0, 8000, '2026-01-24 11:45:51.920454', 1172),
  (1513, 8000, 0, 8000, '2026-01-24 11:45:51.944495', 1173),
  (1514, 8000, 0, 8000, '2026-01-24 11:45:51.967746', 1174),
  (1515, 8000, 0, 8000, '2026-01-24 11:45:51.990940', 1175),
  (1516, 8000, 0, 8000, '2026-01-24 11:45:52.066480', 1176),
  (1517, 8000, 0, 8000, '2026-01-24 11:45:52.091337', 1177),
  (1518, 8000, 0, 8000, '2026-01-24 11:45:52.116629', 1178),
  (1519, 8000, 0, 8000, '2026-01-24 11:45:52.142811', 1179),
  (1520, 8000, 0, 8000, '2026-01-24 11:45:52.167407', 1180),
  (1521, 8000, 0, 8000, '2026-01-24 11:45:52.191449', 1181),
  (1522, 8000, 0, 8000, '2026-01-24 11:45:52.227543', 1182),
  (1523, 8000, 0, 8000, '2026-01-24 11:45:52.253338', 1183),
  (1524, 8000, 0, 8000, '2026-01-24 11:45:52.280115', 1184),
  (1525, 8000, 0, 8000, '2026-01-24 11:45:52.307048', 1185),
  (1526, 8000, 0, 8000, '2026-01-24 11:45:52.340175', 1186),
  (1527, 8000, 0, 8000, '2026-01-24 11:45:52.383081', 1187),
  (1528, 8000, 0, 8000, '2026-01-24 11:45:52.413651', 1188),
  (1529, 8000, 0, 8000, '2026-01-24 11:45:52.442495', 1189),
  (1530, 8000, 0, 8000, '2026-01-24 11:45:52.479308', 1190),
  (1531, 8000, 0, 8000, '2026-01-24 11:45:52.514132', 1191),
  (1532, 8000, 0, 8000, '2026-01-24 11:45:52.562544', 1192),
  (1533, 8000, 0, 8000, '2026-01-24 11:45:52.593707', 1193),
  (1534, 8000, 0, 8000, '2026-01-24 11:45:52.656263', 1194),
  (1535, 8000, 0, 8000, '2026-01-24 11:45:52.682745', 1195),
  (1536, 8000, 0, 8000, '2026-01-24 11:45:52.707306', 1196),
  (1537, 8000, 0, 8000, '2026-01-24 11:45:52.755565', 1197),
  (1538, 8000, 0, 8000, '2026-01-24 11:45:53.054593', 1198),
  (1539, 8000, 0, 8000, '2026-01-24 11:45:53.139118', 1199),
  (1540, 8000, 0, 8000, '2026-01-24 11:45:53.201736', 1200),
  (1541, 8000, 0, 8000, '2026-01-24 11:45:53.225269', 1201),
  (1542, 0, 0, 0, '2026-01-24 11:45:53.232217', 1202),
  (1543, 0, 0, 0, '2026-01-24 11:45:53.238951', 1203),
  (1544, 0, 0, 0, '2026-01-24 11:45:53.245811', 1204),
  (1545, 0, 0, 0, '2026-01-24 11:45:53.253092', 1205),
  (1546, 0, 0, 0, '2026-01-24 11:45:53.260446', 1206),
  (1547, 0, 0, 0, '2026-01-24 11:45:53.268000', 1207),
  (1548, 0, 0, 0, '2026-01-24 11:45:53.278239', 1208),
  (1549, 0, 0, 0, '2026-01-24 11:45:53.285359', 1209),
  (1550, 0, 0, 0, '2026-01-24 11:45:53.293456', 1210),
  (1551, 0, 0, 0, '2026-01-24 11:45:53.300431', 1211),
  (1552, 0, 0, 0, '2026-01-24 11:45:53.309514', 1212),
  (1553, 0, 0, 0, '2026-01-24 11:45:53.317072', 1213),
  (1554, 0, 0, 0, '2026-01-24 11:45:53.324063', 1214),
  (1555, 0, 0, 0, '2026-01-24 11:45:53.331228', 1215),
  (1556, 7500, 0, 7500, '2026-01-24 11:45:53.365005', 1216),
  (1557, 7500, 0, 7500, '2026-01-24 11:45:53.388011', 1217),
  (1558, 7500, 0, 7500, '2026-01-24 11:45:53.414877', 1218),
  (1559, 7500, 0, 7500, '2026-01-24 11:45:53.438680', 1219),
  (1560, 7500, 0, 7500, '2026-01-24 11:45:53.461433', 1220),
  (1561, 7500, 0, 7500, '2026-01-24 11:45:53.484275', 1221),
  (1562, 7500, 0, 7500, '2026-01-24 11:45:53.508069', 1222),
  (1563, 7500, 0, 7500, '2026-01-24 11:45:53.532021', 1223),
  (1564, 7500, 0, 7500, '2026-01-24 11:45:53.557968', 1224),
  (1565, 7500, 0, 7500, '2026-01-24 11:45:53.584200', 1225),
  (1566, 7500, 0, 7500, '2026-01-24 11:45:53.616423', 1226),
  (1567, 6500, 0, 6500, '2026-01-24 11:45:53.641791', 1227),
  (1568, 6500, 0, 6500, '2026-01-24 11:45:53.665436', 1228),
  (1569, 6500, 0, 6500, '2026-01-24 11:45:53.695328', 1229),
  (1570, 6500, 0, 6500, '2026-01-24 11:45:53.719706', 1230),
  (1571, 6500, 0, 6500, '2026-01-24 11:45:53.743365', 1231),
  (1572, 6500, 0, 6500, '2026-01-24 11:45:53.767857', 1232),
  (1573, 6500, 0, 6500, '2026-01-24 11:45:53.791825', 1233),
  (1574, 6500, 0, 6500, '2026-01-24 11:45:53.818549', 1234),
  (1575, 6500, 0, 6500, '2026-01-24 11:45:53.843501', 1235),
  (1576, 6500, 0, 6500, '2026-01-24 11:45:53.866047', 1236),
  (1577, 6500, 0, 6500, '2026-01-24 11:45:53.889726', 1237),
  (1578, 6500, 0, 6500, '2026-01-24 11:45:53.931112', 1238),
  (1579, 6500, 0, 6500, '2026-01-24 11:45:53.968038', 1239),
  (1580, 6500, 0, 6500, '2026-01-24 11:45:53.993677', 1240),
  (1581, 6500, 0, 6500, '2026-01-24 11:45:54.018356', 1241),
  (1582, 6500, 0, 6500, '2026-01-24 11:45:54.044210', 1242),
  (1583, 6500, 0, 6500, '2026-01-24 11:45:54.067649', 1243),
  (1584, 6500, 0, 6500, '2026-01-24 11:45:54.090289', 1244),
  (1585, 6500, 0, 6500, '2026-01-24 11:45:54.113086', 1245),
  (1586, 6500, 0, 6500, '2026-01-24 11:45:54.136544', 1246),
  (1587, 6500, 0, 6500, '2026-01-24 11:45:54.161074', 1247),
  (1588, 6500, 0, 6500, '2026-01-24 11:45:54.184643', 1248),
  (1589, 6500, 0, 6500, '2026-01-24 11:45:54.207523', 1249),
  (1590, 6500, 0, 6500, '2026-01-24 11:45:54.230388', 1250),
  (1591, 6500, 0, 6500, '2026-01-24 11:45:54.254031', 1251),
  (1592, 6500, 0, 6500, '2026-01-24 11:45:54.278000', 1252),
  (1593, 6500, 0, 6500, '2026-01-24 11:45:54.301087', 1253),
  (1594, 6500, 0, 6500, '2026-01-24 11:45:54.324988', 1254),
  (1595, 6500, 0, 6500, '2026-01-24 11:45:54.354653', 1255),
  (1596, 6500, 0, 6500, '2026-01-24 11:45:54.401612', 1256),
  (1597, 6500, 0, 6500, '2026-01-24 11:45:54.468981', 1257),
  (1598, 6500, 0, 6500, '2026-01-24 11:45:54.493233', 1258),
  (1599, 6500, 0, 6500, '2026-01-24 11:45:54.519304', 1259),
  (1600, 6500, 0, 6500, '2026-01-24 11:45:54.545549', 1260),
  (1601, 6500, 0, 6500, '2026-01-24 11:45:54.575739', 1261),
  (1602, 6500, 0, 6500, '2026-01-24 11:45:54.599217', 1262),
  (1603, 6500, 0, 6500, '2026-01-24 11:45:54.623155', 1263),
  (1604, 6500, 0, 6500, '2026-01-24 11:45:54.649735', 1264),
  (1605, 6500, 0, 6500, '2026-01-24 11:45:54.674957', 1265),
  (1606, 6500, 0, 6500, '2026-01-24 11:45:54.699321', 1266),
  (1607, 6500, 0, 6500, '2026-01-24 11:45:54.995816', 1267),
  (1608, 6500, 0, 6500, '2026-01-24 11:45:55.027134', 1268),
  (1609, 6500, 0, 6500, '2026-01-24 11:45:55.093004', 1269),
  (1610, 6500, 0, 6500, '2026-01-24 11:45:55.132007', 1270),
  (1611, 6500, 0, 6500, '2026-01-24 11:45:55.312919', 1271),
  (1612, 6500, 0, 6500, '2026-01-24 11:45:55.344698', 1272),
  (1613, 6500, 0, 6500, '2026-01-24 11:45:55.376251', 1273),
  (1614, 6500, 0, 6500, '2026-01-24 11:45:55.405172', 1274),
  (1615, 1000, 0, 1000, '2026-01-24 11:45:55.433457', 1275),
  (1616, 1000, 0, 1000, '2026-01-24 11:45:55.493192', 1276),
  (1617, 1000, 0, 1000, '2026-01-24 11:45:55.522584', 1277),
  (1618, 1000, 0, 1000, '2026-01-24 11:45:55.548442', 1278),
  (1619, 1000, 0, 1000, '2026-01-24 11:45:55.575773', 1279),
  (1620, 1000, 0, 1000, '2026-01-24 11:45:55.605281', 1280),
  (1621, 1000, 0, 1000, '2026-01-24 11:45:55.635598', 1281),
  (1622, 1000, 0, 1000, '2026-01-24 11:45:55.660681', 1282),
  (1623, 1000, 0, 1000, '2026-01-24 11:45:55.686608', 1283),
  (1624, 1000, 0, 1000, '2026-01-24 11:45:55.712897', 1284),
  (1625, 1000, 0, 1000, '2026-01-24 11:45:55.741275', 1285),
  (1626, 15599, 0, 15599, '2026-01-24 17:52:03.036939', 1286),
  (1627, 15599, 0, 15599, '2026-01-24 17:52:03.058996', 1287),
  (1628, 15599, 0, 15599, '2026-01-24 17:52:03.081072', 1288),
  (1629, 15599, 0, 15599, '2026-01-24 17:52:03.104820', 1289),
  (1630, 15599, 0, 15599, '2026-01-24 17:52:03.143622', 1290),
  (1631, 15599, 0, 15599, '2026-01-24 17:52:03.165902', 1291),
  (1632, 15599, 0, 15599, '2026-01-24 17:52:03.185319', 1292),
  (1633, 15599, 0, 15599, '2026-01-24 17:52:03.247520', 1293),
  (1634, 15599, 0, 15599, '2026-01-24 17:52:03.275194', 1294),
  (1635, 15599, 0, 15599, '2026-01-24 17:52:03.319858', 1295),
  (1636, 15599, 0, 15599, '2026-01-24 17:52:03.345450', 1296),
  (1637, 7000, 0, 7000, '2026-01-24 11:45:56.076886', 1297),
  (1638, 7000, 0, 7000, '2026-01-24 11:45:56.113947', 1298),
  (1639, 7000, 0, 7000, '2026-01-24 11:45:56.140825', 1299),
  (1640, 7000, 0, 7000, '2026-01-24 11:45:56.165703', 1300),
  (1641, 7000, 0, 7000, '2026-01-24 11:45:56.193872', 1301),
  (1642, 7000, 0, 7000, '2026-01-24 11:45:56.219864', 1302),
  (1643, 7000, 0, 7000, '2026-01-24 11:45:56.244983', 1303),
  (1644, 7000, 0, 7000, '2026-01-24 11:45:56.304132', 1304),
  (1645, 7000, 0, 7000, '2026-01-24 11:45:56.330579', 1305),
  (1646, 7000, 0, 7000, '2026-01-24 11:45:56.357839', 1306),
  (1647, 7000, 0, 7000, '2026-01-24 11:45:56.384256', 1307),
  (1648, 7000, 0, 7000, '2026-01-24 11:45:56.412670', 1308),
  (1649, 7000, 0, 7000, '2026-01-24 11:45:56.441585', 1309),
  (1650, 7000, 0, 7000, '2026-01-24 11:45:56.470143', 1310),
  (1651, 7000, 0, 7000, '2026-01-24 11:45:56.497791', 1311),
  (1652, 7000, 0, 7000, '2026-01-24 11:45:56.524207', 1312),
  (1653, 7000, 0, 7000, '2026-01-24 11:45:56.549713', 1313),
  (1654, 7000, 0, 7000, '2026-01-24 11:45:56.578522', 1314),
  (1655, 7000, 0, 7000, '2026-01-24 11:45:56.624552', 1315)
ON CONFLICT DO NOTHING;

-- finance_transaction (749 rows)
INSERT INTO "finance_transaction" ("id", "type", "amount", "description", "reference", "payment_method", "term", "academic_year", "date", "account_id", "recorded_by_id") VALUES
  (1040, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:40.490610', 1109, NULL),
  (1041, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:40.521465', 1110, NULL),
  (1042, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:40.547266', 1111, NULL),
  (1043, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:40.571476', 1112, NULL),
  (1044, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:40.627706', 1113, NULL),
  (1045, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:40.655288', 1114, NULL),
  (1046, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:40.679531', 1115, NULL),
  (1047, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:40.705049', 1116, NULL),
  (1048, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:40.728368', 1117, NULL),
  (1049, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:40.751578', 1118, NULL),
  (1050, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:40.773649', 1119, NULL),
  (1051, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:40.796181', 1120, NULL),
  (1052, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:40.818511', 1121, NULL),
  (1053, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:40.841722', 1122, NULL),
  (1054, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:40.865739', 1123, NULL),
  (1055, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:40.888818', 1124, NULL),
  (1056, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:40.912499', 1125, NULL),
  (1057, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:40.935915', 1126, NULL),
  (1058, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:40.960513', 1127, NULL),
  (1059, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:40.987319', 1128, NULL),
  (1060, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:41.011551', 1129, NULL),
  (1061, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:41.036258', 1130, NULL),
  (1062, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:41.060560', 1131, NULL),
  (1063, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:41.084643', 1132, NULL),
  (1064, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:41.108392', 1133, NULL),
  (1065, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:41.131584', 1134, NULL),
  (1066, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:41.156129', 1135, NULL),
  (1067, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:41.181067', 1136, NULL),
  (1068, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:41.206466', 1137, NULL),
  (1069, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:41.235598', 1138, NULL),
  (1070, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:41.262226', 1139, NULL),
  (1071, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:41.288199', 1140, NULL),
  (1072, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:41.315254', 1141, NULL),
  (1073, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:41.340770', 1142, NULL),
  (1074, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:41.365792', 1143, NULL),
  (1075, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:41.391165', 1144, NULL),
  (1076, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:41.414158', 1145, NULL),
  (1077, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:41.438003', 1146, NULL),
  (1078, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:41.462081', 1147, NULL),
  (1079, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:41.486396', 1148, NULL),
  (1080, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:41.521226', 1149, NULL),
  (1081, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:41.546478', 1150, NULL),
  (1082, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:41.571179', 1151, NULL),
  (1083, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:41.593979', 1152, NULL),
  (1084, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:41.616766', 1153, NULL),
  (1085, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:41.639577', 1154, NULL),
  (1086, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:41.663416', 1155, NULL),
  (1087, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:41.686373', 1156, NULL),
  (1088, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:41.709186', 1157, NULL),
  (1089, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:41.732914', 1158, NULL),
  (1090, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:41.757039', 1159, NULL),
  (1091, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:41.833304', 1160, NULL),
  (1092, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:41.856768', 1161, NULL),
  (1093, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:41.880590', 1162, NULL),
  (1094, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:41.915674', 1163, NULL),
  (1095, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:41.937873', 1164, NULL),
  (1096, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:41.977699', 1165, NULL),
  (1097, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:42.001671', 1166, NULL),
  (1098, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:42.025587', 1167, NULL),
  (1099, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:42.051336', 1168, NULL),
  (1100, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:42.077356', 1169, NULL),
  (1101, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:42.101185', 1170, NULL),
  (1102, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:42.125239', 1171, NULL),
  (1103, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:42.159019', 1172, NULL),
  (1104, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:42.183983', 1173, NULL),
  (1105, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:42.228560', 1174, NULL),
  (1106, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:42.251312', 1175, NULL),
  (1107, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:42.278555', 1176, NULL),
  (1108, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:42.302034', 1177, NULL),
  (1109, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:42.326688', 1178, NULL),
  (1110, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:42.379182', 1179, NULL),
  (1111, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:42.403514', 1180, NULL),
  (1112, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:42.428299', 1181, NULL),
  (1113, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:42.461742', 1182, NULL),
  (1114, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:42.484601', 1183, NULL),
  (1115, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:42.531117', 1184, NULL),
  (1116, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:42.558880', 1185, NULL),
  (1117, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:42.587845', 1186, NULL),
  (1118, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:42.611638', 1187, NULL),
  (1119, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:42.637386', 1188, NULL),
  (1120, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:42.665978', 1189, NULL),
  (1121, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:42.694853', 1190, NULL),
  (1122, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:42.723578', 1191, NULL),
  (1123, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:42.749289', 1192, NULL),
  (1124, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:42.773395', 1193, NULL),
  (1125, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:42.796782', 1194, NULL),
  (1126, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:42.824842', 1195, NULL),
  (1127, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:42.850305', 1196, NULL),
  (1128, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:42.875033', 1197, NULL),
  (1129, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:42.907986', 1198, NULL),
  (1130, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:42.953432', 1199, NULL),
  (1131, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:42.975997', 1200, NULL),
  (1132, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:43.004968', 1201, NULL),
  (1133, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:43.029552', 1202, NULL),
  (1134, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:43.053987', 1203, NULL),
  (1135, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:43.077409', 1204, NULL),
  (1136, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:43.103715', 1205, NULL),
  (1137, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:43.129807', 1206, NULL),
  (1138, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:43.154085', 1207, NULL),
  (1139, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:43.176993', 1208, NULL),
  (1140, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:43.200401', 1209, NULL),
  (1141, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:43.227577', 1210, NULL),
  (1142, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:43.254186', 1211, NULL),
  (1143, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:43.278149', 1212, NULL),
  (1144, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:43.301182', 1213, NULL),
  (1145, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:43.356845', 1214, NULL),
  (1146, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:43.384014', 1215, NULL),
  (1147, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:43.418614', 1216, NULL),
  (1148, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:43.441301', 1217, NULL),
  (1149, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:43.463940', 1218, NULL),
  (1150, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:43.487919', 1219, NULL),
  (1151, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:43.512225', 1220, NULL),
  (1152, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:43.535530', 1221, NULL),
  (1153, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:43.759234', 1222, NULL),
  (1154, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:43.783335', 1223, NULL),
  (1155, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:43.806283', 1224, NULL),
  (1156, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:43.834218', 1225, NULL),
  (1157, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:43.858817', 1226, NULL),
  (1158, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:43.885377', 1227, NULL),
  (1159, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:43.908961', 1228, NULL),
  (1160, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:43.935136', 1229, NULL),
  (1161, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:43.958724', 1230, NULL),
  (1162, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:44.001795', 1231, NULL),
  (1163, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:44.032061', 1232, NULL),
  (1164, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:44.056412', 1233, NULL),
  (1165, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:44.080415', 1234, NULL),
  (1166, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:44.105105', 1235, NULL),
  (1167, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:44.127889', 1236, NULL),
  (1168, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:44.151542', 1237, NULL),
  (1169, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:44.178040', 1238, NULL),
  (1170, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:44.202845', 1239, NULL),
  (1171, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:44.226851', 1240, NULL),
  (1172, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:44.249992', 1241, NULL),
  (1173, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:44.273480', 1242, NULL),
  (1174, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:44.297777', 1243, NULL),
  (1175, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:44.325822', 1244, NULL),
  (1176, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:44.353737', 1245, NULL),
  (1177, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:44.379599', 1246, NULL),
  (1178, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:44.403281', 1247, NULL),
  (1179, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:44.432094', 1248, NULL),
  (1180, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:44.456422', 1249, NULL),
  (1181, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:44.480215', 1250, NULL),
  (1182, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:44.507977', 1251, NULL),
  (1183, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:44.542915', 1252, NULL),
  (1184, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:44.568355', 1253, NULL),
  (1185, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:44.596525', 1254, NULL),
  (1186, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:44.621038', 1255, NULL),
  (1187, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:44.645551', 1256, NULL),
  (1188, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:44.668907', 1257, NULL),
  (1189, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:44.699009', 1258, NULL),
  (1190, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:44.723134', 1259, NULL),
  (1191, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:44.746328', 1260, NULL),
  (1192, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:44.770762', 1261, NULL),
  (1193, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:44.795687', 1262, NULL),
  (1194, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:44.821980', 1263, NULL),
  (1195, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:44.845467', 1264, NULL),
  (1196, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:44.869984', 1265, NULL),
  (1197, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:44.898159', 1266, NULL),
  (1198, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:44.922287', 1267, NULL),
  (1199, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:44.945950', 1268, NULL),
  (1200, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:44.970883', 1269, NULL),
  (1201, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:44.997676', 1270, NULL),
  (1202, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:45.024672', 1271, NULL),
  (1203, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:45.049001', 1272, NULL),
  (1204, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:45.072672', 1273, NULL),
  (1205, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:45.098667', 1274, NULL),
  (1206, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:45.177279', 1275, NULL),
  (1207, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:45.204614', 1276, NULL),
  (1208, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:45.227321', 1277, NULL),
  (1209, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:45.252475', 1278, NULL),
  (1210, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:45.277124', 1279, NULL),
  (1211, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:45.306847', 1280, NULL),
  (1212, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:45.347746', 1281, NULL),
  (1213, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:45.376503', 1282, NULL),
  (1214, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:45.405450', 1283, NULL),
  (1215, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:45.433045', 1284, NULL),
  (1216, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:45.459593', 1285, NULL),
  (1217, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:45.484933', 1286, NULL),
  (1218, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:45.516541', 1287, NULL),
  (1219, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:45.544988', 1288, NULL),
  (1220, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:45.572199', 1289, NULL),
  (1221, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:45.601404', 1290, NULL),
  (1222, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:45.624823', 1291, NULL),
  (1223, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:45.647543', 1292, NULL),
  (1224, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:45.670261', 1293, NULL),
  (1225, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:45.693742', 1294, NULL),
  (1226, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:45.716677', 1295, NULL),
  (1227, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:45.739492', 1296, NULL),
  (1228, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:45.763495', 1297, NULL),
  (1229, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:45.785981', 1298, NULL),
  (1230, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:45.809013', 1299, NULL),
  (1231, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:45.831302', 1300, NULL),
  (1232, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:45.854503', 1301, NULL),
  (1233, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:45.879377', 1302, NULL),
  (1234, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:45.902531', 1303, NULL),
  (1235, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:45.926309', 1304, NULL),
  (1236, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:45.952169', 1305, NULL),
  (1237, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:45.975867', 1306, NULL),
  (1238, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:46.001413', 1307, NULL),
  (1239, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:46.027503', 1308, NULL)
ON CONFLICT DO NOTHING;
INSERT INTO "finance_transaction" ("id", "type", "amount", "description", "reference", "payment_method", "term", "academic_year", "date", "account_id", "recorded_by_id") VALUES
  (1240, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:46.052295', 1309, NULL),
  (1241, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:46.085124', 1310, NULL),
  (1242, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:46.115952', 1311, NULL),
  (1243, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:46.148346', 1312, NULL),
  (1244, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:46.172079', 1313, NULL),
  (1245, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:46.195797', 1314, NULL),
  (1246, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:46.221510', 1315, NULL),
  (1247, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:46.252477', 1316, NULL),
  (1248, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:46.345340', 1317, NULL),
  (1249, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:46.369211', 1318, NULL),
  (1250, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:46.392613', 1319, NULL),
  (1251, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:46.460799', 1320, NULL),
  (1252, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:46.492454', 1321, NULL),
  (1253, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:46.541098', 1322, NULL),
  (1254, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:46.568483', 1323, NULL),
  (1255, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:46.594861', 1324, NULL),
  (1256, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:46.621495', 1325, NULL),
  (1257, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:46.651278', 1326, NULL),
  (1258, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:46.712353', 1327, NULL),
  (1259, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:46.749639', 1328, NULL),
  (1260, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:46.785049', 1329, NULL),
  (1261, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:46.813342', 1330, NULL),
  (1262, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:46.840874', 1331, NULL),
  (1263, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:46.881375', 1332, NULL),
  (1264, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:46.907133', 1333, NULL),
  (1265, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:46.931279', 1334, NULL),
  (1266, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:46.958300', 1335, NULL),
  (1267, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:46.983347', 1336, NULL),
  (1268, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:47.008971', 1337, NULL),
  (1269, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:47.032488', 1338, NULL),
  (1270, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:47.057168', 1339, NULL),
  (1271, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:47.082979', 1340, NULL),
  (1272, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:47.106154', 1341, NULL),
  (1273, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:47.129729', 1342, NULL),
  (1274, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:47.152961', 1343, NULL),
  (1275, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:47.177015', 1344, NULL),
  (1276, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:47.200694', 1345, NULL),
  (1277, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:47.225088', 1346, NULL),
  (1278, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:47.248785', 1347, NULL),
  (1279, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:47.288913', 1348, NULL),
  (1280, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:47.314828', 1349, NULL),
  (1281, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:47.340113', 1350, NULL),
  (1282, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:47.366521', 1351, NULL),
  (1283, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:47.389855', 1352, NULL),
  (1284, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:47.447860', 1353, NULL),
  (1285, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:47.476747', 1354, NULL),
  (1286, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:47.526397', 1355, NULL),
  (1287, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:47.555363', 1356, NULL),
  (1288, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:47.589922', 1357, NULL),
  (1289, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:47.613848', 1358, NULL),
  (1290, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:47.639967', 1359, NULL),
  (1291, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:47.661967', 1360, NULL),
  (1292, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:47.686115', 1361, NULL),
  (1293, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:47.711684', 1362, NULL),
  (1294, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:47.737080', 1363, NULL),
  (1295, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:47.761116', 1364, NULL),
  (1296, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:47.787315', 1365, NULL),
  (1297, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:47.810503', 1366, NULL),
  (1298, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:47.838669', 1367, NULL),
  (1299, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:47.862466', 1368, NULL),
  (1300, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:47.885616', 1369, NULL),
  (1301, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:47.914295', 1370, NULL),
  (1302, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:47.940768', 1371, NULL),
  (1303, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:47.964210', 1372, NULL),
  (1304, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:47.986904', 1373, NULL),
  (1305, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:48.029356', 1374, NULL),
  (1306, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:48.053292', 1375, NULL),
  (1307, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:48.079969', 1376, NULL),
  (1308, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:48.108319', 1377, NULL),
  (1309, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:48.132880', 1378, NULL),
  (1310, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:48.156590', 1379, NULL),
  (1311, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:48.181089', 1380, NULL),
  (1312, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:48.204046', 1381, NULL),
  (1313, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:48.226538', 1382, NULL),
  (1314, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:48.249416', 1383, NULL),
  (1315, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:48.272863', 1384, NULL),
  (1316, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:48.296017', 1385, NULL),
  (1317, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:48.319563', 1386, NULL),
  (1318, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:48.343275', 1387, NULL),
  (1319, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:48.367308', 1388, NULL),
  (1320, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:48.390560', 1389, NULL),
  (1321, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:48.413829', 1390, NULL),
  (1322, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:48.436904', 1391, NULL),
  (1323, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:48.460247', 1392, NULL),
  (1324, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:48.482760', 1393, NULL),
  (1325, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:48.506338', 1394, NULL),
  (1326, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:48.531066', 1395, NULL),
  (1327, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:48.556062', 1396, NULL),
  (1328, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:48.580272', 1397, NULL),
  (1329, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:48.603610', 1398, NULL),
  (1330, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:48.626384', 1399, NULL),
  (1331, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:48.699647', 1400, NULL),
  (1332, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:48.743853', 1401, NULL),
  (1333, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:48.773860', 1402, NULL),
  (1334, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:48.796576', 1403, NULL),
  (1335, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:48.819667', 1404, NULL),
  (1336, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:48.845208', 1405, NULL),
  (1337, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:48.868462', 1406, NULL),
  (1338, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:48.891432', 1407, NULL),
  (1339, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:48.914180', 1408, NULL),
  (1340, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:48.938254', 1409, NULL),
  (1341, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:48.991951', 1410, NULL),
  (1342, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:49.017123', 1411, NULL),
  (1343, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:49.040412', 1412, NULL),
  (1344, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:49.082192', 1413, NULL),
  (1345, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:49.105633', 1414, NULL),
  (1346, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:49.226352', 1415, NULL),
  (1347, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:49.392293', 1416, NULL),
  (1348, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:49.419540', 1417, NULL),
  (1349, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:49.442091', 1418, NULL),
  (1350, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:49.465247', 1419, NULL),
  (1351, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:49.488423', 1420, NULL),
  (1352, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:49.512011', 1421, NULL),
  (1353, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:49.537690', 1422, NULL),
  (1354, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:49.560873', 1423, NULL),
  (1355, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:49.585272', 1424, NULL),
  (1356, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:49.610259', 1425, NULL),
  (1357, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:49.641126', 1426, NULL),
  (1358, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:49.675123', 1427, NULL),
  (1359, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:49.705385', 1428, NULL),
  (1360, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:49.765113', 1429, NULL),
  (1361, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:49.788942', 1430, NULL),
  (1362, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:49.813150', 1431, NULL),
  (1363, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:49.836186', 1432, NULL),
  (1364, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:49.859070', 1433, NULL),
  (1365, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:49.883114', 1434, NULL),
  (1366, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:49.906249', 1435, NULL),
  (1367, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:49.929530', 1436, NULL),
  (1368, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:49.952406', 1437, NULL),
  (1369, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:49.975445', 1438, NULL),
  (1370, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:49.999417', 1439, NULL),
  (1371, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:50.025785', 1440, NULL),
  (1372, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:50.052639', 1441, NULL),
  (1373, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:50.079982', 1442, NULL),
  (1374, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:50.105348', 1443, NULL),
  (1375, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:50.134700', 1444, NULL),
  (1376, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:50.161425', 1445, NULL),
  (1377, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:50.187184', 1446, NULL),
  (1378, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:50.213579', 1447, NULL),
  (1379, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:50.237627', 1448, NULL),
  (1380, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:50.259606', 1449, NULL),
  (1381, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:50.282569', 1450, NULL),
  (1382, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:50.307713', 1451, NULL),
  (1383, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:50.332997', 1452, NULL),
  (1384, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:50.356024', 1453, NULL),
  (1385, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:50.410436', 1454, NULL),
  (1386, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:50.434158', 1455, NULL),
  (1387, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:50.459283', 1456, NULL),
  (1388, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:50.482960', 1457, NULL),
  (1389, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:50.507936', 1458, NULL),
  (1390, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:50.533117', 1459, NULL),
  (1391, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:50.558820', 1460, NULL),
  (1392, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:50.582870', 1461, NULL),
  (1393, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:50.606857', 1462, NULL),
  (1394, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:50.629532', 1463, NULL),
  (1395, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:50.653411', 1464, NULL),
  (1396, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:50.702372', 1465, NULL),
  (1397, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:50.734430', 1466, NULL),
  (1398, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:50.760948', 1467, NULL),
  (1399, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:50.785006', 1468, NULL),
  (1400, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:50.809341', 1469, NULL),
  (1401, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:50.834738', 1470, NULL),
  (1402, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:50.862894', 1471, NULL),
  (1403, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:50.887149', 1472, NULL),
  (1404, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:50.910896', 1473, NULL),
  (1405, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:50.935109', 1474, NULL),
  (1406, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:50.959162', 1475, NULL),
  (1407, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:50.983327', 1476, NULL),
  (1408, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:51.007389', 1477, NULL),
  (1409, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:51.034291', 1478, NULL),
  (1410, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:51.058391', 1479, NULL),
  (1411, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:51.082257', 1480, NULL),
  (1412, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:51.121381', 1481, NULL),
  (1413, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:51.144933', 1482, NULL),
  (1414, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:51.169112', 1483, NULL),
  (1415, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:51.194179', 1484, NULL),
  (1416, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:51.217998', 1485, NULL),
  (1417, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:51.240425', 1486, NULL),
  (1418, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:51.265060', 1487, NULL),
  (1419, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:51.289299', 1488, NULL),
  (1420, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:51.313768', 1489, NULL),
  (1421, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:51.337765', 1490, NULL),
  (1422, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:51.362566', 1491, NULL),
  (1423, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:51.386297', 1492, NULL),
  (1424, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:51.408633', 1493, NULL),
  (1425, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:51.431383', 1494, NULL),
  (1426, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:51.454453', 1495, NULL),
  (1427, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:51.486782', 1496, NULL),
  (1428, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:51.523922', 1497, NULL),
  (1429, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:51.552766', 1498, NULL),
  (1430, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:51.583969', 1499, NULL),
  (1431, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:51.606886', 1500, NULL),
  (1432, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:51.632166', 1501, NULL),
  (1433, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:51.656002', 1502, NULL),
  (1434, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:51.681019', 1503, NULL),
  (1435, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:51.705660', 1504, NULL),
  (1436, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:51.729212', 1505, NULL),
  (1437, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:51.757044', 1506, NULL),
  (1438, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:51.780796', 1507, NULL),
  (1439, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:51.804071', 1508, NULL)
ON CONFLICT DO NOTHING;
INSERT INTO "finance_transaction" ("id", "type", "amount", "description", "reference", "payment_method", "term", "academic_year", "date", "account_id", "recorded_by_id") VALUES
  (1440, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:51.827803', 1509, NULL),
  (1441, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:51.860417', 1510, NULL),
  (1442, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:51.883604', 1511, NULL),
  (1443, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:51.911901', 1512, NULL),
  (1444, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:51.935741', 1513, NULL),
  (1445, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:51.958722', 1514, NULL),
  (1446, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:51.982347', 1515, NULL),
  (1447, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:52.044381', 1516, NULL),
  (1448, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:52.081928', 1517, NULL),
  (1449, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:52.106056', 1518, NULL),
  (1450, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:52.133480', 1519, NULL),
  (1451, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:52.158322', 1520, NULL),
  (1452, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:52.182435', 1521, NULL),
  (1453, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:52.206148', 1522, NULL),
  (1454, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:52.244604', 1523, NULL),
  (1455, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:52.269077', 1524, NULL),
  (1456, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:52.298159', 1525, NULL),
  (1457, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:52.326358', 1526, NULL),
  (1458, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:52.371592', 1527, NULL),
  (1459, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:52.400485', 1528, NULL),
  (1460, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:52.432431', 1529, NULL),
  (1461, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:52.467746', 1530, NULL),
  (1462, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:52.499864', 1531, NULL),
  (1463, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:52.546546', 1532, NULL),
  (1464, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:52.580339', 1533, NULL),
  (1465, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:52.614331', 1534, NULL),
  (1466, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:52.673920', 1535, NULL),
  (1467, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:52.697413', 1536, NULL),
  (1468, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:52.727334', 1537, NULL),
  (1469, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:52.778415', 1538, NULL),
  (1470, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:53.128948', 1539, NULL),
  (1471, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:53.159685', 1540, NULL),
  (1472, 'INVOICE', 8000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:53.216306', 1541, NULL),
  (1473, 'INVOICE', 7500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:53.356910', 1556, NULL),
  (1474, 'INVOICE', 7500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:53.379351', 1557, NULL),
  (1475, 'INVOICE', 7500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:53.403439', 1558, NULL),
  (1476, 'INVOICE', 7500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:53.429517', 1559, NULL),
  (1477, 'INVOICE', 7500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:53.452527', 1560, NULL),
  (1478, 'INVOICE', 7500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:53.475851', 1561, NULL),
  (1479, 'INVOICE', 7500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:53.498859', 1562, NULL),
  (1480, 'INVOICE', 7500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:53.523547', 1563, NULL),
  (1481, 'INVOICE', 7500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:53.548698', 1564, NULL),
  (1482, 'INVOICE', 7500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:53.574997', 1565, NULL),
  (1483, 'INVOICE', 7500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:53.600436', 1566, NULL),
  (1484, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:53.632902', 1567, NULL),
  (1485, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:53.656481', 1568, NULL),
  (1486, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:53.686586', 1569, NULL),
  (1487, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:53.710974', 1570, NULL),
  (1488, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:53.734622', 1571, NULL),
  (1489, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:53.759106', 1572, NULL),
  (1490, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:53.782422', 1573, NULL),
  (1491, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:53.806389', 1574, NULL),
  (1492, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:53.834348', 1575, NULL),
  (1493, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:53.857666', 1576, NULL),
  (1494, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:53.880715', 1577, NULL),
  (1495, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:53.921766', 1578, NULL),
  (1496, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:53.959410', 1579, NULL),
  (1497, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:53.983964', 1580, NULL),
  (1498, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:54.009599', 1581, NULL),
  (1499, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:54.035024', 1582, NULL),
  (1500, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:54.058954', 1583, NULL),
  (1501, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:54.081658', 1584, NULL),
  (1502, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:54.104710', 1585, NULL),
  (1503, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:54.127421', 1586, NULL),
  (1504, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:54.151924', 1587, NULL),
  (1505, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:54.175307', 1588, NULL),
  (1506, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:54.199017', 1589, NULL),
  (1507, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:54.221308', 1590, NULL),
  (1508, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:54.245212', 1591, NULL),
  (1509, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:54.268594', 1592, NULL),
  (1510, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:54.292540', 1593, NULL),
  (1511, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:54.316290', 1594, NULL),
  (1512, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:54.339125', 1595, NULL),
  (1513, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:54.392300', 1596, NULL),
  (1514, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:54.426841', 1597, NULL),
  (1515, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:54.484022', 1598, NULL),
  (1516, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:54.507958', 1599, NULL),
  (1517, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:54.535019', 1600, NULL),
  (1518, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:54.563329', 1601, NULL),
  (1519, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:54.590125', 1602, NULL),
  (1520, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:54.613611', 1603, NULL),
  (1521, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:54.641332', 1604, NULL),
  (1522, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:54.665177', 1605, NULL),
  (1523, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:54.690099', 1606, NULL),
  (1524, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:54.843145', 1607, NULL),
  (1525, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:55.011851', 1608, NULL),
  (1526, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:55.076584', 1609, NULL),
  (1527, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:55.122511', 1610, NULL),
  (1528, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:55.225980', 1611, NULL),
  (1529, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:55.331608', 1612, NULL),
  (1530, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:55.363798', 1613, NULL),
  (1531, 'INVOICE', 6500, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:55.391908', 1614, NULL),
  (1532, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:55.423777', 1615, NULL),
  (1533, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:55.481898', 1616, NULL),
  (1534, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:55.511089', 1617, NULL),
  (1535, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:55.539678', 1618, NULL),
  (1536, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:55.565055', 1619, NULL),
  (1537, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:55.593500', 1620, NULL),
  (1538, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:55.624476', 1621, NULL),
  (1539, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:55.651816', 1622, NULL),
  (1540, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:55.676267', 1623, NULL),
  (1541, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:55.703895', 1624, NULL),
  (1542, 'INVOICE', 1000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:55.730911', 1625, NULL),
  (1543, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:55.757380', 1626, NULL),
  (1544, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:55.782961', 1627, NULL),
  (1545, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:55.809061', 1628, NULL),
  (1546, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:55.836626', 1629, NULL),
  (1547, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:55.862056', 1630, NULL),
  (1548, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:55.888534', 1631, NULL),
  (1549, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:55.912626', 1632, NULL),
  (1550, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:55.938124', 1633, NULL),
  (1551, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:55.961431', 1634, NULL),
  (1552, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:55.986403', 1635, NULL),
  (1553, 'INVOICE', 5000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:56.010547', 1636, NULL),
  (1554, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:56.067954', 1637, NULL),
  (1555, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:56.092681', 1638, NULL),
  (1556, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:56.130827', 1639, NULL),
  (1557, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:56.156896', 1640, NULL),
  (1558, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:56.184676', 1641, NULL),
  (1559, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:56.210525', 1642, NULL),
  (1560, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:56.236167', 1643, NULL),
  (1561, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:56.293432', 1644, NULL),
  (1562, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:56.321062', 1645, NULL),
  (1563, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:56.347658', 1646, NULL),
  (1564, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:56.373739', 1647, NULL),
  (1565, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:56.399529', 1648, NULL),
  (1566, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:56.430685', 1649, NULL),
  (1567, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:56.459781', 1650, NULL),
  (1568, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:56.488551', 1651, NULL),
  (1569, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:56.513847', 1652, NULL),
  (1570, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:56.540858', 1653, NULL),
  (1571, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:56.565234', 1654, NULL),
  (1572, 'INVOICE', 7000, 'Tuition Fees - Term 1 2026', NULL, 'SYSTEM', 1, '2026', '2026-01-24 11:45:56.611539', 1655, NULL),
  (1573, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:51.204461', 1281, NULL),
  (1574, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:51.225833', 1282, NULL),
  (1575, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:51.246525', 1283, NULL),
  (1576, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:51.265141', 1284, NULL),
  (1577, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:51.284845', 1285, NULL),
  (1578, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:51.304587', 1286, NULL),
  (1579, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:51.324685', 1287, NULL),
  (1580, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:51.347212', 1288, NULL),
  (1581, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:51.374524', 1289, NULL),
  (1582, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:51.398834', 1290, NULL),
  (1583, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:51.418916', 1291, NULL),
  (1584, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:51.437495', 1292, NULL),
  (1585, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:51.456637', 1293, NULL),
  (1586, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:51.484468', 1294, NULL),
  (1587, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:51.502293', 1295, NULL),
  (1588, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:51.521916', 1296, NULL),
  (1589, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:51.540480', 1297, NULL),
  (1590, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:51.579038', 1298, NULL),
  (1591, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:51.603051', 1299, NULL),
  (1592, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:51.634143', 1300, NULL),
  (1593, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:51.652638', 1301, NULL),
  (1594, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:51.685416', 1302, NULL),
  (1595, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:51.708583', 1303, NULL),
  (1596, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:51.729082', 1304, NULL),
  (1597, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:51.747282', 1305, NULL),
  (1598, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:51.766130', 1306, NULL),
  (1599, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:51.788286', 1307, NULL),
  (1600, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:51.880579', 1308, NULL),
  (1601, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:51.911278', 1309, NULL),
  (1602, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:51.933043', 1310, NULL),
  (1603, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:51.952697', 1311, NULL),
  (1604, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:51.971173', 1312, NULL),
  (1605, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:51.997445', 1313, NULL),
  (1606, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:52.021698', 1314, NULL),
  (1607, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:52.052521', 1315, NULL),
  (1608, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:52.071904', 1316, NULL),
  (1609, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:52.094158', 1317, NULL),
  (1610, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:52.122717', 1318, NULL),
  (1611, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:52.158074', 1319, NULL),
  (1612, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:52.178947', 1320, NULL),
  (1613, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:52.199481', 1321, NULL),
  (1614, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:52.219833', 1322, NULL),
  (1615, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:52.240790', 1323, NULL),
  (1616, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:52.261960', 1324, NULL),
  (1617, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:52.282629', 1325, NULL),
  (1618, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:52.310086', 1326, NULL),
  (1619, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:52.335458', 1327, NULL),
  (1620, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:52.363158', 1328, NULL),
  (1621, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:52.384052', 1329, NULL),
  (1622, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:52.403413', 1330, NULL),
  (1623, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:52.426345', 1331, NULL),
  (1624, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:52.444573', 1332, NULL),
  (1625, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:52.463835', 1333, NULL),
  (1626, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:52.487220', 1334, NULL),
  (1627, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:52.506584', 1335, NULL),
  (1628, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:52.525656', 1336, NULL),
  (1629, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:52.549159', 1337, NULL),
  (1630, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:52.570531', 1338, NULL),
  (1631, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:52.590022', 1339, NULL),
  (1632, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:52.614147', 1340, NULL),
  (1633, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:52.649151', 1341, NULL),
  (1634, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:52.669719', 1626, NULL),
  (1635, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:52.689630', 1627, NULL),
  (1636, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:52.707655', 1628, NULL),
  (1637, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:52.728845', 1629, NULL),
  (1638, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:52.775739', 1630, NULL),
  (1639, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:52.794615', 1631, NULL)
ON CONFLICT DO NOTHING;
INSERT INTO "finance_transaction" ("id", "type", "amount", "description", "reference", "payment_method", "term", "academic_year", "date", "account_id", "recorded_by_id") VALUES
  (1640, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:52.816139', 1632, NULL),
  (1641, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:52.835450', 1633, NULL),
  (1642, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:52.859223', 1634, NULL),
  (1643, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:52.885274', 1635, NULL),
  (1644, 'INVOICE', 5000, 'Term 1 2024 Fees (Updated)', NULL, 'SYSTEM', 1, '2024', '2026-01-24 17:49:52.904548', 1636, NULL),
  (1645, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:53.893912', 1281, NULL),
  (1646, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:53.917269', 1282, NULL),
  (1647, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:53.938742', 1283, NULL),
  (1648, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:53.964270', 1284, NULL),
  (1649, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:54.051727', 1285, NULL),
  (1650, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:54.071722', 1286, NULL),
  (1651, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:54.093760', 1287, NULL),
  (1652, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:54.113700', 1288, NULL),
  (1653, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:54.155167', 1289, NULL),
  (1654, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:54.174843', 1290, NULL),
  (1655, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:54.193565', 1291, NULL),
  (1656, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:54.213516', 1292, NULL),
  (1657, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:54.231776', 1293, NULL),
  (1658, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:54.251684', 1294, NULL),
  (1659, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:54.273004', 1295, NULL),
  (1660, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:54.300306', 1296, NULL),
  (1661, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:54.320814', 1297, NULL),
  (1662, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:54.341920', 1298, NULL),
  (1663, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:54.362107', 1299, NULL),
  (1664, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:54.400275', 1300, NULL),
  (1665, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:54.421515', 1301, NULL),
  (1666, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:54.446859', 1302, NULL),
  (1667, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:54.659691', 1303, NULL),
  (1668, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:54.683947', 1304, NULL),
  (1669, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:54.704876', 1305, NULL),
  (1670, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:54.724843', 1306, NULL),
  (1671, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:54.743908', 1307, NULL),
  (1672, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:54.769172', 1308, NULL),
  (1673, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:54.794208', 1309, NULL),
  (1674, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:54.877362', 1310, NULL),
  (1675, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:54.909590', 1311, NULL),
  (1676, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:54.930084', 1312, NULL),
  (1677, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:54.950058', 1313, NULL),
  (1678, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:54.969671', 1314, NULL),
  (1679, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:54.988491', 1315, NULL),
  (1680, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:55.121721', 1316, NULL),
  (1681, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:55.159965', 1317, NULL),
  (1682, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:55.183098', 1318, NULL),
  (1683, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:55.246990', 1319, NULL),
  (1684, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:55.340209', 1320, NULL),
  (1685, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:55.376294', 1321, NULL),
  (1686, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:55.410734', 1322, NULL),
  (1687, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:55.432901', 1323, NULL),
  (1688, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:55.454857', 1324, NULL),
  (1689, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:55.478021', 1325, NULL),
  (1690, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:55.524738', 1326, NULL),
  (1691, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:55.584873', 1327, NULL),
  (1692, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:55.674584', 1328, NULL),
  (1693, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:55.707892', 1329, NULL),
  (1694, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:55.753966', 1330, NULL),
  (1695, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:55.791290', 1331, NULL),
  (1696, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:55.911317', 1332, NULL),
  (1697, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:55.939055', 1333, NULL),
  (1698, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:56.003019', 1334, NULL),
  (1699, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:56.093445', 1335, NULL),
  (1700, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:56.121282', 1336, NULL),
  (1701, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:56.158191', 1337, NULL),
  (1702, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:56.225796', 1338, NULL),
  (1703, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:56.243661', 1339, NULL),
  (1704, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:56.261542', 1340, NULL),
  (1705, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:56.418640', 1341, NULL),
  (1706, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:56.441850', 1626, NULL),
  (1707, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:56.461589', 1627, NULL),
  (1708, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:56.489690', 1628, NULL),
  (1709, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:56.571359', 1629, NULL),
  (1710, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:56.592296', 1630, NULL),
  (1711, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:56.687478', 1631, NULL),
  (1712, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:56.706273', 1632, NULL),
  (1713, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:56.770084', 1633, NULL),
  (1714, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:57.019828', 1634, NULL),
  (1715, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:57.050505', 1635, NULL),
  (1716, 'INVOICE', 3000, 'Term 2 2024 Fees (Updated)', NULL, 'SYSTEM', 2, '2024', '2026-01-24 17:49:57.113536', 1636, NULL),
  (1717, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:03.725401', 1281, NULL),
  (1718, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:03.748258', 1282, NULL),
  (1719, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:03.811079', 1283, NULL),
  (1720, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:03.859173', 1284, NULL),
  (1721, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:03.888623', 1285, NULL),
  (1722, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:03.968664', 1286, NULL),
  (1723, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:03.989705', 1287, NULL),
  (1724, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:04.020323', 1288, NULL),
  (1725, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:04.039587', 1289, NULL),
  (1726, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:04.059076', 1290, NULL),
  (1727, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:04.077245', 1291, NULL),
  (1728, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:04.109935', 1292, NULL),
  (1729, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:04.140743', 1293, NULL),
  (1730, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:04.237234', 1294, NULL),
  (1731, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:04.925228', 1295, NULL),
  (1732, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:05.344476', 1296, NULL),
  (1733, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:05.408739', 1297, NULL),
  (1734, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:05.473077', 1298, NULL),
  (1735, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:05.586376', 1299, NULL),
  (1736, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:05.618057', 1300, NULL),
  (1737, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:05.669414', 1301, NULL),
  (1738, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:09.150817', 1302, NULL),
  (1739, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:09.330056', 1303, NULL),
  (1740, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:09.475969', 1304, NULL),
  (1741, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:09.496058', 1305, NULL),
  (1742, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:11.955794', 1306, NULL),
  (1743, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:13.303782', 1307, NULL),
  (1744, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:13.396734', 1308, NULL),
  (1745, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:13.494761', 1309, NULL),
  (1746, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:16.795404', 1310, NULL),
  (1747, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:19.270140', 1311, NULL),
  (1748, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:19.837674', 1312, NULL),
  (1749, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:19.860648', 1313, NULL),
  (1750, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:20.043766', 1314, NULL),
  (1751, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:20.185621', 1315, NULL),
  (1752, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:21.165177', 1316, NULL),
  (1753, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:21.312644', 1317, NULL),
  (1754, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:21.716598', 1318, NULL),
  (1755, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:21.763294', 1319, NULL),
  (1756, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:21.960841', 1320, NULL),
  (1757, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:22.090873', 1321, NULL),
  (1758, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:22.679173', 1322, NULL),
  (1759, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:22.729449', 1323, NULL),
  (1760, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:22.754920', 1324, NULL),
  (1761, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:22.787289', 1325, NULL),
  (1762, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:22.811153', 1326, NULL),
  (1763, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:22.912450', 1327, NULL),
  (1764, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:23.044823', 1328, NULL),
  (1765, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:23.210284', 1329, NULL),
  (1766, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:23.238438', 1330, NULL),
  (1767, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:23.264492', 1331, NULL),
  (1768, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:23.300103', 1332, NULL),
  (1769, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:23.322516', 1333, NULL),
  (1770, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:23.520810', 1334, NULL),
  (1771, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:23.558003', 1335, NULL),
  (1772, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:23.645198', 1336, NULL),
  (1773, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:23.744704', 1337, NULL),
  (1774, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:23.932620', 1338, NULL),
  (1775, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:24.105452', 1339, NULL),
  (1776, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:24.370046', 1340, NULL),
  (1777, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:24.394304', 1341, NULL),
  (1778, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:24.434563', 1626, NULL),
  (1779, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:24.502594', 1627, NULL),
  (1780, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:24.526517', 1628, NULL),
  (1781, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:24.549806', 1629, NULL),
  (1782, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:24.674598', 1630, NULL),
  (1783, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:24.764478', 1631, NULL),
  (1784, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:24.880360', 1632, NULL),
  (1785, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:24.983167', 1633, NULL),
  (1786, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:25.075506', 1634, NULL),
  (1787, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:25.428233', 1635, NULL),
  (1788, 'INVOICE', 2599, 'Term 3 2024 Fees (Updated)', NULL, 'SYSTEM', 3, '2024', '2026-01-24 17:50:25.481214', 1636, NULL)
ON CONFLICT DO NOTHING;

-- finance_salarystructure (26 rows)
INSERT INTO "finance_salarystructure" ("id", "base_salary", "allowances", "deductions", "updated_at", "user_id", "loans", "nssf") VALUES
  (1, 25000, 0, 0, '2026-01-13 12:51:07.827597', 241, 0, 0),
  (2, 20000, 0, 2000, '2026-01-20 21:18:20.244089', 1328, 500, 500),
  (3, 30000, 0, 5600, '2026-01-21 22:29:43.887105', 1329, 2000, 0),
  (4, 0, 0, 0, '2026-01-20 21:17:03.153906', 1330, 0, 0),
  (5, 0, 0, 0, '2026-01-20 21:17:03.173176', 1331, 0, 0),
  (6, 35000, 0, 0, '2026-01-20 21:17:36.789206', 1332, 0, 0),
  (7, 25000, 2500, 7500, '2026-01-21 20:58:13.263335', 1333, 0, 0),
  (8, 0, 0, 0, '2026-01-20 21:17:03.221826', 1334, 0, 0),
  (9, 0, 0, 0, '2026-01-20 21:17:03.243995', 1335, 0, 0),
  (10, 0, 0, 0, '2026-01-20 21:17:03.259697', 1336, 0, 0),
  (11, 0, 0, 0, '2026-01-20 21:17:03.277733', 1337, 0, 0),
  (12, 0, 0, 0, '2026-01-20 21:17:03.294895', 1338, 0, 0),
  (13, 0, 0, 0, '2026-01-20 21:17:03.320685', 1327, 0, 0),
  (14, 0, 0, 0, '2026-01-20 21:17:03.337029', 1339, 0, 0),
  (15, 0, 0, 0, '2026-01-24 11:48:36.742268', 1, 0, 0),
  (16, 0, 0, 0, '2026-01-24 11:48:36.781980', 18, 0, 0),
  (17, 0, 0, 0, '2026-01-24 11:48:36.807353', 25, 0, 0),
  (18, 0, 0, 0, '2026-01-24 11:48:36.829370', 26, 0, 0),
  (19, 0, 0, 0, '2026-01-24 11:48:36.856133', 225, 0, 0),
  (20, 0, 0, 0, '2026-01-24 11:48:36.878779', 226, 0, 0),
  (21, 0, 0, 0, '2026-01-24 11:48:36.904277', 240, 0, 0),
  (22, 0, 0, 0, '2026-01-24 11:48:37.118729', 1342, 0, 0),
  (23, 0, 0, 0, '2026-01-24 11:48:37.146193', 1343, 0, 0),
  (24, 0, 0, 0, '2026-01-24 11:48:37.171570', 1344, 0, 0),
  (25, 0, 0, 0, '2026-01-24 11:48:37.195340', 1345, 0, 0),
  (26, 0, 0, 0, '2026-01-24 11:48:37.214970', 1346, 0, 0)
ON CONFLICT DO NOTHING;

-- food_mealitem (7 rows)
INSERT INTO "food_mealitem" ("id", "name", "description", "cost", "billing_cycle", "active", "created_at", "per_serving_cost") VALUES
  (1, 'Termly Lunch', 'Full lunch for the whole term', 15000, 'TERMLY', FALSE, '2026-01-13 00:33:22.433804', 0),
  (2, 'Daily Tea Break', 'Morning tea and snack', 50, 'DAILY', TRUE, '2026-01-13 00:33:22.445273', 0),
  (3, 'Termly Fruits', 'Fruit serving daily for the term', 3000, 'TERMLY', TRUE, '2026-01-13 00:33:22.458448', 0),
  (4, 'Monthly Special Diet', 'Special diet accommodations', 6000, 'MONTHLY', TRUE, '2026-01-13 00:33:22.473251', 0),
  (5, 'Tea', '', 20, 'ONE_OFF', TRUE, '2026-01-13 00:47:32.054056', 0),
  (6, 'Tea', '', 20, 'ONE_OFF', FALSE, '2026-01-13 00:47:56.778757', 0),
  (7, 'Tea', '', 20, 'ONE_OFF', FALSE, '2026-01-13 00:49:08.551387', 0)
ON CONFLICT DO NOTHING;

-- food_foodstudentaccount (2 rows)
INSERT INTO "food_foodstudentaccount" ("id", "balance", "active", "total_billed", "total_paid", "updated_at", "student_id") VALUES
  (9, 0, TRUE, 0, 0, '2026-01-14 06:25:23.086779', 818),
  (10, -5000, TRUE, 0, 5000, '2026-01-22 07:48:26.341034', 798)
ON CONFLICT DO NOTHING;

-- transport_route (5 rows)
INSERT INTO "transport_route" ("id", "name", "description", "cost_per_term", "cost_per_month", "pickup_points", "active", "created_at", "map_embed_code") VALUES
  (1, 'Route A - CBD', 'Covers Central Business District and surrounding areas', 15000, 5500, 'Kencom, Railways, GPO, Nation Centre, Hilton', FALSE, '2026-01-13 01:34:58.055731', '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d4103.408903701481!2d37.10383577509383!3d-1.059059498930755!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x182f4f792ce44fcd%3A0xc9ef65bdca51508f!2sBishop%20Dr.%20Mando%20International%20School!5e1!3m2!1sen!2ske!4v1768297292204!5m2!1sen!2ske" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>'),
  (2, 'Route B - Westlands', 'Westlands, Parklands, and Highridge areas', 18000, 6500, 'Sarit Centre, ABC Place, Westgate Mall, Parklands Mosque', FALSE, '2026-01-13 01:34:58.068099', NULL),
  (3, 'Route C - Eastlands', 'Eastlands estates including Umoja, Donholm, Buruburu', 12000, 4500, 'Buruburu Phase 5, Umoja 1, Donholm Phase 8, Makadara', FALSE, '2026-01-13 01:34:58.079780', NULL),
  (4, 'Route D - South B/C', 'South B, South C, Langata Road areas', 16000, 6000, 'South C Shopping Centre, Bellevue, Mugoya, Nairobi West', FALSE, '2026-01-13 01:34:58.089883', NULL),
  (5, 'Route E - Ngong Road', 'Ngong Road, Dagoretti, Karen areas', 20000, 7500, 'Adams Arcade, Prestige Plaza, Karen Shopping Centre, Junction Mall', FALSE, '2026-01-13 01:34:58.102145', NULL)
ON CONFLICT DO NOTHING;

-- transport_transportdriver (1 rows)
INSERT INTO "transport_transportdriver" ("id", "first_name", "last_name", "license_number", "status", "joined_at", "vehicle_id", "user_id", "phone_number") VALUES
  (1, 'Saidah', 'Hamisi', 'T68DJ34', 'ACTIVE', '2026-01-13', NULL, 241, '0749738248')
ON CONFLICT DO NOTHING;

-- transport_transportstudentaccount (1 rows)
INSERT INTO "transport_transportstudentaccount" ("id", "balance", "active", "total_billed", "total_paid", "updated_at", "student_id") VALUES
  (5, -2000, TRUE, 0, 2000, '2026-01-22 07:30:34.719584', 798)
ON CONFLICT DO NOTHING;

-- ============================================================
-- SECTION 3: ADD FOREIGN KEY CONSTRAINTS
-- ============================================================

-- FKs for: auth_permission
DO $$ BEGIN
  DELETE FROM "auth_permission" WHERE "content_type_id" IS NOT NULL AND "content_type_id" NOT IN (SELECT "id" FROM "django_content_type");
  ALTER TABLE "auth_permission" ADD CONSTRAINT "fk_auth_permission_0" FOREIGN KEY ("content_type_id") REFERENCES "django_content_type" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: auth_group_permissions
DO $$ BEGIN
  DELETE FROM "auth_group_permissions" WHERE "permission_id" IS NOT NULL AND "permission_id" NOT IN (SELECT "id" FROM "auth_permission");
  ALTER TABLE "auth_group_permissions" ADD CONSTRAINT "fk_auth_group_permissions_0" FOREIGN KEY ("permission_id") REFERENCES "auth_permission" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "auth_group_permissions" WHERE "group_id" IS NOT NULL AND "group_id" NOT IN (SELECT "id" FROM "auth_group");
  ALTER TABLE "auth_group_permissions" ADD CONSTRAINT "fk_auth_group_permissions_1" FOREIGN KEY ("group_id") REFERENCES "auth_group" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: auth_user_groups
DO $$ BEGIN
  DELETE FROM "auth_user_groups" WHERE "group_id" IS NOT NULL AND "group_id" NOT IN (SELECT "id" FROM "auth_group");
  ALTER TABLE "auth_user_groups" ADD CONSTRAINT "fk_auth_user_groups_0" FOREIGN KEY ("group_id") REFERENCES "auth_group" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "auth_user_groups" WHERE "user_id" IS NOT NULL AND "user_id" NOT IN (SELECT "id" FROM "auth_user");
  ALTER TABLE "auth_user_groups" ADD CONSTRAINT "fk_auth_user_groups_1" FOREIGN KEY ("user_id") REFERENCES "auth_user" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: auth_user_user_permissions
DO $$ BEGIN
  DELETE FROM "auth_user_user_permissions" WHERE "permission_id" IS NOT NULL AND "permission_id" NOT IN (SELECT "id" FROM "auth_permission");
  ALTER TABLE "auth_user_user_permissions" ADD CONSTRAINT "fk_auth_user_user_permissions_0" FOREIGN KEY ("permission_id") REFERENCES "auth_permission" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "auth_user_user_permissions" WHERE "user_id" IS NOT NULL AND "user_id" NOT IN (SELECT "id" FROM "auth_user");
  ALTER TABLE "auth_user_user_permissions" ADD CONSTRAINT "fk_auth_user_user_permissions_1" FOREIGN KEY ("user_id") REFERENCES "auth_user" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: django_admin_log
DO $$ BEGIN
  DELETE FROM "django_admin_log" WHERE "user_id" IS NOT NULL AND "user_id" NOT IN (SELECT "id" FROM "auth_user");
  ALTER TABLE "django_admin_log" ADD CONSTRAINT "fk_django_admin_log_0" FOREIGN KEY ("user_id") REFERENCES "auth_user" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "django_admin_log" WHERE "content_type_id" IS NOT NULL AND "content_type_id" NOT IN (SELECT "id" FROM "django_content_type");
  ALTER TABLE "django_admin_log" ADD CONSTRAINT "fk_django_admin_log_1" FOREIGN KEY ("content_type_id") REFERENCES "django_content_type" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: schools_department
DO $$ BEGIN
  DELETE FROM "schools_department" WHERE "branch_id" IS NOT NULL AND "branch_id" NOT IN (SELECT "id" FROM "schools_branch");
  ALTER TABLE "schools_department" ADD CONSTRAINT "fk_schools_department_0" FOREIGN KEY ("branch_id") REFERENCES "schools_branch" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "schools_department" WHERE "head_id" IS NOT NULL AND "head_id" NOT IN (SELECT "id" FROM "schools_employee");
  ALTER TABLE "schools_department" ADD CONSTRAINT "fk_schools_department_1" FOREIGN KEY ("head_id") REFERENCES "schools_employee" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: schools_employee
DO $$ BEGIN
  DELETE FROM "schools_employee" WHERE "branch_id" IS NOT NULL AND "branch_id" NOT IN (SELECT "id" FROM "schools_branch");
  ALTER TABLE "schools_employee" ADD CONSTRAINT "fk_schools_employee_0" FOREIGN KEY ("branch_id") REFERENCES "schools_branch" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "schools_employee" WHERE "department_id" IS NOT NULL AND "department_id" NOT IN (SELECT "id" FROM "schools_department");
  ALTER TABLE "schools_employee" ADD CONSTRAINT "fk_schools_employee_1" FOREIGN KEY ("department_id") REFERENCES "schools_department" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: schools_grade
DO $$ BEGIN
  DELETE FROM "schools_grade" WHERE "class_teacher_id" IS NOT NULL AND "class_teacher_id" NOT IN (SELECT "employee_ptr_id" FROM "schools_teacher");
  ALTER TABLE "schools_grade" ADD CONSTRAINT "fk_schools_grade_0" FOREIGN KEY ("class_teacher_id") REFERENCES "schools_teacher" ("employee_ptr_id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: schools_teacher
DO $$ BEGIN
  DELETE FROM "schools_teacher" WHERE "user_id" IS NOT NULL AND "user_id" NOT IN (SELECT "id" FROM "auth_user");
  ALTER TABLE "schools_teacher" ADD CONSTRAINT "fk_schools_teacher_0" FOREIGN KEY ("user_id") REFERENCES "auth_user" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "schools_teacher" WHERE "grade_id" IS NOT NULL AND "grade_id" NOT IN (SELECT "id" FROM "schools_grade");
  ALTER TABLE "schools_teacher" ADD CONSTRAINT "fk_schools_teacher_1" FOREIGN KEY ("grade_id") REFERENCES "schools_grade" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "schools_teacher" WHERE "employee_ptr_id" IS NOT NULL AND "employee_ptr_id" NOT IN (SELECT "id" FROM "schools_employee");
  ALTER TABLE "schools_teacher" ADD CONSTRAINT "fk_schools_teacher_2" FOREIGN KEY ("employee_ptr_id") REFERENCES "schools_employee" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: schools_teacher_subjects
DO $$ BEGIN
  DELETE FROM "schools_teacher_subjects" WHERE "subject_id" IS NOT NULL AND "subject_id" NOT IN (SELECT "id" FROM "schools_subject");
  ALTER TABLE "schools_teacher_subjects" ADD CONSTRAINT "fk_schools_teacher_subjects_0" FOREIGN KEY ("subject_id") REFERENCES "schools_subject" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "schools_teacher_subjects" WHERE "teacher_id" IS NOT NULL AND "teacher_id" NOT IN (SELECT "employee_ptr_id" FROM "schools_teacher");
  ALTER TABLE "schools_teacher_subjects" ADD CONSTRAINT "fk_schools_teacher_subjects_1" FOREIGN KEY ("teacher_id") REFERENCES "schools_teacher" ("employee_ptr_id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: schools_nonteachingstaff
DO $$ BEGIN
  DELETE FROM "schools_nonteachingstaff" WHERE "user_id" IS NOT NULL AND "user_id" NOT IN (SELECT "id" FROM "auth_user");
  ALTER TABLE "schools_nonteachingstaff" ADD CONSTRAINT "fk_schools_nonteachingstaff_0" FOREIGN KEY ("user_id") REFERENCES "auth_user" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "schools_nonteachingstaff" WHERE "supervisor_id" IS NOT NULL AND "supervisor_id" NOT IN (SELECT "id" FROM "schools_employee");
  ALTER TABLE "schools_nonteachingstaff" ADD CONSTRAINT "fk_schools_nonteachingstaff_1" FOREIGN KEY ("supervisor_id") REFERENCES "schools_employee" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "schools_nonteachingstaff" WHERE "employee_ptr_id" IS NOT NULL AND "employee_ptr_id" NOT IN (SELECT "id" FROM "schools_employee");
  ALTER TABLE "schools_nonteachingstaff" ADD CONSTRAINT "fk_schools_nonteachingstaff_2" FOREIGN KEY ("employee_ptr_id") REFERENCES "schools_employee" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: schools_salary
DO $$ BEGIN
  DELETE FROM "schools_salary" WHERE "employee_id" IS NOT NULL AND "employee_id" NOT IN (SELECT "id" FROM "schools_employee");
  ALTER TABLE "schools_salary" ADD CONSTRAINT "fk_schools_salary_0" FOREIGN KEY ("employee_id") REFERENCES "schools_employee" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: schools_allowance
DO $$ BEGIN
  DELETE FROM "schools_allowance" WHERE "salary_id" IS NOT NULL AND "salary_id" NOT IN (SELECT "id" FROM "schools_salary");
  ALTER TABLE "schools_allowance" ADD CONSTRAINT "fk_schools_allowance_0" FOREIGN KEY ("salary_id") REFERENCES "schools_salary" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: schools_deduction
DO $$ BEGIN
  DELETE FROM "schools_deduction" WHERE "salary_id" IS NOT NULL AND "salary_id" NOT IN (SELECT "id" FROM "schools_salary");
  ALTER TABLE "schools_deduction" ADD CONSTRAINT "fk_schools_deduction_0" FOREIGN KEY ("salary_id") REFERENCES "schools_salary" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: schools_salaryadvance
DO $$ BEGIN
  DELETE FROM "schools_salaryadvance" WHERE "employee_id" IS NOT NULL AND "employee_id" NOT IN (SELECT "id" FROM "schools_employee");
  ALTER TABLE "schools_salaryadvance" ADD CONSTRAINT "fk_schools_salaryadvance_0" FOREIGN KEY ("employee_id") REFERENCES "schools_employee" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "schools_salaryadvance" WHERE "approved_by_id" IS NOT NULL AND "approved_by_id" NOT IN (SELECT "id" FROM "auth_user");
  ALTER TABLE "schools_salaryadvance" ADD CONSTRAINT "fk_schools_salaryadvance_1" FOREIGN KEY ("approved_by_id") REFERENCES "auth_user" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: schools_advanceapproval
DO $$ BEGIN
  DELETE FROM "schools_advanceapproval" WHERE "approver_id" IS NOT NULL AND "approver_id" NOT IN (SELECT "id" FROM "auth_user");
  ALTER TABLE "schools_advanceapproval" ADD CONSTRAINT "fk_schools_advanceapproval_0" FOREIGN KEY ("approver_id") REFERENCES "auth_user" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "schools_advanceapproval" WHERE "advance_id" IS NOT NULL AND "advance_id" NOT IN (SELECT "id" FROM "schools_salaryadvance");
  ALTER TABLE "schools_advanceapproval" ADD CONSTRAINT "fk_schools_advanceapproval_1" FOREIGN KEY ("advance_id") REFERENCES "schools_salaryadvance" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: schools_leave
DO $$ BEGIN
  DELETE FROM "schools_leave" WHERE "employee_id" IS NOT NULL AND "employee_id" NOT IN (SELECT "id" FROM "schools_employee");
  ALTER TABLE "schools_leave" ADD CONSTRAINT "fk_schools_leave_0" FOREIGN KEY ("employee_id") REFERENCES "schools_employee" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "schools_leave" WHERE "approved_by_id" IS NOT NULL AND "approved_by_id" NOT IN (SELECT "id" FROM "auth_user");
  ALTER TABLE "schools_leave" ADD CONSTRAINT "fk_schools_leave_1" FOREIGN KEY ("approved_by_id") REFERENCES "auth_user" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: schools_leaveapproval
DO $$ BEGIN
  DELETE FROM "schools_leaveapproval" WHERE "leave_id" IS NOT NULL AND "leave_id" NOT IN (SELECT "id" FROM "schools_leave");
  ALTER TABLE "schools_leaveapproval" ADD CONSTRAINT "fk_schools_leaveapproval_0" FOREIGN KEY ("leave_id") REFERENCES "schools_leave" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "schools_leaveapproval" WHERE "approver_id" IS NOT NULL AND "approver_id" NOT IN (SELECT "id" FROM "auth_user");
  ALTER TABLE "schools_leaveapproval" ADD CONSTRAINT "fk_schools_leaveapproval_1" FOREIGN KEY ("approver_id") REFERENCES "auth_user" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: schools_staffdocument
DO $$ BEGIN
  DELETE FROM "schools_staffdocument" WHERE "uploaded_by_id" IS NOT NULL AND "uploaded_by_id" NOT IN (SELECT "id" FROM "auth_user");
  ALTER TABLE "schools_staffdocument" ADD CONSTRAINT "fk_schools_staffdocument_0" FOREIGN KEY ("uploaded_by_id") REFERENCES "auth_user" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "schools_staffdocument" WHERE "employee_id" IS NOT NULL AND "employee_id" NOT IN (SELECT "id" FROM "schools_employee");
  ALTER TABLE "schools_staffdocument" ADD CONSTRAINT "fk_schools_staffdocument_1" FOREIGN KEY ("employee_id") REFERENCES "schools_employee" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: schools_vehicle
DO $$ BEGIN
  DELETE FROM "schools_vehicle" WHERE "driver_id" IS NOT NULL AND "driver_id" NOT IN (SELECT "id" FROM "schools_employee");
  ALTER TABLE "schools_vehicle" ADD CONSTRAINT "fk_schools_vehicle_0" FOREIGN KEY ("driver_id") REFERENCES "schools_employee" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: schools_student
DO $$ BEGIN
  DELETE FROM "schools_student" WHERE "branch_id" IS NOT NULL AND "branch_id" NOT IN (SELECT "id" FROM "schools_branch");
  ALTER TABLE "schools_student" ADD CONSTRAINT "fk_schools_student_0" FOREIGN KEY ("branch_id") REFERENCES "schools_branch" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "schools_student" WHERE "user_id" IS NOT NULL AND "user_id" NOT IN (SELECT "id" FROM "auth_user");
  ALTER TABLE "schools_student" ADD CONSTRAINT "fk_schools_student_1" FOREIGN KEY ("user_id") REFERENCES "auth_user" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "schools_student" WHERE "previous_grade_id" IS NOT NULL AND "previous_grade_id" NOT IN (SELECT "id" FROM "schools_grade");
  ALTER TABLE "schools_student" ADD CONSTRAINT "fk_schools_student_2" FOREIGN KEY ("previous_grade_id") REFERENCES "schools_grade" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "schools_student" WHERE "grade_id" IS NOT NULL AND "grade_id" NOT IN (SELECT "id" FROM "schools_grade");
  ALTER TABLE "schools_student" ADD CONSTRAINT "fk_schools_student_3" FOREIGN KEY ("grade_id") REFERENCES "schools_grade" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: schools_payment
DO $$ BEGIN
  DELETE FROM "schools_payment" WHERE "student_id" IS NOT NULL AND "student_id" NOT IN (SELECT "id" FROM "schools_student");
  ALTER TABLE "schools_payment" ADD CONSTRAINT "fk_schools_payment_0" FOREIGN KEY ("student_id") REFERENCES "schools_student" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: schools_attendance
DO $$ BEGIN
  DELETE FROM "schools_attendance" WHERE "student_id" IS NOT NULL AND "student_id" NOT IN (SELECT "id" FROM "schools_student");
  ALTER TABLE "schools_attendance" ADD CONSTRAINT "fk_schools_attendance_0" FOREIGN KEY ("student_id") REFERENCES "schools_student" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "schools_attendance" WHERE "recorded_by_id" IS NOT NULL AND "recorded_by_id" NOT IN (SELECT "id" FROM "auth_user");
  ALTER TABLE "schools_attendance" ADD CONSTRAINT "fk_schools_attendance_1" FOREIGN KEY ("recorded_by_id") REFERENCES "auth_user" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: schools_assessment
DO $$ BEGIN
  DELETE FROM "schools_assessment" WHERE "student_id" IS NOT NULL AND "student_id" NOT IN (SELECT "id" FROM "schools_student");
  ALTER TABLE "schools_assessment" ADD CONSTRAINT "fk_schools_assessment_0" FOREIGN KEY ("student_id") REFERENCES "schools_student" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "schools_assessment" WHERE "recorded_by_id" IS NOT NULL AND "recorded_by_id" NOT IN (SELECT "id" FROM "auth_user");
  ALTER TABLE "schools_assessment" ADD CONSTRAINT "fk_schools_assessment_1" FOREIGN KEY ("recorded_by_id") REFERENCES "auth_user" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: schools_assessmentresult
DO $$ BEGIN
  DELETE FROM "schools_assessmentresult" WHERE "subject_id" IS NOT NULL AND "subject_id" NOT IN (SELECT "id" FROM "schools_subject");
  ALTER TABLE "schools_assessmentresult" ADD CONSTRAINT "fk_schools_assessmentresult_0" FOREIGN KEY ("subject_id") REFERENCES "schools_subject" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "schools_assessmentresult" WHERE "assessment_id" IS NOT NULL AND "assessment_id" NOT IN (SELECT "id" FROM "schools_assessment");
  ALTER TABLE "schools_assessmentresult" ADD CONSTRAINT "fk_schools_assessmentresult_1" FOREIGN KEY ("assessment_id") REFERENCES "schools_assessment" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: schools_schedule
DO $$ BEGIN
  DELETE FROM "schools_schedule" WHERE "teacher_id" IS NOT NULL AND "teacher_id" NOT IN (SELECT "employee_ptr_id" FROM "schools_teacher");
  ALTER TABLE "schools_schedule" ADD CONSTRAINT "fk_schools_schedule_0" FOREIGN KEY ("teacher_id") REFERENCES "schools_teacher" ("employee_ptr_id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "schools_schedule" WHERE "subject_id" IS NOT NULL AND "subject_id" NOT IN (SELECT "id" FROM "schools_subject");
  ALTER TABLE "schools_schedule" ADD CONSTRAINT "fk_schools_schedule_1" FOREIGN KEY ("subject_id") REFERENCES "schools_subject" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "schools_schedule" WHERE "grade_id" IS NOT NULL AND "grade_id" NOT IN (SELECT "id" FROM "schools_grade");
  ALTER TABLE "schools_schedule" ADD CONSTRAINT "fk_schools_schedule_2" FOREIGN KEY ("grade_id") REFERENCES "schools_grade" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: schools_announcement
DO $$ BEGIN
  DELETE FROM "schools_announcement" WHERE "specific_grade_id" IS NOT NULL AND "specific_grade_id" NOT IN (SELECT "id" FROM "schools_grade");
  ALTER TABLE "schools_announcement" ADD CONSTRAINT "fk_schools_announcement_0" FOREIGN KEY ("specific_grade_id") REFERENCES "schools_grade" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "schools_announcement" WHERE "author_id" IS NOT NULL AND "author_id" NOT IN (SELECT "id" FROM "auth_user");
  ALTER TABLE "schools_announcement" ADD CONSTRAINT "fk_schools_announcement_1" FOREIGN KEY ("author_id") REFERENCES "auth_user" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: schools_smsmessage
DO $$ BEGIN
  DELETE FROM "schools_smsmessage" WHERE "specific_student_id" IS NOT NULL AND "specific_student_id" NOT IN (SELECT "id" FROM "schools_student");
  ALTER TABLE "schools_smsmessage" ADD CONSTRAINT "fk_schools_smsmessage_0" FOREIGN KEY ("specific_student_id") REFERENCES "schools_student" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "schools_smsmessage" WHERE "specific_grade_id" IS NOT NULL AND "specific_grade_id" NOT IN (SELECT "id" FROM "schools_grade");
  ALTER TABLE "schools_smsmessage" ADD CONSTRAINT "fk_schools_smsmessage_1" FOREIGN KEY ("specific_grade_id") REFERENCES "schools_grade" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "schools_smsmessage" WHERE "sent_by_id" IS NOT NULL AND "sent_by_id" NOT IN (SELECT "id" FROM "auth_user");
  ALTER TABLE "schools_smsmessage" ADD CONSTRAINT "fk_schools_smsmessage_2" FOREIGN KEY ("sent_by_id") REFERENCES "auth_user" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: schools_transportfee
DO $$ BEGIN
  DELETE FROM "schools_transportfee" WHERE "student_id" IS NOT NULL AND "student_id" NOT IN (SELECT "id" FROM "schools_student");
  ALTER TABLE "schools_transportfee" ADD CONSTRAINT "fk_schools_transportfee_0" FOREIGN KEY ("student_id") REFERENCES "schools_student" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "schools_transportfee" WHERE "route_id" IS NOT NULL AND "route_id" NOT IN (SELECT "id" FROM "schools_route");
  ALTER TABLE "schools_transportfee" ADD CONSTRAINT "fk_schools_transportfee_1" FOREIGN KEY ("route_id") REFERENCES "schools_route" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: schools_studenttransportassignment
DO $$ BEGIN
  DELETE FROM "schools_studenttransportassignment" WHERE "vehicle_id" IS NOT NULL AND "vehicle_id" NOT IN (SELECT "id" FROM "schools_vehicle");
  ALTER TABLE "schools_studenttransportassignment" ADD CONSTRAINT "fk_schools_studenttransportassignment_0" FOREIGN KEY ("vehicle_id") REFERENCES "schools_vehicle" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "schools_studenttransportassignment" WHERE "student_id" IS NOT NULL AND "student_id" NOT IN (SELECT "id" FROM "schools_student");
  ALTER TABLE "schools_studenttransportassignment" ADD CONSTRAINT "fk_schools_studenttransportassignment_1" FOREIGN KEY ("student_id") REFERENCES "schools_student" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "schools_studenttransportassignment" WHERE "route_id" IS NOT NULL AND "route_id" NOT IN (SELECT "id" FROM "schools_route");
  ALTER TABLE "schools_studenttransportassignment" ADD CONSTRAINT "fk_schools_studenttransportassignment_2" FOREIGN KEY ("route_id") REFERENCES "schools_route" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: schools_foodfee
DO $$ BEGIN
  DELETE FROM "schools_foodfee" WHERE "food_plan_id" IS NOT NULL AND "food_plan_id" NOT IN (SELECT "id" FROM "schools_foodplan");
  ALTER TABLE "schools_foodfee" ADD CONSTRAINT "fk_schools_foodfee_0" FOREIGN KEY ("food_plan_id") REFERENCES "schools_foodplan" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "schools_foodfee" WHERE "student_id" IS NOT NULL AND "student_id" NOT IN (SELECT "id" FROM "schools_student");
  ALTER TABLE "schools_foodfee" ADD CONSTRAINT "fk_schools_foodfee_1" FOREIGN KEY ("student_id") REFERENCES "schools_student" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: schools_studentfoodassignment
DO $$ BEGIN
  DELETE FROM "schools_studentfoodassignment" WHERE "student_id" IS NOT NULL AND "student_id" NOT IN (SELECT "id" FROM "schools_student");
  ALTER TABLE "schools_studentfoodassignment" ADD CONSTRAINT "fk_schools_studentfoodassignment_0" FOREIGN KEY ("student_id") REFERENCES "schools_student" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "schools_studentfoodassignment" WHERE "food_plan_id" IS NOT NULL AND "food_plan_id" NOT IN (SELECT "id" FROM "schools_foodplan");
  ALTER TABLE "schools_studentfoodassignment" ADD CONSTRAINT "fk_schools_studentfoodassignment_1" FOREIGN KEY ("food_plan_id") REFERENCES "schools_foodplan" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: schools_studentmealpayment
DO $$ BEGIN
  DELETE FROM "schools_studentmealpayment" WHERE "student_id" IS NOT NULL AND "student_id" NOT IN (SELECT "id" FROM "schools_student");
  ALTER TABLE "schools_studentmealpayment" ADD CONSTRAINT "fk_schools_studentmealpayment_0" FOREIGN KEY ("student_id") REFERENCES "schools_student" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: schools_mealconsumption
DO $$ BEGIN
  DELETE FROM "schools_mealconsumption" WHERE "student_id" IS NOT NULL AND "student_id" NOT IN (SELECT "id" FROM "schools_student");
  ALTER TABLE "schools_mealconsumption" ADD CONSTRAINT "fk_schools_mealconsumption_0" FOREIGN KEY ("student_id") REFERENCES "schools_student" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "schools_mealconsumption" WHERE "served_by_id" IS NOT NULL AND "served_by_id" NOT IN (SELECT "id" FROM "auth_user");
  ALTER TABLE "schools_mealconsumption" ADD CONSTRAINT "fk_schools_mealconsumption_1" FOREIGN KEY ("served_by_id") REFERENCES "auth_user" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "schools_mealconsumption" WHERE "meal_payment_id" IS NOT NULL AND "meal_payment_id" NOT IN (SELECT "id" FROM "schools_studentmealpayment");
  ALTER TABLE "schools_mealconsumption" ADD CONSTRAINT "fk_schools_mealconsumption_2" FOREIGN KEY ("meal_payment_id") REFERENCES "schools_studentmealpayment" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: schools_syncqueue
DO $$ BEGIN
  DELETE FROM "schools_syncqueue" WHERE "user_id" IS NOT NULL AND "user_id" NOT IN (SELECT "id" FROM "auth_user");
  ALTER TABLE "schools_syncqueue" ADD CONSTRAINT "fk_schools_syncqueue_0" FOREIGN KEY ("user_id") REFERENCES "auth_user" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: schools_employeeattendance
DO $$ BEGIN
  DELETE FROM "schools_employeeattendance" WHERE "recorded_by_id" IS NOT NULL AND "recorded_by_id" NOT IN (SELECT "id" FROM "auth_user");
  ALTER TABLE "schools_employeeattendance" ADD CONSTRAINT "fk_schools_employeeattendance_0" FOREIGN KEY ("recorded_by_id") REFERENCES "auth_user" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "schools_employeeattendance" WHERE "employee_id" IS NOT NULL AND "employee_id" NOT IN (SELECT "id" FROM "schools_employee");
  ALTER TABLE "schools_employeeattendance" ADD CONSTRAINT "fk_schools_employeeattendance_1" FOREIGN KEY ("employee_id") REFERENCES "schools_employee" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: schools_expense
DO $$ BEGIN
  DELETE FROM "schools_expense" WHERE "created_by_id" IS NOT NULL AND "created_by_id" NOT IN (SELECT "id" FROM "auth_user");
  ALTER TABLE "schools_expense" ADD CONSTRAINT "fk_schools_expense_0" FOREIGN KEY ("created_by_id") REFERENCES "auth_user" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: finance_feestructure
DO $$ BEGIN
  DELETE FROM "finance_feestructure" WHERE "grade_id" IS NOT NULL AND "grade_id" NOT IN (SELECT "id" FROM "schools_grade");
  ALTER TABLE "finance_feestructure" ADD CONSTRAINT "fk_finance_feestructure_0" FOREIGN KEY ("grade_id") REFERENCES "schools_grade" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "finance_feestructure" WHERE "category_id" IS NOT NULL AND "category_id" NOT IN (SELECT "id" FROM "finance_feecategory");
  ALTER TABLE "finance_feestructure" ADD CONSTRAINT "fk_finance_feestructure_1" FOREIGN KEY ("category_id") REFERENCES "finance_feecategory" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: finance_studentfinanceaccount
DO $$ BEGIN
  DELETE FROM "finance_studentfinanceaccount" WHERE "student_id" IS NOT NULL AND "student_id" NOT IN (SELECT "id" FROM "schools_student");
  ALTER TABLE "finance_studentfinanceaccount" ADD CONSTRAINT "fk_finance_studentfinanceaccount_0" FOREIGN KEY ("student_id") REFERENCES "schools_student" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: finance_transaction
DO $$ BEGIN
  DELETE FROM "finance_transaction" WHERE "recorded_by_id" IS NOT NULL AND "recorded_by_id" NOT IN (SELECT "id" FROM "auth_user");
  ALTER TABLE "finance_transaction" ADD CONSTRAINT "fk_finance_transaction_0" FOREIGN KEY ("recorded_by_id") REFERENCES "auth_user" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "finance_transaction" WHERE "account_id" IS NOT NULL AND "account_id" NOT IN (SELECT "id" FROM "finance_studentfinanceaccount");
  ALTER TABLE "finance_transaction" ADD CONSTRAINT "fk_finance_transaction_1" FOREIGN KEY ("account_id") REFERENCES "finance_studentfinanceaccount" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: finance_salarystructure
DO $$ BEGIN
  DELETE FROM "finance_salarystructure" WHERE "user_id" IS NOT NULL AND "user_id" NOT IN (SELECT "id" FROM "auth_user");
  ALTER TABLE "finance_salarystructure" ADD CONSTRAINT "fk_finance_salarystructure_0" FOREIGN KEY ("user_id") REFERENCES "auth_user" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: finance_payrollrecord
DO $$ BEGIN
  DELETE FROM "finance_payrollrecord" WHERE "user_id" IS NOT NULL AND "user_id" NOT IN (SELECT "id" FROM "auth_user");
  ALTER TABLE "finance_payrollrecord" ADD CONSTRAINT "fk_finance_payrollrecord_0" FOREIGN KEY ("user_id") REFERENCES "auth_user" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: food_foodstudentaccount
DO $$ BEGIN
  DELETE FROM "food_foodstudentaccount" WHERE "student_id" IS NOT NULL AND "student_id" NOT IN (SELECT "id" FROM "schools_student");
  ALTER TABLE "food_foodstudentaccount" ADD CONSTRAINT "fk_food_foodstudentaccount_0" FOREIGN KEY ("student_id") REFERENCES "schools_student" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: food_foodtransaction
DO $$ BEGIN
  DELETE FROM "food_foodtransaction" WHERE "recorded_by_id" IS NOT NULL AND "recorded_by_id" NOT IN (SELECT "id" FROM "auth_user");
  ALTER TABLE "food_foodtransaction" ADD CONSTRAINT "fk_food_foodtransaction_0" FOREIGN KEY ("recorded_by_id") REFERENCES "auth_user" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "food_foodtransaction" WHERE "account_id" IS NOT NULL AND "account_id" NOT IN (SELECT "id" FROM "food_foodstudentaccount");
  ALTER TABLE "food_foodtransaction" ADD CONSTRAINT "fk_food_foodtransaction_1" FOREIGN KEY ("account_id") REFERENCES "food_foodstudentaccount" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: food_foodsubscription
DO $$ BEGIN
  DELETE FROM "food_foodsubscription" WHERE "meal_item_id" IS NOT NULL AND "meal_item_id" NOT IN (SELECT "id" FROM "food_mealitem");
  ALTER TABLE "food_foodsubscription" ADD CONSTRAINT "fk_food_foodsubscription_0" FOREIGN KEY ("meal_item_id") REFERENCES "food_mealitem" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "food_foodsubscription" WHERE "account_id" IS NOT NULL AND "account_id" NOT IN (SELECT "id" FROM "food_foodstudentaccount");
  ALTER TABLE "food_foodsubscription" ADD CONSTRAINT "fk_food_foodsubscription_1" FOREIGN KEY ("account_id") REFERENCES "food_foodstudentaccount" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: transport_transportvehicle
DO $$ BEGIN
  DELETE FROM "transport_transportvehicle" WHERE "route_id" IS NOT NULL AND "route_id" NOT IN (SELECT "id" FROM "transport_route");
  ALTER TABLE "transport_transportvehicle" ADD CONSTRAINT "fk_transport_transportvehicle_0" FOREIGN KEY ("route_id") REFERENCES "transport_route" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: transport_transportdriver
DO $$ BEGIN
  DELETE FROM "transport_transportdriver" WHERE "user_id" IS NOT NULL AND "user_id" NOT IN (SELECT "id" FROM "auth_user");
  ALTER TABLE "transport_transportdriver" ADD CONSTRAINT "fk_transport_transportdriver_0" FOREIGN KEY ("user_id") REFERENCES "auth_user" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "transport_transportdriver" WHERE "vehicle_id" IS NOT NULL AND "vehicle_id" NOT IN (SELECT "id" FROM "transport_transportvehicle");
  ALTER TABLE "transport_transportdriver" ADD CONSTRAINT "fk_transport_transportdriver_1" FOREIGN KEY ("vehicle_id") REFERENCES "transport_transportvehicle" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: transport_transportstudentaccount
DO $$ BEGIN
  DELETE FROM "transport_transportstudentaccount" WHERE "student_id" IS NOT NULL AND "student_id" NOT IN (SELECT "id" FROM "schools_student");
  ALTER TABLE "transport_transportstudentaccount" ADD CONSTRAINT "fk_transport_transportstudentaccount_0" FOREIGN KEY ("student_id") REFERENCES "schools_student" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: transport_transportassignment
DO $$ BEGIN
  DELETE FROM "transport_transportassignment" WHERE "account_id" IS NOT NULL AND "account_id" NOT IN (SELECT "id" FROM "transport_transportstudentaccount");
  ALTER TABLE "transport_transportassignment" ADD CONSTRAINT "fk_transport_transportassignment_0" FOREIGN KEY ("account_id") REFERENCES "transport_transportstudentaccount" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "transport_transportassignment" WHERE "route_id" IS NOT NULL AND "route_id" NOT IN (SELECT "id" FROM "transport_route");
  ALTER TABLE "transport_transportassignment" ADD CONSTRAINT "fk_transport_transportassignment_1" FOREIGN KEY ("route_id") REFERENCES "transport_route" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: transport_transporttransaction
DO $$ BEGIN
  DELETE FROM "transport_transporttransaction" WHERE "recorded_by_id" IS NOT NULL AND "recorded_by_id" NOT IN (SELECT "id" FROM "auth_user");
  ALTER TABLE "transport_transporttransaction" ADD CONSTRAINT "fk_transport_transporttransaction_0" FOREIGN KEY ("recorded_by_id") REFERENCES "auth_user" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "transport_transporttransaction" WHERE "account_id" IS NOT NULL AND "account_id" NOT IN (SELECT "id" FROM "transport_transportstudentaccount");
  ALTER TABLE "transport_transporttransaction" ADD CONSTRAINT "fk_transport_transporttransaction_1" FOREIGN KEY ("account_id") REFERENCES "transport_transportstudentaccount" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: transport_transportadvancerequest
DO $$ BEGIN
  DELETE FROM "transport_transportadvancerequest" WHERE "driver_id" IS NOT NULL AND "driver_id" NOT IN (SELECT "id" FROM "transport_transportdriver");
  ALTER TABLE "transport_transportadvancerequest" ADD CONSTRAINT "fk_transport_transportadvancerequest_0" FOREIGN KEY ("driver_id") REFERENCES "transport_transportdriver" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "transport_transportadvancerequest" WHERE "action_by_id" IS NOT NULL AND "action_by_id" NOT IN (SELECT "id" FROM "auth_user");
  ALTER TABLE "transport_transportadvancerequest" ADD CONSTRAINT "fk_transport_transportadvancerequest_1" FOREIGN KEY ("action_by_id") REFERENCES "auth_user" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: transport_transportexpense
DO $$ BEGIN
  DELETE FROM "transport_transportexpense" WHERE "vehicle_id" IS NOT NULL AND "vehicle_id" NOT IN (SELECT "id" FROM "transport_transportvehicle");
  ALTER TABLE "transport_transportexpense" ADD CONSTRAINT "fk_transport_transportexpense_0" FOREIGN KEY ("vehicle_id") REFERENCES "transport_transportvehicle" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "transport_transportexpense" WHERE "driver_id" IS NOT NULL AND "driver_id" NOT IN (SELECT "id" FROM "transport_transportdriver");
  ALTER TABLE "transport_transportexpense" ADD CONSTRAINT "fk_transport_transportexpense_1" FOREIGN KEY ("driver_id") REFERENCES "transport_transportdriver" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "transport_transportexpense" WHERE "action_by_id" IS NOT NULL AND "action_by_id" NOT IN (SELECT "id" FROM "auth_user");
  ALTER TABLE "transport_transportexpense" ADD CONSTRAINT "fk_transport_transportexpense_2" FOREIGN KEY ("action_by_id") REFERENCES "auth_user" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- FKs for: transport_transportleaverequest
DO $$ BEGIN
  DELETE FROM "transport_transportleaverequest" WHERE "driver_id" IS NOT NULL AND "driver_id" NOT IN (SELECT "id" FROM "transport_transportdriver");
  ALTER TABLE "transport_transportleaverequest" ADD CONSTRAINT "fk_transport_transportleaverequest_0" FOREIGN KEY ("driver_id") REFERENCES "transport_transportdriver" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
DO $$ BEGIN
  DELETE FROM "transport_transportleaverequest" WHERE "action_by_id" IS NOT NULL AND "action_by_id" NOT IN (SELECT "id" FROM "auth_user");
  ALTER TABLE "transport_transportleaverequest" ADD CONSTRAINT "fk_transport_transportleaverequest_1" FOREIGN KEY ("action_by_id") REFERENCES "auth_user" ("id");
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- ============================================================
-- SECTION 4: CREATE INDEXES
-- ============================================================

CREATE UNIQUE INDEX IF NOT EXISTS "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" ("app_label", "model");
CREATE INDEX IF NOT EXISTS "auth_permission_content_type_id_2f476e4b" ON "auth_permission" ("content_type_id");
CREATE UNIQUE INDEX IF NOT EXISTS "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" ("content_type_id", "codename");
CREATE INDEX IF NOT EXISTS "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" ("permission_id");
CREATE INDEX IF NOT EXISTS "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" ("group_id");
CREATE UNIQUE INDEX IF NOT EXISTS "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" ("group_id", "permission_id");
CREATE INDEX IF NOT EXISTS "auth_user_groups_group_id_97559544" ON "auth_user_groups" ("group_id");
CREATE INDEX IF NOT EXISTS "auth_user_groups_user_id_6a12ed8b" ON "auth_user_groups" ("user_id");
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_groups_user_id_group_id_94350c0c_uniq" ON "auth_user_groups" ("user_id", "group_id");
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_permission_id_1fbb5f2c" ON "auth_user_user_permissions" ("permission_id");
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_a95ead1b" ON "auth_user_user_permissions" ("user_id");
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_permission_id_14a6b632_uniq" ON "auth_user_user_permissions" ("user_id", "permission_id");
CREATE INDEX IF NOT EXISTS "django_admin_log_user_id_c564eba6" ON "django_admin_log" ("user_id");
CREATE INDEX IF NOT EXISTS "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" ("content_type_id");
CREATE INDEX IF NOT EXISTS "schools_department_branch_id_c078bc8f" ON "schools_department" ("branch_id");
CREATE INDEX IF NOT EXISTS "schools_department_head_id_d6a2eb94" ON "schools_department" ("head_id");
CREATE INDEX IF NOT EXISTS "schools_employee_branch_id_3c7cdeae" ON "schools_employee" ("branch_id");
CREATE INDEX IF NOT EXISTS "schools_employee_department_id_19452d0d" ON "schools_employee" ("department_id");
CREATE INDEX IF NOT EXISTS "schools_teacher_grade_id_3f8fae20" ON "schools_teacher" ("grade_id");
CREATE INDEX IF NOT EXISTS "schools_teacher_subjects_subject_id_4ec63c67" ON "schools_teacher_subjects" ("subject_id");
CREATE INDEX IF NOT EXISTS "schools_teacher_subjects_teacher_id_e62f6f59" ON "schools_teacher_subjects" ("teacher_id");
CREATE UNIQUE INDEX IF NOT EXISTS "schools_teacher_subjects_teacher_id_subject_id_3915d914_uniq" ON "schools_teacher_subjects" ("teacher_id", "subject_id");
CREATE INDEX IF NOT EXISTS "schools_nonteachingstaff_supervisor_id_266ca559" ON "schools_nonteachingstaff" ("supervisor_id");
CREATE UNIQUE INDEX IF NOT EXISTS "schools_salary_employee_id_month_d36c58f5_uniq" ON "schools_salary" ("employee_id", "month");
CREATE INDEX IF NOT EXISTS "schools_salary_employee_id_df90283d" ON "schools_salary" ("employee_id");
CREATE INDEX IF NOT EXISTS "schools_allowance_salary_id_de8f9f47" ON "schools_allowance" ("salary_id");
CREATE INDEX IF NOT EXISTS "schools_deduction_salary_id_5b107780" ON "schools_deduction" ("salary_id");
CREATE INDEX IF NOT EXISTS "schools_salaryadvance_employee_id_57f3f536" ON "schools_salaryadvance" ("employee_id");
CREATE INDEX IF NOT EXISTS "schools_salaryadvance_approved_by_id_6d476107" ON "schools_salaryadvance" ("approved_by_id");
CREATE INDEX IF NOT EXISTS "schools_advanceapproval_approver_id_c4e917d5" ON "schools_advanceapproval" ("approver_id");
CREATE INDEX IF NOT EXISTS "schools_advanceapproval_advance_id_ac32b886" ON "schools_advanceapproval" ("advance_id");
CREATE UNIQUE INDEX IF NOT EXISTS "schools_advanceapproval_advance_id_approval_level_0f8bde8b_uniq" ON "schools_advanceapproval" ("advance_id", "approval_level");
CREATE INDEX IF NOT EXISTS "schools_leave_employee_id_d762bafd" ON "schools_leave" ("employee_id");
CREATE INDEX IF NOT EXISTS "schools_leave_approved_by_id_3e4ca239" ON "schools_leave" ("approved_by_id");
CREATE INDEX IF NOT EXISTS "schools_leaveapproval_leave_id_c7704229" ON "schools_leaveapproval" ("leave_id");
CREATE INDEX IF NOT EXISTS "schools_leaveapproval_approver_id_4be99663" ON "schools_leaveapproval" ("approver_id");
CREATE UNIQUE INDEX IF NOT EXISTS "schools_leaveapproval_leave_id_approval_level_1842f0ea_uniq" ON "schools_leaveapproval" ("leave_id", "approval_level");
CREATE INDEX IF NOT EXISTS "schools_staffdocument_uploaded_by_id_04932dd9" ON "schools_staffdocument" ("uploaded_by_id");
CREATE INDEX IF NOT EXISTS "schools_staffdocument_employee_id_75296e04" ON "schools_staffdocument" ("employee_id");
CREATE UNIQUE INDEX IF NOT EXISTS "schools_term_number_year_fabed8bc_uniq" ON "schools_term" ("number", "year");
CREATE INDEX IF NOT EXISTS "schools_vehicle_driver_id_d36200c0" ON "schools_vehicle" ("driver_id");
CREATE INDEX IF NOT EXISTS "schools_student_branch_id_8405b84e" ON "schools_student" ("branch_id");
CREATE INDEX IF NOT EXISTS "schools_student_previous_grade_id_5d1c68e8" ON "schools_student" ("previous_grade_id");
CREATE INDEX IF NOT EXISTS "schools_student_grade_id_8000fe5e" ON "schools_student" ("grade_id");
CREATE INDEX IF NOT EXISTS "schools_payment_student_id_4c53fbf1" ON "schools_payment" ("student_id");
CREATE INDEX IF NOT EXISTS "schools_attendance_student_id_1aa8fb2b" ON "schools_attendance" ("student_id");
CREATE INDEX IF NOT EXISTS "schools_attendance_recorded_by_id_cb69d9f2" ON "schools_attendance" ("recorded_by_id");
CREATE UNIQUE INDEX IF NOT EXISTS "schools_attendance_student_id_date_f10a29fd_uniq" ON "schools_attendance" ("student_id", "date");
CREATE UNIQUE INDEX IF NOT EXISTS "unique_weekly_assessment_per_week" ON "schools_assessment" ("student_id", "assessment_type", "term", "week_number");
CREATE UNIQUE INDEX IF NOT EXISTS "unique_non_weekly_assessment_per_term" ON "schools_assessment" ("student_id", "assessment_type", "term");
CREATE INDEX IF NOT EXISTS "schools_assessment_student_id_5bb34ab0" ON "schools_assessment" ("student_id");
CREATE INDEX IF NOT EXISTS "schools_assessment_recorded_by_id_28ea24c0" ON "schools_assessment" ("recorded_by_id");
CREATE INDEX IF NOT EXISTS "schools_assessmentresult_subject_id_8cd7e420" ON "schools_assessmentresult" ("subject_id");
CREATE INDEX IF NOT EXISTS "schools_assessmentresult_assessment_id_a5fa71f2" ON "schools_assessmentresult" ("assessment_id");
CREATE UNIQUE INDEX IF NOT EXISTS "schools_assessmentresult_assessment_id_subject_id_60b333d9_uniq" ON "schools_assessmentresult" ("assessment_id", "subject_id");
CREATE INDEX IF NOT EXISTS "schools_schedule_teacher_id_3e26d6d6" ON "schools_schedule" ("teacher_id");
CREATE INDEX IF NOT EXISTS "schools_schedule_subject_id_5113dd57" ON "schools_schedule" ("subject_id");
CREATE INDEX IF NOT EXISTS "schools_schedule_grade_id_848a7670" ON "schools_schedule" ("grade_id");
CREATE INDEX IF NOT EXISTS "schools_announcement_specific_grade_id_8bdf1f46" ON "schools_announcement" ("specific_grade_id");
CREATE INDEX IF NOT EXISTS "schools_announcement_author_id_fde21a53" ON "schools_announcement" ("author_id");
CREATE INDEX IF NOT EXISTS "schools_smsmessage_specific_student_id_988a2c7a" ON "schools_smsmessage" ("specific_student_id");
CREATE INDEX IF NOT EXISTS "schools_smsmessage_specific_grade_id_630482ee" ON "schools_smsmessage" ("specific_grade_id");
CREATE INDEX IF NOT EXISTS "schools_smsmessage_sent_by_id_11b65767" ON "schools_smsmessage" ("sent_by_id");
CREATE INDEX IF NOT EXISTS "schools_transportfee_student_id_ec85a65b" ON "schools_transportfee" ("student_id");
CREATE INDEX IF NOT EXISTS "schools_transportfee_route_id_f2584562" ON "schools_transportfee" ("route_id");
CREATE INDEX IF NOT EXISTS "schools_studenttransportassignment_vehicle_id_e597ae9b" ON "schools_studenttransportassignment" ("vehicle_id");
CREATE INDEX IF NOT EXISTS "schools_studenttransportassignment_student_id_32f200c8" ON "schools_studenttransportassignment" ("student_id");
CREATE INDEX IF NOT EXISTS "schools_studenttransportassignment_route_id_5eea36ed" ON "schools_studenttransportassignment" ("route_id");
CREATE UNIQUE INDEX IF NOT EXISTS "schools_studenttransportassignment_student_id_route_id_feee7d2c_uniq" ON "schools_studenttransportassignment" ("student_id", "route_id");
CREATE INDEX IF NOT EXISTS "schools_foodfee_food_plan_id_1a5a7872" ON "schools_foodfee" ("food_plan_id");
CREATE INDEX IF NOT EXISTS "schools_foodfee_student_id_14d7ba31" ON "schools_foodfee" ("student_id");
CREATE INDEX IF NOT EXISTS "schools_studentfoodassignment_student_id_785fc822" ON "schools_studentfoodassignment" ("student_id");
CREATE INDEX IF NOT EXISTS "schools_studentfoodassignment_food_plan_id_a5cfa5dc" ON "schools_studentfoodassignment" ("food_plan_id");
CREATE UNIQUE INDEX IF NOT EXISTS "schools_studentfoodassignment_student_id_food_plan_id_b6a32a41_uniq" ON "schools_studentfoodassignment" ("student_id", "food_plan_id");
CREATE UNIQUE INDEX IF NOT EXISTS "schools_mealpricing_meal_type_location_db79594f_uniq" ON "schools_mealpricing" ("meal_type", "location");
CREATE INDEX IF NOT EXISTS "schools_stu_payment_2cdcad_idx" ON "schools_studentmealpayment" ("payment_date");
CREATE INDEX IF NOT EXISTS "schools_stu_student_cb8a21_idx" ON "schools_studentmealpayment" ("student_id", "meal_type", "is_active");
CREATE INDEX IF NOT EXISTS "schools_studentmealpayment_student_id_c6954ef9" ON "schools_studentmealpayment" ("student_id");
CREATE INDEX IF NOT EXISTS "schools_mea_consump_ba0660_idx" ON "schools_mealconsumption" ("consumption_date");
CREATE INDEX IF NOT EXISTS "schools_mea_student_d067ca_idx" ON "schools_mealconsumption" ("student_id", "meal_type", "consumption_date");
CREATE INDEX IF NOT EXISTS "schools_mealconsumption_student_id_5d2412e8" ON "schools_mealconsumption" ("student_id");
CREATE INDEX IF NOT EXISTS "schools_mealconsumption_served_by_id_4873344d" ON "schools_mealconsumption" ("served_by_id");
CREATE INDEX IF NOT EXISTS "schools_mealconsumption_meal_payment_id_730af8fd" ON "schools_mealconsumption" ("meal_payment_id");
CREATE UNIQUE INDEX IF NOT EXISTS "schools_mealconsumption_student_id_meal_type_consumption_date_16259b88_uniq" ON "schools_mealconsumption" ("student_id", "meal_type", "consumption_date");
CREATE INDEX IF NOT EXISTS "schools_syn_model_n_d0e6c4_idx" ON "schools_syncqueue" ("model_name", "model_id");
CREATE INDEX IF NOT EXISTS "schools_syn_status_556b41_idx" ON "schools_syncqueue" ("status", "created_at");
CREATE INDEX IF NOT EXISTS "schools_syncqueue_user_id_71a529d4" ON "schools_syncqueue" ("user_id");
CREATE INDEX IF NOT EXISTS "schools_employeeattendance_recorded_by_id_758faf56" ON "schools_employeeattendance" ("recorded_by_id");
CREATE INDEX IF NOT EXISTS "schools_employeeattendance_employee_id_7276a174" ON "schools_employeeattendance" ("employee_id");
CREATE UNIQUE INDEX IF NOT EXISTS "schools_employeeattendance_employee_id_date_8125ec9e_uniq" ON "schools_employeeattendance" ("employee_id", "date");
CREATE INDEX IF NOT EXISTS "schools_expense_created_by_id_f67ddd76" ON "schools_expense" ("created_by_id");
CREATE INDEX IF NOT EXISTS "finance_feestructure_grade_id_4db87074" ON "finance_feestructure" ("grade_id");
CREATE INDEX IF NOT EXISTS "finance_feestructure_category_id_c484f382" ON "finance_feestructure" ("category_id");
CREATE UNIQUE INDEX IF NOT EXISTS "finance_feestructure_grade_id_term_academic_year_category_id_706e1de3_uniq" ON "finance_feestructure" ("grade_id", "term", "academic_year", "category_id");
CREATE INDEX IF NOT EXISTS "finance_transaction_recorded_by_id_ee34a345" ON "finance_transaction" ("recorded_by_id");
CREATE INDEX IF NOT EXISTS "finance_transaction_account_id_fb4d3f0f" ON "finance_transaction" ("account_id");
CREATE INDEX IF NOT EXISTS "finance_payrollrecord_user_id_1a82683c" ON "finance_payrollrecord" ("user_id");
CREATE UNIQUE INDEX IF NOT EXISTS "finance_payrollrecord_user_id_month_e56e5f95_uniq" ON "finance_payrollrecord" ("user_id", "month");
CREATE INDEX IF NOT EXISTS "food_foodtransaction_recorded_by_id_01d63439" ON "food_foodtransaction" ("recorded_by_id");
CREATE INDEX IF NOT EXISTS "food_foodtransaction_account_id_cd45f68f" ON "food_foodtransaction" ("account_id");
CREATE INDEX IF NOT EXISTS "food_foodsubscription_meal_item_id_a7ec1225" ON "food_foodsubscription" ("meal_item_id");
CREATE INDEX IF NOT EXISTS "food_foodsubscription_account_id_c2a39b1a" ON "food_foodsubscription" ("account_id");
CREATE INDEX IF NOT EXISTS "transport_transportvehicle_route_id_6871116b" ON "transport_transportvehicle" ("route_id");
CREATE INDEX IF NOT EXISTS "transport_transportassignment_account_id_19deb1b9" ON "transport_transportassignment" ("account_id");
CREATE INDEX IF NOT EXISTS "transport_transportassignment_route_id_9c0b63c1" ON "transport_transportassignment" ("route_id");
CREATE INDEX IF NOT EXISTS "transport_transporttransaction_recorded_by_id_40a74d82" ON "transport_transporttransaction" ("recorded_by_id");
CREATE INDEX IF NOT EXISTS "transport_transporttransaction_account_id_5e3ffa4e" ON "transport_transporttransaction" ("account_id");
CREATE INDEX IF NOT EXISTS "transport_transportadvancerequest_driver_id_ebdbdc95" ON "transport_transportadvancerequest" ("driver_id");
CREATE INDEX IF NOT EXISTS "transport_transportadvancerequest_action_by_id_7de3af07" ON "transport_transportadvancerequest" ("action_by_id");
CREATE INDEX IF NOT EXISTS "transport_transportexpense_vehicle_id_6fb1f292" ON "transport_transportexpense" ("vehicle_id");
CREATE INDEX IF NOT EXISTS "transport_transportexpense_driver_id_a0277ca3" ON "transport_transportexpense" ("driver_id");
CREATE INDEX IF NOT EXISTS "transport_transportexpense_action_by_id_c6cb71a5" ON "transport_transportexpense" ("action_by_id");
CREATE INDEX IF NOT EXISTS "transport_transportleaverequest_driver_id_8364a185" ON "transport_transportleaverequest" ("driver_id");
CREATE INDEX IF NOT EXISTS "transport_transportleaverequest_action_by_id_2be3f38a" ON "transport_transportleaverequest" ("action_by_id");

-- ============================================================
-- SECTION 5: RESET SEQUENCES
-- ============================================================

SELECT setval('"django_content_type_id_seq"', 65, true);
SELECT setval('"auth_permission_id_seq"', 260, true);
SELECT setval('"auth_group_id_seq"', 3, true);
SELECT setval('"auth_user_id_seq"', 1346, true);
SELECT setval('"auth_user_groups_id_seq"', 1345, true);
SELECT setval('"django_migrations_id_seq"', 97, true);
SELECT setval('"django_admin_log_id_seq"', 231, true);
SELECT setval('"config_schoolconfig_id_seq"', 1, true);
SELECT setval('"schools_branch_id_seq"', 2, true);
SELECT setval('"schools_department_id_seq"', 6, true);
SELECT setval('"schools_employee_id_seq"', 47, true);
SELECT setval('"schools_grade_id_seq"', 15, true);
SELECT setval('"schools_teacher_employee_ptr_id_seq"', 47, true);
SELECT setval('"schools_teacher_subjects_id_seq"', 296, true);
SELECT setval('"schools_subject_id_seq"', 12, true);
SELECT setval('"schools_term_id_seq"', 1, true);
SELECT setval('"schools_route_id_seq"', 3, true);
SELECT setval('"schools_vehicle_id_seq"', 1, true);
SELECT setval('"schools_student_id_seq"', 1315, true);
SELECT setval('"schools_attendance_id_seq"', 66, true);
SELECT setval('"schools_schedule_id_seq"', 11, true);
SELECT setval('"schools_announcement_id_seq"', 22, true);
SELECT setval('"schools_smsmessage_id_seq"', 16, true);
SELECT setval('"schools_foodplan_id_seq"', 1, true);
SELECT setval('"schools_mealpricing_id_seq"', 3, true);
SELECT setval('"schools_syncstatus_id_seq"', 1, true);
SELECT setval('"finance_feecategory_id_seq"', 4, true);
SELECT setval('"finance_feestructure_id_seq"', 60, true);
SELECT setval('"finance_studentfinanceaccount_id_seq"', 1655, true);
SELECT setval('"finance_transaction_id_seq"', 1788, true);
SELECT setval('"finance_salarystructure_id_seq"', 26, true);
SELECT setval('"food_mealitem_id_seq"', 7, true);
SELECT setval('"food_foodstudentaccount_id_seq"', 10, true);
SELECT setval('"transport_route_id_seq"', 5, true);
SELECT setval('"transport_transportdriver_id_seq"', 1, true);
SELECT setval('"transport_transportstudentaccount_id_seq"', 5, true);

SET session_replication_role = 'origin';

-- ============================================================
-- MIGRATION COMPLETE
-- ============================================================