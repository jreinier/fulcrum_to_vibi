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

INSERT INTO plot (plot_no, project_name, plot_name, project_label, monitoring_event, datetimer, party, plot_not_sampled, commentplot_not_sampled, sampling_quality, state, county, quadrangle, local_place_name, landowner, xaxis_bearing_of_plot, enter_gps_location_in_plot, latitude, longitude, total_modules, intensive_modules, plot_configuration, plot_configuration_other, plot_size_for_cover_data_area_ha, vegclass, vegsubclass, leap_landcover_classification, cowardin_classification, cowardin_water_regime, cowardin_special_modifier, cowardin_special_modifier_other, landscape_position, inland_landform, water_flow_path, llww_modifiers, llww_modifiers_other, homogeneity, drainage, salinity, hydrologic_regime, oneo_disturbance_type, oneo_disturbance_severity, oneo_disturbance_years_ago, oneo_distubance_per_of_plot, oneo_disturbance_description, twoo_disturbance_type, twoo_disturbance_severity, twoo_disturbance_years_ago, twoo_distubance_per_of_plot, twoo_disturbance_description, threeo_disturbance_type, threeo_disturbance_severity, threeo_disturbance_years_ago, threeo_distubance_per_of_plot, threeo_disturbance_description) SELECT plot_no, project_name, project_name_other, project_label, monitoring_event, date::timestamp with time zone, party, plot_not_sampled, commentplot_not_sampled, sampling_quality, state, county, quadrangle, local_place_name, landowner, xaxis_bearing_of_plot::integer, enter_gps_location_in_plot, latitude_1::numeric, longitude_1::numeric, total_modules::integer, intensive_modules::integer, plot_configuration, plot_configuration_other, plot_size_area_in_hectares::numeric, vegclass, vegsubclass, 
CASE 
WHEN leap_habitat_classification LIKE  '%Dry Oak Forest and Woodland%' THEN 'IA1'
WHEN leap_habitat_classification LIKE  '%Dry-Mesic Oak Forest and Woodland%' THEN 'IA2'
WHEN leap_habitat_classification LIKE  '%Appalachian (Hemlock) Hardwood Forest%' THEN 'IB1'
WHEN leap_habitat_classification LIKE  '%Hemlock Ravine%' THEN 'IB2'
WHEN leap_habitat_classification LIKE  '%Beech-Maple Forest%' THEN 'IC1'
WHEN leap_habitat_classification LIKE  '%Mixed Hardwood Forest (red oak, tuliptree, sugar maple, little to no beech)%' THEN 'IC2'
WHEN leap_habitat_classification LIKE  '%Rich Mesophytic Forest (New York)%' THEN 'IC3'
WHEN leap_habitat_classification LIKE  '%Oak Savanna/Barrens%' THEN 'ID'
WHEN leap_habitat_classification LIKE  '%Non-Calcareous Cliff and Talus%' THEN 'IE1'
WHEN leap_habitat_classification LIKE  '%Calcareous Cliff and Talus%' THEN 'IE2'
WHEN leap_habitat_classification LIKE  '%Great Lakes Rocky Shore and Cliff (Alkaline)%' THEN 'IF'
WHEN leap_habitat_classification LIKE  '%Low Gradient (>3rd order streams and rivers)%' THEN 'IIA1'
WHEN leap_habitat_classification LIKE  '%High Gradient (1st and 2nd order streams)%' THEN 'IIA2'
WHEN leap_habitat_classification LIKE  '%Emergent Herbaceous (Marsh)%' THEN 'IIB'
WHEN leap_habitat_classification LIKE  '%Scrub-Shrub/Meadow%' THEN 'IIC'
WHEN leap_habitat_classification LIKE  '%Forested Flat (including vernal pools)%' THEN 'IIIA1'
WHEN leap_habitat_classification LIKE  '%Forest Seeps%' THEN 'IIIA2'
WHEN leap_habitat_classification LIKE  '%Bog Forest (organic soil)%' THEN 'IIIA3'
WHEN leap_habitat_classification LIKE  '%Coastal Marsh (lakeshore)%' THEN 'IIIB1a'
WHEN leap_habitat_classification LIKE  '%Inland Freshwater Marsh%' THEN 'IIIB1b'
WHEN leap_habitat_classification LIKE  '%Bog%' THEN 'IIIC1'
WHEN leap_habitat_classification LIKE  '%Rich Fen%' THEN 'IIIC2a'
WHEN leap_habitat_classification LIKE  '%Poor Fen%' THEN 'IIIC2b'
WHEN leap_habitat_classification LIKE  '%Other Shrub/Meadow%' THEN 'IIIC3'
WHEN leap_habitat_classification LIKE  '%Beach%' THEN 'IVA1'
WHEN leap_habitat_classification LIKE  '%Wooded Dune%' THEN 'IVA2'
WHEN leap_habitat_classification LIKE  '%Submersed Bed%' THEN 'IVB1'
WHEN leap_habitat_classification LIKE  '%Sand/Gravel Bar%' THEN 'IVB2'
WHEN leap_habitat_classification LIKE  '%Active Farming (Cultivated Crops and Irrigated Agriculture)%' THEN 'VA1'
WHEN leap_habitat_classification LIKE  '%Pasture (Pasture/Hay)%' THEN 'VA2'
WHEN leap_habitat_classification LIKE  '%Old Field (Ruderal Upland - Old Field)%' THEN 'VA3'
WHEN leap_habitat_classification LIKE  '%Post Clearcut Communities (Successional Shrub/Scrub)%' THEN 'VA4'
WHEN leap_habitat_classification LIKE  '%Tree Plantations%' THEN 'VA5'
WHEN leap_habitat_classification LIKE  '%Atypical Successional Woody Communities (Ruderal forest)%' THEN 'VB'
WHEN leap_habitat_classification LIKE  '%Disturbed Soil Communities (Quarries/Strip Mines/Gravel Pits)%' THEN 'VC'
WHEN leap_habitat_classification LIKE  '%Pond and Reservoir (Open water)%' THEN 'VD'
WHEN leap_habitat_classification LIKE  '%Human Structures (oil/gas wells)%' THEN 'VE'
WHEN leap_habitat_classification LIKE  '%Open Space%' THEN 'VF1'
WHEN leap_habitat_classification LIKE  '%Low Intensity%' THEN 'VF2'
WHEN leap_habitat_classification LIKE  '%Medium Intensity%' THEN 'VF3'
WHEN leap_habitat_classification LIKE  '%High Intensity%' THEN 'VF4'
ELSE NULL
END
AS leap_habitat_classification,
cowardin_classification, cowardin_water_regime, cowardin_special_modifier, cowardin_special_modifier_other, landscape_position, inland_landform, water_flow_path, llww_modifiers, llww_modifiers_other, homogeneity, drainage, salinity, hydrologic_regime, oneo_disturbance_type, oneo_disturbance_severity, oneo_disturbance_years_ago::integer, oneo_distubance_per_of_plot::integer, oneo_disturbance_description, twoo_disturbance_type, twoo_disturbance_severity, twoo_disturbance_years_ago::integer, twoo_distubance_per_of_plot::integer, twoo_disturbance_description, threeo_disturbance_type, threeo_disturbance_severity, threeo_disturbance_years_ago::integer, threeo_distubance_per_of_plot::integer, threeo_disturbance_description FROM  vibi_intensive
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
	) GROUP BY plot_no, herbaceous_module, corner, depth, open_water_cover),
	

ins8 AS (INSERT INTO plot_module_herbaceous_info (plot_no, module_id, corner, depth, info, cover_class_code) SELECT plot_no, herbaceous_module::integer,
NULL::integer AS corner, 1::integer AS depth,

CASE WHEN  unvegetated_open_water_cover IS NOT NULL THEN 'unvegetated open water cover'
ELSE NULL
END
AS info, unvegetated_open_water_cover::integer FROM vibi_fulcrum_joined_new_records WHERE NOT EXISTS
(
	SELECT 1 FROM plot_module_herbaceous_info WHERE plot_no = vibi_fulcrum_joined_new_records.plot_no
	) GROUP BY plot_no, herbaceous_module, corner, depth, unvegetated_open_water_cover)
	
INSERT INTO fds1_species_misc_info (species, plot_no, module_id, voucher_no, comment, browse_intensity, percent_flowering, percent_fruiting) SELECT herbaceous_species, plot_no,
herbaceous_module::integer, voucher_number, comment, deer_browse_intensity, _flowering, _fruiting

FROM vibi_fulcrum_joined_new_records WHERE NOT EXISTS
(
	SELECT 1 FROM fds1_species_misc_info WHERE plot_no = vibi_fulcrum_joined_new_records.plot_no
	) AND voucher_number IS NOT NULL OR comment IS NOT NULL OR deer_browse_intensity IS NOT NULL OR _flowering IS NOT NULL OR _fruiting IS NOT NULL GROUP BY plot_no, herbaceous_species, herbaceous_module, voucher_number, comment, deer_browse_intensity, _flowering, _fruiting
	
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

ins1 AS (INSERT INTO plot_module_woody_raw (plot_no, sub, module_id, species, dbh_class, dbh_class_index, count) SELECT plot_no, sub_or_super_sample::numeric, module_number::integer AS module_id,
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
	

	
ins2 AS (INSERT INTO plot_module_woody_raw (plot_no, sub, module_id, species, dbh_class, dbh_class_index, count) SELECT plot_no, sub_or_super_sample::numeric, module_number::integer AS module_id,
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
	
ins3 AS (INSERT INTO plot_module_woody_raw (plot_no, sub, module_id, species, dbh_class, dbh_class_index, count) SELECT plot_no, sub_or_super_sample::numeric, module_number::integer AS module_id,
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
	
ins4 AS (INSERT INTO plot_module_woody_raw (plot_no, sub, module_id, species, dbh_class, dbh_class_index, count) SELECT plot_no, sub_or_super_sample::numeric, module_number::integer AS module_id,
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
	
ins5 AS (INSERT INTO plot_module_woody_raw (plot_no, sub, module_id, species, dbh_class, dbh_class_index, count) SELECT plot_no, sub_or_super_sample::numeric, module_number::integer AS module_id,
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
	
ins6 AS (INSERT INTO plot_module_woody_raw (plot_no, sub, module_id, species, dbh_class, dbh_class_index, count) SELECT plot_no, sub_or_super_sample::numeric, module_number::integer AS module_id,
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
	
ins7 AS (INSERT INTO plot_module_woody_raw (plot_no, sub, module_id, species, dbh_class, dbh_class_index, count) SELECT plot_no, sub_or_super_sample::numeric, module_number::integer AS module_id,
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
	
ins8 AS (INSERT INTO plot_module_woody_raw (plot_no, sub, module_id, species, dbh_class, dbh_class_index, count) SELECT plot_no, sub_or_super_sample::numeric, module_number::integer AS module_id,
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
	
ins9 AS (INSERT INTO plot_module_woody_raw (plot_no, sub, module_id, species, dbh_class, dbh_class_index, count) SELECT plot_no, sub_or_super_sample::numeric, module_number::integer AS module_id,
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
	
ins10 AS (INSERT INTO plot_module_woody_raw (plot_no, sub, module_id, species, dbh_class, dbh_class_index, count) SELECT plot_no, sub_or_super_sample::numeric, module_number::integer AS module_id,
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
	
ins11 AS (INSERT INTO plot_module_woody_raw (plot_no, sub, module_id, species, dbh_class, dbh_class_index, count) SELECT plot_no, sub_or_super_sample::numeric, module_number::integer AS module_id,
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
	
ins12 AS (INSERT INTO plot_module_woody_raw (plot_no, sub, module_id, species, dbh_class, dbh_class_index, count) SELECT plot_no, sub_or_super_sample::numeric, module_number::integer AS module_id,
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
	
ins13 AS (INSERT INTO plot_module_woody_raw (plot_no, sub, module_id, species, dbh_class, dbh_class_index, count) SELECT plot_no, sub_or_super_sample::numeric, module_number::integer AS module_id,
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
	
ins14 AS (INSERT INTO plot_module_woody_raw (plot_no, sub, module_id, species, dbh_class, dbh_class_index, count) SELECT plot_no, sub_or_super_sample::numeric, module_number::integer AS module_id,
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
	
ins15 AS (INSERT INTO plot_module_woody_raw (plot_no, sub, module_id, species, dbh_class, dbh_class_index, count) SELECT plot_no, sub_or_super_sample::numeric, module_number::integer AS module_id,
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
	AND dbh_class = '>40cm') AND "40cm_dbh4" IS NOT NULL),
	
ins16 AS (INSERT INTO plot_module_woody_raw (plot_no, sub, module_id, species, dbh_class, dbh_class_index, count) SELECT plot_no, sub_or_super_sample::numeric, module_number::integer AS module_id,
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
	AND dbh_class = '>40cm') AND "40cm_dbh5" IS NOT NULL)
	
INSERT INTO fds2_species_misc_info (species, plot_no, module_id, voucher_no, comment, browse_intensity, percent_flowering, percent_fruiting) SELECT woody_species, plot_no,
module_number::integer, voucher_number, comment, count_of_browsed_individuals, _flowering, _fruiting

FROM vibi_fulcrum_woody_joined_new_records WHERE NOT EXISTS
(
	SELECT 1 FROM fds2_species_misc_info WHERE plot_no = vibi_fulcrum_woody_joined_new_records.plot_no
	) AND voucher_number IS NOT NULL OR comment IS NOT NULL OR count_of_browsed_individuals IS NOT NULL OR _flowering IS NOT NULL OR _fruiting IS NOT NULL GROUP BY plot_no, woody_species, module_number, voucher_number, comment, count_of_browsed_individuals, _flowering, _fruiting
	
	
;

	
RETURN NEW;
END $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION vibi_woody_modules_insert()
  OWNER TO postgres;
  
  CREATE TRIGGER vibi_woody_modules_insert_trigger AFTER INSERT ON vibi_woody FOR EACH STATEMENT EXECUTE PROCEDURE vibi_woody_modules_insert();          
