-- Step 3: Add FK constraints, indexes, and reset sequences
-- Run this LAST after all data is inserted

SET session_replication_role = 'replica';

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
SET session_replication_role = 'origin';
