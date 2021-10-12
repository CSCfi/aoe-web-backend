--
-- PostgreSQL database dump
--

-- Dumped from database version 12.3 (Debian 12.3-1.pgdg100+1)
-- Dumped by pg_dump version 12.3 (Debian 12.3-1.pgdg100+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: lang; Type: TYPE; Schema: public; Owner: aoe_admin
--

CREATE TYPE public.lang AS ENUM (
    'fi',
    'en',
    'sv'
);


ALTER TYPE public.lang OWNER TO aoe_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: accessibilityapi; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.accessibilityapi (
    id bigint NOT NULL,
    value text NOT NULL,
    educationalmaterialid bigint NOT NULL
);


ALTER TABLE public.accessibilityapi OWNER TO aoe_admin;

--
-- Name: accessibilityapi_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.accessibilityapi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accessibilityapi_id_seq OWNER TO aoe_admin;

--
-- Name: accessibilityapi_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.accessibilityapi_id_seq OWNED BY public.accessibilityapi.id;


--
-- Name: accessibilitycontrol; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.accessibilitycontrol (
    id bigint NOT NULL,
    value text NOT NULL,
    educationalmaterialid bigint NOT NULL
);


ALTER TABLE public.accessibilitycontrol OWNER TO aoe_admin;

--
-- Name: accessibilitycontrol_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.accessibilitycontrol_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accessibilitycontrol_id_seq OWNER TO aoe_admin;

--
-- Name: accessibilitycontrol_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.accessibilitycontrol_id_seq OWNED BY public.accessibilitycontrol.id;


--
-- Name: accessibilityfeature; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.accessibilityfeature (
    id bigint NOT NULL,
    value text NOT NULL,
    educationalmaterialid bigint NOT NULL,
    accessibilityfeaturekey text NOT NULL
);


ALTER TABLE public.accessibilityfeature OWNER TO aoe_admin;

--
-- Name: accessibilityfeature_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.accessibilityfeature_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accessibilityfeature_id_seq OWNER TO aoe_admin;

--
-- Name: accessibilityfeature_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.accessibilityfeature_id_seq OWNED BY public.accessibilityfeature.id;


--
-- Name: accessibilityfeatureextension; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.accessibilityfeatureextension (
    id bigint NOT NULL,
    value text NOT NULL,
    accessibilityfeaturekey text NOT NULL,
    educationalmaterialid bigint NOT NULL,
    usersusername text NOT NULL
);


ALTER TABLE public.accessibilityfeatureextension OWNER TO aoe_admin;

--
-- Name: accessibilityfeatureextension_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.accessibilityfeatureextension_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accessibilityfeatureextension_id_seq OWNER TO aoe_admin;

--
-- Name: accessibilityfeatureextension_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.accessibilityfeatureextension_id_seq OWNED BY public.accessibilityfeatureextension.id;


--
-- Name: accessibilityhazard; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.accessibilityhazard (
    id bigint NOT NULL,
    value text NOT NULL,
    educationalmaterialid bigint NOT NULL,
    accessibilityhazardkey text NOT NULL
);


ALTER TABLE public.accessibilityhazard OWNER TO aoe_admin;

--
-- Name: accessibilityhazard_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.accessibilityhazard_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accessibilityhazard_id_seq OWNER TO aoe_admin;

--
-- Name: accessibilityhazard_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.accessibilityhazard_id_seq OWNED BY public.accessibilityhazard.id;


--
-- Name: accessibilityhazardextension; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.accessibilityhazardextension (
    id bigint NOT NULL,
    value text NOT NULL,
    accessibilityhazardkey text NOT NULL,
    educationalmaterialid bigint NOT NULL,
    usersusername text NOT NULL
);


ALTER TABLE public.accessibilityhazardextension OWNER TO aoe_admin;

--
-- Name: accessibilityhazardextension_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.accessibilityhazardextension_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accessibilityhazardextension_id_seq OWNER TO aoe_admin;

--
-- Name: accessibilityhazardextension_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.accessibilityhazardextension_id_seq OWNED BY public.accessibilityhazardextension.id;


--
-- Name: alignmentobject; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.alignmentobject (
    id bigint NOT NULL,
    educationalmaterialid bigint NOT NULL,
    alignmenttype text NOT NULL,
    targetname text NOT NULL,
    source text NOT NULL,
    educationalframework text DEFAULT ''::text NOT NULL,
    objectkey text NOT NULL,
    targeturl text
);


ALTER TABLE public.alignmentobject OWNER TO aoe_admin;

--
-- Name: alignmentobject_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.alignmentobject_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alignmentobject_id_seq OWNER TO aoe_admin;

--
-- Name: alignmentobject_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.alignmentobject_id_seq OWNED BY public.alignmentobject.id;


--
-- Name: aoeuser; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.aoeuser (
    username text NOT NULL
);


ALTER TABLE public.aoeuser OWNER TO aoe_admin;

--
-- Name: attachment; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.attachment (
    id bigint NOT NULL,
    filepath text,
    originalfilename text NOT NULL,
    filesize integer NOT NULL,
    mimetype text NOT NULL,
    format text NOT NULL,
    filekey text,
    filebucket text,
    defaultfile boolean NOT NULL,
    kind text NOT NULL,
    label text NOT NULL,
    srclang text NOT NULL,
    materialid bigint NOT NULL,
    obsoleted integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.attachment OWNER TO aoe_admin;

--
-- Name: attachment_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.attachment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.attachment_id_seq OWNER TO aoe_admin;

--
-- Name: attachment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.attachment_id_seq OWNED BY public.attachment.id;


--
-- Name: attachmentversioncomposition; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.attachmentversioncomposition (
    versioneducationalmaterialid bigint NOT NULL,
    versionmaterialid bigint NOT NULL,
    versionpublishedat timestamp without time zone NOT NULL,
    attachmentid bigint NOT NULL
);


ALTER TABLE public.attachmentversioncomposition OWNER TO aoe_admin;

--
-- Name: author; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.author (
    id bigint NOT NULL,
    authorname text NOT NULL,
    organization text NOT NULL,
    educationalmaterialid bigint NOT NULL,
    organizationkey text NOT NULL
);


ALTER TABLE public.author OWNER TO aoe_admin;

--
-- Name: author_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.author_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.author_id_seq OWNER TO aoe_admin;

--
-- Name: author_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.author_id_seq OWNED BY public.author.id;


--
-- Name: collection; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.collection (
    id bigint NOT NULL,
    createdat timestamp with time zone NOT NULL,
    updatedat timestamp with time zone,
    publishedat timestamp with time zone,
    createdby text NOT NULL,
    agerangemin integer,
    agerangemax integer,
    collectionname character varying(255) NOT NULL,
    description character varying(2000)
);


ALTER TABLE public.collection OWNER TO aoe_admin;

--
-- Name: collection_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.collection_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.collection_id_seq OWNER TO aoe_admin;

--
-- Name: collection_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.collection_id_seq OWNED BY public.collection.id;


--
-- Name: collectionaccessibilityfeature; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.collectionaccessibilityfeature (
    id integer NOT NULL,
    value text NOT NULL,
    accessibilityfeaturekey text NOT NULL,
    collectionid bigint NOT NULL
);


ALTER TABLE public.collectionaccessibilityfeature OWNER TO aoe_admin;

--
-- Name: collectionaccessibilityfeature_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.collectionaccessibilityfeature_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.collectionaccessibilityfeature_id_seq OWNER TO aoe_admin;

--
-- Name: collectionaccessibilityfeature_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.collectionaccessibilityfeature_id_seq OWNED BY public.collectionaccessibilityfeature.id;


--
-- Name: collectionaccessibilityhazard; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.collectionaccessibilityhazard (
    id bigint NOT NULL,
    value text NOT NULL,
    accessibilityhazardkey text NOT NULL,
    collectionid bigint NOT NULL
);


ALTER TABLE public.collectionaccessibilityhazard OWNER TO aoe_admin;

--
-- Name: collectionaccessibilityhazard_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.collectionaccessibilityhazard_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.collectionaccessibilityhazard_id_seq OWNER TO aoe_admin;

--
-- Name: collectionaccessibilityhazard_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.collectionaccessibilityhazard_id_seq OWNED BY public.collectionaccessibilityhazard.id;


--
-- Name: collectionalignmentobject; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.collectionalignmentobject (
    id bigint NOT NULL,
    alignmenttype text NOT NULL,
    collectionid bigint NOT NULL,
    targetname text NOT NULL,
    source text NOT NULL,
    educationalframework text,
    objectkey text NOT NULL,
    targeturl text
);


ALTER TABLE public.collectionalignmentobject OWNER TO aoe_admin;

--
-- Name: collectionalignmentobject_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.collectionalignmentobject_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.collectionalignmentobject_id_seq OWNER TO aoe_admin;

--
-- Name: collectionalignmentobject_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.collectionalignmentobject_id_seq OWNED BY public.collectionalignmentobject.id;


--
-- Name: collectioneducationalaudience; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.collectioneducationalaudience (
    id bigint NOT NULL,
    educationalrole text NOT NULL,
    collectionid bigint NOT NULL,
    educationalrolekey text NOT NULL
);


ALTER TABLE public.collectioneducationalaudience OWNER TO aoe_admin;

--
-- Name: collectioneducationalaudience_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.collectioneducationalaudience_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.collectioneducationalaudience_id_seq OWNER TO aoe_admin;

--
-- Name: collectioneducationalaudience_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.collectioneducationalaudience_id_seq OWNED BY public.collectioneducationalaudience.id;


--
-- Name: collectioneducationallevel; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.collectioneducationallevel (
    id bigint NOT NULL,
    educationallevelkey text NOT NULL,
    collectionid bigint NOT NULL,
    value text NOT NULL
);


ALTER TABLE public.collectioneducationallevel OWNER TO aoe_admin;

--
-- Name: collectioneducationallevel_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.collectioneducationallevel_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.collectioneducationallevel_id_seq OWNER TO aoe_admin;

--
-- Name: collectioneducationallevel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.collectioneducationallevel_id_seq OWNED BY public.collectioneducationallevel.id;


--
-- Name: collectioneducationalmaterial; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.collectioneducationalmaterial (
    collectionid bigint NOT NULL,
    educationalmaterialid bigint NOT NULL,
    priority integer DEFAULT 999 NOT NULL
);


ALTER TABLE public.collectioneducationalmaterial OWNER TO aoe_admin;

--
-- Name: collectioneducationaluse; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.collectioneducationaluse (
    id bigint NOT NULL,
    educationalusekey text NOT NULL,
    collectionid bigint NOT NULL,
    value text NOT NULL
);


ALTER TABLE public.collectioneducationaluse OWNER TO aoe_admin;

--
-- Name: collectioneducationaluse_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.collectioneducationaluse_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.collectioneducationaluse_id_seq OWNER TO aoe_admin;

--
-- Name: collectioneducationaluse_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.collectioneducationaluse_id_seq OWNED BY public.collectioneducationaluse.id;


--
-- Name: collectionheading; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.collectionheading (
    id bigint NOT NULL,
    heading character varying(255) NOT NULL,
    description character varying(2000),
    priority integer DEFAULT 999 NOT NULL,
    collectionid bigint NOT NULL
);


ALTER TABLE public.collectionheading OWNER TO aoe_admin;

--
-- Name: collectionheading_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.collectionheading_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.collectionheading_id_seq OWNER TO aoe_admin;

--
-- Name: collectionheading_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.collectionheading_id_seq OWNED BY public.collectionheading.id;


--
-- Name: collectionkeyword; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.collectionkeyword (
    id bigint NOT NULL,
    value text NOT NULL,
    collectionid bigint NOT NULL,
    keywordkey text NOT NULL
);


ALTER TABLE public.collectionkeyword OWNER TO aoe_admin;

--
-- Name: collectionkeyword_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.collectionkeyword_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.collectionkeyword_id_seq OWNER TO aoe_admin;

--
-- Name: collectionkeyword_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.collectionkeyword_id_seq OWNED BY public.collectionkeyword.id;


--
-- Name: collectionlanguage; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.collectionlanguage (
    id bigint NOT NULL,
    language text NOT NULL,
    collectionid bigint NOT NULL
);


ALTER TABLE public.collectionlanguage OWNER TO aoe_admin;

--
-- Name: collectionlanguage_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.collectionlanguage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.collectionlanguage_id_seq OWNER TO aoe_admin;

--
-- Name: collectionlanguage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.collectionlanguage_id_seq OWNED BY public.collectionlanguage.id;


--
-- Name: collectionthumbnail; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.collectionthumbnail (
    id bigint NOT NULL,
    filepath text NOT NULL,
    mimetype text NOT NULL,
    filename text NOT NULL,
    obsoleted integer DEFAULT 0 NOT NULL,
    filekey text NOT NULL,
    filebucket text NOT NULL,
    collectionid bigint NOT NULL
);


ALTER TABLE public.collectionthumbnail OWNER TO aoe_admin;

--
-- Name: collectionthumbnail_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.collectionthumbnail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.collectionthumbnail_id_seq OWNER TO aoe_admin;

--
-- Name: collectionthumbnail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.collectionthumbnail_id_seq OWNED BY public.collectionthumbnail.id;


--
-- Name: educationalaudience; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.educationalaudience (
    id bigint NOT NULL,
    educationalrole text NOT NULL,
    educationalmaterialid bigint NOT NULL,
    educationalrolekey text NOT NULL
);


ALTER TABLE public.educationalaudience OWNER TO aoe_admin;

--
-- Name: educationalaudience_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.educationalaudience_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.educationalaudience_id_seq OWNER TO aoe_admin;

--
-- Name: educationalaudience_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.educationalaudience_id_seq OWNED BY public.educationalaudience.id;


--
-- Name: educationallevel; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.educationallevel (
    id bigint NOT NULL,
    value text NOT NULL,
    educationalmaterialid bigint NOT NULL,
    educationallevelkey text NOT NULL
);


ALTER TABLE public.educationallevel OWNER TO aoe_admin;

--
-- Name: educationallevel_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.educationallevel_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.educationallevel_id_seq OWNER TO aoe_admin;

--
-- Name: educationallevel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.educationallevel_id_seq OWNED BY public.educationallevel.id;


--
-- Name: educationallevelextension; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.educationallevelextension (
    id bigint NOT NULL,
    value text NOT NULL,
    educationallevelkey text NOT NULL,
    educationalmaterialid bigint NOT NULL,
    usersusername text NOT NULL
);


ALTER TABLE public.educationallevelextension OWNER TO aoe_admin;

--
-- Name: educationallevelextension_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.educationallevelextension_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.educationallevelextension_id_seq OWNER TO aoe_admin;

--
-- Name: educationallevelextension_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.educationallevelextension_id_seq OWNED BY public.educationallevelextension.id;


--
-- Name: educationalmaterial; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.educationalmaterial (
    id bigint NOT NULL,
    createdat timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    publishedat timestamp with time zone,
    updatedat timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    archivedat timestamp with time zone,
    timerequired text DEFAULT ''::text NOT NULL,
    agerangemin integer,
    agerangemax integer,
    licensecode text DEFAULT ''::text NOT NULL,
    obsoleted integer DEFAULT 0 NOT NULL,
    originalpublishedat timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    usersusername text NOT NULL,
    expires timestamp with time zone,
    suitsallearlychildhoodsubjects boolean DEFAULT false NOT NULL,
    suitsallpreprimarysubjects boolean DEFAULT false NOT NULL,
    suitsallbasicstudysubjects boolean DEFAULT false NOT NULL,
    suitsalluppersecondarysubjects boolean DEFAULT false NOT NULL,
    suitsallvocationaldegrees boolean DEFAULT false NOT NULL,
    suitsallselfmotivatedsubjects boolean DEFAULT false NOT NULL,
    suitsallbranches boolean DEFAULT false NOT NULL,
    suitsalluppersecondarysubjectsnew boolean DEFAULT false NOT NULL,
    ratingcontentaverage numeric(2,1),
    ratingvisualaverage numeric(2,1),
    viewcounter bigint DEFAULT 0,
    downloadcounter bigint DEFAULT 0,
    counterupdatedat timestamp with time zone
);


ALTER TABLE public.educationalmaterial OWNER TO aoe_admin;

--
-- Name: educationalmaterial_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.educationalmaterial_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.educationalmaterial_id_seq OWNER TO aoe_admin;

--
-- Name: educationalmaterial_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.educationalmaterial_id_seq OWNED BY public.educationalmaterial.id;


--
-- Name: educationalmaterialversion; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.educationalmaterialversion (
    educationalmaterialid bigint NOT NULL,
    publishedat timestamp without time zone NOT NULL,
    urn text
);


ALTER TABLE public.educationalmaterialversion OWNER TO aoe_admin;

--
-- Name: educationaluse; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.educationaluse (
    id bigint NOT NULL,
    value text NOT NULL,
    educationalmaterialid bigint NOT NULL,
    educationalusekey text NOT NULL
);


ALTER TABLE public.educationaluse OWNER TO aoe_admin;

--
-- Name: educationaluse_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.educationaluse_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.educationaluse_id_seq OWNER TO aoe_admin;

--
-- Name: educationaluse_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.educationaluse_id_seq OWNED BY public.educationaluse.id;


--
-- Name: inlanguage; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.inlanguage (
    id bigint NOT NULL,
    inlanguage text NOT NULL,
    url text NOT NULL,
    educationalmaterialid bigint NOT NULL
);


ALTER TABLE public.inlanguage OWNER TO aoe_admin;

--
-- Name: inlanguage_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.inlanguage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inlanguage_id_seq OWNER TO aoe_admin;

--
-- Name: inlanguage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.inlanguage_id_seq OWNED BY public.inlanguage.id;


--
-- Name: isbasedon; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.isbasedon (
    id bigint NOT NULL,
    author text,
    url text NOT NULL,
    materialname text NOT NULL,
    educationalmaterialid bigint NOT NULL
);


ALTER TABLE public.isbasedon OWNER TO aoe_admin;

--
-- Name: isbasedon_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.isbasedon_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.isbasedon_id_seq OWNER TO aoe_admin;

--
-- Name: isbasedon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.isbasedon_id_seq OWNED BY public.isbasedon.id;


--
-- Name: isbasedonauthor; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.isbasedonauthor (
    id bigint NOT NULL,
    authorname text NOT NULL,
    isbasedonid bigint NOT NULL
);


ALTER TABLE public.isbasedonauthor OWNER TO aoe_admin;

--
-- Name: isbasedonauthor_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.isbasedonauthor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.isbasedonauthor_id_seq OWNER TO aoe_admin;

--
-- Name: isbasedonauthor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.isbasedonauthor_id_seq OWNED BY public.isbasedonauthor.id;


--
-- Name: keyword; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.keyword (
    id bigint NOT NULL,
    value text NOT NULL,
    educationalmaterialid bigint NOT NULL,
    keywordkey text NOT NULL
);


ALTER TABLE public.keyword OWNER TO aoe_admin;

--
-- Name: keyword_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.keyword_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.keyword_id_seq OWNER TO aoe_admin;

--
-- Name: keyword_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.keyword_id_seq OWNED BY public.keyword.id;


--
-- Name: keywordextension; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.keywordextension (
    id bigint NOT NULL,
    value text NOT NULL,
    educationalmaterialid bigint NOT NULL,
    keywordkey text NOT NULL,
    usersusername text NOT NULL
);


ALTER TABLE public.keywordextension OWNER TO aoe_admin;

--
-- Name: keywordextension_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.keywordextension_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.keywordextension_id_seq OWNER TO aoe_admin;

--
-- Name: keywordextension_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.keywordextension_id_seq OWNED BY public.keywordextension.id;


--
-- Name: learningresourcetype; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.learningresourcetype (
    id bigint NOT NULL,
    value text NOT NULL,
    educationalmaterialid bigint NOT NULL,
    learningresourcetypekey text
);


ALTER TABLE public.learningresourcetype OWNER TO aoe_admin;

--
-- Name: learningresourcetype_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.learningresourcetype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.learningresourcetype_id_seq OWNER TO aoe_admin;

--
-- Name: learningresourcetype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.learningresourcetype_id_seq OWNED BY public.learningresourcetype.id;


--
-- Name: licensecode; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.licensecode (
    code text NOT NULL,
    license text NOT NULL
);


ALTER TABLE public.licensecode OWNER TO aoe_admin;

--
-- Name: logins; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.logins (
    id bigint NOT NULL,
    username character varying(255) NOT NULL,
    passwordsalt character varying(255) NOT NULL,
    passwordhash character varying(255) NOT NULL,
    usersid bigint NOT NULL
);


ALTER TABLE public.logins OWNER TO aoe_admin;

--
-- Name: logins_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.logins_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.logins_id_seq OWNER TO aoe_admin;

--
-- Name: logins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.logins_id_seq OWNED BY public.logins.id;


--
-- Name: material; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.material (
    id bigint NOT NULL,
    link text NOT NULL,
    educationalmaterialid bigint NOT NULL,
    obsoleted integer DEFAULT 0 NOT NULL,
    priority integer DEFAULT 0 NOT NULL,
    materiallanguagekey text DEFAULT 'fi'::public.lang NOT NULL
);


ALTER TABLE public.material OWNER TO aoe_admin;

--
-- Name: material_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.material_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.material_id_seq OWNER TO aoe_admin;

--
-- Name: material_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.material_id_seq OWNED BY public.material.id;


--
-- Name: materialdescription; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.materialdescription (
    id bigint NOT NULL,
    description text NOT NULL,
    language public.lang NOT NULL,
    educationalmaterialid bigint NOT NULL
);


ALTER TABLE public.materialdescription OWNER TO aoe_admin;

--
-- Name: materialdescription_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.materialdescription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.materialdescription_id_seq OWNER TO aoe_admin;

--
-- Name: materialdescription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.materialdescription_id_seq OWNED BY public.materialdescription.id;


--
-- Name: materialdisplayname; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.materialdisplayname (
    id bigint NOT NULL,
    displayname text NOT NULL,
    language public.lang NOT NULL,
    materialid bigint NOT NULL
);


ALTER TABLE public.materialdisplayname OWNER TO aoe_admin;

--
-- Name: materialdisplayname_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.materialdisplayname_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.materialdisplayname_id_seq OWNER TO aoe_admin;

--
-- Name: materialdisplayname_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.materialdisplayname_id_seq OWNED BY public.materialdisplayname.id;


--
-- Name: materialname; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.materialname (
    id bigint NOT NULL,
    materialname text DEFAULT ''::text NOT NULL,
    language public.lang NOT NULL,
    slug text DEFAULT ''::text NOT NULL,
    educationalmaterialid bigint NOT NULL
);


ALTER TABLE public.materialname OWNER TO aoe_admin;

--
-- Name: materialname_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.materialname_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.materialname_id_seq OWNER TO aoe_admin;

--
-- Name: materialname_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.materialname_id_seq OWNED BY public.materialname.id;


--
-- Name: publisher; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.publisher (
    id bigint NOT NULL,
    name text NOT NULL,
    educationalmaterialid bigint NOT NULL,
    publisherkey text NOT NULL
);


ALTER TABLE public.publisher OWNER TO aoe_admin;

--
-- Name: publisher_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.publisher_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.publisher_id_seq OWNER TO aoe_admin;

--
-- Name: publisher_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.publisher_id_seq OWNED BY public.publisher.id;


--
-- Name: rating; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.rating (
    id bigint NOT NULL,
    ratingcontent integer,
    ratingvisual integer,
    feedbackpositive character varying(1000),
    feedbacksuggest character varying(1000),
    feedbackpurpose character varying(1000),
    educationalmaterialid bigint NOT NULL,
    usersusername text NOT NULL,
    updatedat timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.rating OWNER TO aoe_admin;

--
-- Name: rating_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.rating_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rating_id_seq OWNER TO aoe_admin;

--
-- Name: rating_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.rating_id_seq OWNED BY public.rating.id;


--
-- Name: record; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.record (
    id bigint NOT NULL,
    filepath text NOT NULL,
    originalfilename text NOT NULL,
    filesize integer NOT NULL,
    mimetype text NOT NULL,
    format text NOT NULL,
    materialid bigint NOT NULL,
    filekey text NOT NULL,
    filebucket text NOT NULL,
    pdfkey text
);


ALTER TABLE public.record OWNER TO aoe_admin;

--
-- Name: record_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.record_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.record_id_seq OWNER TO aoe_admin;

--
-- Name: record_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.record_id_seq OWNED BY public.record.id;


--
-- Name: temporaryattachment; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.temporaryattachment (
    id bigint NOT NULL,
    filepath text NOT NULL,
    originalfilename text NOT NULL,
    filesize integer NOT NULL,
    mimetype text NOT NULL,
    format text NOT NULL,
    filename text NOT NULL,
    createdat timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    defaultfile boolean NOT NULL,
    kind text NOT NULL,
    label text NOT NULL,
    srclang text NOT NULL,
    attachmentid bigint NOT NULL
);


ALTER TABLE public.temporaryattachment OWNER TO aoe_admin;

--
-- Name: temporaryattachment_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.temporaryattachment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.temporaryattachment_id_seq OWNER TO aoe_admin;

--
-- Name: temporaryattachment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.temporaryattachment_id_seq OWNED BY public.temporaryattachment.id;


--
-- Name: temporaryrecord; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.temporaryrecord (
    id bigint NOT NULL,
    filepath text NOT NULL,
    originalfilename text NOT NULL,
    filesize integer NOT NULL,
    mimetype text NOT NULL,
    format text NOT NULL,
    filename text NOT NULL,
    materialid bigint NOT NULL,
    createdat timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.temporaryrecord OWNER TO aoe_admin;

--
-- Name: temporaryrecord_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.temporaryrecord_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.temporaryrecord_id_seq OWNER TO aoe_admin;

--
-- Name: temporaryrecord_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.temporaryrecord_id_seq OWNED BY public.temporaryrecord.id;


--
-- Name: thumbnail; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.thumbnail (
    id bigint NOT NULL,
    filepath text NOT NULL,
    mimetype text NOT NULL,
    educationalmaterialid bigint NOT NULL,
    filename text NOT NULL,
    obsoleted integer DEFAULT 0 NOT NULL,
    filekey text NOT NULL,
    filebucket text NOT NULL
);


ALTER TABLE public.thumbnail OWNER TO aoe_admin;

--
-- Name: thumbnail_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.thumbnail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.thumbnail_id_seq OWNER TO aoe_admin;

--
-- Name: thumbnail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.thumbnail_id_seq OWNED BY public.thumbnail.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    firstname text NOT NULL,
    lastname text NOT NULL,
    username text NOT NULL,
    preferredlanguage public.lang DEFAULT 'fi'::public.lang NOT NULL,
    preferredtargetname text NOT NULL,
    preferredalignmenttype text NOT NULL,
    termsofusage boolean DEFAULT false NOT NULL,
    email text,
    verifiedemail boolean DEFAULT false,
    newratings boolean DEFAULT false,
    almostexpired boolean DEFAULT false,
    termsupdated boolean DEFAULT false,
    allowtransfer boolean DEFAULT false
);


ALTER TABLE public.users OWNER TO aoe_admin;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: aoe_admin
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO aoe_admin;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aoe_admin
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: userscollection; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.userscollection (
    collectionid bigint NOT NULL,
    usersusername text NOT NULL
);


ALTER TABLE public.userscollection OWNER TO aoe_admin;

--
-- Name: versioncomposition; Type: TABLE; Schema: public; Owner: aoe_admin
--

CREATE TABLE public.versioncomposition (
    educationalmaterialid bigint NOT NULL,
    materialid bigint NOT NULL,
    publishedat timestamp without time zone NOT NULL,
    priority integer
);


ALTER TABLE public.versioncomposition OWNER TO aoe_admin;

--
-- Name: accessibilityapi id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.accessibilityapi ALTER COLUMN id SET DEFAULT nextval('public.accessibilityapi_id_seq'::regclass);


--
-- Name: accessibilitycontrol id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.accessibilitycontrol ALTER COLUMN id SET DEFAULT nextval('public.accessibilitycontrol_id_seq'::regclass);


--
-- Name: accessibilityfeature id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.accessibilityfeature ALTER COLUMN id SET DEFAULT nextval('public.accessibilityfeature_id_seq'::regclass);


--
-- Name: accessibilityfeatureextension id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.accessibilityfeatureextension ALTER COLUMN id SET DEFAULT nextval('public.accessibilityfeatureextension_id_seq'::regclass);


--
-- Name: accessibilityhazard id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.accessibilityhazard ALTER COLUMN id SET DEFAULT nextval('public.accessibilityhazard_id_seq'::regclass);


--
-- Name: accessibilityhazardextension id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.accessibilityhazardextension ALTER COLUMN id SET DEFAULT nextval('public.accessibilityhazardextension_id_seq'::regclass);


--
-- Name: alignmentobject id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.alignmentobject ALTER COLUMN id SET DEFAULT nextval('public.alignmentobject_id_seq'::regclass);


--
-- Name: attachment id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.attachment ALTER COLUMN id SET DEFAULT nextval('public.attachment_id_seq'::regclass);


--
-- Name: author id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.author ALTER COLUMN id SET DEFAULT nextval('public.author_id_seq'::regclass);


--
-- Name: collection id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.collection ALTER COLUMN id SET DEFAULT nextval('public.collection_id_seq'::regclass);


--
-- Name: collectionaccessibilityfeature id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.collectionaccessibilityfeature ALTER COLUMN id SET DEFAULT nextval('public.collectionaccessibilityfeature_id_seq'::regclass);


--
-- Name: collectionaccessibilityhazard id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.collectionaccessibilityhazard ALTER COLUMN id SET DEFAULT nextval('public.collectionaccessibilityhazard_id_seq'::regclass);


--
-- Name: collectionalignmentobject id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.collectionalignmentobject ALTER COLUMN id SET DEFAULT nextval('public.collectionalignmentobject_id_seq'::regclass);


--
-- Name: collectioneducationalaudience id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.collectioneducationalaudience ALTER COLUMN id SET DEFAULT nextval('public.collectioneducationalaudience_id_seq'::regclass);


--
-- Name: collectioneducationallevel id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.collectioneducationallevel ALTER COLUMN id SET DEFAULT nextval('public.collectioneducationallevel_id_seq'::regclass);


--
-- Name: collectioneducationaluse id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.collectioneducationaluse ALTER COLUMN id SET DEFAULT nextval('public.collectioneducationaluse_id_seq'::regclass);


--
-- Name: collectionheading id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.collectionheading ALTER COLUMN id SET DEFAULT nextval('public.collectionheading_id_seq'::regclass);


--
-- Name: collectionkeyword id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.collectionkeyword ALTER COLUMN id SET DEFAULT nextval('public.collectionkeyword_id_seq'::regclass);


--
-- Name: collectionlanguage id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.collectionlanguage ALTER COLUMN id SET DEFAULT nextval('public.collectionlanguage_id_seq'::regclass);


--
-- Name: collectionthumbnail id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.collectionthumbnail ALTER COLUMN id SET DEFAULT nextval('public.collectionthumbnail_id_seq'::regclass);


--
-- Name: educationalaudience id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.educationalaudience ALTER COLUMN id SET DEFAULT nextval('public.educationalaudience_id_seq'::regclass);


--
-- Name: educationallevel id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.educationallevel ALTER COLUMN id SET DEFAULT nextval('public.educationallevel_id_seq'::regclass);


--
-- Name: educationallevelextension id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.educationallevelextension ALTER COLUMN id SET DEFAULT nextval('public.educationallevelextension_id_seq'::regclass);


--
-- Name: educationalmaterial id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.educationalmaterial ALTER COLUMN id SET DEFAULT nextval('public.educationalmaterial_id_seq'::regclass);


--
-- Name: educationaluse id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.educationaluse ALTER COLUMN id SET DEFAULT nextval('public.educationaluse_id_seq'::regclass);


--
-- Name: inlanguage id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.inlanguage ALTER COLUMN id SET DEFAULT nextval('public.inlanguage_id_seq'::regclass);


--
-- Name: isbasedon id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.isbasedon ALTER COLUMN id SET DEFAULT nextval('public.isbasedon_id_seq'::regclass);


--
-- Name: isbasedonauthor id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.isbasedonauthor ALTER COLUMN id SET DEFAULT nextval('public.isbasedonauthor_id_seq'::regclass);


--
-- Name: keyword id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.keyword ALTER COLUMN id SET DEFAULT nextval('public.keyword_id_seq'::regclass);


--
-- Name: keywordextension id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.keywordextension ALTER COLUMN id SET DEFAULT nextval('public.keywordextension_id_seq'::regclass);


--
-- Name: learningresourcetype id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.learningresourcetype ALTER COLUMN id SET DEFAULT nextval('public.learningresourcetype_id_seq'::regclass);


--
-- Name: logins id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.logins ALTER COLUMN id SET DEFAULT nextval('public.logins_id_seq'::regclass);


--
-- Name: material id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.material ALTER COLUMN id SET DEFAULT nextval('public.material_id_seq'::regclass);


--
-- Name: materialdescription id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.materialdescription ALTER COLUMN id SET DEFAULT nextval('public.materialdescription_id_seq'::regclass);


--
-- Name: materialdisplayname id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.materialdisplayname ALTER COLUMN id SET DEFAULT nextval('public.materialdisplayname_id_seq'::regclass);


--
-- Name: materialname id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.materialname ALTER COLUMN id SET DEFAULT nextval('public.materialname_id_seq'::regclass);


--
-- Name: publisher id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.publisher ALTER COLUMN id SET DEFAULT nextval('public.publisher_id_seq'::regclass);


--
-- Name: rating id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.rating ALTER COLUMN id SET DEFAULT nextval('public.rating_id_seq'::regclass);


--
-- Name: record id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.record ALTER COLUMN id SET DEFAULT nextval('public.record_id_seq'::regclass);


--
-- Name: temporaryattachment id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.temporaryattachment ALTER COLUMN id SET DEFAULT nextval('public.temporaryattachment_id_seq'::regclass);


--
-- Name: temporaryrecord id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.temporaryrecord ALTER COLUMN id SET DEFAULT nextval('public.temporaryrecord_id_seq'::regclass);


--
-- Name: thumbnail id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.thumbnail ALTER COLUMN id SET DEFAULT nextval('public.thumbnail_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: accessibilityapi; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.accessibilityapi (id, value, educationalmaterialid) FROM stdin;
\.


--
-- Data for Name: accessibilitycontrol; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.accessibilitycontrol (id, value, educationalmaterialid) FROM stdin;
\.


--
-- Data for Name: accessibilityfeature; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.accessibilityfeature (id, value, educationalmaterialid, accessibilityfeaturekey) FROM stdin;
1	navigointi rakenteen avulla	7	5c2db7be-9a40-4f5b-96b7-768c07bf09c4
2	navigointi rakenteen avulla	8	5c2db7be-9a40-4f5b-96b7-768c07bf09c4
3	käsikirjoitus	12	1bee480d-c3db-4b10-9e37-6f05a34c0521
4	käsikirjoitus	13	1bee480d-c3db-4b10-9e37-6f05a34c0521
5	käsikirjoitus	14	1bee480d-c3db-4b10-9e37-6f05a34c0521
6	käsikirjoitus	18	1bee480d-c3db-4b10-9e37-6f05a34c0521
7	navigointi rakenteen avulla	24	5c2db7be-9a40-4f5b-96b7-768c07bf09c4
8	tekstivastine	24	0ab440bf-1d0d-4d6a-907b-ac080c32ea3c
9	navigointi rakenteen avulla	43	5c2db7be-9a40-4f5b-96b7-768c07bf09c4
10	tekstivastine	43	0ab440bf-1d0d-4d6a-907b-ac080c32ea3c
11	tekstivastine	61	0ab440bf-1d0d-4d6a-907b-ac080c32ea3c
12	käsikirjoitus	74	1bee480d-c3db-4b10-9e37-6f05a34c0521
13	latex	75	3b7bda53-a037-487e-a355-b2f1b20a50b6
14	käsikirjoitus	75	1bee480d-c3db-4b10-9e37-6f05a34c0521
15	ChemML	107	e633ab05-8b0d-4b17-b61d-929a16da0069
16	tekstivastine	108	0ab440bf-1d0d-4d6a-907b-ac080c32ea3c
17	navigointi rakenteen avulla	108	5c2db7be-9a40-4f5b-96b7-768c07bf09c4
18	ChemML	128	e633ab05-8b0d-4b17-b61d-929a16da0069
19	isokokoinen teksti	128	f5abf3e7-ac02-455b-b7a4-6fd4ee5b2c97
20	tekstitys	142	098c131b-7de2-49f1-aef9-508132bb46c6
21	tekstitys	143	098c131b-7de2-49f1-aef9-508132bb46c6
22	tekstitys	144	098c131b-7de2-49f1-aef9-508132bb46c6
23	tekstivastine	144	0ab440bf-1d0d-4d6a-907b-ac080c32ea3c
24	tekstitys	168	098c131b-7de2-49f1-aef9-508132bb46c6
25	tekstivastine	168	0ab440bf-1d0d-4d6a-907b-ac080c32ea3c
26	alternative text	176	0ab440bf-1d0d-4d6a-907b-ac080c32ea3c
28	tekstitys	183	098c131b-7de2-49f1-aef9-508132bb46c6
29	tekstivastine	183	0ab440bf-1d0d-4d6a-907b-ac080c32ea3c
30	latex	184	3b7bda53-a037-487e-a355-b2f1b20a50b6
31	käsikirjoitus	184	1bee480d-c3db-4b10-9e37-6f05a34c0521
32	isokokoinen teksti	189	f5abf3e7-ac02-455b-b7a4-6fd4ee5b2c97
33	selkokieli	193	1f91471b-82d9-4e61-a9e7-637579bf4684
34	latex	193	3b7bda53-a037-487e-a355-b2f1b20a50b6
35	latex	203	3b7bda53-a037-487e-a355-b2f1b20a50b6
36	käsikirjoitus	208	1bee480d-c3db-4b10-9e37-6f05a34c0521
37	multimedia ja ajastettu sisältö hallittavissa	208	b2dcdab5-1a43-4165-ae3f-54ee63c26a4e
38	pistekirjoitus	215	b23933bc-a765-4fa7-bf67-6ba437fb2080
39	tekstitys	215	098c131b-7de2-49f1-aef9-508132bb46c6
40	navigointi rakenteen avulla	216	5c2db7be-9a40-4f5b-96b7-768c07bf09c4
41	pistekirjoitus	216	b23933bc-a765-4fa7-bf67-6ba437fb2080
42	MathML	217	5028bc5d-7c95-406a-b5f3-a2fd1519a6e9
43	tekstitys	220	098c131b-7de2-49f1-aef9-508132bb46c6
44	käsikirjoitus	222	1bee480d-c3db-4b10-9e37-6f05a34c0521
45	isokokoinen teksti	223	f5abf3e7-ac02-455b-b7a4-6fd4ee5b2c97
46	latex	224	3b7bda53-a037-487e-a355-b2f1b20a50b6
47	isokokoinen teksti	231	f5abf3e7-ac02-455b-b7a4-6fd4ee5b2c97
48	latex	231	3b7bda53-a037-487e-a355-b2f1b20a50b6
49	tekstitys	234	098c131b-7de2-49f1-aef9-508132bb46c6
50	isokokoinen teksti	235	f5abf3e7-ac02-455b-b7a4-6fd4ee5b2c97
98	tekstitys	241	098c131b-7de2-49f1-aef9-508132bb46c6
108	isokokoinen teksti	245	f5abf3e7-ac02-455b-b7a4-6fd4ee5b2c97
111	tekstivastine	247	0ab440bf-1d0d-4d6a-907b-ac080c32ea3c
125	MathML	200	5028bc5d-7c95-406a-b5f3-a2fd1519a6e9
128	isokokoinen teksti	246	f5abf3e7-ac02-455b-b7a4-6fd4ee5b2c97
133	tekstitys	265	098c131b-7de2-49f1-aef9-508132bb46c6
134	tekstivastine	265	0ab440bf-1d0d-4d6a-907b-ac080c32ea3c
135	tekstitys	267	098c131b-7de2-49f1-aef9-508132bb46c6
141	isokokoinen teksti	268	f5abf3e7-ac02-455b-b7a4-6fd4ee5b2c97
142	käsikirjoitus	261	1bee480d-c3db-4b10-9e37-6f05a34c0521
144	isokokoinen teksti	233	f5abf3e7-ac02-455b-b7a4-6fd4ee5b2c97
145	käsikirjoitus	269	1bee480d-c3db-4b10-9e37-6f05a34c0521
146	isokokoinen teksti	214	f5abf3e7-ac02-455b-b7a4-6fd4ee5b2c97
147	ChemML	270	e633ab05-8b0d-4b17-b61d-929a16da0069
152	käsikirjoitus	271	1bee480d-c3db-4b10-9e37-6f05a34c0521
153	isokokoinen teksti	257	f5abf3e7-ac02-455b-b7a4-6fd4ee5b2c97
154	navigointi rakenteen avulla	282	5c2db7be-9a40-4f5b-96b7-768c07bf09c4
156	tekstivastine	177	0ab440bf-1d0d-4d6a-907b-ac080c32ea3c
159	tekstivastine	284	0ab440bf-1d0d-4d6a-907b-ac080c32ea3c
160	navigointi rakenteen avulla	285	5c2db7be-9a40-4f5b-96b7-768c07bf09c4
161	navigointi rakenteen avulla	287	5c2db7be-9a40-4f5b-96b7-768c07bf09c4
165	isokokoinen teksti	293	f5abf3e7-ac02-455b-b7a4-6fd4ee5b2c97
174	tekstitys	296	098c131b-7de2-49f1-aef9-508132bb46c6
178	pistekirjoitus	279	b23933bc-a765-4fa7-bf67-6ba437fb2080
179	tekstivastine	279	0ab440bf-1d0d-4d6a-907b-ac080c32ea3c
180	isokokoinen teksti	294	f5abf3e7-ac02-455b-b7a4-6fd4ee5b2c97
181	käsikirjoitus	297	1bee480d-c3db-4b10-9e37-6f05a34c0521
182	ChemML	304	e633ab05-8b0d-4b17-b61d-929a16da0069
183	tekstivastine	306	0ab440bf-1d0d-4d6a-907b-ac080c32ea3c
184	tekstitys	306	098c131b-7de2-49f1-aef9-508132bb46c6
185	navigointi rakenteen avulla	306	5c2db7be-9a40-4f5b-96b7-768c07bf09c4
193	tekstitys	312	098c131b-7de2-49f1-aef9-508132bb46c6
200	latex	337	3b7bda53-a037-487e-a355-b2f1b20a50b6
201	käsikirjoitus	337	1bee480d-c3db-4b10-9e37-6f05a34c0521
202	tekstivastine	338	0ab440bf-1d0d-4d6a-907b-ac080c32ea3c
203	multimedia ja ajastettu sisältö hallittavissa	340	b2dcdab5-1a43-4165-ae3f-54ee63c26a4e
204	tekstitys	341	098c131b-7de2-49f1-aef9-508132bb46c6
205	isokokoinen teksti	342	f5abf3e7-ac02-455b-b7a4-6fd4ee5b2c97
206	MathML	343	5028bc5d-7c95-406a-b5f3-a2fd1519a6e9
207	käsikirjoitus	344	1bee480d-c3db-4b10-9e37-6f05a34c0521
208	käsikirjoitus	345	1bee480d-c3db-4b10-9e37-6f05a34c0521
209	latex	347	3b7bda53-a037-487e-a355-b2f1b20a50b6
210	latex	348	3b7bda53-a037-487e-a355-b2f1b20a50b6
211	viittomakieli	349	d419ac55-1ca7-4c41-9b9c-350916a1548b
220	isokokoinen teksti	360	f5abf3e7-ac02-455b-b7a4-6fd4ee5b2c97
221	isokokoinen teksti	366	f5abf3e7-ac02-455b-b7a4-6fd4ee5b2c97
222	latex	367	3b7bda53-a037-487e-a355-b2f1b20a50b6
231	käsikirjoitus	369	1bee480d-c3db-4b10-9e37-6f05a34c0521
237	latex	378	3b7bda53-a037-487e-a355-b2f1b20a50b6
238	isokokoinen teksti	380	f5abf3e7-ac02-455b-b7a4-6fd4ee5b2c97
239	tekstivastine	381	0ab440bf-1d0d-4d6a-907b-ac080c32ea3c
240	tekstivastine	382	0ab440bf-1d0d-4d6a-907b-ac080c32ea3c
242	käsikirjoitus	310	1bee480d-c3db-4b10-9e37-6f05a34c0521
249	multimedia ja ajastettu sisältö hallittavissa	393	b2dcdab5-1a43-4165-ae3f-54ee63c26a4e
252	multimedia ja ajastettu sisältö hallittavissa	396	b2dcdab5-1a43-4165-ae3f-54ee63c26a4e
255	isokokoinen teksti	399	f5abf3e7-ac02-455b-b7a4-6fd4ee5b2c97
256	käsikirjoitus	400	1bee480d-c3db-4b10-9e37-6f05a34c0521
260	navigointi rakenteen avulla	406	5c2db7be-9a40-4f5b-96b7-768c07bf09c4
275	navigointi rakenteen avulla	420	5c2db7be-9a40-4f5b-96b7-768c07bf09c4
\.


--
-- Data for Name: accessibilityfeatureextension; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.accessibilityfeatureextension (id, value, accessibilityfeaturekey, educationalmaterialid, usersusername) FROM stdin;
5	käsikirjoitus	1bee480d-c3db-4b10-9e37-6f05a34c0521	275	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD
6	MathML	5028bc5d-7c95-406a-b5f3-a2fd1519a6e9	275	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD
8	selkokieli	1f91471b-82d9-4e61-a9e7-637579bf4684	351	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0
9	lättläst språk	1f91471b-82d9-4e61-a9e7-637579bf4684	245	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0
10	structural navigation	5c2db7be-9a40-4f5b-96b7-768c07bf09c4	306	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0
11	tekstitys	098c131b-7de2-49f1-aef9-508132bb46c6	306	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD
\.


--
-- Data for Name: accessibilityhazard; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.accessibilityhazard (id, value, educationalmaterialid, accessibilityhazardkey) FROM stdin;
1	ei välähtelyhaittaa	7	928f2c31-0779-4991-9e48-3af79aba67a3
2	ei äänihaittaa	7	e2165852-c2ec-47b7-8dd5-7cfbfad52697
3	ei äänihaittaa	8	e2165852-c2ec-47b7-8dd5-7cfbfad52697
4	ei välähtelyhaittaa	8	928f2c31-0779-4991-9e48-3af79aba67a3
5	ei äänihaittaa	24	e2165852-c2ec-47b7-8dd5-7cfbfad52697
6	ei välähtelyhaittaa	24	928f2c31-0779-4991-9e48-3af79aba67a3
7	ei esteitä	43	b3293084-f161-4e86-8d68-139588769157
8	ei esteitä	61	b3293084-f161-4e86-8d68-139588769157
9	ei äänihaittaa	74	e2165852-c2ec-47b7-8dd5-7cfbfad52697
10	ei tiedossa	75	85b2dd0b-b362-467b-9904-cfd84e2b0e82
11	ei äänihaittaa	75	e2165852-c2ec-47b7-8dd5-7cfbfad52697
12	ei esteitä	77	b3293084-f161-4e86-8d68-139588769157
13	ääni	107	a482b0b8-80c8-4bd4-b6d7-99853217d948
14	ei esteitä	108	b3293084-f161-4e86-8d68-139588769157
15	ei esteitä	123	b3293084-f161-4e86-8d68-139588769157
16	ei äänihaittaa	128	e2165852-c2ec-47b7-8dd5-7cfbfad52697
17	ei esteitä	128	b3293084-f161-4e86-8d68-139588769157
18	ei esteitä	142	b3293084-f161-4e86-8d68-139588769157
19	ei esteitä	143	b3293084-f161-4e86-8d68-139588769157
20	ei esteitä	144	b3293084-f161-4e86-8d68-139588769157
21	ei tiedossa	160	85b2dd0b-b362-467b-9904-cfd84e2b0e82
22	ei esteitä	168	b3293084-f161-4e86-8d68-139588769157
24	ei esteitä	183	b3293084-f161-4e86-8d68-139588769157
25	ei tiedossa	189	85b2dd0b-b362-467b-9904-cfd84e2b0e82
26	ääni	193	a482b0b8-80c8-4bd4-b6d7-99853217d948
27	ei välähtelyhaittaa	193	928f2c31-0779-4991-9e48-3af79aba67a3
28	ei esteitä	203	b3293084-f161-4e86-8d68-139588769157
29	ei esteitä	208	b3293084-f161-4e86-8d68-139588769157
30	ääni	216	a482b0b8-80c8-4bd4-b6d7-99853217d948
31	välähtely	216	9c3eca43-2e70-4ce4-bb21-83616178a6cf
32	ei välähtelyhaittaa	217	928f2c31-0779-4991-9e48-3af79aba67a3
33	ei esteitä	220	b3293084-f161-4e86-8d68-139588769157
34	ei esteitä	222	b3293084-f161-4e86-8d68-139588769157
35	ääni	223	a482b0b8-80c8-4bd4-b6d7-99853217d948
36	blinkande	224	9c3eca43-2e70-4ce4-bb21-83616178a6cf
37	ei esteitä	231	b3293084-f161-4e86-8d68-139588769157
38	ei esteitä	234	b3293084-f161-4e86-8d68-139588769157
39	ääni	235	a482b0b8-80c8-4bd4-b6d7-99853217d948
74	ei äänihaittaa	241	e2165852-c2ec-47b7-8dd5-7cfbfad52697
83	ääni	239	a482b0b8-80c8-4bd4-b6d7-99853217d948
84	ei esteitä	245	b3293084-f161-4e86-8d68-139588769157
87	ei tiedossa	247	85b2dd0b-b362-467b-9904-cfd84e2b0e82
88	ei esteitä	249	b3293084-f161-4e86-8d68-139588769157
91	ei äänihaittaa	260	e2165852-c2ec-47b7-8dd5-7cfbfad52697
92	ei esteitä	260	b3293084-f161-4e86-8d68-139588769157
93	ei välähtelyhaittaa	260	928f2c31-0779-4991-9e48-3af79aba67a3
113	ei tiedossa	200	85b2dd0b-b362-467b-9904-cfd84e2b0e82
115	ei äänihaittaa	246	e2165852-c2ec-47b7-8dd5-7cfbfad52697
120	ei esteitä	265	b3293084-f161-4e86-8d68-139588769157
121	ei tiedossa	267	85b2dd0b-b362-467b-9904-cfd84e2b0e82
129	ääni	268	a482b0b8-80c8-4bd4-b6d7-99853217d948
130	ei tiedossa	261	85b2dd0b-b362-467b-9904-cfd84e2b0e82
132	ei esteitä	233	b3293084-f161-4e86-8d68-139588769157
133	ei välähtelyhaittaa	269	928f2c31-0779-4991-9e48-3af79aba67a3
134	ei äänihaittaa	214	e2165852-c2ec-47b7-8dd5-7cfbfad52697
135	ääni	270	a482b0b8-80c8-4bd4-b6d7-99853217d948
140	ei esteitä	271	b3293084-f161-4e86-8d68-139588769157
141	ei esteitä	257	b3293084-f161-4e86-8d68-139588769157
142	ei välähtelyhaittaa	177	928f2c31-0779-4991-9e48-3af79aba67a3
145	ei välähtelyhaittaa	284	928f2c31-0779-4991-9e48-3af79aba67a3
146	ei äänihaittaa	285	e2165852-c2ec-47b7-8dd5-7cfbfad52697
147	ei välähtelyhaittaa	285	928f2c31-0779-4991-9e48-3af79aba67a3
148	ei tiedossa	286	85b2dd0b-b362-467b-9904-cfd84e2b0e82
149	ei esteitä	287	b3293084-f161-4e86-8d68-139588769157
153	ei välähtelyhaittaa	293	928f2c31-0779-4991-9e48-3af79aba67a3
162	ei esteitä	296	b3293084-f161-4e86-8d68-139588769157
166	ei esteitä	279	b3293084-f161-4e86-8d68-139588769157
167	ei äänihaittaa	279	e2165852-c2ec-47b7-8dd5-7cfbfad52697
168	ei esteitä	294	b3293084-f161-4e86-8d68-139588769157
169	ei tiedossa	297	85b2dd0b-b362-467b-9904-cfd84e2b0e82
170	ei esteitä	304	b3293084-f161-4e86-8d68-139588769157
171	ei esteitä	306	b3293084-f161-4e86-8d68-139588769157
174	ei esteitä	312	b3293084-f161-4e86-8d68-139588769157
181	ei esteitä	337	b3293084-f161-4e86-8d68-139588769157
182	ei tiedossa	338	85b2dd0b-b362-467b-9904-cfd84e2b0e82
183	ei välähtelyhaittaa	340	928f2c31-0779-4991-9e48-3af79aba67a3
184	ei esteitä	341	b3293084-f161-4e86-8d68-139588769157
185	ei välähtelyhaittaa	342	928f2c31-0779-4991-9e48-3af79aba67a3
186	ei esteitä	343	b3293084-f161-4e86-8d68-139588769157
187	ei tiedossa	344	85b2dd0b-b362-467b-9904-cfd84e2b0e82
188	ei tiedossa	345	85b2dd0b-b362-467b-9904-cfd84e2b0e82
189	ei esteitä	345	b3293084-f161-4e86-8d68-139588769157
190	ei tiedossa	346	85b2dd0b-b362-467b-9904-cfd84e2b0e82
191	ei esteitä	347	b3293084-f161-4e86-8d68-139588769157
192	ei äänihaittaa	348	e2165852-c2ec-47b7-8dd5-7cfbfad52697
193	ei tiedossa	349	85b2dd0b-b362-467b-9904-cfd84e2b0e82
201	ei äänihaittaa	360	e2165852-c2ec-47b7-8dd5-7cfbfad52697
202	ei esteitä	366	b3293084-f161-4e86-8d68-139588769157
203	ei tiedossa	366	85b2dd0b-b362-467b-9904-cfd84e2b0e82
204	ei esteitä	367	b3293084-f161-4e86-8d68-139588769157
209	ei tiedossa	368	85b2dd0b-b362-467b-9904-cfd84e2b0e82
218	ei äänihaittaa	369	e2165852-c2ec-47b7-8dd5-7cfbfad52697
224	ei äänihaittaa	378	e2165852-c2ec-47b7-8dd5-7cfbfad52697
225	ei esteitä	380	b3293084-f161-4e86-8d68-139588769157
226	ei esteitä	381	b3293084-f161-4e86-8d68-139588769157
227	ei äänihaittaa	310	e2165852-c2ec-47b7-8dd5-7cfbfad52697
230	ei esteitä	327	b3293084-f161-4e86-8d68-139588769157
232	ei esteitä	362	b3293084-f161-4e86-8d68-139588769157
234	ei esteitä	393	b3293084-f161-4e86-8d68-139588769157
237	ei tiedossa	396	85b2dd0b-b362-467b-9904-cfd84e2b0e82
247	ei välähtelyhaittaa	420	928f2c31-0779-4991-9e48-3af79aba67a3
\.


--
-- Data for Name: accessibilityhazardextension; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.accessibilityhazardextension (id, value, accessibilityhazardkey, educationalmaterialid, usersusername) FROM stdin;
4	ei äänihaittaa	e2165852-c2ec-47b7-8dd5-7cfbfad52697	275	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD
5	ei välähtelyhaittaa	928f2c31-0779-4991-9e48-3af79aba67a3	275	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD
7	ei esteitä	b3293084-f161-4e86-8d68-139588769157	351	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0
8	inga hinder	b3293084-f161-4e86-8d68-139588769157	245	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0
9	flashing	9c3eca43-2e70-4ce4-bb21-83616178a6cf	111	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0
\.


--
-- Data for Name: alignmentobject; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.alignmentobject (id, educationalmaterialid, alignmenttype, targetname, source, educationalframework, objectkey, targeturl) FROM stdin;
1	2	educationalSubject	Kieli ja maailmani	upperSecondarySchoolSubjects		VKA1	\N
2	2	requires	fonetiikan perustiedot	prerequisites		fonetiikanperustiedot	\N
3	7	educationalSubject	Matematiikka	basicStudySubjects	Perusopetuksen opetussuunnitelma matematiikalle 2014	466344	\N
4	7	teaches	T14 ohjata oppilasta ymmärtämään tuntemattoman käsite ja kehittämään yhtälönratkaisutaitojaan	basicStudyObjectives	Perusopetuksen opetussuunnitelma matematiikalle 2014	748724	\N
5	7	teaches	T20 ohjata oppilasta kehittämään algoritmista ajatteluaan sekä taitojaan soveltaa matematiikkaa ja ohjelmointia ongelmien ratkaisemiseen	basicStudyObjectives	Perusopetuksen opetussuunnitelma matematiikalle 2014	748930	\N
6	7	teaches	S1 Ajattelun taidot ja menetelmät	basicStudyContents	Perusopetuksen opetussuunnitelma matematiikalle 2014	469558	\N
7	7	educationalSubject	Kasvatustieteet	branchesOfScience		516	\N
8	8	educationalSubject	Tietojenkäsittely ja informaatiotieteet	branchesOfScience		113	\N
9	8	educationalSubject	Kasvatustieteet	branchesOfScience		516	\N
10	8	educationalSubject	Filosofia	branchesOfScience		611	\N
11	8	educationalSubject	Historia ja arkeologia	branchesOfScience		615	\N
12	8	educationalSubject	Psykologia	branchesOfScience		515	\N
13	12	educationalSubject	kasvatustieteet	selfMotivatedEducationSubjects		kasvatustieteet	\N
14	12	educationalSubject	Kasvatustieteet	branchesOfScience		516	\N
15	13	educationalSubject	kasvatustieteet	selfMotivatedEducationSubjects		kasvatustieteet	\N
16	13	educationalSubject	Kasvatustieteet	branchesOfScience		516	\N
17	14	educationalSubject	kasvatustieteet	selfMotivatedEducationSubjects		kasvatustieteet	\N
18	14	educationalSubject	Kasvatustieteet	branchesOfScience		516	\N
19	18	educationalSubject	kasvatustieteet	selfMotivatedEducationSubjects		kasvatustieteet	\N
20	18	educationalSubject	Kasvatustieteet	branchesOfScience		516	\N
21	19	requires	Yhteisöllisen toiminnan merkitys	prerequisites		Yhteisllisentoiminnanmerkitys	\N
22	23	educationalSubject	asd	earlyChildhoodEducationSubjects		asd	\N
23	23	educationalSubject	fgh	earlyChildhoodEducationSubjects		fgh	\N
24	23	educationalSubject	hjk	earlyChildhoodEducationSubjects		hjk	\N
25	23	teaches	qwe	earlyChildhoodEducationObjectives		qwe	\N
26	23	teaches	rty	earlyChildhoodEducationObjectives		rty	\N
27	23	teaches	uio	earlyChildhoodEducationObjectives		uio	\N
28	23	educationalSubject	Biologia	basicStudySubjects		478970	\N
29	23	educationalSubject	Elämänkatsomustieto	basicStudySubjects		502088	\N
30	23	teaches	T1 ohjata oppilasta ymmärtämään ekosysteemin perusrakennetta ja toimintaa sekä vertailemaan erilaisia ekosysteemejä ja tunnistamaan lajeja	basicStudyObjectives		478886	\N
31	23	teaches	T2 auttaa oppilasta kuvailemaan eliöiden rakenteita ja elintoimintoja sekä ymmärtämään eliökunnan rakennetta	basicStudyObjectives		478887	\N
32	23	teaches	S1 Biologinen tutkimus	basicStudyContents		479040	\N
33	23	teaches	S2 Tutkimusretkiä luontoon ja lähiympäristöön	basicStudyContents		479041	\N
34	23	requires	OPS	prerequisites		OPS	\N
35	23	requires	ABC	prerequisites		ABC	\N
36	24	educationalSubject	Tietojenkäsittely ja informaatiotieteet	branchesOfScience		113	\N
37	24	educationalSubject	Matematiikka	branchesOfScience		111	\N
38	43	educationalSubject	Kasvatustieteet	branchesOfScience		516	\N
39	43	requires	tekijänoikeudet	prerequisites		tekijnoikeudet	\N
40	44	educationalSubject	Sähkö- ja automaatiotekniikan perustutkinto	vocationalDegrees		1724174	\N
41	56	educationalSubject	Kielen rakenteet funktionaalisesta näkökulmasta	upperSecondarySchoolSubjects		LVS1	\N
42	56	educationalSubject	Kielitieteet	branchesOfScience		6121	\N
43	56	requires	Fonetiikan perusteet	prerequisites		Fonetiikanperusteet	\N
44	57	educationalSubject	Kielen rakenteet funktionaalisesta näkökulmasta	upperSecondarySchoolSubjects		LVS1	\N
45	57	requires	Fonetiikan perusteet	prerequisites		Fonetiikanperusteet	\N
46	54	educationalSubject	Kielen rakenteet funktionaalisesta näkökulmasta	upperSecondarySchoolSubjects		LVS1	\N
47	54	educationalSubject	Kielitieteet	branchesOfScience		6121	\N
48	73	educationalSubject	Fysiikka	basicStudySubjects		466346	\N
49	76	educationalSubject	kasvatustieteet	selfMotivatedEducationSubjects		kasvatustieteet	\N
50	76	educationalSubject	Kasvatustieteet	branchesOfScience		516	\N
51	77	educationalSubject	Kasvatustieteet	branchesOfScience		516	\N
52	78	educationalSubject	Aine ja säteily	upperSecondarySchoolSubjects		FY7	\N
53	78	educationalSubject	Aktiivinen elämäntapa	upperSecondarySchoolSubjects		LI2	\N
834	247	requires	H5P -tehtävien teko	prerequisites		h5ptehtvienteko	\N
57	78	teaches	osaa selittää elämän tunnusmerkit ja perusedellytykset sekä tunnistaa niitä esimerkeistä	upperSecondarySchoolObjectivesNew		6832836	\N
58	78	teaches	osaa solun perusrakennetta ja toimintaa tasolla, joka mahdollistaa evoluution ja ekosysteemin toiminnan ymmärtämisen	upperSecondarySchoolObjectivesNew		6832837	\N
59	78	teaches	osaa selittää perinnölliseen muunteluun, luonnonvalintaan ja lajiutumiseen liittyviä mekanismeja ja osaa selittää näiden merkityksen evoluutiolle	upperSecondarySchoolObjectivesNew		6873318	\N
60	78	teaches	elämän tunnuspiirteet ja organisaatiotasot	upperSecondarySchoolContentsNew		6832842	\N
61	78	teaches	biologiset tieteenalat ja tutkimusmenetelmät	upperSecondarySchoolContentsNew		6832843	\N
62	78	teaches	biologiset havainnot, tutkimuskysymykset ja hypoteesien muodostaminen	upperSecondarySchoolContentsNew		6832844	\N
54	78	educationalSubject	Biologia	upperSecondarySchoolSubjectsNew		6832790	\N
63	78	teaches	ekosysteemien rakenne ja dynaamisuus	upperSecondarySchoolContentsNew		6832874	\N
64	78	teaches	hiilen, typen ja fosforin kierto ja energian virtaus ekosysteemissä	upperSecondarySchoolContentsNew		6832875	\N
65	78	teaches	populaatioiden ominaisuudet	upperSecondarySchoolContentsNew		6832876	\N
66	81	educationalSubject	Hevostalouden perustutkinto	vocationalDegrees		1568687	\N
282	234	teaches	ymmärtää, kuinka tieto hiiliyhdisteistä rakentuu kokeellisen toiminnan ja siihen kytkeytyvän mallintamisen kautta	upperSecondarySchoolObjectivesNew		6833465	\N
69	99	educationalSubject	sdfs	earlyChildhoodEducationSubjects		sdfs	\N
70	100	educationalSubject	asdasdsa	prePrimaryEducationSubjects		asdasdsa	\N
71	101	educationalSubject	Autoalan perustutkinto	vocationalDegrees		1536551	\N
72	103	educationalSubject	Saamen kieli ja kirjallisuus	basicStudySubjects		530529	\N
835	249	educationalSubject	ohjelmointi	selfMotivatedEducationSubjects		ohjelmointi	\N
1234	257	educationalSubject	Juutalainen uskonto	upperSecondarySchoolSubjectsNew		6834384	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6828810/lops2019/oppiaineet/6834384
76	103	teaches	ymmärtää katsomusten, kulttuurien ja yhteiskuntamuotojen jatkuvaa historiallista muuttumista sekä osaa sen perusteella eritellä erilaisten maailmankatsomusten piirteitä ja lähtökohtia	upperSecondarySchoolObjectivesNew		6834926	\N
77	103	teaches	poliittisia maailmankatsomuksia, kuten liberalismi, sosialismi ja nationalismi; katsomusten ilmeneminen elämäntavassa, taiteessa, urheilussa sekä suhteessa luontoon ja ympäristöön	upperSecondarySchoolContentsNew		6865956	\N
78	108	educationalSubject	Biologia	basicStudySubjects		478970	\N
79	108	teaches	T1 ohjata oppilasta ymmärtämään ekosysteemin perusrakennetta ja toimintaa sekä vertailemaan erilaisia ekosysteemejä ja tunnistamaan lajeja	basicStudyObjectives		478886	\N
80	108	teaches	S2 Tutkimusretkiä luontoon ja lähiympäristöön	basicStudyContents		479041	\N
83	108	teaches	hallitsee käsitteitä, tietoa ja taitoja, joiden avulla hän osaa pohtia ja analysoida maailmankatsomuksellisiin järjestelmiin, kuten sekulaariin humanismiin ja uskontoihin, liittyviä kysymyksiä sekä muodostaa niihin oman perustellun kantansa	upperSecondarySchoolObjectivesNew		6834949	\N
84	108	educationalSubject	Kasvatustieteet	branchesOfScience		516	\N
85	108	teaches	tekijänoikeudet opetuksessa	scienceBranchObjectives		tekijnoikeudetopetuksessa	\N
86	108	requires	creative commons -lisenssit	prerequisites		creativecommonslisenssit	\N
91	127	teaches	osaa selittää elämän tunnusmerkit ja perusedellytykset sekä tunnistaa niitä esimerkeistä	upperSecondarySchoolObjectivesNew		6832836	\N
92	127	teaches	hahmottaa ja osaa analysoida muinaissuomalaisten uskontoperinteiden merkitystä suomalaisessa kulttuuriperinnössä, kristinuskoa yhteiskunnan muokkaajana Suomessa ennen ja nyt sekä niiden vaikutusta islamiin Suomessa	upperSecondarySchoolObjectivesNew		6834582	\N
93	127	teaches	elämän tunnuspiirteet ja organisaatiotasot	upperSecondarySchoolContentsNew		6832842	\N
94	127	teaches	Suomen uskontotilanne, suomalainen uskonnollisuus ja sekularisaatio	upperSecondarySchoolContentsNew		6834585	\N
95	128	educationalSubject	Muu oppilaan äidinkieli	basicStudySubjects	aa	692136	\N
96	128	educationalSubject	Romanikieli ja kirjallisuus	basicStudySubjects	aa	605635	\N
97	128	teaches	T1 rohkaista oppilasta ilmaisemaan itseään romanikielellä sekä toimimaan monikielisissä ja -kulttuurisissa vuorovaikutustilanteissa	basicStudyObjectives	aa	727097	\N
98	128	teaches	T2 ohjata oppilasta rakentavaan vuorovaikutukseen, kehittämään ilmaisuaan sekä kykyään antaa ja vastaanottaa palautetta	basicStudyObjectives	aa	727098	\N
99	128	teaches	S1 Vuorovaikutustilanteissa toimiminen	basicStudyContents	aa	719409	\N
100	128	teaches	S4 Kielen, kirjallisuuden ja kulttuurin ymmärtäminen	basicStudyContents	aa	727922	\N
105	128	teaches	osaa solun perusrakennetta ja toimintaa tasolla, joka mahdollistaa evoluution ja ekosysteemin toiminnan ymmärtämisen	upperSecondarySchoolObjectivesNew		6832837	\N
106	128	teaches	osaa jäsentää nykyisen eliökunnan rakenteen	upperSecondarySchoolObjectivesNew		6832839	\N
107	128	teaches	elämän tunnuspiirteet ja organisaatiotasot	upperSecondarySchoolContentsNew		6832842	\N
108	144	educationalSubject	Historia	basicStudySubjects	Perusopetuksen opetussuunnitelma 2014	466345	\N
109	144	teaches	T5 ohjata oppilasta ymmärtämään ihmisen toiminnan motiiveja	basicStudyObjectives	Perusopetuksen opetussuunnitelma 2014	472330	\N
110	144	teaches	L4 Monilukutaito	basicStudyContents	Perusopetuksen opetussuunnitelma 2014	428673	\N
111	144	teaches	S4 Uuden ajan murrosvaihe	basicStudyContents	Perusopetuksen opetussuunnitelma 2014	471927	\N
112	144	requires	tekijänoikeudet	prerequisites		tekijnoikeudet	\N
113	160	educationalSubject	Kone- ja tuotantotekniikan perustutkinto	vocationalDegrees	Kone- ja tuotankotekniikan opetussuunnitelma	1978990	\N
117	160	educationalSubject	Sähkö-, automaatio- ja tietoliikennetekniikka, elektroniikka	branchesOfScience		213	\N
73	103	educationalSubject	Äidinkieli ja kirjallisuus	upperSecondarySchoolSubjectsNew		6828950	\N
74	103	educationalSubject	Elämänkatsomustieto	upperSecondarySchoolSubjectsNew		6834385	\N
81	108	educationalSubject	Elämänkatsomustieto	upperSecondarySchoolSubjectsNew		6834385	\N
87	127	educationalSubject	Biologia	upperSecondarySchoolSubjectsNew		6832790	\N
88	127	educationalSubject	Islamin uskonto	upperSecondarySchoolSubjectsNew		6834381	\N
67	81	educationalSubject	Työpaikkaohjaajaksi valmentautuminen	vocationalUnits		633	\N
68	81	educationalSubject	Yritystoiminnan suunnittelu	vocationalUnits		632	\N
114	160	educationalSubject	Konepajamittaukset	vocationalUnits		2000461	\N
115	160	educationalSubject	Manuaalikoneistus	vocationalUnits		1994388	\N
116	160	educationalSubject	Koneasennus	vocationalUnits		2002430	\N
118	160	educationalSubject	Kone- ja valmistustekniikka	branchesOfScience		214	\N
119	160	educationalSubject	Materiaalitekniikka	branchesOfScience		216	\N
131	177	educationalSubject	Matematiikka	branchesOfScience		111	\N
122	168	teaches	analysoi esimerkiksi taiteissa, uskonnossa ja sosiaalisissa rakenteissa esiintyviä kulttuurisia arvoja ja käytäntöjä	upperSecondarySchoolObjectivesNew		6834059	\N
123	168	teaches	Afrikan kulttuurit	upperSecondarySchoolContentsNew		6834067	\N
124	168	educationalSubject	Sosiaali- ja terveysalan perustutkinto	vocationalDegrees		1724172	\N
126	168	educationalSubject	matematiikka	selfMotivatedEducationSubjects		matematiikka	\N
127	168	teaches	tekijänoikeuksien ymmärtäminen opetuksessa	selfMotivatedEducationObjectives		tekijnoikeuksienymmrtminenopetuksessa	\N
128	168	teaches	avoimen julkaisun periaatteet	selfMotivatedEducationObjectives		avoimenjulkaisunperiaatteet	\N
129	176	educationalSubject	Educational sciences	branchesOfScience		516	\N
132	183	educationalSubject	Elämänkatsomustieto	basicStudySubjects		502088	\N
133	183	teaches	T9 innostaa oppilasta pohtimaan omien valintojensa vaikutusta kestävään tulevaisuuteen paikallisesti ja globaalisti	basicStudyObjectives		525168	\N
134	183	educationalSubject	Avaruustieteet ja tähtitiede	branchesOfScience		115	\N
135	183	teaches	fysiikan perusteet	scienceBranchObjectives		fysiikanperusteet	\N
136	183	requires	matematiikan perusteet	prerequisites		matematiikanperusteet	\N
137	184	educationalSubject	Biologia	basicStudySubjects		478970	\N
138	184	educationalSubject	Matematiikka	basicStudySubjects		466344	\N
139	184	teaches	T1 pitää yllä oppilaan innostusta ja kiinnostusta matematiikkaa kohtaan sekä tukea myönteistä minäkuvaa ja itseluottamusta	basicStudyObjectives		469462	\N
140	184	teaches	T3 ohjata oppilasta kehittämään taitoaan esittää kysymyksiä ja tehdä perusteltuja päätelmiä havaintojensa pohjalta	basicStudyObjectives		469464	\N
141	184	teaches	T7 ohjata oppilasta kehittämään luonnontieteellistä ajattelutaitoa sekä syy- ja seuraussuhteiden ymmärtämistä	basicStudyObjectives		495017	\N
142	184	teaches	T10 ohjata oppilasta tekemään tutkimuksia sekä koulussa että koulun ulkopuolella	basicStudyObjectives		495690	\N
143	184	teaches	L1 Ajattelu ja oppimaan oppiminen	basicStudyContents		428670	\N
144	189	educationalSubject	tähtitiede	earlyChildhoodEducationSubjects		thtitiede	\N
145	193	educationalSubject	Suomen kieli ja kirjallisuus	basicStudySubjects	Perusopetuksen opetussuunnitelma 2014	466341	\N
146	193	educationalSubject	Svenska och litteratur	basicStudySubjects	Perusopetuksen opetussuunnitelma 2014	739610	\N
147	193	teaches	T1 ohjata oppilasta vahvistamaan taitoaan toimia erilaisissa vuorovaikutustilanteissa	basicStudyObjectives	Perusopetuksen opetussuunnitelma 2014	466660	\N
148	193	teaches	T13 innostaa oppilasta kuuntelemaan ja lukemaan lapsille suunnattua kirjallisuutta ja valitsemaan itseään kiinnostavaa luettavaa, kehittämään lukuharrastustaan sekä ohjata oppilasta kirjaston käyttöön	basicStudyObjectives	Perusopetuksen opetussuunnitelma 2014	592970	\N
149	193	teaches	M13 uppmuntra eleven att lyssna till och själv läsa litteratur för barn, att hitta intressant läsning och utveckla sitt läsintresse och använda sig av bibliotek	basicStudyObjectives	Perusopetuksen opetussuunnitelma 2014	753893	\N
150	193	teaches	M1 stödja eleven i att stärka sin förmåga att uttrycka sig och fungera i olika kommunikationssituationer	basicStudyObjectives	Perusopetuksen opetussuunnitelma 2014	748931	\N
151	193	teaches	L1 Ajattelu ja oppimaan oppiminen	basicStudyContents	Perusopetuksen opetussuunnitelma 2014	428670	\N
152	193	teaches	L7 Osallistuminen, vaikuttaminen ja kestävän tulevaisuuden rakentaminen	basicStudyContents	Perusopetuksen opetussuunnitelma 2014	428676	\N
153	193	teaches	S1 Vuorovaikutustilanteissa toimiminen	basicStudyContents	Perusopetuksen opetussuunnitelma 2014	466630	\N
154	193	teaches	I1 Att kommunicera	basicStudyContents	Perusopetuksen opetussuunnitelma 2014	747903	\N
155	193	educationalSubject	Kasvatustieteet	branchesOfScience	Helsingin yliopiston varhaiskasvatuksen opettajan tutkinnon perusteet	516	\N
156	193	teaches	leikki-ikäisten pedagogiikka	scienceBranchObjectives		leikkiikistenpedagogiikka	\N
157	193	requires	oppimistaidot	prerequisites		oppimistaidot	\N
895	203	educationalSubject	käsityö	prePrimaryEducationSubjects		ksity	\N
901	203	requires	teen juominen	prerequisites		teenjuominen	\N
192	207	teaches	T5 ohjata oppilaita asettamaan sekä pitkän että lyhyen aikavälin tavoitteita, tekemään niitä koskevia suunnitelmia sekä arvioimaan niiden toteutumista	basicStudyObjectives		715515	\N
120	168	educationalSubject	Historia	upperSecondarySchoolSubjectsNew		6832796	\N
125	168	educationalSubject	Yhteiskunnassa ja työelämässä tarvittava osaaminen	vocationalUnits		1805904	\N
193	207	teaches	S1 Terveyttä tukeva kasvu ja kehitys	basicStudyContents		489256	\N
191	207	educationalSubject	Terveystieto	basicStudySubjects		478973	\N
1235	257	educationalSubject	Uskonto ilmiönä – juutalaisuuden, kristinuskon ja islamin jäljillä	upperSecondarySchoolModulesNew		6834655	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6828810/lops2019/oppiaineet/6834384/moduulit/6834655
1236	257	educationalSubject	Maailman uskontoja ja uskonnollisia liikkeitä	upperSecondarySchoolModulesNew		6834657	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6828810/lops2019/oppiaineet/6834384/moduulit/6834657
1237	257	teaches	kehittää valmiuksia toimia moniuskontoisessa ja kulttuurisesti moninaisessa ympäristössä ja työelämässä sekä keskustella uskontoihin liittyvistä ajankohtaisista kysymyksistä	upperSecondarySchoolObjectivesNew		6834752	\N
212	215	educationalSubject	Maantieto	basicStudySubjects		478971	\N
213	215	educationalSubject	Hammastekniikan perustutkinto	vocationalDegrees		1571583	\N
214	215	educationalSubject	Hotelli-, ravintola- ja catering-alan perustutkinto	vocationalDegrees		616	\N
215	215	educationalSubject	Huippuosaajana toimiminen	vocationalUnits		635	\N
185	203	educationalSubject	Historia	upperSecondarySchoolSubjectsNew		6832796	\N
187	203	teaches	osaa eritellä tieteen saavutusten merkitystä ja eri aikakausien maailmankuvia	upperSecondarySchoolObjectivesNew		6833997	\N
176	202	educationalSubject	Suomen kieli ja kirjallisuus	basicStudySubjects		466341	\N
177	202	teaches	T1 ohjata oppilasta laajentamaan taitoaan toimia tavoitteellisesti, motivoituneesti, eettisesti ja rakentavasti erilaisissa viestintäympäristöissä	basicStudyObjectives		721290	\N
178	202	teaches	L5 Tieto- ja viestintäteknologinen osaaminen	basicStudyContents		428674	\N
179	202	teaches	S3 Tekstien tuottaminen	basicStudyContents		719402	\N
180	202	educationalSubject	Tekstiili- ja vaatetusalan perustutkinto	vocationalDegrees		1742267	\N
181	202	educationalSubject	Turvallisuusalan perustutkinto	vocationalDegrees		1568684	\N
188	203	teaches	demokratian ja tasa-arvoajattelun leviäminen sekä niiden vastavoimat	upperSecondarySchoolContentsNew		6834015	\N
189	203	educationalSubject	Teknillinen kemia, kemian prosessitekniikka	branchesOfScience		215	\N
912	200	educationalSubject	Elämänkatsomustieto	upperSecondarySchoolSubjectsNew		6834385	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6828810/lops2019/oppiaineet/6834385
913	200	educationalSubject	Katsomukset	upperSecondarySchoolModulesNew		6834844	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6828810/lops2019/oppiaineet/6834385/moduulit/6834844
216	215	educationalSubject	Majoitusliikkeen varaustoiminnot	vocationalUnits		26753	\N
217	215	teaches	hiustenhoito	vocationalEducationObjectives		hiustenhoito	\N
219	216	educationalSubject	Suomi saamenkielisille	basicStudySubjects		692139	\N
220	216	educationalSubject	Kuvataide	basicStudySubjects		466342	\N
221	216	teaches	T2 rohkaista oppilasta keskustelemaan omista ja muiden havainnoista ja ajatuksista sekä perustelemaan näkemyksiään	basicStudyObjectives		662003	\N
222	216	teaches	T8 ohjata oppilasta tarkastelemaan taiteen ja muun visuaalisen kulttuurin merkitystä yksilölle, yhteisölle ja yhteiskunnalle historian ja kulttuurin näkökulmista	basicStudyObjectives		662009	\N
223	216	teaches	L4 Monilukutaito	basicStudyContents		428673	\N
224	216	teaches	L3 Itsestä huolehtiminen ja arjen taidot	basicStudyContents		428672	\N
225	216	requires	android	prerequisites		android	\N
226	217	educationalSubject	Kemia	basicStudySubjects		466347	\N
227	217	teaches	T9 ohjata oppilasta käyttämään tieto- ja viestintäteknologiaa tiedon ja tutkimustulosten hankkimiseen, käsittelemiseen ja esittämiseen sekä tukea oppilaan oppimista havainnollistavien simulaatioiden avulla	basicStudyObjectives		476833	\N
182	202	educationalSubject	Vaateompelun ammatillisen projektityön toteuttaminen	vocationalUnits		156933	\N
183	202	educationalSubject	Mattohuollon tehtävisä toimiminen	vocationalUnits		160768	\N
184	202	educationalSubject	Sosiaalinen ja kulttuurinen osaaminen	vocationalUnits		1678016	\N
218	215	educationalSubject	Geotieteet	branchesOfScience		1171	\N
914	200	educationalSubject	Kulttuurit	upperSecondarySchoolModulesNew		6834843	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6828810/lops2019/oppiaineet/6834385/moduulit/6834843
190	207	educationalSubject	Oppilaanohjaus	basicStudySubjects		605632	\N
228	217	teaches	L4 Monilukutaito	basicStudyContents		428673	\N
229	217	teaches	L6 Työelämätaidot ja yrittäjyys	basicStudyContents		428675	\N
230	217	teaches	S4 Kemia maailmankuvan rakentajana	basicStudyContents		474889	\N
231	217	teaches	S2 Kemia omassa elämässä ja elinympäristössä	basicStudyContents		474887	\N
236	222	educationalSubject	Kemia	basicStudySubjects		466347	\N
237	222	educationalSubject	Kotitalous	basicStudySubjects		502086	\N
238	222	teaches	T2 ohjata ja kannustaa oppilasta tunnistamaan omaa kemian osaamistaan, asettamaan tavoitteita omalle työskentelylleen sekä työskentelemään pitkäjänteisesti	basicStudyObjectives		474976	\N
239	222	teaches	T11 ohjata oppilasta käyttämään erilaisia malleja kuvaamaan ja selittämään aineen rakennetta ja kemiallisia ilmiöitä	basicStudyObjectives		476835	\N
240	222	teaches	T3 ohjata ja rohkaista oppilasta valitsemaan ja käyttämään hyvinvointia edistävästi ja kestävän kulutuksen mukaisesti materiaaleja, työvälineitä, laitteita sekä tieto- ja viestintäteknologiaa	basicStudyObjectives		509926	\N
241	224	educationalSubject	test	earlyChildhoodEducationSubjects	test	test	\N
242	224	teaches	test	earlyChildhoodEducationObjectives		test	\N
243	230	educationalSubject	Evankelisluterilainen uskonto	basicStudySubjects		502089	\N
244	231	educationalSubject	Viittomakieli ja kirjallisuus	basicStudySubjects	Perusopetuksen opetussuunnitelma 2014	692135	\N
245	231	educationalSubject	Elämänkatsomustieto	basicStudySubjects	Perusopetuksen opetussuunnitelma 2014	502088	\N
200	208	teaches	leikkiminen	earlyChildhoodEducationObjectives		leikkiminen	\N
232	220	educationalSubject	Suomi saamenkielisille	basicStudySubjects		692139	\N
233	220	educationalSubject	Saamen kieli ja kirjallisuus	basicStudySubjects		530529	\N
234	220	educationalSubject	Suomi toisena kielenä ja kirjallisuus	basicStudySubjects		692137	\N
235	220	requires	sijaismuodot	prerequisites		sijaismuodot	\N
246	231	teaches	T1 ohjata oppilasta tunnistamaan, ymmärtämään ja käyttämään katsomuksellisia käsitteitä	basicStudyObjectives	Perusopetuksen opetussuunnitelma 2014	525160	\N
247	231	teaches	T2 ohjata oppilasta tunnistamaan ja arvioimaan väitteitä ja niiden perusteluita	basicStudyObjectives	Perusopetuksen opetussuunnitelma 2014	524991	\N
248	231	teaches	T3 ohjata oppilasta arvostamaan omaa ja muiden ajattelua	basicStudyObjectives	Perusopetuksen opetussuunnitelma 2014	524843	\N
249	231	teaches	T6 rohkaista oppilasta monipuolistamaan ilmaisuaan ja syventämään tietoaan viittomakielen rakenteista, viittoman muodostumisesta ja ilmaisutavoista	basicStudyObjectives	Perusopetuksen opetussuunnitelma 2014	747614	\N
250	231	teaches	L1 Ajattelu ja oppimaan oppiminen	basicStudyContents	Perusopetuksen opetussuunnitelma 2014	428670	\N
251	231	teaches	S2 Erilaisia elämäntapoja	basicStudyContents	Perusopetuksen opetussuunnitelma 2014	523458	\N
252	231	teaches	S4 Kielen, kirjallisuuden ja kulttuurin ymmärtäminen	basicStudyContents	Perusopetuksen opetussuunnitelma 2014	727926	\N
253	231	teaches	S1 Vuorovaikutustilanteissa toimiminen	basicStudyContents	Perusopetuksen opetussuunnitelma 2014	715684	\N
254	231	educationalSubject	Aktiivinen elämäntapa	upperSecondarySchoolSubjects	Lukion opetussuunnitelman perusteet 2015	LI2	\N
255	231	teaches	Tavoite elämälle	upperSecondarySchoolObjectives		Tavoiteelmlle	\N
1238	257	teaches	osaa jäsentää uskontoa ja uskonnottomuutta ilmiöinä	upperSecondarySchoolObjectivesNew		6834750	\N
1239	257	teaches	uskontojen merkitys kestävän tulevaisuuden rakentamisessa sekä muita ajankohtaisia uskontoihin ja katsomuksiin liittyviä kysymyksiä	upperSecondarySchoolContentsNew		6834755	\N
259	231	teaches	osaa eritellä maailman- ja elämänkatsomuksen sekä maailmankuvan käsitteitä, arvioida niihin liittyviä perusteita sekä erottaa katsomukselliset ja arvokysymykset mielipidekysymyksistä	upperSecondarySchoolObjectivesNew		6834925	\N
260	231	teaches	perehtyy suuriin maailmanuskontoihin ja hahmottaa niiden keskeisiä piirteitä, sisäistä monimuotoisuutta sekä vaikutusta kulttuuriin ja yhteiskuntaan	upperSecondarySchoolObjectivesNew		6834950	\N
261	231	teaches	poliittisia maailmankatsomuksia, kuten liberalismi, sosialismi ja nationalismi; katsomusten ilmeneminen elämäntavassa, taiteessa, urheilussa sekä suhteessa luontoon ja ympäristöön	upperSecondarySchoolContentsNew		6865956	\N
262	231	teaches	uskonnon ja uskonnottomuuden näkyminen ja vaikutus arkielämässä, politiikassa ja oikeudenkäytössä: liberaali ja fundamentalistinen uskonnollisuus, tapauskonnollisuus, uudet uskonnolliset liikkeet, sekularisaatio ja julkisen vallan tunnustuksettomuuden periaate	upperSecondarySchoolContentsNew		6834956	\N
263	231	teaches	ateismi, agnostismi, uskonnottomuus ja sekulaarin humanismin maailmankatsomukselliset perusteet	upperSecondarySchoolContentsNew		6834955	\N
264	231	educationalSubject	Autoalan perustutkinto	vocationalDegrees	Autoalan perustutkinto Kivikkolan laitoksessa	1536551	\N
267	231	teaches	Rengaiden vaihto	vocationalEducationObjectives		Rengaidenvaihto	\N
268	231	teaches	Eteneminen autolla	vocationalEducationObjectives		Eteneminenautolla	\N
269	231	requires	Kasvatuksen tarkoitus	prerequisites		Kasvatuksentarkoitus	\N
270	231	requires	Väsyminen päivän päätteksi	prerequisites		Vsyminenpivnptteksi	\N
927	207	requires	esteettömyys	prerequisites		esteettmyys	\N
846	247	educationalSubject	Opinto-ohjaus	upperSecondarySchoolSubjectsNew		6835370	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6828810/lops2019/oppiaineet/6835370
1296	294	educationalSubject	Saamen kieli ja kirjallisuus	basicStudySubjects		530529	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/530529
256	231	educationalSubject	Elämänkatsomustieto	upperSecondarySchoolSubjectsNew		6834385	\N
265	231	educationalSubject	Huolto- ja korjaustyöt	vocationalUnits		7706	\N
266	231	educationalSubject	Rengastyöt	vocationalUnits		9009	\N
186	203	educationalSubject	Eurooppalainen ihminen	upperSecondarySchoolModulesNew		6833834	\N
286	235	educationalSubject	Muu oppilaan äidinkieli	basicStudySubjects		692136	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/692136
289	235	teaches	osaa selittää elämän tunnusmerkit ja perusedellytykset sekä tunnistaa niitä esimerkeistä	upperSecondarySchoolObjectivesNew		6832836	\N
290	235	teaches	elämän tunnuspiirteet ja organisaatiotasot	upperSecondarySchoolContentsNew		6832842	\N
55	78	educationalSubject	Elämä ja evoluutio	upperSecondarySchoolModulesNew		6832648	\N
56	78	educationalSubject	Ekologian perusteet	upperSecondarySchoolModulesNew		6832649	\N
75	103	educationalSubject	Katsomukset	upperSecondarySchoolModulesNew		6834844	\N
82	108	educationalSubject	Uskonnot ja uskonnottomuus	upperSecondarySchoolModulesNew		6834845	\N
89	127	educationalSubject	Elämä ja evoluutio	upperSecondarySchoolModulesNew		6832648	\N
90	127	educationalSubject	Uskonto, kulttuuri ja yhteiskunta Suomessa	upperSecondarySchoolModulesNew		6834456	\N
103	128	educationalSubject	Elämä ja evoluutio	upperSecondarySchoolModulesNew		6832648	\N
104	128	educationalSubject	Ekologian perusteet	upperSecondarySchoolModulesNew		6832649	\N
121	168	educationalSubject	Maailman kulttuurit kohtaavat	upperSecondarySchoolModulesNew		6833836	\N
257	231	educationalSubject	Uskonnot ja uskonnottomuus	upperSecondarySchoolModulesNew		6834845	\N
258	231	educationalSubject	Katsomukset	upperSecondarySchoolModulesNew		6834844	\N
205	208	educationalSubject	Yhteiskuntafilosofia	upperSecondarySchoolModulesNew		6833504	\N
1293	279	educationalSubject	koulutus-, johtamis- ja opetushenkilöstön kompetenssien korottaminen vailinnaisen osaamisen tietoteknisisssä taidoissa, nimellisesti ohjelmoinnissa	selfMotivatedEducationSubjects		koulutusjohtamisjaopetushenkilstnkompetenssienkorottaminenvailinnaisenosaamisentietoteknisissstaidoissanimellisestiohjelmoinnissa	\N
288	235	educationalSubject	Elämä ja evoluutio	upperSecondarySchoolModulesNew		6832648	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6828810/lops2019/oppiaineet/6832790/moduulit/6832648
101	128	educationalSubject	Biologia	upperSecondarySchoolSubjectsNew		6832790	\N
102	128	educationalSubject	Filosofia	upperSecondarySchoolSubjectsNew		6832794	\N
194	207	teaches	S3 Opiskelussa ja työelämässä tarvittavat taidot	basicStudyContents		605815	\N
195	207	teaches	L2 Kulttuurinen osaaminen, vuorovaikutus ja ilmaisu	basicStudyContents		428671	\N
287	235	educationalSubject	Biologia	upperSecondarySchoolSubjectsNew		6832790	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6828810/lops2019/oppiaineet/6832790
471	231	educationalSubject	kukkien kastelu	prePrimaryEducationSubjects	Esiops	kukkienkastelu	\N
634	231	educationalSubject	sohvatyynyt	prePrimaryEducationSubjects	Esiops 2	sohvatyynyt	\N
662	178	educationalSubject	Matematiikka	branchesOfScience	suunnitelma	111	https://virkailija.opintopolku.fi/koodisto-service/rest/codeelement/tieteenala_111
271	234	educationalSubject	Saamen kieli ja kirjallisuus	basicStudySubjects	Perusopetuksen opetussuunnitelma 2016	530529	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/530529
272	234	educationalSubject	Suomen kieli ja kirjallisuus	basicStudySubjects	Perusopetuksen opetussuunnitelma 2016	466341	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/466341
283	234	teaches	suhdekaavan ja molekyylikaavan selvittäminen laskennallisesti sekä rakenneisomeria	upperSecondarySchoolContentsNew		6833472	\N
196	207	educationalSubject	Yhteiskuntaoppi	upperSecondarySchoolSubjectsNew		6832797	\N
197	207	educationalSubject	Lakitieto	upperSecondarySchoolModulesNew		6834210	\N
198	207	teaches	tuntee oikeutensa ja velvollisuutensa kansalaisena, työntekijänä ja kuluttajana sekä osaa soveltaa tätä tietoa tavanomaisia oikeusasioita koskeviin kysymyksiin	upperSecondarySchoolObjectivesNew		6834230	\N
199	207	teaches	oikeusjärjestys ja tuomioistuinlaitos	upperSecondarySchoolContentsNew		6834236	\N
1249	177	requires	Videoiden editoiminen	prerequisites		videoideneditoiminen	\N
1255	284	requires	Videoiden editoiminen	prerequisites		videoideneditoiminen	\N
1256	285	educationalSubject	Matematiikka	basicStudySubjects		466344	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/466344
1257	285	teaches	T14 ohjata oppilasta ymmärtämään tuntemattoman käsite ja kehittämään yhtälönratkaisutaitojaan	basicStudyObjectives		748724	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/466344
1284	296	educationalSubject	Biologia	basicStudySubjects	Lorem ipsum dolor sit amet, consectetur porttitor.	478970	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/478970
273	234	teaches	T3 tukea oppilasta vahvistamaan ilmaisurohkeuttaan ja ohjata häntä ilmaisemaan itseään kokonaisvaltaisesti, myös draaman avulla	basicStudyObjectives	Perusopetuksen opetussuunnitelma 2016	592950	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/466341
274	234	teaches	T4 ohjata oppilasta rakentamaan viestijäkuvaansa ja ymmärtämään, että ihmiset viestivät eri tavoin	basicStudyObjectives	Perusopetuksen opetussuunnitelma 2016	592951	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/466341
275	234	teaches	L4 Monilukutaito	basicStudyContents	Perusopetuksen opetussuunnitelma 2016	428673	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/laajaalaisetosaamiset/428673
276	234	teaches	L7 Osallistuminen, vaikuttaminen ja kestävän tulevaisuuden rakentaminen	basicStudyContents	Perusopetuksen opetussuunnitelma 2016	428676	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/laajaalaisetosaamiset/428676
284	234	educationalSubject	Kasvatustieteet	branchesOfScience		516	https://virkailija.opintopolku.fi/koodisto-service/rest/codeelement/tieteenala_516
285	234	teaches	tiedonhaku kandia varten	scienceBranchObjectives		tiedonhakukandiavarten	\N
1012	265	educationalSubject	Kasvatustieteet	branchesOfScience		516	https://virkailija.opintopolku.fi/koodisto-service/rest/codeelement/tieteenala_516
1013	267	educationalSubject	Muu oppilaan äidinkieli	basicStudySubjects		692136	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/692136
1014	267	teaches	L1 Ajattelu ja oppimaan oppiminen	basicStudyContents		428670	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/laajaalaisetosaamiset/428670
1015	267	educationalSubject	Elämänkatsomustieto	upperSecondarySchoolSubjectsNew		6834385	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6828810/lops2019/oppiaineet/6834385
1016	267	educationalSubject	Tilastotiede	branchesOfScience		112	https://virkailija.opintopolku.fi/koodisto-service/rest/codeelement/tieteenala_112
208	208	teaches	osaa soveltaa oppimaansa ajankohtaisiin yhteiskunnallisiin kysymyksiin	upperSecondarySchoolObjectivesNew		6833623	\N
209	208	teaches	poliittiset ihanteet: liberalismi, sosialismi, anarkismi, konservatismi, nationalismi; yhteiskunnalliset utopiat ja dystopiat	upperSecondarySchoolContentsNew		6833628	\N
915	200	teaches	osaa hahmottaa erilaiset elämänkatsomukselliset ratkaisut ja identiteettivalinnat sekä maailman kulttuurisen moninaisuuden rikkautena ja perustella niiden yhdenvertaisen kohtelun	upperSecondarySchoolObjectivesNew		6834915	\N
916	200	teaches	ymmärtää katsomusten, kulttuurien ja yhteiskuntamuotojen jatkuvaa historiallista muuttumista sekä osaa sen perusteella eritellä erilaisten maailmankatsomusten piirteitä ja lähtökohtia	upperSecondarySchoolObjectivesNew		6834926	\N
977	200	requires	käsityöt	prerequisites		ksityt	\N
1215	268	educationalSubject	kukkija	earlyChildhoodEducationSubjects		kukkija	\N
1216	268	educationalSubject	polku	prePrimaryEducationSubjects		polku	\N
790	241	educationalSubject	elokuvat	selfMotivatedEducationSubjects		elokuvat	\N
791	241	teaches	projektityö	selfMotivatedEducationObjectives		projektity	\N
792	241	requires	valokuvaus	prerequisites		valokuvaus	\N
1258	285	teaches	T20 ohjata oppilasta kehittämään algoritmista ajatteluaan sekä taitojaan soveltaa matematiikkaa ja ohjelmointia ongelmien ratkaisemiseen	basicStudyObjectives		748930	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/466344
1259	285	teaches	L5 Tieto- ja viestintäteknologinen osaaminen	basicStudyContents		428674	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/laajaalaisetosaamiset/428674
1260	285	teaches	S1 Ajattelun taidot	basicStudyContents		469269	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/466344
1261	285	educationalSubject	Kasvatustieteet	branchesOfScience		516	https://virkailija.opintopolku.fi/koodisto-service/rest/codeelement/tieteenala_516
1297	294	teaches	T9 kannustaa oppilasta kehittämään tekstin tuottamisen prosesseja ja taitoa arvioida omia tekstejä, tarjota mahdollisuuksia rakentavan palautteen antamiseen ja saamiseen, ohjata ottamaan huomioon tekstin vastaanottaja sekä toimimaan eettisesti verkossa yksityisyyttä ja tekijänoikeuksia kunnioittaen	basicStudyObjectives		722524	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/530529
210	208	teaches	vallan, vapauden, tasa-arvon ja oikeudenmukaisuuden eri muodot	upperSecondarySchoolContentsNew		6833626	\N
347	208	educationalSubject	Matematiikka	branchesOfScience	Testi	111	https://virkailija.opintopolku.fi/koodisto-service/rest/codeelement/tieteenala_111
211	208	requires	leikkiminen	prerequisites		leikkiminen	\N
1225	271	educationalSubject	Suomi viittomakielisille	basicStudySubjects	Perusopetuksen opetussuunnitelma 2014	712901	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/712901
1226	271	educationalSubject	Suomi toisena kielenä ja kirjallisuus	basicStudySubjects	Perusopetuksen opetussuunnitelma 2014	692137	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/692137
1230	271	teaches	L4 Monilukutaito	basicStudyContents	Perusopetuksen opetussuunnitelma 2014	428673	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/laajaalaisetosaamiset/428673
1302	304	educationalSubject	Biologia	basicStudySubjects	ads	478970	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/478970
1294	279	teaches	koulutus- johtamis- ja opetushnekilöstön kompetenssien korottaminen valinnaisen osaamisen tietoteknisissä taidoissa, nimellisesti ohjelmoinnissa, varsinaisesti korottaen kommunikaatioon, ymmärrykseen ja yhteiskunnalliseen osaamiseen liittyvää kompetenssia, jota kaikilta koulutus-, johtamis- ja opetushenkilöstöltä vaaditaan. Tavoitte linjautuu perusokoulun vuoden 2014 opetussuunnitelman tavoitteiden toteuttamiseen ja tarjoaa todelliset valmiudet opetuksen suunnitteluun, toteuttamiseen ja arviointiin opetussuunnitelman ohjelmointiin liittyvien aiheiden osalta	selfMotivatedEducationObjectives		koulutusjohtamisjaopetushnekilstnkompetenssienkorottaminenvalinnaisenosaamisentietoteknisisstaidoissanimellisestiohjelmoinnissavarsinaisestikorottaenkommunikaatioonymmrrykseenjayhteiskunnalliseenosaamiseenliittyvkompetenssiajotakaikiltakoulutusjohtamisjaopetushenkilstltvaaditaantavoittelinjautuuperusokoulunvuoden2014opetussuunnitelmantavoitteidentoteuttamiseenjatarjoaatodellisetvalmiudetopetuksensuunnitteluuntoteuttamiseenjaarviointiinopetussuunnitelmanohjelmointiinliittyvienaiheidenosalta	\N
1295	279	requires	Koulutuksen-, johtamisen- tai opetuksen ylempi korkeakoulututkinto, joka on suoritettu aikaisintaan 2000-luvun alkupuolella, sekä siihen liittyvät valinnaiset opinnot jatkuvan oppimisen, monitieteisyyden ja rauhankasvatuksen alalta.	prerequisites		koulutuksenjohtamisentaiopetuksenylempikorkeakoulututkintojokaonsuoritettuaikaisintaan2000luvunalkupuolellaseksiihenliittyvtvalinnaisetopinnotjatkuvanoppimisenmonitieteisyydenjarauhankasvatuksenalalta	\N
1483	356	teaches	käyttää äänentoistoon liittyvää terminologiaa	vocationalRequirements		2059	\N
1484	356	teaches	uusi testi	vocationalRequirements		uusitesti	\N
1490	356	teaches	tunnistaa musiikkialan keskeiset toimintatavat	vocationalRequirements		2254	\N
1792	396	educationalSubject	Elintarviketeollisuuden ammattitutkinto	furtherVocationalQualifications		2270455	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/2270455
1793	396	educationalSubject	Elintarvikejalostuksen ammattitutkinto	furtherVocationalQualifications		2270454	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/2270454
1794	396	educationalSubject	Matkailupalvelujen ammattitutkinto (Tuleva)	furtherVocationalQualifications		7104540	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/7104540
1298	294	teaches	S4 Kielen, kirjallisuuden ja kulttuurin ymmärtäminen	basicStudyContents		593371	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/530529
1299	297	educationalSubject	Suomen kieli ja kirjallisuus	basicStudySubjects		466341	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/466341
1300	297	teaches	T2 opastaa oppilasta kehittämään kieltään ja mielikuvitustaan sekä vuorovaikutus- ja yhteistyötaitojaan tarjoamalla mahdollisuuksia osallistua erilaisiin ryhmäviestintätilanteisiin ja tutustua niiden käytänteisiin	basicStudyObjectives		466661	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/466341
1301	297	teaches	L5 Tieto- ja viestintäteknologinen osaaminen	basicStudyContents		428674	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/laajaalaisetosaamiset/428674
277	234	teaches	S2 Tekstien tulkitseminen	basicStudyContents	Perusopetuksen opetussuunnitelma 2016	466631	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/466341
278	234	teaches	S3 Tekstien tuottaminen	basicStudyContents	Perusopetuksen opetussuunnitelma 2016	466632	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/466341
279	234	educationalSubject	Kemia	upperSecondarySchoolSubjectsNew		6832793	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6828810/lops2019/oppiaineet/6832793
280	234	educationalSubject	Lukiodiplomit	upperSecondarySchoolSubjectsNew		6835372	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6828810/lops2019/oppiaineet/6835372
281	234	educationalSubject	Molekyylit ja mallit	upperSecondarySchoolModulesNew		6833238	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6828810/lops2019/oppiaineet/6832793/moduulit/6833238
1240	282	educationalSubject	Matematiikka	basicStudySubjects		466344	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/466344
1242	282	teaches	T5 ohjata ja tukea oppilasta ongelmanratkaisutaitojen kehittämisessä	basicStudyObjectives		469467	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/466344
1241	282	teaches	T4 kannustaa oppilasta esittämään päättelyään ja ratkaisujaan muille konkreettisin välinein, piirroksin, suullisesti ja kirjallisesti myös tieto- ja viestintäteknologiaa hyödyntäen	basicStudyObjectives		469465	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/466344
1243	282	teaches	L5 Tieto- ja viestintäteknologinen osaaminen	basicStudyContents		428674	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/laajaalaisetosaamiset/428674
1335	327	educationalSubject	Filosofia	upperSecondarySchoolSubjectsNew		6832794	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6828810/lops2019/oppiaineet/6832794
1336	327	educationalSubject	Etiikka	upperSecondarySchoolModulesNew		6833503	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6828810/lops2019/oppiaineet/6832794/moduulit/6833503
1227	271	teaches	T3 kannustaa oppilasta kehittämään esiintymistaitojaan ja taitoaan ilmaista itseään erilaisissa tilanteissa tavoitteellisesti ja erilaisia ilmaisukeinoja hyödyntäen	basicStudyObjectives	Perusopetuksen opetussuunnitelma 2014	747828	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/692137
1316	317	educationalSubject	Kemia	upperSecondarySchoolSubjectsNew		6832793	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6828810/lops2019/oppiaineet/6832793
1317	317	educationalSubject	Kemiallinen reaktio	upperSecondarySchoolModulesNew		6833239	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6828810/lops2019/oppiaineet/6832793/moduulit/6833239
1318	317	teaches	osaa käyttää ja soveltaa reaktioihin liittyviä käsitteitä jokapäiväisen elämän, ympäristön ja yhteiskunnan ilmiöissä sekä nykyteknologian sovelluksissa	upperSecondarySchoolObjectivesNew		6833481	\N
1319	317	teaches	reaktioiden tutkiminen kokeellisesti sekä tutkimustulosten käsitteleminen, tulkitseminen ja esittäminen	upperSecondarySchoolContentsNew		6833485	\N
1320	318	educationalSubject	Suomen kieli ja kirjallisuus	basicStudySubjects		466341	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/466341
1321	318	teaches	T4 ohjata oppilasta rakentamaan viestijäkuvaansa ja ymmärtämään, että ihmiset viestivät eri tavoin	basicStudyObjectives		592951	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/466341
1322	318	teaches	L5 Tieto- ja viestintäteknologinen osaaminen	basicStudyContents		428674	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/laajaalaisetosaamiset/428674
1313	313	educationalSubject	Grundexamen i natur och miljö	vocationalDegrees		3282478	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/3282478
1314	313	educationalSubject	Naturinstruktion	vocationalUnits		3317259	\N
1315	313	educationalSubject	Natur- och miljörådgivning	vocationalUnits		3327560	\N
1228	271	teaches	T1 rohkaista oppilasta kehittämään taitoaan toimia tavoitteellisesti, eettisesti ja vuorovaikutussuhdetta rakentaen koulun ja yhteiskunnan vuorovaikutustilanteissa	basicStudyObjectives	Perusopetuksen opetussuunnitelma 2014	747826	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/692137
1337	327	teaches	oppii jäsentämään oman elämänsä merkityksellisyyttä ja elämänvalintojaan filosofisen käsitteistön avulla	upperSecondarySchoolObjectivesNew		6833609	\N
1338	327	teaches	ympäristöä ja luontoa koskevia eettisiä kysymyksiä, kuten ilmastonmuutos ja eläinten oikeudet	upperSecondarySchoolContentsNew		6833616	\N
1505	356	educationalSubject	Biologia	basicStudySubjects		478970	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/478970
1506	356	educationalSubject	Fysiikka	basicStudySubjects		466346	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/466346
1507	356	teaches	T1 kannustaa ja innostaa oppilasta fysiikan opiskeluun	basicStudyObjectives		472457	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/466346
1366	337	educationalSubject	Kotitalous	basicStudySubjects		502086	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/502086
1367	337	teaches	T2 ohjata oppilasta harjoittelemaan kotitalouden hallinnassa tarvittavia kädentaitoja sekä kannustaa luovuuteen ja estetiikan huomioimiseen	basicStudyObjectives		506119	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/502086
1368	337	teaches	L4 Monilukutaito	basicStudyContents		428673	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/laajaalaisetosaamiset/428673
1369	339	educationalSubject	Elämänkatsomustieto	upperSecondarySchoolSubjectsNew		6834385	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6828810/lops2019/oppiaineet/6834385
1370	339	educationalSubject	Katsomukset	upperSecondarySchoolModulesNew		6834844	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6828810/lops2019/oppiaineet/6834385/moduulit/6834844
1371	339	teaches	osaa eritellä ja arvioida evoluution, universaalien eettisten järjestelmien, Euroopan uuden ajan murroksen, valistuksen, tieteen sekä modernin markkinatalouden merkitystä maailmankuviin ja omaan elämänkatsomukseensa	upperSecondarySchoolObjectivesNew		6834927	\N
1372	339	teaches	katsomusten historiaa: universaalien katsomusten ja moraalijärjestelmien synty, modernin subjektin ja tieteellisen maailmankuvan synty, edistysusko ja yhteiskunnan osa-alueiden eriytyminen uudenlaisten katsomusten taustana	upperSecondarySchoolContentsNew		6865955	\N
1373	342	educationalSubject	Kuvataide	basicStudySubjects		466342	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/466342
1229	271	teaches	T2 innostaa oppilasta vahvistamaan kasvokkaisen vuorovaikutuksen, opetuspuheen ja kuultujen tekstien kuuntelu- ja ymmärtämistaitojaan	basicStudyObjectives	Perusopetuksen opetussuunnitelma 2014	747712	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/692137
1231	271	teaches	S2 Tekstien tulkitseminen	basicStudyContents	Perusopetuksen opetussuunnitelma 2014	716160	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/692137
1232	271	teaches	S5 Kielen käyttö kaiken oppimisen tukena	basicStudyContents	Perusopetuksen opetussuunnitelma 2014	705791	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/692137
1233	271	requires	aakkoset	prerequisites		aakkoset	\N
1396	316	educationalSubject	Biologia	upperSecondarySchoolSubjectsOld		BI	\N
1397	316	educationalSubject	Elämä ja evoluutio	upperSecondarySchoolCoursesOld		BI1	\N
1491	327	educationalSubject	Elämänkatsomustieto	upperSecondarySchoolSubjectsOld		ET	\N
1492	327	educationalSubject	Katsomusten maailma	upperSecondarySchoolCoursesOld		ET5	\N
1307	312	educationalSubject	Biologia	basicStudySubjects		478970	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/478970
1432	351	educationalSubject	Elämänkatsomustieto	upperSecondarySchoolSubjectsOld		ET	\N
1443	351	educationalSubject	Biologia	upperSecondarySchoolSubjectsOld		BI	\N
1460	351	educationalSubject	Kemia	upperSecondarySchoolSubjectsOld		KE	\N
201	208	educationalSubject	Yhteiskuntaoppi	basicStudySubjects	Perusopetuksen opetussuunnitelma 2014	478972	\N
202	208	teaches	L4 Monilukutaito	basicStudyContents	Perusopetuksen opetussuunnitelma 2014	428673	\N
203	208	teaches	L5 Tieto- ja viestintäteknologinen osaaminen	basicStudyContents	Perusopetuksen opetussuunnitelma 2014	428674	\N
1308	312	teaches	T1 ohjata oppilasta ymmärtämään ekosysteemin perusrakennetta ja toimintaa sekä vertailemaan erilaisia ekosysteemejä ja tunnistamaan lajeja	basicStudyObjectives		478886	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/478970
1503	358	educationalSubject	oppimateriaalien kehittäminen	selfMotivatedEducationSubjects		oppimateriaalienkehittminen	\N
1434	351	educationalSubject	Elämä ja evoluutio	upperSecondarySchoolCoursesOld		BI1	\N
1435	351	educationalSubject	Katsomusten maailma	upperSecondarySchoolCoursesOld		ET5	\N
204	208	educationalSubject	Filosofia	upperSecondarySchoolSubjectsNew		6832794	\N
206	208	teaches	pystyy arvioimaan filosofisesti yhteiskunnan rakennetta ja sen oikeutusta	upperSecondarySchoolObjectivesNew		6833622	\N
207	208	teaches	ymmärtää oikeuksien merkityksen yhteiskunnan perustana.	upperSecondarySchoolObjectivesNew		6833624	\N
1436	351	educationalSubject	Kulttuurit katsomuksen muovaajina	upperSecondarySchoolCoursesOld		ET4	\N
1433	351	educationalSubject	Biologian sovellukset	upperSecondarySchoolCoursesOld		BI5	\N
1605	367	educationalSubject	Matematiikka	branchesOfScience		111	https://virkailija.opintopolku.fi/koodisto-service/rest/codeelement/tieteenala_111
1606	367	teaches	tähtitieteellisen ajan merkit	scienceBranchObjectives		thtitieteellisenajanmerkit	\N
309	220	teaches	T2 rohkaista oppilasta kehittämään sosiaalisia taitojaan ohjaamalla monipuoliseen vuorovaikutukseen sekä taitoon antaa ja vastaanottaa palautetta	basicStudyObjectives		726240	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/530529
310	220	teaches	L1 Ajattelu ja oppimaan oppiminen	basicStudyContents		428670	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/laajaalaisetosaamiset/428670
311	220	teaches	L2 Kulttuurinen osaaminen, vuorovaikutus ja ilmaisu	basicStudyContents		428671	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/laajaalaisetosaamiset/428671
1539	360	educationalSubject	Muu oppilaan äidinkieli	basicStudySubjects		692136	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/692136
1540	361	educationalSubject	Tieto- ja viestintätekniikan perustutkinto (Siirtymäajalla)	vocationalDegrees		1726680	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/1726680
1541	361	educationalSubject	Tieto- ja tietoliikennetekniikan perustutkinto (Siirtymäajalla)	vocationalDegrees		1724179	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/1724179
1542	361	educationalSubject	Tieto- ja viestintätekniikan perustutkinto	vocationalDegrees		6779583	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6779583
333	220	educationalSubject	Kemia	upperSecondarySchoolSubjectsNew		6832793	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6828810/lops2019/oppiaineet/6832793
1465	351	educationalSubject	Teknologia, maailmankatsomukset ja ihmiskunnan tulevaisuus	upperSecondarySchoolCoursesOld		ET6	\N
1698	378	educationalSubject	Suomen kieli ja kirjallisuus	basicStudySubjects		466341	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/466341
334	220	educationalSubject	Kemia ja kestävä tulevaisuus	upperSecondarySchoolModulesNew		6833237	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6828810/lops2019/oppiaineet/6832793/moduulit/6833237
1604	365	educationalSubject	qa-toiminta	selfMotivatedEducationSubjects		qatoiminta	\N
1684	370	educationalSubject	Kuvataide	basicStudySubjects		466342	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/466342
1685	370	teaches	T1 kannustaa oppilasta havainnoimaan, taidetta, ympäristöä ja muuta visuaalista kulttuuria moniaistisesti ja käyttämään monipuolisesti kuvallisen tuottamisen menetelmiä	basicStudyObjectives		662002	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/466342
1686	370	teaches	L4 Monilukutaito	basicStudyContents		428673	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/laajaalaisetosaamiset/428673
1699	378	teaches	T4 ohjata oppilasta rakentamaan viestijäkuvaansa ja ymmärtämään, että ihmiset viestivät eri tavoin	basicStudyObjectives		592951	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/466341
1700	378	teaches	L4 Monilukutaito	basicStudyContents		428673	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/laajaalaisetosaamiset/428673
1620	368	educationalSubject	luomuviljely	selfMotivatedEducationSubjects		luomuviljely	\N
1797	396	educationalSubject	Immobilisaatiohoidon erikoisammattitutkinto	specialistVocationalQualifications		4221364	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/4221364
1636	369	requires	sipulin pilkkominen	prerequisites		sipulinpilkkominen	\N
1701	380	educationalSubject	matematiikka	earlyChildhoodEducationSubjects		matematiikka	\N
1702	380	teaches	kullttuuri	earlyChildhoodEducationObjectives		kullttuuri	\N
1543	362	educationalSubject	Yhteiskuntaoppi	basicStudySubjects		478972	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/478972
1544	362	teaches	T1 ohjata oppilasta syventämään kiinnostustaan ympäröivään yhteiskuntaan ja vahvistaa oppilaan kiinnostusta yhteiskuntaoppiin tiedonalana	basicStudyObjectives		489604	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/478972
1545	362	teaches	L4 Monilukutaito	basicStudyContents		428673	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/laajaalaisetosaamiset/428673
1546	362	teaches	S1 Arkielämä ja oman elämän hallinta	basicStudyContents		489252	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/478972
1798	396	educationalSubject	Isännöinnin erikoisammattitutkinto	specialistVocationalQualifications		3689875	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/3689875
1580	356	educationalSubject	testi 1	earlyChildhoodEducationSubjects		testi1	\N
1581	356	educationalSubject	testi 2	earlyChildhoodEducationSubjects		testi2	\N
1480	356	educationalSubject	Musiikkialan perustutkinto	vocationalDegrees		6749301	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6749301
1481	356	educationalSubject	Musiikkialan toimintaympäristössä toimiminen	vocationalUnits		6746417	\N
1799	396	educationalSubject	Kalatalouden erikoisammattitutkinto	specialistVocationalQualifications		3068222	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/3068222
1715	310	requires	kevät	prerequisites		kevt	\N
1719	380	educationalSubject	Matematiikka	basicStudySubjects		466344	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/466344
1720	380	teaches	T4 kannustaa oppilasta esittämään päättelyään ja ratkaisujaan muille konkreettisin välinein, piirroksin, suullisesti ja kirjallisesti myös tieto- ja viestintäteknologiaa hyödyntäen	basicStudyObjectives		469465	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/466344
1721	380	teaches	L2 Kulttuurinen osaaminen, vuorovaikutus ja ilmaisu	basicStudyContents		428671	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/laajaalaisetosaamiset/428671
1722	380	teaches	S1 Ajattelun taidot	basicStudyContents		469269	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/466344
1723	364	educationalSubject	Suomen kieli ja kirjallisuus	basicStudySubjects		466341	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/466341
1724	364	educationalSubject	Yhteiskuntaoppi	basicStudySubjects		478972	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/478972
1725	364	educationalSubject	Elämänkatsomustieto	basicStudySubjects		502088	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/502088
1726	364	educationalSubject	Suomi saamenkielisille	basicStudySubjects		692139	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/692139
1735	312	teaches	L1 Ajattelu ja oppimaan oppiminen	basicStudyContents		428670	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/laajaalaisetosaamiset/428670
1736	312	teaches	L5 Tieto- ja viestintäteknologinen osaaminen	basicStudyContents		428674	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/laajaalaisetosaamiset/428674
1508	356	teaches	T2 ohjata ja kannustaa oppilasta tunnistamaan omaa fysiikan osaamistaan, asettamaan tavoitteita omalle työskentelylleen sekä työskentelemään pitkäjänteisesti	basicStudyObjectives		472458	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/466346
1482	356	educationalSubject	Äänentoistojärjestelmän käyttäminen	vocationalUnits		6765996	\N
1753	391	educationalSubject	Teologia	branchesOfScience		614	https://virkailija.opintopolku.fi/koodisto-service/rest/codeelement/tieteenala_614
1756	392	educationalSubject	Autoalan perustutkinto	vocationalDegrees		3397336	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/3397336
1757	392	educationalSubject	Ajoneuvoalan ammattitutkinto	furtherVocationalQualifications		4804100	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/4804100
1758	392	educationalSubject	Ajoneuvoalan erikoisammattitutkinto	specialistVocationalQualifications		4837162	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/4837162
1759	392	requires	fsdfds	prerequisites		fsdfds	\N
1785	393	requires	lapion käyttö	prerequisites		lapionkytt	\N
1775	354	educationalSubject	Hevostalouden perustutkinto	vocationalDegrees		6828811	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6828811
1776	354	educationalSubject	Hieronnan ammattitutkinto	furtherVocationalQualifications		4556441	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/4556441
1762	355	educationalSubject	Suomi saamenkielisille	basicStudySubjects		692139	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/692139
1763	355	educationalSubject	Saamen kieli ja kirjallisuus	basicStudySubjects		530529	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/530529
1770	355	educationalSubject	Grundexamen i båtbyggnad (Övergångstid)	vocationalDegrees		1568685	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/1568685
1760	355	educationalSubject	Aseseppäkisällin ammattitutkinto (Siirtymäajalla)	furtherVocationalQualifications		1000203	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/1000203
1761	355	educationalSubject	Hevostalouden erikoisammattitutkinto	specialistVocationalQualifications		2357204	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/2357204
1766	355	educationalSubject	Tilastotiede	branchesOfScience		112	https://virkailija.opintopolku.fi/koodisto-service/rest/codeelement/tieteenala_112
1767	355	educationalSubject	Avaruustieteet ja tähtitiede	branchesOfScience		115	https://virkailija.opintopolku.fi/koodisto-service/rest/codeelement/tieteenala_115
1791	396	educationalSubject	Eläintenhoidon ammattitutkinto	furtherVocationalQualifications		4454270	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/4454270
1777	354	educationalSubject	Kasvatus- ja ohjausalan erikoisammattitutkinto	specialistVocationalQualifications		5116904	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/5116904
1786	395	requires	lumenluonti	prerequisites		lumenluonti	\N
1826	396	educationalSubject	Asiakaskokemuksen tuottaminen ja palveluverkoston hallinta	vocationalUnits		3700378	\N
1827	396	educationalSubject	Kalatalouden yritystoiminnasta vastaaminen	vocationalUnits		4627056	\N
1828	396	educationalSubject	Esimiehenä toimiminen kalatalousalalla	vocationalUnits		4619029	\N
1829	396	educationalSubject	Eläinten hoito ja hyvinvoinnista huolehtiminen eläinhoitolassa	vocationalUnits		4525981	\N
1830	396	educationalSubject	Asiakaspalvelu eläinhoitolassa	vocationalUnits		4525496	\N
1831	396	educationalSubject	Kasvatus- ja ohjausalan kehittämistoiminta muuttuvissa toimintaympäristöissä	vocationalUnits		5126471	\N
1800	396	educationalSubject	Kasvatus- ja ohjausalan erikoisammattitutkinto	specialistVocationalQualifications		5116904	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/5116904
1795	396	educationalSubject	Hieronnan erikoisammattitutkinto	specialistVocationalQualifications		4556442	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/4556442
1796	396	educationalSubject	Hius- ja kauneudenhoitoalan erikoisammattitutkinto	specialistVocationalQualifications		2910072	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/2910072
1973	402	educationalSubject	tutkin ja toimin ympäristössäni	earlyChildhoodEducationSubjects		tutkinjatoiminympristssni	\N
1974	402	educationalSubject	matematiikka	earlyChildhoodEducationSubjects		matematiikka	\N
1975	402	teaches	matemaattisen ajattelun kehittyminen	earlyChildhoodEducationObjectives		matemaattisenajattelunkehittyminen	\N
1976	402	educationalSubject	tutkin ja toimin ympäristössäni	prePrimaryEducationSubjects		tutkinjatoiminympristssni	\N
1977	402	educationalSubject	matematiikka	prePrimaryEducationSubjects		matematiikka	\N
1978	402	teaches	matemaattisen ajattelun kehittyminen	prePrimaryEducationObjectives		matemaattisenajattelunkehittyminen	\N
1991	420	educationalSubject	Kemia	upperSecondarySchoolSubjectsNew		6832793	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6828810/lops2019/oppiaineet/6832793
1992	420	educationalSubject	Kemiallinen energia ja kiertotalous	upperSecondarySchoolModulesNew		6833500	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6828810/lops2019/oppiaineet/6832793/moduulit/6833500
1993	420	teaches	tuntee merkittävien metallien ominaisuuksia sekä valmistus- ja jalostusprosesseja ympäristövaikutuksineen	upperSecondarySchoolObjectivesNew		6833530	\N
1994	420	teaches	sähkökemian keskeiset periaatteet: jännitesarja, normaalipotentiaali, kemiallinen pari, elektrolyysi ja kemiallisen energian varastointi	upperSecondarySchoolContentsNew		6833538	\N
1938	401	educationalSubject	Muut humanistiset tieteet	branchesOfScience		616	https://virkailija.opintopolku.fi/koodisto-service/rest/codeelement/tieteenala_616
\.


--
-- Data for Name: aoeuser; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.aoeuser (username) FROM stdin;
juniemin@csc.fi
anlindfo@csc.fi
mroppone@csc.fi
4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD
\.


--
-- Data for Name: attachment; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.attachment (id, filepath, originalfilename, filesize, mimetype, format, filekey, filebucket, defaultfile, kind, label, srclang, materialid, obsoleted) FROM stdin;
1	https://testing.object.pouta.csc.fi/lahioikeudetsbv-1578568516264.vtt	lahioikeudet.sbv.vtt	4039	text/vtt	7bit	lahioikeudetsbv-1578568516264.vtt	testing	t	subtitles	Testi	fi	268	0
2	https://testing.object.pouta.csc.fi/lahioikeudetsv-1579071011131.sbv	lahioikeudet sv.sbv	3958	application/octet-stream	7bit	lahioikeudetsv-1579071011131.sbv	testing	f	subtitles	svenska	sv	334	0
3	https://testing.object.pouta.csc.fi/lahioikeudet-1579071011144.sbv	lahioikeudet.sbv	3875	application/octet-stream	7bit	lahioikeudet-1579071011144.sbv	testing	t	subtitles	suomi	fi	334	0
4	https://testing.object.pouta.csc.fi/lahioikeudeten-1579071011057.sbv	lahioikeudet en.sbv	3883	application/octet-stream	7bit	lahioikeudeten-1579071011057.sbv	testing	f	subtitles	english	en	334	0
5	https://testing.object.pouta.csc.fi/ohjeetsv-1579160708932.sbv	ohjeet sv.sbv	3056	application/octet-stream	7bit	ohjeetsv-1579160708932.sbv	testing	f	subtitles	sve	sv	338	0
6	https://testing.object.pouta.csc.fi/ohjeet-1579160708949.sbv	ohjeet.sbv	3082	application/octet-stream	7bit	ohjeet-1579160708949.sbv	testing	t	subtitles	fin	fi	338	0
7	https://testing.object.pouta.csc.fi/ohjeeten-1579160708966.sbv	ohjeet en.sbv	3131	application/octet-stream	7bit	ohjeeten-1579160708966.sbv	testing	f	subtitles	eng	en	338	0
8	https://testing.object.pouta.csc.fi/lahioikeudetsbv-1579168847915.vtt	lahioikeudet.sbv.vtt	4039	application/octet-stream	7bit	lahioikeudetsbv-1579168847915.vtt	testing	t	subtitles	suomi	fi	339	0
12	https://testing.object.pouta.csc.fi/avoinjulkaiseminensbv-1579170196150.vtt	avoinjulkaiseminen.sbv.vtt	3207	text/vtt	7bit	avoinjulkaiseminensbv-1579170196150.vtt	testing	f	subtitles	Avoin julkaiseminen	fi	342	0
13	https://testing.object.pouta.csc.fi/avoinjulkaiseminensvsbv-1579170196161.vtt	avoinjulkaiseminen sv.sbv.vtt	3098	text/vtt	7bit	avoinjulkaiseminensvsbv-1579170196161.vtt	testing	t	subtitles	Öppnä publicering	sv	342	0
14	https://testing.object.pouta.csc.fi/avoinjulkaiseminensbv-1579173494948.vtt	avoinjulkaiseminen.sbv.vtt	3207	text/vtt	7bit	avoinjulkaiseminensbv-1579173494948.vtt	testing	f	subtitles	Avoin julkaiseminen	fi	345	0
15	https://testing.object.pouta.csc.fi/avoinjulkaiseminensvsbv-1579173494988.vtt	avoinjulkaiseminen sv.sbv.vtt	3098	text/vtt	7bit	avoinjulkaiseminensvsbv-1579173494988.vtt	testing	t	subtitles	Öppnä publicering	sv	345	0
16	https://testing.object.pouta.csc.fi/lahioikeudetsbv-1579181060377.vtt	lahioikeudet.sbv.vtt	4039	application/octet-stream	7bit	lahioikeudetsbv-1579181060377.vtt	testing	t	subtitles	suomi	fi	347	0
17	https://testing.object.pouta.csc.fi/lahioikeudetsbv-1579182825488.vtt	lahioikeudet.sbv.vtt	4039	application/octet-stream	7bit	lahioikeudetsbv-1579182825488.vtt	testing	t	subtitles	suomi	fi	348	0
18	https://testing.object.pouta.csc.fi/lahioikeudetsbv-1579182825476.vtt	lahioikeudet.sbv.vtt	4039	application/octet-stream	7bit	lahioikeudetsbv-1579182825476.vtt	testing	f	subtitles	svenska	sv	348	0
19	https://testing.object.pouta.csc.fi/lahioikeudetsbv-1579182825463.vtt	lahioikeudet.sbv.vtt	4039	application/octet-stream	7bit	lahioikeudetsbv-1579182825463.vtt	testing	f	subtitles	english	en	348	0
20	https://testing.object.pouta.csc.fi/lahioikeudetsbv-1579245189223.vtt	lahioikeudet.sbv.vtt	4039	application/octet-stream	7bit	lahioikeudetsbv-1579245189223.vtt	testing	t	subtitles	suomi	fi	349	0
21	https://testing.object.pouta.csc.fi/lahioikeudetsbv-1579245189252.vtt	lahioikeudet.sbv.vtt	4039	application/octet-stream	7bit	lahioikeudetsbv-1579245189252.vtt	testing	f	subtitles	svenska	sv	349	0
22	https://testing.object.pouta.csc.fi/lahioikeudetsbv-1579245189256.vtt	lahioikeudet.sbv.vtt	4039	application/octet-stream	7bit	lahioikeudetsbv-1579245189256.vtt	testing	f	subtitles	english	en	349	0
23	https://testing.object.pouta.csc.fi/avoinjulkaiseminensbv-1579246950166.vtt	avoinjulkaiseminen.sbv.vtt	3207	text/vtt	7bit	avoinjulkaiseminensbv-1579246950166.vtt	testing	f	subtitles	Avoin julkaiseminen	fi	351	0
24	https://testing.object.pouta.csc.fi/lahioikeudetsbv-1579255084543.vtt	lahioikeudet.sbv.vtt	4039	application/octet-stream	7bit	lahioikeudetsbv-1579255084543.vtt	testing	f	subtitles	sad	ab	353	0
25	https://testing.object.pouta.csc.fi/avoinjulkaiseminensbv-1579256574890.vtt	avoinjulkaiseminen.sbv.vtt	3207	text/vtt	7bit	avoinjulkaiseminensbv-1579256574890.vtt	testing	f	subtitles	Avoin julkaiseminen	fi	354	0
26	https://testing.object.pouta.csc.fi/avoinjulkaiseminensvsbv-1579256574911.vtt	avoinjulkaiseminen sv.sbv.vtt	3098	text/vtt	7bit	avoinjulkaiseminensvsbv-1579256574911.vtt	testing	f	subtitles	Avoin julkaiseminen sv	sv	354	0
27	https://testing.object.pouta.csc.fi/avoinjulkaiseminensbv-1579256772946.vtt	avoinjulkaiseminen.sbv.vtt	3207	text/vtt	7bit	avoinjulkaiseminensbv-1579256772946.vtt	testing	f	subtitles	tekstitys	fi	356	0
28	https://testing.object.pouta.csc.fi/avoinjulkaiseminensvsbv-1579256886094.vtt	avoinjulkaiseminen sv.sbv.vtt	3098	text/vtt	7bit	avoinjulkaiseminensvsbv-1579256886094.vtt	testing	t	subtitles	Textning	sv	357	0
29	https://testing.object.pouta.csc.fi/avoinjulkaiseminenensbv-1579257163385.vtt	avoinjulkaiseminen en.sbv.vtt	2964	text/vtt	7bit	avoinjulkaiseminenensbv-1579257163385.vtt	testing	f	subtitles	text	en	359	0
30	https://testing.object.pouta.csc.fi/avoinjulkaiseminensvsbv-1579257163357.vtt	avoinjulkaiseminen sv.sbv.vtt	3098	text/vtt	7bit	avoinjulkaiseminensvsbv-1579257163357.vtt	testing	t	subtitles	Textning	sv	359	0
31	https://testing.object.pouta.csc.fi/avoinjulkaiseminensbv-1579257163394.vtt	avoinjulkaiseminen.sbv.vtt	3207	text/vtt	7bit	avoinjulkaiseminensbv-1579257163394.vtt	testing	f	subtitles	tekstitys	fi	359	0
32	https://testing.object.pouta.csc.fi/lahioikeudetsbv-1579257412512.vtt	lahioikeudet.sbv.vtt	4039	application/octet-stream	7bit	lahioikeudetsbv-1579257412512.vtt	testing	f	subtitles	fsd	sv	360	0
33	https://testing.object.pouta.csc.fi/avoinjulkaiseminensbv-1579257588357.vtt	avoinjulkaiseminen.sbv.vtt	3207	text/vtt	7bit	avoinjulkaiseminensbv-1579257588357.vtt	testing	t	subtitles	tekstitys	fi	361	0
34	https://testing.object.pouta.csc.fi/avoinjulkaiseminenensbv-1579257676007.vtt	avoinjulkaiseminen en.sbv.vtt	2964	text/vtt	7bit	avoinjulkaiseminenensbv-1579257676007.vtt	testing	f	subtitles	texts	en	363	0
35	https://testing.object.pouta.csc.fi/avoinjulkaiseminenensbv-1579257788316.vtt	avoinjulkaiseminen en.sbv.vtt	2964	text/vtt	7bit	avoinjulkaiseminenensbv-1579257788316.vtt	testing	f	subtitles	Avoin	en	365	0
36	https://testing.object.pouta.csc.fi/lahioikeudetsbv-1579257973216.vtt	lahioikeudet.sbv.vtt	4039	application/octet-stream	7bit	lahioikeudetsbv-1579257973216.vtt	testing	t	subtitles	suomi	fi	366	0
37	https://testing.object.pouta.csc.fi/lahioikeudetsbv-1579258123672.vtt	lahioikeudet.sbv.vtt	4039	application/octet-stream	7bit	lahioikeudetsbv-1579258123672.vtt	testing	f	subtitles	suomi	fi	367	0
38	https://testing.object.pouta.csc.fi/lahioikeudetsbv-1579258478840.vtt	lahioikeudet.sbv.vtt	4039	application/octet-stream	7bit	lahioikeudetsbv-1579258478840.vtt	testing	f	subtitles	suomi	fi	368	0
39	https://testing.object.pouta.csc.fi/avoinjulkaiseminenensbv-1579258522022.vtt	avoinjulkaiseminen en.sbv.vtt	2964	text/vtt	7bit	avoinjulkaiseminenensbv-1579258522022.vtt	testing	f	subtitles	tekstitys	en	369	0
40	https://testing.object.pouta.csc.fi/avoinjulkaiseminensbv-1579259334367.vtt	avoinjulkaiseminen.sbv.vtt	3207	text/vtt	7bit	avoinjulkaiseminensbv-1579259334367.vtt	testing	f	subtitles	tekstitys	fi	371	0
41	https://testing.object.pouta.csc.fi/avoinjulkaiseminensvsbv-1579499535382.vtt	avoinjulkaiseminen sv.sbv.vtt	3098	text/vtt	7bit	avoinjulkaiseminensvsbv-1579499535382.vtt	testing	f	subtitles	textning	sv	375	0
42	https://testing.object.pouta.csc.fi/lahioikeudetsbv-1579774581470.vtt	lahioikeudet.sbv.vtt	4039	application/octet-stream	7bit	lahioikeudetsbv-1579774581470.vtt	testing	t	subtitles	suomi	fi	388	0
43	https://testing.object.pouta.csc.fi/lahioikeudetsbv-1579780219271.vtt	lahioikeudet.sbv.vtt	4039	application/octet-stream	7bit	lahioikeudetsbv-1579780219271.vtt	testing	t	subtitles	suomi	fi	389	0
44	https://testing.object.pouta.csc.fi/lahioikeudetsbv-1579780989217.vtt	lahioikeudet.sbv.vtt	4039	application/octet-stream	7bit	lahioikeudetsbv-1579780989217.vtt	testing	t	subtitles	adsa	sv	390	0
45	https://testing.object.pouta.csc.fi/lahioikeudetsbv-1579781104010.vtt	lahioikeudet.sbv.vtt	4039	application/octet-stream	7bit	lahioikeudetsbv-1579781104010.vtt	testing	t	subtitles	hgfdfg	sv	392	0
46	https://testing.object.pouta.csc.fi/avoinjulkaiseminensbv-1579781522146.vtt	avoinjulkaiseminen.sbv.vtt	3207	text/vtt	7bit	avoinjulkaiseminensbv-1579781522146.vtt	testing	t	subtitles	tekstitys	fi	395	0
47	https://testing.object.pouta.csc.fi/avoinjulkaiseminensvsbv-1579781522190.vtt	avoinjulkaiseminen sv.sbv.vtt	3098	text/vtt	7bit	avoinjulkaiseminensvsbv-1579781522190.vtt	testing	f	subtitles	Textning	sv	395	0
48	https://testing.object.pouta.csc.fi/avoinjulkaiseminensbv-1581592905376.vtt	avoinjulkaiseminen.sbv.vtt	3207	text/vtt	7bit	avoinjulkaiseminensbv-1581592905376.vtt	testing	f	subtitles	Textning	sv	417	0
49	https://testing.object.pouta.csc.fi/avoinjulkaiseminensbv-1581594297577.vtt	avoinjulkaiseminen.sbv.vtt	3207	text/vtt	7bit	avoinjulkaiseminensbv-1581594297577.vtt	testing	f	subtitles	tesktitys	fi	418	0
50	https://testing.object.pouta.csc.fi/lahioikeudet1-1581594728747.vtt	lahioikeudet1.vtt	4039	text/vtt	7bit	lahioikeudet1-1581594728747.vtt	testing	t	subtitles	eka	fi	419	0
51	https://testing.object.pouta.csc.fi/lahioikeudet2-1581595539947.vtt	lahioikeudet2.vtt	4039	text/vtt	7bit	lahioikeudet2-1581595539947.vtt	testing	f	subtitles	toka	sv	420	0
52	https://testing.object.pouta.csc.fi/lahioikeudet1-1581595539915.vtt	lahioikeudet1.vtt	4039	text/vtt	7bit	lahioikeudet1-1581595539915.vtt	testing	t	subtitles	eka	fi	420	0
53	https://testing.object.pouta.csc.fi/lahioikeudet1-1581595597771.vtt	lahioikeudet1.vtt	4039	text/vtt	7bit	lahioikeudet1-1581595597771.vtt	testing	t	subtitles	eka	en	421	0
54	https://testing.object.pouta.csc.fi/lahioikeudet2-1581595597807.vtt	lahioikeudet2.vtt	4039	text/vtt	7bit	lahioikeudet2-1581595597807.vtt	testing	f	subtitles	kolmas	ab	421	0
55	https://testing.object.pouta.csc.fi/lahioikeudet1-1581596374590.vtt	lahioikeudet1.vtt	4039	text/vtt	7bit	lahioikeudet1-1581596374590.vtt	testing	t	subtitles	asd	sv	422	0
56	https://testing.object.pouta.csc.fi/lahioikeudet2-1581596374631.vtt	lahioikeudet2.vtt	4039	text/vtt	7bit	lahioikeudet2-1581596374631.vtt	testing	f	subtitles	dfg	en	422	0
57	https://testing.object.pouta.csc.fi/avoinjulkaiseminenensbv-1581597359664.vtt	avoinjulkaiseminen en.sbv.vtt	2964	text/vtt	7bit	avoinjulkaiseminenensbv-1581597359664.vtt	testing	f	subtitles	subtitles	en	424	0
58	https://testing.object.pouta.csc.fi/avoinjulkaiseminensbv-1581597359646.vtt	avoinjulkaiseminen.sbv.vtt	3207	text/vtt	7bit	avoinjulkaiseminensbv-1581597359646.vtt	testing	f	subtitles	tekstitys	fi	424	0
59	https://testing.object.pouta.csc.fi/avoinjulkaiseminensbv-1582005844772.vtt	avoinjulkaiseminen.sbv.vtt	3207	text/vtt	7bit	avoinjulkaiseminensbv-1582005844772.vtt	testing	f	subtitles	Tekstitys	fi	430	0
60	https://testing.object.pouta.csc.fi/avoinjulkaiseminensvsbv-1582005844794.vtt	avoinjulkaiseminen sv.sbv.vtt	3098	text/vtt	7bit	avoinjulkaiseminensvsbv-1582005844794.vtt	testing	f	subtitles	Textning	sv	430	0
62	https://testing.object.pouta.csc.fi/lahioikeudet1-1582204761534.vtt	lahioikeudet1.vtt	4039	text/vtt	7bit	lahioikeudet1-1582204761534.vtt	testing	t	subtitles	testi1	fi	442	0
61	https://testing.object.pouta.csc.fi/lahioikeudet2-1582204761564.vtt	lahioikeudet2.vtt	4039	text/vtt	7bit	lahioikeudet2-1582204761564.vtt	testing	f	subtitles	testi2	sv	442	1
63	https://testing.object.pouta.csc.fi/lahioikeudet1-1582204923890.vtt	lahioikeudet1.vtt	4039	text/vtt	7bit	lahioikeudet1-1582204923890.vtt	testing	f	subtitles	testi3	en	443	0
64	https://testing.object.pouta.csc.fi/lahioikeudet2-1582204923915.vtt	lahioikeudet2.vtt	4039	text/vtt	7bit	lahioikeudet2-1582204923915.vtt	testing	t	subtitles	testi4	sv	443	0
65	https://testing.object.pouta.csc.fi/avoinjulkaiseminensbv-1582526977114.vtt	avoinjulkaiseminen.sbv.vtt	3207	text/vtt	7bit	avoinjulkaiseminensbv-1582526977114.vtt	testing	f	subtitles	Tekstitys	fi	454	0
73	https://testing.object.pouta.csc.fi/lahioikeudet1-1589374866245.vtt	lahioikeudet1.vtt	4039	text/vtt	7bit	lahioikeudet1-1589374866245.vtt	testing	f	subtitles	Testi	sv	495	0
74	https://testing.object.pouta.csc.fi/lahioikeudet1-1589374892980.vtt	lahioikeudet1.vtt	4039	text/vtt	7bit	lahioikeudet1-1589374892980.vtt	testing	f	subtitles	Kolmas	fi	495	0
75	https://testing.object.pouta.csc.fi/lahioikeudet2-1589375356622.vtt	lahioikeudet2.vtt	4039	text/vtt	7bit	lahioikeudet2-1589375356622.vtt	testing	f	subtitles	Testi	sv	495	0
76	https://testing.object.pouta.csc.fi/lahioikeudet1-1589452849580.vtt	lahioikeudet1.vtt	4039	text/vtt	7bit	lahioikeudet1-1589452849580.vtt	testing	f	subtitles	Täysin uusi	fi	495	0
77	https://testing.object.pouta.csc.fi/lahioikeudet1-1589453019430.vtt	lahioikeudet1.vtt	4039	text/vtt	7bit	lahioikeudet1-1589453019430.vtt	testing	t	subtitles	Uusi tekstitys	fi	495	0
78	https://testing.object.pouta.csc.fi/lahioikeudet2-1589453076895.vtt	lahioikeudet2.vtt	4039	text/vtt	7bit	lahioikeudet2-1589453076895.vtt	testing	t	subtitles	Korvaava	fi	495	0
79	https://testing.object.pouta.csc.fi/avoinjulkaiseminensbv-1589457054907.vtt	avoinjulkaiseminen.sbv.vtt	3207	text/vtt	7bit	avoinjulkaiseminensbv-1589457054907.vtt	testing	f	subtitles	Textning	sv	565	0
80	https://testing.object.pouta.csc.fi/lahioikeudetsbv-1589457054904.vtt	lahioikeudet.sbv.vtt	4039	text/vtt	7bit	lahioikeudetsbv-1589457054904.vtt	testing	f	subtitles	Tekstitys	fi	565	0
67	https://testing.object.pouta.csc.fi/avoinjulkaiseminensvsbv-1585123113456.vtt	avoinjulkaiseminen sv.sbv.vtt	3098	text/vtt	7bit	avoinjulkaiseminensvsbv-1585123113456.vtt	testing	t	subtitles	Textning	sv	495	0
66	https://testing.object.pouta.csc.fi/avoinjulkaiseminensvsbv-1582526977126.vtt	avoinjulkaiseminen sv.sbv.vtt	3098	text/vtt	7bit	avoinjulkaiseminensvsbv-1582526977126.vtt	testing	f	subtitles	Textning	sv	454	0
69	https://testing.object.pouta.csc.fi/bestsubtitle-1586257241930.vtt	best-subtitle.vtt	0	application/octet-stream	7bit	bestsubtitle-1586257241930.vtt	testing	t	subtitles	Tekstitys suomeksi	fi	504	0
68	https://testing.object.pouta.csc.fi/avoinjulkaiseminensbv-1585123113434.vtt	avoinjulkaiseminen.sbv.vtt	3207	text/vtt	7bit	avoinjulkaiseminensbv-1585123113434.vtt	testing	t	subtitles	Tekstitys	fi	495	0
70	https://testing.object.pouta.csc.fi/lahioikeudet1-1589283677089.vtt	lahioikeudet1.vtt	4039	text/vtt	7bit	lahioikeudet1-1589283677089.vtt	testing	t	subtitles	subtitle.label	fi	495	0
71	https://testing.object.pouta.csc.fi/lahioikeudet1-1589373682274.vtt	lahioikeudet1.vtt	4039	text/vtt	7bit	lahioikeudet1-1589373682274.vtt	testing	t	subtitles	subtitle.label	fi	495	0
72	https://testing.object.pouta.csc.fi/lahioikeudet1-1589374665481.vtt	lahioikeudet1.vtt	4039	text/vtt	7bit	lahioikeudet1-1589374665481.vtt	testing	t	subtitles	Eka	fi	495	0
81	https://testing.object.pouta.csc.fi/avoinjulkaiseminensbv-1589457170842.vtt	avoinjulkaiseminen.sbv.vtt	3207	text/vtt	7bit	avoinjulkaiseminensbv-1589457170842.vtt	testing	f	subtitles	Textning	sv	565	0
82	https://testing.object.pouta.csc.fi/lahioikeudetensbv-1589457170842.vtt	lahioikeudet en.sbv.vtt	4046	text/vtt	7bit	lahioikeudetensbv-1589457170842.vtt	testing	f	subtitles	Tekstitys	fi	565	0
90	https://testing.object.pouta.csc.fi/lahioikeudet1-1589459790115.vtt	lahioikeudet1.vtt	4039	text/vtt	7bit	lahioikeudet1-1589459790115.vtt	testing	t	subtitles	gfd	en	565	0
85	https://testing.object.pouta.csc.fi/avoinjulkaiseminensbv-1589457240878.vtt	avoinjulkaiseminen.sbv.vtt	3207	text/vtt	7bit	avoinjulkaiseminensbv-1589457240878.vtt	testing	f	subtitles	Tekstitys	fi	565	0
86	https://testing.object.pouta.csc.fi/lahioikeudet1-1589457386654.vtt	lahioikeudet1.vtt	4039	text/vtt	7bit	lahioikeudet1-1589457386654.vtt	testing	t	subtitles	Ykkönen	fi	495	0
83	https://testing.object.pouta.csc.fi/avoinjulkaiseminensvsbv-1589457240880.vtt	avoinjulkaiseminen sv.sbv.vtt	3098	text/vtt	7bit	avoinjulkaiseminensvsbv-1589457240880.vtt	testing	f	subtitles	Textning	sv	565	0
87	https://testing.object.pouta.csc.fi/lahioikeudet1-1589457929682.vtt	lahioikeudet1.vtt	4039	text/vtt	7bit	lahioikeudet1-1589457929682.vtt	testing	f	subtitles	Toinen	sv	565	0
84	https://testing.object.pouta.csc.fi/avoinjulkaiseminenensbv-1589457240878.vtt	avoinjulkaiseminen en.sbv.vtt	2964	text/vtt	7bit	avoinjulkaiseminenensbv-1589457240878.vtt	testing	f	subtitles	Subtitles	en	565	0
92	https://testing.object.pouta.csc.fi/avoinjulkaiseminensvsbv-1589459912316.vtt	avoinjulkaiseminen sv.sbv.vtt	3098	text/vtt	7bit	avoinjulkaiseminensvsbv-1589459912316.vtt	testing	f	subtitles	textning	sv	565	0
89	https://testing.object.pouta.csc.fi/lahioikeudet2-1589459464843.vtt	lahioikeudet2.vtt	4039	text/vtt	7bit	lahioikeudet2-1589459464843.vtt	testing	f	subtitles	gdfgdf	fi	565	0
91	https://testing.object.pouta.csc.fi/avoinjulkaiseminenensbv-1589459912319.vtt	avoinjulkaiseminen en.sbv.vtt	2964	text/vtt	7bit	avoinjulkaiseminenensbv-1589459912319.vtt	testing	f	subtitles	Subtitles	en	565	0
88	https://testing.object.pouta.csc.fi/avoinjulkaiseminensvsbv-1589458623979.vtt	avoinjulkaiseminen sv.sbv.vtt	3098	text/vtt	7bit	avoinjulkaiseminensvsbv-1589458623979.vtt	testing	f	subtitles	Tekstitys	fi	565	0
94	https://testing.object.pouta.csc.fi/avoinjulkaiseminenensbv-1589460018261.vtt	avoinjulkaiseminen en.sbv.vtt	2964	text/vtt	7bit	avoinjulkaiseminenensbv-1589460018261.vtt	testing	f	subtitles	textning	sv	565	0
93	https://testing.object.pouta.csc.fi/avoinjulkaiseminenensbv-1589459947363.vtt	avoinjulkaiseminen en.sbv.vtt	2964	text/vtt	7bit	avoinjulkaiseminenensbv-1589459947363.vtt	testing	f	subtitles	abhaasi	ab	565	0
96	https://testing.object.pouta.csc.fi/avoinjulkaiseminenensbv-1589460086617.vtt	avoinjulkaiseminen en.sbv.vtt	2964	text/vtt	7bit	avoinjulkaiseminenensbv-1589460086617.vtt	testing	t	subtitles	subtitles	ab	565	0
95	https://testing.object.pouta.csc.fi/avoinjulkaiseminenensbv-1589460086609.vtt	avoinjulkaiseminen en.sbv.vtt	2964	text/vtt	7bit	avoinjulkaiseminenensbv-1589460086609.vtt	testing	f	subtitles	subtitles	ab	565	0
97	https://testing.object.pouta.csc.fi/avoinjulkaiseminenensbv-1589460172058.vtt	avoinjulkaiseminen en.sbv.vtt	2964	text/vtt	7bit	avoinjulkaiseminenensbv-1589460172058.vtt	testing	t	subtitles	subtitles	en	565	0
98	https://testing.object.pouta.csc.fi/avoinjulkaiseminensbv-1589460559301.vtt	avoinjulkaiseminen.sbv.vtt	3207	text/vtt	7bit	avoinjulkaiseminensbv-1589460559301.vtt	testing	f	subtitles	Tekstitys	fi	593	0
99	https://testing.object.pouta.csc.fi/avoinjulkaiseminensbv-1589460645912.vtt	avoinjulkaiseminen.sbv.vtt	3207	text/vtt	7bit	avoinjulkaiseminensbv-1589460645912.vtt	testing	f	subtitles	tekstitys	fi	594	0
100	https://testing.object.pouta.csc.fi/avoinjulkaiseminensbv-1589460721091.vtt	avoinjulkaiseminen.sbv.vtt	3207	text/vtt	7bit	avoinjulkaiseminensbv-1589460721091.vtt	testing	f	subtitles	tekstitys	fi	595	0
101	https://testing.object.pouta.csc.fi/lahioikeudet1-1594811431299.vtt	lahioikeudet1.vtt	4039	text/vtt	7bit	lahioikeudet1-1594811431299.vtt	testing	t	subtitles	Lorem ipsum dolor sit mit	fi	653	0
102	https://testing.object.pouta.csc.fi/ohjevideotekstitys-1596454346168.vtt	ohjevideo_tekstitys.vtt	5146	text/vtt	7bit	ohjevideotekstitys-1596454346168.vtt	testing	f	subtitles	Tekstitys	fi	667	0
103	https://testing.object.pouta.csc.fi/blackbirdfi-1597734693626.srt	blackbirdfi.srt	50	application/octet-stream	7bit	blackbirdfi-1597734693626.srt	testing	t	subtitles	Äänen kuvaus	fi	682	0
104	https://testing.object.pouta.csc.fi/lahioikeudet1-1598604538941.vtt	lahioikeudet1.vtt	4039	text/vtt	7bit	lahioikeudet1-1598604538941.vtt	testing	f	subtitles	ruotsi	sv	687	0
105	https://testing.object.pouta.csc.fi/lahioikeudet2-1598604538982.vtt	lahioikeudet2.vtt	4039	text/vtt	7bit	lahioikeudet2-1598604538982.vtt	testing	f	subtitles	lontoo	en	687	0
106	https://testing.object.pouta.csc.fi/avoinjulkaiseminensbv-1598606213056.vtt	avoinjulkaiseminen.sbv.vtt	3207	text/vtt	7bit	avoinjulkaiseminensbv-1598606213056.vtt	testing	f	subtitles	suomi	fi	688	0
107	https://testing.object.pouta.csc.fi/avoinjulkaiseminensvsbv-1598606213095.vtt	avoinjulkaiseminen_sv.sbv.vtt	3098	text/vtt	7bit	avoinjulkaiseminensvsbv-1598606213095.vtt	testing	f	subtitles	svenska	sv	688	0
108	https://testing.object.pouta.csc.fi/avoinjulkaiseminenensbv-1598606213165.vtt	avoinjulkaiseminen_en.sbv.vtt	2964	text/vtt	7bit	avoinjulkaiseminenensbv-1598606213165.vtt	testing	f	subtitles	English	en	688	0
118	https://testing.object.pouta.csc.fi/avoinjulkaiseminensbv-1598609535317.vtt	avoinjulkaiseminen.sbv.vtt	3207	text/vtt	7bit	avoinjulkaiseminensbv-1598609535317.vtt	testing	f	subtitles	Tekstitys	fi	693	0
119	https://testing.object.pouta.csc.fi/avoinjulkaiseminenensbv-1598609535365.vtt	avoinjulkaiseminen_en.sbv.vtt	2964	text/vtt	7bit	avoinjulkaiseminenensbv-1598609535365.vtt	testing	f	subtitles	Subtitles	en	693	0
124	https://testing.object.pouta.csc.fi/ymparistosvsbv-1598610020291.vtt	ymparisto_sv.sbv.vtt	6100	text/vtt	7bit	ymparistosvsbv-1598610020291.vtt	testing	f	subtitles	testi	sv	697	0
112	https://testing.object.pouta.csc.fi/videotsvsbv-1598606812327.vtt	videot_sv.sbv.vtt	4810	text/vtt	7bit	videotsvsbv-1598606812327.vtt	testing	f	subtitles	tekstitys1	fi	689	0
113	https://testing.object.pouta.csc.fi/ymparistosvsbv-1598606812382.vtt	ymparisto_sv.sbv.vtt	6100	text/vtt	7bit	ymparistosvsbv-1598606812382.vtt	testing	f	subtitles	tekstitys2	sv	689	0
114	https://testing.object.pouta.csc.fi/lahioikeudet1-1598607308578.vtt	lahioikeudet1.vtt	4039	text/vtt	7bit	lahioikeudet1-1598607308578.vtt	testing	f	subtitles	yksi	fi	690	0
115	https://testing.object.pouta.csc.fi/lahioikeudet2-1598607308627.vtt	lahioikeudet2.vtt	4039	text/vtt	7bit	lahioikeudet2-1598607308627.vtt	testing	f	subtitles	kaksi	sv	690	0
116	https://testing.object.pouta.csc.fi/lahioikeudet2-1598608826589.vtt	lahioikeudet2.vtt	4039	text/vtt	7bit	lahioikeudet2-1598608826589.vtt	testing	f	subtitles	hfghfg	en	691	0
117	https://testing.object.pouta.csc.fi/lahioikeudet1-1598608826632.vtt	lahioikeudet1.vtt	4039	text/vtt	7bit	lahioikeudet1-1598608826632.vtt	testing	f	subtitles	dsdf	sv	691	0
120	https://testing.object.pouta.csc.fi/avoinjulkaiseminensvsbv-1598609535364.vtt	avoinjulkaiseminen_sv.sbv.vtt	3098	text/vtt	7bit	avoinjulkaiseminensvsbv-1598609535364.vtt	testing	f	subtitles	Textning	sv	693	0
9	https://testing.object.pouta.csc.fi/avoinjulkaiseminenen-1579169130657.sbv	avoinjulkaiseminen en.sbv	2830	application/octet-stream	7bit	avoinjulkaiseminenen-1579169130657.sbv	testing	f	subtitles	Open publishing	en	340	1
121	https://testing.object.pouta.csc.fi/videotsvsbv-1598609775382.vtt	videot_sv.sbv.vtt	4810	text/vtt	7bit	videotsvsbv-1598609775382.vtt	testing	f	subtitles	heprea 1	fi	695	0
122	https://testing.object.pouta.csc.fi/ymparistosvsbv-1598609775394.vtt	ymparisto_sv.sbv.vtt	6100	text/vtt	7bit	ymparistosvsbv-1598609775394.vtt	testing	f	subtitles	heprea 2	he	695	0
10	https://testing.object.pouta.csc.fi/avoinjulkaiseminen-1579169130681.sbv	avoinjulkaiseminen.sbv	3073	application/octet-stream	7bit	avoinjulkaiseminen-1579169130681.sbv	testing	t	subtitles	Avoin julkaiseminen	fi	340	1
123	https://testing.object.pouta.csc.fi/videotsvsbv-1598610020206.vtt	videot_sv.sbv.vtt	4810	text/vtt	7bit	videotsvsbv-1598610020206.vtt	testing	f	subtitles	tekti	fi	697	0
125	https://testing.object.pouta.csc.fi/videotsvsbv-1599202121191.vtt	videot_sv.sbv.vtt	4810	text/vtt	7bit	videotsvsbv-1599202121191.vtt	testing	f	subtitles	videot	fi	688	0
110	https://testing.object.pouta.csc.fi/avoinjulkaiseminensvsbv-1598606401297.vtt	avoinjulkaiseminen_sv.sbv.vtt	3098	text/vtt	7bit	avoinjulkaiseminensvsbv-1598606401297.vtt	testing	t	subtitles	svenska	sv	688	0
111	https://testing.object.pouta.csc.fi/avoinjulkaiseminenensbv-1598606401303.vtt	avoinjulkaiseminen_en.sbv.vtt	2964	text/vtt	7bit	avoinjulkaiseminenensbv-1598606401303.vtt	testing	f	subtitles	english	en	688	0
109	https://testing.object.pouta.csc.fi/avoinjulkaiseminensbv-1598606401287.vtt	avoinjulkaiseminen.sbv.vtt	3207	text/vtt	7bit	avoinjulkaiseminensbv-1598606401287.vtt	testing	f	subtitles	suomi	fi	688	0
11	https://testing.object.pouta.csc.fi/avoinjulkaiseminensv-1579169130674.sbv	avoinjulkaiseminen sv.sbv	2964	application/octet-stream	7bit	avoinjulkaiseminensv-1579169130674.sbv	testing	f	subtitles	Avoin julkaiseminen sv	sv	340	1
126	https://testing.object.pouta.csc.fi/aoejulkaisuwebinaari-1611131128926.srt	aoe_julkaisuwebinaari.srt	98343	application/octet-stream	7bit	aoejulkaisuwebinaari-1611131128926.srt	testing	f	subtitles	tekstiä	fi	878	0
\.


--
-- Data for Name: attachmentversioncomposition; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.attachmentversioncomposition (versioneducationalmaterialid, versionmaterialid, versionpublishedat, attachmentid) FROM stdin;
112	268	2019-12-18 13:44:10.406	1
137	334	2020-01-15 06:51:19.803	2
137	334	2020-01-15 06:51:19.803	3
137	334	2020-01-15 06:51:19.803	4
140	338	2020-01-16 07:46:46.231	5
140	338	2020-01-16 07:46:46.231	6
140	338	2020-01-16 07:46:46.231	7
141	339	2020-01-16 10:01:15.837	8
142	340	2020-01-16 10:06:59.427	9
142	340	2020-01-16 10:06:59.427	10
142	340	2020-01-16 10:06:59.427	11
143	342	2020-01-16 10:24:17.752	12
143	342	2020-01-16 10:24:17.752	13
144	345	2020-04-03 10:38:41.222	14
144	345	2020-04-03 10:38:41.222	15
168	395	2020-01-23 12:40:22.943	46
168	395	2020-01-23 12:40:22.943	47
183	417	2020-02-13 11:37:16.332	48
184	418	2020-02-13 11:48:07.889	49
189	424	2020-02-13 12:37:46.503	57
189	424	2020-02-13 12:37:46.503	58
193	430	2020-02-18 06:14:46.537	59
193	430	2020-02-18 06:14:46.537	60
203	454	2020-02-24 06:52:10.285	65
203	454	2020-02-24 06:52:10.285	66
241	504	2020-04-07 11:55:25.809	69
234	495	2020-04-15 08:02:45.761	67
234	495	2020-04-15 08:02:45.761	68
234	495	2020-05-14 10:43:49.944	77
234	495	2020-05-14 10:44:44.383	78
207	565	2020-05-14 11:54:08.008	85
207	565	2020-05-14 11:54:08.008	84
207	565	2020-05-14 11:54:08.008	83
234	495	2020-05-14 11:56:31.25	86
207	565	2020-05-14 12:04:47.045	83
207	565	2020-05-14 12:04:47.045	84
207	565	2020-05-14 12:05:36.749	87
207	565	2020-05-14 12:05:36.749	84
207	565	2020-05-14 12:17:10.916	88
207	565	2020-05-14 12:17:10.916	87
207	565	2020-05-14 12:31:10.462	87
207	565	2020-05-14 12:31:10.462	88
207	565	2020-05-14 12:31:10.462	89
207	565	2020-05-14 12:36:33.389	87
207	565	2020-05-14 12:36:33.389	88
207	565	2020-05-14 12:36:33.389	89
207	565	2020-05-14 12:36:33.389	90
207	565	2020-05-14 12:38:37.982	87
207	565	2020-05-14 12:38:37.982	88
207	565	2020-05-14 12:38:37.982	91
207	565	2020-05-14 12:38:37.982	92
207	565	2020-05-14 12:39:13.079	88
207	565	2020-05-14 12:39:13.079	91
207	565	2020-05-14 12:39:13.079	92
207	565	2020-05-14 12:39:13.079	93
207	565	2020-05-14 12:39:35.461	88
207	565	2020-05-14 12:39:35.461	92
207	565	2020-05-14 12:39:35.461	93
207	565	2020-05-14 12:40:44.821	88
207	565	2020-05-14 12:40:44.821	94
207	565	2020-05-14 12:40:44.821	93
207	565	2020-05-14 12:41:31.347	88
207	565	2020-05-14 12:41:31.347	94
207	565	2020-05-14 12:41:31.347	93
207	565	2020-05-14 12:41:31.347	95
207	565	2020-05-14 12:41:31.347	96
207	565	2020-05-14 12:43:00.553	88
207	565	2020-05-14 12:43:00.553	94
207	565	2020-05-14 12:43:00.553	95
207	565	2020-05-14 12:43:00.553	97
301	687	2020-08-28 08:49:26.206	104
301	687	2020-08-28 08:49:26.206	105
312	688	2020-08-28 09:20:08.513	109
312	688	2020-08-28 09:20:08.513	110
312	688	2020-08-28 09:20:08.513	111
315	691	2020-08-28 10:00:54.341	116
315	691	2020-08-28 10:00:54.341	117
317	693	2020-08-28 10:15:07.361	118
317	693	2020-08-28 10:15:07.361	119
317	693	2020-08-28 10:15:07.361	120
318	695	2020-08-28 10:17:40.234	121
318	695	2020-08-28 10:17:40.234	122
313	697	2020-08-28 10:20:31.917	123
313	697	2020-08-28 10:20:31.917	124
313	697	2020-08-28 10:21:18.651	124
313	697	2020-08-28 10:21:18.651	123
312	688	2020-09-04 06:48:47.139	110
312	688	2020-09-04 06:48:47.139	111
312	688	2020-09-04 06:48:47.139	125
394	878	2021-01-20 08:26:09.646	126
\.


--
-- Data for Name: author; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.author (id, authorname, organization, educationalmaterialid, organizationkey) FROM stdin;
1	testi timo	A. Hätinen Oy	1	1.2.246.562.10.58952610762
2	Virkkunen, Päivi	Helsingin yliopisto	2	1.2.246.562.10.39218317368
3		Aalto-yliopisto, Taiteiden ja suunnittelun korkeakoulu	4	1.2.246.562.10.25401456758
4	Toivanen, Tero		7	
5		Suomen koodikoulu	8	suomenkoodikoulu
6	Koli, Hanne		12	
7	Koli, Hanne		13	
8	Koli, Hanne		14	
9	Koli, Hanne		18	
10	Ilomäki, Liisa		19	
11	Ilomäki, Liisa	Helsingin yliopisto	20	1.2.246.562.10.39218317368
12	Hopeakoski, Sari	Helsingin yliopisto	20	1.2.246.562.10.39218317368
13	Lehtonen, Kalle		23	
14		Suomen koodikoulu	24	suomenkoodikoulu
15	Mehiläinen, Maija	Helsingin aikuislukio	43	1.2.246.562.10.81017043621
16	Hovi Jani	Saimaan ammattiopisto Sampo, Tekniikan ala, Imatra	44	1.2.246.562.10.45497399738
17	sdfsdfsdfsd		52	
18	Mehiläinen, Maija		16	
19	Virkkunen, Päivi		56	
20	Virkkunen, Päivi	Helsingin yliopisto	57	1.2.246.562.10.39218317368
21	Virkkunen, Päivi	Helsingin yliopisto	54	1.2.246.562.10.39218317368
22	Testi, Testi	Aalto-yliopisto, Avoin yliopisto	59	1.2.246.562.10.60811147247
23	Koli, Hanne		61	
24	asdasdasdasdasd	Äänekosken kansalaisopisto Koskela	67	1.2.246.562.10.90047369294
28	Teppo		73	
29	väinämöinen		74	
30	Tekijä	Aalto-yliopisto, Avoin yliopisto	75	1.2.246.562.10.60811147247
31	Vainio, Leena		76	
32	testi, testaaja		77	
33	Testaaja, Teppo	Aarrelaiva Oy	78	1.2.246.562.10.68767615369
34	dsadasdasdas		81	
35	javascript:alert("Hi there")		97	
36	Teppo		99	
37	Teppo		100	
38	Teppo		101	
39	Testaaja, Teppo		103	
40	aapo		107	
41	Testaaja, Teppo		108	
42	Testaaja		110	
43	Testaaja, Teppo		111	
44	dsfsdf		112	
45	Teppo		117	
46	testi testaaja		118	
47	Testaaja, Tepponen		123	
48	asdasdasdas		127	
49	henkilö ,heikki	Aalto kansalaisopisto	128	1.2.246.562.10.17695871545
50		CSC-Tieteen tietotekniikan keskus Oy	128	1.2.246.562.10.2013112012294919827487
51	gfdfg		132	
52	Tulppu, Teppo		137	
53	Testi		138	
54	dfg		139	
55	Lehtonen, Kalle		140	
56	Testi		141	
57	Toikkanen, Tarmo		142	
58	Toikkanen, Tarmo		143	
60		Länsirannikon Koulutus Oy	160	1.2.246.562.10.82246911869
61	Mehiläinen, Maija		165	
62	Toikkanen, Tarmo		168	
63	adas		171	
64	gfhgf		174	
65	sdfsd		175	
66	Toikkanen, Tarmo		176	
69	tekijä		182	
70	Toikkanen, Tarmo		183	
71	kokeilija, koetyttö		184	
72	Testaaja, Teppo		189	
73	Kokeilija, Koekäyttäjä		193	
74		Koeorganisaatio	193	koeorganisaatio
77	Kokeilija, Koekäyttäjä	Aalto kansalaisopisto	202	1.2.246.562.10.17695871545
79	Seppo		204	
83	Testinen, Testi		216	
86	Testaaja, Teppo		222	
87	Testaaja, Teppo		223	
88	testaaja,testi	CSC-Tieteen tietotekniikan keskus Oy	224	1.2.246.562.10.2013112012294919827487
94	tekijä, timo		235	
124	Toikkanen, Tarmo	Aalto-yliopisto	144	1.2.246.562.10.56753942459
125	Toikkanen, Tarmo		144	
129	matti, meikäläinen		230	
458	Mehiläinen, Maija		351	
144	Testaaja, Teppo	Aurinkokiven koulu	231	1.2.246.562.10.11200144647
145		Ammattiopisto Luovi, Helsingin yksikkö	231	1.2.246.562.10.55931024156
147	kelo, Tapio		178	
150	Linkittäjä, Linkki		217	
175	Testinen, Testi		239	
184	Testinen, Testi		243	
187	Kokeilinen, Kokeilija	Aalto kansalaisopisto	245	1.2.246.562.10.17695871545
200	Kokeilija, Koekäyttäjä	Aalto-yliopisto, Sähkötekniikan korkeakoulu	215	1.2.246.562.10.38864316104
204	Kokeilija, Koekäyttäjä	Aallonhuipun päiväkoti	203	1.2.246.562.10.88311418342
208	Testaaja, Testi		260	
214	Kukkiva, Kukka		200	
215		organizatision	200	organizatision
464	Lindfors, Anna		382	
223	test,testinggg		264	
224		OHO-hanke	265	ohohanke
225	test,Testingggggg		266	
237	Kokeilija, Koekäyttäjä	Helsingin yliopiston kirjasto	234	helsinginyliopistonkirjasto
238		Aallonhuipun päiväkoti	234	1.2.246.562.10.88311418342
247	Kokeilija, Koekäyttäjä	Aitoon koulutuskeskus, Tampere	207	1.2.246.562.10.35845772686
249	Kokeilija, Koekäyttäjä	Aitoon koulu	249	1.2.246.562.10.70175634446
253	Testi		261	
254	Tekijä, Tekijä		263	
256	Kukkiva, Kukka		233	
257	Kukkiva, Kukka		269	
258	Testi		259	
260	Tekijä		258	
261	Ropponen, Mika	CSC-Tieteen tietotekniikan keskus Oy	228	1.2.246.562.10.2013112012294919827487
262	isomäki, Toni	A. Hätinen Oy	214	1.2.246.562.10.58952610762
263		Aallonhuipun päiväkoti	214	1.2.246.562.10.88311418342
264	kanala, jari	5-åringarnas språkbad (Alma)	270	1.2.246.562.10.51453362991
270	Ostajainen, Lounasruokailija	Äkkiväärän Päiväkoti	257	1.2.246.562.10.85831636338
271	koe, koe		276	
277	Mehiläinen, Maija	Puistokoulu	177	1.2.246.562.10.75201288117
278	Ropponen, Mika	CSC-Tieteen tietotekniikan keskus Oy	241	1.2.246.562.10.2013112012294919827487
279	Mehiläinen, Maija	Puistokoulu	284	1.2.246.562.10.75201288117
281	Testaaja, Teppo		277	
282	Toivanen, Tero		285	
283	Testinen, Testi		286	
284		oho-hanke	287	ohohanke
285		https://aoe.fi/#/materiaali/379	287	httpsaoefimateriaali379
287	Tekijäinen, Tekijä		291	
291	Lehto, Olli	Puistokoulu	293	1.2.246.562.10.75201288117
471	Kukkainen, Kukka	Aalto-korkeakoulusäätiö sr	380	1.2.246.562.10.82388989657
299	Hakkeri, Heikki		169	
302		Matikkakoulu	246	matikkakoulu
306	Kokeilinen, Kokeilija	Äänekosken kaupunki	268	1.2.246.562.10.41953359605
307	Lorem ipsum dolor sit amet, consectetur porttitori		296	
309	Matkaaja, Matias		267	
310	Kasvi, Kaisa		247	
473	Testi-henkilö, Testaaja		327	
475	Eränpalo, Tommi		362	
313	Testajaa, Tepponen		294	
314	Testaaja-Testinen, Teppo		297	
476	Karhuvirta, Tiina		362	
478	Testaaja, Testi		385	
321	kanala, jari		302	
322	Toivanen, Tero		282	
323	Testinen, Testi		282	
324	tests		301	
480	kanala, k		390	
328	adsas		314	
329	ryry		315	
331	Toikkanen, Tarmo		317	
488	isomäki, Toni		355	
333	Matkija, Lintu		318	
505	Lehto, Olli		309	
344	Caine, Michael		290	
347	Kuukaileva, Kukka	Aktiivi-instituutti	337	1.2.246.562.10.56695937518
348	Testinen, Testaaja		338	
349	Testinen, Testaaja		339	
350	Testinen, Testaaja		340	
351	Testinen, Testaaja		341	
352	Testinen, Testaaja		342	
353	Testinen, Testaaja		343	
354	Testinen, Testaaja		344	
355	Testailija, testaaja		345	
356	Testailija, testin		346	
357	Testailija, testi		347	
360	Testailija, testi		350	
514	Katkoton, Sähkö		400	
516		Väestöliitto	292	vestliitto
366	Kokeilinen, Kokeilija	A. Hätinen Oy	271	1.2.246.562.10.58952610762
521	Lindfors, Anna	CSC-Tieteen tietotekniikan keskus Oy	381	1.2.246.562.10.2013112012294919827487
522		Halkokarin koulu	381	1.2.246.562.10.26264179479
370	gdgdf		316	
378	Mehiläinen		304	
379	Testaaja, Teppo	Rekivaaran koulu	208	1.2.246.562.10.60061848499
393	Testinen, Testikäyttäjä		358	
397	kokeilija, koe		313	
398	Testajaa, Testi	AAMU-JA ILTAPÄIVÄKERHO	360	1.2.246.562.10.42481131946
399	Testaaja-Testinen, Testikäyttäjä		361	
402	Kenttälä, Marjo		363	
403	Ruohonen, Teemu		363	
413	Testinen, Testaaja		365	
421	Testinen, testaaja		348	
422	Lindfors, Anna		368	
424	Kokeinen, Koehlö		366	
430	Testi		303	
431	Expertti, Ruoka	Aallonhuipun päiväkoti	369	1.2.246.562.10.88311418342
433	Testailija, Testi		367	
440	Testaaja, Teppo	Ammattiopisto Lappia, Rovaniemi	220	1.2.246.562.10.10146969034
441	Tekijä, Tekijä	Aalto-yliopisto, Perustieteiden korkeakoulu	220	1.2.246.562.10.39920288212
442	Testaaja-Testinen, Teppo		279	
443	Mölönen, Mösti		279	
444	Testimateriaali		288	
460	Testailija, Testi		378	
466	Tuura, kauppaneuvos		275	
469	Lehto, Olli		310	
470		CSC-Tieteen tietotekniikan keskus Oy	310	1.2.246.562.10.2013112012294919827487
472	Moilanen, Antti		364	
451	Testinen, Testi		370	
452	Kuskailija, Kuski		370	
453	Kolma, Kolmas		370	
454		Aalto-yliopisto	370	1.2.246.562.10.56753942459
455		Aalto kansalaisopisto	370	1.2.246.562.10.17695871545
456		Ahjolan kansalaisopisto	370	1.2.246.562.10.39922874043
457		Aalto-yliopisto, Perustieteiden korkeakoulu	370	1.2.246.562.10.39920288212
474	Videoilija, Video		312	
479	Meikäläinen		356	
481	Testailija, Testi		391	
483	Testi		392	
489	Kokeinen, Koke		393	
495	Testailija, testi		349	
497		5-åringarnas språkbad (Alma)	394	1.2.246.562.10.51453362991
513	Kaikki, Sujuu		399	
515	Meta, Filo		401	
518	Kasku, Kaksku	Aallonhuipun päiväkoti	396	1.2.246.562.10.88311418342
520	Kokeinen, Koke		395	
528	Kangas, Jonna	Helsingin yliopisto, Kasvatustieteellinen tiedekunta	402	1.2.246.562.10.67451633415
529	Reunamo, Jyrki	Helsingin yliopisto, Kasvatustieteellinen tiedekunta	402	1.2.246.562.10.67451633415
530	Erfving, Emilia		402	
531		LUMA-keskus Suomi	402	lumakeskussuomi
532		Helsingin yliopiston tiedekasvatus	402	helsinginyliopistontiedekasvatus
533	Lindfors, Anna		403	
534	Kokeilija, Koehenkilö		404	
535	Testaaja, Testi		405	
537	Kokeilija, Koe-erä		407	
538	Testainen, Testi		408	
539	Testinen, Testi		409	
540	Kokeellinen, Koe		251	
541	Koke, K.		359	
543	Teppo		354	
545	Kokei, koe		410	
549		Avointen oppimateriaalien kirjasto	306	avointenoppimateriaalienkirjasto
552		saavutettavasti.fi	406	saavutettavastifi
553			406	
555		Ada Äijälän koulu O/Y	300	1.2.246.562.10.12475679333
556	Kukkiva, Kukka		420	
\.


--
-- Data for Name: collection; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.collection (id, createdat, updatedat, publishedat, createdby, agerangemin, agerangemax, collectionname, description) FROM stdin;
6	2020-05-20 10:47:29.743635+00	2020-05-20 10:47:29.743635+00	\N	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	\N	Testi testi	\N
7	2020-05-20 10:48:07.300784+00	2020-05-20 10:48:07.300784+00	\N	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	\N	Testiä	\N
8	2020-05-20 10:48:46.162777+00	2020-05-20 10:48:46.162777+00	\N	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	\N	Test	\N
9	2020-05-20 10:50:45.44838+00	2020-05-20 10:50:45.44838+00	\N	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	\N	Testitesti	\N
10	2020-05-25 08:40:06.868198+00	2020-05-25 08:40:06.868198+00	\N	mroppone@csc.fi	\N	\N	Stone head collection	\N
13	2020-05-25 09:02:32.041523+00	2020-05-25 09:02:32.041523+00	\N	anlindfo@csc.fi	\N	\N	Testaus	\N
15	2020-05-28 07:56:49.529789+00	2020-05-28 07:56:49.529789+00	\N	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	\N	Uusi kokoelma	\N
16	2020-05-28 07:57:32.312558+00	2020-05-28 07:57:32.312558+00	\N	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	\N	New collection	\N
17	2020-05-28 07:57:55.152572+00	2020-05-28 07:57:55.152572+00	\N	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	\N	Kokoelma 23	\N
19	2020-06-26 05:50:58.867121+00	2020-06-26 05:50:58.867121+00	\N	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	\N	tämä on kokoelma	\N
20	2020-07-16 08:32:30.890421+00	2020-07-16 08:32:30.890421+00	\N	olehto@csc.fi	\N	\N	Omat suosikkimateriaalit	\N
21	2020-07-17 06:54:40.381291+00	2020-07-17 06:54:40.381291+00	\N	olehto@csc.fi	\N	\N	Verkko-oppiminen	\N
22	2020-07-17 06:54:48.676732+00	2020-07-17 06:54:48.676732+00	\N	olehto@csc.fi	\N	\N	Digipedagogiikka	\N
18	2020-06-04 09:02:52.249685+00	2020-09-24 06:35:22.733988+00	2020-08-27 06:27:33.753172+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	\N	\N	Avointen oppimateriaalien hyödyntäminen opetuksessa	Tähän kokoelmaan olen kerännyt testaaja-henkilömme testaus-tarpeisiin sopivia testi-materiaaleja. Kaiken kaikkiaan, erinomainen testaus-kokoelma.
2	2020-05-20 10:03:21.464602+00	2020-12-14 11:45:14.163322+00	2020-08-11 12:19:47.164813+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	\N	Toinen kokoelma	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse tincidunt hendrerit odio, vel vulputate augue. Ut vel orci aliquam, dictum erat in, scelerisque magna. Nunc ultricies bibendum nunc in posuere. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed porta sodales odio, commodo commodo orci fermentum a.
12	2020-05-25 09:02:12.065247+00	2020-08-17 13:26:08.326378+00	2020-08-17 13:26:08.326378+00	anlindfo@csc.fi	\N	\N	Esimerkkikokoelma	Tämä kokoelma ohjeistaa kokoelma-työkalun käyttöön Avointen oppimateriaalien kirjastossa.
14	2020-05-27 11:39:30.475516+00	2020-08-18 11:46:04.435359+00	2020-08-18 11:44:34.936766+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	\N	Kokeilu	test test
3	2020-05-20 10:05:40.037778+00	2020-08-13 06:09:13.163464+00	\N	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	\N	Kolmas	XXXX
11	2020-05-25 08:59:01.332285+00	2020-09-03 08:37:04.40599+00	2020-08-18 11:40:09.921323+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	\N	Vartijan ammattitutkinto	Tähän materiaaliin kerätään vartjuuteen liittyvät laadukkaat oppimateriaalit. Pidä tämä siis aloitussivunasi kun haluat oppia vartijan ammattisaloista!
4	2020-05-20 10:06:30.496265+00	2020-09-08 05:49:18.634462+00	2020-08-13 06:05:52.639518+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	\N	Neljäs kokoelma	Kokoelmainen kuvaus
1	2020-05-20 09:54:36.755256+00	2020-09-17 09:23:29.717505+00	2020-07-30 07:23:13.022735+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	\N	Testi	Testikuvaus
5	2020-05-20 10:07:08.922659+00	2020-08-31 09:42:06.442205+00	2020-08-14 09:17:03.575937+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	\N	Esimerkkikokoelma	Tämä kokoelma toimii esimerkkinä ohjeistustarkoituksessa. 
23	2020-09-17 06:21:37.783588+00	2020-09-17 09:59:34.189907+00	\N	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	\N	\N	keskeneräinen	kaklekl
24	2020-09-22 06:23:18.023279+00	2020-09-22 06:23:18.023279+00	\N	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	\N	\N	in progress	\N
25	2020-10-08 10:24:45.361903+00	2020-10-08 10:29:47.807633+00	\N	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	\N	Kouludemokratia	Kouludemokratiasta kertova materiaalikokonaisuus.
26	2020-10-29 08:57:07.031467+00	2020-10-29 09:03:41.445216+00	2020-10-29 09:02:55.728711+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	\N	\N	pdf-konveretteri	Tämä kokoelma testaa pdf-konveretterin haasteita
\.


--
-- Data for Name: collectionaccessibilityfeature; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.collectionaccessibilityfeature (id, value, accessibilityfeaturekey, collectionid) FROM stdin;
12	tekstitys	098c131b-7de2-49f1-aef9-508132bb46c6	12
13	tekstivastine	0ab440bf-1d0d-4d6a-907b-ac080c32ea3c	12
23	large print	f5abf3e7-ac02-455b-b7a4-6fd4ee5b2c97	14
31	isokokoinen teksti	f5abf3e7-ac02-455b-b7a4-6fd4ee5b2c97	1
32	latex	3b7bda53-a037-487e-a355-b2f1b20a50b6	1
33	isokokoinen teksti	f5abf3e7-ac02-455b-b7a4-6fd4ee5b2c97	23
38	selkokieli	1f91471b-82d9-4e61-a9e7-637579bf4684	18
41	käsikirjoitus	1bee480d-c3db-4b10-9e37-6f05a34c0521	2
42	latex	3b7bda53-a037-487e-a355-b2f1b20a50b6	2
\.


--
-- Data for Name: collectionaccessibilityhazard; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.collectionaccessibilityhazard (id, value, accessibilityhazardkey, collectionid) FROM stdin;
18	ei esteitä	b3293084-f161-4e86-8d68-139588769157	12
33	unknown	85b2dd0b-b362-467b-9904-cfd84e2b0e82	14
40	ei esteitä	b3293084-f161-4e86-8d68-139588769157	5
41	ei esteitä	b3293084-f161-4e86-8d68-139588769157	11
47	ei tiedossa	85b2dd0b-b362-467b-9904-cfd84e2b0e82	1
48	ei välähtelyhaittaa	928f2c31-0779-4991-9e48-3af79aba67a3	1
49	ei esteitä	b3293084-f161-4e86-8d68-139588769157	23
58	ei esteitä	b3293084-f161-4e86-8d68-139588769157	18
59	ei äänihaittaa	e2165852-c2ec-47b7-8dd5-7cfbfad52697	18
60	ei välähtelyhaittaa	928f2c31-0779-4991-9e48-3af79aba67a3	18
61	ei tiedossa	85b2dd0b-b362-467b-9904-cfd84e2b0e82	25
63	ei esteitä	b3293084-f161-4e86-8d68-139588769157	26
66	ei välähtelyhaittaa	928f2c31-0779-4991-9e48-3af79aba67a3	2
67	ei äänihaittaa	e2165852-c2ec-47b7-8dd5-7cfbfad52697	2
\.


--
-- Data for Name: collectionalignmentobject; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.collectionalignmentobject (id, alignmenttype, collectionid, targetname, source, educationalframework, objectkey, targeturl) FROM stdin;
179	educationalSubject	11	Turvallisuusalan perustutkinto	vocationalDegrees	\N	3536450	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/3536450
197	educationalSubject	23	Biologia	upperSecondarySchoolSubjectsOld	\N	BI	\N
198	educationalSubject	23	Solu ja perinnöllisyys	upperSecondarySchoolCoursesOld	\N	BI3	\N
199	educationalSubject	23	Musiikkialan perustutkinto	vocationalDegrees	\N	6749301	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6749301
200	educationalSubject	23	Musiikkialan toimintaympäristössä toimiminen	vocationalUnits	\N	6746417	\N
201	teaches	23	tunnistaa yritystoiminnan periaatteet	vocationalRequirements	\N	2251	\N
255	educationalSubject	25	Terveystiede	branchesOfScience	\N	3141	https://virkailija.opintopolku.fi/koodisto-service/rest/codeelement/tieteenala_3141
256	educationalSubject	25	Kansanterveystiede, ympäristö ja työterveys	branchesOfScience	\N	3142	https://virkailija.opintopolku.fi/koodisto-service/rest/codeelement/tieteenala_3142
26	educationalSubject	3	Bildkonst	basicStudySubjects	\N	466342	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/466342
27	teaches	3	M3 inspirera eleven att ge uttryck för sina iakttagelser och tankar i bild genom att använda olika tekniker och metoder för att uttrycka sig i olika miljöer	basicStudyObjectives	\N	662004	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/466342
28	teaches	3	K2 Kulturell och kommunikativ kompetens	basicStudyContents	\N	428671	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/laajaalaisetosaamiset/428671
29	teaches	3	I1 Egna bildkulturer	basicStudyContents	\N	469555	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/466342
271	educationalSubject	2	testi	earlyChildhoodEducationSubjects	fdsfdsfds	testi	\N
272	educationalSubject	2	Biologia	basicStudySubjects	OPS2020	478970	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/478970
273	educationalSubject	2	Fysiikka	basicStudySubjects	OPS2020	466346	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/466346
274	teaches	2	T1 kannustaa ja innostaa oppilasta fysiikan opiskeluun	basicStudyObjectives	OPS2020	472457	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/466346
275	teaches	2	T2 ohjata ja kannustaa oppilasta tunnistamaan omaa fysiikan osaamistaan, asettamaan tavoitteita omalle työskentelylleen sekä työskentelemään pitkäjänteisesti	basicStudyObjectives	OPS2020	472458	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/466346
276	educationalSubject	2	Biologia	upperSecondarySchoolSubjectsNew	\N	6832790	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6828810/lops2019/oppiaineet/6832790
277	educationalSubject	2	Islamin uskonto	upperSecondarySchoolSubjectsNew	\N	6834381	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6828810/lops2019/oppiaineet/6834381
278	educationalSubject	2	Matematiikan lyhyt oppimäärä	upperSecondarySchoolSubjectsNew	\N	6831747	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6828810/lops2019/oppiaineet/6831747
279	educationalSubject	2	Ruotsi, A-oppimäärä	upperSecondarySchoolSubjectsNew	\N	6830287	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6828810/lops2019/oppiaineet/6830287
280	educationalSubject	2	Hevostalouden perustutkinto (Tuleva)	vocationalDegrees	\N	6828811	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6828811
281	educationalSubject	2	Hevostalouden perustehtävissä toimiminen	vocationalUnits	\N	6858268	\N
282	educationalSubject	2	Hevosten liikunnasta huolehtiminen	vocationalUnits	\N	6858269	\N
283	teaches	2	huomioi työssään lajityypillisten ja yksilöllisten käyttäytymistarpeiden toteutumista ja niiden vaikutusta hevosten fyysiselle ja psyykkiselle hyvinvoinnille	vocationalRequirements	\N	6204	\N
284	teaches	2	hoitaa hevosia tallissa, pihatossa ja laitumella ja tekee tallin päivittäiset ja kausittaiset työtehtävät	vocationalRequirements	\N	6205	\N
171	educationalSubject	5	Kemia	upperSecondarySchoolSubjectsNew	\N	6832793	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6828810/lops2019/oppiaineet/6832793
172	educationalSubject	5	Filosofia	upperSecondarySchoolSubjectsNew	\N	6832794	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6828810/lops2019/oppiaineet/6832794
173	educationalSubject	5	Yhteiskuntafilosofia	upperSecondarySchoolModulesNew	\N	6833504	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6828810/lops2019/oppiaineet/6832794/moduulit/6833504
174	educationalSubject	5	Kemiallinen tasapaino	upperSecondarySchoolModulesNew	\N	6833501	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6828810/lops2019/oppiaineet/6832793/moduulit/6833501
175	teaches	5	pystyy arvioimaan filosofisesti yhteiskunnan rakennetta ja sen oikeutusta	upperSecondarySchoolObjectivesNew	\N	6833622	\N
176	teaches	5	tutustuu teollisuuden prosesseissa ja luonnossa tapahtuviin tasapainoreaktioihin ja niiden merkitykseen.	upperSecondarySchoolObjectivesNew	\N	6833549	\N
177	teaches	5	poliittiset ihanteet: liberalismi, sosialismi, anarkismi, konservatismi, nationalismi; yhteiskunnalliset utopiat ja dystopiat	upperSecondarySchoolContentsNew	\N	7159158	\N
178	teaches	5	reaktionopeuteen ja tasapainoreaktioihin liittyvien ilmiöiden tutkiminen kokeellisesti sekä ilmiöiden mallintaminen ja analysointi graafisesti tietokonesovelluksella	upperSecondarySchoolContentsNew	\N	6833566	\N
194	educationalSubject	1	Biologia	upperSecondarySchoolSubjectsOld	\N	BI	\N
84	educationalSubject	12	Suomen kieli ja kirjallisuus	upperSecondarySchoolSubjectsNew	\N	6828951	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6828810/lops2019/oppiaineet/6828951
85	educationalSubject	12	Tekstien tulkinta ja kirjoittaminen	upperSecondarySchoolModulesNew	\N	6829040	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6828810/lops2019/oppiaineet/6828951/moduulit/6829040
86	teaches	12	osaa tuottaa, tulkita ja arvioida erilaisia, monimuotoisia tekstejä ja niiden rakenteita ja ilmaisutapoja	upperSecondarySchoolObjectivesNew	\N	6829036	\N
87	teaches	12	tekstien moniäänisyys ja intertekstuaalisuus	upperSecondarySchoolContentsNew	\N	6829073	\N
195	educationalSubject	1	Biologian sovellukset	upperSecondarySchoolCoursesOld	\N	BI5	\N
196	educationalSubject	1	Ekologia ja ympäristö	upperSecondarySchoolCoursesOld	\N	BI2	\N
242	educationalSubject	18	Kemia	upperSecondarySchoolSubjectsNew	\N	6832793	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6828810/lops2019/oppiaineet/6832793
243	educationalSubject	18	Filosofia	upperSecondarySchoolSubjectsNew	\N	6832794	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6828810/lops2019/oppiaineet/6832794
244	educationalSubject	18	Elämänkatsomustieto	upperSecondarySchoolSubjectsNew	\N	6834385	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6828810/lops2019/oppiaineet/6834385
245	educationalSubject	18	Kemia ja minä	upperSecondarySchoolModulesNew	\N	6833236	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6828810/lops2019/oppiaineet/6832793/moduulit/6833236
246	educationalSubject	18	Totuus	upperSecondarySchoolModulesNew	\N	6833505	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6828810/lops2019/oppiaineet/6832794/moduulit/6833505
247	educationalSubject	18	Minä ja hyvä elämä	upperSecondarySchoolModulesNew	\N	6834841	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/6828810/lops2019/oppiaineet/6834385/moduulit/6834841
248	teaches	18	saa kokemuksia, jotka herättävät ja syventävät kiinnostusta kemiaa ja sen opiskelua kohtaan, ja tutustuu kemian alan ammatteihin ja jatko-opintomahdollisuuksiin	upperSecondarySchoolObjectivesNew	\N	6833420	\N
249	teaches	18	osaa erottaa mielipiteet tosiasiaväittämistä ja ymmärtää tarpeen perustella tosiasiaväittämät	upperSecondarySchoolObjectivesNew	\N	6833633	\N
250	teaches	18	ymmärtää hyvän elämän pohtimiseen liittyvät keskeiset käsitteet ja osaa käyttää niitä oman elämänkatsomuksensa jäsentämisessä	upperSecondarySchoolObjectivesNew	\N	6834880	\N
251	teaches	18	minuus, elämänkatsomus, maailmankatsomus ja maailmankuva	upperSecondarySchoolContentsNew	\N	6834886	\N
252	teaches	18	arjen aineiden turvallisuuden arviointi ja kemian merkitys omassa elämässä	upperSecondarySchoolContentsNew	\N	6833427	\N
253	teaches	18	kieli, merkitys ja totuus	upperSecondarySchoolContentsNew	\N	6833639	\N
254	teaches	18	selittäminen, ennustaminen, ymmärtäminen ja tulkinta erilaisissa tieteissä	upperSecondarySchoolContentsNew	\N	6833645	\N
143	educationalSubject	14	Suomi saamenkielisille	basicStudySubjects	\N	692139	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/oppiaineet/692139
144	teaches	14	L1 Ajattelu ja oppimaan oppiminen	basicStudyContents	\N	428670	https://virkailija.opintopolku.fi/eperusteet-service/api/perusteet/419550/perusopetus/laajaalaisetosaamiset/428670
\.


--
-- Data for Name: collectioneducationalaudience; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.collectioneducationalaudience (id, educationalrole, collectionid, educationalrolekey) FROM stdin;
7	Förälder	3	3305e3b0-ade9-408e-95b0-672a1dd51acf
26	Asiantuntija tai ammattilainen	12	66edb65b-8648-4f95-ac48-d9478293cef4
27	Opettaja	12	9f3904bf-a09d-4dfd-bf46-15ae225b8941
49	Professional	14	66edb65b-8648-4f95-ac48-d9478293cef4
50	Peer Tutor	14	7765381f-c316-49a1-869f-de6043115d4d
53	Ohjaaja tai mentori	5	f732bbb6-6496-4f72-8dda-3917145003f4
54	Vertaistutor	5	7765381f-c316-49a1-869f-de6043115d4d
55	Asiantuntija tai ammattilainen	11	66edb65b-8648-4f95-ac48-d9478293cef4
56	Ohjaaja tai mentori	11	f732bbb6-6496-4f72-8dda-3917145003f4
57	General Public	4	2b7915eb-4df7-467e-a841-b0201b80dc9d
63	Erityisopetus	1	42e63a64-75f2-49e7-8692-4494ae8e4bfe
64	Kansalainen	1	2b7915eb-4df7-467e-a841-b0201b80dc9d
65	Ohjaaja tai mentori	23	f732bbb6-6496-4f72-8dda-3917145003f4
70	Kansalainen	18	2b7915eb-4df7-467e-a841-b0201b80dc9d
71	Erityisopetus	25	42e63a64-75f2-49e7-8692-4494ae8e4bfe
73	Asiantuntija tai ammattilainen	26	66edb65b-8648-4f95-ac48-d9478293cef4
76	Erityisopetus	2	42e63a64-75f2-49e7-8692-4494ae8e4bfe
77	Kansalainen	2	2b7915eb-4df7-467e-a841-b0201b80dc9d
\.


--
-- Data for Name: collectioneducationallevel; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.collectioneducationallevel (id, educationallevelkey, collectionid, value) FROM stdin;
9	8cb1a02f-54cb-499a-b470-4ee980519707	3	grundläggande utbildning
25	94f79e1e-10e6-483d-b651-27521f94f7bf	12	lukiokoulutus
43	75e8bed1-b965-483d-8ba4-48a5614c69ba	14	basic education grades 5-6
46	94f79e1e-10e6-483d-b651-27521f94f7bf	5	lukiokoulutus
47	010c6689-5021-4d8e-8c02-68a27cc5a87b	11	ammatillinen koulutus
48	8e7b8440-286d-4cc9-ad99-9fe288107535	4	early childhood education
49	3ff553ba-a4d7-407c-ad00-80e54ecebd16	4	pre-primary education
55	94f79e1e-10e6-483d-b651-27521f94f7bf	1	lukiokoulutus
56	94f79e1e-10e6-483d-b651-27521f94f7bf	23	lukiokoulutus
57	010c6689-5021-4d8e-8c02-68a27cc5a87b	23	ammatillinen koulutus
64	94f79e1e-10e6-483d-b651-27521f94f7bf	18	lukiokoulutus
65	e5a48ada-3de0-4246-9b8f-32d4ff68e22f	25	korkeakoulutus
67	8e7b8440-286d-4cc9-ad99-9fe288107535	26	varhaiskasvatus
72	8cb1a02f-54cb-499a-b470-4ee980519707	2	perusopetus
73	8e7b8440-286d-4cc9-ad99-9fe288107535	2	varhaiskasvatus
74	94f79e1e-10e6-483d-b651-27521f94f7bf	2	lukiokoulutus
75	010c6689-5021-4d8e-8c02-68a27cc5a87b	2	ammatillinen koulutus
\.


--
-- Data for Name: collectioneducationalmaterial; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.collectioneducationalmaterial (collectionid, educationalmaterialid, priority) FROM stdin;
6	207	0
8	207	0
6	265	0
6	266	0
10	241	0
13	142	0
6	245	0
8	241	0
15	200	0
20	247	0
20	246	0
22	267	0
24	356	999
18	271	1
18	208	2
18	189	3
18	245	5
18	285	6
3	200	2
18	168	999
18	306	999
14	368	999
25	364	0
15	207	0
26	127	1
26	171	2
26	246	3
26	110	4
26	365	5
26	247	6
26	366	7
26	220	8
26	351	10
26	356	11
26	364	12
12	306	1
12	108	2
12	168	3
12	142	4
12	220	5
26	378	999
26	245	999
26	168	999
26	177	999
26	381	999
26	382	999
14	249	1
2	300	0
2	303	3
2	306	5
2	233	6
5	306	1
5	168	2
5	108	3
5	230	5
5	220	6
5	233	7
5	249	8
5	260	9
5	247	11
11	111	2
11	207	5
4	290	1
4	312	3
5	349	999
5	345	999
11	286	999
1	215	0
1	291	0
1	207	0
23	356	999
\.


--
-- Data for Name: collectioneducationaluse; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.collectioneducationaluse (id, educationalusekey, collectionid, value) FROM stdin;
6	7c6c5151-3155-4a7d-a8c2-033e249ccee2	3	Modul
25	69125b8d-8b43-4820-838e-daf145672c17	12	Ohjeistus
46	8643ab6e-8443-4ef8-b2d2-0c4440c0a671	14	Assessment
47	7c6c5151-3155-4a7d-a8c2-033e249ccee2	14	Modul
50	7c6c5151-3155-4a7d-a8c2-033e249ccee2	5	Oppimiskokonaisuuden osa
51	69125b8d-8b43-4820-838e-daf145672c17	5	Ohjeistus
52	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8	11	Itsenäinen opiskelu
53	69125b8d-8b43-4820-838e-daf145672c17	11	Ohjeistus
54	8643ab6e-8443-4ef8-b2d2-0c4440c0a671	4	Assessment
60	80135e90-e23d-40e7-b375-7bc9871ed284	1	Interaktiivinen materiaali
61	b197309a-8194-4669-ad9d-f90f58368e5d	1	Jatkotyöstettävä materiaali
62	b197309a-8194-4669-ad9d-f90f58368e5d	23	Jatkotyöstettävä materiaali
67	80135e90-e23d-40e7-b375-7bc9871ed284	18	Interaktiivinen materiaali
68	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8	25	Itsenäinen opiskelu
70	8643ab6e-8443-4ef8-b2d2-0c4440c0a671	26	Arviointi
73	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8	2	Itsenäinen opiskelu
74	b197309a-8194-4669-ad9d-f90f58368e5d	2	Jatkotyöstettävä materiaali
\.


--
-- Data for Name: collectionheading; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.collectionheading (id, heading, description, priority, collectionid) FROM stdin;
9	Rubriken 1	Någonting	0	3
10	Rubriken 2	Någonting annat	1	3
32	Avointen oppimateriaalien tekeminen	Tämä osio opastaa avointen oppimateriaalien tekemiseen. Se antaa tietoa avoimesta lisensoinnista, avoimista tiedostomuodoista ja avoimen materiaalin remiksauksesta.	0	12
52	A heading	and some text	0	14
57	Avointen oppimateriaalien tekeminen	Li Europan lingues es membres del sam familie. Lor separat existentie es un myth. Por scientie, musica, sport etc, litot Europa usa li sam vocabular. Li lingues differe solmen in li grammatica, li pronunciation e li plu commun vocabules. 	0	5
58	Toinen väliotsikko	Li Europan lingues es membres del sam familie. Lor separat existentie es un myth. Por scientie, musica, sport etc, litot Europa usa li sam vocabular. Li lingues differe solmen in li grammatica, li pronunciation e li plu commun vocabules. Omnicos directe al desirabilite de un nov lingua franca: On refusa continuar payar custosi traductores. At solmen va esser necessi far uniform grammatica, pronunciation e plu sommun paroles. Ma quande lingues coalesce, li grammatica del resultant lingue es plu simplic e regulari quam ti del coalescent lingues. Li nov lingua franca va esser plu simplic e regulari quam li existent Europan lingues. It va esser tam simplic quam Occidental in fact, it va esser Occidental. A un Angleso it va semblar un simplificat Angles, quam un skeptic Cambridge amico dit me que Occidental es.Li Europan lingues es membres del sam familie. Lor separat existentie es un myth. Por scientie, musica, sport etc, litot Europa usa li sam vocabular. Li lingues differe solmen in li grammatica, li pronunciation e li plu commun vocabules. Omnicos directe al desirabilite de un nov lingua franca: On refusa continuar payar custosi traductores. At solmen va esser necessi far uniform grammatica, pronunciation e plu sommun paroles.	4	5
59	Kolmas otsikko - lopetus	Viimeisessä osiossa palaamme alun teemoihin ja vedämme langat yhteen. Osan tarkoituksena on kehittää tiedon muistiinjäämistä ja antaa kokoelman lukijoille työkaluja osaamisensa testaamiseen ja todentamiseen.	10	5
60	Perusteet	Tässä ovat perusteista perusteimmat - turvallisuuden ABC	0	11
61	Testi	dadasda	1	11
62	Syventävät	\N	3	11
63	ja toinen heti perään	\N	4	11
64	dasda	dadasda	0	4
65	gfgdfgdfgdf	dasda	2	4
72	Kokeilemisen pakollisuudesta	Tässä kerron kaikkea mahdollista kokeilmiseeen, testaamiseen ja elämään liittyen ja selkeytän niiden eroja.	0	18
73	Monipuoliset tiedostomuodot	Tässä kerrataan testaamiseen soveltuvien materiaalien löytämisen haasteita tuomalla esille erilaisia testimateriaaleja.	4	18
74	Demokratiakasvatus	\N	1	25
77	PDF:ksi konvertoitavat materiaalit	\N	0	26
78	PDF:t	valmiksii pdfiä	9	26
82	H2 otsikko	Ei suoraan liity tiettyyn materiaaliin	1	2
83	Väliotsikko alla olevalle materiaalille	Mahdollisesti jotain tekstiä	2	2
84	Testi k	DKSAdkasod	4	2
\.


--
-- Data for Name: collectionkeyword; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.collectionkeyword (id, value, collectionid, keywordkey) FROM stdin;
153	3D-skannerit	23	//www.yso.fi/onto/yso/p37987
18	åderlåtning	3	//www.yso.fi/onto/yso/p27654
19	adiponektin	3	//www.yso.fi/onto/yso/p23953
20	adhesion	3	//www.yso.fi/onto/yso/p6154
170	testaus	18	//www.yso.fi/onto/yso/p8471
171	tetrakloorieteeni	18	//www.yso.fi/onto/yso/p18461
172	tex mex -musiikki	18	//www.yso.fi/onto/yso/p30046
173	demokratia	25	//www.yso.fi/onto/yso/p742
174	demokratiakasvatus	25	demokratiakasvatus
178	testaus	26	//www.yso.fi/onto/yso/p8471
179	testausmenetelmät	26	//www.yso.fi/onto/yso/p26360
180	PDF	26	//www.yso.fi/onto/yso/p12371
122	accident prevention	14	//www.yso.fi/onto/yso/p14545
123	zoologists	14	//www.yso.fi/onto/yso/p17398
124	Zoroastrianism	14	//www.yso.fi/onto/yso/p15570
127	moniosaaminen	5	//www.yso.fi/onto/yso/p20632
128	osaamisen kehittäminen	5	//www.yso.fi/onto/yso/p38391
129	ajoitus (suunnittelu)	5	//www.yso.fi/onto/yso/p28184
130	tarahumarat	5	//www.yso.fi/onto/yso/p23947
131	värähtelyt	5	//www.yso.fi/onto/yso/p708
194	abstraktit pelit	2	//www.yso.fi/onto/yso/p28697
132	majakanvartijat	11	//www.yso.fi/onto/yso/p24874
133	merivartijat	11	//www.yso.fi/onto/yso/p27373
134	vartijat	11	//www.yso.fi/onto/yso/p18181
135	vartiointi	11	//www.yso.fi/onto/yso/p20430
136	vartioveneet	11	//www.yso.fi/onto/yso/p24892
137	äänikasetit	4	//www.yso.fi/onto/yso/p12688
138	aapasuot	4	//www.yso.fi/onto/yso/p17093
66	ohjeet	12	//www.yso.fi/onto/yso/p9583
67	käyttöohjeet	12	//www.yso.fi/onto/yso/p13834
68	kokoelmat	12	//www.yso.fi/onto/yso/p12676
195	absurdismi	2	//www.yso.fi/onto/yso/p17642
196	Adobe Bridge	2	//www.yso.fi/onto/yso/p23494
197	AdWords	2	//www.yso.fi/onto/yso/p21140
150	3D-elokuvat	1	//www.yso.fi/onto/yso/p25476
151	3D-mallinnus	1	//www.yso.fi/onto/yso/p26739
198	affiksit	2	//www.yso.fi/onto/yso/p2836
199	afrikkalainen sikarutto	2	//www.yso.fi/onto/yso/p28462
200	agenttiteoria	2	//www.yso.fi/onto/yso/p23547
201	2-dieetti	2	//www.yso.fi/onto/yso/p27439
202	3D-elokuvat	2	//www.yso.fi/onto/yso/p25476
203	3D-mallinnus	2	//www.yso.fi/onto/yso/p26739
204	3D-skannerit	2	//www.yso.fi/onto/yso/p37987
205	3D-tulostimet	2	//www.yso.fi/onto/yso/p37917
206	3D Studio MAX	2	//www.yso.fi/onto/yso/p16103
152	3D-tulostimet	1	//www.yso.fi/onto/yso/p37917
\.


--
-- Data for Name: collectionlanguage; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.collectionlanguage (id, language, collectionid) FROM stdin;
12	sv	3
26	fi	12
27	sv	12
42	en	14
47	fi	5
48	fi	11
49	fi	4
54	fi	1
55	af	23
62	fi	18
63	en	18
64	fi	25
66	fi	26
69	fi	2
70	en	2
\.


--
-- Data for Name: collectionthumbnail; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.collectionthumbnail (id, filepath, mimetype, filename, obsoleted, filekey, filebucket, collectionid) FROM stdin;
2	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1597738784593.png	image/png	thumbnail1597738784593.png	1	thumbnail1597738784593.png	aoethumbnailtest	5
3	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1597738820252.png	image/png	thumbnail1597738820252.png	1	thumbnail1597738820252.png	aoethumbnailtest	5
4	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1597738845936.png	image/png	thumbnail1597738845936.png	0	thumbnail1597738845936.png	aoethumbnailtest	5
1	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1597663555561.png	image/png	thumbnail1597663555561.png	1	thumbnail1597663555561.png	aoethumbnailtest	2
6	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1597740178362.png	image/png	thumbnail1597740178362.png	0	thumbnail1597740178362.png	aoethumbnailtest	4
5	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1597739213660.png	image/png	thumbnail1597739213660.png	1	thumbnail1597739213660.png	aoethumbnailtest	2
7	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1597743992487.png	image/png	thumbnail1597743992487.png	1	thumbnail1597743992487.png	aoethumbnailtest	2
8	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1597750487117.png	image/png	thumbnail1597750487117.png	0	thumbnail1597750487117.png	aoethumbnailtest	2
9	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1597750754822.png	image/png	thumbnail1597750754822.png	0	thumbnail1597750754822.png	aoethumbnailtest	11
10	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1597751115807.png	image/png	thumbnail1597751115807.png	0	thumbnail1597751115807.png	aoethumbnailtest	14
\.


--
-- Data for Name: educationalaudience; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.educationalaudience (id, educationalrole, educationalmaterialid, educationalrolekey) FROM stdin;
1	Erityisopetus	1	42e63a64-75f2-49e7-8692-4494ae8e4bfe
2	Opettaja	2	9f3904bf-a09d-4dfd-bf46-15ae225b8941
3	Erityisopetus	4	42e63a64-75f2-49e7-8692-4494ae8e4bfe
4	Opettaja	7	9f3904bf-a09d-4dfd-bf46-15ae225b8941
5	Oppija	7	582949cb-36a4-4053-9f2f-c53ae954a6ae
6	Opettaja	8	9f3904bf-a09d-4dfd-bf46-15ae225b8941
7	Asiantuntija tai ammattilainen	8	66edb65b-8648-4f95-ac48-d9478293cef4
8	Opettaja	12	9f3904bf-a09d-4dfd-bf46-15ae225b8941
9	Ohjaaja tai mentori	12	f732bbb6-6496-4f72-8dda-3917145003f4
10	Asiantuntija tai ammattilainen	12	66edb65b-8648-4f95-ac48-d9478293cef4
11	Opetuksen ja kasvatuksen johtaja	12	84dfd485-15bb-4688-bf5f-3bd1cbff31ec
12	Opettaja	13	9f3904bf-a09d-4dfd-bf46-15ae225b8941
13	Asiantuntija tai ammattilainen	13	66edb65b-8648-4f95-ac48-d9478293cef4
14	Ohjaaja tai mentori	13	f732bbb6-6496-4f72-8dda-3917145003f4
15	Opetuksen ja kasvatuksen johtaja	13	84dfd485-15bb-4688-bf5f-3bd1cbff31ec
16	Asiantuntija tai ammattilainen	14	66edb65b-8648-4f95-ac48-d9478293cef4
17	Opettaja	14	9f3904bf-a09d-4dfd-bf46-15ae225b8941
18	Ohjaaja tai mentori	14	f732bbb6-6496-4f72-8dda-3917145003f4
19	Opetuksen ja kasvatuksen johtaja	14	84dfd485-15bb-4688-bf5f-3bd1cbff31ec
20	Opettaja	18	9f3904bf-a09d-4dfd-bf46-15ae225b8941
21	Asiantuntija tai ammattilainen	18	66edb65b-8648-4f95-ac48-d9478293cef4
22	Opetuksen ja kasvatuksen johtaja	18	84dfd485-15bb-4688-bf5f-3bd1cbff31ec
23	Opettaja	19	9f3904bf-a09d-4dfd-bf46-15ae225b8941
24	Opettaja	20	9f3904bf-a09d-4dfd-bf46-15ae225b8941
25	Huoltaja	23	3305e3b0-ade9-408e-95b0-672a1dd51acf
26	Kansalainen	23	2b7915eb-4df7-467e-a841-b0201b80dc9d
27	Asiantuntija tai ammattilainen	24	66edb65b-8648-4f95-ac48-d9478293cef4
28	Opettaja	24	9f3904bf-a09d-4dfd-bf46-15ae225b8941
29	Oppija	24	582949cb-36a4-4053-9f2f-c53ae954a6ae
30	Opettaja	43	9f3904bf-a09d-4dfd-bf46-15ae225b8941
31	Asiantuntija tai ammattilainen	43	66edb65b-8648-4f95-ac48-d9478293cef4
32	Opettaja	44	9f3904bf-a09d-4dfd-bf46-15ae225b8941
33	Oppija	44	582949cb-36a4-4053-9f2f-c53ae954a6ae
35	Erityisopetus	52	42e63a64-75f2-49e7-8692-4494ae8e4bfe
39	Oppija	16	582949cb-36a4-4053-9f2f-c53ae954a6ae
42	Opettaja	56	9f3904bf-a09d-4dfd-bf46-15ae225b8941
43	Opettaja	57	9f3904bf-a09d-4dfd-bf46-15ae225b8941
44	Oppija	54	582949cb-36a4-4053-9f2f-c53ae954a6ae
45	Asiantuntija tai ammattilainen	59	66edb65b-8648-4f95-ac48-d9478293cef4
46	Ohjaaja tai mentori	61	f732bbb6-6496-4f72-8dda-3917145003f4
47	Opettaja	61	9f3904bf-a09d-4dfd-bf46-15ae225b8941
48	Asiantuntija tai ammattilainen	61	66edb65b-8648-4f95-ac48-d9478293cef4
49	Kansalainen	67	2b7915eb-4df7-467e-a841-b0201b80dc9d
56	Opettaja	73	9f3904bf-a09d-4dfd-bf46-15ae225b8941
57	Erityisopetus	74	42e63a64-75f2-49e7-8692-4494ae8e4bfe
58	Ohjaaja tai mentori	75	f732bbb6-6496-4f72-8dda-3917145003f4
59	Opettaja	76	9f3904bf-a09d-4dfd-bf46-15ae225b8941
60	Asiantuntija tai ammattilainen	76	66edb65b-8648-4f95-ac48-d9478293cef4
61	Ohjaaja tai mentori	76	f732bbb6-6496-4f72-8dda-3917145003f4
62	Asiantuntija tai ammattilainen	77	66edb65b-8648-4f95-ac48-d9478293cef4
63	Opettaja	77	9f3904bf-a09d-4dfd-bf46-15ae225b8941
64	Kansalainen	78	2b7915eb-4df7-467e-a841-b0201b80dc9d
65	Opettaja	78	9f3904bf-a09d-4dfd-bf46-15ae225b8941
66	Erityisopetus	81	42e63a64-75f2-49e7-8692-4494ae8e4bfe
67	Huoltaja	97	3305e3b0-ade9-408e-95b0-672a1dd51acf
68	Asiantuntija tai ammattilainen	99	66edb65b-8648-4f95-ac48-d9478293cef4
69	Erityisopetus	100	42e63a64-75f2-49e7-8692-4494ae8e4bfe
70	Kansalainen	101	2b7915eb-4df7-467e-a841-b0201b80dc9d
71	Opettaja	103	9f3904bf-a09d-4dfd-bf46-15ae225b8941
72	Asiantuntija tai ammattilainen	107	66edb65b-8648-4f95-ac48-d9478293cef4
73	Opettaja	108	9f3904bf-a09d-4dfd-bf46-15ae225b8941
74	Kansalainen	110	2b7915eb-4df7-467e-a841-b0201b80dc9d
75	Erityisopetus	111	42e63a64-75f2-49e7-8692-4494ae8e4bfe
76	Asiantuntija tai ammattilainen	112	66edb65b-8648-4f95-ac48-d9478293cef4
77	Erityisopetus	117	42e63a64-75f2-49e7-8692-4494ae8e4bfe
78	General Public	118	2b7915eb-4df7-467e-a841-b0201b80dc9d
79	Asiantuntija tai ammattilainen	123	66edb65b-8648-4f95-ac48-d9478293cef4
80	Asiantuntija tai ammattilainen	127	66edb65b-8648-4f95-ac48-d9478293cef4
81	Asiantuntija tai ammattilainen	128	66edb65b-8648-4f95-ac48-d9478293cef4
82	Erityisopetus	128	42e63a64-75f2-49e7-8692-4494ae8e4bfe
83	Asiantuntija tai ammattilainen	132	66edb65b-8648-4f95-ac48-d9478293cef4
84	Oppija	137	582949cb-36a4-4053-9f2f-c53ae954a6ae
85	Opettaja	142	9f3904bf-a09d-4dfd-bf46-15ae225b8941
86	Opettaja	143	9f3904bf-a09d-4dfd-bf46-15ae225b8941
88	Oppija	160	582949cb-36a4-4053-9f2f-c53ae954a6ae
89	Opettaja	168	9f3904bf-a09d-4dfd-bf46-15ae225b8941
90	Asiantuntija tai ammattilainen	168	66edb65b-8648-4f95-ac48-d9478293cef4
91	Professional	176	66edb65b-8648-4f95-ac48-d9478293cef4
95	Opettaja	183	9f3904bf-a09d-4dfd-bf46-15ae225b8941
96	Asiantuntija tai ammattilainen	183	66edb65b-8648-4f95-ac48-d9478293cef4
97	Ohjaaja tai mentori	184	f732bbb6-6496-4f72-8dda-3917145003f4
98	Erityisopetus	189	42e63a64-75f2-49e7-8692-4494ae8e4bfe
99	Kansalainen	193	2b7915eb-4df7-467e-a841-b0201b80dc9d
100	Vertaistutor	193	7765381f-c316-49a1-869f-de6043115d4d
105	Erityisopetus	202	42e63a64-75f2-49e7-8692-4494ae8e4bfe
106	Huoltaja	202	3305e3b0-ade9-408e-95b0-672a1dd51acf
113	Kansalainen	216	2b7915eb-4df7-467e-a841-b0201b80dc9d
114	Vertaistutor	216	7765381f-c316-49a1-869f-de6043115d4d
119	Erityisopetus	222	42e63a64-75f2-49e7-8692-4494ae8e4bfe
120	Erityisopetus	223	42e63a64-75f2-49e7-8692-4494ae8e4bfe
121	Allmänheten	224	2b7915eb-4df7-467e-a841-b0201b80dc9d
127	Erityisopetus	235	42e63a64-75f2-49e7-8692-4494ae8e4bfe
87	Opettaja	144	9f3904bf-a09d-4dfd-bf46-15ae225b8941
263	Kansalainen	200	2b7915eb-4df7-467e-a841-b0201b80dc9d
320	Kansalainen	268	2b7915eb-4df7-467e-a841-b0201b80dc9d
148	Huoltaja	144	3305e3b0-ade9-408e-95b0-672a1dd51acf
149	Kansalainen	144	2b7915eb-4df7-467e-a841-b0201b80dc9d
115	Ohjaaja tai mentori	217	f732bbb6-6496-4f72-8dda-3917145003f4
116	Huoltaja	217	3305e3b0-ade9-408e-95b0-672a1dd51acf
211	Ohjaaja tai mentori	249	f732bbb6-6496-4f72-8dda-3917145003f4
112	Ohjaaja tai mentori	215	f732bbb6-6496-4f72-8dda-3917145003f4
122	Erityisopetus	230	42e63a64-75f2-49e7-8692-4494ae8e4bfe
205	Ohjaaja tai mentori	246	f732bbb6-6496-4f72-8dda-3917145003f4
201	Opettaja	239	9f3904bf-a09d-4dfd-bf46-15ae225b8941
92	Opettaja	177	9f3904bf-a09d-4dfd-bf46-15ae225b8941
191	Kansalainen	241	2b7915eb-4df7-467e-a841-b0201b80dc9d
274	Opettaja	267	9f3904bf-a09d-4dfd-bf46-15ae225b8941
111	Vertaistutor	207	7765381f-c316-49a1-869f-de6043115d4d
214	Kansalainen	260	2b7915eb-4df7-467e-a841-b0201b80dc9d
215	Ohjaaja tai mentori	260	f732bbb6-6496-4f72-8dda-3917145003f4
123	Asiantuntija tai ammattilainen	231	66edb65b-8648-4f95-ac48-d9478293cef4
124	Kansalainen	231	2b7915eb-4df7-467e-a841-b0201b80dc9d
202	Kansalainen	245	2b7915eb-4df7-467e-a841-b0201b80dc9d
94	Erityisopetus	178	42e63a64-75f2-49e7-8692-4494ae8e4bfe
335	General Public	257	2b7915eb-4df7-467e-a841-b0201b80dc9d
216	Opettaja	260	9f3904bf-a09d-4dfd-bf46-15ae225b8941
316	Erityisopetus	249	42e63a64-75f2-49e7-8692-4494ae8e4bfe
308	Opetuksen ja kasvatuksen johtaja	207	84dfd485-15bb-4688-bf5f-3bd1cbff31ec
110	Oppija	207	582949cb-36a4-4053-9f2f-c53ae954a6ae
270	Erityisopetus	264	42e63a64-75f2-49e7-8692-4494ae8e4bfe
271	Ohjaaja tai mentori	265	f732bbb6-6496-4f72-8dda-3917145003f4
272	Opettaja	265	9f3904bf-a09d-4dfd-bf46-15ae225b8941
273	Erityisopetus	265	42e63a64-75f2-49e7-8692-4494ae8e4bfe
107	Kansalainen	203	2b7915eb-4df7-467e-a841-b0201b80dc9d
108	Vertaistutor	203	7765381f-c316-49a1-869f-de6043115d4d
109	Opetuksen ja kasvatuksen johtaja	203	84dfd485-15bb-4688-bf5f-3bd1cbff31ec
321	Huoltaja	261	3305e3b0-ade9-408e-95b0-672a1dd51acf
126	Opettaja	234	9f3904bf-a09d-4dfd-bf46-15ae225b8941
125	Asiantuntija tai ammattilainen	234	66edb65b-8648-4f95-ac48-d9478293cef4
209	Ohjaaja tai mentori	247	f732bbb6-6496-4f72-8dda-3917145003f4
323	Opettaja	233	9f3904bf-a09d-4dfd-bf46-15ae225b8941
324	Kansalainen	269	2b7915eb-4df7-467e-a841-b0201b80dc9d
319	General Public	214	2b7915eb-4df7-467e-a841-b0201b80dc9d
326	Asiantuntija tai ammattilainen	270	66edb65b-8648-4f95-ac48-d9478293cef4
336	Opettaja	276	9f3904bf-a09d-4dfd-bf46-15ae225b8941
275	Oppija	267	582949cb-36a4-4053-9f2f-c53ae954a6ae
210	Opettaja	247	9f3904bf-a09d-4dfd-bf46-15ae225b8941
340	Oppija	177	582949cb-36a4-4053-9f2f-c53ae954a6ae
344	Opettaja	284	9f3904bf-a09d-4dfd-bf46-15ae225b8941
345	Oppija	284	582949cb-36a4-4053-9f2f-c53ae954a6ae
346	Kansalainen	277	2b7915eb-4df7-467e-a841-b0201b80dc9d
348	Opettaja	285	9f3904bf-a09d-4dfd-bf46-15ae225b8941
349	Oppija	285	582949cb-36a4-4053-9f2f-c53ae954a6ae
350	Asiantuntija tai ammattilainen	286	66edb65b-8648-4f95-ac48-d9478293cef4
351	Ohjaaja tai mentori	287	f732bbb6-6496-4f72-8dda-3917145003f4
352	Opettaja	287	9f3904bf-a09d-4dfd-bf46-15ae225b8941
357	Erityisopetus	293	42e63a64-75f2-49e7-8692-4494ae8e4bfe
371	Erityisopetus	296	42e63a64-75f2-49e7-8692-4494ae8e4bfe
372	Huoltaja	296	3305e3b0-ade9-408e-95b0-672a1dd51acf
373	Kansalainen	296	2b7915eb-4df7-467e-a841-b0201b80dc9d
276	Asiantuntija tai ammattilainen	267	66edb65b-8648-4f95-ac48-d9478293cef4
334	Huoltaja	271	3305e3b0-ade9-408e-95b0-672a1dd51acf
117	Erityisopetus	220	42e63a64-75f2-49e7-8692-4494ae8e4bfe
353	Asiantuntija tai ammattilainen	288	66edb65b-8648-4f95-ac48-d9478293cef4
381	Förälder	279	3305e3b0-ade9-408e-95b0-672a1dd51acf
382	Opettaja	294	9f3904bf-a09d-4dfd-bf46-15ae225b8941
383	Erityisopetus	297	42e63a64-75f2-49e7-8692-4494ae8e4bfe
391	Asiantuntija tai ammattilainen	302	66edb65b-8648-4f95-ac48-d9478293cef4
337	Opettaja	282	9f3904bf-a09d-4dfd-bf46-15ae225b8941
398	Opettaja	317	9f3904bf-a09d-4dfd-bf46-15ae225b8941
399	Opettaja	318	9f3904bf-a09d-4dfd-bf46-15ae225b8941
534	Ohjaaja tai mentori	378	f732bbb6-6496-4f72-8dda-3917145003f4
426	Kansalainen	348	2b7915eb-4df7-467e-a841-b0201b80dc9d
555	Huoltaja	391	3305e3b0-ade9-408e-95b0-672a1dd51acf
569	Asiantuntija tai ammattilainen	394	66edb65b-8648-4f95-ac48-d9478293cef4
414	Erityisopetus	337	42e63a64-75f2-49e7-8692-4494ae8e4bfe
415	Oppija	338	582949cb-36a4-4053-9f2f-c53ae954a6ae
416	Ohjaaja tai mentori	339	f732bbb6-6496-4f72-8dda-3917145003f4
417	Oppija	339	582949cb-36a4-4053-9f2f-c53ae954a6ae
418	Kansalainen	340	2b7915eb-4df7-467e-a841-b0201b80dc9d
419	Kansalainen	341	2b7915eb-4df7-467e-a841-b0201b80dc9d
420	Ohjaaja tai mentori	342	f732bbb6-6496-4f72-8dda-3917145003f4
421	Ohjaaja tai mentori	343	f732bbb6-6496-4f72-8dda-3917145003f4
422	Ohjaaja tai mentori	344	f732bbb6-6496-4f72-8dda-3917145003f4
423	Kansalainen	345	2b7915eb-4df7-467e-a841-b0201b80dc9d
424	Ohjaaja tai mentori	346	f732bbb6-6496-4f72-8dda-3917145003f4
425	Huoltaja	347	3305e3b0-ade9-408e-95b0-672a1dd51acf
428	Erityisopetus	350	42e63a64-75f2-49e7-8692-4494ae8e4bfe
502	Oppija	368	582949cb-36a4-4053-9f2f-c53ae954a6ae
469	Asiantuntija tai ammattilainen	358	66edb65b-8648-4f95-ac48-d9478293cef4
503	Opettaja	368	9f3904bf-a09d-4dfd-bf46-15ae225b8941
504	Asiantuntija tai ammattilainen	368	66edb65b-8648-4f95-ac48-d9478293cef4
397	Elev	313	582949cb-36a4-4053-9f2f-c53ae954a6ae
480	Erityisopetus	360	42e63a64-75f2-49e7-8692-4494ae8e4bfe
481	Asiantuntija tai ammattilainen	361	66edb65b-8648-4f95-ac48-d9478293cef4
429	Kansalainen	316	2b7915eb-4df7-467e-a841-b0201b80dc9d
433	Ohjaaja tai mentori	316	f732bbb6-6496-4f72-8dda-3917145003f4
537	Asiantuntija tai ammattilainen	382	66edb65b-8648-4f95-ac48-d9478293cef4
495	Kansalainen	366	2b7915eb-4df7-467e-a841-b0201b80dc9d
586	Kansalainen	399	2b7915eb-4df7-467e-a841-b0201b80dc9d
588	Kansalainen	400	2b7915eb-4df7-467e-a841-b0201b80dc9d
589	Erityisopetus	401	42e63a64-75f2-49e7-8692-4494ae8e4bfe
541	Asiantuntija tai ammattilainen	310	66edb65b-8648-4f95-ac48-d9478293cef4
535	Kansalainen	380	2b7915eb-4df7-467e-a841-b0201b80dc9d
483	Opettaja	364	9f3904bf-a09d-4dfd-bf46-15ae225b8941
390	Kansalainen	303	2b7915eb-4df7-467e-a841-b0201b80dc9d
516	Huoltaja	369	3305e3b0-ade9-408e-95b0-672a1dd51acf
494	Asiantuntija tai ammattilainen	365	66edb65b-8648-4f95-ac48-d9478293cef4
404	Kansalainen	327	2b7915eb-4df7-467e-a841-b0201b80dc9d
393	Erityisopetus	312	42e63a64-75f2-49e7-8692-4494ae8e4bfe
394	Ohjaaja tai mentori	312	f732bbb6-6496-4f72-8dda-3917145003f4
460	Asiantuntija tai ammattilainen	355	66edb65b-8648-4f95-ac48-d9478293cef4
496	Huoltaja	367	3305e3b0-ade9-408e-95b0-672a1dd51acf
529	Erityisopetus	370	42e63a64-75f2-49e7-8692-4494ae8e4bfe
530	Kansalainen	370	2b7915eb-4df7-467e-a841-b0201b80dc9d
442	Ohjaaja tai mentori	351	f732bbb6-6496-4f72-8dda-3917145003f4
482	Oppija	362	582949cb-36a4-4053-9f2f-c53ae954a6ae
384	Asiantuntija tai ammattilainen	306	66edb65b-8648-4f95-ac48-d9478293cef4
605	Opettaja	406	9f3904bf-a09d-4dfd-bf46-15ae225b8941
551	Ohjaaja tai mentori	385	f732bbb6-6496-4f72-8dda-3917145003f4
461	Huoltaja	356	3305e3b0-ade9-408e-95b0-672a1dd51acf
462	Kansalainen	356	2b7915eb-4df7-467e-a841-b0201b80dc9d
554	Asiantuntija tai ammattilainen	390	66edb65b-8648-4f95-ac48-d9478293cef4
562	Kansalainen	393	2b7915eb-4df7-467e-a841-b0201b80dc9d
536	Asiantuntija tai ammattilainen	381	66edb65b-8648-4f95-ac48-d9478293cef4
427	Erityisopetus	349	42e63a64-75f2-49e7-8692-4494ae8e4bfe
575	Asiantuntija tai ammattilainen	309	66edb65b-8648-4f95-ac48-d9478293cef4
571	Opettaja	396	9f3904bf-a09d-4dfd-bf46-15ae225b8941
585	Huoltaja	396	3305e3b0-ade9-408e-95b0-672a1dd51acf
597	Opettaja	402	9f3904bf-a09d-4dfd-bf46-15ae225b8941
563	Kansalainen	395	2b7915eb-4df7-467e-a841-b0201b80dc9d
598	Oppija	402	582949cb-36a4-4053-9f2f-c53ae954a6ae
601	Kansalainen	403	2b7915eb-4df7-467e-a841-b0201b80dc9d
602	Asiantuntija tai ammattilainen	403	66edb65b-8648-4f95-ac48-d9478293cef4
603	Kansalainen	404	2b7915eb-4df7-467e-a841-b0201b80dc9d
604	Opettaja	405	9f3904bf-a09d-4dfd-bf46-15ae225b8941
606	Opettaja	407	9f3904bf-a09d-4dfd-bf46-15ae225b8941
607	Opettaja	408	9f3904bf-a09d-4dfd-bf46-15ae225b8941
608	Huoltaja	409	3305e3b0-ade9-408e-95b0-672a1dd51acf
609	Erityisopetus	251	42e63a64-75f2-49e7-8692-4494ae8e4bfe
610	Huoltaja	359	3305e3b0-ade9-408e-95b0-672a1dd51acf
443	Kansalainen	354	2b7915eb-4df7-467e-a841-b0201b80dc9d
613	Kansalainen	410	2b7915eb-4df7-467e-a841-b0201b80dc9d
385	Opettaja	306	9f3904bf-a09d-4dfd-bf46-15ae225b8941
625	Opettaja	420	9f3904bf-a09d-4dfd-bf46-15ae225b8941
\.


--
-- Data for Name: educationallevel; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.educationallevel (id, value, educationalmaterialid, educationallevelkey) FROM stdin;
1	varhaiskasvatus	1	8e7b8440-286d-4cc9-ad99-9fe288107535
2	lukiokoulutus	2	94f79e1e-10e6-483d-b651-27521f94f7bf
3	lukiokoulutus	4	94f79e1e-10e6-483d-b651-27521f94f7bf
4	omaehtoinen osaamisen kehittäminen	7	bc25d0e7-3c68-49a1-9329-239dae01fab7
5	lukiokoulutus	7	94f79e1e-10e6-483d-b651-27521f94f7bf
6	perusopetus	7	8cb1a02f-54cb-499a-b470-4ee980519707
7	ammatillinen koulutus	7	010c6689-5021-4d8e-8c02-68a27cc5a87b
8	korkeakoulutus	7	e5a48ada-3de0-4246-9b8f-32d4ff68e22f
9	lukiokoulutus	8	94f79e1e-10e6-483d-b651-27521f94f7bf
10	ammatillinen koulutus	8	010c6689-5021-4d8e-8c02-68a27cc5a87b
11	korkeakoulutus	8	e5a48ada-3de0-4246-9b8f-32d4ff68e22f
12	omaehtoinen osaamisen kehittäminen	8	bc25d0e7-3c68-49a1-9329-239dae01fab7
13	korkeakoulutus	12	e5a48ada-3de0-4246-9b8f-32d4ff68e22f
14	omaehtoinen osaamisen kehittäminen	12	bc25d0e7-3c68-49a1-9329-239dae01fab7
15	ammatillinen koulutus	12	010c6689-5021-4d8e-8c02-68a27cc5a87b
16	lukiokoulutus	12	94f79e1e-10e6-483d-b651-27521f94f7bf
17	lukiokoulutus	13	94f79e1e-10e6-483d-b651-27521f94f7bf
18	ammatillinen koulutus	13	010c6689-5021-4d8e-8c02-68a27cc5a87b
19	korkeakoulutus	13	e5a48ada-3de0-4246-9b8f-32d4ff68e22f
20	omaehtoinen osaamisen kehittäminen	13	bc25d0e7-3c68-49a1-9329-239dae01fab7
21	lukiokoulutus	14	94f79e1e-10e6-483d-b651-27521f94f7bf
22	ammatillinen koulutus	14	010c6689-5021-4d8e-8c02-68a27cc5a87b
23	omaehtoinen osaamisen kehittäminen	14	bc25d0e7-3c68-49a1-9329-239dae01fab7
24	korkeakoulutus	14	e5a48ada-3de0-4246-9b8f-32d4ff68e22f
25	lukiokoulutus	18	94f79e1e-10e6-483d-b651-27521f94f7bf
26	ammatillinen koulutus	18	010c6689-5021-4d8e-8c02-68a27cc5a87b
27	omaehtoinen osaamisen kehittäminen	18	bc25d0e7-3c68-49a1-9329-239dae01fab7
28	korkeakoulutus	18	e5a48ada-3de0-4246-9b8f-32d4ff68e22f
29	lukiokoulutus	19	94f79e1e-10e6-483d-b651-27521f94f7bf
30	lukiokoulutus	20	94f79e1e-10e6-483d-b651-27521f94f7bf
31	ammatillinen koulutus	20	010c6689-5021-4d8e-8c02-68a27cc5a87b
32	varhaiskasvatus	23	8e7b8440-286d-4cc9-ad99-9fe288107535
33	perusopetus	23	8cb1a02f-54cb-499a-b470-4ee980519707
34	lukiokoulutus	24	94f79e1e-10e6-483d-b651-27521f94f7bf
35	ammatillinen koulutus	24	010c6689-5021-4d8e-8c02-68a27cc5a87b
36	korkeakoulutus	24	e5a48ada-3de0-4246-9b8f-32d4ff68e22f
37	korkeakoulutus	43	e5a48ada-3de0-4246-9b8f-32d4ff68e22f
38	ammatillinen koulutus	44	010c6689-5021-4d8e-8c02-68a27cc5a87b
39	lukiokoulutus	52	94f79e1e-10e6-483d-b651-27521f94f7bf
40	korkeakoulutus	16	e5a48ada-3de0-4246-9b8f-32d4ff68e22f
41	lukiokoulutus	56	94f79e1e-10e6-483d-b651-27521f94f7bf
42	korkeakoulutus	56	e5a48ada-3de0-4246-9b8f-32d4ff68e22f
43	lukiokoulutus	57	94f79e1e-10e6-483d-b651-27521f94f7bf
44	lukiokoulutus	54	94f79e1e-10e6-483d-b651-27521f94f7bf
45	korkeakoulutus	54	e5a48ada-3de0-4246-9b8f-32d4ff68e22f
46	omaehtoinen osaamisen kehittäminen	59	bc25d0e7-3c68-49a1-9329-239dae01fab7
47	perusopetus	61	8cb1a02f-54cb-499a-b470-4ee980519707
48	ammatillinen koulutus	61	010c6689-5021-4d8e-8c02-68a27cc5a87b
49	lukiokoulutus	61	94f79e1e-10e6-483d-b651-27521f94f7bf
50	korkeakoulutus	61	e5a48ada-3de0-4246-9b8f-32d4ff68e22f
51	perusopetus	67	8cb1a02f-54cb-499a-b470-4ee980519707
52	perusopetus	73	8cb1a02f-54cb-499a-b470-4ee980519707
53	varhaiskasvatus	74	8e7b8440-286d-4cc9-ad99-9fe288107535
54	esiopetus	75	3ff553ba-a4d7-407c-ad00-80e54ecebd16
55	lukiokoulutus	76	94f79e1e-10e6-483d-b651-27521f94f7bf
56	ammatillinen koulutus	76	010c6689-5021-4d8e-8c02-68a27cc5a87b
57	korkeakoulutus	76	e5a48ada-3de0-4246-9b8f-32d4ff68e22f
58	omaehtoinen osaamisen kehittäminen	76	bc25d0e7-3c68-49a1-9329-239dae01fab7
59	omaehtoinen osaamisen kehittäminen	77	bc25d0e7-3c68-49a1-9329-239dae01fab7
60	korkeakoulutus	77	e5a48ada-3de0-4246-9b8f-32d4ff68e22f
61	lukiokoulutus	78	94f79e1e-10e6-483d-b651-27521f94f7bf
62	ammatillinen koulutus	81	010c6689-5021-4d8e-8c02-68a27cc5a87b
63	varhaiskasvatus	97	8e7b8440-286d-4cc9-ad99-9fe288107535
64	varhaiskasvatus	99	8e7b8440-286d-4cc9-ad99-9fe288107535
65	esiopetus	100	3ff553ba-a4d7-407c-ad00-80e54ecebd16
66	ammatillinen koulutus	101	010c6689-5021-4d8e-8c02-68a27cc5a87b
67	lukiokoulutus	103	94f79e1e-10e6-483d-b651-27521f94f7bf
68	perusopetus	103	8cb1a02f-54cb-499a-b470-4ee980519707
69	varhaiskasvatus	107	8e7b8440-286d-4cc9-ad99-9fe288107535
70	perusopetus	108	8cb1a02f-54cb-499a-b470-4ee980519707
71	lukiokoulutus	108	94f79e1e-10e6-483d-b651-27521f94f7bf
72	korkeakoulutus	108	e5a48ada-3de0-4246-9b8f-32d4ff68e22f
73	perusopetuksen vuosiluokat 7-9	110	a2a70a14-b150-4f37-9e20-2bbb71731807
74	varhaiskasvatus	111	8e7b8440-286d-4cc9-ad99-9fe288107535
75	esiopetus	111	3ff553ba-a4d7-407c-ad00-80e54ecebd16
76	perusopetus	111	8cb1a02f-54cb-499a-b470-4ee980519707
77	lukiokoulutus	111	94f79e1e-10e6-483d-b651-27521f94f7bf
78	ammatillinen koulutus	111	010c6689-5021-4d8e-8c02-68a27cc5a87b
79	omaehtoinen osaamisen kehittäminen	111	bc25d0e7-3c68-49a1-9329-239dae01fab7
80	korkeakoulutus	111	e5a48ada-3de0-4246-9b8f-32d4ff68e22f
81	varhaiskasvatus	112	8e7b8440-286d-4cc9-ad99-9fe288107535
82	perusopetus	117	8cb1a02f-54cb-499a-b470-4ee980519707
83	self-motivated competence development	118	bc25d0e7-3c68-49a1-9329-239dae01fab7
84	omaehtoinen osaamisen kehittäminen	123	bc25d0e7-3c68-49a1-9329-239dae01fab7
85	lukiokoulutus	127	94f79e1e-10e6-483d-b651-27521f94f7bf
86	perusopetus	128	8cb1a02f-54cb-499a-b470-4ee980519707
87	lukiokoulutus	128	94f79e1e-10e6-483d-b651-27521f94f7bf
88	varhaiskasvatus	132	8e7b8440-286d-4cc9-ad99-9fe288107535
89	perusopetus	137	8cb1a02f-54cb-499a-b470-4ee980519707
90	varhaiskasvatus	138	8e7b8440-286d-4cc9-ad99-9fe288107535
91	ammatillinen koulutus	139	010c6689-5021-4d8e-8c02-68a27cc5a87b
92	varhaiskasvatus	140	8e7b8440-286d-4cc9-ad99-9fe288107535
93	varhaiskasvatus	141	8e7b8440-286d-4cc9-ad99-9fe288107535
94	omaehtoinen osaamisen kehittäminen	142	bc25d0e7-3c68-49a1-9329-239dae01fab7
95	omaehtoinen osaamisen kehittäminen	143	bc25d0e7-3c68-49a1-9329-239dae01fab7
96	perusopetus	144	8cb1a02f-54cb-499a-b470-4ee980519707
97	omaehtoinen osaamisen kehittäminen	144	bc25d0e7-3c68-49a1-9329-239dae01fab7
98	ammatillinen koulutus	160	010c6689-5021-4d8e-8c02-68a27cc5a87b
99	alemman korkeakouluasteen tutkinto	160	ff3334db-2a71-4459-8f0d-c42ce2b12a70
100	esiopetus	165	3ff553ba-a4d7-407c-ad00-80e54ecebd16
101	ammatillinen koulutus	168	010c6689-5021-4d8e-8c02-68a27cc5a87b
102	lukiokoulutus	168	94f79e1e-10e6-483d-b651-27521f94f7bf
103	omaehtoinen osaamisen kehittäminen	168	bc25d0e7-3c68-49a1-9329-239dae01fab7
104	varhaiskasvatus	171	8e7b8440-286d-4cc9-ad99-9fe288107535
105	varhaiskasvatus	174	8e7b8440-286d-4cc9-ad99-9fe288107535
106	esiopetus	175	3ff553ba-a4d7-407c-ad00-80e54ecebd16
107	higher education	176	e5a48ada-3de0-4246-9b8f-32d4ff68e22f
109	lukiokoulutus	177	94f79e1e-10e6-483d-b651-27521f94f7bf
110	ammatillinen koulutus	177	010c6689-5021-4d8e-8c02-68a27cc5a87b
111	varhaiskasvatus	178	8e7b8440-286d-4cc9-ad99-9fe288107535
112	varhaiskasvatus	182	8e7b8440-286d-4cc9-ad99-9fe288107535
113	perusopetus	183	8cb1a02f-54cb-499a-b470-4ee980519707
114	lukiokoulutus	183	94f79e1e-10e6-483d-b651-27521f94f7bf
115	korkeakoulutus	183	e5a48ada-3de0-4246-9b8f-32d4ff68e22f
116	varhaiskasvatus	184	8e7b8440-286d-4cc9-ad99-9fe288107535
117	perusopetuksen vuosiluokat 5-6	184	75e8bed1-b965-483d-8ba4-48a5614c69ba
118	varhaiskasvatus	189	8e7b8440-286d-4cc9-ad99-9fe288107535
119	varhaiskasvatus	193	8e7b8440-286d-4cc9-ad99-9fe288107535
120	esiopetus	193	3ff553ba-a4d7-407c-ad00-80e54ecebd16
121	perusopetus	193	8cb1a02f-54cb-499a-b470-4ee980519707
122	korkeakoulutus	193	e5a48ada-3de0-4246-9b8f-32d4ff68e22f
123	varhaiskasvatus	202	8e7b8440-286d-4cc9-ad99-9fe288107535
124	perusopetuksen lisäopetus (10-luokka)	202	14fe3b08-8516-4999-946b-96eb90c2d563
125	ammatillinen koulutus	202	010c6689-5021-4d8e-8c02-68a27cc5a87b
126	omaehtoinen osaamisen kehittäminen	202	bc25d0e7-3c68-49a1-9329-239dae01fab7
127	esiopetus	203	3ff553ba-a4d7-407c-ad00-80e54ecebd16
128	omaehtoinen osaamisen kehittäminen	203	bc25d0e7-3c68-49a1-9329-239dae01fab7
129	korkeakoulutus	203	e5a48ada-3de0-4246-9b8f-32d4ff68e22f
130	lukiokoulutus	203	94f79e1e-10e6-483d-b651-27521f94f7bf
131	esiopetus	204	3ff553ba-a4d7-407c-ad00-80e54ecebd16
132	perusopetuksen vuosiluokat 1-2	207	5410475a-a2fb-46d7-9eb4-c572b5d92dbb
133	lukiokoulutus	207	94f79e1e-10e6-483d-b651-27521f94f7bf
134	korkeakoulutus	207	e5a48ada-3de0-4246-9b8f-32d4ff68e22f
135	varhaiskasvatus	208	8e7b8440-286d-4cc9-ad99-9fe288107535
136	perusopetuksen vuosiluokat 5-6	208	75e8bed1-b965-483d-8ba4-48a5614c69ba
137	lukiokoulutus	208	94f79e1e-10e6-483d-b651-27521f94f7bf
138	omaehtoinen osaamisen kehittäminen	208	bc25d0e7-3c68-49a1-9329-239dae01fab7
139	korkeakoulutus	215	e5a48ada-3de0-4246-9b8f-32d4ff68e22f
140	perusopetus	215	8cb1a02f-54cb-499a-b470-4ee980519707
141	lukiokoulutus	215	94f79e1e-10e6-483d-b651-27521f94f7bf
142	ammatillinen koulutus	215	010c6689-5021-4d8e-8c02-68a27cc5a87b
143	perusopetus	216	8cb1a02f-54cb-499a-b470-4ee980519707
144	omaehtoinen osaamisen kehittäminen	216	bc25d0e7-3c68-49a1-9329-239dae01fab7
145	korkeakoulutus	216	e5a48ada-3de0-4246-9b8f-32d4ff68e22f
146	varhaiskasvatus	217	8e7b8440-286d-4cc9-ad99-9fe288107535
147	omaehtoinen osaamisen kehittäminen	217	bc25d0e7-3c68-49a1-9329-239dae01fab7
148	perusopetuksen vuosiluokat 7-9	217	a2a70a14-b150-4f37-9e20-2bbb71731807
149	perusopetus	220	8cb1a02f-54cb-499a-b470-4ee980519707
150	ammatillinen koulutus	220	010c6689-5021-4d8e-8c02-68a27cc5a87b
151	varhaiskasvatus	222	8e7b8440-286d-4cc9-ad99-9fe288107535
152	perusopetus	222	8cb1a02f-54cb-499a-b470-4ee980519707
153	esiopetus	223	3ff553ba-a4d7-407c-ad00-80e54ecebd16
154	småbarnsfostran	224	8e7b8440-286d-4cc9-ad99-9fe288107535
155	perusopetus	230	8cb1a02f-54cb-499a-b470-4ee980519707
156	perusopetus	231	8cb1a02f-54cb-499a-b470-4ee980519707
157	lukiokoulutus	231	94f79e1e-10e6-483d-b651-27521f94f7bf
158	ammatillinen koulutus	231	010c6689-5021-4d8e-8c02-68a27cc5a87b
159	lukiokoulutus	234	94f79e1e-10e6-483d-b651-27521f94f7bf
160	perusopetus	234	8cb1a02f-54cb-499a-b470-4ee980519707
161	korkeakoulutus	234	e5a48ada-3de0-4246-9b8f-32d4ff68e22f
162	perusopetus	235	8cb1a02f-54cb-499a-b470-4ee980519707
163	lukiokoulutus	235	94f79e1e-10e6-483d-b651-27521f94f7bf
177	varhaiskasvatus	220	8e7b8440-286d-4cc9-ad99-9fe288107535
178	esiopetus	220	3ff553ba-a4d7-407c-ad00-80e54ecebd16
179	lukiokoulutus	220	94f79e1e-10e6-483d-b651-27521f94f7bf
180	korkeakoulutus	220	e5a48ada-3de0-4246-9b8f-32d4ff68e22f
181	omaehtoinen osaamisen kehittäminen	220	bc25d0e7-3c68-49a1-9329-239dae01fab7
186	korkeakoulutus	208	e5a48ada-3de0-4246-9b8f-32d4ff68e22f
224	esiopetus	231	3ff553ba-a4d7-407c-ad00-80e54ecebd16
264	korkeakoulutus	178	e5a48ada-3de0-4246-9b8f-32d4ff68e22f
297	korkeakoulutus	241	e5a48ada-3de0-4246-9b8f-32d4ff68e22f
304	perusopetus	239	8cb1a02f-54cb-499a-b470-4ee980519707
305	varhaiskasvatus	243	8e7b8440-286d-4cc9-ad99-9fe288107535
306	omaehtoinen osaamisen kehittäminen	245	bc25d0e7-3c68-49a1-9329-239dae01fab7
310	perusopetus	246	8cb1a02f-54cb-499a-b470-4ee980519707
315	perusopetus	247	8cb1a02f-54cb-499a-b470-4ee980519707
316	lukiokoulutus	247	94f79e1e-10e6-483d-b651-27521f94f7bf
317	ammatillinen koulutus	247	010c6689-5021-4d8e-8c02-68a27cc5a87b
319	omaehtoinen osaamisen kehittäminen	249	bc25d0e7-3c68-49a1-9329-239dae01fab7
322	perusopetus	260	8cb1a02f-54cb-499a-b470-4ee980519707
332	varhaiskasvatus	247	8e7b8440-286d-4cc9-ad99-9fe288107535
370	esiopetus	261	3ff553ba-a4d7-407c-ad00-80e54ecebd16
372	perusopetuksen vuosiluokat 7-9	200	a2a70a14-b150-4f37-9e20-2bbb71731807
373	lukiokoulutus	200	94f79e1e-10e6-483d-b651-27521f94f7bf
404	varhaiskasvatus	264	8e7b8440-286d-4cc9-ad99-9fe288107535
405	korkeakoulutus	265	e5a48ada-3de0-4246-9b8f-32d4ff68e22f
406	varhaiskasvatus	266	8e7b8440-286d-4cc9-ad99-9fe288107535
407	perusopetus	267	8cb1a02f-54cb-499a-b470-4ee980519707
408	lukiokoulutus	267	94f79e1e-10e6-483d-b651-27521f94f7bf
409	omaehtoinen osaamisen kehittäminen	267	bc25d0e7-3c68-49a1-9329-239dae01fab7
410	alemman korkeakouluasteen tutkinto	267	ff3334db-2a71-4459-8f0d-c42ce2b12a70
465	pre-primary education	214	3ff553ba-a4d7-407c-ad00-80e54ecebd16
466	varhaiskasvatus	268	8e7b8440-286d-4cc9-ad99-9fe288107535
468	perusopetus	263	8cb1a02f-54cb-499a-b470-4ee980519707
470	perusopetus	233	8cb1a02f-54cb-499a-b470-4ee980519707
471	esiopetus	269	3ff553ba-a4d7-407c-ad00-80e54ecebd16
472	varhaiskasvatus	269	8e7b8440-286d-4cc9-ad99-9fe288107535
473	varhaiskasvatus	259	8e7b8440-286d-4cc9-ad99-9fe288107535
474	perusopetus	258	8cb1a02f-54cb-499a-b470-4ee980519707
476	omaehtoinen osaamisen kehittäminen	228	bc25d0e7-3c68-49a1-9329-239dae01fab7
478	esiopetus	270	3ff553ba-a4d7-407c-ad00-80e54ecebd16
489	perusopetus	271	8cb1a02f-54cb-499a-b470-4ee980519707
490	upper secondary school	257	94f79e1e-10e6-483d-b651-27521f94f7bf
491	perusopetus	276	8cb1a02f-54cb-499a-b470-4ee980519707
492	perusopetus	282	8cb1a02f-54cb-499a-b470-4ee980519707
499	lukiokoulutus	284	94f79e1e-10e6-483d-b651-27521f94f7bf
500	ammatillinen koulutus	284	010c6689-5021-4d8e-8c02-68a27cc5a87b
501	esiopetus	277	3ff553ba-a4d7-407c-ad00-80e54ecebd16
503	perusopetus	285	8cb1a02f-54cb-499a-b470-4ee980519707
504	lukiokoulutus	285	94f79e1e-10e6-483d-b651-27521f94f7bf
505	ammatillinen koulutus	285	010c6689-5021-4d8e-8c02-68a27cc5a87b
506	omaehtoinen osaamisen kehittäminen	285	bc25d0e7-3c68-49a1-9329-239dae01fab7
507	korkeakoulutus	285	e5a48ada-3de0-4246-9b8f-32d4ff68e22f
508	varhaiskasvatus	286	8e7b8440-286d-4cc9-ad99-9fe288107535
509	korkeakoulutus	287	e5a48ada-3de0-4246-9b8f-32d4ff68e22f
510	perusopetus	288	8cb1a02f-54cb-499a-b470-4ee980519707
511	varhaiskasvatus	291	8e7b8440-286d-4cc9-ad99-9fe288107535
515	ammatillinen koulutus	293	010c6689-5021-4d8e-8c02-68a27cc5a87b
516	korkeakoulutus	275	e5a48ada-3de0-4246-9b8f-32d4ff68e22f
518	työhön ja itsenäiseen elämään valmentava koulutus, TELMA	169	da5b8f43-5fc9-4681-812b-40846926f3fd
543	perusopetus	296	8cb1a02f-54cb-499a-b470-4ee980519707
556	omaehtoinen osaamisen kehittäminen	279	bc25d0e7-3c68-49a1-9329-239dae01fab7
557	perusopetus	294	8cb1a02f-54cb-499a-b470-4ee980519707
558	perusopetuksen lisäopetus (10-luokka)	297	14fe3b08-8516-4999-946b-96eb90c2d563
559	perusopetus	304	8cb1a02f-54cb-499a-b470-4ee980519707
560	omaehtoinen osaamisen kehittäminen	306	bc25d0e7-3c68-49a1-9329-239dae01fab7
563	perusopetus	303	8cb1a02f-54cb-499a-b470-4ee980519707
564	varhaiskasvatus	300	8e7b8440-286d-4cc9-ad99-9fe288107535
565	varhaiskasvatus	302	8e7b8440-286d-4cc9-ad99-9fe288107535
567	perusopetus	301	8cb1a02f-54cb-499a-b470-4ee980519707
568	perusopetuksen vuosiluokat 3-4	312	7eb3d5be-0575-44db-ab8a-883cf0ae2f26
570	yrkesutbildning	313	010c6689-5021-4d8e-8c02-68a27cc5a87b
571	esiopetus	314	3ff553ba-a4d7-407c-ad00-80e54ecebd16
572	perusopetus	315	8cb1a02f-54cb-499a-b470-4ee980519707
573	esiopetus	316	3ff553ba-a4d7-407c-ad00-80e54ecebd16
574	lukiokoulutus	317	94f79e1e-10e6-483d-b651-27521f94f7bf
575	perusopetus	318	8cb1a02f-54cb-499a-b470-4ee980519707
580	lukiokoulutus	327	94f79e1e-10e6-483d-b651-27521f94f7bf
586	varhaiskasvatus	290	8e7b8440-286d-4cc9-ad99-9fe288107535
589	perusopetus	337	8cb1a02f-54cb-499a-b470-4ee980519707
590	omaehtoinen osaamisen kehittäminen	338	bc25d0e7-3c68-49a1-9329-239dae01fab7
591	perusopetuksen vuosiluokat 7-9	339	a2a70a14-b150-4f37-9e20-2bbb71731807
592	lukiokoulutus	339	94f79e1e-10e6-483d-b651-27521f94f7bf
593	varhaiskasvatus	340	8e7b8440-286d-4cc9-ad99-9fe288107535
594	esiopetus	341	3ff553ba-a4d7-407c-ad00-80e54ecebd16
595	perusopetuksen vuosiluokat 7-9	342	a2a70a14-b150-4f37-9e20-2bbb71731807
596	ammatilliseen koulutukseen valmentava koulutus, VALMA	342	55c5d6a2-8415-47bc-9d15-7b976b0e999c
597	työhön ja itsenäiseen elämään valmentava koulutus, TELMA	343	da5b8f43-5fc9-4681-812b-40846926f3fd
598	perusopetuksen vuosiluokat 7-9	344	a2a70a14-b150-4f37-9e20-2bbb71731807
599	lukiokoulutukseen valmistava koulutus, LUVA	344	fd362a80-9662-48b8-acd1-d8cef520530c
600	perusopetuksen vuosiluokat 5-6	345	75e8bed1-b965-483d-8ba4-48a5614c69ba
601	perusopetuksen vuosiluokat 5-6	346	75e8bed1-b965-483d-8ba4-48a5614c69ba
602	lukiokoulutus	347	94f79e1e-10e6-483d-b651-27521f94f7bf
603	varhaiskasvatus	348	8e7b8440-286d-4cc9-ad99-9fe288107535
604	omaehtoinen osaamisen kehittäminen	349	bc25d0e7-3c68-49a1-9329-239dae01fab7
605	perusopetuksen vuosiluokat 1-2	350	5410475a-a2fb-46d7-9eb4-c572b5d92dbb
612	lukiokoulutus	351	94f79e1e-10e6-483d-b651-27521f94f7bf
615	lukiokoulutus	316	94f79e1e-10e6-483d-b651-27521f94f7bf
631	varhaiskasvatus	355	8e7b8440-286d-4cc9-ad99-9fe288107535
632	ammatillinen koulutus	356	010c6689-5021-4d8e-8c02-68a27cc5a87b
638	omaehtoinen osaamisen kehittäminen	358	bc25d0e7-3c68-49a1-9329-239dae01fab7
641	perusopetus	356	8cb1a02f-54cb-499a-b470-4ee980519707
649	varhaiskasvatus	360	8e7b8440-286d-4cc9-ad99-9fe288107535
650	perusopetus	360	8cb1a02f-54cb-499a-b470-4ee980519707
651	ammatillinen koulutus	361	010c6689-5021-4d8e-8c02-68a27cc5a87b
652	omaehtoinen osaamisen kehittäminen	361	bc25d0e7-3c68-49a1-9329-239dae01fab7
653	perusopetuksen vuosiluokat 7-9	362	a2a70a14-b150-4f37-9e20-2bbb71731807
654	lukiokoulutus	362	94f79e1e-10e6-483d-b651-27521f94f7bf
655	ammatillinen koulutus	362	010c6689-5021-4d8e-8c02-68a27cc5a87b
656	perusopetus	363	8cb1a02f-54cb-499a-b470-4ee980519707
657	lukiokoulutus	363	94f79e1e-10e6-483d-b651-27521f94f7bf
658	ammatillinen koulutus	363	010c6689-5021-4d8e-8c02-68a27cc5a87b
659	perusopetus	364	8cb1a02f-54cb-499a-b470-4ee980519707
668	varhaiskasvatus	356	8e7b8440-286d-4cc9-ad99-9fe288107535
672	esiopetus	356	3ff553ba-a4d7-407c-ad00-80e54ecebd16
673	omaehtoinen osaamisen kehittäminen	365	bc25d0e7-3c68-49a1-9329-239dae01fab7
674	varhaiskasvatus	366	8e7b8440-286d-4cc9-ad99-9fe288107535
675	esiopetus	366	3ff553ba-a4d7-407c-ad00-80e54ecebd16
676	korkeakoulutus	367	e5a48ada-3de0-4246-9b8f-32d4ff68e22f
686	korkeakoulutus	368	e5a48ada-3de0-4246-9b8f-32d4ff68e22f
687	omaehtoinen osaamisen kehittäminen	368	bc25d0e7-3c68-49a1-9329-239dae01fab7
701	omaehtoinen osaamisen kehittäminen	369	bc25d0e7-3c68-49a1-9329-239dae01fab7
714	omaehtoinen osaamisen kehittäminen	356	bc25d0e7-3c68-49a1-9329-239dae01fab7
715	korkeakoulutus	356	e5a48ada-3de0-4246-9b8f-32d4ff68e22f
732	varhaiskasvatus	370	8e7b8440-286d-4cc9-ad99-9fe288107535
733	perusopetus	370	8cb1a02f-54cb-499a-b470-4ee980519707
738	perusopetus	378	8cb1a02f-54cb-499a-b470-4ee980519707
739	varhaiskasvatus	380	8e7b8440-286d-4cc9-ad99-9fe288107535
740	omaehtoinen osaamisen kehittäminen	381	bc25d0e7-3c68-49a1-9329-239dae01fab7
741	omaehtoinen osaamisen kehittäminen	382	bc25d0e7-3c68-49a1-9329-239dae01fab7
750	esiopetus	310	3ff553ba-a4d7-407c-ad00-80e54ecebd16
751	perusopetuksen vuosiluokat 3-4	310	7eb3d5be-0575-44db-ab8a-883cf0ae2f26
752	lukiokoulutus	310	94f79e1e-10e6-483d-b651-27521f94f7bf
753	omaehtoinen osaamisen kehittäminen	310	bc25d0e7-3c68-49a1-9329-239dae01fab7
759	perusopetuksen vuosiluokat 1-2	380	5410475a-a2fb-46d7-9eb4-c572b5d92dbb
767	varhaiskasvatus	385	8e7b8440-286d-4cc9-ad99-9fe288107535
774	varhaiskasvatus	390	8e7b8440-286d-4cc9-ad99-9fe288107535
775	esiopetus	390	3ff553ba-a4d7-407c-ad00-80e54ecebd16
776	korkeakoulutus	391	e5a48ada-3de0-4246-9b8f-32d4ff68e22f
777	ammatillinen koulutus	354	010c6689-5021-4d8e-8c02-68a27cc5a87b
778	ammatillinen koulutus	392	010c6689-5021-4d8e-8c02-68a27cc5a87b
780	ammatillinen koulutus	355	010c6689-5021-4d8e-8c02-68a27cc5a87b
783	perusopetus	355	8cb1a02f-54cb-499a-b470-4ee980519707
784	korkeakoulutus	355	e5a48ada-3de0-4246-9b8f-32d4ff68e22f
794	omaehtoinen osaamisen kehittäminen	393	bc25d0e7-3c68-49a1-9329-239dae01fab7
795	omaehtoinen osaamisen kehittäminen	395	bc25d0e7-3c68-49a1-9329-239dae01fab7
797	varhaiskasvatus	349	8e7b8440-286d-4cc9-ad99-9fe288107535
799	varhaiskasvatus	395	8e7b8440-286d-4cc9-ad99-9fe288107535
806	varhaiskasvatus	394	8e7b8440-286d-4cc9-ad99-9fe288107535
808	ammatillinen koulutus	396	010c6689-5021-4d8e-8c02-68a27cc5a87b
812	varhaiskasvatus	309	8e7b8440-286d-4cc9-ad99-9fe288107535
822	varhaiskasvatus	399	8e7b8440-286d-4cc9-ad99-9fe288107535
824	varhaiskasvatus	400	8e7b8440-286d-4cc9-ad99-9fe288107535
825	korkeakoulutus	401	e5a48ada-3de0-4246-9b8f-32d4ff68e22f
826	perusopetus	292	8cb1a02f-54cb-499a-b470-4ee980519707
834	varhaiskasvatus	402	8e7b8440-286d-4cc9-ad99-9fe288107535
835	esiopetus	402	3ff553ba-a4d7-407c-ad00-80e54ecebd16
838	omaehtoinen osaamisen kehittäminen	403	bc25d0e7-3c68-49a1-9329-239dae01fab7
839	omaehtoinen osaamisen kehittäminen	404	bc25d0e7-3c68-49a1-9329-239dae01fab7
840	korkeakoulutus	405	e5a48ada-3de0-4246-9b8f-32d4ff68e22f
841	lukiokoulutus	405	94f79e1e-10e6-483d-b651-27521f94f7bf
842	omaehtoinen osaamisen kehittäminen	406	bc25d0e7-3c68-49a1-9329-239dae01fab7
843	omaehtoinen osaamisen kehittäminen	407	bc25d0e7-3c68-49a1-9329-239dae01fab7
844	omaehtoinen osaamisen kehittäminen	408	bc25d0e7-3c68-49a1-9329-239dae01fab7
845	omaehtoinen osaamisen kehittäminen	409	bc25d0e7-3c68-49a1-9329-239dae01fab7
846	perusopetus	251	8cb1a02f-54cb-499a-b470-4ee980519707
847	varhaiskasvatus	359	8e7b8440-286d-4cc9-ad99-9fe288107535
850	varhaiskasvatus	410	8e7b8440-286d-4cc9-ad99-9fe288107535
860	lukiokoulutukseen valmistava koulutus, LUVA	420	fd362a80-9662-48b8-acd1-d8cef520530c
861	lukiokoulutus	420	94f79e1e-10e6-483d-b651-27521f94f7bf
\.


--
-- Data for Name: educationallevelextension; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.educationallevelextension (id, value, educationallevelkey, educationalmaterialid, usersusername) FROM stdin;
3	perusopetus	8cb1a02f-54cb-499a-b470-4ee980519707	275	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD
4	varhaiskasvatus	8e7b8440-286d-4cc9-ad99-9fe288107535	275	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD
6	perusopetuksen lisäopetus (10-luokka)	14fe3b08-8516-4999-946b-96eb90c2d563	351	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0
7	vocational education	010c6689-5021-4d8e-8c02-68a27cc5a87b	306	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0
8	self-motivated competence development	bc25d0e7-3c68-49a1-9329-239dae01fab7	306	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0
9	perusopetus	8cb1a02f-54cb-499a-b470-4ee980519707	306	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD
\.


--
-- Data for Name: educationalmaterial; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.educationalmaterial (id, createdat, publishedat, updatedat, archivedat, timerequired, agerangemin, agerangemax, licensecode, obsoleted, originalpublishedat, usersusername, expires, suitsallearlychildhoodsubjects, suitsallpreprimarysubjects, suitsallbasicstudysubjects, suitsalluppersecondarysubjects, suitsallvocationaldegrees, suitsallselfmotivatedsubjects, suitsallbranches, suitsalluppersecondarysubjectsnew, ratingcontentaverage, ratingvisualaverage, viewcounter, downloadcounter, counterupdatedat) FROM stdin;
2	2019-11-01 06:31:25.766269+00	\N	2019-11-01 08:06:00.547+00	9999-01-01 00:00:00+00		-1	-1	CCBY4.0	0	2019-11-01 06:31:25.766269+00	maija.mehilainen@aoe.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
4	2019-11-01 12:41:45.97115+00	\N	2019-11-01 12:42:31.406+00	9999-01-01 00:00:00+00		-1	-1	CCBY4.0	0	2019-11-01 12:41:45.97115+00	maija.mehilainen@aoe.fi	2019-11-30 12:41:19+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
5	2019-11-01 13:29:41.868489+00	\N	2019-11-01 13:29:41.868489+00	9999-01-01 00:00:00+00		-1	-1		0	2019-11-01 13:29:41.868489+00	maija.mehilainen@aoe.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
8	2019-11-05 08:25:52.988466+00	\N	2019-11-05 08:33:30.328+00	9999-01-01 00:00:00+00	27 h	18	-1	CCBY4.0	0	2019-11-05 08:25:52.988466+00	maija.mehilainen@aoe.fi	9999-01-01 00:00:00+00	f	f	f	t	t	t	f	f	\N	\N	0	0	\N
9	2019-11-05 10:06:12.250655+00	\N	2019-11-05 10:06:12.250655+00	9999-01-01 00:00:00+00		-1	-1		0	2019-11-05 10:06:12.250655+00	maija.mehilainen@aoe.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
13	2019-11-05 10:58:16.142223+00	\N	2019-11-05 11:03:23.256+00	9999-01-01 00:00:00+00		18	-1	CCBY4.0	0	2019-11-05 10:58:16.142223+00	maija.mehilainen@aoe.fi	9999-01-01 00:00:00+00	f	f	f	t	t	f	f	f	\N	\N	0	0	\N
14	2019-11-05 11:11:57.541652+00	\N	2019-11-05 11:19:07.395+00	9999-01-01 00:00:00+00		18	-1	CCBY4.0	0	2019-11-05 11:11:57.541652+00	maija.mehilainen@aoe.fi	9999-01-01 00:00:00+00	f	f	f	t	t	f	f	f	\N	\N	0	0	\N
15	2019-11-08 10:41:43.807819+00	\N	2019-11-08 10:41:43.807819+00	9999-01-01 00:00:00+00		-1	-1		0	2019-11-08 10:41:43.807819+00	maija.mehilainen@aoe.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
19	2019-11-12 12:54:51.728563+00	\N	2019-11-12 12:57:40.409+00	9999-01-01 00:00:00+00		-1	-1	CCBY4.0	0	2019-11-12 12:54:51.728563+00	maija.mehilainen@aoe.fi	9999-01-01 00:00:00+00	f	f	f	t	f	f	f	f	\N	\N	0	0	\N
20	2019-11-12 12:59:45.685698+00	\N	2019-11-12 13:02:58.146+00	9999-01-01 00:00:00+00		-1	-1	CCBY4.0	0	2019-11-12 12:59:45.685698+00	maija.mehilainen@aoe.fi	9999-01-01 00:00:00+00	f	f	f	t	t	f	f	f	\N	\N	0	0	\N
21	2019-11-13 08:58:20.836407+00	\N	2019-11-13 08:58:20.836407+00	9999-01-01 00:00:00+00		-1	-1		0	2019-11-13 08:58:20.836407+00	maija.mehilainen@aoe.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
24	2019-11-15 09:50:44.233751+00	\N	2019-11-15 09:55:03.52+00	\N	54h	18	-1	CCBY4.0	0	2019-11-15 09:50:44.233751+00	maija.mehilainen@aoe.fi	9999-01-01 00:00:00+00	f	f	f	t	t	f	f	f	\N	\N	0	0	\N
25	2019-11-18 08:02:56.105654+00	\N	2019-11-18 08:02:56.105654+00	\N		-1	-1		0	2019-11-18 08:02:56.105654+00	maija.mehilainen@aoe.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
26	2019-11-18 09:28:37.184384+00	\N	2019-11-18 09:28:37.184384+00	\N		-1	-1		0	2019-11-18 09:28:37.184384+00	maija.mehilainen@aoe.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
27	2019-11-20 11:04:14.978814+00	\N	2019-11-20 11:04:14.978814+00	\N		-1	-1		0	2019-11-20 11:04:14.978814+00	maija.mehilainen@aoe.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
28	2019-11-20 11:04:15.390637+00	\N	2019-11-20 11:04:15.390637+00	\N		-1	-1		0	2019-11-20 11:04:15.390637+00	maija.mehilainen@aoe.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
29	2019-11-20 11:04:15.729726+00	\N	2019-11-20 11:04:15.729726+00	\N		-1	-1		0	2019-11-20 11:04:15.729726+00	maija.mehilainen@aoe.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
30	2019-11-20 11:22:26.178309+00	\N	2019-11-20 11:22:26.178309+00	\N		-1	-1		0	2019-11-20 11:22:26.178309+00	maija.mehilainen@aoe.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
31	2019-11-20 11:22:26.956202+00	\N	2019-11-20 11:22:26.956202+00	\N		-1	-1		0	2019-11-20 11:22:26.956202+00	maija.mehilainen@aoe.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
32	2019-11-20 11:22:27.120644+00	\N	2019-11-20 11:22:27.120644+00	\N		-1	-1		0	2019-11-20 11:22:27.120644+00	maija.mehilainen@aoe.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
33	2019-11-20 11:45:08.12484+00	\N	2019-11-20 11:45:08.12484+00	\N		-1	-1		0	2019-11-20 11:45:08.12484+00	maija.mehilainen@aoe.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
34	2019-11-20 11:45:08.2255+00	\N	2019-11-20 11:45:08.2255+00	\N		-1	-1		0	2019-11-20 11:45:08.2255+00	maija.mehilainen@aoe.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
36	2019-11-20 11:50:14.11576+00	\N	2019-11-20 11:50:14.11576+00	\N		-1	-1		0	2019-11-20 11:50:14.11576+00	maija.mehilainen@aoe.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
37	2019-11-20 11:50:19.440217+00	\N	2019-11-20 11:50:19.440217+00	\N		-1	-1		0	2019-11-20 11:50:19.440217+00	maija.mehilainen@aoe.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
38	2019-11-20 11:53:02.511485+00	\N	2019-11-20 11:53:02.511485+00	\N		-1	-1		0	2019-11-20 11:53:02.511485+00	maija.mehilainen@aoe.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
39	2019-11-20 11:58:49.0879+00	\N	2019-11-20 11:58:49.0879+00	\N		-1	-1		0	2019-11-20 11:58:49.0879+00	maija.mehilainen@aoe.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
40	2019-11-20 12:01:17.04134+00	\N	2019-11-20 12:01:17.04134+00	\N		-1	-1		0	2019-11-20 12:01:17.04134+00	maija.mehilainen@aoe.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
41	2019-11-22 10:16:29.880948+00	\N	2019-11-22 10:16:29.880948+00	\N		-1	-1		0	2019-11-22 10:16:29.880948+00	maija.mehilainen@aoe.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
42	2019-11-22 10:18:24.547242+00	\N	2019-11-22 10:18:24.547242+00	\N		-1	-1		0	2019-11-22 10:18:24.547242+00	maija.mehilainen@aoe.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
43	2019-11-22 11:16:00.506434+00	\N	2019-11-22 11:33:44.493+00	\N		18	-1	CCBY4.0	0	2019-11-22 11:16:00.506434+00	maija.mehilainen@aoe.fi	2022-08-17 09:39:38+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
44	2019-11-22 12:03:50.209033+00	\N	2019-11-22 12:06:31.513+00	\N		-1	-1	CCBY4.0	0	2019-11-22 12:03:50.209033+00	maija.mehilainen@aoe.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
45	2019-11-25 08:25:18.000958+00	\N	2019-11-25 08:25:18.000958+00	\N		-1	-1		0	2019-11-25 08:25:18.000958+00	maija.mehilainen@aoe.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
46	2019-11-26 10:59:24.257097+00	\N	2019-11-26 10:59:24.257097+00	\N		-1	-1		0	2019-11-26 10:59:24.257097+00	maija.mehilainen@aoe.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
47	2019-11-26 11:11:36.166832+00	\N	2019-11-26 11:11:36.166832+00	\N		-1	-1		0	2019-11-26 11:11:36.166832+00	maija.mehilainen@aoe.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
48	2019-11-27 13:33:46.244095+00	\N	2019-11-27 13:33:46.244095+00	\N		-1	-1		0	2019-11-27 13:33:46.244095+00	maija.mehilainen@aoe.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
49	2019-11-27 13:42:32.056628+00	\N	2019-11-27 13:42:32.056628+00	\N		-1	-1		0	2019-11-27 13:42:32.056628+00	maija.mehilainen@aoe.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
50	2019-11-27 13:44:23.750527+00	\N	2019-11-27 13:44:23.750527+00	\N		-1	-1		0	2019-11-27 13:44:23.750527+00	maija.mehilainen@aoe.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
51	2019-11-27 13:48:17.555077+00	\N	2019-11-27 13:48:17.555077+00	\N		-1	-1		0	2019-11-27 13:48:17.555077+00	maija.mehilainen@aoe.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
52	2019-11-27 14:01:36.662521+00	\N	2019-11-27 15:56:13.246+00	\N		-1	-1	CCBY4.0	0	2019-11-27 14:01:36.662521+00	maija.mehilainen@aoe.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
53	2019-11-28 05:41:27.728722+00	\N	2019-11-28 05:41:27.728722+00	\N		-1	-1		0	2019-11-28 05:41:27.728722+00	maija.mehilainen@aoe.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
55	2019-11-28 08:50:07.27998+00	\N	2019-11-28 08:50:07.27998+00	\N		-1	-1		0	2019-11-28 08:50:07.27998+00	maija.mehilainen@aoe.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
56	2019-11-28 12:06:40.99973+00	\N	2019-11-28 12:10:30.368+00	\N		-1	-1	CCBY4.0	0	2019-11-28 12:06:40.99973+00	maija.mehilainen@aoe.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
1	2019-10-31 14:02:19.164864+00	\N	2019-10-31 14:03:22.199+00	9999-01-01 00:00:00+00		0	1	CCBY4.0	0	2019-10-31 14:02:19.164864+00	maija.mehilainen@aoe.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
58	2019-11-28 12:12:43.149035+00	\N	2019-11-28 12:12:43.149035+00	\N		-1	-1		0	2019-11-28 12:12:43.149035+00	maija.mehilainen@aoe.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
57	2019-11-28 12:12:42.848578+00	\N	2019-11-28 12:15:09.832+00	\N		-1	-1	CCBY4.0	0	2019-11-28 12:12:42.848578+00	maija.mehilainen@aoe.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
54	2019-11-28 05:58:14.805867+00	\N	2019-11-28 12:18:56.31+00	\N		-1	-1	CCBY4.0	0	2019-11-28 05:58:14.805867+00	maija.mehilainen@aoe.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
59	2019-11-28 12:18:56.239943+00	\N	2019-11-28 12:20:03.229+00	\N		12	15	CCBY4.0	0	2019-11-28 12:18:56.239943+00	maija.mehilainen@aoe.fi	2019-11-30 12:18:25+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
60	2019-11-28 12:28:15.875457+00	\N	2019-11-28 12:28:15.875457+00	\N		-1	-1		0	2019-11-28 12:28:15.875457+00	maija.mehilainen@aoe.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
61	2019-11-28 12:44:16.64162+00	\N	2019-11-28 12:47:36.072+00	\N		-1	-1	CCBY4.0	0	2019-11-28 12:44:16.64162+00	maija.mehilainen@aoe.fi	9999-01-01 00:00:00+00	f	f	t	t	t	f	t	f	\N	\N	0	0	\N
62	2019-11-28 13:01:02.551794+00	\N	2019-11-28 13:01:02.551794+00	\N		-1	-1		0	2019-11-28 13:01:02.551794+00	maija.mehilainen@aoe.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
16	2019-11-11 09:32:23.071074+00	\N	2019-11-28 05:57:11.932+00	9999-01-01 00:00:00+00		-1	-1	CCBY4.0	0	2019-11-11 09:32:23.071074+00	maija.mehilainen@aoe.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	t	f	\N	\N	0	0	\N
6	2019-11-01 14:38:43.026314+00	\N	2019-11-01 14:38:43.026314+00	9999-01-01 00:00:00+00		-1	-1		0	2019-11-01 14:38:43.026314+00	maija.mehilainen@aoe.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
7	2019-11-05 07:56:18.192379+00	\N	2019-11-05 08:16:11.066+00	9999-01-01 00:00:00+00	8 h	18	-1	CCBY4.0	0	2019-11-05 07:56:18.192379+00	maija.mehilainen@aoe.fi	9999-01-01 00:00:00+00	f	f	t	t	t	t	f	f	\N	\N	0	0	\N
10	2019-11-05 10:19:04.357537+00	\N	2019-11-05 10:19:04.357537+00	9999-01-01 00:00:00+00		-1	-1		0	2019-11-05 10:19:04.357537+00	maija.mehilainen@aoe.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
11	2019-11-05 10:20:35.965126+00	\N	2019-11-05 10:20:35.965126+00	9999-01-01 00:00:00+00		-1	-1		0	2019-11-05 10:20:35.965126+00	maija.mehilainen@aoe.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
12	2019-11-05 10:47:49.799852+00	\N	2019-11-05 10:52:03.272+00	9999-01-01 00:00:00+00		18	-1	CCBY4.0	0	2019-11-05 10:47:49.799852+00	maija.mehilainen@aoe.fi	9999-01-01 00:00:00+00	f	f	f	t	t	f	f	f	\N	\N	0	0	\N
17	2019-11-12 06:38:16.357634+00	\N	2019-11-12 06:38:16.357634+00	9999-01-01 00:00:00+00		-1	-1		0	2019-11-12 06:38:16.357634+00	maija.mehilainen@aoe.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
18	2019-11-12 10:39:11.5233+00	\N	2019-11-12 10:43:00.771+00	9999-01-01 00:00:00+00		18	-1	CCBY4.0	0	2019-11-12 10:39:11.5233+00	maija.mehilainen@aoe.fi	9999-01-01 00:00:00+00	f	f	f	t	t	f	f	f	\N	\N	0	0	\N
22	2019-11-13 09:00:23.86971+00	\N	2019-11-13 09:00:23.86971+00	9999-01-01 00:00:00+00		-1	-1		0	2019-11-13 09:00:23.86971+00	maija.mehilainen@aoe.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
23	2019-11-13 10:08:11.186234+00	\N	2019-11-13 10:15:44.206+00	9999-01-01 00:00:00+00	34 h	1	123	CCBY4.0	0	2019-11-13 10:08:11.186234+00	maija.mehilainen@aoe.fi	2020-12-30 22:00:00+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
63	2019-11-28 13:02:10.080762+00	\N	2019-11-28 13:02:10.080762+00	\N		-1	-1		0	2019-11-28 13:02:10.080762+00	maija.mehilainen@aoe.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
64	2019-11-28 13:02:10.634266+00	\N	2019-11-28 13:02:10.634266+00	\N		-1	-1		0	2019-11-28 13:02:10.634266+00	maija.mehilainen@aoe.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
65	2019-11-28 13:02:11.388427+00	\N	2019-11-28 13:02:11.388427+00	\N		-1	-1		0	2019-11-28 13:02:11.388427+00	maija.mehilainen@aoe.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
66	2019-11-28 13:05:02.748726+00	\N	2019-11-28 13:05:02.748726+00	\N		-1	-1		0	2019-11-28 13:05:02.748726+00	maija.mehilainen@aoe.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
68	2019-11-28 13:08:36.240503+00	\N	2019-11-28 13:08:36.240503+00	\N		-1	-1		0	2019-11-28 13:08:36.240503+00	maija.mehilainen@aoe.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
67	2019-11-28 13:06:59.025246+00	\N	2019-11-28 13:20:11.634+00	\N		-1	-1	CCBY4.0	0	2019-11-28 13:06:59.025246+00	maija.mehilainen@aoe.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
69	2019-11-28 13:34:47.22319+00	\N	2019-11-28 13:34:47.22319+00	\N		-1	-1		0	2019-11-28 13:34:47.22319+00	maija.mehilainen@aoe.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
70	2019-12-02 11:12:54.38564+00	\N	2019-12-02 11:12:54.38564+00	\N		-1	-1		0	2019-12-02 11:12:54.38564+00	maija.mehilainen@aoe.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
105	2019-12-17 08:58:16.979774+00	\N	2019-12-17 08:58:17.197527+00	\N		-1	-1		0	2019-12-17 08:58:16.979774+00	teppo@yliopisto.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
71	2019-12-03 06:08:43.570578+00	\N	2019-12-03 06:08:43.570578+00	\N		-1	-1		0	2019-12-03 06:08:43.570578+00	juniemin@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
72	2019-12-03 06:39:35.903943+00	\N	2019-12-03 06:39:35.903943+00	\N		-1	-1		0	2019-12-03 06:39:35.903943+00	juniemin@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
73	2019-12-10 12:45:40.968351+00	\N	2019-12-10 12:46:29.167+00	\N		1	14	CCBY4.0	0	2019-12-10 12:45:40.968351+00	teppo@yliopisto.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
74	2019-12-10 13:18:24.433259+00	\N	2019-12-10 13:20:21.075+00	\N	1	1	55	CCBY4.0	0	2019-12-10 13:18:24.433259+00	teppo@yliopisto.fi	2019-12-08 13:16:45+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
75	2019-12-10 13:50:41.646052+00	\N	2019-12-10 13:53:12.61+00	\N		-1	-1	CCBYNCND4.0	0	2019-12-10 13:50:41.646052+00	teppo@yliopisto.fi	2019-12-31 22:00:00+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
76	2019-12-10 13:56:04.444358+00	\N	2019-12-10 13:59:15.402+00	\N		18	-1	CCBY4.0	0	2019-12-10 13:56:04.444358+00	anlindfo@csc.fi	9999-01-01 00:00:00+00	f	f	f	t	t	t	t	f	\N	\N	0	0	\N
78	2019-12-12 10:31:57.27457+00	\N	2019-12-12 10:34:46.643+00	\N		-1	-1	CCBY4.0	0	2019-12-12 10:31:57.27457+00	teppo@yliopisto.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
80	2019-12-12 10:56:45.166343+00	\N	2019-12-12 10:56:45.166343+00	\N		-1	-1		0	2019-12-12 10:56:45.166343+00	anlindfo@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
82	2019-12-12 11:30:03.261517+00	\N	2019-12-12 11:30:03.261517+00	\N		-1	-1		0	2019-12-12 11:30:03.261517+00	mroppone@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
81	2019-12-12 11:29:50.280002+00	\N	2019-12-12 11:30:50.916+00	\N		-1	-1	CCBY4.0	0	2019-12-12 11:29:50.280002+00	teppo@yliopisto.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
84	2019-12-12 11:32:56.721321+00	\N	2019-12-12 11:32:56.721321+00	\N		-1	-1		0	2019-12-12 11:32:56.721321+00	teppo@yliopisto.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
85	2019-12-12 11:33:41.637923+00	\N	2019-12-12 11:33:41.637923+00	\N		-1	-1		0	2019-12-12 11:33:41.637923+00	mroppone@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
86	2019-12-12 11:53:06.909754+00	\N	2019-12-12 11:53:06.909754+00	\N		-1	-1		0	2019-12-12 11:53:06.909754+00	teppo@yliopisto.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
87	2019-12-12 11:54:59.406244+00	\N	2019-12-12 11:54:59.406244+00	\N		-1	-1		0	2019-12-12 11:54:59.406244+00	mroppone@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
88	2019-12-12 11:56:27.817543+00	\N	2019-12-12 11:56:27.817543+00	\N		-1	-1		0	2019-12-12 11:56:27.817543+00	anlindfo@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
89	2019-12-12 12:41:40.335944+00	\N	2019-12-12 12:41:40.335944+00	\N		-1	-1		0	2019-12-12 12:41:40.335944+00	mroppone@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
90	2019-12-12 12:55:58.355452+00	\N	2019-12-12 12:55:58.355452+00	\N		-1	-1		0	2019-12-12 12:55:58.355452+00	teppo@yliopisto.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
91	2019-12-12 13:49:26.121847+00	\N	2019-12-12 13:49:26.121847+00	\N		-1	-1		0	2019-12-12 13:49:26.121847+00	teppo@yliopisto.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
92	2019-12-12 13:50:31.394754+00	\N	2019-12-12 13:50:31.394754+00	\N		-1	-1		0	2019-12-12 13:50:31.394754+00	mroppone@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
93	2019-12-12 13:51:48.814326+00	\N	2019-12-12 13:51:48.814326+00	\N		-1	-1		0	2019-12-12 13:51:48.814326+00	mroppone@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
94	2019-12-12 13:56:14.036202+00	\N	2019-12-12 13:56:14.036202+00	\N		-1	-1		0	2019-12-12 13:56:14.036202+00	teppo@yliopisto.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
96	2019-12-12 17:45:04.527354+00	\N	2019-12-12 17:45:04.527354+00	\N		-1	-1		0	2019-12-12 17:45:04.527354+00	mroppone@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
97	2019-12-13 09:13:25.561931+00	\N	2019-12-13 09:14:14.844+00	\N		-1	-1	CCBY4.0	0	2019-12-13 09:13:25.561931+00	teppo@yliopisto.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
98	2019-12-13 10:53:00.094283+00	\N	2019-12-13 10:53:00.094283+00	\N		-1	-1		0	2019-12-13 10:53:00.094283+00	anlindfo@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
99	2019-12-16 10:56:26.945759+00	\N	2019-12-16 10:57:23.384+00	\N		-1	-1	CCBY4.0	0	2019-12-16 10:56:26.945759+00	teppo@yliopisto.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
100	2019-12-16 10:58:23.731832+00	\N	2019-12-16 10:58:45.863+00	\N		-1	-1	CCBY4.0	0	2019-12-16 10:58:23.731832+00	teppo@yliopisto.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
101	2019-12-16 11:49:41.600468+00	\N	2019-12-16 11:50:05.446+00	\N		-1	-1	CCBY4.0	0	2019-12-16 11:49:41.600468+00	teppo@yliopisto.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
102	2019-12-16 14:18:42.41737+00	\N	2019-12-16 14:18:42.41737+00	\N		-1	-1		0	2019-12-16 14:18:42.41737+00	e155554	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
103	2019-12-17 07:54:25.224339+00	\N	2019-12-17 08:00:47.709+00	\N		-1	-1	CCBY4.0	0	2019-12-17 07:54:25.224339+00	anlindfo@csc.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
104	2019-12-17 08:53:30.044541+00	\N	2019-12-17 08:53:30.334654+00	\N		-1	-1		0	2019-12-17 08:53:30.044541+00	teppo@yliopisto.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
106	2019-12-17 09:59:02.731288+00	\N	2019-12-17 09:59:04.116993+00	\N		-1	-1		0	2019-12-17 09:59:02.731288+00	teppo@yliopisto.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
83	2019-12-12 11:30:55.219962+00	\N	2020-05-29 05:23:08.264+00	\N		5	100	CCBYSA4.0	0	2019-12-12 11:30:55.219962+00	mroppone@csc.fi	2020-05-01 05:21:15+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
107	2019-12-17 10:21:12.210996+00	2019-12-17 10:22:23.659206+00	2019-12-17 10:22:23.667+00	\N		1	2	CCBY4.0	0	2019-12-17 10:21:12.210996+00	teppo@yliopisto.fi	2019-12-31 10:20:50+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
113	2019-12-18 13:46:26.152733+00	\N	2019-12-18 13:46:26.152733+00	\N		-1	-1		0	2019-12-18 13:46:26.152733+00	e159440	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
108	2019-12-17 11:14:34.37716+00	2019-12-17 11:26:03.193378+00	2019-12-17 11:26:03.196+00	\N		18	-1	CCBY4.0	0	2019-12-17 11:14:34.37716+00	anlindfo@csc.fi	2020-03-08 22:00:00+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
109	2019-12-18 06:16:19.011394+00	\N	2019-12-18 06:16:19.338614+00	\N		-1	-1		0	2019-12-18 06:16:19.011394+00	210281-9988	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
114	2019-12-18 13:57:34.754269+00	\N	2019-12-18 13:57:34.754269+00	\N		-1	-1		0	2019-12-18 13:57:34.754269+00	e159440	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
115	2019-12-18 14:07:25.888561+00	\N	2019-12-18 14:07:25.888561+00	\N		-1	-1		0	2019-12-18 14:07:25.888561+00	e159440	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
119	2019-12-19 08:18:32.518984+00	\N	2019-12-19 08:18:32.591126+00	\N		-1	-1		0	2019-12-19 08:18:32.518984+00	e159440	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
116	2019-12-18 14:49:44.370719+00	\N	2019-12-18 14:49:44.370719+00	\N		-1	-1		0	2019-12-18 14:49:44.370719+00	mroppone@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
121	2019-12-19 11:06:09.52981+00	\N	2019-12-19 11:06:10.075731+00	\N		-1	-1		0	2019-12-19 11:06:09.52981+00	mroppone@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
122	2019-12-19 11:28:35.633816+00	\N	2019-12-19 11:28:35.924937+00	\N		-1	-1		0	2019-12-19 11:28:35.633816+00	mroppone@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
124	2019-12-19 12:12:56.455635+00	\N	2019-12-19 12:12:56.806708+00	\N		-1	-1		0	2019-12-19 12:12:56.455635+00	mroppone@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
125	2019-12-20 09:40:56.758682+00	\N	2019-12-20 09:40:57.382186+00	\N		-1	-1		0	2019-12-20 09:40:56.758682+00	teppo@yliopisto.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
126	2019-12-20 11:54:18.362667+00	\N	2019-12-20 11:54:18.903106+00	\N		-1	-1		0	2019-12-20 11:54:18.362667+00	teppo@yliopisto.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
128	2020-01-02 13:04:59.624433+00	2020-01-02 13:10:16.440926+00	2020-01-02 13:10:16.443+00	\N	500	1	22	CCBY4.0	0	2020-01-02 13:04:59.624433+00	teppo@yliopisto.fi	2020-01-28 13:01:58+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
129	2020-01-08 12:24:32.561168+00	\N	2020-01-08 12:24:59.012059+00	\N		-1	-1		0	2020-01-08 12:24:32.561168+00	teppo@yliopisto.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
130	2020-01-08 13:02:32.605018+00	\N	2020-01-08 13:02:33.027935+00	\N		-1	-1		0	2020-01-08 13:02:32.605018+00	MPASSOID.53b1af17cb284998638b5	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
118	2019-12-19 08:14:35.196666+00	2019-12-19 08:17:06.078708+00	2019-12-19 08:17:06.082+00	\N		-1	-1	CCBY4.0	0	2019-12-19 08:14:35.196666+00	e159440	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	3	0	2021-02-23 06:34:38.11706+00
123	2019-12-19 12:05:44.636897+00	2019-12-19 12:07:17.863345+00	2019-12-19 12:07:17.865+00	\N		-1	-1	CCBY4.0	1	2019-12-19 12:05:44.636897+00	anlindfo@csc.fi	2020-01-07 22:00:00+00	f	f	f	f	f	t	f	f	\N	\N	0	0	\N
143	2020-01-16 10:23:06.885529+00	2020-01-16 10:24:17.751673+00	2020-01-16 10:24:17.754+00	\N		-1	-1	CCBY4.0	0	2020-01-16 10:23:06.885529+00	anlindfo@csc.fi	9999-01-01 00:00:00+00	f	f	f	f	f	t	f	f	\N	\N	1	0	2020-11-18 07:07:25.547809+00
117	2019-12-19 06:42:34.494761+00	2019-12-19 06:43:14.880587+00	2019-12-19 06:43:14.882+00	\N		-1	-1	CCBY4.0	0	2019-12-19 06:42:34.494761+00	teppo@yliopisto.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	2	0	2021-02-23 06:34:36.429564+00
77	2019-12-12 10:28:34.343024+00	\N	2020-12-21 11:14:58.597356+00	\N		18	-1	CCBY4.0	0	2019-12-12 10:28:34.343024+00	anlindfo@csc.fi	2020-02-04 10:28:05+00	f	f	f	f	f	t	f	f	\N	\N	0	0	\N
112	2019-12-18 13:43:08.806549+00	2019-12-18 13:44:10.406432+00	2020-01-09 11:15:16.659238+00	\N		-1	-1	CCBY4.0	0	2019-12-18 13:43:08.806549+00	teppo@yliopisto.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	2	0	2021-03-31 07:52:58.06839+00
120	2019-12-19 08:22:39.120363+00	\N	2019-12-19 08:22:39.715762+00	\N		-1	-1		0	2019-12-19 08:22:39.120363+00	mroppone@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	2	0	2021-04-20 05:49:17.990405+00
131	2020-01-10 08:15:18.466896+00	\N	2020-01-10 08:15:18.919352+00	\N		-1	-1		0	2020-01-10 08:15:18.466896+00	anlindfo@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
133	2020-01-10 11:51:07.968239+00	\N	2020-01-10 11:52:08.366449+00	\N		-1	-1		0	2020-01-10 11:51:07.968239+00	teppo@yliopisto.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
134	2020-01-14 11:26:47.196964+00	\N	2020-01-14 11:27:02.182753+00	\N		-1	-1		0	2020-01-14 11:26:47.196964+00	teppo@yliopisto.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
135	2020-01-14 11:45:27.462874+00	\N	2020-01-14 11:45:27.846464+00	\N		-1	-1		0	2020-01-14 11:45:27.462874+00	anlindfo@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
159	2020-01-20 05:52:03.030647+00	\N	2020-01-20 05:52:21.781322+00	\N		-1	-1		0	2020-01-20 05:52:03.030647+00	anlindfo@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
152	2020-01-17 10:32:30.867317+00	\N	2020-01-17 10:32:49.446155+00	\N		-1	-1		0	2020-01-17 10:32:30.867317+00	anlindfo@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
136	2020-01-14 13:32:51.356074+00	\N	2020-01-14 13:37:03.479688+00	\N		-1	-1		0	2020-01-14 13:32:51.356074+00	teppo@yliopisto.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
138	2020-01-15 09:20:48.253332+00	2020-01-15 09:21:46.267026+00	2020-01-15 09:21:46.269+00	\N		-1	-1	CCBY4.0	0	2020-01-15 09:20:48.253332+00	teppo@yliopisto.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
170	2020-01-24 08:42:39.299968+00	\N	2020-01-24 08:42:40.906906+00	\N		-1	-1		0	2020-01-24 08:42:39.299968+00	teppo@yliopisto.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
153	2020-01-17 10:39:38.954764+00	\N	2020-01-17 10:39:54.359114+00	\N		-1	-1		0	2020-01-17 10:39:38.954764+00	anlindfo@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
145	2020-01-16 13:23:49.645887+00	\N	2020-01-16 13:53:53.523908+00	\N		-1	-1		0	2020-01-16 13:23:49.645887+00	teppo@yliopisto.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
140	2020-01-16 07:31:10.166158+00	2020-01-16 07:46:46.231135+00	2020-01-16 07:46:46.236+00	\N		-1	-1	CCBY4.0	0	2020-01-16 07:31:10.166158+00	teppo@yliopisto.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
154	2020-01-17 10:41:05.984843+00	\N	2020-01-17 10:41:21.892403+00	\N		-1	-1		0	2020-01-17 10:41:05.984843+00	anlindfo@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
141	2020-01-16 10:00:30.799319+00	2020-01-16 10:01:15.836537+00	2020-01-16 10:01:15.839+00	\N		-1	-1	CCBY4.0	0	2020-01-16 10:00:30.799319+00	teppo@yliopisto.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
161	2020-01-22 12:16:33.878575+00	\N	2020-01-22 12:16:37.612397+00	\N		-1	-1		0	2020-01-22 12:16:33.878575+00	teppo@yliopisto.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
146	2020-01-17 07:12:52.104324+00	\N	2020-01-17 07:22:13.936349+00	\N		-1	-1		0	2020-01-17 07:12:52.104324+00	teppo@yliopisto.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
155	2020-01-17 10:42:58.243825+00	\N	2020-01-17 10:43:14.104471+00	\N		-1	-1		0	2020-01-17 10:42:58.243825+00	anlindfo@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
147	2020-01-17 07:41:57.740036+00	\N	2020-01-17 07:42:38.263434+00	\N		-1	-1		0	2020-01-17 07:41:57.740036+00	anlindfo@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
162	2020-01-23 06:56:40.510581+00	\N	2020-01-23 06:56:41.884022+00	\N		-1	-1		0	2020-01-23 06:56:40.510581+00	anlindfo@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
163	2020-01-23 07:35:58.414717+00	\N	2020-01-23 07:36:03.072826+00	\N		-1	-1		0	2020-01-23 07:35:58.414717+00	teppo@yliopisto.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
148	2020-01-17 09:55:44.569018+00	\N	2020-01-17 10:48:44.708778+00	\N		-1	-1		0	2020-01-17 09:55:44.569018+00	teppo@yliopisto.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
149	2020-01-17 10:22:44.283386+00	\N	2020-01-17 10:23:01.120013+00	\N		-1	-1		0	2020-01-17 10:22:44.283386+00	anlindfo@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
156	2020-01-17 10:45:56.086076+00	\N	2020-01-17 10:54:39.952946+00	\N		-1	-1		0	2020-01-17 10:45:56.086076+00	teppo@yliopisto.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
150	2020-01-17 10:25:22.033448+00	\N	2020-01-17 10:26:19.487857+00	\N		-1	-1		0	2020-01-17 10:25:22.033448+00	anlindfo@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
151	2020-01-17 10:27:54.781717+00	\N	2020-01-17 10:28:13.740525+00	\N		-1	-1		0	2020-01-17 10:27:54.781717+00	anlindfo@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
164	2020-01-23 08:08:17.857517+00	\N	2020-01-23 08:08:36.408323+00	\N		-1	-1		0	2020-01-23 08:08:17.857517+00	teppo@yliopisto.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
157	2020-01-17 10:55:09.748584+00	\N	2020-01-17 10:55:28.272614+00	\N		-1	-1		0	2020-01-17 10:55:09.748584+00	anlindfo@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
165	2020-01-23 10:08:28.192843+00	2020-01-23 10:09:10.236305+00	2020-01-23 10:09:10.238+00	\N		-1	-1	CCBY4.0	0	2020-01-23 10:08:28.192843+00	teppo@yliopisto.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
158	2020-01-17 11:08:45.453541+00	\N	2020-01-17 11:09:30.119792+00	\N		-1	-1		0	2020-01-17 11:08:45.453541+00	anlindfo@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
167	2020-01-23 11:50:02.032477+00	\N	2020-01-23 12:05:05.138119+00	\N		-1	-1		0	2020-01-23 11:50:02.032477+00	teppo@yliopisto.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
172	2020-01-28 06:25:13.545673+00	\N	2020-01-28 06:25:14.731637+00	\N		-1	-1		0	2020-01-28 06:25:13.545673+00	anlindfo@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
166	2020-01-23 10:09:54.273817+00	\N	2020-01-23 10:16:22.552866+00	\N		-1	-1		0	2020-01-23 10:09:54.273817+00	teppo@yliopisto.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
173	2020-01-28 07:36:37.499813+00	\N	2020-01-28 07:36:37.784604+00	\N		-1	-1		0	2020-01-28 07:36:37.499813+00	olehto@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
175	2020-01-28 11:05:24.790011+00	2020-01-28 11:06:26.549836+00	2020-01-28 11:06:26.553+00	\N		-1	-1	CCBY4.0	0	2020-01-28 11:05:24.790011+00	teppo@yliopisto.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
174	2020-01-28 10:35:01.230801+00	2020-01-28 10:56:08.825421+00	2020-01-28 10:56:08.83+00	\N		-1	-1	CCBY4.0	0	2020-01-28 10:35:01.230801+00	teppo@yliopisto.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
176	2020-01-28 11:21:10.281615+00	2020-01-28 11:26:19.086324+00	2020-01-28 11:26:19.089+00	\N		-1	-1	CCBY4.0	0	2020-01-28 11:21:10.281615+00	210281-9988	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
179	2020-01-30 10:56:31.477756+00	\N	2020-01-30 10:56:35.291939+00	\N		-1	-1		0	2020-01-30 10:56:31.477756+00	teppo@yliopisto.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
181	2020-02-12 08:56:50.779043+00	\N	2020-02-12 08:59:21.277247+00	\N		-1	-1		0	2020-02-12 08:56:50.779043+00	teppo@yliopisto.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
180	2020-02-06 13:43:55.756376+00	\N	2020-02-06 13:43:56.173214+00	\N		-1	-1		0	2020-02-06 13:43:55.756376+00	210281-9988	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
160	2020-01-22 08:31:19.846292+00	2020-01-22 09:13:22.832277+00	2020-01-22 09:13:22.839+00	\N		-1	-1	CCBYSA4.0	1	2020-01-22 08:31:19.846292+00	olehto@csc.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
182	2020-02-12 09:02:53.980048+00	2020-02-12 09:03:17.747619+00	2020-02-12 09:03:17.753+00	\N		-1	-1	CCBY4.0	0	2020-02-12 09:02:53.980048+00	teppo@yliopisto.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
183	2020-02-13 11:21:31.823554+00	2020-02-13 11:37:16.332078+00	2020-02-13 11:37:16.335+00	\N		-1	-1	CCBY4.0	0	2020-02-13 11:21:31.823554+00	210281-9988	9999-01-01 00:00:00+00	f	f	t	f	f	f	f	f	\N	\N	0	0	\N
184	2020-02-13 11:44:46.243248+00	2020-02-13 11:48:07.889181+00	2020-02-13 11:48:07.891+00	\N		-1	-1	CCBY4.0	0	2020-02-13 11:44:46.243248+00	210281-9988	9999-01-01 00:00:00+00	t	f	f	f	f	f	f	f	\N	\N	0	0	\N
185	2020-02-13 11:51:51.517922+00	\N	2020-02-13 11:52:10.232383+00	\N		-1	-1		0	2020-02-13 11:51:51.517922+00	teppo@yliopisto.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
187	2020-02-13 12:17:58.173249+00	\N	2020-02-13 12:17:58.173249+00	\N		-1	-1		0	2020-02-13 12:17:58.173249+00	teppo@yliopisto.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
186	2020-02-13 12:05:22.640531+00	\N	2020-02-13 12:06:39.083168+00	\N		-1	-1		0	2020-02-13 12:05:22.640531+00	teppo@yliopisto.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
241	2020-04-07 11:00:41.808762+00	2020-04-07 11:55:25.809404+00	2020-06-11 06:10:55.932+00	\N	2h	5	99	CC BY-SA 4.0	0	2020-04-07 11:00:41.808762+00	mroppone@csc.fi	2022-12-30 22:00:00+00	f	f	f	f	f	f	f	f	4.0	5.0	0	0	\N
188	2020-02-13 12:19:17.361352+00	\N	2020-02-13 12:19:35.876689+00	\N		-1	-1		0	2020-02-13 12:19:17.361352+00	teppo@yliopisto.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
201	2020-02-24 06:41:22.754409+00	\N	2020-02-24 06:41:23.38645+00	\N		-1	-1		0	2020-02-24 06:41:22.754409+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
190	2020-02-13 12:40:23.784825+00	\N	2020-02-13 12:40:42.256423+00	\N		-1	-1		0	2020-02-13 12:40:23.784825+00	teppo@yliopisto.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
191	2020-02-13 13:04:06.357399+00	\N	2020-02-13 13:04:06.781608+00	\N		-1	-1		0	2020-02-13 13:04:06.357399+00	210281-9988	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
192	2020-02-17 08:21:36.856438+00	\N	2020-02-17 08:21:39.328648+00	\N		-1	-1		0	2020-02-17 08:21:36.856438+00	210281-9988	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
252	2020-04-27 05:48:57.249418+00	\N	2020-04-27 05:48:57.249418+00	\N		\N	\N		0	2020-04-27 05:48:57.249418+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
178	2020-01-30 10:11:21.803851+00	2020-04-03 12:13:33.431473+00	2020-04-03 12:13:33.433+00	\N		1	2	CCBY4.0	0	2020-01-30 10:11:21.803851+00	teppo@yliopisto.fi	9999-01-01 00:00:00+00	f	t	f	f	f	f	t	f	\N	\N	1	0	2020-11-17 13:29:42.458436+00
139	2020-01-15 10:45:12.147348+00	2020-01-15 10:46:18.998053+00	2020-01-15 10:46:19+00	\N		-1	-1	CCBY4.0	0	2020-01-15 10:45:12.147348+00	teppo@yliopisto.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	1	0	2021-03-22 08:43:09.937862+00
142	2020-01-16 10:05:19.399277+00	2020-01-16 10:06:59.427318+00	2020-01-16 10:06:59.429+00	\N		-1	-1	CCBY4.0	1	2020-01-16 10:05:19.399277+00	anlindfo@csc.fi	9999-01-01 00:00:00+00	f	f	f	f	f	t	f	f	\N	\N	1	0	2020-12-08 09:28:25.841047+00
144	2020-01-16 11:18:01.819914+00	2020-04-03 10:38:41.222402+00	2020-04-03 10:38:41.226+00	\N		18	99	CCBY4.0	0	2020-01-16 11:18:01.819914+00	anlindfo@csc.fi	2023-08-15 10:13:10+00	f	f	f	f	f	t	f	f	\N	\N	1	0	2020-12-08 09:32:41.480564+00
137	2020-01-15 06:49:53.904535+00	2020-01-15 06:51:19.802905+00	2020-01-15 06:51:19.809+00	\N		-1	-1	CCBY4.0	0	2020-01-15 06:49:53.904535+00	teppo@yliopisto.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	2	0	2021-02-23 06:34:53.840752+00
230	2020-03-11 12:50:22.087476+00	2020-04-03 10:48:45.83455+00	2020-04-03 10:48:45.837+00	\N		1	1	CCBY4.0	0	2020-03-11 12:50:22.087476+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	2021-03-31 21:00:00+00	f	f	t	f	f	f	f	f	\N	\N	2	0	2021-02-02 06:38:14.754438+00
132	2020-01-10 11:03:56.387163+00	2020-01-10 11:47:14.869531+00	2020-10-14 09:44:26.51413+00	\N		-1	-1	CCBY4.0	0	2020-01-10 11:03:56.387163+00	teppo@yliopisto.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	6	0	2021-03-26 10:57:24.899966+00
216	2020-02-25 15:46:34.464603+00	2020-02-25 15:50:37.113257+00	2020-02-25 15:50:37.118+00	\N		-1	-1	CCBY4.0	0	2020-02-25 15:46:34.464603+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	2023-08-23 14:45:01+00	f	f	f	f	f	t	t	f	\N	\N	0	0	\N
202	2020-02-24 06:46:07.59392+00	2020-02-24 06:48:07.88288+00	2020-02-24 06:48:07.885+00	\N		-1	-1	CCBY4.0	0	2020-02-24 06:46:07.59392+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	9999-01-01 00:00:00+00	t	f	f	f	f	t	f	f	\N	\N	0	0	\N
195	2020-02-20 06:09:53.5691+00	\N	2020-02-20 06:09:53.605504+00	\N		-1	-1		0	2020-02-20 06:09:53.5691+00	teppo@yliopisto.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
194	2020-02-20 06:00:11.828832+00	\N	2020-02-20 06:12:06.115187+00	\N		-1	-1		0	2020-02-20 06:00:11.828832+00	210281-9988	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
223	2020-03-03 11:13:47.942299+00	2020-03-03 11:15:22.578431+00	2020-03-03 11:15:22.58+00	\N	2	1	5	CCBY4.0	0	2020-03-03 11:13:47.942299+00	teppo@yliopisto.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
218	2020-02-28 08:09:40.926547+00	\N	2020-02-28 08:09:41.341534+00	\N		-1	-1		0	2020-02-28 08:09:40.926547+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
196	2020-02-20 06:34:41.320265+00	\N	2020-02-20 06:39:23.046558+00	\N		-1	-1		0	2020-02-20 06:34:41.320265+00	teppo@yliopisto.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
205	2020-02-24 08:57:39.140835+00	\N	2020-02-24 08:57:39.551205+00	\N		-1	-1		0	2020-02-24 08:57:39.140835+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
197	2020-02-20 07:26:39.492523+00	\N	2020-02-20 07:35:54.638723+00	\N		-1	-1		0	2020-02-20 07:26:39.492523+00	teppo@yliopisto.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
198	2020-02-20 12:40:28.886468+00	\N	2020-02-20 12:40:29.345624+00	\N		-1	-1		0	2020-02-20 12:40:28.886468+00	juniemin@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
206	2020-02-24 09:00:21.346917+00	\N	2020-02-24 09:00:39.68785+00	\N		-1	-1		0	2020-02-24 09:00:21.346917+00	teppo@yliopisto.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
199	2020-02-20 13:19:04.017687+00	\N	2020-02-20 13:22:05.122127+00	\N		-1	-1		0	2020-02-20 13:19:04.017687+00	teppo@yliopisto.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
209	2020-02-25 05:37:49.505225+00	\N	2020-02-25 05:37:49.879678+00	\N		-1	-1		0	2020-02-25 05:37:49.505225+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
210	2020-02-25 05:44:59.285475+00	\N	2020-02-25 05:44:59.285475+00	\N		-1	-1		0	2020-02-25 05:44:59.285475+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
211	2020-02-25 05:46:10.284581+00	\N	2020-02-25 06:01:28.059959+00	\N		-1	-1		0	2020-02-25 05:46:10.284581+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
219	2020-02-28 10:07:11.130173+00	\N	2020-02-28 10:07:11.549044+00	\N		-1	-1		0	2020-02-28 10:07:11.130173+00	anlindfo@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
212	2020-02-25 06:08:13.610455+00	\N	2020-02-25 06:08:13.610455+00	\N		-1	-1		0	2020-02-25 06:08:13.610455+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
213	2020-02-25 08:50:37.190962+00	\N	2020-02-25 08:53:12.455943+00	\N		-1	-1		0	2020-02-25 08:50:37.190962+00	teppo@yliopisto.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
3	2019-11-01 08:27:12.095353+00	\N	2019-11-01 08:27:12.095353+00	9999-01-01 00:00:00+00		-1	-1		1	2019-11-01 08:27:12.095353+00	maija.mehilainen@aoe.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
225	2020-03-06 12:12:57.910513+00	\N	2020-03-06 12:12:58.148401+00	\N		-1	-1		0	2020-03-06 12:12:57.910513+00	mroppone@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
226	2020-03-06 12:22:05.905034+00	\N	2020-03-06 12:22:06.226796+00	\N		-1	-1		0	2020-03-06 12:22:05.905034+00	mroppone@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
221	2020-02-28 11:45:29.455608+00	\N	2020-02-28 11:45:29.804211+00	\N		-1	-1		0	2020-02-28 11:45:29.455608+00	mroppone@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
222	2020-03-03 07:43:24.344191+00	2020-03-03 07:44:31.036558+00	2020-03-03 07:44:31.04+00	\N		-1	-1	CCBY4.0	0	2020-03-03 07:43:24.344191+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	9999-01-01 00:00:00+00	t	f	t	f	f	f	f	f	\N	\N	0	0	\N
227	2020-03-09 06:59:33.524926+00	\N	2020-03-09 06:59:33.837866+00	\N		-1	-1		0	2020-03-09 06:59:33.524926+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
228	2020-03-10 07:36:20.789977+00	\N	2020-05-29 08:58:46.622+00	\N		\N	\N	CCBY4.0	0	2020-03-10 07:36:20.789977+00	mroppone@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
229	2020-03-10 09:13:43.140708+00	\N	2020-03-10 09:13:43.391236+00	\N		-1	-1		0	2020-03-10 09:13:43.140708+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
236	2020-03-26 07:52:59.060715+00	\N	2020-03-26 08:15:31.972553+00	\N		-1	-1		0	2020-03-26 07:52:59.060715+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
232	2020-03-18 12:40:04.093934+00	\N	2020-03-18 12:40:04.559283+00	\N		-1	-1		0	2020-03-18 12:40:04.093934+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
214	2020-02-25 08:52:38.499609+00	2020-06-02 12:58:30.555428+00	2020-06-02 12:58:30.561+00	\N	100	1	2	CCBY4.0	0	2020-02-25 08:52:38.499609+00	teppo@yliopisto.fi	2022-05-31 21:00:00+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
237	2020-03-31 07:59:48.135603+00	\N	2020-03-31 07:59:49.203964+00	\N		-1	-1		0	2020-03-31 07:59:48.135603+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
238	2020-04-01 19:53:14.043924+00	\N	2020-04-01 19:55:41.051254+00	\N		-1	-1		0	2020-04-01 19:53:14.043924+00	teppo@yliopisto.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
240	2020-04-03 10:09:30.015048+00	\N	2020-04-03 10:09:30.309135+00	\N		-1	-1		0	2020-04-03 10:09:30.015048+00	anlindfo@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
203	2020-02-24 06:49:13.645032+00	2020-02-24 06:52:10.284503+00	2020-05-07 08:55:53.715+00	\N		\N	\N	CCBY4.0	0	2020-02-24 06:49:13.645032+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	t	f	f	f	t	t	f	\N	\N	0	0	\N
239	2020-04-02 11:49:09.369422+00	2020-04-08 07:27:43.518218+00	2020-04-08 07:27:43.522+00	\N		\N	\N	CCBY4.0	0	2020-04-02 11:49:09.369422+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	t	f	f	f	f	f	\N	\N	0	0	\N
242	2020-04-08 08:46:32.994058+00	\N	2020-04-08 08:46:34.04597+00	\N		\N	\N		0	2020-04-08 08:46:32.994058+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
244	2020-04-09 08:17:25.11976+00	\N	2020-04-09 08:17:26.106962+00	\N		\N	\N		0	2020-04-09 08:17:25.11976+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
200	2020-02-21 13:53:11.936446+00	2020-05-08 08:37:49.181491+00	2020-05-08 08:37:49.183+00	\N		\N	\N	CCBY4.0	0	2020-02-21 13:53:11.936446+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	t	f	f	f	f	f	1.0	2.0	0	0	\N
258	2020-04-27 05:48:57.262427+00	2020-05-29 07:38:59.636215+00	2020-05-29 08:42:43.464+00	\N		\N	\N	CCBY4.0	0	2020-04-27 05:48:57.262427+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
249	2020-04-23 09:53:58.048848+00	2020-04-27 05:58:02.968727+00	2020-05-15 06:24:52.475+00	\N		\N	\N	CCBYSA4.0	0	2020-04-23 09:53:58.048848+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	2020-04-30 05:14:59+00	f	f	f	f	f	t	f	f	4.0	4.0	0	0	\N
266	2020-05-14 08:29:22.189531+00	2020-05-14 08:31:03.810296+00	2020-05-14 08:31:03.814+00	\N		\N	\N	CCBY4.0	0	2020-05-14 08:29:22.189531+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	5.0	\N	0	0	\N
260	2020-04-27 07:32:25.959377+00	2020-04-27 07:37:30.032094+00	2020-05-07 12:04:27.78+00	\N		13	37	CCBYNC4.0	0	2020-04-27 07:32:25.959377+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	2020-07-30 21:00:00+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
262	2020-05-04 12:43:09.434003+00	\N	2020-05-04 12:43:09.843562+00	\N		\N	\N		0	2020-05-04 12:43:09.434003+00	olehto@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
273	2020-06-05 04:26:36.705574+00	\N	2020-06-05 04:26:43.991745+00	\N		\N	\N		0	2020-06-05 04:26:36.705574+00	mroppone@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
248	2020-04-23 08:17:02.996412+00	\N	2020-04-23 09:53:18.40189+00	\N		\N	\N		0	2020-04-23 08:17:02.996412+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
261	2020-04-28 22:59:41.856677+00	\N	2020-05-27 05:43:22.977+00	\N		\N	\N	CCBY4.0	0	2020-04-28 22:59:41.856677+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	t	f	f	f	f	f	f	\N	\N	0	0	\N
250	2020-04-27 05:48:57.243801+00	\N	2020-04-27 05:48:57.243801+00	\N		\N	\N		0	2020-04-27 05:48:57.243801+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
204	2020-02-24 08:07:28.562135+00	2020-02-24 08:45:34.678838+00	2020-02-24 08:45:34.681+00	\N		-1	-1	CCBY4.0	0	2020-02-24 08:07:28.562135+00	teppo@yliopisto.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	1	0	2020-10-21 12:34:50.287503+00
215	2020-02-25 10:35:01.681584+00	2020-04-03 08:33:45.144566+00	2020-05-07 08:01:39.968+00	\N		-1	-1	CCBYNCSA4.0	0	2020-02-25 10:35:01.681584+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	3	0	2020-12-14 13:39:27.078219+00
243	2020-04-09 07:57:42.722376+00	2020-04-22 10:06:12.335826+00	2020-04-22 10:06:12.342+00	\N		\N	\N	CCBY4.0	0	2020-04-09 07:57:42.722376+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	t	f	f	f	f	f	f	f	\N	\N	1	0	2020-10-21 12:34:55.3459+00
220	2020-02-28 10:08:01.231371+00	2020-04-03 11:11:08.016328+00	2020-10-29 07:20:58.482+00	\N	24 h	8	18	CCBY4.0	0	2020-02-28 10:08:01.231371+00	anlindfo@csc.fi	2020-10-29 22:00:00+00	f	f	f	f	t	f	f	f	3.0	4.0	16	0	2021-04-28 05:46:46.271666+00
235	2020-03-25 08:48:44.605022+00	2020-03-25 08:50:58.293489+00	2020-03-25 08:50:58.296+00	\N	120	1	99	CCBY4.0	0	2020-03-25 08:48:44.605022+00	teppo@yliopisto.fi	2029-03-30 21:00:00+00	f	f	t	f	f	f	f	t	\N	\N	5	0	2021-03-26 11:42:43.500001+00
217	2020-02-27 12:30:55.983348+00	2020-04-07 06:28:43.153435+00	2020-04-07 06:28:43.156+00	\N		-1	-1	CCBY4.0	0	2020-02-27 12:30:55.983348+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	9999-01-01 00:00:00+00	t	f	f	f	f	t	f	f	\N	\N	1	0	2021-03-26 11:36:46.543245+00
231	2020-03-17 13:07:13.854057+00	2020-04-03 12:00:13.121119+00	2020-04-03 12:00:13.124+00	\N	2 h	18	99	CCBY4.0	0	2020-03-17 13:07:13.854057+00	anlindfo@csc.fi	2023-05-09 12:06:05+00	f	f	f	f	f	f	f	f	\N	\N	2	0	2020-12-08 09:32:31.920753+00
233	2020-03-24 11:52:52.943689+00	2020-05-27 07:14:19.188827+00	2020-10-13 05:25:10.341717+00	\N		\N	\N	CCBY4.0	0	2020-03-24 11:52:52.943689+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	t	f	f	f	f	f	\N	\N	57	0	2021-04-28 07:30:47.316825+00
224	2020-03-05 16:59:15.084078+00	2020-03-05 17:02:39.647672+00	2020-03-05 17:02:39.653+00	\N		2	6	CCBY4.0	0	2020-03-05 16:59:15.084078+00	vigallen@csc.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	4	0	2021-03-26 11:03:37.393127+00
193	2020-02-18 06:03:54.614676+00	2020-02-18 06:14:46.537194+00	2020-02-18 06:14:46.543+00	\N		-1	-1	CCBY4.0	0	2020-02-18 06:03:54.614676+00	210281-9988	2023-08-08 04:55:38+00	t	t	t	f	f	f	f	f	\N	\N	2	0	2021-03-26 11:37:22.50478+00
253	2020-04-27 05:48:57.251745+00	\N	2020-04-27 05:48:57.251745+00	\N		\N	\N		0	2020-04-27 05:48:57.251745+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
254	2020-04-27 05:48:57.253671+00	\N	2020-04-27 05:48:57.253671+00	\N		\N	\N		0	2020-04-27 05:48:57.253671+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
256	2020-04-27 05:48:57.254617+00	\N	2020-04-27 05:48:57.254617+00	\N		\N	\N		0	2020-04-27 05:48:57.254617+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
270	2020-06-02 13:54:12.743808+00	2020-06-02 13:55:50.72675+00	2020-06-02 13:55:50.732+00	\N	223	1	22	CCBY4.0	0	2020-06-02 13:54:12.743808+00	teppo@yliopisto.fi	2020-06-29 13:51:07+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
263	2020-05-07 08:08:17.752361+00	2020-05-27 07:04:58.747775+00	2020-05-27 07:04:58.752+00	\N		\N	\N	CCBY4.0	0	2020-05-07 08:08:17.752361+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
234	2020-03-25 07:57:01.17336+00	2020-04-15 08:02:45.761219+00	2020-05-14 12:15:02.842+00	\N		10	18	CCBY4.0	0	2020-03-25 07:57:01.17336+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	2020-04-30 06:17:41+00	f	f	f	f	f	f	f	f	4.7	4.3	0	0	\N
264	2020-05-13 20:00:10.471589+00	2020-05-13 20:01:06.103533+00	2020-05-13 20:01:06.108+00	\N		\N	\N	CCBY4.0	0	2020-05-13 20:00:10.471589+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
269	2020-05-27 07:14:56.688805+00	2020-05-27 07:15:46.571487+00	2020-05-27 07:15:46.577+00	\N		\N	\N	CCBY4.0	0	2020-05-27 07:14:56.688805+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	t	f	f	f	f	f	f	\N	\N	0	0	\N
259	2020-04-27 05:48:57.276507+00	2020-05-29 05:21:33.431502+00	2020-05-29 05:21:33.433+00	\N		\N	\N	CCBY4.0	0	2020-04-27 05:48:57.276507+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	2020-02-29 22:00:00+00	t	f	f	f	f	f	f	f	\N	\N	0	0	\N
274	2020-06-05 08:04:26.276322+00	\N	2020-07-24 11:51:18.306666+00	\N		\N	\N		0	2020-06-05 08:04:26.276322+00	mroppone@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
287	2020-06-22 07:58:53.253253+00	2020-06-22 08:00:48.101178+00	2020-06-22 08:00:48.107+00	\N		\N	\N	CCBYNC4.0	0	2020-06-22 07:58:53.253253+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	t	f	\N	\N	0	0	\N
79	2019-12-12 10:51:20.399+00	\N	2020-05-29 05:24:05.254+00	\N		5	50		0	2019-12-12 10:51:20.399+00	mroppone@csc.fi	2020-05-01 05:21:15+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
95	2019-12-12 14:24:34.874203+00	\N	2020-05-29 05:22:20.043+00	\N		10	100		0	2019-12-12 14:24:34.874203+00	mroppone@csc.fi	2020-05-01 05:21:15+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
284	2020-06-11 10:23:35.963003+00	2020-06-11 10:38:50.886101+00	2020-06-11 10:38:50.89+00	\N	2,5 h	15	50	CCBY4.0	0	2020-06-11 10:23:35.963003+00	olehto@csc.fi	2021-12-31 11:33:16+00	f	f	f	f	t	f	f	t	\N	\N	0	0	\N
283	2020-06-10 09:38:58.394173+00	\N	2020-06-10 09:38:59.472546+00	\N		\N	\N		0	2020-06-10 09:38:58.394173+00	olehto@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
267	2020-05-14 10:17:09.748357+00	2020-05-14 10:30:25.25176+00	2020-07-17 06:52:22.688+00	\N	3 h	\N	\N	CCBY4.0	0	2020-05-14 10:17:09.748357+00	olehto@csc.fi	2021-12-31 22:00:00+00	f	f	t	f	f	t	f	f	3.5	3.5	0	0	\N
293	2020-07-03 11:07:44.902774+00	2020-07-03 11:10:48.338268+00	2020-07-03 11:10:48.34+00	\N	2-3 kuukautta	5	11	CCBY4.0	0	2020-07-03 11:07:44.902774+00	olehto@csc.fi	2020-08-31 11:06:48+00	f	f	f	f	t	f	f	f	\N	\N	0	0	\N
268	2020-05-27 04:39:44.672035+00	2020-05-27 07:12:33.971187+00	2020-07-24 11:50:59.646465+00	\N		\N	\N	CCBY4.0	0	2020-05-27 04:39:44.672035+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	2020-05-31 21:00:00+00	t	f	f	f	f	f	f	f	\N	\N	0	0	\N
294	2020-07-08 07:25:04.030882+00	2020-07-24 08:07:25.62642+00	2020-07-24 08:07:25.63+00	\N		\N	\N	CCBY4.0	0	2020-07-08 07:25:04.030882+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
296	2020-07-15 11:10:13.355675+00	2020-07-15 11:13:14.534807+00	2020-07-15 11:13:14.538+00	\N	10-20 tuntia	0	100	CCBY4.0	0	2020-07-15 11:10:13.355675+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	2020-07-31 07:32:00+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
297	2020-07-24 08:11:32.410811+00	2020-07-24 08:17:05.515904+00	2020-07-24 08:17:05.519+00	\N		\N	\N	CCBY4.0	0	2020-07-24 08:11:32.410811+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
298	2020-07-24 12:40:18.872299+00	\N	2020-07-24 12:40:26.219635+00	\N		\N	\N		0	2020-07-24 12:40:18.872299+00	mroppone@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
305	2020-07-31 10:31:06.993828+00	\N	2020-07-31 10:32:47.87382+00	\N		\N	\N		0	2020-07-31 10:31:06.993828+00	mroppone@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
257	2020-04-27 05:48:57.256258+00	2020-06-04 09:06:18.161537+00	2020-08-06 06:03:09.025687+00	\N		\N	\N	CCBY4.0	0	2020-04-27 05:48:57.256258+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
302	2020-07-28 09:37:22.241489+00	2020-08-05 08:43:39.285946+00	2020-08-05 08:43:39.291+00	\N		\N	\N	CCBY4.0	0	2020-07-28 09:37:22.241489+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	2	0	2021-03-26 11:36:54.594642+00
307	2020-08-10 06:58:56.209905+00	\N	2020-08-10 06:58:56.558556+00	\N		\N	\N		0	2020-08-10 06:58:56.209905+00	anlindfo@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
308	2020-08-10 07:16:01.380544+00	\N	2020-08-10 07:16:01.757355+00	\N		\N	\N		0	2020-08-10 07:16:01.380544+00	anlindfo@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
295	2020-07-09 11:11:02.638524+00	\N	2020-08-18 07:11:33.84641+00	\N		\N	\N		0	2020-07-09 11:11:02.638524+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	4	0	2021-03-19 06:37:21.365629+00
282	2020-06-09 11:30:15.088994+00	2020-06-09 11:35:38.554645+00	2020-08-28 07:30:44.802+00	\N		\N	\N	CCBY4.0	0	2020-06-09 11:30:15.088994+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
292	2020-07-01 06:28:13.565373+00	2021-02-24 10:05:36.468907+00	2021-02-24 10:05:36.481+00	\N		\N	\N	CCBY4.0	0	2020-07-01 06:28:13.565373+00	olehto@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	9	0	2021-03-05 09:29:39.996808+00
311	2020-08-28 07:32:05.733364+00	\N	2020-08-28 07:32:06.067933+00	\N		\N	\N		0	2020-08-28 07:32:05.733364+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
285	2020-06-22 05:54:54.117975+00	2020-06-22 06:04:04.366827+00	2020-10-19 05:51:52.712926+00	\N	8 h	\N	\N	CCBY4.0	0	2020-06-22 05:54:54.117975+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	t	f	t	t	f	t	4.0	5.0	46	2	2021-04-28 05:47:04.745037+00
288	2020-06-23 09:36:31.992988+00	2020-06-23 09:38:02.157507+00	2020-10-29 08:11:12.615+00	\N		\N	\N	CCBY4.0	0	2020-06-23 09:36:31.992988+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	2020-10-31 22:00:00+00	f	f	t	f	f	f	f	f	\N	\N	0	0	\N
290	2020-06-25 06:11:16.682803+00	2020-09-04 06:50:43.925088+00	2020-09-04 06:51:17.331+00	\N		\N	\N	CCBY4.0	0	2020-06-25 06:11:16.682803+00	olehto@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	2	0	2021-04-28 06:18:35.497702+00
255	2020-04-27 05:48:57.254076+00	\N	2020-04-27 05:48:57.254076+00	\N		\N	\N		1	2020-04-27 05:48:57.254076+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
300	2020-07-27 09:16:31.716201+00	2020-08-04 06:58:23.213506+00	2021-04-28 05:49:17.453+00	\N		\N	\N	CCBYNC4.0	0	2020-07-27 09:16:31.716201+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	69	0	2021-05-05 09:09:56.198844+00
304	2020-07-28 11:02:09.677519+00	2020-07-28 11:32:22.804975+00	2020-09-15 06:13:39.693+00	\N		\N	\N	CCBYNCSA4.0	0	2020-07-28 11:02:09.677519+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	3	0	2021-03-26 11:42:52.364322+00
277	2020-06-09 10:11:31.459704+00	2020-06-12 10:36:29.182913+00	2020-06-15 05:15:57.142+00	\N		\N	\N	CCBY4.0	0	2020-06-09 10:11:31.459704+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	4	1	2021-03-26 11:38:58.601425+00
291	2020-06-30 07:23:54.641278+00	2020-06-30 09:58:16.228223+00	2020-06-30 09:58:16.23+00	\N		\N	\N	CCBY4.0	0	2020-06-30 07:23:54.641278+00	olehto@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	1	0	2020-12-14 13:38:19.126957+00
265	2020-05-14 05:12:45.622578+00	2020-05-14 05:15:23.666278+00	2020-05-14 05:15:23.671+00	\N		\N	\N	CCBYNC4.0	0	2020-05-14 05:12:45.622578+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	t	f	5.0	5.0	2	0	2021-03-26 11:38:52.40987+00
279	2020-06-09 10:28:36.548463+00	2020-07-24 06:45:03.729648+00	2020-10-29 08:10:48.35+00	\N		\N	\N	CCBY4.0	0	2020-06-09 10:28:36.548463+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	2020-10-31 07:02:22+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
310	2020-08-24 09:52:18.941695+00	2020-12-04 07:23:42.726337+00	2020-12-04 07:24:20.175+00	\N	2,5 kk	7	18	CCBY4.0	0	2020-08-24 09:52:18.941695+00	olehto@csc.fi	2028-03-02 22:00:00+00	f	t	t	f	f	f	f	f	\N	\N	4	0	2020-12-08 09:31:02.209133+00
207	2020-02-24 09:07:14.176169+00	2020-02-24 09:09:49.43964+00	2020-08-06 07:38:05.116135+00	\N		\N	\N	CCBY4.0	0	2020-02-24 09:07:14.176169+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	t	f	\N	3.0	19	0	2021-04-28 07:30:09.632068+00
275	2020-06-05 08:11:01.366393+00	2020-07-03 11:14:40.040464+00	2020-12-10 09:26:25.140494+00	\N		30	99	CCBYSA4.0	0	2020-06-05 08:11:01.366393+00	mroppone@csc.fi	2020-12-30 22:00:00+00	f	f	f	f	f	f	t	f	3.0	4.0	52	5	2020-12-14 13:51:52.328491+00
286	2020-06-22 06:05:13.992066+00	2020-06-22 06:07:31.13937+00	2020-06-22 06:07:31.142+00	\N		\N	\N	CCBY4.0	0	2020-06-22 06:05:13.992066+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	t	f	f	f	f	f	f	f	\N	\N	19	0	2021-04-28 07:30:29.933466+00
276	2020-06-05 09:04:37.621021+00	2020-06-05 09:06:41.016903+00	2020-06-05 09:06:41.019+00	\N		\N	\N	CCBY4.0	0	2020-06-05 09:04:37.621021+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	t	f	f	f	f	f	\N	\N	1	0	2021-03-22 13:38:29.917136+00
299	2020-07-27 08:02:18.319282+00	\N	2020-12-04 09:07:16.17076+00	\N		\N	\N		0	2020-07-27 08:02:18.319282+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	5	0	2021-05-05 11:54:04.242882+00
289	2020-06-25 06:03:44.141226+00	\N	2020-06-25 06:10:04.387428+00	\N		\N	\N		0	2020-06-25 06:03:44.141226+00	olehto@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	4	0	2021-03-04 13:14:17.596475+00
281	2020-06-09 11:28:07.711627+00	\N	2020-06-09 11:28:26.487674+00	\N		\N	\N		0	2020-06-09 11:28:07.711627+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	2	0	2021-03-19 06:17:29.073178+00
278	2020-06-09 10:22:25.734922+00	\N	2020-06-09 10:25:14.879099+00	\N		\N	\N		0	2020-06-09 10:22:25.734922+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	4	0	2021-03-19 06:17:41.539184+00
272	2020-06-04 12:02:52.257099+00	\N	2020-06-04 12:02:53.038924+00	\N		\N	\N		0	2020-06-04 12:02:52.257099+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	2	0	2021-03-22 13:29:01.962029+00
169	2020-01-23 12:18:58.657797+00	2020-07-03 11:30:39.205323+00	2020-07-07 07:38:06.589+00	\N		5	100	CCBYNCSA4.0	0	2020-01-23 12:18:58.657797+00	mroppone@csc.fi	2021-12-31 22:00:00+00	f	f	f	f	f	f	f	f	5.0	5.0	2	0	2021-03-26 11:03:54.48923+00
251	2020-04-27 05:48:57.246153+00	2021-03-19 06:16:59.064935+00	2021-03-19 06:16:59.069+00	\N		\N	\N	CCBY4.0	0	2020-04-27 05:48:57.246153+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	t	f	f	f	f	f	\N	\N	7	0	2021-03-26 11:36:07.179326+00
338	2020-09-10 07:28:34.441654+00	2020-09-10 07:30:56.137093+00	2020-09-10 07:30:56.14+00	\N		\N	\N	CCBYNCND4.0	0	2020-09-10 07:28:34.441654+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	2020-09-22 07:03:22+00	f	f	f	f	f	t	f	f	\N	\N	0	0	\N
319	2020-08-28 10:23:09.124055+00	\N	2020-08-28 10:23:09.757119+00	\N		\N	\N		0	2020-08-28 10:23:09.124055+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
320	2020-08-28 10:23:48.866389+00	\N	2020-08-28 10:23:49.568494+00	\N		\N	\N		0	2020-08-28 10:23:48.866389+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
321	2020-08-28 10:24:08.473387+00	\N	2020-08-28 10:24:08.542765+00	\N		\N	\N		0	2020-08-28 10:24:08.473387+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
322	2020-08-28 10:24:39.970048+00	\N	2020-08-28 10:24:40.791076+00	\N		\N	\N		0	2020-08-28 10:24:39.970048+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
323	2020-08-28 10:25:41.850606+00	\N	2020-08-28 10:25:41.912881+00	\N		\N	\N		0	2020-08-28 10:25:41.850606+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
324	2020-08-28 10:26:11.792934+00	\N	2020-08-28 10:26:11.867282+00	\N		\N	\N		0	2020-08-28 10:26:11.792934+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
368	2020-10-08 06:22:14.55664+00	2020-10-08 06:31:33.597647+00	2020-10-08 11:58:34.664+00	\N		\N	\N	CCBYNCND4.0	0	2020-10-08 06:22:14.55664+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	2	0	2021-03-26 10:57:36.752568+00
326	2020-08-28 10:27:30.884569+00	\N	2020-08-28 10:27:31.148245+00	\N		\N	\N		0	2020-08-28 10:27:30.884569+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
314	2020-08-28 09:34:50.947826+00	2020-08-28 09:35:56.188413+00	2020-08-28 09:35:56.191+00	\N		\N	\N	CCBYSA4.0	0	2020-08-28 09:34:50.947826+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	2	0	2021-04-23 07:59:06.785157+00
350	2020-09-10 08:36:20.408331+00	2020-09-10 08:37:12.417967+00	2020-09-10 08:37:12.42+00	\N		\N	\N	CCBY4.0	0	2020-09-10 08:36:20.408331+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	2020-09-22 08:34:54+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
168	2020-01-23 12:11:50.693915+00	2020-01-23 12:40:22.943219+00	2020-10-19 11:22:10.320193+00	\N		-1	-1	CCBY4.0	0	2020-01-23 12:11:50.693915+00	210281-9988	2022-05-10 11:07:57+00	f	f	f	f	t	f	f	f	\N	\N	42	1	2021-04-28 05:46:59.88002+00
358	2020-09-17 13:25:31.242032+00	2020-09-17 13:27:51.468479+00	2020-09-18 08:32:37.65+00	\N		\N	\N	CCBYNCND4.0	0	2020-09-17 13:25:31.242032+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	2020-09-21 13:24:30+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
315	2020-08-28 10:00:09.064317+00	2020-08-28 10:00:54.341063+00	2020-08-28 10:00:54.344+00	\N		\N	\N	CCBYND4.0	0	2020-08-28 10:00:09.064317+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
365	2020-10-01 04:53:41.871866+00	2020-10-01 04:55:39.90901+00	2020-10-09 07:32:01.829694+00	\N		\N	\N	CCBYNCND4.0	0	2020-10-01 04:53:41.871866+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	\N	f	f	f	f	f	t	f	f	\N	\N	16	0	2021-04-28 05:46:46.280939+00
360	2020-09-24 06:37:34.538329+00	2020-09-24 06:39:18.944656+00	2020-09-24 06:39:18.947+00	\N		1	16	CCBY4.0	0	2020-09-24 06:37:34.538329+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	\N	t	f	f	f	f	f	f	f	\N	\N	1	0	2020-12-02 21:31:58.311267+00
339	2020-09-10 07:32:09.461759+00	2020-09-10 07:33:30.761757+00	2020-09-10 07:33:30.766+00	\N		\N	\N	CCBYNCND4.0	0	2020-09-10 07:32:09.461759+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	2020-09-21 07:03:22+00	f	f	t	f	f	f	f	f	\N	\N	0	0	\N
357	2020-09-16 07:13:38.666106+00	\N	2020-12-04 09:06:42.957982+00	\N		\N	\N		0	2020-09-16 07:13:38.666106+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	2	0	2021-04-13 13:13:29.815855+00
353	2020-09-11 07:07:46.989406+00	\N	2020-09-11 07:07:47.336909+00	\N		\N	\N		0	2020-09-11 07:07:46.989406+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	1	0	2021-02-15 09:27:06.129276+00
362	2020-09-28 07:32:50.510985+00	2020-09-28 07:41:58.536631+00	2020-12-09 06:15:06.313+00	\N	1,25 h	\N	\N	CCBYNCSA4.0	0	2020-09-28 07:32:50.510985+00	anlindfo@csc.fi	\N	f	f	f	f	t	f	f	f	\N	\N	3	0	2020-12-14 13:52:01.907195+00
318	2020-08-28 10:16:15.043449+00	2020-08-28 10:17:40.233984+00	2020-08-28 10:18:20.601+00	\N		\N	\N	CCBY4.0	0	2020-08-28 10:16:15.043449+00	anlindfo@csc.fi	\N	f	f	t	f	f	f	f	f	3.0	5.0	1	0	2020-12-08 09:28:36.487481+00
337	2020-09-10 07:03:30.61322+00	2020-09-10 07:21:12.429387+00	2020-09-10 07:21:12.434+00	\N		\N	\N	CCBYNCND4.0	0	2020-09-10 07:03:30.61322+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	2020-09-15 07:03:22+00	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
325	2020-08-28 10:26:48.077959+00	\N	2020-09-22 12:25:53.11413+00	\N		\N	\N		0	2020-08-28 10:26:48.077959+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
355	2020-09-15 10:21:14.962642+00	2020-09-15 10:23:30.611303+00	2021-01-13 12:25:01.414+00	\N	tres	3	5	CCBY4.0	0	2020-09-15 10:21:14.962642+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	t	f	f	f	f	f	f	f	\N	\N	11	0	2021-03-26 11:03:46.024283+00
359	2020-09-23 07:15:44.497601+00	2021-03-19 06:19:19.888337+00	2021-03-19 06:19:19.892+00	\N		\N	\N	CCBY4.0	0	2020-09-23 07:15:44.497601+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	t	f	f	f	f	f	f	f	\N	\N	14	0	2021-03-26 11:36:11.425523+00
344	2020-09-10 07:57:09.473667+00	2020-09-10 07:58:04.96624+00	2020-09-10 07:58:04.97+00	\N		\N	\N	CCBY4.0	0	2020-09-10 07:57:09.473667+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	t	f	f	f	f	t	\N	\N	0	0	\N
348	2020-09-10 08:24:45.720766+00	2020-09-10 08:25:35.733225+00	2020-10-09 08:34:12.376438+00	\N		\N	\N	CCBY4.0	0	2020-09-10 08:24:45.720766+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	t	f	f	f	f	f	f	f	\N	\N	2	0	\N
347	2020-09-10 08:17:23.376072+00	2020-09-10 08:19:55.241801+00	2020-09-10 08:19:55.246+00	\N		\N	\N	CCBY4.0	0	2020-09-10 08:17:23.376072+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	0	1	2020-12-08 09:25:36.541772+00
345	2020-09-10 08:05:19.953939+00	2020-09-10 08:06:07.127027+00	2020-09-10 08:06:07.133+00	\N		\N	\N	CCBY4.0	0	2020-09-10 08:05:19.953939+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
352	2020-09-11 07:04:31.211908+00	\N	2020-09-11 07:04:31.522577+00	\N		\N	\N		0	2020-09-11 07:04:31.211908+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
363	2020-09-28 08:04:20.686181+00	2020-09-28 08:13:51.345463+00	2020-10-13 11:32:00.230595+00	\N		\N	\N	CCBYNCND4.0	0	2020-09-28 08:04:20.686181+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	\N	f	f	f	f	f	f	f	f	\N	\N	3	0	2021-03-26 11:37:00.205828+00
343	2020-09-10 07:51:49.959302+00	2020-09-10 07:52:33.381025+00	2020-09-10 07:52:33.384+00	\N		\N	\N	CCBY4.0	0	2020-09-10 07:51:49.959302+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	15	1	2021-03-26 10:57:42.089227+00
342	2020-09-10 07:48:07.600419+00	2020-09-10 07:49:00.333274+00	2020-09-10 07:49:00.336+00	\N		\N	\N	CCBY4.0	0	2020-09-10 07:48:07.600419+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	t	f	t	f	f	f	\N	\N	1	0	2020-11-30 09:30:53.825855+00
340	2020-09-10 07:37:41.451631+00	2020-09-10 07:38:43.859274+00	2020-09-10 07:38:43.863+00	\N		\N	\N	CCBYNCND4.0	0	2020-09-10 07:37:41.451631+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	t	f	f	f	f	f	f	f	\N	\N	0	1	2020-12-08 09:25:19.78168+00
354	2020-09-11 08:18:51.41084+00	2020-09-11 08:21:18.354575+00	2021-03-26 11:18:04.398+00	\N		5	\N	CCBY4.0	0	2020-09-11 08:18:51.41084+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	2020-07-31 21:00:00+00	f	f	f	f	f	f	f	f	\N	\N	55	0	2021-03-26 11:35:43.898551+00
346	2020-09-10 08:10:30.191719+00	2020-09-10 08:11:27.055025+00	2020-09-10 08:11:27.058+00	\N		\N	\N	CCBY4.0	0	2020-09-10 08:10:30.191719+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	t	f	f	f	f	f	\N	\N	0	0	\N
306	2020-08-03 11:31:59.748973+00	2020-08-03 11:46:28.607844+00	2021-04-22 07:07:46.338+00	\N		\N	\N	CCBY4.0	0	2020-08-03 11:31:59.748973+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	t	f	f	4.0	4.0	129	1	2021-04-28 07:30:47.333069+00
341	2020-09-10 07:43:26.57182+00	2020-09-10 07:44:19.310312+00	2020-09-10 07:44:19.314+00	\N		\N	\N	CCBY4.0	0	2020-09-10 07:43:26.57182+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	t	f	f	f	f	f	f	\N	\N	11	0	2021-03-26 11:37:52.812162+00
361	2020-09-24 11:08:24.864885+00	2020-09-24 11:15:01.648296+00	2020-09-24 11:15:01.652+00	\N		\N	\N	CCBYNCSA4.0	0	2020-09-24 11:08:24.864885+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	\N	f	f	f	f	f	f	f	f	\N	\N	1	0	2020-12-08 09:31:08.023747+00
316	2020-08-28 10:03:44.844607+00	2020-08-28 10:04:03.592243+00	2020-09-11 10:17:42.488+00	\N		\N	\N	CCBYNC4.0	0	2020-08-28 10:03:44.844607+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
317	2020-08-28 10:10:39.862365+00	2020-08-28 10:15:07.360891+00	2020-08-28 10:15:07.363+00	\N		\N	\N	CCBY4.0	0	2020-08-28 10:10:39.862365+00	anlindfo@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	2	0	2020-12-08 09:29:46.706125+00
312	2020-08-28 09:15:17.542564+00	2020-08-28 09:18:52.316079+00	2020-12-09 06:14:24.517+00	\N		\N	\N	CCBY4.0	0	2020-08-28 09:15:17.542564+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	\N	f	f	f	f	f	f	f	f	\N	\N	3	0	2021-04-28 06:18:35.509381+00
349	2020-09-10 08:31:40.260007+00	2020-09-10 08:32:28.874941+00	2021-01-18 08:28:47.43+00	\N		\N	\N	CCBY4.0	0	2020-09-10 08:31:40.260007+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	26	0	2021-02-16 09:23:37.657645+00
313	2020-08-28 09:26:52.106371+00	2020-08-28 09:28:00.63153+00	2020-09-24 06:35:06.425+00	\N		\N	\N	CCBY4.0	0	2020-08-28 09:26:52.106371+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	\N	f	f	f	f	t	f	f	f	\N	\N	0	0	\N
301	2020-07-28 09:36:20.25832+00	2020-08-28 08:49:26.205743+00	2020-08-28 08:49:26.212+00	\N		\N	\N	CCBY4.0	0	2020-07-28 09:36:20.25832+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	1	0	2020-10-21 12:35:05.740019+00
366	2020-10-01 05:13:53.954002+00	2020-10-01 05:15:27.052922+00	2020-10-13 05:23:06.332+00	\N		\N	\N	CCBYNCND4.0	0	2020-10-01 05:13:53.954002+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	\N	t	t	f	f	f	f	f	f	\N	\N	13	0	2021-04-28 05:46:46.284388+00
177	2020-01-29 07:28:16.601668+00	2020-04-14 11:53:19.448542+00	2020-06-10 09:51:55.36+00	\N	2,5 h	15	50	CCBY4.0	0	2020-01-29 07:28:16.601668+00	olehto@csc.fi	2021-12-30 22:00:00+00	f	f	f	f	t	f	t	t	\N	\N	12	0	2021-04-28 05:46:46.309018+00
387	2020-12-04 09:08:47.545781+00	\N	2020-12-04 09:09:33.877433+00	\N		\N	\N		0	2020-12-04 09:08:47.545781+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	8	0	2021-04-20 07:36:54.290672+00
379	2020-11-16 07:13:19.379819+00	\N	2020-11-16 07:13:19.379819+00	\N		\N	\N		0	2020-11-16 07:13:19.379819+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
367	2020-10-01 05:26:01.309597+00	2020-10-01 05:27:32.511912+00	2020-10-20 07:14:52.323+00	\N		\N	\N	CCBYNCND4.0	0	2020-10-01 05:26:01.309597+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	2020-10-20 07:13:25+00	f	f	f	f	f	f	t	f	\N	\N	0	0	\N
388	2020-12-04 10:27:59.261551+00	\N	2020-12-04 10:32:03.774126+00	\N		\N	\N		0	2020-12-04 10:27:59.261551+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
246	2020-04-14 11:54:30.648253+00	2020-04-14 11:56:55.749387+00	2020-10-13 05:21:28.358+00	\N		\N	\N	CCBY4.0	0	2020-04-14 11:54:30.648253+00	olehto@csc.fi	\N	f	f	t	f	f	f	f	f	\N	\N	15	0	2021-04-28 05:46:46.340449+00
386	2020-12-01 11:40:19.992872+00	\N	2020-12-10 11:34:46.685527+00	\N		\N	\N		0	2020-12-01 11:40:19.992872+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
171	2020-01-24 10:20:38.593122+00	2020-01-24 10:21:06.993808+00	2020-01-24 10:21:06.995+00	\N		-1	-1	CCBY4.0	0	2020-01-24 10:20:38.593122+00	teppo@yliopisto.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	13	0	2021-04-28 05:46:46.393294+00
383	2020-11-27 07:06:10.424462+00	\N	2020-11-27 07:06:16.574072+00	\N		\N	\N		0	2020-11-27 07:06:10.424462+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
371	2020-11-04 06:34:29.858998+00	\N	2020-11-04 06:34:30.847258+00	\N		\N	\N		0	2020-11-04 06:34:29.858998+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
372	2020-11-04 11:00:17.26285+00	\N	2020-11-04 11:00:17.26285+00	\N		\N	\N		0	2020-11-04 11:00:17.26285+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
375	2020-11-04 13:28:45.010508+00	\N	2020-11-04 13:28:45.54018+00	\N		\N	\N		0	2020-11-04 13:28:45.010508+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
376	2020-11-05 06:20:02.813262+00	\N	2020-11-05 06:20:02.813262+00	\N		\N	\N		0	2020-11-05 06:20:02.813262+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
377	2020-11-05 09:58:00.301069+00	\N	2020-11-05 09:58:00.301069+00	\N		\N	\N		0	2020-11-05 09:58:00.301069+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
384	2020-11-27 10:15:47.973317+00	\N	2020-11-27 10:15:49.159484+00	\N		\N	\N		0	2020-11-27 10:15:47.973317+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
356	2020-09-15 11:23:26.54294+00	2020-09-15 12:06:52.880356+00	2020-12-14 12:51:47.549+00	\N		10	15	CCBY4.0	0	2020-09-15 11:23:26.54294+00	210281-9988	2020-12-31 12:51:30+00	t	t	t	f	f	f	f	f	\N	\N	91	0	2021-04-28 05:46:46.399054+00
389	2020-12-17 06:21:11.462948+00	\N	2020-12-17 06:23:13.184432+00	\N		\N	\N		0	2020-12-17 06:21:11.462948+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
369	2020-10-13 05:24:47.137167+00	2020-10-13 05:27:15.108731+00	2020-10-15 05:40:04.064+00	\N	1 h	16	99	CCBYSA4.0	0	2020-10-13 05:24:47.137167+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	2020-10-22 05:22:07+00	f	f	f	f	f	f	f	f	\N	\N	1	0	2020-11-19 06:57:17.521522+00
380	2020-11-23 08:55:53.76215+00	2020-11-23 08:57:01.763716+00	2020-12-09 06:12:31.4+00	\N		\N	\N	CCBY4.0	0	2020-11-23 08:55:53.76215+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	\N	t	f	f	f	f	f	f	f	\N	\N	4	0	2020-12-01 09:19:35.892921+00
327	2020-09-03 07:44:52.527069+00	2020-09-03 07:46:03.68173+00	2020-12-09 06:13:46.488+00	\N		\N	\N	CCBY4.0	0	2020-09-03 07:44:52.527069+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	\N	f	f	f	f	f	f	f	f	\N	\N	2	0	2020-11-17 13:31:43.662889+00
110	2019-12-18 08:45:05.724972+00	2019-12-18 08:45:33.348065+00	2019-12-18 08:45:33.35+00	\N		-1	-1	CCBY4.0	0	2019-12-18 08:45:05.724972+00	teppo@yliopisto.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	21	0	2021-04-28 05:46:46.401472+00
208	2020-02-24 09:10:34.363254+00	2020-04-03 10:08:30.73742+00	2020-10-19 04:54:47.109857+00	\N		1	13	CCBY4.0	0	2020-02-24 09:10:34.363254+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	2020-05-04 21:00:00+00	t	f	f	f	f	t	f	f	\N	\N	16	0	2021-04-28 05:46:59.903359+00
374	2020-11-04 12:52:38.516618+00	\N	2020-12-09 12:32:28.845564+00	\N		\N	\N		0	2020-11-04 12:52:38.516618+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
370	2020-11-02 07:20:26.437862+00	2020-11-02 07:23:09.254259+00	2020-11-02 07:23:55.954+00	\N		\N	\N	CCBYNCND4.0	0	2020-11-02 07:20:26.437862+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	\N	t	f	f	f	f	f	f	f	\N	\N	4	0	2021-04-28 07:30:40.936529+00
111	2019-12-18 13:38:47.614614+00	2019-12-18 13:42:31.237338+00	2019-12-18 13:42:31.241+00	\N		-1	-1	CCBY4.0	0	2019-12-18 13:38:47.614614+00	teppo@yliopisto.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	21	0	2021-04-28 07:30:09.640327+00
373	2020-11-04 11:41:21.607926+00	\N	2020-12-09 13:27:27.531532+00	\N		\N	\N		0	2020-11-04 11:41:21.607926+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
391	2020-12-21 11:16:12.939496+00	2020-12-21 11:19:18.975586+00	2020-12-21 11:19:18.98+00	\N		\N	\N	CCBY4.0	0	2020-12-21 11:16:12.939496+00	anlindfo@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	6	0	2021-03-05 11:12:32.452148+00
390	2020-12-21 09:23:56.373171+00	2020-12-21 09:26:58.037296+00	2020-12-21 09:26:58.041+00	\N		\N	\N	CCBY4.0	0	2020-12-21 09:23:56.373171+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	\N	t	f	f	f	f	f	f	f	\N	\N	2	0	2021-03-26 11:37:39.217573+00
392	2021-01-12 12:24:41.960117+00	2021-01-12 12:30:05.052164+00	2021-01-12 12:30:05.056+00	\N		\N	\N	CCBY4.0	0	2021-01-12 12:24:41.960117+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	5	0	2021-03-25 12:28:53.814159+00
189	2020-02-13 12:35:47.439241+00	2020-02-13 12:37:46.502733+00	2020-10-19 04:54:47.164986+00	\N		-1	-1	CCBY4.0	0	2020-02-13 12:35:47.439241+00	210281-9988	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	20	0	2021-04-28 05:46:59.89206+00
309	2020-08-24 09:52:18.939995+00	2021-01-28 07:33:14.461331+00	2021-01-28 07:35:01.077+00	\N		\N	\N	CCBY4.0	0	2020-08-24 09:52:18.939995+00	olehto@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	18	0	2021-02-22 08:18:22.652604+00
396	2021-01-20 13:33:53.615717+00	2021-01-20 13:35:01.869099+00	2021-02-26 06:23:19.101+00	\N		\N	\N	CCBY4.0	0	2021-01-20 13:33:53.615717+00	MPASSOID.c6329e82913e265b3a79c11a043fdab8b06b1a9e	\N	f	f	f	f	f	f	f	f	\N	\N	71	1	2021-03-05 09:30:28.625418+00
395	2021-01-14 08:32:41.543574+00	2021-01-14 08:34:36.762869+00	2021-03-02 08:56:38.525+00	\N		18	\N	CCBY4.0	0	2021-01-14 08:32:41.543574+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	t	f	f	\N	\N	20	0	2021-03-25 12:29:36.144085+00
385	2020-11-27 11:58:30.507386+00	2020-12-10 07:59:13.14405+00	2020-12-10 07:59:13.147+00	\N		\N	\N	CCBYNCSA4.0	0	2020-11-27 11:58:30.507386+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	\N	f	f	f	f	f	f	f	f	\N	\N	2	0	2020-12-14 13:52:00.186088+00
398	2021-02-01 13:39:33.261323+00	\N	2021-02-04 09:23:45.34606+00	\N		\N	\N		0	2021-02-01 13:39:33.261323+00	MPASSOID.c6329e82913e265b3a79c11a043fdab8b06b1a9e	\N	f	f	f	f	f	f	f	f	\N	\N	9	0	2021-05-10 06:39:46.323885+00
397	2021-01-28 07:49:14.337468+00	\N	2021-01-28 07:49:21.156922+00	\N		\N	\N		0	2021-01-28 07:49:14.337468+00	MPASSOID.c6329e82913e265b3a79c11a043fdab8b06b1a9e	\N	f	f	f	f	f	f	f	f	\N	\N	12	0	2021-02-23 12:44:59.438281+00
393	2021-01-14 07:36:58.191968+00	2021-01-14 08:31:41.534787+00	2021-01-14 08:31:41.54+00	\N		14	\N	CCBY4.0	0	2021-01-14 07:36:58.191968+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	t	f	f	\N	\N	4	0	2021-02-15 13:48:22.443397+00
245	2020-04-14 06:37:32.988234+00	2020-04-27 06:03:53.113634+00	2020-10-19 11:32:16.641089+00	\N		\N	\N	CCBY4.0	0	2020-04-14 06:37:32.988234+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	t	f	f	4.0	2.0	35	0	2021-04-28 05:46:59.908763+00
394	2021-01-14 07:45:34.147362+00	2021-01-20 08:26:09.64579+00	2021-01-20 08:26:40.275+00	\N		\N	\N	CCBY4.0	0	2021-01-14 07:45:34.147362+00	olehto@csc.fi	\N	f	f	f	f	f	f	f	f	\N	\N	31	0	2021-02-15 11:27:34.674966+00
303	2020-07-28 09:39:48.097975+00	2020-08-04 06:51:48.398131+00	2020-10-13 06:01:27.513677+00	\N		7	\N	CCBY4.0	0	2020-07-28 09:39:48.097975+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	77	0	2021-04-28 07:30:47.332372+00
364	2020-09-28 09:25:50.284353+00	2020-09-28 09:30:02.970292+00	2020-12-09 06:13:13.902+00	\N		\N	\N	CCBYNCND4.0	0	2020-09-28 09:25:50.284353+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	\N	f	f	f	f	f	f	f	f	\N	\N	16	0	2021-04-28 05:46:46.313122+00
382	2020-11-24 09:15:00.353813+00	2020-11-24 09:16:14.632798+00	2020-11-26 09:32:04.216+00	\N		\N	\N	CCBYSA4.0	0	2020-11-24 09:15:00.353813+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	\N	f	f	f	f	f	t	f	f	\N	\N	22	2	2021-04-28 05:46:46.316255+00
381	2020-11-24 09:12:46.108971+00	2020-11-24 09:14:33.700146+00	2021-03-05 09:53:35.03+00	\N		\N	\N	CCBYSA4.0	0	2020-11-24 09:12:46.108971+00	anlindfo@csc.fi	\N	f	f	f	f	f	t	f	f	\N	\N	23	1	2021-04-28 05:46:46.329014+00
351	2020-09-11 06:26:44.755363+00	2020-09-11 06:35:51.713284+00	2020-11-02 09:53:34.926+00	\N		\N	12	CCBY4.0	1	2020-09-11 06:26:44.755363+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	2021-05-30 21:00:00+00	f	f	f	f	f	f	f	f	4.0	3.0	35	0	2021-02-02 06:18:56.550704+00
404	2021-03-16 08:57:26.389346+00	2021-03-16 08:58:10.961343+00	2021-03-16 08:58:10.964+00	\N		\N	\N	CCBY4.0	0	2021-03-16 08:57:26.389346+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	t	f	f	\N	\N	4	0	2021-03-16 11:41:56.558513+00
410	2021-04-14 13:36:42.234947+00	2021-04-14 13:37:31.956819+00	2021-04-14 13:38:05.288+00	\N		\N	\N	CCBY4.0	0	2021-04-14 13:36:42.234947+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	6	0	2021-04-14 13:38:05.44207+00
420	2021-05-10 05:10:01.17201+00	2021-05-10 05:57:14.373155+00	2021-05-10 07:51:20.331941+00	\N		\N	\N	CCBYNCND4.0	0	2021-05-10 05:10:01.17201+00	MPASSOID.c6329e82913e265b3a79c11a043fdab8b06b1a9e	\N	f	f	f	f	f	f	f	t	\N	\N	13	0	2021-05-10 05:57:51.483712+00
422	2021-05-10 08:18:56.154614+00	\N	2021-05-10 08:18:56.154614+00	\N		\N	\N		0	2021-05-10 08:18:56.154614+00	MPASSOID.c6329e82913e265b3a79c11a043fdab8b06b1a9e	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
405	2021-03-16 11:37:56.714742+00	2021-03-16 11:39:55.799753+00	2021-03-16 11:39:55.804+00	\N		\N	\N	CCBY4.0	0	2021-03-16 11:37:56.714742+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	t	f	\N	\N	8	0	2021-03-22 13:37:47.420947+00
402	2021-03-15 09:26:56.069946+00	2021-03-15 09:31:47.198561+00	2021-03-15 09:35:32.216+00	\N		\N	\N	CCBYSA4.0	0	2021-03-15 09:26:56.069946+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	15	0	2021-03-22 13:53:58.403887+00
421	2021-05-10 06:39:57.562978+00	\N	2021-05-10 06:39:57.562978+00	\N		\N	\N		0	2021-05-10 06:39:57.562978+00	MPASSOID.c6329e82913e265b3a79c11a043fdab8b06b1a9e	\N	f	f	f	f	f	f	f	f	\N	\N	2	0	2021-05-10 09:33:54.089657+00
409	2021-03-16 12:01:50.783989+00	2021-03-16 12:11:37.106231+00	2021-03-16 12:11:37.111+00	\N		\N	\N	CCBYNCSA4.0	0	2021-03-16 12:01:50.783989+00	anlindfo@csc.fi	\N	f	f	f	f	f	t	f	f	\N	\N	5	0	2021-03-26 11:03:20.250156+00
423	2021-05-10 09:46:14.677633+00	\N	2021-05-10 09:46:14.677633+00	\N		\N	\N		0	2021-05-10 09:46:14.677633+00	MPASSOID.c6329e82913e265b3a79c11a043fdab8b06b1a9e	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
407	2021-03-16 11:45:33.779798+00	2021-03-16 11:49:17.240519+00	2021-03-16 11:49:17.244+00	\N		\N	\N	CCBYNCND4.0	0	2021-03-16 11:45:33.779798+00	MPASSOID.c6329e82913e265b3a79c11a043fdab8b06b1a9e	\N	f	f	f	f	f	t	f	f	\N	\N	7	0	2021-03-26 11:03:26.925035+00
424	2021-05-10 10:36:34.84059+00	\N	2021-05-10 10:36:34.84059+00	\N		\N	\N		0	2021-05-10 10:36:34.84059+00	MPASSOID.c6329e82913e265b3a79c11a043fdab8b06b1a9e	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
399	2021-02-16 11:18:26.829939+00	2021-02-16 11:19:40.459987+00	2021-02-16 11:23:17.617+00	\N		\N	\N	CCBY4.0	0	2021-02-16 11:18:26.829939+00	MPASSOID.c6329e82913e265b3a79c11a043fdab8b06b1a9e	\N	t	f	f	f	f	f	f	f	\N	\N	8	0	2021-03-26 11:03:51.038003+00
400	2021-02-18 08:26:09.250707+00	2021-02-18 08:27:18.669307+00	2021-02-18 08:27:18.674+00	\N		\N	\N	CCBY4.0	0	2021-02-18 08:26:09.250707+00	MPASSOID.c6329e82913e265b3a79c11a043fdab8b06b1a9e	\N	t	f	f	f	f	f	f	f	\N	\N	8	0	2021-02-22 08:19:06.272756+00
401	2021-02-19 06:57:21.308883+00	2021-02-19 06:58:37.604335+00	2021-02-19 06:58:37.609+00	\N		\N	\N	CCBY4.0	0	2021-02-19 06:57:21.308883+00	MPASSOID.c6329e82913e265b3a79c11a043fdab8b06b1a9e	\N	f	f	f	f	f	f	f	f	\N	\N	5	0	2021-02-26 06:21:26.94693+00
280	2020-06-09 11:25:51.096127+00	\N	2020-06-09 11:26:10.360952+00	\N		\N	\N		0	2020-06-09 11:25:51.096127+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	2	0	2021-04-22 08:23:38.335687+00
408	2021-03-16 11:50:42.385971+00	2021-03-16 11:55:46.248451+00	2021-03-16 11:55:46.252+00	\N		\N	\N	CCBYNCND4.0	0	2021-03-16 11:50:42.385971+00	MPASSOID.c6329e82913e265b3a79c11a043fdab8b06b1a9e	\N	f	f	f	f	f	t	f	f	\N	\N	8	0	2021-03-26 11:04:06.315057+00
413	2021-04-23 05:43:41.587987+00	\N	2021-04-23 05:44:05.094226+00	\N		\N	\N		0	2021-04-23 05:43:41.587987+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	1	0	2021-04-23 05:55:41.416205+00
414	2021-04-23 06:03:08.124402+00	\N	2021-04-23 06:03:24.796836+00	\N		\N	\N		0	2021-04-23 06:03:08.124402+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
403	2021-03-16 08:54:40.086145+00	2021-03-16 08:55:49.346532+00	2021-03-16 08:55:49.35+00	\N		\N	\N	CCBYSA4.0	0	2021-03-16 08:54:40.086145+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	4	0	2021-03-16 11:41:47.514737+00
417	2021-04-23 06:12:41.003427+00	\N	2021-04-23 06:12:41.255288+00	\N		\N	\N		0	2021-04-23 06:12:41.003427+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
415	2021-04-23 06:04:57.258476+00	\N	2021-04-23 06:05:13.913697+00	\N		\N	\N		0	2021-04-23 06:04:57.258476+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	1	0	2021-04-23 06:21:16.838257+00
419	2021-04-23 06:41:46.47649+00	\N	2021-04-23 06:42:00.745627+00	\N		\N	\N		0	2021-04-23 06:41:46.47649+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	7	0	2021-05-05 08:23:39.023104+00
418	2021-04-23 06:29:36.416639+00	\N	2021-04-23 06:29:36.6802+00	\N		\N	\N		0	2021-04-23 06:29:36.416639+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	4	0	2021-04-23 07:20:26.258925+00
425	2021-05-10 11:13:06.636922+00	\N	2021-05-10 12:51:13.406258+00	\N		\N	\N		0	2021-05-10 11:13:06.636922+00	MPASSOID.c6329e82913e265b3a79c11a043fdab8b06b1a9e	\N	f	f	f	f	f	f	f	f	\N	\N	1	0	2021-05-10 11:40:31.001448+00
411	2021-04-14 14:15:07.005165+00	\N	2021-04-14 14:15:07.302027+00	\N		\N	\N		0	2021-04-14 14:15:07.005165+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	50	0	2021-04-22 08:45:30.331048+00
406	2021-03-16 11:40:25.030763+00	2021-03-16 11:41:40.001502+00	2021-04-23 05:23:00.45+00	\N		\N	\N	CCBYNCND4.0	0	2021-03-16 11:40:25.030763+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	t	f	f	\N	\N	19	0	2021-04-23 07:57:54.103183+00
426	2021-05-10 11:46:00.581518+00	\N	2021-05-10 13:51:15.393471+00	\N		\N	\N		0	2021-05-10 11:46:00.581518+00	MPASSOID.c6329e82913e265b3a79c11a043fdab8b06b1a9e	\N	f	f	f	f	f	f	f	f	\N	\N	0	0	\N
412	2021-04-23 05:38:49.341238+00	\N	2021-04-23 05:39:02.575796+00	\N		\N	\N		0	2021-04-23 05:38:49.341238+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	4	0	2021-04-23 08:00:28.328938+00
127	2019-12-20 12:01:39.251774+00	2019-12-20 12:02:16.998469+00	2019-12-20 12:02:17+00	\N		-1	-1	CCBY4.0	0	2019-12-20 12:01:39.251774+00	teppo@yliopisto.fi	9999-01-01 00:00:00+00	f	f	f	f	f	f	f	f	\N	\N	15	0	2021-04-28 05:46:46.227587+00
247	2020-04-16 10:20:39.176443+00	2020-04-16 10:31:47.239068+00	2020-07-17 06:53:36.845+00	\N	2 h	8	10	CCBY4.0	0	2020-04-16 10:20:39.176443+00	olehto@csc.fi	2021-05-01 21:00:00+00	t	f	t	f	t	f	f	f	2.0	2.0	32	0	2021-04-28 05:46:46.262966+00
378	2020-11-09 07:46:27.604685+00	2020-11-09 07:48:33.526959+00	2020-11-10 09:45:35.035871+00	\N		\N	\N	CCBY4.0	0	2020-11-09 07:46:27.604685+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	\N	f	f	f	f	f	f	f	f	\N	\N	22	0	2021-04-28 05:46:46.40951+00
271	2020-06-04 08:59:24.078722+00	2020-06-04 09:02:21.799+00	2020-10-19 05:52:52.124292+00	\N	4 h	12	15	CCBY4.0	0	2020-06-04 08:59:24.078722+00	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	2021-01-07 22:00:00+00	f	f	f	f	f	f	f	f	5.0	5.0	28	1	2021-04-28 05:46:59.938221+00
416	2021-04-23 06:09:50.357968+00	\N	2021-04-23 06:32:02.889257+00	\N		\N	\N		0	2021-04-23 06:09:50.357968+00	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	\N	f	f	f	f	f	f	f	f	\N	\N	20	0	2021-05-06 07:29:39.312925+00
\.


--
-- Data for Name: educationalmaterialversion; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.educationalmaterialversion (educationalmaterialid, publishedat, urn) FROM stdin;
300	2021-04-28 05:48:11.354	\N
95	2020-05-29 05:22:20.04	urn:nbn:fi:oerfi-202102_00022647_2
108	2019-12-17 11:26:03.193	urn:nbn:fi:oerfi-202102_00022649_0
111	2019-12-18 13:42:31.237	urn:nbn:fi:oerfi-202102_00022651_5
118	2019-12-19 08:17:06.079	urn:nbn:fi:oerfi-202102_00022654_2
127	2019-12-20 12:02:16.998	urn:nbn:fi:oerfi-202102_00022656_0
132	2020-01-10 11:47:14.87	urn:nbn:fi:oerfi-202102_00022658_8
139	2020-01-15 10:46:18.998	urn:nbn:fi:oerfi-202102_00022661_3
143	2020-01-16 10:24:17.752	urn:nbn:fi:oerfi-202102_00022665_9
160	2020-01-22 09:13:22.832	urn:nbn:fi:oerfi-202102_00022667_7
168	2020-01-23 12:40:22.943	urn:nbn:fi:oerfi-202102_00022669_5
169	2020-07-03 11:30:39.205	urn:nbn:fi:oerfi-202102_00022671_1
174	2020-01-28 10:56:08.825	urn:nbn:fi:oerfi-202102_00022673_9
176	2020-01-28 11:26:19.086	urn:nbn:fi:oerfi-202102_00022675_7
177	2020-04-14 11:53:19.449	urn:nbn:fi:oerfi-202102_00022677_5
183	2020-02-13 11:37:16.332	urn:nbn:fi:oerfi-202102_00022680_0
189	2020-02-13 12:37:46.503	urn:nbn:fi:oerfi-202102_00022682_8
200	2020-05-08 08:37:49.181	urn:nbn:fi:oerfi-202102_00022684_6
204	2020-02-24 08:45:34.679	urn:nbn:fi:oerfi-202102_00022689_1
207	2020-05-14 12:38:37.982	urn:nbn:fi:oerfi-202102_00022691_7
207	2020-05-14 12:17:10.916	urn:nbn:fi:oerfi-202102_00022694_4
207	2020-05-05 12:13:39.275	urn:nbn:fi:oerfi-202102_00022697_1
207	2020-05-14 12:43:00.553	urn:nbn:fi:oerfi-202102_00022700_6
207	2020-05-14 12:31:10.462	urn:nbn:fi:oerfi-202102_00022702_4
207	2020-05-14 12:36:33.389	urn:nbn:fi:oerfi-202102_00022704_2
207	2020-05-14 12:41:31.347	urn:nbn:fi:oerfi-202102_00022706_0
208	2020-04-03 10:08:30.737	urn:nbn:fi:oerfi-202102_00022709_7
215	2020-04-03 08:33:45.145	urn:nbn:fi:oerfi-202102_00022711_3
217	2020-04-07 06:28:43.153	urn:nbn:fi:oerfi-202102_00022714_0
222	2020-03-03 07:44:31.037	urn:nbn:fi:oerfi-202102_00022716_8
224	2020-03-05 17:02:39.648	urn:nbn:fi:oerfi-202102_00022718_6
230	2020-04-03 10:48:45.835	urn:nbn:fi:oerfi-202102_00022720_2
233	2020-05-27 07:14:19.189	urn:nbn:fi:oerfi-202102_00022722_0
234	2020-05-14 10:44:44.383	urn:nbn:fi:oerfi-202102_00022725_7
234	2020-05-14 11:56:31.25	urn:nbn:fi:oerfi-202102_00022727_5
235	2020-03-25 08:50:58.293	urn:nbn:fi:oerfi-202102_00022729_3
241	2020-05-08 11:14:55.458	urn:nbn:fi:oerfi-202102_00022731_9
241	2020-06-11 06:10:55.928	urn:nbn:fi:oerfi-202102_00022733_7
243	2020-04-22 10:06:12.336	urn:nbn:fi:oerfi-202102_00022736_4
246	2020-05-08 09:57:14.185	urn:nbn:fi:oerfi-202102_00022738_2
247	2020-05-05 12:00:07.604	urn:nbn:fi:oerfi-202102_00022740_8
247	2020-04-16 10:31:47.239	urn:nbn:fi:oerfi-202102_00022742_6
249	2020-04-27 05:58:02.969	urn:nbn:fi:oerfi-202102_00022744_4
249	2020-05-05 11:47:20.224	urn:nbn:fi:oerfi-202102_00022746_2
260	2020-05-07 12:04:27.778	urn:nbn:fi:oerfi-202102_00022748_0
260	2020-04-27 07:37:30.032	urn:nbn:fi:oerfi-202102_00022750_5
267	2020-07-17 06:52:22.684	urn:nbn:fi:oerfi-202102_00022753_2
268	2020-05-27 07:12:33.971	urn:nbn:fi:oerfi-202102_00022756_9
268	2020-07-08 08:18:22.025	urn:nbn:fi:oerfi-202102_00022759_6
271	2020-09-04 06:50:06.979	urn:nbn:fi:oerfi-202102_00022763_0
275	2020-12-01 11:42:01.043	urn:nbn:fi:oerfi-202102_00022765_8
275	2020-10-20 09:57:43.884	urn:nbn:fi:oerfi-202102_00022767_6
275	2020-07-03 11:16:29.734	urn:nbn:fi:oerfi-202102_00022770_1
275	2020-10-20 10:42:08.085	urn:nbn:fi:oerfi-202102_00022772_9
279	2020-07-24 06:45:03.73	urn:nbn:fi:oerfi-202102_00022774_7
282	2020-06-09 11:35:38.555	urn:nbn:fi:oerfi-202102_00022776_5
286	2020-06-22 06:07:31.139	urn:nbn:fi:oerfi-202102_00022779_2
288	2020-06-23 09:38:02.158	urn:nbn:fi:oerfi-202102_00022781_8
293	2020-07-03 11:10:48.338	urn:nbn:fi:oerfi-202102_00022784_5
300	2020-08-04 06:58:23.214	urn:nbn:fi:oerfi-202102_00022786_3
302	2020-08-05 08:43:39.286	urn:nbn:fi:oerfi-202102_00022788_1
306	2020-08-03 11:46:28.608	urn:nbn:fi:oerfi-202102_00022793_4
312	2020-08-28 09:18:52.316	urn:nbn:fi:oerfi-202102_00022795_2
312	2020-09-04 06:48:47.139	urn:nbn:fi:oerfi-202102_00022797_0
313	2020-08-28 10:20:31.917	urn:nbn:fi:oerfi-202102_00022799_8
314	2020-08-28 09:35:56.188	urn:nbn:fi:oerfi-202102_00022801_4
316	2020-08-28 10:04:03.592	urn:nbn:fi:oerfi-202102_00022803_2
317	2020-08-28 10:15:07.361	urn:nbn:fi:oerfi-202102_00022805_0
338	2020-09-10 07:30:56.137	urn:nbn:fi:oerfi-202102_00022810_3
340	2020-09-10 07:38:43.859	urn:nbn:fi:oerfi-202102_00022812_1
342	2020-09-10 07:49:00.333	urn:nbn:fi:oerfi-202102_00022814_9
344	2020-09-10 07:58:04.966	urn:nbn:fi:oerfi-202102_00022816_7
346	2020-09-10 08:11:27.055	urn:nbn:fi:oerfi-202102_00022818_5
348	2020-09-10 08:25:35.733	urn:nbn:fi:oerfi-202102_00022820_1
350	2020-09-10 08:37:12.418	urn:nbn:fi:oerfi-202102_00022822_9
354	2020-09-11 08:21:18.355	urn:nbn:fi:oerfi-202102_00022825_6
356	2020-10-05 10:35:36.165	urn:nbn:fi:oerfi-202102_00022828_3
358	2020-09-18 07:53:57.491	urn:nbn:fi:oerfi-202102_00022831_8
361	2020-09-24 11:15:01.648	urn:nbn:fi:oerfi-202102_00022834_5
363	2020-09-28 08:13:51.345	urn:nbn:fi:oerfi-202102_00022836_3
365	2020-10-01 06:24:22.437	urn:nbn:fi:oerfi-202102_00022838_1
366	2020-10-01 05:15:27.053	urn:nbn:fi:oerfi-202102_00022840_7
366	2020-10-01 06:38:03.058	urn:nbn:fi:oerfi-202102_00022842_5
368	2020-10-08 06:31:33.598	urn:nbn:fi:oerfi-202102_00022844_3
370	2020-11-02 07:23:55.951	urn:nbn:fi:oerfi-202102_00022846_1
378	2020-11-09 07:48:33.527	urn:nbn:fi:oerfi-202102_00022848_9
381	2020-11-24 09:14:33.7	urn:nbn:fi:oerfi-202102_00022850_4
382	2020-11-26 09:32:04.21	urn:nbn:fi:oerfi-202102_00022852_2
396	2021-02-16 11:15:43.37	urn:nbn:fi:oerfi-202102_00022859_5
355	2020-09-15 10:23:30.611	urn:nbn:fi:oerfi-202102_00022826_5
355	2021-01-13 12:25:01.408	urn:nbn:fi:oerfi-202101_00022579_5
393	2021-01-14 08:31:41.535	urn:nbn:fi:oerfi-202101_00022580_2
395	2021-01-14 08:34:36.763	urn:nbn:fi:oerfi-202101_00022581_1
395	2021-01-18 08:14:09.977	urn:nbn:fi:oerfi-202101_00022582_0
395	2021-01-18 08:16:24.068	urn:nbn:fi:oerfi-202101_00022583_9
349	2021-01-18 08:28:47.426	urn:nbn:fi:oerfi-202101_00022584_8
394	2021-01-20 08:26:09.646	urn:nbn:fi:oerfi-202101_00022585_7
394	2021-01-20 08:26:40.265	urn:nbn:fi:oerfi-202101_00022586_6
396	2021-01-20 13:35:01.869	urn:nbn:fi:oerfi-202101_00022587_5
309	2021-01-28 07:33:14.461	urn:nbn:fi:oerfi-202101_00022588_4
309	2021-01-28 07:34:18.877	urn:nbn:fi:oerfi-202101_00022589_3
309	2021-01-28 07:35:01.075	urn:nbn:fi:oerfi-202101_00022590_0
79	2020-05-29 05:24:05.25	urn:nbn:fi:oerfi-202102_00022645_4
83	2020-05-29 05:23:08.262	urn:nbn:fi:oerfi-202102_00022646_3
107	2019-12-17 10:22:23.659	urn:nbn:fi:oerfi-202102_00022648_1
110	2019-12-18 08:45:33.348	urn:nbn:fi:oerfi-202102_00022650_6
112	2019-12-18 13:44:10.406	urn:nbn:fi:oerfi-202102_00022652_4
117	2019-12-19 06:43:14.881	urn:nbn:fi:oerfi-202102_00022653_3
123	2019-12-19 12:07:17.863	urn:nbn:fi:oerfi-202102_00022655_1
128	2020-01-02 13:10:16.441	urn:nbn:fi:oerfi-202102_00022657_9
137	2020-01-15 06:51:19.803	urn:nbn:fi:oerfi-202102_00022659_7
138	2020-01-15 09:21:46.267	urn:nbn:fi:oerfi-202102_00022660_4
140	2020-01-16 07:46:46.231	urn:nbn:fi:oerfi-202102_00022662_2
141	2020-01-16 10:01:15.837	urn:nbn:fi:oerfi-202102_00022663_1
142	2020-01-16 10:06:59.427	urn:nbn:fi:oerfi-202102_00022664_0
144	2020-04-03 10:38:41.222	urn:nbn:fi:oerfi-202102_00022666_8
165	2020-01-23 10:09:10.236	urn:nbn:fi:oerfi-202102_00022668_6
169	2020-07-03 11:41:35.546	urn:nbn:fi:oerfi-202102_00022670_2
171	2020-01-24 10:21:06.994	urn:nbn:fi:oerfi-202102_00022672_0
175	2020-01-28 11:06:26.55	urn:nbn:fi:oerfi-202102_00022674_8
177	2020-06-10 09:50:47.133	urn:nbn:fi:oerfi-202102_00022676_6
178	2020-04-03 12:13:33.431	urn:nbn:fi:oerfi-202102_00022678_4
182	2020-02-12 09:03:17.748	urn:nbn:fi:oerfi-202102_00022679_3
184	2020-02-13 11:48:07.889	urn:nbn:fi:oerfi-202102_00022681_9
193	2020-02-18 06:14:46.537	urn:nbn:fi:oerfi-202102_00022683_7
202	2020-02-24 06:48:07.883	urn:nbn:fi:oerfi-202102_00022685_5
203	2020-05-05 11:53:55.81	urn:nbn:fi:oerfi-202102_00022686_4
203	2020-05-07 08:55:53.712	urn:nbn:fi:oerfi-202102_00022687_3
203	2020-02-24 06:52:10.285	urn:nbn:fi:oerfi-202102_00022688_2
207	2020-05-14 12:40:44.821	urn:nbn:fi:oerfi-202102_00022690_8
207	2020-05-14 12:05:36.749	urn:nbn:fi:oerfi-202102_00022692_6
207	2020-02-24 09:09:49.44	urn:nbn:fi:oerfi-202102_00022693_5
207	2020-05-14 11:54:08.008	urn:nbn:fi:oerfi-202102_00022695_3
207	2020-05-08 08:35:41.728	urn:nbn:fi:oerfi-202102_00022696_2
207	2020-05-14 12:39:35.461	urn:nbn:fi:oerfi-202102_00022698_0
207	2020-05-07 08:57:05.125	urn:nbn:fi:oerfi-202102_00022699_9
207	2020-05-08 08:34:29.744	urn:nbn:fi:oerfi-202102_00022701_5
207	2020-05-14 12:39:13.079	urn:nbn:fi:oerfi-202102_00022703_3
207	2020-05-14 12:04:47.045	urn:nbn:fi:oerfi-202102_00022705_1
207	2020-05-08 08:33:14.181	urn:nbn:fi:oerfi-202102_00022707_9
207	2020-05-08 08:32:13.314	urn:nbn:fi:oerfi-202102_00022708_8
208	2020-05-08 08:51:40.715	urn:nbn:fi:oerfi-202102_00022710_4
215	2020-05-05 12:01:41.481	urn:nbn:fi:oerfi-202102_00022712_2
216	2020-02-25 15:50:37.113	urn:nbn:fi:oerfi-202102_00022713_1
220	2020-04-03 11:11:08.016	urn:nbn:fi:oerfi-202102_00022715_9
223	2020-03-03 11:15:22.578	urn:nbn:fi:oerfi-202102_00022717_7
228	2020-05-28 14:24:07.427	urn:nbn:fi:oerfi-202102_00022719_5
231	2020-04-03 12:00:13.121	urn:nbn:fi:oerfi-202102_00022721_1
234	2020-04-15 08:02:45.761	urn:nbn:fi:oerfi-202102_00022723_9
234	2020-05-14 12:15:02.84	urn:nbn:fi:oerfi-202102_00022724_8
234	2020-05-14 10:43:49.944	urn:nbn:fi:oerfi-202102_00022726_6
234	2020-05-11 10:41:08.832	urn:nbn:fi:oerfi-202102_00022728_4
239	2020-04-08 07:27:43.518	urn:nbn:fi:oerfi-202102_00022730_0
241	2020-05-05 11:54:32.705	urn:nbn:fi:oerfi-202102_00022732_8
241	2020-05-08 11:15:47.244	urn:nbn:fi:oerfi-202102_00022734_6
241	2020-04-07 11:55:25.809	urn:nbn:fi:oerfi-202102_00022735_5
245	2020-04-27 06:03:53.114	urn:nbn:fi:oerfi-202102_00022737_3
246	2020-04-14 11:56:55.749	urn:nbn:fi:oerfi-202102_00022739_1
247	2020-05-05 11:59:12.933	urn:nbn:fi:oerfi-202102_00022741_7
249	2020-05-15 06:24:52.472	urn:nbn:fi:oerfi-202102_00022743_5
249	2020-05-14 12:49:13.505	urn:nbn:fi:oerfi-202102_00022745_3
257	2020-06-04 09:06:18.162	urn:nbn:fi:oerfi-202102_00022747_1
260	2020-05-07 08:52:30.191	urn:nbn:fi:oerfi-202102_00022749_9
263	2020-05-27 07:04:58.748	urn:nbn:fi:oerfi-202102_00022751_4
266	2020-05-14 08:31:03.81	urn:nbn:fi:oerfi-202102_00022752_3
267	2020-05-14 10:30:25.252	urn:nbn:fi:oerfi-202102_00022754_1
268	2020-07-03 08:10:39.197	urn:nbn:fi:oerfi-202102_00022755_0
268	2020-07-03 10:36:55.091	urn:nbn:fi:oerfi-202102_00022757_8
268	2020-07-09 10:40:18.934	urn:nbn:fi:oerfi-202102_00022758_7
268	2020-07-03 10:17:46.921	urn:nbn:fi:oerfi-202102_00022760_3
269	2020-05-27 07:15:46.571	urn:nbn:fi:oerfi-202102_00022761_2
270	2020-06-02 13:55:50.727	urn:nbn:fi:oerfi-202102_00022762_1
271	2020-06-04 09:02:21.799	urn:nbn:fi:oerfi-202102_00022764_9
275	2020-10-20 10:01:47.231	urn:nbn:fi:oerfi-202102_00022766_7
275	2020-11-04 08:48:24.335	urn:nbn:fi:oerfi-202102_00022768_5
275	2020-10-20 10:05:37.756	urn:nbn:fi:oerfi-202102_00022769_4
275	2020-10-20 10:42:59.722	urn:nbn:fi:oerfi-202102_00022771_0
277	2020-06-12 10:36:29.183	urn:nbn:fi:oerfi-202102_00022773_8
279	2020-09-17 06:53:26.748	urn:nbn:fi:oerfi-202102_00022775_6
284	2020-06-11 10:38:50.886	urn:nbn:fi:oerfi-202102_00022777_4
304	2020-09-15 06:13:39.691	urn:nbn:fi:oerfi-202102_00022791_6
327	2020-09-03 07:46:03.682	urn:nbn:fi:oerfi-202102_00022808_7
385	2020-12-10 07:59:13.144	urn:nbn:fi:oerfi-202102_00022853_1
285	2020-06-22 06:04:04.367	urn:nbn:fi:oerfi-202102_00022778_3
287	2020-06-22 08:00:48.101	urn:nbn:fi:oerfi-202102_00022780_9
290	2020-09-04 06:50:43.925	urn:nbn:fi:oerfi-202102_00022782_7
291	2020-06-30 09:58:16.228	urn:nbn:fi:oerfi-202102_00022783_6
296	2020-07-15 11:13:14.535	urn:nbn:fi:oerfi-202102_00022785_4
301	2020-08-28 08:49:26.206	urn:nbn:fi:oerfi-202102_00022787_2
303	2020-08-04 06:51:48.398	urn:nbn:fi:oerfi-202102_00022789_0
304	2020-07-28 11:32:22.805	urn:nbn:fi:oerfi-202102_00022790_7
306	2020-08-04 05:56:19.305	urn:nbn:fi:oerfi-202102_00022792_5
310	2020-12-04 07:23:42.726	urn:nbn:fi:oerfi-202102_00022794_3
312	2020-08-28 09:20:08.513	urn:nbn:fi:oerfi-202102_00022796_1
313	2020-08-28 10:21:18.651	urn:nbn:fi:oerfi-202102_00022798_9
313	2020-08-28 09:28:00.632	urn:nbn:fi:oerfi-202102_00022800_5
315	2020-08-28 10:00:54.341	urn:nbn:fi:oerfi-202102_00022802_3
316	2020-09-03 10:09:54.012	urn:nbn:fi:oerfi-202102_00022804_1
318	2020-08-28 10:17:40.234	urn:nbn:fi:oerfi-202102_00022806_9
318	2020-08-28 10:18:20.597	urn:nbn:fi:oerfi-202102_00022807_8
337	2020-09-10 07:21:12.429	urn:nbn:fi:oerfi-202102_00022809_6
339	2020-09-10 07:33:30.762	urn:nbn:fi:oerfi-202102_00022811_2
341	2020-09-10 07:44:19.31	urn:nbn:fi:oerfi-202102_00022813_0
343	2020-09-10 07:52:33.381	urn:nbn:fi:oerfi-202102_00022815_8
345	2020-09-10 08:06:07.127	urn:nbn:fi:oerfi-202102_00022817_6
347	2020-09-10 08:19:55.242	urn:nbn:fi:oerfi-202102_00022819_4
349	2020-09-10 08:32:28.875	urn:nbn:fi:oerfi-202102_00022821_0
351	2020-09-11 06:35:51.713	urn:nbn:fi:oerfi-202102_00022823_8
354	2021-01-13 09:42:30.767	urn:nbn:fi:oerfi-202102_00022824_7
355	2020-09-17 06:21:19.021	urn:nbn:fi:oerfi-202102_00022827_4
356	2020-09-15 12:06:52.88	urn:nbn:fi:oerfi-202102_00022829_2
358	2020-09-17 13:27:51.468	urn:nbn:fi:oerfi-202102_00022830_9
358	2020-09-17 13:32:07.832	urn:nbn:fi:oerfi-202102_00022832_7
360	2020-09-24 06:39:18.945	urn:nbn:fi:oerfi-202102_00022833_6
362	2020-09-28 07:41:58.537	urn:nbn:fi:oerfi-202102_00022835_4
364	2020-09-28 09:30:02.97	urn:nbn:fi:oerfi-202102_00022837_2
365	2020-10-01 04:55:39.909	urn:nbn:fi:oerfi-202102_00022839_0
366	2020-10-01 06:30:52.79	urn:nbn:fi:oerfi-202102_00022841_6
367	2020-10-01 05:27:32.512	urn:nbn:fi:oerfi-202102_00022843_4
369	2020-10-13 05:27:15.109	urn:nbn:fi:oerfi-202102_00022845_2
370	2020-11-02 07:23:09.254	urn:nbn:fi:oerfi-202102_00022847_0
380	2020-11-23 08:57:01.764	urn:nbn:fi:oerfi-202102_00022849_8
382	2020-11-24 09:16:14.633	urn:nbn:fi:oerfi-202102_00022851_3
390	2020-12-21 09:26:58.037	urn:nbn:fi:oerfi-202102_00022854_0
391	2020-12-21 11:19:18.976	urn:nbn:fi:oerfi-202102_00022855_9
392	2021-01-12 12:30:05.052	urn:nbn:fi:oerfi-202102_00022856_8
396	2021-02-16 11:16:10.896	urn:nbn:fi:oerfi-202102_00022860_2
399	2021-02-16 11:19:40.46	urn:nbn:fi:oerfi-202102_00022861_1
400	2021-02-18 08:27:18.669	urn:nbn:fi:oerfi-202102_00022862_0
401	2021-02-19 06:58:37.604	urn:nbn:fi:oerfi-202102_00022891_5
292	2021-02-24 10:05:36.469	urn:nbn:fi:oerfi-202102_00022893_3
396	2021-02-26 06:22:55.137	urn:nbn:fi:oerfi-202102_00022894_2
396	2021-02-26 06:23:19.098	urn:nbn:fi:oerfi-202102_00022895_1
395	2021-03-02 08:54:53.824	urn:nbn:fi:oerfi-202103_00022896_9
395	2021-03-02 08:56:38.522	urn:nbn:fi:oerfi-202103_00022897_8
402	2021-03-15 09:31:47.199	urn:nbn:fi:oerfi-202103_00022898_7
403	2021-03-16 08:55:49.347	urn:nbn:fi:oerfi-202103_00022899_6
404	2021-03-16 08:58:10.961	urn:nbn:fi:oerfi-202103_00022900_3
405	2021-03-16 11:39:55.8	urn:nbn:fi:oerfi-202103_00022901_2
406	2021-03-16 11:41:40.002	urn:nbn:fi:oerfi-202103_00022902_1
407	2021-03-16 11:49:17.241	urn:nbn:fi:oerfi-202103_00022903_0
408	2021-03-16 11:55:46.248	urn:nbn:fi:oerfi-202103_00022904_9
409	2021-03-16 12:11:37.106	urn:nbn:fi:oerfi-202103_00022905_8
251	2021-03-19 06:16:59.065	urn:nbn:fi:oerfi-202103_00022906_7
359	2021-03-19 06:19:19.888	urn:nbn:fi:oerfi-202103_00022907_6
354	2021-03-26 11:06:38.42	urn:nbn:fi:oerfi-202103_00022908_5
354	2021-03-26 11:18:04.394	urn:nbn:fi:oerfi-202103_00022909_4
410	2021-04-14 13:37:31.957	urn:nbn:fi:oerfi-202104_00022910_0
410	2021-04-14 13:38:05.285	urn:nbn:fi:oerfi-202104_00022911_9
420	2021-05-10 05:57:14.373	\N
\.


--
-- Data for Name: educationaluse; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.educationaluse (id, value, educationalmaterialid, educationalusekey) FROM stdin;
1	Interaktiivinen materiaali	1	80135e90-e23d-40e7-b375-7bc9871ed284
2	Opettajan materiaalit ja osaamisen kehittäminen	2	4f0a1a42-aa37-4275-9141-ef2e811dc8ff
3	Interaktiivinen materiaali	4	80135e90-e23d-40e7-b375-7bc9871ed284
4	Itsenäinen opiskelu	7	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
5	Opettajan materiaalit ja osaamisen kehittäminen	7	4f0a1a42-aa37-4275-9141-ef2e811dc8ff
6	Itsenäinen opiskelu	8	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
7	Opettajan materiaalit ja osaamisen kehittäminen	8	4f0a1a42-aa37-4275-9141-ef2e811dc8ff
8	Itsenäinen opiskelu	12	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
9	Opettajan materiaalit ja osaamisen kehittäminen	12	4f0a1a42-aa37-4275-9141-ef2e811dc8ff
10	Itsenäinen opiskelu	13	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
11	Opettajan materiaalit ja osaamisen kehittäminen	13	4f0a1a42-aa37-4275-9141-ef2e811dc8ff
12	Itsenäinen opiskelu	14	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
13	Opettajan materiaalit ja osaamisen kehittäminen	14	4f0a1a42-aa37-4275-9141-ef2e811dc8ff
14	Ohjeistus	18	69125b8d-8b43-4820-838e-daf145672c17
15	Opettajan materiaalit ja osaamisen kehittäminen	19	4f0a1a42-aa37-4275-9141-ef2e811dc8ff
16	Opettajan materiaalit ja osaamisen kehittäminen	20	4f0a1a42-aa37-4275-9141-ef2e811dc8ff
17	Itsenäinen opiskelu	23	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
18	Jatkotyöstettävä materiaali	23	b197309a-8194-4669-ad9d-f90f58368e5d
19	Opettajan materiaalit ja osaamisen kehittäminen	24	4f0a1a42-aa37-4275-9141-ef2e811dc8ff
20	Opettajan materiaalit ja osaamisen kehittäminen	43	4f0a1a42-aa37-4275-9141-ef2e811dc8ff
21	Itsenäinen opiskelu	44	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
23	Interaktiivinen materiaali	52	80135e90-e23d-40e7-b375-7bc9871ed284
27	Jatkotyöstettävä materiaali	16	b197309a-8194-4669-ad9d-f90f58368e5d
32	Opettajan materiaalit ja osaamisen kehittäminen	56	4f0a1a42-aa37-4275-9141-ef2e811dc8ff
33	Opettajan materiaalit ja osaamisen kehittäminen	57	4f0a1a42-aa37-4275-9141-ef2e811dc8ff
34	Itsenäinen opiskelu	54	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
35	Kurssimateriaali	54	cdad2dd2-c075-4630-91fa-79233306ba25
36	Arviointi	59	8643ab6e-8443-4ef8-b2d2-0c4440c0a671
37	Opettajan materiaalit ja osaamisen kehittäminen	61	4f0a1a42-aa37-4275-9141-ef2e811dc8ff
38	Itsenäinen opiskelu	61	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
39	Jatkotyöstettävä materiaali	67	b197309a-8194-4669-ad9d-f90f58368e5d
49	Kurssimateriaali	74	cdad2dd2-c075-4630-91fa-79233306ba25
50	Kurssimateriaali	75	cdad2dd2-c075-4630-91fa-79233306ba25
51	Opettajan materiaalit ja osaamisen kehittäminen	76	4f0a1a42-aa37-4275-9141-ef2e811dc8ff
52	Ohjeistus	77	69125b8d-8b43-4820-838e-daf145672c17
53	Itsenäinen opiskelu	78	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
54	Kurssimateriaali	97	cdad2dd2-c075-4630-91fa-79233306ba25
55	Arviointi	99	8643ab6e-8443-4ef8-b2d2-0c4440c0a671
56	Arviointi	100	8643ab6e-8443-4ef8-b2d2-0c4440c0a671
57	Kurssimateriaali	101	cdad2dd2-c075-4630-91fa-79233306ba25
58	Itsenäinen opiskelu	103	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
59	Arviointi	107	8643ab6e-8443-4ef8-b2d2-0c4440c0a671
60	Itsenäinen opiskelu	108	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
61	Opettajan materiaalit ja osaamisen kehittäminen	108	4f0a1a42-aa37-4275-9141-ef2e811dc8ff
62	Jatkotyöstettävä materiaali	110	b197309a-8194-4669-ad9d-f90f58368e5d
63	Arviointi	111	8643ab6e-8443-4ef8-b2d2-0c4440c0a671
64	Arviointi	112	8643ab6e-8443-4ef8-b2d2-0c4440c0a671
65	Itsenäinen opiskelu	117	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
66	Independent Study	118	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
67	Jatkotyöstettävä materiaali	123	b197309a-8194-4669-ad9d-f90f58368e5d
68	Arviointi	127	8643ab6e-8443-4ef8-b2d2-0c4440c0a671
69	Arviointi	128	8643ab6e-8443-4ef8-b2d2-0c4440c0a671
70	Interaktiivinen materiaali	128	80135e90-e23d-40e7-b375-7bc9871ed284
71	Kurssimateriaali	137	cdad2dd2-c075-4630-91fa-79233306ba25
72	Itsenäinen opiskelu	142	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
73	Opettajan materiaalit ja osaamisen kehittäminen	142	4f0a1a42-aa37-4275-9141-ef2e811dc8ff
74	Opettajan materiaalit ja osaamisen kehittäminen	143	4f0a1a42-aa37-4275-9141-ef2e811dc8ff
75	Itsenäinen opiskelu	143	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
78	Kurssimateriaali	160	cdad2dd2-c075-4630-91fa-79233306ba25
79	Itsenäinen opiskelu	160	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
80	Oppimiskokonaisuuden osa	160	7c6c5151-3155-4a7d-a8c2-033e249ccee2
81	Opettajan materiaalit ja osaamisen kehittäminen	168	4f0a1a42-aa37-4275-9141-ef2e811dc8ff
82	Itsenäinen opiskelu	168	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
83	Professional Support	176	4f0a1a42-aa37-4275-9141-ef2e811dc8ff
88	Itsenäinen opiskelu	183	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
89	Kurssimateriaali	184	cdad2dd2-c075-4630-91fa-79233306ba25
90	Interaktiivinen materiaali	189	80135e90-e23d-40e7-b375-7bc9871ed284
91	Oppimiskokonaisuuden osa	193	7c6c5151-3155-4a7d-a8c2-033e249ccee2
92	Ryhmätyö	193	4fcdf5aa-09f5-48dd-b505-a3c9734e15ed
97	Ryhmätyö	202	4fcdf5aa-09f5-48dd-b505-a3c9734e15ed
98	Oppimiskokonaisuuden osa	202	7c6c5151-3155-4a7d-a8c2-033e249ccee2
106	Kurssimateriaali	216	cdad2dd2-c075-4630-91fa-79233306ba25
107	Oppimiskokonaisuuden osa	216	7c6c5151-3155-4a7d-a8c2-033e249ccee2
112	Itsenäinen opiskelu	222	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
113	Arviointi	223	8643ab6e-8443-4ef8-b2d2-0c4440c0a671
114	Kursmaterial	224	cdad2dd2-c075-4630-91fa-79233306ba25
120	Arviointi	235	8643ab6e-8443-4ef8-b2d2-0c4440c0a671
277	Itsenäinen opiskelu	265	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
87	Interaktiivinen materiaali	178	80135e90-e23d-40e7-b375-7bc9871ed284
215	Jatkotyöstettävä materiaali	249	b197309a-8194-4669-ad9d-f90f58368e5d
104	Itsenäinen opiskelu	215	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
278	Opettajan materiaalit ja osaamisen kehittäminen	265	4f0a1a42-aa37-4275-9141-ef2e811dc8ff
108	Ohjeistus	217	69125b8d-8b43-4820-838e-daf145672c17
109	Jatkotyöstettävä materiaali	217	b197309a-8194-4669-ad9d-f90f58368e5d
115	Interaktiivinen materiaali	230	80135e90-e23d-40e7-b375-7bc9871ed284
279	Itsenäinen opiskelu	267	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
204	Ohjeistus	245	69125b8d-8b43-4820-838e-daf145672c17
205	Jatkotyöstettävä materiaali	245	b197309a-8194-4669-ad9d-f90f58368e5d
99	Jatkotyöstettävä materiaali	203	b197309a-8194-4669-ad9d-f90f58368e5d
203	Arviointi	239	8643ab6e-8443-4ef8-b2d2-0c4440c0a671
86	Opettajan materiaalit ja osaamisen kehittäminen	177	4f0a1a42-aa37-4275-9141-ef2e811dc8ff
76	Opettajan materiaalit ja osaamisen kehittäminen	144	4f0a1a42-aa37-4275-9141-ef2e811dc8ff
221	Interaktiivinen materiaali	260	80135e90-e23d-40e7-b375-7bc9871ed284
193	Itsenäinen opiskelu	241	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
116	Arviointi	231	8643ab6e-8443-4ef8-b2d2-0c4440c0a671
117	Oppimiskokonaisuuden osa	231	7c6c5151-3155-4a7d-a8c2-033e249ccee2
318	Arviointi	268	8643ab6e-8443-4ef8-b2d2-0c4440c0a671
100	Arviointi	203	8643ab6e-8443-4ef8-b2d2-0c4440c0a671
105	Jatkotyöstettävä materiaali	215	b197309a-8194-4669-ad9d-f90f58368e5d
219	Kurssimateriaali	260	cdad2dd2-c075-4630-91fa-79233306ba25
213	Itsenäinen opiskelu	247	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
102	Interaktiivinen materiaali	207	80135e90-e23d-40e7-b375-7bc9871ed284
214	Opettajan materiaalit ja osaamisen kehittäminen	247	4f0a1a42-aa37-4275-9141-ef2e811dc8ff
119	Jatkotyöstettävä materiaali	234	b197309a-8194-4669-ad9d-f90f58368e5d
118	Itsenäinen opiskelu	234	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
275	Itsenäinen opiskelu	264	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
101	Arviointi	207	8643ab6e-8443-4ef8-b2d2-0c4440c0a671
267	Itsenäinen opiskelu	200	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
220	Jatkotyöstettävä materiaali	260	b197309a-8194-4669-ad9d-f90f58368e5d
276	Jatkotyöstettävä materiaali	264	b197309a-8194-4669-ad9d-f90f58368e5d
319	Jatkotyöstettävä materiaali	261	b197309a-8194-4669-ad9d-f90f58368e5d
321	Ohjeistus	233	69125b8d-8b43-4820-838e-daf145672c17
322	Opettajan materiaalit ja osaamisen kehittäminen	269	4f0a1a42-aa37-4275-9141-ef2e811dc8ff
323	Oppimiskokonaisuuden osa	269	7c6c5151-3155-4a7d-a8c2-033e249ccee2
317	Groupwork	214	4fcdf5aa-09f5-48dd-b505-a3c9734e15ed
325	Arviointi	270	8643ab6e-8443-4ef8-b2d2-0c4440c0a671
333	Groupwork	257	4fcdf5aa-09f5-48dd-b505-a3c9734e15ed
334	Ohjeistus	276	69125b8d-8b43-4820-838e-daf145672c17
342	Oppimiskokonaisuuden osa	284	7c6c5151-3155-4a7d-a8c2-033e249ccee2
343	Itsenäinen opiskelu	277	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
345	Itsenäinen opiskelu	285	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
346	Opettajan materiaalit ja osaamisen kehittäminen	285	4f0a1a42-aa37-4275-9141-ef2e811dc8ff
347	Arviointi	286	8643ab6e-8443-4ef8-b2d2-0c4440c0a671
348	Itsenäinen opiskelu	287	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
353	Itsenäinen opiskelu	293	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
209	Kurssimateriaali	246	cdad2dd2-c075-4630-91fa-79233306ba25
366	Arviointi	296	8643ab6e-8443-4ef8-b2d2-0c4440c0a671
367	Itsenäinen opiskelu	296	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
368	Kurssimateriaali	296	cdad2dd2-c075-4630-91fa-79233306ba25
280	Opettajan materiaalit ja osaamisen kehittäminen	267	4f0a1a42-aa37-4275-9141-ef2e811dc8ff
376	Ohjeistus	294	69125b8d-8b43-4820-838e-daf145672c17
377	Interaktiivinen materiaali	297	80135e90-e23d-40e7-b375-7bc9871ed284
382	Arviointi	302	8643ab6e-8443-4ef8-b2d2-0c4440c0a671
332	Itsenäinen opiskelu	271	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
103	Kurssimateriaali	208	cdad2dd2-c075-4630-91fa-79233306ba25
381	Interaktiivinen materiaali	303	80135e90-e23d-40e7-b375-7bc9871ed284
349	Ohjeistus	288	69125b8d-8b43-4820-838e-daf145672c17
111	Ohjeistus	220	69125b8d-8b43-4820-838e-daf145672c17
110	Interaktiivinen materiaali	220	80135e90-e23d-40e7-b375-7bc9871ed284
375	Lagarbete	279	4fcdf5aa-09f5-48dd-b505-a3c9734e15ed
378	Ohjeistus	306	69125b8d-8b43-4820-838e-daf145672c17
335	Jatkotyöstettävä materiaali	282	b197309a-8194-4669-ad9d-f90f58368e5d
336	Itsenäinen opiskelu	282	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
439	Kurssimateriaali	362	cdad2dd2-c075-4630-91fa-79233306ba25
388	Ryhmätyö	317	4fcdf5aa-09f5-48dd-b505-a3c9734e15ed
389	Ohjeistus	318	69125b8d-8b43-4820-838e-daf145672c17
440	Ryhmätyö	362	4fcdf5aa-09f5-48dd-b505-a3c9734e15ed
441	Oppimiskokonaisuuden osa	362	7c6c5151-3155-4a7d-a8c2-033e249ccee2
412	Ohjeistus	348	69125b8d-8b43-4820-838e-daf145672c17
455	Itsenäinen opiskelu	368	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
456	Kurssimateriaali	368	cdad2dd2-c075-4630-91fa-79233306ba25
497	Kurssimateriaali	385	cdad2dd2-c075-4630-91fa-79233306ba25
401	Jatkotyöstettävä materiaali	337	b197309a-8194-4669-ad9d-f90f58368e5d
402	Kurssimateriaali	338	cdad2dd2-c075-4630-91fa-79233306ba25
403	Oppimiskokonaisuuden osa	339	7c6c5151-3155-4a7d-a8c2-033e249ccee2
404	Itsenäinen opiskelu	340	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
405	Ohjeistus	341	69125b8d-8b43-4820-838e-daf145672c17
406	Kurssimateriaali	342	cdad2dd2-c075-4630-91fa-79233306ba25
407	Kurssimateriaali	343	cdad2dd2-c075-4630-91fa-79233306ba25
408	Jatkotyöstettävä materiaali	344	b197309a-8194-4669-ad9d-f90f58368e5d
409	Ohjeistus	345	69125b8d-8b43-4820-838e-daf145672c17
410	Jatkotyöstettävä materiaali	346	b197309a-8194-4669-ad9d-f90f58368e5d
411	Kurssimateriaali	347	cdad2dd2-c075-4630-91fa-79233306ba25
414	Itsenäinen opiskelu	350	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
422	Jatkotyöstettävä materiaali	356	b197309a-8194-4669-ad9d-f90f58368e5d
449	Arviointi	366	8643ab6e-8443-4ef8-b2d2-0c4440c0a671
499	Arviointi	390	8643ab6e-8443-4ef8-b2d2-0c4440c0a671
500	Itsenäinen opiskelu	391	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
546	Interaktiivinen materiaali	409	80135e90-e23d-40e7-b375-7bc9871ed284
516	Ohjeistus	396	69125b8d-8b43-4820-838e-daf145672c17
547	Arviointi	251	8643ab6e-8443-4ef8-b2d2-0c4440c0a671
466	Ohjeistus	369	69125b8d-8b43-4820-838e-daf145672c17
428	Arviointi	358	8643ab6e-8443-4ef8-b2d2-0c4440c0a671
508	Itsenäinen opiskelu	395	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
450	Arviointi	367	8643ab6e-8443-4ef8-b2d2-0c4440c0a671
387	Lagarbete	313	4fcdf5aa-09f5-48dd-b505-a3c9734e15ed
437	Itsenäinen opiskelu	360	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
438	Arviointi	361	8643ab6e-8443-4ef8-b2d2-0c4440c0a671
477	Itsenäinen opiskelu	370	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
478	Kurssimateriaali	370	cdad2dd2-c075-4630-91fa-79233306ba25
481	Kurssimateriaali	378	cdad2dd2-c075-4630-91fa-79233306ba25
448	Arviointi	365	8643ab6e-8443-4ef8-b2d2-0c4440c0a671
483	Itsenäinen opiskelu	381	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
557	Ohjeistus	420	69125b8d-8b43-4820-838e-daf145672c17
484	Itsenäinen opiskelu	382	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
520	Arviointi	309	8643ab6e-8443-4ef8-b2d2-0c4440c0a671
487	Interaktiivinen materiaali	310	80135e90-e23d-40e7-b375-7bc9871ed284
482	Jatkotyöstettävä materiaali	380	b197309a-8194-4669-ad9d-f90f58368e5d
442	Ohjeistus	364	69125b8d-8b43-4820-838e-daf145672c17
394	Opettajan materiaalit ja osaamisen kehittäminen	327	4f0a1a42-aa37-4275-9141-ef2e811dc8ff
385	Opettajan materiaalit ja osaamisen kehittäminen	312	4f0a1a42-aa37-4275-9141-ef2e811dc8ff
421	Interaktiivinen materiaali	355	80135e90-e23d-40e7-b375-7bc9871ed284
507	Itsenäinen opiskelu	393	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
539	Ohjeistus	403	69125b8d-8b43-4820-838e-daf145672c17
540	Itsenäinen opiskelu	404	916b4cd8-949b-4f47-aaf6-0fcaae7a9ac8
541	Kurssimateriaali	405	cdad2dd2-c075-4630-91fa-79233306ba25
548	Arviointi	359	8643ab6e-8443-4ef8-b2d2-0c4440c0a671
413	Jatkotyöstettävä materiaali	349	b197309a-8194-4669-ad9d-f90f58368e5d
514	Arviointi	394	8643ab6e-8443-4ef8-b2d2-0c4440c0a671
543	Ohjeistus	407	69125b8d-8b43-4820-838e-daf145672c17
542	Ohjeistus	406	69125b8d-8b43-4820-838e-daf145672c17
530	Jatkotyöstettävä materiaali	399	b197309a-8194-4669-ad9d-f90f58368e5d
532	Kurssimateriaali	400	cdad2dd2-c075-4630-91fa-79233306ba25
533	Interaktiivinen materiaali	401	80135e90-e23d-40e7-b375-7bc9871ed284
544	Opettajan materiaalit ja osaamisen kehittäminen	407	4f0a1a42-aa37-4275-9141-ef2e811dc8ff
545	Jatkotyöstettävä materiaali	408	b197309a-8194-4669-ad9d-f90f58368e5d
416	Kurssimateriaali	354	cdad2dd2-c075-4630-91fa-79233306ba25
\.


--
-- Data for Name: inlanguage; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.inlanguage (id, inlanguage, url, educationalmaterialid) FROM stdin;
\.


--
-- Data for Name: isbasedon; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.isbasedon (id, author, url, materialname, educationalmaterialid) FROM stdin;
4	{"{\\"key\\":\\"virkkunenpivi\\",\\"value\\":\\"Virkkunen, Päivi\\"}"}	https://aoe.fi/#/demo/materiaali/19/kirjain%E2%80%93aanne-vastaavuus	Kirjain-äänne-vastaavuus	56
5	{"{\\"key\\":\\"virkkunenpivi\\",\\"value\\":\\"Virkkunen, Päivi\\"}"}	https://aoe.fi/#/demo/materiaali/18/opeta-kirjain%E2%80%93aanne-vastaavuutta	Opeta kirjain-äänne-vastaavuutta	54
6	{"{\\"key\\":\\"kaukokokeilija\\",\\"value\\":\\"Kauko, Kokeilija\\"}"}	https://aoe.fi/#/materiaali/4	Digipeda	77
7	{"{\\"key\\":\\"meiklinenmaija\\",\\"value\\":\\"Meikäläinen, Maija\\"}"}	https://aoe.fi/#/materiaali/5	Johdatus robotiikan opetukseen	78
8	{"{\\"key\\":\\"testaajaterhi\\",\\"value\\":\\"Testaaja, Terhi\\"}"}	https://aoe.fi/#/materiaali/4	Avoimet oppimateriaalit ABC	108
9	{"{\\"key\\":\\"testi\\",\\"value\\":\\"Testi\\"}"}	http://localhost:4200/#/materiaali/137	Testi 1	138
10	{"{\\"key\\":\\"testi2\\",\\"value\\":\\"Testi 2\\"}"}	http://localhost:4200/#/materiaali/1372	Testi 2	138
11	{fhgfgh}	https://demo.aoe.fi/#/materiaali/111	Järjestystesti	139
12	{asdasdasdfas}	https://demo.aoe.fi/#/materiaali/137	Testi	139
14	{"{\\"key\\":\\"fdsfsd\\",\\"value\\":\\"fdsfsd\\"}"}	https://demo.aoe.fi/#/lisaa-oppimateriaali/6	adsadas	171
16	\N	https://demo.aoe.fi/#/	Aoe	174
17	\N	https://demo.aoe.fi/#/lisatietoa	Aoe lisätietoa	174
18	\N	https://demo.aoe.fi/#/lisaa-oppimateriaali/6	Aasdsa	175
19	\N	https://demo.aoe.fi/#/lisaa-oppimateriaali/7	DASsdasdas	175
20	\N	https://www.opettajantekijanoikeus.fi/opas/	Opettajan tekijänoikeusopas	176
22	\N	https://www.opettajantekijanoikeus.fi/kopiokissa/osa4/	Opettajan tekijänoikeus	183
23	\N	https://avointiede.fi/fi/julistus	Oppimisen ABC	193
26	\N	https://avointiede.fi/fi/julistus	Testimatsku	202
29	\N	http://aoe.fi	materiaali testaukseen	216
30	\N	http://aoe.fi	Testauskäytännöt	216
31	\N	http://google.com	test	224
38	\N	https://avoimet.fi/oppimateriaalit	Avointen oppimateriaalien A ja Ö	284
39	\N	https://aoe.fi/#/materiaali/570	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin viverra erat et ex eleifend accumsani	296
40	\N	http://tämäonosoite-todella.fi	Materiaali kaikesta	317
41	\N	https://aoe.fi#/materiaali/649	iPad3 Purkaminen	361
43	\N	http://aoe.fi	Kokeilu	366
47	\N	http://aoe.fi	Kokija	369
48	\N	http://aoe.fi	Ruoka	369
44	\N	http://aoe.fi	Testi	367
45	\N	http://aoe.fi	Kokeilu	367
46	\N	http://aoe.fi	Uusi materiaali	367
57	\N	http://olli.fi/kevat	Kevätmateriaali	310
42	\N	https://demo.aoe.fi/#/muokkaa-oppimateriaalia/356/6	Testi	356
\.


--
-- Data for Name: isbasedonauthor; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.isbasedonauthor (id, authorname, isbasedonid) FROM stdin;
1	Virkkunen, Päivi	4
2	Virkkunen, Päivi	5
3	Kauko, Kokeilija	6
4	Meikäläinen, Maija	7
5	Testaaja, Terhi	8
6	Testi	9
7	Testi 2	10
8	fhgfgh	11
9	asdasdasdfas	12
11	fdsfsd	14
13	Meikäläinen, Matti	16
14	Teikäläinen, Teppo	16
15	Organisaatio Oy Ab	16
16	Seppo	17
17	asd	18
18	gdfg	18
19	jhgfhfg	18
20	fgh	19
21	jkhg	19
22	sfd	19
23	Toikkanen, Tarmo	20
24	Oksanen, Ville	20
26	Toikkanen, Tarmo	22
27	Kokeilija, Kokeinen	23
28	Testajaa, Testinen	23
29	Ohjeyhtiö	23
34	Kokeilija, Koekäyttäjä	26
35	Testailija, Testi	26
39	Metsänen, Maija	29
40	Metsänem, Kaika	29
41	Metsälä, Matti	30
42	Testaaja, Testi	31
51	Karviainen, Karri	38
52	Maija Mehiläinen	39
53	Kokeellinen, Koe	40
54	Oikarinen, Kirsi	41
56	Tekijäinen, Tekijä	43
63	Herkuttelija, Herkku	47
64	Tuskailija, Tuska	48
66	Kokeinen, Kokeilija	44
67	Huttunen, Humisija	45
68	Kuiskaaja, Kuisko	46
71	Lehto, Olli	57
72	Testi, Testinen	42
\.


--
-- Data for Name: keyword; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.keyword (id, value, educationalmaterialid, keywordkey) FROM stdin;
1	3D-elokuvat	1	//www.yso.fi/onto/yso/p25476
2	fonetiikka	2	//www.yso.fi/onto/yso/p4532
3	ääntäminen	2	//www.yso.fi/onto/yso/p7303
4	suunnittelumalli	2	suunnittelumalli
5	3D Studio MAX	4	//www.yso.fi/onto/yso/p16103
6	aallonpituus	4	//www.yso.fi/onto/yso/p702
7	ohjelmointi	7	//www.yso.fi/onto/yso/p4887
8	ohjelmointikielet	7	//www.yso.fi/onto/yso/p162
9	Python	7	//www.yso.fi/onto/yso/p13019
10	opiskelu	7	//www.yso.fi/onto/yso/p4781
11	itseopiskelu	7	//www.yso.fi/onto/yso/p14362
12	perusopetus	7	//www.yso.fi/onto/yso/p19327
13	tekoäly	8	//www.yso.fi/onto/yso/p2616
14	koneoppiminen	8	//www.yso.fi/onto/yso/p21846
15	neuroverkot	8	//www.yso.fi/onto/yso/p7292
16	logiikka	8	//www.yso.fi/onto/yso/p456
17	kognitiotiede	8	//www.yso.fi/onto/yso/p16969
18	kieliteknologia	8	//www.yso.fi/onto/yso/p6071
19	robotiikka	8	//www.yso.fi/onto/yso/p2615
20	tekoälyn filosofia	8	tekolynfilosofia
21	konenäkö	8	//www.yso.fi/onto/yso/p2618
22	luonnollinen kieli	8	//www.yso.fi/onto/yso/p26762
23	digipedagogiikka	12	digipedagogiikka
24	pedagogiikka	12	//www.yso.fi/onto/yso/p1584
25	TVT	12	tvt
26	tieto- ja viestintätekniikka	12	//www.yso.fi/onto/yso/p20743
27	digitaalisuus	13	digitaalisuus
28	teknologia	13	//www.yso.fi/onto/yso/p2339
29	tieto- ja viestintätekniikka	13	//www.yso.fi/onto/yso/p20743
30	digipedagogiikka	13	digipedagogiikka
31	oppiminen	14	//www.yso.fi/onto/yso/p2945
32	opetus	14	//www.yso.fi/onto/yso/p2630
33	oppimisprosessi	14	//www.yso.fi/onto/yso/p5103
34	oppimistehtävä	14	oppimistehtv
35	oppimisaktiviteetti	14	oppimisaktiviteetti
36	ohjaus (neuvonta ja opastus)	14	//www.yso.fi/onto/yso/p178
37	pedagogiikka	14	//www.yso.fi/onto/yso/p1584
38	oppimisympäristö	14	//www.yso.fi/onto/yso/p4835
39	aktivointi	14	//www.yso.fi/onto/yso/p17894
40	digipedagogiikka	14	digipedagogiikka
41	oppimistehtävä	18	oppimistehtv
42	pedagogiikka	18	//www.yso.fi/onto/yso/p1584
43	verkko-opetus	18	//www.yso.fi/onto/yso/p6621
44	digipedagogiikka	18	digipedagogiikka
45	aktiviteetti	18	aktiviteetti
46	oppiminen	18	//www.yso.fi/onto/yso/p2945
47	virtuaaliopetus	19	virtuaaliopetus
48	yhteisöllisyys	19	//www.yso.fi/onto/yso/p5522
49	suunnittelumalli	19	suunnittelumalli
50	virtuaaliopetus	20	virtuaaliopetus
51	yhteisöllisyys	20	//www.yso.fi/onto/yso/p5522
52	suunnittelumalli	20	suunnittelumalli
53	2-dieetti	23	//www.yso.fi/onto/yso/p27439
54	robotiikka	24	//www.yso.fi/onto/yso/p2615
55	automaatio	24	//www.yso.fi/onto/yso/p11477
56	sulautettu tietotekniikka	24	//www.yso.fi/onto/yso/p5461
57	ohjelmointi	24	//www.yso.fi/onto/yso/p4887
58	oppiminen	24	//www.yso.fi/onto/yso/p2945
59	opetus	24	//www.yso.fi/onto/yso/p2630
60	avoimet oppimateriaalit	43	//www.yso.fi/onto/yso/p28036
61	avoimuus	43	//www.yso.fi/onto/yso/p10569
62	pedagogiikka	43	//www.yso.fi/onto/yso/p1584
63	OER	43	oer
64	Oikosulkuvirta	44	oikosulkuvirta
67	3D-tulostimet	52	//www.yso.fi/onto/yso/p37917
77	kokeilu	16	//www.yso.fi/onto/yso/p13984
84	fonetiikka	56	//www.yso.fi/onto/yso/p4532
85	ääntäminen	56	//www.yso.fi/onto/yso/p7303
86	suunnittelumalli	56	suunnittelumalli
87	fonetiikka	57	//www.yso.fi/onto/yso/p4532
88	ääntäminen	57	//www.yso.fi/onto/yso/p7303
89	suunnittelumalli	57	suunnittelumalli
90	ääntäminen	54	//www.yso.fi/onto/yso/p7303
91	fonetiikka	54	//www.yso.fi/onto/yso/p4532
92	kieltenopetus	54	//www.yso.fi/onto/yso/p38117
93	3D-mallinnus	59	//www.yso.fi/onto/yso/p26739
94	oppiminen	61	//www.yso.fi/onto/yso/p2945
95	verkko-oppiminen	61	//www.yso.fi/onto/yso/p13627
96	pedagogiikka	61	//www.yso.fi/onto/yso/p1584
97	digipedagogiikka	61	digipedagogiikka
98	aktiviteetti	61	aktiviteetti
99	oppimistehtävä	61	oppimistehtv
100	ääneneristys	67	//www.yso.fi/onto/yso/p19194
107	2-dieetti	73	//www.yso.fi/onto/yso/p27439
108	3D Studio MAX	73	//www.yso.fi/onto/yso/p16103
109	3D-mallinnus	74	//www.yso.fi/onto/yso/p26739
110	3D-mallinnus	75	//www.yso.fi/onto/yso/p26739
111	tieto- ja viestintätekniikka	76	//www.yso.fi/onto/yso/p20743
112	digitaaliset taidot	76	digitaalisettaidot
113	digipedagogiikka	76	digipedagogiikka
114	oppimateriaali	77	//www.yso.fi/onto/yso/p157
115	3D-mallinnus	78	//www.yso.fi/onto/yso/p26739
116	aamupäivätoiminta	78	//www.yso.fi/onto/yso/p3522
117	3D Studio MAX	81	//www.yso.fi/onto/yso/p16103
118	2-dieetti	97	//www.yso.fi/onto/yso/p27439
119	2-dieetti	99	//www.yso.fi/onto/yso/p27439
120	3D Studio MAX	100	//www.yso.fi/onto/yso/p16103
121	3D-skannerit	101	//www.yso.fi/onto/yso/p37987
122	oppimateriaali	103	//www.yso.fi/onto/yso/p157
123	2-dieetti	107	//www.yso.fi/onto/yso/p27439
124	avoimet oppimateriaalit	108	//www.yso.fi/onto/yso/p28036
125	oppimistehtävät	108	oppimistehtvt
126	aallot	110	//www.yso.fi/onto/yso/p1191
127	aallot	111	//www.yso.fi/onto/yso/p1191
128	aarrelöydöt	111	//www.yso.fi/onto/yso/p10416
129	absurdi teatteri	111	//www.yso.fi/onto/yso/p25784
130	adventistit	111	//www.yso.fi/onto/yso/p38387
131	agnostisismi	111	//www.yso.fi/onto/yso/p11676
132	3D Studio MAX	112	//www.yso.fi/onto/yso/p16103
133	3D-mallinnus	117	//www.yso.fi/onto/yso/p26739
134	edcucation	118	edcucation
135	testaus	123	//www.yso.fi/onto/yso/p8471
136	2-dieetti	127	//www.yso.fi/onto/yso/p27439
137	2-dieetti	128	//www.yso.fi/onto/yso/p27439
138	3D Studio MAX	128	//www.yso.fi/onto/yso/p16103
139	2-dieetti	132	//www.yso.fi/onto/yso/p27439
140	aatedraamat	137	//www.yso.fi/onto/yso/p32610
141	älykkyystestit	138	//www.yso.fi/onto/yso/p5054
142	aakkoset	139	//www.yso.fi/onto/yso/p20945
143	Adobe Camera Raw	140	//www.yso.fi/onto/yso/p23138
144	älykkyystestit	141	//www.yso.fi/onto/yso/p5054
145	avoimuus	142	//www.yso.fi/onto/yso/p10569
146	avoimet oppimateriaalit	142	//www.yso.fi/onto/yso/p28036
147	digitaalinen oppimateriaali	142	//www.yso.fi/onto/yso/p3597
148	verkkojulkaiseminen	143	//www.yso.fi/onto/yso/p18440
149	avoimuus	143	//www.yso.fi/onto/yso/p10569
150	avoimet oppimateriaalit	143	//www.yso.fi/onto/yso/p28036
154	kone- ja tuotantotekniikka	160	konejatuotantotekniikka
155	mittaustekniikka	160	//www.yso.fi/onto/yso/p5635
156	mittavälineet	160	mittavlineet
157	työntömitta	160	tyntmitta
158	noonius-asteikko	160	nooniusasteikko
159	aapiset	165	//www.yso.fi/onto/yso/p17439
160	tekijänoikeus	168	//www.yso.fi/onto/yso/p2346
161	avoimuus	168	//www.yso.fi/onto/yso/p10569
162	avoimet oppimateriaalit	168	//www.yso.fi/onto/yso/p28036
163	aamupäivätoiminta	171	//www.yso.fi/onto/yso/p3522
165	aamu	174	//www.yso.fi/onto/yso/p16239
166	aamiaiset	175	//www.yso.fi/onto/yso/p14442
167	copyright	176	//www.yso.fi/onto/yso/p2346
168	open educational resources	176	//www.yso.fi/onto/yso/p28036
173	3D-mallinnus	182	//www.yso.fi/onto/yso/p26739
174	avoimet oppimateriaalit	183	//www.yso.fi/onto/yso/p28036
175	3D-tulostus	183	//www.yso.fi/onto/yso/p27475
176	2-dieetti	184	//www.yso.fi/onto/yso/p27439
177	Wijkin kartano	189	//www.yso.fi/onto/yso/p12873
169	avoimet oppimateriaalit	177	//www.yso.fi/onto/yso/p28036
172	2-dieetti	178	//www.yso.fi/onto/yso/p27439
170	tekijänoikeus	177	//www.yso.fi/onto/yso/p2346
178	asekokeet	189	//www.yso.fi/onto/yso/p412
179	aikuistyypin diabetes	189	//www.yso.fi/onto/yso/p8303
180	opetus	193	//www.yso.fi/onto/yso/p2630
181	oppiminen	193	//www.yso.fi/onto/yso/p2945
182	pedagogiikka	193	//www.yso.fi/onto/yso/p1584
183	uskontotiede	193	//www.yso.fi/onto/yso/p2976
184	aamupäivätoiminta	193	//www.yso.fi/onto/yso/p3522
185	vapaa sivistystyö	193	//www.yso.fi/onto/yso/p12170
192	aamu	202	//www.yso.fi/onto/yso/p16239
193	saavutettavuus	202	//www.yso.fi/onto/yso/p858
194	esteettömyys	202	//www.yso.fi/onto/yso/p16241
195	kokeellinen kirjallisuus	202	//www.yso.fi/onto/yso/p21541
200	äänenkuljetus	204	//www.yso.fi/onto/yso/p30134
210	aaltoenergia	216	//www.yso.fi/onto/yso/p7972
211	adenovirukset	216	//www.yso.fi/onto/yso/p19797
217	pedagogiikka	222	//www.yso.fi/onto/yso/p1584
218	2-dieetti	223	//www.yso.fi/onto/yso/p27439
219	3D-filmer	224	//www.yso.fi/onto/yso/p25476
228	2-dieetti	235	//www.yso.fi/onto/yso/p27439
383	testaus	249	//www.yso.fi/onto/yso/p8471
212	semanttinen web	217	//www.yso.fi/onto/yso/p21716
213	webometriikka	217	//www.yso.fi/onto/yso/p24771
214	linkkuveitset	217	//www.yso.fi/onto/yso/p16247
485	2-dieetti	266	//www.yso.fi/onto/yso/p27439
569	kokeilukoulut	268	//www.yso.fi/onto/yso/p14447
226	verkko-opetus	234	//www.yso.fi/onto/yso/p6621
227	verkkopedagogiikka	234	//www.yso.fi/onto/yso/p18442
225	avoimet oppimateriaalit	234	//www.yso.fi/onto/yso/p28036
368	2-dieetti	243	//www.yso.fi/onto/yso/p27439
384	validointi	249	//www.yso.fi/onto/yso/p20652
441	aallonpituus	200	//www.yso.fi/onto/yso/p702
369	4G-tekniikka	245	//www.yso.fi/onto/yso/p26235
370	äänirunous	245	//www.yso.fi/onto/yso/p29674
151	avoimet oppimateriaalit	144	//www.yso.fi/onto/yso/p28036
152	avoimuus	144	//www.yso.fi/onto/yso/p10569
153	verkkojulkaiseminen	144	//www.yso.fi/onto/yso/p18440
571	3D-mallinnus	263	//www.yso.fi/onto/yso/p26739
367	ääriolot	239	//www.yso.fi/onto/yso/p27785
220	Python	230	//www.yso.fi/onto/yso/p13019
390	adoptiolapset	260	//www.yso.fi/onto/yso/p28482
202	testaus	207	//www.yso.fi/onto/yso/p8471
224	testaus	231	//www.yso.fi/onto/yso/p8471
221	avoimet oppimateriaalit	231	//www.yso.fi/onto/yso/p28036
222	diginatiivit	231	//www.yso.fi/onto/yso/p27098
223	etäopiskelu	231	//www.yso.fi/onto/yso/p1267
459	testausmenetelmät	207	//www.yso.fi/onto/yso/p26360
209	aamiaismajoitus	215	//www.yso.fi/onto/yso/p18776
203	elintestamentti	207	//www.yso.fi/onto/yso/p11989
480	3D Studio MAX	264	//www.yso.fi/onto/yso/p16103
204	vieritestit	207	//www.yso.fi/onto/yso/p21060
481	saavutettavuus	265	//www.yso.fi/onto/yso/p858
201	protestantismi	207	//www.yso.fi/onto/yso/p5043
344	dokumenttielokuvat	241	//www.yso.fi/onto/yso/p13105
345	videoarvostelut	241	//www.yso.fi/onto/yso/p7231
199	astraaliuskonnot	203	//www.yso.fi/onto/yso/p19307
196	äänestyskäyttäytyminen	203	//www.yso.fi/onto/yso/p3223
382	ohjelmointi	249	//www.yso.fi/onto/yso/p4887
197	saavutettavuus	203	//www.yso.fi/onto/yso/p858
198	esteettömyys	203	//www.yso.fi/onto/yso/p16241
482	esteettömyys	265	//www.yso.fi/onto/yso/p16241
440	A-klinikat	200	//www.yso.fi/onto/yso/p10224
483	testaus	265	//www.yso.fi/onto/yso/p8471
484	verkkosivustot	265	//www.yso.fi/onto/yso/p4047
438	2-dieetti	261	//www.yso.fi/onto/yso/p27439
573	3D-mallinnus	233	//www.yso.fi/onto/yso/p26739
574	äänenmuodostus	233	//www.yso.fi/onto/yso/p6942
575	äänittäminen	269	//www.yso.fi/onto/yso/p1139
576	älykkyystestit	259	//www.yso.fi/onto/yso/p5054
577	3D-elokuvat	258	//www.yso.fi/onto/yso/p25476
579	supernovat	228	//www.yso.fi/onto/yso/p10347
568	2 diet	214	//www.yso.fi/onto/yso/p27439
581	2-dieetti	270	//www.yso.fi/onto/yso/p27439
593	aapa mires	257	//www.yso.fi/onto/yso/p17093
594	äänentoisto	276	//www.yso.fi/onto/yso/p1142
605	avoimet oppimateriaalit	284	//www.yso.fi/onto/yso/p28036
606	tekijänoikeudet	284	tekijnoikeudet
607	3D-elokuvat	277	//www.yso.fi/onto/yso/p25476
609	A-vitamiini	277	//www.yso.fi/onto/yso/p17998
610	ohjelmointi	285	//www.yso.fi/onto/yso/p4887
611	ohjelmointikielet	285	//www.yso.fi/onto/yso/p162
612	Python	285	//www.yso.fi/onto/yso/p13019
613	valokuvaus	286	//www.yso.fi/onto/yso/p1979
614	ohjelmistot	286	//www.yso.fi/onto/yso/p11291
615	saavutettavuus	287	//www.yso.fi/onto/yso/p858
618	2-dieetti	291	//www.yso.fi/onto/yso/p27439
622	3D-mallinnus	293	//www.yso.fi/onto/yso/p26739
623	tekijänoikeus	293	//www.yso.fi/onto/yso/p2346
626	tietoturva	169	//www.yso.fi/onto/yso/p5479
582	matematiikka	246	//www.yso.fi/onto/yso/p3160
583	differentiaalilaskenta	246	//www.yso.fi/onto/yso/p7856
647	3D-elokuvat	296	//www.yso.fi/onto/yso/p25476
648	3D-skannerit	296	//www.yso.fi/onto/yso/p37987
487	jatkuva oppiminen	267	jatkuvaoppiminen
634	italian kieli	267	//www.yso.fi/onto/yso/p9203
402	verkko-opetus	247	//www.yso.fi/onto/yso/p6621
644	vihviläkasvit	247	//www.yso.fi/onto/yso/p22904
645	soluhengitys	247	//www.yso.fi/onto/yso/p24868
659	johtosolukko	294	//www.yso.fi/onto/yso/p29420
660	3D Studio MAX	297	//www.yso.fi/onto/yso/p16103
591	3D-elokuvat	271	//www.yso.fi/onto/yso/p25476
661	3D-elokuvat	304	//www.yso.fi/onto/yso/p25476
205	3D-skannerit	208	//www.yso.fi/onto/yso/p37987
206	afrokuubalainen jazz	208	//www.yso.fi/onto/yso/p30059
215	monikielisyys	220	//www.yso.fi/onto/yso/p6720
624	kauppa- ja teollisuushallinto	275	//www.yso.fi/onto/yso/p9326
616	ääni (ihmisääni)	288	//www.yso.fi/onto/yso/p38058
617	podcast-lähetys	288	//www.yso.fi/onto/yso/p26481
216	pohjoinen	220	//www.yso.fi/onto/yso/p21104
234	umpilisäketulehdus	220	//www.yso.fi/onto/yso/p21507
657	mösti	279	msti
658	affärsidéer	279	//www.yso.fi/onto/yso/p14784
673	2-dieetti	302	//www.yso.fi/onto/yso/p27439
595	ohjelmointi	282	//www.yso.fi/onto/yso/p4887
596	testaus	282	//www.yso.fi/onto/yso/p8471
676	2-dieetti	301	//www.yso.fi/onto/yso/p27439
784	testaus	358	//www.yso.fi/onto/yso/p8471
689	aaltojohteet	316	//www.yso.fi/onto/yso/p38925
785	HTML	358	//www.yso.fi/onto/yso/p9170
677	video	312	//www.yso.fi/onto/yso/p8368
687	2-dieetti	314	//www.yso.fi/onto/yso/p27439
688	3D-mallinnus	315	//www.yso.fi/onto/yso/p26739
690	avoimet oppimateriaalit	317	//www.yso.fi/onto/yso/p28036
691	avoimuus	317	//www.yso.fi/onto/yso/p10569
692	avoin tieto	317	//www.yso.fi/onto/yso/p26655
693	testaus	318	//www.yso.fi/onto/yso/p8471
694	kotivideot	318	//www.yso.fi/onto/yso/p27771
678	valokuvausvälineet	312	//www.yso.fi/onto/yso/p6349
679	tekstitys	312	//www.yso.fi/onto/yso/p2597
853	luomuruoka	368	//www.yso.fi/onto/yso/p23647
685	3D-filmer	313	//www.yso.fi/onto/yso/p25476
686	accent	313	//www.yso.fi/onto/yso/p26811
671	2-dieetti	303	//www.yso.fi/onto/yso/p27439
771	2-dieetti	355	//www.yso.fi/onto/yso/p27439
207	yhteenkuuluvuus	208	//www.yso.fi/onto/yso/p22769
208	voimakkuus	208	//www.yso.fi/onto/yso/p22159
719	3D Studio MAX	290	//www.yso.fi/onto/yso/p16103
721	aallonpituus	290	//www.yso.fi/onto/yso/p702
808	demokratiakasvatus	362	demokratiakasvatus
809	yhteiskuntaoppi	362	//www.yso.fi/onto/yso/p7089
810	pelillisyys	362	pelillisyys
811	demokratiefostran	362	demokratiefostran
728	ääninauhat	337	//www.yso.fi/onto/yso/p9430
729	monivalintatehtävät	338	//www.yso.fi/onto/yso/p25895
730	3D-tulostimet	339	//www.yso.fi/onto/yso/p37917
731	aarrelöydöt	339	//www.yso.fi/onto/yso/p10416
732	terveysvaikutteiset elintarvikkeet	340	//www.yso.fi/onto/yso/p10973
733	tavat (tapakulttuuri)	341	//www.yso.fi/onto/yso/p7630
734	sovitus (koettaminen)	342	//www.yso.fi/onto/yso/p14835
735	opetusaineisto	343	//www.yso.fi/onto/yso/p12049
736	zulunkielinen kirjallisuus	344	//www.yso.fi/onto/yso/p29316
737	äänenkuljetus	345	//www.yso.fi/onto/yso/p30134
738	äänikasetit	346	//www.yso.fi/onto/yso/p12688
739	äänentallennuslaitteet	347	//www.yso.fi/onto/yso/p3429
742	valtionmetsät	350	//www.yso.fi/onto/yso/p11320
803	3D-tulostimet	313	//www.yso.fi/onto/yso/p37917
804	aallonpituus	360	//www.yso.fi/onto/yso/p702
751	äänenhuolto	354	//www.yso.fi/onto/yso/p20805
805	testaus	361	//www.yso.fi/onto/yso/p8471
592	zulunkielinen kirjallisuus	271	//www.yso.fi/onto/yso/p29316
806	video	361	//www.yso.fi/onto/yso/p8368
807	verkkovideot	361	//www.yso.fi/onto/yso/p22834
831	testaus	365	//www.yso.fi/onto/yso/p8471
813	yhteisöllisyys	363	//www.yso.fi/onto/yso/p5522
814	osaamisen jakaminen	363	osaamisenjakaminen
815	harrastuneisuus	363	harrastuneisuus
816	oppijalähtöinen	363	oppijalhtinen
817	työpajapäivä	363	typajapiv
832	varmenteet	365	//www.yso.fi/onto/yso/p14587
833	huolto	365	//www.yso.fi/onto/yso/p3283
834	varovaisuusperiaate	365	//www.yso.fi/onto/yso/p25951
835	päivitys	366	//www.yso.fi/onto/yso/p6715
836	pakettiautot	366	//www.yso.fi/onto/yso/p4854
740	säilöntä	348	//www.yso.fi/onto/yso/p5756
750	aateliskirjat	351	//www.yso.fi/onto/yso/p25881
818	demokratiakasvatus	364	demokratiakasvatus
741	aaltoliike	349	//www.yso.fi/onto/yso/p698
867	2-dieetti	369	//www.yso.fi/onto/yso/p27439
837	zouk	366	//www.yso.fi/onto/yso/p29886
838	jalokiviterapia	367	//www.yso.fi/onto/yso/p14577
839	jäsenistö	367	//www.yso.fi/onto/yso/p9758
868	erikoisruokavaliot	369	//www.yso.fi/onto/yso/p18295
819	osallisuus	364	//www.yso.fi/onto/yso/p5164
820	aktiivinen kansalainen	364	aktiivinenkansalainen
703	h5p	327	h5p
704	kotitehtävät	327	//www.yso.fi/onto/yso/p3928
705	laki julkisesta työvoimapalvelusta	327	//www.yso.fi/onto/yso/p21411
812	samhällslära	362	samhllslra
662	avoimet oppimateriaalit	306	//www.yso.fi/onto/yso/p28036
663	Avointen oppimateriaalien kirjasto	306	avointenoppimateriaalienkirjasto
664	verkkojulkaiseminen	306	//www.yso.fi/onto/yso/p18440
772	abbedissat	356	//www.yso.fi/onto/yso/p25521
773	asdkadkasdkasdka	356	asdkadkasdkasdka
672	äänestykset	300	//www.yso.fi/onto/yso/p3224
869	lähiruoka	369	//www.yso.fi/onto/yso/p11416
840	Pirkkalan hiihdot	367	//www.yso.fi/onto/yso/p24265
896	ääniteteollisuus	370	//www.yso.fi/onto/yso/p8351
897	Adobe InDesign	370	//www.yso.fi/onto/yso/p13073
898	afgaaninvinttikoira	370	//www.yso.fi/onto/yso/p22414
904	3D-tulostimet	378	//www.yso.fi/onto/yso/p37917
910	avoimet oppimateriaalit	382	//www.yso.fi/onto/yso/p28036
911	ammatillinen koulutus	382	//www.yso.fi/onto/yso/p9700
912	lukio	382	//www.yso.fi/onto/yso/p7401
913	maksuttomuus	382	//www.yso.fi/onto/yso/p3239
921	Jyväskylän kesä	310	//www.yso.fi/onto/yso/p23266
922	kesävaatteet	310	//www.yso.fi/onto/yso/p28502
923	kesänvietto	310	//www.yso.fi/onto/yso/p6940
905	3D-mallinnus	380	//www.yso.fi/onto/yso/p26739
680	monikielisyys	312	//www.yso.fi/onto/yso/p6720
947	raskas liikenne	385	//www.yso.fi/onto/yso/p9421
950	2-dieetti	390	//www.yso.fi/onto/yso/p27439
951	pappisvihkimys	391	//www.yso.fi/onto/yso/p2373
953	2-dieetti	392	//www.yso.fi/onto/yso/p27439
959	testaus	393	//www.yso.fi/onto/yso/p8471
960	lumityöt	393	//www.yso.fi/onto/yso/p24881
961	lumi-ilmasto	393	//www.yso.fi/onto/yso/p5638
962	lumiaurat	393	//www.yso.fi/onto/yso/p29334
1043	varhaiskasvatus	402	//www.yso.fi/onto/yso/p1650
1044	esiopetus	402	//www.yso.fi/onto/yso/p20272
1045	tutkin ja toimin ympäristössäni	402	tutkinjatoiminympristssni
1051	avoimuus	403	//www.yso.fi/onto/yso/p10569
1052	museoala	403	//www.yso.fi/onto/yso/p11606
1053	digitaaliset kirjastot	403	//www.yso.fi/onto/yso/p22354
1054	testaus	404	//www.yso.fi/onto/yso/p8471
1055	äidinkieli	405	//www.yso.fi/onto/yso/p10957
1056	kieltenopetus	405	//www.yso.fi/onto/yso/p38117
1057	kielikylpy	405	//www.yso.fi/onto/yso/p6135
981	2-dieetti	394	//www.yso.fi/onto/yso/p27439
1012	TEST	399	//www.yso.fi/onto/yso/p20469
1013	aallonpituus	399	//www.yso.fi/onto/yso/p702
1014	äänikuulutukset	399	//www.yso.fi/onto/yso/p38385
1018	älykkäät sähköverkot	400	//www.yso.fi/onto/yso/p29493
1019	sähkövirta	400	//www.yso.fi/onto/yso/p8876
1020	sähköyhtiöt	400	//www.yso.fi/onto/yso/p5562
1021	metadata	401	//www.yso.fi/onto/yso/p9319
1022	automaattinen sisällönkuvailu	401	//www.yso.fi/onto/yso/p27440
1023	ihminen-konejärjestelmät	401	//www.yso.fi/onto/yso/p6680
1024	2-dieetti	292	//www.yso.fi/onto/yso/p27439
995	2-dieetti	309	//www.yso.fi/onto/yso/p27439
984	oppimateriaali	396	//www.yso.fi/onto/yso/p157
985	saaristolaivasto	396	//www.yso.fi/onto/yso/p18987
1060	geologia	407	//www.yso.fi/onto/yso/p2179
1061	aluemaantiede	407	//www.yso.fi/onto/yso/p17912
1062	3D-tulostimet	408	//www.yso.fi/onto/yso/p37917
1063	Pattoin perintötalo	409	//www.yso.fi/onto/yso/p25491
1064	3D-elokuvat	251	//www.yso.fi/onto/yso/p25476
1065	zumba	359	//www.yso.fi/onto/yso/p24580
963	jääpeite	395	//www.yso.fi/onto/yso/p9352
964	jää	395	//www.yso.fi/onto/yso/p682
965	ikkunat	395	//www.yso.fi/onto/yso/p17133
966	testaus	395	//www.yso.fi/onto/yso/p8471
906	avoimet oppimateriaalit	381	//www.yso.fi/onto/yso/p28036
907	Creative Commons -lisenssit	381	//www.yso.fi/onto/yso/p38922
908	yhteisöllinen oppiminen	381	//www.yso.fi/onto/yso/p18727
909	digitaalinen oppimateriaali	381	//www.yso.fi/onto/yso/p3597
1041	matematiikka	402	//www.yso.fi/onto/yso/p3160
1042	LUMATIKKA	402	lumatikka
1068	4G-tekniikka	410	//www.yso.fi/onto/yso/p26235
1059	tekstijulkaisut	406	//www.yso.fi/onto/yso/p19418
1058	saavutettavuus	406	//www.yso.fi/onto/yso/p858
946	kuvailu	306	//www.yso.fi/onto/yso/p334
1092	auringonkukat (suku)	420	//www.yso.fi/onto/yso/p18223
1093	kuivakukat	420	//www.yso.fi/onto/yso/p13621
\.


--
-- Data for Name: keywordextension; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.keywordextension (id, value, educationalmaterialid, keywordkey, usersusername) FROM stdin;
5	3D-skannerit	275	//www.yso.fi/onto/yso/p37987	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD
6	3D-tulostimet	275	//www.yso.fi/onto/yso/p37917	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD
8	kaksoisagentit	351	//www.yso.fi/onto/yso/p22146	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0
9	myöhäiskeskiaika	351	//www.yso.fi/onto/yso/p13058	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0
10	trubaduurit (keskiaika)	351	//www.yso.fi/onto/yso/p3489	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0
11	varhaiskeskiaika	351	//www.yso.fi/onto/yso/p12352	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0
12	aallot	370	//www.yso.fi/onto/yso/p1191	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD
13	piraattituotteet	275	//www.yso.fi/onto/yso/p34410	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0
14	inspiraatio	275	//www.yso.fi/onto/yso/p9316	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0
15	open educational resources	306	//www.yso.fi/onto/yso/p28036	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0
16	collaborative learning	306	//www.yso.fi/onto/yso/p18727	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0
17	informal learning	306	//www.yso.fi/onto/yso/p28042	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0
18	virtual learning environments	306	//www.yso.fi/onto/yso/p26951	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0
19	oppimateriaali	306	//www.yso.fi/onto/yso/p157	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD
\.


--
-- Data for Name: learningresourcetype; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.learningresourcetype (id, value, educationalmaterialid, learningresourcetypekey) FROM stdin;
1	blogi	1	4eb2d87f-6d2e-4ba3-8fff-76085e6c1858
2	opas	2	a31e360b-86ea-4857-bdd7-ac5253e7c1ec
3	esitys	4	7be52f46-138d-482f-834e-5ea33d933c37
4	harjoitus	7	bf2c17a1-2f6f-4019-adb1-576e6caeebd9
5	opas	7	a31e360b-86ea-4857-bdd7-ac5253e7c1ec
6	teksti	8	cc1d00b0-b11f-4afe-a423-e43f96214f89
7	harjoitus	8	bf2c17a1-2f6f-4019-adb1-576e6caeebd9
8	sanasto	8	8376a0c7-118a-48a1-aa1f-b3ccaa41a978
9	audio	12	16d136da-d322-4028-9bda-53a3e7ebd5f6
10	teksti	12	cc1d00b0-b11f-4afe-a423-e43f96214f89
11	teksti	13	cc1d00b0-b11f-4afe-a423-e43f96214f89
12	video	13	c1256389-a47d-4a44-beb2-bdbbc79abb28
13	teksti	14	cc1d00b0-b11f-4afe-a423-e43f96214f89
14	video	14	c1256389-a47d-4a44-beb2-bdbbc79abb28
15	audio	18	16d136da-d322-4028-9bda-53a3e7ebd5f6
16	teksti	18	cc1d00b0-b11f-4afe-a423-e43f96214f89
17	esitys	19	7be52f46-138d-482f-834e-5ea33d933c37
18	opas	19	a31e360b-86ea-4857-bdd7-ac5253e7c1ec
19	opas	20	a31e360b-86ea-4857-bdd7-ac5253e7c1ec
20	sovellus	23	d41d5e9d-bbf0-45f5-9985-eba4feb385f0
21	teksti	24	cc1d00b0-b11f-4afe-a423-e43f96214f89
22	simulaatio	24	23122beb-cf92-4d77-9925-0677e9bdd32c
23	harjoitus	24	bf2c17a1-2f6f-4019-adb1-576e6caeebd9
24	projekti	24	ba288473-784b-4f5f-8231-2d0d782347aa
25	opas	43	a31e360b-86ea-4857-bdd7-ac5253e7c1ec
26	esitys	44	7be52f46-138d-482f-834e-5ea33d933c37
27	harjoitus	44	bf2c17a1-2f6f-4019-adb1-576e6caeebd9
29	blogi	52	4eb2d87f-6d2e-4ba3-8fff-76085e6c1858
33	harjoitus	16	bf2c17a1-2f6f-4019-adb1-576e6caeebd9
36	opas	56	a31e360b-86ea-4857-bdd7-ac5253e7c1ec
37	opas	57	a31e360b-86ea-4857-bdd7-ac5253e7c1ec
38	opas	54	a31e360b-86ea-4857-bdd7-ac5253e7c1ec
39	audio	59	16d136da-d322-4028-9bda-53a3e7ebd5f6
40	audio	61	16d136da-d322-4028-9bda-53a3e7ebd5f6
41	teksti	61	cc1d00b0-b11f-4afe-a423-e43f96214f89
42	sovellus	67	d41d5e9d-bbf0-45f5-9985-eba4feb385f0
49	esitys	73	7be52f46-138d-482f-834e-5ea33d933c37
50	esitys	74	7be52f46-138d-482f-834e-5ea33d933c37
51	harjoitus	75	bf2c17a1-2f6f-4019-adb1-576e6caeebd9
52	teksti	76	cc1d00b0-b11f-4afe-a423-e43f96214f89
53	esitys	77	7be52f46-138d-482f-834e-5ea33d933c37
54	teksti	78	cc1d00b0-b11f-4afe-a423-e43f96214f89
55	blogi	81	4eb2d87f-6d2e-4ba3-8fff-76085e6c1858
56	kaavio	97	e08cb0fc-14d7-4919-91e3-9981f25cc5ce
57	audio	99	16d136da-d322-4028-9bda-53a3e7ebd5f6
58	blogi	100	4eb2d87f-6d2e-4ba3-8fff-76085e6c1858
59	datasetti	101	a42b00b6-c2a7-407d-ba6b-8e7a4fb3e195
60	video	103	c1256389-a47d-4a44-beb2-bdbbc79abb28
61	teksti	103	cc1d00b0-b11f-4afe-a423-e43f96214f89
62	audio	107	16d136da-d322-4028-9bda-53a3e7ebd5f6
63	opas	108	a31e360b-86ea-4857-bdd7-ac5253e7c1ec
64	työkalu	110	1b5918b8-701b-48e6-aa2c-5feb3d7b3d60
65	blogi	111	4eb2d87f-6d2e-4ba3-8fff-76085e6c1858
66	blogi	112	4eb2d87f-6d2e-4ba3-8fff-76085e6c1858
67	esitys	117	7be52f46-138d-482f-834e-5ea33d933c37
68	weblog	118	4eb2d87f-6d2e-4ba3-8fff-76085e6c1858
69	harjoitus	123	bf2c17a1-2f6f-4019-adb1-576e6caeebd9
70	audio	127	16d136da-d322-4028-9bda-53a3e7ebd5f6
71	audio	128	16d136da-d322-4028-9bda-53a3e7ebd5f6
72	blogi	128	4eb2d87f-6d2e-4ba3-8fff-76085e6c1858
73	audio	132	16d136da-d322-4028-9bda-53a3e7ebd5f6
74	video	137	c1256389-a47d-4a44-beb2-bdbbc79abb28
75	datasetti	138	a42b00b6-c2a7-407d-ba6b-8e7a4fb3e195
76	harjoitus	139	bf2c17a1-2f6f-4019-adb1-576e6caeebd9
77	video	140	c1256389-a47d-4a44-beb2-bdbbc79abb28
78	datasetti	141	a42b00b6-c2a7-407d-ba6b-8e7a4fb3e195
79	video	142	c1256389-a47d-4a44-beb2-bdbbc79abb28
80	video	143	c1256389-a47d-4a44-beb2-bdbbc79abb28
82	harjoitus	160	bf2c17a1-2f6f-4019-adb1-576e6caeebd9
83	video	160	c1256389-a47d-4a44-beb2-bdbbc79abb28
84	esitys	165	7be52f46-138d-482f-834e-5ea33d933c37
85	opas	168	a31e360b-86ea-4857-bdd7-ac5253e7c1ec
86	datasetti	171	a42b00b6-c2a7-407d-ba6b-8e7a4fb3e195
88	harjoitus	174	bf2c17a1-2f6f-4019-adb1-576e6caeebd9
89	työkalu	175	1b5918b8-701b-48e6-aa2c-5feb3d7b3d60
90	guide	176	a31e360b-86ea-4857-bdd7-ac5253e7c1ec
94	blogi	182	4eb2d87f-6d2e-4ba3-8fff-76085e6c1858
95	opas	183	a31e360b-86ea-4857-bdd7-ac5253e7c1ec
96	video	183	c1256389-a47d-4a44-beb2-bdbbc79abb28
97	harjoitus	184	bf2c17a1-2f6f-4019-adb1-576e6caeebd9
98	datasetti	189	a42b00b6-c2a7-407d-ba6b-8e7a4fb3e195
99	blogi	193	4eb2d87f-6d2e-4ba3-8fff-76085e6c1858
100	kaavio	193	e08cb0fc-14d7-4919-91e3-9981f25cc5ce
101	kokeellinen työskentely	193	9ec6f06c-6cb4-45b4-a0f4-84e3a22a5999
102	projekti	193	ba288473-784b-4f5f-8231-2d0d782347aa
109	harjoitus	202	bf2c17a1-2f6f-4019-adb1-576e6caeebd9
110	kaavio	202	e08cb0fc-14d7-4919-91e3-9981f25cc5ce
111	sanasto	202	8376a0c7-118a-48a1-aa1f-b3ccaa41a978
112	työkalu	202	1b5918b8-701b-48e6-aa2c-5feb3d7b3d60
117	audio	204	16d136da-d322-4028-9bda-53a3e7ebd5f6
123	datasetti	216	a42b00b6-c2a7-407d-ba6b-8e7a4fb3e195
124	blogi	216	4eb2d87f-6d2e-4ba3-8fff-76085e6c1858
127	datasetti	222	a42b00b6-c2a7-407d-ba6b-8e7a4fb3e195
128	datasetti	223	a42b00b6-c2a7-407d-ba6b-8e7a4fb3e195
129	aktivitet	224	9ec6f06c-6cb4-45b4-a0f4-84e3a22a5999
135	audio	235	16d136da-d322-4028-9bda-53a3e7ebd5f6
301	blogi	266	4eb2d87f-6d2e-4ba3-8fff-76085e6c1858
355	kaavio	263	e08cb0fc-14d7-4919-91e3-9981f25cc5ce
120	wiki	207	f1668b11-5b5c-4a26-ac03-667ad5d0682f
118	audio	207	16d136da-d322-4028-9bda-53a3e7ebd5f6
270	datasetti	200	a42b00b6-c2a7-407d-ba6b-8e7a4fb3e195
215	harjoitus	247	bf2c17a1-2f6f-4019-adb1-576e6caeebd9
122	opas	215	a31e360b-86ea-4857-bdd7-ac5253e7c1ec
205	audio	239	16d136da-d322-4028-9bda-53a3e7ebd5f6
131	datasetti	231	a42b00b6-c2a7-407d-ba6b-8e7a4fb3e195
132	kuva	231	614834dc-b1b5-430e-ad43-94235d7db0f8
92	opas	177	a31e360b-86ea-4857-bdd7-ac5253e7c1ec
93	audio	178	16d136da-d322-4028-9bda-53a3e7ebd5f6
91	harjoitus	177	bf2c17a1-2f6f-4019-adb1-576e6caeebd9
81	video	144	c1256389-a47d-4a44-beb2-bdbbc79abb28
125	kaavio	217	e08cb0fc-14d7-4919-91e3-9981f25cc5ce
130	harjoitus	230	bf2c17a1-2f6f-4019-adb1-576e6caeebd9
218	audio	243	16d136da-d322-4028-9bda-53a3e7ebd5f6
207	kaavio	245	e08cb0fc-14d7-4919-91e3-9981f25cc5ce
208	harjoitus	245	bf2c17a1-2f6f-4019-adb1-576e6caeebd9
303	harjoitus	267	bf2c17a1-2f6f-4019-adb1-576e6caeebd9
373	diagram	257	e08cb0fc-14d7-4919-91e3-9981f25cc5ce
223	työkalu	260	1b5918b8-701b-48e6-aa2c-5feb3d7b3d60
224	wiki	260	f1668b11-5b5c-4a26-ac03-667ad5d0682f
225	teksti	260	cc1d00b0-b11f-4afe-a423-e43f96214f89
119	blogi	207	4eb2d87f-6d2e-4ba3-8fff-76085e6c1858
211	esitys	246	7be52f46-138d-482f-834e-5ea33d933c37
357	harjoitus	233	bf2c17a1-2f6f-4019-adb1-576e6caeebd9
382	harjoitus	284	bf2c17a1-2f6f-4019-adb1-576e6caeebd9
358	video	269	c1256389-a47d-4a44-beb2-bdbbc79abb28
133	esitys	234	7be52f46-138d-482f-834e-5ea33d933c37
297	blogi	264	4eb2d87f-6d2e-4ba3-8fff-76085e6c1858
116	kuva	203	614834dc-b1b5-430e-ad43-94235d7db0f8
113	työkalu	203	1b5918b8-701b-48e6-aa2c-5feb3d7b3d60
114	simulaatio	203	23122beb-cf92-4d77-9925-0677e9bdd32c
115	projekti	203	ba288473-784b-4f5f-8231-2d0d782347aa
298	datasetti	265	a42b00b6-c2a7-407d-ba6b-8e7a4fb3e195
299	video	265	c1256389-a47d-4a44-beb2-bdbbc79abb28
134	harjoitus	234	bf2c17a1-2f6f-4019-adb1-576e6caeebd9
359	video	259	c1256389-a47d-4a44-beb2-bdbbc79abb28
219	datasetti	249	a42b00b6-c2a7-407d-ba6b-8e7a4fb3e195
300	wiki	265	f1668b11-5b5c-4a26-ac03-667ad5d0682f
269	audio	261	16d136da-d322-4028-9bda-53a3e7ebd5f6
361	blogi	258	4eb2d87f-6d2e-4ba3-8fff-76085e6c1858
362	teksti	228	cc1d00b0-b11f-4afe-a423-e43f96214f89
352	activity	214	9ec6f06c-6cb4-45b4-a0f4-84e3a22a5999
364	audio	270	16d136da-d322-4028-9bda-53a3e7ebd5f6
374	kaavio	276	e08cb0fc-14d7-4919-91e3-9981f25cc5ce
216	esitys	247	7be52f46-138d-482f-834e-5ea33d933c37
195	video	241	c1256389-a47d-4a44-beb2-bdbbc79abb28
383	opas	284	a31e360b-86ea-4857-bdd7-ac5253e7c1ec
384	datasetti	277	a42b00b6-c2a7-407d-ba6b-8e7a4fb3e195
386	harjoitus	285	bf2c17a1-2f6f-4019-adb1-576e6caeebd9
387	video	285	c1256389-a47d-4a44-beb2-bdbbc79abb28
388	opas	285	a31e360b-86ea-4857-bdd7-ac5253e7c1ec
389	datasetti	286	a42b00b6-c2a7-407d-ba6b-8e7a4fb3e195
390	kuva	286	614834dc-b1b5-430e-ad43-94235d7db0f8
391	datasetti	287	a42b00b6-c2a7-407d-ba6b-8e7a4fb3e195
393	audio	291	16d136da-d322-4028-9bda-53a3e7ebd5f6
397	datasetti	293	a42b00b6-c2a7-407d-ba6b-8e7a4fb3e195
400	teksti	169	cc1d00b0-b11f-4afe-a423-e43f96214f89
353	blogi	268	4eb2d87f-6d2e-4ba3-8fff-76085e6c1858
420	esitys	296	7be52f46-138d-482f-834e-5ea33d933c37
421	harjoitus	296	bf2c17a1-2f6f-4019-adb1-576e6caeebd9
302	opas	267	a31e360b-86ea-4857-bdd7-ac5253e7c1ec
217	opas	247	a31e360b-86ea-4857-bdd7-ac5253e7c1ec
431	kaavio	294	e08cb0fc-14d7-4919-91e3-9981f25cc5ce
432	datasetti	297	a42b00b6-c2a7-407d-ba6b-8e7a4fb3e195
372	datasetti	271	a42b00b6-c2a7-407d-ba6b-8e7a4fb3e195
433	audio	304	16d136da-d322-4028-9bda-53a3e7ebd5f6
290	harjoitus	208	bf2c17a1-2f6f-4019-adb1-576e6caeebd9
126	sovellus	220	d41d5e9d-bbf0-45f5-9985-eba4feb385f0
392	audio	288	16d136da-d322-4028-9bda-53a3e7ebd5f6
398	esitys	275	7be52f46-138d-482f-834e-5ea33d933c37
430	aktivitet	279	9ec6f06c-6cb4-45b4-a0f4-84e3a22a5999
439	audio	302	16d136da-d322-4028-9bda-53a3e7ebd5f6
375	datasetti	282	a42b00b6-c2a7-407d-ba6b-8e7a4fb3e195
441	audio	301	16d136da-d322-4028-9bda-53a3e7ebd5f6
510	teksti	356	cc1d00b0-b11f-4afe-a423-e43f96214f89
445	datasetti	314	a42b00b6-c2a7-407d-ba6b-8e7a4fb3e195
446	datasetti	315	a42b00b6-c2a7-407d-ba6b-8e7a4fb3e195
448	video	317	c1256389-a47d-4a44-beb2-bdbbc79abb28
449	datasetti	318	a42b00b6-c2a7-407d-ba6b-8e7a4fb3e195
450	video	318	c1256389-a47d-4a44-beb2-bdbbc79abb28
617	audio	390	16d136da-d322-4028-9bda-53a3e7ebd5f6
555	harjoitus	368	bf2c17a1-2f6f-4019-adb1-576e6caeebd9
556	esitys	368	7be52f46-138d-482f-834e-5ea33d933c37
618	datasetti	391	a42b00b6-c2a7-407d-ba6b-8e7a4fb3e195
444	föreläsning	313	73bed523-aa9b-4463-8bed-3b31ce3a927a
465	blogi	290	4eb2d87f-6d2e-4ba3-8fff-76085e6c1858
620	blogi	392	4eb2d87f-6d2e-4ba3-8fff-76085e6c1858
470	harjoitus	337	bf2c17a1-2f6f-4019-adb1-576e6caeebd9
471	harjoitus	338	bf2c17a1-2f6f-4019-adb1-576e6caeebd9
472	harjoitus	339	bf2c17a1-2f6f-4019-adb1-576e6caeebd9
473	kaavio	340	e08cb0fc-14d7-4919-91e3-9981f25cc5ce
474	harjoitus	340	bf2c17a1-2f6f-4019-adb1-576e6caeebd9
475	harjoitus	341	bf2c17a1-2f6f-4019-adb1-576e6caeebd9
476	harjoitus	342	bf2c17a1-2f6f-4019-adb1-576e6caeebd9
477	harjoitus	343	bf2c17a1-2f6f-4019-adb1-576e6caeebd9
478	kaavio	344	e08cb0fc-14d7-4919-91e3-9981f25cc5ce
479	harjoitus	345	bf2c17a1-2f6f-4019-adb1-576e6caeebd9
480	kaavio	346	e08cb0fc-14d7-4919-91e3-9981f25cc5ce
481	harjoitus	347	bf2c17a1-2f6f-4019-adb1-576e6caeebd9
484	audio	350	16d136da-d322-4028-9bda-53a3e7ebd5f6
526	blogi	313	4eb2d87f-6d2e-4ba3-8fff-76085e6c1858
530	esitys	360	7be52f46-138d-482f-834e-5ea33d933c37
531	video	361	c1256389-a47d-4a44-beb2-bdbbc79abb28
533	työkalu	363	1b5918b8-701b-48e6-aa2c-5feb3d7b3d60
447	esitys	316	7be52f46-138d-482f-834e-5ea33d933c37
542	sanasto	366	8376a0c7-118a-48a1-aa1f-b3ccaa41a978
543	opas	366	a31e360b-86ea-4857-bdd7-ac5253e7c1ec
544	työkalu	366	1b5918b8-701b-48e6-aa2c-5feb3d7b3d60
596	kaavio	378	e08cb0fc-14d7-4919-91e3-9981f25cc5ce
598	esitys	381	7be52f46-138d-482f-834e-5ea33d933c37
483	esitys	349	7be52f46-138d-482f-834e-5ea33d933c37
540	harjoitus	365	bf2c17a1-2f6f-4019-adb1-576e6caeebd9
599	esitys	382	7be52f46-138d-482f-834e-5ea33d933c37
541	kaavio	365	e08cb0fc-14d7-4919-91e3-9981f25cc5ce
517	datasetti	358	a42b00b6-c2a7-407d-ba6b-8e7a4fb3e195
437	blogi	303	4eb2d87f-6d2e-4ba3-8fff-76085e6c1858
568	sovellus	369	d41d5e9d-bbf0-45f5-9985-eba4feb385f0
633	audio	394	16d136da-d322-4028-9bda-53a3e7ebd5f6
577	kuva	275	614834dc-b1b5-430e-ad43-94235d7db0f8
604	harjoitus	310	bf2c17a1-2f6f-4019-adb1-576e6caeebd9
545	datasetti	367	a42b00b6-c2a7-407d-ba6b-8e7a4fb3e195
597	kaavio	380	e08cb0fc-14d7-4919-91e3-9981f25cc5ce
482	datasetti	348	a42b00b6-c2a7-407d-ba6b-8e7a4fb3e195
534	opas	364	a31e360b-86ea-4857-bdd7-ac5253e7c1ec
456	harjoitus	327	bf2c17a1-2f6f-4019-adb1-576e6caeebd9
457	kaavio	327	e08cb0fc-14d7-4919-91e3-9981f25cc5ce
591	harjoitus	370	bf2c17a1-2f6f-4019-adb1-576e6caeebd9
491	teksti	351	cc1d00b0-b11f-4afe-a423-e43f96214f89
524	esitys	327	7be52f46-138d-482f-834e-5ea33d933c37
442	video	312	c1256389-a47d-4a44-beb2-bdbbc79abb28
461	sovellus	312	d41d5e9d-bbf0-45f5-9985-eba4feb385f0
532	peli	362	8bb41e85-0d22-4762-9713-ebedd22c50b1
434	opas	306	a31e360b-86ea-4857-bdd7-ac5253e7c1ec
615	harjoitus	385	bf2c17a1-2f6f-4019-adb1-576e6caeebd9
652	datasetti	401	a42b00b6-c2a7-407d-ba6b-8e7a4fb3e195
509	kuva	355	614834dc-b1b5-430e-ad43-94235d7db0f8
626	opas	393	a31e360b-86ea-4857-bdd7-ac5253e7c1ec
653	audio	292	16d136da-d322-4028-9bda-53a3e7ebd5f6
639	audio	309	16d136da-d322-4028-9bda-53a3e7ebd5f6
649	kaavio	399	e08cb0fc-14d7-4919-91e3-9981f25cc5ce
627	kaavio	395	e08cb0fc-14d7-4919-91e3-9981f25cc5ce
651	kaavio	400	e08cb0fc-14d7-4919-91e3-9981f25cc5ce
635	harjoitus	396	bf2c17a1-2f6f-4019-adb1-576e6caeebd9
659	teksti	402	cc1d00b0-b11f-4afe-a423-e43f96214f89
661	harjoitus	403	bf2c17a1-2f6f-4019-adb1-576e6caeebd9
662	esitys	403	7be52f46-138d-482f-834e-5ea33d933c37
663	harjoitus	404	bf2c17a1-2f6f-4019-adb1-576e6caeebd9
664	esitys	405	7be52f46-138d-482f-834e-5ea33d933c37
666	esitys	407	7be52f46-138d-482f-834e-5ea33d933c37
667	kaavio	408	e08cb0fc-14d7-4919-91e3-9981f25cc5ce
668	harjoitus	409	bf2c17a1-2f6f-4019-adb1-576e6caeebd9
665	teksti	406	cc1d00b0-b11f-4afe-a423-e43f96214f89
438	työkalu	300	1b5918b8-701b-48e6-aa2c-5feb3d7b3d60
669	blogi	251	4eb2d87f-6d2e-4ba3-8fff-76085e6c1858
670	datasetti	359	a42b00b6-c2a7-407d-ba6b-8e7a4fb3e195
492	opas	354	a31e360b-86ea-4857-bdd7-ac5253e7c1ec
673	kaavio	410	e08cb0fc-14d7-4919-91e3-9981f25cc5ce
683	kaavio	420	e08cb0fc-14d7-4919-91e3-9981f25cc5ce
\.


--
-- Data for Name: licensecode; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.licensecode (code, license) FROM stdin;
CCBY4.0	CC BY 4.0
CCBYNC4.0	CC BY-NC 4.0
CCBYNCSA4.0	CC BY-NC-SA 4.0
CCBYND4.0	CC BY-ND 4.0
CCBYSA4.0	CC BY-SA 4.0
CCBYNCND4.0	CC BY-NC-ND 4.0
\.


--
-- Data for Name: logins; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.logins (id, username, passwordsalt, passwordhash, usersid) FROM stdin;
\.


--
-- Data for Name: material; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.material (id, link, educationalmaterialid, obsoleted, priority, materiallanguagekey) FROM stdin;
1		1	0	0	fi
2		2	0	0	fi
3		3	0	0	fi
4		4	0	0	fi
5		4	0	0	fi
7		5	0	0	fi
8		5	0	0	fi
11		6	0	0	fi
12		6	0	0	fi
13		5	0	0	fi
14		5	0	0	fi
15		5	0	0	fi
16		5	0	0	fi
17		5	0	0	fi
18		5	0	0	fi
19		7	0	0	fi
20		7	0	0	sv
21		7	0	0	en
22		8	0	0	fi
23		8	0	0	sv
24		8	0	0	en
25		9	0	0	fi
26		9	0	0	fi
27		9	0	0	fi
28		9	0	0	fi
29		9	0	0	fi
30		9	0	0	fi
31		9	0	0	fi
32		9	0	0	fi
33		9	0	0	fi
34		9	0	0	fi
35		9	0	0	fi
36		9	0	0	fi
37		9	0	0	fi
38		10	0	0	fi
39		10	0	0	fi
40		10	0	0	fi
41		10	0	0	fi
42		11	0	0	fi
43		6	0	0	fi
44		12	0	0	fi
45		12	0	0	fi
46		12	0	0	fi
47		12	0	0	sv
48		12	0	0	sv
49		12	0	0	en
50		12	0	0	en
51		13	0	0	fi
52		13	0	0	fi
53		13	0	0	fi
54		13	0	0	sv
55		13	0	0	sv
56		13	0	0	en
57		13	0	0	en
58		14	0	0	fi
59		14	0	0	fi
60		14	0	0	fi
61		14	0	0	sv
62		14	0	0	sv
63		14	0	0	sv
64		14	0	0	en
65		14	0	0	en
66		14	0	0	en
67		15	0	0	fi
68		6	0	0	fi
71		17	0	0	fi
72		18	0	0	fi
73		18	0	0	fi
74		18	0	0	fi
75		18	0	0	fi
76		18	0	0	sv
77		18	0	0	sv
78		18	0	0	sv
79		18	0	0	sv
80		18	0	0	en
81		18	0	0	en
82		18	0	0	en
83		18	0	0	en
84		19	0	0	fi
85		21	0	0	fi
86		22	0	0	fi
87		23	0	0	fi
88		24	0	0	fi
89		24	0	0	fi
90		24	0	0	fi
91		24	0	0	fi
92		24	0	0	fi
93		24	0	0	sv
94		24	0	0	sv
95		24	0	0	sv
96		24	1	0	sv
97		24	1	0	sv
98		24	1	0	en
99		24	1	0	en
69		16	1	0	fi
70		16	1	0	fi
101		26	0	0	fi
103		27	0	0	fi
104		28	0	0	fi
105		29	0	0	fi
106		30	0	0	fi
107		31	0	0	fi
108		32	0	0	fi
109		33	0	0	fi
110		34	0	0	fi
111		39	0	0	fi
112		39	0	0	fi
100		24	1	0	en
115		42	0	0	fi
119		42	1	0	fi
118		42	1	0	fi
117		42	1	0	fi
116		42	1	0	fi
120		42	1	0	fi
121		42	1	0	fi
122		42	1	0	fi
123		42	0	0	fi
124		42	1	0	fi
125		42	1	0	fi
126		43	0	0	fi
127		43	0	0	sv
128		44	0	0	fi
129		45	0	0	fi
130		47	0	0	fi
131		47	0	0	fi
132	http://localhost:4200/#/lisaa-oppimateriaali/132323232	47	0	0	fi
133		47	0	0	fi
136		40	1	0	fi
135		40	1	0	fi
134		40	1	0	fi
138		40	1	0	fi
137		40	1	0	fi
114		40	1	0	fi
113		40	1	0	fi
139		40	0	0	fi
140		40	0	0	fi
141		40	0	0	fi
143		40	0	0	fi
144		40	0	0	fi
142		40	1	0	fi
145		48	1	0	fi
146		48	1	0	fi
147	https://demo.aoe.fi/#/etusivu	48	0	0	fi
148		49	0	0	fi
149		50	0	0	fi
150	https://demo.aoe.fi/#/etusivu	51	0	0	fi
151		51	0	0	fi
152	https://demo.aoe.fi/#/etusivu	52	0	0	fi
153		52	0	0	fi
154	https://aoe.fi/#/demo/materiaali/19/kirjain%E2%80%93aanne-vastaavuus	53	0	0	fi
155		53	0	0	fi
169	https://demo.aoe.fi/#/omat-oppimateriaalit	59	0	0	fi
156		16	0	0	fi
102		16	1	0	fi
159		55	1	0	fi
158		55	1	0	fi
160		55	0	0	fi
161		55	0	0	fi
162	https://aoe.fi/#/demo/materiaali/19/kirjain%E2%80%93aanne-vastaavuus	56	0	0	fi
163		56	0	0	fi
164	https://aoe.fi/#/demo/materiaali/19/kirjain%E2%80%93aanne-vastaavuus	57	0	0	fi
167		57	0	0	fi
166		57	1	0	fi
165	https://aoe.fi/#/demo/materiaali/19/kirjain%E2%80%93aanne-vastaavuus	57	1	0	fi
157	https://aoe.fi/#/demo/materiaali/19/kirjain%E2%80%93aanne-vastaavuus	54	1	0	fi
168	https://aoe.fi/#/demo/materiaali/19/kirjain%E2%80%93aanne-vastaavuus	54	0	0	fi
170		59	0	0	fi
171		60	0	0	fi
172	https://aoe.fi/#/demo/materiaali/5/oppimistehtavien-suunnittelu	61	0	0	fi
173		64	0	0	fi
174		65	0	0	fi
175		66	0	0	fi
176		63	0	0	fi
177		63	0	0	fi
180		68	0	0	fi
181		68	0	0	fi
183		67	1	0	fi
182		67	1	0	fi
179		67	1	0	fi
178		67	1	0	fi
184		67	0	0	fi
185		67	0	0	fi
186		67	0	0	fi
187		67	0	0	fi
188		69	0	0	fi
189		70	0	0	fi
190		70	0	0	sv
191	csc.fi	71	0	0	fi
192	csc.fi	72	0	0	fi
193		73	0	0	fi
194		74	0	0	fi
195		75	0	0	fi
196		75	1	0	fi
197		76	0	0	fi
198		76	0	0	fi
199		76	0	0	en
200		76	0	0	en
201		76	0	0	sv
202		76	0	0	sv
203		77	0	0	fi
204		77	0	0	sv
205	https://aoe.fi/#/materiaali/4	77	0	0	fi
206		78	0	0	fi
209		80	0	0	fi
208		79	1	0	en
211		79	1	0	en
210		79	1	0	en
207		79	1	0	en
212		79	1	0	en
213		79	1	0	en
214		79	1	0	fi
217		81	0	0	fi
218		82	0	0	en
220		84	0	0	fi
221		85	0	0	fi
222		86	0	0	fi
223		87	0	0	en
224		87	0	0	en
225		88	0	0	fi
226		89	0	0	en
227		90	1	0	fi
228		91	0	0	fi
229		92	0	0	en
230		93	0	0	en
231		93	0	0	en
232		94	0	0	fi
215		79	0	0	en
234		97	0	0	fi
235		98	0	0	fi
236		99	0	0	fi
237		99	0	0	fi
238		99	0	0	fi
239		100	0	0	fi
240		100	0	0	fi
241		100	0	0	fi
242		101	0	0	fi
243		101	0	0	fi
244	 	102	0	0	fi
245		103	0	0	fi
246		103	0	0	fi
247		104	0	0	fi
248		105	0	0	fi
249		106	0	0	fi
250		106	0	0	fi
251		106	0	0	fi
252		106	0	0	fi
253		106	0	0	fi
254		107	0	0	fi
255		108	0	0	fi
256		108	0	0	sv
257		109	0	0	fi
258		110	0	0	fi
259		110	0	0	en
260		110	0	0	sv
261		110	0	0	en
262		110	0	0	en
263		110	0	0	sv
266		111	0	0	fi
264		111	0	1	fi
265		111	0	2	fi
267		112	0	0	fi
268		112	0	1	fi
304		117	0	0	fi
303		117	0	1	fi
305		117	0	2	fi
307	https://ohohanke.fi	118	0	0	en
306		118	0	1	en
308	tyopeda.fi	119	0	0	en
309		120	0	0	en
310		121	0	1	en
311		121	0	0	sv
312		122	0	1	fi
313		122	0	0	fi
316		124	0	1	fi
317		124	0	0	fi
318		125	0	0	fi
319		126	0	0	fi
320		127	0	0	fi
322		128	0	0	fi
321	http://demo.aoe.fi	128	0	1	fi
323		129	0	0	fi
324		130	0	0	fi
325		131	0	0	sv
326		132	0	0	fi
327		132	0	1	fi
328		133	0	-1	fi
329		134	0	0	fi
330		135	0	0	fi
331		136	1	0	fi
332		136	0	-1	fi
333		136	0	0	fi
334		137	0	0	fi
335		138	0	0	fi
336		139	0	0	fi
337		140	1	0	fi
338		140	0	0	fi
339		141	0	0	fi
342		143	0	0	fi
341		143	0	1	fi
346		145	0	1	fi
347		145	0	0	fi
348		145	0	1	fi
349		146	0	0	fi
350		146	0	0	fi
351		147	0	0	fi
354		149	0	0	fi
355		150	0	0	fi
356		150	0	0	fi
352		148	1	0	fi
357		151	0	0	en
358		152	0	1	sv
359		152	0	0	fi
361		153	0	0	sv
362		154	0	1	sv
363		154	0	0	sv
364		155	0	1	sv
365		155	0	0	sv
367		148	1	2	fi
360		148	1	1	fi
353		148	1	0	fi
366		156	1	0	fi
368		156	0	-1	fi
369		157	0	0	fi
370		158	0	1	fi
372		158	0	1	fi
371		158	1	0	fi
373		159	0	1	fi
374		159	0	2	fi
375		159	0	0	fi
590		234	0	3	en
591		234	0	2	sv
379		161	0	0	fi
380		162	0	0	en
381		163	0	1	fi
382		164	0	0	fi
383		165	0	0	fi
376		160	1	0	fi
562		207	0	3	fi
233		95	0	0	en
384	http://localhost:4200/#/lisaa-oppimateriaali/1	166	0	0	fi
385		166	0	1	fi
386		166	0	1	fi
387		166	0	2	fi
388		166	0	3	fi
389		167	0	0	fi
390		167	0	0	fi
391		167	0	1	fi
392		167	0	2	fi
396		169	1	0	en
398		169	1	0	fi
397		169	1	1	fi
393		168	0	0	fi
395		168	0	1	fi
394		168	0	2	sv
399		170	0	0	fi
400		171	0	0	fi
401		172	0	0	fi
402		173	0	0	fi
403		174	0	0	fi
404		175	0	0	fi
405		176	0	0	en
454		203	0	0	fi
485		228	0	0	fi
445		200	0	-1	fi
410	http://localhost:4200/#/lisaa-oppimateriaali/1	179	0	0	fi
411		179	0	1	fi
412		180	0	0	fi
378		160	1	1	fi
377		160	1	2	fi
413		181	0	-1	fi
414		182	0	0	fi
417		183	0	0	fi
415		183	0	1	fi
416		183	0	2	sv
418		184	0	0	fi
419		185	0	0	fi
420		186	0	0	fi
421		186	0	0	fi
422		188	0	0	fi
424		189	0	0	fi
423		189	0	1	fi
425		190	0	0	fi
426		191	0	0	fi
427		192	0	0	fi
428		193	0	0	fi
429		193	0	1	sv
430		193	0	2	fi
431	http://www.cti.gr/el/	194	1	0	fi
432	http://testi.org	195	0	0	fi
433	https://aoe.fi/#/demo/materiaali/19/kirjain%E2%80%93aanne-vastaavuus	194	0	-1	fi
434	http://testi.org	196	1	0	fi
435	http://testi.org	196	1	0	fi
436	http://testi.org	196	1	-1	fi
437	http://testi.org	196	1	-1	fi
438	http://testi.org	196	0	-1	fi
439		197	1	0	fi
440	http://testi.org	197	0	-1	fi
441		198	0	0	fi
442		199	0	0	fi
443		199	0	0	fi
444		200	1	0	fi
447		200	1	-1	fi
446		200	1	0	fi
449		201	0	1	fi
450		201	0	0	fi
451		202	0	0	fi
452		202	0	1	fi
448		200	0	0	fi
453		203	0	1	fi
455		204	0	0	fi
456		205	0	0	fi
457		206	0	0	fi
458		207	0	0	fi
460		209	0	0	fi
461		211	0	-1	fi
462	http://localhost:4200/#/lisaa-oppimateriaali/1	213	0	0	fi
463	http://localhost:4200/#/lisaa-oppimateriaali/1	213	0	0	fi
464		213	0	1	fi
465	http://localhost:4200/#/lisaa-oppimateriaali/1	213	0	2	fi
409	csc.fi	178	0	0	fi
467	https://aoe.fi/#/materiaali/13	216	0	0	fi
468		216	0	1	fi
470		218	0	0	fi
471		219	0	0	fi
472		219	0	1	ru
473		220	1	0	ru
474		220	1	0	af
459		208	0	0	fi
487		230	0	0	sv
478		221	0	0	en
6		3	0	0	fi
479		222	0	0	fi
480	https://demo.aoe.fi	223	0	0	fi
481		224	0	0	sv
482		225	0	0	en
483		226	0	0	en
484		227	0	0	fi
486		229	0	0	fi
469	https://aoe.fi/#/materiaali/5	217	0	0	fi
406		177	0	0	fi
408		177	0	1	fi
407		177	0	2	sv
489	https://aoe.fi/#/materiaali/120	231	1	1	fi
537		260	0	0	fi
491		232	0	0	fi
492		233	0	0	fi
496	https://demo.aoe.fi	235	0	0	fi
497	https://aoe.fi/#/demo/materiaali/19/kirjain%E2%80%93aanne-vastaavuus	236	0	0	fi
498	https://aoe.fi/#/demo/materiaali/19/kirjain%E2%80%93aanne-vastaavuus	236	0	0	fi
499		237	0	0	fi
500		238	0	0	fi
501		238	0	0	fi
638		291	0	0	fi
639		292	0	0	fi
516		251	0	0	fi
466	https://aoe.fi/#/demo/materiaali/16/miten-tuetaan-opiskelijoiden-yhteisollisyyden-kehittymista-kurssin-alkuvaiheessa-2	215	0	0	fi
525		251	1	0	fi
524		251	1	0	fi
523		251	1	0	fi
522		251	1	0	fi
503		240	0	0	fi
521		251	1	0	fi
520		251	1	0	fi
519		251	1	0	fi
518		251	1	0	fi
517		251	1	0	fi
526		251	1	0	fi
515		249	0	0	fi
581		267	0	1	fi
509		245	0	0	fi
488		231	0	0	fi
490	https://aoe.fi/#/materiaali/120	231	0	1	fi
535		262	0	0	fi
547	http://localhost:4200/#/omat-oppimateriaalit/40040	260	0	1	fi
504		241	0	0	en
505		241	0	1	en
548	http://localhost:4200/#/omat-oppimateriaalit/adsadasdas	260	0	1	fi
502		239	0	0	fi
506		242	0	0	fi
508		244	0	0	fi
345		144	0	0	fi
343		144	0	1	fi
344		144	0	2	sv
579		267	0	0	fi
538		260	0	0	fi
510		246	0	0	fi
528		260	0	0	fi
576		265	0	0	fi
577		245	0	1	fi
578		266	0	0	fi
511		247	0	0	fi
540		260	0	0	fi
541		260	0	0	fi
507		243	0	0	fi
561	http://localhost:4200/#/muokkaa-oppimateriaalia/260/5	260	0	5	fi
552		207	0	0	fi
553		207	0	0	fi
514		248	1	0	fi
539		260	0	0	fi
554		247	0	0	fi
542		260	0	0	fi
543		260	0	0	fi
493		234	0	0	fi
550		241	0	1	en
557		207	0	0	sv
549		249	0	0	fi
527	http://localhost:4200/#/omat-oppimateriaalit	260	0	1	fi
556	https://aoe.fi/#/materiaali/384	215	0	0	fi
564		207	0	1	fi
530		260	0	0	fi
531		260	0	0	fi
532		260	0	0	fi
533		260	0	0	fi
534		260	0	0	fi
536		260	0	0	fi
546	http://localhost:4200/#/muokkaa-oppimateriaalia/260/2	260	0	100	fi
529		261	0	0	fi
558		263	0	0	fi
580		267	0	2	sv
545	http://localhost:4200/#/muokkaa-oppimateriaalia/260/1	260	0	100	fi
551		203	0	1	fi
573		246	0	0	fi
559		207	0	0	sv
569		200	0	2	fi
563		207	0	2	fi
495		234	0	1	fi
494		234	0	2	sv
570		208	0	2	sv
555		247	0	0	fi
513		247	0	1	fi
512		247	0	2	en
574		241	0	1	en
575		264	0	0	fi
582		234	0	3	fi
583		234	0	3	fi
584		234	0	4	sv
585		234	0	3	fi
586		234	0	3	sv
587		234	0	3	en
588		234	0	3	ab
589		234	0	3	fi
621		283	0	0	fi
622		283	0	1	sv
655		297	1	0	en
623		177	0	0	fi
624		177	0	1	sv
625		284	0	1	sv
626		284	0	0	fi
656	http://localhost:4200/#/muokkaa-oppimateriaalia/268/1	268	0	2	fi
612		277	0	0	fi
627		285	0	0	fi
628		285	0	2	en
629		285	0	1	sv
630		286	0	0	fi
631		287	0	0	fi
634		289	1	1	sv
635		289	1	0	fi
572		208	0	0	fi
571		208	0	1	fi
636		290	0	1	sv
637		290	0	0	fi
477		220	0	1	sv
476		220	0	2	ru
632		288	0	1	en
633		288	0	0	en
657	https://aoe.fi	274	0	0	fi
658	https://yle.fi	298	1	0	fi
659		299	1	0	fi
660		299	1	-1	fi
661		304	0	0	fi
643		293	0	0	fi
644		293	0	1	sv
662	https://aoe.fi	305	1	0	fi
568		207	0	1	sv
566	https://aoe.fi/#/materiaali/62	207	0	4	fi
565		207	0	1	fi
567		207	0	4	fi
646		169	0	0	fi
593		249	0	1	fi
594		249	0	2	fi
595		249	0	2	fi
596		249	0	2	fi
592		249	0	1	en
597		245	0	2	fi
663		305	1	-1	fi
599		233	0	0	fi
600	https://demo.aoe.fi/#/materiaali/268	269	0	0	fi
219		83	0	0	en
216		79	0	0	en
601	https://demo.aoe.fi	270	0	0	fi
602		271	1	0	fi
605		257	0	0	en
606		272	0	0	fi
607		273	1	0	fi
608		274	1	0	fi
609		275	1	0	fi
610		275	1	-1	fi
611		276	1	0	fi
613		278	0	0	fi
614		278	0	0	fi
615		278	0	0	fi
617		280	0	0	fi
618		281	0	0	fi
647		169	0	0	fi
598		268	0	0	fi
640		268	0	1	fi
641		268	0	2	fi
642		268	0	3	sv
648	https://www.ruokatieto.fi/ruokakasvatus/ruokakasvatusta-kaikille	294	1	0	fi
649		268	0	0	fi
650		268	0	1	fi
651	https://yle.fi/aihe/artikkeli/2016/11/30/tunnista-lintu-opas-aloittelijoille	295	0	0	fi
652	http://linnut.luontoportti.fi/index.phtml?lang=fi	295	0	1	fi
653		296	0	0	fi
654		267	0	1	it
666		306	1	1	fi
664		306	0	2	fi
701		320	0	0	fi
673	https://csc.fi	302	0	0	fi
674		257	0	1	fi
675		207	0	5	fi
676		307	0	0	fi
677		308	0	0	fi
678	https://aoe.fi/#/materiaali/3	308	0	2	fi
679		308	0	1	sv
680		295	0	2	fi
681		295	0	3	fi
682		295	0	3	fi
683		309	0	0	en
620		282	0	0	fi
619		282	0	0	fi
685		311	0	0	fi
687		301	0	0	fi
686		301	0	1	sv
712		337	0	0	fi
689		313	0	0	sv
690		314	0	0	fi
691		315	0	0	fi
693		317	0	0	fi
695		318	0	1	fi
694		318	0	0	fi
696		318	0	1	fi
702	http://tamaontesti.fi	321	0	0	fi
699	http://tamaontesti.fi	319	0	1	fi
700		319	0	0	fi
703	http://tamaontesti.fi	322	0	1	fi
704		322	0	0	fi
705	http://tamaontesti.fi	323	0	0	fi
706	http://tama.fi	324	0	0	fi
707	http://tamaontesti.fi	325	0	0	fi
708		326	0	0	fi
697		313	0	0	sv
698		313	0	1	en
711		271	0	0	fi
604		271	0	0	fi
603		271	0	-1	fi
667		306	0	0	fi
671		303	0	0	fi
688		312	0	0	fi
713		338	0	0	fi
714		339	0	0	fi
715		339	0	5	fi
716		339	0	2	fi
717		339	0	4	fi
718		339	0	3	fi
719		339	0	1	fi
720		340	0	0	fi
709		327	0	0	fi
616		279	0	0	fi
645		275	0	0	fi
668		306	0	2	fi
684		309	0	0	fi
672		300	0	0	fi
721		340	0	5	fi
722		340	0	2	fi
723		340	0	4	fi
724		340	0	1	fi
725		340	0	3	fi
726		340	0	6	fi
727		340	0	9	fi
728		340	0	8	fi
729		340	0	7	fi
730		341	0	0	fi
731		341	0	1	fi
732		342	0	1	fi
733		342	0	0	fi
734		342	0	2	fi
735		343	0	0	fi
736		343	0	1	fi
737		343	0	2	fi
738		343	0	3	fi
739		344	0	0	fi
740		344	0	3	fi
741		344	0	1	fi
742		344	0	4	fi
743		344	0	2	fi
744		345	0	0	fi
745		345	0	1	fi
746		345	0	3	fi
747		345	0	2	fi
748		346	0	4	fi
749		346	0	0	fi
750		346	0	3	fi
751		346	0	1	fi
752		346	0	2	fi
753		347	0	2	fi
754		347	0	4	fi
755		347	0	3	fi
756		347	0	0	fi
757		347	0	1	fi
769		350	0	0	fi
770		350	0	1	fi
795	https://www.popupkoulu.fi	363	0	0	fi
772		352	0	0	fi
773		353	0	0	fi
692		316	0	0	fi
710		316	0	1	fi
821		369	0	0	fi
829		371	0	2	fi
775	http://localhost:4200/#/materiaali/304	304	0	0	fi
778		357	0	0	fi
774		354	0	0	fi
776		355	0	0	fi
808		366	0	0	fi
820		368	0	0	fi
827		370	0	0	fi
782		358	0	1	fi
781		358	0	0	fi
783		325	0	1	fi
807		366	0	2	fi
785		360	0	0	fi
786		361	0	0	fi
805		365	0	0	fi
806		365	0	1	fi
815		365	0	2	fi
771		351	1	0	fi
801		364	0	0	fi
809		366	0	1	fi
822		275	0	1	fi
812		367	0	0	fi
813		367	0	1	fi
796		364	0	1	fi
814		367	0	2	fi
810		366	0	3	fi
760		348	0	0	fi
759		348	0	4	fi
758		348	0	1	fi
762		348	0	2	fi
761		348	0	3	fi
811		366	0	4	fi
816		366	0	5	fi
817		366	0	6	fi
818		366	0	7	fi
823		275	0	1	fi
824		275	0	1	fi
825		275	0	1	fi
784		359	0	0	fi
475		220	0	0	sein
780	https://aoe.fi/#/materiaali/436	279	0	1	sv
828		370	0	0	fi
830		371	0	1	fi
779		355	0	1	fi
790		362	0	1	fi
787		362	0	0	fi
791		362	0	2	fi
777		356	0	0	fi
788	https://opinkirjo.fi/act-now/	362	0	6	fi
793		362	0	4	sv
792		362	0	5	sv
794		362	0	3	sv
819		356	0	1	fi
763		349	0	2	fi
764		349	0	0	fi
765		349	0	1	fi
766		349	0	5	fi
767		349	0	3	fi
768		349	0	4	fi
831		275	0	2	fi
832		375	0	0	fi
833		378	0	0	fi
834		378	0	1	fi
835		378	0	1	fi
836		378	0	2	fi
837		378	0	3	fi
838		379	0	0	fi
841		382	0	0	fi
843		382	0	0	fi
842		382	0	1	fi
844		383	0	0	fi
845		383	0	2	en
846		384	0	0	fi
847		275	0	2	ab
826		275	0	1	fi
886		398	0	0	fi
887		396	0	1	fi
848		310	0	1	fi
849		310	0	0	fi
850		357	0	1	en
851		299	0	0	en
852		387	0	0	fi
853		388	0	0	fi
854		388	0	0	fi
839		380	0	0	fi
798		364	0	6	fi
800		364	0	2	fi
797		364	0	4	fi
799		364	0	5	fi
802		364	0	3	fi
804	https://www.youtube.com/watch?v=dqDYWQxqk3g	364	0	7	fi
803	https://opinkirjo.fi/materiaalit/luokkavaltuusto	364	0	6	fi
789	https://opinkirjo.fi/sv/act-now/	362	0	7	sv
855		374	0	0	fi
856		373	0	0	fi
857		373	0	0	fi
858		373	0	0	fi
859		386	0	0	fi
860		385	0	0	fi
861		275	0	2	fi
862		389	0	0	fi
315	https://aoe.fi/#/demo/materiaali/19/kirjain%E2%80%93aanne-vastaavuus	123	1	0	fi
314	aoe.fi	123	1	1	fi
863	https://csc.fi	390	0	0	fi
864		77	0	3	fi
865		77	0	4	fi
866		391	0	0	fi
896		395	0	2	en
340		142	1	0	fi
868		392	0	0	fi
869		354	0	1	sv
870		393	0	0	fi
871		393	0	0	fi
872		393	0	0	fi
897		395	0	3	sv
876		395	0	1	fi
898		395	0	4	it
877		349	0	6	fi
899		395	0	5	sein
888		396	0	1	fi
878		394	0	2	fi
873		394	0	0	fi
875		394	0	0	fi
840		381	0	0	en
880		309	0	1	fi
882		397	0	0	fi
883		397	1	1	fi
890		399	0	0	fi
910		409	0	0	fi
884		398	0	0	fi
885		398	0	0	fi
891		400	0	0	fi
892		401	0	0	fi
881		292	0	1	fi
900	https://aoe.fi/#/materiaali/337	402	0	0	fi
901		403	0	0	fi
902		404	0	0	fi
893	http://aoe.fi	396	0	2	fi
879		396	0	0	fi
889		396	0	1	fi
903		405	0	0	fi
894	http://yle.fi	396	0	2	fi
911		409	0	1	fi
867		359	0	1	fi
874		395	0	0	fi
895		395	0	1	so
906		407	0	0	fi
907		407	0	1	fi
908		408	0	0	fi
909		408	0	1	fi
915		410	0	0	fi
913	https://demo.aoe.fi/#/etusivu	354	0	0	fi
916		410	0	1	fi
912	https://www.youtube.com/	354	0	1	fi
914		354	0	2	fi
917		411	0	0	fi
918		412	0	0	fi
919		413	0	0	fi
904		406	0	0	fi
670		306	0	2	fi
665		306	0	3	fi
669		306	0	4	fi
905		406	0	1	fi
920		414	0	0	fi
921		415	0	0	fi
922		416	0	0	fi
923		417	0	0	fi
924		418	0	0	fi
925		416	0	0	fi
926		416	0	1	fi
927		419	0	0	fi
928	https://demo.aoe.fi/#/muokkaa-oppimateriaalia/300/1	300	0	1	fi
929		420	0	0	fi
930		420	0	0	fi
935		425	0	0	fi
936		426	0	0	fi
\.


--
-- Data for Name: materialdescription; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.materialdescription (id, description, language, educationalmaterialid) FROM stdin;
1	asf	fi	1
2		sv	1
3		en	1
4	Ideoita opettajalle, miten voi tukea kielen oppimista opettamalla fonetiikan perusasioita.\n	fi	2
5		sv	2
6		en	2
7	dasd asdasdasdasdasd	fi	4
8		sv	4
9		en	4
10	Ohjelmoinnin oppimispaketti Python-ympäristössä\n	fi	7
11		sv	7
12		en	7
13	Oppimateriaalissa tutustuaan aluksi tekoälytutkimuksen ja siihen liittyvien lähitieteiden historiaan. Tämän jälkeen aloitetaan tekoälyn tarkempi tutkiminen miettimällä tutumpaa älykkyyden lajia eli ihmisen älykkyyttä. Mitä on ihmisen älykkyys ja miten sitä pitäisi kuvata, jotta sitä voisi jäljitellä eli mallintaa koneellisesti? Samalla verrataan ihmis- ja tekoälyä ja käsitellään niiden välistä vuorovaikutusta. Seuraavaksi tutustutaan tietokoneiden toimintaan ja siihen, miten mallintaminen tapahtuu koneellisesti. Koneoppimista käsittelevästä kappaleesta selviää, että kaikkia malleja ei tarvitse antaa tietokoneelle valmiina, vaan kone voi muodostaa myös itse omia mallejaan. Toisin sanoen tietokoneet voivat oppia uutta. Koneoppimista käsittelevä kappale on keskeinen, koska tietokoneiden kyky oppia on yksi tärkeimpiä kehitysaskeleita tekoälyn suhteen. Koneoppiminen tarvitsee opetusmateriaalia samaan tapaan kuin opiskelija tarvitsee oppikirjoja. Koneoppimisen tarpeisiin tätä materiaalia löytyy tietokannoista ja tämän vuoksi niitä käsitellään omassa kappaleessaan. Tämän jälkeen tutustutaan erilaisiin tekoälyn osa-alueisiin ja sovelluskohteisiin konenäköä, kielen käsittelyä ja robotiikkaa käsittelevissä kappaleissa. Robotiikkaan tutustumisen yhteydessä mietitään lyhyesti myös tekoälyyn liittyviä eettisiä kysymyksiä.	fi	8
14		sv	8
15		en	8
16	Digitaalinen pedagogiikka on tieto- ja viestintäteknisten välineiden ja sovellusten, verkko-oppimisympäristöjen ja sosiaalisen median mielekästä käyttöä opetuksessa, ohjauksessa, oppimisessa ja opiskelussa. Digitaalisessa pedagogiikassa on sopivassa suhteessa niin tekniikkaa kuin pedagogiikkaa. Verkkopedagoginen osaaminen, omat kokemukset, opiskelijoiden taidot ja laitteet sekä käytettävissä oleva tekniikka vaikuttavat siihen millaista digitaalista pedagogiikkaa opettaja omassa työssään toteuttaa. \n	fi	12
17		sv	12
18		en	12
19	Digitaalisuus ja teknologia kouluissa tarkoittaa mobiilia Internetiä, sosiaalista mediaa, pilvipalveluita, dataa ja datan käyttöä. Se tarkoittaa myös järjestelmiä, tietokoneita, ohjelmia, sovelluksia, välineitä sekä oppimisalustoja sekä opetustilojen varustamista. Koulussa pohditaan mitä digitaalisuus tarkoittaa ja mitä siltä halutaan.\n	fi	13
20		sv	13
21		en	13
22	Learning Design – opetuksen ja oppimisen suunnittelu tarkoittaa sekä opettajan opetuksen suunnittelua ja valmistelua että opiskelijan tavoitteellisen oppimisen suunnittelua. Tämä sisältää oppimisprosessin, oppimistilanteiden, oppimisaktiviteettien mm. oppimistehtävien sekä työskentelyohjeiden, ja ohjauksen suunnittelua. Se on myös oppimisympäristöjen, digitaalisten oppimisen välineiden ja menetelmien valintaa.	fi	14
23		sv	14
24		en	14
25	Oppimistehtävä on nimensä mukaan tehtävä, johon sisään rakennetaan uuden oppimista ohjaavaa ja mahdollistavaa toimintaa. Oppimistehtävä on opettajan merkittävä keino tai menetelmä saada oppija pedagogisesti mielekkäästi ja mietitysti oppimaan uusia asioita. Oppimistehtävät jäsentävät verkko-oppimisprosessia samalla tavalla kuin lähiopetuksen tunnit tai luennot. Verkko-oppimisympäristö on tyhjä tila ilman toimijoita - aktivoinnilla siihen luodaan toimintaa. Digitaalisella aktivoinnilla ja osallistamisella pyritään saamaan opiskelijat (osallistujat) aktiivisiksi toimijoiksi verkko-oppimisympäristöissä.	fi	18
26		sv	18
27		en	18
28	Ideoita opettajalle, miten voi tukea opiskelijoiden yhteisön muodostumista virtuaalisessa luokkaopetuksessa\n	fi	19
29		sv	19
30		en	19
31	Ideoita opettajalle, miten voi tukea opiskelijoiden yhteisön muodostumista virtuaalisessa luokkaopetuksessa\n	fi	20
32		sv	20
33		en	20
34	dadasdasdas	fi	23
35		sv	23
36		en	23
37	Oppimateriaalissa esitellään robotiikan ja automaation käsitteistöä, käsitellään tä arjen ja teollisuuden robotiikkaa nyt ja tulevaisuudessa \n	fi	24
38		sv	24
39		en	24
40	Materiaali opastaa avointen oppimateriaalien tekemiseen erilaisia työkaluja käyttäen.	fi	43
41		sv	43
42		en	43
43		fi	44
44		sv	44
45		en	44
49		fi	52
50		sv	52
51		en	52
61	Tämä materiaali kokeilee avointen oppimateriaalien tallennusta	fi	16
62		sv	16
63		en	16
70	Ideoita opettajalle, miten voi tukea kielen oppimista opettamalla fonetiikan perusasioita.\n	fi	56
71		sv	56
72		en	56
73	Ideoita opettajalle, miten voi tukea kielen oppimista opettamalla fonetiikan perusasioita.\n	fi	57
74		sv	57
75		en	57
76	Tietoa äänteistä kielten oppimisen tueksi\n	fi	54
77		sv	54
78		en	54
79	adsadasdas	fi	59
80		sv	59
81		en	59
185		sv	143
186		en	143
190	Konedigi-hankkeessa tuotettua materiaalia....\n\nMittaustekniikka 1 materiaalit. käsitellään aihetta x. koostuu videosta ja harjoituksista. \n\nOsa Kone- ja tuotantotekniikan (25 osp) sisältöä. \n\n	fi	160
191		sv	160
192		en	160
193		fi	165
194		sv	165
195		en	165
82	Oppimistehtävä on nimensä mukaan tehtävä, johon sisään rakennetaan uuden oppimista ohjaavaa ja mahdollistavaa toimintaa. Oppimistehtävä on opettajan merkittävä keino tai menetelmä saada oppija pedagogisesti mielekkäästi ja mietitysti oppimaan uusia asioita. Oppimistehtävät jäsentävät verkko-oppimisprosessia samalla tavalla kuin lähiopetuksen tunnit tai luennot. Verkko-oppimisympäristö on tyhjä tila ilman toimijoita - aktivoinnilla siihen luodaan toimintaa. Digitaalisella aktivoinnilla ja osallistamisella pyritään saamaan opiskelijat (osallistujat) aktiivisiksi toimijoiksi verkko-oppimisympäristöissä.	fi	61
83		sv	61
84		en	61
85	gdfgdfgdfgdf	fi	67
86		sv	67
87		en	67
97	asdasd	fi	73
98		sv	73
99		en	73
100	testing	fi	74
101		sv	74
102		en	74
103	hgfh fhfghfg	fi	75
104		sv	75
105		en	75
106	Opetusteknologia kattaa kaiken teknologian, millä tuetaan oppimista perinteisessä luokkaopetuksessa, sulautuvassa opetuksessa ja verkko-opetuksessa. Teknologia sisältää välineet, laitteet, ohjelmistot ja erilaiset sovellukset. Opetusteknologiaa ovat esimerkiksi toimisto-ohjelmat, oppimisalustat, arviointia tukevat työkalut, työkirjatyyppiset työkalut, digitaaliset oppimateriaalit, sosiaalinen media, työvälineohjelmat, tiedonhaun välineet, teknologiaan pohjautuvat kognitiiviset työkalut, informaation visualisoinnin työkalut sekä simulaatiot, opetusohjelmat ja -pelit, 3D-mallinnukset, robotit jne.\n	fi	76
107	"Undervisningsteknologi innefattar all sådan teknologi som stöder lärandet i traditionell klassrumsundervisning, blandade lärmiljöer och nät-undervisning. Teknologi innefattar alla verktyg, apparater, program och olika applikationer. Lärandeteknologi är exempelvis kontorsprogram, lärandeplattformer, verktyg som stöder bedömning, verktyg som liknar arbetsböcker, digitala lärandematerial, sociala medier, arbetsverktygsprogram, verktyg för informationssökning, teknologibaserade kognitiva verktyg, verktyg som visualiserar information, simulationer, undervisningsprogram- och spel, 3D-modeller, roboter, osv. \n"\n	sv	76
108	Teaching technology covers all technology that is used to support learning in traditional classroom teaching, in blended teaching and in web-based teaching. Technology covers devices, tools, programs and different applications. Teaching technologies include for instance services for group work and communication, workbooks, digital learning material, social media, tool programs, tools for evaluation, information search tools, cognitive tools based on technology, tools for visualising information as well as simulations, educational programs, educational games, 3D models, robots and so on.\n	en	76
109	testimateriaali	fi	77
110		sv	77
111		en	77
112	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus laoreet iaculis nibh et vehicula. Donec vehicula, erat at scelerisque finibus, lacus eros finibus orci, sit amet faucibus metus diam nec massa. Vestibulum nec ipsum gravida, sodales ipsum non, efficitur ligula. Integer sollicitudin leo tellus, eget commodo ipsum vestibulum vel.	fi	78
113		sv	78
114		en	78
115		fi	81
116		sv	81
117		en	81
118	javascript:alert("Hi there")	fi	97
119		sv	97
120		en	97
121	fgdf	fi	99
122		sv	99
123		en	99
124	adsad	fi	100
125		sv	100
126		en	100
127	asda	fi	101
128		sv	101
129		en	101
130	kuvaus mistä kyse	fi	103
131		sv	103
132		en	103
133	kuvataan	fi	107
134		sv	107
135		en	107
136	Materiaalissa opetetaan avointen oppimateriaalien tekemisen perusteet: esimerkiksi lisensointi ja muut huomioitavat asiat kuten saavutettavuus.	fi	108
137		sv	108
138		en	108
139	gffsdfd	fi	110
140		sv	110
141		en	110
142	fdsfsdfsdf	fi	111
143	uikyt7	sv	111
144	hjjgjhgjkhgjgh	en	111
145		fi	112
146		sv	112
147		en	112
148	sfsd	fi	117
149		sv	117
150		en	117
151		fi	118
152		sv	118
153		en	118
154	testing testing	fi	123
155		sv	123
156		en	123
157	adfasd	fi	127
158		sv	127
159		en	127
160	lyhyt kuvaus materiaalista	fi	128
161		sv	128
162		en	128
163	gh	fi	132
164		sv	132
165		en	132
166	fsdfsdf	fi	137
167		sv	137
168		en	137
169		fi	138
170		sv	138
171		en	138
172		fi	139
173		sv	139
174		en	139
175		fi	140
176		sv	140
177		en	140
178		fi	141
179		sv	141
180		en	141
181	testaus	fi	142
182		sv	142
183		en	142
184	Testaus	fi	143
196	Oppimateriaali ohjeistaa tekijänoikeuksien toteuttamiseen opetuksessa.	fi	168
197		sv	168
198		en	168
199		fi	171
200		sv	171
201		en	171
205		fi	174
206		sv	174
207		en	174
208		fi	175
209		sv	175
210		en	175
211		fi	176
212		sv	176
213		en	176
220		fi	182
221		sv	182
222		en	182
223	Testataan syöttöä	fi	183
224		sv	183
225		en	183
226		fi	184
227		sv	184
228		en	184
229	kokeilu	fi	189
230		sv	189
231		en	189
232	Tällä testaan sellaisia metatietoja, jotka useammin jäävät käyttämättä. 	fi	193
233		sv	193
234		en	193
241	testailua	fi	202
242		sv	202
243		en	202
247		fi	204
248		sv	204
249		en	204
259	testausta	fi	216
260	testausta	sv	216
261	testausta	en	216
268		fi	222
269		sv	222
270		en	222
271	kuvaus	fi	223
272	kuvaus	sv	223
273	kuvaus	en	223
274	testi	fi	224
275	testi	sv	224
276	testi	en	224
286	linkki demoon	fi	235
287	linkki demoon	sv	235
288	linkki demoon	en	235
277	jotain jotain xd	fi	230
278	jotain jotain xd	sv	230
279	jotain jotain xd	en	230
283	Opas avointen oppimateriaalien tekemiseen. Opas käsittelee yleisimpiä ongelmakohtia ja rajoitteita, sekä antaa hyviä vinkkejä avointen oppimateriaalien tekemiseen. Tehty osana xxx-hanketta. 	fi	234
262	testing	fi	217
280	Tässä kirjoitan mistä on kyse	fi	231
281	Den här är någonting	sv	231
282	Here write I poetry	en	231
187	Testaumateriaali testaus demossa	fi	144
188	testing testing	sv	144
189	Testaumateriaali testaus demossa	en	144
214	Kirjoita tähän tiivis kuvaus, mitä oppimateriaalisi käsittelee.	fi	177
263	testing	sv	217
264	testing	en	217
217	test	fi	178
218	test	sv	178
219	test	en	178
256	testaan	fi	215
215	Lyhyt kuvaus mitä materiaali käsittelee.\n\nVoi lisätä esim. tiedon hankkeesta.	sv	177
216	Lyhyt kuvaus mitä materiaali käsittelee.\n\nVoi lisätä esim. tiedon hankkeesta.	en	177
257	testaan	sv	215
258	testaan	en	215
244	testailua	fi	203
245	testailua	sv	203
246	testailua	en	203
250	testausta, päivitettynä	fi	207
251	testausta	sv	207
252	testausta	en	207
535	tämä kuvailee materiaalin	fi	200
536	tämä kuvailee materiaalin	sv	200
537	tämä kuvailee materiaalin	en	200
673		fi	95
674		sv	95
284	Opas avointen oppimateriaalien tekemiseen. Opas käsittelee yleisimpiä ongelmakohtia ja rajoitteita, sekä antaa hyviä vinkkejä avointen oppimateriaalien tekemiseen. Tehty osana xxx-hanketta. 	sv	234
285	Opas avointen oppimateriaalien tekemiseen. Opas käsittelee yleisimpiä ongelmakohtia ja rajoitteita, sekä antaa hyviä vinkkejä avointen oppimateriaalien tekemiseen. Tehty osana xxx-hanketta. 	en	234
675		en	95
676		fi	83
677		sv	83
678		en	83
679		fi	79
439	Puuttuva kuvaus	fi	239
440	Puuttuva kuvaus	sv	239
441	Puuttuva kuvaus	en	239
680		sv	79
466		fi	249
475	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras quis efficitur odio, non lobortis leo. Aliquam ut ullamcorper lectus, at vestibulum purus. Suspendisse aliquet tristique semper. Ut a nulla id ante mattis blandit. Sed scelerisque, orci nec efficitur tincidunt, sapien lorem accumsan sem, eget iaculis risus arcu quis elit.	fi	260
476	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras quis efficitur odio, non lobortis leo. Aliquam ut ullamcorper lectus, at vestibulum purus. Suspendisse aliquet tristique semper. Ut a nulla id ante mattis blandit. Sed scelerisque, orci nec efficitur tincidunt, sapien lorem accumsan sem, eget iaculis risus arcu quis elit.	sv	260
467		sv	249
468		en	249
442		fi	243
443		sv	243
444		en	243
253	testing	fi	208
265	Tämä on kuvaus oppimateriaalista	fi	220
266	Tämä on kuvaus oppimateriaalista	sv	220
477	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras quis efficitur odio, non lobortis leo. Aliquam ut ullamcorper lectus, at vestibulum purus. Suspendisse aliquet tristique semper. Ut a nulla id ante mattis blandit. Sed scelerisque, orci nec efficitur tincidunt, sapien lorem accumsan sem, eget iaculis risus arcu quis elit.	en	260
649	kukkuja	fi	268
650	kukkuja	sv	268
445	Materiaali esittelee Avointen oppimateriaalien kirjastoa	fi	245
446	Materiaali esittelee Avointen oppimateriaalien kirjastoa	sv	245
447	Materiaali esittelee Avointen oppimateriaalien kirjastoa	en	245
586	Italian alkeet 1.	fi	267
736	Kirjoita tähän tiivis kuvaus, mitä oppimateriaalisi käsittelee.	fi	284
737	Kirjoita tähän tiivis kuvaus, mitä oppimateriaalisi käsittelee.	sv	284
738	Kirjoita tähän tiivis kuvaus, mitä oppimateriaalisi käsittelee.	en	284
577		fi	264
578		sv	264
579		en	264
715	Just testing it out	fi	257
716	Just testing it out	sv	257
717	Just testing it out	en	257
681		en	79
580	kokeilen html	fi	265
581	kokeilen html	sv	265
582	kokeilen html	en	265
583		fi	266
584		sv	266
585		en	266
587	Kuvaus mitä oppimateriaali käsittelee.	sv	267
460	Miten tehdään avoimia oppimateriaaleja...	fi	247
529		fi	261
530		sv	261
531		en	261
655		fi	263
656		sv	263
657		en	263
461	Miten tehdään avoimia oppimateriaaleja...	sv	247
462	Miten tehdään avoimia oppimateriaaleja...	en	247
451	Lukion differentiaalilaskennan perusteet.	fi	246
661	Hmm.	fi	233
662	Hmm.	sv	233
663	Hmm.	en	233
664	Hmm. Hmm.	fi	269
665	Hmm. Hmm.	sv	269
666	Hmm. Hmm.	en	269
670		fi	259
671		sv	259
672		en	259
685		fi	258
686		sv	258
687		en	258
667		fi	228
668		sv	228
669		en	228
646	discreption	fi	214
647	discreption	sv	214
648	discreption	en	214
697	test	fi	270
698	test	sv	270
699	test	en	270
718		fi	276
719		sv	276
720		en	276
452	On se hieno.	sv	246
453	On se hieno.	en	246
651	kukkuja	en	268
409	Amazing documentary about the stone heads rolling down the hills of Easter Island.	fi	241
410	Amazing 3D documentary	sv	241
411	Amazing 3D documentary	en	241
682		fi	169
683		sv	169
684		en	169
739	test	fi	277
740	test	sv	277
741	test	en	277
745	Oppimateriaali Pythonin opiskeluun. Demolla testausta varten.	fi	285
746	Oppimateriaali Pythonin opiskeluun. Demolla testausta varten.	sv	285
747	Oppimateriaali Pythonin opiskeluun. Demolla testausta varten.	en	285
748	Kokeilu zip-toimivuudesta	fi	286
749	Kokeilu zip-toimivuudesta	sv	286
750	Kokeilu zip-toimivuudesta	en	286
751	Oikea oppimateriaali: https://aoe.fi/#/materiaali/379\n\nTämä sisältö ladattu ja kopioitu demolle	fi	287
752	Oikea oppimateriaali: https://aoe.fi/#/materiaali/379\n\nTämä sisältö ladattu ja kopioitu demolle	sv	287
753	Oikea oppimateriaali: https://aoe.fi/#/materiaali/379\n\nTämä sisältö ladattu ja kopioitu demolle	en	287
757		fi	291
758		sv	291
759		en	291
769	Ai että.	fi	293
770	Ai että.	sv	293
771	Splendid!	en	293
721	testaan syöttöä  – - _ –4 – –6 	fi	282
722	testaan syöttöä	sv	282
723	testaan syöttöä	en	282
885	Avoin julkaisuun liittyvä materiaali löytyy aoe:n varsinaiselta puolelta.	en	317
886	Kokeiluun kaksi materiaalia + video tekstillä	fi	318
887	Kokeiluun kaksi materiaalia + video tekstillä	sv	318
888	Kokeiluun kaksi materiaalia + video tekstillä	en	318
871	Tämä on kuvaus materiaalista, mutta ruotsiksi	fi	313
919		fi	290
754	Todellinen materiaali Hanne Koli ja Leena Vainio aoe.fi	fi	288
712	Kokeilen toimivuutta	fi	271
713	Kokeilen toimivuutta	sv	271
755	Todellinen materiaali Hanne Koli ja Leena Vainio aoe.fi	sv	288
873	Tämä on kuvaus materiaalista, mutta ruotsiksi	en	313
772		fi	275
773		sv	275
774		en	275
817	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris ut dolor vulputate, mattis enim vel, ultrices quam. Nullam rutrum ac ligula sit amet vestibulum. Mauris vel tincidunt magna. Etiam vel nunc quam. Integer fermentum sed nibh nec aliquam. In id lorem ligula. Morbi eleifend nisl ante, vel hendrerit libero rutrum suscipit. Fusce vitae enim ultrices, condimentum purus vel, feugiat risus. Vestibulum sit amet dictum urna.\n\nMauris congue ut ex ac consectetur. Integer a fringilla sapien. Suspendisse placerat feugiat turpis ac rhoncus. Etiam a scelerisque massa. Mauris lacinia varius massa vel convallis. Donec dapibus arcu nec aliquet mattis. Integer gravida gravida lacus, quis consectetur sem consectetur quis. Curabitur malesuada pellentesque lectus sit amet aliquet. Ut maximus nisl in cursus ultrices. Vestibulum vestibulum magna diam, sed iaculis felis dictum ac. Morbi sodales facilisis accumsan. Fusce id libero vel mi euismod lacinia. Nunc quis commodo magna. Curabitur luctus, tortor quis commodo commodo, turpis ante blandit massa, sit amet varius nulla turpis eget magna.\n\nAenean sed lacus est. Ut pulvinar ex odio, nec varius arcu scelerisque quis. Curabitur sit amet tempus diam. Proin ac velit tellus. Vestibulum hendrerit orci in felis interdum, non placerat sem pellentesque. Etiam quis nisi nisi. Curabitur cursus lorem eu porttitor gravida. Vivamus luctus vel lectus et euismod. Ut vel magna vitae velit tempus sollicitudin. Ut consectetur nibh non metus fringilla lacinia.\n\nEtiam lacinia odio quis elit accumsan, quis suscipit velit sodales. Mauris ut lacus sed tortor dapibus bibendum ut quis nisl. Praesent non nisi ac velit auctor gravida. Nulla non justo a massa placerat maximus a non leo. Integer pulvinar viverra viverra. Phasellus enim libero, maximus a urna in, suscipit pretium mauris. Nullam non rutrum enim, varius pellentesque neque. Donec in gravida turpis, sit amet semper diam. Maecenas id ligula at erat elementum rhoncus eu sed nunc. Duis vel nunc ac metus.	fi	296
818	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris ut dolor vulputate, mattis enim vel, ultrices quam. Nullam rutrum ac ligula sit amet vestibulum. Mauris vel tincidunt magna. Etiam vel nunc quam. Integer fermentum sed nibh nec aliquam. In id lorem ligula. Morbi eleifend nisl ante, vel hendrerit libero rutrum suscipit. Fusce vitae enim ultrices, condimentum purus vel, feugiat risus. Vestibulum sit amet dictum urna.\n\nMauris congue ut ex ac consectetur. Integer a fringilla sapien. Suspendisse placerat feugiat turpis ac rhoncus. Etiam a scelerisque massa. Mauris lacinia varius massa vel convallis. Donec dapibus arcu nec aliquet mattis. Integer gravida gravida lacus, quis consectetur sem consectetur quis. Curabitur malesuada pellentesque lectus sit amet aliquet. Ut maximus nisl in cursus ultrices. Vestibulum vestibulum magna diam, sed iaculis felis dictum ac. Morbi sodales facilisis accumsan. Fusce id libero vel mi euismod lacinia. Nunc quis commodo magna. Curabitur luctus, tortor quis commodo commodo, turpis ante blandit massa, sit amet varius nulla turpis eget magna.\n\nAenean sed lacus est. Ut pulvinar ex odio, nec varius arcu scelerisque quis. Curabitur sit amet tempus diam. Proin ac velit tellus. Vestibulum hendrerit orci in felis interdum, non placerat sem pellentesque. Etiam quis nisi nisi. Curabitur cursus lorem eu porttitor gravida. Vivamus luctus vel lectus et euismod. Ut vel magna vitae velit tempus sollicitudin. Ut consectetur nibh non metus fringilla lacinia.\n\nEtiam lacinia odio quis elit accumsan, quis suscipit velit sodales. Mauris ut lacus sed tortor dapibus bibendum ut quis nisl. Praesent non nisi ac velit auctor gravida. Nulla non justo a massa placerat maximus a non leo. Integer pulvinar viverra viverra. Phasellus enim libero, maximus a urna in, suscipit pretium mauris. Nullam non rutrum enim, varius pellentesque neque. Donec in gravida turpis, sit amet semper diam. Maecenas id ligula at erat elementum rhoncus eu sed nunc. Duis vel nunc ac metus.	sv	296
819	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris ut dolor vulputate, mattis enim vel, ultrices quam. Nullam rutrum ac ligula sit amet vestibulum. Mauris vel tincidunt magna. Etiam vel nunc quam. Integer fermentum sed nibh nec aliquam. In id lorem ligula. Morbi eleifend nisl ante, vel hendrerit libero rutrum suscipit. Fusce vitae enim ultrices, condimentum purus vel, feugiat risus. Vestibulum sit amet dictum urna.\n\nMauris congue ut ex ac consectetur. Integer a fringilla sapien. Suspendisse placerat feugiat turpis ac rhoncus. Etiam a scelerisque massa. Mauris lacinia varius massa vel convallis. Donec dapibus arcu nec aliquet mattis. Integer gravida gravida lacus, quis consectetur sem consectetur quis. Curabitur malesuada pellentesque lectus sit amet aliquet. Ut maximus nisl in cursus ultrices. Vestibulum vestibulum magna diam, sed iaculis felis dictum ac. Morbi sodales facilisis accumsan. Fusce id libero vel mi euismod lacinia. Nunc quis commodo magna. Curabitur luctus, tortor quis commodo commodo, turpis ante blandit massa, sit amet varius nulla turpis eget magna.\n\nAenean sed lacus est. Ut pulvinar ex odio, nec varius arcu scelerisque quis. Curabitur sit amet tempus diam. Proin ac velit tellus. Vestibulum hendrerit orci in felis interdum, non placerat sem pellentesque. Etiam quis nisi nisi. Curabitur cursus lorem eu porttitor gravida. Vivamus luctus vel lectus et euismod. Ut vel magna vitae velit tempus sollicitudin. Ut consectetur nibh non metus fringilla lacinia.\n\nEtiam lacinia odio quis elit accumsan, quis suscipit velit sodales. Mauris ut lacus sed tortor dapibus bibendum ut quis nisl. Praesent non nisi ac velit auctor gravida. Nulla non justo a massa placerat maximus a non leo. Integer pulvinar viverra viverra. Phasellus enim libero, maximus a urna in, suscipit pretium mauris. Nullam non rutrum enim, varius pellentesque neque. Donec in gravida turpis, sit amet semper diam. Maecenas id ligula at erat elementum rhoncus eu sed nunc. Duis vel nunc ac metus.	en	296
588	Kuvaus mitä oppimateriaali käsittelee.	en	267
832	kokeilen meneekö ilman tiedostoa läpi	fi	294
833	kokeilen meneekö ilman tiedostoa läpi	sv	294
834	kokeilen meneekö ilman tiedostoa läpi	en	294
835		fi	297
836		sv	297
837		en	297
856	kuvaus	fi	302
857	kuvaus	sv	302
858	kuvaus	en	302
862		fi	301
863		sv	301
864		en	301
874		fi	314
875		sv	314
876		en	314
877		fi	315
878		sv	315
879		en	315
883	Avoin julkaisuun liittyvä materiaali löytyy aoe:n varsinaiselta puolelta.	fi	317
884	Avoin julkaisuun liittyvä materiaali löytyy aoe:n varsinaiselta puolelta.	sv	317
872	Tämä on kuvaus materiaalista, mutta ruotsiksi	sv	313
838		fi	304
839		sv	304
840		en	304
850		fi	303
851		sv	303
852		en	303
865	testaillaan monikielisyyttä	fi	312
901	Testataan materiaalimäärää	fi	327
902	Testataan materiaalimäärää	sv	327
829	Se materialet i aoe.fi: https://aoe.fi/#/materiaali/436	fi	279
830	Se materialet i aoe.fi: https://aoe.fi/#/materiaali/436	sv	279
903	Testataan materiaalimäärää	en	327
853		fi	300
854		sv	300
855		en	300
920		sv	290
921		en	290
931	oikea materiaali löytyy aoe.fi:stä	fi	337
932	oikea materiaali löytyy aoe.fi:stä	sv	337
933	oikea materiaali löytyy aoe.fi:stä	en	337
934	h5p-testi, oikea materiaali löytyy aoe.fi-sivuilta	fi	338
935	h5p-testi, oikea materiaali löytyy aoe.fi-sivuilta	sv	338
936	h5p-testi, oikea materiaali löytyy aoe.fi-sivuilta	en	338
937	oikea materiaali löytyy aoe.fistä\ntestaus useasta h5p-materiaalista samalla sivulla	fi	339
938	oikea materiaali löytyy aoe.fistä\ntestaus useasta h5p-materiaalista samalla sivulla	sv	339
939	oikea materiaali löytyy aoe.fistä\ntestaus useasta h5p-materiaalista samalla sivulla	en	339
940	testaukseen. oikea materiaali löytyy aoe.fistä.	fi	340
941	testaukseen. oikea materiaali löytyy aoe.fistä.	sv	340
942	testaukseen. oikea materiaali löytyy aoe.fistä.	en	340
943	h5p-orgin testitiedostoja	fi	341
944	h5p-orgin testitiedostoja	sv	341
945	h5p-orgin testitiedostoja	en	341
946	testimateriaali h5p-org-sivulta	fi	342
947	testimateriaali h5p-org-sivulta	sv	342
948	testimateriaali h5p-org-sivulta	en	342
949	testimateriaali h5p.orgista	fi	343
950	testimateriaali h5p.orgista	sv	343
951	testimateriaali h5p.orgista	en	343
952	testimateriaali h5p.orgista	fi	344
953	testimateriaali h5p.orgista	sv	344
954	testimateriaali h5p.orgista	en	344
955	testimateriaali h5p.orgista	fi	345
956	testimateriaali h5p.orgista	sv	345
957	testimateriaali h5p.orgista	en	345
958	testimateriaali h5p.orgista	fi	346
959	testimateriaali h5p.orgista	sv	346
960	testimateriaali h5p.orgista	en	346
961	testimateriaali h5p.orgista	fi	347
962	testimateriaali h5p.orgista	sv	347
963	testimateriaali h5p.orgista	en	347
970	oikea materiaali aoe.fissä	fi	350
971	oikea materiaali aoe.fissä	sv	350
972	oikea materiaali aoe.fissä	en	350
881	da dasd ad fa dasd adadas	sv	316
882	da dasd ad fa dasd adadas	en	316
866	testaillaan monikielisyyttä	sv	312
867	testaillaan monikielisyyttä	en	312
1045	testiä	fi	355
1046	testiä	sv	355
1047	testiä	en	355
254	testing	sv	208
255	testing	en	208
714	Kokeilen toimivuutta	en	271
1096	Testausta varten Kirsi Oikarisen oppimateriaali iPadin purkamisesta. Oikea oppimateriaali löytyy täältä: https://aoe.fi#/materiaali/649	fi	361
1097	Testausta varten Kirsi Oikarisen oppimateriaali iPadin purkamisesta. Oikea oppimateriaali löytyy täältä: https://aoe.fi#/materiaali/649	sv	361
880	Tässä materiaalissa perehdytään vanhojen rakennusten uusiokäyttöön ja siihen liittyviin lähtökohtiin. Käytännössä materiaali on Moodlen osio, jonka voi liittää sellaisenaan mille tahansa Moodle-alustalle. Paketti sisältää kaiken materiaalin, joten opettajalta ei vaadita muuta kuin muutaman harjoitustyön hyväksyminen. Tämä materiaali on osa Opetus- ja kulttuuriministeriön rahoittamaa hanketta “Kiertotalousosaamista ammattikorkeakouluihin (2018 – 2020). Hankkeeseen osallistui 18 suomalaista ammattikorkeakoulua.	fi	316
1098	Testausta varten Kirsi Oikarisen oppimateriaali iPadin purkamisesta. Oikea oppimateriaali löytyy täältä: https://aoe.fi#/materiaali/649	en	361
994	das	fi	354
995	das	sv	354
996	das	en	354
991		fi	351
1294		fi	392
1066	Testaus miten Adobe Presenterissä tehty materiaali toimii palvelussa.	fi	358
1067	Testaus miten Adobe Presenterissä tehty materiaali toimii palvelussa.	sv	358
1068	Testaus miten Adobe Presenterissä tehty materiaali toimii palvelussa.	en	358
831	Se materialet i aoe.fi: https://aoe.fi/#/materiaali/436	en	279
992		sv	351
993		en	351
1100	Act now-spelet skapar aktiv samhällsdebatt och utvecklar deltagarnas argumentationsförmåga. Spelet är producerat i nordiskt samarbete och det finns på finska, svenska och norska.	sv	362
1295		sv	392
1296		en	392
964	testimateriaali h5p.orgista	fi	348
1093	Kuvaus materiaalista kertoo kaiken tarpeellisen, aivan kuten tämäkin.	fi	360
1094	Kuvaus materiaalista kertoo kaiken tarpeellisen, aivan kuten tämäkin.	sv	360
1095	Kuvaus materiaalista kertoo kaiken tarpeellisen, aivan kuten tämäkin.	en	360
965	testimateriaali h5p.orgista	sv	348
966	testimateriaali h5p.orgista	en	348
1048	Testi	fi	356
1049	Testi	sv	356
1050	Testi	en	356
1312	Oppimateriaali kertoo kuinka lunta tulisi luoda äkkinäisten ja merkittävien lumipyryjen aikana, niiden jälkeen ja niitä ennen. Se antaa konkreettiset työkalut jokaisen lumitaistoon.	fi	393
1313	Oppimateriaali kertoo kuinka lunta tulisi luoda äkkinäisten ja merkittävien lumipyryjen aikana, niiden jälkeen ja niitä ennen. Se antaa konkreettiset työkalut jokaisen lumitaistoon.	sv	393
967	testimateriaali h5p.orgista	fi	349
968	testimateriaali h5p.orgista	sv	349
969	testimateriaali h5p.orgista	en	349
1102	Verkkopalvelu PopUp-koulun järjestämiseksi. Työkalulla organisoit satojen osallistujien tapahtumia helposti. Verkkopalvelua käyttämällä keräät työpajaehdotukset ja ilmoittautumiset sekä tulostat osallistujalistat.	fi	363
1103	Verkkopalvelu PopUp-koulun järjestämiseksi. Työkalulla organisoit satojen osallistujien tapahtumia helposti. Verkkopalvelua käyttämällä keräät työpajaehdotukset ja ilmoittautumiset sekä tulostat osallistujalistat.	sv	363
1104	Verkkopalvelu PopUp-koulun järjestämiseksi. Työkalulla organisoit satojen osallistujien tapahtumia helposti. Verkkopalvelua käyttämällä keräät työpajaehdotukset ja ilmoittautumiset sekä tulostat osallistujalistat.	en	363
1123	oikeat materiaalit löytyvät aoe.fistä - tässä testataan excel-materiaalien esikatselun toimivuutta.	fi	365
1124	oikeat materiaalit löytyvät aoe.fistä - tässä testataan excel-materiaalien esikatselun toimivuutta.	sv	365
1125	oikeat materiaalit löytyvät aoe.fistä - tässä testataan excel-materiaalien esikatselun toimivuutta.	en	365
1224	Ja sama englanniksi	en	370
1234	Tämä ei ole testi	fi	378
1235	Tämä ei ole testi	sv	378
1236	Tämä ei ole testi	en	378
1144	Tämä on testikuvaus	fi	368
1145	Tämä on testikuvaus	sv	368
1146	Tämä on testikuvaus	en	368
1126	oikeat materiaalit aoe.fi:ssä ja blogissamme	fi	366
1127	oikeat materiaalit aoe.fi:ssä ja blogissamme	sv	366
1128	oikeat materiaalit aoe.fi:ssä ja blogissamme	en	366
1171	Opi valmistamaan herkullisia ruokia\nVerkkopalvelu PopUp-koulun järjestämiseksi. Työkalulla organisoit satojen osallistujien tapahtumia helposti. Verkkopalvelua käyttämällä keräät työpajaehdotukset ja ilmoittautumiset sekä tulostat osallistujalistat.\n	fi	369
1172	Opi valmistamaan herkullisia ruokia	sv	369
1173	Opi valmistamaan herkullisia ruokia	en	369
1129	oikea materiaali aoe.fissä, esitykset jaettu vastaavissa tapahtumissa.	fi	367
1130	oikea materiaali aoe.fissä, esitykset jaettu vastaavissa tapahtumissa.	sv	367
1131	oikea materiaali aoe.fissä, esitykset jaettu vastaavissa tapahtumissa.	en	367
267	Tämä on kuvaus oppimateriaalista	en	220
756	Todellinen materiaali Hanne Koli ja Leena Vainio aoe.fi	en	288
1222	Tämä kuvaus on pitkä ja kaunis.	fi	370
1223	Ja sama ruotsiksi	sv	370
1243	Testaukseen esitys seminaarista	fi	382
1244	Testaukseen esitys seminaarista	sv	382
1245	Testaukseen esitys seminaarista	en	382
1255	Oi kesä kesä.	fi	310
1256	Oi sommar sommar.	sv	310
1257	Oh summer summer.	en	310
1237	kuvaus on kaunista	fi	380
1238	kuvaus on kaunista	sv	380
1239	kuvaus on kaunista	en	380
1105	Oppaassa esitellään luokkavaltuustomalli ja annetaan opettajalle käytännön ohjeita luokkavaltuustotoiminnan aloittamiseen omassa luokassaan. Luokkavaltuuston avulla on mahdollista lisätä kaikkien oppilaiden osallistumis- ja vaikutusmahdollisuuksia luokassa ja koko kouluyhteisössä. 	fi	364
1106	Oppaassa esitellään luokkavaltuustomalli ja annetaan opettajalle käytännön ohjeita luokkavaltuustotoiminnan aloittamiseen omassa luokassaan. Luokkavaltuuston avulla on mahdollista lisätä kaikkien oppilaiden osallistumis- ja vaikutusmahdollisuuksia luokassa ja koko kouluyhteisössä. 	sv	364
1107	Oppaassa esitellään luokkavaltuustomalli ja annetaan opettajalle käytännön ohjeita luokkavaltuustotoiminnan aloittamiseen omassa luokassaan. Luokkavaltuuston avulla on mahdollista lisätä kaikkien oppilaiden osallistumis- ja vaikutusmahdollisuuksia luokassa ja koko kouluyhteisössä. 	en	364
1099	Act Now -yhteiskuntapeli käynnistää aktiivista yhteiskunnallista keskustelua ja kehittää argumentointitaitoa. Pelilaudan kaupunkikuvaan tutustumalla oppilaat löytävät yhteiskunnallisia viittauksia ja käsitteitä. Pelikorttien avulla peli etenee, ja oppilaat pääsevät ratkaisemaan ongelmia, esittämään niiden ratkaisuihin johtavia toimintamalleja sekä argumentoimaan omien ratkaisujensa puolesta.	fi	362
1101	Act Now -yhteiskuntapeli käynnistää aktiivista yhteiskunnallista keskustelua ja kehittää argumentointitaitoa. Pelilaudan kaupunkikuvaan tutustumalla oppilaat löytävät yhteiskunnallisia viittauksia ja käsitteitä. Pelikorttien avulla peli etenee, ja oppilaat pääsevät ratkaisemaan ongelmia, esittämään niiden ratkaisuihin johtavia toimintamalleja sekä argumentoimaan omien ratkaisujensa puolesta.	en	362
1279	kuvaus	fi	385
1280	kuvaus	sv	385
1281	kuvaus	en	385
1285	kuvaus	fi	390
1286	kuvaus	sv	390
1287	kuvaus	en	390
1288	Pappiudesta jne	fi	391
1289	Pappiudesta jne	sv	391
1290	Pappiudesta jne	en	391
1314	Oppimateriaali kertoo kuinka lunta tulisi luoda äkkinäisten ja merkittävien lumipyryjen aikana, niiden jälkeen ja niitä ennen. Se antaa konkreettiset työkalut jokaisen lumitaistoon.	en	393
1381	Tämä testaa vielä lisää lomakkeen toimintaa	fi	399
1382	Tämä testaa vielä lisää lomakkeen toimintaa	sv	399
1383	Tämä testaa vielä lisää lomakkeen toimintaa	en	399
1387	Kokeillaan sähköä	fi	400
1388	Kokeillaan sähköä	sv	400
1389	Kokeillaan sähköä	en	400
1411	Kirjanen tarjoaa matematiikan oppimateriaalin varhaiskasvatukseen ja esiopetukseen. Matematiikan sisällöt esitellään tarinoiden kautta. Lapsille luettavan tarinan rinnalla opettajalle annetaan ideoita siitä, miten opetettavaa käsitettä voi havainnollistaa omassa ryhmässä helposti saatavilla olevilla välineillä. Tarjolla on myös kysymyksiä, joiden avulla voi herätellä keskustelua lasten kanssa. Kirjanen on syntynyt osana LUMATIKKA-hanketta. LUMATIKKA oli valtakunnallinen matematiikan oppimisen ja opettamisen täydennyskoulutushanke, jonka LUMA-keskus Suomi -verkosto toteutti yhteistyössä useiden yliopistojen ja ammattikorkeakoulujen kanssa vuosina 2018–2022. Hanketta rahoitti Opetushallitus.	fi	402
1412	Kirjanen tarjoaa matematiikan oppimateriaalin varhaiskasvatukseen ja esiopetukseen. Matematiikan sisällöt esitellään tarinoiden kautta. Lapsille luettavan tarinan rinnalla opettajalle annetaan ideoita siitä, miten opetettavaa käsitettä voi havainnollistaa omassa ryhmässä helposti saatavilla olevilla välineillä. Tarjolla on myös kysymyksiä, joiden avulla voi herätellä keskustelua lasten kanssa. Kirjanen on syntynyt osana LUMATIKKA-hanketta. LUMATIKKA oli valtakunnallinen matematiikan oppimisen ja opettamisen täydennyskoulutushanke, jonka LUMA-keskus Suomi -verkosto toteutti yhteistyössä useiden yliopistojen ja ammattikorkeakoulujen kanssa vuosina 2018–2022. Hanketta rahoitti Opetushallitus.	sv	402
1413	Kirjanen tarjoaa matematiikan oppimateriaalin varhaiskasvatukseen ja esiopetukseen. Matematiikan sisällöt esitellään tarinoiden kautta. Lapsille luettavan tarinan rinnalla opettajalle annetaan ideoita siitä, miten opetettavaa käsitettä voi havainnollistaa omassa ryhmässä helposti saatavilla olevilla välineillä. Tarjolla on myös kysymyksiä, joiden avulla voi herätellä keskustelua lasten kanssa. Kirjanen on syntynyt osana LUMATIKKA-hanketta. LUMATIKKA oli valtakunnallinen matematiikan oppimisen ja opettamisen täydennyskoulutushanke, jonka LUMA-keskus Suomi -verkosto toteutti yhteistyössä useiden yliopistojen ja ammattikorkeakoulujen kanssa vuosina 2018–2022. Hanketta rahoitti Opetushallitus.	en	402
1333		fi	394
1334		sv	394
1335		en	394
1390	Tallennu, vai ei tallennu, siinä vasta kysymys	fi	401
1391	Tallennu, vai ei tallennu, siinä vasta kysymys	sv	401
1392	Tallennu, vai ei tallennu, siinä vasta kysymys	en	401
1393		fi	292
1394		sv	292
1395		en	292
1417	Esitys aoesta	fi	403
1418	Esitys aoesta	sv	403
1419	Esitys aoesta	en	403
1339	Muokkauslomakkeelle eivät pääse oppimateriaalittomat oppilaat	fi	396
1340	Muokkauslomakkeelle eivät pääse oppimateriaalittomat oppilaat	sv	396
1341	Muokkauslomakkeelle eivät pääse oppimateriaalittomat oppilaat	en	396
1420	testausta 	fi	404
1421	testausta 	sv	404
1422	testausta 	en	404
1351		fi	309
1352		sv	309
1353		en	309
1315	Oppimateriaali näyttää ikkunoiden pesun edistyneemmän muodon: jäänpoiston ikkunoista. Tämän opiskeltuasi tiedät miten toimia tiukan paikan tullen!	fi	395
1316	Oppimateriaali näyttää ikkunoiden pesun edistyneemmän muodon: jäänpoiston ikkunoista. Tämän opiskeltuasi tiedät miten toimia tiukan paikan tullen!	sv	395
1317	Oppimateriaali näyttää ikkunoiden pesun edistyneemmän muodon: jäänpoiston ikkunoista. Tämän opiskeltuasi tiedät miten toimia tiukan paikan tullen!	en	395
1240	Testaukseen oeglobal-esitys	fi	381
1241	Testaukseen oeglobal-esitys	sv	381
1242	Testaukseen oeglobal-esitys	en	381
1423	Kielten oppimiseen ohjeistavaa, varsinainen materiaali aoe.fissä	fi	405
1424	Kielten oppimiseen ohjeistavaa, varsinainen materiaali aoe.fissä	sv	405
1425	Kielten oppimiseen ohjeistavaa, varsinainen materiaali aoe.fissä	en	405
1429	Varsinainen materiaali löytyy aoe.fistä, kokeilua varten täällä	fi	407
1430	Varsinainen materiaali löytyy aoe.fistä, kokeilua varten täällä	sv	407
1431	Varsinainen materiaali löytyy aoe.fistä, kokeilua varten täällä	en	407
1432	Varsinainen materiaali aoe.fissä	fi	408
1433	Varsinainen materiaali aoe.fissä	sv	408
1434	Varsinainen materiaali aoe.fissä	en	408
1435	Oikea materiaali aoe.fissä	fi	409
1436	Oikea materiaali aoe.fissä	sv	409
1437	Oikea materiaali aoe.fissä	en	409
1438	Testataan 	fi	251
1439	Testataan 	sv	251
1440	Testataan 	en	251
1441	Testausta	fi	359
1442	Testausta	sv	359
1443	Testausta	en	359
1450	pikatesti	fi	410
1451	pikatesti	sv	410
1452	pikatesti	en	410
1426	saavutettavuusohjeistus	fi	406
1427	saavutettavuusohjeistus	sv	406
1428	saavutettavuusohjeistus	en	406
841	Opi perusteet oppimateriaalien julkaisemisessa, niiden arvioinnissa ja itseä kiinnostavien oppimateriaalien organisoimisessa Avointen oppimateriaalien kirjastossa. Oppaan avulla löydät vastauksia esimerkiksi seuraaviin asioihin: Mitä tarkoittaa kuvailu ja miksi nähdä siihen vaivaa? Voiko toisten loistavia oppimateriaaleja nostaa esille tai kerätä itselle muistiin?\n\nOppimateriaali on tarkoitettu kirjaston käyttäjille. Se soveltuu myös organisaation sisäisen ohjeistuksen tueksi kun halutaan tukea ja kannustaa kirjaston käyttöön: upota-toiminnon avulla tai lataamalla voit upottaa ohjeistuksen myös esimerkiksi oman oppilaitoksesi sivuille.\n\nOppimateriaali koostuu julkaisua demoavasta ohjevideosta sekä dokumenteista, jossa käydään askel askeleelta läpi kuvien ja tekstin avulla julkaisun-, muokkauksen-, arvioinnin- ja kokoelmien-työkalujen toiminta.  	fi	306
842	Tämä materiaali opastaa Avointen oppimateriaalien kirjaston käyttöön: oppimateriaalien tallentamiseen palveluun, jo tallennetun materiaalien tietojen muokkaamiseen ja oppimateriaalikokoelmien tekemiseen. Upota-toiminnon avulla voit upottaa ohjeistuksen myös esimerkiksi oman oppilaitoksesi sivuille.	sv	306
843	Tämä materiaali opastaa Avointen oppimateriaalien kirjaston käyttöön: oppimateriaalien tallentamiseen palveluun, jo tallennetun materiaalien tietojen muokkaamiseen ja oppimateriaalikokoelmien tekemiseen. Upota-toiminnon avulla voit upottaa ohjeistuksen myös esimerkiksi oman oppilaitoksesi sivuille.	en	306
1480	Testailen raskaita materiaaleja	fi	420
1481	Testailen raskaita materiaaleja	sv	420
1482	Testailen raskaita materiaaleja	en	420
\.


--
-- Data for Name: materialdisplayname; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.materialdisplayname (id, displayname, language, materialid) FROM stdin;
1	testikuva	fi	1
2	testikuva	sv	1
3	testikuva	en	1
4	Opeta puheentuottoa	fi	2
5	6_puheentuotto_opettajalle	sv	2
6	6_puheentuotto_opettajalle	en	2
7	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	fi	4
8	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	sv	4
9	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	en	4
10	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2	fi	5
11	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2	sv	5
12	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2	en	5
13	Python from Scratch	fi	19
14	python-master-paivitetty	sv	19
15	python-master-paivitetty	en	19
16	Python from Scratch	fi	20
17	python_sv-master-paivitetty	sv	20
18	python_sv-master-paivitetty	en	20
19	Python from Scratch	fi	21
20	python_en-master-paivitetty	sv	21
21	python_en-master-paivitetty	en	21
22	Johdatus tekoälyyn	fi	22
23	Johdatus tekoälyyn	sv	22
24	Johdatus tekoälyyn	en	22
25	Introduktion till artificiell intelligens	fi	23
26	Introduktion till artificiell intelligens	sv	23
27	Introduktion till artificiell intelligens	en	23
28	Introduction to artificial intelligence	fi	24
29	_Introduction to artificial intelligence	sv	24
30	_Introduction to artificial intelligence	en	24
31	b Podcast  Digipedagogiikka - teksti	fi	44
32	b Podcast  Digipedagogiikka - teksti	sv	44
33	b Podcast  Digipedagogiikka - teksti	en	44
34	A Podcast Digipedagogiikka	fi	45
35	A Podcast Digipedagogiikka	sv	45
36	A Podcast Digipedagogiikka	en	45
37	b Podcast  Digipedagogiikka - teksti	fi	46
38	b Podcast  Digipedagogiikka - teksti	sv	46
39	b Podcast  Digipedagogiikka - teksti	en	46
40	A Podcast Digipedagogik	fi	47
41	A Podcast Digipedagogik	sv	47
42	A Podcast Digipedagogik	en	47
43	b Podcast Digipedagogik text	fi	48
44	b Podcast Digipedagogik text	sv	48
45	b Podcast Digipedagogik text	en	48
46	A Podcast Digital Pedagogy	fi	49
47	A Podcast Digital Pedagogy	sv	49
48	A Podcast Digital Pedagogy	en	49
49	b Podcast Digital pedagogy - text  	fi	50
50	b Podcast Digital pedagogy - text  	sv	50
51	b Podcast Digital pedagogy - text  	en	50
52	b Video Digitaalisuus ja teknologia kouluissa - teksti	fi	51
53	b Video Digitaalisuus ja teknologia kouluissa - teksti	sv	51
54	b Video Digitaalisuus ja teknologia kouluissa - teksti	en	51
55	A Video Digitaalisuus ja teknologia kouluissa	fi	52
56	A Video Digitaalisuus ja teknologia kouluissa	sv	52
57	A Video Digitaalisuus ja teknologia kouluissa	en	52
58	b Video Digitaalisuus ja teknologia kouluissa - teksti	fi	53
59	b Video Digitaalisuus ja teknologia kouluissa - teksti	sv	53
60	b Video Digitaalisuus ja teknologia kouluissa - teksti	en	53
61	A Video Digitalisering och teknologi i skolor	fi	54
62	A Video Digitalisering och teknologi i skolor	sv	54
63	A Video Digitalisering och teknologi i skolor	en	54
64	b Video Digitalisering och teknologi i skolor text	fi	55
65	b Video Digitalisering och teknologi i skolor text	sv	55
66	b Video Digitalisering och teknologi i skolor text	en	55
67	A Video Digitalization and technology in schools	fi	56
68	A Video Digitalization and technology in schools	sv	56
69	A Video Digitalization and technology in schools	en	56
70	b Video Digitalization and technology in schools - text	fi	57
71	b Video Digitalization and technology in schools - text	sv	57
72	b Video Digitalization and technology in schools - text	en	57
73	A Video Opetuksen ja oppimisen suunnittelu	fi	58
74	A Video Opetuksen ja oppimisen suunnittelu	sv	58
75	A Video Opetuksen ja oppimisen suunnittelu	en	58
76	b Video Opetuksen ja oppimisen suunnittelu - teksti  	fi	59
77	b Video Opetuksen ja oppimisen suunnittelu - teksti  	sv	59
78	b Video Opetuksen ja oppimisen suunnittelu - teksti  	en	59
79	c Infotaulu Opetuksen ja oppimisen suunnittelu	fi	60
80	c Infotaulu Opetuksen ja oppimisen suunnittelu	sv	60
81	c Infotaulu Opetuksen ja oppimisen suunnittelu	en	60
82	A Video Planering av undervisning och lärande	fi	61
83	A Video Planering av undervisning och lärande	sv	61
84	A Video Planering av undervisning och lärande	en	61
85	b Video Planering av undervisning och lärande text	fi	62
86	b Video Planering av undervisning och lärande text	sv	62
87	b Video Planering av undervisning och lärande text	en	62
88	c Infograf Planering av undervisning och lärande	fi	63
89	c Infograf Planering av undervisning och lärande	sv	63
90	c Infograf Planering av undervisning och lärande	en	63
91	A Video Learning design	fi	64
92	A Video Learning design	sv	64
93	A Video Learning design	en	64
94	b Video Learning design text script	fi	65
95	b Video Learning design text script	sv	65
96	b Video Learning design text script	en	65
97	c Infograf Learning Design	fi	66
98	c Infograf Learning Design	sv	66
99	c Infograf Learning Design	en	66
100	A Podcast Oppimistehtävä	fi	72
101	A Podcast Oppimistehtävä	sv	72
102	A Podcast Oppimistehtävä	en	72
103	b Podcast Oppimistehtävä - teksti  	fi	73
104	b Podcast Oppimistehtävä - teksti  	sv	73
105	b Podcast Oppimistehtävä - teksti  	en	73
106	c Oppimistehtäväideoita oppimisprosessin eri vaiheisiin	fi	74
107	c Oppimistehtäväideoita oppimisprosessin eri vaiheisiin	sv	74
108	c Oppimistehtäväideoita oppimisprosessin eri vaiheisiin	en	74
109	d Oppimistehtävän suunnittelu	fi	75
110	d Oppimistehtävän suunnittelu	sv	75
111	d Oppimistehtävän suunnittelu	en	75
112	A Podcast Läruppgifter	fi	76
113	A Podcast Läruppgifter	sv	76
114	A Podcast Läruppgifter	en	76
115	b Podcast Läruppgifter text	fi	77
116	b Podcast Läruppgifter text	sv	77
117	b Podcast Läruppgifter text	en	77
118	c Ideer för läruppgifter	fi	78
119	c Ideer för läruppgifter	sv	78
120	c Ideer för läruppgifter	en	78
121	d Planeringsblankett läruppgifter	fi	79
122	d Planeringsblankett läruppgifter	sv	79
123	d Planeringsblankett läruppgifter	en	79
124	A Podcast Learning assignments	fi	80
125	A Podcast Learning assignments	sv	80
126	A Podcast Learning assignments	en	80
127	b Podcast Learning assignments text 	fi	81
128	b Podcast Learning assignments text 	sv	81
129	b Podcast Learning assignments text 	en	81
130	c Infograf Learning assignment ideas	fi	82
131	c Infograf Learning assignment ideas	sv	82
132	c Infograf Learning assignment ideas	en	82
133	d Planning learning assignments 	fi	83
134	d Planning learning assignments 	sv	83
135	d Planning learning assignments 	en	83
136	Miten tuetaan opiskelijoiden yhteisöllisyyden kehittymistä 1	fi	84
137	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	sv	84
138	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	en	84
139	Ohjeistus_oppimateriaalien_tallentamiseen_SV2	fi	87
140	Ohjeistus_oppimateriaalien_tallentamiseen_SV2	sv	87
141	Ohjeistus_oppimateriaalien_tallentamiseen_SV2	en	87
142	Johdatus robotiikan opettamiseen	fi	88
143	Johdatus robotiikan opettamiseen	sv	88
144	Johdatus robotiikan opettamiseen	en	88
145	4.1 EV3_n ohjelmointi simulaattorissa	fi	89
146	4.1 EV3_n ohjelmointi simulaattorissa	sv	89
147	4.1 EV3_n ohjelmointi simulaattorissa	en	89
148	4.2 Micro_bitin ohjelmointi MakeCode_ssa	fi	90
149	4.2 Micro_bitin ohjelmointi MakeCode_ssa	sv	90
150	4.2 Micro_bitin ohjelmointi MakeCode_ssa	en	90
151	Liite 1 - Robotiikan oppimisen polku	fi	91
152	Liite 1 - Robotiikan oppimisen polku	sv	91
153	Liite 1 - Robotiikan oppimisen polku	en	91
154	Liite 2_ Micro_bit KPS	fi	92
155	Liite 2_ Micro_bit KPS	sv	92
156	Liite 2_ Micro_bit KPS	en	92
157	Introduktion till undervisningen i robotik	fi	93
158	Introduktion till undervisningen i robotik	sv	93
159	Introduktion till undervisningen i robotik	en	93
160	4.1 EV3_n ohjelmointi simulaattorissa_sv	fi	94
161	4.1 EV3_n ohjelmointi simulaattorissa_sv	sv	94
162	4.1 EV3_n ohjelmointi simulaattorissa_sv	en	94
163	4.2 Micro_bitin ohjelmointi MakeCode_ssa_sv	fi	95
164	4.2 Micro_bitin ohjelmointi MakeCode_ssa_sv	sv	95
165	4.2 Micro_bitin ohjelmointi MakeCode_ssa_sv	en	95
166	Liite 1 - Robotiikan oppimisen polku_teksti_sv	fi	96
167	Liite 1 - Robotiikan oppimisen polku_teksti_sv	sv	96
168	Liite 1 - Robotiikan oppimisen polku_teksti_sv	en	96
169	Liite 2_ Micro_bit KPS sv	fi	97
170	Liite 2_ Micro_bit KPS sv	sv	97
171	Liite 2_ Micro_bit KPS sv	en	97
172	Introduction to teaching robotics	fi	98
173	Introduction to teaching robotics	sv	98
174	Introduction to teaching robotics	en	98
175	4.1 EV3 programming in a simulator	fi	99
176	4.1 EV3 programming in a simulator	sv	99
177	4.1 EV3 programming in a simulator	en	99
178	4.2 Micro_bit programming in MakeCode	fi	100
179	4.2 Micro_bit programming in MakeCode	sv	100
180	4.2 Micro_bit programming in MakeCode	en	100
181	Näin teet avoimia oppimateriaaleja	fi	126
182	Näin teet avoimia oppimateriaaleja	sv	126
183	Näin teet avoimia oppimateriaaleja	en	126
184	Skriva öppna lärresurser	fi	127
185	Skriva öppna lärresurser	sv	127
186	Skriva öppna lärresurser	en	127
187	suurin-sallittu-johdon-pituus-236	fi	128
188	suurin-sallittu-johdon-pituus-236	sv	128
189	suurin-sallittu-johdon-pituus-236	en	128
190	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	fi	130
191	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	sv	130
192	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	en	130
193	5 b Kirjain_äänne_opiskelijalle	fi	131
194	5 b Kirjain_äänne_opiskelijalle	sv	131
195	5 b Kirjain_äänne_opiskelijalle	en	131
196	lisää oppimateriaali	fi	132
197		sv	132
198		en	132
199	fi-3-digipedagogiikka	fi	133
200	fi-3-digipedagogiikka	sv	133
201	fi-3-digipedagogiikka	en	133
202	5 b Kirjain_äänne_opiskelijalle	fi	134
203	5 b Kirjain_äänne_opiskelijalle	sv	134
204	5 b Kirjain_äänne_opiskelijalle	en	134
205	6b Puheentuotto_opiskelijalle	fi	135
206	6b Puheentuotto_opiskelijalle	sv	135
207	6b Puheentuotto_opiskelijalle	en	135
208	fi-3-digipedagogiikka	fi	136
209	fi-3-digipedagogiikka	sv	136
210	fi-3-digipedagogiikka	en	136
211	5 b Kirjain_äänne_opiskelijalle	fi	137
212	5 b Kirjain_äänne_opiskelijalle	sv	137
213	5 b Kirjain_äänne_opiskelijalle	en	137
214	fi-3-digipedagogiikka	fi	138
215	fi-3-digipedagogiikka	sv	138
216	fi-3-digipedagogiikka	en	138
217	7_miten_opetetaan_opiskelijoita_etsimään_verkossa	fi	139
218	7_miten_opetetaan_opiskelijoita_etsimään_verkossa	sv	139
219	7_miten_opetetaan_opiskelijoita_etsimään_verkossa	en	139
220	5 b Kirjain_äänne_opiskelijalle	fi	140
221	5 b Kirjain_äänne_opiskelijalle	sv	140
222	5 b Kirjain_äänne_opiskelijalle	en	140
223	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	fi	141
224	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	sv	141
225	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	en	141
226	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	fi	142
227	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	sv	142
228	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	en	142
229	5 b Kirjain_äänne_opiskelijalle	fi	143
230	5 b Kirjain_äänne_opiskelijalle	sv	143
231	5 b Kirjain_äänne_opiskelijalle	en	143
232	fi-3-digipedagogiikka	fi	144
233	fi-3-digipedagogiikka	sv	144
234	fi-3-digipedagogiikka	en	144
235	Video	fi	145
236	Video	sv	145
237	Video	en	145
238	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	fi	146
239	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	sv	146
240	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	en	146
241	adsadsa	fi	147
242		sv	147
243		en	147
244	esitys	fi	148
245	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2	sv	148
246	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2	en	148
247	7_miten_opetetaan_opiskelijoita_etsimään_verkossa	fi	149
248	7_miten_opetetaan_opiskelijoita_etsimään_verkossa	sv	149
249	7_miten_opetetaan_opiskelijoita_etsimään_verkossa	en	149
250	linkki	fi	150
251		sv	150
252		en	150
253	10_arviointi_virtuaaliluokassa	fi	151
254	10_arviointi_virtuaaliluokassa	sv	151
255	10_arviointi_virtuaaliluokassa	en	151
256	linkki	fi	152
257		sv	152
258		en	152
259	esitys	fi	153
260	6_puheentuotto_opettajalle	sv	153
261	6_puheentuotto_opettajalle	en	153
262	Opiskelijan materiaali	fi	154
263		sv	154
264		en	154
265	Opeta kirjain äänne -vastaavuutta	fi	155
266	5_kirjain_äänne_opettajalle	sv	155
267	5_kirjain_äänne_opettajalle	en	155
268	Näin teet avoimia oppimateriaaleja	fi	156
269	Näin teet avoimia oppimateriaaleja	sv	156
270	Näin teet avoimia oppimateriaaleja	en	156
271	Skriva öppna lärresurser	fi	69
272	Skriva öppna lärresurser	sv	69
273	Skriva öppna lärresurser	en	69
274	Skriva öppna lärresurser	fi	70
275	Skriva öppna lärresurser	sv	70
276	Skriva öppna lärresurser	en	70
277	Skriva öppna lärresurser	fi	102
278	Skriva öppna lärresurser	sv	102
279	Skriva öppna lärresurser	en	102
280	Kirjain-äänne-vastaavuus	fi	157
281		sv	157
282		en	157
283	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2	fi	158
284	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2	sv	158
285	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2	en	158
286	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	fi	159
287	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	sv	159
288	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	en	159
289	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	fi	160
290	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	sv	160
291	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	en	160
292	5 b Kirjain_äänne_opiskelijalle	fi	161
293	5 b Kirjain_äänne_opiskelijalle	sv	161
294	5 b Kirjain_äänne_opiskelijalle	en	161
295	Kirjain-äänne-vastaavuus	fi	162
296		sv	162
297		en	162
298	Kirjain-äänne-vastaavuus opettajalle	fi	163
299	5_kirjain_äänne_opettajalle	sv	163
300	5_kirjain_äänne_opettajalle	en	163
301	Kirjain-äänne-vastaavuus	fi	164
302		sv	164
303		en	164
304	Kirjain-äänne-vastaavuus	fi	165
305		sv	165
306		en	165
307	Kirjain-äänne-vastaavuus opettajalle	fi	166
308	5_kirjain_äänne_opettajalle	sv	166
309	5_kirjain_äänne_opettajalle	en	166
310	Kirjain-äänne-vastaavuus opettajalle	fi	167
311	5_kirjain_äänne_opettajalle	sv	167
312	5_kirjain_äänne_opettajalle	en	167
313	Kirjain-äänne-vastaavuus	fi	168
314		sv	168
315		en	168
316	hgfhdgfgdfgfd	fi	169
317		sv	169
318		en	169
319	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	fi	170
320	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	sv	170
321	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	en	170
322	Skriva öppna lärresurser	fi	171
323	Skriva öppna lärresurser	sv	171
324	Skriva öppna lärresurser	en	171
325	Oppimistehtävien suunnittelu	fi	172
326		sv	172
327		en	172
328	15_tekijänoikeudet_virtuaaliluokassa_miten_ohjaan_opiskelijoita	fi	173
329	15_tekijänoikeudet_virtuaaliluokassa_miten_ohjaan_opiskelijoita	sv	173
330	15_tekijänoikeudet_virtuaaliluokassa_miten_ohjaan_opiskelijoita	en	173
331	6b Puheentuotto_opiskelijalle	fi	174
332	6b Puheentuotto_opiskelijalle	sv	174
333	6b Puheentuotto_opiskelijalle	en	174
334	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	fi	175
335	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	sv	175
336	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	en	175
337	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2	fi	176
338	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2	sv	176
339	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2	en	176
340	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	fi	177
341	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	sv	177
342	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	en	177
343	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2	fi	178
344	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2	sv	178
345	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2	en	178
346	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	fi	179
347	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	sv	179
348	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	en	179
349	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	fi	180
350	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	sv	180
351	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	en	180
352	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2	fi	181
353	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2	sv	181
354	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2	en	181
355	5_kirjain_äänne_opettajalle	fi	182
356	5_kirjain_äänne_opettajalle	sv	182
357	5_kirjain_äänne_opettajalle	en	182
358	5 b Kirjain_äänne_opiskelijalle	fi	183
359	5 b Kirjain_äänne_opiskelijalle	sv	183
360	5 b Kirjain_äänne_opiskelijalle	en	183
361	7_miten_opetetaan_opiskelijoita_etsimään_verkossa	fi	184
362	7_miten_opetetaan_opiskelijoita_etsimään_verkossa	sv	184
363	7_miten_opetetaan_opiskelijoita_etsimään_verkossa	en	184
364	10_arviointi_virtuaaliluokassa	fi	185
365	10_arviointi_virtuaaliluokassa	sv	185
366	10_arviointi_virtuaaliluokassa	en	185
367	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2	fi	186
473	test-pdf-mroppone	sv	221
368	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2	sv	186
369	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2	en	186
370	15_tekijänoikeudet_virtuaaliluokassa_miten_ohjaan_opiskelijoita	fi	187
371	15_tekijänoikeudet_virtuaaliluokassa_miten_ohjaan_opiskelijoita	sv	187
372	15_tekijänoikeudet_virtuaaliluokassa_miten_ohjaan_opiskelijoita	en	187
373	6_puheentuotto_opettajalle	fi	188
374	6_puheentuotto_opettajalle	sv	188
375	6_puheentuotto_opettajalle	en	188
376	Kuinka tehdä avoimia oppimateriaaleja	fi	189
377	Kuinka tehdä avoimia oppimateriaaleja	sv	189
378	Kuinka tehdä avoimia oppimateriaaleja	en	189
379	Skriva öppna lärresurser	fi	190
380	Skriva öppna lärresurser	sv	190
381	Skriva öppna lärresurser	en	190
382	testilinkki	fi	191
383		sv	191
384		en	191
385	esitysnimi	fi	192
386		sv	192
387		en	192
388	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	fi	193
389	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	sv	193
390	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	en	193
391	testikuva	fi	194
392	testikuva	sv	194
393	testikuva	en	194
394	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	fi	195
395	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	sv	195
396	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	en	195
397	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2	fi	196
398	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2	sv	196
399	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2	en	196
400	A Infotaulu Opetuksen digitaaliset välineet	fi	197
401	A Infotaulu Opetuksen digitaaliset välineet	sv	197
402	A Infotaulu Opetuksen digitaaliset välineet	en	197
403	b Infotaulu Opiskelun digivälineet	fi	198
404	b Infotaulu Opiskelun digivälineet	sv	198
405	b Infotaulu Opiskelun digivälineet	en	198
406	A Infograf Digital tools for teaching	fi	199
407	A Infograf Digital tools for teaching	sv	199
408	A Infograf Digital tools for teaching	en	199
409	b Infograf Digital tools for studying	fi	200
410	b Infograf Digital tools for studying	sv	200
411	b Infograf Digital tools for studying	en	200
412	Infograf Digitala verktyg för undervisningen	fi	201
413	Infograf Digitala verktyg för undervisningen	sv	201
414	Infograf Digitala verktyg för undervisningen	en	201
415	Infograf Digitala verktyg för studier	fi	202
416	Infograf Digitala verktyg för studier	sv	202
417	Infograf Digitala verktyg för studier	en	202
418	Näin teet avoimia oppimateriaaleja	fi	203
419	Näin teet avoimia oppimateriaaleja	sv	203
420	Näin teet avoimia oppimateriaaleja	en	203
421	Skriva öppna lärresurser	fi	204
422	Skriva öppna lärresurser	sv	204
423	Skriva öppna lärresurser	en	204
424	Digipeda	fi	205
425		sv	205
426		en	205
427	Video	fi	206
428	fi-3-digipedagogiikka	sv	206
429	fi-3-digipedagogiikka	en	206
430	test-docx-mroppone	fi	207
431	test-docx-mroppone	sv	207
432	test-docx-mroppone	en	207
433	test-pdf-mroppone	fi	208
434	test-pdf-mroppone	sv	208
435	test-pdf-mroppone	en	208
436	Näin teet avoimia oppimateriaaleja	fi	209
437	Näin teet avoimia oppimateriaaleja	sv	209
438	Näin teet avoimia oppimateriaaleja	en	209
439	test-pdf-mroppone	fi	210
440	test-pdf-mroppone	sv	210
441	test-pdf-mroppone	en	210
442	test-pdf-mroppone	fi	211
443	test-pdf-mroppone	sv	211
444	test-pdf-mroppone	en	211
445	test-pdf-mroppone	fi	212
446	test-pdf-mroppone	sv	212
447	test-pdf-mroppone	en	212
448	test-docx-mroppone	fi	213
449	test-docx-mroppone	sv	213
450	test-docx-mroppone	en	213
451	test-pdf-mroppone	fi	214
452	test-pdf-mroppone	sv	214
453	test-pdf-mroppone	en	214
460	5 b Kirjain_äänne_opiskelijalle	fi	217
461	5 b Kirjain_äänne_opiskelijalle	sv	217
462	5 b Kirjain_äänne_opiskelijalle	en	217
463	test-pdf-mroppone	fi	218
464	test-pdf-mroppone	sv	218
465	test-pdf-mroppone	en	218
454	test-docx-mroppone	fi	215
455	test-docx-mroppone	sv	215
469	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2	fi	220
470	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2	sv	220
471	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2	en	220
472	test-pdf-mroppone	fi	221
474	test-pdf-mroppone	en	221
475	5 b Kirjain_äänne_opiskelijalle	fi	222
476	5 b Kirjain_äänne_opiskelijalle	sv	222
477	5 b Kirjain_äänne_opiskelijalle	en	222
478	test-docx-mroppone	fi	223
479	test-docx-mroppone	sv	223
480	test-docx-mroppone	en	223
481	test-pdf-mroppone	fi	224
482	test-pdf-mroppone	sv	224
483	test-pdf-mroppone	en	224
484	Näin teet avoimia oppimateriaaleja	fi	225
485	Näin teet avoimia oppimateriaaleja	sv	225
486	Näin teet avoimia oppimateriaaleja	en	225
487	test-pdf-mroppone	fi	226
488	test-pdf-mroppone	sv	226
489	test-pdf-mroppone	en	226
490	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	fi	227
491	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	sv	227
492	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	en	227
493	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	fi	228
494	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	sv	228
495	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	en	228
496	test-pdf-mroppone	fi	229
497	test-pdf-mroppone	sv	229
498	test-pdf-mroppone	en	229
499	test-pdf-mroppone	fi	230
500	test-pdf-mroppone	sv	230
501	test-pdf-mroppone	en	230
502	test-docx-mroppone	fi	231
503	test-docx-mroppone	sv	231
504	test-docx-mroppone	en	231
505	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	fi	232
506	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	sv	232
507	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	en	232
511	digia_logo_rgb	fi	234
512	digia_logo_rgb	sv	234
513	digia_logo_rgb	en	234
514	Näin teet avoimia oppimateriaaleja	fi	235
515	Näin teet avoimia oppimateriaaleja	sv	235
516	Näin teet avoimia oppimateriaaleja	en	235
517	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	fi	236
518	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	sv	236
519	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	en	236
520	Linkedin_metsa2	fi	237
521	Linkedin_metsa2	sv	237
522	Linkedin_metsa2	en	237
523	fi-3-digipedagogiikka	fi	238
524	fi-3-digipedagogiikka	sv	238
525	fi-3-digipedagogiikka	en	238
526	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2	fi	239
527	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2	sv	239
528	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2	en	239
529	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	fi	240
530	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	sv	240
531	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	en	240
532	5 b Kirjain_äänne_opiskelijalle	fi	241
533	5 b Kirjain_äänne_opiskelijalle	sv	241
534	5 b Kirjain_äänne_opiskelijalle	en	241
535	1	fi	242
536	1	sv	242
537	1	en	242
538	Linkedin_metsa2	fi	243
539	Linkedin_metsa2	sv	243
540	Linkedin_metsa2	en	243
541	298571407	fi	244
542	298571407	sv	244
543	298571407	en	244
544	Näin teet avoimia oppimateriaaleja	fi	245
545	Näin teet avoimia oppimateriaaleja	sv	245
546	Näin teet avoimia oppimateriaaleja	en	245
547	kokeiluvideo	fi	246
548	kokeiluvideo	sv	246
549	kokeiluvideo	en	246
550	Α α, Β β, Γ γ, Δ δ, Ε ε, Ζ ζ, Η η, Θ θ, Ι ι, Κ κ, Λ λ, Μ μ, Ν ν, Ξ ξ, Ο ο, Π π, Ρ ρ, Σ σ:ς, Τ τ, Υ υ, Φ φ, Χ χ, Ψ ψ, and Ω ω	fi	247
551	Α α, Β β, Γ γ, Δ δ, Ε ε, Ζ ζ, Η η, Θ θ, Ι ι, Κ κ, Λ λ, Μ μ, Ν ν, Ξ ξ, Ο ο, Π π, Ρ ρ, Σ σ:ς, Τ τ, Υ υ, Φ φ, Χ χ, Ψ ψ, and Ω ω	sv	247
552	Α α, Β β, Γ γ, Δ δ, Ε ε, Ζ ζ, Η η, Θ θ, Ι ι, Κ κ, Λ λ, Μ μ, Ν ν, Ξ ξ, Ο ο, Π π, Ρ ρ, Σ σ:ς, Τ τ, Υ υ, Φ φ, Χ χ, Ψ ψ, and Ω ω	en	247
553	testikuva	fi	248
554	testikuva	sv	248
555	testikuva	en	248
556	9_miten_ylläpitää_motivaatio_oppimiseen_koulupäivän_jälkeen	fi	249
557	9_miten_ylläpitää_motivaatio_oppimiseen_koulupäivän_jälkeen	sv	249
558	9_miten_ylläpitää_motivaatio_oppimiseen_koulupäivän_jälkeen	en	249
559	6_puheentuotto_opettajalle	fi	250
560	6_puheentuotto_opettajalle	sv	250
771	avoinjulkaiseminen	en	354
561	6_puheentuotto_opettajalle	en	250
562	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2	fi	251
563	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2	sv	251
564	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2	en	251
565	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	fi	252
566	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	sv	252
567	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	en	252
568	14_tekijänoikeudet_virtuaaliluokassa_opettajan_oikeudet	fi	253
569	14_tekijänoikeudet_virtuaaliluokassa_opettajan_oikeudet	sv	253
570	14_tekijänoikeudet_virtuaaliluokassa_opettajan_oikeudet	en	253
571	testikuva	fi	254
572	testikuva	sv	254
573	testikuva	en	254
574	Näin teet avoimia oppimateriaaleja	fi	255
575	Näin teet avoimia oppimateriaaleja	sv	255
576	Näin teet avoimia oppimateriaaleja	en	255
577	Skriva öppna lärresurser	fi	256
578	Skriva öppna lärresurser	sv	256
579	Skriva öppna lärresurser	en	256
580	Skriva öppna lärresurser	fi	257
581	Skriva öppna lärresurser	sv	257
582	Skriva öppna lärresurser	en	257
583	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	fi	258
584	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	sv	258
585	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	en	258
586	10_arviointi_virtuaaliluokassa	fi	259
587	10_arviointi_virtuaaliluokassa	sv	259
588	10_arviointi_virtuaaliluokassa	en	259
589	6_puheentuotto_opettajalle	fi	260
590	6_puheentuotto_opettajalle	sv	260
591	6_puheentuotto_opettajalle	en	260
592	7_miten_opetetaan_opiskelijoita_etsimään_verkossa	fi	261
593	7_miten_opetetaan_opiskelijoita_etsimään_verkossa	sv	261
594	7_miten_opetetaan_opiskelijoita_etsimään_verkossa	en	261
595	15_tekijänoikeudet_virtuaaliluokassa_miten_ohjaan_opiskelijoita	fi	262
596	15_tekijänoikeudet_virtuaaliluokassa_miten_ohjaan_opiskelijoita	sv	262
597	15_tekijänoikeudet_virtuaaliluokassa_miten_ohjaan_opiskelijoita	en	262
598	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2	fi	263
599	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2	sv	263
600	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2	en	263
601	2	fi	264
602	1	sv	264
603	1	en	264
604	3	fi	265
605	10_arviointi_virtuaaliluokassa	sv	265
606	10_arviointi_virtuaaliluokassa	en	265
607	1	fi	266
608	5 b Kirjain_äänne_opiskelijalle	sv	266
609	5 b Kirjain_äänne_opiskelijalle	en	266
610	esitys	fi	267
611	7_miten_opetetaan_opiskelijoita_etsimään_verkossa	sv	267
612	7_miten_opetetaan_opiskelijoita_etsimään_verkossa	en	267
613	video	fi	268
614	fi-3-digipedagogiikka	sv	268
615	fi-3-digipedagogiikka	en	268
616	1. Yleiskatsaus automaatioon ja robotiikkaan	fi	303
617	1. Yleiskatsaus automaatioon ja robotiikkaan	sv	303
618	1. Yleiskatsaus automaatioon ja robotiikkaan	en	303
619	3.1 Opetukseen ja opiskeluun soveltuvat laitteet	fi	304
620	3.1 Opetukseen ja opiskeluun soveltuvat laitteet	sv	304
621	3.1 Opetukseen ja opiskeluun soveltuvat laitteet	en	304
622	2. Robotiikka yhteiskunnassa	fi	305
623	2. Robotiikka yhteiskunnassa	sv	305
624	2. Robotiikka yhteiskunnassa	en	305
625	lab1	fi	306
626	lab1	sv	306
627	lab1	en	306
628		fi	307
629		sv	307
630	oho	en	307
631		fi	308
632		sv	308
633	tyopeda	en	308
634	test-pdf-mroppone	fi	309
635	test-pdf-mroppone	sv	309
636	test-pdf-mroppone	en	309
637	test-docx-mroppone	fi	310
638	test-docx-mroppone	sv	310
639	test-docx-mroppone	en	310
640	test-pdf-mroppone	fi	311
641	test-pdf-mroppone	sv	311
642	test-pdf-mroppone	en	311
643	test-docx-mroppone	fi	312
644	test-docx-mroppone	sv	312
645	test-docx-mroppone	en	312
646	test-pdf-mroppone	fi	313
647	test-pdf-mroppone	sv	313
648	test-pdf-mroppone	en	313
649	Löydä materiaalisi	fi	314
650		sv	314
651		en	314
652	Kirjain-äänne-vastaavuus	fi	315
653		sv	315
654		en	315
655	test-docx-mroppone	fi	316
656	test-docx-mroppone	sv	316
657	test-docx-mroppone	en	316
658	test-pdf-mroppone	fi	317
659	test-pdf-mroppone	sv	317
660	test-pdf-mroppone	en	317
772	avoinjulkaiseminen	fi	355
661	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	fi	318
662	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	sv	318
663	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	en	318
664	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2	fi	319
665	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2	sv	319
666	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2	en	319
667	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	fi	320
668	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	sv	320
669	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	en	320
670	aoe demo linkki	fi	321
671	på svenska	sv	321
672	in english	en	321
673	testikuva	fi	322
674	testikuva sve	sv	322
675	testikuva eng	en	322
676	fi-3-digipedagogiikka	fi	323
677	fi-3-digipedagogiikka	sv	323
678	fi-3-digipedagogiikka	en	323
679	Screenshot from 2019-12-12 07-49-56	fi	324
680	Screenshot from 2019-12-12 07-49-56	sv	324
681	Screenshot from 2019-12-12 07-49-56	en	324
682	Screenshot from 2019-12-12 07-49-56	fi	325
683	Screenshot from 2019-12-12 07-49-56	sv	325
684	Screenshot from 2019-12-12 07-49-56	en	325
685	ohjeet	fi	326
686	ohjeet	sv	326
687	ohjeet	en	326
688	lahioikeudet	fi	327
689	lahioikeudet	sv	327
690	lahioikeudet	en	327
691	del1	fi	328
692	del1	sv	328
693	del1	en	328
694	ohjeet	fi	329
695	ohjeet	sv	329
696	ohjeet	en	329
697	Screenshot from 2019-12-12 07-49-56	fi	330
698	Screenshot from 2019-12-12 07-49-56	sv	330
699	Screenshot from 2019-12-12 07-49-56	en	330
700	ohjeet	fi	331
701	ohjeet	sv	331
702	ohjeet	en	331
703	lahioikeudet	fi	332
704	lahioikeudet	sv	332
705	lahioikeudet	en	332
706	sitaatit	fi	333
707	sitaatit	sv	333
708	sitaatit	en	333
709	lahioikeudet	fi	334
710	lahioikeudet	sv	334
711	lahioikeudet	en	334
712	Copyrights in education	fi	335
713	Copyrights in education	sv	335
714	Copyrights in education	en	335
715	Copyrights in education	fi	336
716	Copyrights in education	sv	336
717	Copyrights in education	en	336
718	lahioikeudet	fi	337
719	lahioikeudet	sv	337
720	lahioikeudet	en	337
721	ohjeet	fi	338
722	ohjeet	sv	338
723	ohjeet	en	338
724	lahioikeudet	fi	339
725	lahioikeudet	sv	339
726	lahioikeudet	en	339
727	Avoin julkaiseminen	fi	340
728	avoinjulkaiseminen	sv	340
729	avoinjulkaiseminen	en	340
730	Tekijnoikeudet opetuksessa	fi	341
731	Tekijnoikeudet opetuksessa	sv	341
732	Tekijnoikeudet opetuksessa	en	341
733	Avoin julkaiseminen	fi	342
734	avoinjulkaiseminen	sv	342
735	avoinjulkaiseminen	en	342
745	ohjeet	fi	346
746	ohjeet	sv	346
747	ohjeet	en	346
748	lahioikeudet	fi	347
749	lahioikeudet	sv	347
750	lahioikeudet	en	347
751	sitaatit	fi	348
752	sitaatit	sv	348
753	sitaatit	en	348
754	lahioikeudet	fi	349
755	lahioikeudet	sv	349
756	lahioikeudet	en	349
757	fi-3-digipedagogiikka	fi	350
758	fi-3-digipedagogiikka	sv	350
759	fi-3-digipedagogiikka	en	350
760	avoinjulkaiseminen	fi	351
761	avoinjulkaiseminen	sv	351
762	avoinjulkaiseminen	en	351
763	fi-3-digipedagogiikka	fi	352
764	fi-3-digipedagogiikka	sv	352
765	fi-3-digipedagogiikka	en	352
766	fi-3-digipedagogiikka	fi	353
767	fi-3-digipedagogiikka	sv	353
768	fi-3-digipedagogiikka	en	353
769	avoinjulkaiseminen	fi	354
770	avoinjulkaiseminen	sv	354
773	avoinjulkaiseminen	sv	355
774	avoinjulkaiseminen	en	355
775	avoinjulkaiseminen	fi	356
776	avoinjulkaiseminen	sv	356
777	avoinjulkaiseminen	en	356
778	avoinjulkaiseminen	fi	357
779	avoinjulkaiseminen	sv	357
780	avoinjulkaiseminen	en	357
781	Upphovsrtten i undervisningen	fi	358
782	Upphovsrtten i undervisningen	sv	358
783	Upphovsrtten i undervisningen	en	358
784	avoinjulkaiseminen	fi	359
785	Öppnä publicering	sv	359
786	avoinjulkaiseminen	en	359
787	fi-3-digipedagogiikka	fi	360
788	fi-3-digipedagogiikka	sv	360
789	fi-3-digipedagogiikka	en	360
790	avoinjulkaiseminen	fi	361
791	avoinjulkaiseminen	sv	361
792	avoinjulkaiseminen	en	361
793	Tekijnoikeudet opetuksessa	fi	362
794	Tekijnoikeudet opetuksessa	sv	362
795	Tekijnoikeudet opetuksessa	en	362
796	avoinjulkaiseminen	fi	363
797	avoinjulkaiseminen	sv	363
798	avoinjulkaiseminen	en	363
799	Tekijnoikeudet opetuksessa	fi	364
800	Tekijnoikeudet opetuksessa	sv	364
801	Tekijnoikeudet opetuksessa	en	364
802	avoinjulkaiseminen	fi	365
803	avoinjulkaiseminen	sv	365
804	avoinjulkaiseminen	en	365
805	lahioikeudet	fi	366
806	lahioikeudet	sv	366
807	lahioikeudet	en	366
808	lahioikeudet	fi	367
809	lahioikeudet	sv	367
810	lahioikeudet	en	367
811	lahioikeudet	fi	368
812	lahioikeudet	sv	368
813	lahioikeudet	en	368
814	avoinjulkaiseminen	fi	369
815	avoinjulkaiseminen	sv	369
816	avoinjulkaiseminen	en	369
817	Upphovsrtten i undervisningen	fi	370
818	Upphovsrtten i undervisningen	sv	370
819	Upphovsrtten i undervisningen	en	370
820	avoinjulkaiseminen	fi	371
821	avoinjulkaiseminen	sv	371
822	avoinjulkaiseminen	en	371
823	Tekijnoikeudet opetuksessa	fi	372
824	Tekijnoikeudet opetuksessa	sv	372
825	Tekijnoikeudet opetuksessa	en	372
826	Tekijnoikeudet opetuksessa	fi	373
827	Tekijnoikeudet opetuksessa	sv	373
828	Tekijnoikeudet opetuksessa	en	373
829	Upphovsrtten i undervisningen	fi	374
830	Upphovsrtten i undervisningen	sv	374
831	Upphovsrtten i undervisningen	en	374
832	avoinjulkaiseminen	fi	375
833	avoinjulkaiseminen	sv	375
834	avoinjulkaiseminen	en	375
835	Mittaustehtävä 1	fi	376
836	Kuinka tehdä avoimia oppimateriaaleja	sv	376
837	Kuinka tehdä avoimia oppimateriaaleja	en	376
838	Mittaus 1, video	fi	377
839	Skriva öppna lärresurser	sv	377
840	Skriva öppna lärresurser	en	377
841	Mittauspöytäkirja	fi	378
842	OER_harjoitukset	sv	378
843	OER_harjoitukset	en	378
844	Tekijanoikeudet opetuksessa	fi	379
845	Tekijanoikeudet opetuksessa	sv	379
846	Tekijanoikeudet opetuksessa	en	379
847	Copyrights in education	fi	380
848	Copyrights in education	sv	380
849	Copyrights in education	en	380
850	Upphovsrtten i undervisningen	fi	381
851	Upphovsrtten i undervisningen	sv	381
852	Upphovsrtten i undervisningen	en	381
853	lahioikeudet	fi	382
854	lahioikeudet	sv	382
855	lahioikeudet	en	382
856	Copyrights in education	fi	383
857	Copyrights in education	sv	383
858	Copyrights in education	en	383
859	asdas	fi	384
860	hkjkjh	sv	384
861	gfd	en	384
862	Tekijanoikeudet opetuksessa	fi	385
863	Tekijanoikeudet opetuksessa	sv	385
864	Tekijanoikeudet opetuksessa	en	385
865	Copyrights in education	fi	386
866	Copyrights in education	sv	386
867	Copyrights in education	en	386
868	Upphovsrtten i undervisningen	fi	387
869	Upphovsrtten i undervisningen	sv	387
870	Upphovsrtten i undervisningen	en	387
871	lahioikeudet	fi	388
872	lahioikeudet	sv	388
873	lahioikeudet	en	388
874	lahioikeudet	fi	389
875	lahioikeudet	sv	389
876	lahioikeudet	en	389
877	ohjeet	fi	390
878	ohjeet	sv	390
879	ohjeet	en	390
880	lahioikeudet	fi	391
881	lahioikeudet	sv	391
882	lahioikeudet	en	391
883	sitaatit	fi	392
884	sitaatit	sv	392
885	sitaatit	en	392
886	Tekijänoikeudet opetuksessa	fi	393
887	Tekijnoikeudet opetuksessa	sv	393
888	Tekijnoikeudet opetuksessa	en	393
889	Upphovsrtten i undervisningen	fi	394
890	Upphovsrtten i undervisningen	sv	394
891	Upphovsrtten i undervisningen	en	394
892	avoinjulkaiseminen	fi	395
893	avoinjulkaiseminen	sv	395
894	avoinjulkaiseminen	en	395
895	docker	fi	396
896	docker	sv	396
897	docker	en	396
898	docker3	fi	397
899	docker	sv	397
900	docker	en	397
901	docker2	fi	398
902	docker	sv	398
903	docker	en	398
904	6b Puheentuotto_opiskelijalle	fi	399
905	6b Puheentuotto_opiskelijalle	sv	399
906	6b Puheentuotto_opiskelijalle	en	399
907	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	fi	400
908	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	sv	400
909	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	en	400
910	Tekijnoikeudet opetuksessa	fi	401
911	Tekijnoikeudet opetuksessa	sv	401
912	Tekijnoikeudet opetuksessa	en	401
913	Kuinka tehdä avoimia oppimateriaaleja	fi	402
914	Kuinka tehdä avoimia oppimateriaaleja	sv	402
915	Kuinka tehdä avoimia oppimateriaaleja	en	402
916	6b Puheentuotto_opiskelijalle	fi	403
917	6b Puheentuotto_opiskelijalle	sv	403
918	6b Puheentuotto_opiskelijalle	en	403
919	14_tekijänoikeudet_virtuaaliluokassa_opettajan_oikeudet	fi	404
920	14_tekijänoikeudet_virtuaaliluokassa_opettajan_oikeudet	sv	404
921	14_tekijänoikeudet_virtuaaliluokassa_opettajan_oikeudet	en	404
922	Copyrights in education	fi	405
923	Copyrights in education	sv	405
924	Copyrights in education	en	405
937	dsad	fi	410
938		sv	410
939		en	410
940	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	fi	411
941	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	sv	411
942	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1	en	411
943	Screenshot from 2020-02-06 13-37-46	fi	412
944	Screenshot from 2020-02-06 13-37-46	sv	412
945	Screenshot from 2020-02-06 13-37-46	en	412
946	OD_avaruus	fi	413
947	OD_avaruus	sv	413
948	OD_avaruus	en	413
949	OD_avaruus	fi	414
950	OD_avaruus	sv	414
951	OD_avaruus	en	414
952	Tekijnoikeudet opetuksessa	fi	415
953	Tekijnoikeudet opetuksessa	sv	415
954	Tekijnoikeudet opetuksessa	en	415
955	Upphovsrtten i undervisningen	fi	416
956	Upphovsrtten i undervisningen	sv	416
957	Upphovsrtten i undervisningen	en	416
958	avoinjulkaiseminen	fi	417
959	avoinjulkaiseminen	sv	417
960	avoinjulkaiseminen	en	417
961	avoinjulkaiseminen	fi	418
962	avoinjulkaiseminen	sv	418
963	avoinjulkaiseminen	en	418
964	lahioikeudet	fi	419
965	lahioikeudet	sv	419
966	lahioikeudet	en	419
967	lahioikeudet	fi	420
968	lahioikeudet	sv	420
969	lahioikeudet	en	420
970	lahioikeudet	fi	421
971	lahioikeudet	sv	421
972	lahioikeudet	en	421
973	lahioikeudet	fi	422
974	lahioikeudet	sv	422
975	lahioikeudet	en	422
976	Tekijnoikeudet opetuksessa	fi	423
977	Tekijnoikeudet opetuksessa	sv	423
978	Tekijnoikeudet opetuksessa	en	423
979	avoinjulkaiseminen	fi	424
980	avoinjulkaiseminen	sv	424
981	avoinjulkaiseminen	en	424
982	lahioikeudet	fi	425
983	lahioikeudet	sv	425
984	lahioikeudet	en	425
985	Näin teet avoimia oppimateriaaleja	fi	426
986	Näin teet avoimia oppimateriaaleja	sv	426
987	Näin teet avoimia oppimateriaaleja	en	426
988	Tekijnoikeudet opetuksessa	fi	427
989	Tekijnoikeudet opetuksessa	sv	427
925	Kuinka tehdä avoimia oppimateriaaleja	fi	406
926	Kuinka tehdä avoimia oppimateriaaleja	sv	406
990	Tekijnoikeudet opetuksessa	en	427
991	Näin teet avoimia oppimateriaaleja	fi	428
992	Näin teet avoimia oppimateriaaleja	sv	428
993	Näin teet avoimia oppimateriaaleja	en	428
994	Skriva öppna lärresurser	fi	429
995	Skriva öppna lärresurser	sv	429
996	Skriva öppna lärresurser	en	429
997	avoinjulkaiseminen	fi	430
998	avoinjulkaiseminen	sv	430
999	avoinjulkaiseminen	en	430
1000	Upphovsrtten i undervisningen	fi	431
1001	Upphovsrtten i undervisningen	sv	431
1002	Upphovsrtten i undervisningen	en	431
1003	kokeilu	fi	432
1004	kokeilu	sv	432
1005	kokeilu	en	432
1006	Upphovsrtten i undervisningen	fi	433
1007	Upphovsrtten i undervisningen	sv	433
1008	Upphovsrtten i undervisningen	en	433
1009	testikuva	fi	434
1010	testikuva	sv	434
1011	testikuva	en	434
1012	testikuva	fi	435
1013	testikuva	sv	435
1014	testikuva	en	435
1015	testikuva	fi	436
1016	testikuva	sv	436
1017	testikuva	en	436
1018	testikuva	fi	437
1019	testikuva	sv	437
1020	testikuva	en	437
1021	testikuva	fi	438
1022	testikuva	sv	438
1023	testikuva	en	438
1024	testikuva-testikuva-testikuva-testikuva-testikuva-testikuva-testikuva-vtestikuva-testikuva-testikuva-testikuva-testikuva-testikuva-testikuva-testikuva-testikuva-testikuva-aa	fi	439
1025	testikuva-testikuva-testikuva-testikuva-testikuva-testikuva-testikuva-vtestikuva-testikuva-testikuva-testikuva-testikuva-testikuva-testikuva-testikuva-testikuva-testikuva-aa	sv	439
1026	testikuva-testikuva-testikuva-testikuva-testikuva-testikuva-testikuva-vtestikuva-testikuva-testikuva-testikuva-testikuva-testikuva-testikuva-testikuva-testikuva-testikuva-aa	en	439
1027	testikuva	fi	440
1028	testikuva	sv	440
1029	testikuva	en	440
1030	testikuva	fi	441
1031		sv	441
1032	testikuva	en	441
1033	lahioikeudet	fi	442
1034	lahioikeudet	sv	442
1035	lahioikeudet	en	442
1036	lahioikeudet	fi	443
1037	lahioikeudet	sv	443
1038	lahioikeudet	en	443
1039	Screenshot from 2020-02-21 15-50-55	fi	444
1040	Screenshot from 2020-02-21 15-50-55	sv	444
1041	Screenshot from 2020-02-21 15-50-55	en	444
1043	Esimerkkimateriaali2	fi	446
1045	Esimerkkimateriaali2	sv	446
1047	Esimerkkimateriaali2	en	446
1048	Esimerkkimateriaali1	fi	447
1050	Esimerkkimateriaali1	sv	447
1052	Esimerkkimateriaali1	en	447
1054	Näin teet avoimia oppimateriaaleja	fi	449
1055	Näin teet avoimia oppimateriaaleja	sv	449
1056	Näin teet avoimia oppimateriaaleja	en	449
1057	OER_harjoitukset	fi	450
1058	OER_harjoitukset	sv	450
1059	OER_harjoitukset	en	450
1060	Näin teet avoimia oppimateriaaleja	fi	451
1061	Näin teet avoimia oppimateriaaleja	sv	451
1062	Näin teet avoimia oppimateriaaleja	en	451
1063	OER_harjoitukset	fi	452
1064	OER_harjoitukset	sv	452
1065	OER_harjoitukset	en	452
1066	Skriva öppna lärresurser	fi	453
1067	Skriva öppna lärresurser	sv	453
1068	Skriva öppna lärresurser	en	453
1072	lahioikeudet	fi	455
1073	lahioikeudet	sv	455
1074	lahioikeudet	en	455
1075	Screenshot from 2020-02-21 16-06-16	fi	456
1076	Screenshot from 2020-02-21 16-06-16	sv	456
1077	Screenshot from 2020-02-21 16-06-16	en	456
1078	lahioikeudet	fi	457
1079	lahioikeudet	sv	457
1080	lahioikeudet	en	457
1081	Screenshot from 2020-02-21 16-14-42	fi	458
1082	Screenshot from 2020-02-21 16-14-42	sv	458
1083	Screenshot from 2020-02-21 16-14-42	en	458
1087	Esimerkkimateriaali1	fi	460
1088	Esimerkkimateriaali1	sv	460
1089	Esimerkkimateriaali1	en	460
1090	Esimerkkimateriaali1	fi	461
1091	Esimerkkimateriaali1	sv	461
1092	Esimerkkimateriaali1	en	461
1093	Linkki	fi	462
1094		sv	462
1095		en	462
1096	lahioikeudet	fi	463
1069	avoinjulkaiseminen	fi	454
1070	avoinjulkaiseminen	sv	454
1071	avoinjulkaiseminen	en	454
1049	Esimerkkimateriaali2	fi	448
1051	Esimerkkimateriaali2	sv	448
1053	Esimerkkimateriaali2	en	448
1097	lahioikeudet	sv	463
1098	lahioikeudet	en	463
1099	lahioikeudet	fi	464
1100	lahioikeudet	sv	464
1101	lahioikeudet	en	464
1102	Linkki	fi	465
1103		sv	465
1104		en	465
1108	aoe-materiaali	fi	467
1109		sv	467
1110		en	467
1111	musta kuva	fi	468
1112	IMG_20200225_174348	sv	468
1113	IMG_20200225_174348	en	468
1117	Screenshot from 2020-02-27 15-31-31	fi	470
1118	Screenshot from 2020-02-27 15-31-31	sv	470
1119	Screenshot from 2020-02-27 15-31-31	en	470
1120	Screenshot from 2020-02-27 15-31-31	fi	471
1121	Screenshot from 2020-02-27 15-31-31	sv	471
1122	Screenshot from 2020-02-27 15-31-31	en	471
1123	Screenshot from 2020-02-25 08-12-33	fi	472
1124	Screenshot from 2020-02-25 08-12-33	sv	472
1125	Screenshot from 2020-02-25 08-12-33	en	472
1126	Screenshot from 2020-02-27 15-31-31	fi	473
1127	Screenshot from 2020-02-27 15-31-31	sv	473
1128	Screenshot from 2020-02-27 15-31-31	en	473
1129	Screenshot from 2020-02-27 15-31-31	fi	474
1130	Screenshot from 2020-02-27 15-31-31	sv	474
1131	Screenshot from 2020-02-27 15-31-31	en	474
1141	test	fi	478
1142	test	sv	478
1143	test	en	478
1144	Näin teet avoimia oppimateriaaleja	fi	479
1145	Näin teet avoimia oppimateriaaleja	sv	479
1146	Näin teet avoimia oppimateriaaleja	en	479
1147	esitysnimi	fi	480
1148		sv	480
1149		en	480
1150	python-master-paivitetty	fi	481
1151	python-master-paivitetty	sv	481
1152	python-master-paivitetty	en	481
1153	test	fi	482
1154	test	sv	482
1155	test	en	482
1156	test	fi	483
1157	test	sv	483
1158	test	en	483
1159	Näin teet avoimia oppimateriaaleja	fi	484
1160	Näin teet avoimia oppimateriaaleja	sv	484
1161	Näin teet avoimia oppimateriaaleja	en	484
1165	Screenshot from 2020-03-09 10-43-49	fi	486
1166	Screenshot from 2020-03-09 10-43-49	sv	486
1167	Screenshot from 2020-03-09 10-43-49	en	486
1174	Verkkokriteerit	fi	489
1175		sv	489
1176		en	489
1180	aoefi_logo_nega	fi	491
1181	aoefi_logo_nega	sv	491
1182	aoefi_logo_nega	en	491
1183	Screenshot from 2020-03-23 11-09-34	fi	492
1184	Screenshot from 2020-03-23 11-09-34	sv	492
1185	Screenshot from 2020-03-23 11-09-34	en	492
1195	esitysnimi	fi	496
1196		sv	496
1197		en	496
1198	Screenshot from 2020-03-25 07-47-49	fi	497
1199	Screenshot from 2020-03-25 07-47-49	sv	497
1200	Screenshot from 2020-03-25 07-47-49	en	497
1201	Screenshot from 2020-03-25 07-44-56	fi	498
1202	Screenshot from 2020-03-25 07-44-56	sv	498
1203	Screenshot from 2020-03-25 07-44-56	en	498
1204	OD_avaruus	fi	499
1205	OD_avaruus	sv	499
1206	OD_avaruus	en	499
1207	python-master-paivitetty	fi	500
1208	python-master-paivitetty	sv	500
1209	python-master-paivitetty	en	500
1168	python-master-paivitetty	fi	487
1169	python-master-paivitetty	sv	487
1171	Avoimet oppimateriaalit	fi	488
1172	Screenshot from 2020-03-16 11-58-51	sv	488
1173	Screenshot from 2020-03-16 11-58-51	en	488
1177	Verkkokriteeri	fi	490
1178	Kriteria	sv	490
1179	Criteria	en	490
1114	Linkki materiaaliin	fi	469
1115	Linkki materiaaliin	sv	469
1116	Linkki materiaaliin	en	469
1186	Näin teet avoimia oppimateriaaleja	fi	493
1187	Näin teet avoimia oppimateriaaleja	sv	493
1188	Näin teet avoimia oppimateriaaleja	en	493
1192	Video avoimesta julkaisemisesta	fi	495
1193	avoinjulkaiseminen	sv	495
1162	test	fi	485
1163	test	sv	485
1164	test	en	485
1194	avoinjulkaiseminen	en	495
1189	Skriva öppna lärresurser	fi	494
1190	Skriva öppna lärresurser	sv	494
1210	python-master-paivitetty	fi	501
1211	python-master-paivitetty	sv	501
1212	python-master-paivitetty	en	501
1105	testiiiiii	fi	466
1106	svenska	sv	466
1107	english	en	466
1576	avoin_oppiminen_ja_aoe	fi	509
1577	avoin_oppiminen_ja_aoe	sv	509
1578	avoin_oppiminen_ja_aoe	en	509
934	esitysnimi	fi	409
1084	Skriva öppna lärresurser	fi	459
1085	Skriva öppna lärresurser	sv	459
1086	Skriva öppna lärresurser	en	459
1264	Screenshot_from_4d tietojuttu	fi	503
1265	Screenshot from 2020-04-03 12-48-51	sv	503
1266	Screenshot from 2020-04-03 12-48-51	en	503
935	esitysnimi	sv	409
936	esitysnimi	en	409
1627	Screenshot from 2020-04-14 16-04-07	fi	517
1628	Screenshot from 2020-04-14 16-04-07	sv	517
1629	Screenshot from 2020-04-14 16-04-07	en	517
1504	moai-kilpailu	fi	504
1505	moai-loppet	sv	504
1506	best-movie	en	504
1507	Tuotannon taustat	fi	505
1508	Produktions bakgrund	sv	505
1509	best-document	en	505
1216	lahioikeudet	fi	502
1217	lahioikeudet	sv	502
1218	lahioikeudet	en	502
1630	Screenshot from 2020-04-14 16-04-07	fi	518
1567	OD_avaruus	fi	506
1568	OD_avaruus	sv	506
1569	OD_avaruus	en	506
1573	OD_avaruus	fi	508
1574	OD_avaruus	sv	508
1575	OD_avaruus	en	508
742	Avoin julkaiseminen	fi	345
1624	Screenshot from 2020-04-14 16-04-07	fi	516
1625	Screenshot from 2020-04-14 16-04-07	sv	516
1626	Screenshot from 2020-04-14 16-04-07	en	516
743	avoinjulkaiseminen	sv	345
744	avoinjulkaiseminen	en	345
736	Tekijänoikeudet opetuksessa	fi	343
737	Tekijnoikeudet opetuksessa	sv	343
738	Tekijnoikeudet opetuksessa	en	343
739	Upphovsrtten i undervisningen	fi	344
740	Upphovsrtten i undervisningen	sv	344
741	Upphovsrtten i undervisningen	en	344
1170	python-master-paivitetty	en	487
927	Kuinka tehdä avoimia oppimateriaaleja	en	406
931	OER h5p-harjoitukset	fi	408
932	OER_harjoitukset	sv	408
933	OER_harjoitukset	en	408
928	Skriva öppna lärresurser	fi	407
929	Skriva öppna lärresurser	sv	407
930	Skriva öppna lärresurser	en	407
1588	Slidet	fi	510
1589	ITKnäyttöslide	sv	510
1590	ITKnäyttöslide	en	510
1603	Kuinka tehdä avoimia oppimateriaaleja	fi	511
1604	Kuinka tehdä avoimia oppimateriaaleja	sv	511
1605	Kuinka tehdä avoimia oppimateriaaleja	en	511
1631	Screenshot from 2020-04-14 16-04-07	sv	518
1632	Screenshot from 2020-04-14 16-04-07	en	518
1633	Screenshot from 2020-04-14 16-04-07	fi	519
1634	Screenshot from 2020-04-14 16-04-07	sv	519
1635	Screenshot from 2020-04-14 16-04-07	en	519
1636	Screenshot from 2020-04-14 16-04-07	fi	521
1570	OD_avaruus	fi	507
1571	OD_avaruus	sv	507
1572	OD_avaruus	en	507
1615	python-master-paivitetty	fi	514
1616	python-master-paivitetty	sv	514
1617	python-master-paivitetty	en	514
1637	Screenshot from 2020-04-14 16-04-07	fi	520
1638	Screenshot from 2020-04-14 16-04-07	fi	522
1639	Screenshot from 2020-04-14 16-04-07	sv	521
1640	Screenshot from 2020-04-14 16-04-07	en	521
1641	Screenshot from 2020-04-14 16-04-07	sv	522
1642	Screenshot from 2020-04-14 16-04-07	en	522
1643	Screenshot from 2020-04-14 16-04-07	fi	523
1644	Screenshot from 2020-04-14 16-04-07	sv	520
1645	Screenshot from 2020-04-14 16-04-07	en	520
1646	Screenshot from 2020-04-14 16-04-07	sv	523
1647	Screenshot from 2020-04-14 16-04-07	en	523
1648	Screenshot from 2020-04-14 16-04-07	fi	524
1618	python-master-paivitetty	fi	515
1619	python-master-paivitetty	sv	515
1620	python-master-paivitetty	en	515
1191	Skriva öppna lärresurser	en	494
1609	harjoitukset	fi	513
1610	OER_harjoitukset	sv	513
1611	OER_harjoitukset	en	513
1649	Screenshot from 2020-04-14 16-04-07	sv	524
1650	Screenshot from 2020-04-14 16-04-07	en	524
1651	Screenshot from 2020-04-14 16-04-07	fi	525
1652	Screenshot from 2020-04-14 16-04-07	sv	525
1653	Screenshot from 2020-04-14 16-04-07	en	525
1654	Screenshot from 2020-04-03 15-31-51	fi	526
1655	Screenshot from 2020-04-03 15-31-51	sv	526
1656	Screenshot from 2020-04-03 15-31-51	en	526
1687	Kuinka tehdä avoimia oppimateriaaleja	fi	535
1688	Kuinka tehdä avoimia oppimateriaaleja	sv	535
1689	Kuinka tehdä avoimia oppimateriaaleja	en	535
1720	Linkki	fi	547
1721	Link	sv	547
1722	Link	en	547
1723	Linkki	fi	548
1724	Link	sv	548
1725	Link	en	548
1782	english	en	556
1780	testiiiiii	fi	556
1768	Yhteyttäminen ja soluhengitys	fi	555
1769	Kuinka tehdä avoimia oppimateriaaleja	sv	555
1750	Screenshot from 2020-04-03 15-06-47	fi	552
1751	Screenshot from 2020-04-03 15-06-47	sv	552
1752	Screenshot from 2020-04-03 15-06-47	en	552
1753	Screenshot from 2020-04-03 14-53-28	fi	553
1754	Screenshot from 2020-04-03 14-53-28	sv	553
1755	Screenshot from 2020-04-03 14-53-28	en	553
1756	Havainnollistava kuva	fi	554
1757	02-Opettaja-koneella-takaa	sv	554
1758	02-Opettaja-koneella-takaa	en	554
1770	Kuinka tehdä avoimia oppimateriaaleja	en	555
1606	Same in English	fi	512
1607	Skriva öppna lärresurser	sv	512
1608	Skriva öppna lärresurser	en	512
1801	Screenshot from 2020-04-03 15-31-51	fi	557
1802	Screenshot from 2020-04-03 15-31-51	sv	557
1803	Screenshot from 2020-04-03 15-31-51	en	557
1781	svenska	sv	556
1672	aoefi_logo_nega	fi	530
1673	aoefi_logo_nega	sv	530
1674	aoefi_logo_nega	en	530
1675	digia_logo_rgb	fi	531
1676	digia_logo_rgb	sv	531
1677	digia_logo_rgb	en	531
1678	aoefi_logo_nega	fi	532
1679	aoefi_logo_nega	sv	532
1680	aoefi_logo_nega	en	532
1681	aoefi_logo_nega	fi	533
1682	aoefi_logo_nega	sv	533
1732	coding-cup	fi	550
1733	coding-cup	sv	550
1734	coding-cup	en	550
1735	Näin teet avoimia oppimateriaaleja	fi	551
1736	Näin teet avoimia oppimateriaaleja	sv	551
1737	How to make OER	en	551
1666	OD_avaruus	fi	528
1667	OD_avaruus	sv	528
1668	OD_avaruus	en	528
1726	OD_avaruus	fi	549
1727	OD_avaruus	sv	549
1728	OD_avaruus	en	549
1669	scratch-master-paivitetty	fi	529
1670	scratch-master-paivitetty	sv	529
1671	scratch-master-paivitetty	en	529
1816	OD_avaruus	fi	558
1817	OD_avaruus	sv	558
1818	OD_avaruus	en	558
1683	aoefi_logo_nega	en	533
1684	aoefi_logo_nega	fi	534
1685	aoefi_logo_nega	sv	534
1686	aoefi_logo_nega	en	534
1690	aoefi_logo_nega	fi	536
1691	aoefi_logo_nega	sv	536
1692	aoefi_logo_nega	en	536
1693	digia_logo_cmyk	fi	537
1694	digia_logo_cmyk	sv	537
1695	digia_logo_cmyk	en	537
1696	aoefi_logo_nega	fi	538
1697	aoefi_logo_nega	sv	538
1698	aoefi_logo_nega	en	538
1702	OD_avaruus	fi	540
1703	OD_avaruus	sv	540
1704	OD_avaruus	en	540
1705	OD_avaruus	fi	541
1706	OD_avaruus	sv	541
1707	OD_avaruus	en	541
1708	digia_logo_rgb	fi	542
1709	digia_logo_rgb	sv	542
1710	digia_logo_rgb	en	542
1711	aoefi_logo_nega	fi	543
1712	aoefi_logo_nega	sv	543
1713	aoefi_logo_nega	en	543
1936	Screenshot from 2020-04-03 12-34-36	fi	562
1937	Screenshot from 2020-04-03 12-34-36	sv	562
1938	Screenshot from 2020-04-03 12-34-36	en	562
1894	Screenshot from 2020-04-03 15-31-51	fi	559
1895	Screenshot from 2020-04-03 15-31-51	sv	559
1896	Screenshot from 2020-04-03 15-31-51	en	559
1912	Uusi linkki	fi	561
1913	Uusi linkki	sv	561
1914	Uusi linkki	en	561
1699	aoefi_logo_nega	fi	539
1700	aoefi_logo_nega	sv	539
1701	aoefi_logo_nega	en	539
1663	Linkki	fi	527
1664	Link	sv	527
1665	Link	en	527
1717	Linkki	fi	546
1718	Link	sv	546
1719	Link	en	546
1714	Linkki	fi	545
1715	Link	sv	545
1716	Link	en	545
2046	coding-cup	en	574
1987	zoom	fi	568
1988	zoom	sv	568
1989	zoom	en	568
1942	Screenshot from 2020-04-03 14-53-28	fi	564
1943	Screenshot from 2020-04-03 14-53-28	sv	564
1944	Screenshot from 2020-04-03 14-53-28	en	564
1966	Avaruusseikkailu	fi	566
1042	Esimerkkimateriaali1	fi	445
1044	Esimerkkimateriaali1	sv	445
1046	Esimerkkimateriaali1	en	445
2005	Screenshot from 2020-04-03 15-31-51	fi	569
2006	Screenshot from 2020-04-03 15-31-51	sv	569
1939	Screenshot from 2020-04-03 15-06-47	fi	563
1940	Screenshot from 2020-04-03 15-06-47	sv	563
1941	Screenshot from 2020-04-03 15-06-47	en	563
1967	Avaruusseikkailu	sv	566
1968	Avaruusseikkailu	en	566
1951	avoinjulkaiseminen	fi	565
2075	Kuinka tehdä avoimia oppimateriaaleja	sv	579
2076	Kuinka tehdä avoimia oppimateriaaleja	en	579
2032	Tekstitiedosto	fi	573
2033	Kuinka tehdä avoimia oppimateriaaleja	sv	573
2034	Kuinka tehdä avoimia oppimateriaaleja	en	573
2007	Screenshot from 2020-04-03 15-31-51	en	569
2018	Skriva öppna lärresurser	fi	570
2020	Skriva öppna lärresurser	sv	570
2022	Skriva öppna lärresurser	en	570
2062	python-master-paivitetty2	fi	575
2063	python-master-paivitetty2	sv	575
2044	coding-cup	fi	574
2045	coding-cup	sv	574
2064	python-master-paivitetty2	en	575
2065	oho	fi	576
2066	oho	sv	576
2067	oho	en	576
2068	lahioikeudet	fi	577
2069	lahioikeudet	sv	577
2070	lahioikeudet	en	577
2071	scratch-master-paivitetty	fi	578
2072	scratch-master-paivitetty	sv	578
2073	scratch-master-paivitetty	en	578
2074	Kuinka tehdä avoimia oppimateriaaleja	fi	579
2110	lahioikeudet	fi	582
2111	lahioikeudet	sv	582
2112	lahioikeudet	en	582
2113	lahioikeudet	fi	583
2114	lahioikeudet	sv	583
2115	lahioikeudet	en	583
2116	lahioikeudet	fi	584
2117	lahioikeudet	sv	584
2118	lahioikeudet	en	584
2119	lahioikeudet	fi	585
2120	lahioikeudet	sv	585
2121	lahioikeudet	en	585
2122	lahioikeudet	fi	586
2123	lahioikeudet	sv	586
2124	lahioikeudet	en	586
2125	lahioikeudet	fi	587
2126	lahioikeudet	sv	587
2127	lahioikeudet	en	587
2128	lahioikeudet	fi	588
2129	lahioikeudet	sv	588
2130	lahioikeudet	en	588
2131	lahioikeudet	fi	589
2132	lahioikeudet	sv	589
2133	lahioikeudet	en	589
2134	lahioikeudet	fi	590
2135	lahioikeudet	sv	590
2136	lahioikeudet	en	590
2137	lahioikeudet	fi	591
2138	lahioikeudet	sv	591
2139	lahioikeudet	en	591
2440	Screenshot from 2020-06-03 15-03-33	fi	602
2347	avoinjulkaiseminen	fi	593
2348	avoinjulkaiseminen	sv	593
2349	avoinjulkaiseminen	en	593
2350	avoinjulkaiseminen	fi	594
2351	avoinjulkaiseminen	sv	594
2352	avoinjulkaiseminen	en	594
2353	avoinjulkaiseminen	fi	595
2354	avoinjulkaiseminen	sv	595
2355	avoinjulkaiseminen	en	595
2356	lahioikeudet	fi	596
2357	lahioikeudet	sv	596
2358	lahioikeudet	en	596
2338	Copyrights in education	fi	592
2339	Copyrights in education	sv	592
2340	Copyrights in education	en	592
2368	AOE kehittyy	fi	597
2369	AOE kehittyy	sv	597
2370	AOE kehittyy	en	597
2441	Screenshot from 2020-06-03 15-03-33	sv	602
2442	Screenshot from 2020-06-03 15-03-33	en	602
2371	Screenshot from 2020-05-26 11-15-13	fi	598
2372	Screenshot from 2020-05-26 11-15-13	sv	598
2077	Skriva öppna lärresurser	fi	580
2386	Screenshot from 2020-05-26 11-13-37	fi	599
2387	Screenshot from 2020-05-26 11-13-37	sv	599
2388	Screenshot from 2020-05-26 11-13-37	en	599
2392	Ongelmien syyt ja seuraukset	fi	600
2393		sv	600
2394		en	600
508	test-pdf-mroppone	fi	233
509	test-pdf-mroppone	sv	233
510	test-pdf-mroppone	en	233
466	test-pdf-mroppone	fi	219
467	test-pdf-mroppone	sv	219
468	test-pdf-mroppone	en	219
456	test-docx-mroppone	en	215
457	test-pdf-mroppone	fi	216
1952	avoinjulkaiseminen	sv	565
1953	avoinjulkaiseminen	en	565
1984	OOjs_UI_icon_bulb2_green_opa	fi	567
1985	OOjs_UI_icon_bulb2_green_opa	sv	567
1986	OOjs_UI_icon_bulb2_green_opa	en	567
458	test-pdf-mroppone	sv	216
459	test-pdf-mroppone	en	216
2413	testi linkki	fi	601
2414		sv	601
2415		en	601
2449	Screenshot from 2020-06-01 15-29-39	fi	605
2450	Screenshot from 2020-06-01 15-29-39	sv	605
2451	Screenshot from 2020-06-01 15-29-39	en	605
2455	s22 kieli- ja tekstitietoisuus onni kaarle	fi	606
2456	s22 kieli- ja tekstitietoisuus onni kaarle	sv	606
2457	s22 kieli- ja tekstitietoisuus onni kaarle	en	606
2458	coding-cup	fi	607
2459	coding-cup	sv	607
2460	coding-cup	en	607
2461	coding-cup	fi	608
2462	coding-cup	sv	608
2463	coding-cup	en	608
2464	coding-cup	fi	609
2465	coding-cup	sv	609
2466	coding-cup	en	609
2467	coding-cup	fi	610
2468	coding-cup	sv	610
2469	coding-cup	en	610
2470	aoefi_etusivu_vs2	fi	611
2471	aoefi_etusivu_vs2	sv	611
2472	aoefi_etusivu_vs2	en	611
2078	Skriva öppna lärresurser	sv	580
2079	Skriva öppna lärresurser	en	580
2476	python-master-paivitetty	fi	613
2477	python-master-paivitetty	sv	613
2478	python-master-paivitetty	en	613
2479	python_sv-master-paivitetty	fi	614
2480	python_sv-master-paivitetty	sv	614
2481	python_sv-master-paivitetty	en	614
2482	Screenshot from 2020-06-03 12-49-52	fi	615
2483	Screenshot from 2020-06-03 12-49-52	sv	615
2484	Screenshot from 2020-06-03 12-49-52	en	615
2488	python_sv-master-paivitetty	fi	617
2489	python_sv-master-paivitetty	sv	617
2490	python_sv-master-paivitetty	en	617
2491	python_sv-master-paivitetty	fi	618
2492	python_sv-master-paivitetty	sv	618
2493	python_sv-master-paivitetty	en	618
2506	Kuinka tehdä avoimia oppimateriaaleja	fi	621
2507	Kuinka tehdä avoimia oppimateriaaleja	sv	621
2508	Kuinka tehdä avoimia oppimateriaaleja	en	621
2509	Skriva öppna lärresurser	fi	622
2510	Skriva öppna lärresurser	sv	622
2511	Skriva öppna lärresurser	en	622
2512	Kuinka tehdä avoimia oppimateriaaleja	fi	623
2513	Kuinka tehdä avoimia oppimateriaaleja	sv	623
2514	Kuinka tehdä avoimia oppimateriaaleja	en	623
2515	Skriva öppna lärresurser	fi	624
2516	Skriva öppna lärresurser	sv	624
2517	Skriva öppna lärresurser	en	624
2533	Skriva öppna lärresurer	fi	625
2534	Skriva öppna lärresurer	sv	625
2535	Skriva öppna lärresurer	en	625
2536	Kuinka tehdä avoimia oppimateriaaleja	fi	626
2537	Kuinka tehdä avoimia oppimateriaaleja	sv	626
2538	Kuinka tehdä avoimia oppimateriaaleja	en	626
2473	HTML-materiaali	fi	612
2474	oho	sv	612
2475	oho	en	612
2545	Python from Scratch	fi	627
2546	python-master-paivitetty	sv	627
2547	python-master-paivitetty	en	627
2548	Python from Scratch	fi	628
2549	python_en-master-paivitetty	sv	628
2550	python_en-master-paivitetty	en	628
2551	Python from Scratch	fi	629
2552	python_sv-master-paivitetty	sv	629
2553	python_sv-master-paivitetty	en	629
2554	zip_kuvista	fi	630
2555	zip_kuvista	sv	630
2556	zip_kuvista	en	630
2557	oho	fi	631
2558	oho	sv	631
2559	oho	en	631
2566	Skriva öppna lärresurer	fi	634
2567	Skriva öppna lärresurer	sv	634
2568	Skriva öppna lärresurer	en	634
2569	Kuinka tehdä avoimia oppimateriaaleja	fi	635
2570	Kuinka tehdä avoimia oppimateriaaleja	sv	635
2571	Kuinka tehdä avoimia oppimateriaaleja	en	635
2578	Kuinka tehdä avoimia oppimateriaaleja	fi	638
2579	Kuinka tehdä avoimia oppimateriaaleja	sv	638
2580	Kuinka tehdä avoimia oppimateriaaleja	en	638
2373	Screenshot from 2020-05-26 11-15-13	en	598
2584	Tiedostonimitesti	fi	640
2585	Äödasäd öaädödä adadpl å. dsadas__ dasf---	sv	640
2586	Äödasäd öaädödä adadpl å. dsadas__ dasf---	en	640
2593	Äödasäd öaädödä adadpl å. dsadas__ dasf---	fi	641
2767	Yle	fi	658
2768		sv	658
2769		en	658
2770	Kuvakaappaus - 2020-06-23 12-46-08	fi	659
2771	Kuvakaappaus - 2020-06-23 12-46-08	sv	659
2620	Kesämateriaali	fi	643
2621	kuinka_tehda_avoimia_oppimateriaaleja	sv	643
2622	kuinka_tehda_avoimia_oppimateriaaleja	en	643
2623	Sommar material	fi	644
2624	skriva_oppna_larresurer	sv	644
2625	skriva_oppna_larresurer	en	644
2772	Kuvakaappaus - 2020-06-23 12-46-08	en	659
2773	Kuvakaappaus - 2020-06-23 12-46-08	fi	660
2774	Kuvakaappaus - 2020-06-23 12-46-08	sv	660
2775	Kuvakaappaus - 2020-06-23 12-46-08	en	660
2776	lahioikeudet	fi	661
2777	lahioikeudet	sv	661
2632	Näin esiinnyt verkossa väärällä identiteetillä	fi	646
2633	Näin esiinnyt verkossa väärälla identiteetillä	sv	646
2634	Näin esiinnyt verkossa väärälla identiteetillä	en	646
2644	eettinen-hakkerointi	fi	647
2645	eettinen-hakkerointi	sv	647
2485	python_sv-master-paivitetty	fi	616
2486	python_sv-master-paivitetty	sv	616
2487	python_sv-master-paivitetty	en	616
2560	b Podcast  Digital learning materials and their use in studying and  teaching text 	fi	632
2561	b Podcast  Digital learning materials and their use in studying and  teaching text 	sv	632
2572	Skriva öppna lärresurer	fi	636
2573	Skriva öppna lärresurer	sv	636
2574	Skriva öppna lärresurer	en	636
2575	Kuinka tehdä avoimia oppimateriaaleja	fi	637
2576	Kuinka tehdä avoimia oppimateriaaleja	sv	637
2562	b Podcast  Digital learning materials and their use in studying and  teaching text 	en	632
2626	Ilon ja onnen paiva	fi	645
2627	ilon-ja-onnen-paiva	sv	645
2628	ilon-ja-onnen-paiva	en	645
2581	Skriva öppna lärresurer	fi	639
2582	Skriva öppna lärresurer	sv	639
2583	Skriva öppna lärresurer	en	639
2646	eettinen-hakkerointi	en	647
2594	Äödasäd öaädödä adadpl å. dsadas__ dasf---	sv	641
2595	Äödasäd öaädödä adadpl å. dsadas__ dasf---	en	641
2605	aodasad_oaadoda_adadpl_a._dsadas_dasf-	fi	642
2606	aodasad_oaadoda_adadpl_a._dsadas_dasf-	sv	642
2607	aodasad_oaadoda_adadpl_a._dsadas_dasf-	en	642
2662	Ruokakasvatusta	fi	648
2663		sv	648
2664		en	648
2778	lahioikeudet	en	661
2779	AOE	fi	662
2780		sv	662
2665	OD_avaruus	fi	649
2666	OD_avaruus	sv	649
2667	OD_avaruus	en	649
2710	kirja-thtijengi-5-6-harjoituskirja	fi	650
2711	kirja-thtijengi-5-6-harjoituskirja	sv	650
2712	kirja-thtijengi-5-6-harjoituskirja	en	650
2719	Tunnista lintu - opas aloittelijoille	fi	651
2720		sv	651
2721		en	651
2722	Tunnista lintuja	fi	652
2723		sv	652
2724		en	652
2725	Lorem ipsum dolor sit amet, consectetur efficituri	fi	653
2726	Lorem ipsum dolor sit amet, consectetur efficitur.	sv	653
2727	Lorem ipsum dolor sit amet, consectetur efficitur.	en	653
2737	kielioppi	fi	654
2738	20735092_4de036d400_b	sv	654
2739	20735092_4de036d400_b	en	654
2080	harjoitukset	fi	581
2081	OER_harjoitukset	sv	581
2082	OER_harjoitukset	en	581
2758	c Infograf Digital learning materials in studing and teaching	fi	655
2759	c Infograf Digital learning materials in studing and teaching	sv	655
2760	c Infograf Digital learning materials in studing and teaching	en	655
2761	Hieno linkki	fi	656
2762		sv	656
2763		en	656
2764	AOE	fi	657
2765		sv	657
2766		en	657
2781		en	662
2782	testeri	fi	663
2783	testeri	sv	663
2784	testeri	en	663
2791	Ohjeistus tallentamiseen	fi	666
2792	Ohjeistus_tallentamiseen	sv	666
2793	Ohjeistus_tallentamiseen	en	666
2785	Ohjeistus muokkaamiseen	fi	664
2786	Ohjeistus_muokkaamiseen	sv	664
2787	Ohjeistus_muokkaamiseen	en	664
2845	tämä on linkki	fi	673
2846	tämä on linkki	sv	673
2847	tämä on linkki	en	673
2851	Kuvakaappaus - 2020-08-04 12-03-25	fi	674
2852	Kuvakaappaus - 2020-08-04 12-03-25	sv	674
2853	Kuvakaappaus - 2020-08-04 12-03-25	en	674
2854	ymparisto	fi	675
2855	ymparisto	sv	675
2856	ymparisto	en	675
2857	Näin teet avoimia oppimateriaaleja	fi	676
2858	Näin teet avoimia oppimateriaaleja	sv	676
2859	Näin teet avoimia oppimateriaaleja	en	676
2860	Näin teet avoimia oppimateriaaleja	fi	677
2861	Näin teet avoimia oppimateriaaleja	sv	677
2862	Näin teet avoimia oppimateriaaleja	en	677
2863	Digipedagogiikka	fi	678
2864		sv	678
2865		en	678
2866	Skriva öppna lärresurser	fi	679
2867	Skriva öppna lärresurser	sv	679
2868	Skriva öppna lärresurser	en	679
2869	Linnut	fi	680
2870	Linnut	sv	680
2871	Linnut	en	680
2872	blackbird	fi	681
2873	blackbird	sv	681
2874	blackbird	en	681
2875	blackbird	fi	682
2876	blackbird	sv	682
2877	blackbird	en	682
2878	twitter_avatar	fi	683
2880	twitter_avatar	sv	683
2882	twitter_avatar	en	683
2497	python_sv-master-paivitetty	fi	620
2498	python_sv-master-paivitetty	sv	620
2499	python_sv-master-paivitetty	en	620
2494	Screenshot from 2020-06-03 12-50-02	fi	619
2794	Ohjevideo oppimateriaalien tallennukseen	fi	667
2879	twitter_avatar	fi	684
2881	twitter_avatar	sv	684
2883	twitter_avatar	en	684
2795	Ohjevideo oppimateriaalien tallennukseen	sv	667
2839	OD_avaruus	fi	672
2840	OD_avaruus	sv	672
2841	OD_avaruus	en	672
2495	Screenshot from 2020-06-03 12-50-02	sv	619
2496	Screenshot from 2020-06-03 12-50-02	en	619
2890	Kuvakaappaus - 2020-08-27 12-24-17	fi	685
2891	Kuvakaappaus - 2020-08-27 12-24-17	sv	685
2892	Kuvakaappaus - 2020-08-27 12-24-17	en	685
2896	lahioikeudet	fi	687
2897	lahioikeudet	sv	687
2898	lahioikeudet	en	687
2893	OD_avaruus	fi	686
2894	OD_avaruus	sv	686
2895	OD_avaruus	en	686
2992	ymmärsinkö_kaiken_OER_testi	fi	709
2993	ymmärsinkö_kaiken_OER_testi	sv	709
2994	ymmärsinkö_kaiken_OER_testi	en	709
2911	avoimet_oppimateriaalit_video	fi	689
2912	avoimet_oppimateriaalit_video	sv	689
2913	avoimet_oppimateriaalit_video	en	689
2914	lahioikeudet	fi	690
2915	lahioikeudet	sv	690
2916	lahioikeudet	en	690
2917	lahioikeudet	fi	691
2918	lahioikeudet	sv	691
2919	lahioikeudet	en	691
2923	avoinjulkaiseminen	fi	693
2924	avoinjulkaiseminen	sv	693
2925	avoinjulkaiseminen	en	693
2929	avoimet_oppimateriaalit_video	fi	695
2930	avoimet_oppimateriaalit_video	sv	695
2931	avoimet_oppimateriaalit_video	en	695
2926	Näin teet avoimia oppimateriaaleja	fi	694
2927	Näin teet avoimia oppimateriaaleja	sv	694
2928	Näin teet avoimia oppimateriaaleja	en	694
2932	kokeiluvideo	fi	696
2933	kokeiluvideo	sv	696
2934	kokeiluvideo	en	696
3016	Kuvakaappaus - 2020-09-03 12-47-58	fi	711
3017	Kuvakaappaus - 2020-09-03 12-47-58	sv	711
3018	Kuvakaappaus - 2020-09-03 12-47-58	en	711
2446	Sama x2	fi	604
2447	Screenshot from 2020-06-03 15-03-33	sv	604
2905	avoinjulkaiseminen	fi	688
2956	Testilinkki	fi	699
2957		sv	699
2958		en	699
2959	kokeiluvideo	fi	700
2960	kokeiluvideo	sv	700
2961	kokeiluvideo	en	700
2962	kokeiluvideo	fi	701
2963	kokeiluvideo	sv	701
2964	kokeiluvideo	en	701
2965	Linkkitesti	fi	702
2966		sv	702
2967		en	702
2968	testilinkki	fi	703
2969		sv	703
2970		en	703
2971	kokeiluvideo	fi	704
2972	kokeiluvideo	sv	704
2973	kokeiluvideo	en	704
2974	testilinkki	fi	705
2975		sv	705
2976		en	705
2977	on testi	fi	706
2978		sv	706
2979		en	706
2980	testilinkki	fi	707
2981		sv	707
2982		en	707
2983	testi	fi	708
2984	Näin teet avoimia oppimateriaaleja	sv	708
2985	Näin teet avoimia oppimateriaaleja	en	708
2941	kokeiluvideo	fi	697
2942	kokeiluvideo	sv	697
2943	kokeiluvideo	en	697
2947	Kuvakaappaus - 2020-08-27 12-24-17	fi	698
2948	Kuvakaappaus - 2020-08-27 12-24-17	sv	698
2949	Kuvakaappaus - 2020-08-27 12-24-17	en	698
2443	Screenshot from 2020-06-03 15-03-33	fi	603
2444	Screenshot from 2020-06-03 15-03-33	sv	603
2445	Screenshot from 2020-06-03 15-03-33	en	603
2577	Kuinka tehdä avoimia oppimateriaaleja	en	637
3043	harjoitus-1-verbien-rektioista-1247	fi	713
3044	harjoitus-1-verbien-rektioista-1247	sv	713
3045	harjoitus-1-verbien-rektioista-1247	en	713
2906	avoinjulkaiseminen	sv	688
2907	avoinjulkaiseminen	en	688
3040	opettele-suuntia-ja-paikkoja-suomeksi-image-pairing	fi	712
3041	opettele-suuntia-ja-paikkoja-suomeksi-image-pairing	sv	712
3042	opettele-suuntia-ja-paikkoja-suomeksi-image-pairing	en	712
3046	kertaustehtava-infinitiiveista-partisiipeista-ja-lauseenvastikkeista-1449	fi	714
3047	kertaustehtava-infinitiiveista-partisiipeista-ja-lauseenvastikkeista-1449	sv	714
3048	kertaustehtava-infinitiiveista-partisiipeista-ja-lauseenvastikkeista-1449	en	714
3049	runo-ja-novellianalyysitermisto-1224	fi	715
3050	runo-ja-novellianalyysitermisto-1224	sv	715
3051	runo-ja-novellianalyysitermisto-1224	en	715
3052	termeja-novellin-analysoimiseen-1226	fi	716
3053	termeja-novellin-analysoimiseen-1226	sv	716
3054	termeja-novellin-analysoimiseen-1226	en	716
3055	kertaustehtava-va-partisiipista-1450	fi	717
3056	kertaustehtava-va-partisiipista-1450	sv	717
3057	kertaustehtava-va-partisiipista-1450	en	717
3058	harjoitus-tu-partisiipista-1489	fi	718
3059	harjoitus-tu-partisiipista-1489	sv	718
3060	harjoitus-tu-partisiipista-1489	en	718
3061	harjoitus-1-verbien-astevaihtelusta-2-1468	fi	719
3062	harjoitus-1-verbien-astevaihtelusta-2-1468	sv	719
3063	harjoitus-1-verbien-astevaihtelusta-2-1468	en	719
3064	harjoitus-2-kertovista-lauseenvastikkeista-1251	fi	720
3065	harjoitus-2-kertovista-lauseenvastikkeista-1251	sv	720
3066	harjoitus-2-kertovista-lauseenvastikkeista-1251	en	720
3067	harjoitus-1-verbien-astevaihtelusta-1267	fi	721
3068	harjoitus-1-verbien-astevaihtelusta-1267	sv	721
3069	harjoitus-1-verbien-astevaihtelusta-1267	en	721
3070	harjoitus-1-verbien-rektioista-ja-objektista-1261	fi	722
3071	harjoitus-1-verbien-rektioista-ja-objektista-1261	sv	722
3072	harjoitus-1-verbien-rektioista-ja-objektista-1261	en	722
3073	harjoitus-temporaalirakenteista-1233	fi	723
3074	harjoitus-temporaalirakenteista-1233	sv	723
3075	harjoitus-temporaalirakenteista-1233	en	723
3076	harjoitus-2-runoanalyysin-keskeisista-termeista-1248	fi	724
3077	harjoitus-2-runoanalyysin-keskeisista-termeista-1248	sv	724
3078	harjoitus-2-runoanalyysin-keskeisista-termeista-1248	en	724
3079	harjoitus-1-kertovista-lauseenvastikkeista-1250	fi	725
3080	harjoitus-1-kertovista-lauseenvastikkeista-1250	sv	725
3081	harjoitus-1-kertovista-lauseenvastikkeista-1250	en	725
3082	harjoitus-novellianalyysin-keskeisista-termeista-2-1228	fi	726
3083	harjoitus-novellianalyysin-keskeisista-termeista-2-1228	sv	726
3084	harjoitus-novellianalyysin-keskeisista-termeista-2-1228	en	726
3085	verbien-rektioita-1253	fi	727
3086	verbien-rektioita-1253	sv	727
3087	verbien-rektioita-1253	en	727
3088	harjoitus-runoanalyysin-keskeisista-termeista-1225 (1)	fi	728
3089	harjoitus-runoanalyysin-keskeisista-termeista-1225 (1)	sv	728
3090	harjoitus-runoanalyysin-keskeisista-termeista-1225 (1)	en	728
3091	harjoitus-nominien-taivutuksesta-1487	fi	729
3092	harjoitus-nominien-taivutuksesta-1487	sv	729
3093	harjoitus-nominien-taivutuksesta-1487	en	729
3094	course-presentation-21-21180	fi	730
3095	course-presentation-21-21180	sv	730
3096	course-presentation-21-21180	en	730
3097	interactive-video-2-618	fi	731
3098	interactive-video-2-618	sv	731
3099	interactive-video-2-618	en	731
3100	chart-7143	fi	732
3101	chart-7143	sv	732
3102	chart-7143	en	732
3103	audio-recorder-87-748022	fi	733
3104	audio-recorder-87-748022	sv	733
3105	audio-recorder-87-748022	en	733
3106	accordion-6-7138	fi	734
3107	accordion-6-7138	sv	734
3108	accordion-6-7138	en	734
3109	agamotto-80158	fi	735
3110	agamotto-80158	sv	735
3111	agamotto-80158	en	735
3112	arithmetic-quiz-22-57860	fi	736
3113	arithmetic-quiz-22-57860	sv	736
3114	arithmetic-quiz-22-57860	en	736
3115	collage-3065	fi	737
3116	collage-3065	sv	737
3117	collage-3065	en	737
3118	h5p-column-34794	fi	738
3119	h5p-column-34794	sv	738
3120	h5p-column-34794	en	738
3121	dictation-389727	fi	739
3122	dictation-389727	sv	739
3123	dictation-389727	en	739
3124	essay-4-166755	fi	740
3125	essay-4-166755	sv	740
3126	essay-4-166755	en	740
3127	documentation-tool-3022	fi	741
3128	documentation-tool-3022	sv	741
3129	documentation-tool-3022	en	741
3130	image-multiple-hotspot-question-65081	fi	742
3131	image-multiple-hotspot-question-65081	sv	742
3132	image-multiple-hotspot-question-65081	en	742
3133	drag-and-drop-712	fi	743
3134	drag-and-drop-712	sv	743
3135	drag-and-drop-712	en	743
3136	find-the-hotspot-3024	fi	744
3137	find-the-hotspot-3024	sv	744
3138	find-the-hotspot-3024	en	744
3139	example-content-find-the-words-557697	fi	745
3140	example-content-find-the-words-557697	sv	745
3141	example-content-find-the-words-557697	en	745
3142	iframe-embedder-621	fi	746
3143	iframe-embedder-621	sv	746
3144	iframe-embedder-621	en	746
3145	guess-the-answer-2402	fi	747
3146	guess-the-answer-2402	sv	747
3147	guess-the-answer-2402	en	747
3148	image-slider-2-130336	fi	748
3149	image-slider-2-130336	sv	748
3150	image-slider-2-130336	en	748
3151	image-hotspots-2-825	fi	749
3152	image-hotspots-2-825	sv	749
3153	image-hotspots-2-825	en	749
3154	image-sequencing-3-110117	fi	750
3155	image-sequencing-3-110117	sv	750
3156	image-sequencing-3-110117	en	750
3157	image-juxtaposition-65047	fi	751
3158	image-juxtaposition-65047	sv	751
3159	image-juxtaposition-65047	en	751
3160	example-content-image-pairing-2-233382	fi	752
3161	example-content-image-pairing-2-233382	sv	752
3162	example-content-image-pairing-2-233382	en	752
3163	mark-the-words-2-1408	fi	753
3164	mark-the-words-2-1408	sv	753
3165	mark-the-words-2-1408	en	753
3166	multiple-choice-713	fi	754
3167	multiple-choice-713	sv	754
3168	multiple-choice-713	en	754
3169	memory-game-5-708	fi	755
3170	memory-game-5-708	sv	755
3171	memory-game-5-708	en	755
3172	impressive-presentation-7141	fi	756
3173	impressive-presentation-7141	sv	756
3174	impressive-presentation-7141	en	756
3175	berries-28-441940	fi	757
3176	berries-28-441940	sv	757
3177	berries-28-441940	en	757
3211	h5p-harjoitukset suulliseen kielitaitoon	fi	769
3212	h5p-harjoitukset suulliseen kielitaitoon	sv	769
3213	h5p-harjoitukset suulliseen kielitaitoon	en	769
3214	h5p-harjoitukset suulliseen kielitaitoon (kopio)	fi	770
3215	h5p-harjoitukset suulliseen kielitaitoon (kopio)	sv	770
3216	h5p-harjoitukset suulliseen kielitaitoon (kopio)	en	770
2023	Näin teet avoimia oppimateriaaleja	fi	572
2024	Näin teet avoimia oppimateriaaleja	sv	572
2025	Näin teet avoimia oppimateriaaleja	en	572
2017	Screenshot from 2020-03-31 13-50-49	fi	571
2019	Screenshot from 2020-03-31 13-50-49	sv	571
2021	Screenshot from 2020-03-31 13-50-49	en	571
2920	od_avaruus (1)	fi	692
2921	od_avaruus (1)	sv	692
2922	od_avaruus (1)	en	692
2995	pdf-sample	fi	710
2996	pdf-sample	sv	710
2997	pdf-sample	en	710
3316	pdf-sample	fi	778
3315	pdf-sample	en	777
3334	Oikea materiaali	fi	780
3335	Oikea materiaali	sv	780
3312	zoo999test2	en	776
2448	Screenshot from 2020-06-03 15-03-33	en	604
3256	Kuvakaappaus - 2020-09-11 09-38-39	fi	772
3257	Kuvakaappaus - 2020-09-11 09-38-39	sv	772
3258	Kuvakaappaus - 2020-09-11 09-38-39	en	772
3259	Kuvakaappaus - 2020-09-11 09-38-39	fi	773
3260	Kuvakaappaus - 2020-09-11 09-38-39	sv	773
3261	Kuvakaappaus - 2020-09-11 09-38-39	en	773
3317	pdf-sample	sv	778
3318	pdf-sample	en	778
3298	Linkki	fi	775
3299	Linkki	sv	775
3300	Linkki	en	775
3336	Oikea materiaali	en	780
3262	pdf-sample	fi	774
3263	pdf-sample	sv	774
3264	pdf-sample	en	774
3310	zoo999test2	fi	776
3311	zoo999test2	sv	776
3255	pdf-sample	en	771
3322	zoo999test3	fi	779
3323	zoo999test3	sv	779
3313	pdf-sample	fi	777
3314	pdf-sample	sv	777
3253	pdf-sample	fi	771
3184	personality-quiz-21254	fi	760
3185	personality-quiz-21254	sv	760
3186	personality-quiz-21254	en	760
3181	speak-the-words-73595	fi	759
3254	pdf-sample	sv	771
3324	zoo999test3	en	779
3193	timeline-3-716	fi	763
3194	timeline-3-716	sv	763
3195	timeline-3-716	en	763
3196	speak-the-words-set-example-120784	fi	764
3197	speak-the-words-set-example-120784	sv	764
3198	speak-the-words-set-example-120784	en	764
3199	summary-714	fi	765
3200	summary-714	sv	765
3201	summary-714	en	765
3202	advanced-blanks-example-1-503253	fi	766
3203	advanced-blanks-example-1-503253	sv	766
3204	advanced-blanks-example-1-503253	en	766
3205	true-false-question-34806	fi	767
3206	true-false-question-34806	sv	767
3352	testi	fi	782
3353	testi	sv	782
3354	testi	en	782
3349	Testimateriaali Marko Valja tilaesittely	fi	781
3350	Valja_Marko_Tilaesittely_120111_1	sv	781
3351	Valja_Marko_Tilaesittely_120111_1	en	781
3370	Kuvakaappaus - 2020-09-22 09-34-58	fi	783
3371	Kuvakaappaus - 2020-09-22 09-34-58	sv	783
3372	Kuvakaappaus - 2020-09-22 09-34-58	en	783
3394	lyhyt	fi	785
3395	lyhyt	sv	785
3396	lyhyt	en	785
3397	nimetön	fi	786
3398	nimetön	sv	786
3399	nimetön	en	786
3424	Linkki oppimateriaalin sivulle	fi	795
3425		sv	795
3426		en	795
3469	tehtäväpaketti1	fi	805
3470	tehtäväpaketti1	sv	805
3471	tehtäväpaketti1	en	805
3472	tvt_excel-perusharjoituspaketti	fi	806
3473	tvt_excel-perusharjoituspaketti	sv	806
3474	tvt_excel-perusharjoituspaketti	en	806
3478	autoala englanti 14.10.2019	fi	808
3479	autoala englanti 14.10.2019	sv	808
3480	autoala englanti 14.10.2019	en	808
3475	s22 aineistokirjoittaminen	fi	807
3476	s22 aineistokirjoittaminen	sv	807
3477	s22 aineistokirjoittaminen	en	807
3481	puun_kaskadikaytto_-_opettajan_opas	fi	809
3442	Opas kouludemokratian edistämiseen	fi	801
3443	Luokkavaltuusto_opas-kouludemokratian-edistamiseen	sv	801
3444	Luokkavaltuusto_opas-kouludemokratian-edistamiseen	en	801
3427	Aloitelomekepohja	fi	796
3428	Luokkavaltuusto_aloitelomekepohja	sv	796
3429	Luokkavaltuusto_aloitelomekepohja	en	796
3433	Arviointilomake	fi	798
3434	Luokkavaltuusto_rviointilomake_	sv	798
3484	s22 suomi ja sen sukukielet	fi	810
3435	Luokkavaltuusto_rviointilomake_	en	798
3490	puun_kaskadikaytto_ppt	fi	812
3491	puun_kaskadikaytto_ppt	sv	812
3492	puun_kaskadikaytto_ppt	en	812
3493	aoe_avoin_oppiminen_oy	fi	813
3494	aoe_avoin_oppiminen_oy	sv	813
3495	aoe_avoin_oppiminen_oy	en	813
3496	aoe_avoin_oppiminen_marraskuu	fi	814
3497	aoe_avoin_oppiminen_marraskuu	sv	814
3498	aoe_avoin_oppiminen_marraskuu	en	814
3439	Harjoituksia vuorovaikutus ja yhteistyötaidoista	fi	800
3440	Luokkavaltuusto_Harjoituksia-vuorovaikutus-ja-yhteistyotaidoista	sv	800
3409	Ohjeet	fi	790
3410	actnow_ohjeet_fi_no_se	sv	790
3411	actnow_ohjeet_fi_no_se	en	790
3400	Pelilauta	fi	787
3401	actnowboard_a3_fi_small_uusi	sv	787
3402	actnowboard_a3_fi_small_uusi	en	787
3412	Pelikortit	fi	791
3413	pelikortit_actnow	sv	791
3414	pelikortit_actnow	en	791
3403	Linkki oppimateriaalin sivulle	fi	788
3404	Linkki oppimateriaalin sivulle	sv	788
3405	Linkki oppimateriaalin sivulle	en	788
3418	Instruktionerna	fi	793
3419	actnow_insturktionerna_se_fi_no	sv	793
3420	actnow_insturktionerna_se_fi_no	en	793
3415	Spelkort	fi	792
3416	actnow_spelkort	sv	792
3417	actnow_spelkort	en	792
3421	Spelbrädet	fi	794
3422	actnowboard_svenska	sv	794
3423	actnowboard_svenska	en	794
3406	Länk till studiematerialssidan	fi	789
3407	Länk till studiematerialssidan	sv	789
3408	Länk till studiematerialssidan	en	789
3373	pdf-sample	fi	784
3374	pdf-sample	sv	784
3375	pdf-sample	en	784
3499	testi	fi	815
3500	testi	sv	815
3501	testi	en	815
3486	s22 suomi ja sen sukukielet	en	810
3487	muokkaus	fi	811
3488	muokkaus	sv	811
3489	muokkaus	en	811
3511	muokkaus	fi	816
3512	muokkaus	sv	816
2563	A Podcast Digital learning material and its use in studying and teaching	fi	633
2564	A Podcast Digital learning material and its use in studying and teaching	sv	633
2565	A Podcast Digital learning material and its use in studying and teaching	en	633
3784	valja_marko_viljelyn_paapiirteet_120111_2	fi	827
3785	valja_marko_viljelyn_paapiirteet_120111_2	sv	827
3786	valja_marko_viljelyn_paapiirteet_120111_2	en	827
3787	valja_marko_viljelyn_paapiirteet_120111_2	fi	828
3788	valja_marko_viljelyn_paapiirteet_120111_2	sv	828
3789	valja_marko_viljelyn_paapiirteet_120111_2	en	828
3796	tervetulotoivotus kurssimateriaalin käyttäjälle	fi	829
3797	tervetulotoivotus kurssimateriaalin käyttäjälle	sv	829
3798	tervetulotoivotus kurssimateriaalin käyttäjälle	en	829
3799	ge1 karhu-salo-metodi - ohjeet käyttäjälle	fi	830
3513	muokkaus	en	816
3514	muokkaus	fi	817
3515	muokkaus	sv	817
3516	muokkaus	en	817
3538	ITK_paivat_Oppimisanalytiikan_tyopaja	fi	818
3539	ITK_paivat_Oppimisanalytiikan_tyopaja	sv	818
3540	ITK_paivat_Oppimisanalytiikan_tyopaja	en	818
3800	ge1 karhu-salo-metodi - ohjeet käyttäjälle	sv	830
3801	ge1 karhu-salo-metodi - ohjeet käyttäjälle	en	830
2833	OD_avaruus	fi	671
2834	OD_avaruus	sv	671
2835	OD_avaruus	en	671
3679	Lopputulos	fi	821
3680	IMG_20201006_115253	sv	821
3681	IMG_20201006_115253	en	821
3754	tuuran-salajuoni	fi	826
3755	tuuran-salajuoni	sv	826
3756	tuuran-salajuoni	en	826
3182	speak-the-words-73595	sv	759
3183	speak-the-words-73595	en	759
3178	questionnaire-4-30615	fi	758
3179	questionnaire-4-30615	sv	758
3180	questionnaire-4-30615	en	758
3190	question-set-616	fi	762
3191	question-set-616	sv	762
3192	question-set-616	en	762
3187	single-choice-set-1515	fi	761
3188	single-choice-set-1515	sv	761
3189	single-choice-set-1515	en	761
3574	Testimateriaali	fi	820
3575	example-content-find-the-words-557697	sv	820
3576	example-content-find-the-words-557697	en	820
3482	puun_kaskadikaytto_-_opettajan_opas	sv	809
3483	puun_kaskadikaytto_-_opettajan_opas	en	809
3485	s22 suomi ja sen sukukielet	sv	810
3718	Tuuran asiakirjat	fi	822
3719	Tuuras dokument	sv	822
3720	Tuura's documents	en	822
3727	Tuuran asiakirjat	fi	823
3728	tuuran-asiakirjat	sv	823
3729	tuuran-asiakirjat	en	823
3736	Tuuran asiakirjat	fi	824
3737	tuuran-asiakirjat	sv	824
3738	tuuran-asiakirjat	en	824
3745	tuuran-salajuoni	fi	825
3746	tuuran-salajuoni	sv	825
3747	tuuran-salajuoni	en	825
3814	ge1 karhu-salo-metodi - ohjeet käyttäjälle	fi	832
3815	ge1 karhu-salo-metodi - ohjeet käyttäjälle	sv	832
3816	ge1 karhu-salo-metodi - ohjeet käyttäjälle	en	832
1132	Näin teet avoimia oppimateriaaleja	fi	475
1133	Näin teet avoimia oppimateriaaleja	sv	475
1134	Näin teet avoimia oppimateriaaleja	en	475
1138	Skriva öppna lärresurser	fi	477
1139	Skriva öppna lärresurser	sv	477
1140	Skriva öppna lärresurser	en	477
1135	Näin teet avoimia oppimateriaaleja	fi	476
1136	Näin teet avoimia oppimateriaaleja	sv	476
1137	Näin teet avoimia oppimateriaaleja	en	476
3802	tuura-the-2nd	fi	831
3803	tuura-the-2nd	sv	831
3804	tuura-the-2nd	en	831
3817	ge1 karhu-salo-metodi - ohjeet käyttäjälle	fi	833
3818	ge1 karhu-salo-metodi - ohjeet käyttäjälle	sv	833
3819	ge1 karhu-salo-metodi - ohjeet käyttäjälle	en	833
3820	GE1 Karhu-Salo-metodi pakattu_pienin	fi	834
3821	GE1 Karhu-Salo-metodi pakattu_pienin	sv	834
3822	GE1 Karhu-Salo-metodi pakattu_pienin	en	834
3823	GE1 Tulvat-jaettava	fi	835
3824	GE1 Tulvat-jaettava	sv	835
3825	GE1 Tulvat-jaettava	en	835
3826	3 GE1 Karttakohteet	fi	836
3827	3 GE1 Karttakohteet	sv	836
3828	3 GE1 Karttakohteet	en	836
3829	Kokonaisuus - Eksogeeniset prosessit	fi	837
3830	Kokonaisuus - Eksogeeniset prosessit	sv	837
3831	Kokonaisuus - Eksogeeniset prosessit	en	837
3832	ge1 karhu-salo-metodi - ohjeet käyttäjälle	fi	838
3833	ge1 karhu-salo-metodi - ohjeet käyttäjälle	sv	838
3834	ge1 karhu-salo-metodi - ohjeet käyttäjälle	en	838
3841	esitys	fi	841
3842	kopiosto_aoe	sv	841
3843	kopiosto_aoe	en	841
3847	kopiosto_aoe	fi	843
3848	kopiosto_aoe	sv	843
3849	kopiosto_aoe	en	843
3844	Kuvakaappaus - 2020-11-23 12-07-38	fi	842
3845	Kuvakaappaus - 2020-11-23 12-07-38	sv	842
3846	Kuvakaappaus - 2020-11-23 12-07-38	en	842
3856	Ymmärsinkö kaiken OER testi	fi	844
3857	ymmärsinkö_kaiken_OER_testi	sv	844
3858	ymmärsinkö_kaiken_OER_testi	en	844
3859	Copyrights in education	fi	845
3860	Copyrights in education	sv	845
3861	Copyrights in education	en	845
3862	GE1 Tulvat-jaettava	fi	846
3863	GE1 Tulvat-jaettava	sv	846
3864	GE1 Tulvat-jaettava	en	846
3871	testeri	fi	847
3872	testeri	sv	847
3873	testeri	en	847
3565	aoefi_logo_nega	fi	819
3566	aoefi_logo_nega	sv	819
3567	aoefi_logo_nega	en	819
3838	oeglobal	fi	840
3839	oeglobal	sv	840
3840	oeglobal	en	840
3883	Esimerkkimateriaali	fi	848
3884	Esimerkkimateriaali	sv	848
3885	Esimerkkimateriaali	en	848
3886	aoefi_etusivu	fi	849
3887	aoefi_etusivu	sv	849
3888	aoefi_etusivu	en	849
3901	x5g0n_2020_CC_Summit	fi	850
3902	x5g0n_2020_CC_Summit	sv	850
3903	x5g0n_2020_CC_Summit	en	850
3904	x5g0n_2020_CC_Summit	fi	851
3905	x5g0n_2020_CC_Summit	sv	851
3906	x5g0n_2020_CC_Summit	en	851
3907	Kokonaisuus - Eksogeeniset prosessit	fi	852
3908	Kokonaisuus - Eksogeeniset prosessit	sv	852
3909	Kokonaisuus - Eksogeeniset prosessit	en	852
3910	A Podcast Digital learning material and its use in studying and teaching	fi	853
3911	A Podcast Digital learning material and its use in studying and teaching	sv	853
3912	A Podcast Digital learning material and its use in studying and teaching	en	853
3913	kuvailuwebinaari	fi	854
3914	kuvailuwebinaari	sv	854
3915	kuvailuwebinaari	en	854
3835	Kuvakaappaus - 2020-11-19 09-12-53	fi	839
3836	Kuvakaappaus - 2020-11-19 09-12-53	sv	839
3837	Kuvakaappaus - 2020-11-19 09-12-53	en	839
3441	Luokkavaltuusto_Harjoituksia-vuorovaikutus-ja-yhteistyotaidoista	en	800
3430	Pöytäkirjalomake	fi	797
3431	Luokkavaltuusto_poytakirjalomake	sv	797
3432	Luokkavaltuusto_poytakirjalomake	en	797
3436	Roolikortit	fi	799
3437	Luokkavaltuusto_roolikortit	sv	799
3438	Luokkavaltuusto_roolikortit	en	799
3445	Luokkavaltuuston esittely 2020	fi	802
3446	Luokkavaltuuston-esittely-2020	sv	802
3447	Luokkavaltuuston-esittely-2020	en	802
3451	Luokkavaltuusto-video	fi	804
3452	Luokkavaltuusto-video	sv	804
3453	Luokkavaltuusto-video	en	804
3448	Linkki oppimateriaalin sivulle	fi	803
3449	Linkki oppimateriaalin sivulle	sv	803
3450	Linkki oppimateriaalin sivulle	en	803
2796	Ohjevideo oppimateriaalien tallennukseen	en	667
2797	Ohjeistus tallentamiseen	fi	668
2798	Ohjeistus_tallentamiseen	sv	668
2799	Ohjeistus_tallentamiseen	en	668
2815	Ohjeistus muokkaamiseen	fi	670
2816	Ohjeistus_muokkaamiseen	sv	670
2817	Ohjeistus_muokkaamiseen	en	670
2788	Ohjeistus kokoelmiin	fi	665
2789	Ohjeistus_kokoelmiin	sv	665
2790	Ohjeistus_kokoelmiin	en	665
2812	Ohjeistus arvioimiseen	fi	669
3991	002_200mB_file	fi	855
3992	002_200mB_file	sv	855
3993	002_200mB_file	en	855
3994	002_200mB_file	fi	856
3995	002_200mB_file	sv	856
3996	002_200mB_file	en	856
3997	002_200mB_file	fi	857
3998	002_200mB_file	sv	857
3999	002_200mB_file	en	857
4000	002_200mB_file	fi	858
4001	002_200mB_file	sv	858
4002	002_200mB_file	en	858
4003	ge1 karhu-salo-metodi pakattu	fi	859
4004	ge1 karhu-salo-metodi pakattu	sv	859
4005	ge1 karhu-salo-metodi pakattu	en	859
4006	GE1 Karhu-Salo-metodi pakattu_koe	fi	860
4007	GE1 Karhu-Salo-metodi pakattu_koe	sv	860
4008	GE1 Karhu-Salo-metodi pakattu_koe	en	860
4012	testeri	fi	861
4013	testeri	sv	861
4014	testeri	en	861
4021	GE1 Karhu-Salo-metodi pakattu_koe	fi	862
4022	GE1 Karhu-Salo-metodi pakattu_koe	sv	862
4023	GE1 Karhu-Salo-metodi pakattu_koe	en	862
4024	linkki	fi	863
4025		sv	863
4026		en	863
4027	Kuvakaappaus - 2020-12-04 12-11-03	fi	864
4028	Kuvakaappaus - 2020-12-04 12-11-03	sv	864
4029	Kuvakaappaus - 2020-12-04 12-11-03	en	864
4030	Kuvakaappaus - 2020-12-07 11-20-07	fi	865
4031	Kuvakaappaus - 2020-12-07 11-20-07	sv	865
4032	Kuvakaappaus - 2020-12-07 11-20-07	en	865
4033	Kuvakaappaus - 2020-12-07 11-20-07	fi	866
4034	Kuvakaappaus - 2020-12-07 11-20-07	sv	866
4035	Kuvakaappaus - 2020-12-07 11-20-07	en	866
4045	aoe_logo_nega_pysty_FI_1500px	fi	868
4046	aoe_logo_nega_pysty_FI_1500px	sv	868
4047	aoe_logo_nega_pysty_FI_1500px	en	868
4066	pdf-sample	fi	869
4067	pdf-sample	sv	869
4068	pdf-sample	en	869
4078	Kuvakaappaus - 2020-11-26 13-26-49	fi	870
4079	Kuvakaappaus - 2020-11-26 13-26-49	sv	870
4080	Kuvakaappaus - 2020-11-26 13-26-49	en	870
4081	Kuvakaappaus - 2020-11-26 13-26-49	fi	871
4082	Kuvakaappaus - 2020-11-26 13-26-49	sv	871
4083	Kuvakaappaus - 2020-11-26 13-26-49	en	871
4084	Kuvakaappaus - 2021-01-08 12-00-16	fi	872
4085	Kuvakaappaus - 2021-01-08 12-00-16	sv	872
4086	Kuvakaappaus - 2021-01-08 12-00-16	en	872
3207	true-false-question-34806	en	767
3208	example-content-virtual-tour-360-441814	fi	768
3209	example-content-virtual-tour-360-441814	sv	768
3210	example-content-virtual-tour-360-441814	en	768
4129	Kuvakaappaus - 2021-01-08 12-00-16	fi	877
4130	Kuvakaappaus - 2021-01-08 12-00-16	sv	877
4117	Kuvakaappaus - 2020-12-07 11-20-09	fi	876
4118	Kuvakaappaus - 2020-12-07 11-20-09	sv	876
4119	Kuvakaappaus - 2020-12-07 11-20-09	en	876
4090	Kuvakaappaus - 2020-12-07 10-16-07	fi	874
4091	Kuvakaappaus - 2020-12-07 10-16-07	sv	874
4092	Kuvakaappaus - 2020-12-07 10-16-07	en	874
4131	Kuvakaappaus - 2021-01-08 12-00-16	en	877
4219	Kuvakaappaus - 2021-01-29 08-58-29	fi	884
4220	Kuvakaappaus - 2021-01-29 08-58-29	sv	884
4221	Kuvakaappaus - 2021-01-29 08-58-29	en	884
4153	zoom_0	fi	878
4154	zoom_0	sv	878
4155	zoom_0	en	878
4087	hyinen talvi	fi	873
4088	cc-by	sv	873
4089	cc-by	en	873
4093	Niin kylmä	fi	875
4094	medigi esimerkki	sv	875
4095	medigi esimerkki	en	875
4186	zoom_0	fi	880
4187	zoom_0	sv	880
4188	zoom_0	en	880
4204	zoom_0	fi	881
4205	zoom_0	sv	881
4206	zoom_0	en	881
4207	Kuvakaappaus - 2020-12-10 13-04-09	fi	882
4208	Kuvakaappaus - 2020-12-10 13-04-09	sv	882
4209	Kuvakaappaus - 2020-12-10 13-04-09	en	882
4210	Kuvakaappaus - 2020-12-07 11-20-07	fi	883
4211	Kuvakaappaus - 2020-12-07 11-20-07	sv	883
4212	Kuvakaappaus - 2020-12-07 11-20-07	en	883
4222	GE1 Karhu-Salo-metodi pakattu_pienin	fi	885
4223	GE1 Karhu-Salo-metodi pakattu_pienin	sv	885
4224	GE1 Karhu-Salo-metodi pakattu_pienin	en	885
4225	Kuvakaappaus - 2020-12-17 09-05-41	fi	886
4226	Kuvakaappaus - 2020-12-17 09-05-41	sv	886
4227	Kuvakaappaus - 2020-12-17 09-05-41	en	886
4228	Kuvakaappaus - 2020-12-10 13-04-09	fi	887
4229	Kuvakaappaus - 2020-12-10 13-04-09	sv	887
4039	aoefi_logo_nega	fi	867
4040	aoefi_logo_nega	sv	867
4041	aoefi_logo_nega	en	867
2813	Ohjeistus_arvioimiseen	sv	669
2814	Ohjeistus_arvioimiseen	en	669
4230	Kuvakaappaus - 2020-12-10 13-04-09	en	887
4317	Kuvakaappaus - 2020-12-07 11-20-09	en	899
4339	Alkuperäinen	fi	900
4340	Alkuperäinen	sv	900
4237	Kuvakaappaus - 2021-01-29 08-58-29	fi	888
4238	Kuvakaappaus - 2021-01-29 08-58-29	sv	888
4239	Kuvakaappaus - 2021-01-29 08-58-29	en	888
4341	Alkuperäinen	en	900
4345	aoe_kam	fi	901
4346	aoe_kam	sv	901
4347	aoe_kam	en	901
4348	tehtäväpaketti1	fi	902
4349	tehtäväpaketti1	sv	902
4255	Kuvakaappaus - 2020-10-02 13-56-03	fi	890
4256	Kuvakaappaus - 2020-10-02 13-56-03	sv	890
4257	Kuvakaappaus - 2020-10-02 13-56-03	en	890
4261	Kuvakaappaus - 2020-11-23 12-12-31	fi	891
4262	Kuvakaappaus - 2020-11-23 12-12-31	sv	891
4263	Kuvakaappaus - 2020-11-23 12-12-31	en	891
4264	chart-7143	fi	892
4265	chart-7143	sv	892
4266	chart-7143	en	892
4350	tehtäväpaketti1	en	902
4351	5_kirjain_äänne_opettajalle	fi	903
4352	5_kirjain_äänne_opettajalle	sv	903
4353	5_kirjain_äänne_opettajalle	en	903
4273	AOE	fi	893
4274	AOE	sv	893
4275	AOE	en	893
4171	Kuvakaappaus - 2020-12-17 09-05-41	fi	879
4172	Kuvakaappaus - 2020-12-17 09-05-41	sv	879
4173	Kuvakaappaus - 2020-12-17 09-05-41	en	879
4246	Kuvakaappaus - 2021-02-15 12-35-40	fi	889
4247	Kuvakaappaus - 2021-02-15 12-35-40	sv	889
4248	Kuvakaappaus - 2021-02-15 12-35-40	en	889
4285	AOE	fi	894
4286	AOE	sv	894
4287	AOE	en	894
4297	asiasanat_työelämässä_toimiminen	fi	895
4298	asiasanat_työelämässä_toimiminen	sv	895
4299	asiasanat_työelämässä_toimiminen	en	895
4306	Kuvakaappaus - 2021-02-12 15-50-42	fi	896
4307	Kuvakaappaus - 2021-02-12 15-50-42	sv	896
4308	Kuvakaappaus - 2021-02-12 15-50-42	en	896
4309	Kuvakaappaus - 2021-02-15 12-35-38	fi	897
4310	Kuvakaappaus - 2021-02-15 12-35-38	sv	897
4311	Kuvakaappaus - 2021-02-15 12-35-38	en	897
4312	Kuvakaappaus - 2020-12-04 12-11-03	fi	898
4313	Kuvakaappaus - 2020-12-04 12-11-03	sv	898
4314	Kuvakaappaus - 2020-12-04 12-11-03	en	898
4315	Kuvakaappaus - 2020-12-07 11-20-09	fi	899
4316	Kuvakaappaus - 2020-12-07 11-20-09	sv	899
4360	GE1 Tulvat	fi	906
4361	GE1 Tulvat	sv	906
4362	GE1 Tulvat	en	906
4363	Kokonaisuus - Eksogeeniset prosessit	fi	907
4364	Kokonaisuus - Eksogeeniset prosessit	sv	907
4365	Kokonaisuus - Eksogeeniset prosessit	en	907
4366	GE1 Kylma ja kuuma maa	fi	908
4367	GE1 Kylma ja kuuma maa	sv	908
4368	GE1 Kylma ja kuuma maa	en	908
4369	Kokonaisuus - Luonnontoiminnan aiheuttamat ilmiot	fi	909
4370	Kokonaisuus - Luonnontoiminnan aiheuttamat ilmiot	sv	909
4371	Kokonaisuus - Luonnontoiminnan aiheuttamat ilmiot	en	909
4372	3 GE1 Kolmas kokoontuminen - Kartta	fi	910
4373	3 GE1 Kolmas kokoontuminen - Kartta	sv	910
4374	3 GE1 Kolmas kokoontuminen - Kartta	en	910
4375	GE1 Kokonaisuus - Luonnontoiminnan aiheuttamat ilmiot - ei muokattava	fi	911
4376	GE1 Kokonaisuus - Luonnontoiminnan aiheuttamat ilmiot - ei muokattava	sv	911
4377	GE1 Kokonaisuus - Luonnontoiminnan aiheuttamat ilmiot - ei muokattava	en	911
4388	Linkki 1	fi	913
4389	Linkki 1	sv	913
4392	Linkki 1	en	913
4387	Linkki 2	fi	912
4390	Linkki 2	sv	912
4391	Linkki 2	en	912
4399	pdf-sample	fi	914
4400	pdf-sample	sv	914
4401	pdf-sample	en	914
4411	Avointen oppimateriaalien palvelut, työkalut ja käytännöt.key	fi	915
4412	Avointen oppimateriaalien palvelut, työkalut ja käytännöt.key	sv	915
4413	Avointen oppimateriaalien palvelut, työkalut ja käytännöt.key	en	915
4414	Avointen oppimateriaalien palvelut, työkalut ja käytännöt	fi	916
4415	Avointen oppimateriaalien palvelut, työkalut ja käytännöt	sv	916
4354	Tee-Word-dokumenteista-saavutettavia	fi	904
4355	Tee-Word-dokumenteista-saavutettavia	sv	904
4356	Tee-Word-dokumenteista-saavutettavia	en	904
4357	Tee-Word-dokumenteista-saavutettavia	fi	905
4358	Tee-Word-dokumenteista-saavutettavia	sv	905
4359	Tee-Word-dokumenteista-saavutettavia	en	905
4416	Avointen oppimateriaalien palvelut, työkalut ja käytännöt	en	916
4423	testi	fi	917
4424	testi	sv	917
4425	testi	en	917
4498	4 GE1 Neljäs kokoontuminen - Geomedia	fi	918
4499	4 GE1 Neljäs kokoontuminen - Geomedia	sv	918
4500	4 GE1 Neljäs kokoontuminen - Geomedia	en	918
4501	GE1 Nälkäinen maailmamme	fi	919
4502	GE1 Nälkäinen maailmamme	sv	919
4503	GE1 Nälkäinen maailmamme	en	919
4504	1 GE1 Ensimmäinen kokoontuminen	fi	920
4505	1 GE1 Ensimmäinen kokoontuminen	sv	920
4506	1 GE1 Ensimmäinen kokoontuminen	en	920
4507	1 GE1 Ensimmäinen kokoontuminen	fi	921
4508	1 GE1 Ensimmäinen kokoontuminen	sv	921
4509	1 GE1 Ensimmäinen kokoontuminen	en	921
4510	pdf-sample	fi	922
4511	pdf-sample	sv	922
4512	pdf-sample	en	922
4513	pdf-sample	fi	923
4514	pdf-sample	sv	923
4515	pdf-sample	en	923
4516	1 GE1 Ensimminen kokoontuminen	fi	924
4517	1 GE1 Ensimminen kokoontuminen	sv	924
4518	1 GE1 Ensimminen kokoontuminen	en	924
4519	1 GE1 Ensimminen kokoontuminen	fi	925
4520	pdf-sample	sv	925
4521	pdf-sample	en	925
4522	1 GE1 Ensimminen kokoontuminen	fi	926
4523	1 GE1 Ensimminen kokoontuminen	sv	926
4524	1 GE1 Ensimminen kokoontuminen	en	926
4525	4 GE1 Neljs kokoontuminen - Geomedia	fi	927
4526	4 GE1 Neljs kokoontuminen - Geomedia	sv	927
4527	4 GE1 Neljs kokoontuminen - Geomedia	en	927
4528	Linkki	fi	928
4529	Linkki	sv	928
4530	Linkki	en	928
4543	ge1 karhu-salo-metodi pakattu	fi	929
4544	ge1 karhu-salo-metodi pakattu	sv	929
4545	ge1 karhu-salo-metodi pakattu	en	929
4546	ge1 karhu-salo-metodi pakattu	fi	930
4547	ge1 karhu-salo-metodi pakattu	sv	930
4548	ge1 karhu-salo-metodi pakattu	en	930
4561	ge1 karhu-salo-metodi pakattu	fi	935
4562	ge1 karhu-salo-metodi pakattu	sv	935
4563	ge1 karhu-salo-metodi pakattu	en	935
4564	raskas_testimateriaali5	fi	936
4565	raskas_testimateriaali5	sv	936
4566	raskas_testimateriaali5	en	936
\.


--
-- Data for Name: materialname; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.materialname (id, materialname, language, slug, educationalmaterialid) FROM stdin;
1	testi	fi	testi	1
2		sv		1
3		en		1
4	Opeta puheentuottoa	fi	opeta-puheentuottoa	2
5		sv		2
6		en		2
7	Testimateriaali	fi	testimateriaali	4
8		sv		4
9		en		4
10	Python from Scratch	fi	python-from-scratch	7
11		sv		7
12		en		7
13	Johdatus tekoälyyn	fi	johdatus-tekoalyyn	8
14		sv		8
15		en		8
16	Digipedagogiikka	fi	digipedagogiikka	12
17		sv		12
18		en		12
19	Digitaalisuus ja teknologia kouluissa	fi	digitaalisuus-ja-teknologia-kouluissa	13
20		sv		13
21		en		13
22	Opetuksen ja oppimisen suunnittelu, Learning Design	fi	opetuksen-ja-oppimisen-suunnittelu-learning-design	14
23		sv		14
24		en		14
25	Oppimistehtävän suunnittelu	fi	oppimistehtavan-suunnittelu	18
26		sv		18
27		en		18
28	Miten tuetaan opiskelijoiden yhteisöllisyyden kehittymistä 1	fi	miten-tuetaan-opiskelijoiden-yhteisollisyyden-kehittymista-1	19
29		sv		19
30		en		19
31	Miten tuetaan opiskelijoiden yhteisöllisyyden kehittymistä kurssin alkuvaiheessa? 2	fi	miten-tuetaan-opiskelijoiden-yhteisollisyyden-kehittymista-kurssin-alkuvaiheessa-2	20
32		sv		20
33		en		20
34	Testimateriaali	fi	testimateriaali	23
35		sv		23
36		en		23
37	Johdatus robotiikan opetukseen	fi	johdatus-robotiikan-opetukseen	24
38		sv		24
39		en		24
40	Kuinka tehdä avoimia oppimateriaaleja	fi	kuinka-tehda-avoimia-oppimateriaaleja	43
41		sv		43
42	Hoe to make OER	en	hoe-to-make-oer	43
43	Oikosulkuvirta - suurin sallittu johtimen pituus	fi	oikosulkuvirta-suurin-sallittu-johtimen-pituus	44
44		sv		44
45		en		44
49	hfghfh dhdfgdfgdf	fi		52
50		sv		52
51		en		52
61	kuinka tehdä avoimia materiaaleja	fi		16
62		sv		16
63		en		16
70	Opeta kirjain-äänne -vastaavuutta	fi		56
71		sv		56
72		en		56
73	Opeta kirjain-äänne -vastaavuutta	fi		57
74		sv		57
75		en		57
76	Kirjain-äänne-vastaavuus	fi		54
77		sv		54
78		en		54
79	Testi testinen	fi		59
80		sv		59
81		en		59
85	Oppimistehtävien suunnittelu	fi		61
86		sv		61
87		en		61
88	fdsfsdfsdfsd	fi		67
89		sv		67
90		en		67
100	Testi	fi		73
101		sv		73
102		en		73
103	testikaks	fi		74
104		sv		74
105		en		74
106	adasdasdasdasdas	fi		75
107		sv		75
108		en		75
109	Digitaaliset työvälineeet opetuksessa ja oppimisessa	fi		76
110	Digitaliska verktyg	sv		76
111	Digital teaching and studying tools	en		76
112	Kuinka tehdä avoimia oppimateriaaleja	fi		77
113		sv		77
114		en		77
115	Lukio ja ammattikoulu	fi		78
116		sv		78
117		en		78
118	dasdas	fi		81
119		sv		81
120		en		81
121	javascript:alert("Hi there")	fi		97
122		sv		97
123		en		97
124	Kaikkia yks	fi		99
125		sv		99
126		en		99
127	Monta esitystä	fi		100
128		sv		100
129		en		100
130	Useampi kuva	fi		101
131		sv		101
132		en		101
133	Kuinka tehdä avoimia oppimateriaaleja	fi		103
134		sv		103
135		en		103
145	test	fi		107
146		sv		107
147		en		107
148	Kuinka tehdä avoimia oppimateriaaleja	fi		108
149		sv		108
150		en		108
151	Testi	fi		110
152		sv		110
153		en		110
154	Järjestystesti	fi		111
155		sv		111
156		en		111
157	Toinen järjestys	fi		112
158		sv		112
159		en		112
160	Testi	fi		117
161		sv		117
162		en		117
163		fi		118
164		sv		118
165	OHO	en		118
166	Testimatsku	fi		123
167		sv		123
168		en		123
172	testi	fi		127
173		sv		127
174		en		127
175	materiaalin nimi	fi		128
176	nimi sve	sv		128
177	nimi eng	en		128
178	Testi	fi		132
179		sv		132
180		en		132
181	Testi	fi		137
182		sv		137
183		en		137
184	Testi	fi		138
185		sv		138
186		en		138
187	asdsa	fi		139
188		sv		139
189		en		139
190	Testi	fi		140
191		sv		140
192		en		140
193	VTT Testi	fi		141
194		sv		141
195		en		141
196	Testi kolmella kielellä - avoin julkaiseminen	fi		142
197		sv		142
198		en		142
199	Testi kolmella kielellä nro 2	fi		143
200		sv		143
201		en		143
211	Mittaustekniikka 1	fi		160
212		sv		160
213		en		160
217	testi	fi		165
218		sv		165
219		en		165
220	Avoin julkaiseminen - testaus	fi		168
221		sv		168
222		en		168
223	tesfsddfsf	fi		171
224		sv		171
225		en		171
229	referenssitesti	fi		174
230		sv		174
231		en		174
232	testi	fi		175
233		sv		175
234		en		175
235		fi		176
236		sv		176
237	Muokkattu materiaali testi	en		176
238	Kuinka tehdä avoimia oppimateriaaleja	fi		177
244	testsetesi	fi		182
245		sv		182
246		en		182
247	Verkko-opetus	fi		183
248		sv		183
249		en		183
250	testataus	fi		184
251		sv		184
252		en		184
253	testi	fi		189
254		sv		189
255		en		189
256	Monipuoliset testauskäytännöt	fi		193
257		sv		193
258		en		193
265	Saavutettavuus	fi		202
266		sv		202
267		en		202
271	test	fi		204
272		sv		204
273		en		204
283	testi mobiililla	fi		216
284		sv		216
285		en		216
292	kokeilu	fi		222
293	kokeilu	sv		222
294	kokeilu	en		222
295	Kokeillaan	fi		223
296	Kokeillaan	sv		223
297	Kokeillaan	en		223
298	Testi	fi		224
299	Testi	sv		224
300	Testi	en		224
310	linkki testi	fi		235
311	linkki testi	sv		235
312	linkki testi	en		235
306	Open educational resources	en		231
487	Thumbnail2	fi		243
488	Thumbnail	sv		243
280	testing	fi		215
281	testing	sv		215
282	testing	en		215
489	Thumbnail	en		243
241	Testi	fi		178
242	Testi	sv		178
307	Avoimet oppimateriaalit - ABC	fi		234
308	Öppna lärresurser -ABC	sv		234
577	Testi	fi		261
243	Testi	en		178
286	Linkkimateriaali	fi		217
287	Linkkimateriaali	sv		217
301	ziptesti	fi		230
302	ziptesti	sv		230
303	ziptesti	en		230
288	Linkkimateriaali	en		217
505	Yhteyttäminen ja soluhengitys	fi		247
269	Saavutettavuusoppi 2	sv		203
496	Differentiaalilaskenta 4	fi		246
484	Puuttuva nimi	fi		239
485	Puuttuva nimi	sv		239
486	Puuttuva nimi	en		239
202	Avoin julkaiseminen	fi		144
203	Öppna publ.	sv		144
204	Avoin julkaiseminen	en		144
239	Kuinka tehdä avoimia oppimateriaaleja	sv		177
240	How to make OERs	en		177
304	Avoimet oppimateriaalit - tarkka kuvailu	fi		231
305	Öppna materialet	sv		231
559	Testimateriaali mikä jää kesken	fi		263
560	Testimateriaali mikä jää kesken	sv		263
561	Testimateriaali mikä jää kesken	en		263
625	ziptestttti	fi		264
626	ziptestttti	sv		264
627	ziptestttti	en		264
490	Vaihdettu nimi	fi		245
491	Kokeilu	sv		245
492	Kokeilu	en		245
511	Testi	fi		249
512	Testi	sv		249
513	Testi	en		249
274	Saavutettavuusoppi 3.1	fi		207
275	Saavutettavuusoppi 3	sv		207
268	Saavutettavuusoppi 2	fi		203
506	Kuinka tehdä avoimia oppimateriaaleja	sv		247
507	How to make OER	en		247
497	Olli on hieno mies	sv		246
583	Kokeilumateriaali	fi		200
584	Kokeilumateriaali	sv		200
270	Saavutettavuusoppi 2	en		203
585	Kokeilumateriaali	en		200
498	Olli on hieno mies	en		246
276	Saavutettavuusoppi 3	en		207
520	Testimateriaali	fi		260
521	Test material	sv		260
522	Test material	en		260
628	OHO-test	fi		265
629	OHO-test	sv		265
630	OHO-test	en		265
578	Testi	sv		261
579	Testi	en		261
451	The Best Moai Documentary Ever	fi		241
452	The best moai documentary ever	sv		241
453	The best moai documentary ever	en		241
631	asdasdasd	fi		266
632	asdasdasd	sv		266
633	asdasdasd	en		266
797	Verkko-oppiminen	sv		276
798	Verkko-oppiminen	en		276
811	TESTI 2	fi		278
812	TESTI 2	sv		278
813	TESTI 2	en		278
309	Avoimet oppimateriaalit - ABC	en		234
637	Italian alkeet 1	fi		267
718	Materiaali	fi		233
719	Materiaali	sv		233
720	Materiaali	en		233
721	Kokeilumateriaali	fi		269
722	Kokeilumateriaali	sv		269
723	Kokeilumateriaali	en		269
730	Testi	fi		259
731	Testi	sv		259
732	Testi	en		259
733		fi		95
734		sv		95
735		en		95
736		fi		83
737		sv		83
738		en		83
739		fi		79
740		sv		79
741		en		79
745	Puuttuva nimi	fi		258
746	Puuttuva nimi	sv		258
747	Puuttuva nimi	en		258
727	MR-testimateriaali 1	fi		228
728	MR-testimateriaali 1	sv		228
729	MR-testimateriaali 1	en		228
700	test	fi		214
701	test	sv		214
702	test	en		214
757	testi	fi		270
758	testi	sv		270
759	testi	en		270
703	Ongelman ratkontaa	fi		268
704	Ongelman ratkontaa	sv		268
705	Ongelman ratkontaa	en		268
781	Kokeilumateriaali	fi		257
782	Kokeilumateriaali	sv		257
783	Kokeilumateriaali	en		257
784	Testaus	fi		272
785	Testaus	sv		272
786	Testaus	en		272
787	abc	fi		273
788	abc	sv		273
789	abc	en		273
790	Bug test	fi		274
791	Bug test	sv		274
792	Bug test	en		274
817	Testi 3	fi		280
818	Testi 3	sv		280
819	Testi 3	en		280
820	testi	fi		281
821	testi	sv		281
277	Kokeilu	fi		208
278	Kokeilu	sv		208
279	Kokeilu	en		208
289	Materiaalin nimi	fi		220
290	Materiaalin nimi	sv		220
291	Materiaalin nimi	en		220
815	TESTI 2	sv		279
822	testi	en		281
796	Verkko-oppiminen	fi		276
856	Kolmikielinen html-testi: Python from scratch	fi		285
808	HTML-TESTI OHO-opas - opiskelukykyä, hyvinvointia ja osallisuutta korkeakouluihin - toinen testi	fi		277
809	HTML-TESTI OHO-opas - opiskelukykyä, hyvinvointia ja osallisuutta korkeakouluihin - toinen testi	sv		277
832	Kuinka tehdä avoimia oppimateriaaleja	fi		283
833	Kuinka tehdä avoimia oppimateriaaleja	sv		283
834	Kuinka tehdä avoimia oppimateriaaleja	en		283
844	Kuinka tehdä avoimia oppimateriaaleja	fi		284
845	Kuinka tehdä avoimia oppimateriaaleja	sv		284
846	How to make OER	en		284
857	Kolmikielinen html-testi: Python from scratch	sv		285
858	Kolmikielinen html-testi: Python from scratch	en		285
810	HTML-TESTI OHO-opas - opiskelukykyä, hyvinvointia ja osallisuutta korkeakouluihin - toinen testi	en		277
862	Zip-testing	fi		286
863	Zip-testing	sv		286
864	Zip-testing	en		286
868	Oho-testi 2	fi		287
869	Oho-testi 2	sv		287
870	Oho-testi 2	en		287
880	Kuinka tehdä avoimia oppimateriaaleja	fi		289
881	Kuinka tehdä avoimia oppimateriaaleja	sv		289
882	How to make OER	en		289
742	Eettinen hakkerointi	fi		169
743	Eettinen hakkerointi	sv		169
638	Skriva öppna lärresurser	sv		267
639	How to make OER	en		267
886	Kuinka tehdä avoimia oppimateriaaleja	fi		291
887	Kuinka tehdä avoimia oppimateriaaleja	sv		291
888	Kuinka tehdä avoimia oppimateriaaleja	en		291
907	Kesämateriaali	fi		293
908	Sommer material	sv		293
909	Summer material	en		293
744	Eettinen hakkerointi	en		169
961	Lintuopas	fi		295
962	Lintuopas	sv		295
963	Lintuopas	en		295
967	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus pharetra viverra nunc, ut aeneani	fi		296
968	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus pharetra viverra nunc, ut aeneani	sv		296
969	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus pharetra viverra nunc, ut aeneani	en		296
937	Suomalainen ruokakulttuuri	fi		294
938	Suomalainen ruokakulttuuri	sv		294
939	Suomalainen ruokakulttuuri	en		294
988	Kokeilumateriaali	fi		297
989	Kokeilumateriaali	sv		297
990	Kokeilumateriaali	en		297
994	xxx	fi		298
995	xxx	sv		298
996	xxx	en		298
997	Kokeilu	fi		299
998	Kokeilu	sv		299
999	Kokeilu	en		299
1018		fi		305
1019		sv		305
1020		en		305
1006	Muokattu Testi	fi		302
1007	Testi	sv		302
1008	Testi	en		302
1042	Kuinka tehdä avoimia oppimateriaaleja	fi		307
1043	Kuinka tehdä avoimia oppimateriaaleja	sv		307
1044	Kuinka tehdä avoimia oppimateriaaleja	en		307
1045	Kuinka tehdä avoimia oppimateriaaleja	fi		308
1046	Kuinka tehdä avoimia oppimateriaaleja	sv		308
1047	Kuinka tehdä avoimia oppimateriaaleja	en		308
1003	Testi	fi		301
1004	Testi	sv		301
1005	Testi	en		301
1012	Testi ilman tiedostoja	fi		304
1013	Testi ilman tiedostoja	sv		304
883	Kuinka tehdä avoimia oppimateriaaleja	fi		290
884	Kuinka tehdä avoimia oppimateriaaleja	sv		290
1014	Testi ilman tiedostoja	en		304
1009	Testi testi	fi		303
874	Äänimateriaali	fi		288
1010	Testi testi	sv		303
1011	Testi testi	en		303
816	TESTI 2	en		279
875	Äänimateriaali	sv		288
876	Äänimateriaali	en		288
793	Ilon ja onnen päivä	fi		275
794	Dag för glädje och lycka	sv		275
795	Day for joy and happiness	en		275
1021	Avointen oppimateriaalien kirjaston käyttöohjeet	fi		306
1022	Avointen oppimateriaalien kirjaston käyttöohjeet	sv		306
1049	hyvä materiaali	fi		310
1050	hyvä materiaali	sv		310
895	Kuinka tehdä avoimia oppimateriaaleja	fi		292
896	Kuinka tehdä avoimia oppimateriaaleja	sv		292
1048	hyvä materiaali	fi		309
1051	hyvä materiaali	sv		309
897	Kuinka tehdä avoimia oppimateriaaleja	en		292
1000	Etäopetuksen hyvät käytännöt - mitä ovat opetus ja oppiminen digitaalisuuden puristuksessa?	fi		300
1001	Puuttuva nimi	sv		300
1002	Puuttuva nimi	en		300
1052	hyvä materiaali	en		310
823	kuva – koe	fi		282
824	kuva-koe	sv		282
825	kuva-koe	en		282
1057	–4 – –6 	fi		311
1058	–4 – –6 	sv		311
1059	–4 – –6 	en		311
1207	Audio recorder, chart ja accordion h5p	fi		342
1208	Audio recorder, chart ja accordion h5p	sv		342
1209	Audio recorder, chart ja accordion h5p	en		342
1213	Agamotto, arthimetic quiz, column ja collage h5p	fi		343
1144	Sadan ja yhden yön tarinat	fi		327
1243	Personality quiz, questionnaire, quiz, single choice, speak the words h5p	fi		348
1078	Uusi materiaali tekstityksillä	fi		314
1079	Uusi materiaali tekstityksillä	sv		314
1080	Uusi materiaali tekstityksillä	en		314
1084	Testi testi testi	fi		315
1085	Testi testi testi	sv		315
1086	Testi testi testi	en		315
1145	Sadan ja yhden yön tarinat	sv		327
885	How to make OER	en		290
1096	Avoin julkaisu - monikielinen	fi		317
1097	Avoin julkaisu - monikielinen	sv		317
1098	Avoin julkaisu - monikielinen	en		317
1053	hyvä materiaali	en		309
1102	Heprean monipuolisuudesta	fi		318
1103	Heprean monipuolisuudesta	sv		318
1104	Heprean monipuolisuudesta	en		318
1177	h5p	fi		337
1178	h5p	sv		337
1179	h5p	en		337
1117	Kokeilu 2	fi		319
1118	Kokeilu 2	sv		319
1119	Kokeilu 2	en		319
1120	kokeilu 3	fi		320
1121	kokeilu 3	sv		320
1122	kokeilu 3	en		320
1123	kokeilu 4	fi		321
1124	kokeilu 4	sv		321
1125	kokeilu 4	en		321
1126	Kokeilu 55	fi		322
1127	Kokeilu 55	sv		322
1128	Kokeilu 55	en		322
1129		fi		323
1130		sv		323
1131		en		323
1132	etkak	fi		324
1133	etkak	sv		324
1134	etkak	en		324
1135	etkak	fi		325
1136	etkak	sv		325
1137	etkak	en		325
1138	etkak	fi		326
1139	etkak	sv		326
1140	etkak	en		326
1072	kokeilu	fi		313
1073	kokeilu	sv		313
1074	kokeilu	en		313
1063	Video teksteillä	fi		312
1064	Video teksteillä	sv		312
1065	Video teksteillä	en		312
775	Kokeilu	fi		271
776	Kokeilu	sv		271
777	Kokeilu	en		271
1214	Agamotto, arthimetic quiz, column ja collage h5p	sv		343
1215	Agamotto, arthimetic quiz, column ja collage h5p	en		343
1183	h5p 2	fi		338
1184	h5p 2	sv		338
1185	h5p 2	en		338
1189	h5p - monta tehtävää	fi		339
1190	h5p - monta tehtävää	sv		339
1191	h5p - monta tehtävää	en		339
1195	h5p - iso määrä, satsi 2	fi		340
1196	h5p - iso määrä, satsi 2	sv		340
1197	h5p - iso määrä, satsi 2	en		340
1201	Presis ja video h5p	fi		341
1202	Presis ja video h5p	sv		341
1203	Presis ja video h5p	en		341
1219	Dictation, documentation, essay, multiple hotspot ja drag and drop h5p	fi		344
1220	Dictation, documentation, essay, multiple hotspot ja drag and drop h5p	sv		344
1221	Dictation, documentation, essay, multiple hotspot ja drag and drop h5p	en		344
1225	find the hotspot, find the words, guess the answer ja iframe embedder h5p	fi		345
1226	find the hotspot, find the words, guess the answer ja iframe embedder h5p	sv		345
1227	find the hotspot, find the words, guess the answer ja iframe embedder h5p	en		345
1231	h5p image: hotspot, seuqenzing, juxtaposition, pairing	fi		346
1232	h5p image: hotspot, seuqenzing, juxtaposition, pairing	sv		346
1233	h5p image: hotspot, seuqenzing, juxtaposition, pairing	en		346
1237	Impressive presis, interactivev book, mark the words, memory game ja multiple choice h5p	fi		347
1238	Impressive presis, interactivev book, mark the words, memory game ja multiple choice h5p	sv		347
1239	Impressive presis, interactivev book, mark the words, memory game ja multiple choice h5p	en		347
1146	Sadan ja yhden yön tarinat	en		327
1090	Testi ilman teksityksiä	fi		316
1091	Testi ilman teksityksiä	sv		316
1092	Testi ilman teksityksiä	en		316
1249	Speak the words set, summary, timeline, truefalse, virtual tour, advanced fill in the blanks h5p	fi		349
1250	Speak the words set, summary, timeline, truefalse, virtual tour, advanced fill in the blanks h5p	sv		349
1618	Odp pdf:ksi	fi		381
1255	H5p väärällä päättellä	fi		350
1256	H5p väärällä päättellä	sv		350
1257	H5p väärällä päättellä	en		350
1285	Lukio-testi	fi		352
1286	Lukio-testi	sv		352
1287	Lukio-testi	en		352
1288	testi	fi		353
1289	testi	sv		353
1290	testi	en		353
1597	uusi testi	fi		376
1598	uusi testi	sv		376
1599	uusi testi	en		376
1375	Adobe Presenter -materiaalin testaus	fi		358
1376	Adobe Presenter -materiaalin testaus	sv		358
1377	Adobe Presenter -materiaalin testaus	en		358
1244	Personality quiz, questionnaire, quiz, single choice, speak the words h5p	sv		348
1245	Personality quiz, questionnaire, quiz, single choice, speak the words h5p	en		348
1483	Testimateriaali	fi		368
1408	Kokeilu	fi		360
1409	Kokeilu	sv		360
1410	Kokeilu	en		360
1414	Nopeustesti - Ipad3 purkaminen	fi		361
1415	Nopeustesti - Ipad3 purkaminen	sv		361
1416	Nopeustesti - Ipad3 purkaminen	en		361
1351	Ammattitaitovaatimukset2	fi		356
1352	Ammattitaitovaatimukset	sv		356
1353	Ammattitaitovaatimukset	en		356
1567	Bugitesti	fi		370
1568	Bugitesti	sv		370
1569	Bugitesti	en		370
1279	Testi	fi		351
1280	Testi	sv		351
1281	Testi	en		351
1426	Popupkoulu.fi	fi		363
1427	Popupkoulu.fi	sv		363
1428	Popupkoulu.fi	en		363
1357	Testi	fi		357
1358	Testi	sv		357
1359	Testi	en		357
1291	Testi 2	fi		354
1292	Testi 2	sv		354
1293	Testi 2	en		354
1579	Raskas oppimateriaali	fi		371
1484	Testimateriaali	sv		368
1485	Testimateriaali	en		368
1580	Raskas oppimateriaali	sv		371
1420	ACT NOW	fi		362
1421	ACT NOW	sv		362
1422	ACT NOW	en		362
1393	Testi	fi		359
1394	Testi	sv		359
1395	Testi	en		359
1581	Raskas oppimateriaali	en		371
1585	Raskas testi	fi		372
1459	Docx-testi	fi		366
1453	excel-testi	fi		365
1454	excel-testi	sv		365
1455	excel-testi	en		365
1460	Docx-testi	sv		366
1461	Docx-testi	en		366
1586	Raskas testi	sv		372
1600	kokeilu	fi		377
1601	kokeilu	sv		377
1602	kokeilu	en		377
1513	Nepalilaisen ruuan valmistaminen	fi		369
1514	Nepalilaisen ruuan valmistaminen	sv		369
1515	Nepalilaisen ruuan valmistaminen	en		369
1612	Metatietojen testaus	fi		380
1613	Metatietojen testaus	sv		380
1614	Metatietojen testaus	en		380
1587	Raskas testi	en		372
1588	Raskas - taas	fi		373
1465	powerpointit ja vastaavat	fi		367
1466	powerpointit ja vastaavat	sv		367
1467	powerpointit ja vastaavat	en		367
814	'Oivalluksen ilo näkyy kirkkaana lapsen silmissä' - Työkaluja opettajalle lapsen ohjelmointitaitojen havainnoimiseen monenlaisissa tapaamismuodoissa	fi		279
1589	Raskas - taas	sv		373
1590	Raskas - taas	en		373
1591	Raskas - uudelleen	fi		374
1592	Raskas - uudelleen	sv		374
1593	Raskas - uudelleen	en		374
1594	kokeilu	fi		375
1595	kokeilu	sv		375
1596	kokeilu	en		375
1603	Karhun materiaali, osa 1 	fi		378
1604	Karhun materiaali, osa 1 	sv		378
1605	Karhun materiaali, osa 1 	en		378
1609	Karhu 2	fi		379
1610	Karhu 2	sv		379
1611	Karhu 2	en		379
1432	Luokkavaltuusto: Opas kouludemokratian edistämiseen	fi		364
1433	Luokkavaltuusto: Opas kouludemokratian edistämiseen	sv		364
1345	näkyykö	fi		355
1346	näkyykö	sv		355
1347	näkyykö	en		355
1830	Olevaisen pohdinta	en		401
1862	soffice	sv		403
1863	soffice	en		403
1624	Doc pdfksi	fi		382
1625	Doc pdfksi	sv		382
1626	Doc pdfksi	en		382
1633	Avoimet oppimateriaalit ABC	fi		383
1634	Avoimet oppimateriaalit ABC	sv		383
1635	Open Educational Resources - ABC	en		383
1636	Hidasta ja raskasta	fi		384
1637	Hidasta ja raskasta	sv		384
1638	Hidasta ja raskasta	en		384
1645	karhuilua	fi		386
1646	karhuilua	sv		386
1647	karhuilua	en		386
1657	Eksogeeniset prosessit	fi		387
1658	Eksogeeniset prosessit	sv		387
1659	Eksogeeniset prosessit	en		387
1660		fi		388
1661		sv		388
1662		en		388
1434	Luokkavaltuusto: Opas kouludemokratian edistämiseen	en		364
1639	karhutesti	fi		385
1640	karhutesti	sv		385
1641	karhutesti	en		385
1687	Retesting	fi		389
1688	Retesting	sv		389
1689	Retesting	en		389
1690	testataan	fi		390
1691	testataan	sv		390
1692	testataan	en		390
1696	Esto?	fi		391
1697	Esto?	sv		391
1698	Esto?	en		391
1705	Testi	fi		392
1706	Testi	sv		392
1707	Testi	en		392
1726	Lumenluonti	fi		393
1727	Lumenluonti	sv		393
1728	Lumenluonti	en		393
1789	testi	fi		397
1790	testi	sv		397
1791	testi	en		397
1762	Oppimateriaalien muokkaus	fi		396
1763	Oppimateriaalien muokkaus	sv		396
1764	Oppimateriaalien muokkaus	en		396
1867	Excelin luovuus	fi		404
1868	Excelin luovuus	sv		404
1869	Excelin luovuus	en		404
1251	Speak the words set, summary, timeline, truefalse, virtual tour, advanced fill in the blanks h5p	en		349
1798	Testi	fi		398
1799	Testi	sv		398
1800	Testi	en		398
1729	Talvi on	fi		394
1730	Talvi on	sv		394
1731	Talvi on	en		394
1735	Jään poistaminen ikkunoista	fi		395
1736	Jään poistaminen ikkunoista	sv		395
1737	Jään poistaminen ikkunoista	en		395
1619	Odp pdf:ksi	sv		381
1620	Odp pdf:ksi	en		381
1873	Uusi koe-erä	fi		405
1874	Uusi koe-erä	sv		405
1875	Uusi koe-erä	en		405
1852	Lelan matematiikkaseikkailu päiväkodissa	fi		402
1853	Lelan matematiikkaseikkailu päiväkodissa	sv		402
1854	Lelan matematiikkaseikkailu päiväkodissa	en		402
1813	Testaus	fi		399
1814	Testaus	sv		399
1815	Testaus	en		399
1822	Sähkökatkon aikainen toiminta	fi		400
1823	Sähkökatkon aikainen toiminta	sv		400
1824	Sähkökatkon aikainen toiminta	en		400
1828	Olevaisen pohdinta	fi		401
1829	Olevaisen pohdinta	sv		401
1861	soffice	fi		403
1879	Testausta	fi		406
1880	Testausta	sv		406
1881	Testausta	en		406
1885	Pohdinta 2	fi		407
1886	Pohdinta 2	sv		407
1887	Pohdinta 2	en		407
1891	Kokeilu 3	fi		408
1892	Kokeilu 3	sv		408
1893	Kokeilu 3	en		408
1897	Pohdiskelu	fi		409
1898	Pohdiskelu	sv		409
1899	Pohdiskelu	en		409
1903	Tupla tai kuitti	fi		251
1904	Tupla tai kuitti	sv		251
1905	Tupla tai kuitti	en		251
1945		fi		412
1023	Avointen oppimateriaalien kirjaston käyttöohjeet	en		306
1946		sv		412
1915	pistetesti	fi		410
1916	pistetesti	sv		410
1917	pistetesti	en		410
1924	Testi	fi		411
1925	Testi	sv		411
1926	Testi	en		411
1947		en		412
1948	kukka	fi		413
1949	kukka	sv		413
1950	kukka	en		413
1951		fi		414
1952		sv		414
1953		en		414
1954		fi		415
1955		sv		415
1956		en		415
1957	Testi	fi		416
1958	Testi	sv		416
1959	Testi	en		416
1960		fi		417
1961		sv		417
1962		en		417
1963		fi		418
1964		sv		418
1965		en		418
1966		fi		419
1967		sv		419
1968		en		419
1975	testi	fi		420
1976	testi	sv		420
1977	testi	en		420
1981	Raaaskas	fi		421
1982	Raaaskas	sv		421
1983	Raaaskas	en		421
1984	rashkas	fi		422
1985	rashkas	sv		422
1986	rashkas	en		422
1987	rashkasko	fi		423
1988	rashkasko	sv		423
1989	rashkasko	en		423
1990	Raskas 3	fi		424
1991	Raskas 3	sv		424
1992	Raskas 3	en		424
1993	5	fi		425
1994	5	sv		425
1995	5	en		425
1996	2.0gt	fi		426
1997	2.0gt	sv		426
1998	2.0gt	en		426
\.


--
-- Data for Name: publisher; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.publisher (id, name, educationalmaterialid, publisherkey) FROM stdin;
1	Opettajana virtuaaliluokassa -hanke	2	opettajanavirtuaaliluokassahanke
2	Opettajana virtuaaliluokassa -hanke	20	opettajanavirtuaaliluokassahanke
3	org1	23	org1
4	org2	23	org2
10	Opettajana virtuaaliluokassa -hanke	56	opettajanavirtuaaliluokassahanke
11	Opettajana virtuaaliluokassa -hanke	57	opettajanavirtuaaliluokassahanke
12	Opettajana virtuaaliluokassa -hanke	54	opettajanavirtuaaliluokassahanke
13	Konedigi-hanke	160	konedigihanke
14	Digipeda-hanke	168	digipedahanke
16	MeDigi-hanke	183	medigihanke
19	Koulutus ab	231	koulutusab
17	Sotepeda 24/7 -hanke	215	sotepeda247hanke
41	Avointen oppimateriaalien edistäminen -hanke	177	avointenoppimateriaalienedistminenhanke
43	Avointen oppimateriaalien edistäminen -hanke	284	avointenoppimateriaalienedistminenhanke
40	Julkaisijat Oy	271	julkaisijatoy
48	Kehittämiskeskus Opinkirjo	363	kehittmiskeskusopinkirjo
63	Ruokistajat	369	ruokistajat
18	Hanke-hanke	220	hankehanke
72	Kustannus oy Suomi ab	310	kustannusoysuomiab
49	Kehittämiskeskus Opinkirjo	364	kehittmiskeskusopinkirjo
47	Kehittämiskeskus Opinkirjo	362	kehittmiskeskusopinkirjo
50	testi tesit	356	testitesit
52	toinen	356	toinen
\.


--
-- Data for Name: rating; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.rating (id, ratingcontent, ratingvisual, feedbackpositive, feedbacksuggest, feedbackpurpose, educationalmaterialid, usersusername, updatedat) FROM stdin;
1	5	4	Testi	Test	Testen	234	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	2020-04-16 11:52:21.900356
7	2	2	\N	\N	\N	247	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	2020-04-16 11:58:32.861593
10	3	4	Hyvää	Kehitettävää	Hyödynsin	249	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	2020-05-15 10:36:42.47969
11	5	1	Kansikuva on vetävä	\N	Testailin arvioinnin toimivuutta.	245	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	2020-05-18 04:50:13.749121
12	5	5	Autto paljon kaikkiin	Lisää näkyvyyttä	Oppimiseen	265	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	2020-05-18 05:08:04.130931
14	3	3	\N	\N	\N	245	anlindfo@csc.fi	2020-05-18 05:10:16.955589
17	4	3	Materiaali esitteli ansiokkaasti avoimissa oppimateriaaleissa huomioitavia asioita. Oppimateriaaliin kuuluvat tehtävät tukivat oppimista. Sisältö oli ilmaistu selkeästi.	Jäin kaipaamaan lisää lähdeviitteitä, jotta voisin syventyä aiheeseen enemmän. Tyyliin olisi voinut panostaa lisää, oletko katsellut erilaisia avoimia templateja ja kuvia joita hyödyntää?	Käytin materiaalia itseopiskelussa ja vinkkasin sen kolleegalle.	267	anlindfo@csc.fi	2020-05-18 09:10:46.980994
18	5	5	paljon	\N	\N	234	anlindfo@csc.fi	2020-05-18 09:19:54.479348
19	1	2	\N	\N	\N	200	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	2020-05-18 09:31:08.454606
15	\N	\N				245	teppo@yliopisto.fi	2020-05-18 10:51:07.226076
22	\N	3	Paljon hyvää	\N	\N	207	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	2020-05-18 10:54:16.000543
21	5	\N	Kaikki	\N	\N	249	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	2020-05-18 10:54:34.91063
24	5	\N	\N	\N	\N	266	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	2020-05-18 10:54:47.982453
25	\N	\N	\N	\N		178	teppo@yliopisto.fi	2020-05-18 11:00:48.183883
27	3	4	Todella hyvä materiaali	\N	\N	267	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	2020-05-18 11:09:14.484895
28	\N	\N	kukkuu kukkuu kaukana kukkuu	saimaan rannalla ruikuttaa	\N	245	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	2020-05-18 11:20:49.869695
30	4	5	Hard as a rock	Rolling stones	For fun	241	mroppone@csc.fi	2020-05-25 08:36:17.400603
31	5	5	Kaikki	-	Testaukseen	271	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	2020-06-04 09:02:43.541015
32	4	5	\N	\N	\N	285	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	2020-06-23 09:39:20.090526
33	5	5	Kaikki	\N	\N	169	mroppone@csc.fi	2020-07-03 12:06:01.266696
34	4	4	Materiaali toi hyvin esille aiheen perusteet. Sen rakenne oli selkeä ja tekstiä oli miellyttävä lukea.	Kaipasin enemmän lukuvinkkejä ja lähteitä - mistä saada lisätietoa aiheesta. Lisäksi sivulla 9 näytti olevan virhe toimijan nimessä (UNESCO - UNEVOC).	Käytin materiaali itseopiskeluun osana oman oppimateriaalin avaamisen prosessia. Otin lisenssikappaleen myös käyttöön osana opetustani.	234	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	2020-08-04 04:54:15.763534
35	4	4	Se teki mitä lupasi - nyt osaan käyttää palvelua.	Kuvat olisivat saaneet olla suurempia, nyt piti samalla katsoa itse palvelua.	Katsoin ohjeistukset ennen omien materiaalieni tallentamista.	306	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	2020-09-01 09:18:54.627664
36	4	3	Kaikki	Laajasti visuaalisuutta	arviointiin	351	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	2020-10-13 06:03:54.80837
37	3	5	Jätte bra - alt var helt okej	En oppinut hepreaa - heprean perusteet olisi hyvä lisä	Itsenäiseen opiskeluun	318	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	2020-10-29 07:37:51.796988
38	3	4	Otsikko oli osuva	Sisällön ilmaisua voisi harjottaa 	Elämäni parantamiseen	220	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	2020-10-29 07:39:23.27889
39	3	4	1	2	3	275	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	2020-11-12 08:51:25.061657
\.


--
-- Data for Name: record; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.record (id, filepath, originalfilename, filesize, mimetype, format, materialid, filekey, filebucket, pdfkey) FROM stdin;
1	https://testing.object.pouta.csc.fi/testikuva-1572530539154.png	testikuva.png	11760	image/png	7bit	1	testikuva-1572530539154.png	testing	\N
11	object.pouta.csc.fi/testing/pythonmasterpaivitetty-1572939315118.zip	python-master-paivitetty.zip	39804110	application/zip	7bit	13	pythonmasterpaivitetty-1572939315118.zip	testing	\N
12	object.pouta.csc.fi/testing/pythonsvmasterpaivitetty-1572939333245.zip	python_sv-master-paivitetty.zip	39804049	application/zip	7bit	14	pythonsvmasterpaivitetty-1572939333245.zip	testing	\N
13	object.pouta.csc.fi/testing/pythonenmasterpaivitetty-1572939351178.zip	python_en-master-paivitetty.zip	39803114	application/zip	7bit	15	pythonenmasterpaivitetty-1572939351178.zip	testing	\N
14	object.pouta.csc.fi/testing/pythonmasterpaivitetty-1572939600685.zip	python-master-paivitetty.zip	39804110	application/zip	7bit	16	pythonmasterpaivitetty-1572939600685.zip	testing	\N
15	object.pouta.csc.fi/testing/pythonsvmasterpaivitetty-1572939618847.zip	python_sv-master-paivitetty.zip	39804049	application/zip	7bit	17	pythonsvmasterpaivitetty-1572939618847.zip	testing	\N
16	object.pouta.csc.fi/testing/pythonenmasterpaivitetty-1572939636580.zip	python_en-master-paivitetty.zip	39803114	application/zip	7bit	18	pythonenmasterpaivitetty-1572939636580.zip	testing	\N
17	object.pouta.csc.fi/testing/pythonmasterpaivitetty-1572940524603.zip	python-master-paivitetty.zip	39804110	application/zip	7bit	19	pythonmasterpaivitetty-1572940524603.zip	testing	\N
18	object.pouta.csc.fi/testing/pythonsvmasterpaivitetty-1572940542361.zip	python_sv-master-paivitetty.zip	39804049	application/zip	7bit	20	pythonsvmasterpaivitetty-1572940542361.zip	testing	\N
19	object.pouta.csc.fi/testing/pythonenmasterpaivitetty-1572940560314.zip	python_en-master-paivitetty.zip	39803114	application/zip	7bit	21	pythonenmasterpaivitetty-1572940560314.zip	testing	\N
20	https://testing.object.pouta.csc.fi/Johdatustekolyyn-1572942352112.pdf	Johdatus tekoälyyn.pdf	863390	application/pdf	7bit	22	Johdatustekolyyn-1572942352112.pdf	testing	\N
26	https://testing.object.pouta.csc.fi/Liite1Robotiikanoppimisenpolku-1572948972730.png	Liite 1 - Robotiikan oppimisen polku.png	204613	image/png	7bit	28	Liite1Robotiikanoppimisenpolku-1572948972730.png	testing	\N
56	object.pouta.csc.fi/testing/AVideoOpetuksenjaoppimisensuunnittelu-1572952274449.mp4	A Video Opetuksen ja oppimisen suunnittelu.mp4	31795910	video/mp4	7bit	58	AVideoOpetuksenjaoppimisensuunnittelu-1572952274449.mp4	testing	\N
4	https://testing.object.pouta.csc.fi/1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1572612105551.pptx	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1.pptx	287378	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	4	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1572612105551.pptx	testing	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1572612105551.pdf
5	https://testing.object.pouta.csc.fi/2mitentuetaanopiskelijoidenyhteisollisyydenkehittymista2-1572612105746.pptx	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2.pptx	288552	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	5	2mitentuetaanopiskelijoidenyhteisollisyydenkehittymista2-1572612105746.pptx	testing	2mitentuetaanopiskelijoidenyhteisollisyydenkehittymista2-1572612105746.pdf
6	https://testing.object.pouta.csc.fi/Skrivappnalrresurser-1572614953561.pptx	Skriva öppna lärresurser.pptx	85364	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	6	Skrivappnalrresurser-1572614953561.pptx	testing	Skrivappnalrresurser-1572614953561.pdf
7	https://testing.object.pouta.csc.fi/Skrivappnalrresurser-1572614981842.pptx	Skriva öppna lärresurser.pptx	85364	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	7	Skrivappnalrresurser-1572614981842.pptx	testing	Skrivappnalrresurser-1572614981842.pdf
8	https://testing.object.pouta.csc.fi/Skrivappnalrresurser-1572614981851.pptx	Skriva öppna lärresurser.pptx	85364	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	8	Skrivappnalrresurser-1572614981851.pptx	testing	Skrivappnalrresurser-1572614981851.pdf
10	https://testing.object.pouta.csc.fi/Ninteetavoimiaoppimateriaaleja-1572619123009.pptx	Näin teet avoimia oppimateriaaleja.pptx	85367	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	12	Ninteetavoimiaoppimateriaaleja-1572619123009.pptx	testing	Ninteetavoimiaoppimateriaaleja-1572619123009.pdf
21	https://testing.object.pouta.csc.fi/Introduktiontillartificiellintelligens-1572942352545.odt	Introduktion till artificiell intelligens.odt	399689	application/vnd.oasis.opendocument.text	7bit	23	Introduktiontillartificiellintelligens-1572942352545.odt	testing	Introduktiontillartificiellintelligens-1572942352545.pdf
22	https://testing.object.pouta.csc.fi/Introductiontoartificialintelligence-1572942352779.odt	_Introduction to artificial intelligence.odt	464033	application/vnd.oasis.opendocument.text	7bit	24	Introductiontoartificialintelligence-1572942352779.odt	testing	Introductiontoartificialintelligence-1572942352779.pdf
23	object.pouta.csc.fi/testing/Johdatusrobotiikanopettamiseen-1572948368467.docx	Johdatus robotiikan opettamiseen.docx	8172850	application/vnd.openxmlformats-officedocument.wordprocessingml.document	7bit	25	Johdatusrobotiikanopettamiseen-1572948368467.docx	testing	Johdatusrobotiikanopettamiseen-1572948368467.pdf
24	https://testing.object.pouta.csc.fi/41EV3nohjelmointisimulaattorissa-1572948969765.pptx	4.1 EV3_n ohjelmointi simulaattorissa.pptx	4348623	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	26	41EV3nohjelmointisimulaattorissa-1572948969765.pptx	testing	41EV3nohjelmointisimulaattorissa-1572948969765.pdf
25	https://testing.object.pouta.csc.fi/42MicrobitinohjelmointiMakeCodessa-1572948971675.pptx	4.2 Micro_bitin ohjelmointi MakeCode_ssa.pptx	2395640	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	27	42MicrobitinohjelmointiMakeCodessa-1572948971675.pptx	testing	42MicrobitinohjelmointiMakeCodessa-1572948971675.pdf
27	https://testing.object.pouta.csc.fi/Liite2MicrobitKPS-1572948972825.docx	Liite 2_ Micro_bit KPS.docx	1145593	application/vnd.openxmlformats-officedocument.wordprocessingml.document	7bit	29	Liite2MicrobitKPS-1572948972825.docx	testing	Liite2MicrobitKPS-1572948972825.pdf
31	https://testing.object.pouta.csc.fi/Liite1Robotiikanoppimisenpolkutekstisv-1572948979981.pdf	Liite 1 - Robotiikan oppimisen polku_teksti_sv.pdf	533496	application/pdf	7bit	33	Liite1Robotiikanoppimisenpolkutekstisv-1572948979981.pdf	testing	\N
42	https://testing.object.pouta.csc.fi/bPodcastDigipedagogiikkateksti-1572950850916.pdf	b Podcast  Digipedagogiikka - teksti.pdf	47824	application/pdf	7bit	44	bPodcastDigipedagogiikkateksti-1572950850916.pdf	testing	\N
43	object.pouta.csc.fi/testing/APodcastDigipedagogiikka-1572950850940.m4a	A Podcast Digipedagogiikka.m4a	13442305	audio/mp4	7bit	45	APodcastDigipedagogiikka-1572950850940.m4a	testing	\N
44	https://testing.object.pouta.csc.fi/bPodcastDigipedagogiikkateksti-1572950857026.pdf	b Podcast  Digipedagogiikka - teksti.pdf	47824	application/pdf	7bit	46	bPodcastDigipedagogiikkateksti-1572950857026.pdf	testing	\N
45	object.pouta.csc.fi/testing/APodcastDigipedagogik-1572950857048.m4a	A Podcast Digipedagogik.m4a	14037109	audio/mp4	7bit	47	APodcastDigipedagogik-1572950857048.m4a	testing	\N
46	https://testing.object.pouta.csc.fi/bPodcastDigipedagogiktext-1572950863277.pdf	b Podcast Digipedagogik text.pdf	44356	application/pdf	7bit	48	bPodcastDigipedagogiktext-1572950863277.pdf	testing	\N
47	object.pouta.csc.fi/testing/APodcastDigitalPedagogy-1572950863291.m4a	A Podcast Digital Pedagogy.m4a	14016097	audio/mp4	7bit	49	APodcastDigitalPedagogy-1572950863291.m4a	testing	\N
48	https://testing.object.pouta.csc.fi/bPodcastDigitalpedagogytext-1572950869770.pdf	b Podcast Digital pedagogy - text  .pdf	60948	application/pdf	7bit	50	bPodcastDigitalpedagogytext-1572950869770.pdf	testing	\N
49	https://testing.object.pouta.csc.fi/bVideoDigitaalisuusjateknologiakouluissateksti-1572951440577.pdf	b Video Digitaalisuus ja teknologia kouluissa - teksti.pdf	47750	application/pdf	7bit	51	bVideoDigitaalisuusjateknologiakouluissateksti-1572951440577.pdf	testing	\N
50	object.pouta.csc.fi/testing/AVideoDigitaalisuusjateknologiakouluissa-1572951440601.mp4	A Video Digitaalisuus ja teknologia kouluissa.mp4	40727727	video/mp4	7bit	52	AVideoDigitaalisuusjateknologiakouluissa-1572951440601.mp4	testing	\N
51	https://testing.object.pouta.csc.fi/bVideoDigitaalisuusjateknologiakouluissateksti-1572951459024.pdf	b Video Digitaalisuus ja teknologia kouluissa - teksti.pdf	47750	application/pdf	7bit	53	bVideoDigitaalisuusjateknologiakouluissateksti-1572951459024.pdf	testing	\N
52	object.pouta.csc.fi/testing/AVideoDigitaliseringochteknologiiskolor-1572951459045.mp4	A Video Digitalisering och teknologi i skolor.mp4	40468986	video/mp4	7bit	54	AVideoDigitaliseringochteknologiiskolor-1572951459045.mp4	testing	\N
53	https://testing.object.pouta.csc.fi/bVideoDigitaliseringochteknologiiskolortext-1572951477067.pdf	b Video Digitalisering och teknologi i skolor text.pdf	38971	application/pdf	7bit	55	bVideoDigitaliseringochteknologiiskolortext-1572951477067.pdf	testing	\N
54	object.pouta.csc.fi/testing/AVideoDigitalizationandtechnologyinschools-1572951477088.mp4	A Video Digitalization and technology in schools.mp4	42230899	video/mp4	7bit	56	AVideoDigitalizationandtechnologyinschools-1572951477088.mp4	testing	\N
55	https://testing.object.pouta.csc.fi/bVideoDigitalizationandtechnologyinschoolstext-1572951496113.pdf	b Video Digitalization and technology in schools - text.pdf	56240	application/pdf	7bit	57	bVideoDigitalizationandtechnologyinschoolstext-1572951496113.pdf	testing	\N
244	https://testing.object.pouta.csc.fi/lab1-1576743275250.pdf	lab1.pdf	116799	application/pdf	7bit	306	lab1-1576743275250.pdf	testing	\N
30	https://testing.object.pouta.csc.fi/42MicrobitinohjelmointiMakeCodessasv-1572948979147.pptx	4.2 Micro_bitin ohjelmointi MakeCode_ssa_sv.pptx	2402716	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	32	42MicrobitinohjelmointiMakeCodessasv-1572948979147.pptx	testing	42MicrobitinohjelmointiMakeCodessasv-1572948979147.pdf
32	https://testing.object.pouta.csc.fi/Liite2MicrobitKPSsv-1572948980212.docx	Liite 2_ Micro_bit KPS sv.docx	1114054	application/vnd.openxmlformats-officedocument.wordprocessingml.document	7bit	34	Liite2MicrobitKPSsv-1572948980212.docx	testing	Liite2MicrobitKPSsv-1572948980212.pdf
34	https://testing.object.pouta.csc.fi/41EV3programminginasimulator-1572948984336.pptx	4.1 EV3 programming in a simulator.pptx	4347961	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	36	41EV3programminginasimulator-1572948984336.pptx	testing	41EV3programminginasimulator-1572948984336.pdf
35	https://testing.object.pouta.csc.fi/42MicrobitprogramminginMakeCode-1572948986302.pptx	4.2 Micro_bit programming in MakeCode.pptx	2395561	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	37	42MicrobitprogramminginMakeCode-1572948986302.pptx	testing	42MicrobitprogramminginMakeCode-1572948986302.pdf
36	object.pouta.csc.fi/testing/Johdatusrobotiikanopettamiseen-1572949137513.docx	Johdatus robotiikan opettamiseen.docx	8172850	application/vnd.openxmlformats-officedocument.wordprocessingml.document	7bit	38	Johdatusrobotiikanopettamiseen-1572949137513.docx	testing	Johdatusrobotiikanopettamiseen-1572949137513.pdf
37	https://testing.object.pouta.csc.fi/41EV3nohjelmointisimulaattorissa-1572949141252.pptx	4.1 EV3_n ohjelmointi simulaattorissa.pptx	4348623	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	39	41EV3nohjelmointisimulaattorissa-1572949141252.pptx	testing	41EV3nohjelmointisimulaattorissa-1572949141252.pdf
38	https://testing.object.pouta.csc.fi/42MicrobitinohjelmointiMakeCodessa-1572949143278.pptx	4.2 Micro_bitin ohjelmointi MakeCode_ssa.pptx	2395640	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	40	42MicrobitinohjelmointiMakeCodessa-1572949143278.pptx	testing	42MicrobitinohjelmointiMakeCodessa-1572949143278.pdf
40	object.pouta.csc.fi/testing/Johdatusrobotiikanopettamiseen-1572949232341.docx	Johdatus robotiikan opettamiseen.docx	8172850	application/vnd.openxmlformats-officedocument.wordprocessingml.document	7bit	42	Johdatusrobotiikanopettamiseen-1572949232341.docx	testing	Johdatusrobotiikanopettamiseen-1572949232341.pdf
41	https://testing.object.pouta.csc.fi/Ninteetavoimiaoppimateriaaleja-1572949617963.pptx	Näin teet avoimia oppimateriaaleja.pptx	85367	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	43	Ninteetavoimiaoppimateriaaleja-1572949617963.pptx	testing	Ninteetavoimiaoppimateriaaleja-1572949617963.pdf
57	https://testing.object.pouta.csc.fi/bVideoOpetuksenjaoppimisensuunnitteluteksti-1572952288638.pdf	b Video Opetuksen ja oppimisen suunnittelu - teksti  .pdf	48544	application/pdf	7bit	59	bVideoOpetuksenjaoppimisensuunnitteluteksti-1572952288638.pdf	testing	\N
58	https://testing.object.pouta.csc.fi/cInfotauluOpetuksenjaoppimisensuunnittelu-1572952288658.pdf	c Infotaulu Opetuksen ja oppimisen suunnittelu.pdf	294624	application/pdf	7bit	60	cInfotauluOpetuksenjaoppimisensuunnittelu-1572952288658.pdf	testing	\N
59	object.pouta.csc.fi/testing/AVideoPlaneringavundervisningochlarande-1572952288788.mp4	A Video Planering av undervisning och lärande.mp4	30562026	video/mp4	7bit	61	AVideoPlaneringavundervisningochlarande-1572952288788.mp4	testing	\N
60	https://testing.object.pouta.csc.fi/bVideoPlaneringavundervisningochlarandetext-1572952302596.pdf	b Video Planering av undervisning och lärande text.pdf	39844	application/pdf	7bit	62	bVideoPlaneringavundervisningochlarandetext-1572952302596.pdf	testing	\N
61	https://testing.object.pouta.csc.fi/cInfografPlaneringavundervisningochlarande-1572952302597.pdf	c Infograf Planering av undervisning och lärande.pdf	300683	application/pdf	7bit	63	cInfografPlaneringavundervisningochlarande-1572952302597.pdf	testing	\N
62	object.pouta.csc.fi/testing/AVideoLearningdesign-1572952302654.mp4	A Video Learning design.mp4	31820850	video/mp4	7bit	64	AVideoLearningdesign-1572952302654.mp4	testing	\N
63	https://testing.object.pouta.csc.fi/bVideoLearningdesigntextscript-1572952317379.pdf	b Video Learning design text script.pdf	55221	application/pdf	7bit	65	bVideoLearningdesigntextscript-1572952317379.pdf	testing	\N
64	https://testing.object.pouta.csc.fi/cInfografLearningDesign-1572952317401.pdf	c Infograf Learning Design.pdf	312543	application/pdf	7bit	66	cInfografLearningDesign-1572952317401.pdf	testing	\N
65	https://testing.object.pouta.csc.fi/kInfografOpenphenomenonbasedlearningprocess-1573209703785.pdf	k Infograf Open phenomenon-based learning process.pdf	114770	application/pdf	7bit	67	kInfografOpenphenomenonbasedlearningprocess-1573209703785.pdf	testing	\N
70	object.pouta.csc.fi/testing/APodcastOppimistehtava-1573555144655.m4a	A Podcast Oppimistehtävä.m4a	18311361	audio/mp4	7bit	72	APodcastOppimistehtava-1573555144655.m4a	testing	\N
71	https://testing.object.pouta.csc.fi/bPodcastOppimistehtavateksti-1573555146690.pdf	b Podcast Oppimistehtävä - teksti  .pdf	63216	application/pdf	7bit	73	bPodcastOppimistehtavateksti-1573555146690.pdf	testing	\N
72	https://testing.object.pouta.csc.fi/cOppimistehtavaideoitaoppimisprosessinerivaiheisiin-1573555146696.pdf	c Oppimistehtäväideoita oppimisprosessin eri vaiheisiin.pdf	42609	application/pdf	7bit	74	cOppimistehtavaideoitaoppimisprosessinerivaiheisiin-1573555146696.pdf	testing	\N
73	https://testing.object.pouta.csc.fi/dOppimistehtavansuunnittelu-1573555146702.pdf	d Oppimistehtävän suunnittelu.pdf	56348	application/pdf	7bit	75	dOppimistehtavansuunnittelu-1573555146702.pdf	testing	\N
74	object.pouta.csc.fi/testing/APodcastLaruppgifter-1573555146709.m4a	A Podcast Läruppgifter.m4a	20077309	audio/mp4	7bit	76	APodcastLaruppgifter-1573555146709.m4a	testing	\N
75	https://testing.object.pouta.csc.fi/bPodcastLaruppgiftertext-1573555149209.pdf	b Podcast Läruppgifter text.pdf	50353	application/pdf	7bit	77	bPodcastLaruppgiftertext-1573555149209.pdf	testing	\N
76	https://testing.object.pouta.csc.fi/cIdeerforlaruppgifter-1573555149212.pdf	c Ideer för läruppgifter.pdf	51921	application/pdf	7bit	78	cIdeerforlaruppgifter-1573555149212.pdf	testing	\N
77	https://testing.object.pouta.csc.fi/dPlaneringsblankettlaruppgifter-1573555149217.pdf	d Planeringsblankett läruppgifter.pdf	56656	application/pdf	7bit	79	dPlaneringsblankettlaruppgifter-1573555149217.pdf	testing	\N
78	object.pouta.csc.fi/testing/APodcastLearningassignments-1573555149224.m4a	A Podcast Learning assignments.m4a	18801288	audio/mp4	7bit	80	APodcastLearningassignments-1573555149224.m4a	testing	\N
79	https://testing.object.pouta.csc.fi/bPodcastLearningassignmentstext-1573555151502.pdf	b Podcast Learning assignments text .pdf	64641	application/pdf	7bit	81	bPodcastLearningassignmentstext-1573555151502.pdf	testing	\N
80	https://testing.object.pouta.csc.fi/cInfografLearningassignmentideas-1573555151509.pdf	c Infograf Learning assignment ideas.pdf	33849	application/pdf	7bit	82	cInfografLearningassignmentideas-1573555151509.pdf	testing	\N
81	https://testing.object.pouta.csc.fi/dPlanninglearningassignments-1573555151512.pdf	d Planning learning assignments .pdf	51004	application/pdf	7bit	83	dPlanninglearningassignments-1573555151512.pdf	testing	\N
83	https://testing.object.pouta.csc.fi/ammatillisentutkinnonosat-1573635500772.json	ammatillisen-tutkinnonosat.json	523739	application/json	7bit	85	ammatillisentutkinnonosat-1573635500772.json	testing	\N
67	https://testing.object.pouta.csc.fi/Skrivappnalrresurser-1573464743042.pptx	Skriva öppna lärresurser.pptx	85364	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	69	Skrivappnalrresurser-1573464743042.pptx	testing	Skrivappnalrresurser-1573464743042.pdf
68	https://testing.object.pouta.csc.fi/Skrivappnalrresurser-1573464743053.pptx	Skriva öppna lärresurser.pptx	85364	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	70	Skrivappnalrresurser-1573464743053.pptx	testing	Skrivappnalrresurser-1573464743053.pdf
69	https://testing.object.pouta.csc.fi/Ninteetavoimiaoppimateriaaleja-1573540696345.pptx	Näin teet avoimia oppimateriaaleja.pptx	85367	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	71	Ninteetavoimiaoppimateriaaleja-1573540696345.pptx	testing	Ninteetavoimiaoppimateriaaleja-1573540696345.pdf
84	https://testing.object.pouta.csc.fi/OhjeistusoppimateriaalientallentamiseenSV2-1573635623864.odt	Ohjeistus_oppimateriaalien_tallentamiseen_SV2.odt	25485	application/vnd.oasis.opendocument.text	7bit	86	OhjeistusoppimateriaalientallentamiseenSV2-1573635623864.odt	testing	OhjeistusoppimateriaalientallentamiseenSV2-1573635623864.pdf
85	https://testing.object.pouta.csc.fi/OhjeistusoppimateriaalientallentamiseenSV2-1573639691181.odt	Ohjeistus_oppimateriaalien_tallentamiseen_SV2.odt	25485	application/vnd.oasis.opendocument.text	7bit	87	OhjeistusoppimateriaalientallentamiseenSV2-1573639691181.odt	testing	OhjeistusoppimateriaalientallentamiseenSV2-1573639691181.pdf
89	https://testing.object.pouta.csc.fi/Liite1Robotiikanoppimisenpolku-1573811440814.png	Liite 1 - Robotiikan oppimisen polku.png	204613	image/png	7bit	91	Liite1Robotiikanoppimisenpolku-1573811440814.png	testing	\N
94	https://testing.object.pouta.csc.fi/Liite1Robotiikanoppimisenpolkutekstisv-1573811442452.pdf	Liite 1 - Robotiikan oppimisen polku_teksti_sv.pdf	533496	application/pdf	7bit	96	Liite1Robotiikanoppimisenpolkutekstisv-1573811442452.pdf	testing	\N
87	https://testing.object.pouta.csc.fi/41EV3nohjelmointisimulaattorissa-1573811439555.pptx	4.1 EV3_n ohjelmointi simulaattorissa.pptx	4348623	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	89	41EV3nohjelmointisimulaattorissa-1573811439555.pptx	testing	41EV3nohjelmointisimulaattorissa-1573811439555.pdf
88	https://testing.object.pouta.csc.fi/42MicrobitinohjelmointiMakeCodessa-1573811440563.pptx	4.2 Micro_bitin ohjelmointi MakeCode_ssa.pptx	2395640	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	90	42MicrobitinohjelmointiMakeCodessa-1573811440563.pptx	testing	42MicrobitinohjelmointiMakeCodessa-1573811440563.pdf
90	https://testing.object.pouta.csc.fi/Liite2MicrobitKPS-1573811440835.docx	Liite 2_ Micro_bit KPS.docx	1145593	application/vnd.openxmlformats-officedocument.wordprocessingml.document	7bit	92	Liite2MicrobitKPS-1573811440835.docx	testing	Liite2MicrobitKPS-1573811440835.pdf
92	https://testing.object.pouta.csc.fi/41EV3nohjelmointisimulaattorissasv-1573811441865.pptx	4.1 EV3_n ohjelmointi simulaattorissa_sv.pptx	4150335	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	94	41EV3nohjelmointisimulaattorissasv-1573811441865.pptx	testing	41EV3nohjelmointisimulaattorissasv-1573811441865.pdf
93	https://testing.object.pouta.csc.fi/42MicrobitinohjelmointiMakeCodessasv-1573811442205.pptx	4.2 Micro_bitin ohjelmointi MakeCode_ssa_sv.pptx	2402716	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	95	42MicrobitinohjelmointiMakeCodessasv-1573811442205.pptx	testing	42MicrobitinohjelmointiMakeCodessasv-1573811442205.pdf
95	https://testing.object.pouta.csc.fi/Liite2MicrobitKPSsv-1573811442504.docx	Liite 2_ Micro_bit KPS sv.docx	1114054	application/vnd.openxmlformats-officedocument.wordprocessingml.document	7bit	97	Liite2MicrobitKPSsv-1573811442504.docx	testing	Liite2MicrobitKPSsv-1573811442504.pdf
96	object.pouta.csc.fi/testing/Introductiontoteachingrobotics-1573811442616.docx	Introduction to teaching robotics.docx	8225299	application/vnd.openxmlformats-officedocument.wordprocessingml.document	7bit	98	Introductiontoteachingrobotics-1573811442616.docx	testing	Introductiontoteachingrobotics-1573811442616.pdf
97	https://testing.object.pouta.csc.fi/41EV3programminginasimulator-1573811443463.pptx	4.1 EV3 programming in a simulator.pptx	4347961	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	99	41EV3programminginasimulator-1573811443463.pptx	testing	41EV3programminginasimulator-1573811443463.pdf
98	https://testing.object.pouta.csc.fi/42MicrobitprogramminginMakeCode-1573811443954.pptx	4.2 Micro_bit programming in MakeCode.pptx	2395561	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	100	42MicrobitprogramminginMakeCode-1573811443954.pptx	testing	42MicrobitprogramminginMakeCode-1573811443954.pdf
100	https://testing.object.pouta.csc.fi/Skrivappnalrresurser-1574077880958.pptx	Skriva öppna lärresurser.pptx	85364	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	102	Skrivappnalrresurser-1574077880958.pptx	testing	Skrivappnalrresurser-1574077880958.pdf
101	https://testing.object.pouta.csc.fi/2mitentuetaanopiskelijoidenyhteisollisyydenkehittymista2-1574247854363.pptx	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2.pptx	288552	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	103	2mitentuetaanopiskelijoidenyhteisollisyydenkehittymista2-1574247854363.pptx	testing	2mitentuetaanopiskelijoidenyhteisollisyydenkehittymista2-1574247854363.pdf
102	https://testing.object.pouta.csc.fi/1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1574247854344.pptx	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1.pptx	287378	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	104	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1574247854344.pptx	testing	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1574247854344.pdf
103	https://testing.object.pouta.csc.fi/5bKirjainaanneopiskelijalle-1574247854385.pptx	5 b Kirjain_äänne_opiskelijalle.pptx	1252520	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	105	5bKirjainaanneopiskelijalle-1574247854385.pptx	testing	5bKirjainaanneopiskelijalle-1574247854385.pdf
104	https://testing.object.pouta.csc.fi/1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1574248944953.pptx	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1.pptx	287378	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	106	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1574248944953.pptx	testing	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1574248944953.pdf
105	https://testing.object.pouta.csc.fi/5bKirjainaanneopiskelijalle-1574248944973.pptx	5 b Kirjain_äänne_opiskelijalle.pptx	1252520	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	107	5bKirjainaanneopiskelijalle-1574248944973.pptx	testing	5bKirjainaanneopiskelijalle-1574248944973.pdf
106	https://testing.object.pouta.csc.fi/6bPuheentuottoopiskelijalle-1574248945003.pptx	6b Puheentuotto_opiskelijalle.pptx	1290933	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	108	6bPuheentuottoopiskelijalle-1574248945003.pptx	testing	6bPuheentuottoopiskelijalle-1574248945003.pdf
108	https://testing.object.pouta.csc.fi/5bKirjainaanneopiskelijalle-1574250307068.pptx	5 b Kirjain_äänne_opiskelijalle.pptx	1252520	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	110	5bKirjainaanneopiskelijalle-1574250307068.pptx	testing	5bKirjainaanneopiskelijalle-1574250307068.pdf
109	https://testing.object.pouta.csc.fi/1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1574251129178.pptx	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1.pptx	287378	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	111	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1574251129178.pptx	testing	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1574251129178.pdf
115	https://testing.object.pouta.csc.fi/digialogorgb-1574418289414.png	digia_logo_rgb.png	60433	image/png	7bit	117	digialogorgb-1574418289414.png	testing	\N
117	object.pouta.csc.fi/testing/firobotiikka-1574418719000.zip	fi-robotiikka.zip	22192242	application/zip	7bit	119	firobotiikka-1574418719000.zip	testing	\N
118	object.pouta.csc.fi/testing/firobotiikka-1574418791647.zip	fi-robotiikka.zip	22192242	application/zip	7bit	120	firobotiikka-1574418791647.zip	testing	\N
120	object.pouta.csc.fi/testing/firobotiikka-1574419006632.zip	fi-robotiikka.zip	22192242	application/zip	7bit	122	firobotiikka-1574419006632.zip	testing	\N
122	object.pouta.csc.fi/testing/firobotiikka-1574419067817.zip	fi-robotiikka.zip	22192242	application/zip	7bit	124	firobotiikka-1574419067817.zip	testing	\N
123	object.pouta.csc.fi/testing/firobotiikka-1574419153418.zip	fi-robotiikka.zip	22192242	application/zip	7bit	125	firobotiikka-1574419153418.zip	testing	\N
126	https://testing.object.pouta.csc.fi/suurinsallittujohdonpituus236-1574424229989.h5p	suurin-sallittu-johdon-pituus-236.h5p	2524580	application/octet-stream	7bit	128	suurinsallittujohdonpituus236-1574424229989.h5p	testing	\N
130	object.pouta.csc.fi/testing/fi3digipedagogiikka-1574771013364.mp4	fi-3-digipedagogiikka.mp4	31795910	video/mp4	7bit	133	fi3digipedagogiikka-1574771013364.mp4	testing	\N
133	object.pouta.csc.fi/testing/fi3digipedagogiikka-1574839082509.mp4	fi-3-digipedagogiikka.mp4	31795910	video/mp4	7bit	136	fi3digipedagogiikka-1574839082509.mp4	testing	\N
135	object.pouta.csc.fi/testing/fi3digipedagogiikka-1574839176508.mp4	fi-3-digipedagogiikka.mp4	31795910	video/mp4	7bit	138	fi3digipedagogiikka-1574839176508.mp4	testing	\N
111	https://testing.object.pouta.csc.fi/5bKirjainaanneopiskelijalle-1574251277134.pptx	5 b Kirjain_äänne_opiskelijalle.pptx	1252520	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	113	5bKirjainaanneopiskelijalle-1574251277134.pptx	testing	5bKirjainaanneopiskelijalle-1574251277134.pdf
112	https://testing.object.pouta.csc.fi/6bPuheentuottoopiskelijalle-1574251277151.pptx	6b Puheentuotto_opiskelijalle.pptx	1290933	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	114	6bPuheentuottoopiskelijalle-1574251277151.pptx	testing	6bPuheentuottoopiskelijalle-1574251277151.pdf
113	https://testing.object.pouta.csc.fi/kayttoehdot-1574417904635.odt	käyttöehdot.odt	22851	application/vnd.oasis.opendocument.text	7bit	115	kayttoehdot-1574417904635.odt	testing	kayttoehdot-1574417904635.pdf
116	https://testing.object.pouta.csc.fi/OhjeistusoppimateriaalientallentamiseenSV2-1574418573288.odt	Ohjeistus_oppimateriaalien_tallentamiseen_SV2.odt	25485	application/vnd.oasis.opendocument.text	7bit	118	OhjeistusoppimateriaalientallentamiseenSV2-1574418573288.odt	testing	OhjeistusoppimateriaalientallentamiseenSV2-1574418573288.pdf
119	https://testing.object.pouta.csc.fi/OhjeistusoppimateriaalientallentamiseenSV2-1574419006626.odt	Ohjeistus_oppimateriaalien_tallentamiseen_SV2.odt	25485	application/vnd.oasis.opendocument.text	7bit	121	OhjeistusoppimateriaalientallentamiseenSV2-1574419006626.odt	testing	OhjeistusoppimateriaalientallentamiseenSV2-1574419006626.pdf
121	https://testing.object.pouta.csc.fi/OhjeistusoppimateriaalientallentamiseenSV2-1574419067808.odt	Ohjeistus_oppimateriaalien_tallentamiseen_SV2.odt	25485	application/vnd.oasis.opendocument.text	7bit	123	OhjeistusoppimateriaalientallentamiseenSV2-1574419067808.odt	testing	OhjeistusoppimateriaalientallentamiseenSV2-1574419067808.pdf
124	https://testing.object.pouta.csc.fi/Ninteetavoimiaoppimateriaaleja-1574421360473.pptx	Näin teet avoimia oppimateriaaleja.pptx	85367	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	126	Ninteetavoimiaoppimateriaaleja-1574421360473.pptx	testing	Ninteetavoimiaoppimateriaaleja-1574421360473.pdf
125	https://testing.object.pouta.csc.fi/Skrivappnalrresurser-1574421360492.pptx	Skriva öppna lärresurser.pptx	85364	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	127	Skrivappnalrresurser-1574421360492.pptx	testing	Skrivappnalrresurser-1574421360492.pdf
128	https://testing.object.pouta.csc.fi/1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1574766696257.pptx	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1.pptx	287378	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	130	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1574766696257.pptx	testing	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1574766696257.pdf
129	https://testing.object.pouta.csc.fi/5bKirjainaanneopiskelijalle-1574766696285.pptx	5 b Kirjain_äänne_opiskelijalle.pptx	1252520	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	131	5bKirjainaanneopiskelijalle-1574766696285.pptx	testing	5bKirjainaanneopiskelijalle-1574766696285.pdf
131	https://testing.object.pouta.csc.fi/5bKirjainaanneopiskelijalle-1574839082467.pptx	5 b Kirjain_äänne_opiskelijalle.pptx	1252520	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	134	5bKirjainaanneopiskelijalle-1574839082467.pptx	testing	5bKirjainaanneopiskelijalle-1574839082467.pdf
132	https://testing.object.pouta.csc.fi/6bPuheentuottoopiskelijalle-1574839082488.pptx	6b Puheentuotto_opiskelijalle.pptx	1290933	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	135	6bPuheentuottoopiskelijalle-1574839082488.pptx	testing	6bPuheentuottoopiskelijalle-1574839082488.pdf
134	https://testing.object.pouta.csc.fi/5bKirjainaanneopiskelijalle-1574839176530.pptx	5 b Kirjain_äänne_opiskelijalle.pptx	1252520	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	137	5bKirjainaanneopiskelijalle-1574839176530.pptx	testing	5bKirjainaanneopiskelijalle-1574839176530.pdf
137	https://testing.object.pouta.csc.fi/5bKirjainaanneopiskelijalle-1574845641258.pptx	5 b Kirjain_äänne_opiskelijalle.pptx	1252520	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	140	5bKirjainaanneopiskelijalle-1574845641258.pptx	testing	5bKirjainaanneopiskelijalle-1574845641258.pdf
161	https://testing.object.pouta.csc.fi/10arviointivirtuaaliluokassa-1574946976383.pptx	10_arviointi_virtuaaliluokassa.pptx	288251	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	185	10arviointivirtuaaliluokassa-1574946976383.pptx	testing	10arviointivirtuaaliluokassa-1574946976383.pdf
141	object.pouta.csc.fi/testing/fi3digipedagogiikka-1574846003034.mp4	fi-3-digipedagogiikka.mp4	31795910	video/mp4	7bit	144	fi3digipedagogiikka-1574846003034.mp4	testing	\N
140	https://testing.object.pouta.csc.fi/5bKirjainaanneopiskelijalle-1574846003012.pptx	5 b Kirjain_äänne_opiskelijalle.pptx	1252520	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	143	5bKirjainaanneopiskelijalle-1574846003012.pptx	testing	5bKirjainaanneopiskelijalle-1574846003012.pdf
142	https://testing.object.pouta.csc.fi/1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1574940157435.pptx	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1.pptx	287378	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	160	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1574940157435.pptx	testing	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1574940157435.pdf
143	https://testing.object.pouta.csc.fi/5bKirjainaanneopiskelijalle-1574940157452.pptx	5 b Kirjain_äänne_opiskelijalle.pptx	1252520	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	161	5bKirjainaanneopiskelijalle-1574940157452.pptx	testing	5bKirjainaanneopiskelijalle-1574940157452.pdf
144	https://testing.object.pouta.csc.fi/5kirjainnneopettajalle-1574942801842.pptx	5_kirjain_äänne_opettajalle.pptx	282943	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	163	5kirjainnneopettajalle-1574942801842.pptx	testing	5kirjainnneopettajalle-1574942801842.pdf
145	https://testing.object.pouta.csc.fi/5kirjainnneopettajalle-1574943163546.pptx	5_kirjain_äänne_opettajalle.pptx	282943	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	166	5kirjainnneopettajalle-1574943163546.pptx	testing	5kirjainnneopettajalle-1574943163546.pdf
146	https://testing.object.pouta.csc.fi/5kirjainnneopettajalle-1574943163902.pptx	5_kirjain_äänne_opettajalle.pptx	282943	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	167	5kirjainnneopettajalle-1574943163902.pptx	testing	5kirjainnneopettajalle-1574943163902.pdf
147	https://testing.object.pouta.csc.fi/1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1574943536303.pptx	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1.pptx	287378	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	170	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1574943536303.pptx	testing	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1574943536303.pdf
148	https://testing.object.pouta.csc.fi/Skrivappnalrresurser-1574944097740.pptx	Skriva öppna lärresurser.pptx	85364	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	171	Skrivappnalrresurser-1574944097740.pptx	testing	Skrivappnalrresurser-1574944097740.pdf
150	https://testing.object.pouta.csc.fi/6bPuheentuottoopiskelijalle-1574946130168.pptx	6b Puheentuotto_opiskelijalle.pptx	1290933	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	174	6bPuheentuottoopiskelijalle-1574946130168.pptx	testing	6bPuheentuottoopiskelijalle-1574946130168.pdf
151	https://testing.object.pouta.csc.fi/1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1574946302547.pptx	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1.pptx	287378	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	175	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1574946302547.pptx	testing	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1574946302547.pdf
152	https://testing.object.pouta.csc.fi/2mitentuetaanopiskelijoidenyhteisollisyydenkehittymista2-1574946381270.pptx	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2.pptx	288552	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	176	2mitentuetaanopiskelijoidenyhteisollisyydenkehittymista2-1574946381270.pptx	testing	2mitentuetaanopiskelijoidenyhteisollisyydenkehittymista2-1574946381270.pdf
153	https://testing.object.pouta.csc.fi/1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1574946381251.pptx	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1.pptx	287378	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	177	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1574946381251.pptx	testing	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1574946381251.pdf
154	https://testing.object.pouta.csc.fi/2mitentuetaanopiskelijoidenyhteisollisyydenkehittymista2-1574946419144.pptx	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2.pptx	288552	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	178	2mitentuetaanopiskelijoidenyhteisollisyydenkehittymista2-1574946419144.pptx	testing	2mitentuetaanopiskelijoidenyhteisollisyydenkehittymista2-1574946419144.pdf
156	https://testing.object.pouta.csc.fi/2mitentuetaanopiskelijoidenyhteisollisyydenkehittymista2-1574946516378.pptx	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2.pptx	288552	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	181	2mitentuetaanopiskelijoidenyhteisollisyydenkehittymista2-1574946516378.pptx	testing	2mitentuetaanopiskelijoidenyhteisollisyydenkehittymista2-1574946516378.pdf
157	https://testing.object.pouta.csc.fi/1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1574946516290.pptx	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1.pptx	287378	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	180	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1574946516290.pptx	testing	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1574946516290.pdf
158	https://testing.object.pouta.csc.fi/5kirjainaanneopettajalle-1574946569922.pptx	5_kirjain_äänne_opettajalle.pptx	282943	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	182	5kirjainaanneopettajalle-1574946569922.pptx	testing	5kirjainaanneopettajalle-1574946569922.pdf
159	https://testing.object.pouta.csc.fi/5bKirjainaanneopiskelijalle-1574946569851.pptx	5 b Kirjain_äänne_opiskelijalle.pptx	1252520	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	183	5bKirjainaanneopiskelijalle-1574946569851.pptx	testing	5bKirjainaanneopiskelijalle-1574946569851.pdf
160	https://testing.object.pouta.csc.fi/7mitenopetetaanopiskelijoitaetsimaanverkossa-1574946952446.pptx	7_miten_opetetaan_opiskelijoita_etsimään_verkossa.pptx	283331	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	184	7mitenopetetaanopiskelijoitaetsimaanverkossa-1574946952446.pptx	testing	7mitenopetetaanopiskelijoitaetsimaanverkossa-1574946952446.pdf
168	https://testing.object.pouta.csc.fi/testikuva-1575983904471.png	testikuva.png	11760	image/png	7bit	194	testikuva-1575983904471.png	testing	\N
171	https://testing.object.pouta.csc.fi/AInfotauluOpetuksendigitaalisetvalineet-1575986164536.pdf	A Infotaulu Opetuksen digitaaliset välineet.pdf	329645	application/pdf	7bit	197	AInfotauluOpetuksendigitaalisetvalineet-1575986164536.pdf	testing	\N
172	https://testing.object.pouta.csc.fi/bInfotauluOpiskelundigivalineet-1575986164690.pdf	b Infotaulu Opiskelun digivälineet.pdf	329242	application/pdf	7bit	198	bInfotauluOpiskelundigivalineet-1575986164690.pdf	testing	\N
173	https://testing.object.pouta.csc.fi/AInfografDigitaltoolsforteaching-1575986164724.pdf	A Infograf Digital tools for teaching.pdf	337357	application/pdf	7bit	199	AInfografDigitaltoolsforteaching-1575986164724.pdf	testing	\N
174	https://testing.object.pouta.csc.fi/bInfografDigitaltoolsforstudying-1575986164731.pdf	b Infograf Digital tools for studying.pdf	340535	application/pdf	7bit	200	bInfografDigitaltoolsforstudying-1575986164731.pdf	testing	\N
175	https://testing.object.pouta.csc.fi/InfografDigitalaverktygforstudier-1575986164820.pdf	Infograf Digitala verktyg för studier.pdf	325255	application/pdf	7bit	202	InfografDigitalaverktygforstudier-1575986164820.pdf	testing	\N
176	https://testing.object.pouta.csc.fi/InfografDigitalaverktygforundervisningen-1575986164783.pdf	Infograf Digitala verktyg för undervisningen.pdf	324378	application/pdf	7bit	201	InfografDigitalaverktygforundervisningen-1575986164783.pdf	testing	\N
179	object.pouta.csc.fi/testing/fi3digipedagogiikka-1576146717338.mp4	fi-3-digipedagogiikka.mp4	31795910	video/mp4	7bit	206	fi3digipedagogiikka-1576146717338.mp4	testing	\N
181	https://testing.object.pouta.csc.fi/testpdfmroppone-1576147880467.pdf	test-pdf-mroppone.pdf	183623	application/pdf	7bit	208	testpdfmroppone-1576147880467.pdf	testing	\N
183	https://testing.object.pouta.csc.fi/testpdfmroppone-1576148325967.pdf	test-pdf-mroppone.pdf	183623	application/pdf	7bit	210	testpdfmroppone-1576148325967.pdf	testing	\N
184	https://testing.object.pouta.csc.fi/testpdfmroppone-1576149400678.pdf	test-pdf-mroppone.pdf	183623	application/pdf	7bit	211	testpdfmroppone-1576149400678.pdf	testing	\N
185	https://testing.object.pouta.csc.fi/testpdfmroppone-1576149748930.pdf	test-pdf-mroppone.pdf	183623	application/pdf	7bit	212	testpdfmroppone-1576149748930.pdf	testing	\N
187	https://testing.object.pouta.csc.fi/testpdfmroppone-1576149776731.pdf	test-pdf-mroppone.pdf	183623	application/pdf	7bit	214	testpdfmroppone-1576149776731.pdf	testing	\N
189	https://testing.object.pouta.csc.fi/testpdfmroppone-1576149845873.pdf	test-pdf-mroppone.pdf	183623	application/pdf	7bit	216	testpdfmroppone-1576149845873.pdf	testing	\N
163	https://testing.object.pouta.csc.fi/15tekijanoikeudetvirtuaaliluokassamitenohjaanopiskelijoita-1574947136995.pptx	15_tekijänoikeudet_virtuaaliluokassa_miten_ohjaan_opiskelijoita.pptx	290304	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	187	15tekijanoikeudetvirtuaaliluokassamitenohjaanopiskelijoita-1574947136995.pptx	testing	15tekijanoikeudetvirtuaaliluokassamitenohjaanopiskelijoita-1574947136995.pdf
164	https://testing.object.pouta.csc.fi/6puheentuottoopettajalle-1574948087292.pptx	6_puheentuotto_opettajalle.pptx	280356	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	188	6puheentuottoopettajalle-1574948087292.pptx	testing	6puheentuottoopettajalle-1574948087292.pdf
165	https://testing.object.pouta.csc.fi/Kuinkatehdavoimiaoppimateriaaleja-1575285174432.pptx	Kuinka tehdä avoimia oppimateriaaleja.pptx	85367	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	189	Kuinkatehdavoimiaoppimateriaaleja-1575285174432.pptx	testing	Kuinkatehdavoimiaoppimateriaaleja-1575285174432.pdf
166	https://testing.object.pouta.csc.fi/Skrivappnalrresurser-1575285174454.pptx	Skriva öppna lärresurser.pptx	85364	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	190	Skrivappnalrresurser-1575285174454.pptx	testing	Skrivappnalrresurser-1575285174454.pdf
169	https://testing.object.pouta.csc.fi/2mitentuetaanopiskelijoidenyhteisollisyydenkehittymista2-1575985841775.pptx	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2.pptx	288552	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	196	2mitentuetaanopiskelijoidenyhteisollisyydenkehittymista2-1575985841775.pptx	testing	2mitentuetaanopiskelijoidenyhteisollisyydenkehittymista2-1575985841775.pdf
170	https://testing.object.pouta.csc.fi/1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1575985841697.pptx	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1.pptx	287378	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	195	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1575985841697.pptx	testing	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1575985841697.pdf
177	https://testing.object.pouta.csc.fi/Ninteetavoimiaoppimateriaaleja-1576146514450.pptx	Näin teet avoimia oppimateriaaleja.pptx	85367	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	203	Ninteetavoimiaoppimateriaaleja-1576146514450.pptx	testing	Ninteetavoimiaoppimateriaaleja-1576146514450.pdf
178	https://testing.object.pouta.csc.fi/Skrivappnalrresurser-1576146514533.pptx	Skriva öppna lärresurser.pptx	85364	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	204	Skrivappnalrresurser-1576146514533.pptx	testing	Skrivappnalrresurser-1576146514533.pdf
180	https://testing.object.pouta.csc.fi/testdocxmroppone-1576147880503.docx	test-docx-mroppone.docx	11533	application/vnd.openxmlformats-officedocument.wordprocessingml.document	7bit	207	testdocxmroppone-1576147880503.docx	testing	testdocxmroppone-1576147880503.pdf
182	https://testing.object.pouta.csc.fi/Ninteetavoimiaoppimateriaaleja-1576148205221.pptx	Näin teet avoimia oppimateriaaleja.pptx	85367	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	209	Ninteetavoimiaoppimateriaaleja-1576148205221.pptx	testing	Ninteetavoimiaoppimateriaaleja-1576148205221.pdf
186	https://testing.object.pouta.csc.fi/testdocxmroppone-1576149776720.docx	test-docx-mroppone.docx	11533	application/vnd.openxmlformats-officedocument.wordprocessingml.document	7bit	213	testdocxmroppone-1576149776720.docx	testing	testdocxmroppone-1576149776720.pdf
188	https://testing.object.pouta.csc.fi/testdocxmroppone-1576149845863.docx	test-docx-mroppone.docx	11533	application/vnd.openxmlformats-officedocument.wordprocessingml.document	7bit	215	testdocxmroppone-1576149845863.docx	testing	testdocxmroppone-1576149845863.pdf
191	https://testing.object.pouta.csc.fi/testpdfmroppone-1576150203321.pdf	test-pdf-mroppone.pdf	183623	application/pdf	7bit	218	testpdfmroppone-1576150203321.pdf	testing	\N
192	https://testing.object.pouta.csc.fi/testpdfmroppone-1576150255277.pdf	test-pdf-mroppone.pdf	183623	application/pdf	7bit	219	testpdfmroppone-1576150255277.pdf	testing	\N
194	https://testing.object.pouta.csc.fi/testpdfmroppone-1576150421687.pdf	test-pdf-mroppone.pdf	183623	application/pdf	7bit	221	testpdfmroppone-1576150421687.pdf	testing	\N
197	https://testing.object.pouta.csc.fi/testpdfmroppone-1576151699466.pdf	test-pdf-mroppone.pdf	183623	application/pdf	7bit	224	testpdfmroppone-1576151699466.pdf	testing	\N
199	https://testing.object.pouta.csc.fi/testpdfmroppone-1576154500391.pdf	test-pdf-mroppone.pdf	183623	application/pdf	7bit	226	testpdfmroppone-1576154500391.pdf	testing	\N
202	https://testing.object.pouta.csc.fi/testpdfmroppone-1576158631450.pdf	test-pdf-mroppone.pdf	183623	application/pdf	7bit	229	testpdfmroppone-1576158631450.pdf	testing	\N
203	https://testing.object.pouta.csc.fi/testpdfmroppone-1576158708872.pdf	test-pdf-mroppone.pdf	183623	application/pdf	7bit	230	testpdfmroppone-1576158708872.pdf	testing	\N
206	https://testing.object.pouta.csc.fi/testpdfmroppone-1576160674937.pdf	test-pdf-mroppone.pdf	183623	application/pdf	7bit	233	testpdfmroppone-1576160674937.pdf	testing	\N
207	https://testing.object.pouta.csc.fi/digialogorgb-1576228405590.png	digia_logo_rgb.png	60433	image/png	7bit	234	digialogorgb-1576228405590.png	testing	\N
210	https://testing.object.pouta.csc.fi/Linkedinmetsa2-1576493787116.jpg	Linkedin_metsa2.jpg	483270	image/jpeg	7bit	237	Linkedinmetsa2-1576493787116.jpg	testing	\N
211	object.pouta.csc.fi/testing/fi3digipedagogiikka-1576493787097.mp4	fi-3-digipedagogiikka.mp4	31795910	video/mp4	7bit	238	fi3digipedagogiikka-1576493787097.mp4	testing	\N
215	https://testing.object.pouta.csc.fi/1-1576496981729.jpg	1.jpg	89996	image/jpeg	7bit	242	1-1576496981729.jpg	testing	\N
216	https://testing.object.pouta.csc.fi/Linkedinmetsa2-1576496981651.jpg	Linkedin_metsa2.jpg	483270	image/jpeg	7bit	243	Linkedinmetsa2-1576496981651.jpg	testing	\N
217	https://testing.object.pouta.csc.fi/kokeiluvideo-1576569265272.mp4	kokeiluvideo.mp4	755107	video/mp4	7bit	246	kokeiluvideo-1576569265272.mp4	testing	\N
195	https://testing.object.pouta.csc.fi/5bKirjainaanneopiskelijalle-1576151586959.pptx	5 b Kirjain_äänne_opiskelijalle.pptx	1252520	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	222	5bKirjainaanneopiskelijalle-1576151586959.pptx	testing	5bKirjainaanneopiskelijalle-1576151586959.pdf
196	https://testing.object.pouta.csc.fi/testdocxmroppone-1576151699518.docx	test-docx-mroppone.docx	11533	application/vnd.openxmlformats-officedocument.wordprocessingml.document	7bit	223	testdocxmroppone-1576151699518.docx	testing	testdocxmroppone-1576151699518.pdf
198	https://testing.object.pouta.csc.fi/Ninteetavoimiaoppimateriaaleja-1576151787905.pptx	Näin teet avoimia oppimateriaaleja.pptx	85367	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	225	Ninteetavoimiaoppimateriaaleja-1576151787905.pptx	testing	Ninteetavoimiaoppimateriaaleja-1576151787905.pdf
200	https://testing.object.pouta.csc.fi/1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1576155358419.pptx	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1.pptx	287378	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	227	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1576155358419.pptx	testing	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1576155358419.pdf
201	https://testing.object.pouta.csc.fi/1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1576158566172.pptx	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1.pptx	287378	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	228	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1576158566172.pptx	testing	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1576158566172.pdf
204	https://testing.object.pouta.csc.fi/testdocxmroppone-1576158724672.docx	test-docx-mroppone.docx	11533	application/vnd.openxmlformats-officedocument.wordprocessingml.document	7bit	231	testdocxmroppone-1576158724672.docx	testing	testdocxmroppone-1576158724672.pdf
208	https://testing.object.pouta.csc.fi/Ninteetavoimiaoppimateriaaleja-1576234380120.pptx	Näin teet avoimia oppimateriaaleja.pptx	85367	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	235	Ninteetavoimiaoppimateriaaleja-1576234380120.pptx	testing	Ninteetavoimiaoppimateriaaleja-1576234380120.pdf
209	https://testing.object.pouta.csc.fi/1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1576493787001.pptx	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1.pptx	287378	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	236	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1576493787001.pptx	testing	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1576493787001.pdf
212	https://testing.object.pouta.csc.fi/2mitentuetaanopiskelijoidenyhteisollisyydenkehittymista2-1576493903882.pptx	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2.pptx	288552	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	239	2mitentuetaanopiskelijoidenyhteisollisyydenkehittymista2-1576493903882.pptx	testing	2mitentuetaanopiskelijoidenyhteisollisyydenkehittymista2-1576493903882.pdf
213	https://testing.object.pouta.csc.fi/1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1576493903785.pptx	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1.pptx	287378	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	240	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1576493903785.pptx	testing	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1576493903785.pdf
214	https://testing.object.pouta.csc.fi/5bKirjainaanneopiskelijalle-1576493903902.pptx	5 b Kirjain_äänne_opiskelijalle.pptx	1252520	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	241	5bKirjainaanneopiskelijalle-1576493903902.pptx	testing	5bKirjainaanneopiskelijalle-1576493903902.pdf
218	https://testing.object.pouta.csc.fi/Ninteetavoimiaoppimateriaaleja-1576569265301.pptx	Näin teet avoimia oppimateriaaleja.pptx	85367	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	245	Ninteetavoimiaoppimateriaaleja-1576569265301.pptx	testing	Ninteetavoimiaoppimateriaaleja-1576569265301.pdf
219	https://testing.object.pouta.csc.fi/and-1576572810096.png	Α α, Β β, Γ γ, Δ δ, Ε ε, Ζ ζ, Η η, Θ θ, Ι ι, Κ κ, Λ λ, Μ μ, Ν ν, Ξ ξ, Ο ο, Π π, Ρ ρ, Σ σ:ς, Τ τ, Υ υ, Φ φ, Χ χ, Ψ ψ, and Ω ω.png	11760	image/png	7bit	247	and-1576572810096.png	testing	\N
220	https://testing.object.pouta.csc.fi/testikuva-1576573097025.png	testikuva.png	11760	image/png	7bit	248	testikuva-1576573097025.png	testing	\N
226	https://testing.object.pouta.csc.fi/testikuva-1576578072260.png	testikuva.png	11760	image/png	7bit	254	testikuva-1576578072260.png	testing	\N
236	https://testing.object.pouta.csc.fi/1-1576676452026.jpg	1.jpg	89996	image/jpeg	7bit	264	1-1576676452026.jpg	testing	\N
240	object.pouta.csc.fi/testing/fi3digipedagogiikka-1576676588871.mp4	fi-3-digipedagogiikka.mp4	31795910	video/mp4	7bit	268	fi3digipedagogiikka-1576676588871.mp4	testing	\N
222	https://testing.object.pouta.csc.fi/2mitentuetaanopiskelijoidenyhteisollisyydenkehittymista2-1576576742905.pptx	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2.pptx	288552	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	251	2mitentuetaanopiskelijoidenyhteisollisyydenkehittymista2-1576576742905.pptx	testing	2mitentuetaanopiskelijoidenyhteisollisyydenkehittymista2-1576576742905.pdf
223	https://testing.object.pouta.csc.fi/6puheentuottoopettajalle-1576576742924.pptx	6_puheentuotto_opettajalle.pptx	280356	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	250	6puheentuottoopettajalle-1576576742924.pptx	testing	6puheentuottoopettajalle-1576576742924.pdf
225	https://testing.object.pouta.csc.fi/14tekijanoikeudetvirtuaaliluokassaopettajanoikeudet-1576576743014.pptx	14_tekijänoikeudet_virtuaaliluokassa_opettajan_oikeudet.pptx	287192	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	253	14tekijanoikeudetvirtuaaliluokassaopettajanoikeudet-1576576743014.pptx	testing	14tekijanoikeudetvirtuaaliluokassaopettajanoikeudet-1576576743014.pdf
227	https://testing.object.pouta.csc.fi/Ninteetavoimiaoppimateriaaleja-1576581274416.pptx	Näin teet avoimia oppimateriaaleja.pptx	85367	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	255	Ninteetavoimiaoppimateriaaleja-1576581274416.pptx	testing	Ninteetavoimiaoppimateriaaleja-1576581274416.pdf
228	https://testing.object.pouta.csc.fi/Skrivappnalrresurser-1576581274431.pptx	Skriva öppna lärresurser.pptx	85364	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	256	Skrivappnalrresurser-1576581274431.pptx	testing	Skrivappnalrresurser-1576581274431.pdf
229	https://testing.object.pouta.csc.fi/Skrivappnalrresurser-1576649779074.pptx	Skriva öppna lärresurser.pptx	85364	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	257	Skrivappnalrresurser-1576649779074.pptx	testing	Skrivappnalrresurser-1576649779074.pdf
230	https://testing.object.pouta.csc.fi/1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1576658705779.pptx	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1.pptx	287378	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	258	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1576658705779.pptx	testing	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1576658705779.pdf
231	https://testing.object.pouta.csc.fi/6puheentuottoopettajalle-1576658705988.pptx	6_puheentuotto_opettajalle.pptx	280356	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	260	6puheentuottoopettajalle-1576658705988.pptx	testing	6puheentuottoopettajalle-1576658705988.pdf
232	https://testing.object.pouta.csc.fi/10arviointivirtuaaliluokassa-1576658706030.pptx	10_arviointi_virtuaaliluokassa.pptx	288251	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	259	10arviointivirtuaaliluokassa-1576658706030.pptx	testing	10arviointivirtuaaliluokassa-1576658706030.pdf
234	https://testing.object.pouta.csc.fi/15tekijanoikeudetvirtuaaliluokassamitenohjaanopiskelijoita-1576658706047.pptx	15_tekijänoikeudet_virtuaaliluokassa_miten_ohjaan_opiskelijoita.pptx	290304	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	262	15tekijanoikeudetvirtuaaliluokassamitenohjaanopiskelijoita-1576658706047.pptx	testing	15tekijanoikeudetvirtuaaliluokassamitenohjaanopiskelijoita-1576658706047.pdf
235	https://testing.object.pouta.csc.fi/2mitentuetaanopiskelijoidenyhteisollisyydenkehittymista2-1576658705901.pptx	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2.pptx	288552	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	263	2mitentuetaanopiskelijoidenyhteisollisyydenkehittymista2-1576658705901.pptx	testing	2mitentuetaanopiskelijoidenyhteisollisyydenkehittymista2-1576658705901.pdf
237	https://testing.object.pouta.csc.fi/10arviointivirtuaaliluokassa-1576676452006.pptx	10_arviointi_virtuaaliluokassa.pptx	288251	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	265	10arviointivirtuaaliluokassa-1576676452006.pptx	testing	10arviointivirtuaaliluokassa-1576676452006.pdf
238	https://testing.object.pouta.csc.fi/5bKirjainaanneopiskelijalle-1576676451993.pptx	5 b Kirjain_äänne_opiskelijalle.pptx	1252520	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	266	5bKirjainaanneopiskelijalle-1576676451993.pptx	testing	5bKirjainaanneopiskelijalle-1576676451993.pdf
239	https://testing.object.pouta.csc.fi/7mitenopetetaanopiskelijoitaetsimaanverkossa-1576676589032.pptx	7_miten_opetetaan_opiskelijoita_etsimään_verkossa.pptx	283331	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	267	7mitenopetetaanopiskelijoitaetsimaanverkossa-1576676589032.pptx	testing	7mitenopetetaanopiskelijoitaetsimaanverkossa-1576676589032.pdf
241	https://testing.object.pouta.csc.fi/1Yleiskatsausautomaatioonjarobotiikkaan-1576737754558.docx	1. Yleiskatsaus automaatioon ja robotiikkaan.docx	3921959	application/vnd.openxmlformats-officedocument.wordprocessingml.document	7bit	303	1Yleiskatsausautomaatioonjarobotiikkaan-1576737754558.docx	testing	1Yleiskatsausautomaatioonjarobotiikkaan-1576737754558.pdf
243	https://testing.object.pouta.csc.fi/2Robotiikkayhteiskunnassa-1576737754591.docx	2. Robotiikka yhteiskunnassa.docx	3402647	application/vnd.openxmlformats-officedocument.wordprocessingml.document	7bit	305	2Robotiikkayhteiskunnassa-1576737754591.docx	testing	2Robotiikkayhteiskunnassa-1576737754591.pdf
245	https://testing.object.pouta.csc.fi/testpdfmroppone-1576743759456.pdf	test-pdf-mroppone.pdf	183623	application/pdf	7bit	309	testpdfmroppone-1576743759456.pdf	testing	\N
247	https://testing.object.pouta.csc.fi/testpdfmroppone-1576753569869.pdf	test-pdf-mroppone.pdf	183623	application/pdf	7bit	311	testpdfmroppone-1576753569869.pdf	testing	\N
248	https://testing.object.pouta.csc.fi/testpdfmroppone-1576754915659.pdf	test-pdf-mroppone.pdf	183623	application/pdf	7bit	313	testpdfmroppone-1576754915659.pdf	testing	\N
250	https://testing.object.pouta.csc.fi/testpdfmroppone-1576757576485.pdf	test-pdf-mroppone.pdf	183623	application/pdf	7bit	317	testpdfmroppone-1576757576485.pdf	testing	\N
255	https://testing.object.pouta.csc.fi/testikuva-1577970299773.png	testikuva.png	11760	image/png	7bit	322	testikuva-1577970299773.png	testing	\N
256	object.pouta.csc.fi/testing/fi3digipedagogiikka-1578486272619.mp4	fi-3-digipedagogiikka.mp4	31795910	video/mp4	7bit	323	fi3digipedagogiikka-1578486272619.mp4	testing	\N
257	https://testing.object.pouta.csc.fi/Screenshotfrom20191212074956-1578488552637.png	Screenshot from 2019-12-12 07-49-56.png	81993	image/png	7bit	324	Screenshotfrom20191212074956-1578488552637.png	testing	\N
258	https://testing.object.pouta.csc.fi/Screenshotfrom20191212074956-1578644118513.png	Screenshot from 2019-12-12 07-49-56.png	81993	image/png	7bit	325	Screenshotfrom20191212074956-1578644118513.png	testing	\N
259	object.pouta.csc.fi/testing/ohjeet-1578654236459.mp4	ohjeet.mp4	17496902	video/mp4	7bit	326	ohjeet-1578654236459.mp4	testing	\N
260	object.pouta.csc.fi/testing/lahioikeudet-1578655080667.mp4	lahioikeudet.mp4	21865195	video/mp4	7bit	327	lahioikeudet-1578655080667.mp4	testing	\N
261	https://testing.object.pouta.csc.fi/del1-1578657126259.png	del1.png	2193717	image/png	7bit	328	del1-1578657126259.png	testing	\N
262	object.pouta.csc.fi/testing/ohjeet-1579001207278.mp4	ohjeet.mp4	17496902	video/mp4	7bit	329	ohjeet-1579001207278.mp4	testing	\N
263	https://testing.object.pouta.csc.fi/Screenshotfrom20191212074956-1579002327504.png	Screenshot from 2019-12-12 07-49-56.png	81993	image/png	7bit	330	Screenshotfrom20191212074956-1579002327504.png	testing	\N
264	object.pouta.csc.fi/testing/ohjeet-1579008771427.mp4	ohjeet.mp4	17496902	video/mp4	7bit	331	ohjeet-1579008771427.mp4	testing	\N
265	object.pouta.csc.fi/testing/lahioikeudet-1579008922412.mp4	lahioikeudet.mp4	21865195	video/mp4	7bit	332	lahioikeudet-1579008922412.mp4	testing	\N
266	object.pouta.csc.fi/testing/sitaatit-1579009004908.mp4	sitaatit.mp4	21815495	video/mp4	7bit	333	sitaatit-1579009004908.mp4	testing	\N
267	object.pouta.csc.fi/testing/lahioikeudet-1579070993974.mp4	lahioikeudet.mp4	21865195	video/mp4	7bit	334	lahioikeudet-1579070993974.mp4	testing	\N
268	https://testing.object.pouta.csc.fi/Copyrightsineducation-1579080048307.pdf	Copyrights in education.pdf	4953520	application/pdf	7bit	335	Copyrightsineducation-1579080048307.pdf	testing	\N
270	object.pouta.csc.fi/testing/lahioikeudet-1579159870244.mp4	lahioikeudet.mp4	21865195	video/mp4	7bit	337	lahioikeudet-1579159870244.mp4	testing	\N
271	object.pouta.csc.fi/testing/ohjeet-1579160695249.mp4	ohjeet.mp4	17496902	video/mp4	7bit	338	ohjeet-1579160695249.mp4	testing	\N
272	object.pouta.csc.fi/testing/lahioikeudet-1579168830851.mp4	lahioikeudet.mp4	21865195	video/mp4	7bit	339	lahioikeudet-1579168830851.mp4	testing	\N
273	object.pouta.csc.fi/testing/avoinjulkaiseminen-1579169119426.mp4	avoinjulkaiseminen.mp4	220988631	video/mp4	7bit	340	avoinjulkaiseminen-1579169119426.mp4	testing	\N
274	https://testing.object.pouta.csc.fi/Tekijnoikeudetopetuksessa-1579170186947.pdf	Tekijnoikeudet opetuksessa.pdf	3893002	application/pdf	7bit	341	Tekijnoikeudetopetuksessa-1579170186947.pdf	testing	\N
275	object.pouta.csc.fi/testing/avoinjulkaiseminen-1579170186936.mp4	avoinjulkaiseminen.mp4	220988631	video/mp4	7bit	342	avoinjulkaiseminen-1579170186936.mp4	testing	\N
276	https://testing.object.pouta.csc.fi/Tekijnoikeudetopetuksessa-1579173481885.pdf	Tekijnoikeudet opetuksessa.pdf	3893002	application/pdf	7bit	343	Tekijnoikeudetopetuksessa-1579173481885.pdf	testing	\N
277	https://testing.object.pouta.csc.fi/Upphovsrtteniundervisningen-1579173481876.pdf	Upphovsrtten i undervisningen.pdf	5010623	application/pdf	7bit	344	Upphovsrtteniundervisningen-1579173481876.pdf	testing	\N
278	object.pouta.csc.fi/testing/avoinjulkaiseminen-1579173481859.mp4	avoinjulkaiseminen.mp4	220988631	video/mp4	7bit	345	avoinjulkaiseminen-1579173481859.mp4	testing	\N
279	object.pouta.csc.fi/testing/lahioikeudet-1579181029715.mp4	lahioikeudet.mp4	21865195	video/mp4	7bit	347	lahioikeudet-1579181029715.mp4	testing	\N
280	object.pouta.csc.fi/testing/ohjeet-1579181029874.mp4	ohjeet.mp4	17496902	video/mp4	7bit	346	ohjeet-1579181029874.mp4	testing	\N
249	https://testing.object.pouta.csc.fi/testdocxmroppone-1576754915668.docx	test-docx-mroppone.docx	11533	application/vnd.openxmlformats-officedocument.wordprocessingml.document	7bit	312	testdocxmroppone-1576754915668.docx	testing	testdocxmroppone-1576754915668.pdf
252	https://testing.object.pouta.csc.fi/1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1576834856824.pptx	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1.pptx	287378	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	318	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1576834856824.pptx	testing	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1576834856824.pdf
253	https://testing.object.pouta.csc.fi/2mitentuetaanopiskelijoidenyhteisollisyydenkehittymista2-1576842858413.pptx	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2.pptx	288552	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	319	2mitentuetaanopiskelijoidenyhteisollisyydenkehittymista2-1576842858413.pptx	testing	2mitentuetaanopiskelijoidenyhteisollisyydenkehittymista2-1576842858413.pdf
269	object.pouta.csc.fi/testing/Copyrightsineducation-1579085112222.odp	Copyrights in education.odp	12846653	application/vnd.oasis.opendocument.presentation	7bit	336	Copyrightsineducation-1579085112222.odp	testing	Copyrightsineducation-1579085112222.pdf
281	object.pouta.csc.fi/testing/sitaatit-1579182808437.mp4	sitaatit.mp4	21815495	video/mp4	7bit	348	sitaatit-1579182808437.mp4	testing	\N
282	object.pouta.csc.fi/testing/lahioikeudet-1579245172170.mp4	lahioikeudet.mp4	21865195	video/mp4	7bit	349	lahioikeudet-1579245172170.mp4	testing	\N
283	object.pouta.csc.fi/testing/fi3digipedagogiikka-1579245707327.mp4	fi-3-digipedagogiikka.mp4	31795910	video/mp4	7bit	350	fi3digipedagogiikka-1579245707327.mp4	testing	\N
284	object.pouta.csc.fi/testing/avoinjulkaiseminen-1579246917812.mp4	avoinjulkaiseminen.mp4	220988631	video/mp4	7bit	351	avoinjulkaiseminen-1579246917812.mp4	testing	\N
285	object.pouta.csc.fi/testing/fi3digipedagogiikka-1579254944637.mp4	fi-3-digipedagogiikka.mp4	31795910	video/mp4	7bit	352	fi3digipedagogiikka-1579254944637.mp4	testing	\N
286	object.pouta.csc.fi/testing/fi3digipedagogiikka-1579255059718.mp4	fi-3-digipedagogiikka.mp4	31795910	video/mp4	7bit	353	fi3digipedagogiikka-1579255059718.mp4	testing	\N
287	object.pouta.csc.fi/testing/avoinjulkaiseminen-1579256564329.mp4	avoinjulkaiseminen.mp4	220988631	video/mp4	7bit	354	avoinjulkaiseminen-1579256564329.mp4	testing	\N
288	object.pouta.csc.fi/testing/avoinjulkaiseminen-1579256722085.mp4	avoinjulkaiseminen.mp4	220988631	video/mp4	7bit	355	avoinjulkaiseminen-1579256722085.mp4	testing	\N
289	object.pouta.csc.fi/testing/avoinjulkaiseminen-1579256761377.mp4	avoinjulkaiseminen.mp4	220988631	video/mp4	7bit	356	avoinjulkaiseminen-1579256761377.mp4	testing	\N
290	object.pouta.csc.fi/testing/avoinjulkaiseminen-1579256874830.mp4	avoinjulkaiseminen.mp4	220988631	video/mp4	7bit	357	avoinjulkaiseminen-1579256874830.mp4	testing	\N
291	https://testing.object.pouta.csc.fi/Upphovsrtteniundervisningen-1579257150995.pdf	Upphovsrtten i undervisningen.pdf	5010623	application/pdf	7bit	358	Upphovsrtteniundervisningen-1579257150995.pdf	testing	\N
292	object.pouta.csc.fi/testing/avoinjulkaiseminen-1579257150959.mp4	avoinjulkaiseminen.mp4	220988631	video/mp4	7bit	359	avoinjulkaiseminen-1579257150959.mp4	testing	\N
293	object.pouta.csc.fi/testing/fi3digipedagogiikka-1579257387722.mp4	fi-3-digipedagogiikka.mp4	31795910	video/mp4	7bit	360	fi3digipedagogiikka-1579257387722.mp4	testing	\N
294	object.pouta.csc.fi/testing/avoinjulkaiseminen-1579257578997.mp4	avoinjulkaiseminen.mp4	220988631	video/mp4	7bit	361	avoinjulkaiseminen-1579257578997.mp4	testing	\N
295	https://testing.object.pouta.csc.fi/Tekijnoikeudetopetuksessa-1579257666038.pdf	Tekijnoikeudet opetuksessa.pdf	3893002	application/pdf	7bit	362	Tekijnoikeudetopetuksessa-1579257666038.pdf	testing	\N
296	object.pouta.csc.fi/testing/avoinjulkaiseminen-1579257666024.mp4	avoinjulkaiseminen.mp4	220988631	video/mp4	7bit	363	avoinjulkaiseminen-1579257666024.mp4	testing	\N
297	https://testing.object.pouta.csc.fi/Tekijnoikeudetopetuksessa-1579257778301.pdf	Tekijnoikeudet opetuksessa.pdf	3893002	application/pdf	7bit	364	Tekijnoikeudetopetuksessa-1579257778301.pdf	testing	\N
298	object.pouta.csc.fi/testing/avoinjulkaiseminen-1579257778281.mp4	avoinjulkaiseminen.mp4	220988631	video/mp4	7bit	365	avoinjulkaiseminen-1579257778281.mp4	testing	\N
299	object.pouta.csc.fi/testing/lahioikeudet-1579257956143.mp4	lahioikeudet.mp4	21865195	video/mp4	7bit	366	lahioikeudet-1579257956143.mp4	testing	\N
300	object.pouta.csc.fi/testing/lahioikeudet-1579258106617.mp4	lahioikeudet.mp4	21865195	video/mp4	7bit	367	lahioikeudet-1579258106617.mp4	testing	\N
301	object.pouta.csc.fi/testing/lahioikeudet-1579258461747.mp4	lahioikeudet.mp4	21865195	video/mp4	7bit	368	lahioikeudet-1579258461747.mp4	testing	\N
302	object.pouta.csc.fi/testing/avoinjulkaiseminen-1579258509797.mp4	avoinjulkaiseminen.mp4	220988631	video/mp4	7bit	369	avoinjulkaiseminen-1579258509797.mp4	testing	\N
303	https://testing.object.pouta.csc.fi/Upphovsrtteniundervisningen-1579259325583.pdf	Upphovsrtten i undervisningen.pdf	5010623	application/pdf	7bit	370	Upphovsrtteniundervisningen-1579259325583.pdf	testing	\N
304	object.pouta.csc.fi/testing/avoinjulkaiseminen-1579259325558.mp4	avoinjulkaiseminen.mp4	220988631	video/mp4	7bit	371	avoinjulkaiseminen-1579259325558.mp4	testing	\N
305	https://testing.object.pouta.csc.fi/Tekijnoikeudetopetuksessa-1579259369391.pdf	Tekijnoikeudet opetuksessa.pdf	3893002	application/pdf	7bit	372	Tekijnoikeudetopetuksessa-1579259369391.pdf	testing	\N
306	https://testing.object.pouta.csc.fi/Tekijnoikeudetopetuksessa-1579499523070.pdf	Tekijnoikeudet opetuksessa.pdf	3893002	application/pdf	7bit	373	Tekijnoikeudetopetuksessa-1579499523070.pdf	testing	\N
307	https://testing.object.pouta.csc.fi/Upphovsrtteniundervisningen-1579499523074.pdf	Upphovsrtten i undervisningen.pdf	5010623	application/pdf	7bit	374	Upphovsrtteniundervisningen-1579499523074.pdf	testing	\N
308	object.pouta.csc.fi/testing/avoinjulkaiseminen-1579499523060.mp4	avoinjulkaiseminen.mp4	220988631	video/mp4	7bit	375	avoinjulkaiseminen-1579499523060.mp4	testing	\N
311	https://testing.object.pouta.csc.fi/OERharjoitukset-1579681880126.h5p	OER_harjoitukset.h5p	1854828	application/octet-stream	7bit	378	OERharjoitukset-1579681880126.h5p	testing	\N
312	https://testing.object.pouta.csc.fi/Tekijanoikeudetopetuksessa-1579695393947.pdf	Tekijanoikeudet opetuksessa.pdf	3893002	application/pdf	7bit	379	Tekijanoikeudetopetuksessa-1579695393947.pdf	testing	\N
313	https://testing.object.pouta.csc.fi/Copyrightsineducation-1579762600578.pdf	Copyrights in education.pdf	4953520	application/pdf	7bit	380	Copyrightsineducation-1579762600578.pdf	testing	\N
314	https://testing.object.pouta.csc.fi/Upphovsrtteniundervisningen-1579764958518.pdf	Upphovsrtten i undervisningen.pdf	5010623	application/pdf	7bit	381	Upphovsrtteniundervisningen-1579764958518.pdf	testing	\N
315	object.pouta.csc.fi/testing/lahioikeudet-1579766897921.mp4	lahioikeudet.mp4	21865195	video/mp4	7bit	382	lahioikeudet-1579766897921.mp4	testing	\N
316	https://testing.object.pouta.csc.fi/Copyrightsineducation-1579774108258.pdf	Copyrights in education.pdf	4953520	application/pdf	7bit	383	Copyrightsineducation-1579774108258.pdf	testing	\N
317	https://testing.object.pouta.csc.fi/Tekijanoikeudetopetuksessa-1579774194393.pdf	Tekijanoikeudet opetuksessa.pdf	3893002	application/pdf	7bit	385	Tekijanoikeudetopetuksessa-1579774194393.pdf	testing	\N
310	https://testing.object.pouta.csc.fi/Skrivappnalrresurser-1579681880116.pptx	Skriva öppna lärresurser.pptx	85364	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	377	Skrivappnalrresurser-1579681880116.pptx	testing	Skrivappnalrresurser-1579681880116.pdf
318	https://testing.object.pouta.csc.fi/Copyrightsineducation-1579774381607.pdf	Copyrights in education.pdf	4953520	application/pdf	7bit	386	Copyrightsineducation-1579774381607.pdf	testing	\N
319	https://testing.object.pouta.csc.fi/Upphovsrtteniundervisningen-1579774534854.pdf	Upphovsrtten i undervisningen.pdf	5010623	application/pdf	7bit	387	Upphovsrtteniundervisningen-1579774534854.pdf	testing	\N
320	object.pouta.csc.fi/testing/lahioikeudet-1579774564352.mp4	lahioikeudet.mp4	21865195	video/mp4	7bit	388	lahioikeudet-1579774564352.mp4	testing	\N
321	object.pouta.csc.fi/testing/lahioikeudet-1579780202117.mp4	lahioikeudet.mp4	21865195	video/mp4	7bit	389	lahioikeudet-1579780202117.mp4	testing	\N
322	object.pouta.csc.fi/testing/ohjeet-1579780975573.mp4	ohjeet.mp4	17496902	video/mp4	7bit	390	ohjeet-1579780975573.mp4	testing	\N
323	object.pouta.csc.fi/testing/lahioikeudet-1579781069899.mp4	lahioikeudet.mp4	21865195	video/mp4	7bit	391	lahioikeudet-1579781069899.mp4	testing	\N
324	object.pouta.csc.fi/testing/sitaatit-1579781069911.mp4	sitaatit.mp4	21815495	video/mp4	7bit	392	sitaatit-1579781069911.mp4	testing	\N
325	https://testing.object.pouta.csc.fi/Tekijnoikeudetopetuksessa-1579781510805.pdf	Tekijnoikeudet opetuksessa.pdf	3893002	application/pdf	7bit	393	Tekijnoikeudetopetuksessa-1579781510805.pdf	testing	\N
326	https://testing.object.pouta.csc.fi/Upphovsrtteniundervisningen-1579781510798.pdf	Upphovsrtten i undervisningen.pdf	5010623	application/pdf	7bit	394	Upphovsrtteniundervisningen-1579781510798.pdf	testing	\N
327	object.pouta.csc.fi/testing/avoinjulkaiseminen-1579781510770.mp4	avoinjulkaiseminen.mp4	220988631	video/mp4	7bit	395	avoinjulkaiseminen-1579781510770.mp4	testing	\N
328	https://testing.object.pouta.csc.fi/docker-1579781938700.jpg	docker.jpg	195840	image/jpeg	7bit	396	docker-1579781938700.jpg	testing	\N
329	https://testing.object.pouta.csc.fi/docker-1579781980820.jpg	docker.jpg	195840	image/jpeg	7bit	397	docker-1579781980820.jpg	testing	\N
330	https://testing.object.pouta.csc.fi/docker-1579781984205.jpg	docker.jpg	195840	image/jpeg	7bit	398	docker-1579781984205.jpg	testing	\N
333	https://testing.object.pouta.csc.fi/Tekijnoikeudetopetuksessa-1580192713611.pdf	Tekijnoikeudet opetuksessa.pdf	3893002	application/pdf	7bit	401	Tekijnoikeudetopetuksessa-1580192713611.pdf	testing	\N
337	https://testing.object.pouta.csc.fi/Copyrightsineducation-1580210470334.pdf	Copyrights in education.pdf	4953520	application/pdf	7bit	405	Copyrightsineducation-1580210470334.pdf	testing	\N
340	https://testing.object.pouta.csc.fi/OERharjoitukset-1580282896885.h5p	OER_harjoitukset.h5p	1854828	application/octet-stream	7bit	408	OERharjoitukset-1580282896885.h5p	testing	\N
342	https://testing.object.pouta.csc.fi/Screenshotfrom20200206133746-1580996635828.png	Screenshot from 2020-02-06 13-37-46.png	38606	image/png	7bit	412	Screenshotfrom20200206133746-1580996635828.png	testing	\N
343	https://testing.object.pouta.csc.fi/odavaruus-1581497960369.pdf	od_avaruus.pdf	672892	application/pdf	7bit	413	odavaruus-1581497960369.pdf	testing	\N
344	https://testing.object.pouta.csc.fi/odavaruus-1581498174260.pdf	od_avaruus.pdf	672892	application/pdf	7bit	414	odavaruus-1581498174260.pdf	testing	\N
345	https://testing.object.pouta.csc.fi/Tekijnoikeudetopetuksessa-1581592891897.pdf	Tekijnoikeudet opetuksessa.pdf	3893002	application/pdf	7bit	415	Tekijnoikeudetopetuksessa-1581592891897.pdf	testing	\N
346	https://testing.object.pouta.csc.fi/Upphovsrtteniundervisningen-1581592891893.pdf	Upphovsrtten i undervisningen.pdf	5010623	application/pdf	7bit	416	Upphovsrtteniundervisningen-1581592891893.pdf	testing	\N
347	object.pouta.csc.fi/testing/avoinjulkaiseminen-1581592891867.mp4	avoinjulkaiseminen.mp4	220988631	video/mp4	7bit	417	avoinjulkaiseminen-1581592891867.mp4	testing	\N
348	object.pouta.csc.fi/testing/avoinjulkaiseminen-1581594286292.mp4	avoinjulkaiseminen.mp4	220988631	video/mp4	7bit	418	avoinjulkaiseminen-1581594286292.mp4	testing	\N
349	object.pouta.csc.fi/testing/lahioikeudet-1581594711603.mp4	lahioikeudet.mp4	21865195	video/mp4	7bit	419	lahioikeudet-1581594711603.mp4	testing	\N
350	object.pouta.csc.fi/testing/lahioikeudet-1581595522737.mp4	lahioikeudet.mp4	21865195	video/mp4	7bit	420	lahioikeudet-1581595522737.mp4	testing	\N
351	object.pouta.csc.fi/testing/lahioikeudet-1581595580581.mp4	lahioikeudet.mp4	21865195	video/mp4	7bit	421	lahioikeudet-1581595580581.mp4	testing	\N
334	https://testing.object.pouta.csc.fi/Kuinkatehdavoimiaoppimateriaaleja-1580196997550.pptx	Kuinka tehdä avoimia oppimateriaaleja.pptx	85367	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	402	Kuinkatehdavoimiaoppimateriaaleja-1580196997550.pptx	testing	Kuinkatehdavoimiaoppimateriaaleja-1580196997550.pdf
335	https://testing.object.pouta.csc.fi/6bPuheentuottoopiskelijalle-1580207701286.pptx	6b Puheentuotto_opiskelijalle.pptx	1290933	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	403	6bPuheentuottoopiskelijalle-1580207701286.pptx	testing	6bPuheentuottoopiskelijalle-1580207701286.pdf
336	https://testing.object.pouta.csc.fi/14tekijanoikeudetvirtuaaliluokassaopettajanoikeudet-1580209524845.pptx	14_tekijänoikeudet_virtuaaliluokassa_opettajan_oikeudet.pptx	287192	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	404	14tekijanoikeudetvirtuaaliluokassaopettajanoikeudet-1580209524845.pptx	testing	14tekijanoikeudetvirtuaaliluokassaopettajanoikeudet-1580209524845.pdf
338	https://testing.object.pouta.csc.fi/Kuinkatehdavoimiaoppimateriaaleja-1580282896750.pptx	Kuinka tehdä avoimia oppimateriaaleja.pptx	85367	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	406	Kuinkatehdavoimiaoppimateriaaleja-1580282896750.pptx	testing	Kuinkatehdavoimiaoppimateriaaleja-1580282896750.pdf
339	https://testing.object.pouta.csc.fi/Skrivappnalrresurser-1580282896880.pptx	Skriva öppna lärresurser.pptx	85364	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	407	Skrivappnalrresurser-1580282896880.pptx	testing	Skrivappnalrresurser-1580282896880.pdf
352	object.pouta.csc.fi/testing/lahioikeudet-1581596357441.mp4	lahioikeudet.mp4	21865195	video/mp4	7bit	422	lahioikeudet-1581596357441.mp4	testing	\N
353	https://testing.object.pouta.csc.fi/tekijnoikeudetopetuksessa-1581597347534.pdf	tekijnoikeudet opetuksessa.pdf	3893002	application/pdf	7bit	423	tekijnoikeudetopetuksessa-1581597347534.pdf	testing	\N
354	object.pouta.csc.fi/testing/avoinjulkaiseminen-1581597347525.mp4	avoinjulkaiseminen.mp4	220988631	video/mp4	7bit	424	avoinjulkaiseminen-1581597347525.mp4	testing	\N
355	object.pouta.csc.fi/testing/lahioikeudet-1581597623868.mp4	lahioikeudet.mp4	21865195	video/mp4	7bit	425	lahioikeudet-1581597623868.mp4	testing	\N
357	https://testing.object.pouta.csc.fi/tekijnoikeudetopetuksessa-1581927696922.pdf	tekijnoikeudet opetuksessa.pdf	3893002	application/pdf	7bit	427	tekijnoikeudetopetuksessa-1581927696922.pdf	testing	\N
360	object.pouta.csc.fi/testing/avoinjulkaiseminen-1582005834691.mp4	avoinjulkaiseminen.mp4	220988631	video/mp4	7bit	430	avoinjulkaiseminen-1582005834691.mp4	testing	\N
361	https://testing.object.pouta.csc.fi/testikuvatestikuvatestikuvatestikuvatestikuvatestikuvatestikuvavtestikuvatestikuvatestikuvatestikuvatestikuvatestikuvatestikuvatestikuvatestikuvatestikuvaaa-1582183599603.png	testikuva-testikuva-testikuva-testikuva-testikuva-testikuva-testikuva-vtestikuva-testikuva-testikuva-testikuva-testikuva-testikuva-testikuva-testikuva-testikuva-testikuva-aa.png	11760	image/png	7bit	439	testikuvatestikuvatestikuvatestikuvatestikuvatestikuvatestikuvavtestikuvatestikuvatestikuvatestikuvatestikuvatestikuvatestikuvatestikuvatestikuvatestikuvaaa-1582183599603.png	testing	\N
362	https://testing.object.pouta.csc.fi/testikuva-1582202429058.png	testikuva.png	11760	image/png	7bit	441	testikuva-1582202429058.png	testing	\N
363	object.pouta.csc.fi/testing/lahioikeudet-1582204744122.mp4	lahioikeudet.mp4	21865195	video/mp4	7bit	442	lahioikeudet-1582204744122.mp4	testing	\N
364	object.pouta.csc.fi/testing/lahioikeudet-1582204906275.mp4	lahioikeudet.mp4	21865195	video/mp4	7bit	443	lahioikeudet-1582204906275.mp4	testing	\N
365	https://testing.object.pouta.csc.fi/screenshotfrom20200221155055-1582293192009.png	screenshot from 2020-02-21 15-50-55.png	6580	image/png	7bit	444	screenshotfrom20200221155055-1582293192009.png	testing	\N
366	https://testing.object.pouta.csc.fi/esimerkkimateriaali2-1582294353930.png	esimerkkimateriaali2.png	30514	image/png	7bit	446	esimerkkimateriaali2-1582294353930.png	testing	\N
367	https://testing.object.pouta.csc.fi/esimerkkimateriaali1-1582294353928.png	esimerkkimateriaali1.png	17845	image/png	7bit	445	esimerkkimateriaali1-1582294353928.png	testing	\N
368	https://testing.object.pouta.csc.fi/esimerkkimateriaali2-1582294358471.png	esimerkkimateriaali2.png	30514	image/png	7bit	448	esimerkkimateriaali2-1582294358471.png	testing	\N
369	https://testing.object.pouta.csc.fi/esimerkkimateriaali1-1582294358465.png	esimerkkimateriaali1.png	17845	image/png	7bit	447	esimerkkimateriaali1-1582294358465.png	testing	\N
371	https://testing.object.pouta.csc.fi/oerharjoitukset-1582526482788.h5p	oer_harjoitukset.h5p	1854828	application/octet-stream	7bit	450	oerharjoitukset-1582526482788.h5p	testing	\N
373	https://testing.object.pouta.csc.fi/oerharjoitukset-1582526767625.h5p	oer_harjoitukset.h5p	1854828	application/octet-stream	7bit	452	oerharjoitukset-1582526767625.h5p	testing	\N
375	object.pouta.csc.fi/testing/avoinjulkaiseminen-1582526953727.mp4	avoinjulkaiseminen.mp4	220988631	video/mp4	7bit	454	avoinjulkaiseminen-1582526953727.mp4	testing	\N
376	object.pouta.csc.fi/testing/lahioikeudet-1582531648666.mp4	lahioikeudet.mp4	21865195	video/mp4	7bit	455	lahioikeudet-1582531648666.mp4	testing	\N
377	https://testing.object.pouta.csc.fi/screenshotfrom20200221160616-1582534659167.png	screenshot from 2020-02-21 16-06-16.png	24837	image/png	7bit	456	screenshotfrom20200221160616-1582534659167.png	testing	\N
378	object.pouta.csc.fi/testing/lahioikeudet-1582534821447.mp4	lahioikeudet.mp4	21865195	video/mp4	7bit	457	lahioikeudet-1582534821447.mp4	testing	\N
379	https://testing.object.pouta.csc.fi/screenshotfrom20200221161442-1582535234199.png	screenshot from 2020-02-21 16-14-42.png	50450	image/png	7bit	458	screenshotfrom20200221161442-1582535234199.png	testing	\N
381	https://testing.object.pouta.csc.fi/esimerkkimateriaali1-1582609069560.png	esimerkkimateriaali1.png	17845	image/png	7bit	460	esimerkkimateriaali1-1582609069560.png	testing	\N
382	https://testing.object.pouta.csc.fi/esimerkkimateriaali1-1582610487750.png	esimerkkimateriaali1.png	17845	image/png	7bit	461	esimerkkimateriaali1-1582610487750.png	testing	\N
383	object.pouta.csc.fi/testing/lahioikeudet-1582620682537.mp4	lahioikeudet.mp4	21865195	video/mp4	7bit	464	lahioikeudet-1582620682537.mp4	testing	\N
384	https://testing.object.pouta.csc.fi/img20200225174348-1582645594808.jpg	img_20200225_174348.jpg	866614	image/jpeg	7bit	468	img20200225174348-1582645594808.jpg	testing	\N
358	https://testing.object.pouta.csc.fi/skrivappnalrresurser-1582005834689.pptx	skriva öppna lärresurser.pptx	85364	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	429	skrivappnalrresurser-1582005834689.pptx	testing	skrivappnalrresurser-1582005834689.pdf
359	https://testing.object.pouta.csc.fi/ninteetavoimiaoppimateriaaleja-1582005834665.pptx	näin teet avoimia oppimateriaaleja.pptx	85367	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	428	ninteetavoimiaoppimateriaaleja-1582005834665.pptx	testing	ninteetavoimiaoppimateriaaleja-1582005834665.pdf
370	https://testing.object.pouta.csc.fi/ninteetavoimiaoppimateriaaleja-1582526482836.pptx	näin teet avoimia oppimateriaaleja.pptx	85367	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	449	ninteetavoimiaoppimateriaaleja-1582526482836.pptx	testing	ninteetavoimiaoppimateriaaleja-1582526482836.pdf
374	https://testing.object.pouta.csc.fi/skrivappnalrresurser-1582526953704.pptx	skriva öppna lärresurser.pptx	85364	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	453	skrivappnalrresurser-1582526953704.pptx	testing	skrivappnalrresurser-1582526953704.pdf
380	https://testing.object.pouta.csc.fi/skrivappnalrresurser-1582535434414.pptx	skriva öppna lärresurser.pptx	85364	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	459	skrivappnalrresurser-1582535434414.pptx	testing	skrivappnalrresurser-1582535434414.pdf
385	https://testing.object.pouta.csc.fi/screenshotfrom20200227153131-1582877381035.png	screenshot from 2020-02-27 15-31-31.png	71454	image/png	7bit	470	screenshotfrom20200227153131-1582877381035.png	testing	\N
386	https://testing.object.pouta.csc.fi/screenshotfrom20200227153131-1582884431200.png	screenshot from 2020-02-27 15-31-31.png	71454	image/png	7bit	471	screenshotfrom20200227153131-1582884431200.png	testing	\N
387	https://testing.object.pouta.csc.fi/screenshotfrom20200225081233-1582884431218.png	screenshot from 2020-02-25 08-12-33.png	193575	image/png	7bit	472	screenshotfrom20200225081233-1582884431218.png	testing	\N
388	https://testing.object.pouta.csc.fi/screenshotfrom20200227153131-1582884481298.png	screenshot from 2020-02-27 15-31-31.png	71454	image/png	7bit	473	screenshotfrom20200227153131-1582884481298.png	testing	\N
389	https://testing.object.pouta.csc.fi/screenshotfrom20200227153131-1582884489808.png	screenshot from 2020-02-27 15-31-31.png	71454	image/png	7bit	474	screenshotfrom20200227153131-1582884489808.png	testing	\N
393	https://testing.object.pouta.csc.fi/test-1582890329509.txt	test.txt	0	text/plain	7bit	478	test-1582890329509.txt	testing	\N
395	object.pouta.csc.fi/testing/pythonmasterpaivitetty-1583427555184.zip	python-master-paivitetty.zip	39804110	application/zip	7bit	481	pythonmasterpaivitetty-1583427555184.zip	testing	\N
396	https://testing.object.pouta.csc.fi/test-1583496777947.txt	test.txt	0	text/plain	7bit	482	test-1583496777947.txt	testing	\N
397	https://testing.object.pouta.csc.fi/test-1583497325938.txt	test.txt	0	text/plain	7bit	483	test-1583497325938.txt	testing	\N
399	https://testing.object.pouta.csc.fi/test-1583825780834.txt	test.txt	0	text/plain	7bit	485	test-1583825780834.txt	testing	\N
400	https://testing.object.pouta.csc.fi/screenshotfrom20200309104349-1583831623170.png	screenshot from 2020-03-09 10-43-49.png	40008	image/png	7bit	486	screenshotfrom20200309104349-1583831623170.png	testing	\N
401	object.pouta.csc.fi/testing/pythonmasterpaivitetty-1583931022171.zip	python-master-paivitetty.zip	39804110	application/zip	7bit	487	pythonmasterpaivitetty-1583931022171.zip	testing	\N
402	https://testing.object.pouta.csc.fi/screenshotfrom20200316115851-1584450433943.png	screenshot from 2020-03-16 11-58-51.png	200711	image/png	7bit	488	screenshotfrom20200316115851-1584450433943.png	testing	\N
403	https://testing.object.pouta.csc.fi/aoefilogonega-1584535204206.pdf	aoefi_logo_nega.pdf	65588	application/pdf	7bit	491	aoefilogonega-1584535204206.pdf	testing	\N
404	https://testing.object.pouta.csc.fi/screenshotfrom20200323110934-1585050773064.png	screenshot from 2020-03-23 11-09-34.png	17987	image/png	7bit	492	screenshotfrom20200323110934-1585050773064.png	testing	\N
407	object.pouta.csc.fi/testing/avoinjulkaiseminen-1585123021292.mp4	avoinjulkaiseminen.mp4	220988631	video/mp4	7bit	495	avoinjulkaiseminen-1585123021292.mp4	testing	\N
408	https://testing.object.pouta.csc.fi/odavaruus-1585641588392.pdf	od_avaruus.pdf	672892	application/pdf	7bit	499	odavaruus-1585641588392.pdf	testing	\N
409	object.pouta.csc.fi/testing/pythonmasterpaivitetty-1585770794161.zip	python-master-paivitetty.zip	39804110	application/zip	7bit	500	pythonmasterpaivitetty-1585770794161.zip	testing	\N
410	object.pouta.csc.fi/testing/pythonmasterpaivitetty-1585770905060.zip	python-master-paivitetty.zip	39804110	application/zip	7bit	501	pythonmasterpaivitetty-1585770905060.zip	testing	\N
411	object.pouta.csc.fi/testing/lahioikeudet-1585828149471.mp4	lahioikeudet.mp4	21865195	video/mp4	7bit	502	lahioikeudet-1585828149471.mp4	testing	\N
412	https://testing.object.pouta.csc.fi/screenshotfrom20200403124851-1585908570091.png	screenshot from 2020-04-03 12-48-51.png	87341	image/png	7bit	503	screenshotfrom20200403124851-1585908570091.png	testing	\N
414	https://testing.object.pouta.csc.fi/bestmovie-1586257241846.mp4	best-movie.mp4	0	video/mp4	7bit	504	bestmovie-1586257241846.mp4	testing	\N
415	https://testing.object.pouta.csc.fi/odavaruus-1586335593237.pdf	od_avaruus.pdf	672892	application/pdf	7bit	506	odavaruus-1586335593237.pdf	testing	\N
416	https://testing.object.pouta.csc.fi/odavaruus-1586419062965.pdf	od_avaruus.pdf	672892	application/pdf	7bit	507	odavaruus-1586419062965.pdf	testing	\N
417	https://testing.object.pouta.csc.fi/odavaruus-1586420245353.pdf	od_avaruus.pdf	672892	application/pdf	7bit	508	odavaruus-1586420245353.pdf	testing	\N
418	https://testing.object.pouta.csc.fi/avoinoppiminenjaaoe-1586846253059.pdf	avoin_oppiminen_ja_aoe.pdf	3027802	application/pdf	7bit	509	avoinoppiminenjaaoe-1586846253059.pdf	testing	\N
391	https://testing.object.pouta.csc.fi/ninteetavoimiaoppimateriaaleja-1582884523091.pptx	näin teet avoimia oppimateriaaleja.pptx	85367	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	475	ninteetavoimiaoppimateriaaleja-1582884523091.pptx	testing	ninteetavoimiaoppimateriaaleja-1582884523091.pdf
392	https://testing.object.pouta.csc.fi/ninteetavoimiaoppimateriaaleja-1582884523096.pptx	näin teet avoimia oppimateriaaleja.pptx	85367	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	476	ninteetavoimiaoppimateriaaleja-1582884523096.pptx	testing	ninteetavoimiaoppimateriaaleja-1582884523096.pdf
398	https://testing.object.pouta.csc.fi/ninteetavoimiaoppimateriaaleja-1583737173549.pptx	näin teet avoimia oppimateriaaleja.pptx	85367	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	484	ninteetavoimiaoppimateriaaleja-1583737173549.pptx	testing	ninteetavoimiaoppimateriaaleja-1583737173549.pdf
405	https://testing.object.pouta.csc.fi/skrivappnalrresurser-1585123021304.pptx	skriva öppna lärresurser.pptx	85364	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	494	skrivappnalrresurser-1585123021304.pptx	testing	skrivappnalrresurser-1585123021304.pdf
406	https://testing.object.pouta.csc.fi/ninteetavoimiaoppimateriaaleja-1585123021236.pptx	näin teet avoimia oppimateriaaleja.pptx	85367	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	493	ninteetavoimiaoppimateriaaleja-1585123021236.pptx	testing	ninteetavoimiaoppimateriaaleja-1585123021236.pdf
413	https://testing.object.pouta.csc.fi/bestdocument-1586257241871.docx	best-document.docx	0	application/vnd.openxmlformats-officedocument.wordprocessingml.document	7bit	505	bestdocument-1586257241871.docx	testing	bestdocument-1586257241871.pdf
422	https://testing.object.pouta.csc.fi/oerharjoitukset-1587032439499.h5p	oer_harjoitukset.h5p	1854828	application/octet-stream	7bit	513	oerharjoitukset-1587032439499.h5p	testing	\N
423	object.pouta.csc.fi/testing/pythonmasterpaivitetty-1587629823123.zip	python-master-paivitetty.zip	39804110	application/zip	7bit	514	pythonmasterpaivitetty-1587629823123.zip	testing	\N
424	object.pouta.csc.fi/testing/pythonmasterpaivitetty-1587635638185.zip	python-master-paivitetty.zip	39804110	application/zip	7bit	515	pythonmasterpaivitetty-1587635638185.zip	testing	\N
425	https://testing.object.pouta.csc.fi/screenshotfrom20200414160407-1587966537328.png	screenshot from 2020-04-14 16-04-07.png	52866	image/png	7bit	516	screenshotfrom20200414160407-1587966537328.png	testing	\N
426	https://testing.object.pouta.csc.fi/screenshotfrom20200414160407-1587966537358.png	screenshot from 2020-04-14 16-04-07.png	52866	image/png	7bit	517	screenshotfrom20200414160407-1587966537358.png	testing	\N
427	https://testing.object.pouta.csc.fi/screenshotfrom20200414160407-1587966537362.png	screenshot from 2020-04-14 16-04-07.png	52866	image/png	7bit	518	screenshotfrom20200414160407-1587966537362.png	testing	\N
428	https://testing.object.pouta.csc.fi/screenshotfrom20200414160407-1587966537518.png	screenshot from 2020-04-14 16-04-07.png	52866	image/png	7bit	519	screenshotfrom20200414160407-1587966537518.png	testing	\N
429	https://testing.object.pouta.csc.fi/screenshotfrom20200414160407-1587966537513.png	screenshot from 2020-04-14 16-04-07.png	52866	image/png	7bit	521	screenshotfrom20200414160407-1587966537513.png	testing	\N
430	https://testing.object.pouta.csc.fi/screenshotfrom20200414160407-1587966537510.png	screenshot from 2020-04-14 16-04-07.png	52866	image/png	7bit	520	screenshotfrom20200414160407-1587966537510.png	testing	\N
431	https://testing.object.pouta.csc.fi/screenshotfrom20200414160407-1587966537525.png	screenshot from 2020-04-14 16-04-07.png	52866	image/png	7bit	522	screenshotfrom20200414160407-1587966537525.png	testing	\N
432	https://testing.object.pouta.csc.fi/screenshotfrom20200414160407-1587966537551.png	screenshot from 2020-04-14 16-04-07.png	52866	image/png	7bit	523	screenshotfrom20200414160407-1587966537551.png	testing	\N
433	https://testing.object.pouta.csc.fi/screenshotfrom20200414160407-1587966537775.png	screenshot from 2020-04-14 16-04-07.png	52866	image/png	7bit	524	screenshotfrom20200414160407-1587966537775.png	testing	\N
434	https://testing.object.pouta.csc.fi/screenshotfrom20200414160407-1587966537496.png	screenshot from 2020-04-14 16-04-07.png	52866	image/png	7bit	525	screenshotfrom20200414160407-1587966537496.png	testing	\N
435	https://testing.object.pouta.csc.fi/screenshotfrom20200403153151-1587966588094.png	screenshot from 2020-04-03 15-31-51.png	170660	image/png	7bit	526	screenshotfrom20200403153151-1587966588094.png	testing	\N
436	https://testing.object.pouta.csc.fi/odavaruus-1587972746216.pdf	od_avaruus.pdf	672892	application/pdf	7bit	528	odavaruus-1587972746216.pdf	testing	\N
437	object.pouta.csc.fi/testing/scratchmasterpaivitetty-1588114781978.zip	scratch-master-paivitetty.zip	64776771	application/zip	7bit	529	scratchmasterpaivitetty-1588114781978.zip	testing	\N
438	https://testing.object.pouta.csc.fi/aoefilogonega-1588157194917.pdf	aoefi_logo_nega.pdf	65588	application/pdf	7bit	530	aoefilogonega-1588157194917.pdf	testing	\N
439	https://testing.object.pouta.csc.fi/digialogorgb-1588166267705.png	digia_logo_rgb.png	60433	image/png	7bit	531	digialogorgb-1588166267705.png	testing	\N
440	https://testing.object.pouta.csc.fi/aoefilogonega-1588226610455.pdf	aoefi_logo_nega.pdf	65588	application/pdf	7bit	532	aoefilogonega-1588226610455.pdf	testing	\N
441	https://testing.object.pouta.csc.fi/aoefilogonega-1588227118249.pdf	aoefi_logo_nega.pdf	65588	application/pdf	7bit	533	aoefilogonega-1588227118249.pdf	testing	\N
442	https://testing.object.pouta.csc.fi/aoefilogonega-1588227267862.pdf	aoefi_logo_nega.pdf	65588	application/pdf	7bit	534	aoefilogonega-1588227267862.pdf	testing	\N
444	https://testing.object.pouta.csc.fi/aoefilogonega-1588663823555.pdf	aoefi_logo_nega.pdf	65588	application/pdf	7bit	536	aoefilogonega-1588663823555.pdf	testing	\N
445	https://testing.object.pouta.csc.fi/digialogocmyk-1588663922315.ai	digia_logo_cmyk.ai	1124039	application/postscript	7bit	537	digialogocmyk-1588663922315.ai	testing	\N
446	https://testing.object.pouta.csc.fi/aoefilogonega-1588664029868.pdf	aoefi_logo_nega.pdf	65588	application/pdf	7bit	538	aoefilogonega-1588664029868.pdf	testing	\N
447	https://testing.object.pouta.csc.fi/aoefilogonega-1588664092020.pdf	aoefi_logo_nega.pdf	65588	application/pdf	7bit	539	aoefilogonega-1588664092020.pdf	testing	\N
448	https://testing.object.pouta.csc.fi/odavaruus-1588664149109.pdf	od_avaruus.pdf	672892	application/pdf	7bit	540	odavaruus-1588664149109.pdf	testing	\N
449	https://testing.object.pouta.csc.fi/odavaruus-1588664149119.pdf	od_avaruus.pdf	672892	application/pdf	7bit	541	odavaruus-1588664149119.pdf	testing	\N
450	https://testing.object.pouta.csc.fi/digialogorgb-1588664692842.png	digia_logo_rgb.png	60433	image/png	7bit	542	digialogorgb-1588664692842.png	testing	\N
451	https://testing.object.pouta.csc.fi/aoefilogonega-1588664865380.pdf	aoefi_logo_nega.pdf	65588	application/pdf	7bit	543	aoefilogonega-1588664865380.pdf	testing	\N
452	https://testing.object.pouta.csc.fi/odavaruus-1588679219522.pdf	od_avaruus.pdf	672892	application/pdf	7bit	549	odavaruus-1588679219522.pdf	testing	\N
453	https://testing.object.pouta.csc.fi/codingcup-1588679618150.jpg	coding-cup.jpg	3835	image/jpeg	7bit	550	codingcup-1588679618150.jpg	testing	\N
420	https://testing.object.pouta.csc.fi/kuinkatehdavoimiaoppimateriaaleja-1587032439380.pptx	kuinka tehdä avoimia oppimateriaaleja.pptx	85367	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	511	kuinkatehdavoimiaoppimateriaaleja-1587032439380.pptx	testing	kuinkatehdavoimiaoppimateriaaleja-1587032439380.pdf
421	https://testing.object.pouta.csc.fi/skrivappnalrresurser-1587032439528.pptx	skriva öppna lärresurser.pptx	85364	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	512	skrivappnalrresurser-1587032439528.pptx	testing	skrivappnalrresurser-1587032439528.pdf
455	https://testing.object.pouta.csc.fi/screenshotfrom20200403150647-1588679737968.png	screenshot from 2020-04-03 15-06-47.png	138314	image/png	7bit	552	screenshotfrom20200403150647-1588679737968.png	testing	\N
456	https://testing.object.pouta.csc.fi/screenshotfrom20200403145328-1588679770856.png	screenshot from 2020-04-03 14-53-28.png	153286	image/png	7bit	553	screenshotfrom20200403145328-1588679770856.png	testing	\N
457	https://testing.object.pouta.csc.fi/02opettajakoneellatakaa-1588679864998.png	02-opettaja-koneella-takaa.png	2213968	image/png	7bit	554	02opettajakoneellatakaa-1588679864998.png	testing	\N
459	https://testing.object.pouta.csc.fi/screenshotfrom20200403153151-1588680811486.png	screenshot from 2020-04-03 15-31-51.png	170660	image/png	7bit	557	screenshotfrom20200403153151-1588680811486.png	testing	\N
460	https://testing.object.pouta.csc.fi/odavaruus-1588838897988.pdf	od_avaruus.pdf	672892	application/pdf	7bit	558	odavaruus-1588838897988.pdf	testing	\N
461	https://testing.object.pouta.csc.fi/screenshotfrom20200403153151-1588841773190.png	screenshot from 2020-04-03 15-31-51.png	170660	image/png	7bit	559	screenshotfrom20200403153151-1588841773190.png	testing	\N
462	https://testing.object.pouta.csc.fi/screenshotfrom20200403123436-1588926691347.png	screenshot from 2020-04-03 12-34-36.png	106975	image/png	7bit	562	screenshotfrom20200403123436-1588926691347.png	testing	\N
463	https://testing.object.pouta.csc.fi/screenshotfrom20200403150647-1588926691351.png	screenshot from 2020-04-03 15-06-47.png	138314	image/png	7bit	563	screenshotfrom20200403150647-1588926691351.png	testing	\N
464	https://testing.object.pouta.csc.fi/screenshotfrom20200403145328-1588926722155.png	screenshot from 2020-04-03 14-53-28.png	153286	image/png	7bit	564	screenshotfrom20200403145328-1588926722155.png	testing	\N
465	object.pouta.csc.fi/testing/avoinjulkaiseminen-1588926691342.mp4	avoinjulkaiseminen.mp4	220988631	video/mp4	7bit	565	avoinjulkaiseminen-1588926691342.mp4	testing	\N
466	https://testing.object.pouta.csc.fi/oojsuiiconbulb2greenopa-1588926934289.svg	oojs_ui_icon_bulb2_green_opa.svg	2460	image/svg+xml	7bit	567	oojsuiiconbulb2greenopa-1588926934289.svg	testing	\N
467	https://testing.object.pouta.csc.fi/zoom-1588926934302.png	zoom.png	16967	image/png	7bit	568	zoom-1588926934302.png	testing	\N
468	https://testing.object.pouta.csc.fi/screenshotfrom20200403153151-1588927012561.png	screenshot from 2020-04-03 15-31-51.png	170660	image/png	7bit	569	screenshotfrom20200403153151-1588927012561.png	testing	\N
470	https://testing.object.pouta.csc.fi/screenshotfrom20200331135049-1588927877118.png	screenshot from 2020-03-31 13-50-49.png	133332	image/png	7bit	571	screenshotfrom20200331135049-1588927877118.png	testing	\N
473	https://testing.object.pouta.csc.fi/codingcup-1588936540758.jpg	coding-cup.jpg	3835	image/jpeg	7bit	574	codingcup-1588936540758.jpg	testing	\N
474	object.pouta.csc.fi/testing/pythonmasterpaivitetty2-1589400010594.zip	python-master-paivitetty2.zip	39804110	application/zip	7bit	575	pythonmasterpaivitetty2-1589400010594.zip	testing	\N
475	object.pouta.csc.fi/testing/oho-1589433165676.zip	oho.zip	59351933	application/zip	7bit	576	oho-1589433165676.zip	testing	\N
476	object.pouta.csc.fi/testing/lahioikeudet-1589440101359.mp4	lahioikeudet.mp4	21865195	video/mp4	7bit	577	lahioikeudet-1589440101359.mp4	testing	\N
477	object.pouta.csc.fi/testing/scratchmasterpaivitetty-1589444962390.zip	scratch-master-paivitetty.zip	64776771	application/zip	7bit	578	scratchmasterpaivitetty-1589444962390.zip	testing	\N
480	https://testing.object.pouta.csc.fi/oerharjoitukset-1589451430013.h5p	oer_harjoitukset.h5p	1854828	application/octet-stream	7bit	581	oerharjoitukset-1589451430013.h5p	testing	\N
481	object.pouta.csc.fi/testing/lahioikeudet-1589453321480.mp4	lahioikeudet.mp4	21865195	video/mp4	7bit	582	lahioikeudet-1589453321480.mp4	testing	\N
482	object.pouta.csc.fi/testing/lahioikeudet-1589453483533.mp4	lahioikeudet.mp4	21865195	video/mp4	7bit	583	lahioikeudet-1589453483533.mp4	testing	\N
483	object.pouta.csc.fi/testing/lahioikeudet-1589453589330.mp4	lahioikeudet.mp4	21865195	video/mp4	7bit	584	lahioikeudet-1589453589330.mp4	testing	\N
484	object.pouta.csc.fi/testing/lahioikeudet-1589453677367.mp4	lahioikeudet.mp4	21865195	video/mp4	7bit	585	lahioikeudet-1589453677367.mp4	testing	\N
485	object.pouta.csc.fi/testing/lahioikeudet-1589453806930.mp4	lahioikeudet.mp4	21865195	video/mp4	7bit	586	lahioikeudet-1589453806930.mp4	testing	\N
486	object.pouta.csc.fi/testing/lahioikeudet-1589454228850.mp4	lahioikeudet.mp4	21865195	video/mp4	7bit	587	lahioikeudet-1589454228850.mp4	testing	\N
487	object.pouta.csc.fi/testing/lahioikeudet-1589454283827.mp4	lahioikeudet.mp4	21865195	video/mp4	7bit	588	lahioikeudet-1589454283827.mp4	testing	\N
488	object.pouta.csc.fi/testing/lahioikeudet-1589454348776.mp4	lahioikeudet.mp4	21865195	video/mp4	7bit	589	lahioikeudet-1589454348776.mp4	testing	\N
458	https://testing.object.pouta.csc.fi/kuinkatehdavoimiaoppimateriaaleja-1588679999322.pptx	kuinka tehdä avoimia oppimateriaaleja.pptx	85367	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	555	kuinkatehdavoimiaoppimateriaaleja-1588679999322.pptx	testing	kuinkatehdavoimiaoppimateriaaleja-1588679999322.pdf
471	https://testing.object.pouta.csc.fi/skrivappnalrresurser-1588927877121.pptx	skriva öppna lärresurser.pptx	85364	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	570	skrivappnalrresurser-1588927877121.pptx	testing	skrivappnalrresurser-1588927877121.pdf
472	https://testing.object.pouta.csc.fi/kuinkatehdavoimiaoppimateriaaleja-1588931730040.pptx	kuinka tehdä avoimia oppimateriaaleja.pptx	85367	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	573	kuinkatehdavoimiaoppimateriaaleja-1588931730040.pptx	testing	kuinkatehdavoimiaoppimateriaaleja-1588931730040.pdf
478	https://testing.object.pouta.csc.fi/kuinkatehdavoimiaoppimateriaaleja-1589451429917.pptx	kuinka tehdä avoimia oppimateriaaleja.pptx	85367	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	579	kuinkatehdavoimiaoppimateriaaleja-1589451429917.pptx	testing	kuinkatehdavoimiaoppimateriaaleja-1589451429917.pdf
479	https://testing.object.pouta.csc.fi/skrivappnalrresurser-1589451430042.pptx	skriva öppna lärresurser.pptx	85364	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	580	skrivappnalrresurser-1589451430042.pptx	testing	skrivappnalrresurser-1589451430042.pdf
489	object.pouta.csc.fi/testing/lahioikeudet-1589454407538.mp4	lahioikeudet.mp4	21865195	video/mp4	7bit	590	lahioikeudet-1589454407538.mp4	testing	\N
490	object.pouta.csc.fi/testing/lahioikeudet-1589454407530.mp4	lahioikeudet.mp4	21865195	video/mp4	7bit	591	lahioikeudet-1589454407530.mp4	testing	\N
491	https://testing.object.pouta.csc.fi/copyrightsineducation-1589460491735.pdf	copyrights in education.pdf	4953520	application/pdf	7bit	592	copyrightsineducation-1589460491735.pdf	testing	\N
492	object.pouta.csc.fi/testing/avoinjulkaiseminen-1589460445319.mp4	avoinjulkaiseminen.mp4	220988631	video/mp4	7bit	593	avoinjulkaiseminen-1589460445319.mp4	testing	\N
493	object.pouta.csc.fi/testing/avoinjulkaiseminen-1589460520403.mp4	avoinjulkaiseminen.mp4	220988631	video/mp4	7bit	594	avoinjulkaiseminen-1589460520403.mp4	testing	\N
494	object.pouta.csc.fi/testing/avoinjulkaiseminen-1589460607919.mp4	avoinjulkaiseminen.mp4	220988631	video/mp4	7bit	595	avoinjulkaiseminen-1589460607919.mp4	testing	\N
495	object.pouta.csc.fi/testing/lahioikeudet-1589523861355.mp4	lahioikeudet.mp4	21865195	video/mp4	7bit	596	lahioikeudet-1589523861355.mp4	testing	\N
497	https://testing.object.pouta.csc.fi/screenshotfrom20200526111513-1590554384740.png	screenshot from 2020-05-26 11-15-13.png	16496	image/png	7bit	598	screenshotfrom20200526111513-1590554384740.png	testing	\N
498	https://testing.object.pouta.csc.fi/screenshotfrom20200526111337-1590563611432.png	screenshot from 2020-05-26 11-13-37.png	53794	image/png	7bit	599	screenshotfrom20200526111337-1590563611432.png	testing	\N
499	https://testing.object.pouta.csc.fi/screenshotfrom20200603150333-1591261164147.png	screenshot from 2020-06-03 15-03-33.png	109705	image/png	7bit	602	screenshotfrom20200603150333-1591261164147.png	testing	\N
500	https://testing.object.pouta.csc.fi/screenshotfrom20200603150333-1591261191517.png	screenshot from 2020-06-03 15-03-33.png	109705	image/png	7bit	603	screenshotfrom20200603150333-1591261191517.png	testing	\N
501	https://testing.object.pouta.csc.fi/screenshotfrom20200603150333-1591261330432.png	screenshot from 2020-06-03 15-03-33.png	109705	image/png	7bit	604	screenshotfrom20200603150333-1591261330432.png	testing	\N
502	https://testing.object.pouta.csc.fi/screenshotfrom20200601152939-1591261469227.png	screenshot from 2020-06-01 15-29-39.png	40332	image/png	7bit	605	screenshotfrom20200601152939-1591261469227.png	testing	\N
503	https://testing.object.pouta.csc.fi/s22kielijatekstitietoisuusonnikaarle-1591272172311.mbz	s22 kieli- ja tekstitietoisuus onni kaarle.mbz	1041415	application/octet-stream	7bit	606	s22kielijatekstitietoisuusonnikaarle-1591272172311.mbz	testing	\N
504	https://testing.object.pouta.csc.fi/codingcup-1591331196742.jpg	coding-cup.jpg	3835	image/jpeg	7bit	607	codingcup-1591331196742.jpg	testing	\N
505	https://testing.object.pouta.csc.fi/codingcup-1591344266312.jpg	coding-cup.jpg	3835	image/jpeg	7bit	608	codingcup-1591344266312.jpg	testing	\N
506	https://testing.object.pouta.csc.fi/codingcup-1591344661399.jpg	coding-cup.jpg	3835	image/jpeg	7bit	609	codingcup-1591344661399.jpg	testing	\N
507	https://testing.object.pouta.csc.fi/codingcup-1591344760490.jpg	coding-cup.jpg	3835	image/jpeg	7bit	610	codingcup-1591344760490.jpg	testing	\N
508	https://testing.object.pouta.csc.fi/aoefietusivuvs2-1591347877898.png	aoefi_etusivu_vs2.png	351671	image/png	7bit	611	aoefietusivuvs2-1591347877898.png	testing	\N
509	object.pouta.csc.fi/testing/oho-1591697491529.zip	oho.zip	59351933	application/zip	7bit	612	oho-1591697491529.zip	testing	\N
510	object.pouta.csc.fi/testing/pythonmasterpaivitetty-1591698145798.zip	python-master-paivitetty.zip	39804110	application/zip	7bit	613	pythonmasterpaivitetty-1591698145798.zip	testing	\N
511	object.pouta.csc.fi/testing/pythonsvmasterpaivitetty-1591698280018.zip	python_sv-master-paivitetty.zip	39804049	application/zip	7bit	614	pythonsvmasterpaivitetty-1591698280018.zip	testing	\N
512	https://testing.object.pouta.csc.fi/screenshotfrom20200603124952-1591698314699.png	screenshot from 2020-06-03 12-49-52.png	106514	image/png	7bit	615	screenshotfrom20200603124952-1591698314699.png	testing	\N
513	object.pouta.csc.fi/testing/pythonsvmasterpaivitetty-1591698516612.zip	python_sv-master-paivitetty.zip	39804049	application/zip	7bit	616	pythonsvmasterpaivitetty-1591698516612.zip	testing	\N
514	object.pouta.csc.fi/testing/pythonsvmasterpaivitetty-1591701951179.zip	python_sv-master-paivitetty.zip	39804049	application/zip	7bit	617	pythonsvmasterpaivitetty-1591701951179.zip	testing	\N
515	object.pouta.csc.fi/testing/pythonsvmasterpaivitetty-1591702087770.zip	python_sv-master-paivitetty.zip	39804049	application/zip	7bit	618	pythonsvmasterpaivitetty-1591702087770.zip	testing	\N
516	https://testing.object.pouta.csc.fi/screenshotfrom20200603125002-1591702215152.png	screenshot from 2020-06-03 12-50-02.png	48265	image/png	7bit	619	screenshotfrom20200603125002-1591702215152.png	testing	\N
517	object.pouta.csc.fi/testing/pythonsvmasterpaivitetty-1591702295670.zip	python_sv-master-paivitetty.zip	39804049	application/zip	7bit	620	pythonsvmasterpaivitetty-1591702295670.zip	testing	\N
518	https://testing.object.pouta.csc.fi/kuinkatehdavoimiaoppimateriaaleja-1591781938626.pdf	kuinka tehdä avoimia oppimateriaaleja.pdf	79461	application/pdf	7bit	621	kuinkatehdavoimiaoppimateriaaleja-1591781938626.pdf	testing	\N
519	https://testing.object.pouta.csc.fi/skrivappnalrresurser-1591781938932.png	skriva öppna lärresurser.png	297308	image/png	7bit	622	skrivappnalrresurser-1591781938932.png	testing	\N
520	https://testing.object.pouta.csc.fi/kuinkatehdavoimiaoppimateriaaleja-1591782469927.pdf	kuinka tehdä avoimia oppimateriaaleja.pdf	79461	application/pdf	7bit	623	kuinkatehdavoimiaoppimateriaaleja-1591782469927.pdf	testing	\N
521	https://testing.object.pouta.csc.fi/skrivappnalrresurser-1591782469947.png	skriva öppna lärresurser.png	297308	image/png	7bit	624	skrivappnalrresurser-1591782469947.png	testing	\N
523	https://testing.object.pouta.csc.fi/kuinkatehdavoimiaoppimateriaaleja-1591871016178.pdf	kuinka tehdä avoimia oppimateriaaleja.pdf	79461	application/pdf	7bit	626	kuinkatehdavoimiaoppimateriaaleja-1591871016178.pdf	testing	\N
524	object.pouta.csc.fi/testing/pythonmasterpaivitetty-1592805294204.zip	python-master-paivitetty.zip	39804110	application/zip	7bit	627	pythonmasterpaivitetty-1592805294204.zip	testing	\N
525	object.pouta.csc.fi/testing/pythonsvmasterpaivitetty-1592805294354.zip	python_sv-master-paivitetty.zip	39804049	application/zip	7bit	629	pythonsvmasterpaivitetty-1592805294354.zip	testing	\N
526	object.pouta.csc.fi/testing/pythonenmasterpaivitetty-1592805294426.zip	python_en-master-paivitetty.zip	39803114	application/zip	7bit	628	pythonenmasterpaivitetty-1592805294426.zip	testing	\N
527	https://testing.object.pouta.csc.fi/zipkuvista-1592805914069.zip	zip_kuvista.zip	592885	application/zip	7bit	630	zipkuvista-1592805914069.zip	testing	\N
528	object.pouta.csc.fi/testing/oho-1592812733316.zip	oho.zip	59351933	application/zip	7bit	631	oho-1592812733316.zip	testing	\N
529	https://testing.object.pouta.csc.fi/bpodcastdigitallearningmaterialsandtheiruseinstudyingandteachingtext-1592904992212.pdf	b podcast  digital learning materials and their use in studying and  teaching text .pdf	60441	application/pdf	7bit	632	bpodcastdigitallearningmaterialsandtheiruseinstudyingandteachingtext-1592904992212.pdf	testing	\N
530	object.pouta.csc.fi/testing/apodcastdigitallearningmaterialanditsuseinstudyingandteaching-1592904992078.m4a	a podcast digital learning material and its use in studying and teaching.m4a	12541954	audio/mp4	7bit	633	apodcastdigitallearningmaterialanditsuseinstudyingandteaching-1592904992078.m4a	testing	\N
532	https://testing.object.pouta.csc.fi/kuinkatehdavoimiaoppimateriaaleja-1593065024312.pdf	kuinka tehdä avoimia oppimateriaaleja.pdf	79461	application/pdf	7bit	635	kuinkatehdavoimiaoppimateriaaleja-1593065024312.pdf	testing	\N
534	https://testing.object.pouta.csc.fi/kuinkatehdavoimiaoppimateriaaleja-1593065476816.pdf	kuinka tehdä avoimia oppimateriaaleja.pdf	79461	application/pdf	7bit	637	kuinkatehdavoimiaoppimateriaaleja-1593065476816.pdf	testing	\N
535	https://testing.object.pouta.csc.fi/kuinkatehdavoimiaoppimateriaaleja-1593501834775.pdf	kuinka tehdä avoimia oppimateriaaleja.pdf	79461	application/pdf	7bit	638	kuinkatehdavoimiaoppimateriaaleja-1593501834775.pdf	testing	\N
537	https://testing.object.pouta.csc.fi/aodasadoaadodaadadpladsadasdasf-1593763832433.pdf	a_o_dasa_d_o_aa_do_da_adadpl_a_._dsadas_dasf---.pdf	672892	application/pdf	7bit	640	aodasadoaadodaadadpladsadasdasf-1593763832433.pdf	testing	\N
538	https://testing.object.pouta.csc.fi/aodasadoaadodaadadpladsadasdasf-1593771462602.pdf	aodasad_oaadoda_adadpl_a._dsadas_dasf-.pdf	672892	application/pdf	7bit	641	aodasadoaadodaadadpladsadasdasf-1593771462602.pdf	testing	\N
539	https://testing.object.pouta.csc.fi/aodasadoaadodaadadpladsadasdasf-1593772611172.pdf	aodasad_oaadoda_adadpl_a._dsadas_dasf-.pdf	672892	application/pdf	7bit	642	aodasadoaadodaadadpladsadasdasf-1593772611172.pdf	testing	\N
540	https://testing.object.pouta.csc.fi/kuinkatehdaavoimiaoppimateriaaleja-1593774465028.pdf	kuinka_tehda_avoimia_oppimateriaaleja.pdf	79461	application/pdf	7bit	643	kuinkatehdaavoimiaoppimateriaaleja-1593774465028.pdf	testing	\N
542	https://testing.object.pouta.csc.fi/ilonjaonnenpaiva-1593774981663.jpg	ilon-ja-onnen-paiva.jpg	56624	image/jpeg	7bit	645	ilonjaonnenpaiva-1593774981663.jpg	testing	\N
543	https://testing.object.pouta.csc.fi/nainesiinnytverkossavaarallaidentiteeltilla-1593775674385.txt	nain_esiinnyt_verkossa_vaaralla_identiteeltilla.txt	0	text/plain	7bit	646	nainesiinnytverkossavaarallaidentiteeltilla-1593775674385.txt	testing	\N
544	https://testing.object.pouta.csc.fi/eettinenhakkerointi-1593776461511.txt	eettinen-hakkerointi.txt	0	text/plain	7bit	647	eettinenhakkerointi-1593776461511.txt	testing	\N
545	https://testing.object.pouta.csc.fi/odavaruus-1594196292602.pdf	od_avaruus.pdf	672892	application/pdf	7bit	649	odavaruus-1594196292602.pdf	testing	\N
546	object.pouta.csc.fi/testing/kirjathtijengi56harjoituskirja-1594291121187.pdf	kirja-thtijengi-5-6-harjoituskirja.pdf	109426080	application/pdf	7bit	650	kirjathtijengi56harjoituskirja-1594291121187.pdf	testing	\N
547	object.pouta.csc.fi/testing/lahioikeudet-1594811413461.mp4	lahioikeudet.mp4	21865195	video/mp4	7bit	653	lahioikeudet-1594811413461.mp4	testing	\N
548	https://testing.object.pouta.csc.fi/207350924de036d400b-1594968729986.jpg	20735092_4de036d400_b.jpg	178811	image/jpeg	7bit	654	207350924de036d400b-1594968729986.jpg	testing	\N
549	https://testing.object.pouta.csc.fi/cinfografdigitallearningmaterialsinstudingandteaching-1595578292499.pdf	c_infograf_digital_learning_materials_in_studing_and_teaching.pdf	256965	application/pdf	7bit	655	cinfografdigitallearningmaterialsinstudingandteaching-1595578292499.pdf	testing	\N
550	https://testing.object.pouta.csc.fi/kuvakaappaus20200623124608-1595836938380.png	kuvakaappaus_-_2020-06-23_12-46-08.png	282946	image/png	7bit	659	kuvakaappaus20200623124608-1595836938380.png	testing	\N
551	https://testing.object.pouta.csc.fi/kuvakaappaus20200623124608-1595836977190.png	kuvakaappaus_-_2020-06-23_12-46-08.png	282946	image/png	7bit	660	kuvakaappaus20200623124608-1595836977190.png	testing	\N
552	object.pouta.csc.fi/testing/lahioikeudet-1595934129796.mp4	lahioikeudet.mp4	21865195	video/mp4	7bit	661	lahioikeudet-1595934129796.mp4	testing	\N
553	https://testing.object.pouta.csc.fi/testeri-1596191558405.txt	testeri.txt	0	text/plain	7bit	663	testeri-1596191558405.txt	testing	\N
554	https://testing.object.pouta.csc.fi/ohjeistusmuokkaamiseen-1596454320049.pdf	ohjeistus_muokkaamiseen.pdf	1560505	application/pdf	7bit	664	ohjeistusmuokkaamiseen-1596454320049.pdf	testing	\N
555	https://testing.object.pouta.csc.fi/ohjeistuskokoelmiin-1596454320046.pdf	ohjeistus_kokoelmiin.pdf	1716095	application/pdf	7bit	665	ohjeistuskokoelmiin-1596454320046.pdf	testing	\N
556	https://testing.object.pouta.csc.fi/ohjeistustallentamiseen-1596454319994.pdf	ohjeistus_tallentamiseen.pdf	4275598	application/pdf	7bit	666	ohjeistustallentamiseen-1596454319994.pdf	testing	\N
533	https://testing.object.pouta.csc.fi/skrivappnalrresurer-1593065476834.docx	skriva öppna lärresurer.docx	11424	application/vnd.openxmlformats-officedocument.wordprocessingml.document	7bit	636	skrivappnalrresurer-1593065476834.docx	testing	skrivappnalrresurer-1593065476834.pdf
536	https://testing.object.pouta.csc.fi/skrivappnalrresurer-1593584893695.docx	skriva öppna lärresurer.docx	11424	application/vnd.openxmlformats-officedocument.wordprocessingml.document	7bit	639	skrivappnalrresurer-1593584893695.docx	testing	skrivappnalrresurer-1593584893695.pdf
541	https://testing.object.pouta.csc.fi/skrivaoppnalarresurer-1593774465085.docx	skriva_oppna_larresurer.docx	11424	application/vnd.openxmlformats-officedocument.wordprocessingml.document	7bit	644	skrivaoppnalarresurer-1593774465085.docx	testing	skrivaoppnalarresurer-1593774465085.pdf
557	object.pouta.csc.fi/testing/ohjevideooppimateriaalientallennukseen-1596454319822.mp4	ohjevideo_oppimateriaalien_tallennukseen.mp4	53380588	video/mp4	7bit	667	ohjevideooppimateriaalientallennukseen-1596454319822.mp4	testing	\N
558	https://testing.object.pouta.csc.fi/ohjeistustallentamiseen-1596455160855.pdf	ohjeistus_tallentamiseen.pdf	4334202	application/pdf	7bit	668	ohjeistustallentamiseen-1596455160855.pdf	testing	\N
559	https://testing.object.pouta.csc.fi/ohjeistusarvioimiseen-1596520406352.pdf	ohjeistus_arvioimiseen.pdf	1238783	application/pdf	7bit	669	ohjeistusarvioimiseen-1596520406352.pdf	testing	\N
560	https://testing.object.pouta.csc.fi/ohjeistusmuokkaamiseen-1596520406347.pdf	ohjeistus_muokkaamiseen.pdf	1560633	application/pdf	7bit	670	ohjeistusmuokkaamiseen-1596520406347.pdf	testing	\N
561	https://testing.object.pouta.csc.fi/odavaruus-1596523903203.pdf	od_avaruus.pdf	672892	application/pdf	7bit	671	odavaruus-1596523903203.pdf	testing	\N
562	https://testing.object.pouta.csc.fi/odavaruus-1596524276813.pdf	od_avaruus.pdf	672892	application/pdf	7bit	672	odavaruus-1596524276813.pdf	testing	\N
563	https://testing.object.pouta.csc.fi/kuvakaappaus20200804120325-1596693788333.png	kuvakaappaus_-_2020-08-04_12-03-25.png	274953	image/png	7bit	674	kuvakaappaus20200804120325-1596693788333.png	testing	\N
564	object.pouta.csc.fi/testing/ymparisto-1596699471228.mp4	ymparisto.mp4	27652921	video/mp4	7bit	675	ymparisto-1596699471228.mp4	testing	\N
568	https://testing.object.pouta.csc.fi/linnut-1597733424109.txt	linnut.txt	0	text/plain	7bit	680	linnut-1597733424109.txt	testing	\N
569	https://testing.object.pouta.csc.fi/blackbird-1597734453028.mp3	blackbird.mp3	46539	audio/mpeg	7bit	681	blackbird-1597734453028.mp3	testing	\N
570	https://testing.object.pouta.csc.fi/blackbird-1597734693585.mp3	blackbird.mp3	46539	audio/mpeg	7bit	682	blackbird-1597734693585.mp3	testing	\N
571	https://testing.object.pouta.csc.fi/twitteravatar-1598262739122.png	twitter_avatar.png	3572	image/png	7bit	684	twitteravatar-1598262739122.png	testing	\N
572	https://testing.object.pouta.csc.fi/twitteravatar-1598262739114.png	twitter_avatar.png	3572	image/png	7bit	683	twitteravatar-1598262739114.png	testing	\N
573	https://testing.object.pouta.csc.fi/kuvakaappaus20200827122417-1598599925814.png	kuvakaappaus_-_2020-08-27_12-24-17.png	86065	image/png	7bit	685	kuvakaappaus20200827122417-1598599925814.png	testing	\N
574	https://testing.object.pouta.csc.fi/odavaruus-1598604521941.pdf	od_avaruus.pdf	672892	application/pdf	7bit	686	odavaruus-1598604521941.pdf	testing	\N
575	object.pouta.csc.fi/testing/lahioikeudet-1598604521247.mp4	lahioikeudet.mp4	21865195	video/mp4	7bit	687	lahioikeudet-1598604521247.mp4	testing	\N
576	object.pouta.csc.fi/testing/avoinjulkaiseminen-1598606117639.mp4	avoinjulkaiseminen.mp4	220988631	video/mp4	7bit	688	avoinjulkaiseminen-1598606117639.mp4	testing	\N
577	https://testing.object.pouta.csc.fi/avoimetoppimateriaalitvideo-1598606812184.mp4	avoimet_oppimateriaalit_video.mp4	267768	video/mp4	7bit	689	avoimetoppimateriaalitvideo-1598606812184.mp4	testing	\N
578	object.pouta.csc.fi/testing/lahioikeudet-1598607291044.mp4	lahioikeudet.mp4	21865195	video/mp4	7bit	690	lahioikeudet-1598607291044.mp4	testing	\N
579	object.pouta.csc.fi/testing/lahioikeudet-1598608809198.mp4	lahioikeudet.mp4	21865195	video/mp4	7bit	691	lahioikeudet-1598608809198.mp4	testing	\N
580	https://testing.object.pouta.csc.fi/odavaruus1-1598609025123.pdf	od_avaruus_1.pdf	672892	application/pdf	7bit	692	odavaruus1-1598609025123.pdf	testing	\N
581	object.pouta.csc.fi/testing/avoinjulkaiseminen-1598609439917.mp4	avoinjulkaiseminen.mp4	220988631	video/mp4	7bit	693	avoinjulkaiseminen-1598609439917.mp4	testing	\N
583	https://testing.object.pouta.csc.fi/avoimetoppimateriaalitvideo-1598609775209.mp4	avoimet_oppimateriaalit_video.mp4	267768	video/mp4	7bit	695	avoimetoppimateriaalitvideo-1598609775209.mp4	testing	\N
584	https://testing.object.pouta.csc.fi/kokeiluvideo-1598609893463.mp4	kokeiluvideo.mp4	755107	video/mp4	7bit	696	kokeiluvideo-1598609893463.mp4	testing	\N
585	https://testing.object.pouta.csc.fi/kokeiluvideo-1598610019835.mp4	kokeiluvideo.mp4	755107	video/mp4	7bit	697	kokeiluvideo-1598610019835.mp4	testing	\N
586	https://testing.object.pouta.csc.fi/kuvakaappaus20200827122417-1598610073898.png	kuvakaappaus_-_2020-08-27_12-24-17.png	86065	image/png	7bit	698	kuvakaappaus20200827122417-1598610073898.png	testing	\N
587	https://testing.object.pouta.csc.fi/kokeiluvideo-1598610189196.mp4	kokeiluvideo.mp4	755107	video/mp4	7bit	700	kokeiluvideo-1598610189196.mp4	testing	\N
588	https://testing.object.pouta.csc.fi/kokeiluvideo-1598610228958.mp4	kokeiluvideo.mp4	755107	video/mp4	7bit	701	kokeiluvideo-1598610228958.mp4	testing	\N
589	https://testing.object.pouta.csc.fi/kokeiluvideo-1598610280070.mp4	kokeiluvideo.mp4	755107	video/mp4	7bit	704	kokeiluvideo-1598610280070.mp4	testing	\N
591	https://testing.object.pouta.csc.fi/ymmarsinkokaikenoertesti-1599119092593.h5p	ymmarsinko_kaiken_oer_testi.h5p	3008808	application/octet-stream	7bit	709	ymmarsinkokaikenoertesti-1599119092593.h5p	testing	\N
592	https://testing.object.pouta.csc.fi/pdfsample-1599127789244.pdf	pdf-sample.pdf	7945	application/pdf	7bit	710	pdfsample-1599127789244.pdf	testing	\N
566	https://testing.object.pouta.csc.fi/nainteetavoimiaoppimateriaaleja-1597043761439.pptx	nain_teet_avoimia_oppimateriaaleja.pptx	85367	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	677	nainteetavoimiaoppimateriaaleja-1597043761439.pptx	testing	nainteetavoimiaoppimateriaaleja-1597043761439.pdf
567	https://testing.object.pouta.csc.fi/skrivaoppnalarresurser-1597043761513.pptx	skriva_oppna_larresurser.pptx	85364	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	679	skrivaoppnalarresurser-1597043761513.pptx	testing	skrivaoppnalarresurser-1597043761513.pdf
582	https://testing.object.pouta.csc.fi/nainteetavoimiaoppimateriaaleja-1598609775131.pptx	nain_teet_avoimia_oppimateriaaleja.pptx	85367	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	694	nainteetavoimiaoppimateriaaleja-1598609775131.pptx	testing	nainteetavoimiaoppimateriaaleja-1598609775131.pdf
593	https://testing.object.pouta.csc.fi/kuvakaappaus20200903124758-1599202198800.png	kuvakaappaus_-_2020-09-03_12-47-58.png	190816	image/png	7bit	711	kuvakaappaus20200903124758-1599202198800.png	testing	\N
594	https://testing.object.pouta.csc.fi/opettelesuuntiajapaikkojasuomeksiimagepairing-1599721410716.h5p	opettele-suuntia-ja-paikkoja-suomeksi-image-pairing.h5p	979988	application/octet-stream	7bit	712	opettelesuuntiajapaikkojasuomeksiimagepairing-1599721410716.h5p	testing	\N
595	object.pouta.csc.fi/testing/harjoitus1verbienrektioista1247-1599722914525.h5p	harjoitus-1-verbien-rektioista-1247.h5p	6214702	application/octet-stream	7bit	713	harjoitus1verbienrektioista1247-1599722914525.h5p	testing	\N
596	https://testing.object.pouta.csc.fi/kertaustehtavainfinitiiveistapartisiipeistajalauseenvastikkeista1449-1599723129532.h5p	kertaustehtava-infinitiiveista-partisiipeista-ja-lauseenvastikkeista-1449.h5p	714200	application/octet-stream	7bit	714	kertaustehtavainfinitiiveistapartisiipeistajalauseenvastikkeista1449-1599723129532.h5p	testing	\N
597	https://testing.object.pouta.csc.fi/runojanovellianalyysitermisto1224-1599723130033.h5p	runo-ja-novellianalyysitermisto-1224.h5p	700035	application/octet-stream	7bit	715	runojanovellianalyysitermisto1224-1599723130033.h5p	testing	\N
598	https://testing.object.pouta.csc.fi/termejanovellinanalysoimiseen1226-1599723129789.h5p	termeja-novellin-analysoimiseen-1226.h5p	699843	application/octet-stream	7bit	716	termejanovellinanalysoimiseen1226-1599723129789.h5p	testing	\N
599	https://testing.object.pouta.csc.fi/kertaustehtavavapartisiipista1450-1599723129808.h5p	kertaustehtava-va-partisiipista-1450.h5p	713128	application/octet-stream	7bit	717	kertaustehtavavapartisiipista1450-1599723129808.h5p	testing	\N
600	https://testing.object.pouta.csc.fi/harjoitustupartisiipista1489-1599723129837.h5p	harjoitus-tu-partisiipista-1489.h5p	713007	application/octet-stream	7bit	718	harjoitustupartisiipista1489-1599723129837.h5p	testing	\N
601	object.pouta.csc.fi/testing/harjoitus1verbienastevaihtelusta21468-1599723129741.h5p	harjoitus-1-verbien-astevaihtelusta-2-1468.h5p	8340518	application/octet-stream	7bit	719	harjoitus1verbienastevaihtelusta21468-1599723129741.h5p	testing	\N
602	https://testing.object.pouta.csc.fi/harjoitus2kertovistalauseenvastikkeista1251-1599723461553.h5p	harjoitus-2-kertovista-lauseenvastikkeista-1251.h5p	713095	application/octet-stream	7bit	720	harjoitus2kertovistalauseenvastikkeista1251-1599723461553.h5p	testing	\N
603	https://testing.object.pouta.csc.fi/harjoitus1verbienastevaihtelusta1267-1599723462066.h5p	harjoitus-1-verbien-astevaihtelusta-1267.h5p	713338	application/octet-stream	7bit	721	harjoitus1verbienastevaihtelusta1267-1599723462066.h5p	testing	\N
604	https://testing.object.pouta.csc.fi/harjoitus1verbienrektioistajaobjektista1261-1599723461886.h5p	harjoitus-1-verbien-rektioista-ja-objektista-1261.h5p	715076	application/octet-stream	7bit	722	harjoitus1verbienrektioistajaobjektista1261-1599723461886.h5p	testing	\N
605	https://testing.object.pouta.csc.fi/harjoitustemporaalirakenteista1233-1599723461935.h5p	harjoitus-temporaalirakenteista-1233.h5p	713002	application/octet-stream	7bit	723	harjoitustemporaalirakenteista1233-1599723461935.h5p	testing	\N
606	https://testing.object.pouta.csc.fi/harjoitus2runoanalyysinkeskeisistatermeista1248-1599723461811.h5p	harjoitus-2-runoanalyysin-keskeisista-termeista-1248.h5p	849024	application/octet-stream	7bit	724	harjoitus2runoanalyysinkeskeisistatermeista1248-1599723461811.h5p	testing	\N
607	https://testing.object.pouta.csc.fi/harjoitus1kertovistalauseenvastikkeista1250-1599723462000.h5p	harjoitus-1-kertovista-lauseenvastikkeista-1250.h5p	713085	application/octet-stream	7bit	725	harjoitus1kertovistalauseenvastikkeista1250-1599723462000.h5p	testing	\N
608	https://testing.object.pouta.csc.fi/harjoitusnovellianalyysinkeskeisistatermeista21228-1599723462872.h5p	harjoitus-novellianalyysin-keskeisista-termeista-2-1228.h5p	806609	application/octet-stream	7bit	726	harjoitusnovellianalyysinkeskeisistatermeista21228-1599723462872.h5p	testing	\N
609	https://testing.object.pouta.csc.fi/verbienrektioita1253-1599723463689.h5p	verbien-rektioita-1253.h5p	700038	application/octet-stream	7bit	727	verbienrektioita1253-1599723463689.h5p	testing	\N
610	https://testing.object.pouta.csc.fi/harjoitusrunoanalyysinkeskeisistatermeista12251-1599723463613.h5p	harjoitus-runoanalyysin-keskeisista-termeista-1225_1.h5p	1559209	application/octet-stream	7bit	728	harjoitusrunoanalyysinkeskeisistatermeista12251-1599723463613.h5p	testing	\N
611	https://testing.object.pouta.csc.fi/harjoitusnominientaivutuksesta1487-1599723463541.h5p	harjoitus-nominien-taivutuksesta-1487.h5p	5120792	application/octet-stream	7bit	729	harjoitusnominientaivutuksesta1487-1599723463541.h5p	testing	\N
612	https://testing.object.pouta.csc.fi/coursepresentation2121180-1599723806680.h5p	course-presentation-21-21180.h5p	4698533	application/octet-stream	7bit	730	coursepresentation2121180-1599723806680.h5p	testing	\N
613	https://testing.object.pouta.csc.fi/interactivevideo2618-1599723806903.h5p	interactive-video-2-618.h5p	3272065	application/octet-stream	7bit	731	interactivevideo2618-1599723806903.h5p	testing	\N
614	https://testing.object.pouta.csc.fi/chart7143-1599724087903.h5p	chart-7143.h5p	114324	application/octet-stream	7bit	732	chart7143-1599724087903.h5p	testing	\N
615	https://testing.object.pouta.csc.fi/audiorecorder87748022-1599724087667.h5p	audio-recorder-87-748022.h5p	1041716	application/octet-stream	7bit	733	audiorecorder87748022-1599724087667.h5p	testing	\N
616	https://testing.object.pouta.csc.fi/accordion67138-1599724087950.h5p	accordion-6-7138.h5p	544074	application/octet-stream	7bit	734	accordion67138-1599724087950.h5p	testing	\N
617	https://testing.object.pouta.csc.fi/arithmeticquiz2257860-1599724310277.h5p	arithmetic-quiz-22-57860.h5p	779331	application/octet-stream	7bit	736	arithmeticquiz2257860-1599724310277.h5p	testing	\N
618	https://testing.object.pouta.csc.fi/agamotto80158-1599724310032.h5p	agamotto-80158.h5p	1554299	application/octet-stream	7bit	735	agamotto80158-1599724310032.h5p	testing	\N
619	https://testing.object.pouta.csc.fi/collage3065-1599724310297.h5p	collage-3065.h5p	674530	application/octet-stream	7bit	737	collage3065-1599724310297.h5p	testing	\N
620	object.pouta.csc.fi/testing/h5pcolumn34794-1599724310341.h5p	h5p-column-34794.h5p	5598231	application/octet-stream	7bit	738	h5pcolumn34794-1599724310341.h5p	testing	\N
621	https://testing.object.pouta.csc.fi/essay4166755-1599724629741.h5p	essay-4-166755.h5p	700411	application/octet-stream	7bit	740	essay4166755-1599724629741.h5p	testing	\N
622	https://testing.object.pouta.csc.fi/dictation389727-1599724629551.h5p	dictation-389727.h5p	1798321	application/octet-stream	7bit	739	dictation389727-1599724629551.h5p	testing	\N
623	https://testing.object.pouta.csc.fi/documentationtool3022-1599724629800.h5p	documentation-tool-3022.h5p	881728	application/octet-stream	7bit	741	documentationtool3022-1599724629800.h5p	testing	\N
624	https://testing.object.pouta.csc.fi/imagemultiplehotspotquestion65081-1599724629880.h5p	image-multiple-hotspot-question-65081.h5p	773900	application/octet-stream	7bit	742	imagemultiplehotspotquestion65081-1599724629880.h5p	testing	\N
625	https://testing.object.pouta.csc.fi/draganddrop712-1599724629912.h5p	drag-and-drop-712.h5p	1071688	application/octet-stream	7bit	743	draganddrop712-1599724629912.h5p	testing	\N
626	https://testing.object.pouta.csc.fi/findthehotspot3024-1599725120031.h5p	find-the-hotspot-3024.h5p	827817	application/octet-stream	7bit	744	findthehotspot3024-1599725120031.h5p	testing	\N
627	https://testing.object.pouta.csc.fi/iframeembedder621-1599725120164.h5p	iframe-embedder-621.h5p	441537	application/octet-stream	7bit	746	iframeembedder621-1599725120164.h5p	testing	\N
628	https://testing.object.pouta.csc.fi/examplecontentfindthewords557697-1599725120109.h5p	example-content-find-the-words-557697.h5p	632284	application/octet-stream	7bit	745	examplecontentfindthewords557697-1599725120109.h5p	testing	\N
629	https://testing.object.pouta.csc.fi/guesstheanswer2402-1599725120249.h5p	guess-the-answer-2402.h5p	885020	application/octet-stream	7bit	747	guesstheanswer2402-1599725120249.h5p	testing	\N
630	https://testing.object.pouta.csc.fi/imageslider2130336-1599725430419.h5p	image-slider-2-130336.h5p	475405	application/octet-stream	7bit	748	imageslider2130336-1599725430419.h5p	testing	\N
631	https://testing.object.pouta.csc.fi/imagehotspots2825-1599725430290.h5p	image-hotspots-2-825.h5p	869738	application/octet-stream	7bit	749	imagehotspots2825-1599725430290.h5p	testing	\N
632	https://testing.object.pouta.csc.fi/imagesequencing3110117-1599725430382.h5p	image-sequencing-3-110117.h5p	910807	application/octet-stream	7bit	750	imagesequencing3110117-1599725430382.h5p	testing	\N
633	https://testing.object.pouta.csc.fi/imagejuxtaposition65047-1599725430366.h5p	image-juxtaposition-65047.h5p	2210203	application/octet-stream	7bit	751	imagejuxtaposition65047-1599725430366.h5p	testing	\N
634	object.pouta.csc.fi/testing/examplecontentimagepairing2233382-1599725430409.h5p	example-content-image-pairing-2-233382.h5p	9920881	application/octet-stream	7bit	752	examplecontentimagepairing2233382-1599725430409.h5p	testing	\N
635	https://testing.object.pouta.csc.fi/markthewords21408-1599725843686.h5p	mark-the-words-2-1408.h5p	705800	application/octet-stream	7bit	753	markthewords21408-1599725843686.h5p	testing	\N
636	https://testing.object.pouta.csc.fi/multiplechoice713-1599725843656.h5p	multiple-choice-713.h5p	1567921	application/octet-stream	7bit	754	multiplechoice713-1599725843656.h5p	testing	\N
637	https://testing.object.pouta.csc.fi/memorygame5708-1599725843792.h5p	memory-game-5-708.h5p	1334340	application/octet-stream	7bit	755	memorygame5708-1599725843792.h5p	testing	\N
638	https://testing.object.pouta.csc.fi/impressivepresentation7141-1599725843479.h5p	impressive-presentation-7141.h5p	2698150	application/octet-stream	7bit	756	impressivepresentation7141-1599725843479.h5p	testing	\N
639	object.pouta.csc.fi/testing/berries28441940-1599725843679.h5p	berries-28-441940.h5p	8844747	application/octet-stream	7bit	757	berries28441940-1599725843679.h5p	testing	\N
640	https://testing.object.pouta.csc.fi/questionnaire430615-1599726285915.h5p	questionnaire-4-30615.h5p	630029	application/octet-stream	7bit	758	questionnaire430615-1599726285915.h5p	testing	\N
641	https://testing.object.pouta.csc.fi/speakthewords73595-1599726286086.h5p	speak-the-words-73595.h5p	743967	application/octet-stream	7bit	759	speakthewords73595-1599726286086.h5p	testing	\N
642	https://testing.object.pouta.csc.fi/personalityquiz21254-1599726285796.h5p	personality-quiz-21254.h5p	1498492	application/octet-stream	7bit	760	personalityquiz21254-1599726285796.h5p	testing	\N
643	https://testing.object.pouta.csc.fi/singlechoiceset1515-1599726286022.h5p	single-choice-set-1515.h5p	815018	application/octet-stream	7bit	761	singlechoiceset1515-1599726286022.h5p	testing	\N
644	https://testing.object.pouta.csc.fi/questionset616-1599726285986.h5p	question-set-616.h5p	3096447	application/octet-stream	7bit	762	questionset616-1599726285986.h5p	testing	\N
645	https://testing.object.pouta.csc.fi/timeline3716-1599726700500.h5p	timeline-3-716.h5p	367164	application/octet-stream	7bit	763	timeline3716-1599726700500.h5p	testing	\N
646	https://testing.object.pouta.csc.fi/speakthewordssetexample120784-1599726700387.h5p	speak-the-words-set-example-120784.h5p	1015909	application/octet-stream	7bit	764	speakthewordssetexample120784-1599726700387.h5p	testing	\N
647	https://testing.object.pouta.csc.fi/summary714-1599726700578.h5p	summary-714.h5p	705700	application/octet-stream	7bit	765	summary714-1599726700578.h5p	testing	\N
648	https://testing.object.pouta.csc.fi/advancedblanksexample1503253-1599726701162.h5p	advanced-blanks-example-1-503253.h5p	739100	application/octet-stream	7bit	766	advancedblanksexample1503253-1599726701162.h5p	testing	\N
649	https://testing.object.pouta.csc.fi/truefalsequestion34806-1599726700651.h5p	true-false-question-34806.h5p	1694082	application/octet-stream	7bit	767	truefalsequestion34806-1599726700651.h5p	testing	\N
650	object.pouta.csc.fi/testing/examplecontentvirtualtour360441814-1599726700656.h5p	example-content-virtual-tour-360-441814.h5p	11974603	application/octet-stream	7bit	768	examplecontentvirtualtour360441814-1599726700656.h5p	testing	\N
651	object.pouta.csc.fi/testing/h5pharjoituksetsuulliseenkielitaitoon-1599726980503.zip	h5p-harjoitukset_suulliseen_kielitaitoon.zip	6462385	application/zip	7bit	769	h5pharjoituksetsuulliseenkielitaitoon-1599726980503.zip	testing	\N
652	object.pouta.csc.fi/testing/h5pharjoituksetsuulliseenkielitaitoonkopio-1599726980812.h5p	h5p-harjoitukset_suulliseen_kielitaitoon_kopio.h5p	6462385	application/octet-stream	7bit	770	h5pharjoituksetsuulliseenkielitaitoonkopio-1599726980812.h5p	testing	\N
653	https://testing.object.pouta.csc.fi/pdfsample-1599805604832.pdf	pdf-sample.pdf	7945	application/pdf	7bit	771	pdfsample-1599805604832.pdf	testing	\N
654	https://testing.object.pouta.csc.fi/kuvakaappaus20200911093839-1599807871282.png	kuvakaappaus_-_2020-09-11_09-38-39.png	85053	image/png	7bit	772	kuvakaappaus20200911093839-1599807871282.png	testing	\N
655	https://testing.object.pouta.csc.fi/kuvakaappaus20200911093839-1599808067066.png	kuvakaappaus_-_2020-09-11_09-38-39.png	85053	image/png	7bit	773	kuvakaappaus20200911093839-1599808067066.png	testing	\N
656	https://testing.object.pouta.csc.fi/pdfsample-1599812331498.pdf	pdf-sample.pdf	7945	application/pdf	7bit	774	pdfsample-1599812331498.pdf	testing	\N
657	https://testing.object.pouta.csc.fi/zoo999test2-1600165275056.png	zoo999test2.png	11760	image/png	7bit	776	zoo999test2-1600165275056.png	testing	\N
658	https://testing.object.pouta.csc.fi/pdfsample-1600169006622.pdf	pdf-sample.pdf	7945	application/pdf	7bit	777	pdfsample-1600169006622.pdf	testing	\N
659	https://testing.object.pouta.csc.fi/pdfsample-1600240418749.pdf	pdf-sample.pdf	7945	application/pdf	7bit	778	pdfsample-1600240418749.pdf	testing	\N
660	https://testing.object.pouta.csc.fi/zoo999test3-1600323659391.png	zoo999test3.png	11760	image/png	7bit	779	zoo999test3-1600323659391.png	testing	\N
661	object.pouta.csc.fi/testing/valjamarkotilaesittely1201111-1600349131304.zip	valja_marko_tilaesittely_120111_1.zip	19406304	application/zip	7bit	781	valjamarkotilaesittely1201111-1600349131304.zip	testing	\N
662	object.pouta.csc.fi/testing/testi-1600349506956.zip	testi.zip	19372156	application/zip	7bit	782	testi-1600349506956.zip	testing	\N
663	https://testing.object.pouta.csc.fi/kuvakaappaus20200922093458-1600777552759.png	kuvakaappaus_-_2020-09-22_09-34-58.png	7237	image/png	7bit	783	kuvakaappaus20200922093458-1600777552759.png	testing	\N
664	https://testing.object.pouta.csc.fi/pdfsample-1600845344585.pdf	pdf-sample.pdf	7945	application/pdf	7bit	784	pdfsample-1600845344585.pdf	testing	\N
665	https://testing.object.pouta.csc.fi/lyhyt-1600929454645.mp4	lyhyt.mp4	630200	video/mp4	7bit	785	lyhyt-1600929454645.mp4	testing	\N
666	object.pouta.csc.fi/testing/nimeton-1600945704937.mp4	nimeton.mp4	407817578	video/mp4	7bit	786	nimeton-1600945704937.mp4	testing	\N
667	https://testing.object.pouta.csc.fi/actnowboarda3fismalluusi-1601278370582.pdf	actnowboard_a3_fi_small_uusi.pdf	2520459	application/pdf	7bit	787	actnowboarda3fismalluusi-1601278370582.pdf	testing	\N
668	https://testing.object.pouta.csc.fi/actnowohjeetfinose-1601278372647.pdf	actnow_ohjeet_fi_no_se.pdf	137808	application/pdf	7bit	790	actnowohjeetfinose-1601278372647.pdf	testing	\N
669	https://testing.object.pouta.csc.fi/pelikortitactnow-1601278372692.pdf	pelikortit_actnow.pdf	143552	application/pdf	7bit	791	pelikortitactnow-1601278372692.pdf	testing	\N
670	https://testing.object.pouta.csc.fi/actnowspelkort-1601278372917.pdf	actnow_spelkort.pdf	30767	application/pdf	7bit	792	actnowspelkort-1601278372917.pdf	testing	\N
671	https://testing.object.pouta.csc.fi/actnowinsturktionernasefino-1601278372827.pdf	actnow_insturktionerna_se_fi_no.pdf	137808	application/pdf	7bit	793	actnowinsturktionernasefino-1601278372827.pdf	testing	\N
672	https://testing.object.pouta.csc.fi/actnowboardsvenska-1601278372723.pdf	actnowboard_svenska.pdf	2497297	application/pdf	7bit	794	actnowboardsvenska-1601278372723.pdf	testing	\N
673	https://testing.object.pouta.csc.fi/luokkavaltuustoaloitelomekepohja-1601285150748.pdf	luokkavaltuusto_aloitelomekepohja.pdf	138484	application/pdf	7bit	796	luokkavaltuustoaloitelomekepohja-1601285150748.pdf	testing	\N
674	https://testing.object.pouta.csc.fi/luokkavaltuustopoytakirjalomake-1601285150715.pdf	luokkavaltuusto_poytakirjalomake.pdf	112629	application/pdf	7bit	797	luokkavaltuustopoytakirjalomake-1601285150715.pdf	testing	\N
675	https://testing.object.pouta.csc.fi/luokkavaltuustorviointilomake-1601285151078.pdf	luokkavaltuusto_rviointilomake_.pdf	224447	application/pdf	7bit	798	luokkavaltuustorviointilomake-1601285151078.pdf	testing	\N
676	https://testing.object.pouta.csc.fi/luokkavaltuustoroolikortit-1601285150738.pdf	luokkavaltuusto_roolikortit.pdf	345413	application/pdf	7bit	799	luokkavaltuustoroolikortit-1601285150738.pdf	testing	\N
677	https://testing.object.pouta.csc.fi/luokkavaltuustoharjoituksiavuorovaikutusjayhteistyotaidoista-1601285150625.pdf	luokkavaltuusto_harjoituksia-vuorovaikutus-ja-yhteistyotaidoista.pdf	380077	application/pdf	7bit	800	luokkavaltuustoharjoituksiavuorovaikutusjayhteistyotaidoista-1601285150625.pdf	testing	\N
678	https://testing.object.pouta.csc.fi/luokkavaltuustoopaskouludemokratianedistamiseen-1601285150353.pdf	luokkavaltuusto_opas-kouludemokratian-edistamiseen.pdf	2553637	application/pdf	7bit	801	luokkavaltuustoopaskouludemokratianedistamiseen-1601285150353.pdf	testing	\N
679	https://testing.object.pouta.csc.fi/luokkavaltuustonesittely2020-1601285150848.pdf	luokkavaltuuston-esittely-2020.pdf	4982624	application/pdf	7bit	802	luokkavaltuustonesittely2020-1601285150848.pdf	testing	\N
682	https://testing.object.pouta.csc.fi/autoalaenglanti14102019-1601529234053.docx	autoala_englanti_14.10.2019.docx	227510	application/vnd.openxmlformats-officedocument.wordprocessingml.document	7bit	808	autoalaenglanti14102019-1601529234053.docx	testing	autoalaenglanti14102019-1601529234053.pdf
683	https://testing.object.pouta.csc.fi/s22aineistokirjoittaminen-1601529234153.docx	s22_aineistokirjoittaminen.docx	22585	application/vnd.openxmlformats-officedocument.wordprocessingml.document	7bit	807	s22aineistokirjoittaminen-1601529234153.docx	testing	s22aineistokirjoittaminen-1601529234153.pdf
684	https://testing.object.pouta.csc.fi/puunkaskadikayttoopettajanopas-1601529234142.docx	puun_kaskadikaytto_-_opettajan_opas.docx	166453	application/vnd.openxmlformats-officedocument.wordprocessingml.document	7bit	809	puunkaskadikayttoopettajanopas-1601529234142.docx	testing	puunkaskadikayttoopettajanopas-1601529234142.pdf
685	https://testing.object.pouta.csc.fi/s22suomijasensukukielet-1601529234251.docx	s22_suomi_ja_sen_sukukielet.docx	114415	application/vnd.openxmlformats-officedocument.wordprocessingml.document	7bit	810	s22suomijasensukukielet-1601529234251.docx	testing	s22suomijasensukukielet-1601529234251.pdf
686	https://testing.object.pouta.csc.fi/muokkaus-1601529234237.odt	muokkaus.odt	355276	application/vnd.oasis.opendocument.text	7bit	811	muokkaus-1601529234237.odt	testing	muokkaus-1601529234237.pdf
687	https://testing.object.pouta.csc.fi/puunkaskadikayttoppt-1601529961387.pptx	puun_kaskadikaytto_ppt.pptx	2366426	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	812	puunkaskadikayttoppt-1601529961387.pptx	testing	puunkaskadikayttoppt-1601529961387.pdf
688	https://testing.object.pouta.csc.fi/aoeavoinoppiminenoy-1601529961502.odp	aoe_avoin_oppiminen_oy.odp	2668170	application/vnd.oasis.opendocument.presentation	7bit	813	aoeavoinoppiminenoy-1601529961502.odp	testing	aoeavoinoppiminenoy-1601529961502.pdf
689	object.pouta.csc.fi/testing/aoeavoinoppiminenmarraskuu-1601529961600.ppt	aoe_avoin_oppiminen_marraskuu.ppt	5253120	application/vnd.ms-powerpoint	7bit	814	aoeavoinoppiminenmarraskuu-1601529961600.ppt	testing	aoeavoinoppiminenmarraskuu-1601529961600.pdf
694	https://testing.object.pouta.csc.fi/aoefilogonega-1601894131169.pdf	aoefi_logo_nega.pdf	65588	application/pdf	7bit	819	aoefilogonega-1601894131169.pdf	testing	\N
695	https://testing.object.pouta.csc.fi/examplecontentfindthewords557697-1602138134622.h5p	example-content-find-the-words-557697.h5p	632284	application/octet-stream	7bit	820	examplecontentfindthewords557697-1602138134622.h5p	testing	\N
696	https://testing.object.pouta.csc.fi/img20201006115253-1602566687206.jpg	img_20201006_115253.jpg	4558403	image/jpeg	7bit	821	img20201006115253-1602566687206.jpg	testing	\N
697	https://testing.object.pouta.csc.fi/tuuranasiakirjat-1603187852273.txt	tuuran-asiakirjat.txt	0	text/plain	7bit	822	tuuranasiakirjat-1603187852273.txt	testing	\N
698	https://testing.object.pouta.csc.fi/tuuranasiakirjat-1603188099380.txt	tuuran-asiakirjat.txt	39	text/plain	7bit	823	tuuranasiakirjat-1603188099380.txt	testing	\N
699	https://testing.object.pouta.csc.fi/tuuranasiakirjat-1603188330467.txt	tuuran-asiakirjat.txt	55	text/plain	7bit	824	tuuranasiakirjat-1603188330467.txt	testing	\N
700	https://testing.object.pouta.csc.fi/tuuransalajuoni-1603190521056.pdf	tuuran-salajuoni.pdf	30354	application/pdf	7bit	825	tuuransalajuoni-1603190521056.pdf	testing	\N
701	https://testing.object.pouta.csc.fi/tuuransalajuoni-1603190573478.pdf	tuuran-salajuoni.pdf	30666	application/pdf	7bit	826	tuuransalajuoni-1603190573478.pdf	testing	\N
702	object.pouta.csc.fi/testing/valjamarkoviljelynpaapiirteet1201112-1604301626530.zip	valja_marko_viljelyn_paapiirteet_120111_2.zip	15646112	application/zip	7bit	827	valjamarkoviljelynpaapiirteet1201112-1604301626530.zip	testing	\N
703	object.pouta.csc.fi/testing/valjamarkoviljelynpaapiirteet1201112-1604301811295.zip	valja_marko_viljelyn_paapiirteet_120111_2.zip	15646112	application/zip	7bit	828	valjamarkoviljelynpaapiirteet1201112-1604301811295.zip	testing	\N
704	https://testing.object.pouta.csc.fi/tervetulotoivotuskurssimateriaalinkayttajalle-1604471670201.pdf	tervetulotoivotus_kurssimateriaalin_kayttajalle.pdf	77230	application/pdf	7bit	829	tervetulotoivotuskurssimateriaalinkayttajalle-1604471670201.pdf	testing	\N
705	https://testing.object.pouta.csc.fi/ge1karhusalometodiohjeetkayttajalle-1604471670207.pdf	ge1_karhu-salo-metodi_-_ohjeet_kayttajalle.pdf	365747	application/pdf	7bit	830	ge1karhusalometodiohjeetkayttajalle-1604471670207.pdf	testing	\N
706	https://testing.object.pouta.csc.fi/tuurathe2nd-1604479685148.jpg	tuura-the-2nd.jpg	56624	image/jpeg	7bit	831	tuurathe2nd-1604479685148.jpg	testing	\N
707	https://testing.object.pouta.csc.fi/ge1karhusalometodiohjeetkayttajalle-1604496525114.pdf	ge1_karhu-salo-metodi_-_ohjeet_kayttajalle.pdf	365747	application/pdf	7bit	832	ge1karhusalometodiohjeetkayttajalle-1604496525114.pdf	testing	\N
708	https://testing.object.pouta.csc.fi/ge1karhusalometodiohjeetkayttajalle-1604907987726.pdf	ge1_karhu-salo-metodi_-_ohjeet_kayttajalle.pdf	365747	application/pdf	7bit	833	ge1karhusalometodiohjeetkayttajalle-1604907987726.pdf	testing	\N
709	object.pouta.csc.fi/testing/ge1karhusalometodipakattupienin-1605000075285.zip	ge1_karhu-salo-metodi_pakattu_pienin.zip	51948877	application/zip	7bit	834	ge1karhusalometodipakattupienin-1605000075285.zip	testing	\N
710	https://testing.object.pouta.csc.fi/ge1tulvatjaettava-1605001133088.pdf	ge1_tulvat-jaettava.pdf	1408363	application/pdf	7bit	835	ge1tulvatjaettava-1605001133088.pdf	testing	\N
713	https://testing.object.pouta.csc.fi/kuvakaappaus20201119091253-1606121753835.png	kuvakaappaus_-_2020-11-19_09-12-53.png	57507	image/png	7bit	839	kuvakaappaus20201119091253-1606121753835.png	testing	\N
2	https://testing.object.pouta.csc.fi/6puheentuottoopettajalle-1572589885731.pptx	6_puheentuotto_opettajalle.pptx	280356	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	2	6puheentuottoopettajalle-1572589885731.pptx	testing	6puheentuottoopettajalle-1572589885731.pdf
691	https://testing.object.pouta.csc.fi/muokkaus-1601533844846.doc	muokkaus.doc	355328	application/msword	7bit	816	muokkaus-1601533844846.doc	testing	muokkaus-1601533844846.pdf
9	https://testing.object.pouta.csc.fi/Ninteetavoimiaoppimateriaaleja-1572619122999.pptx	Näin teet avoimia oppimateriaaleja.pptx	85367	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	11	Ninteetavoimiaoppimateriaaleja-1572619122999.pptx	testing	Ninteetavoimiaoppimateriaaleja-1572619122999.pdf
28	object.pouta.csc.fi/testing/Introduktiontillundervisningenirobotik-1572948973331.docx	Introduktion till undervisningen i robotik.docx	8324156	application/vnd.openxmlformats-officedocument.wordprocessingml.document	7bit	30	Introduktiontillundervisningenirobotik-1572948973331.docx	testing	Introduktiontillundervisningenirobotik-1572948973331.pdf
690	https://testing.object.pouta.csc.fi/testi-1601533456721.ods	testi.ods	15292	application/vnd.oasis.opendocument.spreadsheet	7bit	815	testi-1601533456721.ods	testing	testi-1601533456721.pdf
29	https://testing.object.pouta.csc.fi/41EV3nohjelmointisimulaattorissasv-1572948977051.pptx	4.1 EV3_n ohjelmointi simulaattorissa_sv.pptx	4150335	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	31	41EV3nohjelmointisimulaattorissasv-1572948977051.pptx	testing	41EV3nohjelmointisimulaattorissasv-1572948977051.pdf
692	https://testing.object.pouta.csc.fi/muokkaus-1601533844853.rtf	muokkaus.rtf	686263	application/rtf	7bit	817	muokkaus-1601533844853.rtf	testing	muokkaus-1601533844853.pdf
693	https://testing.object.pouta.csc.fi/itkpaivatoppimisanalytiikantyopaja-1601534277265.doc	itk_paivat_oppimisanalytiikan_tyopaja.doc	17408	application/msword	7bit	818	itkpaivatoppimisanalytiikantyopaja-1601534277265.doc	testing	itkpaivatoppimisanalytiikantyopaja-1601534277265.pdf
711	object.pouta.csc.fi/testing/3ge1karttakohteet-1605001156329.pptx	3_ge1_karttakohteet.pptx	35047536	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	836	3ge1karttakohteet-1605001156329.pptx	testing	3ge1karttakohteet-1605001156329.pdf
712	object.pouta.csc.fi/testing/kokonaisuuseksogeenisetprosessit-1605001486828.pptx	kokonaisuus_-_eksogeeniset_prosessit.pptx	108289958	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	837	kokonaisuuseksogeenisetprosessit-1605001486828.pptx	testing	kokonaisuuseksogeenisetprosessit-1605001486828.pdf
3	https://testing.object.pouta.csc.fi/6puheentuottoopettajalle-1572596832062.pptx	6_puheentuotto_opettajalle.pptx	280356	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	3	6puheentuottoopettajalle-1572596832062.pptx	testing	6puheentuottoopettajalle-1572596832062.pdf
732	object.pouta.csc.fi/testing/-1607518237850002_200mb_file	002_200mb_file	209715200	application/octet-stream	7bit	858	-1607518237850002_200mb_file	testing	.pdf
33	object.pouta.csc.fi/testing/Introductiontoteachingrobotics-1572948980701.docx	Introduction to teaching robotics.docx	8225299	application/vnd.openxmlformats-officedocument.wordprocessingml.document	7bit	35	Introductiontoteachingrobotics-1572948980701.docx	testing	Introductiontoteachingrobotics-1572948980701.pdf
39	object.pouta.csc.fi/testing/Introduktiontillundervisningenirobotik-1572949179612.docx	Introduktion till undervisningen i robotik.docx	8324156	application/vnd.openxmlformats-officedocument.wordprocessingml.document	7bit	41	Introduktiontillundervisningenirobotik-1572949179612.docx	testing	Introduktiontillundervisningenirobotik-1572949179612.pdf
66	https://testing.object.pouta.csc.fi/Skrivappnalrresurser-1573464722460.pptx	Skriva öppna lärresurser.pptx	85364	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	68	Skrivappnalrresurser-1573464722460.pptx	testing	Skrivappnalrresurser-1573464722460.pdf
82	https://testing.object.pouta.csc.fi/1mitentuetaanopiskelijoidenyhteisllisyydenkehittymist1-1573563291684.pptx	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1.pptx	287378	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	84	1mitentuetaanopiskelijoidenyhteisllisyydenkehittymist1-1573563291684.pptx	testing	1mitentuetaanopiskelijoidenyhteisllisyydenkehittymist1-1573563291684.pdf
86	object.pouta.csc.fi/testing/Johdatusrobotiikanopettamiseen-1573811438608.docx	Johdatus robotiikan opettamiseen.docx	8172850	application/vnd.openxmlformats-officedocument.wordprocessingml.document	7bit	88	Johdatusrobotiikanopettamiseen-1573811438608.docx	testing	Johdatusrobotiikanopettamiseen-1573811438608.pdf
91	object.pouta.csc.fi/testing/Introduktiontillundervisningenirobotik-1573811440959.docx	Introduktion till undervisningen i robotik.docx	8324156	application/vnd.openxmlformats-officedocument.wordprocessingml.document	7bit	93	Introduktiontillundervisningenirobotik-1573811440959.docx	testing	Introduktiontillundervisningenirobotik-1573811440959.pdf
99	https://testing.object.pouta.csc.fi/1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1574069316983.pptx	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1.pptx	287378	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	101	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1574069316983.pptx	testing	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1574069316983.pdf
107	https://testing.object.pouta.csc.fi/1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1574250307088.pptx	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1.pptx	287378	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	109	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1574250307088.pptx	testing	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1574250307088.pdf
110	https://testing.object.pouta.csc.fi/2mitentuetaanopiskelijoidenyhteisollisyydenkehittymista2-1574251129206.pptx	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2.pptx	288552	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	112	2mitentuetaanopiskelijoidenyhteisollisyydenkehittymista2-1574251129206.pptx	testing	2mitentuetaanopiskelijoidenyhteisollisyydenkehittymista2-1574251129206.pdf
114	https://testing.object.pouta.csc.fi/oppimateriaalivarntotietosuojaselosteluonnosversio1-1574417904639.odt	oppimateriaalivarnto_tietosuojaseloste_luonnos_versio_1.odt	24722	application/vnd.oasis.opendocument.text	7bit	116	oppimateriaalivarntotietosuojaselosteluonnosversio1-1574417904639.odt	testing	oppimateriaalivarntotietosuojaselosteluonnosversio1-1574417904639.pdf
127	https://testing.object.pouta.csc.fi/Ninteetavoimiaoppimateriaaleja-1574670317988.pptx	Näin teet avoimia oppimateriaaleja.pptx	85367	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	129	Ninteetavoimiaoppimateriaaleja-1574670317988.pptx	testing	Ninteetavoimiaoppimateriaaleja-1574670317988.pdf
136	https://testing.object.pouta.csc.fi/7mitenopetetaanopiskelijoitaetsimaanverkossa-1574845641279.pptx	7_miten_opetetaan_opiskelijoita_etsimään_verkossa.pptx	283331	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	139	7mitenopetetaanopiskelijoitaetsimaanverkossa-1574845641279.pptx	testing	7mitenopetetaanopiskelijoitaetsimaanverkossa-1574845641279.pdf
138	https://testing.object.pouta.csc.fi/1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1574846003055.pptx	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1.pptx	287378	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	141	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1574846003055.pptx	testing	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1574846003055.pdf
139	https://testing.object.pouta.csc.fi/1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1574846002990.pptx	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1.pptx	287378	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	142	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1574846002990.pptx	testing	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1574846002990.pdf
149	https://testing.object.pouta.csc.fi/15tekijanoikeudetvirtuaaliluokassamitenohjaanopiskelijoita-1574946130185.pptx	15_tekijänoikeudet_virtuaaliluokassa_miten_ohjaan_opiskelijoita.pptx	290304	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	173	15tekijanoikeudetvirtuaaliluokassamitenohjaanopiskelijoita-1574946130185.pptx	testing	15tekijanoikeudetvirtuaaliluokassamitenohjaanopiskelijoita-1574946130185.pdf
155	https://testing.object.pouta.csc.fi/1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1574946419115.pptx	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1.pptx	287378	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	179	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1574946419115.pptx	testing	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1574946419115.pdf
162	https://testing.object.pouta.csc.fi/2mitentuetaanopiskelijoidenyhteisollisyydenkehittymista2-1574947022152.pptx	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2.pptx	288552	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	186	2mitentuetaanopiskelijoidenyhteisollisyydenkehittymista2-1574947022152.pptx	testing	2mitentuetaanopiskelijoidenyhteisollisyydenkehittymista2-1574947022152.pdf
167	https://testing.object.pouta.csc.fi/1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1575981941028.pptx	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1.pptx	287378	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	193	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1575981941028.pptx	testing	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1575981941028.pdf
733	object.pouta.csc.fi/testing/ge1karhusalometodipakattu-1607585459876.zip	ge1_karhu-salo-metodi_pakattu.zip	1826822784	application/zip	7bit	859	ge1karhusalometodipakattu-1607585459876.zip	testing	\N
190	https://testing.object.pouta.csc.fi/5bKirjainaanneopiskelijalle-1576150190344.pptx	5 b Kirjain_äänne_opiskelijalle.pptx	1252520	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	217	5bKirjainaanneopiskelijalle-1576150190344.pptx	testing	5bKirjainaanneopiskelijalle-1576150190344.pdf
193	https://testing.object.pouta.csc.fi/2mitentuetaanopiskelijoidenyhteisollisyydenkehittymista2-1576150376771.pptx	2_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_2.pptx	288552	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	220	2mitentuetaanopiskelijoidenyhteisollisyydenkehittymista2-1576150376771.pptx	testing	2mitentuetaanopiskelijoidenyhteisollisyydenkehittymista2-1576150376771.pdf
205	https://testing.object.pouta.csc.fi/1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1576158974091.pptx	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1.pptx	287378	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	232	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1576158974091.pptx	testing	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1576158974091.pdf
221	https://testing.object.pouta.csc.fi/9mitenyllapitaamotivaatiooppimiseenkoulupaivanjalkeen-1576576742994.pptx	9_miten_ylläpitää_motivaatio_oppimiseen_koulupäivän_jälkeen.pptx	283402	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	249	9mitenyllapitaamotivaatiooppimiseenkoulupaivanjalkeen-1576576742994.pptx	testing	9mitenyllapitaamotivaatiooppimiseenkoulupaivanjalkeen-1576576742994.pdf
224	https://testing.object.pouta.csc.fi/1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1576576742784.pptx	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1.pptx	287378	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	252	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1576576742784.pptx	testing	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1576576742784.pdf
233	https://testing.object.pouta.csc.fi/7mitenopetetaanopiskelijoitaetsimaanverkossa-1576658706008.pptx	7_miten_opetetaan_opiskelijoita_etsimään_verkossa.pptx	283331	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	261	7mitenopetetaanopiskelijoitaetsimaanverkossa-1576658706008.pptx	testing	7mitenopetetaanopiskelijoitaetsimaanverkossa-1576658706008.pdf
242	https://testing.object.pouta.csc.fi/31Opetukseenjaopiskeluunsoveltuvatlaitteet-1576737754595.docx	3.1 Opetukseen ja opiskeluun soveltuvat laitteet.docx	3122766	application/vnd.openxmlformats-officedocument.wordprocessingml.document	7bit	304	31Opetukseenjaopiskeluunsoveltuvatlaitteet-1576737754595.docx	testing	31Opetukseenjaopiskeluunsoveltuvatlaitteet-1576737754595.pdf
246	https://testing.object.pouta.csc.fi/testdocxmroppone-1576753569568.docx	test-docx-mroppone.docx	11533	application/vnd.openxmlformats-officedocument.wordprocessingml.document	7bit	310	testdocxmroppone-1576753569568.docx	testing	testdocxmroppone-1576753569568.pdf
251	https://testing.object.pouta.csc.fi/testdocxmroppone-1576757576494.docx	test-docx-mroppone.docx	11533	application/vnd.openxmlformats-officedocument.wordprocessingml.document	7bit	316	testdocxmroppone-1576757576494.docx	testing	testdocxmroppone-1576757576494.pdf
254	https://testing.object.pouta.csc.fi/1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1576843299301.pptx	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1.pptx	287378	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	320	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1576843299301.pptx	testing	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1576843299301.pdf
309	https://testing.object.pouta.csc.fi/Kuinkatehdavoimiaoppimateriaaleja-1579681880027.pptx	Kuinka tehdä avoimia oppimateriaaleja.pptx	85367	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	376	Kuinkatehdavoimiaoppimateriaaleja-1579681880027.pptx	testing	Kuinkatehdavoimiaoppimateriaaleja-1579681880027.pdf
331	https://testing.object.pouta.csc.fi/6bPuheentuottoopiskelijalle-1579855359368.pptx	6b Puheentuotto_opiskelijalle.pptx	1290933	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	399	6bPuheentuottoopiskelijalle-1579855359368.pptx	testing	6bPuheentuottoopiskelijalle-1579855359368.pdf
332	https://testing.object.pouta.csc.fi/1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1579861238642.pptx	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1.pptx	287378	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	400	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1579861238642.pptx	testing	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1579861238642.pdf
341	https://testing.object.pouta.csc.fi/1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1580381791589.pptx	1_miten_tuetaan_opiskelijoiden_yhteisöllisyyden_kehittymistä_1.pptx	287378	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	411	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1580381791589.pptx	testing	1mitentuetaanopiskelijoidenyhteisollisyydenkehittymista1-1580381791589.pdf
356	https://testing.object.pouta.csc.fi/ninteetavoimiaoppimateriaaleja-1581599046412.pptx	näin teet avoimia oppimateriaaleja.pptx	85367	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	426	ninteetavoimiaoppimateriaaleja-1581599046412.pptx	testing	ninteetavoimiaoppimateriaaleja-1581599046412.pdf
372	https://testing.object.pouta.csc.fi/ninteetavoimiaoppimateriaaleja-1582526767639.pptx	näin teet avoimia oppimateriaaleja.pptx	85367	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	451	ninteetavoimiaoppimateriaaleja-1582526767639.pptx	testing	ninteetavoimiaoppimateriaaleja-1582526767639.pdf
390	https://testing.object.pouta.csc.fi/skrivappnalrresurser-1582884523095.pptx	skriva öppna lärresurser.pptx	85364	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	477	skrivappnalrresurser-1582884523095.pptx	testing	skrivappnalrresurser-1582884523095.pdf
394	https://testing.object.pouta.csc.fi/ninteetavoimiaoppimateriaaleja-1583221404432.pptx	näin teet avoimia oppimateriaaleja.pptx	85367	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	479	ninteetavoimiaoppimateriaaleja-1583221404432.pptx	testing	ninteetavoimiaoppimateriaaleja-1583221404432.pdf
419	object.pouta.csc.fi/testing/itknyttslide-1586865270842.pptx	itknäyttöslide.pptx	5911111	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	510	itknyttslide-1586865270842.pptx	testing	itknyttslide-1586865270842.pdf
443	https://testing.object.pouta.csc.fi/kuinkatehdavoimiaoppimateriaaleja-1588596189564.pptx	kuinka tehdä avoimia oppimateriaaleja.pptx	85367	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	535	kuinkatehdavoimiaoppimateriaaleja-1588596189564.pptx	testing	kuinkatehdavoimiaoppimateriaaleja-1588596189564.pdf
454	https://testing.object.pouta.csc.fi/ninteetavoimiaoppimateriaaleja-1588679623473.pptx	näin teet avoimia oppimateriaaleja.pptx	85367	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	551	ninteetavoimiaoppimateriaaleja-1588679623473.pptx	testing	ninteetavoimiaoppimateriaaleja-1588679623473.pdf
469	https://testing.object.pouta.csc.fi/ninteetavoimiaoppimateriaaleja-1588927877122.pptx	näin teet avoimia oppimateriaaleja.pptx	85367	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	572	ninteetavoimiaoppimateriaaleja-1588927877122.pptx	testing	ninteetavoimiaoppimateriaaleja-1588927877122.pdf
496	https://testing.object.pouta.csc.fi/aoekehittyy-1589531583934.docx	aoe kehittyy.docx	43604	application/vnd.openxmlformats-officedocument.wordprocessingml.document	7bit	597	aoekehittyy-1589531583934.docx	testing	aoekehittyy-1589531583934.pdf
522	https://testing.object.pouta.csc.fi/skrivappnalrresurer-1591871016223.docx	skriva öppna lärresurer.docx	11424	application/vnd.openxmlformats-officedocument.wordprocessingml.document	7bit	625	skrivappnalrresurer-1591871016223.docx	testing	skrivappnalrresurer-1591871016223.pdf
531	https://testing.object.pouta.csc.fi/skrivappnalrresurer-1593065024330.docx	skriva öppna lärresurer.docx	11424	application/vnd.openxmlformats-officedocument.wordprocessingml.document	7bit	634	skrivappnalrresurer-1593065024330.docx	testing	skrivappnalrresurer-1593065024330.pdf
565	https://testing.object.pouta.csc.fi/nainteetavoimiaoppimateriaaleja-1597042736275.pptx	nain_teet_avoimia_oppimateriaaleja.pptx	85367	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	676	nainteetavoimiaoppimateriaaleja-1597042736275.pptx	testing	nainteetavoimiaoppimateriaaleja-1597042736275.pdf
590	https://testing.object.pouta.csc.fi/nainteetavoimiaoppimateriaaleja-1598610450959.pptx	nain_teet_avoimia_oppimateriaaleja.pptx	85367	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	708	nainteetavoimiaoppimateriaaleja-1598610450959.pptx	testing	nainteetavoimiaoppimateriaaleja-1598610450959.pdf
680	https://testing.object.pouta.csc.fi/tehtavapaketti1-1601528021924.xlsx	tehtavapaketti1.xlsx	22147	application/vnd.openxmlformats-officedocument.spreadsheetml.sheet	7bit	805	tehtavapaketti1-1601528021924.xlsx	testing	tehtavapaketti1-1601528021924.pdf
681	https://testing.object.pouta.csc.fi/tvtexcelperusharjoituspaketti-1601528021994.xlsx	tvt_excel-perusharjoituspaketti.xlsx	144369	application/vnd.openxmlformats-officedocument.spreadsheetml.sheet	7bit	806	tvtexcelperusharjoituspaketti-1601528021994.xlsx	testing	tvtexcelperusharjoituspaketti-1601528021994.pdf
714	https://testing.object.pouta.csc.fi/oeglobal-1606209166184.odp	oeglobal.odp	4100699	application/vnd.oasis.opendocument.presentation	7bit	840	oeglobal-1606209166184.odp	testing	oeglobal-1606209166184.pdf
715	https://testing.object.pouta.csc.fi/kopiostoaoe-1606209300427.pptx	kopiosto_aoe.pptx	3643635	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	841	kopiostoaoe-1606209300427.pptx	testing	kopiostoaoe-1606209300427.pdf
716	https://testing.object.pouta.csc.fi/kuvakaappaus20201123120738-1606383114647.png	kuvakaappaus_-_2020-11-23_12-07-38.png	8379	image/png	7bit	842	kuvakaappaus20201123120738-1606383114647.png	testing	kuvakaappaus20201123120738-1606383114647.pdf
717	https://testing.object.pouta.csc.fi/kopiostoaoe-1606383114425.pptx	kopiosto_aoe.pptx	3643447	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	843	kopiostoaoe-1606383114425.pptx	testing	kopiostoaoe-1606383114425.pdf
718	https://testing.object.pouta.csc.fi/ymmarsinkokaikenoertesti-1606460770513.h5p	ymmarsinko_kaiken_oer_testi.h5p	3008808	application/octet-stream	7bit	844	ymmarsinkokaikenoertesti-1606460770513.h5p	testing	\N
719	https://testing.object.pouta.csc.fi/copyrightsineducation-1606460770635.pdf	copyrights_in_education.pdf	4953520	application/pdf	7bit	845	copyrightsineducation-1606460770635.pdf	testing	copyrightsineducation-1606460770635.pdf
720	https://testing.object.pouta.csc.fi/ge1tulvatjaettava-1606472148053.pdf	ge1_tulvat-jaettava.pdf	1408363	application/pdf	7bit	846	ge1tulvatjaettava-1606472148053.pdf	testing	ge1tulvatjaettava-1606472148053.pdf
721	https://testing.object.pouta.csc.fi/testeri-1606822891293.txt	testeri.txt	0	text/plain	7bit	847	testeri-1606822891293.txt	testing	testeri-1606822891293.pdf
722	https://testing.object.pouta.csc.fi/aoefietusivu-1607066459208.png	aoefi_etusivu.png	360451	image/png	7bit	849	aoefietusivu-1607066459208.png	testing	aoefietusivu-1607066459208.pdf
723	https://testing.object.pouta.csc.fi/esimerkkimateriaali-1607066459214.pptx	esimerkkimateriaali.pptx	290137	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	848	esimerkkimateriaali-1607066459214.pptx	testing	esimerkkimateriaali-1607066459214.pdf
724	object.pouta.csc.fi/testing/x5g0n2020ccsummit-1607072763817.pptx	x5g0n_2020_cc_summit.pptx	84003411	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	850	x5g0n2020ccsummit-1607072763817.pptx	testing	x5g0n2020ccsummit-1607072763817.pdf
725	object.pouta.csc.fi/testing/x5g0n2020ccsummit-1607072787126.pptx	x5g0n_2020_cc_summit.pptx	84003411	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	851	x5g0n2020ccsummit-1607072787126.pptx	testing	x5g0n2020ccsummit-1607072787126.pdf
726	object.pouta.csc.fi/testing/kokonaisuuseksogeenisetprosessit-1607072927627.pptx	kokonaisuus_-_eksogeeniset_prosessit.pptx	108289958	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	852	kokonaisuuseksogeenisetprosessit-1607072927627.pptx	testing	kokonaisuuseksogeenisetprosessit-1607072927627.pdf
727	object.pouta.csc.fi/testing/apodcastdigitallearningmaterialanditsuseinstudyingandteaching-1607077679345.m4a	a_podcast_digital_learning_material_and_its_use_in_studying_and_teaching.m4a	12541954	audio/mp4	7bit	853	apodcastdigitallearningmaterialanditsuseinstudyingandteaching-1607077679345.m4a	testing	\N
728	object.pouta.csc.fi/testing/kuvailuwebinaari-1607077862316.mp4	kuvailuwebinaari.mp4	129797183	video/mp4	7bit	854	kuvailuwebinaari-1607077862316.mp4	testing	\N
729	object.pouta.csc.fi/testing/-1607516996825002_200mb_file	002_200mb_file	209715200	application/octet-stream	7bit	855	-1607516996825002_200mb_file	testing	.pdf
730	object.pouta.csc.fi/testing/-1607517435001002_200mb_file	002_200mb_file	209715200	application/octet-stream	7bit	856	-1607517435001002_200mb_file	testing	.pdf
731	object.pouta.csc.fi/testing/-1607517845376002_200mb_file	002_200mb_file	209715200	application/octet-stream	7bit	857	-1607517845376002_200mb_file	testing	.pdf
734	object.pouta.csc.fi/testing/ge1karhusalometodipakattukoe-1607586921801.zip	ge1_karhu-salo-metodi_pakattu_koe.zip	275844570	application/zip	7bit	860	ge1karhusalometodipakattukoe-1607586921801.zip	testing	\N
735	https://testing.object.pouta.csc.fi/testeri-1607592384715.txt	testeri.txt	0	text/plain	7bit	861	testeri-1607592384715.txt	testing	testeri-1607592384715.pdf
736	object.pouta.csc.fi/testing/ge1karhusalometodipakattu-1607585459876.zip	ge1_karhu-salo-metodi_pakattu.zip	1826822784	application/zip	7bit	859	ge1karhusalometodipakattu-1607585459876.zip	testing	\N
737	object.pouta.csc.fi/testing/ge1karhusalometodipakattukoe-1608186071570.zip	ge1_karhu-salo-metodi_pakattu_koe.zip	275844570	application/zip	7bit	862	ge1karhusalometodipakattukoe-1608186071570.zip	testing	\N
738	https://testing.object.pouta.csc.fi/kuvakaappaus20201204121103-1608548389695.png	kuvakaappaus_-_2020-12-04_12-11-03.png	127842	image/png	7bit	864	kuvakaappaus20201204121103-1608548389695.png	testing	kuvakaappaus20201204121103-1608548389695.pdf
739	https://testing.object.pouta.csc.fi/kuvakaappaus20201207112007-1608549298341.png	kuvakaappaus_-_2020-12-07_11-20-07.png	162753	image/png	7bit	865	kuvakaappaus20201207112007-1608549298341.png	testing	kuvakaappaus20201207112007-1608549298341.pdf
740	https://testing.object.pouta.csc.fi/kuvakaappaus20201207112007-1608549373037.png	kuvakaappaus_-_2020-12-07_11-20-07.png	162753	image/png	7bit	866	kuvakaappaus20201207112007-1608549373037.png	testing	kuvakaappaus20201207112007-1608549373037.pdf
741	https://testing.object.pouta.csc.fi/aoefilogonega-1608552088248.pdf	aoefi_logo_nega.pdf	65588	application/pdf	7bit	867	aoefilogonega-1608552088248.pdf	testing	aoefilogonega-1608552088248.pdf
742	https://testing.object.pouta.csc.fi/aoelogonegapystyfi1500px-1610454282074.png	aoe_logo_nega_pysty_fi_1500px.png	35956	image/png	7bit	868	aoelogonegapystyfi1500px-1610454282074.png	testing	aoelogonegapystyfi1500px-1610454282074.pdf
743	https://testing.object.pouta.csc.fi/pdfsample-1610530901163.pdf	pdf-sample.pdf	7945	application/pdf	7bit	869	pdfsample-1610530901163.pdf	testing	pdfsample-1610530901163.pdf
744	https://testing.object.pouta.csc.fi/kuvakaappaus20201126132649-1610609818300.png	kuvakaappaus_-_2020-11-26_13-26-49.png	30353	image/png	7bit	870	kuvakaappaus20201126132649-1610609818300.png	testing	kuvakaappaus20201126132649-1610609818300.pdf
745	https://testing.object.pouta.csc.fi/kuvakaappaus20201126132649-1610609981638.png	kuvakaappaus_-_2020-11-26_13-26-49.png	30353	image/png	7bit	871	kuvakaappaus20201126132649-1610609981638.png	testing	kuvakaappaus20201126132649-1610609981638.pdf
746	https://testing.object.pouta.csc.fi/kuvakaappaus20210108120016-1610610032615.png	kuvakaappaus_-_2021-01-08_12-00-16.png	364825	image/png	7bit	872	kuvakaappaus20210108120016-1610610032615.png	testing	kuvakaappaus20210108120016-1610610032615.pdf
747	https://testing.object.pouta.csc.fi/ccby-1610610334216.png	cc-by.png	12588	image/png	7bit	873	ccby-1610610334216.png	testing	ccby-1610610334216.pdf
748	https://testing.object.pouta.csc.fi/kuvakaappaus20201207101607-1610613161658.png	kuvakaappaus_-_2020-12-07_10-16-07.png	367341	image/png	7bit	874	kuvakaappaus20201207101607-1610613161658.png	testing	kuvakaappaus20201207101607-1610613161658.pdf
749	https://testing.object.pouta.csc.fi/medigiesimerkki-1610613252748.pdf	medigi_esimerkki.pdf	659736	application/pdf	7bit	875	medigiesimerkki-1610613252748.pdf	testing	medigiesimerkki-1610613252748.pdf
750	https://testing.object.pouta.csc.fi/kuvakaappaus20201207112009-1610957644347.png	kuvakaappaus_-_2020-12-07_11-20-09.png	112275	image/png	7bit	876	kuvakaappaus20201207112009-1610957644347.png	testing	kuvakaappaus20201207112009-1610957644347.pdf
751	https://testing.object.pouta.csc.fi/kuvakaappaus20210108120016-1610958521095.png	kuvakaappaus_-_2021-01-08_12-00-16.png	364825	image/png	7bit	877	kuvakaappaus20210108120016-1610958521095.png	testing	kuvakaappaus20210108120016-1610958521095.pdf
752	object.pouta.csc.fi/testing/zoom0-1611131100686.mp4	zoom_0.mp4	53432277	video/mp4	7bit	878	zoom0-1611131100686.mp4	testing	zoom0-1611131100686.pdf
753	https://testing.object.pouta.csc.fi/kuvakaappaus20201217090541-1611149633754.png	kuvakaappaus_-_2020-12-17_09-05-41.png	73986	image/png	7bit	879	kuvakaappaus20201217090541-1611149633754.png	testing	kuvakaappaus20201217090541-1611149633754.pdf
757	https://testing.object.pouta.csc.fi/kuvakaappaus20201207112007-1611820154524.png	kuvakaappaus_-_2020-12-07_11-20-07.png	162753	image/png	7bit	883	kuvakaappaus20201207112007-1611820154524.png	testing	kuvakaappaus20201207112007-1611820154524.pdf
756	https://testing.object.pouta.csc.fi/kuvakaappaus20201210130409-1611820154451.png	kuvakaappaus_-_2020-12-10_13-04-09.png	139759	image/png	7bit	882	kuvakaappaus20201210130409-1611820154451.png	testing	kuvakaappaus20201210130409-1611820154451.pdf
754	object.pouta.csc.fi/testing/zoom0-1611819227368.mp4	zoom_0.mp4	53432277	video/mp4	7bit	880	zoom0-1611819227368.mp4	testing	zoom0-1611819227368.pdf
755	object.pouta.csc.fi/testing/zoom0-1611819650837.mp4	zoom_0.mp4	53432277	video/mp4	7bit	881	zoom0-1611819650837.mp4	testing	zoom0-1611819650837.pdf
758	https://testing.object.pouta.csc.fi/kuvakaappaus20210129085829-1612186773359.png	kuvakaappaus_-_2021-01-29_08-58-29.png	89347	image/png	7bit	884	kuvakaappaus20210129085829-1612186773359.png	testing	kuvakaappaus20210129085829-1612186773359.pdf
759	object.pouta.csc.fi/testing/ge1karhusalometodipakattupienin-1612430479395.zip	ge1_karhu-salo-metodi_pakattu_pienin.zip	51948877	application/zip	7bit	885	ge1karhusalometodipakattupienin-1612430479395.zip	testing	\N
760	https://testing.object.pouta.csc.fi/kuvakaappaus20201217090541-1612430625080.png	kuvakaappaus_-_2020-12-17_09-05-41.png	73986	image/png	7bit	886	kuvakaappaus20201217090541-1612430625080.png	testing	kuvakaappaus20201217090541-1612430625080.pdf
761	https://testing.object.pouta.csc.fi/kuvakaappaus20201210130409-1612430689191.png	kuvakaappaus_-_2020-12-10_13-04-09.png	139759	image/png	7bit	887	kuvakaappaus20201210130409-1612430689191.png	testing	kuvakaappaus20201210130409-1612430689191.pdf
762	https://testing.object.pouta.csc.fi/kuvakaappaus20210129085829-1613474134109.png	kuvakaappaus_-_2021-01-29_08-58-29.png	89347	image/png	7bit	888	kuvakaappaus20210129085829-1613474134109.png	testing	kuvakaappaus20210129085829-1613474134109.pdf
763	https://testing.object.pouta.csc.fi/kuvakaappaus20210215123540-1613474159989.png	kuvakaappaus_-_2021-02-15_12-35-40.png	24686	image/png	7bit	889	kuvakaappaus20210215123540-1613474159989.png	testing	kuvakaappaus20210215123540-1613474159989.pdf
764	https://testing.object.pouta.csc.fi/kuvakaappaus20201002135603-1613474306901.png	kuvakaappaus_-_2020-10-02_13-56-03.png	356446	image/png	7bit	890	kuvakaappaus20201002135603-1613474306901.png	testing	kuvakaappaus20201002135603-1613474306901.pdf
765	https://testing.object.pouta.csc.fi/kuvakaappaus20201123121231-1613636769483.png	kuvakaappaus_-_2020-11-23_12-12-31.png	27513	image/png	7bit	891	kuvakaappaus20201123121231-1613636769483.png	testing	kuvakaappaus20201123121231-1613636769483.pdf
766	https://testing.object.pouta.csc.fi/chart7143-1613717841384.h5p	chart-7143.h5p	114324	application/octet-stream	7bit	892	chart7143-1613717841384.h5p	testing	\N
767	https://testing.object.pouta.csc.fi/asiasanattyoelamassatoimiminen-1614675289011.png	asiasanat_tyoelamassa_toimiminen.png	8243	image/png	7bit	895	asiasanattyoelamassatoimiminen-1614675289011.png	testing	asiasanattyoelamassatoimiminen-1614675289011.pdf
769	https://testing.object.pouta.csc.fi/kuvakaappaus20210215123538-1614675390582.png	kuvakaappaus_-_2021-02-15_12-35-38.png	77787	image/png	7bit	897	kuvakaappaus20210215123538-1614675390582.png	testing	kuvakaappaus20210215123538-1614675390582.pdf
771	https://testing.object.pouta.csc.fi/kuvakaappaus20201207112009-1614675390669.png	kuvakaappaus_-_2020-12-07_11-20-09.png	112275	image/png	7bit	899	kuvakaappaus20201207112009-1614675390669.png	testing	kuvakaappaus20201207112009-1614675390669.pdf
770	https://testing.object.pouta.csc.fi/kuvakaappaus20201204121103-1614675390690.png	kuvakaappaus_-_2020-12-04_12-11-03.png	127842	image/png	7bit	898	kuvakaappaus20201204121103-1614675390690.png	testing	kuvakaappaus20201204121103-1614675390690.pdf
768	https://testing.object.pouta.csc.fi/kuvakaappaus20210212155042-1614675390545.png	kuvakaappaus_-_2021-02-12_15-50-42.png	69340	image/png	7bit	896	kuvakaappaus20210212155042-1614675390545.png	testing	kuvakaappaus20210212155042-1614675390545.pdf
772	https://testing.object.pouta.csc.fi/aoekam-1615884880169.odp	aoe_kam.odp	3063687	application/vnd.oasis.opendocument.presentation	7bit	901	aoekam-1615884880169.odp	testing	aoekam-1615884880169.pdf
773	https://testing.object.pouta.csc.fi/tehtavapaketti1-1615885046446.xlsx	tehtavapaketti1.xlsx	22147	application/vnd.openxmlformats-officedocument.spreadsheetml.sheet	7bit	902	tehtavapaketti1-1615885046446.xlsx	testing	tehtavapaketti1-1615885046446.pdf
774	https://testing.object.pouta.csc.fi/5kirjainaanneopettajalle-1615894676802.pptx	5_kirjain_aanne_opettajalle.pptx	282943	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	903	5kirjainaanneopettajalle-1615894676802.pptx	testing	5kirjainaanneopettajalle-1615894676802.pdf
775	https://testing.object.pouta.csc.fi/teeworddokumenteistasaavutettavia-1615894825116.docx	tee-word-dokumenteista-saavutettavia.docx	410393	application/vnd.openxmlformats-officedocument.wordprocessingml.document	7bit	904	teeworddokumenteistasaavutettavia-1615894825116.docx	testing	teeworddokumenteistasaavutettavia-1615894825116.pdf
776	https://testing.object.pouta.csc.fi/teeworddokumenteistasaavutettavia-1615894825422.docx	tee-word-dokumenteista-saavutettavia.docx	410393	application/vnd.openxmlformats-officedocument.wordprocessingml.document	7bit	905	teeworddokumenteistasaavutettavia-1615894825422.docx	testing	teeworddokumenteistasaavutettavia-1615894825422.pdf
777	object.pouta.csc.fi/testing/ge1tulvat-1615895133902.pptx	ge1_tulvat.pptx	24159474	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	906	ge1tulvat-1615895133902.pptx	testing	ge1tulvat-1615895133902.pdf
778	object.pouta.csc.fi/testing/kokonaisuuseksogeenisetprosessit-1615895134249.pptx	kokonaisuus_-_eksogeeniset_prosessit.pptx	108289958	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	907	kokonaisuuseksogeenisetprosessit-1615895134249.pptx	testing	kokonaisuuseksogeenisetprosessit-1615895134249.pdf
779	object.pouta.csc.fi/testing/ge1kylmjakuumamaa-1615895442479.pptx	ge1_kylm_ja_kuuma_maa.pptx	50116139	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	908	ge1kylmjakuumamaa-1615895442479.pptx	testing	ge1kylmjakuumamaa-1615895442479.pdf
780	object.pouta.csc.fi/testing/kokonaisuusluonnontoiminnanaiheuttamatilmit-1615895442655.pptx	kokonaisuus_-_luonnontoiminnan_aiheuttamat_ilmit.pptx	176892148	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	909	kokonaisuusluonnontoiminnanaiheuttamatilmit-1615895442655.pptx	testing	kokonaisuusluonnontoiminnanaiheuttamatilmit-1615895442655.pdf
781	object.pouta.csc.fi/testing/3ge1kolmaskokoontuminenkartta-1615896110864.pptx	3_ge1_kolmas_kokoontuminen_-_kartta.pptx	68111269	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	910	3ge1kolmaskokoontuminenkartta-1615896110864.pptx	testing	3ge1kolmaskokoontuminenkartta-1615896110864.pdf
782	object.pouta.csc.fi/testing/ge1kokonaisuusluonnontoiminnanaiheuttamatilmioteimuokattava-1615896111017.pptx	ge1_kokonaisuus_-_luonnontoiminnan_aiheuttamat_ilmiot_-_ei_muokattava.pptx	176891899	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	911	ge1kokonaisuusluonnontoiminnanaiheuttamatilmioteimuokattava-1615896111017.pptx	testing	ge1kokonaisuusluonnontoiminnanaiheuttamatilmioteimuokattava-1615896111017.pdf
783	https://testing.object.pouta.csc.fi/pdfsample-1616757481203.pdf	pdf-sample.pdf	7945	application/pdf	7bit	914	pdfsample-1616757481203.pdf	testing	pdfsample-1616757481203.pdf
784	https://testing.object.pouta.csc.fi/avointenoppimateriaalienpalveluttyokalutjakaytannotkey-1618407402346.pdf	avointen_oppimateriaalien_palvelut_tyokalut_ja_kaytannot.key.pdf	592969	application/pdf	7bit	915	avointenoppimateriaalienpalveluttyokalutjakaytannotkey-1618407402346.pdf	testing	avointenoppimateriaalienpalveluttyokalutjakaytannotkey-1618407402346.pdf
785	https://testing.object.pouta.csc.fi/avointenoppimateriaalienpalveluttyokalutjakaytannot-1618407480349.key	avointen_oppimateriaalien_palvelut_tyokalut_ja_kaytannot.key	592969	application/x-iwork-keynote-sffkey	7bit	916	avointenoppimateriaalienpalveluttyokalutjakaytannot-1618407480349.key	testing	avointenoppimateriaalienpalveluttyokalutjakaytannot-1618407480349.pdf
786	https://testing.object.pouta.csc.fi/testi-1618409707065.zip	testi.zip	157	application/x-zip-compressed	7bit	917	testi-1618409707065.zip	testing	\N
787	object.pouta.csc.fi/testing/4ge1neljskokoontuminengeomedia-1619156329457.pptx	4_ge1_neljs_kokoontuminen_-_geomedia.pptx	13352519	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	918	4ge1neljskokoontuminengeomedia-1619156329457.pptx	testing	4ge1neljskokoontuminengeomedia-1619156329457.pdf
788	object.pouta.csc.fi/testing/ge1nlkinenmaailmamme-1619156621694.pptx	ge1_nlkinen_maailmamme.pptx	25181385	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	919	ge1nlkinenmaailmamme-1619156621694.pptx	testing	ge1nlkinenmaailmamme-1619156621694.pdf
789	object.pouta.csc.fi/testing/1ge1ensimminenkokoontuminen-1619157788257.pptx	1_ge1_ensimminen_kokoontuminen.pptx	16022588	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	920	1ge1ensimminenkokoontuminen-1619157788257.pptx	testing	1ge1ensimminenkokoontuminen-1619157788257.pdf
790	object.pouta.csc.fi/testing/1ge1ensimminenkokoontuminen-1619157897332.pptx	1_ge1_ensimminen_kokoontuminen.pptx	16022588	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	921	1ge1ensimminenkokoontuminen-1619157897332.pptx	testing	1ge1ensimminenkokoontuminen-1619157897332.pdf
791	https://testing.object.pouta.csc.fi/pdfsample-1619158190413.pdf	pdf-sample.pdf	7945	application/pdf	7bit	922	pdfsample-1619158190413.pdf	testing	pdfsample-1619158190413.pdf
792	https://testing.object.pouta.csc.fi/pdfsample-1619158361055.pdf	pdf-sample.pdf	7945	application/pdf	7bit	923	pdfsample-1619158361055.pdf	testing	pdfsample-1619158361055.pdf
793	https://testing.object.pouta.csc.fi/1ge1ensimminenkokoontuminen-1619159376491.pdf	1_ge1_ensimminen_kokoontuminen.pdf	7945	application/pdf	7bit	924	1ge1ensimminenkokoontuminen-1619159376491.pdf	testing	1ge1ensimminenkokoontuminen-1619159376491.pdf
794	https://testing.object.pouta.csc.fi/1ge1ensimminenkokoontuminen-1619159522626.pdf	1_ge1_ensimminen_kokoontuminen.pdf	7945	application/pdf	7bit	925	1ge1ensimminenkokoontuminen-1619159522626.pdf	testing	1ge1ensimminenkokoontuminen-1619159522626.pdf
795	https://testing.object.pouta.csc.fi/1ge1ensimminenkokoontuminen-1619159522629.pdf	1_ge1_ensimminen_kokoontuminen.pdf	7945	application/pdf	7bit	926	1ge1ensimminenkokoontuminen-1619159522629.pdf	testing	1ge1ensimminenkokoontuminen-1619159522629.pdf
796	object.pouta.csc.fi/testing/4ge1neljskokoontuminengeomedia-1619160106557.pptx	4_ge1_neljs_kokoontuminen_-_geomedia.pptx	13352519	application/vnd.openxmlformats-officedocument.presentationml.presentation	7bit	927	4ge1neljskokoontuminengeomedia-1619160106557.pptx	testing	4ge1neljskokoontuminengeomedia-1619160106557.pdf
797	object.pouta.csc.fi/testing/ge1karhusalometodipakattu-1620623401312.zip	ge1_karhu-salo-metodi_pakattu.zip	1826822784	application/zip	7bit	929	ge1karhusalometodipakattu-1620623401312.zip	testing	\N
798	object.pouta.csc.fi/testing/ge1karhusalometodipakattu-1620626024273.zip	ge1_karhu-salo-metodi_pakattu.zip	1826822784	application/zip	7bit	930	ge1karhusalometodipakattu-1620626024273.zip	testing	\N
799	object.pouta.csc.fi/testing/ge1karhusalometodipakattu-1620623401312.zip	ge1_karhu-salo-metodi_pakattu.zip	1826822784	application/zip	7bit	929	ge1karhusalometodipakattu-1620623401312.zip	testing	\N
800	object.pouta.csc.fi/testing/ge1karhusalometodipakattu-1620626024273.zip	ge1_karhu-salo-metodi_pakattu.zip	1826822784	application/zip	7bit	930	ge1karhusalometodipakattu-1620626024273.zip	testing	\N
801	object.pouta.csc.fi/testing/ge1karhusalometodipakattu-1620645186721.zip	ge1_karhu-salo-metodi_pakattu.zip	1826822784	application/zip	7bit	935	ge1karhusalometodipakattu-1620645186721.zip	testing	\N
802	object.pouta.csc.fi/testing/raskastestimateriaali5-1620647160657.zip	raskas_testimateriaali5.zip	2001243134	application/zip	7bit	936	raskastestimateriaali5-1620647160657.zip	testing	\N
803	object.pouta.csc.fi/testing/ge1karhusalometodipakattu-1620645186721.zip	ge1_karhu-salo-metodi_pakattu.zip	1826822784	application/zip	7bit	935	ge1karhusalometodipakattu-1620645186721.zip	testing	\N
804	object.pouta.csc.fi/testing/raskastestimateriaali5-1620647160657.zip	raskas_testimateriaali5.zip	2001243134	application/zip	7bit	936	raskastestimateriaali5-1620647160657.zip	testing	\N
\.


--
-- Data for Name: temporaryattachment; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.temporaryattachment (id, filepath, originalfilename, filesize, mimetype, format, filename, createdat, defaultfile, kind, label, srclang, attachmentid) FROM stdin;
\.


--
-- Data for Name: temporaryrecord; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.temporaryrecord (id, filepath, originalfilename, filesize, mimetype, format, filename, materialid, createdat) FROM stdin;
723	uploads/ge1karhusalometodiohjeetkayttajalle-1605510799458.pdf	ge1_karhu-salo-metodi_-_ohjeet_kayttajalle.pdf	365747	application/pdf	7bit	ge1karhusalometodiohjeetkayttajalle-1605510799458.pdf	838	2020-11-16 07:13:19.594693+00
738	uploads/apodcastdigitallearningmaterialanditsuseinstudyingandteaching-1607077679345.m4a	a_podcast_digital_learning_material_and_its_use_in_studying_and_teaching.m4a	12541954	audio/mp4	7bit	apodcastdigitallearningmaterialanditsuseinstudyingandteaching-1607077679345.m4a	853	2020-12-04 10:28:08.189475+00
739	uploads/kuvailuwebinaari-1607077862316.mp4	kuvailuwebinaari.mp4	129797183	video/mp4	7bit	kuvailuwebinaari-1607077862316.mp4	854	2020-12-04 10:31:59.202807+00
\.


--
-- Data for Name: thumbnail; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.thumbnail (id, filepath, mimetype, educationalmaterialid, filename, obsoleted, filekey, filebucket) FROM stdin;
1	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1572940989514.png	image/png	7	thumbnail1572940989514.png	0	thumbnail1572940989514.png	aoethumbnailtest
2	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1572942543181.png	image/png	8	thumbnail1572942543181.png	0	thumbnail1572942543181.png	aoethumbnailtest
3	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1575985941496.png	image/png	75	thumbnail1575985941496.png	1	thumbnail1575985941496.png	aoethumbnailtest
4	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1575985952100.png	image/png	75	thumbnail1575985952100.png	0	thumbnail1575985952100.png	aoethumbnailtest
5	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1578656820271.png	image/png	132	thumbnail1578656820271.png	0	thumbnail1578656820271.png	aoethumbnailtest
6	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1579071059844.png	image/png	137	thumbnail1579071059844.png	0	thumbnail1579071059844.png	aoethumbnailtest
7	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1581594386496.png	image/png	184	thumbnail1581594386496.png	0	thumbnail1581594386496.png	aoethumbnailtest
8	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1582005881150.png	image/png	193	thumbnail1582005881150.png	0	thumbnail1582005881150.png	aoethumbnailtest
9	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1582526505362.png	image/png	201	thumbnail1582526505362.png	0	thumbnail1582526505362.png	aoethumbnailtest
10	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1582527003416.png	image/png	203	thumbnail1582527003416.png	0	thumbnail1582527003416.png	aoethumbnailtest
11	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1582534720152.png	image/png	205	thumbnail1582534720152.png	0	thumbnail1582534720152.png	aoethumbnailtest
12	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1582535254246.png	image/png	207	thumbnail1582535254246.png	0	thumbnail1582535254246.png	aoethumbnailtest
13	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1582535484377.png	image/png	208	thumbnail1582535484377.png	0	thumbnail1582535484377.png	aoethumbnailtest
15	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1584450464515.png	image/png	231	thumbnail1584450464515.png	0	thumbnail1584450464515.png	aoethumbnailtest
16	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1585050781165.png	image/png	233	thumbnail1585050781165.png	0	thumbnail1585050781165.png	aoethumbnailtest
14	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1582806696286.png	image/png	217	thumbnail1582806696286.png	1	thumbnail1582806696286.png	aoethumbnailtest
17	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1585737422228.png	image/png	217	thumbnail1585737422228.png	1	thumbnail1585737422228.png	aoethumbnailtest
18	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1585737548329.png	image/png	217	thumbnail1585737548329.png	1	thumbnail1585737548329.png	aoethumbnailtest
19	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1585738027505.png	image/png	217	thumbnail1585738027505.png	0	thumbnail1585738027505.png	aoethumbnailtest
21	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1585907246098.png	image/png	220	thumbnail1585907246098.png	1	thumbnail1585907246098.png	aoethumbnailtest
23	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1585909819936.png	image/png	240	thumbnail1585909819936.png	1	thumbnail1585909819936.png	aoethumbnailtest
25	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1585910794603.png	image/png	230	thumbnail1585910794603.png	1	thumbnail1585910794603.png	aoethumbnailtest
26	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1585910920616.png	image/png	230	thumbnail1585910920616.png	0	thumbnail1585910920616.png	aoethumbnailtest
24	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1585909989339.png	image/png	240	thumbnail1585909989339.png	1	thumbnail1585909989339.png	aoethumbnailtest
27	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1585910997208.png	image/png	240	thumbnail1585910997208.png	1	thumbnail1585910997208.png	aoethumbnailtest
28	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1585911896375.png	image/png	240	thumbnail1585911896375.png	0	thumbnail1585911896375.png	aoethumbnailtest
20	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1585906426230.png	image/png	234	thumbnail1585906426230.png	1	thumbnail1585906426230.png	aoethumbnailtest
29	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1585911980648.png	image/png	234	thumbnail1585911980648.png	1	thumbnail1585911980648.png	aoethumbnailtest
22	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1585907691742.png	image/png	220	thumbnail1585907691742.png	1	thumbnail1585907691742.png	aoethumbnailtest
31	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1585912253255.png	image/png	220	thumbnail1585912253255.png	1	thumbnail1585912253255.png	aoethumbnailtest
32	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1585914603155.png	image/png	220	thumbnail1585914603155.png	0	thumbnail1585914603155.png	aoethumbnailtest
30	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1585912168066.png	image/png	234	thumbnail1585912168066.png	1	thumbnail1585912168066.png	aoethumbnailtest
33	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1586240349493.png	image/png	234	thumbnail1586240349493.png	0	thumbnail1586240349493.png	aoethumbnailtest
34	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1586258600516.png	image/png	241	thumbnail1586258600516.png	0	thumbnail1586258600516.png	aoethumbnailtest
35	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1586419223276.png	image/png	243	thumbnail1586419223276.png	1	thumbnail1586419223276.png	aoethumbnailtest
36	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1586419465826.png	image/png	243	thumbnail1586419465826.png	0	thumbnail1586419465826.png	aoethumbnailtest
37	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1586420259956.png	image/png	244	thumbnail1586420259956.png	0	thumbnail1586420259956.png	aoethumbnailtest
38	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1586846282772.png	image/png	245	thumbnail1586846282772.png	0	thumbnail1586846282772.png	aoethumbnailtest
39	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1587964548236.png	image/png	249	thumbnail1587964548236.png	0	thumbnail1587964548236.png	aoethumbnailtest
40	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1588679898741.png	image/png	247	thumbnail1588679898741.png	0	thumbnail1588679898741.png	aoethumbnailtest
41	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1590480812634.png	image/png	261	thumbnail1590480812634.png	0	thumbnail1590480812634.png	aoethumbnailtest
42	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1591106067327.png	image/png	270	thumbnail1591106067327.png	0	thumbnail1591106067327.png	aoethumbnailtest
44	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1591261506828.png	image/png	257	thumbnail1591261506828.png	0	thumbnail1591261506828.png	aoethumbnailtest
45	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1591781969147.png	image/png	283	thumbnail1591781969147.png	1	thumbnail1591781969147.png	aoethumbnailtest
46	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1591782482412.png	image/png	283	thumbnail1591782482412.png	1	thumbnail1591782482412.png	aoethumbnailtest
47	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1591782707311.png	image/png	283	thumbnail1591782707311.png	0	thumbnail1591782707311.png	aoethumbnailtest
48	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1591871032075.png	image/png	284	thumbnail1591871032075.png	0	thumbnail1591871032075.png	aoethumbnailtest
49	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1593065867797.png	image/png	290	thumbnail1593065867797.png	0	thumbnail1593065867797.png	aoethumbnailtest
50	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1593689121782.png	image/png	281	thumbnail1593689121782.png	0	thumbnail1593689121782.png	aoethumbnailtest
51	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1593692006246.png	image/png	280	thumbnail1593692006246.png	0	thumbnail1593692006246.png	aoethumbnailtest
52	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1593774398249.png	image/png	275	thumbnail1593774398249.png	1	thumbnail1593774398249.png	aoethumbnailtest
53	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1593774436160.png	image/png	275	thumbnail1593774436160.png	1	thumbnail1593774436160.png	aoethumbnailtest
55	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1593774492496.png	image/png	293	thumbnail1593774492496.png	1	thumbnail1593774492496.png	aoethumbnailtest
56	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1593774524493.png	image/png	293	thumbnail1593774524493.png	0	thumbnail1593774524493.png	aoethumbnailtest
54	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1593774466449.png	image/png	275	thumbnail1593774466449.png	1	thumbnail1593774466449.png	aoethumbnailtest
57	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1593774761095.png	image/png	275	thumbnail1593774761095.png	1	thumbnail1593774761095.png	aoethumbnailtest
58	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1593774787288.png	image/png	275	thumbnail1593774787288.png	0	thumbnail1593774787288.png	aoethumbnailtest
59	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1593775717142.png	image/png	169	thumbnail1593775717142.png	0	thumbnail1593775717142.png	aoethumbnailtest
60	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1594208577655.png	image/png	267	thumbnail1594208577655.png	0	thumbnail1594208577655.png	aoethumbnailtest
61	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1594208655252.png	image/png	246	thumbnail1594208655252.png	0	thumbnail1594208655252.png	aoethumbnailtest
43	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1591261225936.png	image/png	271	thumbnail1591261225936.png	1	thumbnail1591261225936.png	aoethumbnailtest
62	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1598520029984.png	image/png	271	thumbnail1598520029984.png	1	thumbnail1598520029984.png	aoethumbnailtest
63	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1599133916157.png	image/png	271	thumbnail1599133916157.png	1	thumbnail1599133916157.png	aoethumbnailtest
64	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1599798069949.png	image/png	271	thumbnail1599798069949.png	0	thumbnail1599798069949.png	aoethumbnailtest
65	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1599798605810.png	image/png	339	thumbnail1599798605810.png	0	thumbnail1599798605810.png	aoethumbnailtest
66	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1600756432102.png	image/png	327	thumbnail1600756432102.png	0	thumbnail1600756432102.png	aoethumbnailtest
67	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1600929514571.png	image/png	360	thumbnail1600929514571.png	0	thumbnail1600929514571.png	aoethumbnailtest
68	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1601278520484.png	image/png	362	thumbnail1601278520484.png	0	thumbnail1601278520484.png	aoethumbnailtest
69	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1601285334141.png	image/png	364	thumbnail1601285334141.png	1	thumbnail1601285334141.png	aoethumbnailtest
70	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1601285354173.png	image/png	364	thumbnail1601285354173.png	0	thumbnail1601285354173.png	aoethumbnailtest
71	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1604301657557.png	image/png	370	thumbnail1604301657557.png	0	thumbnail1604301657557.png	aoethumbnailtest
72	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1606820160301.png	image/png	356	thumbnail1606820160301.png	0	thumbnail1606820160301.png	aoethumbnailtest
73	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1607066477448.png	image/png	310	thumbnail1607066477448.png	0	thumbnail1607066477448.png	aoethumbnailtest
74	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1613474360860.png	image/png	399	thumbnail1613474360860.png	0	thumbnail1613474360860.png	aoethumbnailtest
75	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1615895333509.png	image/png	407	thumbnail1615895333509.png	0	thumbnail1615895333509.png	aoethumbnailtest
76	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1619074846222.png	image/png	306	thumbnail1619074846222.png	0	thumbnail1619074846222.png	aoethumbnailtest
77	https://aoethumbnailtest.object.pouta.csc.fi/thumbnail1619154594987.png	image/png	406	thumbnail1619154594987.png	0	thumbnail1619154594987.png	aoethumbnailtest
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.users (id, firstname, lastname, username, preferredlanguage, preferredtargetname, preferredalignmenttype, termsofusage, email, verifiedemail, newratings, almostexpired, termsupdated, allowtransfer) FROM stdin;
1	Maija	Mehiläinen	maija.mehilainen@aoe.fi	fi			f	\N	f	f	f	f	f
3	Teppo	Testikäyttäjä	teppo@yliopisto.fi	fi			t	\N	f	f	f	f	f
4	Mika	Ropponen	mroppone@csc.fi	fi			t	\N	f	f	f	f	f
2	Jussi	Nieminen	juniemin@csc.fi	fi			t	\N	f	f	f	f	f
7	Taru	Kuhalampi	e151399	fi			f	\N	f	f	f	f	f
8	Heidi	Hynynen	e155554	fi			t	\N	f	f	f	f	f
6	Nordea	Demo	210281-9988	fi			t	\N	f	f	f	f	f
9	Henrik	Korhonen	e159440	fi			t	\N	f	f	f	f	f
10	Pekka-Testi	Virtanen	MPASSOID.53b1af17cb284998638b5	fi			t	\N	f	f	f	f	f
12	Olli	Lehto	olehto@csc.fi	fi			t	\N	f	f	f	f	f
11	Victor	Gallen	vigallen@csc.fi	fi			t	\N	f	f	f	f	f
14	Jarkko	Huovinen	jahuovi@csc.fi	fi			t	\N	f	f	f	f	f
29	Aapo	Salo	aasalo@csc.fi	fi			f	\N	f	f	f	f	f
27	Pekka-Testi	Virtanen	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0	fi			t	anna.lindfors@csc.fi	t	t	t	f	f
30	Testi1	Oppilas1	MPASSOID.c6329e82913e265b3a79c11a043fdab8b06b1a9e	fi			t	\N	f	f	f	f	f
31	Risto	Sivonen	rsivonen@csc.fi	fi			f	\N	f	f	f	f	f
13	Nordea	Demo	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD	fi			t	oppimateriaalivaranto@csc.fi	t	t	t	f	f
28	Aki	Karppinen	akkarppi@csc.fi	fi			t	\N	f	f	f	f	f
5	Anna	Lindfors	anlindfo@csc.fi	fi			t	anna.lindfors@csc.fi	t	t	t	t	t
\.


--
-- Data for Name: userscollection; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.userscollection (collectionid, usersusername) FROM stdin;
1	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD
3	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD
4	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD
5	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD
6	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD
7	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD
8	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD
9	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD
10	mroppone@csc.fi
11	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD
12	anlindfo@csc.fi
13	anlindfo@csc.fi
14	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD
15	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD
16	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD
17	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD
18	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0
19	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD
20	olehto@csc.fi
21	olehto@csc.fi
22	olehto@csc.fi
23	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0
24	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0
25	4GXNGLC62DVELHPSKA6AY5WSD4TX7CGD
26	MPASSOID.53b1af17cb284998638b538bead9d33300b785d0
2	anlindfo@csc.fi
\.


--
-- Data for Name: versioncomposition; Type: TABLE DATA; Schema: public; Owner: aoe_admin
--

COPY public.versioncomposition (educationalmaterialid, materialid, publishedat, priority) FROM stdin;
107	254	2019-12-17 10:22:23.659	0
108	255	2019-12-17 11:26:03.193	0
108	256	2019-12-17 11:26:03.193	0
110	258	2019-12-18 08:45:33.348	0
110	259	2019-12-18 08:45:33.348	0
110	260	2019-12-18 08:45:33.348	0
110	261	2019-12-18 08:45:33.348	0
110	262	2019-12-18 08:45:33.348	0
110	263	2019-12-18 08:45:33.348	0
111	266	2019-12-18 13:42:31.237	0
111	264	2019-12-18 13:42:31.237	1
111	265	2019-12-18 13:42:31.237	2
112	267	2019-12-18 13:44:10.406	0
112	268	2019-12-18 13:44:10.406	1
117	304	2019-12-19 06:43:14.881	0
117	303	2019-12-19 06:43:14.881	1
117	305	2019-12-19 06:43:14.881	2
118	307	2019-12-19 08:17:06.079	0
118	306	2019-12-19 08:17:06.079	1
123	315	2019-12-19 12:07:17.863	0
123	314	2019-12-19 12:07:17.863	1
127	320	2019-12-20 12:02:16.998	0
128	322	2020-01-02 13:10:16.441	0
128	321	2020-01-02 13:10:16.441	1
132	326	2020-01-10 11:47:14.87	0
132	327	2020-01-10 11:47:14.87	1
137	334	2020-01-15 06:51:19.803	0
138	335	2020-01-15 09:21:46.267	0
139	336	2020-01-15 10:46:18.998	0
140	337	2020-01-16 07:46:46.231	0
140	338	2020-01-16 07:46:46.231	0
141	339	2020-01-16 10:01:15.837	0
142	340	2020-01-16 10:06:59.427	0
143	342	2020-01-16 10:24:17.752	0
143	341	2020-01-16 10:24:17.752	1
165	383	2020-01-23 10:09:10.236	0
160	376	2020-01-22 09:13:22.832	0
168	393	2020-01-23 12:40:22.943	0
168	395	2020-01-23 12:40:22.943	1
168	394	2020-01-23 12:40:22.943	2
171	400	2020-01-24 10:21:06.994	0
174	403	2020-01-28 10:56:08.825	0
175	404	2020-01-28 11:06:26.55	0
176	405	2020-01-28 11:26:19.086	0
160	378	2020-01-22 09:13:22.832	1
160	377	2020-01-22 09:13:22.832	2
182	414	2020-02-12 09:03:17.748	0
183	417	2020-02-13 11:37:16.332	0
183	415	2020-02-13 11:37:16.332	1
183	416	2020-02-13 11:37:16.332	2
184	418	2020-02-13 11:48:07.889	0
189	424	2020-02-13 12:37:46.503	0
189	423	2020-02-13 12:37:46.503	1
193	428	2020-02-18 06:14:46.537	0
193	429	2020-02-18 06:14:46.537	1
193	430	2020-02-18 06:14:46.537	2
202	451	2020-02-24 06:48:07.883	0
202	452	2020-02-24 06:48:07.883	1
203	454	2020-02-24 06:52:10.285	0
203	453	2020-02-24 06:52:10.285	1
204	455	2020-02-24 08:45:34.679	0
207	458	2020-02-24 09:09:49.44	0
178	409	2020-04-03 12:13:33.431	0
216	467	2020-02-25 15:50:37.113	0
216	468	2020-02-25 15:50:37.113	1
220	473	2020-04-03 11:11:08.016	0
220	474	2020-04-03 11:11:08.016	0
208	459	2020-04-03 10:08:30.737	0
230	487	2020-04-03 10:48:45.835	0
222	479	2020-03-03 07:44:31.037	0
223	480	2020-03-03 11:15:22.578	0
224	481	2020-03-05 17:02:39.648	0
217	469	2020-04-07 06:28:43.153	0
177	406	2020-04-14 11:53:19.449	0
177	408	2020-04-14 11:53:19.449	1
177	407	2020-04-14 11:53:19.449	2
231	489	2020-04-03 12:00:13.121	1
235	496	2020-03-25 08:50:58.293	0
215	466	2020-04-03 08:33:45.145	0
249	515	2020-04-27 05:58:02.969	0
245	509	2020-04-27 06:03:53.114	0
231	488	2020-04-03 12:00:13.121	0
231	490	2020-04-03 12:00:13.121	1
241	504	2020-04-07 11:55:25.809	0
241	505	2020-04-07 11:55:25.809	1
239	502	2020-04-08 07:27:43.518	0
144	345	2020-04-03 10:38:41.222	0
144	343	2020-04-03 10:38:41.222	1
144	344	2020-04-03 10:38:41.222	2
246	510	2020-04-14 11:56:55.749	0
234	493	2020-04-15 08:02:45.761	0
234	495	2020-04-15 08:02:45.761	1
234	494	2020-04-15 08:02:45.761	2
247	511	2020-04-16 10:31:47.239	0
247	513	2020-04-16 10:31:47.239	1
247	512	2020-04-16 10:31:47.239	2
243	507	2020-04-22 10:06:12.336	0
247	554	2020-05-05 11:59:12.933	0
247	513	2020-05-05 11:59:12.933	1
247	512	2020-05-05 11:59:12.933	2
247	555	2020-05-05 12:00:07.604	0
247	513	2020-05-05 12:00:07.604	1
247	512	2020-05-05 12:00:07.604	2
203	454	2020-05-05 11:53:55.81	0
203	551	2020-05-05 11:53:55.81	1
207	557	2020-05-05 12:13:39.275	0
249	549	2020-05-05 11:47:20.224	0
215	556	2020-05-05 12:01:41.481	0
260	528	2020-04-27 07:37:30.032	0
260	530	2020-04-27 07:37:30.032	1
260	531	2020-04-27 07:37:30.032	2
260	532	2020-04-27 07:37:30.032	3
260	533	2020-04-27 07:37:30.032	4
241	504	2020-05-05 11:54:32.705	0
241	550	2020-05-05 11:54:32.705	1
260	534	2020-04-27 07:37:30.032	5
260	536	2020-04-27 07:37:30.032	6
260	537	2020-04-27 07:37:30.032	7
260	538	2020-04-27 07:37:30.032	8
260	539	2020-04-27 07:37:30.032	9
260	540	2020-04-27 07:37:30.032	10
260	541	2020-04-27 07:37:30.032	11
260	542	2020-04-27 07:37:30.032	12
260	543	2020-04-27 07:37:30.032	13
260	527	2020-04-27 07:37:30.032	14
260	546	2020-04-27 07:37:30.032	15
260	545	2020-04-27 07:37:30.032	16
260	528	2020-05-07 08:52:30.191	0
260	539	2020-05-07 08:52:30.191	1
260	527	2020-05-07 08:52:30.191	2
260	546	2020-05-07 08:52:30.191	3
260	545	2020-05-07 08:52:30.191	4
203	551	2020-05-07 08:55:53.712	0
260	528	2020-05-07 12:04:27.778	0
260	561	2020-05-07 12:04:27.778	1
260	539	2020-05-07 12:04:27.778	2
260	527	2020-05-07 12:04:27.778	3
260	546	2020-05-07 12:04:27.778	4
260	545	2020-05-07 12:04:27.778	5
207	559	2020-05-07 08:57:05.125	0
207	559	2020-05-08 08:32:13.314	0
207	564	2020-05-08 08:32:13.314	1
207	562	2020-05-08 08:33:14.181	0
207	559	2020-05-08 08:33:14.181	1
207	565	2020-05-08 08:33:14.181	2
207	563	2020-05-08 08:33:14.181	3
207	562	2020-05-08 08:34:29.744	0
207	559	2020-05-08 08:34:29.744	1
207	566	2020-05-08 08:34:29.744	2
207	565	2020-05-08 08:34:29.744	3
207	563	2020-05-08 08:34:29.744	4
207	562	2020-05-08 08:35:41.728	0
207	568	2020-05-08 08:35:41.728	1
207	566	2020-05-08 08:35:41.728	2
207	565	2020-05-08 08:35:41.728	3
207	567	2020-05-08 08:35:41.728	4
200	445	2020-05-08 08:37:49.181	0
200	448	2020-05-08 08:37:49.181	1
200	569	2020-05-08 08:37:49.181	2
241	504	2020-05-08 11:14:55.458	0
241	504	2020-05-08 11:15:47.244	0
241	574	2020-05-08 11:15:47.244	1
234	493	2020-05-11 10:41:08.832	0
234	495	2020-05-11 10:41:08.832	1
234	494	2020-05-11 10:41:08.832	2
266	578	2020-05-14 08:31:03.81	0
267	579	2020-05-14 10:30:25.252	0
234	493	2020-05-14 10:43:49.944	0
234	495	2020-05-14 10:43:49.944	1
234	494	2020-05-14 10:43:49.944	2
234	493	2020-05-14 10:44:44.383	0
234	495	2020-05-14 10:44:44.383	1
234	494	2020-05-14 10:44:44.383	2
207	562	2020-05-14 11:54:08.008	0
207	568	2020-05-14 11:54:08.008	1
207	566	2020-05-14 11:54:08.008	2
207	565	2020-05-14 11:54:08.008	3
207	567	2020-05-14 11:54:08.008	4
234	493	2020-05-14 11:56:31.25	0
234	495	2020-05-14 11:56:31.25	1
234	494	2020-05-14 11:56:31.25	2
207	562	2020-05-14 12:04:47.045	0
207	568	2020-05-14 12:04:47.045	1
207	566	2020-05-14 12:04:47.045	2
207	565	2020-05-14 12:04:47.045	3
207	567	2020-05-14 12:04:47.045	4
207	562	2020-05-14 12:05:36.749	0
207	568	2020-05-14 12:05:36.749	1
207	566	2020-05-14 12:05:36.749	2
207	565	2020-05-14 12:05:36.749	3
207	567	2020-05-14 12:05:36.749	4
234	493	2020-05-14 12:15:02.84	0
234	495	2020-05-14 12:15:02.84	1
234	494	2020-05-14 12:15:02.84	2
207	562	2020-05-14 12:17:10.916	0
207	568	2020-05-14 12:17:10.916	1
207	566	2020-05-14 12:17:10.916	2
207	565	2020-05-14 12:17:10.916	3
207	567	2020-05-14 12:17:10.916	4
207	562	2020-05-14 12:31:10.462	0
207	568	2020-05-14 12:31:10.462	1
207	566	2020-05-14 12:31:10.462	2
207	565	2020-05-14 12:31:10.462	3
207	567	2020-05-14 12:31:10.462	4
207	562	2020-05-14 12:36:33.389	0
207	568	2020-05-14 12:36:33.389	1
207	566	2020-05-14 12:36:33.389	2
207	565	2020-05-14 12:36:33.389	3
207	567	2020-05-14 12:36:33.389	4
207	562	2020-05-14 12:38:37.982	0
207	568	2020-05-14 12:38:37.982	1
207	566	2020-05-14 12:38:37.982	2
207	565	2020-05-14 12:38:37.982	3
207	567	2020-05-14 12:38:37.982	4
207	562	2020-05-14 12:39:13.079	0
207	568	2020-05-14 12:39:13.079	1
207	566	2020-05-14 12:39:13.079	2
207	565	2020-05-14 12:39:13.079	3
207	567	2020-05-14 12:39:13.079	4
207	562	2020-05-14 12:39:35.461	0
207	568	2020-05-14 12:39:35.461	1
207	566	2020-05-14 12:39:35.461	2
207	565	2020-05-14 12:39:35.461	3
207	567	2020-05-14 12:39:35.461	4
207	562	2020-05-14 12:40:44.821	0
207	568	2020-05-14 12:40:44.821	1
207	566	2020-05-14 12:40:44.821	2
207	565	2020-05-14 12:40:44.821	3
207	567	2020-05-14 12:40:44.821	4
207	562	2020-05-14 12:41:31.347	0
207	568	2020-05-14 12:41:31.347	1
207	566	2020-05-14 12:41:31.347	2
207	565	2020-05-14 12:41:31.347	3
207	567	2020-05-14 12:41:31.347	4
207	562	2020-05-14 12:43:00.553	0
207	568	2020-05-14 12:43:00.553	1
207	566	2020-05-14 12:43:00.553	2
207	565	2020-05-14 12:43:00.553	3
207	567	2020-05-14 12:43:00.553	4
249	549	2020-05-14 12:49:13.505	0
249	592	2020-05-14 12:49:13.505	1
249	596	2020-05-15 06:24:52.472	0
249	549	2020-05-15 06:24:52.472	1
249	592	2020-05-15 06:24:52.472	2
263	558	2020-05-27 07:04:58.748	0
268	598	2020-05-27 07:12:33.971	0
233	599	2020-05-27 07:14:19.189	0
269	600	2020-05-27 07:15:46.571	0
95	233	2020-05-29 05:22:20.04	0
83	219	2020-05-29 05:23:08.262	0
79	215	2020-05-29 05:24:05.25	0
79	216	2020-05-29 05:24:05.25	1
228	485	2020-05-28 14:24:07.427	0
270	601	2020-06-02 13:55:50.727	0
257	605	2020-06-04 09:06:18.162	0
177	623	2020-06-10 09:50:47.133	0
177	624	2020-06-10 09:50:47.133	1
241	504	2020-06-11 06:10:55.928	0
284	626	2020-06-11 10:38:50.886	0
284	625	2020-06-11 10:38:50.886	1
277	612	2020-06-12 10:36:29.183	0
285	627	2020-06-22 06:04:04.367	0
285	629	2020-06-22 06:04:04.367	1
271	603	2020-06-04 09:02:21.799	0
271	604	2020-06-04 09:02:21.799	1
208	572	2020-05-08 08:51:40.715	0
285	628	2020-06-22 06:04:04.367	2
286	630	2020-06-22 06:07:31.139	0
287	631	2020-06-22 08:00:48.101	0
291	638	2020-06-30 09:58:16.228	0
268	598	2020-07-03 08:10:39.197	0
268	640	2020-07-03 08:10:39.197	1
268	598	2020-07-03 10:17:46.921	0
268	640	2020-07-03 10:17:46.921	1
268	641	2020-07-03 10:17:46.921	2
293	643	2020-07-03 11:10:48.338	0
293	644	2020-07-03 11:10:48.338	1
169	646	2020-07-03 11:30:39.205	0
169	647	2020-07-03 11:41:35.546	0
268	598	2020-07-03 10:36:55.091	0
268	640	2020-07-03 10:36:55.091	1
268	641	2020-07-03 10:36:55.091	2
268	642	2020-07-03 10:36:55.091	3
268	649	2020-07-08 08:18:22.025	0
267	580	2020-05-14 10:30:25.252	1
267	581	2020-05-14 10:30:25.252	2
246	573	2020-05-08 09:57:14.185	0
268	649	2020-07-09 10:40:18.934	0
268	650	2020-07-09 10:40:18.934	1
296	653	2020-07-15 11:13:14.535	0
267	654	2020-07-17 06:52:22.684	0
267	581	2020-07-17 06:52:22.684	1
279	616	2020-07-24 06:45:03.73	0
304	661	2020-07-28 11:32:22.805	0
306	667	2020-08-03 11:46:28.608	0
306	668	2020-08-03 11:46:28.608	1
306	664	2020-08-03 11:46:28.608	2
306	665	2020-08-03 11:46:28.608	3
300	672	2020-08-04 06:58:23.214	0
302	673	2020-08-05 08:43:39.286	0
282	620	2020-06-09 11:35:38.555	0
282	619	2020-06-09 11:35:38.555	1
301	687	2020-08-28 08:49:26.206	0
301	686	2020-08-28 08:49:26.206	1
312	688	2020-08-28 09:18:52.316	0
313	689	2020-08-28 09:28:00.632	0
314	690	2020-08-28 09:35:56.188	0
315	691	2020-08-28 10:00:54.341	0
316	692	2020-08-28 10:04:03.592	0
317	693	2020-08-28 10:15:07.361	0
318	694	2020-08-28 10:17:40.234	0
318	695	2020-08-28 10:17:40.234	1
318	694	2020-08-28 10:18:20.597	0
318	696	2020-08-28 10:18:20.597	1
313	697	2020-08-28 10:20:31.917	0
355	776	2020-09-17 06:21:19.021	0
313	697	2020-08-28 10:21:18.651	0
312	688	2020-08-28 09:20:08.513	0
290	636	2020-09-04 06:50:43.925	0
290	637	2020-09-04 06:50:43.925	1
306	667	2020-08-04 05:56:19.305	0
337	712	2020-09-10 07:21:12.429	0
338	713	2020-09-10 07:30:56.137	0
339	714	2020-09-10 07:33:30.762	0
339	715	2020-09-10 07:33:30.762	1
339	716	2020-09-10 07:33:30.762	2
339	717	2020-09-10 07:33:30.762	3
339	718	2020-09-10 07:33:30.762	4
339	719	2020-09-10 07:33:30.762	5
340	720	2020-09-10 07:38:43.859	0
340	721	2020-09-10 07:38:43.859	1
340	722	2020-09-10 07:38:43.859	2
340	723	2020-09-10 07:38:43.859	3
340	724	2020-09-10 07:38:43.859	4
340	725	2020-09-10 07:38:43.859	5
340	726	2020-09-10 07:38:43.859	6
340	727	2020-09-10 07:38:43.859	7
340	728	2020-09-10 07:38:43.859	8
340	729	2020-09-10 07:38:43.859	9
341	730	2020-09-10 07:44:19.31	0
341	731	2020-09-10 07:44:19.31	1
342	732	2020-09-10 07:49:00.333	0
342	733	2020-09-10 07:49:00.333	1
342	734	2020-09-10 07:49:00.333	2
343	736	2020-09-10 07:52:33.381	0
343	735	2020-09-10 07:52:33.381	1
343	737	2020-09-10 07:52:33.381	2
343	738	2020-09-10 07:52:33.381	3
344	740	2020-09-10 07:58:04.966	0
344	739	2020-09-10 07:58:04.966	1
344	741	2020-09-10 07:58:04.966	2
344	742	2020-09-10 07:58:04.966	3
344	743	2020-09-10 07:58:04.966	4
345	744	2020-09-10 08:06:07.127	0
345	746	2020-09-10 08:06:07.127	1
345	745	2020-09-10 08:06:07.127	2
345	747	2020-09-10 08:06:07.127	3
346	748	2020-09-10 08:11:27.055	0
346	749	2020-09-10 08:11:27.055	1
346	750	2020-09-10 08:11:27.055	2
346	751	2020-09-10 08:11:27.055	3
346	752	2020-09-10 08:11:27.055	4
347	753	2020-09-10 08:19:55.242	0
347	754	2020-09-10 08:19:55.242	1
347	755	2020-09-10 08:19:55.242	2
347	756	2020-09-10 08:19:55.242	3
347	757	2020-09-10 08:19:55.242	4
350	769	2020-09-10 08:37:12.418	0
350	770	2020-09-10 08:37:12.418	1
316	692	2020-09-03 10:09:54.012	0
316	710	2020-09-03 10:09:54.012	1
271	711	2020-09-04 06:50:06.979	0
271	604	2020-09-04 06:50:06.979	1
303	671	2020-08-04 06:51:48.398	0
312	688	2020-09-04 06:48:47.139	0
304	775	2020-09-15 06:13:39.691	0
208	571	2020-05-08 08:51:40.715	1
355	776	2020-09-15 10:23:30.611	0
356	777	2020-09-15 12:06:52.88	0
275	645	2020-07-03 11:16:29.734	0
348	760	2020-09-10 08:25:35.733	0
348	759	2020-09-10 08:25:35.733	1
288	632	2020-06-23 09:38:02.158	0
288	633	2020-06-23 09:38:02.158	1
351	771	2020-09-11 06:35:51.713	0
306	668	2020-08-04 05:56:19.305	1
306	670	2020-08-04 05:56:19.305	2
306	665	2020-08-04 05:56:19.305	3
354	774	2020-09-11 08:21:18.355	0
349	763	2020-09-10 08:32:28.875	0
349	764	2020-09-10 08:32:28.875	1
349	765	2020-09-10 08:32:28.875	2
349	766	2020-09-10 08:32:28.875	3
349	767	2020-09-10 08:32:28.875	4
382	841	2020-11-24 09:16:14.633	0
382	843	2020-11-26 09:32:04.21	0
358	781	2020-09-17 13:27:51.468	0
358	781	2020-09-17 13:32:07.832	0
358	782	2020-09-17 13:32:07.832	1
358	781	2020-09-18 07:53:57.491	0
391	866	2020-12-21 11:19:18.976	0
313	698	2020-08-28 10:21:18.651	1
360	785	2020-09-24 06:39:18.945	0
361	786	2020-09-24 11:15:01.648	0
363	795	2020-09-28 08:13:51.345	0
365	805	2020-10-01 04:55:39.909	0
365	806	2020-10-01 04:55:39.909	1
366	808	2020-10-01 05:15:27.053	0
366	807	2020-10-01 05:15:27.053	1
366	809	2020-10-01 05:15:27.053	2
366	810	2020-10-01 05:15:27.053	3
366	811	2020-10-01 05:15:27.053	4
365	805	2020-10-01 06:24:22.437	0
365	806	2020-10-01 06:24:22.437	1
365	815	2020-10-01 06:24:22.437	2
366	808	2020-10-01 06:30:52.79	0
366	807	2020-10-01 06:30:52.79	1
366	809	2020-10-01 06:30:52.79	2
366	810	2020-10-01 06:30:52.79	3
366	811	2020-10-01 06:30:52.79	4
366	816	2020-10-01 06:30:52.79	5
366	817	2020-10-01 06:30:52.79	6
382	842	2020-11-26 09:32:04.21	1
392	868	2021-01-12 12:30:05.052	0
394	873	2021-01-20 08:26:09.646	0
275	847	2020-12-01 11:42:01.043	0
275	645	2020-12-01 11:42:01.043	1
275	826	2020-12-01 11:42:01.043	2
348	758	2020-09-10 08:25:35.733	2
348	762	2020-09-10 08:25:35.733	3
348	761	2020-09-10 08:25:35.733	4
368	820	2020-10-08 06:31:33.598	0
366	808	2020-10-01 06:38:03.058	0
366	807	2020-10-01 06:38:03.058	1
366	809	2020-10-01 06:38:03.058	2
366	810	2020-10-01 06:38:03.058	3
366	811	2020-10-01 06:38:03.058	4
366	816	2020-10-01 06:38:03.058	5
366	817	2020-10-01 06:38:03.058	6
366	818	2020-10-01 06:38:03.058	7
310	848	2020-12-04 07:23:42.726	0
310	849	2020-12-04 07:23:42.726	1
380	839	2020-11-23 08:57:01.764	0
364	801	2020-09-28 09:30:02.97	0
364	796	2020-09-28 09:30:02.97	1
369	821	2020-10-13 05:27:15.109	0
394	875	2021-01-20 08:26:09.646	1
355	779	2020-09-17 06:21:19.021	1
367	812	2020-10-01 05:27:32.512	0
367	813	2020-10-01 05:27:32.512	1
367	814	2020-10-01 05:27:32.512	2
275	645	2020-10-20 09:57:43.884	0
275	822	2020-10-20 09:57:43.884	1
275	645	2020-10-20 10:01:47.231	0
275	823	2020-10-20 10:01:47.231	1
275	645	2020-10-20 10:05:37.756	0
275	824	2020-10-20 10:05:37.756	1
275	645	2020-10-20 10:42:08.085	0
275	825	2020-10-20 10:42:08.085	1
275	645	2020-10-20 10:42:59.722	0
275	826	2020-10-20 10:42:59.722	1
220	475	2020-04-03 11:11:08.016	0
220	477	2020-04-03 11:11:08.016	1
220	476	2020-04-03 11:11:08.016	2
279	616	2020-09-17 06:53:26.748	0
279	780	2020-09-17 06:53:26.748	1
370	827	2020-11-02 07:23:09.254	0
370	828	2020-11-02 07:23:55.951	0
275	645	2020-11-04 08:48:24.335	0
275	826	2020-11-04 08:48:24.335	1
275	831	2020-11-04 08:48:24.335	2
378	833	2020-11-09 07:48:33.527	0
364	798	2020-09-28 09:30:02.97	2
364	800	2020-09-28 09:30:02.97	3
364	797	2020-09-28 09:30:02.97	4
364	799	2020-09-28 09:30:02.97	5
364	802	2020-09-28 09:30:02.97	6
364	804	2020-09-28 09:30:02.97	7
364	803	2020-09-28 09:30:02.97	8
327	709	2020-09-03 07:46:03.682	0
362	790	2020-09-28 07:41:58.537	0
362	787	2020-09-28 07:41:58.537	1
362	791	2020-09-28 07:41:58.537	2
362	788	2020-09-28 07:41:58.537	3
362	793	2020-09-28 07:41:58.537	4
362	792	2020-09-28 07:41:58.537	5
362	794	2020-09-28 07:41:58.537	6
362	789	2020-09-28 07:41:58.537	7
385	860	2020-12-10 07:59:13.144	0
356	777	2020-10-05 10:35:36.165	0
356	819	2020-10-05 10:35:36.165	1
390	863	2020-12-21 09:26:58.037	0
354	774	2021-01-13 09:42:30.767	0
354	869	2021-01-13 09:42:30.767	1
355	776	2021-01-13 12:25:01.408	0
393	870	2021-01-14 08:31:41.535	0
393	871	2021-01-14 08:31:41.535	1
393	872	2021-01-14 08:31:41.535	2
349	768	2020-09-10 08:32:28.875	5
395	874	2021-01-14 08:34:36.763	0
395	874	2021-01-18 08:14:09.977	0
395	876	2021-01-18 08:14:09.977	1
395	874	2021-01-18 08:16:24.068	0
349	763	2021-01-18 08:28:47.426	0
349	764	2021-01-18 08:28:47.426	1
349	765	2021-01-18 08:28:47.426	2
349	766	2021-01-18 08:28:47.426	3
349	767	2021-01-18 08:28:47.426	4
349	768	2021-01-18 08:28:47.426	5
349	877	2021-01-18 08:28:47.426	6
394	878	2021-01-20 08:26:09.646	2
394	873	2021-01-20 08:26:40.265	0
394	875	2021-01-20 08:26:40.265	1
396	879	2021-01-20 13:35:01.869	0
309	684	2021-01-28 07:33:14.461	0
309	684	2021-01-28 07:34:18.877	0
309	880	2021-01-28 07:34:18.877	1
309	684	2021-01-28 07:35:01.075	0
396	879	2021-02-16 11:15:43.37	0
396	888	2021-02-16 11:15:43.37	1
396	879	2021-02-16 11:16:10.896	0
396	889	2021-02-16 11:16:10.896	1
399	890	2021-02-16 11:19:40.46	0
400	891	2021-02-18 08:27:18.669	0
306	669	2020-08-04 05:56:19.305	4
401	892	2021-02-19 06:58:37.604	0
292	639	2021-02-24 10:05:36.469	0
292	881	2021-02-24 10:05:36.469	1
396	879	2021-02-26 06:22:55.137	0
396	889	2021-02-26 06:22:55.137	1
396	893	2021-02-26 06:22:55.137	2
396	879	2021-02-26 06:23:19.098	0
396	889	2021-02-26 06:23:19.098	1
396	894	2021-02-26 06:23:19.098	2
395	874	2021-03-02 08:54:53.824	0
395	895	2021-03-02 08:54:53.824	1
395	874	2021-03-02 08:56:38.522	0
395	895	2021-03-02 08:56:38.522	1
395	896	2021-03-02 08:56:38.522	2
395	897	2021-03-02 08:56:38.522	3
395	898	2021-03-02 08:56:38.522	4
395	899	2021-03-02 08:56:38.522	5
381	840	2020-11-24 09:14:33.7	0
402	900	2021-03-15 09:31:47.199	0
403	901	2021-03-16 08:55:49.347	0
404	902	2021-03-16 08:58:10.961	0
405	903	2021-03-16 11:39:55.8	0
407	906	2021-03-16 11:49:17.241	0
407	907	2021-03-16 11:49:17.241	1
408	908	2021-03-16 11:55:46.248	0
408	909	2021-03-16 11:55:46.248	1
409	910	2021-03-16 12:11:37.106	0
409	911	2021-03-16 12:11:37.106	1
251	516	2021-03-19 06:16:59.065	0
359	784	2021-03-19 06:19:19.888	0
359	867	2021-03-19 06:19:19.888	1
354	913	2021-03-26 11:06:38.42	0
354	912	2021-03-26 11:06:38.42	1
354	913	2021-03-26 11:18:04.394	0
354	912	2021-03-26 11:18:04.394	1
354	914	2021-03-26 11:18:04.394	2
410	915	2021-04-14 13:37:31.957	0
410	915	2021-04-14 13:38:05.285	0
410	916	2021-04-14 13:38:05.285	1
406	904	2021-03-16 11:41:40.002	0
406	905	2021-03-16 11:41:40.002	1
300	672	2021-04-28 05:48:11.354	0
300	928	2021-04-28 05:48:11.354	1
420	929	2021-05-10 05:57:14.373	0
\.


--
-- Name: accessibilityapi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.accessibilityapi_id_seq', 1, false);


--
-- Name: accessibilitycontrol_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.accessibilitycontrol_id_seq', 1, false);


--
-- Name: accessibilityfeature_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.accessibilityfeature_id_seq', 275, true);


--
-- Name: accessibilityfeatureextension_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.accessibilityfeatureextension_id_seq', 11, true);


--
-- Name: accessibilityhazard_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.accessibilityhazard_id_seq', 247, true);


--
-- Name: accessibilityhazardextension_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.accessibilityhazardextension_id_seq', 9, true);


--
-- Name: alignmentobject_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.alignmentobject_id_seq', 1994, true);


--
-- Name: attachment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.attachment_id_seq', 126, true);


--
-- Name: author_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.author_id_seq', 556, true);


--
-- Name: collection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.collection_id_seq', 26, true);


--
-- Name: collectionaccessibilityfeature_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.collectionaccessibilityfeature_id_seq', 42, true);


--
-- Name: collectionaccessibilityhazard_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.collectionaccessibilityhazard_id_seq', 67, true);


--
-- Name: collectionalignmentobject_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.collectionalignmentobject_id_seq', 284, true);


--
-- Name: collectioneducationalaudience_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.collectioneducationalaudience_id_seq', 77, true);


--
-- Name: collectioneducationallevel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.collectioneducationallevel_id_seq', 75, true);


--
-- Name: collectioneducationaluse_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.collectioneducationaluse_id_seq', 74, true);


--
-- Name: collectionheading_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.collectionheading_id_seq', 84, true);


--
-- Name: collectionkeyword_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.collectionkeyword_id_seq', 206, true);


--
-- Name: collectionlanguage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.collectionlanguage_id_seq', 70, true);


--
-- Name: collectionthumbnail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.collectionthumbnail_id_seq', 10, true);


--
-- Name: educationalaudience_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.educationalaudience_id_seq', 625, true);


--
-- Name: educationallevel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.educationallevel_id_seq', 861, true);


--
-- Name: educationallevelextension_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.educationallevelextension_id_seq', 9, true);


--
-- Name: educationalmaterial_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.educationalmaterial_id_seq', 426, true);


--
-- Name: educationaluse_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.educationaluse_id_seq', 557, true);


--
-- Name: inlanguage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.inlanguage_id_seq', 1, false);


--
-- Name: isbasedon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.isbasedon_id_seq', 59, true);


--
-- Name: isbasedonauthor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.isbasedonauthor_id_seq', 72, true);


--
-- Name: keyword_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.keyword_id_seq', 1093, true);


--
-- Name: keywordextension_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.keywordextension_id_seq', 19, true);


--
-- Name: learningresourcetype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.learningresourcetype_id_seq', 683, true);


--
-- Name: logins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.logins_id_seq', 1, false);


--
-- Name: material_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.material_id_seq', 936, true);


--
-- Name: materialdescription_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.materialdescription_id_seq', 1482, true);


--
-- Name: materialdisplayname_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.materialdisplayname_id_seq', 4566, true);


--
-- Name: materialname_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.materialname_id_seq', 1998, true);


--
-- Name: publisher_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.publisher_id_seq', 77, true);


--
-- Name: rating_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.rating_id_seq', 39, true);


--
-- Name: record_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.record_id_seq', 804, true);


--
-- Name: temporaryattachment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.temporaryattachment_id_seq', 126, true);


--
-- Name: temporaryrecord_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.temporaryrecord_id_seq', 810, true);


--
-- Name: thumbnail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.thumbnail_id_seq', 77, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aoe_admin
--

SELECT pg_catalog.setval('public.users_id_seq', 31, true);


--
-- Name: accessibilityapi accessibilityapi_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.accessibilityapi
    ADD CONSTRAINT accessibilityapi_pkey PRIMARY KEY (id);


--
-- Name: accessibilitycontrol accessibilitycontrol_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.accessibilitycontrol
    ADD CONSTRAINT accessibilitycontrol_pkey PRIMARY KEY (id);


--
-- Name: accessibilityfeature accessibilityfeature_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.accessibilityfeature
    ADD CONSTRAINT accessibilityfeature_pkey PRIMARY KEY (id);


--
-- Name: accessibilityfeatureextension accessibilityfeatureextension_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.accessibilityfeatureextension
    ADD CONSTRAINT accessibilityfeatureextension_pkey PRIMARY KEY (id);


--
-- Name: accessibilityhazard accessibilityhazard_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.accessibilityhazard
    ADD CONSTRAINT accessibilityhazard_pkey PRIMARY KEY (id);


--
-- Name: accessibilityhazardextension accessibilityhazardextension_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.accessibilityhazardextension
    ADD CONSTRAINT accessibilityhazardextension_pkey PRIMARY KEY (id);


--
-- Name: alignmentobject alignmentobject_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.alignmentobject
    ADD CONSTRAINT alignmentobject_pkey PRIMARY KEY (id);


--
-- Name: aoeuser aoeuser_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.aoeuser
    ADD CONSTRAINT aoeuser_pkey PRIMARY KEY (username);


--
-- Name: attachment attachment_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.attachment
    ADD CONSTRAINT attachment_pkey PRIMARY KEY (id);


--
-- Name: attachmentversioncomposition attachmentversioncomposition_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.attachmentversioncomposition
    ADD CONSTRAINT attachmentversioncomposition_pkey PRIMARY KEY (versioneducationalmaterialid, versionmaterialid, versionpublishedat, attachmentid);


--
-- Name: author author_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.author
    ADD CONSTRAINT author_pkey PRIMARY KEY (id);


--
-- Name: collection collection_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.collection
    ADD CONSTRAINT collection_pkey PRIMARY KEY (id);


--
-- Name: collectionaccessibilityfeature collectionaccessibilityfeature_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.collectionaccessibilityfeature
    ADD CONSTRAINT collectionaccessibilityfeature_pkey PRIMARY KEY (id);


--
-- Name: collectionaccessibilityhazard collectionaccessibilityhazard_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.collectionaccessibilityhazard
    ADD CONSTRAINT collectionaccessibilityhazard_pkey PRIMARY KEY (id);


--
-- Name: collectionalignmentobject collectionalignmentobject_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.collectionalignmentobject
    ADD CONSTRAINT collectionalignmentobject_pkey PRIMARY KEY (id);


--
-- Name: collectioneducationalaudience collectioneducationalaudience_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.collectioneducationalaudience
    ADD CONSTRAINT collectioneducationalaudience_pkey PRIMARY KEY (id);


--
-- Name: collectioneducationallevel collectioneducationallevel_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.collectioneducationallevel
    ADD CONSTRAINT collectioneducationallevel_pkey PRIMARY KEY (id);


--
-- Name: collectioneducationalmaterial collectioneducationalmaterial_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.collectioneducationalmaterial
    ADD CONSTRAINT collectioneducationalmaterial_pkey PRIMARY KEY (collectionid, educationalmaterialid);


--
-- Name: collectioneducationaluse collectioneducationaluse_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.collectioneducationaluse
    ADD CONSTRAINT collectioneducationaluse_pkey PRIMARY KEY (id);


--
-- Name: collectionheading collectionheading_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.collectionheading
    ADD CONSTRAINT collectionheading_pkey PRIMARY KEY (id);


--
-- Name: collectionkeyword collectionkeyword_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.collectionkeyword
    ADD CONSTRAINT collectionkeyword_pkey PRIMARY KEY (id);


--
-- Name: collectionlanguage collectionlanguage_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.collectionlanguage
    ADD CONSTRAINT collectionlanguage_pkey PRIMARY KEY (id);


--
-- Name: collectionthumbnail collectionthumbnail_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.collectionthumbnail
    ADD CONSTRAINT collectionthumbnail_pkey PRIMARY KEY (id);


--
-- Name: accessibilityfeature constraint_accessibilityfeature; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.accessibilityfeature
    ADD CONSTRAINT constraint_accessibilityfeature UNIQUE (accessibilityfeaturekey, educationalmaterialid);


--
-- Name: accessibilityfeatureextension constraint_accessibilityfeatureextension; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.accessibilityfeatureextension
    ADD CONSTRAINT constraint_accessibilityfeatureextension UNIQUE (accessibilityfeaturekey, educationalmaterialid);


--
-- Name: accessibilityhazard constraint_accessibilityhazard; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.accessibilityhazard
    ADD CONSTRAINT constraint_accessibilityhazard UNIQUE (accessibilityhazardkey, educationalmaterialid);


--
-- Name: accessibilityhazardextension constraint_accessibilityhazardextension; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.accessibilityhazardextension
    ADD CONSTRAINT constraint_accessibilityhazardextension UNIQUE (accessibilityhazardkey, educationalmaterialid);


--
-- Name: alignmentobject constraint_alignmentobject; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.alignmentobject
    ADD CONSTRAINT constraint_alignmentobject UNIQUE (alignmenttype, objectkey, source, educationalmaterialid);


--
-- Name: educationalaudience constraint_educationalaudience; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.educationalaudience
    ADD CONSTRAINT constraint_educationalaudience UNIQUE (educationalrolekey, educationalmaterialid);


--
-- Name: educationallevel constraint_educationallevel; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.educationallevel
    ADD CONSTRAINT constraint_educationallevel UNIQUE (educationallevelkey, educationalmaterialid);


--
-- Name: educationallevelextension constraint_educationallevelextension; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.educationallevelextension
    ADD CONSTRAINT constraint_educationallevelextension UNIQUE (educationallevelkey, educationalmaterialid);


--
-- Name: educationaluse constraint_educationaluse; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.educationaluse
    ADD CONSTRAINT constraint_educationaluse UNIQUE (educationalusekey, educationalmaterialid);


--
-- Name: inlanguage constraint_inlanguage; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.inlanguage
    ADD CONSTRAINT constraint_inlanguage UNIQUE (inlanguage, educationalmaterialid);


--
-- Name: isbasedon constraint_isbasedon; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.isbasedon
    ADD CONSTRAINT constraint_isbasedon UNIQUE (materialname, educationalmaterialid);


--
-- Name: keyword constraint_keyword; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.keyword
    ADD CONSTRAINT constraint_keyword UNIQUE (keywordkey, educationalmaterialid);


--
-- Name: keywordextension constraint_keywordextension; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.keywordextension
    ADD CONSTRAINT constraint_keywordextension UNIQUE (keywordkey, educationalmaterialid);


--
-- Name: materialname constraint_lang_id; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.materialname
    ADD CONSTRAINT constraint_lang_id UNIQUE (language, educationalmaterialid);


--
-- Name: learningresourcetype constraint_learningresourcetype; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.learningresourcetype
    ADD CONSTRAINT constraint_learningresourcetype UNIQUE (learningresourcetypekey, educationalmaterialid);


--
-- Name: materialdescription constraint_materialdescription_lang_id; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.materialdescription
    ADD CONSTRAINT constraint_materialdescription_lang_id UNIQUE (language, educationalmaterialid);


--
-- Name: materialdisplayname constraint_materialdisplayname; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.materialdisplayname
    ADD CONSTRAINT constraint_materialdisplayname UNIQUE (language, materialid);


--
-- Name: publisher constraint_publisher; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.publisher
    ADD CONSTRAINT constraint_publisher UNIQUE (publisherkey, educationalmaterialid);


--
-- Name: rating constraint_rating; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT constraint_rating UNIQUE (usersusername, educationalmaterialid);


--
-- Name: educationalaudience educationalaudience_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.educationalaudience
    ADD CONSTRAINT educationalaudience_pkey PRIMARY KEY (id);


--
-- Name: educationallevel educationallevel_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.educationallevel
    ADD CONSTRAINT educationallevel_pkey PRIMARY KEY (id);


--
-- Name: educationallevelextension educationallevelextension_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.educationallevelextension
    ADD CONSTRAINT educationallevelextension_pkey PRIMARY KEY (id);


--
-- Name: educationalmaterial educationalmaterial_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.educationalmaterial
    ADD CONSTRAINT educationalmaterial_pkey PRIMARY KEY (id);


--
-- Name: educationalmaterialversion educationalmaterialversion_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.educationalmaterialversion
    ADD CONSTRAINT educationalmaterialversion_pkey PRIMARY KEY (educationalmaterialid, publishedat);


--
-- Name: educationaluse educationaluse_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.educationaluse
    ADD CONSTRAINT educationaluse_pkey PRIMARY KEY (id);


--
-- Name: inlanguage inlanguage_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.inlanguage
    ADD CONSTRAINT inlanguage_pkey PRIMARY KEY (id);


--
-- Name: isbasedon isbasedon_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.isbasedon
    ADD CONSTRAINT isbasedon_pkey PRIMARY KEY (id);


--
-- Name: isbasedonauthor isbasedonauthor_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.isbasedonauthor
    ADD CONSTRAINT isbasedonauthor_pkey PRIMARY KEY (id);


--
-- Name: keyword keyword_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.keyword
    ADD CONSTRAINT keyword_pkey PRIMARY KEY (id);


--
-- Name: keywordextension keywordextension_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.keywordextension
    ADD CONSTRAINT keywordextension_pkey PRIMARY KEY (id);


--
-- Name: learningresourcetype learningresourcetype_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.learningresourcetype
    ADD CONSTRAINT learningresourcetype_pkey PRIMARY KEY (id);


--
-- Name: licensecode licensecode_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.licensecode
    ADD CONSTRAINT licensecode_pkey PRIMARY KEY (code);


--
-- Name: logins logins_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.logins
    ADD CONSTRAINT logins_pkey PRIMARY KEY (id);


--
-- Name: material material_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.material
    ADD CONSTRAINT material_pkey PRIMARY KEY (id);


--
-- Name: materialdescription materialdescription_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.materialdescription
    ADD CONSTRAINT materialdescription_pkey PRIMARY KEY (id);


--
-- Name: materialdisplayname materialdisplayname_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.materialdisplayname
    ADD CONSTRAINT materialdisplayname_pkey PRIMARY KEY (id);


--
-- Name: materialname materialname_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.materialname
    ADD CONSTRAINT materialname_pkey PRIMARY KEY (id);


--
-- Name: publisher publisher_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.publisher
    ADD CONSTRAINT publisher_pkey PRIMARY KEY (id);


--
-- Name: rating rating_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT rating_pkey PRIMARY KEY (id);


--
-- Name: record record_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.record
    ADD CONSTRAINT record_pkey PRIMARY KEY (id);


--
-- Name: temporaryattachment temporaryattachment_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.temporaryattachment
    ADD CONSTRAINT temporaryattachment_pkey PRIMARY KEY (id);


--
-- Name: temporaryrecord temporaryrecord_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.temporaryrecord
    ADD CONSTRAINT temporaryrecord_pkey PRIMARY KEY (id);


--
-- Name: thumbnail thumbnail_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.thumbnail
    ADD CONSTRAINT thumbnail_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (username);


--
-- Name: userscollection userscollection_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.userscollection
    ADD CONSTRAINT userscollection_pkey PRIMARY KEY (collectionid, usersusername);


--
-- Name: versioncomposition versioncomposition_pkey; Type: CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.versioncomposition
    ADD CONSTRAINT versioncomposition_pkey PRIMARY KEY (educationalmaterialid, materialid, publishedat);


--
-- Name: accessibilityfeature fk_accessibilityfeature; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.accessibilityfeature
    ADD CONSTRAINT fk_accessibilityfeature FOREIGN KEY (educationalmaterialid) REFERENCES public.educationalmaterial(id) ON DELETE CASCADE;


--
-- Name: accessibilityhazard fk_accessibilityhazard; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.accessibilityhazard
    ADD CONSTRAINT fk_accessibilityhazard FOREIGN KEY (educationalmaterialid) REFERENCES public.educationalmaterial(id);


--
-- Name: author fk_author; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.author
    ADD CONSTRAINT fk_author FOREIGN KEY (educationalmaterialid) REFERENCES public.educationalmaterial(id) ON DELETE CASCADE;


--
-- Name: materialdescription fk_description; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.materialdescription
    ADD CONSTRAINT fk_description FOREIGN KEY (educationalmaterialid) REFERENCES public.educationalmaterial(id);


--
-- Name: educationallevel fk_educationallevel; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.educationallevel
    ADD CONSTRAINT fk_educationallevel FOREIGN KEY (educationalmaterialid) REFERENCES public.educationalmaterial(id) ON DELETE CASCADE;


--
-- Name: materialdisplayname fk_materialdisplayname; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.materialdisplayname
    ADD CONSTRAINT fk_materialdisplayname FOREIGN KEY (materialid) REFERENCES public.material(id) ON DELETE CASCADE;


--
-- Name: materialname fk_materialname; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.materialname
    ADD CONSTRAINT fk_materialname FOREIGN KEY (educationalmaterialid) REFERENCES public.educationalmaterial(id);


--
-- Name: publisher fk_publisher; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.publisher
    ADD CONSTRAINT fk_publisher FOREIGN KEY (educationalmaterialid) REFERENCES public.educationalmaterial(id);


--
-- Name: temporaryrecord fk_temporaryrecord; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.temporaryrecord
    ADD CONSTRAINT fk_temporaryrecord FOREIGN KEY (materialid) REFERENCES public.material(id);


--
-- Name: thumbnail fk_thumbnail; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.thumbnail
    ADD CONSTRAINT fk_thumbnail FOREIGN KEY (educationalmaterialid) REFERENCES public.educationalmaterial(id);


--
-- Name: accessibilityfeatureextension fkaccessibilityfeatureextension; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.accessibilityfeatureextension
    ADD CONSTRAINT fkaccessibilityfeatureextension FOREIGN KEY (educationalmaterialid) REFERENCES public.educationalmaterial(id);


--
-- Name: accessibilityhazardextension fkaccessibilityhazardextension; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.accessibilityhazardextension
    ADD CONSTRAINT fkaccessibilityhazardextension FOREIGN KEY (educationalmaterialid) REFERENCES public.educationalmaterial(id);


--
-- Name: alignmentobject fkalignmentobject; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.alignmentobject
    ADD CONSTRAINT fkalignmentobject FOREIGN KEY (educationalmaterialid) REFERENCES public.educationalmaterial(id) ON DELETE CASCADE;


--
-- Name: attachmentversioncomposition fkattachmentversion; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.attachmentversioncomposition
    ADD CONSTRAINT fkattachmentversion FOREIGN KEY (attachmentid) REFERENCES public.attachment(id);


--
-- Name: collectionaccessibilityfeature fkcollectionaccessibilityfeature; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.collectionaccessibilityfeature
    ADD CONSTRAINT fkcollectionaccessibilityfeature FOREIGN KEY (collectionid) REFERENCES public.collection(id);


--
-- Name: collectionaccessibilityhazard fkcollectionaccessibilityhazard; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.collectionaccessibilityhazard
    ADD CONSTRAINT fkcollectionaccessibilityhazard FOREIGN KEY (collectionid) REFERENCES public.collection(id);


--
-- Name: collectionalignmentobject fkcollectionaligmentobject; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.collectionalignmentobject
    ADD CONSTRAINT fkcollectionaligmentobject FOREIGN KEY (collectionid) REFERENCES public.collection(id) ON DELETE CASCADE;


--
-- Name: collectioneducationalaudience fkcollectioneducationalaudience; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.collectioneducationalaudience
    ADD CONSTRAINT fkcollectioneducationalaudience FOREIGN KEY (collectionid) REFERENCES public.collection(id) ON DELETE CASCADE;


--
-- Name: collectioneducationallevel fkcollectioneducationallevel; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.collectioneducationallevel
    ADD CONSTRAINT fkcollectioneducationallevel FOREIGN KEY (collectionid) REFERENCES public.collection(id) ON DELETE CASCADE;


--
-- Name: collectioneducationaluse fkcollectioneducationaluse; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.collectioneducationaluse
    ADD CONSTRAINT fkcollectioneducationaluse FOREIGN KEY (collectionid) REFERENCES public.collection(id) ON DELETE CASCADE;


--
-- Name: collectionheading fkcollectionheading; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.collectionheading
    ADD CONSTRAINT fkcollectionheading FOREIGN KEY (collectionid) REFERENCES public.collection(id);


--
-- Name: collectionkeyword fkcollectionkeywords; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.collectionkeyword
    ADD CONSTRAINT fkcollectionkeywords FOREIGN KEY (collectionid) REFERENCES public.collection(id) ON DELETE CASCADE;


--
-- Name: collectionlanguage fkcollectionlanguage; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.collectionlanguage
    ADD CONSTRAINT fkcollectionlanguage FOREIGN KEY (collectionid) REFERENCES public.collection(id) ON DELETE CASCADE;


--
-- Name: collectioneducationalmaterial fkcollectionmaterial; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.collectioneducationalmaterial
    ADD CONSTRAINT fkcollectionmaterial FOREIGN KEY (collectionid) REFERENCES public.collection(id) ON DELETE CASCADE;


--
-- Name: collectionthumbnail fkcollectionthumbnail; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.collectionthumbnail
    ADD CONSTRAINT fkcollectionthumbnail FOREIGN KEY (collectionid) REFERENCES public.collection(id);


--
-- Name: userscollection fkcollectionusers; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.userscollection
    ADD CONSTRAINT fkcollectionusers FOREIGN KEY (collectionid) REFERENCES public.collection(id) ON DELETE CASCADE;


--
-- Name: educationalaudience fkeducationalaudience; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.educationalaudience
    ADD CONSTRAINT fkeducationalaudience FOREIGN KEY (educationalmaterialid) REFERENCES public.educationalmaterial(id) ON DELETE CASCADE;


--
-- Name: educationallevelextension fkeducationallevelextension; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.educationallevelextension
    ADD CONSTRAINT fkeducationallevelextension FOREIGN KEY (educationalmaterialid) REFERENCES public.educationalmaterial(id);


--
-- Name: educationalmaterial fkeducationalmaterial; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.educationalmaterial
    ADD CONSTRAINT fkeducationalmaterial FOREIGN KEY (usersusername) REFERENCES public.users(username) ON DELETE RESTRICT;


--
-- Name: versioncomposition fkeducationalmaterialversion; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.versioncomposition
    ADD CONSTRAINT fkeducationalmaterialversion FOREIGN KEY (educationalmaterialid) REFERENCES public.educationalmaterial(id);


--
-- Name: educationaluse fkeducationaluse; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.educationaluse
    ADD CONSTRAINT fkeducationaluse FOREIGN KEY (educationalmaterialid) REFERENCES public.educationalmaterial(id) ON DELETE CASCADE;


--
-- Name: educationalmaterialversion fkemversion; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.educationalmaterialversion
    ADD CONSTRAINT fkemversion FOREIGN KEY (educationalmaterialid) REFERENCES public.educationalmaterial(id);


--
-- Name: inlanguage fkinlanguage; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.inlanguage
    ADD CONSTRAINT fkinlanguage FOREIGN KEY (educationalmaterialid) REFERENCES public.educationalmaterial(id) ON DELETE CASCADE;


--
-- Name: isbasedon fkisbasedon; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.isbasedon
    ADD CONSTRAINT fkisbasedon FOREIGN KEY (educationalmaterialid) REFERENCES public.educationalmaterial(id) ON DELETE CASCADE;


--
-- Name: isbasedonauthor fkisbasedonauthor; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.isbasedonauthor
    ADD CONSTRAINT fkisbasedonauthor FOREIGN KEY (isbasedonid) REFERENCES public.isbasedon(id);


--
-- Name: keyword fkkeyword; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.keyword
    ADD CONSTRAINT fkkeyword FOREIGN KEY (educationalmaterialid) REFERENCES public.educationalmaterial(id) ON DELETE CASCADE;


--
-- Name: keywordextension fkkeywordextension; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.keywordextension
    ADD CONSTRAINT fkkeywordextension FOREIGN KEY (usersusername) REFERENCES public.users(username);


--
-- Name: learningresourcetype fklearningresourcetype; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.learningresourcetype
    ADD CONSTRAINT fklearningresourcetype FOREIGN KEY (educationalmaterialid) REFERENCES public.educationalmaterial(id) ON DELETE CASCADE;


--
-- Name: material fkmaterial; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.material
    ADD CONSTRAINT fkmaterial FOREIGN KEY (educationalmaterialid) REFERENCES public.educationalmaterial(id) ON DELETE RESTRICT;


--
-- Name: collectioneducationalmaterial fkmaterialcollection; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.collectioneducationalmaterial
    ADD CONSTRAINT fkmaterialcollection FOREIGN KEY (educationalmaterialid) REFERENCES public.educationalmaterial(id) ON DELETE RESTRICT;


--
-- Name: versioncomposition fkmaterialversion; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.versioncomposition
    ADD CONSTRAINT fkmaterialversion FOREIGN KEY (materialid) REFERENCES public.material(id);


--
-- Name: rating fkratingeducationalmaterial; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT fkratingeducationalmaterial FOREIGN KEY (educationalmaterialid) REFERENCES public.educationalmaterial(id);


--
-- Name: rating fkratingusers; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT fkratingusers FOREIGN KEY (usersusername) REFERENCES public.users(username);


--
-- Name: record fkrecord; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.record
    ADD CONSTRAINT fkrecord FOREIGN KEY (materialid) REFERENCES public.material(id) ON DELETE RESTRICT;


--
-- Name: temporaryattachment fktempattachment; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.temporaryattachment
    ADD CONSTRAINT fktempattachment FOREIGN KEY (attachmentid) REFERENCES public.attachment(id);


--
-- Name: accessibilityfeatureextension fkuseraccessibilityfeatureextension; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.accessibilityfeatureextension
    ADD CONSTRAINT fkuseraccessibilityfeatureextension FOREIGN KEY (usersusername) REFERENCES public.users(username);


--
-- Name: accessibilityhazardextension fkusersaccessibiltyhazardextension; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.accessibilityhazardextension
    ADD CONSTRAINT fkusersaccessibiltyhazardextension FOREIGN KEY (usersusername) REFERENCES public.users(username);


--
-- Name: userscollection fkuserscollection; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.userscollection
    ADD CONSTRAINT fkuserscollection FOREIGN KEY (usersusername) REFERENCES public.users(username);


--
-- Name: educationallevelextension fkuserseducationallevelextension; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.educationallevelextension
    ADD CONSTRAINT fkuserseducationallevelextension FOREIGN KEY (usersusername) REFERENCES public.users(username);


--
-- Name: keywordextension fkuserskeywordextension; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.keywordextension
    ADD CONSTRAINT fkuserskeywordextension FOREIGN KEY (educationalmaterialid) REFERENCES public.educationalmaterial(id);


--
-- Name: versioncomposition fkversioncomposition; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.versioncomposition
    ADD CONSTRAINT fkversioncomposition FOREIGN KEY (educationalmaterialid, publishedat) REFERENCES public.educationalmaterialversion(educationalmaterialid, publishedat);


--
-- Name: attachmentversioncomposition fkversioncompositionattachment; Type: FK CONSTRAINT; Schema: public; Owner: aoe_admin
--

ALTER TABLE ONLY public.attachmentversioncomposition
    ADD CONSTRAINT fkversioncompositionattachment FOREIGN KEY (versioneducationalmaterialid, versionmaterialid, versionpublishedat) REFERENCES public.versioncomposition(educationalmaterialid, materialid, publishedat);


--
-- PostgreSQL database dump complete
--

