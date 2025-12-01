--
-- PostgreSQL database dump
--

\restrict kSLsx13fBNdNcWQWgGFClrWpKE195gR8judOwgqJviNoLW2g11mzNJTjJ3Tahpa

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2025-12-01 19:29:30

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
-- TOC entry 5770 (class 0 OID 0)
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
-- TOC entry 5772 (class 0 OID 0)
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
-- TOC entry 5774 (class 0 OID 0)
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
-- TOC entry 5771 (class 0 OID 0)
-- Dependencies: 14
-- Name: SCHEMA identity; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA identity FROM pg_database_owner;
REVOKE USAGE ON SCHEMA identity FROM PUBLIC;
GRANT ALL ON SCHEMA identity TO postgres;
GRANT USAGE ON SCHEMA identity TO PUBLIC;


--
-- TOC entry 5773 (class 0 OID 0)
-- Dependencies: 15
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2025-12-01 19:29:31

--
-- PostgreSQL database dump complete
--

\unrestrict kSLsx13fBNdNcWQWgGFClrWpKE195gR8judOwgqJviNoLW2g11mzNJTjJ3Tahpa

