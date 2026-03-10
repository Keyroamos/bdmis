-- Step 1: Drop existing tables and recreate schema
-- Run this FIRST in Supabase SQL Editor

SET session_replication_role = 'replica';

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
