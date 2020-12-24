--
-- PostgreSQL database dump
--

-- Dumped from database version 11.6 (Ubuntu 11.6-1.pgdg18.04+1)
-- Dumped by pg_dump version 11.6 (Ubuntu 11.6-1.pgdg18.04+1)

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
-- Name: tablefunc; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS tablefunc WITH SCHEMA public;


--
-- Name: EXTENSION tablefunc; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION tablefunc IS 'functions that manipulate whole tables, including crosstab';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auth_assignment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_assignment (
    item_name character varying(64) NOT NULL,
    user_id character varying(64) NOT NULL,
    created_at integer
);


ALTER TABLE public.auth_assignment OWNER TO postgres;

--
-- Name: auth_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_item (
    name character varying(64) NOT NULL,
    type smallint NOT NULL,
    description text,
    rule_name character varying(64),
    data bytea,
    created_at character varying(50),
    updated_at character varying(50)
);


ALTER TABLE public.auth_item OWNER TO postgres;

--
-- Name: auth_item_child; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_item_child (
    parent character varying(64) NOT NULL,
    child character varying(64) NOT NULL
);


ALTER TABLE public.auth_item_child OWNER TO postgres;

--
-- Name: auth_rule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_rule (
    name character varying(64) NOT NULL,
    data bytea,
    created_at integer,
    updated_at integer
);


ALTER TABLE public.auth_rule OWNER TO postgres;

--
-- Name: buy_condition; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.buy_condition (
    id integer NOT NULL,
    label character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.buy_condition OWNER TO postgres;

--
-- Name: buy_condition_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.buy_condition_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.buy_condition_id_seq OWNER TO postgres;

--
-- Name: buy_condition_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.buy_condition_id_seq OWNED BY public.buy_condition.id;


--
-- Name: buy_request; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.buy_request (
    id integer NOT NULL,
    code character varying(50) NOT NULL,
    created date NOT NULL,
    last_update timestamp without time zone,
    created_by integer NOT NULL,
    buy_request_status_id integer NOT NULL,
    buy_request_type_id integer NOT NULL,
    approved_date date,
    approved_by integer,
    cancel_reason text,
    buyer_assigned smallint,
    buy_approved_by integer,
    buy_approved_date date,
    dt_specialist_assigned integer,
    dt_approved_date date,
    dt_approved_by integer,
    approve_start date,
    closed_date date,
    execution_start date,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.buy_request OWNER TO postgres;

--
-- Name: COLUMN buy_request.approved_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.buy_request.approved_date IS 'Fecha aprobación por JLogística';


--
-- Name: COLUMN buy_request.buy_approved_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.buy_request.buy_approved_date IS 'Fecha de aprobacion por JCompradores';


--
-- Name: COLUMN buy_request.dt_approved_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.buy_request.dt_approved_date IS 'Fecha aprobación por especialista técnico';


--
-- Name: COLUMN buy_request.approve_start; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.buy_request.approve_start IS 'Fecha en que se selecciono el ganador';


--
-- Name: COLUMN buy_request.closed_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.buy_request.closed_date IS 'Cierre de la orden';


--
-- Name: COLUMN buy_request.execution_start; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.buy_request.execution_start IS 'Fecha en que se inicio el ciclo de transportacion';


--
-- Name: buy_request_711; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.buy_request_711 (
    id smallint NOT NULL,
    buy_request_id integer,
    final_destiny_id integer NOT NULL,
    plan smallint NOT NULL,
    general_description text NOT NULL,
    other_operation numeric(10,2),
    deployment_place text,
    seguiment_date date,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.buy_request_711 OWNER TO postgres;

--
-- Name: buy_request_711_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.buy_request_711_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.buy_request_711_id_seq OWNER TO postgres;

--
-- Name: buy_request_711_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.buy_request_711_id_seq OWNED BY public.buy_request_711.id;


--
-- Name: buy_request_document; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.buy_request_document (
    id integer NOT NULL,
    buy_request_id integer NOT NULL,
    last_updated_by integer,
    created_date date,
    last_update date,
    url_to_file character varying,
    custom_file character varying(50),
    document_type_id integer,
    document_status_id integer,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.buy_request_document OWNER TO postgres;

--
-- Name: buy_request_document_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.buy_request_document_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.buy_request_document_id_seq OWNER TO postgres;

--
-- Name: buy_request_document_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.buy_request_document_id_seq OWNED BY public.buy_request_document.id;


--
-- Name: buy_request_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.buy_request_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.buy_request_id_seq OWNER TO postgres;

--
-- Name: buy_request_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.buy_request_id_seq OWNED BY public.buy_request.id;


--
-- Name: buy_request_international; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.buy_request_international (
    id integer NOT NULL,
    buy_request_id integer NOT NULL,
    bidding_start date,
    bidding_end date,
    destiny_id integer,
    payment_instrument_id integer,
    buy_condition_id integer,
    transport_days integer,
    build_days integer,
    bidding_ready_date date,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    credit_card_open date
);


ALTER TABLE public.buy_request_international OWNER TO postgres;

--
-- Name: buy_request_international_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.buy_request_international_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.buy_request_international_id_seq OWNER TO postgres;

--
-- Name: buy_request_international_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.buy_request_international_id_seq OWNED BY public.buy_request_international.id;


--
-- Name: buy_request_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.buy_request_provider (
    id integer NOT NULL,
    buy_request_id integer NOT NULL,
    provider_id integer NOT NULL,
    provider_status_id integer NOT NULL,
    winner boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.buy_request_provider OWNER TO postgres;

--
-- Name: buy_request_provider_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.buy_request_provider_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.buy_request_provider_id_seq OWNER TO postgres;

--
-- Name: buy_request_provider_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.buy_request_provider_id_seq OWNED BY public.buy_request_provider.id;


--
-- Name: buy_request_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.buy_request_status (
    id integer NOT NULL,
    label character varying(50) NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.buy_request_status OWNER TO postgres;

--
-- Name: buy_request_status_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.buy_request_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.buy_request_status_id_seq OWNER TO postgres;

--
-- Name: buy_request_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.buy_request_status_id_seq OWNED BY public.buy_request_status.id;


--
-- Name: buy_request_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.buy_request_type (
    id integer NOT NULL,
    label character varying(150) NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.buy_request_type OWNER TO postgres;

--
-- Name: buy_request_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.buy_request_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.buy_request_type_id_seq OWNER TO postgres;

--
-- Name: buy_request_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.buy_request_type_id_seq OWNED BY public.buy_request_type.id;


--
-- Name: certification_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.certification_type (
    id smallint NOT NULL,
    label character varying(50) NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.certification_type OWNER TO postgres;

--
-- Name: certificaion_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.certificaion_type_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.certificaion_type_id_seq OWNER TO postgres;

--
-- Name: certificaion_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.certificaion_type_id_seq OWNED BY public.certification_type.id;


--
-- Name: certification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.certification (
    id smallint NOT NULL,
    label character varying NOT NULL,
    certification_type_id smallint NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.certification OWNER TO postgres;

--
-- Name: certification_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.certification_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.certification_id_seq OWNER TO postgres;

--
-- Name: certification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.certification_id_seq OWNED BY public.certification.id;


--
-- Name: certification_validated_list_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.certification_validated_list_item (
    id smallint NOT NULL,
    certification_id smallint NOT NULL,
    validated_list_item_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.certification_validated_list_item OWNER TO postgres;

--
-- Name: certification_validated_list_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.certification_validated_list_item_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.certification_validated_list_item_id_seq OWNER TO postgres;

--
-- Name: certification_validated_list_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.certification_validated_list_item_id_seq OWNED BY public.certification_validated_list_item.id;


--
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    id integer NOT NULL,
    client_code character varying(10),
    name character varying(150) NOT NULL,
    address text NOT NULL,
    organism_id integer NOT NULL,
    province_ueb integer NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.client OWNER TO postgres;

--
-- Name: client_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.client_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.client_id_seq OWNER TO postgres;

--
-- Name: client_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.client_id_seq OWNED BY public.client.id;


--
-- Name: country; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.country (
    id integer NOT NULL,
    label character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.country OWNER TO postgres;

--
-- Name: country_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.country_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.country_id_seq OWNER TO postgres;

--
-- Name: country_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.country_id_seq OWNED BY public.country.id;


--
-- Name: demand; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.demand (
    id integer NOT NULL,
    client_contract_number character varying(50) NOT NULL,
    client_id smallint NOT NULL,
    payment_method_id integer NOT NULL,
    other_execution text,
    deployment_part_id integer NOT NULL,
    other_deploy text,
    waranty_time_id integer NOT NULL,
    warranty_specification text,
    purchase_reason_id integer NOT NULL,
    require_replacement_part boolean DEFAULT false,
    replacement_part_details text,
    require_post_warranty boolean DEFAULT false,
    post_warranty_details text,
    require_technic_asistance boolean DEFAULT false,
    technic_asistance_details text,
    created_date date NOT NULL,
    sending_date date,
    rejected_reason text,
    observation text,
    validated_list_id integer NOT NULL,
    seller_requirement_id integer NOT NULL,
    demand_status_id integer NOT NULL,
    created_by smallint NOT NULL,
    seller_requirement_details character varying(250),
    demand_code character varying(20),
    approved_by integer,
    approved_date date,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.demand OWNER TO postgres;

--
-- Name: demand_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.demand_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.demand_id_seq OWNER TO postgres;

--
-- Name: demand_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.demand_id_seq OWNED BY public.demand.id;


--
-- Name: demand_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.demand_item (
    id integer NOT NULL,
    demand_id integer NOT NULL,
    validated_list_item_id integer NOT NULL,
    price real NOT NULL,
    quantity integer NOT NULL,
    buy_request_id integer,
    internal_distribution boolean,
    cancelled boolean DEFAULT false NOT NULL,
    cancelled_msg character varying(150),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.demand_item OWNER TO postgres;

--
-- Name: demand_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.demand_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.demand_item_id_seq OWNER TO postgres;

--
-- Name: demand_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.demand_item_id_seq OWNED BY public.demand_item.id;


--
-- Name: demand_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.demand_status (
    id integer NOT NULL,
    label character varying(100) NOT NULL,
    color character varying DEFAULT 8,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.demand_status OWNER TO postgres;

--
-- Name: demand_status_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.demand_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.demand_status_id_seq OWNER TO postgres;

--
-- Name: demand_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.demand_status_id_seq OWNED BY public.demand_status.id;


--
-- Name: deployment_part; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deployment_part (
    id integer NOT NULL,
    label character varying(150) NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.deployment_part OWNER TO postgres;

--
-- Name: deployment_part_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.deployment_part_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.deployment_part_id_seq OWNER TO postgres;

--
-- Name: deployment_part_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.deployment_part_id_seq OWNED BY public.deployment_part.id;


--
-- Name: destiny; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.destiny (
    id smallint NOT NULL,
    label character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.destiny OWNER TO postgres;

--
-- Name: destiny_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.destiny_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.destiny_id_seq OWNER TO postgres;

--
-- Name: destiny_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.destiny_id_seq OWNED BY public.destiny.id;


--
-- Name: document_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.document_status (
    id smallint NOT NULL,
    label character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.document_status OWNER TO postgres;

--
-- Name: document_status_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.document_status_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.document_status_id_seq OWNER TO postgres;

--
-- Name: document_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.document_status_id_seq OWNED BY public.document_status.id;


--
-- Name: document_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.document_type (
    id integer NOT NULL,
    label character varying(150) NOT NULL,
    required boolean DEFAULT true NOT NULL,
    active boolean DEFAULT true NOT NULL,
    responsable character varying(100),
    buy_request_type_id integer DEFAULT 1 NOT NULL,
    order_doc integer,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.document_type OWNER TO postgres;

--
-- Name: document_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.document_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.document_type_id_seq OWNER TO postgres;

--
-- Name: document_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.document_type_id_seq OWNED BY public.document_type.id;


--
-- Name: document_type_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.document_type_permission (
    id integer NOT NULL,
    document_type_id integer NOT NULL,
    allow_view boolean DEFAULT false NOT NULL,
    allow_update boolean DEFAULT false NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.document_type_permission OWNER TO postgres;

--
-- Name: document_type_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.document_type_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.document_type_permission_id_seq OWNER TO postgres;

--
-- Name: document_type_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.document_type_permission_id_seq OWNED BY public.document_type_permission.id;


--
-- Name: email_notify; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.email_notify (
    id integer NOT NULL,
    bidding_start date NOT NULL,
    bidding_end date NOT NULL,
    sended_date date NOT NULL,
    body text NOT NULL,
    attachment character varying(150) NOT NULL,
    buy_request_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.email_notify OWNER TO postgres;

--
-- Name: email_notify_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.email_notify_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.email_notify_id_seq OWNER TO postgres;

--
-- Name: email_notify_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.email_notify_id_seq OWNED BY public.email_notify.id;


--
-- Name: final_destiny; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.final_destiny (
    id smallint NOT NULL,
    label character varying(150) NOT NULL,
    code character varying(3) DEFAULT 'as'::character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.final_destiny OWNER TO postgres;

--
-- Name: final_destiny_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.final_destiny_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.final_destiny_id_seq OWNER TO postgres;

--
-- Name: final_destiny_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.final_destiny_id_seq OWNED BY public.final_destiny.id;


--
-- Name: view_internacional_buy_steep; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_internacional_buy_steep AS
 SELECT buy_request.code,
    date_part('day'::text, age((buy_request.approved_date)::timestamp with time zone, (buy_request.created)::timestamp with time zone)) AS t_aproved,
    date_part('day'::text, age((buy_request.dt_approved_date)::timestamp with time zone, (buy_request.approved_date)::timestamp with time zone)) AS t_dt_approved,
    date_part('day'::text, age((buy_request.buy_approved_date)::timestamp with time zone, (buy_request.dt_approved_date)::timestamp with time zone)) AS t_buy_approved,
    date_part('day'::text, age((buy_request_international.bidding_end)::timestamp with time zone, (buy_request.buy_approved_date)::timestamp with time zone)) AS t_licitation,
    date_part('day'::text, age((buy_request.approve_start)::timestamp with time zone, (buy_request_international.bidding_end)::timestamp with time zone)) AS t_winner_selected,
    date_part('day'::text, age((buy_request.execution_start)::timestamp with time zone, (buy_request.approve_start)::timestamp with time zone)) AS t_execution_start
   FROM (public.buy_request
     LEFT JOIN public.buy_request_international ON ((buy_request_international.buy_request_id = buy_request.id)))
  WHERE (buy_request.buy_request_type_id = 1);


ALTER TABLE public.view_internacional_buy_steep OWNER TO postgres;

--
-- Name: inform_contratacion_internacional_fuera_fecha; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.inform_contratacion_internacional_fuera_fecha AS
 SELECT buy_request.code,
    buy_request.created,
    view_internacional_buy_steep.t_aproved,
    view_internacional_buy_steep.t_dt_approved,
    view_internacional_buy_steep.t_buy_approved,
    view_internacional_buy_steep.t_licitation,
    view_internacional_buy_steep.t_winner_selected,
    view_internacional_buy_steep.t_execution_start,
    buy_request_status.label AS estado
   FROM ((public.view_internacional_buy_steep
     JOIN public.buy_request ON (((buy_request.code)::text = (view_internacional_buy_steep.code)::text)))
     JOIN public.buy_request_status ON ((buy_request.buy_request_status_id = buy_request_status.id)))
  WHERE ((view_internacional_buy_steep.t_aproved > (3)::double precision) OR (view_internacional_buy_steep.t_dt_approved > (3)::double precision) OR (view_internacional_buy_steep.t_buy_approved > (3)::double precision) OR (view_internacional_buy_steep.t_licitation > (14)::double precision) OR (view_internacional_buy_steep.t_winner_selected > (7)::double precision) OR (view_internacional_buy_steep.t_execution_start > (50)::double precision));


ALTER TABLE public.inform_contratacion_internacional_fuera_fecha OWNER TO postgres;

--
-- Name: view_nacional_buy_steep; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_nacional_buy_steep AS
 SELECT buy_request.code,
    date_part('day'::text, age((buy_request.approved_date)::timestamp with time zone, (buy_request.created)::timestamp with time zone)) AS t_aproved,
    date_part('day'::text, age((buy_request.dt_approved_date)::timestamp with time zone, (buy_request.approved_date)::timestamp with time zone)) AS t_dt_approved,
    date_part('day'::text, age((buy_request.buy_approved_date)::timestamp with time zone, (buy_request.dt_approved_date)::timestamp with time zone)) AS t_buy_approved,
    date_part('day'::text, age((buy_request.approve_start)::timestamp with time zone, (buy_request.buy_approved_date)::timestamp with time zone)) AS t_winner_selected,
    date_part('day'::text, age((buy_request.execution_start)::timestamp with time zone, (buy_request.approve_start)::timestamp with time zone)) AS t_execution_start
   FROM public.buy_request
  WHERE (buy_request.buy_request_type_id <> 1);


ALTER TABLE public.view_nacional_buy_steep OWNER TO postgres;

--
-- Name: inform_contratacion_nacional_fuera_fecha; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.inform_contratacion_nacional_fuera_fecha AS
 SELECT buy_request.code,
    buy_request.created,
    buy_request_type.label AS tipo,
    view_nacional_buy_steep.t_aproved,
    view_nacional_buy_steep.t_dt_approved,
    view_nacional_buy_steep.t_buy_approved,
    view_nacional_buy_steep.t_winner_selected,
    view_nacional_buy_steep.t_execution_start,
    buy_request_status.label AS estado
   FROM (((public.view_nacional_buy_steep
     JOIN public.buy_request ON (((buy_request.code)::text = (view_nacional_buy_steep.code)::text)))
     JOIN public.buy_request_type ON ((buy_request.buy_request_type_id = buy_request_type.id)))
     JOIN public.buy_request_status ON ((buy_request.buy_request_status_id = buy_request_status.id)))
  WHERE ((view_nacional_buy_steep.t_aproved > (3)::double precision) OR (view_nacional_buy_steep.t_dt_approved > (3)::double precision) OR (view_nacional_buy_steep.t_buy_approved > (3)::double precision) OR (view_nacional_buy_steep.t_winner_selected > (3)::double precision) OR (view_nacional_buy_steep.t_execution_start > (50)::double precision))
  ORDER BY buy_request_type.label, buy_request.code;


ALTER TABLE public.inform_contratacion_nacional_fuera_fecha OWNER TO postgres;

--
-- Name: organism; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.organism (
    id integer NOT NULL,
    short_name character varying(20) NOT NULL,
    name character varying(250) NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.organism OWNER TO postgres;

--
-- Name: province_ueb; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.province_ueb (
    id integer NOT NULL,
    label character varying(200) NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.province_ueb OWNER TO postgres;

--
-- Name: inform_demandas_rechazadas; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.inform_demandas_rechazadas AS
 SELECT province_ueb.label AS ueb_name,
    demand.demand_code,
    demand.sending_date,
    client.name AS client_name,
    organism.short_name,
    demand.rejected_reason
   FROM ((((public.demand
     JOIN public.client ON ((demand.client_id = client.id)))
     JOIN public.province_ueb ON ((client.province_ueb = province_ueb.id)))
     JOIN public.demand_status ON ((demand.demand_status_id = demand_status.id)))
     JOIN public.organism ON ((client.organism_id = organism.id)))
  WHERE (demand.demand_status_id = 4)
  ORDER BY province_ueb.label;


ALTER TABLE public.inform_demandas_rechazadas OWNER TO postgres;

--
-- Name: request_stage; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.request_stage (
    id smallint NOT NULL,
    date_created date NOT NULL,
    date_start date NOT NULL,
    date_end date NOT NULL,
    real_end date,
    stage_id integer NOT NULL,
    buy_request_id integer NOT NULL,
    details text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    active boolean
);


ALTER TABLE public.request_stage OWNER TO postgres;

--
-- Name: stage; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stage (
    id integer NOT NULL,
    label character varying(255) NOT NULL,
    "order" integer NOT NULL,
    buy_request_type_id integer NOT NULL,
    active boolean DEFAULT true NOT NULL,
    duration integer,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.stage OWNER TO postgres;

--
-- Name: inform_ordenes_en_transportacion; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.inform_ordenes_en_transportacion AS
 SELECT buy_request.code,
    buy_request.created,
    buy_request_type.label AS tipo,
    request_stage.date_start,
    request_stage.date_end,
    stage.label AS hito
   FROM (((public.buy_request
     JOIN public.request_stage ON ((request_stage.buy_request_id = buy_request.id)))
     JOIN public.stage ON ((request_stage.stage_id = stage.id)))
     JOIN public.buy_request_type ON (((buy_request.buy_request_type_id = buy_request_type.id) AND (stage.buy_request_type_id = buy_request_type.id))))
  WHERE request_stage.active;


ALTER TABLE public.inform_ordenes_en_transportacion OWNER TO postgres;

--
-- Name: inform_ordenes_en_transportacion_vencidas; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.inform_ordenes_en_transportacion_vencidas AS
 SELECT buy_request.code,
    buy_request.created,
    buy_request_type.label AS tipo,
    request_stage.date_start,
    request_stage.date_end,
    stage.label AS hito,
    request_stage.details
   FROM (((public.buy_request
     JOIN public.request_stage ON ((request_stage.buy_request_id = buy_request.id)))
     JOIN public.stage ON ((request_stage.stage_id = stage.id)))
     JOIN public.buy_request_type ON (((buy_request.buy_request_type_id = buy_request_type.id) AND (stage.buy_request_type_id = buy_request_type.id))))
  WHERE (request_stage.active AND (request_stage.date_end > now()));


ALTER TABLE public.inform_ordenes_en_transportacion_vencidas OWNER TO postgres;

--
-- Name: inform_pending_demand; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.inform_pending_demand AS
 SELECT province_ueb.label AS ueb_name,
    demand.demand_code,
    demand.sending_date,
    client.name AS client_name,
    organism.short_name,
    demand_status.label AS status,
    date_part('day'::text, (now() - (demand.sending_date)::timestamp with time zone)) AS dias
   FROM ((((public.demand
     JOIN public.client ON ((demand.client_id = client.id)))
     JOIN public.province_ueb ON ((client.province_ueb = province_ueb.id)))
     JOIN public.demand_status ON ((demand.demand_status_id = demand_status.id)))
     JOIN public.organism ON ((client.organism_id = organism.id)))
  WHERE (((demand.demand_status_id = 2) OR (demand.demand_status_id = 3)) AND (demand.sending_date <= (now() - '1 mon'::interval)))
  ORDER BY province_ueb.label;


ALTER TABLE public.inform_pending_demand OWNER TO postgres;

--
-- Name: inform_productos_mas_solicitado_anual; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.inform_productos_mas_solicitado_anual AS
SELECT
    NULL::integer AS id,
    NULL::character varying(200) AS product_name,
    NULL::bigint AS demandas_solicitadas,
    NULL::bigint AS cantidad,
    NULL::real AS precio,
    NULL::double precision AS importe,
    NULL::character varying AS um;


ALTER TABLE public.inform_productos_mas_solicitado_anual OWNER TO postgres;

--
-- Name: inform_productos_mas_solicitado_trimestre; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.inform_productos_mas_solicitado_trimestre AS
SELECT
    NULL::integer AS id,
    NULL::character varying(200) AS product_name,
    NULL::bigint AS demandas_solicitadas,
    NULL::bigint AS cantidad,
    NULL::real AS precio,
    NULL::double precision AS importe,
    NULL::character varying AS um;


ALTER TABLE public.inform_productos_mas_solicitado_trimestre OWNER TO postgres;

--
-- Name: inform_solicitudes_activas; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.inform_solicitudes_activas AS
 SELECT buy_request.code,
    buy_request.created,
    buy_request_type.label AS tipo,
    demand.demand_code AS demanda,
    client.name AS cliente,
    organism.name AS organismo,
    province_ueb.label AS ueb,
    buy_request_status.label AS estado
   FROM (((((((public.buy_request
     JOIN public.buy_request_type ON ((buy_request.buy_request_type_id = buy_request_type.id)))
     JOIN public.buy_request_status ON ((buy_request.buy_request_status_id = buy_request_status.id)))
     JOIN public.demand_item ON ((demand_item.buy_request_id = buy_request.id)))
     JOIN public.demand ON ((demand_item.demand_id = demand.id)))
     JOIN public.client ON ((demand.client_id = client.id)))
     JOIN public.organism ON ((client.organism_id = organism.id)))
     JOIN public.province_ueb ON ((client.province_ueb = province_ueb.id)))
  WHERE ((buy_request.buy_request_status_id <> 1) AND (buy_request.buy_request_status_id <> 3) AND (buy_request.buy_request_status_id <> 7))
  ORDER BY buy_request_type.label, buy_request.code;


ALTER TABLE public.inform_solicitudes_activas OWNER TO postgres;

--
-- Name: inform_ventas_ultimo_anno; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.inform_ventas_ultimo_anno AS
 SELECT to_char((buy_request.approved_date)::timestamp with time zone, 'MM-YY'::text) AS fecha,
    (demand_item.price * (demand_item.quantity)::double precision) AS amount
   FROM (public.buy_request
     JOIN public.demand_item ON ((demand_item.buy_request_id = buy_request.id)))
  WHERE (buy_request.buy_request_status_id = 7);


ALTER TABLE public.inform_ventas_ultimo_anno OWNER TO postgres;

--
-- Name: log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.log (
    id integer NOT NULL,
    user_id smallint NOT NULL,
    action_moment timestamp without time zone NOT NULL,
    ip character varying(15) NOT NULL,
    action character varying(150) NOT NULL,
    description text NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.log OWNER TO postgres;

--
-- Name: log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.log_id_seq OWNER TO postgres;

--
-- Name: log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.log_id_seq OWNED BY public.log.id;


--
-- Name: migration; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migration (
    version character varying(180) NOT NULL,
    apply_time integer
);


ALTER TABLE public.migration OWNER TO postgres;

--
-- Name: offert; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offert (
    id integer NOT NULL,
    upload_by integer NOT NULL,
    upload_date date NOT NULL,
    expiration_date date NOT NULL,
    url_file character varying NOT NULL,
    evaluated_by integer,
    evaluation_date date,
    approved boolean,
    url_evaluation character varying,
    winner boolean,
    buy_request_provider_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    code character varying(150)
);


ALTER TABLE public.offert OWNER TO postgres;

--
-- Name: offert_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.offert_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.offert_id_seq OWNER TO postgres;

--
-- Name: offert_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.offert_id_seq OWNED BY public.offert.id;


--
-- Name: organism_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.organism_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.organism_id_seq OWNER TO postgres;

--
-- Name: organism_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.organism_id_seq OWNED BY public.organism.id;


--
-- Name: payment_instrument; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment_instrument (
    id integer NOT NULL,
    label character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.payment_instrument OWNER TO postgres;

--
-- Name: payment_instrument_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payment_instrument_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payment_instrument_id_seq OWNER TO postgres;

--
-- Name: payment_instrument_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payment_instrument_id_seq OWNED BY public.payment_instrument.id;


--
-- Name: payment_method; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment_method (
    id integer NOT NULL,
    label character varying(150) NOT NULL,
    description text,
    active boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.payment_method OWNER TO postgres;

--
-- Name: payment_method_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payment_method_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payment_method_id_seq OWNER TO postgres;

--
-- Name: payment_method_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payment_method_id_seq OWNED BY public.payment_method.id;


--
-- Name: provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.provider (
    id integer NOT NULL,
    name character varying NOT NULL,
    country_id integer NOT NULL,
    address text NOT NULL,
    active boolean DEFAULT true NOT NULL,
    contact_name character varying NOT NULL,
    contact_email character varying NOT NULL,
    observation text,
    buy_request_type_id integer DEFAULT 1 NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.provider OWNER TO postgres;

--
-- Name: provider_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.provider_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.provider_id_seq OWNER TO postgres;

--
-- Name: provider_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.provider_id_seq OWNED BY public.provider.id;


--
-- Name: provider_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.provider_status (
    id integer NOT NULL,
    label character varying(50) NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.provider_status OWNER TO postgres;

--
-- Name: provider_status_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.provider_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.provider_status_id_seq OWNER TO postgres;

--
-- Name: provider_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.provider_status_id_seq OWNED BY public.provider_status.id;


--
-- Name: provider_validated_list; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.provider_validated_list (
    id integer NOT NULL,
    provider_id integer NOT NULL,
    validated_list_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.provider_validated_list OWNER TO postgres;

--
-- Name: provider_validated_list_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.provider_validated_list_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.provider_validated_list_id_seq OWNER TO postgres;

--
-- Name: provider_validated_list_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.provider_validated_list_id_seq OWNED BY public.provider_validated_list.id;


--
-- Name: province_ueb_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.province_ueb_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.province_ueb_id_seq OWNER TO postgres;

--
-- Name: province_ueb_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.province_ueb_id_seq OWNED BY public.province_ueb.id;


--
-- Name: purchase_reason; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.purchase_reason (
    id integer NOT NULL,
    label character varying(150) NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.purchase_reason OWNER TO postgres;

--
-- Name: purchase_reason_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.purchase_reason_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.purchase_reason_id_seq OWNER TO postgres;

--
-- Name: purchase_reason_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.purchase_reason_id_seq OWNED BY public.purchase_reason.id;


--
-- Name: request_stage_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.request_stage_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.request_stage_id_seq OWNER TO postgres;

--
-- Name: request_stage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.request_stage_id_seq OWNED BY public.request_stage.id;


--
-- Name: seller_requirement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seller_requirement (
    id smallint NOT NULL,
    label character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.seller_requirement OWNER TO postgres;

--
-- Name: seller_requirement_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seller_requirement_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seller_requirement_id_seq OWNER TO postgres;

--
-- Name: seller_requirement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.seller_requirement_id_seq OWNED BY public.seller_requirement.id;


--
-- Name: stage_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stage_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stage_id_seq OWNER TO postgres;

--
-- Name: stage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stage_id_seq OWNED BY public.stage.id;


--
-- Name: subfamily; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subfamily (
    id integer NOT NULL,
    label character varying(150) NOT NULL,
    validated_list_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.subfamily OWNER TO postgres;

--
-- Name: subfamily_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subfamily_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subfamily_id_seq OWNER TO postgres;

--
-- Name: subfamily_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subfamily_id_seq OWNED BY public.subfamily.id;


--
-- Name: um; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.um (
    id integer NOT NULL,
    label character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.um OWNER TO postgres;

--
-- Name: um_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.um_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.um_id_seq OWNER TO postgres;

--
-- Name: um_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.um_id_seq OWNED BY public.um.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    full_name character varying(200) NOT NULL,
    email character varying(150) NOT NULL,
    password character varying(100) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    last_login timestamp without time zone,
    province_ueb integer,
    active boolean DEFAULT true,
    cargo character varying(150),
    phone_number character varying(20),
    digital_signature_url character varying(150),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- Name: user_can_view; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_can_view (
    id smallint NOT NULL,
    user_id smallint NOT NULL,
    buy_request_type_id smallint NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.user_can_view OWNER TO postgres;

--
-- Name: user_can_view_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_can_view_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_can_view_id_seq OWNER TO postgres;

--
-- Name: user_can_view_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_can_view_id_seq OWNED BY public.user_can_view.id;


--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- Name: validated_list; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.validated_list (
    id integer NOT NULL,
    label character varying(250) NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    common boolean DEFAULT false
);


ALTER TABLE public.validated_list OWNER TO postgres;

--
-- Name: validated_list_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.validated_list_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.validated_list_id_seq OWNER TO postgres;

--
-- Name: validated_list_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.validated_list_id_seq OWNED BY public.validated_list.id;


--
-- Name: validated_list_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.validated_list_item (
    id integer NOT NULL,
    seisa_code character varying(50),
    product_name character varying(200) NOT NULL,
    tecnic_description text NOT NULL,
    price real NOT NULL,
    um_id integer NOT NULL,
    validated_list_id smallint NOT NULL,
    tech_contrato text,
    tech_posicion integer,
    tech_codigo text,
    tech_descripcion text,
    tech_precio text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    active boolean DEFAULT true,
    picture character varying(250)
);


ALTER TABLE public.validated_list_item OWNER TO postgres;

--
-- Name: validated_list_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.validated_list_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.validated_list_item_id_seq OWNER TO postgres;

--
-- Name: validated_list_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.validated_list_item_id_seq OWNED BY public.validated_list_item.id;


--
-- Name: view_active_demand; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_active_demand AS
 SELECT demand.id,
    demand.client_contract_number,
    demand.client_id,
    demand.payment_method_id,
    demand.other_execution,
    demand.deployment_part_id,
    demand.other_deploy,
    demand.waranty_time_id,
    demand.warranty_specification,
    demand.purchase_reason_id,
    demand.require_replacement_part,
    demand.replacement_part_details,
    demand.require_post_warranty,
    demand.post_warranty_details,
    demand.require_technic_asistance,
    demand.technic_asistance_details,
    demand.created_date,
    demand.sending_date,
    demand.rejected_reason,
    demand.observation,
    demand.validated_list_id,
    demand.seller_requirement_id,
    demand.demand_status_id,
    demand.created_by,
    demand.seller_requirement_details,
    demand.demand_code,
    demand.approved_by,
    demand.approved_date
   FROM ((public.demand
     JOIN public.client ON ((demand.client_id = client.id)))
     JOIN public.province_ueb ON ((client.province_ueb = province_ueb.id)))
  WHERE ((demand.demand_status_id <> 6) AND (demand.demand_status_id <> 1) AND (demand.demand_status_id <> 4));


ALTER TABLE public.view_active_demand OWNER TO postgres;

--
-- Name: view_avg_internacional; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_avg_internacional AS
 SELECT avg(date_part('day'::text, age((buy_request.approved_date)::timestamp with time zone, (buy_request.created)::timestamp with time zone))) AS avg_aproved,
    avg(date_part('day'::text, age((buy_request.dt_approved_date)::timestamp with time zone, (buy_request.approved_date)::timestamp with time zone))) AS avg_dt_approved,
    avg(date_part('day'::text, age((buy_request.buy_approved_date)::timestamp with time zone, (buy_request.dt_approved_date)::timestamp with time zone))) AS avg_buy_approved,
    avg(date_part('day'::text, age((buy_request_international.bidding_end)::timestamp with time zone, (buy_request.buy_approved_date)::timestamp with time zone))) AS avg_licitation,
    avg(date_part('day'::text, age((buy_request.approve_start)::timestamp with time zone, (buy_request_international.bidding_end)::timestamp with time zone))) AS avg_winner_selected,
    avg(date_part('day'::text, age((buy_request.execution_start)::timestamp with time zone, (buy_request.approve_start)::timestamp with time zone))) AS avg_execution_start
   FROM (public.buy_request
     JOIN public.buy_request_international ON ((buy_request_international.buy_request_id = buy_request.id)))
  WHERE (buy_request.buy_request_status_id = 7);


ALTER TABLE public.view_avg_internacional OWNER TO postgres;

--
-- Name: view_avg_nacional; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_avg_nacional AS
 SELECT buy_request.buy_request_type_id,
    avg(date_part('day'::text, age((buy_request.approved_date)::timestamp with time zone, (buy_request.created)::timestamp with time zone))) AS avg_aproved,
    avg(date_part('day'::text, age((buy_request.dt_approved_date)::timestamp with time zone, (buy_request.approved_date)::timestamp with time zone))) AS avg_dt_approved,
    avg(date_part('day'::text, age((buy_request.buy_approved_date)::timestamp with time zone, (buy_request.dt_approved_date)::timestamp with time zone))) AS avg_buy_approved,
    avg(date_part('day'::text, age((buy_request.approve_start)::timestamp with time zone, (buy_request.approved_date)::timestamp with time zone))) AS avg_winner_selected,
    avg(date_part('day'::text, age((buy_request.execution_start)::timestamp with time zone, (buy_request.approve_start)::timestamp with time zone))) AS avg_execution_start
   FROM public.buy_request
  WHERE (buy_request.buy_request_status_id = 7)
  GROUP BY buy_request.buy_request_type_id;


ALTER TABLE public.view_avg_nacional OWNER TO postgres;

--
-- Name: view_buy_request_active; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_buy_request_active WITH (security_barrier='false') AS
 SELECT buy_request.id,
    buy_request.code,
    buy_request.created,
    buy_request.last_update,
    buy_request.created_by,
    buy_request.buy_request_status_id,
    buy_request.buy_request_type_id,
    buy_request.approved_date,
    buy_request.approved_by,
    buy_request.cancel_reason,
    buy_request.buyer_assigned,
    buy_request.buy_approved_by,
    buy_request.buy_approved_date,
    buy_request.dt_specialist_assigned,
    buy_request.dt_approved_date,
    buy_request.dt_approved_by
   FROM public.buy_request
  WHERE ((buy_request.buy_request_status_id <> 7) AND (buy_request.buy_request_status_id <> 3) AND (buy_request.buy_request_status_id <> 1));


ALTER TABLE public.view_buy_request_active OWNER TO postgres;

--
-- Name: view_buy_request_by_type_and_status; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_buy_request_by_type_and_status AS
 SELECT buy_request_type.label AS tipo,
    view_buy_request_active.buy_request_type_id,
    buy_request_status.label AS estado,
    view_buy_request_active.buy_request_status_id,
    count(buy_request_status.label) AS cantidad
   FROM ((public.view_buy_request_active
     JOIN public.buy_request_status ON ((view_buy_request_active.buy_request_status_id = buy_request_status.id)))
     JOIN public.buy_request_type ON ((view_buy_request_active.buy_request_type_id = buy_request_type.id)))
  GROUP BY view_buy_request_active.buy_request_type_id, view_buy_request_active.buy_request_status_id, buy_request_type.label, buy_request_status.label;


ALTER TABLE public.view_buy_request_by_type_and_status OWNER TO postgres;

--
-- Name: view_buy_request_active_all; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_buy_request_active_all AS
 SELECT buy_request_status.id,
    buy_request_status.label,
    view_buy_request_by_type_and_status.tipo,
    view_buy_request_by_type_and_status.estado,
    view_buy_request_by_type_and_status.cantidad
   FROM (public.buy_request_status
     FULL JOIN public.view_buy_request_by_type_and_status ON ((view_buy_request_by_type_and_status.buy_request_status_id = buy_request_status.id)))
  ORDER BY buy_request_status.id;


ALTER TABLE public.view_buy_request_active_all OWNER TO postgres;

--
-- Name: view_buy_request_active_x_status_x_esp_compras; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_buy_request_active_x_status_x_esp_compras AS
 SELECT "user".id AS id_user,
    "user".full_name AS especialista,
    buy_request_status.label AS estado,
    view_buy_request_active.buy_request_type_id,
    count(buy_request_status.label) AS cantidad
   FROM ((public.view_buy_request_active
     JOIN public."user" ON ((view_buy_request_active.buyer_assigned = "user".id)))
     JOIN public.buy_request_status ON ((view_buy_request_active.buy_request_status_id = buy_request_status.id)))
  GROUP BY "user".id, "user".full_name, buy_request_status.label, view_buy_request_active.buy_request_type_id;


ALTER TABLE public.view_buy_request_active_x_status_x_esp_compras OWNER TO postgres;

--
-- Name: view_buy_request_active_x_status_x_esp_dopbs; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_buy_request_active_x_status_x_esp_dopbs AS
 SELECT "user".id AS id_user,
    "user".full_name AS esp_dopbs,
    buy_request_status.label AS estado,
    count(buy_request_status.label) AS cantidad
   FROM ((public.view_buy_request_active
     JOIN public."user" ON ((view_buy_request_active.dt_specialist_assigned = "user".id)))
     JOIN public.buy_request_status ON ((view_buy_request_active.buy_request_status_id = buy_request_status.id)))
  GROUP BY "user".id, "user".full_name, buy_request_status.label;


ALTER TABLE public.view_buy_request_active_x_status_x_esp_dopbs OWNER TO postgres;

--
-- Name: view_buy_request_active_x_status_x_type; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_buy_request_active_x_status_x_type AS
 SELECT "user".full_name AS especialista,
    buy_request_status.label AS estado,
    count(buy_request_status.label) AS cantidad
   FROM ((public.view_buy_request_active
     JOIN public."user" ON ((view_buy_request_active.buyer_assigned = "user".id)))
     JOIN public.buy_request_status ON ((view_buy_request_active.buy_request_status_id = buy_request_status.id)))
  GROUP BY "user".full_name, buy_request_status.label;


ALTER TABLE public.view_buy_request_active_x_status_x_type OWNER TO postgres;

--
-- Name: view_buy_request_active_x_tipe_x_esp_dopbs; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_buy_request_active_x_tipe_x_esp_dopbs AS
 SELECT "user".full_name AS esp_dopbs,
    buy_request_type.label AS tipo,
    count(buy_request_type.label) AS cantidad
   FROM ((public.view_buy_request_active
     JOIN public."user" ON ((view_buy_request_active.dt_specialist_assigned = "user".id)))
     JOIN public.buy_request_type ON ((view_buy_request_active.buy_request_type_id = buy_request_type.id)))
  GROUP BY "user".full_name, buy_request_type.label;


ALTER TABLE public.view_buy_request_active_x_tipe_x_esp_dopbs OWNER TO postgres;

--
-- Name: view_buy_request_licitando; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_buy_request_licitando AS
 SELECT buy_request.id AS id_buy_request,
    buy_request.code,
    buy_request.created,
    buy_request.last_update,
    buy_request.created_by,
    buy_request.buy_request_status_id,
    buy_request.buy_request_type_id,
    buy_request.approved_date,
    buy_request.approved_by,
    buy_request.cancel_reason,
    buy_request.buyer_assigned,
    buy_request.buy_approved_by,
    buy_request.buy_approved_date,
    buy_request.dt_specialist_assigned,
    buy_request.dt_approved_date,
    buy_request.dt_approved_by,
    buy_request_international.id,
    buy_request_international.buy_request_id,
    buy_request_international.bidding_start,
    buy_request_international.bidding_end,
    buy_request_international.destiny_id,
    buy_request_international.payment_instrument_id,
    buy_request_international.buy_condition_id,
    buy_request_international.transport_days,
    buy_request_international.build_days
   FROM (public.buy_request
     JOIN public.buy_request_international ON ((buy_request_international.buy_request_id = buy_request.id)))
  WHERE ((buy_request.buy_request_status_id = 4) AND (buy_request.buy_request_type_id = 1));


ALTER TABLE public.view_buy_request_licitando OWNER TO postgres;

--
-- Name: view_buy_request_bidding_time; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_buy_request_bidding_time AS
 SELECT view_buy_request_licitando.id_buy_request,
    view_buy_request_licitando.code,
    view_buy_request_licitando.buy_request_type_id,
    view_buy_request_licitando.dt_specialist_assigned,
    view_buy_request_licitando.buyer_assigned,
    now() AS fecha,
    view_buy_request_licitando.bidding_start,
    view_buy_request_licitando.bidding_end,
    date_part('day'::text, age((view_buy_request_licitando.bidding_end)::timestamp with time zone, (view_buy_request_licitando.bidding_start)::timestamp with time zone)) AS total,
    date_part('day'::text, age((view_buy_request_licitando.bidding_start)::timestamp with time zone)) AS transcurridos,
    ((date_part('day'::text, age((view_buy_request_licitando.bidding_start)::timestamp with time zone)) * (100)::double precision) / date_part('day'::text, age((view_buy_request_licitando.bidding_end)::timestamp with time zone, (view_buy_request_licitando.bidding_start)::timestamp with time zone))) AS porciento
   FROM public.view_buy_request_licitando;


ALTER TABLE public.view_buy_request_bidding_time OWNER TO postgres;

--
-- Name: view_buy_request_evaluating; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_buy_request_evaluating AS
 SELECT buy_request.id,
    buy_request.code,
    buy_request.created,
    buy_request.last_update,
    buy_request.created_by,
    buy_request.buy_request_status_id,
    buy_request.buy_request_type_id,
    buy_request.approved_date,
    buy_request.approved_by,
    buy_request.cancel_reason,
    buy_request.buyer_assigned,
    buy_request.buy_approved_by,
    buy_request.buy_approved_date,
    buy_request.dt_specialist_assigned,
    buy_request.dt_approved_date,
    buy_request.dt_approved_by
   FROM public.buy_request
  WHERE (buy_request.buy_request_status_id = 5);


ALTER TABLE public.view_buy_request_evaluating OWNER TO postgres;

--
-- Name: view_demandas_activas_x_estado; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_demandas_activas_x_estado AS
 SELECT demand_status.label AS estado,
    demand_status.color,
    count(demand_status.label) AS total
   FROM (public.view_active_demand
     JOIN public.demand_status ON ((demand_status.id = view_active_demand.demand_status_id)))
  GROUP BY demand_status.label, demand_status.color;


ALTER TABLE public.view_demandas_activas_x_estado OWNER TO postgres;

--
-- Name: view_demandas_activas_x_ueb; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_demandas_activas_x_ueb AS
 SELECT province_ueb.label AS ueb,
    count(client.province_ueb) AS demandas
   FROM ((public.view_active_demand
     JOIN public.client ON ((view_active_demand.client_id = client.id)))
     JOIN public.province_ueb ON ((client.province_ueb = province_ueb.id)))
  GROUP BY province_ueb.label;


ALTER TABLE public.view_demandas_activas_x_ueb OWNER TO postgres;

--
-- Name: view_demandas_activas_x_ueb_x_estado; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_demandas_activas_x_ueb_x_estado AS
 SELECT demand_status.label AS estado,
    demand_status.color,
    count(demand_status.label) AS total,
    province_ueb.label AS ueb
   FROM (((public.view_active_demand
     JOIN public.demand_status ON ((demand_status.id = view_active_demand.demand_status_id)))
     JOIN public.client ON ((view_active_demand.client_id = client.id)))
     JOIN public.province_ueb ON ((client.province_ueb = province_ueb.id)))
  GROUP BY demand_status.label, demand_status.color, province_ueb.label
  ORDER BY province_ueb.label;


ALTER TABLE public.view_demandas_activas_x_ueb_x_estado OWNER TO postgres;

--
-- Name: view_documents_pending_by_user; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_documents_pending_by_user AS
 SELECT view_buy_request_evaluating.code,
    buy_request_type.label AS tipo_solicitud,
    document_type.label AS documento,
    count(document_type.label) AS cantidad,
    document_status.label AS estado,
    document_type_permission.user_id AS id_user,
    buy_request_document.document_status_id AS id_estado
   FROM (((((public.view_buy_request_evaluating
     JOIN public.buy_request_document ON ((view_buy_request_evaluating.id = buy_request_document.buy_request_id)))
     JOIN public.document_status ON ((buy_request_document.document_status_id = document_status.id)))
     JOIN public.document_type ON ((buy_request_document.document_type_id = document_type.id)))
     JOIN public.document_type_permission ON ((document_type_permission.document_type_id = document_type.id)))
     JOIN public.buy_request_type ON ((document_type.buy_request_type_id = buy_request_type.id)))
  WHERE ((buy_request_document.document_status_id <> 2) AND document_type.active AND document_type.required AND document_type_permission.allow_update)
  GROUP BY view_buy_request_evaluating.code, document_type_permission.user_id, document_type.label, document_status.label, buy_request_document.document_status_id, buy_request_type.label;


ALTER TABLE public.view_documents_pending_by_user OWNER TO postgres;

--
-- Name: view_edad_maxima_demanda_pendiente; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_edad_maxima_demanda_pendiente AS
 SELECT demand.demand_code,
    date_part('day'::text, age((demand.sending_date)::timestamp with time zone)) AS dias
   FROM public.demand
  WHERE ((demand.demand_status_id = 2) OR (demand.demand_status_id = 3))
  ORDER BY (date_part('day'::text, age((demand.sending_date)::timestamp with time zone))) DESC
 LIMIT 1;


ALTER TABLE public.view_edad_maxima_demanda_pendiente OWNER TO postgres;

--
-- Name: view_offert_pending_evaluations; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_offert_pending_evaluations AS
 SELECT view_buy_request_active.code AS buy_request,
    offert.upload_date,
    date_part('day'::text, age((offert.upload_date)::timestamp with time zone)) AS dias,
    view_buy_request_active.dt_specialist_assigned AS especialista,
    buy_request_provider.provider_status_id
   FROM ((public.offert
     JOIN public.buy_request_provider ON ((offert.buy_request_provider_id = buy_request_provider.id)))
     JOIN public.view_buy_request_active ON ((buy_request_provider.buy_request_id = view_buy_request_active.id)))
  WHERE ((offert.evaluation_date IS NULL) AND (buy_request_provider.provider_status_id = 2));


ALTER TABLE public.view_offert_pending_evaluations OWNER TO postgres;

--
-- Name: view_old_jcompras; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_old_jcompras AS
 SELECT buy_request.code,
    buy_request.buyer_assigned,
    buy_request.dt_approved_date,
    buy_request.buy_request_type_id,
    date_part('day'::text, age((buy_request.dt_approved_date)::timestamp with time zone)) AS dias
   FROM public.buy_request
  WHERE ((buy_request.buy_request_status_id = 2) AND (buy_request.dt_approved_date IS NOT NULL) AND (buy_request.buy_approved_date IS NULL))
  ORDER BY (date_part('day'::text, age((buy_request.approved_date)::timestamp with time zone))) DESC;


ALTER TABLE public.view_old_jcompras OWNER TO postgres;

--
-- Name: view_old_jdopbs; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_old_jdopbs AS
 SELECT buy_request.code,
    buy_request.approved_date,
    date_part('day'::text, age((buy_request.approved_date)::timestamp with time zone)) AS dias
   FROM public.buy_request
  WHERE ((buy_request.buy_request_status_id = 2) AND (buy_request.approved_date IS NOT NULL) AND (buy_request.dt_approved_date IS NULL))
  ORDER BY (date_part('day'::text, age((buy_request.approved_date)::timestamp with time zone))) DESC;


ALTER TABLE public.view_old_jdopbs OWNER TO postgres;

--
-- Name: view_productos_mas_demandados; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_productos_mas_demandados AS
 SELECT validated_list_item.product_name,
    validated_list_item.picture,
    validated_list_item.id,
    validated_list_item.validated_list_id,
    count(validated_list_item.product_name) AS cantidad
   FROM ((public.demand_item
     JOIN public.demand ON ((demand_item.demand_id = demand.id)))
     JOIN public.validated_list_item ON ((demand_item.validated_list_item_id = validated_list_item.id)))
  WHERE (validated_list_item.active = true)
  GROUP BY validated_list_item.product_name, validated_list_item.picture, validated_list_item.id, validated_list_item.validated_list_id
  ORDER BY (count(validated_list_item.product_name)) DESC
 LIMIT 10;


ALTER TABLE public.view_productos_mas_demandados OWNER TO postgres;

--
-- Name: view_stages_actives_and_expired; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_stages_actives_and_expired AS
 SELECT buy_request.code,
    buy_request.buyer_assigned,
    buy_request.buy_request_type_id,
    stage.label,
    request_stage.date_start,
    request_stage.date_end,
    date_part('day'::text, age((request_stage.date_end)::timestamp with time zone, (request_stage.date_start)::timestamp with time zone)) AS schedule_days,
    date_part('day'::text, age((request_stage.date_start)::timestamp with time zone)) AS real_days
   FROM ((public.request_stage
     JOIN public.stage ON ((request_stage.stage_id = stage.id)))
     JOIN public.buy_request ON ((request_stage.buy_request_id = buy_request.id)))
  WHERE ((request_stage.real_end IS NULL) AND (request_stage.date_start <= now()));


ALTER TABLE public.view_stages_actives_and_expired OWNER TO postgres;

--
-- Name: warranty_time; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.warranty_time (
    id integer NOT NULL,
    label character varying(250) NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.warranty_time OWNER TO postgres;

--
-- Name: warranty_time_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.warranty_time_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.warranty_time_id_seq OWNER TO postgres;

--
-- Name: warranty_time_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.warranty_time_id_seq OWNED BY public.warranty_time.id;


--
-- Name: buy_condition id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buy_condition ALTER COLUMN id SET DEFAULT nextval('public.buy_condition_id_seq'::regclass);


--
-- Name: buy_request id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buy_request ALTER COLUMN id SET DEFAULT nextval('public.buy_request_id_seq'::regclass);


--
-- Name: buy_request_711 id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buy_request_711 ALTER COLUMN id SET DEFAULT nextval('public.buy_request_711_id_seq'::regclass);


--
-- Name: buy_request_document id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buy_request_document ALTER COLUMN id SET DEFAULT nextval('public.buy_request_document_id_seq'::regclass);


--
-- Name: buy_request_international id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buy_request_international ALTER COLUMN id SET DEFAULT nextval('public.buy_request_international_id_seq'::regclass);


--
-- Name: buy_request_provider id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buy_request_provider ALTER COLUMN id SET DEFAULT nextval('public.buy_request_provider_id_seq'::regclass);


--
-- Name: buy_request_status id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buy_request_status ALTER COLUMN id SET DEFAULT nextval('public.buy_request_status_id_seq'::regclass);


--
-- Name: buy_request_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buy_request_type ALTER COLUMN id SET DEFAULT nextval('public.buy_request_type_id_seq'::regclass);


--
-- Name: certification id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.certification ALTER COLUMN id SET DEFAULT nextval('public.certification_id_seq'::regclass);


--
-- Name: certification_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.certification_type ALTER COLUMN id SET DEFAULT nextval('public.certificaion_type_id_seq'::regclass);


--
-- Name: certification_validated_list_item id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.certification_validated_list_item ALTER COLUMN id SET DEFAULT nextval('public.certification_validated_list_item_id_seq'::regclass);


--
-- Name: client id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client ALTER COLUMN id SET DEFAULT nextval('public.client_id_seq'::regclass);


--
-- Name: country id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country ALTER COLUMN id SET DEFAULT nextval('public.country_id_seq'::regclass);


--
-- Name: demand id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.demand ALTER COLUMN id SET DEFAULT nextval('public.demand_id_seq'::regclass);


--
-- Name: demand_item id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.demand_item ALTER COLUMN id SET DEFAULT nextval('public.demand_item_id_seq'::regclass);


--
-- Name: demand_status id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.demand_status ALTER COLUMN id SET DEFAULT nextval('public.demand_status_id_seq'::regclass);


--
-- Name: deployment_part id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deployment_part ALTER COLUMN id SET DEFAULT nextval('public.deployment_part_id_seq'::regclass);


--
-- Name: destiny id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.destiny ALTER COLUMN id SET DEFAULT nextval('public.destiny_id_seq'::regclass);


--
-- Name: document_status id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_status ALTER COLUMN id SET DEFAULT nextval('public.document_status_id_seq'::regclass);


--
-- Name: document_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_type ALTER COLUMN id SET DEFAULT nextval('public.document_type_id_seq'::regclass);


--
-- Name: document_type_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_type_permission ALTER COLUMN id SET DEFAULT nextval('public.document_type_permission_id_seq'::regclass);


--
-- Name: email_notify id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_notify ALTER COLUMN id SET DEFAULT nextval('public.email_notify_id_seq'::regclass);


--
-- Name: final_destiny id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.final_destiny ALTER COLUMN id SET DEFAULT nextval('public.final_destiny_id_seq'::regclass);


--
-- Name: log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log ALTER COLUMN id SET DEFAULT nextval('public.log_id_seq'::regclass);


--
-- Name: offert id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offert ALTER COLUMN id SET DEFAULT nextval('public.offert_id_seq'::regclass);


--
-- Name: organism id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organism ALTER COLUMN id SET DEFAULT nextval('public.organism_id_seq'::regclass);


--
-- Name: payment_instrument id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_instrument ALTER COLUMN id SET DEFAULT nextval('public.payment_instrument_id_seq'::regclass);


--
-- Name: payment_method id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_method ALTER COLUMN id SET DEFAULT nextval('public.payment_method_id_seq'::regclass);


--
-- Name: provider id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provider ALTER COLUMN id SET DEFAULT nextval('public.provider_id_seq'::regclass);


--
-- Name: provider_status id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provider_status ALTER COLUMN id SET DEFAULT nextval('public.provider_status_id_seq'::regclass);


--
-- Name: provider_validated_list id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provider_validated_list ALTER COLUMN id SET DEFAULT nextval('public.provider_validated_list_id_seq'::regclass);


--
-- Name: province_ueb id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.province_ueb ALTER COLUMN id SET DEFAULT nextval('public.province_ueb_id_seq'::regclass);


--
-- Name: purchase_reason id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_reason ALTER COLUMN id SET DEFAULT nextval('public.purchase_reason_id_seq'::regclass);


--
-- Name: request_stage id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.request_stage ALTER COLUMN id SET DEFAULT nextval('public.request_stage_id_seq'::regclass);


--
-- Name: seller_requirement id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seller_requirement ALTER COLUMN id SET DEFAULT nextval('public.seller_requirement_id_seq'::regclass);


--
-- Name: stage id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stage ALTER COLUMN id SET DEFAULT nextval('public.stage_id_seq'::regclass);


--
-- Name: subfamily id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subfamily ALTER COLUMN id SET DEFAULT nextval('public.subfamily_id_seq'::regclass);


--
-- Name: um id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.um ALTER COLUMN id SET DEFAULT nextval('public.um_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Name: user_can_view id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_can_view ALTER COLUMN id SET DEFAULT nextval('public.user_can_view_id_seq'::regclass);


--
-- Name: validated_list id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.validated_list ALTER COLUMN id SET DEFAULT nextval('public.validated_list_id_seq'::regclass);


--
-- Name: validated_list_item id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.validated_list_item ALTER COLUMN id SET DEFAULT nextval('public.validated_list_item_id_seq'::regclass);


--
-- Name: warranty_time id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.warranty_time ALTER COLUMN id SET DEFAULT nextval('public.warranty_time_id_seq'::regclass);


--
-- Data for Name: auth_assignment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_assignment (item_name, user_id, created_at) FROM stdin;
root	admin	1576553616
ueb	habana	1581394159
ueb	ueb	1582369568
Jefe_logistica	jlogistica	1582370009
ep_dt	jtecnico	1582370200
especialista_tecnico	tecnico	1582370376
miembro_comite	comite	1583781859
ueb	ueb_pinar	1589134175
ueb	ueb_santiagp	1589134230
jefe_compras	jnacional	1590850654
buyer	cinternacional	1590894652
buyer	cnacional	1590894683
buyer	c711	1590894701
especialista_logistica	logistica	1591282798
jefe_compras	jcompras	1591283221
especialista_logistica	gol	1591283584
\.


--
-- Data for Name: auth_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_item (name, type, description, rule_name, data, created_at, updated_at) FROM stdin;
roles	1	\N	\N	\N	\N	\N
actions	1	\N	\N	\N	\N	\N
root	1	Super administrador	\N	\N	\N	\N
country/*	1	Country/*	\N	\N	\N	\N
country/index	2	Country/index	\N	\N	\N	\N
country/view	2	Country/view	\N	\N	\N	\N
country/create	2	Country/create	\N	\N	\N	\N
country/update	2	Country/update	\N	\N	\N	\N
country/delete	2	Country/delete	\N	\N	\N	\N
manage/*	1	Manage/*	\N	\N	\N	\N
manage/rbac	2	Manage/rbac	\N	\N	\N	\N
manage/view	2	Manage/view	\N	\N	\N	\N
manage/createrole	2	Manage/createrole	\N	\N	\N	\N
manage/updaterole	2	Manage/updaterole	\N	\N	\N	\N
manage/updateperm	2	Manage/updateperm	\N	\N	\N	\N
manage/modifyrol	2	Manage/modifyrol	\N	\N	\N	\N
manage/delete	2	Manage/delete	\N	\N	\N	\N
site/*	1	Site/*	\N	\N	\N	\N
site/index	2	Site/index	\N	\N	\N	\N
site/login	2	Site/login	\N	\N	\N	\N
site/logout	2	Site/logout	\N	\N	\N	\N
site/contact	2	Site/contact	\N	\N	\N	\N
site/about	2	Site/about	\N	\N	\N	\N
user/*	1	User/*	\N	\N	\N	\N
user/index	2	User/index	\N	\N	\N	\N
user/view	2	User/view	\N	\N	\N	\N
user/create	2	User/create	\N	\N	\N	\N
user/update	2	User/update	\N	\N	\N	\N
buyrequeststatus/*	1	BuyRequestStatus/*	\N	\N	\N	\N
buyrequeststatus/index	2	BuyRequestStatus/index	\N	\N	\N	\N
buyrequeststatus/view	2	BuyRequestStatus/view	\N	\N	\N	\N
buyrequeststatus/create	2	BuyRequestStatus/create	\N	\N	\N	\N
buyrequeststatus/update	2	BuyRequestStatus/update	\N	\N	\N	\N
buyrequeststatus/delete	2	BuyRequestStatus/delete	\N	\N	\N	\N
certification/*	1	Certification/*	\N	\N	\N	\N
certification/index	2	Certification/index	\N	\N	\N	\N
certification/view	2	Certification/view	\N	\N	\N	\N
certification/create	2	Certification/create	\N	\N	\N	\N
certification/update	2	Certification/update	\N	\N	\N	\N
certification/delete	2	Certification/delete	\N	\N	\N	\N
certificationtype/*	1	CertificationType/*	\N	\N	\N	\N
certificationtype/index	2	CertificationType/index	\N	\N	\N	\N
certificationtype/view	2	CertificationType/view	\N	\N	\N	\N
certificationtype/create	2	CertificationType/create	\N	\N	\N	\N
certificationtype/update	2	CertificationType/update	\N	\N	\N	\N
certificationtype/delete	2	CertificationType/delete	\N	\N	\N	\N
demandstatus/*	1	DemandStatus/*	\N	\N	\N	\N
demandstatus/index	2	DemandStatus/index	\N	\N	\N	\N
demandstatus/view	2	DemandStatus/view	\N	\N	\N	\N
demandstatus/create	2	DemandStatus/create	\N	\N	\N	\N
demandstatus/update	2	DemandStatus/update	\N	\N	\N	\N
demandstatus/delete	2	DemandStatus/delete	\N	\N	\N	\N
deploymentpart/*	1	DeploymentPart/*	\N	\N	\N	\N
deploymentpart/index	2	DeploymentPart/index	\N	\N	\N	\N
deploymentpart/view	2	DeploymentPart/view	\N	\N	\N	\N
deploymentpart/create	2	DeploymentPart/create	\N	\N	\N	\N
deploymentpart/update	2	DeploymentPart/update	\N	\N	\N	\N
deploymentpart/delete	2	DeploymentPart/delete	\N	\N	\N	\N
documenttype/*	1	DocumentType/*	\N	\N	\N	\N
documenttype/index	2	DocumentType/index	\N	\N	\N	\N
documenttype/view	2	DocumentType/view	\N	\N	\N	\N
documenttype/create	2	DocumentType/create	\N	\N	\N	\N
documenttype/update	2	DocumentType/update	\N	\N	\N	\N
documenttype/delete	2	DocumentType/delete	\N	\N	\N	\N
documenttypepermission/*	1	DocumentTypePermission/*	\N	\N	\N	\N
documenttypepermission/index	2	DocumentTypePermission/index	\N	\N	\N	\N
documenttypepermission/view	2	DocumentTypePermission/view	\N	\N	\N	\N
documenttypepermission/create	2	DocumentTypePermission/create	\N	\N	\N	\N
documenttypepermission/update	2	DocumentTypePermission/update	\N	\N	\N	\N
documenttypepermission/delete	2	DocumentTypePermission/delete	\N	\N	\N	\N
organism/*	1	Organism/*	\N	\N	\N	\N
organism/index	2	Organism/index	\N	\N	\N	\N
organism/view	2	Organism/view	\N	\N	\N	\N
organism/create	2	Organism/create	\N	\N	\N	\N
organism/update	2	Organism/update	\N	\N	\N	\N
organism/delete	2	Organism/delete	\N	\N	\N	\N
paymentmethod/*	1	PaymentMethod/*	\N	\N	\N	\N
paymentmethod/index	2	PaymentMethod/index	\N	\N	\N	\N
paymentmethod/view	2	PaymentMethod/view	\N	\N	\N	\N
paymentmethod/create	2	PaymentMethod/create	\N	\N	\N	\N
paymentmethod/update	2	PaymentMethod/update	\N	\N	\N	\N
paymentmethod/delete	2	PaymentMethod/delete	\N	\N	\N	\N
provinceueb/*	1	ProvinceUeb/*	\N	\N	\N	\N
provinceueb/index	2	ProvinceUeb/index	\N	\N	\N	\N
provinceueb/view	2	ProvinceUeb/view	\N	\N	\N	\N
provinceueb/create	2	ProvinceUeb/create	\N	\N	\N	\N
provinceueb/update	2	ProvinceUeb/update	\N	\N	\N	\N
provinceueb/delete	2	ProvinceUeb/delete	\N	\N	\N	\N
purchasereason/*	1	PurchaseReason/*	\N	\N	\N	\N
purchasereason/index	2	PurchaseReason/index	\N	\N	\N	\N
purchasereason/view	2	PurchaseReason/view	\N	\N	\N	\N
purchasereason/create	2	PurchaseReason/create	\N	\N	\N	\N
purchasereason/update	2	PurchaseReason/update	\N	\N	\N	\N
purchasereason/delete	2	PurchaseReason/delete	\N	\N	\N	\N
stage/*	1	Stage/*	\N	\N	\N	\N
stage/index	2	Stage/index	\N	\N	\N	\N
stage/view	2	Stage/view	\N	\N	\N	\N
stage/create	2	Stage/create	\N	\N	\N	\N
stage/update	2	Stage/update	\N	\N	\N	\N
stage/delete	2	Stage/delete	\N	\N	\N	\N
um/*	1	Um/*	\N	\N	\N	\N
um/index	2	Um/index	\N	\N	\N	\N
um/view	2	Um/view	\N	\N	\N	\N
um/create	2	Um/create	\N	\N	\N	\N
um/update	2	Um/update	\N	\N	\N	\N
um/delete	2	Um/delete	\N	\N	\N	\N
validatedlist/*	1	ValidatedList/*	\N	\N	\N	\N
validatedlist/index	2	ValidatedList/index	\N	\N	\N	\N
validatedlist/view	2	ValidatedList/view	\N	\N	\N	\N
validatedlist/create	2	ValidatedList/create	\N	\N	\N	\N
validatedlist/update	2	ValidatedList/update	\N	\N	\N	\N
validatedlist/delete	2	ValidatedList/delete	\N	\N	\N	\N
warrantytime/*	1	WarrantyTime/*	\N	\N	\N	\N
warrantytime/index	2	WarrantyTime/index	\N	\N	\N	\N
warrantytime/view	2	WarrantyTime/view	\N	\N	\N	\N
warrantytime/create	2	WarrantyTime/create	\N	\N	\N	\N
warrantytime/update	2	WarrantyTime/update	\N	\N	\N	\N
warrantytime/delete	2	WarrantyTime/delete	\N	\N	\N	\N
ueb	1	Especialista UEB	\N	\N	\N	\N
user/disable	2	User/disable	\N	\N	\N	\N
user/logs	2	User/logs	\N	\N	\N	\N
demand/*	1	Demand/*	\N	\N	\N	\N
demand/index	2	Demand/index	\N	\N	\N	\N
demand/view	2	Demand/view	\N	\N	\N	\N
demand/create	2	Demand/create	\N	\N	\N	\N
demand/update	2	Demand/update	\N	\N	\N	\N
demand/delete	2	Demand/delete	\N	\N	\N	\N
client/*	1	Client/*	\N	\N	\N	\N
client/index	2	Client/index	\N	\N	\N	\N
client/view	2	Client/view	\N	\N	\N	\N
client/create	2	Client/create	\N	\N	\N	\N
client/update	2	Client/update	\N	\N	\N	\N
client/delete	2	Client/delete	\N	\N	\N	\N
client/combo	2	Client/combo	\N	\N	\N	\N
sellerrequirement/*	1	SellerRequirement/*	\N	\N	\N	\N
sellerrequirement/index	2	SellerRequirement/index	\N	\N	\N	\N
sellerrequirement/view	2	SellerRequirement/view	\N	\N	\N	\N
sellerrequirement/create	2	SellerRequirement/create	\N	\N	\N	\N
sellerrequirement/update	2	SellerRequirement/update	\N	\N	\N	\N
sellerrequirement/delete	2	SellerRequirement/delete	\N	\N	\N	\N
demand/demandproducts	2	Demand/demandproducts	\N	\N	\N	\N
subfamily/*	1	Subfamily/*	\N	\N	\N	\N
subfamily/index	2	Subfamily/index	\N	\N	\N	\N
subfamily/view	2	Subfamily/view	\N	\N	\N	\N
subfamily/create	2	Subfamily/create	\N	\N	\N	\N
subfamily/update	2	Subfamily/update	\N	\N	\N	\N
subfamily/delete	2	Subfamily/delete	\N	\N	\N	\N
validatedlistitem/*	1	ValidatedListItem/*	\N	\N	\N	\N
validatedlistitem/create	2	ValidatedListItem/create	\N	\N	\N	\N
validatedlistitem/update	2	ValidatedListItem/update	\N	\N	\N	\N
validatedlistitem/delete	2	ValidatedListItem/delete	\N	\N	\N	\N
demand/send	2	Demand/send	\N	\N	\N	\N
demanditem/*	1	DemandItem/*	\N	\N	\N	\N
demand/approve	2	Demand/approve	\N	\N	\N	\N
demand/reject	2	Demand/reject	\N	\N	\N	\N
demand/clasify	2	Demand/clasify	\N	\N	\N	\N
buyrequesttype/*	1	BuyRequestType/*	\N	\N	\N	\N
buyrequesttype/index	2	BuyRequestType/index	\N	\N	\N	\N
buyrequesttype/view	2	BuyRequestType/view	\N	\N	\N	\N
buyrequesttype/create	2	BuyRequestType/create	\N	\N	\N	\N
buyrequesttype/update	2	BuyRequestType/update	\N	\N	\N	\N
buyrequesttype/delete	2	BuyRequestType/delete	\N	\N	\N	\N
demand/divide	2	Demand/divide	\N	\N	\N	\N
buyrequest/*	1	BuyRequest/*	\N	\N	\N	\N
buyrequest/index	2	BuyRequest/index	\N	\N	\N	\N
buyrequest/view	2	BuyRequest/view	\N	\N	\N	\N
buyrequest/create	2	BuyRequest/create	\N	\N	\N	\N
buyrequest/update	2	BuyRequest/update	\N	\N	\N	\N
buyrequest/delete	2	BuyRequest/delete	\N	\N	\N	\N
buyrequest/viewassociateddemands	2	BuyRequest/viewassociateddemands	\N	\N	\N	\N
buyrequest/viewproducts	2	BuyRequest/viewproducts	\N	\N	\N	\N
buyrequest/viewpropuestas	2	BuyRequest/viewpropuestas	\N	\N	\N	\N
buyrequest/removeitem	2	BuyRequest/removeitem	\N	\N	\N	\N
buyrequest/approve	2	BuyRequest/approve	\N	\N	\N	\N
buyrequest/golapproved	2	BuyRequest/golapproved	\N	\N	\N	\N
buyrequest/export	2	BuyRequest/export	\N	\N	\N	\N
buyrequest/assignuser	2	BuyRequest/assignuser	\N	\N	\N	\N
Jefe_logistica	1	Jefe dirección logística	\N	\N	\N	\N
jefe_compras	1	EP Compras	\N	\N	\N	\N
ep_dt	1	EP Dirección técnica	\N	\N	\N	\N
especialista_tecnico	1	Especialista técnico	\N	\N	\N	\N
demand/deleteitem	2	Demand/deleteitem	\N	\N	\N	\N
demand/cancelitem	2	Demand/cancelitem	\N	\N	\N	\N
buyrequest/assignbuyer	2	BuyRequest/assignbuyer	\N	\N	\N	\N
buyrequest/assignet	2	BuyRequest/assignet	\N	\N	\N	\N
provider/*	1	Provider/*	\N	\N	\N	\N
provider/index	2	Provider/index	\N	\N	\N	\N
provider/view	2	Provider/view	\N	\N	\N	\N
provider/create	2	Provider/create	\N	\N	\N	\N
provider/update	2	Provider/update	\N	\N	\N	\N
provider/delete	2	Provider/delete	\N	\N	\N	\N
buyrequest/reject	2	BuyRequest/reject	\N	\N	\N	\N
buycondition/*	1	BuyCondition/*	\N	\N	\N	\N
buycondition/index	2	BuyCondition/index	\N	\N	\N	\N
buycondition/view	2	BuyCondition/view	\N	\N	\N	\N
buycondition/create	2	BuyCondition/create	\N	\N	\N	\N
buycondition/update	2	BuyCondition/update	\N	\N	\N	\N
buycondition/delete	2	BuyCondition/delete	\N	\N	\N	\N
destiny/*	1	Destiny/*	\N	\N	\N	\N
destiny/index	2	Destiny/index	\N	\N	\N	\N
destiny/view	2	Destiny/view	\N	\N	\N	\N
destiny/create	2	Destiny/create	\N	\N	\N	\N
destiny/update	2	Destiny/update	\N	\N	\N	\N
destiny/delete	2	Destiny/delete	\N	\N	\N	\N
paymentinstrument/*	1	PaymentInstrument/*	\N	\N	\N	\N
paymentinstrument/index	2	PaymentInstrument/index	\N	\N	\N	\N
paymentinstrument/view	2	PaymentInstrument/view	\N	\N	\N	\N
paymentinstrument/create	2	PaymentInstrument/create	\N	\N	\N	\N
paymentinstrument/update	2	PaymentInstrument/update	\N	\N	\N	\N
paymentinstrument/delete	2	PaymentInstrument/delete	\N	\N	\N	\N
providerstatus/*	1	ProviderStatus/*	\N	\N	\N	\N
providerstatus/index	2	ProviderStatus/index	\N	\N	\N	\N
providerstatus/view	2	ProviderStatus/view	\N	\N	\N	\N
providerstatus/create	2	ProviderStatus/create	\N	\N	\N	\N
providerstatus/update	2	ProviderStatus/update	\N	\N	\N	\N
providerstatus/delete	2	ProviderStatus/delete	\N	\N	\N	\N
buyrequest/providerdetails	2	BuyRequest/providerdetails	\N	\N	\N	\N
buyrequest/uploadoffert	2	BuyRequest/uploadoffert	\N	\N	\N	\N
buyrequest/saveofert	2	BuyRequest/saveofert	\N	\N	\N	\N
buyrequest/validateofert	2	BuyRequest/validateofert	\N	\N	\N	\N
buyrequest/evaluateoffert	2	BuyRequest/evaluateoffert	\N	\N	\N	\N
buyrequest/selectwinners	2	BuyRequest/selectwinners	\N	\N	\N	\N
user/addfileaccess	2	User/addfileaccess	\N	\N	\N	\N
user/deletedocumentaccess	2	User/deletedocumentaccess	\N	\N	\N	\N
user/updatedocumentaccess	2	User/updatedocumentaccess	\N	\N	\N	\N
buyrequest/viewdocuments	2	BuyRequest/viewdocuments	\N	\N	\N	\N
buyrequest/sendtomonitoring	2	BuyRequest/sendtomonitoring	\N	\N	\N	\N
buyrequest/uploadfileexpedient	2	BuyRequest/uploadfileexpedient	\N	\N	\N	\N
documentstatus/*	1	DocumentStatus/*	\N	\N	\N	\N
documentstatus/index	2	DocumentStatus/index	\N	\N	\N	\N
documentstatus/view	2	DocumentStatus/view	\N	\N	\N	\N
documentstatus/create	2	DocumentStatus/create	\N	\N	\N	\N
documentstatus/update	2	DocumentStatus/update	\N	\N	\N	\N
documentstatus/delete	2	DocumentStatus/delete	\N	\N	\N	\N
tec_logistica	1	Dirección logística	\N	\N	\N	\N
especialista_logistica	1	Especialista Logística	\N	\N	\N	\N
buyrequest/dtapproved	2	BuyRequest/dtapproved	\N	\N	\N	\N
buyrequest/buyapproved	2	BuyRequest/buyapproved	\N	\N	\N	\N
buyrequest/changebidding	2	BuyRequest/changebidding	\N	\N	\N	\N
miembro_comite	1	Miembro comité	\N	\N	\N	\N
buyrequest/uploadotherdocs	2	BuyRequest/uploadotherdocs	\N	\N	\N	\N
buyrequest/viewtransportation	2	BuyRequest/viewtransportation	\N	\N	\N	\N
buyrequest/updatestage	2	BuyRequest/updatestage	\N	\N	\N	\N
buyrequest/stagesuccess	2	BuyRequest/stagesuccess	\N	\N	\N	\N
buyrequest/validatemonitoring	2	BuyRequest/validatemonitoring	\N	\N	\N	\N
buyrequest/validateevaluateofert	2	BuyRequest/validateevaluateofert	\N	\N	\N	\N
buyrequest/generatenacionaloffert	2	BuyRequest/generatenacionaloffert	\N	\N	\N	\N
buyrequest/closebidding	2	BuyRequest/closebidding	\N	\N	\N	\N
finaldestiny/*	1	FinalDestiny/*	\N	\N	\N	\N
finaldestiny/index	2	FinalDestiny/index	\N	\N	\N	\N
finaldestiny/view	2	FinalDestiny/view	\N	\N	\N	\N
finaldestiny/create	2	FinalDestiny/create	\N	\N	\N	\N
finaldestiny/update	2	FinalDestiny/update	\N	\N	\N	\N
finaldestiny/delete	2	FinalDestiny/delete	\N	\N	\N	\N
buyrequest711/*	1	BuyRequest711/*	\N	\N	\N	\N
buyrequest711/index	2	BuyRequest711/index	\N	\N	\N	\N
buyrequest711/view	2	BuyRequest711/view	\N	\N	\N	\N
buyrequest711/create	2	BuyRequest711/create	\N	\N	\N	\N
buyrequest711/update	2	BuyRequest711/update	\N	\N	\N	\N
buyrequest711/delete	2	BuyRequest711/delete	\N	\N	\N	\N
buyrequest711/separate	2	BuyRequest711/separate	\N	\N	\N	\N
buyrequest711/presentar	2	BuyRequest711/presentar	\N	\N	\N	\N
site/indexlogistica	2	Site/indexlogistica	\N	\N	\N	\N
site/mail	2	Site/mail	\N	\N	\N	\N
buyrequestinternational/*	1	BuyRequestInternational/*	\N	\N	\N	\N
buyrequestinternational/validatecreate	2	BuyRequestInternational/validatecreate	\N	\N	\N	\N
user/myaccount	2	User/myaccount	\N	\N	\N	\N
user/changepassword	2	User/changepassword	\N	\N	\N	\N
user/validatepassword	2	User/validatepassword	\N	\N	\N	\N
demanditem/additem	2	DemandItem/additem	\N	\N	\N	\N
validatedlistitem/modaldetail	2	ValidatedListItem/modaldetail	\N	\N	\N	\N
validatedlistitem/requestadd	2	ValidatedListItem/requestadd	\N	\N	\N	\N
inform/*	1	Inform/*	\N	\N	\N	\N
inform/index	2	Inform/index	\N	\N	\N	\N
inform/demandasproductosmassolicitados	2	Inform/demandasproductosmassolicitados	\N	\N	\N	\N
inform/demandasproductosmassolicitadostrimestre	2	Inform/demandasproductosmassolicitadostrimestre	\N	\N	\N	\N
inform/demandaspendientes	2	Inform/demandaspendientes	\N	\N	\N	\N
inform/demandasrechazadas	2	Inform/demandasrechazadas	\N	\N	\N	\N
inform/solicitudesactivas	2	Inform/solicitudesactivas	\N	\N	\N	\N
inform/solicitudesfuerafecha	2	Inform/solicitudesfuerafecha	\N	\N	\N	\N
inform/ventas	2	Inform/ventas	\N	\N	9276416329	9276416329
inform/solicitudesentransportacion	2	Inform/solicitudesentransportacion	\N	\N	9276420613	9276420613
inform/solicitudesentransportacionvencidas	2	Inform/solicitudesentransportacionvencidas	\N	\N	9276421953	9276421953
buyer	1	Comprador	\N	\N	1590894606	1590894606
\.


--
-- Data for Name: auth_item_child; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_item_child (parent, child) FROM stdin;
roles	root
actions	country/*
country/*	country/index
country/*	country/view
country/*	country/create
country/*	country/update
country/*	country/delete
actions	manage/*
manage/*	manage/rbac
manage/*	manage/view
manage/*	manage/createrole
manage/*	manage/updaterole
manage/*	manage/updateperm
manage/*	manage/modifyrol
manage/*	manage/delete
actions	site/*
site/*	site/index
site/*	site/login
site/*	site/logout
site/*	site/contact
site/*	site/about
actions	user/*
user/*	user/index
user/*	user/view
user/*	user/create
user/*	user/update
root	manage/*
actions	buyrequeststatus/*
buyrequeststatus/*	buyrequeststatus/index
buyrequeststatus/*	buyrequeststatus/view
buyrequeststatus/*	buyrequeststatus/create
buyrequeststatus/*	buyrequeststatus/update
buyrequeststatus/*	buyrequeststatus/delete
actions	certification/*
certification/*	certification/index
certification/*	certification/view
certification/*	certification/create
certification/*	certification/update
certification/*	certification/delete
actions	certificationtype/*
certificationtype/*	certificationtype/index
certificationtype/*	certificationtype/view
certificationtype/*	certificationtype/create
certificationtype/*	certificationtype/update
certificationtype/*	certificationtype/delete
actions	demandstatus/*
demandstatus/*	demandstatus/index
demandstatus/*	demandstatus/view
demandstatus/*	demandstatus/create
demandstatus/*	demandstatus/update
demandstatus/*	demandstatus/delete
actions	deploymentpart/*
deploymentpart/*	deploymentpart/index
deploymentpart/*	deploymentpart/view
deploymentpart/*	deploymentpart/create
deploymentpart/*	deploymentpart/update
deploymentpart/*	deploymentpart/delete
actions	documenttype/*
documenttype/*	documenttype/index
documenttype/*	documenttype/view
documenttype/*	documenttype/create
documenttype/*	documenttype/update
documenttype/*	documenttype/delete
actions	documenttypepermission/*
documenttypepermission/*	documenttypepermission/index
documenttypepermission/*	documenttypepermission/view
documenttypepermission/*	documenttypepermission/create
documenttypepermission/*	documenttypepermission/update
documenttypepermission/*	documenttypepermission/delete
actions	organism/*
organism/*	organism/index
organism/*	organism/view
organism/*	organism/create
organism/*	organism/update
organism/*	organism/delete
actions	paymentmethod/*
paymentmethod/*	paymentmethod/index
paymentmethod/*	paymentmethod/view
paymentmethod/*	paymentmethod/create
paymentmethod/*	paymentmethod/update
paymentmethod/*	paymentmethod/delete
actions	provinceueb/*
provinceueb/*	provinceueb/index
provinceueb/*	provinceueb/view
provinceueb/*	provinceueb/create
provinceueb/*	provinceueb/update
provinceueb/*	provinceueb/delete
actions	purchasereason/*
purchasereason/*	purchasereason/index
purchasereason/*	purchasereason/view
purchasereason/*	purchasereason/create
purchasereason/*	purchasereason/update
purchasereason/*	purchasereason/delete
actions	stage/*
stage/*	stage/index
stage/*	stage/view
stage/*	stage/create
stage/*	stage/update
stage/*	stage/delete
actions	um/*
um/*	um/index
um/*	um/view
um/*	um/create
um/*	um/update
um/*	um/delete
actions	validatedlist/*
validatedlist/*	validatedlist/index
validatedlist/*	validatedlist/view
validatedlist/*	validatedlist/create
validatedlist/*	validatedlist/update
validatedlist/*	validatedlist/delete
actions	warrantytime/*
warrantytime/*	warrantytime/index
warrantytime/*	warrantytime/view
warrantytime/*	warrantytime/create
warrantytime/*	warrantytime/update
warrantytime/*	warrantytime/delete
root	buyrequeststatus/*
root	certification/*
root	certificationtype/*
root	country/*
root	demandstatus/*
root	deploymentpart/*
root	documenttype/*
root	organism/*
root	paymentmethod/*
root	stage/*
root	purchasereason/*
root	provinceueb/*
root	um/*
root	warrantytime/*
roles	ueb
user/*	user/disable
user/*	user/logs
root	user/logs
actions	demand/*
demand/*	demand/index
demand/*	demand/view
demand/*	demand/create
demand/*	demand/update
demand/*	demand/delete
ueb	demand/index
ueb	demand/view
ueb	demand/create
ueb	demand/update
actions	client/*
client/*	client/index
client/*	client/view
client/*	client/create
client/*	client/update
client/*	client/delete
ueb	client/index
ueb	client/view
ueb	client/*
client/*	client/combo
ueb	client/combo
actions	sellerrequirement/*
sellerrequirement/*	sellerrequirement/index
sellerrequirement/*	sellerrequirement/view
sellerrequirement/*	sellerrequirement/create
sellerrequirement/*	sellerrequirement/update
sellerrequirement/*	sellerrequirement/delete
root	sellerrequirement/*
demand/*	demand/demandproducts
actions	subfamily/*
subfamily/*	subfamily/index
subfamily/*	subfamily/view
subfamily/*	subfamily/create
subfamily/*	subfamily/update
subfamily/*	subfamily/delete
actions	validatedlistitem/*
validatedlistitem/*	validatedlistitem/create
validatedlistitem/*	validatedlistitem/update
validatedlistitem/*	validatedlistitem/delete
ueb	demand/demandproducts
demand/*	demand/send
actions	demanditem/*
ueb	demand/send
ueb	site/*
root	site/*
demand/*	demand/approve
demand/*	demand/reject
demand/*	demand/clasify
actions	buyrequesttype/*
buyrequesttype/*	buyrequesttype/index
buyrequesttype/*	buyrequesttype/view
buyrequesttype/*	buyrequesttype/create
buyrequesttype/*	buyrequesttype/update
buyrequesttype/*	buyrequesttype/delete
root	buyrequesttype/*
demand/*	demand/divide
actions	buyrequest/*
buyrequest/*	buyrequest/index
buyrequest/*	buyrequest/view
buyrequest/*	buyrequest/create
buyrequest/*	buyrequest/update
buyrequest/*	buyrequest/delete
buyrequest/*	buyrequest/viewassociateddemands
buyrequest/*	buyrequest/viewproducts
buyrequest/*	buyrequest/viewpropuestas
buyrequest/*	buyrequest/removeitem
buyrequest/*	buyrequest/approve
buyrequest/*	buyrequest/golapproved
buyrequest/*	buyrequest/export
buyrequest/*	buyrequest/assignuser
ueb	demand/delete
roles	Jefe_logistica
roles	jefe_compras
roles	ep_dt
roles	especialista_tecnico
demand/*	demand/deleteitem
ueb	demand/deleteitem
Jefe_logistica	demand/index
Jefe_logistica	demand/approve
Jefe_logistica	demand/reject
Jefe_logistica	demand/view
Jefe_logistica	demand/demandproducts
Jefe_logistica	demand/divide
Jefe_logistica	demand/clasify
demand/*	demand/cancelitem
Jefe_logistica	demand/cancelitem
Jefe_logistica	buyrequest/index
Jefe_logistica	buyrequest/viewassociateddemands
Jefe_logistica	buyrequest/viewproducts
Jefe_logistica	buyrequest/update
Jefe_logistica	buyrequest/delete
Jefe_logistica	buyrequest/approve
jefe_compras	buyrequest/index
jefe_compras	buyrequest/view
jefe_compras	buyrequest/export
jefe_compras	buyrequest/assignuser
buyrequest/*	buyrequest/assignbuyer
buyrequest/*	buyrequest/assignet
jefe_compras	buyrequest/assignbuyer
ep_dt	buyrequest/index
ep_dt	buyrequest/view
ep_dt	buyrequest/assignet
ep_dt	buyrequest/assignuser
ep_dt	buyrequest/export
especialista_tecnico	buyrequest/index
especialista_tecnico	buyrequest/update
especialista_tecnico	buyrequest/view
especialista_tecnico	buyrequest/viewproducts
especialista_tecnico	buyrequest/viewpropuestas
actions	provider/*
provider/*	provider/index
provider/*	provider/view
provider/*	provider/create
provider/*	provider/update
provider/*	provider/delete
jefe_compras	provider/*
buyrequest/*	buyrequest/reject
Jefe_logistica	buyrequest/reject
Jefe_logistica	buyrequest/export
actions	buycondition/*
buycondition/*	buycondition/index
buycondition/*	buycondition/view
buycondition/*	buycondition/create
buycondition/*	buycondition/update
buycondition/*	buycondition/delete
actions	destiny/*
destiny/*	destiny/index
destiny/*	destiny/view
destiny/*	destiny/create
destiny/*	destiny/update
destiny/*	destiny/delete
actions	paymentinstrument/*
paymentinstrument/*	paymentinstrument/index
paymentinstrument/*	paymentinstrument/view
paymentinstrument/*	paymentinstrument/create
paymentinstrument/*	paymentinstrument/update
paymentinstrument/*	paymentinstrument/delete
root	buycondition/*
root	destiny/*
root	paymentinstrument/*
actions	providerstatus/*
providerstatus/*	providerstatus/index
providerstatus/*	providerstatus/view
providerstatus/*	providerstatus/create
providerstatus/*	providerstatus/update
providerstatus/*	providerstatus/delete
root	providerstatus/*
buyrequest/*	buyrequest/providerdetails
buyrequest/*	buyrequest/uploadoffert
buyrequest/*	buyrequest/saveofert
buyrequest/*	buyrequest/validateofert
buyrequest/*	buyrequest/evaluateoffert
especialista_tecnico	buyrequest/providerdetails
especialista_tecnico	buyrequest/evaluateoffert
buyrequest/*	buyrequest/selectwinners
user/*	user/addfileaccess
root	user/addfileaccess
user/*	user/deletedocumentaccess
user/*	user/updatedocumentaccess
root	user/deletedocumentaccess
root	user/updatedocumentaccess
buyrequest/*	buyrequest/viewdocuments
buyrequest/*	buyrequest/sendtomonitoring
buyrequest/*	buyrequest/uploadfileexpedient
actions	documentstatus/*
documentstatus/*	documentstatus/index
documentstatus/*	documentstatus/view
documentstatus/*	documentstatus/create
documentstatus/*	documentstatus/update
documentstatus/*	documentstatus/delete
root	documentstatus/*
roles	especialista_logistica
especialista_logistica	demand/index
especialista_logistica	demand/approve
especialista_logistica	demand/reject
especialista_logistica	demand/view
especialista_logistica	demand/cancelitem
especialista_logistica	demand/demandproducts
especialista_logistica	demand/clasify
especialista_logistica	buyrequest/index
especialista_logistica	buyrequest/view
especialista_logistica	buyrequest/update
especialista_logistica	buyrequest/providerdetails
especialista_logistica	buyrequest/viewassociateddemands
especialista_logistica	buyrequest/viewproducts
buyrequest/*	buyrequest/dtapproved
ep_dt	buyrequest/dtapproved
buyrequest/*	buyrequest/buyapproved
jefe_compras	buyrequest/buyapproved
buyrequest/*	buyrequest/changebidding
roles	miembro_comite
miembro_comite	buyrequest/index
miembro_comite	buyrequest/view
miembro_comite	buyrequest/update
miembro_comite	buyrequest/viewproducts
miembro_comite	buyrequest/viewpropuestas
miembro_comite	buyrequest/viewdocuments
miembro_comite	buyrequest/uploadfileexpedient
buyrequest/*	buyrequest/uploadotherdocs
buyrequest/*	buyrequest/viewtransportation
buyrequest/*	buyrequest/updatestage
buyrequest/*	buyrequest/stagesuccess
buyrequest/*	buyrequest/validatemonitoring
buyrequest/*	buyrequest/validateevaluateofert
ep_dt	buyrequest/validateevaluateofert
especialista_tecnico	buyrequest/validateevaluateofert
buyrequest/*	buyrequest/generatenacionaloffert
buyrequest/*	buyrequest/closebidding
especialista_logistica	demand/divide
actions	finaldestiny/*
finaldestiny/*	finaldestiny/index
finaldestiny/*	finaldestiny/view
finaldestiny/*	finaldestiny/create
finaldestiny/*	finaldestiny/update
finaldestiny/*	finaldestiny/delete
root	finaldestiny/*
actions	buyrequest711/*
buyrequest711/*	buyrequest711/index
buyrequest711/*	buyrequest711/view
buyrequest711/*	buyrequest711/create
buyrequest711/*	buyrequest711/update
buyrequest711/*	buyrequest711/delete
especialista_logistica	buyrequest711/create
especialista_logistica	buyrequest711/update
especialista_logistica	buyrequest/reject
especialista_logistica	buyrequest/delete
especialista_logistica	buyrequest711/view
Jefe_logistica	buyrequest711/view
buyrequest711/*	buyrequest711/separate
especialista_logistica	buyrequest711/separate
buyrequest711/*	buyrequest711/presentar
site/*	site/indexlogistica
site/*	site/mail
actions	buyrequestinternational/*
buyrequestinternational/*	buyrequestinternational/validatecreate
Jefe_logistica	buyrequest/view
jefe_compras	buyrequest/viewpropuestas
user/*	user/myaccount
user/*	user/changepassword
user/*	user/validatepassword
ueb	user/changepassword
ueb	user/validatepassword
ueb	user/myaccount
Jefe_logistica	user/myaccount
Jefe_logistica	user/changepassword
Jefe_logistica	user/validatepassword
jefe_compras	user/myaccount
jefe_compras	user/changepassword
jefe_compras	user/validatepassword
ep_dt	user/myaccount
ep_dt	user/changepassword
ep_dt	user/validatepassword
especialista_tecnico	user/myaccount
especialista_tecnico	user/changepassword
especialista_tecnico	user/validatepassword
especialista_logistica	user/myaccount
especialista_logistica	user/changepassword
especialista_logistica	user/validatepassword
demanditem/*	demanditem/additem
ueb	demanditem/additem
validatedlistitem/*	validatedlistitem/modaldetail
ueb	validatedlistitem/modaldetail
validatedlistitem/*	validatedlistitem/requestadd
ueb	validatedlistitem/requestadd
actions	inform/*
inform/*	inform/index
especialista_logistica	inform/index
Jefe_logistica	inform/index
inform/*	inform/demandasproductosmassolicitados
Jefe_logistica	inform/demandasproductosmassolicitados
inform/*	inform/demandasproductosmassolicitadostrimestre
Jefe_logistica	inform/demandasproductosmassolicitadostrimestre
inform/*	inform/demandaspendientes
Jefe_logistica	inform/demandaspendientes
inform/*	inform/demandasrechazadas
Jefe_logistica	inform/demandasrechazadas
inform/*	inform/solicitudesactivas
Jefe_logistica	inform/solicitudesactivas
inform/*	inform/solicitudesfuerafecha
Jefe_logistica	inform/solicitudesfuerafecha
inform/*	inform/ventas
Jefe_logistica	inform/ventas
inform/*	inform/solicitudesentransportacion
Jefe_logistica	inform/solicitudesentransportacion
inform/*	inform/solicitudesentransportacionvencidas
Jefe_logistica	inform/solicitudesentransportacionvencidas
root	user/index
root	user/*
especialista_logistica	demand/create
root	client/*
especialista_logistica	client/combo
especialista_logistica	demanditem/additem
especialista_logistica	demand/send
roles	buyer
buyer	buyrequest711/*
buyer	buyrequest711/index
buyer	buyrequest711/view
buyer	buyrequest711/create
buyer	buyrequest711/presentar
buyer	buyrequest711/update
buyer	buyrequest711/separate
buyer	buyrequest711/delete
buyer	buyrequest/index
buyer	buyrequest/view
buyer	buyrequest/update
buyer	buyrequest/generatenacionaloffert
buyer	buyrequest/providerdetails
buyer	buyrequest/viewassociateddemands
buyer	buyrequest/viewproducts
buyer	buyrequest/viewpropuestas
buyer	buyrequest/export
buyer	buyrequest/uploadoffert
buyer	buyrequest/saveofert
buyer	buyrequest/selectwinners
buyer	buyrequest/closebidding
buyer	buyrequest/validatemonitoring
buyer	buyrequest/sendtomonitoring
buyer	buyrequest/stagesuccess
buyer	buyrequest/changebidding
buyer	buyrequest/uploadfileexpedient
buyer	buyrequest/updatestage
buyer	buyrequest/uploadotherdocs
buyer	buyrequest/viewtransportation
buyer	buyrequestinternational/*
buyer	buyrequest/viewdocuments
especialista_tecnico	validatedlist/*
especialista_logistica	certificationtype/*
especialista_logistica	certification/*
especialista_logistica	buycondition/*
especialista_logistica	destiny/*
especialista_logistica	finaldestiny/*
especialista_logistica	providerstatus/*
especialista_logistica	demandstatus/*
especialista_logistica	buyrequeststatus/*
especialista_logistica	documentstatus/*
especialista_logistica	stage/*
especialista_logistica	paymentinstrument/*
especialista_logistica	paymentmethod/*
especialista_logistica	purchasereason/*
especialista_logistica	organism/*
especialista_logistica	country/*
especialista_logistica	deploymentpart/*
especialista_logistica	sellerrequirement/*
especialista_logistica	warrantytime/*
especialista_logistica	documenttype/*
especialista_logistica	buyrequesttype/*
especialista_logistica	um/*
especialista_tecnico	validatedlistitem/*
\.


--
-- Data for Name: auth_rule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_rule (name, data, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: buy_condition; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.buy_condition (id, label, created_at, updated_at) FROM stdin;
1	EXW	2020-05-24 03:16:25.478465	2020-05-24 03:16:25.564974
2	FCA	2020-05-24 03:16:25.478465	2020-05-24 03:16:25.564974
3	FAS	2020-05-24 03:16:25.478465	2020-05-24 03:16:25.564974
4	FOB	2020-05-24 03:16:25.478465	2020-05-24 03:16:25.564974
5	CPT	2020-05-24 03:16:25.478465	2020-05-24 03:16:25.564974
6	CIP	2020-05-24 03:16:25.478465	2020-05-24 03:16:25.564974
7	CFR	2020-05-24 03:16:25.478465	2020-05-24 03:16:25.564974
8	CIF	2020-05-24 03:16:25.478465	2020-05-24 03:16:25.564974
9	DAT	2020-05-24 03:16:25.478465	2020-05-24 03:16:25.564974
10	DAP	2020-05-24 03:16:25.478465	2020-05-24 03:16:25.564974
11	DDP	2020-05-24 03:16:25.478465	2020-05-24 03:16:25.564974
\.


--
-- Data for Name: buy_request; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.buy_request (id, code, created, last_update, created_by, buy_request_status_id, buy_request_type_id, approved_date, approved_by, cancel_reason, buyer_assigned, buy_approved_by, buy_approved_date, dt_specialist_assigned, dt_approved_date, dt_approved_by, approve_start, closed_date, execution_start, created_at, updated_at) FROM stdin;
45	SN-2020-002-gav-01	2020-05-30	\N	23	6	3	2020-05-30	15	\N	28	\N	\N	21	2020-05-30	18	\N	\N	2020-05-30	2020-05-30 13:24:04	2020-05-30 22:43:38
46	SN-2020-002	2020-06-04	\N	23	7	2	2020-06-04	15	\N	19	17	2020-06-04	21	2020-06-04	18	2020-06-04	2020-06-04	2020-06-04	2020-06-04 11:15:21	2020-06-04 11:36:33
47	SN-2020-003-gae-01	2020-06-04	\N	23	7	3	2020-06-04	15	\N	28	17	2020-06-04	21	2020-06-04	18	\N	2020-06-04	2020-06-04	2020-06-04 11:50:48	2020-06-04 11:57:36
48	SI-2020-003	2020-06-03	\N	23	6	1	2020-06-03	15	\N	20	17	2020-06-03	21	2020-06-03	18	2020-06-04	\N	2020-06-04	2020-06-04 14:12:17	2020-06-04 14:53:30
49	SI-2020-004	2020-06-05	\N	23	6	1	2020-06-05	15	\N	20	17	2020-06-05	21	2020-06-05	18	2020-06-09	\N	2020-06-09	2020-06-09 15:52:58	2020-06-09 17:13:25
43	SN-2020-001	2020-05-16	\N	23	6	2	2020-05-16	15	\N	19	17	2020-05-16	21	2020-05-16	18	\N	\N	2020-05-16	2020-05-24 03:16:25.630892	2020-05-24 03:16:25.714197
44	SI-2020-002	2020-05-22	\N	23	6	1	2020-05-22	15	\N	20	17	2020-05-23	21	2020-05-23	18	2020-07-05	\N	2020-07-05	2020-05-24 03:16:25.630892	2020-07-05 22:46:43
42	SI-2020-001	2020-04-01	\N	23	7	1	2020-04-03	23	\N	20	17	2020-04-05	21	2020-04-04	18	2020-04-30	2020-05-22	2020-05-17	2020-05-24 03:16:25.630892	2020-05-24 03:16:25.714197
\.


--
-- Data for Name: buy_request_711; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.buy_request_711 (id, buy_request_id, final_destiny_id, plan, general_description, other_operation, deployment_place, seguiment_date, created_at, updated_at) FROM stdin;
14	45	1	2020	desc;asdlas;ld	150.00	Mantilla #20	\N	2020-05-30 13:24:54	2020-05-30 13:24:54
15	47	2	2020	asdasd	250.00	asdasd	\N	2020-06-04 11:51:25	2020-06-04 11:51:25
\.


--
-- Data for Name: buy_request_document; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.buy_request_document (id, buy_request_id, last_updated_by, created_date, last_update, url_to_file, custom_file, document_type_id, document_status_id, created_at, updated_at) FROM stdin;
234	42	20	\N	2020-05-16	/request_files/aIGUuKVa3daUeHMjZLLw4dZldLqJnGx7.pdf	\N	3	2	2020-05-24 03:16:26.029507	2020-05-24 03:16:26.088319
236	42	20	\N	2020-05-16	/request_files/DmCM2u48dnEoqHIOCbRY--KlqI-JNO53.pdf	\N	2	2	2020-05-24 03:16:26.029507	2020-05-24 03:16:26.088319
238	42	20	\N	2020-05-16	/request_files/bWpDMfqHuRKH77pi12MdilXZ3L90Vhc3.pdf	\N	1	2	2020-05-24 03:16:26.029507	2020-05-24 03:16:26.088319
230	42	24	2020-05-16	2020-05-16	/request_files/uj8LCmGDN6GXovcnDdwDtwNs8z0pspzm.pdf		9	2	2020-05-24 03:16:26.029507	2020-05-24 03:16:26.088319
229	42	24	2020-05-16	2020-05-16	/request_files/d4d_qzQKaVPB5I4I969Nj9mHD3JS1jws.pdf		10	2	2020-05-24 03:16:26.029507	2020-05-24 03:16:26.088319
233	42	24	2020-05-16	2020-05-16	/request_files/G7QDMDxAsNv4CE3rHKTiHYVVADdHENe0.pdf		5	2	2020-05-24 03:16:26.029507	2020-05-24 03:16:26.088319
232	42	24	2020-05-16	2020-05-16	/request_files/ZhX5nKmCS3tMRfrBz0m6jy2abMiKK9_F.pdf		6	2	2020-05-24 03:16:26.029507	2020-05-24 03:16:26.088319
239	42	24	2020-05-16	2020-05-16	/request_files/v8QjX2T84Co2N3nFkrQqU5MqCwlD-fHU.pdf		8	2	2020-05-24 03:16:26.029507	2020-05-24 03:16:26.088319
231	42	24	2020-05-16	2020-05-16	/request_files/3Q4rMhwvzGhvB_RRml8JVC9PBLpkrlpg.pdf		4	2	2020-05-24 03:16:26.029507	2020-05-24 03:16:26.088319
235	42	24	2020-05-16	2020-05-16	/request_files/Th9fxRF2ljeg65wGnwlUNdKYO7-dEUzM.pdf		11	2	2020-05-24 03:16:26.029507	2020-05-24 03:16:26.088319
237	42	24	2020-05-16	2020-05-16	/request_files/Reo9foQE72-97sCVdaRuwBOU6s2ZMlvB.pdf		7	2	2020-05-24 03:16:26.029507	2020-05-24 03:16:26.088319
240	43	19	\N	2020-05-16	/request_files/k7TsVaRj8yF1h9lWZ1FfJhPwoNfIi1NJ.pdf	\N	15	2	2020-05-24 03:16:26.029507	2020-05-24 03:16:26.088319
244	43	19	2020-05-16	2020-05-16	/request_files/2k3tAMuzAixzjhRQ_CiLRHoPClQRybzD.pdf		12	2	2020-05-24 03:16:26.029507	2020-05-24 03:16:26.088319
242	43	19	2020-05-16	2020-05-16	/request_files/ip495eVK_F87LMtH6q6s4sek3HsG5MwP.pdf		13	2	2020-05-24 03:16:26.029507	2020-05-24 03:16:26.088319
241	43	19	2020-05-16	2020-05-16	/request_files/AoAeJYOoRHn42V936rlYHjwacpL-g5F1.pdf		14	2	2020-05-24 03:16:26.029507	2020-05-24 03:16:26.088319
245	43	19	2020-05-16	2020-05-16	/request_files/dX93FjfUe9aukRUiSPE48UPBXhrCYv0V.pdf		16	2	2020-05-24 03:16:26.029507	2020-05-24 03:16:26.088319
243	43	19	2020-05-16	2020-05-16	/request_files/9Py3plDzlVlO0psHRQ608cgiKJ83ztQ8.pdf		17	2	2020-05-24 03:16:26.029507	2020-05-24 03:16:26.088319
246	45	28	2020-05-30	2020-05-30	/request_files/yUJjN0sEIReuI89vDoH-9ZZ2cjKE65Wm.pdf		18	2	2020-05-30 22:42:29	2020-05-30 22:43:32
247	46	19	\N	2020-06-04	/request_files/8274jNz4tEx2IyoTNSfSULJog-WO-BZI.pdf	\N	15	2	2020-06-04 11:32:18	2020-06-04 11:32:18
266	49	24	2020-06-09	2020-06-09	/request_files/bCmJmwFT4uobuG40XvD3bVkP3-B5ssAO.pdf		9	2	2020-06-09 17:05:42	2020-06-09 17:07:50
248	46	19	2020-06-04	2020-06-04	/request_files/cnWdD1ZSZmBAok-vQ0u6lTDkxcBJCf6O.pdf		12	2	2020-06-04 11:32:18	2020-06-04 11:34:43
249	46	19	2020-06-04	2020-06-04	/request_files/UKJJPKawH8sCEwxpLFR2Diwj0N8yi-lI.pdf		13	2	2020-06-04 11:32:18	2020-06-04 11:34:58
250	46	19	2020-06-04	2020-06-04	/request_files/XtkpZNWoTGW74q7nG6OmQBeZCFxuioHl.pdf		14	2	2020-06-04 11:32:18	2020-06-04 11:35:13
251	46	19	2020-06-04	2020-06-04	/request_files/W4yaaBmA9YAy1-mHRcJZaPluET3d2PkU.pdf		16	2	2020-06-04 11:32:18	2020-06-04 11:35:28
252	46	19	2020-06-04	2020-06-04	/request_files/TBeUaLBqV86DZuPS3nzDrCs_W3B6ZDUD.pdf		17	2	2020-06-04 11:32:18	2020-06-04 11:35:42
253	47	28	2020-06-04	2020-06-04	/request_files/NrasHSnxJzdNfpYghJa8p0FKYp4k_J1t.pdf		18	2	2020-06-04 11:55:37	2020-06-04 11:55:54
259	48	20	\N	2020-06-04	/request_files/JPGPm91nSI8V5VSEBMkRERk-XRBiXQ3j.docx	\N	3	2	2020-06-04 14:47:47	2020-06-04 14:47:47
261	48	20	\N	2020-06-04	/request_files/8PPZ3iXI_PT01l6MuEW5I86bSL8E_5do.docx	\N	2	2	2020-06-04 14:47:47	2020-06-04 14:47:47
263	48	20	\N	2020-06-04	/request_files/9rQxxcP1wKgZg-NBvyvruMyWphWB0CVI.docx	\N	1	2	2020-06-04 14:47:47	2020-06-04 14:47:47
255	48	24	2020-06-04	2020-06-04	/request_files/_9Bp_OlqU0YHdq2t8HMr6JHaqLT-nDAS.docx		9	2	2020-06-04 14:47:47	2020-06-04 14:50:02
254	48	24	2020-06-04	2020-06-04	/request_files/qe1ZVJ8Npkx9c61N6xFBA217c1rOOmvg.docx		10	2	2020-06-04 14:47:47	2020-06-04 14:50:19
258	48	24	2020-06-04	2020-06-04	/request_files/MwdtID81DR89MHffJN86LydSUTQ3OHZq.docx		5	2	2020-06-04 14:47:47	2020-06-04 14:50:36
257	48	24	2020-06-04	2020-06-04	/request_files/6nIaJIxBQhLvmaRQY98q7ZBOKYrwnWFe.docx		6	2	2020-06-04 14:47:47	2020-06-04 14:50:53
264	48	24	2020-06-04	2020-06-04	/request_files/Ujd4SH1UDCRyRiFn04OVH7XDU0vkKPCR.docx		8	2	2020-06-04 14:47:47	2020-06-04 14:51:16
256	48	24	2020-06-04	2020-06-04	/request_files/jaWSM7kbfGWtgAeC9ZBpBApOZBIGdNc1.docx		4	2	2020-06-04 14:47:47	2020-06-04 14:51:33
260	48	24	2020-06-04	2020-06-04	/request_files/nTx6tkGuLiJmLsbAtx1feR7Rph1iFE97.docx		11	2	2020-06-04 14:47:47	2020-06-04 14:51:49
262	48	24	2020-06-04	2020-06-04	/request_files/8JTgglCV69hHHtei3YxCdmbqePb-uJUv.docx		7	2	2020-06-04 14:47:47	2020-06-04 14:52:11
270	49	20	\N	2020-06-09	/request_files/LDFkwjt0O1fMC7uX9zI2mCWP3KLxmoFr.docx	\N	3	2	2020-06-09 17:05:42	2020-06-09 17:05:42
272	49	20	\N	2020-06-09	/request_files/W8N0DPu-9lSGzCK-AYujZMGYKJdQSXr-.docx	\N	2	2	2020-06-09 17:05:42	2020-06-09 17:05:42
274	49	20	\N	2020-06-09	/request_files/ElrbBK7FHN_VWCV_78VAfre4JIE1CPSv.docx	\N	1	2	2020-06-09 17:05:42	2020-06-09 17:05:42
265	49	24	2020-06-09	2020-06-09	/request_files/Z1RpvgCRTscee_KeeRKHMdc2UbhYl0Mx.pdf		10	2	2020-06-09 17:05:42	2020-06-09 17:08:05
269	49	24	2020-06-09	2020-06-09	/request_files/tsUf8l_FMoh2uT5tu5ZQemZl9rUJ-tQe.pdf		5	2	2020-06-09 17:05:42	2020-06-09 17:08:42
268	49	24	2020-06-09	2020-06-09	/request_files/WS-Jlf4N4wnejhylvqBbS-gvBA21glar.pdf		6	2	2020-06-09 17:05:42	2020-06-09 17:09:05
275	49	24	2020-06-09	2020-06-09	/request_files/C78QTTArATtofoTgwGY-dBYtlrR6kO6X.pdf		8	2	2020-06-09 17:05:42	2020-06-09 17:09:27
267	49	24	2020-06-09	2020-06-09	/request_files/z8r3UMCQTN6oUgkRq-9ne_GZRMYEvPdP.pdf		4	2	2020-06-09 17:05:42	2020-06-09 17:09:47
271	49	24	2020-06-09	2020-06-09	/request_files/yziAoz2salSmItx69OZcQkfG2gwXz4Hf.pdf		11	2	2020-06-09 17:05:42	2020-06-09 17:10:02
273	49	24	2020-06-09	2020-06-09	/request_files/FQpsNqdxlETZE_HvfropLqIcLzsJ6xMS.pdf		7	2	2020-06-09 17:05:42	2020-06-09 17:10:18
281	44	20	\N	2020-07-05	/request_files/YJtfuOpaDo6WzLGLJMzRJ1LX89JyrlHB.docx	\N	3	2	2020-07-05 22:25:27	2020-07-05 22:25:27
283	44	20	\N	2020-07-05	/request_files/E6d5k23R70QCeF7oh6MSGqjjpIyUTLZi.docx	\N	2	2	2020-07-05 22:25:27	2020-07-05 22:25:27
285	44	20	\N	2020-07-05	/request_files/a0vqolf9XaOumBJR9200_3MagqEMtBtR.docx	\N	1	2	2020-07-05 22:25:28	2020-07-05 22:25:28
277	44	24	2020-07-05	2020-07-05	/request_files/G6BgrSd2T_nP0RbINnxyOaQMqwSOl417.docx		9	2	2020-07-05 22:25:27	2020-07-05 22:26:40
276	44	24	2020-07-05	2020-07-05	/request_files/9adLP8iwddGMzl7ZwO3dCyllcsTZp_m9.docx		10	2	2020-07-05 22:25:27	2020-07-05 22:27:00
280	44	24	2020-07-05	2020-07-05	/request_files/Mloh_Qbt5zB-enXrL20Pbbf9ltfIs3QK.docx		5	2	2020-07-05 22:25:27	2020-07-05 22:27:24
279	44	24	2020-07-05	2020-07-05	/request_files/xBhpE0TMXlAqqf5Dk1HDUYW-RJ23xTFX.docx		6	2	2020-07-05 22:25:27	2020-07-05 22:27:44
286	44	24	2020-07-05	2020-07-05	/request_files/Urj_Z_miGlMFGtQjIRyKopmHdZjaijJP.docx		8	2	2020-07-05 22:25:28	2020-07-05 22:28:03
278	44	24	2020-07-05	2020-07-05	/request_files/v58YVOIJOomibRFuWpU7IGrlIEnx-2XZ.docx		4	2	2020-07-05 22:25:27	2020-07-05 22:28:21
282	44	24	2020-07-05	2020-07-05	/request_files/TTwBkiKKQLCASX1z4CkhCGxLO9gAUwXg.docx		11	2	2020-07-05 22:25:27	2020-07-05 22:28:42
284	44	24	2020-07-05	2020-07-05	/request_files/6FtoECwQwWGQxQR7vINyxAa0ZUB-9_sj.docx		7	2	2020-07-05 22:25:28	2020-07-05 22:29:03
\.


--
-- Data for Name: buy_request_international; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.buy_request_international (id, buy_request_id, bidding_start, bidding_end, destiny_id, payment_instrument_id, buy_condition_id, transport_days, build_days, bidding_ready_date, created_at, updated_at, credit_card_open) FROM stdin;
13	42	2020-04-13	2020-04-27	1	2	7	90	90	2020-05-16	2020-05-24 03:16:26.1349	2020-05-24 03:16:26.198869	\N
15	48	2020-06-02	2020-06-03	1	2	8	60	90	2020-06-04	2020-06-04 14:20:26	2020-06-04 14:53:30	\N
16	49	2020-06-05	2020-06-06	1	2	5	60	90	2020-06-09	2020-06-09 16:01:01	2020-06-09 17:13:25	\N
14	44	2020-05-22	2020-06-17	1	2	8	12	12	2020-05-23	2020-05-24 03:16:26.1349	2020-07-05 22:47:49	2020-07-06
\.


--
-- Data for Name: buy_request_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.buy_request_provider (id, buy_request_id, provider_id, provider_status_id, winner, created_at, updated_at) FROM stdin;
26	42	1	3	t	2020-05-24 03:16:26.255878	2020-05-24 03:16:26.302302
27	43	3	3	t	2020-05-24 03:16:26.255878	2020-05-24 03:16:26.302302
29	46	3	3	t	2020-06-04 11:29:09	2020-06-04 11:32:18
30	48	1	3	t	2020-06-04 14:39:14	2020-06-04 14:47:47
31	49	1	3	t	2020-06-09 16:38:56	2020-06-09 17:05:42
33	44	1	3	t	2020-07-05 21:48:45	2020-07-05 22:25:27
\.


--
-- Data for Name: buy_request_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.buy_request_status (id, label, created_at, updated_at) FROM stdin;
1	Borrador	2020-05-24 03:16:26.357542	2020-05-24 03:16:26.433637
2	Sin tramitar	2020-05-24 03:16:26.357542	2020-05-24 03:16:26.433637
3	Cancelada	2020-05-24 03:16:26.357542	2020-05-24 03:16:26.433637
5	Evaluando ofertas	2020-05-24 03:16:26.357542	2020-05-24 03:16:26.433637
7	Cerrada	2020-05-24 03:16:26.357542	2020-05-24 03:16:26.433637
4	En licitación	2020-05-24 03:16:26.357542	2020-05-24 03:16:26.433637
6	Ejecutando	2020-05-24 03:16:26.357542	2020-05-24 03:16:26.433637
\.


--
-- Data for Name: buy_request_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.buy_request_type (id, label, created_at, updated_at) FROM stdin;
1	Internacional	2020-05-24 03:16:26.488555	2020-05-24 03:16:26.616729
2	Nacional	2020-05-24 03:16:26.488555	2020-05-24 03:16:26.616729
3	711	2020-05-24 03:16:26.488555	2020-05-24 03:16:26.616729
\.


--
-- Data for Name: certification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.certification (id, label, certification_type_id, created_at, updated_at) FROM stdin;
1	UL	1	2020-05-24 03:16:26.671673	2020-05-24 03:16:26.724715
2	FM	1	2020-05-24 03:16:26.671673	2020-05-24 03:16:26.724715
3	CFE	1	2020-05-24 03:16:26.671673	2020-05-24 03:16:26.724715
\.


--
-- Data for Name: certification_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.certification_type (id, label, created_at, updated_at) FROM stdin;
1	Internacional	2020-05-24 03:16:26.780776	2020-05-24 03:16:26.835806
\.


--
-- Data for Name: certification_validated_list_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.certification_validated_list_item (id, certification_id, validated_list_item_id, created_at, updated_at) FROM stdin;
4	3	2693	2020-07-07 23:47:28	2020-07-07 23:47:28
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client (id, client_code, name, address, organism_id, province_ueb, created_at, updated_at) FROM stdin;
1	20401245	Hospital  Hermanos Almejeiras	Calle San Lázaro Esquina Belascoain	2	1	2020-05-24 03:16:26.991669	2020-05-24 03:16:27.052385
2	2121	GIGB Santiago	Santiago de Cuba	3	3	2020-05-24 03:16:26.991669	2020-05-24 03:16:27.052385
3	12145	Las terrazas	adasdas	4	2	2020-05-24 03:16:26.991669	2020-05-24 03:16:27.052385
4	INERNO	CASA MATRIZ	Dirección Seisa	5	4	2020-05-30 13:11:47	2020-05-30 13:11:47
\.


--
-- Data for Name: country; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.country (id, label, created_at, updated_at) FROM stdin;
1	Cuba	2020-05-24 03:16:27.112487	2020-05-24 03:16:27.165942
2	España	2020-05-24 03:16:27.112487	2020-05-24 03:16:27.165942
3	Argentina	2020-05-24 03:16:27.112487	2020-05-24 03:16:27.165942
\.


--
-- Data for Name: demand; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.demand (id, client_contract_number, client_id, payment_method_id, other_execution, deployment_part_id, other_deploy, waranty_time_id, warranty_specification, purchase_reason_id, require_replacement_part, replacement_part_details, require_post_warranty, post_warranty_details, require_technic_asistance, technic_asistance_details, created_date, sending_date, rejected_reason, observation, validated_list_id, seller_requirement_id, demand_status_id, created_by, seller_requirement_details, demand_code, approved_by, approved_date, created_at, updated_at) FROM stdin;
35	interno	4	2		1		1		1	f		f		f		2020-05-30	2020-05-30	\N		9	3	5	23	\N	D-2020-005	23	2020-05-30	2020-05-30 13:21:16	2020-05-30 13:24:04
36	01010	3	1		1		1		1	f		f		f		2020-06-04	2020-06-04	\N		2	1	5	25	\N	D-2020-006	\N	\N	2020-06-04 10:44:51	2020-06-04 11:15:28
37	1111	3	7		1		1		1	f		f		f		2020-06-04	2020-06-04	\N		14	3	5	25	\N	D-2020-007	23	2020-06-04	2020-06-04 10:55:58	2020-06-04 11:50:49
39	8585	3	1		1		1		1	f		f		f		2020-06-04	2020-06-04	\N		14	3	5	25	\N	D-2020-009	23	2020-06-04	2020-06-04 13:47:50	2020-06-04 14:12:17
38	2222	3	7		1		1		1	f		f		f		2020-06-04	2020-06-04	\N		14	3	3	25	\N	D-2020-008	\N	\N	2020-06-04 11:00:59	2020-06-04 14:14:04
30	1111	1	7		1		1		1	f		f		f		2020-05-16	2020-05-16	\N		14	3	5	14	\N	D-2020-001	23	2020-05-16	2020-05-24 03:16:27.221015	2020-05-24 03:16:27.321776
31	2121	3	7		1		1		1	f		f		f		2020-05-16	2020-05-16	\N		9	3	5	25	\N	D-2020-002	\N	\N	2020-05-24 03:16:27.221015	2020-05-24 03:16:27.321776
34	010101	1	7		1		1		1	t		f		f		2020-05-24	2020-06-09	\N		14	3	5	14	\N	D-2020-010	23	2020-06-09	2020-05-24 15:05:06	2020-06-09 15:52:59
32	11124	3	7		1		1		1	f		f		f		2020-05-22	2020-05-22	\N		14	1	5	25	\N	D-2020-003	23	2020-05-22	2020-05-24 03:16:27.221015	2020-05-24 03:16:27.321776
40	2121	1	7		1		1		1	f		f		f		2020-06-09	2020-06-10	\N		14	3	3	14	\N	D-2020-011	23	2020-06-10	2020-06-09 15:22:59	2020-06-10 17:46:43
33	1121	1	7		1		1		1	f		f		f		2020-05-24	2020-04-17	ete es un motivo muy importante		14	3	4	14	\N	D-2020-004	\N	\N	2020-05-24 10:05:15	2020-05-26 23:56:04
41	9989	3	7		1		1		1	f		f		f		2020-07-07	2020-07-08	\N		14	3	3	25	\N	D-2020-012	23	2020-07-08	2020-07-07 23:53:23	2020-07-08 00:10:49
42	test	1	1		1		1		1	f		f		f		2020-10-25	\N	\N		15	3	1	14	\N	\N	\N	\N	2020-10-25 22:39:30	2020-10-25 22:42:27
\.


--
-- Data for Name: demand_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.demand_item (id, demand_id, validated_list_item_id, price, quantity, buy_request_id, internal_distribution, cancelled, cancelled_msg, created_at, updated_at) FROM stdin;
118	35	1548	1.56200004	5	45	\N	f	\N	2020-05-30 13:22:43	2020-05-30 13:22:43
119	35	1705	7.3920002	3	45	\N	f	\N	2020-05-30 13:22:47	2020-05-30 13:22:47
120	35	1894	24.4529991	10	45	\N	f	\N	2020-05-30 13:22:52	2020-05-30 13:22:52
121	35	1723	8.35999966	20	45	\N	f	\N	2020-05-30 13:22:53	2020-05-30 13:22:53
122	35	1973	35.980999	4	45	\N	f	\N	2020-05-30 13:22:54	2020-05-30 13:22:54
123	35	1759	9.77900028	9	45	\N	f	\N	2020-05-30 13:22:55	2020-05-30 13:22:55
124	35	1649	4.26800013	5	45	\N	f	\N	2020-05-30 13:22:57	2020-05-30 13:22:57
100	30	1346	0	10	42	\N	f	\N	2020-05-24 03:16:27.359158	2020-05-24 03:16:27.412289
101	31	1648	4.26800013	20	43	\N	f	\N	2020-05-24 03:16:27.359158	2020-05-24 03:16:27.412289
102	32	1348	0	10	44	\N	f	\N	2020-05-24 03:16:27.359158	2020-05-24 03:16:27.412289
132	38	1929	30.5690002	3	\N	\N	f	\N	2020-06-04 11:01:06	2020-06-04 11:01:07
125	36	2200	72.3499985	2	46	\N	f	\N	2020-06-04 10:45:04	2020-06-04 10:45:04
126	36	2000	38.5999985	3	46	\N	f	\N	2020-06-04 10:45:06	2020-06-04 10:45:07
127	36	1988	37.0800018	1	46	\N	f	\N	2020-06-04 10:45:08	2020-06-04 10:45:08
128	37	1757	9.7130003	2	47	\N	f	\N	2020-06-04 10:56:04	2020-06-04 10:56:04
129	37	1889	23.5949993	2	47	\N	f	\N	2020-06-04 10:56:06	2020-06-04 10:56:07
130	37	1667	4.89499998	20	47	\N	f	\N	2020-06-04 10:56:13	2020-06-04 10:56:13
135	39	1719	8.09599972	1	\N	t	f	\N	2020-06-04 14:08:12	2020-06-04 14:08:12
133	39	1757	9.7130003	2	48	\N	f	\N	2020-06-04 13:48:46	2020-06-04 13:48:47
134	39	1719	8.09599972	1	48	\N	f	\N	2020-06-04 13:48:49	2020-06-04 14:08:12
131	38	1719	8.09599972	2	48	\N	f	\N	2020-06-04 11:01:04	2020-06-04 11:01:05
136	40	1620	2.92600012	10	\N	\N	f	\N	2020-06-09 15:26:49	2020-06-09 15:26:49
137	34	1608	2.59599996	2	\N	\N	t	no tienes dinero.	2020-06-09 15:46:34	2020-06-09 15:46:56
138	34	1608	2.59599996	1	49	\N	f	\N	2020-06-09 15:51:56	2020-06-09 15:51:56
116	34	1608	2.59599996	1	49	\N	f	\N	2020-05-24 15:36:53	2020-06-09 15:51:56
115	34	1889	23.5949993	2	49	\N	f	\N	2020-05-24 15:36:48	2020-05-24 15:36:49
117	34	2060	46.6949997	5	49	\N	f	\N	2020-05-24 15:37:00	2020-05-24 15:37:00
139	40	1719	8.09599972	4	\N	\N	f	\N	2020-06-10 17:00:23	2020-06-10 17:00:26
140	40	1929	30.5690002	3	\N	\N	f	\N	2020-06-10 17:00:29	2020-06-10 17:00:29
141	40	2060	46.6949997	3	\N	\N	f	\N	2020-06-10 17:02:26	2020-06-10 17:02:28
142	41	1719	8.09599972	2	\N	\N	f	\N	2020-07-08 00:09:21	2020-07-08 00:09:22
143	41	1929	30.5690002	10	\N	\N	f	\N	2020-07-08 00:09:26	2020-07-08 00:09:26
144	41	1985	36.6739998	5	\N	\N	f	\N	2020-07-08 00:09:27	2020-07-08 00:09:27
145	41	2113	54.0209999	20	\N	\N	f	\N	2020-07-08 00:09:29	2020-07-08 00:09:29
108	33	2113	54.0209999	3	\N	\N	f	\N	2020-05-24 12:38:41	2020-05-24 12:38:41
109	33	1985	36.6739998	10	\N	\N	f	\N	2020-05-24 13:27:35	2020-05-24 13:27:35
107	33	1929	30.5690002	5	\N	\N	f	\N	2020-05-24 12:38:38	2020-05-24 13:45:18
112	33	1608	2.59599996	5	\N	\N	f	\N	2020-05-24 13:49:10	2020-05-24 13:49:36
114	33	1665	4.80700016	2	\N	\N	f	\N	2020-05-24 13:52:33	2020-05-24 13:52:33
\.


--
-- Data for Name: demand_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.demand_status (id, label, color, created_at, updated_at) FROM stdin;
6	Cerrada	#999999	2020-05-24 03:16:27.468347	2020-05-24 03:16:27.525186
1	Borrador	#cecece	2020-05-24 03:16:27.468347	2020-05-24 03:16:27.525186
4	Rechazada	#dc3545	2020-05-24 03:16:27.468347	2020-05-24 03:16:27.525186
2	Nueva	#007bff	2020-05-24 03:16:27.468347	2020-05-24 03:16:27.525186
3	Recibida	#4caf50	2020-05-24 03:16:27.468347	2020-07-05 15:06:35
5	Aceptada	#00bcd4	2020-05-24 03:16:27.468347	2020-07-05 15:06:46
\.


--
-- Data for Name: deployment_part; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.deployment_part (id, label, created_at, updated_at) FROM stdin;
1	1 Plazo	2020-05-24 03:16:27.580332	2020-05-24 03:16:27.639779
2	2 Plazos	2020-05-24 03:16:27.580332	2020-05-24 03:16:27.639779
3	3 Plazos	2020-05-24 03:16:27.580332	2020-05-24 03:16:27.639779
4	4 Plazos	2020-05-24 03:16:27.580332	2020-05-24 03:16:27.639779
5	Otros	2020-05-24 03:16:27.580332	2020-05-24 03:16:27.639779
\.


--
-- Data for Name: destiny; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.destiny (id, label, created_at, updated_at) FROM stdin;
1	Habana/Mariel	2020-05-24 03:16:27.695431	2020-05-24 03:16:27.752198
2	Santiago de Cuba	2020-05-24 03:16:27.695431	2020-05-24 03:16:27.752198
\.


--
-- Data for Name: document_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.document_status (id, label, created_at, updated_at) FROM stdin;
1	Pendiente	2020-05-24 03:16:27.804559	2020-05-24 03:16:27.854347
2	Aprobado	2020-05-24 03:16:27.804559	2020-05-24 03:16:27.854347
3	Rechazado	2020-05-24 03:16:27.804559	2020-05-24 03:16:27.854347
\.


--
-- Data for Name: document_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.document_type (id, label, required, active, responsable, buy_request_type_id, order_doc, created_at, updated_at) FROM stdin;
10	Apertura de carta de crédito	t	t	Comprador	1	5	2020-05-24 03:16:28.002041	2020-05-24 03:16:28.046142
9	Contrato	t	t	Comité de contratación	1	4	2020-05-24 03:16:28.002041	2020-05-24 03:16:28.046142
18	Cronograma de suministro del pedido GAE/TECNOTEX	t	t	Comprador 	3	1	2020-05-24 03:16:28.002041	2020-05-24 03:16:28.046142
4	Solicitud de importación eventual	f	t	Compras	1	9	2020-05-24 03:16:28.002041	2020-05-24 03:16:28.046142
6	Dictamen logístico	t	t	Logística	1	7	2020-05-24 03:16:28.002041	2020-05-24 03:16:28.046142
5	Dictamen legal	t	t	Abogado	1	6	2020-05-24 03:16:28.002041	2020-05-24 03:16:28.046142
3	Fundamentación de la compra	t	t	Compras	1	2	2020-05-24 03:16:28.002041	2020-05-24 03:16:28.046142
11	Directiva de negocio	t	t	Compras	1	10	2020-05-24 03:16:28.002041	2020-05-24 03:16:28.046142
2	Preforma de contrato	t	t	Compras	1	1	2020-05-24 03:16:28.002041	2020-05-24 03:16:28.046142
7	Dictamen comercial	f	t	Comercial	1	11	2020-05-24 03:16:28.002041	2020-05-24 03:16:28.046142
1	Pliego de concurrencias	t	t	Compras	1	3	2020-05-24 03:16:28.002041	2020-05-24 03:16:28.046142
8	Dictamen Financiero	t	t	Economía	1	8	2020-05-24 03:16:28.002041	2020-05-24 03:16:28.046142
15	Preforma de contrato	t	t	Comprador	2	1	2020-05-24 03:16:28.002041	2020-05-24 03:16:28.046142
12	Dictamen Legal	t	t	SEISA	2	2	2020-05-24 03:16:28.002041	2020-05-24 03:16:28.046142
13	Preforma de contrato	t	t	Comprador	2	3	2020-05-24 03:16:28.002041	2020-05-24 03:16:28.046142
14	Dictamen comercial	t	t	COmercial	2	4	2020-05-24 03:16:28.002041	2020-05-24 03:16:28.046142
16	Contrato	f	t	Comité de contratación	2	5	2020-05-24 03:16:28.002041	2020-05-24 03:16:28.046142
17	Fundamentación de la compra	f	t	Comprador	2	6	2020-05-24 03:16:28.002041	2020-05-24 03:16:28.046142
\.


--
-- Data for Name: document_type_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.document_type_permission (id, document_type_id, allow_view, allow_update, user_id, created_at, updated_at) FROM stdin;
13	10	t	f	20	2020-05-24 03:16:28.096836	2020-05-24 03:16:28.149421
15	7	t	f	20	2020-05-24 03:16:28.096836	2020-05-24 03:16:28.149421
16	8	t	f	20	2020-05-24 03:16:28.096836	2020-05-24 03:16:28.149421
17	5	t	f	20	2020-05-24 03:16:28.096836	2020-05-24 03:16:28.149421
18	6	t	f	20	2020-05-24 03:16:28.096836	2020-05-24 03:16:28.149421
21	2	t	t	20	2020-05-24 03:16:28.096836	2020-05-24 03:16:28.149421
20	1	t	t	20	2020-05-24 03:16:28.096836	2020-05-24 03:16:28.149421
19	3	t	t	20	2020-05-24 03:16:28.096836	2020-05-24 03:16:28.149421
14	9	t	f	20	2020-05-24 03:16:28.096836	2020-05-24 03:16:28.149421
27	10	t	t	24	2020-05-24 03:16:28.096836	2020-05-24 03:16:28.149421
28	9	t	t	24	2020-05-24 03:16:28.096836	2020-05-24 03:16:28.149421
29	7	t	t	24	2020-05-24 03:16:28.096836	2020-05-24 03:16:28.149421
30	8	t	t	24	2020-05-24 03:16:28.096836	2020-05-24 03:16:28.149421
31	5	t	t	24	2020-05-24 03:16:28.096836	2020-05-24 03:16:28.149421
32	6	t	t	24	2020-05-24 03:16:28.096836	2020-05-24 03:16:28.149421
33	11	t	t	24	2020-05-24 03:16:28.096836	2020-05-24 03:16:28.149421
34	3	t	t	24	2020-05-24 03:16:28.096836	2020-05-24 03:16:28.149421
35	1	t	t	24	2020-05-24 03:16:28.096836	2020-05-24 03:16:28.149421
36	2	t	t	24	2020-05-24 03:16:28.096836	2020-05-24 03:16:28.149421
37	4	t	t	24	2020-05-24 03:16:28.096836	2020-05-24 03:16:28.149421
38	11	t	t	20	2020-05-24 03:16:28.096836	2020-05-24 03:16:28.149421
39	4	t	t	20	2020-05-24 03:16:28.096836	2020-05-24 03:16:28.149421
40	14	t	t	19	2020-05-24 03:16:28.096836	2020-05-24 03:16:28.149421
41	12	t	t	19	2020-05-24 03:16:28.096836	2020-05-24 03:16:28.149421
42	15	t	t	19	2020-05-24 03:16:28.096836	2020-05-24 03:16:28.149421
43	13	t	t	19	2020-05-24 03:16:28.096836	2020-05-24 03:16:28.149421
44	16	t	t	19	2020-05-24 03:16:28.096836	2020-05-24 03:16:28.149421
45	17	t	t	19	2020-05-24 03:16:28.096836	2020-05-24 03:16:28.149421
77	18	t	t	19	2020-05-24 03:16:28.096836	2020-05-24 03:16:28.149421
78	18	t	t	28	2020-05-30 22:43:10	2020-05-30 22:43:10
\.


--
-- Data for Name: email_notify; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.email_notify (id, bidding_start, bidding_end, sended_date, body, attachment, buy_request_id, created_at, updated_at) FROM stdin;
11	2020-05-01	2020-05-16	2020-05-16	Inicio el proceso de licitación	SI-2020-001.zip	42	2020-05-24 03:16:28.201343	2020-05-24 03:16:28.254246
12	2020-05-01	2020-05-16	2020-05-16	Inicio el proceso de licitación	SI-2020-001.zip	42	2020-05-24 03:16:28.201343	2020-05-24 03:16:28.254246
13	2020-05-23	2020-05-23	2020-05-23	este es el cuerpo del mensaje	SI-2020-002.zip	44	2020-05-24 03:16:28.201343	2020-05-24 03:16:28.254246
14	2020-06-04	2020-06-18	2020-06-04	ljdalsdjs	SI-2020-003.zip	48	2020-06-04 14:39:18	2020-06-04 14:39:18
15	2020-06-08	2020-06-23	2020-06-09	dfgdfgdfgdfgdgf	SI-2020-004.zip	49	2020-06-09 16:39:01	2020-06-09 16:39:01
16	2020-05-22	2020-07-31	2020-07-05	dsfs	SI-2020-002.zip	44	2020-07-05 21:10:34	2020-07-05 21:10:34
17	2020-05-22	2020-07-31	2020-07-05	dsfs	SI-2020-002.zip	44	2020-07-05 21:23:35	2020-07-05 21:23:35
18	2020-05-22	2020-07-23	2020-07-05	asdsda	SI-2020-002.zip	44	2020-07-05 21:46:45	2020-07-05 21:46:45
19	2020-05-22	2020-07-23	2020-07-05	dsf	SI-2020-002.zip	44	2020-07-05 21:48:54	2020-07-05 21:48:54
20	2020-05-22	2020-07-24	2020-07-05	sdad	SI-2020-002.zip	44	2020-07-05 21:51:01	2020-07-05 21:51:01
21	2020-05-22	2020-07-05	2020-07-05	gdf	SI-2020-002.zip	44	2020-07-05 21:54:54	2020-07-05 21:54:54
22	2020-05-22	2020-07-05	2020-07-05	asdasd	SI-2020-002.zip	44	2020-07-05 21:55:48	2020-07-05 21:55:48
\.


--
-- Data for Name: final_destiny; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.final_destiny (id, label, code, created_at, updated_at) FROM stdin;
1	Gaviota (Soporte técnico)	gav	2020-05-24 03:16:28.311957	2020-05-24 03:16:28.372022
2	GAE	gae	2020-05-24 03:16:28.311957	2020-05-24 03:16:28.372022
\.


--
-- Data for Name: log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.log (id, user_id, action_moment, ip, action, description, created_at, updated_at) FROM stdin;
186	2	2020-02-22 11:06:08	192.168.0.4	Agregar Usuario	Fue añadido el usuario ueb al sistema.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
187	2	2020-02-22 11:06:22	192.168.0.4	Rol eilminado	El Rol comprador_internacional ha sido eliminado	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
188	2	2020-02-22 11:06:27	192.168.0.4	Rol eilminado	El Rol comprador_nacional ha sido eliminado	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
189	2	2020-02-22 11:06:31	192.168.0.4	Rol eilminado	El Rol jcompradores ha sido eliminado	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
190	2	2020-02-22 11:06:35	192.168.0.4	Rol eilminado	El Rol jefe_tecnico ha sido eliminado	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
191	2	2020-02-22 11:06:38	192.168.0.4	Rol eilminado	El Rol jefe_gol ha sido eliminado	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
192	2	2020-02-22 11:06:42	192.168.0.4	Rol eilminado	El Rol esp_tecnico ha sido eliminado	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
193	2	2020-02-22 11:08:23	192.168.0.4	Rol creado	El Rol Jefe_logistica ha sido creado.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
194	2	2020-02-22 11:09:05	192.168.0.4	Rol creado	El Rol esp_gol ha sido creado.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
195	2	2020-02-22 11:09:48	192.168.0.4	Rol creado	El Rol jefe_compras ha sido creado.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
196	2	2020-02-22 11:10:15	192.168.0.4	Rol creado	El Rol ep_dt ha sido creado.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
197	2	2020-02-22 11:10:55	192.168.0.4	Rol creado	El Rol comprador_nacional ha sido creado.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
198	2	2020-02-22 11:11:26	192.168.0.4	Rol creado	El Rol comprador_internacional ha sido creado.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
199	2	2020-02-22 11:12:09	192.168.0.4	Rol creado	El Rol especialista_tecnico ha sido creado.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
200	2	2020-02-22 11:12:32	192.168.0.4	Rol creado	El Rol comite ha sido creado.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
201	2	2020-02-22 11:13:29	192.168.0.4	Agregar Usuario	Fue añadido el usuario jlogistica al sistema.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
202	2	2020-02-22 11:14:16	192.168.0.4	Agregar Usuario	Fue añadido el usuario gol al sistema.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
203	2	2020-02-22 11:15:34	192.168.0.4	Agregar Usuario	Fue añadido el usuario jcompras al sistema.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
204	2	2020-02-22 11:16:40	192.168.0.4	Agregar Usuario	Fue añadido el usuario jtecnico al sistema.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
205	2	2020-02-22 11:17:54	192.168.0.4	Agregar Usuario	Fue añadido el usuario cnacional al sistema.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
206	2	2020-02-22 11:18:40	192.168.0.4	Agregar Usuario	Fue añadido el usuario cinternacional al sistema.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
207	2	2020-02-22 11:19:36	192.168.0.4	Agregar Usuario	Fue añadido el usuario tecnico al sistema.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
208	2	2020-02-22 11:20:26	192.168.0.4	Agregar Usuario	Fue añadido el usuario comite al sistema.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
209	2	2020-02-22 11:21:14	192.168.0.4	Usuario sale del sistema	El usuario  admin ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
210	14	2020-02-22 11:21:22	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario ueb	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
211	14	2020-02-22 11:22:05	192.168.0.4	Demanda creada	Se ha creado una demanda con ID6	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
212	14	2020-02-22 11:53:49	192.168.0.4	Demanda enviada	Se ha enviado la demanda DN-2020-00001	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
213	14	2020-02-22 11:57:45	192.168.0.4	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
214	15	2020-02-22 11:57:54	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
215	15	2020-02-22 13:00:31	192.168.0.4	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
216	14	2020-02-22 13:00:37	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario ueb	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
217	14	2020-02-22 13:01:23	192.168.0.4	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
218	15	2020-02-22 13:01:49	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
219	15	2020-02-22 13:02:04	192.168.0.4	Demanda rechazada	La Demanda 6 ha sido rechazada	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
220	15	2020-02-22 13:02:12	192.168.0.4	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
221	14	2020-02-22 13:02:22	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario ueb	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
222	14	2020-02-22 13:02:57	192.168.0.4	Demanda enviada	Se ha enviado la demanda DN-2020-00001	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
223	14	2020-02-22 13:03:08	192.168.0.4	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
224	15	2020-02-22 13:03:18	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
225	15	2020-02-22 13:03:29	192.168.0.4	Demanda aceptada	La Demanda DN-2020-00001 ha sido aceptada	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
226	15	2020-02-22 13:55:27	192.168.0.4	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
227	17	2020-02-22 13:55:35	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
228	17	2020-02-23 19:22:54	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
229	16	2020-02-23 19:23:03	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario gol	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
230	16	2020-02-23 19:35:01	192.168.0.4	Usuario sale del sistema	El usuario  gol ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
231	15	2020-02-23 19:35:08	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
232	15	2020-02-23 19:35:27	192.168.0.4	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
233	16	2020-02-23 19:35:40	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario gol	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
234	16	2020-02-23 19:36:37	192.168.0.4	Usuario sale del sistema	El usuario  gol ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
235	17	2020-02-23 19:36:58	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
236	17	2020-02-23 19:37:08	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
237	16	2020-02-23 19:37:18	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario gol	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
238	16	2020-02-23 19:37:45	192.168.0.4	Usuario sale del sistema	El usuario  gol ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
239	16	2020-02-23 19:37:50	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario gol	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
240	16	2020-02-23 19:37:54	192.168.0.4	Usuario sale del sistema	El usuario  gol ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
241	17	2020-02-23 19:38:03	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
242	17	2020-02-23 19:44:56	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
243	18	2020-02-23 19:45:10	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
244	18	2020-02-23 19:46:27	192.168.0.4	Usuario sale del sistema	El usuario  jtecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
245	21	2020-02-23 19:46:45	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario tecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
246	21	2020-02-23 19:51:08	192.168.0.4	Usuario sale del sistema	El usuario  tecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
247	18	2020-02-23 19:51:24	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
248	18	2020-02-23 19:51:47	192.168.0.4	Usuario sale del sistema	El usuario  jtecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
249	21	2020-02-23 19:52:01	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario tecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
250	21	2020-02-23 19:58:20	192.168.0.4	Usuario sale del sistema	El usuario  tecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
251	20	2020-02-23 19:58:53	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
252	20	2020-02-23 20:02:25	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
253	17	2020-02-23 20:02:47	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
254	17	2020-02-23 23:03:01	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
255	20	2020-02-24 00:08:54	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
256	20	2020-02-24 18:29:47	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
257	14	2020-02-24 18:29:55	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario ueb	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
258	14	2020-02-24 18:38:45	192.168.0.4	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
259	20	2020-02-24 18:38:55	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
260	20	2020-02-24 18:55:49	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
261	14	2020-02-24 18:57:23	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario ueb	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
262	14	2020-02-24 19:07:32	192.168.0.4	Demanda creada	Se ha creado una demanda con ID7	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
263	14	2020-02-24 19:12:53	192.168.0.4	Demanda enviada	Se ha enviado la demanda DN-2020-00002	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
264	14	2020-02-24 19:13:55	192.168.0.4	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
265	15	2020-02-24 19:14:25	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
266	15	2020-02-24 19:16:46	192.168.0.4	Demanda aceptada	La Demanda DN-2020-00002 ha sido aceptada	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
267	15	2020-02-24 19:36:54	192.168.0.4	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
268	16	2020-02-24 19:37:13	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario gol	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
269	16	2020-02-24 20:00:46	192.168.0.4	Usuario sale del sistema	El usuario  gol ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
270	17	2020-02-24 20:01:04	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
271	17	2020-02-24 20:08:19	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
272	18	2020-02-24 20:08:27	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
273	18	2020-02-24 20:09:05	192.168.0.4	Usuario sale del sistema	El usuario  jtecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
274	20	2020-02-24 20:09:13	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
275	20	2020-02-27 02:27:16	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
276	14	2020-02-27 02:27:26	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario ueb	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
277	14	2020-02-27 02:41:52	192.168.0.4	Demanda creada	Se ha creado una demanda con ID8	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
278	14	2020-02-27 02:42:09	192.168.0.4	Demanda enviada	Se ha enviado la demanda D-2020-001	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
279	14	2020-02-27 02:42:27	192.168.0.4	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
280	15	2020-02-27 02:42:37	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
281	15	2020-02-27 02:43:45	192.168.0.4	Demanda aceptada	La Demanda D-2020-001 ha sido aceptada	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
282	20	2020-02-29 16:43:42	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
283	20	2020-02-29 16:44:07	192.168.43.254	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
284	17	2020-02-29 16:44:17	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
285	15	2020-02-29 16:46:34	192.168.43.254	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
286	20	2020-02-29 16:46:45	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
287	20	2020-02-29 16:47:00	192.168.43.254	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
288	17	2020-02-29 16:47:12	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
289	17	2020-02-29 16:50:06	192.168.43.254	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
290	20	2020-02-29 16:50:13	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
291	20	2020-03-02 01:05:17	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
292	18	2020-03-02 01:05:31	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
293	18	2020-03-02 01:06:02	192.168.0.4	Usuario sale del sistema	El usuario  jtecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
294	18	2020-03-02 01:06:07	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
295	18	2020-03-02 01:08:40	192.168.0.4	Usuario sale del sistema	El usuario  jtecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
296	21	2020-03-02 01:09:30	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario tecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
297	21	2020-03-02 03:21:14	192.168.0.4	Usuario sale del sistema	El usuario  tecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
298	20	2020-03-02 03:21:23	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
299	20	2020-03-02 04:19:16	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
300	2	2020-03-02 04:19:25	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario admin	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
301	2	2020-03-02 06:56:36	192.168.0.4	Usuario sale del sistema	El usuario  admin ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
302	20	2020-03-02 06:56:42	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
303	20	2020-03-02 16:35:37	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
306	14	2020-03-02 17:48:08	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario ueb	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
307	14	2020-03-02 17:48:49	192.168.0.4	Demanda creada	Se ha creado una demanda con ID9	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
308	14	2020-03-02 17:49:15	192.168.0.4	Demanda enviada	Se ha enviado la demanda D-2020-002	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
309	14	2020-03-02 17:49:23	192.168.0.4	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
310	15	2020-03-02 17:49:31	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
311	15	2020-03-02 17:49:44	192.168.0.4	Demanda aceptada	La Demanda D-2020-002 ha sido aceptada	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
312	15	2020-03-02 18:01:55	192.168.0.4	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
313	20	2020-03-02 18:02:04	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
314	20	2020-03-02 18:02:18	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
315	17	2020-03-02 18:02:26	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
316	17	2020-03-02 18:03:14	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
317	17	2020-03-02 18:03:23	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
318	17	2020-03-02 18:03:43	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
319	15	2020-03-02 18:03:50	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
320	15	2020-03-02 18:07:06	192.168.0.4	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
321	17	2020-03-02 18:07:14	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
322	17	2020-03-02 18:07:31	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
323	15	2020-03-02 18:07:39	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
324	15	2020-03-02 18:10:38	192.168.0.4	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
325	17	2020-03-02 18:10:47	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
326	17	2020-03-02 18:11:13	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
327	18	2020-03-02 18:11:24	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
328	18	2020-03-02 18:12:01	192.168.0.4	Usuario sale del sistema	El usuario  jtecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
329	20	2020-03-02 18:12:11	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
330	20	2020-03-02 18:16:11	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
331	21	2020-03-02 18:16:24	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario tecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
332	21	2020-03-02 18:17:38	192.168.0.4	Usuario sale del sistema	El usuario  tecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
333	20	2020-03-02 18:18:40	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
334	20	2020-03-02 20:22:07	192.168.43.254	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
335	14	2020-03-02 20:25:28	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario ueb	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
336	14	2020-03-02 20:54:18	192.168.43.254	Demanda creada	Se ha creado una demanda con ID10	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
337	14	2020-03-02 20:55:19	192.168.43.254	Demanda enviada	Se ha enviado la demanda D-2020-003	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
338	14	2020-03-02 20:55:26	192.168.43.254	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
339	15	2020-03-02 20:55:44	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
340	15	2020-03-02 20:56:55	192.168.43.254	Demanda aceptada	La Demanda D-2020-003 ha sido aceptada	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
341	15	2020-03-02 20:59:57	192.168.43.254	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
342	17	2020-03-02 21:00:09	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
343	17	2020-03-02 21:01:38	192.168.43.254	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
344	18	2020-03-02 21:01:50	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
345	18	2020-03-02 21:03:00	192.168.43.254	Usuario sale del sistema	El usuario  jtecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
346	18	2020-03-02 21:15:48	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
347	18	2020-03-02 21:16:43	192.168.43.254	Usuario sale del sistema	El usuario  jtecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
348	20	2020-03-02 21:16:58	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
349	2	2020-03-02 21:18:28	192.168.43.254	Usuario sale del sistema	El usuario  admin ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
350	17	2020-03-02 21:18:42	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
351	17	2020-03-02 21:25:20	192.168.43.254	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
352	2	2020-03-02 21:25:30	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario admin	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
353	20	2020-03-02 21:38:48	192.168.43.254	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
354	21	2020-03-02 21:39:01	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario tecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
355	21	2020-03-02 21:40:26	192.168.43.254	Usuario sale del sistema	El usuario  tecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
356	20	2020-03-02 21:42:06	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
357	20	2020-03-02 21:49:24	192.168.43.254	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
361	20	2020-03-02 21:52:24	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
362	2	2020-03-04 04:55:17	192.168.0.4	Usuario sale del sistema	El usuario  admin ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
363	14	2020-03-04 04:55:27	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario ueb	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
364	14	2020-03-04 04:56:03	192.168.0.4	Demanda creada	Se ha creado una demanda con ID11	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
365	14	2020-03-04 04:58:43	192.168.0.4	Demanda enviada	Se ha enviado la demanda D-2020-001	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
366	14	2020-03-04 04:58:50	192.168.0.4	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
367	14	2020-03-04 04:58:56	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario ueb	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
368	14	2020-03-04 05:10:02	192.168.0.4	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
369	17	2020-03-04 05:10:53	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
370	17	2020-03-04 05:18:18	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
371	15	2020-03-04 05:18:31	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
372	15	2020-03-04 05:18:53	192.168.0.4	Demanda aceptada	La Demanda D-2020-001 ha sido aceptada	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
373	15	2020-03-04 05:23:58	192.168.0.4	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
374	17	2020-03-04 05:24:06	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
375	17	2020-03-04 05:28:56	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
376	18	2020-03-04 05:29:05	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
377	18	2020-03-04 05:29:29	192.168.0.4	Usuario sale del sistema	El usuario  jtecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
378	20	2020-03-04 05:29:41	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
379	20	2020-03-04 05:36:59	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
380	21	2020-03-04 05:37:13	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario tecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
381	21	2020-03-04 05:38:20	192.168.0.4	Usuario sale del sistema	El usuario  tecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
382	20	2020-03-04 05:38:30	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
383	14	2020-03-04 05:41:49	192.168.0.4	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
384	2	2020-03-04 05:42:14	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario admin	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
385	20	2020-03-04 05:46:31	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
386	14	2020-03-04 05:51:14	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario ueb	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
387	14	2020-03-04 05:51:23	192.168.43.254	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
388	14	2020-03-04 06:02:50	192.168.43.157	Usuario autenticado	Se ha autenticado el usuario ueb	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
389	14	2020-03-04 06:08:41	192.168.43.157	Demanda creada	Se ha creado una demanda con ID12	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
390	14	2020-03-04 06:11:49	192.168.43.157	Demanda enviada	Se ha enviado la demanda D-2020-002	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
391	14	2020-03-04 06:12:43	192.168.43.157	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
392	15	2020-03-04 06:13:10	192.168.43.157	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
393	15	2020-03-04 06:18:37	192.168.43.157	Demanda aceptada	La Demanda D-2020-002 ha sido aceptada	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
394	15	2020-03-04 06:22:21	192.168.43.157	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
395	18	2020-03-04 06:23:11	192.168.43.157	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
396	18	2020-03-04 06:29:22	192.168.43.157	Usuario sale del sistema	El usuario  jtecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
397	17	2020-03-04 06:34:19	192.168.43.157	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
398	17	2020-03-04 06:35:31	192.168.43.157	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
399	20	2020-03-04 06:36:07	192.168.43.157	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
400	20	2020-03-04 06:58:43	192.168.43.157	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
401	17	2020-03-04 06:58:59	192.168.43.157	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
402	17	2020-03-04 07:02:03	192.168.43.157	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
403	20	2020-03-04 07:02:34	192.168.43.157	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
404	20	2020-03-04 07:15:53	192.168.43.157	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
405	21	2020-03-04 07:16:39	192.168.43.157	Usuario autenticado	Se ha autenticado el usuario tecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
406	21	2020-03-04 07:28:06	192.168.43.157	Usuario sale del sistema	El usuario  tecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
407	19	2020-03-04 07:28:19	192.168.43.157	Usuario autenticado	Se ha autenticado el usuario cnacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
408	19	2020-03-04 07:28:24	192.168.43.157	Usuario sale del sistema	El usuario  cnacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
409	20	2020-03-04 07:28:39	192.168.43.157	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
410	20	2020-03-04 07:29:56	192.168.43.157	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
411	21	2020-03-04 07:30:08	192.168.43.157	Usuario autenticado	Se ha autenticado el usuario tecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
412	21	2020-03-04 07:32:33	192.168.43.157	Usuario sale del sistema	El usuario  tecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
413	20	2020-03-04 07:32:47	192.168.43.157	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
414	20	2020-03-04 07:50:54	192.168.43.157	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
417	20	2020-03-04 07:53:04	192.168.43.157	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
418	20	2020-03-04 08:07:47	192.168.43.157	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
419	2	2020-03-04 08:08:40	192.168.43.157	Usuario autenticado	Se ha autenticado el usuario admin	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
420	2	2020-03-04 08:10:59	192.168.43.157	Usuario sale del sistema	El usuario  admin ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
421	20	2020-03-04 08:14:09	192.168.43.157	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
422	20	2020-03-04 08:23:05	192.168.43.157	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
423	2	2020-03-05 01:07:06	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario admin	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
424	2	2020-03-05 01:47:14	192.168.0.4	Usuario sale del sistema	El usuario  admin ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
425	15	2020-03-05 01:47:24	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
426	15	2020-03-05 15:50:22	192.168.0.4	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
427	17	2020-03-05 15:50:28	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
428	17	2020-03-05 19:04:27	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
429	14	2020-03-05 19:04:40	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario ueb	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
430	14	2020-03-05 19:05:15	192.168.0.4	Demanda creada	Se ha creado una demanda con ID13	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
431	14	2020-03-05 19:06:12	192.168.0.4	Demanda enviada	Se ha enviado la demanda D-2020-001	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
432	14	2020-03-05 19:06:21	192.168.0.4	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
433	2	2020-03-05 19:07:37	192.168.0.4	Rol creado	El Rol esp_logistica ha sido creado.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
434	2	2020-03-05 19:12:15	192.168.0.4	Agregar Usuario	Fue añadido el usuario logistica al sistema.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
435	23	2020-03-05 19:12:31	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario logistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
436	2	2020-03-05 19:14:49	192.168.0.4	Usuario desactivado	El usuario gol fue desactivado.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
437	2	2020-03-05 19:17:26	192.168.0.4	Rol creado	El Rol tec_logistica ha sido creado.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
438	2	2020-03-05 19:22:51	192.168.0.4	Rol eilminado	El Rol comite ha sido eliminado	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
439	2	2020-03-05 19:23:16	192.168.0.4	Rol eilminado	El Rol esp_logistica ha sido eliminado	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
440	2	2020-03-05 19:23:41	192.168.0.4	Rol creado	El Rol especialista_logistica ha sido creado.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
441	2	2020-03-05 19:24:35	192.168.0.4	Actualizar Usuario	Actualizados los datos de logistica.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
442	23	2020-03-05 19:31:17	192.168.0.4	Demanda aceptada	La Demanda D-2020-001 ha sido aceptada	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
443	23	2020-03-05 20:51:04	192.168.0.4	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
444	15	2020-03-05 20:51:18	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
445	15	2020-03-05 21:32:32	192.168.0.4	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
446	18	2020-03-05 21:32:49	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
447	18	2020-03-05 22:05:04	192.168.0.4	Usuario sale del sistema	El usuario  jtecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
448	21	2020-03-05 22:05:11	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario tecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
449	21	2020-03-05 22:05:34	192.168.0.4	Usuario sale del sistema	El usuario  tecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
450	18	2020-03-05 22:05:44	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
451	18	2020-03-05 22:11:05	192.168.0.4	Usuario sale del sistema	El usuario  jtecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
452	21	2020-03-05 22:11:23	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario tecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
453	21	2020-03-05 23:17:02	192.168.0.4	Usuario sale del sistema	El usuario  tecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
454	21	2020-03-05 23:17:10	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario tecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
455	21	2020-03-05 23:21:50	192.168.0.4	Usuario sale del sistema	El usuario  tecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
456	17	2020-03-05 23:21:58	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
457	17	2020-03-05 23:22:20	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
458	18	2020-03-05 23:22:36	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
459	18	2020-03-05 23:25:36	192.168.0.4	Usuario sale del sistema	El usuario  jtecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
460	17	2020-03-05 23:25:47	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
461	17	2020-03-05 23:32:06	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
462	20	2020-03-05 23:32:33	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
463	20	2020-03-05 23:40:09	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
464	17	2020-03-05 23:40:15	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
465	17	2020-03-05 23:41:11	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
466	20	2020-03-05 23:41:19	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
467	2	2020-03-08 19:19:56	192.168.0.4	Actualizar Usuario	Actualizados los datos de jlogistica.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
468	2	2020-03-08 19:21:02	192.168.0.4	Actualizar Usuario	Actualizados los datos de jcompras.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
469	2	2020-03-08 19:21:28	192.168.0.4	Actualizar Usuario	Actualizados los datos de jcompras.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
470	2	2020-03-08 19:21:42	192.168.0.4	Actualizar Usuario	Actualizados los datos de cinternacional.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
471	20	2020-03-08 20:03:26	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
472	17	2020-03-08 20:03:54	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
473	17	2020-03-08 20:04:06	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
474	18	2020-03-08 20:04:18	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
475	18	2020-03-08 20:04:37	192.168.0.4	Usuario sale del sistema	El usuario  jtecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
476	17	2020-03-08 20:04:47	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
477	17	2020-03-08 20:05:07	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
478	20	2020-03-08 20:05:13	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
479	2	2020-03-08 20:23:10	192.168.0.4	Usuario sale del sistema	El usuario  admin ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
480	17	2020-03-08 20:23:20	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
481	17	2020-03-08 20:23:50	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
482	2	2020-03-08 20:24:02	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario admin	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
483	2	2020-03-08 20:24:37	192.168.0.4	Actualizar Usuario	Actualizados los datos de gol.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
484	2	2020-03-08 20:24:48	192.168.0.4	Actualizar Usuario	Actualizados los datos de tecnico.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
485	2	2020-03-08 20:25:00	192.168.0.4	Actualizar Usuario	Actualizados los datos de jlogistica.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
486	2	2020-03-08 20:25:09	192.168.0.4	Actualizar Usuario	Actualizados los datos de jtecnico.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
487	2	2020-03-08 20:25:31	192.168.0.4	Actualizar Usuario	Actualizados los datos de cnacional.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
488	2	2020-03-08 20:25:44	192.168.0.4	Actualizar Usuario	Actualizados los datos de cinternacional.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
489	2	2020-03-08 20:25:55	192.168.0.4	Actualizar Usuario	Actualizados los datos de jcompras.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
490	2	2020-03-08 20:26:02	192.168.0.4	Actualizar Usuario	Actualizados los datos de admin.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
491	2	2020-03-08 20:26:09	192.168.0.4	Actualizar Usuario	Actualizados los datos de ueb.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
492	2	2020-03-08 20:26:15	192.168.0.4	Actualizar Usuario	Actualizados los datos de ueb.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
493	20	2020-03-09 16:16:48	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
494	21	2020-03-09 16:17:05	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario tecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
495	21	2020-03-09 16:25:40	192.168.0.4	Usuario sale del sistema	El usuario  tecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
496	20	2020-03-09 16:25:47	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
497	20	2020-03-09 19:19:51	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
498	20	2020-03-09 19:20:04	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
499	2	2020-03-09 19:22:06	192.168.0.4	Rol creado	El Rol miembro_comite ha sido creado.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
500	2	2020-03-09 19:24:19	192.168.0.4	Agregar Usuario	Fue añadido el usuario comite al sistema.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
501	20	2020-03-09 19:25:29	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
502	24	2020-03-09 19:25:37	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario comite	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
503	24	2020-03-09 19:26:58	192.168.0.4	Usuario sale del sistema	El usuario  comite ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
504	20	2020-03-09 19:27:10	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
505	20	2020-03-09 19:28:36	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
506	24	2020-03-09 19:28:45	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario comite	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
507	24	2020-03-09 19:42:15	192.168.0.4	Usuario sale del sistema	El usuario  comite ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
508	20	2020-03-09 19:42:34	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
509	20	2020-03-09 20:04:33	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
510	24	2020-03-09 20:04:45	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario comite	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
511	24	2020-03-09 20:05:20	192.168.0.4	Usuario sale del sistema	El usuario  comite ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
512	20	2020-03-09 20:05:32	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
513	20	2020-03-09 21:28:28	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
514	20	2020-03-09 21:28:34	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
515	20	2020-03-11 12:35:17	192.168.43.254	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
516	14	2020-03-11 12:35:34	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario ueb	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
517	14	2020-03-11 12:36:44	192.168.43.254	Demanda creada	Se ha creado una demanda con ID14	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
518	14	2020-03-11 12:37:24	192.168.43.254	Demanda enviada	Se ha enviado la demanda D-2020-002	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
519	14	2020-03-11 12:37:34	192.168.43.254	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
520	23	2020-03-11 12:37:49	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario logistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
521	23	2020-03-11 12:38:04	192.168.43.254	Demanda aceptada	La Demanda D-2020-002 ha sido aceptada	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
522	23	2020-03-11 12:42:34	192.168.43.254	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
523	15	2020-03-11 12:42:45	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
524	15	2020-03-11 12:43:23	192.168.43.254	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
525	18	2020-03-11 12:43:41	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
526	18	2020-03-11 12:44:20	192.168.43.254	Usuario sale del sistema	El usuario  jtecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
527	17	2020-03-11 12:44:31	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
528	17	2020-03-11 12:45:11	192.168.43.254	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
529	20	2020-03-11 12:45:27	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
530	20	2020-03-11 13:48:46	192.168.43.254	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
531	21	2020-03-11 13:49:00	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario tecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
532	21	2020-03-11 14:08:30	192.168.43.254	Usuario sale del sistema	El usuario  tecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
533	20	2020-03-11 14:08:46	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
534	20	2020-03-11 14:19:34	192.168.43.254	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
535	21	2020-03-11 14:19:45	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario tecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
536	21	2020-03-11 14:23:07	192.168.43.254	Usuario sale del sistema	El usuario  tecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
537	20	2020-03-11 14:23:25	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
538	20	2020-03-11 14:24:53	192.168.43.254	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
539	24	2020-03-11 14:25:30	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario comite	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
540	24	2020-03-11 14:25:48	192.168.43.254	Usuario sale del sistema	El usuario  comite ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
541	24	2020-03-11 14:26:09	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario comite	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
542	24	2020-03-11 14:33:49	192.168.43.254	Usuario sale del sistema	El usuario  comite ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
543	20	2020-03-11 14:34:11	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
544	20	2020-03-14 13:17:09	192.168.43.254	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
545	14	2020-03-14 13:18:08	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario ueb	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
546	14	2020-03-14 13:28:25	192.168.43.254	Demanda creada	Se ha creado una demanda con ID15	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
547	14	2020-03-14 13:30:22	192.168.43.254	Demanda enviada	Se ha enviado la demanda D-2020-003	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
548	14	2020-03-14 13:30:31	192.168.43.254	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
549	23	2020-03-14 13:30:43	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario logistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
550	23	2020-03-14 13:35:54	192.168.43.254	Demanda aceptada	La Demanda D-2020-003 ha sido aceptada	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
551	23	2020-03-14 13:37:55	192.168.43.254	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
552	17	2020-03-14 13:38:11	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
553	17	2020-03-14 13:38:51	192.168.43.254	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
554	15	2020-03-14 13:39:03	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
555	15	2020-03-14 13:40:55	192.168.43.254	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
556	18	2020-03-14 13:41:16	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
557	18	2020-03-14 13:45:04	192.168.43.254	Usuario sale del sistema	El usuario  jtecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
558	17	2020-03-14 13:45:15	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
559	17	2020-03-14 13:46:55	192.168.43.254	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
560	20	2020-03-14 13:47:08	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
561	20	2020-03-14 13:49:41	192.168.43.254	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
562	17	2020-03-14 13:49:55	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
563	17	2020-03-14 13:50:18	192.168.43.254	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
564	14	2020-03-14 14:03:21	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario ueb	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
565	14	2020-03-14 20:46:35	192.168.0.4	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
566	2	2020-03-14 20:46:44	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario admin	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
567	2	2020-03-14 21:17:13	192.168.0.4	Usuario sale del sistema	El usuario  admin ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
568	2	2020-03-14 21:17:18	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario admin	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
569	2	2020-03-14 21:17:22	192.168.0.4	Usuario sale del sistema	El usuario  admin ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
570	14	2020-03-14 21:17:28	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario ueb	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
571	14	2020-03-14 23:13:28	192.168.0.4	Demanda creada	Se ha creado una demanda con ID16	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
572	14	2020-03-14 23:35:41	192.168.0.4	Demanda enviada	Se ha enviado la demanda D-2020-001	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
573	14	2020-03-14 23:35:52	192.168.0.4	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
574	23	2020-03-14 23:36:04	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario logistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
575	23	2020-03-14 23:54:50	192.168.0.4	Demanda rechazada	La Demanda 16 ha sido rechazada	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
576	23	2020-03-15 00:28:58	192.168.0.4	Demanda aceptada	La Demanda D-2020-001 ha sido aceptada	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
577	23	2020-03-15 00:35:42	192.168.0.4	Demanda aceptada	La Demanda D-2020-001 ha sido aceptada	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
578	23	2020-03-15 00:36:36	192.168.0.4	Demanda aceptada	La Demanda D-2020-001 ha sido aceptada	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
579	23	2020-03-15 00:37:18	192.168.0.4	Demanda aceptada	La Demanda D-2020-001 ha sido aceptada	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
580	23	2020-03-15 00:38:10	192.168.0.4	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
581	15	2020-03-15 00:38:23	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
582	15	2020-03-15 00:45:59	192.168.0.4	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
583	18	2020-03-15 00:46:12	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
584	18	2020-03-15 00:47:45	192.168.0.4	Usuario sale del sistema	El usuario  jtecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
585	17	2020-03-15 00:47:53	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
586	17	2020-03-15 01:33:00	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
587	20	2020-03-15 01:33:13	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
588	20	2020-03-15 01:56:07	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
589	21	2020-03-15 01:56:16	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario tecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
590	21	2020-03-15 04:16:56	192.168.0.4	Usuario sale del sistema	El usuario  tecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
591	14	2020-03-15 04:18:10	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario ueb	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
592	14	2020-03-15 04:30:31	192.168.0.4	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
593	2	2020-03-15 04:30:40	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario admin	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
594	2	2020-03-15 05:59:47	192.168.0.4	Usuario desactivado	El usuario logistica fue desactivado.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
595	2	2020-03-15 06:00:28	192.168.0.4	Usuario desactivado	El usuario logistica fue desactivado.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
596	2	2020-03-15 06:03:19	192.168.0.4	Usuario sale del sistema	El usuario  admin ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
597	2	2020-03-15 06:12:35	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario admin	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
598	2	2020-03-15 06:13:05	192.168.0.4	Usuario sale del sistema	El usuario  admin ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
599	14	2020-03-15 06:13:38	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario ueb	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
600	14	2020-03-15 07:03:57	192.168.0.4	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
601	20	2020-03-15 07:04:21	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
602	20	2020-03-15 07:04:40	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
603	14	2020-03-15 07:04:49	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario ueb	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
604	14	2020-03-15 07:14:31	192.168.0.4	Demanda creada	Se ha creado una demanda con ID17	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
605	2	2020-03-15 07:20:16	192.168.0.4	Usuario sale del sistema	El usuario  admin ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
606	14	2020-03-15 07:40:52	192.168.0.4	Demanda enviada	Se ha enviado la demanda D-2020-002	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
607	14	2020-03-15 07:52:47	192.168.0.4	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
608	23	2020-03-15 07:53:20	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario logistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
609	23	2020-03-15 17:01:43	192.168.0.4	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
610	20	2020-03-15 17:01:50	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
611	20	2020-03-15 20:13:33	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
612	21	2020-03-15 20:13:43	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario tecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
613	21	2020-03-15 21:14:46	192.168.0.4	Usuario sale del sistema	El usuario  tecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
614	20	2020-03-15 21:14:58	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
615	20	2020-03-16 01:09:28	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
616	24	2020-03-16 01:09:42	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario comite	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
617	24	2020-03-16 01:09:57	192.168.0.4	Usuario sale del sistema	El usuario  comite ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
618	20	2020-03-16 01:10:20	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
619	20	2020-03-16 01:32:43	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
620	20	2020-03-16 01:32:48	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
621	20	2020-03-16 02:11:26	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
622	24	2020-03-16 02:11:37	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario comite	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
623	24	2020-03-16 02:19:01	192.168.0.4	Usuario sale del sistema	El usuario  comite ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
624	20	2020-03-16 02:19:11	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
625	2	2020-03-16 02:54:19	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario admin	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
626	2	2020-03-18 02:15:22	192.168.0.4	Usuario sale del sistema	El usuario  admin ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
627	17	2020-03-18 02:15:35	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
628	17	2020-03-18 02:56:13	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
629	2	2020-03-18 02:56:52	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario admin	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
630	20	2020-03-18 21:58:02	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
631	17	2020-03-18 21:58:51	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
632	17	2020-03-18 22:00:21	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
633	14	2020-03-18 22:00:37	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario ueb	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
634	14	2020-03-19 03:34:07	192.168.0.4	Demanda creada	Se ha creado una demanda con ID18	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
635	14	2020-03-19 03:34:58	192.168.0.4	Demanda enviada	Se ha enviado la demanda D-2020-003	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
636	14	2020-03-19 03:35:08	192.168.0.4	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
637	23	2020-03-19 03:35:28	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario logistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
638	23	2020-03-19 03:36:33	192.168.0.4	Demanda aceptada	La Demanda D-2020-002 ha sido aceptada	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
639	23	2020-03-19 22:03:44	192.168.0.4	Demanda aceptada	La Demanda D-2020-003 ha sido aceptada	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
640	23	2020-03-19 22:06:46	192.168.0.4	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
641	15	2020-03-19 22:06:56	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
642	15	2020-03-20 03:54:08	192.168.0.4	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
643	20	2020-03-20 03:54:14	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
644	2	2020-03-20 04:03:49	192.168.0.4	Usuario sale del sistema	El usuario  admin ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
645	23	2020-03-20 04:04:04	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario logistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
646	20	2020-03-20 04:32:46	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
647	21	2020-03-20 04:32:59	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario tecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
648	21	2020-03-20 04:41:08	192.168.0.4	Usuario sale del sistema	El usuario  tecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
649	17	2020-03-20 04:41:23	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
650	17	2020-03-20 04:41:30	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
651	20	2020-03-20 04:41:40	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
652	20	2020-03-20 05:12:53	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
653	15	2020-03-20 05:13:06	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
654	15	2020-03-20 05:17:01	192.168.0.4	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
655	18	2020-03-20 05:17:07	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
656	18	2020-03-20 05:17:28	192.168.0.4	Usuario sale del sistema	El usuario  jtecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
657	18	2020-03-20 05:17:35	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
658	18	2020-03-20 05:18:41	192.168.0.4	Usuario sale del sistema	El usuario  jtecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
659	15	2020-03-20 05:18:54	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
660	15	2020-03-20 05:19:30	192.168.0.4	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
661	18	2020-03-20 05:19:41	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
662	18	2020-03-20 06:03:26	192.168.0.4	Usuario sale del sistema	El usuario  jtecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
663	17	2020-03-20 06:03:34	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
664	23	2020-03-20 06:08:53	192.168.0.4	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
665	17	2020-03-20 06:08:59	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
666	19	2020-03-20 06:09:17	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cnacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
667	2	2020-03-20 06:09:25	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario admin	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
668	19	2020-03-21 03:39:41	192.168.0.4	Usuario sale del sistema	El usuario  cnacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
669	21	2020-03-21 03:39:53	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario tecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
670	21	2020-03-22 04:46:45	192.168.0.4	Usuario sale del sistema	El usuario  tecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
671	19	2020-03-22 04:46:59	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cnacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
672	19	2020-03-22 22:11:03	192.168.0.4	Usuario sale del sistema	El usuario  cnacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
673	14	2020-03-22 22:11:14	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario ueb	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
674	14	2020-03-22 22:11:43	192.168.0.4	Demanda creada	Se ha creado una demanda con ID19	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
675	14	2020-03-22 22:12:02	192.168.0.4	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
676	23	2020-03-22 22:12:24	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario logistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
677	23	2020-03-22 22:12:45	192.168.0.4	Demanda aceptada	La Demanda D-2020-002 ha sido aceptada	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
678	23	2020-03-22 22:13:35	192.168.0.4	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
679	14	2020-03-22 22:13:45	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario ueb	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
680	14	2020-03-22 22:14:04	192.168.0.4	Demanda enviada	Se ha enviado la demanda D-2020-004	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
681	14	2020-03-22 22:14:12	192.168.0.4	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
682	23	2020-03-22 22:14:19	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario logistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
683	23	2020-03-22 22:14:32	192.168.0.4	Demanda aceptada	La Demanda D-2020-004 ha sido aceptada	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
684	23	2020-03-22 22:14:51	192.168.0.4	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
685	15	2020-03-22 22:15:00	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
686	15	2020-03-22 22:15:26	192.168.0.4	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
687	18	2020-03-22 22:15:45	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
688	18	2020-03-22 22:17:52	192.168.0.4	Usuario sale del sistema	El usuario  jtecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
689	17	2020-03-22 22:17:57	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
690	17	2020-03-22 22:19:14	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
691	19	2020-03-22 22:19:23	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cnacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
692	19	2020-03-22 22:29:26	192.168.0.4	Usuario sale del sistema	El usuario  cnacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
693	21	2020-03-22 22:29:39	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario tecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
694	21	2020-03-22 22:30:21	192.168.0.4	Usuario sale del sistema	El usuario  tecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
695	19	2020-03-22 22:30:29	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cnacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
696	19	2020-03-22 22:43:26	192.168.0.4	Usuario sale del sistema	El usuario  cnacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
697	23	2020-03-22 22:43:48	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario logistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
698	23	2020-03-22 22:44:43	192.168.0.4	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
699	15	2020-03-22 22:44:49	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
700	15	2020-03-22 22:46:31	192.168.0.4	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
701	18	2020-03-22 22:46:36	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
702	18	2020-03-22 22:47:04	192.168.0.4	Usuario sale del sistema	El usuario  jtecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
703	17	2020-03-22 22:47:11	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
704	17	2020-03-22 22:48:19	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
705	20	2020-03-22 22:48:25	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
706	20	2020-03-23 02:37:25	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
707	20	2020-03-23 02:37:32	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
708	20	2020-03-23 02:48:52	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
709	20	2020-03-23 02:48:56	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
710	20	2020-03-23 02:49:09	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
711	21	2020-03-23 02:49:18	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario tecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
712	21	2020-03-23 02:51:13	192.168.0.4	Usuario sale del sistema	El usuario  tecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
713	20	2020-03-23 02:51:19	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
714	20	2020-03-23 02:55:26	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
715	24	2020-03-23 02:55:49	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario comite	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
716	24	2020-03-23 03:07:05	192.168.0.4	Usuario sale del sistema	El usuario  comite ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
717	20	2020-03-23 03:07:14	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
718	20	2020-03-23 03:16:27	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
719	19	2020-03-23 03:20:32	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cnacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
720	19	2020-03-23 03:20:33	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cnacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
721	19	2020-03-23 03:20:45	192.168.0.4	Usuario sale del sistema	El usuario  cnacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
722	2	2020-03-23 03:30:59	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario admin	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
723	2	2020-03-23 03:31:08	192.168.0.4	Usuario sale del sistema	El usuario  admin ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
724	14	2020-03-23 03:42:55	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario ueb	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
725	14	2020-03-23 03:43:44	192.168.43.254	Demanda creada	Se ha creado una demanda con ID20	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
726	14	2020-03-23 03:44:18	192.168.43.254	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
727	23	2020-03-23 03:44:34	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario logistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
728	23	2020-03-23 03:45:01	192.168.43.254	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
729	14	2020-03-23 03:45:13	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario ueb	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
730	14	2020-03-23 03:45:42	192.168.43.254	Demanda enviada	Se ha enviado la demanda D-2020-005	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
731	14	2020-03-23 03:45:52	192.168.43.254	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
732	23	2020-03-23 03:46:03	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario logistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
733	23	2020-03-23 03:46:27	192.168.43.254	Demanda aceptada	La Demanda D-2020-005 ha sido aceptada	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
734	23	2020-03-23 03:47:08	192.168.43.254	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
735	15	2020-03-23 03:47:22	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
736	15	2020-03-23 13:48:51	192.168.43.254	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
737	18	2020-03-23 13:49:06	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
738	18	2020-03-23 13:49:43	192.168.43.254	Usuario sale del sistema	El usuario  jtecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
739	17	2020-03-23 13:49:54	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
740	17	2020-03-23 13:50:31	192.168.43.254	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
741	20	2020-03-23 13:50:46	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
742	20	2020-03-23 14:01:08	192.168.43.254	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
743	21	2020-03-23 14:01:24	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario tecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
744	21	2020-03-23 14:02:16	192.168.43.254	Usuario sale del sistema	El usuario  tecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
745	20	2020-03-23 14:02:29	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
746	20	2020-03-23 14:06:25	192.168.43.254	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
747	24	2020-03-23 14:06:37	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario comite	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
748	24	2020-03-23 14:09:29	192.168.43.254	Usuario sale del sistema	El usuario  comite ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
749	20	2020-03-23 14:09:38	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
750	20	2020-03-23 14:22:36	192.168.43.254	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
751	15	2020-03-23 14:23:02	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
752	15	2020-03-23 14:24:07	192.168.43.254	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
753	18	2020-03-23 14:24:25	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
754	18	2020-03-23 14:25:14	192.168.43.254	Usuario sale del sistema	El usuario  jtecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
755	17	2020-03-23 14:25:36	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
756	17	2020-03-23 14:26:35	192.168.43.254	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
757	19	2020-03-23 14:26:47	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario cnacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
758	19	2020-03-23 14:28:30	192.168.43.254	Usuario sale del sistema	El usuario  cnacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
759	21	2020-03-23 14:28:48	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario tecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
760	21	2020-03-23 14:29:43	192.168.43.254	Usuario sale del sistema	El usuario  tecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
761	19	2020-03-23 14:30:28	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario cnacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
762	19	2020-03-23 14:40:27	192.168.43.254	Usuario sale del sistema	El usuario  cnacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
763	23	2020-03-23 14:40:40	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario logistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
764	23	2020-03-23 15:09:44	192.168.43.254	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
765	2	2020-03-23 15:09:54	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario admin	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
766	2	2020-03-23 15:10:50	192.168.43.254	Usuario sale del sistema	El usuario  admin ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
767	20	2020-03-30 23:31:00	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
768	20	2020-03-30 23:31:47	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
769	14	2020-03-30 23:31:54	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario ueb	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
770	14	2020-03-30 23:39:59	192.168.0.4	Demanda creada	Se ha creado una demanda con ID21	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
771	14	2020-03-30 23:40:36	192.168.0.4	Demanda enviada	Se ha enviado la demanda D-2020-006	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
772	14	2020-03-30 23:40:52	192.168.0.4	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
773	23	2020-03-30 23:41:17	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario logistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
774	23	2020-03-30 23:41:34	192.168.0.4	Demanda aceptada	La Demanda D-2020-006 ha sido aceptada	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
775	23	2020-03-30 23:59:52	192.168.0.4	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
776	15	2020-03-31 00:00:06	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
777	15	2020-03-31 00:00:26	192.168.0.4	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
778	18	2020-03-31 00:00:52	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
779	18	2020-03-31 00:01:26	192.168.0.4	Usuario sale del sistema	El usuario  jtecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
780	20	2020-03-31 00:01:49	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
781	20	2020-03-31 00:02:00	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
782	17	2020-03-31 00:02:12	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
783	17	2020-03-31 00:02:41	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
784	20	2020-03-31 00:02:50	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
785	20	2020-03-31 00:12:05	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
786	21	2020-03-31 00:12:16	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario tecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
787	21	2020-03-31 00:13:34	192.168.0.4	Usuario sale del sistema	El usuario  tecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
788	20	2020-03-31 00:13:39	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
789	20	2020-03-31 00:16:04	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
790	24	2020-03-31 00:16:19	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario comite	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
791	24	2020-03-31 00:18:09	192.168.0.4	Usuario sale del sistema	El usuario  comite ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
792	20	2020-03-31 00:18:15	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
793	20	2020-03-31 00:33:06	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
794	23	2020-03-31 00:33:39	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario logistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
795	23	2020-03-31 00:34:37	192.168.0.4	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
796	15	2020-03-31 00:35:03	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
797	15	2020-03-31 00:35:29	192.168.0.4	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
798	18	2020-03-31 00:35:39	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
799	18	2020-03-31 00:36:16	192.168.0.4	Usuario sale del sistema	El usuario  jtecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
800	17	2020-03-31 00:36:28	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
801	17	2020-03-31 00:37:09	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
802	19	2020-03-31 00:37:35	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cnacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
803	19	2020-03-31 00:38:53	192.168.0.4	Usuario sale del sistema	El usuario  cnacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
804	21	2020-03-31 00:39:06	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario tecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
805	21	2020-03-31 00:40:08	192.168.0.4	Usuario sale del sistema	El usuario  tecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
806	19	2020-03-31 00:40:25	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cnacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
807	19	2020-04-04 15:43:59	192.168.0.4	Usuario sale del sistema	El usuario  cnacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
808	23	2020-04-04 15:52:01	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario logistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
809	23	2020-04-04 16:49:18	192.168.0.4	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
810	2	2020-04-04 16:49:38	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario admin	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
811	2	2020-04-04 18:40:16	192.168.0.4	Usuario sale del sistema	El usuario  admin ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
812	23	2020-04-04 18:45:52	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario logistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
813	23	2020-04-05 18:38:19	192.168.0.4	Solicitud SN-2020-005-gav-01 eliminada.	La solicitud de compra SN-2020-005-gav-01 ha sido eliminada.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
814	23	2020-04-05 18:39:56	192.168.0.4	Solicitud SN-2020-005-gav-01 eliminada.	La solicitud de compra SN-2020-005-gav-01 ha sido eliminada.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
815	23	2020-04-05 18:40:09	192.168.0.4	Solicitud SN-2020-005-gav-01 eliminada.	La solicitud de compra SN-2020-005-gav-01 ha sido eliminada.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
816	23	2020-04-05 18:41:31	192.168.0.4	Solicitud SN-2020-005-gav-01 eliminada.	La solicitud de compra SN-2020-005-gav-01 ha sido eliminada.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
817	23	2020-04-05 18:55:41	192.168.0.4	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
818	15	2020-04-05 18:56:10	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
819	15	2020-04-05 19:32:09	192.168.0.4	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
820	23	2020-04-05 19:32:17	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario logistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
821	23	2020-04-05 19:59:19	192.168.0.4	Solicitud SN-2020-005-gav-01 eliminada.	La solicitud de compra SN-2020-005-gav-01 ha sido eliminada.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
822	23	2020-04-05 20:02:52	192.168.0.4	Solicitud SN-2020-005-gav-01 eliminada.	La solicitud de compra SN-2020-005-gav-01 ha sido eliminada.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
823	23	2020-04-05 20:06:13	192.168.0.4	Solicitud SN-2020-005-gav-01 eliminada.	La solicitud de compra SN-2020-005-gav-01 ha sido eliminada.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
824	23	2020-04-05 20:06:42	192.168.0.4	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
825	14	2020-04-05 20:06:51	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario ueb	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
826	14	2020-04-05 20:07:30	192.168.0.4	Demanda creada	Se ha creado una demanda con ID22	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
827	14	2020-04-05 20:08:20	192.168.0.4	Demanda enviada	Se ha enviado la demanda D-2020-007	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
828	14	2020-04-05 20:08:27	192.168.0.4	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
829	23	2020-04-05 20:08:33	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario logistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
830	23	2020-04-05 20:08:48	192.168.0.4	Demanda aceptada	La Demanda D-2020-007 ha sido aceptada	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
831	23	2020-04-05 20:09:38	192.168.0.4	Solicitud SN-2020-005 eliminada.	La solicitud de compra SN-2020-005 ha sido eliminada.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
832	23	2020-04-06 03:53:33	192.168.0.4	Solicitud SN-2020-005-gae-02 eliminada.	La solicitud de compra SN-2020-005-gae-02 ha sido eliminada.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
833	23	2020-04-06 04:00:58	192.168.0.4	Solicitud SN-2020-005-gae-03 eliminada.	La solicitud de compra SN-2020-005-gae-03 ha sido eliminada.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
834	23	2020-04-06 04:01:26	192.168.0.4	Solicitud SN-2020-005-gae-02 eliminada.	La solicitud de compra SN-2020-005-gae-02 ha sido eliminada.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
835	23	2020-04-06 04:38:49	192.168.0.4	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
836	17	2020-04-06 04:39:15	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
837	17	2020-04-06 04:39:24	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
838	18	2020-04-06 04:39:36	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
839	18	2020-04-06 04:48:18	192.168.0.4	Usuario sale del sistema	El usuario  jtecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
840	17	2020-04-06 04:48:42	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
841	17	2020-04-06 04:50:26	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
842	19	2020-04-06 05:13:38	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cnacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
843	19	2020-04-06 05:13:57	192.168.0.4	Usuario sale del sistema	El usuario  cnacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
844	17	2020-04-06 05:14:14	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
845	17	2020-04-06 05:14:41	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
846	19	2020-04-06 05:14:53	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cnacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
847	2	2020-04-07 23:03:22	192.168.0.4	Usuario sale del sistema	El usuario  admin ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
848	17	2020-04-07 23:03:27	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
849	17	2020-04-07 23:48:04	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
850	19	2020-04-07 23:51:05	192.168.0.4	Usuario sale del sistema	El usuario  cnacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
851	23	2020-04-07 23:51:30	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario logistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
852	23	2020-04-07 23:51:45	192.168.0.4	Solicitud SN-2020-005-gae-01 eliminada.	La solicitud de compra SN-2020-005-gae-01 ha sido eliminada.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
853	23	2020-04-07 23:51:53	192.168.0.4	Solicitud SN-2020-005-gae-02 eliminada.	La solicitud de compra SN-2020-005-gae-02 ha sido eliminada.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
854	23	2020-04-07 23:52:02	192.168.0.4	Solicitud SN-2020-005-gae-03 eliminada.	La solicitud de compra SN-2020-005-gae-03 ha sido eliminada.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
855	2	2020-04-07 23:53:48	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario admin	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
856	23	2020-04-08 00:05:18	192.168.0.4	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
857	18	2020-04-08 00:05:32	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
858	18	2020-04-08 00:05:42	192.168.0.4	Usuario sale del sistema	El usuario  jtecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
859	18	2020-04-08 00:05:50	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
860	18	2020-04-08 00:06:13	192.168.0.4	Usuario sale del sistema	El usuario  jtecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
861	17	2020-04-08 00:06:26	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
862	17	2020-04-08 00:06:42	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
863	17	2020-04-08 00:06:59	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
864	17	2020-04-08 00:08:24	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
865	18	2020-04-08 00:10:16	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
866	18	2020-04-08 00:11:13	192.168.0.4	Usuario sale del sistema	El usuario  jtecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
867	17	2020-04-08 00:11:31	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
868	17	2020-04-08 00:11:44	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
869	19	2020-04-08 00:13:22	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cnacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
870	19	2020-04-10 16:08:04	192.168.0.4	Usuario sale del sistema	El usuario  cnacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
871	14	2020-04-10 16:08:16	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario ueb	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
872	14	2020-04-10 18:45:02	192.168.0.4	Demanda creada	Se ha creado una demanda con ID23	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
873	14	2020-04-10 18:45:19	192.168.0.4	Demanda enviada	Se ha enviado la demanda D-2020-008	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
874	14	2020-04-10 18:46:36	192.168.0.4	Demanda creada	Se ha creado una demanda con ID24	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
875	14	2020-04-10 18:47:40	192.168.0.4	Demanda enviada	Se ha enviado la demanda D-2020-009	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
876	14	2020-04-10 18:52:13	192.168.0.4	Demanda creada	Se ha creado una demanda con ID25	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
877	14	2020-04-10 18:52:34	192.168.0.4	Demanda enviada	Se ha enviado la demanda D-2020-010	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
878	14	2020-04-10 18:53:44	192.168.0.4	Demanda creada	Se ha creado una demanda con ID26	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
879	14	2020-04-10 18:54:03	192.168.0.4	Demanda enviada	Se ha enviado la demanda D-2020-011	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
880	14	2020-04-10 18:55:06	192.168.0.4	Demanda creada	Se ha creado una demanda con ID27	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
881	14	2020-04-10 18:55:23	192.168.0.4	Demanda enviada	Se ha enviado la demanda D-2020-012	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
882	14	2020-04-10 19:41:01	192.168.0.4	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
883	23	2020-04-10 19:41:23	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario logistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
884	23	2020-04-10 19:56:36	192.168.0.4	Demanda rechazada	La Demanda 23 ha sido rechazada	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
885	23	2020-04-10 20:05:47	192.168.0.4	Demanda aceptada	La Demanda D-2020-009 ha sido aceptada	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
886	23	2020-04-10 20:06:10	192.168.0.4	Demanda aceptada	La Demanda D-2020-009 ha sido aceptada	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
887	23	2020-04-10 20:25:27	192.168.0.4	Item cancelado	El item Accesorio para Tamper Switch Honeywell 28 2 (5) fue rechazado.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
888	23	2020-04-10 20:26:30	192.168.0.4	Item cancelado	El item Accesorio para Tamper Switch Honeywell 28 2 (5) fue rechazado.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
889	23	2020-04-10 20:29:28	192.168.0.4	Item cancelado	El item Accesorio para Tamper Switch Honeywell 28 2 (5) fue rechazado.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
890	23	2020-04-10 20:32:32	192.168.0.4	Demanda aceptada	La Demanda D-2020-010 ha sido aceptada	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
891	23	2020-04-10 20:32:58	192.168.0.4	Item cancelado	El item Tamper Switch Inalambrico Honeywell 5800RPS (10) fue rechazado.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
892	23	2020-04-10 21:33:22	192.168.0.4	solicitud de compra creada	Se ha creado la solicitud de compra SI-2020-004	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
893	23	2020-04-10 21:42:50	192.168.0.4	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
894	15	2020-04-10 21:43:33	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
895	15	2020-04-10 21:43:49	192.168.0.4	solicitud de compra aprobada	Se ha aprobado la solicitud de compra SI-2020-004	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
896	15	2020-04-11 01:50:57	192.168.0.4	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
897	23	2020-04-29 00:55:40	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario logistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
898	23	2020-04-28 21:33:36	192.168.0.4	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
899	15	2020-04-28 21:33:48	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
900	15	2020-04-28 21:34:12	192.168.0.4	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
901	18	2020-04-28 21:34:19	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
902	18	2020-04-28 21:34:36	192.168.0.4	Solicitud asignada	Se ha asignado la solicitud SI-2020-004 a Especialista Técncio	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
903	18	2020-04-28 21:34:49	192.168.0.4	Usuario sale del sistema	El usuario  jtecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
904	15	2020-04-28 21:34:58	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
905	15	2020-04-28 21:35:26	192.168.0.4	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
906	17	2020-04-28 21:35:31	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
907	17	2020-04-28 21:35:42	192.168.0.4	Solicitud asignada	Se ha asignado la solicitud SI-2020-004 a Comprador Internacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
908	17	2020-04-28 21:35:52	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
909	20	2020-04-28 21:35:58	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
910	20	2020-04-28 21:37:20	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
911	21	2020-04-28 21:37:29	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario tecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
912	21	2020-04-28 21:38:07	192.168.0.4	Usuario sale del sistema	El usuario  tecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
913	20	2020-04-28 21:38:13	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
914	20	2020-04-29 22:57:41	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
915	24	2020-04-29 22:58:01	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario comite	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
916	24	2020-04-29 22:58:22	192.168.0.4	Documento subido/actulizado	Se ha generado docuemnto con id 208	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
917	24	2020-04-29 22:58:33	192.168.0.4	Documento subido/actulizado	Se ha generado docuemnto con id 207	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
918	24	2020-04-29 22:58:43	192.168.0.4	Documento subido/actulizado	Se ha generado docuemnto con id 211	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
919	24	2020-04-29 22:58:54	192.168.0.4	Documento subido/actulizado	Se ha generado docuemnto con id 210	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
920	24	2020-04-29 22:59:09	192.168.0.4	Documento subido/actulizado	Se ha generado docuemnto con id 217	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
921	24	2020-04-29 22:59:22	192.168.0.4	Documento subido/actulizado	Se ha generado docuemnto con id 209	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
922	24	2020-04-29 22:59:35	192.168.0.4	Documento subido/actulizado	Se ha generado docuemnto con id 213	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
923	24	2020-04-29 22:59:49	192.168.0.4	Documento subido/actulizado	Se ha generado docuemnto con id 215	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
924	24	2020-04-29 23:00:04	192.168.0.4	Documento subido/actulizado	Se ha generado docuemnto con id 207	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
925	24	2020-04-29 23:00:16	192.168.0.4	Documento subido/actulizado	Se ha generado docuemnto con id 211	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
926	24	2020-04-29 23:00:27	192.168.0.4	Usuario sale del sistema	El usuario  comite ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
927	20	2020-04-29 23:00:32	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
928	20	2020-04-30 01:27:11	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
929	23	2020-04-30 01:27:42	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario logistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
930	23	2020-04-30 01:27:55	192.168.0.4	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
931	23	2020-04-30 01:28:00	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario logistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
932	23	2020-04-30 11:44:17	192.168.0.4	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
933	14	2020-04-30 11:44:23	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario ueb	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
934	14	2020-05-09 20:24:38	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario ueb	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
935	14	2020-05-09 21:06:55	192.168.0.4	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
936	23	2020-05-09 21:07:17	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario logistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
937	23	2020-05-10 14:05:30	192.168.0.4	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
938	2	2020-05-10 14:05:53	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario admin	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
939	2	2020-05-10 14:09:35	192.168.0.4	Agregar Usuario	Fue añadido el usuario ueb_pinar al sistema.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
940	2	2020-05-10 14:10:30	192.168.0.4	Agregar Usuario	Fue añadido el usuario ueb_santiagp al sistema.	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
941	2	2020-05-10 14:10:40	192.168.0.4	Usuario sale del sistema	El usuario  admin ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
942	26	2020-05-10 14:10:46	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario ueb_santiagp	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
943	26	2020-05-10 14:19:35	192.168.0.4	Demanda creada	Se ha creado una demanda con ID28	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
944	26	2020-05-10 14:19:59	192.168.0.4	Demanda enviada	Se ha enviado la demanda D-2020-013	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
945	26	2020-05-10 14:21:12	192.168.0.4	Usuario sale del sistema	El usuario  ueb_santiagp ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
946	23	2020-05-10 14:21:17	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario logistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
947	23	2020-05-10 14:21:44	192.168.0.4	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
948	25	2020-05-10 14:21:55	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario ueb_pinar	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
949	25	2020-05-10 14:22:58	192.168.0.4	Demanda creada	Se ha creado una demanda con ID29	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
950	25	2020-05-10 14:23:20	192.168.0.4	Demanda enviada	Se ha enviado la demanda D-2020-014	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
951	25	2020-05-10 14:23:29	192.168.0.4	Usuario sale del sistema	El usuario  ueb_pinar ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
952	23	2020-05-10 14:23:35	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario logistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
953	23	2020-05-10 23:47:31	192.168.0.4	solicitud de compra creada	Se ha creado la solicitud de compra SI-2020-005	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
954	23	2020-05-11 19:11:29	192.168.0.4	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
955	15	2020-05-11 19:11:56	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
956	15	2020-05-11 19:13:22	192.168.0.4	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
957	15	2020-05-11 19:13:45	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
958	15	2020-05-11 19:15:04	192.168.0.4	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
959	15	2020-05-11 19:15:10	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
960	15	2020-05-11 19:15:25	192.168.0.4	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
961	15	2020-05-11 19:15:34	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
962	15	2020-05-11 19:15:55	192.168.0.4	solicitud de compra aprobada	Se ha aprobado la solicitud de compra SI-2020-005	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
963	15	2020-05-11 19:16:06	192.168.0.4	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
964	18	2020-05-11 19:16:25	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
965	18	2020-05-12 08:16:07	192.168.0.4	Solicitud asignada	Se ha asignado la solicitud SI-2020-005 a Especialista Técncio	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
966	18	2020-05-12 08:16:38	192.168.0.4	Usuario sale del sistema	El usuario  jtecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
967	17	2020-05-12 08:16:49	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
968	17	2020-05-12 14:47:08	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
969	17	2020-05-12 14:47:28	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
970	17	2020-05-12 14:47:36	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
971	15	2020-05-12 14:47:46	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
972	15	2020-05-12 21:00:23	192.168.0.4	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
973	17	2020-05-12 21:00:39	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
974	17	2020-05-13 14:16:16	192.168.0.4	Solicitud asignada	Se ha asignado la solicitud SI-2020-005 a Comprador Internacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
975	17	2020-05-13 14:17:23	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
976	20	2020-05-13 14:17:39	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
977	20	2020-05-13 20:55:02	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
978	15	2020-05-13 20:55:23	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
979	15	2020-05-13 21:16:44	192.168.0.4	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
980	15	2020-05-13 21:16:50	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
981	15	2020-05-13 21:16:59	192.168.0.4	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
982	20	2020-05-13 21:17:12	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
983	20	2020-05-14 10:01:55	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
984	20	2020-05-14 10:02:02	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
985	20	2020-05-14 10:04:08	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
986	21	2020-05-14 10:05:06	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario tecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
987	21	2020-05-14 21:36:01	192.168.0.4	Usuario sale del sistema	El usuario  tecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
988	24	2020-05-14 21:39:16	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario comite	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
989	24	2020-05-15 09:11:59	192.168.0.4	Usuario sale del sistema	El usuario  comite ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
990	20	2020-05-15 09:12:30	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
991	20	2020-05-15 10:43:45	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
992	21	2020-05-15 10:43:54	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario tecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
993	21	2020-05-15 10:44:44	192.168.0.4	Usuario sale del sistema	El usuario  tecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
994	21	2020-05-15 10:44:51	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario tecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
995	21	2020-05-15 10:45:03	192.168.0.4	Usuario sale del sistema	El usuario  tecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
996	20	2020-05-15 10:45:17	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
997	20	2020-05-15 10:46:41	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
998	24	2020-05-15 10:49:44	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario comite	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
999	24	2020-05-16 18:30:28	192.168.0.4	Usuario sale del sistema	El usuario  comite ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1000	14	2020-05-16 18:30:36	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario ueb	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1001	14	2020-05-16 18:31:14	192.168.0.4	Demanda creada	Se ha creado una demanda con ID30	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1002	14	2020-05-16 19:33:46	192.168.0.4	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1003	23	2020-05-16 19:34:11	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario logistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1004	23	2020-05-16 19:34:25	192.168.0.4	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1005	14	2020-05-16 19:34:35	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario ueb	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1006	14	2020-05-16 19:34:56	192.168.0.4	Demanda enviada	Se ha enviado la demanda D-2020-001	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1007	14	2020-05-16 19:35:25	192.168.0.4	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1008	23	2020-05-16 19:35:33	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario logistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1009	23	2020-05-16 19:36:37	192.168.0.4	Demanda aceptada	La Demanda D-2020-001 ha sido aceptada	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1010	23	2020-05-16 19:36:48	192.168.0.4	solicitud de compra creada	Se ha creado la solicitud de compra SI-2020-001	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1011	23	2020-05-16 19:37:27	192.168.0.4	solicitud de compra aprobada	Se ha aprobado la solicitud de compra SI-2020-001	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1012	2	2020-05-16 19:38:33	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario admin	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1013	23	2020-05-16 19:39:54	192.168.0.4	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1014	17	2020-05-16 19:40:02	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1015	17	2020-05-16 19:40:29	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1016	18	2020-05-16 19:40:41	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1017	18	2020-05-16 19:40:55	192.168.0.4	Solicitud asignada	Se ha asignado la solicitud SI-2020-001 a Especialista Técncio	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1018	18	2020-05-16 19:41:22	192.168.0.4	Usuario sale del sistema	El usuario  jtecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1019	17	2020-05-16 19:41:32	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1020	17	2020-05-16 19:42:33	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1021	20	2020-05-16 19:42:45	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1022	20	2020-05-16 19:43:04	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1023	17	2020-05-16 19:43:12	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1024	17	2020-05-16 19:50:54	192.168.0.4	Solicitud asignada	Se ha asignado la solicitud SI-2020-001 a Comprador Internacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1025	17	2020-05-16 19:53:21	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1026	20	2020-05-16 19:53:31	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1027	20	2020-05-16 20:20:52	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1028	18	2020-05-16 20:21:01	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1029	18	2020-05-16 20:21:12	192.168.0.4	Usuario sale del sistema	El usuario  jtecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1030	21	2020-05-16 20:21:23	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario tecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1031	21	2020-05-16 20:23:00	192.168.0.4	Usuario sale del sistema	El usuario  tecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1032	20	2020-05-16 20:23:10	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1033	20	2020-05-16 20:30:55	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1034	24	2020-05-16 20:31:05	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario comite	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1035	24	2020-05-16 20:31:38	192.168.0.4	Documento subido/actulizado	Se ha generado docuemnto con id 230	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1036	24	2020-05-16 20:31:53	192.168.0.4	Documento subido/actulizado	Se ha generado docuemnto con id 229	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1037	24	2020-05-16 20:32:09	192.168.0.4	Documento subido/actulizado	Se ha generado docuemnto con id 233	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1038	24	2020-05-16 20:32:23	192.168.0.4	Documento subido/actulizado	Se ha generado docuemnto con id 232	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1039	24	2020-05-16 20:32:38	192.168.0.4	Documento subido/actulizado	Se ha generado docuemnto con id 239	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1040	24	2020-05-16 20:32:54	192.168.0.4	Documento subido/actulizado	Se ha generado docuemnto con id 231	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1041	24	2020-05-16 20:33:12	192.168.0.4	Documento subido/actulizado	Se ha generado docuemnto con id 235	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1042	24	2020-05-16 20:33:26	192.168.0.4	Documento subido/actulizado	Se ha generado docuemnto con id 237	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1043	24	2020-05-16 20:33:39	192.168.0.4	Usuario sale del sistema	El usuario  comite ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1044	20	2020-05-16 20:33:50	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1045	20	2020-05-16 21:01:56	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1046	25	2020-05-16 21:02:24	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario ueb_pinar	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1047	25	2020-05-16 21:02:50	192.168.0.4	Demanda creada	Se ha creado una demanda con ID31	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1048	25	2020-05-16 21:03:13	192.168.0.4	Demanda enviada	Se ha enviado la demanda D-2020-002	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1049	25	2020-05-16 21:03:23	192.168.0.4	Usuario sale del sistema	El usuario  ueb_pinar ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1050	23	2020-05-16 21:03:34	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario logistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1051	23	2020-05-16 21:05:03	192.168.0.4	solicitud de compra creada	Se ha creado la solicitud de compra SN-2020-001	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1052	23	2020-05-16 21:05:03	192.168.0.4	Demanda aceptada	La Demanda D-2020-002 ha sido aceptada	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1053	23	2020-05-16 21:05:31	192.168.0.4	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1054	17	2020-05-16 21:05:37	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1055	17	2020-05-16 21:07:00	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1056	18	2020-05-16 21:07:10	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1057	18	2020-05-16 21:22:38	192.168.0.4	Usuario sale del sistema	El usuario  jtecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1058	15	2020-05-16 21:22:56	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1059	15	2020-05-16 21:23:12	192.168.0.4	solicitud de compra aprobada	Se ha aprobado la solicitud de compra SN-2020-001	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1060	15	2020-05-16 21:23:26	192.168.0.4	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1061	18	2020-05-16 21:23:45	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1062	18	2020-05-16 21:23:45	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1063	18	2020-05-16 21:24:01	192.168.0.4	Solicitud asignada	Se ha asignado la solicitud SN-2020-001 a Especialista Técncio	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1064	18	2020-05-16 21:24:18	192.168.0.4	Usuario sale del sistema	El usuario  jtecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1065	17	2020-05-16 21:24:33	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1066	17	2020-05-16 21:24:51	192.168.0.4	Solicitud asignada	Se ha asignado la solicitud SN-2020-001 a Comprador Nacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1067	17	2020-05-16 22:49:04	192.168.0.4	Solicitud asignada	Se ha asignado la solicitud SN-2020-001 a Comprador Nacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1068	17	2020-05-16 22:50:04	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1069	15	2020-05-16 22:50:13	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1070	15	2020-05-16 22:52:10	192.168.0.4	solicitud de compra aprobada	Se ha aprobado la solicitud de compra SN-2020-001	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1071	15	2020-05-16 22:53:02	192.168.0.4	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1072	17	2020-05-16 22:53:11	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1073	17	2020-05-16 22:55:57	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1074	19	2020-05-16 22:56:05	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cnacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1075	19	2020-05-16 23:16:20	192.168.0.4	Usuario sale del sistema	El usuario  cnacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1076	21	2020-05-16 23:16:30	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario tecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1077	21	2020-05-16 23:17:24	192.168.0.4	Usuario sale del sistema	El usuario  tecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1078	19	2020-05-16 23:17:37	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cnacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1079	19	2020-05-16 23:43:23	192.168.0.4	Documento subido/actulizado	Se ha generado docuemnto con id 244	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1080	19	2020-05-16 23:43:37	192.168.0.4	Documento subido/actulizado	Se ha generado docuemnto con id 242	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1081	19	2020-05-16 23:43:55	192.168.0.4	Documento subido/actulizado	Se ha generado docuemnto con id 241	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1082	19	2020-05-16 23:44:14	192.168.0.4	Documento subido/actulizado	Se ha generado docuemnto con id 245	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1083	19	2020-05-16 23:44:31	192.168.0.4	Documento subido/actulizado	Se ha generado docuemnto con id 243	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1084	19	2020-05-22 19:34:50	192.168.0.4	Usuario sale del sistema	El usuario  cnacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1085	17	2020-05-22 19:35:39	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1086	17	2020-05-22 20:55:29	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1087	20	2020-05-22 20:55:41	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1088	20	2020-05-22 22:43:15	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1089	25	2020-05-22 22:43:51	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario ueb_pinar	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1090	25	2020-05-22 22:44:26	192.168.0.4	Demanda creada	Se ha creado una demanda con ID32	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1091	25	2020-05-22 22:44:40	192.168.0.4	Demanda enviada	Se ha enviado la demanda D-2020-003	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1092	25	2020-05-22 22:44:51	192.168.0.4	Usuario sale del sistema	El usuario  ueb_pinar ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1093	23	2020-05-22 22:45:03	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario logistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1094	23	2020-05-22 22:45:29	192.168.0.4	Demanda aceptada	La Demanda D-2020-003 ha sido aceptada	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1095	23	2020-05-22 22:45:38	192.168.0.4	solicitud de compra creada	Se ha creado la solicitud de compra SI-2020-002	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1096	23	2020-05-22 23:15:11	192.168.0.4	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1097	23	2020-05-22 23:15:28	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario logistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1098	23	2020-05-22 23:15:40	192.168.0.4	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1099	15	2020-05-22 23:15:51	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1100	15	2020-05-22 23:16:04	192.168.0.4	solicitud de compra aprobada	Se ha aprobado la solicitud de compra SI-2020-002	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1101	15	2020-05-23 01:37:22	192.168.0.4	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1102	20	2020-05-23 01:37:29	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1103	20	2020-05-23 01:41:34	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1104	18	2020-05-23 01:41:49	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1105	18	2020-05-23 01:44:23	192.168.0.4	Solicitud asignada	Se ha asignado la solicitud SI-2020-002 a Especialista Técncio	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1106	18	2020-05-23 01:45:19	192.168.0.4	Usuario sale del sistema	El usuario  jtecnico ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1107	17	2020-05-23 01:45:34	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1108	17	2020-05-23 01:46:07	192.168.0.4	Solicitud asignada	Se ha asignado la solicitud SI-2020-002 a Comprador Internacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1109	17	2020-05-23 01:54:11	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1110	20	2020-05-23 01:54:18	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1111	20	2020-05-23 21:33:24	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1112	17	2020-05-23 21:33:35	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1113	17	2020-05-23 21:34:38	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1114	19	2020-05-23 21:34:45	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cnacional	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1115	19	2020-05-23 22:15:09	192.168.0.4	Usuario sale del sistema	El usuario  cnacional ha salido del sistema	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1116	2	2020-05-23 22:15:32	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario admin	2020-05-24 03:16:28.435727	2020-05-24 03:16:28.494413
1117	2	2020-05-24 01:02:12	192.168.0.4	Usuario sale del sistema	El usuario  admin ha salido del sistema	2020-05-24 01:02:12	2020-05-24 01:02:12
1118	2	2020-05-24 01:02:18	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario admin	2020-05-24 01:02:18	2020-05-24 01:02:18
1119	2	2020-05-24 01:02:46	192.168.0.4	Usuario sale del sistema	El usuario  admin ha salido del sistema	2020-05-24 01:02:46	2020-05-24 01:02:46
1120	14	2020-05-24 01:03:00	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario ueb	2020-05-24 01:03:00	2020-05-24 01:03:00
1121	14	2020-05-24 01:53:19	192.168.0.4	Actualizar Usuario	Actualizados los datos de ueb.	2020-05-24 01:53:19	2020-05-24 01:53:19
1122	14	2020-05-24 01:53:38	192.168.0.4	Actualizar Usuario	Actualizados los datos de ueb.	2020-05-24 01:53:38	2020-05-24 01:53:38
1123	14	2020-05-24 01:53:59	192.168.0.4	Actualizar Usuario	Actualizados los datos de ueb.	2020-05-24 01:53:59	2020-05-24 01:53:59
1124	14	2020-05-24 01:54:33	192.168.0.4	Actualizar Usuario	Actualizados los datos de ueb.	2020-05-24 01:54:33	2020-05-24 01:54:33
1125	14	2020-05-24 01:54:44	192.168.0.4	Actualizar Usuario	Actualizados los datos de ueb.	2020-05-24 01:54:44	2020-05-24 01:54:44
1126	14	2020-05-24 02:55:15	192.168.0.4	Contraseña cambiada	Cambiada la contraseña de ueb.	2020-05-24 02:55:15	2020-05-24 02:55:15
1127	14	2020-05-24 02:55:32	192.168.0.4	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-05-24 02:55:32	2020-05-24 02:55:32
1128	14	2020-05-24 02:55:48	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario ueb	2020-05-24 02:55:48	2020-05-24 02:55:48
1129	14	2020-05-24 02:56:19	192.168.0.4	Contraseña cambiada	Cambiada la contraseña de ueb.	2020-05-24 02:56:19	2020-05-24 02:56:19
1130	14	2020-05-24 02:56:29	192.168.0.4	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-05-24 02:56:29	2020-05-24 02:56:29
1131	14	2020-05-24 02:56:36	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario ueb	2020-05-24 02:56:36	2020-05-24 02:56:36
1132	14	2020-05-24 02:56:47	192.168.0.4	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-05-24 02:56:47	2020-05-24 02:56:47
1133	14	2020-05-24 02:56:55	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario ueb	2020-05-24 02:56:55	2020-05-24 02:56:55
1134	14	2020-05-24 02:57:19	192.168.0.4	Contraseña cambiada	Cambiada la contraseña de ueb.	2020-05-24 02:57:19	2020-05-24 02:57:19
1135	14	2020-05-24 02:57:40	192.168.0.4	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-05-24 02:57:40	2020-05-24 02:57:40
1136	14	2020-05-24 02:57:48	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario ueb	2020-05-24 02:57:48	2020-05-24 02:57:48
1137	14	2020-05-24 03:00:27	192.168.0.4	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-05-24 03:00:27	2020-05-24 03:00:27
1138	14	2020-05-24 10:04:19	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario ueb	2020-05-24 10:04:19	2020-05-24 10:04:19
1139	14	2020-05-24 10:05:15	192.168.0.4	Demanda creada	Se ha creado una demanda con ID33	2020-05-24 10:05:15	2020-05-24 10:05:15
1140	14	2020-05-24 14:56:48	192.168.0.4	Demanda enviada	Se ha enviado la demanda D-2020-004	2020-05-24 14:56:48	2020-05-24 14:56:48
1141	14	2020-05-24 15:05:06	192.168.0.4	Demanda creada	Se ha creado una demanda con ID34	2020-05-24 15:05:06	2020-05-24 15:05:06
1142	14	2020-05-24 19:50:49	192.168.0.4	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-05-24 19:50:49	2020-05-24 19:50:49
1143	15	2020-05-24 19:50:57	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-24 19:50:57	2020-05-24 19:50:57
1144	15	2020-05-26 23:56:04	192.168.0.4	Demanda rechazada	La Demanda 33 ha sido rechazada	2020-05-26 23:56:04	2020-05-26 23:56:04
1145	15	2020-05-28 17:51:50	192.168.0.4	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-28 17:51:50	2020-05-28 17:51:50
1146	19	2020-05-28 17:52:10	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cnacional	2020-05-28 17:52:10	2020-05-28 17:52:10
1147	19	2020-05-28 18:38:21	192.168.0.4	Usuario sale del sistema	El usuario  cnacional ha salido del sistema	2020-05-28 18:38:21	2020-05-28 18:38:21
1148	17	2020-05-28 18:38:46	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-28 18:38:46	2020-05-28 18:38:46
1149	17	2020-05-28 18:39:05	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-28 18:39:05	2020-05-28 18:39:05
1150	15	2020-05-28 18:39:14	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-28 18:39:14	2020-05-28 18:39:14
1151	2	2020-05-28 23:04:06	192.168.0.4	Actualizar Usuario	Actualizados los datos de logistica.	2020-05-28 23:04:06	2020-05-28 23:04:06
1152	2	2020-05-28 23:04:20	192.168.0.4	Actualizar Usuario	Actualizados los datos de jtecnico.	2020-05-28 23:04:20	2020-05-28 23:04:20
1153	15	2020-05-28 23:29:32	192.168.0.4	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-28 23:29:32	2020-05-28 23:29:32
1154	2	2020-05-28 23:29:41	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario admin	2020-05-28 23:29:41	2020-05-28 23:29:41
1155	2	2020-05-28 23:39:33	192.168.0.4	Actualizar Usuario	Actualizados los datos de jcompras.	2020-05-28 23:39:33	2020-05-28 23:39:33
1156	2	2020-05-28 23:40:34	192.168.0.4	Actualizar Usuario	Actualizados los datos de cinternacional.	2020-05-28 23:40:34	2020-05-28 23:40:34
1157	2	2020-05-28 23:42:15	192.168.0.4	Actualizar Usuario	Actualizados los datos de jcompras.	2020-05-28 23:42:15	2020-05-28 23:42:15
1158	2	2020-05-28 23:43:43	192.168.0.4	Actualizar Usuario	Actualizados los datos de jcompras.	2020-05-28 23:43:43	2020-05-28 23:43:43
1159	2	2020-05-28 23:44:42	192.168.0.4	Actualizar Usuario	Actualizados los datos de jcompras.	2020-05-28 23:44:42	2020-05-28 23:44:42
1160	2	2020-05-30 10:54:39	192.168.0.4	Actualizar Usuario	Actualizados los datos de gol.	2020-05-30 10:54:39	2020-05-30 10:54:39
1161	2	2020-05-30 10:55:01	192.168.0.4	Actualizar Usuario	Actualizados los datos de comite.	2020-05-30 10:55:01	2020-05-30 10:55:01
1162	2	2020-05-30 10:55:44	192.168.0.4	Actualizar Usuario	Actualizados los datos de cnacional.	2020-05-30 10:55:44	2020-05-30 10:55:44
1163	2	2020-05-30 10:57:34	192.168.0.4	Agregar Usuario	Fue añadido el usuario jnacional al sistema.	2020-05-30 10:57:34	2020-05-30 10:57:34
1164	2	2020-05-30 10:57:50	192.168.0.4	Usuario sale del sistema	El usuario  admin ha salido del sistema	2020-05-30 10:57:50	2020-05-30 10:57:50
1165	27	2020-05-30 10:58:00	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jnacional	2020-05-30 10:58:00	2020-05-30 10:58:00
1166	2	2020-05-30 11:02:33	192.168.0.4	Actualizar Usuario	Actualizados los datos de jnacional.	2020-05-30 11:02:33	2020-05-30 11:02:33
1167	2	2020-05-30 11:02:49	192.168.0.4	Actualizar Usuario	Actualizados los datos de jnacional.	2020-05-30 11:02:49	2020-05-30 11:02:49
1168	27	2020-05-30 11:30:32	192.168.0.4	Usuario sale del sistema	El usuario  jnacional ha salido del sistema	2020-05-30 11:30:32	2020-05-30 11:30:32
1169	17	2020-05-30 11:30:53	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-30 11:30:53	2020-05-30 11:30:53
1170	2	2020-05-30 11:31:20	192.168.0.4	Actualizar Usuario	Actualizados los datos de jcompras.	2020-05-30 11:31:20	2020-05-30 11:31:20
1171	17	2020-05-30 11:35:23	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-30 11:35:23	2020-05-30 11:35:23
1172	15	2020-05-30 11:35:30	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-30 11:35:30	2020-05-30 11:35:30
1173	2	2020-05-30 11:43:00	192.168.0.4	Actualizar Usuario	Actualizados los datos de jlogistica.	2020-05-30 11:43:00	2020-05-30 11:43:00
1174	15	2020-05-30 11:43:28	192.168.0.4	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-30 11:43:28	2020-05-30 11:43:28
1175	20	2020-05-30 11:43:36	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-30 11:43:36	2020-05-30 11:43:36
1176	2	2020-05-30 12:17:11	192.168.0.4	Actualizar Usuario	Actualizados los datos de cinternacional.	2020-05-30 12:17:11	2020-05-30 12:17:11
1177	2	2020-05-30 12:28:23	192.168.0.4	Actualizar Usuario	Actualizados los datos de logistica.	2020-05-30 12:28:23	2020-05-30 12:28:23
1178	2	2020-05-30 12:30:46	192.168.0.4	Actualizar Usuario	Actualizados los datos de gol.	2020-05-30 12:30:46	2020-05-30 12:30:46
1179	2	2020-05-30 12:30:58	192.168.0.4	Actualizar Usuario	Actualizados los datos de tecnico.	2020-05-30 12:30:58	2020-05-30 12:30:58
1180	2	2020-05-30 12:31:07	192.168.0.4	Actualizar Usuario	Actualizados los datos de jnacional.	2020-05-30 12:31:07	2020-05-30 12:31:07
1181	2	2020-05-30 12:31:22	192.168.0.4	Actualizar Usuario	Actualizados los datos de cnacional.	2020-05-30 12:31:22	2020-05-30 12:31:22
1182	2	2020-05-30 12:31:32	192.168.0.4	Actualizar Usuario	Actualizados los datos de jnacional.	2020-05-30 12:31:32	2020-05-30 12:31:32
1183	2	2020-05-30 12:31:56	192.168.0.4	Actualizar Usuario	Actualizados los datos de admin.	2020-05-30 12:31:56	2020-05-30 12:31:56
1184	2	2020-05-30 12:38:47	192.168.0.4	Actualizar Usuario	Actualizados los datos de ueb_pinar.	2020-05-30 12:38:47	2020-05-30 12:38:47
1185	2	2020-05-30 12:39:23	192.168.0.4	Actualizar Usuario	Actualizados los datos de tecnico.	2020-05-30 12:39:23	2020-05-30 12:39:23
1186	20	2020-05-30 13:01:24	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-05-30 13:01:24	2020-05-30 13:01:24
1187	23	2020-05-30 13:01:55	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario logistica	2020-05-30 13:01:55	2020-05-30 13:01:55
1188	23	2020-05-30 13:21:16	192.168.0.4	Demanda creada	Se ha creado una demanda con ID35	2020-05-30 13:21:16	2020-05-30 13:21:16
1189	23	2020-05-30 13:23:20	192.168.0.4	Demanda enviada	Se ha enviado la demanda D-2020-005	2020-05-30 13:23:20	2020-05-30 13:23:20
1190	23	2020-05-30 13:23:41	192.168.0.4	Demanda aceptada	La Demanda D-2020-005 ha sido aceptada	2020-05-30 13:23:41	2020-05-30 13:23:41
1191	23	2020-05-30 13:24:04	192.168.0.4	solicitud de compra creada	Se ha creado la solicitud de compra SN-2020-002	2020-05-30 13:24:04	2020-05-30 13:24:04
1192	23	2020-05-30 13:25:06	192.168.0.4	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-05-30 13:25:06	2020-05-30 13:25:06
1193	15	2020-05-30 13:25:14	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-05-30 13:25:14	2020-05-30 13:25:14
1194	15	2020-05-30 22:16:06	192.168.0.4	solicitud de compra aprobada	Se ha aprobado la solicitud de compra SN-2020-002-gav-01	2020-05-30 22:16:06	2020-05-30 22:16:06
1195	15	2020-05-30 22:16:35	192.168.0.4	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-05-30 22:16:35	2020-05-30 22:16:35
1196	17	2020-05-30 22:16:43	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-30 22:16:43	2020-05-30 22:16:43
1197	2	2020-05-30 22:17:15	192.168.0.4	Actualizar Usuario	Actualizados los datos de jcompras.	2020-05-30 22:17:15	2020-05-30 22:17:15
1198	2	2020-05-30 22:25:33	192.168.0.4	Agregar Usuario	Fue añadido el usuario c711 al sistema.	2020-05-30 22:25:33	2020-05-30 22:25:33
1199	17	2020-05-30 22:27:23	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-30 22:27:23	2020-05-30 22:27:23
1200	17	2020-05-30 22:27:29	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-30 22:27:29	2020-05-30 22:27:29
1201	17	2020-05-30 22:29:08	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-30 22:29:08	2020-05-30 22:29:08
1202	18	2020-05-30 22:29:25	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-05-30 22:29:25	2020-05-30 22:29:25
1203	2	2020-05-30 22:29:52	192.168.0.4	Actualizar Usuario	Actualizados los datos de jtecnico.	2020-05-30 22:29:52	2020-05-30 22:29:52
1204	2	2020-05-30 22:37:19	192.168.0.4	Actualizar Usuario	Actualizados los datos de tecnico.	2020-05-30 22:37:19	2020-05-30 22:37:19
1205	2	2020-05-30 22:40:30	192.168.0.4	Actualizar Usuario	Actualizados los datos de tecnico.	2020-05-30 22:40:30	2020-05-30 22:40:30
1206	18	2020-05-30 22:40:43	192.168.0.4	Solicitud asignada	Se ha asignado la solicitud SN-2020-002-gav-01 a Especialista Técncio	2020-05-30 22:40:43	2020-05-30 22:40:43
1207	18	2020-05-30 22:41:02	192.168.0.4	Usuario sale del sistema	El usuario  jtecnico ha salido del sistema	2020-05-30 22:41:02	2020-05-30 22:41:02
1208	17	2020-05-30 22:41:14	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-05-30 22:41:14	2020-05-30 22:41:14
1209	17	2020-05-30 22:41:31	192.168.0.4	Solicitud asignada	Se ha asignado la solicitud SN-2020-002-gav-01 a Comprador 711	2020-05-30 22:41:31	2020-05-30 22:41:31
1210	17	2020-05-30 22:41:54	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-05-30 22:41:54	2020-05-30 22:41:54
1211	28	2020-05-30 22:42:06	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario c711	2020-05-30 22:42:06	2020-05-30 22:42:06
1212	28	2020-05-30 22:43:32	192.168.0.4	Documento subido/actulizado	Se ha generado docuemnto con id 246	2020-05-30 22:43:32	2020-05-30 22:43:32
1213	2	2020-05-30 23:08:38	192.168.0.4	Rol eilminado	El Rol comprador_nacional ha sido eliminado	2020-05-30 23:08:38	2020-05-30 23:08:38
1214	2	2020-05-30 23:09:12	192.168.0.4	Rol eilminado	El Rol comprador_internacional ha sido eliminado	2020-05-30 23:09:12	2020-05-30 23:09:12
1215	2	2020-05-30 23:09:22	192.168.0.4	Rol eilminado	El Rol esp_gol ha sido eliminado	2020-05-30 23:09:22	2020-05-30 23:09:22
1216	2	2020-05-30 23:10:06	192.168.0.4	Rol creado	El Rol buyer ha sido creado.	2020-05-30 23:10:06	2020-05-30 23:10:06
1217	2	2020-05-30 23:10:52	192.168.0.4	Actualizar Usuario	Actualizados los datos de cinternacional.	2020-05-30 23:10:52	2020-05-30 23:10:52
1218	2	2020-05-30 23:11:23	192.168.0.4	Actualizar Usuario	Actualizados los datos de cnacional.	2020-05-30 23:11:23	2020-05-30 23:11:23
1219	2	2020-05-30 23:11:41	192.168.0.4	Actualizar Usuario	Actualizados los datos de c711.	2020-05-30 23:11:41	2020-05-30 23:11:41
1220	28	2020-05-30 23:12:19	192.168.0.4	Usuario sale del sistema	El usuario  c711 ha salido del sistema	2020-05-30 23:12:19	2020-05-30 23:12:19
1221	20	2020-05-30 23:12:40	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-05-30 23:12:40	2020-05-30 23:12:40
1222	2	2020-05-30 23:29:40	192.168.0.4	Actualizar Usuario	Actualizados los datos de cinternacional.	2020-05-30 23:29:40	2020-05-30 23:29:40
1223	2	2020-05-30 23:34:07	192.168.0.4	Actualizar Usuario	Actualizados los datos de cinternacional.	2020-05-30 23:34:07	2020-05-30 23:34:07
1224	25	2020-06-04 10:44:16	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario ueb_pinar	2020-06-04 10:44:16	2020-06-04 10:44:16
1225	25	2020-06-04 10:44:51	192.168.0.4	Demanda creada	Se ha creado una demanda con ID36	2020-06-04 10:44:51	2020-06-04 10:44:51
1226	25	2020-06-04 10:45:14	192.168.0.4	Demanda enviada	Se ha enviado la demanda D-2020-006	2020-06-04 10:45:14	2020-06-04 10:45:14
1227	25	2020-06-04 10:55:58	192.168.0.4	Demanda creada	Se ha creado una demanda con ID37	2020-06-04 10:55:58	2020-06-04 10:55:58
1228	25	2020-06-04 10:56:24	192.168.0.4	Demanda enviada	Se ha enviado la demanda D-2020-007	2020-06-04 10:56:24	2020-06-04 10:56:24
1229	2	2020-06-04 10:58:49	192.168.0.4	Actualizar Usuario	Actualizados los datos de ueb_pinar.	2020-06-04 10:58:49	2020-06-04 10:58:49
1230	2	2020-06-04 10:59:44	192.168.0.4	Actualizar Usuario	Actualizados los datos de logistica.	2020-06-04 10:59:44	2020-06-04 10:59:44
1231	2	2020-06-04 10:59:58	192.168.0.4	Actualizar Usuario	Actualizados los datos de logistica.	2020-06-04 10:59:58	2020-06-04 10:59:58
1232	25	2020-06-04 11:00:59	192.168.0.4	Demanda creada	Se ha creado una demanda con ID38	2020-06-04 11:00:59	2020-06-04 11:00:59
1233	25	2020-06-04 11:01:17	192.168.0.4	Demanda enviada	Se ha enviado la demanda D-2020-008	2020-06-04 11:01:17	2020-06-04 11:01:17
1234	25	2020-06-04 11:03:54	192.168.0.4	Demanda enviada	Se ha enviado la demanda D-2020-008	2020-06-04 11:03:54	2020-06-04 11:03:54
1235	2	2020-06-04 11:06:32	192.168.0.4	Actualizar Usuario	Actualizados los datos de jcompras.	2020-06-04 11:06:32	2020-06-04 11:06:32
1236	2	2020-06-04 11:07:01	192.168.0.4	Actualizar Usuario	Actualizados los datos de jcompras.	2020-06-04 11:07:01	2020-06-04 11:07:01
1237	25	2020-06-04 11:08:15	192.168.0.4	Demanda enviada	Se ha enviado la demanda D-2020-008	2020-06-04 11:08:15	2020-06-04 11:08:15
1238	25	2020-06-04 11:11:07	192.168.0.4	Demanda enviada	Se ha enviado la demanda D-2020-008	2020-06-04 11:11:07	2020-06-04 11:11:07
1239	2	2020-06-04 11:13:04	192.168.0.4	Actualizar Usuario	Actualizados los datos de gol.	2020-06-04 11:13:04	2020-06-04 11:13:04
1240	25	2020-06-04 11:13:28	192.168.0.4	Demanda enviada	Se ha enviado la demanda D-2020-008	2020-06-04 11:13:28	2020-06-04 11:13:28
1241	25	2020-06-04 11:14:28	192.168.0.4	Usuario sale del sistema	El usuario  ueb_pinar ha salido del sistema	2020-06-04 11:14:28	2020-06-04 11:14:28
1242	23	2020-06-04 11:14:45	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario logistica	2020-06-04 11:14:45	2020-06-04 11:14:45
1243	23	2020-06-04 11:15:28	192.168.0.4	solicitud de compra creada	Se ha creado la solicitud de compra SN-2020-002	2020-06-04 11:15:28	2020-06-04 11:15:28
1244	23	2020-06-04 11:15:28	192.168.0.4	Demanda aceptada	La Demanda D-2020-006 ha sido aceptada	2020-06-04 11:15:28	2020-06-04 11:15:28
1245	23	2020-06-04 11:17:30	192.168.0.4	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-06-04 11:17:30	2020-06-04 11:17:30
1246	15	2020-06-04 11:17:41	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-06-04 11:17:41	2020-06-04 11:17:41
1247	15	2020-06-04 11:19:55	192.168.0.4	solicitud de compra aprobada	Se ha aprobado la solicitud de compra SN-2020-002	2020-06-04 11:19:54	2020-06-04 11:19:54
1248	15	2020-06-04 11:20:07	192.168.0.4	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-06-04 11:20:07	2020-06-04 11:20:07
1249	17	2020-06-04 11:20:17	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-06-04 11:20:17	2020-06-04 11:20:17
1250	17	2020-06-04 11:20:52	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-06-04 11:20:52	2020-06-04 11:20:52
1251	18	2020-06-04 11:20:59	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-06-04 11:20:59	2020-06-04 11:20:59
1252	18	2020-06-04 11:21:23	192.168.0.4	Solicitud asignada	Se ha asignado la solicitud SN-2020-002 a Especialista Técncio	2020-06-04 11:21:23	2020-06-04 11:21:23
1253	18	2020-06-04 11:22:03	192.168.0.4	Usuario sale del sistema	El usuario  jtecnico ha salido del sistema	2020-06-04 11:22:03	2020-06-04 11:22:03
1254	17	2020-06-04 11:22:15	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-06-04 11:22:15	2020-06-04 11:22:15
1255	17	2020-06-04 11:22:39	192.168.0.4	Solicitud asignada	Se ha asignado la solicitud SN-2020-002 a Comprador Nacional	2020-06-04 11:22:39	2020-06-04 11:22:39
1256	17	2020-06-04 11:22:57	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-06-04 11:22:57	2020-06-04 11:22:57
1257	19	2020-06-04 11:23:05	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cnacional	2020-06-04 11:23:05	2020-06-04 11:23:05
1258	19	2020-06-04 11:29:19	192.168.0.4	Usuario sale del sistema	El usuario  cnacional ha salido del sistema	2020-06-04 11:29:19	2020-06-04 11:29:19
1259	21	2020-06-04 11:29:30	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario tecnico	2020-06-04 11:29:30	2020-06-04 11:29:30
1260	21	2020-06-04 11:31:43	192.168.0.4	Usuario sale del sistema	El usuario  tecnico ha salido del sistema	2020-06-04 11:31:43	2020-06-04 11:31:43
1261	19	2020-06-04 11:31:55	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cnacional	2020-06-04 11:31:55	2020-06-04 11:31:55
1262	19	2020-06-04 11:33:17	192.168.0.4	Documento subido/actulizado	Se ha generado docuemnto con id 248	2020-06-04 11:33:17	2020-06-04 11:33:17
1263	19	2020-06-04 11:34:43	192.168.0.4	Documento subido/actulizado	Se ha generado docuemnto con id 248	2020-06-04 11:34:43	2020-06-04 11:34:43
1264	19	2020-06-04 11:34:58	192.168.0.4	Documento subido/actulizado	Se ha generado docuemnto con id 249	2020-06-04 11:34:58	2020-06-04 11:34:58
1265	19	2020-06-04 11:35:13	192.168.0.4	Documento subido/actulizado	Se ha generado docuemnto con id 250	2020-06-04 11:35:13	2020-06-04 11:35:13
1266	19	2020-06-04 11:35:28	192.168.0.4	Documento subido/actulizado	Se ha generado docuemnto con id 251	2020-06-04 11:35:28	2020-06-04 11:35:28
1267	19	2020-06-04 11:35:42	192.168.0.4	Documento subido/actulizado	Se ha generado docuemnto con id 252	2020-06-04 11:35:42	2020-06-04 11:35:42
1268	19	2020-06-04 11:38:44	192.168.0.4	Orden cerrada	La orden SN-2020-002 ha sido cerrada	2020-06-04 11:38:44	2020-06-04 11:38:44
1269	19	2020-06-04 11:50:10	192.168.0.4	Usuario sale del sistema	El usuario  cnacional ha salido del sistema	2020-06-04 11:50:10	2020-06-04 11:50:10
1270	23	2020-06-04 11:50:23	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario logistica	2020-06-04 11:50:23	2020-06-04 11:50:23
1271	23	2020-06-04 11:50:40	192.168.0.4	Demanda aceptada	La Demanda D-2020-007 ha sido aceptada	2020-06-04 11:50:40	2020-06-04 11:50:40
1272	23	2020-06-04 11:50:49	192.168.0.4	solicitud de compra creada	Se ha creado la solicitud de compra SN-2020-003	2020-06-04 11:50:49	2020-06-04 11:50:49
1273	23	2020-06-04 11:51:40	192.168.0.4	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-06-04 11:51:40	2020-06-04 11:51:40
1274	15	2020-06-04 11:51:58	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-06-04 11:51:58	2020-06-04 11:51:58
1275	15	2020-06-04 11:52:22	192.168.0.4	solicitud de compra aprobada	Se ha aprobado la solicitud de compra SN-2020-003-gae-01	2020-06-04 11:52:22	2020-06-04 11:52:22
1276	15	2020-06-04 11:52:50	192.168.0.4	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-06-04 11:52:50	2020-06-04 11:52:50
1277	18	2020-06-04 11:53:01	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-06-04 11:53:01	2020-06-04 11:53:01
1278	18	2020-06-04 11:53:18	192.168.0.4	Solicitud asignada	Se ha asignado la solicitud SN-2020-003-gae-01 a Especialista Técncio	2020-06-04 11:53:18	2020-06-04 11:53:18
1279	18	2020-06-04 11:53:53	192.168.0.4	Usuario sale del sistema	El usuario  jtecnico ha salido del sistema	2020-06-04 11:53:53	2020-06-04 11:53:53
1280	17	2020-06-04 11:54:02	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-06-04 11:54:02	2020-06-04 11:54:02
1281	17	2020-06-04 11:54:16	192.168.0.4	Solicitud asignada	Se ha asignado la solicitud SN-2020-003-gae-01 a Comprador 711	2020-06-04 11:54:16	2020-06-04 11:54:16
1282	17	2020-06-04 11:54:33	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-06-04 11:54:33	2020-06-04 11:54:33
1283	28	2020-06-04 11:54:43	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario c711	2020-06-04 11:54:43	2020-06-04 11:54:43
1284	28	2020-06-04 11:55:54	192.168.0.4	Documento subido/actulizado	Se ha generado docuemnto con id 253	2020-06-04 11:55:54	2020-06-04 11:55:54
1285	28	2020-06-04 11:57:36	192.168.0.4	Orden cerrada	La orden SN-2020-003-gae-01 ha sido cerrada	2020-06-04 11:57:36	2020-06-04 11:57:36
1286	2	2020-06-04 13:39:31	192.168.43.254	Usuario sale del sistema	El usuario  admin ha salido del sistema	2020-06-04 13:39:30	2020-06-04 13:39:30
1287	25	2020-06-04 13:41:04	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario ueb_pinar	2020-06-04 13:41:04	2020-06-04 13:41:04
1288	25	2020-06-04 13:47:51	192.168.43.254	Demanda creada	Se ha creado una demanda con ID39	2020-06-04 13:47:51	2020-06-04 13:47:51
1289	25	2020-06-04 13:54:49	192.168.43.254	Demanda enviada	Se ha enviado la demanda D-2020-009	2020-06-04 13:54:49	2020-06-04 13:54:49
1290	25	2020-06-04 13:55:06	192.168.43.254	Usuario sale del sistema	El usuario  ueb_pinar ha salido del sistema	2020-06-04 13:55:06	2020-06-04 13:55:06
1291	2	2020-06-04 13:55:59	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario admin	2020-06-04 13:55:59	2020-06-04 13:55:59
1292	2	2020-06-04 13:59:25	192.168.43.254	Usuario sale del sistema	El usuario  admin ha salido del sistema	2020-06-04 13:59:25	2020-06-04 13:59:25
1293	23	2020-06-04 14:00:26	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario logistica	2020-06-04 14:00:26	2020-06-04 14:00:26
1294	23	2020-06-04 14:03:51	192.168.43.254	Demanda aceptada	La Demanda D-2020-009 ha sido aceptada	2020-06-04 14:03:51	2020-06-04 14:03:51
1295	23	2020-06-04 14:12:17	192.168.43.254	solicitud de compra creada	Se ha creado la solicitud de compra SI-2020-003	2020-06-04 14:12:17	2020-06-04 14:12:17
1296	23	2020-06-04 14:14:04	192.168.43.254	Demanda aceptada	La Demanda D-2020-008 ha sido aceptada	2020-06-04 14:14:04	2020-06-04 14:14:04
1297	23	2020-06-04 14:15:16	192.168.43.254	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-06-04 14:15:16	2020-06-04 14:15:16
1298	15	2020-06-04 14:15:49	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-06-04 14:15:48	2020-06-04 14:15:48
1299	15	2020-06-04 14:20:27	192.168.43.254	solicitud de compra aprobada	Se ha aprobado la solicitud de compra SI-2020-003	2020-06-04 14:20:27	2020-06-04 14:20:27
1300	15	2020-06-04 14:27:28	192.168.43.254	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-06-04 14:27:28	2020-06-04 14:27:28
1301	2	2020-06-04 14:28:11	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario admin	2020-06-04 14:28:11	2020-06-04 14:28:11
1302	2	2020-06-04 14:28:26	192.168.43.254	Usuario sale del sistema	El usuario  admin ha salido del sistema	2020-06-04 14:28:26	2020-06-04 14:28:26
1303	18	2020-06-04 14:28:36	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-06-04 14:28:36	2020-06-04 14:28:36
1304	18	2020-06-04 14:32:01	192.168.43.254	Solicitud asignada	Se ha asignado la solicitud SI-2020-003 a Especialista Técncio	2020-06-04 14:32:01	2020-06-04 14:32:01
1305	18	2020-06-04 14:34:33	192.168.43.254	Usuario sale del sistema	El usuario  jtecnico ha salido del sistema	2020-06-04 14:34:33	2020-06-04 14:34:33
1306	17	2020-06-04 14:34:43	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-06-04 14:34:43	2020-06-04 14:34:43
1307	17	2020-06-04 14:35:31	192.168.43.254	Solicitud asignada	Se ha asignado la solicitud SI-2020-003 a Comprador Internacional	2020-06-04 14:35:31	2020-06-04 14:35:31
1308	17	2020-06-04 14:36:27	192.168.43.254	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-06-04 14:36:27	2020-06-04 14:36:27
1309	20	2020-06-04 14:36:38	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-06-04 14:36:38	2020-06-04 14:36:38
1310	20	2020-06-04 14:41:32	192.168.43.254	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-06-04 14:41:32	2020-06-04 14:41:32
1311	21	2020-06-04 14:41:47	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario tecnico	2020-06-04 14:41:47	2020-06-04 14:41:47
1312	21	2020-06-04 14:46:39	192.168.43.254	Usuario sale del sistema	El usuario  tecnico ha salido del sistema	2020-06-04 14:46:39	2020-06-04 14:46:39
1313	20	2020-06-04 14:46:57	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-06-04 14:46:57	2020-06-04 14:46:57
1314	20	2020-06-04 14:48:19	192.168.43.254	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-06-04 14:48:19	2020-06-04 14:48:19
1315	24	2020-06-04 14:48:39	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario comite	2020-06-04 14:48:39	2020-06-04 14:48:39
1316	24	2020-06-04 14:50:02	192.168.43.254	Documento subido/actulizado	Se ha generado docuemnto con id 255	2020-06-04 14:50:02	2020-06-04 14:50:02
1317	24	2020-06-04 14:50:19	192.168.43.254	Documento subido/actulizado	Se ha generado docuemnto con id 254	2020-06-04 14:50:19	2020-06-04 14:50:19
1318	24	2020-06-04 14:50:36	192.168.43.254	Documento subido/actulizado	Se ha generado docuemnto con id 258	2020-06-04 14:50:36	2020-06-04 14:50:36
1319	24	2020-06-04 14:50:53	192.168.43.254	Documento subido/actulizado	Se ha generado docuemnto con id 257	2020-06-04 14:50:53	2020-06-04 14:50:53
1320	24	2020-06-04 14:51:16	192.168.43.254	Documento subido/actulizado	Se ha generado docuemnto con id 264	2020-06-04 14:51:16	2020-06-04 14:51:16
1321	24	2020-06-04 14:51:33	192.168.43.254	Documento subido/actulizado	Se ha generado docuemnto con id 256	2020-06-04 14:51:33	2020-06-04 14:51:33
1322	24	2020-06-04 14:51:49	192.168.43.254	Documento subido/actulizado	Se ha generado docuemnto con id 260	2020-06-04 14:51:49	2020-06-04 14:51:49
1323	24	2020-06-04 14:52:11	192.168.43.254	Documento subido/actulizado	Se ha generado docuemnto con id 262	2020-06-04 14:52:11	2020-06-04 14:52:11
1324	24	2020-06-04 14:52:23	192.168.43.254	Usuario sale del sistema	El usuario  comite ha salido del sistema	2020-06-04 14:52:23	2020-06-04 14:52:23
1325	20	2020-06-04 14:52:39	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-06-04 14:52:39	2020-06-04 14:52:39
1326	20	2020-06-04 14:59:57	192.168.43.254	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-06-04 14:59:57	2020-06-04 14:59:57
1327	17	2020-06-04 15:00:10	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-06-04 15:00:10	2020-06-04 15:00:10
1328	17	2020-06-04 15:00:20	192.168.43.254	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-06-04 15:00:20	2020-06-04 15:00:20
1329	15	2020-06-04 15:00:31	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-06-04 15:00:31	2020-06-04 15:00:31
1359	20	2020-06-05 22:28:40	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-06-05 22:28:40	2020-06-05 22:28:40
1360	15	2020-06-05 22:28:56	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-06-05 22:28:56	2020-06-05 22:28:56
1361	15	2020-06-07 15:35:21	192.168.0.4	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-06-07 15:35:21	2020-06-07 15:35:21
1362	2	2020-06-07 15:35:51	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario admin	2020-06-07 15:35:51	2020-06-07 15:35:51
1363	15	2020-06-07 20:38:56	192.168.0.10	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-06-07 20:38:56	2020-06-07 20:38:56
1364	15	2020-06-07 23:23:11	192.168.0.10	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-06-07 23:23:11	2020-06-07 23:23:11
1365	2	2020-06-07 23:23:20	192.168.0.10	Usuario autenticado	Se ha autenticado el usuario admin	2020-06-07 23:23:20	2020-06-07 23:23:20
1366	2	2020-06-09 15:10:57	192.168.43.254	Usuario sale del sistema	El usuario  admin ha salido del sistema	2020-06-09 15:10:57	2020-06-09 15:10:57
1367	14	2020-06-09 15:11:14	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario ueb	2020-06-09 15:11:14	2020-06-09 15:11:14
1368	14	2020-06-09 15:22:59	192.168.43.254	Demanda creada	Se ha creado una demanda con ID40	2020-06-09 15:22:59	2020-06-09 15:22:59
1369	14	2020-06-09 15:41:13	192.168.43.254	Demanda enviada	Se ha enviado la demanda D-2020-010	2020-06-09 15:41:13	2020-06-09 15:41:13
1370	14	2020-06-09 15:41:31	192.168.43.254	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-06-09 15:41:31	2020-06-09 15:41:31
1371	23	2020-06-09 15:41:45	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario logistica	2020-06-09 15:41:45	2020-06-09 15:41:45
1372	23	2020-06-09 15:43:59	192.168.43.254	Demanda aceptada	La Demanda D-2020-010 ha sido aceptada	2020-06-09 15:43:59	2020-06-09 15:43:59
1373	23	2020-06-09 15:46:56	192.168.43.254	Item cancelado	El item Adaptador Hembra 1" (CAM x ROS) (2) fue rechazado.	2020-06-09 15:46:56	2020-06-09 15:46:56
1374	23	2020-06-09 15:52:58	192.168.43.254	solicitud de compra creada	Se ha creado la solicitud de compra SI-2020-004	2020-06-09 15:52:58	2020-06-09 15:52:58
1375	23	2020-06-09 15:56:01	192.168.43.254	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-06-09 15:56:01	2020-06-09 15:56:01
1376	15	2020-06-09 15:56:11	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-06-09 15:56:11	2020-06-09 15:56:11
1377	15	2020-06-09 16:01:01	192.168.43.254	solicitud de compra aprobada	Se ha aprobado la solicitud de compra SI-2020-004	2020-06-09 16:01:01	2020-06-09 16:01:01
1378	15	2020-06-09 16:01:14	192.168.43.254	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-06-09 16:01:14	2020-06-09 16:01:14
1379	18	2020-06-09 16:01:29	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario jtecnico	2020-06-09 16:01:29	2020-06-09 16:01:29
1380	18	2020-06-09 16:11:13	192.168.43.254	Solicitud asignada	Se ha asignado la solicitud SI-2020-004 a Especialista Técncio	2020-06-09 16:11:13	2020-06-09 16:11:13
1381	18	2020-06-09 16:11:31	192.168.43.254	Usuario sale del sistema	El usuario  jtecnico ha salido del sistema	2020-06-09 16:11:31	2020-06-09 16:11:31
1382	17	2020-06-09 16:11:42	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-06-09 16:11:42	2020-06-09 16:11:42
1383	17	2020-06-09 16:12:29	192.168.43.254	Solicitud asignada	Se ha asignado la solicitud SI-2020-004 a Comprador Internacional	2020-06-09 16:12:29	2020-06-09 16:12:29
1384	17	2020-06-09 16:13:43	192.168.43.254	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-06-09 16:13:43	2020-06-09 16:13:43
1385	20	2020-06-09 16:13:56	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-06-09 16:13:56	2020-06-09 16:13:56
1386	20	2020-06-09 16:45:45	192.168.43.254	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-06-09 16:45:45	2020-06-09 16:45:45
1387	17	2020-06-09 16:46:13	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-06-09 16:46:13	2020-06-09 16:46:13
1388	17	2020-06-09 16:46:30	192.168.43.254	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-06-09 16:46:30	2020-06-09 16:46:30
1389	21	2020-06-09 16:46:38	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario tecnico	2020-06-09 16:46:38	2020-06-09 16:46:38
1390	20	2020-06-09 16:47:22	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-06-09 16:47:22	2020-06-09 16:47:22
1391	20	2020-06-09 16:49:23	192.168.43.254	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-06-09 16:49:23	2020-06-09 16:49:23
1392	21	2020-06-09 16:49:52	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario tecnico	2020-06-09 16:49:52	2020-06-09 16:49:52
1393	21	2020-06-09 17:00:46	192.168.43.254	Usuario sale del sistema	El usuario  tecnico ha salido del sistema	2020-06-09 17:00:46	2020-06-09 17:00:46
1394	20	2020-06-09 17:00:56	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-06-09 17:00:56	2020-06-09 17:00:56
1395	21	2020-06-09 17:06:57	192.168.43.254	Usuario sale del sistema	El usuario  tecnico ha salido del sistema	2020-06-09 17:06:57	2020-06-09 17:06:57
1396	24	2020-06-09 17:07:12	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario comite	2020-06-09 17:07:12	2020-06-09 17:07:12
1397	24	2020-06-09 17:07:50	192.168.43.254	Documento subido/actulizado	Se ha generado docuemnto con id 266	2020-06-09 17:07:50	2020-06-09 17:07:50
1398	24	2020-06-09 17:08:05	192.168.43.254	Documento subido/actulizado	Se ha generado docuemnto con id 265	2020-06-09 17:08:05	2020-06-09 17:08:05
1399	24	2020-06-09 17:08:42	192.168.43.254	Documento subido/actulizado	Se ha generado docuemnto con id 269	2020-06-09 17:08:42	2020-06-09 17:08:42
1400	24	2020-06-09 17:09:05	192.168.43.254	Documento subido/actulizado	Se ha generado docuemnto con id 268	2020-06-09 17:09:05	2020-06-09 17:09:05
1401	24	2020-06-09 17:09:28	192.168.43.254	Documento subido/actulizado	Se ha generado docuemnto con id 275	2020-06-09 17:09:28	2020-06-09 17:09:28
1402	24	2020-06-09 17:09:47	192.168.43.254	Documento subido/actulizado	Se ha generado docuemnto con id 267	2020-06-09 17:09:47	2020-06-09 17:09:47
1403	24	2020-06-09 17:10:02	192.168.43.254	Documento subido/actulizado	Se ha generado docuemnto con id 271	2020-06-09 17:10:02	2020-06-09 17:10:02
1404	24	2020-06-09 17:10:18	192.168.43.254	Documento subido/actulizado	Se ha generado docuemnto con id 273	2020-06-09 17:10:18	2020-06-09 17:10:18
1405	24	2020-06-10 16:37:38	192.168.43.254	Usuario sale del sistema	El usuario  comite ha salido del sistema	2020-06-10 16:37:38	2020-06-10 16:37:38
1406	14	2020-06-10 16:48:14	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario ueb	2020-06-10 16:48:14	2020-06-10 16:48:14
1407	14	2020-06-10 16:48:32	192.168.43.254	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-06-10 16:48:32	2020-06-10 16:48:32
1408	2	2020-06-10 16:48:45	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario admin	2020-06-10 16:48:45	2020-06-10 16:48:45
1409	2	2020-06-10 16:51:56	192.168.43.254	Usuario desactivado	El usuario gol fue desactivado.	2020-06-10 16:51:56	2020-06-10 16:51:56
1410	2	2020-06-10 16:54:45	192.168.43.254	Usuario sale del sistema	El usuario  admin ha salido del sistema	2020-06-10 16:54:45	2020-06-10 16:54:45
1411	14	2020-06-10 16:55:24	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario ueb	2020-06-10 16:55:24	2020-06-10 16:55:24
1412	14	2020-06-10 17:41:33	192.168.43.254	Demanda enviada	Se ha enviado la demanda D-2020-011	2020-06-10 17:41:33	2020-06-10 17:41:33
1413	14	2020-06-10 17:42:01	192.168.43.254	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-06-10 17:42:01	2020-06-10 17:42:01
1414	23	2020-06-10 17:42:16	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario logistica	2020-06-10 17:42:16	2020-06-10 17:42:16
1415	23	2020-06-10 17:46:43	192.168.43.254	Demanda aceptada	La Demanda D-2020-011 ha sido aceptada	2020-06-10 17:46:43	2020-06-10 17:46:43
1416	23	2020-06-10 17:49:37	192.168.43.254	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-06-10 17:49:37	2020-06-10 17:49:37
1417	15	2020-06-10 17:50:13	192.168.43.254	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-06-10 17:50:13	2020-06-10 17:50:13
1418	2	2020-06-13 15:26:49	192.168.0.10	Usuario sale del sistema	El usuario  admin ha salido del sistema	2020-06-13 15:26:49	2020-06-13 15:26:49
1419	23	2020-06-13 15:27:05	192.168.0.10	Usuario autenticado	Se ha autenticado el usuario logistica	2020-06-13 15:27:05	2020-06-13 15:27:05
1420	2	2020-06-13 15:41:11	192.168.0.10	Usuario autenticado	Se ha autenticado el usuario admin	2020-06-13 15:41:11	2020-06-13 15:41:11
1421	15	2020-06-13 15:56:32	192.168.0.4	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-06-13 15:56:32	2020-06-13 15:56:32
1422	23	2020-06-13 15:56:45	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario logistica	2020-06-13 15:56:45	2020-06-13 15:56:45
1423	23	2020-06-13 17:29:37	192.168.0.10	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-06-13 17:29:37	2020-06-13 17:29:37
1424	15	2020-06-13 17:29:52	192.168.0.10	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-06-13 17:29:52	2020-06-13 17:29:52
1425	15	2020-06-13 17:41:59	192.168.0.10	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-06-13 17:41:59	2020-06-13 17:41:59
1426	15	2020-06-13 17:42:48	192.168.0.10	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-06-13 17:42:48	2020-06-13 17:42:48
1427	15	2020-06-13 17:44:17	192.168.0.10	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-06-13 17:44:17	2020-06-13 17:44:17
1428	15	2020-06-13 17:44:42	192.168.0.10	Usuario autenticado	Se ha autenticado el usuario jlogistica	2020-06-13 17:44:42	2020-06-13 17:44:42
1429	15	2020-06-13 17:44:53	192.168.0.10	Usuario sale del sistema	El usuario  jlogistica ha salido del sistema	2020-06-13 17:44:53	2020-06-13 17:44:53
1430	23	2020-06-13 17:47:59	192.168.0.10	Usuario autenticado	Se ha autenticado el usuario logistica	2020-06-13 17:47:59	2020-06-13 17:47:59
1431	23	2020-06-13 18:13:59	192.168.0.10	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-06-13 18:13:59	2020-06-13 18:13:59
1432	23	2020-06-13 18:15:30	192.168.0.10	Usuario autenticado	Se ha autenticado el usuario logistica	2020-06-13 18:15:30	2020-06-13 18:15:30
1433	23	2020-07-05 15:05:48	192.168.0.4	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-07-05 15:05:48	2020-07-05 15:05:48
1434	2	2020-07-05 15:06:03	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario admin	2020-07-05 15:06:03	2020-07-05 15:06:03
1435	2	2020-07-05 15:08:48	192.168.0.4	Usuario sale del sistema	El usuario  admin ha salido del sistema	2020-07-05 15:08:48	2020-07-05 15:08:48
1436	20	2020-07-05 15:11:14	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2020-07-05 15:11:13	2020-07-05 15:11:13
1437	20	2264-01-28 08:11:29	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario cinternacional	2264-01-28 08:11:29	2264-01-28 08:11:29
1470	20	2020-07-05 21:23:54	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-07-05 21:23:54	2020-07-05 21:23:54
1471	17	2020-07-05 21:24:09	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-07-05 21:24:09	2020-07-05 21:24:09
1472	17	2020-07-05 22:15:17	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-07-05 22:15:17	2020-07-05 22:15:17
1473	21	2020-07-05 22:15:36	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario tecnico	2020-07-05 22:15:36	2020-07-05 22:15:36
1474	21	2020-07-05 22:20:35	192.168.0.4	Usuario sale del sistema	El usuario  tecnico ha salido del sistema	2020-07-05 22:20:35	2020-07-05 22:20:35
1475	24	2020-07-05 22:26:09	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario comite	2020-07-05 22:26:09	2020-07-05 22:26:09
1476	24	2020-07-05 22:26:40	192.168.0.4	Documento subido/actulizado	Se ha generado docuemnto con id 277	2020-07-05 22:26:40	2020-07-05 22:26:40
1477	24	2020-07-05 22:27:01	192.168.0.4	Documento subido/actulizado	Se ha generado docuemnto con id 276	2020-07-05 22:27:01	2020-07-05 22:27:01
1478	24	2020-07-05 22:27:24	192.168.0.4	Documento subido/actulizado	Se ha generado docuemnto con id 280	2020-07-05 22:27:24	2020-07-05 22:27:24
1479	24	2020-07-05 22:27:44	192.168.0.4	Documento subido/actulizado	Se ha generado docuemnto con id 279	2020-07-05 22:27:44	2020-07-05 22:27:44
1480	24	2020-07-05 22:28:03	192.168.0.4	Documento subido/actulizado	Se ha generado docuemnto con id 286	2020-07-05 22:28:03	2020-07-05 22:28:03
1481	24	2020-07-05 22:28:22	192.168.0.4	Documento subido/actulizado	Se ha generado docuemnto con id 278	2020-07-05 22:28:21	2020-07-05 22:28:21
1482	24	2020-07-05 22:28:43	192.168.0.4	Documento subido/actulizado	Se ha generado docuemnto con id 282	2020-07-05 22:28:42	2020-07-05 22:28:42
1483	24	2020-07-05 22:29:03	192.168.0.4	Documento subido/actulizado	Se ha generado docuemnto con id 284	2020-07-05 22:29:03	2020-07-05 22:29:03
1484	20	2020-07-07 23:12:49	192.168.0.4	Usuario sale del sistema	El usuario  cinternacional ha salido del sistema	2020-07-07 23:12:49	2020-07-07 23:12:49
1485	23	2020-07-07 23:12:58	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario logistica	2020-07-07 23:12:58	2020-07-07 23:12:58
1486	23	2020-07-07 23:20:13	192.168.0.4	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-07-07 23:20:13	2020-07-07 23:20:13
1487	21	2020-07-07 23:20:21	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario tecnico	2020-07-07 23:20:21	2020-07-07 23:20:21
1488	24	2020-07-07 23:33:37	192.168.0.4	Usuario sale del sistema	El usuario  comite ha salido del sistema	2020-07-07 23:33:37	2020-07-07 23:33:37
1489	2	2020-07-07 23:33:47	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario admin	2020-07-07 23:33:47	2020-07-07 23:33:47
1490	2	2020-07-07 23:51:45	192.168.0.4	Usuario sale del sistema	El usuario  admin ha salido del sistema	2020-07-07 23:51:45	2020-07-07 23:51:45
1491	25	2020-07-07 23:52:50	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario ueb_pinar	2020-07-07 23:52:50	2020-07-07 23:52:50
1492	25	2020-07-07 23:53:23	192.168.0.4	Demanda creada	Se ha creado una demanda con ID41	2020-07-07 23:53:23	2020-07-07 23:53:23
1493	25	2020-07-08 00:09:31	192.168.0.4	Demanda enviada	Se ha enviado la demanda D-2020-012	2020-07-08 00:09:31	2020-07-08 00:09:31
1494	25	2020-07-08 00:09:58	192.168.0.4	Usuario sale del sistema	El usuario  ueb_pinar ha salido del sistema	2020-07-08 00:09:58	2020-07-08 00:09:58
1495	23	2020-07-08 00:10:11	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario logistica	2020-07-08 00:10:11	2020-07-08 00:10:11
1496	23	2020-07-08 00:10:49	192.168.0.4	Demanda aceptada	La Demanda D-2020-012 ha sido aceptada	2020-07-08 00:10:49	2020-07-08 00:10:49
1497	23	2020-07-08 08:14:20	192.168.0.4	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-07-08 08:14:20	2020-07-08 08:14:20
1498	14	2020-07-08 08:14:35	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario ueb	2020-07-08 08:14:35	2020-07-08 08:14:35
1499	14	2020-07-08 08:14:49	192.168.0.4	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-07-08 08:14:49	2020-07-08 08:14:49
1500	23	2020-07-08 08:15:17	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario logistica	2020-07-08 08:15:17	2020-07-08 08:15:17
1501	17	2020-09-01 21:19:21	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario jcompras	2020-09-01 21:19:21	2020-09-01 21:19:21
1502	17	2020-09-01 21:20:44	192.168.0.4	Usuario sale del sistema	El usuario  jcompras ha salido del sistema	2020-09-01 21:20:44	2020-09-01 21:20:44
1503	23	2020-09-01 21:20:52	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario logistica	2020-09-01 21:20:52	2020-09-01 21:20:52
1504	23	2020-09-01 21:23:55	192.168.0.4	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-09-01 21:23:55	2020-09-01 21:23:55
1505	2	2020-09-01 21:43:41	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario admin	2020-09-01 21:43:41	2020-09-01 21:43:41
1506	2	2020-09-09 20:28:32	192.168.0.4	Usuario sale del sistema	El usuario  admin ha salido del sistema	2020-09-09 20:28:32	2020-09-09 20:28:32
1507	14	2020-09-09 20:28:40	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario ueb	2020-09-09 20:28:40	2020-09-09 20:28:40
1508	2	2020-10-25 21:14:37	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario admin	2020-10-25 21:14:37	2020-10-25 21:14:37
1509	2	2020-10-25 21:17:44	192.168.0.4	Usuario sale del sistema	El usuario  admin ha salido del sistema	2020-10-25 21:17:44	2020-10-25 21:17:44
1510	23	2020-10-25 21:17:57	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario logistica	2020-10-25 21:17:57	2020-10-25 21:17:57
1511	23	2020-10-25 21:21:03	192.168.0.4	Usuario sale del sistema	El usuario  logistica ha salido del sistema	2020-10-25 21:21:03	2020-10-25 21:21:03
1512	14	2020-10-25 21:21:12	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario ueb	2020-10-25 21:21:12	2020-10-25 21:21:12
1513	14	2020-10-25 22:11:38	192.168.0.4	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-10-25 22:11:38	2020-10-25 22:11:38
1514	14	2020-10-25 22:15:33	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario ueb	2020-10-25 22:15:33	2020-10-25 22:15:33
1515	14	2020-10-25 22:39:30	192.168.0.4	Demanda creada	Se ha creado una demanda con ID42	2020-10-25 22:39:30	2020-10-25 22:39:30
1516	14	2020-10-25 22:43:52	192.168.0.4	Usuario sale del sistema	El usuario  ueb ha salido del sistema	2020-10-25 22:43:52	2020-10-25 22:43:52
1517	23	2020-10-25 22:43:59	192.168.0.4	Usuario autenticado	Se ha autenticado el usuario logistica	2020-10-25 22:43:59	2020-10-25 22:43:59
\.


--
-- Data for Name: migration; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migration (version, apply_time) FROM stdin;
m000000_000000_base	1576543333
m140506_102106_rbac_init	1576543397
m170907_052038_rbac_add_index_on_auth_assignment_user_id	1576543397
m180523_151638_rbac_updates_indexes_without_prefix	1576543397
\.


--
-- Data for Name: offert; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offert (id, upload_by, upload_date, expiration_date, url_file, evaluated_by, evaluation_date, approved, url_evaluation, winner, buy_request_provider_id, created_at, updated_at, code) FROM stdin;
32	19	2020-06-04	2020-06-17	/offerts/Zx4m5bVXcCbYHHH9UK2BXYGf34fkbe1z.pdf	21	2020-06-04	t	/evaluations/3dG0Cph-nZ00ZssWv2MpD5KNedBTt2BR.pdf	\N	29	2020-06-04 11:29:09	2020-06-04 11:30:17	\N
33	20	2020-06-04	2020-07-09	/offerts/Eb7hHh144o_syHzOmiN4t4C1xT5SeqcE.xls	21	2020-06-04	t	/evaluations/1SZdS7yvJ7Eo88YmWAKX7OZs0afFw_Mz.docx	\N	30	2020-06-04 14:41:22	2020-06-04 14:44:34	\N
34	20	2020-06-09	2020-08-25	/offerts/WMJqUMP5S0BFXlV3gkflYhpX0YwcgBkQ.xls	21	2020-06-09	t	/evaluations/mDzRQeaWcdZ8i6qi3X4mQhUqT-B8ztzI.docx	\N	31	2020-06-09 16:49:09	2020-06-09 16:53:34	\N
36	20	2020-07-05	2020-07-31	/offerts/h8xGgc3UoKtv9Si0FzcSvP4IMSMBvpzZ.xls	\N	\N	\N	\N	\N	33	2020-07-05 22:09:46	2020-07-05 22:09:46	1122
35	20	2020-07-05	2020-07-21	/offerts/kk6ZGXAhk-HFAZOzCwFhXjOptZ-8kF2I.xls	21	2020-07-05	t	/evaluations/mqaqeY9bqVIApRbnv4PAPv3La2WwyW4s.docx	\N	33	2020-07-05 22:05:20	2020-07-05 22:20:16	1121
30	20	2020-05-16	2020-06-30	/offerts/m0IYQxU0deZ3HAIbow3qePv_Wu8mQQgY.xls	21	2020-05-16	t	/evaluations/8kSSLg9-PZnu_orR7bab65EAOwdYiDbD.pdf	\N	26	2020-05-24 03:16:28.541992	2020-05-24 03:16:28.611291	\N
31	19	2020-05-16	2020-05-29	/offerts/E5O_nkhgJwW_k25FE9cn-DNK_4UaroX8.pdf	21	2020-05-16	t	/evaluations/Y3laSBwFbZ3lwyS5khVpr3RV8p7S0yiv.pdf	\N	27	2020-05-24 03:16:28.541992	2020-05-24 03:16:28.611291	\N
\.


--
-- Data for Name: organism; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.organism (id, short_name, name, created_at, updated_at) FROM stdin;
1	MINED	Ministerio de Educación	2020-05-24 03:16:28.667891	2020-05-24 03:16:28.726016
2	MINSAP	Ministerio de Salud Pública	2020-05-24 03:16:28.667891	2020-05-24 03:16:28.726016
3	BIOCUBAFARMA	BIOCUBAFARMA	2020-05-24 03:16:28.667891	2020-05-24 03:16:28.726016
4	CE	Consejo de Estados	2020-05-24 03:16:28.667891	2020-05-24 03:16:28.726016
5	SEISA	SEISA	2020-05-30 13:10:52	2020-05-30 13:10:52
\.


--
-- Data for Name: payment_instrument; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment_instrument (id, label, created_at, updated_at) FROM stdin;
1	CC-A LA VISTA 80-20%	2020-05-24 03:16:28.777687	2020-05-24 03:16:28.832283
2	Carta de crédito	2020-05-24 03:16:28.777687	2020-05-24 03:16:28.832283
3	Transferencia	2020-05-24 03:16:28.777687	2020-05-24 03:16:28.832283
4	Letra de cambio	2020-05-24 03:16:28.777687	2020-05-24 03:16:28.832283
5	Cheque	2020-05-24 03:16:28.777687	2020-05-24 03:16:28.832283
\.


--
-- Data for Name: payment_method; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment_method (id, label, description, active, created_at, updated_at) FROM stdin;
4	Crédito a 720 días	Esta es una descripción de ejemplo	t	2020-05-24 03:16:28.883039	2020-05-24 03:16:28.940158
5	Otro	Esta es una descripción de ejemplo	t	2020-05-24 03:16:28.883039	2020-05-24 03:16:28.940158
1	CL externo por orden y a cuenta	Esta es una descripción de ejemplo	t	2020-05-24 03:16:28.883039	2020-05-24 03:16:28.940158
6	CL Externo traspazo de liquidez entre organismos	Esta es una descripción de ejemplo	t	2020-05-24 03:16:28.883039	2020-05-24 03:16:28.940158
2	Fondos propios	Esta es una descripción de ejemplo	t	2020-05-24 03:16:28.883039	2020-05-24 03:16:28.940158
7	CL externo emitido por el organismo del cliente	Esta es una descripción de ejemplo.\r\nEsto puede cambiar muchisimo por eso es un nomenclador...	t	2020-05-24 03:16:28.883039	2020-05-24 03:16:28.940158
3	Crédito a 360 días	Lorem ipsum dolor sit amet consectetur adipiscing, elit accumsan eget mollis facilisi iaculis, aptent lacus feugiat mauris semper. Etiam facilisi tempus vehicula praesent nibh vitae lacus semper ligula potenti ridiculus, nostra convallis mi class faucibus in leo placerat rutrum torquent sed vivamus, dui enim ultricies eros dignissim porttitor ut quisque eu parturient. Nisl netus consequat vivamus laoreet nunc feugiat mus eros elementum volutpat enim, suscipit montes neque pellentesque iaculis tristique condimentum eu semper.\n\nSuscipit senectus primis semper elementum dictumst tristique, ut aliquam egestas nisi non lacinia, curae tempus torquent massa malesuada. Penatibus suscipit quam aenean tempus accumsan nec natoque feugiat dui, a pulvinar vulputate dictumst nulla quis nam vivamus pretium tortor, ridiculus sollicitudin ligula lacus pharetra luctus mattis etiam. Rutrum libero porta parturient venenatis conubia tristique aptent vitae, id quis luctus magnis dignissim nam rhoncus magna volutpat, posuere ligula pulvinar tincidunt etiam sed litora.	t	2020-05-24 03:16:28.883039	2020-05-24 03:16:28.940158
\.


--
-- Data for Name: provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.provider (id, name, country_id, address, active, contact_name, contact_email, observation, buy_request_type_id, created_at, updated_at) FROM stdin;
1	Royal	2	5825 W 25th Ct, #105, Hialeah, FL 33016	t	Chucho	carlosllorca89@gmail.com		1	2020-05-24 03:16:28.991622	2020-05-24 03:16:29.036539
3	Proveedor nacional	1	esta es la dirección	t	Pedro Pérez	pedro@nacional.cu	Este es un proveedor que vende CO2	2	2020-05-24 03:16:28.991622	2020-05-24 03:16:29.036539
4	Gaviota	1	Dirección gaviota	t	Gaviota	gaviota@gaviota.cu	Gaviota	3	2020-05-24 03:16:28.991622	2020-05-24 03:16:29.036539
5	TECNOTEX	1	TECNOTEX	t	TECNOTEX	tecnotex@tecnotex.cu	esta	3	2020-05-24 03:16:28.991622	2020-05-24 03:16:29.036539
2	Europartes	2	Calle Vigia# 308 e/ Principe y San Juaquin	t	Cucho	carlosllorca89@gmail.com		1	2020-05-24 03:16:28.991622	2020-07-05 21:24:54
\.


--
-- Data for Name: provider_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.provider_status (id, label, created_at, updated_at) FROM stdin;
2	Oferta recibida	2020-05-24 03:16:29.085383	2020-05-24 03:16:29.13579
3	Oferta aprobada	2020-05-24 03:16:29.085383	2020-05-24 03:16:29.13579
4	Oferta rechazada	2020-05-24 03:16:29.085383	2020-05-24 03:16:29.13579
1	Sin respuesta	2020-05-24 03:16:29.085383	2020-05-24 03:16:29.13579
\.


--
-- Data for Name: provider_validated_list; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.provider_validated_list (id, provider_id, validated_list_id, created_at, updated_at) FROM stdin;
46	1	14	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
47	1	9	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
48	1	2	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
49	1	1	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
50	1	15	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
51	1	3	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
52	1	4	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
53	1	16	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
54	1	6	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
55	1	7	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
56	1	5	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
57	1	10	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
58	1	11	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
59	1	12	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
60	1	13	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
61	1	8	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
62	1	17	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
63	1	18	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
64	3	14	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
65	3	9	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
66	3	2	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
67	3	1	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
68	3	15	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
69	3	3	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
70	3	4	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
71	3	16	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
72	3	6	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
73	3	7	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
74	3	5	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
75	3	10	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
76	3	11	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
77	3	12	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
78	3	13	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
79	3	8	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
80	3	17	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
81	3	18	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
82	4	14	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
83	4	9	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
84	4	2	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
85	4	1	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
86	4	15	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
87	4	3	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
88	4	4	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
89	4	16	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
90	4	6	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
91	4	7	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
92	4	5	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
93	4	10	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
94	4	11	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
95	4	12	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
96	4	13	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
97	4	8	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
98	4	17	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
99	4	18	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
100	5	14	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
101	5	9	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
102	5	2	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
103	5	1	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
104	5	15	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
105	5	3	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
106	5	4	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
107	5	16	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
108	5	6	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
109	5	7	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
110	5	5	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
111	5	10	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
112	5	11	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
113	5	12	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
114	5	13	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
115	5	8	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
116	5	17	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
117	5	18	2020-05-24 03:16:29.180448	2020-05-24 03:16:29.256252
118	2	14	2020-07-06 01:24:54.27886	2020-07-06 01:24:54.27886
119	2	9	2020-07-06 01:24:54.27886	2020-07-06 01:24:54.27886
120	2	2	2020-07-06 01:24:54.27886	2020-07-06 01:24:54.27886
121	2	1	2020-07-06 01:24:54.27886	2020-07-06 01:24:54.27886
122	2	15	2020-07-06 01:24:54.27886	2020-07-06 01:24:54.27886
123	2	3	2020-07-06 01:24:54.27886	2020-07-06 01:24:54.27886
124	2	4	2020-07-06 01:24:54.27886	2020-07-06 01:24:54.27886
125	2	16	2020-07-06 01:24:54.27886	2020-07-06 01:24:54.27886
126	2	6	2020-07-06 01:24:54.27886	2020-07-06 01:24:54.27886
127	2	7	2020-07-06 01:24:54.27886	2020-07-06 01:24:54.27886
128	2	5	2020-07-06 01:24:54.27886	2020-07-06 01:24:54.27886
129	2	10	2020-07-06 01:24:54.27886	2020-07-06 01:24:54.27886
130	2	11	2020-07-06 01:24:54.27886	2020-07-06 01:24:54.27886
131	2	12	2020-07-06 01:24:54.27886	2020-07-06 01:24:54.27886
132	2	13	2020-07-06 01:24:54.27886	2020-07-06 01:24:54.27886
133	2	8	2020-07-06 01:24:54.27886	2020-07-06 01:24:54.27886
134	2	17	2020-07-06 01:24:54.27886	2020-07-06 01:24:54.27886
135	2	18	2020-07-06 01:24:54.27886	2020-07-06 01:24:54.27886
\.


--
-- Data for Name: province_ueb; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.province_ueb (id, label, created_at, updated_at) FROM stdin;
1	UEB La Habana	2020-05-24 03:16:29.301756	2020-05-24 03:16:29.347526
2	UEB Pinar del Rio	2020-05-24 03:16:29.301756	2020-05-24 03:16:29.347526
3	UEB Santiago de Cuba	2020-05-24 03:16:29.301756	2020-05-24 03:16:29.347526
4	Sede central	2020-05-28 23:00:07	2020-05-28 23:00:07
\.


--
-- Data for Name: purchase_reason; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.purchase_reason (id, label, created_at, updated_at) FROM stdin;
1	Comprar	2020-05-24 03:16:29.408397	2020-05-24 03:16:29.471283
2	Inventario mínimo	2020-05-24 03:16:29.408397	2020-05-24 03:16:29.471283
3	Medios	2020-05-24 03:16:29.408397	2020-05-24 03:16:29.471283
4	Solicitud de oferta	2020-05-24 03:16:29.408397	2020-05-24 03:16:29.471283
\.


--
-- Data for Name: request_stage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.request_stage (id, date_created, date_start, date_end, real_end, stage_id, buy_request_id, details, created_at, updated_at, active) FROM stdin;
219	2020-06-04	2020-07-03	2020-07-18	2020-06-04	22	47		2020-06-04 11:55:59	2020-06-04 11:56:34	f
235	2020-06-04	2020-09-01	2020-09-05	\N	9	48	\N	2020-06-04 14:53:30	2020-06-04 14:58:54	\N
220	2020-06-04	2020-07-18	2020-08-03	2020-06-04	23	47		2020-06-04 11:55:59	2020-06-04 11:56:43	f
236	2020-06-04	2020-09-05	2020-09-06	\N	10	48	\N	2020-06-04 14:53:30	2020-06-04 14:58:54	\N
221	2020-06-04	2020-08-03	2020-08-13	2020-06-04	24	47		2020-06-04 11:55:59	2020-06-04 11:56:52	f
237	2020-06-04	2020-09-06	2020-09-07	\N	11	48	\N	2020-06-04 14:53:30	2020-06-04 14:58:54	\N
222	2020-06-04	2020-08-13	2020-08-20	2020-06-04	25	47		2020-06-04 11:56:00	2020-06-04 11:57:00	f
238	2020-06-04	2020-09-07	2020-09-10	\N	12	48	\N	2020-06-04 14:53:30	2020-06-04 14:58:54	\N
223	2020-06-04	2020-08-20	2020-09-09	2020-06-04	26	47		2020-06-04 11:56:00	2020-06-04 11:57:09	f
239	2020-06-04	2020-09-10	2020-09-13	\N	13	48	\N	2020-06-04 14:53:30	2020-06-04 14:58:54	\N
224	2020-06-04	2020-09-09	2020-11-08	2020-06-04	27	47		2020-06-04 11:56:00	2020-06-04 11:57:19	f
240	2020-06-04	2020-09-13	2020-09-15	\N	14	48	\N	2020-06-04 14:53:30	2020-06-04 14:58:54	\N
225	2020-06-04	2020-11-08	2021-01-07	2020-06-04	28	47		2020-06-04 11:56:00	2020-06-04 11:57:28	f
226	2020-06-04	2021-01-07	2021-01-17	2020-06-04	29	47		2020-06-04 11:56:00	2020-06-04 11:57:36	f
227	2020-06-04	2020-06-04	2020-06-05	2020-06-04	1	48		2020-06-04 14:53:30	2020-06-04 14:54:30	f
228	2020-06-04	2020-08-13	2020-08-16	2020-06-04	2	48		2020-06-04 14:53:30	2020-06-04 14:56:49	f
200	2020-05-16	2020-05-22	2020-05-23	\N	18	43	\N	2020-05-24 03:16:29.540534	2020-05-24 03:16:29.660541	\N
179	2020-05-16	2020-05-16	2020-05-17	2020-05-22	1	42	Se adelanta todo una semana.\r\nVolvemos una semana atrás por el corona virus.	2020-05-24 03:16:29.540534	2020-05-24 03:16:29.660541	\N
180	2020-05-16	2020-07-25	2020-07-28	2020-05-22	2	42		2020-05-24 03:16:29.540534	2020-05-24 03:16:29.660541	\N
181	2020-05-16	2020-07-28	2020-08-02	2020-05-22	3	42		2020-05-24 03:16:29.540534	2020-05-24 03:16:29.660541	\N
182	2020-05-16	2020-08-02	2020-08-03	2020-05-22	4	42		2020-05-24 03:16:29.540534	2020-05-24 03:16:29.660541	\N
183	2020-05-16	2020-08-03	2020-08-07	2020-05-22	5	42		2020-05-24 03:16:29.540534	2020-05-24 03:16:29.660541	\N
184	2020-05-16	2020-08-07	2020-08-10	2020-05-22	6	42		2020-05-24 03:16:29.540534	2020-05-24 03:16:29.660541	\N
185	2020-05-16	2020-08-10	2020-08-14	2020-05-22	7	42		2020-05-24 03:16:29.540534	2020-05-24 03:16:29.660541	\N
186	2020-05-16	2020-11-12	2020-11-13	2020-05-22	8	42		2020-05-24 03:16:29.540534	2020-05-24 03:16:29.660541	\N
187	2020-05-16	2020-11-13	2020-11-17	2020-05-22	9	42		2020-05-24 03:16:29.540534	2020-05-24 03:16:29.660541	\N
188	2020-05-16	2020-11-17	2020-11-18	2020-05-22	10	42		2020-05-24 03:16:29.540534	2020-05-24 03:16:29.660541	\N
189	2020-05-16	2020-11-18	2020-11-19	2020-05-22	11	42		2020-05-24 03:16:29.540534	2020-05-24 03:16:29.660541	\N
190	2020-05-16	2020-11-19	2020-11-22	2020-05-22	12	42		2020-05-24 03:16:29.540534	2020-05-24 03:16:29.660541	\N
191	2020-05-16	2020-11-22	2020-11-25	2020-05-22	13	42		2020-05-24 03:16:29.540534	2020-05-24 03:16:29.660541	\N
192	2020-05-16	2020-11-25	2020-11-27	2020-05-22	14	42		2020-05-24 03:16:29.540534	2020-05-24 03:16:29.660541	\N
197	2020-05-16	2020-05-16	2020-05-18	2020-05-28	15	43		2020-05-24 03:16:29.540534	2020-05-28 17:54:04	f
199	2020-05-16	2020-05-21	2020-05-22	\N	17	43	\N	2020-05-24 03:16:29.540534	2020-05-28 17:57:29	t
198	2020-05-16	2020-05-18	2020-05-21	2020-05-28	16	43		2020-05-24 03:16:29.540534	2020-05-28 17:57:29	f
201	2020-05-30	2020-05-30	2020-05-31	\N	19	45	\N	2020-05-30 22:43:38	2020-05-30 22:43:38	\N
202	2020-05-30	2020-05-31	2020-06-07	\N	20	45	\N	2020-05-30 22:43:38	2020-05-30 22:43:38	\N
203	2020-05-30	2020-06-07	2020-06-28	\N	21	45	\N	2020-05-30 22:43:38	2020-05-30 22:43:38	\N
204	2020-05-30	2020-06-28	2020-07-13	\N	22	45	\N	2020-05-30 22:43:38	2020-05-30 22:43:38	\N
205	2020-05-30	2020-07-13	2020-07-29	\N	23	45	\N	2020-05-30 22:43:38	2020-05-30 22:43:38	\N
206	2020-05-30	2020-07-29	2020-08-08	\N	24	45	\N	2020-05-30 22:43:38	2020-05-30 22:43:38	\N
207	2020-05-30	2020-08-08	2020-08-15	\N	25	45	\N	2020-05-30 22:43:38	2020-05-30 22:43:38	\N
208	2020-05-30	2020-08-15	2020-09-04	\N	26	45	\N	2020-05-30 22:43:38	2020-05-30 22:43:38	\N
209	2020-05-30	2020-09-04	2020-11-03	\N	27	45	\N	2020-05-30 22:43:38	2020-05-30 22:43:38	\N
210	2020-05-30	2020-11-03	2021-01-02	\N	28	45	\N	2020-05-30 22:43:38	2020-05-30 22:43:38	\N
211	2020-05-30	2021-01-02	2021-01-12	\N	29	45	\N	2020-05-30 22:43:38	2020-05-30 22:43:38	\N
212	2020-06-04	2020-06-04	2020-06-06	2020-06-04	15	46		2020-06-04 11:35:48	2020-06-04 11:35:59	f
213	2020-06-04	2020-06-06	2020-06-09	2020-06-04	16	46		2020-06-04 11:35:48	2020-06-04 11:36:09	f
214	2020-06-04	2020-06-09	2020-06-10	2020-06-04	17	46		2020-06-04 11:35:48	2020-06-04 11:36:19	f
215	2020-06-04	2020-06-10	2020-06-11	2020-06-04	18	46		2020-06-04 11:35:48	2020-06-04 11:36:32	f
216	2020-06-04	2020-06-04	2020-06-05	2020-06-04	19	47		2020-06-04 11:55:59	2020-06-04 11:56:09	f
217	2020-06-04	2020-06-05	2020-06-12	2020-06-04	20	47		2020-06-04 11:55:59	2020-06-04 11:56:17	f
218	2020-06-04	2020-06-12	2020-07-03	2020-06-04	21	47		2020-06-04 11:55:59	2020-06-04 11:56:26	f
253	2020-06-09	2020-11-18	2020-11-21	\N	13	49	\N	2020-06-09 17:13:25	2020-06-09 17:21:35	\N
254	2020-06-09	2020-11-21	2020-11-23	\N	14	49	\N	2020-06-09 17:13:25	2020-06-09 17:21:35	\N
256	2020-07-05	2020-07-06	2020-07-07	\N	1	44	\N	2020-07-05 22:50:25	2020-07-05 22:50:25	\N
257	2020-07-05	1969-12-31	1970-01-03	\N	2	44	\N	2020-07-05 22:50:49	2020-07-05 22:50:49	\N
258	2020-07-05	1970-01-03	1970-01-08	\N	3	44	\N	2020-07-05 22:50:49	2020-07-05 22:50:49	\N
259	2020-07-05	1970-01-08	1970-01-09	\N	4	44	\N	2020-07-05 22:50:49	2020-07-05 22:50:49	\N
229	2020-06-04	2020-04-15	2020-04-20	\N	3	48	ljsdlfjsdlsdjflskdfnlsdjflksdjfdsnlksdfjl	2020-06-04 14:53:30	2020-06-04 14:58:54	t
230	2020-06-04	2020-06-20	2020-06-21	\N	4	48	\N	2020-06-04 14:53:30	2020-06-04 14:58:54	\N
231	2020-06-04	2020-06-21	2020-06-25	\N	5	48	\N	2020-06-04 14:53:30	2020-06-04 14:58:54	\N
232	2020-06-04	2020-06-25	2020-06-28	\N	6	48	\N	2020-06-04 14:53:30	2020-06-04 14:58:54	\N
233	2020-06-04	2020-06-28	2020-07-02	\N	7	48	\N	2020-06-04 14:53:30	2020-06-04 14:58:54	\N
234	2020-06-04	2020-08-31	2020-09-01	\N	8	48	\N	2020-06-04 14:53:30	2020-06-04 14:58:54	\N
260	2020-07-05	1970-01-09	1970-01-13	\N	5	44	\N	2020-07-05 22:50:49	2020-07-05 22:50:49	\N
241	2020-06-09	2020-06-09	2020-06-10	2020-06-09	1	49		2020-06-09 17:13:25	2020-06-09 17:19:34	f
261	2020-07-05	1970-01-13	1970-01-16	\N	6	44	\N	2020-07-05 22:50:49	2020-07-05 22:50:49	\N
262	2020-07-05	1970-01-16	1970-01-20	\N	7	44	\N	2020-07-05 22:50:49	2020-07-05 22:50:49	\N
242	2020-06-09	2020-08-18	2020-08-21	2020-06-09	2	49	lhdalhdajkshkjadshdas	2020-06-09 17:13:25	2020-06-09 17:21:35	f
243	2020-06-09	2020-08-23	2020-08-28	\N	3	49	\N	2020-06-09 17:13:25	2020-06-09 17:21:35	t
244	2020-06-09	2020-08-28	2020-08-29	\N	4	49	\N	2020-06-09 17:13:25	2020-06-09 17:21:35	\N
245	2020-06-09	2020-08-29	2020-09-02	\N	5	49	\N	2020-06-09 17:13:25	2020-06-09 17:21:35	\N
246	2020-06-09	2020-09-02	2020-09-05	\N	6	49	\N	2020-06-09 17:13:25	2020-06-09 17:21:35	\N
247	2020-06-09	2020-09-05	2020-09-09	\N	7	49	\N	2020-06-09 17:13:25	2020-06-09 17:21:35	\N
248	2020-06-09	2020-11-08	2020-11-09	\N	8	49	\N	2020-06-09 17:13:25	2020-06-09 17:21:35	\N
249	2020-06-09	2020-11-09	2020-11-13	\N	9	49	\N	2020-06-09 17:13:25	2020-06-09 17:21:35	\N
250	2020-06-09	2020-11-13	2020-11-14	\N	10	49	\N	2020-06-09 17:13:25	2020-06-09 17:21:35	\N
251	2020-06-09	2020-11-14	2020-11-15	\N	11	49	\N	2020-06-09 17:13:25	2020-06-09 17:21:35	\N
252	2020-06-09	2020-11-15	2020-11-18	\N	12	49	\N	2020-06-09 17:13:25	2020-06-09 17:21:35	\N
263	2020-07-05	1970-02-01	1970-02-02	\N	8	44	\N	2020-07-05 22:50:49	2020-07-05 22:50:49	\N
264	2020-07-05	1970-02-02	1970-02-06	\N	9	44	\N	2020-07-05 22:50:49	2020-07-05 22:50:49	\N
265	2020-07-05	1970-02-06	1970-02-07	\N	10	44	\N	2020-07-05 22:50:49	2020-07-05 22:50:49	\N
266	2020-07-05	1970-02-07	1970-02-08	\N	11	44	\N	2020-07-05 22:50:49	2020-07-05 22:50:49	\N
267	2020-07-05	1970-02-08	1970-02-11	\N	12	44	\N	2020-07-05 22:50:49	2020-07-05 22:50:49	\N
268	2020-07-05	1970-02-11	1970-02-14	\N	13	44	\N	2020-07-05 22:50:49	2020-07-05 22:50:49	\N
269	2020-07-05	1970-02-14	1970-02-16	\N	14	44	\N	2020-07-05 22:50:49	2020-07-05 22:50:49	\N
\.


--
-- Data for Name: seller_requirement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.seller_requirement (id, label, created_at, updated_at) FROM stdin;
1	Capacitación	2020-05-24 03:16:29.721456	2020-05-24 03:16:29.767815
2	Puesta en marcha	2020-05-24 03:16:29.721456	2020-05-24 03:16:29.767815
3	Ninguna	2020-05-24 03:16:29.721456	2020-05-24 03:16:29.767815
\.


--
-- Data for Name: stage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stage (id, label, "order", buy_request_type_id, active, duration, created_at, updated_at) FROM stdin;
5	Confeccion de la DM	5	1	t	4	2020-05-24 03:16:29.823183	2020-05-24 03:16:29.923614
7	Presentación a la Aduana General de la Declaración de Mercancías y levante	7	1	t	4	2020-05-24 03:16:29.823183	2020-05-24 03:16:29.923614
8	Arribo del Buque al Puerto	8	1	t	1	2020-05-24 03:16:29.823183	2020-05-24 03:16:29.923614
13	Recepcion al detalle e Informe de Recepción	13	1	t	3	2020-05-24 03:16:29.823183	2020-05-24 03:16:29.923614
9	Planificación de la Transportación con el Transportista	9	1	t	4	2020-05-24 03:16:29.823183	2020-05-24 03:16:29.923614
12	Elaboración de la Ficha de Costo	12	1	t	3	2020-05-24 03:16:29.823183	2020-05-24 03:16:29.923614
11	Inspección y recepción de bultos con la presencia de la Comisión de Apertura de Contenedores	11	1	t	1	2020-05-24 03:16:29.823183	2020-05-24 03:16:29.923614
10	Extracción de la Carga por el Transportista, llegada del contenedor al Primer Almacén	10	1	t	1	2020-05-24 03:16:29.823183	2020-05-24 03:16:29.923614
2	Comunicación por el proveedor de la fecha de entrega de la mercancía según contrato y apertura de CC (21 dias antes de DO por CTO.)	2	1	t	3	2020-05-24 03:16:29.823183	2020-05-24 03:16:29.923614
3	Buqueo de la Mercancía	3	1	t	5	2020-05-24 03:16:29.823183	2020-05-24 03:16:29.923614
1	Comunicación de la apertura del Instrumento de pago  al proveedor	1	1	t	1	2020-05-24 03:16:29.823183	2020-05-24 03:16:29.923614
6	Envío de documentos originales del Embarque por el proveedor	6	1	t	3	2020-05-24 03:16:29.823183	2020-05-24 03:16:29.923614
4	Envío de documentos de embarque en formato digital por el proveedor	4	1	t	1	2020-05-24 03:16:29.823183	2020-05-24 03:16:29.923614
14	Distribución y Despacho de la mercancía para cada UEB	14	1	t	2	2020-05-24 03:16:29.823183	2020-05-24 03:16:29.923614
15	Facturacion, Carga y Transporte de la Mercancia del Almacen del Proveedor	1	2	t	2	2020-05-24 03:16:29.823183	2020-05-24 03:16:29.923614
16	Inspección, Recepción al detalle en Almacen del Comprador	2	2	t	3	2020-05-24 03:16:29.823183	2020-05-24 03:16:29.923614
17	Distribución de la mercancía para cada UEB	3	2	t	1	2020-05-24 03:16:29.823183	2020-05-24 03:16:29.923614
18	Despacho de las mercancías	4	2	t	1	2020-05-24 03:16:29.823183	2020-05-24 03:16:29.923614
19	Presentación del 711	1	3	t	1	2020-05-24 03:16:29.823183	2020-05-24 03:16:29.923614
20	Revisión y aceptación del 711	2	3	t	7	2020-05-24 03:16:29.823183	2020-05-24 03:16:29.923614
21	Preentación de ofertas	3	3	t	21	2020-05-24 03:16:29.823183	2020-05-24 03:16:29.923614
22	Aprobación técnica	4	3	t	15	2020-05-24 03:16:29.823183	2020-05-24 03:16:29.923614
23	Reofertas, negociación y comité de contratación	5	3	t	16	2020-05-24 03:16:29.823183	2020-05-24 03:16:29.923614
24	Comité del GAE	6	3	t	10	2020-05-24 03:16:29.823183	2020-05-24 03:16:29.923614
25	Firma del contrato	7	3	t	7	2020-05-24 03:16:29.823183	2020-05-24 03:16:29.923614
26	Apertura de la carta de crédito	8	3	t	20	2020-05-24 03:16:29.823183	2020-05-24 03:16:29.923614
27	Producción	9	3	t	60	2020-05-24 03:16:29.823183	2020-05-24 03:16:29.923614
28	Transportación	10	3	t	60	2020-05-24 03:16:29.823183	2020-05-24 03:16:29.923614
29	Entrega a SEISA	11	3	t	10	2020-05-24 03:16:29.823183	2020-05-24 03:16:29.923614
\.


--
-- Data for Name: subfamily; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subfamily (id, label, validated_list_id, created_at, updated_at) FROM stdin;
1	Principal	1	2020-05-24 03:16:29.956734	2020-05-24 03:16:30.001442
2	Armario porta extintores	2	2020-05-24 03:16:29.956734	2020-05-24 03:16:30.001442
3	CO2	2	2020-05-24 03:16:29.956734	2020-05-24 03:16:30.001442
4	PQS	2	2020-05-24 03:16:29.956734	2020-05-24 03:16:30.001442
5	Partes y piezas para extintores	2	2020-05-24 03:16:29.956734	2020-05-24 03:16:30.001442
6	Principal	3	2020-05-24 03:16:29.956734	2020-05-24 03:16:30.001442
7	Tierra física y accesorios de instalación	7	2020-05-24 03:16:29.956734	2020-05-24 03:16:30.001442
8	Supresores genéricos	7	2020-05-24 03:16:29.956734	2020-05-24 03:16:30.001442
9	ADEMCO	6	2020-05-24 03:16:29.956734	2020-05-24 03:16:30.001442
10	Común	6	2020-05-24 03:16:29.956734	2020-05-24 03:16:30.001442
11	DSC	6	2020-05-24 03:16:29.956734	2020-05-24 03:16:30.001442
12	América	4	2020-05-24 03:16:29.956734	2020-05-24 03:16:30.001442
13	Notifier amércia	4	2020-05-24 03:16:29.956734	2020-05-24 03:16:30.001442
14	Notifier Italia	4	2020-05-24 03:16:29.956734	2020-05-24 03:16:30.001442
15	Accesorios sistemas extinción por agua	5	2020-05-24 03:16:29.956734	2020-05-24 03:16:30.001442
16	Equipos contra incendios	5	2020-05-24 03:16:29.956734	2020-05-24 03:16:30.001442
17	Materiales de montaje	5	2020-05-24 03:16:29.956734	2020-05-24 03:16:30.001442
18	Tuberías	5	2020-05-24 03:16:29.956734	2020-05-24 03:16:30.001442
19	Válvulas y sensor de flujo	5	2020-05-24 03:16:29.956734	2020-05-24 03:16:30.001442
\.


--
-- Data for Name: um; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.um (id, label, created_at, updated_at) FROM stdin;
1	Unidad	2020-05-24 03:16:30.06659	2020-05-24 03:16:30.114742
2	Metro	2020-05-24 03:16:30.06659	2020-05-24 03:16:30.114742
3	Litro	2020-05-24 03:16:30.06659	2020-05-24 03:16:30.114742
4	Kilogramo	2020-05-24 03:16:30.06659	2020-05-24 03:16:30.114742
5	Metro	2020-05-24 03:16:30.06659	2020-05-24 03:16:30.114742
6	m3	2020-05-24 03:16:30.06659	2020-05-24 03:16:30.114742
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, username, full_name, email, password, created_at, last_login, province_ueb, active, cargo, phone_number, digital_signature_url, updated_at) FROM stdin;
26	ueb_santiagp	Ueb Santiago	carlos@codeberrysolutions.com	$2y$13$Q69VajxdtRaRnwihXe4YUOXxnU2POpjflAqt.l1M9ezc1Nm95IAWK	2020-05-10 00:00:00	2020-05-10 14:10:46	3	t	Especialista	5353314593	\N	2020-05-24 03:18:29.923279
16	gol	Especialista GOL	carlosllorca89@gmail.com	$2y$13$Zs98YBtoMHpDgKeuSA1j7u/OoPnYNzLccNIpTV2.oVA7XbxmTTKBe	2020-02-22 00:00:00	2020-02-24 19:37:13	4	t			\N	2020-06-04 11:13:04
24	comite	Comité	carlosllorca89@gmail.com	$2y$13$HzrOA.mpTAPUP2R31KGKMOD/R6wWi5wRtSGKmef7gmdq7PFSVCJ9.	2020-03-09 00:00:00	2020-07-05 22:26:09	4	t	Un miembro del comité	+535124578	\N	2020-07-05 22:26:08
21	tecnico	Especialista Técncio	carlosllorca89@gmail.com	$2y$13$4nAWD8O829ra8e51c7Pipu6qlbsrC8KSQG0tcQUoYjquRn/Bt6fSG	2020-02-22 00:00:00	2020-07-07 23:20:21	4	t			\N	2020-07-07 23:20:20
25	ueb_pinar	UEB Pinar	carlos@codeberrysolutions.com	$2y$13$n2uQvr5kdhK/yNPrGahuc.luDs2ONo8PranLwVAkUpje1Q7BEPlsC	2020-05-10 00:00:00	2020-07-07 23:52:50	2	t	Especialista	53314593	\N	2020-07-07 23:52:50
19	cnacional	Comprador Nacional	carlosllorca89@gmail.com	$2y$13$6OZP8KX/KwR8/Lzw1hSHz.e/49aIJfNZM4XU/Tv7sAdudMtcgTYYK	2020-02-22 00:00:00	2020-06-04 11:31:55	4	t			\N	2020-06-04 11:31:55
17	jcompras	Jefe de Compras	carlosllorca89@gmail.com	$2y$13$WhhloOIZJ6LmNV2UXIYMFuyIcVMFOCifMmRM.ntaFLAGzCBZ19lnK	2020-02-22 00:00:00	2020-09-01 21:19:21	4	t	EP COmpras internacionales	+5351212	\N	2020-09-01 21:19:20
2	admin	SEISA Admin	carlosllorca89@gmail.com	$2y$13$VassiVFx6tuNZm2ZjYbJMO9c80YKADhcKvTjAUc3WtHgn0fVtU9ZO	2019-12-17 00:00:00	2020-10-25 21:14:37	4	t			\N	2020-10-25 21:14:36
18	jtecnico	Jefe dircción técncia	carlosllorca89@gmail.com	$2y$13$9qGTbtOcN1t46QrvCjtzE.LuYkghnto9ijM.ER.TzQbzvtrv2m0Le	2020-02-22 00:00:00	2020-06-09 16:01:29	4	t			\N	2020-06-09 16:01:28
27	jnacional	Jefe de compras nacionales	carlosllorca89@gmail.com	$2y$13$qlkxjw/dflEsAemv9hpGl.n/zCPQiqDWsU4Epqvs8Arg9mPuzzOUG	2020-05-30 00:00:00	2020-05-30 10:58:00	4	t	Jefe de compras	+5353314593	\N	2020-05-30 12:31:32
15	jlogistica	Jefe Dirección Logística	carlosllorca89@gmail.com	$2y$13$/5sDmpyO9ruk9Uy.C92AOeO72MdzmBvguAacKt2pAcsuxjQbFgmGi	2020-02-22 00:00:00	2020-06-13 17:44:42	4	t	Jefe Dirección Logística	+53511111111	\N	2020-06-13 17:44:41
28	c711	Comprador 711	carlosllorca89@gmail.com	$2y$13$gCl3KDcnOp7b3TlNKXb6JuzjG1hStL4Dtsw8TvebRpWRtrPTeCjFa	2020-05-30 00:00:00	2020-06-04 11:54:43	4	t	Comprador	+5353314593	\N	2020-06-04 11:54:42
14	ueb	UEB, La Habana	carlosllorca89@gmail.com	$2y$13$5NUPguf6pVQaRxaKbClw4uJeYuwrrctkIhb9cmTurNGC2KbP2n4/C	2020-02-22 00:00:00	2020-10-25 22:15:33	1	t			\N	2020-10-25 22:15:33
23	logistica	Esp. logística	carlosllorca89@gmail.com	$2y$13$TlG4K5EufNUJ0XRuy6rQP.etN2r4AbqR5V/UGbaBzdtH1CD0NFRhS	2020-03-05 00:00:00	2020-10-25 22:43:59	4	t	Especialista logística	+5351234567	\N	2020-10-25 22:43:58
20	cinternacional	Comprador Internacional	carlosllorca89@gmail.com	$2y$13$e5ly1G4KG0kEg3zRZfd6OOL1AXqOFVqpCVbBgRtQ/2dYuo4ftSxt6	2020-02-22 00:00:00	2264-01-28 08:11:29	4	t	Comprador		\N	2264-01-28 08:11:28
\.


--
-- Data for Name: user_can_view; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_can_view (id, user_id, buy_request_type_id, created_at, updated_at) FROM stdin;
8	24	3	2020-05-30 14:55:01.861949	2020-05-30 14:55:01.861949
9	24	1	2020-05-30 14:55:01.861949	2020-05-30 14:55:01.861949
10	24	2	2020-05-30 14:55:01.861949	2020-05-30 14:55:01.861949
20	15	3	2020-05-30 15:43:00.752372	2020-05-30 15:43:00.752372
21	15	1	2020-05-30 15:43:00.752372	2020-05-30 15:43:00.752372
22	15	2	2020-05-30 15:43:00.752372	2020-05-30 15:43:00.752372
36	27	3	2020-05-30 16:31:32.634509	2020-05-30 16:31:32.634509
37	27	2	2020-05-30 16:31:32.634509	2020-05-30 16:31:32.634509
45	18	3	2020-05-31 02:29:52.095044	2020-05-31 02:29:52.095044
46	18	1	2020-05-31 02:29:52.095044	2020-05-31 02:29:52.095044
47	18	2	2020-05-31 02:29:52.095044	2020-05-31 02:29:52.095044
48	21	3	2020-05-31 02:40:30.817548	2020-05-31 02:40:30.817548
49	21	1	2020-05-31 02:40:30.817548	2020-05-31 02:40:30.817548
50	21	2	2020-05-31 02:40:30.817548	2020-05-31 02:40:30.817548
52	19	2	2020-05-31 03:11:23.583573	2020-05-31 03:11:23.583573
53	28	3	2020-05-31 03:11:41.409403	2020-05-31 03:11:41.409403
55	20	1	2020-05-31 03:34:07.241465	2020-05-31 03:34:07.241465
59	23	3	2020-06-04 14:59:58.716515	2020-06-04 14:59:58.716515
60	23	1	2020-06-04 14:59:58.716515	2020-06-04 14:59:58.716515
61	23	2	2020-06-04 14:59:58.716515	2020-06-04 14:59:58.716515
65	17	3	2020-06-04 15:07:01.527844	2020-06-04 15:07:01.527844
66	17	1	2020-06-04 15:07:01.527844	2020-06-04 15:07:01.527844
67	17	2	2020-06-04 15:07:01.527844	2020-06-04 15:07:01.527844
68	16	3	2020-06-04 15:13:04.336357	2020-06-04 15:13:04.336357
69	16	1	2020-06-04 15:13:04.336357	2020-06-04 15:13:04.336357
70	16	2	2020-06-04 15:13:04.336357	2020-06-04 15:13:04.336357
\.


--
-- Data for Name: validated_list; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.validated_list (id, label, created_at, updated_at, common) FROM stdin;
1	Avance de obra	2020-05-24 03:18:29.954671	2020-05-24 03:18:30.008481	f
2	Armarios porta extintores	2020-05-24 03:18:29.954671	2020-05-24 03:18:30.008481	f
3	Extintores CO2	2020-05-24 03:18:29.954671	2020-05-24 03:18:30.008481	f
4	Extintores PQS	2020-05-24 03:18:29.954671	2020-05-24 03:18:30.008481	f
5	PARTES Y PIEZAS PARA EXTINTOR DE PQS - HÍDRICO - CO2	2020-05-24 03:18:29.954671	2020-05-24 03:18:30.008481	f
6	Material gastable	2020-05-24 03:18:29.954671	2020-05-24 03:18:30.008481	f
7	Pararrayo, Tierra Física y Accesorios de Instalación	2020-05-24 03:18:29.954671	2020-05-24 03:18:30.008481	f
8	Supresores genéricos	2020-05-24 03:18:29.954671	2020-05-24 03:18:30.008481	f
9	Ademco SACI	2020-05-24 03:18:29.954671	2020-05-24 03:18:30.008481	f
11	SACI DSC	2020-05-24 03:18:29.954671	2020-05-24 03:18:30.008481	f
12	SADI Notifier América	2020-05-24 03:18:29.954671	2020-05-24 03:18:30.008481	f
13	SADI Notifier Italia	2020-05-24 03:18:29.954671	2020-05-24 03:18:30.008481	f
14	Accesorios Sistemas Fijos de Extinción con agua (Accesorios de CPBC BM)	2020-05-24 03:18:29.954671	2020-05-24 03:18:30.008481	f
15	Equipos contra Incendio	2020-05-24 03:18:29.954671	2020-05-24 03:18:30.008481	f
16	Materiales de Montaje de Extinción Fija	2020-05-24 03:18:29.954671	2020-05-24 03:18:30.008481	f
17	Tuberias Sistemas Fijos de Extinción con agua	2020-05-24 03:18:29.954671	2020-05-24 03:18:30.008481	f
18	Válvulas y Sensores de flujo	2020-05-24 03:18:29.954671	2020-05-24 03:18:30.008481	f
10	 SACI común	2020-05-24 03:18:29.954671	2020-07-08 00:06:40	t
\.


--
-- Data for Name: validated_list_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.validated_list_item (id, seisa_code, product_name, tecnic_description, price, um_id, validated_list_id, tech_contrato, tech_posicion, tech_codigo, tech_descripcion, tech_precio, created_at, updated_at, active, picture) FROM stdin;
1343	\N	IPF- 39. Completo (Siamesa y cofre metálico)	 Boca de Salida en piso para Columna seca (Modelo IPF-39). Formado por la  Válvula Siamesa con entrada roscada NPT de 21/2"  y  (2) dos salidas de 11/2", equipadas con válvulas, racores Barcelona y tapas con dispositivos de purga de aire junto con el Cofre metálico (caja y marco pintado en rojo/blanco, para instalar cristal con pegatina “USO EXCLUSIVO DE BOMBEROS”). Medidas de la caja con el marco estándar 590 ancho x 345 alto x 400 de profundidad (mm).Medidas del cristal 225x510 mm. 	0	1	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1344	\N	IPF- 40. Completo (Siamesa, válvula de esfera y cofre metálico)	Boca de Salida en piso con válvula de seccionamiento para la Columna seca (Modelo IPF-40). Formado por la  Válvula Siamesa con entrada roscada NPT de 21/2"  y  (2) dos salidas de 11/2", equipadas con válvulas, racores Barcelona y tapas con dispositivos de purga de aire,  una válvula de esfera de 3" y por un cofre metálico (caja y marco pintado en rojo/blanco, para instalar cristal con pegatina “USO EXCLUSIVO DE BOMBEROS”). Medidas de la caja con el marco estándar 600 ancho x550 alto x 300 de profundidad (mm). Puerta metálica con cristal de medidas 550x600 mm. 	0	1	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1345	\N	IPF- 41. Completo (Siamesa y cofre metálico)	Toma de fachada para la Columna seca (Modelo IPF-41). Formado por la  Válvula Siamesa con entrada roscada NPT de 3"  y  (2) dos salidas de 21/2", equipadas con válvulas, racores Barcelona y tapas con dispositivos de purga de aire y por un cofre metálico con puerta ciega dimensiones 550x 400x 300 mm. Tanto la puerta de la caja como el marco pintados en rojo y llevan la inscripción  “USO EXCLUSIVO DE BOMBEROS”). 	0	1	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1346	\N	Unión Universal SOC X SOC ¾"	Unión Universal SOC X SOC ¾"	0	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1347	\N	Unión Universal SOC X SOC 1"	Unión Universal SOC X SOC 1"	0	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1348	\N	Unión Universal SOC X SOC 1¼"	Unión Universal SOC X SOC 1¼"	0	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1349	\N	Unión Universal SOC X SOC 1½"	Unión Universal SOC X SOC 1½"	0	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1350	\N	Unión Universal SOC X SOC 2"	Unión Universal SOC X SOC 2"	0	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1351	\N	Válvula Completa de BIE de 45 mm (1-1/2") con Racor BCN + Manómetro	Válvula BIE de  45 mm (1-1/2") de laton y aluminio  con cierre de asiento plano (tipo de apertura lenta), ángulo formado entre entrada y la salida comprendido entre 90 º y 135º. Se suministrará completa de  con racor Barcelona y manómetro.	0	1	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1352	\N	Taco Expansor Nylon 6 mm	Taco Expansor de Nylon de 6 x 30 mm para tornillo de 3,5 - 5 mm	0.0109999999	1	1	m3503-073 Tornilleria, Fijaciones y Expansiones	7	m35037	Tornillo c/avellanada bicromatado rosca aglomerado y madera. \nØ 3,5 X 16 mm.	2,6	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1353	\N	Taco Expansor 8 mm	Taco Expansor de Nylon de 8 mm x 40 mm para tornillo de 4,5 - 6 mm	0.0219999999	1	1	m3505-073 Tornilleria, Fijaciones y Expansiones	21	m350521/73181491	Tornillo broca DIN 7504-K autoperforante con arandela de neopreno. ISO 15480. Acero cincado. Para union de placas o perfiles de acero entre si, 6.3 x 25 mm (DxL).	30	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1354	\N	Tornillo Autotaladrante 4,2 x 19 mm DIN 7504-P	Tornillo Autotaladrante o punta de broca de acero zincado DIN 7504-P Diametro: 4,2 mm, Largo: 19 mm (3/4") Cabeza Avellanada Philips H.	0.0219999999	1	1	m3505-073 Tornilleria, Fijaciones y Expansiones	29	m350529/73181210	Tornillo de acero inoxidable cabeza avellanada mortaja PH2 para la colocación de bisagras 4 x 25 mm  DIN 7505 A INOX A2.	11,93	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1355	\N	Arandela DIN 125 M-6 ZN	Arandela DIN 125 M-6 ZN, Arandela DIN 125. Acero zincado plata	0.0246399995	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1356	\N	Tuerca DIN 934 M-6 ZN	Tuerca DIN 934 M-6 ZN Tuerca DIN 934. Acero zincado plata	0.0246399995	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1357	\N	Tuerca DIN 934 M-8 ZN	Tuerca DIN 934 M-8 ZN Tuerca DIN 934. Acero zincado plata	0.0246399995	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1358	\N	Taco Expansor Nylon 5 mm	Taco Expansor de Nylon de 5 mm x 25 mm para tornillo de 2,5 - 4,2 mm	0.0329999998	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1359	\N	Arandela DIN 125 M-8 ZN	Arandela DIN 125 M-8 ZN, Arandela DIN 125. Acero zincado plata	0.0369599983	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1360	\N	Taco Expansor Nylon para Pladur	Taco Expansor de Nylon  para Pladur tipo espiral de 35 mm de largo para tornillo de 3 - 4,5  mm	0.0439999998	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1361	\N	Tornillo Autorroscante 4,2 x 22 mm DIN 7982	Tornillo Autorroscante de acero zincado DIN 7982 Diametro: 4,2 mm, Largo: 22 mm (7/8") Cabeza Avellanada Philips H.	0.0439999998	1	1	m3503-073 Tornilleria, Fijaciones y Expansiones	33	m350333	Taco nylon con tornillo para fijación en carton y yeso. Ref. NPL, Cod. 9ZNPL. Catalogo Apolo 	14,8	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1362	\N	Tornillo Autorroscante 4,8 x 25 mm  DIN 7982	Tornillo Autorroscante de acero zincado DIN 7982 Diametro: 4,8 mm Largo: 25 mm (1") Cabeza Avellanada Philips H.	0.0439999998	1	1	m3501-073 Tornilleria, Fijaciones y Expansiones	11	m350111/76.16.10.00	BIS  GOLD Conector clavable  para  paredes de yeso  y pladur con tornillo incluido de 4 x 30 mm. Fácil y rápido de usar. No taladrar, el  taco queda fijado  al apretar el tornillo.\nNo  gira  cuando   es  atornillado,  extraíble  sin  apenas dañar la pared. (Cant. min 1000)	159,79	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1363	\N	Arandela DIN 125 M-10 ZN	Arandela DIN 125 M-10 ZN, Arandela DIN 125. Acero zincado plata	0.049279999	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1364	\N	Anclaje Metálico Expansión Tornillo	Anclaje Metálico de Expansión Tornillo Exagonal Diametro 6 mm	0.0549999997	1	1	m3501-073 Tornilleria, Fijaciones y Expansiones	8	m35018/76.16.10.00	Tornillo para  aluminio  AL  FST  Ø 4,2 x 13 cincado. (Cant. min 1000)	24,18	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1365	\N	Tornillo Autorroscante 6 x 35 mm	Tornillo Autorroscante de acero zincado DIN 571 Diametro: 6 mm, Largo: 35 mm (1-1/2") Cabeza Hexagonal	0.0549999997	1	1	m3501-073 Tornilleria, Fijaciones y Expansiones	14	m350114/76.16.10.00	Anclaje  metálico  medida  tornillo M-8 x 80 mm. Ø 10 mm. (Cant. min 1000)	157,09	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1366	\N	Arandela DIN 125 M-12 ZN	Arandela DIN 125 M-12 ZN, Arandela DIN 125. Acero zincado plata	0.0615999997	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1367	\N	Clip de Acero OHS-SS	Clip de Acero Inoxidable para Sujeción del Cable Termosensible	0.0879999995	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1368	\N	Clip Plastico WAW	Clip Plastico para Sujeción del Cable Termosensible	0.0879999995	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1369	\N	Grapa HPC-2	Grapa para Sujeción del Cable Termosensible	0.0879999995	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1370	\N	Arandela DIN 125 M-16 ZN	Arandela DIN 125 M-16 ZN, Arandela DIN 125. Acero zincado plata	0.098559998	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1371	\N	Terminal Tipo U, 10 AWG	Terminal de Horquilla Preaislado (Tipo U) para Cable 10 AWG (5 mm2)	0.0989999995	1	1	18449-m38 Conectores y Empalmes	147	SFAU66 	TER.HORQUILLA 6MM AMARILLO PALA 6 275240	0,0484	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1372	\N	Junta para Válvula de 10 kg	Junta de estanqueidad para válvula para bocina manguera o vaso difusor, válida para extintor de 10 kg CO2. Fabricada en Nylon.	0.109999999	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1373	\N	Junta para Válvula de 2-5 kg	Junta de estanqueidad para válvula para bocina manguera o vaso difusor, válida para extintor de 2 kg, 5 kg  CO2. Fabricada en Nylon.	0.109999999	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1374	\N	Pasador de 3,5 mm	Pasador de seguridad de 3,5 mm con ranura y agujero	0.109999999	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1375	\N	Precinto de plastico para valvulas de extintores de polvo. Color rojo.	Precinto de plastico tipo candado, para valvulas de extintores de polvo. Color rojo.  (PLASTIC SEAL).	0.109999999	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1376	\N	Anclaje Metálico Expansión Tornillo	Anclaje Metálico de Expansión Tornillo Exagonal Diametro 8 mm	0.109999999	1	1	m3501-073 Tornilleria, Fijaciones y Expansiones	13	m350113/76.16.10.00	Anclaje metálico medida tornillo M-6 x 45 mm. Ø 8 mm. (Cant. min 1000)	81,59	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1377	\N	Anilla de seguridad extintor de PQS de 6 kgs, 9 kgs y 25 kgs	Anilla de seguridad para extintor de PQS de 6 kgs, 9 kgs y 25 kgs.(SAFETY SEAL (METAL) )	0.119999997	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1378	\N	Plástico Recambio PSm30	Plástico de recambio para Pulsador Manual serie M paquete de 10 pz.	0.120999999	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1379	\N	Taco Brida 8 mm x 35 mm	Taco Brida Autocentrable Diametro 8 mm x 35 mm de Largo, Admite Bridas de hasta 8,9 mm de Ancho	0.131999999	1	1	21709-042 Paneles, Pizarras Electricas y sus Componentes	9593	ENN47996	100 Taco-bridas, 9mm de largo, negro	15,81	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1380	\N	Manguito separador Hexagonal  M-10  x 30 ZN	Manguito separador Hexagonal  M-10  x 30 ZN, Manguito separador Hexagonal. Acero zincado plata	0.135519996	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1381	\N	Difusor de Polipropileno 	Difusor de Polipropileno, para extintor de  1 y3 kg. (NOZZLE 1 KG AND 3 KG).	0.140000001	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1382	\N	Grapa Tipo F 20 mm 1/2"	Grapas Reforzadas Tipo F-20 para Tuberías Plásticas Ø Ext. 20 mm, Agujero Tornillo Ø 6,5 mm	0.143000007	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1383	\N	Tapa para Caja Metalica 2x4	Tapa Metalica para Caja Metalica 2x4 de Acero Electrogalvanizado o Galvanizado en Caliente	0.150000006	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1384	\N	Tapa para Caja Metalica 4x4	Tapa Metalica para Caja Metalica 4x4 de Acero Electrogalvanizado o Galvanizado en Caliente	0.150000006	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1385	\N	Grapa Tipo F 22 mm 1/2"-3/4"	Grapas Reforzadas Tipo F-22 para Tuberías Plásticas Ø Ext. 22 mm, Agujero Tornillo Ø 6,5 mm	0.153999999	1	1	31192-260 Soportería 	99	3119299	BIS GRAPA ZINCADA, 22MM. COD ISOFIX 805122 EN CAJAS DE 100 UDS 	5,64	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1386	\N	Manguito separador Hexagonal  M-12  x 40 ZN	Manguito separador Hexagonal  M-12  x 40 ZN, Manguito separador Hexagonal. Acero zincado plata	0.160160005	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1387	\N	Manguito separador Hexagonal  M-6  x 20 ZN	Manguito separador Hexagonal  M-6  x 20 ZN, Manguito separador Hexagonal. Acero zincado plata	0.160160005	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1388	\N	Tuerca DIN 934 M-10 ZN	Tuerca DIN 934 M-10 ZN Tuerca DIN 934. Acero zincado plata	0.160160005	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1389	\N	Brida Plástica 7,6 x 368 mm	Brida Plástica Incoloras Ancho: 7,6 mm, Largo 368 mm. Carga Máxima 54 Kg	0.165000007	1	1	21709-042 Paneles, Pizarras Electricas y sus Componentes	9560	ENN46916	1000 Bridas-Cintura de 200x4,8mm incoloras	74,4	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1390	\N	Tuerca DIN 934 M-12 ZN	Tuerca DIN 934 M-12 ZN Tuerca DIN 934. Acero zincado plata	0.172480002	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1391	\N	Grapa Tipo F 25 mm 3/4"	Grapas Reforzadas Tipo F-25 para Tuberías Plásticas Ø Ext. 25 mm, Agujero Tornillo Ø 6,5 mm	0.175999999	1	1	31192-260 Soportería 	99	3119299	BIS GRAPA ZINCADA, 22MM. COD ISOFIX 805122 EN CAJAS DE 100 UDS 	5,64	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1392	\N	Taco Brida 6 mm x 25 mm	Taco Brida Autocentrable Diametro 6 mm x 25 mm de Largo, Admite Bridas de hasta 7,6 mm de Ancho	0.187000006	1	1	31192-260 Soportería 	100	31192100	BIS GRAPA ZINCADA, 26MM. COD ISOFIX 805126 EN CAJAS DE 100 UDS 	7	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1393	\N	Manguito separador Hexagonal  M-8  x 30 ZN	Manguito separador Hexagonal  M-8  x 30 ZN, Manguito separador Hexagonal. Acero zincado plata	0.197119996	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1394	\N	Terminal Tipo U, 8 AWG	Terminal de Horquilla Preaislado (Tipo U) para Cable 8 AWG (9 mm2)	0.197999999	1	1	18449-m38 Conectores y Empalmes	148	SFAU68 	TER.HORQUILLA 6MM AMARILLO PALA 8 275250	0,0527	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1395	\N	Colgador para Extintor 2 Kg	Colgador mural metalico para CO2 2 Kg (Wall bracket for CO2 2 Kg.)	0.209999993	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1396	\N	Tuerca DIN 934 M-16 ZN	Tuerca DIN 934 M-16 ZN Tuerca DIN 934. Acero zincado plata	0.221760005	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1397	\N	Racor Recto, Diámetro 1/2"	Conector (Racor) Recto de Poliamida para Tubería Flexible PVC, Diámetro Ext 20 mm 	0.310000002	1	1	28043 EMPOTRAMIENTO ELECTRICO	20	PM ICTA25F	Tuberia corrugada flexible ICTA de GEWISS de 25 mm con guia de Acero DX16325 Blanca	0,29	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1398	\N	Tubo sonda de PQS de 1 kg.	Tubo sonda para extintor de PQS de 1 kgs de 340 mm de largo (DEEP TUBE1KG) fabricado en pvc con corte en 45 grados en extremo inferior.	0.239999995	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1399	\N	Barrena para Metal 2 mm	Barrena para Metal, Diámetro: 2,5 mm, Largo: 57 mm. HSS	0.241999999	1	6		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1400	\N	Conector Macho para Tubería Rígida Metalica EMT 1/2"	Conector Macho Metalico de Acero Electrogalvanizado o Galvanizado en Caliente para Tubería Rígida Metalica EMT 1/2" Diámetro 1/2¨ Diámetro Int. 12 mm	0.25	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1401	\N	Accesorio Terminal, 20x10 mm	Accesorio de Canaleta, Terminal, Color Blanco para Canaleta 20 x 10 mm 	0.263999999	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1402	\N	Alambre de Acero 	Alambre de Acero de Diámetro: 1 mm, No. 18, para Mandrilar Mangueras	0.275000006	2	6		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1403	\N	Taco Expansor Metálico para Pladur	Taco de Expansor de Metal  para Pladur tipo espiral de 35 mm de largo para tornillo de 3 - 5 mm	0.275000006	1	1	m3501-073 Tornilleria, Fijaciones y Expansiones	3	m35013/76.16.10.00	Rapitac  6/40 taco con tornillo incorporado.  (Cant. min\n1000)	15,32	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1404	\N	Accesorio Ángulo Externo, 20x10 mm	Accesorio de Canaleta, Ángulo Externo, Color Blanco para Canaleta 20 x 10 mm	0.296999991	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1405	\N	Accesorio Ángulo Interno, 20x10 mm	Accesorio de Canaleta, Ángulo Interno, Color Blanco para Canaleta 20 x 10 mm	0.296999991	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1406	\N	Accesorio Curva Plana, 20x10 mm	Accesorio de Canaleta, Curva Plana, Color blanco para Canaleta 20 x 10 mm	0.296999991	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1407	\N	Accesorio Derivación T, 20x10 mm	Accesorio de Canaleta, Derivación en T, Color Blanco para Canaleta 20 x 10 mm	0.296999991	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1408	\N	Unión para Tubería Rígida Metalica EMT 1/2"	Unión Metalica de Acero Electrogalvanizado o Galvanizado en Caliente para Tubería Rígida Metalica EMT 1/2" Diámetro 1/2¨ Diámetro Int. 12 mm	0.300000012	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1409	\N	Tubo sonda de PQS de 3 kg.	Tubo sonda para extintor de PQS de 3 kgs de 481 mm de largo (DEEP TUBE 3 KG) fabricado en pvc con corte en 45 grados en extremo inferior.	0.319999993	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1410	\N	Anclaje hembra SA - 6	Anclaje hembra SA - 6, Anclaje metálico de expansión con rosca interna para cargas medias. Acero cincado electrolítico de 5 micras de espesor, expansión por impacto para fijación en hormigón y materiales duros	0.32032001	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1411	\N	Anclaje hembra SA - 8	Anclaje hembra SA - 8, Anclaje metálico de expansión con rosca interna para cargas medias. Acero cincado electrolítico de 5 micras de espesor, expansión por impacto para fijación en hormigón y materiales duros	0.32032001	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1412	\N	Accesorio Terminal, 30x10 mm	Accesorio de Canaleta, Terminal, Color Blanco para Canaleta 30 x 10 mm 	0.340999991	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1413	\N	Racor Recto, Díametro 3/4"	Conector (Racor) Recto de Poliamida para Tubería Flexible PVC, Diámetro Ext 25 mm 	0.351999998	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1414	\N	Grapa Tipo F 32 mm 1"	Grapas Reforzadas Tipo F-32 para Tuberías Plásticas Ø Ext. 32 mm, Agujero Tornillo Ø 6,5 mm	0.351999998	1	1	31192-260 Soportería 	100	31192100	BIS GRAPA ZINCADA, 26MM. COD ISOFIX 805126 EN CAJAS DE 100 UDS 	7	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1415	\N	Tapón SOC ¾" Soldado BM CAM	Tapón SOC ¾" Soldado BM CAM, estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	0.351999998	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1416	\N	Grapa Metalica Isofonica GMI  MG28 ϕ=3/4"	Grapa Metalica Isofonica GMI  MG28 ϕ=¾" Grapas metálicas isofónicas. Multigrap. Para sujeción de tubos en batería de Cu. y de\nFe., con banda de caucho EPDM	0.357279986	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1417	\N	Tubo sonda de PQS de 6 kg.	Tubo sonda para extintor de PQS de 6 kgs de 561 mm de largo (DEEP TUBE 6 KG) fabricado en pvc con corte en 45 grados en extremo inferior.	0.360000014	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1418	\N	Canaleta 20x10 mm	Canaleta con Tapa,  Color Blanco, 20x10 mm  	0.363000005	2	1		26389	NSYTRV62PE	Terminal de tornillo tierra, 2pts, 6mm2  - Linergy TR	112,53	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1419	\N	Accesorio Terminal, 40x16,5 mm	Accesorio de Canaleta, Terminal, Color Blanco para Canaleta 40 x 16,5 mm 	0.38499999	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1420	\N	Barrena para Metal 5 mm	Barrena para Metal, Diámetro: 5 mm, Largo: 85 mm. HSS	0.38499999	1	6		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1421	\N	Tornillo M10 x 40 mm	Tornillo Totalmente roscado de acero zincado de Cabeza Hexagonal  M10, Largo: 40 mm DIN 933 8.8, 	0.394239992	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1422	\N	Accesorio Ángulo Externo, 30x10 mm	Accesorio de Canaleta, Ángulo Externo, Color Blanco para Canaleta 30 x 10 mm	0.395999998	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1423	\N	Accesorio Ángulo Interno, 30x10 mm	Accesorio de Canaleta, Ángulo Interno, Color Blanco para Canaleta 30 x 10 mm	0.395999998	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1424	\N	Accesorio Curva Plana, 30x10 mm	Accesorio de Canaleta, Curva Plana, Color blanco para Canaleta 30 x 10 mm	0.395999998	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1425	\N	Accesorio Derivación T, 30x10 mm	Accesorio de Canaleta, Derivación en T, Color Blanco para Canaleta 30 x 10 mm	0.395999998	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1426	\N	Conector Macho para Tubería Rígida Metalica EMT 3/4" 	Conector Macho Metalico de Acero Electrogalvanizado o Galvanizado en Caliente para Tubería Rígida Metalica EMT 3/4" Diámetro 3/4¨ Diámetro Int. 18 mm	0.400000006	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1427	\N	Conector Recto Metalico para Tubo Flexible Metalico EMT 1/2"	Conector Recto Metalico de Acero Electrogalvanizado o Galvanizado en Caliente para Tubo Flexible Metalico EMT 1/2¨, Diámetro Int. 15 mm, Diámetro Ext. 20 mm	0.400000006	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1428	\N	Conector Recto Metalico para Tubo Flexible Metalico EMT Forrado con Goma LIQUIDTIGHT 1/2"	Conector Recto Metalico de Acero Electrogalvanizado o Galvanizado en Caliente para Tubo Flexible Metalico Forrado con Goma LIQUIDTIGHT 1/2¨, Diámetro Int. 15 mm, Diámetro Ext. 20 mm 	0.400000006	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1429	\N	Accesorio Ángulo Externo, 40x16,5 mm	Accesorio de Canaleta, Ángulo Externo, Color Blanco para Canaleta 40 x 16,5 mm 	0.407000005	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1430	\N	Accesorio Ángulo Interno, 40x16,5 mm	Accesorio de Canaleta, Ángulo Interno, Color Blanco para Canaleta 40 x 16,5 mm 	0.407000005	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1431	\N	Accesorio Curva Plana, 40x16,5 mm	Accesorio de Canaleta, Curva Plana, Color blanco para Canaleta 40 x 16,5 mm 	0.407000005	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1432	\N	Accesorio Derivación T, 40x16,5 mm	Accesorio de Canaleta, Derivación en T, Color Blanco para Canaleta 40 x 16,5 mm 	0.407000005	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1433	\N	Colgador para Extintor 5 Kg	Colgador mural metalico para CO2 5 Kg (Wall bracket for CO2 5 Kg.)	0.419999987	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1434	\N	Abrazadera isofónica ϕ=¾"	Abrazadera isofónica RI-35 (M8+M10) ϕ=¾"	0.431199998	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1435	\N	Caja Metalica 2x4 sin Tapa	Caja Metalica 2x4 con profundidad 1-1/2" (38mm) y tres huecos por caras 1/2"x 3/4”x 1/2” de Acero Electrogalvanizado o Galvanizado en Caliente	0.449999988	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1436	\N	Unión para Tubería Rígida Metalica EMT 3/4" 	Unión Metalica de Acero Electrogalvanizado o Galvanizado en Caliente para Tubería Rígida Metalica EMT 3/4" Diámetro 3/4¨ Diámetro Int. 18 mm	0.449999988	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1437	\N	Soporte mural metalico para extintores de 3, 6 y 9 Kg de polvo.	Soporte mural metalico para extintores de 3, 6 y 9 Kg de polvo, acero galvanizado. (WALL BRACKET FOR PQS)	0.460000008	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1438	\N	Tubo sonda de PQS de 9 kg. 	Tubo sonda para extintor de PQS de 9 kgs de 588 mm de largo (DEEP TUBE 9 KG) fabricado en pvc con corte en 45 grados en extremo inferior.	0.460000008	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1439	\N	Racor Recto, Díametro 1"	Conector (Racor) Recto de Poliamida para Tubería Flexible PVC, Diámetro Ext 32 mm 	0.462000012	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1440	\N	Abrazadera isofónica  ϕ=1"	Abrazadera isofónica RI-28 (M8+M10) ϕ=1"	0.468160003	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1441	\N	Anclaje hembra SA - 10	Anclaje hembra SA - 10, Anclaje metálico de expansión con rosca interna para cargas medias. Acero cincado electrolítico de 5 micras de espesor, expansión por impacto para fijación en hormigón y materiales duros	0.468160003	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1442	\N	Lija Impermeable 120	Lija Impermeable de Grano 120	0.47299999	1	6		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1443	\N	Barrena para Metal 6 mm	Barrena para Metal, Diámetro: 6 mm, Largo: 93 mm. HSS	0.483999997	1	6		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1444	\N	Caja Metalica 4x4 sin Tapa	Caja Metalica 4x4 con profundidad 1-1/2" (38mm) y tres huecos por caras 1/2"x 3/4”x 1/2” de Acero Electrogalvanizado o Galvanizado en Caliente	0.5	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1445	\N	Anclaje hembra SA - 12	Anclaje hembra SA - 12, Anclaje metálico de expansión con rosca interna para cargas medias. Acero cincado electrolítico de 5 micras de espesor, expansión por impacto para fijación en hormigón y materiales duros	0.529760003	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1446	\N	Junta de silicona para valvulas 1 - 3 kg.	Junta de silicona para valvulas 1 - 3 kg. (SILICON GASKET NECK RING VALVE 1  -3 KG).	0.529999971	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1447	\N	Junta de silicona para valvulas 6 - 9 - 25 kg.	Junta de silicona para valvulas 6 - 9 - 25 kg. (SILICON GASKET NECK RING VALVE 6-9-25 KG).	0.529999971	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1448	\N	Lija Impermeable 100	Lija Impermeable de Grano 100	0.538999975	1	6		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1449	\N	Conector Macho para Tubería Rígida Metalica EMT 1" 	Conector Macho Metalico de Acero Electrogalvanizado o Galvanizado en Caliente para Tubería Rígida Metalica EMT 1" Diámetro 1¨ Diámetro Int. 25 mm	0.550000012	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1450	\N	Unión para Tubería Rígida Metalica EMT 1" 	Unión Metalica de Acero Electrogalvanizado o Galvanizado en Caliente para Tubería Rígida Metalica EMT 1" Diámetro 1¨ Diámetro Int. 25 mm	0.550000012	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1451	\N	Abrazadera isofónica ϕ=1¼"	Abrazadera isofónica RI-40 (M8+M10) ϕ=1¼"	0.566720009	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1452	\N	Abrazadera isofónica  ϕ=1½"	Abrazadera isofónica RI-50 (M8+M10) ϕ=1½"	0.566720009	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1453	\N	Cable de Red UTP	Cable de Red UTP Cat. 6 (CCTV-SCA)	0.572000027	2	1	19259-m38 Cables de Corrientes Débiles y Telefónicos	36	/8544.49.95	SUMCAB Sumsave UTP Cat.6 4x2xAWGm3/1	0,29	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1454	\N	Canaleta 30x10 mm	Canaleta Color Blanco 30 x 10 mm 	0.572000027	2	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1455	\N	Lija Impermeable 80	Lija Impermeable de Grano 80	0.572000027	1	6		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1456	\N	Terminal de Ojo M-8, 6 AWG	Terminal de Ojo M-8, Preaislado para Cable 6 AWG (13 mm2)	0.572000027	1	1	18449-m38 Conectores y Empalmes	14	SFT168	TERNINAL COBRE 16MM M8 T-16/8 010330	0,086	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1457	\N	Tornillo M12 x 90 mm	Tornillo Totalmente roscado de acero zincado de Cabeza Hexagonal  M12, Largo: 90 mm DIN 933 8.8, 	0.579039991	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1458	\N	Tapón SOC 1¼" Soldado BM CAM	Tapón SOC 1¼" Soldado BM CAM, estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	0.583000004	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1459	\N	Brida Plástica 4,8 x 186 mm	Brida Plástica Incoloras Ancho: 4,8 mm, Largo 186 mm. Carga Máxima 22 Kg	0.593999982	1	1	21709-042 Paneles, Pizarras Electricas y sus Componentes	9594	ENN47998	100 Taco-bridas a distancia, designación EC8, 9mm de largo, negro	21,39	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1460	\N	Conjunto eje para cierre  valvulas de 1 y 3 kg.	Conjunto eje montado,  para cierre  valvulas de 1 y 3 kg, laton y plastico endurecido. (SPARE VALVE 6,9,25 KG WITH GASKET AND SPRING).	0.610000014	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1461	\N	Conjunto eje   para cierre  valvulas de 6,9 y 25 kg.	Conjunto eje montado,  para cierre  valvulas de 6,9 y 25 kg, laton y plastico endurecido. (SPARE VALVE 6,9,25 KG WITH GASKET AND SPRING).	0.610000014	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1462	\N	Tubo Sonda 2 kgs	Tubo sonda CO2 2 KGS	0.610000014	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1463	\N	Varilla roscada  DIN 975  M-8  x 1000 ZN	Varilla roscada  DIN 975  M-8  x 1000 ZN Varilla roscada  DIN 975. Acero zincado plata	0.615999997	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1464	\N	Junta de silicona para valvula 50 kg.	Junta de silicona para valvula 50 kg. (SILICON GASKET NECK RING VALVE 50 KG).	0.629999995	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1465	\N	Cristal Recambio SUS758	Cristal de recambio para Pulsador Manual  serie M paquete de 10 pz	0.638000011	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1466	\N	Cristal Recambio SUS758	Cristal de recambio para Pulsador Manual serie M paquete de 10 pz	0.638000011	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1467	\N	Abrazadera isofónica  ϕ=2"	Abrazadera isofónica RI-60 (M8+M10) ϕ=2"	0.64064002	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1468	\N	Varilla roscada  DIN 975  M-6  x 1000 ZN	Varilla roscada  DIN 975  M-6  x 1000 ZN Varilla roscada  DIN 975. Acero zincado plata	0.652960002	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1469	\N	Eje de 10 Kg	Eje para valvula 10 Kg CO2	0.670000017	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1470	\N	Eje de 2-5 Kg	Eje para valvula 2 y 5Kg CO2	0.670000017	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1471	\N	Abrazadera ϕ=1½"	Abrazadera FIRCLAM FC-50 ϕ=1½"	0.677600026	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1472	\N	Disco de Seguridad Válvula de 10 kg	Disco de seguridad para válvulas de CO2  de 10 kg. Fabricado en lámina de latón.Tarados a 190 bar +/- 10%	0.699999988	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1473	\N	Disco de Seguridad Válvula de 2-5 kg	Disco de seguridad para válvulas de CO2 de 2 kg y 5 kg. Fabricado en lámina de latón.Tarados a 190 bar +/- 10%	0.699999988	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1474	\N	Tapón SOC 1½" Soldado BM CAM	Tapón SOC 1½" Soldado BM CAM, estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	0.703999996	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1475	\N	Abrazadera isofónica  ϕ=2½"	Abrazadera isofónica RI-75 (M8+M10) ϕ=2½"	0.714559972	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1476	\N	Unidad de Cierre	Unidad de cierre completo  CO2 10 Kg	0.74000001	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1477	\N	Vastago 10 Kg	Vastago montado 10 Kg CO2	0.779999971	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1478	\N	Vastago 2-5 Kg	Vastago montado 2 y 5Kg CO2	0.779999971	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1479	\N	Oxigeno Gas 	Oxigeno Gas 	0.791999996	6	6		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1480	\N	Terminal de Ojo M-10, 2 AWG	Terminal de Ojo M-10, Preaislado para Cable 2 AWG (33 mm2) 	0.791999996	1	1	18449-m38 Conectores y Empalmes	22	SFT3510	TERMINAL COBRE 35MM M10 T-35/10 010430	0,2103	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1481	\N	Terminal de Ojo  M-10, 4 AWG	Terminal de Ojo M-10, Preaislado para Cable 4 AWG (21 mm2)	0.791999996	1	1	18449-m38 Conectores y Empalmes	19	SFT2510	TERMINAL COBRE 25MM M10 010380	0,1444	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1482	\N	Conector Recto Metalico para Tubo Flexible  Metalico EMT 3/4"	Conector Recto Metalico de Acero Electrogalvanizado o Galvanizado en Caliente para Tubo Flexible Metalico EMT 3/4¨, Diámetro Int. 20 mm, Diámetro Ext. 25 mm	0.800000012	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1483	\N	Conector Recto Metalico para Tubo Flexible Metalico EMT Forrado con Goma LIQUIDTIGHT 3/4"	Conector Recto Metalico de Acero Electrogalvanizado o Galvanizado en Caliente para Tubo Flexible Metalico Forrado con Goma LIQUIDTIGHT 3/4¨, Diámetro Int. 20 mm, Diámetro Ext. 25 mm 	0.800000012	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1484	\N	Anclaje hembra SA - 16  	Anclaje hembra SA - 16, Anclaje metálico de expansión con rosca interna para cargas medias. Acero cincado electrolítico de 5 micras de espesor, expansión por impacto para fijación en hormigón y materiales duros	0.800800025	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1485	\N	Abrazadera isofónica  ϕ=3"	Abrazadera isofónica RI-90 (M8+M10) ϕ=3"	0.813120008	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1486	\N	Cable Corrientes Débiles Multivías 8+2 Vías	Cable Multivias Apantallado 2x18 AWG + 8x22 AWG (0.75mm2x0.22mm2) (Alarma SACI)	0.81400001	2	1	19259-m38 Cables de Corrientes Débiles y Telefónicos	126	/8544.49.95	SUMCAB Sumsave Alarma 8x0,22mm2 + 2x0,75mm2	0,52	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1487	\N	Soporte abrazadera para PQS  1 Kg.	Soporte abrazadera para PQS  1Kg, material acero revestido con silicona, uso vehiculo. (BRACKET  1 KG).	0.829999983	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1488	\N	Terminal de Ojo	Terminal de Ojo Estañado (M-10)  para Cable 1/0 AWG (50 mm2)	0.847000003	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1489	\N	Pasador  para Válvula de 2-5 kg	Pasador (Remache) de manetas,  válvula de 1 kg, 2 kg y 5 kg CO2. Fabricado en acero inoxidable.	0.850000024	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1490	\N	Cable Coaxial Siames	Cable Coaxial RG-59 de 75 Ohm + 2X1.00mm2 (CCTV)	0.85799998	2	1	19259-m38 Cables de Corrientes Débiles y Telefónicos	33	/8544.49.95	SUMCAB Sumsave Coax Combi RG59 + (2x1)  LSZH	0,49	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1491	\N	Tubo Sonda 5 kgs	Tubo sonda CO2 5 KGS	0.879999995	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1492	\N	Cable Antiflama 2x18 AWG	Cable Antiflama Apantallado 2x18 AWG (1.00 mm2) con Cubierta PVC Rojo (Incendios SADI)	0.879999995	2	1	19259-m38 Cables de Corrientes Débiles y Telefónicos	83	/8544.49.95	SUMCAB Sumsave AS+ Data Segur Fire 2x1 mm2	0,61	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1493	\N	Llave SC070	Paquete con diez llaves de prueba	0.890999973	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1494	\N	Llave SC070	Paquete con diez llaves de prueba	0.890999973	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1495	\N	Abrazadera  ϕ=2½"	Abrazadera FIRCLAM FC-75 ϕ=2½"	0.911679983	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1496	\N	Brida PM-3	Brida para Sujeción del Cable Termosensible	0.912999988	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1497	\N	Tornillo M16 x 150 mm	Tornillo Totalmente roscado de acero zincado de Cabeza Hexagonal  M16, Largo: 150 mm DIN 933 8.8, 	0.924000025	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1498	\N	Tapón SOC 2" Soldado BM CAM	Tapón SOC 2" Soldado BM CAM, estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	0.935000002	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1499	\N	Abrazadera Colgante ϕ=1"	Abrazadera Colgante C-35 ϕ=1" Abrazadera Colgante, para sujeción de tubos contraincendios.\nAcabado Acero cincado plata.	0.936320007	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1500	\N	Muelle 10 kgs	Muelle para valvula CO2 10 kg	0.939999998	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1501	\N	Muelle 2-5 kgs	Muelle para valvula CO2 2-5 kg	0.939999998	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1502	\N	Tape Eléctrico	Tape Eléctrico o Cinta Eléctrica, Multiuso, Color: Negro. Resistencia a Tracción de: 45 lb/in (79 N/cm), % de Enlongación: 2%. Resistencia Dieléctrica 5,5 kV, Soporta temperaturas de hasta: 130 °C	0.94599998	1	6		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1503	\N	Peana para extintor de PQS de 6 kgs. 	Peana para extintor de PQS de 6 kgs. De Polipropileno de alta resistencia. (PLASTIC BOTTOM 6 KG).	0.959999979	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1504	\N	Cable Coaxial	Cable Coaxial RG-59 de 75 Ohm (CCTV)	0.967999995	2	1	19259-m38 Cables de Corrientes Débiles y Telefónicos	30	/8544.49.95	SUMCAB Sumsave Coax RG59 1x75Ohm LSZH	0,25	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1505	\N	Varilla roscada  DIN 975  M-10  x 1000 ZN	Varilla roscada  DIN 975  M-10  x 1000 ZN Varilla roscada  DIN 975. Acero zincado plata	0.985599995	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1506	\N	Conector Macho KRALOY SCH40 PVC 1/2"	Conector Macho KRALOY Conduit SCH 40 PVC Diámetro 1/2¨ Diámetro Int. 12 mm  para exteriores resistente al fuego y rayos solares.	0.99000001	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1507	\N	Abrazadera Colgante ϕ=1½"	Abrazadera Colgante C-50 ϕ=1½" Abrazadera Colgante, para sujeción de tubos contraincendios.\nAcabado Acero cincado plata.	1.02256	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1508	\N	Abrazadera ϕ=2"	Abrazadera FIRCLAM FC-60 ϕ=2"	1.03488004	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1509	\N	Tubo sonda de PQS de 25 kg.	Tubo sonda para extintor de PQS de 25 kgs. (DEEP TUBE 25 KG).	1.05999994	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1510	\N	Tubería Flexible PVC 1/2" con Guía (Blanca)	Tubería Flexible PVC con Guía Interior, Diámetro 1/2¨, Diámetro Int. 15 mm, Diámetro Ext. 20 mm (Color Blanco)	1.07799995	2	1	28043 EMPOTRAMIENTO ELECTRICO	20	PM ICTA25F	Tuberia corrugada flexible ICTA de GEWISS de 25 mm con guia de Acero DX15125 Negra	0,29	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1511	\N	Tubería Flexible PVC 1/2" con Guía (Negra)	Tubería Flexible PVC con Guía Interior, Diámetro 1/2¨, Diámetro Int. 15 mm, Diámetro Ext. 20 mm (Color Negro)	1.07799995	2	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1512	\N	Abrazadera isofónica  ϕ=4"	Abrazadera isofónica RI-110 (M8+M10) ϕ=4"	1.08415997	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1513	\N	Cable de Red FTP	Cable de Red Apantallado Global FTP Cat. 6 (Para uso en exterior) (CCTV, SCA)	1.08899999	2	1	19259-m38 Cables de Corrientes Débiles y Telefónicos	38	/8544.49.95	SUMCAB Sumsave FTP Cat.6 4x2xAWGm3/1	0,38	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1514	\N	Abrazadera Colgante ϕ=1¼"	Abrazadera Colgante C-40  ϕ=1¼" Abrazadera Colgante, para sujeción de tubos contraincendios.\nAcabado Acero cincado plata.	1.09648001	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1515	\N	Conector Tipo Perro	Conector Tipo Perro 3/16" para Cables de Retenida 3/16" (Acero)	1.10000002	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1516	\N	Unión KRALOY SCH40 PVC 1/2"	Unión KRALOY Conduit SCH 40 PVC Diámetro 1/2¨ Diámetro Int. 12 mm  para exteriores resistente al fuego y rayos solares.	1.11000001	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1517	\N	Manguito separador Hexagonal  M-16  x 50 ZN	Manguito separador Hexagonal  M-16  x 50 ZN, Manguito separador Hexagonal. Acero zincado plata	1.12111998	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1518	\N	Cable Antiflama 2x16 AWG	Cable Antiflama Apantallado 2x16 AWG (1.50 mm2) con Cubierta PVC Rojo (Incendios SADI)	1.12199998	2	1	19259-m38 Cables de Corrientes Débiles y Telefónicos	71	/8544.49.95	SUMCAB Sumsave AS + Data Segur Fire 2x1,5mm2	0,63	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1519	\N	Tapón SOC 2½" Soldado BM CAM	Tapón SOC 2½" Soldado BM CAM, estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	1.16600001	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1520	\N	Polvo químico para extintor ABC  55 %.	Polvo químico para extintor ABC, 55% de fosfato mono amónico, en sacos de 25 kgs Color Amarillo. (DRY CHEMICAL POWDER 55%).	1.16999996	4	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1521	\N	Abrazadera Colgante ϕ=2"	Abrazadera Colgante C-60  ϕ=2" Abrazadera Colgante, para sujeción de tubos contraincendios.\nAcabado Acero cincado plata.	1.17040002	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1522	\N	Conjunto Pasador Válvula de 10 kg	Conjunto Pasador de Seguridad, válvula de 10 kg CO2. Fabricado en acero inoxidable y polietileno de alta densidad. (SAFETY SEAL (METAL)	1.17999995	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1523	\N	Conjunto Pasador Válvula de 2-5 kg	Conjunto Pasador de Seguridad, válvula de 2 kg y 5 kg CO2. Fabricado en acero inoxidable y polietileno de alta densidad. (SAFETY SEAL (METAL)	1.17999995	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1524	\N	Hoja de segueta 24	Hoja de segueta 24	1.18799996	1	6		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1525	\N	Conector Recto Metalico para Tubo Flexible Metalico EMT 1"	Conector Recto Metalico de Acero Electrogalvanizado o Galvanizado en Caliente para Tubo Flexible Metalico EMT 1¨, Diámetro Int. 25 mm, Diámetro Ext. 32 mm	1.20000005	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1526	\N	Conector Recto Metalico para Tubo Flexible Metalico EMT Forrado con Goma LIQUIDTIGHT 1"	Conector Recto Metalico de Acero Electrogalvanizado o Galvanizado en Caliente para Tubo Flexible Metalico Forrado con Goma LIQUIDTIGHT 1¨, Diámetro Int. 25 mm, Diámetro Ext. 32 mm 	1.20000005	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1527	\N	Cable Eléctrico 10 AWG con cubierta de PVC (rollo de 50m)	Cable Monoconductor Calibre 10 AWG (6 mm2) con Cubierta PVC Verde-Amarillo	1.21000004	2	1	19830-m38 Cables Eléctricos	6	8544.30.00	Sumcab Sumflex H07V-K 450/750V 1x6mm	0,366	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1528	\N	Codo 45º ¾" Soldado BM (CAMxCAM) 	Codo 45º ¾" Soldado BM (CAMxCAM), estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	1.21000004	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1529	\N	Abrazadera ϕ=3"	Abrazadera FIRCLAM FC-90 ϕ=3"	1.21967995	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1530	\N	Vientos de Torreta	Cable de Acero 3/16" para Retenida de Vientos. 	1.25399995	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1531	\N	Grapa Metalica Isofonica GMI  MG60 ϕ=2"	Grapa Metalica Isofonica GMI  MG60 ϕ=2" Grapas metálicas isofónicas. Multigrap. Para sujeción de tubos en batería de Cu. y de\nFe., con banda de caucho EPDM	1.29359996	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1532	\N	Varilla roscada  DIN 975  M-12  x 1000 ZN	Varilla roscada  DIN 975  M-12  x 1000 ZN Varilla roscada  DIN 975. Acero zincado plata	1.30592	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1533	\N	Peana para extintor de PQS de 9 kgs. 	Peana para extintor de PQS de 9 kgs. De Polipropileno de alta resistencia. (PLASTIC BOTTOM 9 KG).	1.32000005	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1534	\N	Juntas de goma  tóricas Ø 1½"	Junta tórica de goma para conexiones de aluminio	1.34288001	1	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1535	\N	Peana para extintor de PQS de 9 lts. 	Peana para extintor de PQS de 9 lts. De Polipropileno de alta resistencia. (PLASTIC BOTTOM 9 lts).	1.35000002	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1536	\N	Abrazadera Colgante ϕ=2½"	Abrazadera Colgante C-75 ϕ=2½" Abrazadera Colgante, para sujeción de tubos contraincendios.\nAcabado Acero cincado plata.	1.35520005	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1537	\N	Tubería Flexible PVC 3/4" con Guía (Blanca)	Tubería Flexible PVC con Guía Interior, Diametro 3/4¨ Diámetro Int. 20 mm, Diámetro Ext. 25 mm (Color Blanco)	1.36399996	2	1	28043 EMPOTRAMIENTO ELECTRICO	22	PM ICTA16F	Tuberia corrugada flexible ICTA de GEWISS de 16 mm con guia de Acero DX16316  Blanca	0,17	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1538	\N	Tubería Flexible PVC 3/4" con Guía (Negra)	Tubería Flexible PVC con Guía Interior, Diametro 3/4¨ Diámetro Int. 20 mm, Diámetro Ext. 25 mm (Color Negro)	1.36399996	2	1	28043 EMPOTRAMIENTO ELECTRICO	22	PM ICTA16F	Tuberia corrugada flexible ICTA de GEWISS de 16 mm con guia de Acero DX15116 Negra	0,17	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1539	\N	Conector Macho KRALOY SCH40 PVC 3/4"	Conector Macho KRALOY Conduit SCH 40 PVC Diámetro 3/4¨ Diámetro Int. 18 mm para exteriores resistente al fuego y rayos solares.	1.37	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1540	\N	Monitor MON-22LCDW	Monitor Widescreen HD LED de 22 " Listado UL con Bocinas Integradas	1.42400002	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1541	\N	Cable Antiflama 4x18 AWG	Cable Antiflama Apantallado 4x18 AWG (1.00 mm2) con Cubierta PVC Rojo (Incendios SADI)	1.42999995	2	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1542	\N	Tubo sonda de PQS de 50 kgs	Tubo sonda para extintor de PQS de 50 kgs. (DEEP TUBE 50 KG).	1.45000005	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1543	\N	Buje 1" x ¾" (CAM x ESP)	Buje 1" x ¾" (CAM x ESP),estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	1.46300006	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1544	\N	Cable Corrientes 2x14 AWG	Cable Antiflama Apantallado 2x14 AWG (2.00 mm2) con Cubierta PVC Rojo (Incendios SADI)	1.47000003	2	1	19259-m38 Cables de Corrientes Débiles y Telefónicos	72	/8544.49.95	SUMCAB Sumsave AS + Data Segur Fire 2x2,5mm2	0,95	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1545	\N	Grapa Metalica Isofonica GMI  MG75 ϕ=2½"	Grapa Metalica Isofonica GMI  MG75 ϕ=2½" Grapas metálicas isofónicas. Multigrap. Para sujeción de tubos en batería de Cu. y de\nFe., con banda de caucho EPDM	1.47839999	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1546	\N	Juntas de goma  tóricas Ø 2"	Junta tórica de goma para conexiones de aluminio	1.50303996	1	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1547	\N	Abrazadera Colgante ϕ=3"	Abrazadera Colgante C-90 ϕ=3" Abrazadera Colgante, para sujeción de tubos contraincendios.\nAcabado Acero cincado plata.	1.55320001	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1548	\N	Accesorio para Tamper Switch Honeywell 28 2	Accesorio para Tamper Switch 955WH	1.56200004	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1549	\N	Regleta de Conexiones PWSC	Regleta de Conexiones para Empalmar el Cable Termosensible	1.57299995	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1550	\N	Soporte mural metalico para extintores de 3, 6 y 9 Kg de polvo.	Soporte mural metalico para extintores de 3, 6 y 9 Kg de polvo, acero galvanizado. (WALL BRACKET FOR PQS)	1.58000004	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1551	\N	Brochas 1"	Brochas 1"	1.59500003	1	6		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1552	\N	Tubería Flexible PVC 1" con Guía (Blanca)	Tubería Flexible PVC con Guía Interior, Diametro 1¨ Diámetro Int. 25 mm, Diámetro Ext. 32 mm (Color Blanco)	1.59500003	2	1	28043 EMPOTRAMIENTO ELECTRICO	21	PM ICTA16F	Tuberia corrugada flexible ICTA de GEWISS de 20 mm con guia de Acero DX16320 Blanca	0,21	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1553	\N	Tubería Flexible PVC 1" con Guía (Negra)	Tubería Flexible PVC con Guía Interior, Diametro 1¨ Diámetro Int. 25 mm, Diámetro Ext. 32 mm (Color Negro)	1.59500003	2	1	28043 EMPOTRAMIENTO ELECTRICO	21	PM ICTA16F	Tuberia corrugada flexible ICTA de GEWISS de 20 mm con guia de Acero DX15120 Negra	0,21	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1554	\N	Codo 45º 1" Soldado BM (CAMxCAM) 	Codo 45º 1" Soldado BM (CAMxCAM), estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	1.60599995	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1555	\N	Grapa tipo Fleje	Grapa tipo Fleje de Cobre para Sujeción de Cable 1/0 AWG (50 mm2) a Superficies de Concreto Verticales u Horizontales	1.61699998	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1556	\N	Clip metalico CC-2	Clip Metalico Alargado para Sujeción del Cable Termosensible	1.62800002	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1557	\N	Conjunto de Eje  para Válvula de 10 kg	Conjunto Eje Montado. Conjunto completo de cierre para válvula de CO2 10 kg. Fabricado en latón y plástico endurecido.	1.66999996	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1558	\N	Conjunto de Eje  para Válvula de 2-5 kg	Conjunto Eje Montado. Conjunto completo de cierre para válvulas de CO2 2 kg y 5kg. Fabricado en latón y plástico endurecido.	1.66999996	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1559	\N	Tapón SOC 1" Soldado BM CAM	Tapón SOC 1" Soldado BM CAM, estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	1.68299997	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1560	\N	Soporte abrazadera para PQS  3 Kg.	Soporte abrazadera para PQS  3Kg, material acero cincado, uso vehiculo. (BRACKET  3 KG).	1.72000003	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1561	\N	Unión Soldada  ¾" (CAM x CAM)	Unión Soldada  ¾" (CAM x CAM) estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	1.727	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1562	\N	Cable Corrientes 4x16 AWG	Cable Antiflama Apantallado 4x16 AWG (1.50 mm2) con Cubierta PVC Rojo (Incendios SADI)	1.77100003	2	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1563	\N	Codo 90º ¾" Soldado BM (CAMxCAM) 	Codo 90º ¾" Soldado BM (CAMxCAM), estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	1.79299998	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1564	\N	Juntas de goma  tóricas Ø 2½"	Junta tórica de goma para conexiones de aluminio	1.81104004	1	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1565	\N	Brochas 1½"	Brochas 1½"	1.81500006	1	6		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1566	\N	Conector Macho KRALOY SCH40 PVC 1"	Conector Macho KRALOY Conduit SCH 40 PVC Diámetro 1¨ Diámetro Int. 25 mm para exteriores resistente al fuego y rayos solares.	1.82000005	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1567	\N	Cable Eléctrico 8 AWG con cubierta de PVC (rollo de 50m)	Cable Monoconductor Calibre 8 AWG (10 mm2) con Cubierta PVC Verde-Amarillo	1.87	2	1	19830-m38 Cables Eléctricos	7	8544.30.00	Sumcab Sumflex H07V-K 450/750V 1x10mm2	0,648	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1568	\N	Unión Soldada  1"(CAM x CAM)	Unión Soldada  1"(CAM x CAM) estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	1.903	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1569	\N	Codo 30° KRALOY SCH40 PVC 1/2"	Codo 30° KRALOY Conduit SCH 40 PVC Diámetro 1/2¨ Diámetro Int. 12 mm  para exteriores resistente al fuego y rayos solares.	1.90999997	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1570	\N	Codo 90° KRALOY SCH40 PVC 1/2"	Codo 90° KRALOY Conduit SCH 40 PVC Diámetro 1/2¨ Diámetro Int. 12 mm  para exteriores resistente al fuego y rayos solares.	1.94000006	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1571	\N	Cable Corrientes Débiles Multivías6+2 Vías	Cable Multivias Apantallado 2x18 AWG + 6x22 AWG (0.75mm2x0.22mm2) (Alarma SACI)	1.97000003	2	1	19259-m38 Cables de Corrientes Débiles y Telefónicos	127	/8544.49.96	SUMCAB Sumsave Alarma 6x0,22mm2 + 2x0,75mm3	0,46	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1572	\N	Teflón	Cinta Teflón Ancho: 3/4" (20 mm), Largo: 20 m	1.98000002	1	6		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1573	\N	Unión KRALOY SCH40 PVC 3/4"	Unión KRALOY Conduit SCH 40 PVC Diámetro 3/4¨ Diámetro Int. 18 mm para exteriores resistente al fuego y rayos solares.	2	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1574	\N	Interruptor 1P, 16 A	Interruptor Modular Magneto-Térmico 1 Polo, Curva C, 16 A. 400V/10kA (Montaje en Perfil DIN)	2.01300001	1	1	21709-042 Paneles, Pizarras Electricas y sus Componentes	603	A9F79125	Acti 9 - Interruptor Automatico Modular iC60N - 1P - In=25A - Icn=6kA/400VCA (IEC 60898) - Curva C	2,86	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1575	\N	Interruptor 1P, 25 A	Interruptor Modular Magneto-Térmico 1 Polo, Curva C, 25 A. 400V/10kA (Montaje en Perfil DIN)	2.01300001	1	1	21709-042 Paneles, Pizarras Electricas y sus Componentes	5962	A9F77163	Interruptor automático modularActi9, iC60N disjoncteur 1P 63A curva C	5,27	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1576	\N	Patch Cord Cat. 6	Latiguillo de Red o Patch Cord Cat. 6. Longitud Variable (50cm,1m,2m,o 3m) (CCTV, SCA)	2.01300001	1	1	21709-042 Paneles, Pizarras Electricas y sus Componentes	29137	VDIP181646010	Latiguillo CAT6 RJ45 U/UTP 250MHz LSZH CORD 1M GREY	4,6	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1577	\N	Cable Corrientes 4x14 AWG	Cable Antiflama Apantallado 4x14 AWG (2.00 mm2) con Cubierta PVC Rojo (Incendios SADI)	2.02999997	2	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1578	\N	Manguera  Extintor de 6 kgs. 	Manguera con difusor de alta presion, para extintor de 6 kgs. (HOSE AND HORN 6 KG). Fabricada en: PVC, téxtil y polietileno de alta densidad. Difusor: plástico de alta calidad\n\nPrensado: alta presión y alineado con la manguera.\n\nIncluye: junta estanqueidad de alta resistencia para conexion con valvula	2.02999997	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1579	\N	Cable Corrientes Débiles Multivías 4+2 Vías	Cable Multivias Apantallado 2x18 AWG + 4x22 AWG (0.75mm2x0.22mm2) (Alarma SACI)	2.05699992	2	1	19259-m38 Cables de Corrientes Débiles y Telefónicos	128	/8544.49.95	SUMCAB Sumsave Alarma 4x0,22mm2 + 2x0,75mm2	0,4	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1580	\N	Grapa Metalica Isofonica GMI  MG90 ϕ=3"	Grapa Metalica Isofonica GMI  MG90 ϕ=3" Grapas metálicas isofónicas. Multigrap. Para sujeción de tubos en batería de Cu. y de\nFe., con banda de caucho EPDM	2.09439993	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1581	\N	Barrena para Metal 8 mm	Barrena para Metal, Diámetro  8 mm, Largo: 150 mm HSS	2.13000011	1	6		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1582	\N	Interruptor 1P, 63 A	Interruptor Modular Magneto-Térmico 1 Polo, Curva C, 63 A. 400V/10kA (Montaje en Perfil DIN)	2.13400006	1	1	21709-042 Paneles, Pizarras Electricas y sus Componentes	6649	A9N18360	Interruptor automático modular C120N 2P 63A C 10000A 415V 	46,17	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1583	\N	Baterías 1,5v AAA Litio	Baterías 1,5v AAA tipo FR03 Disulfuro de Hierro-Litio Larga Duración	2.1500001	1	6		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1584	\N	Codo 45° KRALOY SCH40 PVC 1/2"	Codo 45° KRALOY Conduit SCH 40 PVC Diámetro 1/2¨ Diámetro Int. 12 mm  para exteriores resistente al fuego y rayos solares.	2.1500001	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1585	\N	Manguera  Extintor de 9 kgs. 	Manguera con difusor de alta presion, para extintor de 9 kgs. (HOSE AND HORN 9 KG). Fabricada en: PVC, téxtil y polietileno de alta densidad.   Difusor: plástico dealta calidad\n\nPrensado: alta presión y alineado con la manguera.\n\nIncluye: junta estanqueidad de alta resistencia para conexion con valvula	2.1500001	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1586	\N	Canaleta 40x16,5 mm	Canaleta Color Blanco 40 x 16,5 mm 	2.17799997	2	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1587	\N	Tamper Switch Inalambrico Honeywell 5800RPS	Tamper Switch Trasmisor  Inalambrico compatible con receptores serie 5800	2.17799997	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1588	\N	Mordaza para varilla roscada M8 (C-Clamp)	Mordaza para varilla roscada M8 (C-Clamp). Mordaza para sujecion a vigas Modelo C  (Beam-Clamp Tipo C). Garra para vigas hecha de acero fundido; perno de acero endurecido, tuerca de acero zincado	2.21760011	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1589	\N	Buje 1¼" x ¾" (CAM x ESP)	Buje 1¼" x ¾" (CAM x ESP),estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	2.24399996	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1649	\N	Contacto Magnético Honeywell 7939BR	Contacto Magnético Carmelita para Montaje en Superficie Normalmente Cerrado (Puerta Cerrada)	4.26800013	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1590	\N	Buje 1¼" x 1" (CAM x ESP)	Buje 1¼" x 1" (CAM x ESP), estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	2.24399996	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1591	\N	Tabletas 	Tabletas para Soldadura Exotérmica 	2.24399996	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1592	\N	Codo 45º 1¼" Soldado BM (CAMxCAM) 	Codo 45º 1¼" Soldado BM (CAMxCAM), estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	2.27699995	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1593	\N	Mordaza para varilla roscada M10 (C-Clamp)	Mordaza para varilla roscada M10 (C-Clamp). Mordaza para sujecion a vigas Modelo C  (Beam-Clamp Tipo C). Garra para vigas hecha de acero fundido; perno de acero endurecido, tuerca de acero zincado	2.27920008	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1594	\N	Unión KRALOY SCH40 PVC 1"	Unión Hembra KRALOY Conduit SCH 40 PVC Diámetro 1¨ Diámetro Int. 25 mm para exteriores resistente al fuego y rayos solares.	2.27999997	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1595	\N	Manguera  Extintor de 9 lts. 	Manguera con difusor de alta presion, para extintores de 9 litros. (HOSE AND HORN 9 L). Fabricada en: PVC, téxtil y polietileno de alta densidad.   Difusor: plástico de alta calidad\n\nPrensado: alta presión y alineado con la manguera.\n\nIncluye: junta estanqueidad de alta resistencia para conexion con valvula	2.28999996	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1596	\N	Grapa Metalica Isofonica GMI  MG35 ϕ=1"	Grapa Metalica Isofonica GMI  MG35 ϕ=1" Grapas metálicas isofónicas. Multigrap. Para sujeción de tubos en batería de Cu. y de\nFe., con banda de caucho EPDM	2.31615996	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1597	\N	Grapa de Fijación de Cable a Metal	Grapa para Fijación de Cable 1/0 AWG (50 mm2) a Superficie Metálica 	2.3210001	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1598	\N	Baterías 1,5v AA Litio	Baterías 1,5v AA tipo FR6 Disulfuro de Hierro-Litio Larga Duración	2.3499999	1	6		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1599	\N	Codo 90º 1" Soldado BM (CAMxCAM) 	Codo 90º 1" Soldado BM (CAMxCAM), estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	2.38700008	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1600	\N	Tapa Protectora PS200	Tapa de protección frontal transparente para Pulsador Manual serie M	2.398	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1601	\N	Tapa Protectora PS200	Tapa de protección frontal transparente para Pulsador Manual serie M	2.398	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1602	\N	Varilla roscada  DIN 975  M-16  x 1000 ZN	Varilla roscada  DIN 975  M-16  x 1000 ZN Varilla roscada  DIN 975. Acero zincado plata	2.41472006	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1603	\N	Codo 45° KRALOY SCH41 PVC 3/4"	Codo 45° KRALOY Conduit SCH 40 PVC Diámetro 3/4¨ Diámetro Int. 18 mm para exteriores resistente al fuego y rayos solares.	2.42000008	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1604	\N	Barrena para Metal 10 mm	Barrena para Metal, Diámetro 10 mm, Largo: 180 mm HSS	2.42000008	1	6		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1605	\N	Codo 90° KRALOY SCH41 PVC 3/4"	Codo 90° KRALOY Conduit SCH 40 PVC Diámetro 3/4¨ Diámetro Int. 18 mm para exteriores resistente al fuego y rayos solares.	2.44000006	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1606	\N	Pasador  para Válvula de 10 kg	Juego de manetas para valvula de  CO2  2 - 5  kg	2.51999998	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1607	\N	Mordaza BC-2	Mordaza para Anclaje a Vigas del Cable Termosensible	2.58500004	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1608	\N	Adaptador Hembra 1" (CAM x ROS)	Adaptador Hembra 1" (CAM x ROS) estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	2.59599996	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1609	\N	Brochas 3"	Brochas 3"	2.59599996	1	6		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1610	\N	Grapa de Fijación de Cable a Concreto	Grapa para Fijación de Cable 1/0 AWG (50 mm2) a Superficie de Concreto	2.62899995	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1611	\N	Borna de Tierra	Borna de Tierra para Montaje en Perfil DIN. Ancho 35 mm. Color Verde/Amarillo. 	2.69499993	1	1	21709-042 Paneles, Pizarras Electricas y sus Componentes	24464	NSYR19DN	Rail/Perfil DIN - Montaje a 19" - Gama  de Aplicacion: Actassi 	11,66	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1612	\N	Cepillo de Alambre 	Cepillo de Alambre (Acero Inoxidable) con Mango de Madera. Largo: 290 mm, Ancho: 35 mm, 4 x 16 Hileras. Calibre del Alambre: 0,014". Largo del Alambre: 1"	2.70600009	1	6		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1613	\N	Grapa de Fijación de Cable y/o Pletina a Mástil	Grapa de Latón para Fijación, de Conductor de 1/0 AWG o Pletina de 20mm x 3mm, a Mástil de Diámetro: 1 1/2"	2.70600009	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1614	\N	Grapa Mecánica 	Grapa o Brida de Presión Mecánica con Tornillo Sinfin para Fijación del Bajante a la Torreta 	2.70600009	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1615	\N	Difusor para Extintor 2 Kg	Vaso difusor de alta resistencia 2 kg de CO2. Fabricado en polipropileno y latón. (HORN 2 KGS CO2)	2.72000003	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1616	\N	Codo 45º 1½" Soldado BM (CAMxCAM) 	Codo 45º 1½" Soldado BM (CAMxCAM), estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	2.72799993	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1617	\N	Baterías Recargables 1,2v AAA Litio	Baterías Recargable 1,2v AAA NiMH	2.73000002	1	6		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1618	\N	Abrazadera Colgante ϕ=6"	Abrazadera Colgante C-160 ϕ=6" Abrazadera Colgante, para sujeción de tubos contraincendios.\nAcabado Acero cincado plata.	2.79663992	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1619	\N	Baterías Recargables 1,2v AA Litio	Baterías Recargable 1,2v AA NiMH	2.80999994	1	6		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1620	\N	Buje 1½" x ¾" (CAM x ESP)	Buje 1½" x ¾" (CAM x ESP),estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	2.92600012	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1621	\N	Tensor de Ojo	Tensor Doble Ojo 3/8" para Cable de Acero 3/16" de Retenida de Vientos.	3.03600001	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1646	\N	Mordaza para varilla roscada M12 (Beam-Clamp)	Mordaza para varilla roscada M12 (Beam-Clamp). Mordaza para sujecion a vigas Modelo C  (Beam-Clamp Tipo C). Garra para vigas hecha de acero fundido; perno de acero endurecido, tuerca de acero zincado	4.06559992	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1647	\N	Regleta de Conexión	Regletas o Clemas de Conexión de 10 mm para Cables de Calibre 10 AWG. 	4.11399984	1	1	21709-042 Paneles, Pizarras Electricas y sus Componentes	37697	Leg-34276	Bolsa de 10 udes de Regleta NYLBLOC 12 polos 6mm2 blanca	6,83	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1763	\N	Soporte SB-I/O	Caja Plástica de Montaje para Pulsador NBG-12L (Interior)	9.85599995	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1622	\N	Tubería de CPVC  ¾" 	Tubería de CPVC  ¾" , Las tuberías de CPVC BlazeMaster®,  para los sistemas de rociadores contra incendio, están hechas de policloruro de vinilo post-clorinado (CPVC),  aprobadas para el uso en todas las aplicaciones de riesgo tipo bajo (según NFPA 101). Estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3, (20, 25, 32,  40,  50, 65,  80 mm) con  espesor  de  pared RD-13.5. Los tubos  son  comercializados  en  longitudes  de 15  pies o  4.57 mts.. La tubería de CPVC. BlazeMaster ® esta aprobada para el uso en todas las aplicaciones de bajo riessgo tipo NFPA 13 en Edificios públicos. 	3.09319997	2	17		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1623	\N	Indicador de presion para extintores de 1 y 3 Kg 	Indicador de presion de m3 mm para extintores de 1 y 3 Kg de polvo,de laton cromado. (PRESSURE GAUGE).            Dimensión: Ø m3 mm.\nVálido para: extintores de 1 kg y 3 kg de polvo\nMaterial: latón cromado de alta calidad\nEscala: 0-31 bar\nIncluye: filtro\nTemperatura de trabajo: -30°C a +60°C	3.18000007	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1624	\N	Indicador de presion  para extintores de 6, 9 y 25 Kg	Indicador de presion de 27 mm para extintores de 6, 9 y 25 Kg de polvo, de laton cromado. (PRESSURE GAUGE).    Dimensión: Ø 27 mm.\nVálido para: extintores de 6 kg, 9 kg y 25 kg de polvo\nMaterial: latón cromado de alta calidad                                                                                                                                                                                                                                                                                         Escala: 0-31 bar\nIncluye: filtro\nTemperatura de trabajo: -30°C a +60°C	3.18000007	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1625	\N	Cable Eléctrico 6 AWG con cubierta de PVC (rollo de 25 o 50m)	Cable Monoconductor Calibre 6 AWG (16 mm2) con Cubierta PVC Verde-Amarillo	3.19000006	2	1	19830-m38 Cables Eléctricos	8	8544.30.00	Sumcab Sumflex H07V-K 450/750V 1x16mm2	1,005	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1626	\N	Codo 45° KRALOY SCH42 PVC 1"	Cod 45° KRALOY Conduit SCH 40 PVC Diámetro 1¨ Diámetro Int. 25 mm para exteriores resistente al fuego y rayos solares.	3.19000006	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1627	\N	Soporte para PQS  6 Kg	Soporte para PQS  6Kg, material acero cincado, uso vehiculo. (BRACKET  6 KG).	3.21000004	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1628	\N	Brochas 4"	Brochas 4"	3.21199989	1	6		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1629	\N	Mordaza para varilla roscada M16 (Beam-Clamp)	Mordaza para varilla roscada M16 (Beam-Clamp). Mordaza para sujecion a vigas Modelo C  (Beam-Clamp Tipo C). Garra para vigas hecha de acero fundido; perno de acero endurecido, tuerca de acero zincado	3.36335993	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1630	\N	Baterías 9v 	Baterías 9v Tipo PP3	3.36599994	1	6		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1631	\N	Codo 30° KRALOY SCH41 PVC 3/4"	Codo 30° KRALOY Conduit SCH 40 PVC Diámetro 3/4¨ Diámetro Int. 18 mm para exteriores resistente al fuego y rayos solares.	3.46000004	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1632	\N	Unión Soldada  1¼" (CAM x CAM)	Unión Soldada  1¼" (CAM x CAM) estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	3.46499991	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1633	\N	Abrazadera isofónica  ϕ=6"	Abrazadera isofónica RI-160 (M8+M10) ϕ=6"	3.47424006	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1634	\N	Tubería Rígida Metalica EMT 1/2"	Tubería Rígida Metalica EMT 1/2" Diámetro 1/2¨ Diámetro Int. 12 mm  para exteriores de Acero Electrogalvanizado o Galvanizado en Caliente	3.5	2	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1635	\N	Manguera de Goma y Lona diámetro 1 ¾ " (45 mm), c/racor Barcelona (tramos de 20 m).	Manguera de caucho y lona Tipo Plana:                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     Formada por dos capas, una capa interior fabricada en caucho sintético especialmente formulado y una capa exterior tejida circularmente, compuesta por hilos de poliéster. Requerimientos a cumplimentar: ligereza, flexibilidad, fácil de usar y enrollar, buena resistencia a la presión y un buen aislante térmico . Color blanco, extremos con racores tipo Barcelona. 	3.57279992	2	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1636	\N	Tee ¾" (CAMxCAMxCAM) 	Tee ¾" (CAMxCAMxCAM), estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	3.59699988	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1637	\N	Caja PS031W 	Caja de montaje superficie para Pulsador Manual serie M	3.64100003	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1638	\N	Caja PS031W 	Caja de montaje superficie para pulsadores serie M	3.64100003	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1639	\N	Codo 45º 2" Soldado BM (CAMxCAM) 	Codo 45º 2" Soldado BM (CAMxCAM), estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	3.64100003	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1640	\N	Batería CR2025	Batería de Dióxido de Manganeso-Litio 3v Tipo Botón Largo 20 mm Ancho 2,5 mm	3.69000006	1	10		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1641	\N	Tapón  SOC 3" Soldado BM CAM	Tapón  SOC 3" Soldado BM CAM,estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	3.8499999	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1642	\N	Registro Eléctrico de PVC 180 x 140 x 86 mm perforada con 10 conos 	Caja de Registro Rectangular PVC con Tapa 180 x 140 x 86 mm Perforada 10 orificios con Boquillas de goma IP 55, IK 07. (Interior)	3.91599989	1	1	28043 EMPOTRAMIENTO ELECTRICO	30	Geros 17054	Caja de Adosar IP-55 tipo Plexo de 100x100x50	1,07	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1643	\N	Cable Eléctrico Royal Cord de 3 vías 	Cable Multivías (Royal Cord) 3 conductores (12 AWG) (4 mm2)	3.94899988	2	1	19830-m38 Cables Eléctricos	58	8544.30.00	Sumcab Sumflex S RV-K 0,6/1kv 3G4mm2 FB-BH No propagador del incendio / Bajo en halogenos	1,026	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1644	\N	Batería CR2032	Batería de Dióxido de Manganeso-Litio 3v Tipo Botón Largo 20 mm Ancho 3,2 mm	3.99000001	1	10		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1645	\N	Buje 1½" x 1" (CAM x ESP)	Buje 1½" x 1" (CAM x ESP), estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	4.05900002	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1648	\N	Contacto Magnético Honeywell 7939WH	Contacto Magnético Blanco para Montaje en Superficie Normalmente Cerrado (Puerta Cerrada)	4.26800013	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1650	\N	Tee  Red 1" x 1" x ¾" (CAMxCAMxCAM) 	Tee  Red 1" x 1" x ¾" (CAMxCAMxCAM), estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	4.35599995	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1651	\N	Unión Soldada  1½" (CAM x CAM)	Unión Soldada  1½" (CAM x CAM) estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	4.41099977	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1652	\N	Cable Corrientes Débiles Multivías 10+2 Vías	Cable Multivias Apantallado 2x18 AWG + 10x22 AWG (0.75mm2x0.22mm2) (Alarma SACI)	4.44399977	2	1	19259-m38 Cables de Corrientes Débiles y Telefónicos	13	/8544.49.95	SUMCAB Sumsave Alarma 10x0,22mm2 + 2x0,75mm2	0,85	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1653	\N	Cristal para Gabinetes de 620 x 515 x 3 mm de espesor.	Cristal o vidrio templado de seguridad de 3 mm de espesor, para Gabinetes portamanguera	4.45983982	1	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1654	\N	Válvula de PQS de 1 kgs y 3 kgs.	Válvula de latón, acero y caucho para extintor de PQS de 1 kgs y 3 kgs, rosca M30, con difusor, junta hytrel, pasador y precinto. (VALVE 1-3 KG).  Cuerpo: latón de alta calidad. Manetasuperior: pintura 100% poliéster y terminación metalizada.\nManeta inferior: pintura 100% poliéster. Pasador: acero INOX, con sujección a la válvula mediante conjunto pasador.\nMuelle: acero INOX.	4.53999996	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1655	\N	Codo 45º 2½" Soldado BM (CAMxCAM) 	Codo 45º 2½" Soldado BM (CAMxCAM), estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	4.54300022	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1656	\N	Manguera de Goma y Lona diámetro 2 " (52 mm), c/racor Barcelona (tramos de 20 m).	Manguera de caucho y lona Tipo Plana:                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     Formada por dos capas, una capa interior fabricada en caucho sintético especialmente formulado y una capa exterior tejida circularmente, compuesta por hilos de poliéster. Requerimientos a cumplimentar: ligereza, flexibilidad, fácil de usar y enrollar, buena resistencia a la presión y un buen aislante térmico . Color blanco, extremos con racores tipo Barcelona. 	4.54608011	2	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1657	\N	Anticorrosivo 	Pintura Anticorrosivo 	4.61999989	3	6		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1658	\N	Batería CR1m3A	Batería Litio CR1m3A 3v Cilindrica Largo 34.5 Ancho mm 17 mm	4.69999981	1	10		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1659	\N	Manómetro para Válvula de BIE 0-16 kg/cm2.	Manómetro para Válvula de BIE 0-16 kg/cm2 Estándar de cuerpo de latón con rosca 1/4" macho, para válvula de BIE 45 mm o 25mm, de 0-16 kg/cm2, con esfera redonda de lectura. Cuerpo de esfera de plástico de alta resistencia. Incluye cuadradillo en el cuerpo del manómetro para su ajuste con llave	4.73487997	1	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1660	\N	Cable Eléctrico 4 AWG con cubierta de PVC (rollo de 25 o 50m)	Cable Monoconductor Calibre 4 AWG (25 mm2) con Cubierta PVC Verde-Amarillo	4.73000002	2	1	19830-m38 Cables Eléctricos	9	8544.30.00	Sumcab Sumflex H07V-K 450/750V 1x25mm2	1,634	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1661	\N	Accesorio F210	Accesorio Embellecedor para Base B210LP	4.75199986	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1662	\N	Espuma AFFF 6%.	Agente epumogeno AFFF 6 % CLASE B BOLDFOAM B6 (para fuegos de clase B (hidrocarburos)	4.76000023	3	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1663	\N	Codo 90° KRALOY SCH42 PVC 1"	Cod 90° KRALOY Conduit SCH 40 PVC Diámetro 1¨ Diámetro Int. 25 mm para exteriores resistente al fuego y rayos solares.	4.78000021	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1664	\N	Disco de Corte de Metal	Disco de Corte de Metal, 300 x 2,5 x 25,4 mm	4.80700016	1	6		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1665	\N	Tee 1" (CAMxCAMxCAM) 	Tee 1" (CAMxCAMxCAM), estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	4.80700016	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1666	\N	Grapa Metalica Isofonica GMI  MG42 ϕ=1¼"	Grapa Metalica Isofonica GMI  MG42 ϕ=1¼" Grapas metálicas isofónicas. Multigrap. Para sujeción de tubos en batería de Cu. y de\nFe., con banda de caucho EPDM	4.8540802	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1667	\N	Buje 2" x  1½" (CAM x ESP)	Buje 2" x  1½" (CAM x ESP),estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80) 	4.89499998	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1668	\N	Esmalte Blanco	Esmalte Blanco	4.96099997	3	6		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1669	\N	Esmalte Rojo	Esmalte Rojo	4.96099997	3	6		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1670	\N	Tubería de CPVC 1" 	Tubería de CPVC 1"  , Las tuberías de CPVC BlazeMaster®  de Durman y Spears,  para los sistemas de rociadores contra incendio, están hechas de policloruro de vinilo post-clorinado (CPVC)  están completamente aprobadas para el uso en todas las aplicaciones de riesgo tipo bajo (según NFPA 101). Estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3, (20, 25, 32,  40,  50, 65,  80 mm) con  espesor  de  pared RD-13.5. Los tubos  son  comercializados  en  longitudes  de 15  pies o  4.57 mts.. La tubería de CPVC. BlazeMaster ® esta aprobada para el uso en todas las aplicaciones de bajo riessgo tipo NFPA 13 en Edificios públicos. 	4.9649601	2	17		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1671	\N	Caja de Montaje SMB500-WH Nuevo	Caja de Montaje en superficie para Módulos ISO, FCM, FRM, FMM, FZM	4.9829998	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1672	\N	Codo 90º 1¼" Soldado BM (CAMxCAM) 	Codo 90º 1¼" Soldado BM (CAMxCAM), estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	4.9829998	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1673	\N	Batería de Litio 3v CR2	Batería de Litio CR2 3v  Cilindrica Largo 27 mm Ancho 15,6 mm	4.98999977	1	10		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1674	\N	Tee  Red 1½" x 1½" x 1¼" (CAMxCAMxCAM)	Tee  Red 1½" x 1½" x 1¼" (CAMxCAMxCAM), estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	4.99399996	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1904	\N	Chasis CHS-2D	Chasis para Montaje de Anunciador NCA-2 en ABS-2D	26.1800003	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1675	\N	Tubería Rígida Metalica EMT 3/4" 	Tubería Rígida Metalica EMT 3/4" Diámetro 3/4¨ Diámetro Int. 18 mm para exteriores de Acero Electrogalvanizado o Galvanizado en Caliente	5	2	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1676	\N	Riel DIN	Riel DIN Tipo U, Perforado, Espesor de chapa 1mm. Ancho 35mm. Profundidad 7,5mm	5.01599979	1	1	21709-042 Paneles, Pizarras Electricas y sus Componentes	6021	A9F79116	Acti 9 - Interruptor Automatico Modular iC60N - 1P - In=16A - Icn=6kA/400VCA (IEC 60898) - Curva C	2,86	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1677	\N	Válvula de PQS de 6 kgs, 9 kgs y 25 kgs.	Válvula de latón, acero y caucho para extintor de PQS de 6 kgs, 9 kgs y 25 kgs, rosca M30, con junta hytrel, pasador y precinto .(VALVE 6-9-25 KG) Cuerpo: latón de alta calidad. Maneta superior: pintura 100% poliéster y terminación metalizada. Maneta inferior: pintura 100% poliéster.Pasador: acero INOX, con sujección a la válvula mediante conjunto pasador. Muelle: acero INOX.	5.01999998	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1678	\N	Cable de Cobre Desnudo 1/0 AWG (rollo de 25 o 50m)	Cable de Cobre Desnudo Trenzado Calibre: 1/0 AWG (50 mm2)	5.10400009	2	1	19830-m38 Cables Eléctricos	151	8544.30.01	Sumcab Cable desnudo Cu 1x50mm2	2,8	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1679	\N	Cilindro Ext. PQS 1 KG	Cilindro Ext. PQS 1 KG (PQS  1 Kg conteiner)\nCaracterísticas Técnicas:\nAltura: (355 – 375) mm; Diámetro: 80 mm; Espesor nominal de pared: 1,2 mm; Espesor mínimo de pared: 1,20 mm; Volumen: (1,25 – 1,35) litros; Peso: (1,10 – 1,38) Kg. \nMateriales:\nBotella de acero soldado: Fabricada en chapa de acero laminada en frio, de bajo contenido de carbono para embutición profunda; Conexion roscada para valvula fabricada con barra de acero M 30.     \nAcabado:                                                                                                                                                                                                   Pintura al horno 100 % poliéster, RAL 3000, espesor de la capa de pintura que garantice como mínimo 480 horas de la prueba de nieblas salinas sin que aparezca síntomas de corrosión exterior.	5.13999987	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1680	\N	Barrena de Tungsteno 5	Barrena de Tungsteno 5 mm x 85 mm 	5.14799976	1	6		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1681	\N	Barrena de Tungsteno 6	Barrena de Tungsteno 6 mm	5.14799976	1	6		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1682	\N	Soporte SBBSPWL Nuevo	Caja de Montaje para Altavoz de Evacuación	5.17000008	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1683	\N	Registro Eléctrico de PVC 105 x 105 x 55 mm perforada con 7 conos 	Caja de Registro Cuadrada PVC con Tapa 105 x 105 x 55 mm Perforada 7 orificios con Boquillas de goma IP 55, IK 07. (Interior)	5.19199991	1	1	21709-042 Paneles, Pizarras Electricas y sus Componentes	9564	ENN46925	100 Bridas-Cintura de 368x7,6mm incoloras	31,62	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1684	\N	Cable de Cobre Desnudo 1/0AWG	Cable de Cobre Trenzado Desnudo Calibre: 1/0 AWG (50 mm2)	5.24700022	2	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1685	\N	Tubería Rígida KRALOY SCH40 PVC 1/2" 	Tubería Rígida KRALOY Conduit SCH 40 PVC Diámetro 1/2¨ Diámetro Int. 12 mm  para exteriores resistente al fuego y rayos solares.	5.36000013	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1686	\N	Barrena de Tungsteno 8	Barrena de Tungsteno  8 mm x 150 mm	5.42999983	1	6		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1687	\N	Codo 45º 3" Soldado BM (CAMxCAM) 	Codo 45º 3" Soldado BM (CAMxCAM), estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	5.45599985	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1688	\N	Grapa de Fijación de Pletina a Concreto	Grapa  para Fijación de Pletina 20 mm x 3 mm a Superficie de Concreto	5.46700001	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1689	\N	Grapa de Fijación de Pletina a Metal	Grapa  para Fijación de Pletina 20 mm x 3 mm a Superficie de Metálica	5.46700001	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1690	\N	Codo 30° KRALOY SCH42 PVC 1"	Codo 30° KRALOY Conduit SCH 40 PVC Diámetro 1¨ Diámetro Int. 25 mm para exteriores resistente al fuego y rayos solares.	5.6500001	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1691	\N	Buje 2" x ¾" (CAM x ESP)	Buje 2" x ¾" (CAM x ESP), estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	5.67600012	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1692	\N	Unión Soldada  2" (CAM x CAM)	Unión Soldada  2" (CAM x CAM) estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	5.85200024	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1693	\N	Tee  Red 1½" x 1½" x1" (CAMxCAMxCAM)	Tee  Red 1½" x 1½" x1" (CAMxCAMxCAM), estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	5.91800022	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1694	\N	Registro Eléctrico de PVC 220 x 170 x 86 mm perforada con 14 conos 	Caja de Registro Rectangular PVC con Tapa 220 x 170 x 86 mm Perforada 14 orificios con Boquillas de goma IP 55, IK 07. (Interior)	5.94000006	1	1	28043 EMPOTRAMIENTO ELECTRICO	31	Geros 17064	Caja estanca de adosar IP-55 de 240X190X90 410C7 PM	4,85	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1695	\N	Tramo de Cable PFL	Tramo de Cable Flexible para Instalación de Resistencia de Fin de Línea RFL	6.00600004	2	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1696	\N	Tubo de Comprobación DST1	Tubo de aspiración para conductos de hasta 30cm de ancho.	6.18200016	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1697	\N	Tubo de Comprobación DST1	Tubo de aspiración para conductos de hasta 30cm de ancho.	6.18200016	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1698	\N	Barrena de Tungsteno 12	Barrena de Tungsteno  12 mm x 400 mm	6.26999998	1	6		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1699	\N	Base de Montaje DSC DMW	Accesorio de Montaje en Pared para Sensores de Movimiento	6.28100014	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1700	\N	Cable Eléctrico Royal Cord de 5 vías	Cable Multivías (Royal Cord) 5 conductores (12 AWG) (4 mm2)	6.38000011	2	1	19830-m38 Cables Eléctricos	100	8544.30.00	Sumcab Sumflex S RV-K 0,6/1kv 5G4mm2 FB-BH No propagador del incendio / Bajo en halogenos	1,677	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1701	\N	Base BRR	Base interior para sirena de color rojo con entradas para tubos	6.48999977	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1702	\N	Tee  Red 2" x 2" x 1" (CAMxCAMxCAM)	Tee  Red 2" x 2" x 1" (CAMxCAMxCAM), estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	6.48999977	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1703	\N	Grapa para Guardera 	Grapa para Fijación  a Pared de la Guardera de Protección	6.76499987	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2693	test	Producto común	producto común	1.07000005	3	10	\N	\N	\N	\N	\N	2020-07-07 23:47:28	2020-07-07 23:47:28	t	\N
1704	\N	Codo 90º 1½" Soldado BM (CAMxCAM) 	Codo 90º 1½" Soldado BM (CAMxCAM), estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	7.00699997	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1705	\N	Base de Montaje Honeywell SMB10T	Base Universal de Montaje en Pared con Tamper para Sensores de Movimiento (Paquete 5u)	7.3920002	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1706	\N	Cable Eléctrico 2 AWG con cubierta de PVC (rollo de 25 o 50m)	Cable Monoconductor Calibre 2 AWG (35 mm2) con Cubierta PVC Verde-Amarillo	7.3920002	2	1	19830-m38 Cables Eléctricos	10	8544.30.00	Sumcab Sumflex H07V-K 450/750V 1x35mm2	2,266	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1707	\N	Barrena de Tungsteno 10	Barrena de Tungsteno  10 mm x 400 mm	7.42500019	1	6		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1708	\N	Válvula de PQS de 50 kgs.	Válvula de latón, acero y caucho para extintor de PQS de 50 kgs, rosca M30, con junta hytrel, pasador y precinto. Cuerpo: latón de alta calidad. Maneta superior: pintura 100% poliéster y terminación metalizada. Maneta inferior: pintura 100% poliéster. Pasador: acero INOX, con sujección a la válvula mediante conjunto pasador. Muelle: acero INOX.	7.48000002	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1709	\N	Conector Bimetálico Tipo Perro	Conector Bimetálico Tipo Perro KSU 25 para unión de Cable (Acero) de Retenida y Bajante (Cobre)	7.55700016	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1710	\N	Tee  1¼" (CAMxCAMxCAM) 	Tee  1¼" (CAMxCAMxCAM), estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	7.59000015	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1711	\N	Unión Soldada  2½" (CAM x CAM)	Unión Soldada  2½" (CAM x CAM) estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	7.61199999	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1712	\N	Tubería de CPVC 1¼" \n	Tubería de CPVC 1¼"  , Las tuberías de CPVC BlazeMaster®  de Durman y Spears,  para los sistemas de rociadores contra incendio, están hechas de policloruro de vinilo post-clorinado (CPVC)  están completamente aprobadas para el uso en todas las aplicaciones de riesgo tipo bajo (según NFPA 101). Estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3, (20, 25, 32,  40,  50, 65,  80 mm) con  espesor  de  pared RD-13.5. Los tubos  son  comercializados  en  longitudes  de 15  pies o  4.57 mts.. La tubería de CPVC. BlazeMaster ® esta aprobada para el uso en todas las aplicaciones de bajo riessgo tipo NFPA 13 en Edificios públicos. \n	7.71320009	2	17		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1713	\N	Conexión Rosca Fija Interior de aluminio tipo GOST  2½" (70 mm)	Conexión rosca fija interior de aluminio tipo GOST . Rosca GAS- BSP	7.90944004	1	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1714	\N	Buje 2" x 1" (CAM x ESP)	Buje 2" x 1" (CAM x ESP),estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	7.95300007	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1715	\N	Spray de Humo	Spray de Humo	7.95300007	1	6		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1716	\N	Tubería Rígida KRALOY SCH40 PVC 3/4" 	Tubería Rígida KRALOY Conduit SCH 40 PVC Diámetro 3/4¨ Diámetro Int. 18 mm para exteriores resistente al fuego y rayos solares.	7.98000002	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1717	\N	Tubería Rígida Metalica EMT 1" 	Tubería Rígida Metalica EMT 1" Diámetro 1¨ Diámetro Int. 25 mm para exteriores de Acero Electrogalvanizado o Galvanizado en Caliente	8	2	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1718	\N	Caja de Montaje SMB-600	Caja de Montaje en superficie para Detectores	8.07400036	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1719	\N	Adaptador Hembra 1¼" (CAM x ROS) 	Adaptador Hembra 1¼" (CAM x ROS)  estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	8.09599972	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1720	\N	Tapa Ciega de aluminio tipo GOST  2" (50mm)	Tapa Ciega de aluminio tipo GOST con cadena.  	8.15583992	1	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1721	\N	Manguera de caucho y poliamida Tipo C diámetro 2" (52 mm), rollo  de 60 m.	Manguera de caucho y poliamida Tipo 3:                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      Manguera para uso contra incendios de caucho y poliamida. Resistente a la abrasión, al calor, al agua de mar y a las inclemencias del tiempo, otros requerimientos a cumplimentar:  resistente a agentes químicos y aceites, ozono y rayos UV . Color Rojo, extremos sin racores, longitud del rollo 60 m.	8.16816044	2	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1722	\N	Base CSR	Base interior para sirena de color rojo paquete de 5 pz	8.39000034	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1723	\N	Contacto Magnétco Honeywell 7940WH	Contacto Magnético Blanco Montaje en Superficie Normalmente Cerrado (Puerta Cerrada con Pegatina)	8.35999966	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1724	\N	Contacto Magnétco Honeywell 7940BR	Contacto Magnético Carmelita Montaje en Superficie Normalmente Cerrado (Puerta Cerrada con Pegatina)	8.35999966	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1725	\N	Panel Eléctrico 12P IP65	Panel Eléctrico PVC para Adosar a Pared de 12 Posiciones,  IP-65, IK-10	8.43700027	1	1	21709-042 Paneles, Pizarras Electricas y sus Componentes	1363	13978	Panel modular de adosar IP65 / MINI KAEDRA / 1 FILA 8 Módulos 	20,58	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1726	\N	Cilindro Ext. PQS 3 KG	Cilindro Ext. PQS 3 KG (PQS  3 Kg conteiner)\n Características Técnicas:\nAltura: Altura 4981mm;Diametro 110mm; Espesor Nominal de la pared 1,2 mm; Espesor mínimo de pared 1,20 mm; Volumen:3,30l; Peso: 2,25 kg\nMateriales:\nBotella de acero soldado: Fabricada en chapa de acero laminada en frio, de bajo contenido de carbono para embutición profunda; Conexion roscada para valvula fabricada con barra de acero M 30.     \nAcabado:                                                                                                                                                                                        Pintura al horno 100 % poliéster, RAL 3000, espesor de la capa de pintura que garantice como mínimo 480 horas de la prueba de nieblas salinas sin que aparezca síntomas de corrosión exterior.	8.43999958	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1727	\N	Tamper Switch Honeywell 955WH	Tamper Switch para Montaje en Gabienetes de Paneles de Alarmas y/o Fuentes Auxiliares 	8.44799995	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1728	\N	Tee  Red 2" x 2" x 1½" (CAMxCAMxCAM)	Tee  Red 2" x 2" x 1½" (CAMxCAMxCAM), estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	8.44799995	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1729	\N	Baterías AAA de Litio 1.5v	Baterías 1,5v AAA tipo FR03 Disulfuro de Hierro-Litio Larga Duración (Estuche de 4 Unidades)	8.57999992	1	10		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1730	\N	Bocina para Extintor de 10 kg	Bocina con manguera de alta presión,  10 kg de CO2. Fabricada en PVC, textil y PEAD  con hilo de cobre interior (HOSE AND HORN 10 KG CO2)	8.71000004	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1731	\N	Accesorio AP-P	Accesorio Embellecedor para Detectores Serie 302	8.80000019	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1732	\N	Bocina para Extintor de 5 kg	Bocina con manguera de alta presión,  5 kg de CO2. Fabricada en PVC, textil y PEAD  con hilo de cobre interior (HOSE AND HORN 5 KG CO2)	8.92000008	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1733	\N	Pulsador M1A-R470SF-K013-01	Pulsador Manual Convencional rearmable con contacto NA y resistencia de 470 ohmios	8.92099953	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1734	\N	Tubo de Muestreo DST1(A)	Tubo Metálico de Muestreo para Ducto de Ancho hasta 30 cm. 	8.92099953	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1735	\N	CA-1W	Accesorio de Montaje de multiple angulo montaje en pared para sensores LX	8.96000004	1	10		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1736	\N	CA-2C	Accesorio de Montaje en techo para sensores LX	8.96000004	1	10		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1737	\N	Caja SBBWL Nuevo	Caja de Montaje de PVC para Sirena o Estrobo Serie L Montaje en Pared (Blanco) para interiores	8.98700047	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1738	\N	Caja SBBRL Nuevo	Caja de Montaje de PVC para Sirena o Estrobo Serie L Montaje en Pared (Rojo) para interiores	8.98700047	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1739	\N	Tee 1½" (CAMxCAMxCAM) 	Tee 1½" (CAMxCAMxCAM), estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	9.02000046	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1740	\N	Manguera  Extintor de 25 kgs. 	Manguera con difusor de alta presion, para extintor movil de 25 Kg. (HOSE AND HORN 25 KG).	9.06999969	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1741	\N	Spray Limpiador de Superficies Plásticas 	Spray Limpiador de Superficies Plásticas 	9.08600044	1	6		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1742	\N	Caja SBBGWL Nuevo	Caja de Montaje de PVC para Sirena o Estrobo Compacta Serie L Montaje en Pared (Blanco) para interiores	9.10000038	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1743	\N	Caja SBBGRL Nuevo	Caja de Montaje de PVC para Sirena o Estrobo Compacta Serie L Montaje en Pared (Rojo) para interiores	9.10000038	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1744	\N	Base B210LP(A)	Bases para Detectores Direccionables de la serie 851	9.29500008	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1745	\N	Cable Termosensible PHSC-220-EPC	Cable Termosensible Multipropósito (Temperatura de Alarma 105˚C)	9.37199974	2	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1746	\N	Cable Termosensible PHSC-280-EPC	Cable Termosensible Multipropósito (Temperatura de Alarma 138˚C)	9.37199974	2	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1747	\N	Cable Termosensible PHSC-356-EPC	Cable Termosensible Multipropósito (Temperatura de Alarma 180˚C)	9.37199974	2	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1748	\N	Cable Termosensible PHSC-155-EPC	Cable Termosensible Multipropósito (Temperatura de Alarma 68˚C)	9.37199974	2	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1749	\N	Cable Termosensible PHSC-190-EPC	Cable Termosensible Multipropósito (Temperatura de Alarma 88˚C)	9.37199974	2	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1750	\N	Cable Termosensible PHSC-155-EPR	Cable Termosensible para Exteriores (Temperatura de Alarma 68˚C)	9.37199974	2	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1751	\N	Cable Termosensible PHSC-190-EPR	Cable Termosensible para Exteriores (Temperatura de Alarma 88˚C)	9.37199974	2	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1752	\N	Bateria AA de Litio 1.5v	Baterías 1,5v AA tipo FR6 Disulfuro de Hierro-Litio Larga Duración (Estuche de 4 Unidades)	9.39000034	1	10		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1753	\N	Acetileno Industrial 	Acetileno Industrial 	9.46000004	6	6		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1754	\N	Detector 5603	Detector Temperatura Fija Convencional con Base a 2 Hilos (57 grados)	9.58100033	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1755	\N	Manguera de caucho y poliamida Tipo C diámetro 2½" (66 mm), rollo  de 60 m.	Manguera de caucho y poliamida Tipo 3:                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      Manguera para uso contra incendios de caucho y poliamida. Resistente a la abrasión, al calor, al agua de mar y a las inclemencias del tiempo, otros requerimientos a cumplimentar:  resistente a agentes químicos y aceites, ozono y rayos UV . Color Rojo, extremos sin racores, longitud del rollo 60 m.	9.58495998	2	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1756	\N	Cilindro  Ext. PQS 6 KG	Cilindro Ext. PQS 6 KG (PQS 6 Kg conteiner).                                                                                                                Características Técnicas:\nAltura: (515-528) mm; Diametro 150 mm; Espesor Nominal de la pared 1,5 mm; Espesor mínimo de pared 1,50 mm; Volumen:(7,70-6,72) l; Peso:(3,20-3,30) kg\nMateriales:\nBotella de acero soldado: Fabricada en chapa de acero laminada en frio, de bajo contenido de carbono para embutición profunda; Conexion para valvula M 30 .     \nAcabado:                                                                                                                                                                                       Pintura al horno 100 % poliéster, RAL 3000, espesor de la capa de pintura que garantice como mínimo 480 horas de la prueba de nieblas salinas sin que aparezca síntomas de corrosión exterior.                                                                                                 	9.67000008	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1757	\N	Adaptador Hembra 1½" (CAM x ROS)	Adaptador Hembra 1½" (CAM x ROS) estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	9.7130003	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1758	\N	Cable Termosensible PHSC-135-XLT	Cable Termosensible Multipropósito de Baja Temperatura (57˚C)	9.73499966	2	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1759	\N	Contacto Magnético Honeywell 7939-2WH	Contacto Magnético Blanco para Montaje en Superficie Relé Forma C (Contacto abierto y cerrado)	9.77900028	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1760	\N	Contacto Magnético Honeywell 7939-2BR	Contacto Magnético Carmelita para Montaje en Superficie Relé Forma C (Contacto abierto y cerrado)	9.77900028	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1761	\N	Cable de Cobre Cubierto en PVC Verde/Amarillo 1/0AWG	Cable de Cobre Trenzado con Cubierta de PVC, Color: Verde/Amarillo, Calibre: 1/0 AWG (50 mm2)	9.80099964	2	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1762	\N	Soporte SB-I/O	Caja Plástica de Montaje para Pulsador NBG-12L (Interior)	9.85599995	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1764	\N	Tee  Red 1¼" x 1¼" x1" (CAMxCAMxCAM) 	Tee  Red 1¼" x 1¼" x1" (CAMxCAMxCAM), estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	9.86699963	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1765	\N	Unión Soldada  3" (CAM x CAM)	Unión Soldada  3" (CAM x CAM) estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	9.88899994	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1766	\N	Conexión rosca fija exterior de latón Tipo STORZ para manguera diámetro 2" (DN50)	Conexión rosca fija exterior Tipo STORZ: Material: Latón, Presión del trabajo: 10bar; 13bar, Presión de Brust: 30bar; 39bar	10.0038404	1	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1767	\N	Sirena Honeywell WAVE2	Sirena para Interiores con Tamper, Salida de 2 tonos de 105 dB.Potencia: 15 W.Consumo de 500 mA.	10.0100002	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1768	\N	Tubería de CPVC 1½" 	Tubería de CPVC 1½"  , Las tuberías de CPVC BlazeMaster®  de Durman y Spears,  para los sistemas de rociadores contra incendio, están hechas de policloruro de vinilo post-clorinado (CPVC)  están completamente aprobadas para el uso en todas las aplicaciones de riesgo tipo bajo (según NFPA 101). Estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3, (20, 25, 32,  40,  50, 65,  80 mm) con  espesor  de  pared RD-13.5. Los tubos  son  comercializados  en  longitudes  de 15  pies o  4.57 mts.. La tubería de CPVC. BlazeMaster ® esta aprobada para el uso en todas las aplicaciones de bajo riessgo tipo NFPA 13 en Edificios públicos. 	10.1270399	2	17		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1769	\N	Tapa Ciega de aluminio tipo GOST  2½" (70 mm)	Tapa Ciega de aluminio tipo GOST con cadena.  	10.15168	1	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1770	\N	Sellador	Pasta de Sellado 0,45kg 	10.1859999	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1771	\N	Base WRR	Base exterior IP65 para sirena de color rojo con entradas para tubos	10.2959995	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1772	\N	Base B501AP-BK	Base negra para detectores direccionables de la serie NFX	10.3290005	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1773	\N	Base B501AP	Base para detectores direccionables de la serie NFX	10.3290005	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1774	\N	Soporte para Montaje en Pared o Techo DSC LC-L1ST	Soporte para Montaje en Pared o Techo para Detectores de Interior LC Series	10.4169998	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1775	\N	Cable Termosensible PHSC-220-XCR	Cable Termosensible para Aplicaciones Industriales (Temperatura de Alarma 105˚C)	10.4610004	2	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1776	\N	Cable Termosensible PHSC-280-XCR	Cable Termosensible para Aplicaciones Industriales (Temperatura de Alarma 138˚C)	10.4610004	2	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1777	\N	Cable Termosensible PHSC-356-XCR	Cable Termosensible para Aplicaciones Industriales (Temperatura de Alarma 180˚C)	10.4610004	2	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1778	\N	Cable Termosensible PHSC-190-XCR	Cable Termosensible para Aplicaciones Industriales (Temperatura de Alarma 88˚C)	10.4610004	2	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1779	\N	Cable Termosensible PHSC-155-XCR	Cable Termosensible para Aplicaciones Industriales(Temperatura de Alarma 68˚C)	10.4610004	2	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1780	\N	Interruptor 2P, 125 A	Interruptor Modular Magneto-Térmico 2 Polos, Curva C, 125 A. 400V/10kA (Montaje en Perfil DIN)	10.4610004	1	1	21709-042 Paneles, Pizarras Electricas y sus Componentes	6656	A9N18369	Acti 9 - Interruptor Automatico Modular C120N - 3P - In=125A - Icn=10kA/400VCA (IEC 60898) - Curva C	55,32	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1781	\N	Interruptor 2P, 63 A	Interruptor Modular Magneto-Térmico 2 Polos, Curva C, 63 A. 400V/10kA (Montaje en Perfil DIN)	10.4610004	1	1	21709-042 Paneles, Pizarras Electricas y sus Componentes	6652	A9N18363	Acti 9 - Interruptor Automatico Modular C120N - 2P - In=125A - Icn=10kA/400VCA (IEC 60898) - Curva C	142,94	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1782	\N	Soporte SB-10	Caja Metálica de Montaje para Pulsador NBG-12L (Exterior)	10.5489998	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1783	\N	Soporte SB-10	Caja Metálica de Montaje para Pulsador NBG-12L (Exterior)	10.5489998	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1784	\N	Conexión rosca fija interior de latón Tipo STORZ para manguera diámetro 2" (DN50)	Conexión rosca fija interior Tipo STORZ: Material: Latón, Presión del trabajo: 10bar; 13bar, Presión de Brust: 30bar; 39bar	10.5582399	1	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1785	\N	Base B300-6(A) Nuevo	Bases para Detectores Direccionables de la serie 951	10.5710001	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1786	\N	Codo 90º 2" Soldado BM (CAMxCAM) 	Codo 90º 2" Soldado BM (CAMxCAM), estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	10.7139997	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1787	\N	Tubería Rígida KRALOY SCH40 PVC 1" 	Tubería Rígida KRALOY Conduit SCH 40 PVC Diámetro 1¨ Diámetro Int. 25 mm para exteriores resistente al fuego y rayos solares.	10.8500004	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1788	\N	Soporte para Montaje en Pared o Techo DSC LC-B1-15X	Soporte para Montaje en Pared o Techo para Detectores de Exterior LC Series	10.8570004	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1789	\N	Cable Termosensible PHSC-6893-TRI	Cable Termosensible para Exteriores con Pre-alarma (Temperatura de Pre-alarma 68˚C / Temperaturande Alarma 200˚C)	11.0299997	2	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1790	\N	Base de Montaje DSC DMC	Accesorio de Montaje en Techo para Sensores de Movimiento	11.3100004	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1791	\N	Módulo Expansor Honeywell 4193SN	Minimódulo Expansor de 1 Zona Serial V-Plex (Aplicación con Pulsador Manual Convencional)	11.2530003	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1792	\N	Módulo Expansor Honeywell 4293SN	Minimódulo Expansor de 2 Zonas Seriales V-Plex (Aplicación con Pulsador Manual Convencional y otros equipos convencionales)	11.2530003	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1793	\N	Base B401	Base para detector convencional serie 800	11.3629999	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1794	\N	Lente de Cortina DSC LC-L1-CL	Lente de Cortina Tipo Pasillo para Detectores LC-100-PI	11.3739996	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1795	\N	Kit de 4 Imanes Honeywell 5899	Kit de 4 Imanes para Transmisor 5816	11.5500002	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1796	\N	Conexión Rosca Fija Exterior de aluminio tipo GOST  2" (50mm)	Conexión rosca fija exterior de aluminio tipo GOST . Rosca GAS- BSP	11.6423998	1	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1797	\N	Plástico Recambio PSm30	Plástico de recambio para Pulsador Manual serie M paquete de 10 pz.	11.6709995	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1798	\N	Manguera  Extintor de 25 lts. 	Manguera con difusor de alta presion, para extintor movil de 25 L. (HOSE AND HORN 25 KG).	11.8000002	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1799	\N	Manguera  Extintor de 50 lts. 	Manguera con difusor de alta presion para extintor de 50 lts. (HOSE AND HORN 50 L).	11.8199997	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1800	\N	Tee  Red 2½" x 2½" x 1" (CAMxCAMxCAM)	Tee  Red 2½" x 2½" x 1" (CAMxCAMxCAM), estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	11.8249998	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1801	\N	Válvula  para Extintor de 2-5 kg	Válvula completa para extintores de CO2  2 - 5  kg. Fabricada en latón, acero cromado y caucho. Incluye pasador y sujección del precinto. (VALVE CO2    2 - 5 KG)	11.8299999	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1802	\N	Tubo de Muestreo DST5(A)	Tubo Metálico de Muestreo para Ducto de Ancho de 1.20 cm hasta 2.40 cm.  	11.8800001	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1803	\N	Sensor de Movimiento DSC LC-100-PI	Sensor de Movimiento Montaje en Pared con Inmunidad contra mascota (hasta 25kg/55lbs), con Tamper y relay Form A (NC) Alcance de 5 a 15m	12.1549997	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1804	\N	Registro Eléctrico de Metal 180 x 140 x 86 mm	Caja de Registro Rectangular Metalica con Tapa 180 x 140 x 86 mm Perforada 10 orificios     (IP-66) Exterior	12.3199997	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1805	\N	Pulsador M3A-R000SG-K013-41	Pulsador Manual Convencional por rotura de cristal con contacto NA o NC	12.3529997	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1806	\N	Tubo de Comprobación DST 5	Tubo de aspiración para conductos entre 120cm y 240cm de ancho.	12.3529997	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1807	\N	Cilindro Ext. PQS 9 KG	Cilindro Ext. PQS 9 KG (PQS 9 Kg conteiner).                                                                                                                Características Técnicas:\nAltura: (580-588) mm; Diametro 180 mm; Espesor Nominal de la pared 1,5 mm; Espesor mínimo de pared 1,50 mm; Volumen:(10,85-11,60) l; Peso:(4,20-5,50) kg.\nMateriales:\nBotella de acero soldado: Fabricada en chapa de acero laminada en frio, de bajo contenido de carbono para embutición profunda; Conexion roscada para valvula fabricada con barra de acero M 30.     \nAcabado:                                                                                                                                                                                           Pintura al horno 100 % poliéster, RAL 3000, espesor de la capa de pintura que garantice como mínimo 480 horas de la prueba de nieblas salinas sin que aparezca síntomas de corrosión exterior.       	12.3800001	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1808	\N	Válvula  para Extintor de 10 kg	Válvula completa para extintores de CO2  10 kg. Fabricada en latón, acero cromado y caucho. Incluye pasador y sujección del precinto. (VALVE CO2    10 KG)	12.4300003	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1809	\N	Barra de Equipotencialización	Barra de Equipotencializacíon de Mallas de Puesta a Tierra. Cobre-Estañado para Conexión de Cable hasta Calibre: 1/0AWG y Pletina 20 mm x 3 mm.	12.441	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1810	\N	Buje 3" x 2" (CAM x ESP)	Buje 3" x 2" (CAM x ESP),estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	12.441	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1889	\N	Brida Fija 2½" (CAMx Brida)	Brida Fija 2½" (CAMx Brida), estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	23.5949993	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1890	\N	Soporte SBA-10	Caja Metálica de Montaje para Pulsador de Aborto/Disparo NBG-12LRA	23.9139996	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1891	\N	Soporte SBA-10	Caja Metálica de Montaje para Pulsador de Aborto/Disparo NBG-12LRA	23.9139996	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1892	\N	Tee 2½" (CAMxCAMxCAM) 	Tee 2½" (CAMxCAMxCAM), estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	24.0900002	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1893	\N	Accesorio de Montaje Individual Supresores	Accesorio de Montaje en Rack para Supresor Individual de Redes Informáticas. 	24.3759995	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1894	\N	Caja de Montaje Honeywell 5140MPS-BB	Caja de Montaje para Pulsador MPS series	24.4529991	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1895	\N	Caja 6500-SMK Kit 	Caja para montaje en superficie profundidad de 43mm para detectores de humo lineales	24.7169991	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1896	\N	Caja 6500-SMK Kit 	Caja para montaje en superficie profundidad de 43mm para detectores de humo lineales	24.7169991	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1897	\N	Tubería Flexible Metalica EMT 1"	Tubería Flexible Metalica EMT 1¨, Diámetro Int. 25 mm, Diámetro Ext. 32 mm de Acero Electrogalvanizado o Galvanizado en Caliente	25	2	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1898	\N	Tubería Flexible Metalica EMT 3/4"	Tubería Flexible Metalica EMT 3/4¨, Diámetro Int. 20 mm, Diámetro Ext. 25 mm de Acero Electrogalvanizado o Galvanizado en Caliente	25	2	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1899	\N	Conexión Rosca Fija Interior de aluminio tipo GOST 5" (125 mm)	Conexión rosca fija interior de aluminio tipo GOST . Rosca GAS- BSP	25.0095997	1	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1900	\N	Módulo Aislador ISO-X	Módulo Aislador de Corto Cicuito en el Lazo	25.1790009	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1901	\N	Sirena HWLA Nuevo	Sirena (Blanca) Serie L (2 hilos) Montaje en Pared Interior	25.5639992	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1902	\N	Sirena HRLA Nuevo	Sirena (Roja) Serie L (2 hilos) Montaje en Pared Interior	25.5639992	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1903	\N	Llavero Inalambrico Honeywell 5834-2	Llavero Inalambrico Unidireccional de 2 Botones Negro	25.6079998	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1905	\N	Chasis NCA-640-2-KIT	Chasis para Montaje de Anunciador NCA-2 en Chasis CHS2-M2	26.1800003	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1906	\N	Batería BAT-12120	Batería Sellada de 12 Volt 12 A/H	26.3339996	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1907	\N	Detector 2W-B	Detector Óptico Convencional con Base a 2 Hilos	26.8290005	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1908	\N	Conexión Barcelona  para Manguera de 45 mm (1½")	Conexión tipo Barcelona para manguera plana, completa, con junta estanca incluida, de alta resistencia.	26.9561596	1	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1909	\N	Recarga para Electrodo Químico	Compuesto de Recarga para Electrodo Químico 	27.0599995	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1910	\N	Sensor Movimiento Honeywell IS335	Sensor de Movimiento de Montaje en Pared Antimascotas 80 lbs Alcance 12m x 17m	27.2250004	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1911	\N	Estaño	Estaño con Fundente, Diámetro: 1 mm, Peso: 500g, Estaño(Sn): 40%, Plomo(Pb): 60%, Temperatura de Fusión: 183-m38 °C, Norma: Alloy No. 114	27.3129997	1	6		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1912	\N	Doblador de Tuberias Metalicas EMT 1/2"	Doblador para Tuberias Metalicas EMT 1/2¨, Diámetro Int. 15 mm, Diámetro Ext. 20 mm 	27.5	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1913	\N	Sensor Movimiento 360° Honeywell IS-280CM	Sensor de Movimiento 360° de Montaje en Techo Altura Maxima 3m /radio 14 m	27.6870003	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1914	\N	Sensor Movimiento Honeywell IS3035	Sensor de Movimiento de Montaje en Pared Optica de Fresnel Alcance 12m x 17m	28.1130009	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1915	\N	Plancha de Neopreno de 1400 mm x 1000 mmx 3 mm	Plancha de Neopreno, para realizar juntas de válvulas y conexiones en las redes  hidráulicas. Características: Color negro, densidad 1.45, dureza 60, rotura 50 Kg/cm2, alargamiento 300%, temperatura -20 +100°C 	28.1388798	1	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1916	\N	PS-1212	Batería de 12V. Capacidad 12Ah	28.1490002	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1917	\N	Cilindro Ext. PQS 25 Kg	Cilindro con accesorios, chasi y ruedas para Extintor movil PQS 25 Kg.                                                                                Caracteristicas Técnicas: Altura (915-978) mm; Diametro 250mm; Espesor Nominal de la pared 2,5 mm; Espesor mínimo de pared 2,50 mm; Volumen:29 l; Peso:(19-20,77) kg ,                                                                                                         Materiales: Botella y chasis: Fabricada en chapa de acero; Valvula manual: Latón, acero y caucho (incluye pasador de seguridad en maneta de accionamiento y precinto sobre pasador); Indicador de presión: ø 27mm: Latón cromado; Manguera: caucho, textil, acero y propileno;  presión de servicio de la manguera: 20 bar, presión de ruptura de la manguera: 65 bar;Tubo Sonda de PVC ó Polipropileno. Etiqueta Serigrafiadaó Acetato Adhesivo. Ruedas de carro: ø 300 mm polipropileno y caucho sintético.                                                                                                                                                                  Acabado:                                                                                                                                                                                                                                                                                                                                       Pintura al horno 100 % poliéster, RAL 3000, espesor de la capa de pintura que garantice como mínimo 480 horas de la prueba de nieblas salinas sin que aparezca síntomas de corrosión exterior.	28.1499996	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1918	\N	Tee 3" (CAMxCAMxCAM) 	Tee 3" (CAMxCAMxCAM), estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	29.0179996	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1919	\N	Módulo Monitor FMM-1(A)	Módulo Monitor de 1 Entrada de Contactos Secos	29.1280003	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1920	\N	Pulsador NBG-12L	Pulsador Manual Convencional Acción Doble con Llave	29.1280003	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1921	\N	Pulsador NBG-12LSP	Pulsador Manual Convencional Acción Doble con Llave (Idioma Español)	29.1280003	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1922	\N	Pulsador NBG-12LRA	Pulsador Manual Convencional de Disparo/Aborto para Extinción Accion Doble y Led de Estado	29.1280003	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1923	\N	Sensor Movimiento Honeywell IS3050A-SN	Sensor de Movimiento de Montaje en Pared (Alcance Max de 16 x 12 m) V-Plex	29.2600002	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1924	\N	Fuente Auxiliar DSC PS3020	Fuente de alimentación regulada de 6 voltios o 12 voltios, seleccionable por puente, 2,2 A con cargador de batería incorporado e indicador de alimenatción de CA	29.5240002	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1925	\N	Contacto Magnetico Inalambrico Honeywell 5800MINI	Contacto Magnetico Inalambrico Blanco con Led de estado, incluye Iman y bateria	30.0300007	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1926	\N	Contacto Magnetico Inalambrico Honeywell 5800MINIBR	Contacto Magnetico Inalambrico Carmelita con Led de estado, incluye Iman y bateria	30.0300007	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1927	\N	Sensor de Movimiento Honeywell 5800PIR	Sensor de Movimiento Inalámbrico de Montaje en Pared (alcance de 11 m x 12 m)	30.0300007	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1928	\N	Sirena Honeywell 748L	Sirena para Interiores o Exteriores con Tamper, Resistente al agua, protección contra UV.Salida de 2 tonos de 112 dB.Potencia: 25 W.Consumo de 1300 mA	30.0300007	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1929	\N	Adaptador Macho  1¼" (CAMxROS)	Adaptador Macho  1¼" (CAMxROS) estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	30.5690002	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1930	\N	Sensor Movimiento Honeywell IS3050	Sensor de Movimiento de Montaje en Pared Optica de de Fresnel Alcance 16m x 22m	31.0039997	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1931	\N	Módulo de Reemplazo  para Supresor para Red de Energía Tipo 2, 300V	Módulo de Reemplazo Tipo 2 (Fase) Un: 300 Vac, Uc: 320 Vac, In: 20 kA, Imax: 40 kA. 	31.1739998	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1932	\N	Detector de Rotura de Vidrio Digital DSC LC-105DGB	Detector de Ruptura de Vidrio Digital montaje en Pared o Techo con contacto Form A (NC) y Tamper 	31.2509995	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1933	\N	Detector de Rotura de Vidrio DSC AC-101	Detector de Ruptura de Vidrio montaje en Pared con contacto Form A (NC) y Tamper	31.2509995	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1934	\N	Tapa Ciega de aluminio tipo GOST  5" (125 mm)	Tapa Ciega de aluminio tipo GOST con cadena.  	31.4160004	1	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1935	\N	Pica 	Pica o Electrodo de Acero, con recubrimiento de Cobre (300 µm). Diámetro 16 mm. Largo 3000 mm 	31.5919991	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1936	\N	Contacto Magnetico Inalambrico Honeywell 5816WMWH	Contacto Magnetico Inalambrico Blanco con Iman y Bateria incluidos	31.7679996	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1937	\N	Contacto Magnetico Inalambrico Honeywell 5816WMBR	Contacto Magnetico Inalambrico Carmelita con Led de estado, incluye Iman y bateria	31.7679996	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1938	\N	Detector FST-951(A) Nuevo	Detector de Temperatura Fija 57°C Direccionable (usa la base B300-6)	32.0099983	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1939	\N	Detector 2WT-B	Detector Óptico/Térmico Convencional con Base a 2 Hilos (57 grados) i3 series 	32.0099983	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1940	\N	Tee  Red 3" x 3" x  2½ (CAMxCAMxCAM)	Tee  Red 3" x 3" x  2½ (CAMxCAMxCAM), estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	32.4500008	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1941	\N	Detector 5624	Detector Temperatura Fija Convencional con Base  a 4 Hilos (90 grados)	32.4939995	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1942	\N	Detector 56m3	Detector Temperatura Fija Convencional con Base a 4 Hilos (57 grados)	32.5600014	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1943	\N	Sensor Movimiento Honeywell IS3050A	Sensor de Movimiento de Montaje en Pared Optica de Espejo Antienmascaramiento Alcance 16m x 22m	32.5639992	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1944	\N	Boton de Panico Inalámbrico Honeywell 5802WXT	Botón de Pánico Inalámbrico Modelo Pulsera (1 Botón) con Batería de 3 Volts Lithium	32.9507217	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1945	\N	Boton de Panico Inalámbrico Honeywell 5869 	Botón de Pánico Inalambrico con Carcasa de Plástico	32.9560013	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1946	\N	Válvula de pie con filtro de bronce  2" 	Válvula de pie, cuerpo de laton con filtro de bronce. Rosca NPT,  PN-16	33.0299187	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1947	\N	Base Horizontal para Punta Franklin	Base horizontal para instalar Punta Franklin sobre techo plano, rosca hembra M10.	33.2420006	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1948	\N	Base Vertical para Punta Franklin	Base vertical para Punta Franklin, rosca hembra M10.	33.2420006	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1949	\N	Sensor de Movimiento DSC AMB-300	Sensor de Movimiento de Pir de Montaje en Pared con Tamper (Alcance Máximo 12 m)	33.5060005	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1950	\N	Tubería de CPVC 2½" 	Tubería de CPVC 2½"  , Las tuberías de CPVC BlazeMaster®  de Durman y Spears,  para los sistemas de rociadores contra incendio, están hechas de policloruro de vinilo post-clorinado (CPVC)  están completamente aprobadas para el uso en todas las aplicaciones de riesgo tipo bajo (según NFPA 101). Estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3, (20, 25, 32,  40,  50, 65,  80 mm) con  espesor  de  pared RD-13.5. Los tubos  son  comercializados  en  longitudes  de 15  pies o  4.57 mts.. La tubería de CPVC. BlazeMaster ® esta aprobada para el uso en todas las aplicaciones de bajo riessgo tipo NFPA 13 en Edificios públicos. 	33.5103989	2	17		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1951	\N	Módulo de Reemplazo  para Supresor para Red de Energía Tipo 2, 120V	Módulo de Reemplazo Tipo 2 (Fase) Un: 120 Vac, Uc: 150 Vac, In: 20 kA, Imax: 40 kA. 	33.6930008	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1952	\N	Fuente Auxiliar Honeywell AD12612	Fuente de Alimentacion Auxiliar de 16VAC 6/12VDC 1.2A	33.7319984	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1953	\N	Tubo de Comprobación DST 10	Tubo de aspiración para conductos entre 240cm y 360cm de ancho.	33.7369995	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1954	\N	Sensor de Movimiento DSC BV-601	Sensor de Movimiento de Doble Pir de Montaje en Pared con Inmunidada contra Mascotas y Tamper y relay Form A (NC) (Alcance Máximo 12 m)	33.7480011	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1955	\N	Extintor portátil POLVO ABC 9 kg lleno (PQS  9 Kg Full Extinguisher). 	Extintor PQS  ABC 9kg lleno, incluye colgador. Agente Extintor : Polvo ABC 55 Agente propulsor Nitrogeno, carga140 g Eficacia Mínina requerida27A-144B. Acabado: pintura al Horno 100%poliester, Ral 3000 espesor de la capa que garantyice como minimo 480 hrs de la prueba de nieblas salinas si n que aparezcan sintomas de corrosión.Caracteristicas Técnicas:Presión de diseño:25 bar,Presión de prueba:25 bar Presión maxima de servcio: 17 bar.Presión de ruptura de la botella110-190 bar;Carga 9kg±5%Temperatura de servicio:-20 a 60 ºC Uso Aconsejable: Fuegos ABC y E para tensiónes electricas menores a 35 Kv; Altura (580-588)mm;Diametro 180mm; Espesor Nominal de la pared 1,5mm;Espesor mínimo de pared 1,50 mm; Volumen:(10,85-11,60); tara:(4,20-5,50) kg , Peso total:(13,34-13,50) kg. Materiales: Botella de acero soldada:fabricada en chapa de acero laminada en frio, de bajo contenido de carbono para embutición profunda; Valvula:Latón, acero y caucho; Indicador de presión :ø 27mm:Latón cromado;Manguera:PVC,textil y PEAD;  presión de servicio de la manguera: 20 bar, presión de ruptura de la manguera:65bar,Peana: propileno;Tubo Sonda de PVC ó Polipropileno. Etiqueta Serigrafiadaó Acetato Adhesivo Colgador Mural:fabricado en acero galvanizado.	33.7700005	1	4		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1956	\N	Módulo de Control FCM-1(A) 	Módulo de Control Direccionable, 1 Salida Programable de 24 Vdc	33.8139992	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1957	\N	Detector FSP-851(A)	Detector de Humo Óptico Direccionable (usa la base B210LP) 	34.1110001	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1958	\N	Detector FAPT-851(A)	Detector Multicriterio Inteligente Optico/Termico  con Ajuste Automatico de Sensibilidad con el Ambiente (usa la base B210LP) 	34.1110001	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1959	\N	Anunciador Remoto RTS151	Estación de Test Remoto para Detector FS-OSI-RIA	34.3419991	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1960	\N	Anunciador Remoto RTS151	Estación de Test Remoto para Detector FS-OSI-RIA	34.3419991	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1961	\N	Detector 5602	Detector Temperatura Fija/Termovelocimétrico Convencional con Base a 2 Hilos (90 grados)	34.4959984	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1962	\N	Módulo Expansor Honeywell 4219	Módulo Expansor de 8 Zonas (Panel de Intrusos Vista 48)	34.6500015	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1963	\N	Protector STI-9610	Protector de Superficie para Detectores de Humo Alto Perfil (detectores de gran tamaño)	34.8040009	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1964	\N	Protector STI-9602	Protector de Superficie para Detectores de Humo Bajo Perfil (detectores de tamaño standar)	34.8040009	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1965	\N	Base B224BI(A)	Base con Aislador para Detectores Direccionables de la serie 851 y 951	35.2659988	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1966	\N	Módulo de Reemplazo  para Supresor para Red de Energía Tipo 2, m30V	Módulo de Reemplazo Tipo 2 (Fase) Un: m30 Vac, Uc: 275 Vac, In: 20 kA, Imax: 40 kA. 	35.3540001	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1967	\N	Detector FD-851HTE A	Detector de Alta Temperatura 77 c° convencional	35.8380013	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1968	\N	Conctacto Magnético Inalámbrico DSC WS4925	Contacto Magnético Inalámbrico de Puerta/Ventana 433 MHz (con cinta adhesiva)	35.9480019	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1969	\N	Conctacto Magnético Inalámbrico DSC WS4945W	Contacto Magnético Inalámbrico de Puerta/Ventana Blanco 433 MHz 	35.9480019	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1970	\N	Conctacto Magnético Inalámbrico DSC WS4945B	Contacto Magnético Inalámbrico de Puerta/Ventana Marrón 433 MHz 	35.9480019	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1971	\N	Conctacto Magnético Inalámbrico de Empotrar  DSC EV-DW4917	Contacto Magnético Inalámbrico para Empotrar en Puerta/Ventana Marrón 433 MHz 	35.9480019	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1972	\N	Revestimiento BP2-4	Placa Sólida para Revestimiento de la ultima fila o compartimiento de Baterías 	35.9700012	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1973	\N	Contacto Magnético Exterior Honeywell 4959SN	Contacto Magnético de Aluminio para Puerta Abatible con Accesorio en L, y Cable de 60 cm, V-Plex	35.980999	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1974	\N	Receptor Inalámbrico Honeywell 5881ENL	Módulo Receptor Inalambrico 8 Zonas (Funcionamiento Unidireccional)	35.9920006	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1975	\N	Base B224RB(A)	Base Relay para Detectores Direccionables de la serie 851 y 951	36.0359993	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1976	\N	Detector 302-135	Detector TF/TV Convencional tipo Bulbo Montaje Interior (57 Grados)	36.0800018	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1977	\N	Detector 302-194	Detector TF/TV Convencional tipo Bulbo Montaje Interior (90 Grados)	36.0800018	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1978	\N	Contacto Magnético Direccionable para Incendios DSC AMP-702	Contacto Magnético Direccionable para aplicaciones contra incendio con entrada de contacto externo normalmente abierto, supervisada mediante resistor de fn de línea	36.1679993	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1979	\N	Detector FD-851RE A	Detector Temperatura Fija 58 c°-Termovelocimétrico convencional	36.1679993	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1980	\N	Extintor portátil de polvo químico seco ABC 3kg	Extintor PQS  ABC 3kg lleno, incluye colgador y soporte para vehiculo. Agente Extintor : Polvo ABC 55 Agente propulsor Nitrogeno, carga 40 g Eficacia Mínina requerida13A-55B. Acabado: pintura al Horno 100%poliester, Ral 3000 espesor de la capa que garantyice como minimo 480 hrs de la prueba de nieblas salinas si n que aparezcan sintomas de corrosión.Caracteristicas Técnicas:Presión de diseño:25 bar,Presión de prueba:25 bar Presión maxima de servcio: 17 bar.Pr4esión de ruptura de la botella110-190 bar;Carga 3kg±5%Temperatura de servicio:-20 a 60 ºC Uso Aconsejable: Fuegos ABC y E para tensiónes electricas menoresa 35 Kv; Altura 4981mm;Diametro 110mm; Espesor Nominal de la pared 1,2mm;Espesor mínimo de pared 1,20 mm; Volumen:3,30l; tara: 2,25 kg , Peso toral 5,03kg. Materiales: Botella de acero soldada:fabricada en chapa de acero laminada en frio, de bajo contenido de carbono para embutición profunda; Valvula:Latón, acero y caucho; Indicador de presión :ø m3mm:Latón cromado;difusor de polipropileno Tubo Sonda de PVC ó Polipropileno. Etiqueta Serigrafiadaó Acetato Adhesivo Colgador Mural:fabricado en acero galvanizado.Soporte para vehículo con fleje de acro cincado	36.2200012	1	4		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1981	\N	Lanza Variomatic de  1½" de tres efectos, de latón o bronce.	Lanza Variomatic de 3 efectos (chorro, cortina y cierre) , con rosca hembra de acople y racor Tipo Barcelona rosca fija exterior. Material  latón, bronce.	36.5164795	1	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1982	\N	Teclado Mensajes Fijos Honeywell 6150SP	Teclado de Mensajes Fijos (Paneles Vista 48,50,128,250)	36.5309982	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1983	\N	Módulo de Reemplazo para Supresor para Red de Energía Tipo 3, 2P, 120V	Módulo de Reemplazo Tipo 3 (Fase + Fase) Un: 120 Vac, Uc: 150 Vac, IL: 25 A, In: 2 kA, Itotal: 4 kA.. 	36.5639992	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1984	\N	Módulo de Reemplazo para Supresor para Red de Energía Tipo 3, 2P, m30V	Módulo de Reemplazo Tipo 3 (Fase + Fase) Un: m30 Vac, Uc: 255 Vac, IL: 25 A, In: 3 kA, Itotal: 5 kA.. 	36.5639992	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1985	\N	Adaptador Macho  1½" (CAMxROS)	Adaptador Macho  1½" (CAMxROS) estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	36.6739998	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1986	\N	Tubo de Muestreo DST10(A)	Tubo Metálico de Muestreo para Ducto de Ancho de 2.40 cm hasta 3.70 cm.  	36.7400017	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1987	\N	Organizador WC-2	Organizador de Cables en Gabinete	37.0480003	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1988	\N	Armario Inyectado PVC-ABS	Armario Inyectado FI-60 de PVC-ABS, uso interperie, totalmente estanco, dielectrico y de alta resistencia al impacto, dimensiones 700 x 285 x m30 mm exteriores y 645 x 225 x 200 mm interiores, valido para extintor: 3, 6, 9 kg de polvo, 6 y 9 litros hidricos y 2 kg de CO2, 	37.0800018	1	2	m3501-073 Tornilleria, Fijaciones y Expansiones	7	m35017/76.16.10.00	Kit fijación soportes.Incluye: (tornillo Ø 5 x 40 + taco Ø\n8 mm) (Cant. min 1000)	26,48	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1989	\N	Módulo Expansor Direccionable DSC PowerSeries PC-5100	Módulo Expansor de 32 Zonas Direccionables PowerSeries	37.2900009	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1990	\N	Módulo Expansor DSC PowerSeries PC-5108	Módulo Expansor de 8 Zonas Cableadas PowerSeries	37.2900009	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1991	\N	Base para Supresor	Base para Supresores de 12-24 Vdc	37.4000015	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1992	\N	Sensor de Movimiento 360 Grados DSC AMB-500	Sensor de Movimiento de Montaje en Techo con Tamper (Radio de Cobertura de 4,6 a 6 m)	37.4659996	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1993	\N	Módulo M710E	Módulo monitor direccionable con 1 entrada supervisada, led de estado y aislador incorporado	37.5540009	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1994	\N	Estrobo SCRLA Nuevo	Estrobo (Rojo) Serie L (2 hilos) Montaje en Techo Interior	37.5760002	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1995	\N	Teclado Mensajes Fijos Honeywell 6148SP	Teclado de Mensajes Fijos (Solo Vista 48)	37.7299995	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1996	\N	Sensor Movimiento Honeywell DT8050A-SN	Sensor de Movimiento y Microonda de Montaje en Pared (Alcance Max de 16 x 12 m) V-Plex	37.8400002	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1997	\N	Detector FST-851(A)	Detector de Temperatura Fija 57°C Direccionable (usa la base B210LP)	38.1150017	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1998	\N	Detector FST-851R(A)	Detector de Temperatura Fija 57°C/ Termovelocimétrico Direccionable (usa la base B210LP) 	38.1150017	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
1999	\N	Cilindro Ext PQS 50 Kg	Cilindro con accesorios chasi y ruedas para Extintor movil PQS 50 Kg                                                                                   Caracteristicas Técnicas: Altura (1003-1050) mm; Diametro 300 mm; Espesor Nominal de la pared 2,5 mm; Volumen:52l; Peso: (24,5-25,06) kg.                                                                                                                                          Materiales: Botella y chasis: Fabricada en chapa de acero; Valvula manual: Latón, acero y caucho (incluye pasador de seguridad en maneta de accionamiento y precinto sobre pasador); Indicador de presión: ø 37mm: Latón cromado; Manguera: caucho, textil, acero y propileno;  presión de servicio de la manguera: 20 bar, presión de ruptura de la manguera:65bar; Tubo Sonda de PVC ó Polipropileno. Etiqueta Serigrafiadaó Acetato Adhesivo. Ruedas de carro: ø 300 mm polipropileno y caucho sintético.                                                                                                                                                                   Acabado:                                                                                                                                                                                                                                                                                                      Pintura al horno 100 % poliéster, RAL 3000, espesor de la capa de pintura que garantice como mínimo 480 horas de la prueba de nieblas salinas sin que aparezca síntomas de corrosión exterior.	38.4300003	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2065	\N	Acondicionador de Suelos	Compuesto Químico Acondicionador o Mejorador de Suelos.	47.3110008	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2066	\N	Base B200SCO(A)	Base Sonora para Detectores Direccionables para Detector FCO-851 y 951 (Volumen Bajo)	47.4319992	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2000	\N	Armario de polipropileno con puerta personalizada Tipo C	Armario para extintor relizado en polipropileno tratado, cuerpo color negro y puerta reforzada de color rojo, reversible con doble ventana personalizada con logotipo SEISA.  Uso intemperie,  resistente a cambios de temperatura,  estabilazdo para UV, totalmente estanco, dielectrico y de alta resistencia al impacto de 830 x 310 x 263mm. Con capacidad para extintor de CO2 de 5 Kgs.	38.5999985	1	2		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2001	\N	Módulo Relay Honeywell 4201SN	Módulo de un Relay Supervisado 2A 28VAC/VDC V-Plex (Paneles de Intruso Vistas 50/128/250)	38.8520012	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2002	\N	Módulo Relé FRM-1(A) 	Módulo Relay Direccionable Forma C,1 Salida Programables de Relay, Contactos Libres de Potencial	38.8520012	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2003	\N	Supresor de Sobretensiones Transitorias para Red de Energía. Tipo 3	Protector Tipo 3 de 6 Salidas Protegidas contra Sobretensiones Transitorias. Cordón de 1,5 m. Tipo de Conexión NEMA. Un: 120Vac. 	39.1380005	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2004	\N	Lanza Variomatic de  2" de tres efectos, de latón o bronce.	Lanza Variomatic de 3 efectos (chorro, cortina y cierre) , con rosca hembra de acople y racor Tipo GOST rosca fija exterior. Material  latón, bronce.	39.5102386	1	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2005	\N	Sensor de Movimiento combinado con ruptura de Vidrio DSC LC-102PIGBSS	Sensor de Movimiento combinado con Ruptura de Vidrio  Montaje en Pared conInmunidad contra mascota con Tamper y relay Form A (NC) (hasta 25kg/55lbs), Alcance de 5 a 15m	39.512001	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2006	\N	Batería BAT-12180	Batería Sellada de 12 Volt 18 A/H	39.5670013	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2007	\N	Sirena con Estrobo P2RLA Nuevo	Sirena/Estrobo (Roja) Serie L (2 hilos) Montaje en Pared Interior Candela Ajustable	39.5670013	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2008	\N	Sirena con Estrobo P2WLA Nuevo	Sirena/Estrobo (Roja) Serie L (2 hilos) Montaje en Pared Interior Candela Ajustable	39.5670013	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2009	\N	Detector 302-AW-135	Detector TF/TV Convencional tipo Bulbo Montaje Exterior (57 Grados)	39.5999985	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2010	\N	Detector 302-ET-135	Detector TF/TV Convencional tipo Bulbo Montaje Exterior (57 Grados)	39.5999985	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2011	\N	Detector 302-AW-194	Detector TF/TV Convencional tipo Bulbo Montaje Exterior (90 Grados)	39.5999985	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2012	\N	Detector 302-ET-194	Detector TF/TV Convencional tipo bulbo Montaje Exterior (90 Grados)	39.5999985	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2013	\N	Contacto Magnético Direccionable con 4 zonas externas           DSC AMP-704	Contacto Magnético Direccionable con 4 zonas externas para 4 contacto de puertas y ventanas cableados normalmente cerrados con resistores de fin de línea simples o dobles	39.6879997	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2014	\N	Módulo Expansor Honeywell 4229	Módulo Expansor de 8 Zonas con 2 Relé Forma C (Panel de Intrusos Vista 48)	39.7099991	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2015	\N	Boton de Panico Inalámbrico Honeywell 5802WXT-2	Botón de Pánico Inalámbrico Modelo Pulsera (2 Botones) con Batería de 3 Volts Lithium	39.7364006	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2016	\N	Detector 4W-B	Detector Óptico Convencional con Base a 4 Hilos	39.8639984	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2017	\N	Detector 4WT-B	Detector Óptico/Térmico Convencional con Base a 4 Hilos (57 grados) i3 series	39.8639984	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2018	\N	Sensor de Movimiento 360 Grados DSC BV-501	Sensor de Movimiento de Montaje en Techo con Tamper y relay Form A (NC) (Radio de Cobertura de 4,6 a 6 m)	40.0180016	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2019	\N	Sirena con Estrobo P2GRLA Nuevo	Sirena/Estrobo Compacta (Roja) Serie L (2 hilos) Montaje en Pared Interior Candela Ajustable	40.1100006	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2020	\N	Sirena con Estrobo P2GWLA Nuevo	Sirena/Estrobo Compacta (Roja) Serie L (2 hilos) Montaje en Pared Interior Candela Ajustable	40.1100006	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2021	\N	Sensor Movimiento Solicitud de Salida Honeywell IS320WH	Sensor Movimiento Blanco para Solicitud de Salida con Buzzer y control de volumen, entrada de contacto de puerta, lectora y teclado Rango desde 1.67m x 0.6m hasta 4.8 x 2.5m	40.1829987	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2022	\N	Receptor InalámbricoHoneywell 5881ENH	Módulo Receptor Inalambrico Zonas Ilimitadas (Funcionamiento Unidireccional)	40.2599983	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2023	\N	Guardera PVC	Guardera para Protección de Bajante 3000 mm de PVC	40.5789986	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2024	\N	Módulo de Reemplazo  para Supresor para Red de Energía Tipo 2, Neutro	Módulo de Reemplazo Tipo 2 (Neutro) Uc: 255 Vac, In: 20 kA, Imax: 40 kA. 	40.5789986	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2025	\N	Protector STI1221D	Protector de Superficie para Estrobo Solamente	40.6559982	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2026	\N	Protector STI1210D	Protector de Superficie para Sirena Estroboscópica	40.6559982	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2027	\N	Sensores de Vibración DSC SS-102	Sensores de Vibración con Tamper	40.8100014	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2028	\N	Sirena con Estrobo P4RLA Nuevo	Sirena/Estrobo (Roja) Serie L (4 hilos) Montaje en Pared Interior Candela Ajustable	41.3100014	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2029	\N	Sirena con Estrobo P4WLA Nuevo	Sirena/Estrobo (Roja) Serie L (4 hilos) Montaje en Pared Interior Candela Ajustable	41.3100014	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2030	\N	Detector FSP-851R(A)	Detector de Humo Óptico Direccionable (Test Remoto solo con DNR-DNRW)  (usa la base B210LP) 	41.4150009	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2031	\N	Sensor Movimiento Doble Tecnica DSC LC-124-PIMW	Sensor de movimiento de doble tecnología sensor PIR y microondas con inmunidad a mascotas  Form C (NC&NO) (Alcance Max.18 x 15m) 	41.6790009	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2032	\N	Sensor Movimiento Doble Tecnica DSC LC-104-PIMW	Sensor de movimiento de doble tecnología sensor PIR y microondas con inmunidad a mascotas contacto Form A (NC) (Alcance Max.18 x 15m) 	41.6790009	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2033	\N	Sensor Movimiento para Exteriores DSC LC-181 	Sensor de movimiento PIR con inmunidad a mascotas regulable contacto para Exteriores Form C (NC&NO) Montaje en Pared con Tamper (Alcance Max.18 x 15m) 	41.6790009	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2034	\N	Soporte de Riel DIN para montaje en Rack	Soporte de Riel DIN para montaje en Rack largo 19"	41.7560005	1	1	21709-042 Paneles, Pizarras Electricas y sus Componentes	21611	NSYAMRD30357SB	Carril DIN simétrico de 35x7,5mm suministrados sin tornillos, altura 150 y 200mm, anchura 300mm, profundidad 80 y 120mm	30,04	2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2067	\N	Sensor Movimiento Doble Tecnica DSC LC-103-PIMSK	Sensor de movimiento de doble tecnología sensor PIR y microondas con inmunidad a mascotas y función de antienmascaramiento contacto Form A (NC) (Alcance Max.18 x 15m) 	47.5309982	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2068	\N	Sensor Movimiento Doble Tecnica DSC LC-1m3-PIMSK	Sensor de movimiento de doble tecnología sensor PIR y microondas con inmunidad a mascotas y función de antienmascaramiento contacto Form C (NC&NO) (Alcance Max.18 x 15m) 	47.5309982	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2069	\N	Detector FST-851H(A)	Detector de Alta Termperatura Fija 88°C Direccionable (usa la base B210LP) 	47.7840004	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2070	\N	Módulo Monitor FMM-101(A)	Minimódulo Monitor de 1 Entrada Programable para Dispositivos Convencionales a 2 o 4 Hilos	47.7840004	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2071	\N	Detector NFXI-OPT	Detector direccionable fotoeléctrico de humo con modulo aislador	47.8720016	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2035	\N	Cilindro  Ext. Espuma 25 l 	Cilindro con revestimiento interior + accesorios, chasi y ruedas para Extintor movil Espuma 25 l                                                      Caracteristicas Técnicas: Altura (915-978) mm; Diametro 250 mm; Espesor Nominal de la pared 2,5 mm; Espesor mínimo de pared 2,50 mm; Volumen:29 l; Peso:(19-20,77) kg ,                                                                                                         Materiales: Botella y chasis: Fabricada en chapa de acero; Valvula manual: Latón, acero y caucho (incluye pasador de seguridad en maneta de accionamiento y precinto sobre pasador); Indicador de presión: ø 27mm: Latón cromado; Manguera: caucho, textil, acero y propileno;  presión de servicio de la manguera: 20 bar, presión de ruptura de la manguera: 65 bar;Tubo Sonda de PVC ó Polipropileno. Etiqueta Serigrafiadaó Acetato Adhesivo. Ruedas de carro: ø 300 mm polipropileno y caucho sintético.                                                                                                                                                                  Acabado:                                                                                                                                                                                                                                                                                                                                              Pintura al horno 100 % poliéster, RAL 3000, espesor de la capa de pintura que garantice como mínimo 480 horas de la prueba de nieblas salinas sin que aparezca síntomas de corrosión exterior.                                          	42.1500015	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2036	\N	Contacto Magnetico Inalambrico Honeywell 5816WH	Contacto Magnetico Inalambrico Blanco con Iman y Bateria incluidos	42.1520004	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2037	\N	Contacto Magnetico Inalambrico Honeywell 5816BR	Contacto Magnetico Inalambrico Carmelita con Led de estado, incluye Iman y bateria	42.1520004	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2038	\N	Módulo de Reemplazo para Supresor para Red de Energía Tipo 3, 4P, 120V	Módulo de Reemplazo Tipo 3 (3 Fase + Neutro) Un: 120 Vac, Uc: 150 Vac, IL: 25 A, In: 3 kA, Itotal: 5 kA.. 	42.7789993	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2039	\N	Extintor portátil de dióxido de carbono CO2 2 kg	Extintor portátil de  CO2 2 kg lleno (CO2  2 Kg Full Extinguisher). Incluye colgador mural de acero.\nAgente extintor: Bióxido de carbono. Eficacia minima requerida: 21B \nAcabado: Pintura al horno 100 % poliéster, RAL 3000, espesor de la capa de pintura que garantice como minimo 480 horas de la prueba de nieblas salinas sin que aparezca síntomas de corrosión exterior. \nCaracterísticas Técnicas:\nPresión de diseño: 250 Bar; Presión de prueba: 250 Bar; Presión máxima de servicio: 174  -180 Bar;  Presión de rotura de botella: 570 Bar; Presión de tarado disco de seguridad: 190 Bar ± 10 %; Carga: 1,9 - 2 kg CO2; Temperatura de Servicio: -20 a 60 ºC; Uso aconsejable: Fuegos A y B; Altura: (485 – 650) mm; Diámetro: (101,6 – 116) mm; Espesor nominal de pared: 2,5 mm; Espesor mínimo de pared: 2,38 mm; Volumen: (2,98 – 3,4) litros; Tara: (4,35 – 4,87) Kg; Peso total: (6,36 – 7) Kg; Grado de llenado: (0,58 - 0,67) Kg/l. \nMateriales:\nTubo de acero aleado estirado sin soldadura; Válvula: Latón, acero y caucho; Tubo sonda: Polipropileno; Vaso difusor: Poliamida y acero; Peana: Polipropileno inyectado; Etiqueta: Serigrafía o acetato adhesivo.\nColgador mural: Fabricado en acero al carbono con acabado cincado.	42.8499985	1	3		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2040	\N	Detector FSP-951(A) Nuevo	Detector de Humo Óptico Direccionable (usa la base B300-6) 	43.0099983	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2041	\N	Módulo PGM DSC PowerSeries PC5208	Módulo de 8 Salidas Programables de 12v 50 mA PowerSeries	43.3069992	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2042	\N	Módulo de Integración DSC PowerSeries IT-100	Módulo de Integración con Interfaz Bidireccional RS-m32 PowerSeries 	43.3069992	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2043	\N	Módulo de Interfaz de Impresora DSC PC5400	Módulo de Interfaz de Impresora Serial	43.3069992	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2044	\N	Detector NFXI-TDIFF	Detector direccionable termovelocimétrico con modulo aislador	43.8899994	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2045	\N	Detector NFXI-TDIFF-BK	Detector negro direccionable termovelocimétrico con modulo aislador	43.8899994	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2046	\N	Detector NFXI-TFIX58	Detector termico direccionable de temperatura fija a 58°C, con modulo aislador	43.8899994	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2047	\N	PS-1217	Batería de 12V. Capacidad 17Ah	43.9339981	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2048	\N	Módulo de interfaz de Datos DSC MAXSYS PC4401	Módulo de interfaz de Datos Capaz de funcionar como interfaz RS-m32 de 2 vías, aislador PC-Link o módulo de impresora MAXSYS	43.9669991	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2049	\N	Sensor Movimiento Doble Tecnica Honeywell DT8050A	Sensor de Movimiento montaje en pared Doble Tecnología Pir-Microonda con Antienmascaramiento, Alcance Max.16 x 22m 	44.3300018	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2050	\N	Supresor para Red de Energía Tipo 2, 1P, m30V	Supresor Modular TNS. Tipo 2, 1P (Fase) con Monitoreo a Distancia.  Un: m30 Vac. Uc: 275 Vac, In: 20 kA, Imax: 40 kA, Iimp: 12 kA.	44.3409996	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2051	\N	Módulo Monitor FZM-1(A)	Módulo Monitor de 1 Entrada Programable para Lazo de Dispositivos Convencionales a 2 Hilos	44.4620018	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2052	\N	Pulsador NBG-12LX	Pulsador Manual Direccionable Acción Doble con Llave	44.5940018	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2053	\N	Pulsador NBG-12LXSP	Pulsador Manual Direccionable Acción Doble con Llave (Idioma Español)	44.5940018	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2054	\N	Sirena con Estrobo PC2RLA Nuevo	Sirena/Estrobo (Roja) Serie L (2 hilos) Montaje en Techo Interior	44.9459991	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2055	\N	Sirena con Estrobo PC2WLA Nuevo	Sirena/Estrobo (Roja) Serie L (2 hilos) Montaje en Techo Interior	44.9459991	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2056	\N	Doblador de Tuberias Metalicas EMT 3/4"	Doblador para Tuberias Metalicas EMT 3/4¨, Diámetro Int. 20 mm, Diámetro Ext. 25 mm 	45	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2057	\N	Bobina de Desacople 35A	Bobinas de Desacople Un: m30 Vac, Uc: 275 Vac, IL: 35 A, Imax: 100 kA. 	45.4410019	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2058	\N	Cemento CPVC	Cemento One Step de CPVC-BM( 948 ml)	46.1889992	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2059	\N	Botón de Pánico Honeywell 269SN	Botón de Pánico Direccionable con Carcasa de Acero V-Plex	46.3671989	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2060	\N	Brida Fija 3" (CAMx Brida)	Brida Fija 3" (CAMx Brida),estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	46.6949997	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2061	\N	Pulsador Manual Honeywell 5140MPS-1	Pulsador Manual Convencional de Acción Simple para Lazo de Incendio	46.7719994	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2062	\N	Válvula eliminadora de aire conexión macho ½"	Válvula eliminadora de aire. Cuerpo de bronce, 150 psi.	46.8160019	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2063	\N	Barra de Comprobación	Barra de Medición o Comprobación del Sistema de Tierra para Montaje en Arqueta o Registro de Tierra	46.8709984	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2064	\N	Revestimiento DP-1B	Placa Sólida para Revestimiento para 1ra fila y filas intermedias	47.1570015	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2072	\N	Detector NFXI-OPT-BK	Detector negro direccionable fotoeléctrico de humo con modulo aislador	47.8720016	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2073	\N	Supresor para Red de Energía Tipo 2, 1P, 120V	Supresor Modular TNS. Tipo 2, 1P (Fase) con Monitoreo a Distancia.  Un: 120 Vac, Uc: 150-155 Vac, In: 20 kA, Imax: 40 kA, Iimp: 12 kA.	47.8720016	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2074	\N	Sirena con Estrobo PC4RLA Nuevo	Sirena/Estrobo (Roja) Serie L (4 hilos) Montaje en Techo Interior	48.1020012	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2075	\N	Sirena con Estrobo PC4WLA Nuevo	Sirena/Estrobo (Roja) Serie L (4 hilos) Montaje en Techo Interior	48.1020012	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2076	\N	Pulsador M5A-RP02SG-N026-01 	Pulsador Manual Direccionable por rotura de cristal con minimódulo incluido	48.1910019	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2077	\N	Pulsador M5A-RP02FF-N026-01 	Pulsador Manual Direccionable rearmable con minimódulo incluido	48.1910019	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2078	\N	Conexión de latón Tipo STORZ para manguera diámetro 2" (DN50)	Conexión para manguera Tipo STORZ: Material: Latón, Presión del trabajo: 10 bar; 13 bar, Presión de Brust: 30bar; 39bar 	48.5161591	1	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2079	\N	Módulo de Reemplazo para Supresor para Red de Energía Tipo 3, 4P, m30V	Módulo de Reemplazo Tipo 3 (3 Fase + Neutro) Un: m30 Vac, Uc: 255 Vac, IL: 25 A, In: 3 kA, Itotal: 5 kA.	48.7519989	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2080	\N	Pulsador Manual Honeywell 5140MPS-2 	Pulsador Manual Convencional de Acción Simple para Lazo de Incendio rearmable por llave Allen	48.8079987	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2081	\N	Supresor para Red de Energía Tipo 2, 1P, Neutro	Supresor Modular TNS. Tipo 2, 1P (Neutro) con Monitoreo a Distancia. Uc: 255 Vac, In: 20 kA, Imax: 40 kA, Iimp: 12 kA.	48.8950005	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2082	\N	Sirena Amseco SSX-52	Sirena para Montaje en Exterior sin Estrobo	48.9900017	1	10		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2083	\N	Set de Accesorios 	Conjunto o Set de accesorios para Soldadura Exotérmica, debe incluir: Cepillo para Limpieza de Conductores, Cepillo para Limpieza del Molde de Soldadura, Limpiador de Desechos, Pincel o Brocha de Limpieza, Guantes de Trabajo	49.0489998	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2084	\N	Revestimiento DP-DISP	Placa de Revestimiento para Montaje de CPU2-3030 y ACS en 1ra Fila 	49.0600014	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2085	\N	Módulo Relé Honeywell 4204	Módulo de 4 Relé Forma C, para Paneles de Intruso Series VISTA.	49.4449997	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2086	\N	Batería BAT-12260	Batería Sellada de 12 Volt 26 A/H	49.5550003	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2087	\N	Tarjeta Multiples Módulos Aisladores ISO-6(A)	Tarjeta de 6 Módulos Aisladores de Corto Circuito en el Lazo	49.8959999	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2088	\N	Conctacto Magnético Inalámbrico DSC WS8945W	Contacto Magnético Inalámbrico de Puerta/Ventana Blanco 868 MHz 	50.0499992	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2089	\N	Conctacto Magnético Inalámbrico de 3 zonas DSC WS4965	Contacto magnetico Inalámbrico de puerta/ventana con tres zonas 433 MHz (1 zona con contacto “reed switch y 2 entradas para contactos externos normalmente cerrados)	50.0499992	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2090	\N	Conctacto Magnético Inalámbrico DSC WS8945B	Contacto Magnético Inalámbrico de Puerta/Ventana Marrón 868 MHz 	50.0499992	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2091	\N	Mini Contacto Magnetico Inalambrico DSC WS4975	Mini Contacto Inalámbrico Extraplano para Puertas y Ventana 433 MHz Bateria de Litio	50.0499992	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2092	\N	Mini Contacto Magnetico Inalambrico DSC WS8975	Mini Contacto Inalámbrico Extraplano para Puertas y Ventana 868 MHz Bateria de Litio	50.0499992	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2093	\N	Supresor para Red de Energía Tipo 2, 1P, 300V	Supresor Modular TNS. Tipo 2, 1P (Fase) con Monitoreo a Distancia. Un 300 Vac, Uc: 320 Vac, In: 20 kA, Imax: 40 kA.	50.2700005	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2094	\N	Módulo Expansor Honeywell 4190SN	Módulo Expansor de 2 Seriales Zonas (Paneles de Intruso Vistas 50/128/250)	50.4020004	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2095	\N	Módulo Expansor Honeywell 4190U	Módulo Expansor de 2 Zonas (Paneles de Intruso Vistas 50/128/250)	50.4020004	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2096	\N	Módulo Expansor Honeywell 4208U	Módulo Expansor de 8 Zonas (Paneles de Intruso Vistas 50/128/250)	50.4020004	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2097	\N	Módulo Expansor Honeywell 4208SN	Módulo Expansor de 8 Zonas Seriales V-Plex (Paneles de Intruso Vistas 50/128/250)	50.4020004	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2098	\N	Anunciador Remoto RTS151KEY	Estación de Test Remoto para Detector FS-OSI-RIA con Bloqueo 	50.973999	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2099	\N	Anunciador Remoto RTS151KEY	Estación de Test Remoto para Detector FS-OSI-RIA con Bloqueo 	50.973999	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2100	\N	Llavero Inalambrico Honeywell 5834-4	Llavero Inalambrico Unidireccional de 4 Botones Negro	51.2159996	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2101	\N	Sensor Movimiento Solicitud de Salida Honeywell IS320BL	Sensor Movimiento Negro para Solicitud de Salida con Buzzer y control de volumen, entrada de contacto de puerta, lectora y teclado Rango desde 1.67m x 0.6m hasta 4.8 x 2.5m	51.2270012	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2102	\N	Tubería de CPVC 3" 	Tubería de CPVC 3"  , Las tuberías de CPVC BlazeMaster®  de Durman y Spears,  para los sistemas de rociadores contra incendio, están hechas de policloruro de vinilo post-clorinado (CPVC)  están completamente aprobadas para el uso en todas las aplicaciones de riesgo tipo bajo (según NFPA 101). Estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3, (20, 25, 32,  40,  50, 65,  80 mm) con  espesor  de  pared RD-13.5. Los tubos  son  comercializados  en  longitudes  de 15  pies o  4.57 mts.. La tubería de CPVC. BlazeMaster ® esta aprobada para el uso en todas las aplicaciones de bajo riessgo tipo NFPA 13 en Edificios públicos. 	51.2512016	2	17		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2103	\N	Detector SD-851E A	Detector de Humo Optico convencional	51.6669998	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2104	\N	Sensor Movimiento Honeywell DT8360CM-SN	Sensor de Movimiento de Montaje en Techo con Antienmascaramiento V-Plex	52.1069984	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2105	\N	Módulo Relé Honeywell 4204CF	Módulo de 2 salidas NAC supervizadas para aplicaciones Contra Incendios, para Paneles de Intruso Series VISTA.	52.1119995	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2106	\N	Mástil de Altura 2m	Mástil de Acero galvanizado de Diámetro: 1 1/2", Altura: 2m. para instalar en Torreta 	52.5579987	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2107	\N	Sirena con Estrobo WSS-PR-I02	Sirena direccionable blanca alimentada del lazo con aislador incorporado y estrobo rojo	52.8549995	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2108	\N	Sirena con Estrobo WST-PR-I02 	Sirena direccionable blanca de bajo perfil alimentada del lazo con aislador incorporado y estrobo rojo	52.8549995	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2109	\N	Sirena WSO-PR-I02 	Sirena direccionable de color rojo alimentada del lazo y con aislador incorporado.	52.8549995	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2110	\N	Lanza Variomatic de  2½" de tres efectos, de   latón o bronce.	Lanza Variomatic de 3 efectos (chorro, cortina y cierre) , con rosca hembra de acople y racor Tipo GOST rosca fija exterior. Material  latón, bronce.	53.1977615	1	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2223	\N	Módulo M701-240-DIN	Módulo de control de 1 salida relay NA/NC para 240 vac, led de estado y aislador incorporado para montaje en perfil DIN	81.3450012	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2111	\N	Sensor Movimiento Doble Tecnica Honeywell DT8360ACM	Sensor de Movimiento montaje en techo Doble Tecnología Pir-Microonda con Antienmascaramiento, Altura hasta 8m /radio 10m , Altura 2,4m /radio 6m	53.3720016	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2112	\N	Guardera de Acero	Guardera para Protección de Bajante 3000 mm de Acero Galvanizado.	54.0099983	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2113	\N	Adaptador Macho  2" (CAMxROS)	Adaptador Macho  2" (CAMxROS) estan  hechos con resina de Poli (cloruro de Vinilo) Clorado (CPVC), estan disponibles en las dimensiones comerciales del  acero “Iron Pipe Sizes” (IPS) en los diámetros de ¾”, 1”, 1 ½”, 1 ¼” 2”, 2 ½” y 3. ASTM F 438 (SCH 40) Y ASTM F 439 (SCH 80)	54.0209999	1	14		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2114	\N	Extintor portátil de polvo químico seco ABC 6 kg	Extintor PQS  ABC 6kg lleno, incluye colgador. Agente Extintor : Polvo ABC 55 Agente propulsor Nitrogeno, carga80 g Eficacia Mínina requerida21A-113B. Acabado: pintura al Horno 100%poliester, Ral 3000 espesor de la capa que garantyice como minimo 480 hrs de la prueba de nieblas salinas si n que aparezcan sintomas de corrosión.Caracteristicas Técnicas:Presión de diseño:25 bar,Presión de prueba:25 bar Presión maxima de servcio: 17 bar.Presión de ruptura de la botella110-190 bar;Carga 6kg±5%Temperatura de servicio:-20 a 60 ºC Uso Aconsejable: Fuegos ABC y E para tensiónes electricas menores a 35 Kv; Altura (515-528)mm;Diametro 150mm; Espesor Nominal de la pared 1,5mm;Espesor mínimo de pared 1,50 mm; Volumen:(7,70-6,72); tara:(3,20-3,30) kg , Peso total:(9,28-9,30) kg. Materiales: Botella de acero soldada:fabricada en chapa de acero laminada en frio, de bajo contenido de carbono para embutición profunda; Valvula:Latón, acero y caucho; Indicador de presión :ø 27mm:Latón cromado;Manguera:PVC,textil y PEAD;  presión de servicio de la manguera: 20 bar, presión de ruptura de la manguera:65bar,Peana: propileno;Tubo Sonda de PVC ó Polipropileno. Etiqueta Serigrafiadaó Acetato Adhesivo Colgador Mural:fabricado en acero galvanizado.	54.3400002	1	4		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2115	\N	Base de Torreta	Base de Torreta Triangular (3 Metros)	54.4169998	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2116	\N	Llavero Inalámbrico de Pánico DSC WS4938	Llavero Inalámbrico de Pánico de 1 Botón 433 MHz	54.6699982	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2117	\N	Sensor de Movimiento Inalámbrico DSC WS4904P	Detector Pasivo Infrarrojo Inalámbrico alcance 12 x12m  1 Bateria de Litio 433Mhz	55.362999	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2118	\N	Sensor de Movimiento Inalámbrico DSC WS8904	Detector Pasivo Infrarrojo Inalámbrico alcance 12 x12m  1 Bateria de Litio 868Mhz	55.362999	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2119	\N	Supresor de Sobretensiones Transitorias + Permanentes para Red de Energía. Tipo 3	Protector Tipo 3 Enchufable con Rearme Automático de 6 Salidas Protegidas contra Sobretensiones Transitorias y Permanentes. Cordón de 1,5 m. Tipo de Conexión NEMA. Un: 120Vac. 	55.5279999	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2120	\N	Simulador de Ruptura de Vidrio Honeywell FG701	Simulador de Ruptura de Vidrio para comprobacion de detectores de ruptura.	56.2099991	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2121	\N	Llavero Inalambrico Honeywell 5834-4EN	Llavero Inalambrico Unidireccional de 4 Botones Plateado	56.3310013	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2122	\N	Válvula eliminadora de aire conexión macho ¾"	Válvula eliminadora de aire. Cuerpo de bronce, 150 psi.	56.5611191	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2123	\N	Cilindro Ext Espuma 50 l 	Cilindro con revestimiento interior + accesorios, chasi y ruedas para Extintor movil Espuma 50 l                                              Caracteristicas Técnicas:Presión de diseño: Altura (1003-1050) mm; Diametro 300 mm; Espesor Nominal de la pared 2,5 mm; Volumen:52 l; Peso:(24,5-25,06) kg.                                                                                                                             Materiales: Botella y chasis: Fabricada en chapa de acero; Valvula manual:Latón, acero y caucho (incluye pasador de seguridad en maneta de accionamiento y precinto sobre pasador); Indicador de presión: ø 37mm: Latón cromado; Manguera:caucho, textil, acero y propileno; presión de servicio de la manguera: 20 bar, presión de ruptura de la manguera: 65 bar; Tubo Sonda de PVC ó Polipropileno. Etiqueta Serigrafiada ó Acetato Adhesivo. Ruedas de carro:ø300mm polipropileno y caucho sintético.                                                                                                                                                                     Pintura al horno 100 % poliéster, RAL 3000, espesor de la capa de pintura que garantice como mínimo 480 horas de la prueba de nieblas salinas sin que aparezca síntomas de corrosión exterior.	56.7799988	1	5		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2124	\N	Fuente Auxiliar Honeywell AD25624	Fuente de Alimentacion Auxiliar de 16VAC 12/24VDC 2.5A	56.9469986	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2125	\N	Control de Pared de 4 Botones DSC WS4979	Control Inalámbrico de pared de 4 Botones 433 MHz	56.9799995	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2126	\N	Llavero Inalámbrico de 2 Botones DSC WS4949	Llavero Inalámbrico de 2 Botones 433 MHz	56.9799995	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2127	\N	Caja M200SMB	Caja de montaje para módulos de la serie M700	57.2550011	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2128	\N	Módulo M721	Módulo monitor y de control direccionable con 2 entradas y 1 salida configurable supervisadas todas, led de estado y aislador incorporado	57.2550011	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2129	\N	Teclado de LED DSC PK5508	Teclado LED de 8 Zonas PowerSeries	57.3540001	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2130	\N	Detector FSP-951T(A) Nuevo	Detector de Humo Óptico combinado con Temp. Fija  57°C Direccionable (usa la base B300-6)	57.6290016	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2131	\N	Detector FSP-951R(A) Nuevo	Detector de Humo Óptico Direccionable (Test Remoto solo con DNR-DNRW) (usa la base B300-6) 	57.6290016	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2132	\N	Teclado Alfanumérico Honeywell 6160SP	Teclado Alfanumérico (Paneles Vistas 48,50,128,250	57.7719994	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2133	\N	Teclado Mensajes Fijos con Receptor Honeywell 6150RF	Teclado de Mensajes Fijos con Receptor RF Incluido (Paneles Vista 48,50,128,250)	57.7719994	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2134	\N	Teclado Alfanumerico con Receptor Honeywell 6160RF	Teclado de Alfanumerico con Receptor RF Incluido (Paneles Vista 48,50,128,250)	58.3320007	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2135	\N	Estrobo SWLA Nuevo	Estrobo (Blanco) Serie L (2 hilos) Montaje en Pared Interior	58.5200005	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2136	\N	Estrobo SCWLA Nuevo	Estrobo (Blanco) Serie L (2 hilos) Montaje en Techo Interior	58.5200005	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2137	\N	Módulo M701-240	Módulo de control de 1 salida relay NA/NC para 240 vac, led de estado y aislador incorporado	58.762001	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2138	\N	Sensor Movimiento Doble Tecnica Exterior Honeywell DT900	Sensor de Movimiento Exterior Doble Tecnología Pir-Microonda con Antienmascaramiento Amplio Rango 27 x 21m 	59.5320015	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2139	\N	Panel Alarmas Honeywell VISTA 48	Panel de Alarma Contra Intrusos 8 Zonas 3 Particiones 	60.0159988	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2140	\N	Sensor Movimiento Doble Tecnica Exterior Honeywell DT906	Sensor de Movimiento Exterior Doble Tecnología Pir-Microonda con Antienmascaramiento Rango Estrecho (Patrón de Cortina) 61 x 5m 	60.1329994	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2180	\N	Abarcón metálico M10 - 90  ϕ=3"	Abarcón metálico M10 - 90  ϕ=3" Abarcón metálico Ubolt. Acero cincado electrolítico, con 4 tuercas premontadas DIN 934 estampadas en frio y cincadas	66.170723	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2141	\N	Módulo discador de doble línea DSC MAXSYS PC4701 	Módulo con Conexión para dos líneas telefónicas supervisadas • 1 zona para detectores de humo de 2 hilos Clase B/Estilo B supervisada • 1 zona Clase B/Estilo B para detector de ﬂujo de agua •  Relés forma “C” para alarma de incendioy falla de incendio	60.1699982	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2142	\N	Módulo Salidas de Baja Corriente DSC MAXSYS PC4216	Módulo de 16 Salidas Programables de 12v 50mA MAXSYS	60.1699982	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2143	\N	Módulo Receptor Multiple DSC PowerSeries PC5320	Módulo para conexión de múltiples Receptores Inalámbricos PowerSeries	60.1699982	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2144	\N	Módulo Receptor DSC PowerSeries RF5132-433	Módulo Receptor Inalámbrico 32 Zonas y 16 Llaves PowerSeries a 433MHz	60.1699982	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2145	\N	Módulo Receptor DSC PowerSeries RF5132-868	Módulo Receptor Inalámbrico 32 Zonas y 16 Llaves PowerSeries a 868MHz	60.1699982	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2146	\N	Módulo Transceptor DSC PowerSeries TR5164-433	Módulo Transceptor Inalámbrico 32 Zonas y 2 Llaves de 2 Vías PowerSeries	60.1699982	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2147	\N	Protector STI-1m30	Protector de Superficie para Pulsador sin Bocina	60.368	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2148	\N	Protector STI-1m30	Protector de Superficie para Pulsador sin Bocina	60.368	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2149	\N	Detector de Rotura de Vidrio DSC AC-102	Detector de Ruptura de Vidrio montaje en Pared con contacto Form C (NC&NO) y Tamper	60.5219994	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2150	\N	Detector de Rotura de Vidrio DSC AC-501	Detector de Ruptura de Vidrio montaje en Techo con contacto Form A (NC) y Tamper	60.5219994	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2151	\N	Estrobo CWST-RW-S5 	Estrobo convencional de color rojo y flash trasparente	60.7529984	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2152	\N	Contacto Magnetico Inalambrico Exterior Honeywell 5816OD	Contacto Magnetico Inalambrico Para Exteriores a prueba de agua,incluye Iman y bateria	60.8300018	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2153	\N	Llavero Inalámbrico de Bidireccional DSC WT4989	Llavero Inalámbrico Bidireccional con Display de íconos y 4 Botones Programables	61.5999985	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2154	\N	Llavero Inalámbrico de 4 Botones DSC WS4939	Llavero Inalámbrico de 4 Botones 433 MHz	61.5999985	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2155	\N	Llavero Inalámbrico de 4 Botones DSC WS4969	Llavero Inalámbrico de 4 Botones con Linterna 433 MHz	61.5999985	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2156	\N	Llavero Inalámbrico de 5 Botones DSC WS4959	Llavero Inalámbrico de 5 Botones 433 MHz	61.5999985	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2157	\N	PS-1224	Batería de 12V. Capacidad 24Ah	61.7869987	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2158	\N	Estrobo CWST-RW-W5	Estrobo convencional de color rojo y flash trasparente con base alta IP65	61.7869987	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2159	\N	Detector SD-851TE A	Detector Optico-Termico convencional multicriterio.	62.007	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2160	\N	Teclado de LED DSC PK5516	Teclado LED de 16 Zonas PowerSeries	62.1279984	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2161	\N	Protector STI-3150	Protector de Superficie para Pulsador para Exteriores	62.8320007	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2162	\N	Protector STI-3150	Protector de Superficie para Pulsador para Exteriores	62.8320007	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2163	\N	Supresor para Red de Datos 2 Líneas  12V	Supresor Modular para Datos para 2 Líneas Un: 12 Vdc. Uc: 15 Vdc. IL: 0,75 A. 	62.8429985	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2164	\N	Supresor para Red de Datos 2 Líneas 24V 	Supresor Modular para Datos para 2 Líneas Un: 24 Vdc. Uc: 33 Vdc. IL: 0,75 A. 	62.8429985	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2165	\N	Teclado Alfanumérico Rojo Honeywell 6160CR-2	Teclado Alfanumérico Rojo para aplicaciones Contra Incendios (Paneles Vistas 48,50,128,250	63.1209984	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2166	\N	Detector 5622	Detector Temperatura Fija/Termovelocimétrico Convencional con Base a 4 Hilos (90 grados)	63.8330002	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2167	\N	Base B200S(A)	Base Sonora para Detectores Direccionables de la serie 851 y 951 (Volumen Bajo)	63.9210014	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2168	\N	Sensor de Movimiento c/ Ruptura de Vidrio 360 Grados DSC BV-501GB	Sensor de Movimiento combinado con Sensor de Ruptura de Vidrio de Montaje en Techo con Tamper y relay Form A (NC) (PIR con Radio de Cobertura de 4,6 a 6 m) (Ruptura de Vidrio 4,6 a 7 m)	64.0309982	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2169	\N	Sensor de Movimiento c/ Ruptura de Vidrio 360 Grados DSC BV-502GB	Sensor de Movimiento combinado con Sensor de Ruptura de Vidrio de Montaje en Techo con Tamper y Relay Forma C (NC&NO) (PIR con Radio de Cobertura de 4,6 a 6 m) (Ruptura de Vidrio 4,6 a 7 m)	64.0309982	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2170	\N	Gabinete CAB-PS1	Gabinete con Puerta para Fuente Auxiliar ACPS-610	64.1190033	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2171	\N	Kit de Montaje 6500-MMK	Kit de Accesorios de Montaje para Detector FS-OSI-RIA	64.1409988	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2172	\N	Kit de Montaje 6500-MMK Nuevo	Kit de Accesorios de Montaje para Detector FS-OSI-RIA	64.1409988	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2173	\N	Chasis CHS-6	Chasis de 6 Posiciones para Montaje de Tarjetas de Módulos Multiples	64.1740036	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2174	\N	Revestimiento ADP2-640	Placa de Revestimiento para Montaje de Chasis CHS2-M2 con CPU2-640 en Filas Intermedias	64.2399979	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2175	\N	Sensor de Impacto Inalámbrico con Contacto Magnetico           DSC EV-DW4927SS	Sensor de impacto inalámbrico con contacto para puerta/ventana integrado (Ajuste de sencibilidad y pre-alarma)	64.6800003	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2176	\N	Teclado de LED DSC RFK5508	Teclado LED de 8 Zonas PowerSeries con receptor inalámbrico incorporado PowerSeries 32 zonas	64.6800003	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2177	\N	Extintor portátil de dióxido de carbono CO2 5 kg	Extintor portátil de  CO2 5 kg lleno (CO2  5 Kg Full Extinguisher). Incluye colgador mural de acero.\nAgente extintor: Bióxido de carbono. Eficacia minima requerida:  55B.\nAcabado:  Pintura al horno 100 % poliéster, RAL 3000, espesor de la capa de pintura que garantice como minimo 480 horas de la prueba de nieblas salinas sin que aparezca síntomas de corrosión exterior.\nCaracterísticas Técnicas:\nPresión de diseño: 250 Bar; Presión de prueba: 250 Bar; Presión máxima de servicio: 174  -180 Bar;  Presión de rotura de botella: 570 Bar; Presión de tarado disco de seguridad: 190 Bar ± 10 %; Carga: 4,75 - 5 kg CO2; Temperatura de Servicio: -20 a 60 ºC; Uso aconsejable: Fuegos A y B; Altura: (745 – 760) mm; Diámetro: (136 – 140) mm; Espesor nominal de pared: 3,3 mm; Espesor mínimo de pared: 2,78 mm; Volumen: (7,46 – 8,05) litros; Tara: (8,75 – 9,59) Kg; Peso total: (13,75 – 15,22) Kg; Grado de llenado: (0,62 - 0,67) Kg/l. \nMateriales:\nTubo de acero aleado estirado sin soldadura; Válvula: Latón, acero u caucho; Tubo sonda: Polipropileno/Aluminio; Bocina  Manguera: polipropileno, caucho y acero; Peana: Polipropileno inyectado; Etiqueta: Serigrafía o acetato adhesivo.\nColgador mural: Fabricado en acero al carbono con acabado cincado.	64.7600021	1	3		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2178	\N	Barra de Tierra	Barra de Tierra de Cobre, 6 Vías con Tornillos y Tuercas M-10 para Conexión de Cable de Cobre Desnudo Calibre: 1/0 AWG y Pletina 20 mm x 3 mm.	65.2740021	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2179	\N	Revestimiento ADP-4B	Placa de Revestimiento para Montaje de Chasis CHS2-M2 con CPU2-3030 en Filas Intermedias	65.6809998	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2181	\N	Pulsador W3A-R000SG-K013-41 	Pulsador Manual Convencional para Exteriores IP67 con contacto NA o NC, Incorpora tapa protectora de plástico, cristal SUS758, y caja para montaje en superficie PS031W.	66.5940018	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2182	\N	Conexión de Aluminio Tipo GOST para manguera diámetro 2" (DN50)	Conexión para manguera Tipo GOST: Material: Aluminio, Presión del trabajo: 10bar; 13bar, Presión de Brust: 30bar; 39 bar. 	66.84832	1	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2183	\N	Conexión de latón Tipo STORZ para manguera diámetro 2½" (DN65)	Conexión para manguera Tipo STORZ: Material: Latón, Presión del trabajo: 10 bar; 13 bar, Presión de Brust: 30bar; 39bar 	67.3041611	1	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2184	\N	Sirena con estrobo CWSS-RW-S5	Sirena convencional de color rojo  y estrobo trasparente	67.3420029	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2185	\N	Conexión Rosca Fija Exterior de aluminio tipo GOST 5" (125 mm)	Conexión rosca fija exterior de aluminio tipo GOST . Rosca GAS- BSP	68.8071976	1	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2186	\N	Supresor para Lineas Telefónicas	Supresor para Líneas Telefónicas con Conector  RJ-45, Un: 130 Vdc, Uc: 220 Vdc/Vac, IL: 360 mA.	68.848999	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2187	\N	Panel VSN-4REL	Tarjeta de 4 relés NA/NC configurable	69	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2188	\N	Detector de Ruptura de Vidrio Inalambrico Honeywell 5853	Detector de Ruptura de Vidrio Inalambrico con Selección de Sensibilidad	69.0469971	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2189	\N	Sirena con estrobo CWSS-RW-W5	Sirena convencional de color rojo  y estrobo trasparente con base alta IP65	69.3330002	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2190	\N	Módulo Expansor DSC MAXSYS PC-4108A	Módulo Expansor de 8 Zonas Cableadas MAXSYS	69.6190033	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2191	\N	Sensor de Movimiento DSC AMB-600	Sensor de Movimiento de Doble Pir de Montaje en Pared con Tamper  (Alcance Máximo 12 m) 	69.6740036	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2192	\N	Sensor de Movimiento DSC BV-602	Sensor de Movimiento de Doble Pir de Montaje en Pared con Inmunidada contra Mascotas con Tamper y Relay Forma C (NC&NO) (Alcance Máximo 12 m) 	70.4000015	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2193	\N	Sensor de Inundación DSC WS4985	Sensor de Inundacion, incluye una sonda de agua (permite monitorear dos sondas) 433Mhz	70.4110031	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2194	\N	Sensor de Inundación DSC WS8985	Sensor de Inundacion, incluye una sonda de agua (permite monitorear dos sondas) 868Mhz	70.4110031	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2195	\N	Estrobo SRLA Nuevo	Estrobo (Rojo) Serie L (2 hilos) Montaje en Pared Interior	70.9940033	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2196	\N	Módulo Aislador Honeywell VSI	Módulo Aislador para Cableado de Dispositivos con Tecnología V-Plex	71.3899994	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2197	\N	Módulo Expansor DSC MAXSYS PC-4116	Módulo Expansor de 16 Zonas Cableadas MAXSYS	72.0279999	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2198	\N	Módulo Receptor DSC MAXSYS RF4164-433	Módulo Receptor Inalámbrico 64 Zonas y 16 Llaves MAXSYS	72.0279999	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2199	\N	Sensor de Movimiento 360 Grados DSC BV-502	Sensor de Movimiento de Montaje en Techo con Tamper y Relay Forma C (NC&NO) (Radio de Cobertura de 4,6 a 6 m)	72.0279999	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2200	\N	Armario de Chapa FI-63	Armario portaextintor realizado en polipropileno. El gabinete porta extintor Modelo C para extintores de CO2  y polvo, de 5Kg (CO2) y 6 y 9 Kg (polvo). Fabricado en PP  	72.3499985	1	2		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2201	\N	Kit de Montaje Honeywell SC116	Kit de Montaje en Pared para Sensor de Vibración	73.1500015	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2202	\N	Sensor de Vibración Honeywell SC-105	Sensor de Vibración Aplicación para Cajeros Automáticos Ajustado a Ambientes Ruidosos	73.1500015	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2203	\N	Sirena con Estrobo WSS-PC-I02	Sirena direccionable blanca alimentada del lazo con aislador incorporado y estrobo trasparente	74.1399994	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2204	\N	Sirena con Estrobo WST-PC-I02 	Sirena direccionable blanca de bajo perfil alimentada del lazo con aislador incorporado y estrobo trasparente 	74.1399994	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2205	\N	Arqueta o Registro	Registro de Tierra o Arqueta de Prolipopileno con Tapa 	74.4700012	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2206	\N	Tubería Flexible Metalica EMT Forrado con Goma LIQUIDTIGHT 1/2"	Tubería Flexible Metalica de Acero Electrogalvanizado o Galvanizado en Caliente Forrado con Goma LIQUIDTIGHT 1/2¨, Diámetro Int. 15 mm, Diámetro Ext. 20 mm 	75	2	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2207	\N	Detector 5621	Detector Temperatura Fija/Termovelocimétrico Convencional con Base a 4 Hilos (57 grados)	75.7789993	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2208	\N	Detector NFXI-TFIX78	Detector termico direccionable de temperatura fija a 78°C, con modulo aislador	75.7789993	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2209	\N	Detector de Humo Inalambrico Honeywell 5806W3	Detector de Humo Óptico Inalámbrico con Batería de 3 Volts Lithium	76.3000031	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2210	\N	Detector de Humo Optico-Termico Inalambrico Honeywell 5808W3	Detector de Humo Óptico-Termico 57°C Inalámbrico con Batería de 3 Volts Lithium	76.3000031	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2211	\N	Sensor de Vibración Honeywell SC-100	Sensor de Vibración para Aplicaciones Generales con Ajuste de Sensibilidad	76.3000031	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2212	\N	Detector de Temperatura Fija y Termovelocimetrico Inalambrico Honeywell 5809SS	Detector Termovelocimetrico y Temperatura Fija 57°C Inalámbrico con Batería de 3 Volts Lithium	76.637001	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2213	\N	Panel de Alarmas DSC MAXSYS PC-4020	Panel de Alarma 16 Zonas Cableadas DSC (Expande 128 Zonas, 8 Particiones) MAXSYS Series	76.9800034	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2214	\N	Panel de Alarmas DSC MAXSYS PC-4020CF	Panel de Alarma para aplicaciones Contra Incendios 16 Zonas Cableadas DSC (Expande 128 Zonas, 8 Particiones) MAXSYS Series (Incluye Gabinete Rojo PC4050CR, un Módulo discador de doble linea PC4701 con • 1 zona para detectores de humo de 2 hilos Clase B/Estilo B supervisada •  1 zona Clase B/Estilo B para detector de ﬂujo de agua •  Relés forma “C” para alarma-falla de incendio y un transformador 16VCA, 40 VA	76.9800034	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2215	\N	Barrera Perimetral OPTEX AX-70TN	Barrera Perimetral Alcance 20 m, Protección al Ambiente IP-55	78.5999985	1	10		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2216	\N	Chasis CHS-4N	Chasis de 4 Posiciones para Montaje de Tarjetas de Red, Gateways, Web, Interface,etc.	79.189003	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2217	\N	Chasis CHS-4N	Chasis de 4 Posiciones para Montaje de Tarjetas de Red, Gateways, Web, Interface,etc.	79.189003	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2218	\N	Chasis CHS-4N	Chasis de 4 Posiciones para Montaje de Tarjetas de Red, Gateways, Web, Interface,etc.	79.189003	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2219	\N	Sirena Amseco SSX-52SR	Sirena para Montaje en Exterior con Estrobo de Color Rojo 	79.4899979	1	10		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2220	\N	Módulo Monitor Dual FDM-1(A)	Módulo Monitor  Dual de 2 Entradas Programables para 2 Lazos de Dispositivos Convencionales a 2 Hilos	79.7939987	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2221	\N	Chasis CHS-BH1	Chasis para Montaje de 2 Baterías de hasta 12 Volt 12 A/H una Encima de la Otra	80.5530014	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2222	\N	Módulo Extensor Honeywell 4297	Módulo Extensor de Polling Loop V-Plex	80.9380035	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2268	\N	Molde Lineal	Molde Lineal Cable-Cable 1/0 AWG (50 mm2)	90.1999969	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2224	\N	Módulo Alimentación DSC PowerSeries PC5200	Módulo de Fuente de Alimentación 1 salida 12v 1A PowerSeries	81.9280014	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2225	\N	Detector FSP-851T(A)	Detector de Humo Óptico combinado con Temp. Fija  57°C Direccionable (usa la base B210LP) 	82.2910004	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2226	\N	Módulo M700XE	Módulo aislador	82.6760025	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2227	\N	Teclado de LED DSC RFK5516	Teclado LED de 16 Zonas PowerSeries con receptor inalámbrico incorporado PowerSeries 32 zonas	83.1600037	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2228	\N	Bobina de Desacople 63A	Bobinas de Desacople Un: m30 Vac, Uc: 275 Vac, IL: 63 A, Imax: 100 kA. 	83.1930008	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2229	\N	Detector de Temperatura Fija Inalambrico Honeywell 5809FXT	Detector de Temperatura Fija 57°C Inalámbrico con Batería de 3 Volts Lithium	83.3470001	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2230	\N	Contacto Magnetico Inalambrico Honeywell 5870API	Contacto Magnetico Inalambrico Para Bienes Interiores (Museos, Cuadros Plasmas)	83.9300003	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2231	\N	Detector de CO2 Inalambrico DSC WS4913	Detector de CO2 Inalámbrico con Batería de 3 Volts Lithium 433Mhz	83.9300003	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2232	\N	Detector de CO2 Inalambrico DSC WS8913	Detector de CO2 Inalámbrico con Batería de 3 Volts Lithium 868Mhz	83.9300003	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2233	\N	Detector de Humo Inalambrico DSC WS4936	Detector de Humo Óptico Inalámbrico con 3 Baterías AAA	83.9300003	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2234	\N	Detector de Humo y Temperatura Inalambrico DSC WS4916	Detector de Humo Óptico-Termico Inalámbrico con 3 Baterías AAA	83.9300003	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2235	\N	Detector Temperatura Honeywell 5193SDT	Detector Direccionable Combinado de Humo Óptico y Temperatura Fija 57 grados celsius (Vplex)	83.9300003	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2236	\N	Punta Franklin Simple	Punta captadora Simple, de Acero Inoxidable, tipo Franklin, Rosca Macho M10, Diámetro: 10 mm, Altura: 500 mm.	83.9300003	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2237	\N	Conexión de Aluminio Tipo GOST para manguera diámetro 2½" (DN65)	Conexión para manguera Tipo GOST: Material: Aluminio, Presión del trabajo: 10bar; 13bar, Presión de Brust: 30bar; 39 bar. 	84.1209564	1	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2238	\N	Módulo Expansor Honeywell 4209U	Módulo Expansor de Grupos de 4 Zonas Seriales de Incendios V-Plex (Paneles de Intruso Vistas 50/128/250)	84.2929993	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2239	\N	Receptor Inalámbrico Honeywell 5881ENM	Módulo Receptor Inalambrico 16 Zonas (Funcionamiento Unidireccional)	84.5130005	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2240	\N	Supresor para Red de Energía Tipo 2, 2P, m30V	Supresor Modular TNS. Tipo 2, 2P (Fase + Neutro) con Monitoreo a Distancia.  Un: m30 Vac. Uc: 275 Vac, In: 20 kA, Imax: 40 kA, Iimp: 12 kA.	84.5459976	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2241	\N	Módulo de doble salida de sirena DSC MAXSYS PC4702BP 	 Admite hasta 4 módulos • Provee 2 circuitos de notifcación de alarma con corriente nominal de 1.8 amps a 24 VCD cada uno • Salidas completamente supervisadas para las fallas de apertura, de cortocircuito y de conexión a tierra • Protección PTC • Incluye: gabinete PC4052CR color rojo, transformador de 28 VCA/175 VA	85.4150009	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2242	\N	Módulo de Control de Acceso DSC MAXSYS PC4820	Módulo de Control de Acceso de 2 Lectoras MAXSYS	85.4150009	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2243	\N	Módulo Alimentación DSC MAXSYS PC4204CX	Módulo de Fuente de Alimentación/ 4 Salidas de relé/Repetidor Combus MAXSYS	85.4150009	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2244	\N	Módulo Alimentación DSC MAXSYS PC4204	Módulo de Fuente de Alimentación/Repetidor Combus MAXSYS	85.4150009	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2245	\N	Módulo Repetidor Honeywell 5800RP	Módulo Repetidor de Señal de Radio Frecuencia (Compatible con receptores serie 5800)	85.9100037	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2246	\N	Pinza General	Pinza General para Soldaduras con Multiples Moldes con cable 50mm2	85.9209976	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2247	\N	Panel de Alarmas PC-1616	Panel de Alarma contra Intrusos 6 Zonas DSC (Expande Hasta 16 Zonas)	86.4100037	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2248	\N	Panel de Alarmas PC-1832	Panel de Alarma contra Intrusos 8 Zonas DSC (Expande Hasta 32 Zonas)	86.4100037	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2249	\N	Supresor para Red de Energía Tipo 3, 2P, 120V	Supresor Modular. Tipo 3, 2P (Fase + Neutro) con Monitoreo a Distancia. Un: 120 Vac, Uc: 150 Vac, IL: 25 A, In: 2 kA, Itotal: 4 kA.	86.6689987	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2250	\N	Supresor para Red de Energía Tipo 3, 2P, m30V	Supresor Modular. Tipo 3, 2P (Fase + Neutro) con Monitoreo a Distancia. Un: m30 Vac, Uc: 255 Vac, IL: 25 A, In: 3 kA, Itotal: 5 kA.	86.6689987	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2251	\N	Detector Humo Optico DSC FSA-210	Detectores de Humo Fotoeléctrico a 2 hilos	87.0540009	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2252	\N	Detector Humo Optico Direccionable DSC FSB-210B	Detectores de Humo Fotoeléctrico direccionable	87.0540009	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2253	\N	Detector Humo Optico-Termico DSC FSA-210T	Detectores de Humo Fotoeléctrico-Termico con sensor de temperatura fija y termovelocimetrico a 2 hilos	87.0540009	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2254	\N	Detector Humo Optico-Termico DSC FSA-210ST	Detectores de Humo Fotoeléctrico-Termico con sensor de temperatura fija y termovelocimetrico a 2 hilos con buzzer incorporado	87.0540009	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2255	\N	Detector Humo Optico-Termico DSC FSA-210RT	Detectores de Humo Fotoeléctrico-Termico con sensor de temperatura fija y termovelocimetrico a 2 hilos con relay auxiliar	87.0540009	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2256	\N	Detector Humo Optico-Termico Direccionable DSC FSB-210BT	Detectores de Humo Fotoeléctrico-Termico con sensor de temperatura fija y termovelocimetrico direccionable	87.0540009	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2257	\N	Supresor para Red de Datos. Cat 6. PoE 	Supresor Individual para Redes Informáticas Categoría 6, RJ-45 PoE Un: 48 Vdc, In: 150A	87.0650024	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2258	\N	Supresor para Red de Datos. Cat 6 PoE, Con Latiguillos UTP	Supresor Individual para Redes Informáticas, con Latiguillos Categoría 6, con Conector RJ-45 PoE Un: 48 Vdc, In: 150A	87.0650024	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2259	\N	Detector de Ruptura de Vidrio Honeywell FG1625RFM	Detector de Ruptura de Vidrio para Empotrar con Selección de Sensibilidad	87.1640015	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2260	\N	Sensor de Movimiento OPTEX LX-402	Sensor de Movimiento Exterior Inmune a macotas, Ajuste de sensibilidad dia/noche Antienmascaramiento Rango 12 x 15m, Arco de cubrimiento 120°	87.4000015	1	10		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2261	\N	Chasis CHS-M3	Chasis para Montaje de CPU y Anunciadores en Fila 1 de CPU2-3030	87.5820007	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2262	\N	Barrera Perimetral OPTEX AX-130TN	Barrera Perimetral Alcance 40 m, Protección al Ambiente IP-55	87.8700027	1	10		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2263	\N	Panel VSN-m32	Tarjeta de comunicaciones RSm32 con puerto aislado para conexión directa a TG vía RSm32, NO necesaría vía IP	88	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2264	\N	Revestimiento DP-DISP2	Placa de Revestimiento para Montaje de CPU2-640 en 1ra Fila 	88.7480011	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2265	\N	Módulo NFXI-MM1M	Mini módulo monitor direccionable con 1 entrada supervisada	89.5619965	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2266	\N	Molde en T	Molde en T Horizontal Cable-Cable 1/0 AWG (50 mm2)	90.1999969	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2267	\N	Molde en X	Molde en X Cable-Cable 1/0 AWG (50 mm2)	90.1999969	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2269	\N	Módulo Alimentación DSC PowerSeries PC5204	Módulo de Fuente de Alimentación 4 salidas 12v 1A PowerSeries	90.3649979	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2270	\N	Anclaje Tipo U	Anclaje tipo "U" (atornillable) para adosar mástiles de Diámetro: 1 1/2" a muro (juego de 3 soportes).	90.75	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2271	\N	Detector de impacto Inalámbrico Honeywell 5800-SS1	Sensor de impacto Inalambrico	91.3000031	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2272	\N	Módulo Interfaz Serie Honeywell 4100	Módulo de Interfaz Serie para Impresora y para Programacion Directa PC (Paneles de Intruso Vistas 50/128/250)	91.6299973	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2273	\N	Válvula de retención extremos ranurados.   3"	Válvula de retención extremos ranurados. Material de Hierro dúctil, con ranuras. Acabado pintura roja  aprobaciones FM y  certificados UL para el uso en sistemas automáticos de sprinklers.	91.820961	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2274	\N	Válvula de MariposC9:D47isada) 3"	Válvula de mariposa con extremos ranurados, equipada con volante e interruptor de control y cableado para su monitoreo remoto. Material de Hierro dúctil, acabado pintura roja,  aprobados FM y  certificados UL para el uso en sistemas automáticos de sprinklers. 	91.9441605	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2275	\N	Detector de Solicitud de Salida DSC T-REX	Detector de solicitud de salida infrarrojo pasivo con tecnología X-Y targeting™\npatentada y DSP (Procesamiento de señales digitales)	92.4000015	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2276	\N	Válvula de Bola de 1"	Válvula de bola de Latón HEMBRA / HEMBRA,presión Max.: 25 BAR. Rosca NPT	92.4000015	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2277	\N	Torre para Barrera OPTEX AX-TWEB	Base para Montaje de Torre sobre Piso 	92.6999969	1	10		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2278	\N	Supresor para Red de Datos. Cat 5. 5Vdc	Supresor Individual para Redes Informáticas Categoría. 5, con Conector RJ-45, Un: 5 Vdc, Uc: 7.5 Vdc, In: 200 A	92.7959976	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2279	\N	Detector de Ruptura de Vidrio Direccionable DSC AMA-100	Detector de Ruptura de Vidrio con Direccionable con Tamper	93.4670029	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2280	\N	Detector de Ruptura de Vidrio Honeywell FG-1625SN	Detector de Ruptura de Vidrio con Selección de Sensibilidad V-Plex	93.4670029	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2281	\N	Supresor para Plantas de Radio BNC	Supresor con Conector BNC para Plantas de Radio. Uc: 180 Vdc, IL: 3.5 A. 	93.8960037	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2282	\N	Supresor para Red de Energía Tipo 2, 2P, 120V	Supresor Modular TNS. Tipo 2, 2P (3 Fase + Neutro) con Monitoreo a Distancia.  Un: 120 Vac, Uc: 155 Vac, In: 20 kA, Imax: 40 kA, Iimp: 12 kA.	93.961998	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2283	\N	Abarcón metálico M10 - 115  ϕ=4"	Abarcón metálico M10 - 115  ϕ=4" Abarcón metálico Ubolt. Acero cincado electrolítico, con 4 tuercas premontadas DIN 934 estampadas en frio y cincadas	94.5436783	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2284	\N	Doblador de Tuberias Metalicas EMT 1"	Doblador para Tuberias Metalicas EMT 1¨, Diámetro Int. 25 mm, Diámetro Ext. 32 mm 	96	1	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2285	\N	Sensor Movimiento Doble Tecnica para Exteriores DSC LC-151	Sensor de movimiento de doble tecnología sensor PIR y microondas con inmunidad a mascotas regulable contacto para Exteriores Form C (NC&NO) (Alcance Max.15m) 	96.2279968	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2286	\N	Detector Humo Honeywell 5193SD	Detector Direccionable de Humo Óptico V-Plex	97.4160004	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2287	\N	Sensor de Movimiento OPTEX LX-802N	Sensor de Movimiento Exterior Inmune a macotas, Ajuste de sensibilidad dia/noche Antienmascaramiento Rango 24 x 2m, lente de cortina 	98.3099976	1	10		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2288	\N	Teclado LCD Alfanumérico DSC MAXSYS LCD4501	Teclado LCD Alfanumérico de 64 Zonas MAXSYS	99.3519974	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2289	\N	Teclado LCD Alfanumérico Rojo DSC MAXSYS LCD4521	Teclado LCD Alfanumérico Rojo de 64 Zonas MAXSYS para aplicaciones Contra Incendios (incluye tecla para restablecer zonas de incendios)	99.3519974	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2290	\N	Tubería Flexible Metalica EMT Forrado con Goma LIQUIDTIGHT 3/4"	Tubería Flexible Metalica Acero Electrogalvanizado o Galvanizado en Caliente Forrado con Goma LIQUIDTIGHT 3/4¨, Diámetro Int. 20 mm, Diámetro Ext. 25 mm 	100	2	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2291	\N	Gabinete SBB-A4	Gabinete de 1 Nivel con compartimiento de Baterías (Color negro)	100.716003	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2292	\N	Gabienete SBB-A4R	Gabinete de 1 Nivel con compartimiento de Baterías (Color rojo)	100.716003	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2293	\N	Supresor para Red de Datos. Cat 5e. 5Vdc	Supresor Individual para Redes Informáticas Categoría. 5e, con Conector RJ-45, Un: 5 Vdc, Uc: 7.5 Vdc, In: 200 A	101.497002	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2294	\N	Gabinete ABS-1B	Gabinete para el Montaje de 1 Anunciadores ACS, SCS y LCD2-80	102.101997	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2295	\N	Gabinete ABS-2B	Gabinete para el Montaje de 2 Anunciadores ACS, SCS y LCD2-80	102.101997	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2296	\N	Gabinete USB-1B	Gabinete para Montaje de Tarjeta SLC-IM (Negro)	102.112999	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2297	\N	Gabinete USB-1R	Gabinete para Montaje de Tarjeta SLC-IM (Rojo)	102.112999	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2298	\N	Módulo M701E	Módulo de control de 1 salida configurable supervisada con resistencia de final de línea, led de estado y aislador incorporado	102.849998	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2299	\N	Detector NFXI-SMT3	Detector direccionable multicriterio óptico-termovelocimétrico-IR con modulo aislador	103.345001	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2300	\N	Detector NFXI-SMT2	Detector direccionable óptico-termovelocimétrico con modulo aislador.	103.345001	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2301	\N	Detector NFXI-SMT2-BK	Detector negro direccionable óptico-termovelocimétrico con modulo aislador.	103.345001	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2302	\N	Conector MNS-CABLE	Conector RS-485 para cable de MNS-CONTROL (para MegaDot)	106.194	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2303	\N	Detector de Rotura de Vidrio Inalámbrico DSC WLS912L-433	Detector de Rotura de Vidrio Inalámbrico 2 baterías de litio	106.997002	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2304	\N	Módulo de Control de Acceso Honeywell VISTAKEY 	Módulo de Control de Acceso de una Puerta (Paneles de Intruso Vistas 50/128/250)	107.029999	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2305	\N	Teclado Alfanumérico Honeywell  6164SP	Teclado Alfanumérico Expande 4 zonas y incluye 1 relay (Paneles Vista 48,50,128,250)	107.029999	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2306	\N	Teclado LCD Alfanumérico DSC PK5500	Teclado LCD Alfanumérico de 64 Zonas PowerSeries	107.392998	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2307	\N	Punta Franklin Tripolar	Punta Franklin Multiple de Acero Inoxidable (Multipunta) para mástil de Diámetro: 1 1/2".	107.987	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2308	\N	Teclado LCD Alfanumérico con Receptor DSC RFK5500	Teclado LCD Alfanumérico de 64 Zonas con receptor inalámbrico incorporado PowerSeries 32 zonas	108.119003	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2309	\N	Teclado LCD Alfanumérico con Receptor DSC RFK5564	Teclado LCD Alfanumérico de 64 Zonas con receptor inalámbrico incorporado PowerSeries 64 zonas	108.778999	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2310	\N	Teclado Inalambrico Honeywell 5828	Teclado Inlambrico Mensajes Fijos (Vista 48 y 50 necesita modulo 5883H)	110.220001	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2311	\N	Caja para Conducto D2E	Caja para detector convencional de conducto (Requiere tubo de aspiración, base B401 y detector óptico SD-851E)	111.694	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2312	\N	Soporte 6500-MMK	Soporte Multiple para instalación de detectores de humo lineales	111.694	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2313	\N	Soporte 6500-MMK	Soporte Multiple para instalación para detectores de humo lineales	111.694	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2314	\N	Supresor para Red de Energía Tipo 1, 1P, 400V	Supresor Modular Tipo 1, 1P (Fase) Un: 400 Vac, Uc: 460 Vac, Iimp: 30 kA	111.859001	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2315	\N	Supresor para Red de Datos 4 Líneas 12V 	Supresor Modular para Datos para 4 Líneas Un: 12 Vdc. Uc: 15 Vdc. IL: 0,75 A. 	113.783997	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2316	\N	Carcasa para Detector de Ducto DNR(A)	Carcasa para Detector de Ducto, con Montaje para: FSP-851(A)-FSP-851R(A)	114.400002	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2317	\N	Molde Cable-Superficie Horizontal	Molde Cable-Superficie Horizontal 1/0 AWG (50 mm2)	114.400002	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2318	\N	Molde Cable-Superficie Vertical	Molde Cable-Superficie Vertical 1/0 AWG (50 mm2)	114.400002	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2319	\N	Molde Cable-Pica	Molde Vertical Cable-Pica 1/0 AWG (50 mm2)-Ø 16 mm	114.400002	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2320	\N	Teclado Alfanumérico Honeywell  6460W	Teclado Alfanumérico Blanco (Paneles Vista 128BPT y Vista 250BPT)	114.730003	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2321	\N	Teclado Alfanumérico Honeywell 6460S	Teclado Alfanumérico Plateado (Paneles Vista 128BPT y Vista 250BPT)	114.730003	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2322	\N	Supresor de Sobretensiones Transitorias + Permanentes para Red de Energía. Tipo 2. 2P. m30V. 20A	Módulo Protector Tipo 2, 2P (Fase+Neutro) Contra Sobre-Tensiones Transitorias y Permanentes con Contactor y Elemento de Corte con Rearme Automático. Un: m30V, Uc: 400V, Ua: 275V. In: 20A. (In: 5kA. Imax. 15kA onda 8/20µs)	116.286766	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2323	\N	Supresor de Sobretensiones Transitorias + Permanentes para Red de Energía. Tipo 2. 2P. 120V. 	Módulo Protector Tipo 2, 2P (Fase+Neutro) Contra Sobre-Tensiones Transitorias y Permanentes con Contactor y Elemento de Corte con Rearme Automático. Un: 120V, Uc: 208V, Ua: 144V. (In: 5kA. Imax. 15kA onda 8/20µs)	116.292	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2324	\N	Módulo Monitor FMM-4-20	Módulo Monitor para Dispositivos con Entrada Protocolo Líneal  de 4-20 mA (Sólo con NFS2-3030)	117.040001	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2325	\N	Accesorio de Montaje, Multiple Supresores	Accesorio de Montaje en Rack para Multiples Supresores de Redes Informáticas	117.348	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2326	\N	Extintor móvil de dióxido de carbono CO2 10 kg	Extintor portátil de  CO2 10 kg lleno (CO2  10 Kg Full Extinguisher).\nAgente extintor: Bióxido de carbono Eficacia: No necesaria\nAcabado: Pintura al horno 100 % poliéster, RAL 3000, espesor de la capa de pintura que garantice 500 horas de la prueba de nieblas salinas sin que aparezca síntomas de corrosión. \nCaracterísticas Técnicas:\nPresión de diseño: 250 Bar; Presión de prueba: 250 Bar; Presión máxima de servicio: 174  -180 Bar;  Presión de rotura de botella: 510 Bar; Presión de tarado disco de seguridad: 190 Bar ± 10 %; Carga: 9,5 - 10 kg CO2; Temperatura de Servicio: -20 a 60 ºC; Uso aconsejable: Fuegos A y B; Altura: (963 – 1293) mm; Diámetro: (139,7 – 154) mm; Espesor nominal de pared: 3,3 mm; Espesor mínimo de pared: 3,14 mm; Volumen: (14,3 – 14,93) litros; Tara: 13,70 – 15,9) Kg; Peso total: (m3,70 – 26,77) Kg; Grado de llenado: (0,67 - 0,69) Kg/l. \nMateriales:\nTubo de acero aleado estirado sin soldadura; Válvula: Latón, acero u caucho; Tubo sonda: Polipropileno/Aluminio; Bocina  Manguera: polipropileno, caucho  textil y acero; Peana: Polipropileno ninyectado; Etiqueta: Serigrafía o acetato adhesivo.	117.410004	1	3		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2327	\N	Caja para Conducto DNRE	Caja para detector direccionable de conducto (Requiere tubo de aspiración y detector óptico NFXI-OPT)	118.073997	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2328	\N	Gabinete SBB-B4	Gabinete de 2 Niveles con compartimiento de Baterías (Color negro)	118.700996	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2329	\N	Gabinete SBB-B4R	Gabinete de 2 Niveles con compartimiento de Baterías (Color rojo)	118.700996	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2330	\N	Extintor móvil de polvo químico seco ABC lleno 25 kg	Extintor PQS  ABC  25 kg lleno, incluye colgador. Agente Extintor : Polvo ABC 55 Agente propulsor Nitrogeno seco. Acabado: pintura al Horno 100%poliester, Ral 3000 espesor de la capa que garantyice como minimo 480 hrs de la prueba de nieblas salinas si n que aparezcan sintomas de corrosión.Caracteristicas Técnicas:Presión de diseño:25 bar,Presión de prueba:25 bar Presión maxima de servcio: 17 bar;Carga 25kg±5%Temperatura de servicio:-20 a 60 ºC Uso Aconsejable: Fuegos ABC y E para tensiónes electricas menores a 35 Kv; Altura (915-978)mm;Diametro 250mm; Espesor Nominal de la pared 2,5mm;Espesor mínimo de pared 2,50 mm; Volumen:29l; tara:(19-20,77) kg , Peso total:(44,28-46,03) kg. Materiales: Botellay chasis:fabricada en chapa de acero; Valvula manual:Latón, acero y caucho(incluye pasadorde seguridad en maneta de accionamiento y precinto sobre pasador; Indicador de presión :ø 27mm:Latón cromado;Manguera:caucho,textil,acero y propileno;  presión de servicio de la manguera: 20 bar, presión de ruptura de la manguera:65bar;Tubo Sonda de PVC ó Polipropileno. Etiqueta Serigrafiadaó Acetato Adhesivo Colgador.Ruedas de carro:ø300mm polipropileno y caucho sintético .	118.800003	1	4		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2331	\N	Supresor para Plantas de Radio N	Supresor Conector N para Plantas de Radio. Uc: 180 Vdc, IL: 6 A. 	120.065002	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2332	\N	Accesorio AM-82-TOP Nuevo	Bastidor “Easy-Fit” para montaje de panel AM-8200	120.823997	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2333	\N	PS-1m38	Batería de 12V. Capacidad 38Ah	120.823997	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2334	\N	Detector FSC-851(A)	Detector Multicriterio Intelliquad, Humo, CO2, Temperatura y Llamas. (usa la base B210LP) 	121.968002	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2335	\N	Detector de CO2 Inalambrico Honeywell 5800CO	Detector de CO2 Inalámbrico con Batería de 3 Volts Lithium	122.43	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2336	\N	Modulo Repetidor Inalambrico DSC WS4920	Módulo Repetidor Inalambrico compatible con Powerseries y Maxsys Extiende enormemente el rango de los dispositivos inalámbricos de una vía de DSC	122.43	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2337	\N	Teclado LCD Iconos Fijos DSC PK5501	Teclado LCD Fijo con íconos de 64 Zonas PowerSeries	122.584	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2338	\N	Abarcón metálico M10 - 160  ϕ=6"	Abarcón metálico M10 - 160  ϕ=6" Abarcón metálico Ubolt. Acero cincado electrolítico, con 4 tuercas premontadas DIN 934 estampadas en frio y cincadas	13.5819197	1	16		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2339	\N	Pinza para Molde Cable-Superficie	Pinza para Soldadura con Molde Cable-Superficie Vertical	124.640999	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2340	\N	Pulsador W5A-RP02SG-N026-01 	Pulsador Manual Direccionable para Exteriores IP67 con minimódulo Incorpora tapa protectora de plástico, cristal SUS758, y caja para montaje en superficie PS031W.	125.763	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2341	\N	Mástil de Altura 6m	Mástil de Acero galvanizado de Diámetro: 1 1/2", Altura: 6m. Conformado por dos (2) tramos o secciones de 3m cada uno. (Incluye pasadores para union de tramos o secciones)	126.059998	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2561	\N	Fuente AMPS-24E	Fuente de Alimentación Direccionable para Panel Anunciador NCA-2 (220 Volt)	636.757019	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2342	\N	Detector FPTI-951(A) Nuevo	Detector Multicriterio Inteligente Optico/Termico/Infrarojo con Ajuste Automatico de Sensibilidad con el Ambiente (usa la base B300-6) 	128.669998	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2343	\N	Sistema de Puesta a Tierra	Sistema de Puesta a Tierra para Carro Cisterna de Combustible. Debe incluir: 2 Pinzas de Puesta a Tierra de Acero Inoxidable + Cable retráctil de longitud 3m. 	128.677994	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2344	\N	Via Chispas para Antena	VÍa de Chispas para Mástil de Antena, Ip (10/350) > 100 kA, In (8/20) = 50 kA, Up < 4 kA	128.677994	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2345	\N	Supresor para Red de Energía Tipo 3, 4P, 120V	Supresor Modular. Tipo 3, 4P (3 Fase + Neutro) con Monitoreo a Distancia. Un: 120 Vac, Uc: 150 Vac, IL: 25 A, In: 3 kA, Itotal: 5 kA.	129.029999	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2346	\N	Puerta DR-A4B	Puerta Sólida para Gabinete 1 Nivel con compartimiento de Baterías (Color negro)	129.360001	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2347	\N	Puerta DR-A4BR	Puerta Sólida para Gabinete 1 Nivel con compartimiento de Baterías (Color rojo)	129.360001	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2348	\N	Modulo Inalambrico conversor a Zonas Cableadas Honeywell 5800C2W	Modulo Inalambrico Coversor a 9 zonas Cableadas con Alimentacion 12VDC (Compatible con receptores serie 5800)	129.667999	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2349	\N	Módulo M720E	Módulo monitor direccionable con 2 entradas supervisadas, led de estado y aislador incorporado	130.899994	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2350	\N	Laser Alineación OSP-002	Puntero Laser para alineación de Detector FS-OSI-RIA	131.065002	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2351	\N	Laser Alineación OSP-002 Nuevo	Puntero Laser para alineación de Detector FS-OSI-RIA	131.065002	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2352	\N	Teclado LCD Iconos Fijos con Receptor DSC RFK5501	Teclado LCD Fijo con íconos de 64 Zonas con receptor inalámbrico incorporado PowerSeries 32 zonas	131.373001	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2353	\N	Supresor de Sobretensiones Transitorias + Permanentes para Red de Energía. Tipo 2. 2P. m30V. 63A	Módulo Protector Tipo 2, 2P (Fase+Neutro) Contra Sobre-Tensiones Transitorias y Permanentes con Contactor y Elemento de Corte con Rearme Automático. Un: m30V, Uc: 400V, Ua: 275V. In: 63A. (In: 5kA. Imax. 15kA onda 8/20µs)	131.408554	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2354	\N	Supresor para Red de Datos. Cat 6. 5Vdc 	Supresor Individual para Redes Informáticas Categoría. 6, con Conector RJ-45, Un: 5 Vdc, Uc: 7.5 Vdc, In: 200 A	131.559998	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2355	\N	Módulo de Reemplazo para Supresor para Red de Energía Tipo 1, 120V	Módulo de Reemplazo Tipo 1 (Fase) Un: 120 Vac, Uc: 150 Vac, Iimp: 35-30 kA	132.164993	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2356	\N	Módulo de Reemplazo para Supresor para Red de Energía Tipo 1, 400V	Módulo de Reemplazo Tipo 1 (Fase) Un: 400 Vac, Uc: 460 Vac, Iimp: 30 kA	132.164993	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2357	\N	Sensor de Movimiento Inalámbrico DSC WLS914-433	Detector Pasivo Doble Infrarrojo Inalámbrico Inmune a Mascotas 4 Baterias AA 433Mhz	132.296997	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2358	\N	Kit de Espejos 6500-LRK	Kit de Reflectores de largo alcance para detectores de humo lineales	132.835999	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2359	\N	Kit de Espejos 6500-LRK	Kit de Reflectores de largo alcance para detectores de humo lineales	132.835999	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2360	\N	Tarjeta Multiples Módulos de Control XP6-C(A)	Tarjeta de 6 Módulos de Control Direccionables, 6 Salidas Programables de 24 Vdc	133.386002	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2361	\N	Tarjeta Multiples Módulos Monitores XP6-M(A)	Tarjeta de 6 Módulos Monitores, 6 Entradas Programables de Contactos Secos  	133.386002	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2362	\N	Anclaje de Mástil a Torreta	Anclaje de Mástil a Torreta (Juego de 3 Piezas), Acero Galvanizado 	134.287994	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2363	\N	Válvula de retención extremos ranurados.   4"	Válvula de retención extremos ranurados. Material de Hierro dúctil, con ranuras. Acabado pintura roja  aprobaciones FM y  certificados UL para el uso en sistemas automáticos de sprinklers.	134.33728	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2364	\N	Via Chispas	Vía Chispas para Unión de Tomas de Tierra Física	135.278	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2365	\N	Modulo Aislador de Incendio DSC AML-770B	Modulo Aislador de lazo ( aisla en el mismo lazo los sensores de Incendios de los de intruso)	135.475998	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2366	\N	Modulo Aislador y Repetidor de lazo DSC AMX-400	Modulo Aislador y Repetidor de lazo direccionable (aisla el lazo en caso de cortos circuitos)	135.475998	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2367	\N	Receptor Inalámbrico Honeywell 5881ENHC 	Módulo Receptor Inalambrico Comercial Zonas Ilimitadas (Funcionamiento Unidireccional util para Incendios)	135.475998	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2368	\N	Modulo Receptor inalámbrico de 2 canales DSC RXL2-433	Receptor inalámbrico de 2 canales soporta hasta 6 botones inalámbricos por salida y 2 salidas de relé forma ‘C’ integradas programables	135.475998	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2369	\N	Detector FCO-851(A) 	Detector Multicriterio Intelliquad Plus, Humo, CO2, Temperatura y Llamas.(Flash Scan Solamente) (usa la base Sonora B200S) 	136.419998	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2370	\N	Supresor para Red de Datos. Cat 6. PoE+ y PoE++/4PoE IP66	Supresor Individual para Redes Informáticas en Exteriores Categoría 6, RJ-45 PoE+ y PoE++/4PoE IP66 (se usa en aplicaciones de CCTV)	136.785004	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2371	\N	Kit de Control de Acceso Honeywell VISTAKEY-SK 	Kit que incluye:                                                                                                                                                 • 1 Módulo VISTAKEY                                                                                                                                     • 1 Gabinete (UL listed)                                                                                                                                  • 1 Transformador                                                                                                                                           • 1 Lector de Proximidad OP30-FWM                                                                                                         • 25 Tarjetas de Proximidad PTPROX25 ,                                                                                                   • 1 Fuente Auxiliar SA12040 ,                                                                                                                        • 2 Placas de Montaje para módulo VISTAKEY (Paneles de Intruso Vistas 50/128/250)	137.830002	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2372	\N	Gabinete ABS-2D	Gabinete para Montaje de Anunciador NCA-2 (Negro)	137.983994	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2373	\N	Gabinete ABS-2DR	Gabinete para Montaje de Anunciador NCA-2 (Rojo)	137.983994	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2374	\N	Simulador DSC AFT-100	Simulador de Ruptura de Vidrio, para Sensores de Ruptura de Vidrio DSC	138.897003	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2375	\N	Módulo de Reemplazo para Supresor de Energía Tipo 1, 1P, m30V	Módulo de Reemplazo Tipo 1 (Fase) Un: m30 Vac, Uc: 275-255 Vac, Iimp: 50-30 kA. 	140.117996	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2376	\N	Puerta DR-A4	Puerta Transparente para Gabinete 1 Nivel con compartimiento de Baterías (Color negro)	140.283005	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2377	\N	Puerta DR-A4R	Puerta Transparente para Gabinete 1 Nivel con compartimiento de Baterías (Color rojo)	140.283005	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2378	\N	Extintor móvil de polvo químico seco ABC lleno 50 kg	Extintor PQS  ABC  50kg lleno. Agente Extintor : Polvo ABC 55 Agente propulsor: Nitrogeno seco. Acabado: pintura al Horno 100%poliester, Ral 3000 espesor de la capa que garantyice como minimo 480 hrs de la prueba de nieblas salinas si n que aparezcan sintomas de corrosión.Caracteristicas Técnicas:Presión de diseño:25 bar,Presión de prueba:25 bar Presión maxima de servcio: 17 bar;Carga 50kg±5%Temperatura de servicio:-20 a 60 ºC Uso Aconsejable: Fuegos ABC y E para tensiónes electricas menores a 35 Kv; Altura (1003-1050)mm;Diametro 300mm; Espesor Nominal de la pared 2,5mm; Volumen:52l; tara:(24,5-25,06) kg , Peso total:(74,5-75,06) kg. Materiales: Botella y chasis:fabricada en chapa de acero; Valvula manual:Latón, acero y caucho(incluye pasadorde seguridad en maneta de accionamiento y precinto sobre pasador); Indicador de presión :ø 37mm:Latón cromado;Manguera:caucho,textil,acero y propileno;  presión de servicio de la manguera: 20 bar, presión de ruptura de la manguera:65bar;Tubo Sonda de PVC ó Polipropileno. Etiqueta Serigrafiadaó Acetato Adhesivo Colgador.Ruedas de carro:ø300mm polipropileno y caucho sintético .	140.800003	1	4		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2379	\N	Kit de Montaje Honeywell SC117	Kit de Montaje en Piso para Sensor de Vibración	140.910004	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2380	\N	Panel de Alarmas PC-1864	Panel de Alarma contra Intrusos 8 Zonas DSC (Expande Hasta 64 Zonas)	141.110001	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2381	\N	Módulo de Reemplazo para Supresor para Red de Energía Tipo 1, 1P, 277V	Módulo de Reemplazo Tipo 1 (Fase) Un: 277 Vac, Uc: 320 Vac, Iimp: 25 kA. 	142.658997	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2382	\N	Módulo de Reemplazo para Supresor para Red de Energía Tipo 1+2, m30V	Módulo de Reemplazo Tipo 1+2, (Fase) Un: m30 Vac, Uc: 264-275 Vac, Iimp: 25 kA	142.658997	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2383	\N	Supresor para Red de Energía Tipo 1, 1P, m30V	Supresor Modular Tipo 1, 1P (Fase) con Monitoreo a Distancia. Un: m30 Vac, Uc: 275-255 Vac, Iimp: 50-30 kA. 	145.826996	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2384	\N	Transmisor IP Honeywell 7847i-E	Comunicador (Transmisor) para Incorporar a una Red IP, Paneles de la Serie Vista. 	147.774002	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2385	\N	Supresor para Red de Datos 4 Líneas 24V 	Supresor Modular para Datos para 4 Líneas Un: 24 Vdc. Uc: 33 Vdc. IL: 0,75 A. 	147.960999	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2386	\N	Accesorio de Empotrar TR-B4	Accesorio para Empotrar Gabinetes de 2 Niveles con compartimiento de Baterías	148.225006	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2387	\N	Puerta DR-B4B	Puerta Sólida para Gabinete 2 Niveles con compartimiento de Baterías (Color negro)	148.720001	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2388	\N	Puerta DR-B4BR	Puerta Sólida para Gabinete 2 Niveles con compartimiento de Baterías (Color rojo)	148.720001	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2389	\N	Supresor para Red de Energía Tipo 1, 1P, 120V	Supresor Modular Tipo 1, 1P (Fase) con Monitoreo a Distancia. Un:120 Vac, Uc: 150 Vac, Iimp: 35-30 kA, In: 40 kA, Imax: 50 kA. 	148.742004	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2390	\N	Módulo de Reemplazo para Supresor para Red de Energía Tipo 1+2, 400V	Módulo de Reemplazo Tipo 1+2, (Fase) Un: 400 Vac, Uc: 460 Vac, Iimp: 25 kA	149.720993	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2391	\N	Panel NFS-TFT	Pantalla gráfica de 4,3" (480x272 pixels) para NFSx-Supra	150	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2392	\N	Altavoz PF-24V	Altavoz de Evacuación (Exit Point)	153.384003	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2393	\N	Detector FST-951H(A) Nuevo	Detector de Alta Termperatura Fija 88°C Direccionable (usa la base B300-6)	153.955994	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2394	\N	Detector FSV-951R(A) Nuevo	Detector de Humo Óptico Laser Direccionable de Alerta Temprana VIEW (usa la base B300-6) 	153.955994	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2395	\N	Detector FST-951R(A)	Detector de Temperatura Fija 57°C/ Termovelocimétrico Direccionable (usa la base B300-6)	153.955994	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2396	\N	Módulo de Reemplazo  para Supresor para Red de Energía Tipo 1+2, 130V	Módulo de Reemplazo Tipo 1+2, (Fase) Un: 130 Vac, Uc: 150 Vac, Iimp: 25 kA, Imax: 65 kA.	154.143005	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2397	\N	Válvula de Bola extremos ranurados 1½"	Válvula de Bola extremos ranurados equipada con palanca de mano o volante. Para control de flujo en SIACI 	154.246399	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2398	\N	Chasis CHS2-M2	Chasis para Montaje de CPU2-640 y Anunciadores en la 1ra Fila	157.014008	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2399	\N	Sensor Movimiento Doble Tecnica inalambrico Honeywell 5898	Sensor de Movimiento Doble Tecnología Inalambrico Pir-Microonda Antimascota 15 x 18m 	157.464996	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2400	\N	Acesorio de Empotrar TR-C4	Accesorio para Empotrar Gabinetes de 3 Niveles con compartimiento de Baterías	158.330002	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2401	\N	Tubería Flexible Metalica EMT Forrado con Goma LIQUIDTIGHT 1"	Tubería Flexible Metalica Acero Electrogalvanizado o Galvanizado en Caliente Forrado con Goma LIQUIDTIGHT 1¨, Diámetro Int. 25 mm, Diámetro Ext. 32 mm 	165	2	1	NO APARECE EN NINGUN CONTRATO MARCO	\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2402	\N	Sensor Movimiento Doble Tecnica para Exteriores IP65 DSC LC-171	Sensor de movimiento de doble tecnología doble sensor PIR y microondas con inmunidad a mascotas regulable contacto para Exteriores IP65 Form C (NC&NO) (Alcance Max.12m) 	165.901993	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2403	\N	HLSPS25 	Fuente de alimentación EN54-4A2 de 24 vcc con 1 o 2 salidas 65W / 2,5A	166.132996	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2404	\N	Supresor para Red de Energía Tipo 1, 1P, 277V	Supresor Modular Tipo 1, 1P (Fase) con Monitoreo a Distancia. Un: 277 Vac, Uc: 320 Vac, Iimp: 25 kA. 	167.464005	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2405	\N	Fuente Auxiliar Altronix eFlow6N	Fuente Auxiliar 120VAC 60Hz, 1 salida 12 o 24 VDC 6A (Tarjeta)	167.729996	1	10		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2406	\N	Módulo Programación Honeywell 7720P	Módulo de Programación (OBLIGADO PARA PROGRAMAR 7810e)	171.578003	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2407	\N	Accesorio de Empotrar TR-D4	Accesorio para Empotrar Gabinetes de 4 Niveles con compartimiento de Baterías	173.492004	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2408	\N	Gabinete EQBB-C4	Gabinete de Equipamiento de 3 Niveles	174.283997	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2409	\N	Gabinete EQBB-B4	Gabinete de Equipamiento de 2 Niveles	175.164001	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2410	\N	Supresor para Red de Energía Tipo 3, 4P, m30V	Supresor Modular. Tipo 3, 4P (3 Fase + Neutro) con Monitoreo a Distancia. Un: m30 Vac, Uc: 255 Vac, IL: 25 A, In: 3 kA, Itotal: 5 kA.	176	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2411	\N	Puerta DR-B4	Puerta Transparente para Gabinete 2 Niveles con compartimiento de Baterías (Color negro)	176.264008	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2412	\N	Puerta DR-B4R	Puerta Transparente para Gabinete 2 Niveles con compartimiento de Baterías (Color rojo)	176.264008	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2413	\N	Supresor para Red de Energía Tipo 2, 4P, 120V	Supresor Modular TNS. Tipo 2, 4P (3 Fases + Neutro) con Monitoreo a Distancia.  Un: 120 Vac, Uc: 155 Vac, In: 20 kA, Imax: 40 kA, Iimp: 12 kA.	178.914993	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2414	\N	Sonda Temperatura TMP2DDS1A	Detector térmico EN54/5 autorrearmable con rango de activación entre 99°C y 115°C (clase D) IP66	183.975006	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2415	\N	Módulo Dual Monitor + Relé FDRM-1(A)	Módulo Dual Combinado (2 Entradas Programables de Módulo Monitores + 2 Salidas Programables de Relay, Contactos Libres de Potencial Forma C)	185.272995	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2416	\N	Supresor para Red de Energía Tipo 2, 4P, 300V	Supresor Modular TNS. Tipo 2, 4P (3 Fases + Neutro) con Monitoreo a Distancia.  Un: 300 Vac, Uc: 320 Vac, In: 20 kA, Imax: 40 kA, Iimp: 12 kA.	185.526001	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2417	\N	Supresor para Red de Energía Tipo 2, 4P, m30V	Supresor Modular TNS. Tipo 2, 4P (3 Fases + Neutro) con Monitoreo a Distancia.  Un: m30 Vac. Uc: 275 Vac, In: 20 kA, Imax: 40 kA, Iimp: 12 kA.	189.507996	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2418	\N	Sonda Temperatura TMP2DA2S1A	Detector térmico EN54/5 autorrearmable con rango de activación entre 54°C y 70°C (clase A) IP66	190.156998	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2419	\N	Sonda Temperatura TMP2DCS1A	Detector térmico EN54/5 autorrearmable con rango de activación entre 84°C y 100°C (clase C) IP66	190.156998	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2420	\N	Válvula de Bola extremos ranurados 2"	Válvula de Bola extremos ranurados equipada con palanca de mano o volante. Para control de flujo en SIACI 	193.608795	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2421	\N	Módulo S300ZDU	Módulo Interfaz de display de zona convencional	194.281998	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2422	\N	Detector FCO-951(A) Nuevo	Detector Multicriterio, Humo, CO2, Temperatura, Luz y Llamas. (usa la base B300-6) 	195.429993	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2423	\N	PS-1265	Batería de 12V. Capacidad 65Ah	195.645996	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2424	\N	Sensor de Flujo de paleta,  para tubería 3"	Sensor de Flujo de paleta , para tubos  de acero de tamaño de 2” a 8” para montar en posición horizontal o vertical. Su construcción es robusta y puede ser utilizado tanto en exteriores como en interiores, pero nunca en atmósferas explosivas.	196.503998	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2425	\N	Sensor de Flujo de paleta,  para tubería 6"	Sensor de Flujo de paleta , para tubos  de acero de tamaño de 2” a 8” para montar en posición horizontal o vertical. Su construcción es robusta y puede ser utilizado tanto en exteriores como en interiores, pero nunca en atmósferas explosivas.	196.503998	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2426	\N	Sensor de Flujo de paleta, para tubería 4"	Sensor de Flujo de paleta , para tubos  de acero de tamaño de 2” a 8” para montar en posición horizontal o vertical. Su construcción es robusta y puede ser utilizado tanto en exteriores como en interiores, pero nunca en atmósferas explosivas.	196.503998	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2427	\N	Accesorio de Empotrar TR-A4	Accesorio para Empotrar Gabinetes de 1 Nivel con compartimiento de Baterías	196.602997	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2428	\N	Software de programación          PK-8200 Nuevo	Software de programación y configuración para AM-8200	199.078003	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2429	\N	Tarjeta AM-82-2S2C Nuevo	Tarjeta comunicaciones (impresora + Terminales remotos LCD-8200)	199.078003	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2430	\N	Carcasa para Detector de Ducto DNRW	Carcasa para Detector de Ductopara Zonas Estancas con Montaje para: FSP-851(A)-FSP-851R(A)	199.100006	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2431	\N	Panel Alarmas Honeywell VISTA 50P	Panel de Alarma Contra Intrusos 9 Zonas 8 Particiones con Tecnología Vplex	199.429993	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2432	\N	Supresor de Sobretensiones Transitorias + Permanentes para Red de Energía. Tipo 2. 4P. 120V. 	Módulo Protector Tipo 2, 4P (3 Fase+Neutro) Contra Sobre-Tensiones Transitorias y Permanentes con Contactor y Elemento de Corte con Rearme Automático. Un: 120V, Uc: 208V, Ua: 144V. (In: 5kA. Imax. 15kA onda 8/20µs)	199.990997	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2433	\N	Supresor de Sobretensiones Transitorias + Permanentes para Red de Energía. Tipo 2. 4P. m30V. 25A	Módulo Protector Tipo 2, 4P (3 Fase+Neutro) Contra Sobre-Tensiones Transitorias y Permanentes con Contactor y Elemento de Corte con Rearme Automático. Un: m30V, Uc: 400V, Ua: 275V. In: 25A. (In: 5kA. Imax. 15kA onda 8/20µs)	199.992294	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2434	\N	Teclado DIA-6M	Teclado a membrana para AM-6000	201.442993	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2435	\N	HLSPS50	Fuente de alimentación EN54-4A2 de 24 vcc con 1 o 2 salidas 130W / 5A	204.578003	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2436	\N	Sensor Movimiento Exterior Honeywell 5800PIR-OD	Sensor de Movimiento Doble IR Exterior IP54 Inmune a la Luz ajustable a 90° alcance 12m	207.130005	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2437	\N	Válvula de retención extremos ranurados.   2"	Válvula de retención extremos ranurados. Material de Hierro dúctil, con ranuras. Acabado pintura roja  aprobaciones FM y  certificados UL para el uso en sistemas automáticos de sprinklers.	207.468796	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2438	\N	Válvula de Mariposa extremos ranurados  4"	Válvula de Mariposa extremos ranurados, equipada con palanca de mano o volante. Material de Hierro dúctil, con ranuras. Acabado pintura rojaaprobaciones FM y  certificados UL para el uso en sistemas automáticos de sprinklers.	208.737762	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2439	\N	Válvula de Mariposa extremos ranurados  3"	Válvula de Mariposa extremos ranurados, equipada con palanca de mano o volante. Material de Hierro dúctil, con ranuras. Acabado pintura rojaaprobaciones FM y  certificados UL para el uso en sistemas automáticos de sprinklers.	214.133926	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2440	\N	Fuente Auxiliar Altronix eFlow6NX	Fuente Auxiliar 120VAC 60Hz, 1 salida 12 o 24 VDC  6A (Tarjeta + Gabinete)	217.130005	1	10		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2441	\N	Panel NFS4-Supra	Central convencional microprocesada de 4 zonas con histórico incorporado y opciones de conexión remota vía TG	218	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2442	\N	BIE - 45 mm, hecho en Fibra de vidrio, con manguera plana (Completo). 	Boca de Incendio Equipada Ø 45 mm, armario fabricado en fibra de vidrio, con troquel en la parte inferior para entrada de agua. Cierre rápido con tirador y bisagras de acero inoxidable. Carrete pintado en rojo RAL3002 de 525 mm, abatible 180º. Colector de poliamida-fibra de vidrio, anticorrosión y muy resistente a la fricción.  Dimensiones 570 alto x 570 ancho x 215 fondo\nManguera racorada en sus dos extremos con racores según UNE m3.400 de Ø45 mm, uso ligero 20 metros de longitud. Lanza  Variomatic de 45 mm, triple efecto (chorro, pulverización cónica y cierre), conectada al extremo de la manguera por medio de racores tipo Barcelona. Manómetro Con rosca de ¼” GAS. Escala de 0-16 kg/cm2.\nIdeal para instalaciones exteriores y para ambientes corrosivos gracias a su composición que lo hace prácticamente inalterable a los agentes externos. 	219.665604	1	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2443	\N	Válvula de retención extremos ranurados.   2½"	Válvula de retención extremos ranurados. Material de Hierro dúctil, con ranuras. Acabado pintura roja  aprobaciones FM y  certificados UL para el uso en sistemas automáticos de sprinklers.	222.314407	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2444	\N	Módulo de Enlace Honeywell VA-8200	Módulo de Enlace hasta 8 (Paneles Vista 128BPT y Vista 250BPT)	225.852005	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2445	\N	Puerta DR-C4B	Puerta Sólida para Gabinete 3 Niveles con compartimiento de Baterías (Color negro)	227.039993	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2446	\N	Puerta DR-C4BR	Puerta Sólida para Gabinete 3 Niveles con compartimiento de Baterías (Color rojo)	227.039993	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2447	\N	Módulo M710E-CZ	Módulo monitor de 1 zona convencional supervisada (detectores a 2 hilos) con condensador de final de línea, led de estado y aislador incorporado	227.348007	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2448	\N	Módulo M710E-CZR	Módulo monitor de 1 zona convencional supervisada (detectores a 2 hilos) con resistencia de final de línea, led de estado y aislador incorporado	227.348007	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2449	\N	Teclado Tactil Inalambrico DSC WTK5504	Teclado Inalámbrico con Interfaz de Armado Táctil PowerSeries (usar con modulo TR5164-433)	230.229996	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2450	\N	Teclado Tactil Inalambrico con Lector de Proximidad DSC WTK5504	Teclado Inalámbrico con Interfaz de Armado Táctil PowerSeries y Lector de Proximidad Incorporado (usar con modulo TR5164-433) (usar tarjeta de proximidad WTK5504P únicamente)	230.229996	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2451	\N	Teclado Inalámbrico de 2 Vías con Lector de Proximidad DSC WT5500P	Teclado Inalámbrico de 2 Vías PowerSeries con Lector de Proximidad Incorporado (usar con modulo TR5164-433) (usar tarjeta de proximidad WTK5504P únicamente)	230.229996	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2452	\N	Barrera Perimetral OPTEX SL-200QN	Barrera Perimetral Alcance 60 m, Protección al Ambiente IP-65	230.919998	1	10		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2453	\N	Puerta EQDR-C4	Puerta con Rejilla de Ventilación para Gabinete de Equipamiento de 3 Niveles 	232.440994	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2454	\N	Fuente Auxiliar Altronix eFlow6N8D	Fuente Auxiliar 120VAC 60Hz, 8 salidas 12 o 24 VDC  proteguidas por fusibles electronicos rearmables 6A total - 750mA por cada salida (Tarjeta + Gabinete)	236.529999	1	10		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2455	\N	Puerta EQDR-B4	Puerta con Rejilla de Ventilación para Gabinete de Equipamiento de 2 Niveles	240.009003	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2456	\N	Supresor de Sobretensiones Transitorias + Permanentes para Red de Energía. Tipo 2. 4P. m30V. 63A	Módulo Protector Tipo 2, 4P (3 Fase+Neutro) Contra Sobre-Tensiones Transitorias y Permanentes con Contactor y Elemento de Corte con Rearme Automático. Un: m30V, Uc: 400V, Ua: 275V. In: 63A. (In: 5kA. Imax. 15kA onda 8/20µs)	241.351959	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2457	\N	Contador de Impactos	Contador de Descargas Electromecánico	247.360001	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2458	\N	Fuente Auxiliar Altronix eFlow102N8D	Fuente Auxiliar 120VAC 60Hz, 8 salidas 12 o 24 VDC  proteguidas por fusibles electronicos rearmables 10A total - 1,25A por cada salida (Tarjeta + Gabinete)	251.850006	1	10		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2459	\N	Puerta DR-D4B	Puerta Sólida para Gabinete 4 Niveles con compartimiento de Baterías (Color negro)	256.299988	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2460	\N	Puerta DR-D4BR	Puerta Sólida para Gabinete 4 Niveles con compartimiento de Baterías (Color rojo)	256.299988	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2461	\N	Válvula de pie con filtro de bronce  4". Bridada	Válvula de pie con filtro de broce, con brida. PN-11	259.20047	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2462	\N	BIE - 45 mm, chapa metálica y puerta de cristal, con manguera plana (Completo). 	Boca de Incendio Equipada BIE-45. Constituida por un armario horizontal metálico, un soporte (devanadera) para colocar la manguera, una válvula de cierre manual con manómetro y una lanza. Requerimientos: Armario  (chapa de acero de 1 mm de espesor con marco en acero para colocar cristal, provisto de pre taladro para la entrada de alimentación, pintado en color rojo RAL 3000,  medidas 625 x 520 x 140 mm), manguera (manguera de goma y lona  plana de 20 m de longitud racorada en sus dos extremos con racores según UNE m3.400 de Ø45 mm), lanza (Variomatic de 45 mm de 3 efectos, con racor Barcelona de conexión rosca macho de 45 mm, fabricada en ABS de alta resistencia y color rojo), válvula de  ángulo (Ø  45 mm, de latón y aluminio apertura lenta, completa  con racor Barcelona y manómetro) Juego de etiquetas " ROMPASE EN CASO DE INCENDIO"	260.247681	1	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2463	\N	Teclado Tactil Honeywell  6280W	Teclado TouchScreen Blanco (Paneles Vista 128BPT y Vista 250BPT)	260.54599	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2464	\N	Teclado Tactil Honeywell  6280S	Teclado TouchScreen Plateado (Paneles Vista 128BPT y Vista 250BPT)	260.54599	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2465	\N	Válvula de retención extremos ranurados.   6"	Válvula de retención extremos ranurados. Material de Hierro dúctil, con ranuras. Acabado pintura roja  aprobaciones FM y  certificados UL para el uso en sistemas automáticos de sprinklers.	262.452972	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2466	\N	Tarjeta Multiples Módulos Monitores XP10-M(A)	Tarjeta de 10 Módulos Monitores, 10 Entradas Programables de Contactos Secos  	263.93399	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2467	\N	Teclado Inalámbrico de 2 Vías DSC WT5500	Teclado Inalámbrico de 2 Vías PowerSeries (usar con modulo TR5164-433)	264	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2468	\N	Módulo de Reemplazo para Supresor para Red de Energía, Tipo 1. Neutro	Módulo de Reemplazo Tipo 1 (Neutro) Un: m30 Vac, Uc: 255 Vac, Iimp: 100-60 kA, In:40 kA. 	267.608002	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2469	\N	Válvula de compuerta extremos ranurados.   2"	Válvula de compuerta extremos ranurados. Material de Hierro dúctil, con ranuras. Acabado pintura roja  aprobaciones FM y  certificados UL para el uso en sistemas automáticos de sprinklers.	269.068787	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2470	\N	Letrero SP-2MNS	Letrero Óptico Acústico de 2 Mensajes (Pre-alarma y Evacuación)	274.119995	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2471	\N	Gabinete EQBB-D4	Gabinete de Equipamiento de 4 Niveles	276.320007	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2472	\N	Interfaz de Seguridad con Pantalla Táctil DSC PTK5507W	Teclado con Interfaz de Seguridad Táctil PowerSeries Blanco	276.429993	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2473	\N	Interfaz de Seguridad con Pantalla Táctil DSC PTK5507S	Teclado con Interfaz de Seguridad Táctil PowerSeries Plateado	276.429993	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2474	\N	Válvula de pie con filtro  2½", bridada	Válvula de pie de Hierro Fundido,con brida. PN-10 colador inoxidable	278.666077	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2475	\N	Panel NFS8-Supra	Central convencional microprocesada de 8 zonas con histórico incorporado y opciones de conexión remota vía TG	283	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2476	\N	BIE - 25 mm, hecho en Fibra de vidrio, con manguera semirrígida (Completo). 	Boca de Incendio Equipada (B.I.E-25), completa con armario metálico, homologada y certificada según UNE-EN-671.1 para su instalación final en obra. Dotada de manguera semirrígida de 25mm (1") de diámetro con 20 metros de longitud, racorada con machones de 1" rosca macho a ambos extremos, con válvula de esfera de 25 mm (1"), manómetro 0-16 Bar, lanza Variomatic de 3 efectos de 25 mm, devanadera fija metálica pintada en rojo (posibilidad de extraer en el montaje de la BIE) para manguera. Armario metálico (chapa de 1,5 mm de grosor) pintado en rojo RAL-3000, con puerta para cristal pintada en rojo RAL-3000, con bisagra integrada y cierre de cuadradillo. Medidas del armario: 70 alto x 25 profundo x 50 ancho en cm. Entrada de tubería por abajo en el centro del armario (incluye pre-taladro en el armario).Armario preparado para empotrar (rejilla lateral de ventilación). Manguera homologada y certificada. Incluye adhesivo de "Rómpase en Caso de incendio". Equipo completo para su instalación final en obra. deal para pilares de obra (estrecha, funcional y poco profunda).	289.914246	1	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2477	\N	Válvula de pie con filtro de bronce 2½". Bridada	Válvula de pie con filtro de broce, con brida. PN-13	297.799042	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2478	\N	Tarjeta Multiples Módulos Relé XP6-R(A)	Tarjeta de 6 Módulos Relay Direccionables Forma C, 6 Salidas Programables de Relay, Contactos Libres de Potencial	298.276001	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2562	\N	Fuente AMPS-24	Fuente de Alimentación Direccionable para Panel NFS2-3030 (110 Volt)	636.757019	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2563	\N	Fuente AMPS-24E	Fuente de Alimentación Direccionable para Panel NFS2-3030 (220 Volt)	636.757019	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2479	\N	Válvula de Mariposa extremos ranurados (supervisada) 4"	Válvula de mariposa con extremos ranurados, equipada con volante e interruptor de control y cableado para su monitoreo remoto. Material de Hierro dúctil, acabado pintura roja,  aprobados FM y  certificados UL para el uso en sistemas automáticos de sprinklers. 	299.930389	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2480	\N	Contador de Impactos	Contador de Descargas con Puerto USB + Software y Baterías 	300.190002	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2481	\N	Gabinete SBB-C4	Gabinete de 3 Niveles con compartimiento de Baterías (Color negro)	300.377014	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2482	\N	Gabinete SBB-C4R	Gabinete de 3 Niveles con compartimiento de Baterías (Color rojo)	300.377014	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2483	\N	Electrodo de Grafito	Electrodo de Grafito Diámetro: 150 mm. Largo 600 mm + polvo de Grafito 	302.136993	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2484	\N	Válvula de Mariposa extremos ranurados 8"	Válvula de Mariposa extremos ranurados, equipada con palanca de mano o volante. Material de Hierro dúctil, con ranuras. Acabado pintura rojaaprobaciones FM y  certificados UL para el uso en sistemas automáticos de sprinklers.	302.406708	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2485	\N	Fuente Auxiliar Altronix eFlow102N16D	Fuente Auxiliar 120VAC 60Hz, 16 salidas 12 o 24 VDC  proteguidas por fusibles electronicos rearmables 10A total - 625mA por cada salida (Tarjeta + Gabinete)	302.640015	1	10		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2486	\N	Equipo de Encendido Electrónico	Equipo de Encendido Electrónico para Soldadura Exotérmica.	305.28299	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2487	\N	Hidrante 4" bajo nivel de tierra GEISER 1 boca de 4" para uso de bomberos	Hidrante 4" bajo nivel de tierra GEISER 1 boca de 4" para uso de bomberos	306.115051	1	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2488	\N	Válvula de compuerta extremos ranurados.   2½"	Válvula de compuerta extremos ranurados. Material de Hierro dúctil, con ranuras. Acabado pintura roja  aprobaciones FM y  certificados UL para el uso en sistemas automáticos de sprinklers.	309.367523	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2489	\N	Panel Alarmas Honeywell VISTA 128BPT	Panel de Alarma Contra Intrusos 9 Zonas 8 Particiones con Tecnología Vplex	309.881012	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2490	\N	Transceptor Inalámbrico Honeywell 5883H 	Módulo Transceptor Inalambrico Alta Seguridad Zonas Ilimitadas de (Funcionamiento Bidireccional)	312.884003	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2491	\N	Panel NFS12-Supra	Central convencional microprocesada de 12 zonas con histórico incorporado y opciones de conexión remota vía TG	314	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2492	\N	Fuente FCPS-24S6C	Fuente de Alimentación Auxiliar Sin Suervisión (6 Amp) (110 Volt) con Gabinete	314.600006	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2493	\N	Fuente FCPS-24S6CE	Fuente de Alimentación Auxiliar Sin Suervisión (6 Amp) (220 Volt) con Gabinete	314.600006	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2494	\N	Supresor para Red de Energía Tipo 1+2, 2P, 130V	Supresor Modular TNS. Tipo 1+2, 2P (Fase + Neutro) con Monitoreo a Distancia. Un: 130 Vac, Uc: 150 Vac, Iimp: 25 kA, Imax: 65 kA. 	320.589142	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2495	\N	Válvula de Mariposa extremos ranurados  (supervisada) 6"	Válvula de mariposa con extremos ranurados, equipada con volante e interruptor de control y cableado para su monitoreo remoto. Material de Hierro dúctil, acabado pintura roja,  aprobados FM y  certificados UL para el uso en sistemas automáticos de sprinklers. 	321.046875	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2496	\N	Batería BAT-12550	Batería Sellada de 12 Volt 50 A/H	324.720001	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2497	\N	Anunciador N-ANN-LED	Módulo Anunciador a LED hasta 10 Zonas para Paneles Convencionales con Gabinete Negro 	325.600006	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2498	\N	Anunciador N-ANN-LED-R	Módulo Anunciador a LED hasta 10 Zonas para Paneles Convencionales con Gabinete Rojo	325.600006	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2499	\N	Panel Alarmas Honeywell VISTA 128FBP	Panel de Alarma Contra Intrusos ara aplicaciones Contra Incendios 9 Zonas 8 Particiones con Tecnología Vplex (incluye en la placa dos lazos para detectores de incendios a dos hilos con expansion opcional)	328.203003	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2500	\N	Anunciador AEM-24AT	Anunciador de Control (Módulo Expansor de 24 Puntos)	334.51001	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2501	\N	Gabinete BB-100	Gabinete con Puerta, Capacidad para Alojar Fuente auxiliar + 2 Baterías de hasta de 100 A/H	334.51001	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2502	\N	Gabinete SBB-D4	Gabinete de 4 Niveles con compartimiento de Baterías (Color negro)	334.51001	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2503	\N	Gabinete SBB-D4R	Gabinete de 4 Niveles con compartimiento de Baterías (Color rojo)	334.51001	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2504	\N	Fuente FCPS-24S8C	Fuente de Alimentación Auxiliar Sin Suervisión (8 Amp) (110 Volt) con Gabinete	337.700012	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2505	\N	Fuente FCPS-24S8CE	Fuente de Alimentación Auxiliar Sin Suervisión (8 Amp) (220 Volt) con Gabinete	337.700012	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2506	\N	Tarjeta LIB-8200 Nuevo	Tarjeta de ampliación de 2  lazos para AM-8200	339.812012	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2507	\N	Copete de Torreta	Tramo Final o Copete de Torreta Triangular con Orificio de Diámetro Interior mayor a 1 1/2" para Instalación de Mástil	343.81601	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2508	\N	Kit de Programación UPDL1000	Kit de programación remota para AM-1000	344.476013	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2509	\N	Kit de Programación UPDL2000	Kit de programación remota para AM-2000	344.476013	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2510	\N	Kit de Programación UPDL6000	Kit de programación remota para AM-6000	344.476013	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2511	\N	Válvula de pie con filtro de bronce 3". Bridada	Válvula de pie con filtro de broce, con brida. PN-12	354.532654	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2512	\N	Válvula de pie con filtro 3",bridada	Válvula de pie de Hierro Fundido,con brida. PN-10 colador inoxidable	356.996643	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2513	\N	Válvula de Mariposa extremos ranurados 10"	Válvula de Mariposa extremos ranurados, equipada con palanca de mano o volante. Material de Hierro dúctil, con ranuras. Acabado pintura rojaaprobaciones FM y  certificados UL para el uso en sistemas automáticos de sprinklers.	360.138245	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2514	\N	Supresor para Red de Energía, Tipo 1. Neutro	Supresor Modular Tipo 1, 1P (Neutro) con Monitoreo a Distancia. Un: m30 Vac, Uc: 255 Vac, Iimp: 100-60 kA, In:40 kA. 	362.911987	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2515	\N	Barrera Perimetral OPTEX SL-350QN	Barrera Perimetral Alcance 100 m, Protección al Ambiente IP-65	363.619995	1	10		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2516	\N	Válvula de Mariposa extremos ranurados 6"	Válvula de Mariposa extremos ranurados, equipada con palanca de mano o volante. Material de Hierro dúctil, con ranuras. Acabado pintura rojaaprobaciones FM y  certificados UL para el uso en sistemas automáticos de sprinklers.	365.497437	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2517	\N	Puerta EQDR-D4	Puerta con Rejilla de Ventilación para Gabinete de Equipamiento de 4 Niveles 	367.179993	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2518	\N	Tarjeta Communicadora UDACT-2	Tarjeta Comunicadora Trasmisora de Alarma Digital Universal	385	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2519	\N	Torre para Barrera OPTEX AX-TW200M	Torre de Montaje en Pared para Barreras Perimetrales. (Altura 190m)	386.040009	1	10		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2564	\N	Comprobador POL-200-TS	Herramienta de diagnóstico del lazo	648.736023	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2520	\N	Válvula de Mariposa extremos ranurados (supervisada) 8"	Válvula de mariposa con extremos ranurados, equipada con volante e interruptor de control y cableado para su monitoreo remoto. Material de Hierro dúctil, acabado pintura roja,  aprobados FM y  certificados UL para el uso en sistemas automáticos de sprinklers. 	390.248322	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2521	\N	Válvula de pie con filtro  4", bridada	Válvula de pie de Hierro Fundido,con brida. PN-10 colador inoxidable	393.254395	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2522	\N	Módulo de Reemplazo  para Supresor para Red de Energía Tipo 1+2, Neutro	Módulo de Reemplazo Tipo 1+2, (Neutro) Un: m30 Vac, Uc: 255-264 Vac, Imp: 30 kA, Imax: 65 kA. 	394.505676	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2523	\N	Tarjeta de Lazo LEM-320	Tarjeta Expansora de Lazo para Paneles NFS2-3030 (se usa en parejas con la LCM-320)	399.531006	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2524	\N	Tarjeta de Lazo LEM-320	Tarjeta Expansora de Lazo para Paneles NFS2-640 (se usa una sola en el panel NFS2-640)	399.531006	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2525	\N	Válvula de compuerta extremos ranurados.   3"	Válvula de compuerta extremos ranurados. Material de Hierro dúctil, con ranuras. Acabado pintura roja  aprobaciones FM y  certificados UL para el uso en sistemas automáticos de sprinklers.	400.104309	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2526	\N	Válvula de Mariposa extremos ranurados 12"	Válvula de Mariposa extremos ranurados, equipada con palanca de mano o volante. Material de Hierro dúctil, con ranuras. Acabado pintura rojaaprobaciones FM y  certificados UL para el uso en sistemas automáticos de sprinklers.	401.287048	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2527	\N	Anunciador AEM-48AT	Anunciador de Control (Módulo Expansor de 48 Puntos)	415.359985	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2528	\N	Hidrante 4" bajo nivel de tierra GEISER 2 bocas de 2 1/2"	Hidrante 4" bajo nivel de tierra GEISER 2 bocas de 2 1/2"	424.497925	1	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2529	\N	Válvula de compuerta extremos ranurados.   4"	Válvula de compuerta extremos ranurados. Material de Hierro dúctil, con ranuras. Acabado pintura roja  aprobaciones FM y  certificados UL para el uso en sistemas automáticos de sprinklers.	435.795349	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2530	\N	Barrera Perimetral OPTEX SL-650QN	Barrera Perimetral Alcance 200 m, Protección al Ambiente IP-65	443.619995	1	10		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2531	\N	Puerta DR-C4	Puerta Transparente para Gabinete 3 Niveles con compartimiento de Baterías (Color negro)	450.559998	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2532	\N	Puerta DR-C4R	Puerta Transparente para Gabinete 3 Niveles con compartimiento de Baterías (Color rojo)	450.559998	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2533	\N	Electrodo Químico Vertical	Electrodo Químico Vertical de Cobre. Diámetro: 54 mm. Largo 3000 mm.	453.354004	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2534	\N	Válvula de retención extremos ranurados.   8"	Válvula de retención extremos ranurados. Material de Hierro dúctil, con ranuras. Acabado pintura roja  aprobaciones FM y  certificados UL para el uso en sistemas automáticos de sprinklers.	456.431366	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2535	\N	Anunciador ACM-48AT	Anunciador de Conntrol (Módulo de Control de 48 Puntos)	468.160004	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2536	\N	Válvula de Mariposa extremos ranurados (supervisada) 10"	Válvula de mariposa con extremos ranurados, equipada con volante e interruptor de control y cableado para su monitoreo remoto. Material de Hierro dúctil, acabado pintura roja,  aprobados FM y  certificados UL para el uso en sistemas automáticos de sprinklers. 	477.399994	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2537	\N	Tramo Intermedio de Torreta	Tramo Intermedio de Torreta Triangular (3 Metros)	510.532013	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2538	\N	Detector 6500RS	Detector de humo lineal IR convencional con prueba integrada 	527.218994	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2539	\N	Gabinete ICA 6	Gabinete de Alojamiento para LIB-600	529.111023	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2540	\N	Panel Alarmas Honeywell VISTA 250BPT	Panel de Alarma Contra Intrusos 9 Zonas 8 Particiones con Tecnología Vplex	535.656006	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2541	\N	Tarjeta de Red HS-NCM-W	Tarjeta Red NFN de Alta Velocidad para PC cableado en Par de Cobre	542.080017	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2542	\N	Puerta DR-D4	Puerta Transparente para Gabinete 4 Niveles con compartimiento de Baterías (Color negro)	544.775024	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2543	\N	Puerta DR-D4R	Puerta Transparente para Gabinete 4 Niveles con compartimiento de Baterías (Color rojo)	544.775024	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2544	\N	Válvula de Mariposa extremos ranurados (supervisada) 12"	Válvula de mariposa con extremos ranurados, equipada con volante e interruptor de control y cableado para su monitoreo remoto. Material de Hierro dúctil, acabado pintura roja,  aprobados FM y  certificados UL para el uso en sistemas automáticos de sprinklers. 	545.258545	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2545	\N	Válvula de pie con filtro de bronce 6". Bridada	Válvula de pie con filtro de broce, con brida. PN-10 	554.744934	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2546	\N	Válvula de pie con filtro  6", bridada	Válvula de pie de Hierro Fundido,con brida. PN-10 colador inoxidable	554.744934	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2547	\N	Torre para Barrera OPTEX AX-TW200	Torre Autosoportada (Doble Cara) para Barreras Perimetrales. (Altura 190m)	557	1	10		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2548	\N	Display LCD-160	Display para CPU2-3030	566.973022	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2549	\N	Display LCD-160-SP	Display para CPU2-3030 Idioma Español	566.973022	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2550	\N	Válvula de retención extremos ranurados.   10"	Válvula de retención extremos ranurados. Material de Hierro dúctil, con ranuras. Acabado pintura roja  aprobaciones FM y  certificados UL para el uso en sistemas automáticos de sprinklers.	571.081299	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2551	\N	Pararrayo Activo 15 µs	Pararrayos con Dispositivo de Cebado (PDC) 15 µs con Test Local	572.627014	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2552	\N	Supresor para Red de Energía Tipo 1+2, 2P, m30V	Supresor Modular TNS. Tipo 1+2, 2P (Fase + Neutro) con Monitoreo a Distancia. Un: m30 Vac, Uc: 264-275 Vac, Iimp: 25 kA, Itotal: 50 kA, Imax: 65 kA. 	572.911072	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2553	\N	Anunciador SCE-8	Estación Expansor de Control de Humo. Control y Monitoreo de Dampers y Fan (+8 Dispositivos)	575.52002	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2554	\N	Anunciador SCE-8L	Estación Expansor de Control de Humo. Control y Monitoreo de Lámparas y LEDs (+8 Dispositivos)	575.52002	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2555	\N	Anunciador ACM-24AT	Anunciador de Control (Módulo de Control de 24 Puntos)	583.726013	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2556	\N	Panel Alarmas Honeywell VISTA 250FBP	Panel de Alarma Contra Intrusos ara aplicaciones Contra Incendios 9 Zonas 8 Particiones con Tecnología Vplex (incluye en la placa dos lazos para detectores de incendios a dos hilos con expansion opcional)	589.344971	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2557	\N	Batería BAT-121000	Batería Sellada de 12 Volt 100 A/H	600.159973	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2558	\N	Tarjeta Interface SLC/MODBUS SLC-IM	Tarjeta Interface para integracion de protocolo MODBUS con NOTIFIER SLC (Conexión directa con el Panel )(usar tarjeta VHX-1420-HFS)	612.919983	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2559	\N	Electrodo Químico Horizontal	Electrodo Químico Horizontal (L) de Cobre. Diámetro: 54 mm x (1000 + 3000mm).	633.291992	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2560	\N	Fuente AMPS-24	Fuente de Alimentación Direccionable para Panel Anunciador NCA-2 (110 Volt)	636.757019	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2565	\N	Supresor para Red de Datos. Cat 6. PoE. 4Ptos	Supresor para Redes Informáticas con Conector RJ-45, 4 Puertos, Montaje en Rack Un: 48 Vdc, Uc: 60 Vdc, IL: 100 mA.  (No usar con CCTV)	653.015015	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2566	\N	Anunciador Remoto LCD2-80	Anunciador Remoto Display de 80 Caracteres 	669.02002	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2567	\N	Válvula de retención extremos ranurados.   12"	Válvula de retención extremos ranurados. Material de Hierro dúctil, con ranuras. Acabado pintura roja  aprobaciones FM y  certificados UL para el uso en sistemas automáticos de sprinklers.	684.647034	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2568	\N	Pararrayo Activo 30 µs	Pararrayos con Dispositivo de Cebado (PDC) 30 µs con Test Local	702.778992	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2569	\N	Válvula de compuerta extremos ranurados.   6"	Válvula de compuerta extremos ranurados. Material de Hierro dúctil, con ranuras. Acabado pintura roja  aprobaciones FM y  certificados UL para el uso en sistemas automáticos de sprinklers.	703.28717	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2570	\N	Detector NFXI-BEAM-T	Detector de humo lineal IR direccionable con prueba integrada 	706.39801	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2571	\N	Display LCD8200 Nuevo	Display remoto tactil 7" retroiluminado, para AM-8200	720.807983	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2572	\N	Supresor para Red de Datos. Cat 6. 5Vdc. 4Ptos	Supresor para Redes Informáticas con Conector RJ-45, 4 Puertos, Montaje en Rack Un: 5 Vdc, Uc: 6 Vdc, IL: 100 mA. (No usar con CCTV)	728.629028	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2573	\N	Hidrante de columna seca con entrada curva y conexión DN 100 (4")	Hidrante de columna seca con entrada curva profundidad 640 mm y conexión DN  (100-150), con dos (2) salidas de  21/2" (70) y una (1) salida de 4" para uso de (BOMBERO). Todas las salidas equipadas con conexiones rápidas tipo GOST con tapa y cadenilla. Hidrante con drenaje y sistema de rotura. Con una presión máxima de servicio de 16 bar y una presión de prueba de 25 bar. El cuerpo, la columna y el cuerpo de la válvula del hidrante están fabricados en fundición de hierro gris. 	733.039978	1	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2574	\N	Tarjeta de Lazo LCM-320	Tarjeta Controladora de Lazo para Paneles NFS2-3030 (se usa en parejas con la LEM-320)	734.370972	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2575	\N	Receptor IP Honeywell 7810iR-ENT	Receptor para Incoporporar a una Red IP Paneles de Alarma de la Serie Vista, Utilizando el 7847i-E	735.570007	1	9		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2576	\N	Supresor para Red de Energía Tipo 1+2, 4P, 400V	Supresor Modular TNS. Tipo 1+2, 4P (3 Fases + Neutro) con Monitoreo a Distancia. Un: 400 Vac, Uc: 460 Vac, Itotal: 100 kA, Iimp: 25 kA.	741.708008	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2577	\N	Detector BEAM1224S	Detector de As de Luz Proyectada Convencional con Test de Sensibilidad (Beam Master)	756.35199	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2578	\N	Supresor para Red de Datos. Cat 6. PoE. 8Ptos	Supresor para Redes Informáticas con Conector RJ-45, 8 Puertos, Montaje en Rack Un: 48 Vdc, Uc: 60 Vdc, IL: 100 mA.  (No usar con CCTV)	758.427979	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2579	\N	CPU NFS-320-RB-SP	Remplazo de unidad central de procesamiento con fuente de alimentación integrada 110 Volt sin Display para Panel de Alarmas contra Incendios Direccionable NFS-320 Idioma Español	762.762024	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2580	\N	CPU NFS-320-RB	Remplazo de unidad central de procesamiento con fuente de alimentación integrada 110 Volt sin Display para Panel de Alarmas contra Incendios Direccionable NFS-320 Idioma Ingles	762.762024	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2581	\N	Sensor de Movimiento OPTEX REDWALL SIP-5030	Sensor de Movimiento Laser para Montaje en Exterior e Interior IP-65, (Rango Ancho Área de Cubrimiento 50x30 m)	789.219971	1	10		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2582	\N	Sensor de Movimiento OPTEX REDWALL SIP-100	Sensor de Movimiento Laser para Montaje en Exterior e Interior IP-65, (Rango de Largo Alcance, Área de Cubrimiento 100x5 m)	814.539978	1	10		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2583	\N	Gabinete con pedestal fabricado con fibra de vidrio equipado.	Gabinete Exterior con pedestal fabricado en fibra de vidrio con resina poliéster. El pedestal de fibra de vidrio para rellenar con concreto y provisto de un set completo de tornillos, tuercas y arandela para su fijación al piso o base de hormigón. Destinado para el resguardo de la dotación de equipos auxiliares de los hidrantes exteriores. Apto para uso a la intemperie.  Equipado con:                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         • Dos (2) tramos de manguera Tipo 3 / equivalente   a  DURALINE Ø = 2 ½" Tramo de L = 20 m, extremos con conexiones tipo GOST de aluminio DN 70.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           • Dos (2) lanzas de bronce 2½" de 3 efectos de   con acoples GOST de aluminio.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   (Se podrá incluir otros equipos en la dotación según requerimientos del Sistema)	851.459839	1	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2584	\N	Gabinete con pedestal fabricado con fibra de vidrio sin equipar.	Gabinete Exterior con pedestal fabricado en fibra de vidrio con resina poliéster. El pedestal de fibra de vidrio para rellenar con concreto y provisto de un set completo de tornillos, tuercas y arandela para su fijación al piso o base de hormigón. Destinado para el resguardo de la dotación de equipos auxiliares de los hidrantes exteriores. Apto para uso a la intemperie.  	851.459839	1	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2585	\N	Anunciador NCA-2	Anunciador de Control de Red 	856.119019	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2586	\N	Anunciador NCA-2	Anunciador de Control de Red en modo Display (Requiere Chasis NCA-640-2-KIT)	856.119019	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2587	\N	Supresor para Red de Datos. Cat 6. PoE. 16Ptos	Supresor para Redes Informáticas con Conector RJ-45, 16 Puertos, Montaje en Rack Un: 48 Vdc, Uc: 60 Vdc, IL: 100 mA.  (No usar con CCTV)	858	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2588	\N	Supresor para Red de Energía Tipo 1+2, 4P, m30V	Supresor Modular TNS. Tipo 1+2, 4P (3 Fases + Neutro) con Monitoreo a Distancia. Un: m30 Vac, Uc: 264-275 Vac, Itotal: 100 kA, Iimp: 25 kA, Imax: 65kA. 	868.394653	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2589	\N	Gabinete BB-200	Gabinete con Puerta, Capacidad para Alojar Fuente auxiliar + 4 Baterías de hasta de 100 A/H	870.815002	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2590	\N	Pararrayo Activo 45 µs	Pararrayos con Dispositivo de Cebado (PDC) 45 µs con Test Local	873.257019	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2591	\N	Panel de Incendios RP-2001	Panel de Extinción Convencional hasta 6 Lazos (Extinción por Agua) (110 Volt)	877.359985	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2592	\N	Panel de Incendios RP-2001E	Panel de Extinción Convencional hasta 6 Lazos (Extinción por Agua) (220 Volt)	877.359985	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2593	\N	Interface MNS-CONTROL8	Interfaz para Panel de Incendios para Configuración de 8 Mensajes (para MegaDot)	893.200012	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2594	\N	Hidrante de columna seca con entrada recta y conexión DN 150 (6")	Hidrante de columna seca con entrada recta profundidad 640 mm y conexión DN  (100-150), con dos (2) salidas de  21/2" (70) y una (1) salida de 4" para uso de (BOMBERO). Todas las salidas equipadas con conexiones rápidas tipo GOST con tapa y cadenilla. Hidrante con drenaje y sistema de rotura. Con una presión máxima de servicio de 16 bar y una presión de prueba de 25 bar. El cuerpo, la columna y el cuerpo de la válvula del hidrante están fabricados en fundición de hierro gris. 	942.47998	1	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2595	\N	Anunciador SCS-8L	Estación Master de Control de Humo. Control y Monitoreo de Lámparas y LEDs (8 Dispositivos)	948.419983	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2596	\N	Anunciador SCS-8	Estación Master de Control de Humo. Control y Monitoreo de Dampers y Fan (8 Dispositivos)	948.926025	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2597	\N	Detector FS-OSI-RIA Nuevo	Detector de As de Luz Proyectada Direccionable con Prueba de Sensibilidad	954.799988	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2598	\N	Teclado KDM-R2-SP	Teclado para unidad central de procesamiento con fuente de alimentación integrada 110 Volt sin Display para Panel de Alarmas contra Incendios Direccionable NFS-320 Idioma Español	971.340027	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2599	\N	Teclado KDM-R2	Teclado para unidad central de procesamiento con fuente de alimentación integrada 110 Volt sin Display para Panel de Alarmas contra Incendios Direccionable NFS-320 Idioma Ingles	971.340027	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2600	\N	Teclado KDM-R2-SP	Teclado para unidad central de procesamiento con fuente de alimentación integrada 110 Volt sin Display para Panel de Alarmas contra Incendios Direccionablepara NFS2-640  Idioma Español	971.340027	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2601	\N	Teclado KDM-R2	Teclado para unidad central de procesamiento con fuente de alimentación integrada 110 Volt sin Display para Panel de Alarmas contra Incendios Direccionablepara NFS2-640 Idioma Ingles 	971.340027	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2602	\N	Hidrante de columna húmeda con entrada recta y conexión DN 150 (6")	Hidrante de columna húmeda con entrada recta y conexión DN  (100-150), con dos (2) salidas de  21/2" (70) y una (1) salida de 4" para uso de (BOMBERO). Todas las salidas equipadas con válvulas y conexiones rápidas tipo GOST con tapa y cadenilla. Hidrante sin drenaje y sistema de rotura. Con una presión máxima de servicio de 16 bar y una presión de prueba de 25 bar. El cuerpo, la columna y el cuerpo de la válvula del hidrante están fabricados en fundición de hierro gris. 	971.986389	1	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2603	\N	Supresor para Red de Datos. Cat 6. 5Vdc. 8Ptos	Supresor para Redes Informáticas con Conector RJ-45, 8 Puertos, Montaje en Rack Un: 5 Vdc, Uc: 6 Vdc, IL: 300 mA.  (No usar con CCTV)	1010.77899	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2604	\N	Válvula de compuerta extremos ranurados.   8"	Válvula de compuerta extremos ranurados. Material de Hierro dúctil, con ranuras. Acabado pintura roja  aprobaciones FM y  certificados UL para el uso en sistemas automáticos de sprinklers.	1016.94208	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2605	\N	Panel de Incendios RP-2002	Panel de Extinción Convencional hasta 6 Lazos (Extinción por Gas) (110 Volt)	1032.23999	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2606	\N	Panel de Incendios RP-2002E	Panel de Extinción Convencional hasta 6 Lazos (Extinción por Gas) (220 Volt)	1032.23999	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2607	\N	Hidrante de columna seca con entrada curva y conexión DN 150 (6")	Hidrante de columna seca con entrada curva profundidad 640 mm y conexión DN  (100-150), con dos (2) salidas de  21/2" (70) y una (1) salida de 4" para uso de (BOMBERO). Todas las salidas equipadas con conexiones rápidas tipo GOST con tapa y cadenilla. Hidrante con drenaje y sistema de rotura. Con una presión máxima de servicio de 16 bar y una presión de prueba de 25 bar. El cuerpo, la columna y el cuerpo de la válvula del hidrante están fabricados en fundición de hierro gris. 	1052.44836	1	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2608	\N	Pararrayo Activo 60 µs	Pararrayos con Dispositivo de Cebado (PDC) 60 µs con Test Local	1055.47205	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2609	\N	Tarjeta Interface VHX-1420-HFS	Tarjeta de Interface conversora de protocolo VESDA a MODBUS (usar con VESDA-HLI-GW o SLC-IM)	1084.16003	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2610	\N	Panel de Incendios SFP-5UDE	Panel de Alarmas contra Incendios Convencional hasta 5 Zonas con Anunciador N-ANN-LED Incluido (220 Volt) Negro	1086.94299	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2611	\N	Panel de Incendios SFP-5UDR	Panel de Alarmas contra Incendios Convencional hasta 5 Zonas con Anunciador N-ANN-LED Incluido (110 Volt) Rojo	1091.71997	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2612	\N	Panel de Incendios SFP-5UDC	Panel de Alarmas contra Incendios Convencional hasta 5 Zonas con Anunciador N-ANN-LED Incluido (110 Volt) Negro	1104.57605	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2613	\N	Supresor para Red de Datos. Cat 6. 5Vdc. 16Ptos	Supresor para Redes Informáticas con Conector RJ-45, 16 Puertos, Montaje en Rack Un: 5 Vdc, Uc: 6 Vdc, IL: 300 mA.  (No usar con CCTV)	1115.31201	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2614	\N	Panel de Incendios SFP-10UDE	Panel de Alarmas contra Incendios Convencional hasta 10 Zonas con Anunciador N-ANN-LED Incluido (220 Volt) Negro	1125.52002	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2615	\N	Panel de Incendios SFP-10UDR	Panel de Alarmas contra Incendios Convencional hasta 10 Zonas con Anunciador N-ANN-LED Incluido (110 Volt) Rojo	1126.59998	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2616	\N	Tarjeta WEB Server NWS-3	Tarjeta Servidor WEB Notifire (Acceso via Web)	1133.95703	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2617	\N	Placa Frontal DIA 6	Placa Frontal, Front Board para AM-6000	1142.96594	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2618	\N	Display LCD6000N	Display remoto retroiluminado, para AM2000N y AM6000N.	1153.98804	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2619	\N	Hidrante de columna seca con entrada recta y conexión DN 100 (4")	Hidrante de columna seca con entrada recta profundidad 640 mm y conexión DN  (100-150), con dos (2) salidas de  21/2" (70) y una (1) salida de 4" para uso de (BOMBERO). Todas las salidas equipadas con conexiones rápidas tipo GOST con tapa y cadenilla. Hidrante con drenaje y sistema de rotura. Con una presión máxima de servicio de 16 bar y una presión de prueba de 25 bar. El cuerpo, la columna y el cuerpo de la válvula del hidrante están fabricados en fundición de hierro gris. 	1158.6344	1	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2620	\N	Gabinete AM-8200-BB Nuevo	Gabinete expansor con fte de alimentacion (110 a 220 Volt) permite el alojamiento de 2 tarjetas LIB8200 expandiendose hasta 8 lazos	1167.03406	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2621	\N	Hidrante de columna húmeda con entrada recta y conexión DN 100 (4")	Hidrante de columna húmeda con entrada recta y conexión DN  (100-150), con dos (2) salidas de  21/2" (70) y una (1) salida de 4" para uso de (BOMBERO). Todas las salidas equipadas con válvulas y conexiones rápidas tipo GOST con tapa y cadenilla. Hidrante sin drenaje y sistema de rotura. Con una presión máxima de servicio de 16 bar y una presión de prueba de 25 bar. El cuerpo, la columna y el cuerpo de la válvula del hidrante están fabricados en fundición de hierro gris. 	1182.58447	1	15		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2622	\N	Fuente ACPS-610	Fuente de Alimentación Auxiliar Direccionable Supervisada (6 Amp) (110 Volt)	1194.68799	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2623	\N	Fuente ACPS-610E	Fuente de Alimentación Auxiliar Direccionable Supervisada (6 Amp) (220 Volt)	1194.68799	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2624	\N	Tarjeta de Red HS-NCM-WSF	Tarjeta Red NFN de Alta Velocidad para PC cableado en Cobre/Fibra MonoModo	1225.83997	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2625	\N	Tarjeta SIB600 OEM	Tarjeta interfase salida serie RSm32 / 485 con protocolo CEI ABI.	1240.10706	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2626	\N	Equipo de Testeo	Equipo de Testeo Local para Pararrayos con Dispositivo de Cebado (PDC)	1298.13196	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2627	\N	Interface LEDSIGN-GW	Tarjeta Interface para Letrero Luminico IP (Soporta hasta OAX2-24V)	1313.83997	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2628	\N	Tarjeta de Red NFN-GW-EM-3	Tarjeta Red NFN Gateway de Alta Velocidad Embebida (Standalone)	1317.80005	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2629	\N	Tarjeta de Red Gateway NFN-GW-PC-HNSF	Tarjeta Red NFN Gateway de Alta Velocidad para PC cableado en Fibra MonoModo	1317.80005	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2630	\N	Tarjeta de Red Gateway NFN-GW-PC-HNMF	Tarjeta Red NFN Gateway de Alta Velocidad para PC cableado en Fibra MultiModo	1317.80005	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2631	\N	Tarjeta de Red Gateway NFN-GW-PC-HNW	Tarjeta Red NFN Gateway de Alta Velocidad para PC cableado en Par de Cobre	1317.80005	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2632	\N	Tarjeta Interface Gateway BACNET-GW-3	Tarjeta Interface Gateway conversora de protocolo MODBUS a BACNET	1318.23999	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2633	\N	Tarjeta Interface Gateway MODBUS-GW 	Tarjeta Interface Gateway conversora de protocolo MODBUS a NOTIFIER SLC	1318.23999	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2634	\N	Tarjeta Interface Gateway VESDA-HLI-GW	Tarjeta Interface Gateway VESDA para integracion de detectores VESDA (Modbus) con NOTIFIER SLC (Conexión remota a la red Noti.Fire.Net) (usar tarjeta VHX-1420-HFS)	1318.23999	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2635	\N	Supresor para Red de Datos. Cat 6. PoE. 24Ptos	Supresor para Redes Informáticas con Conector RJ-45, 24 Puertos, Montaje en Rack Un: 48 Vdc, Uc: 60 Vdc, IL: 100 mA.  (No usar con CCTV)	1330.29602	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2636	\N	Supresor para Red de Datos. Cat 6. 5Vdc. 24Ptos	Supresor para Redes Informáticas con Conector RJ-45, 24 Puertos, Montaje en Rack Un: 5 Vdc, Uc: 6 Vdc, IL: 300 mA.  (No usar con CCTV)	1330.29602	1	8		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2637	\N	Letrero Luminico a Leds MegaDot	Letrero Luminíco con Arreglos de LEDs programables y Mensajes Configurables (120-m30 Vac)	1355.19995	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2638	\N	Letrero OAX2-24V	Letrero Lumínico IP PoE o 24 Volt, con Tecnología LED.	1355.19995	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2639	\N	Tarjeta de Red HS-NCM-WMF	Tarjeta Red NFN de Alta Velocidad para PC cableado en Cobre/Fibra MultiModo	1377.42004	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2640	\N	Interface MNS-CONTROL16	Interfaz para Panel de Incendios para Configuración de 16 Mensajes (para MegaDot)	1386	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2641	\N	Gabinete FIRSTVISION-ENC	Gabienete para Display Interactivo para Bomberos ONYX FirstVision	1410.64001	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2642	\N	Tarjeta de Red HS-NCM-MFSF	Tarjeta Red NFN de Alta Velocidad para PC cableado en Fibra MonoModo/MultiModo	1410.64001	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2643	\N	CPU2 para panel de Incendio NFS2-640	Unidad central de procesamiento con fuente de alimentación integrada para Panel de Alarmas contra Incendios Direccionable NFS2-640 hasta 2 Lazos (110 Volt)	1439.21802	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2644	\N	CPU2 para panel de Incendio NFS2-640E	Unidad central de procesamiento con fuente de alimentación integrada para Panel de Alarmas contra Incendios Direccionable NFS2-640 hasta 2 Lazos hasta 2 Lazos (220 Volt)	1439.21802	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2645	\N	CPU2 para panel de Incendio NFS2-640-SP	Unidad central de procesamiento con fuente de alimentación integrada para Panel de Alarmas contra Incendios Direccionable NFS2-640 hasta 2 Lazos Idioma Español (110 Volt)	1439.21802	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2646	\N	CPU2 para panel de Incendio NFS2-640E-SP	Unidad central de procesamiento con fuente de alimentación integrada para Panel de Alarmas contra Incendios Direccionable NFS2-640 hasta 2 Lazos Idioma Español (220 Volt)	1439.21802	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2647	\N	Panel de Incendios SFP-10UDC	Panel de Alarmas contra Incendios Convencional hasta 10 Zonas con Anunciador N-ANN-LED Incluido (110 Volt) Negro	1509.19995	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2648	\N	CPU para panel de Incendio NFS-320SYS	Unidad central de procesamiento con fuente de alimentación integrada 110 Volt con Dislpay para Panel de Alarmas contra Incendios Direccionable NFS-320 (necesita gabinete y  revestimientos)	1542.85999	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2649	\N	CPU para panel de Incendio NFS-320SYSE	Unidad central de procesamiento con fuente de alimentación integrada 220 Volt con Display para Panel de Alarmas contra Incendios Direccionable NFS-320 (necesita gabinete y  revestimientos)	1542.85999	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2650	\N	Válvula de compuerta extremos ranurados.   10"	Válvula de compuerta extremos ranurados. Material de Hierro dúctil, con ranuras. Acabado pintura roja  aprobaciones FM y  certificados UL para el uso en sistemas automáticos de sprinklers.	1639.28687	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2651	\N	Kit de Control de Acceso DSC MAXSYS MaxKit 	Kit que incluye:                                                                                                                                                            •  Un panel de control PC4020\n•  Un módulo de control de acceso de 2 lectoras PC4820\n•  Una lectora ioProx P225W26\n•  Diez llaves de proximidad de codifcación dual P40KEY ioProx (para Paneles Maxsys)	1688.87402	1	11		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2652	\N	Panel de Incendio NFS-320R	Panel de Alarmas contra Incendios Direccionable de 1 Lazo (Gabinete Rojo Idioma Ingles 110 Volt)	1807.21204	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2653	\N	Panel AM-8200 Nuevo	Panel de Incendio Analógico de 2 Lazos  expandible a 8 Lazos con display tactil y fte de alimentación (110 a 220 Volt), permite alojamiento de 2 tarjeta LIB8200 en el mismo gabinete expandiendose hasta 4 lazos	1922.17297	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2654	\N	Panel de Incendio NFS-320E	Panel de Alarmas contra Incendios Direccionable de 1 Lazo (Gabinete Negro Idioma Ingles 220 Volt)	1927.58496	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2655	\N	Válvula de compuerta extremos ranurados.   12"	Válvula de compuerta extremos ranurados. Material de Hierro dúctil, con ranuras. Acabado pintura roja  aprobaciones FM y  certificados UL para el uso en sistemas automáticos de sprinklers.	1942.74084	1	18		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2656	\N	Panel de Incendio NFS-320	Panel de Alarmas contra Incendios Direccionable de 1 Lazo (Gabinete Negro Idioma Ingles 110 Volt)	2013.31897	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2657	\N	CPU para panel de Incendio NFS2-3030ND	CPU2 para Panel de Incendio Analógico hasta 10 Lazos (Sin Display)	2204.43311	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2658	\N	CPU para panel de Incendio NFS2-3030D-SP	CPU2 para Panel de Incendio Analógico hasta 10 Lazos Idioma Español (Con Display)	2204.43311	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2659	\N	CPU para panel de Incendio NFS2-3030ND-SP	CPU2 para Panel de Incendio Analógico hasta 10 Lazos Idioma Español (Sin Display)	2204.43311	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2660	\N	CPU para panel de Incendio NFS2-3030D	Unidad central de procesamiento con fuente de alimentación integrada 110 Volt con Dislpay para Panel de Alarmas contra Incendios Direccionable NFS2-3030 hasta 10 Lazos (Con Display)	2204.43311	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2661	\N	Panel de Incendio NFS-320CE	Panel de Alarmas contra Incendios Direccionable de 1 Lazo (Gabinete Negro con Posición para Módulo ACM 220 Volt)	2260.92896	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2662	\N	Panel de Incendio NFS-320C	Panel de Alarmas contra Incendios Direccionable de 1 Lazo (Gabinete Negro con Posición para Módulo ACS 110 Volt)	2260.92896	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2663	\N	Panel de Incendio NFS-320CR	Panel de Alarmas contra Incendios Direccionable de 1 Lazo (Gabinete Rojo con Posición para Módulo ACM 110 Volt)	2260.92896	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2664	\N	Panel AM-1000	Panel de Incendio Analógico de 1 Lazos (110 a 220 Volt)	2287.2959	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2665	\N	Panel de Incendio NFS-320-SP	Panel de Alarmas contra Incendios Direccionable de 1 Lazo (Gabinete Negro Idioma Español 110 Volt)	2314.3999	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2666	\N	Panel de Incendio NFS-320-SPE	Panel de Alarmas contra Incendios Direccionable de 1 Lazo (Gabinete Negro Idioma Español 220 Volt)	2314.3999	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2667	\N	Panel de Incendio NFS-320-SPR	Panel de Alarmas contra Incendios Direccionable de 1 Lazo (Gabinete Rojo Idioma Español 110 Volt)	2314.3999	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2668	\N	Tarjeta de Red HS-NCM-SF	Tarjeta Red NFN de Alta Velocidad para PC cableado en Fibra MonoModo	2450.82202	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2669	\N	Tarjeta de Red HS-NCM-MF	Tarjeta Red NFN de Alta Velocidad para PC cableado en Fibra MultiModo	2450.82202	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2670	\N	Pararrayo Activo 60 µs	Pararrayos con Dispositivo de Cebado (PDC) 60 µs con Test Remoto 	2466.79395	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2671	\N	Pararrayo Activo 15 µs	Pararrayos con Dispositivo de Cebado (PDC) 15 µs con Test Remoto 	2661.14111	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2672	\N	Pararrayo Activo 45 µs	Pararrayos con Dispositivo de Cebado (PDC) 45 µs con Test Remoto 	2661.14111	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2673	\N	Panel AM-2000N	Panel de Incendio Analógico de 2 Lazos (110 a 220 Volt)	2790.22705	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2674	\N	Panel AM-6000N	Panel de Incendio Analógico de 2 Lazos (110 a 220 Volt) ampliable hasta 16 lazos mediante tarjetas LIB6000N	2790.22705	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2675	\N	Pararrayo Activo 30 µs	Pararrayos con Dispositivo de Cebado (PDC) 30 µs con Test Remoto 	2865.66724	1	7		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2676	\N	Tarjeta LIB-600	Tarjeta de ampliación de 4 lazos	2928.70605	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2677	\N	Tarjeta LIB-600N	Tarjeta de ampliación de 4 lazos para AM-6000 serie N.	2928.70605	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2678	\N	Sensor de Movimiento OPTEX REDSCAN RLS-3060	Sensor de Movimiento Laser 190° para Montaje en Exterior e Interior IP-66, (Rango de 60m vertical y de 30m horizontal, Arco de Cubrimiento 190°)	3590	1	10		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2679	\N	Tarjeta BE-600A	Mother Board  para AM-6000	3602.5	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2680	\N	Panel AM-6000.4N	Panel de Incendio Analógico de 4 Lazos (110 a 220 Volt) ampliable hasta 16 lazos mediante tarjetas LIB6000N	5063.75098	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2681	\N	Display FIRSTVISION-LCD	Display Interactivo para Bomberos ONYX FirstVision	7392	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2682	\N	Panel AM-6000.8N	Panel de Incendio Analógico de 8 Lazos (110 a 220 Volt) ampliable hasta 16 lazos mediante tarjetas LIB6000N	8164.01318	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2683	\N	Estación de Trabajo ONYXWORKS-WS	Estación de Trabajo  ONYXWorks PC incluye Procesador Intel® i7-4700EQ, 2.4GHz, QM87, 4th Gen, (4 nucleos/8 hilos), 6 MB of Cache, 16 GB of RAM, un SSD de 240 GB, sonido, mouse optico, teclado, puerto Ethernet. Sotware preinstalado y llave de Activación	10780	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2684	\N	Panel AM-6000.12N	Panel de Incendio Analógico de 12 Lazos (110 a 220 Volt) ampliable hasta 16 lazos mediante tarjetas LIB6000N	11160.9297	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2685	\N	Panel AM-6000.16N	Panel de Incendio Analógico de 16 Lazos (110 a 220 Volt) ampliable hasta 16 lazos mediante tarjetas LIB6000N	12986.6328	1	13		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2686	\N	Accesorio TR300	Accesorio Embellecedor para Base B300-6	0	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2687	\N	Estrobo SCWL-CLR-ALERT Nuevo	Estrobo (Blanco) Lente Transparente Alerta Serie L (2 hilos) Montaje en Techo Interior	0	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2688	\N	Kit 10 Bases B210LPBP	Kit de 10 Bases B210LP(A) para detectores de la serie 851	0	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2689	\N	Kit 10 Bases B300-6-BP Nuevo	Kit de 10 Bases B300-6(A) para detectores de la serie 951	0	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2690	\N	Kit 10 Bases/Carcazas Negras BCK-200B	Kit de 10 Bases Negras B210LP(A) y Carcazas Negras para detectores de la serie 851	0	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2691	\N	Kit 10 Bases/Carcazas Negras CK300-BL Nuevo	Kit de 10 Bases Negras B300-6(A) y Carcazas Negras para detectores de la serie 951	0	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
2692	\N	Kit 10 Bases/Carcazas Negras CK300-IR-BL Nuevo	Kit de 10 Bases Negras B300-6(A) y Carcazas Negras para detectores FPTI y FCO  serie 951	0	1	12		\N				2020-05-24 03:18:30.068203	2020-05-24 03:18:30.176498	t	\N
\.


--
-- Data for Name: warranty_time; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.warranty_time (id, label, created_at, updated_at) FROM stdin;
1	1 año a partir de la importación	2020-05-24 03:18:30.243185	2020-05-24 03:18:30.310461
\.


--
-- Name: buy_condition_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.buy_condition_id_seq', 11, true);


--
-- Name: buy_request_711_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.buy_request_711_id_seq', 15, true);


--
-- Name: buy_request_document_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.buy_request_document_id_seq', 286, true);


--
-- Name: buy_request_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.buy_request_id_seq', 49, true);


--
-- Name: buy_request_international_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.buy_request_international_id_seq', 16, true);


--
-- Name: buy_request_provider_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.buy_request_provider_id_seq', 34, true);


--
-- Name: buy_request_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.buy_request_status_id_seq', 5, true);


--
-- Name: buy_request_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.buy_request_type_id_seq', 3, true);


--
-- Name: certificaion_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.certificaion_type_id_seq', 1, true);


--
-- Name: certification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.certification_id_seq', 3, true);


--
-- Name: certification_validated_list_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.certification_validated_list_item_id_seq', 4, true);


--
-- Name: client_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.client_id_seq', 4, true);


--
-- Name: country_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.country_id_seq', 3, true);


--
-- Name: demand_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.demand_id_seq', 42, true);


--
-- Name: demand_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.demand_item_id_seq', 145, true);


--
-- Name: demand_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.demand_status_id_seq', 6, true);


--
-- Name: deployment_part_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.deployment_part_id_seq', 5, true);


--
-- Name: destiny_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.destiny_id_seq', 2, true);


--
-- Name: document_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.document_status_id_seq', 3, true);


--
-- Name: document_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.document_type_id_seq', 18, true);


--
-- Name: document_type_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.document_type_permission_id_seq', 78, true);


--
-- Name: email_notify_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.email_notify_id_seq', 22, true);


--
-- Name: final_destiny_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.final_destiny_id_seq', 2, true);


--
-- Name: log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.log_id_seq', 1517, true);


--
-- Name: offert_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.offert_id_seq', 36, true);


--
-- Name: organism_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.organism_id_seq', 5, true);


--
-- Name: payment_instrument_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payment_instrument_id_seq', 5, true);


--
-- Name: payment_method_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payment_method_id_seq', 7, true);


--
-- Name: provider_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.provider_id_seq', 5, true);


--
-- Name: provider_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.provider_status_id_seq', 4, true);


--
-- Name: provider_validated_list_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.provider_validated_list_id_seq', 135, true);


--
-- Name: province_ueb_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.province_ueb_id_seq', 4, true);


--
-- Name: purchase_reason_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.purchase_reason_id_seq', 4, true);


--
-- Name: request_stage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.request_stage_id_seq', 269, true);


--
-- Name: seller_requirement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seller_requirement_id_seq', 3, true);


--
-- Name: stage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stage_id_seq', 29, true);


--
-- Name: subfamily_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subfamily_id_seq', 19, true);


--
-- Name: um_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.um_id_seq', 4, true);


--
-- Name: user_can_view_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_can_view_id_seq', 70, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 28, true);


--
-- Name: validated_list_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.validated_list_id_seq', 18, true);


--
-- Name: validated_list_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.validated_list_item_id_seq', 2693, true);


--
-- Name: warranty_time_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.warranty_time_id_seq', 1, true);


--
-- Name: auth_assignment auth_assignment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_assignment
    ADD CONSTRAINT auth_assignment_pkey PRIMARY KEY (item_name, user_id);


--
-- Name: auth_item_child auth_item_child_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_item_child
    ADD CONSTRAINT auth_item_child_pkey PRIMARY KEY (parent, child);


--
-- Name: auth_item auth_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_item
    ADD CONSTRAINT auth_item_pkey PRIMARY KEY (name);


--
-- Name: auth_rule auth_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_rule
    ADD CONSTRAINT auth_rule_pkey PRIMARY KEY (name);


--
-- Name: buy_condition buy_condition_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buy_condition
    ADD CONSTRAINT buy_condition_pkey PRIMARY KEY (id);


--
-- Name: buy_request_711 buy_request_711_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buy_request_711
    ADD CONSTRAINT buy_request_711_pkey PRIMARY KEY (id);


--
-- Name: buy_request_document buy_request_document_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buy_request_document
    ADD CONSTRAINT buy_request_document_pkey PRIMARY KEY (id);


--
-- Name: buy_request_international buy_request_international_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buy_request_international
    ADD CONSTRAINT buy_request_international_pkey PRIMARY KEY (id);


--
-- Name: buy_request buy_request_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buy_request
    ADD CONSTRAINT buy_request_pkey PRIMARY KEY (id);


--
-- Name: buy_request_provider buy_request_provider_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buy_request_provider
    ADD CONSTRAINT buy_request_provider_pkey PRIMARY KEY (id);


--
-- Name: buy_request_status buy_request_status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buy_request_status
    ADD CONSTRAINT buy_request_status_pkey PRIMARY KEY (id);


--
-- Name: buy_request_type buy_request_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buy_request_type
    ADD CONSTRAINT buy_request_type_pkey PRIMARY KEY (id);


--
-- Name: certification_type certificaion_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.certification_type
    ADD CONSTRAINT certificaion_type_pkey PRIMARY KEY (id);


--
-- Name: certification certification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.certification
    ADD CONSTRAINT certification_pkey PRIMARY KEY (id);


--
-- Name: certification_validated_list_item certification_validated_list_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.certification_validated_list_item
    ADD CONSTRAINT certification_validated_list_item_pkey PRIMARY KEY (id);


--
-- Name: client client_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (id);


--
-- Name: country country_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_pkey PRIMARY KEY (id);


--
-- Name: demand_item demand_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.demand_item
    ADD CONSTRAINT demand_item_pkey PRIMARY KEY (id);


--
-- Name: demand demand_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.demand
    ADD CONSTRAINT demand_pkey PRIMARY KEY (id);


--
-- Name: demand_status demand_status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.demand_status
    ADD CONSTRAINT demand_status_pkey PRIMARY KEY (id);


--
-- Name: deployment_part deployment_part_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deployment_part
    ADD CONSTRAINT deployment_part_pkey PRIMARY KEY (id);


--
-- Name: destiny destiny_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.destiny
    ADD CONSTRAINT destiny_pkey PRIMARY KEY (id);


--
-- Name: document_status document_status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_status
    ADD CONSTRAINT document_status_pkey PRIMARY KEY (id);


--
-- Name: document_type_permission document_type_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_type_permission
    ADD CONSTRAINT document_type_permission_pkey PRIMARY KEY (id);


--
-- Name: document_type document_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_type
    ADD CONSTRAINT document_type_pkey PRIMARY KEY (id);


--
-- Name: email_notify email_notify_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_notify
    ADD CONSTRAINT email_notify_pkey PRIMARY KEY (id);


--
-- Name: final_destiny final_destiny_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.final_destiny
    ADD CONSTRAINT final_destiny_pkey PRIMARY KEY (id);


--
-- Name: log log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log
    ADD CONSTRAINT log_pkey PRIMARY KEY (id);


--
-- Name: migration migration_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migration
    ADD CONSTRAINT migration_pkey PRIMARY KEY (version);


--
-- Name: offert offert_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offert
    ADD CONSTRAINT offert_pkey PRIMARY KEY (id);


--
-- Name: organism organism_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organism
    ADD CONSTRAINT organism_pkey PRIMARY KEY (id);


--
-- Name: payment_instrument payment_instrument_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_instrument
    ADD CONSTRAINT payment_instrument_pkey PRIMARY KEY (id);


--
-- Name: payment_method payment_method_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_method
    ADD CONSTRAINT payment_method_pkey PRIMARY KEY (id);


--
-- Name: provider provider_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provider
    ADD CONSTRAINT provider_pkey PRIMARY KEY (id);


--
-- Name: provider_status provider_status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provider_status
    ADD CONSTRAINT provider_status_pkey PRIMARY KEY (id);


--
-- Name: provider_validated_list provider_validated_list_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provider_validated_list
    ADD CONSTRAINT provider_validated_list_pkey PRIMARY KEY (id);


--
-- Name: province_ueb province_ueb_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.province_ueb
    ADD CONSTRAINT province_ueb_pkey PRIMARY KEY (id);


--
-- Name: purchase_reason purchase_reason_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_reason
    ADD CONSTRAINT purchase_reason_pkey PRIMARY KEY (id);


--
-- Name: request_stage request_stage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.request_stage
    ADD CONSTRAINT request_stage_pkey PRIMARY KEY (id);


--
-- Name: validated_list_item se; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.validated_list_item
    ADD CONSTRAINT se UNIQUE (seisa_code);


--
-- Name: seller_requirement seller_requirement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seller_requirement
    ADD CONSTRAINT seller_requirement_pkey PRIMARY KEY (id);


--
-- Name: stage stage_order_buy_request_type_id_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stage
    ADD CONSTRAINT stage_order_buy_request_type_id_key1 UNIQUE ("order", buy_request_type_id);


--
-- Name: stage stage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stage
    ADD CONSTRAINT stage_pkey PRIMARY KEY (id);


--
-- Name: subfamily subfamily_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subfamily
    ADD CONSTRAINT subfamily_pkey PRIMARY KEY (id);


--
-- Name: um um_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.um
    ADD CONSTRAINT um_pkey PRIMARY KEY (id);


--
-- Name: user_can_view user_can_view_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_can_view
    ADD CONSTRAINT user_can_view_pkey PRIMARY KEY (id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: validated_list_item validated_list_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.validated_list_item
    ADD CONSTRAINT validated_list_item_pkey PRIMARY KEY (id);


--
-- Name: validated_list validated_list_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.validated_list
    ADD CONSTRAINT validated_list_pkey PRIMARY KEY (id);


--
-- Name: warranty_time warranty_time_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.warranty_time
    ADD CONSTRAINT warranty_time_pkey PRIMARY KEY (id);


--
-- Name: idx-auth_assignment-user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx-auth_assignment-user_id" ON public.auth_assignment USING btree (user_id);


--
-- Name: idx-auth_item-type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx-auth_item-type" ON public.auth_item USING btree (type);


--
-- Name: inform_productos_mas_solicitado_anual _RETURN; Type: RULE; Schema: public; Owner: postgres
--

CREATE OR REPLACE VIEW public.inform_productos_mas_solicitado_anual AS
 SELECT validated_list_item.id,
    validated_list_item.product_name,
    count(validated_list_item.id) AS demandas_solicitadas,
    sum(demand_item.quantity) AS cantidad,
    validated_list_item.price AS precio,
    ((sum(demand_item.quantity))::double precision * validated_list_item.price) AS importe,
    um.label AS um
   FROM (((public.validated_list_item
     JOIN public.demand_item ON ((demand_item.validated_list_item_id = validated_list_item.id)))
     JOIN public.demand ON ((demand_item.demand_id = demand.id)))
     JOIN public.um ON ((validated_list_item.um_id = um.id)))
  WHERE ((demand.sending_date >= (now() - '1 year'::interval)) AND (demand.sending_date <= now()) AND (demand.demand_status_id <> 1))
  GROUP BY validated_list_item.id, validated_list_item.product_name, um.label
  ORDER BY (count(validated_list_item.id)) DESC;


--
-- Name: inform_productos_mas_solicitado_trimestre _RETURN; Type: RULE; Schema: public; Owner: postgres
--

CREATE OR REPLACE VIEW public.inform_productos_mas_solicitado_trimestre AS
 SELECT validated_list_item.id,
    validated_list_item.product_name,
    count(validated_list_item.id) AS demandas_solicitadas,
    sum(demand_item.quantity) AS cantidad,
    validated_list_item.price AS precio,
    ((sum(demand_item.quantity))::double precision * validated_list_item.price) AS importe,
    um.label AS um
   FROM (((public.validated_list_item
     JOIN public.demand_item ON ((demand_item.validated_list_item_id = validated_list_item.id)))
     JOIN public.demand ON ((demand_item.demand_id = demand.id)))
     JOIN public.um ON ((validated_list_item.um_id = um.id)))
  WHERE ((demand.sending_date >= (now() - '3 mons'::interval)) AND (demand.sending_date <= now()) AND (demand.demand_status_id <> 1))
  GROUP BY validated_list_item.id, validated_list_item.product_name, um.label
  ORDER BY (count(validated_list_item.id)) DESC;


--
-- Name: auth_assignment auth_assignment_item_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_assignment
    ADD CONSTRAINT auth_assignment_item_name_fkey FOREIGN KEY (item_name) REFERENCES public.auth_item(name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: auth_item_child auth_item_child_child_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_item_child
    ADD CONSTRAINT auth_item_child_child_fkey FOREIGN KEY (child) REFERENCES public.auth_item(name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: auth_item_child auth_item_child_parent_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_item_child
    ADD CONSTRAINT auth_item_child_parent_fkey FOREIGN KEY (parent) REFERENCES public.auth_item(name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: auth_item auth_item_rule_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_item
    ADD CONSTRAINT auth_item_rule_name_fkey FOREIGN KEY (rule_name) REFERENCES public.auth_rule(name) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: buy_request_711 fk_buy_request_711_buy_request_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buy_request_711
    ADD CONSTRAINT fk_buy_request_711_buy_request_1 FOREIGN KEY (buy_request_id) REFERENCES public.buy_request(id);


--
-- Name: buy_request_711 fk_buy_request_711_final_destiny_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buy_request_711
    ADD CONSTRAINT fk_buy_request_711_final_destiny_1 FOREIGN KEY (final_destiny_id) REFERENCES public.final_destiny(id);


--
-- Name: buy_request fk_buy_request_buy_request_status_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buy_request
    ADD CONSTRAINT fk_buy_request_buy_request_status_1 FOREIGN KEY (buy_request_status_id) REFERENCES public.buy_request_status(id);


--
-- Name: buy_request fk_buy_request_buy_request_type_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buy_request
    ADD CONSTRAINT fk_buy_request_buy_request_type_1 FOREIGN KEY (buy_request_type_id) REFERENCES public.buy_request_type(id);


--
-- Name: buy_request_document fk_buy_request_document_buy_request_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buy_request_document
    ADD CONSTRAINT fk_buy_request_document_buy_request_1 FOREIGN KEY (buy_request_id) REFERENCES public.buy_request(id);


--
-- Name: buy_request_document fk_buy_request_document_document_status_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buy_request_document
    ADD CONSTRAINT fk_buy_request_document_document_status_1 FOREIGN KEY (document_status_id) REFERENCES public.document_status(id);


--
-- Name: buy_request_document fk_buy_request_document_document_type_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buy_request_document
    ADD CONSTRAINT fk_buy_request_document_document_type_1 FOREIGN KEY (document_type_id) REFERENCES public.document_type(id);


--
-- Name: buy_request_document fk_buy_request_document_user_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buy_request_document
    ADD CONSTRAINT fk_buy_request_document_user_1 FOREIGN KEY (last_updated_by) REFERENCES public."user"(id);


--
-- Name: buy_request_international fk_buy_request_international_buy_condition_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buy_request_international
    ADD CONSTRAINT fk_buy_request_international_buy_condition_1 FOREIGN KEY (buy_condition_id) REFERENCES public.buy_condition(id);


--
-- Name: buy_request_international fk_buy_request_international_buy_request_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buy_request_international
    ADD CONSTRAINT fk_buy_request_international_buy_request_1 FOREIGN KEY (buy_request_id) REFERENCES public.buy_request(id);


--
-- Name: buy_request_international fk_buy_request_international_destiny_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buy_request_international
    ADD CONSTRAINT fk_buy_request_international_destiny_1 FOREIGN KEY (destiny_id) REFERENCES public.destiny(id);


--
-- Name: buy_request_international fk_buy_request_international_payment_instrument_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buy_request_international
    ADD CONSTRAINT fk_buy_request_international_payment_instrument_1 FOREIGN KEY (payment_instrument_id) REFERENCES public.payment_instrument(id);


--
-- Name: buy_request_provider fk_buy_request_provider_buy_request_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buy_request_provider
    ADD CONSTRAINT fk_buy_request_provider_buy_request_1 FOREIGN KEY (buy_request_id) REFERENCES public.buy_request(id);


--
-- Name: buy_request_provider fk_buy_request_provider_provider_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buy_request_provider
    ADD CONSTRAINT fk_buy_request_provider_provider_1 FOREIGN KEY (provider_id) REFERENCES public.provider(id);


--
-- Name: buy_request_provider fk_buy_request_provider_provider_status_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buy_request_provider
    ADD CONSTRAINT fk_buy_request_provider_provider_status_1 FOREIGN KEY (provider_status_id) REFERENCES public.provider_status(id);


--
-- Name: buy_request fk_buy_request_user_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buy_request
    ADD CONSTRAINT fk_buy_request_user_1 FOREIGN KEY (created_by) REFERENCES public."user"(id);


--
-- Name: buy_request fk_buy_request_user_2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buy_request
    ADD CONSTRAINT fk_buy_request_user_2 FOREIGN KEY (approved_by) REFERENCES public."user"(id);


--
-- Name: buy_request fk_buy_request_user_3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buy_request
    ADD CONSTRAINT fk_buy_request_user_3 FOREIGN KEY (buyer_assigned) REFERENCES public."user"(id);


--
-- Name: buy_request fk_buy_request_user_4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buy_request
    ADD CONSTRAINT fk_buy_request_user_4 FOREIGN KEY (buy_approved_by) REFERENCES public."user"(id);


--
-- Name: buy_request fk_buy_request_user_5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buy_request
    ADD CONSTRAINT fk_buy_request_user_5 FOREIGN KEY (dt_specialist_assigned) REFERENCES public."user"(id);


--
-- Name: buy_request fk_buy_request_user_6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buy_request
    ADD CONSTRAINT fk_buy_request_user_6 FOREIGN KEY (dt_approved_by) REFERENCES public."user"(id);


--
-- Name: certification fk_certification_certificaion_type_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.certification
    ADD CONSTRAINT fk_certification_certificaion_type_1 FOREIGN KEY (certification_type_id) REFERENCES public.certification_type(id);


--
-- Name: certification_validated_list_item fk_certification_validated_list_item_certification_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.certification_validated_list_item
    ADD CONSTRAINT fk_certification_validated_list_item_certification_1 FOREIGN KEY (certification_id) REFERENCES public.certification(id);


--
-- Name: certification_validated_list_item fk_certification_validated_list_item_validated_list_item_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.certification_validated_list_item
    ADD CONSTRAINT fk_certification_validated_list_item_validated_list_item_1 FOREIGN KEY (validated_list_item_id) REFERENCES public.validated_list_item(id);


--
-- Name: client fk_client_organism_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT fk_client_organism_1 FOREIGN KEY (organism_id) REFERENCES public.organism(id);


--
-- Name: client fk_client_province_ueb_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT fk_client_province_ueb_1 FOREIGN KEY (province_ueb) REFERENCES public.province_ueb(id);


--
-- Name: demand fk_demand_client_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.demand
    ADD CONSTRAINT fk_demand_client_1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: demand fk_demand_demand_status_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.demand
    ADD CONSTRAINT fk_demand_demand_status_1 FOREIGN KEY (demand_status_id) REFERENCES public.demand_status(id);


--
-- Name: demand fk_demand_deployment_part_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.demand
    ADD CONSTRAINT fk_demand_deployment_part_1 FOREIGN KEY (deployment_part_id) REFERENCES public.deployment_part(id);


--
-- Name: demand_item fk_demand_item_buy_request_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.demand_item
    ADD CONSTRAINT fk_demand_item_buy_request_1 FOREIGN KEY (buy_request_id) REFERENCES public.buy_request(id);


--
-- Name: demand_item fk_demand_item_demand_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.demand_item
    ADD CONSTRAINT fk_demand_item_demand_1 FOREIGN KEY (demand_id) REFERENCES public.demand(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: demand_item fk_demand_item_validated_list_item_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.demand_item
    ADD CONSTRAINT fk_demand_item_validated_list_item_1 FOREIGN KEY (validated_list_item_id) REFERENCES public.validated_list_item(id);


--
-- Name: demand fk_demand_payment_method_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.demand
    ADD CONSTRAINT fk_demand_payment_method_1 FOREIGN KEY (payment_method_id) REFERENCES public.payment_method(id);


--
-- Name: demand fk_demand_purchase_reason_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.demand
    ADD CONSTRAINT fk_demand_purchase_reason_1 FOREIGN KEY (purchase_reason_id) REFERENCES public.purchase_reason(id);


--
-- Name: demand fk_demand_seller_requirement_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.demand
    ADD CONSTRAINT fk_demand_seller_requirement_1 FOREIGN KEY (seller_requirement_id) REFERENCES public.seller_requirement(id);


--
-- Name: demand fk_demand_user_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.demand
    ADD CONSTRAINT fk_demand_user_1 FOREIGN KEY (created_by) REFERENCES public."user"(id);


--
-- Name: demand fk_demand_user_2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.demand
    ADD CONSTRAINT fk_demand_user_2 FOREIGN KEY (approved_by) REFERENCES public."user"(id);


--
-- Name: demand fk_demand_validated_list_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.demand
    ADD CONSTRAINT fk_demand_validated_list_1 FOREIGN KEY (validated_list_id) REFERENCES public.validated_list(id);


--
-- Name: demand fk_demand_warranty_time_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.demand
    ADD CONSTRAINT fk_demand_warranty_time_1 FOREIGN KEY (waranty_time_id) REFERENCES public.warranty_time(id);


--
-- Name: document_type fk_document_type_buy_request_type_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_type
    ADD CONSTRAINT fk_document_type_buy_request_type_1 FOREIGN KEY (buy_request_type_id) REFERENCES public.buy_request_type(id);


--
-- Name: document_type_permission fk_document_type_permission_document_type_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_type_permission
    ADD CONSTRAINT fk_document_type_permission_document_type_1 FOREIGN KEY (document_type_id) REFERENCES public.document_type(id);


--
-- Name: document_type_permission fk_document_type_permission_user_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_type_permission
    ADD CONSTRAINT fk_document_type_permission_user_1 FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: email_notify fk_email_notify_buy_request_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_notify
    ADD CONSTRAINT fk_email_notify_buy_request_1 FOREIGN KEY (buy_request_id) REFERENCES public.buy_request(id);


--
-- Name: log fk_log_user_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log
    ADD CONSTRAINT fk_log_user_1 FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: offert fk_offert_buy_request_provider_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offert
    ADD CONSTRAINT fk_offert_buy_request_provider_1 FOREIGN KEY (buy_request_provider_id) REFERENCES public.buy_request_provider(id);


--
-- Name: offert fk_offert_user_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offert
    ADD CONSTRAINT fk_offert_user_1 FOREIGN KEY (upload_by) REFERENCES public."user"(id);


--
-- Name: offert fk_offert_user_2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offert
    ADD CONSTRAINT fk_offert_user_2 FOREIGN KEY (evaluated_by) REFERENCES public."user"(id);


--
-- Name: provider fk_provider_buy_request_type_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provider
    ADD CONSTRAINT fk_provider_buy_request_type_1 FOREIGN KEY (buy_request_type_id) REFERENCES public.buy_request_type(id);


--
-- Name: provider fk_provider_country_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provider
    ADD CONSTRAINT fk_provider_country_1 FOREIGN KEY (country_id) REFERENCES public.country(id);


--
-- Name: provider_validated_list fk_provider_validated_list_provider_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provider_validated_list
    ADD CONSTRAINT fk_provider_validated_list_provider_1 FOREIGN KEY (provider_id) REFERENCES public.provider(id);


--
-- Name: provider_validated_list fk_provider_validated_list_validated_list_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provider_validated_list
    ADD CONSTRAINT fk_provider_validated_list_validated_list_1 FOREIGN KEY (validated_list_id) REFERENCES public.validated_list(id);


--
-- Name: request_stage fk_request_stage_buy_request_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.request_stage
    ADD CONSTRAINT fk_request_stage_buy_request_1 FOREIGN KEY (buy_request_id) REFERENCES public.buy_request(id);


--
-- Name: request_stage fk_request_stage_stage_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.request_stage
    ADD CONSTRAINT fk_request_stage_stage_1 FOREIGN KEY (stage_id) REFERENCES public.stage(id);


--
-- Name: stage fk_stage_buy_request_type_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stage
    ADD CONSTRAINT fk_stage_buy_request_type_1 FOREIGN KEY (buy_request_type_id) REFERENCES public.buy_request_type(id);


--
-- Name: subfamily fk_subfamily_validated_list_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subfamily
    ADD CONSTRAINT fk_subfamily_validated_list_1 FOREIGN KEY (validated_list_id) REFERENCES public.validated_list(id);


--
-- Name: user_can_view fk_user_can_view_buy_request_type_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_can_view
    ADD CONSTRAINT fk_user_can_view_buy_request_type_1 FOREIGN KEY (buy_request_type_id) REFERENCES public.buy_request_type(id);


--
-- Name: user_can_view fk_user_can_view_user_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_can_view
    ADD CONSTRAINT fk_user_can_view_user_1 FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: user fk_user_province_ueb_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT fk_user_province_ueb_1 FOREIGN KEY (province_ueb) REFERENCES public.province_ueb(id);


--
-- Name: validated_list_item fk_validated_list_item_um_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.validated_list_item
    ADD CONSTRAINT fk_validated_list_item_um_1 FOREIGN KEY (um_id) REFERENCES public.um(id);


--
-- Name: validated_list_item fk_validated_list_item_validated_list_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.validated_list_item
    ADD CONSTRAINT fk_validated_list_item_validated_list_1 FOREIGN KEY (validated_list_id) REFERENCES public.validated_list(id);


--
-- PostgreSQL database dump complete
--

