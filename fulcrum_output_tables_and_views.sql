DROP TABLE IF EXISTS vibi_intensive CASCADE;
DROP TABLE IF EXISTS vibi_intensive_herbaceous_intensive CASCADE;
DROP TABLE IF EXISTS vibi_intensive_herbaceous_intensive_herbaceous_species_list CASCADE;
DROP TABLE IF EXISTS vibi_intensive_photos CASCADE;
DROP TABLE IF EXISTS vibi_woody CASCADE;
DROP TABLE IF EXISTS vibi_woody_woody_species_list CASCADE;
DROP TABLE IF EXISTS vibi_woody_woody_species_list_module_and_count CASCADE;


CREATE EXTENSION IF NOT EXISTS postgis;

CREATE TABLE IF NOT EXISTS "vibi_intensive" (
  "fulcrum_id" character varying(100),
  "created_at" timestamp without time zone,
  "updated_at" timestamp without time zone,
  "created_by" text,
  "updated_by" text,
  "system_created_at" timestamp without time zone,
  "system_updated_at" timestamp without time zone,
  "version" bigint,
  "status" text,
  "project" text,
  "assigned_to" text,
  "latitude" double precision,
  "longitude" double precision,
  "geometry" geometry(Point, 4326),
  "plot_no" text,
  "project_name" text,
  "project_name_other" text,
  "plot_name" text,
  "project_label" text,
  "project_label_other" text,
  "monitoring_event" text,
  "monitoring_event_other" text,
  "date" text,
  "time" text,
  "party" text,
  "plot_not_sampled" text,
  "commentplot_not_sampled" text,
  "sampling_quality" text,
  "state" text,
  "county" text,
  "quadrangle" text,
  "local_place_name" text,
  "landowner" text,
  "xaxis_bearing_of_plot" text,
  "enter_gps_location_in_plot" text,
  "latitude_1" text,
  "longitude_1" text,
  "plot_placement" text,
  "plot_placement_other" text,
  "total_modules" text,
  "intensive_modules" text,
  "plot_configuration" text,
  "plot_size_area_in_hectares" text,
  "estimate_of_per_open_water_entire_site" text,
  "estimate_of_perunvegetated_ow_entire_site" text,
  "estimate_per_invasives_entire_site" text,
  "centerline" text,
  "oneo_plant" text,
  "vegclass" text,
  "vegsubclass" text,
  "twoo_plant" text,
  "oneo_class_code_mod_natureserve" text,
  "cowardin_classification" text,
  "cowardin_water_regime" text,
  "cowardin_special_modifier" text,
  "cowardin_special_modifier_other" text,
  "landscape_position" text,
  "inland_landform" text,
  "water_flow_path" text,
  "llww_modifiers" text,
  "llww_modifiers_other" text,
  "landform_type" text,
  "homogeneity" text,
  "stand_size" text,
  "drainage" text,
  "salinity" text,
  "hydrologic_regime" text,
  "oneo_disturbance_type" text,
  "oneo_disturbance_severity" text,
  "oneo_disturbance_years_ago" text,
  "oneo_distubance_per_of_plot" text,
  "oneo_disturbance_description" text,
  "twoo_disturbance_type" text,
  "twoo_disturbance_severity" text,
  "twoo_disturbance_years_ago" text,
  "twoo_distubance_per_of_plot" text,
  "twoo_disturbance_description" text,
  "threeo_disturbance_type" text,
  "threeo_disturbance_severity" text,
  "threeo_disturbance_years_ago" text,
  "threeo_distubance_per_of_plot" text,
  "threeo_disturbance_description" text,
  "photos" text,
  "photos_caption" text,
  "photos_url" text
);



CREATE TABLE IF NOT EXISTS "vibi_intensive_herbaceous_intensive" (
  "fulcrum_id" character varying(100),
  "fulcrum_parent_id" text,
  "fulcrum_record_id" text,
  "version" bigint,
  "latitude" double precision,
  "longitude" double precision,
  "geometry" geometry(Point, 4326),
  "created_at" timestamp without time zone,
  "updated_at" timestamp without time zone,
  "created_by" text,
  "updated_by" text,
  "herbaceous_module" text,
  "bare_ground_cover" text,
  "litter_cover" text,
  "open_water_cover" text,
  "unvegetated_open_water_cover" text
);



CREATE TABLE IF NOT EXISTS "vibi_intensive_herbaceous_intensive_herbaceous_species_list" (
  "fulcrum_id" character varying(100),
  "fulcrum_parent_id" text,
  "fulcrum_record_id" text,
  "version" bigint,
  "latitude" double precision,
  "longitude" double precision,
  "geometry" geometry(Point, 4326),
  "created_at" timestamp without time zone,
  "updated_at" timestamp without time zone,
  "created_by" text,
  "updated_by" text,
  "herbaceous_species" text,
  "corner_1_depth" text,
  "corner_2_depth" text,
  "corner_3_depth" text,
  "corner_4_depth" text,
  "cover_code" text,
  "voucher_number" text,
  "comment" text,
  "deer_browse_intensity" text,
  "_flowering" text,
  "_fruiting" text
);



CREATE TABLE IF NOT EXISTS "vibi_intensive_photos" (
  "fulcrum_id" text,
  "fulcrum_parent_id" text,
  "fulcrum_record_id" text,
  "version" bigint,
  "caption" text,
  "latitude" double precision,
  "longitude" double precision,
  "geometry" geometry(Point, 4326),
  "file_size" bigint,
  "uploaded_at" timestamp without time zone,
  "exif_date_time" text,
  "exif_gps_altitude" text,
  "exif_gps_date_stamp" text,
  "exif_gps_time_stamp" text,
  "exif_gps_dop" text,
  "exif_gps_img_direction" text,
  "exif_gps_img_direction_ref" text,
  "exif_gps_latitude" text,
  "exif_gps_latitude_ref" text,
  "exif_gps_longitude" text,
  "exif_gps_longitude_ref" text,
  "exif_make" text,
  "exif_model" text,
  "exif_orientation" text,
  "exif_pixel_x_dimension" text,
  "exif_pixel_y_dimension" text,
  "exif_software" text,
  "exif_x_resolution" text,
  "exif_y_resolution" text
);


CREATE TABLE IF NOT EXISTS "vibi_woody" (
  "fulcrum_id" character varying(100),
  "created_at" timestamp without time zone,
  "updated_at" timestamp without time zone,
  "created_by" text,
  "updated_by" text,
  "system_created_at" timestamp without time zone,
  "system_updated_at" timestamp without time zone,
  "version" bigint,
  "status" text,
  "project" text,
  "assigned_to" text,
  "latitude" double precision,
  "longitude" double precision,
  "geometry" geometry(Point, 4326),
  "plot_no" text
);



CREATE TABLE IF NOT EXISTS "vibi_woody_woody_species_list" (
  "fulcrum_id" character varying(100),
  "fulcrum_parent_id" text,
  "fulcrum_record_id" text,
  "version" bigint,
  "latitude" double precision,
  "longitude" double precision,
  "geometry" geometry(Point, 4326),
  "created_at" timestamp without time zone,
  "updated_at" timestamp without time zone,
  "created_by" text,
  "updated_by" text,
  "woody_species" text
);



CREATE TABLE IF NOT EXISTS "vibi_woody_woody_species_list_module_and_count" (
  "fulcrum_id" character varying(100),
  "fulcrum_parent_id" text,
  "fulcrum_record_id" text,
  "version" bigint,
  "latitude" double precision,
  "longitude" double precision,
  "geometry" geometry(Point, 4326),
  "created_at" timestamp without time zone,
  "updated_at" timestamp without time zone,
  "created_by" text,
  "updated_by" text,
  "module_number" text,
  "shrub_clump_count" text,
  "0_1cm_count" text,
  "1_25cm_count" text,
  "25_5cm_count" text,
  "5_10cm_count" text,
  "10_15cm_count" text,
  "15_20cm_count" text,
  "20_25cm_count" text,
  "25_30cm_count" text,
  "30_35cm_count" text,
  "35_40cm_count" text,
  "40cm_dbh1" text,
  "40cm_dbh2" text,
  "40cm_dbh3" text,
  "40cm_dbh4" text,
  "40cm_dbh5" text,
  "voucher_number" text,
  "comment" text,
  "deer_browse_intensity" text,
  "_flowering" text,
  "_fruiting" text
);


CREATE OR REPLACE VIEW vibi_fulcrum_joined  AS SELECT a.*, b.herbaceous_module, b.bare_ground_cover, b.litter_cover, b.open_water_cover, unvegetated_open_water_cover, c.plot_no FROM vibi_intensive_herbaceous_intensive_herbaceous_species_list a 
LEFT JOIN vibi_intensive_herbaceous_intensive b ON b.fulcrum_id = a.fulcrum_parent_id
LEFT JOIN  vibi_intensive c ON c.fulcrum_id = a.fulcrum_record_id; 


CREATE OR REPLACE VIEW vibi_fulcrum_woody_joined  AS SELECT a.*, b.woody_species, c.plot_no FROM vibi_woody_woody_species_list_module_and_count a 
LEFT JOIN vibi_woody_woody_species_list b ON b.fulcrum_id = a.fulcrum_parent_id
LEFT JOIN  vibi_woody c ON c.fulcrum_id = a.fulcrum_record_id;


CREATE OR REPLACE VIEW vibi_fulcrum_soil_joined  AS SELECT  c.plot_no, c.sample_depth_inches, b.depth_to_layer_cm, b.matrix_hue, b.matrix_value, b.matrix_chroma, a.redox_hue, a.redox_value, a.redox_chroma, a.redox_percent, a.redox_type, a.redox_location, b.soil_texture, b.remarks, a.fulcrum_id, a.fulcrum_parent_id, a.fulcrum_record_id, a.version, a.latitude, a.longitude, a.geometry, a.created_at, a.updated_at, a.created_by, a.updated_by FROM
vibi_physical_soil_layers_redox_features a
LEFT JOIN vibi_physical_soil_layers b ON b.fulcrum_id = a.fulcrum_parent_id
LEFT JOIN vibi_physical c ON c.fulcrum_id = a.fulcrum_record_id;      
