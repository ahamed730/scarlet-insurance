--
-- PostgreSQL database dump
--

-- Dumped from database version 10.21
-- Dumped by pg_dump version 10.21

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
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id bigint NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: homepage_account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.homepage_account (
    id bigint NOT NULL,
    password character varying(128) NOT NULL,
    type_of_account character varying(255) NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    username character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    phone_number character varying(50) NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    last_login timestamp with time zone NOT NULL,
    is_admin boolean NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    is_superadmin boolean NOT NULL
);


ALTER TABLE public.homepage_account OWNER TO postgres;

--
-- Name: homepage_account_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.homepage_account_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.homepage_account_id_seq OWNER TO postgres;

--
-- Name: homepage_account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.homepage_account_id_seq OWNED BY public.homepage_account.id;


--
-- Name: homepage_appointment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.homepage_appointment (
    id bigint NOT NULL,
    provider_id bigint NOT NULL,
    patient_id bigint NOT NULL,
    "time" timestamp with time zone,
    reason_for_appointment text
);


ALTER TABLE public.homepage_appointment OWNER TO postgres;

--
-- Name: homepage_appointment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.homepage_appointment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.homepage_appointment_id_seq OWNER TO postgres;

--
-- Name: homepage_appointment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.homepage_appointment_id_seq OWNED BY public.homepage_appointment.id;


--
-- Name: homepage_doctorinformation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.homepage_doctorinformation (
    id bigint NOT NULL,
    specialty character varying(255) NOT NULL,
    location character varying(255) NOT NULL,
    doctor_id bigint
);


ALTER TABLE public.homepage_doctorinformation OWNER TO postgres;

--
-- Name: homepage_doctorinformation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.homepage_doctorinformation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.homepage_doctorinformation_id_seq OWNER TO postgres;

--
-- Name: homepage_doctorinformation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.homepage_doctorinformation_id_seq OWNED BY public.homepage_doctorinformation.id;


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: homepage_account id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.homepage_account ALTER COLUMN id SET DEFAULT nextval('public.homepage_account_id_seq'::regclass);


--
-- Name: homepage_appointment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.homepage_appointment ALTER COLUMN id SET DEFAULT nextval('public.homepage_appointment_id_seq'::regclass);


--
-- Name: homepage_doctorinformation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.homepage_doctorinformation ALTER COLUMN id SET DEFAULT nextval('public.homepage_doctorinformation_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	4	add_logentry
2	Can change log entry	4	change_logentry
3	Can delete log entry	4	delete_logentry
4	Can view log entry	4	view_logentry
5	Can add permission	5	add_permission
6	Can change permission	5	change_permission
7	Can delete permission	5	delete_permission
8	Can view permission	5	view_permission
9	Can add group	6	add_group
10	Can change group	6	change_group
11	Can delete group	6	delete_group
12	Can view group	6	view_group
13	Can add content type	7	add_contenttype
14	Can change content type	7	change_contenttype
15	Can delete content type	7	delete_contenttype
16	Can view content type	7	view_contenttype
17	Can add session	8	add_session
18	Can change session	8	change_session
19	Can delete session	8	delete_session
20	Can view session	8	view_session
21	Can add account	1	add_account
22	Can change account	1	change_account
23	Can delete account	1	delete_account
24	Can view account	1	view_account
25	Can add doctor	2	add_doctor
26	Can change doctor	2	change_doctor
27	Can delete doctor	2	delete_doctor
28	Can view doctor	2	view_doctor
29	Can add patient	3	add_patient
30	Can change patient	3	change_patient
31	Can delete patient	3	delete_patient
32	Can view patient	3	view_patient
33	Can add Doctor Information	9	add_doctorinformation
34	Can change Doctor Information	9	change_doctorinformation
35	Can delete Doctor Information	9	delete_doctorinformation
36	Can view Doctor Information	9	view_doctorinformation
37	Can add Appointment	10	add_appointment
38	Can change Appointment	10	change_appointment
39	Can delete Appointment	10	delete_appointment
40	Can view Appointment	10	view_appointment
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	homepage	account
2	homepage	doctor
3	homepage	patient
4	admin	logentry
5	auth	permission
6	auth	group
7	contenttypes	contenttype
8	sessions	session
9	homepage	doctorinformation
10	homepage	appointment
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2022-07-20 09:16:22.962019-04
2	admin	0001_initial	2022-07-20 09:16:51.327386-04
3	admin	0002_logentry_remove_auto_add	2022-07-20 09:16:51.33463-04
4	admin	0003_logentry_add_action_flag_choices	2022-07-20 09:16:51.340835-04
5	contenttypes	0002_remove_content_type_name	2022-07-20 09:16:51.357463-04
6	auth	0001_initial	2022-07-20 09:16:51.402425-04
7	auth	0002_alter_permission_name_max_length	2022-07-20 09:16:51.410794-04
8	auth	0003_alter_user_email_max_length	2022-07-20 09:16:51.417483-04
9	auth	0004_alter_user_username_opts	2022-07-20 09:16:51.424345-04
10	auth	0005_alter_user_last_login_null	2022-07-20 09:16:51.431603-04
11	auth	0006_require_contenttypes_0002	2022-07-20 09:16:51.433708-04
12	auth	0007_alter_validators_add_error_messages	2022-07-20 09:16:51.440431-04
13	auth	0008_alter_user_username_max_length	2022-07-20 09:16:51.447937-04
14	auth	0009_alter_user_last_name_max_length	2022-07-20 09:16:51.456305-04
15	auth	0010_alter_group_name_max_length	2022-07-20 09:16:51.465993-04
16	auth	0011_update_proxy_permissions	2022-07-20 09:16:51.489253-04
17	auth	0012_alter_user_first_name_max_length	2022-07-20 09:16:51.495994-04
18	sessions	0001_initial	2022-07-20 09:16:51.507838-04
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
8ewylyygjey07wlcyya8owemoh6oufcy	.eJxVjEEOwiAQRe_C2hBGpIBL9z0DmWGmUjU0Ke3KeHfbpAvd_vfef6uE61LS2mROI6urAnX63QjzU-oO-IH1Puk81WUeSe-KPmjT_cTyuh3u30HBVrY6izPAFvyZbTBg-YLRRRPAZEKwAyEPcYOOUXIn4MVSRz5ghCgiUX2-33I4XQ:1oE9bA:51vUp2VjrYREotm9KbnSIqvaaDTyVnKFII8inhdmxGU	2022-08-03 09:18:44.567169-04
\.


--
-- Data for Name: homepage_account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.homepage_account (id, password, type_of_account, first_name, last_name, username, email, phone_number, date_joined, last_login, is_admin, is_staff, is_active, is_superadmin) FROM stdin;
1	pbkdf2_sha256$260000$Kp69jmFfcTO1QLN9F417Op$mecClPsKuoiqEtMIDq9aCM0r2aDKOZKlfKqSnazXtWw=	ADMIN	Admin	Admin	admin	admin@ibmedical.com		2022-07-20 09:18:28.815309-04	2022-07-20 09:18:44.561509-04	t	t	t	t
\.


--
-- Data for Name: homepage_appointment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.homepage_appointment (id, provider_id, patient_id, "time", reason_for_appointment) FROM stdin;
\.


--
-- Data for Name: homepage_doctorinformation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.homepage_doctorinformation (id, specialty, location, doctor_id) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 40, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 10, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 18, true);


--
-- Name: homepage_account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.homepage_account_id_seq', 1, true);


--
-- Name: homepage_appointment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.homepage_appointment_id_seq', 1, false);


--
-- Name: homepage_doctorinformation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.homepage_doctorinformation_id_seq', 1, false);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: homepage_account homepage_account_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.homepage_account
    ADD CONSTRAINT homepage_account_email_key UNIQUE (email);


--
-- Name: homepage_account homepage_account_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.homepage_account
    ADD CONSTRAINT homepage_account_pkey PRIMARY KEY (id);


--
-- Name: homepage_account homepage_account_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.homepage_account
    ADD CONSTRAINT homepage_account_username_key UNIQUE (username);


--
-- Name: homepage_appointment homepage_appointment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.homepage_appointment
    ADD CONSTRAINT homepage_appointment_pkey PRIMARY KEY (id);


--
-- Name: homepage_doctorinformation homepage_doctorinformation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.homepage_doctorinformation
    ADD CONSTRAINT homepage_doctorinformation_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: homepage_account_email_26af660b_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX homepage_account_email_26af660b_like ON public.homepage_account USING btree (email varchar_pattern_ops);


--
-- Name: homepage_account_username_49411efb_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX homepage_account_username_49411efb_like ON public.homepage_account USING btree (username varchar_pattern_ops);


--
-- Name: homepage_appointment_patient_id_a3883c46; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX homepage_appointment_patient_id_a3883c46 ON public.homepage_appointment USING btree (patient_id);


--
-- Name: homepage_appointment_provider_id_706c8733; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX homepage_appointment_provider_id_706c8733 ON public.homepage_appointment USING btree (provider_id);


--
-- Name: homepage_doctorinformation_doctor_id_631092fe; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX homepage_doctorinformation_doctor_id_631092fe ON public.homepage_doctorinformation USING btree (doctor_id);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_homepage_account_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_homepage_account_id FOREIGN KEY (user_id) REFERENCES public.homepage_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: homepage_appointment homepage_appointment_patient_id_a3883c46_fk_homepage_account_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.homepage_appointment
    ADD CONSTRAINT homepage_appointment_patient_id_a3883c46_fk_homepage_account_id FOREIGN KEY (patient_id) REFERENCES public.homepage_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: homepage_appointment homepage_appointment_provider_id_706c8733_fk_homepage_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.homepage_appointment
    ADD CONSTRAINT homepage_appointment_provider_id_706c8733_fk_homepage_ FOREIGN KEY (provider_id) REFERENCES public.homepage_doctorinformation(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: homepage_doctorinformation homepage_doctorinfor_doctor_id_631092fe_fk_homepage_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.homepage_doctorinformation
    ADD CONSTRAINT homepage_doctorinfor_doctor_id_631092fe_fk_homepage_ FOREIGN KEY (doctor_id) REFERENCES public.homepage_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

