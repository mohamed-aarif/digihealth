--
-- PostgreSQL database dump
--

\restrict MwB48jUO0Bn9YIAt0YBaQz2uBSE7IDu4WUKTxmWnv8flXInYpGLPOXuzYJ22VTI

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2025-12-01 19:28:36

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 7 (class 2615 OID 23025)
-- Name: appointment; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA appointment;


ALTER SCHEMA appointment OWNER TO postgres;

--
-- TOC entry 13 (class 2615 OID 23031)
-- Name: configuration; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA configuration;


ALTER SCHEMA configuration OWNER TO postgres;

--
-- TOC entry 9 (class 2615 OID 23027)
-- Name: consent; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA consent;


ALTER SCHEMA consent OWNER TO postgres;

--
-- TOC entry 10 (class 2615 OID 23028)
-- Name: device; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA device;


ALTER SCHEMA device OWNER TO postgres;

--
-- TOC entry 11 (class 2615 OID 23029)
-- Name: engagement; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA engagement;


ALTER SCHEMA engagement OWNER TO postgres;

--
-- TOC entry 14 (class 2615 OID 2200)
-- Name: identity; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA identity;


ALTER SCHEMA identity OWNER TO postgres;

--
-- TOC entry 5840 (class 0 OID 0)
-- Dependencies: 14
-- Name: SCHEMA identity; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA identity IS 'standard public schema';


--
-- TOC entry 8 (class 2615 OID 23026)
-- Name: medication; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA medication;


ALTER SCHEMA medication OWNER TO postgres;

--
-- TOC entry 6 (class 2615 OID 23024)
-- Name: patient; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA patient;


ALTER SCHEMA patient OWNER TO postgres;

--
-- TOC entry 15 (class 2615 OID 23731)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 5842 (class 0 OID 0)
-- Dependencies: 15
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


--
-- TOC entry 12 (class 2615 OID 23030)
-- Name: vault; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO postgres;

--
-- TOC entry 2 (class 3079 OID 22985)
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA identity;


--
-- TOC entry 5844 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 280 (class 1259 OID 23347)
-- Name: appointment_audits; Type: TABLE; Schema: appointment; Owner: postgres
--

CREATE TABLE appointment.appointment_audits (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    appointment_id uuid NOT NULL,
    changed_by_user_id uuid NOT NULL,
    old_status_id uuid,
    new_status_id uuid NOT NULL,
    change_time timestamp with time zone DEFAULT now() NOT NULL,
    comment text,
    "ExtraProperties" text,
    "ConcurrencyStamp" character varying(40)
);


ALTER TABLE appointment.appointment_audits OWNER TO postgres;

--
-- TOC entry 278 (class 1259 OID 23297)
-- Name: appointments; Type: TABLE; Schema: appointment; Owner: postgres
--

CREATE TABLE appointment.appointments (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    tenant_id uuid,
    identity_patient_id uuid NOT NULL,
    identity_doctor_id uuid NOT NULL,
    start_time timestamp with time zone NOT NULL,
    end_time timestamp with time zone NOT NULL,
    status_id uuid NOT NULL,
    channel_id uuid NOT NULL,
    reason character varying(512),
    notes text,
    creation_time timestamp with time zone DEFAULT now() NOT NULL,
    "ExtraProperties" text,
    "ConcurrencyStamp" character varying(40),
    "CreatorId" uuid,
    "LastModificationTime" timestamp without time zone,
    "LastModifierId" uuid,
    "IsDeleted" boolean DEFAULT false NOT NULL,
    "DeleterId" uuid,
    "DeletionTime" timestamp without time zone
);


ALTER TABLE appointment.appointments OWNER TO postgres;

--
-- TOC entry 279 (class 1259 OID 23327)
-- Name: doctor_schedule_rules; Type: TABLE; Schema: appointment; Owner: postgres
--

CREATE TABLE appointment.doctor_schedule_rules (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    tenant_id uuid,
    identity_doctor_id uuid NOT NULL,
    day_of_week_id uuid NOT NULL,
    start_time_of_day interval NOT NULL,
    end_time_of_day interval NOT NULL,
    slot_duration_minutes integer NOT NULL,
    creation_time timestamp with time zone DEFAULT now() NOT NULL,
    "ExtraProperties" text,
    "ConcurrencyStamp" character varying(40),
    "CreatorId" uuid,
    "LastModificationTime" timestamp without time zone,
    "LastModifierId" uuid,
    "IsDeleted" boolean DEFAULT false NOT NULL,
    "DeleterId" uuid,
    "DeletionTime" timestamp without time zone
);


ALTER TABLE appointment.doctor_schedule_rules OWNER TO postgres;

--
-- TOC entry 266 (class 1259 OID 23049)
-- Name: appointment_channels; Type: TABLE; Schema: configuration; Owner: postgres
--

CREATE TABLE configuration.appointment_channels (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    code character varying(64) NOT NULL,
    name character varying(128) NOT NULL,
    description text,
    sort_order integer DEFAULT 0 NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE configuration.appointment_channels OWNER TO postgres;

--
-- TOC entry 265 (class 1259 OID 23032)
-- Name: appointment_statuses; Type: TABLE; Schema: configuration; Owner: postgres
--

CREATE TABLE configuration.appointment_statuses (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    code character varying(64) NOT NULL,
    name character varying(128) NOT NULL,
    description text,
    sort_order integer DEFAULT 0 NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE configuration.appointment_statuses OWNER TO postgres;

--
-- TOC entry 269 (class 1259 OID 23100)
-- Name: consent_party_types; Type: TABLE; Schema: configuration; Owner: postgres
--

CREATE TABLE configuration.consent_party_types (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    code character varying(64) NOT NULL,
    name character varying(128) NOT NULL,
    description text,
    sort_order integer DEFAULT 0 NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE configuration.consent_party_types OWNER TO postgres;

--
-- TOC entry 270 (class 1259 OID 23117)
-- Name: consent_statuses; Type: TABLE; Schema: configuration; Owner: postgres
--

CREATE TABLE configuration.consent_statuses (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    code character varying(64) NOT NULL,
    name character varying(128) NOT NULL,
    description text,
    sort_order integer DEFAULT 0 NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE configuration.consent_statuses OWNER TO postgres;

--
-- TOC entry 267 (class 1259 OID 23066)
-- Name: days_of_week; Type: TABLE; Schema: configuration; Owner: postgres
--

CREATE TABLE configuration.days_of_week (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    code character varying(32) NOT NULL,
    name character varying(64) NOT NULL,
    description text,
    sort_order integer DEFAULT 0 NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE configuration.days_of_week OWNER TO postgres;

--
-- TOC entry 271 (class 1259 OID 23134)
-- Name: device_types; Type: TABLE; Schema: configuration; Owner: postgres
--

CREATE TABLE configuration.device_types (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    code character varying(64) NOT NULL,
    name character varying(128) NOT NULL,
    description text,
    sort_order integer DEFAULT 0 NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE configuration.device_types OWNER TO postgres;

--
-- TOC entry 268 (class 1259 OID 23083)
-- Name: medication_intake_statuses; Type: TABLE; Schema: configuration; Owner: postgres
--

CREATE TABLE configuration.medication_intake_statuses (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    code character varying(64) NOT NULL,
    name character varying(128) NOT NULL,
    description text,
    sort_order integer DEFAULT 0 NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE configuration.medication_intake_statuses OWNER TO postgres;

--
-- TOC entry 272 (class 1259 OID 23151)
-- Name: notification_channels; Type: TABLE; Schema: configuration; Owner: postgres
--

CREATE TABLE configuration.notification_channels (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    code character varying(64) NOT NULL,
    name character varying(128) NOT NULL,
    description text,
    sort_order integer DEFAULT 0 NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE configuration.notification_channels OWNER TO postgres;

--
-- TOC entry 273 (class 1259 OID 23168)
-- Name: notification_statuses; Type: TABLE; Schema: configuration; Owner: postgres
--

CREATE TABLE configuration.notification_statuses (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    code character varying(64) NOT NULL,
    name character varying(128) NOT NULL,
    description text,
    sort_order integer DEFAULT 0 NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE configuration.notification_statuses OWNER TO postgres;

--
-- TOC entry 274 (class 1259 OID 23185)
-- Name: vault_record_types; Type: TABLE; Schema: configuration; Owner: postgres
--

CREATE TABLE configuration.vault_record_types (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    code character varying(64) NOT NULL,
    name character varying(128) NOT NULL,
    description text,
    sort_order integer DEFAULT 0 NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE configuration.vault_record_types OWNER TO postgres;

--
-- TOC entry 286 (class 1259 OID 23482)
-- Name: consent_audits; Type: TABLE; Schema: consent; Owner: postgres
--

CREATE TABLE consent.consent_audits (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    consent_id uuid NOT NULL,
    action character varying(32) NOT NULL,
    performed_by_user_id uuid NOT NULL,
    action_time timestamp with time zone DEFAULT now() NOT NULL,
    details text,
    "ExtraProperties" text,
    "ConcurrencyStamp" character varying(40)
);


ALTER TABLE consent.consent_audits OWNER TO postgres;

--
-- TOC entry 285 (class 1259 OID 23452)
-- Name: consents; Type: TABLE; Schema: consent; Owner: postgres
--

CREATE TABLE consent.consents (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    tenant_id uuid,
    identity_patient_id uuid NOT NULL,
    granted_to_party_type_id uuid NOT NULL,
    granted_to_party_id uuid NOT NULL,
    data_scope character varying(256) NOT NULL,
    purpose_of_use text NOT NULL,
    granted_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone,
    status_id uuid NOT NULL,
    "ExtraProperties" text,
    "ConcurrencyStamp" character varying(40),
    "CreatorId" uuid,
    "LastModificationTime" timestamp without time zone,
    "LastModifierId" uuid,
    "IsDeleted" boolean DEFAULT false NOT NULL,
    "DeleterId" uuid,
    "DeletionTime" timestamp without time zone
);


ALTER TABLE consent.consents OWNER TO postgres;

--
-- TOC entry 288 (class 1259 OID 23522)
-- Name: device_readings; Type: TABLE; Schema: device; Owner: postgres
--

CREATE TABLE device.device_readings (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    tenant_id uuid,
    device_id uuid NOT NULL,
    identity_patient_id uuid NOT NULL,
    reading_time timestamp with time zone NOT NULL,
    reading_type character varying(64) NOT NULL,
    value1 numeric(18,4),
    value2 numeric(18,4),
    unit character varying(32),
    raw_payload text,
    "ExtraProperties" text,
    "ConcurrencyStamp" character varying(40)
);


ALTER TABLE device.device_readings OWNER TO postgres;

--
-- TOC entry 287 (class 1259 OID 23502)
-- Name: devices; Type: TABLE; Schema: device; Owner: postgres
--

CREATE TABLE device.devices (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    tenant_id uuid,
    device_serial character varying(128) NOT NULL,
    device_type_id uuid NOT NULL,
    manufacturer character varying(128),
    model character varying(128),
    assigned_patient_id uuid,
    assigned_at timestamp with time zone,
    is_active boolean DEFAULT true NOT NULL,
    creation_time timestamp with time zone DEFAULT now() NOT NULL,
    "ExtraProperties" text,
    "ConcurrencyStamp" character varying(40),
    "CreatorId" uuid,
    "LastModificationTime" timestamp without time zone,
    "LastModifierId" uuid,
    "IsDeleted" boolean DEFAULT false NOT NULL,
    "DeleterId" uuid,
    "DeletionTime" timestamp without time zone
);


ALTER TABLE device.devices OWNER TO postgres;

--
-- TOC entry 297 (class 1259 OID 23972)
-- Name: chat_messages; Type: TABLE; Schema: engagement; Owner: postgres
--

CREATE TABLE engagement.chat_messages (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    tenant_id uuid,
    session_id uuid NOT NULL,
    sender_type character varying(32) NOT NULL,
    sender_user_id uuid,
    content text NOT NULL,
    content_format character varying(32) DEFAULT 'PlainText'::character varying NOT NULL,
    is_from_ai_assistant boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    ai_context_json text,
    "ExtraProperties" text,
    "ConcurrencyStamp" character varying(40),
    "CreationTime" timestamp without time zone DEFAULT now() NOT NULL,
    "CreatorId" uuid,
    "LastModificationTime" timestamp without time zone,
    "LastModifierId" uuid,
    "IsDeleted" boolean DEFAULT false NOT NULL,
    "DeleterId" uuid,
    "DeletionTime" timestamp without time zone
);


ALTER TABLE engagement.chat_messages OWNER TO postgres;

--
-- TOC entry 296 (class 1259 OID 23950)
-- Name: chat_sessions; Type: TABLE; Schema: engagement; Owner: postgres
--

CREATE TABLE engagement.chat_sessions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    tenant_id uuid,
    identity_patient_id uuid NOT NULL,
    created_by_user_id uuid,
    session_type character varying(64) NOT NULL,
    related_appointment_id uuid,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    ended_at timestamp with time zone,
    is_active boolean DEFAULT true NOT NULL,
    last_message_at timestamp with time zone,
    metadata_json text,
    "ExtraProperties" text,
    "ConcurrencyStamp" character varying(40),
    "CreationTime" timestamp without time zone DEFAULT now() NOT NULL,
    "CreatorId" uuid,
    "LastModificationTime" timestamp without time zone,
    "LastModifierId" uuid,
    "IsDeleted" boolean DEFAULT false NOT NULL,
    "DeleterId" uuid,
    "DeletionTime" timestamp without time zone
);


ALTER TABLE engagement.chat_sessions OWNER TO postgres;

--
-- TOC entry 289 (class 1259 OID 23543)
-- Name: notification_templates; Type: TABLE; Schema: engagement; Owner: postgres
--

CREATE TABLE engagement.notification_templates (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    tenant_id uuid,
    template_key character varying(128) NOT NULL,
    channel_id uuid NOT NULL,
    subject_template character varying(512),
    body_template text NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    creation_time timestamp with time zone DEFAULT now() NOT NULL,
    "ExtraProperties" text,
    "ConcurrencyStamp" character varying(40),
    "CreatorId" uuid,
    "LastModificationTime" timestamp without time zone,
    "LastModifierId" uuid,
    "IsDeleted" boolean DEFAULT false NOT NULL,
    "DeleterId" uuid,
    "DeletionTime" timestamp without time zone
);


ALTER TABLE engagement.notification_templates OWNER TO postgres;

--
-- TOC entry 290 (class 1259 OID 23565)
-- Name: notifications; Type: TABLE; Schema: engagement; Owner: postgres
--

CREATE TABLE engagement.notifications (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    tenant_id uuid,
    recipient_user_id uuid NOT NULL,
    channel_id uuid NOT NULL,
    template_key character varying(128) NOT NULL,
    payload_json text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    sent_at timestamp with time zone,
    status_id uuid NOT NULL,
    error_message text,
    "ExtraProperties" text,
    "ConcurrencyStamp" character varying(40),
    "CreatorId" uuid,
    "LastModificationTime" timestamp without time zone,
    "LastModifierId" uuid,
    "IsDeleted" boolean DEFAULT false NOT NULL,
    "DeleterId" uuid,
    "DeletionTime" timestamp without time zone
);


ALTER TABLE engagement.notifications OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 22727)
-- Name: AbpAuditLogActions; Type: TABLE; Schema: identity; Owner: postgres
--

CREATE TABLE identity."AbpAuditLogActions" (
    "Id" uuid NOT NULL,
    "TenantId" uuid,
    "AuditLogId" uuid NOT NULL,
    "ServiceName" character varying(256),
    "MethodName" character varying(128),
    "Parameters" character varying(2000),
    "ExecutionTime" timestamp without time zone NOT NULL,
    "ExecutionDuration" integer NOT NULL,
    "ExtraProperties" text
);


ALTER TABLE identity."AbpAuditLogActions" OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 22433)
-- Name: AbpAuditLogExcelFiles; Type: TABLE; Schema: identity; Owner: postgres
--

CREATE TABLE identity."AbpAuditLogExcelFiles" (
    "Id" uuid NOT NULL,
    "TenantId" uuid,
    "FileName" character varying(256),
    "CreationTime" timestamp without time zone NOT NULL,
    "CreatorId" uuid
);


ALTER TABLE identity."AbpAuditLogExcelFiles" OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 22440)
-- Name: AbpAuditLogs; Type: TABLE; Schema: identity; Owner: postgres
--

CREATE TABLE identity."AbpAuditLogs" (
    "Id" uuid NOT NULL,
    "ApplicationName" character varying(96),
    "UserId" uuid,
    "UserName" character varying(256),
    "TenantId" uuid,
    "TenantName" character varying(64),
    "ImpersonatorUserId" uuid,
    "ImpersonatorUserName" character varying(256),
    "ImpersonatorTenantId" uuid,
    "ImpersonatorTenantName" character varying(64),
    "ExecutionTime" timestamp without time zone NOT NULL,
    "ExecutionDuration" integer NOT NULL,
    "ClientIpAddress" character varying(64),
    "ClientName" character varying(128),
    "ClientId" character varying(64),
    "CorrelationId" character varying(64),
    "BrowserInfo" character varying(512),
    "HttpMethod" character varying(16),
    "Url" character varying(256),
    "Exceptions" text,
    "Comments" character varying(256),
    "HttpStatusCode" integer,
    "ExtraProperties" text NOT NULL,
    "ConcurrencyStamp" character varying(40) NOT NULL
);


ALTER TABLE identity."AbpAuditLogs" OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 22452)
-- Name: AbpBackgroundJobs; Type: TABLE; Schema: identity; Owner: postgres
--

CREATE TABLE identity."AbpBackgroundJobs" (
    "Id" uuid NOT NULL,
    "ApplicationName" character varying(96),
    "JobName" character varying(128) NOT NULL,
    "JobArgs" character varying(1048576) NOT NULL,
    "TryCount" smallint DEFAULT 0 NOT NULL,
    "CreationTime" timestamp without time zone NOT NULL,
    "NextTryTime" timestamp without time zone NOT NULL,
    "LastTryTime" timestamp without time zone,
    "IsAbandoned" boolean DEFAULT false NOT NULL,
    "Priority" smallint DEFAULT 15 NOT NULL,
    "ExtraProperties" text NOT NULL,
    "ConcurrencyStamp" character varying(40) NOT NULL
);


ALTER TABLE identity."AbpBackgroundJobs" OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 22472)
-- Name: AbpClaimTypes; Type: TABLE; Schema: identity; Owner: postgres
--

CREATE TABLE identity."AbpClaimTypes" (
    "Id" uuid NOT NULL,
    "Name" character varying(256) NOT NULL,
    "Required" boolean NOT NULL,
    "IsStatic" boolean NOT NULL,
    "Regex" character varying(512),
    "RegexDescription" character varying(128),
    "Description" character varying(256),
    "ValueType" integer NOT NULL,
    "CreationTime" timestamp without time zone NOT NULL,
    "ExtraProperties" text NOT NULL,
    "ConcurrencyStamp" character varying(40) NOT NULL
);


ALTER TABLE identity."AbpClaimTypes" OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 22743)
-- Name: AbpEntityChanges; Type: TABLE; Schema: identity; Owner: postgres
--

CREATE TABLE identity."AbpEntityChanges" (
    "Id" uuid NOT NULL,
    "AuditLogId" uuid NOT NULL,
    "TenantId" uuid,
    "ChangeTime" timestamp without time zone NOT NULL,
    "ChangeType" smallint NOT NULL,
    "EntityTenantId" uuid,
    "EntityId" character varying(128),
    "EntityTypeFullName" character varying(128) NOT NULL,
    "ExtraProperties" text
);


ALTER TABLE identity."AbpEntityChanges" OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 22901)
-- Name: AbpEntityPropertyChanges; Type: TABLE; Schema: identity; Owner: postgres
--

CREATE TABLE identity."AbpEntityPropertyChanges" (
    "Id" uuid NOT NULL,
    "TenantId" uuid,
    "EntityChangeId" uuid NOT NULL,
    "NewValue" character varying(512),
    "OriginalValue" character varying(512),
    "PropertyName" character varying(128) NOT NULL,
    "PropertyTypeFullName" character varying(64) NOT NULL
);


ALTER TABLE identity."AbpEntityPropertyChanges" OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 22487)
-- Name: AbpFeatureGroups; Type: TABLE; Schema: identity; Owner: postgres
--

CREATE TABLE identity."AbpFeatureGroups" (
    "Id" uuid NOT NULL,
    "Name" character varying(128) NOT NULL,
    "DisplayName" character varying(256) NOT NULL,
    "ExtraProperties" text
);


ALTER TABLE identity."AbpFeatureGroups" OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 22510)
-- Name: AbpFeatureValues; Type: TABLE; Schema: identity; Owner: postgres
--

CREATE TABLE identity."AbpFeatureValues" (
    "Id" uuid NOT NULL,
    "Name" character varying(128) NOT NULL,
    "Value" character varying(128) NOT NULL,
    "ProviderName" character varying(64),
    "ProviderKey" character varying(64)
);


ALTER TABLE identity."AbpFeatureValues" OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 22497)
-- Name: AbpFeatures; Type: TABLE; Schema: identity; Owner: postgres
--

CREATE TABLE identity."AbpFeatures" (
    "Id" uuid NOT NULL,
    "GroupName" character varying(128) NOT NULL,
    "Name" character varying(128) NOT NULL,
    "ParentName" character varying(128),
    "DisplayName" character varying(256) NOT NULL,
    "Description" character varying(256),
    "DefaultValue" character varying(256),
    "IsVisibleToClients" boolean NOT NULL,
    "IsAvailableToHost" boolean NOT NULL,
    "AllowedProviders" character varying(256),
    "ValueType" character varying(2048),
    "ExtraProperties" text
);


ALTER TABLE identity."AbpFeatures" OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 22518)
-- Name: AbpLinkUsers; Type: TABLE; Schema: identity; Owner: postgres
--

CREATE TABLE identity."AbpLinkUsers" (
    "Id" uuid NOT NULL,
    "SourceUserId" uuid NOT NULL,
    "SourceTenantId" uuid,
    "TargetUserId" uuid NOT NULL,
    "TargetTenantId" uuid
);


ALTER TABLE identity."AbpLinkUsers" OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 22760)
-- Name: AbpOrganizationUnitRoles; Type: TABLE; Schema: identity; Owner: postgres
--

CREATE TABLE identity."AbpOrganizationUnitRoles" (
    "RoleId" uuid NOT NULL,
    "OrganizationUnitId" uuid NOT NULL,
    "TenantId" uuid,
    "CreationTime" timestamp without time zone NOT NULL,
    "CreatorId" uuid
);


ALTER TABLE identity."AbpOrganizationUnitRoles" OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 22526)
-- Name: AbpOrganizationUnits; Type: TABLE; Schema: identity; Owner: postgres
--

CREATE TABLE identity."AbpOrganizationUnits" (
    "Id" uuid NOT NULL,
    "TenantId" uuid,
    "ParentId" uuid,
    "Code" character varying(95) NOT NULL,
    "DisplayName" character varying(128) NOT NULL,
    "EntityVersion" integer NOT NULL,
    "ExtraProperties" text NOT NULL,
    "ConcurrencyStamp" character varying(40) NOT NULL,
    "CreationTime" timestamp without time zone NOT NULL,
    "CreatorId" uuid,
    "LastModificationTime" timestamp without time zone,
    "LastModifierId" uuid,
    "IsDeleted" boolean DEFAULT false NOT NULL,
    "DeleterId" uuid,
    "DeletionTime" timestamp without time zone
);


ALTER TABLE identity."AbpOrganizationUnits" OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 22547)
-- Name: AbpPermissionGrants; Type: TABLE; Schema: identity; Owner: postgres
--

CREATE TABLE identity."AbpPermissionGrants" (
    "Id" uuid NOT NULL,
    "TenantId" uuid,
    "Name" character varying(128) NOT NULL,
    "ProviderName" character varying(64) NOT NULL,
    "ProviderKey" character varying(64) NOT NULL
);


ALTER TABLE identity."AbpPermissionGrants" OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 22556)
-- Name: AbpPermissionGroups; Type: TABLE; Schema: identity; Owner: postgres
--

CREATE TABLE identity."AbpPermissionGroups" (
    "Id" uuid NOT NULL,
    "Name" character varying(128) NOT NULL,
    "DisplayName" character varying(256) NOT NULL,
    "ExtraProperties" text
);


ALTER TABLE identity."AbpPermissionGroups" OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 22566)
-- Name: AbpPermissions; Type: TABLE; Schema: identity; Owner: postgres
--

CREATE TABLE identity."AbpPermissions" (
    "Id" uuid NOT NULL,
    "GroupName" character varying(128) NOT NULL,
    "Name" character varying(128) NOT NULL,
    "ParentName" character varying(128),
    "DisplayName" character varying(256) NOT NULL,
    "IsEnabled" boolean NOT NULL,
    "MultiTenancySide" smallint NOT NULL,
    "Providers" character varying(128),
    "StateCheckers" character varying(256),
    "ExtraProperties" text
);


ALTER TABLE identity."AbpPermissions" OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 22778)
-- Name: AbpRoleClaims; Type: TABLE; Schema: identity; Owner: postgres
--

CREATE TABLE identity."AbpRoleClaims" (
    "Id" uuid NOT NULL,
    "RoleId" uuid NOT NULL,
    "TenantId" uuid,
    "ClaimType" character varying(256) NOT NULL,
    "ClaimValue" character varying(1024)
);


ALTER TABLE identity."AbpRoleClaims" OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 22579)
-- Name: AbpRoles; Type: TABLE; Schema: identity; Owner: postgres
--

CREATE TABLE identity."AbpRoles" (
    "Id" uuid NOT NULL,
    "TenantId" uuid,
    "Name" character varying(256) NOT NULL,
    "NormalizedName" character varying(256) NOT NULL,
    "IsDefault" boolean NOT NULL,
    "IsStatic" boolean NOT NULL,
    "IsPublic" boolean NOT NULL,
    "EntityVersion" integer NOT NULL,
    "CreationTime" timestamp without time zone NOT NULL,
    "ExtraProperties" text NOT NULL,
    "ConcurrencyStamp" character varying(40) NOT NULL
);


ALTER TABLE identity."AbpRoles" OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 22596)
-- Name: AbpSecurityLogs; Type: TABLE; Schema: identity; Owner: postgres
--

CREATE TABLE identity."AbpSecurityLogs" (
    "Id" uuid NOT NULL,
    "TenantId" uuid,
    "ApplicationName" character varying(96),
    "Identity" character varying(96),
    "Action" character varying(96),
    "UserId" uuid,
    "UserName" character varying(256),
    "TenantName" character varying(64),
    "ClientId" character varying(64),
    "CorrelationId" character varying(64),
    "ClientIpAddress" character varying(64),
    "BrowserInfo" character varying(512),
    "CreationTime" timestamp without time zone NOT NULL,
    "ExtraProperties" text NOT NULL,
    "ConcurrencyStamp" character varying(40) NOT NULL
);


ALTER TABLE identity."AbpSecurityLogs" OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 22607)
-- Name: AbpSessions; Type: TABLE; Schema: identity; Owner: postgres
--

CREATE TABLE identity."AbpSessions" (
    "Id" uuid NOT NULL,
    "SessionId" character varying(128) NOT NULL,
    "Device" character varying(64) NOT NULL,
    "DeviceInfo" character varying(64),
    "TenantId" uuid,
    "UserId" uuid NOT NULL,
    "ClientId" character varying(64),
    "IpAddresses" character varying(2048),
    "SignedIn" timestamp without time zone NOT NULL,
    "LastAccessed" timestamp without time zone,
    "ExtraProperties" text
);


ALTER TABLE identity."AbpSessions" OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 22619)
-- Name: AbpSettingDefinitions; Type: TABLE; Schema: identity; Owner: postgres
--

CREATE TABLE identity."AbpSettingDefinitions" (
    "Id" uuid NOT NULL,
    "Name" character varying(128) NOT NULL,
    "DisplayName" character varying(256) NOT NULL,
    "Description" character varying(512),
    "DefaultValue" character varying(2048),
    "IsVisibleToClients" boolean NOT NULL,
    "Providers" character varying(1024),
    "IsInherited" boolean NOT NULL,
    "IsEncrypted" boolean NOT NULL,
    "ExtraProperties" text
);


ALTER TABLE identity."AbpSettingDefinitions" OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 22632)
-- Name: AbpSettings; Type: TABLE; Schema: identity; Owner: postgres
--

CREATE TABLE identity."AbpSettings" (
    "Id" uuid NOT NULL,
    "Name" character varying(128) NOT NULL,
    "Value" character varying(2048) NOT NULL,
    "ProviderName" character varying(64),
    "ProviderKey" character varying(64)
);


ALTER TABLE identity."AbpSettings" OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 22793)
-- Name: AbpTenantConnectionStrings; Type: TABLE; Schema: identity; Owner: postgres
--

CREATE TABLE identity."AbpTenantConnectionStrings" (
    "TenantId" uuid NOT NULL,
    "Name" character varying(64) NOT NULL,
    "Value" character varying(1024) NOT NULL
);


ALTER TABLE identity."AbpTenantConnectionStrings" OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 22642)
-- Name: AbpTenants; Type: TABLE; Schema: identity; Owner: postgres
--

CREATE TABLE identity."AbpTenants" (
    "Id" uuid NOT NULL,
    "Name" character varying(64) NOT NULL,
    "NormalizedName" character varying(64) NOT NULL,
    "EntityVersion" integer NOT NULL,
    "ExtraProperties" text NOT NULL,
    "ConcurrencyStamp" character varying(40) NOT NULL,
    "CreationTime" timestamp without time zone NOT NULL,
    "CreatorId" uuid,
    "LastModificationTime" timestamp without time zone,
    "LastModifierId" uuid,
    "IsDeleted" boolean DEFAULT false NOT NULL,
    "DeleterId" uuid,
    "DeletionTime" timestamp without time zone
);


ALTER TABLE identity."AbpTenants" OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 22808)
-- Name: AbpUserClaims; Type: TABLE; Schema: identity; Owner: postgres
--

CREATE TABLE identity."AbpUserClaims" (
    "Id" uuid NOT NULL,
    "UserId" uuid NOT NULL,
    "TenantId" uuid,
    "ClaimType" character varying(256) NOT NULL,
    "ClaimValue" character varying(1024)
);


ALTER TABLE identity."AbpUserClaims" OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 22658)
-- Name: AbpUserDelegations; Type: TABLE; Schema: identity; Owner: postgres
--

CREATE TABLE identity."AbpUserDelegations" (
    "Id" uuid NOT NULL,
    "TenantId" uuid,
    "SourceUserId" uuid NOT NULL,
    "TargetUserId" uuid NOT NULL,
    "StartTime" timestamp without time zone NOT NULL,
    "EndTime" timestamp without time zone NOT NULL
);


ALTER TABLE identity."AbpUserDelegations" OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 22823)
-- Name: AbpUserLogins; Type: TABLE; Schema: identity; Owner: postgres
--

CREATE TABLE identity."AbpUserLogins" (
    "UserId" uuid NOT NULL,
    "LoginProvider" character varying(64) NOT NULL,
    "TenantId" uuid,
    "ProviderKey" character varying(196) NOT NULL,
    "ProviderDisplayName" character varying(128)
);


ALTER TABLE identity."AbpUserLogins" OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 22836)
-- Name: AbpUserOrganizationUnits; Type: TABLE; Schema: identity; Owner: postgres
--

CREATE TABLE identity."AbpUserOrganizationUnits" (
    "UserId" uuid NOT NULL,
    "OrganizationUnitId" uuid NOT NULL,
    "TenantId" uuid,
    "CreationTime" timestamp without time zone NOT NULL,
    "CreatorId" uuid
);


ALTER TABLE identity."AbpUserOrganizationUnits" OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 22854)
-- Name: AbpUserRoles; Type: TABLE; Schema: identity; Owner: postgres
--

CREATE TABLE identity."AbpUserRoles" (
    "UserId" uuid NOT NULL,
    "RoleId" uuid NOT NULL,
    "TenantId" uuid
);


ALTER TABLE identity."AbpUserRoles" OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 22871)
-- Name: AbpUserTokens; Type: TABLE; Schema: identity; Owner: postgres
--

CREATE TABLE identity."AbpUserTokens" (
    "UserId" uuid NOT NULL,
    "LoginProvider" character varying(64) NOT NULL,
    "Name" character varying(128) NOT NULL,
    "TenantId" uuid,
    "Value" text
);


ALTER TABLE identity."AbpUserTokens" OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 22668)
-- Name: AbpUsers; Type: TABLE; Schema: identity; Owner: postgres
--

CREATE TABLE identity."AbpUsers" (
    "Id" uuid NOT NULL,
    "TenantId" uuid,
    "UserName" character varying(256) NOT NULL,
    "NormalizedUserName" character varying(256) NOT NULL,
    "Name" character varying(64),
    "Surname" character varying(64),
    "Email" character varying(256) NOT NULL,
    "NormalizedEmail" character varying(256) NOT NULL,
    "EmailConfirmed" boolean DEFAULT false NOT NULL,
    "PasswordHash" character varying(256),
    "SecurityStamp" character varying(256) NOT NULL,
    "IsExternal" boolean DEFAULT false NOT NULL,
    "PhoneNumber" character varying(16),
    "PhoneNumberConfirmed" boolean DEFAULT false NOT NULL,
    "IsActive" boolean NOT NULL,
    "TwoFactorEnabled" boolean DEFAULT false NOT NULL,
    "LockoutEnd" timestamp with time zone,
    "LockoutEnabled" boolean DEFAULT false NOT NULL,
    "AccessFailedCount" integer DEFAULT 0 NOT NULL,
    "ShouldChangePasswordOnNextLogin" boolean NOT NULL,
    "EntityVersion" integer NOT NULL,
    "LastPasswordChangeTime" timestamp with time zone,
    "ExtraProperties" text NOT NULL,
    "ConcurrencyStamp" character varying(40) NOT NULL,
    "CreationTime" timestamp without time zone NOT NULL,
    "CreatorId" uuid,
    "LastModificationTime" timestamp without time zone,
    "LastModifierId" uuid,
    "IsDeleted" boolean DEFAULT false NOT NULL,
    "DeleterId" uuid,
    "DeletionTime" timestamp without time zone,
    "Salutation" character varying(32),
    "ProfilePhotoUrl" text
);


ALTER TABLE identity."AbpUsers" OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 22701)
-- Name: OpenIddictApplications; Type: TABLE; Schema: identity; Owner: postgres
--

CREATE TABLE identity."OpenIddictApplications" (
    "Id" uuid NOT NULL,
    "ApplicationType" character varying(50),
    "ClientId" character varying(100),
    "ClientSecret" text,
    "ClientType" character varying(50),
    "ConsentType" character varying(50),
    "DisplayName" text,
    "DisplayNames" text,
    "JsonWebKeySet" text,
    "Permissions" text,
    "PostLogoutRedirectUris" text,
    "Properties" text,
    "RedirectUris" text,
    "Requirements" text,
    "Settings" text,
    "ClientUri" text,
    "LogoUri" text,
    "ExtraProperties" text NOT NULL,
    "ConcurrencyStamp" character varying(40) NOT NULL,
    "CreationTime" timestamp without time zone NOT NULL,
    "CreatorId" uuid,
    "LastModificationTime" timestamp without time zone,
    "LastModifierId" uuid,
    "IsDeleted" boolean DEFAULT false NOT NULL,
    "DeleterId" uuid,
    "DeletionTime" timestamp without time zone
);


ALTER TABLE identity."OpenIddictApplications" OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 22886)
-- Name: OpenIddictAuthorizations; Type: TABLE; Schema: identity; Owner: postgres
--

CREATE TABLE identity."OpenIddictAuthorizations" (
    "Id" uuid NOT NULL,
    "ApplicationId" uuid,
    "CreationDate" timestamp without time zone,
    "Properties" text,
    "Scopes" text,
    "Status" character varying(50),
    "Subject" character varying(400),
    "Type" character varying(50),
    "ExtraProperties" text NOT NULL,
    "ConcurrencyStamp" character varying(40) NOT NULL
);


ALTER TABLE identity."OpenIddictAuthorizations" OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 22714)
-- Name: OpenIddictScopes; Type: TABLE; Schema: identity; Owner: postgres
--

CREATE TABLE identity."OpenIddictScopes" (
    "Id" uuid NOT NULL,
    "Description" text,
    "Descriptions" text,
    "DisplayName" text,
    "DisplayNames" text,
    "Name" character varying(200),
    "Properties" text,
    "Resources" text,
    "ExtraProperties" text NOT NULL,
    "ConcurrencyStamp" character varying(40) NOT NULL,
    "CreationTime" timestamp without time zone NOT NULL,
    "CreatorId" uuid,
    "LastModificationTime" timestamp without time zone,
    "LastModifierId" uuid,
    "IsDeleted" boolean DEFAULT false NOT NULL,
    "DeleterId" uuid,
    "DeletionTime" timestamp without time zone
);


ALTER TABLE identity."OpenIddictScopes" OWNER TO postgres;

--
-- TOC entry 264 (class 1259 OID 22917)
-- Name: OpenIddictTokens; Type: TABLE; Schema: identity; Owner: postgres
--

CREATE TABLE identity."OpenIddictTokens" (
    "Id" uuid NOT NULL,
    "ApplicationId" uuid,
    "AuthorizationId" uuid,
    "CreationDate" timestamp without time zone,
    "ExpirationDate" timestamp without time zone,
    "Payload" text,
    "Properties" text,
    "RedemptionDate" timestamp without time zone,
    "ReferenceId" character varying(100),
    "Status" character varying(50),
    "Subject" character varying(400),
    "Type" character varying(50),
    "ExtraProperties" text NOT NULL,
    "ConcurrencyStamp" character varying(40) NOT NULL
);


ALTER TABLE identity."OpenIddictTokens" OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 22426)
-- Name: __EFMigrationsHistory; Type: TABLE; Schema: identity; Owner: postgres
--

CREATE TABLE identity."__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL
);


ALTER TABLE identity."__EFMigrationsHistory" OWNER TO postgres;

--
-- TOC entry 293 (class 1259 OID 23639)
-- Name: doctors; Type: TABLE; Schema: identity; Owner: postgres
--

CREATE TABLE identity.doctors (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    tenant_id uuid,
    user_id uuid NOT NULL,
    salutation character varying(32),
    gender character varying(16),
    specialization character varying(256),
    registration_number character varying(128),
    creation_time timestamp with time zone DEFAULT now() NOT NULL,
    "ConcurrencyStamp" character varying(40),
    "ExtraProperties" text,
    "CreatorId" uuid,
    "LastModificationTime" timestamp without time zone,
    "LastModifierId" uuid,
    "IsDeleted" boolean DEFAULT false NOT NULL,
    "DeleterId" uuid,
    "DeletionTime" timestamp without time zone
);


ALTER TABLE identity.doctors OWNER TO postgres;

--
-- TOC entry 295 (class 1259 OID 23703)
-- Name: family_links; Type: TABLE; Schema: identity; Owner: postgres
--

CREATE TABLE identity.family_links (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    tenant_id uuid,
    patient_id uuid NOT NULL,
    family_user_id uuid NOT NULL,
    relationship character varying(50) NOT NULL,
    is_guardian boolean DEFAULT false NOT NULL,
    creation_time timestamp with time zone DEFAULT now() NOT NULL,
    "ConcurrencyStamp" character varying(40),
    "ExtraProperties" text,
    "CreatorId" uuid,
    "LastModificationTime" timestamp without time zone,
    "LastModifierId" uuid,
    "IsDeleted" boolean DEFAULT false NOT NULL,
    "DeleterId" uuid,
    "DeletionTime" timestamp without time zone
);


ALTER TABLE identity.family_links OWNER TO postgres;

--
-- TOC entry 294 (class 1259 OID 23657)
-- Name: patients; Type: TABLE; Schema: identity; Owner: postgres
--

CREATE TABLE identity.patients (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    tenant_id uuid,
    user_id uuid NOT NULL,
    salutation character varying(32),
    date_of_birth date,
    gender character varying(16),
    residence_country character varying(128),
    creation_time timestamp with time zone DEFAULT now() NOT NULL,
    "ConcurrencyStamp" character varying(40),
    "ExtraProperties" text,
    "CreatorId" uuid,
    "LastModificationTime" timestamp without time zone,
    "LastModifierId" uuid,
    "IsDeleted" boolean DEFAULT false NOT NULL,
    "DeleterId" uuid,
    "DeletionTime" timestamp without time zone
);


ALTER TABLE identity.patients OWNER TO postgres;

--
-- TOC entry 292 (class 1259 OID 23623)
-- Name: users; Type: TABLE; Schema: identity; Owner: postgres
--

CREATE TABLE identity.users (
    id uuid NOT NULL,
    tenant_id uuid,
    user_name character varying(256) NOT NULL,
    email character varying(256) NOT NULL,
    salutation character varying(32),
    profile_photo_url text,
    name character varying(128),
    surname character varying(128),
    is_active boolean DEFAULT true NOT NULL,
    creation_time timestamp with time zone DEFAULT now() NOT NULL,
    "ExtraProperties" text,
    "ConcurrencyStamp" character varying(40),
    "CreatorId" uuid,
    "LastModificationTime" timestamp without time zone,
    "LastModifierId" uuid,
    "IsDeleted" boolean DEFAULT false NOT NULL,
    "DeleterId" uuid,
    "DeletionTime" timestamp without time zone
);


ALTER TABLE identity.users OWNER TO postgres;

--
-- TOC entry 284 (class 1259 OID 23425)
-- Name: medication_intake_logs; Type: TABLE; Schema: medication; Owner: postgres
--

CREATE TABLE medication.medication_intake_logs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    tenant_id uuid,
    identity_patient_id uuid NOT NULL,
    prescription_item_id uuid NOT NULL,
    scheduled_time timestamp with time zone NOT NULL,
    taken_time timestamp with time zone,
    status_id uuid NOT NULL,
    notes text,
    creation_time timestamp with time zone DEFAULT now() NOT NULL,
    "ExtraProperties" text,
    "ConcurrencyStamp" character varying(40),
    "CreatorId" uuid,
    "LastModificationTime" timestamp without time zone,
    "LastModifierId" uuid,
    "IsDeleted" boolean DEFAULT false NOT NULL,
    "DeleterId" uuid,
    "DeletionTime" timestamp without time zone
);


ALTER TABLE medication.medication_intake_logs OWNER TO postgres;

--
-- TOC entry 283 (class 1259 OID 23409)
-- Name: medication_schedules; Type: TABLE; Schema: medication; Owner: postgres
--

CREATE TABLE medication.medication_schedules (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    tenant_id uuid,
    identity_patient_id uuid NOT NULL,
    prescription_item_id uuid NOT NULL,
    time_of_day interval NOT NULL,
    "ExtraProperties" text,
    "ConcurrencyStamp" character varying(40),
    "CreatorId" uuid,
    "LastModificationTime" timestamp without time zone,
    "LastModifierId" uuid,
    "IsDeleted" boolean DEFAULT false NOT NULL,
    "DeleterId" uuid,
    "DeletionTime" timestamp without time zone
);


ALTER TABLE medication.medication_schedules OWNER TO postgres;

--
-- TOC entry 282 (class 1259 OID 23392)
-- Name: prescription_items; Type: TABLE; Schema: medication; Owner: postgres
--

CREATE TABLE medication.prescription_items (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    tenant_id uuid,
    prescription_id uuid NOT NULL,
    drug_name character varying(256) NOT NULL,
    strength character varying(128),
    dosage_instructions text,
    start_date date,
    end_date date,
    frequency_per_day integer,
    "ExtraProperties" text,
    "ConcurrencyStamp" character varying(40),
    "CreatorId" uuid,
    "LastModificationTime" timestamp without time zone,
    "LastModifierId" uuid,
    "IsDeleted" boolean DEFAULT false NOT NULL,
    "DeleterId" uuid,
    "DeletionTime" timestamp without time zone
);


ALTER TABLE medication.prescription_items OWNER TO postgres;

--
-- TOC entry 281 (class 1259 OID 23377)
-- Name: prescriptions; Type: TABLE; Schema: medication; Owner: postgres
--

CREATE TABLE medication.prescriptions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    tenant_id uuid,
    identity_patient_id uuid NOT NULL,
    identity_doctor_id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    diagnosis_summary text,
    notes text,
    "ExtraProperties" text,
    "ConcurrencyStamp" character varying(40),
    "CreatorId" uuid,
    "LastModificationTime" timestamp without time zone,
    "LastModifierId" uuid,
    "IsDeleted" boolean DEFAULT false NOT NULL,
    "DeleterId" uuid,
    "DeletionTime" timestamp without time zone
);


ALTER TABLE medication.prescriptions OWNER TO postgres;

--
-- TOC entry 277 (class 1259 OID 23282)
-- Name: patient_external_links; Type: TABLE; Schema: patient; Owner: postgres
--

CREATE TABLE patient.patient_external_links (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    tenant_id uuid,
    identity_patient_id uuid NOT NULL,
    system_name character varying(128) NOT NULL,
    external_reference character varying(256) NOT NULL,
    creation_time timestamp with time zone DEFAULT now() NOT NULL,
    "ExtraProperties" text,
    "ConcurrencyStamp" character varying(40),
    "CreatorId" uuid,
    "LastModificationTime" timestamp without time zone,
    "LastModifierId" uuid,
    "IsDeleted" boolean DEFAULT false NOT NULL,
    "DeleterId" uuid,
    "DeletionTime" timestamp without time zone
);


ALTER TABLE patient.patient_external_links OWNER TO postgres;

--
-- TOC entry 276 (class 1259 OID 23268)
-- Name: patient_medical_summaries; Type: TABLE; Schema: patient; Owner: postgres
--

CREATE TABLE patient.patient_medical_summaries (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    tenant_id uuid,
    identity_patient_id uuid NOT NULL,
    blood_group character varying(8),
    allergies text,
    chronic_conditions text,
    notes text,
    creation_time timestamp with time zone DEFAULT now() NOT NULL,
    "ExtraProperties" text,
    "ConcurrencyStamp" character varying(40),
    "CreatorId" uuid,
    "LastModificationTime" timestamp without time zone,
    "LastModifierId" uuid,
    "IsDeleted" boolean DEFAULT false NOT NULL,
    "DeleterId" uuid,
    "DeletionTime" timestamp without time zone
);


ALTER TABLE patient.patient_medical_summaries OWNER TO postgres;

--
-- TOC entry 275 (class 1259 OID 23254)
-- Name: patient_profile_extensions; Type: TABLE; Schema: patient; Owner: postgres
--

CREATE TABLE patient.patient_profile_extensions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    tenant_id uuid,
    identity_patient_id uuid NOT NULL,
    primary_contact_number character varying(32),
    secondary_contact_number character varying(32),
    email character varying(256),
    address_line1 character varying(256),
    address_line2 character varying(256),
    city character varying(128),
    state character varying(128),
    zipcode character varying(32),
    country character varying(128),
    emergency_contact_name character varying(256),
    emergency_contact_number character varying(32),
    preferred_language character varying(64),
    creation_time timestamp with time zone DEFAULT now() NOT NULL,
    "ExtraProperties" text,
    "ConcurrencyStamp" character varying(40),
    "CreatorId" uuid,
    "LastModificationTime" timestamp without time zone,
    "LastModifierId" uuid,
    "IsDeleted" boolean DEFAULT false NOT NULL,
    "DeleterId" uuid,
    "DeletionTime" timestamp without time zone
);


ALTER TABLE patient.patient_profile_extensions OWNER TO postgres;

--
-- TOC entry 298 (class 1259 OID 24393)
-- Name: __EFMigrationsHistory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL
);


ALTER TABLE public."__EFMigrationsHistory" OWNER TO postgres;

--
-- TOC entry 291 (class 1259 OID 23593)
-- Name: vault_records; Type: TABLE; Schema: vault; Owner: postgres
--

CREATE TABLE vault.vault_records (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    tenant_id uuid,
    identity_patient_id uuid,
    owner_user_id uuid NOT NULL,
    record_type_id uuid NOT NULL,
    title character varying(256) NOT NULL,
    metadata_json text,
    issue_date date,
    expiry_date date,
    storage_location character varying(512),
    is_encrypted boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    last_updated_at timestamp with time zone DEFAULT now() NOT NULL,
    "ExtraProperties" text,
    "ConcurrencyStamp" character varying(40),
    "CreatorId" uuid,
    "LastModificationTime" timestamp without time zone,
    "LastModifierId" uuid,
    "IsDeleted" boolean DEFAULT false NOT NULL,
    "DeleterId" uuid,
    "DeletionTime" timestamp without time zone
);


ALTER TABLE vault.vault_records OWNER TO postgres;

--
-- TOC entry 5816 (class 0 OID 23347)
-- Dependencies: 280
-- Data for Name: appointment_audits; Type: TABLE DATA; Schema: appointment; Owner: postgres
--

COPY appointment.appointment_audits (id, appointment_id, changed_by_user_id, old_status_id, new_status_id, change_time, comment, "ExtraProperties", "ConcurrencyStamp") FROM stdin;
\.


--
-- TOC entry 5814 (class 0 OID 23297)
-- Dependencies: 278
-- Data for Name: appointments; Type: TABLE DATA; Schema: appointment; Owner: postgres
--

COPY appointment.appointments (id, tenant_id, identity_patient_id, identity_doctor_id, start_time, end_time, status_id, channel_id, reason, notes, creation_time, "ExtraProperties", "ConcurrencyStamp", "CreatorId", "LastModificationTime", "LastModifierId", "IsDeleted", "DeleterId", "DeletionTime") FROM stdin;
\.


--
-- TOC entry 5815 (class 0 OID 23327)
-- Dependencies: 279
-- Data for Name: doctor_schedule_rules; Type: TABLE DATA; Schema: appointment; Owner: postgres
--

COPY appointment.doctor_schedule_rules (id, tenant_id, identity_doctor_id, day_of_week_id, start_time_of_day, end_time_of_day, slot_duration_minutes, creation_time, "ExtraProperties", "ConcurrencyStamp", "CreatorId", "LastModificationTime", "LastModifierId", "IsDeleted", "DeleterId", "DeletionTime") FROM stdin;
\.


--
-- TOC entry 5802 (class 0 OID 23049)
-- Dependencies: 266
-- Data for Name: appointment_channels; Type: TABLE DATA; Schema: configuration; Owner: postgres
--

COPY configuration.appointment_channels (id, code, name, description, sort_order, is_active) FROM stdin;
95e236e0-ed2a-45c8-bbd7-b4162e3f995f	IN_PERSON	In-person	Appointment at physical clinic	1	t
30866e6c-7aeb-452d-9da6-450fdae5aed0	VIDEO	Video	Video consultation	2	t
b30b9853-5735-4a9f-a9b4-598848adfc6b	PHONE	Phone	Phone consultation	3	t
\.


--
-- TOC entry 5801 (class 0 OID 23032)
-- Dependencies: 265
-- Data for Name: appointment_statuses; Type: TABLE DATA; Schema: configuration; Owner: postgres
--

COPY configuration.appointment_statuses (id, code, name, description, sort_order, is_active) FROM stdin;
6d2e8ae6-b2a8-432b-8b02-64a708554119	REQUESTED	Requested	Patient requested an appointment	1	t
802ae6c9-d7aa-4892-b326-edb42b46909a	CONFIRMED	Confirmed	Doctor/clinic confirmed the appointment	2	t
7db6455d-601f-48dc-a59b-2b0a90e05d5c	COMPLETED	Completed	Appointment completed	3	t
98a1dbbb-d8fe-4d9a-ab84-3f043d58dbab	CANCELLED	Cancelled	Appointment cancelled	4	t
3031e3f1-41c8-4947-855e-077753041717	NO_SHOW	No Show	Patient did not attend	5	t
\.


--
-- TOC entry 5805 (class 0 OID 23100)
-- Dependencies: 269
-- Data for Name: consent_party_types; Type: TABLE DATA; Schema: configuration; Owner: postgres
--

COPY configuration.consent_party_types (id, code, name, description, sort_order, is_active) FROM stdin;
4156d47c-c726-49f2-ac42-845ceb0ceb73	DOCTOR	Doctor	Individual doctor	1	t
11895445-1b09-4338-8b66-897cc7737533	ORGANIZATION	Organization	Healthcare organization	2	t
f376bd55-9037-48fa-acfc-a832d11f6805	FAMILY	Family	Family member / caregiver	3	t
\.


--
-- TOC entry 5806 (class 0 OID 23117)
-- Dependencies: 270
-- Data for Name: consent_statuses; Type: TABLE DATA; Schema: configuration; Owner: postgres
--

COPY configuration.consent_statuses (id, code, name, description, sort_order, is_active) FROM stdin;
26ff2db6-6b59-49ea-a3cc-0d9d3a060e70	ACTIVE	Active	Consent currently active	1	t
f5e6a575-4fc9-42ec-8d28-bff1e9dec0ef	REVOKED	Revoked	Consent revoked by patient	2	t
40158331-67bc-4699-86e8-fe46280f4a64	EXPIRED	Expired	Consent expired at end date	3	t
\.


--
-- TOC entry 5803 (class 0 OID 23066)
-- Dependencies: 267
-- Data for Name: days_of_week; Type: TABLE DATA; Schema: configuration; Owner: postgres
--

COPY configuration.days_of_week (id, code, name, description, sort_order, is_active) FROM stdin;
4a879e03-646e-478c-8985-61b79151c387	SUNDAY	Sunday	\N	1	t
03177006-3159-4cce-8eb0-fadb8d56e5bc	MONDAY	Monday	\N	2	t
ecc04dfc-5e43-46c6-93fd-42fc0d309e57	TUESDAY	Tuesday	\N	3	t
214e2e10-4c1d-4f3c-8855-2f60164cf935	WEDNESDAY	Wednesday	\N	4	t
6640f2fc-a47a-4bdc-ae5a-7120039e3def	THURSDAY	Thursday	\N	5	t
38fe3c03-bd0a-41c7-86cb-dfe08d8f8c4d	FRIDAY	Friday	\N	6	t
dbb0dbf7-442d-46fd-8e99-b57907d68458	SATURDAY	Saturday	\N	7	t
\.


--
-- TOC entry 5807 (class 0 OID 23134)
-- Dependencies: 271
-- Data for Name: device_types; Type: TABLE DATA; Schema: configuration; Owner: postgres
--

COPY configuration.device_types (id, code, name, description, sort_order, is_active) FROM stdin;
5613164d-c19f-4b8b-bbcf-b185e1d97a57	BLOOD_PRESSURE_MONITOR	Blood Pressure Monitor	BP Monitor	1	t
b0c917dd-3b76-4483-bc81-935ad6abea59	GLUCOMETER	Glucometer	Blood glucose meter	2	t
810abdb3-9e5c-4dd4-945b-64601bf0a7a4	WEIGHING_SCALE	Weighing Scale	Body weight scale	3	t
683ffb5e-5065-4141-9c39-8b39c7662d0f	GENERIC	Generic Device	Other device type	4	t
\.


--
-- TOC entry 5804 (class 0 OID 23083)
-- Dependencies: 268
-- Data for Name: medication_intake_statuses; Type: TABLE DATA; Schema: configuration; Owner: postgres
--

COPY configuration.medication_intake_statuses (id, code, name, description, sort_order, is_active) FROM stdin;
660a6bcf-39fd-4c5a-86b3-54d92b513d00	PENDING	Pending	Not yet taken	1	t
f8e8d637-1f2c-428e-a7f9-f70e5e8898e0	TAKEN	Taken	Dose taken as scheduled	2	t
15733538-c33e-4177-825d-7e82891ef292	SKIPPED	Skipped	Dose skipped	3	t
\.


--
-- TOC entry 5808 (class 0 OID 23151)
-- Dependencies: 272
-- Data for Name: notification_channels; Type: TABLE DATA; Schema: configuration; Owner: postgres
--

COPY configuration.notification_channels (id, code, name, description, sort_order, is_active) FROM stdin;
5bd892b3-cb30-43e7-bec3-a07284c542e8	EMAIL	Email	Email notification	1	t
de25d0cf-3ab3-4544-b23f-638f51bd3a80	SMS	SMS	Text message notification	2	t
93d53d37-e3ab-4519-90cf-ef429011e9b7	PUSH	Push	Mobile push notification	3	t
af4172a5-158a-40b9-9c99-a33c07921cf3	IN_APP	In-app	In-app notification	4	t
\.


--
-- TOC entry 5809 (class 0 OID 23168)
-- Dependencies: 273
-- Data for Name: notification_statuses; Type: TABLE DATA; Schema: configuration; Owner: postgres
--

COPY configuration.notification_statuses (id, code, name, description, sort_order, is_active) FROM stdin;
c9f084d9-4037-42be-8bb4-1477c7605303	PENDING	Pending	Queued for sending	1	t
8d326bac-2909-43fa-b0d6-72ad4e81fb68	SENT	Sent	Successfully sent	2	t
ccd08adf-6b17-4fa5-b3ac-30dadb14a9e6	FAILED	Failed	Failed to send	3	t
\.


--
-- TOC entry 5810 (class 0 OID 23185)
-- Dependencies: 274
-- Data for Name: vault_record_types; Type: TABLE DATA; Schema: configuration; Owner: postgres
--

COPY configuration.vault_record_types (id, code, name, description, sort_order, is_active) FROM stdin;
73530370-71d8-42c3-bb9e-7e6617bedef5	NATIONAL_ID	National ID	Generic national identification number	1	t
644fcbbf-2729-46df-8c80-c9e5b8c1de3a	EMIRATES_ID	Emirates ID	UAE Emirates ID card	2	t
48229da9-c6e2-4ded-9d6f-f3a375baecd4	PASSPORT	Passport	Passport document	3	t
13a3f5e5-b592-4067-816b-2b9a7e4fc2e1	INSURANCE	Health Insurance	Health insurance policy	4	t
8f35e127-52ca-4eb1-b300-f5678441be6e	MEDICAL_REPORT	Medical Report	Medical report or discharge summary	5	t
e23f9a52-7cc0-4696-b02b-1f2614c62e82	OTHER	Other	Other document type	99	t
\.


--
-- TOC entry 5822 (class 0 OID 23482)
-- Dependencies: 286
-- Data for Name: consent_audits; Type: TABLE DATA; Schema: consent; Owner: postgres
--

COPY consent.consent_audits (id, consent_id, action, performed_by_user_id, action_time, details, "ExtraProperties", "ConcurrencyStamp") FROM stdin;
\.


--
-- TOC entry 5821 (class 0 OID 23452)
-- Dependencies: 285
-- Data for Name: consents; Type: TABLE DATA; Schema: consent; Owner: postgres
--

COPY consent.consents (id, tenant_id, identity_patient_id, granted_to_party_type_id, granted_to_party_id, data_scope, purpose_of_use, granted_at, expires_at, status_id, "ExtraProperties", "ConcurrencyStamp", "CreatorId", "LastModificationTime", "LastModifierId", "IsDeleted", "DeleterId", "DeletionTime") FROM stdin;
\.


--
-- TOC entry 5824 (class 0 OID 23522)
-- Dependencies: 288
-- Data for Name: device_readings; Type: TABLE DATA; Schema: device; Owner: postgres
--

COPY device.device_readings (id, tenant_id, device_id, identity_patient_id, reading_time, reading_type, value1, value2, unit, raw_payload, "ExtraProperties", "ConcurrencyStamp") FROM stdin;
\.


--
-- TOC entry 5823 (class 0 OID 23502)
-- Dependencies: 287
-- Data for Name: devices; Type: TABLE DATA; Schema: device; Owner: postgres
--

COPY device.devices (id, tenant_id, device_serial, device_type_id, manufacturer, model, assigned_patient_id, assigned_at, is_active, creation_time, "ExtraProperties", "ConcurrencyStamp", "CreatorId", "LastModificationTime", "LastModifierId", "IsDeleted", "DeleterId", "DeletionTime") FROM stdin;
\.


--
-- TOC entry 5833 (class 0 OID 23972)
-- Dependencies: 297
-- Data for Name: chat_messages; Type: TABLE DATA; Schema: engagement; Owner: postgres
--

COPY engagement.chat_messages (id, tenant_id, session_id, sender_type, sender_user_id, content, content_format, is_from_ai_assistant, created_at, ai_context_json, "ExtraProperties", "ConcurrencyStamp", "CreationTime", "CreatorId", "LastModificationTime", "LastModifierId", "IsDeleted", "DeleterId", "DeletionTime") FROM stdin;
\.


--
-- TOC entry 5832 (class 0 OID 23950)
-- Dependencies: 296
-- Data for Name: chat_sessions; Type: TABLE DATA; Schema: engagement; Owner: postgres
--

COPY engagement.chat_sessions (id, tenant_id, identity_patient_id, created_by_user_id, session_type, related_appointment_id, started_at, ended_at, is_active, last_message_at, metadata_json, "ExtraProperties", "ConcurrencyStamp", "CreationTime", "CreatorId", "LastModificationTime", "LastModifierId", "IsDeleted", "DeleterId", "DeletionTime") FROM stdin;
\.


--
-- TOC entry 5825 (class 0 OID 23543)
-- Dependencies: 289
-- Data for Name: notification_templates; Type: TABLE DATA; Schema: engagement; Owner: postgres
--

COPY engagement.notification_templates (id, tenant_id, template_key, channel_id, subject_template, body_template, is_active, creation_time, "ExtraProperties", "ConcurrencyStamp", "CreatorId", "LastModificationTime", "LastModifierId", "IsDeleted", "DeleterId", "DeletionTime") FROM stdin;
32000000-0000-0000-0000-000000000001	00000000-0000-0000-0000-000000000001	AppointmentConfirmed	5bd892b3-cb30-43e7-bec3-a07284c542e8	Your appointment is confirmed	Dear {{PatientName}}, your appointment with {{DoctorName}} on {{AppointmentDate}} is confirmed.	t	2025-11-17 11:57:58.500008+04	\N	\N	\N	\N	\N	f	\N	\N
32000000-0000-0000-0000-000000000002	00000000-0000-0000-0000-000000000001	MedicationReminder	de25d0cf-3ab3-4544-b23f-638f51bd3a80	\N	Reminder: Please take your {{DrugName}} dose scheduled at {{Time}}.	t	2025-11-17 11:57:58.500008+04	\N	\N	\N	\N	\N	f	\N	\N
32000000-0000-0000-0000-000000000003	00000000-0000-0000-0000-000000000001	CriticalDeviceReading	af4172a5-158a-40b9-9c99-a33c07921cf3	\N	Alert: A critical {{ReadingType}} reading was received for {{PatientName}}.	t	2025-11-17 11:57:58.500008+04	\N	\N	\N	\N	\N	f	\N	\N
\.


--
-- TOC entry 5826 (class 0 OID 23565)
-- Dependencies: 290
-- Data for Name: notifications; Type: TABLE DATA; Schema: engagement; Owner: postgres
--

COPY engagement.notifications (id, tenant_id, recipient_user_id, channel_id, template_key, payload_json, created_at, sent_at, status_id, error_message, "ExtraProperties", "ConcurrencyStamp", "CreatorId", "LastModificationTime", "LastModifierId", "IsDeleted", "DeleterId", "DeletionTime") FROM stdin;
\.


--
-- TOC entry 5788 (class 0 OID 22727)
-- Dependencies: 252
-- Data for Name: AbpAuditLogActions; Type: TABLE DATA; Schema: identity; Owner: postgres
--

COPY identity."AbpAuditLogActions" ("Id", "TenantId", "AuditLogId", "ServiceName", "MethodName", "Parameters", "ExecutionTime", "ExecutionDuration", "ExtraProperties") FROM stdin;
3a1daa2e-4829-9986-2a1d-96bcaf028450	\N	3a1daa2e-4828-9b70-1729-8711a4cdecd0	Volo.Abp.Account.Web.Pages.Account.LoginModel	OnPostAsync	{"action":"Login"}	2025-11-18 17:27:00.93848	1490	{}
3a1daa2e-6493-a142-3aa9-c1ae51ae77eb	\N	3a1daa2e-6493-e47b-2a82-ffe30557a142	Volo.Abp.OpenIddict.Controllers.TokenController	HandleAsync	{}	2025-11-18 17:27:09.595227	32	{}
3a1daa2e-7b85-c3df-5f37-51dad4f04b58	\N	3a1daa2e-7b85-ddff-c74b-9629c08d74e8	Volo.Abp.OpenIddict.Controllers.TokenController	HandleAsync	{}	2025-11-18 17:27:15.53105	19	{}
3a1daa2f-2ae9-d36c-276a-9d1537e6f61f	\N	3a1daa2f-2ae9-22a4-e58c-51bcb0cf63c1	Volo.Abp.TenantManagement.TenantAppService	CreateAsync	{"input":{"adminEmailAddress":"admin@admin.com","name":"00000000-0000-0000-0000-000000000001","extraProperties":{}}}	2025-11-18 17:27:59.560792	914	{}
3a1daa2f-2ae9-dee7-1b6a-93b58ffd2cf2	\N	3a1daa2f-2ae9-22a4-e58c-51bcb0cf63c1	Volo.Abp.TenantManagement.TenantController	CreateAsync	{"input":{"adminEmailAddress":"admin@admin.com","name":"00000000-0000-0000-0000-000000000001","extraProperties":{}}}	2025-11-18 17:27:59.550917	933	{}
3a1daa30-5558-8683-3ec7-7088ded5e7a5	\N	3a1daa30-5558-dcb2-6cf9-09262fb63279	Volo.Abp.OpenIddict.Controllers.TokenController	HandleAsync	{}	2025-11-18 17:29:16.838704	14	{}
3a1db955-df30-af58-d758-309f3dc0efe8	\N	3a1db955-df2f-2508-2337-cf0c731f685a	Volo.Abp.Account.Web.Pages.Account.LoginModel	OnPostAsync	{"action":"Login"}	2025-11-21 16:04:34.080815	1156	{}
3a1db96b-406a-5917-9b33-8c4272bdc419	\N	3a1db96b-406a-514e-a5fe-6c93a04da080	Volo.Abp.OpenIddict.Controllers.TokenController	HandleAsync	{}	2025-11-21 16:27:56.282729	41	{}
3a1db96c-3523-3e40-3564-2a5cefd0cb9b	\N	3a1db96c-3523-08d7-7cea-eaabfe8732ec	Volo.Abp.PermissionManagement.PermissionAppService	GetAsync	{"providerName":null,"providerKey":null}	2025-11-21 16:28:58.993277	4	{}
3a1db96c-3523-9e2e-19fb-6f0ddd9e33a1	\N	3a1db96c-3523-08d7-7cea-eaabfe8732ec	Volo.Abp.PermissionManagement.PermissionsController	GetAsync	{}	2025-11-21 16:28:58.973018	27	{}
3a1db96c-a46e-d2f9-eb10-c4753d0f87b1	\N	3a1db96c-a46e-f1c4-2c4a-80148f843c80	Volo.Abp.OpenIddict.Controllers.TokenController	HandleAsync	{}	2025-11-21 16:29:27.465264	18	{}
3a1db96d-e592-423b-5225-349004c402e1	\N	3a1db96d-e592-e8b5-3779-777cb4a7724e	Volo.Abp.OpenIddict.Controllers.TokenController	HandleAsync	{}	2025-11-21 16:30:49.590732	53	{}
3a1db97e-b67d-2962-b642-bec238293ca7	\N	3a1db97e-b67c-abae-a1cd-e3d08ed09798	Volo.Abp.OpenIddict.Controllers.TokenController	HandleAsync	{}	2025-11-21 16:49:11.652313	45	{}
3a1db97e-beb7-ee07-ba06-bfe2f24bf860	\N	3a1db97e-beb7-79f1-8c49-c1333d7c4b71	Volo.Abp.OpenIddict.Controllers.TokenController	HandleAsync	{}	2025-11-21 16:49:13.846423	28	{}
3a1db9ba-15ad-b540-ba77-1653c652aaca	\N	3a1db9ba-15ad-4086-f10e-a2153234371a	Volo.Abp.OpenIddict.Controllers.TokenController	HandleAsync	{}	2025-11-21 17:54:02.68584	32	{}
3a1db9ba-1cad-9e69-ebdf-e49780c6319e	\N	3a1db9ba-1cad-735a-e238-f8273b8c68a6	Volo.Abp.OpenIddict.Controllers.TokenController	HandleAsync	{}	2025-11-21 17:54:04.542418	15	{}
3a1dbc8e-5ea2-ddb2-c910-b8780bff80ed	\N	3a1dbc8e-5ea2-d622-1737-3b3dcd63c7fd	Volo.Abp.Account.Web.Pages.Account.LoginModel	OnPostAsync	{"action":"Login"}	2025-11-22 07:05:09.165887	366	{}
3a1dbc90-646a-040d-d88f-d8d01d91db9d	\N	3a1dbc90-646a-bc59-e618-b9719f66eb91	Volo.Abp.Account.Web.Pages.Account.LoginModel	OnPostAsync	{"action":"Login"}	2025-11-22 07:07:21.913906	175	{}
3a1dbc91-c694-2839-b9e1-376a8bc431f4	\N	3a1dbc91-c694-e463-b95a-10c8b66dc529	Volo.Abp.Account.Web.Pages.Account.LoginModel	OnPostAsync	{"action":"Login"}	2025-11-22 07:08:52.624627	131	{}
3a1dbcb0-4c31-20ea-3867-41f36d4046c6	\N	3a1dbcb0-4c31-62f5-371e-8b209d25992c	Volo.Abp.Account.Web.Pages.Account.LoginModel	OnPostAsync	{"action":"Login"}	2025-11-22 07:42:12.073658	959	{}
3a1dbcd9-a086-880a-ed74-9a8dcbb0d8b9	\N	3a1dbcd9-a086-1157-bc0f-28177515e727	Volo.Abp.Account.Web.Pages.Account.LoginModel	OnPostAsync	{"action":"Login"}	2025-11-22 08:27:21.284089	315	{}
3a1dbcdb-7b7f-2344-2a19-7d97aeea76fa	\N	3a1dbcdb-7b7d-d6c7-6d5f-9d9405e93a6c	Volo.Abp.OpenIddict.Controllers.TokenController	HandleAsync	{}	2025-11-22 08:29:23.050645	48	{}
3a1dbcdb-8257-04c7-dc4a-e3cc705de075	\N	3a1dbcdb-8257-174e-2033-b2c3ab462fba	Volo.Abp.OpenIddict.Controllers.TokenController	HandleAsync	{}	2025-11-22 08:29:24.906096	12	{}
3a1dbcdc-01fb-34db-54a6-00f00a6868e4	\N	3a1dbcdc-01fb-3068-48d3-04e79e331b9e	Volo.Abp.Account.Web.Pages.Account.LoginModel	OnPostAsync	{"action":"Login"}	2025-11-22 08:29:57.363384	262	{}
3a1dbcdc-146a-7bd6-e30a-c8aa3adc4c9f	\N	3a1dbcdc-146a-6780-1d25-698d0d31fa8f	Volo.Abp.OpenIddict.Controllers.TokenController	HandleAsync	{}	2025-11-22 08:30:02.303088	14	{}
3a1dbcdc-297c-db6f-80bf-d9283c6dae25	\N	3a1dbcdc-297c-feb5-ef98-f61e6f4a43ee	Volo.Abp.OpenIddict.Controllers.TokenController	HandleAsync	{}	2025-11-22 08:30:07.702698	12	{}
3a1dbcdd-335b-05a8-8b07-fe98204b7556	\N	3a1dbcdd-335b-f411-7db2-d85521bf3e14	Volo.Abp.Identity.IdentityUserController	UpdateAsync	{"id":"3a1db416-b2b2-3609-98b4-058d6ceeb9d2","input":{"concurrencyStamp":"dafa089ff4854f60a4675da05624cd72","userName":"hostadmin","name":"Mohamed","surname":"Aarif","email":"mohamed.aarif.armaan@gmail.com","phoneNumber":"0553007928","isActive":true,"lockoutEnabled":false,"roleNames":["admin"],"extraProperties":{}}}	2025-11-22 08:31:15.521654	255	{}
3a1dbcdd-335b-ab53-2367-72888fa939a8	\N	3a1dbcdd-335b-f411-7db2-d85521bf3e14	Volo.Abp.Identity.IdentityUserAppService	UpdateAsync	{"id":"3a1db416-b2b2-3609-98b4-058d6ceeb9d2","input":{"concurrencyStamp":"dafa089ff4854f60a4675da05624cd72","userName":"hostadmin","name":"Mohamed","surname":"Aarif","email":"mohamed.aarif.armaan@gmail.com","phoneNumber":"0553007928","isActive":true,"lockoutEnabled":false,"roleNames":["admin"],"extraProperties":{}}}	2025-11-22 08:31:15.527126	239	{}
3a1dbcdd-7ca5-ba23-4b18-27ac38ac5118	\N	3a1dbcdd-7ca5-d0b7-677b-3dfd38991965	Volo.Abp.Identity.IdentityUserController	UpdateAsync	{"id":"3a1db416-b2b2-3609-98b4-058d6ceeb9d2","input":{"concurrencyStamp":"dafa089ff4854f60a4675da05624cd72","userName":"hostadmin","name":"Mohamed","surname":"Aarif","email":"mohamed.aarif.armaan@gmail.com","phoneNumber":"0553007928","isActive":true,"lockoutEnabled":false,"roleNames":["admin"],"extraProperties":{}}}	2025-11-22 08:31:34.359505	204	{}
3a1dbcdd-7ca5-c6ff-7648-c499015404f5	\N	3a1dbcdd-7ca5-d0b7-677b-3dfd38991965	Volo.Abp.Identity.IdentityUserAppService	UpdateAsync	{"id":"3a1db416-b2b2-3609-98b4-058d6ceeb9d2","input":{"concurrencyStamp":"dafa089ff4854f60a4675da05624cd72","userName":"hostadmin","name":"Mohamed","surname":"Aarif","email":"mohamed.aarif.armaan@gmail.com","phoneNumber":"0553007928","isActive":true,"lockoutEnabled":false,"roleNames":["admin"],"extraProperties":{}}}	2025-11-22 08:31:34.362013	201	{}
3a1dbcdd-a2fd-c628-0f5f-7f36aae9b0af	\N	3a1dbcdd-a2fd-1e5b-81f5-400e252ebf2a	Volo.Abp.OpenIddict.Controllers.TokenController	HandleAsync	{}	2025-11-22 08:31:44.329355	10	{}
3a1dbcde-fa02-4aaf-ff06-1dc64f229d38	\N	3a1dbcde-fa02-8d34-8bcc-ae32fff82b52	Volo.Abp.Account.Web.Pages.Account.LoginModel	OnPostAsync	{"action":"Login"}	2025-11-22 08:33:12.087867	106	{}
3a1dbcdf-0ede-bc45-eded-ab424c92767a	\N	3a1dbcdf-0ede-93a4-6560-9a21095793a8	Volo.Abp.OpenIddict.Controllers.TokenController	HandleAsync	{}	2025-11-22 08:33:17.48581	16	{}
3a1dbcdf-255d-3175-b22f-7b75cbad66ba	\N	3a1dbcdf-255d-5736-3aaf-3db76195b738	Volo.Abp.OpenIddict.Controllers.TokenController	HandleAsync	{}	2025-11-22 08:33:23.252177	10	{}
3a1dbd66-0dc7-50c9-bdae-37daf57af5ec	\N	3a1dbd66-0dc7-bcb7-7083-76a36bbee31d	Volo.Abp.Account.Web.Pages.Account.LoginModel	OnPostAsync	{"action":"Login"}	2025-11-22 11:00:43.921257	686	{}
3a1dbec8-2b3c-a080-5eb6-3cc0ca46ffd8	\N	3a1dbec8-2b3c-fe3c-f2a4-9f710dd58e46	Volo.Abp.Account.Web.Pages.Account.LoginModel	OnPostAsync	{"action":"Login"}	2025-11-22 17:27:30.859419	1033	{}
3a1dbec8-4972-8415-019a-4c0e5116e61d	\N	3a1dbec8-4972-0337-25c9-bb16e2826880	Volo.Abp.OpenIddict.Controllers.TokenController	HandleAsync	{}	2025-11-22 17:27:39.55602	20	{}
3a1dbec8-5f81-bf67-2d27-2ec5cfcc11d7	\N	3a1dbec8-5f81-9c49-2f95-d254d12ab252	Volo.Abp.OpenIddict.Controllers.TokenController	HandleAsync	{}	2025-11-22 17:27:45.232643	20	{}
3a1dbec8-8eae-3db5-58b0-44a1f906f476	\N	3a1dbec8-8eae-a166-ae6e-444c9152baa1	Volo.Abp.TenantManagement.TenantAppService	UpdateAsync	{"id":"3a1daa2f-274c-c133-f38f-6f5a98d37f7a","input":{"concurrencyStamp":"c9cef4c82fc34fb79e61c056f8640914","name":"Default Clinic","extraProperties":{}}}	2025-11-22 17:27:57.30426	43	{}
3a1dbec8-8eae-ab57-e419-0370eef16667	\N	3a1dbec8-8eae-a166-ae6e-444c9152baa1	Volo.Abp.TenantManagement.TenantController	UpdateAsync	{"id":"3a1daa2f-274c-c133-f38f-6f5a98d37f7a","input":{"concurrencyStamp":"c9cef4c82fc34fb79e61c056f8640914","name":"Default Clinic","extraProperties":{}}}	2025-11-22 17:27:57.300263	55	{}
3a1dbec9-7a5b-6a60-f53a-bc209872b589	\N	3a1dbec9-7a5b-37d3-9e2b-97097e8aa0f4	Volo.Abp.Account.Web.Pages.Account.LoginModel	OnPostAsync	{"action":"Login"}	2025-11-22 17:28:57.571933	119	{}
3a1dbec9-8ef1-b5fb-c245-1f0af020b999	\N	3a1dbec9-8ef1-ae0d-db76-7cec2822bee9	Volo.Abp.OpenIddict.Controllers.TokenController	HandleAsync	{}	2025-11-22 17:29:02.921286	10	{}
3a1dbec9-a4d1-039c-e102-26196231f1c6	\N	3a1dbec9-a4d1-dff2-1750-ab0780b6d795	Volo.Abp.OpenIddict.Controllers.TokenController	HandleAsync	{}	2025-11-22 17:29:08.509081	27	{}
3a1dbeca-8b52-c042-a9b8-0a1d3cedad03	\N	3a1dbeca-8b52-c158-d6b2-5cd747a326c8	Volo.Abp.Account.Web.Pages.Account.LoginModel	OnPostAsync	{"action":"Login"}	2025-11-22 17:30:07.344687	225	{}
3a1dbed7-6033-56f7-0c91-8d7f96102071	\N	3a1dbed7-6033-9ac9-22b7-813fb2b59296	Volo.Abp.Account.Web.Pages.Account.LoginModel	OnPostAsync	{"action":"Login"}	2025-11-22 17:44:08.292953	206	{}
3a1dbed8-1f21-a2ef-9936-9c145faaf994	\N	3a1dbed8-1f21-c25b-caf1-a8e2271647d5	Volo.Abp.Account.Web.Pages.Account.LoginModel	OnPostAsync	{"action":"Login"}	2025-11-22 17:44:57.147367	229	{}
3a1dbeda-9b3c-6afb-1ccb-d6fac39d64bc	\N	3a1dbeda-9b3c-15ce-1673-d34addee4aa0	Volo.Abp.Account.Web.Pages.Account.LoginModel	OnPostAsync	{"action":"Login"}	2025-11-22 17:47:40.087785	132	{}
3a1dbedf-6469-3e69-3d13-a69a89bd959c	\N	3a1dbedf-6469-212d-de1c-c4b7f0e40a98	Volo.Abp.Account.Web.Pages.Account.LoginModel	OnPostAsync	{"action":"Login"}	2025-11-22 17:52:53.585955	269	{}
3a1dbee9-0319-2eca-ec01-58104e596411	\N	3a1dbee9-0319-64f4-18a4-435716c866de	Volo.Abp.Account.Web.Pages.Account.LoginModel	OnPostAsync	{"action":"Login"}	2025-11-22 18:03:24.033262	270	{}
3a1dbeec-c553-495e-741d-86b4551a842a	\N	3a1dbeec-c553-2a6c-0445-af15d235ba96	Volo.Abp.Account.Web.Pages.Account.LoginModel	OnPostAsync	{"action":"Login"}	2025-11-22 18:07:30.318208	315	{}
3a1dbef8-4ab7-11d2-2332-241e97b25ced	\N	3a1dbef8-4ab7-2419-d226-46f4dc143220	Volo.Abp.Account.Web.Pages.Account.LoginModel	OnPostAsync	{"action":"Login"}	2025-11-22 18:20:05.391177	283	{}
3a1dc39f-11fa-2739-3415-0231b0927c18	\N	3a1dc39f-11f9-f06c-433d-5dd1813f844e	Volo.Abp.Account.Web.Pages.Account.LoginModel	OnPostAsync	{"action":"Login"}	2025-11-23 16:00:42.945125	1579	{}
3a1dc3a3-998b-257d-44ff-e3487aa5bfdf	\N	3a1dc3a3-998b-3508-5114-1ed70bf88c24	Volo.Abp.Account.Web.Pages.Account.LoginModel	OnPostAsync	{"action":"Login"}	2025-11-23 16:05:40.756104	623	{}
3a1dc3a7-3573-1615-ff84-b9fa7e03b63b	\N	3a1dc3a7-3573-2a0c-3772-b04124f0aa2a	Volo.Abp.Account.Web.Pages.Account.LoginModel	OnPostAsync	{"action":"Login"}	2025-11-23 16:09:37.790625	115	{}
3a1dc3a7-b0a8-9026-6d60-e430763e4e77	\N	3a1dc3a7-b0a8-d214-51e8-154b4d63fbac	Volo.Abp.Account.Web.Pages.Account.LoginModel	OnPostAsync	{"action":"Login"}	2025-11-23 16:10:09.330047	118	{}
3a1dc3ab-2839-b7fd-a11a-506b91ecd414	\N	3a1dc3ab-2838-3f3a-974f-a62caf97f2c3	Volo.Abp.Account.Web.Pages.Account.LoginModel	OnPostAsync	{"action":"Login"}	2025-11-23 16:13:55.612702	1043	{}
3a1dc3ab-a9c5-ed6d-1f9c-0b4f2d52938a	\N	3a1dc3ab-a9c5-7fe0-8772-688670caca70	Volo.Abp.Account.Web.Pages.Account.LoginModel	OnPostAsync	{"action":"Login"}	2025-11-23 16:14:29.6995	128	{}
3a1dc3b3-0e62-f36f-60d3-b98ea277f4d5	\N	3a1dc3b3-0e62-e37b-55f4-f470834f899c	Volo.Abp.Account.Web.Pages.Account.LoginModel	OnPostAsync	{"action":"Login"}	2025-11-23 16:22:33.40578	924	{}
3a1dc3b6-d4ce-4168-5ade-60a79e4ccf7d	\N	3a1dc3b6-d4ce-4d26-cc79-ac0ef11122c0	Volo.Abp.Account.Web.Pages.Account.LoginModel	OnPostAsync	{"action":"Login"}	2025-11-23 16:26:41.629371	112	{}
3a1dc3b7-3619-7e2f-46da-cbfc29a223cb	\N	3a1dc3b7-3619-59bc-f464-2664d044b678	Volo.Abp.Account.Web.Pages.Account.LoginModel	OnPostAsync	{"action":"Login"}	2025-11-23 16:27:06.468359	180	{}
3a1dc3b9-b650-395a-1055-585824f1bdc3	\N	3a1dc3b9-b64f-a967-7720-bab9704a38e8	Volo.Abp.Account.Web.Pages.Account.LoginModel	OnPostAsync	{"action":"Login"}	2025-11-23 16:29:49.488885	1046	{}
3a1dc3be-84dd-db62-79cb-99a123b66fe5	\N	3a1dc3be-84dd-084b-4d69-a496477a9ba3	Volo.Abp.Account.Web.Pages.Account.LoginModel	OnPostAsync	{"action":"Login"}	2025-11-23 16:35:04.613727	944	{}
3a1dc3c2-0bdb-41b3-b822-a809ec252e97	\N	3a1dc3c2-0bda-3e86-dbcc-37f6a8389689	Volo.Abp.Account.Web.Pages.Account.LoginModel	OnPostAsync	{"action":"Login"}	2025-11-23 16:38:56.231608	489	{}
3a1dc3ca-c031-63fe-b5ab-f36e551cd9e6	\N	3a1dc3ca-c031-552c-20fd-ad37cf7511e7	Volo.Abp.Account.Web.Pages.Account.LoginModel	OnPostAsync	{"action":"Login"}	2025-11-23 16:48:26.902471	274	{}
3a1dc3dc-ad7f-aa85-ae96-878a1ac49974	\N	3a1dc3dc-ad7e-947b-d784-c22d1124ed55	Volo.Abp.Account.Web.Pages.Account.LoginModel	OnPostAsync	{"action":"Login"}	2025-11-23 17:08:01.479151	560	{}
3a1dd683-7cc4-15a2-2f5a-b203d1948e88	\N	3a1dd683-7cc3-d8e1-475c-73896b71e7c5	Volo.Abp.Account.Web.Pages.Account.LoginModel	OnPostAsync	{"action":"Login"}	2025-11-27 08:03:22.655816	1307	{}
3a1dd683-a345-595c-086b-30560ff6dd21	\N	3a1dd683-a345-45bc-cfb7-78a84e317912	Volo.Abp.OpenIddict.Controllers.TokenController	HandleAsync	{}	2025-11-27 08:03:33.699448	43	{}
3a1dd683-be49-b42b-eb48-0e4675473d00	\N	3a1dd683-be49-be51-bad7-c4b0b93525e4	Volo.Abp.OpenIddict.Controllers.TokenController	HandleAsync	{}	2025-11-27 08:03:40.690833	21	{}
\.


--
-- TOC entry 5766 (class 0 OID 22433)
-- Dependencies: 230
-- Data for Name: AbpAuditLogExcelFiles; Type: TABLE DATA; Schema: identity; Owner: postgres
--

COPY identity."AbpAuditLogExcelFiles" ("Id", "TenantId", "FileName", "CreationTime", "CreatorId") FROM stdin;
\.


--
-- TOC entry 5767 (class 0 OID 22440)
-- Dependencies: 231
-- Data for Name: AbpAuditLogs; Type: TABLE DATA; Schema: identity; Owner: postgres
--

COPY identity."AbpAuditLogs" ("Id", "ApplicationName", "UserId", "UserName", "TenantId", "TenantName", "ImpersonatorUserId", "ImpersonatorUserName", "ImpersonatorTenantId", "ImpersonatorTenantName", "ExecutionTime", "ExecutionDuration", "ClientIpAddress", "ClientName", "ClientId", "CorrelationId", "BrowserInfo", "HttpMethod", "Url", "Exceptions", "Comments", "HttpStatusCode", "ExtraProperties", "ConcurrencyStamp") FROM stdin;
3a1daa2e-4828-9b70-1729-8711a4cdecd0	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-18 17:27:00.922169	1510	::1	\N	\N	43241a04c091453a8318646252522a40	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	POST	/Account/Login	\N		302	{}	f540fc5789fc4ebca95bd2d722e68662
3a1daa2e-6493-e47b-2a82-ffe30557a142	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-18 17:27:09.580956	134	::1	\N	\N	a031a0a50ea04e9684b25005ab46d9f0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	POST	/connect/token	\N		200	{}	407eee651efc4697bbd5876a2906180d
3a1daa2e-7b85-ddff-c74b-9629c08d74e8	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-18 17:27:15.522335	67	::1	\N	\N	64878d86fe4f4942a4a53993f41167a4	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	POST	/connect/token	\N		200	{}	1350df388e8841b2ae60c1f031995cb4
3a1daa2f-2ae9-22a4-e58c-51bcb0cf63c1	digihealth.HttpApi.Host	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	admin	\N	\N	\N	\N	\N	\N	2025-11-18 17:27:59.52223	967	::1	\N	digihealth_Blazor	76c2e3316ecb444c9826cfacef4534e2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	POST	/api/multi-tenancy/tenants	\N		200	{}	cc2a971de33347ca96c1e08e5208cb66
3a1daa30-5558-dcb2-6cf9-09262fb63279	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-18 17:29:16.837746	51	::1	\N	\N	d77e3b627be44356a0e987e8062e735f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	POST	/connect/token	\N		200	{}	99b29d869f5e4e51b95cb75b4cf03b10
3a1db955-df2f-2508-2337-cf0c731f685a	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-21 16:04:34.063075	1178	::1	\N	\N	cabf49cfeb0046bcab250284f7727169	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	POST	/Account/Login	\N		302	{}	9ba287ec3f314125a557392eab661aff
3a1db96b-406a-514e-a5fe-6c93a04da080	digihealth.HttpApi.Host	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	admin	\N	\N	\N	\N	\N	\N	2025-11-21 16:27:56.278176	111	::1	\N	\N	3a21070bb2814def9dd2b151ec552e94	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	POST	/connect/token	\N		200	{}	0f09ad79bb6540e687e948cf3044819c
3a1db96c-3523-08d7-7cea-eaabfe8732ec	digihealth.HttpApi.Host	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	admin	\N	\N	\N	\N	\N	\N	2025-11-21 16:28:58.859466	183	::1	\N	digihealth_Swagger	4d5324bfb7824d05ad6333bfce271c53	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	GET	/api/permission-management/permissions	[\r\n  {\r\n    "code": null,\r\n    "message": "An internal error occurred during your request!",\r\n    "details": null,\r\n    "data": null,\r\n    "validationErrors": null\r\n  }\r\n]		500	{}	3bb19c494c6b478aa8384c5c4de95305
3a1db96c-a46e-f1c4-2c4a-80148f843c80	digihealth.HttpApi.Host	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	admin	\N	\N	\N	\N	\N	\N	2025-11-21 16:29:27.464046	70	::1	\N	\N	82fb89da378743fa89fef7c56831826e	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	POST	/connect/token	\N		200	{}	47f5cd9af21f4f9a86ff99ea7ca81130
3a1db96d-e592-e8b5-3779-777cb4a7724e	digihealth.HttpApi.Host	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	admin	\N	\N	\N	\N	\N	\N	2025-11-21 16:30:49.5835	155	::1	\N	\N	a37d58a898de41898b928f09dee68e65	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	POST	/connect/token	\N		200	{}	643ef5ddbf974053a16d27b09bcaf456
3a1db97e-b67c-abae-a1cd-e3d08ed09798	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-21 16:49:11.646725	151	::1	\N	\N	8ba140bac7b44a64bb0121f1d1a24875	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	POST	/connect/token	\N		200	{}	764a2d4f90a04807ac5ce89e12d39722
3a1db97e-beb7-79f1-8c49-c1333d7c4b71	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-21 16:49:13.842667	68	::1	\N	\N	6e9d4121afdb422893471a0c8743415e	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	POST	/connect/token	\N		200	{}	e68a8e6a9c4d4985a3a01257d18dcab4
3a1db9ba-15ad-4086-f10e-a2153234371a	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-21 17:54:02.681792	111	::1	\N	\N	78ffd24104994784b43d92ba5124d4d5	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	POST	/connect/token	\N		200	{}	70cc4f60ecb4423ca67904894d39036a
3a1db9ba-1cad-735a-e238-f8273b8c68a6	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-21 17:54:04.540844	48	::1	\N	\N	58a1c188064b43c29f2e6a038712c637	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	POST	/connect/token	\N		200	{}	a043a47a07864be68ec56e35dd1835ad
3a1dbc8e-5ea2-d622-1737-3b3dcd63c7fd	digihealth.HttpApi.Host	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	admin	\N	\N	\N	\N	\N	\N	2025-11-22 07:05:09.144361	389	::1	\N	\N	b37739cfd193457b94fcb553bef02086	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	POST	/Account/Login	\N		302	{}	44535d04682a439091d547e444046843
3a1dbc90-646a-bc59-e618-b9719f66eb91	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-22 07:07:21.895422	195	::1	\N	\N	38defeeecf994c5f8431dbdab76977b6	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0	POST	/Account/Login	\N		302	{}	6b897e8ad37b45a09e77ddd5f7dda362
3a1dbc91-c694-e463-b95a-10c8b66dc529	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-22 07:08:52.611931	144	::1	\N	\N	0f63143b7ca64456ada3dfbb8c05c5a9	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	POST	/Account/Login	\N		302	{}	426e1fc575b24905863fffd75d2f35ae
3a1dbcb0-4c31-62f5-371e-8b209d25992c	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-22 07:42:12.059215	978	::1	\N	\N	c8df188499714dfc8c294ad33ec91579	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	POST	/Account/Login	\N		302	{}	9b36588b64bb40f5ad53824e47271b90
3a1dbcd9-a086-1157-bc0f-28177515e727	digihealth.HttpApi.Host	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	admin	\N	\N	\N	\N	\N	\N	2025-11-22 08:27:21.271871	329	::1	\N	\N	f2e902433396405a875853942861a3ca	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	POST	/Account/Login	\N		302	{}	7bb10492cca449a0b2d823475771503b
3a1dbcdb-7b7d-d6c7-6d5f-9d9405e93a6c	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-22 08:29:23.044752	148	::1	\N	\N	10383220a3144e08bd1c0609d6cd65f6	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	POST	/connect/token	\N		200	{}	85c81682b6a14f67a3a7266da1067113
3a1dbcdb-8257-174e-2033-b2c3ab462fba	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-22 08:29:24.904995	46	::1	\N	\N	b125143850964feaa6c2a5794ecc969f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	POST	/connect/token	\N		200	{}	03b0953137a04b58afb773c37ab4a3d3
3a1dbcdc-01fb-3068-48d3-04e79e331b9e	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-22 08:29:57.341781	285	::1	\N	\N	2a27978b976449f1b2cee34d0249064f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	POST	/Account/Login	\N		302	{}	dcd173cbd508472fb21c60213ad19ce8
3a1dbcdc-146a-6780-1d25-698d0d31fa8f	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-22 08:30:02.299973	46	::1	\N	\N	0432b6bf850749e2959f67e49fdd0dac	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	POST	/connect/token	\N		200	{}	aec4201d936a4fb5a34d81a62dc8f0cf
3a1dbcdc-297c-feb5-ef98-f61e6f4a43ee	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-22 08:30:07.70014	40	::1	\N	\N	a454a9b88daf4ed9a6afbb98271b92a9	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	POST	/connect/token	\N		200	{}	eae5e08d455d433c8cd66128da2a7487
3a1dbcdd-7ca5-d0b7-677b-3dfd38991965	digihealth.HttpApi.Host	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	admin	\N	\N	\N	\N	\N	\N	2025-11-22 08:31:34.355917	210	::1	\N	digihealth_Blazor	63458c01c9eb4ea98f570e4718bdc9eb	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	PUT	/api/identity/users/3a1db416-b2b2-3609-98b4-058d6ceeb9d2	\N		200	{}	aef36f2ff2de4978893886ee617c2659
3a1dbcdd-335b-f411-7db2-d85521bf3e14	digihealth.HttpApi.Host	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	admin	\N	\N	\N	\N	\N	\N	2025-11-22 08:31:15.49909	304	::1	\N	digihealth_Blazor	1d965e94342e471daac0c80de31fe08e	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	PUT	/api/identity/users/3a1db416-b2b2-3609-98b4-058d6ceeb9d2	[\r\n  {\r\n    "code": "Volo.Abp.Identity:PasswordRequiresUpper",\r\n    "message": "Passwords must have at least one uppercase ('A'-'Z').",\r\n    "details": null,\r\n    "data": {},\r\n    "validationErrors": null\r\n  }\r\n]		403	{}	870884a690fe44ea97ef5d963948d769
3a1dbcdd-a2fd-1e5b-81f5-400e252ebf2a	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-22 08:31:44.328233	54	::1	\N	\N	9551e0a4dca6463695425f912d97dce2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	POST	/connect/token	\N		200	{}	e7087f05e1414cfcabf9b03f55dc7e71
3a1dbcde-fa02-8d34-8bcc-ae32fff82b52	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-22 08:33:12.079318	115	::1	\N	\N	869b8bd8c8294b5dba21c97bc6ee4758	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	POST	/Account/Login	\N		302	{}	90178545a3114939b76ef78b8f77ef48
3a1dbcdf-0ede-93a4-6560-9a21095793a8	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-22 08:33:17.484393	50	::1	\N	\N	68f0b81d15594032859c468a4f6504bd	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	POST	/connect/token	\N		200	{}	56082cdd66514a0491bfa23a29ed65da
3a1dbcdf-255d-5736-3aaf-3db76195b738	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-22 08:33:23.250778	43	::1	\N	\N	f91e61b76ce645319b3ed14609fc43ec	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	POST	/connect/token	\N		200	{}	7261cbfef07f4fc48aaf214d8d7150bd
3a1dbd66-0dc7-bcb7-7083-76a36bbee31d	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-22 11:00:43.90612	705	::1	\N	\N	c08ad9e73b834b478d4eba5b08be84d5	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	POST	/Account/Login	\N		302	{}	aadd1f1289fc426099ba80d38abb9edc
3a1dbec8-2b3c-fe3c-f2a4-9f710dd58e46	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-22 17:27:30.844739	1051	::1	\N	\N	1a98e41ca78e467fbc23e0e1bc2fc0fd	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	POST	/Account/Login	\N		302	{}	6e1c6bd5341f4d2a9270298412390774
3a1dbec8-4972-0337-25c9-bb16e2826880	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-22 17:27:39.551614	82	::1	\N	\N	8ce0fc2dc80c4230bdf6c4a46815cf7a	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	POST	/connect/token	\N		200	{}	98bd08ed46694ca9bd68f978f8543c29
3a1dbec8-5f81-9c49-2f95-d254d12ab252	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-22 17:27:45.229486	52	::1	\N	\N	7591d700be8e43d583889c9e96379699	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	POST	/connect/token	\N		200	{}	682069b8541646e5a067d78fdbb38fb7
3a1dbec8-8eae-a166-ae6e-444c9152baa1	digihealth.HttpApi.Host	3a1dbd64-c316-bace-f69e-a0e93968898b	admin	\N	\N	\N	\N	\N	\N	2025-11-22 17:27:57.278409	80	::1	\N	digihealth_Blazor	a47fd2a5fc11488080f684a05bd069cd	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	PUT	/api/multi-tenancy/tenants/3a1daa2f-274c-c133-f38f-6f5a98d37f7a	\N		200	{}	75a625b50d134c82b232865b76060836
3a1dbec9-7a5b-37d3-9e2b-97097e8aa0f4	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-22 17:28:57.561498	130	::1	\N	\N	e90705d33bad43d0ba603dcbf463f473	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	POST	/Account/Login	\N		302	{}	c4b9c347abac4c418098e59ce204c37a
3a1dbec9-8ef1-ae0d-db76-7cec2822bee9	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-22 17:29:02.918653	43	::1	\N	\N	c91df843d2df4f1d8d0714e303d5fb62	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	POST	/connect/token	\N		200	{}	6100b02819844066ae5b63a85ecd1f5b
3a1dbec9-a4d1-dff2-1750-ab0780b6d795	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-22 17:29:08.507212	54	::1	\N	\N	366d618b807a4a858d3d5ec1f3f6e79e	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	POST	/connect/token	\N		200	{}	ca79e8dae55f4574b89104e426726b92
3a1dbeca-8b52-c158-d6b2-5cd747a326c8	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-22 17:30:07.330542	240	::1	\N	\N	b876388ca23c42e9903ea0805f0709a0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	POST	/Account/Login	\N		302	{}	5a1c7a9e61474f23afb9b59ef6dfe5b4
3a1dbed7-6033-9ac9-22b7-813fb2b59296	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-22 17:44:08.283576	215	::1	\N	\N	989c1447d68845ff98b817a74195c1b5	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	POST	/Account/Login	\N		302	{}	92174c34cd634b7f8292ea9c1dd1471a
3a1dbed8-1f21-c25b-caf1-a8e2271647d5	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-22 17:44:57.125121	252	::1	\N	\N	115c6e8f568f4371acc4c0853b0ee3f0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	POST	/Account/Login	\N		302	{}	f02743cae003430f9bccbf3d550ae323
3a1dbeda-9b3c-15ce-1673-d34addee4aa0	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-22 17:47:40.079518	141	::1	\N	\N	cd0b80031bc549ed8a5e3321a75c83bb	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	POST	/Account/Login	\N		302	{}	ddb650f36ace4983bb8f179760c16954
3a1dbedf-6469-212d-de1c-c4b7f0e40a98	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-22 17:52:53.570499	288	::1	\N	\N	6b0fe5492e454df4b2859d75ec959f8e	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	POST	/Account/Login	\N		302	{}	05e74d29c97f4e05bef8b330fa6934cf
3a1dbee9-0319-64f4-18a4-435716c866de	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-22 18:03:24.017755	289	::1	\N	\N	dc4d2ae7baa744679fd2f0922ca8aced	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	POST	/Account/Login	\N		302	{}	881ac674d63342628c56bcf7e3cfee95
3a1dbeec-c553-2a6c-0445-af15d235ba96	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-22 18:07:30.304169	332	::1	\N	\N	afd991013a45474281c12a0dc2bea910	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	POST	/Account/Login	\N		302	{}	2c07c83665d6493099ab32aa00b5f7b3
3a1dbef8-4ab7-2419-d226-46f4dc143220	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-22 18:20:05.367805	314	::1	\N	\N	63eeb7da798548dc8683f402e0c44d52	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	POST	/Account/Login	\N		302	{}	9ecf0bff14aa4390b7454b5ddfd4fca6
3a1dc39f-11f9-f06c-433d-5dd1813f844e	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-23 16:00:42.927366	1601	::1	\N	\N	58e55067a7774d86914207514ec08f54	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	POST	/Account/Login	\N		302	{}	31b14a28f75a4bbdbdbdebbfa89f66c0
3a1dc3a3-998b-3508-5114-1ed70bf88c24	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-23 16:05:40.742982	640	::1	\N	\N	ec6168df76354bdea1d52cf54f2acb6f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0	POST	/Account/Login	\N		302	{}	8978ed6e8a81452d9fa12378929a4b74
3a1dc3a7-3573-2a0c-3772-b04124f0aa2a	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-23 16:09:37.774207	133	::1	\N	\N	f2f2e3a036564e26af205ca56f2cfc89	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0	POST	/Account/Login	\N		302	{}	ba48d6b64b0a4afe9eaf1b5f015d9e0c
3a1dc3a7-b0a8-d214-51e8-154b4d63fbac	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-23 16:10:09.319922	128	::1	\N	\N	546f8d08f18e43dea05db8dc8ea86ddf	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0	POST	/Account/Login	\N		302	{}	d09eb43ee36243feb9a83eab891b0293
3a1dc3ab-2838-3f3a-974f-a62caf97f2c3	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-23 16:13:55.599608	1061	::1	\N	\N	d5048cc0391b4f92adc8445d4243f0e5	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0	POST	/Account/Login	\N		302	{}	96ba3a2ed5c841a8824533a1e946eca2
3a1dc3ab-a9c5-7fe0-8772-688670caca70	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-23 16:14:29.682868	146	::1	\N	\N	791f40eb629d4ab59224aaf9cf052a22	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0	POST	/Account/Login	\N		302	{}	bc192279af904996ab3ac1dad2250f6d
3a1dc3b3-0e62-e37b-55f4-f470834f899c	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-23 16:22:33.39184	942	::1	\N	\N	9e1a3251061b4114a3dea32fbb39c0db	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0	POST	/Account/Login	\N		302	{}	1d8b71becd66470e857b769610021609
3a1dc3b6-d4ce-4d26-cc79-ac0ef11122c0	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-23 16:26:41.612042	130	::1	\N	\N	cc17d9a3217c42b5a12ba2ba5db1929f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0	POST	/Account/Login	\N		302	{}	fc45d687a95a4e00af780c7d59d31dfd
3a1dc3b7-3619-59bc-f464-2664d044b678	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-23 16:27:06.448446	201	::1	\N	\N	1549539b18214772a9611d6df5f15a6a	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0	POST	/Account/Login	\N		302	{}	3939b97ac8804cd0b661d98c56e96f06
3a1dc3b9-b64f-a967-7720-bab9704a38e8	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-23 16:29:49.477785	1060	::1	\N	\N	ed4a062120ae4e409bd6cd35b460f2f8	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0	POST	/Account/Login	\N		302	{}	d1bab3aa7357450fb9199893187d1a18
3a1dc3be-84dd-084b-4d69-a496477a9ba3	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-23 16:35:04.601114	960	::1	\N	\N	e2208b72199b46b7b9474cdc1e8fdde0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0	POST	/Account/Login	\N		302	{}	82704f34143c4e6ba4c9b2d83cd8f5e0
3a1dc3c2-0bda-3e86-dbcc-37f6a8389689	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-23 16:38:56.2165	507	::1	\N	\N	d26ec5271057462bafc955a258e3802e	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0	POST	/Account/Login	\N		302	{}	6ef8771e187b4f0385dc350045976b26
3a1dc3ca-c031-552c-20fd-ad37cf7511e7	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-23 16:48:26.8892	291	::1	\N	\N	0b2c2eb89fb84e2988c4c30647dbe36a	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0	POST	/Account/Login	\N		302	{}	883b3211a4244f55954fa91cd3b4621d
3a1dc3dc-ad7e-947b-d784-c22d1124ed55	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-23 17:08:01.461767	581	::1	\N	\N	b748175691124859b3a067581d053f04	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0	POST	/Account/Login	\N		302	{}	0e366231ed9a45639d2297471f58fcde
3a1dd683-7cc3-d8e1-475c-73896b71e7c5	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-27 08:03:22.639337	1327	::1	\N	\N	bdb98bfc0f4649babdc210a83a34be63	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0	POST	/Account/Login	\N		302	{}	ffe09673aa0445d39eb1780a631ffeb9
3a1dd683-a345-45bc-cfb7-78a84e317912	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-27 08:03:33.691707	137	::1	\N	\N	71763fe7e986406c800662561ec6724b	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0	POST	/connect/token	\N		200	{}	f53d37571dd041418a9094cf345b2451
3a1dd683-be49-be51-bad7-c4b0b93525e4	digihealth.HttpApi.Host	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-27 08:03:40.689271	56	::1	\N	\N	2bfb1c1d7f7444eea31a5bc3f5c5a662	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0	POST	/connect/token	\N		200	{}	583db58b1dbb417aac5750cd892421e6
\.


--
-- TOC entry 5768 (class 0 OID 22452)
-- Dependencies: 232
-- Data for Name: AbpBackgroundJobs; Type: TABLE DATA; Schema: identity; Owner: postgres
--

COPY identity."AbpBackgroundJobs" ("Id", "ApplicationName", "JobName", "JobArgs", "TryCount", "CreationTime", "NextTryTime", "LastTryTime", "IsAbandoned", "Priority", "ExtraProperties", "ConcurrencyStamp") FROM stdin;
\.


--
-- TOC entry 5769 (class 0 OID 22472)
-- Dependencies: 233
-- Data for Name: AbpClaimTypes; Type: TABLE DATA; Schema: identity; Owner: postgres
--

COPY identity."AbpClaimTypes" ("Id", "Name", "Required", "IsStatic", "Regex", "RegexDescription", "Description", "ValueType", "CreationTime", "ExtraProperties", "ConcurrencyStamp") FROM stdin;
\.


--
-- TOC entry 5789 (class 0 OID 22743)
-- Dependencies: 253
-- Data for Name: AbpEntityChanges; Type: TABLE DATA; Schema: identity; Owner: postgres
--

COPY identity."AbpEntityChanges" ("Id", "AuditLogId", "TenantId", "ChangeTime", "ChangeType", "EntityTenantId", "EntityId", "EntityTypeFullName", "ExtraProperties") FROM stdin;
\.


--
-- TOC entry 5799 (class 0 OID 22901)
-- Dependencies: 263
-- Data for Name: AbpEntityPropertyChanges; Type: TABLE DATA; Schema: identity; Owner: postgres
--

COPY identity."AbpEntityPropertyChanges" ("Id", "TenantId", "EntityChangeId", "NewValue", "OriginalValue", "PropertyName", "PropertyTypeFullName") FROM stdin;
\.


--
-- TOC entry 5770 (class 0 OID 22487)
-- Dependencies: 234
-- Data for Name: AbpFeatureGroups; Type: TABLE DATA; Schema: identity; Owner: postgres
--

COPY identity."AbpFeatureGroups" ("Id", "Name", "DisplayName", "ExtraProperties") FROM stdin;
3a1da9ee-e9ce-e1c4-a175-fbd88843c98c	SettingManagement	L:AbpSettingManagement,Feature:SettingManagementGroup	{}
\.


--
-- TOC entry 5772 (class 0 OID 22510)
-- Dependencies: 236
-- Data for Name: AbpFeatureValues; Type: TABLE DATA; Schema: identity; Owner: postgres
--

COPY identity."AbpFeatureValues" ("Id", "Name", "Value", "ProviderName", "ProviderKey") FROM stdin;
\.


--
-- TOC entry 5771 (class 0 OID 22497)
-- Dependencies: 235
-- Data for Name: AbpFeatures; Type: TABLE DATA; Schema: identity; Owner: postgres
--

COPY identity."AbpFeatures" ("Id", "GroupName", "Name", "ParentName", "DisplayName", "Description", "DefaultValue", "IsVisibleToClients", "IsAvailableToHost", "AllowedProviders", "ValueType", "ExtraProperties") FROM stdin;
3a1da9ee-e9d4-267a-f497-b1b03cc22a1a	SettingManagement	SettingManagement.Enable	\N	L:AbpSettingManagement,Feature:SettingManagementEnable	L:AbpSettingManagement,Feature:SettingManagementEnableDescription	true	t	f	\N	{"name":"ToggleStringValueType","properties":{},"validator":{"name":"BOOLEAN","properties":{}}}	{}
3a1da9ee-ea35-fd63-0d7a-d3235802712e	SettingManagement	SettingManagement.AllowChangingEmailSettings	SettingManagement.Enable	L:AbpSettingManagement,Feature:AllowChangingEmailSettings	\N	false	t	f	\N	{"name":"ToggleStringValueType","properties":{},"validator":{"name":"BOOLEAN","properties":{}}}	{}
\.


--
-- TOC entry 5773 (class 0 OID 22518)
-- Dependencies: 237
-- Data for Name: AbpLinkUsers; Type: TABLE DATA; Schema: identity; Owner: postgres
--

COPY identity."AbpLinkUsers" ("Id", "SourceUserId", "SourceTenantId", "TargetUserId", "TargetTenantId") FROM stdin;
\.


--
-- TOC entry 5790 (class 0 OID 22760)
-- Dependencies: 254
-- Data for Name: AbpOrganizationUnitRoles; Type: TABLE DATA; Schema: identity; Owner: postgres
--

COPY identity."AbpOrganizationUnitRoles" ("RoleId", "OrganizationUnitId", "TenantId", "CreationTime", "CreatorId") FROM stdin;
\.


--
-- TOC entry 5774 (class 0 OID 22526)
-- Dependencies: 238
-- Data for Name: AbpOrganizationUnits; Type: TABLE DATA; Schema: identity; Owner: postgres
--

COPY identity."AbpOrganizationUnits" ("Id", "TenantId", "ParentId", "Code", "DisplayName", "EntityVersion", "ExtraProperties", "ConcurrencyStamp", "CreationTime", "CreatorId", "LastModificationTime", "LastModifierId", "IsDeleted", "DeleterId", "DeletionTime") FROM stdin;
\.


--
-- TOC entry 5775 (class 0 OID 22547)
-- Dependencies: 239
-- Data for Name: AbpPermissionGrants; Type: TABLE DATA; Schema: identity; Owner: postgres
--

COPY identity."AbpPermissionGrants" ("Id", "TenantId", "Name", "ProviderName", "ProviderKey") FROM stdin;
3a1da2e4-2fc2-04c5-2415-331f13d44e6b	\N	AbpIdentity.Users.Create	R	admin
3a1da2e4-2fc2-17d8-f1c8-598577fe39cb	\N	AbpIdentity.Users	R	admin
3a1da2e4-2fc2-1c1d-2e95-25e2a853fc04	\N	AbpIdentity.Users.ManagePermissions	R	admin
3a1da2e4-2fc2-22cd-29ac-e73289a37539	\N	AbpIdentity.Roles.ManagePermissions	R	admin
3a1da2e4-2fc2-2c2a-09b1-862ab1c04f1b	\N	AbpTenantManagement.Tenants	R	admin
3a1da2e4-2fc2-3630-89b7-2897925762f9	\N	FeatureManagement.ManageHostFeatures	R	admin
3a1da2e4-2fc2-3d6c-9e7e-2ef980d6c6e5	\N	AbpTenantManagement.Tenants.Create	R	admin
3a1da2e4-2fc2-5337-05c8-4e31c4cddee4	\N	SettingManagement.Emailing.Test	R	admin
3a1da2e4-2fc2-647c-d4ca-56eb33f84828	\N	SettingManagement.TimeZone	R	admin
3a1da2e4-2fc2-6483-0f3a-4318cb0d501e	\N	AbpTenantManagement.Tenants.ManageFeatures	R	admin
3a1da2e4-2fc2-73e4-eee5-07c519d1e675	\N	AbpIdentity.Roles.Update	R	admin
3a1da2e4-2fc2-a2f9-89d0-5a2262c458f0	\N	AbpIdentity.Users.Update	R	admin
3a1da2e4-2fc2-a824-152e-c0586c600990	\N	AbpIdentity.Roles.Create	R	admin
3a1da2e4-2fc2-a90c-e676-b966f1776bd7	\N	AbpTenantManagement.Tenants.ManageConnectionStrings	R	admin
3a1da2e4-2fc2-bfbf-7eb1-a6007277ab74	\N	AbpIdentity.Roles.Delete	R	admin
3a1da2e4-2fc2-c188-0aaa-1577370b7a92	\N	AbpTenantManagement.Tenants.Delete	R	admin
3a1da2e4-2fc2-c27e-76c9-8622f32dbb9c	\N	AbpIdentity.Users.Delete	R	admin
3a1da2e4-2fc2-cc01-d71d-d31c15750120	\N	AbpIdentity.Users.Update.ManageRoles	R	admin
3a1da2e4-2fc2-d09a-055a-b10d79c0e08b	\N	AbpTenantManagement.Tenants.Update	R	admin
3a1da2e4-2fc2-d390-82b6-1af5e61d8fd3	\N	SettingManagement.Emailing	R	admin
3a1da2e4-2fc2-ea5e-1782-4f97b46a32fb	\N	AbpIdentity.Roles	R	admin
3a1daa2f-2aa9-543e-c8d2-d853fbd8a707	3a1daa2f-274c-c133-f38f-6f5a98d37f7a	AbpIdentity.Roles	R	admin
3a1daa2f-2aaa-0e22-c24a-c215633035aa	3a1daa2f-274c-c133-f38f-6f5a98d37f7a	AbpIdentity.Users.ManagePermissions	R	admin
3a1daa2f-2aaa-1360-1ff6-bd344013490d	3a1daa2f-274c-c133-f38f-6f5a98d37f7a	AbpIdentity.Users.Create	R	admin
3a1daa2f-2aaa-1f1a-3295-795d6fb17bca	3a1daa2f-274c-c133-f38f-6f5a98d37f7a	SettingManagement.Emailing	R	admin
3a1daa2f-2aaa-3546-7dd4-29ac8960d72b	3a1daa2f-274c-c133-f38f-6f5a98d37f7a	AbpIdentity.Users.Delete	R	admin
3a1daa2f-2aaa-66d5-1409-a67d5be005a0	3a1daa2f-274c-c133-f38f-6f5a98d37f7a	AbpIdentity.Users	R	admin
3a1daa2f-2aaa-7cfe-1e45-2774900d3a45	3a1daa2f-274c-c133-f38f-6f5a98d37f7a	AbpIdentity.Roles.ManagePermissions	R	admin
3a1daa2f-2aaa-aeb2-2eed-dabcf798bcec	3a1daa2f-274c-c133-f38f-6f5a98d37f7a	AbpIdentity.Roles.Update	R	admin
3a1daa2f-2aaa-cb29-0c20-629c58e100ff	3a1daa2f-274c-c133-f38f-6f5a98d37f7a	AbpIdentity.Users.Update	R	admin
3a1daa2f-2aaa-ccbe-80d7-ef494ec98d22	3a1daa2f-274c-c133-f38f-6f5a98d37f7a	AbpIdentity.Roles.Create	R	admin
3a1daa2f-2aaa-d5e0-4c19-24bf5b242674	3a1daa2f-274c-c133-f38f-6f5a98d37f7a	SettingManagement.Emailing.Test	R	admin
3a1daa2f-2aaa-d6ca-8905-879404561184	3a1daa2f-274c-c133-f38f-6f5a98d37f7a	SettingManagement.TimeZone	R	admin
3a1daa2f-2aaa-e596-83f9-da19a1cf06a0	3a1daa2f-274c-c133-f38f-6f5a98d37f7a	AbpIdentity.Roles.Delete	R	admin
3a1daa2f-2aaa-f40c-ac32-78c19d6f9880	3a1daa2f-274c-c133-f38f-6f5a98d37f7a	AbpIdentity.Users.Update.ManageRoles	R	admin
3a1db416-b74c-2cbf-f9fb-39b9eee0e419	\N	IdentityService.Patients	R	admin
3a1db416-b74c-5367-d52f-db43a8d21627	\N	IdentityService.Doctors	R	admin
3a1db416-b74c-7923-b3c8-ae992bc19a01	\N	IdentityService.Patients.Manage	R	admin
3a1db416-b74c-a25f-4579-871d1f3df8b4	\N	IdentityService.Profile	R	admin
3a1db416-b74c-afb0-4ee9-985a27cf545a	\N	IdentityService.Doctors.Manage	R	admin
3a1db7b4-7845-676d-b7a8-567a478499d1	\N	IdentityService.FamilyLinks	R	admin
3a1db7b4-7846-9529-6c97-2e7e844d56c6	\N	IdentityService.FamilyLinks.Manage	R	admin
\.


--
-- TOC entry 5776 (class 0 OID 22556)
-- Dependencies: 240
-- Data for Name: AbpPermissionGroups; Type: TABLE DATA; Schema: identity; Owner: postgres
--

COPY identity."AbpPermissionGroups" ("Id", "Name", "DisplayName", "ExtraProperties") FROM stdin;
3a1da9ee-e9d7-6e6d-3c5f-e37e7b68b0d9	AbpIdentity	L:AbpIdentity,Permission:IdentityManagement	{"_CurrentProviderName":"Volo.Abp.Identity.IdentityPermissionDefinitionProvider"}
3a1da9ee-e9e2-49de-a8e3-371884266915	SettingManagement	L:AbpSettingManagement,Permission:SettingManagement	{"_CurrentProviderName":"Volo.Abp.SettingManagement.SettingManagementPermissionDefinitionProvider"}
3a1da9ee-e9e2-4f9b-3f9f-e0b209010d93	FeatureManagement	L:AbpFeatureManagement,Permission:FeatureManagement	{"_CurrentProviderName":"Volo.Abp.FeatureManagement.FeaturePermissionDefinitionProvider"}
3a1da9ee-e9e5-1c96-c571-aade671725ef	digihealth	F:digihealth	{"_CurrentProviderName":"digihealth.Permissions.digihealthPermissionDefinitionProvider"}
3a1da9ee-e9e5-76e3-3e62-f54d3df8c1ee	AbpTenantManagement	L:AbpTenantManagement,Permission:TenantManagement	{"_CurrentProviderName":"Volo.Abp.TenantManagement.AbpTenantManagementPermissionDefinitionProvider"}
3a1db416-b8a3-2eff-45b0-7530838c3361	IdentityService	L:IdentityService,Permission:IdentityService	{"_CurrentProviderName":"IdentityService.Permissions.IdentityServicePermissionDefinitionProvider"}
\.


--
-- TOC entry 5777 (class 0 OID 22566)
-- Dependencies: 241
-- Data for Name: AbpPermissions; Type: TABLE DATA; Schema: identity; Owner: postgres
--

COPY identity."AbpPermissions" ("Id", "GroupName", "Name", "ParentName", "DisplayName", "IsEnabled", "MultiTenancySide", "Providers", "StateCheckers", "ExtraProperties") FROM stdin;
3a1da9ee-e9df-15c7-f5b3-c6fa1e683077	AbpIdentity	AbpIdentity.Roles	\N	L:AbpIdentity,Permission:RoleManagement	t	3	\N	\N	{"_CurrentProviderName":"Volo.Abp.Identity.IdentityPermissionDefinitionProvider"}
3a1da9ee-e9e1-08d2-c787-355059987fb6	AbpIdentity	AbpIdentity.Roles.ManagePermissions	AbpIdentity.Roles	L:AbpIdentity,Permission:ChangePermissions	t	3	\N	\N	{"_CurrentProviderName":"Volo.Abp.Identity.IdentityPermissionDefinitionProvider"}
3a1da9ee-e9e1-4ff1-c4e7-714b1487a373	AbpIdentity	AbpIdentity.Roles.Create	AbpIdentity.Roles	L:AbpIdentity,Permission:Create	t	3	\N	\N	{"_CurrentProviderName":"Volo.Abp.Identity.IdentityPermissionDefinitionProvider"}
3a1da9ee-e9e1-79e6-efc6-235e51a18a20	AbpIdentity	AbpIdentity.Users.Create	AbpIdentity.Users	L:AbpIdentity,Permission:Create	t	3	\N	\N	{"_CurrentProviderName":"Volo.Abp.Identity.IdentityPermissionDefinitionProvider"}
3a1da9ee-e9e1-81f1-28ba-16edce6df97b	AbpIdentity	AbpIdentity.Users.Update	AbpIdentity.Users	L:AbpIdentity,Permission:Edit	t	3	\N	\N	{"_CurrentProviderName":"Volo.Abp.Identity.IdentityPermissionDefinitionProvider"}
3a1da9ee-e9e1-967d-e3ab-9bee2c5c366f	AbpIdentity	AbpIdentity.Roles.Update	AbpIdentity.Roles	L:AbpIdentity,Permission:Edit	t	3	\N	\N	{"_CurrentProviderName":"Volo.Abp.Identity.IdentityPermissionDefinitionProvider"}
3a1da9ee-e9e1-af71-82a4-1f0a8c4bd3e8	AbpIdentity	AbpIdentity.Users	\N	L:AbpIdentity,Permission:UserManagement	t	3	\N	\N	{"_CurrentProviderName":"Volo.Abp.Identity.IdentityPermissionDefinitionProvider"}
3a1da9ee-e9e1-f475-7e11-7354153a5eea	AbpIdentity	AbpIdentity.Roles.Delete	AbpIdentity.Roles	L:AbpIdentity,Permission:Delete	t	3	\N	\N	{"_CurrentProviderName":"Volo.Abp.Identity.IdentityPermissionDefinitionProvider"}
3a1da9ee-e9e2-0bcd-d9ad-627fea2cf6b3	AbpIdentity	AbpIdentity.Users.Delete	AbpIdentity.Users	L:AbpIdentity,Permission:Delete	t	3	\N	\N	{"_CurrentProviderName":"Volo.Abp.Identity.IdentityPermissionDefinitionProvider"}
3a1da9ee-e9e2-1dc1-2a54-0876b04987d7	SettingManagement	SettingManagement.Emailing	\N	L:AbpSettingManagement,Permission:Emailing	t	3	\N	\N	{"_CurrentProviderName":"Volo.Abp.SettingManagement.SettingManagementPermissionDefinitionProvider"}
3a1da9ee-e9e2-45a0-1f61-31b38caa7c22	AbpIdentity	AbpIdentity.Users.Update.ManageRoles	AbpIdentity.Users.Update	L:AbpIdentity,Permission:ManageRoles	t	3	\N	\N	{"_CurrentProviderName":"Volo.Abp.Identity.IdentityPermissionDefinitionProvider"}
3a1da9ee-e9e2-4caa-f7c5-517c740ac540	FeatureManagement	FeatureManagement.ManageHostFeatures	\N	L:AbpFeatureManagement,Permission:FeatureManagement.ManageHostFeatures	t	2	\N	\N	{"_CurrentProviderName":"Volo.Abp.FeatureManagement.FeaturePermissionDefinitionProvider"}
3a1da9ee-e9e2-5614-da5b-388f5ca50aaf	AbpIdentity	AbpIdentity.Users.ManagePermissions	AbpIdentity.Users	L:AbpIdentity,Permission:ChangePermissions	t	3	\N	\N	{"_CurrentProviderName":"Volo.Abp.Identity.IdentityPermissionDefinitionProvider"}
3a1da9ee-e9e2-eb7f-3a6f-80c1a1dd4090	AbpIdentity	AbpIdentity.UserLookup	\N	L:AbpIdentity,Permission:UserLookup	t	3	C	\N	{"_CurrentProviderName":"Volo.Abp.Identity.IdentityPermissionDefinitionProvider"}
3a1da9ee-e9e5-291b-b6ec-19af926e0233	AbpTenantManagement	AbpTenantManagement.Tenants.ManageFeatures	AbpTenantManagement.Tenants	L:AbpTenantManagement,Permission:ManageFeatures	t	2	\N	\N	{"_CurrentProviderName":"Volo.Abp.TenantManagement.AbpTenantManagementPermissionDefinitionProvider"}
3a1da9ee-e9e5-3f73-1902-2c41d0023374	AbpTenantManagement	AbpTenantManagement.Tenants	\N	L:AbpTenantManagement,Permission:TenantManagement	t	2	\N	\N	{"_CurrentProviderName":"Volo.Abp.TenantManagement.AbpTenantManagementPermissionDefinitionProvider"}
3a1da9ee-e9e5-50e0-ebb9-fd80f23b2d7c	SettingManagement	SettingManagement.Emailing.Test	SettingManagement.Emailing	L:AbpSettingManagement,Permission:EmailingTest	t	3	\N	\N	{"_CurrentProviderName":"Volo.Abp.SettingManagement.SettingManagementPermissionDefinitionProvider"}
3a1da9ee-e9e5-6369-9a5f-273157c398b1	AbpTenantManagement	AbpTenantManagement.Tenants.Create	AbpTenantManagement.Tenants	L:AbpTenantManagement,Permission:Create	t	2	\N	\N	{"_CurrentProviderName":"Volo.Abp.TenantManagement.AbpTenantManagementPermissionDefinitionProvider"}
3a1da9ee-e9e5-71bb-2f9c-0b9a2a589e39	AbpTenantManagement	AbpTenantManagement.Tenants.Update	AbpTenantManagement.Tenants	L:AbpTenantManagement,Permission:Edit	t	2	\N	\N	{"_CurrentProviderName":"Volo.Abp.TenantManagement.AbpTenantManagementPermissionDefinitionProvider"}
3a1da9ee-e9e5-b62e-fcc4-cacc5d481578	SettingManagement	SettingManagement.TimeZone	\N	L:AbpSettingManagement,Permission:TimeZone	t	3	\N	\N	{"_CurrentProviderName":"Volo.Abp.SettingManagement.SettingManagementPermissionDefinitionProvider"}
3a1da9ee-e9e5-c04c-e6ec-f722ce464e66	AbpTenantManagement	AbpTenantManagement.Tenants.Delete	AbpTenantManagement.Tenants	L:AbpTenantManagement,Permission:Delete	t	2	\N	\N	{"_CurrentProviderName":"Volo.Abp.TenantManagement.AbpTenantManagementPermissionDefinitionProvider"}
3a1da9ee-e9e5-e695-3611-6c08b56bae54	AbpTenantManagement	AbpTenantManagement.Tenants.ManageConnectionStrings	AbpTenantManagement.Tenants	L:AbpTenantManagement,Permission:ManageConnectionStrings	t	2	\N	\N	{"_CurrentProviderName":"Volo.Abp.TenantManagement.AbpTenantManagementPermissionDefinitionProvider"}
3a1db416-b8a5-b315-9c0c-daa018a420fa	IdentityService	IdentityService.Doctors	\N	L:IdentityService,Permission:Doctors	t	3	\N	\N	{"_CurrentProviderName":"IdentityService.Permissions.IdentityServicePermissionDefinitionProvider"}
3a1db416-b8a6-018b-45f6-717e74d64f0a	IdentityService	IdentityService.Profile	\N	L:IdentityService,Permission:Profile	t	3	\N	\N	{"_CurrentProviderName":"IdentityService.Permissions.IdentityServicePermissionDefinitionProvider"}
3a1db416-b8a6-4f33-be13-b65b4052f41b	IdentityService	IdentityService.Patients.Manage	IdentityService.Patients	L:IdentityService,Permission:Patients.Manage	t	3	\N	\N	{"_CurrentProviderName":"IdentityService.Permissions.IdentityServicePermissionDefinitionProvider"}
3a1db416-b8a6-6954-45b3-f0a0d9bad2d3	IdentityService	IdentityService.Patients	\N	L:IdentityService,Permission:Patients	t	3	\N	\N	{"_CurrentProviderName":"IdentityService.Permissions.IdentityServicePermissionDefinitionProvider"}
3a1db416-b8a6-b4ac-982b-294523f7152f	IdentityService	IdentityService.Doctors.Manage	IdentityService.Doctors	L:IdentityService,Permission:Doctors.Manage	t	3	\N	\N	{"_CurrentProviderName":"IdentityService.Permissions.IdentityServicePermissionDefinitionProvider"}
3a1db7b4-7ad2-a3b5-906f-4bd1c80c6258	IdentityService	IdentityService.FamilyLinks	\N	L:IdentityService,Permission:FamilyLinks	t	3	\N	\N	{"_CurrentProviderName":"IdentityService.Permissions.IdentityServicePermissionDefinitionProvider"}
3a1db7b4-7ad2-fb5e-6e9e-3c15deb0da9f	IdentityService	IdentityService.FamilyLinks.Manage	IdentityService.FamilyLinks	L:IdentityService,Permission:FamilyLinks.Manage	t	3	\N	\N	{"_CurrentProviderName":"IdentityService.Permissions.IdentityServicePermissionDefinitionProvider"}
\.


--
-- TOC entry 5791 (class 0 OID 22778)
-- Dependencies: 255
-- Data for Name: AbpRoleClaims; Type: TABLE DATA; Schema: identity; Owner: postgres
--

COPY identity."AbpRoleClaims" ("Id", "RoleId", "TenantId", "ClaimType", "ClaimValue") FROM stdin;
\.


--
-- TOC entry 5778 (class 0 OID 22579)
-- Dependencies: 242
-- Data for Name: AbpRoles; Type: TABLE DATA; Schema: identity; Owner: postgres
--

COPY identity."AbpRoles" ("Id", "TenantId", "Name", "NormalizedName", "IsDefault", "IsStatic", "IsPublic", "EntityVersion", "CreationTime", "ExtraProperties", "ConcurrencyStamp") FROM stdin;
3a1daa2f-2a0b-f108-2a24-f1fe6957da1c	3a1daa2f-274c-c133-f38f-6f5a98d37f7a	admin	ADMIN	f	t	t	2	2025-11-18 17:28:00.282147	{}	251bbea4beea4423b8eefd96af3c038e
3a1da2e4-2da0-92ca-434d-c72638198342	\N	admin	ADMIN	f	t	t	6	2025-11-17 07:28:45.509927	{}	68ef4b80a6b140fd912c31b4d058ccd8
\.


--
-- TOC entry 5779 (class 0 OID 22596)
-- Dependencies: 243
-- Data for Name: AbpSecurityLogs; Type: TABLE DATA; Schema: identity; Owner: postgres
--

COPY identity."AbpSecurityLogs" ("Id", "TenantId", "ApplicationName", "Identity", "Action", "UserId", "UserName", "TenantName", "ClientId", "CorrelationId", "ClientIpAddress", "BrowserInfo", "CreationTime", "ExtraProperties", "ConcurrencyStamp") FROM stdin;
3a1daa2e-4706-be19-2cae-5abd35d4bd24	\N	digihealth.HttpApi.Host	Identity	LoginSucceeded	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	admin	\N	\N	43241a04c091453a8318646252522a40	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2025-11-18 17:27:02.147369	{}	ab10ca84dfff4829bd6737346fffe1fa
3a1db955-de57-d066-0c6d-e28a6faa99dc	\N	digihealth.HttpApi.Host	Identity	LoginSucceeded	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	admin	\N	\N	cabf49cfeb0046bcab250284f7727169	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2025-11-21 16:04:35.029157	{}	83d46f64f88148439e44cbd17170b547
3a1dbc8e-5e0e-36dc-a953-5773708d7d93	\N	digihealth.HttpApi.Host	Identity	LoginSucceeded	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	admin	\N	\N	b37739cfd193457b94fcb553bef02086	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2025-11-22 07:05:09.388366	{}	3d4cd14e27644216a79dad261c378536
3a1dbc90-645e-cfe7-d053-5c5803880280	\N	digihealth.HttpApi.Host	Identity	LoginSucceeded	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	admin	\N	\N	38defeeecf994c5f8431dbdab76977b6	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0	2025-11-22 07:07:22.078623	{}	d757faac28a043feb9e9a3aa7da5ba4b
3a1dbc91-c68b-016a-13ad-8c85f098526b	\N	digihealth.HttpApi.Host	Identity	LoginSucceeded	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	admin	\N	\N	0f63143b7ca64456ada3dfbb8c05c5a9	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2025-11-22 07:08:52.747446	{}	8d3c6361060b438f877b9e08e540bbc7
3a1dbcb0-4b92-9627-1d91-3961c46be89f	\N	digihealth.HttpApi.Host	Identity	LoginSucceeded	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	admin	\N	\N	c8df188499714dfc8c294ad33ec91579	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2025-11-22 07:42:12.880654	{}	aad732187fef479dbe0d7e1b370ea927
3a1dbcd9-a04a-c26c-69b8-c35152d7e992	\N	digihealth.HttpApi.Host	Identity	LoginSucceeded	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	admin	\N	\N	f2e902433396405a875853942861a3ca	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2025-11-22 08:27:21.541739	{}	2bfcdb2180c04dcbac5b5e23ceecd9b3
3a1dbcdc-01c7-d083-2b47-c31c1a180e89	\N	digihealth.HttpApi.Host	Identity	LoginSucceeded	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	admin	\N	\N	2a27978b976449f1b2cee34d0249064f	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2025-11-22 08:29:57.57323	{}	faaf5790229f45eab5342d996f94a71d
3a1dbcde-f9f9-3905-d26a-d0b2d5cfb1af	\N	digihealth.HttpApi.Host	Identity	LoginSucceeded	3a1db416-b2b2-3609-98b4-058d6ceeb9d2	hostadmin	\N	\N	869b8bd8c8294b5dba21c97bc6ee4758	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2025-11-22 08:33:12.185209	{}	77e70808665c4af1b2b8752003642e22
3a1dbd66-0d24-8d7c-751e-5b3dd7cf6dd5	\N	digihealth.HttpApi.Host	Identity	LoginSucceeded	3a1dbd64-c316-bace-f69e-a0e93968898b	admin	\N	\N	c08ad9e73b834b478d4eba5b08be84d5	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2025-11-22 11:00:44.448454	{}	1204c3605abf41f0ad29f234da111d78
3a1dbec8-2a99-cfd1-0669-27e5aa909e02	\N	digihealth.HttpApi.Host	Identity	LoginSucceeded	3a1dbd64-c316-bace-f69e-a0e93968898b	admin	\N	\N	1a98e41ca78e467fbc23e0e1bc2fc0fd	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2025-11-22 17:27:31.735312	{}	7760999fddfc4c4696e12440cf88a03b
3a1dbec9-7a53-d6f9-9cd9-bdb8ef58b1d9	\N	digihealth.HttpApi.Host	Identity	LoginSucceeded	3a1dbd64-c316-bace-f69e-a0e93968898b	admin	\N	\N	e90705d33bad43d0ba603dcbf463f473	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2025-11-22 17:28:57.683258	{}	b5d7840f8223451f920d8f1e890aef2a
3a1dbeca-8b0b-0a02-6185-f6f82ef39cb5	\N	digihealth.HttpApi.Host	Identity	LoginSucceeded	3a1dbd64-c316-bace-f69e-a0e93968898b	admin	\N	\N	b876388ca23c42e9903ea0805f0709a0	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2025-11-22 17:30:07.499281	{}	7f98a29dcbe74a77a2510b214bd743ba
3a1dbed7-5fe3-dbd7-cf5f-80d0f306c7e3	\N	digihealth.HttpApi.Host	Identity	LoginSucceeded	3a1dbd64-c316-bace-f69e-a0e93968898b	admin	\N	\N	989c1447d68845ff98b817a74195c1b5	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2025-11-22 17:44:08.419554	{}	31b82f788d1d4355b7f3c107e31ec504
3a1dbed8-1eda-f31b-b72d-1728f229f9b0	\N	digihealth.HttpApi.Host	Identity	LoginSucceeded	3a1dbd64-c316-bace-f69e-a0e93968898b	admin	\N	\N	115c6e8f568f4371acc4c0853b0ee3f0	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2025-11-22 17:44:57.306329	{}	fc7adf3b67424141991397901a4e6e47
3a1dbeda-9b35-b2d0-bb0e-c5505f3383db	\N	digihealth.HttpApi.Host	Identity	LoginSucceeded	3a1dbd64-c316-bace-f69e-a0e93968898b	admin	\N	\N	cd0b80031bc549ed8a5e3321a75c83bb	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2025-11-22 17:47:40.21295	{}	26d8340e00934177bd5cbc685a3f87d1
3a1dbedf-6428-f9a2-3a50-d8245a5f27d6	\N	digihealth.HttpApi.Host	Identity	LoginSucceeded	3a1dbd64-c316-bace-f69e-a0e93968898b	admin	\N	\N	6b0fe5492e454df4b2859d75ec959f8e	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2025-11-22 17:52:53.798814	{}	55927cb4160544a2b7da4d4a2de9a9a7
3a1dbee9-02db-05ea-fb56-316990da7354	\N	digihealth.HttpApi.Host	Identity	LoginSucceeded	3a1dbd64-c316-bace-f69e-a0e93968898b	admin	\N	\N	dc4d2ae7baa744679fd2f0922ca8aced	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2025-11-22 18:03:24.249873	{}	05c688d6e338498ca5fec99cc3015a8e
3a1dbeec-c50c-f9de-7676-92aa716c8d23	\N	digihealth.HttpApi.Host	Identity	LoginSucceeded	3a1dbd64-c316-bace-f69e-a0e93968898b	admin	\N	\N	afd991013a45474281c12a0dc2bea910	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2025-11-22 18:07:30.570275	{}	8d8b816adfa8426cb651e6cd3010fd3f
3a1dbef8-4a76-417f-7569-c8116a4ceb36	\N	digihealth.HttpApi.Host	Identity	LoginSucceeded	3a1dbd64-c316-bace-f69e-a0e93968898b	admin	\N	\N	63eeb7da798548dc8683f402e0c44d52	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2025-11-22 18:20:05.620583	{}	a12d1e804e954df0bd0eb91a1f908d16
3a1dc39f-1107-5ecb-9318-f824b20541c4	\N	digihealth.HttpApi.Host	Identity	LoginSucceeded	3a1dbd64-c316-bace-f69e-a0e93968898b	admin	\N	\N	58e55067a7774d86914207514ec08f54	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2025-11-23 16:00:44.292965	{}	0a55060f3f7946808b6b8bdb8f8ac21f
3a1dc3a3-98f7-c0df-a854-80c630daea09	\N	digihealth.HttpApi.Host	Identity	LoginSucceeded	3a1dbd64-c316-bace-f69e-a0e93968898b	admin	\N	\N	ec6168df76354bdea1d52cf54f2acb6f	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0	2025-11-23 16:05:41.237381	{}	1aab7b6355504663904b4f22ee0714d4
3a1dc3a7-3568-1201-2a25-27e8cc3a7860	\N	digihealth.HttpApi.Host	Identity	LoginSucceeded	3a1dbd64-c316-bace-f69e-a0e93968898b	admin	\N	\N	f2f2e3a036564e26af205ca56f2cfc89	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0	2025-11-23 16:09:37.896589	{}	4c3a1b26a2f84047a8e374aae5386c7c
3a1dc3a7-b0a1-a3b6-3c51-d997fa298408	\N	digihealth.HttpApi.Host	Identity	LoginSucceeded	3a1dbd64-c316-bace-f69e-a0e93968898b	admin	\N	\N	546f8d08f18e43dea05db8dc8ea86ddf	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0	2025-11-23 16:10:09.441221	{}	9724abb9052f4b77a3febbe8fa48e039
3a1dc3ab-2798-dfab-f3f9-47deb789aeb8	\N	digihealth.HttpApi.Host	Identity	LoginSucceeded	3a1dbd64-c316-bace-f69e-a0e93968898b	admin	\N	\N	d5048cc0391b4f92adc8445d4243f0e5	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0	2025-11-23 16:13:56.502965	{}	e1e2ff1fd64140ea845c3fad70fb7f32
3a1dc3ab-a9bb-8d20-88be-046756846c20	\N	digihealth.HttpApi.Host	Identity	LoginSucceeded	3a1dbd64-c316-bace-f69e-a0e93968898b	admin	\N	\N	791f40eb629d4ab59224aaf9cf052a22	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0	2025-11-23 16:14:29.819344	{}	f51a00ac027f4eb7909c14165aa15687
3a1dc3b3-0dc5-3e5b-8d2e-ed59a94fdced	\N	digihealth.HttpApi.Host	Identity	LoginSucceeded	3a1dbd64-c316-bace-f69e-a0e93968898b	admin	\N	\N	9e1a3251061b4114a3dea32fbb39c0db	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0	2025-11-23 16:22:34.178691	{}	43d34c6525b64698a6c02473f9a0fcd9
3a1dc3b6-d4c2-2c57-fce2-c8dd7f285cbf	\N	digihealth.HttpApi.Host	Identity	LoginSucceeded	3a1dbd64-c316-bace-f69e-a0e93968898b	admin	\N	\N	cc17d9a3217c42b5a12ba2ba5db1929f	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0	2025-11-23 16:26:41.730551	{}	08ce4fdda0804db699eaf5c12b217e9b
3a1dc3b7-360f-b897-cf34-b447e5745a0d	\N	digihealth.HttpApi.Host	Identity	LoginSucceeded	3a1dbd64-c316-bace-f69e-a0e93968898b	admin	\N	\N	1549539b18214772a9611d6df5f15a6a	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0	2025-11-23 16:27:06.639323	{}	075c627543d143fd876033cd2f844c5e
3a1dc3b9-b5a3-7a81-aa14-a402c3d5a8b4	\N	digihealth.HttpApi.Host	Identity	LoginSucceeded	3a1dbd64-c316-bace-f69e-a0e93968898b	admin	\N	\N	ed4a062120ae4e409bd6cd35b460f2f8	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0	2025-11-23 16:29:50.369566	{}	267259e81e584b4e8e4445e0c069c78d
3a1dc3be-8445-08fe-1d2b-f699082b7d25	\N	digihealth.HttpApi.Host	Identity	LoginSucceeded	3a1dbd64-c316-bace-f69e-a0e93968898b	admin	\N	\N	e2208b72199b46b7b9474cdc1e8fdde0	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0	2025-11-23 16:35:05.411809	{}	4e6ebc5256a9417794ee3e4733b14c35
3a1dc3c2-0b7d-d945-0187-d40c4e4ea657	\N	digihealth.HttpApi.Host	Identity	LoginSucceeded	3a1dbd64-c316-bace-f69e-a0e93968898b	admin	\N	\N	d26ec5271057462bafc955a258e3802e	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0	2025-11-23 16:38:56.635595	{}	6bc8e8ef90b74d1e9bd70f42610d90fe
3a1dc3ca-bffb-ba0d-f6db-7b0bc6770792	\N	digihealth.HttpApi.Host	Identity	LoginSucceeded	3a1dbd64-c316-bace-f69e-a0e93968898b	admin	\N	\N	0b2c2eb89fb84e2988c4c30647dbe36a	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0	2025-11-23 16:48:27.128265	{}	fad765e4443b4379b4a1c0ab9f301e9b
3a1dc3dc-acec-b949-17c9-6dbed5df83cb	\N	digihealth.HttpApi.Host	Identity	LoginSucceeded	3a1dbd64-c316-bace-f69e-a0e93968898b	admin	\N	\N	b748175691124859b3a067581d053f04	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0	2025-11-23 17:08:01.898797	{}	f5286c3886934d18a12471e327c21c13
3a1dd683-7bff-54b0-3165-e9966c646117	\N	digihealth.HttpApi.Host	Identity	LoginSucceeded	3a1dbd64-c316-bace-f69e-a0e93968898b	admin	\N	\N	bdb98bfc0f4649babdc210a83a34be63	::1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0	2025-11-27 08:03:23.773861	{}	02b40f2d0b9e4f518d23b7438397af6d
\.


--
-- TOC entry 5780 (class 0 OID 22607)
-- Dependencies: 244
-- Data for Name: AbpSessions; Type: TABLE DATA; Schema: identity; Owner: postgres
--

COPY identity."AbpSessions" ("Id", "SessionId", "Device", "DeviceInfo", "TenantId", "UserId", "ClientId", "IpAddresses", "SignedIn", "LastAccessed", "ExtraProperties") FROM stdin;
\.


--
-- TOC entry 5781 (class 0 OID 22619)
-- Dependencies: 245
-- Data for Name: AbpSettingDefinitions; Type: TABLE DATA; Schema: identity; Owner: postgres
--

COPY identity."AbpSettingDefinitions" ("Id", "Name", "DisplayName", "Description", "DefaultValue", "IsVisibleToClients", "Providers", "IsInherited", "IsEncrypted", "ExtraProperties") FROM stdin;
3a1da9ee-ea13-9f90-1205-007d004b0e8d	Abp.Localization.DefaultLanguage	L:AbpLocalization,DisplayName:Abp.Localization.DefaultLanguage	L:AbpLocalization,Description:Abp.Localization.DefaultLanguage	en	t	\N	t	f	{}
3a1da9ee-ea15-0529-cc12-c8cec9a7ffb7	Abp.Identity.Lockout.AllowedForNewUsers	L:AbpIdentity,DisplayName:Abp.Identity.Lockout.AllowedForNewUsers	L:AbpIdentity,Description:Abp.Identity.Lockout.AllowedForNewUsers	True	t	\N	t	f	{}
3a1da9ee-ea15-08a1-9606-a328ae7e4815	Abp.Identity.Password.RequiredUniqueChars	L:AbpIdentity,DisplayName:Abp.Identity.Password.RequiredUniqueChars	L:AbpIdentity,Description:Abp.Identity.Password.RequiredUniqueChars	1	t	\N	t	f	{}
3a1da9ee-ea15-158d-900e-a7dd28d19f5a	Abp.Identity.Lockout.MaxFailedAccessAttempts	L:AbpIdentity,DisplayName:Abp.Identity.Lockout.MaxFailedAccessAttempts	L:AbpIdentity,Description:Abp.Identity.Lockout.MaxFailedAccessAttempts	5	t	\N	t	f	{}
3a1da9ee-ea15-3c3f-cc31-e6cd186aa375	Abp.Timing.TimeZone	L:AbpTiming,DisplayName:Abp.Timing.Timezone	L:AbpTiming,Description:Abp.Timing.Timezone		t	\N	t	f	{}
3a1da9ee-ea15-4b4d-4274-86b56e3c721c	Abp.Mailing.Smtp.Domain	L:AbpEmailing,DisplayName:Abp.Mailing.Smtp.Domain	L:AbpEmailing,Description:Abp.Mailing.Smtp.Domain	\N	f	\N	t	f	{}
3a1da9ee-ea15-4cf1-5402-f83916e1cd8f	Abp.Identity.OrganizationUnit.MaxUserMembershipCount	L:AbpIdentity,Identity.OrganizationUnit.MaxUserMembershipCount	L:AbpIdentity,Identity.OrganizationUnit.MaxUserMembershipCount	2147483647	t	\N	t	f	{}
3a1da9ee-ea15-616e-a2ab-d33c87686a36	Abp.Identity.SignIn.RequireConfirmedEmail	L:AbpIdentity,DisplayName:Abp.Identity.SignIn.RequireConfirmedEmail	L:AbpIdentity,Description:Abp.Identity.SignIn.RequireConfirmedEmail	False	t	\N	t	f	{}
3a1da9ee-ea15-7d6e-9935-98ffef0e23d7	Abp.Mailing.Smtp.Port	L:AbpEmailing,DisplayName:Abp.Mailing.Smtp.Port	L:AbpEmailing,Description:Abp.Mailing.Smtp.Port	25	f	\N	t	f	{}
3a1da9ee-ea15-7f12-0aca-668d49556fdf	Abp.Identity.User.IsEmailUpdateEnabled	L:AbpIdentity,DisplayName:Abp.Identity.User.IsEmailUpdateEnabled	L:AbpIdentity,Description:Abp.Identity.User.IsEmailUpdateEnabled	True	t	\N	t	f	{}
3a1da9ee-ea15-8742-4598-d8f37eb1ef7a	Abp.Identity.Password.RequireLowercase	L:AbpIdentity,DisplayName:Abp.Identity.Password.RequireLowercase	L:AbpIdentity,Description:Abp.Identity.Password.RequireLowercase	True	t	\N	t	f	{}
3a1da9ee-ea15-89ca-02cc-1ca789a5cd0f	Abp.Identity.SignIn.EnablePhoneNumberConfirmation	L:AbpIdentity,DisplayName:Abp.Identity.SignIn.EnablePhoneNumberConfirmation	L:AbpIdentity,Description:Abp.Identity.SignIn.EnablePhoneNumberConfirmation	True	t	\N	t	f	{}
3a1da9ee-ea15-8cdd-5fdf-982d9dce40ff	Abp.Identity.User.IsUserNameUpdateEnabled	L:AbpIdentity,DisplayName:Abp.Identity.User.IsUserNameUpdateEnabled	L:AbpIdentity,Description:Abp.Identity.User.IsUserNameUpdateEnabled	True	t	\N	t	f	{}
3a1da9ee-ea15-af6f-dd29-94cd0a498cd4	Abp.Identity.Password.RequireDigit	L:AbpIdentity,DisplayName:Abp.Identity.Password.RequireDigit	L:AbpIdentity,Description:Abp.Identity.Password.RequireDigit	True	t	\N	t	f	{}
3a1da9ee-ea15-b94c-cdb1-823be6e7e63f	Abp.Mailing.Smtp.Host	L:AbpEmailing,DisplayName:Abp.Mailing.Smtp.Host	L:AbpEmailing,Description:Abp.Mailing.Smtp.Host	127.0.0.1	f	\N	t	f	{}
3a1da9ee-ea15-c498-9aab-43ab2026dc01	Abp.Identity.Password.RequireUppercase	L:AbpIdentity,DisplayName:Abp.Identity.Password.RequireUppercase	L:AbpIdentity,Description:Abp.Identity.Password.RequireUppercase	True	t	\N	t	f	{}
3a1da9ee-ea15-cb01-4e1c-78b1ddc9cb19	Abp.Identity.SignIn.RequireConfirmedPhoneNumber	L:AbpIdentity,DisplayName:Abp.Identity.SignIn.RequireConfirmedPhoneNumber	L:AbpIdentity,Description:Abp.Identity.SignIn.RequireConfirmedPhoneNumber	False	t	\N	t	f	{}
3a1da9ee-ea15-d22c-1222-929b20fbda92	Abp.Mailing.Smtp.Password	L:AbpEmailing,DisplayName:Abp.Mailing.Smtp.Password	L:AbpEmailing,Description:Abp.Mailing.Smtp.Password	\N	f	\N	t	t	{}
3a1da9ee-ea15-da93-d0ce-c5d09326184e	Abp.Identity.Password.RequiredLength	L:AbpIdentity,DisplayName:Abp.Identity.Password.RequiredLength	L:AbpIdentity,Description:Abp.Identity.Password.RequiredLength	6	t	\N	t	f	{}
3a1da9ee-ea15-dcf9-0b2d-a1aa5c8c28f7	Abp.Identity.Password.ForceUsersToPeriodicallyChangePassword	L:AbpIdentity,DisplayName:Abp.Identity.Password.ForceUsersToPeriodicallyChangePassword	L:AbpIdentity,Description:Abp.Identity.Password.ForceUsersToPeriodicallyChangePassword	False	t	\N	t	f	{}
3a1da9ee-ea15-ea9a-32fd-af8aedf2f029	Abp.Mailing.Smtp.UserName	L:AbpEmailing,DisplayName:Abp.Mailing.Smtp.UserName	L:AbpEmailing,Description:Abp.Mailing.Smtp.UserName	\N	f	\N	t	f	{}
3a1da9ee-ea15-eb6a-6ad1-674255311f64	Abp.Identity.Password.RequireNonAlphanumeric	L:AbpIdentity,DisplayName:Abp.Identity.Password.RequireNonAlphanumeric	L:AbpIdentity,Description:Abp.Identity.Password.RequireNonAlphanumeric	True	t	\N	t	f	{}
3a1da9ee-ea15-ebaf-f949-3f6ea2a1af85	Abp.Identity.Password.PasswordChangePeriodDays	L:AbpIdentity,DisplayName:Abp.Identity.Password.PasswordChangePeriodDays	L:AbpIdentity,Description:Abp.Identity.Password.PasswordChangePeriodDays	0	t	\N	t	f	{}
3a1da9ee-ea15-f1f0-e708-f811de79c570	Abp.Identity.Lockout.LockoutDuration	L:AbpIdentity,DisplayName:Abp.Identity.Lockout.LockoutDuration	L:AbpIdentity,Description:Abp.Identity.Lockout.LockoutDuration	300	t	\N	t	f	{}
3a1da9ee-ea15-fb6d-6ec8-5c4956ceb361	Abp.Identity.SignIn.RequireEmailVerificationToRegister	L:AbpIdentity,DisplayName:Abp.Identity.SignIn.RequireEmailVerificationToRegister	L:AbpIdentity,Description:Abp.Identity.SignIn.RequireEmailVerificationToRegister	False	f	\N	t	f	{}
3a1da9ee-ea16-1968-2533-9df130d07c6f	Abp.Account.EnableLocalLogin	L:AbpAccount,DisplayName:Abp.Account.EnableLocalLogin	L:AbpAccount,Description:Abp.Account.EnableLocalLogin	true	t	\N	t	f	{}
3a1da9ee-ea16-20b5-6d9a-896634274007	Abp.Mailing.Smtp.EnableSsl	L:AbpEmailing,DisplayName:Abp.Mailing.Smtp.EnableSsl	L:AbpEmailing,Description:Abp.Mailing.Smtp.EnableSsl	false	f	\N	t	f	{}
3a1da9ee-ea16-26e3-2969-a624f5403c3c	Abp.Mailing.DefaultFromAddress	L:AbpEmailing,DisplayName:Abp.Mailing.DefaultFromAddress	L:AbpEmailing,Description:Abp.Mailing.DefaultFromAddress	noreply@abp.io	f	\N	t	f	{}
3a1da9ee-ea16-7937-7d19-7da6b56ecc3c	Abp.Account.IsSelfRegistrationEnabled	L:AbpAccount,DisplayName:Abp.Account.IsSelfRegistrationEnabled	L:AbpAccount,Description:Abp.Account.IsSelfRegistrationEnabled	true	t	\N	t	f	{}
3a1da9ee-ea16-8069-d164-d5b272cfb2a0	Abp.Mailing.Smtp.UseDefaultCredentials	L:AbpEmailing,DisplayName:Abp.Mailing.Smtp.UseDefaultCredentials	L:AbpEmailing,Description:Abp.Mailing.Smtp.UseDefaultCredentials	true	f	\N	t	f	{}
3a1da9ee-ea16-e931-5aca-56935d902047	Abp.Mailing.DefaultFromDisplayName	L:AbpEmailing,DisplayName:Abp.Mailing.DefaultFromDisplayName	L:AbpEmailing,Description:Abp.Mailing.DefaultFromDisplayName	ABP application	f	\N	t	f	{}
\.


--
-- TOC entry 5782 (class 0 OID 22632)
-- Dependencies: 246
-- Data for Name: AbpSettings; Type: TABLE DATA; Schema: identity; Owner: postgres
--

COPY identity."AbpSettings" ("Id", "Name", "Value", "ProviderName", "ProviderKey") FROM stdin;
\.


--
-- TOC entry 5792 (class 0 OID 22793)
-- Dependencies: 256
-- Data for Name: AbpTenantConnectionStrings; Type: TABLE DATA; Schema: identity; Owner: postgres
--

COPY identity."AbpTenantConnectionStrings" ("TenantId", "Name", "Value") FROM stdin;
\.


--
-- TOC entry 5783 (class 0 OID 22642)
-- Dependencies: 247
-- Data for Name: AbpTenants; Type: TABLE DATA; Schema: identity; Owner: postgres
--

COPY identity."AbpTenants" ("Id", "Name", "NormalizedName", "EntityVersion", "ExtraProperties", "ConcurrencyStamp", "CreationTime", "CreatorId", "LastModificationTime", "LastModifierId", "IsDeleted", "DeleterId", "DeletionTime") FROM stdin;
3a1daa2f-274c-c133-f38f-6f5a98d37f7a	Default Clinic	DEFAULT CLINIC	1	{}	d1886c85c66a427b8f795fd123b5e990	2025-11-18 17:27:59.648868	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	2025-11-22 17:27:57.34512	3a1dbd64-c316-bace-f69e-a0e93968898b	f	\N	\N
\.


--
-- TOC entry 5793 (class 0 OID 22808)
-- Dependencies: 257
-- Data for Name: AbpUserClaims; Type: TABLE DATA; Schema: identity; Owner: postgres
--

COPY identity."AbpUserClaims" ("Id", "UserId", "TenantId", "ClaimType", "ClaimValue") FROM stdin;
\.


--
-- TOC entry 5784 (class 0 OID 22658)
-- Dependencies: 248
-- Data for Name: AbpUserDelegations; Type: TABLE DATA; Schema: identity; Owner: postgres
--

COPY identity."AbpUserDelegations" ("Id", "TenantId", "SourceUserId", "TargetUserId", "StartTime", "EndTime") FROM stdin;
\.


--
-- TOC entry 5794 (class 0 OID 22823)
-- Dependencies: 258
-- Data for Name: AbpUserLogins; Type: TABLE DATA; Schema: identity; Owner: postgres
--

COPY identity."AbpUserLogins" ("UserId", "LoginProvider", "TenantId", "ProviderKey", "ProviderDisplayName") FROM stdin;
\.


--
-- TOC entry 5795 (class 0 OID 22836)
-- Dependencies: 259
-- Data for Name: AbpUserOrganizationUnits; Type: TABLE DATA; Schema: identity; Owner: postgres
--

COPY identity."AbpUserOrganizationUnits" ("UserId", "OrganizationUnitId", "TenantId", "CreationTime", "CreatorId") FROM stdin;
\.


--
-- TOC entry 5796 (class 0 OID 22854)
-- Dependencies: 260
-- Data for Name: AbpUserRoles; Type: TABLE DATA; Schema: identity; Owner: postgres
--

COPY identity."AbpUserRoles" ("UserId", "RoleId", "TenantId") FROM stdin;
3a1dbd64-c316-bace-f69e-a0e93968898b	3a1da2e4-2da0-92ca-434d-c72638198342	\N
\.


--
-- TOC entry 5797 (class 0 OID 22871)
-- Dependencies: 261
-- Data for Name: AbpUserTokens; Type: TABLE DATA; Schema: identity; Owner: postgres
--

COPY identity."AbpUserTokens" ("UserId", "LoginProvider", "Name", "TenantId", "Value") FROM stdin;
\.


--
-- TOC entry 5785 (class 0 OID 22668)
-- Dependencies: 249
-- Data for Name: AbpUsers; Type: TABLE DATA; Schema: identity; Owner: postgres
--

COPY identity."AbpUsers" ("Id", "TenantId", "UserName", "NormalizedUserName", "Name", "Surname", "Email", "NormalizedEmail", "EmailConfirmed", "PasswordHash", "SecurityStamp", "IsExternal", "PhoneNumber", "PhoneNumberConfirmed", "IsActive", "TwoFactorEnabled", "LockoutEnd", "LockoutEnabled", "AccessFailedCount", "ShouldChangePasswordOnNextLogin", "EntityVersion", "LastPasswordChangeTime", "ExtraProperties", "ConcurrencyStamp", "CreationTime", "CreatorId", "LastModificationTime", "LastModifierId", "IsDeleted", "DeleterId", "DeletionTime", "Salutation", "ProfilePhotoUrl") FROM stdin;
3a1dbd64-c316-bace-f69e-a0e93968898b	\N	admin	ADMIN	admin	\N	admin@abp.io	ADMIN@ABP.IO	f	AQAAAAIAAYagAAAAEAPxIvynlX6+WCHv0HCTT0kSWlQQgNrHJ0LCL0CzZAW92SGoRR4Ctg81z87MRVpTBg==	3QQADDEM3AUSC56QO2M7C6SNLYIKFWXO	f	\N	f	t	f	\N	t	0	f	2	2025-11-22 14:59:20.05087+04	{}	d9c23ed855fe4345b20fc3e45ae2468c	2025-11-22 10:59:20.245133	\N	2025-11-22 10:59:20.91204	\N	f	\N	\N	\N	\N
3a1dbd64-c850-7e71-8b8a-db06bbb33836	3a1daa2f-274c-c133-f38f-6f5a98d37f7a	clinicadmin	CLINICADMIN	Default	Admin	admin@defaultclinic.local	ADMIN@DEFAULTCLINIC.LOCAL	f	AQAAAAIAAYagAAAAENa+GWf04D0ipvIg3hzI2EzfbFtYnHx2CWF2bJS3XXrscKRpkqx8fEN9ESduAXxtFg==	JKEKRIZXKLLCKMQGFUTADBMUZMN5Q6C4	f	\N	f	t	f	\N	t	0	f	0	2025-11-22 14:59:21.384799+04	{}	56ad8dc545bb44f6849743e9d395c5a3	2025-11-22 10:59:21.400543	\N	\N	\N	f	\N	\N	Dr	\N
3a1dbd64-c8f8-ae7e-397e-2901e42bb09a	3a1daa2f-274c-c133-f38f-6f5a98d37f7a	patient1	PATIENT1	Sample	Patient	patient1@defaultclinic.local	PATIENT1@DEFAULTCLINIC.LOCAL	f	AQAAAAIAAYagAAAAENrKYInEtAUVOzxCfnS6pH38GMOG1vdKcyjwpsejRo4RW0EsTW6fPr9AuUEHNO7urw==	7HKUJ6ENYBMLDUJIKOEEXYVGOWHEWHQH	f	\N	f	t	f	\N	t	0	f	0	2025-11-22 14:59:21.542398+04	{}	24770432978d41c5b887c643ee41e509	2025-11-22 10:59:21.546902	\N	\N	\N	f	\N	\N	Ms	\N
3a1dbd64-c7ad-cada-f36e-2ccab88985b5	\N	hostadmin	HOSTADMIN	Host	Admin	host.admin@digihealth.local	HOST.ADMIN@DIGIHEALTH.LOCAL	f	AQAAAAIAAYagAAAAEC0A6w58MqZ40Wr7awc49/EnbPYEFpCWsy01oOpHfgU54v/EkUVaNt3ydsHBrDIz3w==	5PBP5RTYEW257HXTRVZDQW6DBWOIX2NT	f	\N	f	t	f	\N	t	0	f	2	2025-11-22 14:59:21.21208+04	{}	d055cafd98b74bb6b1855599060e0221	2025-11-22 10:59:21.22003	\N	2025-11-27 15:10:23.705199	\N	f	\N	\N	Mr	\N
3a1dd80a-6a63-8357-072a-def65adf9702	\N	hostdoctor	HOSTDOCTOR	Host	Doctor	host.doctor@digihealth.local	HOST.DOCTOR@DIGIHEALTH.LOCAL	f	AQAAAAIAAYagAAAAEOQEBy38Tp5lfZXXN2yIDubCia4K6jtutBomX99B7faUkhECUAeo8/O84PV+Hg2AEg==	6ZP2FA3YK5EMAXXA6HTBWLB6PD4WJ3MR	f	\N	f	t	f	\N	t	0	f	2	2025-11-27 19:10:23.933528+04	{}	bf2bc36979024a8480afc3383d876c6c	2025-11-27 15:10:23.964469	\N	2025-11-27 15:10:23.985843	\N	f	\N	\N	Dr	\N
3a1dd80a-6b34-49cd-86a8-45ef82ca5773	\N	patient1	PATIENT1	Sample	Patient	patient1@digihealth.local	PATIENT1@DIGIHEALTH.LOCAL	f	AQAAAAIAAYagAAAAECOV9TX8CDCioJjK6+vypMS6cYg5X0ild/NllrijhPYSG5UW+6zC6al3qZalNZDEOA==	XCB5YOXKP3XOARZTJC3A2XNTR3WQVNRY	f	\N	f	t	f	\N	t	0	f	2	2025-11-27 19:10:24.117991+04	{}	439c71ec10814371905daee737c12cec	2025-11-27 15:10:24.121943	\N	2025-11-27 15:10:24.127495	\N	f	\N	\N	Ms	\N
\.


--
-- TOC entry 5786 (class 0 OID 22701)
-- Dependencies: 250
-- Data for Name: OpenIddictApplications; Type: TABLE DATA; Schema: identity; Owner: postgres
--

COPY identity."OpenIddictApplications" ("Id", "ApplicationType", "ClientId", "ClientSecret", "ClientType", "ConsentType", "DisplayName", "DisplayNames", "JsonWebKeySet", "Permissions", "PostLogoutRedirectUris", "Properties", "RedirectUris", "Requirements", "Settings", "ClientUri", "LogoUri", "ExtraProperties", "ConcurrencyStamp", "CreationTime", "CreatorId", "LastModificationTime", "LastModifierId", "IsDeleted", "DeleterId", "DeletionTime") FROM stdin;
3a1da2e4-3191-7923-a780-699387b8fef2	\N	digihealth_Blazor	\N	public	implicit	Blazor Application	\N	\N	["ept:end_session","gt:authorization_code","rst:code","ept:authorization","ept:token","ept:revocation","ept:introspection","scp:address","scp:email","scp:phone","scp:profile","scp:roles","scp:digihealth"]	["https://localhost:44327/authentication/logout-callback"]	\N	["https://localhost:44327/authentication/login-callback"]	\N	\N	https://localhost:44327	\N	{}	20fdca2b4ffa4db7bb85567460d3784b	2025-11-17 07:28:46.550981	\N	\N	\N	f	\N	\N
3a1da2e4-31fc-79a3-4737-084c1efda199	\N	digihealth_Swagger	\N	public	implicit	digihealth Swagger UI	\N	\N	["ept:end_session","gt:authorization_code","rst:code","ept:authorization","ept:token","ept:revocation","ept:introspection","gt:refresh_token","scp:address","scp:email","scp:phone","scp:profile","scp:roles","scp:digihealth"]	\N	\N	["https://localhost:44322/swagger/oauth2-redirect.html"]	\N	\N	https://localhost:44322	\N	{}	fd6dc02ea62e4ff2a080c53d0f4fcb46	2025-11-17 07:28:46.591222	\N	2025-11-23 16:38:38.538928	\N	f	\N	\N
\.


--
-- TOC entry 5798 (class 0 OID 22886)
-- Dependencies: 262
-- Data for Name: OpenIddictAuthorizations; Type: TABLE DATA; Schema: identity; Owner: postgres
--

COPY identity."OpenIddictAuthorizations" ("Id", "ApplicationId", "CreationDate", "Properties", "Scopes", "Status", "Subject", "Type", "ExtraProperties", "ConcurrencyStamp") FROM stdin;
3a1dbce2-c141-ea2d-8cf0-0a30b045d5ae	3a1da2e4-31fc-79a3-4737-084c1efda199	2025-11-22 08:37:19.809907	\N	["digihealth"]	valid	3a1db416-b2b2-3609-98b4-058d6ceeb9d2	permanent	{}	86ed3182e94c452994411002a94a75d4
3a1db955-e21c-697d-db53-2a221a850fe3	3a1da2e4-31fc-79a3-4737-084c1efda199	2025-11-21 16:04:35.994925	\N	["digihealth"]	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	permanent	{}	d10e735bb1b84c49b37004f2b3c9de30
3a1dbd66-0fd6-0b60-47df-10707561f5b0	3a1da2e4-31fc-79a3-4737-084c1efda199	2025-11-22 11:00:45.141207	\N	["digihealth"]	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	permanent	{}	5cf73ce211654a0b8153cfd63eb4d5b9
3a1dbec8-2d0c-ad13-330e-933785192bab	3a1da2e4-3191-7923-a780-699387b8fef2	2025-11-22 17:27:32.361562	\N	["openid","profile","digihealth","roles","email","phone"]	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	permanent	{}	1f37cc6fce5b457d8a1aa9c112e7c11d
3a1daa2e-4a09-550d-2d70-85760204b9e6	3a1da2e4-3191-7923-a780-699387b8fef2	2025-11-18 17:27:02.920117	\N	["openid","profile","digihealth","roles","email","phone"]	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	permanent	{}	a62e509e42b34b0d8d1880437db76831
3a1dbcde-fa38-6da3-4cec-3b6b954e7c30	3a1da2e4-3191-7923-a780-699387b8fef2	2025-11-22 08:33:12.246879	\N	["openid","profile","digihealth","roles","email","phone"]	valid	3a1db416-b2b2-3609-98b4-058d6ceeb9d2	permanent	{}	8931105c97ee4f8885ff81b4544b25f1
\.


--
-- TOC entry 5787 (class 0 OID 22714)
-- Dependencies: 251
-- Data for Name: OpenIddictScopes; Type: TABLE DATA; Schema: identity; Owner: postgres
--

COPY identity."OpenIddictScopes" ("Id", "Description", "Descriptions", "DisplayName", "DisplayNames", "Name", "Properties", "Resources", "ExtraProperties", "ConcurrencyStamp", "CreationTime", "CreatorId", "LastModificationTime", "LastModifierId", "IsDeleted", "DeleterId", "DeletionTime") FROM stdin;
3a1da2e4-3108-3794-afdd-50ce4fa912ac	\N	\N	digihealth API	\N	digihealth	\N	["digihealth"]	{}	bc0e616e75bb4739821f5821057e0d4d	2025-11-17 07:28:46.3993	\N	\N	\N	f	\N	\N
\.


--
-- TOC entry 5800 (class 0 OID 22917)
-- Dependencies: 264
-- Data for Name: OpenIddictTokens; Type: TABLE DATA; Schema: identity; Owner: postgres
--

COPY identity."OpenIddictTokens" ("Id", "ApplicationId", "AuthorizationId", "CreationDate", "ExpirationDate", "Payload", "Properties", "RedemptionDate", "ReferenceId", "Status", "Subject", "Type", "ExtraProperties", "ConcurrencyStamp") FROM stdin;
3a1dbcdf-2546-e620-a1ff-2035a9bcb80b	3a1da2e4-3191-7923-a780-699387b8fef2	3a1dbcde-fa38-6da3-4cec-3b6b954e7c30	2025-11-22 08:33:23	2025-11-22 09:33:23	\N	\N	\N	\N	valid	3a1db416-b2b2-3609-98b4-058d6ceeb9d2	access_token	{}	441fa1c016ab440b8b0c273804cd8945
3a1daa2e-62ce-10ec-8e3c-d589f81f8524	3a1da2e4-3191-7923-a780-699387b8fef2	3a1daa2e-4a09-550d-2d70-85760204b9e6	2025-11-18 17:27:09	2025-11-18 17:32:09	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.JdxcpG2I4wGR10dEEO7cGRPN7cIb1UA4JsOgZOhkK_H63BAKl0WCm_zkJ5VlhuB9Zlwy5iz7ofIBP1FAdSeSXG37hBTrFN3vDnPjvmHLTuTY3BjKDDNJUPzO3qTlLeo181bNu6xZmTQlfHU6QbyFO4JAA-Hoam8rAmWy9TV9MtLLO9w4N8x7yuVcwsyGDqPLjrvXpy81kCRevqv0dkt_DiRAysp0eTKzmzYN5q1YUZWcSuZ1fHTqebL_aBqdNWj2X6bGlbKqHdcov862rek9Ixv5jZsKuy1uv_2CF2y3LRKaZsOzXrDo8ROmQEomCUdICJSDBzXg63uBmxq-1alruw.t1pcnMSmTjptg0dQ7uoSOA.U2F_Wx0oEKF07bId1KpXOO-P8_JS5WhQ0Xh7DMfOofNcYRPLVoeLv-EXFg_ePDB_oStS_9QEZr_oZnVNqkFLmE2Q4WIBwzKUmFmpRLFwbi5MRM8bq_ZC3RJwe-xb-AK2gDxEqYls-YhpROs_w2nUlwum268Te2VS_OtBuDQY0gfLfPWDhEJjjavewtwn5fR31UEPEcjGhlT2l-Y7u8cnD3GnYa7EPFKwiafkQft9tK0Xd4zbaLGpfvzucZta11uazL2INegPN2v2EeSPVNDmdrN4Xi4a2gRqUCPMUCtfk75ZDx4_q0iWkpDxyNCy18r2U9sjxo-nMtd6rCSUehYtLJWZySccSFBaQa4XfkprJRLZ0Zl_0x-BtJzU2poxbixb5h2pNfFUK7I3G2gIpzQ8_uaLG-vSLSMCEnwY7HBzoFrYCcDJltNgvQqA7_pdJt2_Ljfg7GkHMbraO7c7pu2a8GSu-3evLCBzCCrTt76oDDOmIcVtmMSXuWrNVNTX2n4q5qnQDHnz4Y9DJar2-3nFA3b4GUzxlzXyPaUv3tIxUnVtWbzMNKvwNv7-rMh85aI6Od6Fs_5YeZLmi3VAFuHCiSmBRRuJPAqQpjb0Zn6padoDQdpDocWADHoLYrJiH3NBwgTGFSbklbGRuPgJnnpMmMHv_Dc7wkLk8d9QiQV65lSqynZDzvly7JWC-Ey12sQVqn18XCTtgisyPxScAAx9cSBHAExxmBo4aSl9bp0d_Tj4UzECrsCwyel2uS6JJCGr4S2NycXzKTXCOqhYdQQmW4_TaEX4GIa-gk1hPOkLhJQ5XUFxQRl4J1WHzPFnOXn_Br6yniZlZMm9HH9duaW5Q0ZbYMlHiwAv2Gpf_L69WCXKhcGPcDx1nJJiOE3jvsOvoeoVMad1v0Y7ouGqNRrwHkOrfPT1RESBcZSrqPX0QD4haJ6cVaFiuXq2uTb74AOXqbqaXYkHaGOrE6xklddV8DmomcfiYPq3iZ6bFTEAACN6bXI8E10BA4tUXDZd5AHQ7rVuCLZqYNAcq9MCyY9z2UWPM77VFOilX4OrzLyBxuAlrtv1P17qlQCsZgjnaoiAGKjeNjaMaRjt2VwlQjx-7iW0dzYDbWTOaC1LOsOEPOO0bntbZdjVeP4PPld_hnibsT15KgMqnafE1LdP-rSw4AIHJc4rlycIn8vxmKCn9p4QXpEgd7B50MRE6MRTrf1d67-BbOemxtTxp0NTDbY3_Gs4TTaP5uvq3EsviFtrbS7ApeU1psFSJHLzMhEF02OEBTTK4T6CJ4WGwt0vV-lAZjVu1qnnNTgT1xsGKulfBAAj00TzjIExJC02aFuKUfZPx2mm1r9HI9cr6Op2XX16OgJdQJ4ZW-voy-O5idn1OPy-oi5Wus80WIGdP4tjSMb4lrBgWjr4BcWKbz0qrM-XKe8BvOMRpxfCfmCdook7A5heNYivbUWoBm1cNwAXnoLxKHt-1g5xTqJjPIm45XP8IHMhbCxJuO4NQJiWli2N76GQqQ7VDdM87Ad91-QdPQzBtXwXFZgSVlP8UybCtSSPFkUeEwWxK09G9U0mZjlt2FMkezPrG2VlKGSpdUgomiQc0a-OtuqfVVYEsdwqeU6kWdrY7NIhk0cX4i79JEgsEFlxNE3JFWlc_mgcELl1Mi-8nBhuDljPqBXSfErY0n3SrtAX7RbnEVyzS6qBMcqZzia_ER00JCNQav1l5D_ocd-gK0nvBERD_2pd2_qqNra8YV_ANoHCMZNYIVWb4xcLOrR6tFEsejK9UR9Rk7zjFbFemaOuRT9TDyn4DBFq591V77laxem-xLp9LNUQ2mVUwko-zBEJp1HkdXuEDptD6KXq3wSfbDAdQk5yDYSvj06Kp_el9os1oGzUatHZYndbzXLhX_AlVhLwnutfttS5YdV4mUSqIsHe613mO12ouZAo2noFx532Uq2becfQ9bt9Th9HvacGLkFkfHTcvv-8eXOWEeBHAZ74d5uxOpbkntufM07Kf61wOus5GspV65ZIjKL-1MkuSILZsWq5Q89B6Z2hcIrLs0iTZqGgHXTw0vLkBUylkpa-IqGOeldrD_DBVjRGjJJ_UbJ6AyLL1IgZaxbMf4O_Sc_GeZCP96UVaF948ZlabZ1K0PVg9v-RBKeGmTvoEhD6MUrjar4O0pV3v_D5Tb_21QPE-w0J7Heic_PSqeFsszgpcOdD6a2BuVQcBXXtD75jqNLK0heKNaiACpDUVVkpo4ajgt1ZCek3G1_OEM88F4WF3boz41OMf0IaENluw2s0UYZEE6CdXgrIxYqEb0h0VrT8QM-vX_qGRnKDsOd4bPxwvQbnqAmPf629_VG-S7CD4D2OnOhS1tok8cEGFSvG6mVl85ka2zeQentK3FRQCke06L-yNuUN4m7X_ZmZVZPl3mac-dyYJJ2i3LdTy56M-VIS8fshQhl9RZ8HFxRVte6186rQeK3rE3lCdwxZ7q2XMwO-j07Nqy_No0kD7GUbcc-_jvSOriaHaWJhPR0dZ87QfLJjAVG1lA1zbFMj7Nbu_mfZxgYyMrHxzROQglZD1C3gNQKHOu1iukPyZBjKDg5Dmx_gs7DeOQTmL2EVS1pKs8oCKYY8-B30jcmzf0sGDtIMwV3Lmqa1KMsxsGHuUgHWiA-ZL2NBeES67zXrtcl1YccVmwTOvZEnuKO3eKqTS2A3JaFRBTP2eyqInPE3bR5c5DYm6QMMGAiwaxY0W-2PTFLQOx1uBVTlLZ-K.aHkvf7CA5iHyO_WZNBx-2tGVwgLmyY1Ce_3jJSev36I	\N	2025-11-18 17:27:09.632197	24WdTr/BFHAzH8gNuf3fO60qTEp4r246uUOxyprnkDE=	redeemed	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	00af03efc20d4139b091e265c03575ca
3a1daa2e-6474-0db9-dd6a-603943555836	3a1da2e4-3191-7923-a780-699387b8fef2	3a1daa2e-4a09-550d-2d70-85760204b9e6	2025-11-18 17:27:09	2025-11-18 18:27:09	\N	\N	\N	\N	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	access_token	{}	c5e4a038da874644af9da73cb54eff0e
3a1daa2e-6482-a9b6-e807-3db621b4dbcb	3a1da2e4-3191-7923-a780-699387b8fef2	3a1daa2e-4a09-550d-2d70-85760204b9e6	2025-11-18 17:27:09	2025-11-18 17:47:09	\N	\N	\N	\N	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	id_token	{}	6a4218959a614f2fa98ff94388967ca7
3a1daa2e-4ac2-e3f9-0f06-39fea19a80fa	3a1da2e4-3191-7923-a780-699387b8fef2	3a1daa2e-4a09-550d-2d70-85760204b9e6	2025-11-18 17:27:03	2025-11-18 17:32:03	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.s0RKwfrKqXfKptZXsnjOWUgbDbv_PL_kR0WFomk9xilSf3H5KBt7cqui4g1Grtj5qCKrSPMaTVuagLBXjzHjscSzzDLWrtJUTf-kjXGhuNeu6JFwE9FKtBuHkvSVJc0i8QxLJT-qPlpDuJgAZ7OogRZo1FEKyRaGFghzDpIR0q9GMf50NvXPLRrnoh6sOZoztNo-aa-BYrVsg1KCzg6IRdLYitn-2xB69IuDbHgssoxyql2izciiSL6nHloMULKgxh6hQNYOA6a-0jD8LfEWOBvnDpsCUaFZ0JmMvi8qgR1t78klme_UKLkD8TBIpQ-dFfsPtfFFfkPdnOPv1Q6TpQ.m-1ubkLb-2543ipJYZ-uVA.icTF2Ub9eFkMQJQg6Oo_ND1VA3ZPbLC11xEhAWmyVylHQMxMz3yUpcPhbeq2c9xi18Sofun3CgmU3Fcw8ZefS7zdy4lOFy5gYw0yIVq6o2UZoin3-RNzOIGBshDP9xYEDyF_lqhe7Y3-3tg-T5o5Mg58Ac_sDor31k7xudQynQzAHAZ9OuSXOfvQKt4NgbArDRb1FRPLXRlGHGNWdca9AZyLwuE5qXwk68s0dfBB7h1irpzDkFHaAoMaFG2fWt_8x6htvrImX8uASb456Y-_FCwg1KvCkAkWDdkMtEDAWKImG5UfziSVEAGi6XK7BL7Wb2rq_HbLfBZfxn8ZteTMc36YtcCOscGmAPS6AwoLhwgvA1aDqvsXlskpflUcI09_CzHQFsIXQLrFTYaRBzKEo-N4QkHzG5yMKHsj57QfApPUEr7iiKQqymnTe0b-xmsIb8HMtBjSVAkQsy2AjcRu_OQBq6BtqIN3FMJPiXNkW7kzam1C-xEN97XtCFLi8AzSSOVeFrIlvGTopCTmCENXxyUOrsLhauV5U8EOz_7NP37t7v5lyPdqd0ewgj6Na5v_j63N8KTELf3HeRFXXr1ErifNBowSm8H7fsZcxfpb4eS0OGLh13RRQh2escv1A6CAGNbq9-llhiNS-R1ERcX-Bu1w8lF8gCDAhNtYlbvWNWZ_0WYwpIEpTvgIQzqtrUohM2kTYQ9dNH9-xCO4y23tYc_FcnCFsa_Mv0ct7PbfhpOeYmSzu7KAeSdHxWxp20IK3tir1RzN6P5bGeJztVU3GxPrlNO_-P5bGRL-Cq7btW0WaRxuqy2F6gYdAHIh4d9Ep_qWPWaJvf-e---dk9NwBn--d1lWojpcCB_u7TOJaLaIQfNN4KmZmARb8sYvvMK9looZMTNeRRQTAQGj2mp4S3494oR4l-1Gp4BwJplK2s-EAssAuaoVFLpE1m7dqNPr0DrH9D_hbPQMhBc9SvAvbf6qHwQxij32E9kpGosc_EUuk_dMATAX2mqrQEtTtsPtnG6kg7ICSu6qCD5Kv59LvHvBhBqv5SkJuwncrK9_2KwpQJtdqO7aIhSguNLYar6zMVct2dQQu-rndnog2nKcxqKVdrwbJCkaoGGlaHckAJzvN6Bu_pYcAifDuk2OJhbcb0IgOw7AwnDRbqJ1YXU61AnYcd_4nOuS8uNmXXi5uqLdtiv0vWldxAy8fPOmjUB-WP3_gkdK9BGfBkSZ3nG4PkDSmPqr08GekSYBHnfRVBZWsFiGYsJvH8oVFaQ8Qwr0od1Eme5tLD9J7HiCSryVebMTiDwfbHIPO7frTS2_WdHsCIyEGvfMICEf6HA1XNZVLwHQagoWEywZf8QSuXnATsZzM7yOWxofhmesLeKwweN2QbrPeVQyIpgbHfZDOJ_34CoHcUJ2ldzBTi6Q8-HilMHxxyP-TbNwbZysYZAz8FEFK57fSqJGOTQOTD_XQTxzM7dyHrEl6wByE_JVV-FSpW_fteHWTyLY4ec-GNPBvYfiO8PsM6WapM2TuxPdhkyZVlnQcAK9bw7nkFv9cBYF-5Lx4cGhi8Pvc6-SynTnXDJ1MCuV5RFYwsd2Ee5QSPCbWNxxn6Bqnx8o5eFXUFcu9TINroPbOy1tG8D7WP0OwpUdNwT7yV4NzwKZBI640G85WilH-lwpLge5VpQoFH3iYoJbpxvhEkIrSki7oOYK-GFJaSiNLVBaJJZz1wYpdIpmRzXlC46xrdgd3OKPAHgeheB_oCBM3T-PHp7D0ChGDIiJFrIErDkkL8sniNdtvWDUtMaoglOg_6sNhaq8jjSc34_nSM_bVm3JkQiPjIieoMM5fnEKRRe_Tkyu63eRk1wO4c02xOf4kt7cFNeGMwphaL_lui-JTAQSWRdeS1HJ0ysWSQHnXdDp76tNJPlc_Op8Wcl27roBNKPLv1JNlcxO3qIsDFZIZJVsyMUUxLC_nQdOpHbWmvowoVwSOfaVcPWJr235hB8k4zgnp33_uDV2F211V03I0dEDrm8HzG0lLTl5lWsc8slIlB3Od2lfX_2odYSDRycsY54yVVCJ66WrMuMeS6sDrvYNY8aDgsuL0zK7lNAmbJ5L4H_1tp-PsFEpdWMh4r67jFOEY0am29WFG4JYhYr-Gov-f-3EGca3o9GtzcO30PWZG0nOMI_i6Sj4oMPZGSrgUQQ0bXMNxBJEPzCXVTTf_7DziIZ8-aueJ9DWoGigJg-l7DgMJ_lWP7XuigEMBxNxbCAD6FrKXeaBJRuLclr-eXSCRI8RhQoD7sX14TsbzgUv0DOq9Z4tkP6m6LaLOeAxOX4e88fOC1Z9h-WU04eQoHahMxIz7vdUfE7Atca_SthRRhezrQuS57il-XDbKygCBzHiA50KR_x1DIhlv9DCNFTNvyiDt_AdOb_3MPm4ja0w6Mghd0N8i9VUNeZ7SjDf1Lre_nKFxvOfeU0y6WxDtHZMWj2WAk-i9KECrLTHBROcklg1mfrsCpNVjHnZwBKgzDlDIIAQtijgtMmtfk34xlt963WOtSWuJtVpkjhxj2AqAHiPNEtHhMwyMByzvCBAPpUSQyNEO6i5AlvTTGyuRMVHJRciDXb1IowO8Zv8Y93ccy5Tkd-RYqS8asy4MM6VK-BnMkJTIqW86fkwa3xZ4NN1WvIzNXO0d4j6g3fjhaKxkWHH3Z7CeLzYytEkO_-bfRLc4tZVklMPsiy3J67ZsvdGDlOIsd2cxxw3WpEW1X9UQN5upmy0Oipj.GG1g_co87V3PpEx-2fy2GH1FpOgCCyCd-FyuH9sNtIM	\N	2025-11-18 17:27:15.550117	QsaCxQ2S3k1KdQZ2iT/oKR1htoA6fx5NJZ80wsClByM=	redeemed	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	6d58e2585e684abaa12f38338e85fc05
3a1daa2e-7b6d-3006-91cc-b540a1fb55a8	3a1da2e4-3191-7923-a780-699387b8fef2	3a1daa2e-4a09-550d-2d70-85760204b9e6	2025-11-18 17:27:15	2025-11-18 18:27:15	\N	\N	\N	\N	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	access_token	{}	42b0a89599b64811872c92ffccd8a002
3a1daa2e-7b7a-8e10-1585-976a7d4988f1	3a1da2e4-3191-7923-a780-699387b8fef2	3a1daa2e-4a09-550d-2d70-85760204b9e6	2025-11-18 17:27:15	2025-11-18 17:47:15	\N	\N	\N	\N	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	id_token	{}	a94ae0e9f7fb45c7bed9927fbe9af23e
3a1daa30-54bb-77f3-9b97-8acab551202d	3a1da2e4-3191-7923-a780-699387b8fef2	3a1daa2e-4a09-550d-2d70-85760204b9e6	2025-11-18 17:29:16	2025-11-18 17:34:16	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.HjW2DJDJ-eAfjap5u-pl8WY6dcytYdA5KG_pRW0T1ie1rFwk9e1NWOfGmfoAHj00gtQRnlFMXh0mBEQg0ZdK6mip-vArvLfbr3KSy3uxjNJeo9y3j5YRAe7jN9TwtpkfQCV9fBXx2z1M9ecgysOQ06y0z8BKJ137ZQ_tnk5l69DRsc5lvpnXZwvmtrfzzL5EqPas0iIxdPL376yXXaWctzMCUAZSq6_SuvP6cdAur8sbVLHVw4lmV1DZehHAK5ipMkCB-KyxljfjmaW6LetZcTlMMhmrHd3RuvMT0eImDVWP93Lv_ElJQ1O9dr1voxIHf_VJfqwSyuZxuXlqcxBciA.uiRg3XIBw1Xg5WN-iSwvtA.hlDHVJYV8uSobkqR2ixDUHI9poY-TLOjzWZPO23f8-k0iUhDyyetyM_BKU6bhZOjR-RXy9ZBfyICA31kXr5xX_5FF82LvJmddpMH63x8fjwb2dH1iaQfIIqaHjuSXlem3wi2Jn6weg_VjtWKvpyOfga4j4jxcxTj3216pGPB7SiNq05aQaw767kLZJveZh5RYv3NmlDULNxAA7tYLkgPIUT5hj351gVbcmrdfvEWsjV0hy1WboWWz3lJbVYOYHSsafismIqWuZ0sgYC4W6EYSsKKEzgB1zA-BaKZ6bWeGu72K-HYLWh2ss9oOXsenuEwGFbzP_f9TBEWib_3G_e_mXjM-CJdtXiUEuXpxr5pg1xYpQb5k4HW1sXOgJU2FUrnJduUubMJuoVYAU9KOEbw3EEs9dXlXQoXn0GO1ypjlU9SVFo4V45twu1qAnTRYDbRF0uxSpJeD6NDwYYDesLjy5zKs7Wsgxx-HLCFq16EUFOLaBGoBZHifsLm64Lk89Cf927Q-9d0YaVykz9ZYPO9gMzqLEDo_F7eQelNqrUESQlPYW-ZbaxdmI7R8-_L5Ffk2D7aio4AB_1tWebyE6MVgRptyVbhv8_VQo0VytUPFf8oAlFN-_9zwPPt2POylRmkFjuVLvGPT6AGsJg3RbP3yrZ-K1Q8umh0xMrcYe8Az68VAjOt_8bavKMpTtlXOiRZrURO3JF2tswV0Wky-C7V6tugyUDdisc8ALcQuEshx0u4oHsVaMCB23XbWIWnQYJWoUJMkN1eRqOHV3u0Maz7M061PzWaefQ8AbXSqJfy_IjVeak6KpSSrHeb0mk-8iDZbkcjfNb5F5j-au2yziE3_HhL1NF0JQm6QqCX_l5228Ow3HAleafkWlWvtykU_Ynjxr_FJgy8CjobI8onXaJF72_fXyQFT7mddoexFoA5EDrsPKQxh9TmcI6WVUuGHJtA1mj8Wx8EW7a2HLNMIvmwQWOn0SnJpuHZxRQla50iRegWvb3T6LiXNkND_cyKuJfphRh2aARr9d6xf19ORGUB6woV8No0F27tmYaKCR2EfgkcopWf56yy65Zy5TT7z0xKspBYjh2MLsb1z5ZIPlqLfsAMByHnKODmzgn7Damce3v6QA9bNcq1wpWF2y-ZB8AwEqJtE1OX09w4NrBNc-4bngb34GDnK4u1Zshu3-gwH_q02DOfsU3XOqfmpdQUrn-KsAEZqMh2OnbO-Hoa-yaAHXgbrbVtlXbxeuW0xR37CHgwcUhGeslqNKy11Qd-RoArDp3IBrc5_W50iyxuaM1hI728KAvpvVWtz8wFPwRDwnS7RzstHYGkYxBvJuG8vmczZBr2VtQej1wKKH8SG4yg0YrsiYgAWRnYvty8BZtssKY_5xJmLN3EK1vGxTDoFN1uFiQuCKtEAnqUhegXehQXqH3maN8CPArHfQVldGtDZacD99XiAujBXyR8PKbhrttH5ACB1AAtioNK0GPlbmhWbSEQiJQtAheWMg1T7FehBCTo6Dieh0tgiLVW2SOZUdErR292UMbJ8I6Y9x66ecdZcsjce3CIJmnt2kGe5uLnwIl1uro67AijHaG_NcX-7d0Ymetpcn5qJXP8vQEddJpCVVSYHuXWIbxyxsits3ZrE6yXO3ERJxmPwvWkHt4Fy8WEVzWalX9Z0EgB2KHduidz9m4UZBuICqGDBAkyNRFNsjzxx98y3A9MQnWCql5qWk8tS8cZpHv01UdMYDwfeZ9_F6KGWlmmoKRYzhp0DxByZ3ltXw7s-D-CPOEJ8SiPukr_stiyzqW7SWlggHIpJdtPTC8jD7IjYppzjgxHgSZJ_y8iNBVNf8TCasLiLi237fY_vj7iiTrDKrVH4EHCUThaOmLuKYdEOCIrrI4jbtDeGcMiiGFRlont7i7xQbnXPEsH2CnGAIQ13521BegOcpLyDfqRK5m4bYxC9ksXbILIoDRBti1JRn2zMb1RppKtKrsRYwOh3lO3vPWWxN0mAoCMSFwWNfJceq5Zu7UdPBpV6MRnc-vfW178bnXA8IAz0q09NpGPqIyLiyrvPN2kfQUGvcQjASW0EiRubewwoDarnyg9r0azKQTCkqeZiAcq-z7-u2Zx17zaYDC8HuvD4wrmZzBeyOQEwEF81iDy9EOPmQN4QWuCohEX8HGeNQuRXz3QjLqBvg6r7PZAlS_kXkC2XOCeRQzdzyLhcUjHT8Of7w7DG521N4DTCQtPM_i14dvyY6KSfvQ1OLQg8xS4gWANsJ51BmwH6ZYcklCxOI6zgbNnXvCDKo19TnGZsyLEIO93JNCOysdd7p6jIToHghcSvXmvll0t5p96H4zQ4CxbT0h2JRDNObFzxGeaY3YnQNmHErqu27_42cuYSIQie5V2FnO0EefDg_juFaR_pdfeSblEUFZEcynIeOrXdrDfQ2kyzCZRP8Md_HSXVeGhczB2lmOFch5WzY7VPTSmWkV93TcKjvui6T-NXKYDw5v9x0RIJxvtZEOkfkJsnhmPmzmdn4fU_Yr1xK4V9Ex23_F8O_KmI0cV_DuAUAml-RTU5QNGBXSLKKAgiM9qcZBdgL43SE4HQBe84ivokDYZRCNHT_xpcfo4Kit0nI3jrcMjDrdoIJFMuDHti-ZJwGKsZYRMQKaYYyYnqmIBd7Cr_EkBz3-Q9lBbOZDMtaBMzRNJCjIIfJUCFTOdrYDyStvmC4826ulqJYlKU_vjcT_95CIMFXZaYL_xni5JWb6iQ6pueEXA.VDGxuNFmxAfy3fJzdVK2vOcOnisfxxGwOkxdxFa-3c8	\N	2025-11-18 17:29:16.853063	xK8n7dLqTr5UOOwHsVvH1hL1ySjhasJRYGoCl8XsbIk=	redeemed	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	7d8ef0cbb78741d6b0eb5c3ae8f7390b
3a1daa30-5541-ed25-b546-a69d5d5f763d	3a1da2e4-3191-7923-a780-699387b8fef2	3a1daa2e-4a09-550d-2d70-85760204b9e6	2025-11-18 17:29:16	2025-11-18 18:29:16	\N	\N	\N	\N	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	access_token	{}	b8c832458a85493ab62784784c7c6394
3a1daa30-554d-e987-ff63-7a979ddfb409	3a1da2e4-3191-7923-a780-699387b8fef2	3a1daa2e-4a09-550d-2d70-85760204b9e6	2025-11-18 17:29:16	2025-11-18 17:49:16	\N	\N	\N	\N	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	id_token	{}	58042985b65040caad87b7b56054e145
3a1db955-e2ce-5157-093d-eedc61807a76	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1db955-e21c-697d-db53-2a221a850fe3	2025-11-21 16:04:36	2025-11-21 16:09:36	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.dHiIld3F1vZmTZIwMc-8d6dLdMlFbqK_tTceTt82z_84030ZZOSoxz9hx-mK2LBNpE_cEMjJ59lBWzFmhFr04fWIsIWObFB8D8GP6DfWAafqwc7pF7_Aw21hGC5jVxRYQUqsgfbEzBISb8Yqorg2d8Aw7Hd1APl1SGKlAVj94wcllcZZM1D-viGFpWGbMLJmwiGReMTEDFNKRrIF2MTwia3DO1zwQTu7cS5SvFcTcphVfv-tg6Bscis_TYPOc5g9nYvn5iwx5kEh_EI4vPQfJoTo_5Ilf4JWo15YbhKF6ZeEAapWPvDWMH2HveOK43vC_-oITocfs2ZstWfipuI-GA.Tt5Ncv_cNdjTZ5xyuFLTPg.LiXZ-7a8l1JkYmkEtcX7kdo-M0PICfaokroXXhmu1JKBVpYiV55tBEv-tIm9Th0WLoBREH0Z-mCruAcbJCivCk9RJjtLYvOyVgo1j4zwbD7E06_MQ6aS9KaInLNqm7HKh2mjT8OXhmUTO7svSzk0_jRjVjtGs_QLcX2lhkc2bTfjOYB9L7LPWNHPpj4qZGhLvo_X5SCMPOHY7eURxvVJ7VUMHy6VS2rnFvx0MnX4IL5lXYif5ZteAEKNX08bIPriQKy3k9L86uVErl2V0VbAtO_-JsRzKCr53iMljZ7IuC3gIY1dkLRuYhaGl53KLQaecgUlVP3wWs9UCYGrnObLHm8YclEoodx6b9zYSZNddQBxvjfwFhYiLp2PXW3J1LWkbpBmEndn7raubS8u3aaLDEEORPefT35nNbwtop-UT0KrcSwM07mUaLBThbSn0d9r-Sw8lLIvyuJzdNZs-Kz3vBPwh8ELBP7HPLhc7EDX-hsxAHQDrDrh6aTynlbim_8EykrHhX6zJkHZcsZor_pwmvcYIt2w2VeL2t3VwyyCALO80JlDUDuAjbEzEtmqxYkJcZ9BSUFUMQw6GDZsn9gtFfhWELBIHfFr_KLzRjw9LtKC5rHctZHwLAqfNrd45cYPiBZQbt5xAGUPfnT5IgXifs2xuEE7C_5SYuFVeoXnC_t0kQWVXwnxiISuq75YX9XTYLNMdU1WRq3rfkmySkM7CynGnxfymavWnXVycZt554bbQI3UwhJgAs2rWrJr2YcIvghcV4cp2ILzHdH5FZj7rV8SLVWmTWVDX6smYc1vbQTJ0kq9UWi6xTgi0fHJw1jTS3vJoI7fd6Ec8-M76qtOZ6ICaZQgzg4B-JMgInRMJJNfOIoRZlUvJncEqhtxTXtgBTxH2bxfvvPYz9U-kA3zwC3mujhPLMtZLuP7paMyiL9c7ek6s0upGNSBjJKs4rkWql4kbKa38YHzF0DQBYvckAj-MgLp1JIdOcJOoAnVAaQDm1ld3dyAcP6WooRQyNE9LROoGaCr7h86ufyYcfKyQTzpgiQQJKARhfQNqpn1hCcc6qDt5rG_PQOoB5FV4GCkZh7grxmvMXsEI_5vDl_w4Dd60MLV8pNSYkpLBlEyXl5AsOxBqpq2HDKCAraKGpGSD78l-XiC02GBNbvE8ppb1oNo4j9OewbZQFvmOB-ZIMeJHGrheL8R7yB3J1qiWaLjiOnS86bbEUjpjQeuayx_YWeA5bvWbP-OWe8O5N4M9m7jWo7N4IQDBkQLFZqeyErwY--JZ3Z2Ynj9sQpMq5osDx8Pzaw7m0dLfO0_Ur_5kWU01p9aOHnapxFF4d2jOeFjR776xFM9zHhnwE7igWTyXQEuT5wAkHRa5V-V4Ymwf-RMvSdlbfrFejnpHeUGnNUGjqcNFbU7xjSA1qX_9Dxl87aqorTQQ7frSJ_fXYeVCnFQkZnYAkdUrc9E2DOHn69eJCujJCjZZC4-DxSFJLSkhyare6OOwS8Xv-bMGblKUCMHu-yKOH5MMy-IgHHmGZeVCeBn01dxmkFfCpmADjmuCVoAORN1C0naYocySnMXPGH4Bz-ZmfC_tBetmYhHgRk_IBUSpbjd8esGdJRGW1POjLEzjvtTM9ZttnoDChUZooPqZ2s0yrH7-scXBiDP5ORn7Tr8lAxPp8WIf4ZKwoM6lX-NMXZAzoH2rofg8041EwjRuaovSybS34auzE8f38WLT9RRL2wuhc-uRPRIrtzRE3z_4VjeZFad8ex7vvBLDL40-QS86eCT3Wore_jMikqfqNAHR8FAZg6xSqyCm6cLgmarj1wDI1_97jSHyiUcE1yAe50PGb7SlYprtUfI580n8G78I2CKUpGEcWWblrZbiE96D8FYfDNlUhQYaeBjH51NCBEReYTuzS72swhzA88w3ZVypN5OCuWYTqWQ-V4Xg8j9FirVNBnMiEw11Mr4VjjIKRPAfnSsUS0m8vAibhrbB67YCz1JKZnfCSbqku6_68cZagwOMZVeJ1_nX9dKmaAYPCC9nRfIXZ_vTy1oOn9A2OATj-MRHSPoVGtaR2JtaeEYA7JxREkZ2a5FRIp3Ty6MKSELCF6-XbXhKw58yj9RbNMW2csP5QSzKlBXqginWaNEYI43aKRrhO6MXsJbjJnD2HrK8yNeq-_Ccmhxe4Ffzy82lKwucJbgPGJjMxeaEQlretPoZwF9a9SHZYsP-ZXPdgNOZJHSrFfjhQ5TCE8krXRfG5NDv0kEiNS8Bul-0DVVqiaqeHe8sq5RGOSi_D9E-kGTm16x9qX9XO6lEBkrehilfOrQMMWsJVI_WA0y3_pSspsl6PzcU-kRNMJN0N1yB2F2060PkAZnoTNEs2qPapcsvh9wMfYOAbGbY7sL2LraLLZXHC6mfJ7gMylRLnuzitd0uJlxn9tDpxsFXL9oxBs1aTA890Q4bU_4tpSkRMI_duyjqZ8rxji929lqTPCBWfapcj8lF4dockP1rtI0p7IdeK3BjDW4-EDF7i8eVRI8wHYODmukM8UfgHcnLAk.PhAYrDNvOI3Z73VxL0VMZUiHcMw4vvfnyURVXZxdmnU	\N	\N	eHs2B0mh3dz1QmbSXiOweH9OB5FPe6bADS5mmMPLxEA=	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	bf3612aaa8f6401fa5465b838fbc3b85
3a1db95d-00f3-f4ad-14f5-19a864f99c82	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1db955-e21c-697d-db53-2a221a850fe3	2025-11-21 16:12:22	2025-11-21 16:17:22	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.KdcpaBkdgd5kiAFPO8kMIgJgttkiNtM36BXh9TZQEh3XnoYKbZ24qJoiwsJXGkvr3AVr9moWEibBJDOXKx5f1sYCBzoGx0LKmJv6Acpo_YPpXYi9RGjb25zO8vG_Nb2ujpVhmRiXfhYJGu-HcqS_Xp2ScVgXmZOiJ9TlcMNEINgEkVVFxAk9CmAgyj3kyy6SAni9zK1iO3tvTxWabqNaHcgRO4xpnZOrlLYjgd4AdSAwsMpQf0ERSGBTL54l6QNHaDd-HriBOafBm7jHWK5Bv4i4DSb91oWtA4-9XL9GYjJwfHKDgUZB-ChhqbCpEb4Qvls58fL157UKI4-4jv2h5g.AuQDgYRrokyUZlZQqox9jg._c87Jx_d9wma8WCptMesZp_zlJExGjnhmpV0SwW0AnT7aPWzqhFQC3fz8b9c6-37od2IZdUQ6Pdpc5bTv8sRZNtGG7lkNMMXEtF1yctLMR6UHmncdeD9M4pnWhda2ArVQxVpXuzs4AtOVOOcoNJ2Qi7fyLCO8ijXFZJA6yAI0NTDQPSf3WgGsJD3EVjWCgDp9rJpXORsNgx811XERb7NPYCjzCBk1xdGoV_kx7bBqoyjUh9LCMTjxSYA5pPAfWzKTRjSMUf52jEOIrXT1AIGWEiTIeF0cIO_2ZRNTZgHXJnsvqhtiXq55PqftLRVrjUGgXtMh-lbl7ZvkV-RSrt46tFiUh3uFqn8u_S0gPlKDH26sDyOZt4RMO-Uhk-UzrmmIG7DhWpA0UDfKrOR7yiQAEE31I5i8Ek985B6YYaFNl1TTzpXRYh4N31cscwLfcz0CtYRzzGo8c70uRlR2_PXY6vj2P3wcEEckwI7RNC98UXQ3DlYk7vha_RViz7EMrH6ISVl1E4u3Nppmnr9DLkPqQIFmhy-56FsC4vjOiWB2DXDPgRgv6vqmLFqNXb9paqB8oTvBpIJuLJ53xfk7tgMJutwKeK_2fIk1bcGGJ8TA9uVPJWsxzdJ9ixUzi-naEKLbPyVjWLuDJ4v1wv3TkUYdb_odgxrKYOabGVqhxzXWPQW0FTMqAnB4SnDcevffeGePK695HoKQl5AtOXR3HQqQcd1ncRgK9Co5wXGUHFXgOjIKSb3PDjfeYKWT5IbWL47aql9udIm-fpPWXTlNRol6NsWun4ogjGdhjeaIe67BeJnyVRkS0VZTleRAKVIWvoMiJNof9rDpkfoCotEIOdtKrxAuASx0x9_ATj2tD4dHV-qbKuym7rP51ElE264sluoP_wAfxDhg83LPwN9Y3-o39maxUUnDRYb30qM97tSAwIh0r0YQZt0qrdIOrl4ke-xgmI2BCYXaevAlR0WU5jdcgvgTADa-AtVgg0s-iraL6fGYfTOd8qN5fGYALG5-gVExGMxJPJMj7tiRJihy6AmTlkDu0n3L8NQJTYd_rzswvv8HjesR8WkJRHwxUnUPTA3kQbNqgWhY3TYCwLJMp0K6JNwD7bQURjTpNQMuLgovShjThLq5gJ9xZuuAkABCMbDcwluvCDqRsxt9C_42sRP8pS24SkAzXitiyCtFmFzGWEcA54zWUkuLdHPMPkB5xXFh9YvJWBSMTIKNvQlJx3OEy7KWxDjEqb8Mf9Oq8DCLh2FoeYXQjYAYASgEaNX_MK9Ea717rxJWL9cYy2NcRlOOOgsyzUZ3XBQT_jvhsiuZf9sCT88sYlTe85nOyAfQoQxPUFoDciJ2eNPyHdADuGesSFZo3Yc00iU8OBwTYU3ErPRGcCi45WIRhuD-VwQrhvJI9n1brWiavVHH8OZcvbHT28U6EA82Q5neKh70e92yOutzGp4BdjgqP1gOrQXv4JWZhl_pMCPxXJZt5GP3ja06vMljTQvLYKvmkz604Cr4eV3-mGtNjp-lklbxLBgokWAYPtrSRLcrytGOl2bbAybkCsFKuox_0RK1TVtnoWSHVMlPC-AwUPCuqqbWoW_uUsqtuzNfFBRDJ48fpoC1Mc86lva1rech8W6XNYKH6KCBYlt85LWWHwaaQRlPrDOZcXUnu9dL5A5YFoszsmT6r33O9htdtEO-LPTvtSUOVD1JvtzrjjLOeC8NGcpy_iC5qGMIoKXzaqRXqi3bdfs2HBXAWCUzuhxd6PGN6gfRUDKAziGK6tSsV7A-ZTR1CF_Ltjc2eBQIf47sdxFwLlslF0lS8QakTMtGpwOP2_hks16GcOyLwnXcgO8GkHIgJwv1p1GfLRTPCcTSuySsxGqeUgWctpvN_srt0iZ5lg_7lB10F1ul8RJTbNI0sxk--wVED1l7pQEpWNIo-AH3eUmkOyEW48MbBsgfkoeCVdnN77fAdqqarNgFBCPMb2feLUOoQFqOLI2FrYPZo_ZBRpZgQlRNQy6nGHf0I0ImgJXX3mCedYw4PmNXr3vcUyw6-wako-zwRnWgS4mEcmxt63BqwruXry-xcKOAoLHftpq8N0ayjMmgU3D-a385otFatBELFDqCPVOffhyWyQqd0ipN6mDkhLZ2WDrVk3ek1I6pTzx4_obbDP2TIqun2xE8tzJF6oT_l1xmPsyx5qIU6vh9m2mjnWguZWL1JAlS9uT5NBr0Gs1W6_BJt6sVm9ZPIYjZrqvhS-JmE4vk7GTD1UkLbyK84VXlL8rLoYIplV21HdP8bOiA-m835k5npJ9gJoh9OiaYen2sk9H_XBbZs-xi2k9q7WF9ZiSYFgJlSQh05wkktMzn-CgjC5N548Ad1nTikEqoS2T4uUML4pzGoyDHV2JBDk7z_OGeI4Uqrc_MtbdNSZEBYbCApqwNlD_ymd4G5KolMSttLujr7ZlGtnMpHb2tOCc5huIhBmsoH-LxoZancW8dbM585oI-Y5a_LitdTAhjTs7C-YnmFtbdCJ7EFD-RgQcQEEbkJSFHTY8Q0W5SKs.zK3qXrWPweE5Y8qfqwD6YSvC0rwGBhTclqOZwQuqhWQ	\N	\N	lVDqioeXMe0jzwWJ5BTH6ptEiTW9HMftIWVDOa4b+3o=	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	daea74b95903482b8d930c3c5ebc4587
3a1db96b-3cc5-44f7-512f-e50f99f3c94a	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1db955-e21c-697d-db53-2a221a850fe3	2025-11-21 16:27:55	2025-11-21 16:32:55	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.uCnkDuecfe1oXdABC1LuEO_EEHa2nH3krRSDfW4XQnJzLXWpe-zMrYPRiIQYYQkptqVq4reMqqhUVF2b6bDosUXaeZ5zMaZ6hJ1OJAG0WTWS65YrfGZMnIlx2hgXqPlwDA88wvzACYg3iJgugzdm2A2hDfrvnQ_4Ln-L2WaDG4yfT1l6tFrMEkZB9hDoXu-9LMLSaIMOe6xeYJfw8jj7zpLlK6R_JSvD8DkoUVJhKvFvw3eN0kpG9iMoGPYZBj8huae8gNGNUe1yY-9q_MJvBUTRlOxItBV86IRp6g4d1fnces589SKu0_YZSWIUAWbtxguqHIg3sTmNiHKFmKaXWA.TLMUlGIMvdRikiLdik7-0g.71Prz0_G1T_cJDVHcuAxvKohVFGLHpizYrm8beNdsDFQ7rbJM4D8Yuyj0HMUChyxCi3fAMcreKhoPL4zXQ0Qj3PgVA3veZk_XZVLEnnxRzuICSKRYkQbTzJuskEC03qTN2FTXgPFD3t_--TKm-FNilb93Dazev7TSp6l1QN7Zya_lm8_ZmyFF9vtjKhh6IgdaOAqsTrm6aMg48q5b9LoUXHZbi6FA5IiCVWJvUbe6C_bzgswVpEFjHySGbV6YHWCDGUePwlFuU_9xofI92ybZzk7gLAFVmH95Z2deZvJ4ZZSk8R8JEcgewkhYNzzbYl2utgjtRFinkGMvqd_Gt_tZ8eY344-R9dKdmLr1z6K2s-1fpphDmcGVC7tuZ_4Yty9lVjbIABKEqLnc1wEhFaT5Sc20nzuwhvP8k_AL9lIiuHcRNb-S4OOmuVlNLVRQkEGivMhZlmSD-gfMdNLI_GHhgM9lReVtOy5cw-DT3AH-rTcvOc3lD46qe6Rj6knISG2zHIH6TjOg5X2U5RKwMecDSJN65iJb-wGXerkG5pMP8EHl8Cgz4sLIR8i4H68B1uQR2jCUjTq6WJl8VqJ3XhslKKlGPvFC45Zrnvw4dXM-UqnLo7lC-E3HsRZpSRUiOthE0TK8RMdoyU07_Fy3C3BSnaVsOePXDXUTu6vVgsbkYDylDjII2xifuWwbxMCXoJ9_AfThfW5RQ8jeB719nIp6Nfptpew1nPNrMFDsN-A93UERYiqdLyepHWsNsGXdGquxywu4voygdz7bNcy0tRoNNHSx4gLqDUQHfIVM-xI7kp5nYpLuT1ybLUi_3QTqWjfKeXY26ax326F5PPAfI4SPLMCMSiTWD7me9mNcUcKkD0KTrukdH8Zy13d3UquiWo6Vx9iOBP-DwFAWMOfdPwjfqK1E8yp9TeCZlerShyDqHTC_C5PvfHKT65y3c8V6CmTvTDxt4zWho3f-ENzgc_PVdJgU8PG-VH3I9Fphy5-0ennnDYg8KS6qvmKM0zhKYokQHyc2OoZRrs8XfTohITDsJQFXU5hE7o-1VmKomwMQtVnd_32l_xA2mpucv-Ae2H6xw3h-FWAx9Y91SrbjBmdl7-6FN0sPG0QYVb_g0z27ZGLIilM9s5FjJroRmbji6TEUQDGf5VJVCZFhL24ACgQ-4dnXkFQz2ZBU2j-pEErxv5E6rA1ThZzrsiL-fM31hdAPn69rCNV7XkZfgI9qSjZrNdQ07cRYOlouqq3tlZBDx2gD5geD9NC_EvJwbBB80-TLvx9lI_ZwiMDvfrdakpK-rqsyzIN8rV3y69w6xzLkDtrI80eKFY8Cr6OKhcrWrjxrF4KlPr_Bl5vhReKOCnCMCJ0KIzyMugg8q0AfvcC3vC8uWpSRxH7RRZB0Y0d6tIFt0KB_N_XQ_tg9Z9vywNiy1A_-qwfOzEXVaSLA_ZBM_t5XQqxH64ZEIHBHAAYEt1bWU3ExDEufTZ1NllJk_tKkCBg43xRxeq2WakTxkShpLenhnpjSBZ6raNojWcjQ-N4BD9eI8MkL2ohh32lhzWvTomQz_jKkJyqJUwMaaSgMtk0xweW7rtyDL-5t2DD4XBqhMHdRTmqv0Zxxa7iUAPp0RFO-mEy9DMUsaTSIoWLAWDQHxz49f1RAA05ytOZR7yQCQlwtHgIIImpQUazZBpflHdY0SMzD9v9CI-mA6QcSJAs6Dgai_YF94MqrAAAy-axIuSu7WHnWmcdjhyXxQPOWTEg7hV_ONfckoq0uWzop9p-uCNYcaQsxcgB0SYA5rpMoFMHxBkKoMiul7JG70TZfoBihySRWPhL1e2TfAF5BZt7CyPgZU4nhR66PiuWCyTiCEeZ34UIEuMGwdVsMJuELqCCku-qkjj4nOfv11mLuyhl3duY13nz94gZlzariGZvnksZAB3vVQ_CeXWXey1kNGgjpOODbLJ04hq2eJm75e9j6VFjF583FniIg3_PPYGvgNOWqJKsuziiAJWHNOHwVtcRrvD31WRtMqp69k7uEazM0JUNEIL5PdCkOCnPU6A0T1OM7ETfCBpmCM40yUcyf9yviae4uIj_VWAi77GoUyL5CgZBzt6NTGGXjHb4jkEIBpzdXAJ8tEidKfnB4vvMYlW_tY_UsTxFZU54s-QRGKOTBcs0AIC4iW-DeDg8n24yt6EfO9Ct52bkn7heCkTIS2YKEYrGJGtgwxm_K0AukVJJQkKbqUJE6SHMJN4F_tbIKFbqJ8wZVYzCxLEGMSIjtzB2vNKUKiDSBLOD2pX_kAzzqeE0PkpoTKckdb0oEgyyqomMDqkgkNuO-TQ7J2wNr7aWJoE3q482p-HQUjVns9JJKB2rRRJI0f9aHverClIGZsISTe_gDxm_hFrBhtl76-wTEVRbPoct6k29l85qr4d8CGNez_RgRAW_JCSX8aYHUG1mtZhnS8m7KwNzJ5gR3JgAIGI3xmLTYkNjVcJGqCqS_kfEhV_dpEfMMvTbdINjRjby1yRpLtE6I6T_p97HoSodpXvgSwg2Lh1ME_iofYM.JHSwAQk-26DflAWXntv5uGY5Egv1HiRE4Vs96CdYP_Y	\N	2025-11-21 16:27:56.327399	WDlGltLOgkkTSYL+CcqHNh3fsf5SWW/AESBuD9aevdg=	redeemed	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	15ab6b870a09419da3d972d0c2d6932f
3a1db96b-4047-6dad-3d3c-b27256056a46	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1db955-e21c-697d-db53-2a221a850fe3	2025-11-21 16:27:56	2025-11-21 17:27:56	\N	\N	\N	\N	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	access_token	{}	e76bce323ef34b0ebde953b0a96b784b
3a1db96c-a393-9588-01cb-4c4add822656	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1db955-e21c-697d-db53-2a221a850fe3	2025-11-21 16:29:27	2025-11-21 16:34:27	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.XsA-ABTn3lNzX9_gAyl1eC3HhP_NZiXYvGzoGZGCgA5O1QsjbC5Tu4NP6B-CurNOBW2MhFq7V4G9vJmp9MsZhSeuGjlrGD9Wjs7-jQDBbhPOgFO-d2sLBjl4upICAsLvS0Ae-WkPIgo05cYDg6fK10ezs8JNxkFcuiXLLs6glJHNe9tc9omgRTCZ0B_B_7TpCF0MKBboA7pUczdZ_2QBQSUZepY3kd_97Q-1jGZEXOH68q9RSOSG9lxHnplgF5phOfUNzQALiBRaBwlB-uD2qcyI-nugrXWsN3kZ049Rg2NFAcqEFQ3zJVrQ7SVsjqxmczWNaGECrQt7SSrNEoBNnA.f7S4YUPocTy0X90g111j6w.Gi1dn2Uad2fZFMP0ZuVV9Wape5qtEKvbD8W_IMy5GeqXdl6qFaUwPrFsGXBwMkvrZ-QMS9NMWTGn6ZlSshXotjva01ncx-nz2LTh29z6QUjVH2tm2ZAUQq33OodVZrlG7GVGZEnRJpBWZL1k4xJtJQP2XRb-0dNreNFjLYlEHO5xxH4_qGKtdLKF2svEWmIXB24HjLOwIoZYSO1jcrrNGIr_ygLdZGAD1HUc00a-BWeA0dmb-v9wDpTJeonr6-fqdT7pq62lHuJrbcGUodV12M2_0m2CnVtteLu_cYF7HalwfrlnvSfHNcKXz9cNuEW2NImFA1J_FgbHqYBWeTGfYRwsNPf_nZ-FqFM0VXXSZDYgV-k9vTzAzrPr_H9kiM8z5giO7O2MGGBCWC5V5gvy01RhGWmlsK9K9YIvhPVlL8petdfcx63RIyv9cEG3uyMgqetyNdkJU4F3yhfhkil6jYEGdZU8yFbwWIuhmCXkhXAtj0dvlILKeCN06OrM809WhP_V01G_6EMAb-U1PBpigki0KVeqXr-4zenbAlrzGWtHbOYD07oc9uDEmOgDndLqMYdmnvsSURZU3y5buBlyfctiVHFm8BsiyruyF-VZUUsZHG0ofBYiSEwwtTcEd6olcAEr3RY9iryiuseZbL06TZc1Gehf-rOh5PNPbQycOHZfgO9DDk0srIcmDPcj1LTxv4hwZSFmHnSgZOajhq3e9QVOVWiRwdDP5eGskDVIo46q378wHERIOqj04OHP95m68Q4JECahsIHTcVKb47hPDvzEiZK5izn5YRVr375OKczUSal0lYNhHn8lYsXC5y9LJdJIsvn-Tp5T1ev7Xd4_7j0IsXFCUjYPTLJ45dZEbEOPLvR2-lujU1WCgze8fNEiWGYHnibr2MWUO5rpIqbw-pf6wdGteTE81itPT3w9ipOhxnKWzT9JG8LGqjy61mVkiyH_-0LldiiiH_jR0f4mCMzh6Swcq7O8p6DQiQJ5PaZkRnb8Vkg0jJ73O-vdv5a7WFLcjXZ8e232WFBoW083BAjnVD3lTxC0uFuwGMqRySvHeEwZa_ENuQzfDhoSZo0MZzleUaJAfzC558RiP9RVHct39_Ue87Ujr0fAjC5zHJvosZiUoZDsG8dW8R9i6K_pJX7170_yVEEHkp94a-Zc7gNFFuC1FhfOhsmuYTizra96bE_88bzY_BST3tDAxmLERpN2eiM47CTLYI9nceLNPiiCc-Emf1q5MkvY9mp6YCzfnTN_gZrgPfWACZKfBv2T44ux-Z04sTMKlPO_qQr7CWc363ngm2vh6oGmRnquSG4BplpvC63SHhjIIPkZ-cwjvj8PJFn_r7PBWhz4c6GfnawRv5Qs5Np2mPupGQ0-LAukqkkqKIIyXwgxNuabVtme6o8mVPK-j5owQQ0MefcQb3tAz7L0jGS2vAEGvVh1XQITuZRY22O3590gNrbUJYTGG6tjcOQlZ2My0-aHVqbpw8_1N0u1HZa2c-h7ZssAlD8upJzDfyJWDO_XbaTXwp3Tv9pyXsYqwlyRZzNAK5d6EXcICjAZNw9FUtsKUrwQuJ8gsnXRb2al7xmPd2IqWB-8XJJ8NpX51UIr_saMSLdTj3p8pW24x-Ddrvm2e5lJ945JifpRuoQnRCGWRvmdg7xdXicCvzUqm8muloTPPHE_sMFD0iPifPB1L9fRIJKJ54Yp21bOKLGp8aiUoKvKp3frsVSr_yafBZa8BUdzQtwBlqNOfQ61yd1tvTV16FT_LeuctL1w27EBDi9ooQLq1vAE9GyM4VD2kvYeFKtWY_RKak7XFWnPGPyPWq97jK3-gh0PprcWsRjDQ1jkqT18QMe-6JvnhbQF6KfErmrx-zJTfZbhygrSeZh5NiP4XqFGpi46chhR6V_vK4xzyzvJEL4hG-iD8Z-lSvSSC7vPkNTcqHoBX6YPYvZdGLXUlDmY12c_wIgNnimDy9pe2u5TSzDJRq82S7QLHe6qZVRs_bd9k6sm-W2mFPYLir_rhUYyN9-e_IoA2BYC7ocg3CuYTHdK5F2MVexmQHdUhVKnRA2mxInFEP6_ssi7IJ2L6a69tFX3G8gOPl92KOVXiDMFYPpGdA2dXmF3S1QNWiWWDqk12EHJa6m2KnGr7MCH0QAR70uJeD-sNB_0fsnD_tQ52NfDaaJi1tCFLWTBh0FpYkWFnZRHV9rD2UJ9IsMhMaP8WYSuhA39NC-EZMM8Pl1iUTBM_rvTK3kkB1D7xZO5FQVRAEB4rc1tfqoV1RMqz5pcNR7oVXWB5tP8AnonOWMazT4cPd2dDlVYCHHT9wh_dDosbwGtck9qv9viBLZj_y14vQUeROJbi9_btzNPmYApbkrcDuzXuHihASjY9ybn3StVgNI29nV1URrc3ALpaH9l1O8LPiTiKRdl0OCST3vkaUFOdlCH8uRBMzjG0Ie1dyJcGwzpzCA2ptKRZ7W3NrN73kTDRzkQvP5RUXcp9PyImr7O-As4F-R8BFmZiQo1qiNf6oR4HrfmRtAA7Cb0WXP4ReY.HCmNTq8r-dZbRzqynso6aJvM2oKgrrPTk4xNPp0oKOU	\N	2025-11-21 16:29:27.485048	0OCfKDRLlRMjuJ102EQoCLFcsuj5+OfRwFUnpYmTpGM=	redeemed	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	40ee3d2081c14708894a0f52151a43fe
3a1db96c-a451-647d-a399-cbd49e1cb5d8	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1db955-e21c-697d-db53-2a221a850fe3	2025-11-21 16:29:27	2025-11-21 17:29:27	\N	\N	\N	\N	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	access_token	{}	5b6fa5f36d38431589b749cac8d14dd4
3a1db96d-e199-81bd-fafa-3b9d2a3bf36f	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1db955-e21c-697d-db53-2a221a850fe3	2025-11-21 16:30:48	2025-11-21 16:35:48	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.0inEp-Ix6IJXVa6SEuhy7oJam0fs4hCJ-UUDLGZbzQUqxiZrGCdpEbCnO3m8pop0ExrGTQW7PVeIW0Lhc9hzVIZtC2Ox75HLISg5QwEOKEYSwGzWSajP-d_kvL18MIdxWdaTiLQWM1UpSuXpOsFsm__6c_XOkQzfRpeWPvP7qZlzgYKCsWkpDZCFfD_ed6AxHjPWL37Pbl1sFpAaas6cmtiNSE-uGlo2yKCYE2rIbhEiIjwpi__-p9qCUMt5P_pTsa82XUD-kkZkAY0_rIsaAAmzV2wE5UWLTnWVitww69wh1dVr6HhRlkUvGtU79xsHokSvAIBrKVNNDtEnVUhzqQ.4SjgLpnOSTzk0WCHDJ15_w.Kb83X1PajvBzZlgCgnDqk1F8E-lLTG0YI6EW5xljNNRSkX8BLnlOylDRoqDSsaCH5N0dDClP3qzJr2Ss3XzxDqLCEolaWxkwaAtH0KsSnFhuTdfOa_MoXIjbMUCPR-UzqJUU2OXbo-ARUVH7Yk4RSqvAWxtSa797ZzdVuHn_mV9rfi-Extg74TmB34oyL5IzhrOWPK15z_H-IiDoCgV4aB6NfdJqYbxNXE3SEHLZAUGr8R1k2LhPYbzWInnzyXpc60ViCOxxDq7lkuQlEeLwIanaiMPZkl3ARJxU38s6adtG-TDrNuK_mNmQdKuI0lJ8HyjbjnURU101tR1nWyJ7KX-eWgvwtsvzweFfD9-H4fgBajYszG8yKyttLiTdJIuChgoXRA2TwN9x8olqeXNwCU_fZC9SRXFMYxibI50HVU_SZe5VkIPjlrlUswB9jy9BALIIhRaSnA4Ub8ERk2iK8s4tx_GkAKMN5Jt8C0o_cnzw6qyElbYLXpkXDLBn17jO3fetR8NMUnFSQRIpgLdIXnU-WbRrgP-j5b3ZRbAGqprt_ZqK_OwWUWGac3exfc-fzBGQmO-yBEGaT2wpR-tuhnPmX4fZBhIr81kTA1ueItra7eHHCNKUb3UH5jRy5n7QOV6qAVSyLF1odUYEdsMkebyJ4Wh0BKtJS-aVesGA-RfMBz7IUzA4L2twzAAtBO3wUasSQimt9pR5gcc5HeUe7YNwrmyS0BIObRY-FUP-8fohb8yb5rYs9OYOH2O7ylDjjxq6zruXjutBV-ylyQk0F11BuF_tpGWVW3RBPueb56C9wsg2X7XRVezuyYLh098BEVb1gTsMp8bSWHoVw0vHATge0mdF8ThPocQlXNFlP0mM7K_2xeTCE4Muspj_Xsy_l6ZlzqBmDve6-tpzL-Z5bZYYAJNvz50MT0Z9Vfgc8BSvGaXlmfb_BIgBk2RpAaamMsvBptABuHOQxE3Mro6iAO1Zlq3D6v990BKJ5QtSGZS_0MDdQWEDASqtyLCx1KH0XgHBcl6fBPpMc0Rm4nFJoWAiBzANaPhkKCeit6larqWTawK1P7Sh7sgGjMG92RddGMdrlavXHw9VzmkHj17TkoUYUl-7Lii4TK-zNeJVD8tsSXHdEnsUVOLwdan5BQhbBxl19Vc8NvI0Qs71qZ2I5MrrvSBWl7p-xgzq0gN7KbZmdkPMqbbXPFtHymxOAEGkXF3iKNlsf2cC6BSW4prieXfHaF41dQmMy8X5L43OggG6veLvOJoghAEPbP-7Cw2Zn251hG9EzjFgMkJRYlXPF51giy5JzYH0gO9BaGucargoikFgKMqd1Q_JVxROTMz-9xQ19948oPhp5Wf6KImWs29J8Q7JUYjfB8VIt1QHoUlfdv8yQCZE5PLeWZFgadK3D1S5Bo-GdI8dwxUI_REYT1P3k1kE3giCkfGndOcqD5Ks2Icpp-1XmWLFd5rrqw0wUDdO_SL1GepkfyIhLeN1GA9WkcVmXs90cHOV_mi04WAP_HBqAYAFsBTWT_YBMSwrVZdsXCxo70BwGMd-R2NQRWbowjIHQIH3JLkoHzE948EoAntVyU51ERJKnTT8OebMUlsZkHCm13XIn9hGoGN4kqJ5kvOW_IbGh-_AnUgMZS-mU07a9VOO35KjqSZqFZ2mv5OGMae20kHtcpPLR2YV8je-4jxnJ76xhisHJbsOKiy98yzP7OnOxXWCTgpL5MKG4-2wNv9IVUVpdjq6d0RHvPcwGBwDkweVzvg7eC8oJ7FTGQdOlfa15dp5ltegedma9Lmzihu5b-o3wIpTF1NijdOgiK2xl5gy4-kz5r_xJHaCBDY9sS1a-rE81LfO63w4_7dY49nU8RTNTkByv78Ej7TcaHkJ0lG1j8QwIxMXn9UsX_HvHrTpFcL7bia8bzwzs7W191Am6aJZ4HTKi5jocgGjuz7ls66yHK0WqI7VXKNinYch_AAsNBN7bUUlnMOG8kr6NJuyN4IDJD43p7fTaY0RZhx7_uCXyEZNuO5-YrsfVfCAHSri_EKZc2kDRU9pA0ALrIVOLDszSyZrxz5KZMOJFN93rHfGV9fQie8-TRUf--E1a892df5ecdajDwwvNayB-PwTvRie3OV_FzH-N2qWnU7elzmosL1HlaORbn8_RnUkk-L-dKAkuue4UzbJHwt7R91uHljeCewsHAeTepKFB32nFq0qIIrMLZs9u83AauYzXnW_uDtvAyLtGEnvbgsNY6IrZPbuglS1HMttHDQ0biuF9dJuSKMCOumMpjR-UMlpD1veCjPZtmfgUVWykt1zw-EYgTsA_7tlsYMGD1Tyxl-BUNzTrbQNJQhdQeFk0vgcJwtoffBtHpxxt7YEtTQHVdVHew5gqAAChUasyeJe1RbohzqYLJ6txqInZeR9L5W7e1LHCguqtV4b0wQ4bZ9SvtVXAFrF16nWM393N8Q58D3FSwCMlUJKLPufHvYvZ7R_o_V9SGKYkmwb5_b-xBAQ4z5HhR7TB5Fm1DrMULD527eBpWL3kY6ciKnzTuE.AhQ7CNEE_SnF6SiLR4t0K4ilVecryJDU7nOSJjY2B-A	\N	2025-11-21 16:30:49.649184	xl9VXOOa1lCxcgztLiQUj6oldI32vC9d3HZDfC3QsxY=	redeemed	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	3b50c34a67e249afa65d552fadc153a3
3a1db96d-e563-de62-69d6-40bb97d81191	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1db955-e21c-697d-db53-2a221a850fe3	2025-11-21 16:30:49	2025-11-21 17:30:49	\N	\N	\N	\N	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	access_token	{}	3626a9f568d4429d9bc02dfc611eec0b
3a1db96e-239e-e1eb-42bf-5da238f23ef0	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1db955-e21c-697d-db53-2a221a850fe3	2025-11-21 16:31:05	2025-11-21 16:36:05	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.POa7UeCzsPLknSHtmb4_rJXK0kriJQ70prvKvGiRw_4yQTDJYAH6NbkhoWOW39t0Yc6afPM82Hvks-d1s6oOpXYnRI4qsZrGGCdaj87X_NO3UGA6FdzMUX3ZUuucMfgkG2ggldCsgy6XKXLcrVyWS9KJr37igbb6sXaWq3AEcxzZN0NgRku3QRp_Iav0u7tqZiCv4xL1tjY50QsCS2U7dBepBegMbeXHjaTFIiIxhDLqbzYt4tm8-Gvo80YHbumakG-22IRLJA4I609RoeEqswQrfeNKe7dLNB71pYqc2ngyw-ZhzGKjBWDAgFCWzeU57qmRuDPQA2TpGq_hYOappQ.uWJXUreQhQVsZ1mSiALxBg.78_BXxMJyex_6IVoBJKWrvK_lleI471Nb3dyG9I3hcyD4dQ87rFAfGPHZRSvhc4AdvWUxObffm5p9PDFzE7qSaR_r0efZRl4zG6J9Jk8tqmanwpNASwAEzEMogjX-9b99-BkUPFx0DUwKa87qMtSfWnXBiYqzhRqJtBWFRklu2Wn7GL7VQvlv3E_hXi_eiGaJ4vZwzHmaSqDuLGqRAXe1sI6e8FhUwtO2JUcPggGWEHVxeCzLCJt4grohzqUSPkY9RepKCXFsM6EmzCrAyDcAibmhXejwgSq756bSUX-5b6v-ex6-sSl4kY-r5NCbjBbmVLvwB7N4zJxEIr_z9llD9TH_QIkyGU6jUQkPxtxKz_S0t5R-kzFeuu8f5z6OymvU7uuLJ5Y0oTENmhzFiE0MltiqMfRFRKP8q33R23lo9Aaw62u39PB4gc7iZFsQbua7CEbXpiznQ0hlYFxeCExp1nztwR4o7K31EZnRhd176hK0rng61gBVSGAi5QKDjRXiQrQUiwRWRwNVQx8b6FfNM_QD4UFjqPA_6egSWmt6LyM_wQZ4lllOxcLjqibRlgiDtVMJmN8Uo2rY16lVNvSDmfvJb9V4Sauja1AGLw1PTTdSsjHKKrV8OTCnvbhA_SmN91YXasZZlhqRTDznZap2REl4wqlTtw4RiLT4vg6ZfwQmNQrwWt1FgDuiSaFYDJZz4_hUlcTwpdqX61aVh8Dx3MSEM1F33ZOR9QxCl2OtmLysphOP9vg3i7GY06c_Nmm_qfW1iIUxdL2ukiS7MrFzVPrJ2gDk3klveTCxycP4UJnmfLYIRX8yyhce9sEiAIudepNiwYSH5wC4JF2faTUMNkRhVYTRr31hED9v1gcrlXfgVeZlLEr-G9T1ueL40ypHdjwU9hGdIq0KDYvlHRCb2xBiBM5VPqU-au-dkLwulwBdw3NlFxkhy0gkAWry5jFVWh3BNR5xsvurmgj953EgccGc-l75Fcum12yev5BBiyuMtqmGSjUD4KilU6MWCzSaIFH_jVKTQHWfmNKBWlswr5cIeebfeMrBLITPnzOAjGnOeyi-y7K4wQv6okMWNDRVRBM4-ubLZGPZ3OFM8vrjd0SWYMRxT8oEW08WbBR4kWv05GHoPACsZzsPSrGkEc06EtghAyXJgf4ED_I760CZk8k7hZqtseieiyAk_aHUuTGk1qaAKh5tRjLepc5LA1BLsAU83SZQz4P02quefGQzT7HtzbSxOURaowm613BfdnYWN-1hdb4ZOmBXS6ovrrvhKAzmtSBkunkMG1JfE5t9z81WFoRm-3VmyyDw9SAfT66e33ZKPDrlCs8PrwyYchWwigw1-2MYWCVUqnomP1mXDgWQKcH3tOP18aaESllQvSR-1ZTdjG1rUqrGbN7Q-L7H1dOIvo9vf0nQvpZzc_EGdIvoEqMVulbmE45FsMAoXosu7qa5XIlXgfdUr0BLU9NkR1T1OCvazbNvI_S4Ldi1LXsOdcD2lq8ZQQJkaRBAVgkjaQ9x8UyABlfapFSI7sur37VBArFBa2JLcb8RTTzRrNwvSYIdzs6K8i8UJIWf6cTTF_DOI6QxhaqLw0uZKWJ5oe4uZdfbga5oEC3OGCKYYt2y94FsNZl39PEDuRFQV8fr3OvCrgueZKT_kIm9wpkG47DIryoiJUUzwTQKF-nwD8Ff7XwPpUxlthZyfDmrZIT0YG5u_THjDw9Qc7flfzSE8_wXySGw91r0Hf6Hczhrlarly8evtsnDWq5UhdiDB92UiFtaW6iyybFzN3Ud9Jd6u2fJ5kiYtds3I-G3-6KGhFOLomOT5jcK9I24N-skX3zDyJmlYiy8d0YyDkGKhB6TieUSaDmwlW59P7qVd-ZcFQDPJ8y4yljTtPt96Fp_scb1Cf5hnf5jRHyhHZYUnotDV6MprFw56d2e56lea2TNnSQ93ORs5knQ8I3AwJ6lT8SVm6Coo4nWa2C11sIlKxqnkTtJTSJq1j6z9gROLGbrps5mNYCJEau9rCjjwGsn8XvzgneLPT8TMowLNsKpuQ3_cXUlGqOKFsrGqR8Eu0Lm9F7iH0h1wf3M2jjYL5C9hVVSw3DX4DgVaTcsVZG3Je7PbDzuSinvEy4yM2Q-ot4nMaRonlddluRoPgD0AxulWjbavtvj8WAdTyx0BrPMRrdybzemhlFh-_11z5XMzlbxOpTOoRmiAbo88pj-ENlLXQmCw8r9kNpJt8WRXbSIGuSUBZh1j_qljLGuK5LkckRCAALtFlOUGSQmfvVq_1Lxh5r2hDN2umfdYH-XLGeJvnluuGoxxhaR2tuKNWI6Z07VB5iS9No0qrCng7tCW0m4oJA_UWAUrbV18-3XTeG9cf4ljGj_GM0-Kubl0D1ut4UGbPZgVg9Q0VBaJ23CqjWbRmxfPuuVeXno9YIdcN5sAJmUIkJFq9sd-K4ZaSC7GmEGmnBFnOIWJPWZWZBJuN-mwNigpH-SwJ9zaQhbcQ7jgUik8KfGRskk90LYokptnybdClnbgBwl_C73mZmNEE_NuQ.xONbg0_jPABtBTOAhzLW8alYKl5F7zR94ueC7m53WBY	\N	\N	Ps2p4lbWSy3imQJPtTr1FTpsNdz+JO1CpiJzymbxXvc=	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	4477ca2b62224c4ca0d29d10d2543380
3a1db96e-8fe6-f094-adfe-5be3c058d55f	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1db955-e21c-697d-db53-2a221a850fe3	2025-11-21 16:31:33	2025-11-21 16:36:33	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.FIjI1mLkCl6VNWAfx4q-SNz9UBwR9GP10i1fL0pZzNth38bUhex5caOOkle0Asr4B8lMlZpRwjh8MxaTMn2pCNlMgZWi5lcOPNmxAHpCo_YllapTi7UHFnAZxDmxaNwoSRnOJmVRKtBmShTksam4mjDXew4x7oYeQezXyg77sPT3h7m34S-9QbMSAhU3HlArkVVyPx64DGzw8gUKA4alxZdBX4MxJEaUGpkEfcBD7xP7AmQBd1l3K38FJDK4tulXKJVcKqP5ZOyV4tVRs4vNKV68lYiR48g2-cRlrcbyD-TyDulf5YBOlc9LNqSzMykMp18NFCX26zxJA4mFwHVuMg.D4ICltySsMWzOA8I9HKFeQ.fGzM4jxKZ-m9y2b0x5ArZ-0OAl9VpQ2OCK3rvu7ddYnksRxvkdjKluiwtQCyj49KTkyJhoON1XcCi1Z7g14ugxwsNjajPjo8KELoBDs8Ngfe-xf57b3bN7hK8HaIPQ-Uy-0T-kpbtVNW706BRP6UfmbtRO__OdR4b4u1sHjXtVkiCOFWBH29eEOfGvqmSbpT1xS7N1fXVfRK7efGHI5PFtPZFQQPtmOvGqnj-OgLKjxphz13VnykaV3ntuGWPJcL8ykIlDlSE8r1hFIFxxGEglhTrmTzL5VI-BiYaX6nFx3nVc3LU5Ic4mGaAmmHQGOQMvhN8In_ohpDUM11h0nmruFw1enwrqYbqiVQyaHYZuIl9vyAIs2-ehSxfXvqER6tm0I0ZgyMK0Krr1Tq9z2fjJOssUFfs2keQL6Z9oyA8ArQrpJXb9ROvlZ89s0XNb1PoE0ffhzi1WVR_rOxSX9n5YntiMh0rvUkzwoWpTXcM4ViyeGrNtbFxaUPdHoXrieUHBTLD0Yy6Vaj44DSCMieIaqNwYXmo5aLwUcWlb9Q1X4xLql_3QAscKz9pOD80INpgQIMOcOo_yutjolsomGEOUHk46rGw8YT9-7MIebzoJ3gukh55Gy063ceuhrYdES7h3oI5hIy-bt2XZMu69fh-Vxnnz_11NFQgqHex11iPmJBStwhQf0l0insj_hHwtCi3nFd4d2yZVpuz74Yb3Hd3Tng2lIHg53RCcOoeGqJ48xI4QT1cNdEO5cahYLMhsPrG1ZAb3uikPUALtpA820v8f94TWuEzqMluFfosz1OoM5WsWwmnLEeMxs5D6fKfj3LbzFCrxF64eahy57uVDuhWp1rcA76UnmIFh5rfzhhxqYmLgfQrQiqvKn3U2ceRwBdc1ptATJuLL7QjUZmLkeYtPw3_jVyRwGJzSJMq0S5b7kV91jTiLuAY9O011ypRbyEGAFJkpucoEjMNo6R10b4nJa51z7-yIkQFwwANOmdZlKrbqy1qLYXQQ3N6G7wXNrTQgDniZZ5HQiwgxZW_qSYRii7ME1oBZaZeJ8_EsgJFBOnOeg_L4-DwJDos2-rxf6c4YPVXZbaaSeEt2h6BmJOiZKYKkSitrBGsLh-I8F5HTajTcKLJMqWaAQKPsFsbqpgPRRW2PybF5kLXEjAw7QfO0b73Gdmz66EuloRsAuG0ICtvwGSNcepfpdj90sVzRICfsn2Sr_PpK1A7dmW1VU1tqRCQ6NKff9HgHeMU9O4_1Z8LJmCeLsVAUEOHCCRrOtp8CVqn862t9Jvn6R1qwFpmUpmCCzpwX7QwFXmk7rBjlvSXpZz7bz13IurQcKBDRqPiG4QMDXieTPxRmkwtcgaATZIQUecWDFcTxdFEeFEnMMYngcDvdeAZ3Ws3NvPGD6YoHKHrT6m90OsLlcgIdNMdZpJHZxU6sCUpT9qABmtN9x5SlZlgjr8BKtiJHIRXR0d4YFkLpYTsDMF19n1zhM32krfa2OhuS7kV-pH05uu5E1yBLjEhiHHDsfQpHJWPEieFAy9MLtKQKawmKBPhVZ6f9fCEDY_H8N7DBiThMoLOeIcmVCjYIBpme4qd08LY2q0sgQ0P4-Qj92lJhC7rusI4_GuDIZiroNHf4X9IWN3g37Gveq-6q_VSkb57BbDwZoOPaoIi4XW2i1QNYKH7vVAr3JLI-RYztW0YfZDXrob-cUAcrFX8hZqyTz9v4iZV9uh8XgoARkV37sv414AbYkAkjg4_shkugK320Ok8Yv2aOtuF5lf6QPz-2OB6pgwOWmLaLMzwyjY-B6kW4XuHBbQK4jV5b--6JH-biFOXnAkgHDDsZ7qltSPfbNc9-c4TAlT8gz5qo0gLWbXeUHgHHjl6xOUmTbcKpE3fGZJxT-Ew5CQ4eudq70MIgImFQjjr2tz0NMS_4j-WC8Db-K94KlLOACO4aKdN_7hegWaKlj3LtzgRSh8CFr-ks9lu4PDCFfX16rfDyr9kdaN19HEIVRC2zLf0VWiNxFobKaWy4pELFHYSHt0ih9o6D3NRyKcu8V8YHQVDFAkVtNrvRY0aAzqaCXbM6g9tyEiXuq0aNPp336-kZXQgTh2tHUzfbDDC-Sy1PgxtEe_VnEA9b6eyvIebq5DRpnUU0hsxvsZ9tvSwP3XdFDwv6tfePvnC2vet1oB6QtCvcwV1LATOcliwsiRxew_qup9ZBOyuRbDG4qMaf6gijX72s0t0vyebuVmY9zuohmKw0-bwYUxa8sbdhvQEWm7Q8StEwxsnFxD5z6Rz7nO8Wi7Xyjf_ETYzcZa03Tg05FLPMtBeDizZhVW3pptpkXt3Bv8AgMe4xtZ4kcMu84HjbMHeJae1-9TABcFd_CS9d1P1iI283h5G4lUVQWpX82qfcIwVSDJy1paBqGCtWl4rviUu88spHljJAHuKii49Zmn7NjaQ_ej1B8EjWD1_9Aia2_60tQEx1iYRQvsgAxDL5HB7lAxgRNUulXoaWXB3wJxSxJagsoLuTEjJ6RPyrFCcQEG4OvkTRa2l9AeiIQ.2fdbcl9Az0sWzLeqrN7Z9WFBWJqztdbgODoLbdrI650	\N	\N	fDFa6cTtRGpZOmAoj64PE80LD09wDD+DJYwQcd12r0s=	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	0a6a4501e5dc4c18bff5d7197d961443
3a1db96e-a4e3-2962-7644-ae4a8c15b896	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1db955-e21c-697d-db53-2a221a850fe3	2025-11-21 16:31:38	2025-11-21 16:36:38	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.KeNTl34emrntuz-BLIpN7wGxRdNPm_FcAJJGY1xcvd2O_XH1EFX5nEDk0i-Gma7jTYP5Hys9yp4ggRGUAMF44KrLYtYZF4kVNsXlNAq1AEUBbtySIHMkx1b8_u0onkfzL9IZX-Zl-lLBnsZnNj6QC3BJvB1pFl1r9zQ-0vpr_0jCRV288sZCGPblpaek3VVeKE_3kzIRhWGdx8KbYZ7xdlB5zCf_Eo9FhgOQlqzB2bgwDPyCWQj-3B_jTQURsuOLmh8afwc0svI1WbD8P0v2W1UcSLZ5zAbCdzhHgQ8V8vFEyRDePd3UxGAPJCCQMkceAmcaW4ch79xDfAWGcFXOKg.Yzsi0FObJ9-3QUfHeKgQ6Q.gWQo4XoSV_MvHFbnDTtv0xaVbi0C-kjFWfXmlmGESPbeN5178wn05FJ5GgoGeJyd_e-1jRWgqSenclAHYJv5d2FDBAdL1NJvuh6J46b8Hb2P4hRRrAjAKMLhi8LctT_dE9zKaz85Wu2zjZi4UUtZKluKe7ajNS2LYuoSY01VKgcVUBSf441ESBFxKHB4c2lTgywE8BfzWwoYYgGDHhNVApS91-ZfEUysHouQVy_zEF3w_Y_dc8WntwRmpkRT5BEXMEpAV3C9rJwLhXe1cyJJW_p-SeB-l2j0dcNpC1Mc1I8ofI_p-EGiXYlHe2FnAhKZrKHBk5y3ajw4_GCWxgxtD0x8Fdz8vDLBcI_1SJHDo3zzvt_2CFOAif7PNIWtyJArQ1xssIRtB4gcDfemyaZa9fZEpC3yGk-nhZFh80c9YiyWQ93GRsEG_NBdgEiCa1EdB2MUuZpJjLjLYrDIaD1RGaVT8yWUHagVhNKpeO7c9y3qVRKnNy1gUAmktiUIz2AejMWwT1HfU0NLbcWyTK2MT8-DFIzF9fF1BxmuvSIHG3q0C9cAsJ4jieyJb8a8xAdnHRzHZJXbans5KpATqq1dFZKCHVhe5fwhQZ7jAatb7sB7zX9GG8ZI09qT0-Bi_b7DnyCeD0LNXeaWzPZ-0GOF8OiGiNiJTU4edZdxz1ZGZr1U3YtHZv2jNMUUhQRmUkztwy5zm-pGsEu9eL_X1KbwCopWXFQQKct5WHKaqwaYJI7c7N58xSWdnxQucbJ5R6Dhv8V68a5Mj4wxkTVSCN7jDER1SXPFMeUTcZnXItz54nRRpYznUc8xd6EGv_P3UPdPJ5gu6MkRaOTXmxy4oXj3dxZVlWgUQPX80BiL0Z5dl-elS3yRyCWMUc_lkVUhdbQzOxbo0NY7X8coqZYFlqh03IbEyMC4RpQRcDE7cJ6rDkkkvU_aUQf3CUGd9D22D_DAaZq1Bpy4bka6jcf6VxnKaI5JFIcokA_57BXykBV52mGDpCdTcTEKoPHdxepf0AjX6c7eVLFOXQAOT7THNB-y4TJZPJW16SXcJ8IpaC0ejcIbUhILJhLnGqqTSPO8MOaVgVs3BqPdONVQdEEGkKWkOnHNA9Twz0vqBCWWJSa8r-gHzlh19kFBquUsfbLI4rUzblM-75QqqoaeX8nlYT1Vl34s1yWv1vLIzmB6RSlX-VeyYPoPJyRFG9bQHdbGpkESzImfhbmONihNRWJi6JanNoq18kaoKuNdpwAyYxDc5U06MptVttkwnBpocfA7NNDl7e2oapwL2dUPuPkW64f3tnFnK3Jk4ikc0M5uAJXHuY-UoD053iSiZycAV9nGxI2CMUI2EXkMqwfDV3z5fKGHpAX8JoPtfa5EyZuOiuaw0gYUUoaNgA9ojvIjCYOpG70kDPJpyVJJTMgymezpk57uOxAmPf8Ps98Ey-bJNU8pF90RFp4eaHm0fbrgs4ROcIkKGVmKBupdBO9eTiEgNwdd7gup8GyTgTbOKsYpt-t1U9QtqRiEA8sFsU06BI4Cy7uQvIiAM2E24Em4hRFspfREZGi4x5Ze8n9LaRHCBvB8CwJIg5xFH21DHQnhlAA0NxiXjXLJhhsBRGCEUc0vinwmKazrXfBYEKEXpWlBk5kA2ccJCvTqDtnZSnb7htBwqC2cM_UYkFyJTXIrfXuRRJi5XlOfgxijw1WicrIKI8Cnl3pugqUuZ3oR5hYwEeALFj3VxeWZharC6xlJ5ITVV5agW-c91tAWcP__R1gzxPvDad-FUacxnHQTZMFA5C2mDGpPSA2CkmJT1YAB--7wP6AuDrMkCuZreeEE0NRI6xLx2SqI8WDix36enVa_Kem-NGz2VypQkU3t2-D1ZRQ4f1tMXHgQ6lC1j3r3coR8_3c3uMmjj6nK0Tig1BoIxZk8x2s5fbgLqx7AarBn2eHSfGZNWy3yLh4aJLWk7uB4Rq8Z1YiM1VhSy0xAKdCKzixckwarCp2APZp9Yt-dGb499k68I3861c-Vo4mf5OSn9Uu8_HVVPHXOm7bxrK5llZ8H_FSCstiL1osRZh7lxGqbkd4Xr512-ULoTWMDPBMV8Ks45ndFgxOZcc3p_UbBdXJiNDHV_AbKPItau9JbDsgSHNYlEXMFBnuglxp7NwIs5gkqKjC-UndDFhxxucBT8DVOj_o7D5IeKDHxaWWytZlnvAoxdJl2TshCZdycwOHOUI0GEAaA5-u6kyIqEL3hCTGtyQREoHaj2v6Is81Ljn3N8fTwHdEIpWZ6QjCpulM52mWpxpYF7JjauRLtJnj-2mTXYFcubU3QN3YKSmmLONZyjU5Mvw4DtwFEIPfWk8zfbB0isVfYOhhh7dDEMF4py2v9QyYPjT6JPtQoi9u0u3VDaov0_xUlP2Oa-WEI4iXq31K_9nmTRQ95qg3D2yUEQjHF6VXj29QJeh-kIr9tllSCSI53FHUL1B6WlaZae046xhBbItUXdScJ8Lcy6c4VwvDUizQhvAvF4GJVLwuyXUEpZqyIooDSIwehOO-r3v0hoBfSKS0.VNbNLAU2O_po4QJ7PZIksE2mqyXIbUZj4u651YjNH9M	\N	\N	556DorftjlxvMKAmeZEUpYpRAOX/roPX46md+DOBs7w=	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	0068236e91d941beaffce7d4c57daacb
3a1db96e-d8d6-dff0-b143-4703ec19e29c	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1db955-e21c-697d-db53-2a221a850fe3	2025-11-21 16:31:52	2025-11-21 16:36:52	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.un20N86d0AFChJzCbEB8FhVtnozPOBvy4RRSm5YP963Cf1rpDzys4WVJ8wG6aggyiCA04YaDsxWAnkq3qmv0x2S9lxpb1OSlFDnBlgVvUuIQg7tJws9Z-oa02hF9YszINGvrQXg3rI7dhbCib-4LecCJbFJnEPwhy3YbIMvKnC22gbM0ZCT3QZPzZp68aLhUivWthSa_kBznSBxLUjWVEW7wLv_ZsYQ3liYsBnhm78JEhhFYh9sEFKfOePbfKlZ_EjCng87r7z3AYkC7AOSLCQWNtymCx57dYdQC2jNeSSnh3NBcINUFT2Z1r5qtEfSEjFifAGMAVyLZ1vgImy8wBg.3UdPySML7VkuSTZGglkLZg.OCQlmII0sa9ADsKkj_zwwwH72tkCzHGKFpL55LpAXLvXkEPOTlhWEgEAVGCnmOvY2haEZBheOxUrD45nsV40hJSLtEphHYYd8-DfF-VhKTq1WG5xsKHRAX_TZtpkVIVMakm5apQUnUh9UT7uvYAhlYUTlaqMpGubpjpcMkBRVoyN56Sw9jdD5B4UYqZ7217opfGU2yLNuATvSAi0DWfEtgfY0KmkWfX5OGZ-1RhcYQ84iqUUx_6YrL6aKaS0ZjK8aS46XrOrElAvR0bo57r52FA9n_-39WVyIKtp2FalOJthO3LCutzVTrZv7-EO74cBrs0t2Q70nhN6a_3tYB5pv0lRwozLwhXwmASRDh40pPUZVAG2OuT9wEcbLwsj371HlT-8-w6rf75nATBeGADdcInS2FOhFGeNP2EIA4EDnaKSiV0M6QqAYKzpCHlbL2ncOPDaXwr072H16EGEGgTSaDGAX0vEmA-B521dC4Y-IcA60dR2bEq-B9DUA34pDIr-56xXOid2l0W-07EXO0wk-PTgtw3I8Rqi6nBbOdls5Bdps2NqimVmO3_5JQcd9bfgNeEIWMoUmCbUd954qm6agKy8hVWhKoPiQ0KTf3NMZp-pEzBMQ3pyH1PcFpAkNmmDsNNuffljpcNtjKzoJzsDG0C42ut8zwxhBEmR6DckZ9b_kEtlQkrpJUjczBWvqZeC6E8n8AFtvskyQw-7b5DSe_wrLq7Yxuyig9tMSNZpdEDykhuaaYylHD9yK-lc_ZuBQZ-5h739Qfr0CFulAgfe2rbtnUpzw3jJNIXWsuemlmrDWBvTth1DBXQarFFI62tpD7jazhlXkTV_m70mvHP88EjvFLBDUEXM84DsvpBtnxeaqGri1oTq3eGQWVCpuFH9581TPinNxJQmux9t-MQpgvCyM3h3wrIqD8ZaaeYR5vLGFC55LN25oWFT0RJCWHOzWuh-46qrci7x_1rx1KTZx7JcqqCnsF1FkbUttXnfF2oD8dIzs-qS3iEShf7rn-phhJaLPZfYFdlFVZQ2TWHAYjWlttZgacnHifzYAtOSP44yTbui4FgxCggR6vfRmak3L-RkaX16m5R3uII-OsICZ4DORmpdTD3930dnRO-D4x8wGjv1sBjwgcUDRxe6A_UZV1KPZa_GNfXSa-8YmbjFWuQRi3iXdZG9OCUiYpX1QV1NMwewCUaN63Y_X8fG6zvMF041OeDkb4cqCk-eLSc8eIL8oUEOz23O7wjUVds5bgDx2x-8wfC2pa37vtlG5bRCNMFkVPFnLrQAN6G3qIDcJeugx9otJpPVUvyCd4iOjywNIUqo7ysaxdKxNHrVAbFxhNCZV_IhR6ye-nQuf_Mbh4fG4oWz2XTrNgY73jQBDRBuS5NDdaQo1A7QXXOOA3BSdbbSE7jzoYb0RIa6nhaanr6P6Syk_4l5Urzm6RNjDAXkvN4tqFuTqLX4YXmyY3qMM3dRrJFVNkla7asZRw9kcCwU7l0tE51a39goqsDO0DS4JaWBBi7DRt_dEWBFcl4GQn2D6pFdglLII4dPQE4kcJSq9AHT2wx7liXO35xo5cC8zVtUJejn1xTImzQ9nJ3yqIqNQYlB2UwlTaz2vAxhgrN_ftva9x5h2BO2dQOKzuMzaw9DKi2AK1egCINOxY06KifwSNgJeV65wEbXQFwR7sXG52s2Vr-qKvxtjShtmZlMBalZe0LINl8fry_uUq-xGmKU9hPXLxmfa1NQ3ioYYiC66zRDN0_VK12gkIOEJ4EXziA56uWBWn9z95LUbkbRzx2E__ADFddC-wfZOPcr5NPxv1sbMZo-jy0Dhgh0fAQn2eyn92Ek-MaQvLxlD7GlZ5vyS_xgvUXUylqed7BPavQo8LlRJDIZSaSYCKaWxjYQ0ybx-sEfyogk9OAGeqMRBK78gFpQBmVLYlapkaell_F50cBPPCp_ZbIuk0ORkdZvSd1FVTWltjp3CrRYsXvHJ5R8FFvL-YNo-uYZ8yce48fLEQaUlw5YKrFEA4Ebos9tCWhRgyMVCrMsr4rENOMw8iYsLk2bfQ2NQtZkkQJFaU-Ci4qMXs2EgUGguX162c7aH8HGdRun3QRxiiwzWCQfgCnhdVzQXSmdRnSW5lk6MeRf1XVlawbeFIo8HwcivYfqv7M4tNkhy7g8Nal6VsPbyWEyyb53aH-CwMDqsdCFQ4WcWbLEE1Xamp0F_tDdWTOD3MqVt4uH2hOvodoMeimhre5dAIOFxlCD9LuAMOFh08yW4rpmkQc7NAKLljaRpk8sk2RFicuSB4C-sHlavSvAk1LrOP0bfPxGXLS2kHylr61aBDXCq0VAjiZGPO_2on1bNO4EgkR9RtatQ8Xi_tv-m6RAONG4RDbj3D1LG6qERmQ8-92SgEiMPYN0rcpsIyMod_Qv2CH_3gwgDUYiwgPBNXJYty-Sfvjr5PhmvcTmQmaRHcmCflyBoEpvCf5hffLsy33Plgrt1o1iaCEscKiMkdF266x58RxyObkYauzP-5OXF157EQzJbjR7bVMMDMk.gyu67is4CAtRtlJ-D-TQc4wpXCqN39pfrnPSnePAsD0	\N	\N	xSZ/OpexPtobu8c9oCCnFTe86SqAEI1Bd2tyYuis2lg=	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	496c9a22031f4ed2991e34fec66de776
3a1db973-b76b-e979-3a5d-68908bf48b9d	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1db955-e21c-697d-db53-2a221a850fe3	2025-11-21 16:37:11	2025-11-21 16:42:11	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.vOAff-YzjzdInvhqow0ZE3GKE3T8B31DdkqAb4PH1yxLDwVp8tPEGxSKVgo81nMd9rewJbKVGUhd8GZsblJOY5EchrJndDiSZqkATGxj07Wtd71__0DqDHI83_ipKfkhv2KQgNtzd2GbVmOpX6G1Asue54Aavn_wWwgtFTvJhZHUPX0CjgK8R-8OPD9L_l55RJAFTTpnl-_0CxtWO4Tq3E1wW98HqnIKglb61ZPsWgBGx7WMYbWIvWRMIDiCawmT5wMoAfDoq4cW_ry49Syxha7JA9bDa002G6QS-qoPd24caX0z3dArrgKjmqh534NTQSGgxxMq_pXqTalYOgWQag.6QRbPdncSn38gs7Lwo_u8w.JIJWMPXg0kIau1KXIx0f8soVCHyTIxl2Q-FQstmyNTB9fD-D5lvykdMcJiec5sZHxTcuv1bQlctu5K5n9OrD9ChRukwR49VTbeSkGpX01REz6JOcOG7sNaJV1ahd8AmWtgMFRF_DWI-K5PBZ5iLrS5yHNF0ECe7fSebZ2Iz6ooEVW0wRY6eJXx_Fyjlp-rXvpfZesjrbRs3kJ06yj9O3WRevu4x_4DY0P_5ZY3a0S9Xm7rsd1Yi2MXBH3ufT5_a3q1AlvxI27g7TuHa933Pj0CQW3tHs69bHOrWEkSMDL7ZRmPQIq2chEpVHkyGea8e9Gv-ZdGZhKe9brulzAOk97VDmc8qmez9HXFi9yPFx_PECDL0fOvlapwYP65iMgXzKqjqUIj2pDevaEcWXTR8r3S4tH-CHLpygx6S9GnTS-v7PBzTgmDCFSNWSsRgCzNEhICgLNAX-Ca6QCxSPbJK7XQomIEJlnm7ke0hb6YQo3-5Sc9ZOsh9hGNbU-zMbrpqnuXoG2pMvo6QMGZFENlVpv2GqgIcIoGIItFvWYoZgrInpZeOhAVAbF0409EDhX_gy2Pben59N9MWnRCvDtWJS-pRg1ieerQVexj_4OBA1KTKHoAXNtP4NBO3QWpPfhIl7nEhPK_UWcFqhMaK9uwYShdyyPW2cZzobNo9vpkmDddMc2tghEs6kiHR_9dXs9ZTM5mIS9-SWm6NS4RD-qgbmGTDoCI5z1pspF2fulhB1RLV00lCYLpOD0_g8lsibgZr53-dBT0J1awMQKfJagNUtIjgkXsC9lUlyVQEVdcMjPU01bUi5Bwwm8ZKtcpydEzpXDqUf0kh7LVBU-nBeSIwnkvjB420715OGzXdoSWt6ddGr0cl7KeSJ8Og0J6vM2DH33_bCsq2RRrdOyMWbTYmIXkCTwCl68a6G7ION373hHG26lc5QFUc36J7bJPxZFeqKBoWh4d5hAs0w672MDvYpq7zCEkhrSmT2Me5lmZjh9m-LCNfsmh-4puITYwmt0zMPmr7B7e67jU28SnWz3SFV1g9OahUKMcLVMhY8lJgrtjMcwg3jq1UFMt_XBAN187Dbpbqpajh6Pos-08Stt66vp9OLNhRz1-oZWvp2eqb7d8HEfJQK_f-BC6Tu30P0bkVhYb8wksQvbZjWKaASb9T8sC6Rw3NjnBZGN1ehIvwvY60f_dFLSYOHC7xd32mzkwPC5xe4tGOSC-RhMacGuQmAVpeKZ2L6g5R3NATMJIsbVOWwfJQLT0EHKt1nK3wDiABOwHld02GIlTTs5FF0gP9mt3RblHxglDgjExBOtUE1gd6MvGSsXYTMooCLUPWObSx-WkGll_JRna0t23TbFEmMJAEuv2wDT2Ug7lc0TNiNwOkKFULJWJo93T34k2Lkb9q73KsmPplBTXxnSaMDa1Zk_0eiPT-DNJy4N7VzrRaSuqBWGQGrqVwmjPdpwA_eKhYlTr30NrcvZs1G74XkDMxG3w4aXo7p2fbI78uhJkwehMJBPl0UQoBJmXwAlygw74X71hLhUadTZiiZ35JOCm-kzrn0VjuzwybEiQkEbCSTQgqQQTOA-zkUGdE3lfPFUWylUvUJMt7STNhOE0HDFn0YY9SLfayrov0f1UT8ZBzyFH0iaciXcJ1IqMGhaUgtDmAEP45tF4vKcB7fKhI7g6e6Njw6Y7P6Iw70vkMeXkwXdT8iRCfMJtCXzkYDSc8cr5zSHx0ixzKcckx5iE9bPi_YVONNhteMGZ3Vgx0HlaudqrdFgVQ9QEG9DnsHRDlpiY3IWVZ9by59CrdsqMxWSeE0tLyDarWMZhMS_ANKYL_UjwMThqysdZKHNm7G1rDX-mRp2WmbmMnCozytcF7VN2xHxm773spKh03RlZ-eXwAi9xsxPvvEnS4YPiImjpPUZl6SpYPonQfxPOns8kXMO_JOlBTLShqQqFGKzS911saWT7ar-mbetkSJgesb5MFgHBkXV4oiTit3xH-4w2j9EhmzdY_L50VeQ8WHMCZPoG3fd1dneM1bzOwMsiuFx_HtzW-qLHweBIZJ6f_m0Pulv7KNKPkj4G9EfSYt2GsZVj0B5cv5Tf7CQbRtd6h1ykd7FumMIMcglHzMLbJRfZx-r0E73KJwBPn5_351oN8XUxzar9MnsuwkXNdoza37citpKRx3Q01taBh0aQnBFcgN3Te_vM9y1Bjteq22hFdDGVhcPXSlb0j8PidAjloqN4jsmlWRP5ud_1WOHVVGBZcAMQk8DPMUC3xaDqkvVMk_vaGRm79NZwlTr0Vakgx5Qkh6SzHLuc3_BpPfkwrkQu-d3Ah0BQEV6Agl9rg61nFstNDobHkYNPWakJ-ErNNJ_V6b0UJ1yPd2L49EGIcmxvH1AVAOIQ0eAXYKx6x6EClrySqQJJeW8cHvxA5nZ7KQXz5Dxtio4rtkaeF0oAHNfk73NDvqMmJ3GMkgc4MAoDDF10ypi7S2hUyUvYtAcN54Oe9V04qECs_zqFl8Q2cZUziM96IE2K9lxXGmmupE0D7LF2JGX7Q.rHPMLEgYNgA0ch78fMwQmQDWxK7ZP7DuYMdf0a01NlY	\N	\N	84voS+26/VL0oNYftUA1FzNQikEbz6KWLf8ucWIMiHY=	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	420ffbf99c9644528869ae6a1efe3995
3a1db974-2f3a-bd3d-38fa-b05dd0897d65	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1db955-e21c-697d-db53-2a221a850fe3	2025-11-21 16:37:41	2025-11-21 16:42:41	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.Qp_O94MGxFpFl6uT8j_0W3MY93biFhvS6VHSG5OikBzlOTWkWAh4w9HjTj6CsgPspNRCAlxwjXNUSSkoyKfdkhQC1tcVujr4Z7soGZzYGm9xiWzKcGLBd0-0JmW6BbJmTll5Me9lzATL-QqtvZaCf2MqrG0LRmd0hGhU2wv7lOG_gfnRY02yiTm-otetz7DXvm2Jj0NOHYyNqCrUASb9Kab1LKsaqPytJBe0O64g5AtC8IuXhB31q8KiH7Lavr3RqtmK879AKKZOOUvqeiNTjSyk3rSGZThGC1Lrx0ldEXbgFqtX-WSbQVeQvr_PAZ91FcLrGSYbtXN8BCxZRhl8ag.2QChQLjLD1yjfhOuJmuyLw.yoVP9oHAijCY1KtdUGlfWMsrhZroPEieew5Z4pCg_Ev65nvB7XOkg9FVbgNkcu7rSZ1kWnjQHaWoXkHdtNWYvZwiXGqlCgbeYqAHtl1RA7fCnyWIVtsGUIaR92y-6gPQxB6lqCiCuCZSlNaA3XasuXd_eNpnEy_FzgnVim1SSCCKqkiawhVhCSfn97V0E5wbbHQZD1PoHGC5dh9vU871JdVjMowbsgsGY8m4ARIfk2L5URoz8eVqJaSbEx1xk5zr-L5VY9fTGwg98W6uBGDRq5Qt_2rHat-gLNb4aB5QoYA2d4mTYcqpuwr_qjJS8AmfbKewBg8tZUxFTUv3QL_TIYdYWjpoLsxWML5wvjcLdDudjjjnJKK36sdQrXfVX_roJ3Do4XCVKPgn_S-l77loyfpzvp8zkTePO8BYr0iFeqUG6KjkRznfCbV_x8bEkiI9AsMF0D73GmC6jbRff0mAgRJsfET3ILLeCwgUMThlPzC5JTBwKFpeMP2JhmkAoC1wc6MsfIIDhn6mfljQU6OC5fRqcAY_xppcaoG3xJiVCi_QZUxVmYNXNw0ClTguPwBy_CnfeLxV8avW45JeCC8m6sfyP2NcsVONZY_x3dNmGFbgMk5EJckk4Uq5-XXdao1egXJUvVyw8NPVQ7uuG3RNVv9VEBFhqUJcW1EqTM9vpWg6tAIht5frBrobqJryP6dBkhef7tCPn3YAxTWN8hBvF9ISIo5NGPnMimm2k64ECgC3nbjeefpEhiu2LkSi5_u2Vpr3Oc8oosFyHHe3Sv8miLqCDALk5Qlh8L-tMeephTTNpwu5rM_XFWcunuZYB_gFA8sqkBqqpbKqI3d8myyjj9KGOz1a2ODLCSt-NRZha4etxPmu9ObYUirjIcnUXXCiLde5bOj1FVPqGR0jEqYI_zXvSo7nDYdN_xSpVOsvwxPbc75ssp95X5lBJ462AmviXcEkc3MNgsc3KGpId2S_iVSYTD0ZuMhXwZRxg_nWt5CTrZN9rDutnac66YS_4a6goZE-Q-Drj-MymAKFekLpWecUY3UGYl8Kc0_KN-GRhGJsqQMG24BBIXoHlGvkgB8VrR8lQ8YuOInMXHvyOnsipDfX_Vfs08KYVFEyBgvQKidSoSYwTCzhsrMBYP_USwyx2G_F5iwQLqjkp7vUj2HsdbQGB-0fclUdBbhBlUKcDErRfK5k-_dMpzAZv_5I54fXSWjZJY8HdrBSuG1UY7fi48_c2oiR2rN_LArSGR87IqKbFgUjpCI-0hk6r1QlXWJdzqMFU7kV-yM8BpzBWmYgXycMXnMlpVn1zk-cMf8gw5tZ5F8c6Cd0iuusJpMoHhmUy88Tkpn-oM5I8LF3AWdT1P-0-u1vbiuK4cGTnHLKz3qzBhv9_s2kq3e21XogPKPj5bbvfA-tR1jFpZqlDZ0_6sC3NO57ajIwCfhawjkJtCcgQazpC9QACnQ6x23qRmH6U67Q5TJ08vocf9Kh5VUhLLki5uMntfdymGMESN6w5W9myjH9wDLGE7boePoUsk95ddsVvcMqCG2IpbKz9psB2XjMWIw437dWwVF7t5AHns4kZsgS8FifUJXD5YgEDo2ifTl-GjjtHweQgLqQWOn_Q_860Fq2YDoJkzQus9mdUbU-wqf8n7AjFX2fzXvu6HR4byKMTz1d5jNGIAjhW5fuNXGyTM2lpfXqgz-IsLw7JldQEKsEG0hIZvEZQ_XW3RxBXAmFtIk6jJcyLhZ9lyQ0uM3yhKlUbe4ixCFnZY1pgvhSmVgPgdj9sV82KULavNDLrxdlpu4y5APczrSvx8awfBIur58KlXUnM8-VrtYSO70yDt5TPmJFytfkKQILyzvFzgduIktyJSkjrOyrSOsoYrNbRaegZ9HZsN6GhGG_IRUr3GCNzpV2kn2tVb6WpMmUo9gHtzEDvXRPP4LgXGSx5PDHRwZQDKwXl0m7xId_FYpAy3hgT2EVqspAesb8tJytSbfIiNsJKSXAUlagXO2we3qI64KgpFnS4O8dYLFRheej2OfKmnbOa-43SWk0DTPBSU9igRXYLoZuv5ztGdyz2SV2VM_VsS_wSjtlAc0dLWnshsS_jqkZaXS1OlHsH8n77R3ED5WfkodyHQVMFd3a_2dYTpTOJwO164yq_V6pkKXpuXckXJlA_9IlNleFu9PqYdnLOq9Oiz8_jcdqNuMzuJU6ps9m9ttr8cX7fmgzPuoqOOkQoMxlZ3GmoxU-TYJHj3c1vSpU6jSY2EqsacL28TfKhRRU0-MM89iblDjZDXlEZUpA9UDZcrYvJ0C3BVX9o15B_RMKoh9XFJ8iyY0zvM_mft3Yb3qIjSr5YBlLxAnxy54_-yhT5oYPqCL7Yfeqnw9fHgeR5RX9zXuFC6ZEcoPu1kvK1cVdxe-4-Gkmb6VQsPTF3fB-IrJ5Vb9iwuyhxi-WVpsENdaQesStNjmSOwHRF5rNhzY_3RWGvzeLx4FSXZzHBOw-gUbx8DZ9hghtlrc5GIZ3Sq55S35xInaTlH79NsIOvY4feNcxUqZ6Z30.L8l3aWCKavBze9pFBvQpx5cARPIyD1_qWtKhAqB3lR4	\N	\N	wZO1s01750lvtaNP348bG38D/401S3kDyTYRPXz0rQI=	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	d826671263e44684b5d2666af8f03650
3a1db974-8127-daa3-3ffc-74fed6f996de	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1db955-e21c-697d-db53-2a221a850fe3	2025-11-21 16:38:02	2025-11-21 16:43:02	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.VfU4-FBhJuaNwcNGd0uEmc2ifL7oBKNpnOnNf002PNCvStOi61UBPmXeM1XR-NzGZhE5jU4NnMwnOlhips1PRiPQxF6uo70-CbcwwohEAwOF1spe49fG_u6wYSbf0ZJomGVrOLjpkkuAycG-fwr0QQJpCkczrJETJJjcrX-TmwKXyQ2xqrxEgxiZVTxE7VUycyO_8ksnPu7_Am3mxfVUQmDbRgVsePfHU32Ujf9rUUJ1i95fM6a08EoqK8A-OmrUyA3eQMRnNXuJ5TMjaNBlLclOOEL0uzVLJbN9_xaf_a_FeZ_bPy2ShPGSsFeumRs7PIjntdUUZvuClszncNjljA.cfZ40CDvplbCP6Ns3LQg8w.g2BCD7NCaygDivun_b-splrOQdHvZN5kYoxhgSCQZaVfK45u-4YHoIs51n3oRtnrC0N4KaT2dQdaC6pCqxgxcZHzw47A32D8M4LsDTs_xLgrj9wi27IpQrVDXS1zku9QNDNiaRC-Z9R4mIyZyz1FJpLPXxLbeQqmMBdzr9XhbUvJ1O1SzqCqk_Htj49S4PqgFjvrxfoKa4trVVW81D4ZL4s8--NBBaSfYIfFOKgwD3mEUgsaGpSZUIusnGSrsaA6yyEb5G9htkuDGoo2YdZyoU3Bd7Xv-F2ygVgfkOyGtuMgAYKiNHhRASkE0kM09jBriHD8lBOAmkSDuAkdaGTAyUZy6UxC45rsvs4RWvzjsH_LdBcADZW05UlqoSPAwrInUNneNbjFXcjGsIKWNrFD9QsQCrxOpmWpSSRajt_Q5JQfvD46GLDefWwDu1-7fs40rPid-Ktti_FJHS5y1n7ncylcOqE2ELi6WTkbPDVeWfhQaTHJL94XCTnPz3eF6cyBol6QH5Z8GxlLPL-6djZM_Lxm4osG5Z3LoDf3nqLSi0GDvoqK6S71_sC7dY31csc7O2UhyVoVMAUC653gbPchYrJxn4ewdA2Cf7vNynXwHjzW5aiR_7ozU4hNy34qD8EigQQKpw2EgzwInKgLGFaiQOHjVsm9qA_g1qpJZDkCZvktveKwgxJWbuezMwyCeV_mST6ceQX_0VJjhItz5BHytTOld_p7QAJyhInlfJ0stdKZ_SSZlL_FC6l8rdTV1qv7hC9x8nqGVJg6rW-TWo9hgBFr31iYpBJvqguP_zEekIv-QcAVuIxoJB0cd81PbNc6qr5vlGXAL-aQSvIkrUdZvk4GGZyvfXIXZhYhOhBFUK4Hv3DH-fhs47rGKM6tRaL32AvL0zc9tWOUz_33l5J6LyGdUaX1QQ4M1K-DcxbklwFEPs-PUulWzXTdWoressx9jzzL8KUSW17Pt6NTzgQ4JgKphQeZk_xDN8Z2fCBgf8VUyOoXX2cMRbW6B5s3fH584MMYrbZxlWN1fGnegnQ40SKh9SQdFq7MiAj_jKLFRwAEdZZzv9TJtRGZ1hoUKZ3CdCiz50GOV7zrqbHZ74AM5Qse7Jabnfa3t1gPrsNOct9wlx3pMxXAILOuyfJKJBmosP3_0Cm39fe9hVYwNGVGsmgiZTvaizg0veaUggUXWMHyO9xmARSDKpkm1GTdyhjKOeWBjhW7JiETs_QVPV_EtbmylfQ7EJP3N4ddnRE9hi8yg5xZzzia1jwdEeADTau0djCXQ6lBC3_smutex9ZDi6JeoYC-8WZBAs9VA2RLhW20fq8DAJIRZCmhFqqjSPVsj7muejE6ZiPzjDz9J9MNQRrdLofaKwkcJs7qoWc04kW1JfmG9-YZuf2-LgYAZNcVO3i8NiKbwLzdwzYIYKJdAUja-YZQi9-TR2XnLJl7U0bL9Kr6HF2nz9HwfG6Os7km7ez98VuKaYOsbnZEPrWTZlfKrf910nDHO0ZfGifn_Zt7H0wPZZLmMCwxYsLvYXfhS5jmdyP5SNGlu-jqfBov8aR7rzX0kCXNFbj9ecRVl6ALk_Pgd4xsy782-p5HQ5kavQqySYzwKPu59yVMAzeVGdAClOD7iNB0ONizSor8qnK2WtxIZaCouBrxrBXitnhJx2yi1HGJ5Q4GzC7yTBDjxb1dhgwGhzM146Da4AHLrXTay0nfRf-6Y8U5LDyPmruBjYWenGrKgpvZrck2GKnjWuJ66AKMjbjV_Z8kdEP5RA0qDk2_MmNpeFCbkbj9dcgEa3clrFE24veOHr-jt-uEisaLFCl3kqgNQNpE3UntCtKDL1Xp7tEnrsg6Bn5O2e88OHsOQmcpqLAzB4j0DF9-6vdypseiWJqfzBSBSW-96NSq9ci3uYBhEa5y3RVaJ0yi7dhK59cqI3DGKtTGt2A2zJm5J_vnkCxiDT4p64mwA2a5aIAupz0svlCJXjMaKoooRa1zgihXzZUawI14WE1ub1utIQFh9KaTWBBvxcscS05qFIoqfDNt3bB1IurruJvFtkZitG7lt5UC20tfHWvHeCwyx6gzLKg0mluvp-sIxenWGs3n7V_SWNnSeXJIKUKDvNv5VH13DzSpAz8SDedihHhyFZiZhQ2KSXCS5060A9UDjdACZZoqiXIoKNqN07iZctkf_FGd0wkGR2ZJuQl43QZwetguN_WXc0gka_lZ82JvrljJ5qZ7r4PSpoYSupc-8gwOhKAOX2GTjbejFsJ5mEPpPv-_wyXcczY7K90B32MhVNoWEVY3r8ajDUx88yMOHGSKvJlVUj6rqXGvxCpqGQjf3sMMRSPwhip0xcSAj_X1juygD4cblYCwMOwW8BTi_tjZEDkYr0rVo8sqi6KAmyuyLu1T5rdX25nHIyW-D_ucEnyjF2CXXg4NGYA1SRevPkxiRUzv6pQjltCoY9fo_iK7LiGtKys4gf3vxDE_vmuZKAmQYBeN8x-Om8f3GMCDEfqi2RTtaA2ctdvSTabcXUS5ORDPjz64-ogYLy2G5qA.pvqQiIym6OB7Nf1U2vb8lDv8cm91ysgalJncPCSmR1w	\N	\N	/mKhdK3SB8easEw+uNKwqgR7sBMMAVpg52IRWiD0p7w=	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	bbdc0c5ef5bb447ab647898eadfb6f4a
3a1db974-8f08-b671-a0d1-00112476a33c	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1db955-e21c-697d-db53-2a221a850fe3	2025-11-21 16:38:06	2025-11-21 16:43:06	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.PMRb9gfkQOOIUVssbaYsL0bzMlXyeHpSZXPjaM5toBhvuFrwgjcYCZ4je7Igj-wUJfaTaoRREwwmbZX0zspgW6xcx8RDx8bjRQKQT_-fb5iowI1K2BBwBviav3vUbVmQrXez_Gvsg3yKs70hVV0toAqpXbC7309A4uQTb9RBQkMM9bpbzr0BNn3fuf74X680bcsihewcvOpEbAId3CCV_hxCbrjUFU9p7iOD18mduPBYLbafqrB5p4A94bC9obIfuSTu_kA6UeIs_F-ljB3nJ5JaFiaHw5Q0CSSEn07WOK2zvf__GAH48nI1I7azK2fBl5Kq8xvs5qx7uIw5AVi-Wg.zW5ezC7P1yzF23yoeolTtw.RkJWZoMdC3UNIJraZwNfC632EWTm6VkV6adOoukyVfZ5VsZxsUqH1T3ronLq3aFLFbuL_YSploD7oMWOpFyA5_wnJ9Jw3rAX1w9dHmGid22ZW6MVb0zKMYltQ7tKeReuUaYPiorfTt6pB9dXzbXDMLGI7-orCAhV0C5eQ4SHU21r2AKOZbI-E2gvOFmgOMnC3KOXQgw5rpPTjs8t3GHiGFm-4rXNgeiCz0uhqWaSOgCI0pL9xn33juiw2fPAEw6mSZbPDeK80TFZk431M_n-PJ2NLg5kN6DDCUUNbWHVC1MgSPPFbnGji6XOB7Z07QiS5Q4WTiKAA8v1Q7Obk_5EAQUotnJ4sBVL955cPvhbsvIhnttt1kqeTC08wvYvRdwYLKNqy_XFkQjW8imnOS0FN6Sj_dfmjHCgLGmZ-roK4F4RX75KE9QbSDWsNRqKBUwQPst2VzWmptl3umtE5PHIJUZtksF7ZEkuHFZGnl7T3Nzi55GuphacvY2sPuY8lPzhtCGX-aJa7eiFpppRi6Px0EpgpOXzr85nSqOiy0iSmkZIBjUaKv4I1ogA60U3QFxXssgDBos9VFzjmMt1jK2oW-UQ0DKVNCByB79qzFKhD7IfE83_UefHJB_V016WhHnsV2f5aFTjiga5iLP9NRqIUunAj1Fm4mQhHsSTTZ80XM9c8PqbE3_Ohgbmm4pW1FDJIV6aU419jrfmpht4-08HqahhGmKu0wQqBLOeONlvXgbPcJrQ4uIavTiNCFFj34FDHfx0_4-jEPbkzceyUKkPp842H2dQpIW6PQmvJbXaHkHxc___pP4TLN0vAY_dpS4SbOIlxFUGIATlkQBz5xhO8QDwtluLS8-w-wOP0cCNvBj6IktjJApR1O1aWXMgcDDkMOeHbdeS8YxDNNF1saUDgbnue8toCq7xqM8hHJ7k8184O6IINU8oMW0jj3GWSOXvvK1Q-ueEH-LF8tqBqG8cRlJiEz2OaHcWmN0jWX2l4Te21LiXhzjyvat9dld6nUAmMRo9d27hl6vytifTDN1D05V9SEuer247QDxJSORhkNWARvC6SdB1DbtssFw4JzIRZWshmyjtG29YIt2qFovWX-fMjr1G3EhPF50DE4UtTf65LbvBz5hd3BT8-I7SX7a4nCqN7zsMtu6Vpq7pUILoKAfckFGgTvmmNJ8hl_crx9i8YvtiAiTuvGRp68MkPAhamcBJG_jVpBeezzXoSRQ7rGgdwXCFYT3D8Wgmi6zEYlaZ9f70mgDs6f2KbpMnBc1iMVZa-_XgdQMJ683M5SS_I4RFBDpfBJInkIYcV60iU7x5t-DLfosUoA776nJKrDzftcnHNej3-QneXOScUBk46nRnpXop4SUu58Ba6mTrN-FWVGPQpOYzAOI3PYW7rgoh0c6oWCwlG7re9rd8Jczb5HIUQ-Nbz5qW8tEwzCKWyclAV8jRwy06pfsIbshQWNCl1nPGn-r7_iuDKa_A9hvkv3VINpJENAUrhd46VbuMHM1QOC5qpu2yxccGKjIijChD1HbqeoHYbOlT8ZxBLivJ5GPoqOlC6jLICqtzBv-JW9YheARuRJuiGK6gqUfdHMtQEJVN5zxarlSulkVeStDoc5PJEGJjgkhjmL1Bz1TWHCrbY-sUjP4FJZLKSMVOYD7JluhrIB3oDJWT-fQBrzQ3OWT1SOc6ZhfkMP-Nd3MVS1NjSnmmwD-lyh2nLOKwyf6HCYey17xLEjwbg_EXCkQDdvs8Nm3yVM-S6L2QZVeq-W3cy3Vh832iWBy4rtl9Uh4Ea6LNxVaJtsX1RbD7zk0aCx9_KWXspnqgX9XrBFjplkP4TwI8Xnl9Dl_LH8OhQDMZQ1hHndoMnSg7kcMLqWrhRtTwQrGin5tXfuquhGGr8szhLHsixfMcLRadtijWZCUOMyvCVq4pXyEXEGMOJssUef4K-IfPXjVbTPRBMwndOotdSck7dZXSlYtV9dwF2m5qqV0ELqlvu_IBjrUwTp1UrQa3OL7TY2xzQF97giFKo9ZAE95ZbRA6dNyFloaqVaVI0Y5CHRvsmP37QFzIHf7UWPwn24qn7-gaQq6kt73cFFrFfxRrPcg5ik_fX7ys6qEHZ0Aejn9P0rrXlZS0osHltQLuuUYgf4EX21n4T4-vMCZ5PpyI_Jzn5uBCdDZ1owCMxIo4bcmDQQ_Zsz2aaw7naHKe-tFS45LPWBLs5Lulv3bTYZLwsvC-z3bNF-VuMDG-1mGNPlmVI2x4X7fVfZ6krOIpaiA0BRFhtLS2ioe9fMBfDrjoBf_N3VH_oeblgvGjK-mI2ICReVGn4WGjBFxda9gldVLJQJ51MAD51PoSO0a0NQ8WVCdnGQAXPorOpin4J0kglI7X8n6TbL0RRv2VC7Iyf_wWyb2xmGzayIRmymA2Hcg6prA0Hz3j3eq3-6M3RupwHUpyp7DKJePve4pl7YEw5LIHlVWpJX3AgUS-YxsPUIzynAxrilN30VN6im8f5TmiEaCQkHtb-16aSOQpwB9uqedY_aHvHUa6812jG-4.7h0uYLxDnU1t2xuVD0BBrktea7x-WI-XFbsGwp7k1Mk	\N	\N	9k51Aybj9zoQijtVRn/0ZbwedI7Glt66Jaj0TgyBKh4=	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	e80494f2fedd4c3caebac639ad3befba
3a1db979-1c96-e170-bee0-f35c2b16b647	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1db955-e21c-697d-db53-2a221a850fe3	2025-11-21 16:43:04	2025-11-21 16:48:04	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.Ur-3mp7NMSSHQsy4S831LkVTkMXsvu-WPIlX1YtAsX2LUO32UKMikxEYVOneIS2d99kN-nFTbU-hgBkqOv0YEom57kIji2yQeQjMssP61HAXUJMIoQp5VnZn56tO4DdQeQ4lOwqsTQcM0_oy6oUOlpsxwSeaPI2czUG84NKkhoUz1POCpHeRVUue5EIDwWhHJrUE6IV6Vd9v-932CAL6oaJSRiYg14FFC8nBo0e_JlfyVH1IDrmInb1gSAxqtuC2BOLFr3zAr5AtbDVRR_KWsGwzosIY83ZDxxSI46co2ofSVbFA8CBkkYWEZxBSQtoSG0euA8MGWUP57GL1RU-qkw.iG-EXPUHOi2xxwtFJZ4h3Q.7M9Deh-pLEJxiHfvYcocX7YyO5J2iFwEOW2UXr-2yRB96x1oGixh1tHdq-SS56ER3K602GtuJal-wXuVc5iD7WsX-47mLatWaf8eS6dXiZpjSVUkVWxwURplPeRQTkL0p1uk79hRRmOykZk7D0DdMsWFeGSt4oBOMY06wzQVp3YFtTyyUxb-K5CeNgUk9AcE8Rt7GEBgjblYmPFRnXUN3OsPh-DuAvAdXnBimP_H6PNxYK_5s1k8wH_c654U2xpivhPSfR9sdQGiuK73_pxLZZPBMv7QpxxPCouBSkBM33xCY2cWeLGcVFqQiYc8V_nOmmgkVxdp3QVhP6Wh1UsOeFUTGhIjegrGMJVDjHb8y7Qjxr6gS8KnXJgD4XXGGD0wyTSoS1f51rX-a8Wpx61cb1a7pzf3lDr7DWnDOz1u6GUPP71AE_EKg_fDloOrU0jNY3SIWI8G_JDitu5--ag21blo3is4GLgRAlrVAKarmyP20XLh-63eZhFhrLOCu5aRIJL1lR08T47vHnSO4uNr75BJY0_7F3pNJHR7PLB7JV1LY0sCC_WLsVAmde1VODWqudDkW9Yk7NM0TgwyQqtbste3PWAsoEA4YnL8TDldzaWdGRjKayyTIXZFYs2iJm5uHwYU0D7F1R0CDYRaGPcKivJniy6RWdcGoloAnh8LN7XBQGggUsBZ1rKVo6_mDOhXzMgaOQh6kjOUng_aKfvBtDRU9I-NIHYEqnFVkXsFdUJiGfry5zGEA7IOMigqtCzvnj6ryiDcnBeMyfyue_ywNVjeikaSVX3BwHF0Ir-0qGFEg6uCuiagUp5Z82F6HSzCHpuKM2SCecPtyMqSXIWBXoqG3BbO_Ph6eKBhUuAhB61guBioe0enMxQ2OO08N4o9tiX5Yelz1FpmqBzIJSGnqAZKv588JxKRvaSHoJ2rZ9TmEmcya4dqYUl-B21LlTVtFxWfNQB1nhoV76I_v6mrJY9pCilFl-2umltad4nDwnoeTGhYyoNXGyNsRCC40Gyc4L2rKxN3qYDUS0LL42OWrPKBYM2nf5YXiYPcPhA-DB_G_miueyPR3LClgDZAQ6wrqR3Bfmlix_zARhkSwKuAF4uUD3BL54eZumRS8fubI7cv8yXKxdLNRTPPyQylTYVSbcz0OCsK7oFFmiH7Gs1XAuMmfHMNPUNXvubZPAJAxqp1mCsrLrh5j5mZNeBmLxCUWcY_5brtm3rftVvsNzdpUYNik-Y0Vi2McW9JWfEd9THGbX54HJ8x9sjVZW4kmOA8iMraxnwXUFmwS9Kxk_8NEpHAxvZKACTaN-E5ym_hklxTYEgnphvj-Q-0Y7B_YCoSKFfs1TLpQcVLDnLGNXuRa6PLEgfVJ8eqIul7hDilpFz_4TVhlGERGfWgH_P7Ce2x_uwx0npCouxuGPCIs-gHAk7NrSwvyOT4lyuNsD1Qh6HhLMP1MQc2-tJicfsaFN6V5xToFQXmvzoqqgZiXM6Hgf9DpQ2-DUocyjmbnNwxeh9rgYUICh6x6mT-YOQKFGES54xdwXzHUTxI-HF26qRFZakEEH4wV_tfATg3Ju7E-iKvNYvUWwX9EcGlLJDnYx4MVWydUh9V28Rl3dSfoBSFzA9HyKjZbw2-KsSTgDijGXr5qSyo9P6a2W_CmzoA03CEN7-cl7llavFnNlOPJu-kIc_O7ZSMWqGvsXKeh3PvQITQIu42zYd-F9MAhKG_-0HLIDW5uwlU5nE7aNytFXzc3wCTtytv8enmlsRjFEN-xyb258gMg0tOrtrjprsMq8wdb7eAmCjtumJ6zXKfbpK7Y-uezR4G1nP5Nt7YyH27XBJvBlkQGdGXRDBhzDUPWZlA1kcLwwFoSGNJ8EM8DylGedANEpgtl135g4hAFfdTKa7vgJ3LO_4rb0mogUzPFzNNU1cnh6PHHR_UEN6HOT2WUb23PGPbsUQHFfeDNm5neQ2ZnVUcrkDh2JbSicrI23KCzd_Aw2GKZwRdVxZ4g9Zi9devPUlRB8Pp1vDngXsHw22vjPFTbNPnpywp3CuQAGjge5YgPkm8XbZBhiHMs9PYa0GRGZF9NtmCJup5EbbbISA7d8U1K7diJlTMNDzxrh5gSdnn-z9-EDhM9roCgEsTOpCEAwYBhdc1AQR1LMu3ynJcaEErVqICpj4SKhMfRDUgc83HphG2hdJ7wMzJ_9yDIyRiy6qGLDTDiLsy1cXAE1OU2qK6XnRf7rkm91UGz7uL4Sye_mlqM4xUEqmgObSieUsfuaJNWOA3p2DXgtAxk8xGisaqiAD3M9Fx7ZMmFb3QKdht-DCYypOPlG4tjzxmjdeW71Gvme-RlntmIGuwFp1bGuAtbpuHl7g0WhLtiJHSooPN3hHeaG2HI_V-AZrDPd2NG2xFQBa8GL3X4I3aI7h8Mm7t_pkkbNkpHQm_LikheSIjc7L545Elw7-k1iyOC2dfHxnJJPZs00XF737huztZyDqLZbLnr4xtbRwA9qVRoapdpaWJrzgTWiAUE_phAxdDoWTdeWI6eRO-zSqyLQc.ZL_gP7w4FS1cPZiJgp6_9lB03SLqHe_QHNhgBlQz5V0	\N	\N	grcfFm1liii4DOUI4lDj6ZqMD/rr51ddWVo/lR+QgYw=	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	dd770550ff3a40058509395ea2955bc9
3a1db97a-7756-d533-3453-d66c7cd7dc12	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1db955-e21c-697d-db53-2a221a850fe3	2025-11-21 16:44:33	2025-11-21 16:49:33	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.JkwrZqfFGGjb6Yphxokrrrt0DaNbDUnvw3Q8BhmYWqmp59NH4wPSjSm4641-SSlqaiLMZW5nDMfgcRrOVxtaCqSZs6P9sX0z0OrSbiRGjPznhluNWX8sHquHVpLJFiE1RG9i12aJLhEFYO9jmZjISd8UmxYq-UrL_hqHSDgcGhtIG6V1XiDNa8p0l4WNfN-5mPcIMiHket-VgZ0-pl_YEWbYCyA9ugymc-3jxZaOYnNPXsFrqFvEM_k7kisJHn8XnlPajPLiung8S9Z0ZTjPBVsw0P7Hd4usi8ImObP5CNjnliYMpYllgDgWikVUUv3mc0ZZ2x7zBMUMf0_pCxMVtA.BvQpTQwRdyztEWIoHOkpMg.4FQ_-Y2vlP8VJtK_2xEGD9ytblHTRdmYJS7ogtWvHqYJsPVEbQSoVnXI5AQi9JiYqhb_M7_875b0bGykiaJkdLIdXLINQcwFHFTS1LypNvgoLTXPNEPOctf70rIluIsTd04WylRib-LlnxQU1VB6pevnxQmUsxGyizHVL56YwV5ZwESdfYbDZVrhCcsON49H-c5p0a3ccokFrCAD0ruXB4-LLrkJjUAUAk2zl7oMs8_xupxheTmUVyAuaG0-aco3Im_WJ0PrTKd8FlXtQ-Rv_KwgzeC6QX_PejP-lJJYiPpNgdeC__gyrCEw3YUymdj3gvWBLKr6D4T0u-hXG7a0ry_i4TuSSOSR0u6raNKTZ-BKUpftm9oUXCKhMjol6xgYNBH_Tl3AN4yrGV_9r-CDGLlxbLCuU8OLN9hiNIwTvZJ26NGUGOPVTT3veu0wU5DHmHoXhXdKFCCmRhoJbo4M9MlUqosMzC5eSSRAMZdHkT5V7_BLcjzubJdCeG9EvIo2k6G4ZG11sZY-3_rk9JQVTULtbzQUBNC0xoQ4GFhOP4nJ1XVu43Drivx9f2EFnjo1Cr1dLpQlsWBY0E9_An7j2K5Q0H2D-aAssZwaMGrerNhUxHvK7FDKzCS4-ad2JifC1ykQFdbgYXencRVv8pa3_3InebLHQEt6g-8g5BFezMWuBZ0FE5VSOqhU0Mxu-dnqkJocgmw3EnUEKZ6jBtvf_t-vv_LL1rKxBmdeB-mNp55VQCJWkAsO5deGqhb2MvU-icDmOHEM_in7dwcaErmtaKkUUooKKlN0I6_-4nPWMJJUyzSio4bZsvJiQA3_LZR9ARCG3RRn0x70MNu0iW42f7-E21wpXeaX__OPP_nNNR5UNzOUyW4ClmfL7oVDE3olD4IyMdqQ4KsMaXk0kkFGlL833WUiJmTm0VYjlK6keNFHRdF1FaaKmEElwv4J8LHmNCx2wj7nvGbGT-0IzqknCq4v9TBslPGhUMs4M0ch5GUUP0HdcY7dk9K7QJZby-TCg1lPTudtV-Ylw40qiGlZl8pdvoczzvO2NsNNFhG6xV4q-9HIVuID8O52IsnPicAFbDteQLRHtgGKzmIoGBOYfHw3zjJ0WmefmVuXqY_uiKNx5UjlIQDjOSOUpY_UwXtr-a7TkxVNDX6-tyVSd0MlYuzOZV7PX_7LzMqX-pgxtrZh4R8Ob47Ei_9GGFiLgNPE05xZ9tAynWZoftnWsBkxLNzaMYT6-FrvomUV2r0O1qDVM1qVSJ_BIWe5Q2yfg3cq8nkjApnGkDikae-P8FUecGe5iBnhCjxw9dCjZ-YrZBx3ZqjT_t6yxyLSBwwHBeAhAnUvrtJtBS3r4-m3P1FW_N7ven_6SxG0G6YGceL2C7Ddv10_lkgwCzRvUv-ESOvxKgZo7TspbT2NgIvQVtCkGpLjia-UMoP7f8kwyAsLgwOuJJkPnYx81oDK9mHTkZm4OY_OE4iz76MvhQYuDpZxW_DfhUi35PziNI73GQaN1aBOoSYkmvQZ4RtdKwkPyNyAI4kQv95r9r1NwEX-l4i5oA-jl6x5EHNMFZhP3rvh6dwx1VQmv9j9EF4NL_ohO5WruOPDiJiHHchgogQb4ofNGxaBAgow67OITG6C5cU78woNx9ggSaqsW9c2I3AhU7wpi8oBD5udh2ptfyFa__I3mIssBu87KuSlAKtYMUg4LNVYmFeNlQXjxWiRRbuU52CNHJgQIswc2w8j224UN6umbWju2J_6MplbCxFyxxnpDQZqOjof2bQ4Y9hoSK1RrqNy8VRC5sDndlkV6-BvmrQ49fbBqsU9K7Egp3tN5jEKcaj7oUFmhhpX9ZOqSIdGhNOV4BL1NFABhh5C1ZjH7MLiNcQsSw7-rvN-Eag2huFZsmK9ua-0lx6EyS29wpv0W248N2wL4SzSsQyNeIRo_SW825mKJwj3jECzjEWzo-c4M9kx1It32njMrq7AVCjueMc4sTOi_eiIXlxX4Ya8LrD-XgyRP6dqXUsnQzPKeEmDYnm7AoVSD1zPXUWqHR5rxiuZpvb9_zPXRfYlHFhjnU1JWPQ-ccQcA3I53JGIOUO3AaW6dQImDNQ7SFgKw7Gds73Lx-Nv0BYT-zFO-CYbdDNyOgGS2c3sNXGw2gZmBWKAQvPZXgQ6H-RuRO3ozrBgPsx2xYla_qaKcc6y6rQh8wS011NzHMdGllAGkYm27N3VI8MLQj5mZpW9gw-si7BbqmXrp5dX3LaySOxPyqp-XataXxe67_VrTav5bMmi3nA8HQWcOe_RQ_HZoKSDyVl5kWBP7DRQeHKeJbkKzsbRxH44-26IlZJvFXa4838Hq0UNPuDTGJhCDstmQzOSBWcT8QFv.tfpr3RSmYiiXt6NALLyJsXPiE7kESEUtzzyct5sS0p4	\N	\N	cOFaUk4XtqS1jZrej+POsewhmhhWhsd4BNC65cs/NCw=	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	02e86d410fca448fb1658ce4ac33a96c
3a1db97a-81a0-266f-078e-92e5b1987bc8	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1db955-e21c-697d-db53-2a221a850fe3	2025-11-21 16:44:36	2025-11-21 16:49:36	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.juWQi88vhgycky2KjsQUvA3iK2lwbR5nNCdP2c6i4rZWlOqYlkhrPAYXUeK8O8PureucPrW_IOl267OW1RUeJirNqAPmA19SkU-9NHc6bEInzMA7X6C3Do_j-ZDcsVziALziFbLMH_HJ_LFwGiDSTLusFrp9m7ueHoINpBcB4y-_PSbknoLYJ1D81Tl7OcsIwCALweyF87A13X4k5BBldlDBa3qSuwEKk6bYZoE3_s0CRxXcHqDf3EpJmu6sI7-LDJal5fb0A3EEOhTAxXBU0fUdyZ1gVEyrXM8uvCWDzJEj5a4HIIp_-AK7gZv1Nt18WcAUPZVj9edFoOvyb_62Bw.SBUDT9q8lEvGn1F0xixSuQ.u0k6TchHf0ToZ1Bc2n_EoZZLilBrsFt73ZkWECQBFGGX1F3BHaNIzN5cPQohPU9CsHprAxK5DTIqMJ3oL-D113JzqvRW-1aoSWUJevpR5PHmAT5E9ZsrDxZhg84WoHMhnEw61lXOMkDIxGFsOl60fMu4ZRs-G1T2Cg0E80Vmj7GEJv9JQSB4yfQTIBLZzxQq10fCh5t3G7xTBy4NikvGGzYy4RVqrDBuyck7TCP1WkMpgUPyO2zozXVBnWCKMq3ECIztpE46Nl0iDfiQkOijxdveL8mYU1LhFDMKpeuotcnZ04-ybLBoF4QOU29AiGDVNn4z57Al5q1spOUERdjzvqkxWsA6vAYHliBsU_VB3IAw1SBEsoFe5WxG76ZIL0iDUZOqSpnTxXLIYgyhuHsgy7MQR8EmGtpwQtt9HYha0FVJnmC9OiwnpnuPpVGdsRahlt_czsWjz-zpzu00l142gmTsPcOECN3doqLJNz1dPt_QqBFA1WE5B11Bd5sUDLxxuBrKnD_X__I8T8lfS_NKhl3XErwee6YDToUH5txJ-IqGZD3L5zkNcS10UrN8s6WmBmlpW_Jqse72OxcZ-q_pyl9JIKaX_OXYGcJgukEs-liG9gtCfYPJI6QSTgELPlQc8IkN-xR3W8dLpPkWn99tqcVf-HSygk-diZKwvIz1-L5EDLBsv0EwHID3XQ2BYuIw7blH-HsIRGJqb02P5GfJMEGnC5CqBAyEOalHeK-x0XdXzxUWZA8C0gTCN9Gc3vuN2RBdGHp7kTmlo0tQWZ56kWiAIwO2JVoaU3xhKMgzoNwyoD4YjHdpVQ1R-WCwC79eWloDBElqMjncgcZepf26hYf11ex38Hbm5wPyDhsO1nivTs6D5-XbLt-weLKQs-j2FBUbhUH0x9DiQfQt8NnnE-oHq7fLkLaVMg3b80H9pjr-IpW9RZHuY9wxtAvvM9SuC3TdUQ4kn4huIGySdm46FOQn3x2_9_g8pRVQdJkfwUPPe3ON6ZRlX0gZzGMrBcaszhFTv23Q2IFgoIDtCxEs7Wb2CmP3dbhPAliLhH-JQ9aV9zKBtQ_IheIRia1q5d6WBe7qqJ65pfs2GHRl9DQ-y88YcWWsOxVADdWG71JahzfpEeQZWgbVDKSICTe5KIBRMVCU-7pHsCR6i_BSU5MYQBLk5sKAl_-TZ0Nf-rcAlkr75UdtyidCDQu9OvlXF2_StiWIFh2XxbQLxSMUoBoF997dFFM5uZosXp30n9fXlIUX79p9og2dw7dTU9SJf_By0im8LZvEGjlNL5KMVggTblTwUSJ0ddkOyCSUVLbt3606t1TAE0Z2RItlyUAUKg17SjF0PmBwDSlgr4_Q46uHwMx3f6eiOFf747SlCcYLWx3Er77Tx0ZDS5tF0UclX9GiXdv_fyENUmyt0Xy3pzpsHZkx2G7DUh080GgRcBkC8JkMhidNuevk6L2aTeH25dGqNlHGqsm0yC44eglswl4O27FfZK_Fb7S7WIHaCeQIUnQJfYQbAbXEN1hkx7Gksq2Ex1wTNJmWtKnteUstvQwzektOjjAu7xLSQA7b1qObsa-j6uTTFyCkm0EwLL89Gvql2F1pjTAGkMVrnzZzEkt_GfUdakMgWLlNkJfThPywawdwqjzkYSspv7ns9UYOHrZLf8Q32a4FWoV_J-kPTJVAWecAymiMEhTcB8bjM9MdkNODSljZ72kDRSOLuk_rkznqQYxLbbBMgdmt5luEKh678rcOTaTlQ3n1TU77IOY1rZ9a7YrWOzRvaAo2Sv17bCRjWG_THq_TwByUzxiBniFjnquqr7Tq0zKjEEse8tlaMOtIIpPwkMvHk4UykwthMuRBdeAQFz2SyBnMUMxBR0Q8u8AhnA3Yy6CF6JMkvW8GU974zjplQm5HjsN3Z4pkn1QuSFiuBprwp8i8QQapeduyOgS6KYhOE8mBXxicAuiYk04sOKQ6R3wOry5sN7X3kx1v1eHRw7fkuMj-bUyEbl2BWInZXg2Cb0HXn_judQVX9G589T-lIjzraihN5oO_PDNYbFqeS2k7-wXdEK9yQHRc6Sz_PAuisiJgbPFdrk52ZC9hrh3i2Uc9f0KQeyd59uYGOzOz7Ndpp5jNcxSWfRweM3YSGHhRC34_y4iWCr_7DzwpUc4y_pCEUepT5xlVSi52u02BE6SM8kXPSxleVM2FKr56KuQCiDzjfIfzIUUbwSPMb4CF18rltTAAJ9r8qehghHyRB_1gMhQh7aDssTHPztRRIGXZZdlEyyU9UiUl5vgbxmqRlL3xz74sKxdy5Qro8p8JlXIF6LsslKJG4prth_axOfWSsLaBMGYZWZUAoLdklO0Nb2ayZIdsfT2IsraKGbO_0jZxVjvbDKP4aOf-Suf_5ki75fwQHl4-zQ2DYxk7H6cI73hGLWAxQe9D_aVACqLuw87jP_ebnpra7TcFMAZBuNKCHA0_PGVQ667nMshZX8WV7oEARtQwfGwMJCty7KE99ATb-HsplEBGTmx-RTsFf2p5PJYCawg3XViG2Fg.1gYsMnic1iyUqCu1xjC30eUokpsab1OnO16xNkaEQ34	\N	\N	W34EhUJeP406W9vjS4p8Coq5FEFlDa6R871pk+Hmck4=	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	68f5a674d91147bf82375157e6a82f3e
3a1db97b-63ef-7d34-cbf4-ae84a5747f25	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1db955-e21c-697d-db53-2a221a850fe3	2025-11-21 16:45:34	2025-11-21 16:50:34	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.mb2Qpe7y1WoZ1f1nbWe1HXlom-CniL3x6P7E8GNUSB6o5rLYtGLDVKgFU-PtH1Gm0duL1412E79tXKeHyC8bCXfm5Pq9uI1BmtdLE0vcqlxfq0tXnD8YI0N-yZ75cjwPGlOa2by5MDyCF4xOOjBt8NjxIWAQobZHXIkgFROgcMhoDe9l4-9NBZBBZlV7lC0WZ21FJ0_cOkV0P30ylOg56GhDcj4sAyyrD7fpJzcrz_Act69SJPG4p70-X_Ub76CZprmUvZJcrzC9Gl3Wdn7AjHdWJv93Muam0U-DCaBkOQaS2eA8OBOlXDxcFthg6UHx380wRAPZFHAQcD4z5ZQ_SQ.821bcYlbOOEOV__dLf8v2A.1Zt5WFuCB8H1Pw_FkqpEw6FoxkWRHp0qJf2Mt70haOrEe-_rfLMoMB7Sd9s7UHEmzZoZAhDofV1DMR7gfLlhSp6H8z6-RGNLYhVovYEJbHZ69z_OlULWmBZ9c_aL4E6yrhMoqfomg3gonWEiWZQQl3i6dQJ3OsgcBjxdTJ4qi7Kl8olpd9q41eOKU9-jc3tZdab2qc-DnfZLoUUu1ZWeCLMjRKTRworXzyipjF7OwvadJsv6XstxtbfgFEnvGgR6_8fuqM7WkiJDDGQjw9m9PHkFI3EOox3-LukG0XxRDe-pWNRtKC1WxQGtZWlFOp0HLP1CergICYxGGpnyu63otyMVTDpeR4CU5GMQcuzxtSiaBXpf6m0Wua0PLyBOcMZPiCKWyCJ7OU0Ng6OVDIIg_ZQHSkdTLdTRUkTsdi2XF6GjRImIj_nYAogdTs_hwXOFhSZ04yO9anwvZlmdjv_ZSVvMTJ7IIBTOMkqLDT0JzCE5nOqEF-XjcdxWckGKUYagJg6EcY_tqZZFl1nwALddiFtBOkX5AGGiixJZPszHJA9OF6XbSd5_9t_glGixeTElWkRxvccsXP0dXWFLbhhj8GKMXF4vQNBioT-bsrXkkOnxk82ACQlZCzcx3nUBp2d5XL0qOl9yI2i71vq4CYjdEDJDu89im-prjKz-Xz3Hy0n_mWrEsaPo9tYE9jKIBP--wQeLVTpO3jFmI4rodXYuHdCMcAxbIjf1FxtwvmOIxoT_S5w5nTe3jPIgJRcvYkk6HCsjlG6n4fHs_JYNJWuOkIl1aMFsol5pKUQ2yt9PaFRPQ7BwbpixlBnjvw-MiQowv2vl6DA3DGkqBpUYYdqVkQt8NOVoFvkz5CWoqy0BIOD42qCszUH60TXFw3mwFFMmZysJZ6R0rA9Zh8mvRNNFZDrN5IkLaalOZJQ68d-KBLDL61m0Fj0WMrAeVXAVO4vbSe0QyHXPYyTCpWU2wrGof-nVwQgnqHqy308nl08toBPeYB6KwFyLudU6cPtqc2e_Zobhj61a0xh_EQuUdxjY7trLJq7FyI9KLzKBtP0sLp5wgs_4tchOumpTC7ksDIqxUP-zINnWRUmeEx-FvNVi1XHdORNHLqDBP23jM3aNxKyTLwjJmep5fdzMNywRfsZ_lsgUW31jE87fyqhKSVpB3QD51Y5fLNEQ7SIJpvej1djJkVEkS_YZTDlS1Xmodzpu3dSNrAKaZqg-5kMkSZ5IdMl-BJM7PlHZuIq_3cytYisUI8x0Jh8h3cH8LVV7pxzX0qLfDrRwRaqbgr9i2qHNJPoq3_AnpOXRMS0jH5jl4xmE4FNAErLZhiCpuziOgj3ELHI9ZIpZrCJ9InuvOHRa1B-1maeRxqJdZ4afgZnlrvx8zP1NkfE3QMAwvwFqq4QhyVZ8mQUQ12PgLF-S5KdHbAz51oV8v8gmid58UaJnfmFbcgsrHfG5GHHNnKXSbQ7iiYAd4uyucYvJ81rBHpgn_tUJZL2hjyBCbHP-4Ppl7-mlJh5U6jFYZKF9eMRUycJ-B8N1JtQgSMhGKzw0XOJEAjfKzjGT2qjWw7yQZPJjQt4_TJIRs5wamffQFU5CmXUw5EIHAQ1gPFgPxF0FaZUorH59_9uCUxsdSyhxNxG7iAxlkIGR-q0nZeLu4Xrn9bhWH6kM1-OPBioeAj6jcruYwzduwBTm08wobNyZvsenz69ts1X08dVLkV3rBhuT-0N5A1T_D_biO0mTnyyc-2a6FV8yi_gxbK1jMfHb1bWwz6Aw1RO5_nrYafrS3Z3oFj1N_p8RW6S5oQ8Dl-Ke4VaNqIu-3TlQVoaTUy8E7QbsOqQaWcR6Hu7zUQQKvmvNOj-N2RQRLKa2ZGmjacxOHopwiDHdG6LcpadkyTghwe2X7rDIDlUJPRsm51W0fDcwxdHNsvcGME3FWsBb85rK7FjqXlwl9EQYqP98zJElyIlo4DWUeHqxqvrIkkxpOR3QxMX0RJifAjfkZaL0u8dwjXSyPgbJRCcInjdIrKi9CSGtga560JGNGSD13zjEHkX21D_gAvuEaTpupr4AWCQuKVdSSWKpT7XY1SGBqsUM4itKADGYpHca4ge1ibrUysz3DTi5RZ1lo9ra5Bb5THsy_5idICHQATU-Cy2Uhur6vrwpqse-ghpmPJ2Rn5HPMKN2mfOtF8MnhZ4JNJrWEtTvavaOIeQrYGQ5MsFv31-v_SCwC7cZZ0FySFqaUO6fRZLDyVl-49NMRTmTvSyUobJelJoF_bfk8AuKYeekCj-mwfo2XjX7r3JgFIf26y4oSa6y4qZNBhkCvag27pUId1aC5Q4agj7qOgaBSFAeqZNmCGpFynaYX2mmktEQogB3434u3WCMGW_LSnzQYIPdWinq3mU2Fp91d8dwbQZ8yFWtx-KspgKhyS1hvGVic2r0iHzDIQd5wkGKQxs4oV1Sjv4Vf7VqtSb9toZNtTMzdzRp-BjkQfOx0d7cou5am9iCEe-0E6hXKiTdPYjr7nWQyAefJvssi4HI6Me-BxCSOU15IjG9d_M.IBVmpuvdzj0hBKxiAwmXmOA3aK3sZ9q_v2ge8QRicO4	\N	\N	xRVsmxVnvlnSepHBnQ8CbgM1WwdOJ+z84690i6k+FQ8=	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	259840d2d70c40c086249934042ed57e
3a1db97b-76a1-6623-4d55-220ba882d699	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1db955-e21c-697d-db53-2a221a850fe3	2025-11-21 16:45:38	2025-11-21 16:50:38	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.NEkbSTgCRZBKOpTHSj9E-IXRpJBadb1SpQNznDmwOixY3FqXlHZ3toaXy9P22FnmlqglMu_9nMFbGw15rcAitzmigl3MdFCfSMjgFs3pOhH-GX1rBQGbNANPYLGvq1tVyJMCQ94pT7ZDnl8O_AmYjFvh065NaYVIFFAQaVuhiTI_xwLNwg_hLTIGh_ftQ_BGe_lDort6mqClUEYR4k8KK8bx-7ZLl0lAm2mOWzsARooTw4R2V1ldxV4zkZesOtQzBtAngoaDYAkVyMPBY1E8qRF9Tetg4nNMNSUJajznFOjAanjkXP9erZ3a5DJnMSRRCagOfv7xgxnxlPXpkNhKDw.s2gtdJ2x_XyXOePZdJ1KPQ.X2P6hHu87otUwiN9JF4FzEHipFt_Wk0H6rbCMmsK-6mbXXpSkWUlshpOwIGEAtpO-7pQvITx-WP8n7ZoeswCGZ8cN19m97yHfzj3WwpyO1s_DfGGcoUbdry-Lk1CmHnF5swvC2V-0ZL9TX75u_T4iMbwzGf5tq5GSJo1X1K2DD1cj4agY9KPV_ttRd-kqL9t0nsuzpClg1njylrVw3vxNdn02v0S7hxV8Fu97SrS3W_EWSgNwLQ4DxbVKzM3KFSfPXLe5ABFtsGwG2HmUFW15fhkOUB9xDEiBTBavEwj8g_A32mWcqFriDfz2IjO3-yhoHe1Mx3nu5PuDZfBNKoMAZYsvzuCYHOX81NDSsO8ceUhTQQrAeBtpH0rcv1O5sHY2aSTj17SStKOy0Z7TVuT6zs7_4_iA7wdDWOBnDKWY5-dpadbyA8_PSYTzwuXb4vbLgSOAdXrqxc_bq-20j6oy9d_sYNZEx1p6cnauwARAw9aj1E7a3hpeUK1SIokbNlQPNtATuToIMbLqBHuO9ssE-4sPF43gnqxxVrHeQP5jQLEHNorZmDGWqMV3FDuOQOrY2OIeWQDsAa7nXoCEWDApg2MqdQLCxala8iCcareVA5xVf3ydiOHvYYWjBGOT4iNHKKfwTffvffwrQtBnVZikUUErdDYCKz1-2rLe5bmpRLePrhBzdJv_ePcpcgHuFp64vH-zr56I6zoi_wFGkAn1c0eZnJBlc88CSUzR4qyeyV4o6yr18bjDWLKbjs6CQsFgflWkGTXjxjt14qJ4UjhogvdXEVOSSpR6sdrJz77WoKqH9BG6-Gf4yttrSW5K5nkdrlzbPuB_Ml7oACg9vE0joaP4l3JQ5XB5uAOjSPK3eHvLK-hNlTnyan3ARpRB_aaVzFBZjVOgCXLy0S6cQEXEGDLgzjQ-kL1t3O-8ZEwh0STZV2TSzW1mViL0SkhDaFNd0Oozpb3Te2Q2Nu2ybVhM-MW_1VRD57C2mawSzJzhoSx78d42GNKbxFqe-FhAziDh2XDpOE0rpoMeBLA1gjWAXNBx2IXpfaB0uATy6RUIOKGVcVv7Ot4Yl4K8MzGiX2t-R0eb1NBcl6LPkvKGBaBbm6WzWKr3dV0QkqpQps1-WRy0iE07HXMiKMFhDSEjTYYI_VNhaVaPttBepcH3voSjVuu-2hk8SlYln5X92uiKHgXxIW8eFzI-v-gkJHA553qvtNyvCT_asG4kQkyJF--DK-JT-_jJbG_i_siyV8COmURZj0lCKVx_5xNHdB-6PHVFW5l6TuoqtohLniu18BF0XtwkzKPI6rO6-v-GjhjGDDGIpse5uwfYUqonB60sphNiMg6VW8lu60JLTUUkWeBbA_mklMswg6P055taif7pSVD23x-LILrxNLJ-X5Bh-H3TYjFGBkYPJZWxG18jaEWxl3_4mvOhkyHnhGOuMLaklsRULa1jQ42vlW0ukW4f32edl1toJvJhTPR6hJ5TsMFfrvBctmg1L4octU9JGdwQH6swj_oKC30fvzr8ZAh9PGqFdbc0HWSBSSQFGIkBT0yWZVMW-S4gEE-beYUSEel9lN4Bw1a7pTOm7ufprURVZAtQxrPQt6X0faYnT-47jOL4DRz5sRPOrZRM7FX30D8OIzdJOZQ8LfX-pNFoc2w9c75DS1WW92gQy_HEvFmnIlil8HNz6HqzrgbJdtHZjfmcD65E062DBLZrfrkamV-Gxa9lsa6yyBx-k2G-dpEP1sXHCiidffVYbDdNBzzV45miyjEh9WxUjZj6SNTMlD2EXIAAUyMpMx0YklHNsOoQdWkEj8pgDPXPH5NRKoPYK_0hKjdL7L-synzd8n1YzEU6EsHx8EcTmR3fyoEaPvYUrbNc1sKG-czGVdvr0_B6fgSLcTQEZ4MAOW1qWCrqmY9tvMlNYFR8EWPY7Rgdw68P8le8yK9mCcMVIDPf5C2gETCKF_Q52GixvERBiXPE3RivDUXfQpsca5wepPl5BNqySx4Lu4e0NYH0LNP8pZcX4JqsitF_RIYn_qVHkWqcUpEqPZZCDM1z2qlEJ4uxsPndAvntBuaHbCgF9_NAVnVXR4UHeXgV3M-XaxamtAp7esXzpXTUPZHR9AyKcekxCgBAxFcaMLp2MCXEAtfSeggNpMc5NrPDWXm-W1nKuB8heilojwzESvV-S_pnEPMT8Ng-l8I87Irw7fVLwJMrY5lQGu1H9LzYQR0z1B6ewyZSEyKT01BMtFFeoQzLDf4QpbYiGQKMNelCK5PpHw_cxqh0JC4LfSh-Ek1zcgU8kEZrqplX8vsyLAwzpaH_VBwMAxuhT8iO4MftWfz-jBsHRv43ajCxBo9GMGmi3gKk-7Li3UQ4r4Kmcodzqj3IcJUqDdNGLlzPZRRey8ftUX5bYrvXsCQA2NDQW8AsTsU8wIOAAsi6ttgM_OIoTSp1GY7yfyYKR3PscEyhzzArM0ZFsjqCKScP0OlVIXqfhOHuID3HQzHwlXXShEb3iq14zlhJ6eaZAPUpmytlh_m7y065jdzBdFVFmI.TOWhaIQXclKcWh8AKvStygmdzraahWLManUTAfDM1EM	\N	\N	BV/e+kXkYAD8g4NO0XMprdhiB/jZ2OE7I5JEuuIaLJY=	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	ac564504f8124acabd3408cb6b54638a
3a1db97e-b291-fc9c-200f-4b6f8bc2a120	3a1da2e4-3191-7923-a780-699387b8fef2	3a1daa2e-4a09-550d-2d70-85760204b9e6	2025-11-21 16:49:10	2025-11-21 16:54:10	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.cMMEexOLcmjHlFO-xSEpMNiYPi4miufPgP5w8oZWfXdnrgecMb8wJ0woiSHz5J7LLwDzsL2zyeO7Nnig-Paj4dtjBa064xbvjJfgoRp0PwcIowCmrj2rLDraEmWkku_LBkwvAYG81dIaYI7a3paF6vd3x9lHy8Sn19yHojndnhGNp5VWHNzM9pfakTjnZzJqVv91c34Bln0KeQkLDNc-thKYBZdHbqBkr0G-J7EoZKPhRzvtxyb6_BzTpkpgL288RkiSgOiTkkdAuP-I0yiZReeT621w_u7A7yPPjcuVt-cGeqUUbTXQehOwb-KW4B0o9YlBRZHTdobLWUqL6IZI2Q.Q_YjndNJM1YpdE5nbygv1Q.PSpDzZSxz8ic1xbUk5-vvztGPC8rP9A3tsZNxKAtTpMoHrXaSyHmgTh1WgWd5xcNKbFJF9Y0oGUjbEEjh_Bf1mAViS7YsD8qU9H5Wa4ITR1GY3x1gmn02xougey2muddDpOE8ERfj_T5QEqELRmB_IY6Xuy0ZUa4Q8qUDGyAskLDAo8CaQZ1I1sdQk45HQOf-O-eg-imp9JlYewPEZtzksD4GTmavVauM4ps_xYbzPlyhGIU6UuV-ExVPf726_ZlK1lV8mexzp0k6rVxU4LHLbqVIvcHwPTFFS-lmrXChK55ozPn3h0Nb2hlygDYEmkcOP7xLJeuCM0yQkwgmQ0cLPeAxbWvDR9YqpBCG2vtNovR3rjWJI-349NJ5qXXcfgrpsM_3yzpX-qMxhSwxpPRK6Fu59-MvI-puantdbSBmlLkQBVFYtb4mKRC0HxQKvqUmYL0s420pyO107sPuhKNx4hUZTFttffyAajrhhu7y1zZPutsUL_PodXjjKBNyn9zVxHxtV_PFXbd0o-MX7mZyYcDOcsAJb--dz4KB-LMdVi7KT4Ntuu5I18Ye2EJxdrNF3DDP7vG-JpacsXqd07XSeSjSQbltoeyJuyCHhrc2-6fJynHW9UDy41V7np2D-45pWoYeWG2B4WKBGAszgGlR9Rbl46b1M0oHd4OAy5-FrA6QnC1An09cSN_0O815a_h3dMeDqmr4ilAtkHv2NPO4MG7FYuGQx0DvDsuw9SXkbnL-jjkwBQZZ279H-Mn5WBzPI8iy2yQHXfOQXmFr9nzlsegbDQBAM1_ePHDL1QTuv9HyOzFHfDbJZv4ViGe10XxYsHOsWuLvcpt-4Bc_w9RPwz3bbfA4gop_O_14YHEWf0ncT4zuz0HmvsVVeFTd0ef36wE-96ilLO3qIleTfEzCncl1MhDUN58LKeJ4-3K-wenNV0mOrn306cTY2cVUNlz_ZzXvY9gDPxI7D8nsFmAsrAAC726_KAs37GT8CnNBpLVKyJ-m3o2AS8gEJo-5V1IIlfNRlHxyGMm2NqAZ8MThej78fcx1YxoDJBs890un9ZsVcWpNUkSopmlqCcwFcA57rOQOCNwSrwxWFrPq0y06ScFCO6hxaSwQcozUHrBrsnm8PsnF-CyakKcCr9QFn9yW-QWlb7t-bgXL1RVPy9BgBYCBsa-EvHI-Ymp20iECyx8vNR-_0-X9P-2I38DXnzx-LErHiDC4VFtrMKmstrX7deH60aB7af_MWj_nNSdPuTQ2ubIz8LlAiPaBsMc821awTxyxHz9fRbaUiMhSi0II2_-UnFHELyGstV4bsmUVaT5dnrYsj0JAx_W7ESiIIafWj2LvApTVmKzuYY2rveNT30ihpNO5j9UX7Z5Zb3cLDGSNxCZsm6b5fNScc97MjasUKxVZykKbmEh9FacMqH623qxt_HypioNWCxHh9-2T5X7jd99J_UyHtfYPyVfTqP_PyYKB0Mm5LVGO7XkOlw3qAXY4ekx3c_8h7TuZPRM1JdOKGfLB7pATCnuBPmolg4ycLzVfhKnKgfJ-7ZvML7UvhfmdbEyU6_RNs0rS0xTaO2Mb9zZpSBKlF58gfjfZeVBour00KgAStxHs63SysdC5gGWjnWZtMnAxVxu07Ug_KBP-U814Q3YaJt3-268XjncXv_SS98Ko0mukBMjg2LzJZWEQxwlIvRtuB1WSxIAhkRHMw9B6KQPdEGidylK2-B0Qo78haDuwXpw-RA4Hnd-JJJu-sRLtErgtw0axu5J36VlOj6s4hNmcJHHVsBOPaGmWW4FYENQGUG-OkmixcOBj-ceZGOTO0QA669pFA0bmD3iRyQOGZR2wNnPPu-NlZg4gChYZFhmWicsfL0D9-R1ITW3rPCy3Qw6UqV00hl3m1PTFrItsFWKkKtkVYB-i_c80qn91DbBsFlG0b2gaTL_Qs0Myx_C92PFg0E7dDAqVlw1OlUJocP_E4E1FMHh6qa2N2mTVwlGDe4AxGz2rrWimYhv1Exo0r2tYMO5GtrGHmXoCWWR9iaFR9xJroz2PxaKU279BLkLLZ7FMflsmVuylULgD--A66f79xmYi9OSZVUfF7qh2lFQcBEMPWKid2Hofi-SX9UoXCFLQvMgAIbK_jN_yg-50BmE3JntdHamK58n2rEyfkg6ZqZBthPiWOPGV3BBkyrZcASt89-Oq3bSl95Cauh5WbulA1QhWwxoKhw0plwpN9vgMPb5OGay_7Wvy5UVn0nXFZVtH_OvDmJraU-fy3cXSp_A7iRIniQmoAMhLSJNaHIq0v7LRSiqzhSYEeFx5bvHSNmGbtNdSSU3-ATMRWnepZgj2oQ5pYB-0jwkaTNgCMXbNYNPgLhshjfAeohKYDG0ck4uhXWpE0pta1P4rjF8VEdPv3D8GQ7GvwwAkNHF9FJCagjw-8c3e_6HSlN3USA7imT7q1GJHnfPFHUh5KeYS8lEsUzNMXEAYX8ujl0hBikeETyFa-mDxKwLFELzczc0UdZvKn_1Uoi6SrUz21qIsfaVC0FpZusrqekDRPQo1659Ax0B2uxqGIcMf91pXID39d22_Q88dYvAoPW4s_7RUOvMUdbDGtLzAdAzHBUiZ8UOkJ8E2h9Ufv5sJwuFM-kzddiswYkzsYLapr4hcN_TivxhPVqbAt7rLhx17nU-YRWGKopUZsqIg-rHEAcSItmUPu8OsFqBUaoF1DgQGmFlIUdj8msFMqLt_iWyNUrjfpPmKjjN8J7a76U_o11JIfzHbERi5ANMcm_uyN9P-lfup939jmbfEag9Sg95Ov0c7egkq23Kzu4qbJIqM9d0ZnL9spf7B1T-yabh_L-R2J2JP-Q7cjSCtbiA96Q.HBYnxlF4rFcA3s36LZVDHZkE-wYXfiK0OWSEdtBn2FI	\N	2025-11-21 16:49:11.701225	CXJIADLQ0LHFPm91J64STs0fsDwrp+CGZfrNvvC+zIA=	redeemed	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	4588434700bf45e7ab3f04c68d6cac31
3a1db97e-b644-2ca0-8785-496c5ec07221	3a1da2e4-3191-7923-a780-699387b8fef2	3a1daa2e-4a09-550d-2d70-85760204b9e6	2025-11-21 16:49:11	2025-11-21 17:49:11	\N	\N	\N	\N	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	access_token	{}	a37bf554577e42989bb81ea84e3ec3e0
3a1db97e-b65c-6001-85f2-0a00d763e8dc	3a1da2e4-3191-7923-a780-699387b8fef2	3a1daa2e-4a09-550d-2d70-85760204b9e6	2025-11-21 16:49:11	2025-11-21 17:09:11	\N	\N	\N	\N	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	id_token	{}	28be9f06e8dc42879aa11c2494f8b69e
3a1dbcdd-a239-660f-ebe2-13dd233e1968	3a1da2e4-3191-7923-a780-699387b8fef2	3a1daa2e-4a09-550d-2d70-85760204b9e6	2025-11-22 08:31:44	2025-11-22 08:36:44	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.aCjc8I9TWJYWmUTi3t1DoLymuGsP2nZsyjDk4KrWCGc-gsv5Y7BtJ5jONejhESUW5bkkMCqTwKL-QUvEw4z8Qo7S6hp-086PkJK1ohapfb-DPMFPHduienVf1I7ilb6Rfsl5PRt70OK3Bri5-uedeP6rf6zvY9sCDXL0DAnRZgfKaCgbHpn2uNr4_qOIQX66Z1B6PDko7DVjhCRraVUvv9yb_gT0aGvsGfOoA9uUpxpAmHdHhnw36AA0BhIL5S89iowJDW6KRNYB8SYEgQZH4w4_rNOA8kkYGY5jLenhlDwJZQ74jx4M8uqdEgNEn_gvyhiOBdWn9zRWjV5bVyriew.U7UivMzbDrdl6dNNToqDTg.XJbDguZfMVre_On1IDpmjYU-zXn-Awdo99yYY4o7HOCEn9az-lOvN8lWm2wPMB3tVRu0_5BhM5UKu38AeV8ObVK0olPmt-MN-0agVussP9l5UOXC7ZE-jzahPZQeoodY_Rm6i2v6HmGrP-DKdjSYQF2jTYJBtGX0J96umEktcHSHO7WepY0J9ciwRTE7UTJNr7-K1qvbG4BQq5aEkUT_EgMjhhv5DUttsTY5D1-4OkpWavELB_ZZtB_ieF6SB_Kf_1JlpPh25nIcSo_CC0sHjWrcBcQth6F3aZ-C-Bz7aQuKgGdiOFpKnynUvnx0j_jCaikem3oqUVb3bb3nmCzxiROEgwTzxhCiqvqNyg9lJtVmGeVdTwovka9q0Qok_9gKyJJOjqfKVvccx4mJqTOdw3ERrjYF6UhIq4ZW3KDQurReNauW1AcyAT9TebiVZT01Be8x24bzooPHO-W_FoGwETdjXcswI6w4YA5phg9ZU9FkEvurGT0eNXpl4yY5ZFyKPU5434CLLBw6SbLvGnNl1yCH2hHmNN52OEey1q_RbfE8KuciC9r5nfX3Ifndg62BO3dctpUNFUbAFi56rb6AgRqAuhZSfLEO_xeYLcY1_Bh9gEbU6gcf7Pd-k2U_UuW80MTHijZKgtZRP2jTqWrhecg-cFuBbeENQRBV4dDWq08T-SQ9EVhF_Q0f0m-JLA3HFTZ3jms_dFtHfAzs2FzRj40Rf0Zi_AM8Gdw3QRD3TXX-UBV34q0oMuiiXLmUl8go_pgBbt1onOrnWYJDvTkCVGInlvjtS4zs_-dowkkl7z8zyZetsvs3brI0oT7AfMVNuzfV8ZXCrhiP48-dlTGLK7ZW2tPk6-WAFR1jSnoag-vydxzxm_b2EcDD_jQwEuaG9YCbC89LUev8K6jaFnI-j0IkM-MCNetZlDwhMXeuHONDGdITxnkZ83d3TmAspGyk3VZm73DsyyW8LKqiJDu_Kyz5d6kLpIUerLAvzPt7IL1cgmDwsVLezw4_XZK06YLdTK6U5y0HuQmmQ6NP3vKBikZyNS-Tzisbbe_ez3LlYPBooD7xVxqWNR-xnAzr54kYQtz0fbiIkDhE9pDThRBMTkckmBpRh8xdM95_ayhRVmIQgJ-5fCm0kBBbuPKYNUQQbEA9zpgnyNkhbjEPHwaHYGpoPdktoBoLMJ7NLaaVlvbIIFRSqRUr7kf1LEabQ-9swC2t4Mk4IIhOpvjW08vHnPdS7Lx-d_UhuwmnfD5RxonvFCt24ej45-d2Gg-b7dwCUC7caUHaxyMyAnuG1JxljfkU_HI_6MlJPp6Ut-o1CVNDWQPh2cG-1bcLvMPK0uoX_SNeO5uoulKzMXC0O3_Augz3udk4TUDHfJnjfb50pwlWVMSfEbSu8dUtkJPZK5j-l-JquLF_pLa7BjLpO-24UibqEkyte3J7kr1SB0JtFrteagQMyoOiku89EfQLlbD3ndKcXSvMtkA21d0Qi5ejTgxi3pPjhMrm5eHLqczkCwsjDcgyegqo6VEl0Sj7c5esGiVHYlbKiSJcLqQ9HnHevS_4f_Pnf5gr6hcD0lAqQjPUX_Mjg0DarQRWpPxtATmhX35IeWgsSQjM5BMY22kCra3GPQC37iumEm1EOTPoUsTAPtxc_LBqJFVJ-Mh36-LdAYCjz2c1nVHrvTnR3OJvtNFlaFo4HxPcrbvG56zayuPlbrDy8gHGLwiO38TkdcUwUBU2zWr3BqjeV_a159tOjAagzAoX62fQ-vr9sUgoU6oTPJSK0CUifJOVKGnBmumKUnXD33JxzZ5bhZEKB_guMhcB9eZO8Se5qBYZFB1n_S1yVPEB5mUdqdooSWLcno_vT_rCtTEeQYOuM25o332MrKxjH6jJL7XvrW0RybtjtYB8sfbhbSfc_-niGAs484uD6LKfGLLrLezuVHGFIoH6PP9FqH1PdiZfEdaGlrkoRRXmhTAthvOCFr1ETkRQHYEdft1s48K4JoP8yghqFlF1uUXwKCeGPHjOOEEn05Nfu2cCHMfjPNPq6d7HnuYsApsFavobkewSfXU-4bLMIA0RrotevL3Q3jCnAzBan_YBhQcqOCXXULNctqTq9ODzlj2BvgqH6TeXe8Epk_IGZBvYD4FW7pTPZNO1Z3oGMjqpzxi2V7as2njN1eja6EO8TTy7O92uL_yOdtX_3Nv3CjQo0jnCVUm8qDJ46FyDoj7exvHW9uCViX1LJ2POiH4wrHheUzD_fhoFGlbUna300_Ur2Mu7k6XpMmGLjIB5QotYx8rUohKtcp3SAXurh_2fZeSTSatxrh0TJr5xqkMeuALNFPVo49-dKZB4ERR9lBu8x4PUIzVtYwpxyfJf7OGw_UWbYuNBoPhm71scvQNsGyXzK80Vz2Z9CH6NI3pdHdKKHLFr-w9ZQ7UbQ8OxKU0p0XfwLOL3jEmNaXeRX6xAkFpv8O_v7xbgjT4eEc1tFi2QpTw152CJjGG2fm5xtJu-4D3uftq40o7kvyiqTOb4D5LwO5ah8aDCp7_3kvWx93CTFKy0F0vw97wFpt25RXjILpfSZlzndcVYIgLyXmeMchTDIgWroynSr1k4KSKj0pGRawjqRQ1oJh5QtQnNq63-EJq2s9ct9Ca12KM81CnKwnLu426H3IW5WzEut4on8L6E2j3HC1BrJQUc6Rvha-DpTSwxWKhrDPnD-E-MGrtRKTDM8tpqP_j7-CG1jf7DNgeFzS_4293jnd-qajbHJlASAx4d.Q6A3dj4UWwEFL0GYb5Yfak7Q2qBO9StDeVEbcoMoCXo	\N	2025-11-22 08:31:44.339517	YQYdvznQuI3oxNHM1yaBjFstt6cml1pFLS6Gpafcur8=	redeemed	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	4ea41ad66ccc4661a2982586dbe0afcf
3a1dbcdf-0ec9-e56e-0173-0352b2076824	3a1da2e4-3191-7923-a780-699387b8fef2	3a1dbcde-fa38-6da3-4cec-3b6b954e7c30	2025-11-22 08:33:17	2025-11-22 09:33:17	\N	\N	\N	\N	valid	3a1db416-b2b2-3609-98b4-058d6ceeb9d2	access_token	{}	b27e05e6d40141ba972188f5eff352a5
3a1dbcdf-0ed2-05ea-1e5c-4cd5ece9c665	3a1da2e4-3191-7923-a780-699387b8fef2	3a1dbcde-fa38-6da3-4cec-3b6b954e7c30	2025-11-22 08:33:17	2025-11-22 08:53:17	\N	\N	\N	\N	valid	3a1db416-b2b2-3609-98b4-058d6ceeb9d2	id_token	{}	ba938246a9b84e9081585740240fc510
3a1dbce2-c14e-d40a-4731-9d6c6101feec	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbce2-c141-ea2d-8cf0-0a30b045d5ae	2025-11-22 08:37:19	2025-11-22 08:42:19	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.jSXOjlmdVeoo3mLBwqhOPqd2js-Kp1ZhFDiVixUvAZTVZs0FQxCTZauvXwpzC-l1nwSIndRGNASPAKqVp7GbZP5noFNWPEa8TF693_dMtWKdzDxM-LS79M6iD_CrMlEQzG6CpYuBAzru5x2y6yg3qVC5XxS4t26oT4KEBxx6xtqkhMUXEFKziCcOuBvpwX2ePwX4mOkgIMS1hW7vfUwTsm1fV4Bxva8F8WrSD4w4qXmE2oIILqKnIcLeFWUVkhylzd-8ZAwOShddhOIEtgGj_YkpFRrXHXLJO6PgJNxjHDkpcXUdnyEB3F2GwdU-Z9PkmgA8HuPicRXLnrSQdtLe7g.csLiwdc8w4u0rsj5Er_9UA.DvcBcYDVLYR7nPTp4T4gDR6CVMCrP_vxkYYXGGSkuunwVfO2e4AZCpq-16yr_yUOTLGQzSKazlIGFG3ezFe2d2fDp9elcLmyeQ9YNxaUnWuLb_z5U3z4lx2fvdDvUBXa84M9ppJ-yLdm9pdAfNwEUBtxp5QTSzGiBUMCFxNBr2Tg4-gFGPhCwMZ_3Pyzje4HTebRN3MshL8NDYKUbXJ039A3pzFSY2aXqvI0GaeibtlLHqoUB4-Q81O-7TNs-Qe5wzTli1q7xy_OdXZdKLnTCK2PULk2HYJZJ9ucZz-lLKCTFsbUop4E7JR4I1uOczdggdDfztv8FeluClc7G5I0OROyrZopiuw7Cpe5Zzq4oQP5EFJzW3D_WMyrq5fqcCMta36RJ7XilTW-JKcgHMH6YQSq91ARka_dP_Z3STeFH_eKZxFtV-oi-hRoNypSAN_gDQANQqguDN_pKEjZ1LUv1J6UnPQNd8qf10pc9ztThr5OsqKaiM9B5q1DdU_He7SbzhWFIm7dfolsnMmnzjqJmG-ytLCLAIMyIOQj4PveX7-jDTOoB8Zcv2BYcBX2fH0bBBP6MfFMAi-DCjS0ACyIpGa_VCedKkpoq93rD6h5gXJ0ymMGKXqCrmUnavn9Tos9orjSKKAZwsRecvxq06aIaCB-sonZ-0ZNjOiZfkwj_9q7f1_7yxToMS2CgqKhC4N9O742oesK_Kv4GLvV9YfrVfDVLQo_kFhPaNza7SVc7Ilgy1I_Tgwgwul42nc1zFsMNp21temroqfbdexLy0Hij0TLMtYAPncEPYbdyBImvRbFnAIm62O0AZNr7ctG9ydIrRqLI_wWFe5nq5eDH4H5b39RFPiRSy8bK0GT3f9Zy973KEUdvd3aGWH6DhKnSRKlDIzSPhL5cNCbJ3v9_CRt4UtvJPmgj7cNQ3VwYRzgUDWbgE3KPfwvB_MADlX9HUROxeNkOjAm3L12J0hOqT5_78EbztfRIUseZAbggEYSpw-skT4tG-56byATTEOEF3x9KzYPaPG6M3b5cpUEfEjaVzmtQMi4PhdZIc2LDD6bC0UIfT0bZS1dwuIuDmdUFP2ZeahDmGeo7sDtTCrSRpLVZ9caz60vOoFPEaRsboIi2GJCGhAUgxKYrhEoImuMIfXGr6F_dZD9MIta9m3nYfYaDrg1E8DVzHb1YM8VExTErcAa39nCYn-WQZ6D1b1IKCOqCoKN1bmx8nFgnVvtwcX94XsvG5Bt_H3riy4cofEXjeBwrwwvOjL5CZGL97208bmsybq59NTRNQhyWuw0sw9MSe5U8C76mi2S6TGYcB7TSm2NkYidYRmcVfH3-W_zTkU7rUF7I2L9zffm5t1ygdfqjM8valmn1OsWnK6I-bclgtf5N4LJYhyDbv8cXl1X54zzgmrMTwxSP4xjd_IHuldH0cWqAXNrT0arZ4YscO7aGFJveeBvUILrBExPTZkWAR_ZasshAY6AwOjdAHEmXd89m2EbNpWxGfPhX2cTL6u6J0N9QIpUo7hQL4o33HHFjrEBGeQDBkDS7mvS6m6_72L06JtGiGRD_szgoTXPGeYE1orUkAuCM85c3BikBxwB9y0ceIxR_delAEM8SVEoKWfN338Of6u_sYWZ7s8nqOTwWsCPTn5rJhBNLh2eRKVKeVdbpqtj2wIxr1_d1aSZ25XO7f-UveTXWxHpoXnR9W8Myf7ddSrhkdXNuXrNFOxx8tPQLOVHrWOYUj6myTYvuI0iJWAZrI5AOx3_zrHC55HmACZfwbRZRF1P0kNAcH7nbF_Kv2DB3m-QgHE7SmIuQCArrKob7HvZ7EqiYg0ycCca9pa-ZqjBz2Wgw34swkHMIvRFdqAd5sg_e6qzKbien-PFDmMLgWbEtYfBGTcDYBRkQH-Ba3DVDSL-Ze3ckUoKxZ9_OsQGfzdC7fpJQkNfnrIt_ldr7v_ZgwdQbstCl-lvX1bZryVEWRMS_PwhhcjywGg7DoevfjK-RTAdWu1RRrO7SmiVCJa0MBNzdQh7MkcDR0uH4BUkOuKA2KczhmY0lcfOsfWQVAW3u4vnLEt7HCYHSVUCmCgCc7sDetT9dGhqJIZwyj3PFVzAAQuUDtZR8mY1D9--O4ZS2sAMmUZfpPZnOkuXToK9zcze4SGeQMGicymfn31jHkbTwBDxgD3DjbcclcHvJelx1-OwZWFOhWZKs2Awrh9fqITaMrX4vCSe1mjmiO3oQDnYrC5Jn_SHXChEe-ldfl7fRmM-49A-esGY-kSVqZmKM4yYytjz_1nsiCudABG8RWp5k6JSB2l0Ldriw4YnnttGemnC8l2I8RKTRx8xNKCma7slWXr3IwyI0w9eehcIjQNNaY-8WXPTH0q_Z7DsRAy0Ma4CjuwPSeTG-9sCIZQBhEHIi95PDa0RnYyvzIZeAdTKUAx7Qd0MrnMJtOpD6RpUYm9vEnJa6pdylJ1kx1TMnT8d3f5dYtYyyRHGp1XSFWLLplbG6em1Np-ixCiw4OmtF96Lznl2op_yINiWzCXn9lo8MM7MCO5ab77leiyKhAAConpj3-_qW67jvbXh9syoYqXxGgBEGv4FM8-UQK4rm_y-PlrlMRtlTpdeYxb1OIR2AefXlXGI69pxS_pAPA43nE5LViSlT3YReQNpGFkJI3k_RdJXO3Y4xBvvbcDRy07C-XuRkx4DAT9tizSQQKZew-vsNEyqY9I1Tw.QwDW4lepyTrSEkuu3LR3gGbu2VZGMbXMhYSfj0VArds	\N	\N	kSuOPUO0NlfQFno7xWJ67uZtpAlFGRsZ+I1HTr8IESc=	valid	3a1db416-b2b2-3609-98b4-058d6ceeb9d2	authorization_code	{}	d794359a6ebf4ed591420c0a5cebf7c9
3a1dbce3-2275-50eb-edcf-4f2af52eb713	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbce2-c141-ea2d-8cf0-0a30b045d5ae	2025-11-22 08:37:44	2025-11-22 08:42:44	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.OCMoDC9nTjedD-jtL8CuiKFXwLxvonuczOQ5oG3VoL7IZD1MZkt_cqiQT15dSVqU-fWT1WMXhwygqf8xpxulvKh-JA4cnP7VxaI1ajPaJCvGgzXhXvKf9I9neBtJQmhFkzileskhPW9fFd4S7i9PpzPpqXuVGI8a-d5CvYrv7GVJ4BpMxV9Kevki26_eK7rbjEGQMYrx6rbciFNeV7Q_BqFVYdc0EuXZB2Qe366WOnL3Xu7Ar6AUkMkBz2c57aMBAETbdBaNBq8_0DFxjydk7nzcQZg84d_t0Mf_xm7Rg3N5lKZSI8lz1qsMDHReZaeVNGRnxooAC1BxgpnvzxHetA.dm1X1ZsvGpMNwAo6SRDMTw.W6mb5rqAcoUydIDFS2AdEd2YFAq4ugzKCyxuw0LBuJtAzcwZP-oB4zrEDEcho6kVXgqba5LcR7f5TTN41K2ZBdXqk7H_42zxV_dOHI0V8w6O9mQDog4bVQqszPCr16125M9LttQUWcE3CsklBUvnVT5y3rYP60TDRht0CZ6iqCM9EvlRu077jX3BvX8vVKyexP0KS1R8kVDIBZTymSOFb86vR3g7zWpPp8phwmeXJ0l5TZufVjELwEX24avwEYEdw8H41GnfPafEWswuA_s9anB-kd_jYBv-q3BQCP517JVFxxhm92MyZ9pI-G1pcw7XjzMDHTdFiu9TZ2bIDsKRDt4b6RX2UU9IrTmHP7O1nJHiQJdjAAlFshgU5IGJQjG86Xc5k2qyNRbChdVcDWkK5D6mrCbWzTaecUHZUXl4Yjhb9sJ3IcELinXRmAz3D9ctjTKYM7HEyOLf_anklmRN8Tm-1qSRe5FRfdX3JpsH4thQgKF6wcxU91tsWQ4t3aUgaWbMvFId2H8FPQ70NTfoEW8VZzFxADcfPJ3LDLB1StbMfr1-Zm-R9GdV_LcFHae-LSltxg9ytV6W6_TOTrjUV8IZOyb--vHWhoE5gvRCHCRp5GfkPaoXMG_d9-yvK3FtuCQ16E6llp2bM4rPJP5FmriUnsa1G5edT1LVJD33zKF3EZha5-ATBV4_7PQ6KTaawt9nlfAZ_bXqzVRBR6mj6bp3tLVdRWw7Db6Wl0Mv5aSTYoVxCLpgSHatXGKu5Bt-YFgR0MAK7q_vMvSY-g-Lx-_8DzF04gf45y17PqXjeZJa091JuSSYu_aKMxCSCAo-GVCjkCKlBZu0TUQ5W7aO9sYiPYAWzIl4Unn__C6r5r-nTFwQElQrS9CSka0GfURIQyhlxnyQpaY5R636_fomXUqMsBVfJg4ZNd575GsUhCCUshQyTthhhv7n2Bswh6xz8tfb_8-NqLezNLFZQf45WttubWR6t6hY8N63yvLSBGUt_F-P6b7FtwbNjPa9mGP9niZIQcEGrelQh4DYZpGuIbAX3hIzLdMJ4v34pClpNdaq66DtaArokmKp958RJoyFY7FWQaG_pUtKY5S0NkQGMc-gOycIS05I7FkhBcBLby8r1rP4AEWWGu8vxdOIEe_DJYOlJVd2GjsgL2Yb5j7Flmu15zcAPhd02DViTDFv5QUsAoNaG4eiIz_CzeZ9NlYCapQTAS2nBCLwHVYfpAc0YD_PDIc7jSX4om0TtC640Om8KGvuho3kgLm6UUHQ7CFyhnDSYYsc03grBo3YxYT-ubRUY42hI9H_utFGC0ralJxNUXF0ch1QUz8druP6Vh0eseeN9sLeSv4Zcuauz_YAUIA80WfDGVgYo8DZsFTdCorbC1-FF27P1tGyoTIpu1Lv7CTru60fq0l6ZXMkdKTQ4r5X-Krul1n9RRlHav4-4ijUMRbae2IXpZLLzF8yS6zYs3kfsTLZBosJetOopJq7igly5VUdism9mC5cLLsvviIGfsBrFcdLuYxI392SXEBJff9KtHsjadwKJbJNo8BH_P48FztG-A90chBG-LfFkkoHxtU31xBtMJGE99Nwbcixk3dX1V_s47NjDxPFJOLCe9wLnCUe5vFSqEqUObnZqkCJyoOPBaE5GPd0gZHtguvsBhY8peqSUSNmJZ5gLFmCDQADahRfOLunMeY7Tz-X3zKUS_PI0cYfrKCS3u9Eh07455XeVcJO1_9T1DQfFL7XB9VMG8WrAqNyZIaRFekuRHSqZ80y9-kUfbM8BPLqgnOG7KiT18l1m4q0gb1wnOm1pgStW2L_MLv7GfIFUn_AbqazDWXlt3Tiy9owuUo_RKgq6VONJfdWWSdg4cU2Xqf5rebKnlmdffFCxaag8MO8IYfTwtq8dnlNp3kAniyRCaZsrcOnHyCb39Il7BRpmYPUtNS7P-LZ9qTezFrPVv4bPKT68bQiQ1vUp-RJtbVOyaovzhsvoEkCvE5-c_c_IlsVQ220UCAXZoWi6fn7vxPwflZiplWT7hgO1ZMZBsQfFiEFfUiKcLtNHHziqmw08GyGrCJvwIBBRcE9TZF6xtfB0QivEcEAyxE6krt6birb_Sl_i01WKSXY4RdIOGi-ZTgsgSXaGOUr5ZeKtvUpBHgwVd9f7MGFmVvRfkuHx3DLlRv_n-c9Fe9otyrRXFctUDpZgcDxe-YUJ0rweuJK6l7WxSJq1D01IJr4wRDCHKlKPuFgvqfMowkeqeuskM0OgpCF1W9uBDtIxPZyHU3AglbIJA8XfXhDKdDQzIQWESSa0MFeAXTRuvoE66ezfFSJJ3KZmN8jALUVaUnv9Tewtqz0eSp6O9EKmS1XzrmNiePDtzRm9DBU4edsC4lGvTGAejD4-S4Z-idRQBKgnO4qu3U99_Af-eJg3_DJyIE-ZeeS_Yy6UiIDrgUGDQwpqs6V_Q0HW2XT78hLn_ulomzXp1WfSpF9U1BtsBEPEz4DlWjK15iyqGN_sOil1Y72wF-O2_Jw50DrLa6DsgFzZzI9-Ds5x-OyyPkgTfcGBsqhAiT6ZwBLZS_TUHsH0XY2hiTfcbJMNZW7RXjmmfoAkpw73vz61ex43MRKJgHHd2Iw5ifLpNMrEQEk-iJkm7lmWXFffzYrdp-pRRO8-GkOKdscdvpoBtDIDHD1nXzfZn2liyPXyExmWFSBTm2xOvE7aUOkdJA4Fg.Mfpyb-5yKqc-kEi_I3ss9uFAn2z-7gSrbMqwFo1MrGg	\N	\N	U7xVIJmxjrSsV5BAzHUr22GwHTlDI3O7nKauNPD0gK0=	valid	3a1db416-b2b2-3609-98b4-058d6ceeb9d2	authorization_code	{}	8983a33e5b9b4b59856cc764c103dce5
3a1dbd66-1069-1e11-84dd-b41b6f422805	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-22 11:00:45	2025-11-22 11:05:45	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.xNk1YmxzgD4rQ9vSBzAZh5ecu7bEHdiRBxcxuSg8JT5a1_5S2usKFvBZV6FBvNileD_VoOYO7cDECut8fW79qkydrJuELqlsl-IuhYBInUXu_ibirusFADo7ct5x8gvIwhgCHlJBUQk1uR3akRHwE6cHwtCV-44ipg-_vHk9rFGQwRZ1tGV6ig7haVffmB_mgywBMhYhFhYvax5BO01oMKRsEY4mPTJQftxig9rCnR2BBmbsViHt5ltMZ9J0xZtnr6ZEn0KWLXWTeoScYWM1CDNWBmHDwNzCHJEQ6yFv7X_zhPk-rFJO92loBSbsyFaSv53sATCPKxmprLz_fIeymw.H1RJlzX35nVeLmnDLSLu4Q.EQPCFWA0-5GtmEoz0OGKsbxA999_dUUe350X7proZbYD-x1TPwhW2vOAAj1_Htnnczy2JDk-U_AI0orlWzFfZZdE67yNFXmWn_-SxNDGQwTE4qpqWNKstkGh82BYSigmjWLPnkxdp-HWsc-Gl8aqbj0PdRKB_HDf2xQ0n8QXnb4doC9EVArG1-fk1u7PZBU8euIIJZXesJ1PRp69hml83MBID_2iqqrzMcTrJJDos9VlyHT2p3wMSx9lIklbhUrmrIMyA6yoTsz-5gPTX5UR4gnDk7xb9FGXJEcJdqcss4n95Cf8gHiByhvBSXw1aQKd2hX4rWUAHBzTYwvUDJ4f_9OQrraPYVirDAcej4UDL1ZbIh-7BQxGIJNOfvUHh0_ZEpT1CFenlbM1p90gE_6yWDRXoY9R5XJMsqduCF_wA9dw93EgWlgJk38z_1glvXmT6Q-H4zAWD2BSUWxjKfkTQOEWnEgwX5XfuPa9pd28rMKUL9mG-d2dkgN2kYpAo0lvWjysPUbhNTpUjELs2OX_4zKFl-eP5yjDTklp4gcA-zlFZnZR1gU-nPqCTbhk-AJRHgxLYI2xDA1HW0uEU_2ArrqnV9J5ezhHcVKeAJURSvBHFNPIje3uv7u42nmnd2mjcldqvXi2THnQrn9WRFvIB8TiVqcgrk7dnNFtGpjgE9b9LQJDA3ZiVAZ2B3SRh_qOt_JLvQzR_HLJIN3R8fdqN_fzNUKtvXmi7HBuDmQqJO_WlqICWoJUxq6-OwHIeBM8EaF6SUjzvWPC-Z3m6OWiQHWVpTnzqoxKzwA8ULDsfpy08Gte_fRGaI5mQIbyq5sd9Tu9QsYqdt1slnwi8eVcPghbZGnK4jajuCrlmnPjWzUgG_uh2tXDEv6_Pj7JmRgc0WhqosgGIgsrCrjK6Vwmn1ZkI48l7v4e7GuDwIcHjh28UbI3-KYzF50o8gTsB0IRLO5fXLUf8WmTDXSuJL1a7f8k8YENhYmKq15Uw93sSuGtdgrjsBdFfBFi3jIj9g2p7Clt-zD70rM9CgxoS_i8YM2nkiL7hLTN3tBSKBzn5vtl3UCSN0OnPcvlNLEjUsWGspIrF3kBx9c9_YhlY93Wwy_Lsg3tcOslCZFS-DyyrUzIY_SLuIIrYkGrzCoaPsx3thn1wc2POSFiZozgecgtUVyzlcyu2TbE8xONPgQdju07ITmG8L_9FY222uvtgBr-f-AFFUuCjkKw20CRiB-V5hp5MZ6GnCXC5uXSFvK7Q318kC5KpJZWQDixcCzayTlL-MDywiY_wW4Pdg-Q8S7-KI0HGA6ElYACfj5WEZfoOxtqkD4oPNbc0lGN0fS95NVDr5jeRm41eCx8M5WYIJJPRULOVYP14TmJmNIQM88vZommFmFnGb4PVmCyOeQbvmUs25lPPVOiuDEASlnZpzFkFc9sZOUtthDqKlEhQYgjexwreOsPo2UMmD8gu9g8SGVcBBi-ZxTXCRikqNdf3SkJhgHSYBmDrN4k_6hiHmGGyOfqqCSkunAiPNYU56IbiUftIEjYhmecbuWI-DvOAKiB2JcBGeU5B3154w_fpLOMRKte31TvX9tpBB_zml06WqBzWF_mcbjr0Hhw64BphXYFENxpI4W3eaDJXtCkwKSgITf3dMchZ6ZqG6vf96r1xjspw_QAzrk9r6UzfzZW3qP-nxRYQ1zcx5zSdtVKs3vzS3SPbCWyobblu6waGGq1ShhcUgla-mPjov3KRfFSYSVxDQp408tLm5fsgCJYsbdY54jxMG_tEnzZZUVgfbLPUO6GdpCmmXy-YX4ZGdAzLj1fREXu9fv7mr1FfO3YijBuzN77Ht3AZOVAnnMbaC_X-LO_QIVNb5wPhKF67kLOexbX2jj2jAmq0tXxnhUcbYQxDFTC4OCq7XhAH6-PNCRW0MuwUZxo1fvk8NEOOqekmdnyjdHJnwBixphmihUU2QVBfnsCF5czSgrSXB7kF0WVt166VLadm3qaOtvBfuCvzISMuPaeeHREoZg3RjcSu_Efb-I0hR0T32uv11qprLGLA5rn5vFpzFguwzHLIGsvrIalTTtTtFDeu8NYDtMBFnwMLk44jv8eag0QdDRIlmlLhxzOsXiUWecocgzqdB0oL9A6IhEYrDJLIRWcq47vp5Zx9atfm6_1oHrL86tSl20DuqLHvmk7keb8SUBA1bt7Y17LKXiGnaitMr8-r5JBVKgVCxrpKQzShrjlYxKIJSzGp74yE580PJTF4zfOqXANMzmk5B0N4fRtaRW_C1CdeO54gYus3OyDOh1fZozDm5wICVOaNFu7u2-RfR5wI2_zYu9TDOD8VCxO13t5CHAxIx6aA4U5Vrh-lEUMZk419nfixeiWGNbC5re85o4XP6AjqriUbH8N6gzwy8FRflCeKt7MVc6u2AplSeKOTZkAyBTGZnjMSBKBSpq1kntjmiAoCEedwQ.FebGewkaa_67NPmlj0YTp6XkUcbEKHWTcXMRVHn2udM	\N	\N	zwJ+av+EtEngcsSIUTayVZstn5mLlHMciyvtqXG4ahM=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	1412a8e28f52482185c1053f5f13d7d3
3a1dbd66-a8b8-ff8b-40b9-e6eb345be85a	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-22 11:01:24	2025-11-22 11:06:24	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.w0hNsve0LNnVOHeZ61YOueZQZ0lkkV3aos5_C7e1nhR8hKW1YUYqJ7aRgPU8agmfYsAxGmmY7MqjWIygyZhQ-tjMYtg7SX_oeXb5i0e_iKbEcHkowVnQJhtdkSgA0DRrW9A5IYTMa1oaF6hOG2s8QA000aDoXu-FQSM7ZzoUsuUkhTDeFV7DzLPXKUWYpkMtLp-vblEmDgoo8bzA3_1_HzjXm4xK6cprTiuQH893BHhUWdjg6pgMSmyB4dLS-e1Z1cLPnO6HlHL1b05x9ZgCoXcKAVYGzD9tjluzECVqPi12faV4IV3M7JzaMwv_zANAKLunoo2wRQ_rg4TuAzeF4w.iDXG8H1wCx5EkxSHJyngFg.6cC2do5TUUrBdH1TZA7dWvShaMLZVTwOCrLqxeetfLHKho-DluhVC2H64ODaLvPU8anNOIhOpQocUHoVFz_nxw4-qWA0ZwsBUnT4tNBYxkhOmY_WCf6xPQKa6so7_Y7cesRO7yx6ks_o99Pid0wsEtn3x88gvtKwUCKF0KNGnqSR5LtH0KnuMe1qtEeMBkOKgIG8h_vpAVt2L7j8tjxdHO5s-PvAnSLisdYYXNhHuwT9YE70bhzQ1d8SuhMgf8qzCeGaWNxRYOhCAebTxZQboaW_BOTlsXg-wIWyWDvD-kBt2ieR7ROUTnQCWuD2-826afXkiNcemHEzjtcpdsdzTc0WVevYhswuPfSSzW6ca6UnuSs2yrfEvKVQTSmbkMWW_PVDlrHzrnqtoC56sFOmGM8jxjpSyqYuL4n3iP5VUedAowLGk4sNnkVLBb7BSb-9rpL7th8v9yab7v15qAy2WRYdyo7-5zPgmG8PXaFXNCYbxe6jRjCrhluR9J41cfYUfxMV3uze10BxSsYrkOQJ9CC3ngYnR0poinZDxxDZWPlq4TuvgzeRUVGOGmYMm2Lx77C1jqf1iFqbpxHT5c70e9Y83TGxARUxx4ALAEtLUgm0A_UuyC3n2ILOGqenKufqNN_uHo7sDjGQ2pvsXxSi2JwyVYUL6YQ2vc_8UZqQSTH3UVbcxur9u-AVZLLT8cSkurC9ZM68AANjXcCWT2BS_02f1SWoNZgi5a4eiz85ptQ2ne6sWluETLt3ETdQzymyoYl8TJ2biApUt1X8V_YXnSLfi0WZA1Tub3R5Wv13WflablWMfHS7ViGlAcBm3DIs1VTZQBxWynwFpx5aB49xUcLDy1S824z-9GSqDNkvGnsMz6-k01x8W6HR3rHUKaD7s0QPdfa7oS-dPnxKWqlrZg4Smx5vmY6IX5eghsGaNsMt6zMFLeHHOjA7uOGexs_TQVzMbC59dFI0DjTRjdJ79dSEJidMTs32Mh45jTEdALEJEs8q8ciHRvsBYAObgXGJPlgBli8a3rS_dUyhj_d0ZGU6V-HmRuEwZXo2UgeSTVKvopAesg-PbZrO_Z_rrwgSsgv-PrZe4Tn7PWSzzQXXnbGgXscIVY4eqnsp9V2JuKzaM3dk22OuIW1CNvaQRd2vaPhdqPI1C-2w-oMWvgJDhElMwUNWwzSxDx9YNyaXG6l2K_wFAjmWB0db0IgQgQMPnoAvitrJC4mDeYIPsm911D62QKIVoPxXDheVefvAK31CrnJCWb9FA6xe1MoOymR3aPLYwD4st_2YnAh7hBrb5sBQ_ytCVXvJg28K9VRyrn-ofp_7bLLyHXmf4HKegSy8DdjZhunVZyRCKwj-f52TVq9bCqozRHFSgj87G40EZlDU4DqVSgNOUb10AHum_uD_8KXktBv6hz8u8jtDPjRFlqxa7dMFXJTD71103RPRKiBqlJ8_QvJCc3AA-PpuOOeGeJPEtZ638uC-99U3eVNbBTTfn3b8B-a48bnVtWrdzPUhANGq0x6dTgtmKJLkqNqQ1vUQ-EOow-6bAac7xIe_k7pHF9yIWoAS61CquGkYQ0StE79Izsc-M5VObxxEHsr4Eg4YpGBSEs_eSpSCT1cSDFk4C3KoHdSSLdphBaHMhCVX1k5SsRs5pV122NYvP7L2VyF4R651p1OamiHmh6rLIrbo2xCUl-bhRyTqRBxaUsSs3cdoXB30Cx9UVFeXb0hCn-HaOfthRLUxU0qxOfytQeBoxMfRvbCYbMOF0WpNcjCbdSuHyxDszt9krK2AQooKXF0FQsjDj5Y9mQxMRyniKGwTT8GOPc2FncO3l-59Gyr8iw7s0p26KQzRTbVhQQNaQddS9whpIgjLBH9HGDrPT4Z0Uzur_zUR3tvadHxMypmk3BvIRowSy0CHM-v-lLQ7OEgFG-oup-lw1FyFDYT3n3dVW2aAmQ7vtgd5cymVKguyR6OdqfgQVW9w3lnBTo7DTUgLcvNXoJ8TdFBOAMgn-bo1hbtvne5b88IBdY8vSyFT_eHZeieryJ7p7l2iuqYtFFZZu_qz47SsQDstNwbJNOJjd42HlFWZ8Y6K73uDNmAT216u_b9AKCsUCT_V4p7-sOnFMFL8FMzxLAKELCcBeySn16_UsyrfRbD1hwhvAo3mT_uYDuY-uTHg5Unflar4QM0Azcs4AhcIZA8YSRfA0HJPTouVGhbL66jaQ9_8aMA8NfF7lQazYHzT6fYG7dP6vvkAEVF3F3E0WRGlO9uaDv8GJJnci-O6hY8Rd-IiS3sUmyGRhe041TQjXZav042QRQGJQUpk6U-E6ntN1mbYUg0urOWAIEkE3Ma-rpIBdWcWqvCRUFN9I1-dj4N9PyCf0M5NdxqGIi76UaDxmw4UQkl3RHA-_hK1EmvccgMzYQj2Yy1y93sRENWRBbsYqqXPwYTRT-3LrvL-mm-26FwX0w.3qV0fXqRWa18Re_4ea_46UHC2siv-__tQRNOlTCBhJc	\N	\N	HGbqQHcxgV72psvj+bBUitA8419MolpbrU7l6jD6cCE=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	f9e02d27c1a54c19bb2bb2b472187117
3a1dbd66-c41f-a26c-7ea2-a889768eaba7	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-22 11:01:31	2025-11-22 11:06:31	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.SJT1DGEZtphmPHGP7I2r0Vb-3t2ph5PvgiUmjYoeehMk2qCZ6kb0gUrnkleJ_whBaDZAoV6wvWs3DNJ79hr_1zXArfarNAj1bqx3AQIsbC5thhcUUJ_lTnmBDZrQFJoJHdwRw68HeBQewddqcngBgFGlnTMYjYUNt0NcNgIxB2fjr43OyoAGLbTD0y0GnDbkMeiLc5I_FaHI8NOT36g5eXbjvbGm2YfdgZWssGpzhJ7JfprZWGN9XKSDCHooYocOsR6fjxbllKkbfaRSettIpUsvSlzTTqDV7yRGNLJ_kyAsibn_PAIX-t_X6foGpyT5HiiJb2Yq07aGnqhCKMj17g.62sfkdBYE-n0B47qzRk0lg.iTq1UGZGzGxOmNREfGj566YYxESX-irEM6molvnpNd2Qsspgp5ld875fNSzOGN4gUoph7u0zzEBLsWDjE1DtBZPGzoZHoVkrlkTZvA6PL0Bn9ABcDf5NvMslw5D6NNy-YwJHpIrfte7-6JzVp095jJgPdOQHUnpqgCV9mqWLg4t3dOqOtKFg6bzNOMyKqsVRFMzwbHeKE2kHMkJ2GhvlYEzjnXt7w3IIuKP5Q8CVQsgUku-pz18Glo5W1u3Xh5vNhaccA5gWr7EpK6AVxLd5S2O7K51eEZnmxHtWk__C9sqv7q8r3ETR28sCgwBcIhd0RyJCal4WNvpKIcST8ACEnEcYpZI-4_aaz5nRat-TsS_lkcallA37bmSP0oscIcKY1fMH6LFgFwcaK8La8GH2xo2_xE4o9XtN2mlHRpPLD1k_5mOiPcxRDoMEldmZ3VvZu64-dXy7NM2e4YbdmAl574ithCWdl8j3oVx5ORv1ptq_g6alvkTWVT2KKUL0t-EfzHUsWFyzAEzEC1j0tr-Fot8Z4zJKnY7wY-roCXjgGpn847_MqnAt8QtpObCwnWEoRU3BuMFrOJw_OTInMZwS90NO8-chA2JkfM2R6peXvHo6Z-maK701f4183sSFSqOLJtX-iZgYowp5DLI4mRigf4ESaUvjF8H0zOhgRepvXpqy_OZFkKBvZLrspzfvUw81s2yOjITJfQDCpzRhoj8QUbuBegvYdaqtsIfmx_Wyyz64p485Do54RRALxh4XBJxmmZ5zOtd8irGwHbXKNMeFT9WdEncuqBzOfk7UWc8qXk2WW42Jk0nNlK2R_H11c5GfuSLlCDObCI6EsI8O3Wjf55k2oam1GyvrtnDqqq6ezkbRq1hyCcbMHd6XgWpBF2pIST5spmI0JTPGzty6lja3lUXsxdHwkdNvl3K6-MW1KrxuhFrHOYePGonJsvgV2dIV11CjuSMym1c_3Bae0VKaVvNw1iKZYRJzQ1GxF9s-YFUH9-JyN_wbfq055Y1X4o5E3y3AQlVBw1iV7Rvikp7TiK-fabufyUh81SnX39QGA8cm5lG2BiD1h8vzN1JkXtpY5lJS39m3uYhN3tYP3_4WnasLP7tJbp1x2BgShKwbJ7ffQvWQFnJXKMf4wtARdUaZEArd50JYYaTSjUVeCse6HHNg9HP3YvUJBMvAoJDRLsBag2NDfPjEhCxdhUcb9jc-RWU4uTgKzyjJdx3nrkRpMoWdiEXHaiUpFtDpRKEn4KLlrsDYhrfSohzbLYrTeSvm4Cuq_zsdxETRH2Vwf7PwUTfFuvmu3Rmp9dr3cvAk61TWBy_LxE5_BB5Ute5HXmLwqIB3PLtnQMA6norbPXqbWSb0wakvXcwGvG0GpYbwkNzvgGTh-L3hl-qJ-MyxkR0j1GwHPnPtmctQMFmfz_1r6DvxitEdv2KdOZcYDb8HBV48bMlD6MAPjxcKdi-UDkZK-D5Hwu86-f4VgiROYQt7mov68GEwcnALoGcy78I8x8RIzVolnY9UAWvpMYO4bDU_92_kvPvhqS85ul3D2sd5EnUjzO0XmYQoqh-lJncl6LqkXAGr_voT7lAYe8k0Uadj0zEPYPh-DYBanpagihyILAvokHbxyTDqr76w5VpCaUiY8Nu2dtcrwahCidfv74jdnY9nrr_s5ZFYfLhd2Xkuvy6ERD3c_sVeJ_2mjX4mIfl8shuKtwOTe3MFxFceuIKTlHyH8TDoXPHw1CxpvkXmgHJ4YpUHxGXfmmeObAh-xcQh-17bNSn80fGxIUK6mKzt1E0XagwZHJobV39yqvYfl5sc6UF2XNS-RKez1V4DN20UZMxEXzGTJWmh4JYXIfirMZKlpLvF89SDGtI55Go3WSWE0LYvfkS0RNwbNj3DjgrRKUHjqd4Hm7iw1jx9U-Z8reIcct7rC0uOCFDSmkOtlQVDNW6rQ20w4ursJJVBAKrpdXKaWvURLvInIf0P5rWX7A3f2PMp4BpHZ612i5asCz_KfIgOB8aHwx5ANOP9Dd8xKaPK48tzqjpoU7rIFWfocHr5qhwTxZDanB6JinWkBrcHL8XSSofpkgKZI5u9ahHcvKg9_NRTrlT7vDvisWUAYVTEld4l8w_leIqcQR9SJZYTETpb3Kd_T0InwkvqBmIQeo0_Phb82Vk-cQgqr0yH5joayPn49tyENojTEjl9-NtYj_pajrGazGFvlqFffvlnzdVL30iGE_XPOBwDMgZAbcT3peMAsz0C5Z66woMacfjKduL581Vzfjze7qBtj-PfSw6IBsjoTtF0h6X1VaBbSo8DdDlC8qJKLKD2Wcr5MWkoFKfwVjUxSNj5k7wSn5WWXmjOBX6ZMFlJ0Qp5JIVreDt76iyspRpgFEr_z-wAeNmdNANtLs7wYQ2hL28J6Rl9KHSkCremjyKHmnT5neGj29-wblVHRU8Ls5SmqU-cQQ._eJB0llb12JIJkBTwlvvAFgbqV2T-uI0Htz4NrEe0Ak	\N	\N	GpC6j+Golutzp4zHs2CNRNLNzae/FROYwIDbmvTbiIA=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	aa9b79e278554097b7831dd82259d639
3a1dbec8-4822-73cf-a3f0-a4325e56cdb7	3a1da2e4-3191-7923-a780-699387b8fef2	3a1dbec8-2d0c-ad13-330e-933785192bab	2025-11-22 17:27:39	2025-11-22 17:32:39	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.S7yHHkE09pF0urBELIrc6YtoHwtrdwuz55LPKW5mZ-R6i98CxmcFGzrE3wncCk3n5JWTLx5K0NP4gacJV1Ms654J4w9WHr309RnHkI8AOvOO19yVkmHcgALC1ZkTHnxSgiS6sF8cUO1cNIDQ-m_vtBImH99JLtqKnRnqbPngPaXwUPrwCsFTsahPYO6DWjLEne1Tgs0qDMDjIVPDFtKGGczy5SE1dqsZWW5SCaqB7MtgC1gZOFEzG0BBr75D-YxTK6ijKkns-E81kGInZMGPVylrlTBgdhGYzg6Unl65lduf7QU2zo0pqCAtL7lba7_164inqxKi5gzGyBXDtEIZKA.vZ8lmK9V7gW42WUyFIf2Qg.5agD1PB9AlU0y4wFeTqkb7DG4cN94MOOzdqp1W0AZwu3H4ci7SFr3VcsSQiCTdnFv36wE3rVKrTPJSasnIik2q_yNVmvooMxzvb7IX3HnReXc3Ja84tG3_DfxyVxgt0wLVytTZXn-SW2dyLQu6e0gf_caHKwVBT64VOhO_wmJKqLx7k5Ayl1DuA9idOZpAyno7gO4X7N1MG_8ee7VSdWr-bT6tKslH_g6xxfdlAlD8IyAY-B-hIabwWGMBXiHvJCLj7xiC0NW5Exjjkxs6R3mD8fxnQBYHh8D1ZDl5j0NWnLsTfdIhpGv_ame9rr_bdIBU2MjfSuhiXjCLe5w5W6pzTsIqYHI26ESmFE2gvXFc2fP9ELToenwvD42RtxVdCwktCsfoztA1H0P-Su-FPTqaPuUbppB2N_L1z-TRh8msnw-43EK61nXf4Fp7q5qVIt_HOfZ8Sro9kUQR8cs0Pc4Ce4gj1V6IpDcsX-mkUJRGuVeSGC1DAMV8f2g6wepa_AH32IYry6BEzXd3w6u1LGisQ73hINZLZFLyO87opN1DD_CC4pN0cy5ie9wPe69PD5yiVCnPsD2MNJxH-IZAaaFR0vKAmiDM1IFkzdeYzsVxKx-EpaRq_q5fnorbv0RMdknr2NaFsD9c410wrORlCZLp8zVr_PDIg_bQofpXOIsWldVrqFrHoSGJ6mutFEsnUzqdDpG8QrI6P8oj5g61lhPrcRksl696xJTmit7L6ooIWMYAkkKDdYH2Jh1P_nbwBv097FZUeUIVBaIaV8sGoEtCEb_492ZZ8AvC-Qp693xYLMngrHnE9n0uz1geC_Jg5tV1GNsz3F1yrTi_mXWCX67sERT7S9TdbI3aiVDL406Dsk-PQI6rHioV1L9-DaqNvC2WP_mpq5i0gYdoFKLuTr1-WHpknuo0plstVTP0Q13B5D1GmLTLIGXJ2ZcNUJRon-X4hdE9Y9h13ZOisSImPTIjjlxX8wCMHApMQp6BEqBQBzdV-sTpIcMxTjKvB5dwnNd7GC9XrvoBzESJFq-Hfwmo70cEZtYdDG4jpt_onxtiwXT2Df6NIsg0qvKg71k-0GjKAo7r1Y5hfOAOkS2WjDUc8aHk8vnS9DVk0f4S-nb5VFOwTJAmXNCtxsO0Ndqp2LpIdjnGu614fGfzu7IVd1gK9bZeqqDN36LeFh1u9vTBCkeNaULNJSsdQ1vanEzDm8lrvAYAvnkTPIMfcTQc3Qiu_XeyBnWZd7ICuHxPUaOL2x8z49L42Ogo8AP5ZJT1Ctw_mqjfYJTLhE2FQxUl1KJSnIb-6hKK9MVv0XmjphoSVojQmuLRsEdlsJ0EKAszQixn3T-Sgj4sQHWG2aN8y9XV6cOXCo3gpJYXITlp_OcWNKZjt-ZSu6hXgVIOtyoqG3sQzIZVNUfHsAYo-JYgVZQyEZhpaKg4gT0vob5QtMxh4pyTCrwOSqP2OhYY_lz1HdYFYNKnPqPH--l5mY6uV9d_UnROhsSt7LCdkJ3i1SZDyic-vpz5pe14lABvaHA9mHmf9Rxy69UHhkA7VirBnrHl_lVy1ihX8shZkGZWGc4Jr0wRJ3mWyTs8EjW82QBvR9Ed_TQ_4wtpNBIaCa-bPwQaGX712Yr3xV7L_pAcgrqMZf77C78iWs8Ajy3lg16aE5Jl2E46GxMF-xhlSQW0kgZrZkkP40IFlE6AO5EcXVp5VfuwFw2edZas3PTsGGazjWNbuRvjFzQWMk9Jxb8hoq_qhgLONcVSegHZ1Zt-5Fl10EyPw7rllvEv_v4XYYk3jY70YN9o_6TqVIDIt--j6GDyQERuzpysBJOhkJ2EiZTw0DBZLjFiE3D3-14CmkNagDvF4WJ-jrAfSbxM6cUrWuHGg5-SqNjdnXxBsZS0pIEFpXModhWHDsY-Ps2pEjd1JX7FQTJwSUitnXFvbCxg8jZjz6DTLkGeZpfQExw8M1MC_pWhD9UCmZOp-sDjtfhKa3PQxtVetckTqoiueQhNAQMzKtGgM9QDPh_IvPWNf8ZSra2noGIM1USy1XFLCmeB1iNLk5MZEZ6r_Dyr7gEYtpeznjtYiFU2ljPYYx3wJFLmXCbK177u5ihx7pvxRxtxzqAaMmgEOgfO3CG6uOBTk3ZtCyIkuBNp_DAXig0_H8h0-gYWmQOyZvd2xFcVKfkgH-UsB8f2iiQXG7utiNjmAQPpDV_01F147Qurz810mOUEtmpCCtClMkN8escbBG-jzi5Vswoe8at5qF0bFSZO15KXPicdoWqtZnadRZ719n95WEDR4Ap6FraZFDVad8ilR6icEjFBYZWzYcoswBJGlCZl8ho24lMpay5bf-Yo4cfC6riqQ5FQfCrXcUZPbKilfuPOnUJ0uhpFNLgAWt_xCwZjSIwAb4caBO_EgxEktSSXf_2X1ryc64RrtuvHmyu19vYCXm64Ho4gV8g1INP-sDRJxcly1rK1pw5Jg5WbtXUBuVCp2gjLLPIvNG6eJDuoogLD20a7BE081w1aZW9M_5tVsQLUOpxj6Plo9xwdtHH0eeNID1anVmkRxHOrRb8RANKD2dyp2mB0Ad4wu-C4vv2EOdKEjpX90mIkbhTCCXj8Z9Oo4ocZ9J3rCIJcpTklBfdzyDssadLWoln1LFriHLnIjtdZsZ_c7RrNW2O9_vTKU5gUvV6DsQCDMe6rMmqkMESakTMAFXbWBB0dP0Z2rG0a8KITu5CzxuOd_UReQB17ZxEDfGk1O2su35aNS_3a75.y3wm1rrf_4PUDLLKg-qpTLCGu1ZfJpCjhXwqTn1yv3c	\N	2025-11-22 17:27:39.579461	juNXdW5k1ZUqdpXZh/IG5QA+JvQ80qSi6oA+8Ru1Src=	redeemed	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	96f47039e3db44b9b16edb2ef9ffbcfb
3a1dbec8-5f6e-b04a-e16e-c75df53d2041	3a1da2e4-3191-7923-a780-699387b8fef2	3a1dbec8-2d0c-ad13-330e-933785192bab	2025-11-22 17:27:45	2025-11-22 18:27:45	\N	\N	\N	\N	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	access_token	{}	45b3ceca9e684044bee994306df1e7e4
3a1dbec8-5f76-ec07-74dc-521d92a9afdf	3a1da2e4-3191-7923-a780-699387b8fef2	3a1dbec8-2d0c-ad13-330e-933785192bab	2025-11-22 17:27:45	2025-11-22 17:47:45	\N	\N	\N	\N	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	id_token	{}	d13c40f00c5e46a29fe1307e6d42059e
3a1dbec9-8edd-f32a-b3ec-ac282f563006	3a1da2e4-3191-7923-a780-699387b8fef2	3a1dbec8-2d0c-ad13-330e-933785192bab	2025-11-22 17:29:02	2025-11-22 18:29:02	\N	\N	\N	\N	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	access_token	{}	fd9345e2cdbd461d9e7c1848d5b5ecc9
3a1dbec9-8ee4-cf1d-0ff3-cef2781c7d99	3a1da2e4-3191-7923-a780-699387b8fef2	3a1dbec8-2d0c-ad13-330e-933785192bab	2025-11-22 17:29:02	2025-11-22 17:49:02	\N	\N	\N	\N	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	id_token	{}	e96651705d8045ddbbf8bf0635c87965
3a1dbed7-6093-b342-0cd7-a76ffc5883cd	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-22 17:44:08	2025-11-22 17:49:08	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.zJq1zrhqlx8cDA8mMkbBZcgRNCfl4jBBorAlIBJqmz5KWtKOBDnzGshBTvctQPxPJf7DMo70fylPb4S_j3pVDQeYzzMrH3GVxvrXGsbFT_Zzz5UaZsWi9-vG-h-J1g1RYHQQG_a6z8xyS1qXin1DLu6dEkbm3_e6pQM-IiWN3Gez7mM-36IE2hisNEmBS69aTXEsfLF1pLt0yCA12cHl6bPUCor8AVHgAYS1mTNILXfOsktqha8EAh_SrxCyMk4R1g9tlHwfrElofHRkhDTKwDWYW1HLksJiXccgHwUAGhsVpt0G8UvAmmZ9tpbcY7PiJirydBsy3OLOe0JLeYr3gA.r9tS3b5S3K5vzhf83dX5fw.1nPWnHiXi0J9gZkya1qcPXtLxpUr05RY1er7m-AzUmpOxhcO03nlZmePnvxujVTXdCp9AXWcL-vL6qPdgHzSLUh7EkE-h5zVfJ8_zTxK0GWc3S2aRDKuKIO8N3QKYG6sq2m37f14C0kJPKsvPid46BPrpZQNi930d9rnWMSHNM1sWw4Wu_eE_JxifBq6hWlidVQNM4SFXaRZJwmwySIlLapFj5-tUGzWP0LmvYBWisEoXcmCG_NELQO37O0RMrMahuPxU6ziQ_PvJdGmrTnQbpi107sm85hT50uQMwIFP7UfgkQEqkZ3TuWnh2ezQsZpRSdK3v3dA8W7gJ9o9jxFiwsiRa2159dI8HW17Ze08uUR4RRxEK_c1XvE9jFApG1H9ECZF9cn29wIR1T1M-utHedQX8HFylkN5nK5GUl5cFUMDwmwUwlM3s4EyYb2cogLaBQeLp0468hjzcs5nUMX4lek3ZQA4OIx8JTTVGoAUsLUywrMSz04VnzdI3jL8KZoS4DPoj7Ot3tnIpqkdGy-ZlPjVA2O67wnZJgmGSRyzrYd2Ai-ib8V9MqnqPgdag_gHQnamhCvJSie3cWAnYVA8voPtjqhbAEQ6DaomML-g7Zqi9OWEwlIjalFzSKyR6rrHKD6RotI2kjOi3HvVySYD4iYvqUFd_-BDiiQ3oXMDmeulAxf4jtRHnaTXPv-E6FLH-tMhX2RnmBWn7gDaE11Pt5M6mcJ5msjHNzetHRpwu3thKQtFdwADpH4GbCIfsEZyAe16ObDpsNAZnOwv7LT8FBhxTkBsqhJoiuw9XM9965-K7LMCUTdYFDp4CtxB2apVlSCIuSQ4MS5oVCGcW9QbgPwySUqiQQ1poLTrK5ILz7Wd3w2DJ2B_SGIkkmwa8jdcN1VYb5KmiaY6y0dmHsZh9eTzmgQhF3THzwRiZqe73NUVxeB0ZiQZpJX74xNzOCgCdGaiUUK3phXy_el-YlgwvToRd3t-yS5Gzch_cp3UXY1phu1J1PlYXgIdCitmLJCsKFq5-sZWRbKbUdytnS0bPPnK720usY-fCshOQ9aUfk-o98cZic6M5gkOkagxhXGQYHpZ1L5WFXSJXXG_j3BsCLFDakFuhkBoRY2SJu5XcipHgw_lQn0ElLHTWNLUlfCybakjcBBThvvkqTONfmCJpYtAq09vYCR-UqLpCU0sS-Auuq9l8rrgHZadWuTsahWNJrT_KNob5Ebud05TpytXtSN9jafrPxiutr6w8UpuvReCYT-RoiXAhUy2ec1n7TTW2XJw2JNSs7dRjaylTYov1YIM4z9_E6ChRkZc99r86vrv0nlCA-ElJ0eb7ISn2KnvARZ17HGvzVnvWzeJxntO__p5SdH5cUkY6oyNI9zgHcslWyRhrC-S2rGuPgD54JuNLDQslRfoex3s8gJSiOQtopcNYTtozCkTM40cydwLyNd6Z2nA7qH_EzwP_FKVt_KBwdfMTwqTS2PXKc6H1mXbK7vqcP4smt3e5iQj95zeItTISt2l8WqAdeY_qr-A0uzVgbaF3B1n6Miyy6ubW2SsHHfckl5ySbsjQN2r2DjgNPkPCyg9oSPDajqTBjdj_iW4BqzjgtB5adtmSortMiCjFfVrYupAae-AgNESBbXbpaElJ2GVrvq9X79tGjteNwLfvpQIw42GrV3HmBC1EaeU2Daq0Hilx8AKTmmFjIpecOGHDA7Xf-3n7o26a8KcmYvEP899qryOGoHec7r7yzf9LVWNPG1kMk2CnL1lFkrGKq8e9qyxT5CzZXttk3LTYrnRMPxYV-KjT9LNK3Xb2chYqe24rHoox5Wx2DwpNuBBJWWMpR9_grlI_yl11fEXkA7bR-764FJxyFQZ4r4a86bsd6ZPe_PZM3oiOu0UqFkdJEVSTYSVt97ZBEOm4LhUu0JnVMVnYiFyPFYHnLNcQPjkOyI2Pv8m0oA1woZn44gj_NFG9HCzxqDTet1vf2jo0DlbUzHRgtCvk4gxUwSm1xX9TVEfA0vL3pjlvsIwxVpdBqKLvUpPZQYVQ1UhfSbeGU5xRddl4GztP_K1TsigtCk1pCM4RCPmbsYn59h9IHbTQL0OejUfDMEyKpdZhey98gdiI67798LbtqIIKPPNCTiahqjniYAoDHntf3qkZp4vpjmjniXeIuidB7mj1C-zgNMZA6gTtA7K6j6aCurm-iXRQL4ftWGB1X99iucf6r7OiGOdxkzCC35l8atUNLIo63g6Z5S_4jyTAfqQIJNoeqeCrBHWH45zGZHHX_q2NtESlTS1iRUaO0qrCP1CI6dxB5zSSmdlBDasXf22J4nhBCzUeU64ax9EmYKg_XMSTTYS741FxJRAXY_Z0UDDT7OJ-3dt9quDY1iz0ItSbVBOkY9xupbhcG1R3Xi7Vu2lr8-0Q_4MiFvhID5hcJVggmsx3RMT8ayMXTZI6rcAc8W0nmDig.cvFxVad0G4jFW5CWE3LR5DEpwo4qv55pQR60pXgV-gI	\N	\N	R1av/cW3tZNmqqjVvZB6ITiVxTTP+hJjf/eMByIrjE0=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	4ee96872f0c74f2a84934bdbbb5b67f8
3a1dbedf-6570-9513-50b8-42fc479257ef	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-22 17:52:54	2025-11-22 17:57:54	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.e9mDP7jk1XDKudYIRoZk5oQZ7Iw2OzA0j_GH9J9smw4GG_OE-FUy8elTSGuHteosfnFFh4Xt-1-o05au9_O5Ajaww5k2rgrkSMS-yPugrCDoL6IUGi899sHFzCCWr_5Q8m9NVEMUUtwoWPTdniclD8SO0mr4wqkLFLdJGfekmkJjh_UtCHrltm3dd1hLs2RjmVGHuukE9TkMVfSPn5Xjg9XqIizA40-P0liW8J0d4841QNbwiCBkjygwz15Q05bNKd6muQsBqpxSmeLBGW9WOx0tTHYCrWSPr404EMy2cg_H35r5CBpTJZMYlG1uuSQGbsMBMLBYv87xEldWYxUucg.z0bWRhudRcbzLflfqqiD0w.0RBktcspdR-gGIPpf2POxgEKObpx-EzfMunTqTA2C67Gdr-rWO67CJwyEGp7sbDTIbkfKhZG67DwULSQsfz2kAuIycqVAIRBvDvVbKHNosyX9ihWmKjxOf9Lk9fyzdNyMF-99QprSJfbaEF9lCWSYfpmqtTgxg110QchWGaUQdiJIcuCd_gBPOlmz7K0GJKawsB7WiIrRb_kX70ENMIj0JazZPC9EXhWy4uxRW8WX0GFIMR7CbikCNxXeQBThuw_zzRs-S0DOGr9ZCQkPFJOL2ZG9jksoQ4kEaylqmZBpMX8SXPvUtM4OHp-nqADhlmp3JJop2RpS1XMOL_z1OWmr2tGv8R6itU2wmi4c1WSQwjzN9zxBFp2TvucgnexdihWool85JKbWJGUFz7ugWcCk6LfBHrl8SkSyfaKNGbGqTE3opK35m_nYxKtBzSEVSL2kyky4YS8O71gFG_9YKkOgCmDjMr9qi4N69MMbHuoEsK_mCAnG7O3b8xk3TwTbFdXne1N_JjobICtc9F_hh7op_XAy5p2jQKTpUyJCF_yOefe3N5TLpDmySM2QltA9g_pa3a00laWSdK-VsLHIz1xYeM-BdjKZf-JaQxPDxll8H48q5Zoz_nwjoaq1kBmNHl-Q44DytrPgEdxJVR7QQFboZ587QzVXIx2eZbe_bC6327vLr_bTsOngmAkVgWItAwSoPn4_PTvX48n1fdx2O6tZHzWLq70YnYSRKKyyirp6ogKyfxVsFNnndVMRkgKHRNcsn_OMMnF13Kgviery27Vl67LK3PGPTwTrOGRhMP9an9MBPhxIgK8bXzYMCU92JJ7Xa3bZC4hfYtjUflT2pmnMufaMNfaMoB_cmYpeSoHjsNQdYDIVbN5bWNL9ov7iTIdVpDuUYjZHN0EI-hi4MyifBmhrl-5M6lBIQf1vToZpSVJuUcAgVJevfjXSfh7TTHiHPcj0-kr9bfeBZrlx2UK2Py_oT8o9ZdO6dDCTfop_pCddyrs4Gy4O14ihknwUQBDv6i-BTbg8QCRvcvaT9-t9JA9a-X_4j7fRg1xwbg_74CFCv245bqGiPEFfm7eCoQcnoX73aowQENKvDPhgMrE8fZ2DPc6sfajJ6-88X49kjRdF62F481JlEC_GDJW-tso1QF_d-Cl0S_h64bhpTKzNrvwPSUJmVXgjHq8_Xhi7lONfnZbtzXbeShqj-o8kwVP1pKLeqhNqQ87IPv_DJl1jndjXxXHqwmoNcyQhGtBgRPKGfrrcYa3ljpUmoEwhVkxA2zDgcprYyMcj6kz7DUKSqpljFutZyflcxIMeeW6ckFFc0YcMA0AgoyvpWnq912YYVI_6Phzgv5tdXl_GIV2RIFpKgDpl3pd-WKNPccmfkqt6q-wlBD5dskQJQ1rNj-gHl1QXRwkw73yomDqJHm0RhcaiEQsiunuNyph287syHBs-RD9YvngtkFS1kHN6KHkebkc5mdhz6kUx7rY8EBowWb1iMUffgmHsFh5EvdKLJhU8Nijh7amxR6SooHB8zRh3ktQy29Ha8I6ZKB2LoHVvA2LsqfS2g0Yi_AitWNjt2ypBK8XCW4YxPx5JEUvC2wj488dFro_xjiSCjToaQHmNs8UE2kAF1vxpmHDJynFQ_3tQWRa7YqG9cBn1_ideVefOYoqtM85C-m3V81CyOSURXeLDsk1cphlF13pZyt2zTvSBXVXqekFxgNc9LhscfYtDueH58d01i01fODQ2IYk_Y7mBMf8_a6lJd7Wzv8GyVO88W_i9Jrj2LB_IbZdiohmUHG1EsIq9HTmcdZC_3FDPHjgZEBihO3iHrurYJxYDKnJEnDD_DyQbtl1YetL0sXvrY0PyRvCbt7bGJV1dWilMYqi8bmIYNn_3XeCu-UPrD-B6OWpNSARhF7K4gstw8h06-Y1Rr6l5T2AOsp2xjSE3gGCQOMk3AgbAEGPpPeH3KbdkJYyzADAOblEjYeXxlsLHWrc6Dh2ZFZ4clemzLDNv-6xF_w6WFvviea30b0bqmIw2CDD3xNRALvkBdFYAlbupagL2K8wto8XoQXJzqzVxr5TZDRy4ooTHBHQqzq4OjExSr-FapEN116aEf_z0klRr63xvInb8_RyZitXkk1owfx2Pw15thPmrL3O2Dtcv-CjHwGzzYQF7GsDgCs2qJciiMlK-jl1EJ6qpn2_X9abn06swQRTnMQoiuQDe_chG0eRYBIe2-0pn9ndpl-cPG0VCC3c_bf0IAeRtcIeSZ04qNQHJJ08_3h-eG1k3Vkdm28_qB_QfyRkFSi8H3M_zXt4FyeJHcxtZZ5q6WsF3Y-vAaBZwkMMaSioy73WsQo6RKy8PS3L2KwgczwtevRtDjq_k2IEeOknlNV0D2-V3cFeMmfHFbjMGgSKp0bGC0sIX7ct2gtDMlSA9g4DlDHV5B6Wac5rHf0eO7MfIMA92GGrPw.UyIttQawxas1rHJoc-aOOBSHVjRUqepEnNxoN-Iop5I	\N	\N	H9wZ1D8aoyx/YEBq0SHycNKC/DZ+ADMBmEZZT4pfQ6k=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	4a52d98c5af64c9cb14b4d752562d440
3a1dbee9-03f6-6072-34ab-e66b7a74fc4a	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-22 18:03:24	2025-11-22 18:08:24	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.zBr3PwehhM2eeAA3PQ2rraYba6nXGtGodm2FWuQJl_7EB03TDbryNiCBM4Fq185gQpLIEbmaZ5Se_H8OKKg2S8Fk3V3oJNcVDppSnCw46wQml5Xt-K11KxxMsHc_8YG-Fc4eUBRzXRvBxyrnYZMI3hZ_tVfwmb2mMp77JmG-fuhFbVmwLB1h2NMUaRl32ltvCq134P6pBwSdTemvBK0p1VEmtNRaRYTKQlP8MQ1oAeFjaCyf2E36ObyfBfog_W4HiE-V0OcMSjbRqfTEOB3egj9SpXGAEWbE7x5NFduY-m0sxg2wSM0xX9BEkfqGdZUj_uU2wcgkNymAq6URP66HFw.lfquc1Gz0a4d9dD-hEO1lg.vj-ZCtHvbp-hU5fUXm1OkhA_7oOKK4K3LR33JmZJ-msedQPmpeJXRu8Kwc1f31L1dmGMgAxgX3m-S0uhNZJd4nmYUG9PqV8YPkuVhtSGwFLAyrxOZVJX97fsGUiKtdjYpOwlCTYIt9_Z5xhZjziPKa3kMBkf6KT5ePP-F-yCfIzz_iOn9wy2M-hcppf3bI4WB42n4m6wC8sdsLSSxoUyerrKAX9PXtrYqhTfNUMvkn3UpRXfQrr6JKLiBLA3py57Dzyr7RKNf-MBpNaQeISyXSTpMUnBOgcuvVfTdNoPfghgl3arSDWN-dgpEkdfG1pMGq0j8SQ2q52bwoDDrTgOOTNjIe9QrCpdgZgwGIygQLCfvf6kc6goC7YVJuErywKU8t_JmeA7JafgPi50WQ95ddJX7K4FoYXnY43rl15LDKJi2RWcfTCKz3ZMVJy6ujHCBM0ecEuapWLwD7oARQuqTMOiSLpZ-eQCKmx2WGhnnWGjz0Yh4acO0ri4qfx4NajrgYojYTXWeRTzMRGzH36wf4feoZti-GLtz3h6Eoh86y3EJOZkicK4I_QTgHX_AL-wse_SDFeDwzAEQTY_qsxbR-CNuE3AdCK31_oLJWov_UwOSrDocDi7BsB_7LHSoxJziB5bw-ygSWzQpG_w0EibA9kvPIRv8NjYABJrVxPNFgY7TRr8zxatwiMgqxqeuHGzz5_TvEMpKXOcqKatg3bBkCRA6GEJLuOT4XbYOGNHN5Vb7UvaqJAHhICIpBgQY_tN9_VT9JMKhwGxZqVC1ma14-sSCzK3aJRSd8TJknPI7BvSqVyNAedOZK8PZsCgU3IVZAkH9LCak5iAq5lLFuQOFGcGvT0Io3nUC7XrbrqFDKuT0fTOE1ZcAWDFlVKZseCNz9Prb_GKEkShBhradT3m-kAshXdyEqmha7iQeOQlkY4bZwuH8gEYpMWmEaLvrhMAu3K30WfJ8Lx0PjMWgGFfm0lR4WT5wbJFn6XeCShDk8-t3dIg7pNMt27wjs40LcATLYd8mnoRC3UPB5GKRsvlJ9cYgKezXgS2pcYnoTu65-0VOHjqWzJ2f9kYeppDxIbxO_wXAU7MqEcpUSRYS9Os_2aFveh4ffLcPT_iADqMkit7iuxaXgLO7qEgGG-hlggWXZDMljJFwG-CMl9VOjbMDpSOvK68RKQfWqM1vHQ4yAezr1WEnFScDCF3YtDyTOcPvTAy7xhd0pJNGZLwVqCjtHJaHKdsio2LJqq10Vka_8b2llXUufsGsgRLYvx5W2moX41Sc4PDajzX9OOevPjgGvwPyEdq-EnDkOwllik1xvm4BZbXjSbH3sDRN5FBNbxPJOvsY_f41-919HHmOk7rHC2eq5OclBL416xXe2WddTBM8qF3w7sr3yN5jysRj2D_gPKp4gZoRRXlpAaftW9HYwF0BbRmRQLBy_GAmeOdC6k2xBiE6FeZW9kqu1_gDDWcdfU3vZHLaC1eBeA79nLt90Mil_95MifuhPsIqwTsMY5tePWCnrrrV5meE8oxQlgKxKwZ7_pMdB9H86QCeViWNVeC3yR0eTlEeVrykJf0n1fvrXLu-4zAs3M71yoFdWuZnlXj54q0cZD3HZKzNS1aMeh6iaBl4-aiI0WwgcPUCiWUl_ovR5ubesc0dr4ZdDunJz3qowgrIon-YdnJrlIRHfQQAswg_cYk8CxKV1eXe-NkDFufU12mHKjItz_4os6x43c1l5fASe6CsW_N9Dk8VZbkAUc59rgJ6wfiaSwkosqCFWAiScq4VQgCj8GpPIk1hFn6fjQsWUe6tOky5bTwFSrSHqSyHLksyo5QTmas9YPE5k4CBGIrP3W10MCaqTH8UCd6Xed2MnoU-Un0xilz7V3peR4BHe4T8oknrHmXdURj_hHWsud25EP_YdlSErMfB5no3P39_M1HbJQ3zlN9v0TQSDsffN8MaA00uawoe2RRSSKcA2CyYOQR6G-PzEdHsAKvt6OgF_Iztt6EFjGc4gx_ee7oJvtKpo3TTYmii1RiDzOZSRM5QvQU5mpzuOOthHRYQuzO56lXWgrD3-1y61_Nd3oP77H2fTzJCEaqrOvisvCHlN5HIWWZxESaBYyPGxgLnV3SR6ASCyfamFYzT-GrQ25T8TT_uJ2j8UizbmckEx2_k0CEssikwfnSEMvkTiBYIcXj2du2AnqDY3gCzmNQLmVUydZ-PXcThJCKAfI4kHsLUnzies2ih_qfheYVUNA3B81Sg_N8X5ZzHNZqHmTOMwQGfDMUthJu9jUZ2QfXWrVu63cZv7JqYj5xlZ1jQbcMQoHDxeT807CZY2jKD01Sqcxax8_3aejhPdSrbWQKSogSqcjdXXT-OucD1JPp1YrYCyTcQ4c3SrgCvUjZ_hESivfGr_EaD3FSpkd1JjqeHDxtAZygCWKXUQHuaFVc92BNFuoKfbFThga_9nUfGQ.U9bLT4N2Ai0FnC3QXwm4FoG_7-2QHcgqVI_7ZeUSsdU	\N	\N	z3Wj3YCH+h3n4CQMJ0+52KOCw8GrwbudDcMd4ABsZtM=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	c365ba0f9c944472bf711e2337d5a0ab
3a1dbeec-5f33-ec91-2f67-2123cd321116	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-22 18:07:04	2025-11-22 18:12:04	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.ilGuVobrFUPllY3Tvz54KMOxUKeWEg9cA8l3XlTX25O-LH3YBVbciwFaCl29uc93vNvRo7vqu3PtRgTJ5-z3rM-lpef1rP0BWUXHlw2-m7E37eZ6dmeyne6qjS6j7nPPhj1nlFOFfkiS-z6znmMJ-WQDolxXz4XiQRUtgViC6ka-uCuPS7osNCiWTMh5T2XSgymyXg9cXEfv-oIoFiecOmvjo8PyGLE4KncmvjFNH66I8h2y2Wf0kWu4RzsRZ3WpN0BN78OfPpQmb1CnLEVYWKglHlGdyqMzpzXdnAM1cgXjjVg8R_dZyr3jHppUt9hI7Yk1Y-_DWx_0WSQBtvWFWQ.lY-xZjTjSv2Dir04Wr8JfA.TmT8dXZnWErxCtUILlkUkoG6s0yH59ECNvmVLQmsTL-QV5gZprP8f58Are6ovjEXPBZViYsKXatyH_FohC45pw2sY7G2IaBVeMdTBezbIwotliev23iHIdJciNOc0Coj6tkZDghLxNfejBAyQddsDzTdF17ZDtq5F1HTljWmMedz_18GRGKQBE41UVDDymR0npdTKF7DpsAF6ELJlHao4-7f6nszidiNPW-bJlx-9_zSpgetoqOvovgPgNJAI1BZwwSxcYBgLq3VLEgHvisxqLQ-jJntE9pRpiaSNZ-OPjUcZ1TTD8t_IGliSxUefKyFFNU7DqGbqNw-yOE6gVqACRCFiTAJOzmkxiI5nac-lwYVpFp_AAvxblf6woUuuSHSlTCTAHbklvHVStJJO-6cDD4chFamtoNJ5svQ7fFMy5vwwayXLs9xedlbCqo4Vnx2dn_mE4n6alJncUbFJuOhbo3gSAJiv3L7eVP_FkbX8D3yXWiboDTL747bouZe16of6fFXjKUEO39aaqjy2vyYydePoAxVdwF8DGyp-yBmLV6yRSF4FN6ywJMLETc_fEmt6_aqTCw1BVaf6vdC56P9MY2mPrlvAcqZ62j6fmbBXUc27P30Haf34jtDHGpdLmOcFy2U2gfKn72vreFkOFMWScr2at2HuRnwnqUvwK2VCGz8CI-NseFIELt_w-CotQV_5LQL2G5-dGPXh1ADvYFk9pVjq_H9mBFEZeaq-PIMGbQD-M8rkAhxFB0ATbjZrCpxo8HuOjc9Fty60LPD9ettfCAbidpkg-k6Qtr749g-thglCaKRsClhahpnsMbmNKjKYjk6_K2b3fP-9GZi3_veWDBLVPmzzTTRtVt64mpyv6yJhwwkGnkegWhV-dOmsonzrMpld_LXhHscahF_zkKYe0aCtSMXJeC059rwnEvF9ML41vD6g-ivg7uWSt39D1xnKnURSeR99v9GuI3pcyFWAcboI4_9iVKDQ1s5utyXeuU8b96wx6oKWCh0QQ7gsZP1QL3lWNJNIUnsuKIgrogzNFawDR5OdN7MPz1QmCQQXdsX03wQXaf614l7j_UFh0tS5u-0osMG9YhDHRYVXg_lHMAo9v_r9O8lWrJW0v1bDrn30MQsFa9xKaeRhQKeBxHo7rTwyPcUYC66a6l6TZ9NgRQuUxNv3J6X_GO2gllInp8GvDbYJX-EjiTC6ZMyr0zQjlIiEsZujclU7uj3Dt0rw5NS_xP7RU98EYs_vax9_ujY47AudouHMz4fC7-fdvAK-yc0kQyJdxlPrAEKyMIBceeEI5l15GNT9ZPF21imLDNCTScpaKZHYL0AxrpV7YvZuSR3yKDhOWV0s9LtKFEt29AayYZjseoWHzxTVcUuQIOUvPK2S9Qkg1-7VnoSj3eOmr3yewhgqZBRYr5UD11a2t4tbETHMA-vOjnTzYuAx3SFlRfl8Rxq6524GZB-_m9W4kkEdfpjzxn_M5t2Y-KvReO8m93hOC0MJMkkQZ0N8sGzBNeJbzV8T6UX446yxarwmiiduTleDyemUc28BGCDdPlqslNkGA2uSx50KGDTSrk3MSny1PgEczmjGEJmi0deVqQCVcWhtrkLYK7i4-YhlF7kspNi_r5o_ta0fyI3gPuRFM3J0V-otDsOdWIWygC1UCn_-DXltgT2IBV_C-bEj_aCrqP0CGQKif_UUFZHqfsk03c2RLcOhroO_2dQhniX6C5Id-D-U0aqQsGtqirKCdPjKso3hWTLa6TXqi3H1tMZAcfs6fhw_s3gvE2g6Nd6Y-yMxJo7MpaPTLXRKUvVuLJ4mfghBKfidGA2ZraB0biLHYTQa-VALwpSLPst7IU7JOmZBroovfcoG_j67tdV8b11g3G5JZBOYNz7fPBtKIn992QQZqz_B9Mtn0ClFzrXa441bNYj9g_08cCK_PuZUe38xN29NZV-aKOlsTQAmehA7cCtgiN88fPQIKTIkIwr0RzcBWoSB6dgyFW9-e1kP0C4CZCNvkL6OobcrnrD81-4tWEA5PzS7BC9Mkr0Klqyycq27KveQgdNytKk61wIL9DQHqBWRl1CZ0tB_A81e-Si9eIjWFuxPvqWNXuHIQCwV5H4iAA3y8RbKf5LZ9p_Y-7E6bRZdDCgTbXe2gpvrkKMaHpUHmmqV6rmeM2EQtKswjrX2kxE123joiyV3wiUOkcXrr29crubwwHGyJIirx6pBNLmV2D09S-lOCPa-z6vPNE63eLAzaMs_ePba953q-DSo1CMiW3xlqPACqIhOrOcu2z9CTd23ncBOs0IELX3ZXLhPD3dZBmh_W_pTY80fhs-wFUcu3exVjZNzHtXxLOGMxC_8zBh-SaNH7G3Hca5txQLrbH1fvOoqz4pVFnHrjDiw3TSlRdyDsL4X83s3QBc6ptOt1e9Ob-eBznOz6GBhvAJS3EKdfBLlp0A2bo6hA.0gNjPSSeEFYbaH6-B650-L5m2fYHz7wIyUrlvcC9LSQ	\N	\N	mSof4oFpDVR/XcGBvilOM6cYGJqOzOr9WA0Z8VvJ2/o=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	85f476162f53428d8e21286e20ad7ab1
3a1dc3a3-9bef-e77e-bfad-c9b8735828c1	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-23 16:05:41	2025-11-23 16:10:41	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.ef8gmPy8aOdwSNe2f7OJaj5WfRNbFqFbDDaonpha5be58vsLarod8l5nOtVHJwtSBMN9USgfDzPL1nj9aeiWn11pkfG_n-voCI4oK2sjSSqqzF5Y9i0efodPFS7wvkzy0jz7mTfQG-_W9rfGgBUO8JX8YqqSbHpXZx7GktlMgGWtp48-kLKGVPcEI7GN8W6V25IsVPk8PGNvjPrRP91xp19AcXMNI1qcKTjZziW8azTgRtaEcBJ_NiQLm4rXdGCXQKw0X0urZODpqghS7kGItkCJrXhQqP0ilh01RdIlyK7FN_kkrA7oKWdtDo-dP23kTC5G3hJWZ_djEWrRm-919Q.sH9MhyNpajExPkUel6ji4A.7w_M90haXDkL9WT3_dM4vfMD1YeowGZvA-a4hcyt9ND8dahD3qutng8aNoEIGGyV69y4_L8b1h60CJUI6KR99RQm0p0hy1sKEaWIg_ZvhxxKT6toMivnJWiN22BJJpyRkRzjQcIfZL5qnXUez3BPjhUZDnbsiLoe8NXQm5APeRQFhqtiQ7r2ATweSJ9uDhrFzseZsd_FZdbzhMUSUqV1DRrUUr_hA_iT2DQS8c97MLANlyjFep1eWfvWARqA08LwX0olsroIrOUkJI1dwwHrY4ihkSRMsmJTz3fRXZtejYPd4Qup9oUjgyscVHXz8wjEeAey7XWtrJm6GSFgARNDABYcKiwN_UrQB71gXhi8QNeWT8XhiE1B7etDYWPBQe2EpqfMPqr7wUkfsamJsMMfQXCeB4ymVqUFiAb4UTqph7DWQQGiUWt8ek_58GPmpkV3UPpKJj9Ev04nqY56oBi_MKZhuec7rIrwfTh8tURYjBgU4p6H-zaFNj-6c_vA9lJO6WJmOc6W4f1uD_lpFCdOAI_TFMlFl14BVy6LOKanbbMb_xg9-yZXYaS37NdowJNA7TsAf9XnCKpYPJcxKwXnPRgTvw_q-3yJAayL6c3BAce0Vyuct5CoG4TMzN9WXW2G2hJ3BYyYnzcRHlBdr4CD80Z1fCbLenAB72xcV9laiMa8E351IwWVq_YaDolo7Ig0zj4hy4hC1zCIrjuLX6ciS3W5R5tWFY73PFfGtlJGRiNvnVvGJuAPV4sJzjKHwCPdQg0ifzMXKqhkiRMdK6jx3PKKBYCHSbcwGEYZ7UflIDMRk_qJNCDPPoXJDFSznUGv4uX6yQzArne59JPL3XRsAFKEaczHGErpyQBf1U47kVlSu6YfVaqQcJ_DN0rSrVk0ExVfOx5AYMI4kJ5QDpDyEMz5coY4mYXgyyktR4bKl3fUerLqGqLU2A1ENDXiIFN32lm-wTj1iLURjqv9Dbxy4wCkGIm66jRb3NKkiqvlJELl_J599MM-7Yu-8jibaVRH-gBe04gITs6juWrJgEr1qSUGUt6WVSwMqEsUds-FBjctM0hJrnrHHVS18lHMgIHbQla4KT3ozPNRoEdbPBTaTsMk7iJkS-49_2In6is6p--3rM9Mz50YaBOSBP4POVCrc4WA_7mnlI0e81DIWxaHXBonN2nk8MPomHGb4ubqoXxIUGHGL1TZK9Ew0hJEjybws83NnOe__A816J2DkgargiuFA_YGoW-wy6f_VMJJgwQHUmiv-urkdPumx9MgtyscvMjNHu88rHWytb3kyRX3S8Bl7-17spuyWU1q3vBRHRoEyWEEDM9uu1qFLzOco15Q9hjUharQp_fsQIk4Ow0L_I0XVKswSycFyl2vs1eg-06P_0oI7fmo2Ox1Lwv5377sbNXk-invUrTO7gMGqRzvRqKEMnnYYBGiyNyYWSx5kRJcHI_JcsVU5UTIKL-zeB-PfZ_8J9eSIohE2eXhXfbpRouXZ8npqM1mNGD41Uc1szhvIop4PLRG-1HlcpUFkGW1PI-aXSLcC7YfcWAQQwpdpBv77CsArwdX5XTnLJ6YrBcTUiDVvV_byFAwuizkxTQo037SH60jHKWF7RzV3yv3KvsixgtA18ZRlHgyKLFbGHAReI00DgnwmJQQ8Ngcn-3zWDzazldf85PxnINXiycyMXKHScYePLwIp0jxvKR7td58nw3N1khtuNWGH992bZx_Id6FLT8GowKygPwI2ckZn1uNwtZHjrrWJT6G0QjZoU83EnQE6ytlhG8ESAOlC13P4IUX045ARSY7f3JyZyOCbyze-64hDN8aaDYCyhVnLP0qsp4sSxMHRXx19jD-0ESQOnWuMux59KrBxQ8bk3bSjyNBvX7oSrBXgyqT3PZvDkOG5-HEX1OEBYhFj3xHeBkahUorsx6vfBCvuoA_ToMgGrywTe7b1ebRyMpIxw-2KfKEeKEc96wOfDfmLy-8EBDybNszTx8MRYRkg2psuPBr0zfD3i1O1SpfAdaQwq2PsoOf7aCxq_s0qQXaJCaQk-PNHpBw6gb_HTb0aSEkKu_cvGTcXwbHVHZ6MXHO388Rlv28Ooo5AaYkYbvwTWT2x0lCp5rVYdnxvTSVYbexmg1IzzPJGedBuXcHgdCJLiz0nnr2zoWvMQj7VYDrajjswffXRk7zIBOWkxL6zVllijVqnEobCcmOK9KjFSv9J2XjWUb8ZMLrbJJ0nsz-zs4gpobhg5qRNH3-EAQ9XFggpDPezGzc7F8KdoSEwQmqnz8m99pdqeUJc6_aKW1ASkSO6VL0rGkfvS_IP81MsXUhlWbUnWqZy43V8voOK-ho4qzGRe2rIU_NLIhzhQ9PQa211xqCYqA0yB3aFUjO9WxVWWKHr5zrV0Wt5wpHiEUxFack3YgHmrD0jzhExaQKYdK7LOrRswzK1CqogCljO966XanfWg.9w2gXUGCA_IYl_FLquPb9sBWKhuMnjbvzH9g3CC1lKg	\N	\N	+BG792GlkEvPjDVAl4kVMGdm0IiVNQxO9K7nd/PrTZE=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	c7768c6c81534120b58b312912a9ffc6
3a1dc3ab-2b09-cb82-6fb5-f5c712f08085	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-23 16:13:57	2025-11-23 16:18:57	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.H6YvYM0sEoORxLoPehYvKHyr75fVVvpcZuNDgycGAmuRuQJLR4fiBQF_DKoQJEEbtwjLj6NNs_eL0qQPhuwMchPBG11I6N4dS-YQcdodBMWa0WqModPGTIKIfeKItShBGMIUI8pllZ63M57FEg7FZ0rYtiB7l9ejtCA8rrDarLPX0axJd-liQuZK87EnXgMTVmT-Hjm8LYCQ-hj2OnCu8D_vSxt2OBBBYKomWNIX9TaVIFyq3ZoC_9pDzDDW_0k08hXc8Es7iYcC-iDspvQpdGCSc5MYN8mqBoMQdfpiMkR_rmCd8lyyAbjzJ2L65GiB72agf8KQ1OlfMUc68Jfa8g.IS-IOENDo_pc1MoXfL6WFA.gxRbuwr08B-Pi_DIkymr80HyvsWgYsewDs3xmISmYAwfG_WojGD2UeXlJkzTeJboLU1gspp1OWFCErHhK-4eG-N9tfa3OFVLfGiDDLnQy3DjlIIxf5hIe-OqUlmfbXmmiLxzo8AqnMg0ORWVd004Tb4xaKLW-WL0YJD8yuxUNzV4WeFIxJAgcFSOUkmpzdc2Mh4WBbjsFELRWiYeRNPGw8Vv4CiD0_JVMa6SsxGIg2LsngAmVqrA5JqMA1IOlis_sGN-hUs4hhPvZ4rxSC5okX9Y84Dnj3-2h40Nc6WmojBPddIfxKNOly3MWOFwhC78g9rLnH-Td6LxyEvh2tAiYBdveTHktguzH2a7o1ow86dhsE8pEFBDiqtKeHpqnUaH3PUVRm3nRgXHKex0GHPrUKdafZ_I4q_qHcD_jk7Fezw4SmwDTBW4e5jP_fz1NLgu3Id3TKeqxbPUgLFGTKtSuojvrR6Fi8j5bSx6P6NN9p7Bwxn6kdlKjUlsgtwvjh2vHTC0wzyikhZwB2cUKhogGaGbnblkDwyJa8GrjEDanVKNyT6D-5T_1LYSXLHZJfqJPaOLe2v-MkAL84a_Bn76LnCvb8bd7avtpY7QQWgcWZDv4zHlVkIErHnlPVlyzVGbuRdYKYVnmd3zKqfBpyi6AFkv51VERc_FgjBkn7mxZwVt3FFr3Uj5z-V0-4iCHrAm1Ux4ayffHBjc3JW83ClLCekNNYLcYKjlMihvyQ0P8sbZ1dneM1gyiIQ_2lgQebpaNLaOGJyjIJrxEKxOXSn9NriQm5dwZ1VIEUgyXpUFoo8WdOqj0LnM1i0-gu45rfBF8eOXOLLpYXzkjn0NuD4nXNkEbcJ39PRkz8pMXdDxWtNwp4oub3mDn7mXYGvXX7hYYBELaMRFFS42Jg3IfnY0gm_TJF7gBdihOsIHPxL5UqHzyi6kIhD7_qd2VG6O0ozSbZ24793QPWFoEi6mz-9n4sjw8i4jZNZpeL4vVC4EEYJCjScf1xwOrgOVgNnjJwvhGq3syPvlJ3-ASe0safH0KUyEvnj3Y6wn3o6n0bpnNK21iCY4OX4qqt3xSlIoyBaaxW1hD036X_7ZH-HsKk8UL13mvS_GqFfkXFspfNgWVRNIbFDBlg9vcfzT9RontZTEdFsaghvB7gTtFsOIc8aQHk9U-FxrnoABr3ytlXcZvT88nBcBz7-VW5BCktDj9JECvgqDawcp99-nZgc1o4pUsmOCmfC2t6Ra5BMMBX6NkC0r1UhDrQr9gW3QhOZCcMNX2DHFsXAP0mrcmBBaARBAq4nX286L4ad3YvoNvMCCEXB8K1IDgPZXpjFO_iI6yNYOpMg1zyzuAZaEtAWkbhWiS8Fh_0To45Guny97wxzf3lF7iwiYk16m27sckgaZqFk5wHFa4523DUoqA_9vVyPDivTRPicMPtL8OtKVUzRUQAJS9hZm9dfUWoQ26ldphlT3JUOLxsAU3PfCmYcUtd7_FrIuXZVOLSi_xTRMed8lHhHpMi7oiUmiz6uDHdkLkFZbU2ARN6t-tQRboNwq9bmfz9nPQAlo4qsbZyA29oZQj0tNcEIRfJwQhqQMbXIFEcwXZ-wO0nmVgr5VFYgc5r6hPbJPoIqgkYoNk5lzGnCpm6rOBp-eMkkmaY_F0fySBxO5gYztMqB79ZbTL91FlSgBC-sUn2aUfGljQMx30mC3mn3fG_uyU9t9YMwJM5OcjPQnypgnInQMC7GavKahu-qD_VdUwv543ez9OMZF8S2_r0MLUFsifgz6Zbq1xKCcVZmxd-b14VnoCDzGz4IQM9c5Y4_TmPUDUQSmnxHpUqKC9269c6pHw5BhMg6-5_hhH3FI2-RHa6oTGVjn2akClu4zdaQhyv6UOP93LgseRiHXG1Yd34rTRLOZpAayX5JBE8TnEZ_1mkfd7MigL8G1wPPvVYRf7nIyzaWlx-b-CIZoLcqBDzLsG40pkF0pAi4Hn1ruCA9caOdpmdfkKw3e-fkUr4K2gLiWjoymcB7BdhlXrZR7D0zZyTctVdMlR5XUxb_MRXelDYr9n2MGtAuXEkD5fXI4Zd1vn9vI32lGPzmDASdy5EVXFyoukIZIDV0vBzGkyfBBznd_bywwKuE0jlZCiZxjvcxjea5vq8FTAyReQ1DIgu6UEq6ndLcX1CuNXlVXl_fk0YnDGY83SyKUTPGC1Qc0p3BeyciTBtUAWNqEknvqVCS99lCzCFIvqgnB14GnOQ29n_pFo0V07zR717wCDE4ZVfPN6JFIEQvSAxAOJwXnqGmv5Ol_LX_oqLX82zkyw3fQ0mQfBAvQp4UL4SVNmtzRPUT-lz0BJ6Q_mokq42d0LlKJ4ZUIvgj8ckBBj4dgqV6k3uy7gtWJ4Tk0pNPNWKcTuxXwK_3qdv3kEqfj4wA_nQ-Qsc6bORh--o6U4N-uMJKkm7WPzbZ575E7e2oTmg.UuWKPlnUcIGA5wc2jI-LkAMlJKpwZ-Aw9z06jxLu0Dw	\N	\N	iU5uBiuwfgdsf1YhAuOPsYEiSL70Mvb7SMyspakOonE=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	96e06f2d10f74f1e8b499e69357b2e93
3a1dc3ab-aa29-c672-58d6-936f3dfb081b	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-23 16:14:29	2025-11-23 16:19:29	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.sDuZdMpgGXBxkvpg-SwIi49MTyNslzBxMO8bVbxxf_TzvENHJ1UQDuEHTUjpjCkkpMHD-cgnbdWStP85vfbCQ-MA-ZWGUFn9mjLbHA1zjDDfO5XL8xIu1aVHhNyBZZdhl_RIj7NzIcDyHkL8p_DmXKID-4deAYj5iDeoSFyexujBZ3kzWQenVAX8zggYd12OnbHB6qiHh5ZQGZ9VKtGFSfXXxtVxjWFe0gk8R7jKVNTJQZ_UUrA0AvmKOyieF5YrCMtGT-Bqy9NgzcRbBvkX_JXGiuDwAS2oHObZrDXObq3lWxKBCjyvgLc_xse7tBZjUUXXXPF072JV1DufcjedEQ.rcsgJKnuTM7AFlaql1tEMg.sYV-eXO6z5UXkfEw92fpYkF1uLYuRCVB6s89otVlIO8u1OqJYZUPikakVX8-uHaEtFD30RJ3z3wJLqDp1HGPNy38Tyu8QjFJTYR-65NgWiZoLgLoh10XpZg_NA03bFUoFxK-IRvd1PMJQk7Uj0NLBZX996oYHR_x8JAv7eHhdeESZd40Av7RDGfOCYVOxxSzb1xKoBWQWx-hINylVlNvpFABWcDxg820Irrt8nJAwr9bVZbOzK6BP_XiqRZOB0HGgWONdlJMRFnhjYe8fuMLlxdeXl3KlhR4507P3oRvTsbJE6sKmyYlAfldhPDtEUzlvMQ78nm1VFCPL025YjeyRr0fhXz3T7WU4s4rJOyyPErnPBCBXRVhQ5OUOD9spfKDIDVmOUBAPCRLJHfWTs6ssfvi1FGge7tGcPW8UGxw6rVKPj25m2Q3vK4O4GAHm0PxnEF9nmr4hkfqdDa4KzfEFLrIIPrdXnKTU77twN_InhErYNSgssRIcboBEWFZGbEVANlPKr8PwuXckqw6mK1IJHNI3qDdP6jlVU17IsmbZBP9B7BM9S7ZkBGd_UDI72WY95A1kXW5fJSdbS3uydvvqEAt3RVE4QxT03B401QY0-RCd0t5_lqSNhr9IcWuWtawpi29Lp6Lylx3_6Ub5eHSCDyhuLhJ3AQB5GYWA4u8Hrwp772pC8NbBxeiwUWvux54zT94oolFomM05R2FigRe7zf6iuMT0clcFZdtI6FlPAr5M0JpOycMKsUMwO0DEoPqFkchBpBsM8lJn6GOrcENjXJYg0H4pCM3dl1bFRPmDvVt_iU9dqFzv9_E3QMCOEFeOA80hcDeHhBfPHfHtdt7UEaXPJNPAZyh1h-qM8tsGZBDXMeAQQnQOMjtuJw1dcN0IRBqlNdVwox4nlFYySGJClaBhmX3Xo7Z_bRPoF9-e6NXgjEPKYRtJoblbsjpBDCSRqPQrAYk1FjBQfDwohXezyGriCZbj9mzmeeL-ybYntn8JJOzL6CsLl7xRH3M3YFImRcpHWhfWjggedca351uUNvAVs6qMR9pZeeP09TshXa-HqNk9kntulbGY153muRA4XUnAKS0OZCNpTfm1wJLVQd-fGHNa-GoswRv400R-0Kg9nBmzs5b6y8MjNYgIAmytav_iqDr4BqkkyrNoK0MdkI_PCQzjDbq-lYh2jrxdu439oQwjqu0gkbGJ6QbxA6qUC6pkMo7hTgeXXvjm8Tn6vLD7p8X4Gp6-2jog9TcjxjTTekMsWeMh1lsOeo7tp-ZyqXbFNXa7fVsIMHg7hvRSpiBBoFR0tabkmfk3AtgFfuPtOsNwfKwLrG0emoOsU9UbSQ_sjqz9HPT1PH-FUI2XhmdxbofGuIMavqpkSES3KDbbdGNu3jgmN-8z0N1rdiTOTB7XFdRNp914VUCARabhfKOuuw7x92zMIqgIvGsArIp6fqWqi1f6jgHEfxiHNxkPsyczTLYU4wNE4-wRR10ynKZhAEFXDjUgWqr96ummDa1n7mMH5Wqb4YFNnAOQg9tlL4rXwlmA_wJsaUtrX02IuAENmaWoS_hZ29JtmGCkkLIpXnk7nf9bR1SEOu0J0b_L2IMa9r18bzIs5Gkv4ZjGAc15-QbglzMqoDLdy7GoVjUjche5QPH84dhjoLW59mnPmu_VDhrijvpVjDlulkuyB1azN4NbT7BP4tV8M6UANKIoIb5gP1aX0whO1aEePVnS6H45N8zXSF7BNSIuYTPpY_Hd9zfl65fTatHM4JelZcayqmojigtz-jA4exbnRSHccCaerxeXelEPgb8Ae4RoluxtLH1tVH-MeOIYfed0_eUqgb61ppt2wYuPSaGzQYW8JMCe1pPP-S5CkeTu33C0lpyw10zIrmirT7JWOwlLjUX4BSGBBTfj7OeDAbSvMXiGymtO2Spk0SJB3WPH1fyB3FqE-edm4n-FDzrWeczQaAol7hw3oepG9BblXwN4dYNaA1oOOFP0i2V6PuPwX2tvLhR7cgRdkLSDp8u17ODIW36kUro7AkI8PRO87PHUmagHeitaK6wkbbTFPFBUe7F9nNcqWy_fBSYVM9m6_XeZfLQj4-5mx4FKhhMots8amoSQWWjYpDIzdIlNMFPTf9Bf67ywHa_zveQKYPPl1zmxaI-t5csKmbL_jtEby9haq2M4wH95vc-WnLTyJ9zoz48kzMobqE015KcMYoj4iiaLEIeXOWNJkna0I3mJWBmCljFyHQFoyO2oug3Un-9Vuk3njyxxJr-pI0633b4MXhIvcIrcisUG3iYrB4_YpPRdGR4f-2Up2pmDcIFz_RwvojRqFRsUjQzODhXXIW3F0-9gzk8-JtFKaUHiWBgWI7aZNrQIOcB1qvzTrtt5MrJpdUJ1tTnkM8X57AC9h7Rrd0dDgXHCwpqJmqupDCHuBJ_OrmsEr8zSis5zcug7ATp857IYA.bJrBvqMYiOkoF1FrCnem3-y0JhF-NT98yB_BUWZp2t8	\N	\N	d4k+Fmd15YVy7p4I4BQNaHs6ABMJUNigsuKrDUvqqX8=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	d2ca17e0ed1b4a58947245edb4274048
3a1dc3b7-365f-d4a5-243e-556aec838f5c	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-23 16:27:06	2025-11-23 16:32:06	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.EzWpV9y61WuXTch_Uunl97f8WFMkvHHcWzvkLjdX8iuxggYwfcXwAN0Xj5EHejjsMvSyS_3Imz5w7CdKFZ8bHN72Lsjz5bW2-hmBFNXBdXPBhoF2XDVj9j95AG2svE6oQrL1FERKNHIboQ4pQgGLW_xIYvdxbtWE187pR5eznGHk-OyZzPUeknaetRQjeEZdNByeHgO7alk9GzYFKspt7jSJwptceYJ16zS8Lpj63Qya3nOJcY04CM432rGaLWZB3I0x-RGDDLCIQ9Kx5C6RxV8HRli41WThhYjYeP-DWjUbGc1S_6P29qZqfzt37CpB_mWchInsIfqUxvfJSrElJg.ghCG37bHjEkjZnq4rJ7RlA.upfaWa3gYLvWvfHAORB26GRalYhRMSQzVpWLUWlWUpHWdk644-ra7gy5CayHWoPuQFBFKZCcC-avBsp04mHJU8NLtE1DQZVe9oRgKIkgd4M3ajMc-ZtgJHxS5RuY65SN7qddd29q-Bae5lA4VYAa37tWoqTTCwOxT9z7UN2D0JB38tb0PAC2kbgr3Y5PS4RhqwImS4CIcjfSpHn7RiKS30oI5YL-kLxjijjjuQUswFBP1nO27dxtuQ4y4fyC0CmiqE5qHa5kryai2OtiBgz6cs7xvHCIYDzAv8XPt1vDBISFbnzfUmoRNpK9JTBKL9HDLu4ncZv7GjKYlFqGHDorai2XNhjYwUsv7Tc9YLCRWsk3_ylRmSyGTc_H2uoBy6ewM3qvRuiAbnUe8TJR6_kkIzL_xyzdLvHDeEUIyahnX7fS_tzvjHLn4ld-qdqrsYGq4nyWZAYefZihmuO5Pz5ZsTWa1nSLXG3k9Mx-otgXRQ-F8OyTLwkaqvO1GV5T5r2MAPVbjM95wiuyRDBDaqbLAHb7gSMFzkS9Cxt5wiaFfan67D6L-EVpa9RI-1QU8dUKhfpPiwCHn_8yS7nukrbsfSb2kCPaZCVsZLoFQldrjA_xB6az108uHcEQ6r6AgplMwNOsMfp_iCs6edHNYd2RNP7dua6UxNueUlzLy9FLlbMjB2ALAA8FH2uSXAxq1qH6a1gb_McAPtM5jVJnTNQrzQtbGW7tICCNF-ZV2iGWc71zT8ebY9uFxY0TG9irP_UT9l_9qF-xV1K2FkZ4jdhk1nS4mqT3cjpFOibNrYsm6VAKF0cuF_5Ffpj_sPZvYIlzyQlDj4rgCGZ8hmqcObg_QN-rTvPRnV0bsm7MPnJylrSIvymGXQkccsNXg3hk5Rbz4hW7IqFP2OOBJ9ncQM2fugqeAJuHrjbm-DA7B4OCYh1NwabHanghV0q7MvSXGAT0T6jrj9hgV426BZ9h3hE06S6-T0fPqhNMxwr4Y7RfX9O_idBJJpu167tU98k25lqepPsdYq5vvNfs5gcoLpjJiVA7BciAJAYHHxjHHlip6yu2JMZlPwc95uCwVW9S5Tf6a7opaQkzEdBMdR0eHZJhGxVeWJVBbiYOao-AMrHaYBiCZYZyl3xv9zMYpr2u8-VcpvCDSsX0J5B0raBbhp18cets3MrleEETkLqPQeyV3SlnHkACPYWXlZD7fIsBiIioaQaDL3Z8pXfa0OkmGVajDMGSu73aOZe79AZN9EBjQnK6rjEGKnpFvcIQZi6dtpsKD2KpWASPHRC02sHFRdoJy9T1vD8WWRxB9k0nqylkwtI8RM2gcnJQdOwma2-IGIg-5xIRJtHi7rC0pCTSEpEGpoWsWB0k_HPkUCM_v6GSadBwYOvgcnNUEtUrp1lRvcn4QnTQ30kZ6qVu3GXGEAKek563dsFAXWlRIFPX1aUDLnv8FSuq4Zf691_A_ABWYD2JzxDG8EQuV1KHPfrcfdtTdwbnYt3vGRo6XfKSOuVlcVo0N0AaYQs96SW7KVa3m3RA4Wz2WAokw6FwLhOyeXlpW91jHI0BAB4hG4Vy2eOVhv-3r5UWkfvxzTBldA3IS2PFkQknzCWgZ-QUPllQSqEYNotQIqCAmvYKQ-6IR_CfdbQjoPCPpm2jEG7GTQ6NMOd-veCsVi6mD0xEuhGr4kGY0kA8g9P3KLdnyt7yUrfBDzyRYcSpBU6ON291eUJlF20Jhu5nLwbWoZa1CmwAIkHnDDDTYyHikZNii5girINP6McORauV1OD9C1E6h7di0qhafghxHlcMmB3FIJCV-k_O67U5g5jKR5cQ0rMb4ndAi7u86czlGrxeUoUwa5w4_7H2TB-POA-JTBVM1PSpxO3ZT3YWltaKlfmL0LRHekqDBIk_p9pURDOr6e1SOPD5aCBnNZXw4bHZ4tqVk6JAt_sCtfUo_J51pdiW5Yc32mPwWcVBmchGjgrFBWz2fWscaEcms2pwPAsJghRnJupMo4WEoHvwLxNNsCrGjO8DgTpSOyFGcWuqInM3cCUHQhkQN5s15xTYkYaJzirxx7-3YO5nevgJSsFQaD7qIu1MJ96GxyFg_xhDvtn55s3owb3FaLGn3Ue3quHXjOhBD8kJ7ERuhY7lefLgoeZC4ocRwLMx8XFCzkcrV7Y_hrW_vo46WXNuUlMko_kfgBDe1Tg7s6WqNVdkaevvVTwEjuXfleyce9dFWYHYxDaymvBK6H8il3-DJgJU-x4hA1WuSELhESsDGXz_O4LJmeqpa6y0HuVZcGvZGCt4pHFNwD1GL3GyPNTvGAY2sscqwDCMAK1RrcHGksGu728i3i_4iMhR-Gw5Gz1MKGF3CIXiDEoNnX84qE5GeLkILhXSHwiqqzGoZ0GP157Pm4tRig1_x6r3gioLiZ-VrdblSLHTyfIsTKdTaeEhwAvAaAlghq05dK5jMQ-uYA.iVPNsdxXOZyTIdUsHT_h2b-fiBAwjr_BIZmJ_9Tyq_0	\N	\N	6NIEjSSZPjGM1xwiA4OkyYQFa6k6ZOTAtgUYltYTITM=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	b57f0a7521424180b96f9b977b327946
3a1dc3b9-cc22-5b88-09b0-5d32df7d4c21	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-23 16:29:56	2025-11-23 16:34:56	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.YIVucAaR3CROtnbz6khYl5gTJFZFd4zAYQvB56o6VmiDyXWPYyYtp1siXFw1Wu4KKezbsKfSaS_n_vP4rUOoh6yrhd_xrZ71HcXt08QoTO9S2k76Y-GuDQwzwExHmkS9mJP_k9N4yKBFT3amfhUkmAbPiKcTC-C8CANUHR3sGK25ehzjC06q5vHGzEwlqJP9JY3X3q2K4w3CzJcYVnMV0smQSRRGjLQ2d2YWshsDaMSTn38SGBcOLDtWJZ1d_z6eMTDvS-mAxXKYQDrW9bmtaCgssjNUi17H8fQSbXTHGWjRAoC11gAp0WRruIxy8sBM5Nml1ii-5hLgMb_lf_Q1VQ.MLA6VEG06oorSTuz2mrZQQ.N-9G23UGCsLKKeFBWWZEiQMvjUr5CyMH4JCBvB8YhKumN4m-b8J_8fyhPi2Fpikf10Gx7bdRq7fseeqU03ZwwgK39ESd-mK0KosKlFIv0mIqaxuTIGWtlV2d1Q6Q0kerTXbBB8ecZcGP05AjgAOE8NLi_PQCQUA6XwuOTLJwBkYQuhvgp0YyoAiJNG_0nkNm2wGgJf1L61jWkIHU28zYftIeEiewSZITfGRIylTN2XP1naSfpS31MPGfSBJYMvs6SBgE-pdpprNQ8uPNsPVOmhQWuFlq0LytPrspRjWspz8LQd71cOJV8dZvV0XCFFBlFSmOeX-7CWkSN4mPTiG8vKOYYHSJIXWT8Nxruy7m-Vkcn4j7o9zq2faOb6zfF2SVCV_2v8qzBJidgN_U9s7n7OmKOjHlawRLvwupsoUKz91tQijKbMsV-hiDZpCbJ5wBYgvQ2EYa2cBhVKFyyFaMGueaYI03LtlyjcshMjIjexj06Fy-A8uCumb_SU2T05TMpbJ-z83C-o6iB5M2l8dkTQRdzZtHmzXZstkDw8Ma0bARqg-236Qc4mhV5hCWpjbcRPRCNcxKj41yh1iVpMKAWnAvTbCOhWyhy-wKF278BKkzq182l_ImmGChR3S49M8ZFF0Cyj-K4Ou_fTmNWRjmQrxIgLlZCWdIXk6enoW35PGBjpkdUr0vSMbtHwC7kaWYG8c4r6PN4eN-bXwoxQ33k4yiSp5VVcsdUPMkTf8xzo5bz5qbjcz3H-lPXF8h6Oupta1XGxJsG1g9QXZKSATEVOZobCAtw1kmsezM8QCaAQUFeShHGDOz3yCHSY2Vfpm9mICNZ1FMgfXGb-naYaIMahh4qqdpOytAH2v-bE4Fb4fTgcp95BKTPz4BM05jM-BKKblmjBEliFwYuTASwXt38ZobtmR44ztyQyvp7qIJMFkT9zvkG703crHYvGJWD4FjGTiRIueJSQ-EvbZeslna1XufYVGFIBwI4HKOlmdZTxwz7As2uOfDTztWPY6SMM7gjjmQXzFj81mTwnpM6VRl2qfgVrj-mg7qApb5rGeqmJOH9gyTiNMsfLc4--1ajeM2bIDizMx3mVqNbSKk28JBNodvliEQDrLrVrDJjngy70jxz78ct0RBixZWxt0g2HQ8U4TnZ9inmCGKRl390jJPEdt_ELPtomFdLJ8uXesPyQKI_55902fJQCidhgci3AhsT7iWCnAjXiEE4cD591QOPxj5GLqAWfjpYo98Ay3b34DgWU54ANLLP9FwR1kAFZ_cw2ZCVeYuIo6k6NLKt6fWBbINFCnZkYDySdYe6jcE6GGRITsEoumkEwXbesH_1_llfnh2hvIFANFUKcI2mbmOzQEKpvFyYnAqnYGfku-algW68681F2iwLQpUXH8uwrUnFB-NqiEzusCU8PEB3A-_myXGCP833e2YQqYkfbFNkAT5CA58L3FY_p1zMBFxOGmTrnD-LGiVP0osR2U4OWbmLM6xQteEDAWD51SSJSOTx3wwqCgXYM2q4YTJzq6ea6Yl8dYx_RodXEGgrzGQTA15kNJ4KEiZxaIivE1OG1FIKGquA3V9fce4VUi8dTfnbmSp_YHUVobWUeNGOoryKmtQBFPvAyt5OVYblOZVidtrMdyDLdIc07lv6ituVQ7Tfjs1eL2lc01yg11DBAUi6TiGv1PArSnED5jVcxoYrNnPpWMVCw9UNgT73U93Ha1PxhO7AJeVmYFxd0-zK6w1SzeB1Tfx4WPUOxMVjMoo25TTQqFL0SzJme7R0deDnc4iplxalUL3amGHJb0eNhaymy0Mu2nZEW_29QXOyKsU0HByTWLvswicBWb8snPwYyfN7pGfm7s3cX1rYGFJe6feVGASLH9XZH-RjuXpmYFLHF3vGUFGRUjWkErhz9BvfEKj55YYx-fOqXM5BM01ODKdr0hNpOq_I5nlKpsqom6PqGs9IbO2t5aAU3qNZr0QZ_6LCHtLI6oDBtSmzHeQBhy-3m9vWEd2sIQOSRxhhxYh_I9Jj8Kh7nFzv-hhWj7R1q2ZYVTvZXIOstNfpOPG--jJsafRnDaSCxdCgm_dlnxd1CIS-UGAmM9DpdOn2Leqfyx4IrTO1wsEIfw_X2_ZZZDfHkB9-7myjMFBrbCOdA7DAwo6-1s9wqFZZzgL49czDZcqE04YMSKCdA81NTu-TZmSrSx1D83hpw2fQJS_S8RC-Z1gJktKWj_K5bNH9yQpMraRd0LQzSFPpepPrs-njWZnpiLhTWF6aIq_GjgWbNynnuOCZSWqaN1Y6t75QBK5yUI7knAK7DAECWue3oqlye6xWekYDls0YtAWh0M7uC8oUuUNJKAOYgGnkqU-7IScHZYxthu87Zckvl5fnSQfNDJnqfjQ7Y5Uqo3saEjkoXDjLjT0EyiUi6pmJa6NPf1zWy3pBf7JrSYm0I3FXGuI9CFZHb9Qug.WhZLrh3xjDJyW1Iib84Ti_ECpNSNKoDrk62Os7s46Rw	\N	\N	AUl54poFOgso+0r2tT+GOE0diCpF5Z6rxJAXn5hDzlo=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	cc71fa0ad37c4d739b48bc8c77636c2c
3a1dc3b9-d8d1-581a-8bb2-610870628cd6	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-23 16:29:59	2025-11-23 16:34:59	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.Xf02XvpLxv-4c62LGBQd4fiEI6E7RrpNRKx1vRvCMM3prkY-HvWyPdWaSm-dxlugZEf6JFKji9mvg19Ytg2YED69eWwQPzHTdialK_AtQddapVXOVt7mZ4ZOAR2ZkFuanDl3wdgGKs9LjHPo5GuWZP9bACpUl8w1civCNzJYaq8y1gmt-d86kQvUJDxSTtQCygj6aZ2mLYOOvxhK3T6is0wDkgLKwh-V_uPbzaKJkD4c2A9u6lVQg7uKCh1SCx0V7CwULvWsamRsc-56ZMxKHVkVHkEEHH16Ouz9mhRPGavC9LLXlZ08mJyZ_6OW7oMYq0HYYj50ucPxo4pH-HdHvg.mEDi7Z3M_CgazRuL4U7GGw.eq4nfRzhjrVElIRS06OTk0_iExUITrNRGbYwQNtg3NlhBSVSa_TUnKlKc1ixS27289DYYZjFK2iAkQOp9kNUyUu2UlSoX034gqH5AM-gIxBYH0VEP_GJMqruMz8sRUzPFiVVC92MZs9J39SYiBmG9ngPoWWpAvFt2BsC7TJh6Ismw50BgBVXGe-kJGTezbBZ5a1jv6YLxj9Tc2lIdskp1-nC5TGHVTOPfyActeEfICETjLeiviUo4u1UDF1OMFpGOT15fk_awB0EN7C5mt7dDgVpHScuHejeXVTsAUxEPtoOxKVmm6Q85d4_iqZQ_q5xuZNXpooU0k-PXIlgDuUoczEbogpu2hlCbyzZbZAGqW5gOS-zqUyfFyo6WIwaV6Biy4fHBrFYfBylUOozGADktitsgWFQ6c7YTkCaWDT7RCJJhVoKWV8_kGRtiVRRBP6H3h8sUowwPZwtXaZ_lyl2H-nnzquJpwCjaiqRC7E0Nia5wjqrodKU4LDXXuTnXjtHLI_llqUsomQgbvLybrvk5GkAQjPL1ukZOWi2oR3dOGYG8nKItGgQieeeWBNM7PJuJxpRZFUHexyhEYWnL4i_avfFRO68vlQXYBfBQPiejXodr3hU7x5O_9LT42MlCfPZ8PR6RboaIg1CVw8V6YCOSZHFI5Ykw_rryJTzBUgksTW1RlJ7iCnscssMHVUsTwaW003uDeyXA8iNz5dN5qo4hKY5z4nBTNnLt_tBJVNF9Q9ENgPBcWYHuc8xLomDWePCiyW6iWfJohv9R77_nzBolRQsERtaFFZH9Nkbqq837SPbF93qyfEFOYE_IFU-1qgbmelKBYsO2rZU9_T2KIQOSDNcVvgqtLkG91P3r6LpgCT1cXf-p_KebhtFls0JkXGxOzoi5OGTerlbtq5xECLd35hSD3YZtwTIBwHpndpKnrZAtjaQRuHNhaDjIMElhOxoJm5b06izOgPyGQRsGhy5twemGh6aZnGiZKhAy0PJsYPz6rLluDxoAb8d_Ilzl6eVh1qTSLBvZSAiOYyawpJqaT2skVJRQ8awnTaD4_lunJEXace7eUM1jK2UcpT3oPNGS52vKJtpd1TEc7Lld2b_BNVaFwX0TX-hyLFlFStX3UB34pzwPjbGt2omUYf0dlcA-OFGsQ3p6osqjgIIZu8BwC1h7k6nLQKDLaE6-bH-VWjn6zLEzgHKz6sBarRAfM8LxsFXkQ_0fM7g8hVePN5x_M_og_ry9u_8X9xtCpA6zZGehH3w984vUds0IyzbQK4WhiXJC4xxt644cyDauMdo5o-y3xsLW-DdmeWNsJz_Ir5YEIclYmSyhgYLOiQ1FC1qK9n7bmkoT_cNBNFfckJvM2KrdEDTUh8qXvAit12guHKBUjz3C8b8-MwDSO0kjCe4K2Dtf5zm4izC1bHjivf4TzkbgxBDeX_ZhhKaITvMmV0Cp7o2Qc2n3alL2eZYjJVYG7ecAm9sNyYxPaUARhrNMZwbLAGG9FYxxUkl09tqhl-eagqUvhTfLS5nzdghMnQmcIW0rnhu3aeGdOBqzWmPZvAllsqxQhN94P6vI7CyCsbYTZPBXkckCObWe1GJ8INkfsn9kV6ZuR2TqkDe3DosXylGg92iDtbifZrXyVxp6sNIvxKx93kq4WfmAgY-tqQR-N7OcbpiN580b0D7FFjaKzrA33l4Mu9pPIHpeA5Zm9Bcu2gCcdK65gvyizhYYrhTuxLrPZrrrbV6LBoTvMqiL1enX2CIzZjIitECFbaw9Txlu-Q_d4_-FnC52hZivN4toNmjH4skoltx6Yhg8Sne2ZEdJXI7gKtF2yzYsb6Jh9x7iTxRqfOAjabZPYX4AURa7JzZNCB36QAvHuCd54cm-V2-vHhB0wNlqxltMrirgPLp9Qnpfjom8nvdNwDnIYPd_8BfCGtG8QejCYZA5BSOybDNDBpzA3CBkbQQjqwsQv0E9d7Z0aBZN59H4Gx-vNoJ40tRPkfZ35v3D42AkGiiSldNYbhXs6WQGexHi20w5QLUBNTKphPzmmgnW7rJ5GNBYEVTk2wV_wF2iw8jpONrbeLxSedPOJ1Xhq9c_Ivlnfzi3ScXoGJhGg_L-jHdXrKYfkI4mZA9Rkz81XJ_YEkqXpo26J9nbJ4wB4ghdv_8-CdfX5BQWXZPHYU4G22cIrIr9WulKf77ifkiYIZggGF6zbKMZCVmBNA09iAuHan3IJOJ5tSNQv7OWuSSevrVKk68B3OsCAY-ZpQ-fTrPn4wjVnKxAF7c-I3Geza3x9TtMdPEBGdcP4zrQH9QIgonlZwuDT4XyGP3KmM7x6CZ9JqmqHD0Ex_cUZucRpeNm7navlD_xhTCTfFVQjaPBEA6m_c0B3laoDd6tJ7MZP7QZaLkAG5dBAqPi3JyDe1AbrVyTyIu_Ehb6_hK-ah7sGgbTopC50wtFZ1HISRUSTo1RSo-5g.Anl6xyE7WuCFRqWAqM0aaOJDAJZl4_toO8S16V59f7U	\N	\N	OjjjyMXoAyqdxTxQ3KSlgEjlUhZwMom53mDxdnvvoiA=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	4787fa10c98e4635b08356e9d331620f
3a1dc3be-9746-0805-e932-1c2605730b6e	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-23 16:35:10	2025-11-23 16:40:10	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.KaaWaCEuV9pSLIZxqimGbGFXj28wF4bPq23jg2criybBJGWcaLUwlnkzCvk0pTReSU_DsdUsp0K8E4Q_QRG5kRsVqvAsDxIGQURO1SHOUg7Q4ax8jkUgkF3Bqjr0JNym8iA5YI46JBRyttQA2Pv0PxbGV9xceSghFjDy7384JgY7WqMLQai1hWsJ5mo68wqwdDTEdR08w0HsybaHEy_iXwV8QLVFrulERHR7_QJoWfwYq_bjDPr4Dua0ifgGjItIQrELkPgxEAWp1G43E4eaxDKuBjzBE7QrjftcwMO_FT_izdnCC9JAYfZKDTAOPWeGLntx6G-ah7BiCtm_CtW5OA.MiqkuunRlV3Uo_PPUefgNQ.kxbLU6CjjjfnFtp-rxe3BB92I9ZvOJH8EUJKcawyCfC3_OckZWGXORjOtfDvqqwhJi1vlFkF5mx4Sg6fpCeeAtTZCE0IKv0wqoq7zmMOz9Wm52q2NeK7ZYhA6kH2HFgQ3OzzC7vzMIJJ5VKF1x7A0fIaor91FjH8KRjZVYKWDs9tRf78P8nGl5LmhrMseB-jCF2A2OWoLUCdx1xR9np-sQOe_zRr3LziTSaFzPICdfTcnqYo7JVxrf6szZRxomt2XVR-5tyJ89SPW6jctj3765_2SSrODKLTmNOx_aAUFcSYjDNc-2mKyJnNGa7ZfZlMCUmaHJws7uoddIRMjQju6EMTdevJ4SvVJPHDY4MU4yTbtVWQmM6WnjkG_voFHwTRR2885aHkSUhRPgvoRfHVuub8cOZGScF2wRyQUhcey2vSDiQPQ6nF7K6CRWPN63VeexzFEHJG-H2qum1uZ2-tj353rpIfsjU7Wi7APKfaTslJE885T90uF8TbKrfU98TpRJIp1u0GG4NgJwyk9pyTAOZdoGrQ9Jubtc4ugTPdWapdDH80TuFYc-B5KGJD7irCDLk9yAHtDyQBTeYUPMImuwuAdFZKPAkYmOBBD-alDRMWuiC7oqqvNBvvDKBiBmSn3gDq5vx8g7OFCHwv5nrE_zP8tEkTy_zN7cpSO60FZ_nOGXk6MYuE4_E8byEqdEnNl8sWiMf9-wo36oX3wy53hDhjX6UCPm-Jycl-Cg5PXdUZyXjxu5q2ShLU2QB0j4mjs7JDUt1ySkOxxg2V7iskJFPieuhMGx1q77C0X4Tcqw9Pl_D_n0pgtJBg-NzLSn1TzhIfF44nZ8PZ3JckDLUqYtP9XYEfRQVhmSJq-GXMbvOyAYNe2IzQTpf6eug6qk1FJ1-lXPPO9hfTZknw0-ls672siJEihQRiiBRZUJTqHGT72XH5IwvLl3Rvi07AnJ-hJL5Z9kOWLNlzQQL1CRXwdqYOVUgJ2cqUNdNqsH_5stwcRT5DVWysFWm5Q2G4IP55ypDLQU8l1dQhtRsxZPB3BBe8FGet7iAw8pGVpVzzSnSOv89NqdeP3qYZJcOjfB55GKsHW3nfdPS_rsGyGGBbl2bm1YlCm120ku3fPXCoefi3Pj29TYCTfXe1h079Du6QNU0DhLqsmR_NHCHEboZ-T5f90TUdOomkJuGfeRIJpQONwy9r2RnAdUb0Rrsm-CTdGvuQzSxRzfb65tK-INBgU3aKMsQeBJMgPY_VsBqJVHVMvNUgyjVhcVODUuUsevbloJU4Gd5wCHIfHtEWrGGWLLqA2wsk2ppsG5mpWV50gWV2CLgWLKNCOAHNkk8iiL4wGASXc_qV6utuuGo5CGMm3bELdyHKcrKkA4elg7avlpX8qJUmJzyM_dQ20O_g3J0Rn_zxDD2W7K6M-m55lAfrBkzXoH7QyndECvaCDo63fN2QEpQCiD5U3SjjesUrMYDl5BVY2qyk_D_bQXKqvmjRo7DWYW9R2nzI6twKoe-WaFWUD8Y0Wd0S4PwHXi_eEsJEkuONCngfl-35sUPtkKF8_cuPH8Nn7NzTc7V2MDBacNqwFTr56rr-_bVdex5ga_FTYSrMolqucvbEd35IAY2_-UAvWivE-w1zZsMlmCTku6OUich9FacMRLg40sSnuaf93-oH6r9K9KDY2ji2ALntQsJoAnEfbzS3s4pMLW1hQC6EJaN3txOahaHR1lQOixOc1vxidgcSIOVIfO8B3g7g-5uEXhnLt7oPU03AiVw9_whKLwCa_cQeP9Rli1q3Rb3QlL-oW6lHvZOeDoSvRnRHAvcsEPM3LdQndwq0eN_4wyDxdBnhin8KWnE64lqKCDwZg7Cq1YIEHMQW3AM5C4l3MFMhjiYMmop266CInTI71qeqp1EtSk9eGRbjD02khfukN_lyQWbtkpPMVtIO4aURMo2EXoekvkoUDXecAFzN1hFrIEJifaEpWFDknospVso7sqCsZLy_pf0J-_RYsZ1n8b3nFG1weak5zRBOcxpz6XvlGBIk1yTwijo5jlnZxDWPQL0cdDsffn3xpjBZOof4BvXF1CI1GRsEngiJZPRd56L_cAgLUkTiu_ohDPKFEbTFWIA1vCUsdXiS9AAgXpTxOrl8z6uLBp4xV0LCdm7VZCB9BmpNYx-yiMzFOSKQgLUh_TkHy-U_kI-y6ijKHpnzeyPuN47z-TLE4I90-kux9dy3mVtdWVqA-utXTICpf-hKl1rK_gaVhisSHHafbhpAoIUXRw9F8EXEW4S78JOfgpoY8T1IOBPskYblcac2dPEYSBBaaS54XdSusWWzCD9y8bi83vulMUKKSvYYndHij2zWDqHMkq4BRRI2XpN9LG180qzRO3jOon6PN5pRj8w4g-w8fKr1bKmsYhD6CVHDXTxEUVoCkkeQHfHxe9JTvZTQhTJuq3uysrMvRGgWUsg-Vw.XR5IS6U70e6X3RX61aTxhJV3DZupskwMROuFaF9PMhQ	\N	\N	mQU6QUxDScwNSOwwyl3VS5UjV5qnMez0pN6Bnjdb/iE=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	58243ce9db2b4e7bbefe56f876bedb90
3a1dc3c2-1b37-eaf5-cbc0-e12d8625f5f6	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-23 16:39:00	2025-11-23 16:44:00	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.ZJovflDWltsL_goNyJfE6KSHi-yeEtp0Su4QLPgCDq_kA6gNmYN2F4kLWV-Jh5GNy2BOUS0FhhZJjSLjP-EFvAQnPUl9mEx5OhGuZszb_9FDe8FAj3jBUTe-ToLldsWHUGAeWzuLdcaUJctFKkqcEYgy4Gkijw-lYRB34t-t5ZjQZ2U9RbXHyO1gJzgV49mCL6Lgz8xf1Kve81l4d5xWCtYfSGoQAY74giR1msjOfUmmxJ1fc-5B33_-VA4NLy6nZh00he83obIw2S-AR7rIFnlp4VJe61nP6bH1197wcK1wW6xV9Zkkt8on6MouAAPAvC-tF6d0RKE01Zk-fD7pwg.ivxP3QWN_QLQ5pOwRI7JGw.TOAQ22gR3MbJsK_i7sP66YyH5Y2nUUqvtTyq0odDU9s0bIpXSpyK2Xs_nciWUhFMQmVpBz6voexyZH6GUjRPWyQPqb6H9nPp1XVxgf7e8q4n1cJkwZKxt48zQJP2AUuoRODSJlDbM8BD5ihk5gJIGpQpj1enQONmh2TZJHlCnKA2ilZz7q7n0jzYX1yr_J8BSTzKsmJA_lzv93LI6cnNyvSB7VudhmGVOU-Rtezf18TFMZ2KssBdZssVOY76qdYSC8VsC6GFWlWQLYO9bW67U0yQ2KyTLsJn7fkSDKNSpfbOmN3JRGKa5-1jXrstkfwUa8ihgzBAhAtRGaVMAeHIZHUwwCa6y6FZhlGmg_5ivk8BuOxvJ_-lXGUH20sfGKzEpbAkBt61S1ZgEn_EmXoES9pV2gmw_YBCzY5JihM-nrigH3d3XausOO-NQBT_-htxjcO6RaSp-UKnaPOyn8qe8amj4FGMRHAbOxQhuEsn4tzlzb-AHJDdtU-H1tbMFBISYi83yz_rKVdOAduT-9T5LDOHR5OP9qkb6hdmxzs6Iyt1vQcvi50778BS3Gsjv6qb-nXnOW8fUnP1K6eHt-3eP2d5igYBVqEPAMXIMrkz02EsY6Th7bJKX8C1A6hQjcXlG8Mc6-ke89p8Ar4AMLExD72ERv5CwXEPhZvWAAOcokeui78-3Ai1_q6eMHp3K5iFYSHRbChdhHUd6Rb4HioGrhC49SgiHFo06ugYrKzsVBOg7eijTvA1rCyXsQZicUawdpuxDNNymRb9-3Si_EpX4fK5WlSxBl9LA4XMXUw5d2jDdE9iyrIkv-DPQ16zhNnBFCA_-kFMSfPTPUcsjGhxotiyqKB6YX_GgqujXbIxbetNRPUG1L753zz2zWeEUn91mdZFVi-kymWnXgjcUuNujAzANtjRwZas-SDnDo6qOnW_VqNFx6SPv8p64yU1sxecTAEFDoipVTJPRi_GgK4cvssMb7Ii2LENN6oCr_IVzwwNVs-aZQmbJh9CpJsnCrfbr5-Z4Sg3TVXQr7joAeN-ObFJssMu6b9tyUnsqAFY4v6iDpyYuqzuHhfNKl1I87QdJMdPFuytYLG7GQPQllCu7C4tucsbybZjzYE3ostFpbgv-xlinN_AELeKL0-0_VHWh8Dd03PG-ggCrf1-Fp7XfTTliBTggtu3W5kmFB0_bsIQK51c68fATT0JQn3cNkvcV9rgz_o63SnmYEtDeQn7HopN80BszeQ9tZxceeHwAXZnlp0NSkcU7JLCnO7Q-tirnHZmiISCkid8TrjkOUpY7hvY21j6yU_tAly02vJNCUm5LvzNDOO9PjCzVQPjPSSJmpZy3jlEXDGAF4jbZB2VRBaBLVtwty_IFMSAbREepfXnKY792lppzRUjpYQwoPm3QEXRrx8WIhZONZXSBS1hQ9uC1XSixJ1ESqRZ2NBJreFnCD8zdF35uB4_23bhDL_cLzEBRxLXmQR7eBko62haXneL-rxb23k-H2tt-tF0pmIP_i19L0-S8TZRUDJXTF0Mj-qKsgY8Eb0-Af-iBY0rVHh3F5PAt_sJcOWoVyQVYUYBoy2zd9ADH2wcASTGKqMesy9GtXn6maPOceY5GE0DenobUNXeK7-Zv4ztuKCRKGy03iawfiVwH-u0fhJRNcGABQM1FalneChqtO1IIcxUH4u28oHk5cwygBTiVBiOu5FDyym3WraxIJ518_JN-qJq9PHpBxmX-sIH_MlcipxVSQPbJTyllNjxgftIwDM3xyssXfv_IcXVOwJW7jksginVuOZpIgJiMnaGT6Dj6AaSavKlNWCD6wQoCMerho0uI7UsgHQPwepvKOQ36X8eZl5JU2cRLqfV_GeLU_cIxEBVYqrttOYEfQgrjvJq-1WFjC5exVlsdS3X0JmEKe7zTKkZc1OLHGJh_29sOVnK2IbUsFinri0RUxbIhCNk0iboJpa2sOvT09FNWVhmxdOi1nD7QGbxrhCH_4Q1n0CPUxM9UNVPHlcPhjd337H7gDqsS9G3jpBqHVRIMp1krj1swdZALuo6TKh5STpTgAIMvbL7_SGPcQ3GUU8QofzBEkpefXln7cTpqvN6seVvnGXDuC0-cAiW1XeLmYFKCm1Rsd2wmDIeHsydDBttYWP4a3b3wzan3j-i87mGQD916GWYwWlDgdk6CuIlyEGyKGe6lsEYNVNyJK2vQmyYW74nlzff0ctJyOnt1V1bKVIcnFWnvy0Jn7m7-OR6mTPqHpcl5OHurhYn0Bqgs62kiwThdSB_ZyHiRgmqqkK5_e4MBvNyUzUbRexBXAk2-UyFhrE2GVapjXlFDYRJQ4ND5wG9Y1ISmyjxle72Sa_I-9FujYyA4qnOToGh-O7ovIIm8cV6qqL82DQOsDVxu4g8-oYWct38vrLxRVlyY1cUGSiY36jnzRj6xoICDIOz4ruMxAdnpgF0XA.hU3_LI78McxYIqKJ9C1xk0SqLY0zdrN6Amm_JHGi7RI	\N	\N	U+BX/UwIZQZA9N7WTM2CVsZqS6W2Z1JGXRFOKjZA22M=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	7126376d0db941479b6501692d26ed2c
3a1dc3ca-3576-63ed-44e9-72eba4b4c613	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-23 16:47:51	2025-11-23 16:52:51	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.GfCMLIJix1Znm1saexp1yBJ8Z_6ZOTJOeyJmyLSpp-6H_YQr_ULrbSeHXgvb6BFnJtu11PDRTdguuB3UgzOhiwZhBy38bR1OqE1j4P4z0xLhO2mdBlPy_MR55uJcuGgnRfNVdnrBuvhHa26poz8vAkprbgThImAET9q-8X81itFALnFPXJA2CLy0iS3Hbw4E4-oJPijmS6D1sLTo6rVpKI8SeUsBV2jJm0ZpiXaIFUu0_fgVTaRVSbxsqJde-hmf8DYkL67oe2dMFoJcXt1aUQaTVfUIlG1jRess1YkBHEcMpZpHRuhTjDH2FgqG7DPH-ikSg6fIndY56oqEKyo6_g.1V2e1PxF0e7vwWJVSV20Jw.oom5g3LP1-p7K-fFKDLGE619StWLxhLAMoUvr49ladypEVp6L_bwiZxez_WaSai6I4IZuxVQNTBNFSg2HpFYG1LlBHoPtfrO17JuoNbsrZbfECFcGwYQKYMzF2fFz6HL_JjJBHS4-p5aBMRtVopuCRtoqjz8dYc4WEAXccIG6BGVlAfF6w99GPYnxEQ9pTYWNkjKUyUTg4RR7lP41OBB1EfVexiFndD8IZ27BSYgR-1yoUMojSUvKB6DZTl8l7t91LBEldR83QPW05xcI9BQNKi9547RXQgSyGfmPquRREzpkQpXqhz1e9WFhhwUnwd6wQ0rn_Rqhn0V9F1ju-IBmIiVQGlO5EyqX-2ovLSR3snXaciqwgQo_4qJvwBBKJuVmfnwIcG0TB2sbQggljl3qATdR_SDsVacuxdrwcWM0uo_-Py1Wc-dnFoZrhvOt7JeuDuXxwS_V_0snymuWN8CrAxTbNG_ehXHR5tVKFCIbudxg23lJWk33_hmAzJ187c4-sWsq-cm384SrB8bAPqpZMy9A12uOUJFVXXVBG7Wnb_RIJgY91rfC7PJkyGHlD0CCGx_My9SbpCV9OkFt6x4cxK_iqn8aS5nQaMJ9QJagvr29KxT5Vlqe7wUjyk59OGDeLpKljfKGaq1-qOENOZTw6R3OtsijILMtPfq5gLde0zCbsc8Kip7RehfNB9BzInvH8F5iJREj6bxbnTr_FQS23istdxIs-2RPhJKWoWOPOnOAHBvdaQ8bu6Yi4PZrDmLWOhKSAKE_hhuIOON9Wpjk87R3vSJ4beyMzADt6OWSKK0-P0pG-i9aQi_9Xhqlb0hB8OuG2wH6Qp0gppZtzcZA2PaiGsgmCR4tNCL_ees_fMlKwouaTkHkXpwh_2byZA-yW7hGScK-ujVVGVm56Ax-IQm7mPFF7xO6CZmK893c65c2EmFoIwILpngQ4b2CHo9joD9VkOHMCMnydOArtOkaKylam21dJCbgp0KFVBGC51LF0DrJI_TMsfD-ie0uZgBFW6CohBGE18X5XagJjq3lhhVPAIwYZW83ZEJpTvJsIk3xTaTjPj9lYs9cGdoZrlrL-jx6n7flRnLVkbYRlLhb4KR3jT3G6PU7aNfJI7cX2EYkurZLhaxt3q7hF98ZyMj7hvzobxpM5Xdjxyf_syAL0_lbAkdR55pS02mIExv8_BCCSszgiw9Ya8le4sF6gDQq39V9DJqSpnH99PqadCbOFcoqBAUHWDjif8bNeqBSBUQfwfgehP3BPXn9CP97zakRRM9qTblFy3NBNilI__IYAFVLWjGKJwEuFbn3elq3OJjpJxwYA2Lan3i8yFZX_12_D5ctkjLZCZC3RspSYa9RxRwiAPzlknumWI9nRMYoygwO-WeCs8nGVobfGu23TJ1EkZMKPIBQ43UiRoJusO7PD5ZmzisYIMHHd3GlPDhm2eNoTbEr3614g-zvqEud_trb8T6B3pgctbmXxxB83tA00P9cGXQO9gjiHsweBhYChBr_oqusXL90Q_3OUqZicy2t5IuXBUGiEEGN_xYyzD1UqMVJXQZcwdh9JCsHHqwguMHu04z-EIzOXX8vWbR3B01n9TYRAXEZpmvIPlmMAeo-QWzceaqgAIqla8Akr65Abz6Hgshbi5Qm6pGD70xbRxLxmSrqnr_jN0NsqCZNnpzSMiknRC0CVvuJT83naLqysrS6xb_lkomNU6DD3ZlXOauDS_-A9jRAMgOAQfkw9b_D0vRMSlHJW9Uy7M8OhOeFGrxD0ANddTNZntdnviIYcOunAczi5flK5toKWxHOS3LvkcWBC3gSt7RmEOJZNdTfIrpLrQj6vQVyzCcbEx-iwXhVEBxzPOphuSinE7T9KvbtU0NZcjHgvOyGmvUeY-5iv1fSSe3GFBSow1r78lmGWNTap6cXm6iSZQ34DsnOMZYFRq1W4Aoj1v-yRwpJRtxj38xB69LEaIh6vsXSHIgq5iTON05z2PIJbNLbtYDyaF6H2wEtadXPJprVltzlzAaNuEGIYBnh_ovCCX2oPXmI59fA1kI93EFwIZFkEpkWMeFnTxk2zXryZYjNOZI-q0c1nu2tZ4F9rYqLfSg6T0qvo7ttM6V-4DzrcNI-gAQuprJ7vgFnjLS5glZAVq_F7SRDhOJ9razVxCI0Nb0nZRsXco1dEevSWYYKdEyQ4oD1MTYjkRbbdWC74fRcumbhnuArDwQppO3z0OIHogFbW10AtsSztgXDTl83Z0CuCqFSNo3M3xkBwPrKj2w6ukJHXasDMB-5ZFvyyslbgUJs--m03ZTbD1TGO56KV6i8i8JtCdMNjCyH0tKDM7YrYbg6nBZAG2djbwOiCAcVsUxiIp4CQ-x0fPp-ZKdfgEZ7ywsPqNDzsjvbFra8GTu7k57R2weoatkw19STPAJz0rTPaMi_IXna5zd1RiKSs6DdRwnRToR4A.lFaWHuZphTqhMXYoZLdILMwkTdXiQ2l6f8g-gnJ86Dc	\N	\N	X6nTvib6PJSm8qpNUC2ceXPkadWJ0QvVhLj272Pobgc=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	38eb8a1548474d34b847aa2f9c2cc544
3a1dc3ca-c121-ef3c-8802-2ed44ef27e8e	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-23 16:48:27	2025-11-23 16:53:27	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.OFkorZMtMZUFDredZdJCHXkOKBVCUGsTKN3bPvKtJPE4O3M9KXbAEBwYSMYDTclimzJMmhMR6kpUaPXyMeRxmGSRIvlX-6FmoowAv28zsaI3iVlJC-QxsxttpvUQOrgDqEDvWv8Iqj2xcNyJi_yr4Q7X_jShyiiGj0AM2LreAsMiF7qyqDl76fhJ6228rkEvGkAL3dGKapXRShFPxijgOwIRR5bggvzIoTj-RuUngbpc47k9W7juNBaCb0cCb4QjVIP47HcxXYSLa3yO5u_0Ae18p49XCYTKOkA1mBbkIsJ5Z3C7Qf2Srhegdpy6pW8v1XYvBvU03m_80-x4pkA42w.rkGVMp5YN66FukgKbbJIGQ.aVc5lBd4j8gpjvFtBx68HH3sSSB85iANpxcdnfh9u4xJfXsyLkHZBCm78-is1yQImQqQ9uNj29Nvc6iHm31sS6IgqMULTm5JRMpyomQasfgkzXRhG80XMMrWcvwVa64yPwvTmftGyMOfHzUjUNGzAa2NzGjxCWn2d0LbI9T8vb8o3LLUzS2vqXvJhdLns29PclYty_ad2dXZo12C7w2z7sZNo8SgKOvBFCP2ayhp3Y_Rz7XNReDKA7miKRaAEHdgJgGFlY-VQi01KcmyUnh8piJbA8-heZR7p2ctkFS5kWWdaHhGfxRXaLI9jvo7E-lNHvlnaegy5GisnwXAkNBeJANQ4g6V-UViYY_6dZC025Jsd32EGu7qJ1FQfgZEeHjYtb3HkFL2ZFh3R2WCfSEUiHJ301oAFaaSCtuY0dcqVLUhbP9Uzw75uJiWVYRer-sqZcdxMXPl9UEFdzgvca_noLzsD6lmTSc8O8hFxzZwD8fZHDJyorAg4vL12XM7zhT20NznvYmhNZz9IrLzRbfFza1D0t1krceqSCKntXPa2A2EVECnPcwj3aFfcrScAUPmK2dDL6FUfSJTYwDnWesykP1zWmGNMxa3B-hp_m22HCc6VmEOYMHXtHrT8dL-xTWSFyzPqvfUYJssYJ7vqX7GGkkkM2xMVCsPe3eeK7u99lWt24E5DrLJlDHQ3BBHLcqkaZrJBepNlusBDo9Ketq6jcyjmLhSLmKnIvPKw96H17HyACWPAW3KTRRHlFEU_nKahVrqTakYQ3iDH0BLqMx9E-hRsSheI9yJ1ZgUswiNgAHoFyXqpxUu-EcTIEv1X7Di2tIcxC1zZlBvDoDHc2kqR9Kmbl-UUdhAn02wP3NHqCCPGSXjAuAr52ZCdR86IyY0fWd92g0_V-NrS6m051i2w-WqJ_O_dwGMMQH1bExu5Ekefcz9PsU1GGOKQQ9696gd2yPZj9CMd8fhiwOeYTHZS6Mu4U8pcOtooliS-3u0HaF3Fwk_m-9M6vE_8F9PX4GfVq8YPa7_0PQ2I90gasoCFtHMfyJWkKzONxAPCdQrh0ccRTD84Ui4s4Pw5JLuuC3TX0Nz7cct61UcgzFjGp6cFmZRP_AIMl1rdJN8FM1FAcRKjlpijbZDArb6lA6WuZV6HeT5SuKnfhkAhknkhfdfy-CiceMxd0hflu7OlADwJEf-6QDv_BUP09ILh1i1U-StE_3kGCfQUEl3PndpwrUmzDXc15MezFLl57joHcb5P31UF9QQK4R5SeGOK3xPD8pJGFe3nJTxK-kGeNPi7PLWyifRneUShTPA4Wy6bxJpF2B4swofwA2OSUz99F718MKgKVzGymwizyAyqRaD6Qk2Zp7Y94p36n1IU2jDoRYtNJ8bGvOirZdDLcjreDXj_QK-O8IGyGMhGlXsyYbTWpsslJ5hH7aJxseZasM2bwHt2oa1gSZjH26EKXn_629xge3FIlVWD_CvVE5ej9JGhtvNLEPX15B9LGg3o3vd59seKOE9PqSVeEhMDf1umQA4ONxu64pz9c4v1k0MqmiiBCb-EX6ZzvCYrDeVE73-HbEJe_FxBk62ZYDpwXB0lFGNW9v14io8PN2O0gobLNkfLrOYq9lAkK_Mgdmbkhf5iBb2zMA3OniuzREJ8CEAA4-dmdREpOFCtnGRsBVoDijx-b9BhZnHccd24JRMJRbOfeqqWyQuZLkfQr5ANmTgh6Pvr8A63WegCnBnhrCcb-J1ql3z5aJfQC2Ip5a74xPXujkLee54MW3JmmLy1_9gJT5ZLIJwjRBdAog5-A6k1EmzMNJRXezv4sja9iZsXhD4G_oJh0jU_Z-z1QHRQTFzi_NE0wq44KzoMMCoTnpTO8H4ie_FQJjzPjd6k-8iMDAO5ydy-Not7lR8M5rkKBLp7BH8dwv5DHb77Ghz9czyppCHZ7roLKpOh4iv2ByIAO_y8DcDivpMvDmJE_p2KI0xfjidA1J6V79HJeB06_c3aEKp-upjFAwMQhGMS3tSsU18VxxWPf8CZtPrTHKD2pnWN5wZsrJXJvQXYH8E6a_4-cO_A7c4kfsOW1q_or4xzuUY_icTcA9qJBNsSTnK8IumLHdD6NxgufZzajy6HVofWP6O0ujKrewF1UKpkUhPI6eAisXLyBPMXWlEJol5obmF_p8CVpWR7MxraP6fwSi8w6KNVnoyQcbt-C1WGoFhG_jn8Q6UCIhfHUTWfgFPUDPNNM9CdfoSQO5hrUP1nuBcX5wmohZFa061TqWXIkwLme-B-p2DGmZcmZA0icbS46zg8h2WxvKxBrr1Iaf8Jhg1_W96LSimdHREMA1l50ZYXPLJJnEonfLV7Zift37AdsTgMPL9mqa9x46H4R9VUvwniY_E0a4SiI3_vywoo0O1jeWSCkR1HxVbkcAuLYAHnWYv4gP4Gj3VeAAImm1B7_xfHqHFWlhD4g.xG61BgsgaE0rP5M1fG2MgAjwrQDc-tRyamfA1TyjW4I	\N	\N	ExxvuJ+Lqtq59SR/PKLAZioMwbg8SkZIbKC15gaQdh4=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	95587f56ba5247bf8e7ef70fe82e984f
3a1dc3ca-cc61-07b2-5b22-a0b7fb602ac1	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-23 16:48:30	2025-11-23 16:53:30	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.ToFUEKg_Un_QmHIkYHHSw8lmrk_-cdB0MoPbjJzJa_o5h7UEbNdWvqm71_v_xsJYtTV587iWlfzy5KrEinHm-h__3usAlIbxq3et_UBeQHt27BK_WkbEbkKkzlqn0QZtRzvks4VL64vOXJa_2qLv32g-K45cLpeAYqNEqF7TEBsihQ7gogPwxZ8WE2DPaTnh1M7V_6-H_IM-_qnQs_O7i-1nbz0s5Ram0KbVlAD5Mxbtg-x4akOvfeWbTSf10_cyUdKmrqzS_VqhXWyQ66ExdatcbrVTZq-SY2dTlAtTMb3m7VP7og2rtbf9bPoa0_nVA7Ox3OYjw2N7bvqk8QcldA._y15fbbAr1v571wUYtJuqg.beXogAuNlnCXguNcZAyVDXdb_RQie3LRWVSoZT31galqejebh743ZZJ0020_4l8PA-emkaDVbPeon9VJZCFPz72Nl47vJeSKGdApMfKdte41QN-vaNA2cKQtrrmsXjFTVHeR4J1HsvYaGocWiqblwtE_pMG3VkCq2oOaffoTF7N6cK_Ino-d1--k9sDMNmnltmFGRgmXrkq6OnrpgvFXsEW8yehO9i3wyexIy6wtwiqFFREzA6N-37_RQbj40ynK4YyCzpIEj-NzrRNeUT7LdBoJhwOyuu5KhjBuW3W12RcbT2MY91ECyMsuEq-eQPtezVWvONMoGShezV6IN5CgKkuuTk38W1JpQFhV8nnfAE6m9mq_496g1ycWlabjfnkOnJBO22GmJgGuaYTWwOXC_v96z2AJMombrW6B5LRV_8vIJS_bh5B7dxSj6Ibc8CsmhLsT-xVAmGSsn8weT-s9EpQQW_CYd9jr973huRtR_KCXjS1Y0ZjgL8D-0lbnZOzwKRiOp62onOoufZ9m67y4den6V9Ib3EDP4Xcwg-vTqmKfmj9VRZYHokX_yQaH-ZLB-RGPVdwhDmntg-fhtxwXYqqkpkx6nR7OH1zSPrdCpJ-BGce0zN8LuDTjv-lSmri6Z-G2uvwBbONviVKlpQYjQd7fU6f9Ud-1hOFsAoMxrV-z_aH1m0-QsUMZfQn9T2zvZ2w60mNIV02ZXtZ8BJhUq94Spe399QawyLuXvnBXapeqpNUXxYZumfeRTeFT-sHFsYwsrSxQkxEoM3pPNNjaes8yj7Sh27Ez2voWGVy6QWbgRQ9_yr723_jDEHnGAor2_mtycDpO4BvWleTBg3QIN6ySpxd1xIDNmufWbMW_Ch2_L3YUwjEZo430wuHdW5wYykTki2oNk6PU9Nv3iVr73_crbh6kbCPG9uYGdrlTJmroKcDzMd4qIgtBG5DzvHS47DC2fCLiN9ZCmxrf-NYNLaZb8kslSd3TVYS5OzrESQuBpFY6j4GCyQtAr2rYdqUOhRQO19YTQqd8Nxw1n_ljDnmQHes9LSBFxBh4xrua3ov7X1MIU2-JziZSRPGT32VA9TMVut7t5C_LIMKRERnHhR92bRKen1P3PDtM11gTt8qphDEz2CUSMriAJJ3LBSfobtOfHc_9E-dcfa_YbmTMFt53b91bCbM__eY020lONkt_MmkfxaSQYAN6NM56YvGSgCOOggBZcamOlJjVXtzlKo1CwQX03xPr1W2EYTiGzUB4LaqFntgVTqDJ1UMQq_KsPYYDexhVtD8bL2yNboYKVFKPh4ulDGB4etuL_0T376xA6sfOCUjegLiy24TE9A63ovFVJycGBAVa06EUBofq1rwOMb1JgRChT7WHyexBOirnCwfZ2vgoQZRA9QFT3qhf08-M7LFQWEYA1hzK0GV2Lh9jxwIX3nCEK9QlKJg0MIBvZLFmqelO32zJBqmqv2QwQlv9gD5aFh8lJFBhbxtUlxL99aHGUpSykGXF-TO5jNkAV50GXICBrbeFqZHfEXS_oAyFf-yeTyupVtQFQVhuYsZvzqLA5UHYwRbYmRMMYVUAGfGmPNwhxmtPxZSgtv6H3qkNPPP2sbXQvHi-eyEvdT0WGBuBE20wO2jNVea_bI1vJJHmrwB2VOBhUxShixgXOZWlLAOldffm12NRIYYzRzVWOmQ8uL0NnzQwlse_TRWjuZdQF6iFNz0TXCHRL2AnB9Xzl1A8L3U7RmdIbZHLyD3mCWuGYS-8BE2IgAXdmN4-y3QUJmRsaadm9Bzq_s6zyPy6oukYEw-RiFVQH1xHiZkqQKvhAmfIacgauJvLs3QSUlgKtHMfTOdEFJYrnIfpV899i4MzruOF9ciKN1IT6LU9c5BSz_1JxGu2N5y8VeDrUSwRcZxyr9KLvG08_rav831SunP2W0bZsRDzE7gdMgpd984Z9sBkVWCpsq_zGCeHfTj3YtZzPIeEftUzYo5fcgXN21KfUBtcl9mEMhf5bSeREectwLwlKtggB7CBQrY-Ullr6y046G5QDARj76ebnL3GTT4oxKCMzbt4UQNjUVLd8gGEI3-jddfezPKXGVFpjiSqEZ01eml7mZgIMKpxVBx2JQDs0KElRmHNYkxyKhg9p-HMTwHe2V5aF8Lw3GLfYHXxUrwt8PKTx4If_ygXufwJmC6awdN2NCDQ4hPu6MTFOZFG0GsQMT8hpsnT96tvn_5LQSgNxE3qTWXGj2AbORcMQA5cdmU2Mf2UhOTb1u38208uSQkMy4snUqtSrvdra7YZ2XTxi-KD7D1qvmLZP4O4tpFbPxjvvRDhkxblbkdEVmFSbjZwlaCHvqkO6WHMhJFrD3avXgArACDawvzme9SXVWhKolEfvtAgcFdTxwlxwRptsOct6jvU0OpOzTsVxvVmL7oIY2bW4RnKVT3UmEounlpK7e0zOM69sFsQ8g.uv4cApRN3AOEW7nNiU-e7D9HzxGfLUcJ-RYGXHFebgI	\N	\N	xHMrroB4rpAnv2jMybzOJLXvYiuYNzs/4p1I758m4Xw=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	96cdabce930c45c39653bcf9a7634c46
3a1dc3dc-c4e1-5c6a-749c-88beeea9aa6c	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-23 17:08:08	2025-11-23 17:13:08	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.BUp4srLS0zqCKDw0jopKXeJycR6LclekzueQldb91IU9qaKb2jAuWQLVmBTEyXl1FjiB79AFSIymBI2UeZnAgUWKIbR_UISTaAt75zknXiCLT6NdRDKqIqOhLLr0JIoLZoW5tRhBp7HufQJdHO_wEOxIzeXEWkZ_G1oFYIxHrsi4zab1bYs6Sn2KIy4V6QrPbkHTpl8UQHrFKAT8YYx2eBRUwpiwSpSJemAeFq0bJHBfLytgwASc6WnNbzzb_CHSSKjzNuHbFjlZrN9P5KVoZe64R3GE--sheJHDzXHV4KogwUiNZbWWzIP4G0UG3NfwNAA7kxYtoH8oGy4F7n9wVg.JkSM_W8Fh8HYIxJr4GADaA.hNfbojHky5n8VUyzGxbJ7B9vLx_FHeRuQHNU8PVr4qjYLOnSNTyMhlRqQXj1t_EYEJqxSstcXSWRg_No1Bylr6Dkic01Ot5ka5J7s8fX3C9-uhHRSk5bD_B7a7nerEDZTBYUhv3Mj3igQS9Y4U2cMmquaUeeNWB3FRihobPYsnXVLgqhQzBHxj1g2zpXVioZu1mOeqs8NbRjPaqaUuBzr1adT51lULpQxx1B-mAAyq5HKLSHHq3xCzjO3DOJ8-0n5WfibENvTmnJDC9qRNqQ4GfT0f1sWHyxXcmMPzi2p4UKIKpLOEmpzqe4DFqpRkaEdWIfRJOKdUARYTdXAC1aEwgihBKfmpsFI4spKeSrVEuhVO-Il2re6ymQQBG3UA5DFwKxohLWNmUrsdN-XKxjAa8xG7TmDX2J-HMdNfyk9CvL_LTCPsVcB6AZ-jM2bDW3lhcPddJ_qj_xCND22anvITUI6rlRNGvtDrzsecJmeTdaFGJzNelxqDfj1AjeErsvp3n65VwkhucIC1bUqthOpWqxxHz2W3bo0i4nZKfY1lo1a3P3zMc7IZZOe588ZUSGI79UfHvfbnzXKgcfWgsUeta2mgmRmCQHuEjngY7qFfZQbzrnzevqWyxkcJJHxxPhTaK5WHjmR_F7-ApfiTfqqr9f-MKKl3lmCfOrbq4GP_1YxXy9yoqjfUcmzyjXvsrVxP1Kzmj1wSstT7YsGA_zrMQiEkUsLPo37Svfs3fhu2n2qwXfEDZChas7ywEBZJQH7ohE6H4IUmkaD4L-LjKsD86Y_FGKFGGI647eq7agQQIyp6goTQSWidGjoDQKrrSicHsAp21Lhkh_y4UULDE07fk6iGjv5oZ5tpNROsOb5t7b7SHYxuJnqpXQTgo63iYnVi-auI6Co3fifpnnwtH7xw7x05ssEBlAZJ-wXmQh9saCAmkN1xlyO3QAHwEu8klUvZeI7QmXd3Eo4h7v3_o8-rp7SeXcL7P3UFzfb2mrj5sSb-VB8ATamzFJt9ddBJ_t7e_4WtvJr6I9mCGOknDSSL7VF8JtgzMoFMakalZ8PRHvTDG5_eKslVJrzXOyizGwspnOaI2kxJraKUyyNGddleLOTLb2MtAGqjK6dgAas_XJlryQn43Zw8pnslNhY6WmWovYff2GyKKK3oTIR6TstxY3RAuKyDXnh1WNSEY9TFoCfyIHvy3KYAfrcsyoFv0uR1mpurOGzOL9Un5RMIVdby5E6GicYaPBJM3RXLu15UOclhsZ4c9IFhFycXUbAYdzg0VxvLcluSYDLTB7pdwyx-nEESzx_7rUQNam0rYJ_IMOi0TIDgwaNGqDU39TXpAjBFfWtS8imZP2fcOdv7yiJfadODlUsIvwuPQZ3O2NyjwEJpRUzCchYzhkNQgfHBdlOOoxcwFrNuJPoECXtNiLEnFXyHyneRe_vK1nxR1g6vONWdlQq6s0aw8cBbhcnhYF70GZaC21ip_StkppPpXQd3zH0L5LAasvL4BG_kzVY0kX-PDWLoELAYg4BRVYUbQ35q4gU1C0-4LQ7rq5X_QG82OR1DL4NLkFAkXVitATbTjLUwSKwiX8_qG98CkB3UPe7hJ8JwH4UiynMicBRF9QiB730nQeemQyo0fRtDlNdQY3yUhvSzXC8kpAlezNLRh3i1mjPYDi3X4cAtdURwS8KJu1xB7-zPcjIqz1oBTXxx1UpNbT90qxWt6XNwmZitFWjPHv5Tec6JRB0AdvWiyG3rjYZ5Hi_0UEw-gFMpjT0WsTSAv0DDhEMjBPIpeMsZJS57BnLhRPEav-0r5GyElTNdaAX0lzCaVwTQGwpmDvRUPAFYeIWbtlzTEOneEWcvaZuPcVvEnU3DNtwhO0MZCV0dygcqJcxXx4LN54_wOMNJWk1glnnDejLKhRqM0c0vZZsaiviJnX30TJD3UyrAO1jNyCpDS0yD6KaGhamwz9p_ZcD1at4AXY0MU5NUM1XOWIva2CW0D2gGZpOHN5JO9UCtU0rwsimv29CMeMCUeQDbnIse__VOTbbHF60-9bu_iIj52FIHsgGFzYB3DyiIvysjWT-hg47pAmOHuvrGtdQgWxvc0U-jX-snefNANSScyOn3WFwMgE8IG_kdo0SOd0cby8CFqzIztv-Dx2hU8bzxPDj2fKth0zYqCzs5H7fZCBqm9_yMKPJ4c9PPcG_uCHtssaivQ62wXK0YP_MbFTchfbybOpPCGKXqO8stDztkAzSWinBWcx8UDlglTRzPjv6gEqjSGP3OeowzViaQXYWPU.qt2QYWsiYp-PYq8oFO3DsufhR63GblWEEGeUwOrytL0	\N	\N	wtwS+C+JXYSQwxEdOFza1MZycMHYxiuEW+G55w8UIio=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	e17d8f9193bc4ccfa52aa5f13b13f877
3a1dc3dc-cf33-be4a-7d35-b4d0fd3fd62f	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-23 17:08:10	2025-11-23 17:13:10	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.s4Xhr_7Wwxia0VzfY2wRbz8ubIHWPGSHAAHoSfR_erxQ3nWG9oRjGjbeTvIwdYXTW-aQ_nP43lvANg0UxvXVc9IT3ChdTUIXBMRpgPdIj8vc6keGY3kp_pfxdYSxhbMQNI5vm_uS6j2po0qsMLldfNqWZuKf-qINJyyEs2Gsdrnc7CSE2bhwO2Adv-l80z4KpcEXosxMNxDxePP9xPIDQOQkY8md7MDy_8jLfomW7-bqKwLVV-ufUCYE3aZIAO49An-CirEKcxhU_l5ugJlABWPnIaDJcqr1aH0No-8YCx35eqZl1cROIepwDtg56sXu4ambYqrTacW2ebWUhS3OoA.XMfdWXBzZzTSIKW1okSluQ.mi823kU7g7gWJzz4o2YcqeOUHsg_rFlr6lCmBH2anvXPXPjS6xqh6bYQVWZHZiHVMybTPAdx7wkaSVX4eaZIbRP5DPVOE5acbHmzFh5XC7iIXrIWeBADuW3etQbCGFGVzXTOrhG80wdZmsyqWRZlh3bwwlcZNWNWVr9cDaklBUJIcbKBGxB1OqbM3zCHF8LW2zN3-OPmzt86SG7MNDEhU3w84EmH13u056Ui_GHkPL5o2Lpx-FU404TTYLmg-2VkJeiFwRRyGinbNrIamH777hBlMP8UaGzQ5grWj1cFO__9yPGLJ5xa734Oeh4TKZrrqeetx8qX_yA-N42Pw4nxMK_sA_Wv8LjfZx5Bf6izev5SMrmszK02gWX3KBTWCfazi2OGGSkRZW08FM6kkFPlsvBCDhuq30g_4WRjOKVCG33aIGWX9qAT46Wo1G4QFXqxeJQ-1fbTmONe9YxtIkU80o6yzXywxX6JwL-I1VnxOhpR8ANESJjbUCZWoZJ1srjaFY5OyvXgg5ZHJNdSBuwHGhJQIny1uJKducJ_bogU0AsE2DbnMweCsbs4EiN7QNfzOa2_nFY_UtVYAPlc0VHgDH9F7PfnBRkhRD05CGym1OERpuUPKnlOeL4RR7oWdLcPJFbGnjOG1fWNn9e8YL3rk6lagHXywOvikrCanOyr67xf0O7yFEogz761polXK2wB83Owqh6zkvo--s88t9blMyC30fKlPAzOwoSjiET_Lpozh4WVARl4m1wdyQ1flHI6SU1FsdpddQjOGmuED1OQgn2aVLQYfgcK0kX-9WBer-HgZLG3ui4IFTwyrnmSyHDHfivZrRDg-njx8kBaG-Wggz59uvYGS5Ylwehxm5Fr22HnmryPkehW1ECW2ur-xJ3MQLmkaHAY7Rk_OiALu6yEObbcrCqGjG6uWcBw6L9TyK8COnHB7heC_9VMH8CvseW2mpxPl7N2XxQM6qevBi8dvsSoJ9nUZqSqjxUB1Jw17N5oK6ZoYOvidtyesKZMa-7an7WXTL6yu4UUiKq0-Kme6nyzw9uWt9cG3gE3m6gK12rh5_VfVJNiTtEG-hyrylfkIh1X5rD0kNP3x6vrX0usvZuTZaCsiTZA3y4grsDmjYy3U_Rp3LFB6j2IaElUG9D6VznwzOCEETkdFqOhZEvWdyfnyHB-YPiT4X07IKhjPYWjMlPtWpoR5JCzRr9QMhcS4Mvgs5tLw1ii8CiYsdpwjVQUUo8HVKYy0SRQ5JcfBUzRZFARHoVh27qPOTWZcaLGM9b8trux85sgyLTUt4O8NbkQL6L_ilpcKKkt2dr4uvaUGTtfnl9vG0Vq7zhb08mIpCMH4nTKuWC7l3hDqODf6YE60ePsT9C3EuSA0yTbozadiMuWSAFhYhlxh3-IjugNkIf3o5rxPgf4ailmk26LV54jvijVywdkjIf-TuaKTnlMUc5AvbdJI8ZIV0mEKXa0RFFQ19KzU--FQdYwbk94UuM4AGEz4DoGsXNhdQvkgyseNa4I2gaGixcU-c8TkvZ1wna4u-LQK1BgN3jKZB00h4Bk9Asvk84YIycgSFmOCb_fT0zH-oQaJIZZgudVLjn7KFzurXCfG_V4oGGlV6OwRmfijiTEusFPGk6A49tme5uUAWS7YyfHF1hNFyI1XTbD9B9J5GWar9qsxg56uWpy8fnYCAUoCrDO5OX3KhZ6uoDEj9gD6oFGEKek5dSL4T-ihgftQDJ__PG3F0KsOw2V27MTPQQiI547x0lpMS3nzgX7cGxeVmgssMtkpillPEajip5rZRs28SAv_HXKlQ2dmm8hAygQSpAKhBeJaJ_hrRs0lxcEKoPdENWxDFKHvP98CruTK3reVXvNpzbBYV8iFdrDzIiAREDo81IH3MgYTCxiEhDiideWb-WdPW_QhFiMNSRDI9Yrsq4p2odVGQNd7gm2gm9lxlA24ZrCmgE62Evj8JOJWb8mhvR4Kz8-2dmr-OexeelQ0eFaNMC6yLwoL13ouZakZkC9_QkhW-iS8MYIl2AWoqT7Q0xRvLHokMLvJzzy5lPrqXPhX0_ZV39ChvZk-mDZvSQ5vGwHmwhosTJV1y4oc_eI9_OswYg4kZy1T0TWN9EstW5ZY9jLtMvv6ihVr6ajyOglVRVH5rl-Czw1VehZA-lESJSfWdfc0l6C4j8IMHiu8e0l4KiJnPS-BG4jYjIvYk-6sJGHNvf6uzIMoEI6Y0B9lJes-rdIjbCCAd14PhPaR0F0V0z0Q96Qsl93-2p35rCKBw2cLB7WnK24aUlUBpUyfBzLH7VTODGBb-bQmAjWulbV9Dz9Q_sfSru7Rj367kuCx9vZ9WwcT_ThBzGBbJkccmQJsu6KIMbdtjpOLGaVoyYkJt2knhRSb1aaC-5g01cZiXhBA2zh_5YpHfNEaGlPRFFGEzFvkLYCkrzVVVZ-ndW1ihU6OfbKAg.Z_pCJ8akHbwbgnxrNX5KYVnAiKb5GfGSzK8yEd3y5ss	\N	\N	8hhwMwv7le3C3c09WSPqlrLSOLow2La2bvUcDa+nCYY=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	5951ec8f41f843e88902f3c162af1fb7
3a1dbcdd-a2ed-338e-a867-18b583bcf3bc	3a1da2e4-3191-7923-a780-699387b8fef2	3a1daa2e-4a09-550d-2d70-85760204b9e6	2025-11-22 08:31:44	2025-11-22 09:31:44	\N	\N	\N	\N	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	access_token	{}	7086df70f45541be9cff6cfe8f1931b9
3a1dbcdd-a2f5-2d18-44e0-545b2f8ec77a	3a1da2e4-3191-7923-a780-699387b8fef2	3a1daa2e-4a09-550d-2d70-85760204b9e6	2025-11-22 08:31:44	2025-11-22 08:51:44	\N	\N	\N	\N	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	id_token	{}	639b56c35afe435eacd5c13f7d8b4015
3a1db97e-bdb8-7d69-c097-80b259ddcf61	3a1da2e4-3191-7923-a780-699387b8fef2	3a1daa2e-4a09-550d-2d70-85760204b9e6	2025-11-21 16:49:13	2025-11-21 16:54:13	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.JNxRP6Z9mOHOwBp1c_Xb_jp2WZ_Mlq-nwmLSuUM-8Hpz0gM6bBDrTgOXUqrimgOdNpS07k8MVw4k36UwO1raHg8gvlJj4KT3ksT6rtYkg0f4lx3UFrM3zkbGH0g1SaJn8c9V2yP3Sh_GyjMqswOqylBkzT-Yk0wH5h1RqFJyyhRh00kqAJaxOBW1ZscTTii4VRSTUrFAqZYwVyeNgUxmBCxQi9he6ANEa-ZohIj-V3PxXYI97-QhetlwaxlGjdeoFrR0buF1bliQnJJMmBCSHlt8AZDwUhU0DcmMP4xY8amSCANvNGeKBf1N0PijEQ41ceQ7dPDEUNf8Y4GJAd4hng.WRsGMGWPJ5MN-OMj84rK0A.rqzx0bJdha99uw8dGMBD5eFDRydHDSB53fke2-ghEBuKcPB-kw1ZABgsOsaZ1V2k2-3_dqk-rULQjhF34kaQvvbKtY7NW8eH2wL3GZAbj_-suOilHbRSN_DjxzqJ19UuwFZ3U6816eHUeLPu16KEaYGT96TZ6d_ieqvtb0xqOutyz_bnjuMZLeOLwbfwcY5Dopw8WJCqbGtAYh8nOEq88EoC-2V7wlONUxqfwtXwUHszWmUWRKditNNpg78y57KKQoIfpNH-VJeZMIND1pU_rygGO2ILdMI9NRikz9he6eB7SyAl2dvgVw2_Q7R0RIvchN4S-fW1WH9t4JTuxuA0DMuywQGbaUJZb3Kj1wfiKXHYSd3ZWwmLlm0Wlo_oDmY-Qcu2ziM9iMSgvV2q59I7ufm84uGNveXrLpbtYXRck8-GcPf8VKsHaGHofLVs3fQVg9SI6ShLXFhWGl9SLzhonrASIQ67Lwy8aSvKQ7cfzopxL3GHImTqCQu9srqkpBXf4tLolZKy2RrtQFyNDwQB45eqx5ppudgyQrjhpoqfM_GuUVc-X3H2T0Qc0ang0ngKMhqwdHJKLr7b_26VSSY1lYXkUzbBYjOXLB3ejISKd1Y70OU0cy6LlvC69Xjtap3RvFFqXXkwj_PjsdSliQNdbmWfuJwgaC2lD1ebzlDVRCTfiNTRNMfyNTMtsCzrBv8Rm8lW9fX0o1R54ske0O_R3DHUL4BxMfSGiLY4HLcFzLpnepAaReHtqyJ_oFtTYWeA-I4CAFv4Od1x-j7hJi4WYP3wNWglvWX0b6UBksO1aMpMy20Ka11w1lMpFcxxcpz0_Wm6yuCqCIC_ff5UyLpaBAC0VG2QQnfvL5jm55IaZem125QBPoHXuuNLKBdpUuf2DOhlAtMYqIIAo0l4EdmWSQwx2olGEgtzZUOyM8GaSLTOtSIYiGLUH5QmaT4Ue4x8bwhhkH0AHRuIyt4MTsp3fDK504DzcdbWALA4_CLtLU9sGA_jI-6hokbSm8v4b5eqjfYfGVBFN-oni7LOf_Jy1XnqoFF8UanbzGnHTBDvlFFZIXskHfWGjSqjOwsiYrG1BpXVAz_1rVo4aRU223pvxbMy_LZH-ooQgZ5FCb386pJ79iGWCmquATDIzMlpWK0H66td9FTohh4VkLt4FuT7ZNoAET9RE5Rj73MlMjILoyI9O8xUbWHQ23Egv7k5yM6ban0oBtHLVlUFsW_dE7fGgE3kVLkEw9KKC5g19HQaHEoq68VBLwq2GcxWsuFz1t_GmeUjqGaqFkis0HuwxBupMNp9JatIeIxwxdaoicUd5_JNCCLGZ5VtY3cqkUgpH7IPQxKNx3g3Ic7U5Q4fG_1tCeOWCDfLT5ZsWZxNDx8Wb_TnHwBBemJ_DQvmtFTkX2jBk6v4AQoGDtb9pnLadtohWmh7SFQGczFq0uv7kU7-DjtTWjdAWoGJF-pfwo5gUapjy2MB2urgsXUWiNOZqfICvjvo1J9DwmcxOqCBqbDT-fmkLzZGATLpVAnlvf3MxjzSt1qzYrw0SdRtt8l9xqRFMExKUqY44PFq5GQeoErfRDr8XHDpc-gBRcU4wNKx8--xnXZRl9oR42GAo5TkmkFi8Unnibf0SgVRhTq0Ic2fcRZG4WnDYa_BF5wh-8TrjXsoW0bBa-M9wd4EK4R01sm3_7y933N_L94cKCqNhQRWRefKDDioIMkWfwVFmd1K-v8QOzCivAH3OlFpyVZpzPwDsQQ1XKf2YDMEA1qynqj9U_fbZf1WyDQ_bHiwiyElnZWqwQzLl7iqwvriZ1Jo5zl_HKAA56CO-LsoNSmj_ySlpDy11JeRge5ZH_k5J7uXoiTpl1YppNV0_0K7wxQG4GuZQhSBB6PdFcubT5pReDmhRPj9DSo5NlNC866QE5hoWxKb7Tv7c85JF2r5y8xIm7dTO14FrrYJ0g3UWS3xcJ8JAkf_GHEUnu8cw4SMYi8HnidagupivHIoK40Bt3D3emM7VXZFTMIjPK6O9frC84p9jBRrHheWe3J7bENSiXBOhx0X0BOV9nqtNCacnmxYKJqOfM5XcZ1UmGikG5GmwKneQEjhIuyCy4rHGsxPejynTjp__oUIFiDEg496D6VdB1Vs9QOmzAe2M1_kBKj-FTdagXp2eeLiPRMbagNHSjyumJtpxJF7kiHR2RUtLPu11Svu4OvL-m30N0dWyXOCjBD2VPB-RWj7RUdMLFP5tGcUVZJyHUk2962sQpP5SzP_RjZKCN6XV5M7_oVYVa2h7_j6GDEJ4Ykm9SEhmsM-7fbXC9y9D6uo-oT1OYTDgCrQOKeU_LO2BGnAy5nHbN3QYOZv62sSY6J1UJWwjmeeaKiY5uxHxI3KYoSCBA2w01eyozJj2gqe9FduRUeoxBkZr8n6x1iVEk-9I1OhTJZ1Pf7bRFSO_jUi8AxtFuLlEX8d077jtPGjfMtAfl_HxfZpzh5KpHhbQotdlbwb5L5nwcusVVtmTwzWVRm6_WPKXiYZxTzYToJWZyto_Wx8CdRILL3fs5nEBKcH1e22CnZBALwWGwkFyNZh3WxnB5vRo8cNLyxw36elSKJY3OuLhiMdCMafZiVGuISiUJ7sIRvC6sKmBoyRIFlKQL5hNyXvv021nV771tUzH-ftKiqT5MroGWtJ6nQT-UHxNCbVYrj015mgREhULhJaTC2sZpVkAuwznMmo_WFEKmgm008OMrRkqrx2cHTBFdAgAKlTcAFAu6_awLNOVoNxUZXkgrM3YacRyWEYjuTpKOBxbc7M2TG70veJ74JbkLV53FYrUt7zlDq2CA81ElUGEOaQyWBcvfSoe_kS_1lKYuG3Hev7rqf3B9nEmO8.p-LtpGq3skixytF0aTClv3giZ39KSKBTmjHWk0obiK4	\N	2025-11-21 16:49:13.874872	RtP4f6IECKuLw2EiAv9NLVt7oqDvEQ7s0952Rq6Cct0=	redeemed	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	f9df6a6090534e369b19afe1fc439d07
3a1db97e-be9f-74b8-bc81-490705aece64	3a1da2e4-3191-7923-a780-699387b8fef2	3a1daa2e-4a09-550d-2d70-85760204b9e6	2025-11-21 16:49:13	2025-11-21 17:49:13	\N	\N	\N	\N	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	access_token	{}	3d73b7b8ec34443988a13b1698f79826
3a1db97e-beaa-b065-ee64-d7e9da82229c	3a1da2e4-3191-7923-a780-699387b8fef2	3a1daa2e-4a09-550d-2d70-85760204b9e6	2025-11-21 16:49:13	2025-11-21 17:09:13	\N	\N	\N	\N	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	id_token	{}	e3995a5583ae4ee4942c16f7d039a9a0
3a1db980-4754-7182-4294-ba4bf9ad6445	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1db955-e21c-697d-db53-2a221a850fe3	2025-11-21 16:50:54	2025-11-21 16:55:54	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.roSuCoZZMRO36KOk08pVpRbi9x2kZynBPkYKgLMIarSCHkya_rlEkGcwPPtASEvNVX1Ia-xJrvvVxqtUjsyXjSQI_H6vepfa-QZer_pjS5onpoWvNwVmUOdz_j4G7MxukMBxNSNQTgIZem4H-KMPqjkl3LzdP-BJbdgzKn3gIC_NbUuVAr3EGrs97ql7_J4Jz9PWkRwsFBo5PykpdrhrgKQqqONRsjavMrmb9n0ZwZNK_qOiMvMMogGF3sM78qjv1IelqocbogjvFy1tLcp27-V7VC6KeshgtMF88AJerDNd8HKW22llaoFb0pVnKno-OIgNbjSJhPlgYMPN8Mit7w.92B8dxIZn9vQMnnWNnRcHQ.memMetGDsb6oDtqMN0gprHZPhH-WZalrDnu1ISs2-16vlxJ5vOoIM5pIkwu7B8eRnH4PxbXCcD1PSPmV4u5BvqLyVLCgKTLLsh3lEPXKWI-yam3UZGGi2qyTl-ruXbJq37ymk9fXhf3-s5ujU_DERTQF6x_RYN8KDMBBj_KtpKI5Tmj67g-TAX7M_15vItq8DtHRRaUlHG3hc7oZrpMlOCDxviT86sqpjtdAOyYK-DRuw25jumzQHsusw25mfWvE8aCUeN1yd6pbZl7WZOYrhOJPSvv6ZjODcWHoknd9N6LRCJBRES5snHnqmQ4ED4kb1mkQMfOpkbA-r5NkeQ1ZDAMq03E7ERTrqMmYNoiLg5849IFJUa3BjN-TrRF407CGAQdkzOuB0DrzQIfSeP3DSOhaoKmapfQSDr2zp8Qx2aKACS4_cSX2JtyD-wjCIkN1mKlooWRc-BLNO9Y-CKJaqyAsktEkVIgx9N8iTSRooWlGEobl9AbZCq_mj-gPXGdbthIbToOVKPrgL3UoysKiSzHBg9H9hFTLUdRBBAGO1yeQKrxqSFtJK9STvWpY3TdMZVRdDab_2Camub04QD57yA-Lwok3_XppPdfHTnA4dNuB9t6EM-7ThKQV7qvPwH0zc2hj5w_6Jr8mNbc-XfHghqNja9hIhA9DNlXHJsimd2wg8sI2i5JDE1Szhgch03uuf2abhIvNaB8B2ZHFxGAzOWrq5DvlG6xmzoNHXBmXRMfKsOHHT7NXNMFCwpwJe6zVNzhzo5aqa37XcUQsDRd8BZr0tYQ7Ea-YdvFTcWJ2d64dt7TW5hRdW8f2WFsLH2ZEoNJGpy8kmR0MkCKxMqmDIJMMaLk-BA1UjY5qsp01WUJWP88mUghiuU5PQjXR2PIAy2vUCWJCVDX4JVi4d7jabYMhjQhGhggd0SUn19GjEJtj9DFfXv4yDqSn2xJ2WUN3YKjok3nF7KUTbc5cQm5jyLMpqPoNWdljHzazAdAYL1Fhe1U6rx9cWddtZdN1UdOrCCZ5xlQnuUYMM8xAgyYtKbvlaWwXpuK2snSInKxwXXFfMNYrsD8-oK1GMRYQp-xKoRktHYyoOVvR7OYl9Pc4usXD-s87b--PQCHQgq33Yo-mjUgACP5DE2mcef0wuK8jsqZDQghZFFCSX8bDkmzj6BSHntQNolZHW7axeCxBUvD0ltU0NaTZhBef_WHilOk8vr9flaAfkkKKmGkE0uSExcmaQQhDUpNksoh_Al7O_Yafj56d1x1uAUyrU0y3lWABGmcWIt12EclgZFcCWDcozOOGFwM1m40f0JOgTCMhK-XN4ANqCmrjbYHlh8Kq76h5ed19mknUv3t-TUacAR4Yd_cBDH1rJh9v8VUH4vZOopFJRaqy6rUdKUX9mGQ81GMusZFhd-qz25CfUHjliLnjiw8Nl0g-xVVb9vMfBC7XBVFKISSPLkvjIr9X8_1dQRh93DPz81Kdij5kLb4k3ikAA4jDPje1BCUY8wmmvLkRZLG7kr-TqHE5PJXiqQGMX9-7i_fB3MefnJMCehcs_8WpAId6AP3AS1aMcy5hMsixkUAqQ0QmlvTGROE9DXCxeAWsgoQahx6wh_ITZGcbjkmpcZu0kIf_b5ZT0DFNoJ6girkdcwXEuv8muktsbkcZZ0tzjhq_8qAW-TKpCcay647BZ4e1gcNBkGhyG9JhLHXFN8rB97MG58mZakD5xB1w-YrLZBlrjyP_EqY1mksy_z115nifo8QK1j7Hbyv1vYc_n5mB8pncak56Wf4Np68jgsXQHLFay_67vIC1WjnFbQkljF45QyIZm5elEFoZiEr9vRgBut5kYxrkY-UzlH9bPWxmOINAK735dKidbA-CTIlITLuQgrZco4SxzDOefdPMtjlUsGdye178hlQGc_z-tUWBHNWqez3Vp80HhzIOWv2M-6N2JeyQEXqu8f3todlZcl_tHuNNVCPaqLLp5Jq3b_U4k0pSoGmSkYbBB1JWgyiJ2LZG3rNCeA7_wDp9ukGImwDbusWh8VdFKiR3sg3lQUeOsIMnAzbBbevRkeFXEFgSB9KTP_ABctLc4IQJWXSyu0l7OpPltoR2GHar2R2-OOHftGdX88Pl-FXCHm6AtfOLYyqVcMwNq4QgAbkdQYhEIc7XWzrMPt8E1JnmKAAuRIr5WieaMCbaLx_cyJIBZ_ICRYtJg_0dxjXzsEsUnv9fx5zAFJF9QubYUGb2vso3RKnCtRNKbDlSneV0pz2lJv9VzMgs8bu2xN4GhjWdcRxt4PELxBRmz59dZrwUCDop60rvqt735_c9dC1tb-qZZB7RxG3JTRVuhK_vVeyi1lX0W5lidwd027puc86Bzlosztdi_Sn0JYWtZdsbYBXjWnv6ru7CfV_50433Ic1QbADWRM0XiATlL9JZMUkc84TsdMqMwjXMPn6F_E8HrY3f1nMyLNzG5W0BMO4nSY0crgBZfFHPbitMGZi3V2F6csRVUUUZGiE8Xo83ujyrp4LiTaFiNjf2AfXNkQ7CqN-E3lIY2UM.uoHC5sFGvi-_fjLcIhTJCAD8QAxEaGulbuHhb-xSgCI	\N	\N	5iztHgX75ytcdrZMArnS0gbDZsX8bEA40WrPWhJFj+U=	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	2e8779c58c1d4bc9a809c737b4951180
3a1db9ba-0e51-818a-04b7-9ecd09033584	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1db955-e21c-697d-db53-2a221a850fe3	2025-11-21 17:54:00	2025-11-21 17:59:00	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.lmbjcVnncjsPnFcb9uW9l3B8D2xEKJ3s8A9e1yJnW4AW3hhZs_yZw-HPOoyx-qOlE_-8fNBUvhqfoeFbPjJV1bOKTEtqWFZQIqMHD-TG5NjA-tjnrwSzBicbsQr7jn5PR7osmEmpeYEVbtBUiLRSzM7j6m1LMn2blalbjk2dubOK_UpdsUnLsfw_KmVkBgSj9uiimh3YUNwo-z81x-UY-54IXWMij0ICgF39rMtVdNBJJHHkAsVkuOagGhF4kXUhNh1tT1g0L6k6KJn9hxiSl1qxYBxX9dBjLAfQzZhS04YkJK8gkzuR-vRSQTZaXEDZOAlPr164IrvbxJySUin2jQ.96F9u_4kowIxUnm2A8MYbQ.nUZExHEI7eN1wn1z7S9KDA1ewU_dRhyGa7PrBvEIcUTyNrPQig4WTJpmbPWowhbReRS05xcWQFa-nR3lmZYLyzACATXJ8USCWcdliUS0nmucO0Qr5EfSfTGo7Z6tPFkaZhyDgCFzyNaegdO8AChwJz1M5CtVcSsRZ8WL8095727gYWu9IXnz_5MN4dxM0Fb0gJYBj5afGPeOmgoymflU8tX4L7MWvcQFugd4r69lAxzi_PIQllzD7evwZR1VdRSDcCqIn8uBXlLHlsGi_Nahyjzw9J386KcyWBUMO0yXoqU0PZg8yo9hU6a41XT4iDxasbLU3ojXM8DSHKbDMP_lZNRRJXd1nqxViPiXe6iNvVlTc-5AzH7ep8RwV0lJWbpoypmt-ZvzH9sllqJhn1BirxpEcIFfh4furR_tHWIV1o19_sR8dQh0br1omLV2pomHAlDAtOt_4Fhj5xg3gmB4xT3MNKicHT0g3_EGLzaaymJhmHsiP8C6NX2nEVy3krd_1EgysO2IPtJUqEdeP3tcxoga3jJewWLZdMMUkKixrLcuIF5lA8ePEbJd88XsU1Vs94z9riJlTZgDfqvE4YBvvhqPYnIGLSAJ0kd1duqeq-d23YLBxjXgdr9Db9Wnj74oYA80duwmFztIIlBA_5ufeyloOVLilZgg0WVUJiX-LLfZHD1_UkYbRT5foqjNnauvfoRIhShpq_-hOOkR245p-fr0a4JKx3LAWaRRfHwvl1DTzrlLbd7Y525SDbN-v2XUsjCXEUBttVfwLHdl_FXlZOnh0-lC_WRK84BnP215GyxMouxM3BOKSxiCbVAb79fQ4mcck5A3A1BPtaowPf6OxhSXfRWkOTCmas1wZ2IcDQzOTAHn4X3dmoUjt775W4cWaTPyb-l5e5mo1hJfMc0-x51vrXEi0c8uFxszL3OoZJ3bWVrvFCnUIZShYkVKKWYD9rikJhNdDO0FBHH5XvfG9Aye3nz0YBgXSg_Rg_pDHFkiW03pG5a2YDk3aEUet-_xilXjhkpAP3RKFvWA3glqSKI9OXDwsuKtTRV3fw-wS1TmPtpYUFrA5AqbUK2olEApfcofSl6iICoRhxJ_mu_nXQpt60NgBvxw0fZBt4rjZsPMrRxNMHDUq4_qpWwpQDuwHE6FIcXsKkagwY-T6Gdo_mnzQPhHFmSNMLncO7JlDvVn7IJ6oByuQ9LJmq8JR2zYsxgKMcDuxYUoZCRhAlqzyyI47iNIenCTShPCFCWsTmj8np9E3J12PrB_7Mdxq189WPpF7SPEnxdHru6Bfz6BiAXi_bU1VlC-VHExu_Cj_6J1cci1LhRVnGwMx0xL21k1V5SSbosodhYkQdalKjCBh-lJ3c98I3cc5ae7XN-o9XUYBPIq8VgVAL85Ts5VtH1yu0Atpv4HWfNISC8bSMwRo-dkvhGq3ENBLq0qrEl_n7tT7LP6tD6TCw4Lww9t_SIqiciHgn-rcIssekpW0wRm66gAFiD-Zu8zx9L1dFjnuMzt4_jxUCM8W8TKaGuWAtV5WLx34GlujExPgkcQ_udBJIuv5ZC68zYdMOumebc4Ed86c-MPetDT15O6hmNXh72HukWOuCsk92YDs6Dkef5as0Zq3DehlCAanfTT8iH8ZsdILtMIHpmvKN0ij7McZU7nLzMfgmkJoBPJahs1V2wKv6Zwmb-VxxMCHMuQTB3PTwljKbQUroukxFrG-1hXEFtGUQOBADWZj2torG9wy_DcnKkemI_Yu-QJ784DBPr_JAbciR5QW7OmhUsvbAMhC5-iOzCA_lK_U3vTU3KElDgmWnVwWDERzbx8xIP5jNYCvFvtKujhl1ftIoIDLsbnwGBufIA7KQS_mC0kkNO6mKADpdH2GzeQHGNRaQfh8xQoBRRax5XwJlrtcu8mrEAVrjoxt3xRzbTXosRMkINkBQiUlsOEuI6riIIsqIAtaXk3lVzSQ6Kh-LVR-EsmZXSaQIsGEBcCGbr_g5b0KxJMIoRKt1lbb134Lfn1ycO32iPpuTjfaCmWQHvJAhu94ccKm4cX8YmVkKKBkn8UGH2Bp5HeJei5ToZYBH8yFwF2EzOpI1Ya7_FRwuJ9QAuZZkbFS6w4eqiCoIFZgmRdnBt9YOuMpy-dxbYe1nd8Zg4NJKmeqbYgHDhJmTrJox8Qppqsg3wwMKY5x93-qBwep0ePwBjMPey392u4xt7TOO6Vsex8y_8pvAqJcU7OeLqye1155QQ9OItpDlT-MQfVkrjlDwQMRgiyOvAIS1wNNqS2JLb5PVLRb-q6ULXYA3VSpwxss7KlzshX1H7FGTZ31Nk3kBUiudeUAXmkfeKNdZJLfw7qiLFCFsWHQOnMLpZuKTYEP39DiHC-XHtA14l0xRFudSp2djBV0KIX_6Ajdw6EfZnKtKXIbwBnqVH5RhXMnXv6KGkQtcOhrEoE0jLpap-A3dAo_vH7lp0PK3goq7fuJjYsA2fvgewRBzh3bVe8Zp8NsNBJfBPqWHX6LdQJCThWiZeAnU3Mx0cVvfaRwFss58nKDws.y8q6MQ2r1iAB4MZu45XWgMwgQHsUHHgdhQNaKT3JuEE	\N	\N	soVQBH3P0bncZssbcGDLeJLVqEYZswDf0jEO0VIgoH8=	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	6475665b22534c159916fc892947d8a4
3a1db9ba-145d-e853-c965-55995b44799d	3a1da2e4-3191-7923-a780-699387b8fef2	3a1daa2e-4a09-550d-2d70-85760204b9e6	2025-11-21 17:54:02	2025-11-21 17:59:02	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.IG90zSqWxKe2fNhyTqCQqwYg6vTbGouA3RAvX46jUjacw7rL1oJQI2P2zg778cQn5GyIcYDXy5D3fbzk5CT5TTMyyAnvNLvKAvVHyFT0x5eIvzPYkafaacpjpSlXTT8mdaYUH4Pjf6MJJXJdu2KaeiO31U6LVxfSZpprCfFtmNjqbJb6LVFFBSehDGpFRNMsq-yv7fZfRssiKGiP0W9DkYYFL1j1aLtJ8Helv7w8GhWAkxlbqyWR_f3clr5FOgKljaxsKVbFhxV3EZ5IgyEpC4E7PPz66GRkdHaxhm0Dlj52mKsoUar389ICZ96SArHhm4PwKSTCq7cx31J7Rd13Pg.AVqL3Y7vGYxtliv2Vo5D5Q.PVdox2fopMehY-RkOfLIJf8EFy200QIpRYH3ksdlKnx9luSPieMEZxTHn16rKPdEtH4xNMrnG76EQ9uI0BFnUGn3sBkLFXLNC15g8QIIk2w8bCWE0ClLhjzCPFy9RwsMMU4pWIacIavnAMDaMuHtyBO1f-p-B6d8amLy8BSEad3vKRoegg8wVl2kJ_ceq7DubJyPgv6rl6jTsXIy6AWiJKsyIpF79BB2jsTxHigWzdLHNrSwuVcW4fj0960mdAKcx0NKNBUEgZvd7odS-d1MgbjqMkaFob1RNGsQhVGu7XNQtG4PIqWjGkIsTQw6ximnBt4gWXGnoPdxqzNb-vvncbaB-MSsig3Lb3I7rsObGsL5b73AU4lUn98Ec_o8NezFTfBH45V9_Rq3ScKIg9qbFRYRLMnFY8rt9qg9o0Gr_YDUw1we3G3VtvtMLf12oubiea4Yi01XcGewnzlRsEOpTt8iAvpGwybIfZJXc7on-6ClFQXUB-_YyB0pZDhgoXMl-MXqw8_HuX233UtLKMeb-ErhQxGtogjA5NlscoNEY7gCxVE04VyHQCO79MA5zr5pJc-AJJ8duJ9yvVmo_rZBFoNKhtYAB2jtESHjY3-9JNfF2Pi8cLXStTMpi9HYpBLzKxhg4Nr0F-_UdYWQ9EGdjRiHCDxMABw1qh_XjK2MIkh02oww7qxMDde7WildB0hjNsHHRjtzFGVdPO8t9gV7WM2xYHrpmjjVYh4_APkQJZ1EmXgL1HJjzaXL0QS2_P4U9k77KOWPdyBNswCiM1SjkGQFbnogttW-OC2QPhfRobKxIYJkiqJgoALGU9YvfwdtpPAxYcYPDW5S8VQK7S5VOKgEnCsdTdJ5kRuUr96DayZQMHpJ26BJFoon4Tzc2CUhXJExh_93BoJxAhPYwA4p2SYsrsuusGKN-nG3gfCE4fSSBBC3bqZ_BNN7xtl7Ns9ieVK2CM3FZPgZ80tT22BNo6Fj_AQ_W7BoNsFe0PsUdgM7hcibf4K68UQQk4GZzQf-RAgPaoMuC9fYB8AW167rHjk3Fzafoxiv7DGvYc3S5VeWDpD960pMJoFBN3r7sopKhHfsPn4BBRii0e4C40V01wwT0WZMwJn9_Uf1Zc-Fgs7vnYmyiaQReamttW14-f_MLYP0jS-6sw1iJaKlJ7V40lTKKBw6WDskA9B49gxK53LfjHSlMbtVdoAAbG8_Kv4T_Fhj4mQtNtTL2TzAdMN3xIzqHpMooLespJXCxAtRZUDVddtYfo82juC36CAeshz8AWaatlCGagNwcB9WD5McVxA0SNiKXk-yyIk343jmJcsfG85yJVOi5OTJokUNR7PVDpfoSVs18woIstttagNahHOswe5rf55nMjrB70mMkCBQm70pLd98R35_eoWhZvCQRK-6BnPGbHNmkH0Qq8ohFW6RHp3ND2nxav1h47oyOhy47xNkA5xwiOICeMXR5XwJZ9Hkoo6GgMKIOs2q7HNozZbpDGAfxNta3_5a75XkGmNpLS_sfpzb7cGGJZxd06eFG5W3FuBQWgmfwRQEQ0viHnt4ZxzMaXXPiCsUQw8eVZWvSZ3ERymCWHWvDS7V3VlgskIm_LKfDcaI9AXAytwDUg91bgKUcxmIQp-oH2GKWwbSHqiJru_gquX7vSdHIy8bWOAE6X6B1Q6Qll9HQ1g0_4buBX5zJ0f0wkws7yBajQ9ValqsKXb_dwPPSFS0sOIKWxLFKIkOTmMwTVMFz0wcr0o8Vp3PNHYuzWRv6roidkc95lYonIxl0AYos94HPM25Xfbf-Pgg3H8OuAfG1taZuOA4R-iRC0zL1eMrKbF91TG3yMOBiSPXRmzPYhcMrvTHlj4l6uqQrScCSufco22swxIkgWoQnBCmVX_1O3MNzlmU_5f2_Ve3MFQSvL8d-tPDB-iaXJCIFzwOpKEa7msUSybrxQNBJJ7mygs3EFGijp_SlgKAEZxCFbnwitAl3OHhCwn-fkDUQpzU-IgrDdy1iM-VDSz8A30l97wrPEOkByPwRGW9whgiz0zck7GV0S0L1ezQPr1q2t-MJtXBZG6D25Uh9Qxp8LbzH3j8PDr0MxNL-oHfu9g4p9ZXmWZF86jD8FIBZphsg5pfAwat4yioqlBa1PuW9mkZbB3wxLhZz0BfT_UIphL6aQYG8sjVUotGRiv_NpxQ9p7hdnD45OP6w5pQ73vHRRZ-MW8asL--ybU_ynx6JMru7CzhyJONnQNdpBeaXppIFubrJEv4BTUfN4PheavLQHSJphGs-z4Lb3FKg5JhVg8EkmEjWMK_M0t2mln07vFdXmL9qswbUjUMFW3AyhyYlGhLcT30crlCZ7Q1BNdYMDlkiinSEy9Im-U8QNL_V4zjr9l5nh7BnXhjGPVP8-hKKrG3bE5t_AzL76Gad_ETPf0GI7t1PoyX_m78T4QX3ITlHelhGLigH17gVzQr6cUSBVojHubCjdb50Ya5lxSOYDM1ow6QYdwwbijV1RiBpgfaeinlW1aCp15a08RFHEMMjbwXgF4tgWterB8Ue3ye6oWtTHXc6_STjGIP1-iJ5_kv5D-x0ZPeaSdiylk0GKWTarS3pcJjVzsqegHMHVR8r8LSelqYoZ5Z09Qv2vQpHHMY9xpv9qlnavsobfqpwFWuEStIdMj-lP7BlFuy6SrEOJKi7Sg-obbqxzngnPjahSRU5nF5p4LhipeYP3esxHYjaySN0NieYcqmMMrFUtvCixsyEW_qpQn84vaaAx0fSYBT150S3p7yGdpKd-r5T8tCdy0wp7J1h-6HUOX9LlLKxeHT7T8Sr1aFL_ntLMN1fOFj-tReVFK2mG-oQT1tTGVAqmKBOXpKgE4JVu0.POF9o7qolxUwjhKmMf5lC5qSC__o48Gqr_clNQ1tJEs	\N	2025-11-21 17:54:02.722092	1nWD1G4HgK9kKE2I1hsAUI63J+vOJvn9pYxDpJpHQg0=	redeemed	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	56152763d00941d9a09da565a34c6735
3a1db9ba-1588-ccd2-128f-e1055c39b436	3a1da2e4-3191-7923-a780-699387b8fef2	3a1daa2e-4a09-550d-2d70-85760204b9e6	2025-11-21 17:54:02	2025-11-21 18:54:02	\N	\N	\N	\N	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	access_token	{}	21cde2346f50404da388c9367f906067
3a1db9ba-1599-2441-f5b0-710fe1392d9e	3a1da2e4-3191-7923-a780-699387b8fef2	3a1daa2e-4a09-550d-2d70-85760204b9e6	2025-11-21 17:54:02	2025-11-21 18:14:02	\N	\N	\N	\N	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	id_token	{}	332047e82e554b22983c07b231ce206c
3a1db9ba-1c11-86ae-b04f-60c6f0bb8e35	3a1da2e4-3191-7923-a780-699387b8fef2	3a1daa2e-4a09-550d-2d70-85760204b9e6	2025-11-21 17:54:04	2025-11-21 17:59:04	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.e2AnRhrGrDKDGsRBESn0GbW8rSLRfrm1tTD7vhJDQKcshHbEqvSpFKwfTtYx2XwgjHZdqGHguFhJhfu_pHTNWNmhU_-kzIn5YwO8RiLQ76_AB_636Lqru6P4tHcGSOcxuES-9pc3WJbdsSERT10CSnU3vXdY6Hr-0u7K8BsjWKPDZ6RJ_TmKPOwyo8dYhPveViVjeuxET8yyRyc1f-8Kr0JJmry5AnaUj2jR6oxDT3IxSkG8g0CzcY-SNIUoI5dWItfNux2sMVOYTVhkE5wTu3Mtq52a010zRrsFR4o0bWtK0ZjeXEA_Ga4b8OWEbsWaZiwcEV-VOzwTdXLcmGZiaw.1bmbEjTnIK8cSBEzlDgaaA.d1cSBB5YwpDLkfZKVV69e_kZAUq4qQLmcO-WxOOVnyMKtF_1kvpMHHH3wZxuOx2ZcwgXnr5_IQz90yk0yCTSkWA-DzPE6ELe1NMWzXijJh2whMzS8lhbIlne2QLfd0_H8tzwHDxq2mB6gL9ZlLMkchx3NL4RBGCnB4wZc5yFmgTrJHQ0JftszIipuxYOfy5jRxJQnCUvO3HCASxjwFo84EJRU0DeNhO_p9yG6lKKkDSG0ht2ArM2aVRgBlpqmxmSlI57L8pUVPxOLi6G2X-xprX2YNWX-nE47QYaxm2wR8pCtETy7Mx0NoEvBFxG4ZkKNTsgLvgzRvI3LCvZrXTJK8XOV6uGhCnMWKLatJjPlw8Hl2ie-7SMiEpqgvz7ce02v98ft3JGqwIWFXMK9_qg3I_6EAkTUiAcsbyS3oebXB5VfTImws3cduwV5X_3hLWy8QiCr44icovfy_sZUinBhKmqoilc3h131_U0691z6ca0Ztt_TwcY6J3CSmoaqfHmSsiYCrZkp28WXJzQTNU8yklEoTeJ8O8RBMVNYgAloPw-ElPGfhAgNXfL8wkDqt05_vlSNiZ0A_bNLdERp5kG_r0TMIuiJwiCGt7YUrWRDpXA2wUPm5t08ZdowL_HvO3GYJoxRgbgPeroNUo16W6OaBaOZ2O96e1VMPElRAB4SdnYWit8s1L4wJ5czszT2cnFh8x9CtH3X6QahF31MuKt4SabvslXWSEOZFMqZzPa7j89AYOqQ0oXdQQJkapZSmFRqhl2QMxGplrdapUprZpa4_XFOXmAY3PSF6TapoJj08OQUY0w0UxwJcgTVhUT4lVFDl04mBeG0RH8ngs5D4GPmNnQxK1aJEX8haRnPF96_VqDZr5TWil652pIye-lkChKeDipKpkVVouUmPPyTrzhE8Ce1EgQ6NlV3btTCHCKXPEE8hwPb_vhbsn31h9Q3L3hVE7E2WKsgOFEL_0W2-pYMOw66UOX-XQqrDik8RdH7G6QdcLEmCIsB-F-BBdjznFUZ9w1q_o8Uv-xi7tJ2_3HJeie9eMYMqesrJl8UQfoLLh2MVenm03LVdkMbxXJNWPHryKTqlC-YhK5kv6lWcRVWF7FeubSeWGIsgKgwpyoqPCzrkUbKPm5OryoXMVCQbYpYTxV85pv1QQ3AyJEPfsYcBQBIDt51YJJb9RDdr6YdXn4M7WLLfTHWf7lXIa3Pu-gqUhRmQuIp3bKTB20sLlIlX7O9DyNd-D5ZhulD9wOvy-cnADC3y_Ke8cFTgaF_f_fa53p9KSW0IVDxi32SvaanD5cCRZNL0cdBQKxDkCX_Z7Cl-sz1K7eOYlJ31F84x_ZqGF08h4HL1vZGlWBVw7WYJdKzG8J0cbBk_FXQEBxHWu7PgQi05XbkNZjZR3DrLgJLsykNfJiU7KSFwNq7m242AHVhJfDlpjLtPwmV-IqA8ghf_sVD-Y5TRq3LVBdLGT5cNQErKTYWNRuv7xL2b9yWIb_XMlu9IGDct4SfAwlGpQS11z8FdziwlSxfde56UvM8MedSuc1K5xEYj0dJKaQfosoqNR7pxhPzFTaAcv_bhiBhNKieolbFxU_9ND_1SrLfKa45NfWa0O0J60DfoGEtdZDP6NSX7ruQ4_CEEcsReKGG2GucOggvxJCmlA7rauafvapquRh8iycmw3ym11qOzQcMVKdYgl1uObAQC30zpMGp9y7ekgtE8AAy_y6Y-cwkhfnhDmyWv_mBTu3K0ZQBT3eyUJpsGjl1ZVLK3Qb9UXtHNqyJtPUICFCLdM09LiRQd6qivqKmr3kUe2YzUupN5N_no89AcqHen3yTz5dC2f-NlxHfJo-bSqBm7fthee1IhjpjMYia_ETMwFXDoLsXwhRmEDhjQDhuBEk0c2Kcd1jKfa5uifSgj4M10ftZAI5fox3xh_Gj_VMabDJADnwAC-8loLAuVwAPXEd-pbskx04gJwMbsRsA1765uKSL8PoTw15Spw1HR0NiikHlwDZVA7sj5GM8SCfdSSR8cxlv_4XMxOirWbSxr__whoiTDZDJqiYXiy7nG5j0zSA9JuEKh4BH52QS8bSOn5QOob40qaDD6PIitzvcUGOkmZI5gluG-tVQ1wqeliDJLu35P-Ni95jWe2sx-YkL0hsAsTuKbXHuk7z_qSG8JYDlmr-VoGws6WJ1_TU8lbZnKMizwVkcZWRmj1jphBoU6w6v-1OXzkYyEuIO8-73DlzaZXwYXFASplPIWwm2ufl9CpmKRh4FJejpdmmhjgnq7KdIthETJrSBOhJDmShDOhCJiGL3TrKJSoziDUUnWBwxgsduDXhiaq1IBhLTak6wXCivFpn3xe8VEUW0MBil5DlHgGSLKr1PxhgWlbxk-YxTqfCRiiQYHZDLHrOqu4ZLln-kwz3nr8VghBy8-1yH-ArKd9HtLdYNSwq8RkDiZ9sYf8KrpcM_sqIR9AM6KUkJNTvi44nNdOQwaiIK-hYSWCoXPa6uGx1B0wr0eU11WwgU9pktDSvdO25ueT8cspz5MNMMV8eVdDaT8RiJCJSI-kmTt7T-Bq5sOpCFppjkpJ4etxOOhRNnpFoGkgyarLQ6RzrUOVoeL3PXDoZFLBo6tDtH8muWogk0IknOfQS4S1MKuRhAq9rowiJ434Ia5yvUjT9kPtirmrN6P0zteFfimw18WU9CGNDO85__-s1jH54OdnvKnt9vsCBX-MJMSYGTbxGpgPyh_GVWd-NG65SPs1PtwtfCJb3TLvD2ImjKvtrzQ-uOT2uNHnp75xCQ8iTidQi6J-T689Y1Q_qA0sDmY0_BO0I00c4Jiw6nYIpfCuvIh6MIToZvQZNvM_m_9gOsMdCuIPQICo.ODfS4YGYVymC8BAEhj0ZgawzjCB1fFe0M6tNNLzbcuA	\N	2025-11-21 17:54:04.557799	IHF6+O0auC91frjs+MnXg4gUmZerD7mdr5YHcV8pzko=	redeemed	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	247536df32624884b1ed96afed02e7d9
3a1db9ba-1c98-09a7-fac3-f59fdd2aaca6	3a1da2e4-3191-7923-a780-699387b8fef2	3a1daa2e-4a09-550d-2d70-85760204b9e6	2025-11-21 17:54:04	2025-11-21 18:54:04	\N	\N	\N	\N	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	access_token	{}	1eb101798ca84b99a92e69d5ba91e24d
3a1db9ba-1ca1-7d86-3683-4723f2fd3e9a	3a1da2e4-3191-7923-a780-699387b8fef2	3a1daa2e-4a09-550d-2d70-85760204b9e6	2025-11-21 17:54:04	2025-11-21 18:14:04	\N	\N	\N	\N	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	id_token	{}	c10b62b155934634b2146d14dd56d640
3a1db9ba-58a2-7b53-9ca0-027f31ba1772	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1db955-e21c-697d-db53-2a221a850fe3	2025-11-21 17:54:19	2025-11-21 17:59:19	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.KoTgyDBEPmnmRFHJva8GL7LZJznG4AX2e0MADljhoXj-M_Rq3Phl3HDZ8RqDKenXTRIzn2nCGzzoI819wFY2Mm0qom4afy07r21FOhSaq3TywsfKrpnSuhwIjiZKDJMxnI-hgo4d_KWSK4IK63nbsqWdvjWEtMgDdViLhDi3ffEj-obh_-OLGCUrIuscpddskf_YZE8lWllVC-bS_lqd9yHkMe5_pI3LCi8Q_sn1ZijAVRvw-P6KNoC9dJ08HTi5axkNmCMMPXBjksmc8nYJJWcchIW19jxaetRk5D_zxnVwYGO1_KmIhrLjPAhMdvJxP47eJOs783eszRdZAuZQxg.jAJOfBeL8BvtVXddAocaTQ._4g1utkrTVDngIHEbjUWJ1LuUOMyFJ7gmcLjnDSDuA-isyaaOtwYLYeN9XzF82MLuBND5BwUtgbyQnE-3AXSmfLCuYUPa1CzNcIrZ3AvrO-WNieOw8bFXCEdlGLFZHMQOZ6JV9jTkjbtyBSBlIj_AO5UHF4rec0KXlQsQittCt1Up63UgvSeYIy5L3n5CZuKDNSScyuRPWDJdAeZALdU6iynCSdTy0OwuKUYDJ38Z5C7zsoRAp2lAK2VqHIsHqtNlKqSSNUhz2n1xgzdz21LdLG51AoD-adVSxLNTXep0DuSpNmJEzzCNdhQAHT6aSQ5IVzPQikKBLi_ZImu13EyWFDhmUnp3B3OilPs68hhLz-atvPrWRdyUPCupIGp44rvAouAuJQf_ry2JTGZDFzsIYJNSo56WG3LXh2vRGvv_mz-uWm4F2fuljuEJF39U5noK15bkJJ_pCnrWIcRD6_YTbsPcBgfmA5TPQcx8CEIInlK_TP0nyOsRHFsz1Fk_jmmL-8UuY6xH5YGZeg3Y8HtJlC5fsOncW3thgf8pRjW8dvt6VbikZqVcuf9OyVcWo61cznFZb9DIz9fUBRZ7FFdrJyW2OPIVHEElhzu1EgbkS-aSOVHRXv-CcLaY8MW-jORgl-BitDnXymJp_2XXzrBXQHc4mvMlOU5yqDXx9HiuQ3JVKDtzwsrWyTHfG3kuQ7CG9wiQEukYjuYUpoUSxECXfeZVYPM3hYGq_abX5AcHywkNPxCT4h1oQhDu_XNYKy7e5tqCoEd3uUw0PoZOwuqZMmKW7rm1DaDY8vE2jxx2SoV9VIbEiM1G5HdKsiSZhnU9yGB0wRDej4xRv1M2n-c6K006lmgNGcAoR0_0NK4pFMP9EKzyMRbvscN2ygUyR-skzlRdtq0UkuXSwlAV8SmV7ZwIRlaKd-PpE5PJL9aCSS9hxNvQaJ0sonH5syRUsL88CMIQYbJ1d-v6AmjtEDZ4kWHBwb4dauQmRm7EDDnPgAOKqdQO8bmywXerG-a82ICJHbE3F58D5WjtneqONVsnEtoliqZApmjt0lIjLf7WwZF9YdquPF4rB3lk_xVlmskQa10IdWLDQ34AnHBxfZFrBnco5u2VkYgXODZHYHxzjKW-R0M6VQQQKT1fdd4qU9rASURT67Okibv2sOIM6vC2L3-Jl-0BBO9LzgSAg66lIEl6Baf_-7y9DXgZn_xDcin2jFKt-TPkCL84NtZj4rMpDPUgHO8y7BsS9-bkT_3iCuTZsy4UNwTQgrfKGeDkc3v85wxa2QJy-JXoFrCzVwjXVtBNAPIS9QaI35vzqNwbbJlmGWzxOAO-lOTljmHG9fbbciJHYGy_nJ84ENq4pqfRMGXXKLoUS8gxnSuWzdjaogZj09d6gVuXviL_6MDnn5jZ--1i2V2ZC0KQWGye-VXNSNEzvG_XPNoyCBYF6mqY7VWsvYFYEc0R29EbBhKykeG-qRWQVFX63uTCOexXSSFzvrM3cx4OCLCrNKqI_X7CLcCEtlIEw4DYGA8ymlczGhpjEmndc39cAd8i9cR4qB8FMslTnnPcIB9gw2wCMJGvLujSTzwHvu3Y_QUOWRGAexnywO_pTwpVayY6lyYNJ5TKulrLGj-9kZrjSVEESFLq7hZ0fBd2UUX2sG-lhVbXG5_ImUeI4zlp9q2ifvTshLpKIZNjFypGdFGB4R8eM6fqGcy0GhzCidmuCa9aw7usaSL98k03DHLZkBPCwLkpe0tALXjTC9mi82dqX78r_Mg-g2VZDM2M1GCzCPiRZSRNTY4G_uC0K8tu-vv7ItpOgrPHSClZHzll0-qrpvkEvt_ovCY9C78BEWnSdkDD8Ii_qtr5KQqP9p4VV0dwge-s-44aIuDMgeW36481dspyvesLTVPiGmv5Ja-cfV7y0YQFYo683t09wlI8qOa1GD1ZwX4AA2aNgWAo1MGP0DPqWwW0il9hvtfFi9CJteOyituZgeRS8Qa8J5uO65ePNU3fNccCm_ZBxJExqIYq5X4xN_iWBTiQwpg3K0gMLM3xfwKK-cMp-p2otPwEQFJBr-B4UZ6AnB1miNMh_myvRKuxmKxfF_7B5Etkka7BiYs1SGPzH6uZb6zpR167XR8CupX8LbC_NYpLdsMlnlBtRS9j1CODyabwF9yM9T3tbv1Mb4IZma0xSxHOwzokmM8ba0bftRZD2rsJWAQVJ8vT6E74WqIEFcN1lSbFqAPnLf-I3ibd_YpOL_Vfv52GmzsaffIUq-67adKz873pGV8hTUHSQ2_lHOvagnZh0lpgvN0BexzrzxgYRfEcuN5Wecc27A9s3R5lGiy6A1KDuOaJcW-ZZLynjR7NzV72deqq-1H7UL3W43q.-nXYjqhBDbkzlAX1XghukFF3TL0Pibl5adaRWVanI-Q	\N	\N	2ucLMnTIakS+OZhBYg/9MTro3r+zp4cK6/MYO2w6U84=	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	4a144574962e4046ab3133f53933a98d
3a1db9ba-70a3-ec48-a084-a0b581e3cd97	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1db955-e21c-697d-db53-2a221a850fe3	2025-11-21 17:54:26	2025-11-21 17:59:26	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.Dm-uJEzf7ecdQMdqlzi16ooj0hymAFY6yf3_wKPpWHOP93v1GM8MrlmAgRphHN2S7VJJkM24ufQoqXxbpIhHRTDaV6bzh6c4_meU2Tn1KD-MKHfNGygwFmTw2heaZK8saJw5mtpbe-3ERUnqmlXXXW3tNvVNiHn9dKGnaStegMikqZoDHOz5_0wveKT59h_T7QUXLI5oQebiv4eS-IIUnpVgNWkky7YkDpvlYzSyg5Uua_XLKf-AszbCLv9EeOlXjYsm30IFozqcsBTSBWDiTcOWWFcTNjR2Uh_engKNLkB7d2oZ5QEK_AqL-UdbXdPH3Y3c7gE8ux9aXlMQZ55Dmg.iSvmIr4PQPyUgsE11nCwTQ.zTtv9P3Unrfc6p4W1TVsCcDCPOOBHj9DD-bl1kUPe71Mypna-VK8u0QE10F_FpYweoDZWMbkS01PjE3E_5T6r4lDG0SFEsh_GR6VLYg704wipEN2qLOqph-lpTlpaiiKFacUX5dgShQSJd4p7xdm5CdZsvFgFLgLoKV8aOhgVjpE_M_U5MF_Ki63YzSOIcjphZhfgkEokADBAL6MmTrARWOH6QpLnSBWsB0Hxl26qEo2Apwfq25hxkTQyznX5zxFOEuzcAlwB-e8m1-Kpor0xb0q17VW0YaUuRILa3QygWhkYnquGzAsT9zA7lkCukupdRTVev6PWFVg-dmVcB76LxGGZdhYF8cF5e7Vi4NE7acPn6jyjQomGsPgMZrKb0a0lOgXoqf4KFoGYU2_zxXW0JiCKOqNV-7rPSav6WlRAWaczqMW8X95yBL9vlXLc_DN1CukZL9sah0ZC7CU1Jj4DtxVaSdy1SLNqgivJmDWB4r2cGy__DJOWRiFHPBfSARsBiuq6jBJn74ZWCMjjFhPFz-fskbh2_jVuwiewCkIsFSZr7XadktGRvqhmDl4y-Y6uGaJyClBkw-H-vt9vuhDXkZubaYr_XdAXIxMx1PBlE6P3Cr6ffhV7oZE7TjiqKapYoObewlfHuUv4m15SIqtYO43ZuTjUHlCewnepDkz0pUiRzp_bPvWNxwltkd2gipsn8HXXeAIvzkS9MobBefN-t4h_d0iUFqQi-KtV-IxF7Fm1fhYaRUpYCQrGgzuQY1PGQZZwI2QGNKZSuZr_gAoQZwEorO2Qs6nbPVq1CeWv0nflkGZdRsxy48wioP40igufCvYGXdBuQB-Lqrb7cri1ktz3aJpnjbBni-oRLWGjHrrOrYVdrUGv_MybO5WxRDIO7M8BQ8oe9wN4YDrrj3A5eRADfNmGdIjwK3rrAQwyQmIXXfgPYAwMtcIwNnGlagEmqlfFG0wnGSniXQTyHNme8LZS9QmgjYEbPOVXxZiTD6vVhF1ZgrAK-F_K5ubsqR7dRfVBC2qSnabaJbHvlFCr_-ZqyQ8RnkbxCcHEio43IZ6-a4LiUIpeUGjMAS0gpIqpw81e2JrScWu58gYQe_OmrbdlPgrgNNl49mw4XYDSQ95aWpDctLMkCf3hjgW3VZXLztWtvq10UHPNc_2I4F5tN8QsNXWgCotoXLUGuaAaKH8mm677n-TCfVRSu1wAXpXRL1QmmohDUYzSVtnPBsT6Yvq8gqihx1ebCvH3Mq4xhGf1SldFzz-8T23adFSzEUnbaNuqzRY-rnBarkCc81YLiaqc4ryl-V3Gqxz7IKeNvuZ0Hin8ZdprBPFxDRJ_N7d61-I-X0vD0CAl62azJ2XEZvQowdQ3yIxaB_voo0Fo6jwO5uoMY20vPeJMjzeebP0Abt-Lf0WDFpmQ_8_rgHoyJXdA17D5GmJLlk8-jShoocGZ4FEn3_kg5rs_B0ph3VyuPJ9QEEd2zmeLVxxwXJ1j_4uwPGm9nP1M89Bwkbj_D_r9TLCyWuJW38WwKDVedjMeN4zfaOLBmzsBKsTiOuVYTID3Ffpogq8sNIWVKcOQ09Zn5W4iwlUrYvN4XPHKyOjYz45dhf6WVGa-k-f29q5PEWAHI63vuDm2d6IJZDD-O_Rw_5pIqSkzbZy1RVUo-XedsW9CkvZRrnc-ALwkPlk-S-HE7dn3o6iaKkEPbigD66eIKvTkSJXyp4H9dBzPk78GVlKjCK9IoEWSONmZ5RWyNPPXIENEypACETTIu9b6Q41QhF85byf_axYlVljRGpRgCM8OeF6fWvnfxjC2ElS5clxLoF79MZ_lxSXJil7i10-mr4dCzjhHLyoWosDbB17q9JyCgH4uChqEqUllsc58pXgd4-m0YgFXCz4VXdW3CmQsPUe4zPyt0khZiPw9Ds4_V7r2GJ1DrKEQMAt6qHm1Tfsjv7-MSgmA83MKEBMQ9Ucq-TAWcxljr4bQ4IuxBlCQJNZW9i3dTmiBndeuIDB2Ag2S-hqlhoqfYvAVlkqhf5zI4amq2lyRg75NjCjDH-FYac-EWdXMEhb2w5-2ovixMZjoAthxU5sWKk7qOcLwcRynaxrtSJC3dmyDL4bLZDLdrfdxjJNGaaFGzseMZPqqeLu2rpRYucYNb2PfX1KK4JS9dWBYJQGqij4rDv48wnLNmuEUuutfNK7DQn096_A4SaKwq8y-d8Ly7f5uzwtbKpBNxYlxZQrsk1PseIRgn3zyyvMqNcANjaifrMVpNunWLu146uSx2ucjDslDOi_p3mcMR0Mr-y9wYHN_I0weBbDNkJQ_fiIK7eT6LuP-WY2GlM3mALEMM1Z12lgbFEy6q732LRPAZDFgVJuWDWl5mBg3eJnUa-X3VRujWtRQfh9EkPdiCQtlScZcFLpgfdaWXlo4jDNskgBm4tE6B2w6kVt71cfFvE8nORzeDe_UdDA6ILNXc8Dwvj1tq08pzz3yiDTD3wmiFgzU0l7FyJvg2qzpaEH9gBuwnqPwNAz2x753sRs56PLCslfETHAmPtQw8k.T3XEIGzSViruIe_36Qymhs4rp5_xpqOsq0_2puhE5-Q	\N	\N	YD4qo2U5hZc5CGeAV6efWDJoX6l2g4yGL1jW2ua4kbc=	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	a6c5bec520f84a4fbf7419c5f5b90b26
3a1db9ba-9ed3-ebcf-6681-70b1bb2962de	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1db955-e21c-697d-db53-2a221a850fe3	2025-11-21 17:54:37	2025-11-21 17:59:37	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.pjWDjzwQpfDMCKVXBdy661hqzC9gg0q7s0Y_mULdUG4wSoaxypsaenv07JKpuwE6OYnTXeHdLBd55HlzQOgrIhxqZK54LGBMh7GQcuQY2nBVO5Rtb9rdT6_QrUHQgc1BJ5Igz4Jp_PlHK7OheLyC_05NmZDoXdwtioqnxFVPaLRdmVrneveXeA-uOs2oHQm_EmP8XDU2TZRq2pbo8HoxGsw88BW2Rg7Hksdtu_miMTRqmWbBq358zcjnn3ytkYxRsotSbMdw9wE2T54hd1oBYxPrkQvXcxjxMPb0R-Vw-p7VlegjLQSFLsLQaNqa2taZ0ab1A5L7LOqZK5zue2jiFA.nWWGQSycz50ULp5PEL1fLg.Uk4eLcTHgFtTmab1qYntozSDIFYWh1B9JgzP2c3ezwx3ZMrJHWjInNv8IblRKIx_CYz43nERAE2iyNEfqsJAijE7dzs4dGfqPLl4_Oa0EZ-eX_EP-4k5wOD2TGp0lfgmqv1y30kb8DnbzQUcCfXGqQ1kSkZ9XzLbrTVwTSaCJVy4mxxtg2zx7z_koAXMTYty-yCO3TX1RlL0qlB2kWwOfCE8G9qSJZkY3y07JEvyrUZcIFzD26hCt1T0j82tCAikNOZ2jXPzt7Cu_eu8ApPbx7rVKCe0aieggMS_JnwZ-NDhfz_8XERKhC_ppQUlcg_V82BV5_iSuyxkYTuZkEfr_5BGzE1nvCauHIKuEGjSo7HHF8fo08jBr6UdPkOl8NPyIVyYBMPRi8QSngSf9d3cp0_P5oaVYIg0JRryG_-4eqMQQpo87g0hZunkVkfuOdimjrQ88dbfMdYZpswR8TWzTGTVdJl-vHRdglX_XxLBIWJIt7RuvEm2bXSejVDO0OsgiPN1xYDdq6pXl1XNWQTym6gil3DGm47-oU6BIetfub5M3RjYpQRA0GXN5aLJ0LCRkpavc5tuzMl0ZseJp0trXhJ7a3_gvdKeQUxBqY4x0GKWfq2W3MTaMjmyPHHeXl344j7neFOXy68k2rCSYbREI4t6ixW7HsY23s5aJoM6tPHdRtSVLuswkom760cSfld0GRRrZncAS78BAj0a0p-OhPYUiGvSJm4MwjOqnK-d8YdfYOxrYHcRpPE7FhAmT1WDdEbYreGD7zCMFyAnrfalW2aco1exgyXuSwB7XEUXenGfkeltVDcpeqDrw-ZXMCCkylQvVUgi6pXo4d8K6PfZCkNGdlWmRTdtepKftQ7Jeoyt1tuKtQngwpa557cf11QrilABfrVK4QMIPJUrB4Myph65_VEH8ZYbOdGK-R1BJHK5WnVSID-PZ3ti4ghTbz7Q1xLvm9gz0OVfBFAnEo2K75e_F_Z3ukfGUHYnU11QOGh9Zpbkp5zwbt-30M02sJV4Z8PBTMlCqGp2zqMLyinDofg-bnN_37lvg9pfW8AVtSY8uWgAVPYG8HJMHRUfvgXhHgMDjbvgEKPLdhjJEbtkD_Qm1Bi7_Focxkr1-h_ytsNwBhPIRugETu-gchw26qS4WxC4rM94paDwsmae7T9imjAbUz7fsqk3vreDm03rvvBsUIuVKHQVgyMQUrPMuNLYCf4VYbOlpAwp8jt3KuN0CR21f3uH5JE6f6T2YKGP0k7905HqZjnvfttTEcCvX0uHCdtyvDboZFgLwNh25IXzVsiiFFpSpyxSdeQv6LsRfFgcZGHbB0w8UyyWb1KK1lbtLfOkOng3J087ML0H9iBldJNSrC35tsAEt0ATokhND0pikGFtPNKp_G0NsOsuk_L8ccR2Gss6cfItvghwvDcqgX4KJ0-ys3fHXzE_EUga6bRrLldP458hd_UIYLILo6I7jYml2DfpuxXpvTv6or1-aa6xbDnvYhuAHmBP07opJixwjIHPn7zPI6g2hti27l07FubgaW3suSqLPa0ozNKUSa_er6ysE9iCPdzIzT6V3F8ncDojJa7h03rJI4R5pM8W_Gc8XKUAaqLg4CpWKlQFD0_G9dT_Q8B0Kcfib4Lkr5zuWZGuJ35FWJBvBtEa9JMkBbKCmfPe93sgDVb9cca-UAc7X0TR5ZBq_wPutvjZyG6UvnxGwnVfI18PDyXNdzhc6qhCYxVVXG8Gwj0DlwrVCknWY0032NlZ8iFtiKNDbCGYIdWzx_ULTh_UhNwoquWitZKKi7eWZ7ufufAwYTn3yaGLu3s31LsfXbg-Xgyi31wlpx2gz4Yt_WcYvw6HjBEByOnRt5xddf-s5a5DDGsmQ_kqe6fe63EsObMqnnn54vXha75MQ_bOA6QexInSHci5FFx7vY0TnbV-sIQYUo9SYL4Qmb7T0FhDXrcOm_RzLWnX6FaTDSo1mNzkEM8RmT_2QN0RhFCG2WNn4l85Esplb0iZiL9RYo4ff9dGlMfaIcYSwk08WH3axngUPVc6bi8cs4dGZKEYTWEGmGRqjKgQ3x1HVd5uxRGVm-10aqWwnKPt1Q1e0HuZk8Q9TqEYNq3RCspI7n8PDVTg7Pp8kZSkLcsLBeBlLg_0G5F23QxvVfgElM70K0IqQhovQkRExynZIhboQdpqXB1hQO0NC83bM1KRz1dxIW_9ciDb35B8P7rEjZv0t5BFpZiAfvahFENRk2dXG_eqGJz5p65EpNX7UdpuHNPU2Wx3t-LwfBicYfYzF5JaxszT2zGyrhRHAKAmYVgsY7Eotmgy7kL15MuLkDf1MlI_LKaxAGCQNLU_4-dwu2mjtH4Zvqdxbz1xXNJOomolpQOpbzQR--L3tHkrPawNCcHTdnU0gEAfkZ9m0cVk-aeWMTv0y_s5aDft2QLBshCaVau7dbH8Hqs88cgU0fV-LiBBdUJeyFVvMtKs3aHmvGdnUCdiMZa3hqX4VAO8DKRx0WIMnqdSPrB09YwBz12yAMzPw8EEZTNs9vVRr6o.lM5ZlgQlTocAvZX9FrwQPDfrvxb3I8tZOMeMJT5ak3Y	\N	\N	O5esr3pjgiEuYU2W03cLtgPjyU+zeZKO8KD3FWBDw84=	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	2a7a40e0881e4600a54f60c28041c6f9
3a1dbc88-9d82-ef98-52a3-f19b9d3c8016	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1db955-e21c-697d-db53-2a221a850fe3	2025-11-22 06:58:52	2025-11-22 07:03:52	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.Gkqkea4BG73YSiuC0o3F4fhMh3Blga9jXEvFHmuZq9n5S-2MbEqqsDHjToy1paIqED1ULbqLq3LQx9ScsKAZJWGrPgalak2O-iUxKGp3kKb9t0-PuWi60V5S0fIa0XUUfJI_JUuJmAH_PZ8bjwlQL7UK-LtfcJBgCl-Dgc8CTqLp1t3bIVW9TUe5VVkrVCx0Yk_6UD3jtynVthr08eeTZSDWH91vBaNiFN_qRnaUHq7FrzNsVolWjrBo6K2o6UwbcNBZUFgBA9aIQs6ofgLxM1X_lZIH5CEoBBUA7PpZZyesE7GM64JgNGpwtJVu35BorFyB3-gnQGIBF258dlSbNw.Qh7JPuJckf7QKFpvtfkmIg.xckUf56EltLN1fUevmurNCcxRlcF-_T872W2jcoARaVFB1_3KNVVh-_68PyA4bs5-ked64SrQblIuy5WTXZEHXLutNwKKH_PPrNhlLAAgLbY5kbnQLB7epG9ePICWPKGa7XHeHix4I3xd4p3QP3PS8wQ0nfhFLVq4-8C3DqGY4Pql4zA8U3KCXqK2h9YcAQJUACWCjwVjfjn9RhzWntjcJdtOL-bWqWJ6aGOjzybL6XGZOmSA8aKKbzQIp5bUmsT_eezKVz1JJE6VapgD95hX-gDT3rB8MxeNN6senf6hG55YiWqrYF0Kf3fZEsMvnPkd6elZWg4dUaftZ3VFUzUTCz1qEjjTZ5axOh-gNVAksuJ7nuLZ4wgVtGz_nZQ8fOYSu1k6JTQP6ZJDIo703DFhiCkRsNl9eayfX07oLqa4taGUrlhh-JkzF5DlFLJJwWpu4v1MXwNhE70NGB4rfZLfdXufE9s78E2ofucPPauIQtpCiZhYIjUSoUHvh-I2ZYX8hJMk44KLuClblX406qIIksO1JqKYLfitb1hXjQuBoLa8OQ7IslNgTAyhWkM7BCiSy17kkQOssQWcQscueyqdYyXAFqKwIu3Ja6P1Qyp0EMH4pq7fz3kYHyFtUDWrdyZLeVh5GXLHaAF-Cd4nXA38wsObbL9M8ItmBD-H1NA2OP_3zHCPHJl0K8hY6knX9ENQWSN6KuNU7_6CBf7pfDx5extQqAz8th7THoAvn-c_xFO7jPfrQL1CGktuLzZHMU-iV8deQpvBQ4_Q_Y3I3Y24DcD3I_yG2BNrXzF_L3hXMkzqgawDU-2v6_US89kp-VgAYVzYYQP-viBvY2j_QTQ8aaznUoddXg05NT0EEtZ-bK52saLPtD1eKKIqeexchZuIj7RQGYypz-EzFjz0PhPcHqPKOmD1oCnrrOz-0QV-W6tRBjsitrdJVzWwRHwAEohk8j2Sbx1LmpvgIBXkHTnN_QxwIemDE8Q9Sx5LfthOmlbLQ86W147YL9W3w4T9-ojCbL_eLmwa9L_CaKXHRs9e_61zhbBALT2Uvyg1nXXUmpkZJSZoBLmkMtR6wtaxtU6duOSzPn_MsaB5N5F20eSNJ3zd0s826aB3HgCRgNOcF_oGNqMIwBR6-aj1tOsPV-FeAa_TelhLyZOgqUGPBbN5UCtSxAA5Gng9L5kJ4cBVOoLHCnEpZyQJYRlCQCdzufxO6vG0xRSSlaKdAGZdM6G7ctLm6J4vnSg144cIEz1kdHpmCYDWQY2ef_Ut4GGP0IP96rh4_m8JDF_0pzt2VT_n1apRnXpAunZo_AQxTAp8QzjDIl-bF2zpPcF9yIEzuf_7Et2vSgsBS_UH-zZMZqAhqogoBejLBJWvSdtkJHIY3-JRJeMzZTsFekoLxpWzWNWI6SHABXFmt2CKFGL6ap4p4q4pTAAD07p2sESHH1AM2BDIXGmLwEo3ni4gZMZJZw2gHTfr79gf7-ILY2eoBE41qWe2-GvxYjqjp9ItPlpm32BeLBH91iR6HxzlI3233V8-eLq2hTdJK1FVYe6BlXY73oFqmZCz5mk9-PfzBBRZGOGUlb_FpD-17LnWKKgVdzNA5bj9De76lvYrugv0-JvZyKDK0u_50rPu8dDeiQvgAOqt53dN4JFU3TXMhqvcuAl56z6J5LPaDqlfrJktJ4-u7idTGD6DhjHFiYnTHt0jHY04gWB_slr_o9QQOcQuxAFhLzJvgXbYb9YdDmYtiMjEBeI-odxbCyrP3gcYttLx8Tbt_S7tKScvEApgL30PHGUiXr2Dda-4c1xF8dtImC9IHSXNRATO83IDQYmpW9a8tfbErDRnKVPL-G0Bm9NhuFJhdvOeEbCAvO7xOjz4WGYkmHWheeF5X9FcB29JR0BbDejFoEKv2Zzr-qFDvyQ_qC00Ydmh4e-Hs9dWI1JcCz0REgytcFavenvfE8NiZ_77iSwIi1juBT0pSdMb_q_8hxYp3weBgL8FaS3-47pHKWF0MlPYL56-l3XeA874G94PDl7OXOoFwafA4CkfM-vZD9BkxyK9facvMV1vx6oieq3gGgilSMJJnibusgg3Tyxv2rmNfvBcz9NgGozwE1a7pJyLmcAdapzMdy6MXkmEoLlrhcsb167R75jBQ5R2w6Mj_5Rc9ogo545M9gJ8-5QwCfc5TARIDdQJs9O0KokQ-eRUxrkU-tgtWCdjBcjDYV0gVivCQhsRLe3pbP_MedNEUqdmd444i0gJxmuottAckrpzUIi0sPYVnvYQR4U3e91itRkJ_FSRTMSWK3xOhq3kzKxFROE5jX5I8L9k0utGzPxfS-tNQeNfuEy2BI2P8klDIkXN3CUZMf1Vp38LvRFyBFJSkH5RuhQlT4orC2xgHY0ixPJRY6CUM6ochSEZINpz2bt_Rujl0KsMEsLVITHPQ-kjSnSSy6onejcE3x3iVf3K258wO7th_BtAVci36x5I5J77m6o40M7loRq5Sr_fyztdtDePhGOHuX1tpNgK-8Ez5hBBcNGYdWmAlVAexlMi4s.ncQPdZwCyB_76MWgpfaMji-YOvqDNwOzcirFgScY8Ng	\N	\N	JXmTl3qcEEaoxClshIrujMog5LODB+Xn+gZVW13b30c=	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	235ff3e1ddac4d358943b0a08817cd63
3a1dbc89-1c4f-e6a8-d91a-6491c8b1cb1f	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1db955-e21c-697d-db53-2a221a850fe3	2025-11-22 06:59:24	2025-11-22 07:04:24	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.SKy5-23ZRiG6-Db79NlrsdTBzwy8XohaaOSnzQzy9ElUDfMxDdNOzTF8F2E1HeZf8IZrklk_YGX0VbUHHg2FKQ8KXPKxW_wvU25MHd3OfHIH1715bowFhlKMsLUmUzCdYveYD-sngcyH3oN4x_uS4cq1peYtzqUOin0Lh2yGm19rcEkYFJ8eWIftSy7qsmLkqG6p70TiSVGRagnYxbrSUw0FjNXnaebKRuSJKxc01hvxkMWgP2vdTtkWmCKMrdUqzHYAJSwP8Xu0IhWBdnT8YdG-JR4kNuAl2-Eh7kjE952P3DDvXU1jqHpiATFOecWs4zrB3FnjFsi-nmOQ--QYOg.nHj-sZY76rXFmuZ2wMtwRw.7lA4cme3ciZG5KV2JXLad-6SsNHFno4u_bnLO5piOexz--p-mPuwH5Pk2XD3hkeCCBRKmDrkN09e_O8mAI4liucjiS8Izk5rQXSwa_sR7YRSD3R1Y2ozFWB90yLF3_U_Dwq8QiarGY6JJH4g7Dge1EftlFcLbRuraDCtqP_uK4gD_ERFl3fI1V1dPsP4fbW5A5xI-VFNDTNA2k5NlAaKk0FYUYBvB5LP0dLaznfPW2EiWvLb206rFNKIptPdb0ChoHc52I4wLMihuuI3crpwjKVXOjUyA7W_U8cmQEBDSGStvNd_zGLcdoxkG0-C42N-B-LXyzKCiSQE7sb74XbZ8_-MiNFqq4Aw5a-YnPfQxDD9Jq4VnkLW7ZqF_HK0Wr3RzH7FBq-wh7suLLTmRTX1--APmEwcA__hTBGkqemiZBnOeZKf5cb5ZLdljZqe2utMSwdlStjUpblNefeDagPXOZdDTWc0VoXcMuRHB0FTDcwf8QjhY4NO8_2XhQHCyMhcSN6OElCtB1EFmFj7ITZXgtGBb_5cH6GJipxO0hXOSod4lvxOh6pGp_uM9OsUWotns16njvzo_7g1sLmFZKIWMv0r9KvMfiDE3yBjYx2mdB9WKAul-Gq1BjDFClTc2snlJyONkQtoWlSTzQ3_c3hu88_1uT2scwZzt2kpFOPssKuJPpHI03xJXc_JFRGVbgGiRTjPkgff7j7mYqxgArp1ZnX8Izh36UsqA6u2mK8CEJVfwx6YMEQMwAkgNL1CsEiZHCrpEy-UJm4h4UbSiSCtNa9z7lQqZ5ZY6mnM40YMhvwSEkkE5JKaoI_UmU0iOfCTysnZ09sO9V7l_briQXVHOsJzf6_ryqqCsl3rnxF0MJYKo61laoW9Xfl0YtTlnXr5E4V82snu-5hHMB6xGW7Tu5C6Xo0cViR_Ypted_1-lsfgT2-APgfLoy0fYfL_PIK4pn6mC_kzQmvxTsKOWvEzcpAvos3AHvQ7-EWbTyNPpEsanQxMBTGYHSkxo_EOjbw-YAqNRDa_PPSMu1rVU-h1gQ4ObxLL4ogke8-OTwtn1eck5Ao8opyc5--iEDjwRo4AP-HLTytADEebJ-eI02dBl75QjKfb6yKanl4jjciJkprZMIETYmjOwx3xG7wYoMBj54e_UGXcXQTFkxA4XtHRqTP3J5sgNXhdrQnGdiCpZVzOVTkrJ48DsVtUuqhWQ9pOMFUTPWPfcraDgDOEgTux07GEXRA32uDKUZb6ifihsji0itlpF0rDeuCHQ-pMeUelKPfBvFVvPuxzf6iA-pxf9IrjZkx1YFSnmjGS3axo4xTJ2lzjA3v3MPUD5jV-Tyxul_WC0eTg23ue3s5j7IYJxG2OkJldYsOV_l8iZ2XzYADGL0ifuej2KQ-xv2yhQBitLcF-6sFgoRKoWWQ-gOn85o0l3hWPTWecp9C4HXQdeUxUW37MhmEcSPPoMHYgJrdkNhMFP7r8C_6f1jxVo4lqpjFZWPuB0GlUpzjWHgujminTcjk5F5pClr1OIJ_RHEVbppaws1V_1CjeKLMfQumRvjsqqKsYC1I-RL3Rv5jYkvOnRv1DVPVY-vckJ4in-sDkoo2xUqjPPMLY_B9fWdSi9jEYRO8bTgfbsJwpD7j19HYL0pankjT5T1bY5G9QlwjEoQz1sT6naF3CR3Xf94UTGxvNmegMw_jcpBWeSKegdVIvbDONhzcZgFDY90Ho2Qzpt8TjwxnilXcIDzzk-ea8I2nlf9P4MU9eALDd1ggttfakhb62PrmEaEYCwsfOHj4GeVSsELpgKIX47DtQ6H54Hi2S-D5z5R8vPsvg1I8ardpMEfDlTXvS7N2CcMIh3FCSIfedt2UjREfyTZCM-12iDowvZ5AV_p_r2_5WiJc72crikbVJxoKX3WsdJ9q7o65S4BfQT8pbLFHURwfMgb_WeCWyiqXOMczOZqhNuDvg8XHo0l9gn1FrMHmi1_7GWemjH-0ZsOTWZG2Kwq2AqZRMMf28F437daPk6CuupbpnLWecXrhqHQ9JP6TPvC0EGgkIv9s_a9o4FrORuZTKFHxcXlGz1ww3ZDpqMLiuzXNGFgJzU_gZBzfW9HF9U56ACSTf3BbrnrSTbhbuaI6B-4WhwoKLp0uLr3kfctm8cqwQaDzLNDY2969RXSERxZIYXeGnpzsDQJgfhopcX9Y8CMLbfOIUIKJ9Cf9nxJwVasWzM4LraQn5UxI-KI63Gc36Ndup2fOp4fS6JP0VeFU9Kri3TxCA8A8qEd-YdpmVvQFcOwI8u7Le7f-TGCN92642dTKNbh38Dh8RGHRqp1GKhq7TkOKUEBpFMCJ88KLC6Z7CFBnplMS3lyK-_XFUfa1oqRU8FE8F_i4lrbFZGQc81hozWFw1Ry3cBIAV8lFwNXEjK6jGpQa4bD0KS5w524H_SzlIs9MZFyR5B3YQ-o0Yzlt1ExTaieppgoVoxQTTNRWJx1W2QZuIMbIB4BgimG3A0HHIXwi4DcfxpASGsPIzJz9WRks1-zpy-REZQtLLRQzVs3s.tNADqFwuwg3Rv3RFy8KyxcABjCheT7MPDekZ7ncEvVI	\N	\N	dkMR+R288EwO74wU/ovJdQk32XQ/lerZ+GZzN+qgIdo=	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	ec0a5b3e3bff46bbaca73b9ff5684204
3a1dbc89-77de-2eb6-e1d9-54390a44939c	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1db955-e21c-697d-db53-2a221a850fe3	2025-11-22 06:59:48	2025-11-22 07:04:48	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.Xs6cF6qWWIRoUZE-11NQoViMRK-FAlHLHSwUBQyq3G4KepWMt4nZ2hrUxIBMachCyjMIr0geZ4-Mib7a8x24rPz3HNme73ZF6NaLqCrCxGSLLARWyRM5cqBQt2SnYyWT8S1E-iVG31tOesIEPPjuQwHkf1KHWh01ir0TI-nN8kuSR5gsPl-I5FKdsEZV0xibv0KXwK7-o8NVutQkaRwzQLoUZyz96Sncpj-tmy8E3d6q3PGaaiJNg4Yb4DlWLUhdMODw3TcbJdfX8OWebiLXzl952cd1grDT2CMC7GY0_BI6aODbp18vF0niSUPJ2asCy5JfcdpcCABXhNxN8KRJbw.FAhvRJf_gv2-MJiJqEv1hg.SssfDcnMJjyMpYJg1YfsixkrBbxhuCkWHWl9W2xHo7Q5LauaZDwhYLJaLD4fUK6xTZd7U9AVYQ2tpjTKKFFTyV3xf_vxr4iPTn0PKeUJBC1-7FXTuq4qXljP0xt8Uyj0cY27B_qcJX1l7AOr_UmCdzxDEV6woG91HYTm1y3ifRYVpd7s532CGZrE-bMGId23U2pXFRKYVgt-cTEgzU9WVo6CxGPA6gXmuFOZ04yP6fPj-Fqe_Ww0bdz5HCnUTOHerUDFzlz9_S5FFY9e1pdtprsHDFQtZx52ST1dWu66cmy2qP_-GYaEw-KRP8wdqaDF8D7fyoPfH85iDP20Y7_1VKHkhN-nLqdczwUcXOVVyT3Mjhrl4I_F7d0djXZLil3Qv9yJW_wNFT7ow7U_iDYvtN_TdGRlpibXk0sJSZchiRiTO2UninfTB-YoRk5XW1gxJ9ib7_aC_YlQJaR0Pb9JX1_2TI4OMfuKnAVOLv-Z0IjOj4aaeKRPfqtULlwdRqb2Qf1vnXBaGOzxboufrqhfeGKq3fkvtvPwMQcKj5qgc-cIgm2bcPXSvdJtLdnHkoUx40ttKOr0t8NKLPUSo_J7LMEXRwX6shLaqe_vhWHZtMbLBYohzheDq6RUV5RnuVXICPIJIPrsi1dMDWBuHODwhfHDreWQXg81mkvhz_FU8T6N0N2-TsCyt_WBQ_bXmESc55vvUKo2NNQd5RtREh-ghwvLRFgECFnKQilnYmPXxRIimEgg7B-C9QRX5GG6Zc6stXLaMYsypk4-mu167TSVceb3rlTlLm0_ED8kD0s6aMXwpV8fCC3bie4x6MNQ2hPYr38_8OZgUI6rP4GrDIsKnmFKlQf8-9ry5wYKiPRtwLkv4sY74E7bh0v8I01fZ2KsdicMlYY2MO3xGAZZfNs017YZ61cQiHlo09uExG5oS7bXKbramPfZ-woJF6Fx8qWEiw-Od1KHOO1Q_Xr7piGvlhWv1pCRus9OkJllRGMT-8dlVHdL4PbFmiR2eQqHhX-uZMI9Dkw7erwK4YVAM3vtJFvOEoq5hq56TDeyMMixC7jQ74_6E0b9qbyjkt31nr3HFP8MIVR924AeSLqnDT8WYb8KvEQ_qHC0uOn4RdCgqxiCg91gjXjHteT9DLC36tq_TM56WNytspkVjuG1BWjv5RxbvHUlJlf40cRAn455E9Wz2cir8_2NPksXpN3k9i9MTRhk9ix_1rIqYqeXUCn4j09NQQ-cwINpJDrgYL2MN8yLpq6RLy5IbO0e3R18uTCbei53wC5OoJjci6swtEH-49BEKSkXm2q20SPbAy1Ui7I5aLQIMt7hx8KN8lKIHqI5KY0VpA_V6uCVzj_85vqLUcxje7zbCfCIPDnKTjbS4ExD4z9O0LUntUbmbN--KfZr69qhvEuo-71Lp7Jwyn2cY3jqE6jJ4v0L8LvbMPKMb9mpwQ4jzINeqUez9aLZ8V1wi0TWre3NPTLHGR2k2R9f_b0FftYKw1rgCscNjQaZjweUwYaqR_cTJTfpQ9m_iT-Ivb4ZjgfTxW8CFezs40QP3B0Snw40vHwA4dluMwvRIenOBJGfzY8MmeJKhXueVVokfunWzk02RmGKWabvDbxA3fxP6DeJc6Bgx9q6OpM1iuOMpUXz-fFURLI-C6420cZMx6Srahkq7pVbgDDILTFSHDtN-NWF03gZO-s_YJd2yn5qfw8HIuQpFAdtrFQwAao5BImh5xgT4a0Pf8Qb7tqe4Is3j2Y_5lQ4eo7WCU3_w6cJ40aetq5GV6bVAoHO_mfcdYPn9ZyIjxxHIGGo53h7l3PgKZ9w8HqPFZGnjuVJaFY0fB_v9nYV7LDtO66TV_jrQIuqL3VtDtPiY9GK_Xr1JJ008eXqHqc4h5pMOC0-NVAH7ox0Y0LDBEaX_OzW-kiPO0fhSfSpYMTf-Si9Xo2doufbcn1TyzFs6gpS5ticKlJrU8j0dZPRJznnpvMHmz6Eaz-tkYGJ7vue2KG_dbr_K3ODbPSAqvyYTbx7WvbgjRGN7AXonV6mmznX487-Txxp5FsAN7HjKL7YwYq5bpr-g0EizNjYrCJOWXsHjiskSxJBiAVHZoXVT-B2tx8fCP90UZHWXID8Y6Y9uCQcNibcr4lCM7gtvkJq-CS7MSHiaK8FW2CntQywFLXJCH9Yz8W8-mh3ya1Y20C4v1-8mV5cIsLwTBiJAbyp5W6LE8PbhBc-tYKzAi8QqvoPseTZCa2htYpjxb5O5OUUbysPipXM54dTJ4EMLAJ6FzOgaYcvzjDfycTxffJc8ZZt0vkA-r7dY_8MRUQqUzxv4bD-SlqU8fEg740suZUBM25yUg1-NYdPgxR3LCgNxUD5_h-xmr-lSUS7plmxElJK4xNdjtlRomF8vklbUysEbGFQEV-0Abj5oAiYRBENifAlTzEqgZIwAAa3SYGYMzMBFTc_7xm5Db6wcEveRgztGKdXlgi_g67bk727medVoi04BQB-8QuIMRxcWjT6wygGIG9oNsn8puEklkfzhY6daJdbzm1paDE.I922Lvv960KSOuN34vJc0wTNmUOPY2v3txcH73milBY	\N	\N	aq40EfM0ZNOmtLZ1Y3UpdKAQ+B3+JxC0Jr9Fzgqw/qA=	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	c56587fd01844d2e90675e76cbade5e4
3a1dbc8b-c874-e960-3ffa-ab1f8bbe275f	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1db955-e21c-697d-db53-2a221a850fe3	2025-11-22 07:02:20	2025-11-22 07:07:20	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.jjGdmVq4f9XRWk4QY0eaH5URIS9cclG3Mh2NUUmiq8kMGOfhMctcCSIKhA1wQAuV-6NASyhN2Owy-7i_V3ECl3eudBPd-N4DT-P_BE6mFBX7jrZ2_tnlZjuuL4_JawGUseThbx5-K0VGtE9s1SyeLnP6uubS8ycAGJKnMMFRVDrAPu0fFc5j9psapUfS_lZBHZ_ktRU2zK9iDzdfztXzRznHi_f0pVxbAAFp_z-KP28ZPXkoPvBLR776C62Qz1ssgc0SH_U1-tDzs0egPhTz63oOGoU_mYnnPNh8F-eHMkppc4gWM7iUnTPunFbCB3B8c02WhiIlSdLBRjy8ypo0Pg.Sto7Jy5u0iQmTlEglKYZWQ.Qn2k10jt9ZydMXc6uYvd7_Ff21PWK5yomf2oyfcPd6DUQ1rySUOJAvdPwYBZT85I1fUs1AsvAQ4lHSV5og-GOOuLJs0WnXhSHjZ-wed8noIAoPPTzEPm_hFRYkiDGWFR4FH-wIhHLJC1sKp5Exfc0Q3LFszoupfTzZINpJnWVkLqdyfv54V3_TNVmwNqNavt4aO3DIZdc_OKOApj4tAM1e-xsPCBet-JxoJFBZ5HoedqSfNYJGZMJcV2w4IgPzjCezeZofv9nUa-YBdegb87S04SAwa9IkbHaWivoXiO7jGXIgYNlOcyiolCT_9Hjzc7DLjorcDZqz-vY7VKCRb8ExbmZI8bgP7hVFp9VXmBFDXg331RsowjeNQCQRw6yMyPNzL1eQyUbRNMXCkGxmk_eYMjSoWp5t9v2XKRB6_X_ximvSt0pwsBOSUfLjBxaM896paJq7SkqmFRPFIPLLPWb65lXkGzipQM9lckYDUfo539pQ_sx0SRkG_SJLXIMhu56XJFg9udPxuD_dwKUUnzfN8kjNcgxH5pLeixvSmrdYzuuMmiRVbtT2Xg1T28mt2gQ250Y1FoqEEJUnlDogafOebA1ui3KMQ3f5b7e8XfEt_u3KegpWpMCmbCJVepo6hx-HaHcoZNp49mzpufUMHooUKffgjQRUe6S9VRB1rjhlj1z-5g2VyOLuob-yWwSBsn5YEurbnxAhUA-NkGU0JJZ0sC61Fw_DFTKUGMqmv-qX1SE8nWg0_u4AiyU4YUhha2EYmJRL4rO9C0GC4eppkmCj3NtVMYJ8MmDwgLMUKUNIcthfjjTcpTtULTOLCVSDoWu7jvtHzza7nJSACk9_lzUb7kcE9JeOaD2w-sJN4kwya-ox2d4KNFZ2BeKK9jzXQts3202erVnC2DFwVMePVTAyxqRoMEZ6d98eTuuaagpg3yzhVbUEmqRxwGQYigGLRhiyxVc2HPJpy0iOGe5IQ0tlyg8jpxw9IdEI3RoXq-gL_mjIkH79GLf6QP-ZGT93DH1FEfIlDyCc71JiN_h182Dmsg_sjk_iApykTiXdSeZRokgJnKr3iPo2KUzWuSQ_OOsa0HzSBKKRF2G_sB9Enu5Gl-WdEMf9PTQX4dmHPBfhFIasQ2OmKd2SJYmGkT0ZVoV4rNK7GFk_-tiMAGm_eNhM9bmBhQyzheFYTkEzlYSo7RnXFnKkcLRH49WAlAsjATcPmeoYpsOnNv1ueDv9vJblrRUhe3qSwzaap-5yXBgZ-bVsl_W7vrevdjmWmorRnLF_ib-ZEnMHj6MD0hzLIfgLVJgBZLtsf4jhJYWq3kd0lQj1xp9f-I0XZV_rkgrjReF3BEAw7Bdxmsy1mZawapDeVrcTLFAjAyEyD-yr95A2qfvoCA14NrggcRf8KFIxxOU8JKIvUS5XN1MXQFDu1s1YobYsjWRqd1p8OhlzHlV7SdeHkatAfyeXyWK-iO-bbxwW55oJTzquMKwK2z8u2DqDCxykRfEF2Y4uy1C2XRSkDujrHd7xi8PmmBNkdMcHM4-us49YLJIJ8N5YpWG2gNiYPG0UgaoTEDElbUPpyzsN4JZn1cov0MYs-fFIuLsc9Mkk10uHfi-IJndZwT6HsZUezWWKHJgSdYOFEZYOhgnmHVi2M1T4jhb4GNTXc9s3OWhbQEbfvl3eZVcbPLnSlk1ZnwHefAbMduyfDb9tLk-ajf2LpKbVPco5hadqxlzhlmBfja4W12sroS9qwDOZdKNOb7SpNPqFno63jc_-uuidTGO51ZgpCc0ruOAbLrmPCLz1vWwi8Yni5Fqb_dBMrMvYHYa1XzO2evTq4LXBHLbqE1MDji6DyRJWOZiFB2IO1laY57mVWRnMrGBeMAqW-INGnQyN3Gn1J0rFJiuywiC86EJx5Fnp1vvlSc27bd8TkXYmavNbYfAto9IR_5ulDXIWwjm-6HBq6Ua8x2mdsTfv3jc7uf22aBouPIW4ahqkQQsNr5yyRWJLGAnY1-wJdAYZb_DF6vNsAJoHT7hChnGHwAAM15AoHY3miyUSc6FBU7YFXj9hs3tb8eTjN44P2rXhkoyJePLZHxRRoGD1RdoFZYbUEMSJcbvLkFct0YswwH1Q9lQN4DnSkpU98dH8B4MrFZBssPuSQoBvQbzigZVKcApQOIJzwZfySnISS41Y-GAeflCsXxn1aa2g8wwWvmYJUAMpPCh0bgINckWn2kLQ_h7MyHD5mLs5M2GmwCJ2V7ql5nRwNsgtXsZZDDSYKuBvvAvBwsswLDoF1_ZpUnFo6_0SRHWPCbcdxgcZxTb55p_7rfr7b_aZlDZTdwKL-QMnU8fZ3JH7GDydZVPcgj24Gip2KMYzNs92tFgEaz3aej5dqiZNrZKFHP3VNTfLr0f2LtkdhunAjL0D_5lRW2atE6bxCV5lrT-4SbD531o2OxqP3bginBe5l-p1Xk6kEQEHpRHIGa80IDUes25d5Y2uoQm5qs8udNRHDkKS_gvYXkZoQgTXGYEXAHxAuy7LXL7FIRmniICuwk27WiOwMUPj4.nbBYEsxB-1PjKp9SgXzSIaOkIkkZ3dGznbllvBu6PVU	\N	\N	nl3TWSkNCyM9KPxvhMc3MIZNqt+KLvzRuO5Yc5/wddg=	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	e7b3d425bd63426db67007ac4aa5a7c8
3a1dbc8e-98eb-ae48-8271-6caab6b79965	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1db955-e21c-697d-db53-2a221a850fe3	2025-11-22 07:05:24	2025-11-22 07:10:24	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.qvfdxlKscXgLpoFYmrS2ROrEaPj7O7HpAxW2EU96GMlNBCh1b4hl4ABhuSgztspzZ0gfm6XN22JkZ7HuUYYSz3Ssa5pQbpr9drBd6vN4PWaP7joLVuRDmXuFmVu8-p3HAbBgWQN_XSy2UHm9UPkl0A9bkgyAmF2C5aepXoMdbDhWYa3s7zIhWVcH7N-TMVX5AE32TPsXHP4WAyYnSLJ58BDy-_NjYhm7tLwWpUkDXTvUDwux6TkhfK5k76ScNLetZLocVKTYUgEX1PjKnUyq-zJxRVHbmTMtgMtw_5fsuMk1cc6PyLCxLuAl6zW1IW8psDZS-VpJx-FMg-LXNbCOZw.kBF6KISt-4UvADLvu6tytg.XKPw1qSnlD99Xlg_2lmslIO_8WJ2f0taNE_g7zljqHXeYY4XbIO4p7hdvkh4zF1J_docsHVmMkfHHf9nzfiC2aKEFzIDoNu57k5xqgHQzTUs8SkdQ-wjzyAiqAI5U0tV7gbSmZc6X_Djxic0InILlyfukdv1AWFy4KHLBGwVE3vu9loTc_p5bXHOZHBcw0oWWJCCKWDup2PmU69ZNogc_-PhTfPB0CZEf8lwRbNi4mvdzcxRq-E8DKgJu7sDnKAelonuEQsmG1e6gRpdG0XvFGTk70O-cho_9bqD5JgGRJQbp01JX6PIPdiZmk0nVmTn6TkTHzXOuYEIbNpyV9ALkmn0aRfHWFP-L2LzYw6n_3KP46aaQM5feMHsXNMTlpD2A-5Yn6X-PMdgWtr7ATMZqnmiRIJzf6xFIfWn-RrfIINeKh5uHe-LfIp5-e7419lbN0t39GtUwTIChwle48ejFs-Nt8CDAfYgNHZRlj_4Rbw2Ir424zW7oGkTP278OJTQjWyKJu-grtpDdKz1EWcBcyvRxnEVswIp6xX0oZXTK2taAuE6XvkZg2N1ZnSyWaXNfpgi07zc27yZfn0DEknpUjFUpmberPHVlGA88Na_VtBZelMLSVvkdk1Su_thgrGeLfk-ibF1pVtEb_CYcXQdctJYztRtDj_0qdy_MDDlAZ1Jy0MQzPf04ezxi_Ova_aT350cSwwKjdkx47C0CCP5FOITccZKLqUkivb3SYHeHiGXDXJEzjG8u4yijmagqnk9xcDD6a3_xsbOSeC1XxbNm6tRmRIT0OM7fHBJLGRvDMoGfY7spRsdcnoZlngOULcqt-SFuVqUh-S_qYyDJpa1edk_q8pMs1NoelKk-q4tQRmDulaET6BMWqlauNKDUhem_5gVYIeQNEAjp-lFLS-LOBqi6t2DtBNC20xVbHlc3voicxANNaKMLSGxaG0fDtV6AmKwD5puqhtTNy_q-bRi95qZePg83qoPwUsfANXvwFTLh7FGOMpIOLwIDcOWAWuXRkKn83YsR3htvNGYoKEJLcFI_m9438zurBCK_0zgTzS55zn4obRGuIsLo_w8YieEOswCsLtOhLrrb-KQhf4NW0X3ZDiF-B4iNm2DlGReE25-KVRtXasS81HHL7oZaHFwy2_f94-tR5V-wAB-rWxJ1sq--mIRkaOyeY959Nxht-Md8WQbOlgwJz8TBhNUC9keo9ovHMkviAdP4_dDMRMo50jrASmj8cje4_0GGVuyJA5dldpN5oIB49ym_3nf7FNrmIousWWISjz_YLqbuSHXmQzKst-AS6OPx-XuFNPA1g7ea6QDnihhyQLF3xKo_xi0y-NVLTzWG3ZuE2gyC57vUjgCxDGVKsmCeIwaKivpFyq4jkSiC0CbdrlmEojiSkwN-bSOfBAyRoW29w-kMzMPcfke2vWNnNwNXc-HUpcmd2TpOT_jXUBLyY5WmFTeSW69ZI4M3uGGd0h2T3fqbje_C_4lV424R_GJd_CgKXzq1TVEKjwHSq9TeAVhk57a4HkylTbPj2lkVwOVK02mMhvYnWKeRBuRu1d7daYifYeY2dpLIiqAU__6tei2xWalp40Cv_DIkZn525HN6JgLSa_IhNRgm3Yrh2975b1CT9MOe1Aipif1MukGg1xrzr7XqNE_h3AE2taTngkbgOHj2hGHD_HoJWdvQar_91_eTdK5wo4mPvpGw1jbvKG92dARnMpF2L8CffP6vlSdTos_Fm4jWq1y35GQ0q7Y585hzTM6oWI1ScHUATQ9am0ydLJBtwtCbE_tRQxbhCYEKnbmSdnZ_JSmElv2UdEXtTesoK86_tU0dMcrMb1NqvFQJOmp1YQ-x4cs_fwh9QxLx3OQzgTmhrZ4tIihS_Z-SX7_GUAW2oaX-3LHLqEVhOZnbgdBLqvmEnjBBYK-DP5SbHv5sg74kmlf6Wswpm9D3gQBnHGaUzUNMoboqothwx3ooBXG0hKc_vUBdR7rwSA5tcq9pOL-QMn4e__GfUFyZBVDXd-WAeXsPE31ZhpCoiAjF_q1O_TOkjbFy2q7iBtqQLNcbHQxOashAst6LjBC0VxvEJvxDnVOyXss0VCrHnkQKccDuFmZuS1kSWwkbJWI666LoQlsPOUMgDpVNGnGMNT_WQ6-s5dU-tEeJG0mAzYeTNx0QJW2URd2ytVULTB2uiNcNPrtzu-w1kOIKtlrfEeiECT-vjDtexSZogq6Rxv6f07Jsm5VmiQ6IBune1Ak9ePYfmnjXz3gDui-zMbSL2ka4KUDTdHnp2_MkP1JIlic5H66X2TIEhizNS4xF69s2n2V1cZ1f9KBOzwSlFlP05GrdIIQn7gWxBLOjHZZxBEkxGnZplXPSn5569HcvRpaz_UTxxcHw0aYspU_Lz_JxYk6By_vI8q15gB6DuBeNGRRUxiayRVDhFkhz6WFdh4kTTnV1GuvfQ._Qq17JRxxIQo6fE6txUvWGWgepoJQiZoBEV8v4T2aGI	\N	\N	esTkpkq2ntDF8Ro09/z2OtP2cTNdQTKg4wl7okNc1Lg=	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	6e127583b7aa4a64aee065c1650e00fc
3a1dbc8f-119c-5331-18ec-f2996aba6460	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1db955-e21c-697d-db53-2a221a850fe3	2025-11-22 07:05:55	2025-11-22 07:10:55	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.D_CzunLz_gL1XIC8QI51CZc-TvU5DYSQtv1T4E7nx_qtRKg2n4Te-p2oMuKkj7flbKC36BXJAU1OeFfI-a4ve1-ReTJW-tFwgrCm9saT2Rq0p53GycnqDJ2JKjKluKEFAHyG1Fz7L1Ph68wbZxkuBUlRmNc9MgbtXYNM3QIZ86-y9MN6DdlXFxHAoQzH_8Gyen95lipYcsqKlljPnqkDt85UKrniW4bYOyRE__tjT9pFM8hfXr_ci5eSksy96JAj2tIMPnZIJKGffCgeq7bvcP9qLz_IYcmm1Sr7Dfbfp3aLaRfBC6ywFiQubA5GNAvbotPo0rOFbRTXlfZt8nO-6Q.C0tnZxtkBbR8XjH_sjjWMA.2pzxK1srnBTLYawZhJE0hB4LyU7ANO_rJ1IE5iZ6Mf9YBkkS7nLh_QU_jUcFAU8_86mcWpPw2g4uPcsEnOgm8VDQg6Psxe4mhZFx-d1zQRI9qI5a09C6SYCf3YZFB3Buu7e-LyjhPSYudxkbF5DxDMmWeJTna3xkXR8saJkqg-H1JqYag185i41RFTzOPdEUMR4RCpWcrCB-PpYyxCghPKFG1MPsqgUg4fbBioiCWjqeKC7QVW4eeoePEDE5OwwY7b6A4OdNtLgf6r6ng5E-X0gDIOL2lFPbp6_z6Mfv4K1uzhIi4xB7IY0Nc-XG-BF0dhx6Q25ei0kSCHLfJ4_3NQkkb9UGijUb0ug6qeVU2nOH0kcYg3SaxgWZdBffiUPRf8DcvLtbc6KVtt45MwTbe6uwNhXEffcr5akIFmSTFh_GrsgfhIMqHs4bf90N2VLLzOp829l56GhVeIJhV_u2u9EONbrN-t89pJ3vNcPXvrhAF16Qq5l-TM5_2usM-BSRQJEVFN8Y5XW6Rt4N8lUCVlkU7Yv8sIiqn1oulPv1HWGXlKxm4Us6WG0fdAWUeP5hV2L8A9P1R21cyiRk4dI8v30kEiUkKAIH5U2hR8gno06q49qgvSMU_yVIL4IP6BcZ-fkdPrkLUzCuIC0QuWev4NCii0dGnxyVsQ9Ss-mFBSPCVtSuxdkPm2J79XUPSR4bx8q7imwsm2BKbkZp3XXMmVv2M5PCkrlwSViEclE0KOTH1-RpjfX8SA-qzKWGN0SHP6dhgeu54Z95SCik86X6bYoJUHkBuIghvBAyMY6qoR-q8oTW7jGiyf2Mx7claYKMPytuddzDKmg6Vqz7Cosmr-eiry7xe3gj6qcIM0mnC1vMcATPTDHUG3M6C220SJPUZFWY10NhXHpCybsmGVNlPZbF3fe1YASvrtEF43-fvyw3q17xgTQlz37pGm3zEJZslakUit3x745UOF4AbjR3w2A8FQdnN-ZRZEbpJmkevUOO1p85HtDlpsevRPWu0P2E6mAp0EAkcABI45xrVaGHBF5m6Z2dKv2bZyxuClJSIHevL8_YPpuSxigOKaJq9UTGfiAL5vir9GJ6ixTtWgu4D-JoJeSuGdLTC9kAVyxmTpfmH9pbfS49vmAyOfNJZmw0h2TCXwWTQBpSAHjUv4VUJc1brKenhguVpekKn1NFiDZiLPQ5ZWeZkIpQMgkAUI1piQsWkU3d1gnsuYaidR9OvSRsVvocT1_cyR94HkFMFAQN2ri1MF6VOfwI989sUL8ufVMVVyDZALfgsBGYM4aB83lxfv7sgShWo4bCDd54KHjhS3Bt6R2fy4eJzI46mw5420FuiMBP3mzIasXQjJjqpHdkKZcNKYYKDrNbY7FSt8NrEbXqLDxnuZ1Ny2Ilv8AP0Vzia2JB0d9q6qNOE7TanccpNjeefzJjhYoZsJp2FEIx0Vk3k7k_K_-nrQBodMGVDc7kfSR14Uo-08KO0eRbWTqZIbio8AEBh1VCkYEpednsOz_LM-4uAPKhu0K6BfvGWtYll48ZAU3eejrYJLjMMBji0GMdrTalzhwmALmqDfB4yy8M32fG6t_4pH_O9P7ZvFk5oKpKORtamfDg5C13FLXsssTGEGueHgU0tD_ihqQ0Fei7LfHH4azzuepVu8aKyjlgABGCEAZpgMHI9u1LTclc7p-me8ixmsgDcjvb8QsmH6RC9s_h39tfFaoZcwf2RJtpigjVM5aVD3uAG3PVveBhaiOB0erQtvEDc4QljkWuTFNzuMjXdYk1S56IEsi0xLCYuTtYpvaQdIMGQ6DcvYpA_lCN2t_VYOE5XX7ncbTm9HljNHb9Us_8uzp_BlmxuOS3_RmLXmaGMiIx8dOtuLJItiFyj-ggD3TWpK2WjSuPzghXnJDwi0jSOfRIJVUO6MTfFRueske7g-4c0pM5z62e4ECM9eW77ADrony4f_FCymDTYrWZdmi4o9b2OfvmCiu1Q5BWgkLrV8BB1bdXP_bZ68mmBkMditwEmDRxHtnF2KaQdjrjBh20PSgGaviF0i48C-RDr7f1HNjbwkFSl3tPdbrPoaQIFeFjbXZTa5t-8Qs3awYVlywvF6u_zOD00uUtmssjhVp_-OSu7nRLCl1wZ3PD71mytUROUJk6XUph4qRyYtPJ9IJ4pNMzjwp7On7MAbvL-Tt9kg1PgGRxvnBzZroQjYYAaygC82YyAD5QdooN0YGjuA9qhwC6we0SzkcQiqgn-Op3CTFvlBxWCcPJO2MxZ1AUCxSsLK70MUMllxoblJs8Ui34WGaRvFY1dU8TpNN1QyHSmlVg8pKfe61m64qhSEOeV6rQavi6UDQGJUiuUx0wKci5-aBkTnR-xUGfFV2p7Xb6lcaVIIGkJWj_hZiybJOg8Ej0bNVLe0z1AS0zUZcVZAXOYMWwmXu7jOkg2P-9I_vwo1xlfr1bJQ.obb0OdQOspsIPxBrnwe7SqrzRvtkVfPXG42ed7-UD58	\N	\N	83V1p6OLB6I5wjaAm6jRvfY1oYbIsHXKvFjeYigpyEk=	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	1f43e8b577d0458c8f2c002022455ed5
3a1dbc90-64d4-6522-5d81-ba8e5b8909b6	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1db955-e21c-697d-db53-2a221a850fe3	2025-11-22 07:07:22	2025-11-22 07:12:22	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.YjNmL5tfDxowP0i8kinr62KBKuy5plF9_U_XtNn8aV9IRuIkclZZOYuVPrrR7K_OacHtbask0NKSTqZhlw-dI6yzpcWRuhJ_60mYgXKWTKnwi6b3v5zGXsOb6LQuQxC6T-n7EnMJPZq1k_F_LvI3f6i61FDleP1c4j3vj6A6ewidtf3mJGVWwL2Y0wxWJsh5YhJKnn7sPOpLzndfLatutq_JkZe8esUU2WtUlq1K2u_f0ESGEr06OxJSKkjnCbNW_nI5Nj3hC-AHBxR9hmjevHHACf1Tw3tBXWqnWN6y3bg4mhmNrgAi9Hw0Sc8i8o4K5F0ow3p86F4PVvLDL1tGqA.LoXIWp1JlYdtyfURlXZvfA.uAcD2ZUWYQP1uGGsHlX8I89g9mJ2A-GqD6UoM_rJpSdl2IvO8AR6rU-ShxIJ6p7SAFSwCVTqQ25XaEQV0h3kavk2UEWxokjugEOw88xXR8VfrFgwIKw7seqWahj2KB9teA-1DeuYg-BG3KRyQItyayAumTqnixeSUj4wM0zmfZcRawgd5LM3UFQgO3N3P2TKcWiGpad41fGQlWLpP4ZTnJCeG3pq9GgHldZM0OCrl2vldgiecZVxVofJExxJmKdhJCRwYOjlZW260QeTF7cWLp7ETrGru6hqAn04jOuZ9-dEvhn7QwDXuYnbggXcD9u_O4YFNfTfbPwS7giA4I-Vc3_9fQtKrSuOUrLJxZVVP7Z7higonf6OnupaTqV1AlE17OyqocB131HFwT8unlADWIJcnHJGm4lBIteKjvtI_3eP_sULwH7xevakXduIizljtcbtVPaMmF7kdmmYXv-QXiN5Y6YiHwF3l586eI9iSRExJXwKrRQlstzXpyvfqKhFM7ZQ5kEj6pWj5fxYB4YSLLd9z52uY0IWKNA6_it-mc_l5zz_zXpq_HRcis0Kqsow7LNX4z6KawS2lDa_yqeXumVTS0QViS_MasEkshGEwoKeWX1ZCO_ChR2hi5fqjx0ADe1meYyVjY5PzjsYheIucpYxNgVPLf_8NE8FcPDpcnqUUe-m7Ip-AKDssJgMDzoQ2ZgiCs7tT8rzQqdcBYL0LlI39vm-mCqG1sRDjej3yFcR08UjmoECkjrJXcimTTWLkbK-d6Ouo88MWJWB-3VVo35irOttYSYuKG1I5oj6JD3quErSGWk0Zki07gmd0AD4Mh1io13dCr4yrLkRFn_mfGg_J0yr8L7Eq8TSNnMbNVhMhcw4Y0SMdZBcU5E-NbT6SY3cLRXaj9nNHHyWfGQ48wBnN8W7KHSo9-4LJ5Fb8e91FzR2q2frKRsChqTo3u0Adj_s6__j8w3qSNnDL6r7Fi1KgVvFXiz7vjK597N3W-xFuArFby9zePpT5NYoe2NlUjbX1OFGjHAfHKFG8nNSrPWREFIG_E9Tz6vIrw253Dr359jxd73uoGvoWhSjiGfX5tsMop1WlTwiSiM7jeCYWXXDIcQqDrhFzqJ9ECdwqU2pWCO7ZedXYWC1j2fgS14cjhdtpwVbitGPb32-ruIbiMlmQRSOweYxBkFlbirYu61Ku268jrR_O2UbW_d-GucB8qN6kGm7dTDJaspWoHYEXEw1mwPa7_X8jHXkaRFPYHbLsAghzh8ahEVKcTkpKj9AlJ6CFfVUp9aY_D5WQ0pbjFMt218mbgSCCIT62AxKwKnQbaIZiEeqrfj_jvd8dqFSkJmmJuz2BzCBdliQuRl0C-TwjqLfptjf57XhCq_3obh_sywxo8OTtm7ipHY913_QWsVy4dtehcYE9li8vsh-C_83FLDnCoX-MuvpWU9WmCwpawzKInBMmhK3XAKxYQ9aq3r2toIdYL0K4cmyHGHPEp_FJt2nLU3xN-t3zq-LAOCC7R68E0qSPpyLUJNxIzfvrZ_Kc-uWQVA-q_StYb_5RS6A0iE9vI4BZ6PEXBkPK4HI6SJkeQvWo2kNI0JxwNRuSJ28qaBNzAHW5MbPyVNTi7VnV3sEN0WxsJLhwDFACicYIonHqa1cNF7ZN8Eox_PX9NqAaO0Qno5NmVut9OLBu36lHtsEqqR7KgGV1qb4Ad5IhvxYj8VR6IDNLzY4QTFN3-BAcJB2N8PMwZrchy19km1WNrV6-U9pYvBGPvF0QeuUJwuvzTI2vJTEkfMa8VfCkxE59S8et075GQd8nTX4QbMlg7F63HT9OTDHiPd2dlmM1gBCIL_fb8inpxXLm4ZW6nEBu3VCiXmKeWwjhUbnrlEayCduB5FuOwwRhUtU91CEorlVj4MEMsSCqkJS5jZGcsCk2cYqdZsbKV12RFIdk9UpCN_IHELcNvWP3-EfYAGyITXj7FPT9PPVys0baIEGe-rS-8Y5VoNq6jvaDLQcm5RMpmOEyWgYTekxsQ-Y9lSMrqSvGobcvtg21mU2IKLaNGgdCQelIHZUIQC-KoV0hk3DGHDFZ19M1O9N_zj-KrJ1IeTXFjvpRVcBkVY6TCdzJVQU2KmY120infSMCqwugDp6AiivEH-KD6WCy_41bOuR_m1zF-LkvaBRPvy2JlHn-a7jiQerr9TOKrswFsZwZFrH0kw-0kIBILksfNgMK73qOVJZ9gG3As1Im1va3NWhcRaUzDi0GgOP13PdmFD9ss9ErSNW_v4bDRKofxglkkbH54RdCiPJI4nt5Vc31PrOGz-IXDxMMzLFx9lftGYAEaehwQcjx36apQ2fD6TU9vmu5P0H8YqE3Ek_w0QbQo7_IncELKTOnb6jVJ9UyRrsGoQ9XvM1J6zKrW1a8BRHR1OQ7jsHu9oLQRr59YcvWjVkSvkyZA8aC9FJMfbo6rw0cMwnG-CMaofcjwEKFiu57LRRAsCCO0av51k7S2ou6GOGONRHk0Mx2DmU_Wu9H5kpVo5WYw-mK_zhJTb1oAFFmA4.mdm2ehbLXbJX9ozLPlYi9r0cCdf-06Ke7SkMktAtCSg	\N	\N	diMd4CVIEGB4YNoeGCh2Jzsl61xWlpxSc+wsWzQk768=	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	f3769058d36e41d8b0a4e5e9844169d6
3a1dbc91-28f8-abdc-e3bc-159d28aa472e	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1db955-e21c-697d-db53-2a221a850fe3	2025-11-22 07:08:12	2025-11-22 07:13:12	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.TriqUSzlxD2QxjZrc01FmZ1vLYZi0g4q9MeaxJulR18jGwuBw2Rb14nqeGkFAcL1Y-HMNOOMv-gbH4971a8ecxj82NlRCPGCw24o1pB6UGr-30E6Xod2_aam0pPDzK-QuJhl8ViNhw-16N830yNbmqp82E6kQ-Xh_sR5-jaSqCy87uPQC2AdIRkl9gDQ58sjB4fzNf-LmMGztSq1XFlAEwkg-uDS77RGyUQy_8vQPbA79JZsEgvDbmw0UMJry4y525oPW9VydpQ9ZiL34SPzch89weom-AOsLyIDsQ0jdm6KlIJVAfrfAKrI9oO3qFDuezt1nfGYx6PKnfKCCmpvnQ.ZrKgEsW-QUCtUn7H4X26Eg.lnzdDBMe5MbGdXib9Pw8gtP1N14gE4gE8FXjob3RMLX430yG6RUxc9kBGI4xjmSAVBy5PwPAD7X3G0Y8UmK33cLL7gHAp5EJb6DBp1xZVevYWfIozIXm-G-sLicUKm7H9-T0b9uXS9bWJ6joWcImr0txmvGB8R7egePRrdtfsplMl1FsBxnGsXBl0akZyK356LwpEnk1jGhtQBaKHA59dzUSHMS5OYk7u47fkjqLmXo2z04i01ND4Z9o-Kfb6mVAEv5ssn6K1g-9fLhnfB3EZc8Db1qZ8MvUbCJqqrOf2uLbQ2AZfpwWli7bzGqocepu25b5Ny24Us7-IJTumyrlzmeYWA4RX2aW8qn9PTkH6XtHbzkT9kkC-oRQQoV6z4WWSDzfpo3QjX2BEdZJsSEGzO4sWzcODrleTstKhvXGHuG1Y4IJaN292LNnk860JO_B057f3If_OAZLZMGpyGDH2NlSMK4fbxm5kV907082Sn3AobwXE45dEQC52UI-q06NiJMyT31DkZsgu7_RrM0Sq9smlCks9E6nQ8gdYAk26SI5755KGs0AK2k63APZvcpE-mKv6ZCnkb8A4Ssf-RILaWF2-KSlULqlW-ind6RpDlEN-JtPYXewiqd1m0tkYcPjgyF8lt523Pv1I43sgbVs2q84fa10ZL_Omu4WHRjYWcH-WRr0vXmJlNsPIQTsSUrtINKt0dD1L2Pm48BjfbxiUBax7FMIceWIBOckcKKKRdQ3lwvDSrQj_DLRSqknlnCsWTL6lkjRSvL_GgciU0ZkoKVtOb_1l4Qvxg9qeSQzy0SUKcLAu-iDorLheM4RRhknO-1lp2UX3ChtE1S1s55NCBrWdyfMHmfM3EpIH-pJM8PfqsU7ty779oSVBsvkf4VyG2susTgMsoswJdERbopUflse07tRTqDfPGBDcxHf36VJAgXGmFpsAcjZR8TQbeHAFML9wElmqv_SqifGkosK4oMSVGNNHn6eKtCmQy4NmztPv4az7KH8x9ROTO-SJKOIv8BxoOfzJBxojwbUZzimKD5ahcGOOAT3Wh_mqWS-rYyddULpYuVOXKYpO-hxg1tPdwjyqKy0gdknVnBNI36u95lZp7ewg9JtgqOW99i-dV7fuEgzQ_nxqbTmLND9sjoU6Qwk3CUrnPoLHC_yWo-SUHEtvXNjt3vhRSrnpsLQD-P9cewHBRfaC0hk1b3Npc7t31LUkIvQN3onuBIJCRLlsC86yYXoM7IzGLeqv41vIjKqSed-xl6roiErX6YMh1Fw6gvKdwPU6wilEN70dCFEh0AzOFMvLWD-M8bMmNOEqid2jXGBR4gh5Xqt1S65h76te02Co63OCiwiHLm89LH2brkPMWkMO7g7yeXCZgte5WAzmk7f49RJ0nQkcqnzNHXWahxZPIvt3aZLwEeEM6HPzbxK4Ukyla4rZkrZyr5O5e-xSe37ZCfgod1AOf_TuGqEibkqQsIYiQGfeoeUFQoQdV5QhXijPOlUGainaki9ScWnRSP66_ciua7s8j1ctcAoilGkk4KoMxev01gmJufTrMl5tFdcDaSd4Yrw1WAveBibD5jEYaICk_G82wsK_sxNNKwFkadfehE3m24Yl6DLCN5SEvM1LxStJOTa-MiAFC3c1EmjA96YD2Qx7o4QgquBsjVXulHariLP0Dkp9TGznoP_SGLx5iEoLcR4k4BcxsUSdJ8zgmfDkvRYrd6GYeqTprntSJuKDY2ZGq0OkMZ0c4Taaa70tNV5HGx9tBz525oTLzzzPSREXfznB7H-GyWVZbYcIpSmcQkvl1y_h7TldcjC9niA4zLicZ-M6kEa-pFTGRXNrVtMM-b4Rgva0VUpHV9nanrfGJWu1kda4GnDJcrNkqQgDQ6eHMCFER2Xe7gzODjUOK-RnnjARIRQOyZj42EzyNjwT6o2Fp34o2540jb3bZCmXmi9v20dJ8LrauK-DeIbadVROynHaEkKf6cRMRkqsgeOswE2XGiZ6stRQv8LbE3Div5pM0GCxX8CmnoGMVOe9CjJlskgO4xO0pHxCWmlz7gfkWbaFVtj2dx2lByrbr486uU2_Unn3lY8LqtrjcpY7Q0FSk52yP9J5KsGYMX5NBnIUOK7rKLkaxBUc1sLD9F04yzwzbCdJQjG60y98FoZSMs4Pszh1KkhCSU9JYh6sZ1w24jndjDrEgfMMncZQpFNFLCx4u8DeV1_B5dl8lxXG0hzQn9-j-6e0DDaRQhUzHQZu3pM07mnPhPb6xbBQneSfU03tXogHBCy8-4NV3SIoQvIzLSs7v-U7kl2oUSfXZnCxGSojPr-yzyznthCzIjmxngUmrC4jeH7cyscZWfn_WrTSk6gktQyUneE_uNM9N5r6-D1kxYPUsJiBDAXJyJ8iDiH98M-K8kbsPhAsupEiaSJrrQU-NAVFT8sxnDXgwsHEUYjfxzU2wJlZw.9cxrAHgPwrfN47T6MPF4zZe7XQVcJik31YxFtwMqwG8	\N	\N	He5gHiCPEEIRlMMCH17WPYUMF/kpGU8ubE0A2bQFV+I=	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	099a550f220841ff9a1dd951ba2ffc4c
3a1dbc91-c6f1-fcaa-b062-7b49f5710f3e	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1db955-e21c-697d-db53-2a221a850fe3	2025-11-22 07:08:52	2025-11-22 07:13:52	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.qew-BYmV6Ovytq56gj69_uhmpSSYuEYNqEwo9epLztpltZzUwAz5ObsM0nnAfyf1SOuuAHlf3NRsvLxmemf3nM739bUVuJdKz0BBS_gnhVRgNjV62M-TeqlyTr8gzzu_Z-82728V84ru1kJaaUDE6XxFZSZXnUDLj8P0wHs2qD8J_clB0D9CrLxVqGc0YgLRZmI8ycne44Bggyx2cDUIme82ofh8EsNO8W0ncGjaVBEpYiuhoYd7Ebwrg4QKHQcFHGllL3MQIdTTeSovOOhXH2Ftss6wl5h2iD2gIYX-2-pYKpRSfYXNQo7a6G5LzhUaWltrx_SMYO8I8umJQ_58iw.CTO7vtGJ-7lgTELd93GQ_g.Cp2H1S63mIC5Q5DwKNOjnjZKdVTbRltkFI5mtviLDmGAHmMdGjGbgukSi67ddEHrmM37TKGmGIB8dm7ZhyuEv4yqrbaHoLxLCt1mMBgGegSnCdcamWhSmLKEwW3yDtW3wg5g5Xsu-VRfhvlRlrbVoQ0U0ikonivtMGo_E-2AciGgKWtxvg7nUxU2cmIQLge30Capo3nIqsgb7N5L2td2xRJGFEHqaLyTsG9pIMACsvkXBW_WN7WV8NvM2rReRi03W31o-UHxac1g3ocwlCfJAJV8LHDKuYjnqxgOJQgxmlILhj4fErQOgt_LHXrqfXQ4XM5FHO0-hz10YP8Jb5w5YC03H0l_IwMgWOkpXh6r1M1d5ZAuy1v6KzCyqLjKB3LTVpjb_oj-ir3dh3jmiAvo4eGDBg1ZYVs3jYOli6iF7TuRDTBsjZ8QRMy7QSfS7A4RP6MRATHXnIDIw3c0bfx-DTo3FgMBeTmgGxi4vN3pEQqrmTxaoOzpAIWeyzj1M0d8NnZiHykNhJddNXmuVcNvYdnwAIkzQfwFqNS9MBih5HNH7FPqMjiLF_zCSUHAV1TZiO-FhJ7KCI_IoSVTphRPYewgI-zXr5760yWvz132IYhKgv2l49NAvP3NzkLKe_rLEphYXtQfS54U0F8oMqQlAlHBxMgFY3ErCYVILQwiVZjsVMqaYT-x1RLR_kovUgIGWI7O95y4mLikOv0e-2ZC3v8VQOGJD9QF8OJBR286XfS1AkKnzDdBDMaFdRQPi1OuveWj8VPj1jh5_5BLI7JVoDi0IVm1ISrvCCL9BPrZjgZjVXUm4fKaLkYJ6Trfb6LELmqn-cVNU7mDNdwxCKzuGyXa3YqyNaiyvno-HIwUfj3JxbCI3vOIxK7bA9GhzwyzDzNt2Kh_-FRklig6pv5hdMcKPrrL7bMe6vqw1LYPTJGolCD8mUuKnBgWRiygkKHULKYncJnn6v1rsMFndRqEVZmuuWvghNj5YcPNe64Ee2Ut8-tHX48rY7RGqx15FnmGjBgQJtkfOa5ggHwAw2mPWkNjwFxoif1YluVeCb7kNfFCClkDvuKNvEhpaRfFp-pPuvCF5_MheRQNvtoGzIBBlA16cYGs9fn8MpJWPA8RouCrE3Ku8rluYy-uDxy3aSYe3qL6LMmzFRcff20R97TE-vSrhClRKJSfFS_42Hib1o8wyTBGUE2W02dJsuEpv0j5B1bR0h0qwAA7VByyi9HrNKI1Wed5goJZ-kXqZ-sVpDvvvNENXF1HzoKK3rWLmz7pb2e9FdMMdCNZGVQ_1WNbQFyw9JGbiU5n8pe480mVQaHB1__627rvG5ugV2mZmC0x4es-GvLR3BAbP2YbzCwOwXvs6Q0M8ed2sXo69TVbVVbVZIpbctZnsWC46TwPViMlJw6AsMwArgbAv9pR9NCzlZujAL3ysodULEV1NCU3FYo4XvN9kkvXCBCvM8rL0lwpgohZz2UacYh-fyxBuyGWWPWrfxCxVgpk9OXXeswkPgfsws64bbqkR2_HtnrCoeJ2OBfBh4wl_oxJL0rxK2M4uatG5kRchp2du-VsDYqLHKs7DK8TTXvFEmkWmo-gqr4vpWCtbGvSd_l0DLSGJUsiPNoGWz8-mhPlFj7r_4NfSl7JAu1tD_dfgkfvIzZGFF9jiCbemptk15hO0ZU_qIPJfWZGUjUl8dgV7ttr0NlYlkgDm5lKoQFEnTSMlk0GRLde_Kj1kNQfRmLkfUoH6b1aL41NGQLmU1WvDoB9u9QGBZx7-t3sT7qXPAE14M97xCQ987GdmuVfrTvTDw_iihzoQ7THtlqjj6_8V0yxhouVrE9Se4OVb6SZGHZH7KsVop5FROhqfWUuI-5BxyLwnt1PYa_RccZq2Wb5Vxa7VLv2ZxsQ9HhOeXbSDovy1CY0TUBQqAVeCK_QUTi_jkv_zMGDIufBTuyDUlBqHhXkii68w1oTIboCeIjGL-Oq-Nj7T0S9QwxGcHJBygVbnObU-zg0a_MxlahtOkFwNeQ0FR76aY9GYIseB0AAh3BbZ_U6wXhpUg5vKuWETh3uao2LXfcWB64ich2D8JiROX4Dul8wPUCiTU4z4qjvw-Sqve5_gEM7r-Hx4iU8-bnnXn0W7KXoV4VUnn2u2z5Dgiz8AKz5bljEDjJlSjOG_ANq3nsAeLTgkHZFuRAxXF5GzVGVB6Cbq1minh3iVMhN3bP4d_3SBxdHAwowl-lnnevqfuBeS5m0fIrEe3ELwx9JNh_5J4GT2pemlf1hgZKYfUMVy0itGGs4OPs3CfVq8ZPFKK0xAvZN4OAbSH1KB-dmtgU0yzofHwn2uRFv_qkq7vMO8uqLRmIlPEwhxy_SZCyj-96Tq8gN3NDf2MvnBqoyDAPSYAqqIkwfH1Yc2Ti_kjI2ptcx-ITEYfx8TGxAWIHVVG3ZuO-NOVbO1ZE3YIpz49q4ZPfp_w.KAxyCLXbR56kBnEoAHR1RLEWexTp3w9Z2KydaUfQSxo	\N	\N	3yuWHzIyUuAxllFvSI4QC1t0EKn/KYswiPEOhPnzLko=	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	6db7340669774a599aafd5a68873ab12
3a1dbcae-2884-23a3-6df5-ad64928388fe	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1db955-e21c-697d-db53-2a221a850fe3	2025-11-22 07:39:52	2025-11-22 07:44:52	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.Fk33Vfog3OJN1UzYjTSVgAmNM0sj9uMqEQ7dBBLHylktjcL1ZZqL4oYJPna2mW1FVH7U-jr786DFNZ4xzzZJst3i8efJS1B3EpOc4BJdO0JjQ1gqFjg24cG9cR5Ps3uDsR3kZA9lLIKt1FWrj4uxPI8WpUH5fGHe8688HQsR2nJ_4QmDDpH4N4L7F2ymhBeviRLQ7VnU-fnrp967qv7i702aIyo26uhRpveKNDiUpraX-SNYggN_tM32fu7X9YmzA6Q2qEyquqPYVEvNpfxCgYiVMogAM5wRMiWhTpA0H-F77CRLpuoOCH5FmzB-IBBwR35eBQUXul-c8axKiiI2fA.9NO6p3go8LJ4pbe7Sm-KEA.0xhs78gcZTTEhlCNwR53lHa11jhuqSLUqEGjlZDVkDwO5g_H-8Day_9rF7zX6Ngi0Tj_8yeRcdbC53SgfHSy_r9w0wyE2fWTzZi1dMV4e9Z5Pnh4p-2XVGleeL6pG1OsmBpTrZtQ5K94hAYI7YjYuXsdNkGU-ai-FhJY9aHgcuoN6MSX0IH9RmbLq3F3JaGXwhUXgyaXjCKfCcpHZpcS3dqW82JkSI74S0itZ1bhro2C2YTxi058yy1QJzBR0FcUCM7_hfDkVhM08v_w0JWB_PFGz2PkATvJRle0c_YQU6TrcfqFQ5b3Y8SQOIeiIXwOZkFtk8xX-TzDjHN6vB_QWOdR1iu7onC4tUuC2D5qXPiNuutIvaVQY4k58_rE2EG7R8W0jnmhL_MVYe9lDo6iqW-FNryfbOQc-qo0yRHou1Dwo6j-BXGpd4xKoRdyuQPGHagmpxI23iwDYy93wRnNebr1lEHMlgzeG6hoRjpjQLFffzHCHIZ6PDibHM_6V5lOn9IG_ZBhYID146Ja_K-JY3bYJhAmnPMvxHR_21GKYhCLqBVsCR4hj3siut3h8kJIciG-lNWarrNE0ttpBkNz_U7Uxrl_U6YWYOfqQGKGMNB35GM6yudHKCXDHvfFSY-PuSLHZkqwV2OL3fbYCocd83KR_ZditFgWViApEQrk_UxjGykJXSLHomoOArcOMROLnrZ9ORhrI7_KH3IkiUOzxK2vcGDUI56F_ard93fYKb8F1FW8-4IQR34CfamYpFB-YnjRSXmmg47IbOZAik9Zg0OEaGBDP5Pj9wgpiyoRb3N0IkDAoKSldsfRWsvpBYsmH_vgi938VfiDlcEP_g134sSCnJIl8qXmFBS0pdpfzg6RMjzkR9ifx89tF3tBx3Cjn7HBlsTBITYON3ZGGC1Sl_rbFG2a3S3Yz64A780pFBgnneSOJqU63mNOfoqYyxfYjSEZquhzphH-JzqpaqH_yG49SD3tDiMqvd7DXjWWPgxwkg-JRIydjACzAXwLZ4DRnPM9ara7OFWctlaUgxuqQMCvGdmZbAEvZCYCDyUgH0ABfp8YxzjzQl12NlX9hv43qlYQ3dgqFdZLBz7qKGB71E2zDeLlYmr9xFEYQIee4i6KSLhXF45pAOzE0iBeKmm-IwJQU4aXvs22Uk5sRMvutYI-TwDnfXajFEpthWn-hD6K7NRnmvlWK-EAwPUD_5khR9TMXX0r8JW5Nc-eWgYKkM0KLKsdxfc76mWExggoiA1QPyC9JIY6L6I7MP8TJO6QMRy-0RObaSqtzcz9beU8sBjIUsav5dlKBOidUT4gc8g7unftLbOvsjJj_839hXoI6Kfq0jDXGTntUQ2L-nIOOlH4MqzKgbMP1e56Zt-Hu_L5OVYNh8qWWMvXxCt_zu69HNO04-_yqsWSe6X1yEOoyPo3e1n32d87wv7Yw4NZPPknx_oknC7DXfKaAIZfpW1fCqAy7gpHDKtr6RQLPoqfsZwluqj16px2mdME4qKTn-IaApMTtFBMsqhDOCTAp31n8XytQ6mUngsjloU1YClmeMRmF9nt4NX2SUskdrQ2HVNkr9ygR9URAB37C1JrTX_LjL-Je4-KbxLPHZNr-UKYgbDagCQob2XTWUIrYI_ky2tu9cs3nVsV5I7VHTZBtjsYDYWN0C2EPb4a2sLClpqUH0VZ_7sq4QTul3xKy38ILUrFruGBISSVyxCdzmqcOQFAMlTPkuCHCHAF0U7VHVv2GSW0AgM4L-IT6FBmze_J1pQ7dL9__u1fFlE2z-xL52Venajz2aOS_rSlKUYBLgrGRUhDyhpWVguceDAJIA5cKAqjO669PM5QcZj9_CX1e9856oaeIs9woA3VTG5WHqYr-laMph-ywiaBwBG7uwoF3lsIFacRpWok4eCxkrKrMmOfaT-6AoyEu_kz_7jA0a0Jb24T0KLYTu21Zt-Zlyy-7PL0mUhFOOEwofMe3vt8pL94sGehzwrV9WTqETF4Di4Wp5eX1G03GAQ5zhRl0NcvELxUaOZkS0sMVJWyadzRH6QFwdrfit5c2YmuwVQF0pgj7Ari4ThJEPqFmgudpUneuPGotY9eh7sBpsZebZ80x4I_BAw0TIShNKvpqDpjotwMNNBpJbWfYR8l8L5lH2yADAIX43z-_6bp0inJKHXfOUzFYgm5EfLN6d32uucc9b8WCUS6UqokTU6FrFebkaUenpjCb9SvVqOU7emg7wJt-oqBn0vANqZuGYy6ctKxF96fecfXbzxuHR5Z_UbHpOXLZc80wV7FypI2uCzT8BQ57haj-_YaRHAgqOFx5Xk9Dc4L8oYVCG_JV4T3_bXxqb2jNMfX-tQToQuF3H-0s2IPt3DOVzn7ck2F0lYP36G7W6FmxV2aByKiHN30SMP6oYDROWCIlydA6_Rw9ACnBfTDpj6yyIZ0W-rH74tRQW_2GvHPB_xFyJGt1OcjJlz5jULtZcx3njK-aLkw283ZavAsmmoYX-kynfjxnZQg9c80khWeLrNcHVdyfQ-AJKLwwNuoRhU.vUZhrStSzokos4Jy3RxOcmbPzuBI5kZyn1Yt1atEy-s	\N	\N	I/qYzOdgSFOX765pTh72j5td4xB0pVv83itWCeMqsw4=	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	0cae82e59bc5469f8f02b2e92039eb17
3a1dbcb0-4eb3-ed37-ce22-498b989df3de	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1db955-e21c-697d-db53-2a221a850fe3	2025-11-22 07:42:13	2025-11-22 07:47:13	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.V8lYlBEhJmU10u9zXSCzLIzjm6-TWOewJ5VyyYvgUcmiaObEWZf2X0xT9Y_0lutxUspqxVxdyTFuRlIduYP8w63rhEQsb_fNj6XCDUXayrejrURGutoSKfoj21V8GDM-pV117QlqDKKEc0YCAgM7pSPFuqowBWywAoUzH0ipO9vc6jMX80qWHsU23Z_Ceh8H84B68-J_lnSLpuiICiRIz3g4dkkNISc0g7l3FFuchAQ7Fl2tAVkyNkR7YtRlQO21KRd8HLPCtZx2xkSqHie7j36Dll8AEbfEnDO9ohBei_0fTu859-E4D1klpmBDDMeuScYXWoPsQ9_1_NJ5UKYLqw.zyFhpm7X-OKRPsQ_z9fTSA.RY4T7CZPKNH_yQBVlOgKKMqdp3oIjtnwJU9FCe60C1Os0fxAlqgkw3ooqo1MpK4Xlxo326wM9io4kv4-719q1PbKYK8Ce-Ohrz0KOxUcT3j0cjBkwzAJvv6L4jhkdXwe90-_GMZzqFe4lHcsW0xzGuEafswmrR0PcrPvl9VSqi0rcvq1M7j5YDUVC_QrCONj_aoV5UpDtCimacjz6_pByYI7ywa8dQub9i7nBWelpo4tEm3mnFtnQn2zaiRsCwe19Qss4I3vWbMEDMTSZFtO1Zj75QtYSmcM5oOvc3Yq-0bFc-iAX0ApNhLbPkTuzOhWOZb-oyid0jR1CUGrrpyAiSJZQHh1K0C2av9IFfnG2_OmbQjI5l6B86l8jmcr4fP5Miqj8zbXyAGv1wmF9JN358sdL0RmUIcJg5WqUc2CC4CQAyCPrSb3pE3jc0vIlu-wLsC3VFCYgj4Osr5gotb119b9nlJow4UBDLy7fJAI5s0sb2QG5N2gc10Ro9SWdT5JWqhLM_NGsAUjeVRJIpNvgrm2i27sUa5ge40Gt-zkYepbDd1fCMG1211njJy-vp1yDX4KmQSxeNKs2jWbzeTCSrWby8P0cCeHRCA3qj4cIidC2B0vIGNPBxBX7M3nGPG19B2rVIxcPTAEdQ7XxVudqBdw7Npu9BnpJc3jJJrlT5g5pku8ZD7Zht98auyYmn5ikL3h-RhTupQVUFN4dWWV0jFVZQ-GiUq9CGBr21vfPlI0ntMPuukTvr5Yie8P0MXNNQyr3SYjrnWXj0_RpoDNPfYYqZM4QTihUc_UC_pUJ0iMfl1yTYd35S6dk46TjY9dcQo8SS0M2grvw-sVBpUxtsakL8LfwxVff18y8q_lhY8OG9iUmfo8_zE87ztFMIddomXJ6avsHvvLIaxB9JXjHtATnGL13HM068KS08t_RgWnjbvt0T7DcugUQsuEyw0Yzc4bsSK5fS_wYxaTxLiDYUpEF2ra2dz0B7bQmkEuB6h05UkGEqXotWcGrSchcceHFGLP3Mf1v0bHKuIjQwbwvcKCaau_owgvOYDvLobDO7x1ZkPqsf-YDbOUL4OphQOHheL5sl-r422NqPPcJjWQY9_5x_g_5kz_G1dfognnsGi7uotrz2TymVUBHvzTYlBUGYz9pMW6-py7758QQezbIrMdqfevadgd-nGHnsZNyzUm3h3D6tvM2xY7ki4mnVP2sQcxCXaqorWvByOqW_4XKDfN6d8r8cuGJUJHCN5lssZSK6G2zOz9jbTbEoB_ombpajIGpzG5vjY-VtwWcq-7vbD1Me-rEYHOQuoedpHXvEB9M3EqKw3kXM9Mq022xjLKpZ0hLYOMwFBf7AK5JBruRlKsQYFKIJN7YV7pGygzaEeYPb0pQIYZufqNxipseGJGvBsTil9PGn1JAG0SZoa4Bdid43dfOlMJ_wS5LcvlLdJ6C8BU2GJq3uEsAzL6DF-rO_SkFn89UHfTD650TyRjnIePiOfwA3cibTqwHfjJmRufZLQi2hoHaPIdHISaIfeQ_Tr-chduWMUA3FPUJcnDJbMIFhtri4cROa-NvPTnw2zudLwrC7ByxrW-nZaVcTEhXud5Wjo6jeUiOyw07Fi6II5ZFz5wf_UiL4wm2fw0Pe32PNvyeSYuUblg7EG5KTRPHy52bqEolwX1WKO4PuK5dPfD5NmpT6X9M2lpr8esg9NclOV1zFBIdGo-b9JQ6qRNMTjoaXiE2wQFjnY6syVFqTiWY6HXZ8kRR6F79l6uxx9mg6w2D188aO5Ls_jVsWDiLiH5EKWXMc_xnEN2gaA84QY7CPtEXcErhKGRpG-lWaSasSkoEbvaNr5EJhwaJ5dyBYPLmjK17P1K_gZn2LzAmKU8J5oS6J6qlyln1YcD1FEUCKABKzZF5DhzIc2IUpCewU4N5gFOGJ4oKZI5WD1BiaGzhtj2nJkmOLU1yhtWjH0pB2tqJBSUGyhDYfMJ2fdCSEmDjLFdGmlS98UMMRDQdfnJF8SJFym8rGsfbcgu-ZIrMITvn22yKkYaeoJKUhp57pEIu47Ovd27nYLDvjY90EBNpAEZEX9XfvUWAv8gaU-ANvXm1qY7AZ-DTPNJ1O7eT0BNKPFje0BaMwkSol0txv1LnKjzWdPG6igT5YTZ96ly1W1yH-fWzcMrSatX5Oh8Wmic9HDrbmDuJj7pKZyHjyZm0Vl3CEdTIIKek6K-lzDLoHMd58Fqzc2gMc2t5Zs2kOyxPDh4vO8BzUSNLiRN34d8-4dkxoYnXOrAah9pH9nVtv7987v916uRatfG7HbdbXoMCaJyC3lTa9HMwVk323ttRfdUQRz19BzXzK3KvfLH4E25ko_nhzFRlqjp8-SJhpPkz1pbwffUr8nEoqgdF3pIN1kwbqcycCpOPkFn3nOC7IdyDhKB8WJazcB5AwZRXd2RaRSQMGCcRlzyP005WQ.U-qpkXS8eFu1L0yzPQBoPy6c2X4hTF_sY1vpgTCTOE4	\N	\N	quHF9mbkookheLyMe7KWm9cj47ENnXAvZ8Wic7PhXQQ=	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	a2f22a6acca04cadab458e6b9873c1b9
3a1dbcb0-6d6f-3146-96c2-bad610651b77	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1db955-e21c-697d-db53-2a221a850fe3	2025-11-22 07:42:21	2025-11-22 07:47:21	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.MNw3WMzWYHKuenEsq97cMfdPUNwILpqy_xgrW_twLgz1_v6N04c5XUKBqR3uE6W8zRgW2vyPpsIepQzemdmhEn3cIju-0ZVUJ2hZPGzlKwoY7ay18Ald6Vg-dkdcb7t1uE_8Hw6q22aHWAZcoXph_FnIqMvbZJJeuschU16Rw5-B3ckJD1lfUvFdnlasEM2zh2jT3ip2IiAkeutXWHvguEWAT0Bzy3XJmV9paeNT1LA6ZV0GmcFc0jQ39fTD4nhsYz1AhufA-V2HCvmq8296xO46-tx0PRc3tAMAEiMGmrtxjJCvsS4JhvmN_C6KtN7wwCiUws6wCH9rnJtVqlB4Lg.vpTsP7ZNyiN0QfHVnkGb4w.IYaHAQlpeevCVhuegWVMB2kfPMGzopbyvkMALtDmVsDMKOhamTp7x-PI3bPFsQ5pFD4f_eFCwxJQMWzb4_a4-cG-28prH9fFN1r1fYUndbmyit5Qq1rp-p-BY89FyzUrAZ_wppKMKWNGOBYUHn4KW1Cj4KftuSyUq5ANWRBpki8h-OJjxxoZPYx1h24tXObgdy8la5YpRH7dHE41fLxzLxHE5IL-cP0FZPutSFMXfbKbD49_PH_ZKbfQS5EqsP8ff4eQh8AF7g93UTBLgQNXw7XsTs9J1LUAPpmJL3xqruw91YzT-aNq9sVH4b3e0cq-G6o5ZWRtcK5Zrpg8IEn39NSnbZd6HBH06t8VNQMWLni4tQ5dElPhp6V6w8SpnJbu0dP68rlxqWiFKd01sdZIc8y3aQrry9LAB4c9ty_Rj5QKHeXddoCi74NHSTGVUa0sgMJLTtd2KCV3sp0-fFcOG85mTfpRkX8jNAWrNh1gSseA3UNwIDdJhU6mO-Y9b7_eq0zjGTbnml9GPgKkwCXjuh__1E5p75uxntLfnh4c_H-7BzCCY0slU4-p9lYoG7-mI0V11E5x0rUCf2C_AEcX8HYS6bYr_7qwFxJrsAcytQ9_wWKBCNBFUTcgD_VpZoEU7uvX1z1zPdXa55_nr0gEqP72Lcbo_HxE88pkA-Mc5BL2CCLtPEyWHu7Usw9X4wtyKNItr976tng-9gDYr-Z1mPcJrMf9xfLDzbRAI4QxSXrMso6qn8YFt5lQzBOoXpJDWtvI-7IBvraCtDQcrjUcsBcX_bziiGDW_EGBiyNFLA4BoY420hXVRFMNh08tnZrBf7sIl6xXWpz-2o60rqN0ccpqlgvnnrGLAEfphrpvTz-TIJ_ecLfz924yEkLG3hbtu2ScPP6KUhOyZFWjJPqMc7pMEepQ2MZ6NxDNUvntSP1LfaiXQp5kSgcPCDRqYhNcUO-2f3nzbaiDQGg8VIDqfGhFxmxKEPNUOGSf_rolEEoDiABNFtiS6YvnUYLA9Ayimlz4n2-jUU_1foGlVaq7furqEld8tafJeZT1-spzPvCgV5SVTZGx0KUXqWchwzS75RPYJTE84UunU5zv4Q96ZDShJVT3kfWVdUq9SXkwcJh6Q5xpBt5Npwuw6NlruHeKX56PiLEALYoAd_UX3u4zO-cMXK2h3TpP-Hln4dDM5oEVrd8gAoyCrbX7JZanxgVum4l_WosePXUD8mty3fdiT-TbelGCMMBRA4vOjtpW-iUF2FVBbalDqU0MYhmeOBiteBFu_fg2CiacyGkvMQvf6Zt_gAHtUAu0jcbAvxmTJ_OstIOM13pLG4lnAaBxc8JL6ZKRkyGgF-C_lZmrkAkKaFXNhhCwemE9xzrOarj8zsE0ZJEsUnpIfBLPw5AJjSwXzFLZxgtum9WPmAfpD2k5QGtRYwrAlt6zwZS9l202SeN3FPYOf47ykThQxoOcxYtpIBsh0G7SUxJcPQH3QS5CEbZrsQ8ZzuS9lr0zs2-pLT3DKpE9MXbhCMUWeHmkPIgTjemS5iGD2XCeAtHfT_eNX1c2828pQLyk5FKOuhH4lCm7VSQZ-8CtEa0A2PSm_5sU6yiIjadmZdLHoDL0z5ebtdEqV6mvlgT-eeolFfgOEYbjvhiUJICG6MtUBWCTurtYriy34Jk1QToNvVKrK9B4M7eJSxQAQls8i7x78-ABP3JNvy__jUf-4kjbi9pKT_P1px6xrhEoY8fRca18Brn237k2QQHzun_MyXkHZ7Hxod02qpblSRDZOAhGgDzoayTa5ZS3guCaokkFj8nU1pJnZ-wM-ZrYdCPNgDxizM9m_dP3FryV07shoTsNxTMbaxyj2CP3c37ezX2shaI2yvehcmI8WDZE0hcs8gOhxGQ1EK9OM8sYm2NU__ttSiCI5aedDuJKtBLV_ZB7lm5h9CraCEwhbJJE7Xzqc9WAAcu2c3cWRPhyIXPmXfj5l_L9OMk72fdeSJkr3cX5DPWegXBGVjoL2xt1zwWQ1LpTe3aXawyZBU24wTnzXeLEcLjvKcycttWdvTgS8566KoScCUAuMqUg4JmhQr3Lwf-uHP_sF15MnE7bwHB1X665SeaI5wyx6Il7x1C-dzcnpT1375N6ei3m_9XT4O8ksP0WpuJBPZohRr37s5n0SNyFtTg1JfQgWBh0B7hAlRjZ7tuEIuDGsROvFNmXhKaYJ91OeGeBwMytMERjIiC0-z6f4nMGQv0olQxfR8YTG6TjSc9OVbt1cGU8r9eLFg6M3mvAtBuzNSCGiANInQ3SaluVOLTzVZEk3D2__o1oi77CtlD-nuPSvEYrUdFzSM2gtBvjurfKSwzMUkSPMqzZIYOEbfFsfQlJ2DRsCMVcQcqA6RL1fAX5L_L47SbotGtEugAfh8TSSEhCbDcOjL-G3xn25RMO_tDz94E1UVhAT3rvr23Zl1hv7A.pf-BUxMRG_qH_GB_vbRe8qHqQs7Y0UqmElpjoSO6688	\N	\N	cqb3xthtizRTSVIIiJAsvmqb7BEyLzXLjqoJAWgxtVk=	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	8e0e415f3a9c42f0824dac82cefc2f99
3a1dbcb1-06a0-bdd6-a27d-dafc40e2c4a2	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1db955-e21c-697d-db53-2a221a850fe3	2025-11-22 07:43:00	2025-11-22 07:48:00	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.pvraaNQq8jK9Ctd5IDvAWByI08R6hwfgIT1GQCZlpbm9rFvxuLA5SjqAVtUE5YRWxrDRURIbJgmpnq-mn8dJDtjIJy96kxUr5kzeGYXWyZl7vqAqRS6GCmc3jZtqESV2-EQ5YppTyCCpRWx52tWbemQcWpG4_zgU_q5i4RloE1kwFyflfX2iKEjIbJ1WHVNyWN8CJIYEG0MCytTZk4bGxLFRwiKEvRadXBwac-9tL1suqL5dZGIRgpcCuLK5eoIRea1_GKGvxSWBdGQBec7F1OZ_c-y-2HedTGGRs54uXe1bG8U6IoVNczYhJo_Ob6mhiuRm4DnF5fk0FXtbBKra_g.QR1Bwtje72Pn_soA1EIavA.HzcWYqNIv0VH1F1tXRSdjCj65LqB5Ef5UKIwnoWW-1TwvBDVtHUDAdBY2CmZtZgXi4Qm0AKrp1pjKEoVHuI-q-G4q5E3cUP_UzAzQZv8FGrBZbHZZFtFRGya_7GPNi5Jcopty1G-q0T_F3yzmhZtOzhk_ePJPpdfKyrMVZzuJWsZCwzM3DlPTsmDp0hx0RNIN5mVj6GFgifQ6tL-VBXR8G46MmwQjVVJjFeuA2c8TWfI0xxnFySw6u6t5RO69Y5WabEyZDtlSfZV_htP2PFVmFw6xOCj6L8ra8w1tfs1h-v-776iF8bIFK0aqVBXgPBPzb6WeanjKJQf-82OG9snK0cRhW_-psrSagCeNNfS0xylbpin0BQ-dgjptXwnI4DmVkwQSqt06NV2qq7CbCqZGdWBbRv_m79a8PMNFzEz-0TkWUTmNl0AgDGf1tm4SV8pnz8S-7QZ1axTjwx2zjrjGNp_wSsXg6cXL9hrGCfYSRYlcq-63mYOQDo3Ye7kn0HV73LdCGFuO1BF8o5J3PqTTpHW27fyI395XUjHqohJWCgN75Ek41bfHJ4RjtEfPc-mHhSwqE21-HX5UCHhijiVCZi9k-D1DiVNEB9n2zTmcY07mLlX3f3rK4PYqV3QVz1NKDiK1ct_WF3R2teiN5DwBd3h0K8D8W1grDmn88JdYG8aE7pgD-iwNvf5aARzSeJzPxTjF5f1jWeNY5ENUMvSxSYfj7tBLhkKcAvcz4MVPpmM71uetZmN_0z3XRKP1_ecGX6TBCfHkqQKXzPnW7NGKEvRhNVchsR9Lw1VXtKwazSBw5Wb6CJvzAmSyUQy7_TpeM4m3Hoar43RSd3MQUsL3MOohgi0qMJ-88mkDxY-yDuCoNcMMU5zPBXM8ym1KoL4R5iz1XWA6CMgQHCmA3mTJfKLnmcap7s9C2r0K-YXK_DZdTkGONIiIozcKj2nZvkJ73GWX44AR4-KwdV_lQlIqyhid1S-J1ygmd0NN7reIGgJ5Uz7SN_OSpbBosMGR3XY11oC-kARTN4zMaktmM1ffJmJ35Kau24vv40x8uG2EY_n5kgUgDS_3Xdb4Ua3CJiseLbykhJ51PHsTw2atSWEgScCRVLq5KRtvfAznZRJ-SqKrPB6BaItUHr7XJp0PKVsDKXncHCoA368zy8EYndVm3SQ1o7XdhK5S0PA52p4Q5SvbH6YmHO0Z5LnodHQKIt349adz2pqBJGViMSf6HZbUs6eQmIi1SGf6k29zHejiLqOJkPAfS-Tf37zgHQlSb2dzbaaiigztzqzsZ037wqNXmA1juyEdM4CELwjrvJr5424bTjXgYNpBdlW6dkcRisqXiYcy7qnyrcfi2_Un016w818MlizrY-p9w53pLF502YaGg0tH5_2hAtWsAjwRza80qVH0dodKwpu3aEX0ojWaff_z9vKTC4VZ84qs_D0PUxs9FsEG_ZYKDpZQzpqqyw_rlCcWu5wjnWpP3he23wEIMAvfAVWRxvaqIbjYUeZ2p5_CC3jjZjC-g3vFhCaKxSuUcDsX8tqfae_Sq9W7S82sVKCzksfyfGuBU5JqBjAGe3OvRj3uTjvn-rm86jOOTkTtWiBsi8IIivqrkok60u1gQLL7_WwW2WJEjMUYUMhRo_L707MpQZUpYsnli8ncxEHWktNijzrshzK5w5A5i3LauLrySqCHrKvQ8gJ2sIhMO9W8L5XRBZDYFG5k3L3MGZ0XxO0htBn09oIp9aMoWv1U65fTqDeYJb04GUDDB7yBJuoqQNI6F3jwN07wt3I0FbJyQi-D2eEJy3JvFfSJ1aX-GSygbs77uYf1ACTi93DtUx_POW5nF8fYR2tgVIitvLz2iZDZRwYvVEYqBLOjqIZGqSJyqLSyCNyAy2bKjKCcq7zW2RVF3gxuQvzaNhW_x1fOkrX34acHphiyIGYcKCwCNHH8NHI9OZIKUca2zdwo8KeGnCRN9LI74XIf7b-ub43GIqVZVe94pdk_S1N52V3c-SkqBuRYdLWxXmovp_jkvfCSnEvkrMTTQNYoA8n9uoH5W-c57XgmG1_f2F5ggNe2DD0GrSPReEkDDQVEQICMKyKjyUlLdwhqQPVqEwszTrz98pIJD9akYM4thu2EosmlpgbNKMKeaO3bTrxOhJqq0pUinM0HPI1XTJ_67duU7OtN9VKkkem5BcVovDtzll6VzgQYy1x1XcZeUW-s1B8i2LZ20CFXROMDBwQ-PpnZ-P_B6K6LJ3hGatgJRQzJww9uX3dg_Cj7CauE7U8ceuUrpLIPFDz8syt7UvO_dJOXDVJtSc-vQ7w4nuuzohbctXp9-9oNeV8CwMf0PZL0-5vhGsIfBn_Lj5QFoen6pK9VmpLCyUM0hfbDy7U5BE1uOoAaE3DqHHTCqFjqMq-TrTENQzxOrXhZ6GAGHYL0rVs0PKF32wQft5eMuiK7AtkaksU4A.1B1nYpZMNeLxKRUlhOW9hc-Oc9EYNHmehCZ6YYcbhXg	\N	\N	zlXSIQNkkqkDJtswQTg5DKvIb3wjX2KtOT1wgrDGuCQ=	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	63ae537250274b658c8c37fc04bcacb7
3a1dbcd8-87cf-2391-3acc-4690ba22341b	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1db955-e21c-697d-db53-2a221a850fe3	2025-11-22 08:26:09	2025-11-22 08:31:09	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.ZOyB4pRqtoJN2_aaPF-xoT4faB4XOaL-Gdo8z52ezTMhThgkeZC31kiWrNlV0UN4spfD4qNeWXUGqW8ULCmXO65bFXZ2u8MtvrWlz95Suttgl3UsqI2B2zLXxrlh8fQRqmD4eCn_rc9g5mcEiD5vWFpqMIsCL8fJ3GsAie1iGZS36gI-c35dvSg8wK4ZVrN50JqSj8fAog5VsFb9PvfKDsi2AM4QYEbOUEp9xgtNplY5dRWfp8Dtv-aKsIDodqqs0xuA45DEhsi9tPTCYg20HJcUo-FtCtf_BTqOZjdwH5fhWlbplcH5AVt6WTYMEOwkXUzy9bAJ0kK1IlvyzBcG6A.4nSUyEuJ97QSrsC4wWUEPQ.gUw0_JJIYo0NiXgxr7A7zzpVCK7yFtpXPOmq4Ui8bjU2zUZWIIXQiRUSwUU1vpoZ0XY6HOVTUHAUUtCpAjVVKTrXX2kXFgrnuecGV6UYfFUsPgqoBuuQzBXtuWTpg5ONqhjwxM4cFq9pwimFG1qVV6E7i4gx8Oem3hGhtm5SyZn6QsUVXjjvd7z2CQj6EXWU75A1DdOdthudhGP5uuGt2PmXGpekKxBMuOsrdJ_gs0zdNkTcwomq8uTEz5TVV3Ox1Kvb9TrXt-CrDeMk7lMBPMwO5TF7-GhTn7Yi9gST4dIq6fukgwq-h8JbIVEuYUVHdJqkGhi_Ipwd9ANBxabTGS2hF0m8f36aW0lSCgY4ZpRPiQALCZhT_qQJJs2Gj5xX0c6HA0toPv1NKCBIN_9Mc1lOUgw6Jo_8S98kMcSRHpmdDEoeeiK7phBc1mfGAehPgZosaW-GW4emEzHtsR9E_xZOJDCpTw8ZmGwvd_-zSa2wgcmU7A3gZJp4rxphaEtCW5kviLDH-lXGpqVzW05OqdGzE3EIfJ-lxc-VMRDEvD-qGgK3WNB_uLVF5onGBD2iASfVDU9ZIQq6mjxRpL8NTc8B0fIsfH1npvljq0kbGsH5HEIXCaGFUpXryz2_m5yD5Eaudp_W7tlDIDzHzIG3KE340M-EFt5nZ6sCFbVVnyNBOTHG_4FXGaz5BXJyR-gn_5P9JOFcPqFQ-6x1lkk3QOFmCz9ffTh5sYuxfVYOs9uvWZt09DPb_qFX9rTjcQIIUIx8MmNfLzA8W4UVtLV8hO3LiNRp-Zeaf4w91weFkcjaNLJx1qVzneYVTgS8gwEGV2K9dh0zAWfHgN_kTQ0P_2N0U5W4Xq61l2crAW6hyWztAISRJsJW1g8YKxZDhnnvkfuOaTSJJ-YU6jf8W4ryYrYmfOGA7JnmrX8OsmJcGerfmLJc9IKFKKE33rph-8KJ2x9WRx-usxS1B4MzDP3Onqw_FCvEHqGKWE_l2N_nYKkkPYNNHbUQrpT3yYiJBQdEPjSbxjMQArZgVyysZPVefEyMju9YlL2Pdwiu310MVo_-kTwMD_uEb1slNSF0lxjZCNtpv6TxgM28gdFnRJ_gcO_69eEKJCqoOIzac1Scpmenhmoex98uoJwiHQ6T-zkVIQKDx24nwslZ60FjOT2IOqbYB0_J9HpSUlRuxZLFStXW6OoK0uYd1I2md2D65QiYnfi_xU3nJ6Hj-g_iBuefmAElfKzS733wwCQ8mWjxD3HD2nnlkb7IPu-zs21A67_PqHyDD6QlCb-VZB7fRUvFugbk_LHyiwJSewsK4iNEHIlARzJ7FUEaaTWISPThkGMugmA4i-2TYIyhHCFZNMdBLQMdjpp-G1OkTo0R7_wWn3rV2fduZ0o3IXwO-Zy52f7-FNQ831xmwYl7yI4YoT_IxSv9BtJU3olSHnEpv1DVcKSR7N_hlYOlma9VOEEFwYnbxDf5wWNBzkdmJ5vP6pdrP7xHyMlzzyEhGPh0wt5wdjEqmHnX0PQXPAA02w5vx1yZxFR0YmEPByESZS3nTIeI6QNG0_LSeKzzh-lXrubqh3nYeBjMiWziEL1W5vS5kS7qqjTQeXftXSBR6yVwTeibKI1uFyl20FVN62IIRRIhBzMncHV52GTPY8J2NSzkNXmgKVG0-hBncZTb7DwUC2GlJLNy6TMIbdtUeIWCID6O76uzVyPlYdspeXQn1ZSqkvMLoSSUv49HXIq373E8znhAXj5UkdYfq1IPXQuYxm2X2w6mGCYd1_PgsoMLrBpeCppVlLk3x1kR2ZIoKen-s_Ph25-_BPyKD5-TpyPhBwf4V6ZGYj4D2q6zPMotyfkp2EWcmttUPRY7CTEq6ECaojixExOyfTPKzNbGCp5c9VvramBh2pdlEDkQjpSLJIpBy7-YZbYPzhhQm6iQSkjRTJpsaH4khA57b1BBivfe_W4x3A4GI2wldsj_6PTZgNL0S_ycQ2qkuuzj_wwfHsAJWYM3A8ZvkHPSkKxi9Mi81AcFt8TlbsY3rfo4oTmELKpVgZiriaF5l8pWm-4-vd2X4_jOvpUSOhGzB0AAUkEow5jYZbf8UFQ4Rqu1Ple-xi_RoviQDahppp-yWi9T8HMWEU9ozKrzhQDYGV1251PzPCVN8REao43BfgTLbFgGNnMdslcdz9ppKw-5k35BW3hYTq144iKrWojYdr3Iv_hpD1ssxd0llcPTWa2Ae4aqTu_9CW8LLiDcVkTwXd64UvIHQ0aoMKyKw65_CNl9aX0jIhcjGHGJAQuBt4vVt6xoCmwSS_NZgQxF0l4kM2vny8zNuNuQ2pWtiR2MoKYJCrC8us-Mqbi_4XxAsSye2HfB8j5dSsB1pq2oZ8soPBis0rMlddhFouIdbUf9IvH9ynQc90-VwSWMZ-mlWWVeXt0-8WGOpoSdy3IHU4UIFnkP4W88U9rbuA.mK9jMLp4SeIZkDOIJk50a5GEkpk1HFRdlP_93VMB7pw	\N	\N	FXdiIoGeYdvLNcMyNZiWyC5wTKV5GZICcfVR3TSgkvY=	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	427c2b3ad2b349c3a17ca037eeb4281e
3a1dbcd9-bf72-21c2-9728-82c583715fc8	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1db955-e21c-697d-db53-2a221a850fe3	2025-11-22 08:27:29	2025-11-22 08:32:29	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.RoxoYKOwWK_6p2yXWUd6YvL4_eP4M7_frfMrbc37osfT27hoUxEFghqo2GyY4pTml_6xbPM4HRB2F-wOh1sJC_R6hopzm1e_o3Brf2nNwqkh-hcF5AwXcO6QzXF_xODn0F6ezBsWtgJc_02KdhO_BTqIi8a7wFEsHnG57cIUuD2t0mth82YBtcKU_pObAK1icnlIQ1i4wW8SpVK5uBdbvLtPQH6e3ZNTAnPxcXayFoDYytjTaWRtCMWMF6qC0ww28-AXjl9oOFzh9Uqiq-FA36U1Bkk2FUM0mQKCZMZXku49iAGYecFwhJmbDoKXIn9bkoSjQUOonRp10_Y0nMPuVw.-snWu0GqMavYkXjh9stA8Q.A4XSu0l2YW-jakEmQpS7sIhPufx9sCLcrdPYZ8DzGxy5jrZ_H8DmUflvDpnpKlwa6E9zo72c2DZf46n3Q2IfWh1ox8qS4QKGbDwb91n8_jz_joUDKZ5FxyACLqqsc9uyCDEJr52u6ZgRecNSLgaL_1Mx0bczG2h52KiOJKM6rNTmUya4Lt3J0cv3cygVmlkc9S87Iqdu2NxKHPN6R9X9u6rQ4H2cU4di8AIt3soNsSp6O_341FHJzzpIT4CXFUs6tn-Fh4vVSuRXqWRntQCgelszyRG1lsBZ7scTPRkXIfNRFKIr1biGdJv4XM5xChI9NS3dpRB_i_pgFmgnxi6KYg6x4VzJxgoAUQpJBl3cCNXUQIkW03mIAKpoALRo_ZFxSso7K2nI_FpBMDFEsG4IzruOSuIAfDjLl2a23FYEeohxrP1kHoIq6lnDcKHBXcVcaZRbSsXdNewvmOzLn-LOprzScHcaeOEX1Dn6PIWPPq3hBLsgllzlj5RD0SGgC840nu-y-SGVWWi0v_xI7TekuLpOy0M_PR_vnPV0XOIIR9GU2tP3lP-1QZDHAdgcBWk9BkDb__HVXzN5edBlZ9k-xdb6bXuE2pZH68gdQJjjjBYDwP6SVESwDSlEyYSRVg0Cj00BotOAoI5Gr9fcVvEhaRDpbuT7jlY0E1W1MM42ZvfxIvFU7k_vMjk6Ofa_-DEWLE41vt2H5cuoNRcND4kwXVQQi5IaNvDgrqSMjhh8zYEcT0hyBRi2MMVS_jS68nqlKVSqpDQ69mlO7JYT7L5d3RuCsBzZGYIAKwF3_sAps_bhgADb8QdLEAa8nW2O6_crj49jTxDbCickmYoJlpxMhCY_ebFCBgk3KJB9F0EsxYav1ser7H-b-GhTYBkJI6qbtOJ88TIz4v3ANjCFFWbAN8fdReK7hlmMHmEFI2lyt_ZYH1aVfYy8JzyG37nwRicueWlZyvVbfsuzgQ9O41Tqt1K7Md230s1ihIZCg_fj04pJnZ1zHM3HfVzMqjsG-4h41lvsc6tyJJodMiscX3TiEvfxBA0NcKPpkUT36jFildtpd9R1pPH_MNe7KntkmkJvLc9iMBdkVpgPHRked8WErqbPAiExINnm6juX5yyCHxBrnecJFTBzEW-FlDzgfV7G7bgdilbeefjSgWYiEfKXlQYVPUrubREe8TwOWOSxTsqH56JK9GMSP0st11Fw5pFWHaH3kHZFrEoNJca1z15NnsE-fNvJhrRq5HXxe7C70bxzujtytFXt7K_bX1pR3X_pq8I2eU8JS6lKZiTtAMy3wwcniQqkByXlSa6OS78a96paqwDyMF_6meB0nMKqTfPOPMhypHQz767IWmj91WXBqvpIudTIBx1n41HQ3FnUt7OUntxYM-e0RrooI8yV8jVWySXyDQgqEzVwl4tWCm92V1sUjP6-VgC-X8vRXZYW38Cd7E5zP2Lr8rzGUw6gHk2n8SCeXwqIerwAvSFSHMr6VOo4yy--ZS9vbc2Qk1I5rdeMGdjPAySp01mCFxkh1ZcumuRfyRp8T2fM1zfJd8FZj8vwJev5BXq_dNZe3u4LChr39tIWMJk8hjjdJO0cYSGaqS_3hIAEs2JQ2n67V6LM01uVpz4RdsdPfBsGPF-KM717sggKKWNIwx7p1vyo-o6tfli7mY1HJqY5dBUw00kt8dAYXeC9vqM44UG68kUza2aJvtnvk-IzZBjNkiCUniUStjYupya-knJn8Q31g-1GgRqeozwAghzPAsHQLDoltVbuLrDZLkTO-rZK_2w8oSnDPXrcjHuCt0ssBh8JOLBL15HkYg-R-VKHA_MssZ5C-VKknuslQZZdyFp33ucD_fkVQagxtEcODgoe12tzQ2E4MrGbLgS9BexPjcupd_eB7geV2EvzZqeDqyd7n0lPK7Y-4TDduWo56VujrxQByEyxBYxS6sjlK6kjHBSVf5yy8pPtnPtKkVlJUnGRtJAyc4Un7DodsOT-HRuLjEErsyV-xh0YX-W2DbbG1R3KZf4d-kkk08gllujf_AeoUg6krdKuOWKTF-YQmEeCk_OQEXs8Dgy7ubcq38y6yb-Sbt4l5iGRQeD8_oay-QCjln_KUZoRLPej0Z79kxUi6kO-dyUdq420d8qffvCVrVUBwsYlv9WzgLBPQ2tuPR-dFWJ3jsWOPVPSmaUyAKgQhFZ1XLahZhn5N8YhQ-ln15nIPq05SicxpFRWcE0l1C1udV8Qyg4zO61dAJlVTz4hN2g-30PNE4NgTxSXSvW86PMQyLo81pUYdpW6qaM8k8ESk2XtAW5YjOoMiEq5VuJoFPbDNx8guRyXMPaiGz2YX-slEetbYM36YvUiz6FvY3BRkH_tZ01NZTP-4Gf-o1cXhsX5PfeUoRUMQTse-mWCu9oFS54g9P6idyxeAiXd-kvMCrczjhcxehWGcfsyV6TnbIr1l1WM2Q.3GOxJQ2dWsq5jedwlw8q320WKVEt-ZcncPoVAWZpvmY	\N	\N	Vb9e4euCeWLC9c0jMh734LCfNlQSdMRVzUddrtv8e3o=	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	c95cc64e0f06444cbfd237c638acd6fe
3a1dbcdb-77d4-9d8e-cb54-4209317e0ec5	3a1da2e4-3191-7923-a780-699387b8fef2	3a1daa2e-4a09-550d-2d70-85760204b9e6	2025-11-22 08:29:22	2025-11-22 08:34:22	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.AFtg_dPwIVj3N49PfygrxosuIKv_KsQhsHMo1GdGPvLbWhGG_SKnmLx9RnC4DvTL4cHBonlbVnhSTOdJ5F9bTKahN6VY6rkXrDljro8Od8QK36YOHiUkERx4XKYQuVueNKf0mMrkWAOKJLJZmSjZya1y7t13tikeMCXcG6LXqJQep3hWIcTK4sgPBxv2F7vhE1Dmx5kn4c8vkTc1iZEQb0O4hQXM_XxDGWHFNYDzYIihZXX4KTGZfRrkrC3cuxcxz2ozvomAJqPnSl81DF-h2PpThcLzMcBrmE3iY5_tg2cfvvKvUmTj7ETVu3z0rjH8l9W_2hc2tzuuME6ezUcVgA.LHLvD85FmSj4sPBoqIzI1A.s-Cdy1Wx20TaEFZpWM6geo24cnQ75WHq34jbWDEQa8Tzoe5O2Fg3k-O0jhLNdFyh34_iywI79rtXE-syFqmTW6OLn0DMzNprntBbwm3XXswAqD7cq3OUlzf_Apdv4OPk0r78XQi2mOnpgL4RR7Lt1czsWA0HG7qqCMsJ2nLJSdru0C3Ky_otLFod5Cgx5FjGcSY85_dOQmprswQ7deqxGsnZDbgFsiY5IcUgxnGdCfeIn0cvbWxW8jsKEtjhWl9OGkGjyGH870kW2OLzK301yiaFY2ML8lMbmgcs1tnOGfKeVasakcpvG08RFnG-19pVxyXD4F_2DViTCP9PTvyjrxQPHpVdP3ITm6n--41_19zaQv9MmYk_nHVfoFoU-JB7ivxlXyt-wzIAGYwJ7liEkG_zLa5eXTp8ivoxkKldPgUsf4QevTdB1Kj6ZptN891bm95MwRFgxZCLslVIuVVt0xv18Z4kP0F5nipTeZ10N8pofxTrjDqbKIwf9QHj-1sJHOPjAg4HhGKOn9iDHEdbj7hVJk7XESmGmlaN0AbdZRKY12Fdqk5pevgNCUJUjm0U8TsV0iadzjke6Cv5OBD3kEixb8-wCpup_ldTPWu9nSMOf59S7DXPcXfVAKXZumRM37fRt4PPgnEHc7xcsZttePpgp5Xhut7JXsIfYp8j55eyo9Znd7sPx2PIObjbfRilmVgQwx0Oief2fmYqGz-6bmeCISKMurjKxa6nj0v_daj1ocUM4RtJ6QuHsg3CuGonPQmI_OWAXr9fW7CChgKNS44lPTSWwVBh3K0hI79jqA-pLp7HB_kVoHpHiuAxp64KwqA8tcCsDP_9gT6Smg1F7vCBGcxMzquhFqoiSU9ElRhz2TSZufXmqorg1IooHPW5ahdanFIkqsAgpwbcMS-5FNCQyGKryr0yoNvXOgQkKHpByzXqOQUbiU8kqHsk1SY6yn4rrMupeaQEnLKUCP1Z_aDb5jJ8IgJ5ydwgR9FcSWdkSEzhbzE5Zzuqf2DO33ZVzdNkY_b5NwApzzNGMFFj5qAD1lz6kEPulPYvXCa3tnGKOLn5Hp7jSmn7zHwtER65cH-gu3Z0cCwdUAvi4Kqk3Dws2Xcbu30f3NzHHAVrEfnozXbCqkV7kN3D-S0DfFV12z6clM0JtEVjNuM783DqFgmO7HZQyIcWD039p160ht1iNPtpGupCVRprvV3oIGW7bQ8i686rqxa0kD9KCduNfp4C_64hlWjjX7pbsSjD3GSUDIDgVZXEcd_ydtPh8HefcONMm7Ab5VOaB-8tQMuT5UKn82r4ERw38iQ9XkNRX_8HHhYz-xjQ8a-kFqEoumuU4JzmNgdVs18AnQjrhIDdyWLcCOL-ahCTXAOuXYje83T2WZ7rJzjcJEQ8w4tTsy6MoWoDPAX-ht966u9ZzMyy--UnakusCWZVx3s68sBZ0I6yMCiWFIP9ddDziGi4tdMGBbgD5zbnQwIDiWU6x4giOtM7FULiD4SGvdJ5IweL7z3i3hVk3a72ahy8-bkczPE3kLZYs1lB4MG4b_MWTxSQcv-IdUIusvKaghhnoyYWCmdiipym-plKs-SPB6Q8iIXg5Rw0xT2aZN5TOadKI1JnwSH4kofxMJq-WcCWAIUTAPa8TE3uvfqT7qtsQytRRKKPrTKtdGKaqzh4YEj87FgkPDOhARZxw-_ncjZSGkM3p0Abfye-gkaBM5_FyJkLM4n6fLKeNbhVbyNW9ApoIiiNDpmBMeADEkxAox1yhSWsS7k4qc97bXQJOO56hD8jlofvd4ri4f0RYN9Llb_jV6kTf96sxjmarTyPd66zoJlZmXbrs1b4G2r7PgJQg7kbJszfcxa5TqrrtQMWXDDHXL12_iH7QNmm6FdOIKDviTuhZ3gjKfU0QObpLGGsjGWEpWB1fg8HeUknfEP92xRk_s7M1OpzmMYLARDVzsv5lVkG1m0XCpggHpwYB6NtASjiubpj1la-wr5Q5iMRap5eOvLxMRpHVUnNUh0FHjCQDGJ3MqEe_32iAsjFxoav2y1u-VTY8SSbKhicneU7TdjPxVvKdDF77wC5lknYUjif80lEPxg4ZBWmO4pOc4T6f8c5Jwuh-EkbFfL7XgQ23KkP9yWv5HM9Cb6LwlBi7HAZguWwP_nC1bMKXI8psPGqz2E6siGS74x7cLicBpJE_g1mCfsOhceHeQFWwunCOKDs6Bg0Dv60MkfXh77WfAOAfwmvykDJWW0k9widFLhoQKmlQ4zQTl8UCPNqOfA2kC-IKs8kPcjHzTfRqef34MDUB2yukG_4EkNPhPQ57yFNvzdKny3RwIz4eHkeuCZVCCZEaTOTCcKAfNnkznQDaC3guM8R6O92SilfPWkIN3eZPWB2svSJlciAuWKES1GZo2V10Dn2ptf_gaVFB7C7GnU3arR1jrOwLkAxmva_77nm7esNnXsYIP3GkkgJNCEEWXrJkzhsFmO0bvKwcFYnBRdIYcz3E5-4ShgBCCpF_wrqLyKE2p5K_241a-Al3QdB19nEBkcSiSXwY-kJSlibo_69jkSFWKfVXNB0Gx_9g1r0AGxUpwYj7_t42b9eLucfPVZBwloE1oUsOYljBtoEn7hPqS94wDMD0eOfGh25Gz3FtnkK-3g6MDaH6gGAaQKEuUCATOCoPpXLUzeBIqbr1I5WUWv_W8VtzsLXoVTihJKshz-Uw0R9OWhq8Fk8KmPiy7YAFKWtcsqHujNwBxxg2Fa8Y8FBppb0.8ZzCIDLDUIhTmSNR-LlGUKWHgFLutwMdU4HprteP6oY	\N	2025-11-22 08:29:23.10227	PJ0PLue4qSZEwoGvhmt0gT47+3WNAPWBA5PjPiZruKE=	redeemed	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	55843cb69ed348f295dd6de9a46a29b1
3a1dbcdb-7b55-c944-e4be-e577c7ea9329	3a1da2e4-3191-7923-a780-699387b8fef2	3a1daa2e-4a09-550d-2d70-85760204b9e6	2025-11-22 08:29:23	2025-11-22 09:29:23	\N	\N	\N	\N	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	access_token	{}	e1b8dd36beaf4947b1542a7b6dad3c22
3a1dbcdb-7b67-04d2-74fe-04ef52e82262	3a1da2e4-3191-7923-a780-699387b8fef2	3a1daa2e-4a09-550d-2d70-85760204b9e6	2025-11-22 08:29:23	2025-11-22 08:49:23	\N	\N	\N	\N	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	id_token	{}	27e14d0d1e3c49ddaf04af1fe5565f18
3a1dbcdf-0e1e-63de-485f-b396d2545815	3a1da2e4-3191-7923-a780-699387b8fef2	3a1dbcde-fa38-6da3-4cec-3b6b954e7c30	2025-11-22 08:33:17	2025-11-22 08:38:17	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.VCqu9IkoJoEcCHIrKS6Apip6Bvb8gjiJydF5XxZAcX8OBgvHHI3sMhbEIeKEqhvYXqtD3E-cdtE6aP7GfxuZqFWvqsMu3stzVgFilQM2UF2r5ghxM5UOs8dHeGB0vVtHb_AIfZFcFgh_9zyDKPijrwLqtaQfjd2bsdnAcmUDo4NwvR3jiYNe9vgoQM4LBmIJmD6VG0xn6-MSmAUoSzP8SJRB--uW-xkGPzaamF58MMelDF4c-fSQxWhpnZuHARWJ7tQAB0AFoeqG4dc3GhuiV38lAQspytf4nbPxgibAasTKqDws_B6XIeJN-gUE6iuIcENnYnu9UQgIyzaXhWqlew.DTkyVzgZNZEQQHcWbqaeVw.84PcN7ERdb0CEROg2LUZf-TUrEnJqMxG1-ixd8DhqHBpSomAogWGbHeGhlEkI4TPyK5J4aMiR8BL_pBRf8ykcz6inT9khCwEa8AISW0DQxWp5fIRc7MYc_T9GMMXCF57Ed1siI2P1z5In31R4YCZ-JYyGzYNhGx468beRPlxBJ0HzNH2PXCVW-hGPYtIKdQNRXOnoAtlBy5OPp_NToFiZhUDiR6zhM52MqJHUCuluLqukvHM-NSLxyRdqCzdMoydAnoL9m-QfFt5JVfNFPoukzvSn4MTPg0H4aExv3z-2aTJnnlP0Vxwv0LoU-o_QU1XKQzIAP3ph8H2o2yhAjWua5lUKmzZ_JRCM0kIElJ9hO-8fj_RHPC4tnANkuGwqPuzVH2y7gpe-UpzT6bpMZCFXZmBsm3f68HHdfH3FI_Sezz5lgQVeZXbrgyy_623x4I4dN8OJqdSdgT2CgOiPGVl_a3lTOZe63yZS8Iw4pIzlCyLJ3GFi5KGzGxPxqx_SmMTexgfTHWZaIWi_Vw1x4IR4NH5GTMSGz5iyZxHyUDUizg_C0gQ_u06eZ9YNd9mOZuNiLVLznMXQ-RVSXSvbzdhZJi88ur7B4fq3pw7jNqDQoYU4nol8TsZS2LU-aQqN2B3hV1QdTJh08MZvvGZR6W6dJvZEkXHA_Qs9MJp8N-hnMFq3rVsFTQr3mFz8J5udrrxMtB9ELyd3t9Sz2LzP6P-wx6txKufXNkC9-R_mOM-Y_HjVl9oVqDdTq371_PLEZRXZw1468yRcAHBE9f3JkWM358GhV5ppRcuBhSLBhfUaUDBNuuPlr8orGUGK8QQICixBdy5D8YPaSN-9oUHcH5NFmbhH2Vs5Vwqy-rRGDELR0PV2ekreAOMmWOk8c8z6BkpMyTm0QMZxJL5itqKBD5Ww0Qe4q12jPK_pyLg-pJ8dDRS5zT5M3ysIpbini_eWemi-ghNBHaoEiMdRz0dtot2xIggqO-MqyIjpqLjpVlB7_WvrDWxQpp53hT3bc1nkW_u9qwUZ83kK-8vdX82TJcOrXpxd7Kcp9Qy7rgIvnSA6jFxR1V1JWNL44HGYt09z-g4hk2ovY9yWeh6F8fInWkcCU0V3VnWACRLfFYR_--wuu97GL1Rxyzf2gzj9JN8T2wlyaY685jJzNQPvT0AS2CuOuikwOqxg__UshI7fM6rM64hRkdb4yf6tWYq4aRpuHAewJfJXyYcKFMTPyvw6Et7O7fsTgTG80_N3zsQKQ0isgoszNHoDHaYzT_WJQnJRSUYZs1U8OASk5JKOQzOmtN8f3DhSyV7je5IAxYamakyPzbSVYFvvfWtZP1UgV7ZxSwjh1RQReCnIZect8dkZPD9mLDHkhhbrGMAD7-Ni3bJDmtSbBE1h_y3oCcfE6PG3_dPZFp8dKpeSZJfs8C-ZYnD_JGW-3mGWrvShR5lZlyFezC2_8jId-mY0oBcTjEvSWPpgINzuLCqhoRwl_XQmQhgftEUmOy7MVHj88TLfgg9m6ex7NB1fe3_kEBzYV7FtUbykNZ9jaT7YFHcVDq3g9ksVBIU-AW43t5fytmGO5J0GsahpepfigBSDwjaVv176z1oZChKY7Q9y8grHQTh7GP3WHCVjARUjoYXi-vpluXj7MpLdcx1iVcLCPMBR6jjnhIwi-QcfbUfxYzRNh1K6Ngn1zI5-NdJvBg7b5WHHNsyn2BCH1w59KVrHQuVjicDGiB6-dmt3njqRsQkkGLYZCl6BbU2TumdWuE9_9LmFcUPonBkquiXCHdNWBjvpUWVH4b5-rREGqodn5X_UBeviy6EIzK_AxkOKOnMNW14RJIvbMfZWnKExgwbVDz3phxs7wZJpd4q2Do_ekGnv2XdGo_q-QSAvuj9AMIO-4An0wyF0rvLDCjaeSaGkbc8BLmyG3QWEJLS4vuaW1uSPybvVUbDiDPLI2nffh3sjN_BxNKBH3Tl38IeG_wnlhrUaAuzPMJ7wsHKf08TP92ulxu37Sj36huOOEfNuD75PJkIzz6-BJpVqm33wrKNnne6aNvrsA8-Z2QFFEQM8OGy1Vin_7wo31FEcX_MI_X3zR4k-Gryurlu7QaZJSSFnOd00FV91jevVIXnp2tDGuHC98Pf0V7DciWomQ3EsvndzSs0CBEH7BzoOZX-fN3OB3JSHRWWO9g2QiXU6fkhuvwBGMEsLSvJvPACfU0lBqE_Gu0y5yCYrIWxcqwLICssumccl3g7D0ANTSvPxEvutPJvKPdt9NXY6gNLEXncRCCTNw3_Z6wvlP4JhECXjLWIcZor_ORhGur2Q0xlcSbl_8Lft4Ce7R531rp8-sQCwaOpCJMiQS9u_pAlquuLmshAra_yScjxHkrd5E_4kRX2Na6NqVnnxm9aiIta1ivYUnEnkbTdqDUvPMoJUC4uVDy6-C6FzdWUIzckXZ8ih93Fk26dlQFbBiLIr5U7esb939-8TLApDf1Ee4Zg_CPbr1MyKLJM--1fSASBLTvnbv5xr0eVsueXHBgkaesZdZ_RnK_OyJlHbSpXEq_9hbEmCe2CNueIyFMx5kd7TSVSkMod-yjwXijJ_9W9b_p6Xlg4hYUWyeFV9Ffj7WwTUNnGzmUSlfPXH4K8W5PL9LmOFZxz_1ZgBuxuaH6qjilLDpmltO588Tvs6MmhYJJbg8BAxE2V115KHaOYqNVIlH_Z-GnCpRl8zrLTnwUCydwseZs9009pNqaYJHBte2OoNVNfPI312403bPuE37i8ISRGrhTY4lwv85kCvcRd8D9id5RuQlDbrfCMPmLWrY5Dq3EsfS1czrvADdEoqGiC4wsMqbaKLME8wbiHBI6UcmrDXpd-wzksyKkrk_zbLXZtj-pOa118zAZ5MYfdREpvnZ3Q9063alBsxu6cWBCOx1eEKx8Cdx9anxOhynEGwQJdt6Ih_ZYswUHYWanYeCWTCueocieZYCvr4M3hyy3d4I1KlHFEeztefOnZ0iORKRO6X-K8yfBw_tR6qtztG5Mu.YGJNHQoQBCw73vS3cpbk7HszIVbpqx34dNvQ62k1XZo	\N	2025-11-22 08:33:17.502481	jadsXFsniZlnQQJIaaFQepvrNTFKtK7m2wxjqE5xWOs=	redeemed	3a1db416-b2b2-3609-98b4-058d6ceeb9d2	authorization_code	{}	48a7d7c8a01c42a8a05f2fe05cd472f2
3a1dbcde-fa4e-62f2-b60d-fc880c01add1	3a1da2e4-3191-7923-a780-699387b8fef2	3a1dbcde-fa38-6da3-4cec-3b6b954e7c30	2025-11-22 08:33:12	2025-11-22 08:38:12	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.GlJ6QnouS8JVUkeRgt5a5ZB_fmaX1i54FjmQy9ij2i7Z2KKASVJFhhf_xHnhkOrXgNbxmlLDM4YidNhkMkY9PeGCrHFwbbdfLclxv_nW-2UdHHCPSE9mHuh5__ngeZf_DyWA0KgLFbmFPiD_61X8uwPi-sy0S3YIJbxpMx8VwN5zJ6Mj9XpA-uSsj93ktj4rJXTj2lHwsjxHlOSJyh85Bdp6-5WHUaRq-BGMdGyCwwUNNeaJcJPlPUKw-GjC0fA14QELZgcTPkBb54_7VLl4Ru0cD2hsQEovbmh3vzH5y82piumG7QAsQs71bAvJO6oAdMqhNSFDmeDiUeXgC-rstg.J4c0UahjPxkc56KK25SVUQ.WUQwT8RqQh0r9i_WmJd9wXFtmayej1k1NmGJdTq5YczUJZJIY1pXkSjRBLDpMFCWVsndi5NXh8dfsMnbtsdExgbmy81NBqm5MjIXlhbvAuEG5tuqzu4VycmjirgUxQq7OhNk74_b5IUNEop0y95TaK_BT4nUvKTGBmKCAnZoYmoFkaXbORVePG9xOjBEGSSLFNYswwlrY28g0QPnB4qxcdecyP9ltV3h2AU-vZBAa--jK78G8tC3IUNp0WrWQWKUYZAGO5SWRjyuq2CQjyj5c1RIYm7AdzecdnDwbeeb2UTMVg2sCho9ZbR6nFImibPr8xVhOfOQtySUKp-oV3wmRfwiU93pq07FA2ZMC4G8zZKHV-nOOO62Clo9WjGU_I8WL_M-jWGJF1m240TtRt6WHExb7JkMop2fos8ieojxZUQ1tHb4SOlyI-f0elKjFhboTma39TFRGYzwQPXT0bAazo-JiMSYV-WEJxooRQqtq8TDn9phjYna-nA1rWTkha-6JWz5J0YIeZwaNI5-KJvfOPSiSmcvix5rcTEo30HxPoXx9NK2sQhhNpWMqubAfdPHGE2qGDiJgzgZ1p1Ityem9boHnhqha-FqdAHRUL6LA3pszYztaB3WUL-uDELBYXGmiW8dWAEoAaOb_DdbM3FNJwqjp920vYlvgh_eHEyinLx32zt_DgcIlTjEuEjnX4xTXcVDvJ23iQngA0z09JY7pm6qd00X8BxXRmqDo0cXW34Ch6xHbuKubetzJQVGh5yrmHQBvpblEp7f8fxnitQvRY204B2tEvIFjZY2ZWRyVL-XVfC2yCDj1vxtrYkbaYx8UGr3mlUTy3Bd-48bnB8JbS6sM9Td-Ad6LKeIAP_cpXU70dndY7gnii_Tmt7uHQ741IID5UzU2f-9KmfgIN9MReGOBLxNXUvr_sMhnW6CGybwflvR_KiAFSSjMDW0RjQe4i090tIU2N1FBh48KK4PheFfih8M5s3UkaPoWs4SvvXayUs3d1jNY8vm3dR8E0QcOv-0liPyBA8xgTZ1TjeJDLY9NrvtOuk5G8JhVVCK3tR2FWTCBsmFJjFsU2gmlLw77vDV6mT5oyIMg_ZrbLong4EXM8wU7N9pyGHDtY_AkXn76duxjrPLX9fr3sEAOJeQ_12JOoiCJEk6mECINMZ0cNLcUkB8pdxjscP-nfdjAcoWb6W4L05POTK2wmKLkkhtXifUFAb6Sn72pwZdqhiABfHJ6tXA8XMenR-QUzMi8gphNkY3EQgHAIpaBjrNb31yidxOhxwdD5qRjpmKrulFyV5JpdXgk53HKeURYr5t1QTBiAI-VPLIcHcbnYp_U_rYHIAxXRTjtaV-Bf5sGvdRUUiT0sgLqCVN8ZbkqjgTM2xeMtucwxfzIOWbUYHcJFQzyweGVi0A40uo3UVk9UrDcltSdP9z4_Rr_cncID6hD8g5eOTVZoap9Dd6A17KiXMp1yGtPA9OrknxVxgnz6bJaksvgBwC4UaVW78AVX1HBpPHEsjC2DQkBjkPuMBYMgU1nECIndNaAvC8_Txl8Ber7Z7MMauENFgENHhzGdaF1SveMfAV72XVnwk52_EdbOPhjyoqFHnEBrqF7_iy7F7Ai7zOvep4k0bUxo-VC_J4Os33sfUoP2jXI3Pi6aOr_fVwXbc5OJ-AlHk0pBC2ttgjh6nu_cmYUQnmURQvS5xojm-maJTzSMdqRNL-6P7ecREwhcPAW6sNNMBpmPwnncaX5-B2v-yy1VBghjSFmRaqMmfvG-nSDd9rfHr5V1Lu8bTG-TAzmkT1-TT2ndijVWg7ckMX56QyyPBbixbZ911hm0w0OCvOy4eJJbLHLOR5n5JfUyBp7NzfVUExPkuymba-j1gGuaoPdE-CjUn-2H1tC4I1ILotG9wmHWKm7GEQHpDiH42yyZgLDsdmCC4pOg0zQAQd6FOexXX4_jLrRFbbxI_MnMexRJ2k66PJrRT6RKCAtAOOYafWGqxhmVKiOjkoM0a1ZnwVBdN_hLzkaHcO1RNY3RTwqZ_xYJZ5TDqc2pcTMRsScAEu8zqQlS4AGYioExi20N-m8DRVqIepzeCynLRvuO9SIUW2NrfXpwi9MgDwctTpzoeKfIzb8IsET549tmbCbmAMn-9b71xHY_-Pe-gRI31GHIrjsj1lhn8etxlnWa8kvy7HarniYSZf495RHzSc2vaEcKCsB6vQPhd96kr94MaKedxb8cs9WveM7n-chQmJUmU9a3OwIDW6-VdpDTCC6j7Cw4KX4jTN2t4S5Ng2NxqtK0jDthwkZEWAFQLu33v0kLmSjqPcYTMLs09tfMVsY5-w77qBL6UtK-9nVLZ_E_SnSHq6OnIMWoU2MH-U69JQX_YkvGtyYy1YDljeZ7d53-5UkPnpOYWUNt_9IFA4_mCSmKkS_Ih1_hzarrpXcdDSmwnaOBlY5b_63P1ZuhtFDL_pNixbA1zYoK5BqPkydTl7mJzbY_DoQMIxzBkEYc6AeB-x049OqC1nKbfMk767JhG0ZrKeJJf52EVPfcM8XBR_NFQqenjhDRneMJNI2xlxO-5xwx3YVrGT65lRGlCbgwO-0M8Czzdjmqug_OTi8oniZPvTJrcpY-F2QVamCwA6fGzbMcLUPz68LNTClCLGsqr1msHbT3Jf1ds6tn1EnEpQzHx5NrRDTupR_coAku_tKRqmgkMfvzAg4Jdet6-DXbNAdM_AlND2_EaAc5mGu8P6qwegI2gaW0yiE4NvWofNQx-Iw7tCBqGfOU9JQtomJVQfhdeNKDaIdTsSSakodxAsvckkyFxrv1BCYc6Y8mTGLb0_sbmF_l9Iaolyji9uDRGDvNmgyANBdmIHCs4juQcncF9rPqfPRMlKi9-8G69U1gxMasw9HoG2_Noe-Mlqldu1nekgI192_yFo8fyf8hKXtqtDEs4ZvJxQl5UL6EMoGj0mX6C8dukF_q0V2LElJWlZUFBgKWzmnJa4f_Z361banKIJdJOHXJiXOW0D.AUHJ32q4xPFtJmiwhKRqF9dt1bM9iSpXKddOI6PUjwA	\N	2025-11-22 08:33:23.262773	aLl1cRiCRNxZg/SyKcCMOQ40Lg8GYhV1DeePAAyUWCE=	redeemed	3a1db416-b2b2-3609-98b4-058d6ceeb9d2	authorization_code	{}	ad349a6038db4cd8887c2b19ec992b9e
3a1dbd5e-fda5-7073-706e-40ec21a66a4b	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbce2-c141-ea2d-8cf0-0a30b045d5ae	2025-11-22 10:53:01	2025-11-22 10:58:01	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.OGe1YwhDB6c3JmAeEPzWnUthNLvfUMUyEfzHBiipnJRpJy4wbvBUETP75BCNIKGvc0ferHbCnBIDBL1pltgTuJtYsAmOPSQRL7DL0VlvGTAKLG_n5uZjLK0d3V8Vy8vbV4_wdidsecvkw-woCYmrempHrROUvHCs1AufdSOP4Tveak2tPknKdcWRQwcO2x7SfggF02yP1WGSNJ2oVQPZpXY5jtrUSrskbTgvkXwJqsmqWNSycuP4XwtxD6OFznYxvehJ1LujVZ7jh9pwunRuPo_EWffJe3GA7Fs8j3WzSzy1kS3lej0F2-YZ01AmhUBStuswN22AL_C2NjVD_ebjqw.1Opon3BQpZGF_ul6HKubNQ.Ev2JsytHsPm-R0-sPZmnmE1ecrGuI9bFsegqyyzQO_QSX29uxJmi6-u_DUCfX-xUoWPhdWLzlO6HXOa14W5jTuszMoVCWowaJ1ZWv8jxjfU7oPb7Fm_A7zBnw4IjjojiJVUp0vxcg00BL5oLV3LQkpydh9TayCg-fxgv7J6c2cip3-5vhOWf6inXXmymOO-cC0FrJ5J9N2O28qhC0YnN42BQpXFgptwh4G_F_ykDBvTwa-3Iinnwa006OlN6UD37AbzuZqs6LWw9yhfLd7aRMmCOBu632Vrmc9PUVk4aFbbxi2ZjG6wA__FfpqPRHuTA4OO7TM2MvsxNujkxLNaRX_UUU0J39KAb2ifRPAUbXGwIP6Hewm657q4ww5xBVOVBwX9-Pw4BeNvJ1veECBY8k1Hyi4H1syehWiCXeOzUGlqVOS6o_ROd0_CnxjC3eXUDFE6UDKELlIJuoWXsnYLCPy_JdS1ADsCZLBq72TxcfE12RtWrX7gm5ayA0NZuDMPM06OXczunAxv5cb1fGWYtWOxBV0ETj4EpFV6TD_NQoudffdR9oMheHQ9hFXKziZTrAH6ZV_JK7WHuanmX04Vcx6lmCMSNx3O_B-HV6zFse-gR-ZFfdihzMpb9xid2RUvqnylaA8zWJrR4YT9iTrLlgUTUucZIQvBj5lY9evbvKGqPdCmS32Yxe02gdJNBzchdqBUeHxvdAzTmptfrm6txrDXNsvU5a9NoBoVBWLx9gsM12G43yC9HUOfNMBw8-ojz3PBXCQehrkKWcx6x5HpimvauMcsu13NKxF-ojFZSC-Yi1nkmiI-Ft38i-7humV-XhNJr3uYlcXRIOLiL-1VAItthLJP0aY5-st7ySJ_p_6w5P_klERjk9ifYfUVhI43NzQh2kyxblU4DzSw_48eQPa3j-CaxXlPAM_Wo_jlUhNTukB8IPF73VZLO9eCCJOz0OB7Yt8vKrslpiByVwJt7XthfKpfcl3fjwkQcldpXIiuynRW32_0cSllUuogYaD-jVkh7lhJY1TZUHM4lZbHTH9FVgYv5bX4WUZ0OL0pMJceQsA_8UTRhdtvhMZM0SSQr_fPt1P8c2bqS2tjSsKs2dMLMwRHP32qeBnElFaKsXYKzgPY7SN4oAeEzyUB5h2VQXpKK2gV7Ad_b19WXu_hPbCzbAex_wXC8drvs0mRgkacoLV2d2DfiM-MB3jDAp3bWBPUiHXRDefWRU1qEhletTKmsL51KF-E93XwsP8ZB067dBlBlzCMAYvqRbzgeqQgs6ZuiyOzLoIexsmRRT259tmIZQrIf-DHYAXSo9YB94yuJtcS6RNJud9WKrg5-TaGdYR8h5Umg-RZoyAlpoHzUmje3REMgDIuWOspxy9GZg99UrdjPPhwOcIDPlRs_1Hykw1OwqCetGh100YL1gGSgRzMFdkdmWNgb2JN2sBOx2yJeMFrAYv3RMKorTyrMMoZDUDRR32dv3jlJpt5iKXK4e6NP7n0Fnjfg95wrkKBNJgm0Oy2OPMRP0AE5ZQi-selVunSdgyTVesI6F2OJlR2AJ5xHnxkiHrKSsrxuZ7nTo6fYS4P5hLgwBmFL-lkLeOG0ruexjdM86EyQK6RvhFv3FIyQnm9hEj5ScxtVb4cJJVpzCxinemuVP6Sko2Kw2IWxAIKS0NaHbQpckPWMdu_M_sPJUNidZIFXidVFYdFHrq-LcUFuRqD0EVZlBgSYfoM-XicD6eBPb3w9VgULElWx00oEpN4K07VyIX7RtAbghh6qBEquiyV-zOQWdP7XUhg-J1cOCmSFt-q6u8gaGXIhSfNBr3h1bhgvtZ6NFxNXuEY3kydQ4x5dZvvgjWLutZdcbpIkqEAMOiDela3b4VpBcyDPyacIJ6n7uQd6wKM6OVQhXgaXkl2iN5dI1lo-bubS8TPRoy_pX6HvZCN9XxIRNp8-07LAshFqvv_jOooz4zY3cbQQSvFjPUzfeNkNEZQoltubOcW8GeiLzOd4AS0DD-UY2_lpPWohJ8ARK7-_rh8QDChaiH5yRo56aT8-dUD26UmjsQOiVlexgCHjoxnKJIDXxFDDHs23gVRX1aadtzUNYEdsRB2qWFLVeowrWBE1CAtAlqjn_au0aXBl_5oTg1I4wtFfCvmAZqOKQRjCU5zUJEEmw8iC4-n_7r9ClE1FG1X3RTNQFx3f39a7yDwqADI18mgPVKR3qhF3LOCmPd97Oput0_bOR72EyNVzV47MfoaNWBlyFJG6SEBNJWw45TwFhmfo6wXAxU4VCp2M_KE1K6eutudVOWQyyelqt_VXi7NmisqWhFeFqRuhyiKQzG-4F51iW16Ui2boBv7I0v9cFtmTczFKDGc-DnWR_Ax6uX-F0eINMGwKxw5kQ_uch42QlE17I5WFPqnkaFmtvJHuHwtXBEC-sy6nNUk-fvX10diAeuUcGtkF-z_kjWE0qReIrPdJcmZkN8vlswqQEc-jfsxVeHUBoKO1oM-gARB247lp-SOMBdrbHk0rLg8kNRxzoGOxdrP2WZrAqzm6SwGVvV48IFgaSUsap-nxn3iq4hla0XCaMY4SZjC4rg68I2xaO_tGtD54_2TyEPUJXWIDBK0C5lzVJJzdKz1WHyfnIeTmCSjs1_jEA-vEijYNzSrXCr6OmCesKJuquw5Raj4SiUMv1QbtFDpmFKjOp2fDfzNZGMlfzOoxywAM9EzeLg.gZ9QyB1EZHRQ1x9bEWkPpQt3xtGCv5Y_-sbuXej_Q2I	\N	\N	5KTta1cvibj61tLPbFTJtg5+bDI+T3uwwxiGRaBYjrM=	valid	3a1db416-b2b2-3609-98b4-058d6ceeb9d2	authorization_code	{}	e8a3a1c9288c46dda8de44937ec82a7a
3a1dbd61-5082-ae50-c270-b8f0553e5f96	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbce2-c141-ea2d-8cf0-0a30b045d5ae	2025-11-22 10:55:34	2025-11-22 11:00:34	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.RLsx91Nz5cLkKkfMl8O4tpPN-BV35FrHQzGbQz_H2atPfRZoJWsWx7J68H16d_gW1cUzWLKBFSMf8giQfjvgGEBFPfuyk25urlWUkQQmWMqa7Xu08s5Xn0CSZzuvdAnb8CbdYPjc0PNmI2OBZ1wTC_C37Cg2uOa1FZl-yb1bgoyIW_A23bBRaaOIX3NDzrGWBYO1SaWLqylmrMBTlAuzELCG8w31h0O9YL3vYvFN8E-5aVuo31OsIVG1PiftnSaSVoWr2Cvs7JZCmyOUMP4mAGA1W17y2350TLhXXSNjrSMyYN_0dn_iiQRCW7sRUwGfzMy1BB7ELfTwUn9SFmvDhw.PbLAUpk7UBpusOQRHyoEZA.2-M9vLCPLYBmqWKyfW0eu1Wow2kxXhbIE2P1kPaW0yB1vO0kfQAt3yzVtiyIwPQfAUwOHBst65nt4_nTB4lGU9NdegF4ykGY4Jb1SK8N8xqhBh8EszG1OivDztsOmfa2BCSV5Ay_5Ckh8GVaTs9bwA2Nmww6dampfvsoQjwGPzPGQTcXblyEmSUU5GsquPccAwOe5SIggvb3er6Qt2tNIiAHaic8H82a__8c1NzFAi0DLq7_c4ai7gnTJS4qb311Q5XgSOWKC3m5cIU1C-rmodVHTUZZZ8E1r6LFCLZYYYfamIyZEAldjDefYBLEwlsaczPWGgrFQ59uDAoarQr8p5sWkf3lB6ElWVuavaFPzr_8ld-Sav7yH2YvloU5XMmmlA6UhB0NCjeav1NZFJQQQh2QVksaH_Wm_nStiwLcDwta-1pJ6wP4BEwoSs5T3TOZzK9CLaj1fCrftxAEHP3MQbua-XanMh65xqx3isDF5-q1gfCET4uWrQi0Dty2HKe48hWASYh2u5XsCixKtf0gFczrjhy8FDm5vKSFCewdnQ82bSKCwegqptcebm6qq6C-Xm96xrMKDT5c4fYAyNnd_o3hxdEia2Xl8RhjZvazYxcp4zGSX549J8OHJ4aAjwgJksre81mvjOjRKkRLzyw9RdsvRW7qdazD4dgZ6EUJvtXfT98P_L7Up8Au83DPbFr8fYmv87XeRd_rlWNaIzsZE24sPggApdXz5SK52wDCnYVJ7ZtbZPjoyxs12mppncQBKf6rEDxOzZ4lpUuK-iMc1OEXxPqbaNBDWRpgyclGD8Q0_xI1PNJgqR_IG05nlQq2jpubmQk_gG5l7aZCbe1HsxXLmbzLCdFydwQfRn1Y9vpN6FMMAVyrX9ezvDm8IHTyGsW5aQUwE-eSofNGU6aG7O3YKh-v5H92yuM1Wkj2vQceRe9U2QdrHTSV6tMc43NHJ-I9A2uM4wddBr7Ex7izfHWhqt9EitWiYK-nTMNbHBB37qDLfNs_q91N9Swb3jYJQ8uMoYgn_Gd8MT5MTLzApoVpPn2txUCgeFFM5Rjlw9DW5pH0F26Ei3Z4LD-_f-DZNZr9K5U3kaqOVD97y1VoN6hhvbC6-496QcmTr1WHHVbMpMB_cBLAa66Y_rjvqJO5wCnO2evjSQKDGJrUFXp0EbEIf9UqZQd5j7CnUf2MtElmFaFN_1Vw_Dsphm6dy3fTSffk6XXf_OEQSqWQTokFSHL3NX5fsxAJJpep3Bb1_iA6C2wTSIgQVvn9T83E_fGeGLyd2X4QH-mQfj1EJQE1IGJFIufBXwg1ws-iIeEUZ4e31iF0RTe8_uRjU1M-DQGRPJ3go8Jk0Vk_TD3d8crkaS95JVrPXjmuTYyomhh2UdMLwo3rtNpBcXfljHLZnHyatmI5_K58_qXe3tt-f9qVyW9qTlQ13nVIBwnucV-G5AdWUdharAJ1KJDOz-Su7y0mWTIcS5Ndc2L4zQpL3qOkSy_N4zdGJfF_KRIcVRhaWXy8SgYI8aWwCuNoSEw653hQeL9rcYFbEZVwNi9UN8DDGI_bwyWgZrSHg6MlSACMEgH856rDVSBr0qhJ0HlCdxSTsN1YEvdsstH1xB6rLpLkLaaB1fuFoiPTax11piPlXjt3fuVXce_trpxaDZCf1pSY9Vo-KyjyjcimOrtQMeH6yEx-KFPL_6aS8IUsQr9OxNgqRZfbgJLz_WvC9_1EPfQddoSNzAAVw-DpEHutlXxJiZdlO5Br5uwVZdT0u_yUBCw6PFQ1tt6ZyBFOcz2kw7bHC8lhoj--mMFB3LRuhVhNIPJIYWWwgPHDTzJZcr6nW0slHF0Zu_8vK9Jvf5HPgY2kkfALyyc6MtLi1hHF_xqtGHEAtzgVM26vTYdOKYTc-c169U3bUkUdCkeOKHQ_ubY5Gs3iQhCab2LusHXKPkMKEkkGkbZLSkr05PhMZ8lGuXcN4nOJyVryRkhk11RqJHa2LRdAMCCVV9N4qnXOK6Ms_SqTkWZOAEOzFb3v5-b2kywjJg4tZYuIY81vbeICwmc5z_2K0pSngkAHeTg0d1-DzaKFi2fmXBvMWx2zWYD1ktBKhEpSfE7sj1LdJJvSYOS68PmHFP897JP7up7V6L94KRh-VvvJtN_sGoWDGeCMtJIjDNVdYPoVUrCyV_w7cJwhd46FClTi736SxlZBILfTlZhK5WHcDRhGApBfagkO5wlrIPqISthdZrg4M2pmovp41D1c-EkZhYBrkTTpPdHB8D-ZR7J3htBT0lP0d8nbBEDiNWZRh96Aok7Jc43GX2JN1b81QBYCocOIDUGuh01WIMT_9HaFIkVJUKYh7JxaMNTUcf-_GMfpkedNhwGZg4pgxg1tVP-fkF7zh2e0Ih1VIc6IeTVKmXVCTqjVZ7AC1eOjnm2hVqTBsDMQ-DlgDoF-3L8Iu9Fi7jQdonZbRWyaXlG9wWC7PR9BVXz2geRc7Ej6qi4x5Zpa5YOSf-Z2rU_TzbN8r5UsB0ulkmoC8qgZCacculXj7cU6ygd4Viv68EGXr2alUrtWnPWdhWmvABwCkawda99tPui5JR9uPCUh3TQ6VPEBm2SoqREiUc8WrmeTIhg9cgf2bjKy13wh5durycwIoYvVHTl2FzFmXqXgyPWOVc8LIB2-LntrZ1IlSUhk8FJPHPWLZ8I2oFmn5DYUUhm_aXM6_IoBcC-AkgJdog.M1j9jxLcK0Cg0BdAO2j_kOFtSFF37macsuvKsWxpQpw	\N	\N	Vm/5V/K+TJglK9dVgg+fhZp7MMCraVYJA7NBbXyaa4E=	valid	3a1db416-b2b2-3609-98b4-058d6ceeb9d2	authorization_code	{}	6f1f71d1c0994784a3c22e0fc4e6119f
3a1dbd61-8045-c561-ffad-053e700bbe1b	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbce2-c141-ea2d-8cf0-0a30b045d5ae	2025-11-22 10:55:46	2025-11-22 11:00:46	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.XkQm6sE4GiH0yQkKQUK-SSBul9pAH_47YWRQEL6wQyPPIbSdX0cYBGdtZBOSu8O2-68sXiWg5DHKZW1yXsDBAwbCik59U3lgkKniX6STd3AELeJmSXE2154ElxblB1mC26h5yej8TvauLyJJIn1bkz7rqrUJYmRHxfXqq7ZqWH2ZyAYpqejwtFb_bb-BG3-iWUY_7XqRIT45J8hUHuidW0dNvs9dmZbTOZ9Du0juHQ6qKmQIC7OlpvnRXvcoG3agFzo9vRe8PuVa4qSegJrR18h9dP6XinMhFc1C6Mirz2QuRDHASDT_pCmJeNhPU9jXRc7qfkhsBCp6zPOKQAu-kg.ktqAhnKxZV7YbtxrgsasDg.ER6HZ_gma1bsA8j8VrDHwI6R-DFZVxcb9NHgBDDBMWib2GIbNd0qzvuBnqYVtWc3jpT_A6V_3KuyTBaDgZGNp1A-zHPxYCKzu5XZXf8yJNJz4X5mqpH3--M0AF3agcaMw2NZI4QkEf6xX_sPK1QZMssTxoapMKIOZ3bHV4jqCcvvnSRjUy53glH4nNHHS0xBdAXlLGtSxbmXP0OJejYUMMxNIrVBk7ifr2g83ei7p84gZ7GUsraM3VgqiuJvF3XZuTyLBmn3QmRizIBJWHmmPjMtkVD7JN_OGHo-eIPKgvlEhQF1yM2RylaaJR8uoN5n9JZOqmWbQnQKZaEWXJ8YDeVk1QuK-9GuLHEi5RV96C3H-AZ05yZBY0NVLRFruXxIFd-9_Y4nuKo2FdEp25lMroVOhPuqAgfO7nJRvDp6Ey6ItAsZbuygLGynCih-D45wUowktsuHH9M7htQzMQwNKO3B2Eb6MuW6ikqlpz3Mr510spzR-ce0FRJltWG_svuXjUCEIswGoJgeHa-xB64o4HoJeTHt9WN5cjkiXrxhXMnru--QEPFr6LsGmIlNE01HC-yccotvDP0NMPTQeiFK14iClLXE8nemw9BZvas10FsxpBJd5iNsIEsrttmPuXDqWVwm5mDzPSlS-KIp2xuPVLC84zI2fCxnaZrkAZAjS1TSTIOsp_CVp0DR8fCZRgBQxcT0o6uL7JcQH8eDeOF-cBseJa0Fyrz1ag_UWtdDmQ8k8uMYGH9QSLtbvYkanep_sAWewvdzyPK7kQpLlpi5okNnMlbEtSE72kOF8nrEQN4hG6s7JykdfqIYTPjLCIAmEScIcb7-kuzPmKazlkQutOjkZM8jQLAvw96C9mnL7TX-0AsKpj1x_eJOiLIXoVHA8NV98Wj3P8NTvAdBwNPbo8WukRYOIPAa55KsXgXlhZ56KoPhULGooem1qI7Qd1tGp1hmuE2umyhsLd2ufbl5fxVteatzcHft9bN7za00meKpBBED3JqSUprzV_iesBJCRtOqbtzZ0jO5meRZMjHDLb1n4ZcA7njDKNjzA4y45oMQ1dSbynN5OUInLl0WhD4rmaV_5bA_Oi9QOzLalZNADzk4x_xhc9hX0mpODVH_37yToGDZ07qOk2naNMu-PVxryzMdisO4pS3hfBVbR3GTzbmlNasPLYEcRVbIgkKtsgQj1VNoput7mA0zCLumrRasg1evLCVsLOs8GtPloDDV8IaKbP6S6RW-AgZUKXB_ze9p7osnKS8YisTby_A10uZqlK7pm6oQI5cwx2I0wJmEJf-UlLAt45OUybd4sQylHxcrE4En-cO5tRmXLvm8sIffuOaaa8fsULmEQfY4hbw91YdBOAs4ryJnoJ4ISdVun29koT-6Zy3WGnVuGV1m2HCMwvhPUaos2wy4AbuWmBstU69E5XrugYlx_GMcboNCQJm7URf4z6Vlz78cFvvt9eificlCqmNAA_GjN1QhuhKc3k6Vn1RWepxwWJVB4W-Dv34pM327Cdf8GRagVlp6VoMxl8AR6M8ZMTSz3i8_JIlEfvzLT8hcif4AHcsmp7FYRCC1u2nV5yvQgBllavVZ-IUTWsVBtkQ-umP73vmvwWDHbNVNIqjLa0xAgdGAmXRfSnl4NIwI639HBpnNuDPro4CTMaz9V9aGe1tIaMljsqNfsKd5oplQlDxLjA1_Yn4EwJeqXn49nd05lDmzaDi4Cvh4r9ZpkGx85uiZMqL-R7JppAAAZ5KgAOHkjnR0eM6-hakVZpcjg-wYlTnf0xW3PbZfVLFy34KBsrR4ALdcH0ZwmCo2fbfzY3sMGSebfPyp1ynzQrnJpoX_Mhvvg4IerqzmvU1XmV0lXrpZTng4WXet8OOWpb45q---WM2AN6hB4HN1E-Kx89vkqFtHWQfn8MmbSMzUlOz2kk8iKWUo_SCm0du6W0DI7yn1IYR-F0Q2bndVQGMqophOj4k2Jh-6LMrqP6cQy7MPQYy7XTs3sTL_g8jiM8G-4am4uevz1eHCxaoXrzjAQ8YgszJUcSs1PAcb4csMboi-49Rn1tmgCeBtM1JnoLjbRVQqDV_feDrZ_4tHFYA8_WiyzeIYP2XQ98oP1yeyuO7ULOrt6NwAqnhKFlNIoSg_DvuXy1qG7ycmgJ0SRIPwDNNtVOHZtX0-ClSkdcJwyJ-jpKUmvWzLjOhEdHneevdmI4zAIA-oo9vxdYecq-c4pW4idyVY0DWPwQ8LXLcIU73r3l5c-tloN04i4iGe3qmBMm2yPW9NWPYv_RmDaKj6mNE5gRuMWV_nP99Kb6eYijNvDyrT4kRR3eC3KdzJmuTv6ka_M1KQIxXgOgZYPin4ZpYUH3TucK6xLjqXze5uQUl0UCFQlDtnmp7ibn4v8cLciwgSX3BMb47K9D4Fsj4dzOt2fny-uFBPYL6a8EqibpCwFeSZCQ48OTqsjWaEe3vjUcX5CqDAGSOIE3UnaWwbOUdzDmnH299CFIs2nFILZDetqDv7UZOasrycPGdhEARpV1Rg8gCBNTO89BpRCtT9OuIxLUzU_GRIK0cn5McT1vXanJUXC6OfdKYWcUpFbV-uDHhw1OpVEQWKQFOGI1oeD1LB2EDZ5KWj8dxbTjPfj3nrEcIuMrHNtETjJXDx5DSt1Sbix6pCGCKreJ-wFjpwZxVcgZekJ5YXbCNkOYKOIQVKEMPU3pVarrbdzA.wLCHYy8VCTOODN2t1UmQ43zDQrRVtvPe6YWMZc5vvgA	\N	\N	VQO3qI9b9T33HHwJZqas9IKOSbkLOfutKws3AuFfH2A=	valid	3a1db416-b2b2-3609-98b4-058d6ceeb9d2	authorization_code	{}	40a4e83f791b440eb4e27dc309c31b7d
3a1dbd66-26b0-7786-234d-e192268fbc0c	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-22 11:00:50	2025-11-22 11:05:50	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.Pkb2N9DL8logoSpogE3iTrh-uS3XqcPUMSsSa-n-3pqle0cONDNvdxrSuuOCLjE6hFa3xl1eRGGdBJIIrDziJC9ejcxzLzwUt9L3rljsINWbfpmbPUzl5OZ-NHoESUTmmoy3YDx3c8gjinh8pwMzN1DRn0Ril1KFnKbiLuvHqcUuUy9FlB0r8oKVJwtFtW5p5HQGJwPf_h2c-pLg_xn5VL0xstBWmU-ylRkwbSsMIrF6Tyq_ViBpDP_BY6cOEWO9mdEoJNkBVeoh6jVI68UT9teftlHnQQyVCr5auDCgh0sG5QHRU8lKEid_gUB4lSRBRSvafbFBNGo9jkym0cShVQ.lMWSlrUazfXabPgtDD7gKQ.QPGDzkC92y0FnO6X1tQWEdgiwQLQ3wQ6cfuWiY4cEdOEnHMYzFFQ_EbFK5A6ljBVgZCL8zyy_02jxhQOBDwfjTqORycJg9cC8TRwB3srfkRYaZOQdQv2joYNKHt7ZngEHegHLPd6beI29sNAJtz8P3CJcUhbo_XjMtzJM3vPXQ3n47vXVJijzttYgRUFwhxxhhOlWoicBr5i4hwmyS2FIBZp-QEh4VuCPQZ3Cstoq9lPrgz8XYoXJ_u6zFHC48EYcnIsUUe1R6xvVHKGcmXIxjvZsF0VV-3Zc4HjleJEgojzGzPQT7sZ-nlK0AQ8MxpV8oLI1sD9rbtTNsAuDLR85pAZND5YcSL61zszvA3lQzifYMJhIzT8uLkPTPoFov6hMY2j-P0NcjlRqd-Oeh3LjgkD1U6gWLQzs1zzR1QHCTn79vRfImt_D2pda3P1VohOOe_Af7FciMdKvb5lFdS32vj7yPacPoeRGxVvzNQA-LA10Np0gOBoPBQzLISATdbxv8SXeQoGj866M7RGqINlabeNjBnP2R0SyWTvZTapHNJxQGrYqq72ckG2_e8f0qgZpZey4NhpYbxiEdttcT2EqhysRb7BfaFORsmXyaBugT3Ha6iukg2BfFjs0lA6zj_YgXjHwGuOVjk6bqSEuhu_nP4hO3lGo_fBWWXGzKeaaYXktRZB4MgkMMz2rWaa8UUSzrjQDwHsx46jYbm9WQlLJ2ibZhNvPkA1tyR8pX0R96jXlk-fj46Z_Wj_XEqaSTUPOeXGUKqUHk0LUjZ6dYJ_c1bBINt-stAXYQqVeTFqMXjmEblGjJFsg-hyunCnerqcbOmc0bijVB1cIgdw5r5yaL-ifvkv1sTnMKg5US8CyS5OxIzjmSU8NU3A8035dMdJnKb5awnMvElnndHrsdfmG7JfFx5bVvouMxB8ODN4vPB6WxVPq0iXmGKn30URzQOKabS3Ko_8-JqOk05U5fi4_W30dHyteWP9VGv25yO8-TD8u3gPWMJXeM2X_99OGe5SczIkFsW5my1qhot7qstQRmBsv12M8jq6AFkV3RV8B09oMl4N-VQohPXHtoG3p6vZEru3hEy3SJ--rhT93YEbGIvhJu5Yk9PV_WbFvQaQHJr5da45H_yQgzxnYJh4JQgRYOTyqs0DMY8BQAWOXBQihILggrdSJ-k_K1lT9k8KVBUID996tW7TKmX9zX9YEJq38w5r-9zSntQJ4ldvko_hJKQrwFe67L06sYQkZ4Z0zUf_TkVZnj4uH5oNhMe7U1pKN18TJ1ThsaQiavhhf5QsaW3YIT3O109SE9Xxz4jRPw0Gxr4DDf6M-J0KATREFgZ91ABGJsilcbqa-4fVWMVKzYHto9hfh3NB7ZjHxnh66QgSW5oC_KTyb34eEobmQc1yZAomvR1SHDanxKpyZbiP1N3ZdFvcxjaiPgAZPlNw95cjNswK-emuOn44_cQCK5k-MLIZSmw-ZEIjizsSX_-z-i-fSr_9HKWG1pqHXuUrnZ6Avf4jXzvEIQ9IkBug2kdopQcMcW3Cbhl32R18H_Ziv0mQdZrmyCCZIlk_uVoeUtvuHXlbDYZlAvMLoojKxm_vXGHffwJzIlbSDgI5v57Vk6nUEP2OK-Pd_3JpH-XnGj1hw_bDpulK1N4n0mRYS8c4ZKANJ26YTawPVS8yd85b_-Tz0CzhXXGq_IU2C9nkr44pyZIo9WeLfsn7Sq9NBOCFtro0nrF8fFoSwjAnkcxERpivHdXOy0IFFpqTof_QOdoDOb4y_u2oZ6dhjA5csa-JrVgGm6E_xB9SJZwGTDeoVnjp8CaF3VctdAZmlFHlxF7Bv0qxQq_cHzs9STFWpplhjM0gGLR-MXTYwxE-B-YixVj2P49--4a1BGZQ684uaKnwYQr5_1ngWe8TJYj7unhCUsLp1ZGRKE_4-gwIXSaXI9JoJPb21usOXaZsh5_liZ2hQBEUGw96tZClu9UdcVOAVSXVJQj01ko9wDWZQ_zNDvFNWpLBOeKZVAq3J2SqYdr4Zcc_V2U5-9ui94r19Ua2oBtMbN-eHoN-ErejW2SLSkf2C74WT6L8wNaeD5hQkMMzxCegzfeuLzytdnvh2qabm3W6GMCNAJjEYeT6DCT0Fl6vPj8cGY0M2Gi1guZNMN-Iqq5nJoAFnIN6Ca8HCM2T9mqbgBtDlX9ABTKpLOklf2947UeYEc5KarWFqCpIHqDLNZxnD81fI2_Oi-f9bc82WHUWb-rP8mg2uE05JXJXEawF15ZJJu_IKijc-6JZQ4WaIn7BJeq3saTxjHUqjP2vZL93Yn34hyRBP9gYoDn9oZOZVNwJysRC5TIt6zjB1m0vZK5AjvsdsMpumDGS3qpkY-Sg3Iq9Ltqm_wOJvAPCQAYLTRyExdEWeDcoYEe6DtA8Ew8A0JHEKHoOoixziB4lAS9KB5qywm486_ZiJBwlOA.QjlykayatO6ZbzQ00u1BhR1cK4obkO92C3dsW5R_ngg	\N	\N	VCLDjLNq/CtxMpasJEb/M7rAAnMt006fMu29f8tGiVk=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	c11afd0b669c4f37ae1bdc6117eaca8f
3a1dbec3-985e-95f0-f7d1-3940577d19f0	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-22 17:22:32	2025-11-22 17:27:32	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.XWXaKFRj0yfKWYJyXJlb3NGwbLuwk-BdoJL7xo3NJUJkIVuikNWKjyIq8C1_9fZLVEgx93JNu1wmWiAW45S6N0eIADMgf9HHSy1RdgVMcx170xR0pzxJN6fXaM8ZKuHGCIRzAQY3ADGOGHFW3bytn-MkysKrBQbSJKawbvjl8ElIlEsgd8nl9LWKO5utQkAGD-Ln_y5-nC4uxweyqVj8w44ptzENqtdjOlQjqFdDEAibDA_d5uYID8oR7M03c1Na-KmTs1A0c6Bfu8VpbSp42yPh2V13GVKYxyxvQS2Ythmg8EmhCqQAb5TCG24gznF0AprFTizFz4u2V_iYmaQcqQ.ZZlTfutIVE-3FrksCpptuw.BN-QsXaXu76c7j4DnY31tu1DtfOAlSYxV7ltYzpXPbG5OdMDtfrarFYPqWsaPfNPIUCF9ebtUPMKRKKUuT_TtVpxnOLUpYiobUCIOCeNk0gHIgQ0WGwmh7rGPrBkpma3oplPn8DlkftxiiMvQotEu5j4SRISVznDrbMx9EHLd2A67faP7ikqMiGoSvOaP7-505rko8VlicIv7w_EssiXyKMQrB3axNQnGOqhhm3rvEZdxin1Rt-Efc5RDb627aiI_Guew0-ERB9jP7ZZCDWGazAvvQ3U2PSb1daEtNnzQZVyP2VIY25WCO4aEUEX5C8x-AV-WoYN9-WVy5sJPmMwMpAXtqealBSbDYUyxZLkFitAtDPXpHDpqMbMYrWlwzbWRwk4NItdjuGXiiVwmuayWWtwPE_VpM5ZOSlkI9D1CU9eCjKnhP7KMr0Gv52m5qiW155UyeaMRBj-jVBmY-tBdcCu6rHNmDaNdJS9LeA6rvwt4QrcuA__-ByAaVjYqvSxH6P_CYQU0mTAJYAOyOxc8mXUDX9403lZi6Cuv0bnNuwZFy5AGs3mGYJ_0qEu0hXd1oQPWILjTKEILql3oTLXbOYg2Y6ADdOS3n_YWnzQsPY9fpiGiGtUR2nglaAEetKjF5sL94CvZZwwCyUwc3-GUWPh8tY9CnqPDgD7a0ZDG8mX7cgOy-XCwtQR5pG5YP9UkpauxKCrrRI-1q-UO0mPGtEVlFb0QS4EwLhIqUcs4DQbMPFQ5OXQVwEjzRCYAXOBUnbec2gT7IfYCX2FhdFxbK6k6tJJyQQi_FjeOO0E_JC-wR9TSl51MIJVaaXYt7DlhhYA_0uXhKv3eV2JqRz3XyqWXhrXWwJJVGJ6ldM27JDRkN_hxFP-9cLqPb_e-UmEJ3RDMDG3nOA7d77H5ABAFQVh9QdohzVMPyO9iQsh7M2Av9oFsqTHvkY4vlwEoGD6aNjt6zvzJ-qiq82lEozZia-xOuMizW5T9gjbmSFomHDKPkCCdDYcqhBBOqVZVjlufgcvJk7Kc4xbq9_1DUhxUcw5xhzF04KVgKGeShfr5XlOWzIBLIlg0t6VSHa1kh8Z6ZfcIB_W91R2dRutB45ioAOlKp6D708Z45DXeKugRk1IBcBElC1aB5s6FRzkQQbrpPH3xW2FZA6x4zepxOuOstPpeInfMGSB3z1j16t_FPd4lV3X-Ke2T6Ly8oAyFSsZ8e6m1txJWpSkr2pqC-SlcnWbQw6bCKPK7CGDEs8NfGS3GJWKtahjkRvFL5AKQQlleMkPQP6cNAQlvorhnWzMxTGfen6W1rxlvIIhavHtEf0gifPWiWQpnSf1nkj_-uIgcBWGPe_sZonSd-koWh0yMzP3DXd1hHJ7bKo46MALUCwWFNqsiZoqBio3RA3elc1pT6VtRa38Hz5AE1_HQPu1R0FaEIxDRinXxZ6OictCBsPKh9m0VY0glCM8L6LDwsY6S8XhhPM_quWbEf4P9aq2VLDrya5kxSqZmG9_irbAIRpb2gwD1Ggi58CKM4awGHLMA1ZOBzL3ZwkIY23HF5HFm1CS_BWxU9dB-N-lZzfag8z-0u0KmxA5XcOauBJeqjasiotFUdYgZCCTyZnLUj4dy_wUbwl6CdOxjD1NvFNcdXi-nz5DkShlkoeAzvBLYRwzYxZuUHgOyP62epPNF-mxotK6lWTU51HuCbw4lfZdAq16GeowZxEIVatkiBRCE2auU31cq6BWhYS_-ua56BozQ6tYsMvcoJzyTgIYhv3Ly4ihJ_vVBbOghakcsx68u-jRpOPwRY8xNKniF27oW5Vm4jXFqEc4SxOuvlFBGwKuMVwCwfEK69sqDwgiPNkK1vXUJItpUvbi680sUb6f71orlyWh44zTMpSAPurVp1GhuQueauYUU60cV0-XwyKvxFYetQJj2kXuPjLOghFbsJT_RRhdbwqPCERz6fjn-XxTSWP-W39b6MEir5Nd8pSCDmBgOjfpJgVbZ0IvZ1RrA0uGInFCcrrGf6V6n9wmoLmV76tUYidU3QGWBc_RsU2Mr78XL_yktxTGQb8qmmQFQ8A7r1BmYIGqseR5s6pZpdNASDFQc2yp074kWlui0wMRi03EtfHWh2PFOawHO4d5nvoNSqJ-pzjwbVNTeN2_HU0o94IG-DLNp_lyA5hN2FPhqeqivkmFUwy_Y06QG8eSlMIXOCE4y7ATN75Zk6U3pWV1PBzcK_OTIdcp97DFf_aTq3KOuuVKk8paSEKeXiqFOYcsORLPyulO06bvZYIsLcBi9RYDs9MZ2of05wnvfBBSkQ2A4ZcMNzz8lYKsayVPBULq_qB8zroR4J_TER1R08ze6iT0s3CWymR9nRhBPVsYMBZel0w1GC-IxYM7jdnchmOQp8BdjtYNFEOo16xwyc-KzNG3UZSH09UbqwAVlNaLwoFr-HpWnbmB7FxHsfFSBWjAnQ.MeMY-plNK03L0J06gWsaoV05duCWQOLIW1z0zW2-mJ8	\N	\N	6DjSSrBxljSYggDN7ZAfpjemzeNTp+3Q0N0/Ktg0g0U=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	35e5ab224e464afebf2721d3eb86a5a4
3a1dbec9-8e67-6837-e072-46677d390d08	3a1da2e4-3191-7923-a780-699387b8fef2	3a1dbec8-2d0c-ad13-330e-933785192bab	2025-11-22 17:29:02	2025-11-22 17:34:02	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.ExGCfHdVdACRwIL7w1-5N4vsKtHvUdlCVbZEzaiIrhGt6d2zdkShrNW-Hj7y8d3sTIVRzWCTbNYzBJzI8NlCgjbvdrXgzgAbzHEq7Mm33q5SCBI6N6U3HRM4veX8E3d0_FVwYPHo84y7arx_tSgTMv420VtzAZdgrUqp9l5O576PdW_pX2RwXyJGBG5BRBweo2M9ia5xP15OwX-jbucFxlTdXfuFi6PNmKug4FegvVxRuRCXyxfnPvosQJ3bVJOtJwYYqA_L4o0uv-xwCIkmINZAAYeUuiVArkvJgTJHlNO4Q7yAKqNsuwYJgIgZajR6VvLbZfLQ0Q_k_rykz274mQ.4jMiqvoaSMt-fZbgBkEHvg.UMzN40hc3-TzIimnUH38ynHEbOr75D2jE_rHbihukGRFz40RQTVp0eBXweIR7nva028QHTNEbukZztcPhUNDXfCjfb_RxH1kLqA00jm3AG7cH2YeK-hwgfRhwBwbSesLyx3sNlGx7owyRd8Ab-hsMyEg5DZnE7HFFwWmfjpr1l5_pYd8YuMpnnynx7_TD_wXvmG54gsJnHpS_i5KDviQbKZJNYtz2z5dKgKFIdLb36uNPqUMR4Ik-Yj7HZV2Wn5BYUKqdoqtDHQbwHfBf5HN0exU6tDO8V7owfQCLB-z9zroPGDwudkqclJ16c__OILVUocWiOnMlGodJUFoJxkLiaK_ZxFb5WFwYtKMca4j2pU4jW8qAhoThw6al4rNAz7A0BLwbIWFBvD4LfjqM2QcEupXdY4KKS4bBRmHv_RMr_8LszeYSBCx-zi_3p5TVpdOCz94dNrDH3FwqPq4JJoMP04zBMrsn8CdHPuzgC7rprsLlORhbNFxOV-LL9IashYzxiA-PIZs-PFpZJ5nX4mcPVNeaUIZ4kixrIu3fE3efTm-q33L4EfMxDFXgnrYVQ7pPBMcw1NSmPVRNBjd-iKlwxDkYDub-NyRldMw0wjjuOzDuAebgsp38ssfNOiZh7w2GlfgzGiuMI2UayF1DHPNy7OPO9EJHZUIcIGw9SgDR8iFkpf-MpDxpbow5q2299_nAcCNX7c8uFSdKO4bgiS8vs3SsgL9nFoE4wtrffhUcugTn81BTc0AOCdJ2agH7V-8Ma8h46UzjgfyNB_bTg6ZuzOgikoViCT4a4JkHm2jzfMQV4_Pw3ewpHAQljXqD-JLJRsxqcr-17Dlah9tRbS0zOcRugPkrIzXk2wh27Sk3JK7rZHtbZK9DN1I5EpLHM9ZIdtAEq7sMWPu6eeOBCkzvXe19vZy3pQaxrv1OGc_j0u2BbVt5YbOyGRfOUAvfKvZZ25k37GlX2UavDbz9C1fzG7OmuTSXYEDxhKSn3SrNs1wUvCTcFegAu5wJLhuFF1rTfufVHIt-i3MQEWS4_rLQq4aBVEDyVIguC0LgaEwvBw5fsMa4XGw6sjKYGNsGelhKcT7C0w3D7GFhDN7CxMXHutp0A6rU1_oTsjbT0gE8orM734QE4UnlchRtvQ7J8iZrtkL4Br8IyMiu2igoqrfDzbmIbxETNXeICQBvxWTZxaXTlxMScPeyfI1SASoW3uYyfMoC-YiHrbYgb198T9hYCEmTRQhmjkLszw_4OS0HqktYhzIf8EXz8aYE2YaS1xat-ocPBEn9GaicvOxLaYYgorc3sES8YNiufuiXh60ar35v_jdq-UtmY0qnIUtbEeZ0a_kp0JQxe2N1hMjyLCaDf6h3GjVzBoGZjc7QJctIWDDV_HC1liUr8jbsYKJMoHAQ-S7bZ6RiKMrlagEzPkUVhqAFkeAiWrjMVhMZWFkM0zX_biy7r5OvbZ81hGGPFW642VJD-VRmE21EewJjhVvIwERzIKZSsPzQ9nz5ENArcVx2VaAYhbdG5gma3M3THdopLKnDgYDkNB3Vy1fBtLeC8et2Zo2nnflVXE5PgFPOPFADdDX6TwiPqUku3zAeR4_2Wl3cyTu5WN5DT5cAsXwJK1YNpcOgBSVHmDCtbGMKFiw7MNWPWR2MfcYNF9E7-Zdff_uefH57YjuBilA--yoObtxuo2t0WddJ0jLk5KMgRcdzroe9o5YHpvD55nuLXLWIOzFuVGSUdcBfevC_nCfihcKZVFMdh1kPul45Y-IY-VVlRSwxD8JhBbAYNli5XP0G21Lw3xbamNGZc_KLpii_7NIOUNO64zxR-r6duj_0fuDEgWlgMHqvemaQ49Z84OoqOioA_DkJnz9Q5Lgi6JdTdX3sWyqN-_9cayNptCtOiIIz7_DInPIl3YLVmVSLJnN6nDjOnvgxtIARd_l1tf2hED2gd3bH0hLepWclDYPgIGYZnh2qyJzkoDXwU3U5Kz6qI8oYnfNOkIL_p_TX8KyAd1qoEFMCjkH0s9OaDChYZ_ViEWO8FeAptnoiQ-WRz1K19PdJlLepwnRPc1e5MXbt9OabtRXPBj0LG9d_E5RKJq_Kt-BggvJDjwFLR99TAuzrgCjpa7IISehn2uJtpP_F-cvgqhBTHizNa2I_l_HWuEEXGRlYOx6yawEoxvKZqAjL95UuUFfxrUL7RY8c3xVHwVHymi6HNIz54KJWK5HgNOagzztq7PFcg9YSrbtTW-DEebrrndKx5tf7xhQ0cMhvWTMUGHm5vpmuLYZixrhp8KQy2orXt0hThWiRdcAeaBsPK1d7w99djPlnl8Yiluaf0FP0gs_qpC9l42uWVLvFTDYRU2Us6S68uw6Z-Z9iLFEWxdBU4QRHf9-ox7EjtkHcCIZNvBZfT8CQKWo-t6pi73IlmNjM18lq4INZU2dnODn6D0zvGAwllMBVQcbi6z8--hzOKFZZvRLAOuh9UIaLvIhutUUnzYLr9fA3CMp5EODISTOO4S_3Revtro2xEx-oUcibqXN85M95pu1a6CciW-u9HdFVB3yOsYWZkFrTpVdBhsZJObJbJBx47AtJVqYSmYhdv_jFhm3-C5joxhiO-HSK5mjGeABtc2yxqkCnhNkxhrPt2hSexDe8_Kq4GkMXl8GFNgw0kMzS24MVJ8gjgKnAX7EPYbul2llVLPI__-yRUQEyiV5NIqWUcADy802mlOXi_-YiJ8kS8hv9lkRElUsbLSwHhlSK-Sx-Kud4y8V.UKO1LKfEst3s9BZIEtt1AdcBEWAw0YuFfGAaBWC2EAM	\N	2025-11-22 17:29:02.931814	p4J5mjOovDAVnLC/eYC9JF5ZKR9Oj4cxnB3wN3qGCzI=	redeemed	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	c02b93e9bd554f99ae2dcce445e81df3
3a1dbec9-7a8b-5790-0432-a777189a8297	3a1da2e4-3191-7923-a780-699387b8fef2	3a1dbec8-2d0c-ad13-330e-933785192bab	2025-11-22 17:28:57	2025-11-22 17:33:57	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.IRRBJgVF20cjsi-S8VTx0MBe7hzZ2Ux_wtLg6g8YFxNcpqA28uqBs0lkvyvQxwRr0HCml-_WhXi3xdvDx8mZjK08YJv1ZlhdODGS5wfaCEwcIaWBRACibl5KrqiBhIcAsudgiPcPaGkMqKmJvjDLW1zpcnBBxcrDfNnww1u3c_CQ8cwk4-gqxv1U0plXG4PUt7NrQ_wwJKISRPuGqC51-_SL1viH5nnCU7rh3dlDuD_6z4fkEMHxLosD6haVCIB7WKi5QMlWbilfDQAITN-a24tbJ4M-JSlH1HEDUL6pQJypF4SCA2XqTQKZQ_ASOO7bv8tyDjiJZ--L-70QviYXqg.tPB5KkDexLAbvJJ3xgKiTw.kp9lhY7tDpG_J7_2OVswRxb88DKMTZL2UsaihpvAPgKGY2AOpzKxOLKRnNAeF-yhm5JPCNX-5LkeiIb_S8P9RuPnS9QOnZMNfgBmXKe7MMcaBCWsjvryM9IX7MzsyepssITEwBfC2gGAKwuAslP-WFUeOmmRgn0D4ZvIV6hlh0cJRAz9nI9YzfSSrHKcF-2OwkTZavcke9nGJRfhVKJdThdyQjwA01DeB3yu7REtHfAsSyRTMt9gzipuhbgvfuU3DCFybITJpDO4nETjujuWbfk4BbOBk17zPrJQe3yGmXSgMcLfQLuBWTd4niGws48rMMa787D7OAPQO67SUFjhZuGhSEtFIpfWhHskPwznGZbEGyXss_PSuGXnR4Q1hrJynmvaf-XIxPgaoUB7gvdslwQ65kpJItKQ-1ArA8nTFxfpz4BOZc96Af0jX7rfrfq-fDLAZBaqnwZv42gE0ssQcZexprWSt1pdueVgY-IP5QWX7yLDjeYOPKr5i3mpsecgqa1iFnmeMoxrKM-Cd_gmQOcEZZ_Zo-wsKbwySbfk_diAO6AvO9M386llbZocGom5e89CQR5FxjF4r_hQ2H0uYqOsC1nfPluzTLWvZ94NfZcBdccpp0qb7wxyXcnHEYu6Oa3w5molioXdmXr9mS5XLUWTWvRXQv8nY02R6Far4AARE_NV0RFt848eeYyXr_0c0Q1hm3U8uz--24VzEg3VAWh5KI-hTU0KFGMqDM07CN6V2LGhoBZ7HsjnWlT9P07evx0F747KwCQ3tz9lRVhXJHaiAAVbN6Tr5KJlMyRA9LUIbvYDmzDkrMetYJmYvS7Tsez4o2-FT_ibT21hczgO_FdgK3dE75taCB141UB4_BIIUHBgeTSj0_sujmshy0dcKphXnuPMO-EcyedmLT_cjT0hV8WsiIqPUyh4o9XLDDipPPLVG_KHpeV3E_e71kq70tkqnKNC4q4C9RYpkejEYX1EV02cIIFbaugP_OoDh8eKh6DIULnH3E5gZz2uNEctNvEz49A5Q23Zeu3ZQ0sNgBDH4JsLkxw8LtEbl5p1f0roDNoX1wHi2ntGXhZSamoRtZS3B2erqCrtShdxxcDszCiAphZGLphp3N7Eav99l1OhbSmmyV5hVUSPEYTxPftLVdSizuJC3dsOHEifAa_nhB1abuNzRrWY-EsmVrmCSzQ9egNwI1VDNwTO_kDKi7-0mgzyEwzApIZCiZitEBTO9KdTfuM5R9bwzCZVTCpMZ3HpA2OvePOnvM_xbr9sqvPX51S3Bzb2ULhIQ6tkFFwaXSQkDKb5P2pDM5N9GCsMkf4xuS4Q4HEF2STXsQb7Sa-wtxtDXflsJIGwMKMDt8kp50N2M2dT6Zlhfv-709nikt3gdGRA4sXl8U4pju3wQTvPu5K-SNbzkGbwkKeiOrr1MWFVoEvFU3CISXIoWUMGTvdkV1b3Ghb29Q4G3S7lzdqj4-9DT8mnNvmgvafJCM_p1h0vXQvoWshcT01ZDS7HO99gHH6jLlMxtVYDVe88Gb0MrtTyRjYh-cyk6thI9-ZotFscpjt4G_D5D2ld8mR5kWoJW1qoQUBJAPh9Iy4die8duPKgJjPon_cwvGQu8Wj5dZysdvbP-q2cSGfkV7OK5pR90Fy8MURhEbyMoiuxcAiTneuUnb_y39_68PAt7B8x9atZMI7JJRsNqsL1RPQA8S0xwP4LQvFTHZj-LQoYyhYquvhZnipyQyJrsNZUjSNRK6HgxnWWPDZCBA2e_PuLWVNwLRdLSpB8pUrEYe6oCVQWxpGq1ZnjRkHqZbr44wYbmEILACd9iUYb6G9QYT2keAiNO6Iq2U7WCDrK95CnLG3YWLIt0Ass4VeKDNoXGNfWNQ2uVCtY_RyRCanImeDAwn8ALM-CJCosC7OMtJIioX1TxXIjgedRWXEMHbmQ918PLetkmnpQIkvJUUKE3Y3M8AtPdfdz0Kjc0i4mnvVDsBjJ_9pqITMbn_slS5lEzLnhNvgRrTq_uiSDCTV1vDsMAk1AmRmHztnjJeI5qxHjBMizcL0HIJJ8hIr1wgYKjZCE5Ok0-kH1o466pDMtmRAh4J-AxhYrsXD1xzZM2wSw2tV3KLzEPQGa5Xdj4ewPu-nbHbGCAx2-XHxkZirfP1g1xdNhOYsXJ8glfw00E4Hiw8RpuFdqklDEgzWVzw__5gzJ8Uj97BSZHx_BtU8LKuysUui4NXuU5g_IgVzJFdIFe6qYCnItA4snTYHszq4K-MVqKrwx4eVZtGBgkh74Vz8QT_XFUGhUs0Wf3o0oFKiShmeee50z8D7znzT7pYCIx0lhvtwTMvPukkZXpEGCwABtxGzV1qC2K5dorU656XR_3bQEViWXTU9oKs1YVj22jNHRLzS-4yTMXYVpoUddO8mR8nTztGsrIihpGMYWgGswZ7uWyrdWNRoattut-c8PTZfuGPu3LBH7Kz6iMC9QSJgag-MeJgXPUXZQjVg7wybPJnTgV2gwlrgZcO-CCQhqrW2oCzhtK285DaF61SoRGOdml7lUKWVv_gYs9NCUQgbkAUVXwCB1vpfx5oTXKVgDXSotPUjS4z7XfVnidKAjBwNSp3rzQ-Khlj7uYRo43MlTSqnvDy0gap9EJwWSd3HbdWRwQDWZBTw2EuyjUDpvuRjV_6wkGyjSH1f3z_dFpkpASkoM3NtEHNNrgMpMAESQ61OM4TQLwLtMOFki0Jxt2-ikoX8bI1eHYezu9vAPcJQsZkod.ZsqO4qRx4jZjtX44gYCxQvHMtDxul4r2HRbGH0TozgA	\N	2025-11-22 17:29:08.537225	xAdv+bRAfKhi9LlTCwzhiKCNRS4TtkyYBxuNuHkjsEM=	redeemed	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	43bb8d629d5944f597c8bc5705c45014
3a1dbec9-a4c0-20e8-c6ad-e3123faa5e58	3a1da2e4-3191-7923-a780-699387b8fef2	3a1dbec8-2d0c-ad13-330e-933785192bab	2025-11-22 17:29:08	2025-11-22 18:29:08	\N	\N	\N	\N	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	access_token	{}	7b189d991ac24ab698348d4d7b18f609
3a1dbec9-a4c7-1b4d-51fa-2bc034bc6d63	3a1da2e4-3191-7923-a780-699387b8fef2	3a1dbec8-2d0c-ad13-330e-933785192bab	2025-11-22 17:29:08	2025-11-22 17:49:08	\N	\N	\N	\N	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	id_token	{}	21e89f2eb40b43de926eceadb5948e5f
3a1dbed8-1f7b-d397-4bdc-d0b5554aa52d	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-22 17:44:57	2025-11-22 17:49:57	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.yrXmfEWGkuekWRwJgl9pufn1eI33Dt_pFKS-Qqn_ZSZxWTLw__rwdh4EVr1DO5ErQZipqNFd9khddlRbyb7L_m848e-R0nbMIkcjqkLmfB5jVhyz3N4Gn4pLhhKHndLW6rBUEWd1xNjv82SB4jXDwQuYGT-V6XPfoxW8TWIeNRo9WjSJEnAuTagZxK8Ef1tBAp1DwZR78cQz3fg53Rm4YkxomZJ9ivaOv866B_6DS7vjldkvuunqLh7mz7sidrBubQi6hrUHMvvy0k0m1_VREMxByfqKnOmPcoLoqUEcJ7mhKOLdVkOEAUG82epwRDMw6Ok1zLcNxrQhFKkkfyz8LQ.v60DPr_u6FogNyqXgh3eog.bGHFEMga52Dcl3GRxC8i9h5v8UHsBUa1NcXbfhC1qc6tw6TF95wL_unkT4VfwUa5-SYAvQVFJJV05UTu0l7Z09OHCvL3N40HqBz2QR5XmGjl2SHBX2D9QD5hBOoSrwBv3_tN8GP9cLNN4Kd_RTch1FMc5dWi-ZkcgSmav4QcdHpfXzIOb40l8yoS3uXAHehziKhYFjcT2zLTyo8yGWy0gZ5YzdaY6fYsMPZFrVeqwDGf_k8APZU-Q6rfcaWcp3OmimlwO_1Fm8a_QV5HPV-vHDji0Qtp1NuAYNigBZdy3Da9ZxrfEIdD6mgZDu5ms74lfcz-S8NuJ04JNOhHCdtdmrq8wu4YQN6_AIzCELBJXtoE-5LuuXcmIEkkVv3brfQzaPUDO0wKdktb3QGkYG0QnoGIByEfSyXT0-pj_vtQ0cUqybeLjdx6Yq6ffgTATj0qKa3YhsBFXvimdfw7lYgYR9CIagDTEjhNly0TFOcM949-rqEG0bn5uYY-rTeH4WAaKaexgu315ycSgplH50J4wakCoWiCQRGImwKNvbef7ZA5qa_bfHc2SbHInj1ZQ6f058ScF-5XBDPnm9OTbkHnI0RmcgEwrJMVDO3WRUOdVrCj3wHIXOHK8W-7i0SWT_ulgWqa4AUYbmUBHLQ4ZO4p4VXViVwBSFaiM0RmHC1m-3KgrNhwrRFIHOp9LlH60n68AiP0BKSrB_Wtksmfog_8kw55lYIRxpOazURSACO_koWK1WWiOV6RZ_niIi8Ak0dC3iTAg1d9Wzafis7WIyA3eEC_hmPEja21s2KjKPPXPfXZmF0AiuAxVVLoPKWFbGjC2gjwQ3qJWvad9FH1ACklcMp6KhBmd0SanE9wAmAldLugUqoaOKhUZ8dVIFMyJ9AZsZ62mueTE4awZTeILW4BddqEJB-2sim7SAW4Q77NWxWWgMbOA_X2bEpqZdtx9a6r0_fVhdTC9XP1_u8_FkvjvL2s4iVO0lftyqQ_g6HFMHbHIGp8rUEXdT5YOgofYZVfSV3eFt6xHIa6sDWsQ-cLu249SffVTOPakh3USNLt10cDuI2l6VyXtqwwzUpML0ZqS4Ohh-D8oeW40xZfnhyEksX_e4TNdlA3CwwzCiKmphAPf5VFMzvtb4yKiatPVwLQNZxVWglPQd8QCvmyiSdNvGV4_D3GJZU8OdRz2LRerOiNQTykXnblrO5yOmsmsxSVSYHBWCrLCzx80H2YSyM9fNNo3007cm2De2x-vuk58Lpjfc28bErw0a1ISkwcDkILKbX27XAITVUP3f2P9dhW4uJJdr1rw9sps82VTeABMHzFmKEhlD4xL4BHursxIMhfBkW0nsfVtVSPZbWga9xbrnbNzAKaowFdEl0mqj9XoJDoE_4UpEcyFTPwjR0SwLOy_Xw3pGdjsffKGrwFu_yeNxQAd-99FepLwbE4xmb1hkxbw_9qFH7DwzdkrTWb3St_N_r1otVaKKEjAQ35E38yZ4DWkEnUFsqoJvzq3qmmtsguVjeNIiyfGuhgclolaVMNdZdhORixPBN0dtPA3R18679JpjgxRDWoQiJC3iTu16R4Y6fXY2bXVKbglVoaYCGze-Yi2oonFp9hMVzxzv7d-3NybX5j5U38KLgpX1bshmrsDWTFrcRMfHiRRNMPm6FX18q7XnkxPjO6vhX7RRb8SxJ3fXG_hPlawGQJDPGvlqJRp5-cPxBqtqFHal-4XgZQC4uNxoECcGAHp0n2lvKSzS5nvXtXnH5-iepbsAyKf-z00JF-kyXxI2HmCqVLSejNGBvX1VZ7RA7VS6Svw6aAd1dgrLy7CGQLO89-yW19Gznc8Czd1ju-5k5-sw362gCnqmeWT9xHg5Ufw9-MotqY02Uiyq_ZIaKZ3sk0msQR22VRLald55PpqNz6arOnjIlVoq1msGpVSAHqQUvUs-G6ImtFrBqym25V8ZtgNjxuQMXXCVp7lBTSEZ9yEXCBu4vKyzU_CHhnPA8aJw9KAS62wvkUIsXwmYgdMAvdbnwJpJKLYhnngcTOskUYa_Q1ty4L15Zk_DGB5JiPN7AbP1rPOW4_0HUJnn3SWGGkya9U7xLCiz4HkhiFGHlz78DXK6K9C6tCSIkxBq36tHjgkxk4y9vprjAt9EdMW2X-qjc-K7wudLyEGBfpp9Oc4Ow2RDu5ST_I7Z2EJOQnhQ3Av2dg9F1QM3EwDWCH_IHpG6QAWlYi5uPR_pGuEG2XwWCXlRmssR6vxcXoKsmGrw9n7yhUwcJjKUCOQOJleRGwXT4lT5U2NGZR5JG2_OUtYN2PfaeBsYWaLz9UuOY4bfPtseGdKGU2ujvmgJLWfIDigp_q65sf-DTInL5DYjwJ4rGtLRWuyPKhtQqET9z-lGN4oARdg1gMxwLnI-6ryY0cgPWRP3uOH-9gG6aPmkDSMmZnKwAOjGYNXDj5YXJLjtPXtO3BEw.pzgFdiUN0LHZtE496vN8W2iTSoHtkkOcqRyhhTVDn08	\N	\N	+HIiVN43GN5hMnrupgeXFNzMMkWVshgwjAX/KBbawag=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	e6ed6b9d4ce34f0a9362bb1d7ccc6949
3a1dbeda-1cee-e9b4-198a-74ce37aab16b	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-22 17:47:07	2025-11-22 17:52:07	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.pgbzLOP18YvmJGChJ9WjWh4evRv-qSLx4MDMqFaaYBWCosLFlrs_r1YHrAwM7Caa50kIkQZjaulOlcf0N4LPJ3shaml3gl87TACeIY20S_haiD_wMVW5lJd9NgrVspfbmdXoEDAlHkLCaBPy3ABOiqHkmZKjOE_O7xgjxpMuTEIRTSDNNVAQf9WUYQlfB6TPc5tw6umV9M2E2fbPC89IgWmrDuuMDrbhG7pkEaQKencqhHKavnkImTAvgsGSuAElC4umC83_DLFOjNJtGHzt-psBEVyGfEEOkAaEv5VevnUo0Vt-HXFlURww_XhXZ2vdg2zmK8tDRZA8Z_SZEn_OEQ.rwCLaFUJ3EH5cUA7wkB9Ow.dhvLnBZRxxSXRwFNuVLVYic8axnm9v7S41mU5d1KrAvnrO-eCc7ipX6zwrMoX7WxS__Ts41jt4AX8UNtlWXkrSfKhxAIQWQrte7NqwTcANqi3cuufx5Gj2E-0OhBV8nkSlGBDzXP3YQAXYznbyRg0MktjN2rdcJMuZEkE6MSNFBt3te5gxYr3Srcigx-dOTRkFqBXoP-IO0XWkyVb5SlX7Br0g5F7IGmlX_ldVdS-vKFmiXeSx-UBPtXp34OQFJ6Lk3pfLB6Tfnsj5rg7b6A1EboyPLFefRl-fg3bcGbJiYG0Lc06pe-QLuF-4vNPPftGsfvNeHvsTCuvx1YWuys4La13iixp3qqRD3llIS_KOLCPgnJ5WX0R031cDkFuklPtE8l7tbz8zBFuRyWpmilfeePmcxKh8t4K3O_rxK-zQ7l_NZ1Z-FmVoCaG2GPt2uCbAqbHPoKhC2Az3QFo7YrBT5iwTOQisDB_t1E13aEgGjgrBHYG8BMsnY7ascgHv4COu02VnKaXwGYClqpR-uOwz_Fi7asK6U-N2T4wI_niKGJp6oUobajVBL6wu5mfRPHNtQ_xTssj8VLi4RpQDKH6JD9Q_NWk5D7Rx5bSVxVJ8dtwbyYFWs3MtYPw54yQD4NV1s-lHkcMrKPWVVETzCZnWTfYRhypIvAYAQ73tOnNc_7zUkCVKbri2q9qgzh07dByK0sl73Z8rgXA5F3jBVorAIadIEhy7fc5G-ufvO8V9S3-dgsMqaC1Cx4zt3HdYOgpumhxWyIqFOKCY6_Z4JVwgWrbJC5Pu13QJCOqjVDE2VRZWEKNsZbvpRoMw67lLWRc8egPZ_3r_Uzg5YO4lanHbDiFTm0CYR08xIqtNlOivwTaweUtXrN7x391-MMSgRgGDacINyKTCZSGzycgZJNf7MCzfL8uvxgbgNOUqwYnun2e0ELJay9SuGO3m1kQteDVgNPkR_Oy3mKb6f5uwRpZie9lsm4JAbrcvlrJCkH--wTJtXNzfRjJdA_8ttq7-cUA52Rx4vnWOxsIiBsc8qV7cGQO5PiZ6KLy4cSihjhuj_fk3RAe1kB5bHhkBWtGKS5lF3VYw1LJ2eyne-F0NI91g33RWMlf997IzJK8Sw9bDaNpQq9YXHSbAsE-Rlxf8qQCPF2LKc1FLRKI7Ed_AYKhPwo4WACRP0xThAdGVo7iVSzoBOI2153aPKVfa-Iw6gZ84AGnhvz4Rmnh1URyBgmTSsC6VRgbIIw2VpR2apALV-YI3WLlNwYm3UVk-i4N4t0aM-i5N8WLtJUzk1MLjbkERtIBCpxhv1rU4BQEN_N9cbI_MseWSwdyFtYtkdj1S-lwkBVJWB6ChB97wbBb9q4auFaYMhd6bHu8V6ELt3ButrSMjXGEF0j1tjcO3uGZ4aZXd_QAYzm3Wl7AyH10J-H2iO0Av5csUEFZPCntjbgocGqUsI5GfClsXdzRqZDyup9NhBgVUC13iyA3SuGmEKi2DsppYdqz5ovGlHXaIfUX1SxZS-6vYo3PyPeMoUaImWuweFcqMOgdU2xOqp3bBaW3WWn0FrC8ElEE23W4xLRnXNwLPjGwsqM3X1me-DJ7Twiucrl79NM98tpqfFXk-yD2htEcmkZkll7sB-_I_Nsviz3YvC7n0AjOlj0mdj3OyWsytEb2BstMdu-W7mKjkTCCtsLZOywwQGogcf-TNlAaeOzY6NzquFHqqnXRE1Ar8Y6b1llufj85M9t20sb8y_4IXPVI_IqR_Vi7OR1VK0RR-7fQAoCG5Abv-Z0e79DgP7y-6Z-DfjxiVBdNZzTK52pPARNwPVvJDLpYkmpISx1RdwfnD7nkBRvBTehIGIcM3pnqHkVMsJEjKRAaJTDrvVH5TkOTj4bV4RNaluXQQJaHsideDtf1zLvCVFJIMLLVKlYAIj6XOM6a_VLhZ9XJLQ4uLkwQXw_ctCX-x910Qvqlg1L7gjegzoVWPCqTt0tfNYFV3lEhmEbJvoinRWk62yUY7pvApC4rtlsAO7uSO5rpL4q9cFPvWR_ar9afObHitZ70LVaDyIHTQuqvWzgS31dApg4cKwocE0iuEag0jWCUDJfOfWezXogKEu25sHXWqrUh3WncDl90KdtepQIDHBQkqOAoClCtqJxOwwPnC0XAxEs_51uuyINHpXSYDuF4G3s9Y79vKQEDBleqv27Pj29OdT9qUlS0VSlfLC5Og-KBRPDMP7-UVMB4GNHVM46FqZQ9ir4gzIbbEDWiYHQVB4cld80V3-oifvBYWbbyt5JJy596W9AiYqpjQF3rADboIZcKOnhtwGkDYmCpBUW39hUiC7l0HV3s4IWaFVBCafjR6g5wuDeVz4QJjOu376EjZcHwVyUCyPIFVtSWzhXPKr_gwMzH_yd7kcqs0WZbMYPbhiNfMAVk85IGaL4PMn_vh_eKW4Soy86LkoIJ5tDbbDfzA.6e13R2DLeiDpXDugxmlifGF1ZSB7IENrxT2AFjp2Fo4	\N	\N	j4lACut5hyZwHxUlaACiZqDHRu+VAtr4xVYDmOGKD6k=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	a0078197b42548b6b1f9d228e1bf1d4b
3a1dbeda-9b93-4c8b-2d7e-4ec0135fd3d1	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-22 17:47:40	2025-11-22 17:52:40	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.xVfZQbRe4FgSRsXcB0h-dYSd09RSEa9bA8rzSLcPuJ2zXZpCA97Up9J1xrf25RpO8I0eAnyc_T3WMfxfTypSHURgqtCPGAwTgYPr0ewiyhxQWjCJ4zXRAwk7_f6jnK96uzIELWtT9kuLUTl3jMANdN6XR-_t_68PPcqnGNOLwA0aCOywz-qOSKexuV06170f6-RA6OfRAVWcKiSR6gg0-sa4LXOb7FuVOrrX_aosPmg7lItgAK2OhlC7AQGYETi9sMsaCn9CHni0w2TcHiSQK1kc7QQ7lkroZQuVbGGZZUxbtqQmFFRSUiReGtibO5AER_FJ0nv_im8SZrnTKEUBSQ.GM0ukYmeJzkAL2YKBpDVag.oQE0gc1iw9kiMHlVdHdKMlFOJYT07umHJEDl5OCXDKoFYCfpvp1d7qSiiX2vJZKRbRQHE4lpqbVMSHbavkQKyx2r7gjEP-Vja0UTZPrUqluVF8xqygk59S8odcXnIUlr32-vAS1VMomG55EAFD4XT5oLMlAryf1KIAmfZ5vROu5u3tbZ3zgLbq8lbUqfOM-94JL66CLEFXSqOSyI7OjN24Hw1LsDoHQIMU-2tXbVsBPvQPnnuhggSXEH0jaNbUzqji4z519yrzY0vgo8yQHds9OtMKZxRz77I7rlqXYY4F92GcdVN3BY2zXmKLKcRR6hiLoPpPQcq-ZIJkgpKnalZBA6OCDAWA7A1Oz2c9HnRFOqCnzLqx_fs48kZo37QNayZpUxf48LvTotrYdHK8aOlanKokA9nGIDrPP5_wWnZ__3Af6c7Q4e4afGVs_DzZWC2xgGSGOe4FOKUfle92bYlBqxVwiRaTc5lusxiOAYSEvIQrtIOH_1OC_dilEbkp-RvT7Y5dMr36grzcEwciO3wLWGXoGVJM0X-0FpCfcNsUqP4CVz2ltKyR7yeum1i-JjS0bS8uQPks0bPaIpb9nsuQIvhHblHHzFIlCz2R8m5b9J2pwNIX1xOeL8i8YhPJ_NkAnfxBUvrS2zXW4GkJn2DhQQd1EcaI_Lth6JWIDVyXZrQd_89TbmQmzfRCMPXKQsjleIChsMzd3XxgdEvZwjplRdihjz16o_vgZ4npvxGyZ4rcvixFFYlrbGIsw7_Adkaj-9-LxvZn9F9EgsUsM4fuANq1ew_tA6PT6r6dGjp8rHpNGrgNuRZAb0L7ms7bxz11-04U8FITVNeiaxGD6R2lhysimeMDlfsruf1uHydTvKbTxg43yibe6CueFir-D6CDyoJegi5wHzRJ_9ZWPzu4qLK5ixdZzZMuQGP7hY8oZPVy1RyOlQxlv_1e3uSQyUtqo_rnlZvVxlQgbkGnmX90KHi6NIKwO5xN_JgIQ9SuB8FxOZhrA7MN3crimM9V_xXHt_72IC1PO-QSvR0R_vka0DS7S86Ldwq79atE3XB1KENI677qZ20ziVoE8WHVAFOJ892bGEPJRDCr3TEjpOBj7ybE0TgI-bQboVAhTIKNeTpYvk_f3Ib72ZSxDYmr09J7zwJOIWN7wk6Hn03SxozRIWAwqLa6NHdBGwzGcbk-2ZrPruApDaO-FaILPr5IdbJAhIz9PDSWMOAJvTO_eIRMVJd49DvipnJNgANsEY98CVTSukS81EM7fCy2r_ehA0-U8s4UCAZ4UfP-0eMTamG9R7BRXhoIAjho7Rlz-TfnP9dNEyNWA_4unwJ_xHKaqBU-P2CYNWR7q9bpS7TswpDTq2u8k_Eo9ue0CcqNZkf4fhGNm8YhyVPlG53BMjw6YL_m8wVcRO5GQZ-oQwgAhQ7ng8QGsZqafegJft4rRL80fAAqxyzWzYwDxCVI1R34RVhaj9bUEZpwISnsilb1k6mZzEoGXOvBQXcCpW8KHardgjUnriaQTXHA8asZ7aalD5vgYHQ6VZNwup9cXePRbIJkMoMAVAJYQP_UZHED7CeVd6MSipMEbZ9tmu3gY7MKZDXRc9nv23FnzvvAH5855fI5IUQlgJDUDrtCMvK4vlAekACxGB442qksYXWlDagZ1B1K0Idy_cX57YPTKe69CEc9gE8G0FRUJ2nUiYXoTMqSUEoKFXY0C3OD2iLVhSXmeyecwlHSjF8JlFZAPt7YuhwLLH66k3R-oyOFC9oKgYSOz0Lb47aQ9l2pfTqpDm5SZ4AJ4vponAAqJDPhKBnM6wUVfY0M0FQB5-duo2Vg0JZLx4DIzAC17mQFOXyr9OVe8M7Hvco6xXBFEjJY8OwmYvM9amNOLfS2W9yXPbRPGS981soiZLDVFTpURgiPX_WL_RgShi17riC7S9YAa3Mq3OjH7XBcZF5QC82UVEQSOwVLBIudUzhwqShZ2S8551i4UgIk-V6dNOM5klAe8euXoOwrt9Nzf0Agv73_4Pqn0FKk6f2mDJ7QjC8v4urr7Mw5nigUy2_YErN0D10Y2XxwI0nPa2bmi8EUwF9_7SnuOca_q9kWHyqI6MlOO8z8LPB1HE5vTB9CZoPhYLegFVXnX72O6PKIgWOQWJmRSgiRgIFUY1shA3CB9TV08hNo7rcZJeG5K2Eft8VLKL8pKi6j56HlUm7DHNt4wQodMoJgzpXSuMcwHz8mkNFX77fsot_d1JD8kiWWlueUaFsdK4gobtsG75wadMS60CzqYaKUoCT--mvvGXx7k91o1wu3moQ0zxR-JVc-WZi906qrHRszrKQn0bOYrEleqIXenwrSYIsSJWiQnoTfJ4hRbNevjhPPfcCp9zlz5eph-u2VSqq71nv8iD3ClNxNY2UD4pH479nqUejLRGyA02duSrh7o-9HDs0koS1P5NBk33poYIK1QIHA.R-cg9zZneRJKTax109ENY3_8iz2J8vWwnJvw5FPyZwA	\N	\N	rmYkv5AUDxYS9YhPBDhachK2ok1Rj7OzMtcyAoQWMoQ=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	60e530dd1b6c42b39f9c75b8b00b0817
3a1dbedf-912a-cbda-9875-0d0ad28bda22	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-22 17:53:05	2025-11-22 17:58:05	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.X38KVH9Ul7_8c4N8dMiYAs_602nUozv0oj5yGuEFWoqsDqbTGNgqclGKuQqBX-qA72ZX6V4_3fXLZGXR4wBTo5gcTfT5UXedc9xU9KNeTeLtvr2cx1OifBE0CvEYmxgV2FxxoRzCpNieqze_Jai1vkPnspmjEhBZ8mqWE9AJ-9D4mJPRESRYOIO0aJez_PiJisluO_Sau-YGUnWPUz8EonZESrJaE07hFoUCZKDeqC2gGpXunzNLQC_ykDUoS5cel8-fguuVjxfxsyGJzWua_52Fce1hH3FVAjj1nwF1Ev0Lp5Vy55dIkxHbenxcVQJtf5yO8kz2CzDvozUIlBcclw.wQLrG2K_Or48PyH1gwfxyg.RJ6UoPBLQAdKt5QQANJdku7LbA9BJJ1dGaFIbfBDqkJ2kKABDMn3Ms88xgijCv4BT_MMZDAw7c9ViUWY01owKogdE6aELvf7aHbEDq9DXZHGFc1xmtt3jmjBKjuJOciV1kJy9AAThX_-gQXOztidRbAVLsjv2CTD1Zqr5aDipNokv41ng5DF1w1sx80T5grrgNudgEFwwbOn_I-xRUhxqpjoWhsYNkyoRugw99A6LMKWUHQhhcs2gjn6u4TUtw-YlFWUp8tWnLRjS9_xKJ22wiuWcyTeVXYItzgueH2rnEpB320TQBp5Y5dER8UQhSb_2fFp2URXUk3W8HSzkev1lH7hmyAEF_zfBACG421CSGKcQZi6Q1WhJjLdGnMxurXMhW3FaxBlQXOSQGRDZ6Lv_gYeb5_-jVjp57OWoADtyUm4ztS1EjxxqvS_9Lyo7H2GeMXt1myeCE4mjZeN6zSHqLEShM_njE550rkXhAzgEDr8VgzU3dUKPC0oxznb17HK4JJ6jG2quvTk2Q4IVFSm-3POBv5eyfEOGdYcJVrhhd914jyQc9G4P7JMkF_F28XDHqWe00lFP4qkO6HbNJXEc2YsgmJI_P9WRkFIGVLuFAqOqbPrLS22Awc85onXJswf3xHlmC1rQ1HfQl_BKK4G9fBn9mMaCzSrmowgdqV5R9PGVzDYiO-RbD-_C87V4EcfaD4Cf2TU-JVSCzpB7DRA4wrF7qelT_fb10JI3I8iUpFbNyl-xV0ZpPJGulGFHRyD1Sew10PXDNKFuIyRqGEKS0PBTEOkgcNgLwpTsLBnNzGnyP1HtuOa4Jy9tf6cVdZPC89O4fpvRj4qG9Et5fFjYAB-JtJlZ-8Mhae5O5ryxot3McUCvKv38Jpv_Alf7R-pSglLEjGcGqjjgm6qBm8DlMdNahNdDdN0k4tSq2lwNbrk8e6RPZe0g-aE2__NaMPzuu-LjK2jw927nE_paLbayIvYrTGoyD_PaLRaYseDebT2HFpeSVNY_w2tbuqDFHHw6fJWPQ6wwEwyBOV4B154_0dmj286PUi7Dy77pdpySglX6zT9t6BXrLQM_pt9GpAGqvwWEKGwcFKq7Y_WXtOJ41dvd4fmLDkFGwqy72KIfUyh1M38qEFpNefGLB-wWVzrwo9tiPGXGxXYgsTD6s0GEGDL_csb5AZ3pD_BCccmstFtb_L_sRad8eB4V6uy04K9dY3984FNtCWbuk0GjKWcXHtO3OGRa2pz80i1P0glYmxR8i3NXMSHke7t5ze1En2JC0cI9tz3lOW9OtPVCZA6magA3PEsTiqy0bwfySZ8XALhT94-GVjzLn3tDzX6jjpfPyUssbW_1095Br5ZXHMNCiRJAQsf9Bvt-muRN51t1K1Bi4lLxPcs32Z6KOqJSVv4UVUZZziNV-VZzQgkcuVNO-vXZKsh5rSKwdGzSiYroJBBF68ub3GfM1jmOnuTn8om3Iq8akkyGPQhDFV9mvQPl7_JtH3gUkCe8HuIuQP9XiDlNI__6n0lgWrPnw9hD8Fah_Fh5C1AO0vKZ6OJXPWYXhOiP45_pvX12yO3jeFqPmD5R4J7eimSENoFxfwPVlyQqGLdVpggifR5zcQQsaF692u7eu5toGM7FKWcSD25LSsBc2foGL1Ri2peFM17CbkA5wiitotNQDn8fIP2xG1mPwej_DIeoZto748dT8ZRKr7bQFg-pT5Oa8Fq_P-s16tRQSxrreufYNANPSNgd9BsOEywll_-N0QCrp0FaNTSuwxU3EU-LpO93NIunslelrJm5ZKxnrPAbv3BZNvpkNmbnK-cEM6FLjmU9gvxPGK2GxRMjlI_eE7cRuzFWq-e_YYfhC3W8vvRKc1DXKx0VSIOzAOkHDe7B6kpFssr-nzYZMGAZUi9MKrk5FHcDaDWeBsZF6Xr-0QFfVRjEfdCxnMifOa41h6YA4ryAiulaWj0b2BeMYLWGfRA2Fc6LfLAZsSjdI-PG0N1MyxbQTgLW7fDlPePSF378_rUt06wCpmgi2hf9NTMoCKVMK_AWPyBCMw-rU-MDV96DLJHri8DQbKiQYsQq-2-1MU57d5seckzve_LOxAescKVslhEHdIhGBybH8Aq6Z9AxiFYIbngueuRUk8RHibIOaPuZAn0eyox0dAtVZkaNyXgpQadeKnMcv71DSUatEzc3ZpijMgNbnavBrCJrCKVqGo5s6kWl9-MYkhzuCyl1gxV8MRLG3OqOVf6HbW8PGRLrInWWrq7P2m5epgwl9bE6cQEHBaeekCutZCyA2Z-Mi-tDsp4EvwdQcYSynntZy_7nPBGyYWZggIsfq0g19IGq0Bjsfq9efxvxnSbfeJn_acd5xdlcbcmIIjrbg7sSxToxrtCq8a3bjMoH39ed8fegywS5_21dPw9ou3fB4BUrNoN55g76DE9Dy_D5Rle9jxwfkVCeb1UWNOLXw.zdNaLJiIdVmYeiOkp-2BW-tx8u-tEYQFu4zgSG7NCTo	\N	\N	y4BbJCQonNi0X+TQydD0BLTOwLGO9h8IJLZksp8Nkew=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	d764e1ace62645e5a5b6ff168689f927
3a1dbee1-dba3-b346-a347-b12663ff7213	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-22 17:55:35	2025-11-22 18:00:35	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.JSqQoe4Jft8vgXc_Hz_QgNbz0xN07mCPzd-muSEfuOB2npR6OAPCxnbKcHgOboe81WJEvhDfjT37Ynn7Tn5LlfGBEAAopkCf_I--qKo8trmdlw_7CeQPgnCn70lWzYOkMmmaYDf_uBH-YtlZwNzlNJGyScpdA8Ml2RBwswUiBlD6sqk2KG52Ju5aaTHyP20KPE750BCM-4N667gsz6h-k646tW_HiwP10K_qL0IDhdmZVy3kfBp2imrWG9zCTeUSbc8DhSP6UdrkEsP5muqIc35AwRmOTH55zXDDDwbANxaAFIBtRG9qSF0NAKl8qelKIYCFr6bFw05TvuM1GBF1OA.OrvN16fVS8TJ480BX_i70g.LVYl32DdzzD4dYJv4POHRTR7KL2eKXpm4behjovPu8WOOidwmYeo31vfUAvG_IZ8lx99r_f5pRcFVe9eXRcVGAoSqHQgxLsTOmOA2fcSt7AM3S4kW4fkdewpl61nKC62MfYcyvuXX1hHgrQAvxCCbZnih-CMOP7yNkKPV1jcIaLDiSYRC7yUoGqvKU6W5V1IsnmV6OF_8N6wk6lMTwaqS8BYanEZ6hcOsThORuXVo8LXGgOl8Lf1fNu2kR-MU2PYeNwMFzfG2mnD_G3OlupN_ynyGO58S8S9yqY3UgEkRUyJ1Xw4yoTx4OJdpBTGk_k-dBE5fb-pddaYueJJASZvpS5PWuwOrkttVxzELyYJL4Lr06S6W-_kGBVdQvn0D2rRuicRP_pMuiu1MOaqmDlO9gnUpmX5-xRncWiwMuYuQA6ji4E9U2WCwybYO16FzzqNEznmXoaErosI7I5MW-FpTFXaufDhpbuxHjgp5VXKA1qJorAhvmCtY387hfzqM_Sb63EQsI4xQn1W5TI6dpHPw62ziFCk5LjvVA4LHDd_QAZyMLz_tCcRc3FN_kgXDX8C2OCjtIKHbD-QxWrj0f2RmbGMYu4eLrAbQ_9KmvID18DqEtHTaNHSRVJKuwNE-_pV4V_Z82qDDaJuXLE2DOVw1rEUY_Eb0f3S3spvkYbRNyqZoQO8ryIbEi_ixEgSFLcO_O1dtHr8l_WHwTNxYhsbfp9RYf0_xWadj0h-Rbkl8fiM5DZZ9hJlqjLmaJ1GYM7Uc2gTSNaFQ0JvNAo-aRNYKY-5Y1C9_eJrys991hqbxyyeou72xgbTGATdNjvDf_fKTizXBpcSe5V0OVTnhOYQoonNHq2VwszuLpT2FedYTsG0k0Jn40xJrPjq0Oyl79_dEpifa4A-sOOa0dgvvT8typ5pkHNVN_YB5JdJAM3AXo0HWxPHfdT_3G7RXyyzY2c0mXZwebElXLlAT17jEpn2C6sC0f_1NqtRonxDbntrBeuZlMliBYx-PKQnoWWl2pbvKMkN4PvKqL1_fFWcb5WwJdutWfROIy1vr1LWxYYBg3HwUm5C-RiwDw8JkqLElp9DX4etapjR_qExy5OiXDvWAZXmbw9HSWXxZjQwalcVlHFcgo3vgCTpXGCDw7cQz88pf8YJePbztX3xZERK8gCey6cN-DvurqTd_n7uiMWoVj6ieYg9nXpb5F0-ZIp_gWS5NK0GQQgOSK1vmRUVq6y7ihkSlZ0ahHPGH0XTRsKYslCC2yPwD4RbTBkL8fhgJMjYky27PwaatQHzxocLhK1xvpoy_iDEgHPOYmYUWZPjafP6b_AD-UXOBAptxm-vGcN1MPBqCEsrs_mA77vey1Rea5KxlII4K5OA9Grwf1bY74DoOqVffRuXdsFGxeUMImOKjP1ImG87UpyG3MHiB5AC9Kv0mAU-JxLsJODv7BZb8CXvI4EvAMfhuMq-rwvDyNMlcGZaQ3MZj0o7jVKTgMSWEDomVe_QJpdbpc0CAJ7mwlxoOvHXjdz5UPYzHLmPkcWnERw2RYllqcsiCaXCqY2CGE4qfKgU4sJjIUvVNXJtf5-xCAKbD9NMM8D0tXIwK1fJdzjGVnTflZRlSIdvtaIhKI6YD5L6dpQQubiriWY7aBfRX-DEZK9Tw0Bwzz-I3FJVBD58kxnxCqXx-ZdFsZ7IHsrb9Qq07w4AE4M8Mcbx5HnvdAqW23sALOZ33oQNQFb1ziDR6l5ToHQEEW5UUJDKfg0ns2bNQJE8-kq68Mx_ZIF2QhUP-XePG3m2I88PB9hIptehezKOhF2ihBgI1uXM200bSaL6aaK5Gb3hB_8__MxR8dxQ4WE2Um7_IKAg0feWSij1-wYl11Cwu1_xok1FitekV0Tb2r0CSEndV8NJgmIOxNCEZqmRqKyz988ggUYvMLIs9FYd9aVGXsC1XF49pXhJjDVEgeibQPSZNcDR4sCXw9Yt0tSD2dbpF8gSIESPTP265njUDe1t_bP3AdGmgDQhaEJvSP9fX2LKBuOrVXlaCiAb4XkuSX1LIKOlJnUKcozfO3f7pYRdoFmyHBy-WpmNlDrF8tDLPkiobCFCLn960w-DeW-DrbcNYkARb1ZnUTya-NnQd0ICSDGaNw78EsqE503auybLHBIs2-fysrfozDgSL-0VRJFixdyvalB1IABEgQeB4Az8okOYpBi5BOW-GUXJOwx7owJy9EpzflSV52VOAn-Bklr0tFz2qCZpvx9CW8ga0oIsVlbtisdo3zOYmpOItsnoO877ubtHH_IkKAtEqoixZ6ajg4J33qeER3s2zhFZmP8g0JBxfWoo9X6_coV7ZtubFBtWZ8qKaDj9DE-GcwvyH7EG1kZviwV7tdnc06kdJFrMB5IWsow-aoOs-aLj5D05yXFw7uIAXIU7Z44EoOw-Zm0j-HlqjmL11Ps9Fzn3VPg6jSZvE5XtfQ.4Cs1XDKxeI5mClkTNOTvqiyc0yqI2pNJWZaNtL-HmXo	\N	\N	7Kjn2KsNFZZwldvC+TIWvGC+aY9ww55Ap1mA8BlhyPc=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	3128af2bd9834788b491ca9db422474e
3a1dbeeb-fe1c-45d7-6d2f-b9ee1cbb992b	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-22 18:06:39	2025-11-22 18:11:39	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.EiZKgeYc3aC1xbSd9xOkqckGqImQ0RwA8eUiR3-hFkWgvGdSISiRdud_WAwrxeHIal0Wk_gHtBF5SQthiFhqFwpI9iEAShAErJyt1ZqAgNc3oLy_aRDGNMIhryhV0h8paePh9nzDu8PkbzvJEJR-ppBWlQS1yO-dcoRLwg89SUH2u3OwyQP3Lkgzi5kmo_O1aAtpmr0bkNKno8lDZnIL8b-w0854VaNydxcfmFeXC5NP_H5fOjW3YUSd1psaYeK0Cuv0KFBRGDSri3pt3UWojOTHLMoBX0OZBZVRoVAzPoHzE1SUNBRtqx2HQ4NK7GFV87y43uKif_CyzqcOmZPtkw.MFPEmZQI0OmCOf1cVZMGVw.YVIG8GOgMKH7w5C3Yut0YGMonoelX9Fhpk9but280kcsgv2eAQRvoEnjb8JFIp898GWT1k0jZMggk9ZhqQeI0bLGB5YBSB_ct4SN0CHXPnejn1AdnLRI4UaS0YHCd2OvmVAV2sQ77XBaOBZLWv6WbM-LyoRCVgZuMbQjPWQqOah_kG6Vjhyqd4-rDI2B8_zsC4J1E52GwUNlhMVTJsmjM87izTJPibQo0NUU-cZ81WyTt_1JwN3jbUL0zy_26Vg6I_3RicDDaapTNBVJkY-7UeJ0y2iKqe7p1wOJXBN687dkV0IkuqMzRVpKhoqOaUd4Cm9hI1kTSXxrKz21hc7C4hXXGQV6KH4G37eh67qM4Jx_LpM7UAsUgbtrKgdfmoWKHL_98_Eh4olvKQmgoJnlcjOQkEsbqZGjbCjifgwc_vnnRv1KIoTgCe3Z4yN6K5lPCgu65fKxtUf5cESGBjW76aThmMyuoPBuSfkvKgn7zcJ7yysC0l2g6ub0eofvfHZAwIqIKlB9GrxC9F4K-fJxh-kVB5WywtHePUCmvR95sP5LcBJYX5xzLDpn1dMtNPjkJmRA1UcnAJqCThrp_tRPRbVUt51u_MHLK59UVWf8_g0DdObHDuBzD51PQh0hCQEyi5plRgU2jlKWbvv7dDN70I3JF2C1i3XEsKGiA-BcZjaYMYnlaNy3oNF0JbMSqw87G-oIYBX2o9WXS2ikOjN_Ocp2bjUsj3l97R-vIDTAS6xNYJP6o9VZ8ItyLHJYFvHIUZ9KVTE2Yy7el0C9TB2l1G9Wrfo3eNT8sNMPtZeKcHIjM5q-WD8BlmPR1EZ9Og-uN7IbaWZV4P-wGjEgu_FaZsUfk4le0YjESQSVkUizSKNX_WDnek5Ozo1ktIFxS_f6b4hgxI9iSXHKRDfYkJufrUJ-DyLcT4l0_CIBP4xxHUiowfViRsFlX01SUSbHDIe9RYvfAtziMVnz4gG6QY_eAg5aSdHJSUHbcr-lV112aBln7VUsvRltCIVPs6W-1QF3F9SSX4IlgCQDear1ISaK4GpNcp97yH84D2NC7bBb9tawRAccGIn6pLI9FngC6cAsFA034ndWsW5ofrVCZ9lvwGINYV6u0dKPW3u9pJCxUHWfRpY1nBHBY05lhVnXZU6StguXwswaWJoZYAWeFX7KsKhCrUKz6lPDNa-ADg28VclV8l5jhSyUbh3fvB55yG0lgkKdmO4wNGhTVc55M1qec6Uzv4cc2xr5fUBh8Knc4wGTIxlLpAzeaIp28jjCGmdSi_0dzccf2uCmWy258RS79-egQ2AGGIsRdM_4iPNgJkrxqany4Zu7rewSwxYgdm_7m9T40PtpIElOM94qf1XIjEixg8z0sXaPAUjqd8cdAge5SiDAbtQn7TLOFn4ofh75b73CJA5xmjhzpDmbRF9fQWsnqGoOZbLwFj23nivthSYVQViAbKqrpLeGAY7BmQ8xCm3swOeT53NNNnjJzh--9H423JzR47hUFmXU4OKZq40xBZMVtb5S85ruJvbB0cs2Adzpwobq16Ifc8KmL7PnTXW3sh0SgbpTPZeapBpEGr71I1GQ_NsiNt43Lajl7AQ0oK4iSRaZG7VrVtoO1Vh1sOXcSjXVypKJUII5vldaWgYcMz04WJrEsKcwK-YgnleW0KJmY8AsqUtwv6bRov6__X-WC-o0-CAkFRXSIJ1xI-VgOm_mWqAFpMToOmWmkTKJjTROmBZyb8G6mGTdtN_b4ZRQmOoQbkQEvEAAhRw_xt84BfvPJPxs-ndqqMrPAXzFioWQLrEEdmwiipQy8EebpGec9sAPTXpqr5dBPWRbAc2AG_2QHx9hfHeBilaZTtRx2xdffRGrTitcdm5qyYAUnlLNYPaHQT3M04l0WRzGP6h6uIWxW8gZHr184Jkb9krJz7JtoHGS2NvI-X5sZ_o6ksqH8tFTvw1Y_FwDkjr1I6WRmaUNGTC0Rpq48GzGp0XzzmoR5JBW-R2coxsA4AJxwE3Q5hEK_S75540YkD0SRxX6tENiWvfl-PWmeXr-8m-1htqxsGGzksq5Lf9MLVHAzHIa081BKxH5RiIO5GFqDeT9NrL6tCR7im_kv5t6ACcAu3P0O2GK2IJzBwdhOdRGocScbOvqw-YwFnaWsQ0AbPUT02rF8AtpqeX8-HhGKegcGsCe_PE4SP_YcLju89KTZhKr0pYSNB77zqOsVlsUm4rdJX0IabbWa5kHozGLgvhE8P37ASm5NbPwFg6P3AWPyBFgVFWvOrlNwg9oKVyzPY78AyJMlGnWbFPr_BvDr2ST0Jox5kmdIEcgablvwT_chWv8-pywbAHbM-uyuPQe9ZnByBdikVIpOmOlcmIM21rh7iwHjtVxCAvqwcnmgDfWT_5d0E1vl_ac6I_UOF7l2Sx2BPdpcKhI1BjPZ4cu3dHdIwT8tF7jZzam4JbHgTRZgw.pb4azY5MabWat0hWDf7VwyD8AXh5BxvDfdVq9CwO_Qw	\N	\N	itgSxHQTnOA+4kAgmGwbGvYJjIaRElk+MY6YO6DdHqQ=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	7c7c2eb6632541adae4ae8839f074389
3a1dbeec-c60f-6718-e432-10b356cae96b	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-22 18:07:30	2025-11-22 18:12:30	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.0FLOhaUakhBONCvjwjXpcLSRsmXUMy9CGxMTGxEtmR5QVO78miGIXYwopsjmRhMKgN17KKWlYRjDs3FtIM6yqlqyllDcTnaHncNCdz7T59XOiRH_Mu9OzCkC3AWO1Hf5be69KnR0XEgbBltCSJ3zKDZGfvrn9cO72hCirRMZPz4IKr_HMIscaRH0nP3zb6spCFP3SHokYK2F_SHCjzXltWX3O2JfN66N1bwK5iUvKlNK3R0eTRLoLBCBnLkYoaF-RgG5d_mkb1O06ox4RSc-Lx62zUpUZY-x4LsYYoMRQTHqX8HdbDTaKwDnyM5AD_bhvQpAgz59vmzE5eJMwuw66w.odk5M-QV-ULH-vc2mw89Cw.afFvg1_0tcg3jmOh0D6_gEu3x8HDWclO382viX5Bxf_wbj2m_2t7MxM71h7oHg8VF0_DqHNZ1Qnj5AUifoqRfBtnQUM2IO6lO29v13RwiQQA2XwzPPDuwAJcdtMkGsjwPyQNMvGweQ06k7ye3IBmCCbM0yxux42yhaE59m8kGxRmwCgxJNNneWNjy-E3oWgYQGeTQi7z-PLWLIiKmqX9hJsTWVh8z8WPNzFnH0P9q9qGPlVwelLQpQKpO6b3HdjsMfJgX6exxfFhAgjaupCFERkBeK1nVKBDviSPoD-u68FkGzK6mbOelW_bkhw-L6VdEph2sh8by9iEcC8yG9pSsEPIS6iZDGrQ3AWPcrxkE_89YhpIplz5FU66PNIzFBf9ZFhSEbeoNLK2GCrutsNT44YMZRHLkM5vNSnRWIiXkVjZ3JtmUMr5jpK1ZDOWEacRNwrHDoYAeh6d20SyDKyPjTIPSsKaRLa810dM-n-KVi-0MbDiFryWASld0CesmasNZ0wnI8JX010_rQ81jcyUADnz5dPXCoUpvUx75QuBSH_zBf-EkFUIRvjWGpGBOpOtgTndnANGQRk10pX0IlqaaMILsPYXzdv5C4eRJbId1QOL2h-80lIDZotxQpANn9tigIwX8C7e4wYQ8XfXKM4CQDzpcT320Ykfg9Efhg39jMKUfVFW7INE5aua69ppl_DNhjzJt9JLB1AHzcD8VfMlExxyQNQuAgNqc9ThmEE5BUfs7X3U5QW20gyOcoum7l-80-jJYk7fHqv2FpemjdM4NaGM8SfjufBAMg7cn9VY66lFgm-x1t3x0NYkyyXkZ8ZHli-3OM1xFXrjynk3FcW1aDtJA_xefI5gHr6wE81Q66Eko7_j3g3B-eOhng9bdHXyhXmxsFSLOWRrts2C9lARYRooL9_H6rIPtF7SLhZWqVL-QScYdhCwrN15PUc7BSTnk9QuUsnkyg0TKXvcAAl5hFdu-9moV3TKFRaByeaoEqe8gOXXZkyavJ21jPzNGAmyuqd02YKlkcc128-0bN2EgWmYg4_lAeWJ7aKF10-lyr9dlDwZlug75F49EkJR1fR8VKir8OQFHYO367RVTJIHVBN6DXFYbxswdcBJwMUeYAUpJN1SNhCvH_xdqCHHEKUSWzXS_uYhdy7c6qTWB3IDRs9dgvR24lJbNrsZeyFqA8vDOPrmiJ8CNdzDgVHQdGZBRBTrfysfUYS4OOsWtyh9G47wf0onnM0ZxU-M61vyGqAn7YO5HtJqVTU_quj8h2iD-xRoxeudLSA_Ghn-VvFZHLgfSV2gLMcV_jfeJ8nZC9prp9lIv7srRIKY6VILKobxv28joDlvxK-DRzAH_fbuvGCnzFgzIprNRIZ7p0ExGUWTblYefWF27INA3eWwjTeCuwGSAfn34d13ZyF3BQ5nRCJcsAyREKg4pKQtwN40HUkvQ3ipgKuFP12KftJLArcWJkzZY6orroG3q7czoRK64d8b13vFaRU3u4GahLACuY_kzF6i4fEM0AU_O3IxyZiTN098i6AdxrWPx9Zm8s1e3-lgmzSEO_l7lwApu2AM4xn45LLj2lya0pVLuJvmEuP5xTqIGoNizykYkrfGjiB8SmdI-Tnp41FDnG4GCfqz7A693rzLWZQKOEeBxPXauyppUa5hR2Na1KgTFyMh_ei5uMgun15G19dsLlnFEdVp3HgwJIviLEA9_ZPxel22vWgKtPiC8U3q1h384bbOFyIal7yv1NX-koI2gP6tHAshOM3Tg4ZyxcyeopZjTrED5hWZsDznqPJtLhTQKB24x9diiJkZkW6teGLKxvIkFDqOu7uU3SAdViFQKn0X1BAemZgXorRQflYbTWFhqNo0-eAocbm33m2EkFOWK-TXlsnNRx3fXW8_Y1FyTEL_rExlHvZCqWRILri72BmmekERTKoSY0JPOM7QqBmHcL-bkDjdymjI2-hWNPpEOc-rHg93J2Q4dg3vlg3F_unizDaImjj8yerlyU6tDDCySqpEpj5mqigGm3SHZj_BWwNAQvMLXo23_IlsyY4lM1dgIN8BFA2VqqJINV8gUg7NBrnv8ud_gm6EDh1GuezxfQcexjGd5p3n2IvYmH4LDrgjlhoxwlkoupE46V34KH1dXvVFZthnyviCRU7sD-etRuIgNSnkVoT_cgNl5a6ev_8UaIerJbDBf6sBIna3Xo6LcxvMQYSNmSoRFWWJCdO9eSnzpZGYaR3y0k2yESdUlY4K3zD6vO9zycC4qwHrD_qmUMGqFp7e_sMpXlBpzIgBEh96Fl10YrfS7-9to9zAR2dogZ1o9BPRNTvl2IPmVC-g0iT6-41EmvHaQQmaOGrGzW_e8r5OW_dUmP8x21UEwQRC-JFeZP8gEwTqk6pcqvoaTmDcUHUmmnWbbSCh1PuyN_CR_J8DxTguZglDQkbVOovP-MhxJeXFtw.JP8st7JVL26tXH4Otq41_jWuWhfYIfYf5u6LXM2_h6g	\N	\N	TF/wpOrnrrTE/4M7HkF4OOO/GvNoftVqoFPCQXPffBQ=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	bd739d5f4b404ce693465cd3ad259b34
3a1dbef7-e376-dc60-96a5-97fa9f9a3238	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-22 18:19:39	2025-11-22 18:24:39	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.FJtIjly4TLf4Vh19VUMssthzcXgqKpqAfX5U2Z4buA8xuMrevLtEAieKl_SvggS-qN7qjYXZzrEtt3YGnzJcCdzg04H5rH4PuvFOUPfOWsI2uuUTsUsD100I1PEcMws2H7elIlZcGZKbAe2bnlH6mFX9ieDWg-KUBN4uV8Mm4jSzTTKV_zpdYUiz_2cE8fhbH77_R28SJ6DDWL34sKLXZF-EOaipFtg7pXMahvUP7ZfeYoHS-Hhw24ucdMVm2T0ZVtOqcVlH0yc3vQXX_3Hm9ZukjFisVJo_Oc-x75fU4UVluR-czoI05lMKh7WYh0aMZBgKdZ06jHEOBuYHAleD7Q.pqwbTU9JMkMmBcHtYTrfsg.j_nQK1cL3UKlTJ4yJj_fadAXh96_ApjvWkfLyIe-_F1vMXd6RNPqnRxeOfrFOSYN8fl7hS8FSSvQm_ScsGTcLrrqZRHeGIpgcRebNqa3OgNQgCgXgQRDHbBqR5vb9LP0YOiNMuyzJRIp_bvU7T_DrVrhXSQgYnwFECGt76-saIkGwO9Gbbwxesse5kIueMNDaM2_DU1o0eaxFIeg0wVa1QcqSvgQRwYuGGNpqrLIZSyGCVwVeiuORytoDrb-5Bgkzib8yshzthAtQB-KerAWYDIiXeqiRNbU3cL87PoeRs73JmqoTaSALNxEviQucGp0jzaJdEFjw5VmJx6opzzmQi2jR2DuAEXTtXXOKHb6ZkOTHtb807XZ8cRUClKohS9MQz8Az8S55-AHTqjbsj0geQWsHuYng7tIYxj30MMeYD_SPmi-9UvVwQ5lGFJNwFNhf1qRCpS_ozTAKzpUzzHyyvy5p_TTIVj7lkRtbzZHv5p8MlGE7QSMhx2R6g4pPVZWnVxpzluP5FOmevQPJ6mMirrrJIoCSXPov3VaYTWY64MAH2r7Chkgo2nJTdPd6_8SCFOphzVZZN13slkKk-yXzTn5bmL4gXcfCWib0coEKREOHWCi3AmnTEzQBsa0oQwaG4gxJHkViHBlu0c63hMXik1y_Y4EOi-xjp0EDFEy2QGzHVebBYN8JaeB00cicndpuAV76ghGV2ARPdfJcRgP4KqbTGnD3DRfb0C27UvzDsqQkEzOKIpGp9EP2xG6nCqgkw8bA0MNhkFK8itiY-ub6o3WPsiFXNMsYm5oS1DaMqJx5JI-3zS-tY5wvcyGJmTAv3aBqdsKPqL7WLFicGsMCAZ2t08LpHoMc6f57N2YWlyCW5qnRWEwt3g_MdzX-FMukGX9KyLzrDhl2flCse3AI1owLsDKdhTcWv8Pg78OJE-Oe7M-IJen9VXMz1MRrIHMTe7TSTmlRmjRCzlrq4EwHs9cus-Jh0fci2P272KjTAjlK6cb2rsP-y-_4bbymn7TztbKSzRhayEyia0aMF06Ew9uZhLHFC4Yr51bYFid2EKjD6d_NwW4-5bDevZAY5WbqnT0rrm5lBflUt9Y8myFuhiM8liJ1BQ-upRBV-Zki8hROtKxxfxwLYiVpkajXbw7lmfWFjppYoogh-7gmFavx6DyIh_iaQFjE9wa0XKNY02JGXtg5ZnzfUHdRXaN9h_FQn2Bp54s2B7vVFLca_ZQ6jnljrsuCi9jp-NbeU8h6MdfvKs5U3Tu8ebt9gm7XMsc4ImwNqC8VthbhG60toAwl8BWZepdy2MDI3T-yrpHJK7le3j1wqBnv9sqvNZrzCZP6RZTO-c40WvyN3zNVNckAeOWD1mOVddfObiYdZp68KF5u9PZ_ANwcHU3BTAlBPJiR-mC5bOwG5_FwQ5_bM9xNOFFwW2-Rtf5vZP-_4sQ9yMjaTnvbLF9-fAp-s9iCT0Y5uyFZmpzu5oGTcul6gi-vAqutZIqBO4ETngzp4NikVPZJzH8k1BF-VOQJdaeGackW8naycokKV7m8imgivO3rJ_8EMK-zNR_zWirEC0o2yvZ8zzSOklo2UkZ3C8wOqIm6CIS2v7Dx0bXDt1lkvMzNPmzxLGXxxRvx1YYHB4fqC57RXL0sPKMNzNT5OihgsAoFx8vYMEQApxH_3iLTNf5PH4VFFAxLdJqw2BYzfg30e8KostdjpptLWkGLrwqX0U5lIYMRoZQhJyndY-Bv2ql2gJjfH7KxJmDdcg-QusuJEu34l--QsEHw1YuhD10rez5Q9irSBqWVVKMjbn4BdiAHtP7lpSv5dAyMXWgOIbzyLo7J7PjYeJsgryd5VAY6G3P6_UbiHk-W4wtNvhigSKjfB31gNgIAMCKO2yNiv6giVPC1s5t8INXF9wOCgyo_Fn3IcVKzN16OoxEPe_w5OV_6NowKz7_X_kK6i5w0TwphVVEN5qy6RFYl4EdE_8HO7Uv9Sh8eelWD1H_Q3RC0AI1HOxYP05j9GooUBb9WmqkL9TrRQAqhlrmOGnmemrlVF8kfnZ57TN-PwE5V_fAIDzcR8V6gxkctrTvOWaeqMucIVMBMuZ5K_b39_-mohAu4V0f0tdVgVK3DxjaLfp0zLbPc17WC97OiwaXkEaLePvRahLOzKpgOaYMyo03VrVWkcv8_guwRxfCGib36E9G2OKpaD_WqZ2Bo0KzDbx0NIz1Vquz0aIzf50WnZULlxlVInEGYHQBH_JrJv6zZdXKmz8sbNDuzJj488h7py0jQvciCpwbLEG0GYXlZhXMN8_i2chHnwUQGdD3cP2AshsR_d2zRqJ_nBULDtcZDTglr6cUKag3MS4DmMxbvyEGp5tSjd5VJw0nyvABmK12Q2Fhk-hOZzSmTuLjuKd5_r-pWTacKoxgX8JFIRdz5lkZq26HI5CVMW0pvJt1L-DLIf4CJXKYxg.CADUej_Gsr3kcdf39l5n3XtDy44m2LuVTqVNpqVj3YA	\N	\N	cYY9NEQKnshCcJTRDsx8A+rsO2Vq8rW+/BrbPF6e5LA=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	bd036e9c33ed4815b3fd85cc4c393f76
3a1dbef8-4b85-62b1-2f8e-f43e6da080e4	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-22 18:20:05	2025-11-22 18:25:05	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.FFILp6qz1UBPxpfiTxrPRyUnzldPMaZAq09PuGEZgQuWXwAbBgVR_Ns7MBn10spaz_3uj3UrCmlclUVyCli1TJm7z3Dp-hw8hW4tgOn35c1UCzgeSLGgLHABRR9bmJXDOQMzjfUUnzBRzwJAKIyV56xYXzEIMCF4w_lgyRtTunTsyvko0V5AxRKL2EBhan5jLYQDwbXry7sZ4KFkBfQmAUBxNVEKGu0pY3XJfGfM2qtLBjU_et6esrPQtzyz1sUop_gwl-Hc-ahe3HdGzYzMF2bpt9Fqdh-cNcorVQBDsOXyQYHvBEaJp9RAEdLx40r76LLoTydXvV1j0iETxZvJ4A.Xij_YykqVirndWZuQMk_hA.WgsGLUmMLDgt59iP-0mKzISZ9s9jtvxDdbUGCayRcox7jwzphs2Cr86xBx3vCNa2NSZu66z6cGoTvKs_69DkCGy-Y_bMRdLBc3fPoXdjmYAlQIHinbIVkrjGA9opwS_BEsjpidRjygX7SVjnKkCaZ2R8NwLxwBKl7glTVztpX3vQ5S-g_X7ePf7QEfO9Ifl1ouZtcPFvv0Fy-aaCZyA7R4cALgsfv9sl50U_iwy41nts2xcJDvlv3sHATEk8FM9vCG-WBn7Ee96kAI64E8x1-evLuZdQdeYpXabFALAVcZ6SPRYrsKTqhATlcUl3epx-fH9leRdk_y_brzdQP33LYzWy-U0SO2YJqBFSbDY_Cay3ATXrAycgNbuTnh-ZX0qMQtxKWYF_jSDTJ7eEMWQWMhtFon2wbk4imH5n9Uo5kTMKtGDiRRW1L1zjmLC6RgVEF7qXHhdh5gmLjxHtoN9tnz-tMtZZUX8qLUaY4ImqoVvpRysdZO7D9JMrfza-mBmaYIf9lei5m0G_QPhro65aWVd_VIajw8inge03C-8zfH2ijyFOEi9rMc34kflKE07WzXJm1vpqA-0cBHAa4ql3w4hhp1G5zvuzOc3Di8T37u3rsxsnMiopgh6Hufb7CxR6dRXf7zpvMlsjYQc0iMevcoPN3qKEd0GJPVvQiS0yG6t3ONBFhnE6t7iy7U2e8ej_cOjPT0SCStxl4MghLqPAget4l34ltO8qxOCQBHuNIoHFFuWaiK83v9zP8fqMHw3PQ-y36qA980_GQzB8VNGJXcOQPwFGrT0zOYMdiTYz23SG2DHCLsZ-amsZBWMwMzEWAUcOkZGRRRaqfjsflGNLwxyxgcoi91kzJuJD2bGsg6Aw3w1XINXYsrcz1o_H-DADGgND08bIM7ZIWd16zB4wUI7GjpxP9F4u8tE4sdyt588xeC06T69QbpvOf60u0iFTBemUnqwOXbHrQYE1fMR38heLTRL6fgTQh9pHhD_sskVt32YK1WEEgTspmzHzhVc5JC06tJZ4pl8NZYv3uKzTkdm5KgLn_pmePFxaGd4T5Y-wEJiLhHxXLolNjmFWDUWq_3RjUmNt09fjCrNbo5YuHk1LupBcRF17y0FTfKGy0syFMiRQ5crz5rpLlvkjNpqddH3sdglis6_5MfIn2t4-D-vxUctFXkVLQu4X_rtL4rQUWMsd2sK4itMnC4RLcAoCebS70kbMvZaIoEOnCiEw3D9FpS2zr2cKL509IoPB2mkm5mtXCSy7_NUFQtvCos_H9l7xYigi4yRCRe6WMVD4QrB2-CkfnHeEtDYWX8zMjtHpQQAH-MehWuRJ-0b8isBPrsF-caIOJ4ea9bGCiD0ODE4rwMRQLAqK95lC34vIh-cIcT5mJ02mfGrx09zma6p8-0Hgezgjmz9ADBv_sgh-ZW1XrnRMj7bU4v1OKN0f72QfaJUQv1wgyIGLo6YBnEuREpSsHus2lI_wvxzW1CQawOIrP5mfqM8SzG8HLeLHUsMY8aimmKKy77Hkv6hU2Z29UwF3MlINDxXa9PQT87ImmHrp7y3UimgL_EtIOxO4iZfypygwi0yRHuQjytTP8PXLFMVpgV6BpBrvknLCUE6Q45ikRro9cyw_4QDlxzJdGfySHvycg2VlZXp6RKTFRQEmVzPUEn-P75Dsn0aKgt0v1yVAkQXZNZ_cgatjFXadOyNYA6rKk1Zo2l9QIysZiONj6FqlKq5a8Lt9MtrTCLQbUUv_OqGQqtwyoLJZBCv1mOnIWkbZkyVWGOhskYyWD00yfkFXJXUnjMJadC9ZOd6TqMqEyPIwaXVhMUa5yHLMQH_11iZS1qeflyInFrbt8DkomhPgXJTPvJWK2No8J642JMytRpkTxNpK7GMk572SGJSQkJko0iu_5gv1S9jCTTdOp1olbmZVoKowgYcSqLKz-srRs1nTI5ztk0UWSwJzKfr7l7eAcCZXBEo2uECFZ6ZW0sHts9RgTz78NS_5vk1jyddxdooKUV-zKBpwKZNKkc1KJokUUd_JHP90WCgkLbgTqd6RCfXYxQOuj_AOqLZ3-BvduhSCeiOZydFwUYtdAt5f5qnUQGi4dlufSXDrOls_lsDytEO-XR-dsKcrtNlBLTGZdNSHHpNsJnrArjSs-7hEKeXGo_NzC7hKLZKYKJptG6WoSnOJ7Gy6gnVHVuv9VJz5pwxnM1uU4BSdGQHevdrjOmsvE1vuHfEpLNa0UfiZgVLbQnsuLopSenWERMyor0EwS847In4MPZiTaOMicoc__8D37E0C2jB_oxUFb-2G4az0WLgOnOEMMaBVdQ-OHO1_lO8QuyqBB8_cD5lBvkMi_jPU51vCNfznW1hEBcwV8FuReN1SfgVgHSqh709HQuTgyq4Rvx5ZFfenTSULK77JLV2spajK4k92j0cRbcmghOiQIbGa0HrGrffHIzWNng.114i2uFrLJink5rxar2822c0nGx19eiLSRKMCjGYsNA	\N	\N	ZsdnSCzH/vNU5nqpTQs2IuwTNhExXKTKsbhAxCYiTQc=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	d18913591cda415b9817015c58324d23
3a1dc3a3-cd00-3589-842a-3276ab4a10a6	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-23 16:05:54	2025-11-23 16:10:54	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.xLMBg9YFGU4X7YYo4xTE96wp_jK5L6tI2usv8f_2Lontm8v_bnckb_aAX_-BslwozX6LRd-I9n7pA4KOc1WXdGdlvlXdDUUrUTVHRRkWNKSp55Emsdk4-cuEIjy-Utvwv590nK9ps5hKRXNPX8JnBsJ3hgwbL4vlXx_bbVu-Hl3RBYoWU-eObDoPL9ue7Vt0peHSU3et8Fpfsjdk9m5U3taIB5KtWdNr7oKrhUAuAeQkc4Tx7AlMp_8iCXR7kc5h74B9Rmb5M1TrQv_bJtJxOV-_fQ0dWwenhp3z3pNxiatoItsbOgd-8dq6OtdjXFB91xWko9CflEPJN7lNlkuZhw.KWjbudHwUZHveA_ZJjAvuw.aDOsA8K-I1r26mKx18uUCrTWm12TXKhKIB2T99KxiqVGRUPFUbvlRAVDJ96rrhVxFYzqXs-bmDl9Lv6SZgKgiqJ0cpgL_V1xSuUI1H4x1ONPUpo2h2AjLFw4gfIeYWXZ7UTsnBx98DH45WtBOzt5fq7qaT_brYxETuiV5HRtL2yD6o5DEcpRAIZjirgHGWegbrkfdd8G0qXKZmTPNndAG9NTl0qwH51_w5SOHfsrpj404Ckld4EChrSQYQXnqPHAtjrxjRRqQB9IUHBx47cP_2wDw25b7dd7TebG71jC1NNM15h87Io0kcnOoCXnqycxzEUdiaVQxmTcQe5gfgVgljbDG2RuLazX7kv6nkpSH6dYvkYzSqt4xDcgXqLWaTbdHrzCi3QA7XvHBVFBAvhcr6avAfZiVAqmRzJPd5ahJzfZpUoXOHnCzYBisG6EQSM7dsHCgJ1XDrKLAtaTWzURK_cijnWGlTndf6V3GD5D2x63fLVp8oHhAHOqoHfe3Fjg6GSrYugICEPNUVarwl1hDHiExw_vO5y6E3F4A0uUNWYBSCGAHk1UVOOpi-TMxLY0wQSRLhlGi0ibNt7G2i8kYZja7yX3ymMwykg7JGkbcsMLkuT3DAL_o05fysw0aRStfqJj3H5zijkBRhJs2yYOqSEFLILfTjR3u2hGI2qZvSejj-qron0nRIVL7nNwdBZ2mi2tXW3HewcLdt0a1Z4GDaphjHA_ceSZq5mkc-ui2c53Ut8RvgCxOVbvCpdhbvTfiF-2RwIe-5OM1o3RUGHPehfTNqqy8zd_Y0FadIxOEdfKj4g9ffRUcboTCPH-axoFXo9sJ4URpvl3oF1oHfpnUu8OHXHDF6wD9D-zVAGG5yLFVzb89mjjPxI5DIO4xOg3xvyDy7BTNTN1R7At19ioCFzdniuk4k0TxgPBIMBu1_G_1bpoddMQjfL_-OlOs_sM0l0hm-Rp485cYV5Wy2D-MclIUuHHUSZtBZHt_WyJReM8cfEPSm1NUFTu7aHdFNnSssTnvkoH6wjxgQsQZ50XSRe_q87cLz31SA_QnLb304fMyi3hfRRETqHMaXpWLkSt2c7RIiayT8BUAZnwCT_iR3q1phfwVNUYU6Y8b998nlCGgfhu35bLZDT1LYQcRyQsf89QxQGe9Ix69qDV1JDvkkMBQpZR8ecaa-wsZD3pc7zQuBq04R6Qixf0T-xsysTgaC5NkopI6DYfa9_EuoG-6Co815T-zl3Dvyj7NTMg0k3B6KExA9r_nflG-RhSpRzD3_NXFIJhfCTlY8Zk97H46CvrsW5btsmJXIeYi_FhoUz0Jq4rboverlD_k3S5ish4hCuMbPvHHwwe4hwXgkPElv-QCH2v6d07YY1iR4IMSuh_AgYoSX5r1zQ9J16_Sb1k_AwOzD2Qqyfn5jQ-NRpXAwVMam6HZ2bMAnvybUMFwC0QpBdx9FjNutd3MRa9Aq2B6-yrwNmS0wj9r5mBMMlGVKrro1KuT-PNqgyw8MDqwiwhe31GbcTMax6krXJum7WDMwEq4TYMxYIifw8RbKtmjy0A3hd20w2kp29OgaBeZ_WfPRvF2yHzy1uMc-RSHYIn9z-BLiiLGG8C7880RL8lntCRfEwXcZiVdHQG6F-xcYY9l_ONs9JM6JwWckkwebP70SxVqg91A041ZSmvVcluXiHnfsLtXOpuIMTz-ROoTcOaPV8UBKvu82OhJuVsp85ZQnJsYC_dl4y73JAsgiHtGVj5PcQCpYdTnyT4kdNR6DeexwfOimSZeG3uyGTaOp8pJxAMj6l6AeC1rFVGPxNOS1ioV5OPnNRfrEyft62CA99vc73EzS296DDBMNBqxiEHHX2KX__OkZPtIj8oDhTx4-hXJBduAlHgW2IkSMq0JeAy7PKfiuV-h1K0eh4KNqtI3DEKS1x5Qz9ZlSc6h8v4uryqXYy8aiGVGcWk2y39Grvns9IKhIQVD4nAljJXT4WobfUufq6MYU_PEhyaEHW6r1OoikEmKYu0wToGNZ8CTFeWUKafrBFcTCBx2FYOwTlDLn2WnU3u1QR4y033HV69E4nW-ZZVLUD7QJH3Os44yS0bSXe3-zq7RTdaNthAA2pDClv7fQd-j6N7gc1oZoG4avgvxDUPYpxWaqtnhYc0YYo_HRhfMfP9SRHF-uJm8W808O9RLoxXMHvCqf-chAk5Av5iaJiJ5HawKYIHHHHt5cFN27M0elnSVo9G_n9nAewodUEW8Ny2GSPzcTbzRh6MiXTUocAkcZIqwqN88NrKA1ut_n8Lx0lo6_6TuydqhbVZdKlTAqnPhfz8vejWMHfk63210HvEilkG5bBSFWHGcmBotMWCssq3biyznBT2OWSBA9aydG6KMvN3A7HXGJwgbTgVKnBaM8agzA9uteFX63A9voF-qVo8YbG-GkfvPHjGUppQuCjyg7OR4LvAU_am8A.RRP5CAHezArC2lByR7gpFIOJnS2VreoImJEaz-QQR5c	\N	\N	wdC4YlZ0q9qUM9y1rZ/lcNHtiIHknXOAGiNevMAMvIk=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	cbcecd6affaa4a21959a7f50e52b41d5
3a1dc3a7-35ad-57a1-06d3-175d1d2db592	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-23 16:09:37	2025-11-23 16:14:37	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.pnh8qYjhjUNpNufuDV-M4xeCDrzqw7J1SJqfSX3txyn7UuPuSGS5bnbwQmwuet143oJQpcaisUACz2W3nszPiZwX0GAcRewBXAVp2j9cKPDysJnNsGLP_rZ9LmuMl1I2ju7jeun-AIWwW5VmbnvK5du_tA26N6f1hbxrV4-JC1DMrf83f-Uu0kJcaxXBQCVPSmsEogUQp3Am4ogR2HYq40xI15sNNEtbaDbJaAmVSOL6kRfSDbM-zNcacMflDqHfml7Eoncxfaesc-xK3hHxbVBvnHO_FlqC99f-zxaUbUseqvd9a1E4Sykd-dKrBgrX7Xeg5KOi1Poe2XWyMqJesQ.Nrx5TFrauiXTA-Gl2wRbFw.12bJK5PGs0o4Ip97i00CfNarRTPwX0aVbGb030V6R9AMEZEKaHxWkSq3-U7slf1u0ZM3VkuxWfKHUstZa1bFIN2OkPU1DRb9jB_NKYOuXEY1cE92zLIDKxsejUUmeJcl8ghkbJrac3nsUfJ92GMj0s8u_PhX9d_7aDmpxc158C7Bs9m5nwddBkkPKi2UUQcnyDQGYJg-CPY8vg3oaOmlgEEWNI5w1DE6RkmNRxG6OiKEHRB75_k-d3IGogv6hIgfakyidSbqYG0VkEUB8M2yKfMcdkoFJFynxO_tH2__a6RNKQUFsv4AzJ9X5eqiVCVPvJZ2d2ZdEt6hUePrTPQtdQwoYr-7ZveOk0_HouWYgJMMNHcZNkaJLYuis0jb0jRz48okZRNFxaah-x-0ZVYo18Oa0J_mv6JC7bdyDrPqrWKjsrkoyMQBGjc5l1rH5PiS47-bA9LXgKCRt70PuR3Ie4dItxQbX3LJdRznLG2seZeCjQJwUpvQTSzmnS7VditCvDfh5uXxbpnBvrz47owMRRsbb9R4UUPunH2Tt-8o3XEQWhzGZsmr93W43Qd0Uho74K7tPYeCS1iNZbYhVOHSPdkVaglL03dfx-gYS-oVzZDIbCLAIfOPWLeRs9sExmml0DcIf8rt5hpdWnFlFRcWTeiRnYllNW0e3BeVX4zcRoxe0H6BgNBEYzsYQIsAWTLEWmVpUUBGd7GesRGzWikdeMu_Ub49tifpN2mb0Pemv6c_lnfkjIwqT96Ta1ZxHVNxLxQBeA8azZeoaiQdEwYozV8BAzOxoj76DS1hKX_S0FRjcZg8emVDj9aKb666Qtgg0HEpxIPInr-w2d0QDlc5yuNvXatA9jVVD4v5cMmV2qPkgiq5muNL6bwToZpm6Vb6SimmifVlQN5RFpHwGF3_j8dbXxM04xS4Ute9AG1Iy0VEU1pqfOmPw2kmiR09eP3Mnwgk0tis4P06PJjr2OBWEZgbOMnz2g5iCy_OxF5JFk4ru82P-HYCR3hMOipg0Yxio9pKB0vJIswN-N7k_7huHna8aEbmg3-QhJP3qa-2WPPRfSlSHH5U1d9l-LthDt0QeOuPCQnAAAtfR72kadw-rHDL0Ued_J6OI4DCBmHBog2--unvSAhU5kcA1TQr3bSUQyGyGW9xNmLzPk7oHLeYIpVrOSvgyUar4cLN12aU5MdGrx52diaN8QBNXE-cUemnhwxRZXe-_taXpjXRfAs_qNqU1lCBpbxfJDdm-N43BajRM1G0TgJohLvUB8eCD2wl0zYwKUXRyi5TcHnMriTLiI0_rPlLltiwNUYc2Yk9pA0EFTGCOOr5MEQC_ebVevaEHicdSKw4y1tBwX7GTEh3pFqLr1_0g5AFrIAwbGGleEe0p1Xo1zp_CiZIurgglJsSkR8G0BuYKVUX_e7qqDevAIxC8BquBd6j642qmJ-RAQdc2pimG3DoXNZSX70TiVUVjptrBEViFCAYrApOrspujJggnl0s7PKPbripOb0vEEjZc3LjnQw-BPRxtM6MPLapCyRXDNZUHRHtMcMtOIv7sj8fH1sE0qDqQuCVE_fGAO_mh3MHKngEoaI3BjZ_WOv7IXG7B4-8WxHtiuBSWUq4GWDz6wZ_QQyb3en9XxEQcN2H4gOQ457hZrbqNTyrpvgQVIwe_ivJqzO7Jq4fvIoN_7EdE1ssrjO0v07_8SoMrqqo7b8zskALox81hw-CrfptrxmChdwk7I7n8EQLzqDYUgTUATMJvMnzdLHwRG6U_miiACFY-QCHd0rDoQEdwArPJHvOdPxjU2KHEsHtyRonUaGzq-Vs6_5IokLdkFRhp1LEjPfa4-c42jMdZCrTm_LWAOHPsFFDs8UjKnuNYoAw6zKvWpZTQA9ufPEckdkcydSGJe-hD-mQhjKt1D5umZCvgyPtQLEORcsG5XuKznKbLUmDHaTyROYNbXU3jSncCLYOZK9dgrYvHFgmGQD_IkKkSh_U3M5_MJRAhsZ6nWRKONVpLdoxeBV-S0jA_is5f-6I6tdEss5cQfb_X9wQjV5WpcZuyb6fVBnld5e5YdYH757IKUNu84stLYnj6BCbsdIBsgPm1wPKxk0CoktWA_w4WjrRUvg-Rf5nYO-bMkKUFJ8FRr_4Tb9PB5bbyCgShrZeCStcGys4RbRYOEzSpfe_t1ao70lKidmQcX_mt4pe5iQGhGp4bgGCQbPSLR4_dwRyWZpMeqU0PSZMWXOiNO5VhX_HBmt2sRC9kHpllxmgKWhKXdV5ou_Xe1qstj4qEP_QvPwp-PJy3wqhF80ZWPX2R2dD6lV6bKPZ9ai_mETt1b1GrMgaBiX1_Gi9CN3aomcj6yBGIQyujWS2YlqEn7gq4UTVQGoqNnJsUEXKEJtgPDrCfHty5GAs_8ergjWcJfpDE7v8PN5um9R28C3sKkHu5yyeaiERlGcUnGX9y8todQ.x8CNOY9IIOeaSBiP7ii23m-5rzVFXkND44YUIuNZw64	\N	\N	NkiLIFEV4SJjvIajDGYCm2RMiZ0GOZRqx4ZJjkxOdHg=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	cbb9f6901f6c4b34905060da8e2479b6
3a1dc3b3-10eb-8a93-3bb0-7320f91f3dcd	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-23 16:22:34	2025-11-23 16:27:34	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.zrSKDqecoy3lTW8i2qbvTcgl__ryJ3UVR6qGlCC6Jto-IzhAVYcTH_gUxFX0W_6ZEgtAsw0AlS_n2rusiH-D66964hJ-xqAVNHHEM8p_xcVjF7SO0lh_3fCTrYCPiE1cwqVvG7WlX77zNojOYJFgEywrPsEfIWJ_0WJne88_sX0MaWethSNyro52L1G_lkJYS-D3Su_tszewyxlw0xE4V2DSeX8aPZir3UAJLUmGVNg7jPF24sDvd-TddJRLCLbKe9TwAXKKXEVIaW8hMPeGYTen6lUKC1vcofgnMZt6C9uemyHG75x9gXo2vOKIyf8CnqPtENfxwwLfT1TFkl2fWQ.xLcQPg5S4RpekupIzVH4WA.RXJcAtdSznsCKRJkKfw8Tzdhs41sXutfARbCfB9ZfRMkf9E4TDybNRfpWz7W9n5ZaPYRQkhdoW_0w3kvGd9yeDpzQerqR0LRhYdRkQ1XEwm4OCVYJdPtNmMiuNFo1FUHFKLsOVl2z2pyc4XQrH0q_sF-qTtLHh4SHEmqVMpI4suAT-XIcAiBrXT1w4P8UuuOxMgSjxmfInk7_j2zmaSV-VruXw3BCsdUX--dsj3N1aAnC3Y_xyXnEmJsxOH9Jx0V6yHxujNqR6tRYwdZlhJsvQZmaUCer4BIf7d96MWrOlE7myGVjWgoUJFT-Cq-egmoFIktNPQwUNfrXy1YWJJw2koITtmkVQImIx4EkstcoyT2PKy5Vj1n8xH-91SjytQh9bos1llCD3vAfugHMdtwarLcShhDtQNuk2MPUhwH3RAl8Z9znSdxWHhi1oMuShi44JDljBd6j8tWau4-W-3fm3J1iGzVlVCxA-o9Sc2dhiiaQMNydnMe7XylqtwIuvs6HFtXqNGKCSGmkzk6Kr1eNM5Py1Zd2Fhu9itPhk-tH2Ow3kV2t-OPF3yB2W8NeCGGv7Wnf_-GKlCPmxsfAU48lzBcHcSmWJgMoT6bBfngsED3DGhnGARZ-pXDEDNG95pskTkciKHc3dAxoq7BrLwTYICHLyzftIOfcKcj7w7TRUWJIiVJZizrVY-bm9gUQNt7IPxx5iQfSdVEDNvnYCSwLxhURIjkJuKGG0KYUB3UVztZmDAUzdbfXrU15P3gw28Xyvmcmw8HCaUxlk97qL5nxMjSOZ9fWbjT9kb_7sVo_WNq_UiMoZwSbTm0G_dDovv9sVJAhneXnU4TBkMTw9tjn-QRGirO6-iwV2VAqZohCQR7sNAEZUAgwsXZGahaZLEu25iWm38oQQWWG7uIPsonP2-T7zTuVkYOthUGjETou4UPXt-nH5CT9M05JsMJHn4BxQHND9jiRH81WBZfvpak4UrA0r9C9wEVNpSq3pkbKpffsdMvtK2Jm1vEVWuMfNIZJwFqSdDvwbcQ2vVqQz5_08IFbCqMrG3qrA4B6PG3n8IGmsbCtaPdKl274zfWc1Zmr0bwUL1gQfx_mVcHG1Row6EFybooUfsI_0goLuPonoTXDFHFuciXzH__4umK4J-Ye6d_XDVhL1waJat20i7VPp0t_Uk44z9eZ96e3TIRQ1w6B8pt2DwP5yRA7zZoccsKxTCIkyLX34Yqpb-xfvCLuFO8gR_USoUkV_iTlXOMBhxrMMSBzJdCEqEKMG0vOee_0lrkkSCpHKR4V8UY7Q8ZwRerMtBT9ByoOk8H_AwOIpZhG6Jv3NKljEWnLAjcoxYH1Fv9HoKLOoO4fhhXmZKB1aOETnEt2jQ6VRUa_YgIZOdGZw-zOwutjgoQFZHuoGusahl06TxbhMJ_2j-MDEFgKXOxqsNLZYNwzmAc2OaCRo1vbcU1b96xLbGEXZQ933UrwqBGJV2CBQ_jRSWAMNMJJeS_mAUthtoGWonhO21tvO4hE09R5yKpGpRA1mbJDzQA7X0ls3-VXM028pJQfKLIwK8CZv1_-95baCzqNcKWth0GPvLY_QpGG66M-XOhmx5HSqJFtsPZKVugYlvzRkCcbXJMf7tnrIe4Eb-LInhX9u1eq6xTD8brLe_ymYcL0vIPXBYChJtYyJmazpvKqGObw4uBpg2GEiS25Lf4q0aJ1LKGPJrr6FGFYm75ELnp8A_WjOJ-Opmz99Pj8V4u2xnAGvi9sRNNhYEUT6VIr48w_JnY5cb86kog62ex_0GkEesHPbuGQOiiJImwIg6oxJYsxdbj-9koBSiZrDl7XMy1aFfjfNdbF-85Yga1bPtP8G4V5TPbVvhJ_PY-RhwLNOVYT0H3433Wk1qMS1AjbgoEyQ7n0d0vSYTXITdcAnzvwxAcg7JHncGI1K_M0rGQ3QKzT47L6Oy-r_2e3TfdgBuJGkP5HjxaT1OQyBcZuRzsWPFWMLnm7qZLkHdGPjbn39h9yPkuzSp7h0AMNYvXxs7uOl5Mxc6yJm2C9No9Cww2lpWNYm5W4xCVhzR1r3vyY-k2Cw7Qu1LmS780FUyQn-4-ULtnWM5lclEmHvOqTKtjAzvxsNlORJ4einig_8wP2DyWvufASdpsNIxRqF_hNqrXzXzFUZ7bE3B_9xNFgLL8rGXYOvjadBDUHQ_NF6lUwc54n7wX7MAdbNGED0PXjc0lYY40IuCRh_ZvXVn0mBi6uTiyRrndLBK-DjLSc9INhEkBOpg21cek7vZgj42BclSv_yy62PxFqvzUJN2aA3aBHInwGBK86kdlwQ6tYZbVu84cxMQlzj9akcMlDhEGj8ObGMlN8Hmn5o9I9bFcSQ6u0EoSe6Z9Q4PLhPJQeu47L39QAEh5D1eJZ8w0YinmTyzSy_4ETY_detR1y8wzEmQ7PF86Ia1yJkSMM8BRUowp3GWjzg.CoKmDdqCrNdLE79_7Ix5nhxz98csmbelFy7_tlLZffE	\N	\N	EaXjzdliyDcdIJ3Nuw49AoYp0PHh1toUgsWw37HOask=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	4bf0e062ebff4739805f4829a7181659
3a1dc3b9-b8c4-f47e-dbec-f481db3e49fd	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-23 16:29:51	2025-11-23 16:34:51	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.s7FCWL5iQgy1f_R14CPXrnG1qKFPaXFFPAHGqMPmxXZ-WiMOpRDsNmwxQUvXcJZTGfFO_RFFDLolrSGXrzALNhSC85IQ_4uKRi-rH7_Qnu31J5PrjbFi8moJ-_g1WSsTu5M9gh6xP5wNBKBOZrVpry3uyImODv2pYjAq2_TlqLAvKRmruz45zyG_A4zYWRuwTgEUiVfVUJVTUxojZRT0k48lG3s4aQkyVjT23NsHmx9NTP1Oq8yvPhiMmX3-bTu1kUH2-AAmQ4gw26-bnAInopZhIn0fIqOFTNUshi2aVcMR2iE5VIby7qUBlrvtgoQiV1Eufe1aebtVXVY3EJIoKg.LEFgHXER2WzIw1SfG1ykMg.yJF82K4yym_az9JbgnCsup9xkNRWz3v_4kez4EXvJ9vavWcfTrBuvBBTZK5U-zhnlBq50_DBZsbtHpKLxeT5KBLAciGMiCFFwfQfJhIKZtwCwwK2VDx81nLhfklaKZfLxbjxYxPTFEZQWGgMwkXPYJnb-wdTOypkFIo7aCLxk9nzElZkCNaQF7wc5HESHpPZ7IrOYhoU9x80oF9kF_2DJKffkhh97w44fIwV-2_z9M7MFyHM2ItrqRyZOOQKPbgAAVd7Llj7Do8BnznBzIGS1HKd2CqBButGnpZi5GHzBRUa-VfZ4gLDGA4vkfvjuVF5eKhdnN1Q-4TWw6LWDvWQHj6SrsqTIn5TrskqViaP4fdgnDPjSnx7AY6UeDz6Fyy53ZD7Brr12yjMGPevd-S8SfZ68mFEGdePW1D2hrJVha-G_7_FZ0xXvc1hBTaIhIrHtJzmy7fd9SEqaaZS-C9WyHPnAKF4VgGMBLM-awYzsF9oORS7UVw6eG40bIcv8wNRNfW-yBaS4QRVZ_-8QtGm532buo227WkUDMNKj6O1bF33IYSWJmFFqlC4-fKJQYEj_6uPAYqSM05m7g5z5OlhQPjmF2UUV4G_AnyiG4A-ePb-sTihM_FgjysSxwo_MpIw05kWURj6HWcRHPWgPg027dtqrdyddJxlRGcFUULvb2qUERbhTms4vUtpdzWxGn85szDU8c5R30xFqzyq91qn4VhHWljKtRV8HVpY1PjjkYg-1BywdYXIlBwdsqSJnro2MgB6RH2eVkKtHWPB_qPC5WDfddcEQK75yMGRAxskUH-FeGLEifOy9XYb82Q_x0BrL13QVBSiyj4V7dYdXu279hW27FhrChlEQEC8yb8evQPNo_x6XjecXzpzc7o7fWAf_6gRH3g8HyI78-IYJHIAz4e9jLgsV7EosKTIiaDYD_LmBr226j0cJAy3Vn7QXrETn9i1ceKaK8SkFLgN_2WpeysDEyCtpGGVT4zdI14-2jUgsp-pXJQAouaXLq7hOhULtFKYNO6OO6x_D0T_wgASTd6-Hv5zvgACxWvAS-6pxDchnVZ0PnLHYHbAa1ucwkmyr-OCjRClLTAmBtDo-G9t3Kx2OJtk7dWPRrkAZxsS0CPef_-om3Jy3CKtyWB2a1ZiQ7XSrBKiVSpNHD30VSbrbvt6KW9NFELx-B5OGiSi9QWKYubffAqxPkdpbCNKKhiQgI1BvqTn9jXkAkQc_Tk7kccrgu0goV1f_gyw19SiodF4kW5aYTLEo9stH_4MGj4a4rDptNSfK6t10yAlNzeR-ttWnFGklOG8F_mpChn0LPjTHopdOq0P4Nv2ByZ6Sg7cVVuTdn5042npNzeytlqHa8Q0haaV_v7aeZGMvSuXt8p8GVghc5bjDGb5xEPaTT-8S75tqDac8vS8pCp8zvtJoyj1khKwzuPPAxF4vWhvIyV5HnhmUOmBCodVGvcf9DaHUf3T_tifr9Iwdw0yZzI4zYb2lPSZDEJBU2GTAyKt9WwcIA2ZcJ__1u77y1Gv_5He5ezO8LVNW052I2xH7BxUlUUbgR7qBmBEGNW-Cvy5lNaMXD_LPNplCjBP9hKsHOiNwV864f96aLlRuc-wMwdxidpPRUbqsv-m5rifZi36ZmdabJ6113FYOMDXbgUJ-SHrIqP82r4ru28QQamDYuZkDGSjODursmvsmBx2HBk4-a-e5iOSDhdjAcKlZiqBznjGriAZGRwMLkBlE9eQGZVYYIfaxM3K8YK9vjzzvW_U8t6SSZjs8g7aEEh3zSJMxfJCgsrEYw7LtWnOEI9StXfbvUDnNRFimnBhCuhUfDMXXqL44hW2m7gxhnJca4UnDR5_piakkGXHne0x431mvzaW1IxdsaGqfJm1uldw7vUFJO9CgK2q9zjht1yHJ4VStP2ZfOTOXU11VrKWREdVodd1F5OnNLmShtk_3zb3O03q5_Kkk1o-BuhAtmCCotsEO78AZHd80mlBqgfokfH6zimwOlyXIp7WL9FIDNQM894LwCxBODplxKsSl8DlAidXCYRXl1s5E9lM5I2cwPM9bs4GMGxjTM29d0j7r-xup8TW0-5paERLGLdOqh207bPcytwJAfMUzC8wo4ni30l16121xIOucHS4hNu6ESpzOLJ_0kFzKHpHAu_waD8x2_xakH-R6X7wtWIwVQoTTefmjv66YVwwUR5lA2fAQq5vNqRDGJ2zKPLuuJGA73vuHqyYE01mf-WVWqz1wzmvHYPEcCFrrPhwInmNjVxvIzrM9zHmTQtmHHPIKNLBF1K9vER7R4z7ScnYSFpyob2_ss9qQpntVoHAFAr31l_iHmBH0orOrEnSEHttEz7WfI-u8-OaIQ9j30lhhXl3jUTWhxScXnaNV_VZlXSDxxJL34Aoxhwmyb_6AxP7nOmVRo_3hX7sngQgWlepLhnp80_bx5VdR2jW5A.ROTav_dwI9CMvMPwlhD8cYe1a5MMphUUJSF4GLMyWuE	\N	\N	zXg1SmmCV5cjqRwQ9+zpUcolIotfVZ1IcUxSIkryg2M=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	d4d4061ff4994a4b92eeb47268b3c240
3a1dc3b9-d364-6ce4-7f26-f223b3805b27	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-23 16:29:57	2025-11-23 16:34:57	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.kX7WmbNZKVdmPPo-RiNO0BiSoPNW5O8t0drxglRc-Kq9_sT4JM_-Qi7XTN7kQZLbcE-q67CmyaNejX1RUCI1Uqgu4RaSrxTzX7e39PfExnRhNrWEgLM0Biqs77Co0XyCEUgAeeCXhr7w-GYRx71Kfl1rNTU0EC_Jsz0gyAnlGLoA8TJnx7_NC0Iv06vqb0TJb43Sg8lP8CptyhIN8IexOXiekTWdN4e5L7MdyPatYPPnJsZsE1pm6gsZtoXllA_aLLQkoQJv2eBnvBVrHf8LeZDlHUi7fHHgTZcxaSdNibAOCwSaOmm0utzYpC6OpELj1KXxIn7XQzW5zSuQDAkbeA.4PUSLSpduErcsosHce_RnA.LYRWO7Z6RM44eC-TO-A6xtO4665p5ICu1A1MEEFG_CHDyuDowg4bgEJNYkyasqSS82rIFC1efBKl4NoSg50xIAeHx7bWSsR68FOsDf1mnCkk1yrm9YL7gSeV1pLWcNM86jVwb1QLcliMTMRvWqo7eciKChcEY67KlnF7BBPPMih2LTqFWhgA2QlO0kCq4IRNyrCoNeAmW9oH2gj0rhg8FKYDpdgiCQxBphoVKJsoxMsN712lu-_KQsMteAqJnWIEuZmZdBlNxI33JcNI2YMnEYX_bg1dnsH9wnv4C7SsrwejSOFOWJ4R6juVPq3czEhMKXOo9jEOqFGIRqjRZiQN2r6Z65DfrMaYB1v7iMRi32VlZuvTPL-181ydchn5aJ7jDpzixnbPbgIrlXcDNV7pPaH2hbjwrvq3ZdrF83cXhF1tzaTvHyomwFWd4TRm-frItjPXAy_jmemgeOs8J-arZt0_JdkZ5tCgeWhJwlR0XqD5vFfZ3pDGe85RohTWkV58OrhP7ck8TD9hsgMvm4esoerppE1YXtk8pxa7XhQBrkZIliY8vpz5MlcCBI9aKDQKD28r-8AoRQ8nIJj5C6Q3BFl4VVXA6JHAkx0mwjUr9LL_GW3GBzJt2z76nLNnceTX5an0VwkXj0VCmsOXp2xkBNVR-nCkMiCoEuH7D3Z9zghT_CuEtxIr23IlCf5Puhy2hpwq-oN1-XKecCtN-BLpjY9oIfVPVXEuUXqObklu_36P_dwSAJCWhifWbZOhLd02Y0F_KnqQYuIvuBFIlFLlLBY8vI9yK1NPMZdEnyUQB1JczZNIVAacYecN4_scCrvdzfP_iEEw7Zu1LR3VZme7i61pscJUFfc0KrFsSjqw6OKftbKQq5ToDc9IfEgrw5zF-5FWMJ6N8aDcQKkXtOY019r2VX4Um5ehwnM8d1Ej9WuUHwwJWq1OyshZ9zIfCPVV7gAw04ggCrGfg55s3UZTa75hdEyw2dil5qOQyP9hFw6WooGoeCYPiVvp6RceBkX8m63bELGrKCZbFZykcZyF4e04pYE9Sg9RJoucKIGrfNdtUYtsrA2uO7R3egNMOvv9PavRH-MGJdURCeqgZ8-xbeXaQyIo8-O98kmtdYpX4UNytp1Q8-PCtSGC_FcpvMQ3nyUeXNA-EL09Gn2oZr2LWBbeyQMIITiiBk8HxFZAH8nG31BBEEzsTt1Q0lOBpKoti6crvE8h8GtKi56ApqL9XXrtC7C7qwYohfc-YlPEXd2DWkXhvJfmTnI9yJP71bBpTi2czSjcQaJ58IcPzUu2uHlx7slAq4UNRpkjZu5at42uTFGTSFuLLAkBqP0-57TOP12T1DlnslTfi7fkt6LWAsOSHlF7O0LNOpThaNDxLqJ5laJeGW-m9BMe9rdggMQbsaWuR2WJ1ENn3T9qlReCsV8u0PhwEwZtNFPKVLNfDx6JpT2xD0U2bS0p1OcDH3mbpKQK1C9h6m4DR_3-f3NhSyP-1jJGad3JUmSgWNGjwtymq49hqwpM37BD7xmD7u2iMwWFN-P7oWUsjdHxcy8rjMjnxPtj5gEEqAQLiAfd1rLm-rBoPDuYl9BCabzFNTbi-jvDkfoihCTDz3ZdBeuKKDDRbtBzBtlnQ1yvQ32zAuWRVc4TPgDhrAEfzu_W3Oyl2HDvMzq1nKRZqoNHfUZup5m8g4JWFC-6cweXMWToHcvMBVGbrDTQn94FrtVd-oJT9H1e_7OjRxP_Zi5FHtjDqbWVgaSFSp6fn7HpG0WaaSviU-NSkdiRZY3vpMIFp_F0_wUd0QPLsv6JO17LHUwQVuwcbKFFOP5eVh4aVNHrGbVlDE6JlrqCRkukKnLBXvjFLaQbI07SdaQAU2YFHQlTW-UVMiVxJ5-rNBry1Q7M9IjwW6VLPsAPvIvo9D6Vs0zd3sq-znd_Uf3s-ymxU1Qg4iEsrV86dlVhMeY6pjFuKMKrOjF3b_-rabIKL23sVaNIxqs_cXwgpysQatlWPGkJXFfHWdnP3R5rNOuX6EeaFg_KfXBQ1IAqxthfk_hSKnXvKa8Bl1Ndyw0jztQztM1_Fo5DVom40rZCRAQL70FHBnUfkSsnCvYSUzk57mVyJLt_rYwBDtk0qzR5c0h61O_pjXnzMZ56D0WhP7xP4mu8aWDfoDwHePjs9FzrqtaegB_eBhDGNhG5GgLXIiGtlRxTnHRLFFaJwMG2YlpFyKSsRsk5JK0AMv7SfksaD1obU8qk17kqZ2RmHS5wqBx9IJZaf4_nl_yvZ8GkJgmZhQ4Fr8E990h3JdqBTKvNTwO4FThNyfHiDDHsZw-agufKM-r_EOVvvP_zpVBblFoQD_Cy39ID7MD2-Pub_KIvpQXlD3bRdCDIP-WVwMHxxkiFgBp-NEFzmUjvdPl6oksSEYkBnaZXa19AxTvKhgGMiwsZg2HpoBq2isIQh6uFQRL1qbGS4A.A3Eq5gvt54urPvpqVYbEIQPeqGrLuuSH50UZjje2VHE	\N	\N	BpiT/JWpBpkdJrpplh3A1c7Bip5Hv8/vWKyw2qRorXU=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	64541fde0ef247968eec0d45bd215c6d
3a1dc3be-9c5b-b466-d4e8-d4fd232896b4	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-23 16:35:11	2025-11-23 16:40:11	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.ULqG1b2WeuOjU_AGDLMyM8bkrvJwOfasoKCnJF-ijqYzkg2ZykYJp7Hk1sRUWz-_RqZ5A0j3Vr44WojDvAnuq0m6FwFrm6cfRac5OVvCZYY4-M-g82b7Tw_rgYcVJlgrUUud2dk1tyfDCwiSH9IEYEIf0xCUDJXbnfp7A_riNkRFB9yRKFHa0N9sE_d7pykb2obhvQyliTYUSkvOuV8BpMGWUw3Xn31n3q6qWH23BB_f2sI4mLW43HXm1gTaBt7l0w-P833ugVwdfdk1VAhn0LaWDb7UQ7VG5dwJ0SKpdRQGsFDC8kQotRQUas2WN5zPlfmZjFQHrqoBf8VUbsiDiA.U_HExFuqXnGaYBr80Rl_pQ.2tYggUBLycYObNaBvzOrpZaQ5R9fXKFEBrWTEK3t9PtctPqoxSw0X1Oy8Czn-CnIpkRaYfaVxb1DVHNh3Jb2U8ASm8FienX3VhoQOqEbOMfbTf91NgDVFI0CoVgpHAIycDCQXeBhFZETLhyGbTBQ3ZtcmWoNo-aNj57ku9VPfvzZsgqsmRR8OkQsM2p6xqgWlGCCULJqXQPMc7bNAeWhTOU3NHB21H6wrVIITiTnwLE59h6v_G-1_65Ok4V7WKpZAseJVp2hYDp6V_0-I8DY5gZS_tTtcsZ29VR7HWh3CbZ5N5WJDRGbeaSn1P5gcSHRTAyEeqaPMmU7AFquZAOELYxj3Qh9y6qS_vF5yjeoxfJs75RScM6DUZIgfydow-jUuvZOMYqHh1jw5Zot9UjMAZDQTXH2WKSMrpLdpGlbkZSG2WUsCS8qs4qM3yiFYvhOLaR0JOiQTAhU6GRuToAHMCo6vjH13pttL6TgpU9Kg1V8d-BbjUUvnrni5MouJjBSBGjAWIZn6Exb81o1VCTvY9nvCW5QmWqglWWbqqounmZ9BgcFm6oRtCcLWJJibXD5UEU_36Au5PngVnoAsgApAMMfcGiCXSCxNEx6VJcXo6eccSh4Q2mFi4wWiIT9q6gY_Si_ZuxKOI-dlqxMdlcTmtJwqnZ6zPgM0fy0e0VjKtI5qcShJKr6CkKWP75lnp_VjZOFkBs3j5dGByjJgIFd8HlziBsLpU3mAKBZvgzu-kinb0nnF1wWt7McsBx9ew7RO3hmgkwRlx7ciz3CUmu0PVFeKIjvh1NwQv6OgCOgGBBsXdRmlmxISipcSVJsayseK3BFjK5DgBo3Fvezh1mhYQMpWCZusa90gQv8XVHw7LT6gcSF6f_f1rBIZiY17pm69Hcg-PbOfMGLeTDuRF36WeZyGBMRC6W0VjwQpqtBM_QYU4AEnh19I1k9VemetY54hrA27Hog1MWAoh2YfJ_h_Ojn92AirDXUDE5i1-2ijpP6G-BUC4lbAgNK5Ls7548tilJJaBF9UUGUVmhDvWNve3AqFIiGa0LAF7aXq8X0j5kfbVtMLsmhtf36UgZs8iXU_l51t3Jhl0s7vNdAZ5jzeotXBROwBoh-4ebPm3acar9L96vxONv3sPs7ToiiMoXFH8wfe3pz_bw9IrjJXITM9pLX3NzaGKKSEIiYgMqPS8gHdhzF97tw-Zj2GeE9LtemnRZi6CZBXCQokfduFotK3bG6Ls84HGDSoH1ruKChz_aZjvImAkJrXbtgW6lIyg1NlPUNjvaVDNcT5Be5ieETPUpvb9MX6Zoxi-11nrFLKzucyqUxz2SLS9srS0v1D_321DrWVCjbd421mZqHr_immNhyj_hZaSRuzFqrag2-rpsOC7DagYwh6pTJMawlIljwZXvxboNU3IQtbNJa1lYdOJYX-wNI9dQVxKfExf9HUzZt6ND-tmfyAk3EntRU-vzWQAJqo6DARGKnzza7NVPiYZ6Xt9J1bl3KOINsa5F7GGvlzFrsYQjxd9g0ObZYD6Loom_hvvt3bm8vxYq-TL8e3R5-_YoHBG0cpHmaZqGZjsfuDOTNB9bslXIT4_3YtiQvoDc2eFMPPz7bdoz1zpYv-twfBUDRY01sT_SkZ60BgvVf0fOBbp7Gxtrp1EvUx4-sMiqONNAJB2-KU5-wwZfkjSTCUdROdMomrZYHkVaNMrfM-hyqFIdUJupJ_ZuvCS61Dz7OQvdzJKQGXUmtpyV0H5R9ysvqOz9m7GpR2aMM7bPBhOqIb2qzvJZnjwq_xGLXO0hY1Z-qN-9kOPRTzVh0YXswkH30EzgwR0HsU0309Dd4L4nE7YqGIA6wfJ_0LJk9Hf2F0xwQI_P_AeFwgySpqkY5kQlewMFlKJmSQLsUTuKyohvH13Eb9od0kdh05PuSptKOC2FgJPo2Qphz5nPj6Je-X3arfOhoOXKFWf2chktZ1eg6jtqsQY0x4_9IeMFp3el19MeF0HAWXCzc9b8Vo3NotEWFxyckZy99VNQUAMltQ4UBzFEuJFLD4McKUHJXZq9wwugENgeLHKpsUb_Sey0oN-B0mAdhrxUZ-VW2Q7mxNUXZ_tNr3Kl329caUMs2vFQPtyPk8f_Jkki68C6E6gka-D5gzw7-ZSodgqVTmdntjqfSqU9c0tvMNMUuiy1sFWdThlX64a4twhIgSgd6fum57u9F0NFpw8gtvd8NFRh2KcjaGHnHYMssYU0ZTt5XYrJuOY-4OyYrq2z2-WZLi6mYmL6wIyxDC4sOrhUh2q5IXBgQJl_8nr_I-1gL8txvL61qWHMTZ3_OoVSvl6abnlx2KXP0EefwyesscbnJDjSWnhHAZYNpgzK0qheO3GejYpincCdqcUn-bcJQP4iLeDJrK-DFkR7tx3XKRCa1f6kguA0R32BASItJ3TovPORSbUbnoTT36_H--C-sE9vWIA.SyWogXhKxaxbvYZjM7z6njVrBobCQO7Whm8sBSZcCLY	\N	\N	nHNIA9orRzP+7lZ9+vhEU0EzFEVKL88xcUTqTl9lTu0=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	5afe081ab0174d8a9e051f05dc1a24aa
3a1dc3c2-1eb4-274f-a25b-9d1024a1ea21	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-23 16:39:01	2025-11-23 16:44:01	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.joajF8JMwJfaChcrg5xJgujAQYRkZfMxvk2X-OB2hNty8uZxdVqjK9SJpzkF5PcEfgdhdzGDt6rYD4UVUqkpnl4NbSE2hjUhi5w7WcNK9R3bx2-z5kEHJ-X9-nqVko1QB3dr8xaZtDwUYSSab-N06q620nD2XqAzQ1wZeE3Q1Jcrik6tCLg6afWSkxYZftcI_zd7-MckRRzbtZfR_UN3hcFA1ONgsoxwuuuDMAG2PA2XnTghwpPXEyLcbT7twEtMRx2vHHHa9_wh758eqBgAkop09v3Vg3SJexVZaMCY3Zo1-TY5SLn8Wm-98FEqycwJbPXs7tN_hcQbL1XQiUZ_sQ.J8LcKzYRjvxLGAzHemGTnA.rOPgAeAAXWijc8lr-rGAaIEoAN4JVqdi5JjsYirSPgMD5u6FkPrQRWYmPdx9rdPuJudspYfIpcluJ1jeNKBD6Zh4PhGoGNnXI72qmN2ai1BOYB1_M3HZ0pgQCuxh_zUIEuNV3q0fFjqG1HU2A2fHofWCCMCfJa5mhl2tTmOKLgqoLUO-UA8dUQdgf41j2CpcDCkAA8iF_dz4YnA9OvLOoKJvn2LbsL0TKLkDEk4UFKNYcG1yI9nDR7PMSuR-h49Vl33d4sTxqja3_II8I13vL2U7kaJfTAuWnUWph1nv5sEdx25bVSYjsOrF3MpgVY8lnYy7Yt73eZzRRn0rUFnZbSuad3CDrjk9BiuBmQ9vx8XgiIFX_yMs5ULlW5McmIZyPP_5ik54OHOAGmIs4G-cMI-0L9ZdZOn0cS7YT1ESSnZIJ2YSONBf7UvBUd43Ee86o4I5Fgv6WN5Z7Zr8CZ_-axGiaJzTEk9Ij4-OTVUJHwv64Bi4VsAMw0peA6Dx371Os4BPm49BLxKFYUJWgKqzqf01YRf8hjZg3fSsLM01gq9o7kqzC8YfYaLG-LTxoPgxrTzPoF3htumgOA01bQQQ3kQLtf_mq3sYYKAvGwvSb9WoG_cEPTD1MVoGsxMHasUa4bFEePpLF-H1CYwJVIQV-GB7A9jDTZ0ZoovS5YxGLPG7buUP8JaGESKh4mHFLxd_feRAUsVucNNcSMfQWQHbeKiBN8ECjZ2szHQLF8nzIe2rparyyUzhTHLHbFy7aCA1gxCVp4KP6Po93lvyA_5rYjMh1tJTmWFIp48_CgvpUZrdrcYGXncvUTLtC614H6CaoxZ6GhqOJgfSIz75HrQXG8DOmGGHBOjFEUkkvupuFSog0ous6Ou_NWBrw9THuPrpXLSMJMmAvdLFZdH-etcKxzdi9wP5lkj3nEp4YhKv_zSDXgSOB9ypd4dIX5MSAMAUq4HTSVmej4-2Q36cQvUWtiakAmhjj9V_QxW7v2Uxy8CIodWJd-QAIA4kN4-8k61H6vl6aqP1QGR2w6ZVVC9ljdiV7Rharuu1x7zUdLvksTRvXlxwb8mo7BT_qef9WAZN9GiZJYRMwTtICEEl9XquqwEWExw55f0K2SV97IBDlaCIFjrxdIUY-AMerBhnFv2FsmJaBtvzHPZYVJYRXCJkqJdrBL2uQaQsMe4K0fn3cf-xCyOj_bR0E8Vpe0Gz5dCiTof5xyKSRa8Tj1X77PyENT3JilxH5n1LPl99uOcMSLWAlTQSLjajNRlUbdcyeiEmsSx8nalYb_Gn1Utc1GFlobz_yeUJlGAG7HLXW_AeHCc774iwPCO26UIUQgIcjiP8XQkS8cNdafmE9J7nJoavaI-W6ooODjwh5vBZDZaZQLZtQ5sEQqMN7wXP8NB30ZR7aOiHwBqUuv0ZVSgJpoTLNMGk72X6-KsIB08LwSrJ0zo1kWPBGBHD_OW-WdSJwMTxzWHicM_ThQAaj6GjqjYQ7YKzyMmv1dgG56s-rtlyLZ-zUr02Pv0Aa7n0EFj8TWhFPzd9jlOmZcE43MeWqYOs76lDTar5lfokerLNPq7tg6rZT-EQRTbFseIGdpLJOp8g6rqq3jHpwxGuNranohzsrK85zUqZDoQjVl-N9GA7CRA807ADccbu1BKFmtnrCQncrdCQ85_nGUKfzXza56p7IKIEGCVVVyCGixlh-v1ODRYGEnx7-351K-OqrIs936Dugow_NqBfIwOWcpmHqjq5fKU-ZmoNtT3QwePAlSqzhy64b5I1sesb_O5Sr0RyhIns3qzCH9fioAuY5p5qPS-yIGC6wWTFGKNshM-My05_td1R5dVSgQOIzZZ_-LNT-jUBEYeKzstFAx1xiCNoFCI5CFA9XO2ghY92IkrptIrpqUgYZYiapbYCTcEHf7BOJrOPK0aXy7_MusIz91TJY5pJ8ff8NIacFG5rlvM0Iogj4ViuWFYGz3OTQUt9Iah7h6AXf2PyLRdKIaz-6HItvVzmvSP76OimSXp5Or5HKKrsQNh9UI-0V5r7LrNo6hT5IX5LmaZ4yMlQ7AySmtBJPpXZZDCb1RsHyMGVyn3-tVPCVIM4mGBm3vuoGmSt8s4R4Na8twfky9Vzwh9i7DVFZHrbIr5QmYYy3h_QfzQkujDndosNyiaDId5XoMQTwZ0NYi5dmY6eFJ0Rh6ARGRCbFiP5raA2vZTsUq2KEaztzPQUD2UTDP6l2yzcznMtCBm8H0rd7uLZFg-Qmmc0vZQ8OF42ifngFnELi0sthP0qW6U1UB0FBVuVIhZZ3OJ0Or0pS6DrFI3MLIQ5u-bDxUpBY26uvjI7c8uPfyY2umbIFkmkBBapAMAaO6kRFBJImiWqhCVtqF5NroGezd-KVQYJym4af8vuvAmdBZIu0iVvUQxmk-DtvclELM-dwdS1dsT3QfbF6Kg9NxVbvyb4DFbiprpO8A.lW4ZANl9PNwtewk0kgwSVofgkGhNr1x9f6A4u31c16I	\N	\N	qtIzwN77gn+f618J/xaYHNqU2VGMDRh0I4gw1TdVfpg=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	8516ed74291c43eba82bad53bad79a89
3a1dc3ca-413e-f97e-ae37-d31b67b1d6b3	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-23 16:47:54	2025-11-23 16:52:54	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.ITnLVpABsptzVnrzA1ltLe-fkGhIgIDhq3BvmY-YhHrWQpDsPdVcOKolHur4uDDLmIXHDR9eHqQdNZqYsGtpVS6LH4FX8gWTzbSRUvi4E1sf-g8_ORufoOSkmHyvu1hI3qii27fLUn2FXAaTnuEuYVILVfouUmqq1T_pjJRGBTJKarei_jp-tIjYPfVMeeSCzpETHk-HbgtQO4xb9VhBUHl3T9yC88ZdE86ii8092aFw1Vgo12gtnbeQgSbkI0XZDA5J6SRz5awEXXABo4u4xEV2jip9I0jj6CYXiI5afNdaMEiYbpdxCmc8X1_US2RV5CDItADvY7Y2SeEO0DXJzw.9FcW5X0qRo1KwMyUbg7_VQ.GvM5cZYxs19mI6FsAIIGPltxGKd5o5KVFpzFn92CUS82UFl90s8qpn5wmG0CXHBCj9fxMLOrCtmrp-owrAjco1JShf98zG3OHV_TVHsrzAFqDPB-p5uw_xsuthGe7mdU9tXgrYO0c04rb4m6gdVy3k13S_uV7pcQVPHmEoht-aYnrP9pGUUoo1yXeN8RKdZhYdTSyFgQQxvYWrG1tXGXCDX6tKPlqOIheLCl71nV542ppOa7aiS_VzHgKV4UHIi29QrAKs8tZh1efnjqr4JdM7HR3jPxm9s9ZxzVTCm3MD-mh0XVRqqd_CqzAu_eqIn7JG9rV0OoYmUDacLepb0pKXF13htWULQYpUH1SW_eMDQ1NxnDmCTHBFFa-GCovCsnP5YLBsggdpmNHYGeV-r7iHeYjjcBICH6sDcfoqOWZHPFv-Qrg64Cm5YfVvM_2n84WtIbx-4TECYYhZObD6mHDgZP_VjPPaAjk9z8JRxafpWzn8hYa6i4Gl-eNf04A2yNm7D_jGexYYYErEFjF40X2WifDxyjlWP8SuNZbaeaU9bB11MsdoBHvhd2CRcWOuEhKY5K8RkUVZJvyujoPHX7WkqtJjguWNyTSQmh0578qJqBcUDR5mK8AkB3t4cnUCEnSDPHEBXdc36dRAXERmbGqs8cIZH_x7CztDpKreBQ_47eFtGAZ7-_WkT2b0EozsFGo4N_P0unWI_YQ1z-4dEQmlfxyhLgVuU_Xrcbdyv3Ip5CQlfyXCU2h2_ah1N_FUdRq1C7nVFctYkhLWBaP6_8mgE9MvqZh4lCrUWqQaBIXVbnogJ__KDrX5q9vS1_ghfS7l3r9OkDykEUqsRlqySntEprSlB65Vqy6yrdXWzF6GRC0l3966pbHIJtLZLXQq41M61eFJYI4KhLgjAp0EkuG6_D8I4rci2rxQ9DnPH5u9jUfUp-AH1iMkOp16A7fCNwO2MzC6N91R5F6AqbcrF4PyjsfSsz2ls6ZILqxN-TDNkf2wyQdGuwR-HFG5rGS-uNzJdOOTiR3dLQNtAR5pE-vhvJPpYBipzJp4wfVjD153dqnqgVmHx1RrTAoxDcN44T1wsPAlY33r01ZUDpmR28oqrkTbTrYFKQJzC8h8Er96Ps6q0JRHyIH46IeBL-h8S0FuRvaupkYw9GVASow2Bk-iwgaPKs9K2gvHvJjDL8PV-4TrP5DjgrenOmi3HG2K8zh0y6h4bWBXZOgfY9YQ-DvY3JBPH91zxbCQ21f5nw07UIjhARkuyMB1ziVEjKiY6zx-k9REXC5pbMUrpksD2djOyB4sr9SISnjU7BscmNneolQY_MVrgMgVggCVAx1SDalb42AqLSQb8zZ2DyLDxPVW58UlvVgil0_xR8ovQEtPjTR2ggli3yxDA1oWU3J2hcqQCpoBi0Nwg5UT63cfIUMW0xP5JgJ1IVlwo7xmlC-l5RgmJeTsIQfFX-mWJpdSnyz5uM5HS37ZHU-SseiPOq90rX3RfEADn6FkO1FjWebF9P1Y3wFwlvUn-JXnS6yEHywZslr5lx8fUDfJ6rtsJTB7sjFxAbetOj3mmecH7yVdGy69QI510k8GLdNt4yP2gN1XvpYFlixwE8DBngU5wrfVelUmqJuogtjJQnuc3el5deL-2U50QUFAs1-PfoGK5LAl2owit-dkqObL6v2sqiay-kPA9jZc9AtLceNWTbtmj9HtLl_TIv4MI5AefJ7TbmgLiO3kMXoTjB3vcxPXti3g9nsURIxi2Cn1SeRDv3fW6UPFkxVABYg1vpO9bMKWSlMAQG2qyYv88J4Cu3M4ZP9KVwTfhqqb_52OfUhHDUINYk0rb6TEdkHZ5kgjtbflK2CAqHBof44EDww1pn1SuUy324o6JdubQDPwqGFsne3B_4XvmLpoi967ILiWXag44EEeA-g1rl8gP5-SSr3ZlFjxGTBvu2bOERVZVw7l_YkPI92d3IHUgfU1ObdwvbaVgQ7pZsnWn72LADg65-JKg9Nhbm5bWrl7F0AQ4bFV-OZvXXPOH9Tw6W8dzeDhEyva__MwHZOwYOvVGgHYDA-rTtrxT12kdSmBgYdLc7gaXjh6S-oPZMqHKh_I4jksc5-W2CqnnRToGL-o_ACngCyEPIIcw_RpGMt4FTTAxSYWnKEDAGQAyTaIZ1xp8LLtUY7_hNFL54QDUOJkDxsYVqQZJp0yzsAXJf9vca8xCqslfo-kaPw1DTce4ZNSmdf2XBGW5xTz6cQaWgAKHb-lidjGbJdTG7sfwcp-i1wYY94YVGP3v-G85EI0I8hTGP7GFYloq18n4PiequgL6L5KV83MTOVwDtrDcHmhqQr6c9Pu86qvemmhNdd1gX0hFcgH7G6jvuPBYRhExbOeflDGz_p2PAYa7Dfj4vwtS88Mw3S-TuNGalptIeMIGJglPy4fYc490oNmOHs9Es-qcMUHZtfhSL6A.tDBTXek_PgUN2JL1rgWjS9BxqH63gLZ76ujwyThWCvA	\N	\N	ZeVREedvPyQPZA9y7emPbGKj1eOkO7Vyiq2eGDMjWY8=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	912e64a154844cf887393e0df31b4ca0
3a1dbcdf-2551-712b-ebdc-044e7ea0ac8a	3a1da2e4-3191-7923-a780-699387b8fef2	3a1dbcde-fa38-6da3-4cec-3b6b954e7c30	2025-11-22 08:33:23	2025-11-22 08:53:23	\N	\N	\N	\N	valid	3a1db416-b2b2-3609-98b4-058d6ceeb9d2	id_token	{}	3ae1206cc35c4b26a16f0d3fef6323a4
3a1dbcdb-81c1-fecf-e255-f80d9b54fe71	3a1da2e4-3191-7923-a780-699387b8fef2	3a1daa2e-4a09-550d-2d70-85760204b9e6	2025-11-22 08:29:24	2025-11-22 08:34:24	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.nlhnt-Chh0glpfzP4ofXZeLoZG9873bYwN9R73A7QldhyG-EYNGphzEAcpr9_7TMghM-m_x8faonwqq8bob7cpNwnJgkYZWova40jlygwNNO_of7yc93RUjR7qdMHjWEsUFkd_XQuq_xQuJwyHp_WzpuzqdleItRK-sQNL4Oz0VODa4NwaXpzB2eYuG0QqKPWi_qViImI6uJoLCNU3UqDFZQYH-1aYFkR195vys7Np0EuRUkTuc61ojjsLzRyyvzUUjLboI24dBpeCDhPbKvGGGCQp3Tw4sIYz2z5eN4JwsjewLFuCmodoi7sGYglPuO1N-g9cdSKcCLVQlHDFyT9g.FKuuhcD9DnwzD-g4FUY4jQ.lE4_2Q8CHPejl3X9mtk883TdszpgD0_Yk1-1U1nwHs-5LSbvsvg8eqbfLlisVcw9wdUq-Fx-MI5FV0pie4IOEKSDQSLhUiBMdn1xrLbfWi2uU5OeEUJpfHl82DSWRH9EktP1mzoU1UV0edmWRyG607H76k7X84QYMfvl85b1tGoZjHm-Cid21WDhloufi61-RJzzGM34qr0kgPOYIGybcok236j1_1zSkh56XqB6ODG9uQLySG21sOkozL1ryTeoCp-rhEV6DkfXkZeZjdMLic5SPXTPoJZwNjkh69rGbXyq1s8diVA-QmdtJk3FE5bEwO4j60c_PPks1cRrqLn5_ZAgSYwHIZsYRgPRHMCrwWyoBqQ6gjLco6oBcUI_fSWOlwvuOgKgwKLlj_O1IooUDt1XcWACaTfWp2gmKlyQ1HvMW3vMbXwoFwNPPjccGQy3aYMPNyUh4OOOQthZI9oNcVQ5acEVDYv-4LZlnLycB717rKx3gVf7WEhdPR3iKkldR_V7Sn7AsSpcyBTNSdnzHEcieiekCftYxqGoAT0OW_lR1vNsKlxk988USRqZ_3yrWQDdDSTNIO6K5S596vgPXaawJMyQYP70mwsFA5Yw3vTnXfVTlaawZNIZYOEHcmH9_YWA5a6qBxB1lwYEYdLk2nj1FSUn5s83QjaYpehJZD63QcmekyjWfran4nau0gE8LDgrVmHKO4pOQQcJbDpScFRRE9_58skQ9SaxtLAJY7bQOZyudWHm43UHh2qy6AiqObyB1nGBcqOlX3U2IBBEZpsx5R4yyttfZ-PfMY1Y59YSWXR4_Z2Kxr0ZZQ-9ZMhQCbsowAGWEuQWZLXp2eTp8zFEEcaXG0QoEG2dOjqdNE7dt7vEFNI1Z1s17TPBwW8W_r4HRn2pFiQm6Va69s6gNnmQidH7Iqdpq2FJRj0kVjFkbtlmK2N8roDU2z0KcxKCNkJrcToJDU6hipRZkpM0-DN2r__cBZk2Y4xFn4jvLMHpneVtpwfqXIjQPNeFO8UBYkKloFv9azj82ZM9yPH7m16TWNjDBad-f8G01VtTjb1j0vPJlvbjOV762DwsevPzc_sNLUYrM-zYmZj2vdkR-3_m6o7WFi7vKBDH_u54OP2HvT6HhFH7Dd4jNsolbcI3kcIn7PdGbAplxDH3DAbRotkxqAguQQMPmymgsYzILZTn4CFQhoOo0klt-QpY_NlqrJ_S66eTCWOdIPa1YVclSXnV6gMEI2lPEve-OBXWgbUd9hKtgNuFGYeU91pi2FMNUR4vEUTiKft-PIK7tRhCwafWG49V72glqtaq64YRFsDxGnK9lbYlpJufoVD5nV-eAhnUOmNYcoGTexSFtKU4Gqft1uL_OiDeNElX-QrIk2KO5P8lfyfFgGduyPV5C8gCCTGLo93NnwdUuaPNYIM7APPsMsmqB1BusA2F0umtrOaqDvPUE3Bp6po8Cx0fbHXf7MhNYPTJHNNk4IRnLy-0-3FI0O8CJF2LTLBaLJXtm01X9RMKoIoVgcyoqPsAhloXDMi8CwLKEDUBKtlTNknJ7tpG3oPVDFefIAtXA7T8lZg4W2AUdWyxr-voI-0Qs7hJWJR34WnVQakTUuCUF5uKi46u6M4y_GlqN4gvqkigfphm8AOugk3WjQcqbxozntyAFWsDnvJuwIRzw0A6v7bOWP8wtVvOHyXyJdhHOOztmdTP76umZR7YMQwY4ZKXVTPGLwqVKuVeUorGtp7F658EWBBLWcBOLA1u35O1_mFLyTX0_6OduDF2ufzzYcDKbtS1s6UqJvqw_8tisamvwdgEuqM6JMfvUuoPE03lGyCZQ6CSD3hDftxvTrb83yqWx0SzfLHP9aTPkCnJ_5hgPlaJl1nfSB71YEVyeAu9p6B8H7ZQiN3F0cnpxgJ9Et8i1XqheR7YyUQH0JADIdn6RuXs4OFngnj25ArrMJq0mNKkpCRmk-mKzNOP3T2lEwGmXTeK2NbtZnd1NEym9ZUX-3NfgeY0Aej1y8ZEUjBo_5upV6_o2Dq0yhpSNPU0Itk7pam_J5PK9DFOAyyUaxJ7nKVHjhZAuPPZ55K9q5NoG8OKLzNBb9kmnBcUDPu2D0QKZGSBwwrTGDo5lc2dH55IoAMTEMKC3zKuGqXZj6kdeJJXrRmg-ETVBrAF-BtmcQgPPJDxlBosUNhDLMaApnAXA4eFpouD1-O6AhIkpnbC-OqMzGDKuZFOaRZIov1sq8cnVsxS4M3iSTmNGAexAD91WoL6Oz6vGk_1KtvWJqjOrybMg23K07Z0L0buNhOpgkMqkEagzAWJ2E_nVoUZAqyUrebJyA6YSlwmqjdoc6Tp6clXapkB7-NDtjPx-a-unWBSog3MJb-bPPPvI6ROC9QibL_oNAZA21GInSzchM4pwGXIoAmmIhgWxSa417Jj_jWVm0jbPU2tJRIi5dKd9nK0vzJSlmCZ-Hxie4UwwLikhUd3lIdBish5x6QPtEuWsnmnmj5QVpWTAx4OtpTBKcCDelNymzxO9qqUVdv8NAcaLVbm3nBi-HYHVNr0nAjx1QUwDj3fjjGJ7yJiLsyvpgmvh6e4cWzCHhI-JFYfKRW_9BHRuAZaykVawCzmyBPhbs9zoBJHVcXWEMNtB47SczKiCKSyFahFPqQYuOafn0t4ksZeYfjJBvhnBgwnslSxMoArfSFkqHzkD4gxn0G_MBjB8MY8Hg7YMIGqC-cvkmDBxGXJzPKuSei7VFrpOP1ilEwnDnuS.FfJCYIz7SYPJbeaJWu1U32CiToPW7Ene7hwsoX60B7g	\N	2025-11-22 08:29:24.918655	UObw5CNLvi0Ropg6nRcL5Rn3TRIqCSGiT98hJMmRp/c=	redeemed	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	c1096b6841eb4eb9b192e4a3a44acf2e
3a1dbcdb-823f-d076-1ce4-35dc96a6c7e6	3a1da2e4-3191-7923-a780-699387b8fef2	3a1daa2e-4a09-550d-2d70-85760204b9e6	2025-11-22 08:29:24	2025-11-22 09:29:24	\N	\N	\N	\N	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	access_token	{}	fa37f10a2c6243dba987e08bac3ad2f5
3a1dbcdb-8249-0588-8b4f-7880222c45cf	3a1da2e4-3191-7923-a780-699387b8fef2	3a1daa2e-4a09-550d-2d70-85760204b9e6	2025-11-22 08:29:24	2025-11-22 08:49:24	\N	\N	\N	\N	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	id_token	{}	c122df1aa32b4a0ca3f1e7d1803db51b
3a1dbd61-d119-5d3d-2cb1-5cdd88ff6bef	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1db955-e21c-697d-db53-2a221a850fe3	2025-11-22 10:56:06	2025-11-22 11:01:06	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.oe8I8grne1PRUiXZXrQ2ze-NY8xFY7s3tt29aqLANtPJXBmmDerX8TycQ6t8a6IZ6reI4DbOxvlqnxjMvKAdH4jCoL39p4tlf7b9HkoIRCKilfAw2i-NIaCUXZo23G0AZW3jSba9SGxVmw0agxIsY_wS6eIjZzAltEEVZX-NQxnFwu2CA6-m0ychLZebL-Ebnw0WnqE4G1DQRjUmVhzoyRrYve24zskmfF7VIKlgonnHlbSsKd4mwiK-NiT895Fr3x9fy1odWoiqsWq3H1TEgGUk5hZSzCXpThAKrFAwGGnGrAicjFOExG1hezlZHpv1QnNWqJStu0NbVcp19Mb2hw.vMY3-CFJo_eiSbuAJggv0Q.J1hPZ1yakrAsOpEE2bFZkhgEOO7z8P6d4K1d9ieIUSxcKjUSbwZjjWQEwol_BGS7rCcSncbohgBJXuIBDiWhljWxJ4G04sTruRdIrnAwxAhVXglMrscm-rt0DsuA3FO7Zi6jlfyCNLbRNHHQXbFVHzgaPnX-kLrrWwQc-THVqKtusIzrt-TVyJIOHVH9p3t5V8cHO6aZ6F6ZMDyycAYBBdwnZtCDcd9OPcsuHcXSVdnDCzucHjuN5My2NWg7Xcc18uzQqwJJxgk-5lPXzTG9IndH0y2_Q_KHEgOE0EPJJPaKRXOAZ3PMOoF8scxy-Qb5XE3xmer7mKcQwLwz8vSVki3GebO9i8e6cllcFsY54vwmcmn5V2nkShBwUtFQHogyuwO8ZGqXj-o2_0IN4c9OxlmLjxSRf5mfbKPm4P3_olzgpoOF9Oq0nRhT6LfPzB_c71BDAgxs4mbLi9Jj4pUhSFcosKtFqCsO2McBJFR9W70Gpb_kQ97wQ_gnq-LLEjSd7k0bFJybYt4wGUyBSStOhejqddFOD89mGo79utBp7pmgJW1U-MaqQ_hsUaDTPvuELRW1vQfGPkOPaxg1J5cnVJ4H-Hw9rg2oiKyVMrAiMiwqeiol_ZwTOGEulBfT9AiZ0ONMpCCsSRW8w5B5bQ7wFtNM_6lrjTS_1o5o1OjmIe4EoNA8EP4WxNON1e4Qp-3fPQC984y5JpQkJTho8Zt8dxd8jjZkciCKiEUwoLtq18lVSPwMMTat4bYOgx6P2AFMeDcbMYeurzk16fssv54QH_6J42F0lBRIw38YLUbrk4m1CZpK3fTs3FN6oAbSOp5L_VZI_RCt_T0UiOX_YC5pRtGzxiNCLzkXy-T7U1NfyFAM5jRANGj2KI1a3LFXjAvZ5OhsSVpHRDU79UXG8tG5q8pXmCr8ydXJSX6pcnxF8JPeCDGL0-rh5LZ6BQXGd_nDNT6PgrHefhIg0CDEjErXuR_YIeEnStjEyfz2NhvgrSMpf0wCewFG-JP3BlFaivU2l-L1xK71SOHRwV7IOm667uFVLMQp6dInE7LmrFnEv0rvoVcgC3wXImfiIMQeSnfGu5e45Tcy1LkNS-F1ojhGFyTxZIYO7iwAdYu-qHQ8J1fMQjR1-lcwdcb27dWMt9eTbx5X15sq1qWeHnXT9n3VegA1jD7rNKHYv2svK6Qla_TZrhBXTDA5xIOyWqTt0-pBswcgimR6kbiySc33_Ovx1oPhZe39O7gGxV2Y4flyUXZRq-vqHSgKI3HTSLRK8yWRKhntbJdpBvEIyRxqXN6bVvHO2B5HTVAqu_43IuYb38jb9S2ykGGancsKJ1gxj1mIdsukb9jxwF1V8e50a2XeXhbDZRI_NwuQUu9f5E18j8dRzT4qmjB2kv04VL5G58lI2gi_rWs6Fr3-5Nt9d8InNxcTC1iQRRxhZe0cD1oAWdlP_6C82szyNCNoRB3cAoDDQaohe2aoeRALGlNjbnLotTbngsvoUbP8uNigQ99eLmbGlFq57npeUpgEVOPFr3HsqRxar4vKPJrW058mSFnI8MpbYtN8CZGerwSXaHsDTVEg85SpyzgY7crAfok9mlAQuxiLbKzwONWCBcm66lhZ72oxm0X_RsrZXUaty4Y1pmjWcYpjkYy8_IaAef2fJhLMK4TV8KE5AlklbtFf3QjjrhqGPiJt-SjbAV-6FneXRErGkrEevuvkkH9vVpEto_gXpHyy0ApTMCApKtT_q-m7f_9nZM68aOPFCdnZi4OHw7kpG8OLuzbiS2vJ163XwP1UTvzrRib0vFuFC0ueDrcodoBd7jSxeC2bq2A_AcSHfiutK9WkE5hdgl_KjguQmwy-igKAsPEEzI8qik00vKnlaTkJywkproG6YTeWmldhWVxQ-u-tqDYMi9hwEKqgAxDCL4ShBpXHjI5xMMYeH6_asMZq8Ye8ERyrj1lFTY31Kvl5M4gdmYPWuXXi56DP1DA6xNAqD8IKXoE7KqshUlVPzSc0EMpjk4pWJGcmH8txv1TpmySrdr1cf0XljTxZWS_YKmxLra46cwXIEwUertrVo6npecs0ZQ2sQd6Kp7sA_wE8zvUkbrnI2bDbKF53oxMSlTtyi8Tkt5jZs9Qlxdmj9fyLuB-BLMcSX-h6DTxaClwA1octtNYotBjIIgnonwScYAQVUvqN8IlbeI7eFJXvgyKJYH6faJbqv3r3H4aXX-iknSV96OnmiROSN7ZG_i6VHY3hMuRtVNjuPuPFaPL38jzPKJqYxBW66WVRYztGmw_oAMi5Ofhx2JPA3L5fuXpmRGYwV1XZM8MHuabVTXcMhzgdl585-Emp4NFDFf2EnC5VajuVK_1BDx_VZCD95U3jl8Mtrkdk8QKJowPEf_g4KbWdc8uCE5-BjWs-gg13pmoIn8k_skUoj5uWMDyCSf9MGpEBPAWDhoTj5vW8626Sq6UVIKs6Mbd0y7VHFpgKwjXuWL23lqASryHBLXNPvJczki2t3Iuav9Pw_5jIyrk65ON0DaERnRHEGj65-KXY0JM.4Fks385mqtCLBNmR_qJQ0IOaC1WGQPoNQ6ZTZ8R7gb4	\N	\N	hs5Ctn1f+5vPBdieZ1Xpm75VFIlYIZkyNjQxktFxukA=	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	8526c4a936a04e288b32da047231f6f8
3a1dbd66-b29a-8947-51bb-39faaf71b3e6	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-22 11:01:26	2025-11-22 11:06:26	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.NBkcjhjsNmCilBHJ2ca3dU4PKjZXYqx_ckgOAQN88bgEx_GeYqmuTHN-GknYrgOoN7dvAaKwIbdQILYDBkmtfVM-D_gZQz3Z3sAkH_PFWa_dq53H2rvW7htkrkOflcw_lGC3t_X1zb56YcVAB0z3uk3UnV60ufXG8RI6HVw1bBUKStqLKdJsG95_Ket1UyVCwBgi5EHt6FhaQ6vDf9b02TlDlK0Mf3p0App_ATFenSbTy4YtPJAD4DIeHO2XdlfyiC16SlpWqvbiRuFZHc8m2roJTPly4QwXTdWFMggvH-seNp42jzNwudowTbzHLh_Vk-dwGgNIq-kB8xUrvy7MaQ.MhkN2Kq88OBmnkPzepxHnw.nn77YlZeFEGIIyL2T-yNlcLDbt6YFwgPIHtXuZxEg9vUdzftogbf1iQcAsE0L3dYDq794Q84T0JEnogS7IAORQx_lXSe2qirMrIEeqRH0TJztb4twyJwd7rS2k1vWc9EiyvcJwxM_hnQrqVk12gORM6IpEGE7BsJEEwTBwcgwRI_sgz8XdS3nPDY0IW-mwAFJ7h2zqYmIDND6G1Fhz_qQw1WSRlHRQNxF7CnxALEig0kIYGpYdfOWKAo5RERbaAiBOvWLeGQKH0von-2VLynUf74m6_L4q-dPOt1e-BvdU2kQPEqx1DJZTh8dHsh5oN8ToX8qL-ygd3z62V6aVbFLgbfjHBXQh0MfYfuU9egJIKQGaSuLC6NAjWXO-aCWva9ICw4Jx4fNm1C3EoKI8qDUjfe0SG8kAKoO-cyyjEXivkpPxfnrHD-ecU8wGtHkXGPnd4nyf7QmOixElPF3LPreOLzruXMO6vqbqttAj0L9BoUO6VUBZchjUzV-SjweK3k0T8n-z54wq0gmfre_eJjyHCelhD7jD7TQjibnUPT-CVjljyEMfTmIE1GiHnvOObmXtd-jVN-ZdIPoxuDZCIA2Yx5xHCyVXgcrOfz688IJLDn4VnhKDExFh-pj0206s-mP7HrkguoqlIzvv7sCSuB_W-8PpY4CoVao6qhEJpJVgCEfIDdRVD8VFBVcrRur2J26L203aMkTSXx-l1paOTlsFNQRJeNK_3PAYR13xPdlM43_95zNOVS7OqQCPl5q9PutZTUzenoJ8qRmQ_Ts-YpL0dyeTrXUl2AKCRsImd7HPafFoWJ_bZcl6hhBQHPA0Hv_ba2opc83aJ2Slf8WHl8WSVIRfTf8vyaY_ZaaLXBS1ZzsDjWv7lHyU4RX5Bop3bgylRwFrZu085o7CROzwtAosDaXdoZCgV8dRSB95Py3s5ahvIMUfWzEIu_kLsiFKU6yQ5TjmJvWCdN8TL_RIx-CGjctppr2nYg0V1XWcTzb6MlfcALRHIt-Z-OgXQWdh8YG3TBuBv-tdQcunmoH7Ns8FsOlVxpmT0Jw22tQPSv_ljqu-0UVUtWq9uqkfksK-KdUiF88r79V4bTMaJ1dhpjS50PE1jT_oUbuHXlkjiHyRMuiv1msIbZJPK1c_BdpgQNHWs-3JTxBdM_Dkxf_NT9LwuXWpJKOng3S54NPxnMNjsXtPAd2LoptcYX9hrtKODgjw-urskXfgcX2pIOcwmlywsTmuV28ILpXbf6Sj93Kj-hWr7yu3i9uuh9mNHNym-Lmk8ntgMvBWEfB5FSLYkR3It2U5D5blluwStc2FUUlLjqIWvTfRGlmSqurMyHCX3e1yx7rrN7GcsBCrQAzqJtP_3BveL5KQfElwl7vwMwbk1VbdAbRPTsMSuBHUx-t4qo8TKcIIerQ3-upWJ2k6JKFN1Kd3EqYaaLzRahWYjogduGySJipIDk5tda1RNccLZDqHGsaJDMO-dmqFoYbVd-gtMr8YHEnbnm2tfVj5-uU3E5GzNou2p3kNIAPD0yrKLbQ5OALVrSMoG6DjcVksxICYN1uXJDAByhEAygWVvTpLVyWmaPhmwxzwFGObC9fWkNoRYgjVpnw17QDq2kRUfN_GypW5eRz-7Q2mbF3jHdT3TNDaNGyxiraa7DhWq6AH9wnN1Tq_vcgZ_JinhBgn7PEw3aKCYY_eQQyfWK0XPjQYAA1ytyz01qQpf0HxQevmuMNY2GyEVuMcR8ldAYgJunqiwX-MnOmGoxyrcTJ-q7dEGmPU6DG61C05HjgCH9Mtgf1Q44V78fN6_C0xbVir1-hibPHBh52XIp8Za_FGppu5uhdqeu-NjfqrLN1ApPXyZM4DpBJY7CNqBS0glxHkrjDktJPvfDcfEwLkhmulXCUPTOyUzmO7Lb_7kpygQn4iVQJXGfBxauUxgEC1mFI_LnX7R7Gt9aDUC02Uf0ImWpAG49o6G_08HvON_jTDYaBFLEurzge6yzGxEiRs-AjL0wViem2SJV-jfbnSnZ3A8K4UAVF2nMQN6Ldiu2Z32UtRnQnazm9eboJW1Am3eKb7yR4kRI6linTRywZgQQIazggAgtgh0XzvqZsOv4Ka7KHQpItvb9GWldRj_IHB040Ul65EZt5xfLOs0bl4-EVebWFPjv2tV_8QI026wj4pAWfP58ovg7slF7lK7_qR7RWW6XWhKKG3h7pHdrE05Z7JefgpbVFG7YxvXSRoBD64GS0duWZRSu88OitGCJzxETUDrrXbCJsGnuvN_LigpO3Av7Piz_E38_K5UBX-5qgoFRYxMpYHKimrXM_mRkUIvelLGeyONfWe6hlWmUK9CpWOne08X8FZn5OFJlzLktlkum8W0c132NrRSNRzNtOBRO_HNIXQfoPyLK3-4e--oBRP_D4ohBo_W4YQGLzQBuX6dYpty-q5NV8k9bC2nZM-HAJVM7mQ.33Y4iGevR5xbG8dHbAtQb0s3x2E1XbfLRAWt4EcaYLA	\N	\N	MLkNGN216vwDibZf23qZXNRibNFTqpEaijU+AQGp18g=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	7e3c273a5e564390b21a913c1e920e27
3a1dbcdc-13c2-fb8c-528a-f48a146b3c30	3a1da2e4-3191-7923-a780-699387b8fef2	3a1daa2e-4a09-550d-2d70-85760204b9e6	2025-11-22 08:30:02	2025-11-22 08:35:02	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.SXG2Vav5qWtnOLhFUJeBJ012pq-Uj77GNN5aaQdE12j_Ksk-o9z4N_ViPstkkgdsgNGZSm_D3eh9F59EJbnEnwLMe29csizmbnQpyuA6oSZ_e5VzC90O7MAggwt8R593mYyMTen0f2xqq_ZXrJgkycbh1m1bnkS2LZfNallM4wRSf1AEh11gQoK1vZNnupPjfJ_Ti1f2QJp6Po_B4tK9PfITbRDkME8cBWOgNHGgqIR9gxzW7CnnM-RQtAX9jZQUVETou07W9z6KG8mSHGNx7OtkUa8_O8DyQkE560Z-mbh2Y5KHRE0ZqJktWRqIinVMPzJljAso2h2pKEqaQ2Glsw._ADf7jyvyQ5odrtqv5o8NA.1FreV1EUFmXVvuo_U4t-80-gDiWO-sLnMj55-bgy5sQw5pS09XWOMwUnWOXrSrLOx_MXPof-8d4p_Qj5cHJByigRrQeRNVRsG-sqKNB6K73GC-ruKd5lZeZh3kAciX86TMGcXK6dyevuGIfloCq4AR45SD9wDBhUZdFJNCKPMUsAP0Z_rfeF7sx7b7w7s3puRLroDfVs0HVNJsHMw8tT6SQQ5wQEUtKr8yUcAQOaYqorS_lLuHViPYrf9pRGWgPg1EA_ScYEvXdREaYli3-sEjZV-yYvg0ePDLL0jimVnS85vSenfdDm2kGNzHdnvRT2MX3OLzTGfoS-IHU3afIDgvbeeRUpfnhj0qP9ENDteRLwa_Re6-yOlkV8YyXui4KFnWiVpRLFpDxDUECam-RFgKUN5fnoO8MNCv7jTCd9szbK7oI2atyokhs3tAr93rn4H3qn2PPoEIwQzwvv57rHqbaffITqK-gSAfGV4k3eNa5jw3MBePsmnUaMJm4n8km0bHZlKfzOUZ8VSva95kruM5kYNNxjlz2H6Yz5Fbuo6gCJpgIR4c50oW4sVttFZC3a3n0GQzwUpszMkFFLXiZ-pFB4x3eAjh5LrJAZX3P9rNqAIbl9Wf4GT9V5DdYmh-K_yD1LkiMxjs3rLg9FNSdQVCkGn9sfeAcPoiXZZUJyzgaIE4QAvjDcwBzt2MeVV4kPN58w5GfTCOxu7FkkvUKbXyP1RFJuuYEpWxrLQH3Hk-LYG1piFJ_sNvSVM3pJyuWAGSTGz6ZDHSCCDY3Li4j4nSx-9hZBPYSLojdNCchuN_hLqDH5MHMRSYug3DOz0X2qf2tfXAYujHbsTXDG8FNjIIPhTVEF8rLOpJ54gKDP9o-5BnJmPlxz-QoTt1oXVUUZnC4kwMVisSho1RCE8c4XYeiLneLNFpqjdutzEIGNFPFGWXNC-RtBe3ys8dgeFQ5kQedhbRu3tz_B38-mQ6uaBz6Wfz53PQ6zunp3r0_pWl6zJM-W6YZI-gCDZy3u76JOzXBhYDh-2pZLU30e_XDYkEiHPg7QCi9hUdfOebGwYwfHB964dBF5pcTuAaSlgqEektcqhRtXvYv2ZYVwNtlaDnMB5a5gkK7nmMapoybbQisvADknssjA8QRXk1KE0zetRGG--DEQCTYETeufVcWQ8HsJ4_qn8p0Ijk3g7af3ei7G_qdw7oBU5FuvzA6VBYkgFPHMnypeAyVS1fQ56r0KXLmLnAk0cTzq-83d-sW-WolYT7mLCg9WU_r6qkwOp5WcJDlm34A60g_xIZ7qAhL-YSplbSSltXwa_m_IbQ8-eJ1Sje6VUexby9kVEB-_4aEdVQ3zZ2S6Qs53NbPAxOEOK8TDQxo5skRSCtb6rODP2r7SHSPATEACvuKhqxgNr2RfkCCkCiHLwwa4dHwmA3LRmaPoT6xKn5K5HtT1_nOqtQYH8sT1uQRItrTJETYgwW2WqgMYqq2IJ6LwX5wVpNSbaMBWFXEQsrlW17SXGZPMmlre9B83TLa6C4mo_W3FpOOrf11NjQFtiJzUCQRgd4pFRIFwgM2DyhnyIQjC7LzHk9tlZNj_W7jlTAqD2mpn5NSOEGTFH3F3soM0IxdTdYGDF7mWYHA2hNfz8FQsQt6B5Z3ROFMaE5q_SCMldoJEHDyAy7qvp055f9yvo91IRilLMOIkvfs7fDxcNz1wNL0aYPvYnISPLkpOQbe2B7HmTACQDDRz-lZOKjWRsNkNyJtqCbnGi7TwspWKVPEGIoox10UxTtyJdavSKcOhHQbHz5IGubzcrTfsrLAACRtjlj-PKfJ9PPKEp4iW_TU9wxKWtJPUWnvehrfu4nBJP49aZ3S3al2gtKZY_5vbZeYl6rwcQqo-cCpqsvPH8dKqrs-KDYaA_Kk9ZZ4MRsSUqjODlo7ne-SfENHwYhai6Zb3sN9MHKbAGcPzeWDskP2a5qqv2bH54RgfONi-i3iZBNkBDF_1JdjuYhLMDCvfbtmJCyhsN0QICYeRKL0j1Z1C_eQuW8tFM8yfjjX_7axVruNmjYhVhmOq8nrv_Qxglf2_Vuw031GiwAKRP_jvs5YLkNjC3kG-fWT_QhFIBjCxxU__sn34JxMbkoVYJ6iTnlbmzpNrPRD9Ecj3f0fBLXcB9WXCHc8310pMPDW2fxLjADw_Zh3YFSzvl6w6CYA7-CTHlAnwp7VA-fa4371KhS8Kz0iOW_qqfuLZ4N_sQXx2xevDabUmw0nryHDdDO0R_02_knZIEkeRVUwV80UnsSxpGqc4R49_A8f9QcMhmG_TnPxm8e-pJ9nadG2jDsrsYzKu6ftvLPu2COXSKUhwtnwqlvsoGlc5s-oDZVAzL-75PJsm4EwiLV0WenMkSqqcEzSpWf2FfsnjSL6osfVbZe02qBV_pnB811Ao8kFGkywATGVKsmqde7sq0wSgpLdu04SNT7zhrsA-PK0FsWYoYLTT0DNMmSjoCICCdMfK4XVevBoJkkJTAomO5yq265VKOjllk-l_VbvHbOwfv3JI18Goz4CwVjHhHeeU1_uabSjLQwnOVYONsrCbxIU3J-rxpcPjEunt6s8XCBwM1XFlhEMKI2fAPUPFGBqCOY89sof3eX56ZkZOxUjRrGvtncomDxYfZpK-gMiKxOIFW5S1TfjT0j6ZSiyh6S0uuIJLnbG81wuoC15uS13yGBivpBiJcXCsHEbe_XJmLYhMI1TUwqWPd6Sy9GmishrZ5Xx0Q0leBuR0GbPD.FxbEQ6DedxhWT_If-PoWPiy0xMk7G_ba483wDQiuUJ0	\N	2025-11-22 08:30:02.317977	0qNBdA1YWnEqeplsqdXauriHQu47DK1NWU8KIb9qMjU=	redeemed	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	cb87eba793e0403883ea37916d030007
3a1dbcdc-1456-46a5-730a-92961b8d2bc3	3a1da2e4-3191-7923-a780-699387b8fef2	3a1daa2e-4a09-550d-2d70-85760204b9e6	2025-11-22 08:30:02	2025-11-22 09:30:02	\N	\N	\N	\N	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	access_token	{}	c717577c921f475ab71dfd23a4462c81
3a1dbcdc-1460-8cd1-e016-90821db430b9	3a1da2e4-3191-7923-a780-699387b8fef2	3a1daa2e-4a09-550d-2d70-85760204b9e6	2025-11-22 08:30:02	2025-11-22 08:50:02	\N	\N	\N	\N	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	id_token	{}	7b4dcc5fea604955ae94523a637e7b68
3a1dbcdc-023b-6cb0-971e-d9d2e3fea3b9	3a1da2e4-3191-7923-a780-699387b8fef2	3a1daa2e-4a09-550d-2d70-85760204b9e6	2025-11-22 08:29:57	2025-11-22 08:34:57	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.SOuWHe5NZnuTZFRnp0qHb1i0QEaJ2y6uHD1hCXvJvIHf2OgihJe9PMDA19zsu3O3jVDE3HvmBpN01Eqm9DChbrtm9O8rVKLaBSqwU3JCrxfBaUvJcHej9mUypFUFtOINufMpUmAjh8nsrVvdbwmsqyPyumwA5h3vnoBPAXMOXDFpS7qOyGeNHgY9AJHIXO1VNFafeMcYkVtzN0F9rHBCcJfcwVT5u2P2X7mZSubUQW9GVMXj_paeXtTcqVvq6h02nCLWFiPYFp-_3dBZHK3LapIJapNdNeOa9OORN-vDoVvNDhvvar0waZSyDK0hUYZsDpfOzLNScjwJpT5w3AXy2Q.jGaco8OWWJluEdUOTCF3JQ.5KO4poSQIe8L_cIL3HDtsogJFZ3lZCJJ-nscQqfc-l5WDwlk-uCY-MY9F7O6eigMexJfzDyC3HeZa8WsyY4pdfHF1xCq5k6b6drOPbUHaM4_T5wv21B0EccBRx8N56_v9dYUcS_8SzsNN3818ih36qp1H43XMfuffF4IX5ZT2Gbivt7BzrxIroDJK9vaPPapVdmJV6RhNSYx9ahkrlycETEjZvTqPcYPR1F-30mHykMsU9OXR_SDgOlPoNh5UjXC8ckXgcKAHA60OV53oVrXZH7lATL2g2RkFaYABhFCH5Fr52_3SuyBfb7cRrahiaTT_hz6gCO7_lFWCTj5fONIdUMuNlfjAEZUHu4-DIt-KgySFGXKOKq5E1b4VKl71Ou4pw8hf38snguCQy0qIuncgpxyV-EJiRJLSf1TIO-kmeLTo_pq_wwm0hPnjHnbeLt_BEltDZ_Zjr_l1wi3pPcc-cYaviI3mLsSCPZgMK-I4cWMnpQzwx6EGJfcRj9vT__ukMvNSe0iuNtzReOkqLF8D1or4GffAzVo5BlAI8HvNl1X1rJYpZBw9UcvXfG4yZkCFJjmbIxfYjkgvtuNkx6eJcxxo0lZSikqn-oOs37u8RemFzl2Pne5mJbphYPKKa_3oFbieduDViTFysGj6GfwLuGC7avhdQaQ29Hm-I4Y4dLyYSXe1OjWgg0SfHil8g1M7Ao_W_lF1vHrX9HtoZZO3QIcP7Nc2MpLxIwNvDRXB4bP-zxA5EPeEVMyDHb1mO70jj4DwJBJVeeD6zLngLBKJPRYEOwG_xndPYVzAYuZVhmOBdClJerIumyWwNeEtePb2WyYOwJy5LCeYdDrp2QUbJOUyUKCQevdMHgNOyLrsUHGoAanB-mR7Fb1NDxJVNY-H7cRKvQTkH_2flz1ayKrL0hdiRVjle0MIjvCBwkNLyiA0VsyEESbTybXIaMXDQj0iLisqD0HC4C0wjd4LX-Q0si_5R24BGpBGGrk5Gf-doXcArMJalb_Y9a0fNxpr-HLHq7r0wSYiDtCA25WWuWq8cW0jpeduR7Uj6sISzMazIZpTdcePZ9QHVkpoufKTFrQ1NIyzmD79jZvWKuTx7GZNAU_v152Immv-TLJo_BAKSY7B1XiICqOiiM6kzYdtJWrMYdIA0N0fWg4XbQ6OnTtmsGcWXWw8skri6VMPHsNGxXCpZ86-dcXq9vJpOD1QHPOrcgQP-3JgkNQ1T80P_RFt93uZRRUnlRCQ4FhRa862xz4McXxFxLH-LDimx8Ks6bJBGZuJTEiCCWH5MLApZwomiEh9OEjUc9lfGocbzi03AwIO8bjf-0xSpSnySJDD5gpe8AF83ydxR6PFLprCJy1tM4M4ng8W9MnfsoLOsbuo38-_4BJfdpeXcGE0WkrsPxYSbQcFI7dVWwrqVjZ_b1Sz8WVBDsyzFyTjp9DZ2a3Ll6lzmVD87EgLbHhl0ijzJDYbAYwMDTqKiJPBxL1KDF9g6RzGmHkvdUM-AB4vFUjIgu-wG68wrbin_uRHomTZGnofcHiYTRWZaa6j97rAZMauVUUCwYGAxHOp1ChlS40gKEpojJ1NRmXAfv6ghWYycTl77I68w_A4rHtIAZGUZDfwWcyc-zXunO3xSeGU1BXJyAnWv3Z7qE4YC_2PSmEc2-_RfEn2BBapT06P0B1USgb3zzmakGvtp_BRkBhnuO21DuwtvolGRcnYdii7_ITm3YIvTyjtEGu4zHkZnOigO7mNeBQq0S_x7nkiEmpxX45CcEPf5sfZsw068_NCnfXGfH_5TFsYOqsjRIAFrxj6RY8ZP_1spIOcKKHNBhn0knBzbxPJRijXwuhqJEbr3Va2az9rVEfjqrYFEk7zLlnLKVD67HKK-tt8F_QbfCdMxHenvt1RQWP6QA9GT7R24K7IDgzrvadM1F3PaLcXLhLNXq8tjcCFDzqWpgPf40xNT93GaRAMVOAapLM_Ze8MUE7Ya3i-mzHgBrxNJozt84o0YZ6XOOm1yR-08wY2qN4FpVQpszCrpRvmaPnbYn5lLRVNCGJCvSfG6IT1gJX5EW1Y43qazLX1mewDRWTQ4MqY9oRayoALzqcS7WAUQfo5rnbH7SYokYXI_Yv6f0ZSnMAAITKsHPoCiKCTAxlaf_-dpwGjv8ZEAMfoOmVSRAYy4ot51uegz9lf6xBiAiEAVKyeurOMlOWzq-MsH2hnZVlqoHTklBtfSgiZTUwVQb4HgkM88xOSzEfK-LSubr9ECP2Fp1YwdT-LtNHYVXJTIFmkQUW1xOrOldmpxoJRg3NUZBgOBcL8m_si0R8imJ5rpMfzb1Izx2WnAEuLiJCva10ab45AWVDOg4LHAuYXUHFa6FDirVzHiW1uHDK6cxvIwh6WBqkn-dnlcjA-cPUWyCjN97y83eNlrN4TLT_h9VtfbL8Ho2DY8ferOAqVbXFtufVKE209fauILAlqC-qyuNtBjgW71iB_zvzbPhCyml0rgTjMULOzKRcS0rPro0QMDhQSQMpToBb-3K8HQ9hBG2gSF3WyVKeaPVdyry6CuedQenrnxA9Prt0DVzp2-IR9hoJ628b_RjVLwqVTCNfjd-JbWO1gHq-iNrl8emEtUWBHznKy5R84W1zo0H3De8ukEAPuCyqLGYKV0an9eOkmI6EDoBnPOzd9s8aBWVCqbKCy6ZdPV7vt8LNtGfoNfDL2l0JDTgwZJXCwx9QUN9yyrNtcmLepd1NWgryxTGrTXETvs5IK2kI.aj8uW3WeRjdM3-56CfNWt86EDk8jFdQthxuxE5yQc7U	\N	2025-11-22 08:30:07.715697	eC0H+QmbApmmpq6RJQLCMF2540W6LqxO6dzYjd6wdEw=	redeemed	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	authorization_code	{}	a5a1eb7303574d9f9e58ae9b6648066b
3a1dbcdc-296c-2a03-c144-3b2a067b2b31	3a1da2e4-3191-7923-a780-699387b8fef2	3a1daa2e-4a09-550d-2d70-85760204b9e6	2025-11-22 08:30:07	2025-11-22 09:30:07	\N	\N	\N	\N	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	access_token	{}	2b43c306be4e421dbdff79e95381d397
3a1dbcdc-2972-a6e4-aeca-8345b57e7c00	3a1da2e4-3191-7923-a780-699387b8fef2	3a1daa2e-4a09-550d-2d70-85760204b9e6	2025-11-22 08:30:07	2025-11-22 08:50:07	\N	\N	\N	\N	valid	3a1da2e4-2a7a-96bd-0445-14688c3f7c52	id_token	{}	e1b1f7e7aac748419abfa5c2cf9514b3
3a1dbec8-4959-3b27-012c-5146d95a380e	3a1da2e4-3191-7923-a780-699387b8fef2	3a1dbec8-2d0c-ad13-330e-933785192bab	2025-11-22 17:27:39	2025-11-22 18:27:39	\N	\N	\N	\N	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	access_token	{}	7535b6da66f54cb3ace5906977759d9a
3a1dbec8-4965-0dc8-33c2-4e36290a019a	3a1da2e4-3191-7923-a780-699387b8fef2	3a1dbec8-2d0c-ad13-330e-933785192bab	2025-11-22 17:27:39	2025-11-22 17:47:39	\N	\N	\N	\N	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	id_token	{}	ea45e89a33614bbf89f685bf8fdd83e4
3a1dbec8-2d92-c4d8-5710-f1ee3ee8c4f8	3a1da2e4-3191-7923-a780-699387b8fef2	3a1dbec8-2d0c-ad13-330e-933785192bab	2025-11-22 17:27:32	2025-11-22 17:32:32	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.XtcsGjD-Xw6kZrlqB3l-Mo5OASRimI61b9NIKaxwYtOI-oAGgRDdkDPy_lbDQaVjV32d0eFOzOt5L5xTqMWzTFuOVvFDzT4Di2quxSMizHvYKTqS_GL9_plUYgJ9lwHxIupCRIXxlHfnA1z_h3YdDJ7d7yiPKPOhtEGUSEjdRpUTrQIFlI_NMNcapnBmdYJR8Cr6Ayt12Sw7zKS3Sok-iktE-Rbl0jDC9u5y4_GttxgmjK9zcwRYqGLUnxyzv6cvqkO1t067oRIWg5UIh3tJCU17cYUwypMgXF-uv9Uan-9Ipe3IZBvM94ZcbexrsY1sS5x9aveQgy4aCieOBIfceA.94mhHYQapMqRsSFHemULzQ.EHgfsYg1-xba4TjS_gzsxJQpjNrq2VUc5M82SFuwaaerIQHB4J4bU43DMDrKtiV7T8sUcNJyI0fMEUl0AtpQblLPIX6r_fDj5E0ckSG2-maJO_7iYhC0iY-4T7DbaoEKqwKrRWVaVzTvwCI82q58_vm31w5I-YTp7YvENMfelhRRkiUOKQv4DnQxsbbFo0uBy6WQNt6WLRo85RNk1Jz6QN2IpbpDayq5avNU3aIWPs4htmmLNJR4PfPUb0RdaADPRhl8ZDQsKG1sZ3bvD3rjtVBkaXCCH6SipGiUAKBf-iiRTmP4zJLYRy9WrWvp2IWFT6vyE1uVT_1OF7BUMOpH1InCHyVyBgS1yi11YOhn5ykSt5_HcVxOXy9USuRcZOjx8UGYObzhRhGSmahwfx-kR9VOYj-hXsFVVUCar5y0mZ7bXmG5MROAekK2nqEdp8JsdLbLebrGlx6H7k-VOP0UoD_eP4aHrlp4BBV2f2vqiXEMT4eMlVPzxiBqxsKFTiaJ3U2RTBKvxiCMzEzE6KwUJg0Xx3673LyMIdrZWmk3bJI8bXyQwajNO115v7FgXS-44ejiDis7ywibtmmotbQppGfrgG6td0rqvWuLdNy8tYjSciGnm7Ts9iDlZ4DkIZHb0btV77CiomUrJf6B_jtEJV3U_ExSRx2KQNsRPuLyOlTRPNoZFHcUO4Jk-q7wveJmetrWDW1QplMc4b8va-cnr_fRQxplrNoUfxReT68a0L1126ECTT7oUlgu4aVzhm9l36b4QihQ-OZF-SlNimlp9en-ZI2Vb4Z92rbg-uEhfABHJk4uRn419kczmrQPgTPgWXTU2UN9r8l46EFKAlExbdP-wo6SMvnIGi3PNK92kFNr-LW_f8c4_pVN5CMy2gNL2TuF4LmOQzPAYiZeExr74ovRJMFlj5tenOnvX42ARuYPDmcCuLi_30cBEZICFpDoRiZYTpAAGZS2e6hpyAUpdjST0Qlj5Sn1u0GzhGoxru4BXNL04Nf4hdM0eqnjJ8zqb8atTNiN-ltzp8mYTYNsoifOgOYOplslfpb7uodO-XJrco6OrEB7fSSHa22WxmWw8BXRi186u2nWiJ3uoIROWtWur8UeKEcVN740Y5M81N3BUV3td3LArqqsIlqDrWDQq3ALZ6yBVSb0x2khJPJjgKTRgb5ic0GuAWQubOI8qAfqrEEPBUA8IRm-gytqAmzxAOs1yInnbDz5HZD9TYRNfqnK615eF9IR5YyTMNU8no_JSFZzcedM5vgqJTsWsM-mMSukyW0ucCVjrqxs2us-sbVi1Q45ZZp-3xT5F75n3Accm_UalHj4Hw3mzGrE8ayMVMhGYKxDeZda4pXF0crDIc8vXWNohI7pcMz4vZ4QSsEO5m0NgXiX0RxHA6N_P2EQWxDbyB3Yid0aYDd-7TgQtqlQQApoalW1IMVzGqthMts13M3zrQBj4MwRLlDgcUbU4XPzjxskiGp5FYJ067x0DAluNsDAoC_hOvksqjOvlfHWbNrLiJBd0Bej3O7oId7uxzye3Lu-bP-uHokssATfv-XW6_IaQsdiOqAf0olUvgRpZ2Hx07QS5vZkQdiE4i-fFw2XoGMW8rJpl-fAg2FSzKkETpLwMT1Es4j0FvxNT3GDQlpY7LjSB9-RBqdqoBxRTYvZ8F6-wVkr_GUEZOW2c3hE45AEMGT-WDuWS9WrtchJCkuan5o7A9d_MNinSlHtHMeVRbC0pxY9ooHoaLTXQL4QS9sU1UPCIQwBmNRRirkJLBfD5S1CDsLaDghLFG400blCAvFJNqopNl-8p3ZqVpX2PK8hMZoM8ewYDSPOYmaGqUiNL27d8azUNTUGmZ1cJjvXRQ-ttTRi7LKiWxtr0WuF-T06b6RFjzTWG2DH7s7RBB-i_p-jqD0ZyW1agY_I5G2CYFNkbQHgIpN2CNiLPCe17wMw8GU-WE9rhhLWW8cDmNpRPhzI3bbqUDBBtKoyGa4Zq-ghnFtwCErCOmGs-GdIiAwz30mium20rwZqAfSVEFP8gLpPMXtjXx2S2zqdho41D-zPPsZCGO0u_W6TPWgd_SF0r-hhmBO6IVyLK5e5TlmcYEyweU4pO6Os3iyqSEB4LJutP1b9W_X2vAKnG5IhgsATGcliaW696rwWoQYT4eNclVxAlI9qvfPxTiqV5ePBaCf5KACG25t0v0o8RjJn_f7hN2a8q-GJlp9CCEaHUzZOI_AN4NtJTKsMZhfnbqAhAzB8Og50H_bXvIMr_Cith5tep0FeVkP5yfJwXn7W_V84WNb2DT0LyPIl420keY5hYhEzWOIsD1lTlonhiZwRkWsS6nQ3CNGAblJNIN7buD2NXjNKXGqyKMttz4kRkGEDemDMnjWTBMCNM53S6yvJHbOlyRpnk823YYpaQmVD7H3gudVuCL9Q9Q-TRUPu_MU-sKFaeAEyxDsAWOw7qXSBJF2mS9xOZraMHf0_q4GI3kGq1uyH2hD6whSMCyDUyzpa_nutYF7uZBkRCkGuRmREUN8SBYqD2ubz1TxrbJ9NnvJ7eIyRwWL6bucPeYGdukuM1Yz9_bcG4Qg07Kg81g8SllApuzrG1h2lodeNb0VPG_5iZm0XS3eS0_XCJtSAbq1H0QyGt6Dohg1bxjvjTBJ4gD2yJ55cHE-VuZ33T9bxF1TnI9IStmEeQCUcr9QW3JOhhHN5i6MvQFPBsyh0U_yQ5lzlbNQvurXpD1iF1wX892b5zjKS-fEpJyL1R92V.h0AqG3PrSTeduMrQZZig-K4QIjpe1_U2aWUO2ymAq1E	\N	2025-11-22 17:27:45.253472	Yr0y2EW6UbbMPJYm514+Jx1CMKicQiIcoIEUZ99S9xo=	redeemed	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	897890a1956649399aebbfd5adcf02ca
3a1dbeca-8ba0-862b-62c2-6196344436dd	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-22 17:30:07	2025-11-22 17:35:07	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.rf8OJ-0_gw7kBPELpzy9eMGBPGDQ3jHDdsnrG_qTrUU8u7O2NMN3RDeAOK9-_OSeSHnUkMIUXk9PQPEkX0lNFtpcuD7M1fvdRFc6xuxbJ0Q5oV-ax695QNIJqUsfLNjp47iMmjrBSo3pMyMrR3i31g9oTzCyE4t80kzZsGtEVBWHF2gljmpYKfrv7Awdg_4sgial1ICh1LioJZ20bU1t-bpRD6FgY8ue3U-B6Owr2SDar86g1Dmm8qLZZIXtJto76hZBAotQMgVcANdrhkp-WDDDweCNApjqfe-iulfaHeB4_viPoD1HjS2QyuncFx4QVPVIkehrLOnvgE3cBJFX2Q.k3w0tZuhoCC74rNmENxvtw.xv0Kei9gEpkkfpjC29EuP8QMflBdTZKrB177ffIBdd7M5GFqyR6xQpdqYXxy_H78cPzArZoHXQ3wkzshtPe060QEnGRSv9qK9dlJK6BN_wbgz2tMmm6MRGt9gyPAsg13LoccaAmlITg1FQEOHo-aVXepdTzCiAMSaMhYJdTZuZaHSs4sDL7IM2c1XTth43JsvmzwExcq5BKgy3AvzL-fLg8WVdtedpgl1bor7ST85A2X0lC_vcdeNL6GZaNWa4L3p9YxgfR-OI1d8pWomqwv-AzBylvZGBUU_WRY-UC7jq1Dh81MLPwG44PHYTFKJRflWNBlAn9FSBue5AZQrGIl2Rhpj6MmXo_wb5fjtPKO7-XsCetaAKgtDmsJo3jd3ec_-ncuW4RqRjkNLyvNkK1Yfo1mTS6CgEGjcalHcEqTgK9Hz6Ztc5Jhxl6PPrHrxC_dQXA7nRMNK2A9gESeG0Pp1GE1PIjfRDeo_DTmWr-VDmjlVX_QLNpk8GzsyT20YAIaCcfL7vLrOKSwhfnfOrXnzmkaSbynCj2QZlzp6UCLHpvgf-1LABtEnpKLMt7VNq8LjihSSuSb2_s3-LdgEy0Dq1ePH1x7XMkgVC-fmHLGgGEKtUMuvNtdzdqTrH7eLbpLsha-zIuVpaLbmRbvBqWtIeJr9lmsasU3s6Hv5grmDy2X5A7uemryz66tLwSxr7CNcIOLh5pO--G0GYX4gQdRuvOfgisyMdeAKRGxPorZ-GTuIHkLty6xJGYRoSaPklH2Yp-BO_DPEMXQahgeGqW-EmE96Z5khGW7bPMv5ZmMwu01cWQtGAXAH1SP2w4FzIInVea0-SkWh5uED1bZtBiMu3s5GfEPT4sQUYZMAxAycgIyQLbk0wztnleHr21zXwjc2gMRgdIs-lgDN7an9vXidGa4kmN04L7wTmK7tU8AqCDKie1bUtaO6ReL2SC-zx412XVxnlR1OlxsFoVsZ7qb6-D_XmgVCcAqr9l6smcn9nF9W4DgtWVLpZ1Ij4zEoks7xnOCvN83LsGAs4zt-to92n1DHKTp7lHz50A2TMEepxQ2pnEmEYS5eQzqM9341V7ppXfG5UnlqAANYiJXQq2dOKApGsKVCgWF2vt4FvpvS_-BIawumw1oXF10DY_XeiBNQMftK3bhuFF7bNdPJ5yr3VrmuaF0fcgcRrotyxLJOcDvh03NqHdkDPJO7YtIQu7ST_oG8y9a2YEx_9zqOVp5w_kCaNsRjogq7AurnuJBvBBhLZVkUg7PcVo2Yc3C2SMZLJFr_F23e56gUFufWLZFxbbjyenuWs1tVoxJnFnJ9ZdYd0Sp5sjcNl-xPm48skchYBPu-yLpzOc6pns0-oMzn6JDxhvwPFnQNzwt2YJNlJyxs6g1F5LWVamTLG4eFqEgagSs6NMgusBDraUj0TVM_1guSgXwgvBBknJsje6qbE1VUFuxCZTqg_nd_OwwiQSIhXZy_JM0e7HvPQG8tcuSEWctYolnfc_Gt_zFwQpzqtnTOXQQ9TBOWsQqlFcbVpMfD1Bf1abq-_FxDZfyXbMpTH6R37yRiY6Lkzoo73gjhu0lnsSYcjW0gX7QM6qLtJ_vM5YlqGrh6SxjloWOcaBhoHDknxvadEuOIoHhW9QaZKi5AG_q0rfn3Nf9zlVx43lL-612GzkFrc-M4RaVbpvd7WcYhT8bMYLyLzVkUbjMmkML3GtrqZ4lnEG3ehVG92p17OxQR4NvCUBxNWnjaj0HlZPF-X6xU_SBosMzQbybb7HYSa_7gBRKkT7FnC3qK4UMEPUmNQf12Ll4iqnQLMtvr5b0ByNnl2ZSKWhuPklfvzUaex5Yvu9AmreomZR-Aud9275Gr75PVoj_4y0HjQMmKyeZk5jacUvcoznhFxB1XzFnTVdij88TyLkJF8v9GmYURG1bKfTxxEQbiJRR4lmE5JoUPd7vtgSK18gxVVzkZrImuL2hUWGkC_WTxyj7toaMNJhckoTFiYFCWyTLGSLcV441vsgp5Uh2Cgudi3pfFNrKl4PwquIQPCA0TB0Rb-h0gG8hRRKR4Pbo39_32AaOrsRuo4gVoW9vXB1XoUF3ehZTKaP2_z4wrvT-ZiPiDUH4ovuHDopBb7Xb4HEikqlBdzZNiOjgtgMCHLe8oBUB7jjPvSjg9LI6sTE1HURoY3Jc_u-7SpdL0-7I3RfCzUUVjVrS3eVDs6xorIGZ3DoOI8s9ULDp-jlgWF6ZNoVNeUmt9MgHpVhCL8j88S28YvEjtuqzOHBkf6lGKCPsLYs7LbsnSLGMGoR-AIM-ZT_fAMLIP8qQqpncw2xeZ8Ym67Kj7D1cKq-LyLE5iHEE3j7dDaK4pp9FlXMCxMQNN1LXXTvtAkTix96OIS8nxCOi9YYAHKiXwcj7TlunmseO1DVrsbh8UDyncQGW7ym3-YvZNO1t0uoBLiAP5VcMfME67fLzJQ.Y1BluLos1j2rr-QbBfV5n2dY_CPwoHeVvgJmOur333Y	\N	\N	e5NHfxhHO2N3zkXAqMY05MqOItyfUk0646hG6ErZ5fA=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	101a64e4f6084bbaba334f2659ed61bd
3a1dbede-ec8e-8222-3999-2af03d9513a8	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-22 17:52:23	2025-11-22 17:57:23	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.TwE0DiOuIj7YibGajJ8sSEIYj9SasTW9Nyh92ZKT-pYLrK6McAArGMYuKrwm70xlcngZrdE7Ox6Ir-V4fzU02a8ygc7Qb0FgtvKpteQTfs_yHaSEjOeoTkDsG1QX0dVXo8ArdbO2pFbw-_v8BqdH44tluJGJeZkqntxlsqv0Z22bA1PoVchjKQh4hGrI7gdNEimjECKfUuUrQoZ92EF7W9SJWVCT5OBpKKAdEX4c-fledchGsX-y1iCkFkOQtizAjB27rbjAUnXdidko4vtYfI30TaUH9w96pUnd6ocdwrAq-fzkXB_NxPCR-MFrU6wWo3ka2hY6YYODCFB-yG1LKA.MOzBTwDa1TWnv9emyeS85w.GTheidUiaCZ4JHrgstbU8yC3ycPZtmWUAwUjEbRCWGhNGdVDpA8ECFVYjweIn3KthaHzpYxlXJqJnqccyuB5zpVm_B6VFNBfJcIMMUQ7iE0RKXCrs_hWExpVyIaQTuwD-J9BiGhf6LO6q32rrw4BrXWCd8uy8up57eiY6JZsAtipnQy45FRG-5jHQRFEIVQPGuegB4APMDjzCbcRi7ajKxe2vgU4udURrBhC0iq1skhleCOmmXA_hTamdMA7rArvZUsanBWA38iHGsH44TzNPhEmi52PSC_MeN5p7BRwRIsaroowew-5KSTKUvfSxoc6GeZG0GSOQnBSvyImuMaGEsh1o7-sGBXFvHzYrv7HTNaHffGN5r8f90qirdj45Uq8NGHil_eQsqCF0YwJFLz7E3B-hhiqLndh2Zd_jL65laZTayASaRx6jhqr9BpnlPgGIp03trmxVYsRb_ge1joJXtw2B7iM4b7J5WtHx2tWi12p8ehk-l5H0so6IgfLVLTHXYIdq0CYyygCckzcZDqObFnRLbG-uyTI8X6h26qertD5WN9oQNWjQlWuDuLiiO7VPfsQDwYUxruUdZCEd58fTKrL5rt0hCfRkaJne84TZuBqBWxwGiy4GOLACURoIHRXpY3fcf-qrog_VZQhcmRAzAqDcCogSDOSexwiLawX9hIey0jz-oWBl9W1fSGgIfjzxh89pYish38YDe01Rvc_5WGWy1xJ6qN8gYUp3JOl3B3JADeJmRqs82SauMTsaOM4uN0UeAgI_jfLhCdZnrK-d97VDbbVVbWkNa1DPqXPm97zkxjWQdUzvmtF-FWBJP_m1NBdWMOXyP22awPP8lDoLbeq1yhdfdTlOf9bhrZuTz_7emJNaj6t07-Xd79OTDiqXH6MOPmI1mWeuJW2aoAoCHBQ-XDt07ieKiYJyytRDjTYypMv5TVfYqY0oRXuFzRrNXTzugF9_qqNndUEQdVevy2DyDMQqPXOo4ODHGvnksiTRca2NAqreLLOs3-04-LLsznguXGZjvQi_CLa8RasEN-yZCCqfKU4AJTKlA30YANJptPYXSPWTcy7XGcYUtw68bTVaYOb9Gr-yVw5ZERGPQI5Ye8kPL2L2wl7XIqmM4uK2lAYf5uLgo2fqPB6EsCCJQK5JMJQS1_QS0pAQ2pAErJE-OghKlVxlCZz1d9skBPgNoPSVcA4sZ58-hYP9RcQHVP77x6we_C-KRcaWpbtN4gDSvRa_wl_42ZEkn-hKYF7CAgnoNZwtj-ZZ2QaSjN5zp69gbVPk5K2EgdBVNxR0Vn_9pKQpiOv--wfbsPld5yDio6e9w9OpI683nJXlh-pfLGY8QHDcx5UGZwJABfAdPTpGX4uyuUs5vH0o9cWh6o5CJGtXbEa5CVduo2zDAeJ0l0zPjHYBDEqJ_3-uGN8kDCTrnlskWSpvivJ6XOTD74CnaFq8wbbvdyrALMlXRfm2OGm9yw6CBtMLNuGimdy4pCy_JrZcBO5Ki18NHkC1ntCF1z-dyJGJCvzBFgSc2L1s5tN4bfiaOqwbE5wCeI_kpdpAiobFNYYWASMNV5eDXdm_pOBgzLtukQ65K1t4rFBDn_g8x0CVglwE5_MbDNewGoCAZXhWp5A12xYD_ENyjCSemPCeZai-j7gBwISNmnoXpHiYnJ3lIA9_xbdeHrAhlZ7gPm2yzsiJkwP5hDb8_4m3kKN4lLRELAjsI9ajmsy0gb-n7QblgkIyBeq5adVSAaFLjoEOcMQ522sJUX0k7muOYPX0pi1BhGanZEqxaPSHLPAHZu5u1ov_QNoFtINlKd3McdAjHouGgd1vhHA1rK6SmttbP-zdRdFSzhNp-QjlV8LY_swdgwb43rozjQOIcTMEll8WKKcLdlzCsnkI6n9crlQDy17HyaCUJAdvy3R5IlUW6hTLLsqQ3XToVlxXQcaMPHngm5GsPvNhYkmRo9QX5tmB979sstRFUlckTuIKKMlFEZ5iOmoJG7FeoxzbPvo2r0GQTNSBISORRfLaujNpCv7cxGIki8PZiuLtZgW3nvNfacg707b1TbFa7cpNuy1-CNM5x2cBMecmXCeOzws4S-VkmIDrVllZStaILoIeVmnuU847nGJxuwmfzrAYKNEzP23XeMKyWuqvm6KK-KBMIB8XtmnG1Nbiwrv00m3p-YwGqNv8Xdc8kZ0MTyitQqDAeNrqyu7_X7rTiMyyogY80tPa39YWSPz7L8xnj4dTDy2WcrXhL1mMgnTfL-fvJo5EAvinOpv6QcBJxINBelz_KkAjEr33gzn7HQwVO1hR8ifrEGrlNAnrRzdbcC8WPdPAxFUtlTg7G1d_odOcjwQZdhDbzbsfko9_UcTb4GVkL2XBsPCdGmpKNr4SXLxrxpTd_ydHuhdO1qZLTpX7ekLks8k3k7G0cNb77oxV4RZ5pt4DzQ6h8fOREhZdfB51Q.oiHO4YsnISvt8ua7_0zefnJSQ8wqvrT-x3kZR5ApCUE	\N	\N	Ruls1oVFc2Sa6DHv8y+mHVacdNF/jlqRaRkhe7NSQpo=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	29cedab7def14388a3a65a0d368c8281
3a1dbee8-2619-3d62-8dce-ff9f249a237b	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-22 18:02:27	2025-11-22 18:07:27	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.V-SIKfyLtznzz3jlAGmYqfaUQ3H3f06kd-VNEBizZqaEGm2ksgXYhs412umxE9FkFSkqJoQRW6s1rjO1viWubc_bgmW7wZuRjTfJPobcjeYGvd0uydIbhmbMEKiU8WT3d0RwKLMMJMuJgbgV88Y6hv8S-ZlFWO3x65bdkKIzGZNv-COovkOnKxe1ezn0Q5jScso9ijQ7BqMESpgnooB5-k9ZilsGDNrrgrsMQA3xepv7jwZXawXMURmj2BWAa9CEbvVmq4bAgWAb8kkDiaEwmkT1puvnY_lUR2-wKi3ZSctPOpVw6UOV1bgJlELP6WkzduscgJy8z6uAMWDBAUzNDQ.bGtbW0XMwanG3zT0WSQ3DA.wIxRkR5WfKZWhHHmxvHiiA-rWDUQGzEevk4AZCLLX2vwavdZbd0oIn9g1m0zGpTGzqqIeG0BH9k8Ra4hI6WdYtL6rP9-cxukddERuiElPUuyiy0uuviTc4_6aIgrupCPVEikwgHaybvPwcvn_yLaFAP2He7G0SaZg9XNgkgDthSNXgwcnTv1PsSe04yKV1dbRH_As9_CTOBzgTlDVvd5fO0j1JSkoysndm4_5waMCUjhvPsAKf7J6sgAwx8N0uPIrnpWWMhUibTXSO2f0P6LrGzHptYeg6LCEQ8hDR_lJ-Dn3XWlKWJvGvm2z15efm4mFpVBV23S8eBlhNToI-wdXG5bjIjWLmXumLQ8XYdgEdPHa3Jcm_OkkOynQ237X45q1r9vkHd1zsXSz1AQhrjoeqqOYH2P6Rnvbo1G7BSDvIO6eQ7Zx6ORZxmGZWv2QbbFmxMbgv45wCGPFzwmyl_ogunTDt_3c90-dkerKkTSaUwxgRWNs2_M0rc3jUDSm38eSZQRidqp1suKsX5SKBSk-KmVUfuqJIPzQZzrAH3xN_dHw1Qa9hHpcqyDWZlFZfR5Uq6QdU07WnvwX5LQNT6A7aAaktZMNVi1SazDdHb7L4AyMFysabsNNZ7OcxLFJKvDnom228VMIws5wjmMcT7zFSdTVG9gSQjsMIkOYEgP1lsxx7MHTJFK-48hd6lCnfIIQwN5DlkEmcBwV1k1yPvui05DbsmtsE-HhZZ2GXll4SeKioXXKR_P95SH7ljO6y9DmnD0ISRFSzLUJVPIm83cSajyqFlxtljjnZoUrtUre2Z57WYd_ZQMaPFGTihaCWgoJshzkt0fca6N46DRtD_Owrj_YXLw--sPk-vDiGw-EgJRRcg7wBMtm7YZgWU9bQX2fkERIzxScH6mXcYx6UL95-_3HJv3QnYrkP1FbqNhr7mGJUzci7-aiaBcKgTXJVtwCtJFjwvQmjlQo-1wXvZynmbBWWeR2--L2D9YAEwejlm_GFJM0QMnwhbOgZVD5yPWZQVnUJcZNQB7UEIWga35echjRiKOPAkh0RMxCwC-Tz0CklFrT0bLwe49i8KZHtnrhFkAcGiqw00Z5NdckHB_xAUbCdS1dwK_lVQIMjqI9FwYyxVU-oIbUljA6YzFmSYrrb_f_58hc4yme_g1n-tKbSJR1ZFmCjINXx4woYAC9IqUQPjBsHOV8gzLKEvbFymERlhA65MavQcIyFvzVmdM1abGZCnTWEie8vR5-xIpKowizM9Dlvab3PoJ0XMQKqfwoF5l1k6cimFJ5O-zN2rqrXgUOEkhwm21H7AubSisRsWtN4BCWpH4JFLX8Bl_ITldtmAM8njns3JV_l-DlLL2IYZnh0ZuuOx4obneszh4mMmLIroEfhFILQQLn3bo8o6emd7Xpdalhb7tuxlYUa_btMJPibJkrDsNwOrsf51_5bu5PjGMBBa_N6oSaGBr2C28Se6zNRDVcpyG180S4ZPKZr9AzdY2984KPKbQG0-gegkyBb3y5VsJngyxzOXURkXMXnwAxP86aintG7THgu0XV4-tXRbLaf2rHp06gqrXlKr5uBUi_53evhuL-njGZ3sKf5MOaoKaVuEGHOL2fklVwP7Sdqd393Errr4pPB-FmUJJG_tEOz5Rx8pmLWQyp4xZsr0TY-tHvJLTXdaA4-8KmneN7bRIT6EatpQ8LE1JbQz5R8hxv2yeL_-WXfjkPqtHqtQcvyke2X3F5ZbpSCGFwk1x4wMDD-g1u6GXmOwXmZFfR4whVsSsqLTt8TLTj2Y6BJf4GHrrmzLSbaI0ktWefIeE7j3ExU8NaJPnFeYY6cE3oNuZOZBxa5iFaqxlZHR4hyXPjJrtywrym_90NhSZSpWuen2t1G6N5l2vSBmbKW0VyhL9enoDwRjRxRthpWff4OqlMF3EdA-YZo_wWi4yECsIPxLDjhUFZjPcMtT5dMLTnASTOB5ycfZWERLM3GLuRioGoiNoXRX8z1XwJsf8lRllUVF54cKyCxJvcm9sOP2WHx3wACBCf0Mtctu5LAlUV2p3hgUE6f4daDgGUXOvmGeSGJWgrtF9JNG3E1VWYew8EauT8e3xgxLOMYhuSocn6NP-mBgrrpVGVKf8mHcWufopP9yA64pwPq4ACxHcEHjaBV6tMg231swI1CigGmPtpJcb2msiIZ3E_og_RghHxJ5qjzcJ_jLmYIhJlI8cKOlrgsy1s9_bzTRqhyFYy1djee8CzGHAtwH5O-SYNdMluN5vsqSUPp90DZs41xmflk-7zeba7bNaLxLidYTnqXU2dDl2ZjXzpgJJx_tXkkJhvAvnyjzjs_1yD6HxuCPncaiVJUda_levaEwSy6gksTp75NNnG4Q_Gr1SVMlfW5Qs4UJpzLAjS_YN5b7btlzhTjYYSU3hdIAKjH4sarzeowtTCqtHWMrwtxlsnxRKXDldTA.NUmheRFXEefIHnlqaLOH-U4bExuN-kptfh3qHJxWEp0	\N	\N	ZWBMPUyxUaHVn5GmHGrFtvYc51X/n5T4CmxCkj2gmY8=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	14e43f9f73fc4469924ce08908ca6ebf
3a1dbeec-49cf-4afd-e96b-69146d7d21fd	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-22 18:06:59	2025-11-22 18:11:59	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.wA7UlyczkFxl5yjfjakH3ZBbf-xM1y6JQVh08oqVhOTC5DjgFFwPEDyzHCY814_nAe-vMMXcgD8qb0yILYQnU8aKa_jbM9vovLQ2_rHCMIhz8PpTCM4Dzjosx9XufKCQ6je6LEoeTA8KRTUsfumJPfJLcYtSWTXWile_qYKUGGr8IqaXx8tJME3ISC9uN22CC0BrbSX5uaQmzBqJl7pJkY7ihhK-PWAZwCXLO-dRP7q_5VoLRbDusttmzDlc1dVKp9mV6oa_UQh28nKd2wTqhs-oXlPEOBMujye5XjoU68qf4z8kP7LFDWmHnZ7LFmN6Swi-JPIbyo78jHTthW2AQA.BCZf9v0WpTUvhGxLkNvONg.4sOr5KgAAqN_JaguWN8YwkwEQSZqawVuIrsj8C23xYUcjJsOhNEbT0kWPChXoG52JpIjNjK4i1Md7M_n585L0ieQT_3d5qcxr_7oYXpDBaWR4jzrEE5aWv4nVt07obr976Go4aaMERBswahethfsC3Gtdbo7eUf4mY4GL7RYmJuoxO76svdHUj2QhDtaXhp6sRWAA5OCP5C0zXVF7LxLk5Jo8BKSROGPE53Pf_wkBhs0OaKl_7acR7g39uwD_59_MR2TqX9AXr8XbdEYuxoDGmEuxxfMXlsfyKK8sDJhGeCG_NwhM7aMCE292WfcfmfXeehbn9j6_CVMQVgz8NlrV0W_c2H3-XzV_r9FTWSZ5S5Am6fygpwsziK8tJWEdL24AVNx4pX74n73s4TheERxOZ1CQaIh2eNretACqZe7RQHFQ15iLo9eKBu7Mhgy3mjnD8ay-zqlSXUX8LFdtuURHEabC3sNG-eUF6SzJiWfgq3IKG7Hh2qkTeThlSp7nW7_I3o9nrESuID-jr_NYVi6rOogPMTLmwS6u1gA_k8q1Yo2ELiPsFqIFMxLBe-3_h_1iWPwCveEN4o_mSdbr4fh7-T1GFdSnyxhyc0Qb6ohlMNgJosHZX8UMEmXY7ZAICV2JMZObDWIyDG6AOs9XDUDXb44ZsVYZwPZr1bFE5Npv8UQjMlxGf_K_eSuFGKwdimsM8bckeIp9ytxcxEcSpW-PP95MoHcXbFHIceixgRLe_m5x_V8gGRAwpWHl3IB6fPVza6yJ-tSxCu9tPyi8tO_hLlY7JTzhAUf-kgscYSPj6_luUMQE_pt4kpI7eUA3Iz-ffZRp1VKYIxasJKRoOGLvqNfT6s_QIXgJI225pgj1_S2k10OiVdmlsPTXiMTv1tszqRTiRIbjxPhn1O_pkZmicqtiw8f1hV7kqtth1hBA7D3y1Yc6t8mr1gzl3QGf5CjzSl-SO8ZF2p6YmueC73yXMF_hsst0r6Et0vVb2O-GllOPL3w5Akgqv4EDJcgL7kZv4vXSYHc6lWPNSROjPgpk_Sv_lyAiBriXq25GJKHEqT0OJ9lFy5wgkhBB7qCc0h81ro_OsAzXjJmg96mtGzlRuTkIjnDFV2kXRaxQdMOtilMdL7Xeg2gn9rDuBrfINTs6kwQqiRzxbR4y-6n7aaiJLwqvfMIBDQSW2B7ejRqMc33uz7aR31sAagSNaYN0QJP_nGKCDl-QDtvWm--52XgMvRjF4VtFOmLku7FW0Zji6xJQOz7KA5PnVY8aBeQWbJiELmkcNU1GVvbyMSXja_oxYBLQekOnKwBqCww8mm6Lnsrn4rEKDAC8krRK-BK9Agdy95K-Q3h86_CAUmSnJhKrHnOWqnm97RlJgtZ4uaQdzJiMO0yd5KQx99kDqeL2oMGzp5cJ9o1YBRsyDi7MyGLIuKOEEujgn-QGK4K4ui1QxV7cqE1v5zoZ1Ba_cFjtLk2fFQM_GZuToLgrBpHwKq0wDDz7sJPRERwwlA4woQfhyNU14a_HsIgrjNAAAtkIDLJ8JlvlB3sp0E7kdP82T9iW_G5qS4UcGJga8kby8gEgKSO0fQU8zKh2EKAekME63RAsbnnlZXkHddJEDCAk8_nbMzq-R0TdbD1Y7jabp2e9O2De_B8I8l4_-3FhKwU7smvSMndWqLFFEhK8wU1kIyxmJGhlkyArRjNvtB-xD9sAw5X1l_vdI5Rn2rUoTmQHnhsmbCI29C6e7kyFUugLbmQeLorPW-VyLWxE2YzDSQRlY4FEZqT9Y3JGM7Z30EZc8uQFDr5u_SF2DlRYTu2oBf22xRpTMdNY4ve0hQ2XC3VmLFFIexr-ZzWtjIdb47iJc3cWZ7JeCNku-TFfGnYArpaSmIDHwZPEd-Ou6aM1kmWhiALVMwhzAXZewDy1AJ1mNbvWEBAlI1UfzMg9d65PYeVM0uKlERiyQdFb2xtAA93Zs-KF_oZdcG-D-OGwqsW7rArrMZwGXd2nZYsPbyrw9m2Ofod0w5PC-YxHpAbP3vJZf5BgfeoPrHf-SNKzAdLdaPG-V5h8W9RTtSgdoiRbinMFG4gBP0VEckbzM46yOF_NZm3lRIi5T90fNh3i6Zi1qZNKfOsxPLhUvEC5W6iDzObDdQ6teWLfyRE4SU75aqlkPvlCo5LTtJnmYI_6s8dMNuf6Sh9feTJF4Hkb0m-_M30qUQJGnuqxNnfhA4a8jbwKwYz9lGw1l-ro-MzEvAIxwNgWC8xhdOng84iU7urAEasyiakQI6cpYAkGwSgpz1pQxlMl6OwJ4rPD-czculpPDXuy70R64sdKTXCiYSZ30KkMAcxkgAupH122Iixem5YhrB2D9KBU7sa9eMv-pTbPAjsEV05BJdxK5L4njtkYR4K3fMpCPhrDHmXZvgmJfnvhtlzWAuO3TT1ZQvFr0VY85Jpckz-Z9TKnCM9e4Pti481pg.K6rIp_6ohCd2i9upuMchXycNpQbi5YypsKU14zmPL6w	\N	\N	xvAwad5MNWSoqQ46Ou3a1ZKTonEnEjTYM7PbMGEzGr8=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	223f436734584f3684c99545f55f687b
3a1dbeed-236a-fc28-3282-767e68b852eb	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-22 18:07:54	2025-11-22 18:12:54	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.qSvx4VuRqI9F1LWpX1Vx-0_QZq2dL6t74Ft0Gb7yb5OJk6z4YP-ipBxNd0EM_v75J5cc4COat9Oi8-nDLg1tyaikpIH9dZ20CfJUv4LPh5D7N1z3y_aK3-ZVgvGScjX1shOEOX_sikyU03bmC4eaF3h9OG0pye2rIK70SvCDDN_iR8f7puJVVU4sI77pXi4b-6mNXqq436mH2mkmXL_9Gb-JlXq4TakL1wzvTlXU2l7vHzlnNr6Mqh5ADWL2web2iiu5D4K2yJcMnV31dNRGt7o_H_pvT4Vtmy35NfkYfGrGbfMRvleYhQXMhbbxBEUxgUrcuy7mvLukNRQbgNb0uA.hSuxBEOZBRYz7LBDFuTxNA.97Z_rKioCoIhh-A6ew_MjKwBUKuIZ5XKdmybwGlYLumDLnRmGyEw_GCiQ7Hu02u3yawGGwqdT6Owx9423y3v55EypqFCm29deGOTNKnQcRx9DurGA9lnTkCyGBtM7-mPUfKY_L2IOlFc_VTjUG5WdiDDjTXBO0Ew98ceFfhyMntGcQ6xdbzYDgXTOm0Z7aQdOkqU3CYAqvNd3X_RBW_Qc2ZxdS7Kc_OSh-VGnKGI7AYwKPI2C1kEVbEJeLKwChxds8ZkF7edezJsWJ45LPgEWSo2FpZmIytPOPVf3YWotu_4iZRNnNTuSoaiCoBtfrsTj0tzuERvQ1WNODaF40xoZLJoLNf8M8YOl1YRlE-yPovt_w-XZIEFMB0K5QnOPY53dkj349XPu70_xdOcJQHYrqIGb7Kx9qB-MDKO7-n3RTpHKZOz3uMJDEqQPfzMiUfdAiaVs8rzRseUJx0vtPCaAW9uUA5f25hCsDK4RMVIbOP7OgLQ3vyrOb_p1NboJhwcLATHZeuS67KAfCDUCYOIvcEpfFAkAAvZC10RDVjSVX_EJTdthehcqNLMNn_HQvgRIypYA8QyAtTIYfKFhBSLgDSt-Lmc4obcXDS-f4A9K6UaYANCPJo9adVN-P2N7fdSuexdMX75U0wpSuIM-16lwdA4xSzH9NnR5XfLOzHchtL-zRwtPTFZ75b0llCBs_1OWq4hjCvBXmK-WRaT2tkeNYNqnMyfuiCoqkBDf0iFMvswq3v0J2qP9PCOjPq_UaBsc5TIgB1XOzdIBFbte_TeSXsSOZ0BrY4z20ZQexZXlmcoQ-_0oV8jmtwX3ZfaApazAq_3erdlaP0p31S6fTbiXzO56LoPEUmZSRm6wvnB4v0EROk4xZA_JVyAN5P4M7jaNQE_74RLiWF4mwc2CzFzDHiA82GPMN6U_dz8uAp_TO9Mutr0lhuwPb1WDU8G75ppSVdiqfZStplJKtIbFqrrFhl2jg5S_XNwSD-WubR9y3sIeG7egtJEDQ1I44oRb1WpW086A_kXXrd3h7lVCFaI7-7ZWkBgTItmYAEjq87Ze5vQS5IZReX9eK1waL_qjE1Pp0VvKKG3BmPUKflqUqQfHmpDJKOBsOJu1E4aUxck_L4mB_zhmKFCIY64hrWW1vvdsouszOhV1ruKP7iMarVKCUEHeQNhL6ED61K5tEP9sMRymq0MpU9nEAIH1Y0ASrNUp8Jgp8r_q9nMx6OwpklDqn22GOFvL7rcw0CNpljhWIJre1xc37bOHAsE2z0VCrPqwqRiw7fR_swTz9k9BkEkJhUw-8c4dT--mzkGTpAUf0lQ97vdwjPtk6V_MGjNaRKmnrDbQvz1wXUqLotU6rCXCp9hGvQpcUZGnhnn2tYGkNhSnbJMNgdNw46QkQv85zmk-go-q8DzgT5Upvg7rD_j1I6WEgH1ATincvhjz60fYy9HUgxReARDf9l6ECp_8q3HkhyJfmKojUpxENE6mMGTjiVl4FHsK98sEwXke4OcNsasX1xiIxkdOjaYTwNEiMmR8J6vNtl5GV1tzfufLsyW1R3R4ks_eIyh3idflfoTldFjN_WpbGoVT4K3u4iq-grFLexruiJTDWOK3F53DjaeLA_qWRdHE4sF3HGSrqbrsjjfsNHgSzDNPosdW4mP2kjkOIzHHYlPd6ON1yIN94v3_HctGIApj3_-4ScawcxDy1xSPXlmScLvgIFGNDWAK9nZASybX7hRGsWKZQz7jTRm55ni_naixo-Q4FwEyBCLTyPTLUfhPjyk5ij6Mvo0q8sMBb4oWVN1vkLqYY-TmXyQkOWvZdQec1k3a13IuRNSH4_8mlOQFW-7ChC743p5qeG3FLG6LXX4oXLHbXloo0f-g4HL5y9X5c6In4xo8LqTGvQksYWI7of52sJNfZ35T0b4pp1fjyKYp_VaPX-Mm-jrIfj6RCbsJn41GzVSiMOMCQZA7RYgOR_VY03MMxZbu01a4Hz9WHGwx6ctrtUxYOD1cEiUwH7LniymJQLhPJVkUX-QkK5u7a3ISRH1N5kLfYOuAZfa5-mc_JRSCfuUX0-wxNgpiRcCT5A03i4hf01aKE5yT7kB56WNi8uaK_k1Nm4mr9pAChSrlmC_XFySNxtSKGqnbrjgENnMR1w9AUx9ZASEHGDdRafslMl9PK5y6OMFF671GkDd-gHsfP_8CWRrVImGwit70sSMNxAgvj6lzX9JBy1Bwv6ThCXcibcR570_RFFQss1r_OyMopD7o_-IBrqcacn75yqTR-1f3U9VhAwBpzxmAJQ5XCbFsZU_5G2qj5S0vFb9DoiSWc8j4X8MI0UzqYYZtBdvdL5glZ7dQmvd2ofpW1-zcJ_gjIoNQsWZvguQTRTUyEpF8jLB1fpqzB53noIWO6XtoiEkgDQ4KpoK9BjRuqW2wKt-O2eQm6SFaUQmOrMXLC4DDcqjuqsoVg.29WA0JJte7DFF6y-snFhs3F-9QoNs36W-aTIt0EkW7U	\N	\N	JnQV2LjFQ9IvHehI0SFLLgx3GGJkx/cgsZQp8z18Epc=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	34e1368007ee43d88f68e717c7013778
3a1dc39f-15a9-3c08-0f5a-fd1553df5a4a	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-23 16:00:45	2025-11-23 16:05:45	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.W67VEekWPGe0LwgYcXL6jrdtQltzD4uRZiVhICkVpMqspiPy77kekbKrRd53tTM7kXTwUbi2aRABp4Iw_ywemuW-i0ErNw7W0sROa2DNYJWIOYbxfW9eWmshCzR8q57isanVd0X8dgudTmSC2TyUtUIk9yAMX0AsB3OFc-1mQzWscdMxUH4M0Hu2EuViQK5wvJgPeWjmUKkF7PCHXcafjCxoDnVDfIQ4qDEVSFhcf5fd6c03xcawoMIbCUnYBJy2FFIy7s3voulXDHjI_n0Hyaihg-Ezmaf_4Sz_ukkClw_rNcGzAWbhBHk5e80HfRj3Hp7BjIvGbxvAOvMOFEL7nQ.vHgqEh_HgBy4VKEklWsEDA.gbc1uWyrA0ell9n7WQFwV4HCvNeD5dumG_YxIzpdGf2iMEefbi2zkDTRKLJFMWXWVBdRkuAaAF4CKQwXshYE2pYd39EBZ8IznzS_n2yh0QaNZ552v2smKHmT10ahVSd3gHZHFzGP45Faryz3CwAoM1_FRsIi-1CRBZ72grgwMsiMOSPjiuF4a1q0AYZfGys2yCncDVtyG-ajRoytB3h8RiX-8V2RhNZuCuL3RdpISanRzp3n5FK1ctC9aEJ4GykUNPFddN5y-lfwsz2bblCiJpZ-QGmGX5yzIrESy36rq3nm6SLXwfS6Tru9i1lM77PoT00a1whgDsv4rB5K4TBpR-HGbb5ySS_lBN-eIvUtvTZVeRXynV-rA-w0QQ8SM1wVoT_Ux9h6LhUFq8EvII7oAmgDSr_qgEOeOnkKNuCEtT-jwas_h65fCTX94qCEn2NN0f1HaL0bwpp2oAN2jfj33cuaGX4wN4Zy1j8tiZ0snDTqMy57pztFY0_GMvMl6eY6qoV_JzqAQHZPt_DTjVLosGPgXuY2SnFkNNI819SxFSrnN__Y0J9841XGfQMHqSf1Jb962e_BslFA8z_sS5HOgUI9_BNPbaKNpDN4Vy3r5QxkWTmHOrMG6rnTlt89ONCRsMoFJ9V8ljGhhV4MeKqDkbROS99g0A3lbgm5bLTJlOYgzxq4gQQncZY5KA1Lciv8JfZhwZwWusfjr8le3W2uR-bL05MNtMFZfcLtrIkxKARL3ykMDFCyaz_B5736Kqy_AgfxEHvy27weobuqgIiNCv5pTFs-1euY6ngAQiDF3MB-G8MJVHwNHGsVI8SccB5YrXWPgkFGxzAdUQ0aOOIruq09U6SoVHf-nWGhtDESpypNurNiq4eqriHyZ7g6KdjcBO0k25UPXEHtRFPBk_fJnz7CpYsACbZfbIZcx1R2RmBM_rABoTeJubgJO6-zHtV0e4uEjop6LomAIAM8Ye9Qc7R445TVjCbMhTCSMaT9JcFFMLuWTA30Q3DhRHdehB6L5ctZ9hUwHe1lNnAup-U7tEZ9ai6IPj9DQpEX12bb9F_K-0ysTSpSo5nnNrR77xDECFWp95nZkZaRVN7ZnE27VE8OwruYwWlZzJe6Ge9PYCQTYDPR9_H0rmSFOw7Pw3qmNweYUDY4Rk7XR1yZrhQ6AUGzbSXyXN1l6igGSKd8FxjSUBoBFwq_ddphAktkpzZBMG3eG1eoZfXNOJQRFlCz1LukOf-QscSC5rKq1HlWIKEN5Iiy1-X8yFrofnkdjy0u64lcwLiXn4x01hi_MQHJaDz9Ds60WofzsHjyxuYGLTUd9I3nYktlLZ3d_DhlFusPXZMytwsQflCYKCvQLzTEOu3H0G8_s1jnT446zvC0RgD9t6-sXRjycj6LqToKH-G4P5QvQ7B5J5h2LxaERFO-JAOvfGiONzUGDo85K-hQ0ctsF7Kv2dB8uWXmbBFGDWdLp7Z3XTz8mTH023SS0HFH3PwpslkBiHHPG1hUe79K2LzvUJ4gD6jvbqIEDlsFk1aBVr-m01EiKBVYW47vpA3bEcT8QCmXMQLTGqlDTS4Lmn86W_lwaz0h0yY75FOrIaEWO0tUwsytIHWHd3FRYP-hgbd9CdHBv9RVI9TUCduwwNhxAdOjZwkmTFgjkZKBSiqJLlwzxXDHj-j_5INHzauZz1XlicZleS5khhd99eq6RHqTgPcHzScZte78Yk_w_9hrfmBaodPJFPJqepxFjfjMCRW8E2fGNn9fmlvaC_WpvFuklAUcMZQ6X75wobGcK_SU_ma_DbVrFnbEV6jJzZnvMyuszjdLxomC9ubKI0q2_CyeYvNHUOCAcGjSFmqfJitdCyCxxOGfjpOdLHNAzsuJicHNmuMwNllgcOzgcUqAE1RA5r2ndjdsMpg84gd5VWDSizxOBH9bEoPeYyTvZCDIMK5tXlpDA_WocYD9bp02BFU3mmnYTzi4cl8ZXfKRAUXPeXH6rQd8YtxzuC_sbWtilZIosYNggf6HCqvhqOulQnjLss9fLqz2PgQ2_ahmEeVsON-ALfmMFutv9YT-Wn1r5U6mlCeaj4oYVJVFnk_heCu0qAhSJJmxdKPyf44zbWyNHSmasf7n5UPtsecW0hVYuILrRLhvAb2YBKRi7r3R0nfJFOgHI43U3jpDQmRhXa9dX2ZE00GNhTq5nWockf2f0gJbDKVMcvCVOVQz4EqEibMAA4B3TUYDMnyl_WpC1sF4EuOrB2EXfOowIN1VA6l6K7MZt-pR8jANRn6EqXdS4TyJWTYyQlED3v5oUFY0zDU7TDHYIKlP8nIJPs4VOHy6PKYGJvYahQA38TTAEG0T--9LJYvMvyj2RJ87bjLTWHXy02zszn5I_J0PmbF17sehovGv_AUPozakU-r8hTPm7CWoavS2LfchF5ZykwiiX_mwMaZHRUsLoq-xwHC3q2_KnA.c_CNSqV5EbQmGtpFuSyUOfIOqUVMBTcMIU_cFAcDpDQ	\N	\N	NMwEwXT7e/A3wMCvwuJQmtVZIO8dLzyGW4eay2sjR44=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	e25b7add9e314f9cbc682448cd78d00d
3a1dc3a7-b0ec-c911-8cfe-4a52526c6c5f	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-23 16:10:09	2025-11-23 16:15:09	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.EzzCL7ehzz9yrrH1gkA7HASzQyRRWIUDKn6G3JT1UexbENHlUXOZTwbrk4rMN-T3pQH9KjimcvQALF6ZxK4uydEQv4T-7_JDxDCuhGW0fGbPe0tnUqNC16-5pbzu-JYTxb5KRt9aXnJ50Q8gid501RnkLp0dEa-7e5Qri1JdDexLTHLxaly8gejmp88CqAdzO-m-br-kawrl_b3sgUKyWSqOvdgO4njNumekvg_2fNK7EfQ9lyytmMpYnowl3uuwqBkAiBXMYrYotAVXcbRRyjF54x8-EFfD2u1GFjOEwFNDnVJfKfc_YFc5PhO489oCmgf3uDssdyvUPgiHrCdfig.Ja_wo9zu9Mj7NrY5Mvj_yA.7CptJErgkl5TSvUQjM8wqgOdvn0zQWWY1nbs_3cxBBfn3eeNWzygaAGewMAeDl2ZzHmdvvK54dqJ8TpNxE3Py-Re658z3tPAHa7DKi9-90K4xlulPdxsrNsPMPy9n0JU0NtGx7G-kF3uTchkqfnaC1lXvwjkt1kxuUoJ0Hf_jZEyR9X83nXOzJAAn4GjeI8g_PipdQGk0_bvfMVmt5iqxt4PFeGdR5541fbfwbmx5MKelIkwc0nHlh80G1O5G9vEnLXE5N1p8vxPdHsDBhvXnzigeHR6REmOrjI9Guj_mcVzxKMXKafXmNsR3gYzvsLT1-a2Fu2Disy19QGoW3NskgUtdyxgpvL1CWAMAtGI8kiSWVpuFEUHMKoCtAJuO1kV5Mtom2mNTi8Oco45NeAmZIU9PISaLJTRLnzEvt_yEOGDtMpvs_L2imIvSCeNwC6wuLDvklRvlCQYeQfT0f5MZNY66AfNkwa4DzsF23-GZ0CdVqkttoJktUa-GyUfT8HeO7iqWtE-HjThW8vHsta2Hk-_HFQ9aVRuNQ4aAAyegKaD3fSbvUS3voFSg79vdPpKdmgAC47Q8tWXriUhvjm67wCzlS1lQlf6NAStUml8_liWudFca6gWS8qGQTcgGy7T_VYNiq5wY4BsEQvy8Pw5KOoGe6BXSBLxYykYv0QFceua2fGU3suNOPj-ozlCUL9CLnr7I2rHL4v5Ul8CmXvZA-61c9XZQADfI8Zgl_F9vPYJWuumdqyml82jannmXPNoO3QSjH8d8Avx-9Ch0-6mSQo0QcxWNSzN6KfmWnBwc8zR6f5L_eZdGFP0KsmvCPPTeXjuvWsxT8t2jbMzKvlzt5rALNbrbWgeBy02hXd1Up32pHzHWpQJs-gxceyVz861eVgvJE5FCfHuPysFP4ofzwZngyjNPHE_RH7Jo9VhnH0FScq7tynzJnnDlUaTFFTcgwwg7xiGQfaj7fConlsfN7AWwGs-zG3lRSUWpU5DhqwieqSrQRYGpKXCjuG-CFYajplcy3dv-uYGNa8VQoR3aqZVPKqtSzC1pfi5Wz45nK2UCiuVzHJheNRiUaz_sSzZ_n4uk9khycXXbRM9Ta3ySILlA4sIwlJe0fq3GL1NfF8j71OszCS4TQqqPaqfN_7EUbyT1r2o6RW3e3qaQvIZk5n-l7uuHUTnzKYQ_r02lUJo2fut1yKU6rX8aQnBvSST-3GzKngUHFm54tPS1zoiSdOtEdq1QABvp4KOcM8qEP6ylHyjtfaVtzTG9f8V3x7cO67mAekyHpCDQgGBZaf7xmJTbC6SXKSeE_eyz0w7IlYGne3klXnDHG3T5C0qdcTXfKZ5yEvxhdOAkkYqHbX22fjyDLg1Yfy-8FAJG_5REJMLNfQa8Gi38F5kBi3PwqObG1R14wQexGlxU9kOosO2xVUQ6CGVU8eKVDdS2ExW9T9SRnTFx7bQksuHSHT8LVrddzlDrL16q6Tk3veREaKP45BsZk0UR5ng0uCFpcqQmGi847FZ-BbgX2-MwsuWzDQul3vjpX4Cpe6f8QTWHuAHzk8OqsvQHK8KzT91kYPzy4m4XDo4r2J0wKpNxfqxMyVXCOgZqxHswO7qZq1Pgb7llNDCPrl6KrwdVxxuBt4tOhu8_AP3w2qJTMuV_kpWGO66xw6Pgf4Lc2BYUs_BsMXGthefsb3OMAFIw8gNPnq6Fw-W8IfuE4XjZZ_NSo9NaDkh-sg4J2j6ehtpx_rRxOAjBp7s9uccRbQYQlTkwTWUXMPpcEBuEkduDBCjGcPvE58UFHH3m-LOEdfx6I_1TDFKGg9VM05yRYlhftr_pcdw2Z3examq5FDElEJBK4RfHLUkdsWBQCctipcqSysBsI3tz_sH-4W4-ZIMTk_NjrE0K-dNOfUrapRsjxIPdyfFyALsYyd7ZB9iDfoOVSu8seFpixU-x7INnT04UdHFjoxz2h_BLzBb10Do6w6oFFFv9Xxl6rA2JEDcS-6OJSdmlK9l7hQSloAcgTETVHQr7bWgErcxv9avBsS6UJouPO_R70QYlfQPIwFYNVpI5WDe_wH_A0DjeYIMIpBUg80IognfIbWEW3QnCNXkw8DT-2wKKX4XsIEOPxToZ-AAZwE_-zqMBBzRMkeLhbJt6k0f9A0URBodKtoIEVWqUeXsTa5JqToRRsoZ5_amRnpkZbwZpMdJde9Ou2xun5wRgyi9or-hQn3RTd6_mHPAjXMi6cVyzx5XuLG4dL5u5h8DFr6eecwJHqKsAKpojnq1dQdZWvNf35-Jvbi0LCUtva--QonElMRgLS3GrkSaMTv0PhW71hybBpA9fL0Vr2BMjC9YdjrFzr3w3ZHjRi5mK8GhEXhnShYUdoq9cEzggLOe7dD5NmZEQj0ZY4F963mbO271iy_wTlc-HMLbrfP1HHsRvK_DXZXL9NejIBMsXFUCmFXUFcBztg.Ox6z4982LcwiTrtVQoxEaLGARgu0UIHuaIDVGr4YSGk	\N	\N	9cU7sx0vISXHbUiQEtfMGRNJdnRyfHTAMVszlnBQKh4=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	91dab68070ea4169b98bc4e2c088e36e
3a1dc3b6-d51b-a913-0480-7ddce100620a	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-23 16:26:41	2025-11-23 16:31:41	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.HRQduipm9Le0fYWunimiC5evIu8wrDk7IcU5qJ08DKjYF6nYFqHpRdDWrx55zp7FUxdZQ-al6lB_2vNT8inEcSQf1SN1qf8xoWbwf6c1y2x0BobngaQ6a-FZ_rtuH1gyKN1jK9ZH3rYtOBKxGEGJiYV9OTLFq3mxWaSd_fBKo7G-HQiWmFSxIkn3W9cwMkJ1J7JR0Hx3TqjwGN8blMAFoI28oYDlECZn9Xb1s1HXyp2VNBQtXxCTKRl8-Va5YBEdZnzgYcABXnMcuHWCEQRUl-3BRT9CTh5l92UxruQqzA5TNMCRogZzgjux9w5Jwy4Td6rsWvSrs9kSxGwJPz5--Q.XHmEfTnEqgvi2BQce086Mg.7v0GdzDbnDYaTU2GFSIGEf1iD0k988soWOm6MYSbzV3uiLkgFctuWuKnKtXPmnxfRKbE6xogiRlY1-qmLvwj_6PRdxUZQlTZ2LuWYz2rkd12sFVvLakKL4rKmrIewVi00xe4gDtgxNnZFxo8IU5OEbv4aaa4KdoSvj8SSAlYj9IblmOOr1RVtmm5zKHBrnb0MyNbzqeHsWhO4BdblCPtmFd_esFKwPJYayAe7DThHElDGH8f07e-bYnUFDxgMmVKh1kaSQ8J0lo2lrwbUO98ucv1D0Jgw8L81FdGL8DXG1801jraxZZnmZkS61ZYBTK71eujBm-SVQE0eMh8-MKn2PrNvN0T6FAwe29dvdgtEO_jy1I0CJCTkHoK4I3CT7DYtn5ZPu1VFj5e0O0bWPGl30xrOA-np1AWw44N-wMeaHprMPywboft6KzWYNghFJpwbt2SWhBu5M4Sp5YnrH7Iwef9UitBlWDc7gW51L9R-oUnuZkQQVdka0Dn56Lbw5e8eB_a4kDSA4IY_159AIS0Vsu8dX3mkMLPZvsZy5rr43zcScFhQsWyzUfTZNhlJGNXpAxvfsDF3V5qLywnGJUSx68K3wGx_cuYSdrmn2UKOOz3VpfLRDxPkypFyW0BnKBr-cOPNOJDJ7e-7CrEVjVmAs4jGeCNWlfQl_E94KjVHHOkMYqgmVRbrbznNW-qAK-plLdJkZjoulnHB_9t4gBhixuKnBZcZS-42r3KP340C5fJMm6o5YIPJi8cLpgYX9nwpUl7BepzL1fBpgneOivJmNBd0-1l8ukunqodHp3OLbCRObylE-f3LQyJOWYb9KJQiaBO4JM-GFVPmFi5a-VxYMVnTRW8vZvswHYOne_Hx8FpNCGCr6nMgGt9A166sRVnzJniQEeZzYw8um0G4-b-tetKv6DjjZBwJWYhlH6f76mYCJasK89rVhUxkTrsgmXP1QXIhjl4RM-sWTC-hute4Ce6V3mrfhvQu5GFaVEotBNn8BfbhvxbUTazNT2zFpVTu9mdz9EYh-vUpXo7nmpaN_MbjL8fe5vzrDabQsuleLpiCDl08nbd2Jikz2dbTQvSPw5bSHi5zwY1asE7mWjXtiP_xOnDKLxqUsZfJagNyhBuKj_dOw5yyUve-MMnppWg29Rj0nshAep2bkBGowM_nnhzo8o8vCNZz650YrIHfWUTG3nowGYFLlaRWygMJuPCmqs6hzUchON1RS4PY1KeiU10xHk3MsBOLiB_4ZNGt-ewfxHpUs5PJZy1pwjjhp9IOL_LtTOGAo15YdeDCNPReCLJOanO7ZS9CxYP3xWqQwRGwRuB5bL-ItLgTb47V8oy-cObkRDHum63vRCxjObb9YbWOwk9X00ifKVXVfZbdQZkDxsLKXkDSMBs-Xz-nO5lC8SbyCnjaaYrBnN3iq0r802Qc_LefcV3Mt6y9GwGTptXRQo2ZiIZH295qOB0GFzES66O6FbnIYWrPAPkJNPv2J9oS3ytQfe4g68NGU9v9kgba-Sz-SP1zzpbwLHviPg5fpnFDsicwMDVyIErgcHY_2aYQ18V99DZOroExyIN2EFecAHNVlkPvSXAYTZy9DqF1LPdy1zwh7EDsCTn-5yAwTKtMkPzwNZPjDQAdSZd-Dx62r9kY666tRV0gct7DqNN_S1-NO21vQwtdrqFR5uePu4P650sxERlk8mA_4I_ymrbRrU-xCFy4x2Yb1_QB0ZEqcift9n8FLgchYFAEwHrkNqvsi-_CiFBUyIh9MJIq33NjiiCEcL6i1oMjRH9VHRsUvRbM_gV_i-JP7kzpmiQJAKOkAjuc8gM0xYUtv_f1f7H4h0BqEH55MNxYEgDqyXY55ZgVjRlv9o7s58qS0D6owA1tWsc3bjbsp_pD55AaUkN9jzZlWn8ngTZOU_EQHOEniGQ3y8TZkSJS4pVMPuo4wfNnK5pj3-Fr1-5ZoXD_V2Hh0CYcBjWNWEC7gX4yezyhxWI0d9G7BWsE-vdf1LgkhqPcuw1aFtry63bi2kEx7U7U43iDKjRGHdZbZXCauo43-ZPoTET3rB5a6eNMO08rD-wQUzCIR43e3ZD8qFXPnbwYHuIb65Thc__s03Xe4CJu5qloQSzB4gKrdk43ebOG-QyTX2BLLSgexu5Ak-xVky8Lbj-9gqz7Ztupz9MIjAwepqC7Vzi0OIY5nNG0qb5pW9Vr_T6eAqXSlezhuj2hBhbW9dHMeCG6B9T4c-IfXGZHKjMWNAlL8huwMzLLjBJhQEt5j1WYr0vw7lwTalnsmZ5PWD3sSbOJYj4hkXnNb8LMQp_UWJDEgYNk42vM3Cffw5wJtzgmAdTchRCLFH_boKZPWhzqlYJeAN7JBaXrP4vc9SwiEgRgnG4zeB2Sr8jQMbURC53ZQOwolQ_o_VO6LG45MWGh9i2JtocH33q649myjH52EWlnKPaZvGx26GDkA.0Wa0WjmqdWCQwZ6ynJuja4z2zMPEEhHfgfQZ1olSDKA	\N	\N	G107V5xeEla5qYGFoi78oy6IMeSj0WXLVS6f7jVw4TE=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	d1de4a311395462caf1e4a457d095f92
3a1dc3b9-c6e4-581a-f15b-c0eff6fe8667	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-23 16:29:54	2025-11-23 16:34:54	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.aA_O2CFD_IPr09O4mw7ug5Y_eGhQ1a98WHcChJTxQZpJCXgQVI5dOHpWJQpolb3FyjrELRNR_55rnnwNOl3q43UxMyBJ3gAVFjrqUG8VZGQ-NPcbZfuw2eNJvIoe6Q_9JE34MDGMEDHXIbq6WvxdGpi9iiFVUmA9wnS9r5E8WuHAy78_7AdlfC2FktwWPbK8Aw8PvpQwVtzt-jEtlFXPEb2L-M5QU9DiYA9o5rs_rCyO24NjjKa1SU07o0E_gpZIHAKKgluc9IIx3fHX5Bi3q3acwyeixmOYofYmdh3SWWWp6UNZzPExFMC9ke7KpTs1U088UrXemgtxidwZpkoHzg.OkhEUm0kOB-yUzv__sUNww.pGPppVXF9yX9BjQYBKAKdRxCfWzFLU9ghUxEsx6GIq5czCvjU3eve7lMPUsNYr5RGfDrtfGn0dSqvWJzjfWvZwfp8ab0dFYkZMHhsYegCXOckKdV58Ao-_KkruZ0S9rtEg6TuG1144BJEIR8tdi2dDHWpRqPazrKG7PnDI700vHIJmKYDifFheHqw5VissQGUR7f-apJV2BaxedMfYnOnr-fs4fVM77yxOwliRMdvPUPZa06B4L_pxA58LgVHzbRawJ13g2ZcGvC_U4INNSiqxCe5W7JcLH1yqHtP1bXFUQEWwZ7XrmO4jcIiCAcfKgQ--SQtFZqB_j8jFd-S-Mebw_c0LE46ytgSWVkL1tquLKuO8s28B7hA-9abKRF-pObmW8q_p9zTs64ZXqpfYNSWyTOtTWpukTyO1RNpY1de3MUyNNEUHPbI8Ayxwmwkd36huU7AK4wQJSHNdWEiXCn_bT-fMpkdeOoatwyjPZm7KA6oOvgm5ayPihUenXD17s1_bJumZaVWRrnXbWqbaiDldCSEBoIPxJcwFqgCEsqBUuNqlSqiFUooD7aYvGA1N_IOoujBPO7PttHoTLMsftEdYGTvXA6CeYoe9ajcxPoO7xFHtFX-G6dfCtv89zdA_ycP1fxq_c1Fp6laUb-_D1PWUxV6cpMuQdgRdxJPnLSSy_TF4GNy0f_EbVS64ff8JrJLlpGX2OkNpo9dLfK5aGLThisJ8Hid4JcQSm3RNE9jeuWjKK4PQZkBOOsStTwCUszv7LdlsHAxpymETZsGvzeXTw3dmsMJ-jWqd8fZ7kxWU7GDjfocrU_tUG8TyV2nT3E1pW-fMmckr3Ztv-YtcWjzZtf3hjtNL2_Mz9m_1ndl1nvQPzcVz2xTPCBhtxyn9oIgxtbiesBCboTZdzYkBvAFuBXDDDnakMKdnYl0z_0VjnOZebEJ8RWRmexH3oueq1pHrjDF4AomBwopKOuiHtVHz22JOInU1nA0zauLppkiGNcOzulClns6bSO1j5_xIltBkFakbckjrZlS_O8sfsD8ELAaep4EqWu7gSHEADV5rPaARwVQiZnY01Mhyd0oBGMpwrNXnYz9VdptOz0n4iyGTitNXv-1kD4JjdetAXsOhdbJuIoofGh1boSIgFzwKtw8dxisvqQ1HNlUJoRyO0a0tszE4hyRs9A-TOSDGYJMvs2s3G1w85ZDPhOiA51DUTt6EeZ-2p6LvaCmm3Ng_rrervqzUqeXnLbYriGb-1yhl1Wbl4tt4xnw3bi-TGAJ11fLKRkMr4NekMTPi8NftClWMqKge2N1qvVILCmjoLgpQvSN0ZSUF4R0Zwf3tDW7hIjfEabNWeyB05o_I9RvcTZCN8JC84i1Ui2c9U0i4zfevjOPBlI3mAHEpaLhY4Spxvt7OWsq0sdMoLgz4_s8t3SDi0nPdir7GG1XgZE1A2b1rqm0lhAXVd_Td5KaY5zxnH026X7J9QvXH_Q1RpdgKusfjghgi56iUD8TcpHFNKf8IsYLKsdpf0uPtIZfRqO7xslyORPnK7VLzoBdLySdIsJoTEw_Q7W7TySqsknqujut01HKI_iY6I5oCfXaWoGW_VVFBVHIKBgY6dV2l9TGWt5FKdCzkpFRDf0oC6W5oRCoMikGDYDJRcUy76LUlvCvxGx46F58xon-Xd-4muGqOMbV7sFJrx0xm4o-xX_8Vk6ZMC2n4guYdPkiignMF7qGbT2pKpUaNNeJauYic8HcSnhMFVzx_YQqj6xkhXKDge7LgWhmTIOWo_tFQeVJYNhc8pLo4E-JAkgHoQqwcGN5WKlaopwPHzEiFgFCNjiBdPCFGK41NDYQjuXdeK3tpjNV__PspdcyAVJYs9E71-nvlf688eOT6gd4hnzJKODjeoFJmwRGlwv6wlkKNAr53_rozx-GDYr3ac-4hS6rw2Uyu-jKPXjmx4jzn8OAcFUNtDjilLKAxRMioB_Nb2Bqb_dzw24b1X34I2nb3NL6ok7_cR1vFWfsWq-7YU0WWP_TnnNfS7K20xkEuIl4zdxbWvbt0Ulqo3_MJILfEjZuN60LqDipceFsWNTGeDvEEYhrUOaSWsD7CibMsbBZIeH6SBscpImlf9p6_plyodzBG4xfaid5O9qm7m2hMzBypBXS-D5PYq_5XcYvfK7FNP5-Mk1Au4F2NE2zjhyt8sRbMsOgXkBHL4xQSsFYg1B8o-uKA7E6_knMPfmwzSXUL-LOmA-HrmNY19hEr1mPyME5XVSWuxRdOEptkWgb5JLvS-GOx4sBIVsApFkU83CYVdXxjd9cUWlq5LNjvcuaQgrXM0L-V8R0Coe9t0paO2U--I3POQqgNMv9knPtcl1AX1w-DRBV8ZQq-ZrVaxzd5KWoCPy75IIWro8vlS3bplItmwlufAbOo28dSIP6D8yPiNE4x4S-VeVOsIeS8IbcULIzbyyO6rDCQ.V6VgUfbo721r9BVaibD8kxSyFyHbT2Ib5V_Le9qlhe8	\N	\N	YTT2f6hXmdMBhoyTIYtbgIcwvMK27JtalyHXZP+eUbo=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	16b0928c8d324f5793ac46b2da09519e
3a1dc3be-8771-43e6-58d8-10c299f9e5de	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-23 16:35:06	2025-11-23 16:40:06	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.HkPycewtU_4a9DA-FnUpaF2rf94L1NDoA7k7IchjfOgLoWSK9uKYO9JjAuILh63OrY93gtjaUDIDDta4biG23wLkOfENtMEUtYksYrE2ib_kQALGC42PBJPfgL2o8JTEmb95OiVXp0sAsCXsci_Pk1pPl0jMhTpmw3ilmDOvPGcuX1q2S5MI4YmNxOcwROA74SznY4EM0A2e6_Oxj6JqIcDxdK4ZQ-NUGcXpSbKoPo50GOHSqO7HBd3YOAcdQdaPBs0Xq2rlVx77sNjf4tlnOiuCo63AcKMnzD81foddV8zuXIjmJlN7YbzHaaAFXGhqZJvSccvKp4vG0GXpGoSVaA.znSEnx-u6GKQ9jC6y_toCA.9on_xsiBl6Lvmr-lXRDBeGzjIxmit_o4lrahq6ZTFHEL7mQNe_63IuNI85XQXcm8_odcPnBs5K1etxTlmAA2e1aSPE6GHeGF27NLwLxzGuW4SGL7vjRLqFD9jn8GC_yzFB0HznFI4Wal3RwL-FwP18rMqmCO_z_WM1P_cSZ7qeqoidLUQfZETV5I69Vp9dWdtmE9T02Wq3IcgrrPQWNXzCxaFfuULrnA65l2crL9QuUFZ8_ATS6p-ldqWAyrznmx_-VbXD6dXQ0zx0uB48cASDcW7SjO5_HGgV2RJJTrPk2t19caKxRnJgGwHB1iQKIYa1YLYesWFBvbSoJYHa6XBtsi3_dTZzfOBqrxuwjMcK7DyH1EqFlVDBkpnNYv__yOZ8NAiMbwvQd1lZbkAbaULayDsUR-iRjHQXfFAOc4-TovUrmM6Jo27tjPeW8DyJrJoO8g3H_Nzjtt9LVSJpUH7-_tiDxcgY3OM085h5R9AsIekw1Y9bDWZ7zlBAIMvPF3hbXDSJ1sqleuI5lOMgr7xvK5uhgEVgJAldqTXX5zCkwAaksKev3D1ZUE1DrvR-vARZdNzEKaAT8FLq8WFd6_3p9n-DXHI0CtdNC5r98RtLb1YCZ_njzRgcO7mSK652RvHSDGx3xshNfx6ogcyTzGtpXhDlJKUij4n4AkLVCpc1Qn2zUFT-J_oTf2fWPGVM1RPDHZkMVFZUv4wuIoG-jKmReX5k3Fkuz9lzG7rSoWairoT9_QRjewH2kpCCZdH9e8GufAfn3AVAB3GsOT0LnF7basfdOkYoQ0hy3ZWQkupy8UtsjlAk3lu0ecPAdNbTpwUq5j3YgUjVvgL7xrhvIIznunSu0kvJ447JI73KZ3jkb_hFsp01s0rp41zM7bGf-gZQkx7-DD5oRd5AYCteQatiRj7v2eRQK9yUh2qQ8jlUN-aPMqg2rK-v2hHyniEHtw7fwpA84NBxylMYmYbUqEVT3OJue4fKro6BvkQq10kIWM2_kw3Hum9O6T5mFQyYSRxQ6t-E4fZM8wXnHKtiHV1246_75oZzjkPteD5KxRx8l2p2r5ZQ9y8gvnY09ds9Bi9eP4pRNwTXOcn2OrDZrkiVN2xvBbhKoT9WuWdb-iMF6AR7-_yJ9MTSZtJlklojchPYQH-B5x1N-aAZlhYKH-zL5HrCFUdRNNR7tixpo41GKuWjH1QGhNq-5Er63Xre5KYGmVOD3RWSU2dunDSq9eWUHok_Zhp3Sm_rMSDNYbeITncGTeCBI-tvTq-_cU8kb_G3xdnOvpYVnbyqQUT3HqOMqL9x8XdEajKT0W7GvORdEQU_36byxaDX2uIkfTTpQNrAIghSZP0mPbfdKZNX700uFrKgpQru6y4udvxSECm-_4DAgsUTJoYM_Fy45CuvgrYfU6g7X0_F3bmDH97AGUu8_zwKzcOU5EPda_J79yLFh1EIdDsCAHbMJa3KVrmpTdCIpH8aqy-IS15Ha9zRPL38A15yrnCXby-tN-QhDoGz5teMzFPPqQYXQbXbmydowW_k6v9L3PLYmGlHwDzlav1idQsWw2QS8nBPV9jXuHwFDyxss53PAc2JYXkMfQfS5186vl6y-PNA92Z1By_D6gM8cCXRavcugEKhyq4xLxxJf9ytc_3TMcqWInBfsMpImU2nR3x95g9q_XinoEKvimbG7GEeuXPWONWx99bLJ_Hzs1p4kSC-5oshhjiBOR7UyMR8xocilfKi_YH228uvo438S7BoFA4Jp8Ym1oTuChgzzLhkSrT6LsWWizQUNizwt4SqXhrTadahS_eOeVJiyb8q454p1T8J9sJszYxw7_sChDtm1C3xVT5QC9xptZYPKFS5IWvLRmjnvNJ7gd3t-5QlFLScfEu0TqxeAPEaYlHYjXYMnHxtvdWoXHo2qjXXflbpePm4c_spgJVWN2YzsbSJnJmyTsixbMO0vwmIfKUwjUzCkBB0-GBqknXtlj06RA7RzCONwH6L72Z-P49A1iki2wjn7OsGc6HSo2UekOVVux4k9vdVWwa9Xa8pZYMpdGXflnQpVdKv6_aHqJ4ALuKPeUNSCFNm9FkIgNGe9dBH14CIw0bbvgfIf88Dcg72ODgB61f3yfkdkYOSGHRqxA5TLP9iGoZuuIrZM0q5TwRgq_qa2lLMbcWu04lscSbfq3W80_5MhGRmFsGUl4sxFi24l1To2EFCn8STIDr-kpu_ZGK-AkLIxpBgyGeaX2IqD8G4Xqx0LlPdt24E-YQrg2HGEiDLwy2OmBoiizLODIyaNV7TGAWlG5J3aXpcx9zQVRlwiK2AUmxpok3j8j7ziget6k757wDRTyRj9fPsbJ-_Glga9n4PQTcxz4Q5xUiqW1ytGhKxItB26YWh1HPvpFXMnZgv3UnpZROfItlEmgpqFIWgxoagCxfF4udUUuCOV0F8Yw2l1QWzmWsnbbxzARng.3dkVH81g8S1EurrIKcUscS16PlQ7P7FSoOOuD-Q3ivg	\N	\N	+k75Q05Pr+f/SeGBcy8bEbhsW3DOYsg8Eoe+rIR1IMw=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	732527bcf7d84287892a6c62fc7e6f3c
3a1dc3c2-0e7e-caca-304f-6689bdccb747	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-23 16:38:57	2025-11-23 16:43:57	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.DNBJ4TzyKyIduvXLcy2_oFYzAb13VgkWCZ_cTKpK4dqdZJocD73g2tamUcgu107vkUStDwo7SewjDA3JeajOAbfiqEICVbacAbsvG4da1zuTpljnBmq40Uv6nBdRY1-JjAGcoI_KLo_9IlxzTOk2HPUn2DdG6WxFu17F6mv17zvKVd3U7jaPNJ08gw9WGuXTzmstdgS3zPNbP5k3GBwk5MMgdWBeJmd6qEytrtz7QJ3mNYSRc0az0ifRQxuIzSJ74UxljCpy2uzrpagcNxOss9pUT9ySUmFJPpU90Rd1MvzNEIas0DBxF1GVh0wpz42RNXtOTWl5BP_xTWRibcYxWg.pHh6dn9hia-zRzAP5XSmuA.986Fx7z8h96oO9W7Ih_tsKnsNm4JX7-Dvkc-Pqqdeu5dzGinDo-H62uD2NXhPseo9Uw_wuRDUkJ7_0PqO4NbjkdazrWkU2UlizndD0bxspFstrPJsnRm9pq9AmEEw0ZBDDKKvQYv0_Ub2nW2-sIQ80xGPLFvyN9xl4QlTJowieoCst14aoR-vInlrR9FJtRkJrhwgyp76Gk2harl3Gacwqp7DSSQi5sGQ0e6Z9xT4t0djdWVJgJa59cvFt8iaS99VeagQ6vFymyh0vtoJVD9lOezGowW3QSs973TapHlKnYZ7RB1KkKYtBVqydC56hfTMhDL2zlZ_F1etGh3Q2IeayKwiU3JA5fHTPIXCkVtpsDTIM2DzihoiZYYuApn7rE5d2VqxhMVhXo8_bsI7P_53CIzg5-l-rGEVZwK7d9uumjTmfBRUA2Hw6iPFoVHphGZhTZyTHiAw5lgLs9kCMUP70iuCP4Jx2hdJuCBqZS2KX3qUkw0wRGFTdTI11BpLfrxyXxsAJw3kMaJyjy2R1y3285EIS8FiG8nbCRB3iO4rm98PKoudK5d2xI0i9UwjdN5GoKhAHCbBGzFiBJ3AyKpxOeXaeGaOlhLkpzUjE4mWzNN874Y06npDVYF63Xyl4KcWlZYzUxMFrVt0j7iksdYGHLr0abFd9Y8QuCXzptWZ2sqHyOnzY0xp-oRUYPLwu-Jvqt9DqWAOyHpyBFfrKHrPIG_cGlGUgTqWCpmTMhtWMqBqRkPh2aYe7z6jCmp4bmSugE_qhq6RkzxCe-aKQTArE6hm0iX3StxzRZUoZMNnn6_ElwOufgLDB2x_-ycH_9QAn_hYU4lkXqjHmp9u8BiIF4K_mdRBeJprHSbnIyd11AAZmC-xwGCLA0aH28VShAuzZmRpKNbasZxJzebQHYOgyNhhI-vhYsWBZ7-P5AjF3S_zxyQGqQr7FWsd7MkflDwRMDYF0SMQFsivviGpAfUxlXuvpDXrS0aMCKrTMmvE9m1yOOm5eWvD3Fb6vdHMkXzike2R03einJHM7tE97Krpp6w63g9EdW0O37F_Mi6yq92cixRt-otViwzMI4ZIr6D__g6f2_U-vb4QKxMlah5cV8VrRHVbHFjTW7XhjMjUNlwGBLe-UueEeVp-R43c6i3C7-eiLBKZp-6oQ0wRXgJF9YuBMF_l4Njtuv0cNKGUIeNE7nRhKxTdgg12gP6H7EvDfQYqm5diromLBfxxxd6NOC6p4W3aukC7BgNYyZjj3odFs93PmJnNGArJ-VZpUhk6YtQyQqU_ur4YtTJFT58EywM_xzUqJDiN67NKLmjHRUaejfDZa1eFrcrzlk7OfZ_nNb7w9x6cbl6ps-lqV_PrDz4T-PSFOJfusy-MyOevrrfkPze2zkTvf59rjZVXhCbTgYJqmg509Qn_8qXpyD4YHGZsmZWeoLWq_zOGCO29LxOrNdP4xfQ9o1IuXQ7VzvlBfrOvS9QFhp6JeGwB7E7B3tgyRLoirPIrO0Y1PVPi46rskN7fGAyw4dHsQJt1LadGdiJMfWWTelgvWibCAXbk1r1PgXjoZCRHCPxBdf-Q2Doyp1LYw2niwK-EC3EM9mEkIxFCwCuY5Q2wkq8hVpLscmXm8gB42FM3JbPvktR2ubH6VnDD4L-3JmhnUenrFJupVjdN4e_Mt6k_w1GlAcTFCmOyq9t3LNYqyNiwk52tznCMOMJ5LPCpoXzK3pFjJA7b6eOMOm7gqbk8q2n24-k8YwtbxbtsH4HTNTpZc1OwPKDT83ysdoR20J9sliRpo2gWoSLubhATbvTDhjQdfNQkGH0ecx1g8ny9FxHcgQXLe4cvCUKhXIsuwHte80XhS9QrRgiXdDhMH61MZaGL3HEydH1Fc9IObxfhbPkZwFai-KiS9p61f7iLWLXXWb9SQoY4hYrjVGSI_aigquJUDUV-fLSgzsTgX5zdI9vNrOR7PJha5PjZkN3PTjk-nliLhK008YF9mVnaxmFatNt1hkm0XsBi6Dv85EXTe0zpyWs4XnQBxLdGqp1Pt5bUFAgcbAnEJwbOt3LXoEeBXpexgnWpvQ59_x7I3jtGMexGfYQv9k1OkSZY-T9wPyKorNaO827lz6eAi6_P-Z_t8gngJD7CKFt6qtilvBWByJt5wq9Z6aD4i5ZpEj7YhtgFIH_4uxTOjoa5JnUHLRy-8NVLNdy86FxOJcs1anVD8WAG9qEcpm59p7GyMYVBR7gtFryerJFFD4-U1Km8vHcZEMxBs_MmFlArUm4uaLznqKrB0TTE9XJWcyHJPHTtcAnlzq922kA1RGpOusZc5Qq1Vqff1vQeLisyuU6_KYP5KQv-QyN0WxdP98GIPAufIIvmiA_cDP5hQ1_b3O9wQ8wD2o4evU8C9ljy6WqF7x6aF_C8ikb2tSB0ikv7hJu7JO6Os36-dvunN1zwTjvZ7uiwWwzxECFAQ.TPdplg3gloH1FAB9cbszlJaUP88ZLBsSGYgA0CqkTsI	\N	\N	AqBtpBUkrurN8AbLf6IfhlqUZkGwU3up+O57CWIPj3s=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	d1ab44cfc0d349fc827adc9e716f88aa
3a1dc3ca-266b-0e9f-ae7d-d921cef6a462	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-23 16:47:47	2025-11-23 16:52:47	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.Xzb_RXxo4P8fFmwo6b5SGbnI6b_wD5JlU7F0dQxoXw0SvxsKn2Ie0fjv4rmaRtUPzoOCj7CJ2r-e9pZ8eWO2rejNnYb03raT9OaR0_ZKB5EwOrs6uQKE2jdzVlJUghRI4bmmSCmuQMdozJAGFF48bXscCRpnkNM2AUhKLMIX3CbliRLnZo7KGWLpxAtPmxJviR4uIYNgXL51zd0fxnSeY0ubXLueyZKWt4f6ROXEuBmxaw2mdyl3y3XZnjHbVMt4l-LGn1b63dL0YuZpRPHPokHsINASp_1hJd__LJN6sgO2vVCnMXGkJKY76iSfxvlYcRiBbsmS-7VTjdS3aEfDrQ.Yi7iCeRaXgoy9gaAbvczMw.2WS2bvzf4cztMBsNGObXlOVH75ee9JwBphh595FHk4zcFixu3TFJnk3Horzu20KfHxF85YiODd_pbwUNu62L1odLetwkCle4X4HcBas-KLmWhMQ_YBhye9UwqRncfft0uBwhgD8uuHTP5KxSWkbLUnD1HtNHKatk8jxItYvszYBa38y_f_ZNFbIcNFrvXGD19sgJfhCLcDVVdKlbKW4C1Z65smQLMpafKX7ZrpiyRTi3cscFhZPm_cYBizNSry2qsiLgjSepubSp64Q_Ukpmzt4QsiCsGAL_16mSUJ89FoDl-osS68bt-J4oonSd36QYesbHMWwoOXNWWGdF46SNAbe-X5TNEo9zd6X8tuWkce0QS1sy5z6TNNAe6eCu1hO0j2s2yLj5RZUXJ4nCjUgq67Xj46u4M_wyfj-lB8NrRuqtULjYXQWMBwPeTT5f9BWu56PxK-oRf8q8wGH7Bc1KKQSBNFN1oCyld8hfBBad_aBh4pyhQ_N3XPnRR7vcIRSA0YauUAALeRXO6_TLa0r3Xg1uoIjnayIvZSU3oF1stP9tfj5EVCFjcJv5KhYFQo2DmfRWwdYG2IwWYqQ85oy_HYRnM1qqMIZlBEOE7Kdbgvr8aWYZXPBUcO2W6Qswfwa_zpTN_ku9tNMHyAcwZlAdtzp6xkj63VHUGnaJ1BwdwlhbADJR2zoBlpwC6t7fOkaHB1nqHZui76urPsoopkDj2MhOit_Q5ZSOf_fr5Kf2C9EBBesyScCRGBUHc0ZL8fISFjCqccnVq-3fpfrOry5xW5iOqldzr-EMED7nLsfKRHizvaW8GgqinDWZUAUbJfgl8FZXoH8rK3CyegM3Ud-qRVSFZbqbK4XKkRikgvRF6yUnKl3QS58ghpXkXbH8Ryu3KBhh-WPB0V9SLjJn2DQs21o6ZqE-vzMManHK0mQRYM6svtBKIqWC-RKjXg9iHSOtS2SrzmOQF6GWAs4rUIN7aiSvNkdb6KielgeD9sCz2vEtNwKeE2WtyM0mh0ghfaq1Sm970wpVsbJGT2KcW-PsYVC5ThjWa6C0tyD8z1srx251AeqYgva6lZx6tK3mKaTiGPD11AJGaZMididwfRl8rMSV3n2RfAHaryOFI_bHRbT3TbV-5ZKEE5vrL_NTZarUxTytPo1nXw14PeV9ejmvtEv7ofUExu5NVpog1fsUx720RS7YfLyK8Lw9i3rsnnemX9BTfV8eeef7ONagqfgKZerwa_AE15E1_bJGFn6smgtql8wuWnxdQA7jXhfHQcyx2TnhaQGzSy6fBUdoXaeiHeZeCKhLw72Li_0mrr5I6zkJL6hOBU8eLYrrRk8ag_ntjGBnGBFVHZyn5I-IExF_j0pkW16jem-9l1GU7s3081lbbo-CC4QrTMufP_FPlDIedosD98EN7Q8HCFcHbGOXrGicr48yV9-Zgjar_7_XB4krmSM9-1JNzsuQjWfigujyCOAJYZe8PgND6NZ5XEKsqCbpqTpBQZHVAaRnujQlAgbjT7M1PRGQy-xQko_W_cn_vvqwOm5bl0_HPQuA0XVg5i4b38ZOuvYgNDjmzBaJ0_hhgY0FUpS12mdYwn_X5sf6vvdg9PiQV6JC0a3C3wqATvuLW4FkR3ctIKIBsjhkTBYZbt_q-KtBJ4JM9cnLF3DtdFQw6KrLo26CQnPMl_Fxn9jWyNzAp9w3YR-x0G8czg6hjgQycgj_3T0IkZiPN6kM35tmPQtOALwm_6cLUUn5ZKFACnqGauU11C51oaeR3J0UDQ8NCaeSzkzzs-ozbU3PBekorI_ZNCaJ--FnGQeiYbR8M4kNwOEIbXvmeJfE914-a1weDZ2KT2GoCOZKq0slSqowizqD5mfWIpoA8V3700iAEMYmCK5N5Y-HVTviQBnH6-GjdJJl4PUizIjJfG6lMJbM9AzMSEzXU1MVhsdU46BJGyKgHyNPoan1CIM5S9qLiqqy_cBTwkLrWnwsOzvoVxHXsR0nZph0GvosbOe9OBI9yq8tz93S38oXfqWIX1EDlYIW3KLz5n1xis2voOao9GWO8Cn-xQ7vO_hmr3RxcubcGQUjiUMqrskacEafnxCZba522rMgYkyKtY7PM-lZBb7s8Iu9Tao8ckfWAsWxwCcXTmoUR7kM0-hfBi6bIls3SVTTGU2gMlzBakQV72cpJ5uUSHlzAY4uq4X22Z2ij5g3WZch_upqsSY_9twGTu9KlP_7kTyke_bJRmYbnjmUoCJ66dyn0j6i_7sMcu4ncfWT5Gt9z4X04AGqoFUf-gtiTBosXDrXYaYtwF_dr-q8Zdf_3_WaiKQeLEJMvv_kKjU6mItoCtuBeU3jYk2t-88oh66aBV0fwRw80vRF48GJtrHq1A-6PLRNvsc3wsiH8ngTOX6cioXxu8v1z_7bAUEzhXpTRjWkgScYqIzK08gBFO82ku4Cc2fHNkoGXjw3Iw.SwGfSQ_EZoES7QoMoIQSZq1tIHTfDI1ThM8Rvscz3-o	\N	\N	viK+ahtm1MrJs9ZbjnXDumlrBUWCRixRgAktieuyBbA=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	6f412a42ac7d4dc496ee649d7c7fc9be
3a1dc3ca-452d-349c-8f72-707604f049f6	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-23 16:47:55	2025-11-23 16:52:55	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.uAs37YRL_cRkGYR7KOWSaSZjP-teXVF4LFjQSqf1vtwVHHwOE175bEJrKhVPPjTtpDI44uhrCNwndIvocGIm-cv6n3t8V7oG0s_vGvScasa66rHnYzMlGQGSPBFpkmPMFF1QkNIj0_9ZbgofIeT39Yz-3MlGnbLU4Hy5C9RlplBa-xpg2Fq7GlnJHy-8Y7F7AenTZJIx-qJyawr2ic44sPFjx6fURK9bDne29YQSEpTMtUuMR4_Gd1WOG6A_2hqI85_6b-MW2s2Dk2ErJR4YDrB38EAb_inB16rAsyy4WEmYuVWG_jyFZAoiUuh5kpoXnPuMJdilPBF5P5C72kfaYw.iqH5o6oydIaBvwSt3DDOow.RhvG83Pf0W9BeiUQJ4tiQGxvgyHbPVWlIHkZpsn2sJrKfoTAwgDOHfR4FoxecaR9F_oXgD7T3XtHLQt9BzOMU3FFcDRODt1dMUPu-xflgDv7YYKSoPTBbWbcKfCR29-EIhtaEIAdRW5IMyee84cpX3AP5jCXH04FLdixX4lHeR2swwKv60vSpLeobIb7IYlNc_CyvgAr3H72hDz2j92TXCeuPqylgBhDULsaZaVc4FLeV34T-QTsHZlgxKf7DqlAuXZzMiT45ayTBeMUnoENKzH6aDrqEi-ZG-pSMrh0XhxEfyUgGWzQ_s0Zjo0CdVcttyRilxp3MZG4QD_I74-lLeF2Q5F4lj4JbRKvAxsqvS72DeOjZQrV1P4c6Cs9a-nHldm0vKYFSwC-SLnoNFYgYmRS8o38PqjDIHypsQspHKdvgIbfb7p48axyRB39306irygaSfLeGfcEyW8LnmV5OLe2hiagz9SRRjsU0HCfD1a0NnIxiImX3hs7eYhesjcfdYFqiBK9r_O3pxyQ2nnw_QqxQ3XHArTlQ5aDXlwJOcvuTYd5OJaUraKwfD4pI_osPouvFPFy5GKvijd14bGtVQG_4iPIOlNDO-9K8Ml5FWscj4dOcMhx12ZU_UhZty0bJuHdjX53BP0d5Wx7If-0ySpyk2jZWpqk10y6hfPO7TPwPiT_QUMMp2DM1kzpJ5FPGZ-nyUxgs6ky5e--7RAaL-WaGmoyqioNBX1DgTtItpqO8ig9Iex9CWtRhY3a8rMQXNs-eBQMtdwJGpIIbIMCDukGwDqBh5w3y_HJPVmoOEV3RvWDs1pqRM31C0WpClt8xlRrtdsWBT7Mg5hOTg3840QJTtPl2y9OX9Q67g6_JvJ8hVCMqXBHIlL31KjMnLtjnV7MLM3uIn7z5NHlfks7UE-zrY1ezmDwgsi8NV171Pao2OWN3SPZPzjXqzaEkjc8VeKC9qIw97sEDizs1kh6IXZ2Qll1Jr3YRgeOhrzYtwdUpcLhe3LjVe3o5Ko0N79ftr3kMsUloGgzSN2LZAB92a1tGZSJQXQBVq7avji02T0f7QPOP3k7M5nmtkx4CPkqcYTLHwLyf7mJQBdDNYcG0ZfoOKoR5kCGNWEBmVYj_Zk9UJUDHdQu0WtwNXjBeZNRqeeyrQu2tpj9rFQ77fujyei5YeXebB78hD51bq1Dox5l_GYXIleZKOfH7Fr-MmQaZ1_MWTuoZZ7XTKxm5dp0UMqCqpSlPumyRJbVcJS-YCV1D4sWVzj3FVJbFKT-9kIjVmwLey-AtM4C_51yLbitsNB5h2W5N1dtsC0-aDSwns_PyLiAp_BAlgmRbLv7S-HPgSDNXyNdoPPuviDpansEjPhHDOn16m9jBOMSSpH7UNJn-oxwjkWUqUF1K8cpoSaHq71HaZKZhqf0AXbjvDDNrDjQ2o3VQM4rAh7b6lggdzoMUzsQ3lccQsJFgOZEc9UgzdyDCRZ_BaVs_z458Z-KQbAgdEl8zO8Rw0G6QS4WR4UYZURBbxtdvxMfjVSiTZYUj9MDRQSkZHBS3YC5TecbQ3BI9wlVY6Dk4BSQqnQ_1oJjTp2L6cXPR7MzCKkEhhK3WGVF0LclcodSCVN2TOR5blPwP2qf2lLSqf-2QuzZfW64O23GoVO84Epq0bHH2yNNewQqyF_2cB6k49nCIiSaVMcvkMgKvdHXEttPI9fpYSXVJhzsHLpsI4f5tBmddM4LAfKQLVpJwPiZvLNMfbZjbodHL_bhqo9Mpd27yjU-eq7KihKnnuVQbxnbaA8GuxjSutmGFi_eiieZRSK5LyTgZ86OaT0pY8Yd8GEkYf0DMKJiqBe1VXbghRukNDkKjIb1pVWnFL9z3MSGAqnvq6aGvDkeDsk7u162parbLU7YkI1jhU_eUhyCQFbBxGYhnpKdwkUxYLbgE5AweQ1CHx2nHbkVJt9_eCljUlLJ7aNwFlORWLdYQnrwZZngowVFAgygMlwfy6NsYsk-zez6qaSy5A-_rK7JzoCSqtSAZ7ExSCCgDjKGe-RG6wWtal4WqgHkqBWKC2i3t0DAhieEI5ifexyQ0P9RbSf4NrNIhU7BVBGRuEVVjW79Nf_XEy4IEvI2idNOcEfbtk_4AyjfrY59UgP_U86s4ypo0VOtezbJ3Dd7h18q9BIqfF8qU4hoG69o0MWlPs3qrbZg12PHFJWYzqaro29Jja29EtKG-_GsmCDWlY2K6zOWKTgKL_ll2v-l1En2Dg8u5K-muWf57Q5dBtPT47D-hgLSWWMaek83LQpNYI7XSinSmSyddTQYnNcy_KWjRYgw1W8ii1ohay2hf3Z53m4dpbd6yN-JDsXIZKuVknCOa8eAMKOfIBUfSnxeT03tljLG1s-Zd7Sfw1vaP5bAjWBPslgSX5WAsgzGtN3doKVslPlIJGroNqelE3VWquM2QgTa3F3xRg2i0ujr2A.Z300Es3Npj_6J3_YeGuXvcG4Nxu3_s8wM9xcL2ZIVus	\N	\N	L+1sBv/Gu3BNKSg1qmNPaf4IjOafhjNABhcu2xHrUpQ=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	cbc0130244194bb0ac79efbd07d80591
3a1dc3ca-484d-58fb-f372-1ad0ec9d35c3	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-23 16:47:56	2025-11-23 16:52:56	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.QTWa2m5osDSx22hiYbZSl4LX4Ik2hvEiI8FexbnExcR-WEM7b8i2d42cOLxSP7nYwoUTZ3WOWNF5XilLhBjNcjSxfIoCdzflfe7ytCB8MmElpwP_ZU9A6ICgvcl1wnF9B5-Nfease5eG5HTN0k4R1ZGxwLQCeQn3MZstxm1DhxOo77BJhDQj6e-yvBwkqiKaLq8TsKBVHQfaGX63N8lsR1dI-xXp4ERro_Gji5bHCuyq7FYxpcVLAhFKCBUF6H0qtvR2sxflUhdJ7sXRIDtSnbAwQcSCwUxZXtpkmiFPEPE3-iHJNeQPN7jUnwOijk7T0iE4MgEeRZ9UJZxBA-IfNg.Y8VE7nE49B0J5I5hsQGirA.zcmbaYO81Tbnc_-gR__rjaWDybdYRbIBHCl3qFixii2ZF1X0q8G5K3lB7UIB8ww40IUWow_KxvYE_mJaMgBTPMs4k2in8vNsM4mhkwRRjv9oCDBK_gt9PG3xwUiwXIpQRVmefMAA82W1RJbn43SwkS7x0juV9aMfJHryY6zOdR46wHj6tQO3ioSryaaXiC7tTZrEOj5QGTuun_g3d6a8cD5pMSipH_HGl190gSNQDXHA6TcGioRtNiMJWjmfHb5rLhoAKZnm_TKGQHvSt3aL4jfk5NOO0K75jIyaa7aTAppzpGz7W0WiDWk99aRH-LYfDqg-01uYYQPhWL8KJNWhX9rxANvHNE-M-6CRsCi5ZV6laeLyLeaiSVrAMWhWY7QtLJm6cRPt48BlvApf27mxnxBwv4EDQ1HiEIMCyg0hNIRI2nOfOiR-XLV3CGFlt57IP4Hu9aI4p-ZNpCbEmTW_rIsOu87ZrjdkPwtue22D6MtkCnKP7cPYTtGNkP51pduujw7OaY9IBIgIE1QdUqV3avMX1hysv3h1FjyciGmmN1GsRh3YoovEvAbUhhwtdTJxHLua9Y-jyEd4tE65IW0FXRp96z5QcdpOhTvYY8poUSlifjiRpTaNn1K-42oA2Pwn7Lt7709CiBIr0tAZ54DFQhXwa5PBtHowlewpharlcmX-mrBeP2kCeUUIkne_3_J1I9f0fqiv_9r-GIavk5_LL9-GSEALVx_KOv-lbKBP5g4tfZVnO37wc1D-m8iqrNTCy7eRZNw_pToDV2Nnnvhai07NIPPBJ1OtDPtdYrtos2_K1bq--0cjK6IVlMrVoddMJeNH3Tpqt5bnOq5xGXFaRdAf4XL0AOMxXlNaPbzMSDa-iDuIyC8RdwhoIoHpVx5k9RDsoALojFp1OAJN7euYGeUrQZESiXAze4k-BNGXSe1aiecHsnvE91OXcp8wbIEdb0IwXHoSIlp_KlymCmO7pnDYoV5N-MWJ9GBZyrgiAiR-WNJQBVA1N9KhE6lFRyws_c-oQaCUcuOjwwDS3Z7TElW7bDJ-LanMoKCAYmUKWAksJchLHBdhHkN0hRsI5UQY4QNF0TP15ymp31ELjo9nYcV9rxYcKFYgqn6ISQWoKjqDNubpxt1-oI4cTtF2IF5NC2vG4CLB6fU8IQfJiSa4MVsNB5JB7M7XBfeA59a005lLL6YHiF_jI2ICBHifITBZ2dZldjujOHiTC2S4dqJ_GkWSpOxZoEH791h5Bg_Urj9-SaAzKbAzcAlDERdJwp1vWyNNVLTMwU-xA02R0DSbXUk7SmkkHdiFQAVdHgsqQobq1FTOjKtYh_5soh4WdZH1FihiApnapEFpzPSncS-Om-urlE5fbiFA-OkaR9ZbZApbsaYwprH9WyC-3Y4OLtJrcos-bZHGsrH-kp2gG4UlBClhyKb9prnvf5zbCnfMVA5aypcxzjfVlfYSrwVIk62g620Zu9Gmj8mvFI3Pz-96ZVfboWZE_BsGOVACpUF0-4BKArH1pMJg5-U5Ezfe7S1HOHxc5K3jqxvTQAbAlYqW5qiUUppFistSTlq68jxZuZCVeTCf0I9McbcXCjw2fibnQWNYn75mhPQXTnftALsSd-AU9i_T_KjlPDTeVRKb7rBHa8ij2IJNZQV4iKBHSrPOm3oLU-pIs-lHNnQAnWDXUtFee7KrEzA0qPuFkntmmt1F_gREQDsqfmxOdK-uUkPs_D32q4vt5d8vQuuhXJwp6_9lY_Jb1WZ1B4Kes0d8nXNNx7It3irhJ_MEo9NZDCQtQ4ZK7JbJ1PDF9E_U7sTwFIVtN8ksGt0rQC4YnAj9uemKNzV-a3Gb-7RZ_sM3Oo1hfNhwQ1RkcmZjahXc8i026ERUt5YGf54WR7xRVpbfzMk5WVJF6WZvCMwf9MAbA9TCnZ6nSx90IGSG6osrvfErhIi-EWnku1g7jhzwl0hxoViSv9xyw2kYhnBjfwUG-cYj4Efl4srt_OggdQTyCXtpdJ1EyEmx3cDFHCW_GnMoL_K_E05Ksvnn8X3-43dEcquiheJwZ7bZNH2hNaGXb92hVzhMlIGw-NXUpa93Z0RfcVWYmN92En1CQnQYqOZTdHBim8D8gbmQWzKK2Vo2aNN3O48h-5DdWs8eeW5w7frL85hql8DqufQzMZXdczM5wRn7FQ8sJ2XW30WO7hyACnU6Mm8dlFFtVWRfvFODT51ccwPJukkv90ExXBr-KtkTSVyPGVcpGlsq6NgeNESY9Y7kUSzLHXsBAONdwvhUKtLwux_UPrwcpG_XkylkFv-XnzqQNxteocM_4o-AM84Xlyywqh8PPwmC_0msf_xrHEKxbANRBx7K8i-_vlDbcai683h-gu75nfqN49i8Zm53f8i_2fAgY78jq7X17-YRZiscjZrIZiZaxohPLPjMb4hUZvRuj31X5wK-xL2whPakIfgtjA.72mL3Ak6NM3FvY_9IpaT0UyrKfghSVp6J_ce9H-v154	\N	\N	dl4p+nxsKCxCQQn00Tqj8lOlz6F8EnEYML8yuxlO7mw=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	7561119e833c42e39da0eac0eb9b5477
3a1dc3ca-c921-5925-e4be-9e139cd4b742	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-23 16:48:29	2025-11-23 16:53:29	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.DYC2nnwm6IQ6fMp9o0TODE0-JCd4Tmr6aauNnzQ2eIHMu-7ycKEr6D5b02RxOXdF4g5rZU7pNB0PdZb0I_AJU_DaxS3f0BXw9zW8iWr3io09zJvicNfGAKla_-2FWVmeUOqOOtwMTcezjpu4-C_ppcrI_6MojShXBswMnPb94_ThEdatmCQ81a7VUGEDe3gMAaEqQ7tz_vSrQLU0FQBtaelWvW1LkLpQ4Z-IkH_GuhvgoxlnkZl7bUeDDvfjo68dB1Tk1nh_QGjv6v3PtKn7SuX7fUZtVRV_CTy3qquFH9aTHbEsAtzHwfsj2d8cbLoF4cqzugc-KdM6pp4kGbcTSw.C5qKVKVlGRPVcfBmwP3MTg.epiy5wF3dp8-qscFtZuKh5sm2WNv1OYOg8_KEVel71l-aaMYwN9jIQGHBxNnvsvGT3koeGb7Ze62F-L8xt6FXkUUiasp0_MwP_5T2BZ572BX4NAu1eV9UXpSyjGpYubLDGq4-q5N17x20EZ7E0AkkFBBmFXjFbgBozG-wrK1d7iWztOIA2DMXrBSfYNKnRoCVnFHUO0yB2FZWG3bV8st2ds8mdv9HDv8D3DIPKG12Ml0ZJartwf2ddHJHZTwMhjde-FHN1NtrtvbHQygL8TjZ6ii_ObdbElBw34eGiOdkJ36U9vd201raB5nVUR6dYUAS-YL-10SMNwpFLgZR3xqOHUZdTViRuJe_zl7rwv2eTq__4Hv9D1ZYTjopgdq3UQRjHoFrZ2kaswcGTOIm_IGxxwr-YaLdWUmH70tBNrOTqVT8dUsvpXgSmpC5L1a4l0Oil2UY5Yx66aJjuadeE-wssIBbLgotcnObntSD6HQlaQ55g-8WDDjLprbxlUR3F2og3RmhENuMbVF7yFo-sJ4nCeKdUdBvw6fxYG8TCM46DYg-8zZWRNpjvm_WKFAw8sktw3_4Pm2358mcSYZWI7xhGE-7sM1xATPhZL3Cezz-MJz9VJRAcLJ07BXLKR8FOfbH1cCv8XQG-VxYMro3Hh4cxDGTQEB26wwyJDvkSoCaR9CFDvLYn9blWZzma8eEQoZkiRuEH5wAYdoz-q2ABW9jTqyJcO5EiuMOJ5azOlcey-kgLiH4E_7YB6qjo-VwlU9WwjFQutCzXn5wkBV1b0z_IpKVB1dF178SXWZLt4tzFCsrxjeqRxRLF__WimTfZnrG1wV8giXxpg7VaFiRSZusFjYCpCWH5YeoeDBI8uXShCY2fvTCGPdtzU_qTy4aAv0tKhjKvw4YvWJYINQxwM6uFZTpq5HRG3zj5tgXPQU-9SinvkKl9gqXKgjJF2DLrgxd1LWv3JGkojI22YhMy9IrI2-F9QK13Ie1pG5Ct7RjS7dHpuWRmULTAwCgdD27VKvJ7e9m3cqUyImjopgyChH0brbru-N02h12_YjQzl6ys3xGW0MkchHPHTKIppSTxjsNT21rrM-upPCkSoxIwngcvPfDc5PbSl0KLgpkRN1QLd3EdacdZ2zTI09ahmTcuakHmQ0322tSM-9Z-pFvO9D-i63tohKduKhH26wLJhMsCxPlbq_xJj7jsRXeuvL9w9yrYifh0k719PSWNt66JxLS2gp-oK1Rw9iXep_IGcf0mJBJbGhVDOc1aNOxw9V4_hMLT_Gkth3UTbBXxxQJZrweidv3AZH4qjH-Y5WsnL4d5BBWrSe-V3aGltU_SzZV18oqXMbgcGo9lqa-vaa-GqRvM2u353VtVhPTiQhehxoTI7YMKufT4ennPDGdo_vkFA_LpnYAt3lt9hkiZ_UZmkyyIhSUj70isCHP6Q-Pu_vlu788UhqQ34ZrFqDZYUKitrXlDj2qxSs3IZsH7DhpNMRPqYXE7sUvl0ca2XmULwcepJ5uYQzVuoLjbkVksokmo7j_onFS2TYI_8pPqQBKkBOiIhQPDZWcqeNXO5dKxAN0f02Pa2INiBaLXcjILA-BAa8xYN3iN95CyRLHDvmAG0XrWmgFA6e9OVqAfw9INenU10T2bQt10oJNZmhjpE1QGQrXpTjMTG2MdyjCrfVhJj_2Lbo_i_mpseJz78tbzZ9Q6LpGJqFayCqkvDL-kH8MUnHDdf6OIyLFKdK-MJ_sTRJxfNTu5uU2yEJRzCI4JE55YNA9VF4VYeZnfCtkxFGOqkFMdBlyt0SkLpusKX6n1gaurXGtEH8dpm5z-rMS3mrEIeqcp2Sn52FGnBLn0GH2sug9G5H6865FQIfhNf4V1lcUatRudGuujkSjjyGkNpDuQO8z0xXf9Z7rtpSGZNSXD35PpjWQKavs3hXg6vSgOSZGyqS-EwFZPKlQen6lR5JW00_X5ESWQpDdJwPYwrmWTwbExRVCXlPw_TTx8U1ffLBxYU8yv_gl-aew6in6VytWWK7qXuxAXIhSIT1EVm4LimuzijbNdsKgbhVPIeD-5ivMVLzhV0iXrKoAO9oRvyJYBGnsnY9ojwSA-ovEQte5HCDw2Q5mRikkM1UL52waMyNRccJXHZt_TeehXBMVihSQZhLScCQSnuU3n53LayicRX2zg6r3hO3IZZ6tjY2MeROUUbcoFmyCUt_iSKTkqUw8t3kCVbXEVrc_Qa_sFMEAy5hNdf45PYgmewiuT2SVItwMJCEXIUZCubpCc07xxtwo4h2DTVpqptLCd7Z-Eys4RSFLwvCed7uaJA3Fbplnn8No0_NfnXVDhWk3SbUDUgz5h4hYVStbWy_9k-dkm2AYlhdwbe3xDOc_4paoiIpLfCFeu_UT-CMMnwhJ-L2-Gg5VzFk-9blazg8S4EW5exP6wMRBC2HZXeh4pTthR8ZZlpwAw.11KRDayNhO2hGAxiKTO_hAH_prY3hweQHNbVTNq_mAo	\N	\N	04iQODXmbxTOGBh2bHwQJOgjLje5778ezNjWymCsBqw=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	36e5ced6611548dca5245cfa7ae1fb10
3a1dc3dc-aff8-6fbd-7822-51cc6c276c45	3a1da2e4-31fc-79a3-4737-084c1efda199	3a1dbd66-0fd6-0b60-47df-10707561f5b0	2025-11-23 17:08:02	2025-11-23 17:13:02	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.o-dMdNOoxPqT3P39oKLXsDtrw_h8XtLxtroaII6Xih-Bv4C0Wipxx_2DMlWk4W8dFdscnuoEhACmZ7rLPTaltsZj1F5Y7k_rnoM20_aoJz11VVpIwgZ9bRmZjv2ZeKFbbqzicsqvlIyks58bNA_FqNcfurfGsLR6GFgmWCEwXcF4p1wdXrUt4MjgpLzLRrSY1BP9mTTSCrSoFIgqRs07EWwE1lEKYsqwwSFEDlq_hVD_EUNvzX9CzFmJLPN12oUCslm_JKjZ59z9WUtg_MwE5x3UBymsfX2toRkwh_7gZiQPEWj3Yrtj8Zz_BdiPrzJrkdjlUiu6vj5X8Us4w9avgQ.7TruPvX2cD6CjgjqHkKQJg.S28cJJQh1DWjvlO1Zn7B3JG9B5ZTWl3Omya8I9T667b-zBYaCvwA6p3HBmqd8z_wtDR2PC0ZZcgnxxJ4T0FIC_PDkdGvyc53TE2msb4-fjqJhqvYvVIIQwTOj_jHtPVCm57seM7snAPwIbq43Bc4T_LX6tOPbNGYenqnUdKbl5HF2Ze37bN0_zgxRdY4f2y0-5pkGPlyZx2yI0011LQDuWC-k4FgUEvgdJZpqZ1QTZVFmP6SKBaPybdmh7edbcmF2R7YoIkYbsi6QFhEuA3WL64Dj-TgruQ_VE4pcSiPwYTQdVc95P7KoqPjAcPRqz9e16vR-iUGv45cphQmBirLut99XvaQzo1-V7aB99Q9vmpAvrml8DlOgFHUiJGAEpl61L17eLCBD6m8Z6SRJ0l4EB_IFCqbCAtkTyM1v6_S0lNDfav-18EF1-5zRRiS9AFjGCzpyxsCGs4RHGlHxBmUbqs3aqWvPy79FX9oPDQlSunlFKV-JIDGWb9ZMklbg3tmiu53o0uGAcdws6hgrM2zY50_j9ZwW9yxgrNPxX-FYFcE4UKtuhb-Bpqc0kyg5GFtBKB-_3XzK551osGaUjqK97hf8fhHo9ur3KiIOUGwFPXD5dA19SiKS3jLMhnNawtZ1CUe5Sf8i9JI3G4O3sP0ZzQdOrirk4qHWmGH7exN7z0q1thq0uLiBKvLSvryKKlbgVF5aSFqaxIwtYmglzuw_05sUnnJN8ajTt4nXsvOCpVyFPXmbSWIiD8LkXqpnTnXIka2zI4w3vV-5ba6z2bj03HcDA0nzoQ_nMFaTW3SFVwEhdSAu-n-fzqq5nA7xy2KoeFvlYLEXcjAYHJVzak5Gu2TGtaoxtnTBaAphmolxJWg_0-sFIYW8VWSCUquZRL15Zjb7zyvdHtgJC2pMpilIEdLZiLuOqS47mooyxnR6QcdsKwiD0SEFdHaWoUQ3r3jPfQ6LS5gNgy-DQe1VtA6yHsRLj9i1qUUQs8nsxbYm9S4UZ8WKF7I7AGcm0-13-_HAuJupBusw8Jnaf878YbcHxNVwm1_EBENg71K8ACGDt5_FBG2osjd0Z30Yvzy_9BsB6oJkZlRbBqcRfBkh7u-aH4L2RKO4Q40tfqlD508730fw4a96fM9ifv8WYwY3WJiltpXNd3HPKYqvcDpLQvoottrhMGRFlPE14vzo4pQFyNUGjcKvGtmXkMlQ14QVRo62p7zOMRSxepbssM88IBBKE4XbEJinbe4O2mljMAaC33Dd19tmmzIqXFLxr0GqXTCs9NRCTCx20D_mT2f8bW8FD_gwmIogdmPCFsH8FAaQPglOnqxsGaQb-bX19uFdM1lz82Ey0A52z1hQm2cBxHxH9d-kLtLvwDyMkLJrmviMfzpcUu9C8Dwa1ulxvHZ4hBlTLowh3BV5HxNbZrHTw_Pd3xGjT8sBJ4BDAahRHW0mAqQXh7m8XJ759K-OfV-8IXT8ki3EJCgEbyOZWOT4RGcDDLFSVeYuojTLEigttcBlvuCG6-tkUNqo1rZGLL2t-0XFkeLpLqKZKFykTeeTzR0qtKWxxKDld59N_I9INdKu-3amLFy-Xl8Jhn6xf88FDl1ByasjXLaqW8vaV8FlzKQo0-esqqisuJjkTJfXrSmHaRm6sTN9lFh5i9QZup6ukF5b0fLrog6Q-AqRHNYmUOdVPOCNNbMy0Eavvx7hDVzLxLmpcyzv9zNliYNJ3rLw8tE52HX6n99mwLP2i9qd91xnrj9fhPXAm1J7CebOfnNy1S4kfuDCkBOVg79LIikQJ-Ms7_2vSSIjyvhgrLP3c5JgS8ib0IO7SaaDNAnLmKYvWX3tyk0mtajU-AXH_xnv3qYCZ_XEvtyg-vBk2yVUjh635usB4VUN360LWf9rvq9z819CkKrDKZS2HSYcBCZQBOln0O2bjkEiQzjRmShmHWdwEw9VURoYVWFYLHx405UWuTugg0Wak2kGmOHMrt4Falyzq800li3B4bihMTiuJN4qjTaIJcdH1fXxDjzZ0cSBKLE7oragfccyfhij3APSvmzNd39kxu1LbvLoa6N_xKYY8Q3d6g7EFGaZtkw_0FUsiJMqvuqGiysX8nJLrHJ0WocikEC38QP7mgOesdndvvCHYCyI7EIXRJyh6oAOkSRI1zg6ugSkZNu4-hGBIthOWhaArh462omzTCAq91YTTXCKWzi27UFTJW0oyD7Yb8GZTrw8fGKFC6EH_sVsNwGOkVRLz2DnThUcvC1nNjTBhPeUjPaB_5g8S7pxWjSdyVV3C_xAIpvAtZgqX_3vVXpbt0WRy4e1ITZxvitBugQ1pwJ-BwR7r5Hyve4w9wokp4Vss-ycRrmTjcY5sCc5zYODzv6drrdlnbaOXiCwzUSRxO3HMEV7rau1Cj1zGpkx7uKb7SDnzjpACGhyxYWc7z8znBMorZ5MWYBveyZmwb-KRIrgw.5En8OSzNS3CQsc-iSSFSweeZLxcIhBym76fDWccyxko	\N	\N	nfkX7jR8Q/xuH6Sb0yZ4393Shh6It9/mVjxLERPKuZs=	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	171a85c921304becbdd0f4778f78bedc
3a1dd683-a16d-5a78-36d2-4e1ac7f7c2ba	3a1da2e4-3191-7923-a780-699387b8fef2	3a1dbec8-2d0c-ad13-330e-933785192bab	2025-11-27 08:03:33	2025-11-27 08:08:33	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.SEM0PQt1yUt4vuXPq80NdBRy8aCJ_ysAvqdcjaOJf8Loc_5qLPuzwa9tJS3OqGK3tgs5Nsk1yixaslFhKWjskqPsdG4jKtGxPYrk3AFfFQHwvh9uEVHuboYxcFmCE46sMw4XN_Fc03RpeZ2Be99znv_t8O3MFPpV7x4qAQ75HFf8HMkUgkpyz0Uzy0B7xUk8uBaMAsaU9eGaUZk3Bs9nqNNGmLasAhUdptq6N1Eo6mSsPI6vrztl8cLnx0IbJZCzPZUDFCcAIyhIKFmPiBI3SuG3q-2sWSlJUKSveYtgNTYPi-AfJFZXDd1bzIODFDbvWFwsHxhMUWL_lXDkN2y2Pw.vHPOekL2oMjJStoxEV2zcA.Z1QRCBV5DQFq-BLfjNdMDvL-2xWdEDVRvB46Y1PLg-OjUcqFObVosjsqsdI_OFvh3-nA7AlUmj09BYblX7TeVeJ_WyWm60cC9iWj3LKpenJ-y6UgZbNoVdYHvXEkTdFw3KtH-X8ixzEQ0BBNQY3kEghtKfHrYlHj4NmW8rSxx123x8boQZPT07Fuqm1iNYWVhD93NtKviS5x1D6VPb9lAS_RJIKutJ4xixojOwnNcQjWrbwsgAo5apRe1t-9onct4cbOGWtK40aTnsRb5EFZv3nJQAK53Q7Xj3Z88omFyyCfnr28PcRd887SsMjqx07isTrYvHyJnhvfdkH2ju8pLsjS7JqMAOwBl2gQ2FmswFQZTbZBmU_4qCz4PAHQUgaeN5CBK10l2ovwXPondyHl5EQU61rtcKMrp98Rk4JdFnPW8DdMp_3zlLMA98n8eADeFkANS3lNe37wTfcJy7tgDQzyQZMfG8wiOhF0F38V4taXKsFtjlsKVJ-REv0C7XLkAJc3jQXZ4VZggmj0pxnYFjLwNQeqEh-3Q0f3PvY22LlfCNs1tfn-NsoPqC2dKfQCEhxvLdJLWKvO646920s8eXklb4F5P56ENL_7kIFTdS3_76o9Y4IP6K_el0XOjAAMMyAVvuxHlojYfHHUMxnUGNHvSR0EX8Uu99ZwXsO5HfvBEjOx_D0hD8NvOsJKHaEk5oKUw4HTenb5X0ZrG-1Idjxov5ruLd79XLcWftx6J72HsMbh7lotMJgn8fe_JI3Ick4T3TAYuFwm9_5pmpyBj0VrVdzlRQSGloGJPtjGhGE3R_FT8AhhXaAkJ0XhfMjg99f06dBt03UKOqQPQYkAaBPfk9o5S1tgU_jcqnH2VggFMjw-Rnv-KxgienwWswZjez2GhUIsXMuSQuymbitEufpFxW5CvjfvojQMXg7oJNttllKEQusOX8iqyIMWWn8N1kSY7prdq5_k_6v0DpYO113mI2qhCsEoa5ed846QseN2_FPbEM0CdTKQKnBDIEABtymYUJrEH6fI6c2MNq5xV9SXnzoA25WJnUtfe-oVGEpHrYY7llEVkohSHIN0hc8W5So5NhdavTahQPeO0QNZ0G1Gy1KVyYyJkiZHawN-K2VTM0c6ginDDlkRgxzauym3R0EiXEYrUDq5UBd2zvBjlRa7SjHirBk1dRUo1DwfQPBrbBLUlUdvQWXWqS3Jc3DbCLTnES-SXypBFk8bQp9WLwyTr7OC3EqCWO0n_7y4b7A_ZQRw8eX9-AXXoLDWvT7ppB9Yyg5J9mdNq5dnwUCMMd-PICmNZtR494TTJRm67fJ5k50huid-Q60jhVMFNaQOYJdS56dl_dB2Bz2y9HJzUNN3O5piI1bDughEAfYCV-vQe67T51nHfuNkGq-NCVmNpCSehFGvDplVwasge8Hg1pb-hs02ioqDY2co3umkEGFGlw1G8Fw2IKBRgKKsARUugfnu9jfVIAVlsA3A_iEzgYL_qpBMrqyd2NxMZsykytM24juVVo_mSXuI0MzolbmHa4xeqeLa_mB_x1zx0RFuAkzLCsO3_QFCTUvnt9_VwHacux7LT67ddE47t-2Qp4aVLye-kMyBje8yARQ6Mx2xKox_sZcUBm_8y6HAzILYMJYpX8Ckpfz2Q4Dl0lcKBD1Z39YZd74EXVBSEVztn7v0USZLb4QO3X5DA_VzzUkOap5kM1_-ba3NJAAcryTD7DokQDVWIyeAbxky4K0gxh6GYmKPFDB2IKxOHxyd2crWqCSFXo8tVOGWYMMWBmeghqHeFJPR-SaAu6_tPBvayLS5xJskKK7qOT3yzi3A9AfrdkNGpZ8rtBvWrOZBMtcrR9MI-nHKv2XxBur58soAJZF7_435O30d_M1Wl9-xYq9JiU79GmojO2XyB7KUUYTSEEseiA_ZVGPzAVkRr-R58FAwnRSh-x7QVXdlMEza2m8csYz3PaKazC6Yd14ZJ-KHwl-9i89q1O-DJ-MU1rNDUbxRluN7Ke9gnmxc6vsuQY09j62q8DX9ovczzA6juSSMFPeErtmoWU869vV2ROXHAqM0gGAXtF-SDf-yBHRfKvxHVK4O3NVrxHe_HKF4KstEaff9fqvr3Tp_jeGU8reUYbNqSrJrCrBGSfEmewE-kB93zXWNUhR6v7YkUVtyGXPggWElAA0g9cNzi6s9v1ZO4geWJijRa_T4t3N-nRURVwKopVOkAUaOFmGOhjqZzr-nZmEWI6onk1WXlrP49ff9IJuIP8lS_IKJ9st5nIIkSWhj93jbF6zyK1ZqwxWQjFtmXdylLr1Q-d3_GF2Cizcr5t0pdqxQHB7C_zwgy95e_AIqjbeD07oWIWZF-rRZBDSt1-K0Bwlwy9JhQCiEdwDQc26t65jOgQdhTcia0xur_6_hIZo-tNiUEahFffHztyGug6bBmQOTLDw7qiqT22pq-RcZr6H9WleCwEqOsOJQE9pKS-IPytrxKzK2BI1Z-AO6HRwSI-v6FutBgsL5fBij8z9NV2Bbz8ALHrAz8T0skNMbCHnswbBpigA5kCpNLq4d_g81xrYcVzEB7y4nUZpITueJ6i4UjLpAX_pNVr0azl6bnlyjSAdTHU0_iSGFVhhjzX76qmksqpDQc1jTTmlqq2bCVkiKm_fo-OeBrOowPxv10btjtyefrKmV-xobtz_TIn116j_SyZsMCfKyuNUyEQACywqkgUJ7VLgKGmqQNKUQEu0ND0GxluU3JjUU0HLvecay.tWHH5hBSfvPL7q8iC_XSpeCf_hzGdD5cH0VLT1kOjAw	\N	2025-11-27 08:03:33.747257	c1n9MSK2lRdAt5VLxy8JcUfD0w0WrKwcAgN9U9RjSGk=	redeemed	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	363d32417e6f4973869a6a89c70697d4
3a1dd683-a320-1910-e459-275995a4b674	3a1da2e4-3191-7923-a780-699387b8fef2	3a1dbec8-2d0c-ad13-330e-933785192bab	2025-11-27 08:03:33	2025-11-27 09:03:33	\N	\N	\N	\N	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	access_token	{}	f42a9203dacf48b0b1c514bf4cae8054
3a1dd683-a332-91ea-5cdf-33dad06a4cab	3a1da2e4-3191-7923-a780-699387b8fef2	3a1dbec8-2d0c-ad13-330e-933785192bab	2025-11-27 08:03:33	2025-11-27 08:23:33	\N	\N	\N	\N	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	id_token	{}	706993e341884bc8a7ff12e6aa94993c
3a1dd683-7f55-aaec-a00b-6b9dd37262e0	3a1da2e4-3191-7923-a780-699387b8fef2	3a1dbec8-2d0c-ad13-330e-933785192bab	2025-11-27 08:03:24	2025-11-27 08:08:24	eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZDQkMtSFM1MTIiLCJraWQiOiI5QUQ1ODQ5RDg2RThENEJBMEExNzM3M0YwMUM3MTZDMjI2ODcwOTdCIiwidHlwIjoib2lfYXVjK2p3dCIsImN0eSI6IkpXVCJ9.Or0f6MLoWjT8u6rErA7biFA1IhJ-nezVOhoYBPszDEiEVg9jUeikjhjlPxxB5Ap1hdYrLL91dedjJiTmIo2XeMZsv-I7T6vHSoAwUbLxkXx7YbF2SBJ3MengV9y9q80lzH4_QPRqYQxlV2JTGZazkrULB4KOXtR8BP0H3thHitnxsYXwPYfTcjPAYOGueZjAtW_mObBOlDrzSNavHVk2zM749oG0DbmZR9IazVCIsjDimrLqNckGT3FFJ0JgYOsQXkREteAmtkRQx8HgTdmGmUMEYMYzjsbcPZ5Smwe4j-kRefB1RQnVgIkmfJt5pD5LAT2uIwdZIy2mCa8Tz1LnCw.phfRRxwvTwmLaSkMJXyKpQ.dmmPR0OqsaoQoUxB7LO-ulo8jdsWPrIH91e2JAX_mt5KCHscZFIEJJUhWBuxTt86yZE33qFsGSm7bhT_HLZXbhr290cFk8D6WH2rIrYlXUCcyu8yhIfwbc-GR0d7VhwNz-xRWxN9saNTfCHVv8bLA-dbyvx383Vo6CaUdnU2EcK3GPNsE3J5U7UWoOUiTogSP8-u7wcxg6NaF9uBvdCa0ftEJiX-BrrNYWxCh-_13S5qbqYx3SwkGh3D_GYfF175zyT05K24Scn_vlD6elFDj-5Wpmld_-6yVDKN_T-RH8nuTHiQlELjh6BlsGW2vA9GwhdM9i6nvYRSdjPkVQAt1eObWfdCECRiQJDSa9IS0pTsEh61eO_CDSzciBgtHdGFpVDORUyU0MCaEHHD3MFqraLU06zCSeTG2fIKOAxY18Q_gLUdvaTDG3DPZECERG5BY42wsxO9ht3kB3xgfa04Xcx3BRZC_AXcteZJbps9VG26ZL6T-rQ1qXjZ9Oo2u45bcgxCRcAHT-gqQXuB--o68Z6dIKPyRzr2QgHTQLsAHxoVRWdBs_-XxtYjjRDydn0uUcThOE75SMwz0nUN9yj3sGi7kQx6igIYGibTTCX7y4DX3tR7qoQ-S07b3EHSOjXfe7drBFhaCgjS4gtF628EXItde8BdrVbxH6h2bFQCA1nnvkxhgwJNU9fD2dVkC02ldBBJBgja06gJbKOd1XXwseDwnS7RiT7Dx9wNJlys75kU9_b_qGzAfm7AyJhC8BGRludAWKv-3e4kjjRLU1FEmltbrwwPs2mdnMZAVr6F2BZ92N3Ugh2n4I809jHNLCb-Dnd39v58l2fki5vYrvE7LUjfdZjcCIycC7365_q1FQwV-Kd9BNJQOwdsdBErJPfVKuldmfLVC7J-2D2zn0NPDOxY8smiTyHwfBPdQJdCaIYGjku5hZVL8Tw4x7iYOcNarFzhcYmDHLqP_HI3vUPbRU172tnMNCPDJXGbT2poOUI0sG09GjkmHKF1kAa3-JL0rZgh6owWriqglWljBLN0pvkkLXjXLhNzj0gt7aYLtbewDKwheAEQIH49ekto88WeoxBiW5Z_nOcKIXelZYCasZX4BW2Q_GHnBFKvmHPa6C8vE_vlEFVYGo-q0zA6uiNsixLphn133PI3MXuaijm5ij8VhDcpvdhmesfoGV1JGDibOlF1qCjwB11DYFcM33SNJKLvShUPSh6bzVBqluEghB6IhY4SSTX_bPXUNGhw0HHoV0epV3u-r_XYQB5eI05IHf5NTaHjsm3dEP3cMPGXH9cJDSUiSG3828v6V-8IcGWH4IOJOdxdNU-_ayNPQxPqVL86V8aW3pMRA3X3C3DNSQ3YX0BqzmkU4UJPv1spr8te1_YNBepNRYGOSVqDbcajQ-gKRzLgGf1kFOdBMvJ0rbpsOeVmreWXanLNGcEYRYFjP3QzLMLAXUntsNda4WRkW5G09zR1q6w7jM5It-M3eqPl-5L21hFHzfj-O8tw1rkOI8cGs4xEa7pKRwV6_b1_pqbMaVKOEGFrKlCw1qp_M-n-_-Iq9TeAftZ1VYNxQvzlE3yiXZPeZ35KXvrvkYI4gK_OhRHulEC7N5B3zD6lwEohFxSv64JybxXOCX34r5DFYZthWv_FYjzVJ0WwmYVSRDFxShlHNi2VhVTChEongJqDpRKMztY7Ao7CoTQIY3_j90CuJJApGtTLYye9wXjf_2rCsFv-IkrpSOkLu9oohJRZruv9Ks6RiAPKaKEOKPTqwFadyET0cV4OGwPaMtN0264GsFj29LA0Rw4DzKZZKL_FG98IZzAyQd8-aZgLQugSaT15PZmWZr8ZdyY473dAZ0p9lNUKMnFVTcxPs8wGoB6qW50sAKaj8vSthwdV7tjQKPNe_XUxk-qcDZAY7soRt7MuZ9HXwWZqIzw2g6zthK4c39U6FsFmcgjdRGI0l_ekXFBn8tCFUwMyBGkln4aZFoVn76fRwmYDMJcV6a6AB-SypVwYdQtvtzkQlLcqJw91OUxN7m3W3VogRzXoqM-tyKypYvb23fho2Zqp-Z8H1ApL87TERznL_iQ-MV_4biqTkkYb2PD4f2bJDZNEVDAU9rtDzgs6e0Ld8Vu1EHxbfSf8Mp9JkftpIU--gz9xMuTNzbU0UOtXoO7b-JH-4Sv67AuEO2HMU4Omf2GOBEi8myO89KuX_DzC6cCuchTNpAfAPU1L7Ff8xx8fTK_R8v_dFOgSayfTE0-xTWbo30RYFm1TJ8ozAuQmjE2F3anWJeyT9NF8wwM1h6-P7R4mbGodkayNOQf0LWFx_3BZptfSGLJeCwGKo7ySwcnGehbXl02_nRRZa2jp8NaWiiPdEouNeB2HCNxIofl9emswNzu3Bbwn_h5lD6neoLVPhIHx1ebr_JpOz-LfXfctUebXiPg20f0iio2Fk7wKynz4ODyRQbC9vOrSFI0iyadmbJVqZhqXog79NJ7Qy-hYEMqpragZK-iblrFOkm7YZJC9Eiztu5wYKqkREsWNoFivpQnK-WzfKqQnzBOV0Mt_nL7PeFe-4waGLcAhdV8262VgpTBbqV7R2cG_-vQGwjrBJ_REw7m8S1dKtNwwM2JuzeS5aCU9bDtbyhUA1NaQaSn6d6ZirpkFfYXTjPxWbR6CQ8Emd99ByzOyJNAfvLOF9YboFrLoOu6dcgC6u5VucIE7klSAVN-Wjm1x5vZ8uNPJ6CMKS7_ad87t5UNn5ik8t-Y7QtSp.VAQ_8pegUPAJK0jvLUBSvlFx_-UujNBT2vi9_vxSMcU	\N	2025-11-27 08:03:40.713119	ETPuI81Y3eSnPrtdgPuydK8JTvXa3Hd/DIv3h1cninw=	redeemed	3a1dbd64-c316-bace-f69e-a0e93968898b	authorization_code	{}	b87d5e5a2e47496c8e8bf861612b24c4
3a1dd683-be34-24d9-b7c1-441acb6b0f16	3a1da2e4-3191-7923-a780-699387b8fef2	3a1dbec8-2d0c-ad13-330e-933785192bab	2025-11-27 08:03:40	2025-11-27 09:03:40	\N	\N	\N	\N	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	access_token	{}	33c902062d584d7a860e5c27a66393d9
3a1dd683-be3c-536e-33f7-a12dd6178d18	3a1da2e4-3191-7923-a780-699387b8fef2	3a1dbec8-2d0c-ad13-330e-933785192bab	2025-11-27 08:03:40	2025-11-27 08:23:40	\N	\N	\N	\N	valid	3a1dbd64-c316-bace-f69e-a0e93968898b	id_token	{}	6ff27db2e7a741cc891d1eaa232cd362
\.


--
-- TOC entry 5765 (class 0 OID 22426)
-- Dependencies: 229
-- Data for Name: __EFMigrationsHistory; Type: TABLE DATA; Schema: identity; Owner: postgres
--

COPY identity."__EFMigrationsHistory" ("MigrationId", "ProductVersion") FROM stdin;
20251117072826_Initial	9.0.10
\.


--
-- TOC entry 5829 (class 0 OID 23639)
-- Dependencies: 293
-- Data for Name: doctors; Type: TABLE DATA; Schema: identity; Owner: postgres
--

COPY identity.doctors (id, tenant_id, user_id, salutation, gender, specialization, registration_number, creation_time, "ConcurrencyStamp", "ExtraProperties", "CreatorId", "LastModificationTime", "LastModifierId", "IsDeleted", "DeleterId", "DeletionTime") FROM stdin;
3a1dbd64-c8d4-2430-5ce0-00d123c02a37	3a1daa2f-274c-c133-f38f-6f5a98d37f7a	3a1dbd64-c850-7e71-8b8a-db06bbb33836	Dr	Male	General Medicine	REG-001	2025-11-22 10:59:21.430323+04	c6b5a48fc01b4fa1a4a6fbcf189b1741	{}	\N	\N	\N	f	\N	\N
3a1dd80a-6aff-b75e-106c-59226f0c576e	\N	3a1dd80a-6a63-8357-072a-def65adf9702	Dr	Male	General Medicine	REG-001	2025-11-27 15:10:24.029044+04	f39288066cb443c68b9fc8ff4057f5bf	{}	\N	\N	\N	f	\N	\N
\.


--
-- TOC entry 5831 (class 0 OID 23703)
-- Dependencies: 295
-- Data for Name: family_links; Type: TABLE DATA; Schema: identity; Owner: postgres
--

COPY identity.family_links (id, tenant_id, patient_id, family_user_id, relationship, is_guardian, creation_time, "ConcurrencyStamp", "ExtraProperties", "CreatorId", "LastModificationTime", "LastModifierId", "IsDeleted", "DeleterId", "DeletionTime") FROM stdin;
\.


--
-- TOC entry 5830 (class 0 OID 23657)
-- Dependencies: 294
-- Data for Name: patients; Type: TABLE DATA; Schema: identity; Owner: postgres
--

COPY identity.patients (id, tenant_id, user_id, salutation, date_of_birth, gender, residence_country, creation_time, "ConcurrencyStamp", "ExtraProperties", "CreatorId", "LastModificationTime", "LastModifierId", "IsDeleted", "DeleterId", "DeletionTime") FROM stdin;
3a1dbd64-c959-7fe7-242c-8404781053ea	3a1daa2f-274c-c133-f38f-6f5a98d37f7a	3a1dbd64-c8f8-ae7e-397e-2901e42bb09a	Ms	1995-11-22	Female	UAE	2025-11-22 10:59:21.562164+04	04776c73c1de4c09818b34df7940e29f	{}	\N	\N	\N	f	\N	\N
3a1dd80a-6b8b-52e1-60a6-a45ba198010b	\N	3a1dd80a-6b34-49cd-86a8-45ef82ca5773	Ms	1995-11-27	Female	UAE	2025-11-27 15:10:24.167217+04	57dbd41148804b5fabb35a129c4b9efc	{}	\N	\N	\N	f	\N	\N
\.


--
-- TOC entry 5828 (class 0 OID 23623)
-- Dependencies: 292
-- Data for Name: users; Type: TABLE DATA; Schema: identity; Owner: postgres
--

COPY identity.users (id, tenant_id, user_name, email, salutation, profile_photo_url, name, surname, is_active, creation_time, "ExtraProperties", "ConcurrencyStamp", "CreatorId", "LastModificationTime", "LastModifierId", "IsDeleted", "DeleterId", "DeletionTime") FROM stdin;
3a1dbd64-c7ad-cada-f36e-2ccab88985b5	\N	hostadmin	host.admin@digihealth.local	Mr	\N	Host	Admin	t	2025-11-27 15:10:23.501732+04	{}	399adcaf1af145aa814b192e873b7ff7	\N	\N	\N	f	\N	\N
3a1dd80a-6a63-8357-072a-def65adf9702	\N	hostdoctor	host.doctor@digihealth.local	Dr	\N	Host	Doctor	t	2025-11-27 15:10:23.984212+04	{}	e523be77e614441dba9159e531343b91	\N	\N	\N	f	\N	\N
3a1dd80a-6b34-49cd-86a8-45ef82ca5773	\N	patient1	patient1@digihealth.local	Ms	\N	Sample	Patient	t	2025-11-27 15:10:24.12678+04	{}	268aaef1ad994677b1035792006c3457	\N	\N	\N	f	\N	\N
\.


--
-- TOC entry 5820 (class 0 OID 23425)
-- Dependencies: 284
-- Data for Name: medication_intake_logs; Type: TABLE DATA; Schema: medication; Owner: postgres
--

COPY medication.medication_intake_logs (id, tenant_id, identity_patient_id, prescription_item_id, scheduled_time, taken_time, status_id, notes, creation_time, "ExtraProperties", "ConcurrencyStamp", "CreatorId", "LastModificationTime", "LastModifierId", "IsDeleted", "DeleterId", "DeletionTime") FROM stdin;
\.


--
-- TOC entry 5819 (class 0 OID 23409)
-- Dependencies: 283
-- Data for Name: medication_schedules; Type: TABLE DATA; Schema: medication; Owner: postgres
--

COPY medication.medication_schedules (id, tenant_id, identity_patient_id, prescription_item_id, time_of_day, "ExtraProperties", "ConcurrencyStamp", "CreatorId", "LastModificationTime", "LastModifierId", "IsDeleted", "DeleterId", "DeletionTime") FROM stdin;
\.


--
-- TOC entry 5818 (class 0 OID 23392)
-- Dependencies: 282
-- Data for Name: prescription_items; Type: TABLE DATA; Schema: medication; Owner: postgres
--

COPY medication.prescription_items (id, tenant_id, prescription_id, drug_name, strength, dosage_instructions, start_date, end_date, frequency_per_day, "ExtraProperties", "ConcurrencyStamp", "CreatorId", "LastModificationTime", "LastModifierId", "IsDeleted", "DeleterId", "DeletionTime") FROM stdin;
\.


--
-- TOC entry 5817 (class 0 OID 23377)
-- Dependencies: 281
-- Data for Name: prescriptions; Type: TABLE DATA; Schema: medication; Owner: postgres
--

COPY medication.prescriptions (id, tenant_id, identity_patient_id, identity_doctor_id, created_at, diagnosis_summary, notes, "ExtraProperties", "ConcurrencyStamp", "CreatorId", "LastModificationTime", "LastModifierId", "IsDeleted", "DeleterId", "DeletionTime") FROM stdin;
\.


--
-- TOC entry 5813 (class 0 OID 23282)
-- Dependencies: 277
-- Data for Name: patient_external_links; Type: TABLE DATA; Schema: patient; Owner: postgres
--

COPY patient.patient_external_links (id, tenant_id, identity_patient_id, system_name, external_reference, creation_time, "ExtraProperties", "ConcurrencyStamp", "CreatorId", "LastModificationTime", "LastModifierId", "IsDeleted", "DeleterId", "DeletionTime") FROM stdin;
\.


--
-- TOC entry 5812 (class 0 OID 23268)
-- Dependencies: 276
-- Data for Name: patient_medical_summaries; Type: TABLE DATA; Schema: patient; Owner: postgres
--

COPY patient.patient_medical_summaries (id, tenant_id, identity_patient_id, blood_group, allergies, chronic_conditions, notes, creation_time, "ExtraProperties", "ConcurrencyStamp", "CreatorId", "LastModificationTime", "LastModifierId", "IsDeleted", "DeleterId", "DeletionTime") FROM stdin;
\.


--
-- TOC entry 5811 (class 0 OID 23254)
-- Dependencies: 275
-- Data for Name: patient_profile_extensions; Type: TABLE DATA; Schema: patient; Owner: postgres
--

COPY patient.patient_profile_extensions (id, tenant_id, identity_patient_id, primary_contact_number, secondary_contact_number, email, address_line1, address_line2, city, state, zipcode, country, emergency_contact_name, emergency_contact_number, preferred_language, creation_time, "ExtraProperties", "ConcurrencyStamp", "CreatorId", "LastModificationTime", "LastModifierId", "IsDeleted", "DeleterId", "DeletionTime") FROM stdin;
\.


--
-- TOC entry 5834 (class 0 OID 24393)
-- Dependencies: 298
-- Data for Name: __EFMigrationsHistory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."__EFMigrationsHistory" ("MigrationId", "ProductVersion") FROM stdin;
\.


--
-- TOC entry 5827 (class 0 OID 23593)
-- Dependencies: 291
-- Data for Name: vault_records; Type: TABLE DATA; Schema: vault; Owner: postgres
--

COPY vault.vault_records (id, tenant_id, identity_patient_id, owner_user_id, record_type_id, title, metadata_json, issue_date, expiry_date, storage_location, is_encrypted, created_at, last_updated_at, "ExtraProperties", "ConcurrencyStamp", "CreatorId", "LastModificationTime", "LastModifierId", "IsDeleted", "DeleterId", "DeletionTime") FROM stdin;
\.


--
-- TOC entry 5476 (class 2606 OID 23360)
-- Name: appointment_audits appointment_audits_pkey; Type: CONSTRAINT; Schema: appointment; Owner: postgres
--

ALTER TABLE ONLY appointment.appointment_audits
    ADD CONSTRAINT appointment_audits_pkey PRIMARY KEY (id);


--
-- TOC entry 5468 (class 2606 OID 23313)
-- Name: appointments appointments_pkey; Type: CONSTRAINT; Schema: appointment; Owner: postgres
--

ALTER TABLE ONLY appointment.appointments
    ADD CONSTRAINT appointments_pkey PRIMARY KEY (id);


--
-- TOC entry 5473 (class 2606 OID 23340)
-- Name: doctor_schedule_rules doctor_schedule_rules_pkey; Type: CONSTRAINT; Schema: appointment; Owner: postgres
--

ALTER TABLE ONLY appointment.doctor_schedule_rules
    ADD CONSTRAINT doctor_schedule_rules_pkey PRIMARY KEY (id);


--
-- TOC entry 5419 (class 2606 OID 23065)
-- Name: appointment_channels appointment_channels_code_key; Type: CONSTRAINT; Schema: configuration; Owner: postgres
--

ALTER TABLE ONLY configuration.appointment_channels
    ADD CONSTRAINT appointment_channels_code_key UNIQUE (code);


--
-- TOC entry 5421 (class 2606 OID 23063)
-- Name: appointment_channels appointment_channels_pkey; Type: CONSTRAINT; Schema: configuration; Owner: postgres
--

ALTER TABLE ONLY configuration.appointment_channels
    ADD CONSTRAINT appointment_channels_pkey PRIMARY KEY (id);


--
-- TOC entry 5415 (class 2606 OID 23048)
-- Name: appointment_statuses appointment_statuses_code_key; Type: CONSTRAINT; Schema: configuration; Owner: postgres
--

ALTER TABLE ONLY configuration.appointment_statuses
    ADD CONSTRAINT appointment_statuses_code_key UNIQUE (code);


--
-- TOC entry 5417 (class 2606 OID 23046)
-- Name: appointment_statuses appointment_statuses_pkey; Type: CONSTRAINT; Schema: configuration; Owner: postgres
--

ALTER TABLE ONLY configuration.appointment_statuses
    ADD CONSTRAINT appointment_statuses_pkey PRIMARY KEY (id);


--
-- TOC entry 5431 (class 2606 OID 23116)
-- Name: consent_party_types consent_party_types_code_key; Type: CONSTRAINT; Schema: configuration; Owner: postgres
--

ALTER TABLE ONLY configuration.consent_party_types
    ADD CONSTRAINT consent_party_types_code_key UNIQUE (code);


--
-- TOC entry 5433 (class 2606 OID 23114)
-- Name: consent_party_types consent_party_types_pkey; Type: CONSTRAINT; Schema: configuration; Owner: postgres
--

ALTER TABLE ONLY configuration.consent_party_types
    ADD CONSTRAINT consent_party_types_pkey PRIMARY KEY (id);


--
-- TOC entry 5435 (class 2606 OID 23133)
-- Name: consent_statuses consent_statuses_code_key; Type: CONSTRAINT; Schema: configuration; Owner: postgres
--

ALTER TABLE ONLY configuration.consent_statuses
    ADD CONSTRAINT consent_statuses_code_key UNIQUE (code);


--
-- TOC entry 5437 (class 2606 OID 23131)
-- Name: consent_statuses consent_statuses_pkey; Type: CONSTRAINT; Schema: configuration; Owner: postgres
--

ALTER TABLE ONLY configuration.consent_statuses
    ADD CONSTRAINT consent_statuses_pkey PRIMARY KEY (id);


--
-- TOC entry 5423 (class 2606 OID 23082)
-- Name: days_of_week days_of_week_code_key; Type: CONSTRAINT; Schema: configuration; Owner: postgres
--

ALTER TABLE ONLY configuration.days_of_week
    ADD CONSTRAINT days_of_week_code_key UNIQUE (code);


--
-- TOC entry 5425 (class 2606 OID 23080)
-- Name: days_of_week days_of_week_pkey; Type: CONSTRAINT; Schema: configuration; Owner: postgres
--

ALTER TABLE ONLY configuration.days_of_week
    ADD CONSTRAINT days_of_week_pkey PRIMARY KEY (id);


--
-- TOC entry 5439 (class 2606 OID 23150)
-- Name: device_types device_types_code_key; Type: CONSTRAINT; Schema: configuration; Owner: postgres
--

ALTER TABLE ONLY configuration.device_types
    ADD CONSTRAINT device_types_code_key UNIQUE (code);


--
-- TOC entry 5441 (class 2606 OID 23148)
-- Name: device_types device_types_pkey; Type: CONSTRAINT; Schema: configuration; Owner: postgres
--

ALTER TABLE ONLY configuration.device_types
    ADD CONSTRAINT device_types_pkey PRIMARY KEY (id);


--
-- TOC entry 5427 (class 2606 OID 23099)
-- Name: medication_intake_statuses medication_intake_statuses_code_key; Type: CONSTRAINT; Schema: configuration; Owner: postgres
--

ALTER TABLE ONLY configuration.medication_intake_statuses
    ADD CONSTRAINT medication_intake_statuses_code_key UNIQUE (code);


--
-- TOC entry 5429 (class 2606 OID 23097)
-- Name: medication_intake_statuses medication_intake_statuses_pkey; Type: CONSTRAINT; Schema: configuration; Owner: postgres
--

ALTER TABLE ONLY configuration.medication_intake_statuses
    ADD CONSTRAINT medication_intake_statuses_pkey PRIMARY KEY (id);


--
-- TOC entry 5443 (class 2606 OID 23167)
-- Name: notification_channels notification_channels_code_key; Type: CONSTRAINT; Schema: configuration; Owner: postgres
--

ALTER TABLE ONLY configuration.notification_channels
    ADD CONSTRAINT notification_channels_code_key UNIQUE (code);


--
-- TOC entry 5445 (class 2606 OID 23165)
-- Name: notification_channels notification_channels_pkey; Type: CONSTRAINT; Schema: configuration; Owner: postgres
--

ALTER TABLE ONLY configuration.notification_channels
    ADD CONSTRAINT notification_channels_pkey PRIMARY KEY (id);


--
-- TOC entry 5447 (class 2606 OID 23184)
-- Name: notification_statuses notification_statuses_code_key; Type: CONSTRAINT; Schema: configuration; Owner: postgres
--

ALTER TABLE ONLY configuration.notification_statuses
    ADD CONSTRAINT notification_statuses_code_key UNIQUE (code);


--
-- TOC entry 5449 (class 2606 OID 23182)
-- Name: notification_statuses notification_statuses_pkey; Type: CONSTRAINT; Schema: configuration; Owner: postgres
--

ALTER TABLE ONLY configuration.notification_statuses
    ADD CONSTRAINT notification_statuses_pkey PRIMARY KEY (id);


--
-- TOC entry 5451 (class 2606 OID 23201)
-- Name: vault_record_types vault_record_types_code_key; Type: CONSTRAINT; Schema: configuration; Owner: postgres
--

ALTER TABLE ONLY configuration.vault_record_types
    ADD CONSTRAINT vault_record_types_code_key UNIQUE (code);


--
-- TOC entry 5453 (class 2606 OID 23199)
-- Name: vault_record_types vault_record_types_pkey; Type: CONSTRAINT; Schema: configuration; Owner: postgres
--

ALTER TABLE ONLY configuration.vault_record_types
    ADD CONSTRAINT vault_record_types_pkey PRIMARY KEY (id);


--
-- TOC entry 5499 (class 2606 OID 23495)
-- Name: consent_audits consent_audits_pkey; Type: CONSTRAINT; Schema: consent; Owner: postgres
--

ALTER TABLE ONLY consent.consent_audits
    ADD CONSTRAINT consent_audits_pkey PRIMARY KEY (id);


--
-- TOC entry 5494 (class 2606 OID 23468)
-- Name: consents consents_pkey; Type: CONSTRAINT; Schema: consent; Owner: postgres
--

ALTER TABLE ONLY consent.consents
    ADD CONSTRAINT consents_pkey PRIMARY KEY (id);


--
-- TOC entry 5507 (class 2606 OID 23534)
-- Name: device_readings device_readings_pkey; Type: CONSTRAINT; Schema: device; Owner: postgres
--

ALTER TABLE ONLY device.device_readings
    ADD CONSTRAINT device_readings_pkey PRIMARY KEY (id);


--
-- TOC entry 5503 (class 2606 OID 23514)
-- Name: devices devices_pkey; Type: CONSTRAINT; Schema: device; Owner: postgres
--

ALTER TABLE ONLY device.devices
    ADD CONSTRAINT devices_pkey PRIMARY KEY (id);


--
-- TOC entry 5548 (class 2606 OID 23993)
-- Name: chat_messages chat_messages_pkey; Type: CONSTRAINT; Schema: engagement; Owner: postgres
--

ALTER TABLE ONLY engagement.chat_messages
    ADD CONSTRAINT chat_messages_pkey PRIMARY KEY (id);


--
-- TOC entry 5542 (class 2606 OID 23968)
-- Name: chat_sessions chat_sessions_pkey; Type: CONSTRAINT; Schema: engagement; Owner: postgres
--

ALTER TABLE ONLY engagement.chat_sessions
    ADD CONSTRAINT chat_sessions_pkey PRIMARY KEY (id);


--
-- TOC entry 5512 (class 2606 OID 23558)
-- Name: notification_templates notification_templates_pkey; Type: CONSTRAINT; Schema: engagement; Owner: postgres
--

ALTER TABLE ONLY engagement.notification_templates
    ADD CONSTRAINT notification_templates_pkey PRIMARY KEY (id);


--
-- TOC entry 5517 (class 2606 OID 23580)
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: engagement; Owner: postgres
--

ALTER TABLE ONLY engagement.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- TOC entry 5376 (class 2606 OID 22737)
-- Name: AbpAuditLogActions PK_AbpAuditLogActions; Type: CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpAuditLogActions"
    ADD CONSTRAINT "PK_AbpAuditLogActions" PRIMARY KEY ("Id");


--
-- TOC entry 5298 (class 2606 OID 22439)
-- Name: AbpAuditLogExcelFiles PK_AbpAuditLogExcelFiles; Type: CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpAuditLogExcelFiles"
    ADD CONSTRAINT "PK_AbpAuditLogExcelFiles" PRIMARY KEY ("Id");


--
-- TOC entry 5302 (class 2606 OID 22451)
-- Name: AbpAuditLogs PK_AbpAuditLogs; Type: CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpAuditLogs"
    ADD CONSTRAINT "PK_AbpAuditLogs" PRIMARY KEY ("Id");


--
-- TOC entry 5305 (class 2606 OID 22471)
-- Name: AbpBackgroundJobs PK_AbpBackgroundJobs; Type: CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpBackgroundJobs"
    ADD CONSTRAINT "PK_AbpBackgroundJobs" PRIMARY KEY ("Id");


--
-- TOC entry 5307 (class 2606 OID 22486)
-- Name: AbpClaimTypes PK_AbpClaimTypes; Type: CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpClaimTypes"
    ADD CONSTRAINT "PK_AbpClaimTypes" PRIMARY KEY ("Id");


--
-- TOC entry 5380 (class 2606 OID 22754)
-- Name: AbpEntityChanges PK_AbpEntityChanges; Type: CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpEntityChanges"
    ADD CONSTRAINT "PK_AbpEntityChanges" PRIMARY KEY ("Id");


--
-- TOC entry 5408 (class 2606 OID 22911)
-- Name: AbpEntityPropertyChanges PK_AbpEntityPropertyChanges; Type: CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpEntityPropertyChanges"
    ADD CONSTRAINT "PK_AbpEntityPropertyChanges" PRIMARY KEY ("Id");


--
-- TOC entry 5310 (class 2606 OID 22496)
-- Name: AbpFeatureGroups PK_AbpFeatureGroups; Type: CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpFeatureGroups"
    ADD CONSTRAINT "PK_AbpFeatureGroups" PRIMARY KEY ("Id");


--
-- TOC entry 5317 (class 2606 OID 22517)
-- Name: AbpFeatureValues PK_AbpFeatureValues; Type: CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpFeatureValues"
    ADD CONSTRAINT "PK_AbpFeatureValues" PRIMARY KEY ("Id");


--
-- TOC entry 5314 (class 2606 OID 22509)
-- Name: AbpFeatures PK_AbpFeatures; Type: CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpFeatures"
    ADD CONSTRAINT "PK_AbpFeatures" PRIMARY KEY ("Id");


--
-- TOC entry 5320 (class 2606 OID 22525)
-- Name: AbpLinkUsers PK_AbpLinkUsers; Type: CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpLinkUsers"
    ADD CONSTRAINT "PK_AbpLinkUsers" PRIMARY KEY ("Id");


--
-- TOC entry 5383 (class 2606 OID 22767)
-- Name: AbpOrganizationUnitRoles PK_AbpOrganizationUnitRoles; Type: CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpOrganizationUnitRoles"
    ADD CONSTRAINT "PK_AbpOrganizationUnitRoles" PRIMARY KEY ("OrganizationUnitId", "RoleId");


--
-- TOC entry 5324 (class 2606 OID 22541)
-- Name: AbpOrganizationUnits PK_AbpOrganizationUnits; Type: CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpOrganizationUnits"
    ADD CONSTRAINT "PK_AbpOrganizationUnits" PRIMARY KEY ("Id");


--
-- TOC entry 5327 (class 2606 OID 22555)
-- Name: AbpPermissionGrants PK_AbpPermissionGrants; Type: CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpPermissionGrants"
    ADD CONSTRAINT "PK_AbpPermissionGrants" PRIMARY KEY ("Id");


--
-- TOC entry 5330 (class 2606 OID 22565)
-- Name: AbpPermissionGroups PK_AbpPermissionGroups; Type: CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpPermissionGroups"
    ADD CONSTRAINT "PK_AbpPermissionGroups" PRIMARY KEY ("Id");


--
-- TOC entry 5334 (class 2606 OID 22578)
-- Name: AbpPermissions PK_AbpPermissions; Type: CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpPermissions"
    ADD CONSTRAINT "PK_AbpPermissions" PRIMARY KEY ("Id");


--
-- TOC entry 5386 (class 2606 OID 22787)
-- Name: AbpRoleClaims PK_AbpRoleClaims; Type: CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpRoleClaims"
    ADD CONSTRAINT "PK_AbpRoleClaims" PRIMARY KEY ("Id");


--
-- TOC entry 5337 (class 2606 OID 22595)
-- Name: AbpRoles PK_AbpRoles; Type: CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpRoles"
    ADD CONSTRAINT "PK_AbpRoles" PRIMARY KEY ("Id");


--
-- TOC entry 5343 (class 2606 OID 22606)
-- Name: AbpSecurityLogs PK_AbpSecurityLogs; Type: CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpSecurityLogs"
    ADD CONSTRAINT "PK_AbpSecurityLogs" PRIMARY KEY ("Id");


--
-- TOC entry 5348 (class 2606 OID 22618)
-- Name: AbpSessions PK_AbpSessions; Type: CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpSessions"
    ADD CONSTRAINT "PK_AbpSessions" PRIMARY KEY ("Id");


--
-- TOC entry 5351 (class 2606 OID 22631)
-- Name: AbpSettingDefinitions PK_AbpSettingDefinitions; Type: CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpSettingDefinitions"
    ADD CONSTRAINT "PK_AbpSettingDefinitions" PRIMARY KEY ("Id");


--
-- TOC entry 5354 (class 2606 OID 22641)
-- Name: AbpSettings PK_AbpSettings; Type: CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpSettings"
    ADD CONSTRAINT "PK_AbpSettings" PRIMARY KEY ("Id");


--
-- TOC entry 5388 (class 2606 OID 22802)
-- Name: AbpTenantConnectionStrings PK_AbpTenantConnectionStrings; Type: CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpTenantConnectionStrings"
    ADD CONSTRAINT "PK_AbpTenantConnectionStrings" PRIMARY KEY ("TenantId", "Name");


--
-- TOC entry 5358 (class 2606 OID 22657)
-- Name: AbpTenants PK_AbpTenants; Type: CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpTenants"
    ADD CONSTRAINT "PK_AbpTenants" PRIMARY KEY ("Id");


--
-- TOC entry 5391 (class 2606 OID 22817)
-- Name: AbpUserClaims PK_AbpUserClaims; Type: CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpUserClaims"
    ADD CONSTRAINT "PK_AbpUserClaims" PRIMARY KEY ("Id");


--
-- TOC entry 5360 (class 2606 OID 22667)
-- Name: AbpUserDelegations PK_AbpUserDelegations; Type: CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpUserDelegations"
    ADD CONSTRAINT "PK_AbpUserDelegations" PRIMARY KEY ("Id");


--
-- TOC entry 5394 (class 2606 OID 22830)
-- Name: AbpUserLogins PK_AbpUserLogins; Type: CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpUserLogins"
    ADD CONSTRAINT "PK_AbpUserLogins" PRIMARY KEY ("UserId", "LoginProvider");


--
-- TOC entry 5397 (class 2606 OID 22843)
-- Name: AbpUserOrganizationUnits PK_AbpUserOrganizationUnits; Type: CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpUserOrganizationUnits"
    ADD CONSTRAINT "PK_AbpUserOrganizationUnits" PRIMARY KEY ("OrganizationUnitId", "UserId");


--
-- TOC entry 5400 (class 2606 OID 22860)
-- Name: AbpUserRoles PK_AbpUserRoles; Type: CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpUserRoles"
    ADD CONSTRAINT "PK_AbpUserRoles" PRIMARY KEY ("UserId", "RoleId");


--
-- TOC entry 5402 (class 2606 OID 22880)
-- Name: AbpUserTokens PK_AbpUserTokens; Type: CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpUserTokens"
    ADD CONSTRAINT "PK_AbpUserTokens" PRIMARY KEY ("UserId", "LoginProvider", "Name");


--
-- TOC entry 5366 (class 2606 OID 22700)
-- Name: AbpUsers PK_AbpUsers; Type: CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpUsers"
    ADD CONSTRAINT "PK_AbpUsers" PRIMARY KEY ("Id");


--
-- TOC entry 5369 (class 2606 OID 22713)
-- Name: OpenIddictApplications PK_OpenIddictApplications; Type: CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."OpenIddictApplications"
    ADD CONSTRAINT "PK_OpenIddictApplications" PRIMARY KEY ("Id");


--
-- TOC entry 5405 (class 2606 OID 22895)
-- Name: OpenIddictAuthorizations PK_OpenIddictAuthorizations; Type: CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."OpenIddictAuthorizations"
    ADD CONSTRAINT "PK_OpenIddictAuthorizations" PRIMARY KEY ("Id");


--
-- TOC entry 5372 (class 2606 OID 22726)
-- Name: OpenIddictScopes PK_OpenIddictScopes; Type: CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."OpenIddictScopes"
    ADD CONSTRAINT "PK_OpenIddictScopes" PRIMARY KEY ("Id");


--
-- TOC entry 5413 (class 2606 OID 22926)
-- Name: OpenIddictTokens PK_OpenIddictTokens; Type: CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."OpenIddictTokens"
    ADD CONSTRAINT "PK_OpenIddictTokens" PRIMARY KEY ("Id");


--
-- TOC entry 5296 (class 2606 OID 22432)
-- Name: __EFMigrationsHistory PK___EFMigrationsHistory; Type: CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."__EFMigrationsHistory"
    ADD CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId");


--
-- TOC entry 5528 (class 2606 OID 23648)
-- Name: doctors doctors_pkey; Type: CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity.doctors
    ADD CONSTRAINT doctors_pkey PRIMARY KEY (id);


--
-- TOC entry 5538 (class 2606 OID 23718)
-- Name: family_links family_links_pkey; Type: CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity.family_links
    ADD CONSTRAINT family_links_pkey PRIMARY KEY (id);


--
-- TOC entry 5536 (class 2606 OID 23666)
-- Name: patients patients_pkey; Type: CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity.patients
    ADD CONSTRAINT patients_pkey PRIMARY KEY (id);


--
-- TOC entry 5525 (class 2606 OID 23636)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 5492 (class 2606 OID 23439)
-- Name: medication_intake_logs medication_intake_logs_pkey; Type: CONSTRAINT; Schema: medication; Owner: postgres
--

ALTER TABLE ONLY medication.medication_intake_logs
    ADD CONSTRAINT medication_intake_logs_pkey PRIMARY KEY (id);


--
-- TOC entry 5488 (class 2606 OID 23418)
-- Name: medication_schedules medication_schedules_pkey; Type: CONSTRAINT; Schema: medication; Owner: postgres
--

ALTER TABLE ONLY medication.medication_schedules
    ADD CONSTRAINT medication_schedules_pkey PRIMARY KEY (id);


--
-- TOC entry 5485 (class 2606 OID 23402)
-- Name: prescription_items prescription_items_pkey; Type: CONSTRAINT; Schema: medication; Owner: postgres
--

ALTER TABLE ONLY medication.prescription_items
    ADD CONSTRAINT prescription_items_pkey PRIMARY KEY (id);


--
-- TOC entry 5482 (class 2606 OID 23389)
-- Name: prescriptions prescriptions_pkey; Type: CONSTRAINT; Schema: medication; Owner: postgres
--

ALTER TABLE ONLY medication.prescriptions
    ADD CONSTRAINT prescriptions_pkey PRIMARY KEY (id);


--
-- TOC entry 5466 (class 2606 OID 23293)
-- Name: patient_external_links patient_external_links_pkey; Type: CONSTRAINT; Schema: patient; Owner: postgres
--

ALTER TABLE ONLY patient.patient_external_links
    ADD CONSTRAINT patient_external_links_pkey PRIMARY KEY (id);


--
-- TOC entry 5461 (class 2606 OID 23279)
-- Name: patient_medical_summaries patient_medical_summaries_pkey; Type: CONSTRAINT; Schema: patient; Owner: postgres
--

ALTER TABLE ONLY patient.patient_medical_summaries
    ADD CONSTRAINT patient_medical_summaries_pkey PRIMARY KEY (id);


--
-- TOC entry 5457 (class 2606 OID 23265)
-- Name: patient_profile_extensions patient_profile_extensions_pkey; Type: CONSTRAINT; Schema: patient; Owner: postgres
--

ALTER TABLE ONLY patient.patient_profile_extensions
    ADD CONSTRAINT patient_profile_extensions_pkey PRIMARY KEY (id);


--
-- TOC entry 5552 (class 2606 OID 24399)
-- Name: __EFMigrationsHistory PK___EFMigrationsHistory; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."__EFMigrationsHistory"
    ADD CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId");


--
-- TOC entry 5522 (class 2606 OID 23610)
-- Name: vault_records vault_records_pkey; Type: CONSTRAINT; Schema: vault; Owner: postgres
--

ALTER TABLE ONLY vault.vault_records
    ADD CONSTRAINT vault_records_pkey PRIMARY KEY (id);


--
-- TOC entry 5477 (class 1259 OID 23376)
-- Name: ix_appointment_audits_appointment; Type: INDEX; Schema: appointment; Owner: postgres
--

CREATE INDEX ix_appointment_audits_appointment ON appointment.appointment_audits USING btree (appointment_id);


--
-- TOC entry 5478 (class 1259 OID 24388)
-- Name: ix_appointment_audits_changed_by_user; Type: INDEX; Schema: appointment; Owner: postgres
--

CREATE INDEX ix_appointment_audits_changed_by_user ON appointment.appointment_audits USING btree (changed_by_user_id, change_time DESC);


--
-- TOC entry 5469 (class 1259 OID 23326)
-- Name: ix_appointment_status_id; Type: INDEX; Schema: appointment; Owner: postgres
--

CREATE INDEX ix_appointment_status_id ON appointment.appointments USING btree (status_id);


--
-- TOC entry 5470 (class 1259 OID 23324)
-- Name: ix_appointment_tenant_doctor_start; Type: INDEX; Schema: appointment; Owner: postgres
--

CREATE INDEX ix_appointment_tenant_doctor_start ON appointment.appointments USING btree (tenant_id, identity_doctor_id, start_time);


--
-- TOC entry 5471 (class 1259 OID 23325)
-- Name: ix_appointment_tenant_patient_start; Type: INDEX; Schema: appointment; Owner: postgres
--

CREATE INDEX ix_appointment_tenant_patient_start ON appointment.appointments USING btree (tenant_id, identity_patient_id, start_time);


--
-- TOC entry 5474 (class 1259 OID 23346)
-- Name: ix_doc_schedule_tenant_doctor; Type: INDEX; Schema: appointment; Owner: postgres
--

CREATE INDEX ix_doc_schedule_tenant_doctor ON appointment.doctor_schedule_rules USING btree (tenant_id, identity_doctor_id);


--
-- TOC entry 5500 (class 1259 OID 23501)
-- Name: ix_consent_audits_consent; Type: INDEX; Schema: consent; Owner: postgres
--

CREATE INDEX ix_consent_audits_consent ON consent.consent_audits USING btree (consent_id);


--
-- TOC entry 5501 (class 1259 OID 24389)
-- Name: ix_consent_audits_performed_by_user; Type: INDEX; Schema: consent; Owner: postgres
--

CREATE INDEX ix_consent_audits_performed_by_user ON consent.consent_audits USING btree (performed_by_user_id, action_time DESC);


--
-- TOC entry 5495 (class 1259 OID 23480)
-- Name: ix_consents_party; Type: INDEX; Schema: consent; Owner: postgres
--

CREATE INDEX ix_consents_party ON consent.consents USING btree (granted_to_party_type_id, granted_to_party_id, status_id);


--
-- TOC entry 5496 (class 1259 OID 23479)
-- Name: ix_consents_patient; Type: INDEX; Schema: consent; Owner: postgres
--

CREATE INDEX ix_consents_patient ON consent.consents USING btree (identity_patient_id, status_id);


--
-- TOC entry 5497 (class 1259 OID 23481)
-- Name: ix_consents_tenant; Type: INDEX; Schema: consent; Owner: postgres
--

CREATE INDEX ix_consents_tenant ON consent.consents USING btree (tenant_id);


--
-- TOC entry 5508 (class 1259 OID 23541)
-- Name: ix_device_readings_device_time; Type: INDEX; Schema: device; Owner: postgres
--

CREATE INDEX ix_device_readings_device_time ON device.device_readings USING btree (device_id, reading_time);


--
-- TOC entry 5509 (class 1259 OID 23540)
-- Name: ix_device_readings_patient_time; Type: INDEX; Schema: device; Owner: postgres
--

CREATE INDEX ix_device_readings_patient_time ON device.device_readings USING btree (identity_patient_id, reading_time);


--
-- TOC entry 5510 (class 1259 OID 23542)
-- Name: ix_device_readings_type; Type: INDEX; Schema: device; Owner: postgres
--

CREATE INDEX ix_device_readings_type ON device.device_readings USING btree (reading_type);


--
-- TOC entry 5504 (class 1259 OID 23521)
-- Name: ix_devices_assigned_patient; Type: INDEX; Schema: device; Owner: postgres
--

CREATE INDEX ix_devices_assigned_patient ON device.devices USING btree (assigned_patient_id);


--
-- TOC entry 5505 (class 1259 OID 23520)
-- Name: ux_device_serial_tenant; Type: INDEX; Schema: device; Owner: postgres
--

CREATE UNIQUE INDEX ux_device_serial_tenant ON device.devices USING btree (tenant_id, device_serial);


--
-- TOC entry 5549 (class 1259 OID 23995)
-- Name: ix_chat_messages_sender; Type: INDEX; Schema: engagement; Owner: postgres
--

CREATE INDEX ix_chat_messages_sender ON engagement.chat_messages USING btree (sender_user_id, created_at);


--
-- TOC entry 5550 (class 1259 OID 23994)
-- Name: ix_chat_messages_session_created; Type: INDEX; Schema: engagement; Owner: postgres
--

CREATE INDEX ix_chat_messages_session_created ON engagement.chat_messages USING btree (session_id, created_at);


--
-- TOC entry 5543 (class 1259 OID 24390)
-- Name: ix_chat_sessions_created_by_user; Type: INDEX; Schema: engagement; Owner: postgres
--

CREATE INDEX ix_chat_sessions_created_by_user ON engagement.chat_sessions USING btree (created_by_user_id, started_at DESC);


--
-- TOC entry 5544 (class 1259 OID 23969)
-- Name: ix_chat_sessions_patient; Type: INDEX; Schema: engagement; Owner: postgres
--

CREATE INDEX ix_chat_sessions_patient ON engagement.chat_sessions USING btree (identity_patient_id, started_at DESC);


--
-- TOC entry 5545 (class 1259 OID 23971)
-- Name: ix_chat_sessions_related_appointment; Type: INDEX; Schema: engagement; Owner: postgres
--

CREATE INDEX ix_chat_sessions_related_appointment ON engagement.chat_sessions USING btree (related_appointment_id);


--
-- TOC entry 5546 (class 1259 OID 23970)
-- Name: ix_chat_sessions_tenant; Type: INDEX; Schema: engagement; Owner: postgres
--

CREATE INDEX ix_chat_sessions_tenant ON engagement.chat_sessions USING btree (tenant_id);


--
-- TOC entry 5514 (class 1259 OID 23591)
-- Name: ix_notifications_recipient; Type: INDEX; Schema: engagement; Owner: postgres
--

CREATE INDEX ix_notifications_recipient ON engagement.notifications USING btree (recipient_user_id, created_at DESC);


--
-- TOC entry 5515 (class 1259 OID 23592)
-- Name: ix_notifications_status_id; Type: INDEX; Schema: engagement; Owner: postgres
--

CREATE INDEX ix_notifications_status_id ON engagement.notifications USING btree (status_id);


--
-- TOC entry 5513 (class 1259 OID 23564)
-- Name: ux_notification_templates_key_tenant_channel; Type: INDEX; Schema: engagement; Owner: postgres
--

CREATE UNIQUE INDEX ux_notification_templates_key_tenant_channel ON engagement.notification_templates USING btree (tenant_id, template_key, channel_id);


--
-- TOC entry 5373 (class 1259 OID 22937)
-- Name: IX_AbpAuditLogActions_AuditLogId; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX "IX_AbpAuditLogActions_AuditLogId" ON identity."AbpAuditLogActions" USING btree ("AuditLogId");


--
-- TOC entry 5374 (class 1259 OID 22938)
-- Name: IX_AbpAuditLogActions_TenantId_ServiceName_MethodName_Executio~; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX "IX_AbpAuditLogActions_TenantId_ServiceName_MethodName_Executio~" ON identity."AbpAuditLogActions" USING btree ("TenantId", "ServiceName", "MethodName", "ExecutionTime");


--
-- TOC entry 5299 (class 1259 OID 22939)
-- Name: IX_AbpAuditLogs_TenantId_ExecutionTime; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX "IX_AbpAuditLogs_TenantId_ExecutionTime" ON identity."AbpAuditLogs" USING btree ("TenantId", "ExecutionTime");


--
-- TOC entry 5300 (class 1259 OID 22940)
-- Name: IX_AbpAuditLogs_TenantId_UserId_ExecutionTime; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX "IX_AbpAuditLogs_TenantId_UserId_ExecutionTime" ON identity."AbpAuditLogs" USING btree ("TenantId", "UserId", "ExecutionTime");


--
-- TOC entry 5303 (class 1259 OID 22941)
-- Name: IX_AbpBackgroundJobs_IsAbandoned_NextTryTime; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX "IX_AbpBackgroundJobs_IsAbandoned_NextTryTime" ON identity."AbpBackgroundJobs" USING btree ("IsAbandoned", "NextTryTime");


--
-- TOC entry 5377 (class 1259 OID 22942)
-- Name: IX_AbpEntityChanges_AuditLogId; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX "IX_AbpEntityChanges_AuditLogId" ON identity."AbpEntityChanges" USING btree ("AuditLogId");


--
-- TOC entry 5378 (class 1259 OID 22943)
-- Name: IX_AbpEntityChanges_TenantId_EntityTypeFullName_EntityId; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX "IX_AbpEntityChanges_TenantId_EntityTypeFullName_EntityId" ON identity."AbpEntityChanges" USING btree ("TenantId", "EntityTypeFullName", "EntityId");


--
-- TOC entry 5406 (class 1259 OID 22944)
-- Name: IX_AbpEntityPropertyChanges_EntityChangeId; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX "IX_AbpEntityPropertyChanges_EntityChangeId" ON identity."AbpEntityPropertyChanges" USING btree ("EntityChangeId");


--
-- TOC entry 5308 (class 1259 OID 22945)
-- Name: IX_AbpFeatureGroups_Name; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE UNIQUE INDEX "IX_AbpFeatureGroups_Name" ON identity."AbpFeatureGroups" USING btree ("Name");


--
-- TOC entry 5315 (class 1259 OID 22948)
-- Name: IX_AbpFeatureValues_Name_ProviderName_ProviderKey; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE UNIQUE INDEX "IX_AbpFeatureValues_Name_ProviderName_ProviderKey" ON identity."AbpFeatureValues" USING btree ("Name", "ProviderName", "ProviderKey");


--
-- TOC entry 5311 (class 1259 OID 22946)
-- Name: IX_AbpFeatures_GroupName; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX "IX_AbpFeatures_GroupName" ON identity."AbpFeatures" USING btree ("GroupName");


--
-- TOC entry 5312 (class 1259 OID 22947)
-- Name: IX_AbpFeatures_Name; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE UNIQUE INDEX "IX_AbpFeatures_Name" ON identity."AbpFeatures" USING btree ("Name");


--
-- TOC entry 5318 (class 1259 OID 22949)
-- Name: IX_AbpLinkUsers_SourceUserId_SourceTenantId_TargetUserId_Targe~; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE UNIQUE INDEX "IX_AbpLinkUsers_SourceUserId_SourceTenantId_TargetUserId_Targe~" ON identity."AbpLinkUsers" USING btree ("SourceUserId", "SourceTenantId", "TargetUserId", "TargetTenantId");


--
-- TOC entry 5381 (class 1259 OID 22950)
-- Name: IX_AbpOrganizationUnitRoles_RoleId_OrganizationUnitId; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX "IX_AbpOrganizationUnitRoles_RoleId_OrganizationUnitId" ON identity."AbpOrganizationUnitRoles" USING btree ("RoleId", "OrganizationUnitId");


--
-- TOC entry 5321 (class 1259 OID 22951)
-- Name: IX_AbpOrganizationUnits_Code; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX "IX_AbpOrganizationUnits_Code" ON identity."AbpOrganizationUnits" USING btree ("Code");


--
-- TOC entry 5322 (class 1259 OID 22952)
-- Name: IX_AbpOrganizationUnits_ParentId; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX "IX_AbpOrganizationUnits_ParentId" ON identity."AbpOrganizationUnits" USING btree ("ParentId");


--
-- TOC entry 5325 (class 1259 OID 22953)
-- Name: IX_AbpPermissionGrants_TenantId_Name_ProviderName_ProviderKey; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE UNIQUE INDEX "IX_AbpPermissionGrants_TenantId_Name_ProviderName_ProviderKey" ON identity."AbpPermissionGrants" USING btree ("TenantId", "Name", "ProviderName", "ProviderKey");


--
-- TOC entry 5328 (class 1259 OID 22954)
-- Name: IX_AbpPermissionGroups_Name; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE UNIQUE INDEX "IX_AbpPermissionGroups_Name" ON identity."AbpPermissionGroups" USING btree ("Name");


--
-- TOC entry 5331 (class 1259 OID 22955)
-- Name: IX_AbpPermissions_GroupName; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX "IX_AbpPermissions_GroupName" ON identity."AbpPermissions" USING btree ("GroupName");


--
-- TOC entry 5332 (class 1259 OID 22956)
-- Name: IX_AbpPermissions_Name; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE UNIQUE INDEX "IX_AbpPermissions_Name" ON identity."AbpPermissions" USING btree ("Name");


--
-- TOC entry 5384 (class 1259 OID 22957)
-- Name: IX_AbpRoleClaims_RoleId; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX "IX_AbpRoleClaims_RoleId" ON identity."AbpRoleClaims" USING btree ("RoleId");


--
-- TOC entry 5335 (class 1259 OID 22958)
-- Name: IX_AbpRoles_NormalizedName; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX "IX_AbpRoles_NormalizedName" ON identity."AbpRoles" USING btree ("NormalizedName");


--
-- TOC entry 5338 (class 1259 OID 22959)
-- Name: IX_AbpSecurityLogs_TenantId_Action; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX "IX_AbpSecurityLogs_TenantId_Action" ON identity."AbpSecurityLogs" USING btree ("TenantId", "Action");


--
-- TOC entry 5339 (class 1259 OID 22960)
-- Name: IX_AbpSecurityLogs_TenantId_ApplicationName; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX "IX_AbpSecurityLogs_TenantId_ApplicationName" ON identity."AbpSecurityLogs" USING btree ("TenantId", "ApplicationName");


--
-- TOC entry 5340 (class 1259 OID 22961)
-- Name: IX_AbpSecurityLogs_TenantId_Identity; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX "IX_AbpSecurityLogs_TenantId_Identity" ON identity."AbpSecurityLogs" USING btree ("TenantId", "Identity");


--
-- TOC entry 5341 (class 1259 OID 22962)
-- Name: IX_AbpSecurityLogs_TenantId_UserId; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX "IX_AbpSecurityLogs_TenantId_UserId" ON identity."AbpSecurityLogs" USING btree ("TenantId", "UserId");


--
-- TOC entry 5344 (class 1259 OID 22963)
-- Name: IX_AbpSessions_Device; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX "IX_AbpSessions_Device" ON identity."AbpSessions" USING btree ("Device");


--
-- TOC entry 5345 (class 1259 OID 22964)
-- Name: IX_AbpSessions_SessionId; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX "IX_AbpSessions_SessionId" ON identity."AbpSessions" USING btree ("SessionId");


--
-- TOC entry 5346 (class 1259 OID 22965)
-- Name: IX_AbpSessions_TenantId_UserId; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX "IX_AbpSessions_TenantId_UserId" ON identity."AbpSessions" USING btree ("TenantId", "UserId");


--
-- TOC entry 5349 (class 1259 OID 22966)
-- Name: IX_AbpSettingDefinitions_Name; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE UNIQUE INDEX "IX_AbpSettingDefinitions_Name" ON identity."AbpSettingDefinitions" USING btree ("Name");


--
-- TOC entry 5352 (class 1259 OID 22967)
-- Name: IX_AbpSettings_Name_ProviderName_ProviderKey; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE UNIQUE INDEX "IX_AbpSettings_Name_ProviderName_ProviderKey" ON identity."AbpSettings" USING btree ("Name", "ProviderName", "ProviderKey");


--
-- TOC entry 5355 (class 1259 OID 22968)
-- Name: IX_AbpTenants_Name; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX "IX_AbpTenants_Name" ON identity."AbpTenants" USING btree ("Name");


--
-- TOC entry 5356 (class 1259 OID 22969)
-- Name: IX_AbpTenants_NormalizedName; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX "IX_AbpTenants_NormalizedName" ON identity."AbpTenants" USING btree ("NormalizedName");


--
-- TOC entry 5389 (class 1259 OID 22970)
-- Name: IX_AbpUserClaims_UserId; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX "IX_AbpUserClaims_UserId" ON identity."AbpUserClaims" USING btree ("UserId");


--
-- TOC entry 5392 (class 1259 OID 22971)
-- Name: IX_AbpUserLogins_LoginProvider_ProviderKey; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX "IX_AbpUserLogins_LoginProvider_ProviderKey" ON identity."AbpUserLogins" USING btree ("LoginProvider", "ProviderKey");


--
-- TOC entry 5395 (class 1259 OID 22972)
-- Name: IX_AbpUserOrganizationUnits_UserId_OrganizationUnitId; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX "IX_AbpUserOrganizationUnits_UserId_OrganizationUnitId" ON identity."AbpUserOrganizationUnits" USING btree ("UserId", "OrganizationUnitId");


--
-- TOC entry 5398 (class 1259 OID 22973)
-- Name: IX_AbpUserRoles_RoleId_UserId; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX "IX_AbpUserRoles_RoleId_UserId" ON identity."AbpUserRoles" USING btree ("RoleId", "UserId");


--
-- TOC entry 5361 (class 1259 OID 22974)
-- Name: IX_AbpUsers_Email; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX "IX_AbpUsers_Email" ON identity."AbpUsers" USING btree ("Email");


--
-- TOC entry 5362 (class 1259 OID 22975)
-- Name: IX_AbpUsers_NormalizedEmail; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX "IX_AbpUsers_NormalizedEmail" ON identity."AbpUsers" USING btree ("NormalizedEmail");


--
-- TOC entry 5363 (class 1259 OID 22976)
-- Name: IX_AbpUsers_NormalizedUserName; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX "IX_AbpUsers_NormalizedUserName" ON identity."AbpUsers" USING btree ("NormalizedUserName");


--
-- TOC entry 5364 (class 1259 OID 22977)
-- Name: IX_AbpUsers_UserName; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX "IX_AbpUsers_UserName" ON identity."AbpUsers" USING btree ("UserName");


--
-- TOC entry 5367 (class 1259 OID 22978)
-- Name: IX_OpenIddictApplications_ClientId; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX "IX_OpenIddictApplications_ClientId" ON identity."OpenIddictApplications" USING btree ("ClientId");


--
-- TOC entry 5403 (class 1259 OID 22979)
-- Name: IX_OpenIddictAuthorizations_ApplicationId_Status_Subject_Type; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX "IX_OpenIddictAuthorizations_ApplicationId_Status_Subject_Type" ON identity."OpenIddictAuthorizations" USING btree ("ApplicationId", "Status", "Subject", "Type");


--
-- TOC entry 5370 (class 1259 OID 22980)
-- Name: IX_OpenIddictScopes_Name; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX "IX_OpenIddictScopes_Name" ON identity."OpenIddictScopes" USING btree ("Name");


--
-- TOC entry 5409 (class 1259 OID 22981)
-- Name: IX_OpenIddictTokens_ApplicationId_Status_Subject_Type; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX "IX_OpenIddictTokens_ApplicationId_Status_Subject_Type" ON identity."OpenIddictTokens" USING btree ("ApplicationId", "Status", "Subject", "Type");


--
-- TOC entry 5410 (class 1259 OID 22982)
-- Name: IX_OpenIddictTokens_AuthorizationId; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX "IX_OpenIddictTokens_AuthorizationId" ON identity."OpenIddictTokens" USING btree ("AuthorizationId");


--
-- TOC entry 5411 (class 1259 OID 22983)
-- Name: IX_OpenIddictTokens_ReferenceId; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX "IX_OpenIddictTokens_ReferenceId" ON identity."OpenIddictTokens" USING btree ("ReferenceId");


--
-- TOC entry 5529 (class 1259 OID 23656)
-- Name: ix_identity_doctors_specialization; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX ix_identity_doctors_specialization ON identity.doctors USING btree (specialization);


--
-- TOC entry 5530 (class 1259 OID 23654)
-- Name: ix_identity_doctors_tenant; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX ix_identity_doctors_tenant ON identity.doctors USING btree (tenant_id);


--
-- TOC entry 5531 (class 1259 OID 23655)
-- Name: ix_identity_doctors_user_id; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX ix_identity_doctors_user_id ON identity.doctors USING btree (user_id);


--
-- TOC entry 5539 (class 1259 OID 23729)
-- Name: ix_identity_family_links_tenant; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX ix_identity_family_links_tenant ON identity.family_links USING btree (tenant_id) WITH (fillfactor='100', deduplicate_items='true');


--
-- TOC entry 5540 (class 1259 OID 23730)
-- Name: ix_identity_family_links_user_id; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX ix_identity_family_links_user_id ON identity.family_links USING btree (family_user_id) WITH (fillfactor='100', deduplicate_items='true');


--
-- TOC entry 5532 (class 1259 OID 23674)
-- Name: ix_identity_patients_dob; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX ix_identity_patients_dob ON identity.patients USING btree (date_of_birth);


--
-- TOC entry 5533 (class 1259 OID 23672)
-- Name: ix_identity_patients_tenant; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX ix_identity_patients_tenant ON identity.patients USING btree (tenant_id);


--
-- TOC entry 5534 (class 1259 OID 23673)
-- Name: ix_identity_patients_user_id; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX ix_identity_patients_user_id ON identity.patients USING btree (user_id);


--
-- TOC entry 5523 (class 1259 OID 23637)
-- Name: ix_identity_users_tenant; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE INDEX ix_identity_users_tenant ON identity.users USING btree (tenant_id);


--
-- TOC entry 5526 (class 1259 OID 23638)
-- Name: ux_identity_users_username_tenant; Type: INDEX; Schema: identity; Owner: postgres
--

CREATE UNIQUE INDEX ux_identity_users_username_tenant ON identity.users USING btree (tenant_id, user_name);


--
-- TOC entry 5489 (class 1259 OID 23450)
-- Name: ix_med_intake_patient_scheduled; Type: INDEX; Schema: medication; Owner: postgres
--

CREATE INDEX ix_med_intake_patient_scheduled ON medication.medication_intake_logs USING btree (identity_patient_id, scheduled_time);


--
-- TOC entry 5490 (class 1259 OID 23451)
-- Name: ix_med_intake_status_id; Type: INDEX; Schema: medication; Owner: postgres
--

CREATE INDEX ix_med_intake_status_id ON medication.medication_intake_logs USING btree (status_id);


--
-- TOC entry 5486 (class 1259 OID 23424)
-- Name: ix_med_schedules_patient; Type: INDEX; Schema: medication; Owner: postgres
--

CREATE INDEX ix_med_schedules_patient ON medication.medication_schedules USING btree (identity_patient_id);


--
-- TOC entry 5483 (class 1259 OID 23408)
-- Name: ix_prescription_items_prescription; Type: INDEX; Schema: medication; Owner: postgres
--

CREATE INDEX ix_prescription_items_prescription ON medication.prescription_items USING btree (prescription_id);


--
-- TOC entry 5479 (class 1259 OID 23391)
-- Name: ix_prescriptions_tenant_doctor; Type: INDEX; Schema: medication; Owner: postgres
--

CREATE INDEX ix_prescriptions_tenant_doctor ON medication.prescriptions USING btree (tenant_id, identity_doctor_id, created_at DESC);


--
-- TOC entry 5480 (class 1259 OID 23390)
-- Name: ix_prescriptions_tenant_patient; Type: INDEX; Schema: medication; Owner: postgres
--

CREATE INDEX ix_prescriptions_tenant_patient ON medication.prescriptions USING btree (tenant_id, identity_patient_id, created_at DESC);


--
-- TOC entry 5462 (class 1259 OID 23295)
-- Name: ix_patient_ext_links_identity_patient; Type: INDEX; Schema: patient; Owner: postgres
--

CREATE INDEX ix_patient_ext_links_identity_patient ON patient.patient_external_links USING btree (identity_patient_id);


--
-- TOC entry 5463 (class 1259 OID 23296)
-- Name: ix_patient_ext_links_system; Type: INDEX; Schema: patient; Owner: postgres
--

CREATE INDEX ix_patient_ext_links_system ON patient.patient_external_links USING btree (system_name);


--
-- TOC entry 5464 (class 1259 OID 23294)
-- Name: ix_patient_ext_links_tenant; Type: INDEX; Schema: patient; Owner: postgres
--

CREATE INDEX ix_patient_ext_links_tenant ON patient.patient_external_links USING btree (tenant_id);


--
-- TOC entry 5458 (class 1259 OID 23281)
-- Name: ix_patient_med_summaries_identity_patient; Type: INDEX; Schema: patient; Owner: postgres
--

CREATE INDEX ix_patient_med_summaries_identity_patient ON patient.patient_medical_summaries USING btree (identity_patient_id);


--
-- TOC entry 5459 (class 1259 OID 23280)
-- Name: ix_patient_med_summaries_tenant; Type: INDEX; Schema: patient; Owner: postgres
--

CREATE INDEX ix_patient_med_summaries_tenant ON patient.patient_medical_summaries USING btree (tenant_id);


--
-- TOC entry 5454 (class 1259 OID 23267)
-- Name: ix_patient_profile_ext_identity_patient; Type: INDEX; Schema: patient; Owner: postgres
--

CREATE INDEX ix_patient_profile_ext_identity_patient ON patient.patient_profile_extensions USING btree (identity_patient_id);


--
-- TOC entry 5455 (class 1259 OID 23266)
-- Name: ix_patient_profile_ext_tenant; Type: INDEX; Schema: patient; Owner: postgres
--

CREATE INDEX ix_patient_profile_ext_tenant ON patient.patient_profile_extensions USING btree (tenant_id);


--
-- TOC entry 5518 (class 1259 OID 23617)
-- Name: ix_vault_records_expiry; Type: INDEX; Schema: vault; Owner: postgres
--

CREATE INDEX ix_vault_records_expiry ON vault.vault_records USING btree (expiry_date);


--
-- TOC entry 5519 (class 1259 OID 23618)
-- Name: ix_vault_records_owner; Type: INDEX; Schema: vault; Owner: postgres
--

CREATE INDEX ix_vault_records_owner ON vault.vault_records USING btree (owner_user_id);


--
-- TOC entry 5520 (class 1259 OID 23616)
-- Name: ix_vault_records_patient_type; Type: INDEX; Schema: vault; Owner: postgres
--

CREATE INDEX ix_vault_records_patient_type ON vault.vault_records USING btree (identity_patient_id, record_type_id);


--
-- TOC entry 5580 (class 2606 OID 23361)
-- Name: appointment_audits fk_appointment_audits_appointment; Type: FK CONSTRAINT; Schema: appointment; Owner: postgres
--

ALTER TABLE ONLY appointment.appointment_audits
    ADD CONSTRAINT fk_appointment_audits_appointment FOREIGN KEY (appointment_id) REFERENCES appointment.appointments(id);


--
-- TOC entry 5581 (class 2606 OID 24120)
-- Name: appointment_audits fk_appointment_audits_changed_by_user; Type: FK CONSTRAINT; Schema: appointment; Owner: postgres
--

ALTER TABLE ONLY appointment.appointment_audits
    ADD CONSTRAINT fk_appointment_audits_changed_by_user FOREIGN KEY (changed_by_user_id) REFERENCES identity."AbpUsers"("Id");


--
-- TOC entry 5582 (class 2606 OID 23371)
-- Name: appointment_audits fk_appointment_audits_new_status; Type: FK CONSTRAINT; Schema: appointment; Owner: postgres
--

ALTER TABLE ONLY appointment.appointment_audits
    ADD CONSTRAINT fk_appointment_audits_new_status FOREIGN KEY (new_status_id) REFERENCES configuration.appointment_statuses(id);


--
-- TOC entry 5583 (class 2606 OID 23366)
-- Name: appointment_audits fk_appointment_audits_old_status; Type: FK CONSTRAINT; Schema: appointment; Owner: postgres
--

ALTER TABLE ONLY appointment.appointment_audits
    ADD CONSTRAINT fk_appointment_audits_old_status FOREIGN KEY (old_status_id) REFERENCES configuration.appointment_statuses(id);


--
-- TOC entry 5574 (class 2606 OID 23319)
-- Name: appointments fk_appointment_channel; Type: FK CONSTRAINT; Schema: appointment; Owner: postgres
--

ALTER TABLE ONLY appointment.appointments
    ADD CONSTRAINT fk_appointment_channel FOREIGN KEY (channel_id) REFERENCES configuration.appointment_channels(id);


--
-- TOC entry 5575 (class 2606 OID 23314)
-- Name: appointments fk_appointment_status; Type: FK CONSTRAINT; Schema: appointment; Owner: postgres
--

ALTER TABLE ONLY appointment.appointments
    ADD CONSTRAINT fk_appointment_status FOREIGN KEY (status_id) REFERENCES configuration.appointment_statuses(id);


--
-- TOC entry 5576 (class 2606 OID 24176)
-- Name: appointments fk_appointments_doctor; Type: FK CONSTRAINT; Schema: appointment; Owner: postgres
--

ALTER TABLE ONLY appointment.appointments
    ADD CONSTRAINT fk_appointments_doctor FOREIGN KEY (identity_doctor_id) REFERENCES identity.doctors(id);


--
-- TOC entry 5577 (class 2606 OID 24171)
-- Name: appointments fk_appointments_patient; Type: FK CONSTRAINT; Schema: appointment; Owner: postgres
--

ALTER TABLE ONLY appointment.appointments
    ADD CONSTRAINT fk_appointments_patient FOREIGN KEY (identity_patient_id) REFERENCES identity.patients(id);


--
-- TOC entry 5578 (class 2606 OID 23341)
-- Name: doctor_schedule_rules fk_doc_schedule_day; Type: FK CONSTRAINT; Schema: appointment; Owner: postgres
--

ALTER TABLE ONLY appointment.doctor_schedule_rules
    ADD CONSTRAINT fk_doc_schedule_day FOREIGN KEY (day_of_week_id) REFERENCES configuration.days_of_week(id);


--
-- TOC entry 5579 (class 2606 OID 24383)
-- Name: doctor_schedule_rules fk_doc_schedule_doctor; Type: FK CONSTRAINT; Schema: appointment; Owner: postgres
--

ALTER TABLE ONLY appointment.doctor_schedule_rules
    ADD CONSTRAINT fk_doc_schedule_doctor FOREIGN KEY (identity_doctor_id) REFERENCES identity.doctors(id);


--
-- TOC entry 5595 (class 2606 OID 23496)
-- Name: consent_audits fk_consent_audits_consent; Type: FK CONSTRAINT; Schema: consent; Owner: postgres
--

ALTER TABLE ONLY consent.consent_audits
    ADD CONSTRAINT fk_consent_audits_consent FOREIGN KEY (consent_id) REFERENCES consent.consents(id);


--
-- TOC entry 5596 (class 2606 OID 24213)
-- Name: consent_audits fk_consent_audits_performed_by_user; Type: FK CONSTRAINT; Schema: consent; Owner: postgres
--

ALTER TABLE ONLY consent.consent_audits
    ADD CONSTRAINT fk_consent_audits_performed_by_user FOREIGN KEY (performed_by_user_id) REFERENCES identity."AbpUsers"("Id");


--
-- TOC entry 5592 (class 2606 OID 23469)
-- Name: consents fk_consents_party_type; Type: FK CONSTRAINT; Schema: consent; Owner: postgres
--

ALTER TABLE ONLY consent.consents
    ADD CONSTRAINT fk_consents_party_type FOREIGN KEY (granted_to_party_type_id) REFERENCES configuration.consent_party_types(id);


--
-- TOC entry 5593 (class 2606 OID 24208)
-- Name: consents fk_consents_patient; Type: FK CONSTRAINT; Schema: consent; Owner: postgres
--

ALTER TABLE ONLY consent.consents
    ADD CONSTRAINT fk_consents_patient FOREIGN KEY (identity_patient_id) REFERENCES identity.patients(id);


--
-- TOC entry 5594 (class 2606 OID 23474)
-- Name: consents fk_consents_status; Type: FK CONSTRAINT; Schema: consent; Owner: postgres
--

ALTER TABLE ONLY consent.consents
    ADD CONSTRAINT fk_consents_status FOREIGN KEY (status_id) REFERENCES configuration.consent_statuses(id);


--
-- TOC entry 5599 (class 2606 OID 23535)
-- Name: device_readings fk_device_readings_device; Type: FK CONSTRAINT; Schema: device; Owner: postgres
--

ALTER TABLE ONLY device.device_readings
    ADD CONSTRAINT fk_device_readings_device FOREIGN KEY (device_id) REFERENCES device.devices(id);


--
-- TOC entry 5600 (class 2606 OID 24240)
-- Name: device_readings fk_device_readings_patient; Type: FK CONSTRAINT; Schema: device; Owner: postgres
--

ALTER TABLE ONLY device.device_readings
    ADD CONSTRAINT fk_device_readings_patient FOREIGN KEY (identity_patient_id) REFERENCES identity.patients(id);


--
-- TOC entry 5597 (class 2606 OID 24258)
-- Name: devices fk_devices_assigned_patient; Type: FK CONSTRAINT; Schema: device; Owner: postgres
--

ALTER TABLE ONLY device.devices
    ADD CONSTRAINT fk_devices_assigned_patient FOREIGN KEY (assigned_patient_id) REFERENCES identity.patients(id);


--
-- TOC entry 5598 (class 2606 OID 23515)
-- Name: devices fk_devices_type; Type: FK CONSTRAINT; Schema: device; Owner: postgres
--

ALTER TABLE ONLY device.devices
    ADD CONSTRAINT fk_devices_type FOREIGN KEY (device_type_id) REFERENCES configuration.device_types(id);


--
-- TOC entry 5616 (class 2606 OID 24346)
-- Name: chat_messages fk_chat_messages_sender_user; Type: FK CONSTRAINT; Schema: engagement; Owner: postgres
--

ALTER TABLE ONLY engagement.chat_messages
    ADD CONSTRAINT fk_chat_messages_sender_user FOREIGN KEY (sender_user_id) REFERENCES identity."AbpUsers"("Id");


--
-- TOC entry 5617 (class 2606 OID 24341)
-- Name: chat_messages fk_chat_messages_session; Type: FK CONSTRAINT; Schema: engagement; Owner: postgres
--

ALTER TABLE ONLY engagement.chat_messages
    ADD CONSTRAINT fk_chat_messages_session FOREIGN KEY (session_id) REFERENCES engagement.chat_sessions(id);


--
-- TOC entry 5613 (class 2606 OID 24336)
-- Name: chat_sessions fk_chat_sessions_appointment; Type: FK CONSTRAINT; Schema: engagement; Owner: postgres
--

ALTER TABLE ONLY engagement.chat_sessions
    ADD CONSTRAINT fk_chat_sessions_appointment FOREIGN KEY (related_appointment_id) REFERENCES appointment.appointments(id);


--
-- TOC entry 5614 (class 2606 OID 24331)
-- Name: chat_sessions fk_chat_sessions_created_by_user; Type: FK CONSTRAINT; Schema: engagement; Owner: postgres
--

ALTER TABLE ONLY engagement.chat_sessions
    ADD CONSTRAINT fk_chat_sessions_created_by_user FOREIGN KEY (created_by_user_id) REFERENCES identity."AbpUsers"("Id");


--
-- TOC entry 5615 (class 2606 OID 24326)
-- Name: chat_sessions fk_chat_sessions_patient; Type: FK CONSTRAINT; Schema: engagement; Owner: postgres
--

ALTER TABLE ONLY engagement.chat_sessions
    ADD CONSTRAINT fk_chat_sessions_patient FOREIGN KEY (identity_patient_id) REFERENCES identity.patients(id);


--
-- TOC entry 5601 (class 2606 OID 23559)
-- Name: notification_templates fk_notif_templates_channel; Type: FK CONSTRAINT; Schema: engagement; Owner: postgres
--

ALTER TABLE ONLY engagement.notification_templates
    ADD CONSTRAINT fk_notif_templates_channel FOREIGN KEY (channel_id) REFERENCES configuration.notification_channels(id);


--
-- TOC entry 5602 (class 2606 OID 23581)
-- Name: notifications fk_notifications_channel; Type: FK CONSTRAINT; Schema: engagement; Owner: postgres
--

ALTER TABLE ONLY engagement.notifications
    ADD CONSTRAINT fk_notifications_channel FOREIGN KEY (channel_id) REFERENCES configuration.notification_channels(id);


--
-- TOC entry 5603 (class 2606 OID 24321)
-- Name: notifications fk_notifications_recipient_user; Type: FK CONSTRAINT; Schema: engagement; Owner: postgres
--

ALTER TABLE ONLY engagement.notifications
    ADD CONSTRAINT fk_notifications_recipient_user FOREIGN KEY (recipient_user_id) REFERENCES identity."AbpUsers"("Id");


--
-- TOC entry 5604 (class 2606 OID 23586)
-- Name: notifications fk_notifications_status; Type: FK CONSTRAINT; Schema: engagement; Owner: postgres
--

ALTER TABLE ONLY engagement.notifications
    ADD CONSTRAINT fk_notifications_status FOREIGN KEY (status_id) REFERENCES configuration.notification_statuses(id);


--
-- TOC entry 5554 (class 2606 OID 22738)
-- Name: AbpAuditLogActions FK_AbpAuditLogActions_AbpAuditLogs_AuditLogId; Type: FK CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpAuditLogActions"
    ADD CONSTRAINT "FK_AbpAuditLogActions_AbpAuditLogs_AuditLogId" FOREIGN KEY ("AuditLogId") REFERENCES identity."AbpAuditLogs"("Id") ON DELETE CASCADE;


--
-- TOC entry 5555 (class 2606 OID 22755)
-- Name: AbpEntityChanges FK_AbpEntityChanges_AbpAuditLogs_AuditLogId; Type: FK CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpEntityChanges"
    ADD CONSTRAINT "FK_AbpEntityChanges_AbpAuditLogs_AuditLogId" FOREIGN KEY ("AuditLogId") REFERENCES identity."AbpAuditLogs"("Id") ON DELETE CASCADE;


--
-- TOC entry 5568 (class 2606 OID 22912)
-- Name: AbpEntityPropertyChanges FK_AbpEntityPropertyChanges_AbpEntityChanges_EntityChangeId; Type: FK CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpEntityPropertyChanges"
    ADD CONSTRAINT "FK_AbpEntityPropertyChanges_AbpEntityChanges_EntityChangeId" FOREIGN KEY ("EntityChangeId") REFERENCES identity."AbpEntityChanges"("Id") ON DELETE CASCADE;


--
-- TOC entry 5556 (class 2606 OID 22768)
-- Name: AbpOrganizationUnitRoles FK_AbpOrganizationUnitRoles_AbpOrganizationUnits_OrganizationU~; Type: FK CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpOrganizationUnitRoles"
    ADD CONSTRAINT "FK_AbpOrganizationUnitRoles_AbpOrganizationUnits_OrganizationU~" FOREIGN KEY ("OrganizationUnitId") REFERENCES identity."AbpOrganizationUnits"("Id") ON DELETE CASCADE;


--
-- TOC entry 5557 (class 2606 OID 22773)
-- Name: AbpOrganizationUnitRoles FK_AbpOrganizationUnitRoles_AbpRoles_RoleId; Type: FK CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpOrganizationUnitRoles"
    ADD CONSTRAINT "FK_AbpOrganizationUnitRoles_AbpRoles_RoleId" FOREIGN KEY ("RoleId") REFERENCES identity."AbpRoles"("Id") ON DELETE CASCADE;


--
-- TOC entry 5553 (class 2606 OID 22542)
-- Name: AbpOrganizationUnits FK_AbpOrganizationUnits_AbpOrganizationUnits_ParentId; Type: FK CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpOrganizationUnits"
    ADD CONSTRAINT "FK_AbpOrganizationUnits_AbpOrganizationUnits_ParentId" FOREIGN KEY ("ParentId") REFERENCES identity."AbpOrganizationUnits"("Id");


--
-- TOC entry 5558 (class 2606 OID 22788)
-- Name: AbpRoleClaims FK_AbpRoleClaims_AbpRoles_RoleId; Type: FK CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpRoleClaims"
    ADD CONSTRAINT "FK_AbpRoleClaims_AbpRoles_RoleId" FOREIGN KEY ("RoleId") REFERENCES identity."AbpRoles"("Id") ON DELETE CASCADE;


--
-- TOC entry 5559 (class 2606 OID 22803)
-- Name: AbpTenantConnectionStrings FK_AbpTenantConnectionStrings_AbpTenants_TenantId; Type: FK CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpTenantConnectionStrings"
    ADD CONSTRAINT "FK_AbpTenantConnectionStrings_AbpTenants_TenantId" FOREIGN KEY ("TenantId") REFERENCES identity."AbpTenants"("Id") ON DELETE CASCADE;


--
-- TOC entry 5560 (class 2606 OID 22818)
-- Name: AbpUserClaims FK_AbpUserClaims_AbpUsers_UserId; Type: FK CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpUserClaims"
    ADD CONSTRAINT "FK_AbpUserClaims_AbpUsers_UserId" FOREIGN KEY ("UserId") REFERENCES identity."AbpUsers"("Id") ON DELETE CASCADE;


--
-- TOC entry 5561 (class 2606 OID 22831)
-- Name: AbpUserLogins FK_AbpUserLogins_AbpUsers_UserId; Type: FK CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpUserLogins"
    ADD CONSTRAINT "FK_AbpUserLogins_AbpUsers_UserId" FOREIGN KEY ("UserId") REFERENCES identity."AbpUsers"("Id") ON DELETE CASCADE;


--
-- TOC entry 5562 (class 2606 OID 22844)
-- Name: AbpUserOrganizationUnits FK_AbpUserOrganizationUnits_AbpOrganizationUnits_OrganizationU~; Type: FK CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpUserOrganizationUnits"
    ADD CONSTRAINT "FK_AbpUserOrganizationUnits_AbpOrganizationUnits_OrganizationU~" FOREIGN KEY ("OrganizationUnitId") REFERENCES identity."AbpOrganizationUnits"("Id") ON DELETE CASCADE;


--
-- TOC entry 5563 (class 2606 OID 22849)
-- Name: AbpUserOrganizationUnits FK_AbpUserOrganizationUnits_AbpUsers_UserId; Type: FK CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpUserOrganizationUnits"
    ADD CONSTRAINT "FK_AbpUserOrganizationUnits_AbpUsers_UserId" FOREIGN KEY ("UserId") REFERENCES identity."AbpUsers"("Id") ON DELETE CASCADE;


--
-- TOC entry 5564 (class 2606 OID 22861)
-- Name: AbpUserRoles FK_AbpUserRoles_AbpRoles_RoleId; Type: FK CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpUserRoles"
    ADD CONSTRAINT "FK_AbpUserRoles_AbpRoles_RoleId" FOREIGN KEY ("RoleId") REFERENCES identity."AbpRoles"("Id") ON DELETE CASCADE;


--
-- TOC entry 5565 (class 2606 OID 22866)
-- Name: AbpUserRoles FK_AbpUserRoles_AbpUsers_UserId; Type: FK CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpUserRoles"
    ADD CONSTRAINT "FK_AbpUserRoles_AbpUsers_UserId" FOREIGN KEY ("UserId") REFERENCES identity."AbpUsers"("Id") ON DELETE CASCADE;


--
-- TOC entry 5566 (class 2606 OID 22881)
-- Name: AbpUserTokens FK_AbpUserTokens_AbpUsers_UserId; Type: FK CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."AbpUserTokens"
    ADD CONSTRAINT "FK_AbpUserTokens_AbpUsers_UserId" FOREIGN KEY ("UserId") REFERENCES identity."AbpUsers"("Id") ON DELETE CASCADE;


--
-- TOC entry 5567 (class 2606 OID 22896)
-- Name: OpenIddictAuthorizations FK_OpenIddictAuthorizations_OpenIddictApplications_Application~; Type: FK CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."OpenIddictAuthorizations"
    ADD CONSTRAINT "FK_OpenIddictAuthorizations_OpenIddictApplications_Application~" FOREIGN KEY ("ApplicationId") REFERENCES identity."OpenIddictApplications"("Id");


--
-- TOC entry 5569 (class 2606 OID 22927)
-- Name: OpenIddictTokens FK_OpenIddictTokens_OpenIddictApplications_ApplicationId; Type: FK CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."OpenIddictTokens"
    ADD CONSTRAINT "FK_OpenIddictTokens_OpenIddictApplications_ApplicationId" FOREIGN KEY ("ApplicationId") REFERENCES identity."OpenIddictApplications"("Id");


--
-- TOC entry 5570 (class 2606 OID 22932)
-- Name: OpenIddictTokens FK_OpenIddictTokens_OpenIddictAuthorizations_AuthorizationId; Type: FK CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity."OpenIddictTokens"
    ADD CONSTRAINT "FK_OpenIddictTokens_OpenIddictAuthorizations_AuthorizationId" FOREIGN KEY ("AuthorizationId") REFERENCES identity."OpenIddictAuthorizations"("Id");


--
-- TOC entry 5611 (class 2606 OID 23719)
-- Name: family_links family_links_patient_id_fkey; Type: FK CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity.family_links
    ADD CONSTRAINT family_links_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES identity.patients(id);


--
-- TOC entry 5609 (class 2606 OID 23684)
-- Name: doctors fk_identity_doctors_user; Type: FK CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity.doctors
    ADD CONSTRAINT fk_identity_doctors_user FOREIGN KEY (user_id) REFERENCES identity."AbpUsers"("Id") ON DELETE CASCADE;


--
-- TOC entry 5612 (class 2606 OID 23724)
-- Name: family_links fk_identity_family_links_user; Type: FK CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity.family_links
    ADD CONSTRAINT fk_identity_family_links_user FOREIGN KEY (family_user_id) REFERENCES identity."AbpUsers"("Id") ON DELETE CASCADE;


--
-- TOC entry 5610 (class 2606 OID 23698)
-- Name: patients fk_identity_patients_user; Type: FK CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity.patients
    ADD CONSTRAINT fk_identity_patients_user FOREIGN KEY (user_id) REFERENCES identity."AbpUsers"("Id") ON DELETE CASCADE;


--
-- TOC entry 5608 (class 2606 OID 24051)
-- Name: users fk_identity_users_abpusers; Type: FK CONSTRAINT; Schema: identity; Owner: postgres
--

ALTER TABLE ONLY identity.users
    ADD CONSTRAINT fk_identity_users_abpusers FOREIGN KEY (id) REFERENCES identity."AbpUsers"("Id");


--
-- TOC entry 5589 (class 2606 OID 23440)
-- Name: medication_intake_logs fk_med_intake_logs_item; Type: FK CONSTRAINT; Schema: medication; Owner: postgres
--

ALTER TABLE ONLY medication.medication_intake_logs
    ADD CONSTRAINT fk_med_intake_logs_item FOREIGN KEY (prescription_item_id) REFERENCES medication.prescription_items(id);


--
-- TOC entry 5590 (class 2606 OID 24305)
-- Name: medication_intake_logs fk_med_intake_logs_patient; Type: FK CONSTRAINT; Schema: medication; Owner: postgres
--

ALTER TABLE ONLY medication.medication_intake_logs
    ADD CONSTRAINT fk_med_intake_logs_patient FOREIGN KEY (identity_patient_id) REFERENCES identity.patients(id);


--
-- TOC entry 5591 (class 2606 OID 23445)
-- Name: medication_intake_logs fk_med_intake_status; Type: FK CONSTRAINT; Schema: medication; Owner: postgres
--

ALTER TABLE ONLY medication.medication_intake_logs
    ADD CONSTRAINT fk_med_intake_status FOREIGN KEY (status_id) REFERENCES configuration.medication_intake_statuses(id);


--
-- TOC entry 5587 (class 2606 OID 23419)
-- Name: medication_schedules fk_med_schedules_item; Type: FK CONSTRAINT; Schema: medication; Owner: postgres
--

ALTER TABLE ONLY medication.medication_schedules
    ADD CONSTRAINT fk_med_schedules_item FOREIGN KEY (prescription_item_id) REFERENCES medication.prescription_items(id);


--
-- TOC entry 5588 (class 2606 OID 24300)
-- Name: medication_schedules fk_med_schedules_patient; Type: FK CONSTRAINT; Schema: medication; Owner: postgres
--

ALTER TABLE ONLY medication.medication_schedules
    ADD CONSTRAINT fk_med_schedules_patient FOREIGN KEY (identity_patient_id) REFERENCES identity.patients(id);


--
-- TOC entry 5586 (class 2606 OID 23403)
-- Name: prescription_items fk_prescription_items_prescription; Type: FK CONSTRAINT; Schema: medication; Owner: postgres
--

ALTER TABLE ONLY medication.prescription_items
    ADD CONSTRAINT fk_prescription_items_prescription FOREIGN KEY (prescription_id) REFERENCES medication.prescriptions(id);


--
-- TOC entry 5584 (class 2606 OID 24295)
-- Name: prescriptions fk_prescriptions_doctor; Type: FK CONSTRAINT; Schema: medication; Owner: postgres
--

ALTER TABLE ONLY medication.prescriptions
    ADD CONSTRAINT fk_prescriptions_doctor FOREIGN KEY (identity_doctor_id) REFERENCES identity.doctors(id);


--
-- TOC entry 5585 (class 2606 OID 24290)
-- Name: prescriptions fk_prescriptions_patient; Type: FK CONSTRAINT; Schema: medication; Owner: postgres
--

ALTER TABLE ONLY medication.prescriptions
    ADD CONSTRAINT fk_prescriptions_patient FOREIGN KEY (identity_patient_id) REFERENCES identity.patients(id);


--
-- TOC entry 5573 (class 2606 OID 24095)
-- Name: patient_external_links fk_patient_ext_links_patient; Type: FK CONSTRAINT; Schema: patient; Owner: postgres
--

ALTER TABLE ONLY patient.patient_external_links
    ADD CONSTRAINT fk_patient_ext_links_patient FOREIGN KEY (identity_patient_id) REFERENCES identity.patients(id);


--
-- TOC entry 5572 (class 2606 OID 24078)
-- Name: patient_medical_summaries fk_patient_med_summaries_patient; Type: FK CONSTRAINT; Schema: patient; Owner: postgres
--

ALTER TABLE ONLY patient.patient_medical_summaries
    ADD CONSTRAINT fk_patient_med_summaries_patient FOREIGN KEY (identity_patient_id) REFERENCES identity.patients(id);


--
-- TOC entry 5571 (class 2606 OID 24067)
-- Name: patient_profile_extensions fk_patient_profile_ext_patient; Type: FK CONSTRAINT; Schema: patient; Owner: postgres
--

ALTER TABLE ONLY patient.patient_profile_extensions
    ADD CONSTRAINT fk_patient_profile_ext_patient FOREIGN KEY (identity_patient_id) REFERENCES identity.patients(id);


--
-- TOC entry 5605 (class 2606 OID 23611)
-- Name: vault_records fk_vault_record_type; Type: FK CONSTRAINT; Schema: vault; Owner: postgres
--

ALTER TABLE ONLY vault.vault_records
    ADD CONSTRAINT fk_vault_record_type FOREIGN KEY (record_type_id) REFERENCES configuration.vault_record_types(id);


--
-- TOC entry 5606 (class 2606 OID 24368)
-- Name: vault_records fk_vault_records_owner_user; Type: FK CONSTRAINT; Schema: vault; Owner: postgres
--

ALTER TABLE ONLY vault.vault_records
    ADD CONSTRAINT fk_vault_records_owner_user FOREIGN KEY (owner_user_id) REFERENCES identity."AbpUsers"("Id");


--
-- TOC entry 5607 (class 2606 OID 24363)
-- Name: vault_records fk_vault_records_patient; Type: FK CONSTRAINT; Schema: vault; Owner: postgres
--

ALTER TABLE ONLY vault.vault_records
    ADD CONSTRAINT fk_vault_records_patient FOREIGN KEY (identity_patient_id) REFERENCES identity.patients(id);


--
-- TOC entry 5841 (class 0 OID 0)
-- Dependencies: 14
-- Name: SCHEMA identity; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA identity FROM pg_database_owner;
REVOKE USAGE ON SCHEMA identity FROM PUBLIC;
GRANT ALL ON SCHEMA identity TO postgres;
GRANT USAGE ON SCHEMA identity TO PUBLIC;


--
-- TOC entry 5843 (class 0 OID 0)
-- Dependencies: 15
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2025-12-01 19:28:36

--
-- PostgreSQL database dump complete
--

\unrestrict MwB48jUO0Bn9YIAt0YBaQz2uBSE7IDu4WUKTxmWnv8flXInYpGLPOXuzYJ22VTI

