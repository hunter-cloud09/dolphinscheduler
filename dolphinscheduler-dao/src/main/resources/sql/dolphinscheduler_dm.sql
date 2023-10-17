/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
*/

-- ----------------------------
-- Records of QRTZ_FIRED_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_JOB_DETAILS
-- ----------------------------
DROP TABLE IF EXISTS QRTZ_JOB_DETAILS cascade;
CREATE TABLE QRTZ_JOB_DETAILS
(
    SCHED_NAME        varchar(120) NOT NULL,
    JOB_NAME          varchar(200) NOT NULL,
    JOB_GROUP         varchar(200) NOT NULL,
    DESCRIPTION       varchar(250) DEFAULT NULL,
    JOB_CLASS_NAME    varchar(250) NOT NULL,
    IS_DURABLE        varchar(1)   NOT NULL,
    IS_NONCONCURRENT  varchar(1)   NOT NULL,
    IS_UPDATE_DATA    varchar(1)   NOT NULL,
    REQUESTS_RECOVERY varchar(1)   NOT NULL,
    JOB_DATA          blob
);
alter table QRTZ_JOB_DETAILS
    add constraint PRIMARY KEY (SCHED_NAME, JOB_NAME, JOB_GROUP);
create index IDX_QRTZ_J_REQ_RECOVERY on QRTZ_JOB_DETAILS (SCHED_NAME, REQUESTS_RECOVERY);
create index IDX_QRTZ_J_GRP on QRTZ_JOB_DETAILS (SCHED_NAME, JOB_GROUP);

-- ----------------------------
-- Records of QRTZ_SIMPROP_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS QRTZ_TRIGGERS cascade;
CREATE TABLE QRTZ_TRIGGERS
(
    SCHED_NAME     varchar(120) NOT NULL,
    TRIGGER_NAME   varchar(200) NOT NULL,
    TRIGGER_GROUP  varchar(200) NOT NULL,
    JOB_NAME       varchar(200) NOT NULL,
    JOB_GROUP      varchar(200) NOT NULL,
    DESCRIPTION    varchar(250) DEFAULT NULL,
    NEXT_FIRE_TIME bigint       DEFAULT NULL,
    PREV_FIRE_TIME bigint       DEFAULT NULL,
    PRIORITY       bigint       DEFAULT NULL,
    TRIGGER_STATE  varchar(16)  NOT NULL,
    TRIGGER_TYPE   varchar(8)   NOT NULL,
    START_TIME     bigint       NOT NULL,
    END_TIME       bigint       DEFAULT NULL,
    CALENDAR_NAME  varchar(200) DEFAULT NULL,
    MISFIRE_INSTR  smallint     DEFAULT NULL,
    JOB_DATA       blob
);
alter table QRTZ_TRIGGERS
    add constraint PRIMARY KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP);
create index IDX_QRTZ_T_J on QRTZ_TRIGGERS (SCHED_NAME, JOB_GROUP);
create index IDX_QRTZ_T_JG on QRTZ_TRIGGERS (SCHED_NAME, JOB_NAME, JOB_GROUP);
create index IDX_QRTZ_T_C on QRTZ_TRIGGERS (SCHED_NAME, CALENDAR_NAME);
create index IDX_QRTZ_T_G on QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_GROUP);
create index IDX_QRTZ_T_STATE on QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_STATE);
create index IDX_QRTZ_T_N_STATE on QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP, TRIGGER_STATE);
create index IDX_QRTZ_T_N_G_STATE on QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_GROUP, TRIGGER_STATE);
create index IDX_QRTZ_T_NEXT_FIRE_TIME on QRTZ_TRIGGERS (SCHED_NAME, NEXT_FIRE_TIME);
create index IDX_QRTZ_T_NFT_ST on QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_STATE, NEXT_FIRE_TIME);
create index IDX_QRTZ_T_NFT_MISFIRE on QRTZ_TRIGGERS (SCHED_NAME, MISFIRE_INSTR, NEXT_FIRE_TIME);
create index IDX_QRTZ_T_NFT_ST_MISFIRE on QRTZ_TRIGGERS (SCHED_NAME, MISFIRE_INSTR, NEXT_FIRE_TIME, TRIGGER_STATE);
create index IDX_QRTZ_T_NFT_ST_MISFIRE_GRP on QRTZ_TRIGGERS (SCHED_NAME, MISFIRE_INSTR, NEXT_FIRE_TIME, TRIGGER_GROUP,
                                                             TRIGGER_STATE);
alter table QRTZ_TRIGGERS
    add constraint QRTZ_TRIGGERS_ibfk_1 FOREIGN KEY (SCHED_NAME, JOB_NAME, JOB_GROUP) REFERENCES QRTZ_JOB_DETAILS (SCHED_NAME, JOB_NAME, JOB_GROUP);

-- ----------------------------
-- Table structure for QRTZ_BLOB_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS QRTZ_BLOB_TRIGGERS;
CREATE TABLE QRTZ_BLOB_TRIGGERS
(
    SCHED_NAME    varchar(120) NOT NULL,
    TRIGGER_NAME  varchar(200) NOT NULL,
    TRIGGER_GROUP varchar(200) NOT NULL,
    BLOB_DATA     blob
);
alter table QRTZ_BLOB_TRIGGERS
    add constraint pk_stt primary key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP);
create index SCHED_NAME on QRTZ_BLOB_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP);
alter table QRTZ_BLOB_TRIGGERS
    add constraint fk_stt foreign key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP) REFERENCES QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP);

-- ----------------------------
-- Records of QRTZ_BLOB_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_CALENDARS
-- ----------------------------
DROP TABLE IF EXISTS QRTZ_CALENDARS;
CREATE TABLE QRTZ_CALENDARS
(
    SCHED_NAME    varchar(120) NOT NULL,
    CALENDAR_NAME varchar(200) NOT NULL,
    CALENDAR      blob         NOT NULL
);
alter table QRTZ_CALENDARS
    add constraint pk_sc PRIMARY KEY (SCHED_NAME, CALENDAR_NAME);

-- ----------------------------
-- Records of QRTZ_CALENDARS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_CRON_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS QRTZ_CRON_TRIGGERS;
CREATE TABLE QRTZ_CRON_TRIGGERS
(
    SCHED_NAME      varchar(120) NOT NULL,
    TRIGGER_NAME    varchar(200) NOT NULL,
    TRIGGER_GROUP   varchar(200) NOT NULL,
    CRON_EXPRESSION varchar(120) NOT NULL,
    TIME_ZONE_ID    varchar(80) DEFAULT NULL
);
alter table QRTZ_CRON_TRIGGERS
    add constraint pk_qct_stt PRIMARY KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP);
alter table QRTZ_CRON_TRIGGERS
    add constraint QRTZ_CRON_TRIGGERS_ibfk_1 FOREIGN KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP) REFERENCES QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP);


-- ----------------------------
-- Records of QRTZ_CRON_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_FIRED_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS QRTZ_FIRED_TRIGGERS;
CREATE TABLE QRTZ_FIRED_TRIGGERS
(
    SCHED_NAME        varchar(120) NOT NULL,
    ENTRY_ID          varchar(200) NOT NULL,
    TRIGGER_NAME      varchar(200) NOT NULL,
    TRIGGER_GROUP     varchar(200) NOT NULL,
    INSTANCE_NAME     varchar(200) NOT NULL,
    FIRED_TIME        bigint       NOT NULL,
    SCHED_TIME        bigint       NOT NULL,
    PRIORITY          int          NOT NULL,
    STATE             varchar(16)  NOT NULL,
    JOB_NAME          varchar(200) DEFAULT NULL,
    JOB_GROUP         varchar(200) DEFAULT NULL,
    IS_NONCONCURRENT  varchar(1)   DEFAULT NULL,
    REQUESTS_RECOVERY varchar(1)   DEFAULT NULL
);
alter table QRTZ_FIRED_TRIGGERS
    add constraint pk_qft_se PRIMARY KEY (SCHED_NAME, ENTRY_ID);
create index IDX_QRTZ_FT_TRIG_INST_NAME on QRTZ_FIRED_TRIGGERS (SCHED_NAME, INSTANCE_NAME);
create index IDX_QRTZ_FT_INST_JOB_REQ_RCVRY on QRTZ_FIRED_TRIGGERS (SCHED_NAME, INSTANCE_NAME, REQUESTS_RECOVERY);
create index IDX_QRTZ_FT_J_G on QRTZ_FIRED_TRIGGERS (SCHED_NAME, JOB_NAME, JOB_GROUP);
create index IDX_QRTZ_FT_JG on QRTZ_FIRED_TRIGGERS (SCHED_NAME, JOB_GROUP);
create index IDX_QRTZ_FT_T_G on QRTZ_FIRED_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP);
create index IDX_QRTZ_FT_TG on QRTZ_FIRED_TRIGGERS (SCHED_NAME, TRIGGER_GROUP);

-- ----------------------------
-- Records of QRTZ_JOB_DETAILS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_LOCKS
-- ----------------------------
DROP TABLE IF EXISTS QRTZ_LOCKS;
CREATE TABLE QRTZ_LOCKS
(
    SCHED_NAME varchar(120) NOT NULL,
    LOCK_NAME  varchar(40)  NOT NULL
);
alter table QRTZ_LOCKS
    add constraint pk_ql_sl PRIMARY KEY (SCHED_NAME, LOCK_NAME);

-- ----------------------------
-- Records of QRTZ_LOCKS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------
DROP TABLE IF EXISTS QRTZ_PAUSED_TRIGGER_GRPS;
CREATE TABLE QRTZ_PAUSED_TRIGGER_GRPS
(
    SCHED_NAME    varchar(120) NOT NULL,
    TRIGGER_GROUP varchar(200) NOT NULL
);
alter table QRTZ_PAUSED_TRIGGER_GRPS
    add constraint pk_qptg_st PRIMARY KEY (SCHED_NAME, TRIGGER_GROUP);

-- ----------------------------
-- Records of QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_SCHEDULER_STATE
-- ----------------------------
DROP TABLE IF EXISTS QRTZ_SCHEDULER_STATE;
CREATE TABLE QRTZ_SCHEDULER_STATE
(
    SCHED_NAME        varchar(120) NOT NULL,
    INSTANCE_NAME     varchar(200) NOT NULL,
    LAST_CHECKIN_TIME bigint       NOT NULL,
    CHECKIN_INTERVAL  bigint       NOT NULL
);
alter table QRTZ_SCHEDULER_STATE
    add constraint pk_qss_si PRIMARY KEY (SCHED_NAME, INSTANCE_NAME);

-- ----------------------------
-- Records of QRTZ_SCHEDULER_STATE
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_SIMPLE_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS QRTZ_SIMPLE_TRIGGERS;
CREATE TABLE QRTZ_SIMPLE_TRIGGERS
(
    SCHED_NAME      varchar(120) NOT NULL,
    TRIGGER_NAME    varchar(200) NOT NULL,
    TRIGGER_GROUP   varchar(200) NOT NULL,
    REPEAT_COUNT    bigint       NOT NULL,
    REPEAT_INTERVAL bigint       NOT NULL,
    TIMES_TRIGGERED bigint       NOT NULL,
    PRIMARY KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
);
alter table QRTZ_SIMPLE_TRIGGERS
    add constraint QRTZ_SIMPLE_TRIGGERS_ibfk_1 FOREIGN KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP) REFERENCES QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP);

-- ----------------------------
-- Records of QRTZ_SIMPLE_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_SIMPROP_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS QRTZ_SIMPROP_TRIGGERS;
CREATE TABLE QRTZ_SIMPROP_TRIGGERS
(
    SCHED_NAME    varchar(120) NOT NULL,
    TRIGGER_NAME  varchar(200) NOT NULL,
    TRIGGER_GROUP varchar(200) NOT NULL,
    STR_PROP_1    varchar(512)   DEFAULT NULL,
    STR_PROP_2    varchar(512)   DEFAULT NULL,
    STR_PROP_3    varchar(512)   DEFAULT NULL,
    INT_PROP_1    int            DEFAULT NULL,
    INT_PROP_2    int            DEFAULT NULL,
    LONG_PROP_1   bigint         DEFAULT NULL,
    LONG_PROP_2   bigint         DEFAULT NULL,
    DEC_PROP_1    NUMERIC(13, 4) DEFAULT NULL,
    DEC_PROP_2    NUMERIC(13, 4) DEFAULT NULL,
    BOOL_PROP_1   varchar(1)     DEFAULT NULL,
    BOOL_PROP_2   varchar(1)     DEFAULT NULL,
    PRIMARY KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
);
alter table QRTZ_SIMPROP_TRIGGERS
    add constraint QRTZ_SIMPROP_TRIGGERS_ibfk_1 FOREIGN KEY (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP) REFERENCES QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP);

-- ----------------------------
-- Records of QRTZ_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for t_ds_access_token
-- ----------------------------
DROP TABLE IF EXISTS t_ds_access_token;
CREATE TABLE t_ds_access_token
(
    id          int NOT NULL AUTO_INCREMENT,
    user_id     int          DEFAULT NULL,
    token       varchar(64)  DEFAULT NULL,
    expire_time timestamp(0) DEFAULT NULL,
    create_time timestamp(0) DEFAULT NULL,
    update_time timestamp(0) DEFAULT NULL,
    PRIMARY KEY (id)
);

INSERT INTO T_DS_ACCESS_TOKEN
(USER_ID, TOKEN, EXPIRE_TIME, CREATE_TIME, UPDATE_TIME)
VALUES(1, md5(concat('12123-10-10 14:53:52',unix_timestamp(now()))), '2123-10-10 14:53:52', current_timestamp, current_timestamp);


-- ----------------------------
-- Records of t_ds_access_token
-- ----------------------------

-- ----------------------------
-- Table structure for t_ds_alert
-- ----------------------------
DROP TABLE IF EXISTS t_ds_alert;
CREATE TABLE t_ds_alert
(
    id                      int NOT NULL AUTO_INCREMENT,
    title                   varchar(64)       DEFAULT NULL,
    sign                    char(40) NOT NULL DEFAULT '',
    content                 longvarchar,
    alert_status            tinyint           DEFAULT '0',
    warning_type            tinyint           DEFAULT '2',
    log                     longvarchar,
    alertgroup_id           int               DEFAULT NULL,
    create_time             timestamp(0)      DEFAULT NULL,
    update_time             timestamp(0)      DEFAULT NULL,
    project_code            bigint            DEFAULT NULL,
    process_definition_code bigint            DEFAULT NULL,
    process_instance_id     int               DEFAULT NULL,
    alert_type              int               DEFAULT NULL,
    PRIMARY KEY (id)
);
create index idx_status on t_ds_alert (alert_status);
create index idx_sign on t_ds_alert (sign);

-- ----------------------------
-- Records of t_ds_alert
-- ----------------------------

-- ----------------------------
-- Table structure for t_ds_alertgroup
-- ----------------------------
DROP TABLE IF EXISTS t_ds_alertgroup;
CREATE TABLE t_ds_alertgroup
(
    id                 int NOT NULL AUTO_INCREMENT,
    alert_instance_ids varchar(255) DEFAULT NULL,
    create_user_id     int          DEFAULT NULL,
    group_name         varchar(255) DEFAULT NULL,
    description        varchar(255) DEFAULT NULL,
    create_time        timestamp(0) DEFAULT NULL,
    update_time        timestamp(0) DEFAULT NULL,
    PRIMARY KEY (id)
);
alter table t_ds_alertgroup
    add constraint unique (group_name);

-- ----------------------------
-- Records of t_ds_alertgroup
-- ----------------------------

-- ----------------------------
-- Table structure for t_ds_command
-- ----------------------------
DROP TABLE IF EXISTS t_ds_command;
CREATE TABLE t_ds_command
(
    id                         int NOT NULL AUTO_INCREMENT,
    command_type               tinyint      DEFAULT NULL,
    process_definition_code    bigint NOT NULL,
    process_definition_version int          DEFAULT '0',
    process_instance_id        int          DEFAULT '0',
    command_param              longvarchar,
    task_depend_type           tinyint      DEFAULT NULL,
    failure_strategy           tinyint      DEFAULT '0',
    warning_type               tinyint      DEFAULT '0',
    warning_group_id           int          DEFAULT NULL,
    schedule_time              timestamp(0) DEFAULT NULL,
    start_time                 timestamp(0) DEFAULT NULL,
    executor_id                int          DEFAULT NULL,
    update_time                timestamp(0) DEFAULT NULL,
    process_instance_priority  int          DEFAULT '2',
    worker_group               varchar(64),
    environment_code           bigint       DEFAULT '-1',
    dry_run                    tinyint      DEFAULT '0',
    PRIMARY KEY (id)
);
create index priority_id_index on t_ds_command (process_instance_priority, id);

-- ----------------------------
-- Records of t_ds_command
-- ----------------------------

-- ----------------------------
-- Table structure for t_ds_datasource
-- ----------------------------
DROP TABLE IF EXISTS t_ds_datasource;
CREATE TABLE t_ds_datasource
(
    id                int NOT NULL AUTO_INCREMENT,
    name              varchar(64)  NOT NULL,
    note              varchar(255) DEFAULT NULL,
    type              tinyint      NOT NULL,
    user_id           int          NOT NULL,
    connection_params longvarchar         NOT NULL,
    create_time       timestamp(0) NOT NULL,
    update_time       timestamp(0) DEFAULT NULL,
    PRIMARY KEY (id)
);
alter table t_ds_datasource
    add constraint unique (name, type);

-- ----------------------------
-- Records of t_ds_datasource
-- ----------------------------

-- ----------------------------
-- Table structure for t_ds_error_command
-- ----------------------------
DROP TABLE IF EXISTS t_ds_error_command;
CREATE TABLE t_ds_error_command
(
    id                         int NOT NULL AUTO_INCREMENT,
    command_type               tinyint      DEFAULT NULL,
    executor_id                int          DEFAULT NULL,
    process_definition_code    bigint NOT NULL,
    process_definition_version int          DEFAULT '0',
    process_instance_id        int          DEFAULT '0',
    command_param              longvarchar,
    task_depend_type           tinyint      DEFAULT NULL,
    failure_strategy           tinyint      DEFAULT '0',
    warning_type               tinyint      DEFAULT '0',
    warning_group_id           int          DEFAULT NULL,
    schedule_time              timestamp(0) DEFAULT NULL,
    start_time                 timestamp(0) DEFAULT NULL,
    update_time                timestamp(0) DEFAULT NULL,
    process_instance_priority  int          DEFAULT '2',
    worker_group               varchar(64),
    environment_code           bigint       DEFAULT '-1',
    message                    longvarchar,
    dry_run                    tinyint      DEFAULT '0',
    PRIMARY KEY (id)
);

-- ----------------------------
-- Records of t_ds_error_command
-- ----------------------------

-- ----------------------------
-- Table structure for t_ds_process_definition
-- ----------------------------
DROP TABLE IF EXISTS t_ds_process_definition;
CREATE TABLE t_ds_process_definition
(
    id               int NOT NULL AUTO_INCREMENT,
    code             bigint       NOT NULL,
    name             varchar(255)          DEFAULT NULL,
    version          int                   DEFAULT '0',
    description      longvarchar,
    project_code     bigint       NOT NULL,
    release_state    tinyint               DEFAULT NULL,
    user_id          int                   DEFAULT NULL,
    global_params    longvarchar,
    flag             tinyint               DEFAULT NULL,
    locations        longvarchar,
    warning_group_id int                   DEFAULT NULL,
    timeout          int                   DEFAULT '0',
    tenant_id        int          NOT NULL DEFAULT '-1',
    execution_type   tinyint               DEFAULT '0',
    create_time      timestamp(0) NOT NULL,
    update_time      timestamp(0) NOT NULL,
    PRIMARY KEY (id, code)
);
alter table t_ds_process_definition
    add constraint unique (name, project_code);

-- ----------------------------
-- Records of t_ds_process_definition
-- ----------------------------

-- ----------------------------
-- Table structure for t_ds_process_definition_log
-- ----------------------------
DROP TABLE IF EXISTS t_ds_process_definition_log;
CREATE TABLE t_ds_process_definition_log
(
    id               int NOT NULL AUTO_INCREMENT,
    code             bigint       NOT NULL,
    name             varchar(200)          DEFAULT NULL,
    version          int                   DEFAULT '0',
    description      longvarchar,
    project_code     bigint       NOT NULL,
    release_state    tinyint               DEFAULT NULL,
    user_id          int                   DEFAULT NULL,
    global_params    longvarchar,
    flag             tinyint               DEFAULT NULL,
    locations        longvarchar,
    warning_group_id int                   DEFAULT NULL,
    timeout          int                   DEFAULT '0',
    tenant_id        int          NOT NULL DEFAULT '-1',
    execution_type   tinyint               DEFAULT '0',
    operator         int                   DEFAULT NULL,
    operate_time     timestamp(0)          DEFAULT NULL,
    create_time      timestamp(0) NOT NULL,
    update_time      timestamp(0) NOT NULL,
    PRIMARY KEY (id)
);
alter table t_ds_process_definition_log
    add constraint unique (code, version);

-- ----------------------------
-- Table structure for t_ds_task_definition
-- ----------------------------
DROP TABLE IF EXISTS t_ds_task_definition;
CREATE TABLE t_ds_task_definition
(
    id                      int NOT NULL AUTO_INCREMENT,
    code                    bigint                    NOT NULL,
    name                    varchar(200) DEFAULT NULL,
    version                 int          DEFAULT '0',
    description             longvarchar,
    project_code            bigint                    NOT NULL,
    user_id                 int          DEFAULT NULL,
    task_type               varchar(50)               NOT NULL,
    task_execute_type       int          DEFAULT '0',
    task_params             longvarchar,
    flag                    tinyint      DEFAULT NULL,
    task_priority           tinyint      DEFAULT '2',
    worker_group            varchar(200) DEFAULT NULL,
    environment_code        bigint       DEFAULT '-1',
    fail_retry_times        int          DEFAULT NULL,
    fail_retry_interval     int          DEFAULT NULL,
    timeout_flag            tinyint      DEFAULT '0',
    timeout_notify_strategy tinyint      DEFAULT NULL,
    timeout                 int          DEFAULT '0',
    delay_time              int          DEFAULT '0',
    resource_ids            longvarchar,
    task_group_id           int          DEFAULT NULL,
    task_group_priority     tinyint      DEFAULT '0',
    cpu_quota               int          DEFAULT '-1' NOT NULL,
    memory_max              int          DEFAULT '-1' NOT NULL,
    create_time             timestamp(0)              NOT NULL,
    update_time             timestamp(0)              NOT NULL,
    PRIMARY KEY (id, code)
);

-- ----------------------------
-- Table structure for t_ds_task_definition_log
-- ----------------------------
DROP TABLE IF EXISTS t_ds_task_definition_log;
CREATE TABLE t_ds_task_definition_log
(
    id                      int NOT NULL AUTO_INCREMENT,
    code                    bigint                    NOT NULL,
    name                    varchar(200) DEFAULT NULL,
    version                 int          DEFAULT '0',
    description             longvarchar,
    project_code            bigint                    NOT NULL,
    user_id                 int          DEFAULT NULL,
    task_type               varchar(50)               NOT NULL,
    task_execute_type       int          DEFAULT '0',
    task_params             longvarchar,
    flag                    tinyint      DEFAULT NULL,
    task_priority           tinyint      DEFAULT '2',
    worker_group            varchar(200) DEFAULT NULL,
    environment_code        bigint       DEFAULT '-1',
    fail_retry_times        int          DEFAULT NULL,
    fail_retry_interval     int          DEFAULT NULL,
    timeout_flag            tinyint      DEFAULT '0',
    timeout_notify_strategy tinyint      DEFAULT NULL,
    timeout                 int          DEFAULT '0',
    delay_time              int          DEFAULT '0',
    resource_ids            longvarchar         DEFAULT NULL,
    operator                int          DEFAULT NULL,
    task_group_id           int          DEFAULT NULL,
    task_group_priority     tinyint      DEFAULT 0,
    operate_time            timestamp(0) DEFAULT NULL,
    cpu_quota               int          DEFAULT '-1' NOT NULL,
    memory_max              int          DEFAULT '-1' NOT NULL,
    create_time             timestamp(0)              NOT NULL,
    update_time             timestamp(0)              NOT NULL,
    PRIMARY KEY (id)
);
create index idx_code_version on t_ds_task_definition_log (code, version);
create index idx_project_code on t_ds_task_definition_log (project_code);

-- ----------------------------
-- Table structure for t_ds_process_task_relation
-- ----------------------------
DROP TABLE IF EXISTS t_ds_process_task_relation;
CREATE TABLE t_ds_process_task_relation
(
    id                         int NOT NULL AUTO_INCREMENT,
    name                       varchar(200) DEFAULT NULL,
    project_code               bigint       NOT NULL,
    process_definition_code    bigint       NOT NULL,
    process_definition_version int          NOT NULL,
    pre_task_code              bigint       NOT NULL,
    pre_task_version           int          NOT NULL,
    post_task_code             bigint       NOT NULL,
    post_task_version          int          NOT NULL,
    condition_type             tinyint      DEFAULT NULL,
    condition_params           longvarchar,
    create_time                timestamp(0) NOT NULL,
    update_time                timestamp(0) NOT NULL,
    PRIMARY KEY (id)
);
create index idx_code on t_ds_process_task_relation (project_code, process_definition_code);
create index idx_pre_task_code_version on t_ds_process_task_relation (pre_task_code, pre_task_version);
create index idx_post_task_code_version on t_ds_process_task_relation (post_task_code, post_task_version);



-- ----------------------------
-- Table structure for t_ds_process_task_relation_log
-- ----------------------------
DROP TABLE IF EXISTS t_ds_process_task_relation_log;
CREATE TABLE t_ds_process_task_relation_log
(
    id                         int NOT NULL AUTO_INCREMENT,
    name                       varchar(200) DEFAULT NULL,
    project_code               bigint       NOT NULL,
    process_definition_code    bigint       NOT NULL,
    process_definition_version int          NOT NULL,
    pre_task_code              bigint       NOT NULL,
    pre_task_version           int          NOT NULL,
    post_task_code             bigint       NOT NULL,
    post_task_version          int          NOT NULL,
    condition_type             tinyint      DEFAULT NULL,
    condition_params           longvarchar,
    operator                   int          DEFAULT NULL,
    operate_time               timestamp(0) DEFAULT NULL,
    create_time                timestamp(0) NOT NULL,
    update_time                timestamp(0) NOT NULL,
    PRIMARY KEY (id)
);
create index idx_process_code_version on t_ds_process_task_relation_log (process_definition_code, process_definition_version);

-- ----------------------------
-- Table structure for t_ds_process_instance
-- ----------------------------
DROP TABLE IF EXISTS t_ds_process_instance;
CREATE TABLE t_ds_process_instance
(
    id                         int NOT NULL AUTO_INCREMENT,
    name                       varchar(255)          DEFAULT NULL,
    process_definition_code    bigint       NOT NULL,
    process_definition_version int                   DEFAULT '0',
    state                      tinyint               DEFAULT NULL,
    state_history              longvarchar                  DEFAULT NULL,
    recovery                   tinyint               DEFAULT NULL,
    start_time                 timestamp(0)          DEFAULT NULL,
    end_time                   timestamp(0)          DEFAULT NULL,
    run_times                  int                   DEFAULT NULL,
    host                       varchar(135)          DEFAULT NULL,
    command_type               tinyint               DEFAULT NULL,
    command_param              longvarchar,
    task_depend_type           tinyint               DEFAULT NULL,
    max_try_times              tinyint               DEFAULT '0',
    failure_strategy           tinyint               DEFAULT '0',
    warning_type               tinyint               DEFAULT '0',
    warning_group_id           int                   DEFAULT NULL,
    schedule_time              timestamp(0)          DEFAULT NULL,
    command_start_time         timestamp(0)          DEFAULT NULL,
    global_params              longvarchar,
    flag                       tinyint               DEFAULT '1',
    update_time                timestamp(0) NULL     DEFAULT CURRENT_TIMESTAMP,
    is_sub_process             int                   DEFAULT '0',
    executor_id                int          NOT NULL,
    history_cmd                longvarchar,
    process_instance_priority  int                   DEFAULT '2',
    worker_group               varchar(64)           DEFAULT NULL,
    environment_code           bigint                DEFAULT '-1',
    timeout                    int                   DEFAULT '0',
    tenant_id                  int          NOT NULL DEFAULT '-1',
    var_pool                   longvarchar,
    dry_run                    tinyint               DEFAULT '0',
    next_process_instance_id   int                   DEFAULT '0',
    restart_time               timestamp(0)          DEFAULT NULL,
    PRIMARY KEY (id)
);
create index process_instance_index on t_ds_process_instance (process_definition_code, id);
create index start_time_index on t_ds_process_instance (start_time, end_time);
-- 创建一个触发器，在UPDATE操作时自动更新update_time列
CREATE
OR
REPLACE TRIGGER tr_t_ds_process_instance
    BEFORE
UPDATE ON t_ds_process_instance
    FOR EACH ROW
BEGIN
SET NEW.update_time = CURRENT_TIMESTAMP;
END;
-- ----------------------------
-- Records of t_ds_process_instance
-- ----------------------------

-- ----------------------------
-- Table structure for t_ds_project
-- ----------------------------
DROP TABLE IF EXISTS t_ds_project;
CREATE TABLE t_ds_project
(
    id          int NOT NULL AUTO_INCREMENT,
    name        varchar(100) DEFAULT NULL,
    code        bigint       NOT NULL,
    description varchar(255) DEFAULT NULL,
    user_id     int          DEFAULT NULL,
    flag        tinyint      DEFAULT '1',
    create_time timestamp(0) NOT NULL,
    update_time timestamp(0) DEFAULT NULL,
    PRIMARY KEY (id)
);
create index user_id_index on t_ds_project (user_id);
alter table t_ds_project
    add constraint unique (name);
alter table t_ds_project
    add constraint unique (code);

-- ----------------------------
-- Records of t_ds_project
-- ----------------------------

-- ----------------------------
-- Table structure for t_ds_queue
-- ----------------------------
DROP TABLE IF EXISTS t_ds_queue;
CREATE TABLE t_ds_queue
(
    id          int NOT NULL AUTO_INCREMENT,
    queue_name  varchar(64)  DEFAULT NULL,
    queue       varchar(64)  DEFAULT NULL,
    create_time timestamp(0) DEFAULT NULL,
    update_time timestamp(0) DEFAULT NULL,
    PRIMARY KEY (id)
);
alter table t_ds_queue
    add constraint unique (queue_name);

-- ----------------------------
-- Records of t_ds_queue
-- ----------------------------
INSERT INTO t_ds_queue
VALUES ('1', 'default', 'default', null, null);

-- ----------------------------
-- Table structure for t_ds_relation_datasource_user
-- ----------------------------
DROP TABLE IF EXISTS t_ds_relation_datasource_user;
CREATE TABLE t_ds_relation_datasource_user
(
    id            int NOT NULL AUTO_INCREMENT,
    user_id       int NOT NULL,
    datasource_id int          DEFAULT NULL,
    perm          int          DEFAULT '1',
    create_time   timestamp(0) DEFAULT NULL,
    update_time   timestamp(0) DEFAULT NULL,
    PRIMARY KEY (id)
);

-- ----------------------------
-- Records of t_ds_relation_datasource_user
-- ----------------------------

-- ----------------------------
-- Table structure for t_ds_relation_process_instance
-- ----------------------------
DROP TABLE IF EXISTS t_ds_relation_process_instance;
CREATE TABLE t_ds_relation_process_instance
(
    id                         int NOT NULL AUTO_INCREMENT,
    parent_process_instance_id int DEFAULT NULL,
    parent_task_instance_id    int DEFAULT NULL,
    process_instance_id        int DEFAULT NULL,
    PRIMARY KEY (id)
);
create index idx_parent_process_task on t_ds_relation_process_instance (parent_process_instance_id, parent_task_instance_id);
create index idx_process_instance_id on t_ds_relation_process_instance (process_instance_id);

-- ----------------------------
-- Records of t_ds_relation_process_instance
-- ----------------------------

-- ----------------------------
-- Table structure for t_ds_relation_project_user
-- ----------------------------
DROP TABLE IF EXISTS t_ds_relation_project_user;
CREATE TABLE t_ds_relation_project_user
(
    id          int NOT NULL AUTO_INCREMENT,
    user_id     int NOT NULL,
    project_id  int          DEFAULT NULL,
    perm        int          DEFAULT '1',
    create_time timestamp(0) DEFAULT NULL,
    update_time timestamp(0) DEFAULT NULL,
    PRIMARY KEY (id)
);
alter table t_ds_relation_project_user
    add constraint unique (user_id, project_id);

-- ----------------------------
-- Records of t_ds_relation_project_user
-- ----------------------------

-- ----------------------------
-- Table structure for t_ds_relation_resources_user
-- ----------------------------
DROP TABLE IF EXISTS t_ds_relation_resources_user;
CREATE TABLE t_ds_relation_resources_user
(
    id           int NOT NULL AUTO_INCREMENT,
    user_id      int NOT NULL,
    resources_id int          DEFAULT NULL,
    perm         int          DEFAULT '1',
    create_time  timestamp(0) DEFAULT NULL,
    update_time  timestamp(0) DEFAULT NULL,
    PRIMARY KEY (id)
);

-- ----------------------------
-- Records of t_ds_relation_resources_user
-- ----------------------------

-- ----------------------------
-- Table structure for t_ds_relation_udfs_user
-- ----------------------------
DROP TABLE IF EXISTS t_ds_relation_udfs_user;
CREATE TABLE t_ds_relation_udfs_user
(
    id          int NOT NULL AUTO_INCREMENT,
    user_id     int NOT NULL,
    udf_id      int          DEFAULT NULL,
    perm        int          DEFAULT '1',
    create_time timestamp(0) DEFAULT NULL,
    update_time timestamp(0) DEFAULT NULL,
    PRIMARY KEY (id)
);

-- ----------------------------
-- Table structure for t_ds_resources
-- ----------------------------
DROP TABLE IF EXISTS t_ds_resources;
CREATE TABLE t_ds_resources
(
    id           int NOT NULL AUTO_INCREMENT,
    alias        varchar(64)  DEFAULT NULL,
    file_name    varchar(64)  DEFAULT NULL,
    description  varchar(255) DEFAULT NULL,
    user_id      int          DEFAULT NULL,
    type         tinyint      DEFAULT NULL,
    size         bigint       DEFAULT NULL,
    create_time  timestamp(0) DEFAULT NULL,
    update_time  timestamp(0) DEFAULT NULL,
    pid          int          DEFAULT NULL,
    full_name    varchar(128) DEFAULT NULL,
    is_directory tinyint      DEFAULT NULL,
    PRIMARY KEY (id)
);
alter table t_ds_resources
    add constraint unique (full_name, type);

-- ----------------------------
-- Records of t_ds_resources
-- ----------------------------

-- ----------------------------
-- Table structure for t_ds_schedules
-- ----------------------------
DROP TABLE IF EXISTS t_ds_schedules;
CREATE TABLE t_ds_schedules
(
    id                        int NOT NULL AUTO_INCREMENT,
    process_definition_code   bigint       NOT NULL,
    start_time                timestamp(0) NOT NULL,
    end_time                  timestamp(0) NOT NULL,
    timezone_id               varchar(40) DEFAULT NULL,
    crontab                   varchar(255) NOT NULL,
    failure_strategy          tinyint      NOT NULL,
    user_id                   int          NOT NULL,
    release_state             tinyint      NOT NULL,
    warning_type              tinyint      NOT NULL,
    warning_group_id          int         DEFAULT NULL,
    process_instance_priority int         DEFAULT '2',
    worker_group              varchar(64) DEFAULT '',
    environment_code          bigint      DEFAULT '-1',
    create_time               timestamp(0) NOT NULL,
    update_time               timestamp(0) NOT NULL,
    PRIMARY KEY (id)
);

-- ----------------------------
-- Records of t_ds_schedules
-- ----------------------------

-- ----------------------------
-- Table structure for t_ds_session
-- ----------------------------
DROP TABLE IF EXISTS t_ds_session;
CREATE TABLE t_ds_session
(
    id              varchar(64) NOT NULL,
    user_id         int          DEFAULT NULL,
    ip              varchar(45)  DEFAULT NULL,
    last_login_time timestamp(0) DEFAULT NULL,
    PRIMARY KEY (id)
);

-- ----------------------------
-- Records of t_ds_session
-- ----------------------------

-- ----------------------------
-- Table structure for t_ds_task_instance
-- ----------------------------
DROP TABLE IF EXISTS t_ds_task_instance;
CREATE TABLE t_ds_task_instance
(
    id                      int NOT NULL AUTO_INCREMENT,
    name                    varchar(255) DEFAULT NULL,
    task_type               varchar(50)               NOT NULL,
    task_execute_type       int          DEFAULT '0',
    task_code               bigint                    NOT NULL,
    task_definition_version int          DEFAULT '0',
    process_instance_id     int          DEFAULT NULL,
    state                   tinyint      DEFAULT NULL,
    submit_time             timestamp(0) DEFAULT NULL,
    start_time              timestamp(0) DEFAULT NULL,
    end_time                timestamp(0) DEFAULT NULL,
    host                    varchar(135) DEFAULT NULL,
    execute_path            varchar(200) DEFAULT NULL,
    log_path                longvarchar         DEFAULT NULL,
    alert_flag              tinyint      DEFAULT NULL,
    retry_times             int          DEFAULT '0',
    pid                     int          DEFAULT NULL,
    app_link                longvarchar,
    task_params             longvarchar,
    flag                    tinyint      DEFAULT '1',
    retry_interval          int          DEFAULT NULL,
    max_retry_times         int          DEFAULT NULL,
    task_instance_priority  int          DEFAULT NULL,
    worker_group            varchar(64)  DEFAULT NULL,
    environment_code        bigint       DEFAULT '-1',
    environment_config      longvarchar,
    executor_id             int          DEFAULT NULL,
    first_submit_time       timestamp(0) DEFAULT NULL,
    delay_time              int          DEFAULT '0',
    var_pool                longvarchar,
    task_group_id           int          DEFAULT NULL,
    dry_run                 tinyint      DEFAULT '0',
    cpu_quota               int          DEFAULT '-1' NOT NULL,
    memory_max              int          DEFAULT '-1' NOT NULL,
    PRIMARY KEY (id)
);
create index process_instance_id on t_ds_task_instance (process_instance_id);
create index idx_code_version_i on t_ds_task_instance (task_code, task_definition_version);

-- ----------------------------
-- Records of t_ds_task_instance
-- ----------------------------

-- ----------------------------
-- Table structure for t_ds_tenant
-- ----------------------------
DROP TABLE IF EXISTS t_ds_tenant;
CREATE TABLE t_ds_tenant
(
    id          int NOT NULL AUTO_INCREMENT,
    tenant_code varchar(64)  DEFAULT NULL,
    description varchar(255) DEFAULT NULL,
    queue_id    int          DEFAULT NULL,
    create_time timestamp(0) DEFAULT NULL,
    update_time timestamp(0) DEFAULT NULL,
    PRIMARY KEY (id)
);
alter table t_ds_tenant
    add constraint unique (tenant_code);

INSERT INTO T_DS_TENANT
(TENANT_CODE, DESCRIPTION, QUEUE_ID, CREATE_TIME, UPDATE_TIME)
VALUES('dolphinscheduler', '', 1, '2023-10-10 03:13:09.000', '2023-10-10 03:13:09.000');


-- ----------------------------
-- Records of t_ds_tenant
-- ----------------------------

-- ----------------------------
-- Table structure for t_ds_udfs
-- ----------------------------
DROP TABLE IF EXISTS t_ds_udfs;
CREATE TABLE t_ds_udfs
(
    id            int NOT NULL AUTO_INCREMENT,
    user_id       int          NOT NULL,
    func_name     varchar(100) NOT NULL,
    class_name    varchar(255) NOT NULL,
    type          tinyint      NOT NULL,
    arg_types     varchar(255) DEFAULT NULL,
    database      varchar(255) DEFAULT NULL,
    description   varchar(255) DEFAULT NULL,
    resource_id   int          NOT NULL,
    resource_name varchar(255) NOT NULL,
    create_time   timestamp(0) NOT NULL,
    update_time   timestamp(0) NOT NULL,
    PRIMARY KEY (id)
);
alter table t_ds_udfs
    add constraint unique (func_name);

-- ----------------------------
-- Records of t_ds_udfs
-- ----------------------------

-- ----------------------------
-- Table structure for t_ds_user
-- ----------------------------
DROP TABLE IF EXISTS t_ds_user;
CREATE TABLE t_ds_user
(
    id            int NOT NULL AUTO_INCREMENT,
    user_name     varchar(64)  DEFAULT NULL,
    user_password varchar(64)  DEFAULT NULL,
    user_type     tinyint      DEFAULT NULL,
    email         varchar(64)  DEFAULT NULL,
    phone         varchar(11)  DEFAULT NULL,
    tenant_id     int          DEFAULT NULL,
    create_time   timestamp(0) DEFAULT NULL,
    update_time   timestamp(0) DEFAULT NULL,
    queue         varchar(64)  DEFAULT NULL,
    state         tinyint      DEFAULT '1',
    time_zone     varchar(32)  DEFAULT NULL,
    PRIMARY KEY (id)
);
alter table t_ds_user
    add constraint unique (user_name);

-- ----------------------------
-- Records of t_ds_user
-- ----------------------------

-- ----------------------------
-- Table structure for t_ds_worker_group
-- ----------------------------
DROP TABLE IF EXISTS t_ds_worker_group;
CREATE TABLE t_ds_worker_group
(
    id                bigint NOT NULL AUTO_INCREMENT,
    name              varchar(255) NOT NULL,
    addr_list         longvarchar         NULL DEFAULT NULL,
    create_time       timestamp(0) NULL DEFAULT NULL,
    update_time       timestamp(0) NULL DEFAULT NULL,
    description       longvarchar         NULL DEFAULT NULL,
    other_params_json longvarchar         NULL DEFAULT NULL,
    PRIMARY KEY (id)
);
alter table t_ds_worker_group
    add constraint unique (name);

-- ----------------------------
-- Records of t_ds_worker_group
-- ----------------------------

-- ----------------------------
-- Table structure for t_ds_version
-- ----------------------------
DROP TABLE IF EXISTS t_ds_version;
CREATE TABLE t_ds_version
(
    id      int NOT NULL AUTO_INCREMENT,
    version varchar(200) NOT NULL,
    PRIMARY KEY (id)
);
alter table t_ds_version
    add constraint unique (version);


-- ----------------------------
-- Records of t_ds_version
-- ----------------------------
INSERT INTO t_ds_version
VALUES ('1', '3.1.7');


-- ----------------------------
-- Records of t_ds_alertgroup
-- ----------------------------
INSERT INTO t_ds_alertgroup(alert_instance_ids, create_user_id, group_name, description, create_time,
                            update_time)
VALUES ('1,2', 1, 'default admin warning group', 'default admin warning group', current_timestamp, current_timestamp);

-- ----------------------------
-- Records of t_ds_user
-- ----------------------------
INSERT INTO t_ds_user
VALUES ('1', 'admin', '7ad2410b2f4c074479a8937a28a22b8f', '0', 'xxx@qq.com', '', '0', current_timestamp,
        current_timestamp, null, 1, 'Asia/Shanghai');

-- ----------------------------
-- Table structure for t_ds_plugin_define
-- ----------------------------
-- SET sql_mode = (SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));
DROP TABLE IF EXISTS t_ds_plugin_define;
CREATE TABLE t_ds_plugin_define
(
    id            int NOT NULL AUTO_INCREMENT,
    plugin_name   varchar(100) NOT NULL,
    plugin_type   varchar(100) NOT NULL,
    plugin_params longvarchar,
    create_time   timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_time   timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);
alter table t_ds_plugin_define
    add constraint unique (plugin_name, plugin_type);
-- 创建一个触发器，在UPDATE操作时自动更新update_time列
CREATE
OR
REPLACE TRIGGER tr_t_ds_plugin_define
    BEFORE
UPDATE ON t_ds_plugin_define
    FOR EACH ROW
BEGIN
SET NEW.update_time = CURRENT_TIMESTAMP;
END;


-- ----------------------------
-- Table structure for t_ds_alert_plugin_instance
-- ----------------------------
DROP TABLE IF EXISTS t_ds_alert_plugin_instance;
CREATE TABLE t_ds_alert_plugin_instance
(
    id                     int NOT NULL AUTO_INCREMENT,
    plugin_define_id       int          NOT NULL,
    plugin_instance_params clob,
    create_time            timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP,
    update_time            timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP,
    instance_name          varchar(200)      DEFAULT NULL,
    PRIMARY KEY (id)
);
-- 创建一个触发器，在UPDATE操作时自动更新update_time列
CREATE
OR
REPLACE TRIGGER tr_t_ds_alert_plugin_instance
    BEFORE
UPDATE ON t_ds_alert_plugin_instance
    FOR EACH ROW
BEGIN
SET NEW.update_time = CURRENT_TIMESTAMP;
END;

INSERT INTO T_DS_ALERT_PLUGIN_INSTANCE
(PLUGIN_DEFINE_ID, PLUGIN_INSTANCE_PARAMS, CREATE_TIME, UPDATE_TIME, INSTANCE_NAME)
VALUES(38, '{"headerParams":"{\"Content-Type\": \"application/json\"}","requestType":"POST","WarningType":"failure","bodyParams":"{}","url":"http://192.168.90.139:2189/integration/api/alarm","contentField":"contentField"}', '2023-10-10 06:14:06.000', '2023-10-10 06:14:06.000', 'das-integration');


--
-- Table structure for table t_ds_dq_comparison_type
--
DROP TABLE IF EXISTS t_ds_dq_comparison_type;
CREATE TABLE t_ds_dq_comparison_type
(
    id              int NOT NULL AUTO_INCREMENT,
    type            varchar(100) NOT NULL,
    execute_sql     longvarchar         DEFAULT NULL,
    output_table    varchar(100) DEFAULT NULL,
    name            varchar(100) DEFAULT NULL,
    create_time     timestamp(0) DEFAULT NULL,
    update_time     timestamp(0) DEFAULT NULL,
    is_inner_source tinyint      DEFAULT '0',
    PRIMARY KEY (id)
);

INSERT INTO t_ds_dq_comparison_type
(id, type, execute_sql, output_table, name, create_time, update_time, is_inner_source)
VALUES (1, 'FixValue', NULL, NULL, NULL, current_timestamp, current_timestamp, false);
INSERT INTO t_ds_dq_comparison_type
(id, type, execute_sql, output_table, name, create_time, update_time, is_inner_source)
VALUES (2, 'DailyAvg',
        'select round(avg(statistics_value),2) as day_avg from t_ds_dq_task_statistics_value where data_time >=date_trunc(''DAY'', ${data_time}) and data_time < date_add(date_trunc(''day'', ${data_time}),1) and unique_code = ${unique_code} and statistics_name = ''${statistics_name}''',
        'day_range', 'day_range.day_avg', current_timestamp, current_timestamp, true);
INSERT INTO t_ds_dq_comparison_type
(id, type, execute_sql, output_table, name, create_time, update_time, is_inner_source)
VALUES (3, 'WeeklyAvg',
        'select round(avg(statistics_value),2) as week_avg from t_ds_dq_task_statistics_value where  data_time >= date_trunc(''WEEK'', ${data_time}) and data_time <date_trunc(''day'', ${data_time}) and unique_code = ${unique_code} and statistics_name = ''${statistics_name}''',
        'week_range', 'week_range.week_avg', current_timestamp, current_timestamp, true);
INSERT INTO t_ds_dq_comparison_type
(id, type, execute_sql, output_table, name, create_time, update_time, is_inner_source)
VALUES (4, 'MonthlyAvg',
        'select round(avg(statistics_value),2) as month_avg from t_ds_dq_task_statistics_value where  data_time >= date_trunc(''MONTH'', ${data_time}) and data_time <date_trunc(''day'', ${data_time}) and unique_code = ${unique_code} and statistics_name = ''${statistics_name}''',
        'month_range', 'month_range.month_avg', current_timestamp, current_timestamp, true);
INSERT INTO t_ds_dq_comparison_type
(id, type, execute_sql, output_table, name, create_time, update_time, is_inner_source)
VALUES (5, 'Last7DayAvg',
        'select round(avg(statistics_value),2) as last_7_avg from t_ds_dq_task_statistics_value where  data_time >= date_add(date_trunc(''day'', ${data_time}),-7) and  data_time <date_trunc(''day'', ${data_time}) and unique_code = ${unique_code} and statistics_name = ''${statistics_name}''',
        'last_seven_days', 'last_seven_days.last_7_avg', current_timestamp, current_timestamp, true);
INSERT INTO t_ds_dq_comparison_type
(id, type, execute_sql, output_table, name, create_time, update_time, is_inner_source)
VALUES (6, 'Last30DayAvg',
        'select round(avg(statistics_value),2) as last_30_avg from t_ds_dq_task_statistics_value where  data_time >= date_add(date_trunc(''day'', ${data_time}),-30) and  data_time < date_trunc(''day'', ${data_time}) and unique_code = ${unique_code} and statistics_name = ''${statistics_name}''',
        'last_thirty_days', 'last_thirty_days.last_30_avg', current_timestamp, current_timestamp, true);
INSERT INTO t_ds_dq_comparison_type
(id, type, execute_sql, output_table, name, create_time, update_time, is_inner_source)
VALUES (7, 'SrcTableTotalRows', 'SELECT COUNT(*) AS total FROM ${src_table} WHERE (${src_filter})', 'total_count',
        'total_count.total', current_timestamp, current_timestamp, false);
INSERT INTO t_ds_dq_comparison_type
(id, type, execute_sql, output_table, name, create_time, update_time, is_inner_source)
VALUES (8, 'TargetTableTotalRows', 'SELECT COUNT(*) AS total FROM ${target_table} WHERE (${target_filter})',
        'total_count', 'total_count.total', current_timestamp, current_timestamp, false);

--
-- Table structure for table t_ds_dq_execute_result
--
DROP TABLE IF EXISTS t_ds_dq_execute_result;
CREATE TABLE t_ds_dq_execute_result
(
    id                    int NOT NULL AUTO_INCREMENT,
    process_definition_id int          DEFAULT NULL,
    process_instance_id   int          DEFAULT NULL,
    task_instance_id      int          DEFAULT NULL,
    rule_type             int          DEFAULT NULL,
    rule_name             varchar(255) DEFAULT NULL,
    statistics_value      double       DEFAULT NULL,
    comparison_value      double       DEFAULT NULL,
    check_type            int          DEFAULT NULL,
    threshold             double       DEFAULT NULL,
    operator              int          DEFAULT NULL,
    failure_strategy      int          DEFAULT NULL,
    state                 int          DEFAULT NULL,
    user_id               int          DEFAULT NULL,
    comparison_type       int          DEFAULT NULL,
    error_output_path     longvarchar         DEFAULT NULL,
    create_time           timestamp(0) DEFAULT NULL,
    update_time           timestamp(0) DEFAULT NULL,
    PRIMARY KEY (id)
);

--
-- Table structure for table t_ds_dq_rule
--
DROP TABLE IF EXISTS t_ds_dq_rule;
CREATE TABLE t_ds_dq_rule
(
    id          int NOT NULL AUTO_INCREMENT,
    name        varchar(100) DEFAULT NULL,
    type        int          DEFAULT NULL,
    user_id     int          DEFAULT NULL,
    create_time timestamp(0) DEFAULT NULL,
    update_time timestamp(0) DEFAULT NULL,
    PRIMARY KEY (id)
);

INSERT INTO t_ds_dq_rule
    (id, name, type, user_id, create_time, update_time)
VALUES (1, '$t(null_check)', 0, 1, current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule
    (id, name, type, user_id, create_time, update_time)
VALUES (2, '$t(custom_sql)', 1, 1, current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule
    (id, name, type, user_id, create_time, update_time)
VALUES (3, '$t(multi_table_accuracy)', 2, 1, current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule
    (id, name, type, user_id, create_time, update_time)
VALUES (4, '$t(multi_table_value_comparison)', 3, 1, current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule
    (id, name, type, user_id, create_time, update_time)
VALUES (5, '$t(field_length_check)', 0, 1, current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule
    (id, name, type, user_id, create_time, update_time)
VALUES (6, '$t(uniqueness_check)', 0, 1, current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule
    (id, name, type, user_id, create_time, update_time)
VALUES (7, '$t(regexp_check)', 0, 1, current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule
    (id, name, type, user_id, create_time, update_time)
VALUES (8, '$t(timeliness_check)', 0, 1, current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule
    (id, name, type, user_id, create_time, update_time)
VALUES (9, '$t(enumeration_check)', 0, 1, current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule
    (id, name, type, user_id, create_time, update_time)
VALUES (10, '$t(table_count_check)', 0, 1, current_timestamp, current_timestamp);

--
-- Table structure for table t_ds_dq_rule_execute_sql
--
DROP TABLE IF EXISTS t_ds_dq_rule_execute_sql;
CREATE TABLE t_ds_dq_rule_execute_sql
(
    id                  int NOT NULL AUTO_INCREMENT,
    index_sql           int          DEFAULT NULL,
    sql                 longvarchar         DEFAULT NULL,
    table_alias         varchar(255) DEFAULT NULL,
    type                int          DEFAULT NULL,
    is_error_output_sql tinyint      DEFAULT '0',
    create_time         timestamp(0) DEFAULT NULL,
    update_time         timestamp(0) DEFAULT NULL,
    PRIMARY KEY (id)
);

INSERT INTO t_ds_dq_rule_execute_sql
(id, index_sql, sql, table_alias, type, is_error_output_sql, create_time, update_time)
VALUES (1, 1, 'SELECT COUNT(*) AS nulls FROM null_items', 'null_count', 1, false, current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule_execute_sql
(id, index_sql, sql, table_alias, type, is_error_output_sql, create_time, update_time)
VALUES (2, 1, 'SELECT COUNT(*) AS total FROM ${src_table} WHERE (${src_filter})', 'total_count', 2, false,
        current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule_execute_sql
(id, index_sql, sql, table_alias, type, is_error_output_sql, create_time, update_time)
VALUES (3, 1, 'SELECT COUNT(*) AS miss from miss_items', 'miss_count', 1, false, current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule_execute_sql
(id, index_sql, sql, table_alias, type, is_error_output_sql, create_time, update_time)
VALUES (4, 1, 'SELECT COUNT(*) AS valids FROM invalid_length_items', 'invalid_length_count', 1, false,
        current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule_execute_sql
(id, index_sql, sql, table_alias, type, is_error_output_sql, create_time, update_time)
VALUES (5, 1, 'SELECT COUNT(*) AS total FROM ${target_table} WHERE (${target_filter})', 'total_count', 2, false,
        current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule_execute_sql
(id, index_sql, sql, table_alias, type, is_error_output_sql, create_time, update_time)
VALUES (6, 1, 'SELECT ${src_field} FROM ${src_table} group by ${src_field} having count(*) > 1', 'duplicate_items', 0,
        true, current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule_execute_sql
(id, index_sql, sql, table_alias, type, is_error_output_sql, create_time, update_time)
VALUES (7, 1, 'SELECT COUNT(*) AS duplicates FROM duplicate_items', 'duplicate_count', 1, false, current_timestamp,
        current_timestamp);
INSERT INTO t_ds_dq_rule_execute_sql
(id, index_sql, sql, table_alias, type, is_error_output_sql, create_time, update_time)
VALUES (8, 1,
        'SELECT ${src_table}.* FROM (SELECT * FROM ${src_table} WHERE (${src_filter})) ${src_table} LEFT JOIN (SELECT * FROM ${target_table} WHERE (${target_filter})) ${target_table} ON ${on_clause} WHERE ${where_clause}',
        'miss_items', 0, true, current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule_execute_sql
(id, index_sql, sql, table_alias, type, is_error_output_sql, create_time, update_time)
VALUES (9, 1, 'SELECT * FROM ${src_table} WHERE (${src_field} not regexp ''${regexp_pattern}'') AND (${src_filter}) ',
        'regexp_items', 0, true, current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule_execute_sql
(id, index_sql, sql, table_alias, type, is_error_output_sql, create_time, update_time)
VALUES (10, 1, 'SELECT COUNT(*) AS regexps FROM regexp_items', 'regexp_count', 1, false, current_timestamp,
        current_timestamp);
INSERT INTO t_ds_dq_rule_execute_sql
(id, index_sql, sql, table_alias, type, is_error_output_sql, create_time, update_time)
VALUES (11, 1,
        'SELECT * FROM ${src_table} WHERE (to_unix_timestamp(${src_field}, ''${timestamp_format}'')-to_unix_timestamp(''${deadline}'', ''${timestamp_format}'') <= 0) AND (to_unix_timestamp(${src_field}, ''${timestamp_format}'')-to_unix_timestamp(''${begin_time}'', ''${timestamp_format}'') >= 0) AND (${src_filter}) ',
        'timeliness_items', 0, 1, current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule_execute_sql
(id, index_sql, sql, table_alias, type, is_error_output_sql, create_time, update_time)
VALUES (12, 1, 'SELECT COUNT(*) AS timeliness FROM timeliness_items', 'timeliness_count', 1, false, current_timestamp,
        current_timestamp);
INSERT INTO t_ds_dq_rule_execute_sql
(id, index_sql, sql, table_alias, type, is_error_output_sql, create_time, update_time)
VALUES (13, 1,
        'SELECT * FROM ${src_table} where (${src_field} not in ( ${enum_list} ) or ${src_field} is null) AND (${src_filter}) ',
        'enum_items', 0, true, current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule_execute_sql
(id, index_sql, sql, table_alias, type, is_error_output_sql, create_time, update_time)
VALUES (14, 1, 'SELECT COUNT(*) AS enums FROM enum_items', 'enum_count', 1, false, current_timestamp,
        current_timestamp);
INSERT INTO t_ds_dq_rule_execute_sql
(id, index_sql, sql, table_alias, type, is_error_output_sql, create_time, update_time)
VALUES (15, 1, 'SELECT COUNT(*) AS total FROM ${src_table} WHERE (${src_filter})', 'table_count', 1, false,
        current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule_execute_sql
(id, index_sql, sql, table_alias, type, is_error_output_sql, create_time, update_time)
VALUES (16, 1, 'SELECT * FROM ${src_table} WHERE (${src_field} is null or ${src_field} = '''') AND (${src_filter})',
        'null_items', 0, true, current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule_execute_sql
(id, index_sql, sql, table_alias, type, is_error_output_sql, create_time, update_time)
VALUES (17, 1,
        'SELECT * FROM ${src_table} WHERE (length(${src_field}) ${logic_operator} ${field_length}) AND (${src_filter})',
        'invalid_length_items', 0, true, current_timestamp, current_timestamp);

--
-- Table structure for table t_ds_dq_rule_input_entry
--
DROP TABLE IF EXISTS t_ds_dq_rule_input_entry;
CREATE TABLE t_ds_dq_rule_input_entry
(
    id                 int NOT NULL AUTO_INCREMENT,
    field              varchar(255) DEFAULT NULL,
    type               varchar(255) DEFAULT NULL,
    title              varchar(255) DEFAULT NULL,
    value              varchar(255) DEFAULT NULL,
    options            longvarchar         DEFAULT NULL,
    placeholder        varchar(255) DEFAULT NULL,
    option_source_type int          DEFAULT NULL,
    value_type         int          DEFAULT NULL,
    input_type         int          DEFAULT NULL,
    is_show            tinyint      DEFAULT '1',
    can_edit           tinyint      DEFAULT '1',
    is_emit            tinyint      DEFAULT '0',
    is_validate        tinyint      DEFAULT '1',
    create_time        timestamp(0) DEFAULT NULL,
    update_time        timestamp(0) DEFAULT NULL,
    PRIMARY KEY (id)
);

INSERT INTO t_ds_dq_rule_input_entry
(id, field, type, title, value, options, placeholder, option_source_type, value_type, input_type, is_show, can_edit,
 is_emit, is_validate, create_time, update_time)
VALUES (1, 'src_connector_type', 'select', '$t(src_connector_type)', '',
        '[{"label":"HIVE","value":"HIVE"},{"label":"JDBC","value":"JDBC"}]', 'please select source connector type', 2,
        2, 0, 1, 1, 1, 0, current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule_input_entry
(id, field, type, title, value, options, placeholder, option_source_type, value_type, input_type, is_show, can_edit,
 is_emit, is_validate, create_time, update_time)
VALUES (2, 'src_datasource_id', 'select', '$t(src_datasource_id)', '', NULL, 'please select source datasource id', 1, 2,
        0, 1, 1, 1, 0, current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule_input_entry
(id, field, type, title, value, options, placeholder, option_source_type, value_type, input_type, is_show, can_edit,
 is_emit, is_validate, create_time, update_time)
VALUES (3, 'src_table', 'select', '$t(src_table)', NULL, NULL, 'Please enter source table name', 0, 0, 0, 1, 1, 1, 1,
        current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule_input_entry
(id, field, type, title, value, options, placeholder, option_source_type, value_type, input_type, is_show, can_edit,
 is_emit, is_validate, create_time, update_time)
VALUES (4, 'src_filter', 'input', '$t(src_filter)', NULL, NULL, 'Please enter filter expression', 0, 3, 0, 1, 1, 0, 0,
        current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule_input_entry
(id, field, type, title, value, options, placeholder, option_source_type, value_type, input_type, is_show, can_edit,
 is_emit, is_validate, create_time, update_time)
VALUES (5, 'src_field', 'select', '$t(src_field)', NULL, NULL, 'Please enter column, only single column is supported',
        0, 0, 0, 1, 1, 0, 1, current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule_input_entry
(id, field, type, title, value, options, placeholder, option_source_type, value_type, input_type, is_show, can_edit,
 is_emit, is_validate, create_time, update_time)
VALUES (6, 'statistics_name', 'input', '$t(statistics_name)', NULL, NULL,
        'Please enter statistics name, the alias in statistics execute sql', 0, 0, 1, 0, 0, 0, 1, current_timestamp,
        current_timestamp);
INSERT INTO t_ds_dq_rule_input_entry
(id, field, type, title, value, options, placeholder, option_source_type, value_type, input_type, is_show, can_edit,
 is_emit, is_validate, create_time, update_time)
VALUES (7, 'check_type', 'select', '$t(check_type)', '0',
        '[{"label":"Expected - Actual","value":"0"},{"label":"Actual - Expected","value":"1"},{"label":"Actual / Expected","value":"2"},{"label":"(Expected - Actual) / Expected","value":"3"}]',
        'please select check type', 0, 0, 3, 1, 1, 1, 0, current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule_input_entry
(id, field, type, title, value, options, placeholder, option_source_type, value_type, input_type, is_show, can_edit,
 is_emit, is_validate, create_time, update_time)
VALUES (8, 'operator', 'select', '$t(operator)', '0',
        '[{"label":"=","value":"0"},{"label":"<","value":"1"},{"label":"<=","value":"2"},{"label":">","value":"3"},{"label":">=","value":"4"},{"label":"!=","value":"5"}]',
        'please select operator', 0, 0, 3, 1, 1, 0, 0, current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule_input_entry
(id, field, type, title, value, options, placeholder, option_source_type, value_type, input_type, is_show, can_edit,
 is_emit, is_validate, create_time, update_time)
VALUES (9, 'threshold', 'input', '$t(threshold)', NULL, NULL, 'Please enter threshold, number is needed', 0, 2, 3, 1, 1,
        0, 1, current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule_input_entry
(id, field, type, title, value, options, placeholder, option_source_type, value_type, input_type, is_show, can_edit,
 is_emit, is_validate, create_time, update_time)
VALUES (10, 'failure_strategy', 'select', '$t(failure_strategy)', '0',
        '[{"label":"Alert","value":"0"},{"label":"Block","value":"1"}]', 'please select failure strategy', 0, 0, 3, 1,
        1, 0, 0, current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule_input_entry
(id, field, type, title, value, options, placeholder, option_source_type, value_type, input_type, is_show, can_edit,
 is_emit, is_validate, create_time, update_time)
VALUES (11, 'target_connector_type', 'select', '$t(target_connector_type)', '',
        '[{"label":"HIVE","value":"HIVE"},{"label":"JDBC","value":"JDBC"}]', 'Please select target connector type', 2,
        0, 0, 1, 1, 1, 0, current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule_input_entry
(id, field, type, title, value, options, placeholder, option_source_type, value_type, input_type, is_show, can_edit,
 is_emit, is_validate, create_time, update_time)
VALUES (12, 'target_datasource_id', 'select', '$t(target_datasource_id)', '', NULL, 'Please select target datasource',
        1, 2, 0, 1, 1, 1, 0, current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule_input_entry
(id, field, type, title, value, options, placeholder, option_source_type, value_type, input_type, is_show, can_edit,
 is_emit, is_validate, create_time, update_time)
VALUES (13, 'target_table', 'select', '$t(target_table)', NULL, NULL, 'Please enter target table', 0, 0, 0, 1, 1, 1, 1,
        current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule_input_entry
(id, field, type, title, value, options, placeholder, option_source_type, value_type, input_type, is_show, can_edit,
 is_emit, is_validate, create_time, update_time)
VALUES (14, 'target_filter', 'input', '$t(target_filter)', NULL, NULL, 'Please enter target filter expression', 0, 3, 0,
        1, 1, 0, 0, current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule_input_entry
(id, field, type, title, value, options, placeholder, option_source_type, value_type, input_type, is_show, can_edit,
 is_emit, is_validate, create_time, update_time)
VALUES (15, 'mapping_columns', 'group', '$t(mapping_columns)', NULL,
        '[{"field":"src_field","props":{"placeholder":"Please input src field","rows":0,"disabled":false,"size":"small"},"type":"input","title":"src_field"},{"field":"operator","props":{"placeholder":"Please input operator","rows":0,"disabled":false,"size":"small"},"type":"input","title":"operator"},{"field":"target_field","props":{"placeholder":"Please input target field","rows":0,"disabled":false,"size":"small"},"type":"input","title":"target_field"}]',
        'please enter mapping columns', 0, 0, 0, 1, 1, 0, 0, current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule_input_entry
(id, field, type, title, value, options, placeholder, option_source_type, value_type, input_type, is_show, can_edit,
 is_emit, is_validate, create_time, update_time)
VALUES (16, 'statistics_execute_sql', 'blobarea', '$t(statistics_execute_sql)', NULL, NULL,
        'Please enter statistics execute sql', 0, 3, 0, 1, 1, 0, 1, current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule_input_entry
(id, field, type, title, value, options, placeholder, option_source_type, value_type, input_type, is_show, can_edit,
 is_emit, is_validate, create_time, update_time)
VALUES (17, 'comparison_name', 'input', '$t(comparison_name)', NULL, NULL,
        'Please enter comparison name, the alias in comparison execute sql', 0, 0, 0, 0, 0, 0, 1, current_timestamp,
        current_timestamp);
INSERT INTO t_ds_dq_rule_input_entry
(id, field, type, title, value, options, placeholder, option_source_type, value_type, input_type, is_show, can_edit,
 is_emit, is_validate, create_time, update_time)
VALUES (18, 'comparison_execute_sql', 'blobarea', '$t(comparison_execute_sql)', NULL, NULL,
        'Please enter comparison execute sql', 0, 3, 0, 1, 1, 0, 1, current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule_input_entry
(id, field, type, title, value, options, placeholder, option_source_type, value_type, input_type, is_show, can_edit,
 is_emit, is_validate, create_time, update_time)
VALUES (19, 'comparison_type', 'select', '$t(comparison_type)', '', NULL, 'Please enter comparison title', 3, 0, 2, 1,
        0, 1, 0, current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule_input_entry
(id, field, type, title, value, options, placeholder, option_source_type, value_type, input_type, is_show, can_edit,
 is_emit, is_validate, create_time, update_time)
VALUES (20, 'writer_connector_type', 'select', '$t(writer_connector_type)', '',
        '[{"label":"MYSQL","value":"0"},{"label":"POSTGRESQL","value":"1"}]', 'please select writer connector type', 0,
        2, 0, 1, 1, 1, 0, current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule_input_entry
(id, field, type, title, value, options, placeholder, option_source_type, value_type, input_type, is_show, can_edit,
 is_emit, is_validate, create_time, update_time)
VALUES (21, 'writer_datasource_id', 'select', '$t(writer_datasource_id)', '', NULL,
        'please select writer datasource id', 1, 2, 0, 1, 1, 0, 0, current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule_input_entry
(id, field, type, title, value, options, placeholder, option_source_type, value_type, input_type, is_show, can_edit,
 is_emit, is_validate, create_time, update_time)
VALUES (22, 'target_field', 'select', '$t(target_field)', NULL, NULL,
        'Please enter column, only single column is supported', 0, 0, 0, 1, 1, 0, 0, current_timestamp,
        current_timestamp);
INSERT INTO t_ds_dq_rule_input_entry
(id, field, type, title, value, options, placeholder, option_source_type, value_type, input_type, is_show, can_edit,
 is_emit, is_validate, create_time, update_time)
VALUES (23, 'field_length', 'input', '$t(field_length)', NULL, NULL, 'Please enter length limit', 0, 3, 0, 1, 1, 0, 0,
        current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule_input_entry
(id, field, type, title, value, options, placeholder, option_source_type, value_type, input_type, is_show, can_edit,
 is_emit, is_validate, create_time, update_time)
VALUES (24, 'logic_operator', 'select', '$t(logic_operator)', '=',
        '[{"label":"=","value":"="},{"label":"<","value":"<"},{"label":"<=","value":"<="},{"label":">","value":">"},{"label":">=","value":">="},{"label":"<>","value":"<>"}]',
        'please select logic operator', 0, 0, 3, 1, 1, 0, 0, current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule_input_entry
(id, field, type, title, value, options, placeholder, option_source_type, value_type, input_type, is_show, can_edit,
 is_emit, is_validate, create_time, update_time)
VALUES (25, 'regexp_pattern', 'input', '$t(regexp_pattern)', NULL, NULL, 'Please enter regexp pattern', 0, 0, 0, 1, 1,
        0, 0, current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule_input_entry
(id, field, type, title, value, options, placeholder, option_source_type, value_type, input_type, is_show, can_edit,
 is_emit, is_validate, create_time, update_time)
VALUES (26, 'deadline', 'input', '$t(deadline)', NULL, NULL, 'Please enter deadline', 0, 0, 0, 1, 1, 0, 0,
        current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule_input_entry
(id, field, type, title, value, options, placeholder, option_source_type, value_type, input_type, is_show, can_edit,
 is_emit, is_validate, create_time, update_time)
VALUES (27, 'timestamp_format', 'input', '$t(timestamp_format)', NULL, NULL, 'Please enter timestamp format', 0, 0, 0,
        1, 1, 0, 0, current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule_input_entry
(id, field, type, title, value, options, placeholder, option_source_type, value_type, input_type, is_show, can_edit,
 is_emit, is_validate, create_time, update_time)
VALUES (28, 'enum_list', 'input', '$t(enum_list)', NULL, NULL, 'Please enter enumeration', 0, 0, 0, 1, 1, 0, 0,
        current_timestamp, current_timestamp);
INSERT INTO t_ds_dq_rule_input_entry
(id, field, type, title, value, options, placeholder, option_source_type, value_type, input_type, is_show, can_edit,
 is_emit, is_validate, create_time, update_time)
VALUES (29, 'begin_time', 'input', '$t(begin_time)', NULL, NULL, 'Please enter begin time', 0, 0, 0, 1, 1, 0, 0,
        current_timestamp, current_timestamp);

--
-- Table structure for table t_ds_dq_task_statistics_value
--
DROP TABLE IF EXISTS t_ds_dq_task_statistics_value;
CREATE TABLE t_ds_dq_task_statistics_value
(
    id                    int NOT NULL AUTO_INCREMENT,
    process_definition_id int          DEFAULT NULL,
    task_instance_id      int          DEFAULT NULL,
    rule_id               int          NOT NULL,
    unique_code           varchar(255) NULL,
    statistics_name       varchar(255) NULL,
    statistics_value      double       NULL,
    data_time             timestamp(0) DEFAULT NULL,
    create_time           timestamp(0) DEFAULT NULL,
    update_time           timestamp(0) DEFAULT NULL,
    PRIMARY KEY (id)
);

--
-- Table structure for table t_ds_relation_rule_execute_sql
--
DROP TABLE IF EXISTS t_ds_relation_rule_execute_sql;
CREATE TABLE t_ds_relation_rule_execute_sql
(
    id             int NOT NULL AUTO_INCREMENT,
    rule_id        int DEFAULT NULL,
    execute_sql_id int DEFAULT NULL,
    create_time    timestamp(0) NULL,
    update_time    timestamp(0) NULL,
    PRIMARY KEY (id)
);

INSERT INTO t_ds_relation_rule_execute_sql
    (id, rule_id, execute_sql_id, create_time, update_time)
VALUES (1, 1, 1, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_execute_sql
    (id, rule_id, execute_sql_id, create_time, update_time)
VALUES (3, 5, 4, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_execute_sql
    (id, rule_id, execute_sql_id, create_time, update_time)
VALUES (2, 3, 3, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_execute_sql
    (id, rule_id, execute_sql_id, create_time, update_time)
VALUES (4, 3, 8, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_execute_sql
    (id, rule_id, execute_sql_id, create_time, update_time)
VALUES (5, 6, 6, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_execute_sql
    (id, rule_id, execute_sql_id, create_time, update_time)
VALUES (6, 6, 7, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_execute_sql
    (id, rule_id, execute_sql_id, create_time, update_time)
VALUES (7, 7, 9, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_execute_sql
    (id, rule_id, execute_sql_id, create_time, update_time)
VALUES (8, 7, 10, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_execute_sql
    (id, rule_id, execute_sql_id, create_time, update_time)
VALUES (9, 8, 11, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_execute_sql
    (id, rule_id, execute_sql_id, create_time, update_time)
VALUES (10, 8, 12, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_execute_sql
    (id, rule_id, execute_sql_id, create_time, update_time)
VALUES (11, 9, 13, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_execute_sql
    (id, rule_id, execute_sql_id, create_time, update_time)
VALUES (12, 9, 14, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_execute_sql
    (id, rule_id, execute_sql_id, create_time, update_time)
VALUES (13, 10, 15, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_execute_sql
    (id, rule_id, execute_sql_id, create_time, update_time)
VALUES (14, 1, 16, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_execute_sql
    (id, rule_id, execute_sql_id, create_time, update_time)
VALUES (15, 5, 17, current_timestamp, current_timestamp);

--
-- Table structure for table t_ds_relation_rule_input_entry
--
DROP TABLE IF EXISTS t_ds_relation_rule_input_entry;
CREATE TABLE t_ds_relation_rule_input_entry
(
    id                  int NOT NULL AUTO_INCREMENT,
    rule_id             int          DEFAULT NULL,
    rule_input_entry_id int          DEFAULT NULL,
    values_map          longvarchar         DEFAULT NULL,
    index_values        int          DEFAULT NULL,
    create_time         timestamp(0) DEFAULT NULL,
    update_time         timestamp(0) DEFAULT NULL,
    PRIMARY KEY (id)
);

INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (1, 1, 1, NULL, 1, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (2, 1, 2, NULL, 2, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (3, 1, 3, NULL, 3, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (4, 1, 4, NULL, 4, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (5, 1, 5, NULL, 5, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (6, 1, 6, '{"statistics_name":"null_count.nulls"}', 6, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (7, 1, 7, NULL, 7, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (8, 1, 8, NULL, 8, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (9, 1, 9, NULL, 9, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (10, 1, 10, NULL, 10, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (11, 1, 17, '', 11, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (12, 1, 19, NULL, 12, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (13, 2, 1, NULL, 1, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (14, 2, 2, NULL, 2, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (15, 2, 3, NULL, 3, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (16, 2, 6, '{"is_show":"true","can_edit":"true"}', 4, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (17, 2, 16, NULL, 5, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (18, 2, 4, NULL, 6, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (19, 2, 7, NULL, 7, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (20, 2, 8, NULL, 8, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (21, 2, 9, NULL, 9, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (22, 2, 10, NULL, 10, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (24, 2, 19, NULL, 12, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (25, 3, 1, NULL, 1, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (26, 3, 2, NULL, 2, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (27, 3, 3, NULL, 3, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (28, 3, 4, NULL, 4, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (29, 3, 11, NULL, 5, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (30, 3, 12, NULL, 6, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (31, 3, 13, NULL, 7, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (32, 3, 14, NULL, 8, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (33, 3, 15, NULL, 9, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (34, 3, 7, NULL, 10, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (35, 3, 8, NULL, 11, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (36, 3, 9, NULL, 12, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (37, 3, 10, NULL, 13, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (38, 3, 17, '{"comparison_name":"total_count.total"}', 14, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (39, 3, 19, NULL, 15, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (40, 4, 1, NULL, 1, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (41, 4, 2, NULL, 2, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (42, 4, 3, NULL, 3, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (43, 4, 6, '{"is_show":"true","can_edit":"true"}', 4, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (44, 4, 16, NULL, 5, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (45, 4, 11, NULL, 6, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (46, 4, 12, NULL, 7, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (47, 4, 13, NULL, 8, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (48, 4, 17, '{"is_show":"true","can_edit":"true"}', 9, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (49, 4, 18, NULL, 10, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (50, 4, 7, NULL, 11, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (51, 4, 8, NULL, 12, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (52, 4, 9, NULL, 13, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (53, 4, 10, NULL, 14, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (62, 3, 6, '{"statistics_name":"miss_count.miss"}', 18, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (63, 5, 1, NULL, 1, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (64, 5, 2, NULL, 2, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (65, 5, 3, NULL, 3, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (66, 5, 4, NULL, 4, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (67, 5, 5, NULL, 5, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (68, 5, 6, '{"statistics_name":"invalid_length_count.valids"}', 6, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (69, 5, 24, NULL, 7, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (70, 5, 23, NULL, 8, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (71, 5, 7, NULL, 9, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (72, 5, 8, NULL, 10, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (73, 5, 9, NULL, 11, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (74, 5, 10, NULL, 12, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (75, 5, 17, '', 13, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (76, 5, 19, NULL, 14, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (79, 6, 1, NULL, 1, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (80, 6, 2, NULL, 2, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (81, 6, 3, NULL, 3, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (82, 6, 4, NULL, 4, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (83, 6, 5, NULL, 5, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (84, 6, 6, '{"statistics_name":"duplicate_count.duplicates"}', 6, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (85, 6, 7, NULL, 7, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (86, 6, 8, NULL, 8, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (87, 6, 9, NULL, 9, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (88, 6, 10, NULL, 10, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (89, 6, 17, '', 11, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (90, 6, 19, NULL, 12, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (93, 7, 1, NULL, 1, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (94, 7, 2, NULL, 2, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (95, 7, 3, NULL, 3, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (96, 7, 4, NULL, 4, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (97, 7, 5, NULL, 5, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (98, 7, 6, '{"statistics_name":"regexp_count.regexps"}', 6, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (99, 7, 25, NULL, 5, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (100, 7, 7, NULL, 7, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (101, 7, 8, NULL, 8, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (102, 7, 9, NULL, 9, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (103, 7, 10, NULL, 10, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (104, 7, 17, NULL, 11, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (105, 7, 19, NULL, 12, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (108, 8, 1, NULL, 1, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (109, 8, 2, NULL, 2, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (110, 8, 3, NULL, 3, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (111, 8, 4, NULL, 4, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (112, 8, 5, NULL, 5, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (113, 8, 6, '{"statistics_name":"timeliness_count.timeliness"}', 6, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (114, 8, 26, NULL, 8, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (115, 8, 27, NULL, 9, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (116, 8, 7, NULL, 10, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (117, 8, 8, NULL, 11, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (118, 8, 9, NULL, 12, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (119, 8, 10, NULL, 13, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (120, 8, 17, NULL, 14, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (121, 8, 19, NULL, 15, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (124, 9, 1, NULL, 1, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (125, 9, 2, NULL, 2, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (126, 9, 3, NULL, 3, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (127, 9, 4, NULL, 4, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (128, 9, 5, NULL, 5, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (129, 9, 6, '{"statistics_name":"enum_count.enums"}', 6, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (130, 9, 28, NULL, 7, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (131, 9, 7, NULL, 8, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (132, 9, 8, NULL, 9, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (133, 9, 9, NULL, 10, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (134, 9, 10, NULL, 11, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (135, 9, 17, NULL, 12, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (136, 9, 19, NULL, 13, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (139, 10, 1, NULL, 1, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (140, 10, 2, NULL, 2, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (141, 10, 3, NULL, 3, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (142, 10, 4, NULL, 4, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (143, 10, 6, '{"statistics_name":"table_count.total"}', 6, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (144, 10, 7, NULL, 7, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (145, 10, 8, NULL, 8, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (146, 10, 9, NULL, 9, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (147, 10, 10, NULL, 10, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (148, 10, 17, NULL, 11, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (149, 10, 19, NULL, 12, current_timestamp, current_timestamp);
INSERT INTO t_ds_relation_rule_input_entry
(id, rule_id, rule_input_entry_id, values_map, index_values, create_time, update_time)
VALUES (150, 8, 29, NULL, 7, current_timestamp, current_timestamp);

-- ----------------------------
-- Table structure for t_ds_environment
-- ----------------------------
DROP TABLE IF EXISTS t_ds_environment;
CREATE TABLE t_ds_environment
(
    id          bigint NOT NULL AUTO_INCREMENT,
    code        bigint            DEFAULT NULL,
    name        varchar(100) NOT NULL,
    config      longvarchar         NULL DEFAULT NULL,
    description longvarchar         NULL DEFAULT NULL,
    operator    int               DEFAULT NULL,
    create_time timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP,
    update_time timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);
alter table t_ds_environment
    add constraint unique (name);
alter table t_ds_environment
    add constraint unique (code);
CREATE
OR
REPLACE TRIGGER tr_t_ds_environment
    BEFORE
UPDATE ON t_ds_environment
    FOR EACH ROW
BEGIN
SET NEW.update_time = CURRENT_TIMESTAMP;
END;

-- ----------------------------
-- Table structure for t_ds_environment_worker_group_relation
-- ----------------------------
DROP TABLE IF EXISTS t_ds_environment_worker_group_relation;
CREATE TABLE t_ds_environment_worker_group_relation
(
    id               bigint NOT NULL AUTO_INCREMENT,
    environment_code bigint       NOT NULL,
    worker_group     varchar(255) NOT NULL,
    operator         int               DEFAULT NULL,
    create_time      timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP,
    update_time      timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);
alter table t_ds_environment_worker_group_relation
    add constraint unique (environment_code, worker_group);
CREATE
OR
REPLACE TRIGGER tr_t_ds_environment_worker_group_relation
    BEFORE
UPDATE ON t_ds_environment_worker_group_relation
    FOR EACH ROW
BEGIN
SET NEW.update_time = CURRENT_TIMESTAMP;
END;


-- ----------------------------
-- Table structure for t_ds_task_group_queue
-- ----------------------------
DROP TABLE IF EXISTS t_ds_task_group_queue;
CREATE TABLE t_ds_task_group_queue
(
    id          int NOT NULL AUTO_INCREMENT,
    task_id     int               DEFAULT NULL,
    task_name   varchar(100)      DEFAULT NULL,
    group_id    int               DEFAULT NULL,
    process_id  int               DEFAULT NULL,
    priority    int               DEFAULT '0',
    status      tinyint           DEFAULT '-1',
    force_start tinyint           DEFAULT '0',
    in_queue    tinyint           DEFAULT '0',
    create_time timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP,
    update_time timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);
CREATE
OR
REPLACE TRIGGER tr_t_ds_task_group_queue
    BEFORE
UPDATE ON t_ds_task_group_queue
    FOR EACH ROW
BEGIN
SET NEW.update_time = CURRENT_TIMESTAMP;
END;

-- ----------------------------
-- Table structure for t_ds_task_group
-- ----------------------------
DROP TABLE IF EXISTS t_ds_task_group;
CREATE TABLE t_ds_task_group
(
    id           int NOT NULL AUTO_INCREMENT,
    name         varchar(100)      DEFAULT NULL,
    description  varchar(255)      DEFAULT NULL,
    group_size   int          NOT NULL,
    use_size     int               DEFAULT '0',
    user_id      int               DEFAULT NULL,
    project_code bigint            DEFAULT 0,
    status       tinyint           DEFAULT '1',
    create_time  timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP,
    update_time  timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);
CREATE
OR
REPLACE TRIGGER tr_t_ds_task_group
    BEFORE
UPDATE ON t_ds_task_group
    FOR EACH ROW
BEGIN
SET NEW.update_time = CURRENT_TIMESTAMP;
END;

-- ----------------------------
-- Table structure for t_ds_audit_log
-- ----------------------------
DROP TABLE IF EXISTS t_ds_audit_log;
CREATE TABLE t_ds_audit_log
(
    id            bigint NOT NULL AUTO_INCREMENT,
    user_id       int NOT NULL,
    resource_type int NOT NULL,
    operation     int NOT NULL,
    time          timestamp(0) DEFAULT CURRENT_TIMESTAMP,
    resource_id   int NULL     DEFAULT NULL,
    PRIMARY KEY (id)
);

-- ----------------------------
-- Table structure for t_ds_k8s
-- ----------------------------
DROP TABLE IF EXISTS t_ds_k8s;
CREATE TABLE t_ds_k8s
(
    id          int NOT NULL AUTO_INCREMENT,
    k8s_name    varchar(100) DEFAULT NULL,
    k8s_config  longvarchar         DEFAULT NULL,
    create_time timestamp(0) DEFAULT NULL,
    update_time timestamp(0) DEFAULT NULL,
    PRIMARY KEY (id)
);

-- ----------------------------
-- Table structure for t_ds_k8s_namespace
-- ----------------------------
DROP TABLE IF EXISTS t_ds_k8s_namespace;
CREATE TABLE t_ds_k8s_namespace
(
    id                 int NOT NULL AUTO_INCREMENT,
    code               bigint NOT NULL DEFAULT '0',
    limits_memory      int             DEFAULT NULL,
    namespace          varchar(100)    DEFAULT NULL,
    user_id            int             DEFAULT NULL,
    pod_replicas       int             DEFAULT NULL,
    pod_request_cpu    numeric(14, 3)  DEFAULT NULL,
    pod_request_memory int             DEFAULT NULL,
    limits_cpu         numeric(14, 3)  DEFAULT NULL,
    cluster_code       bigint NOT NULL DEFAULT '0',
    create_time        timestamp(0)    DEFAULT NULL,
    update_time        timestamp(0)    DEFAULT NULL,
    PRIMARY KEY (id)
);
alter table t_ds_k8s_namespace
    add constraint unique (namespace, cluster_code);

-- ----------------------------
-- Table structure for t_ds_relation_namespace_user
-- ----------------------------
DROP TABLE IF EXISTS t_ds_relation_namespace_user;
CREATE TABLE t_ds_relation_namespace_user
(
    id           int NOT NULL AUTO_INCREMENT,
    user_id      int NOT NULL,
    namespace_id int          DEFAULT NULL,
    perm         int          DEFAULT '1',
    create_time  timestamp(0) DEFAULT NULL,
    update_time  timestamp(0) DEFAULT NULL,
    PRIMARY KEY (id)
);
alter table t_ds_relation_namespace_user
    add constraint unique (user_id, namespace_id);


-- ----------------------------
-- Table structure for t_ds_alert_send_status
-- ----------------------------
DROP TABLE IF EXISTS t_ds_alert_send_status;
CREATE TABLE t_ds_alert_send_status
(
    id                       int NOT NULL AUTO_INCREMENT,
    alert_id                 int NOT NULL,
    alert_plugin_instance_id int NOT NULL,
    send_status              tinyint      DEFAULT '0',
    log                      longvarchar,
    create_time              timestamp(0) DEFAULT NULL,
    PRIMARY KEY (id)
);
alter table t_ds_alert_send_status
    add constraint unique (alert_id, alert_plugin_instance_id);



-- ----------------------------
-- Table structure for t_ds_cluster
-- ----------------------------
DROP TABLE IF EXISTS t_ds_cluster;
CREATE TABLE t_ds_cluster
(
    id          bigint NOT NULL AUTO_INCREMENT,
    code        bigint            DEFAULT NULL,
    name        varchar(100) NOT NULL,
    config      longvarchar         NULL DEFAULT NULL,
    description longvarchar         NULL DEFAULT NULL,
    operator    int               DEFAULT NULL,
    create_time timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP,
    update_time timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);
alter table t_ds_cluster
    add constraint unique (name);
alter table t_ds_cluster
    add constraint unique (code);
CREATE
OR
REPLACE TRIGGER tr_t_ds_cluster
    BEFORE
UPDATE ON t_ds_cluster
    FOR EACH ROW
BEGIN
SET NEW.update_time = CURRENT_TIMESTAMP;
END;


-- ----------------------------
-- Table structure for t_ds_fav_task
-- ----------------------------
DROP TABLE IF EXISTS t_ds_fav_task;
CREATE TABLE t_ds_fav_task
(
    id        bigint NOT NULL AUTO_INCREMENT,
    task_name varchar(64) NOT NULL,
    user_id   int         NOT NULL,
    PRIMARY KEY (id)
);