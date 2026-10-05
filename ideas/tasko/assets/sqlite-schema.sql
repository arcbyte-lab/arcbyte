CREATE TABLE IF NOT EXISTS "migrations"(
  "id" integer primary key autoincrement not null,
  "migration" varchar not null,
  "batch" integer not null
);
CREATE TABLE IF NOT EXISTS "users"(
  "id" integer primary key autoincrement not null,
  "name" varchar not null,
  "email" varchar not null,
  "email_verified_at" datetime,
  "password" varchar not null,
  "remember_token" varchar,
  "must_change_password" tinyint(1) not null default '1',
  "is_active" tinyint(1) not null default '1',
  "created_at" datetime,
  "updated_at" datetime,
  "two_factor_secret" text,
  "two_factor_recovery_codes" text,
  "two_factor_confirmed_at" datetime,
  "nik" varchar,
  "role" varchar not null default 'user',
  "avatar" varchar
);
CREATE UNIQUE INDEX "users_email_unique" on "users"("email");
CREATE TABLE IF NOT EXISTS "password_reset_tokens"(
  "email" varchar not null,
  "token" varchar not null,
  "created_at" datetime,
  primary key("email")
);
CREATE TABLE IF NOT EXISTS "sessions"(
  "id" varchar not null,
  "user_id" integer,
  "ip_address" varchar,
  "user_agent" text,
  "payload" text not null,
  "last_activity" integer not null,
  primary key("id")
);
CREATE INDEX "sessions_user_id_index" on "sessions"("user_id");
CREATE INDEX "sessions_last_activity_index" on "sessions"("last_activity");
CREATE TABLE IF NOT EXISTS "cache"(
  "key" varchar not null,
  "value" text not null,
  "expiration" integer not null,
  primary key("key")
);
CREATE INDEX "cache_expiration_index" on "cache"("expiration");
CREATE TABLE IF NOT EXISTS "cache_locks"(
  "key" varchar not null,
  "owner" varchar not null,
  "expiration" integer not null,
  primary key("key")
);
CREATE INDEX "cache_locks_expiration_index" on "cache_locks"("expiration");
CREATE TABLE IF NOT EXISTS "jobs"(
  "id" integer primary key autoincrement not null,
  "queue" varchar not null,
  "payload" text not null,
  "attempts" integer not null,
  "reserved_at" integer,
  "available_at" integer not null,
  "created_at" integer not null
);
CREATE INDEX "jobs_queue_index" on "jobs"("queue");
CREATE TABLE IF NOT EXISTS "job_batches"(
  "id" varchar not null,
  "name" varchar not null,
  "total_jobs" integer not null,
  "pending_jobs" integer not null,
  "failed_jobs" integer not null,
  "failed_job_ids" text not null,
  "options" text,
  "cancelled_at" integer,
  "created_at" integer not null,
  "finished_at" integer,
  primary key("id")
);
CREATE TABLE IF NOT EXISTS "failed_jobs"(
  "id" integer primary key autoincrement not null,
  "uuid" varchar not null,
  "connection" text not null,
  "queue" text not null,
  "payload" text not null,
  "exception" text not null,
  "failed_at" datetime not null default CURRENT_TIMESTAMP
);
CREATE UNIQUE INDEX "failed_jobs_uuid_unique" on "failed_jobs"("uuid");
CREATE TABLE IF NOT EXISTS "divisions"(
  "id" integer primary key autoincrement not null,
  "prefix" varchar not null,
  "name" varchar not null,
  "slug" varchar not null,
  "description" text,
  "created_at" datetime,
  "updated_at" datetime,
  "deleted_at" datetime
);
CREATE UNIQUE INDEX "divisions_prefix_unique" on "divisions"("prefix");
CREATE UNIQUE INDEX "divisions_name_unique" on "divisions"("name");
CREATE UNIQUE INDEX "divisions_slug_unique" on "divisions"("slug");
CREATE TABLE IF NOT EXISTS "division_members"(
  "id" integer primary key autoincrement not null,
  "user_id" integer not null,
  "division_id" integer not null,
  "role_type" varchar check("role_type" in('admin', 'supervisor', 'member', 'viewer')) not null default 'member',
  "role_label" varchar,
  "created_at" datetime,
  "updated_at" datetime,
  foreign key("user_id") references "users"("id") on delete cascade,
  foreign key("division_id") references "divisions"("id") on delete cascade
);
CREATE UNIQUE INDEX "division_members_user_id_division_id_unique" on "division_members"(
  "user_id",
  "division_id"
);
CREATE TABLE IF NOT EXISTS "project_members"(
  "id" integer primary key autoincrement not null,
  "project_id" integer not null,
  "user_id" integer not null,
  "role" varchar check("role" in('owner', 'person-in-charge', 'member', 'viewer')) not null default 'member',
  "invited_by" integer,
  "created_at" datetime,
  "updated_at" datetime,
  foreign key("project_id") references "projects"("id") on delete cascade,
  foreign key("user_id") references "users"("id") on delete cascade,
  foreign key("invited_by") references "users"("id") on delete set null
);
CREATE UNIQUE INDEX "project_members_project_id_user_id_unique" on "project_members"(
  "project_id",
  "user_id"
);
CREATE TABLE IF NOT EXISTS "personal_access_tokens"(
  "id" integer primary key autoincrement not null,
  "tokenable_type" varchar not null,
  "tokenable_id" integer not null,
  "name" text not null,
  "token" varchar not null,
  "abilities" text,
  "last_used_at" datetime,
  "expires_at" datetime,
  "created_at" datetime,
  "updated_at" datetime
);
CREATE INDEX "personal_access_tokens_tokenable_type_tokenable_id_index" on "personal_access_tokens"(
  "tokenable_type",
  "tokenable_id"
);
CREATE UNIQUE INDEX "personal_access_tokens_token_unique" on "personal_access_tokens"(
  "token"
);
CREATE INDEX "personal_access_tokens_expires_at_index" on "personal_access_tokens"(
  "expires_at"
);
CREATE TABLE IF NOT EXISTS "proofs"(
  "id" integer primary key autoincrement not null,
  "task_id" integer not null,
  "user_id" integer not null,
  "file" varchar not null,
  "created_at" datetime,
  "updated_at" datetime,
  "drive_file_id" varchar,
  "size" integer,
  "original_name" varchar,
  foreign key("task_id") references "tasks"("id") on delete cascade,
  foreign key("user_id") references "users"("id")
);
CREATE TABLE IF NOT EXISTS "recurring_tasks"(
  "id" integer primary key autoincrement not null,
  "division_id" integer not null,
  "creator_id" integer not null,
  "name" varchar not null,
  "description" text,
  "frequency" varchar not null,
  "priority_level" integer not null default '2',
  "status" varchar check("status" in('Active', 'Paused')) not null default 'Active',
  "last_run_at" datetime,
  "next_run_at" datetime,
  "created_at" datetime,
  "updated_at" datetime,
  "deleted_at" datetime,
  "required_proof_type" varchar,
  "schedule_day" varchar,
  "due_time" varchar,
  "schedule_days" text,
  "assignee_id" integer not null,
  foreign key("division_id") references "divisions"("id") on delete cascade,
  foreign key("creator_id") references "users"("id") on delete cascade,
  foreign key("assignee_id") references "users"("id") on delete no action on update no action
);
CREATE INDEX "recurring_tasks_assignee_id_index" on "recurring_tasks"("assignee_id");
CREATE TABLE IF NOT EXISTS "project_activities"(
  "id" integer primary key autoincrement not null,
  "project_id" integer not null,
  "user_id" integer not null,
  "activity_type" varchar not null,
  "description" varchar not null,
  "properties" text,
  "created_at" datetime,
  "updated_at" datetime,
  foreign key("project_id") references "projects"("id") on delete cascade,
  foreign key("user_id") references "users"("id") on delete cascade
);
CREATE TABLE IF NOT EXISTS "projects"(
  "id" integer primary key autoincrement not null,
  "name" varchar not null,
  "description" text,
  "start_date" date,
  "due_date" date,
  "creator_id" integer not null,
  "division_id" integer not null,
  -- ADR 0005: final 5-value lifecycle. 'archived' is now a real terminal status (the
  -- visible form of soft-delete, reachable from any of the other four), not dead legacy.
  -- Default is 'planning', matching every doc's claim that a new Project hasn't started.
  "status" varchar check("status" in('planning', 'in_progress', 'completed', 'cancelled', 'archived')) not null default 'planning',
  "created_at" datetime,
  "updated_at" datetime,
  -- ADR 0005: kept only as the timestamp of the most recent transition into 'archived'
  -- (paralleling tasks.completed_date/cancelled_date) — not a parallel soft-delete
  -- mechanism. A row is archived because status says so, not because this is set.
  "deleted_at" datetime,
  foreign key("division_id") references divisions("id") on delete cascade on update no action,
  foreign key("creator_id") references users("id") on delete cascade on update no action
);
CREATE TABLE IF NOT EXISTS "tasks"(
  "id" integer primary key autoincrement not null,
  "code" varchar not null,
  "division_id" integer not null,
  "project_id" integer,
  "creator_id" integer not null,
  "name" varchar not null,
  "description" text,
  "priority_level" integer not null default('2'),
  "status" varchar not null default('waiting'),
  "due_date" datetime,
  "start_date" datetime,
  "completed_date" datetime,
  "review_date" datetime,
  "cancelled_date" datetime,
  "created_at" datetime,
  "updated_at" datetime,
  "required_proof_type" varchar,
  "parent_id" integer,
  "recurring_task_id" integer,
  "due_soon_notified_at" datetime,
  "reminder_notified_at" datetime,
  "overdue_notified_at" datetime,


  "assignee_id" integer,
  foreign key("creator_id") references users("id") on delete no action on update no action,
  foreign key("project_id") references projects("id") on delete set null on update no action,
  foreign key("division_id") references divisions("id") on delete cascade on update no action,
  foreign key("parent_id") references tasks("id") on delete cascade on update no action,
  foreign key("recurring_task_id") references "recurring_tasks"("id") on delete set null,
  foreign key("assignee_id") references users("id") on delete set null on update no action
);
CREATE UNIQUE INDEX "tasks_code_unique" on "tasks"("code");
CREATE INDEX "tasks_assignee_id_status_index" on "tasks"("assignee_id", "status");
CREATE TABLE IF NOT EXISTS "task_reviews"(
  "id" integer primary key autoincrement not null,
  "task_id" integer not null,
  "reviewer_id" integer not null,
  "decision" varchar not null,
  "reason" text,
  "created_at" datetime,
  "updated_at" datetime,
  foreign key("task_id") references "tasks"("id") on delete cascade,
  foreign key("reviewer_id") references "users"("id")
);
CREATE TABLE IF NOT EXISTS "attachments"(
  "id" integer primary key autoincrement not null,
  "task_id" integer not null,
  "user_id" integer not null,
  "file" varchar not null,
  "created_at" datetime,
  "updated_at" datetime,
  "drive_file_id" varchar,
  "size" integer,
  "comment_id" integer,
  "original_name" varchar,
  foreign key("user_id") references users("id") on delete no action on update no action,
  foreign key("task_id") references tasks("id") on delete cascade on update no action,
  foreign key("comment_id") references "comments"("id") on delete cascade
);
CREATE TABLE IF NOT EXISTS "comments"(
  "id" integer primary key autoincrement not null,
  "task_id" integer not null,
  "user_id" integer not null,
  "comment" text,
  "created_at" datetime,
  "updated_at" datetime,
  "mentioned_names" text,
  "deleted_at" datetime,
  foreign key("user_id") references users("id") on delete no action on update no action,
  foreign key("task_id") references tasks("id") on delete cascade on update no action
);
CREATE TABLE IF NOT EXISTS "personal_tasks"(
  "id" integer primary key autoincrement not null,
  "user_id" integer not null,
  "parent_id" integer,
  "title" varchar not null,
  "note" text,
  "status" varchar check("status" in('todo', 'in_progress', 'done')) not null default 'todo',
  "priority_level" integer not null default '2',
  "due_date" datetime,
  "completed_at" datetime,
  "position" integer not null default '0',
  "created_at" datetime,
  "updated_at" datetime,
  foreign key("user_id") references "users"("id") on delete cascade,
  foreign key("parent_id") references "personal_tasks"("id") on delete cascade
);
CREATE INDEX "personal_tasks_user_id_parent_id_index" on "personal_tasks"(
  "user_id",
  "parent_id"
);
CREATE INDEX "personal_tasks_user_id_status_index" on "personal_tasks"(
  "user_id",
  "status"
);
CREATE TABLE IF NOT EXISTS "notifications"(
  "id" varchar not null,
  "type" varchar not null,
  "notifiable_type" varchar not null,
  "notifiable_id" integer not null,
  "data" text not null,
  "read_at" datetime,
  "created_at" datetime,
  "updated_at" datetime,
  primary key("id")
);
CREATE INDEX "notifications_notifiable_type_notifiable_id_index" on "notifications"(
  "notifiable_type",
  "notifiable_id"
);
CREATE TABLE IF NOT EXISTS "task_deadline_requests"(
  "id" integer primary key autoincrement not null,
  "task_id" integer not null,
  "requester_id" integer not null,
  "decided_by" integer,
  "current_due_date" datetime,
  "requested_due_date" datetime not null,
  "reason" text,
  "status" varchar not null default 'pending',
  "decision_reason" text,
  "decided_at" datetime,
  "created_at" datetime,
  "updated_at" datetime,
  foreign key("task_id") references "tasks"("id") on delete cascade,
  foreign key("requester_id") references "users"("id"),
  foreign key("decided_by") references "users"("id")
);
CREATE INDEX "task_deadline_requests_task_id_status_index" on "task_deadline_requests"(
  "task_id",
  "status"
);
CREATE INDEX "tasks_project_id_parent_id_status_index" on "tasks"(
  "project_id",
  "parent_id",
  "status"
);
CREATE INDEX "tasks_division_id_parent_id_status_index" on "tasks"(
  "division_id",
  "parent_id",
  "status"
);
CREATE INDEX "tasks_due_soon_notified_at_due_date_index" on "tasks"(
  "due_soon_notified_at",
  "due_date"
);
CREATE INDEX "tasks_due_date_index" on "tasks"("due_date");
CREATE INDEX "notifications_notifiable_type_notifiable_id_read_at_index" on "notifications"(
  "notifiable_type",
  "notifiable_id",
  "read_at"
);
CREATE INDEX "project_activities_project_id_created_at_index" on "project_activities"(
  "project_id",
  "created_at"
);
CREATE UNIQUE INDEX "users_nik_unique" on "users"("nik");
CREATE TABLE IF NOT EXISTS "activity_logs"(
  "id" integer primary key autoincrement not null,
  "actor_id" integer,
  "actor_name" varchar,
  "action" varchar not null,
  "subject_type" varchar,
  "subject_id" integer,
  "subject_label" varchar,
  "division_id" integer,
  "project_id" integer,
  "changes" text,
  "description" varchar,
  "created_at" datetime,
  foreign key("actor_id") references "users"("id") on delete set null,
  foreign key("division_id") references "divisions"("id") on delete set null
);
CREATE INDEX "activity_logs_created_at_index" on "activity_logs"("created_at");
CREATE INDEX "activity_logs_division_id_created_at_index" on "activity_logs"(
  "division_id",
  "created_at"
);
CREATE INDEX "activity_logs_action_index" on "activity_logs"("action");
CREATE INDEX "activity_logs_subject_type_subject_id_index" on "activity_logs"(
  "subject_type",
  "subject_id"
);
CREATE TABLE IF NOT EXISTS "task_dependencies"(
  "id" integer primary key autoincrement not null,
  "predecessor_id" integer not null,
  "successor_id" integer not null,
  "created_at" datetime,
  "updated_at" datetime,
  foreign key("predecessor_id") references "tasks"("id") on delete cascade,
  foreign key("successor_id") references "tasks"("id") on delete cascade
);
CREATE UNIQUE INDEX "task_dependencies_predecessor_id_successor_id_unique" on "task_dependencies"(
  "predecessor_id",
  "successor_id"
);
CREATE INDEX "task_dependencies_successor_id_index" on "task_dependencies"(
  "successor_id"
);