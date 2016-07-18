CREATE OR REPLACE FUNCTION vibi_plot_info_upsert()
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

ON CONFLICT (plot_no) DO UPDATE SET project_name = (SELECT project_name FROM vibi_intensive WHERE plot_no = plot.plot_no);

RETURN NEW;
END $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION vibi_plot_info_upsert()
  OWNER TO postgres;

CREATE TRIGGER vibi_plot_info_upsert_trigger AFTER INSERT ON vibi_intensive FOR EACH STATEMENT EXECUTE PROCEDURE vibi_plot_info_upsert();   