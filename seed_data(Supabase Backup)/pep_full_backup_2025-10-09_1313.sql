--
-- PostgreSQL database dump
--

\restrict 4McNB2baXDF1EoWjacDYR10hCIHA0PZcrjSysIqWCa7Qeka8ZvpVPkWhKsGBADf

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.6 (Ubuntu 17.6-2.pgdg22.04+1)

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
-- Name: auth; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA auth;


--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA extensions;


--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA graphql;


--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA graphql_public;


--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA pgbouncer;


--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA realtime;


--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA storage;


--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA vault;


--
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


--
-- Name: oauth_registration_type; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.oauth_registration_type AS ENUM (
    'dynamic',
    'manual'
);


--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


--
-- Name: access_level; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.access_level AS ENUM (
    'super',
    'standard',
    'limited'
);


--
-- Name: assessment_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.assessment_type AS ENUM (
    'Teacher',
    'SHL',
    'Self',
    'Peer',
    'System'
);


--
-- Name: component_category; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.component_category AS ENUM (
    'SHL',
    'Professional',
    'Physical',
    'Mental',
    'Social',
    'Conduct',
    'Academic'
);


--
-- Name: email_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.email_status AS ENUM (
    'Queued',
    'Sent',
    'Failed',
    'Bounced',
    'Delivered'
);


--
-- Name: email_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.email_type AS ENUM (
    'Welcome',
    'Score Update',
    'Notification',
    'Report',
    'System',
    'Intervention',
    'Reminder'
);


--
-- Name: enrollment_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.enrollment_status AS ENUM (
    'Enrolled',
    'Completed',
    'Dropped',
    'Transferred'
);


--
-- Name: enrollment_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.enrollment_type AS ENUM (
    'Mandatory',
    'Optional'
);


--
-- Name: feedback_category; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.feedback_category AS ENUM (
    'General',
    'Academic',
    'Technical',
    'Wellness',
    'Behavior'
);


--
-- Name: feedback_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.feedback_status AS ENUM (
    'Submitted',
    'In Progress',
    'Resolved',
    'Closed'
);


--
-- Name: gender_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.gender_type AS ENUM (
    'Male',
    'Female',
    'Other'
);


--
-- Name: grade_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.grade_type AS ENUM (
    'A+',
    'A',
    'B',
    'C',
    'D',
    'E',
    'IC'
);


--
-- Name: import_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.import_status AS ENUM (
    'Pending',
    'Processing',
    'Completed',
    'Failed',
    'Cancelled'
);


--
-- Name: import_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.import_type AS ENUM (
    'Students',
    'Scores',
    'Attendance',
    'Teachers',
    'Interventions'
);


--
-- Name: intervention_enrollment_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.intervention_enrollment_status AS ENUM (
    'Enrolled',
    'Pending',
    'Dropped',
    'Completed'
);


--
-- Name: intervention_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.intervention_status AS ENUM (
    'Draft',
    'Active',
    'Completed',
    'Archived',
    'Cancelled'
);


--
-- Name: notification_category; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.notification_category AS ENUM (
    'Score',
    'Attendance',
    'Assignment',
    'System',
    'Announcement'
);


--
-- Name: notification_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.notification_type AS ENUM (
    'Info',
    'Success',
    'Warning',
    'Error',
    'System'
);


--
-- Name: priority_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.priority_type AS ENUM (
    'Low',
    'Medium',
    'High'
);


--
-- Name: score_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.score_status AS ENUM (
    'Draft',
    'Submitted',
    'Approved',
    'Rejected'
);


--
-- Name: status_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.status_type AS ENUM (
    'Good',
    'Progress',
    'Deteriorate',
    'Cleared',
    'Not Cleared',
    'Attendance Shortage'
);


--
-- Name: student_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.student_status AS ENUM (
    'Active',
    'Inactive',
    'Graduated',
    'Dropped'
);


--
-- Name: submission_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.submission_status AS ENUM (
    'Submitted',
    'Graded',
    'Returned',
    'Late'
);


--
-- Name: submission_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.submission_type AS ENUM (
    'Document',
    'Presentation',
    'Video',
    'Link',
    'Text',
    'Direct_Assessment'
);


--
-- Name: sync_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.sync_status AS ENUM (
    'Success',
    'Failed',
    'Partial',
    'Pending'
);


--
-- Name: task_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.task_status AS ENUM (
    'Draft',
    'Active',
    'Completed',
    'Archived'
);


--
-- Name: teacher_role; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.teacher_role AS ENUM (
    'Lead',
    'Assistant'
);


--
-- Name: upload_purpose; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.upload_purpose AS ENUM (
    'Profile Picture',
    'Document',
    'Assignment',
    'Report',
    'System',
    'Other'
);


--
-- Name: user_role; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.user_role AS ENUM (
    'student',
    'teacher',
    'admin'
);


--
-- Name: user_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.user_status AS ENUM (
    'active',
    'inactive',
    'suspended'
);


--
-- Name: action; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


--
-- Name: buckettype; Type: TYPE; Schema: storage; Owner: -
--

CREATE TYPE storage.buckettype AS ENUM (
    'STANDARD',
    'ANALYTICS'
);


--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: -
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


--
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: -
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: -
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


--
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: -
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


--
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


--
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: -
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


--
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: -
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    IF EXISTS (
      SELECT FROM pg_extension
      WHERE extname = 'pg_net'
      -- all versions in use on existing projects as of 2025-02-20
      -- version 0.12.0 onwards don't need these applied
      AND extversion IN ('0.2', '0.6', '0.7', '0.7.1', '0.8', '0.10.0', '0.11.0')
    ) THEN
      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

      REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
      REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

      GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
      GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    END IF;
  END IF;
END;
$$;


--
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: -
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


--
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


--
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


--
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: -
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: -
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $_$
begin
    raise debug 'PgBouncer auth request: %', p_usename;

    return query
    select 
        rolname::text, 
        case when rolvaliduntil < now() 
            then null 
            else rolpassword::text 
        end 
    from pg_authid 
    where rolname=$1 and rolcanlogin;
end;
$_$;


--
-- Name: audit_weightage_changes(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.audit_weightage_changes() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    entity_id_value TEXT;
    audit_user_id UUID;
BEGIN
    -- Get a valid user ID for audit purposes
    SELECT id INTO audit_user_id 
    FROM users 
    WHERE role = 'admin' 
    ORDER BY created_at 
    LIMIT 1;
    
    -- If no admin user found, skip audit (shouldn't happen in production)
    IF audit_user_id IS NULL THEN
        IF TG_OP = 'DELETE' THEN
            RETURN OLD;
        ELSE
            RETURN NEW;
        END IF;
    END IF;

    -- Determine the entity ID based on the table
    IF TG_TABLE_NAME = 'batch_term_quadrant_weightages' THEN
        entity_id_value := CASE 
            WHEN TG_OP = 'DELETE' THEN OLD.quadrant_id::TEXT
            ELSE NEW.quadrant_id::TEXT
        END;
    ELSIF TG_TABLE_NAME = 'batch_term_subcategory_weightages' THEN
        entity_id_value := CASE 
            WHEN TG_OP = 'DELETE' THEN OLD.subcategory_id::TEXT
            ELSE NEW.subcategory_id::TEXT
        END;
    ELSIF TG_TABLE_NAME = 'batch_term_component_weightages' THEN
        entity_id_value := CASE 
            WHEN TG_OP = 'DELETE' THEN OLD.component_id::TEXT
            ELSE NEW.component_id::TEXT
        END;
    ELSIF TG_TABLE_NAME = 'batch_term_microcompetency_weightages' THEN
        entity_id_value := CASE 
            WHEN TG_OP = 'DELETE' THEN OLD.microcompetency_id::TEXT
            ELSE NEW.microcompetency_id::TEXT
        END;
    END IF;

    IF TG_OP = 'INSERT' THEN
        INSERT INTO weightage_change_audit (
            config_id, change_type, entity_type, entity_id, 
            new_weightage, changed_by, change_context
        ) VALUES (
            NEW.config_id, 'create', 
            CASE TG_TABLE_NAME
                WHEN 'batch_term_quadrant_weightages' THEN 'quadrant'
                WHEN 'batch_term_subcategory_weightages' THEN 'subcategory'
                WHEN 'batch_term_component_weightages' THEN 'component'
                WHEN 'batch_term_microcompetency_weightages' THEN 'microcompetency'
            END,
            entity_id_value,
            NEW.weightage, 
            COALESCE(
                current_setting('app.current_user_id', true)::UUID, 
                audit_user_id
            ),
            jsonb_build_object('table', TG_TABLE_NAME, 'operation', TG_OP, 'migration', true)
        );
        RETURN NEW;
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO weightage_change_audit (
            config_id, change_type, entity_type, entity_id, 
            old_weightage, new_weightage, changed_by, change_context
        ) VALUES (
            NEW.config_id, 'update',
            CASE TG_TABLE_NAME
                WHEN 'batch_term_quadrant_weightages' THEN 'quadrant'
                WHEN 'batch_term_subcategory_weightages' THEN 'subcategory'
                WHEN 'batch_term_component_weightages' THEN 'component'
                WHEN 'batch_term_microcompetency_weightages' THEN 'microcompetency'
            END,
            entity_id_value,
            OLD.weightage, NEW.weightage,
            COALESCE(
                current_setting('app.current_user_id', true)::UUID, 
                audit_user_id
            ),
            jsonb_build_object('table', TG_TABLE_NAME, 'operation', TG_OP)
        );
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO weightage_change_audit (
            config_id, change_type, entity_type, entity_id, 
            old_weightage, changed_by, change_context
        ) VALUES (
            OLD.config_id, 'delete',
            CASE TG_TABLE_NAME
                WHEN 'batch_term_quadrant_weightages' THEN 'quadrant'
                WHEN 'batch_term_subcategory_weightages' THEN 'subcategory'
                WHEN 'batch_term_component_weightages' THEN 'component'
                WHEN 'batch_term_microcompetency_weightages' THEN 'microcompetency'
            END,
            entity_id_value,
            OLD.weightage,
            COALESCE(
                current_setting('app.current_user_id', true)::UUID, 
                audit_user_id
            ),
            jsonb_build_object('table', TG_TABLE_NAME, 'operation', TG_OP)
        );
        RETURN OLD;
    END IF;
    RETURN NULL;
END;
$$;


--
-- Name: calculate_grade(numeric); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.calculate_grade(score numeric) RETURNS character varying
    LANGUAGE plpgsql
    AS $$ BEGIN CASE WHEN score >= 80 THEN RETURN 'A+'; WHEN score >= 66 THEN RETURN 'A'; WHEN score >= 50 THEN RETURN 'B'; WHEN score >= 34 THEN RETURN 'C'; WHEN score > 0 THEN RETURN 'D'; ELSE RETURN 'E'; END CASE; END; $$;


--
-- Name: calculate_grade_from_percentage(numeric); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.calculate_grade_from_percentage(percentage numeric) RETURNS character varying
    LANGUAGE plpgsql
    AS $$ BEGIN CASE WHEN percentage >= 80 THEN RETURN 'A+'; WHEN percentage >= 66 THEN RETURN 'A'; WHEN percentage >= 50 THEN RETURN 'B'; WHEN percentage >= 34 THEN RETURN 'C'; WHEN percentage > 0 THEN RETURN 'D'; ELSE RETURN 'E'; END CASE; END; $$;


--
-- Name: calculate_microcompetency_score_from_task(numeric, numeric, numeric, numeric); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.calculate_microcompetency_score_from_task(p_task_score numeric, p_task_max_score numeric, p_microcompetency_weightage numeric, p_microcompetency_max_score numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Calculate weighted score for microcompetency
    -- Formula: (task_score / task_max_score) * (weightage / 100) * microcompetency_max_score
    RETURN (p_task_score / p_task_max_score) * (p_microcompetency_weightage / 100.0) * p_microcompetency_max_score;
END;
$$;


--
-- Name: copy_default_component_weightages(uuid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.copy_default_component_weightages(p_config_id uuid) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO batch_term_component_weightages (
        config_id, component_id, weightage, max_score, minimum_score
    )
    SELECT
        p_config_id, id, weightage, max_score, minimum_score
    FROM components
    WHERE is_active = true;
END;
$$;


--
-- Name: copy_default_microcompetency_weightages(uuid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.copy_default_microcompetency_weightages(p_config_id uuid) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO batch_term_microcompetency_weightages (
        config_id, microcompetency_id, weightage, max_score
    )
    SELECT
        p_config_id, id, weightage, max_score
    FROM microcompetencies
    WHERE is_active = true;
END;
$$;


--
-- Name: copy_default_quadrant_weightages(uuid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.copy_default_quadrant_weightages(p_config_id uuid) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO batch_term_quadrant_weightages (
        config_id, quadrant_id, weightage, minimum_attendance, business_rules
    )
    SELECT
        p_config_id, id, weightage, minimum_attendance, business_rules
    FROM quadrants
    WHERE is_active = true;
END;
$$;


--
-- Name: copy_default_subcategory_weightages(uuid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.copy_default_subcategory_weightages(p_config_id uuid) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO batch_term_subcategory_weightages (
        config_id, subcategory_id, weightage
    )
    SELECT
        p_config_id, id, weightage
    FROM sub_categories
    WHERE is_active = true;
END;
$$;


--
-- Name: copy_weightage_configuration(uuid, uuid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.copy_weightage_configuration(p_source_config_id uuid, p_target_config_id uuid) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Copy quadrant weightages
    INSERT INTO batch_term_quadrant_weightages (
        config_id, quadrant_id, weightage, minimum_attendance, business_rules
    )
    SELECT
        p_target_config_id, quadrant_id, weightage, minimum_attendance, business_rules
    FROM batch_term_quadrant_weightages
    WHERE config_id = p_source_config_id;

    -- Copy subcategory weightages
    INSERT INTO batch_term_subcategory_weightages (
        config_id, subcategory_id, weightage
    )
    SELECT
        p_target_config_id, subcategory_id, weightage
    FROM batch_term_subcategory_weightages
    WHERE config_id = p_source_config_id;

    -- Copy component weightages
    INSERT INTO batch_term_component_weightages (
        config_id, component_id, weightage, max_score, minimum_score
    )
    SELECT
        p_target_config_id, component_id, weightage, max_score, minimum_score
    FROM batch_term_component_weightages
    WHERE config_id = p_source_config_id;

    -- Copy microcompetency weightages
    INSERT INTO batch_term_microcompetency_weightages (
        config_id, microcompetency_id, weightage, max_score
    )
    SELECT
        p_target_config_id, microcompetency_id, weightage, max_score
    FROM batch_term_microcompetency_weightages
    WHERE config_id = p_source_config_id;
END;
$$;


--
-- Name: get_batch_term_weightage_config(uuid, uuid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.get_batch_term_weightage_config(p_batch_id uuid, p_term_id uuid) RETURNS uuid
    LANGUAGE plpgsql
    AS $$
DECLARE
    config_id UUID;
BEGIN
    SELECT id INTO config_id
    FROM batch_term_weightage_config
    WHERE batch_id = p_batch_id
      AND term_id = p_term_id
      AND is_active = true
    LIMIT 1;

    RETURN config_id;
END;
$$;


--
-- Name: FUNCTION get_batch_term_weightage_config(p_batch_id uuid, p_term_id uuid); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION public.get_batch_term_weightage_config(p_batch_id uuid, p_term_id uuid) IS 'Get active weightage configuration ID for a batch-term combination';


--
-- Name: get_quadrant_weightage(uuid, uuid, character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.get_quadrant_weightage(p_batch_id uuid, p_term_id uuid, p_quadrant_id character varying) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
DECLARE
    config_id UUID;
    weightage_value DECIMAL(5,2);
BEGIN
    -- Get the active configuration
    config_id := get_batch_term_weightage_config(p_batch_id, p_term_id);

    IF config_id IS NOT NULL THEN
        -- Get term-batch specific weightage
        SELECT weightage INTO weightage_value
        FROM batch_term_quadrant_weightages
        WHERE config_id = config_id AND quadrant_id = p_quadrant_id;

        IF weightage_value IS NOT NULL THEN
            RETURN weightage_value;
        END IF;
    END IF;

    -- Fallback to default quadrant weightage
    SELECT weightage INTO weightage_value
    FROM quadrants
    WHERE id = p_quadrant_id AND is_active = true;

    RETURN COALESCE(weightage_value, 0);
END;
$$;


--
-- Name: FUNCTION get_quadrant_weightage(p_batch_id uuid, p_term_id uuid, p_quadrant_id character varying); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION public.get_quadrant_weightage(p_batch_id uuid, p_term_id uuid, p_quadrant_id character varying) IS 'Get quadrant weightage with fallback to default';


--
-- Name: get_weightage_summary(uuid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.get_weightage_summary(p_config_id uuid) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    summary JSONB := '{}';
    quadrant_data JSONB;
    subcategory_data JSONB;
    component_data JSONB;
    microcompetency_data JSONB;
BEGIN
    -- Get quadrant weightages
    SELECT jsonb_agg(
        jsonb_build_object(
            'quadrant_id', btqw.quadrant_id,
            'quadrant_name', q.name,
            'weightage', btqw.weightage,
            'minimum_attendance', btqw.minimum_attendance
        )
    ) INTO quadrant_data
    FROM batch_term_quadrant_weightages btqw
    JOIN quadrants q ON btqw.quadrant_id = q.id
    WHERE btqw.config_id = p_config_id;

    -- Get subcategory weightages
    SELECT jsonb_agg(
        jsonb_build_object(
            'subcategory_id', btscw.subcategory_id,
            'subcategory_name', sc.name,
            'quadrant_id', sc.quadrant_id,
            'weightage', btscw.weightage
        )
    ) INTO subcategory_data
    FROM batch_term_subcategory_weightages btscw
    JOIN sub_categories sc ON btscw.subcategory_id = sc.id
    WHERE btscw.config_id = p_config_id;

    -- Get component weightages
    SELECT jsonb_agg(
        jsonb_build_object(
            'component_id', btcw.component_id,
            'component_name', c.name,
            'subcategory_id', c.sub_category_id,
            'weightage', btcw.weightage,
            'max_score', COALESCE(btcw.max_score, c.max_score),
            'minimum_score', COALESCE(btcw.minimum_score, c.minimum_score)
        )
    ) INTO component_data
    FROM batch_term_component_weightages btcw
    JOIN components c ON btcw.component_id = c.id
    WHERE btcw.config_id = p_config_id;

    -- Get microcompetency weightages
    SELECT jsonb_agg(
        jsonb_build_object(
            'microcompetency_id', btmw.microcompetency_id,
            'microcompetency_name', m.name,
            'component_id', m.component_id,
            'weightage', btmw.weightage,
            'max_score', COALESCE(btmw.max_score, m.max_score)
        )
    ) INTO microcompetency_data
    FROM batch_term_microcompetency_weightages btmw
    JOIN microcompetencies m ON btmw.microcompetency_id = m.id
    WHERE btmw.config_id = p_config_id;

    -- Build summary
    summary := jsonb_build_object(
        'config_id', p_config_id,
        'quadrants', COALESCE(quadrant_data, '[]'::jsonb),
        'subcategories', COALESCE(subcategory_data, '[]'::jsonb),
        'components', COALESCE(component_data, '[]'::jsonb),
        'microcompetencies', COALESCE(microcompetency_data, '[]'::jsonb)
    );

    RETURN summary;
END;
$$;


--
-- Name: handle_user_role_change(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.handle_user_role_change() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    current_term_uuid UUID;
BEGIN
    -- Only proceed if role has actually changed
    IF OLD.role = NEW.role THEN
        RETURN NEW;
    END IF;

    -- Log the role change
    RAISE NOTICE 'User % role changed from % to %', NEW.id, OLD.role, NEW.role;

    -- Get current term for student assignments
    SELECT id INTO current_term_uuid 
    FROM terms 
    WHERE is_current = true 
    LIMIT 1;

    -- Handle new role requirements
    IF NEW.role = 'student' THEN
        -- Ensure student record exists
        INSERT INTO students (
            user_id,
            registration_no,
            name,
            course,
            status,
            current_term_id
        ) VALUES (
            NEW.id,
            'REG-' || EXTRACT(EPOCH FROM NOW())::bigint,
            COALESCE(NEW.first_name || ' ' || NEW.last_name, NEW.username),
            'PGDM',
            'Active',
            current_term_uuid
        )
        ON CONFLICT (user_id) DO UPDATE SET
            name = COALESCE(NEW.first_name || ' ' || NEW.last_name, NEW.username),
            status = 'Active',
            current_term_id = COALESCE(current_term_uuid, students.current_term_id),
            updated_at = CURRENT_TIMESTAMP;

        RAISE NOTICE 'Student record ensured for user %', NEW.id;

    ELSIF NEW.role = 'teacher' THEN
        -- Ensure teacher record exists
        INSERT INTO teachers (
            user_id,
            employee_id,
            name,
            is_active
        ) VALUES (
            NEW.id,
            'EMP-' || EXTRACT(EPOCH FROM NOW())::bigint,
            COALESCE(NEW.first_name || ' ' || NEW.last_name, NEW.username),
            true
        )
        ON CONFLICT (user_id) DO UPDATE SET
            name = COALESCE(NEW.first_name || ' ' || NEW.last_name, NEW.username),
            is_active = true,
            updated_at = CURRENT_TIMESTAMP;

        RAISE NOTICE 'Teacher record ensured for user %', NEW.id;
    END IF;

    -- Handle old role cleanup
    IF OLD.role = 'teacher' AND NEW.role != 'teacher' THEN
        -- Deactivate teacher record instead of deleting (preserve history)
        UPDATE teachers 
        SET is_active = false, updated_at = CURRENT_TIMESTAMP 
        WHERE user_id = NEW.id;

        RAISE NOTICE 'Teacher record deactivated for user %', NEW.id;
    END IF;

    RETURN NEW;
END;
$$;


--
-- Name: migrate_existing_weightages(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.migrate_existing_weightages() RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    batch_rec RECORD;
    term_rec RECORD;
    config_id UUID;
    admin_user_id UUID;
BEGIN
    -- Get a system admin user for the migration
    SELECT id INTO admin_user_id FROM users WHERE role = 'admin' LIMIT 1;

    IF admin_user_id IS NULL THEN
        RAISE EXCEPTION 'No admin user found for migration';
    END IF;

    -- Create configurations for all active batch-term combinations
    FOR batch_rec IN SELECT id, name FROM batches WHERE is_active = true LOOP
        FOR term_rec IN SELECT id, name FROM terms WHERE is_active = true LOOP

            -- Create configuration
            INSERT INTO batch_term_weightage_config (
                batch_id, term_id, config_name, description,
                is_active, created_by
            ) VALUES (
                batch_rec.id, term_rec.id,
                format('Default Config - %s - %s', batch_rec.name, term_rec.name),
                'Migrated from existing system weightages',
                true, admin_user_id
            ) RETURNING id INTO config_id;

            -- Migrate quadrant weightages
            INSERT INTO batch_term_quadrant_weightages (
                config_id, quadrant_id, weightage, minimum_attendance, business_rules
            )
            SELECT
                config_id, id, weightage, minimum_attendance, business_rules
            FROM quadrants
            WHERE is_active = true;

            -- Migrate subcategory weightages
            INSERT INTO batch_term_subcategory_weightages (
                config_id, subcategory_id, weightage
            )
            SELECT
                config_id, id, weightage
            FROM sub_categories
            WHERE is_active = true;

            -- Migrate component weightages
            INSERT INTO batch_term_component_weightages (
                config_id, component_id, weightage, max_score, minimum_score
            )
            SELECT
                config_id, id, weightage, max_score, minimum_score
            FROM components
            WHERE is_active = true;

            -- Migrate microcompetency weightages
            INSERT INTO batch_term_microcompetency_weightages (
                config_id, microcompetency_id, weightage, max_score
            )
            SELECT
                config_id, id, weightage, max_score
            FROM microcompetencies
            WHERE is_active = true;

        END LOOP;
    END LOOP;

    RAISE NOTICE 'Migration completed successfully';
END;
$$;


--
-- Name: FUNCTION migrate_existing_weightages(); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION public.migrate_existing_weightages() IS 'Migrate existing weightages to new term-batch specific structure';


--
-- Name: recalculate_student_scores(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.recalculate_student_scores() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- This function will be called after microcompetency scores are inserted/updated
    -- It can trigger recalculation of aggregated scores if needed
    
    -- For now, we rely on the views for real-time calculation
    -- In the future, we might want to cache calculated scores for performance
    
    RETURN COALESCE(NEW, OLD);
END;
$$;


--
-- Name: update_enrollment_scores(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_enrollment_scores() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Update intervention enrollment current_score and completion_percentage
    UPDATE intervention_enrollments 
    SET 
        current_score = (
            SELECT COALESCE(sis.average_score, 0)
            FROM student_intervention_scores sis
            WHERE sis.student_id = COALESCE(NEW.student_id, OLD.student_id)
            AND sis.intervention_id = COALESCE(NEW.intervention_id, OLD.intervention_id)
        ),
        completion_percentage = (
            SELECT COALESCE(sis.average_score, 0)
            FROM student_intervention_scores sis
            WHERE sis.student_id = COALESCE(NEW.student_id, OLD.student_id)
            AND sis.intervention_id = COALESCE(NEW.intervention_id, OLD.intervention_id)
        )
    WHERE student_id = COALESCE(NEW.student_id, OLD.student_id)
    AND intervention_id = COALESCE(NEW.intervention_id, OLD.intervention_id);
    
    RETURN COALESCE(NEW, OLD);
END;
$$;


--
-- Name: update_student_overall_score(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_student_overall_score() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Update the student's overall score based on weighted quadrant scores
    UPDATE students 
    SET overall_score = (
        SELECT COALESCE(
            CASE 
                WHEN COUNT(sqs.average_score) > 0 THEN
                    ROUND(
                        AVG(sqs.average_score * sqs.weightage / 100), 2
                    )
                ELSE 0
            END, 0
        )
        FROM student_quadrant_scores sqs
        WHERE sqs.student_id = COALESCE(NEW.student_id, OLD.student_id)
    ),
    updated_at = CURRENT_TIMESTAMP
    WHERE id = COALESCE(NEW.student_id, OLD.student_id);
    
    RETURN COALESCE(NEW, OLD);
END;
$$;


--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;


--
-- Name: validate_weightage_totals(uuid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.validate_weightage_totals(p_config_id uuid) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    quadrant_total DECIMAL(5,2);
    subcategory_totals JSONB := '{}';
    component_totals JSONB := '{}';
    microcompetency_totals JSONB := '{}';
    validation_result JSONB := '{"valid": true, "errors": []}';
    rec RECORD;
BEGIN
    -- Check quadrant weightages total to 100%
    SELECT COALESCE(SUM(weightage), 0) INTO quadrant_total
    FROM batch_term_quadrant_weightages
    WHERE config_id = p_config_id;

    IF quadrant_total != 100 THEN
        validation_result := jsonb_set(validation_result, '{valid}', 'false');
        validation_result := jsonb_set(validation_result, '{errors}',
            validation_result->'errors' || jsonb_build_array(
                format('Quadrant weightages total %.2f%%, should be 100%%', quadrant_total)
            )
        );
    END IF;

    -- Check subcategory weightages within each quadrant
    FOR rec IN
        SELECT sc.quadrant_id, COALESCE(SUM(btscw.weightage), 0) as total_weightage
        FROM sub_categories sc
        LEFT JOIN batch_term_subcategory_weightages btscw ON sc.id = btscw.subcategory_id AND btscw.config_id = p_config_id
        GROUP BY sc.quadrant_id
    LOOP
        IF rec.total_weightage > 0 AND rec.total_weightage != 100 THEN
            validation_result := jsonb_set(validation_result, '{valid}', 'false');
            validation_result := jsonb_set(validation_result, '{errors}',
                validation_result->'errors' || jsonb_build_array(
                    format('Subcategory weightages in quadrant %s total %.2f%%, should be 100%%',
                           rec.quadrant_id, rec.total_weightage)
                )
            );
        END IF;
    END LOOP;

    RETURN validation_result;
END;
$$;


--
-- Name: FUNCTION validate_weightage_totals(p_config_id uuid); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION public.validate_weightage_totals(p_config_id uuid) IS 'Validate that weightages sum to 100% at each level';


--
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_;

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;


--
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


--
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


--
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    declare
      res jsonb;
    begin
      execute format('select to_jsonb(%L::'|| type_::text || ')', val)  into res;
      return res;
    end
    $$;


--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


--
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


--
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS SETOF realtime.wal_rls
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
      with pub as (
        select
          concat_ws(
            ',',
            case when bool_or(pubinsert) then 'insert' else null end,
            case when bool_or(pubupdate) then 'update' else null end,
            case when bool_or(pubdelete) then 'delete' else null end
          ) as w2j_actions,
          coalesce(
            string_agg(
              realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
              ','
            ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
            ''
          ) w2j_add_tables
        from
          pg_publication pp
          left join pg_publication_tables ppt
            on pp.pubname = ppt.pubname
        where
          pp.pubname = publication
        group by
          pp.pubname
        limit 1
      ),
      w2j as (
        select
          x.*, pub.w2j_add_tables
        from
          pub,
          pg_logical_slot_get_changes(
            slot_name, null, max_changes,
            'include-pk', 'true',
            'include-transaction', 'false',
            'include-timestamp', 'true',
            'include-type-oids', 'true',
            'format-version', '2',
            'actions', pub.w2j_actions,
            'add-tables', pub.w2j_add_tables
          ) x
      )
      select
        xyz.wal,
        xyz.is_rls_enabled,
        xyz.subscription_ids,
        xyz.errors
      from
        w2j,
        realtime.apply_rls(
          wal := w2j.data::jsonb,
          max_record_bytes := max_record_bytes
        ) xyz(wal, is_rls_enabled, subscription_ids, errors)
      where
        w2j.w2j_add_tables <> ''
        and xyz.subscription_ids[1] is not null
    $$;


--
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


--
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  BEGIN
    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    -- Attempt to insert the message
    INSERT INTO realtime.messages (payload, event, topic, private, extension)
    VALUES (payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      RAISE WARNING 'ErrorSendingBroadcastMessage: %', SQLERRM;
  END;
END;
$$;


--
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


--
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


--
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


--
-- Name: add_prefixes(text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.add_prefixes(_bucket_id text, _name text) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    prefixes text[];
BEGIN
    prefixes := "storage"."get_prefixes"("_name");

    IF array_length(prefixes, 1) > 0 THEN
        INSERT INTO storage.prefixes (name, bucket_id)
        SELECT UNNEST(prefixes) as name, "_bucket_id" ON CONFLICT DO NOTHING;
    END IF;
END;
$$;


--
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


--
-- Name: delete_leaf_prefixes(text[], text[]); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.delete_leaf_prefixes(bucket_ids text[], names text[]) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_rows_deleted integer;
BEGIN
    LOOP
        WITH candidates AS (
            SELECT DISTINCT
                t.bucket_id,
                unnest(storage.get_prefixes(t.name)) AS name
            FROM unnest(bucket_ids, names) AS t(bucket_id, name)
        ),
        uniq AS (
             SELECT
                 bucket_id,
                 name,
                 storage.get_level(name) AS level
             FROM candidates
             WHERE name <> ''
             GROUP BY bucket_id, name
        ),
        leaf AS (
             SELECT
                 p.bucket_id,
                 p.name,
                 p.level
             FROM storage.prefixes AS p
                  JOIN uniq AS u
                       ON u.bucket_id = p.bucket_id
                           AND u.name = p.name
                           AND u.level = p.level
             WHERE NOT EXISTS (
                 SELECT 1
                 FROM storage.objects AS o
                 WHERE o.bucket_id = p.bucket_id
                   AND o.level = p.level + 1
                   AND o.name COLLATE "C" LIKE p.name || '/%'
             )
             AND NOT EXISTS (
                 SELECT 1
                 FROM storage.prefixes AS c
                 WHERE c.bucket_id = p.bucket_id
                   AND c.level = p.level + 1
                   AND c.name COLLATE "C" LIKE p.name || '/%'
             )
        )
        DELETE
        FROM storage.prefixes AS p
            USING leaf AS l
        WHERE p.bucket_id = l.bucket_id
          AND p.name = l.name
          AND p.level = l.level;

        GET DIAGNOSTICS v_rows_deleted = ROW_COUNT;
        EXIT WHEN v_rows_deleted = 0;
    END LOOP;
END;
$$;


--
-- Name: delete_prefix(text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.delete_prefix(_bucket_id text, _name text) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    -- Check if we can delete the prefix
    IF EXISTS(
        SELECT FROM "storage"."prefixes"
        WHERE "prefixes"."bucket_id" = "_bucket_id"
          AND level = "storage"."get_level"("_name") + 1
          AND "prefixes"."name" COLLATE "C" LIKE "_name" || '/%'
        LIMIT 1
    )
    OR EXISTS(
        SELECT FROM "storage"."objects"
        WHERE "objects"."bucket_id" = "_bucket_id"
          AND "storage"."get_level"("objects"."name") = "storage"."get_level"("_name") + 1
          AND "objects"."name" COLLATE "C" LIKE "_name" || '/%'
        LIMIT 1
    ) THEN
    -- There are sub-objects, skip deletion
    RETURN false;
    ELSE
        DELETE FROM "storage"."prefixes"
        WHERE "prefixes"."bucket_id" = "_bucket_id"
          AND level = "storage"."get_level"("_name")
          AND "prefixes"."name" = "_name";
        RETURN true;
    END IF;
END;
$$;


--
-- Name: delete_prefix_hierarchy_trigger(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.delete_prefix_hierarchy_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    prefix text;
BEGIN
    prefix := "storage"."get_prefix"(OLD."name");

    IF coalesce(prefix, '') != '' THEN
        PERFORM "storage"."delete_prefix"(OLD."bucket_id", prefix);
    END IF;

    RETURN OLD;
END;
$$;


--
-- Name: enforce_bucket_name_length(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.enforce_bucket_name_length() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
    if length(new.name) > 100 then
        raise exception 'bucket name "%" is too long (% characters). Max is 100.', new.name, length(new.name);
    end if;
    return new;
end;
$$;


--
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
    _filename text;
BEGIN
    SELECT string_to_array(name, '/') INTO _parts;
    SELECT _parts[array_length(_parts,1)] INTO _filename;
    RETURN reverse(split_part(reverse(_filename), '.', 1));
END
$$;


--
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


--
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
BEGIN
    -- Split on "/" to get path segments
    SELECT string_to_array(name, '/') INTO _parts;
    -- Return everything except the last segment
    RETURN _parts[1 : array_length(_parts,1) - 1];
END
$$;


--
-- Name: get_level(text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.get_level(name text) RETURNS integer
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
SELECT array_length(string_to_array("name", '/'), 1);
$$;


--
-- Name: get_prefix(text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.get_prefix(name text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
SELECT
    CASE WHEN strpos("name", '/') > 0 THEN
             regexp_replace("name", '[\/]{1}[^\/]+\/?$', '')
         ELSE
             ''
        END;
$_$;


--
-- Name: get_prefixes(text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.get_prefixes(name text) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
DECLARE
    parts text[];
    prefixes text[];
    prefix text;
BEGIN
    -- Split the name into parts by '/'
    parts := string_to_array("name", '/');
    prefixes := '{}';

    -- Construct the prefixes, stopping one level below the last part
    FOR i IN 1..array_length(parts, 1) - 1 LOOP
            prefix := array_to_string(parts[1:i], '/');
            prefixes := array_append(prefixes, prefix);
    END LOOP;

    RETURN prefixes;
END;
$$;


--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::bigint) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


--
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


--
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(name COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                        substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1)))
                    ELSE
                        name
                END AS name, id, metadata, updated_at
            FROM
                storage.objects
            WHERE
                bucket_id = $5 AND
                name ILIKE $1 || ''%'' AND
                CASE
                    WHEN $6 != '''' THEN
                    name COLLATE "C" > $6
                ELSE true END
                AND CASE
                    WHEN $4 != '''' THEN
                        CASE
                            WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                                substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                name COLLATE "C" > $4
                            END
                    ELSE
                        true
                END
            ORDER BY
                name COLLATE "C" ASC) as e order by name COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_token, bucket_id, start_after;
END;
$_$;


--
-- Name: lock_top_prefixes(text[], text[]); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.lock_top_prefixes(bucket_ids text[], names text[]) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_bucket text;
    v_top text;
BEGIN
    FOR v_bucket, v_top IN
        SELECT DISTINCT t.bucket_id,
            split_part(t.name, '/', 1) AS top
        FROM unnest(bucket_ids, names) AS t(bucket_id, name)
        WHERE t.name <> ''
        ORDER BY 1, 2
        LOOP
            PERFORM pg_advisory_xact_lock(hashtextextended(v_bucket || '/' || v_top, 0));
        END LOOP;
END;
$$;


--
-- Name: objects_delete_cleanup(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.objects_delete_cleanup() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_bucket_ids text[];
    v_names      text[];
BEGIN
    IF current_setting('storage.gc.prefixes', true) = '1' THEN
        RETURN NULL;
    END IF;

    PERFORM set_config('storage.gc.prefixes', '1', true);

    SELECT COALESCE(array_agg(d.bucket_id), '{}'),
           COALESCE(array_agg(d.name), '{}')
    INTO v_bucket_ids, v_names
    FROM deleted AS d
    WHERE d.name <> '';

    PERFORM storage.lock_top_prefixes(v_bucket_ids, v_names);
    PERFORM storage.delete_leaf_prefixes(v_bucket_ids, v_names);

    RETURN NULL;
END;
$$;


--
-- Name: objects_insert_prefix_trigger(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.objects_insert_prefix_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    NEW.level := "storage"."get_level"(NEW."name");

    RETURN NEW;
END;
$$;


--
-- Name: objects_update_cleanup(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.objects_update_cleanup() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    -- NEW - OLD (destinations to create prefixes for)
    v_add_bucket_ids text[];
    v_add_names      text[];

    -- OLD - NEW (sources to prune)
    v_src_bucket_ids text[];
    v_src_names      text[];
BEGIN
    IF TG_OP <> 'UPDATE' THEN
        RETURN NULL;
    END IF;

    -- 1) Compute NEW−OLD (added paths) and OLD−NEW (moved-away paths)
    WITH added AS (
        SELECT n.bucket_id, n.name
        FROM new_rows n
        WHERE n.name <> '' AND position('/' in n.name) > 0
        EXCEPT
        SELECT o.bucket_id, o.name FROM old_rows o WHERE o.name <> ''
    ),
    moved AS (
         SELECT o.bucket_id, o.name
         FROM old_rows o
         WHERE o.name <> ''
         EXCEPT
         SELECT n.bucket_id, n.name FROM new_rows n WHERE n.name <> ''
    )
    SELECT
        -- arrays for ADDED (dest) in stable order
        COALESCE( (SELECT array_agg(a.bucket_id ORDER BY a.bucket_id, a.name) FROM added a), '{}' ),
        COALESCE( (SELECT array_agg(a.name      ORDER BY a.bucket_id, a.name) FROM added a), '{}' ),
        -- arrays for MOVED (src) in stable order
        COALESCE( (SELECT array_agg(m.bucket_id ORDER BY m.bucket_id, m.name) FROM moved m), '{}' ),
        COALESCE( (SELECT array_agg(m.name      ORDER BY m.bucket_id, m.name) FROM moved m), '{}' )
    INTO v_add_bucket_ids, v_add_names, v_src_bucket_ids, v_src_names;

    -- Nothing to do?
    IF (array_length(v_add_bucket_ids, 1) IS NULL) AND (array_length(v_src_bucket_ids, 1) IS NULL) THEN
        RETURN NULL;
    END IF;

    -- 2) Take per-(bucket, top) locks: ALL prefixes in consistent global order to prevent deadlocks
    DECLARE
        v_all_bucket_ids text[];
        v_all_names text[];
    BEGIN
        -- Combine source and destination arrays for consistent lock ordering
        v_all_bucket_ids := COALESCE(v_src_bucket_ids, '{}') || COALESCE(v_add_bucket_ids, '{}');
        v_all_names := COALESCE(v_src_names, '{}') || COALESCE(v_add_names, '{}');

        -- Single lock call ensures consistent global ordering across all transactions
        IF array_length(v_all_bucket_ids, 1) IS NOT NULL THEN
            PERFORM storage.lock_top_prefixes(v_all_bucket_ids, v_all_names);
        END IF;
    END;

    -- 3) Create destination prefixes (NEW−OLD) BEFORE pruning sources
    IF array_length(v_add_bucket_ids, 1) IS NOT NULL THEN
        WITH candidates AS (
            SELECT DISTINCT t.bucket_id, unnest(storage.get_prefixes(t.name)) AS name
            FROM unnest(v_add_bucket_ids, v_add_names) AS t(bucket_id, name)
            WHERE name <> ''
        )
        INSERT INTO storage.prefixes (bucket_id, name)
        SELECT c.bucket_id, c.name
        FROM candidates c
        ON CONFLICT DO NOTHING;
    END IF;

    -- 4) Prune source prefixes bottom-up for OLD−NEW
    IF array_length(v_src_bucket_ids, 1) IS NOT NULL THEN
        -- re-entrancy guard so DELETE on prefixes won't recurse
        IF current_setting('storage.gc.prefixes', true) <> '1' THEN
            PERFORM set_config('storage.gc.prefixes', '1', true);
        END IF;

        PERFORM storage.delete_leaf_prefixes(v_src_bucket_ids, v_src_names);
    END IF;

    RETURN NULL;
END;
$$;


--
-- Name: objects_update_level_trigger(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.objects_update_level_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Ensure this is an update operation and the name has changed
    IF TG_OP = 'UPDATE' AND (NEW."name" <> OLD."name" OR NEW."bucket_id" <> OLD."bucket_id") THEN
        -- Set the new level
        NEW."level" := "storage"."get_level"(NEW."name");
    END IF;
    RETURN NEW;
END;
$$;


--
-- Name: objects_update_prefix_trigger(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.objects_update_prefix_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    old_prefixes TEXT[];
BEGIN
    -- Ensure this is an update operation and the name has changed
    IF TG_OP = 'UPDATE' AND (NEW."name" <> OLD."name" OR NEW."bucket_id" <> OLD."bucket_id") THEN
        -- Retrieve old prefixes
        old_prefixes := "storage"."get_prefixes"(OLD."name");

        -- Remove old prefixes that are only used by this object
        WITH all_prefixes as (
            SELECT unnest(old_prefixes) as prefix
        ),
        can_delete_prefixes as (
             SELECT prefix
             FROM all_prefixes
             WHERE NOT EXISTS (
                 SELECT 1 FROM "storage"."objects"
                 WHERE "bucket_id" = OLD."bucket_id"
                   AND "name" <> OLD."name"
                   AND "name" LIKE (prefix || '%')
             )
         )
        DELETE FROM "storage"."prefixes" WHERE name IN (SELECT prefix FROM can_delete_prefixes);

        -- Add new prefixes
        PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    END IF;
    -- Set the new level
    NEW."level" := "storage"."get_level"(NEW."name");

    RETURN NEW;
END;
$$;


--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


--
-- Name: prefixes_delete_cleanup(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.prefixes_delete_cleanup() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_bucket_ids text[];
    v_names      text[];
BEGIN
    IF current_setting('storage.gc.prefixes', true) = '1' THEN
        RETURN NULL;
    END IF;

    PERFORM set_config('storage.gc.prefixes', '1', true);

    SELECT COALESCE(array_agg(d.bucket_id), '{}'),
           COALESCE(array_agg(d.name), '{}')
    INTO v_bucket_ids, v_names
    FROM deleted AS d
    WHERE d.name <> '';

    PERFORM storage.lock_top_prefixes(v_bucket_ids, v_names);
    PERFORM storage.delete_leaf_prefixes(v_bucket_ids, v_names);

    RETURN NULL;
END;
$$;


--
-- Name: prefixes_insert_trigger(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.prefixes_insert_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    RETURN NEW;
END;
$$;


--
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql
    AS $$
declare
    can_bypass_rls BOOLEAN;
begin
    SELECT rolbypassrls
    INTO can_bypass_rls
    FROM pg_roles
    WHERE rolname = coalesce(nullif(current_setting('role', true), 'none'), current_user);

    IF can_bypass_rls THEN
        RETURN QUERY SELECT * FROM storage.search_v1_optimised(prefix, bucketname, limits, levels, offsets, search, sortcolumn, sortorder);
    ELSE
        RETURN QUERY SELECT * FROM storage.search_legacy_v1(prefix, bucketname, limits, levels, offsets, search, sortcolumn, sortorder);
    END IF;
end;
$$;


--
-- Name: search_legacy_v1(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.search_legacy_v1(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
    v_order_by text;
    v_sort_order text;
begin
    case
        when sortcolumn = 'name' then
            v_order_by = 'name';
        when sortcolumn = 'updated_at' then
            v_order_by = 'updated_at';
        when sortcolumn = 'created_at' then
            v_order_by = 'created_at';
        when sortcolumn = 'last_accessed_at' then
            v_order_by = 'last_accessed_at';
        else
            v_order_by = 'name';
        end case;

    case
        when sortorder = 'asc' then
            v_sort_order = 'asc';
        when sortorder = 'desc' then
            v_sort_order = 'desc';
        else
            v_sort_order = 'asc';
        end case;

    v_order_by = v_order_by || ' ' || v_sort_order;

    return query execute
        'with folders as (
           select path_tokens[$1] as folder
           from storage.objects
             where objects.name ilike $2 || $3 || ''%''
               and bucket_id = $4
               and array_length(objects.path_tokens, 1) <> $1
           group by folder
           order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


--
-- Name: search_v1_optimised(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.search_v1_optimised(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
    v_order_by text;
    v_sort_order text;
begin
    case
        when sortcolumn = 'name' then
            v_order_by = 'name';
        when sortcolumn = 'updated_at' then
            v_order_by = 'updated_at';
        when sortcolumn = 'created_at' then
            v_order_by = 'created_at';
        when sortcolumn = 'last_accessed_at' then
            v_order_by = 'last_accessed_at';
        else
            v_order_by = 'name';
        end case;

    case
        when sortorder = 'asc' then
            v_sort_order = 'asc';
        when sortorder = 'desc' then
            v_sort_order = 'desc';
        else
            v_sort_order = 'asc';
        end case;

    v_order_by = v_order_by || ' ' || v_sort_order;

    return query execute
        'with folders as (
           select (string_to_array(name, ''/''))[level] as name
           from storage.prefixes
             where lower(prefixes.name) like lower($2 || $3) || ''%''
               and bucket_id = $4
               and level = $1
           order by name ' || v_sort_order || '
     )
     (select name,
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[level] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where lower(objects.name) like lower($2 || $3) || ''%''
       and bucket_id = $4
       and level = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


--
-- Name: search_v2(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer DEFAULT 100, levels integer DEFAULT 1, start_after text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text, sort_column text DEFAULT 'name'::text, sort_column_after text DEFAULT ''::text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    sort_col text;
    sort_ord text;
    cursor_op text;
    cursor_expr text;
    sort_expr text;
BEGIN
    -- Validate sort_order
    sort_ord := lower(sort_order);
    IF sort_ord NOT IN ('asc', 'desc') THEN
        sort_ord := 'asc';
    END IF;

    -- Determine cursor comparison operator
    IF sort_ord = 'asc' THEN
        cursor_op := '>';
    ELSE
        cursor_op := '<';
    END IF;
    
    sort_col := lower(sort_column);
    -- Validate sort column  
    IF sort_col IN ('updated_at', 'created_at') THEN
        cursor_expr := format(
            '($5 = '''' OR ROW(date_trunc(''milliseconds'', %I), name COLLATE "C") %s ROW(COALESCE(NULLIF($6, '''')::timestamptz, ''epoch''::timestamptz), $5))',
            sort_col, cursor_op
        );
        sort_expr := format(
            'COALESCE(date_trunc(''milliseconds'', %I), ''epoch''::timestamptz) %s, name COLLATE "C" %s',
            sort_col, sort_ord, sort_ord
        );
    ELSE
        cursor_expr := format('($5 = '''' OR name COLLATE "C" %s $5)', cursor_op);
        sort_expr := format('name COLLATE "C" %s', sort_ord);
    END IF;

    RETURN QUERY EXECUTE format(
        $sql$
        SELECT * FROM (
            (
                SELECT
                    split_part(name, '/', $4) AS key,
                    name,
                    NULL::uuid AS id,
                    updated_at,
                    created_at,
                    NULL::timestamptz AS last_accessed_at,
                    NULL::jsonb AS metadata
                FROM storage.prefixes
                WHERE name COLLATE "C" LIKE $1 || '%%'
                    AND bucket_id = $2
                    AND level = $4
                    AND %s
                ORDER BY %s
                LIMIT $3
            )
            UNION ALL
            (
                SELECT
                    split_part(name, '/', $4) AS key,
                    name,
                    id,
                    updated_at,
                    created_at,
                    last_accessed_at,
                    metadata
                FROM storage.objects
                WHERE name COLLATE "C" LIKE $1 || '%%'
                    AND bucket_id = $2
                    AND level = $4
                    AND %s
                ORDER BY %s
                LIMIT $3
            )
        ) obj
        ORDER BY %s
        LIMIT $3
        $sql$,
        cursor_expr,    -- prefixes WHERE
        sort_expr,      -- prefixes ORDER BY
        cursor_expr,    -- objects WHERE
        sort_expr,      -- objects ORDER BY
        sort_expr       -- final ORDER BY
    )
    USING prefix, bucket_name, limits, levels, start_after, sort_column_after;
END;
$_$;


--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


--
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text NOT NULL,
    code_challenge_method auth.code_challenge_method NOT NULL,
    code_challenge text NOT NULL,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone
);


--
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.flow_state IS 'stores metadata for pkce logins';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


--
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


--
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


--
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid
);


--
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- Name: oauth_clients; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.oauth_clients (
    id uuid NOT NULL,
    client_id text NOT NULL,
    client_secret_hash text NOT NULL,
    registration_type auth.oauth_registration_type NOT NULL,
    redirect_uris text NOT NULL,
    grant_types text NOT NULL,
    client_name text,
    client_uri text,
    logo_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    CONSTRAINT oauth_clients_client_name_length CHECK ((char_length(client_name) <= 1024)),
    CONSTRAINT oauth_clients_client_uri_length CHECK ((char_length(client_uri) <= 2048)),
    CONSTRAINT oauth_clients_logo_uri_length CHECK ((char_length(logo_uri) <= 2048))
);


--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


--
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: -
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: -
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


--
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


--
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text
);


--
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


--
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    disabled boolean,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


--
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: admin_audit_log; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_audit_log (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    admin_id uuid NOT NULL,
    action character varying(100) NOT NULL,
    target_user_id uuid,
    old_value jsonb,
    new_value jsonb,
    reason text,
    ip_address inet,
    user_agent text,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: admins; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admins (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    permissions jsonb DEFAULT '[]'::jsonb,
    access_level public.access_level DEFAULT 'standard'::public.access_level,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: attendance; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.attendance (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    student_id uuid NOT NULL,
    term_id uuid NOT NULL,
    quadrant_id character varying(50) NOT NULL,
    attendance_date date NOT NULL,
    is_present boolean NOT NULL,
    reason character varying(255),
    marked_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: attendance_eligibility; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.attendance_eligibility (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    student_id uuid,
    term_id uuid,
    attendance_type character varying(50) NOT NULL,
    component_id uuid,
    total_sessions integer DEFAULT 0,
    attended_sessions integer DEFAULT 0,
    percentage numeric(5,2) DEFAULT 0,
    eligibility_status character varying(20) DEFAULT 'ict'::character varying,
    threshold_required numeric(5,2) DEFAULT 75.00,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


--
-- Name: attendance_summary; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.attendance_summary (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    student_id uuid NOT NULL,
    term_id uuid NOT NULL,
    quadrant_id character varying(50) NOT NULL,
    total_sessions integer DEFAULT 0 NOT NULL,
    attended_sessions integer DEFAULT 0 NOT NULL,
    percentage numeric(5,2) GENERATED ALWAYS AS (
CASE
    WHEN (total_sessions > 0) THEN (((attended_sessions)::numeric / (total_sessions)::numeric) * (100)::numeric)
    ELSE (0)::numeric
END) STORED,
    last_updated timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_attendance_sessions CHECK (((attended_sessions >= 0) AND (attended_sessions <= total_sessions)))
);


--
-- Name: audit_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.audit_logs (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    user_id uuid,
    action character varying(100) NOT NULL,
    entity_type character varying(50) NOT NULL,
    entity_id uuid,
    old_values jsonb,
    new_values jsonb,
    ip_address inet,
    user_agent text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: backup_batches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.backup_batches (
    id uuid,
    name character varying(100),
    year integer,
    start_date date,
    end_date date,
    is_active boolean,
    created_at timestamp without time zone
);


--
-- Name: backup_students; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.backup_students (
    id uuid,
    user_id uuid,
    registration_no character varying(20),
    name character varying(255),
    course character varying(100),
    batch_id uuid,
    section_id uuid,
    house_id uuid,
    gender public.gender_type,
    phone character varying(20),
    preferences jsonb,
    overall_score numeric(5,2),
    grade public.grade_type,
    status public.student_status,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    current_term_id uuid
);


--
-- Name: backup_terms; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.backup_terms (
    id uuid,
    name character varying(100),
    description text,
    start_date date,
    end_date date,
    is_active boolean,
    is_current boolean,
    academic_year character varying(20),
    created_at timestamp without time zone
);


--
-- Name: batch_term_component_weightages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.batch_term_component_weightages (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    config_id uuid NOT NULL,
    component_id uuid NOT NULL,
    weightage numeric(5,2) NOT NULL,
    max_score numeric(5,2) DEFAULT NULL::numeric,
    minimum_score numeric(5,2) DEFAULT NULL::numeric,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    CONSTRAINT batch_term_component_weightages_weightage_check CHECK (((weightage >= (0)::numeric) AND (weightage <= (100)::numeric)))
);


--
-- Name: TABLE batch_term_component_weightages; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.batch_term_component_weightages IS 'Term and batch specific component weightages';


--
-- Name: batch_term_microcompetency_weightages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.batch_term_microcompetency_weightages (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    config_id uuid NOT NULL,
    microcompetency_id uuid NOT NULL,
    weightage numeric(5,2) NOT NULL,
    max_score numeric(5,2) DEFAULT NULL::numeric,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    CONSTRAINT batch_term_microcompetency_weightages_weightage_check CHECK (((weightage >= (0)::numeric) AND (weightage <= (100)::numeric)))
);


--
-- Name: TABLE batch_term_microcompetency_weightages; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.batch_term_microcompetency_weightages IS 'Term and batch specific microcompetency weightages';


--
-- Name: batch_term_progression; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.batch_term_progression (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    batch_id uuid,
    term_id uuid,
    term_number integer NOT NULL,
    status character varying(20) DEFAULT 'upcoming'::character varying,
    start_date date,
    end_date date,
    completion_date date,
    students_enrolled integer DEFAULT 0,
    students_completed integer DEFAULT 0,
    students_failed integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


--
-- Name: batch_term_quadrant_weightages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.batch_term_quadrant_weightages (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    config_id uuid NOT NULL,
    quadrant_id character varying(50) NOT NULL,
    weightage numeric(5,2) NOT NULL,
    minimum_attendance numeric(5,2) DEFAULT 0.00,
    business_rules jsonb DEFAULT '{}'::jsonb,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    CONSTRAINT batch_term_quadrant_weightages_minimum_attendance_check CHECK (((minimum_attendance >= (0)::numeric) AND (minimum_attendance <= (100)::numeric))),
    CONSTRAINT batch_term_quadrant_weightages_weightage_check CHECK (((weightage >= (0)::numeric) AND (weightage <= (100)::numeric)))
);


--
-- Name: TABLE batch_term_quadrant_weightages; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.batch_term_quadrant_weightages IS 'Term and batch specific quadrant weightages';


--
-- Name: batch_term_subcategory_weightages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.batch_term_subcategory_weightages (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    config_id uuid NOT NULL,
    subcategory_id uuid NOT NULL,
    weightage numeric(5,2) NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    CONSTRAINT batch_term_subcategory_weightages_weightage_check CHECK (((weightage >= (0)::numeric) AND (weightage <= (100)::numeric)))
);


--
-- Name: TABLE batch_term_subcategory_weightages; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.batch_term_subcategory_weightages IS 'Term and batch specific subcategory weightages';


--
-- Name: batch_term_weightage_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.batch_term_weightage_config (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    batch_id uuid NOT NULL,
    term_id uuid NOT NULL,
    config_name character varying(255) NOT NULL,
    description text,
    is_active boolean DEFAULT true,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


--
-- Name: TABLE batch_term_weightage_config; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.batch_term_weightage_config IS 'Main configuration table for batch-term specific weightages';


--
-- Name: batches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.batches (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    name character varying(100) NOT NULL,
    year integer NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    current_term_number integer DEFAULT 1,
    max_terms integer DEFAULT 4,
    batch_start_date date DEFAULT CURRENT_DATE,
    expected_graduation_date date,
    batch_status character varying(20) DEFAULT 'active'::character varying
);


--
-- Name: components; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.components (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    sub_category_id uuid NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    weightage numeric(5,2) NOT NULL,
    max_score numeric(5,2) DEFAULT 5.00 NOT NULL,
    minimum_score numeric(5,2) DEFAULT 0.00 NOT NULL,
    category public.component_category NOT NULL,
    display_order integer DEFAULT 0,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_component_scores CHECK (((max_score > (0)::numeric) AND (minimum_score >= (0)::numeric) AND (minimum_score <= max_score))),
    CONSTRAINT chk_component_weightage CHECK (((weightage > (0)::numeric) AND (weightage <= (100)::numeric)))
);


--
-- Name: data_imports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.data_imports (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    import_type public.import_type NOT NULL,
    filename character varying(255) NOT NULL,
    file_path character varying(500) NOT NULL,
    status public.import_status DEFAULT 'Pending'::public.import_status,
    total_records integer DEFAULT 0,
    processed_records integer DEFAULT 0,
    successful_records integer DEFAULT 0,
    failed_records integer DEFAULT 0,
    error_log jsonb DEFAULT '[]'::jsonb,
    processing_log jsonb DEFAULT '[]'::jsonb,
    term_id uuid,
    imported_by uuid NOT NULL,
    started_at timestamp without time zone,
    completed_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_import_records CHECK (((processed_records >= 0) AND (successful_records >= 0) AND (failed_records >= 0) AND (processed_records = (successful_records + failed_records))))
);


--
-- Name: direct_assessments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.direct_assessments (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    task_id uuid NOT NULL,
    student_id uuid NOT NULL,
    score numeric(5,2) NOT NULL,
    feedback text,
    private_notes text,
    assessed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    assessed_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    term_id uuid NOT NULL,
    CONSTRAINT check_score_range CHECK (((score >= (0)::numeric) AND (score <= (100)::numeric))),
    CONSTRAINT chk_direct_assessment_score CHECK ((score >= (0)::numeric))
);


--
-- Name: email_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.email_logs (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    recipient_email character varying(255) NOT NULL,
    recipient_user_id uuid,
    subject character varying(255) NOT NULL,
    email_type public.email_type NOT NULL,
    template_name character varying(100),
    status public.email_status DEFAULT 'Queued'::public.email_status,
    sent_at timestamp without time zone,
    delivered_at timestamp without time zone,
    error_message text,
    metadata jsonb DEFAULT '{}'::jsonb,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: feedback; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.feedback (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    student_id uuid NOT NULL,
    teacher_id uuid,
    subject character varying(255) NOT NULL,
    category public.feedback_category NOT NULL,
    message text NOT NULL,
    priority public.priority_type DEFAULT 'Medium'::public.priority_type,
    status public.feedback_status DEFAULT 'Submitted'::public.feedback_status,
    response text,
    submitted_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    resolved_at timestamp without time zone,
    resolved_by uuid
);


--
-- Name: file_uploads; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.file_uploads (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    original_filename character varying(255) NOT NULL,
    stored_filename character varying(255) NOT NULL,
    file_path character varying(500) NOT NULL,
    file_size bigint NOT NULL,
    mime_type character varying(100) NOT NULL,
    file_hash character varying(64) NOT NULL,
    uploaded_by uuid NOT NULL,
    entity_type character varying(50),
    entity_id uuid,
    is_public boolean DEFAULT false,
    upload_purpose public.upload_purpose DEFAULT 'Other'::public.upload_purpose,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_file_size CHECK ((file_size > 0))
);


--
-- Name: houses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.houses (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    name character varying(50) NOT NULL,
    color character varying(7) NOT NULL,
    description text,
    total_points integer DEFAULT 0,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: hps_calculation_audit; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hps_calculation_audit (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    student_id uuid NOT NULL,
    term_id uuid NOT NULL,
    old_hps numeric(5,2) DEFAULT 0 NOT NULL,
    new_hps numeric(5,2) DEFAULT 0 NOT NULL,
    hps_difference numeric(5,2) DEFAULT 0 NOT NULL,
    percentage_change numeric(5,2) DEFAULT 0 NOT NULL,
    trigger_type character varying(50) NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb,
    calculated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: intervention_enrollments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.intervention_enrollments (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    intervention_id uuid NOT NULL,
    student_id uuid NOT NULL,
    enrollment_date date DEFAULT CURRENT_DATE NOT NULL,
    enrollment_status public.intervention_enrollment_status DEFAULT 'Enrolled'::public.intervention_enrollment_status,
    enrollment_type public.enrollment_type DEFAULT 'Optional'::public.enrollment_type,
    progress_data jsonb DEFAULT '{}'::jsonb,
    current_score numeric(5,2) DEFAULT 0.00,
    completion_percentage numeric(5,2) DEFAULT 0.00,
    enrolled_by uuid NOT NULL,
    enrollment_deadline timestamp without time zone
);


--
-- Name: intervention_microcompetencies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.intervention_microcompetencies (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    intervention_id uuid NOT NULL,
    microcompetency_id uuid NOT NULL,
    weightage numeric(5,2) NOT NULL,
    max_score numeric(5,2) DEFAULT 10.00 NOT NULL,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_intervention_micro_max_score CHECK ((max_score > (0)::numeric)),
    CONSTRAINT chk_intervention_micro_weightage CHECK (((weightage > (0)::numeric) AND (weightage <= (100)::numeric)))
);


--
-- Name: intervention_quadrants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.intervention_quadrants (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    intervention_id uuid NOT NULL,
    quadrant_id character varying(50) NOT NULL,
    weightage numeric(5,2) NOT NULL,
    components jsonb DEFAULT '[]'::jsonb,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_intervention_quadrant_weightage CHECK (((weightage > (0)::numeric) AND (weightage <= (100)::numeric)))
);


--
-- Name: intervention_tasks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.intervention_tasks (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    intervention_id uuid NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    due_date date,
    status character varying(20) DEFAULT 'active'::character varying,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: intervention_teachers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.intervention_teachers (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    intervention_id uuid NOT NULL,
    teacher_id uuid NOT NULL,
    assigned_quadrants jsonb DEFAULT '[]'::jsonb NOT NULL,
    role public.teacher_role DEFAULT 'Assistant'::public.teacher_role,
    permissions jsonb DEFAULT '[]'::jsonb,
    assigned_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    assigned_by uuid NOT NULL,
    is_active boolean DEFAULT true
);


--
-- Name: interventions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.interventions (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    start_date date NOT NULL,
    end_date date NOT NULL,
    status public.intervention_status DEFAULT 'Draft'::public.intervention_status,
    quadrant_weightages jsonb DEFAULT '{}'::jsonb NOT NULL,
    prerequisites jsonb DEFAULT '[]'::jsonb,
    max_students integer DEFAULT 50,
    objectives jsonb DEFAULT '[]'::jsonb,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    term_id uuid,
    scoring_deadline timestamp without time zone,
    total_weightage numeric(5,2) DEFAULT 100.00,
    is_scoring_open boolean DEFAULT false,
    CONSTRAINT chk_intervention_dates CHECK ((end_date > start_date)),
    CONSTRAINT chk_intervention_max_students CHECK ((max_students > 0))
);


--
-- Name: kos_sync_log; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.kos_sync_log (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    sync_type character varying(50) NOT NULL,
    status character varying(20) NOT NULL,
    users_synced integer DEFAULT 0,
    errors_count integer DEFAULT 0,
    error_details jsonb,
    started_at timestamp without time zone NOT NULL,
    completed_at timestamp without time zone,
    triggered_by uuid
);


--
-- Name: microcompetencies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.microcompetencies (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    component_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    weightage numeric(5,2) NOT NULL,
    max_score numeric(5,2) DEFAULT 10.00 NOT NULL,
    display_order integer DEFAULT 0,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_microcompetency_max_score CHECK ((max_score > (0)::numeric)),
    CONSTRAINT chk_microcompetency_weightage CHECK (((weightage > (0)::numeric) AND (weightage <= (100)::numeric)))
);


--
-- Name: microcompetency_scores; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.microcompetency_scores (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    student_id uuid NOT NULL,
    intervention_id uuid NOT NULL,
    microcompetency_id uuid NOT NULL,
    obtained_score numeric(5,2) NOT NULL,
    max_score numeric(5,2) NOT NULL,
    percentage numeric(5,2) GENERATED ALWAYS AS (((obtained_score / max_score) * (100)::numeric)) STORED,
    scored_by uuid NOT NULL,
    scored_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    feedback text,
    status public.score_status DEFAULT 'Submitted'::public.score_status,
    term_id uuid NOT NULL,
    CONSTRAINT check_score_range CHECK (((obtained_score >= (0)::numeric) AND (obtained_score <= max_score))),
    CONSTRAINT chk_microcompetency_score_range CHECK (((obtained_score >= (0)::numeric) AND (obtained_score <= max_score)))
);


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notifications (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    title character varying(255) NOT NULL,
    message text NOT NULL,
    type public.notification_type DEFAULT 'Info'::public.notification_type,
    category public.notification_category NOT NULL,
    is_read boolean DEFAULT false,
    action_url character varying(500),
    metadata jsonb DEFAULT '{}'::jsonb,
    expires_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    read_at timestamp without time zone
);


--
-- Name: quadrants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.quadrants (
    id character varying(50) NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    weightage numeric(5,2) NOT NULL,
    minimum_attendance numeric(5,2) DEFAULT 0.00,
    business_rules jsonb DEFAULT '{}'::jsonb,
    is_active boolean DEFAULT true,
    display_order integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_quadrant_attendance CHECK (((minimum_attendance >= (0)::numeric) AND (minimum_attendance <= (100)::numeric))),
    CONSTRAINT chk_quadrant_weightage CHECK (((weightage > (0)::numeric) AND (weightage <= (100)::numeric)))
);


--
-- Name: scores; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.scores (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    student_id uuid NOT NULL,
    component_id uuid NOT NULL,
    term_id uuid NOT NULL,
    obtained_score numeric(5,2) NOT NULL,
    max_score numeric(5,2) NOT NULL,
    percentage numeric(5,2) GENERATED ALWAYS AS (((obtained_score / max_score) * (100)::numeric)) STORED,
    assessment_date date DEFAULT CURRENT_DATE NOT NULL,
    assessed_by uuid NOT NULL,
    assessment_type public.assessment_type DEFAULT 'Teacher'::public.assessment_type,
    notes text,
    status public.score_status DEFAULT 'Submitted'::public.score_status,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT check_score_range CHECK (((obtained_score >= (0)::numeric) AND (obtained_score <= max_score))),
    CONSTRAINT chk_score_range CHECK (((obtained_score >= (0)::numeric) AND (obtained_score <= max_score)))
);


--
-- Name: sections; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sections (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    batch_id uuid NOT NULL,
    name character varying(10) NOT NULL,
    capacity integer DEFAULT 60,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: shl_integrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shl_integrations (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    student_id uuid NOT NULL,
    shl_user_id character varying(100) NOT NULL,
    competency_data jsonb DEFAULT '{}'::jsonb NOT NULL,
    last_sync_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    sync_status public.sync_status DEFAULT 'Success'::public.sync_status,
    error_message text,
    sync_attempts integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: student_competency_scores; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.student_competency_scores AS
 SELECT ms.student_id,
    ms.term_id,
    c.id AS component_id,
    c.name AS component_name,
    COALESCE(avg(((ms.obtained_score * 100.0) / ms.max_score)), (0)::numeric) AS average_score,
    count(ms.id) AS total_microcompetencies,
    count(
        CASE
            WHEN (ms.obtained_score > (0)::numeric) THEN 1
            ELSE NULL::integer
        END) AS scored_microcompetencies
   FROM ((public.microcompetency_scores ms
     JOIN public.microcompetencies m ON ((ms.microcompetency_id = m.id)))
     JOIN public.components c ON ((m.component_id = c.id)))
  GROUP BY ms.student_id, ms.term_id, c.id, c.name;


--
-- Name: student_improvement_goals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.student_improvement_goals (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    student_id uuid NOT NULL,
    term_id uuid NOT NULL,
    component_id uuid NOT NULL,
    target_score numeric(5,2) NOT NULL,
    target_date date NOT NULL,
    actions jsonb DEFAULT '[]'::jsonb,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    completed_at timestamp without time zone
);


--
-- Name: student_intervention_scores; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.student_intervention_scores AS
 SELECT ie.student_id,
    i.term_id,
    i.id AS intervention_id,
    i.name AS intervention_name,
    COALESCE(avg(((ms.obtained_score * 100.0) / ms.max_score)), (0)::numeric) AS average_score,
    count(ms.id) AS total_microcompetencies,
    count(
        CASE
            WHEN (ms.obtained_score > (0)::numeric) THEN 1
            ELSE NULL::integer
        END) AS scored_microcompetencies,
    ie.enrollment_status,
    ie.enrollment_date
   FROM (((public.intervention_enrollments ie
     JOIN public.interventions i ON ((ie.intervention_id = i.id)))
     LEFT JOIN public.intervention_microcompetencies im ON ((i.id = im.intervention_id)))
     LEFT JOIN public.microcompetency_scores ms ON (((im.microcompetency_id = ms.microcompetency_id) AND (ie.student_id = ms.student_id) AND (i.term_id = ms.term_id))))
  GROUP BY ie.student_id, i.term_id, i.id, i.name, ie.enrollment_status, ie.enrollment_date;


--
-- Name: student_interventions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.student_interventions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    student_id uuid NOT NULL,
    intervention_id uuid NOT NULL,
    enrollment_date timestamp without time zone DEFAULT now(),
    status character varying(20) DEFAULT 'active'::character varying,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: student_level_progression; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.student_level_progression (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    student_id uuid NOT NULL,
    term_id uuid NOT NULL,
    level_number integer NOT NULL,
    level_name character varying(100) NOT NULL,
    progression_status character varying(50) DEFAULT 'in_progress'::character varying,
    eligibility_status character varying(50) DEFAULT 'pending'::character varying,
    attendance_percentage numeric(5,2),
    quadrant_scores jsonb,
    overall_score numeric(5,2),
    progression_date timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: student_profile_requests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.student_profile_requests (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    student_id uuid NOT NULL,
    requested_changes jsonb NOT NULL,
    current_values jsonb NOT NULL,
    request_reason text,
    status character varying(20) DEFAULT 'pending'::character varying,
    requested_by uuid NOT NULL,
    reviewed_by uuid,
    review_reason text,
    created_at timestamp without time zone DEFAULT now(),
    reviewed_at timestamp without time zone,
    CONSTRAINT student_profile_requests_status_check CHECK (((status)::text = ANY (ARRAY[('pending'::character varying)::text, ('approved'::character varying)::text, ('rejected'::character varying)::text])))
);


--
-- Name: students; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.students (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    registration_no character varying(20) NOT NULL,
    name character varying(255) NOT NULL,
    course character varying(100) NOT NULL,
    batch_id uuid,
    section_id uuid,
    house_id uuid,
    gender public.gender_type,
    phone character varying(20),
    preferences jsonb DEFAULT '{}'::jsonb,
    overall_score numeric(5,2) DEFAULT 0.00,
    grade public.grade_type DEFAULT 'IC'::public.grade_type,
    status public.student_status DEFAULT 'Active'::public.student_status,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    current_term_id uuid NOT NULL
);


--
-- Name: sub_categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sub_categories (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    quadrant_id character varying(50) NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    weightage numeric(5,2) NOT NULL,
    display_order integer DEFAULT 0,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_subcategory_weightage CHECK (((weightage > (0)::numeric) AND (weightage <= (100)::numeric)))
);


--
-- Name: student_quadrant_scores; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.student_quadrant_scores AS
 SELECT s.student_id,
    s.term_id,
    q.id AS quadrant_id,
    q.name AS quadrant_name,
    COALESCE(btqw.weightage, q.weightage) AS weightage,
    COALESCE(avg(((s.obtained_score * 100.0) / s.max_score)), (0)::numeric) AS average_score,
    count(s.id) AS total_components,
    count(
        CASE
            WHEN (s.obtained_score > (0)::numeric) THEN 1
            ELSE NULL::integer
        END) AS scored_components
   FROM ((((((public.scores s
     JOIN public.components c ON ((s.component_id = c.id)))
     JOIN public.sub_categories sc ON ((c.sub_category_id = sc.id)))
     JOIN public.quadrants q ON (((sc.quadrant_id)::text = (q.id)::text)))
     JOIN public.students st ON ((s.student_id = st.id)))
     LEFT JOIN public.batch_term_weightage_config btc ON (((btc.batch_id = st.batch_id) AND (btc.term_id = s.term_id) AND (btc.is_active = true))))
     LEFT JOIN public.batch_term_quadrant_weightages btqw ON (((btqw.config_id = btc.id) AND ((btqw.quadrant_id)::text = (q.id)::text))))
  GROUP BY s.student_id, s.term_id, q.id, q.name, COALESCE(btqw.weightage, q.weightage);


--
-- Name: student_rankings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.student_rankings (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    student_id uuid,
    term_id uuid,
    quadrant_id character varying(50),
    rank_position integer,
    total_students integer,
    score numeric(5,2),
    ranking_type character varying(20) DEFAULT 'quadrant'::character varying,
    grade character varying(5),
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: student_score_summary; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.student_score_summary (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    student_id uuid NOT NULL,
    term_id uuid NOT NULL,
    persona_score numeric(5,2) DEFAULT 0.00,
    wellness_score numeric(5,2) DEFAULT 0.00,
    behavior_score numeric(5,2) DEFAULT 0.00,
    discipline_score numeric(5,2) DEFAULT 0.00,
    total_hps numeric(5,2) DEFAULT 0.00,
    overall_grade character varying(5) DEFAULT 'IC'::character varying,
    overall_status character varying(20) DEFAULT 'Progress'::character varying,
    last_calculated_at timestamp without time zone DEFAULT now(),
    calculation_version integer DEFAULT 1,
    CONSTRAINT check_quadrant_scores CHECK (((persona_score >= (0)::numeric) AND (persona_score <= (100)::numeric) AND (wellness_score >= (0)::numeric) AND (wellness_score <= (100)::numeric) AND (behavior_score >= (0)::numeric) AND (behavior_score <= (100)::numeric) AND (discipline_score >= (0)::numeric) AND (discipline_score <= (100)::numeric))),
    CONSTRAINT check_total_hps CHECK (((total_hps >= (0)::numeric) AND (total_hps <= (100)::numeric)))
);


--
-- Name: student_term_progression; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.student_term_progression (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    student_id uuid,
    batch_id uuid,
    term_id uuid,
    term_number integer NOT NULL,
    enrollment_date date DEFAULT CURRENT_DATE,
    completion_date date,
    status character varying(20) DEFAULT 'enrolled'::character varying,
    eligibility_status character varying(20) DEFAULT 'pending'::character varying,
    final_hps numeric(5,2),
    final_grade character varying(5),
    attendance_percentage numeric(5,2),
    quadrant_scores jsonb,
    progression_notes text,
    can_progress_to_next boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


--
-- Name: student_terms; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.student_terms (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    student_id uuid NOT NULL,
    term_id uuid NOT NULL,
    enrollment_status public.enrollment_status DEFAULT 'Enrolled'::public.enrollment_status,
    total_score numeric(5,2) DEFAULT 0.00,
    grade public.grade_type DEFAULT 'IC'::public.grade_type,
    overall_status public.status_type DEFAULT 'Progress'::public.status_type,
    rank integer,
    is_eligible boolean DEFAULT true,
    enrolled_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    completed_at timestamp without time zone
);


--
-- Name: system_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.system_settings (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    setting_key character varying(100) NOT NULL,
    setting_value jsonb NOT NULL,
    description text,
    category character varying(50) NOT NULL,
    is_public boolean DEFAULT false,
    updated_by uuid NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: task_microcompetencies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.task_microcompetencies (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    task_id uuid NOT NULL,
    microcompetency_id uuid NOT NULL,
    weightage numeric(5,2) DEFAULT 100.00 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_weightage CHECK (((weightage > (0)::numeric) AND (weightage <= (100)::numeric)))
);


--
-- Name: tasks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tasks (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    intervention_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    quadrant_id character varying(50),
    component_id uuid,
    max_score numeric(5,2) DEFAULT 10.00 NOT NULL,
    due_date timestamp without time zone NOT NULL,
    instructions text,
    rubric jsonb DEFAULT '[]'::jsonb,
    attachments jsonb DEFAULT '[]'::jsonb,
    submission_type public.submission_type DEFAULT 'Document'::public.submission_type,
    allow_late_submission boolean DEFAULT true,
    late_penalty numeric(5,2) DEFAULT 0.00,
    status public.task_status DEFAULT 'Draft'::public.task_status,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    microcompetency_id uuid,
    created_by_teacher_id uuid,
    requires_submission boolean DEFAULT true,
    CONSTRAINT chk_task_late_penalty CHECK (((late_penalty >= (0)::numeric) AND (late_penalty <= (100)::numeric))),
    CONSTRAINT chk_task_max_score CHECK ((max_score > (0)::numeric))
);


--
-- Name: task_microcompetency_summary; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.task_microcompetency_summary AS
 SELECT t.id AS task_id,
    t.name AS task_name,
    t.max_score,
    t.due_date,
    t.status,
    i.name AS intervention_name,
    count(tm.microcompetency_id) AS microcompetency_count,
    sum(tm.weightage) AS total_weightage,
    array_agg(m.name ORDER BY tm.weightage DESC) AS microcompetency_names,
    array_agg(tm.weightage ORDER BY tm.weightage DESC) AS weightages
   FROM (((public.tasks t
     JOIN public.interventions i ON ((t.intervention_id = i.id)))
     LEFT JOIN public.task_microcompetencies tm ON ((t.id = tm.task_id)))
     LEFT JOIN public.microcompetencies m ON ((tm.microcompetency_id = m.id)))
  GROUP BY t.id, t.name, t.max_score, t.due_date, t.status, i.name;


--
-- Name: task_submissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.task_submissions (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    task_id uuid NOT NULL,
    student_id uuid NOT NULL,
    submitted_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    status public.submission_status DEFAULT 'Submitted'::public.submission_status,
    is_late boolean DEFAULT false,
    attachments jsonb DEFAULT '[]'::jsonb,
    submission_text text,
    score numeric(5,2),
    rubric_scores jsonb DEFAULT '[]'::jsonb,
    feedback text,
    private_notes text,
    graded_by uuid,
    graded_at timestamp without time zone
);


--
-- Name: teacher_assignments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.teacher_assignments (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    teacher_id uuid NOT NULL,
    student_id uuid NOT NULL,
    term_id uuid NOT NULL,
    quadrant_id character varying(50) NOT NULL,
    assigned_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    assigned_by uuid NOT NULL,
    is_active boolean DEFAULT true,
    notes text
);


--
-- Name: teacher_microcompetency_assignments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.teacher_microcompetency_assignments (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    intervention_id uuid NOT NULL,
    teacher_id uuid NOT NULL,
    microcompetency_id uuid NOT NULL,
    can_score boolean DEFAULT true,
    can_create_tasks boolean DEFAULT true,
    assigned_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    assigned_by uuid NOT NULL,
    is_active boolean DEFAULT true
);


--
-- Name: teachers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.teachers (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    employee_id character varying(20) NOT NULL,
    name character varying(255) NOT NULL,
    specialization character varying(100),
    department character varying(100),
    assigned_quadrants jsonb DEFAULT '[]'::jsonb,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: teacher_task_permissions; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.teacher_task_permissions AS
 SELECT DISTINCT t.id AS teacher_id,
    i.id AS intervention_id,
    i.name AS intervention_name,
    count(tma.microcompetency_id) AS assigned_microcompetencies,
    count(
        CASE
            WHEN tma.can_create_tasks THEN 1
            ELSE NULL::integer
        END) AS can_create_tasks_count,
    count(
        CASE
            WHEN tma.can_score THEN 1
            ELSE NULL::integer
        END) AS can_score_count
   FROM ((public.teachers t
     JOIN public.teacher_microcompetency_assignments tma ON ((t.id = tma.teacher_id)))
     JOIN public.interventions i ON ((tma.intervention_id = i.id)))
  WHERE (tma.is_active = true)
  GROUP BY t.id, i.id, i.name;


--
-- Name: term_lifecycle_events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.term_lifecycle_events (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    term_id uuid,
    batch_id uuid,
    event_type character varying(50) NOT NULL,
    event_date timestamp without time zone DEFAULT now(),
    triggered_by uuid,
    event_data jsonb,
    notes text,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: terms; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.terms (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    start_date date NOT NULL,
    end_date date NOT NULL,
    is_active boolean DEFAULT false,
    is_current boolean DEFAULT false,
    academic_year character varying(20) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    term_number integer DEFAULT 1,
    term_status character varying(20) DEFAULT 'upcoming'::character varying,
    level_name character varying(50),
    attendance_threshold numeric(5,2) DEFAULT 75.00,
    progression_requirements jsonb,
    eligibility_rules jsonb,
    completion_date date,
    max_students integer,
    level_number integer DEFAULT 1,
    CONSTRAINT chk_term_dates CHECK ((end_date > start_date))
);


--
-- Name: user_sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_sessions (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    session_token character varying(255) NOT NULL,
    refresh_token character varying(255) NOT NULL,
    ip_address inet,
    user_agent text,
    expires_at timestamp without time zone NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    last_accessed timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    is_active boolean DEFAULT true
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    username character varying(50) NOT NULL,
    email character varying(255) NOT NULL,
    password_hash character varying(255) NOT NULL,
    role public.user_role NOT NULL,
    status public.user_status DEFAULT 'active'::public.user_status,
    last_login timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    microsoft_id character varying(255),
    sso_provider character varying(50),
    erp_validated boolean DEFAULT false,
    first_name character varying(100),
    last_name character varying(100),
    kos_user_id character varying(255),
    authenticated_via character varying(50) DEFAULT 'local'::character varying,
    user_source character varying(20) DEFAULT 'local'::character varying,
    promoted_by uuid,
    promoted_at timestamp without time zone,
    promotion_reason text,
    last_kos_sync timestamp without time zone
);


--
-- Name: v_batch_term_weightage_summary; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.v_batch_term_weightage_summary AS
 SELECT btc.id AS config_id,
    btc.batch_id,
    b.name AS batch_name,
    btc.term_id,
    t.name AS term_name,
    btc.config_name,
    btc.is_active,
    jsonb_agg(DISTINCT jsonb_build_object('quadrant_id', btqw.quadrant_id, 'quadrant_name', q.name, 'weightage', btqw.weightage, 'minimum_attendance', btqw.minimum_attendance)) FILTER (WHERE (btqw.id IS NOT NULL)) AS quadrant_weightages,
    count(DISTINCT btqw.quadrant_id) AS quadrant_count,
    count(DISTINCT btscw.subcategory_id) AS subcategory_count,
    count(DISTINCT btcw.component_id) AS component_count,
    count(DISTINCT btmw.microcompetency_id) AS microcompetency_count
   FROM (((((((public.batch_term_weightage_config btc
     JOIN public.batches b ON ((btc.batch_id = b.id)))
     JOIN public.terms t ON ((btc.term_id = t.id)))
     LEFT JOIN public.batch_term_quadrant_weightages btqw ON ((btc.id = btqw.config_id)))
     LEFT JOIN public.quadrants q ON (((btqw.quadrant_id)::text = (q.id)::text)))
     LEFT JOIN public.batch_term_subcategory_weightages btscw ON ((btc.id = btscw.config_id)))
     LEFT JOIN public.batch_term_component_weightages btcw ON ((btc.id = btcw.config_id)))
     LEFT JOIN public.batch_term_microcompetency_weightages btmw ON ((btc.id = btmw.config_id)))
  GROUP BY btc.id, btc.batch_id, b.name, btc.term_id, t.name, btc.config_name, btc.is_active;


--
-- Name: weightage_change_audit; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.weightage_change_audit (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    config_id uuid NOT NULL,
    change_type character varying(50) NOT NULL,
    entity_type character varying(50) NOT NULL,
    entity_id character varying(255) NOT NULL,
    old_weightage numeric(5,2),
    new_weightage numeric(5,2),
    change_reason text,
    changed_by uuid NOT NULL,
    changed_at timestamp without time zone DEFAULT now(),
    change_context jsonb DEFAULT '{}'::jsonb,
    CONSTRAINT weightage_change_audit_change_type_check CHECK (((change_type)::text = ANY ((ARRAY['create'::character varying, 'update'::character varying, 'delete'::character varying, 'inherit'::character varying])::text[]))),
    CONSTRAINT weightage_change_audit_entity_type_check CHECK (((entity_type)::text = ANY ((ARRAY['quadrant'::character varying, 'subcategory'::character varying, 'component'::character varying, 'microcompetency'::character varying])::text[])))
);


--
-- Name: TABLE weightage_change_audit; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.weightage_change_audit IS 'Audit trail for all weightage changes';


--
-- Name: weightage_inheritance_rules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.weightage_inheritance_rules (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    rule_name character varying(255) NOT NULL,
    rule_type character varying(50) NOT NULL,
    source_config_id uuid,
    target_batch_id uuid,
    target_term_id uuid,
    inheritance_level character varying(50) NOT NULL,
    is_active boolean DEFAULT true,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    CONSTRAINT weightage_inheritance_rules_check CHECK (((((rule_type)::text = 'batch_to_batch'::text) AND (source_config_id IS NOT NULL) AND (target_batch_id IS NOT NULL)) OR (((rule_type)::text = 'term_to_term'::text) AND (source_config_id IS NOT NULL) AND (target_term_id IS NOT NULL)) OR (((rule_type)::text = 'default_system'::text) AND (source_config_id IS NULL)))),
    CONSTRAINT weightage_inheritance_rules_inheritance_level_check CHECK (((inheritance_level)::text = ANY ((ARRAY['all'::character varying, 'quadrant'::character varying, 'subcategory'::character varying, 'component'::character varying, 'microcompetency'::character varying])::text[]))),
    CONSTRAINT weightage_inheritance_rules_rule_type_check CHECK (((rule_type)::text = ANY ((ARRAY['batch_to_batch'::character varying, 'term_to_term'::character varying, 'default_system'::character varying])::text[])))
);


--
-- Name: TABLE weightage_inheritance_rules; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.weightage_inheritance_rules IS 'Rules for inheriting weightages between batches and terms';


--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);


--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: -
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text,
    type storage.buckettype DEFAULT 'STANDARD'::storage.buckettype NOT NULL
);


--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: -
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: buckets_analytics; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.buckets_analytics (
    id text NOT NULL,
    type storage.buckettype DEFAULT 'ANALYTICS'::storage.buckettype NOT NULL,
    format text DEFAULT 'ICEBERG'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: objects; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb,
    level integer
);


--
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: -
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: prefixes; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.prefixes (
    bucket_id text NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    level integer GENERATED ALWAYS AS (storage.get_level(name)) STORED NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb
);


--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
00000000-0000-0000-0000-000000000000	d4e2391a-bf37-4f42-8c22-14a30c5b4945	{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"sri@e.com","user_id":"62aae285-3b52-4e52-ba18-9fe2d0932a18","user_phone":""}}	2025-06-13 18:05:28.231655+00	
00000000-0000-0000-0000-000000000000	b990f97c-4eec-40b9-a7e1-0f104df23eac	{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"provider":"email","user_email":"divya@e.com","user_id":"8d5f03f1-0b14-4ad7-98cb-6ce307eb0887","user_phone":""}}	2025-07-12 06:29:00.194064+00	
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at) FROM stdin;
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
62aae285-3b52-4e52-ba18-9fe2d0932a18	62aae285-3b52-4e52-ba18-9fe2d0932a18	{"sub": "62aae285-3b52-4e52-ba18-9fe2d0932a18", "email": "sri@e.com", "email_verified": false, "phone_verified": false}	email	2025-06-13 18:05:28.227865+00	2025-06-13 18:05:28.229002+00	2025-06-13 18:05:28.229002+00	37bc8028-2adc-4c76-a990-ba9501e2eefb
8d5f03f1-0b14-4ad7-98cb-6ce307eb0887	8d5f03f1-0b14-4ad7-98cb-6ce307eb0887	{"sub": "8d5f03f1-0b14-4ad7-98cb-6ce307eb0887", "email": "divya@e.com", "email_verified": false, "phone_verified": false}	email	2025-07-12 06:29:00.188101+00	2025-07-12 06:29:00.189309+00	2025-07-12 06:29:00.189309+00	4e6568aa-61db-44a4-9aaa-79a3c6c452d1
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid) FROM stdin;
\.


--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.oauth_clients (id, client_id, client_secret_hash, registration_type, redirect_uris, grant_types, client_name, client_uri, logo_uri, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
20250717082212
20250731150234
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag) FROM stdin;
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at, disabled) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
00000000-0000-0000-0000-000000000000	62aae285-3b52-4e52-ba18-9fe2d0932a18	authenticated	authenticated	sri@e.com	$2a$10$1SIhIeWpXpfMLPP.MFyhWuQjWsPq5EA4LFIHfBnIjkRvfYF5X/6m2	2025-06-13 18:05:28.239448+00	\N		\N		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2025-06-13 18:05:28.215118+00	2025-06-13 18:05:28.242819+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	8d5f03f1-0b14-4ad7-98cb-6ce307eb0887	authenticated	authenticated	divya@e.com	$2a$10$Gm9sVWHKzRk1vmmz/a2M7uqc/2MqLFUtUVd.TeyMPJA1NyO6wf4.W	2025-07-12 06:29:00.199836+00	\N		\N		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2025-07-12 06:29:00.172029+00	2025-07-12 06:29:00.201589+00	\N	\N			\N		0	\N		\N	f	\N	f
\.


--
-- Data for Name: admin_audit_log; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.admin_audit_log (id, admin_id, action, target_user_id, old_value, new_value, reason, ip_address, user_agent, created_at) FROM stdin;
aa3c1021-a269-4200-9f16-e8ae47208ea8	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	super_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	curl/7.81.0	2025-07-11 10:35:04.891
5291f77d-5137-4163-a418-f8a8a224853b	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-11 11:09:56.201
a18cd8f0-0384-4a4e-9454-dd2ca503919d	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	super_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-11 11:10:20.338
2ceba47d-9ac8-4656-a771-4ba804660cef	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-11 11:12:56.251
334ece24-a5e3-4b31-b75f-3f82ad30c58d	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-11 11:51:28.763
ae597bca-2ea8-46c2-b37e-8cd90958c1a3	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-11 12:51:49.727
88f6adaf-0d46-4272-8aec-b9b91f887d63	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-11 13:41:17.295
9542841f-04e9-4d76-930b-8ba1bf40b578	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-11 13:54:21.057
398038cd-6adb-4a86-8649-e3a2c757e550	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	curl/7.81.0	2025-07-11 16:40:41.271
03c22b72-91a9-4aff-a4b2-fbccbcd45aa2	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-11 16:56:09.052
48d84eb9-1482-47b7-a56e-d777b3ee86a4	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	super_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-12 04:54:04.961
83680052-bc36-4d03-92d0-3ebc3ec46f94	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-12 04:58:53.956
68ec30f2-0703-4214-a792-2e85b896054a	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-12 04:59:17.455
ad74f1c1-0d89-416c-a72e-31bfaf7d035f	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-12 04:59:48.076
642bb607-5bb6-49cb-a669-8954c022b26c	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-12 05:00:13.515
c9a6d52a-6fde-471a-98f9-c50478a54168	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-12 05:10:01.911
5e1b35a7-02cc-4606-9a59-cee08ddb643c	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	2025-07-12 05:12:11.217
fb617536-bd69-45be-a644-7a1575ac0bce	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-12 05:15:03.364
060155f9-aa3f-427a-ab7a-a8e8af7e5c7c	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-12 05:15:23.114
2a0294be-9f12-43b5-b0fe-278d50441082	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	2025-07-12 05:15:39.103
a85db8c7-f620-48fb-b31b-c04b5bbb831e	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-12 05:17:04.31
254c7840-40bc-4b8b-a96f-dc3a26f38f19	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-12 05:20:34.977
d599a3e4-fc66-4557-a9ba-22f555eb2a66	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-12 05:22:59.929
1d08b962-e9d6-4616-bf67-fa5854897ee4	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::1	axios/1.9.0	2025-07-12 05:23:44.531
94f77d9d-1ed1-4894-a652-1ff369a301af	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-12 05:56:02.044
40bdee08-d92b-4088-b488-75957a3d468d	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::1	axios/1.9.0	2025-07-12 06:08:53.237
1ea30f0e-b817-4b4e-a3a5-0277e74dc9e2	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::1	axios/1.9.0	2025-07-12 06:18:05.288
9d0d46d4-7924-472b-9262-d931d9ac8e18	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-12 06:24:24.138
fe894db9-a474-4e57-8dec-5f57c76aab25	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-12 06:42:28.033
e9650d68-ce82-4140-8a92-d676e6dfc311	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-12 06:42:32.415
2e3e1a5f-40e3-4ed4-81e5-ab2d43cddc14	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-12 06:47:26.61
9b999634-d00c-42dd-9eb0-44f71a9d6600	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-12 06:53:24.472
29e25e7e-47e7-4e11-826c-7e6d1b408bfa	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-13 05:47:26.366
3e27d00f-8c19-453f-85b2-2141a2c82c1e	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-13 07:06:04.307
bff96116-328c-41a6-90ba-88ddde22bb3b	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-13 07:17:08.601
786055d8-24b2-456b-9be4-9f5918d700ad	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	curl/7.81.0	2025-07-13 16:35:13.924
87ffb00f-4d2a-4765-a5c9-d6a9f5144f3c	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-13 16:36:51.771
697e2866-8c67-41c7-8456-86ea4234e00f	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-13 16:38:22.664
92d22779-9bbd-400c-ab8e-3002a4583998	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	curl/7.81.0	2025-07-13 16:55:32.454
cf90cc08-5fe6-470f-b240-de4912651c37	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-13 17:11:46.957
14aa9150-1ff8-449b-92b2-f7111849f22e	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	curl/7.81.0	2025-07-13 20:34:38.48
7068cffc-1d66-4490-9f57-781058169bfc	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	curl/7.81.0	2025-07-13 21:03:46.17
74e3d215-cc3b-448c-8eea-f4384c2c30a7	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-15 09:58:28.775
24d147f1-ffb6-4932-adcf-963cb389fba6	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	curl/7.81.0	2025-07-15 10:06:55.387
8c8be6ca-b749-4d63-8f61-da1985ce7a62	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	curl/7.81.0	2025-07-15 12:30:32.757
ec16f25a-befb-45a1-a186-cc97c4c4a1d3	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-15 12:35:58.492
343199f5-8aed-47e5-9728-acc0672e6f76	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-15 12:37:12.931
70db9f1b-2a46-4e04-b69b-db3dca20f7e8	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	curl/7.81.0	2025-07-15 12:41:09.414
5714570c-c912-4b97-992a-9f5586396abe	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	curl/7.81.0	2025-07-15 12:54:02.37
d64e6d24-0756-4107-8477-d1f9e16de80a	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	curl/7.81.0	2025-07-15 12:56:39.341
4dba89ff-abc8-4937-9e9c-813b0b5a647d	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	curl/7.81.0	2025-07-15 12:59:01.955
7c16e23c-f3ba-41bc-abcd-6559c1e98c49	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	curl/7.81.0	2025-07-15 13:01:41.821
ebf3231d-4471-4329-8bb6-98b8c3c1adb3	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-15 13:02:55.049
6d306e3d-1e8e-4efc-9300-0a31079aec28	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-15 13:03:18.329
1dd4da53-7510-4ce3-a8b9-195aecf428c0	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	curl/7.81.0	2025-07-15 13:03:19.277
8d06e57e-4747-4d7c-a19a-d75bfd32380a	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	curl/7.81.0	2025-07-15 13:06:59.861
95b5b94c-3f03-4609-b7ae-7e8fea1fd563	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	curl/7.81.0	2025-07-15 13:07:12.124
c3094b66-575b-4b26-8470-afc6a710e7ee	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	curl/7.81.0	2025-07-15 13:10:37.133
071c59f5-909a-4336-a876-d90b03e9e6c5	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	curl/7.81.0	2025-07-15 13:10:50.26
4d57025d-b358-4380-908e-209bd28fb676	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	curl/7.81.0	2025-07-15 13:11:21.727
4f5c7fe6-80a5-4c92-87e4-54107ca4c2c8	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	curl/7.81.0	2025-07-15 14:11:23.305
dcd6152c-0fd8-479a-a59c-58f5d82e74f1	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	curl/7.81.0	2025-07-16 05:34:26.594
6cd63abf-60c7-4701-a904-be1f0fb23911	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	curl/7.81.0	2025-07-16 05:35:23.445
e0b919e6-25a3-4b15-8bd6-94981f9ff513	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-25 04:12:14.755
23054c24-687a-4e8e-8153-73c40c91c4db	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-25 04:23:15.899
4a5672d7-5ac1-46e2-be93-8673c7994b20	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-25 04:24:07.925
125d3eff-0a6b-4214-a04f-a5c2f28b8378	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-25 04:31:41.409
2d67c693-060b-461c-8097-3c99137984eb	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-25 04:43:03.642
3b5f40ef-689a-4a9c-ac2f-a45d07541a53	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-25 04:43:53.061
f40b68fc-b0e2-4583-b7c4-42144feb0d55	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-25 04:53:26.423
b3f62c11-ae63-4af6-a77d-e0ae0d9069af	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-25 04:56:57.581
31c68521-3d5a-4789-b060-24a761853f1c	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-25 06:51:41.208
2d7723fb-b367-4aaf-84e7-4dffb9b9aed8	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-25 07:54:41.459
fe2a1b78-6362-4b9c-9e5b-9a19c799ea6d	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-25 07:55:20.026
01564552-1248-47fa-a3bd-a8c1323486d6	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	2025-07-25 07:58:25.93
4e4aa4aa-9d18-4c75-adfd-f80d70cc70b7	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:141.0) Gecko/20100101 Firefox/141.0	2025-08-07 13:52:36.727
6d0d8ad0-9f79-4632-b75f-f0029fff7f27	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	curl/7.81.0	2025-08-07 13:53:13.709
e118d4ae-aa3e-41cd-89f5-0bfedc64a21c	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	curl/7.81.0	2025-08-07 13:55:45.977
524ddb99-ead9-4582-b5bf-90412fdf4dec	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	curl/7.81.0	2025-08-07 13:56:57.43
a881e73a-7514-47a5-85c5-101f3bb28f7f	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:141.0) Gecko/20100101 Firefox/141.0	2025-08-07 14:04:48.289
54746c3c-8f10-401f-b6bd-ef3ef2cb5cfd	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:141.0) Gecko/20100101 Firefox/141.0	2025-08-07 14:30:41.63
a7c8cd81-9932-4166-8682-6b1fb02f1924	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	super_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	curl/7.81.0	2025-08-07 17:39:08.114
d8241dd2-b013-4a75-a7bd-4fc4f9ea0a8a	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	curl/7.81.0	2025-08-08 13:42:20.703
40e5ce46-853c-407e-8316-b2852ce0672d	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	curl/7.81.0	2025-08-08 13:47:56.958
1c14472c-2456-4334-8f1b-9813c0c14ec8	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	curl/7.81.0	2025-08-08 13:57:26.105
9af8a11f-9d42-4ff3-89ad-39f50936aa26	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	curl/7.81.0	2025-08-08 14:07:26.167
28272f6a-c732-4b87-a292-202d5f318a79	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	node	2025-08-08 14:09:42.81
94de381d-d128-4518-937d-1978d1c85397	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	node	2025-08-08 14:16:16.302
e29788e5-b378-4c1f-8adb-c94cbf97c494	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:141.0) Gecko/20100101 Firefox/141.0	2025-08-08 15:23:48.959
f7214c29-5fb8-400f-ae2b-88b8ae9ca51f	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:141.0) Gecko/20100101 Firefox/141.0	2025-08-08 16:29:15.26
656649a1-ef23-450f-9e49-ef2283e437b9	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:141.0) Gecko/20100101 Firefox/141.0	2025-08-08 16:32:20.103
85ca6c23-eb1c-4066-8989-229f05e3e277	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	curl/7.81.0	2025-08-08 16:38:19.511
16670dba-cb22-4e40-9c6d-1a7874b47461	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	curl/7.81.0	2025-08-08 16:43:56.183
f3ede356-becf-437e-9fa8-befce4ba9882	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:141.0) Gecko/20100101 Firefox/141.0	2025-08-08 17:03:41.118
1aed407e-c41e-4470-86d5-cf66a366c3b0	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:141.0) Gecko/20100101 Firefox/141.0	2025-08-08 17:09:06.812
69699ea7-7cc4-4296-8eb2-f39c839130b4	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:141.0) Gecko/20100101 Firefox/141.0	2025-08-08 17:23:00.416
8aea563a-d68a-4531-9327-5a557f73809e	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	curl/7.81.0	2025-08-08 17:24:00.303
82796465-d9c4-4e00-b703-7d84a1a7830d	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:141.0) Gecko/20100101 Firefox/141.0	2025-08-08 17:49:21.415
257dcd1c-e3fd-4d6d-84e4-68ad9ceb27d1	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	curl/7.81.0	2025-08-08 19:01:29.767
47fa35db-468e-43ec-98a7-f2adc8e28e10	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	curl/7.81.0	2025-08-08 19:01:55.162
2fc1d27c-cd6b-452c-a18a-0d91dc8091dd	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:141.0) Gecko/20100101 Firefox/141.0	2025-08-08 19:17:06.743
34a93fe3-522c-4fdc-a81b-ef45e7544ea6	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:141.0) Gecko/20100101 Firefox/141.0	2025-08-09 17:11:54.768
c20682c0-4a43-430d-b8a3-0e144b27e75c	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:141.0) Gecko/20100101 Firefox/141.0	2025-08-09 17:18:09.19
499c786f-a8a7-481a-9379-c9a5dfc4c4ec	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	2025-08-14 14:57:00.494
b42f1b51-1188-4b6a-9f5e-7f664a533e96	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	2025-08-14 15:24:42.606
48cf645e-fd9b-471b-81e8-84456a8fd117	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	2025-08-15 07:01:31.688
767c6ce2-aff3-46d3-bfca-7d13817551a3	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	2025-08-15 07:07:53.796
b1003bd3-d335-4df1-8f0c-64f407434e18	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	2025-08-15 07:51:30.438
a242f347-c067-4e02-b5f8-3e18d1590a7e	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	2025-08-18 13:47:09.423
ee16eadc-900f-4e89-8a2e-40e77ebda003	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	106.51.85.159	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	2025-08-19 17:50:33.026
7a023c74-e607-4e2a-b238-873d0ee5d829	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	106.51.85.159	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	2025-08-19 17:51:05.833
b077e97b-cb14-442b-80ee-627496355399	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:141.0) Gecko/20100101 Firefox/141.0	2025-08-19 17:52:17.852
79345394-2c3d-4654-ac1c-7e7c3cefb4e0	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	106.51.85.159	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	2025-08-19 17:52:49.463
a5413435-9618-46a6-9913-2f0728b3e5a7	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:141.0) Gecko/20100101 Firefox/141.0	2025-08-19 17:52:57.71
8f59d4af-5106-493c-9973-f2595381fefe	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:141.0) Gecko/20100101 Firefox/141.0	2025-08-19 17:56:38.994
4ae19eca-9058-4960-92a2-cac9f63ba402	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	106.51.85.159	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	2025-08-19 17:56:39.299
99ee9c19-6f48-4dd6-b50a-ecea05785513	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	106.51.85.159	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	2025-08-19 18:01:50.571
4522478b-3b1a-4f2a-8f73-78a46c346e72	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:141.0) Gecko/20100101 Firefox/141.0	2025-08-19 18:03:07.432
1c872572-72d8-47d2-a0dd-8bc97fff4ede	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	super_admin_login	\N	\N	\N	\N	106.51.85.159	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	2025-08-19 18:07:00.447
0cae3478-6e70-4206-9ebf-2a7b1b5fc08d	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	202.131.141.42	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	2025-08-20 05:44:34.479
be318190-ee5c-40dd-abbe-94829083c442	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	202.131.141.42	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	2025-08-20 05:44:48.051
df1ea2bc-4bea-44d8-85fb-15e175147b78	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	202.131.141.42	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	2025-08-20 05:45:19.498
2bce9cbd-0d30-49d5-b939-788c756ba5cc	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	202.131.141.42	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	2025-08-20 05:45:25.185
25d4fd52-202d-4b39-a278-dafee975d931	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	139.5.29.126	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	2025-08-20 06:00:45.669
e1e0769c-a084-49f2-8609-4d45113b019c	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	139.5.29.126	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	2025-08-20 06:00:57.219
cc92ea2f-24ae-4999-95f2-b56f491330a3	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	202.131.141.42	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	2025-08-20 06:01:16.981
c21cb2cf-a492-4ecc-83f1-1df6171a4c8f	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	139.5.29.126	Mozilla/5.0 (X11; Linux x86_64; rv:141.0) Gecko/20100101 Firefox/141.0	2025-08-20 06:06:23.727
1d7430be-2d3b-4c92-9fa7-933cd577829c	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	202.131.141.42	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0	2025-08-20 06:35:16.472
3f488b7d-3186-42b4-9956-0d92c9fccddf	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:141.0) Gecko/20100101 Firefox/141.0	2025-08-20 07:14:55.529
29b4ef0d-08cf-4b44-96b6-da86d925fa11	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	202.131.141.42	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	2025-08-20 07:59:31.09
23f1b678-c5ef-42a6-b286-4a956ce5f01a	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:141.0) Gecko/20100101 Firefox/141.0	2025-08-20 08:00:43.284
4800f96c-a18d-4550-8e6e-f83a31ea7470	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:141.0) Gecko/20100101 Firefox/141.0	2025-08-20 08:02:14.134
e357fe1b-34b6-45b4-bd86-fec1f551149d	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.140.47.107	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	2025-08-20 08:16:09.529
7bf26424-1a12-4e86-bcaf-1ed1f47f7538	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.140.47.107	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	2025-08-20 08:17:34.398
07012a0a-18d7-4914-bbf9-8aadc29a3b23	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.140.47.107	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	2025-08-20 08:20:52.391
57c355a5-692f-41c9-9335-e17a533aecd8	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.140.47.107	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	2025-08-20 08:21:58.034
bc2f6458-0ff4-412e-aa08-3b75eed3b338	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	202.131.141.42	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0	2025-08-21 05:20:22.577
c9e92978-d74f-43a0-862b-5bc880b72f99	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (Android 12; Mobile; rv:141.0) Gecko/141.0 Firefox/141.0	2025-08-21 06:46:30.68
5cec8a70-0763-43b2-a60c-046899299743	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	202.131.141.42	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	2025-08-25 08:54:42.983
13045d95-dc54-4feb-8984-6cc84f08ed83	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:142.0) Gecko/20100101 Firefox/142.0	2025-08-25 10:57:05.302
77ca1462-7ea6-4d20-9e65-214681e69885	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:142.0) Gecko/20100101 Firefox/142.0	2025-08-30 05:19:31.613
dc9a7ef7-e4af-4f19-bdde-dc17423fc04c	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:142.0) Gecko/20100101 Firefox/142.0	2025-08-30 05:30:36.974
f6213993-3d75-4471-8c36-40e59ee143e8	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	202.131.141.42	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0	2025-09-19 06:24:53.166
88f58ff6-2519-41a2-b132-6c6101f87208	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	2025-09-22 05:07:07.777
a68ecaa7-bc95-4730-b2a1-ed862a09fe3d	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	202.131.141.42	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36	2025-10-07 09:52:05.844
924bfd9a-7fa0-43b2-98e5-89b28a7e6b10	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:143.0) Gecko/20100101 Firefox/143.0	2025-10-07 12:49:19.636
c5b9dffc-05fc-421b-841e-429c55232229	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:143.0) Gecko/20100101 Firefox/143.0	2025-10-07 12:59:57.394
4bbc6222-2f52-4a15-90c4-eec4ccae7677	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:143.0) Gecko/20100101 Firefox/143.0	2025-10-07 13:00:37.309
b18901c6-fccb-4614-ac6a-b29dc9fa9114	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:143.0) Gecko/20100101 Firefox/143.0	2025-10-07 14:39:44.297
7371f01f-1aa8-4d02-a608-b09e28b758c0	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:143.0) Gecko/20100101 Firefox/143.0	2025-10-07 15:21:01.303
27822a83-71e3-42d1-87a5-33b6ed23f8c0	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:143.0) Gecko/20100101 Firefox/143.0	2025-10-07 15:31:31.455
28053d07-6c8b-40b5-9984-4298c0170d6e	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:143.0) Gecko/20100101 Firefox/143.0	2025-10-07 15:35:38.428
844778e2-d0a4-4ac6-915a-94a3eaf9c1fa	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:143.0) Gecko/20100101 Firefox/143.0	2025-10-07 15:57:36.315
fa0550e1-840d-4546-9d65-21d55906e064	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:143.0) Gecko/20100101 Firefox/143.0	2025-10-07 16:02:11.777
3ba2d107-86c4-4f46-955d-04825bd50e93	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:143.0) Gecko/20100101 Firefox/143.0	2025-10-07 16:10:41.626
8b7869ce-7514-4972-bb32-3c59502bdd98	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:143.0) Gecko/20100101 Firefox/143.0	2025-10-07 16:25:09.052
203f7dc7-ac48-4f97-8a3d-29aecdca7d42	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:143.0) Gecko/20100101 Firefox/143.0	2025-10-07 16:45:36.894
05db5b03-94b1-4a91-b40c-a7706b52bc43	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:143.0) Gecko/20100101 Firefox/143.0	2025-10-07 18:12:06.352
781b2bb4-9340-4ee4-8ab1-5b38a8ebe7e5	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:143.0) Gecko/20100101 Firefox/143.0	2025-10-07 19:20:25.079
c995e571-05bd-41a8-8449-4ea32199cfca	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:143.0) Gecko/20100101 Firefox/143.0	2025-10-07 19:29:29.979
5c6cfbcc-e339-4d7d-abbe-caefcdff0ae0	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:143.0) Gecko/20100101 Firefox/143.0	2025-10-07 19:40:27.101
edc58e98-3bfe-475e-9164-400090c3cd28	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:143.0) Gecko/20100101 Firefox/143.0	2025-10-08 15:39:05.334
e4950c5c-9db6-4f8c-944a-9099a0f77d7d	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:143.0) Gecko/20100101 Firefox/143.0	2025-10-08 16:07:25.814
8a22481e-3e6d-417d-bf5b-ce774961adaa	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:143.0) Gecko/20100101 Firefox/143.0	2025-10-08 16:27:41.658
c38ac645-a28f-4cd8-932e-9f92f6645c2b	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:143.0) Gecko/20100101 Firefox/143.0	2025-10-08 16:52:02.047
b9ea76b9-9300-438d-985b-b0ca2403053b	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:143.0) Gecko/20100101 Firefox/143.0	2025-10-08 17:50:02.517
4438aaf0-bfde-4d04-95fa-47f7fd71f192	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:143.0) Gecko/20100101 Firefox/143.0	2025-10-08 18:42:46.297
1a5bc756-373d-4ee9-af01-b776ee461dee	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:143.0) Gecko/20100101 Firefox/143.0	2025-10-08 18:53:24.608
3f3475e7-4a0a-461d-adfe-f78e9df0e79d	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:143.0) Gecko/20100101 Firefox/143.0	2025-10-08 19:05:08.724
4ce8e951-c379-46f7-958e-5522cca382d0	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:143.0) Gecko/20100101 Firefox/143.0	2025-10-09 04:12:48.685
35a154df-1175-4813-b1ec-d8dc6ac04a9c	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:143.0) Gecko/20100101 Firefox/143.0	2025-10-09 04:31:11.764
1e96ff69-cd4c-4d6f-9392-aa7af6fc766a	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:143.0) Gecko/20100101 Firefox/143.0	2025-10-09 04:36:22.562
27056209-15d0-4ca3-af59-438d9942da70	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:143.0) Gecko/20100101 Firefox/143.0	2025-10-09 04:39:05.201
fd1ec08e-cd6a-4eb6-82b0-e28f98b5bc2d	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:143.0) Gecko/20100101 Firefox/143.0	2025-10-09 04:45:49.398
3defb89a-e3d3-4595-ad71-69e27b7b8d88	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:143.0) Gecko/20100101 Firefox/143.0	2025-10-09 05:21:23.142
dcdead03-3c7f-4509-b7a5-bee0aa921146	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:143.0) Gecko/20100101 Firefox/143.0	2025-10-09 05:37:08.372
65e2e98c-5c56-460c-a623-d946a73dd1e9	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	103.240.10.76	Mozilla/5.0 (X11; Linux x86_64; rv:143.0) Gecko/20100101 Firefox/143.0	2025-10-09 05:40:21.524
9c3cc9eb-7649-4658-8f5c-954a2f1446c6	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:143.0) Gecko/20100101 Firefox/143.0	2025-10-09 05:43:36.198
9b5df920-6218-4c9f-89eb-18dc685f57dc	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	curl/7.81.0	2025-10-09 05:46:41.711
7df7f9d1-883e-4035-a0d3-f1b4b1c1500e	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:143.0) Gecko/20100101 Firefox/143.0	2025-10-09 05:47:16.845
58d33ab8-1d20-4efe-a290-1afe33d85696	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:143.0) Gecko/20100101 Firefox/143.0	2025-10-09 06:05:39.644
91aad494-a5ab-4dd1-9994-a2af0c99f20b	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:143.0) Gecko/20100101 Firefox/143.0	2025-10-09 06:22:32.609
5bcdf6cf-78ed-4d51-a572-e3053baf4819	16459cad-4104-4955-8977-45eb93a63d4a	local_admin_login	\N	\N	\N	\N	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:143.0) Gecko/20100101 Firefox/143.0	2025-10-09 06:26:08.051
\.


--
-- Data for Name: admins; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.admins (id, user_id, name, permissions, access_level, created_at) FROM stdin;
075d26e0-ca34-4b13-914f-1264a4fbc06a	16459cad-4104-4955-8977-45eb93a63d4a	Admin User	[]	super	2025-06-16 21:17:51.698372
c4fc7fec-0189-4401-ae4e-153ba5991ba4	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	System Administrator	["full_access", "user_management", "system_config", "reports"]	super	2025-06-13 18:17:31.577575
\.


--
-- Data for Name: attendance; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.attendance (id, student_id, term_id, quadrant_id, attendance_date, is_present, reason, marked_by, created_at) FROM stdin;
\.


--
-- Data for Name: attendance_eligibility; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.attendance_eligibility (id, student_id, term_id, attendance_type, component_id, total_sessions, attended_sessions, percentage, eligibility_status, threshold_required, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: attendance_summary; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.attendance_summary (id, student_id, term_id, quadrant_id, total_sessions, attended_sessions, last_updated) FROM stdin;
\.


--
-- Data for Name: audit_logs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.audit_logs (id, user_id, action, entity_type, entity_id, old_values, new_values, ip_address, user_agent, created_at) FROM stdin;
cb921f4d-ad78-49ac-9bb2-f7aadd5f6021	\N	MIGRATION_START	SYSTEM	\N	\N	{"migration": "smart_batch_progression"}	\N	\N	2025-07-13 15:21:03.197345
\.


--
-- Data for Name: backup_batches; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.backup_batches (id, name, year, start_date, end_date, is_active, created_at) FROM stdin;
6322629c-643e-458b-9347-8b389f655a90	PGDM 2024	2024	2024-01-01	2024-12-31	t	2025-06-13 17:52:27.073051
f9294daf-2956-42b5-bba7-d5e11b23dcee	PGDM 2025	2025	2025-01-01	2025-12-31	t	2025-06-13 18:04:58.849546
4414fd0e-692d-4ad8-9f3c-2dbc6b292fd7	Batch 2024	2024	2024-01-01	2024-12-31	t	2025-06-14 04:29:18.714389
\.


--
-- Data for Name: backup_students; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.backup_students (id, user_id, registration_no, name, course, batch_id, section_id, house_id, gender, phone, preferences, overall_score, grade, status, created_at, updated_at, current_term_id) FROM stdin;
4be88d4d-0ba8-4d64-9df1-ae9b2cea75e7	936d859b-317e-444b-8d5e-42c5a7ffa978	PGDM24003	Mike Johnson	PGDM	6322629c-643e-458b-9347-8b389f655a90	05ae4c96-12ca-4ed2-ab66-8ed3025036c6	a0e117c0-232b-4c70-aa39-6830184c34ed	Male	+91 9876543212	{}	92.75	A+	Active	2025-06-13 18:04:58.849546	2025-07-11 11:49:45.845692	7c08f415-fa83-476f-936c-a4e0a2a6e10c
d3dad72f-6aea-4df8-ad96-438ef61d14d7	6240aad4-227d-448c-85f0-69ac0130538b	TEST001	Updated Test Student 2	General Course	4414fd0e-692d-4ad8-9f3c-2dbc6b292fd7	a5daefdb-0011-424b-8557-5abc257ece5d	b8b46b58-43bc-46fc-a571-ce9dd3f4f5d7	Male	+9876543210	{"address": "456 New Street", "date_of_birth": "2000-02-02", "emergency_contact_name": "New Emergency Contact", "emergency_contact_phone": "+9876543211"}	0.00	IC	Active	2025-06-14 19:19:07.839168	2025-07-11 11:49:45.845692	7c08f415-fa83-476f-936c-a4e0a2a6e10c
6adaf3c7-3bb5-459d-a5a5-f43e9374a376	0d4f033c-be02-4c59-9609-056a6872a2a4	2024001	Test Student	General Course	4414fd0e-692d-4ad8-9f3c-2dbc6b292fd7	a5daefdb-0011-424b-8557-5abc257ece5d	b8b46b58-43bc-46fc-a571-ce9dd3f4f5d7	Male	+1234567890	{"address": "123 Test Street", "date_of_birth": "2000-01-01", "emergency_contact_name": "Emergency Contact", "emergency_contact_phone": "+1234567891"}	0.00	IC	Active	2025-06-16 21:18:01.025946	2025-07-11 11:49:45.845692	7c08f415-fa83-476f-936c-a4e0a2a6e10c
61f681f0-f678-4594-9ed2-593e48743fb1	71ff6d38-afe3-4eaa-8f85-a98eb0e09033	2334	Ajith Kumar	PGDM	6322629c-643e-458b-9347-8b389f655a90	bda4bf18-c059-4b40-86eb-d1854cc88720	bde1d487-a6ca-455e-9f22-99c415576632	Male	+91-9876543210	{}	95.00	A+	Active	2025-06-23 10:09:20.835614	2025-07-11 11:49:45.845692	7c08f415-fa83-476f-936c-a4e0a2a6e10c
e40b09ba-be85-4364-9e2e-2e03b4116ea3	4bd1b5bc-95e0-4188-a13a-969e572031b8	2335	Rohan Sharma	PGDM	6322629c-643e-458b-9347-8b389f655a90	bda4bf18-c059-4b40-86eb-d1854cc88720	402da889-3756-4f0c-af6b-f32e0f0afc8b	Male	+91-9876543211	{}	97.00	A+	Active	2025-06-23 10:09:20.982277	2025-07-11 11:49:45.845692	7c08f415-fa83-476f-936c-a4e0a2a6e10c
2e8b3074-577b-41d8-bf01-0bddcd655f43	65a02a92-93cc-4989-84dc-9e613edacf63	2336	Priya Mehta	PGDM	6322629c-643e-458b-9347-8b389f655a90	05ae4c96-12ca-4ed2-ab66-8ed3025036c6	a0e117c0-232b-4c70-aa39-6830184c34ed	Female	+91-9876543212	{}	96.00	A+	Active	2025-06-23 10:09:21.070903	2025-07-11 11:49:45.845692	7c08f415-fa83-476f-936c-a4e0a2a6e10c
7f21c6a9-aa16-40d8-b047-fc62c19d00af	489ff7ac-6131-4555-ba7c-534410764542	PGDM24002	Jane Smith	PGDM	6322629c-643e-458b-9347-8b389f655a90	bda4bf18-c059-4b40-86eb-d1854cc88720	402da889-3756-4f0c-af6b-f32e0f0afc8b	Female	+91 9876543222	{"darkMode": true, "notifyScores": false}	78.25	B	Active	2025-06-13 18:04:58.849546	2025-07-11 11:49:45.845692	7c08f415-fa83-476f-936c-a4e0a2a6e10c
92722982-a894-4c72-81b7-6615cbb3d8e1	67d4ebf0-4f32-4835-9fb6-0787c2a53b76	TEST005	Test Student 5	PGDM	6322629c-643e-458b-9347-8b389f655a90	bda4bf18-c059-4b40-86eb-d1854cc88720	\N	Male	\N	{}	0.00	IC	Active	2025-07-02 09:22:27.88063	2025-07-11 11:49:45.845692	7c08f415-fa83-476f-936c-a4e0a2a6e10c
d4bdbfb9-769c-459c-b4e1-bebb26fd665b	9505cf24-5c7b-444e-907b-b90792dd2705	TEST002	Test User 2	General Course	4414fd0e-692d-4ad8-9f3c-2dbc6b292fd7	a5daefdb-0011-424b-8557-5abc257ece5d	b8b46b58-43bc-46fc-a571-ce9dd3f4f5d7	Male	+1234567890	{"address": "123 Test Street", "date_of_birth": "2000-01-01", "emergency_contact_name": "Emergency Contact", "emergency_contact_phone": "+1234567891"}	50.00	IC	Active	2025-06-16 18:41:19.84904	2025-07-11 15:11:59.593711	7c08f415-fa83-476f-936c-a4e0a2a6e10c
8156f178-3330-4ee5-b1e4-7d42b6aaa936	78b6c6d9-fadf-4573-8c69-f929000583cb	16515615	lkn yfytfyt	jubuin	4414fd0e-692d-4ad8-9f3c-2dbc6b292fd7	05ae4c96-12ca-4ed2-ab66-8ed3025036c6	\N	Female		{}	90.00	IC	Active	2025-06-28 16:24:41.122377	2025-07-11 15:11:59.593711	7c08f415-fa83-476f-936c-a4e0a2a6e10c
085339af-ae22-4516-bb7e-3710c747b292	6385b486-0f50-4adb-a929-c56dbd347a70	TEST123	Test Student	PGDM	6322629c-643e-458b-9347-8b389f655a90	bda4bf18-c059-4b40-86eb-d1854cc88720	\N	Male	+1234567890	{}	100.00	IC	Active	2025-06-24 16:30:07.895343	2025-07-11 15:11:59.593711	7c08f415-fa83-476f-936c-a4e0a2a6e10c
cadd1c0f-daf4-4a19-b9b2-d30a0f1c7728	29810ef4-ce6c-47c3-a685-d46987a20208	2337	Arjun Patel	PGDM	6322629c-643e-458b-9347-8b389f655a90	05ae4c96-12ca-4ed2-ab66-8ed3025036c6	bde1d487-a6ca-455e-9f22-99c415576632	Male	+91-9876543213	{}	85.00	A	Active	2025-06-23 10:09:21.129583	2025-07-11 15:11:59.593711	7c08f415-fa83-476f-936c-a4e0a2a6e10c
b209213f-9bff-462f-a788-11db4d6abb96	33fce9ad-6f48-4d6d-8115-67e751f75212	1520	srihari.kanyaboina Kanyaboina	General	6322629c-643e-458b-9347-8b389f655a90	bda4bf18-c059-4b40-86eb-d1854cc88720	\N	Male	+91 9876543210	{}	0.00	IC	Active	2025-07-11 11:34:05.145079	2025-07-12 06:18:08.08958	b0d1e6de-6c75-4f9c-ae72-17c1b5dfa3bf
a50cb48b-cca9-469f-855e-f09dee8facb9	4f0f8414-44b9-4882-a322-4392a24466f0	1093	Thejus Kartha	General	\N	\N	\N	\N	\N	{}	0.00	IC	Active	2025-07-12 04:53:30.809332	2025-07-12 06:41:20.868499	7c08f415-fa83-476f-936c-a4e0a2a6e10c
7a67a808-e8ec-4022-9a49-077a75b939fe	1103f718-aa90-4230-b092-f627cd6e01cc	2022OCTVUGP0000	Srihari Srinivas	BTECH	4414fd0e-692d-4ad8-9f3c-2dbc6b292fd7	42f6f3b8-9a6e-4d7c-91b7-d046543f83c4	402da889-3756-4f0c-af6b-f32e0f0afc8b	Male	8104282778	{"emergency_contact_name": "asesvf", "emergency_contact_phone": "sa"}	16.84	IC	Active	2025-06-30 06:21:29.428523	2025-07-12 06:41:34.410371	7c08f415-fa83-476f-936c-a4e0a2a6e10c
ada432e7-90a7-4aa0-8243-27546633a443	7308e92d-31fe-4bb3-8481-cbcad5ea80c2	qwert1234	Divyashree svb	General	f9294daf-2956-42b5-bba7-d5e11b23dcee	42f6f3b8-9a6e-4d7c-91b7-d046543f83c4	\N	Female	1234567890	{}	0.00	IC	Active	2025-07-12 06:48:23.779449	2025-07-12 06:48:23.779449	b0d1e6de-6c75-4f9c-ae72-17c1b5dfa3bf
\.


--
-- Data for Name: backup_terms; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.backup_terms (id, name, description, start_date, end_date, is_active, is_current, academic_year, created_at) FROM stdin;
733c5378-7278-4a4d-a2c8-14855370b33f	Term 1 / Level 0	First term of the academic year	2024-01-01	2024-06-30	t	f	2024	2025-06-13 17:52:27.073051
03b35f5a-babc-4863-871c-471606daaa17	Term 1		2025-04-01	2025-06-30	t	f	2025	2025-07-01 13:36:40.34001
6e697a94-4354-4961-8194-e76a45681f12	Term 4	Festive Term	2025-07-18	2025-09-30	t	f	2025	2025-07-03 11:48:19.117691
863bf5b0-c7c7-436f-9c9b-364ced18ed68	Term 2		2025-07-01	2025-09-30	t	f	2025	2025-06-30 16:30:50.382488
7c08f415-fa83-476f-936c-a4e0a2a6e10c	Term 3		2024-07-03	2024-07-17	t	f	2025	2025-07-03 06:16:41.880867
62cbc472-9175-4c95-b9f7-3fb0e2abca2f	Festive Term 2025	xdgtfgt	2025-10-01	2025-12-01	t	f	2025	2025-07-12 05:25:47.876186
b0d1e6de-6c75-4f9c-ae72-17c1b5dfa3bf	Term 3		2025-10-01	2025-12-01	t	t	2025	2025-07-01 16:08:12.171018
\.


--
-- Data for Name: batch_term_component_weightages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.batch_term_component_weightages (id, config_id, component_id, weightage, max_score, minimum_score, created_at, updated_at) FROM stdin;
dc258d03-6bb8-4e10-b4b6-dbcd8eaa34c1	d9dfeb65-9d58-476b-8a71-61df3af839b6	34c05a81-5261-49cc-a48e-74beeffbbde9	100.00	5.00	0.00	2025-10-09 05:44:04.879485	2025-10-09 05:44:04.879485
3eb43121-abb3-4930-a501-3302c348e08e	d9dfeb65-9d58-476b-8a71-61df3af839b6	4c6ad1ae-7165-432e-a915-4102082c36cf	100.00	5.00	0.00	2025-10-09 05:44:04.879485	2025-10-09 05:44:04.879485
9efe7316-0014-426a-9af4-2efa6b455cb4	d9dfeb65-9d58-476b-8a71-61df3af839b6	5bd8fc59-1862-48bf-abf0-428da25a1b07	100.00	5.00	0.00	2025-10-09 05:44:04.879485	2025-10-09 05:44:04.879485
7c9bd880-ab9e-4a11-9d15-9fe6a7f40a28	d9dfeb65-9d58-476b-8a71-61df3af839b6	33a34606-c38f-41b4-b177-018d32e147fe	100.00	5.00	0.00	2025-10-09 05:44:04.879485	2025-10-09 05:44:04.879485
a2f8a31b-d37b-49de-a703-0de87e58cc42	d9dfeb65-9d58-476b-8a71-61df3af839b6	dbbfaec0-c416-4124-8e84-0e6fd939b203	100.00	5.00	0.00	2025-10-09 05:44:04.879485	2025-10-09 05:44:04.879485
00d54c0c-9b10-48a8-8c19-cc03a9009861	d9dfeb65-9d58-476b-8a71-61df3af839b6	5f879989-7fbb-420c-b532-31939fb64bf3	100.00	5.00	0.00	2025-10-09 05:44:04.879485	2025-10-09 05:44:04.879485
a5fa4556-a495-487e-8f8e-9ee6c191cd40	d9dfeb65-9d58-476b-8a71-61df3af839b6	1e184ce2-e271-4666-b316-cbdf446b6ff1	100.00	5.00	0.00	2025-10-09 05:44:04.879485	2025-10-09 05:44:04.879485
189d2272-63df-440e-8bea-6597ba05afeb	d9dfeb65-9d58-476b-8a71-61df3af839b6	942dd95e-c3cc-4d75-872f-10284d06bc0c	100.00	5.00	0.00	2025-10-09 05:44:04.879485	2025-10-09 05:44:04.879485
8b87720b-9004-472b-8da6-152c649eda0d	d9dfeb65-9d58-476b-8a71-61df3af839b6	61b99470-5e1d-4e02-9d4c-22836faca5f6	100.00	5.00	0.00	2025-10-09 05:44:04.879485	2025-10-09 05:44:04.879485
0b515aeb-9557-4d94-bda5-0a6887e93c7b	d9dfeb65-9d58-476b-8a71-61df3af839b6	6d9537fa-408f-458f-8ce4-df168aca82b3	100.00	5.00	0.00	2025-10-09 05:44:04.879485	2025-10-09 05:44:04.879485
ad6f9d06-703e-4c38-a18f-e5b2911b10ba	d9dfeb65-9d58-476b-8a71-61df3af839b6	b464cb43-8128-4edd-8bc3-5ff6b58e7026	100.00	5.00	0.00	2025-10-09 05:44:04.879485	2025-10-09 05:44:04.879485
db5afb67-cbbf-4a26-b317-c6150feec282	d9dfeb65-9d58-476b-8a71-61df3af839b6	04c55953-826b-41f9-81fc-6a7a8edbca62	100.00	5.00	0.00	2025-10-09 05:44:04.879485	2025-10-09 05:44:04.879485
83769a8b-c33d-414c-8a1a-0e935dd488a9	d9dfeb65-9d58-476b-8a71-61df3af839b6	4dfe00e4-716a-4358-8185-f9672ddf7ad3	100.00	5.00	0.00	2025-10-09 05:44:04.879485	2025-10-09 05:44:04.879485
76f66c5d-e40f-4e4d-b8d1-9a07349969d5	d9dfeb65-9d58-476b-8a71-61df3af839b6	47a5b091-72ec-47d9-9028-c2e80a1dfa4c	100.00	5.00	0.00	2025-10-09 05:44:04.879485	2025-10-09 05:44:04.879485
8f2e7d20-67cf-426f-aef2-ab7eb3fde4de	d9dfeb65-9d58-476b-8a71-61df3af839b6	08273004-dc4c-4738-8740-507d23ac7c22	100.00	5.00	0.00	2025-10-09 05:44:04.879485	2025-10-09 05:44:04.879485
d6097de3-4f5a-43e3-958e-2517abd46298	d9dfeb65-9d58-476b-8a71-61df3af839b6	72115e64-922a-4df2-a20e-aadebbb0eab3	100.00	5.00	0.00	2025-10-09 05:44:04.879485	2025-10-09 05:44:04.879485
a716f3d6-5896-4f6c-bc48-4faefc07c16d	d9dfeb65-9d58-476b-8a71-61df3af839b6	9ec8e344-1032-47ff-8c4e-e52c721f6150	100.00	5.00	0.00	2025-10-09 05:44:04.879485	2025-10-09 05:44:04.879485
e3188353-860f-49ef-8387-31de40ea5e4a	94907b83-1c4f-4ed4-8104-597b6924576c	34c05a81-5261-49cc-a48e-74beeffbbde9	100.00	5.00	0.00	2025-10-09 05:47:01.828562	2025-10-09 05:47:01.828562
56bd2031-1af9-4e69-a175-400ef9a0f2b8	94907b83-1c4f-4ed4-8104-597b6924576c	4c6ad1ae-7165-432e-a915-4102082c36cf	100.00	5.00	0.00	2025-10-09 05:47:01.828562	2025-10-09 05:47:01.828562
9c487d34-1e05-4a56-9f36-fadcb87bf5d6	94907b83-1c4f-4ed4-8104-597b6924576c	5bd8fc59-1862-48bf-abf0-428da25a1b07	100.00	5.00	0.00	2025-10-09 05:47:01.828562	2025-10-09 05:47:01.828562
d8200f88-e7f8-42f6-9b57-69a17131e54f	94907b83-1c4f-4ed4-8104-597b6924576c	33a34606-c38f-41b4-b177-018d32e147fe	100.00	5.00	0.00	2025-10-09 05:47:01.828562	2025-10-09 05:47:01.828562
cbe70854-a6f9-4dfb-ac0b-08fbe77a0e33	94907b83-1c4f-4ed4-8104-597b6924576c	dbbfaec0-c416-4124-8e84-0e6fd939b203	100.00	5.00	0.00	2025-10-09 05:47:01.828562	2025-10-09 05:47:01.828562
e7a8644c-07f1-4658-b004-ef59373a7dbe	94907b83-1c4f-4ed4-8104-597b6924576c	5f879989-7fbb-420c-b532-31939fb64bf3	100.00	5.00	0.00	2025-10-09 05:47:01.828562	2025-10-09 05:47:01.828562
d1d7e75c-fee8-4ceb-8654-ee4137fa8980	94907b83-1c4f-4ed4-8104-597b6924576c	1e184ce2-e271-4666-b316-cbdf446b6ff1	100.00	5.00	0.00	2025-10-09 05:47:01.828562	2025-10-09 05:47:01.828562
0776f949-b2f3-4460-8a28-17b7383bcbf6	94907b83-1c4f-4ed4-8104-597b6924576c	942dd95e-c3cc-4d75-872f-10284d06bc0c	100.00	5.00	0.00	2025-10-09 05:47:01.828562	2025-10-09 05:47:01.828562
4ef4d8df-6dcd-470d-8e33-f511b86336e5	94907b83-1c4f-4ed4-8104-597b6924576c	61b99470-5e1d-4e02-9d4c-22836faca5f6	100.00	5.00	0.00	2025-10-09 05:47:01.828562	2025-10-09 05:47:01.828562
ba31aa83-5399-4aff-ab44-e48a6b5e8933	94907b83-1c4f-4ed4-8104-597b6924576c	6d9537fa-408f-458f-8ce4-df168aca82b3	100.00	5.00	0.00	2025-10-09 05:47:01.828562	2025-10-09 05:47:01.828562
30834456-c493-433c-bd58-c5f021039868	94907b83-1c4f-4ed4-8104-597b6924576c	b464cb43-8128-4edd-8bc3-5ff6b58e7026	100.00	5.00	0.00	2025-10-09 05:47:01.828562	2025-10-09 05:47:01.828562
50b6816a-059e-475f-b51b-1a95a9617ead	94907b83-1c4f-4ed4-8104-597b6924576c	04c55953-826b-41f9-81fc-6a7a8edbca62	100.00	5.00	0.00	2025-10-09 05:47:01.828562	2025-10-09 05:47:01.828562
9bbecb66-27ac-4570-bc77-8a229fc6eab4	94907b83-1c4f-4ed4-8104-597b6924576c	4dfe00e4-716a-4358-8185-f9672ddf7ad3	100.00	5.00	0.00	2025-10-09 05:47:01.828562	2025-10-09 05:47:01.828562
9a7c1a8c-f3bd-4268-b8d5-252df24f2d05	94907b83-1c4f-4ed4-8104-597b6924576c	47a5b091-72ec-47d9-9028-c2e80a1dfa4c	100.00	5.00	0.00	2025-10-09 05:47:01.828562	2025-10-09 05:47:01.828562
efacdcc1-587c-4040-8742-3a4240820008	94907b83-1c4f-4ed4-8104-597b6924576c	08273004-dc4c-4738-8740-507d23ac7c22	100.00	5.00	0.00	2025-10-09 05:47:01.828562	2025-10-09 05:47:01.828562
2a1c7343-f4ec-422b-9f93-1863ef46c210	94907b83-1c4f-4ed4-8104-597b6924576c	72115e64-922a-4df2-a20e-aadebbb0eab3	100.00	5.00	0.00	2025-10-09 05:47:01.828562	2025-10-09 05:47:01.828562
b0392e56-34b6-46cb-bb60-181d071324d6	94907b83-1c4f-4ed4-8104-597b6924576c	9ec8e344-1032-47ff-8c4e-e52c721f6150	100.00	5.00	0.00	2025-10-09 05:47:01.828562	2025-10-09 05:47:01.828562
\.


--
-- Data for Name: batch_term_microcompetency_weightages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.batch_term_microcompetency_weightages (id, config_id, microcompetency_id, weightage, max_score, created_at, updated_at) FROM stdin;
49b7f3a8-a150-4d61-9ff5-de2905758d9f	d9dfeb65-9d58-476b-8a71-61df3af839b6	4476c3a6-58da-4c43-9b8a-b1da70172072	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
966bf348-46bf-46a8-a3e6-f5c265fcdc74	d9dfeb65-9d58-476b-8a71-61df3af839b6	31a4c844-6a46-4b57-a23d-91d9a5ff7382	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
f146945d-23e8-4666-b582-b9ca28da48f5	d9dfeb65-9d58-476b-8a71-61df3af839b6	4d6b4184-d62e-427a-ba00-16ff3f4e4f10	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
11eb8e79-8bf6-4d67-9b4c-bb82e95f81e9	d9dfeb65-9d58-476b-8a71-61df3af839b6	06947927-aab0-4d24-b5fe-b42c0b83050c	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
e1891d27-5384-464f-93ed-71d80d6d84fb	d9dfeb65-9d58-476b-8a71-61df3af839b6	6ef0dc2b-9fd6-40e2-a2c6-2485232d953c	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
71f49fce-1b86-4627-bff6-875d55302e39	d9dfeb65-9d58-476b-8a71-61df3af839b6	7e8983cd-5a94-49cc-9b80-64358a9d48f9	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
db657c05-562c-49fe-b543-f7cca2c23d0a	d9dfeb65-9d58-476b-8a71-61df3af839b6	685d23ad-eadc-47ac-9f91-8f741ae4211f	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
3eca29b6-c6df-4e3b-a6f9-62c17c563dc9	d9dfeb65-9d58-476b-8a71-61df3af839b6	2e599a1f-e34d-436c-98f9-01f019cb29bd	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
b4439c46-368e-481d-b4cc-83d9d2146994	d9dfeb65-9d58-476b-8a71-61df3af839b6	1b63c6c1-36b6-49b5-a61f-1c3f2b85bdb1	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
307bf0f0-c957-4c3e-a81d-169df53e2968	d9dfeb65-9d58-476b-8a71-61df3af839b6	44a43cc4-8d2e-4ce5-b437-2b76a205ea84	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
21e3276f-4cbc-4fcf-851e-a5066363375d	d9dfeb65-9d58-476b-8a71-61df3af839b6	08314805-8508-4254-997b-a035415747d5	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
1b3e2a2e-8fd4-4d3c-b750-984a4343b845	d9dfeb65-9d58-476b-8a71-61df3af839b6	9077e1c0-d24a-4477-983a-6b8aeaa43532	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
8fca9704-6080-4974-9c7d-3eaa146b1e01	d9dfeb65-9d58-476b-8a71-61df3af839b6	64be578a-9f8e-4795-aeae-1b5dac189cce	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
af366d39-9bf6-498f-b573-84b69eb19d6a	d9dfeb65-9d58-476b-8a71-61df3af839b6	be2ca789-8ed3-4c6f-808a-1dfb50c19877	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
ba123271-7fd1-43cc-81f2-afddbce8e369	d9dfeb65-9d58-476b-8a71-61df3af839b6	448cb56a-e4d6-44c4-a49b-8a6119f36843	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
ac65fc70-4d13-4207-8782-b7f877a9c918	d9dfeb65-9d58-476b-8a71-61df3af839b6	5a1ffe37-852a-4e75-96c8-5353fdbf9011	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
da27f956-480a-44d9-b726-738a8ab7d344	d9dfeb65-9d58-476b-8a71-61df3af839b6	4680bc8d-b6f0-40e3-ba26-a05e68d21f14	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
bab9cc40-b958-4c60-bc0b-38185ebc8b82	d9dfeb65-9d58-476b-8a71-61df3af839b6	9ceb0bdb-9f21-40da-b938-c7729ff2daa3	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
fe531d99-4e05-429f-b03c-bda7545e49a3	d9dfeb65-9d58-476b-8a71-61df3af839b6	a48a6338-402d-482e-8d7a-b7193d97047a	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
7b31f56d-7af5-4634-a1a8-b296a35dd686	d9dfeb65-9d58-476b-8a71-61df3af839b6	55fa8528-6b9c-4f3c-9fb2-6de44c5d9cf0	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
2f92aa61-5403-4001-aeed-6c3a5f54f767	d9dfeb65-9d58-476b-8a71-61df3af839b6	457db1c7-044e-47a7-a820-e1e5114f9cea	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
9b0cc4e4-f7d4-4a97-b052-974c7c91d30f	d9dfeb65-9d58-476b-8a71-61df3af839b6	31509ddf-18ee-4538-a2eb-5bbe560c0914	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
97ff1f3f-e90e-4e01-aeaa-2f333476e00e	d9dfeb65-9d58-476b-8a71-61df3af839b6	698deda3-2aa9-4d4f-8a14-2fb80faac986	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
5ea4c646-0626-4e81-b0c1-19112c8dce41	d9dfeb65-9d58-476b-8a71-61df3af839b6	3f488cd4-bad3-46ec-9f92-1957e2924774	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
4dbcbf55-a179-4d69-9737-9946dd740171	d9dfeb65-9d58-476b-8a71-61df3af839b6	6dad3ff1-9da6-4efd-9549-e8b4654529c7	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
2202ebfa-71a5-404c-adf2-9b12c8590670	d9dfeb65-9d58-476b-8a71-61df3af839b6	74771254-6da7-4ea1-a8b9-7ad3c99d75db	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
550afc0d-293d-4931-8454-6d2e070be165	d9dfeb65-9d58-476b-8a71-61df3af839b6	a8953d15-fdda-490c-8a8e-1372f25c0a33	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
ca89c12e-b191-47d6-9064-b543134e76d0	d9dfeb65-9d58-476b-8a71-61df3af839b6	76e855c0-ec81-4eae-a010-0e23b76426f1	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
d8895db2-d012-427b-9fcb-3da4236ef352	d9dfeb65-9d58-476b-8a71-61df3af839b6	810f1b09-7630-4260-bf7e-5fa910cbb3dc	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
dffdfc2b-c484-4a73-8225-87735bfb50d1	d9dfeb65-9d58-476b-8a71-61df3af839b6	01c4c2d4-ab2f-480f-b145-442ae56fad48	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
2ef4f1c4-f837-4bf4-994b-cc16c4894916	d9dfeb65-9d58-476b-8a71-61df3af839b6	2d2976b5-f9bb-42e8-aca0-d6e6b6e6de77	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
faac9936-c3a0-45b6-b73c-f0909fb5c1a5	d9dfeb65-9d58-476b-8a71-61df3af839b6	22d1a89c-85d5-4403-8330-e34aa6c8b2fc	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
ec708dd3-53e6-458b-b2b8-4769f061c25e	d9dfeb65-9d58-476b-8a71-61df3af839b6	7082bb51-3094-4606-8f92-106a1820e380	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
f35abd4e-f4b6-4590-b0c6-32f96b878d0b	d9dfeb65-9d58-476b-8a71-61df3af839b6	101eb49e-efd6-4def-9a1f-11dce221cdba	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
e50db9df-1236-4902-b175-ad83ec00de09	d9dfeb65-9d58-476b-8a71-61df3af839b6	c030fd4f-5f7b-46ad-84b7-631adbeb1f40	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
c61dd688-2219-4217-a7b0-4ecd268f67d4	d9dfeb65-9d58-476b-8a71-61df3af839b6	adbc17f9-6f88-4144-afe1-e29f3a0bd21e	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
41673b6c-77f6-4eda-a924-69a46f6090e8	d9dfeb65-9d58-476b-8a71-61df3af839b6	bcb48067-c6be-4c39-87bc-08618f18ef4e	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
4a79b135-110b-4f7d-893c-55f92e55da74	d9dfeb65-9d58-476b-8a71-61df3af839b6	955efb94-7eac-4392-969a-732f19143f89	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
8d4b027b-f191-4e64-b7af-5241c3c42f1f	d9dfeb65-9d58-476b-8a71-61df3af839b6	45cfe4d4-2cc1-4dd3-b5a8-67ecc9d243c9	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
87fbac44-5437-46d5-bd5e-f7e303138a37	d9dfeb65-9d58-476b-8a71-61df3af839b6	cb21ea38-e7ad-4f8d-b4c4-33f892cd9119	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
624327f6-c85f-46d6-9405-d9a1276a6331	d9dfeb65-9d58-476b-8a71-61df3af839b6	3554e4f4-8d4c-4b4a-9fe6-88eb1f5ef489	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
34394c9e-2569-466d-a42e-d2ebe9432977	d9dfeb65-9d58-476b-8a71-61df3af839b6	f7be1839-a795-438b-b9da-54fed97ca1d7	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
2218db9f-5708-44ef-a6b1-3c2926f1722a	d9dfeb65-9d58-476b-8a71-61df3af839b6	3da28c94-987a-419d-ac12-822d05bd8448	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
ce471121-668b-49ab-9c5b-d2be7f4567e4	d9dfeb65-9d58-476b-8a71-61df3af839b6	c42f0ccc-e7e4-447b-b392-ecd3eca5d764	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
66bb8f8a-599a-4707-9234-c59aa7ca2984	d9dfeb65-9d58-476b-8a71-61df3af839b6	544af37f-9528-4ef3-bc99-5870532c51d5	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
b4eb88df-26a6-4815-af7a-faeecd574ff6	d9dfeb65-9d58-476b-8a71-61df3af839b6	d3660cf9-b4c4-4c12-bba3-766c128a43ac	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
0da62765-604a-4506-b317-bdf25a89a464	d9dfeb65-9d58-476b-8a71-61df3af839b6	a0ce1af3-fabf-4a1a-851e-edb00cd10f22	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
495131be-aefb-4a03-a9b2-feafe7a180fb	d9dfeb65-9d58-476b-8a71-61df3af839b6	d69b272d-0f08-4157-8db3-43ba94def224	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
fa6c4b68-820c-4b40-a039-9c2ae7532810	d9dfeb65-9d58-476b-8a71-61df3af839b6	3e8102b3-e71f-4739-8682-b5ebcbdbd6a5	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
834901aa-178f-428b-ae16-5cb9eae3afe0	d9dfeb65-9d58-476b-8a71-61df3af839b6	cd6c3b70-cdbb-47c6-b1bb-d3236ee53d03	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
345948cf-8296-46c5-9bf2-47e5d7557e13	d9dfeb65-9d58-476b-8a71-61df3af839b6	4624333f-29fe-4075-9023-9526c56f1783	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
0ef04986-6653-4190-8d85-6237b0efe74c	d9dfeb65-9d58-476b-8a71-61df3af839b6	2f71659a-9d89-4d70-8319-b6ef85764acf	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
b9a8eb70-75bb-4fdc-b49e-6c02a2e9b0a5	d9dfeb65-9d58-476b-8a71-61df3af839b6	f2cb1b7e-41df-411f-abaa-2ac7cbf58674	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
b4c2be77-3291-4f31-a6ad-84037d3f861e	d9dfeb65-9d58-476b-8a71-61df3af839b6	6f74812e-ca45-4234-9a10-9bfe8f46467c	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
c3e1049d-be3e-4c55-b8f6-114e107ea4bf	d9dfeb65-9d58-476b-8a71-61df3af839b6	0decb9dd-8b4c-471e-97ab-df29e7bb212c	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
e73a2977-659e-499e-ad18-0c89b3e24eca	d9dfeb65-9d58-476b-8a71-61df3af839b6	88fad813-46ed-4601-a334-ae77df797be3	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
8e468a99-1037-4b59-b65c-fa3b8a93d956	d9dfeb65-9d58-476b-8a71-61df3af839b6	9358b2c4-aebc-480a-9eff-6873c156da12	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
fa8bb9d9-784a-451a-bdd0-d79039ef5fa1	d9dfeb65-9d58-476b-8a71-61df3af839b6	d5760d32-ce61-48fd-988e-9bd16cc52ca1	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
b56cf6dc-9287-4337-afa2-7cc5594686b4	d9dfeb65-9d58-476b-8a71-61df3af839b6	7022a346-204b-472a-b46b-b801f07e8853	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
522e86ea-3b46-441d-9993-581dac717663	d9dfeb65-9d58-476b-8a71-61df3af839b6	c26c7d3d-7062-4ac5-a1f5-a69b17724eaa	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
5a639373-96cf-4b39-b3d1-f9da1a2f03c1	d9dfeb65-9d58-476b-8a71-61df3af839b6	6852ffde-5e9e-4faa-be78-93d194b1f8b7	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
9ee68636-8519-49fd-a634-3f1e15b7cc93	d9dfeb65-9d58-476b-8a71-61df3af839b6	de38ca59-7d04-4de2-acfd-6daf46162a07	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
1e122415-29dc-4fa7-b2ee-e7e93ac91831	d9dfeb65-9d58-476b-8a71-61df3af839b6	6350fa4f-4163-42b7-a37a-16be275b9418	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
53ea98fb-1ce8-4c19-a570-8b4a8d6a00f7	d9dfeb65-9d58-476b-8a71-61df3af839b6	7453ffe7-e829-4f52-a16b-44efbc183640	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
6e17c097-e4b1-46fb-a58d-843e7f32169d	d9dfeb65-9d58-476b-8a71-61df3af839b6	fbd8f3d7-1bbe-4e3c-955f-c370b9f7f680	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
0dd9720d-28c6-47e2-9d88-a8115a89d091	d9dfeb65-9d58-476b-8a71-61df3af839b6	569954c7-4f99-425c-9454-45277997273b	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
eff60ca3-a7b0-4e31-93a0-df28b1042397	d9dfeb65-9d58-476b-8a71-61df3af839b6	13936326-3a08-46e7-9577-cfee038577f0	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
ca24bcea-d088-467e-94ad-9f1293b848ad	d9dfeb65-9d58-476b-8a71-61df3af839b6	5fd87c78-5e02-4ec6-8706-1a2678ee90b4	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
f1f16890-180c-4d23-837a-1fad667dc3f5	d9dfeb65-9d58-476b-8a71-61df3af839b6	9136ba3e-9c59-47ab-ab64-67a2f84b74f4	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
be10c1b6-dcd3-4ba1-8fcc-92fa63695c0a	d9dfeb65-9d58-476b-8a71-61df3af839b6	47c94861-1830-4e10-97f0-5f0b5a7f9c05	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
ff45fe63-7854-4e77-bd1b-b2bc1f5130a3	d9dfeb65-9d58-476b-8a71-61df3af839b6	a6fc7ef9-8ebc-47cc-b9b5-48b404599670	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
1e309365-68af-4acf-a833-4782307883f5	d9dfeb65-9d58-476b-8a71-61df3af839b6	5016201d-732e-4a7f-8e7e-c9d3fa3b2030	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
adc1cee7-6821-4294-b975-b92adb8e97d1	d9dfeb65-9d58-476b-8a71-61df3af839b6	10163f9f-5bb3-4bdc-b3c8-9ddf17b2e3b6	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
52f11254-c92a-43a6-af68-d8c9fe0c8772	d9dfeb65-9d58-476b-8a71-61df3af839b6	0322c72d-2fbf-462d-9a59-76e1550b30d9	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
616919b4-4368-4414-bc3e-7884a2ec702f	d9dfeb65-9d58-476b-8a71-61df3af839b6	ec97e568-30d6-4e8f-acb3-b74d1b4b5436	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
7739dc7e-1bb9-4725-aeda-856778fc394d	d9dfeb65-9d58-476b-8a71-61df3af839b6	41ab0a41-f16e-4bd5-961e-5b070acd6410	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
1751ae62-b8bd-485e-aea2-419e90f5370c	d9dfeb65-9d58-476b-8a71-61df3af839b6	b2e23679-040c-4d57-9ab7-4a019c00652a	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
ac4ecdeb-36df-4a6c-baa3-24c7e6e90f86	d9dfeb65-9d58-476b-8a71-61df3af839b6	7a0abf02-6038-45d0-9a9d-4d0a25e44019	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
0c046823-0c54-498e-9118-9e7d307edc1f	d9dfeb65-9d58-476b-8a71-61df3af839b6	b7d67908-6205-4863-a694-d7dba56e1d39	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
590508d4-07ff-4404-8b42-ab8ea9ea667e	d9dfeb65-9d58-476b-8a71-61df3af839b6	30b71cb1-97df-4655-8704-0560bcf5da06	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
b5a968d0-995e-4e91-b037-8b083653dd88	d9dfeb65-9d58-476b-8a71-61df3af839b6	f658c2c3-3d12-4798-bccb-9af886cd15eb	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
149e270a-7e6d-43e7-8f34-401b0849a19b	d9dfeb65-9d58-476b-8a71-61df3af839b6	6f903e44-300e-470c-aa64-125da9772880	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
5baa8b52-62dd-4e94-b156-e3f16485501d	d9dfeb65-9d58-476b-8a71-61df3af839b6	24c6259e-6fbf-4a75-a66e-bd8a2894b261	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
cc7b2077-bce6-4649-906c-876c629229cf	d9dfeb65-9d58-476b-8a71-61df3af839b6	a2287dfb-4153-4222-91dd-5ab86abcd82a	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
2a482681-ef8a-4171-abd3-8599d7bf28ea	d9dfeb65-9d58-476b-8a71-61df3af839b6	77c73ecd-3988-4efa-af44-efe3725e9f14	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
046cb0e9-fd50-4e3e-b7ea-94879b11601c	d9dfeb65-9d58-476b-8a71-61df3af839b6	3125cce7-fab5-4000-a4ec-d6cb3069e730	100.00	5.00	2025-10-09 05:44:04.938371	2025-10-09 05:44:04.938371
d477e1e0-b3d1-43da-8603-3744e06f6361	94907b83-1c4f-4ed4-8104-597b6924576c	4476c3a6-58da-4c43-9b8a-b1da70172072	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
cb9ff738-5a3e-4fe5-ac7d-37151bf5b527	94907b83-1c4f-4ed4-8104-597b6924576c	31a4c844-6a46-4b57-a23d-91d9a5ff7382	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
8e92e2b7-22db-4cb0-96aa-ca4ec413a408	94907b83-1c4f-4ed4-8104-597b6924576c	4d6b4184-d62e-427a-ba00-16ff3f4e4f10	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
31b9aeac-40dc-492a-bb92-58d5a8a4e8bf	94907b83-1c4f-4ed4-8104-597b6924576c	06947927-aab0-4d24-b5fe-b42c0b83050c	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
cb02cf17-23dc-4e67-b7c8-f1b5b0c77531	94907b83-1c4f-4ed4-8104-597b6924576c	6ef0dc2b-9fd6-40e2-a2c6-2485232d953c	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
e073699c-0122-47b0-9ee0-952773e678bc	94907b83-1c4f-4ed4-8104-597b6924576c	7e8983cd-5a94-49cc-9b80-64358a9d48f9	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
c4ef193c-3a69-49cf-9ccf-9b0a5118b3f2	94907b83-1c4f-4ed4-8104-597b6924576c	685d23ad-eadc-47ac-9f91-8f741ae4211f	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
02dc26af-5c51-4957-aa11-14298e28763b	94907b83-1c4f-4ed4-8104-597b6924576c	2e599a1f-e34d-436c-98f9-01f019cb29bd	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
3372a2d6-c7e1-45a4-9eff-b735302d2046	94907b83-1c4f-4ed4-8104-597b6924576c	1b63c6c1-36b6-49b5-a61f-1c3f2b85bdb1	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
88febb6a-6876-4823-ba72-0f8ce3c9e38e	94907b83-1c4f-4ed4-8104-597b6924576c	44a43cc4-8d2e-4ce5-b437-2b76a205ea84	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
6b36e64f-5f11-4ade-a128-26abc19ccd2e	94907b83-1c4f-4ed4-8104-597b6924576c	08314805-8508-4254-997b-a035415747d5	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
0eb4dd21-7835-44be-a720-4860a600abce	94907b83-1c4f-4ed4-8104-597b6924576c	9077e1c0-d24a-4477-983a-6b8aeaa43532	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
73f05736-649c-44b9-91ff-b2fbda303496	94907b83-1c4f-4ed4-8104-597b6924576c	64be578a-9f8e-4795-aeae-1b5dac189cce	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
6241b540-4e79-48e6-afdb-9716fe5a4218	94907b83-1c4f-4ed4-8104-597b6924576c	be2ca789-8ed3-4c6f-808a-1dfb50c19877	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
c69632f7-7e2e-4b96-821a-2c9fdacecbfb	94907b83-1c4f-4ed4-8104-597b6924576c	448cb56a-e4d6-44c4-a49b-8a6119f36843	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
e3905dce-196e-45e3-b122-4b6e201c2a2d	94907b83-1c4f-4ed4-8104-597b6924576c	5a1ffe37-852a-4e75-96c8-5353fdbf9011	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
9d1e564b-dc4a-47e0-b064-b00684cc1e22	94907b83-1c4f-4ed4-8104-597b6924576c	4680bc8d-b6f0-40e3-ba26-a05e68d21f14	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
9c750f10-535a-4eba-addc-05222cd59381	94907b83-1c4f-4ed4-8104-597b6924576c	9ceb0bdb-9f21-40da-b938-c7729ff2daa3	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
7dc45b71-c5e8-453c-918b-e4284f7c5797	94907b83-1c4f-4ed4-8104-597b6924576c	a48a6338-402d-482e-8d7a-b7193d97047a	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
d11bed0d-11eb-4a24-9160-b4decdd5d4aa	94907b83-1c4f-4ed4-8104-597b6924576c	55fa8528-6b9c-4f3c-9fb2-6de44c5d9cf0	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
f8c8c4fd-097f-45b5-8867-cd729d93a9f4	94907b83-1c4f-4ed4-8104-597b6924576c	457db1c7-044e-47a7-a820-e1e5114f9cea	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
028fc15d-9c2e-425e-8e82-059364b93ac8	94907b83-1c4f-4ed4-8104-597b6924576c	31509ddf-18ee-4538-a2eb-5bbe560c0914	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
0ef1a716-9eda-4f41-a3dc-85e1755392d8	94907b83-1c4f-4ed4-8104-597b6924576c	698deda3-2aa9-4d4f-8a14-2fb80faac986	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
be9ed53f-74f0-4ef0-a271-0766cd6b974b	94907b83-1c4f-4ed4-8104-597b6924576c	3f488cd4-bad3-46ec-9f92-1957e2924774	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
720b8391-5478-4f01-b975-233aeb343d17	94907b83-1c4f-4ed4-8104-597b6924576c	6dad3ff1-9da6-4efd-9549-e8b4654529c7	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
4051ea8d-ed12-4af1-abc1-890fa5f6a0a0	94907b83-1c4f-4ed4-8104-597b6924576c	74771254-6da7-4ea1-a8b9-7ad3c99d75db	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
683beea8-a6f9-409a-8331-6c0797b6fc1e	94907b83-1c4f-4ed4-8104-597b6924576c	a8953d15-fdda-490c-8a8e-1372f25c0a33	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
d516cacf-5909-4a93-96ee-c60773c70104	94907b83-1c4f-4ed4-8104-597b6924576c	76e855c0-ec81-4eae-a010-0e23b76426f1	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
019f36fe-e100-4da5-b25a-d09abf1278ea	94907b83-1c4f-4ed4-8104-597b6924576c	810f1b09-7630-4260-bf7e-5fa910cbb3dc	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
d9a47d0b-617a-4e7c-ac50-1a150490f748	94907b83-1c4f-4ed4-8104-597b6924576c	01c4c2d4-ab2f-480f-b145-442ae56fad48	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
162640b0-ad03-408e-be90-74f4a8c2cbca	94907b83-1c4f-4ed4-8104-597b6924576c	2d2976b5-f9bb-42e8-aca0-d6e6b6e6de77	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
d1092897-56d3-44e9-8b9a-d9097bccd111	94907b83-1c4f-4ed4-8104-597b6924576c	22d1a89c-85d5-4403-8330-e34aa6c8b2fc	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
1519413c-030d-4f73-9934-3391cd51c00b	94907b83-1c4f-4ed4-8104-597b6924576c	7082bb51-3094-4606-8f92-106a1820e380	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
6bc5abeb-665d-4b19-9782-8ee2a0cbf240	94907b83-1c4f-4ed4-8104-597b6924576c	101eb49e-efd6-4def-9a1f-11dce221cdba	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
1230b02f-7f6e-46a2-9972-54d68475d92b	94907b83-1c4f-4ed4-8104-597b6924576c	c030fd4f-5f7b-46ad-84b7-631adbeb1f40	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
0451f3c6-6e83-420e-b12f-75524b72c9d7	94907b83-1c4f-4ed4-8104-597b6924576c	adbc17f9-6f88-4144-afe1-e29f3a0bd21e	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
549441eb-b0f2-4482-bc12-4cb796d968fe	94907b83-1c4f-4ed4-8104-597b6924576c	bcb48067-c6be-4c39-87bc-08618f18ef4e	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
66964a64-df2a-49e1-9deb-88b7a34a9fb3	94907b83-1c4f-4ed4-8104-597b6924576c	955efb94-7eac-4392-969a-732f19143f89	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
3051b8e9-e266-4f28-a8f2-00e466505a71	94907b83-1c4f-4ed4-8104-597b6924576c	45cfe4d4-2cc1-4dd3-b5a8-67ecc9d243c9	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
1306398d-b749-4152-89fe-af27c0998b25	94907b83-1c4f-4ed4-8104-597b6924576c	cb21ea38-e7ad-4f8d-b4c4-33f892cd9119	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
d8f78ffc-9b60-4772-ab36-e6de81b0bd71	94907b83-1c4f-4ed4-8104-597b6924576c	3554e4f4-8d4c-4b4a-9fe6-88eb1f5ef489	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
0192a619-543a-442d-abd7-c49553af5bc8	94907b83-1c4f-4ed4-8104-597b6924576c	f7be1839-a795-438b-b9da-54fed97ca1d7	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
1e60dc55-2312-46b0-b2ac-c619d55dfa70	94907b83-1c4f-4ed4-8104-597b6924576c	3da28c94-987a-419d-ac12-822d05bd8448	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
32bbbc1a-6b2e-4235-922e-e4ed5b1c6f5a	94907b83-1c4f-4ed4-8104-597b6924576c	c42f0ccc-e7e4-447b-b392-ecd3eca5d764	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
6bf88302-064c-45a4-b902-a83f33659436	94907b83-1c4f-4ed4-8104-597b6924576c	544af37f-9528-4ef3-bc99-5870532c51d5	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
e92767ca-82cb-4799-ad59-c9e18a03213d	94907b83-1c4f-4ed4-8104-597b6924576c	d3660cf9-b4c4-4c12-bba3-766c128a43ac	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
030d0f0d-bc04-4463-898c-74fe6c6cda56	94907b83-1c4f-4ed4-8104-597b6924576c	a0ce1af3-fabf-4a1a-851e-edb00cd10f22	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
a056f478-60d4-4061-ab22-92488426dd85	94907b83-1c4f-4ed4-8104-597b6924576c	d69b272d-0f08-4157-8db3-43ba94def224	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
0d99890b-bce9-4b4d-9d4a-4d6ac04c547f	94907b83-1c4f-4ed4-8104-597b6924576c	3e8102b3-e71f-4739-8682-b5ebcbdbd6a5	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
d43f0146-fd89-4302-bde4-79ec78b47ec0	94907b83-1c4f-4ed4-8104-597b6924576c	cd6c3b70-cdbb-47c6-b1bb-d3236ee53d03	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
ce5bad58-b4a0-44df-8b45-fc51677eda88	94907b83-1c4f-4ed4-8104-597b6924576c	4624333f-29fe-4075-9023-9526c56f1783	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
12ed889c-8022-4482-a5b5-e6d623355014	94907b83-1c4f-4ed4-8104-597b6924576c	2f71659a-9d89-4d70-8319-b6ef85764acf	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
4d354796-8571-4ada-a9fc-9df51194afda	94907b83-1c4f-4ed4-8104-597b6924576c	f2cb1b7e-41df-411f-abaa-2ac7cbf58674	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
08eb4c63-b65c-4c47-b547-3c75185f33f2	94907b83-1c4f-4ed4-8104-597b6924576c	6f74812e-ca45-4234-9a10-9bfe8f46467c	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
074fd73b-c830-4b0f-9193-b2c2deea601c	94907b83-1c4f-4ed4-8104-597b6924576c	0decb9dd-8b4c-471e-97ab-df29e7bb212c	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
3060631f-6f28-4f5e-99f1-61e041d9d2e7	94907b83-1c4f-4ed4-8104-597b6924576c	88fad813-46ed-4601-a334-ae77df797be3	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
cbe29a64-1e6a-4808-b787-b4ede042c04d	94907b83-1c4f-4ed4-8104-597b6924576c	9358b2c4-aebc-480a-9eff-6873c156da12	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
8117a2aa-c38b-4821-b9c4-9ef0c5bcf26e	94907b83-1c4f-4ed4-8104-597b6924576c	d5760d32-ce61-48fd-988e-9bd16cc52ca1	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
111440fb-77c9-4f81-b94a-2f2c428fe8c3	94907b83-1c4f-4ed4-8104-597b6924576c	7022a346-204b-472a-b46b-b801f07e8853	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
64b280e7-2129-4648-93ee-9be118e8e8da	94907b83-1c4f-4ed4-8104-597b6924576c	c26c7d3d-7062-4ac5-a1f5-a69b17724eaa	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
a35d4bdb-4c83-40be-a6e3-ff003463723d	94907b83-1c4f-4ed4-8104-597b6924576c	6852ffde-5e9e-4faa-be78-93d194b1f8b7	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
6346fdd8-490a-4b9e-89e0-36d8ab244df7	94907b83-1c4f-4ed4-8104-597b6924576c	de38ca59-7d04-4de2-acfd-6daf46162a07	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
f7fa712b-d4d9-4fd0-a452-f8ade1824913	94907b83-1c4f-4ed4-8104-597b6924576c	6350fa4f-4163-42b7-a37a-16be275b9418	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
cb424739-7ede-47aa-bb08-4fa562bf03ff	94907b83-1c4f-4ed4-8104-597b6924576c	7453ffe7-e829-4f52-a16b-44efbc183640	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
f5c19963-bf21-493c-ae0f-63c94c21689c	94907b83-1c4f-4ed4-8104-597b6924576c	fbd8f3d7-1bbe-4e3c-955f-c370b9f7f680	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
8e87b0a9-486f-44c9-b6bd-0ac420d14c15	94907b83-1c4f-4ed4-8104-597b6924576c	569954c7-4f99-425c-9454-45277997273b	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
6d39ca5f-4980-459c-b157-e35235904a38	94907b83-1c4f-4ed4-8104-597b6924576c	13936326-3a08-46e7-9577-cfee038577f0	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
7ce097d1-d784-4793-82be-a5d209b00322	94907b83-1c4f-4ed4-8104-597b6924576c	5fd87c78-5e02-4ec6-8706-1a2678ee90b4	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
0b38aa71-a346-4334-b373-616cac2cdc9f	94907b83-1c4f-4ed4-8104-597b6924576c	9136ba3e-9c59-47ab-ab64-67a2f84b74f4	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
094baf35-2f82-4179-993a-42fb295f8309	94907b83-1c4f-4ed4-8104-597b6924576c	47c94861-1830-4e10-97f0-5f0b5a7f9c05	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
37a8bb31-e659-435d-974c-2cc83ee07086	94907b83-1c4f-4ed4-8104-597b6924576c	a6fc7ef9-8ebc-47cc-b9b5-48b404599670	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
abebd724-1f41-4eca-b09c-3bb3604c4e84	94907b83-1c4f-4ed4-8104-597b6924576c	5016201d-732e-4a7f-8e7e-c9d3fa3b2030	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
9d4795b7-5c44-466b-8fd4-7fc5a5c3aaae	94907b83-1c4f-4ed4-8104-597b6924576c	10163f9f-5bb3-4bdc-b3c8-9ddf17b2e3b6	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
78c897ed-03ea-42f9-b4ae-dcbc9acd8b42	94907b83-1c4f-4ed4-8104-597b6924576c	0322c72d-2fbf-462d-9a59-76e1550b30d9	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
b7fad45f-e77d-4e7a-a599-185f5056175f	94907b83-1c4f-4ed4-8104-597b6924576c	ec97e568-30d6-4e8f-acb3-b74d1b4b5436	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
4fd49588-f360-424c-ba3c-6772234efa67	94907b83-1c4f-4ed4-8104-597b6924576c	41ab0a41-f16e-4bd5-961e-5b070acd6410	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
4bdc71cb-c000-4ef3-8abb-fc02bf6b7453	94907b83-1c4f-4ed4-8104-597b6924576c	b2e23679-040c-4d57-9ab7-4a019c00652a	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
9521fd98-bb60-41e6-ad16-0ec7e31bbc96	94907b83-1c4f-4ed4-8104-597b6924576c	7a0abf02-6038-45d0-9a9d-4d0a25e44019	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
0a8e51f6-b5d1-4d95-9823-fc70ca13d51d	94907b83-1c4f-4ed4-8104-597b6924576c	b7d67908-6205-4863-a694-d7dba56e1d39	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
1c424a95-2872-4d2f-a08a-d2b16a71d720	94907b83-1c4f-4ed4-8104-597b6924576c	30b71cb1-97df-4655-8704-0560bcf5da06	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
7d89b9ac-fb6e-4a80-bb33-fcc3183b24e6	94907b83-1c4f-4ed4-8104-597b6924576c	f658c2c3-3d12-4798-bccb-9af886cd15eb	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
ec43b5ab-af7c-438b-9dc0-be0e36ec36be	94907b83-1c4f-4ed4-8104-597b6924576c	6f903e44-300e-470c-aa64-125da9772880	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
13ae1787-dff5-4e97-bd59-6ca724fe2d96	94907b83-1c4f-4ed4-8104-597b6924576c	24c6259e-6fbf-4a75-a66e-bd8a2894b261	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
55338523-5e92-4091-9841-48e16bdf2e75	94907b83-1c4f-4ed4-8104-597b6924576c	a2287dfb-4153-4222-91dd-5ab86abcd82a	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
21dfce1e-e37f-45c0-842b-38c413dbb71c	94907b83-1c4f-4ed4-8104-597b6924576c	77c73ecd-3988-4efa-af44-efe3725e9f14	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
2f70d20f-4d66-460c-b6ec-1f2537a8ce1d	94907b83-1c4f-4ed4-8104-597b6924576c	3125cce7-fab5-4000-a4ec-d6cb3069e730	100.00	5.00	2025-10-09 05:47:01.888842	2025-10-09 05:47:01.888842
\.


--
-- Data for Name: batch_term_progression; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.batch_term_progression (id, batch_id, term_id, term_number, status, start_date, end_date, completion_date, students_enrolled, students_completed, students_failed, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: batch_term_quadrant_weightages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.batch_term_quadrant_weightages (id, config_id, quadrant_id, weightage, minimum_attendance, business_rules, created_at, updated_at) FROM stdin;
a7d095c5-d70e-4105-b1a3-d4ecbc206e1d	d9dfeb65-9d58-476b-8a71-61df3af839b6	persona	50.00	80.00	{}	2025-10-09 05:44:04.744735	2025-10-09 05:45:13.687
10875cda-d411-494c-9d83-955564f0dbdf	d9dfeb65-9d58-476b-8a71-61df3af839b6	wellness	30.00	80.00	{}	2025-10-09 05:44:04.744735	2025-10-09 05:45:13.755
b8120a89-110b-46a7-a407-9e252dcf4f58	d9dfeb65-9d58-476b-8a71-61df3af839b6	behavior	10.00	0.00	{}	2025-10-09 05:44:04.744735	2025-10-09 05:45:14.096
f460ebab-7d58-4b86-9862-3e6b7749c76b	d9dfeb65-9d58-476b-8a71-61df3af839b6	discipline	10.00	0.00	{}	2025-10-09 05:44:04.744735	2025-10-09 05:45:14.154
0425f172-926b-4953-8285-758331fe91cf	94907b83-1c4f-4ed4-8104-597b6924576c	persona	100.00	80.00	{}	2025-10-09 05:47:01.700716	2025-10-09 05:47:01.700716
a5474486-03bc-414d-8e87-a2adcaa2bbd3	94907b83-1c4f-4ed4-8104-597b6924576c	wellness	100.00	80.00	{}	2025-10-09 05:47:01.700716	2025-10-09 05:47:01.700716
13075a2b-6ad8-46b1-845b-91415c171c0b	94907b83-1c4f-4ed4-8104-597b6924576c	behavior	100.00	0.00	{}	2025-10-09 05:47:01.700716	2025-10-09 05:47:01.700716
54778d86-8101-44d9-a527-37b029bc6c0e	94907b83-1c4f-4ed4-8104-597b6924576c	discipline	100.00	0.00	{}	2025-10-09 05:47:01.700716	2025-10-09 05:47:01.700716
\.


--
-- Data for Name: batch_term_subcategory_weightages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.batch_term_subcategory_weightages (id, config_id, subcategory_id, weightage, created_at, updated_at) FROM stdin;
3a5dc4d5-671d-44a9-ba78-35b61d4b2517	d9dfeb65-9d58-476b-8a71-61df3af839b6	bcd6a86f-338c-4997-ae43-f378cc10dbb0	100.00	2025-10-09 05:44:04.821104	2025-10-09 05:44:04.821104
ef036a0e-ba5e-4b87-bba3-e89f9604cba1	d9dfeb65-9d58-476b-8a71-61df3af839b6	f1282f61-7149-4e9f-aaad-d3dc5b14d533	100.00	2025-10-09 05:44:04.821104	2025-10-09 05:44:04.821104
b6994b54-70b1-419d-9d88-5b95ff0982bc	d9dfeb65-9d58-476b-8a71-61df3af839b6	167335d3-2172-4eb4-8275-af4341c79882	100.00	2025-10-09 05:44:04.821104	2025-10-09 05:44:04.821104
94902847-8747-4822-a010-e1a56e06c751	d9dfeb65-9d58-476b-8a71-61df3af839b6	ae887796-17a6-4ee8-ac39-8bd3154508de	100.00	2025-10-09 05:44:04.821104	2025-10-09 05:44:04.821104
f57dc74d-f5b6-4c5c-8d53-6961deef45bb	d9dfeb65-9d58-476b-8a71-61df3af839b6	90298481-85b8-460e-a294-eb938947aa1e	100.00	2025-10-09 05:44:04.821104	2025-10-09 05:44:04.821104
2188a6d9-cc71-411f-9e18-7d0722d1876e	94907b83-1c4f-4ed4-8104-597b6924576c	bcd6a86f-338c-4997-ae43-f378cc10dbb0	100.00	2025-10-09 05:47:01.748513	2025-10-09 05:47:01.748513
12d30bfc-42f6-4635-b5d8-8598a939cb09	94907b83-1c4f-4ed4-8104-597b6924576c	f1282f61-7149-4e9f-aaad-d3dc5b14d533	100.00	2025-10-09 05:47:01.748513	2025-10-09 05:47:01.748513
31343a5a-6752-4969-8dd9-a656e0ec8f3b	94907b83-1c4f-4ed4-8104-597b6924576c	167335d3-2172-4eb4-8275-af4341c79882	100.00	2025-10-09 05:47:01.748513	2025-10-09 05:47:01.748513
c802da94-ecca-4fbc-bb0c-dd876b410218	94907b83-1c4f-4ed4-8104-597b6924576c	ae887796-17a6-4ee8-ac39-8bd3154508de	100.00	2025-10-09 05:47:01.748513	2025-10-09 05:47:01.748513
3ec8bd69-6cc4-48d8-9d93-bcc05426e402	94907b83-1c4f-4ed4-8104-597b6924576c	90298481-85b8-460e-a294-eb938947aa1e	100.00	2025-10-09 05:47:01.748513	2025-10-09 05:47:01.748513
\.


--
-- Data for Name: batch_term_weightage_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.batch_term_weightage_config (id, batch_id, term_id, config_name, description, is_active, created_by, created_at, updated_at) FROM stdin;
94907b83-1c4f-4ed4-8104-597b6924576c	4414fd0e-692d-4ad8-9f3c-2dbc6b292fd7	ef77ce62-77d3-4de6-864b-b74abab79d22	Test Configuration 2	Test configuration for fixing created_by issue	t	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.659999	2025-10-09 05:47:01.659999
d9dfeb65-9d58-476b-8a71-61df3af839b6	f9294daf-2956-42b5-bba7-d5e11b23dcee	694784ea-5501-483d-be6d-08f6667a6465	SS		t	16459cad-4104-4955-8977-45eb93a63d4a	2025-10-09 05:44:04.659601	2025-10-09 05:45:14.187
\.


--
-- Data for Name: batches; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.batches (id, name, year, start_date, end_date, is_active, created_at, current_term_number, max_terms, batch_start_date, expected_graduation_date, batch_status) FROM stdin;
f9294daf-2956-42b5-bba7-d5e11b23dcee	PGDM 2025	2025	2025-01-01	2025-12-31	t	2025-06-13 18:04:58.849546	3	4	2025-07-13	\N	active
4414fd0e-692d-4ad8-9f3c-2dbc6b292fd7	Batch 2024	2024	2024-01-01	2024-12-31	t	2025-06-14 04:29:18.714389	4	4	2025-07-13	\N	graduated
4cb5c881-4600-45a6-bc61-4dfcf85aff9a	Workflow Test Batch 2025	2025	2025-01-01	2025-12-31	t	2025-07-16 05:17:30.296765	1	4	2025-07-16	\N	active
6322629c-643e-458b-9347-8b389f655a90	PGDM 2024	2024	2024-01-01	2024-12-31	t	2025-06-13 17:52:27.073051	4	4	2025-07-13	\N	graduated
\.


--
-- Data for Name: components; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.components (id, sub_category_id, name, description, weightage, max_score, minimum_score, category, display_order, is_active, created_at, updated_at) FROM stdin;
34c05a81-5261-49cc-a48e-74beeffbbde9	ae887796-17a6-4ee8-ac39-8bd3154508de	Analytical & Critical Thinking ( A ) (C)	Analytical & Critical Thinking for Capstone	100.00	5.00	0.00	Professional	0	t	2025-10-09 05:23:09.985785	2025-10-09 05:23:09.985785
4c6ad1ae-7165-432e-a915-4102082c36cf	ae887796-17a6-4ee8-ac39-8bd3154508de	Communication ( C ) (C)	Communication for Capstone	100.00	5.00	0.00	Professional	0	t	2025-10-09 05:23:09.985785	2025-10-09 05:23:09.985785
5bd8fc59-1862-48bf-abf0-428da25a1b07	ae887796-17a6-4ee8-ac39-8bd3154508de	Empathy  ( E ) (C)	Empathy for Capstone	100.00	5.00	0.00	Professional	0	t	2025-10-09 05:23:09.985785	2025-10-09 05:23:09.985785
33a34606-c38f-41b4-b177-018d32e147fe	ae887796-17a6-4ee8-ac39-8bd3154508de	Leadership(  L ) (C)	Leadership for Capstone	100.00	5.00	0.00	Professional	0	t	2025-10-09 05:23:09.985785	2025-10-09 05:23:09.985785
dbbfaec0-c416-4124-8e84-0e6fd939b203	ae887796-17a6-4ee8-ac39-8bd3154508de	Negotiation ( N ) (C)	Negotiation for Capstone	100.00	5.00	0.00	Professional	0	t	2025-10-09 05:23:09.985785	2025-10-09 05:23:09.985785
5f879989-7fbb-420c-b532-31939fb64bf3	ae887796-17a6-4ee8-ac39-8bd3154508de	Problem Solving ( P ) (C)	Problem Solving for Capstone	100.00	5.00	0.00	Professional	0	t	2025-10-09 05:23:09.985785	2025-10-09 05:23:09.985785
1e184ce2-e271-4666-b316-cbdf446b6ff1	ae887796-17a6-4ee8-ac39-8bd3154508de	Team Work ( T) (C)	Team Work for Capstone	100.00	5.00	0.00	Professional	0	t	2025-10-09 05:23:09.985785	2025-10-09 05:23:09.985785
942dd95e-c3cc-4d75-872f-10284d06bc0c	bcd6a86f-338c-4997-ae43-f378cc10dbb0	Analytical & Critical Thinking ( A )		100.00	5.00	0.00	Professional	1	t	2025-10-08 09:30:42.482705	2025-10-08 17:44:33.496148
61b99470-5e1d-4e02-9d4c-22836faca5f6	bcd6a86f-338c-4997-ae43-f378cc10dbb0	Communication ( C )		100.00	5.00	0.00	Professional	2	t	2025-10-08 09:30:42.482705	2025-10-08 17:44:33.496148
6d9537fa-408f-458f-8ce4-df168aca82b3	bcd6a86f-338c-4997-ae43-f378cc10dbb0	Empathy  ( E )		100.00	5.00	0.00	Professional	3	t	2025-10-08 09:30:42.482705	2025-10-08 17:44:33.496148
b464cb43-8128-4edd-8bc3-5ff6b58e7026	bcd6a86f-338c-4997-ae43-f378cc10dbb0	Leadership(  L )		100.00	5.00	0.00	Professional	4	t	2025-10-08 09:30:42.482705	2025-10-08 17:44:33.496148
04c55953-826b-41f9-81fc-6a7a8edbca62	bcd6a86f-338c-4997-ae43-f378cc10dbb0	Negotiation ( N )		100.00	5.00	0.00	Professional	5	t	2025-10-08 09:30:42.482705	2025-10-08 17:44:33.496148
4dfe00e4-716a-4358-8185-f9672ddf7ad3	bcd6a86f-338c-4997-ae43-f378cc10dbb0	Problem Solving ( P )		100.00	5.00	0.00	Professional	6	t	2025-10-08 09:30:42.482705	2025-10-08 17:44:33.496148
47a5b091-72ec-47d9-9028-c2e80a1dfa4c	90298481-85b8-460e-a294-eb938947aa1e	Academics (C)	Academics for Capstone	100.00	5.00	0.00	Academic	0	t	2025-10-09 05:26:31.899929	2025-10-09 05:26:31.899929
08273004-dc4c-4738-8740-507d23ac7c22	bcd6a86f-338c-4997-ae43-f378cc10dbb0	Team Work ( T)		100.00	5.00	0.00	Professional	7	t	2025-10-08 09:30:42.482705	2025-10-08 17:44:33.496148
72115e64-922a-4df2-a20e-aadebbb0eab3	f1282f61-7149-4e9f-aaad-d3dc5b14d533	Fitness		100.00	5.00	0.00	Physical	1	t	2025-10-08 09:51:18.773473	2025-10-08 17:44:33.496148
9ec8e344-1032-47ff-8c4e-e52c721f6150	167335d3-2172-4eb4-8275-af4341c79882	Academics		100.00	5.00	0.00	Academic	1	t	2025-10-08 09:51:44.665761	2025-10-08 17:44:33.496148
\.


--
-- Data for Name: data_imports; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.data_imports (id, import_type, filename, file_path, status, total_records, processed_records, successful_records, failed_records, error_log, processing_log, term_id, imported_by, started_at, completed_at, created_at) FROM stdin;
\.


--
-- Data for Name: direct_assessments; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.direct_assessments (id, task_id, student_id, score, feedback, private_notes, assessed_at, assessed_by, created_at, updated_at, term_id) FROM stdin;
\.


--
-- Data for Name: email_logs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.email_logs (id, recipient_email, recipient_user_id, subject, email_type, template_name, status, sent_at, delivered_at, error_message, metadata, created_at) FROM stdin;
\.


--
-- Data for Name: feedback; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.feedback (id, student_id, teacher_id, subject, category, message, priority, status, response, submitted_at, resolved_at, resolved_by) FROM stdin;
\.


--
-- Data for Name: file_uploads; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.file_uploads (id, original_filename, stored_filename, file_path, file_size, mime_type, file_hash, uploaded_by, entity_type, entity_id, is_public, upload_purpose, created_at) FROM stdin;
\.


--
-- Data for Name: houses; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.houses (id, name, color, description, total_points, is_active, created_at) FROM stdin;
bde1d487-a6ca-455e-9f22-99c415576632	Daredevils	#FF6B6B	Bold and adventurous house	0	t	2025-06-13 17:52:27.073051
402da889-3756-4f0c-af6b-f32e0f0afc8b	Coronation	#4ECDC4	Royal and dignified house	0	t	2025-06-13 17:52:27.073051
a0e117c0-232b-4c70-aa39-6830184c34ed	Apache	#45B7D1	Strong and resilient house	0	t	2025-06-13 17:52:27.073051
deba4c27-7c58-4bf6-96e8-fae8d04aa1ee	Bravehearts	#96CEB4	Courageous and determined house	0	t	2025-06-13 17:52:27.073051
b8b46b58-43bc-46fc-a571-ce9dd3f4f5d7	Red House	#EF4444	Red house for students	0	t	2025-06-14 04:29:18.875613
\.


--
-- Data for Name: hps_calculation_audit; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.hps_calculation_audit (id, student_id, term_id, old_hps, new_hps, hps_difference, percentage_change, trigger_type, metadata, calculated_at, created_at) FROM stdin;
\.


--
-- Data for Name: intervention_enrollments; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.intervention_enrollments (id, intervention_id, student_id, enrollment_date, enrollment_status, enrollment_type, progress_data, current_score, completion_percentage, enrolled_by, enrollment_deadline) FROM stdin;
0fe223bb-6aa6-4adb-9be0-8c0b5d4362cb	708bb649-495c-45d0-a217-185f19446e75	a677d812-3140-440f-9603-2cff99ca31d4	2025-10-09	Enrolled	Optional	{}	0.00	0.00	16459cad-4104-4955-8977-45eb93a63d4a	\N
fe4e68e7-4bb9-4e75-953b-54fb8f769163	708bb649-495c-45d0-a217-185f19446e75	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	2025-10-09	Enrolled	Optional	{}	0.00	0.00	16459cad-4104-4955-8977-45eb93a63d4a	\N
d1496d60-c394-4ee3-840e-10a7e6036375	708bb649-495c-45d0-a217-185f19446e75	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	2025-10-09	Enrolled	Optional	{}	0.00	0.00	16459cad-4104-4955-8977-45eb93a63d4a	\N
c46fb626-017a-44be-959a-28233ca1de2c	708bb649-495c-45d0-a217-185f19446e75	30da9b2e-814c-408d-823b-f2719459e315	2025-10-09	Enrolled	Optional	{}	0.00	0.00	16459cad-4104-4955-8977-45eb93a63d4a	\N
77c3b9b0-d09c-4e2a-a570-26971b631dc4	708bb649-495c-45d0-a217-185f19446e75	f81b6756-e9c8-4a45-8704-bcc647f20d12	2025-10-09	Enrolled	Optional	{}	0.00	0.00	16459cad-4104-4955-8977-45eb93a63d4a	\N
4a1baf3a-f808-41a0-8be2-940357781268	79336918-2f2b-450a-b09b-70a320973d6c	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	2025-10-09	Enrolled	Optional	{}	75.00	75.00	16459cad-4104-4955-8977-45eb93a63d4a	\N
d17775c5-8355-49ee-bf2d-0948eae227b3	79336918-2f2b-450a-b09b-70a320973d6c	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	2025-10-09	Enrolled	Optional	{}	50.00	50.00	16459cad-4104-4955-8977-45eb93a63d4a	\N
b8a18197-902b-495e-bdd2-0588db2e141d	79336918-2f2b-450a-b09b-70a320973d6c	30da9b2e-814c-408d-823b-f2719459e315	2025-10-09	Enrolled	Optional	{}	55.00	55.00	16459cad-4104-4955-8977-45eb93a63d4a	\N
ad7d07ad-e3a0-4b36-a1fb-b91bcca653f5	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	f81b6756-e9c8-4a45-8704-bcc647f20d12	2025-10-08	Enrolled	Optional	{}	24.00	24.00	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	\N
a3a1901d-685d-46be-ac28-72727248ba66	79336918-2f2b-450a-b09b-70a320973d6c	f81b6756-e9c8-4a45-8704-bcc647f20d12	2025-10-09	Enrolled	Optional	{}	87.60	87.60	16459cad-4104-4955-8977-45eb93a63d4a	\N
a83c511c-e2a4-45c2-847e-42d1d79cfb93	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	2025-10-08	Enrolled	Optional	{}	74.00	74.00	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	\N
93920418-eed9-453d-b0b1-d090307fb23b	79336918-2f2b-450a-b09b-70a320973d6c	a677d812-3140-440f-9603-2cff99ca31d4	2025-10-09	Enrolled	Optional	{}	0.00	0.00	16459cad-4104-4955-8977-45eb93a63d4a	\N
73736ad2-347c-448e-bfb8-563f21eb4dea	906b8089-4326-4a47-b82b-756db4f8916d	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	2025-10-09	Enrolled	Optional	{}	71.82	71.82	16459cad-4104-4955-8977-45eb93a63d4a	\N
2d8d8df5-de0f-42e0-a82d-d6947b7ae301	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	a677d812-3140-440f-9603-2cff99ca31d4	2025-10-09	Enrolled	Optional	{}	0.00	0.00	16459cad-4104-4955-8977-45eb93a63d4a	\N
61d4d171-80ba-4e66-898f-4f92959b6f39	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	30da9b2e-814c-408d-823b-f2719459e315	2025-10-09	Enrolled	Optional	{}	80.00	80.00	16459cad-4104-4955-8977-45eb93a63d4a	\N
06dd9334-6823-4d9a-8a68-b844c12aad31	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	a677d812-3140-440f-9603-2cff99ca31d4	2025-10-08	Enrolled	Optional	{}	0.00	0.00	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	\N
6cf750c6-d78e-43c5-92fc-3a9d764a5050	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	2025-10-08	Enrolled	Optional	{}	72.00	72.00	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	\N
1298bf1e-47cd-45ad-b492-c9f292b0a99a	906b8089-4326-4a47-b82b-756db4f8916d	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	2025-10-09	Enrolled	Optional	{}	61.82	61.82	16459cad-4104-4955-8977-45eb93a63d4a	\N
34d147b3-8934-4507-9040-bf3d1517c5c9	906b8089-4326-4a47-b82b-756db4f8916d	30da9b2e-814c-408d-823b-f2719459e315	2025-10-09	Enrolled	Optional	{}	34.55	34.55	16459cad-4104-4955-8977-45eb93a63d4a	\N
e896a911-6434-4972-a826-3c6ec690c238	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	2025-10-09	Enrolled	Optional	{}	90.91	90.91	16459cad-4104-4955-8977-45eb93a63d4a	\N
4e80b1ff-6592-420b-a2f6-43ec14851336	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	30da9b2e-814c-408d-823b-f2719459e315	2025-10-08	Enrolled	Optional	{}	22.67	22.67	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	\N
ec6efacc-b1e9-4b8e-b588-9522352b26d3	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	f81b6756-e9c8-4a45-8704-bcc647f20d12	2025-10-09	Enrolled	Optional	{}	89.09	89.09	16459cad-4104-4955-8977-45eb93a63d4a	\N
c19be5c9-92c8-49c6-abba-bedce9b87dbd	906b8089-4326-4a47-b82b-756db4f8916d	f81b6756-e9c8-4a45-8704-bcc647f20d12	2025-10-09	Enrolled	Optional	{}	33.64	33.64	16459cad-4104-4955-8977-45eb93a63d4a	\N
a3679762-5935-4c57-8a29-8f367cfa6ce7	906b8089-4326-4a47-b82b-756db4f8916d	a677d812-3140-440f-9603-2cff99ca31d4	2025-10-09	Enrolled	Optional	{}	0.00	0.00	16459cad-4104-4955-8977-45eb93a63d4a	\N
c8b087b6-a98c-4474-9096-e3d65e7c10e3	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	2025-10-09	Enrolled	Optional	{}	83.64	83.64	16459cad-4104-4955-8977-45eb93a63d4a	\N
23c91f64-03e8-4fa8-a24f-b3e5e80199e7	88db9091-ce2d-4403-8435-836d38255f2c	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	2025-10-08	Enrolled	Optional	{}	74.67	74.67	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	\N
def482c9-1c1e-4e1f-a2fb-78f28dfd3f99	4d2ce8fc-08e8-4865-a179-0d326f3151da	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	2025-10-09	Enrolled	Optional	{}	68.57	68.57	16459cad-4104-4955-8977-45eb93a63d4a	\N
777bf6c3-528f-4e2a-a381-d3075d167f9a	88db9091-ce2d-4403-8435-836d38255f2c	a677d812-3140-440f-9603-2cff99ca31d4	2025-10-08	Enrolled	Optional	{}	0.00	0.00	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	\N
e3c7e899-9ac2-4e47-9e17-3b252d6f37ef	4d2ce8fc-08e8-4865-a179-0d326f3151da	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	2025-10-09	Enrolled	Optional	{}	62.86	62.86	16459cad-4104-4955-8977-45eb93a63d4a	\N
5dbcf925-9a74-4ea0-b0c6-9b3159985a6e	88db9091-ce2d-4403-8435-836d38255f2c	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	2025-10-08	Enrolled	Optional	{}	76.67	76.67	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	\N
f9935cc2-cf69-44d4-8c48-529a9ba556ff	a3642afb-c1e0-48b5-a089-cc429f99a93e	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	2025-10-09	Enrolled	Optional	{}	67.14	67.14	16459cad-4104-4955-8977-45eb93a63d4a	\N
8f892e1b-ceb2-4ebd-8e74-4fb6b38f8ac8	a3642afb-c1e0-48b5-a089-cc429f99a93e	f81b6756-e9c8-4a45-8704-bcc647f20d12	2025-10-09	Enrolled	Optional	{}	33.81	33.81	16459cad-4104-4955-8977-45eb93a63d4a	\N
5c676859-9112-4e96-a4d0-a060aa09ba2f	4d2ce8fc-08e8-4865-a179-0d326f3151da	30da9b2e-814c-408d-823b-f2719459e315	2025-10-09	Enrolled	Optional	{}	22.86	22.86	16459cad-4104-4955-8977-45eb93a63d4a	\N
efae741f-cafa-4b93-8a13-5862863871dc	a3642afb-c1e0-48b5-a089-cc429f99a93e	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	2025-10-09	Enrolled	Optional	{}	61.90	61.90	16459cad-4104-4955-8977-45eb93a63d4a	\N
673881ad-5fc7-41d9-8fc5-38f98762b038	4d2ce8fc-08e8-4865-a179-0d326f3151da	f81b6756-e9c8-4a45-8704-bcc647f20d12	2025-10-09	Enrolled	Optional	{}	33.33	33.33	16459cad-4104-4955-8977-45eb93a63d4a	\N
b478408a-3794-454c-b22d-ab73ce324c8e	88db9091-ce2d-4403-8435-836d38255f2c	30da9b2e-814c-408d-823b-f2719459e315	2025-10-08	Enrolled	Optional	{}	0.00	0.00	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	\N
3aa8d9ae-bb29-4b85-b825-f517122a7ea2	a3642afb-c1e0-48b5-a089-cc429f99a93e	a677d812-3140-440f-9603-2cff99ca31d4	2025-10-09	Enrolled	Optional	{}	0.00	0.00	16459cad-4104-4955-8977-45eb93a63d4a	\N
8f87d476-e302-4454-8e5d-2dbd4e0c7299	4d2ce8fc-08e8-4865-a179-0d326f3151da	a677d812-3140-440f-9603-2cff99ca31d4	2025-10-09	Enrolled	Optional	{}	0.00	0.00	16459cad-4104-4955-8977-45eb93a63d4a	\N
d3b93e40-6fec-451b-b923-5921a6491eca	a3642afb-c1e0-48b5-a089-cc429f99a93e	30da9b2e-814c-408d-823b-f2719459e315	2025-10-09	Enrolled	Optional	{}	27.62	27.62	16459cad-4104-4955-8977-45eb93a63d4a	\N
fa3921d9-981b-497b-9199-ef98096e23c0	88db9091-ce2d-4403-8435-836d38255f2c	f81b6756-e9c8-4a45-8704-bcc647f20d12	2025-10-08	Enrolled	Optional	{}	11.33	11.33	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	\N
\.


--
-- Data for Name: intervention_microcompetencies; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.intervention_microcompetencies (id, intervention_id, microcompetency_id, weightage, max_score, is_active, created_at) FROM stdin;
b8d80136-04bc-4e72-992d-9f7b55cf38de	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	4476c3a6-58da-4c43-9b8a-b1da70172072	1.00	5.00	t	2025-10-08 15:36:01.037884
80a4de53-a202-4dbe-92f7-c04d2bb877f8	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	31a4c844-6a46-4b57-a23d-91d9a5ff7382	1.00	5.00	t	2025-10-08 15:36:01.037884
6ed233d0-4b4c-4579-bd99-54f9c95c3f19	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	4d6b4184-d62e-427a-ba00-16ff3f4e4f10	1.00	5.00	t	2025-10-08 15:36:01.037884
43f251dd-89f0-4444-bce1-ee47ca246bc9	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	06947927-aab0-4d24-b5fe-b42c0b83050c	1.00	5.00	t	2025-10-08 15:36:01.037884
48a39f98-b3f2-424b-862d-bac277644fd9	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	7e8983cd-5a94-49cc-9b80-64358a9d48f9	1.00	5.00	t	2025-10-08 15:36:01.037884
462ea170-dcef-4199-b787-aab8f83aa58c	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	685d23ad-eadc-47ac-9f91-8f741ae4211f	1.00	5.00	t	2025-10-08 15:36:01.037884
33ebd2fe-0c94-4ee2-8d80-a674a52e60ff	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	2e599a1f-e34d-436c-98f9-01f019cb29bd	1.00	5.00	t	2025-10-08 15:36:01.037884
e9999e22-52d9-42b4-997c-521a5c35f94d	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	44a43cc4-8d2e-4ce5-b437-2b76a205ea84	1.00	5.00	t	2025-10-08 15:36:01.037884
c2953f21-fea1-4729-bc0b-57164085e79b	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	08314805-8508-4254-997b-a035415747d5	1.00	5.00	t	2025-10-08 15:36:01.037884
264af287-2c1b-4440-8cac-d559a027fac7	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	88fad813-46ed-4601-a334-ae77df797be3	1.00	5.00	t	2025-10-08 15:36:01.037884
fdc3fb74-dcf2-4903-b977-3e5b54b70501	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	9358b2c4-aebc-480a-9eff-6873c156da12	1.00	5.00	t	2025-10-08 15:36:01.037884
ad65a2dd-f2f2-48ae-91e9-76b9dc8d79aa	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	7022a346-204b-472a-b46b-b801f07e8853	1.00	5.00	t	2025-10-08 15:36:01.037884
a1442bcf-9044-45ca-9aea-3605ae86dc58	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	6852ffde-5e9e-4faa-be78-93d194b1f8b7	1.00	5.00	t	2025-10-08 15:36:01.037884
a78c54f3-2b64-4d7b-93bb-9164e1791669	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	ec97e568-30d6-4e8f-acb3-b74d1b4b5436	1.00	5.00	t	2025-10-08 15:36:01.037884
dfe56e51-58a6-4c6d-9e3e-960b70a2ba29	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	41ab0a41-f16e-4bd5-961e-5b070acd6410	1.00	5.00	t	2025-10-08 15:36:01.037884
4d8dc41d-5259-4734-9386-508da466b86e	88db9091-ce2d-4403-8435-836d38255f2c	4476c3a6-58da-4c43-9b8a-b1da70172072	100.00	10.00	t	2025-10-08 18:01:01.374544
fd14b713-2ee7-43a8-a333-13de046f0012	88db9091-ce2d-4403-8435-836d38255f2c	31a4c844-6a46-4b57-a23d-91d9a5ff7382	100.00	10.00	t	2025-10-08 18:01:01.374544
ef44f141-fec2-4272-ae47-06596dc36939	88db9091-ce2d-4403-8435-836d38255f2c	4d6b4184-d62e-427a-ba00-16ff3f4e4f10	100.00	10.00	t	2025-10-08 18:01:01.374544
2dda52b0-7f68-46cd-81dd-5031b2f8808c	88db9091-ce2d-4403-8435-836d38255f2c	06947927-aab0-4d24-b5fe-b42c0b83050c	100.00	10.00	t	2025-10-08 18:01:01.374544
ef8b0128-cacd-4d78-860c-490ba2d1bb8c	88db9091-ce2d-4403-8435-836d38255f2c	7e8983cd-5a94-49cc-9b80-64358a9d48f9	100.00	10.00	t	2025-10-08 18:01:01.374544
21fd21a0-087b-4063-bf40-811041d8f98f	88db9091-ce2d-4403-8435-836d38255f2c	685d23ad-eadc-47ac-9f91-8f741ae4211f	100.00	10.00	t	2025-10-08 18:01:01.374544
a76d6940-33ed-485e-ae51-a65b64885a48	88db9091-ce2d-4403-8435-836d38255f2c	2e599a1f-e34d-436c-98f9-01f019cb29bd	100.00	10.00	t	2025-10-08 18:01:01.374544
43ce13bd-3fc2-4971-8c41-e598486da0b6	88db9091-ce2d-4403-8435-836d38255f2c	44a43cc4-8d2e-4ce5-b437-2b76a205ea84	100.00	10.00	t	2025-10-08 18:01:01.374544
b1e9ca74-49f7-4be5-a649-052850962794	88db9091-ce2d-4403-8435-836d38255f2c	08314805-8508-4254-997b-a035415747d5	100.00	10.00	t	2025-10-08 18:01:01.374544
c695541e-357a-4633-82fe-2642143f5024	88db9091-ce2d-4403-8435-836d38255f2c	88fad813-46ed-4601-a334-ae77df797be3	100.00	10.00	t	2025-10-08 18:01:01.374544
6747cb95-b81e-47cb-884b-900c1911a7e5	88db9091-ce2d-4403-8435-836d38255f2c	9358b2c4-aebc-480a-9eff-6873c156da12	100.00	10.00	t	2025-10-08 18:01:01.374544
4b746d37-eb66-4316-bbab-cf184fe51c20	88db9091-ce2d-4403-8435-836d38255f2c	7022a346-204b-472a-b46b-b801f07e8853	100.00	10.00	t	2025-10-08 18:01:01.374544
5cb4379f-c194-410f-8a74-e269fdfad022	88db9091-ce2d-4403-8435-836d38255f2c	6852ffde-5e9e-4faa-be78-93d194b1f8b7	100.00	10.00	t	2025-10-08 18:01:01.374544
d126831b-7d20-45b7-a421-0983b7e4ee9e	88db9091-ce2d-4403-8435-836d38255f2c	ec97e568-30d6-4e8f-acb3-b74d1b4b5436	100.00	10.00	t	2025-10-08 18:01:01.374544
7eecfa13-23a6-47e8-95ab-d6123c19252b	88db9091-ce2d-4403-8435-836d38255f2c	41ab0a41-f16e-4bd5-961e-5b070acd6410	100.00	10.00	t	2025-10-08 18:01:01.374544
1a307a78-e22c-4862-992a-0f312f19b5fb	708bb649-495c-45d0-a217-185f19446e75	adbc17f9-6f88-4144-afe1-e29f3a0bd21e	100.00	10.00	t	2025-10-09 04:28:40.078608
916534c7-dcbe-4ed0-8cce-8c35f111e0f9	708bb649-495c-45d0-a217-185f19446e75	bcb48067-c6be-4c39-87bc-08618f18ef4e	100.00	10.00	t	2025-10-09 04:28:40.078608
770105fe-c889-4fee-9d79-49eb03798b60	708bb649-495c-45d0-a217-185f19446e75	955efb94-7eac-4392-969a-732f19143f89	100.00	10.00	t	2025-10-09 04:28:40.078608
541c8322-118d-4de8-98b1-29417b49de8b	708bb649-495c-45d0-a217-185f19446e75	ec97e568-30d6-4e8f-acb3-b74d1b4b5436	100.00	10.00	t	2025-10-09 04:28:40.078608
e9e05d27-376f-45b7-b50d-2b76a7aaf627	4d2ce8fc-08e8-4865-a179-0d326f3151da	08314805-8508-4254-997b-a035415747d5	100.00	10.00	t	2025-10-09 04:53:08.884186
b30a4c9f-468c-4151-98df-07b92df8598d	4d2ce8fc-08e8-4865-a179-0d326f3151da	88fad813-46ed-4601-a334-ae77df797be3	100.00	10.00	t	2025-10-09 04:53:08.884186
b4c6cdb3-8515-4c92-ad1f-200ed43c5ee5	4d2ce8fc-08e8-4865-a179-0d326f3151da	9358b2c4-aebc-480a-9eff-6873c156da12	100.00	10.00	t	2025-10-09 04:53:08.884186
e5987ccc-8d50-48c6-867d-3a47c0100a0d	4d2ce8fc-08e8-4865-a179-0d326f3151da	d5760d32-ce61-48fd-988e-9bd16cc52ca1	100.00	10.00	t	2025-10-09 04:53:08.884186
ad8365f8-446d-4a9f-8728-5e70a369ec7d	4d2ce8fc-08e8-4865-a179-0d326f3151da	7022a346-204b-472a-b46b-b801f07e8853	100.00	10.00	t	2025-10-09 04:53:08.884186
aac563e6-0bd1-4c86-b488-7c4b4b1ac980	4d2ce8fc-08e8-4865-a179-0d326f3151da	6852ffde-5e9e-4faa-be78-93d194b1f8b7	100.00	10.00	t	2025-10-09 04:53:08.884186
78022dcb-d9b8-42fe-a91f-480fb6384dc2	4d2ce8fc-08e8-4865-a179-0d326f3151da	ec97e568-30d6-4e8f-acb3-b74d1b4b5436	100.00	10.00	t	2025-10-09 04:53:08.884186
832f4a6f-59a1-4fa0-953d-3689c1bba23b	4d2ce8fc-08e8-4865-a179-0d326f3151da	0322c72d-2fbf-462d-9a59-76e1550b30d9	100.00	10.00	t	2025-10-09 04:53:08.884186
1dc77d9c-013c-451c-97ae-6d8a1f5379b2	79336918-2f2b-450a-b09b-70a320973d6c	1b63c6c1-36b6-49b5-a61f-1c3f2b85bdb1	100.00	10.00	t	2025-10-09 05:04:45.538318
14fbde36-cceb-47a4-958b-d30eb68c06fb	906b8089-4326-4a47-b82b-756db4f8916d	88fad813-46ed-4601-a334-ae77df797be3	100.00	10.00	t	2025-10-09 05:11:17.407825
a60dfbf2-85f5-42d2-aed2-a7e824cd4ad3	906b8089-4326-4a47-b82b-756db4f8916d	9358b2c4-aebc-480a-9eff-6873c156da12	100.00	10.00	t	2025-10-09 05:11:17.407825
8821f9e1-9696-4556-af96-3a1dd0b01379	906b8089-4326-4a47-b82b-756db4f8916d	d5760d32-ce61-48fd-988e-9bd16cc52ca1	100.00	10.00	t	2025-10-09 05:11:17.407825
f9e839cd-3b95-4a2d-8246-c9514e0720b2	906b8089-4326-4a47-b82b-756db4f8916d	7022a346-204b-472a-b46b-b801f07e8853	100.00	10.00	t	2025-10-09 05:11:17.407825
1b9dcb8b-399b-4b86-b50a-bb8eea49d692	906b8089-4326-4a47-b82b-756db4f8916d	ec97e568-30d6-4e8f-acb3-b74d1b4b5436	100.00	10.00	t	2025-10-09 05:11:17.407825
fa965b95-c690-4bd3-b88d-a0d0eda6c288	906b8089-4326-4a47-b82b-756db4f8916d	41ab0a41-f16e-4bd5-961e-5b070acd6410	100.00	10.00	t	2025-10-09 05:11:17.407825
b2f4d558-23f9-4ff3-8b34-89627074993f	a3642afb-c1e0-48b5-a089-cc429f99a93e	4d6b4184-d62e-427a-ba00-16ff3f4e4f10	100.00	10.00	t	2025-10-09 05:16:43.196311
54b48378-3ebb-41f2-b495-564e2760e2ba	a3642afb-c1e0-48b5-a089-cc429f99a93e	685d23ad-eadc-47ac-9f91-8f741ae4211f	100.00	10.00	t	2025-10-09 05:16:43.196311
a230ed5f-b54b-4c49-a558-03ff267851cd	a3642afb-c1e0-48b5-a089-cc429f99a93e	2e599a1f-e34d-436c-98f9-01f019cb29bd	100.00	10.00	t	2025-10-09 05:16:43.196311
08f62655-e82c-4c1e-946f-51b474a70808	a3642afb-c1e0-48b5-a089-cc429f99a93e	44a43cc4-8d2e-4ce5-b437-2b76a205ea84	100.00	10.00	t	2025-10-09 05:16:43.196311
5c78306d-fc44-4053-a8ea-d3f8f34f51c3	a3642afb-c1e0-48b5-a089-cc429f99a93e	2d2976b5-f9bb-42e8-aca0-d6e6b6e6de77	100.00	10.00	t	2025-10-09 05:16:43.196311
0358401a-085a-4b3a-b464-81fb9992519f	a3642afb-c1e0-48b5-a089-cc429f99a93e	88fad813-46ed-4601-a334-ae77df797be3	100.00	10.00	t	2025-10-09 05:16:43.196311
96129ac3-eee8-49de-a922-eb5a4ff143ca	a3642afb-c1e0-48b5-a089-cc429f99a93e	9358b2c4-aebc-480a-9eff-6873c156da12	100.00	10.00	t	2025-10-09 05:16:43.196311
2dcca1ed-cedc-4bef-bd08-d7591501ccc3	a3642afb-c1e0-48b5-a089-cc429f99a93e	7022a346-204b-472a-b46b-b801f07e8853	100.00	10.00	t	2025-10-09 05:16:43.196311
dc0e364c-1d82-4db2-9241-0ed6d5abc836	a3642afb-c1e0-48b5-a089-cc429f99a93e	6852ffde-5e9e-4faa-be78-93d194b1f8b7	100.00	10.00	t	2025-10-09 05:16:43.196311
f2d3a26e-83de-4df7-b3d9-a705d22ad037	a3642afb-c1e0-48b5-a089-cc429f99a93e	ec97e568-30d6-4e8f-acb3-b74d1b4b5436	100.00	10.00	t	2025-10-09 05:16:43.196311
4a812137-5e56-4338-9ac7-2ece1afbe651	a3642afb-c1e0-48b5-a089-cc429f99a93e	41ab0a41-f16e-4bd5-961e-5b070acd6410	100.00	10.00	t	2025-10-09 05:16:43.196311
805c579f-14e8-4f68-bf3b-f84ef5d57d09	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	448cb56a-e4d6-44c4-a49b-8a6119f36843	100.00	10.00	t	2025-10-09 05:31:33.644677
19e734b9-528a-4fa2-b56c-f08b9bce5414	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	3554e4f4-8d4c-4b4a-9fe6-88eb1f5ef489	100.00	10.00	t	2025-10-09 05:31:33.644677
2a514381-0dff-4666-9993-e55dee6f33d4	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	f7be1839-a795-438b-b9da-54fed97ca1d7	100.00	10.00	t	2025-10-09 05:31:33.644677
2dcb9bfc-70aa-4682-bedf-78bfe1b4ec82	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	c42f0ccc-e7e4-447b-b392-ecd3eca5d764	100.00	10.00	t	2025-10-09 05:31:33.644677
48379608-1d94-48cf-bd98-0cbf50f227cc	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	9ceb0bdb-9f21-40da-b938-c7729ff2daa3	100.00	10.00	t	2025-10-09 05:31:33.644677
c75d9f70-931b-4e02-adc9-6b5b5561ad8e	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	6f903e44-300e-470c-aa64-125da9772880	100.00	10.00	t	2025-10-09 05:31:33.644677
ab779417-19e8-4dcd-9f72-3fdd7e4f84e7	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	24c6259e-6fbf-4a75-a66e-bd8a2894b261	100.00	10.00	t	2025-10-09 05:31:33.644677
8f52aea4-7a97-4bf7-b69c-1d8965c85cfb	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	77c73ecd-3988-4efa-af44-efe3725e9f14	100.00	10.00	t	2025-10-09 05:31:33.644677
84729037-9b45-4420-9539-c686410a289b	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	698deda3-2aa9-4d4f-8a14-2fb80faac986	100.00	10.00	t	2025-10-09 05:31:33.644677
5f626ab4-e035-44fd-91ae-18f213e1c05b	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	f2cb1b7e-41df-411f-abaa-2ac7cbf58674	100.00	10.00	t	2025-10-09 05:31:33.644677
3d664b75-0b22-474f-814e-67edf61e991a	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	6f74812e-ca45-4234-9a10-9bfe8f46467c	100.00	10.00	t	2025-10-09 05:31:33.644677
\.


--
-- Data for Name: intervention_quadrants; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.intervention_quadrants (id, intervention_id, quadrant_id, weightage, components, created_at) FROM stdin;
\.


--
-- Data for Name: intervention_tasks; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.intervention_tasks (id, intervention_id, title, description, due_date, status, created_at) FROM stdin;
\.


--
-- Data for Name: intervention_teachers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.intervention_teachers (id, intervention_id, teacher_id, assigned_quadrants, role, permissions, assigned_at, assigned_by, is_active) FROM stdin;
d7e21801-d1a0-46aa-ae16-2f34a6a6db5c	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	71e3d945-4236-4d79-87d7-9f3e1979f83b	[]	Lead	["score", "create_tasks"]	2025-10-08 15:36:08.322258	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	t
204a41f6-eac9-4a55-bf7e-7978ec6dec9f	708bb649-495c-45d0-a217-185f19446e75	71e3d945-4236-4d79-87d7-9f3e1979f83b	["Persona", "Discipline"]	Lead	[]	2025-10-09 04:29:15.926225	b0cde931-c687-42e5-9643-e36a15868f17	t
08890f20-658e-4279-a269-5d3b8f8dd49f	4d2ce8fc-08e8-4865-a179-0d326f3151da	71e3d945-4236-4d79-87d7-9f3e1979f83b	["Persona", "Discipline"]	Lead	[]	2025-10-09 04:53:15.81705	16459cad-4104-4955-8977-45eb93a63d4a	t
fc64c01c-3c3e-46ea-ae0c-c65815734f4a	79336918-2f2b-450a-b09b-70a320973d6c	71e3d945-4236-4d79-87d7-9f3e1979f83b	["Persona"]	Lead	[]	2025-10-09 05:04:52.56623	16459cad-4104-4955-8977-45eb93a63d4a	t
8cebc012-98ca-41bf-8d39-c4655120b62a	906b8089-4326-4a47-b82b-756db4f8916d	71e3d945-4236-4d79-87d7-9f3e1979f83b	["Persona", "Discipline"]	Lead	[]	2025-10-09 05:11:23.911815	16459cad-4104-4955-8977-45eb93a63d4a	t
a7fa3183-116f-4904-a252-6a9db3b02ca2	a3642afb-c1e0-48b5-a089-cc429f99a93e	71e3d945-4236-4d79-87d7-9f3e1979f83b	["Persona", "Discipline"]	Lead	[]	2025-10-09 05:16:49.435898	16459cad-4104-4955-8977-45eb93a63d4a	t
77d072d8-582b-4437-b2c6-bd06ae8a2851	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	71e3d945-4236-4d79-87d7-9f3e1979f83b	["Persona", "Discipline"]	Lead	[]	2025-10-09 05:31:40.276331	16459cad-4104-4955-8977-45eb93a63d4a	t
\.


--
-- Data for Name: interventions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.interventions (id, name, description, start_date, end_date, status, quadrant_weightages, prerequisites, max_students, objectives, created_by, created_at, updated_at, term_id, scoring_deadline, total_weightage, is_scoring_open) FROM stdin;
708bb649-495c-45d0-a217-185f19446e75	Book review 2	Book review intervention focusing on Negotiation and Discipline microcompetencies	2025-10-08	2025-10-22	Active	{}	[]	50	[]	16459cad-4104-4955-8977-45eb93a63d4a	2025-10-09 04:28:27.730809	2025-10-09 04:45:23.155949	694784ea-5501-483d-be6d-08f6667a6465	\N	100.00	f
4d2ce8fc-08e8-4865-a179-0d326f3151da	Business Proposal Report	Business Proposal Report intervention focusing on Empathy, Problem Solving, Team Work, and Discipline microcompetencies	2025-10-08	2025-10-22	Active	{}	[]	50	[]	16459cad-4104-4955-8977-45eb93a63d4a	2025-10-09 04:52:58.735365	2025-10-09 04:52:58.735365	694784ea-5501-483d-be6d-08f6667a6465	\N	100.00	f
79336918-2f2b-450a-b09b-70a320973d6c	EMAIL WRITING	EMAIL WRITING intervention focusing on Communication microcompetencies	2025-10-08	2025-10-22	Active	{}	[]	50	[]	16459cad-4104-4955-8977-45eb93a63d4a	2025-10-09 05:04:39.095174	2025-10-09 05:04:39.095174	694784ea-5501-483d-be6d-08f6667a6465	\N	100.00	f
906b8089-4326-4a47-b82b-756db4f8916d	Problem Solving	Problem Solving intervention focusing on Problem Solving and Discipline microcompetencies	2025-10-08	2025-10-22	Active	{}	[]	50	[]	16459cad-4104-4955-8977-45eb93a63d4a	2025-10-09 05:11:08.392887	2025-10-09 05:11:08.392887	694784ea-5501-483d-be6d-08f6667a6465	\N	100.00	f
a3642afb-c1e0-48b5-a089-cc429f99a93e	Debating	Debating intervention focusing on Analytical, Communication, Leadership, Problem Solving, Team Work, and Discipline microcompetencies	2025-10-08	2025-10-22	Active	{}	[]	50	[]	16459cad-4104-4955-8977-45eb93a63d4a	2025-10-09 05:16:33.215144	2025-10-09 05:16:33.215144	694784ea-5501-483d-be6d-08f6667a6465	\N	100.00	f
a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	CAPSTONE	CAPSTONE intervention focusing on Persona and Discipline CAPSTONE microcompetencies	2025-10-08	2025-10-22	Active	{}	[]	50	[]	16459cad-4104-4955-8977-45eb93a63d4a	2025-10-09 05:31:22.114503	2025-10-09 05:31:22.114503	694784ea-5501-483d-be6d-08f6667a6465	\N	100.00	f
b626892a-a3a5-4040-ab9c-5d8ff7c7d866	Story Telling	Auto-created from request	2025-10-08	2025-10-22	Active	{}	[]	50	[]	16459cad-4104-4955-8977-45eb93a63d4a	2025-10-08 15:35:49.287807	2025-10-09 04:40:38.618857	694784ea-5501-483d-be6d-08f6667a6465	\N	100.00	t
88db9091-ce2d-4403-8435-836d38255f2c	Book review	Book review intervention with microcompetencies: C1, C2, C3, C5, E1, A1, A2, A3, A4, P1, P2, P4, T1, D4, D5	2025-10-08	2025-10-22	Active	{}	[]	50	[]	16459cad-4104-4955-8977-45eb93a63d4a	2025-10-08 18:00:50.239765	2025-10-09 04:40:38.618857	694784ea-5501-483d-be6d-08f6667a6465	\N	100.00	f
\.


--
-- Data for Name: kos_sync_log; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.kos_sync_log (id, sync_type, status, users_synced, errors_count, error_details, started_at, completed_at, triggered_by) FROM stdin;
\.


--
-- Data for Name: microcompetencies; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.microcompetencies (id, component_id, name, description, weightage, max_score, display_order, is_active, created_at, updated_at) FROM stdin;
4476c3a6-58da-4c43-9b8a-b1da70172072	942dd95e-c3cc-4d75-872f-10284d06bc0c	A1		100.00	5.00	1	t	2025-10-08 09:31:10.114678	2025-10-08 17:44:34.625451
31a4c844-6a46-4b57-a23d-91d9a5ff7382	942dd95e-c3cc-4d75-872f-10284d06bc0c	A2		100.00	5.00	2	t	2025-10-08 09:31:10.114678	2025-10-08 17:44:34.625451
4d6b4184-d62e-427a-ba00-16ff3f4e4f10	942dd95e-c3cc-4d75-872f-10284d06bc0c	A3		100.00	5.00	3	t	2025-10-08 09:31:10.114678	2025-10-08 17:44:34.625451
06947927-aab0-4d24-b5fe-b42c0b83050c	942dd95e-c3cc-4d75-872f-10284d06bc0c	A4		100.00	5.00	4	t	2025-10-08 09:31:10.114678	2025-10-08 17:44:34.625451
6ef0dc2b-9fd6-40e2-a2c6-2485232d953c	942dd95e-c3cc-4d75-872f-10284d06bc0c	A5		100.00	5.00	5	t	2025-10-08 09:31:10.114678	2025-10-08 17:44:34.625451
7e8983cd-5a94-49cc-9b80-64358a9d48f9	61b99470-5e1d-4e02-9d4c-22836faca5f6	C1		100.00	5.00	1	t	2025-10-08 09:31:10.114678	2025-10-08 17:44:34.625451
685d23ad-eadc-47ac-9f91-8f741ae4211f	61b99470-5e1d-4e02-9d4c-22836faca5f6	C2		100.00	5.00	2	t	2025-10-08 09:31:10.114678	2025-10-08 17:44:34.625451
2e599a1f-e34d-436c-98f9-01f019cb29bd	61b99470-5e1d-4e02-9d4c-22836faca5f6	C3		100.00	5.00	3	t	2025-10-08 09:31:10.114678	2025-10-08 17:44:34.625451
1b63c6c1-36b6-49b5-a61f-1c3f2b85bdb1	61b99470-5e1d-4e02-9d4c-22836faca5f6	C4		100.00	5.00	4	t	2025-10-08 09:31:10.114678	2025-10-08 17:44:34.625451
44a43cc4-8d2e-4ce5-b437-2b76a205ea84	61b99470-5e1d-4e02-9d4c-22836faca5f6	C5		100.00	5.00	5	t	2025-10-08 09:31:10.114678	2025-10-08 17:44:34.625451
08314805-8508-4254-997b-a035415747d5	6d9537fa-408f-458f-8ce4-df168aca82b3	E1		100.00	5.00	1	t	2025-10-08 09:31:10.114678	2025-10-08 17:44:34.625451
9077e1c0-d24a-4477-983a-6b8aeaa43532	6d9537fa-408f-458f-8ce4-df168aca82b3	E2		100.00	5.00	2	t	2025-10-08 09:31:10.114678	2025-10-08 17:44:34.625451
64be578a-9f8e-4795-aeae-1b5dac189cce	34c05a81-5261-49cc-a48e-74beeffbbde9	A1 (C)	Analytical & Critical Thinking A1 for Capstone	100.00	5.00	0	t	2025-10-09 05:23:16.546509	2025-10-09 05:23:16.546509
be2ca789-8ed3-4c6f-808a-1dfb50c19877	34c05a81-5261-49cc-a48e-74beeffbbde9	A2 (C)	Analytical & Critical Thinking A2 for Capstone	100.00	5.00	0	t	2025-10-09 05:23:16.546509	2025-10-09 05:23:16.546509
448cb56a-e4d6-44c4-a49b-8a6119f36843	34c05a81-5261-49cc-a48e-74beeffbbde9	A3 (C)	Analytical & Critical Thinking A3 for Capstone	100.00	5.00	0	t	2025-10-09 05:23:16.546509	2025-10-09 05:23:16.546509
5a1ffe37-852a-4e75-96c8-5353fdbf9011	34c05a81-5261-49cc-a48e-74beeffbbde9	A4 (C)	Analytical & Critical Thinking A4 for Capstone	100.00	5.00	0	t	2025-10-09 05:23:16.546509	2025-10-09 05:23:16.546509
4680bc8d-b6f0-40e3-ba26-a05e68d21f14	34c05a81-5261-49cc-a48e-74beeffbbde9	A5 (C)	Analytical & Critical Thinking A5 for Capstone	100.00	5.00	0	t	2025-10-09 05:23:16.546509	2025-10-09 05:23:16.546509
9ceb0bdb-9f21-40da-b938-c7729ff2daa3	33a34606-c38f-41b4-b177-018d32e147fe	L1 (C)	Leadership L1 for Capstone	100.00	5.00	0	t	2025-10-09 05:23:33.12327	2025-10-09 05:23:33.12327
a48a6338-402d-482e-8d7a-b7193d97047a	33a34606-c38f-41b4-b177-018d32e147fe	L2 (C)	Leadership L2 for Capstone	100.00	5.00	0	t	2025-10-09 05:23:33.12327	2025-10-09 05:23:33.12327
55fa8528-6b9c-4f3c-9fb2-6de44c5d9cf0	33a34606-c38f-41b4-b177-018d32e147fe	L3 (C)	Leadership L3 for Capstone	100.00	5.00	0	t	2025-10-09 05:23:33.12327	2025-10-09 05:23:33.12327
457db1c7-044e-47a7-a820-e1e5114f9cea	33a34606-c38f-41b4-b177-018d32e147fe	L4 (C)	Leadership L4 for Capstone	100.00	5.00	0	t	2025-10-09 05:23:33.12327	2025-10-09 05:23:33.12327
31509ddf-18ee-4538-a2eb-5bbe560c0914	33a34606-c38f-41b4-b177-018d32e147fe	L5 (C)	Leadership L5 for Capstone	100.00	5.00	0	t	2025-10-09 05:23:33.12327	2025-10-09 05:23:33.12327
698deda3-2aa9-4d4f-8a14-2fb80faac986	1e184ce2-e271-4666-b316-cbdf446b6ff1	T1 (C)	Team Work T1 for Capstone	100.00	5.00	0	t	2025-10-09 05:23:49.270443	2025-10-09 05:23:49.270443
3f488cd4-bad3-46ec-9f92-1957e2924774	1e184ce2-e271-4666-b316-cbdf446b6ff1	T2 (C)	Team Work T2 for Capstone	100.00	5.00	0	t	2025-10-09 05:23:49.270443	2025-10-09 05:23:49.270443
6dad3ff1-9da6-4efd-9549-e8b4654529c7	1e184ce2-e271-4666-b316-cbdf446b6ff1	T3 (C)	Team Work T3 for Capstone	100.00	5.00	0	t	2025-10-09 05:23:49.270443	2025-10-09 05:23:49.270443
74771254-6da7-4ea1-a8b9-7ad3c99d75db	1e184ce2-e271-4666-b316-cbdf446b6ff1	T4 (C)	Team Work T4 for Capstone	100.00	5.00	0	t	2025-10-09 05:23:49.270443	2025-10-09 05:23:49.270443
a8953d15-fdda-490c-8a8e-1372f25c0a33	1e184ce2-e271-4666-b316-cbdf446b6ff1	T5 (C)	Team Work T5 for Capstone	100.00	5.00	0	t	2025-10-09 05:23:49.270443	2025-10-09 05:23:49.270443
76e855c0-ec81-4eae-a010-0e23b76426f1	6d9537fa-408f-458f-8ce4-df168aca82b3	E3		100.00	5.00	3	t	2025-10-08 09:31:10.114678	2025-10-08 17:44:34.625451
810f1b09-7630-4260-bf7e-5fa910cbb3dc	6d9537fa-408f-458f-8ce4-df168aca82b3	E4		100.00	5.00	4	t	2025-10-08 09:31:10.114678	2025-10-08 17:44:34.625451
01c4c2d4-ab2f-480f-b145-442ae56fad48	6d9537fa-408f-458f-8ce4-df168aca82b3	E5		100.00	5.00	5	t	2025-10-08 09:31:10.114678	2025-10-08 17:44:34.625451
2d2976b5-f9bb-42e8-aca0-d6e6b6e6de77	b464cb43-8128-4edd-8bc3-5ff6b58e7026	L1		100.00	5.00	1	t	2025-10-08 09:31:10.114678	2025-10-08 17:44:34.625451
22d1a89c-85d5-4403-8330-e34aa6c8b2fc	b464cb43-8128-4edd-8bc3-5ff6b58e7026	L2		100.00	5.00	2	t	2025-10-08 09:31:10.114678	2025-10-08 17:44:34.625451
7082bb51-3094-4606-8f92-106a1820e380	b464cb43-8128-4edd-8bc3-5ff6b58e7026	L3		100.00	5.00	3	t	2025-10-08 09:31:10.114678	2025-10-08 17:44:34.625451
101eb49e-efd6-4def-9a1f-11dce221cdba	b464cb43-8128-4edd-8bc3-5ff6b58e7026	L4		100.00	5.00	4	t	2025-10-08 09:31:10.114678	2025-10-08 17:44:34.625451
c030fd4f-5f7b-46ad-84b7-631adbeb1f40	b464cb43-8128-4edd-8bc3-5ff6b58e7026	L5		100.00	5.00	5	t	2025-10-08 09:31:10.114678	2025-10-08 17:44:34.625451
adbc17f9-6f88-4144-afe1-e29f3a0bd21e	04c55953-826b-41f9-81fc-6a7a8edbca62	N1		100.00	5.00	1	t	2025-10-08 09:31:10.114678	2025-10-08 17:44:34.625451
bcb48067-c6be-4c39-87bc-08618f18ef4e	04c55953-826b-41f9-81fc-6a7a8edbca62	N2		100.00	5.00	2	t	2025-10-08 09:31:10.114678	2025-10-08 17:44:34.625451
955efb94-7eac-4392-969a-732f19143f89	04c55953-826b-41f9-81fc-6a7a8edbca62	N3		100.00	5.00	3	t	2025-10-08 09:31:10.114678	2025-10-08 17:44:34.625451
45cfe4d4-2cc1-4dd3-b5a8-67ecc9d243c9	04c55953-826b-41f9-81fc-6a7a8edbca62	N4		100.00	5.00	4	t	2025-10-08 09:31:10.114678	2025-10-08 17:44:34.625451
cb21ea38-e7ad-4f8d-b4c4-33f892cd9119	4c6ad1ae-7165-432e-a915-4102082c36cf	C1 (C)	Communication C1 for Capstone	100.00	5.00	0	t	2025-10-09 05:23:21.231589	2025-10-09 05:23:21.231589
3554e4f4-8d4c-4b4a-9fe6-88eb1f5ef489	4c6ad1ae-7165-432e-a915-4102082c36cf	C2 (C)	Communication C2 for Capstone	100.00	5.00	0	t	2025-10-09 05:23:21.231589	2025-10-09 05:23:21.231589
f7be1839-a795-438b-b9da-54fed97ca1d7	4c6ad1ae-7165-432e-a915-4102082c36cf	C3 (C)	Communication C3 for Capstone	100.00	5.00	0	t	2025-10-09 05:23:21.231589	2025-10-09 05:23:21.231589
3da28c94-987a-419d-ac12-822d05bd8448	4c6ad1ae-7165-432e-a915-4102082c36cf	C4 (C)	Communication C4 for Capstone	100.00	5.00	0	t	2025-10-09 05:23:21.231589	2025-10-09 05:23:21.231589
c42f0ccc-e7e4-447b-b392-ecd3eca5d764	4c6ad1ae-7165-432e-a915-4102082c36cf	C5 (C)	Communication C5 for Capstone	100.00	5.00	0	t	2025-10-09 05:23:21.231589	2025-10-09 05:23:21.231589
544af37f-9528-4ef3-bc99-5870532c51d5	dbbfaec0-c416-4124-8e84-0e6fd939b203	N1 (C)	Negotiation N1 for Capstone	100.00	5.00	0	t	2025-10-09 05:23:38.87277	2025-10-09 05:23:38.87277
d3660cf9-b4c4-4c12-bba3-766c128a43ac	dbbfaec0-c416-4124-8e84-0e6fd939b203	N2 (C)	Negotiation N2 for Capstone	100.00	5.00	0	t	2025-10-09 05:23:38.87277	2025-10-09 05:23:38.87277
a0ce1af3-fabf-4a1a-851e-edb00cd10f22	dbbfaec0-c416-4124-8e84-0e6fd939b203	N3 (C)	Negotiation N3 for Capstone	100.00	5.00	0	t	2025-10-09 05:23:38.87277	2025-10-09 05:23:38.87277
d69b272d-0f08-4157-8db3-43ba94def224	dbbfaec0-c416-4124-8e84-0e6fd939b203	N4 (C)	Negotiation N4 for Capstone	100.00	5.00	0	t	2025-10-09 05:23:38.87277	2025-10-09 05:23:38.87277
3e8102b3-e71f-4739-8682-b5ebcbdbd6a5	dbbfaec0-c416-4124-8e84-0e6fd939b203	N5 (C)	Negotiation N5 for Capstone	100.00	5.00	0	t	2025-10-09 05:23:38.87277	2025-10-09 05:23:38.87277
cd6c3b70-cdbb-47c6-b1bb-d3236ee53d03	47a5b091-72ec-47d9-9028-c2e80a1dfa4c	D1 (C)	Academics D1 for Capstone	100.00	5.00	0	t	2025-10-09 05:26:40.999079	2025-10-09 05:26:40.999079
4624333f-29fe-4075-9023-9526c56f1783	47a5b091-72ec-47d9-9028-c2e80a1dfa4c	D2 (C)	Academics D2 for Capstone	100.00	5.00	0	t	2025-10-09 05:26:40.999079	2025-10-09 05:26:40.999079
2f71659a-9d89-4d70-8319-b6ef85764acf	47a5b091-72ec-47d9-9028-c2e80a1dfa4c	D3 (C)	Academics D3 for Capstone	100.00	5.00	0	t	2025-10-09 05:26:40.999079	2025-10-09 05:26:40.999079
f2cb1b7e-41df-411f-abaa-2ac7cbf58674	47a5b091-72ec-47d9-9028-c2e80a1dfa4c	D4 (C)	Academics D4 for Capstone	100.00	5.00	0	t	2025-10-09 05:26:40.999079	2025-10-09 05:26:40.999079
6f74812e-ca45-4234-9a10-9bfe8f46467c	47a5b091-72ec-47d9-9028-c2e80a1dfa4c	D5 (C)	Academics D5 for Capstone	100.00	5.00	0	t	2025-10-09 05:26:40.999079	2025-10-09 05:26:40.999079
0decb9dd-8b4c-471e-97ab-df29e7bb212c	04c55953-826b-41f9-81fc-6a7a8edbca62	N5		100.00	5.00	5	t	2025-10-08 09:31:10.114678	2025-10-08 17:44:34.625451
88fad813-46ed-4601-a334-ae77df797be3	4dfe00e4-716a-4358-8185-f9672ddf7ad3	P1		100.00	5.00	1	t	2025-10-08 09:31:10.114678	2025-10-08 17:44:34.625451
9358b2c4-aebc-480a-9eff-6873c156da12	4dfe00e4-716a-4358-8185-f9672ddf7ad3	P2		100.00	5.00	2	t	2025-10-08 09:31:10.114678	2025-10-08 17:44:34.625451
d5760d32-ce61-48fd-988e-9bd16cc52ca1	4dfe00e4-716a-4358-8185-f9672ddf7ad3	P3		100.00	5.00	3	t	2025-10-08 09:31:10.114678	2025-10-08 17:44:34.625451
7022a346-204b-472a-b46b-b801f07e8853	4dfe00e4-716a-4358-8185-f9672ddf7ad3	P4		100.00	5.00	4	t	2025-10-08 09:31:10.114678	2025-10-08 17:44:34.625451
c26c7d3d-7062-4ac5-a1f5-a69b17724eaa	4dfe00e4-716a-4358-8185-f9672ddf7ad3	P5		100.00	5.00	5	t	2025-10-08 09:31:10.114678	2025-10-08 17:44:34.625451
6852ffde-5e9e-4faa-be78-93d194b1f8b7	08273004-dc4c-4738-8740-507d23ac7c22	T1		100.00	5.00	1	t	2025-10-08 09:31:10.114678	2025-10-08 17:44:34.625451
de38ca59-7d04-4de2-acfd-6daf46162a07	08273004-dc4c-4738-8740-507d23ac7c22	T2		100.00	5.00	2	t	2025-10-08 09:31:10.114678	2025-10-08 17:44:34.625451
6350fa4f-4163-42b7-a37a-16be275b9418	08273004-dc4c-4738-8740-507d23ac7c22	T3		100.00	5.00	3	t	2025-10-08 09:31:10.114678	2025-10-08 17:44:34.625451
7453ffe7-e829-4f52-a16b-44efbc183640	08273004-dc4c-4738-8740-507d23ac7c22	T4		100.00	5.00	4	t	2025-10-08 09:31:10.114678	2025-10-08 17:44:34.625451
fbd8f3d7-1bbe-4e3c-955f-c370b9f7f680	08273004-dc4c-4738-8740-507d23ac7c22	T5		100.00	5.00	5	t	2025-10-08 09:31:10.114678	2025-10-08 17:44:34.625451
569954c7-4f99-425c-9454-45277997273b	72115e64-922a-4df2-a20e-aadebbb0eab3	Push Ups		100.00	5.00	1	t	2025-10-08 09:51:32.517897	2025-10-08 17:44:34.625451
13936326-3a08-46e7-9577-cfee038577f0	72115e64-922a-4df2-a20e-aadebbb0eab3	Sit Ups		100.00	5.00	2	t	2025-10-08 09:51:32.517897	2025-10-08 17:44:34.625451
5fd87c78-5e02-4ec6-8706-1a2678ee90b4	72115e64-922a-4df2-a20e-aadebbb0eab3	Sit & reach		100.00	5.00	3	t	2025-10-08 09:51:32.517897	2025-10-08 17:44:34.625451
9136ba3e-9c59-47ab-ab64-67a2f84b74f4	72115e64-922a-4df2-a20e-aadebbb0eab3	Beep test		100.00	5.00	4	t	2025-10-08 09:51:32.517897	2025-10-08 17:44:34.625451
47c94861-1830-4e10-97f0-5f0b5a7f9c05	72115e64-922a-4df2-a20e-aadebbb0eab3	3KM Run		100.00	5.00	5	t	2025-10-08 09:51:32.517897	2025-10-08 17:44:34.625451
a6fc7ef9-8ebc-47cc-b9b5-48b404599670	72115e64-922a-4df2-a20e-aadebbb0eab3	BCA		100.00	5.00	6	t	2025-10-08 09:51:32.517897	2025-10-08 17:44:34.625451
5016201d-732e-4a7f-8e7e-c9d3fa3b2030	9ec8e344-1032-47ff-8c4e-e52c721f6150	D1		100.00	5.00	1	t	2025-10-08 09:51:56.242166	2025-10-08 17:44:34.625451
10163f9f-5bb3-4bdc-b3c8-9ddf17b2e3b6	9ec8e344-1032-47ff-8c4e-e52c721f6150	D2		100.00	5.00	2	t	2025-10-08 09:51:56.242166	2025-10-08 17:44:34.625451
0322c72d-2fbf-462d-9a59-76e1550b30d9	9ec8e344-1032-47ff-8c4e-e52c721f6150	D3		100.00	5.00	3	t	2025-10-08 09:51:56.242166	2025-10-08 17:44:34.625451
ec97e568-30d6-4e8f-acb3-b74d1b4b5436	9ec8e344-1032-47ff-8c4e-e52c721f6150	D4		100.00	5.00	4	t	2025-10-08 09:51:56.242166	2025-10-08 17:44:34.625451
41ab0a41-f16e-4bd5-961e-5b070acd6410	9ec8e344-1032-47ff-8c4e-e52c721f6150	D5		100.00	5.00	5	t	2025-10-08 09:51:56.242166	2025-10-08 17:44:34.625451
b2e23679-040c-4d57-9ab7-4a019c00652a	5bd8fc59-1862-48bf-abf0-428da25a1b07	E1 (C)	Empathy E1 for Capstone	100.00	5.00	0	t	2025-10-09 05:23:27.170852	2025-10-09 05:23:27.170852
7a0abf02-6038-45d0-9a9d-4d0a25e44019	5bd8fc59-1862-48bf-abf0-428da25a1b07	E2 (C)	Empathy E2 for Capstone	100.00	5.00	0	t	2025-10-09 05:23:27.170852	2025-10-09 05:23:27.170852
b7d67908-6205-4863-a694-d7dba56e1d39	5bd8fc59-1862-48bf-abf0-428da25a1b07	E3 (C)	Empathy E3 for Capstone	100.00	5.00	0	t	2025-10-09 05:23:27.170852	2025-10-09 05:23:27.170852
30b71cb1-97df-4655-8704-0560bcf5da06	5bd8fc59-1862-48bf-abf0-428da25a1b07	E4 (C)	Empathy E4 for Capstone	100.00	5.00	0	t	2025-10-09 05:23:27.170852	2025-10-09 05:23:27.170852
f658c2c3-3d12-4798-bccb-9af886cd15eb	5bd8fc59-1862-48bf-abf0-428da25a1b07	E5 (C)	Empathy E5 for Capstone	100.00	5.00	0	t	2025-10-09 05:23:27.170852	2025-10-09 05:23:27.170852
6f903e44-300e-470c-aa64-125da9772880	5f879989-7fbb-420c-b532-31939fb64bf3	P1 (C)	Problem Solving P1 for Capstone	100.00	5.00	0	t	2025-10-09 05:23:43.773227	2025-10-09 05:23:43.773227
24c6259e-6fbf-4a75-a66e-bd8a2894b261	5f879989-7fbb-420c-b532-31939fb64bf3	P2 (C)	Problem Solving P2 for Capstone	100.00	5.00	0	t	2025-10-09 05:23:43.773227	2025-10-09 05:23:43.773227
a2287dfb-4153-4222-91dd-5ab86abcd82a	5f879989-7fbb-420c-b532-31939fb64bf3	P3 (C)	Problem Solving P3 for Capstone	100.00	5.00	0	t	2025-10-09 05:23:43.773227	2025-10-09 05:23:43.773227
77c73ecd-3988-4efa-af44-efe3725e9f14	5f879989-7fbb-420c-b532-31939fb64bf3	P4 (C)	Problem Solving P4 for Capstone	100.00	5.00	0	t	2025-10-09 05:23:43.773227	2025-10-09 05:23:43.773227
3125cce7-fab5-4000-a4ec-d6cb3069e730	5f879989-7fbb-420c-b532-31939fb64bf3	P5 (C)	Problem Solving P5 for Capstone	100.00	5.00	0	t	2025-10-09 05:23:43.773227	2025-10-09 05:23:43.773227
\.


--
-- Data for Name: microcompetency_scores; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.microcompetency_scores (id, student_id, intervention_id, microcompetency_id, obtained_score, max_score, scored_by, scored_at, feedback, status, term_id) FROM stdin;
d3fe90c4-4e53-4856-9149-f0ea97ae677e	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	88db9091-ce2d-4403-8435-836d38255f2c	7e8983cd-5a94-49cc-9b80-64358a9d48f9	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:24:39.060001	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
4f05a5a6-a3ce-482c-93c8-9b6515d2494c	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	88db9091-ce2d-4403-8435-836d38255f2c	685d23ad-eadc-47ac-9f91-8f741ae4211f	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:24:39.060001	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
54ace22f-b02a-4427-9180-a1c2972bbfe0	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	88db9091-ce2d-4403-8435-836d38255f2c	4476c3a6-58da-4c43-9b8a-b1da70172072	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:24:58.006659	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
a77926f7-4af5-4269-ac5e-1cb7d4a73251	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	88db9091-ce2d-4403-8435-836d38255f2c	31a4c844-6a46-4b57-a23d-91d9a5ff7382	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:24:58.006659	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
614b270e-103f-473d-9a0b-cb3ad65da0d3	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	88db9091-ce2d-4403-8435-836d38255f2c	4d6b4184-d62e-427a-ba00-16ff3f4e4f10	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:24:58.006659	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
90e64615-b150-477a-a636-329a0e3256c2	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	88db9091-ce2d-4403-8435-836d38255f2c	7e8983cd-5a94-49cc-9b80-64358a9d48f9	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:24:58.006659	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
95f222c1-682d-4adb-b02a-950cfdf3922b	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	88db9091-ce2d-4403-8435-836d38255f2c	685d23ad-eadc-47ac-9f91-8f741ae4211f	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:24:58.006659	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
affcded7-6d00-4c3a-bdbd-9b5dde485acf	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	88db9091-ce2d-4403-8435-836d38255f2c	2e599a1f-e34d-436c-98f9-01f019cb29bd	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:24:58.006659	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
991e9741-9c5b-442a-aa30-c7862eb6c8f6	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	88db9091-ce2d-4403-8435-836d38255f2c	44a43cc4-8d2e-4ce5-b437-2b76a205ea84	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:24:58.006659	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
ef5ab453-69b5-42c8-84a5-1c063781e722	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	88db9091-ce2d-4403-8435-836d38255f2c	88fad813-46ed-4601-a334-ae77df797be3	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:24:58.006659	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
ea85df95-e656-4084-a75c-9cfb8b7445b4	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	88db9091-ce2d-4403-8435-836d38255f2c	9358b2c4-aebc-480a-9eff-6873c156da12	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:24:58.006659	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
2cab557a-21c9-4447-90ce-48f3b484e47d	30da9b2e-814c-408d-823b-f2719459e315	88db9091-ce2d-4403-8435-836d38255f2c	06947927-aab0-4d24-b5fe-b42c0b83050c	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
e20932f7-3677-4193-9503-f084199a8cd4	30da9b2e-814c-408d-823b-f2719459e315	88db9091-ce2d-4403-8435-836d38255f2c	08314805-8508-4254-997b-a035415747d5	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
aada05ba-2e9e-4d97-b059-cf5d18a40ca0	30da9b2e-814c-408d-823b-f2719459e315	88db9091-ce2d-4403-8435-836d38255f2c	2e599a1f-e34d-436c-98f9-01f019cb29bd	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
fd73cc87-c2f4-489f-affe-7df74e22d65e	30da9b2e-814c-408d-823b-f2719459e315	88db9091-ce2d-4403-8435-836d38255f2c	31a4c844-6a46-4b57-a23d-91d9a5ff7382	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
55150416-777b-4fd1-9977-65a1620ecdc6	30da9b2e-814c-408d-823b-f2719459e315	88db9091-ce2d-4403-8435-836d38255f2c	4476c3a6-58da-4c43-9b8a-b1da70172072	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
c7afad68-beed-4abb-af8d-df6e0b689d0f	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	4476c3a6-58da-4c43-9b8a-b1da70172072	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:38:41.11252	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
e7ecc975-cae2-470b-bd6a-4edd13afd747	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	31a4c844-6a46-4b57-a23d-91d9a5ff7382	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:38:41.11252	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
0133c5b0-e16a-4cd2-adfb-ccaddedc4129	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	4d6b4184-d62e-427a-ba00-16ff3f4e4f10	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:38:41.11252	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
a7a04c54-4704-4bbc-90fe-83e6d5331a71	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	06947927-aab0-4d24-b5fe-b42c0b83050c	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:38:41.11252	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
90f21d6e-994e-45a9-a257-309844266223	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	7e8983cd-5a94-49cc-9b80-64358a9d48f9	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:38:41.11252	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
26478064-a218-4592-bedb-3ca637f94242	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	685d23ad-eadc-47ac-9f91-8f741ae4211f	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:38:41.11252	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
d1f0ce34-8aab-4b6b-bc41-bf584d1b9dff	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	2e599a1f-e34d-436c-98f9-01f019cb29bd	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:38:41.11252	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
36aa31f3-f132-4753-8e22-0065021525ed	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	44a43cc4-8d2e-4ce5-b437-2b76a205ea84	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:38:41.11252	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
7ded3ab3-e6b7-429b-a707-d8a646b86a9e	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	08314805-8508-4254-997b-a035415747d5	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:38:41.11252	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
50ce4dc2-d589-4c36-81ca-ac58565bab98	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	88fad813-46ed-4601-a334-ae77df797be3	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:38:41.11252	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
297a2554-5e80-4cec-ae21-f835655bb8f6	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	9358b2c4-aebc-480a-9eff-6873c156da12	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:38:41.11252	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
62e85d9e-41e2-4601-a8f1-2bf6b1043d4c	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	7022a346-204b-472a-b46b-b801f07e8853	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:38:41.11252	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
20b7c40d-5a9a-4ffc-95bd-7732be54786c	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	6852ffde-5e9e-4faa-be78-93d194b1f8b7	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:38:41.11252	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
c2c6b1f6-c764-4839-b3de-c14ad5b0db23	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	ec97e568-30d6-4e8f-acb3-b74d1b4b5436	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:38:41.11252	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
fbd66e0f-6dab-48be-854d-efe6556592cd	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	41ab0a41-f16e-4bd5-961e-5b070acd6410	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:38:41.11252	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
e36f701e-55ab-4f1c-8951-6b45bb803834	f81b6756-e9c8-4a45-8704-bcc647f20d12	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	7022a346-204b-472a-b46b-b801f07e8853	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
bc5e5b6b-2b3a-474b-97d8-b1bc02df6fb9	f81b6756-e9c8-4a45-8704-bcc647f20d12	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	6852ffde-5e9e-4faa-be78-93d194b1f8b7	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
847dce14-0be0-4351-b289-b8297112cbc5	f81b6756-e9c8-4a45-8704-bcc647f20d12	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	ec97e568-30d6-4e8f-acb3-b74d1b4b5436	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
95a713e5-e418-44bf-a09c-753050da1b30	f81b6756-e9c8-4a45-8704-bcc647f20d12	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	41ab0a41-f16e-4bd5-961e-5b070acd6410	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
5c2dcb75-648a-42c7-853f-9739d8a7ab29	a677d812-3140-440f-9603-2cff99ca31d4	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	4476c3a6-58da-4c43-9b8a-b1da70172072	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
6c56b8a8-1511-481f-9e5c-b65eabe21b92	a677d812-3140-440f-9603-2cff99ca31d4	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	31a4c844-6a46-4b57-a23d-91d9a5ff7382	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
912e58cb-d823-42b3-9a1e-149368b8669f	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	88db9091-ce2d-4403-8435-836d38255f2c	2e599a1f-e34d-436c-98f9-01f019cb29bd	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:24:39.060001	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
5f3f5454-afa0-42a7-911f-16ff8f1e10c2	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	88db9091-ce2d-4403-8435-836d38255f2c	08314805-8508-4254-997b-a035415747d5	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:24:39.060001	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
bf9e47e9-ecb0-4493-ab51-f77a2b72c7f2	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	88db9091-ce2d-4403-8435-836d38255f2c	88fad813-46ed-4601-a334-ae77df797be3	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:24:39.060001	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
4d452c44-2bd6-4eea-954b-0dbf2cfa8f2b	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	88db9091-ce2d-4403-8435-836d38255f2c	6852ffde-5e9e-4faa-be78-93d194b1f8b7	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:24:39.060001	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
4e6803d1-de76-4142-bda8-900bd1b1d283	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	88db9091-ce2d-4403-8435-836d38255f2c	ec97e568-30d6-4e8f-acb3-b74d1b4b5436	5.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:24:39.060001	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
8698d673-a548-4885-8498-f1bc30d3e54c	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	88db9091-ce2d-4403-8435-836d38255f2c	41ab0a41-f16e-4bd5-961e-5b070acd6410	5.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:24:39.060001	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
309eccd9-d05f-4b2d-84ed-e585252cb651	30da9b2e-814c-408d-823b-f2719459e315	88db9091-ce2d-4403-8435-836d38255f2c	41ab0a41-f16e-4bd5-961e-5b070acd6410	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
0f6171da-646b-418d-9d0c-e3c648bdca0e	30da9b2e-814c-408d-823b-f2719459e315	88db9091-ce2d-4403-8435-836d38255f2c	6852ffde-5e9e-4faa-be78-93d194b1f8b7	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
f9a5e318-a12b-45dd-9057-46ba321060b6	30da9b2e-814c-408d-823b-f2719459e315	88db9091-ce2d-4403-8435-836d38255f2c	ec97e568-30d6-4e8f-acb3-b74d1b4b5436	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
819e09dd-cf3e-4516-816a-f6006d419dae	f81b6756-e9c8-4a45-8704-bcc647f20d12	88db9091-ce2d-4403-8435-836d38255f2c	4476c3a6-58da-4c43-9b8a-b1da70172072	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
3b212654-9a6a-4b96-89c6-aee726ff34cc	f81b6756-e9c8-4a45-8704-bcc647f20d12	88db9091-ce2d-4403-8435-836d38255f2c	31a4c844-6a46-4b57-a23d-91d9a5ff7382	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
b5e7a9f4-78e4-4af1-9d0f-d8078b461c4d	f81b6756-e9c8-4a45-8704-bcc647f20d12	88db9091-ce2d-4403-8435-836d38255f2c	4d6b4184-d62e-427a-ba00-16ff3f4e4f10	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
b067f613-93ec-4847-91f7-55ba385f303d	f81b6756-e9c8-4a45-8704-bcc647f20d12	88db9091-ce2d-4403-8435-836d38255f2c	06947927-aab0-4d24-b5fe-b42c0b83050c	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
a8aa69b4-a429-4843-a62e-b541817c79ca	f81b6756-e9c8-4a45-8704-bcc647f20d12	88db9091-ce2d-4403-8435-836d38255f2c	7e8983cd-5a94-49cc-9b80-64358a9d48f9	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
49d732da-2ebe-4878-b8f8-8ebe585cdbdf	f81b6756-e9c8-4a45-8704-bcc647f20d12	88db9091-ce2d-4403-8435-836d38255f2c	685d23ad-eadc-47ac-9f91-8f741ae4211f	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
e825db77-0a00-4348-8d64-a536864d521e	a677d812-3140-440f-9603-2cff99ca31d4	88db9091-ce2d-4403-8435-836d38255f2c	06947927-aab0-4d24-b5fe-b42c0b83050c	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
19c000ec-830c-4a2e-a99b-968e4cd448e5	a677d812-3140-440f-9603-2cff99ca31d4	88db9091-ce2d-4403-8435-836d38255f2c	31a4c844-6a46-4b57-a23d-91d9a5ff7382	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
3898af29-cf5f-442a-96db-9b79e18c011e	a677d812-3140-440f-9603-2cff99ca31d4	88db9091-ce2d-4403-8435-836d38255f2c	4476c3a6-58da-4c43-9b8a-b1da70172072	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
3a112ffb-ea2a-4807-8500-c6363791e3fa	a677d812-3140-440f-9603-2cff99ca31d4	88db9091-ce2d-4403-8435-836d38255f2c	4d6b4184-d62e-427a-ba00-16ff3f4e4f10	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
fa81be86-87fd-4dff-ae7d-8757def59aef	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	4476c3a6-58da-4c43-9b8a-b1da70172072	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:39:09.213387	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
4cb2a6a1-f2ee-40fb-b65b-a8b06b23cae5	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	31a4c844-6a46-4b57-a23d-91d9a5ff7382	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:39:09.213387	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
6eb509be-0d61-4314-b87b-671a1d7d7da7	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	4d6b4184-d62e-427a-ba00-16ff3f4e4f10	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:39:09.213387	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
d03fc644-c031-4d8f-bb40-b9a435c846ea	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	06947927-aab0-4d24-b5fe-b42c0b83050c	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:39:09.213387	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
de8b8270-352e-4efb-b344-03ae9a1adf5f	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	7e8983cd-5a94-49cc-9b80-64358a9d48f9	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:39:09.213387	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
5e7873a2-ce21-4f13-857b-6c62edd4d13d	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	685d23ad-eadc-47ac-9f91-8f741ae4211f	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:39:09.213387	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
d928c76d-e807-4961-9505-03d4a470c6fa	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	2e599a1f-e34d-436c-98f9-01f019cb29bd	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:39:09.213387	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
7812be94-e25b-44ea-ac2e-7538775e7d06	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	44a43cc4-8d2e-4ce5-b437-2b76a205ea84	5.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:39:09.213387	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
3dcc019f-999b-41fb-99a9-dbb97b99db04	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	08314805-8508-4254-997b-a035415747d5	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:39:09.213387	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
a2031cd9-0ab3-46c4-bbe4-afd2c8398436	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	88fad813-46ed-4601-a334-ae77df797be3	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:39:09.213387	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
3db12707-2578-458f-8b88-10a9cf383c19	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	9358b2c4-aebc-480a-9eff-6873c156da12	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:39:09.213387	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
cb875da7-dff2-4216-92ec-6925186448e2	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	7022a346-204b-472a-b46b-b801f07e8853	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:39:09.213387	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
5f3d14de-8a75-4a43-ace2-91b971db4392	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	6852ffde-5e9e-4faa-be78-93d194b1f8b7	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:39:09.213387	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
ee758c2a-51e4-46bd-b230-e9efb39d665b	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	ec97e568-30d6-4e8f-acb3-b74d1b4b5436	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:39:09.213387	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
f2785970-1a06-418d-8c11-902180b387f2	a677d812-3140-440f-9603-2cff99ca31d4	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	4d6b4184-d62e-427a-ba00-16ff3f4e4f10	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
ca377c05-00c3-4704-8669-c37463870672	a677d812-3140-440f-9603-2cff99ca31d4	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	06947927-aab0-4d24-b5fe-b42c0b83050c	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
758ccb20-66f1-4f06-9b1c-fb2b437f5a02	a677d812-3140-440f-9603-2cff99ca31d4	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	7e8983cd-5a94-49cc-9b80-64358a9d48f9	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
23f85656-4ac9-4897-aec8-340c1568914f	a677d812-3140-440f-9603-2cff99ca31d4	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	685d23ad-eadc-47ac-9f91-8f741ae4211f	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
32f272d7-f70e-4c63-a8b2-c7da112e8979	a677d812-3140-440f-9603-2cff99ca31d4	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	2e599a1f-e34d-436c-98f9-01f019cb29bd	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
f5c49f6f-0b58-4949-883e-31c21b0a0543	f81b6756-e9c8-4a45-8704-bcc647f20d12	88db9091-ce2d-4403-8435-836d38255f2c	2e599a1f-e34d-436c-98f9-01f019cb29bd	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
16e5de02-8de9-4fea-95de-49ebb67d617b	f81b6756-e9c8-4a45-8704-bcc647f20d12	88db9091-ce2d-4403-8435-836d38255f2c	44a43cc4-8d2e-4ce5-b437-2b76a205ea84	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
3e1b643c-a2e8-45be-9da8-89645d964c30	f81b6756-e9c8-4a45-8704-bcc647f20d12	88db9091-ce2d-4403-8435-836d38255f2c	08314805-8508-4254-997b-a035415747d5	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
d3e9085d-3c83-4722-9065-2151bc3f4806	f81b6756-e9c8-4a45-8704-bcc647f20d12	88db9091-ce2d-4403-8435-836d38255f2c	88fad813-46ed-4601-a334-ae77df797be3	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
eb7e9c2b-8491-437e-8612-2c2c4a5dd00c	f81b6756-e9c8-4a45-8704-bcc647f20d12	88db9091-ce2d-4403-8435-836d38255f2c	9358b2c4-aebc-480a-9eff-6873c156da12	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
98f251cf-d137-42f3-bb09-1c1930d6609f	f81b6756-e9c8-4a45-8704-bcc647f20d12	88db9091-ce2d-4403-8435-836d38255f2c	7022a346-204b-472a-b46b-b801f07e8853	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
8c0e76b7-6241-4850-bca6-05179c19092e	f81b6756-e9c8-4a45-8704-bcc647f20d12	88db9091-ce2d-4403-8435-836d38255f2c	6852ffde-5e9e-4faa-be78-93d194b1f8b7	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
19afc9ee-21bc-4860-b640-e9670b2680e4	a677d812-3140-440f-9603-2cff99ca31d4	88db9091-ce2d-4403-8435-836d38255f2c	08314805-8508-4254-997b-a035415747d5	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
5df892fb-89b3-430f-927d-6bf8676bbcdd	a677d812-3140-440f-9603-2cff99ca31d4	88db9091-ce2d-4403-8435-836d38255f2c	2e599a1f-e34d-436c-98f9-01f019cb29bd	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
b9965b13-e492-4ecc-a5f3-0ab996c44b7c	a677d812-3140-440f-9603-2cff99ca31d4	88db9091-ce2d-4403-8435-836d38255f2c	41ab0a41-f16e-4bd5-961e-5b070acd6410	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
d9e1c757-4a4b-457f-ab2b-5df37f859510	a677d812-3140-440f-9603-2cff99ca31d4	88db9091-ce2d-4403-8435-836d38255f2c	44a43cc4-8d2e-4ce5-b437-2b76a205ea84	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
64c5c901-102e-4b2e-bab0-1b15922411f2	a677d812-3140-440f-9603-2cff99ca31d4	88db9091-ce2d-4403-8435-836d38255f2c	6852ffde-5e9e-4faa-be78-93d194b1f8b7	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
e75319f2-9485-48ec-b078-c4c784e1ef48	a677d812-3140-440f-9603-2cff99ca31d4	88db9091-ce2d-4403-8435-836d38255f2c	685d23ad-eadc-47ac-9f91-8f741ae4211f	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
8407e6cd-fd1e-49a9-a140-45f80371580c	30da9b2e-814c-408d-823b-f2719459e315	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	4476c3a6-58da-4c43-9b8a-b1da70172072	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
e2576864-da1f-4c66-b178-4aa78b0f2675	30da9b2e-814c-408d-823b-f2719459e315	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	31a4c844-6a46-4b57-a23d-91d9a5ff7382	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
e36a9323-b338-4f45-9363-c5a5c8d4acb7	30da9b2e-814c-408d-823b-f2719459e315	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	4d6b4184-d62e-427a-ba00-16ff3f4e4f10	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
0ee3eef3-5b61-49a6-875a-18078cc2917e	30da9b2e-814c-408d-823b-f2719459e315	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	06947927-aab0-4d24-b5fe-b42c0b83050c	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
e3598ae5-4bd5-4fdc-a9ad-26f9165070af	30da9b2e-814c-408d-823b-f2719459e315	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	7e8983cd-5a94-49cc-9b80-64358a9d48f9	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
fde67e20-8fcb-4568-bd86-682990150f2c	30da9b2e-814c-408d-823b-f2719459e315	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	685d23ad-eadc-47ac-9f91-8f741ae4211f	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
2534c91c-9f5d-40f5-8d69-46620d0fca02	30da9b2e-814c-408d-823b-f2719459e315	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	2e599a1f-e34d-436c-98f9-01f019cb29bd	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
e5e46b81-7807-4b33-be82-e04e896de004	30da9b2e-814c-408d-823b-f2719459e315	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	44a43cc4-8d2e-4ce5-b437-2b76a205ea84	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
45c1de6c-b245-4af1-8042-658e31d02d89	30da9b2e-814c-408d-823b-f2719459e315	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	08314805-8508-4254-997b-a035415747d5	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
cc07b7a2-f866-4ad8-8630-96b1607049d5	30da9b2e-814c-408d-823b-f2719459e315	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	88fad813-46ed-4601-a334-ae77df797be3	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
b8331724-11f6-4434-9b54-33a08444e10e	30da9b2e-814c-408d-823b-f2719459e315	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	9358b2c4-aebc-480a-9eff-6873c156da12	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
ee51033d-e470-48a6-9606-12ac9a5e507c	30da9b2e-814c-408d-823b-f2719459e315	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	7022a346-204b-472a-b46b-b801f07e8853	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
5812ce0e-69f9-445a-acf0-69c94570cdfc	30da9b2e-814c-408d-823b-f2719459e315	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	6852ffde-5e9e-4faa-be78-93d194b1f8b7	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
d8269ce1-1c27-4df0-8ca3-12782b83ad3a	30da9b2e-814c-408d-823b-f2719459e315	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	ec97e568-30d6-4e8f-acb3-b74d1b4b5436	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
de39a549-bcdc-4895-80fa-127a3fdf0329	30da9b2e-814c-408d-823b-f2719459e315	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	41ab0a41-f16e-4bd5-961e-5b070acd6410	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
9ab3a8ac-a930-4216-883e-9e5e21b6184b	f81b6756-e9c8-4a45-8704-bcc647f20d12	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	4476c3a6-58da-4c43-9b8a-b1da70172072	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
a86c7c7a-fd7f-4082-8074-fc34b5bc33a7	f81b6756-e9c8-4a45-8704-bcc647f20d12	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	31a4c844-6a46-4b57-a23d-91d9a5ff7382	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
e5902965-f65f-4a13-8fe5-fdb4f55df39c	f81b6756-e9c8-4a45-8704-bcc647f20d12	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	4d6b4184-d62e-427a-ba00-16ff3f4e4f10	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
ec619ebd-c8bb-46c8-9a6a-0a531cced32d	f81b6756-e9c8-4a45-8704-bcc647f20d12	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	06947927-aab0-4d24-b5fe-b42c0b83050c	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
9d0af700-ddcc-4f78-80c6-0cbbdfcecbf0	f81b6756-e9c8-4a45-8704-bcc647f20d12	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	7e8983cd-5a94-49cc-9b80-64358a9d48f9	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
1f76eaeb-a520-4f4c-a717-2c44adffe25a	f81b6756-e9c8-4a45-8704-bcc647f20d12	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	685d23ad-eadc-47ac-9f91-8f741ae4211f	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
57416907-1daf-4443-b73a-39a320d2e0b5	f81b6756-e9c8-4a45-8704-bcc647f20d12	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	2e599a1f-e34d-436c-98f9-01f019cb29bd	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
e5ad462a-7f46-4889-a7d6-309b95db34ef	f81b6756-e9c8-4a45-8704-bcc647f20d12	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	44a43cc4-8d2e-4ce5-b437-2b76a205ea84	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
c07d90f5-cb4c-4535-ade4-207dec7c5fad	f81b6756-e9c8-4a45-8704-bcc647f20d12	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	08314805-8508-4254-997b-a035415747d5	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
4865ac58-af71-4196-9c42-ba42e6633689	f81b6756-e9c8-4a45-8704-bcc647f20d12	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	88fad813-46ed-4601-a334-ae77df797be3	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
2f6f49f4-df1c-4101-a4c7-e746d882705e	f81b6756-e9c8-4a45-8704-bcc647f20d12	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	9358b2c4-aebc-480a-9eff-6873c156da12	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
2a62fbc6-682a-43a2-942c-c8ef16872128	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	88db9091-ce2d-4403-8435-836d38255f2c	4476c3a6-58da-4c43-9b8a-b1da70172072	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:24:39.060001	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
95a244d0-d37a-4263-ab7d-8cf73e3f6fe4	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	88db9091-ce2d-4403-8435-836d38255f2c	31a4c844-6a46-4b57-a23d-91d9a5ff7382	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:24:39.060001	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
613ae4d9-0837-460e-b15c-596c3664e182	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	88db9091-ce2d-4403-8435-836d38255f2c	4d6b4184-d62e-427a-ba00-16ff3f4e4f10	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:24:39.060001	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
36dde9e7-1ad9-4d5e-8e31-8f7af2819787	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	88db9091-ce2d-4403-8435-836d38255f2c	06947927-aab0-4d24-b5fe-b42c0b83050c	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:24:39.060001	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
16925d0d-1a60-4f35-bcad-3e2d701f4969	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	88db9091-ce2d-4403-8435-836d38255f2c	44a43cc4-8d2e-4ce5-b437-2b76a205ea84	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:24:39.060001	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
b16fa914-d2b3-4df9-a55f-01f15e917e4c	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	88db9091-ce2d-4403-8435-836d38255f2c	9358b2c4-aebc-480a-9eff-6873c156da12	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:24:39.060001	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
52f68f29-291e-4d19-9416-d769bd6ad14c	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	88db9091-ce2d-4403-8435-836d38255f2c	7022a346-204b-472a-b46b-b801f07e8853	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:24:39.060001	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
07e5948c-ecf4-4488-80e9-579bf682fcaf	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	88db9091-ce2d-4403-8435-836d38255f2c	06947927-aab0-4d24-b5fe-b42c0b83050c	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:24:58.006659	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
a03c4702-e87d-4f6c-bba7-be0e10a4b223	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	88db9091-ce2d-4403-8435-836d38255f2c	08314805-8508-4254-997b-a035415747d5	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:24:58.006659	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
7640efc3-c022-4005-8949-7ac956c3b68b	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	88db9091-ce2d-4403-8435-836d38255f2c	7022a346-204b-472a-b46b-b801f07e8853	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:24:58.006659	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
b0e2d65f-1642-4ae8-be2d-174542056939	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	88db9091-ce2d-4403-8435-836d38255f2c	6852ffde-5e9e-4faa-be78-93d194b1f8b7	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:24:58.006659	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
e5d1f35c-e8e1-41cd-b033-bc98cd5f6e52	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	88db9091-ce2d-4403-8435-836d38255f2c	ec97e568-30d6-4e8f-acb3-b74d1b4b5436	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:24:58.006659	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
847a6207-8ab7-41ad-a64d-869accd307f3	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	88db9091-ce2d-4403-8435-836d38255f2c	41ab0a41-f16e-4bd5-961e-5b070acd6410	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:24:58.006659	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
1004ba71-b945-4535-b557-e3649ce00f54	30da9b2e-814c-408d-823b-f2719459e315	88db9091-ce2d-4403-8435-836d38255f2c	44a43cc4-8d2e-4ce5-b437-2b76a205ea84	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
17939c97-d387-4072-9b56-0ade473c89b7	30da9b2e-814c-408d-823b-f2719459e315	88db9091-ce2d-4403-8435-836d38255f2c	4d6b4184-d62e-427a-ba00-16ff3f4e4f10	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
800c02b2-b17c-40fa-9cf1-3d97b71e523d	30da9b2e-814c-408d-823b-f2719459e315	88db9091-ce2d-4403-8435-836d38255f2c	685d23ad-eadc-47ac-9f91-8f741ae4211f	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
12230383-2cfe-4b94-90a6-92b54aaf59a7	30da9b2e-814c-408d-823b-f2719459e315	88db9091-ce2d-4403-8435-836d38255f2c	7022a346-204b-472a-b46b-b801f07e8853	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
71df562d-10ee-4118-9cf5-8dcd42114bcf	30da9b2e-814c-408d-823b-f2719459e315	88db9091-ce2d-4403-8435-836d38255f2c	7e8983cd-5a94-49cc-9b80-64358a9d48f9	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
ed2f55c9-5a95-48f5-86fd-4e40e0ff289f	30da9b2e-814c-408d-823b-f2719459e315	88db9091-ce2d-4403-8435-836d38255f2c	88fad813-46ed-4601-a334-ae77df797be3	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
8987739b-bc28-42f5-a66e-a8b50e9f3fef	30da9b2e-814c-408d-823b-f2719459e315	88db9091-ce2d-4403-8435-836d38255f2c	9358b2c4-aebc-480a-9eff-6873c156da12	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
8d81ec42-50aa-4f18-820f-5ad3b8b46d31	f81b6756-e9c8-4a45-8704-bcc647f20d12	88db9091-ce2d-4403-8435-836d38255f2c	ec97e568-30d6-4e8f-acb3-b74d1b4b5436	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
a509cc08-2ed5-4dc9-ad3d-eaa1fdce16ec	f81b6756-e9c8-4a45-8704-bcc647f20d12	88db9091-ce2d-4403-8435-836d38255f2c	41ab0a41-f16e-4bd5-961e-5b070acd6410	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
e8081920-57db-496c-ad26-2b6bd9124f0c	a677d812-3140-440f-9603-2cff99ca31d4	88db9091-ce2d-4403-8435-836d38255f2c	7e8983cd-5a94-49cc-9b80-64358a9d48f9	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
457b10ea-2b73-479e-86d0-c34e6a494914	a677d812-3140-440f-9603-2cff99ca31d4	88db9091-ce2d-4403-8435-836d38255f2c	7022a346-204b-472a-b46b-b801f07e8853	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
f55abcc6-ffac-488a-b915-4257a21ebf5c	a677d812-3140-440f-9603-2cff99ca31d4	88db9091-ce2d-4403-8435-836d38255f2c	88fad813-46ed-4601-a334-ae77df797be3	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
f566b793-9ac2-4e2d-81fb-a5812b57f3be	a677d812-3140-440f-9603-2cff99ca31d4	88db9091-ce2d-4403-8435-836d38255f2c	9358b2c4-aebc-480a-9eff-6873c156da12	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
bf436380-668f-4265-8e0f-ba446c42ab1d	a677d812-3140-440f-9603-2cff99ca31d4	88db9091-ce2d-4403-8435-836d38255f2c	ec97e568-30d6-4e8f-acb3-b74d1b4b5436	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:25:22.115888	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
c901ea52-3f2f-45fa-b20a-44e00593bf18	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	41ab0a41-f16e-4bd5-961e-5b070acd6410	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:39:09.213387	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
c6f7f388-f915-4521-94d8-aecc57f1412e	a677d812-3140-440f-9603-2cff99ca31d4	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	44a43cc4-8d2e-4ce5-b437-2b76a205ea84	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
5aaff784-2688-4a48-9b15-4b5a5b1bb2aa	a677d812-3140-440f-9603-2cff99ca31d4	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	08314805-8508-4254-997b-a035415747d5	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
83b7a52d-8f00-4ed7-b8ff-6b693d06a154	a677d812-3140-440f-9603-2cff99ca31d4	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	88fad813-46ed-4601-a334-ae77df797be3	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
fd9b0ca7-1959-45d6-b690-f13a4b455e7c	a677d812-3140-440f-9603-2cff99ca31d4	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	9358b2c4-aebc-480a-9eff-6873c156da12	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
c89b4edc-f9c6-40e1-81b7-22149d3fbc69	a677d812-3140-440f-9603-2cff99ca31d4	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	7022a346-204b-472a-b46b-b801f07e8853	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
2f923d22-4546-4f0f-938a-35a5932eb1f4	a677d812-3140-440f-9603-2cff99ca31d4	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	6852ffde-5e9e-4faa-be78-93d194b1f8b7	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
6e6e33b3-bdf3-4d7f-b94f-41be82a32c2e	a677d812-3140-440f-9603-2cff99ca31d4	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	ec97e568-30d6-4e8f-acb3-b74d1b4b5436	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
e656451c-4954-4044-9aab-a582b439de3b	a677d812-3140-440f-9603-2cff99ca31d4	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	41ab0a41-f16e-4bd5-961e-5b070acd6410	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-08 18:40:25.39319	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
9420ad63-01d9-48f6-a943-4bd389efdcda	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	708bb649-495c-45d0-a217-185f19446e75	adbc17f9-6f88-4144-afe1-e29f3a0bd21e	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:30:10.395636	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
73429bc4-3f9c-40a7-9e9c-89057e16d155	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	708bb649-495c-45d0-a217-185f19446e75	bcb48067-c6be-4c39-87bc-08618f18ef4e	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:30:10.395636	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
ce655fc9-d12f-4275-aa4d-8575a4d94318	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	708bb649-495c-45d0-a217-185f19446e75	955efb94-7eac-4392-969a-732f19143f89	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:30:10.395636	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
5fe05c2f-80b8-4c84-a4be-1eae43915d6c	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	708bb649-495c-45d0-a217-185f19446e75	ec97e568-30d6-4e8f-acb3-b74d1b4b5436	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:30:10.395636	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
6c8dd86e-a19d-435d-b3dd-8f5aabdf6c42	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	708bb649-495c-45d0-a217-185f19446e75	adbc17f9-6f88-4144-afe1-e29f3a0bd21e	5.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:30:20.029464	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
8120c84b-bcd6-453c-b1ac-a7b560d97408	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	708bb649-495c-45d0-a217-185f19446e75	bcb48067-c6be-4c39-87bc-08618f18ef4e	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:30:20.029464	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
ce76543d-7d82-4f3a-bd94-a0d274377c55	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	708bb649-495c-45d0-a217-185f19446e75	955efb94-7eac-4392-969a-732f19143f89	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:30:20.029464	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
c1ee5917-a79a-494f-b452-e0bce06dc4d9	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	708bb649-495c-45d0-a217-185f19446e75	ec97e568-30d6-4e8f-acb3-b74d1b4b5436	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:30:20.029464	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
e316896e-efc3-4efc-a717-2bcf62112cd1	30da9b2e-814c-408d-823b-f2719459e315	708bb649-495c-45d0-a217-185f19446e75	adbc17f9-6f88-4144-afe1-e29f3a0bd21e	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:30:29.350622	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
c74c060a-ca5f-433b-b4a4-a289e0ea8df3	30da9b2e-814c-408d-823b-f2719459e315	708bb649-495c-45d0-a217-185f19446e75	bcb48067-c6be-4c39-87bc-08618f18ef4e	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:30:29.350622	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
85a307de-b7e3-49e7-8782-cb088ff55c63	30da9b2e-814c-408d-823b-f2719459e315	708bb649-495c-45d0-a217-185f19446e75	955efb94-7eac-4392-969a-732f19143f89	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:30:29.350622	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
facc3e10-8a6f-435c-93e7-20c9521cdae1	30da9b2e-814c-408d-823b-f2719459e315	708bb649-495c-45d0-a217-185f19446e75	ec97e568-30d6-4e8f-acb3-b74d1b4b5436	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:30:29.350622	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
900d2d04-737e-4c9d-a21d-f826e4b96a3e	f81b6756-e9c8-4a45-8704-bcc647f20d12	708bb649-495c-45d0-a217-185f19446e75	adbc17f9-6f88-4144-afe1-e29f3a0bd21e	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:30:38.898918	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
e8d451a9-1d1e-4a98-a313-9d4ea113e757	f81b6756-e9c8-4a45-8704-bcc647f20d12	708bb649-495c-45d0-a217-185f19446e75	bcb48067-c6be-4c39-87bc-08618f18ef4e	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:30:38.898918	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
09f44bd7-9481-48cb-8419-2af08dc3be53	f81b6756-e9c8-4a45-8704-bcc647f20d12	708bb649-495c-45d0-a217-185f19446e75	955efb94-7eac-4392-969a-732f19143f89	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:30:38.898918	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
8b527159-b58a-4bc1-909a-59c6174ce7b8	f81b6756-e9c8-4a45-8704-bcc647f20d12	708bb649-495c-45d0-a217-185f19446e75	ec97e568-30d6-4e8f-acb3-b74d1b4b5436	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:30:38.898918	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
1e18c35a-556b-4e37-b366-6a459828ab39	a677d812-3140-440f-9603-2cff99ca31d4	708bb649-495c-45d0-a217-185f19446e75	adbc17f9-6f88-4144-afe1-e29f3a0bd21e	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:30:48.152959	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
a3166746-6ef9-4147-9315-f7ebc3654e24	a677d812-3140-440f-9603-2cff99ca31d4	708bb649-495c-45d0-a217-185f19446e75	bcb48067-c6be-4c39-87bc-08618f18ef4e	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:30:48.152959	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
1935ff4c-0406-40a0-a393-e5edd6b419d7	a677d812-3140-440f-9603-2cff99ca31d4	708bb649-495c-45d0-a217-185f19446e75	955efb94-7eac-4392-969a-732f19143f89	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:30:48.152959	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
7db1a135-b417-4282-ae27-94ac143180c6	a677d812-3140-440f-9603-2cff99ca31d4	708bb649-495c-45d0-a217-185f19446e75	ec97e568-30d6-4e8f-acb3-b74d1b4b5436	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:30:48.152959	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
a7dc73b5-59a1-4973-a27e-c747ae671077	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	4d2ce8fc-08e8-4865-a179-0d326f3151da	08314805-8508-4254-997b-a035415747d5	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:53:46.025434	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
b31a03fe-cc4d-476a-a1e8-d39eea289f5d	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	4d2ce8fc-08e8-4865-a179-0d326f3151da	88fad813-46ed-4601-a334-ae77df797be3	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:53:46.025434	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
8a4dbd43-c56f-4707-b2cf-2f4806425bde	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	4d2ce8fc-08e8-4865-a179-0d326f3151da	9358b2c4-aebc-480a-9eff-6873c156da12	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:53:46.025434	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
b9ae375a-989e-41b5-8601-b4d1893e2658	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	4d2ce8fc-08e8-4865-a179-0d326f3151da	d5760d32-ce61-48fd-988e-9bd16cc52ca1	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:53:46.025434	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
2cdf57b3-74b8-45ce-84d5-69ec93251ecb	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	4d2ce8fc-08e8-4865-a179-0d326f3151da	7022a346-204b-472a-b46b-b801f07e8853	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:53:46.025434	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
405afa75-32d1-4866-8e20-d454d0a7d004	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	4d2ce8fc-08e8-4865-a179-0d326f3151da	6852ffde-5e9e-4faa-be78-93d194b1f8b7	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:53:46.025434	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
94e13a4d-a9f6-4285-ae3a-d0410cbd9288	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	4d2ce8fc-08e8-4865-a179-0d326f3151da	ec97e568-30d6-4e8f-acb3-b74d1b4b5436	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:53:46.025434	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
478f813e-f1cb-4d7d-a023-f61d8de3f3fe	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	4d2ce8fc-08e8-4865-a179-0d326f3151da	0322c72d-2fbf-462d-9a59-76e1550b30d9	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:53:46.025434	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
95968cf1-4e08-4e72-af35-8b1636dadd6e	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	4d2ce8fc-08e8-4865-a179-0d326f3151da	08314805-8508-4254-997b-a035415747d5	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:54:06.077364	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
c50070f1-2584-411e-a3ab-671b4d9cc33d	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	4d2ce8fc-08e8-4865-a179-0d326f3151da	88fad813-46ed-4601-a334-ae77df797be3	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:54:06.077364	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
072f2e52-cc8c-4227-9da5-46c738871c92	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	4d2ce8fc-08e8-4865-a179-0d326f3151da	9358b2c4-aebc-480a-9eff-6873c156da12	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:54:06.077364	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
3e1b0c00-e195-4834-89c3-42be990898a1	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	4d2ce8fc-08e8-4865-a179-0d326f3151da	d5760d32-ce61-48fd-988e-9bd16cc52ca1	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:54:06.077364	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
75c2d216-13df-4706-b0f8-e89d324f4838	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	4d2ce8fc-08e8-4865-a179-0d326f3151da	7022a346-204b-472a-b46b-b801f07e8853	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:54:06.077364	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
86bdff7d-07cc-4f3b-bf4f-4045d76e2323	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	4d2ce8fc-08e8-4865-a179-0d326f3151da	6852ffde-5e9e-4faa-be78-93d194b1f8b7	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:54:06.077364	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
d82ddc57-db80-41ce-a4d3-9168238c3029	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	4d2ce8fc-08e8-4865-a179-0d326f3151da	ec97e568-30d6-4e8f-acb3-b74d1b4b5436	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:54:06.077364	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
2fe004df-cb80-4732-9831-13f94e325d47	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	4d2ce8fc-08e8-4865-a179-0d326f3151da	0322c72d-2fbf-462d-9a59-76e1550b30d9	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:54:06.077364	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
ead478c8-7d67-4e82-8c88-df17177d484a	30da9b2e-814c-408d-823b-f2719459e315	4d2ce8fc-08e8-4865-a179-0d326f3151da	08314805-8508-4254-997b-a035415747d5	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:54:25.947852	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
e51e1bed-578a-4087-82c6-6f8a3ada7b15	30da9b2e-814c-408d-823b-f2719459e315	4d2ce8fc-08e8-4865-a179-0d326f3151da	88fad813-46ed-4601-a334-ae77df797be3	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:54:25.947852	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
c1582b47-0abe-418d-b908-b94f2b8126d3	30da9b2e-814c-408d-823b-f2719459e315	4d2ce8fc-08e8-4865-a179-0d326f3151da	9358b2c4-aebc-480a-9eff-6873c156da12	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:54:25.947852	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
6fd32938-ec7a-4978-812d-35e6a8dfe869	30da9b2e-814c-408d-823b-f2719459e315	4d2ce8fc-08e8-4865-a179-0d326f3151da	d5760d32-ce61-48fd-988e-9bd16cc52ca1	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:54:25.947852	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
f337ecbf-7817-4194-9c6b-df44697d427c	30da9b2e-814c-408d-823b-f2719459e315	4d2ce8fc-08e8-4865-a179-0d326f3151da	7022a346-204b-472a-b46b-b801f07e8853	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:54:25.947852	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
9a11885a-429e-49f1-a2a2-be47e3c23692	30da9b2e-814c-408d-823b-f2719459e315	4d2ce8fc-08e8-4865-a179-0d326f3151da	6852ffde-5e9e-4faa-be78-93d194b1f8b7	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:54:25.947852	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
786d57a0-4fdd-4695-8e06-2f9e1e3e81a8	30da9b2e-814c-408d-823b-f2719459e315	4d2ce8fc-08e8-4865-a179-0d326f3151da	ec97e568-30d6-4e8f-acb3-b74d1b4b5436	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:54:25.947852	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
049ad515-37d7-4f16-9551-ffeda4d2b9c2	30da9b2e-814c-408d-823b-f2719459e315	4d2ce8fc-08e8-4865-a179-0d326f3151da	0322c72d-2fbf-462d-9a59-76e1550b30d9	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:54:25.947852	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
efae8a3a-fd25-4489-b169-a4526d0ed4e2	f81b6756-e9c8-4a45-8704-bcc647f20d12	4d2ce8fc-08e8-4865-a179-0d326f3151da	08314805-8508-4254-997b-a035415747d5	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:54:46.049307	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
42273da8-bea0-40c4-b764-f5106ddf1f6d	f81b6756-e9c8-4a45-8704-bcc647f20d12	4d2ce8fc-08e8-4865-a179-0d326f3151da	88fad813-46ed-4601-a334-ae77df797be3	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:54:46.049307	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
157f980c-f02b-4fcf-a21d-e2a89463156a	f81b6756-e9c8-4a45-8704-bcc647f20d12	4d2ce8fc-08e8-4865-a179-0d326f3151da	9358b2c4-aebc-480a-9eff-6873c156da12	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:54:46.049307	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
467e84f2-e86d-4dfa-9e5e-865341852119	f81b6756-e9c8-4a45-8704-bcc647f20d12	4d2ce8fc-08e8-4865-a179-0d326f3151da	d5760d32-ce61-48fd-988e-9bd16cc52ca1	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:54:46.049307	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
8acb58a0-4ef6-4660-84dd-6c0414fbf5ee	f81b6756-e9c8-4a45-8704-bcc647f20d12	4d2ce8fc-08e8-4865-a179-0d326f3151da	7022a346-204b-472a-b46b-b801f07e8853	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:54:46.049307	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
af2aa414-6cb8-4be6-9560-ff9db2e0e689	f81b6756-e9c8-4a45-8704-bcc647f20d12	4d2ce8fc-08e8-4865-a179-0d326f3151da	6852ffde-5e9e-4faa-be78-93d194b1f8b7	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:54:46.049307	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
895b3393-bb7d-4a1e-ae62-2d2303c60a27	f81b6756-e9c8-4a45-8704-bcc647f20d12	4d2ce8fc-08e8-4865-a179-0d326f3151da	ec97e568-30d6-4e8f-acb3-b74d1b4b5436	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:54:46.049307	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
fa8d9551-62e5-4836-b1d6-aaaa50228ba7	f81b6756-e9c8-4a45-8704-bcc647f20d12	4d2ce8fc-08e8-4865-a179-0d326f3151da	0322c72d-2fbf-462d-9a59-76e1550b30d9	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:54:46.049307	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
5acc75ea-592e-4dc9-a330-dabeaa657692	a677d812-3140-440f-9603-2cff99ca31d4	4d2ce8fc-08e8-4865-a179-0d326f3151da	08314805-8508-4254-997b-a035415747d5	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:55:05.442169	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
a9f04f4e-6b34-4d68-9dd0-757ad60ca7e2	a677d812-3140-440f-9603-2cff99ca31d4	4d2ce8fc-08e8-4865-a179-0d326f3151da	88fad813-46ed-4601-a334-ae77df797be3	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:55:05.442169	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
4b742764-834d-41d7-9f0b-4f2514555f22	a677d812-3140-440f-9603-2cff99ca31d4	4d2ce8fc-08e8-4865-a179-0d326f3151da	9358b2c4-aebc-480a-9eff-6873c156da12	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:55:05.442169	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
98e26369-2bee-45d1-aca2-496b804f1a6d	a677d812-3140-440f-9603-2cff99ca31d4	4d2ce8fc-08e8-4865-a179-0d326f3151da	d5760d32-ce61-48fd-988e-9bd16cc52ca1	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:55:05.442169	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
392cec8d-9c00-4da0-823e-693ad241eb4b	a677d812-3140-440f-9603-2cff99ca31d4	4d2ce8fc-08e8-4865-a179-0d326f3151da	7022a346-204b-472a-b46b-b801f07e8853	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:55:05.442169	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
9430e8da-4713-40d2-96b4-b92fc6589cf5	a677d812-3140-440f-9603-2cff99ca31d4	4d2ce8fc-08e8-4865-a179-0d326f3151da	6852ffde-5e9e-4faa-be78-93d194b1f8b7	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:55:05.442169	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
c9a99de2-88e5-4309-b3f2-3c0e0f6a1eaa	a677d812-3140-440f-9603-2cff99ca31d4	4d2ce8fc-08e8-4865-a179-0d326f3151da	ec97e568-30d6-4e8f-acb3-b74d1b4b5436	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:55:05.442169	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
889074f3-46f7-46a8-8131-1e57124bf536	a677d812-3140-440f-9603-2cff99ca31d4	4d2ce8fc-08e8-4865-a179-0d326f3151da	0322c72d-2fbf-462d-9a59-76e1550b30d9	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 04:55:05.442169	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
b4a9f9d0-d7ab-47d0-9568-22191c05666d	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	79336918-2f2b-450a-b09b-70a320973d6c	1b63c6c1-36b6-49b5-a61f-1c3f2b85bdb1	3.75	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:05:12.868526	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
3fc14795-3cea-45c4-be20-8f333dda0471	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	79336918-2f2b-450a-b09b-70a320973d6c	1b63c6c1-36b6-49b5-a61f-1c3f2b85bdb1	2.50	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:05:18.860938	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
c099e93f-fa4d-46c7-bc08-9046ef1cf39a	30da9b2e-814c-408d-823b-f2719459e315	79336918-2f2b-450a-b09b-70a320973d6c	1b63c6c1-36b6-49b5-a61f-1c3f2b85bdb1	2.75	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:05:24.760739	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
dabf603f-3d09-41ad-8bb2-077b28487339	f81b6756-e9c8-4a45-8704-bcc647f20d12	79336918-2f2b-450a-b09b-70a320973d6c	1b63c6c1-36b6-49b5-a61f-1c3f2b85bdb1	4.38	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:05:30.686427	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
9fb6bf03-5f35-4f85-a7a4-b744afaacc03	a677d812-3140-440f-9603-2cff99ca31d4	79336918-2f2b-450a-b09b-70a320973d6c	1b63c6c1-36b6-49b5-a61f-1c3f2b85bdb1	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:05:36.21794	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
3e90faf1-3cc7-4333-aaf8-29671f661b29	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	906b8089-4326-4a47-b82b-756db4f8916d	88fad813-46ed-4601-a334-ae77df797be3	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:11:53.056107	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
4a213c0e-1081-45c9-a660-b5161ef8604e	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	906b8089-4326-4a47-b82b-756db4f8916d	9358b2c4-aebc-480a-9eff-6873c156da12	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:11:53.056107	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
800ec3a0-66b4-48bc-a3cb-fa492aa76946	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	906b8089-4326-4a47-b82b-756db4f8916d	d5760d32-ce61-48fd-988e-9bd16cc52ca1	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:11:53.056107	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
459180e8-0fef-4896-8f29-475f6f701c85	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	906b8089-4326-4a47-b82b-756db4f8916d	7022a346-204b-472a-b46b-b801f07e8853	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:11:53.056107	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
ebcfc0f5-dc1e-4f3f-a6f4-a37e3ba1e1e0	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	906b8089-4326-4a47-b82b-756db4f8916d	ec97e568-30d6-4e8f-acb3-b74d1b4b5436	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:11:53.056107	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
ddcca0ee-1022-45ef-8d78-6d9526ebce7a	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	906b8089-4326-4a47-b82b-756db4f8916d	41ab0a41-f16e-4bd5-961e-5b070acd6410	5.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:11:53.056107	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
06627904-8552-4549-854f-f190657015e6	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	906b8089-4326-4a47-b82b-756db4f8916d	88fad813-46ed-4601-a334-ae77df797be3	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:12:06.354559	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
f1a56243-b724-4165-bd8d-d22c20c1d936	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	906b8089-4326-4a47-b82b-756db4f8916d	9358b2c4-aebc-480a-9eff-6873c156da12	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:12:06.354559	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
213f6bb2-5d11-4fe8-b0b4-404bcb391977	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	906b8089-4326-4a47-b82b-756db4f8916d	d5760d32-ce61-48fd-988e-9bd16cc52ca1	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:12:06.354559	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
d840c555-69b2-4881-b4bf-f3a5b0b6489a	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	906b8089-4326-4a47-b82b-756db4f8916d	7022a346-204b-472a-b46b-b801f07e8853	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:12:06.354559	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
d4e1ceb7-d3c7-4b5a-a943-88747239a373	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	906b8089-4326-4a47-b82b-756db4f8916d	ec97e568-30d6-4e8f-acb3-b74d1b4b5436	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:12:06.354559	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
328d6429-9cc2-4474-a1bc-1cc46b55e74c	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	906b8089-4326-4a47-b82b-756db4f8916d	41ab0a41-f16e-4bd5-961e-5b070acd6410	5.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:12:06.354559	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
5ba33138-97b4-4021-8790-9302720ae5b6	30da9b2e-814c-408d-823b-f2719459e315	906b8089-4326-4a47-b82b-756db4f8916d	88fad813-46ed-4601-a334-ae77df797be3	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:12:19.030594	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
a9f77786-34f3-4bb0-add0-297886c9e484	30da9b2e-814c-408d-823b-f2719459e315	906b8089-4326-4a47-b82b-756db4f8916d	9358b2c4-aebc-480a-9eff-6873c156da12	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:12:19.030594	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
59c71e09-fbab-4c6c-b8e2-ad9e50748f1b	30da9b2e-814c-408d-823b-f2719459e315	906b8089-4326-4a47-b82b-756db4f8916d	d5760d32-ce61-48fd-988e-9bd16cc52ca1	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:12:19.030594	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
984f9319-aa50-484e-9d1b-206b438dfb06	30da9b2e-814c-408d-823b-f2719459e315	906b8089-4326-4a47-b82b-756db4f8916d	7022a346-204b-472a-b46b-b801f07e8853	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:12:19.030594	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
ec8cfa8e-1da4-4129-80d6-8f581b767930	30da9b2e-814c-408d-823b-f2719459e315	906b8089-4326-4a47-b82b-756db4f8916d	ec97e568-30d6-4e8f-acb3-b74d1b4b5436	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:12:19.030594	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
31468404-7bfa-46f2-9ec3-0b661a99e7fc	30da9b2e-814c-408d-823b-f2719459e315	906b8089-4326-4a47-b82b-756db4f8916d	41ab0a41-f16e-4bd5-961e-5b070acd6410	5.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:12:19.030594	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
461f8849-b4c2-450e-8956-aec45b18bb19	f81b6756-e9c8-4a45-8704-bcc647f20d12	906b8089-4326-4a47-b82b-756db4f8916d	88fad813-46ed-4601-a334-ae77df797be3	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:12:33.884436	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
71031c02-24a9-494d-a91b-7b615a30f159	f81b6756-e9c8-4a45-8704-bcc647f20d12	906b8089-4326-4a47-b82b-756db4f8916d	9358b2c4-aebc-480a-9eff-6873c156da12	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:12:33.884436	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
bacf5866-e3a6-40be-872d-15c93fbf54ab	f81b6756-e9c8-4a45-8704-bcc647f20d12	906b8089-4326-4a47-b82b-756db4f8916d	d5760d32-ce61-48fd-988e-9bd16cc52ca1	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:12:33.884436	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
e0c38699-9799-466b-af3e-798c43216267	f81b6756-e9c8-4a45-8704-bcc647f20d12	906b8089-4326-4a47-b82b-756db4f8916d	7022a346-204b-472a-b46b-b801f07e8853	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:12:33.884436	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
033a32db-4c6e-4686-9c51-d7ce83a99284	f81b6756-e9c8-4a45-8704-bcc647f20d12	906b8089-4326-4a47-b82b-756db4f8916d	ec97e568-30d6-4e8f-acb3-b74d1b4b5436	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:12:33.884436	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
51242f6b-d510-49d2-a98b-18e4d1690e7c	f81b6756-e9c8-4a45-8704-bcc647f20d12	906b8089-4326-4a47-b82b-756db4f8916d	41ab0a41-f16e-4bd5-961e-5b070acd6410	5.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:12:33.884436	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
7fcf85b7-dba8-4349-8764-2e9222d4e3f3	a677d812-3140-440f-9603-2cff99ca31d4	906b8089-4326-4a47-b82b-756db4f8916d	88fad813-46ed-4601-a334-ae77df797be3	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:13:41.784073	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
3976f6aa-29be-48e6-a8c7-a9b091314c4d	a677d812-3140-440f-9603-2cff99ca31d4	906b8089-4326-4a47-b82b-756db4f8916d	9358b2c4-aebc-480a-9eff-6873c156da12	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:13:41.784073	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
bc6b45e3-c158-4751-86d2-352a0ed00e3d	a677d812-3140-440f-9603-2cff99ca31d4	906b8089-4326-4a47-b82b-756db4f8916d	d5760d32-ce61-48fd-988e-9bd16cc52ca1	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:13:41.784073	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
7f3e9540-905b-4adc-b081-0c207d347410	a677d812-3140-440f-9603-2cff99ca31d4	906b8089-4326-4a47-b82b-756db4f8916d	7022a346-204b-472a-b46b-b801f07e8853	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:13:41.784073	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
4aae6e6c-0f72-425d-8d40-e1eab5e0f2e7	a677d812-3140-440f-9603-2cff99ca31d4	906b8089-4326-4a47-b82b-756db4f8916d	ec97e568-30d6-4e8f-acb3-b74d1b4b5436	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:13:41.784073	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
baef9760-4ee6-43bc-9380-6a869dfc7651	a677d812-3140-440f-9603-2cff99ca31d4	906b8089-4326-4a47-b82b-756db4f8916d	41ab0a41-f16e-4bd5-961e-5b070acd6410	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:13:41.784073	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
12dd4f0f-0a9a-4b62-aef4-513b5e4f021a	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	a3642afb-c1e0-48b5-a089-cc429f99a93e	4d6b4184-d62e-427a-ba00-16ff3f4e4f10	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:17:16.358945	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
8bae52ad-8622-46a1-b3dd-e383da5a9b5f	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	a3642afb-c1e0-48b5-a089-cc429f99a93e	685d23ad-eadc-47ac-9f91-8f741ae4211f	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:17:16.358945	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
4273a721-83d1-4a3f-867a-8bf4a3db518d	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	a3642afb-c1e0-48b5-a089-cc429f99a93e	2e599a1f-e34d-436c-98f9-01f019cb29bd	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:17:16.358945	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
6c1ce14e-ed06-4182-aacf-f91889b236b7	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	a3642afb-c1e0-48b5-a089-cc429f99a93e	44a43cc4-8d2e-4ce5-b437-2b76a205ea84	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:17:16.358945	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
f5030fad-0109-4a57-8a4f-b2f33a7f0c75	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	a3642afb-c1e0-48b5-a089-cc429f99a93e	2d2976b5-f9bb-42e8-aca0-d6e6b6e6de77	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:17:16.358945	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
dea1d4cf-c60a-43ff-8a97-2562b79173cd	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	a3642afb-c1e0-48b5-a089-cc429f99a93e	88fad813-46ed-4601-a334-ae77df797be3	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:17:16.358945	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
d1f725ed-c179-41a8-9730-91a598d09415	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	a3642afb-c1e0-48b5-a089-cc429f99a93e	9358b2c4-aebc-480a-9eff-6873c156da12	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:17:16.358945	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
01eca71f-946f-498f-b8b3-5137f1c49745	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	a3642afb-c1e0-48b5-a089-cc429f99a93e	7022a346-204b-472a-b46b-b801f07e8853	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:17:16.358945	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
caf24fe3-8442-434b-b7d5-796b9ad7afc3	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	a3642afb-c1e0-48b5-a089-cc429f99a93e	6852ffde-5e9e-4faa-be78-93d194b1f8b7	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:17:16.358945	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
7f8796b6-9826-4dde-9971-6f572301b1ad	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	a3642afb-c1e0-48b5-a089-cc429f99a93e	ec97e568-30d6-4e8f-acb3-b74d1b4b5436	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:17:16.358945	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
a78ef573-b1bd-44f1-9af7-9c5eaac3f39a	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	a3642afb-c1e0-48b5-a089-cc429f99a93e	41ab0a41-f16e-4bd5-961e-5b070acd6410	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:17:16.358945	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
13672bdd-46dc-4f03-9041-bea90e568c28	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	a3642afb-c1e0-48b5-a089-cc429f99a93e	4d6b4184-d62e-427a-ba00-16ff3f4e4f10	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:17:32.698965	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
da4ec3c8-889b-45e2-9fbd-00221bea1b85	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	a3642afb-c1e0-48b5-a089-cc429f99a93e	685d23ad-eadc-47ac-9f91-8f741ae4211f	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:17:32.698965	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
325acb4b-e786-404a-ad3c-7cb584983857	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	a3642afb-c1e0-48b5-a089-cc429f99a93e	2e599a1f-e34d-436c-98f9-01f019cb29bd	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:17:32.698965	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
f007e68b-fdd1-4763-89cc-4d9dddd5705c	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	a3642afb-c1e0-48b5-a089-cc429f99a93e	44a43cc4-8d2e-4ce5-b437-2b76a205ea84	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:17:32.698965	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
95d0c673-6963-4486-a45b-c1e92c72d920	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	a3642afb-c1e0-48b5-a089-cc429f99a93e	2d2976b5-f9bb-42e8-aca0-d6e6b6e6de77	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:17:32.698965	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
93c22fec-9399-4ff8-aa67-207a041b2788	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	a3642afb-c1e0-48b5-a089-cc429f99a93e	88fad813-46ed-4601-a334-ae77df797be3	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:17:32.698965	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
65fd6ffb-f3aa-407b-a071-94b6937e803a	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	a3642afb-c1e0-48b5-a089-cc429f99a93e	9358b2c4-aebc-480a-9eff-6873c156da12	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:17:32.698965	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
8c93b56a-a687-463d-97ef-332677dee4c9	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	a3642afb-c1e0-48b5-a089-cc429f99a93e	7022a346-204b-472a-b46b-b801f07e8853	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:17:32.698965	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
210cd9e5-d0c3-49aa-b215-2af0c2d43f78	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	a3642afb-c1e0-48b5-a089-cc429f99a93e	6852ffde-5e9e-4faa-be78-93d194b1f8b7	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:17:32.698965	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
e114bc89-8ddd-49e0-8a19-7028a99c2eaa	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	a3642afb-c1e0-48b5-a089-cc429f99a93e	ec97e568-30d6-4e8f-acb3-b74d1b4b5436	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:17:32.698965	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
7aabaacb-cb32-4e15-9108-e8a61a118bf7	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	a3642afb-c1e0-48b5-a089-cc429f99a93e	41ab0a41-f16e-4bd5-961e-5b070acd6410	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:17:32.698965	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
e480a3d5-cce3-43f7-b8df-c84ce7a2ef45	30da9b2e-814c-408d-823b-f2719459e315	a3642afb-c1e0-48b5-a089-cc429f99a93e	4d6b4184-d62e-427a-ba00-16ff3f4e4f10	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:17:49.088275	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
6e34fd9f-a3e5-4e7a-8656-413a4a3e2633	30da9b2e-814c-408d-823b-f2719459e315	a3642afb-c1e0-48b5-a089-cc429f99a93e	685d23ad-eadc-47ac-9f91-8f741ae4211f	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:17:49.088275	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
d1ae3120-4b94-4e39-ba54-7e97a23dd030	30da9b2e-814c-408d-823b-f2719459e315	a3642afb-c1e0-48b5-a089-cc429f99a93e	2e599a1f-e34d-436c-98f9-01f019cb29bd	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:17:49.088275	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
9f6c3938-344c-494c-b233-96afb2883b3d	30da9b2e-814c-408d-823b-f2719459e315	a3642afb-c1e0-48b5-a089-cc429f99a93e	44a43cc4-8d2e-4ce5-b437-2b76a205ea84	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:17:49.088275	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
215a0282-c3c6-4780-9ed8-7427da1b4e93	30da9b2e-814c-408d-823b-f2719459e315	a3642afb-c1e0-48b5-a089-cc429f99a93e	2d2976b5-f9bb-42e8-aca0-d6e6b6e6de77	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:17:49.088275	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
c96e9efa-8eea-45e3-94e9-93a9bc745967	30da9b2e-814c-408d-823b-f2719459e315	a3642afb-c1e0-48b5-a089-cc429f99a93e	88fad813-46ed-4601-a334-ae77df797be3	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:17:49.088275	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
4bcfeeb4-cd60-43f3-a892-0317e18565e1	30da9b2e-814c-408d-823b-f2719459e315	a3642afb-c1e0-48b5-a089-cc429f99a93e	9358b2c4-aebc-480a-9eff-6873c156da12	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:17:49.088275	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
15a8b264-fa8c-4963-8b6b-53c3d3bd3e92	30da9b2e-814c-408d-823b-f2719459e315	a3642afb-c1e0-48b5-a089-cc429f99a93e	7022a346-204b-472a-b46b-b801f07e8853	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:17:49.088275	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
e37be8b3-fcd0-4eea-b9ec-8cba63370022	30da9b2e-814c-408d-823b-f2719459e315	a3642afb-c1e0-48b5-a089-cc429f99a93e	6852ffde-5e9e-4faa-be78-93d194b1f8b7	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:17:49.088275	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
ffa4b7c9-ebcd-4c19-8ca8-9e7712d69eb8	30da9b2e-814c-408d-823b-f2719459e315	a3642afb-c1e0-48b5-a089-cc429f99a93e	ec97e568-30d6-4e8f-acb3-b74d1b4b5436	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:17:49.088275	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
3326ec31-734f-4159-8967-80c5a6e586de	30da9b2e-814c-408d-823b-f2719459e315	a3642afb-c1e0-48b5-a089-cc429f99a93e	41ab0a41-f16e-4bd5-961e-5b070acd6410	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:17:49.088275	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
866d1779-74c4-49e3-9249-ff1ddb73e36b	f81b6756-e9c8-4a45-8704-bcc647f20d12	a3642afb-c1e0-48b5-a089-cc429f99a93e	4d6b4184-d62e-427a-ba00-16ff3f4e4f10	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:18:05.693521	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
fb7cc2ae-394a-4076-b585-fc697e6ec2cf	f81b6756-e9c8-4a45-8704-bcc647f20d12	a3642afb-c1e0-48b5-a089-cc429f99a93e	685d23ad-eadc-47ac-9f91-8f741ae4211f	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:18:05.693521	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
3bcbc9f0-37e3-42c6-9e0c-e246655f0d28	f81b6756-e9c8-4a45-8704-bcc647f20d12	a3642afb-c1e0-48b5-a089-cc429f99a93e	2e599a1f-e34d-436c-98f9-01f019cb29bd	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:18:05.693521	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
80229d0a-6ffb-4de5-94ce-dbd8a10590f3	f81b6756-e9c8-4a45-8704-bcc647f20d12	a3642afb-c1e0-48b5-a089-cc429f99a93e	44a43cc4-8d2e-4ce5-b437-2b76a205ea84	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:18:05.693521	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
3eb7703c-c6c3-46f8-b3ae-b36dbfd5490b	f81b6756-e9c8-4a45-8704-bcc647f20d12	a3642afb-c1e0-48b5-a089-cc429f99a93e	2d2976b5-f9bb-42e8-aca0-d6e6b6e6de77	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:18:05.693521	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
53585345-96c0-41f5-9a11-2c2f2d9c485a	f81b6756-e9c8-4a45-8704-bcc647f20d12	a3642afb-c1e0-48b5-a089-cc429f99a93e	88fad813-46ed-4601-a334-ae77df797be3	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:18:05.693521	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
73e59d76-380f-4cbc-8bb1-a0922aaadc64	f81b6756-e9c8-4a45-8704-bcc647f20d12	a3642afb-c1e0-48b5-a089-cc429f99a93e	9358b2c4-aebc-480a-9eff-6873c156da12	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:18:05.693521	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
71498ed1-9d9f-44e5-9dd3-af4e3066738b	f81b6756-e9c8-4a45-8704-bcc647f20d12	a3642afb-c1e0-48b5-a089-cc429f99a93e	7022a346-204b-472a-b46b-b801f07e8853	2.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:18:05.693521	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
86f49850-1eb0-4927-852d-5bb09dba6b9d	f81b6756-e9c8-4a45-8704-bcc647f20d12	a3642afb-c1e0-48b5-a089-cc429f99a93e	6852ffde-5e9e-4faa-be78-93d194b1f8b7	1.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:18:05.693521	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
e0072ad8-382a-4220-ac52-eeee0df66aac	f81b6756-e9c8-4a45-8704-bcc647f20d12	a3642afb-c1e0-48b5-a089-cc429f99a93e	ec97e568-30d6-4e8f-acb3-b74d1b4b5436	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:18:05.693521	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
07a93a13-649e-4e64-a308-73820e5a3516	f81b6756-e9c8-4a45-8704-bcc647f20d12	a3642afb-c1e0-48b5-a089-cc429f99a93e	41ab0a41-f16e-4bd5-961e-5b070acd6410	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:18:05.693521	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
0fa5c92f-11f3-4ca1-9dce-0478321536d5	a677d812-3140-440f-9603-2cff99ca31d4	a3642afb-c1e0-48b5-a089-cc429f99a93e	4d6b4184-d62e-427a-ba00-16ff3f4e4f10	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:18:24.175541	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
d48932ac-bcd0-4e43-9668-abdb2cdb7fec	a677d812-3140-440f-9603-2cff99ca31d4	a3642afb-c1e0-48b5-a089-cc429f99a93e	685d23ad-eadc-47ac-9f91-8f741ae4211f	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:18:24.175541	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
a0182790-005b-4317-b353-ba53f6396086	a677d812-3140-440f-9603-2cff99ca31d4	a3642afb-c1e0-48b5-a089-cc429f99a93e	2e599a1f-e34d-436c-98f9-01f019cb29bd	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:18:24.175541	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
fe4cb914-ead4-4a74-88eb-f64539fc0aa5	a677d812-3140-440f-9603-2cff99ca31d4	a3642afb-c1e0-48b5-a089-cc429f99a93e	44a43cc4-8d2e-4ce5-b437-2b76a205ea84	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:18:24.175541	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
66bdd622-0506-4387-97f6-77b24a5b1793	a677d812-3140-440f-9603-2cff99ca31d4	a3642afb-c1e0-48b5-a089-cc429f99a93e	2d2976b5-f9bb-42e8-aca0-d6e6b6e6de77	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:18:24.175541	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
ebf4eb8a-7fc9-4b13-a8cb-e928ca582a7f	a677d812-3140-440f-9603-2cff99ca31d4	a3642afb-c1e0-48b5-a089-cc429f99a93e	88fad813-46ed-4601-a334-ae77df797be3	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:18:24.175541	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
f3a05275-1cad-47d7-9d50-5e0dcc80f42c	a677d812-3140-440f-9603-2cff99ca31d4	a3642afb-c1e0-48b5-a089-cc429f99a93e	9358b2c4-aebc-480a-9eff-6873c156da12	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:18:24.175541	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
d951168d-b252-46ab-a684-098b0296c55b	a677d812-3140-440f-9603-2cff99ca31d4	a3642afb-c1e0-48b5-a089-cc429f99a93e	7022a346-204b-472a-b46b-b801f07e8853	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:18:24.175541	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
d759dc89-2476-4882-8d0f-060014e4843c	a677d812-3140-440f-9603-2cff99ca31d4	a3642afb-c1e0-48b5-a089-cc429f99a93e	6852ffde-5e9e-4faa-be78-93d194b1f8b7	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:18:24.175541	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
c3361beb-9091-4425-a915-ceed1c36ffad	a677d812-3140-440f-9603-2cff99ca31d4	a3642afb-c1e0-48b5-a089-cc429f99a93e	ec97e568-30d6-4e8f-acb3-b74d1b4b5436	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:18:24.175541	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
86cd4215-7281-4209-8645-7c42615f3fe5	a677d812-3140-440f-9603-2cff99ca31d4	a3642afb-c1e0-48b5-a089-cc429f99a93e	41ab0a41-f16e-4bd5-961e-5b070acd6410	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:18:24.175541	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
d492b4c9-2dfe-4a2d-94f8-285b97b0620a	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	448cb56a-e4d6-44c4-a49b-8a6119f36843	5.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:32:14.64929	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
6dd55009-b1e7-498c-b8af-6dcee0573804	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	3554e4f4-8d4c-4b4a-9fe6-88eb1f5ef489	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:32:14.64929	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
327fe369-0e56-470f-bfd2-77808339675c	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	f7be1839-a795-438b-b9da-54fed97ca1d7	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:32:14.64929	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
a2bebb3b-30c6-46c0-a514-e12f2e4984e0	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	c42f0ccc-e7e4-447b-b392-ecd3eca5d764	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:32:14.64929	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
931e12d2-2b01-4f20-b2cc-e60929989b3c	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	9ceb0bdb-9f21-40da-b938-c7729ff2daa3	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:32:14.64929	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
ffc15fa5-f4ff-49cf-8a36-c20d93784272	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	6f903e44-300e-470c-aa64-125da9772880	5.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:32:14.64929	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
b29a6af0-bee7-4836-b255-e6201b87c04d	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	24c6259e-6fbf-4a75-a66e-bd8a2894b261	5.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:32:14.64929	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
a38138c6-2392-44c1-99a2-869861f2c381	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	77c73ecd-3988-4efa-af44-efe3725e9f14	5.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:32:14.64929	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
b54cdc9d-911e-4fef-9b88-fafb09987479	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	698deda3-2aa9-4d4f-8a14-2fb80faac986	5.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:32:14.64929	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
27585490-5991-484e-8762-954d1c5cccfb	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	f2cb1b7e-41df-411f-abaa-2ac7cbf58674	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:32:14.64929	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
1f65dfbf-e3e4-47a1-8f24-d4aa35a3f854	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	6f74812e-ca45-4234-9a10-9bfe8f46467c	5.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:32:14.64929	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
329e7b79-6f43-4905-a7f1-22555aeb7226	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	448cb56a-e4d6-44c4-a49b-8a6119f36843	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:32:34.070732	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
a22bec03-37ba-4116-93cd-a200bfff00ac	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	3554e4f4-8d4c-4b4a-9fe6-88eb1f5ef489	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:32:34.070732	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
c7321a3c-0e96-441b-be7e-cc4ddb271b21	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	f7be1839-a795-438b-b9da-54fed97ca1d7	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:32:34.070732	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
cee84195-847c-4288-a5cc-928c1b0bd0db	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	c42f0ccc-e7e4-447b-b392-ecd3eca5d764	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:32:34.070732	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
b640640b-de7d-42ae-9da5-705b29d59a2a	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	9ceb0bdb-9f21-40da-b938-c7729ff2daa3	5.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:32:34.070732	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
c8ea9239-91e1-4c4b-ad6f-f0af3951a375	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	6f903e44-300e-470c-aa64-125da9772880	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:32:34.070732	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
9d4bed73-05a0-47eb-bd13-491896e67e85	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	24c6259e-6fbf-4a75-a66e-bd8a2894b261	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:32:34.070732	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
b26b5fe3-7eeb-4c96-8b9d-4c3d75d992ba	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	77c73ecd-3988-4efa-af44-efe3725e9f14	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:32:34.070732	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
c7a25379-d646-4f9f-8db5-d834d88ffc5e	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	698deda3-2aa9-4d4f-8a14-2fb80faac986	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:32:34.070732	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
70e84730-14dd-4916-bcce-482143dd1ee6	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	f2cb1b7e-41df-411f-abaa-2ac7cbf58674	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:32:34.070732	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
7d4ae733-8b34-4b61-895d-93e0c2ef0332	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	6f74812e-ca45-4234-9a10-9bfe8f46467c	5.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:32:34.070732	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
66c91e04-3688-4d6e-a906-83196a61c5d8	30da9b2e-814c-408d-823b-f2719459e315	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	448cb56a-e4d6-44c4-a49b-8a6119f36843	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:32:56.285781	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
f342c120-6da1-4471-995f-5f853469356a	30da9b2e-814c-408d-823b-f2719459e315	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	3554e4f4-8d4c-4b4a-9fe6-88eb1f5ef489	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:32:56.285781	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
1f3f15ad-267f-4e0e-99da-a76641380282	30da9b2e-814c-408d-823b-f2719459e315	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	f7be1839-a795-438b-b9da-54fed97ca1d7	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:32:56.285781	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
1ba602ec-d459-4606-8b82-b433a51f6f6e	30da9b2e-814c-408d-823b-f2719459e315	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	c42f0ccc-e7e4-447b-b392-ecd3eca5d764	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:32:56.285781	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
a7f9a90f-9687-4432-ab7d-614b38cd3127	30da9b2e-814c-408d-823b-f2719459e315	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	9ceb0bdb-9f21-40da-b938-c7729ff2daa3	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:32:56.285781	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
a1de2653-f3f9-499b-ab1b-9233042112af	30da9b2e-814c-408d-823b-f2719459e315	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	6f903e44-300e-470c-aa64-125da9772880	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:32:56.285781	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
31c847e1-8954-4a5c-a362-91810d8fb789	30da9b2e-814c-408d-823b-f2719459e315	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	24c6259e-6fbf-4a75-a66e-bd8a2894b261	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:32:56.285781	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
f371a438-287d-464c-b7a4-c4075eac4a7c	30da9b2e-814c-408d-823b-f2719459e315	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	77c73ecd-3988-4efa-af44-efe3725e9f14	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:32:56.285781	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
4e18dc6f-70f1-4fe2-a3e6-fb59927d94b7	30da9b2e-814c-408d-823b-f2719459e315	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	698deda3-2aa9-4d4f-8a14-2fb80faac986	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:32:56.285781	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
caf0b69e-4b68-42bc-abb0-b54845793d98	30da9b2e-814c-408d-823b-f2719459e315	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	f2cb1b7e-41df-411f-abaa-2ac7cbf58674	3.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:32:56.285781	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
ae0cce35-70f0-4531-a8a6-8e9277162e39	30da9b2e-814c-408d-823b-f2719459e315	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	6f74812e-ca45-4234-9a10-9bfe8f46467c	5.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:32:56.285781	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
13c633fa-008b-44a9-ba87-2f6553816a86	f81b6756-e9c8-4a45-8704-bcc647f20d12	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	448cb56a-e4d6-44c4-a49b-8a6119f36843	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:33:18.698413	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
0409ed5d-7dd3-4b7f-ab2e-ee764bec1ff5	f81b6756-e9c8-4a45-8704-bcc647f20d12	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	3554e4f4-8d4c-4b4a-9fe6-88eb1f5ef489	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:33:18.698413	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
3bb35651-b6bd-4358-ab41-eee2efc57fce	f81b6756-e9c8-4a45-8704-bcc647f20d12	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	f7be1839-a795-438b-b9da-54fed97ca1d7	5.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:33:18.698413	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
675fd2b0-69fd-404f-8c25-b7acbd01e2d3	f81b6756-e9c8-4a45-8704-bcc647f20d12	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	c42f0ccc-e7e4-447b-b392-ecd3eca5d764	5.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:33:18.698413	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
b207420a-b0cc-4b69-998d-a5f8b0d5924c	f81b6756-e9c8-4a45-8704-bcc647f20d12	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	9ceb0bdb-9f21-40da-b938-c7729ff2daa3	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:33:18.698413	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
71dba7b3-3343-48c4-b785-8161cdb365db	f81b6756-e9c8-4a45-8704-bcc647f20d12	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	6f903e44-300e-470c-aa64-125da9772880	5.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:33:18.698413	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
034d52f0-7a77-4511-b14e-38432b267991	f81b6756-e9c8-4a45-8704-bcc647f20d12	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	24c6259e-6fbf-4a75-a66e-bd8a2894b261	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:33:18.698413	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
4d970074-95b9-4d7f-a1de-0325518abc2f	f81b6756-e9c8-4a45-8704-bcc647f20d12	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	77c73ecd-3988-4efa-af44-efe3725e9f14	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:33:18.698413	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
bb775297-16a0-4f6b-ada7-bb4bb567f2e5	f81b6756-e9c8-4a45-8704-bcc647f20d12	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	698deda3-2aa9-4d4f-8a14-2fb80faac986	5.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:33:18.698413	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
d6d42a3b-1927-4a60-8f26-83a5f2049a6e	f81b6756-e9c8-4a45-8704-bcc647f20d12	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	f2cb1b7e-41df-411f-abaa-2ac7cbf58674	4.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:33:18.698413	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
1541cf63-cb72-4970-83a3-9f220dd2b386	f81b6756-e9c8-4a45-8704-bcc647f20d12	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	6f74812e-ca45-4234-9a10-9bfe8f46467c	5.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:33:18.698413	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
a46e88ef-16c4-4307-8090-572f1d77d2e3	a677d812-3140-440f-9603-2cff99ca31d4	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	448cb56a-e4d6-44c4-a49b-8a6119f36843	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:33:40.922205	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
769398b7-69e9-420a-916e-8b132dc0b17b	a677d812-3140-440f-9603-2cff99ca31d4	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	3554e4f4-8d4c-4b4a-9fe6-88eb1f5ef489	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:33:40.922205	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
4ecad81c-888f-4f3c-9c9f-06839842c13a	a677d812-3140-440f-9603-2cff99ca31d4	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	f7be1839-a795-438b-b9da-54fed97ca1d7	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:33:40.922205	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
5e41f188-524e-470f-8c17-c27ba9c6f396	a677d812-3140-440f-9603-2cff99ca31d4	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	c42f0ccc-e7e4-447b-b392-ecd3eca5d764	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:33:40.922205	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
bcea251e-2fe8-4f1c-a485-ee1cbe2745cb	a677d812-3140-440f-9603-2cff99ca31d4	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	9ceb0bdb-9f21-40da-b938-c7729ff2daa3	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:33:40.922205	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
cc924eaf-1d22-48b0-a33b-1497a90e4e30	a677d812-3140-440f-9603-2cff99ca31d4	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	6f903e44-300e-470c-aa64-125da9772880	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:33:40.922205	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
7f0b2592-5c62-4f81-a52b-3ebafff03eec	a677d812-3140-440f-9603-2cff99ca31d4	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	24c6259e-6fbf-4a75-a66e-bd8a2894b261	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:33:40.922205	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
e77deb16-6e73-4fb7-a4be-8404f2aa3154	a677d812-3140-440f-9603-2cff99ca31d4	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	77c73ecd-3988-4efa-af44-efe3725e9f14	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:33:40.922205	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
122f96f8-6c51-4b82-881e-3191ca2d31bc	a677d812-3140-440f-9603-2cff99ca31d4	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	698deda3-2aa9-4d4f-8a14-2fb80faac986	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:33:40.922205	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
8cf4d9a5-bf1a-4e40-84ff-a0c0a02d2a35	a677d812-3140-440f-9603-2cff99ca31d4	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	f2cb1b7e-41df-411f-abaa-2ac7cbf58674	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:33:40.922205	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
d9835298-5a35-4a40-8537-788248bce5da	a677d812-3140-440f-9603-2cff99ca31d4	a4ecd7f9-72b8-47f7-8e89-1a79528e98ae	6f74812e-ca45-4234-9a10-9bfe8f46467c	0.00	5.00	71e3d945-4236-4d79-87d7-9f3e1979f83b	2025-10-09 05:33:40.922205	\N	Submitted	694784ea-5501-483d-be6d-08f6667a6465
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.notifications (id, user_id, title, message, type, category, is_read, action_url, metadata, expires_at, created_at, read_at) FROM stdin;
\.


--
-- Data for Name: quadrants; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.quadrants (id, name, description, weightage, minimum_attendance, business_rules, is_active, display_order, created_at) FROM stdin;
persona	Persona	SHL Competencies and Professional Readiness	100.00	80.00	{}	t	1	2025-06-13 17:52:27.073051
wellness	Wellness	Physical, Mental, and Social Wellness	100.00	80.00	{}	t	2	2025-06-13 17:52:27.073051
behavior	Behavior	Professional Conduct, Interpersonal Skills, and Personal Development	100.00	0.00	{}	t	3	2025-06-13 17:52:27.073051
discipline	Discipline	Attendance, Code of Conduct, and Academic Discipline	100.00	0.00	{}	t	4	2025-06-13 17:52:27.073051
\.


--
-- Data for Name: scores; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.scores (id, student_id, component_id, term_id, obtained_score, max_score, assessment_date, assessed_by, assessment_type, notes, status, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sections; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.sections (id, batch_id, name, capacity, is_active, created_at) FROM stdin;
bda4bf18-c059-4b40-86eb-d1854cc88720	6322629c-643e-458b-9347-8b389f655a90	A	60	t	2025-06-13 18:04:58.849546
05ae4c96-12ca-4ed2-ab66-8ed3025036c6	6322629c-643e-458b-9347-8b389f655a90	B	60	t	2025-06-13 18:04:58.849546
42f6f3b8-9a6e-4d7c-91b7-d046543f83c4	f9294daf-2956-42b5-bba7-d5e11b23dcee	A	60	t	2025-06-13 18:04:58.849546
a5daefdb-0011-424b-8557-5abc257ece5d	4414fd0e-692d-4ad8-9f3c-2dbc6b292fd7	Section A	50	t	2025-06-14 04:29:18.807026
a17bba6f-4d5f-41bd-b6f9-9152ca1e797e	4cb5c881-4600-45a6-bc61-4dfcf85aff9a	Section A	50	t	2025-07-16 05:17:57.716142
\.


--
-- Data for Name: shl_integrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.shl_integrations (id, student_id, shl_user_id, competency_data, last_sync_at, sync_status, error_message, sync_attempts, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: student_improvement_goals; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.student_improvement_goals (id, student_id, term_id, component_id, target_score, target_date, actions, created_at, completed_at) FROM stdin;
\.


--
-- Data for Name: student_interventions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.student_interventions (id, student_id, intervention_id, enrollment_date, status, created_at) FROM stdin;
\.


--
-- Data for Name: student_level_progression; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.student_level_progression (id, student_id, term_id, level_number, level_name, progression_status, eligibility_status, attendance_percentage, quadrant_scores, overall_score, progression_date, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: student_profile_requests; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.student_profile_requests (id, student_id, requested_changes, current_values, request_reason, status, requested_by, reviewed_by, review_reason, created_at, reviewed_at) FROM stdin;
\.


--
-- Data for Name: student_rankings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.student_rankings (id, student_id, term_id, quadrant_id, rank_position, total_students, score, ranking_type, grade, created_at) FROM stdin;
\.


--
-- Data for Name: student_score_summary; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.student_score_summary (id, student_id, term_id, persona_score, wellness_score, behavior_score, discipline_score, total_hps, overall_grade, overall_status, last_calculated_at, calculation_version) FROM stdin;
aa87a05f-868e-445d-8c1d-53e0fe884494	3b1204ce-bbd5-43f3-aa84-980bb0b3a864	694784ea-5501-483d-be6d-08f6667a6465	79.04	0.00	0.00	77.50	78.78	C+	Satisfactory	2025-10-09 06:15:31.387	2
4d352e59-0660-4bd0-81d1-b71809cca11d	0e6b765b-cf10-4e8a-934f-78271f6bb7d3	694784ea-5501-483d-be6d-08f6667a6465	73.55	0.00	0.00	76.67	74.07	C	Satisfactory	2025-10-09 06:20:24.591	2
3e9d2281-4dc5-4444-8e9d-130288cb5ea3	a677d812-3140-440f-9603-2cff99ca31d4	694784ea-5501-483d-be6d-08f6667a6465	0.00	0.00	0.00	0.00	0.00	F	Poor	2025-10-08 17:48:54.823	2
f127457f-9f43-42b2-814d-efc92c73ab49	f81b6756-e9c8-4a45-8704-bcc647f20d12	694784ea-5501-483d-be6d-08f6667a6465	12.50	0.00	0.00	10.00	11.25	F	Poor	2025-10-08 19:04:56.16	2
37e04254-c760-4727-8b8a-fe24bf9f51e1	30da9b2e-814c-408d-823b-f2719459e315	694784ea-5501-483d-be6d-08f6667a6465	56.38	0.00	0.00	55.56	55.97	F	Poor	2025-10-09 05:36:47.988	2
\.


--
-- Data for Name: student_term_progression; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.student_term_progression (id, student_id, batch_id, term_id, term_number, enrollment_date, completion_date, status, eligibility_status, final_hps, final_grade, attendance_percentage, quadrant_scores, progression_notes, can_progress_to_next, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: student_terms; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.student_terms (id, student_id, term_id, enrollment_status, total_score, grade, overall_status, rank, is_eligible, enrolled_at, completed_at) FROM stdin;
\.


--
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.students (id, user_id, registration_no, name, course, batch_id, section_id, house_id, gender, phone, preferences, overall_score, grade, status, created_at, updated_at, current_term_id) FROM stdin;
0e6b765b-cf10-4e8a-934f-78271f6bb7d3	b5aa8c88-024d-4c56-991e-96196fa9e37e	2024JULB00002	Aaditya K	PGDM	f9294daf-2956-42b5-bba7-d5e11b23dcee	bda4bf18-c059-4b40-86eb-d1854cc88720	\N	Male	6383054727	{}	0.00	IC	Active	2025-10-07 15:31:42.24943	2025-10-09 05:32:34.070732	694784ea-5501-483d-be6d-08f6667a6465
30da9b2e-814c-408d-823b-f2719459e315	98169a54-9d83-4e09-8dee-4fd45fbae295	2024JULB00003	Aanchal Sapra	PGDM	f9294daf-2956-42b5-bba7-d5e11b23dcee	bda4bf18-c059-4b40-86eb-d1854cc88720	\N	Female	9545019964	{}	0.00	IC	Active	2025-10-07 15:31:42.736333	2025-10-09 05:32:56.285781	694784ea-5501-483d-be6d-08f6667a6465
a677d812-3140-440f-9603-2cff99ca31d4	02455f06-24af-4ac7-a30a-3a9c08a688ab	2024JULB00005	Abhirup Choudhury	PGDM	f9294daf-2956-42b5-bba7-d5e11b23dcee	bda4bf18-c059-4b40-86eb-d1854cc88720	\N	Male	8981766705	{}	0.00	IC	Active	2025-10-07 15:31:43.647544	2025-10-09 05:33:40.922205	694784ea-5501-483d-be6d-08f6667a6465
f81b6756-e9c8-4a45-8704-bcc647f20d12	16b165c1-e8b0-4789-a616-28cf97749ca4	2024JULB00004	Abhinav B	PGDM	f9294daf-2956-42b5-bba7-d5e11b23dcee	bda4bf18-c059-4b40-86eb-d1854cc88720	\N	Male	9847017803	{}	0.00	IC	Active	2025-10-07 15:31:43.183506	2025-10-09 05:33:18.698413	694784ea-5501-483d-be6d-08f6667a6465
3b1204ce-bbd5-43f3-aa84-980bb0b3a864	83dd0de1-cf4c-414b-93c6-2ba8e4daa739	2024JULB00001	A Divya Sree	PGDM	f9294daf-2956-42b5-bba7-d5e11b23dcee	bda4bf18-c059-4b40-86eb-d1854cc88720	\N	Female	6305789560	{}	0.00	IC	Active	2025-10-07 15:31:41.782545	2025-10-09 05:32:14.64929	694784ea-5501-483d-be6d-08f6667a6465
\.


--
-- Data for Name: sub_categories; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.sub_categories (id, quadrant_id, name, description, weightage, display_order, is_active, created_at, updated_at) FROM stdin;
bcd6a86f-338c-4997-ae43-f378cc10dbb0	persona	Internal	Internal Competencies	100.00	1	t	2025-10-08 09:30:24.322736	2025-10-08 17:44:32.347435
f1282f61-7149-4e9f-aaad-d3dc5b14d533	wellness	Fitness	Physical Fitness	100.00	1	t	2025-10-08 09:51:11.425385	2025-10-08 17:44:32.347435
167335d3-2172-4eb4-8275-af4341c79882	discipline	Academics	Academic discipline	100.00	1	t	2025-10-08 09:51:38.577108	2025-10-08 17:44:32.347435
ae887796-17a6-4ee8-ac39-8bd3154508de	persona	CAPSTONE	CAPSTONE subcategory for capstone projects and assessments	100.00	0	t	2025-10-09 05:22:47.916265	2025-10-09 05:22:47.916265
90298481-85b8-460e-a294-eb938947aa1e	discipline	CAPSTONE	CAPSTONE subcategory for capstone projects and assessments in Discipline	100.00	0	t	2025-10-09 05:26:25.65784	2025-10-09 05:26:25.65784
\.


--
-- Data for Name: system_settings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.system_settings (id, setting_key, setting_value, description, category, is_public, updated_by, updated_at) FROM stdin;
\.


--
-- Data for Name: task_microcompetencies; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.task_microcompetencies (id, task_id, microcompetency_id, weightage, created_at) FROM stdin;
\.


--
-- Data for Name: task_submissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.task_submissions (id, task_id, student_id, submitted_at, status, is_late, attachments, submission_text, score, rubric_scores, feedback, private_notes, graded_by, graded_at) FROM stdin;
\.


--
-- Data for Name: tasks; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.tasks (id, intervention_id, name, description, quadrant_id, component_id, max_score, due_date, instructions, rubric, attachments, submission_type, allow_late_submission, late_penalty, status, created_by, created_at, updated_at, microcompetency_id, created_by_teacher_id, requires_submission) FROM stdin;
\.


--
-- Data for Name: teacher_assignments; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.teacher_assignments (id, teacher_id, student_id, term_id, quadrant_id, assigned_at, assigned_by, is_active, notes) FROM stdin;
\.


--
-- Data for Name: teacher_microcompetency_assignments; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.teacher_microcompetency_assignments (id, intervention_id, teacher_id, microcompetency_id, can_score, can_create_tasks, assigned_at, assigned_by, is_active) FROM stdin;
644587d6-6741-4f3e-8b5e-9e1a55561bd2	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	71e3d945-4236-4d79-87d7-9f3e1979f83b	4476c3a6-58da-4c43-9b8a-b1da70172072	t	t	2025-10-08 15:40:07.639472	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	t
55e1849f-41e1-4ea5-8578-cd91c6c8a35d	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	71e3d945-4236-4d79-87d7-9f3e1979f83b	31a4c844-6a46-4b57-a23d-91d9a5ff7382	t	t	2025-10-08 15:40:07.639472	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	t
7c24c569-ffeb-443a-8c56-fe3a9abc6acc	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	71e3d945-4236-4d79-87d7-9f3e1979f83b	4d6b4184-d62e-427a-ba00-16ff3f4e4f10	t	t	2025-10-08 15:40:07.639472	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	t
bc937dbe-d3a7-4d75-961c-c279db2e27b7	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	71e3d945-4236-4d79-87d7-9f3e1979f83b	06947927-aab0-4d24-b5fe-b42c0b83050c	t	t	2025-10-08 15:40:07.639472	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	t
bbd336a0-deee-4bbb-bf23-d17f88e53090	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	71e3d945-4236-4d79-87d7-9f3e1979f83b	7e8983cd-5a94-49cc-9b80-64358a9d48f9	t	t	2025-10-08 15:40:07.639472	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	t
3d276e04-1d19-432d-bfa1-e80e5106675e	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	71e3d945-4236-4d79-87d7-9f3e1979f83b	685d23ad-eadc-47ac-9f91-8f741ae4211f	t	t	2025-10-08 15:40:07.639472	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	t
1c769591-ace3-45bd-8318-c25bd90534c5	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	71e3d945-4236-4d79-87d7-9f3e1979f83b	2e599a1f-e34d-436c-98f9-01f019cb29bd	t	t	2025-10-08 15:40:07.639472	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	t
9b016b26-39a6-44ef-8357-fdd0058c0929	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	71e3d945-4236-4d79-87d7-9f3e1979f83b	44a43cc4-8d2e-4ce5-b437-2b76a205ea84	t	t	2025-10-08 15:40:07.639472	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	t
94ad98d7-322a-4591-96ce-70bc07aefd20	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	71e3d945-4236-4d79-87d7-9f3e1979f83b	08314805-8508-4254-997b-a035415747d5	t	t	2025-10-08 15:40:07.639472	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	t
83bdd203-0e1f-438b-bfd4-1d68d8ee857c	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	71e3d945-4236-4d79-87d7-9f3e1979f83b	88fad813-46ed-4601-a334-ae77df797be3	t	t	2025-10-08 15:40:07.639472	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	t
92ba28ac-b95a-402e-b807-b37d6be6aefa	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	71e3d945-4236-4d79-87d7-9f3e1979f83b	9358b2c4-aebc-480a-9eff-6873c156da12	t	t	2025-10-08 15:40:07.639472	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	t
97757139-ef29-4ade-9234-37508d3bf226	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	71e3d945-4236-4d79-87d7-9f3e1979f83b	7022a346-204b-472a-b46b-b801f07e8853	t	t	2025-10-08 15:40:07.639472	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	t
46465e57-9e41-4856-836b-ec8172f5ae34	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	71e3d945-4236-4d79-87d7-9f3e1979f83b	6852ffde-5e9e-4faa-be78-93d194b1f8b7	t	t	2025-10-08 15:40:07.639472	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	t
aaa07ced-f657-4784-8d3d-f33ee54ed689	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	71e3d945-4236-4d79-87d7-9f3e1979f83b	ec97e568-30d6-4e8f-acb3-b74d1b4b5436	t	t	2025-10-08 15:40:07.639472	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	t
9f2a253a-55e3-4a12-aeaf-1d8ced4b1f0b	b626892a-a3a5-4040-ab9c-5d8ff7c7d866	71e3d945-4236-4d79-87d7-9f3e1979f83b	41ab0a41-f16e-4bd5-961e-5b070acd6410	t	t	2025-10-08 15:40:07.639472	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	t
d3227a02-b952-4a51-93b4-27ada3d4393e	88db9091-ce2d-4403-8435-836d38255f2c	71e3d945-4236-4d79-87d7-9f3e1979f83b	4476c3a6-58da-4c43-9b8a-b1da70172072	t	t	2025-10-08 18:01:32.935025	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	t
e6dd640b-a32c-466f-916c-08c10c690de1	88db9091-ce2d-4403-8435-836d38255f2c	71e3d945-4236-4d79-87d7-9f3e1979f83b	31a4c844-6a46-4b57-a23d-91d9a5ff7382	t	t	2025-10-08 18:01:32.935025	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	t
870e61a6-3422-4f2d-bc25-55bb460c9bb7	88db9091-ce2d-4403-8435-836d38255f2c	71e3d945-4236-4d79-87d7-9f3e1979f83b	4d6b4184-d62e-427a-ba00-16ff3f4e4f10	t	t	2025-10-08 18:01:32.935025	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	t
3bf4b1e4-4ce6-4609-8410-f134e8f6698b	88db9091-ce2d-4403-8435-836d38255f2c	71e3d945-4236-4d79-87d7-9f3e1979f83b	06947927-aab0-4d24-b5fe-b42c0b83050c	t	t	2025-10-08 18:01:32.935025	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	t
62b87be8-c7fd-4a4e-a846-33cc42315893	88db9091-ce2d-4403-8435-836d38255f2c	71e3d945-4236-4d79-87d7-9f3e1979f83b	7e8983cd-5a94-49cc-9b80-64358a9d48f9	t	t	2025-10-08 18:01:32.935025	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	t
eabd039c-0601-4f02-8c3b-127e1a23628a	88db9091-ce2d-4403-8435-836d38255f2c	71e3d945-4236-4d79-87d7-9f3e1979f83b	685d23ad-eadc-47ac-9f91-8f741ae4211f	t	t	2025-10-08 18:01:32.935025	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	t
603266dc-11d4-465a-b310-6aace3f67487	88db9091-ce2d-4403-8435-836d38255f2c	71e3d945-4236-4d79-87d7-9f3e1979f83b	2e599a1f-e34d-436c-98f9-01f019cb29bd	t	t	2025-10-08 18:01:32.935025	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	t
ee5dc10a-4364-4e81-9da2-0d3b63793a31	88db9091-ce2d-4403-8435-836d38255f2c	71e3d945-4236-4d79-87d7-9f3e1979f83b	44a43cc4-8d2e-4ce5-b437-2b76a205ea84	t	t	2025-10-08 18:01:32.935025	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	t
307f3cce-65ba-44e8-acc9-beea150245cf	88db9091-ce2d-4403-8435-836d38255f2c	71e3d945-4236-4d79-87d7-9f3e1979f83b	08314805-8508-4254-997b-a035415747d5	t	t	2025-10-08 18:01:32.935025	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	t
7012f6cc-06d4-4cd0-ac6f-119865ee1674	88db9091-ce2d-4403-8435-836d38255f2c	71e3d945-4236-4d79-87d7-9f3e1979f83b	88fad813-46ed-4601-a334-ae77df797be3	t	t	2025-10-08 18:01:32.935025	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	t
ab17f040-98a0-4f60-a7c9-05b50eaaf9cd	88db9091-ce2d-4403-8435-836d38255f2c	71e3d945-4236-4d79-87d7-9f3e1979f83b	9358b2c4-aebc-480a-9eff-6873c156da12	t	t	2025-10-08 18:01:32.935025	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	t
3ca35302-d212-4d9d-a73e-131c13e6bb0c	88db9091-ce2d-4403-8435-836d38255f2c	71e3d945-4236-4d79-87d7-9f3e1979f83b	7022a346-204b-472a-b46b-b801f07e8853	t	t	2025-10-08 18:01:32.935025	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	t
2a90bfbb-23f5-463d-aec1-bb56e9f71849	88db9091-ce2d-4403-8435-836d38255f2c	71e3d945-4236-4d79-87d7-9f3e1979f83b	6852ffde-5e9e-4faa-be78-93d194b1f8b7	t	t	2025-10-08 18:01:32.935025	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	t
466d6e97-d2ce-4afe-983d-319411c83fbc	88db9091-ce2d-4403-8435-836d38255f2c	71e3d945-4236-4d79-87d7-9f3e1979f83b	ec97e568-30d6-4e8f-acb3-b74d1b4b5436	t	t	2025-10-08 18:01:32.935025	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	t
419ccb06-deb4-41cd-b64d-eaa7a1d657a5	88db9091-ce2d-4403-8435-836d38255f2c	71e3d945-4236-4d79-87d7-9f3e1979f83b	41ab0a41-f16e-4bd5-961e-5b070acd6410	t	t	2025-10-08 18:01:32.935025	83304ac0-1cd5-47ec-97d0-27582e7ae2bb	t
\.


--
-- Data for Name: teachers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.teachers (id, user_id, employee_id, name, specialization, department, assigned_quadrants, is_active, created_at, updated_at) FROM stdin;
71e3d945-4236-4d79-87d7-9f3e1979f83b	b0cde931-c687-42e5-9643-e36a15868f17	qwerty123	Srikant qw	persona	asdfg	["persona"]	t	2025-07-12 06:49:52.003976	2025-07-12 06:49:52.003976
\.


--
-- Data for Name: term_lifecycle_events; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.term_lifecycle_events (id, term_id, batch_id, event_type, event_date, triggered_by, event_data, notes, created_at) FROM stdin;
\.


--
-- Data for Name: terms; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.terms (id, name, description, start_date, end_date, is_active, is_current, academic_year, created_at, term_number, term_status, level_name, attendance_threshold, progression_requirements, eligibility_rules, completion_date, max_students, level_number) FROM stdin;
ef77ce62-77d3-4de6-864b-b74abab79d22	00		2023-08-01	2023-08-23	t	f	00	2025-08-30 06:25:49.890363	1	upcoming	\N	75.00	\N	\N	\N	\N	1
694784ea-5501-483d-be6d-08f6667a6465	Test Term		2025-10-01	2025-12-31	t	t	2025	2025-10-07 12:56:02.156301	1	upcoming	\N	75.00	\N	\N	\N	\N	1
\.


--
-- Data for Name: user_sessions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_sessions (id, user_id, session_token, refresh_token, ip_address, user_agent, expires_at, created_at, last_accessed, is_active) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (id, username, email, password_hash, role, status, last_login, created_at, updated_at, microsoft_id, sso_provider, erp_validated, first_name, last_name, kos_user_id, authenticated_via, user_source, promoted_by, promoted_at, promotion_reason, last_kos_sync) FROM stdin;
02455f06-24af-4ac7-a30a-3a9c08a688ab	2024JULB00005	abhirup.choudhury2426@jagsom.edu.in	$2a$12$XBnCq6EJUUgKbzmyUIO.ouB4mOkKjA0CZQ64FiltUZLYFLw2HIjTO	student	active	\N	2025-10-07 15:31:43.516935	2025-10-07 15:31:43.516935	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
0ec59edd-0075-4bb7-b56f-0d264e7febf0	2024JULB00006	abhyuday.tripathi2426@jagsom.edu.in	$2a$12$u4pRDzxO.3qjV4soiDLDb.S4pqxDqfoRcywNzWKmAxv.s6EcFjDQi	student	active	\N	2025-10-07 15:31:43.943677	2025-10-07 15:31:43.943677	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
24475dd6-1de0-4057-ae32-f7c189673739	2024JULB00007	adarsh.g2426@jagsom.edu.in	$2a$12$eUP75gl9FQF.Tp1Be54ad.F4mSstWsr.w12eaVbAxq1UxVLzs.HbG	student	active	\N	2025-10-07 15:31:44.390014	2025-10-07 15:31:44.390014	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
2e3c0a2b-51eb-4e73-8343-d7041058bfd2	2024JULB00008	adarsh.barman2426@jagsom.edu.in	$2a$12$bYkhD3KS9oDo.UP2TBYez.HCvwjRplEVDt34CY2YdpmplTxCIkR66	student	active	\N	2025-10-07 15:31:44.867942	2025-10-07 15:31:44.867942	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
ee519209-77a4-400d-8096-875af8ce7603	2024JULB00009	aditi.kumari2426@jagsom.edu.in	$2a$12$AI0uYApBlUDlYeMwEnZiH.cYTHmg8GAIzXdkdBFdMdR6QDVnp6VA6	student	active	\N	2025-10-07 15:31:45.31159	2025-10-07 15:31:45.31159	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
b7584a9b-cedc-4169-a60a-98e9eed79f3e	2024JULB00012	akarsh.narain2426@jagsom.edu.in	$2a$12$fTllQMDvvl4y2Zq196zd7O3nwqGcixLHMe3ictRJeWsb/nExbzWh2	student	active	\N	2025-10-07 15:31:45.748265	2025-10-07 15:31:45.748265	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
8e9b0837-afb8-4235-918c-f08ba0b0c0ff	2024JULB00013	akshat.singh2426@jagsom.edu.in	$2a$12$w8yQvqw6kgJ7SRoRsCdg6ecAMqzh3YNMtVWEQEGdrGcpTbdYeKafu	student	active	\N	2025-10-07 15:31:46.190851	2025-10-07 15:31:46.190851	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
52b47175-7450-4cf5-9389-7a842b3edbd2	2024JULB00014	amal.shibubalan2426@jagsom.edu.in	$2a$12$7Zk3F8rA.D25UlFv1z8nbeAPFh8JILcXohmuQ3ZQNHOkRpJVATW2O	student	active	\N	2025-10-07 15:31:46.632672	2025-10-07 15:31:46.632672	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
9fe406f3-578f-4db0-8573-b7faa035f5e0	2024JULB00017	anamitra.dutta2426@jagsom.edu.in	$2a$12$4oF4u4jxBVyCNMM7Bt2TWuc2S6SBzt7XdTVd.e2yttzBtNCec1ISC	student	active	\N	2025-10-07 15:31:47.212423	2025-10-07 15:31:47.212423	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
c8ddd3db-6330-4c23-b019-81afa9e4c3b0	2024JULB00019	anantaa.paul2426@jagsom.edu.in	$2a$12$FpVjIHuE/yHNqZkhev/vzOtVf2SUvmXPxx0oAeBvrAWK.mS01.UgC	student	active	\N	2025-10-07 15:31:47.65621	2025-10-07 15:31:47.65621	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
5d313a7d-66c7-4a62-b395-641d804baed9	2024JULB00020	ananya.das2426@jagsom.edu.in	$2a$12$J0mH/XnM2iXq/q0LnByUSOfxFfV4OSZNw9f7XnrsrcshyHi3D31lC	student	active	\N	2025-10-07 15:31:48.137066	2025-10-07 15:31:48.137066	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
cc2788f0-5ba2-41ac-b783-becbbf7af421	2024JULB00021	aniket.inani2426@jagsom.edu.in	$2a$12$xKuGvo6ABsKrjz4KcEFCP.F3mZffNgQSWE/bZ2VbzF2MG9U0wnZ0i	student	active	\N	2025-10-07 15:31:48.581681	2025-10-07 15:31:48.581681	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
21f3773a-4833-4951-8a39-41d853b35c8d	2024JULB00022	anupa.maheshwari2426@jagsom.edu.in	$2a$12$KXwOeWLPmVOkltiBkzWFJupXnM2PXFIuVIC.rAwWf2453dTIiMDnm	student	active	\N	2025-10-07 15:31:49.079849	2025-10-07 15:31:49.079849	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
f34a799a-f2ad-4f9f-87b3-40f1387d5d4d	2024JULB00024	apoorwa.mishra2426@jagsom.edu.in	$2a$12$/qCIO./d81sKtz21u58aWe6mZycfSWVz80BHOUFggeqCkskXSpkW6	student	active	\N	2025-10-07 15:31:49.974848	2025-10-07 15:31:49.974848	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
541f5714-9c67-4447-8680-94aa00ca4f8e	2024JULB00025	arit.roy2426@jagsom.edu.in	$2a$12$Ce.5MAs2npcFFW1cI4KhO.HfsaTMKCwEjyITjwvnUcOFllzkdfZb2	student	active	\N	2025-10-07 15:31:50.436899	2025-10-07 15:31:50.436899	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
b9bbef5d-ec3c-4939-9bfa-78a1ff1ccad2	2024JULB00026	arush.mangal2426@jagsom.edu.in	$2a$12$jZEKVrTqEoovSKC5MEI33u4o3yCbrVYLmAJcLDOMUji2t1Z311HgC	student	active	\N	2025-10-07 15:31:50.874164	2025-10-07 15:31:50.874164	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
424a6df6-516e-4163-8683-168ba19b5f96	2024JULB00027	aryan.atreya2426@jagsom.edu.in	$2a$12$cVgoMelvUe.yTmeNTMmeCuuI0R.CamUeE1jksUF6xf0xjkVJZWmyC	student	active	\N	2025-10-07 15:31:51.356679	2025-10-07 15:31:51.356679	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
051ee566-d660-489f-9993-1fd064cd2c4e	2024JULB00029	aryan.trivedi2426@jagsom.edu.in	$2a$12$68CqSn.wXpLIzqI041syCet9r91iWZrmEf/vWKE3kC6Yz6n2N4TeO	student	active	\N	2025-10-07 15:31:52.279112	2025-10-07 15:31:52.279112	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
79b91488-b1d6-45fd-844d-72c0c59d546a	2024JULB00030	ashisha.john2426@jagsom.edu.in	$2a$12$mokmdEY.7OvNPNC9bZXy1.Cx13bfh2a3wqEMQxYhzlE4V5k4DUpe.	student	active	\N	2025-10-07 15:31:52.731467	2025-10-07 15:31:52.731467	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
392d1fbf-f696-434d-9d50-7de742233c4e	2024JULB00031	ashita.roshan2426@jagsom.edu.in	$2a$12$oVsalxqB6g8QrKM8YsmM.egC4z0hDfZNeEHQyawcRFh7TJX7DSQEW	student	active	\N	2025-10-07 15:31:53.180432	2025-10-07 15:31:53.180432	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
98c96dab-ef47-43f0-a102-c28c1843e3d6	2024JULB00032	ashutosh.sharan2426@jagsom.edu.in	$2a$12$QGiG.89G/YM8PGh7MvgROOJiD9nJ2HDChEkiZd98oXNk2QK2Qdd..	student	active	\N	2025-10-07 15:31:53.668553	2025-10-07 15:31:53.668553	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
f1cf0aa0-41f8-421f-8f39-1b65d7888274	2024JULB00033	ashwin.bhaskar2426@jagsom.edu.in	$2a$12$aS3RsFj13WeeNvVphKTy/eoqLIqiZfM0jUjRkmwMBkQjzkTDGcElG	student	active	\N	2025-10-07 15:31:54.094443	2025-10-07 15:31:54.094443	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
78ac9ba3-c429-45cf-af78-f715a4f8f7ae	2024JULB00034	ayush.anand2426@jagsom.edu.in	$2a$12$CXUw4QlZJi0mu6bbnEdBw..k8DL7ISW2eHQw817CGVShXyW2RXwri	student	active	\N	2025-10-07 15:31:54.542032	2025-10-07 15:31:54.542032	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
9dd8dd91-3fd0-4d95-8d71-b7eb8569de30	2024JULB00037	bhavik.puri2426@jagsom.edu.in	$2a$12$6cQa94Oc9lZtxfvSeyun.u69CVVgUfadwQ08jkDqHTI3P.J.9UsNy	student	active	\N	2025-10-07 15:31:54.957654	2025-10-07 15:31:54.957654	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
e06045e2-6c7e-4870-9c18-355e6ecb926a	2024JULB00038	bibek.muduli2426@jagsom.edu.in	$2a$12$Saat9LcXLmKvco.uR/HpRu/Xpa6/cQe60ku3kbas8WOZzisFXszQq	student	active	\N	2025-10-07 15:31:55.407325	2025-10-07 15:31:55.407325	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
3e4641c2-1df4-4516-ab23-49fd9139a505	2024JULB00039	bipasha.mandal2426@jagsom.edu.in	$2a$12$AQemIWSzKu7HPS4UD7N7xeXecOZFR0wZ45INsRMdLyDarKI17elKG	student	active	\N	2025-10-07 15:31:55.874043	2025-10-07 15:31:55.874043	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
8c94deb6-5f01-4dbc-bc15-98646feeb144	2024JULB00040	bonula.pravallika2426@jagsom.edu.in	$2a$12$Vaj6ofmePOCHlkLSfOrr6eJt0WGR/u5vAKqkOkaMpah1HfGidi28G	student	active	\N	2025-10-07 15:31:56.344571	2025-10-07 15:31:56.344571	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
7bbaff82-30e2-4bac-a716-8346379c1f7b	2024JULB00041	c.divyashree2426@jagsom.edu.in	$2a$12$AZ2Xe1VKsX8Voe3XKbQYLuKhvjjiT04eE7aE.5pJ4Z6zcdY6rMeS2	student	active	\N	2025-10-07 15:31:56.776334	2025-10-07 15:31:56.776334	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
eadee039-d341-47b8-a1f5-3820ef320a40	2024JULB00042	chaitya.sahu2426@jagsom.edu.in	$2a$12$.RJOLORRFeGaivWgRVRzbegvKgheVkrIL3K.KK/fpb58aXIz87xOK	student	active	\N	2025-10-07 15:31:57.210851	2025-10-07 15:31:57.210851	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
d8cbd499-cdef-4a4d-8a83-50df2ac6ad15	2024JULB00044	chirag.bhardwaj2426@jagsom.edu.in	$2a$12$VLPT/T1UQMg/VlhPoG82seTtXcnU57Hh76GVSjUv/GSbRD6hCy.ou	student	active	\N	2025-10-07 15:31:57.629894	2025-10-07 15:31:57.629894	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
83be9e49-98d1-4fa6-9f55-fad3b338eac6	2024JULB00046	darsh.shah2426@jagsom.edu.in	$2a$12$WFQMdrdlV86hllCN9lO3VuZMtoFgFHCNxIIm25kXkekwTTtG5HjU6	student	active	\N	2025-10-07 15:31:58.102534	2025-10-07 15:31:58.102534	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
5f70f088-21df-4fd1-9708-b3d5c31ebbca	2024JULB00047	debotree.roy2426@jagsom.edu.in	$2a$12$F4nydQzDX2GteOe.g0VVDOBokw9A.uuzayN8on3ocZVFNdemGlEcq	student	active	\N	2025-10-07 15:31:58.557386	2025-10-07 15:31:58.557386	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
171262e5-2405-41be-8462-75593214205c	2024JULB00048	deekshitha.s2426@jagsom.edu.in	$2a$12$dGYwTvkmpDPVJpEXzbU45uWkANbQkI7/RviRpHbRmBI3EI.GPWdIu	student	active	\N	2025-10-07 15:31:59.022067	2025-10-07 15:31:59.022067	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
98169a54-9d83-4e09-8dee-4fd45fbae295	2024JULB00003	aanchal.sapra2426@jagsom.edu.in	$2a$12$VgI7bsIGOJcEstuq4M4NtetNnHqfMT3J9wwlyM/Vh4kfObJ2pXvza	student	active	2025-10-09 05:36:46.49	2025-10-07 15:31:42.575071	2025-10-09 05:36:46.526219	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
16b165c1-e8b0-4789-a616-28cf97749ca4	2024JULB00004	abhinav.b2426@jagsom.edu.in	$2a$12$BF9k105lxZ6XhXQvOde/JO9dH4PTFZ7bxyeiCOBJN2jXtCGaVcmee	student	active	2025-10-08 18:53:37.275	2025-10-07 15:31:43.039494	2025-10-08 18:53:37.312352	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
83304ac0-1cd5-47ec-97d0-27582e7ae2bb	superadmin	admin@pepscore.local	$2a$12$Db5bbKv7ob2NKXMvZZfp8ejCC7KB2ixDWcY1hxQDLpSkv3luG4YbK	admin	active	2025-08-19 18:07:00.384	2025-07-11 10:33:58.894	2025-08-19 18:07:00.421512	\N	\N	f	Super	Administrator	\N	local	super_admin	\N	\N	\N	\N
83dd0de1-cf4c-414b-93c6-2ba8e4daa739	2024JULB00001	a.divyaSree2426@jagsom.edu.in	$2a$12$QLUa3XaBhMSJ736hc0hzLuarCgIBsBjCXP5qhdbjSIqyVKC0nGcP2	student	active	2025-10-09 06:11:38.059	2025-10-07 15:31:41.6062	2025-10-09 06:11:38.097899	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
b5aa8c88-024d-4c56-991e-96196fa9e37e	2024JULB00002	aaditya.k2426@jagsom.edu.in	$2a$12$q.ve4XuOnDRlA1ztLifDkeij9ecaleVHC88zYxmLLW.Lu0NgykRai	student	active	2025-10-09 06:17:22.079	2025-10-07 15:31:42.098975	2025-10-09 06:17:22.109105	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
c18a144c-6615-4d0a-ad24-9cc1d6050f67	2024JULB00049	deepak.birthare2426@jagsom.edu.in	$2a$12$nTmX0CJ/8AQSF3aVCI9lAuwjrL20NEL.kbvTVjdN/0zsMq36oHPVW	student	active	\N	2025-10-07 15:31:59.496536	2025-10-07 15:31:59.496536	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
f80ff9b5-051c-45fa-9725-50099eb2dece	2024JULB00053	disha.baid2426@jagsom.edu.in	$2a$12$99PjoESGwyRvBgOeAmztkOrOvgIdlMtl6Ld7TUu0eEn61RLBjCQqG	student	active	\N	2025-10-07 15:31:59.918576	2025-10-07 15:31:59.918576	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
5b1fc1ab-f521-43cd-9260-adfcb416ee1e	2024JULB00054	divya.ashok2426@jagsom.edu.in	$2a$12$lUmwZKfU.uU/OGk5VRUpXenWkr74qwnrVP5c6Pu650Gvgx4pJZ6c.	student	active	\N	2025-10-07 15:32:00.511957	2025-10-07 15:32:00.511957	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
ce68079d-9ea3-43e6-978a-62afcd9bd176	2024JULB00055	divyam.sood2426@jagsom.edu.in	$2a$12$3Jc4pHz0OYSp7.e6n/wMDethWqovGIv.22vtN/1lIuFUjm0vFwZyS	student	active	\N	2025-10-07 15:32:00.945038	2025-10-07 15:32:00.945038	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
133d6d31-9a28-4fb0-b43e-87e84f85d86c	2024JULB00056	elina.mahanta2426@jagsom.edu.in	$2a$12$H9SV2YsiIcEp/bhqzQ4JTOU2uTNc.VLzSlsnphWoF8oWbOEuJZnh6	student	active	\N	2025-10-07 15:32:01.37315	2025-10-07 15:32:01.37315	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
cdf3f20d-bf10-480a-bfc7-a1b388b05d0c	2024JULB00057	faizul.niaz2426@jagsom.edu.in	$2a$12$cdw/HWzrdC7/czqtCuP4jOiBdwtMjIgS0YDlRQMevUUzbA8ne/qT6	student	active	\N	2025-10-07 15:32:01.829183	2025-10-07 15:32:01.829183	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
113df14b-7182-41e2-82b3-5a4cfee108b5	2024JULB00058	farheena.jamadar2426@jagsom.edu.in	$2a$12$u5uzI0v7RxMvVlpEDK4NU.xOzeMugo7ycFntXTmErHeJ2bVmjCdDS	student	active	\N	2025-10-07 15:32:02.281634	2025-10-07 15:32:02.281634	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
e719fb62-9916-4ec2-829b-a8806c0e1c0f	2024JULB00059	gtharnath.reddy2426@jagsom.edu.in	$2a$12$VDMZ7UA1uC5N1CWvNYnMZePAsI.1mTWwrLfg.Ic/x1lW2XJ/XhwzC	student	active	\N	2025-10-07 15:32:02.743192	2025-10-07 15:32:02.743192	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
d69785cd-9362-42bb-b9e2-1ed26df816c0	2024JULB00060	gagan.cs2426@jagsom.edu.in	$2a$12$vzZlV9eeOr5PCo/hKGD9EeaAFo8SzPzy5xJF5vnneFFgdmsTCLagS	student	active	\N	2025-10-07 15:32:03.192178	2025-10-07 15:32:03.192178	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	admin	admin@pepscorennexus.com	$2b$10$N9XPPIdS5VKARICfrPMITO33Zp5l64ch8RviN8fIJ7WcCD9hoYZAG	admin	active	2025-10-09 05:46:41.662	2025-06-13 18:17:31.546211	2025-10-09 05:46:41.683653	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
bebd43ed-1f09-497b-a70c-c2e7b3790a17	2024JULB00061	gaurav.gaur2426@jagsom.edu.in	$2a$12$EUrB5dlunCxh7Tej6GU7D.x2uO2p8OF5M9BdVgSdwHG3rCivR0MTG	student	active	\N	2025-10-07 15:32:03.628242	2025-10-07 15:32:03.628242	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
bd433081-52ea-4553-911e-88c44805f56b	2024JULB00062	harish.kumarr2426@jagsom.edu.in	$2a$12$dE/gj5.CT2m9qi.SjyOoqORokgMoVhAdpJ5lvcgUBRm9qSF9cpVci	student	active	\N	2025-10-07 15:32:04.059309	2025-10-07 15:32:04.059309	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
b5c89002-0f68-425e-816f-d2c3ec869479	2024JULB00063	harshavarthni2426@jagsom.edu.in	$2a$12$TApngHtz8wFaovSSAI8qXObw6ZVMzY5jWaBWQ5ejbV1Q1pldEBIMO	student	active	\N	2025-10-07 15:32:04.507264	2025-10-07 15:32:04.507264	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
d67121bb-6b9b-480b-bcac-488fba2dbb21	2024JULB00064	hemant.prajapat2426@jagsom.edu.in	$2a$12$G578NQF3YNxopE8AtTcIsO3AYjIDMz/whgIED3ezZYvk7Z1VIlGqC	student	active	\N	2025-10-07 15:32:05.020861	2025-10-07 15:32:05.020861	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
6f0d4ae4-1c64-49ac-bc35-29dd9d08650e	2024JULB00065	himanshu.chahar2426@jagsom.edu.in	$2a$12$RjkdDvn4aYe8KM2kZfWXkOZnNkY0lUdYOAqfQdOTmpj1.yRtHL1/6	student	active	\N	2025-10-07 15:32:05.444151	2025-10-07 15:32:05.444151	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
989ab6bf-93a7-41b7-99a7-96f991b147a3	2024JULB00066	himanshu.upadhyay2426@jagsom.edu.in	$2a$12$d4nCrkSbtZsOijXFZyaTXO7OcwA6oSAWfyiPxzl/sLYU1jM68sPBC	student	active	\N	2025-10-07 15:32:05.912353	2025-10-07 15:32:05.912353	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
8962b2ac-3da9-4317-8d00-662f48290786	2024JULB00069	jay.dwivedi2426@jagsom.edu.in	$2a$12$e4I.6ckx/5q4Qs23Ep84FODulvk.BXaOXMI71pbGE870HXl2fFTS2	student	active	\N	2025-10-07 15:32:06.328446	2025-10-07 15:32:06.328446	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
94962c05-3a9a-4878-9cf7-60a6e968cc41	2024JULB00071	jyoti.sahoo2426@jagsom.edu.in	$2a$12$WMlknsetd.GjoTHmUQMacuVFCDD6ny8YD3LC9LA/3pWn9SZYKZ9uG	student	active	\N	2025-10-07 15:32:06.788895	2025-10-07 15:32:06.788895	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
8263b62a-9222-4523-8753-cd65768d53e4	2024JULB00072	kajal.choudhary2426@jagsom.edu.in	$2a$12$6m8XUWHPc89mWIaBsZt2zuUB1cM1YgdVEyHctO.qOshcmgVJM0FZK	student	active	\N	2025-10-07 15:32:07.250968	2025-10-07 15:32:07.250968	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
e219d881-3e12-425d-a752-1737904acbd0	2024JULB00073	k.balajireddy2426@jagsom.edu.in	$2a$12$yHaJU7Qr8/ZzxK7cvzynh.buANLk9Fh3nghgozc0p56r1LJPDuq1C	student	active	\N	2025-10-07 15:32:07.684519	2025-10-07 15:32:07.684519	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
503a62ae-bd38-421a-a3bf-e6173c1bc028	2024JULB00074	karan.kashyap2426@jagsom.edu.in	$2a$12$kYgWBA7GZix3ZTxSQlB2F.eXuhWwBbRktbxku.68b0W0WsWoQEhLC	student	active	\N	2025-10-07 15:32:08.100002	2025-10-07 15:32:08.100002	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
fa3992d7-8c6b-4d18-8988-b71b2fedbef2	2024JULB00075	kartheek.devarapalli2426@jagsom.edu.in	$2a$12$rrZmpsWmdtLj1rMKTLisnug1Eg6AV3JwY86NYjU4NlsdvREU.zMQG	student	active	\N	2025-10-07 15:32:08.522915	2025-10-07 15:32:08.522915	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
d619339c-a3f9-4bd3-a9ee-806d85aebaf7	2024JULB00076	karthik.gr2426@jagsom.edu.in	$2a$12$OsWS.6xS3njkUpxHqgL8juLzuyvBiJIZ1C5SUKtqG0t6PRPRyPXoa	student	active	\N	2025-10-07 15:32:08.972924	2025-10-07 15:32:08.972924	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
a2c05c14-feca-4f25-bdd4-8aaa1d8c7072	2024JULB00077	kavya.devarapalli2426@jagsom.edu.in	$2a$12$NzhixBKOiRjtmcIas32up.Z/MNWMkh97bZjS1bIEvqVOTOmOghuH2	student	active	\N	2025-10-07 15:32:09.391152	2025-10-07 15:32:09.391152	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
15f2ab48-eefd-4b0d-b055-6c79c5ce8a00	2024JULB00078	keshav.dhoot2426@jagsom.edu.in	$2a$12$ePD2vPn59bhkhZGSpX3n3O6PexflLzNNc5x1ut.LMVdSzjYGz06zG	student	active	\N	2025-10-07 15:32:09.834631	2025-10-07 15:32:09.834631	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
44ef31e2-ce85-4f01-95d9-9122fb3bee19	2024JULB00080	koustav.biswas2426@jagsom.edu.in	$2a$12$pIroIxrnFLfKuPMK6BGHHem4WVwn.aQamfZKxs5RbwdH00O.igyIm	student	active	\N	2025-10-07 15:32:10.256652	2025-10-07 15:32:10.256652	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
19e93ca9-faee-480d-990f-d0ff261c4f7c	2024JULB00081	krish.chakraborty2426@jagsom.edu.in	$2a$12$sqzek2xab6GSgr6w4kqYIuPDABrGc2aqsU/1D02ADZy4gz3RjfzVa	student	active	\N	2025-10-07 15:32:10.716857	2025-10-07 15:32:10.716857	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
cc0fbeae-cc6d-47cb-a296-348e4073d03b	2024JULB00236	prachi.pandey2426@jagsom.edu.in	$2a$12$b367wriz/1IWctbZB2yJJ.xo1EgrpDcg021yFFXUcfOGwhqfo5lxm	student	active	\N	2025-10-07 15:33:11.493025	2025-10-07 15:33:11.493025	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
654d3369-e941-4835-afa7-69f1473eb3f5	2024JULB00238	krishna.singh2426@jagsom.edu.in	$2a$12$vc9.O.Zfeh/7QJUy95F8H.DlWBLjt9T2CAvz/88HJgwE3ChGIvOxK	student	active	\N	2025-10-07 15:33:12.134619	2025-10-07 15:33:12.134619	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
90474c37-7410-44e7-829c-2aa5a2a075f9	2024JULB00239	abhishek.nanda2426@jagsom.edu.in	$2a$12$YqwJJdRZTTW.GgqBSesOP.JAJo3krBMRiaonJfrslxfEWTDz/H8ee	student	active	\N	2025-10-07 15:33:12.817176	2025-10-07 15:33:12.817176	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
286a1f20-1d21-4a23-8efd-139303ae822c	2024JULB00240	prabhansha.vyas2426@jagsom.edu.in	$2a$12$iXXVdNaGWWPMUZQ.1o/gyemCVbBLTrQisXNiIYlX8WazEKnFUKITy	student	active	\N	2025-10-07 15:33:13.2676	2025-10-07 15:33:13.2676	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
224ebec5-a184-4384-ac1d-167b2feccb72	2024JULB00241	anu.kumari2426@jagsom.edu.in	$2a$12$PA3uuw8XI7FGTROPa.Tmj.lfOuQz4a7UlQPBLXdylsTkKgjY0YbRu	student	active	\N	2025-10-07 15:33:13.722894	2025-10-07 15:33:13.722894	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
4076d275-36c9-4792-8733-6ed06767846e	2024JULB00242	shreya.sethi2426@jagsom.edu.in	$2a$12$KBaHSm2v7QH7oFsJsIQN/ucxwF/3iFqvXv7gLlAo8DqxdJqX.Zm3S	student	active	\N	2025-10-07 15:33:14.191027	2025-10-07 15:33:14.191027	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
65628c89-74df-4f2f-9a5b-71f90d543098	2024JULB00243	sahil.gupta2426@jagsom.edu.in	$2a$12$9MOkQsA0MpOgK.eRmT.PMeIfD3pck15lkhoRLnRKqzRDbtzDDlFgC	student	active	\N	2025-10-07 15:33:14.650719	2025-10-07 15:33:14.650719	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
881395ad-a862-48c8-9f2f-8c26b3239d2a	2024JULB00244	harshita.chauhan2426@jagsom.edu.in	$2a$12$TBPLk3e2.X0mR9u1H4tHU..rLUkrluzH3tL8i75G9pyk117rq7DNG	student	active	\N	2025-10-07 15:33:15.09297	2025-10-07 15:33:15.09297	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
0b46d768-e9c4-4cf1-b28d-d34a253ba705	2024JULB00245	harshvardhan.patidar2426@jagsom.edu.in	$2a$12$ZGswe.CHcab.yqTtgMdSpeZeyuXgVmFnJoJK2jihbiY3BjdnUVvke	student	active	\N	2025-10-07 15:33:15.539782	2025-10-07 15:33:15.539782	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
20bf46d4-144e-4f2f-a75a-22e5b7ead270	2024JULB00246	badhul.pillai2426@jagsom.edu.in	$2a$12$heo7JOftoz.Sfq5yBRsS2OSoxpmA7hPsM/fua2OpJj20p8JEiWS9e	student	active	\N	2025-10-07 15:33:16.010086	2025-10-07 15:33:16.010086	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
95a70a2e-de56-4782-b2fb-612f1007ab64	2024JULB00247	mdarsalan.siddiqui2426@jagsom.edu.in	$2a$12$KjS6z0dhWKYBYICPyVO8x.bKDikMj8az0Md9WNmkOpyMymqR6ybK6	student	active	\N	2025-10-07 15:33:16.47588	2025-10-07 15:33:16.47588	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
b87d36dc-90f0-4830-a09a-72a811126f4c	2024JULB00248	shivam.kumar2426@jagsom.edu.in	$2a$12$w/Ncjk.xgra0Pxv7WqoI8OVQzFSrxcRJ3Przttrcey.ETgKHEsr5C	student	active	\N	2025-10-07 15:33:16.912458	2025-10-07 15:33:16.912458	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
0453c548-d1a7-490f-b1bf-ba5b776457e7	2024JULB00083	kunal.khurana2426@jagsom.edu.in	$2a$12$3RoXWL4xocH5ADxmBIRZj.n4lEikCEK..M6zKBuRkrVT9Bd36GS2m	student	active	\N	2025-10-07 15:32:11.153432	2025-10-07 15:32:11.153432	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
09e54632-9da5-4111-9db5-65d77f99a437	2024JULB00084	kushal.badalia2426@jagsom.edu.in	$2a$12$lW05UM2re6KijXb28qz0BuZTGphY7pnVUduFjrSYK1jLgi02mlCje	student	active	\N	2025-10-07 15:32:11.622779	2025-10-07 15:32:11.622779	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
90e19e00-671d-4929-a673-2b8d2ef47316	2024JULB00085	kushal.srivastav2426@jagsom.edu.in	$2a$12$q3Vlz6TpnXSpGemuHwvPWuHQ3jRNeVjX2VTI0WrpT79mV537H3KPG	student	active	\N	2025-10-07 15:32:12.068898	2025-10-07 15:32:12.068898	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
cf914e7b-366e-4ae0-a3fc-32eed99bdbaf	2024JULB00086	lakshita.chandak2426@jagsom.edu.in	$2a$12$y0BGTOe3.B/kBECxBAW58u7XsJ0041Pw/I2HRWX8bWU5b..KhANIm	student	active	\N	2025-10-07 15:32:12.504882	2025-10-07 15:32:12.504882	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
752067a0-781c-4749-97a2-29e4d7a619e5	2024JULB00087	laxmi.poorvaja2426@jagsom.edu.in	$2a$12$aA9VeVjVvTvIXqP0dmLs0eQeN3NSFEnvkwhDlYVt13XINYbru76ry	student	active	\N	2025-10-07 15:32:12.990594	2025-10-07 15:32:12.990594	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
9dc763d5-dfe2-49d4-a34a-52be9f49c4c2	2024JULB00088	leena.d2426@jagsom.edu.in	$2a$12$ZLQImKZQQ29j7AqDdzyqIubxLA9gaFpnrufyMX.dVc3uyV08vjgui	student	active	\N	2025-10-07 15:32:13.434488	2025-10-07 15:32:13.434488	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
7e491216-4587-439c-8f47-4a4e715f5f99	2024JULB00090	m.maureenmandy2426@jagsom.edu.in	$2a$12$MVBv96aoxoWGqbj2Rwndy.H4Baj24TQEAJKWhAlX9VVVt0r2xp1Jq	student	active	\N	2025-10-07 15:32:13.900168	2025-10-07 15:32:13.900168	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
adfa87fd-35e9-4e0a-a3e2-c3be8e73d136	2024JULB00091	madhav.sharma2426@jagsom.edu.in	$2a$12$d//G7kMYXgjuYsqDGW4ciOsUAhrukSxzsxz80mvMWAge3rhMusvPS	student	active	\N	2025-10-07 15:32:14.330089	2025-10-07 15:32:14.330089	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
c3d561a5-e5d1-4fa1-94af-65dd9e7e2810	2024JULB00093	manikireddy.akhil2426@jagsom.edu.in	$2a$12$Sqa92zkJYwnKBLg87TW/QuzGuydx4lV1XAywW1abcXoWp3LFxfiwm	student	active	\N	2025-10-07 15:32:14.75668	2025-10-07 15:32:14.75668	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
e153546e-eaeb-47cb-9e29-39ebc4053f8f	2024JULB00094	megha.prajapati2426@jagsom.edu.in	$2a$12$5UTf3P8UKzkU71PD5C3RxOGJdsMCnmjyxsN.AvvuCGf3SQ.2vtURK	student	active	\N	2025-10-07 15:32:15.222724	2025-10-07 15:32:15.222724	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
774ddc2d-26bd-4f64-8abc-ab92dcb8fdb2	2024JULB00095	melvin.rochea2426@jagsom.edu.in	$2a$12$q0rW/060dH64skBdyqWr/.cq8tkMvrSMpzga6izZHOYtiBLOK.Q3q	student	active	\N	2025-10-07 15:32:15.657088	2025-10-07 15:32:15.657088	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
150c0140-6fa1-49a9-b2a2-3e09ec38cd59	2024JULB00096	milan.krishnane2426@jagsom.edu.in	$2a$12$eF/U5Juwv2NaMUZGgpC2DeItmfWu1K0MuKLEzTppZhyfObjVZd5i.	student	active	\N	2025-10-07 15:32:16.093726	2025-10-07 15:32:16.093726	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
d3c9049a-a11f-4eea-aac2-21b9c5901d53	2024JULB00098	naitik.roy2426@jagsom.edu.in	$2a$12$y2BwaYa69TmIFltkxOU6Ouzp0jZRwanCHW3rOK3LkZ0k.xrFEvVDm	student	active	\N	2025-10-07 15:32:16.727609	2025-10-07 15:32:16.727609	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
b9f5d9ec-5e40-42c9-8b4b-8e4343abe193	2024JULB00099	nandan.gbhat2426@jagsom.edu.in	$2a$12$s9dYexBcauFSQON4VCAALe77SfJhoLaNuCWQCErfAwu6EQJL77VcC	student	active	\N	2025-10-07 15:32:17.213715	2025-10-07 15:32:17.213715	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
0088f18a-2a84-463d-bf21-482c2e82f3e5	2024JULB00100	nihal.poojary2426@jagsom.edu.in	$2a$12$zD9ZfDXmlotFbH5GxnIZyOl0t3jQC7mVktkr1WISzOMMY1b0AUuIC	student	active	\N	2025-10-07 15:32:17.652848	2025-10-07 15:32:17.652848	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
1dc86461-a388-4ed9-ab23-bb9fd97fa41b	2024JULB00101	nimisha.baruah2426@jagsom.edu.in	$2a$12$.fJtLMUx3qEVC6Ev9rqa1.igMl1n/wCTbk0.eySk7iamFreXmJi.u	student	active	\N	2025-10-07 15:32:18.078527	2025-10-07 15:32:18.078527	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
36f82d92-2d03-43ec-b180-638957598678	2024JULB00102	niranjana.hari2426@jagsom.edu.in	$2a$12$92z3gC8OkWD88TaOMdYJbuGQYl16t3pCwkNtBAgy6ko.pPN8qWtQa	student	active	\N	2025-10-07 15:32:18.532537	2025-10-07 15:32:18.532537	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
cb579129-1be7-4433-8f19-e501b0bbac0f	2024JULB00103	nishant.mishra2426@jagsom.edu.in	$2a$12$iWfP.Y/x9kqZ0u1c1UGTp.FurM7VaM5jTySrshwCq09X0GBnaVSmC	student	active	\N	2025-10-07 15:32:18.978577	2025-10-07 15:32:18.978577	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
f89a7ded-04e8-42c5-aeed-678fada1a54c	2024JULB00104	nitesh.saini2426@jagsom.edu.in	$2a$12$b5QAa3IJyOMBk1Ok3SaaT.RWikdTL5RIAcOIKhI0q3hapmRoJG3dm	student	active	\N	2025-10-07 15:32:19.411089	2025-10-07 15:32:19.411089	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
fc553908-3a12-414a-91d2-9bdb67a33e99	2024JULB00105	nithish.yuvaraj2426@jagsom.edu.in	$2a$12$EHpZxk2EDp7ZOYg0PyH8ie6Qp7ntMjMcQiVKlBojMEMyFw.EAzWZe	student	active	\N	2025-10-07 15:32:19.963097	2025-10-07 15:32:19.963097	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
12a1497d-46e9-4342-a64d-1629a0462e06	2024JULB00106	o.ksrivyshnu2426@jagsom.edu.in	$2a$12$YUm8w6D7Ymryu.dLIuuqFuYx4BBc6eUyJaLecxO1WgLAaKnRCWixK	student	active	\N	2025-10-07 15:32:20.446483	2025-10-07 15:32:20.446483	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
9eb69be9-3172-4687-bded-edcc4e9c2ba7	2024JULB00107	pavitra.v2426@jagsom.edu.in	$2a$12$gv8F9pF3rwTL8Hw.914fSeVeJOEkQ2rDxt6z41YuGQlPlw1Oq4HT.	student	active	\N	2025-10-07 15:32:20.905954	2025-10-07 15:32:20.905954	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
7fed9ed2-d7e9-4809-8b11-649693286912	2024JULB00108	pooja.s2426@jagsom.edu.in	$2a$12$mqn/T53sy0QhLBVfFFIMxeaiig64RLhuWsozfn9SOam102pkwZN7m	student	active	\N	2025-10-07 15:32:21.374435	2025-10-07 15:32:21.374435	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
ad490f01-345d-4859-a96d-5b1684c7cc59	2024JULB00109	poulami.sarkar2426@jagsom.edu.in	$2a$12$keBfIvrU6ffCIk9slCAUMulgHpXG4/APahEbLSMOq8VxEkr9RXfRK	student	active	\N	2025-10-07 15:32:21.829315	2025-10-07 15:32:21.829315	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
80511346-af37-4aae-951b-d389c3a883a4	2024JULB00113	prajwal.kulkarni2426@jagsom.edu.in	$2a$12$g5mcPcIMzUcsnGuy/ymIpeppOotWmHHekNGU40uAbbnNBqbuZVbI6	student	active	\N	2025-10-07 15:32:22.719026	2025-10-07 15:32:22.719026	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
b20179b4-f51a-4a4a-9910-6c741e228b51	2024JULB00114	prince.kumar2426@jagsom.edu.in	$2a$12$s4rlJRYu0cRoWNcLzJ0TQ.YAUyZd7ZJ1xSpGb/1F448x3BdTuChi2	student	active	\N	2025-10-07 15:32:23.159584	2025-10-07 15:32:23.159584	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
cc689d59-eade-41c7-beda-b7b82b188447	2024JULB00115	pujarchana.nayak2426@jagsom.edu.in	$2a$12$jle0GFDnt1EA61J9lfSKXO/pgKjgWxcOgwEfgeXtL4XYh1aicjD.2	student	active	\N	2025-10-07 15:32:23.601457	2025-10-07 15:32:23.601457	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
a6d14ea4-10c4-4814-9691-48804581e2a7	2024JULB00116	pushkar.dey2426@jagsom.edu.in	$2a$12$I8rFDPuebT/nY3Rj1SiePOnRVRPnt2iqH.dxmAFDrcoXoaa42pxmy	student	active	\N	2025-10-07 15:32:24.050407	2025-10-07 15:32:24.050407	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
0e124b82-3a9d-44ca-9ece-35d45cb15529	2024JULB00118	rahul.ghosh2426@jagsom.edu.in	$2a$12$41MD3Xs/1Nsbb0cZU8apCecYvq2gsyAOpRdDRtHUaQlusF8ub6.za	student	active	\N	2025-10-07 15:32:24.488981	2025-10-07 15:32:24.488981	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
ca4ac708-db6f-4c57-bd95-d56fdd0c1083	2024JULB00119	rahul.lalPP2426@jagsom.edu.in	$2a$12$Mt4a2upXIHhfXq0n9pZTKuZdHVg/5o9a3xExJ0BnxD3JJ7QuixiZK	student	active	\N	2025-10-07 15:32:24.929874	2025-10-07 15:32:24.929874	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
2dc1f8df-6f60-49ee-965e-7b180cf0a13f	2024JULB00120	ramya.h2426@jagsom.edu.in	$2a$12$rHznMAGlEW6vp.3LbK.nZOFh5subWB36Y/U7A1UUpJwtlhxBz3GKi	student	active	\N	2025-10-07 15:32:25.408195	2025-10-07 15:32:25.408195	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
590c4f28-955b-404c-b992-519d58028959	2024JULB00121	renukha.saravana2426@jagsom.edu.in	$2a$12$Dr7pjBlv2el94FxpWD1rXukbuCwbdLXPIZMFM.eX98wzyb86/wl8a	student	active	\N	2025-10-07 15:32:25.88632	2025-10-07 15:32:25.88632	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
b13fa742-e868-4bf6-86a1-7c8b6ee1c282	2024JULB00122	riddhiman.saha2426@jagsom.edu.in	$2a$12$L99Ht7wv00g95EPXg1D6Be3L79dY6Hl7db.tInbYiEmXWdQF12vAy	student	active	\N	2025-10-07 15:32:26.335687	2025-10-07 15:32:26.335687	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
f6d26982-b0e5-426a-9ea6-1445faeb4f40	2024JULB00123	rishik.chandra2426@jagsom.edu.in	$2a$12$0Yh6hE49DqATFviU1TkFVuefEeskF3DaOD6vz9AaiTyy0SCZfSXf2	student	active	\N	2025-10-07 15:32:26.777805	2025-10-07 15:32:26.777805	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
f656a326-7ef5-42ec-8e71-ee20d819833e	2024JULB00124	ritaban.roy2426@jagsom.edu.in	$2a$12$bdvN/muJzKOZ8yUeURNwFuRurdDjMyLCFLwkUBzNpI5c3VYlphB8q	student	active	\N	2025-10-07 15:32:27.204608	2025-10-07 15:32:27.204608	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
21488d6a-33cb-4801-8570-af1b5affab01	2024JULB00125	riya.guliya2426@jagsom.edu.in	$2a$12$v6qTATZSSI2JCCtOSAfNL.epJeyMLNqe6u4B.iDPu/DwQo3RUyd/m	student	active	\N	2025-10-07 15:32:27.646719	2025-10-07 15:32:27.646719	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
0e5c10ff-d034-4294-bcde-a5ce0e871b69	2024JULB00126	riya.rose2426@jagsom.edu.in	$2a$12$ZMh24.RdEOmC7Uszzo9VYuO.ffsv2L/DEol7kHwbOZbX5JMaBa09G	student	active	\N	2025-10-07 15:32:28.079572	2025-10-07 15:32:28.079572	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
cfc1a96e-acd0-4d0f-9e8c-33458f0cad43	2024JULB00129	s.prithviraj2426@jagsom.edu.in	$2a$12$jhiMOaO1WLa6c/1sZtgxMua/BqTRabNuhC3IcbYw1LewNzV5KXWhu	student	active	\N	2025-10-07 15:32:28.537641	2025-10-07 15:32:28.537641	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
22fdf669-a8dc-4c8c-b2b6-dde7043fbfc8	2024JULB00130	sadya.anwar2426@jagsom.edu.in	$2a$12$vtHGYCIkCAyug7IifBBa5ON8Uyo6U673wG7nSngETqt2SWNXWM1z2	student	active	\N	2025-10-07 15:32:28.974896	2025-10-07 15:32:28.974896	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
1a6e9906-5304-4b07-88e9-110df0ae8960	2024JULB00131	sai.krishna2426@jagsom.edu.in	$2a$12$ghrbt318wawYgW1D3k3zvermf3FYSHepSL/OIk.4k2bEny2XEN49y	student	active	\N	2025-10-07 15:32:29.487642	2025-10-07 15:32:29.487642	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
6e646c52-a22c-4a57-977d-6f0b051c5b03	2024JULB00132	sakchi.suryavanshi2426@jagsom.edu.in	$2a$12$cLSQdGfN78mtH1/dRoIvduBIdFmOoF9x75/Sc1PYFAH02ciuls0l6	student	active	\N	2025-10-07 15:32:29.921037	2025-10-07 15:32:29.921037	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
9dae8728-0b07-4240-bb80-ac1b07a85046	2024JULB00133	sandeep.shankar2426@jagsom.edu.in	$2a$12$GZWkcunbTuse29doTNCJ4OfvWYkw71wI8H6JKZ0k2gMl63KCQJYy.	student	active	\N	2025-10-07 15:32:30.370839	2025-10-07 15:32:30.370839	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
4223d3b2-70f6-4b86-83d4-bfb842340ed0	2024JULB00134	sanjay.baliga2426@jagsom.edu.in	$2a$12$Wdxrp4WHkhJOrwzRMiz8hOLDamnHZFWMcwCzAGF.mKtbHAGn59rUu	student	active	\N	2025-10-07 15:32:31.1781	2025-10-07 15:32:31.1781	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
6a04d1dc-6b69-4939-a012-615ca753ea3b	2024JULB00135	saqib.attar2426@jagsom.edu.in	$2a$12$gUkcwqMWR41bfJzXlHASJeUI5EoJPIf/yCSygBhHnT/wBlAVCuHlq	student	active	\N	2025-10-07 15:32:31.62222	2025-10-07 15:32:31.62222	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
1e2d432f-b55f-437c-b8b0-dfbca8b12b57	2024JULB00137	saurav.kumar2426@jagsom.edu.in	$2a$12$lNSjz.b42qwsshq7nhUDJOqnpLxqg7zcXMOsDwh1daWluD83muF2q	student	active	\N	2025-10-07 15:32:32.115707	2025-10-07 15:32:32.115707	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
ed15e599-ae2b-47fe-9202-d844baa00c5b	2024JULB00138	shankar.vyas2426@jagsom.edu.in	$2a$12$6AfB0EpLIHFr4VCBriempOuLDnGXfjulSApPIJbflK4WnObVtL.mq	student	active	\N	2025-10-07 15:32:32.579784	2025-10-07 15:32:32.579784	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
40d23087-4ffc-49e9-b163-7e38bca53b04	2024JULB00139	shaswat.mishra2426@jagsom.edu.in	$2a$12$oehcBBV4xSXG2cVrqkET6uCGb/H8xIGwnlzphdLlJzEi1NBDxaHre	student	active	\N	2025-10-07 15:32:33.048764	2025-10-07 15:32:33.048764	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
1bc3935a-dbb3-4de2-a11d-42344ae91bc0	2024JULB00140	shatabarta.chanda2426@jagsom.edu.in	$2a$12$WniUXBYNb/zMf3QbVoUhieVBAk/QK24psYlIWGzgivwNUc349Al6m	student	active	\N	2025-10-07 15:32:33.505613	2025-10-07 15:32:33.505613	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
2f26b626-a64f-4877-bb6c-9feea75a7759	2024JULB00142	shivang.mishra2426@jagsom.edu.in	$2a$12$U.pFnqwdXB8JP.512psgyeSsoruTgLd6AQju08hf2tA2bbsWEOp8O	student	active	\N	2025-10-07 15:32:33.970858	2025-10-07 15:32:33.970858	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
bef344fc-174f-44d8-a747-4e6f34318c84	2024JULB00145	shruti.rajale2426@jagsom.edu.in	$2a$12$xDoJ1YQc2sC7718YN0u4beLj9YZmmu22UsmDwiJRRPLiSscueoGMK	student	active	\N	2025-10-07 15:32:34.896937	2025-10-07 15:32:34.896937	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
5bbe127d-8bf6-427a-9ce9-3759a077060d	2024JULB00146	shruti.sharma2426@jagsom.edu.in	$2a$12$gPzMfMq7dAhVAcJ2TnX/I.k1iIJF.u19wevYdXWOEhA7om1i2gtRy	student	active	\N	2025-10-07 15:32:35.359546	2025-10-07 15:32:35.359546	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
73fa7a89-cdcd-4481-8233-ddc7c604f44b	2024JULB00147	shruti.vbuchasia2426@jagsom.edu.in	$2a$12$RAB7L516VMlQklK/GkHgkODg8PDnOfPjFyP4lGHMs0p1vAFf2a6s2	student	active	\N	2025-10-07 15:32:35.805846	2025-10-07 15:32:35.805846	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
c058c824-04e9-4b9f-872b-dc653eaa46a0	2024JULB00148	shubham.goel2426@jagsom.edu.in	$2a$12$VNPA6SVq/FtuRHxBGumqieAokPKEGZJTcFmtTCy9Y/WWXsgcaLdqG	student	active	\N	2025-10-07 15:32:36.276557	2025-10-07 15:32:36.276557	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
783891d3-b011-44af-9045-423f259e46e3	2024JULB00149	shubham.kumar2426@jagsom.edu.in	$2a$12$a.mZ6C0PXZUS/EQQSEyCiujhNmYcP6VGnAOZriokbxNmo2w7Sroli	student	active	\N	2025-10-07 15:32:36.733387	2025-10-07 15:32:36.733387	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
d573a2c6-ee9a-4708-ba13-4922563840b8	2024JULB00150	siddharth.singh2426@jagsom.edu.in	$2a$12$X5uNJQNxqnXoqUfcvZ84fuhdEWbYAZB3HZ3FcLjS25fIVWwTvZtD6	student	active	\N	2025-10-07 15:32:37.21493	2025-10-07 15:32:37.21493	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
b1472edc-df07-4c0d-b08b-816e88c74ea5	2024JULB00151	sivaraman.s2426@jagsom.edu.in	$2a$12$VT/k59W70J7lqcY5F0a/e.RSPXAqWJQucRJWYWdlbLsfGffXV7rR2	student	active	\N	2025-10-07 15:32:37.679068	2025-10-07 15:32:37.679068	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
21748dfe-00f1-431e-a421-9b54a0afc4d0	2024JULB00152	snehith.samala2426@jagsom.edu.in	$2a$12$od6sfJAqnfMwVNJ0ADiZwuRuDDewufXKmliTlYYoJ07fm5hATbnya	student	active	\N	2025-10-07 15:32:38.146499	2025-10-07 15:32:38.146499	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
035f4710-44a9-4bc2-9a30-ba6007fc10f6	2024JULB00153	sofia.dorodrigues2426@jagsom.edu.in	$2a$12$8o7nXDPD8M0KkH1Piar6DeQ2tWHEIYnx53yVWAyft89uCfbSO4T3q	student	active	\N	2025-10-07 15:32:38.612492	2025-10-07 15:32:38.612492	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
923a69d2-0ddf-4699-aeee-52a21fd59d31	2024JULB00154	somya.sahoo2426@jagsom.edu.in	$2a$12$Lpj81yJtC8gmHmzuUJzNte1jb3k6UKiSljMyH7kUcgkrjkQKh6o3.	student	active	\N	2025-10-07 15:32:39.250218	2025-10-07 15:32:39.250218	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
6be47e5b-2abd-41a9-98af-52a4bc0855c2	2024JULB00155	sonali.agarwal2426@jagsom.edu.in	$2a$12$R/kUFAQGl/.ARtfIJqQGjO.7Nr05OHjQZRt/..LgXWoEURu09Sp3O	student	active	\N	2025-10-07 15:32:39.713312	2025-10-07 15:32:39.713312	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
a14a458f-4b5e-492b-93fe-fb5cb46914be	2024JULB00156	souvik.roy2426@jagsom.edu.in	$2a$12$iFhV7Pf/S5GrS6uFHvhCo.1LOs31bcfuUciKXjYVjsMlXJKckNJLy	student	active	\N	2025-10-07 15:32:40.188423	2025-10-07 15:32:40.188423	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
0d7fd5f6-6d4e-4340-b2a0-c37c94f065e8	2024JULB00157	spandana.chandragiri2426@jagsom.edu.in	$2a$12$bRCpZp0qdpcuXYbqX/.WaepfbaWNLp2mAZ8DoEaz6PbxF8P0QQkv2	student	active	\N	2025-10-07 15:32:40.654813	2025-10-07 15:32:40.654813	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
7af1c4c8-cafa-407d-acef-9ffff9e67e4e	2024JULB00158	sree.nithish2426@jagsom.edu.in	$2a$12$2jadpOf6xgE4jHKpg82uoOOoncD.l5Fw8LcPA4XADna0OkOuNVYlu	student	active	\N	2025-10-07 15:32:41.154733	2025-10-07 15:32:41.154733	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
7ff8b936-3903-47aa-bcab-caff6c5d68bf	2024JULB00159	sreya.sivadas2426@jagsom.edu.in	$2a$12$/B.twIIdwn6N.5xXxz1oruv3//MIQti5ExjHffrp44QvzEcH1B/NC	student	active	\N	2025-10-07 15:32:41.590995	2025-10-07 15:32:41.590995	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
5f74b6cc-b7a8-439e-8413-de35a1bf864a	2024JULB00160	srishti.shivaram2426@jagsom.edu.in	$2a$12$ZYrempvEja25AHZE7IQ9vefr4i7pz5RajGFBVtuqMqQnGHLOOJSOe	student	active	\N	2025-10-07 15:32:42.056447	2025-10-07 15:32:42.056447	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
0044f22f-0172-43b5-a61d-75ee5f05193f	2024JULB00161	subham.sahana2426@jagsom.edu.in	$2a$12$Czci6E1fPgT1YndmkL9gXuYq062GP7nfYgdMViepCb4X8Ql8Q/caS	student	active	\N	2025-10-07 15:32:42.546431	2025-10-07 15:32:42.546431	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
b3d747ea-7711-459e-a904-d852c2713f97	2024JULB00162	subhrojit.ghosh2426@jagsom.edu.in	$2a$12$Kaw2tO74vDSo2FzQeMvkSONiiacLhH9Jqs9lXWToS/rtTvnR9Hl9S	student	active	\N	2025-10-07 15:32:42.996533	2025-10-07 15:32:42.996533	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
d2c3f0b1-0423-4a17-933e-0ada0e7ee5c1	2024JULB00163	sudharsan.b2426@jagsom.edu.in	$2a$12$uaJo68MWw33DMO1mB5vgJ.S2/Vbx5l/vVtVD69XTXf5Lf2DLwVjeW	student	active	\N	2025-10-07 15:32:43.459085	2025-10-07 15:32:43.459085	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
a6e6ef49-054d-4267-8da6-5b4b593823c5	2024JULB00165	shristi.prakash2426@jagsom.edu.in	$2a$12$owlpFOcYvCodusld.3gA.eAht6GeifuoLNldJu.CO5dp1E7P6eH7S	student	active	\N	2025-10-07 15:32:43.882945	2025-10-07 15:32:43.882945	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
69902061-f36e-4ab9-8a9f-93819034e394	2024JULB00167	sukhman.sandhu2426@jagsom.edu.in	$2a$12$g8QJwGIwCtFv/O1v2WVM1ukpR00uYviG9WinJ8XrDpDon31yexBU6	student	active	\N	2025-10-07 15:32:44.347751	2025-10-07 15:32:44.347751	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
0a8fecbe-b47f-4683-8df9-f2a53276b0da	2024JULB00169	sofia.mehazabeen2426@jagsom.edu.in	$2a$12$sCYBbTL/Ku7/ZoTFd2TSfebGvXW2R4Z4x5PoZf6bQ568X/dZmJK5i	student	active	\N	2025-10-07 15:32:44.820409	2025-10-07 15:32:44.820409	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
41e7ebb3-386c-4848-a7ac-ca54fcbdb8a0	2024JULB00171	thribhuvan.gowda2426@jagsom.edu.in	$2a$12$Grr.zDv/aNnAhqSsnOsqOeUn2FlvfKH2XLOORvByapNvzb/UE513y	student	active	\N	2025-10-07 15:32:45.267379	2025-10-07 15:32:45.267379	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
e65a299d-2369-4766-b057-d490aab6e0b7	2024JULB00172	trinanjan.purkait2426@jagsom.edu.in	$2a$12$9GrUlhl/iXe.pEJ8B39jXeHyqk2vkts121CV1Lg3emohZiH/67AmO	student	active	\N	2025-10-07 15:32:45.751367	2025-10-07 15:32:45.751367	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
573098b4-e544-43bc-8f90-5c0faefd4c32	2024JULB00173	tushar.panda2426@jagsom.edu.in	$2a$12$xpJnWvnBvHAcyflkPoSIROklzhRfx/cey0JcyUeRg5XX7E3oLkjCS	student	active	\N	2025-10-07 15:32:46.197824	2025-10-07 15:32:46.197824	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
6124db13-5919-4cb0-8662-869cdab7b95c	2024JULB00174	urvi.verma2426@jagsom.edu.in	$2a$12$bEXtvPofDTLwf8hNjQqdauqQmL1/P34rKLQZifFTvxsnGexb2WO22	student	active	\N	2025-10-07 15:32:46.65422	2025-10-07 15:32:46.65422	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
d52fcf7a-d57d-498d-a44b-8df7216e6c47	2024JULB00175	vaibhav.laldas2426@jagsom.edu.in	$2a$12$bPg6nHo9y5dZVde./M9mfeGlCnp208BPT.Tiim8aHnnaj9Rpl1TKW	student	active	\N	2025-10-07 15:32:47.110576	2025-10-07 15:32:47.110576	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
7d876a38-3476-4153-a6e0-4a5dd2826e1b	2024JULB00176	vaibhav.pandey2426@jagsom.edu.in	$2a$12$Yc3APbazk2PjHV46/zomeeF18Hee7mW58StwwdYfvZLHXOnyOM7jC	student	active	\N	2025-10-07 15:32:47.561162	2025-10-07 15:32:47.561162	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
865e98e7-b26a-42a3-8982-9ee4c949bdef	2024JULB00177	vanshika.bihani2426@jagsom.edu.in	$2a$12$0BWWexizK2n.1eOJuurSuuvLF/ZWZ5HLQRUlJ.Sk4mfBdgcS3PhGK	student	active	\N	2025-10-07 15:32:48.002856	2025-10-07 15:32:48.002856	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
a4973aec-7609-427a-900c-ede61a6f57ce	2024JULB00178	varsha.saji2426@jagsom.edu.in	$2a$12$6ide.ybDQPhEWFeWt0TRi.qUHGDq0ShLe6MbM/pl6kZ.tVCPrd3Lm	student	active	\N	2025-10-07 15:32:48.461341	2025-10-07 15:32:48.461341	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
d5594707-cb48-4489-931d-7c442844dc0d	2024JULB00179	veeraj.poojari2426@jagsom.edu.in	$2a$12$iNIdtyrP3E4FfH4eHkpGFOsm3vImVVj03WSvKAGwa7L8awlFG8gcG	student	active	\N	2025-10-07 15:32:48.897432	2025-10-07 15:32:48.897432	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
51325351-ce85-4c4a-af9f-ebe5cd93b35c	2024JULB00181	vishal.bhagat2426@jagsom.edu.in	$2a$12$Hx6i346A9KAB8LmHmlwejOwyi/fU04m92tByPaAut1g.adKWUMpiO	student	active	\N	2025-10-07 15:32:49.338881	2025-10-07 15:32:49.338881	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
0a402436-ecee-44d7-b67c-b31160ceada9	2024JULB00182	weslinraj2426@jagsom.edu.in	$2a$12$KmOvosXDiqxaI8YGMS1mC.IoflA.ZstPHbWc0RXLy6Q.5NDz46OEa	student	active	\N	2025-10-07 15:32:49.79717	2025-10-07 15:32:49.79717	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
bc45942e-66cc-4c4d-b678-6e10291b8433	2024JULB00183	yasaswini.sagili2426@jagsom.edu.in	$2a$12$rhx01k66zctNK4bVc39qSOL6i5ds/mV24gTuwmrdZdo37wQFye4Ie	student	active	\N	2025-10-07 15:32:50.278564	2025-10-07 15:32:50.278564	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
2def447a-9390-44bd-b35c-4c19e7f7424a	2024JULB00184	yash.sen2426@jagsom.edu.in	$2a$12$uViJNSw.bPFei4VWHBToc.WUMiSG7x5PLAMQLOydDL/Z9VhU80RHa	student	active	\N	2025-10-07 15:32:50.741107	2025-10-07 15:32:50.741107	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
37118fa0-8c5c-442b-92b2-fce84afbc054	2024JULB00185	souvik.biswas2426@jagsom.edu.in	$2a$12$/7IMDaZcvISVrpjPMktZy.MSn1ksf/DsxtfOsp9x6hbrmy.E5jetC	student	active	\N	2025-10-07 15:32:51.182168	2025-10-07 15:32:51.182168	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
fe8a01d9-aac4-4b50-a63e-42a96e8e19fa	2024JULB00186	pasumurty.vineeth2426@jagsom.edu.in	$2a$12$MzkB1fSvD44wYw7/L0nzge2LXf.7.9CI2ErIsOG1.Lz5/gTxom8iG	student	active	\N	2025-10-07 15:32:51.636226	2025-10-07 15:32:51.636226	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
0ce1cde6-4187-4f56-a01e-172aba2b2e10	2024JULB00187	sejal.negi2426@jagsom.edu.in	$2a$12$8dtn00rH/twn79jK2wCg1ui7.34kYPMCE5qEMkqx48fvklnhrHGVW	student	active	\N	2025-10-07 15:32:52.095501	2025-10-07 15:32:52.095501	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
71ddb60a-a81e-4fa4-82e9-9c002c5aab64	2024JULB00188	jigyasa.singh2426@jagsom.edu.in	$2a$12$Isyzc0B47TCSCh0rLvAwVueqiKO5vuI72FoLEZ4wv8su3c2SkOIxa	student	active	\N	2025-10-07 15:32:52.531657	2025-10-07 15:32:52.531657	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
5f62ba12-fae5-4734-806d-af2153334cb1	2024JULB00189	rahul.mallick2426@jagsom.edu.in	$2a$12$qPEJuYIyM51zfeg.gTN3iu40dq2DJN7UXkHcAtkg1FXCqnbwUwxDC	student	active	\N	2025-10-07 15:32:52.982094	2025-10-07 15:32:52.982094	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
a572535d-16f5-48bf-8371-5270bf99b498	2024JULB00190	himanshu.mall2426@jagsom.edu.in	$2a$12$G2I5XbvgIF02DfhscW2wZOP75yzvM7FJJOxfKgHvdDxYPMyFPhglu	student	active	\N	2025-10-07 15:32:53.471074	2025-10-07 15:32:53.471074	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
5b596636-652a-4f8b-a4da-bf3d63a7ba90	2024JULB00191	jayant.pal2426@jagsom.edu.in	$2a$12$csCHz11mAm/SWDcfdpghAOqSc2cx/PjGji9kjbuZVUadtr6v6wTrW	student	active	\N	2025-10-07 15:32:53.942033	2025-10-07 15:32:53.942033	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
8e564b12-2300-49f7-8711-ffc90f387b8b	2024JULB00194	aditya.ranawat2426@jagsom.edu.in	$2a$12$omYCv.5OgY6z77daNjzkseRxCl.dyf8Ot/qxvfn89pp9hIhTe9XvG	student	active	\N	2025-10-07 15:32:54.393442	2025-10-07 15:32:54.393442	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
9cc852f9-8266-4abc-a48e-23c611239f59	2024JULB00195	nikhitha.pottangi2426@jagsom.edu.in	$2a$12$A/DE/TGxuRiVadyo4qRsKe1O6YhDXJHUHUIEy/Xl9thuXqsJUPJrm	student	active	\N	2025-10-07 15:32:54.857805	2025-10-07 15:32:54.857805	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
d5c737aa-1339-458d-9370-c2734d53d92c	2024JULB00196	piyush.kumar2426@jagsom.edu.in	$2a$12$3.2suA7DMxMrD5CgCD/CP.Fb1MsWHEp/iBY2Ubp2L2xb8/S.qArgK	student	active	\N	2025-10-07 15:32:55.315095	2025-10-07 15:32:55.315095	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
48c6f1f5-3eec-4e73-bce0-105f133d015c	2024JULB00197	deewanshu.ukey2426@jagsom.edu.in	$2a$12$8vle2b2Wk.iPWTpZHzEVzOZs7aok3oR3wadT097FiSBLCFs3pDNWW	student	active	\N	2025-10-07 15:32:55.777111	2025-10-07 15:32:55.777111	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
866b2226-e0e0-4961-8603-a82912861136	2024JULB00198	suvam.basak2426@jagsom.edu.in	$2a$12$Ibyb/7xcMd/9T5dIyBn/9uCq56haIzjYbw33.52uzPbW8uvm2BnJa	student	active	\N	2025-10-07 15:32:56.244928	2025-10-07 15:32:56.244928	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
0c40350f-0723-416f-aca2-2c098be15584	2024JULB00200	meghana.satuluri2426@jagsom.edu.in	$2a$12$IXZlUJ0BiFubHnp806JTAeRWZNTYSXsRGjf4J43uzSU/LdZPwWRki	student	active	\N	2025-10-07 15:32:56.707171	2025-10-07 15:32:56.707171	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
84107796-39b7-42de-9e0c-562a1898485d	2024JULB00201	varun.thampi2426@jagsom.edu.in	$2a$12$NggQJUzFoTM.jclQsxEdJOp0bbiuxL5H4bg8e99lGh29dwZETqgcO	student	active	\N	2025-10-07 15:32:57.161372	2025-10-07 15:32:57.161372	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
e35567fe-921c-47da-9cf4-270152570dec	2024JULB00202	arnav.rastogi2426@jagsom.edu.in	$2a$12$uydewv3g5QPH.MGpY/gtue7VoVJQTo94Tejb/4StjNM.kdXJceHRq	student	active	\N	2025-10-07 15:32:57.629524	2025-10-07 15:32:57.629524	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
07f75d86-bc93-44a8-a2b0-7e3e0b3f5096	2024JULB00205	archa.slal2426@jagsom.edu.in	$2a$12$fm8qBcj6oSSMTeW2qfzyTuLDpuMjA8W8vPh9FjvmONpJ3sTEpizC.	student	active	\N	2025-10-07 15:32:58.560491	2025-10-07 15:32:58.560491	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
6138c7d3-6c6d-40cc-a598-1c16a055fe41	2024JULB00206	arpit.katiyar2426@jagsom.edu.in	$2a$12$UJhIrQ3r/0ZORKCHeAsgvuFfbIAJLs4K4EhruSSMKj/HpIdMzdzn.	student	active	\N	2025-10-07 15:32:59.009432	2025-10-07 15:32:59.009432	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
38c8f848-9c79-43b3-859a-12043ae81aa2	2024JULB00207	ayushi.mohanty2426@jagsom.edu.in	$2a$12$p6Oo2.JVQdhDm4INmE.kw.7yIDv0YpmBu0MPs2Ydagc5M.Aol4u7W	student	active	\N	2025-10-07 15:32:59.46218	2025-10-07 15:32:59.46218	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
e25a4452-e454-4164-821b-70d57a3b2f14	2024JULB00208	garima.sarraf2426@jagsom.edu.in	$2a$12$kKuSJCkVzzBwUH6f5B.r/OooaPudXZAuqNpL.bizchjvbacvdEFkS	student	active	\N	2025-10-07 15:32:59.917393	2025-10-07 15:32:59.917393	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
3a5b8f74-3fa6-400b-a996-0476f2fb6fcf	2024JULB00209	isha.gera2426@jagsom.edu.in	$2a$12$cMf2bDy/pZ/g/QVDgadtQ.yUQps2vLHHP2h5lxvyvI7gDjRpZ0.QC	student	active	\N	2025-10-07 15:33:00.415886	2025-10-07 15:33:00.415886	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
6f201145-f11c-4271-a217-a082e5bd4ddf	2024JULB00210	nikita.soni2426@jagsom.edu.in	$2a$12$moBvnJZaAAteI9A4t0bzHefnTgvmQeLRNNwwKUOFpZvIF1n9c8Oxi	student	active	\N	2025-10-07 15:33:00.920078	2025-10-07 15:33:00.920078	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
c2bb57e6-65e3-44c8-9bd8-72486b2df00a	2024JULB00211	purnita.gupta2426@jagsom.edu.in	$2a$12$2OMnXUHy61Zbd75b14LLw.mpH2ZU2dIJ5LHgOggaXexIlPOPoGTT2	student	active	\N	2025-10-07 15:33:01.649347	2025-10-07 15:33:01.649347	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
e1059ab3-c048-4bca-af7a-cc5a7295aef5	2024JULB00212	rajnish.kumar2426@jagsom.edu.in	$2a$12$RD6Npfv1bl9a24RfUKBDKOjUz7YUAuZuv0C8/CHqqPggfAfq3Ldse	student	active	\N	2025-10-07 15:33:02.38464	2025-10-07 15:33:02.38464	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
d8e85652-634a-4f65-b4d1-6fc930bcf128	2024JULB00213	raju.boya2426@jagsom.edu.in	$2a$12$MqCTAx1ydfcRYm5dkBbRz.huos6Ee1swz1kzheeBpxyS462HjO0na	student	active	\N	2025-10-07 15:33:03.030478	2025-10-07 15:33:03.030478	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
61ff4d5f-b402-4054-872a-e797a25be6fe	2024JULB00215	sanjib.bhagabati2426@jagsom.edu.in	$2a$12$5CcHsGrDjjPpkdaAdm7ZgetDT7ohGc.utmC3SpZVyNXoYh54Z87CC	student	active	\N	2025-10-07 15:33:03.535977	2025-10-07 15:33:03.535977	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
5fe26cc2-7613-4b2b-8e24-9596eea5227e	2024JULB00216	vanshita.bali2426@jagsom.edu.in	$2a$12$b1wKxpRlA5GgU27YsiEpn.LK/nXS3MJ6TDjwJ6jU1C1BxrYKlY/ka	student	active	\N	2025-10-07 15:33:04.098144	2025-10-07 15:33:04.098144	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
9b2b2dc0-ba86-4560-8ea3-542acca7ac18	2024JULB00217	vittika.chavhan2426@jagsom.edu.in	$2a$12$ZI0vFllAsV0Zf8Cj7OOrOuZus7ngKftKO8ORop0MV1s7VLeGj6Uoa	student	active	\N	2025-10-07 15:33:04.553504	2025-10-07 15:33:04.553504	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
265866ea-64dd-4d17-b2d6-d63167ce22c1	2024JULB00218	yash.kataruka2426@jagsom.edu.in	$2a$12$zQH9H.nvvv6BlFhrTllQhOE5zI2lBSxN8NVl9tu7hVhFJAcpdcaPa	student	active	\N	2025-10-07 15:33:04.989575	2025-10-07 15:33:04.989575	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
a559eccf-dad4-4f68-bc64-c2e6ad830e7d	2024JULB00220	rohan.agrawal2426@jagsom.edu.in	$2a$12$4aGbbEO5Sn4KYY2iwqF9GukW9vIqbs1FxvqqVVy3hAIC8gHjIShhu	student	active	\N	2025-10-07 15:33:05.449414	2025-10-07 15:33:05.449414	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
29b81b9d-c183-4994-8635-74a117c85da7	2024JULB00221	dhruban.talukdar2426@jagsom.edu.in	$2a$12$k8QNpgQ0/az4qg.Eqi5k/.MQArcjhvW/FVW10yXBrKaRVL1LNZ55u	student	active	\N	2025-10-07 15:33:05.936493	2025-10-07 15:33:05.936493	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
d0bbe687-4e29-4313-9a81-143439bac669	2024JULB00223	preethish.preethish2426@jagsom.edu.in	$2a$12$C8wVrF9se.s44DAjma4QDeRORaw5WPA0fiO1LW9jTMVLCatR5bidq	student	active	\N	2025-10-07 15:33:06.419961	2025-10-07 15:33:06.419961	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
0a222379-386d-4a35-9950-45facfe3d864	2024JULB00224	aniket.raj2426@jagsom.edu.in	$2a$12$e4gCNBT/IMakw/wh3HkEz.NPRFuloDwj70EsOI3JmBVMNxlgs4QIq	student	active	\N	2025-10-07 15:33:06.862943	2025-10-07 15:33:06.862943	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
ce1602a8-4d37-4cd9-85a5-82e5a6993d2a	2024JULB00225	abhishek.nema2426@jagsom.edu.in	$2a$12$5Efe3JI6qO8IP9c901oamuM0PxS/cQezh9Gm3b70t1amuXafkSej.	student	active	\N	2025-10-07 15:33:07.329145	2025-10-07 15:33:07.329145	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
f77c1d88-a95b-428c-a9f2-7bfd854d03eb	2024JULB00269	vrijendra.balaji2426@jagsom.edu.in	$2a$12$Cri60IBPOhIni5Yssl9A5e1uzfBbKV0PZOAPliigTp9QRsL1wO1fS	student	active	2025-10-07 19:31:00.696	2025-10-07 15:33:26.058035	2025-10-07 19:31:00.711745	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
12d35392-ace7-46fc-b8cf-573ab0728ce8	2024JULB00227	sumit.sharma2426@jagsom.edu.in	$2a$12$bBnTp3FKBUIFc8OGvxyrVerlCGIFVLFI5/48pRIlzq1espKhI4CMC	student	active	\N	2025-10-07 15:33:07.792934	2025-10-07 15:33:07.792934	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
95a98951-128a-4c29-9f84-ac40a9187e29	2024JULB00229	malvika.sinha2426@jagsom.edu.in	$2a$12$am9u7reB9kpy6Pl.GjbGLOc86YU9JeXfW6Y9DJao94oGl9wzANV3C	student	active	\N	2025-10-07 15:33:08.24242	2025-10-07 15:33:08.24242	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
7632b58a-b0b1-4f2f-95e0-6ee466e73128	2024JULB00230	jaladi.susanthika2426@jagsom.edu.in	$2a$12$1bZ1LY0bCNYwUZJftknX/OHIt/F191MzbHZeOAwpWm68aHhy8ilY6	student	active	\N	2025-10-07 15:33:08.713553	2025-10-07 15:33:08.713553	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
709c5a85-1e5e-44f1-b662-f1890759d597	2024JULB00231	sanskar.dixit2426@jagsom.edu.in	$2a$12$nPKZdL5wFp8ZpyIHhy4huefi2YeSbfnbMv0RVfMW3s8aAsU1pIOj2	student	active	\N	2025-10-07 15:33:09.173737	2025-10-07 15:33:09.173737	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
1631de77-ee2d-4779-9ff9-f109959b34b1	2024JULB00232	ankita.anand2426@jagsom.edu.in	$2a$12$q2mFJ77U5V5ZvcVvtclpY.VzI4ens3VU8r5LHAO9fims.GMCLlk/C	student	active	\N	2025-10-07 15:33:09.629854	2025-10-07 15:33:09.629854	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
f1ee4470-692c-4024-8af2-701098d06e83	2024JULB00233	riya.batra2426@jagsom.edu.in	$2a$12$nyZQrDMHU/6/8Zn2v53WreMBLljCVGiyYCwWl8D8rYwr9f2YVuoxO	student	active	\N	2025-10-07 15:33:10.073531	2025-10-07 15:33:10.073531	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
b80e75e8-1990-4ab2-8604-9dccd8c5a3eb	2024JULB00234	pratheek.bhat2426@jagsom.edu.in	$2a$12$6iptN7skrNhpgciwI3wEuOKzFjDgAR.m/yIIsbSWx4zZcClA9fM6O	student	active	\N	2025-10-07 15:33:10.511253	2025-10-07 15:33:10.511253	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
19ce6932-c7b4-4b92-b81f-b155be63eb9d	2024JULB00235	abhinav.dubey2426@jagsom.edu.in	$2a$12$8/WDiY5cCHect6YNyRDuMeZZZew2f0qOvveWqfW6ObOm/2D7kuD0K	student	active	\N	2025-10-07 15:33:11.001645	2025-10-07 15:33:11.001645	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
740031c2-f09c-4774-b138-07aac00ca69f	2024JULB00249	kartik.garg2426@jagsom.edu.in	$2a$12$kYoOqRFv74fHLUzWD0n3GOXub7VrK4M5AvmJZ9yw1s3yatLaJC/rS	student	active	\N	2025-10-07 15:33:17.376025	2025-10-07 15:33:17.376025	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
be44d739-85a4-4d7a-9b2a-89de477f6fa7	2024JULB00250	sanjana.kapadia2426@jagsom.edu.in	$2a$12$s2NKUaMvot0QDAaklMsU8OoA6vfHuvIsNjDQbaVkCGOeDzku9kVX2	student	active	\N	2025-10-07 15:33:17.82848	2025-10-07 15:33:17.82848	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
8fba6e4b-5cb1-4012-968a-a37b97552776	2024JULB00251	rishi.rajyadav2426@jagsom.edu.in	$2a$12$JHsqKn.vh9uBM5uwp/je2OaICBhiZoEQLvcw1ewWz0d1.58Ur23om	student	active	\N	2025-10-07 15:33:18.266261	2025-10-07 15:33:18.266261	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
4aa56658-aa1d-4e5e-bd66-76c2bb9845d8	2024JULB00252	ronak.agarwal2426@jagsom.edu.in	$2a$12$dwWGiIVEm4jddJtaClroVOFj7EEJWCkqwuhuFlgc90yrDLcVNsl4W	student	active	\N	2025-10-07 15:33:18.731535	2025-10-07 15:33:18.731535	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
5074718e-5dbc-4788-9516-3b3f3496f7ca	2024JULB00253	pritam.rajuShet2426@jagsom.edu.in	$2a$12$9n2JNZcG337rEJRKuvQSLuYtV6AasFLNcxvQaOXclnIhJ5ntqWkLy	student	active	\N	2025-10-07 15:33:19.14966	2025-10-07 15:33:19.14966	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
95d8be8d-59d5-451b-b229-a6551577581b	2024JULB00254	reshu.sharma2426@jagsom.edu.in	$2a$12$OZ/UVfoW9flbW1u70cH3Iu78jVBwuAL1Tn/JOMzjc8njYi2hWkysa	student	active	\N	2025-10-07 15:33:19.582474	2025-10-07 15:33:19.582474	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
6feabc3f-e514-44d5-9530-47b729eb9eba	2024JULB00255	saisrita.rao2426@jagsom.edu.in	$2a$12$/Rkix0bLJkxeItGLV027GeCa3/bQq/0tvc4FFncmshCLDVPuYHTqO	student	active	\N	2025-10-07 15:33:20.016231	2025-10-07 15:33:20.016231	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
693eb0a5-2958-412d-a8e5-90dd820532e9	2024JULB00256	riya.kumari2426@jagsom.edu.in	$2a$12$MzlOg5thEj6HGr2VppK9dOoQslj.aGYlBOep4c/hNjzjsfx5LBe2O	student	active	\N	2025-10-07 15:33:20.461006	2025-10-07 15:33:20.461006	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
b3135872-495f-4891-989c-215c20989764	2024JULB00257	saurav.singh2426@jagsom.edu.in	$2a$12$j8SqVd28o4xcCcu7GniZX.eMGzAKd9LUIhmePTd1PQlBHPY8D7Yyu	student	active	\N	2025-10-07 15:33:20.898269	2025-10-07 15:33:20.898269	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
510f16f9-4741-4343-9a11-28310e86db3b	2024JULB00258	animesh.tiwari2426@jagsom.edu.in	$2a$12$2mNXW16fmk7Hh0eWLm7ckuhBo2g4a/dQg7AZHyQSVhYS.boBrpkHi	student	active	\N	2025-10-07 15:33:21.334811	2025-10-07 15:33:21.334811	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
2b348b23-c8d4-4b57-ae18-ee10f964a8a4	2024JULB00260	vishal.durgarao2426@jagsom.edu.in	$2a$12$cDooI4BFkTAyoPhOV7siCe82AHUtkm6.mAiGeFES2Vkejp.4W2gt2	student	active	\N	2025-10-07 15:33:21.782521	2025-10-07 15:33:21.782521	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
9929d849-b4ad-44bd-b319-5bbdb172d53d	2024JULB00261	ananya@ifim.edu.in	$2a$12$Y9GgOCMHzfMQIhxM0e1IveF6pqQEMy19bjQfTh/aJ.uGR7R0neQgy	student	active	\N	2025-10-07 15:33:22.232648	2025-10-07 15:33:22.232648	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
49b2b147-7433-4feb-b2f9-73d66943c856	2024JULB00262	aman.kumar2426@jagsom.edu.in	$2a$12$2VhGi8Cc8zYKw4m/SjpntevNIUpQCRvPamaMhDhTMsFe7KBXQDu9S	student	active	\N	2025-10-07 15:33:22.744802	2025-10-07 15:33:22.744802	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
2d58e38e-cd77-4659-82f9-31974b47337d	2024JULB00263	soumya.roy2426@jagsom.edu.in	$2a$12$p4.XEUqqXJZAUTDyLzigDOkIbvKeXD.IirQsUcfQBA8LtahJS7OH6	student	active	\N	2025-10-07 15:33:23.222177	2025-10-07 15:33:23.222177	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
0442e901-36e6-432f-aeb3-dc2ed66fcbf8	2024JULB00264	nikita.sehgal2426@jagsom.edu.in	$2a$12$9KwLJZ5kHSjaQdHRkim5xuiUUUnpxGcBQ.4P8LApx7crU6BSbqZli	student	active	\N	2025-10-07 15:33:23.673671	2025-10-07 15:33:23.673671	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
1238d389-aa34-4a18-932b-d200322032f5	2024JULB00265	srijan.dobhal2426@jagsom.edu.in	$2a$12$xX8uqtq6X1Pw5wYNw8y2L.HNdPYLojsRPzTUjEc5qTIs2kzfTn4oe	student	active	\N	2025-10-07 15:33:24.355098	2025-10-07 15:33:24.355098	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
0de12f07-d6eb-4ef7-a819-e2c4d901dc80	2024JULB00266	musaddik.k2426@jagsom.edu.in	$2a$12$VJ8rUcH2lh6Mr1oeMfNiEO60X4FoadrECgTrcorIY0DLhobJSEd96	student	active	\N	2025-10-07 15:33:24.772028	2025-10-07 15:33:24.772028	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
4742c6a3-73d3-48f9-ae1b-c3e7694eff9b	2024JULB00267	kushal.raj2426@jagsom.edu.in	$2a$12$r/MPf4NyAn..qiP4t9JNRexg4PotHBpFlc3QOuMke4dXvUCvvi2CK	student	active	\N	2025-10-07 15:33:25.191774	2025-10-07 15:33:25.191774	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
686f7272-d148-4350-b768-e312556865b2	2024JULB00268	soumya.c2426@jagsom.edu.in	$2a$12$gNFzlLExSCMfSSQ1ET5/hOpvJHRpKd2C31kNQQJtktCYpQVCa2jPi	student	active	\N	2025-10-07 15:33:25.609073	2025-10-07 15:33:25.609073	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
8677a0be-5538-4bf4-bf9b-a49af73c0f43	2024JULB00270	rahul.gupta2426@jagsom.edu.in	$2a$12$./ywfkYlEWfp4Dj7adHY9OJOUDqYbY0T4ychRzmnR2AqsoUf/O0XW	student	active	\N	2025-10-07 15:33:26.486169	2025-10-07 15:33:26.486169	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
ec3a4159-1b9f-42c3-b2a1-5f28dcc24e89	2024JULB00272	vikash.kumar2426@jagsom.edu.in	$2a$12$wpGAWXBjnkKOIEVOuzHZtOyPOP2vlocBNOaeMZ3Vhs3qt9/dz9ylO	student	active	\N	2025-10-07 15:33:26.915576	2025-10-07 15:33:26.915576	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
16459cad-4104-4955-8977-45eb93a63d4a	admin1	admin1@university.edu	$2a$12$KDMyOlpa3TmHwP9OQPjM0OWma5gLtwSK9Z4DSiFmInms0kpLiDWQS	admin	active	2025-10-09 06:26:07.979	2025-06-16 21:17:51.663949	2025-10-09 06:26:08.008138	\N	\N	f	\N	\N	\N	local	super_admin	\N	\N	\N	\N
b0cde931-c687-42e5-9643-e36a15868f17	q	q@e.com	$2b$10$7qLe6LcAtJ0wiJHPk/yOw.VB66MhFN2Cnhrutsn/rcUWS4K8obN4.	teacher	active	2025-10-09 05:51:25.839	2025-07-12 06:49:51.938174	2025-10-09 05:51:25.862445	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
55cbe40e-01ab-4cb7-ae64-9e5a006c791c	2024JULB00028	aryan.balapure2426@jagsom.edu.in	$2a$12$WS2Fn0wIBI5/.shfPvZPBO.R4GjqJMBIKrTrFnYv91Wj2VSg/Iw92	student	active	2025-10-07 19:06:46.31	2025-10-07 15:31:51.820343	2025-10-07 19:06:46.379627	\N	\N	f	\N	\N	\N	local	local	\N	\N	\N	\N
\.


--
-- Data for Name: weightage_change_audit; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.weightage_change_audit (id, config_id, change_type, entity_type, entity_id, old_weightage, new_weightage, change_reason, changed_by, changed_at, change_context) FROM stdin;
41210283-04cc-4129-8579-e92680efea0d	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	quadrant	persona	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.744735	{"table": "batch_term_quadrant_weightages", "migration": true, "operation": "INSERT"}
a61eb1ed-9b95-4919-afe3-3c418432f373	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	quadrant	wellness	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.744735	{"table": "batch_term_quadrant_weightages", "migration": true, "operation": "INSERT"}
2feb8225-b3b2-43c5-91a7-3f3bcc0b8413	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	quadrant	behavior	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.744735	{"table": "batch_term_quadrant_weightages", "migration": true, "operation": "INSERT"}
b3fde88c-ecd5-448c-b318-6bbfdde35fd4	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	quadrant	discipline	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.744735	{"table": "batch_term_quadrant_weightages", "migration": true, "operation": "INSERT"}
ffde3eab-198c-4ee9-954e-a93668d8751f	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	subcategory	bcd6a86f-338c-4997-ae43-f378cc10dbb0	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.821104	{"table": "batch_term_subcategory_weightages", "migration": true, "operation": "INSERT"}
c5f10808-a7c4-41c3-98fe-3d978bd8f8b3	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	subcategory	f1282f61-7149-4e9f-aaad-d3dc5b14d533	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.821104	{"table": "batch_term_subcategory_weightages", "migration": true, "operation": "INSERT"}
e42306a3-f4c1-4e05-8382-13fc49aea10a	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	subcategory	167335d3-2172-4eb4-8275-af4341c79882	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.821104	{"table": "batch_term_subcategory_weightages", "migration": true, "operation": "INSERT"}
42b610e7-3835-4f6c-a69b-53c23c1588b8	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	subcategory	ae887796-17a6-4ee8-ac39-8bd3154508de	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.821104	{"table": "batch_term_subcategory_weightages", "migration": true, "operation": "INSERT"}
08e1a67c-ef1f-4483-84a6-604ff636a910	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	subcategory	90298481-85b8-460e-a294-eb938947aa1e	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.821104	{"table": "batch_term_subcategory_weightages", "migration": true, "operation": "INSERT"}
b914bc39-0d7b-4dce-8804-ce7dc0e661d2	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	component	34c05a81-5261-49cc-a48e-74beeffbbde9	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.879485	{"table": "batch_term_component_weightages", "migration": true, "operation": "INSERT"}
9969424f-1fbe-4067-bf4d-3934e171cd7a	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	component	4c6ad1ae-7165-432e-a915-4102082c36cf	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.879485	{"table": "batch_term_component_weightages", "migration": true, "operation": "INSERT"}
72b713d8-3c8b-420f-bcc3-e55b000c6168	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	component	5bd8fc59-1862-48bf-abf0-428da25a1b07	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.879485	{"table": "batch_term_component_weightages", "migration": true, "operation": "INSERT"}
91b22543-94db-46e8-9ac9-85b824b943e4	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	component	33a34606-c38f-41b4-b177-018d32e147fe	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.879485	{"table": "batch_term_component_weightages", "migration": true, "operation": "INSERT"}
f4569f23-cced-418b-9150-0c05a172cc35	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	component	dbbfaec0-c416-4124-8e84-0e6fd939b203	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.879485	{"table": "batch_term_component_weightages", "migration": true, "operation": "INSERT"}
3d9a7aac-d129-4f5a-8eff-ccc3c0415a61	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	component	5f879989-7fbb-420c-b532-31939fb64bf3	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.879485	{"table": "batch_term_component_weightages", "migration": true, "operation": "INSERT"}
9dcd2f26-16f9-409d-9ecd-e9db89332f27	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	component	1e184ce2-e271-4666-b316-cbdf446b6ff1	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.879485	{"table": "batch_term_component_weightages", "migration": true, "operation": "INSERT"}
904bfc3d-9c71-44ec-9c9a-094440513772	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	component	942dd95e-c3cc-4d75-872f-10284d06bc0c	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.879485	{"table": "batch_term_component_weightages", "migration": true, "operation": "INSERT"}
f8eb6984-26e5-4413-a47e-2ebfe01ebfe5	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	component	61b99470-5e1d-4e02-9d4c-22836faca5f6	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.879485	{"table": "batch_term_component_weightages", "migration": true, "operation": "INSERT"}
e7fa1e20-9dca-45bf-8848-03e1b1faa7dc	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	component	6d9537fa-408f-458f-8ce4-df168aca82b3	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.879485	{"table": "batch_term_component_weightages", "migration": true, "operation": "INSERT"}
ab98aea8-a883-481d-bd02-fe28531ada7c	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	component	b464cb43-8128-4edd-8bc3-5ff6b58e7026	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.879485	{"table": "batch_term_component_weightages", "migration": true, "operation": "INSERT"}
a0538306-7b03-4c82-8d2a-abe6113d02e7	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	component	04c55953-826b-41f9-81fc-6a7a8edbca62	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.879485	{"table": "batch_term_component_weightages", "migration": true, "operation": "INSERT"}
aab7732a-711b-41b3-9d63-4560c04a463f	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	component	4dfe00e4-716a-4358-8185-f9672ddf7ad3	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.879485	{"table": "batch_term_component_weightages", "migration": true, "operation": "INSERT"}
71654ad8-39ab-4c36-9953-c95a175b7497	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	component	47a5b091-72ec-47d9-9028-c2e80a1dfa4c	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.879485	{"table": "batch_term_component_weightages", "migration": true, "operation": "INSERT"}
b80b1307-9535-4b1f-b10b-d821e1c04b00	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	component	08273004-dc4c-4738-8740-507d23ac7c22	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.879485	{"table": "batch_term_component_weightages", "migration": true, "operation": "INSERT"}
d44b3f4a-aa6c-4482-8a49-1bd0806a8003	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	component	72115e64-922a-4df2-a20e-aadebbb0eab3	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.879485	{"table": "batch_term_component_weightages", "migration": true, "operation": "INSERT"}
820c0edd-1ff8-4148-8cfa-695dd848cfe8	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	component	9ec8e344-1032-47ff-8c4e-e52c721f6150	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.879485	{"table": "batch_term_component_weightages", "migration": true, "operation": "INSERT"}
6725d789-2cd6-429b-8318-6cd75bbe01fe	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	4476c3a6-58da-4c43-9b8a-b1da70172072	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
2fc966ee-7c3e-4ce4-b768-6ce4ae16248e	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	31a4c844-6a46-4b57-a23d-91d9a5ff7382	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
529a1c56-4eff-4f96-a738-d6e2a904974e	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	4d6b4184-d62e-427a-ba00-16ff3f4e4f10	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
f5f18b60-46d1-43a7-b7f1-f115b10356a0	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	06947927-aab0-4d24-b5fe-b42c0b83050c	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
91b15108-192c-4ac8-9c4d-3aa8563f65b1	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	6ef0dc2b-9fd6-40e2-a2c6-2485232d953c	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
748b8fb8-e43c-4b7b-9cf4-00bd72718778	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	7e8983cd-5a94-49cc-9b80-64358a9d48f9	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
bd093ac2-fb20-4c1d-a1c9-d27415c7c6d0	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	685d23ad-eadc-47ac-9f91-8f741ae4211f	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
6711f21a-af4b-449b-87fa-e0bb3e408e1e	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	2e599a1f-e34d-436c-98f9-01f019cb29bd	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
2fa7abd8-d988-480d-9c78-fcdb23fb775d	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	1b63c6c1-36b6-49b5-a61f-1c3f2b85bdb1	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
e7046899-7515-48e4-90f1-9b3b7e80515f	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	44a43cc4-8d2e-4ce5-b437-2b76a205ea84	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
e95c1532-974a-41eb-8b6d-22faf1e4c0f5	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	08314805-8508-4254-997b-a035415747d5	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
27166a98-c06f-4982-9695-49cb9df06e62	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	9077e1c0-d24a-4477-983a-6b8aeaa43532	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
0588f670-8d21-4c51-b031-f4a73982f411	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	64be578a-9f8e-4795-aeae-1b5dac189cce	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
c4ac0e7b-ffc6-4d74-a1c5-8a7d4d0a5d7f	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	be2ca789-8ed3-4c6f-808a-1dfb50c19877	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
f74e97af-31dc-44f5-8232-6cab483ea98c	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	448cb56a-e4d6-44c4-a49b-8a6119f36843	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
abdcdbab-eb53-4a30-9665-2e3a169c8cd2	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	5a1ffe37-852a-4e75-96c8-5353fdbf9011	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
58075fd9-2b68-49a1-a0a4-b1444d284264	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	4680bc8d-b6f0-40e3-ba26-a05e68d21f14	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
c35283f9-7530-45f6-b4bc-3952b31347d5	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	9ceb0bdb-9f21-40da-b938-c7729ff2daa3	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
aaf92a40-ef72-43b9-be39-257764c42a01	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	a48a6338-402d-482e-8d7a-b7193d97047a	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
40c5363f-b4e3-4109-9f8e-3cf8bc45b194	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	55fa8528-6b9c-4f3c-9fb2-6de44c5d9cf0	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
15576294-7128-4aad-ab07-8f6b2ce46c30	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	457db1c7-044e-47a7-a820-e1e5114f9cea	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
d2016861-cbaf-49fa-be5c-de596bf7b1f9	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	31509ddf-18ee-4538-a2eb-5bbe560c0914	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
6b4b8c53-c6ca-496d-b455-334f156652e5	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	698deda3-2aa9-4d4f-8a14-2fb80faac986	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
84855dc3-888c-43c7-a5bf-77f3f4f136c3	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	3f488cd4-bad3-46ec-9f92-1957e2924774	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
c85d2417-d0c0-477b-8e7f-181b8749997d	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	6dad3ff1-9da6-4efd-9549-e8b4654529c7	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
ffbe006a-b863-46e6-9ee1-f8e5bcdd35be	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	74771254-6da7-4ea1-a8b9-7ad3c99d75db	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
fce8d714-aca4-4ee9-a44b-f618f8160710	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	a8953d15-fdda-490c-8a8e-1372f25c0a33	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
b64a97eb-cfda-4122-ba70-a70728a041ec	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	76e855c0-ec81-4eae-a010-0e23b76426f1	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
ef7d9a1e-36a8-405b-aa8c-54e12abd1a60	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	810f1b09-7630-4260-bf7e-5fa910cbb3dc	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
709d31fe-d913-4a05-9599-016434d4ef1c	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	01c4c2d4-ab2f-480f-b145-442ae56fad48	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
35fe680b-afb6-4707-bb0f-c3b8a840c781	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	2d2976b5-f9bb-42e8-aca0-d6e6b6e6de77	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
c4ca5654-5fb9-4210-859d-344bafe1f724	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	22d1a89c-85d5-4403-8330-e34aa6c8b2fc	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
4ff97616-01d1-40f3-a846-4e2be0d3b86b	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	7082bb51-3094-4606-8f92-106a1820e380	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
74f9ee4c-6fdc-419a-9f99-848b1d1e838d	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	101eb49e-efd6-4def-9a1f-11dce221cdba	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
1046fb41-3439-4e8a-b4a2-b857340079c6	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	c030fd4f-5f7b-46ad-84b7-631adbeb1f40	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
2e84f62d-e549-4a4a-95c4-05372dd32984	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	adbc17f9-6f88-4144-afe1-e29f3a0bd21e	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
0d088458-b86e-4e65-a44c-65ed9303e763	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	bcb48067-c6be-4c39-87bc-08618f18ef4e	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
fe4fe55f-123a-47d5-9612-dc82ce47fef5	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	955efb94-7eac-4392-969a-732f19143f89	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
81e220d5-74dd-4a85-a4ff-c3b206a9e0c4	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	45cfe4d4-2cc1-4dd3-b5a8-67ecc9d243c9	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
90d07b48-5848-46d4-ba44-49ab2b99facf	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	cb21ea38-e7ad-4f8d-b4c4-33f892cd9119	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
14c7431f-791d-434b-aa8b-1d0a59b794d3	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	3554e4f4-8d4c-4b4a-9fe6-88eb1f5ef489	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
5c262f47-cc97-4070-93e8-2683540e01cc	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	f7be1839-a795-438b-b9da-54fed97ca1d7	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
931aa673-835e-4843-818d-a86e0027c444	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	3da28c94-987a-419d-ac12-822d05bd8448	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
225a2269-6412-45f5-ac55-3d255b4dc3bf	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	c42f0ccc-e7e4-447b-b392-ecd3eca5d764	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
f23715d0-40aa-4b4e-8ba3-4905d7725e12	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	544af37f-9528-4ef3-bc99-5870532c51d5	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
0acf4489-39e4-4d74-bd4c-f567df3dd6b8	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	d3660cf9-b4c4-4c12-bba3-766c128a43ac	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
f1ee5551-8aa5-46f7-96af-7c3244f31b7b	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	a0ce1af3-fabf-4a1a-851e-edb00cd10f22	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
57f48396-71bd-44cd-9b2d-8d8758f14653	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	d69b272d-0f08-4157-8db3-43ba94def224	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
3344b1fe-ef18-4373-821d-ff15a5f7dc4d	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	3e8102b3-e71f-4739-8682-b5ebcbdbd6a5	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
1e8b7ceb-550c-4cd5-9fac-85b2dd663c9e	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	cd6c3b70-cdbb-47c6-b1bb-d3236ee53d03	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
3655c321-91fd-494f-a7ca-acfcfacef545	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	4624333f-29fe-4075-9023-9526c56f1783	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
cb59cebb-de7e-4002-87be-e4a01975a4e4	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	2f71659a-9d89-4d70-8319-b6ef85764acf	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
b2dcaa78-2b2d-48bd-b1ac-e24d9b5f3374	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	f2cb1b7e-41df-411f-abaa-2ac7cbf58674	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
3708e00f-fffa-4dfc-a7c6-f80e3bd3101b	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	6f74812e-ca45-4234-9a10-9bfe8f46467c	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
37ad8d81-940c-4822-ab11-b0e811703b40	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	0decb9dd-8b4c-471e-97ab-df29e7bb212c	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
15edce45-276a-4638-a270-c09b58f3cdca	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	88fad813-46ed-4601-a334-ae77df797be3	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
442b94ff-f55e-49c2-b69d-c9e44ed3ea95	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	9358b2c4-aebc-480a-9eff-6873c156da12	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
867873df-b676-4d5d-beb2-662ba965362f	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	d5760d32-ce61-48fd-988e-9bd16cc52ca1	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
e1b28708-e3f9-4fda-8199-5c117798ea54	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	7022a346-204b-472a-b46b-b801f07e8853	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
d8dc185e-5e33-454b-a864-f361b0db3a06	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	c26c7d3d-7062-4ac5-a1f5-a69b17724eaa	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
03386203-aeda-45eb-84a8-e55740b3d6bc	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	6852ffde-5e9e-4faa-be78-93d194b1f8b7	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
26bc1b46-713a-4d43-baa3-08f6e2045c58	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	de38ca59-7d04-4de2-acfd-6daf46162a07	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
3765ab35-e415-4f8b-9bc9-1b88752ab6d3	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	6350fa4f-4163-42b7-a37a-16be275b9418	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
f703de3e-6e32-444c-9c91-bd57fa7bb406	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	7453ffe7-e829-4f52-a16b-44efbc183640	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
e41cf66e-df67-4690-b056-a69cc60f5a74	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	fbd8f3d7-1bbe-4e3c-955f-c370b9f7f680	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
9e7b28fe-e808-4bf4-8b06-74e4954ac9be	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	569954c7-4f99-425c-9454-45277997273b	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
c37ed310-17a5-4ec8-b330-d609a468851e	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	13936326-3a08-46e7-9577-cfee038577f0	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
d88c07a5-d9d7-46c0-99c3-cfc17fa5b586	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	5fd87c78-5e02-4ec6-8706-1a2678ee90b4	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
af7e5f80-682e-40ce-902e-d1cbe5feab15	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	9136ba3e-9c59-47ab-ab64-67a2f84b74f4	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
8d990486-d8a5-42b4-a6c7-b77ecd0871c8	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	47c94861-1830-4e10-97f0-5f0b5a7f9c05	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
f362c495-ab95-4dfb-ad22-ed3d84ad0934	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	a6fc7ef9-8ebc-47cc-b9b5-48b404599670	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
ccd711e2-4377-4684-bcc3-1b4c44ab179e	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	5016201d-732e-4a7f-8e7e-c9d3fa3b2030	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
4e5d2114-d3e7-4525-be02-b24d3d38669d	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	10163f9f-5bb3-4bdc-b3c8-9ddf17b2e3b6	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
5f07f27d-39ad-4cf0-b36f-2b6c7ea54aba	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	0322c72d-2fbf-462d-9a59-76e1550b30d9	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
0a832e96-c70f-4a8e-95b9-fbddde34d9e8	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	ec97e568-30d6-4e8f-acb3-b74d1b4b5436	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
77df7a5e-64ea-456d-a3f3-abac888e77c9	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	41ab0a41-f16e-4bd5-961e-5b070acd6410	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
aafe6d49-a074-417c-8173-cd09dfbb4749	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	b2e23679-040c-4d57-9ab7-4a019c00652a	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
c078e1e7-7bdf-48e8-8952-96fb948a62b0	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	7a0abf02-6038-45d0-9a9d-4d0a25e44019	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
5dd293d2-32c9-443d-bd2f-25798808f097	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	b7d67908-6205-4863-a694-d7dba56e1d39	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
6dbdc8a3-2a4b-46a2-a74c-3f1f9e7185ed	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	30b71cb1-97df-4655-8704-0560bcf5da06	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
d02c1bf0-c621-46ce-a935-9ad093f369b5	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	f658c2c3-3d12-4798-bccb-9af886cd15eb	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
a8393fcb-7200-478a-9c2d-4b2556be2221	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	6f903e44-300e-470c-aa64-125da9772880	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
bc390540-0cdc-44cf-8cf2-08885bd1de3a	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	24c6259e-6fbf-4a75-a66e-bd8a2894b261	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
89f39e06-8573-4f10-b9d9-f1a803d86258	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	a2287dfb-4153-4222-91dd-5ab86abcd82a	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
4fff8a6a-d9a9-4d1f-b14e-79c4278a216b	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	77c73ecd-3988-4efa-af44-efe3725e9f14	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
2565d5e0-8fc4-423a-a1c2-b34941e483a5	d9dfeb65-9d58-476b-8a71-61df3af839b6	create	microcompetency	3125cce7-fab5-4000-a4ec-d6cb3069e730	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:44:04.938371	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
7ac40ffc-4444-4e68-9478-28421106fabf	d9dfeb65-9d58-476b-8a71-61df3af839b6	update	quadrant	persona	100.00	50.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:45:13.729089	{"table": "batch_term_quadrant_weightages", "operation": "UPDATE"}
4d21e7bd-14d5-4d71-8537-14009d6cea42	d9dfeb65-9d58-476b-8a71-61df3af839b6	update	quadrant	wellness	100.00	30.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:45:14.007969	{"table": "batch_term_quadrant_weightages", "operation": "UPDATE"}
ba949d99-edb3-4903-93e1-82bfe337e5fd	d9dfeb65-9d58-476b-8a71-61df3af839b6	update	quadrant	behavior	100.00	10.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:45:14.133713	{"table": "batch_term_quadrant_weightages", "operation": "UPDATE"}
fdfb347a-bc99-42c1-907c-a6e221d67060	d9dfeb65-9d58-476b-8a71-61df3af839b6	update	quadrant	discipline	100.00	10.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:45:14.170236	{"table": "batch_term_quadrant_weightages", "operation": "UPDATE"}
e3941054-ce04-4ce2-9fbc-e58112a7a344	94907b83-1c4f-4ed4-8104-597b6924576c	create	quadrant	persona	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.700716	{"table": "batch_term_quadrant_weightages", "migration": true, "operation": "INSERT"}
d82e21e3-4af2-4383-b5e1-8d610eaa3332	94907b83-1c4f-4ed4-8104-597b6924576c	create	quadrant	wellness	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.700716	{"table": "batch_term_quadrant_weightages", "migration": true, "operation": "INSERT"}
1b36c368-85e6-4087-8df2-5fee2a3dee33	94907b83-1c4f-4ed4-8104-597b6924576c	create	quadrant	behavior	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.700716	{"table": "batch_term_quadrant_weightages", "migration": true, "operation": "INSERT"}
e015e9b8-bc37-41a5-a0b8-f81883f9c908	94907b83-1c4f-4ed4-8104-597b6924576c	create	quadrant	discipline	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.700716	{"table": "batch_term_quadrant_weightages", "migration": true, "operation": "INSERT"}
3724132a-a815-4e15-9ad6-695205928a99	94907b83-1c4f-4ed4-8104-597b6924576c	create	subcategory	bcd6a86f-338c-4997-ae43-f378cc10dbb0	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.748513	{"table": "batch_term_subcategory_weightages", "migration": true, "operation": "INSERT"}
e689af45-94bc-47ba-8732-db357b9a65e3	94907b83-1c4f-4ed4-8104-597b6924576c	create	subcategory	f1282f61-7149-4e9f-aaad-d3dc5b14d533	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.748513	{"table": "batch_term_subcategory_weightages", "migration": true, "operation": "INSERT"}
617d0707-3057-4e06-9822-b1d77444277c	94907b83-1c4f-4ed4-8104-597b6924576c	create	subcategory	167335d3-2172-4eb4-8275-af4341c79882	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.748513	{"table": "batch_term_subcategory_weightages", "migration": true, "operation": "INSERT"}
deb3fdd4-81bb-4a08-8271-9df6bdb2fc24	94907b83-1c4f-4ed4-8104-597b6924576c	create	subcategory	ae887796-17a6-4ee8-ac39-8bd3154508de	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.748513	{"table": "batch_term_subcategory_weightages", "migration": true, "operation": "INSERT"}
f30632e9-5204-4c04-896e-009bbb7471ce	94907b83-1c4f-4ed4-8104-597b6924576c	create	subcategory	90298481-85b8-460e-a294-eb938947aa1e	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.748513	{"table": "batch_term_subcategory_weightages", "migration": true, "operation": "INSERT"}
98540c80-e77e-44c6-959d-2db8dab8d39d	94907b83-1c4f-4ed4-8104-597b6924576c	create	component	34c05a81-5261-49cc-a48e-74beeffbbde9	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.828562	{"table": "batch_term_component_weightages", "migration": true, "operation": "INSERT"}
ef8e14f8-dd2d-4f69-9197-c352ff4f32d6	94907b83-1c4f-4ed4-8104-597b6924576c	create	component	4c6ad1ae-7165-432e-a915-4102082c36cf	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.828562	{"table": "batch_term_component_weightages", "migration": true, "operation": "INSERT"}
ecb2dc6a-50eb-49dd-902d-c8ae76083481	94907b83-1c4f-4ed4-8104-597b6924576c	create	component	5bd8fc59-1862-48bf-abf0-428da25a1b07	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.828562	{"table": "batch_term_component_weightages", "migration": true, "operation": "INSERT"}
1df9c088-a1b2-4162-82e1-747e15cf6f2b	94907b83-1c4f-4ed4-8104-597b6924576c	create	component	33a34606-c38f-41b4-b177-018d32e147fe	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.828562	{"table": "batch_term_component_weightages", "migration": true, "operation": "INSERT"}
5bd747e1-b05a-4de5-96df-6a3f93332893	94907b83-1c4f-4ed4-8104-597b6924576c	create	component	dbbfaec0-c416-4124-8e84-0e6fd939b203	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.828562	{"table": "batch_term_component_weightages", "migration": true, "operation": "INSERT"}
1e01d4af-3cdd-4456-9888-106982325cad	94907b83-1c4f-4ed4-8104-597b6924576c	create	component	5f879989-7fbb-420c-b532-31939fb64bf3	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.828562	{"table": "batch_term_component_weightages", "migration": true, "operation": "INSERT"}
397cdb1e-4239-4d29-a7d5-43bbfbb64e45	94907b83-1c4f-4ed4-8104-597b6924576c	create	component	1e184ce2-e271-4666-b316-cbdf446b6ff1	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.828562	{"table": "batch_term_component_weightages", "migration": true, "operation": "INSERT"}
8fc78af5-0e48-48fa-8d6e-18a852443c60	94907b83-1c4f-4ed4-8104-597b6924576c	create	component	942dd95e-c3cc-4d75-872f-10284d06bc0c	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.828562	{"table": "batch_term_component_weightages", "migration": true, "operation": "INSERT"}
30dc439e-5168-434e-b5f3-64a592dff85f	94907b83-1c4f-4ed4-8104-597b6924576c	create	component	61b99470-5e1d-4e02-9d4c-22836faca5f6	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.828562	{"table": "batch_term_component_weightages", "migration": true, "operation": "INSERT"}
64d753a1-c755-4f6b-b3b7-58c75102d343	94907b83-1c4f-4ed4-8104-597b6924576c	create	component	6d9537fa-408f-458f-8ce4-df168aca82b3	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.828562	{"table": "batch_term_component_weightages", "migration": true, "operation": "INSERT"}
52437fec-3610-402a-a3ec-c0d044e54565	94907b83-1c4f-4ed4-8104-597b6924576c	create	component	b464cb43-8128-4edd-8bc3-5ff6b58e7026	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.828562	{"table": "batch_term_component_weightages", "migration": true, "operation": "INSERT"}
33fc4bac-eaac-4a0c-b784-3532b7b4c715	94907b83-1c4f-4ed4-8104-597b6924576c	create	component	04c55953-826b-41f9-81fc-6a7a8edbca62	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.828562	{"table": "batch_term_component_weightages", "migration": true, "operation": "INSERT"}
8eb82833-021b-4e3b-9488-6187e9d24f5c	94907b83-1c4f-4ed4-8104-597b6924576c	create	component	4dfe00e4-716a-4358-8185-f9672ddf7ad3	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.828562	{"table": "batch_term_component_weightages", "migration": true, "operation": "INSERT"}
d020c1c9-de00-4fb6-9352-1e7f1b688a8c	94907b83-1c4f-4ed4-8104-597b6924576c	create	component	47a5b091-72ec-47d9-9028-c2e80a1dfa4c	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.828562	{"table": "batch_term_component_weightages", "migration": true, "operation": "INSERT"}
880bdebf-58a7-4a4d-8608-8c84d18a5d47	94907b83-1c4f-4ed4-8104-597b6924576c	create	component	08273004-dc4c-4738-8740-507d23ac7c22	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.828562	{"table": "batch_term_component_weightages", "migration": true, "operation": "INSERT"}
12cc196d-3571-4236-97c9-62db716b9479	94907b83-1c4f-4ed4-8104-597b6924576c	create	component	72115e64-922a-4df2-a20e-aadebbb0eab3	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.828562	{"table": "batch_term_component_weightages", "migration": true, "operation": "INSERT"}
1277a9a6-069f-4f32-a8f8-8985b69510eb	94907b83-1c4f-4ed4-8104-597b6924576c	create	component	9ec8e344-1032-47ff-8c4e-e52c721f6150	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.828562	{"table": "batch_term_component_weightages", "migration": true, "operation": "INSERT"}
023b1c9d-ac7d-4e52-92b3-b6f3906e48eb	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	4476c3a6-58da-4c43-9b8a-b1da70172072	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
f31cb806-7262-42d8-9548-73a8dd801ade	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	31a4c844-6a46-4b57-a23d-91d9a5ff7382	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
e4673507-b7f4-49ef-8998-3f694c977645	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	4d6b4184-d62e-427a-ba00-16ff3f4e4f10	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
5a5936c7-0726-4bf6-bccf-3c88ea05c06a	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	06947927-aab0-4d24-b5fe-b42c0b83050c	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
18a5748f-1540-4854-88e6-a2ad12c55a3d	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	6ef0dc2b-9fd6-40e2-a2c6-2485232d953c	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
28372c32-2c9b-449d-a2aa-7ab19ad40982	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	7e8983cd-5a94-49cc-9b80-64358a9d48f9	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
e6f15d13-3c7d-47bf-9175-e2fa26a057b4	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	685d23ad-eadc-47ac-9f91-8f741ae4211f	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
a7ce6824-5b22-44e3-b996-eebcc3b3e832	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	2e599a1f-e34d-436c-98f9-01f019cb29bd	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
e238b908-5586-41f4-965f-618bdfcf5cd7	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	1b63c6c1-36b6-49b5-a61f-1c3f2b85bdb1	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
ea132681-32e3-427a-b5d2-aff630809657	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	44a43cc4-8d2e-4ce5-b437-2b76a205ea84	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
97118cb4-367c-4545-b8b1-37a6ce1c9c16	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	08314805-8508-4254-997b-a035415747d5	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
0a0aa8b7-d615-4781-a4cd-a69a34fd5e17	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	9077e1c0-d24a-4477-983a-6b8aeaa43532	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
58361244-ae2f-4ff3-a3dc-dbf8aff14ef4	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	64be578a-9f8e-4795-aeae-1b5dac189cce	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
a196ebf8-3f77-47be-8ed9-f359edd8ce9e	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	be2ca789-8ed3-4c6f-808a-1dfb50c19877	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
26124278-7fdb-4330-8862-382bee89b26c	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	448cb56a-e4d6-44c4-a49b-8a6119f36843	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
6107d62f-331b-422b-b7d0-7c7b8b9e9a56	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	5a1ffe37-852a-4e75-96c8-5353fdbf9011	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
20f79ba8-6808-42d3-9221-69936dfa641e	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	4680bc8d-b6f0-40e3-ba26-a05e68d21f14	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
36854645-349f-4c2b-85d6-c5cfb4b99a43	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	9ceb0bdb-9f21-40da-b938-c7729ff2daa3	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
d343acfb-4296-463a-89ef-cb8e222f4f4e	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	a48a6338-402d-482e-8d7a-b7193d97047a	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
a7809afe-a1be-464a-a925-a4ebadeb9897	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	55fa8528-6b9c-4f3c-9fb2-6de44c5d9cf0	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
8fd3e487-3f5c-401d-a160-c475f225684b	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	457db1c7-044e-47a7-a820-e1e5114f9cea	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
1893bfc2-04a3-4e33-aca1-357481fab305	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	31509ddf-18ee-4538-a2eb-5bbe560c0914	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
400e9942-be84-4c11-afe1-22f5454afa32	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	698deda3-2aa9-4d4f-8a14-2fb80faac986	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
a58c735e-d23e-451c-b8d6-145844d22acb	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	3f488cd4-bad3-46ec-9f92-1957e2924774	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
d34a9b3e-6a72-4727-8b3d-4836651d5477	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	6dad3ff1-9da6-4efd-9549-e8b4654529c7	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
a31e1cef-04da-4f00-998e-db553086b101	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	74771254-6da7-4ea1-a8b9-7ad3c99d75db	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
d9025171-56bc-46cd-b45c-68a1653a882b	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	a8953d15-fdda-490c-8a8e-1372f25c0a33	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
65f083e4-22b1-4284-8b1a-5cae78340ff0	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	76e855c0-ec81-4eae-a010-0e23b76426f1	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
855a4eb1-9e26-4d07-afcb-55395d50ae5d	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	810f1b09-7630-4260-bf7e-5fa910cbb3dc	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
c520db84-7c41-434d-a3ef-2bb082ebbf6c	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	01c4c2d4-ab2f-480f-b145-442ae56fad48	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
61cd551b-c6f9-45da-a5e8-1cdb8f54cb77	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	2d2976b5-f9bb-42e8-aca0-d6e6b6e6de77	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
6a10e888-471f-4c23-a267-3b4cac352a5b	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	22d1a89c-85d5-4403-8330-e34aa6c8b2fc	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
7101eb35-66f8-4214-bd17-e0224da233a7	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	7082bb51-3094-4606-8f92-106a1820e380	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
dfc97905-3be8-461c-bdc0-021441c5c087	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	101eb49e-efd6-4def-9a1f-11dce221cdba	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
91a41de6-a54c-4fd5-aad1-d1979bb570f3	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	c030fd4f-5f7b-46ad-84b7-631adbeb1f40	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
a8637c90-e8fb-4a46-a458-d30818b65598	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	adbc17f9-6f88-4144-afe1-e29f3a0bd21e	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
7857eaaf-9eb5-486d-978a-c1749a14cf08	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	bcb48067-c6be-4c39-87bc-08618f18ef4e	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
975bb5a5-018f-461e-b38d-cb8418d1a6a6	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	955efb94-7eac-4392-969a-732f19143f89	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
c2997970-77a9-4803-b29c-e5c72ef979f3	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	45cfe4d4-2cc1-4dd3-b5a8-67ecc9d243c9	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
8ac2af5f-2416-45d7-8a00-93a142a8da10	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	cb21ea38-e7ad-4f8d-b4c4-33f892cd9119	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
26c8e6c9-8267-4494-8da9-ffc9bc8485e9	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	3554e4f4-8d4c-4b4a-9fe6-88eb1f5ef489	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
2c972aad-19c1-4ea2-9f58-401bafa2de26	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	f7be1839-a795-438b-b9da-54fed97ca1d7	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
588f5429-f90a-487e-ba8a-11cb589a576b	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	3da28c94-987a-419d-ac12-822d05bd8448	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
c55bcfce-468b-49e4-b83c-dc224ef9670f	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	c42f0ccc-e7e4-447b-b392-ecd3eca5d764	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
fc147feb-a1df-4068-a6f8-70973d13fcac	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	544af37f-9528-4ef3-bc99-5870532c51d5	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
b5f7b831-c637-49c0-a566-86233a5506ce	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	d3660cf9-b4c4-4c12-bba3-766c128a43ac	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
b1fff059-9c46-49d4-9d87-510facc1af80	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	a0ce1af3-fabf-4a1a-851e-edb00cd10f22	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
936e9a47-5a7b-47c6-9e9c-f129f1265e43	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	d69b272d-0f08-4157-8db3-43ba94def224	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
a2beec90-1586-4ac4-9514-016a81ed0a54	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	3e8102b3-e71f-4739-8682-b5ebcbdbd6a5	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
7c68e3a3-92a6-4cae-b063-3fe639d9c2fe	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	cd6c3b70-cdbb-47c6-b1bb-d3236ee53d03	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
582f49e1-5910-4c4b-84c3-c04615f721fc	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	4624333f-29fe-4075-9023-9526c56f1783	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
89707e0e-83ff-47dd-927e-07a9c3600f59	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	2f71659a-9d89-4d70-8319-b6ef85764acf	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
91d11634-2223-417b-9ded-e633fc4a9976	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	f2cb1b7e-41df-411f-abaa-2ac7cbf58674	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
5c7e0798-58eb-4856-b5a0-684c4ad4b10f	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	6f74812e-ca45-4234-9a10-9bfe8f46467c	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
1f10abe3-3de7-4665-b51d-342b086a8617	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	0decb9dd-8b4c-471e-97ab-df29e7bb212c	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
3b9ec234-4d85-44b8-9885-764a9f3d6c3b	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	88fad813-46ed-4601-a334-ae77df797be3	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
7591a91c-064f-4e0b-b15d-bfd6bb2fc4e8	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	9358b2c4-aebc-480a-9eff-6873c156da12	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
e6048820-c473-4458-8536-d3611cb93ec5	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	d5760d32-ce61-48fd-988e-9bd16cc52ca1	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
735a568b-c4e0-4881-aac3-8ee31ade36a1	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	7022a346-204b-472a-b46b-b801f07e8853	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
f01d7deb-b494-4ba0-88fc-bef745b7b9a1	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	c26c7d3d-7062-4ac5-a1f5-a69b17724eaa	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
1d5818cc-16d1-4036-826c-fbdca776c23f	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	6852ffde-5e9e-4faa-be78-93d194b1f8b7	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
eb545adb-0ca6-428b-8473-a5f7a655f9da	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	de38ca59-7d04-4de2-acfd-6daf46162a07	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
1caf2927-4bca-42fd-8111-94d693d3303c	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	6350fa4f-4163-42b7-a37a-16be275b9418	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
9938bbb0-c031-4687-afcc-646231934715	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	7453ffe7-e829-4f52-a16b-44efbc183640	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
e5ce7afe-d44c-458d-99be-92801e355faf	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	fbd8f3d7-1bbe-4e3c-955f-c370b9f7f680	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
309a10d5-0eff-49f8-aeb3-567a4eaf465f	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	569954c7-4f99-425c-9454-45277997273b	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
70825479-d363-4496-a03e-653f95069452	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	13936326-3a08-46e7-9577-cfee038577f0	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
6bf3d925-97dc-48a5-9b4c-26c678ffc351	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	5fd87c78-5e02-4ec6-8706-1a2678ee90b4	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
040f97ba-055a-41fd-922f-1ce0d0cfab09	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	9136ba3e-9c59-47ab-ab64-67a2f84b74f4	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
d49677d7-e848-413f-9515-3a527b5b6c5f	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	47c94861-1830-4e10-97f0-5f0b5a7f9c05	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
26efefca-486c-4507-b9da-d79c699d304f	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	a6fc7ef9-8ebc-47cc-b9b5-48b404599670	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
f0870eab-960b-4564-99c0-3507e8cab591	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	5016201d-732e-4a7f-8e7e-c9d3fa3b2030	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
8a2b035d-3cf1-4ea1-be65-ff2fded77ed9	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	10163f9f-5bb3-4bdc-b3c8-9ddf17b2e3b6	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
b8eae00b-7c43-4616-944f-2ebaf308a4a8	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	0322c72d-2fbf-462d-9a59-76e1550b30d9	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
48dc2700-3d67-4f80-80dc-0ab8826cbf55	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	ec97e568-30d6-4e8f-acb3-b74d1b4b5436	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
7c644ac9-2324-45d4-adf6-70cf1c58f360	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	41ab0a41-f16e-4bd5-961e-5b070acd6410	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
901f81ef-6c9d-48de-a57a-3d3c74c0fb45	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	b2e23679-040c-4d57-9ab7-4a019c00652a	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
10912194-fbba-446e-a7e7-ee3e58c020d4	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	7a0abf02-6038-45d0-9a9d-4d0a25e44019	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
f9755f88-1130-4bf1-9481-152ea09d2b8c	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	b7d67908-6205-4863-a694-d7dba56e1d39	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
73c04fa6-20c8-4f1b-85d9-6c5322449ee2	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	30b71cb1-97df-4655-8704-0560bcf5da06	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
1cb36665-e6e5-4eff-a661-26997d1341ce	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	f658c2c3-3d12-4798-bccb-9af886cd15eb	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
cc357aa7-e912-487b-8192-71f3a4896c97	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	6f903e44-300e-470c-aa64-125da9772880	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
4b56ef4f-1c72-4575-ad02-000eb0688edf	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	24c6259e-6fbf-4a75-a66e-bd8a2894b261	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
73f80d20-1b4c-414c-b841-607ce3fbd2d3	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	a2287dfb-4153-4222-91dd-5ab86abcd82a	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
66dbe64c-c881-4ca3-9c23-966d23e0b316	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	77c73ecd-3988-4efa-af44-efe3725e9f14	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
1467a0ec-6ea4-4702-abf8-77720d678300	94907b83-1c4f-4ed4-8104-597b6924576c	create	microcompetency	3125cce7-fab5-4000-a4ec-d6cb3069e730	\N	100.00	\N	f3ad2fbb-8f8f-4ba4-afb6-b106fa731c76	2025-10-09 05:47:01.888842	{"table": "batch_term_microcompetency_weightages", "migration": true, "operation": "INSERT"}
\.


--
-- Data for Name: weightage_inheritance_rules; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.weightage_inheritance_rules (id, rule_name, rule_type, source_config_id, target_batch_id, target_term_id, inheritance_level, is_active, created_by, created_at) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: -
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2025-06-13 16:51:56
20211116045059	2025-06-13 16:51:57
20211116050929	2025-06-13 16:51:58
20211116051442	2025-06-13 16:51:58
20211116212300	2025-06-13 16:51:59
20211116213355	2025-06-13 16:52:00
20211116213934	2025-06-13 16:52:00
20211116214523	2025-06-13 16:52:01
20211122062447	2025-06-13 16:52:02
20211124070109	2025-06-13 16:52:03
20211202204204	2025-06-13 16:52:03
20211202204605	2025-06-13 16:52:04
20211210212804	2025-06-13 16:52:06
20211228014915	2025-06-13 16:52:07
20220107221237	2025-06-13 16:52:07
20220228202821	2025-06-13 16:52:08
20220312004840	2025-06-13 16:52:09
20220603231003	2025-06-13 16:52:10
20220603232444	2025-06-13 16:52:10
20220615214548	2025-06-13 16:52:11
20220712093339	2025-06-13 16:52:12
20220908172859	2025-06-13 16:52:12
20220916233421	2025-06-13 16:52:13
20230119133233	2025-06-13 16:52:14
20230128025114	2025-06-13 16:52:14
20230128025212	2025-06-13 16:52:15
20230227211149	2025-06-13 16:52:16
20230228184745	2025-06-13 16:52:16
20230308225145	2025-06-13 16:52:17
20230328144023	2025-06-13 16:52:18
20231018144023	2025-06-13 16:52:18
20231204144023	2025-06-13 16:52:19
20231204144024	2025-06-13 16:52:20
20231204144025	2025-06-13 16:52:21
20240108234812	2025-06-13 16:52:21
20240109165339	2025-06-13 16:52:22
20240227174441	2025-06-13 16:52:23
20240311171622	2025-06-13 16:52:24
20240321100241	2025-06-13 16:52:26
20240401105812	2025-06-13 16:52:27
20240418121054	2025-06-13 16:52:28
20240523004032	2025-06-13 16:52:31
20240618124746	2025-06-13 16:52:31
20240801235015	2025-06-13 16:52:32
20240805133720	2025-06-13 16:52:32
20240827160934	2025-06-13 16:52:33
20240919163303	2025-06-13 16:52:34
20240919163305	2025-06-13 16:52:35
20241019105805	2025-06-13 16:52:35
20241030150047	2025-06-13 16:52:38
20241108114728	2025-06-13 16:52:39
20241121104152	2025-06-13 16:52:39
20241130184212	2025-06-13 16:52:40
20241220035512	2025-06-13 16:52:41
20241220123912	2025-06-13 16:52:41
20241224161212	2025-06-13 16:52:42
20250107150512	2025-06-13 16:52:43
20250110162412	2025-06-13 16:52:43
20250123174212	2025-06-13 16:52:44
20250128220012	2025-06-13 16:52:45
20250506224012	2025-06-13 16:52:45
20250523164012	2025-06-13 16:52:46
20250714121412	2025-07-25 04:03:35
20250905041441	2025-10-07 12:52:08
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: -
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at) FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id, type) FROM stdin;
\.


--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.buckets_analytics (id, type, format, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2025-06-13 16:51:53.059172
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2025-06-13 16:51:53.065827
2	storage-schema	5c7968fd083fcea04050c1b7f6253c9771b99011	2025-06-13 16:51:53.068138
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2025-06-13 16:51:53.094354
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2025-06-13 16:51:53.106076
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2025-06-13 16:51:53.10868
6	change-column-name-in-get-size	f93f62afdf6613ee5e7e815b30d02dc990201044	2025-06-13 16:51:53.111701
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2025-06-13 16:51:53.11457
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2025-06-13 16:51:53.117246
9	fix-search-function	3a0af29f42e35a4d101c259ed955b67e1bee6825	2025-06-13 16:51:53.11992
10	search-files-search-function	68dc14822daad0ffac3746a502234f486182ef6e	2025-06-13 16:51:53.124421
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2025-06-13 16:51:53.127472
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2025-06-13 16:51:53.13778
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2025-06-13 16:51:53.14059
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2025-06-13 16:51:53.143307
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2025-06-13 16:51:53.162613
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2025-06-13 16:51:53.165468
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2025-06-13 16:51:53.168212
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2025-06-13 16:51:53.171736
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2025-06-13 16:51:53.177642
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2025-06-13 16:51:53.180654
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2025-06-13 16:51:53.186404
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2025-06-13 16:51:53.196352
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2025-06-13 16:51:53.204657
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2025-06-13 16:51:53.207564
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2025-06-13 16:51:53.210178
26	objects-prefixes	ef3f7871121cdc47a65308e6702519e853422ae2	2025-08-25 16:13:53.116518
27	search-v2	33b8f2a7ae53105f028e13e9fcda9dc4f356b4a2	2025-08-25 16:13:53.709007
28	object-bucket-name-sorting	ba85ec41b62c6a30a3f136788227ee47f311c436	2025-08-25 16:13:54.014445
29	create-prefixes	a7b1a22c0dc3ab630e3055bfec7ce7d2045c5b7b	2025-08-25 16:13:54.118321
30	update-object-levels	6c6f6cc9430d570f26284a24cf7b210599032db7	2025-08-25 16:13:54.307226
31	objects-level-index	33f1fef7ec7fea08bb892222f4f0f5d79bab5eb8	2025-08-25 16:13:55.813395
32	backward-compatible-index-on-objects	2d51eeb437a96868b36fcdfb1ddefdf13bef1647	2025-08-25 16:13:56.520568
33	backward-compatible-index-on-prefixes	fe473390e1b8c407434c0e470655945b110507bf	2025-08-25 16:13:56.808869
34	optimize-search-function-v1	82b0e469a00e8ebce495e29bfa70a0797f7ebd2c	2025-08-25 16:13:56.924119
35	add-insert-trigger-prefixes	63bb9fd05deb3dc5e9fa66c83e82b152f0caf589	2025-08-25 16:13:57.40807
36	optimise-existing-functions	81cf92eb0c36612865a18016a38496c530443899	2025-08-25 16:13:58.306675
37	add-bucket-name-length-trigger	3944135b4e3e8b22d6d4cbb568fe3b0b51df15c1	2025-08-25 16:13:59.404896
38	iceberg-catalog-flag-on-buckets	19a8bd89d5dfa69af7f222a46c726b7c41e462c5	2025-08-25 16:14:00.508804
39	add-search-v2-sort-support	39cf7d1e6bf515f4b02e41237aba845a7b492853	2025-10-07 12:52:06.484697
40	fix-prefix-race-conditions-optimized	fd02297e1c67df25a9fc110bf8c8a9af7fb06d1f	2025-10-07 12:52:06.547533
41	add-object-level-update-trigger	44c22478bf01744b2129efc480cd2edc9a7d60e9	2025-10-07 12:52:06.5773
42	rollback-prefix-triggers	f2ab4f526ab7f979541082992593938c05ee4b47	2025-10-07 12:52:06.583392
43	fix-object-level	ab837ad8f1c7d00cc0b7310e989a23388ff29fc6	2025-10-07 12:52:06.592903
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata, level) FROM stdin;
\.


--
-- Data for Name: prefixes; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.prefixes (bucket_id, name, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: -
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: -
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 1, false);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: -
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- Name: oauth_clients oauth_clients_client_id_key; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_clients
    ADD CONSTRAINT oauth_clients_client_id_key UNIQUE (client_id);


--
-- Name: oauth_clients oauth_clients_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_clients
    ADD CONSTRAINT oauth_clients_pkey PRIMARY KEY (id);


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: admin_audit_log admin_audit_log_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_audit_log
    ADD CONSTRAINT admin_audit_log_pkey PRIMARY KEY (id);


--
-- Name: admins admins_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_pkey PRIMARY KEY (id);


--
-- Name: admins admins_user_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_user_id_key UNIQUE (user_id);


--
-- Name: attendance_eligibility attendance_eligibility_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attendance_eligibility
    ADD CONSTRAINT attendance_eligibility_pkey PRIMARY KEY (id);


--
-- Name: attendance attendance_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_pkey PRIMARY KEY (id);


--
-- Name: attendance_summary attendance_summary_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attendance_summary
    ADD CONSTRAINT attendance_summary_pkey PRIMARY KEY (id);


--
-- Name: audit_logs audit_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_pkey PRIMARY KEY (id);


--
-- Name: batch_term_component_weightages batch_term_component_weightages_config_id_component_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.batch_term_component_weightages
    ADD CONSTRAINT batch_term_component_weightages_config_id_component_id_key UNIQUE (config_id, component_id);


--
-- Name: batch_term_component_weightages batch_term_component_weightages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.batch_term_component_weightages
    ADD CONSTRAINT batch_term_component_weightages_pkey PRIMARY KEY (id);


--
-- Name: batch_term_microcompetency_weightages batch_term_microcompetency_wei_config_id_microcompetency_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.batch_term_microcompetency_weightages
    ADD CONSTRAINT batch_term_microcompetency_wei_config_id_microcompetency_id_key UNIQUE (config_id, microcompetency_id);


--
-- Name: batch_term_microcompetency_weightages batch_term_microcompetency_weightages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.batch_term_microcompetency_weightages
    ADD CONSTRAINT batch_term_microcompetency_weightages_pkey PRIMARY KEY (id);


--
-- Name: batch_term_progression batch_term_progression_batch_id_term_number_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.batch_term_progression
    ADD CONSTRAINT batch_term_progression_batch_id_term_number_key UNIQUE (batch_id, term_number);


--
-- Name: batch_term_progression batch_term_progression_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.batch_term_progression
    ADD CONSTRAINT batch_term_progression_pkey PRIMARY KEY (id);


--
-- Name: batch_term_quadrant_weightages batch_term_quadrant_weightages_config_id_quadrant_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.batch_term_quadrant_weightages
    ADD CONSTRAINT batch_term_quadrant_weightages_config_id_quadrant_id_key UNIQUE (config_id, quadrant_id);


--
-- Name: batch_term_quadrant_weightages batch_term_quadrant_weightages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.batch_term_quadrant_weightages
    ADD CONSTRAINT batch_term_quadrant_weightages_pkey PRIMARY KEY (id);


--
-- Name: batch_term_subcategory_weightages batch_term_subcategory_weightages_config_id_subcategory_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.batch_term_subcategory_weightages
    ADD CONSTRAINT batch_term_subcategory_weightages_config_id_subcategory_id_key UNIQUE (config_id, subcategory_id);


--
-- Name: batch_term_subcategory_weightages batch_term_subcategory_weightages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.batch_term_subcategory_weightages
    ADD CONSTRAINT batch_term_subcategory_weightages_pkey PRIMARY KEY (id);


--
-- Name: batch_term_weightage_config batch_term_weightage_config_batch_id_term_id_is_active_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.batch_term_weightage_config
    ADD CONSTRAINT batch_term_weightage_config_batch_id_term_id_is_active_key UNIQUE (batch_id, term_id, is_active) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: batch_term_weightage_config batch_term_weightage_config_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.batch_term_weightage_config
    ADD CONSTRAINT batch_term_weightage_config_pkey PRIMARY KEY (id);


--
-- Name: batches batches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.batches
    ADD CONSTRAINT batches_pkey PRIMARY KEY (id);


--
-- Name: components components_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.components
    ADD CONSTRAINT components_pkey PRIMARY KEY (id);


--
-- Name: data_imports data_imports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.data_imports
    ADD CONSTRAINT data_imports_pkey PRIMARY KEY (id);


--
-- Name: direct_assessments direct_assessments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.direct_assessments
    ADD CONSTRAINT direct_assessments_pkey PRIMARY KEY (id);


--
-- Name: email_logs email_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.email_logs
    ADD CONSTRAINT email_logs_pkey PRIMARY KEY (id);


--
-- Name: feedback feedback_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT feedback_pkey PRIMARY KEY (id);


--
-- Name: file_uploads file_uploads_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.file_uploads
    ADD CONSTRAINT file_uploads_pkey PRIMARY KEY (id);


--
-- Name: houses houses_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.houses
    ADD CONSTRAINT houses_name_key UNIQUE (name);


--
-- Name: houses houses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.houses
    ADD CONSTRAINT houses_pkey PRIMARY KEY (id);


--
-- Name: hps_calculation_audit hps_calculation_audit_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hps_calculation_audit
    ADD CONSTRAINT hps_calculation_audit_pkey PRIMARY KEY (id);


--
-- Name: intervention_enrollments intervention_enrollments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.intervention_enrollments
    ADD CONSTRAINT intervention_enrollments_pkey PRIMARY KEY (id);


--
-- Name: intervention_microcompetencies intervention_microcompetencies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.intervention_microcompetencies
    ADD CONSTRAINT intervention_microcompetencies_pkey PRIMARY KEY (id);


--
-- Name: intervention_quadrants intervention_quadrants_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.intervention_quadrants
    ADD CONSTRAINT intervention_quadrants_pkey PRIMARY KEY (id);


--
-- Name: intervention_tasks intervention_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.intervention_tasks
    ADD CONSTRAINT intervention_tasks_pkey PRIMARY KEY (id);


--
-- Name: intervention_teachers intervention_teachers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.intervention_teachers
    ADD CONSTRAINT intervention_teachers_pkey PRIMARY KEY (id);


--
-- Name: interventions interventions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.interventions
    ADD CONSTRAINT interventions_pkey PRIMARY KEY (id);


--
-- Name: kos_sync_log kos_sync_log_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.kos_sync_log
    ADD CONSTRAINT kos_sync_log_pkey PRIMARY KEY (id);


--
-- Name: microcompetencies microcompetencies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.microcompetencies
    ADD CONSTRAINT microcompetencies_pkey PRIMARY KEY (id);


--
-- Name: microcompetency_scores microcompetency_scores_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.microcompetency_scores
    ADD CONSTRAINT microcompetency_scores_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: quadrants quadrants_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quadrants
    ADD CONSTRAINT quadrants_pkey PRIMARY KEY (id);


--
-- Name: scores scores_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scores
    ADD CONSTRAINT scores_pkey PRIMARY KEY (id);


--
-- Name: sections sections_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sections
    ADD CONSTRAINT sections_pkey PRIMARY KEY (id);


--
-- Name: shl_integrations shl_integrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shl_integrations
    ADD CONSTRAINT shl_integrations_pkey PRIMARY KEY (id);


--
-- Name: student_improvement_goals student_improvement_goals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_improvement_goals
    ADD CONSTRAINT student_improvement_goals_pkey PRIMARY KEY (id);


--
-- Name: student_improvement_goals student_improvement_goals_student_id_term_id_component_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_improvement_goals
    ADD CONSTRAINT student_improvement_goals_student_id_term_id_component_id_key UNIQUE (student_id, term_id, component_id);


--
-- Name: student_interventions student_interventions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_interventions
    ADD CONSTRAINT student_interventions_pkey PRIMARY KEY (id);


--
-- Name: student_level_progression student_level_progression_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_level_progression
    ADD CONSTRAINT student_level_progression_pkey PRIMARY KEY (id);


--
-- Name: student_level_progression student_level_progression_student_id_term_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_level_progression
    ADD CONSTRAINT student_level_progression_student_id_term_id_key UNIQUE (student_id, term_id);


--
-- Name: student_profile_requests student_profile_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_profile_requests
    ADD CONSTRAINT student_profile_requests_pkey PRIMARY KEY (id);


--
-- Name: student_rankings student_rankings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_rankings
    ADD CONSTRAINT student_rankings_pkey PRIMARY KEY (id);


--
-- Name: student_score_summary student_score_summary_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_score_summary
    ADD CONSTRAINT student_score_summary_pkey PRIMARY KEY (id);


--
-- Name: student_term_progression student_term_progression_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_term_progression
    ADD CONSTRAINT student_term_progression_pkey PRIMARY KEY (id);


--
-- Name: student_term_progression student_term_progression_student_id_term_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_term_progression
    ADD CONSTRAINT student_term_progression_student_id_term_id_key UNIQUE (student_id, term_id);


--
-- Name: student_terms student_terms_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_terms
    ADD CONSTRAINT student_terms_pkey PRIMARY KEY (id);


--
-- Name: students students_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (id);


--
-- Name: students students_registration_no_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_registration_no_key UNIQUE (registration_no);


--
-- Name: students students_user_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_user_id_key UNIQUE (user_id);


--
-- Name: sub_categories sub_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sub_categories
    ADD CONSTRAINT sub_categories_pkey PRIMARY KEY (id);


--
-- Name: system_settings system_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.system_settings
    ADD CONSTRAINT system_settings_pkey PRIMARY KEY (id);


--
-- Name: system_settings system_settings_setting_key_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.system_settings
    ADD CONSTRAINT system_settings_setting_key_key UNIQUE (setting_key);


--
-- Name: task_microcompetencies task_microcompetencies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_microcompetencies
    ADD CONSTRAINT task_microcompetencies_pkey PRIMARY KEY (id);


--
-- Name: task_microcompetencies task_microcompetencies_task_id_microcompetency_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_microcompetencies
    ADD CONSTRAINT task_microcompetencies_task_id_microcompetency_id_key UNIQUE (task_id, microcompetency_id);


--
-- Name: task_submissions task_submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_submissions
    ADD CONSTRAINT task_submissions_pkey PRIMARY KEY (id);


--
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: teacher_assignments teacher_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teacher_assignments
    ADD CONSTRAINT teacher_assignments_pkey PRIMARY KEY (id);


--
-- Name: teacher_microcompetency_assignments teacher_microcompetency_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teacher_microcompetency_assignments
    ADD CONSTRAINT teacher_microcompetency_assignments_pkey PRIMARY KEY (id);


--
-- Name: teachers teachers_employee_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT teachers_employee_id_key UNIQUE (employee_id);


--
-- Name: teachers teachers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT teachers_pkey PRIMARY KEY (id);


--
-- Name: teachers teachers_user_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT teachers_user_id_key UNIQUE (user_id);


--
-- Name: term_lifecycle_events term_lifecycle_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.term_lifecycle_events
    ADD CONSTRAINT term_lifecycle_events_pkey PRIMARY KEY (id);


--
-- Name: terms terms_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.terms
    ADD CONSTRAINT terms_pkey PRIMARY KEY (id);


--
-- Name: attendance_summary uk_attendance_summary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attendance_summary
    ADD CONSTRAINT uk_attendance_summary UNIQUE (student_id, term_id, quadrant_id);


--
-- Name: attendance uk_attendance_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT uk_attendance_unique UNIQUE (student_id, term_id, quadrant_id, attendance_date);


--
-- Name: batches uk_batch_name_year; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.batches
    ADD CONSTRAINT uk_batch_name_year UNIQUE (name, year);


--
-- Name: direct_assessments uk_direct_assessment; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.direct_assessments
    ADD CONSTRAINT uk_direct_assessment UNIQUE (task_id, student_id);


--
-- Name: intervention_enrollments uk_intervention_enrollment; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.intervention_enrollments
    ADD CONSTRAINT uk_intervention_enrollment UNIQUE (intervention_id, student_id);


--
-- Name: intervention_microcompetencies uk_intervention_microcompetency; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.intervention_microcompetencies
    ADD CONSTRAINT uk_intervention_microcompetency UNIQUE (intervention_id, microcompetency_id);


--
-- Name: intervention_quadrants uk_intervention_quadrant; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.intervention_quadrants
    ADD CONSTRAINT uk_intervention_quadrant UNIQUE (intervention_id, quadrant_id);


--
-- Name: intervention_teachers uk_intervention_teacher; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.intervention_teachers
    ADD CONSTRAINT uk_intervention_teacher UNIQUE (intervention_id, teacher_id);


--
-- Name: scores uk_score_student_component_term; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scores
    ADD CONSTRAINT uk_score_student_component_term UNIQUE (student_id, component_id, term_id);


--
-- Name: sections uk_section_batch_name; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sections
    ADD CONSTRAINT uk_section_batch_name UNIQUE (batch_id, name);


--
-- Name: shl_integrations uk_shl_student; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shl_integrations
    ADD CONSTRAINT uk_shl_student UNIQUE (student_id);


--
-- Name: shl_integrations uk_shl_user_id; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shl_integrations
    ADD CONSTRAINT uk_shl_user_id UNIQUE (shl_user_id);


--
-- Name: microcompetency_scores uk_student_intervention_microcompetency; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.microcompetency_scores
    ADD CONSTRAINT uk_student_intervention_microcompetency UNIQUE (student_id, intervention_id, microcompetency_id);


--
-- Name: student_terms uk_student_term; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_terms
    ADD CONSTRAINT uk_student_term UNIQUE (student_id, term_id);


--
-- Name: task_submissions uk_task_submission; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_submissions
    ADD CONSTRAINT uk_task_submission UNIQUE (task_id, student_id);


--
-- Name: teacher_microcompetency_assignments uk_teacher_micro_assignment; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teacher_microcompetency_assignments
    ADD CONSTRAINT uk_teacher_micro_assignment UNIQUE (intervention_id, teacher_id, microcompetency_id);


--
-- Name: teacher_assignments uk_teacher_student_term_quadrant; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teacher_assignments
    ADD CONSTRAINT uk_teacher_student_term_quadrant UNIQUE (teacher_id, student_id, term_id, quadrant_id);


--
-- Name: direct_assessments unique_student_task_term; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.direct_assessments
    ADD CONSTRAINT unique_student_task_term UNIQUE (student_id, task_id, term_id);


--
-- Name: student_score_summary unique_student_term_summary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_score_summary
    ADD CONSTRAINT unique_student_term_summary UNIQUE (student_id, term_id);


--
-- Name: user_sessions user_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_sessions
    ADD CONSTRAINT user_sessions_pkey PRIMARY KEY (id);


--
-- Name: user_sessions user_sessions_refresh_token_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_sessions
    ADD CONSTRAINT user_sessions_refresh_token_key UNIQUE (refresh_token);


--
-- Name: user_sessions user_sessions_session_token_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_sessions
    ADD CONSTRAINT user_sessions_session_token_key UNIQUE (session_token);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: weightage_change_audit weightage_change_audit_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.weightage_change_audit
    ADD CONSTRAINT weightage_change_audit_pkey PRIMARY KEY (id);


--
-- Name: weightage_inheritance_rules weightage_inheritance_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.weightage_inheritance_rules
    ADD CONSTRAINT weightage_inheritance_rules_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: buckets_analytics buckets_analytics_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.buckets_analytics
    ADD CONSTRAINT buckets_analytics_pkey PRIMARY KEY (id);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: prefixes prefixes_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.prefixes
    ADD CONSTRAINT prefixes_pkey PRIMARY KEY (bucket_id, level, name);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- Name: oauth_clients_client_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX oauth_clients_client_id_idx ON auth.oauth_clients USING btree (client_id);


--
-- Name: oauth_clients_deleted_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX oauth_clients_deleted_at_idx ON auth.oauth_clients USING btree (deleted_at);


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- Name: sso_providers_resource_id_pattern_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX sso_providers_resource_id_pattern_idx ON auth.sso_providers USING btree (resource_id text_pattern_ops);


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- Name: idx_admin_audit_admin_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_admin_audit_admin_id ON public.admin_audit_log USING btree (admin_id);


--
-- Name: idx_admin_audit_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_admin_audit_created_at ON public.admin_audit_log USING btree (created_at);


--
-- Name: idx_admin_audit_target_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_admin_audit_target_user ON public.admin_audit_log USING btree (target_user_id);


--
-- Name: idx_attendance_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_attendance_date ON public.attendance USING btree (attendance_date);


--
-- Name: idx_attendance_eligibility_student_term; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_attendance_eligibility_student_term ON public.attendance_eligibility USING btree (student_id, term_id);


--
-- Name: idx_attendance_eligibility_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_attendance_eligibility_unique ON public.attendance_eligibility USING btree (student_id, term_id, attendance_type, COALESCE(component_id, '00000000-0000-0000-0000-000000000000'::uuid));


--
-- Name: idx_attendance_quadrant; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_attendance_quadrant ON public.attendance USING btree (quadrant_id);


--
-- Name: idx_attendance_student_term; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_attendance_student_term ON public.attendance USING btree (student_id, term_id);


--
-- Name: idx_attendance_student_term_quadrant; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_attendance_student_term_quadrant ON public.attendance USING btree (student_id, term_id, quadrant_id);


--
-- Name: idx_attendance_summary_percentage; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_attendance_summary_percentage ON public.attendance_summary USING btree (percentage);


--
-- Name: idx_attendance_summary_quadrant; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_attendance_summary_quadrant ON public.attendance_summary USING btree (quadrant_id);


--
-- Name: idx_attendance_summary_student; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_attendance_summary_student ON public.attendance_summary USING btree (student_id);


--
-- Name: idx_attendance_summary_term; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_attendance_summary_term ON public.attendance_summary USING btree (term_id);


--
-- Name: idx_audit_logs_action; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_audit_logs_action ON public.audit_logs USING btree (action);


--
-- Name: idx_audit_logs_created; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_audit_logs_created ON public.audit_logs USING btree (created_at);


--
-- Name: idx_audit_logs_entity; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_audit_logs_entity ON public.audit_logs USING btree (entity_type, entity_id);


--
-- Name: idx_audit_logs_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_audit_logs_user ON public.audit_logs USING btree (user_id);


--
-- Name: idx_batch_term_component_weightages_component; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_batch_term_component_weightages_component ON public.batch_term_component_weightages USING btree (component_id);


--
-- Name: idx_batch_term_component_weightages_config; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_batch_term_component_weightages_config ON public.batch_term_component_weightages USING btree (config_id);


--
-- Name: idx_batch_term_microcompetency_weightages_config; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_batch_term_microcompetency_weightages_config ON public.batch_term_microcompetency_weightages USING btree (config_id);


--
-- Name: idx_batch_term_microcompetency_weightages_microcompetency; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_batch_term_microcompetency_weightages_microcompetency ON public.batch_term_microcompetency_weightages USING btree (microcompetency_id);


--
-- Name: idx_batch_term_progression_batch_term; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_batch_term_progression_batch_term ON public.batch_term_progression USING btree (batch_id, term_number);


--
-- Name: idx_batch_term_quadrant_weightages_config; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_batch_term_quadrant_weightages_config ON public.batch_term_quadrant_weightages USING btree (config_id);


--
-- Name: idx_batch_term_quadrant_weightages_quadrant; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_batch_term_quadrant_weightages_quadrant ON public.batch_term_quadrant_weightages USING btree (quadrant_id);


--
-- Name: idx_batch_term_subcategory_weightages_config; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_batch_term_subcategory_weightages_config ON public.batch_term_subcategory_weightages USING btree (config_id);


--
-- Name: idx_batch_term_subcategory_weightages_subcategory; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_batch_term_subcategory_weightages_subcategory ON public.batch_term_subcategory_weightages USING btree (subcategory_id);


--
-- Name: idx_batch_term_weightage_config_active; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_batch_term_weightage_config_active ON public.batch_term_weightage_config USING btree (is_active);


--
-- Name: idx_batch_term_weightage_config_batch_term; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_batch_term_weightage_config_batch_term ON public.batch_term_weightage_config USING btree (batch_id, term_id);


--
-- Name: idx_batches_active; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_batches_active ON public.batches USING btree (is_active);


--
-- Name: idx_batches_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_batches_status ON public.batches USING btree (batch_status);


--
-- Name: idx_batches_year; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_batches_year ON public.batches USING btree (year);


--
-- Name: idx_components_category; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_components_category ON public.components USING btree (category);


--
-- Name: idx_components_order; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_components_order ON public.components USING btree (display_order);


--
-- Name: idx_components_subcategory; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_components_subcategory ON public.components USING btree (sub_category_id);


--
-- Name: idx_data_imports_created; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_data_imports_created ON public.data_imports USING btree (created_at);


--
-- Name: idx_data_imports_importer; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_data_imports_importer ON public.data_imports USING btree (imported_by);


--
-- Name: idx_data_imports_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_data_imports_status ON public.data_imports USING btree (status);


--
-- Name: idx_data_imports_term; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_data_imports_term ON public.data_imports USING btree (term_id);


--
-- Name: idx_data_imports_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_data_imports_type ON public.data_imports USING btree (import_type);


--
-- Name: idx_direct_assessments_assessed_by; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_direct_assessments_assessed_by ON public.direct_assessments USING btree (assessed_by);


--
-- Name: idx_direct_assessments_student; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_direct_assessments_student ON public.direct_assessments USING btree (student_id);


--
-- Name: idx_direct_assessments_student_term; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_direct_assessments_student_term ON public.direct_assessments USING btree (student_id, term_id);


--
-- Name: idx_direct_assessments_task; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_direct_assessments_task ON public.direct_assessments USING btree (task_id);


--
-- Name: idx_direct_assessments_term; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_direct_assessments_term ON public.direct_assessments USING btree (term_id);


--
-- Name: idx_email_logs_created; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_email_logs_created ON public.email_logs USING btree (created_at);


--
-- Name: idx_email_logs_recipient; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_email_logs_recipient ON public.email_logs USING btree (recipient_email);


--
-- Name: idx_email_logs_sent; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_email_logs_sent ON public.email_logs USING btree (sent_at);


--
-- Name: idx_email_logs_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_email_logs_status ON public.email_logs USING btree (status);


--
-- Name: idx_email_logs_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_email_logs_type ON public.email_logs USING btree (email_type);


--
-- Name: idx_email_logs_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_email_logs_user ON public.email_logs USING btree (recipient_user_id);


--
-- Name: idx_feedback_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_feedback_status ON public.feedback USING btree (status);


--
-- Name: idx_feedback_student; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_feedback_student ON public.feedback USING btree (student_id);


--
-- Name: idx_feedback_teacher; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_feedback_teacher ON public.feedback USING btree (teacher_id);


--
-- Name: idx_file_uploads_created; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_file_uploads_created ON public.file_uploads USING btree (created_at);


--
-- Name: idx_file_uploads_entity; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_file_uploads_entity ON public.file_uploads USING btree (entity_type, entity_id);


--
-- Name: idx_file_uploads_hash; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_file_uploads_hash ON public.file_uploads USING btree (file_hash);


--
-- Name: idx_file_uploads_purpose; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_file_uploads_purpose ON public.file_uploads USING btree (upload_purpose);


--
-- Name: idx_file_uploads_uploader; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_file_uploads_uploader ON public.file_uploads USING btree (uploaded_by);


--
-- Name: idx_houses_active; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_houses_active ON public.houses USING btree (is_active);


--
-- Name: idx_hps_calculation_audit_student_term; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_hps_calculation_audit_student_term ON public.hps_calculation_audit USING btree (student_id, term_id, calculated_at DESC);


--
-- Name: idx_hps_calculation_audit_trigger; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_hps_calculation_audit_trigger ON public.hps_calculation_audit USING btree (trigger_type, calculated_at DESC);


--
-- Name: idx_intervention_enrollments_intervention; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_intervention_enrollments_intervention ON public.intervention_enrollments USING btree (intervention_id);


--
-- Name: idx_intervention_enrollments_intervention_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_intervention_enrollments_intervention_status ON public.intervention_enrollments USING btree (intervention_id, enrollment_status);


--
-- Name: idx_intervention_enrollments_student; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_intervention_enrollments_student ON public.intervention_enrollments USING btree (student_id);


--
-- Name: idx_intervention_microcompetencies_intervention; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_intervention_microcompetencies_intervention ON public.intervention_microcompetencies USING btree (intervention_id);


--
-- Name: idx_intervention_microcompetencies_microcompetency; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_intervention_microcompetencies_microcompetency ON public.intervention_microcompetencies USING btree (microcompetency_id);


--
-- Name: idx_intervention_quadrants_intervention; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_intervention_quadrants_intervention ON public.intervention_quadrants USING btree (intervention_id);


--
-- Name: idx_intervention_quadrants_quadrant; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_intervention_quadrants_quadrant ON public.intervention_quadrants USING btree (quadrant_id);


--
-- Name: idx_intervention_teachers_intervention; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_intervention_teachers_intervention ON public.intervention_teachers USING btree (intervention_id);


--
-- Name: idx_intervention_teachers_teacher; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_intervention_teachers_teacher ON public.intervention_teachers USING btree (teacher_id);


--
-- Name: idx_interventions_creator; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_interventions_creator ON public.interventions USING btree (created_by);


--
-- Name: idx_interventions_dates; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_interventions_dates ON public.interventions USING btree (start_date, end_date);


--
-- Name: idx_interventions_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_interventions_status ON public.interventions USING btree (status);


--
-- Name: idx_microcompetencies_active; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_microcompetencies_active ON public.microcompetencies USING btree (is_active);


--
-- Name: idx_microcompetencies_component; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_microcompetencies_component ON public.microcompetencies USING btree (component_id);


--
-- Name: idx_microcompetencies_order; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_microcompetencies_order ON public.microcompetencies USING btree (display_order);


--
-- Name: idx_microcompetency_scores_intervention; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_microcompetency_scores_intervention ON public.microcompetency_scores USING btree (intervention_id);


--
-- Name: idx_microcompetency_scores_microcompetency; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_microcompetency_scores_microcompetency ON public.microcompetency_scores USING btree (microcompetency_id);


--
-- Name: idx_microcompetency_scores_student; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_microcompetency_scores_student ON public.microcompetency_scores USING btree (student_id);


--
-- Name: idx_microcompetency_scores_student_term; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_microcompetency_scores_student_term ON public.microcompetency_scores USING btree (student_id, term_id);


--
-- Name: idx_microcompetency_scores_teacher; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_microcompetency_scores_teacher ON public.microcompetency_scores USING btree (scored_by);


--
-- Name: idx_microcompetency_scores_term; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_microcompetency_scores_term ON public.microcompetency_scores USING btree (term_id);


--
-- Name: idx_notifications_created; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_notifications_created ON public.notifications USING btree (created_at);


--
-- Name: idx_notifications_unread; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_notifications_unread ON public.notifications USING btree (user_id, is_read);


--
-- Name: idx_notifications_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_notifications_user ON public.notifications USING btree (user_id);


--
-- Name: idx_profile_requests_created; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_profile_requests_created ON public.student_profile_requests USING btree (created_at);


--
-- Name: idx_profile_requests_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_profile_requests_status ON public.student_profile_requests USING btree (status);


--
-- Name: idx_profile_requests_student; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_profile_requests_student ON public.student_profile_requests USING btree (student_id);


--
-- Name: idx_quadrants_active; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_quadrants_active ON public.quadrants USING btree (is_active);


--
-- Name: idx_quadrants_order; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_quadrants_order ON public.quadrants USING btree (display_order);


--
-- Name: idx_scores_assessor; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_scores_assessor ON public.scores USING btree (assessed_by);


--
-- Name: idx_scores_component; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_scores_component ON public.scores USING btree (component_id);


--
-- Name: idx_scores_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_scores_date ON public.scores USING btree (assessment_date);


--
-- Name: idx_scores_student_term; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_scores_student_term ON public.scores USING btree (student_id, term_id);


--
-- Name: idx_scores_student_term_component; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_scores_student_term_component ON public.scores USING btree (student_id, term_id, component_id);


--
-- Name: idx_scores_term_component_score; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_scores_term_component_score ON public.scores USING btree (term_id, component_id, obtained_score DESC);


--
-- Name: idx_sections_batch; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_sections_batch ON public.sections USING btree (batch_id);


--
-- Name: idx_sessions_active; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_sessions_active ON public.user_sessions USING btree (is_active);


--
-- Name: idx_sessions_expires; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_sessions_expires ON public.user_sessions USING btree (expires_at);


--
-- Name: idx_sessions_token; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_sessions_token ON public.user_sessions USING btree (session_token);


--
-- Name: idx_sessions_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_sessions_user_id ON public.user_sessions USING btree (user_id);


--
-- Name: idx_settings_category; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_settings_category ON public.system_settings USING btree (category);


--
-- Name: idx_settings_public; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_settings_public ON public.system_settings USING btree (is_public);


--
-- Name: idx_shl_integrations_shl_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_shl_integrations_shl_user ON public.shl_integrations USING btree (shl_user_id);


--
-- Name: idx_shl_integrations_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_shl_integrations_status ON public.shl_integrations USING btree (sync_status);


--
-- Name: idx_shl_integrations_sync; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_shl_integrations_sync ON public.shl_integrations USING btree (last_sync_at);


--
-- Name: idx_student_level_progression_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_student_level_progression_status ON public.student_level_progression USING btree (progression_status);


--
-- Name: idx_student_level_progression_student; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_student_level_progression_student ON public.student_level_progression USING btree (student_id);


--
-- Name: idx_student_level_progression_term; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_student_level_progression_term ON public.student_level_progression USING btree (term_id);


--
-- Name: idx_student_rankings_student_term; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_student_rankings_student_term ON public.student_rankings USING btree (student_id, term_id);


--
-- Name: idx_student_rankings_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_student_rankings_unique ON public.student_rankings USING btree (student_id, term_id, COALESCE(quadrant_id, 'overall'::character varying), ranking_type);


--
-- Name: idx_student_score_summary_student; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_student_score_summary_student ON public.student_score_summary USING btree (student_id);


--
-- Name: idx_student_score_summary_term; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_student_score_summary_term ON public.student_score_summary USING btree (term_id);


--
-- Name: idx_student_term_progression_student_term; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_student_term_progression_student_term ON public.student_term_progression USING btree (student_id, term_id);


--
-- Name: idx_student_terms_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_student_terms_status ON public.student_terms USING btree (enrollment_status);


--
-- Name: idx_student_terms_term; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_student_terms_term ON public.student_terms USING btree (term_id);


--
-- Name: idx_student_terms_term_score; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_student_terms_term_score ON public.student_terms USING btree (term_id, total_score DESC);


--
-- Name: idx_students_batch_section; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_students_batch_section ON public.students USING btree (batch_id, section_id);


--
-- Name: idx_students_house; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_students_house ON public.students USING btree (house_id);


--
-- Name: idx_students_registration; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_students_registration ON public.students USING btree (registration_no);


--
-- Name: idx_students_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_students_status ON public.students USING btree (status);


--
-- Name: idx_subcategories_order; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_subcategories_order ON public.sub_categories USING btree (display_order);


--
-- Name: idx_subcategories_quadrant; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_subcategories_quadrant ON public.sub_categories USING btree (quadrant_id);


--
-- Name: idx_task_microcompetencies_micro; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_task_microcompetencies_micro ON public.task_microcompetencies USING btree (microcompetency_id);


--
-- Name: idx_task_microcompetencies_microcompetency; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_task_microcompetencies_microcompetency ON public.task_microcompetencies USING btree (microcompetency_id);


--
-- Name: idx_task_microcompetencies_task; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_task_microcompetencies_task ON public.task_microcompetencies USING btree (task_id);


--
-- Name: idx_task_submissions_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_task_submissions_status ON public.task_submissions USING btree (status);


--
-- Name: idx_task_submissions_student; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_task_submissions_student ON public.task_submissions USING btree (student_id);


--
-- Name: idx_task_submissions_task; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_task_submissions_task ON public.task_submissions USING btree (task_id);


--
-- Name: idx_tasks_due_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_tasks_due_date ON public.tasks USING btree (due_date);


--
-- Name: idx_tasks_intervention; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_tasks_intervention ON public.tasks USING btree (intervention_id);


--
-- Name: idx_tasks_intervention_status_due; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_tasks_intervention_status_due ON public.tasks USING btree (intervention_id, status, due_date);


--
-- Name: idx_tasks_quadrant; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_tasks_quadrant ON public.tasks USING btree (quadrant_id);


--
-- Name: idx_tasks_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_tasks_status ON public.tasks USING btree (status);


--
-- Name: idx_teacher_assignments_active; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_teacher_assignments_active ON public.teacher_assignments USING btree (is_active);


--
-- Name: idx_teacher_assignments_quadrant; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_teacher_assignments_quadrant ON public.teacher_assignments USING btree (quadrant_id);


--
-- Name: idx_teacher_assignments_student; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_teacher_assignments_student ON public.teacher_assignments USING btree (student_id);


--
-- Name: idx_teacher_assignments_teacher; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_teacher_assignments_teacher ON public.teacher_assignments USING btree (teacher_id);


--
-- Name: idx_teacher_assignments_term; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_teacher_assignments_term ON public.teacher_assignments USING btree (term_id);


--
-- Name: idx_teacher_micro_assignments_intervention; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_teacher_micro_assignments_intervention ON public.teacher_microcompetency_assignments USING btree (intervention_id);


--
-- Name: idx_teacher_micro_assignments_microcompetency; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_teacher_micro_assignments_microcompetency ON public.teacher_microcompetency_assignments USING btree (microcompetency_id);


--
-- Name: idx_teacher_micro_assignments_teacher; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_teacher_micro_assignments_teacher ON public.teacher_microcompetency_assignments USING btree (teacher_id);


--
-- Name: idx_teachers_employee_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_teachers_employee_id ON public.teachers USING btree (employee_id);


--
-- Name: idx_teachers_specialization; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_teachers_specialization ON public.teachers USING btree (specialization);


--
-- Name: idx_terms_active; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_terms_active ON public.terms USING btree (is_active);


--
-- Name: idx_terms_current; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_terms_current ON public.terms USING btree (is_current);


--
-- Name: idx_terms_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_terms_status ON public.terms USING btree (term_status);


--
-- Name: idx_terms_term_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_terms_term_number ON public.terms USING btree (term_number);


--
-- Name: idx_terms_year; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_terms_year ON public.terms USING btree (academic_year);


--
-- Name: idx_users_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_users_email ON public.users USING btree (email);


--
-- Name: idx_users_microsoft_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_users_microsoft_id ON public.users USING btree (microsoft_id) WHERE (microsoft_id IS NOT NULL);


--
-- Name: idx_users_role; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_users_role ON public.users USING btree (role);


--
-- Name: idx_users_username; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_users_username ON public.users USING btree (username);


--
-- Name: idx_weightage_change_audit_config; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_weightage_change_audit_config ON public.weightage_change_audit USING btree (config_id);


--
-- Name: idx_weightage_change_audit_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_weightage_change_audit_date ON public.weightage_change_audit USING btree (changed_at);


--
-- Name: idx_weightage_change_audit_entity; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_weightage_change_audit_entity ON public.weightage_change_audit USING btree (entity_type, entity_id);


--
-- Name: idx_weightage_change_audit_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_weightage_change_audit_type ON public.weightage_change_audit USING btree (change_type);


--
-- Name: idx_weightage_inheritance_rules_active; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_weightage_inheritance_rules_active ON public.weightage_inheritance_rules USING btree (is_active);


--
-- Name: idx_weightage_inheritance_rules_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_weightage_inheritance_rules_type ON public.weightage_inheritance_rules USING btree (rule_type);


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: -
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- Name: messages_inserted_at_topic_index; Type: INDEX; Schema: realtime; Owner: -
--

CREATE INDEX messages_inserted_at_topic_index ON ONLY realtime.messages USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: subscription_subscription_id_entity_filters_key; Type: INDEX; Schema: realtime; Owner: -
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_key ON realtime.subscription USING btree (subscription_id, entity, filters);


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: -
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- Name: idx_name_bucket_level_unique; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX idx_name_bucket_level_unique ON storage.objects USING btree (name COLLATE "C", bucket_id, level);


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: -
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- Name: idx_objects_lower_name; Type: INDEX; Schema: storage; Owner: -
--

CREATE INDEX idx_objects_lower_name ON storage.objects USING btree ((path_tokens[level]), lower(name) text_pattern_ops, bucket_id, level);


--
-- Name: idx_prefixes_lower_name; Type: INDEX; Schema: storage; Owner: -
--

CREATE INDEX idx_prefixes_lower_name ON storage.prefixes USING btree (bucket_id, level, ((string_to_array(name, '/'::text))[level]), lower(name) text_pattern_ops);


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: -
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- Name: objects_bucket_id_level_idx; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX objects_bucket_id_level_idx ON storage.objects USING btree (bucket_id, level, name COLLATE "C");


--
-- Name: batch_term_component_weightages audit_component_weightages; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER audit_component_weightages AFTER INSERT OR DELETE OR UPDATE ON public.batch_term_component_weightages FOR EACH ROW EXECUTE FUNCTION public.audit_weightage_changes();


--
-- Name: batch_term_microcompetency_weightages audit_microcompetency_weightages; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER audit_microcompetency_weightages AFTER INSERT OR DELETE OR UPDATE ON public.batch_term_microcompetency_weightages FOR EACH ROW EXECUTE FUNCTION public.audit_weightage_changes();


--
-- Name: batch_term_quadrant_weightages audit_quadrant_weightages; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER audit_quadrant_weightages AFTER INSERT OR DELETE OR UPDATE ON public.batch_term_quadrant_weightages FOR EACH ROW EXECUTE FUNCTION public.audit_weightage_changes();


--
-- Name: batch_term_subcategory_weightages audit_subcategory_weightages; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER audit_subcategory_weightages AFTER INSERT OR DELETE OR UPDATE ON public.batch_term_subcategory_weightages FOR EACH ROW EXECUTE FUNCTION public.audit_weightage_changes();


--
-- Name: microcompetency_scores trigger_recalculate_scores; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trigger_recalculate_scores AFTER INSERT OR DELETE OR UPDATE ON public.microcompetency_scores FOR EACH ROW EXECUTE FUNCTION public.recalculate_student_scores();


--
-- Name: microcompetency_scores trigger_update_enrollment_scores; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trigger_update_enrollment_scores AFTER INSERT OR DELETE OR UPDATE ON public.microcompetency_scores FOR EACH ROW EXECUTE FUNCTION public.update_enrollment_scores();


--
-- Name: microcompetency_scores trigger_update_student_overall_score; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trigger_update_student_overall_score AFTER INSERT OR DELETE OR UPDATE ON public.microcompetency_scores FOR EACH ROW EXECUTE FUNCTION public.update_student_overall_score();


--
-- Name: users trigger_user_role_change; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trigger_user_role_change AFTER UPDATE OF role ON public.users FOR EACH ROW EXECUTE FUNCTION public.handle_user_role_change();


--
-- Name: components update_components_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_components_updated_at BEFORE UPDATE ON public.components FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: interventions update_interventions_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_interventions_updated_at BEFORE UPDATE ON public.interventions FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: microcompetencies update_microcompetencies_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_microcompetencies_updated_at BEFORE UPDATE ON public.microcompetencies FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: scores update_scores_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_scores_updated_at BEFORE UPDATE ON public.scores FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: shl_integrations update_shl_integrations_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_shl_integrations_updated_at BEFORE UPDATE ON public.shl_integrations FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: students update_students_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_students_updated_at BEFORE UPDATE ON public.students FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: sub_categories update_sub_categories_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_sub_categories_updated_at BEFORE UPDATE ON public.sub_categories FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: tasks update_tasks_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_tasks_updated_at BEFORE UPDATE ON public.tasks FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: teachers update_teachers_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_teachers_updated_at BEFORE UPDATE ON public.teachers FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: users update_users_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON public.users FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: -
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- Name: buckets enforce_bucket_name_length_trigger; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER enforce_bucket_name_length_trigger BEFORE INSERT OR UPDATE OF name ON storage.buckets FOR EACH ROW EXECUTE FUNCTION storage.enforce_bucket_name_length();


--
-- Name: objects objects_delete_delete_prefix; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER objects_delete_delete_prefix AFTER DELETE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.delete_prefix_hierarchy_trigger();


--
-- Name: objects objects_insert_create_prefix; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER objects_insert_create_prefix BEFORE INSERT ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.objects_insert_prefix_trigger();


--
-- Name: objects objects_update_create_prefix; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER objects_update_create_prefix BEFORE UPDATE ON storage.objects FOR EACH ROW WHEN (((new.name <> old.name) OR (new.bucket_id <> old.bucket_id))) EXECUTE FUNCTION storage.objects_update_prefix_trigger();


--
-- Name: prefixes prefixes_create_hierarchy; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER prefixes_create_hierarchy BEFORE INSERT ON storage.prefixes FOR EACH ROW WHEN ((pg_trigger_depth() < 1)) EXECUTE FUNCTION storage.prefixes_insert_trigger();


--
-- Name: prefixes prefixes_delete_hierarchy; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER prefixes_delete_hierarchy AFTER DELETE ON storage.prefixes FOR EACH ROW EXECUTE FUNCTION storage.delete_prefix_hierarchy_trigger();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: admin_audit_log admin_audit_log_admin_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_audit_log
    ADD CONSTRAINT admin_audit_log_admin_id_fkey FOREIGN KEY (admin_id) REFERENCES public.users(id);


--
-- Name: admin_audit_log admin_audit_log_target_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_audit_log
    ADD CONSTRAINT admin_audit_log_target_user_id_fkey FOREIGN KEY (target_user_id) REFERENCES public.users(id);


--
-- Name: admins admins_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: attendance_eligibility attendance_eligibility_component_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attendance_eligibility
    ADD CONSTRAINT attendance_eligibility_component_id_fkey FOREIGN KEY (component_id) REFERENCES public.components(id);


--
-- Name: attendance_eligibility attendance_eligibility_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attendance_eligibility
    ADD CONSTRAINT attendance_eligibility_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(id) ON DELETE CASCADE;


--
-- Name: attendance_eligibility attendance_eligibility_term_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attendance_eligibility
    ADD CONSTRAINT attendance_eligibility_term_id_fkey FOREIGN KEY (term_id) REFERENCES public.terms(id) ON DELETE CASCADE;


--
-- Name: attendance attendance_marked_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_marked_by_fkey FOREIGN KEY (marked_by) REFERENCES public.users(id) ON DELETE RESTRICT;


--
-- Name: attendance attendance_quadrant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_quadrant_id_fkey FOREIGN KEY (quadrant_id) REFERENCES public.quadrants(id) ON DELETE CASCADE;


--
-- Name: attendance attendance_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(id) ON DELETE CASCADE;


--
-- Name: attendance_summary attendance_summary_quadrant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attendance_summary
    ADD CONSTRAINT attendance_summary_quadrant_id_fkey FOREIGN KEY (quadrant_id) REFERENCES public.quadrants(id) ON DELETE CASCADE;


--
-- Name: attendance_summary attendance_summary_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attendance_summary
    ADD CONSTRAINT attendance_summary_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(id) ON DELETE CASCADE;


--
-- Name: attendance_summary attendance_summary_term_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attendance_summary
    ADD CONSTRAINT attendance_summary_term_id_fkey FOREIGN KEY (term_id) REFERENCES public.terms(id) ON DELETE CASCADE;


--
-- Name: attendance attendance_term_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_term_id_fkey FOREIGN KEY (term_id) REFERENCES public.terms(id) ON DELETE CASCADE;


--
-- Name: audit_logs audit_logs_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: batch_term_component_weightages batch_term_component_weightages_component_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.batch_term_component_weightages
    ADD CONSTRAINT batch_term_component_weightages_component_id_fkey FOREIGN KEY (component_id) REFERENCES public.components(id);


--
-- Name: batch_term_component_weightages batch_term_component_weightages_config_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.batch_term_component_weightages
    ADD CONSTRAINT batch_term_component_weightages_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.batch_term_weightage_config(id) ON DELETE CASCADE;


--
-- Name: batch_term_microcompetency_weightages batch_term_microcompetency_weightages_config_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.batch_term_microcompetency_weightages
    ADD CONSTRAINT batch_term_microcompetency_weightages_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.batch_term_weightage_config(id) ON DELETE CASCADE;


--
-- Name: batch_term_microcompetency_weightages batch_term_microcompetency_weightages_microcompetency_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.batch_term_microcompetency_weightages
    ADD CONSTRAINT batch_term_microcompetency_weightages_microcompetency_id_fkey FOREIGN KEY (microcompetency_id) REFERENCES public.microcompetencies(id);


--
-- Name: batch_term_progression batch_term_progression_batch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.batch_term_progression
    ADD CONSTRAINT batch_term_progression_batch_id_fkey FOREIGN KEY (batch_id) REFERENCES public.batches(id) ON DELETE CASCADE;


--
-- Name: batch_term_progression batch_term_progression_term_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.batch_term_progression
    ADD CONSTRAINT batch_term_progression_term_id_fkey FOREIGN KEY (term_id) REFERENCES public.terms(id) ON DELETE CASCADE;


--
-- Name: batch_term_quadrant_weightages batch_term_quadrant_weightages_config_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.batch_term_quadrant_weightages
    ADD CONSTRAINT batch_term_quadrant_weightages_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.batch_term_weightage_config(id) ON DELETE CASCADE;


--
-- Name: batch_term_quadrant_weightages batch_term_quadrant_weightages_quadrant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.batch_term_quadrant_weightages
    ADD CONSTRAINT batch_term_quadrant_weightages_quadrant_id_fkey FOREIGN KEY (quadrant_id) REFERENCES public.quadrants(id);


--
-- Name: batch_term_subcategory_weightages batch_term_subcategory_weightages_config_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.batch_term_subcategory_weightages
    ADD CONSTRAINT batch_term_subcategory_weightages_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.batch_term_weightage_config(id) ON DELETE CASCADE;


--
-- Name: batch_term_subcategory_weightages batch_term_subcategory_weightages_subcategory_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.batch_term_subcategory_weightages
    ADD CONSTRAINT batch_term_subcategory_weightages_subcategory_id_fkey FOREIGN KEY (subcategory_id) REFERENCES public.sub_categories(id);


--
-- Name: batch_term_weightage_config batch_term_weightage_config_batch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.batch_term_weightage_config
    ADD CONSTRAINT batch_term_weightage_config_batch_id_fkey FOREIGN KEY (batch_id) REFERENCES public.batches(id) ON DELETE CASCADE;


--
-- Name: batch_term_weightage_config batch_term_weightage_config_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.batch_term_weightage_config
    ADD CONSTRAINT batch_term_weightage_config_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: batch_term_weightage_config batch_term_weightage_config_term_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.batch_term_weightage_config
    ADD CONSTRAINT batch_term_weightage_config_term_id_fkey FOREIGN KEY (term_id) REFERENCES public.terms(id) ON DELETE CASCADE;


--
-- Name: components components_sub_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.components
    ADD CONSTRAINT components_sub_category_id_fkey FOREIGN KEY (sub_category_id) REFERENCES public.sub_categories(id) ON DELETE CASCADE;


--
-- Name: data_imports data_imports_imported_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.data_imports
    ADD CONSTRAINT data_imports_imported_by_fkey FOREIGN KEY (imported_by) REFERENCES public.users(id) ON DELETE RESTRICT;


--
-- Name: data_imports data_imports_term_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.data_imports
    ADD CONSTRAINT data_imports_term_id_fkey FOREIGN KEY (term_id) REFERENCES public.terms(id) ON DELETE SET NULL;


--
-- Name: direct_assessments direct_assessments_assessed_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.direct_assessments
    ADD CONSTRAINT direct_assessments_assessed_by_fkey FOREIGN KEY (assessed_by) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: direct_assessments direct_assessments_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.direct_assessments
    ADD CONSTRAINT direct_assessments_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(id) ON DELETE CASCADE;


--
-- Name: direct_assessments direct_assessments_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.direct_assessments
    ADD CONSTRAINT direct_assessments_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.tasks(id) ON DELETE CASCADE;


--
-- Name: direct_assessments direct_assessments_term_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.direct_assessments
    ADD CONSTRAINT direct_assessments_term_id_fkey FOREIGN KEY (term_id) REFERENCES public.terms(id) ON DELETE CASCADE;


--
-- Name: email_logs email_logs_recipient_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.email_logs
    ADD CONSTRAINT email_logs_recipient_user_id_fkey FOREIGN KEY (recipient_user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: feedback feedback_resolved_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT feedback_resolved_by_fkey FOREIGN KEY (resolved_by) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: feedback feedback_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT feedback_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(id) ON DELETE CASCADE;


--
-- Name: feedback feedback_teacher_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT feedback_teacher_id_fkey FOREIGN KEY (teacher_id) REFERENCES public.teachers(id) ON DELETE SET NULL;


--
-- Name: file_uploads file_uploads_uploaded_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.file_uploads
    ADD CONSTRAINT file_uploads_uploaded_by_fkey FOREIGN KEY (uploaded_by) REFERENCES public.users(id) ON DELETE RESTRICT;


--
-- Name: hps_calculation_audit hps_calculation_audit_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hps_calculation_audit
    ADD CONSTRAINT hps_calculation_audit_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(id) ON DELETE CASCADE;


--
-- Name: hps_calculation_audit hps_calculation_audit_term_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hps_calculation_audit
    ADD CONSTRAINT hps_calculation_audit_term_id_fkey FOREIGN KEY (term_id) REFERENCES public.terms(id) ON DELETE CASCADE;


--
-- Name: intervention_enrollments intervention_enrollments_enrolled_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.intervention_enrollments
    ADD CONSTRAINT intervention_enrollments_enrolled_by_fkey FOREIGN KEY (enrolled_by) REFERENCES public.users(id) ON DELETE RESTRICT;


--
-- Name: intervention_enrollments intervention_enrollments_intervention_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.intervention_enrollments
    ADD CONSTRAINT intervention_enrollments_intervention_id_fkey FOREIGN KEY (intervention_id) REFERENCES public.interventions(id) ON DELETE CASCADE;


--
-- Name: intervention_enrollments intervention_enrollments_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.intervention_enrollments
    ADD CONSTRAINT intervention_enrollments_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(id) ON DELETE CASCADE;


--
-- Name: intervention_microcompetencies intervention_microcompetencies_intervention_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.intervention_microcompetencies
    ADD CONSTRAINT intervention_microcompetencies_intervention_id_fkey FOREIGN KEY (intervention_id) REFERENCES public.interventions(id) ON DELETE CASCADE;


--
-- Name: intervention_microcompetencies intervention_microcompetencies_microcompetency_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.intervention_microcompetencies
    ADD CONSTRAINT intervention_microcompetencies_microcompetency_id_fkey FOREIGN KEY (microcompetency_id) REFERENCES public.microcompetencies(id) ON DELETE CASCADE;


--
-- Name: intervention_quadrants intervention_quadrants_intervention_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.intervention_quadrants
    ADD CONSTRAINT intervention_quadrants_intervention_id_fkey FOREIGN KEY (intervention_id) REFERENCES public.interventions(id) ON DELETE CASCADE;


--
-- Name: intervention_quadrants intervention_quadrants_quadrant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.intervention_quadrants
    ADD CONSTRAINT intervention_quadrants_quadrant_id_fkey FOREIGN KEY (quadrant_id) REFERENCES public.quadrants(id) ON DELETE CASCADE;


--
-- Name: intervention_tasks intervention_tasks_intervention_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.intervention_tasks
    ADD CONSTRAINT intervention_tasks_intervention_id_fkey FOREIGN KEY (intervention_id) REFERENCES public.interventions(id);


--
-- Name: intervention_teachers intervention_teachers_assigned_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.intervention_teachers
    ADD CONSTRAINT intervention_teachers_assigned_by_fkey FOREIGN KEY (assigned_by) REFERENCES public.users(id) ON DELETE RESTRICT;


--
-- Name: intervention_teachers intervention_teachers_intervention_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.intervention_teachers
    ADD CONSTRAINT intervention_teachers_intervention_id_fkey FOREIGN KEY (intervention_id) REFERENCES public.interventions(id) ON DELETE CASCADE;


--
-- Name: intervention_teachers intervention_teachers_teacher_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.intervention_teachers
    ADD CONSTRAINT intervention_teachers_teacher_id_fkey FOREIGN KEY (teacher_id) REFERENCES public.teachers(id) ON DELETE CASCADE;


--
-- Name: interventions interventions_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.interventions
    ADD CONSTRAINT interventions_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id) ON DELETE RESTRICT;


--
-- Name: interventions interventions_term_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.interventions
    ADD CONSTRAINT interventions_term_id_fkey FOREIGN KEY (term_id) REFERENCES public.terms(id) ON DELETE SET NULL;


--
-- Name: kos_sync_log kos_sync_log_triggered_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.kos_sync_log
    ADD CONSTRAINT kos_sync_log_triggered_by_fkey FOREIGN KEY (triggered_by) REFERENCES public.users(id);


--
-- Name: microcompetencies microcompetencies_component_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.microcompetencies
    ADD CONSTRAINT microcompetencies_component_id_fkey FOREIGN KEY (component_id) REFERENCES public.components(id) ON DELETE CASCADE;


--
-- Name: microcompetency_scores microcompetency_scores_intervention_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.microcompetency_scores
    ADD CONSTRAINT microcompetency_scores_intervention_id_fkey FOREIGN KEY (intervention_id) REFERENCES public.interventions(id) ON DELETE CASCADE;


--
-- Name: microcompetency_scores microcompetency_scores_microcompetency_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.microcompetency_scores
    ADD CONSTRAINT microcompetency_scores_microcompetency_id_fkey FOREIGN KEY (microcompetency_id) REFERENCES public.microcompetencies(id) ON DELETE CASCADE;


--
-- Name: microcompetency_scores microcompetency_scores_scored_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.microcompetency_scores
    ADD CONSTRAINT microcompetency_scores_scored_by_fkey FOREIGN KEY (scored_by) REFERENCES public.teachers(id) ON DELETE RESTRICT;


--
-- Name: microcompetency_scores microcompetency_scores_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.microcompetency_scores
    ADD CONSTRAINT microcompetency_scores_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(id) ON DELETE CASCADE;


--
-- Name: microcompetency_scores microcompetency_scores_term_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.microcompetency_scores
    ADD CONSTRAINT microcompetency_scores_term_id_fkey FOREIGN KEY (term_id) REFERENCES public.terms(id) ON DELETE CASCADE;


--
-- Name: notifications notifications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: scores scores_assessed_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scores
    ADD CONSTRAINT scores_assessed_by_fkey FOREIGN KEY (assessed_by) REFERENCES public.users(id) ON DELETE RESTRICT;


--
-- Name: scores scores_component_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scores
    ADD CONSTRAINT scores_component_id_fkey FOREIGN KEY (component_id) REFERENCES public.components(id) ON DELETE CASCADE;


--
-- Name: scores scores_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scores
    ADD CONSTRAINT scores_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(id) ON DELETE CASCADE;


--
-- Name: scores scores_term_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scores
    ADD CONSTRAINT scores_term_id_fkey FOREIGN KEY (term_id) REFERENCES public.terms(id) ON DELETE CASCADE;


--
-- Name: sections sections_batch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sections
    ADD CONSTRAINT sections_batch_id_fkey FOREIGN KEY (batch_id) REFERENCES public.batches(id) ON DELETE CASCADE;


--
-- Name: shl_integrations shl_integrations_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shl_integrations
    ADD CONSTRAINT shl_integrations_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(id) ON DELETE CASCADE;


--
-- Name: student_improvement_goals student_improvement_goals_component_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_improvement_goals
    ADD CONSTRAINT student_improvement_goals_component_id_fkey FOREIGN KEY (component_id) REFERENCES public.components(id) ON DELETE CASCADE;


--
-- Name: student_improvement_goals student_improvement_goals_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_improvement_goals
    ADD CONSTRAINT student_improvement_goals_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(id) ON DELETE CASCADE;


--
-- Name: student_improvement_goals student_improvement_goals_term_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_improvement_goals
    ADD CONSTRAINT student_improvement_goals_term_id_fkey FOREIGN KEY (term_id) REFERENCES public.terms(id) ON DELETE CASCADE;


--
-- Name: student_interventions student_interventions_intervention_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_interventions
    ADD CONSTRAINT student_interventions_intervention_id_fkey FOREIGN KEY (intervention_id) REFERENCES public.interventions(id);


--
-- Name: student_interventions student_interventions_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_interventions
    ADD CONSTRAINT student_interventions_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(id);


--
-- Name: student_level_progression student_level_progression_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_level_progression
    ADD CONSTRAINT student_level_progression_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(id) ON DELETE CASCADE;


--
-- Name: student_level_progression student_level_progression_term_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_level_progression
    ADD CONSTRAINT student_level_progression_term_id_fkey FOREIGN KEY (term_id) REFERENCES public.terms(id) ON DELETE CASCADE;


--
-- Name: student_profile_requests student_profile_requests_requested_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_profile_requests
    ADD CONSTRAINT student_profile_requests_requested_by_fkey FOREIGN KEY (requested_by) REFERENCES public.users(id);


--
-- Name: student_profile_requests student_profile_requests_reviewed_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_profile_requests
    ADD CONSTRAINT student_profile_requests_reviewed_by_fkey FOREIGN KEY (reviewed_by) REFERENCES public.users(id);


--
-- Name: student_profile_requests student_profile_requests_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_profile_requests
    ADD CONSTRAINT student_profile_requests_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(id) ON DELETE CASCADE;


--
-- Name: student_rankings student_rankings_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_rankings
    ADD CONSTRAINT student_rankings_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(id) ON DELETE CASCADE;


--
-- Name: student_rankings student_rankings_term_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_rankings
    ADD CONSTRAINT student_rankings_term_id_fkey FOREIGN KEY (term_id) REFERENCES public.terms(id) ON DELETE CASCADE;


--
-- Name: student_score_summary student_score_summary_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_score_summary
    ADD CONSTRAINT student_score_summary_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(id) ON DELETE CASCADE;


--
-- Name: student_score_summary student_score_summary_term_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_score_summary
    ADD CONSTRAINT student_score_summary_term_id_fkey FOREIGN KEY (term_id) REFERENCES public.terms(id) ON DELETE CASCADE;


--
-- Name: student_term_progression student_term_progression_batch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_term_progression
    ADD CONSTRAINT student_term_progression_batch_id_fkey FOREIGN KEY (batch_id) REFERENCES public.batches(id) ON DELETE CASCADE;


--
-- Name: student_term_progression student_term_progression_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_term_progression
    ADD CONSTRAINT student_term_progression_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(id) ON DELETE CASCADE;


--
-- Name: student_term_progression student_term_progression_term_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_term_progression
    ADD CONSTRAINT student_term_progression_term_id_fkey FOREIGN KEY (term_id) REFERENCES public.terms(id) ON DELETE CASCADE;


--
-- Name: student_terms student_terms_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_terms
    ADD CONSTRAINT student_terms_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(id) ON DELETE CASCADE;


--
-- Name: student_terms student_terms_term_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_terms
    ADD CONSTRAINT student_terms_term_id_fkey FOREIGN KEY (term_id) REFERENCES public.terms(id) ON DELETE CASCADE;


--
-- Name: students students_batch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_batch_id_fkey FOREIGN KEY (batch_id) REFERENCES public.batches(id) ON DELETE RESTRICT;


--
-- Name: students students_current_term_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_current_term_id_fkey FOREIGN KEY (current_term_id) REFERENCES public.terms(id);


--
-- Name: students students_house_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_house_id_fkey FOREIGN KEY (house_id) REFERENCES public.houses(id) ON DELETE SET NULL;


--
-- Name: students students_section_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_section_id_fkey FOREIGN KEY (section_id) REFERENCES public.sections(id) ON DELETE RESTRICT;


--
-- Name: students students_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: sub_categories sub_categories_quadrant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sub_categories
    ADD CONSTRAINT sub_categories_quadrant_id_fkey FOREIGN KEY (quadrant_id) REFERENCES public.quadrants(id) ON DELETE CASCADE;


--
-- Name: system_settings system_settings_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.system_settings
    ADD CONSTRAINT system_settings_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.users(id) ON DELETE RESTRICT;


--
-- Name: task_microcompetencies task_microcompetencies_microcompetency_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_microcompetencies
    ADD CONSTRAINT task_microcompetencies_microcompetency_id_fkey FOREIGN KEY (microcompetency_id) REFERENCES public.microcompetencies(id) ON DELETE CASCADE;


--
-- Name: task_microcompetencies task_microcompetencies_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_microcompetencies
    ADD CONSTRAINT task_microcompetencies_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.tasks(id) ON DELETE CASCADE;


--
-- Name: task_submissions task_submissions_graded_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_submissions
    ADD CONSTRAINT task_submissions_graded_by_fkey FOREIGN KEY (graded_by) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: task_submissions task_submissions_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_submissions
    ADD CONSTRAINT task_submissions_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(id) ON DELETE CASCADE;


--
-- Name: task_submissions task_submissions_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_submissions
    ADD CONSTRAINT task_submissions_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.tasks(id) ON DELETE CASCADE;


--
-- Name: tasks tasks_component_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_component_id_fkey FOREIGN KEY (component_id) REFERENCES public.components(id) ON DELETE RESTRICT;


--
-- Name: tasks tasks_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id) ON DELETE RESTRICT;


--
-- Name: tasks tasks_created_by_teacher_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_created_by_teacher_id_fkey FOREIGN KEY (created_by_teacher_id) REFERENCES public.teachers(id);


--
-- Name: tasks tasks_intervention_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_intervention_id_fkey FOREIGN KEY (intervention_id) REFERENCES public.interventions(id) ON DELETE CASCADE;


--
-- Name: tasks tasks_microcompetency_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_microcompetency_id_fkey FOREIGN KEY (microcompetency_id) REFERENCES public.microcompetencies(id) ON DELETE CASCADE;


--
-- Name: tasks tasks_quadrant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_quadrant_id_fkey FOREIGN KEY (quadrant_id) REFERENCES public.quadrants(id) ON DELETE RESTRICT;


--
-- Name: teacher_assignments teacher_assignments_assigned_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teacher_assignments
    ADD CONSTRAINT teacher_assignments_assigned_by_fkey FOREIGN KEY (assigned_by) REFERENCES public.users(id) ON DELETE RESTRICT;


--
-- Name: teacher_assignments teacher_assignments_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teacher_assignments
    ADD CONSTRAINT teacher_assignments_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(id) ON DELETE CASCADE;


--
-- Name: teacher_assignments teacher_assignments_teacher_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teacher_assignments
    ADD CONSTRAINT teacher_assignments_teacher_id_fkey FOREIGN KEY (teacher_id) REFERENCES public.teachers(id) ON DELETE CASCADE;


--
-- Name: teacher_assignments teacher_assignments_term_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teacher_assignments
    ADD CONSTRAINT teacher_assignments_term_id_fkey FOREIGN KEY (term_id) REFERENCES public.terms(id) ON DELETE CASCADE;


--
-- Name: teacher_microcompetency_assignments teacher_microcompetency_assignments_assigned_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teacher_microcompetency_assignments
    ADD CONSTRAINT teacher_microcompetency_assignments_assigned_by_fkey FOREIGN KEY (assigned_by) REFERENCES public.users(id) ON DELETE RESTRICT;


--
-- Name: teacher_microcompetency_assignments teacher_microcompetency_assignments_intervention_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teacher_microcompetency_assignments
    ADD CONSTRAINT teacher_microcompetency_assignments_intervention_id_fkey FOREIGN KEY (intervention_id) REFERENCES public.interventions(id) ON DELETE CASCADE;


--
-- Name: teacher_microcompetency_assignments teacher_microcompetency_assignments_microcompetency_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teacher_microcompetency_assignments
    ADD CONSTRAINT teacher_microcompetency_assignments_microcompetency_id_fkey FOREIGN KEY (microcompetency_id) REFERENCES public.microcompetencies(id) ON DELETE CASCADE;


--
-- Name: teacher_microcompetency_assignments teacher_microcompetency_assignments_teacher_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teacher_microcompetency_assignments
    ADD CONSTRAINT teacher_microcompetency_assignments_teacher_id_fkey FOREIGN KEY (teacher_id) REFERENCES public.teachers(id) ON DELETE CASCADE;


--
-- Name: teachers teachers_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT teachers_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: term_lifecycle_events term_lifecycle_events_batch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.term_lifecycle_events
    ADD CONSTRAINT term_lifecycle_events_batch_id_fkey FOREIGN KEY (batch_id) REFERENCES public.batches(id);


--
-- Name: term_lifecycle_events term_lifecycle_events_term_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.term_lifecycle_events
    ADD CONSTRAINT term_lifecycle_events_term_id_fkey FOREIGN KEY (term_id) REFERENCES public.terms(id) ON DELETE CASCADE;


--
-- Name: term_lifecycle_events term_lifecycle_events_triggered_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.term_lifecycle_events
    ADD CONSTRAINT term_lifecycle_events_triggered_by_fkey FOREIGN KEY (triggered_by) REFERENCES public.users(id);


--
-- Name: user_sessions user_sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_sessions
    ADD CONSTRAINT user_sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: weightage_change_audit weightage_change_audit_changed_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.weightage_change_audit
    ADD CONSTRAINT weightage_change_audit_changed_by_fkey FOREIGN KEY (changed_by) REFERENCES public.users(id);


--
-- Name: weightage_change_audit weightage_change_audit_config_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.weightage_change_audit
    ADD CONSTRAINT weightage_change_audit_config_id_fkey FOREIGN KEY (config_id) REFERENCES public.batch_term_weightage_config(id);


--
-- Name: weightage_inheritance_rules weightage_inheritance_rules_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.weightage_inheritance_rules
    ADD CONSTRAINT weightage_inheritance_rules_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: weightage_inheritance_rules weightage_inheritance_rules_source_config_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.weightage_inheritance_rules
    ADD CONSTRAINT weightage_inheritance_rules_source_config_id_fkey FOREIGN KEY (source_config_id) REFERENCES public.batch_term_weightage_config(id);


--
-- Name: weightage_inheritance_rules weightage_inheritance_rules_target_batch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.weightage_inheritance_rules
    ADD CONSTRAINT weightage_inheritance_rules_target_batch_id_fkey FOREIGN KEY (target_batch_id) REFERENCES public.batches(id);


--
-- Name: weightage_inheritance_rules weightage_inheritance_rules_target_term_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.weightage_inheritance_rules
    ADD CONSTRAINT weightage_inheritance_rules_target_term_id_fkey FOREIGN KEY (target_term_id) REFERENCES public.terms(id);


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: prefixes prefixes_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.prefixes
    ADD CONSTRAINT "prefixes_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: -
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_analytics; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.buckets_analytics ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- Name: prefixes; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.prefixes ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: -
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


--
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


--
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


--
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


--
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


--
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


--
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


--
-- PostgreSQL database dump complete
--

\unrestrict 4McNB2baXDF1EoWjacDYR10hCIHA0PZcrjSysIqWCa7Qeka8ZvpVPkWhKsGBADf

