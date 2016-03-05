DROP SEQUENCE IF EXISTS vibi_fid_test_seq;
DROP SEQUENCE IF EXISTS vibi_ground_cover_fid_test_seq;
DROP SEQUENCE IF EXISTS vibi_woody_fid_test_seq;

DROP TRIGGER IF EXISTS vibi_plot_info_insert_trigger ON vibi_intensive;
DROP TRIGGER IF EXISTS vibi_herb_modules_insert_trigger ON plot;
DROP TRIGGER IF EXISTS vibi_woody_modules_insert_trigger ON vibi_woody;

CREATE SEQUENCE vibi_fid_test_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 204
  CACHE 1;
  
 CREATE SEQUENCE vibi_ground_cover_fid_test_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 11
  CACHE 1;
  
  CREATE SEQUENCE vibi_woody_fid_test_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

ALTER TABLE plot_module_herbaceous ALTER COLUMN fid SET DEFAULT to_char(nextval('vibi_fid_test_seq'::regclass),'"vibi"fm000000');
ALTER TABLE plot_module_herbaceous_info ALTER COLUMN fid SET DEFAULT to_char(nextval('vibi_ground_cover_fid_test_seq'::regclass),'"vibi"fm000000');
ALTER TABLE plot_module_woody_raw ALTER COLUMN fid SET DEFAULT to_char(nextval('vibi_woody_fid_test_seq'::regclass),'"woody"fm000000');

CREATE OR REPLACE FUNCTION vibi_plot_info_insert()
  RETURNS trigger AS
$BODY$
BEGIN

INSERT INTO plot (plot_no, project_name, plot_name, plot_label, monitoring_event, datetimer, party, plot_not_sampled, commentplot_not_sampled, sampling_quality, tax_accuracy_vascular, tax_accuracy_bryophytes, tax_accuracy_lichens, authority, state, county, quadrangle, local_place_name, landowner, xaxis_bearing_of_plot, enter_gps_location_in_plot, latitude, longitude, total_modules, intensive_modules, plot_configuration, plot_size_for_cover_data_area_ha, estimate_of_per_open_water_entire_site, estimate_of_perunvegetated_ow_entire_site, estimate_per_invasives_entire_site, centerline, oneo_plant, vegclass, vegsubclass, twoo_plant, hgmclass, hgmsubclass, twoo_hgm, oneo_class_code_mod_natureserve, landform_type, homogeneity, stand_size, drainage, salinity, hydrologic_regime, oneo_disturbance_type, oneo_disturbance_severity, oneo_disturbance_years_ago, oneo_distubance_per_of_plot, oneo_disturbance_description, twoo_disturbance_type, twoo_disturbance_severity, twoo_disturbance_years_ago, twoo_distubance_per_of_plot, twoo_disturbance_description, threeo_disturbance_type, threeo_disturbance_severity, threeo_disturbance_years_ago, threeo_distubance_per_of_plot, threeo_disturbance_description) SELECT plot_no, project_name, project_name_other, plot_label, monitoring_event, date::timestamp with time zone, party, plot_not_sampled, commentplot_not_sampled, sampling_quality, tax_accuracy_vascular, tax_accuracy_bryophytes, tax_accuracy_lichens, authority, state, county, quadrangle, local_place_name, landowner, xaxis_bearing_of_plot::integer, enter_gps_location_in_plot, latitude_1::numeric, longitude_1::numeric, total_modules::integer, intensive_modules::integer, plot_configuration, plot_size_area_in_hectares::numeric, estimate_of_per_open_water_entire_site::numeric, estimate_of_perunvegetated_ow_entire_site::numeric, estimate_per_invasives_entire_site::numeric, centerline::numeric, oneo_plant, vegclass, vegsubclass, twoo_plant, hgmclass, hgmsubclass, twoo_hgm, oneo_class_code_mod_natureserve, landform_type, homogeneity, stand_size, drainage, salinity, hydrologic_regime, oneo_disturbance_type, oneo_disturbance_severity, oneo_disturbance_years_ago::integer, oneo_distubance_per_of_plot::integer, oneo_disturbance_description, twoo_disturbance_type, twoo_disturbance_severity, twoo_disturbance_years_ago::integer, twoo_distubance_per_of_plot::integer, twoo_disturbance_description, threeo_disturbance_type, threeo_disturbance_severity, threeo_disturbance_years_ago::integer, threeo_distubance_per_of_plot::integer, threeo_disturbance_description FROM  vibi_intensive
WHERE NOT EXISTS
(
	SELECT 1 FROM plot WHERE plot_no = vibi_intensive.plot_no
	);

RETURN NEW;
END $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION vibi_plot_info_insert()
  OWNER TO postgres;

CREATE TRIGGER vibi_plot_info_insert_trigger AFTER INSERT ON vibi_intensive FOR EACH STATEMENT EXECUTE PROCEDURE vibi_plot_info_insert();  

CREATE OR REPLACE FUNCTION vibi_herb_modules_insert()
  RETURNS trigger AS
$BODY$
BEGIN
	
	WITH vibi_fulcrum_joined_new_records AS (SELECT * FROM vibi_fulcrum_joined WHERE NOT EXISTS
(
	SELECT 1 FROM plot_module_herbaceous WHERE plot_no = vibi_fulcrum_joined.plot_no
	)),
	
	vibi_fulcrum_woody_joined_new_records AS (SELECT * FROM vibi_fulcrum_woody_joined WHERE NOT EXISTS
(
	SELECT 1 FROM plot_module_woody_raw WHERE plot_no = vibi_fulcrum_woody_joined.plot_no
	)),
	
ins1 AS (INSERT INTO plot_module_herbaceous (plot_no, module_id, corner, depth, species, cover_class_code) SELECT plot_no, herbaceous_module::integer, 

CASE WHEN corner_1_depth IS NOT NULL THEN 1
ELSE NULL
END 
AS corner, corner_1_depth::integer,

herbaceous_species, cover_code::integer 

FROM vibi_fulcrum_joined_new_records WHERE corner_1_depth IS NOT NULL),

	
ins2 AS (INSERT INTO plot_module_herbaceous (plot_no, module_id, corner, depth, species, cover_class_code) SELECT plot_no, herbaceous_module::integer, 

CASE WHEN corner_2_depth IS NOT NULL THEN 2
ELSE NULL
END 
AS corner, corner_2_depth::integer,

herbaceous_species, cover_code::integer 

FROM vibi_fulcrum_joined_new_records WHERE corner_2_depth IS NOT NULL),

ins3 AS (INSERT INTO plot_module_herbaceous (plot_no, module_id, corner, depth, species, cover_class_code) SELECT plot_no, herbaceous_module::integer, 

CASE WHEN corner_3_depth IS NOT NULL THEN 3
ELSE NULL
END 
AS corner, corner_3_depth::integer,

herbaceous_species, cover_code::integer 

FROM vibi_fulcrum_joined_new_records WHERE corner_3_depth IS NOT NULL),


ins4 AS (INSERT INTO plot_module_herbaceous (plot_no, module_id, corner, depth, species, cover_class_code) SELECT plot_no, herbaceous_module::integer, 

CASE WHEN corner_4_depth IS NOT NULL THEN 4
ELSE NULL
END 
AS corner, corner_4_depth::integer,

herbaceous_species, cover_code::integer 

FROM vibi_fulcrum_joined_new_records WHERE  corner_4_depth IS NOT NULL),


ins5 AS (INSERT INTO plot_module_herbaceous_info (plot_no, module_id, corner, depth, info, cover_class_code) SELECT plot_no, herbaceous_module::integer,
NULL::integer AS corner, 1::integer AS depth, 

CASE WHEN  bare_ground_cover IS NOT NULL THEN 'bare ground cover'
ELSE NULL
END
AS info, bare_ground_cover::integer FROM vibi_fulcrum_joined_new_records WHERE NOT EXISTS
(
	SELECT 1 FROM plot_module_herbaceous_info WHERE plot_no = vibi_fulcrum_joined_new_records.plot_no
	) GROUP BY plot_no, herbaceous_module, corner, depth, bare_ground_cover),
	
	
ins6 AS (INSERT INTO plot_module_herbaceous_info (plot_no, module_id, corner, depth, info, cover_class_code) SELECT plot_no, herbaceous_module::integer,
NULL::integer AS corner, 1::integer AS depth,

CASE WHEN  litter_cover IS NOT NULL THEN 'litter cover'
ELSE NULL
END
AS info, litter_cover::integer FROM vibi_fulcrum_joined_new_records WHERE NOT EXISTS
(
	SELECT 1 FROM plot_module_herbaceous_info WHERE plot_no = vibi_fulcrum_joined_new_records.plot_no
	) GROUP BY plot_no, herbaceous_module, corner, depth, litter_cover),
	
	
ins7 AS (INSERT INTO plot_module_herbaceous_info (plot_no, module_id, corner, depth, info, cover_class_code) SELECT plot_no, herbaceous_module::integer,
NULL::integer AS corner, 1::integer AS depth,

CASE WHEN  open_water_cover IS NOT NULL THEN 'open water cover'
ELSE NULL
END
AS info, open_water_cover::integer FROM vibi_fulcrum_joined_new_records WHERE NOT EXISTS
(
	SELECT 1 FROM plot_module_herbaceous_info WHERE plot_no = vibi_fulcrum_joined_new_records.plot_no
	) GROUP BY plot_no, herbaceous_module, corner, depth, open_water_cover)
	

INSERT INTO plot_module_herbaceous_info (plot_no, module_id, corner, depth, info, cover_class_code) SELECT plot_no, herbaceous_module::integer,
NULL::integer AS corner, 1::integer AS depth,

CASE WHEN  unvegetated_open_water_cover IS NOT NULL THEN 'unvegetated open water cover'
ELSE NULL
END
AS info, unvegetated_open_water_cover::integer FROM vibi_fulcrum_joined_new_records WHERE NOT EXISTS
(
	SELECT 1 FROM plot_module_herbaceous_info WHERE plot_no = vibi_fulcrum_joined_new_records.plot_no
	) GROUP BY plot_no, herbaceous_module, corner, depth, unvegetated_open_water_cover
	
;
	
RETURN NEW;
END $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION vibi_herb_modules_insert()
  OWNER TO postgres;
  
 CREATE TRIGGER vibi_herb_modules_insert_trigger AFTER INSERT ON plot FOR EACH STATEMENT EXECUTE PROCEDURE vibi_herb_modules_insert();

CREATE OR REPLACE FUNCTION vibi_woody_modules_insert()
  RETURNS trigger AS
$BODY$
BEGIN

	WITH vibi_fulcrum_woody_joined_new_records AS (SELECT * FROM vibi_fulcrum_woody_joined WHERE NOT EXISTS
(
	SELECT 1 FROM plot_module_woody_raw WHERE plot_no = vibi_fulcrum_woody_joined.plot_no
	)),

ins1 AS (INSERT INTO plot_module_woody_raw (plot_no, module_id, species, dbh_class, dbh_class_index, count) SELECT plot_no, module_number::integer AS module_id,
woody_species,

CASE WHEN  'shrub_clump_count' IS NOT NULL THEN 'shrub clump'
ELSE NULL
END
AS dbh_class, 

CASE WHEN 'shrub_clump_count' IS NOT NULL THEN 0 
ELSE NULL
END
AS dbh_class_index, "shrub_clump_count" AS count

FROM vibi_fulcrum_woody_joined_new_records WHERE NOT EXISTS
(
	SELECT 1 FROM plot_module_woody_raw WHERE plot_no = vibi_fulcrum_woody_joined_new_records.plot_no AND species = vibi_fulcrum_woody_joined_new_records.woody_species AND module_id = vibi_fulcrum_woody_joined_new_records.module_number::integer
	AND dbh_class = 'shrub clump') AND shrub_clump_count IS NOT NULL),
	

	
ins2 AS (INSERT INTO plot_module_woody_raw (plot_no, module_id, species, dbh_class, dbh_class_index, count) SELECT plot_no, module_number::integer AS module_id,
woody_species,

CASE WHEN  '0_1cm_count' IS NOT NULL THEN '0-<1cm'
ELSE NULL
END
AS dbh_class, 

CASE WHEN '0_1cm_count' IS NOT NULL THEN 1 
ELSE NULL
END
AS dbh_class_index, "0_1cm_count" AS count

FROM vibi_fulcrum_woody_joined_new_records WHERE NOT EXISTS
(
	SELECT 1 FROM plot_module_woody_raw WHERE plot_no = vibi_fulcrum_woody_joined_new_records.plot_no AND species = vibi_fulcrum_woody_joined_new_records.woody_species AND module_id = vibi_fulcrum_woody_joined_new_records.module_number::integer
	AND dbh_class = '0-<1cm') AND "0_1cm_count" IS NOT NULL),
	
ins3 AS (INSERT INTO plot_module_woody_raw (plot_no, module_id, species, dbh_class, dbh_class_index, count) SELECT plot_no, module_number::integer AS module_id,
woody_species,

CASE WHEN  '1_25cm_count' IS NOT NULL THEN '1-<2.5cm'
ELSE NULL
END
AS dbh_class, 

CASE WHEN '1_25cm_count' IS NOT NULL THEN 2 
ELSE NULL
END
AS dbh_class_index, "1_25cm_count" AS count

FROM vibi_fulcrum_woody_joined_new_records WHERE NOT EXISTS
(
	SELECT 1 FROM plot_module_woody_raw WHERE plot_no = vibi_fulcrum_woody_joined_new_records.plot_no AND species = vibi_fulcrum_woody_joined_new_records.woody_species AND module_id = vibi_fulcrum_woody_joined_new_records.module_number::integer
	AND dbh_class = '1-<2.5cm') AND "1_25cm_count" IS NOT NULL),
	
ins4 AS (INSERT INTO plot_module_woody_raw (plot_no, module_id, species, dbh_class, dbh_class_index, count) SELECT plot_no, module_number::integer AS module_id,
woody_species,

CASE WHEN  '25_5cm_count' IS NOT NULL THEN '2.5-<5cm'
ELSE NULL
END
AS dbh_class, 

CASE WHEN '25_5cm_count' IS NOT NULL THEN 3 
ELSE NULL
END
AS dbh_class_index, "25_5cm_count" AS count

FROM vibi_fulcrum_woody_joined_new_records WHERE NOT EXISTS
(
	SELECT 1 FROM plot_module_woody_raw WHERE plot_no = vibi_fulcrum_woody_joined_new_records.plot_no AND species = vibi_fulcrum_woody_joined_new_records.woody_species AND module_id = vibi_fulcrum_woody_joined_new_records.module_number::integer
	AND dbh_class = '2.5-<5cm') AND "25_5cm_count" IS NOT NULL),
	
ins5 AS (INSERT INTO plot_module_woody_raw (plot_no, module_id, species, dbh_class, dbh_class_index, count) SELECT plot_no, module_number::integer AS module_id,
woody_species,

CASE WHEN  '5_10cm_count' IS NOT NULL THEN '5-<10cm'
ELSE NULL
END
AS dbh_class, 

CASE WHEN '5_10cm_count' IS NOT NULL THEN 4 
ELSE NULL
END
AS dbh_class_index, "5_10cm_count" AS count

FROM vibi_fulcrum_woody_joined_new_records WHERE NOT EXISTS
(
	SELECT 1 FROM plot_module_woody_raw WHERE plot_no = vibi_fulcrum_woody_joined_new_records.plot_no AND species = vibi_fulcrum_woody_joined_new_records.woody_species AND module_id = vibi_fulcrum_woody_joined_new_records.module_number::integer
	AND dbh_class = '5-<10cm') AND "5_10cm_count" IS NOT NULL),
	
ins6 AS (INSERT INTO plot_module_woody_raw (plot_no, module_id, species, dbh_class, dbh_class_index, count) SELECT plot_no, module_number::integer AS module_id,
woody_species,

CASE WHEN  '10_15cm_count' IS NOT NULL THEN '10-<15cm'
ELSE NULL
END
AS dbh_class, 

CASE WHEN '10_15cm_count' IS NOT NULL THEN 5 
ELSE NULL
END
AS dbh_class_index, "10_15cm_count" AS count

FROM vibi_fulcrum_woody_joined_new_records WHERE NOT EXISTS
(
	SELECT 1 FROM plot_module_woody_raw WHERE plot_no = vibi_fulcrum_woody_joined_new_records.plot_no AND species = vibi_fulcrum_woody_joined_new_records.woody_species AND module_id = vibi_fulcrum_woody_joined_new_records.module_number::integer
	AND dbh_class = '10-<15cm') AND "10_15cm_count" IS NOT NULL),
	
ins7 AS (INSERT INTO plot_module_woody_raw (plot_no, module_id, species, dbh_class, dbh_class_index, count) SELECT plot_no, module_number::integer AS module_id,
woody_species,

CASE WHEN  '15_20cm_count' IS NOT NULL THEN '15-<20cm'
ELSE NULL
END
AS dbh_class, 

CASE WHEN '15_20cm_count' IS NOT NULL THEN 6 
ELSE NULL
END
AS dbh_class_index, "15_20cm_count" AS count

FROM vibi_fulcrum_woody_joined_new_records WHERE NOT EXISTS
(
	SELECT 1 FROM plot_module_woody_raw WHERE plot_no = vibi_fulcrum_woody_joined_new_records.plot_no AND species = vibi_fulcrum_woody_joined_new_records.woody_species AND module_id = vibi_fulcrum_woody_joined_new_records.module_number::integer
	AND dbh_class = '15<20cm') AND "15_20cm_count" IS NOT NULL),
	
ins8 AS (INSERT INTO plot_module_woody_raw (plot_no, module_id, species, dbh_class, dbh_class_index, count) SELECT plot_no, module_number::integer AS module_id,
woody_species,

CASE WHEN  '20_25cm_count' IS NOT NULL THEN '20-<25cm'
ELSE NULL
END
AS dbh_class, 

CASE WHEN '20_25cm_count' IS NOT NULL THEN 7 
ELSE NULL
END
AS dbh_class_index, "20_25cm_count" AS count

FROM vibi_fulcrum_woody_joined_new_records WHERE NOT EXISTS
(
	SELECT 1 FROM plot_module_woody_raw WHERE plot_no = vibi_fulcrum_woody_joined_new_records.plot_no AND species = vibi_fulcrum_woody_joined_new_records.woody_species AND module_id = vibi_fulcrum_woody_joined_new_records.module_number::integer
	AND dbh_class = '20-<25cm') AND "20_25cm_count" IS NOT NULL),
	
ins9 AS (INSERT INTO plot_module_woody_raw (plot_no, module_id, species, dbh_class, dbh_class_index, count) SELECT plot_no, module_number::integer AS module_id,
woody_species,

CASE WHEN  '25_30cm_count' IS NOT NULL THEN '25-<30cm'
ELSE NULL
END
AS dbh_class, 

CASE WHEN '25_30cm_count' IS NOT NULL THEN 8 
ELSE NULL
END
AS dbh_class_index, "25_30cm_count" AS count

FROM vibi_fulcrum_woody_joined_new_records WHERE NOT EXISTS
(
	SELECT 1 FROM plot_module_woody_raw WHERE plot_no = vibi_fulcrum_woody_joined_new_records.plot_no AND species = vibi_fulcrum_woody_joined_new_records.woody_species AND module_id = vibi_fulcrum_woody_joined_new_records.module_number::integer
	AND dbh_class = '25-<30cm') AND "25_30cm_count" IS NOT NULL),
	
ins10 AS (INSERT INTO plot_module_woody_raw (plot_no, module_id, species, dbh_class, dbh_class_index, count) SELECT plot_no, module_number::integer AS module_id,
woody_species,

CASE WHEN  '30_35cm_count' IS NOT NULL THEN '25-<30cm'
ELSE NULL
END
AS dbh_class, 

CASE WHEN '30_35cm_count' IS NOT NULL THEN 9 
ELSE NULL
END
AS dbh_class_index, "30_35cm_count" AS count

FROM vibi_fulcrum_woody_joined_new_records WHERE NOT EXISTS
(
	SELECT 1 FROM plot_module_woody_raw WHERE plot_no = vibi_fulcrum_woody_joined_new_records.plot_no AND species = vibi_fulcrum_woody_joined_new_records.woody_species AND module_id = vibi_fulcrum_woody_joined_new_records.module_number::integer
	AND dbh_class = '25-<30cm') AND "30_35cm_count" IS NOT NULL),
	
ins11 AS (INSERT INTO plot_module_woody_raw (plot_no, module_id, species, dbh_class, dbh_class_index, count) SELECT plot_no, module_number::integer AS module_id,
woody_species,

CASE WHEN  '35_40cm_count' IS NOT NULL THEN '35-<40cm'
ELSE NULL
END
AS dbh_class, 

CASE WHEN '35_40cm_count' IS NOT NULL THEN 10
ELSE NULL
END
AS dbh_class_index, "35_40cm_count" AS count

FROM vibi_fulcrum_woody_joined_new_records WHERE NOT EXISTS
(
	SELECT 1 FROM plot_module_woody_raw WHERE plot_no = vibi_fulcrum_woody_joined_new_records.plot_no AND species = vibi_fulcrum_woody_joined_new_records.woody_species AND module_id = vibi_fulcrum_woody_joined_new_records.module_number::integer
	AND dbh_class = '35-<40cm') AND "35_40cm_count" IS NOT NULL),
	
ins12 AS (INSERT INTO plot_module_woody_raw (plot_no, module_id, species, dbh_class, dbh_class_index, count) SELECT plot_no, module_number::integer AS module_id,
woody_species,

CASE WHEN  '40cm_dbh1' IS NOT NULL THEN '>40cm'
ELSE NULL
END
AS dbh_class, 

CASE WHEN '40cm_dbh1' IS NOT NULL THEN 11
ELSE NULL
END
AS dbh_class_index, "40cm_dbh1" AS count

FROM vibi_fulcrum_woody_joined_new_records WHERE NOT EXISTS
(
	SELECT 1 FROM plot_module_woody_raw WHERE plot_no = vibi_fulcrum_woody_joined_new_records.plot_no AND species = vibi_fulcrum_woody_joined_new_records.woody_species AND module_id = vibi_fulcrum_woody_joined_new_records.module_number::integer
	AND dbh_class = '>40cm') AND "40cm_dbh1" IS NOT NULL),
	
ins13 AS (INSERT INTO plot_module_woody_raw (plot_no, module_id, species, dbh_class, dbh_class_index, count) SELECT plot_no, module_number::integer AS module_id,
woody_species,

CASE WHEN  '40cm_dbh2' IS NOT NULL THEN '>40cm'
ELSE NULL
END
AS dbh_class, 

CASE WHEN '40cm_dbh2' IS NOT NULL THEN 12
ELSE NULL
END
AS dbh_class_index, "40cm_dbh2" AS count

FROM vibi_fulcrum_woody_joined_new_records WHERE NOT EXISTS
(
	SELECT 1 FROM plot_module_woody_raw WHERE plot_no = vibi_fulcrum_woody_joined_new_records.plot_no AND species = vibi_fulcrum_woody_joined_new_records.woody_species AND module_id = vibi_fulcrum_woody_joined_new_records.module_number::integer
	AND dbh_class = '>40cm') AND "40cm_dbh2" IS NOT NULL),
	
ins14 AS (INSERT INTO plot_module_woody_raw (plot_no, module_id, species, dbh_class, dbh_class_index, count) SELECT plot_no, module_number::integer AS module_id,
woody_species,

CASE WHEN  '40cm_dbh3' IS NOT NULL THEN '>40cm'
ELSE NULL
END
AS dbh_class, 

CASE WHEN '40cm_dbh3' IS NOT NULL THEN 13
ELSE NULL
END
AS dbh_class_index, "40cm_dbh3" AS count

FROM vibi_fulcrum_woody_joined_new_records WHERE NOT EXISTS
(
	SELECT 1 FROM plot_module_woody_raw WHERE plot_no = vibi_fulcrum_woody_joined_new_records.plot_no AND species = vibi_fulcrum_woody_joined_new_records.woody_species AND module_id = vibi_fulcrum_woody_joined_new_records.module_number::integer
	AND dbh_class = '>40cm') AND "40cm_dbh3" IS NOT NULL),
	
ins15 AS (INSERT INTO plot_module_woody_raw (plot_no, module_id, species, dbh_class, dbh_class_index, count) SELECT plot_no, module_number::integer AS module_id,
woody_species,

CASE WHEN  '40cm_dbh4' IS NOT NULL THEN '>40cm'
ELSE NULL
END
AS dbh_class, 

CASE WHEN '40cm_dbh4' IS NOT NULL THEN 14
ELSE NULL
END
AS dbh_class_index, "40cm_dbh4" AS count

FROM vibi_fulcrum_woody_joined_new_records WHERE NOT EXISTS
(
	SELECT 1 FROM plot_module_woody_raw WHERE plot_no = vibi_fulcrum_woody_joined_new_records.plot_no AND species = vibi_fulcrum_woody_joined_new_records.woody_species AND module_id = vibi_fulcrum_woody_joined_new_records.module_number::integer
	AND dbh_class = '>40cm') AND "40cm_dbh4" IS NOT NULL)
	
INSERT INTO plot_module_woody_raw (plot_no, module_id, species, dbh_class, dbh_class_index, count) SELECT plot_no, module_number::integer AS module_id,
woody_species,

CASE WHEN  '40cm_dbh5' IS NOT NULL THEN '>40cm'
ELSE NULL
END
AS dbh_class, 

CASE WHEN '40cm_dbh5' IS NOT NULL THEN 15
ELSE NULL
END
AS dbh_class_index, "40cm_dbh5" AS count

FROM vibi_fulcrum_woody_joined_new_records WHERE NOT EXISTS
(
	SELECT 1 FROM plot_module_woody_raw WHERE plot_no = vibi_fulcrum_woody_joined_new_records.plot_no AND species = vibi_fulcrum_woody_joined_new_records.woody_species AND module_id = vibi_fulcrum_woody_joined_new_records.module_number::integer
	AND dbh_class = '>40cm') AND "40cm_dbh5" IS NOT NULL
	
;
	
RETURN NEW;
END $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION vibi_woody_modules_insert()
  OWNER TO postgres;
  
  CREATE TRIGGER vibi_woody_modules_insert_trigger AFTER INSERT ON vibi_woody FOR EACH STATEMENT EXECUTE PROCEDURE vibi_woody_modules_insert();  
