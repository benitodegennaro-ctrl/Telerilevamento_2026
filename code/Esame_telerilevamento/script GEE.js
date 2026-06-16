// ==============================================
// Sentinel-2 Surface Reflectance - Cloud Masking and Visualization
// Progetto Ucraina (Zaporizhzhia) - Benito De Gennaro
// ==============================================

// Funzione per il mascheramento delle nuvole tramite banda QA60
function maskS2clouds(image) {
  var qa = image.select('QA60');
  var cloudBitMask = 1 << 10;
  var cirrusBitMask = 1 << 11;
  var mask = qa.bitwiseAnd(cloudBitMask).eq(0)
                 .and(qa.bitwiseAnd(cirrusBitMask).eq(0));
  return image.updateMask(mask).divide(10000);
}

// Selezione delle bande coerenti con la relazione in R (B12 esclusa)
var bands_to_export = ['B2', 'B3', 'B4', 'B8', 'B11'];

// ==============================================
// 1. ESTRAZIONE ANNO 2021 (Baseline)
// ==============================================
var col_2021 = ee.ImageCollection('COPERNICUS/S2_SR_HARMONIZED')
  .filterBounds(aoi)
  .filterDate('2021-05-01', '2021-08-31') // Finestra temporale estiva
  .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE', 20))
  .map(maskS2clouds);

var composite_2021 = col_2021.median().clip(aoi).select(bands_to_export);

Export.image.toDrive({
  image: composite_2021,
  description: 'Ucraina_2021_bands',
  folder: 'GEE_exports',
  fileNamePrefix: 'Ucraina_2021_bands',
  region: aoi,
  scale: 10,
  crs: 'EPSG:4326',
  maxPixels: 1e13
});

// ==============================================
// 2. ESTRAZIONE ANNO 2022 (Fase critica)
// ==============================================
var col_2022 = ee.ImageCollection('COPERNICUS/S2_SR_HARMONIZED')
  .filterBounds(aoi)
  .filterDate('2022-05-01', '2022-08-31')
  .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE', 20))
  .map(maskS2clouds);

var composite_2022 = col_2022.median().clip(aoi).select(bands_to_export);

Export.image.toDrive({
  image: composite_2022,
  description: 'Ucraina_2022_bands',
  folder: 'GEE_exports',
  fileNamePrefix: 'Ucraina_2022_bands',
  region: aoi,
  scale: 10,
  crs: 'EPSG:4326',
  maxPixels: 1e13
});

// ==============================================
// 3. ESTRAZIONE ANNO 2026 (Situazione attuale)
// ==============================================
var col_2026 = ee.ImageCollection('COPERNICUS/S2_SR_HARMONIZED')
  .filterBounds(aoi)
  .filterDate('2026-05-01', '2026-06-15') // Dati aggiornati al periodo corrente (2026)
  .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE', 20))
  .map(maskS2clouds);

var composite_2026 = col_2026.median().clip(aoi).select(bands_to_export);

Export.image.toDrive({
  image: composite_2026,
  description: 'Ucraina_2026_bands',
  folder: 'GEE_exports',
  fileNamePrefix: 'Ucraina_2026_bands',
  region: aoi,
  scale: 10,
  crs: 'EPSG:4326',
  maxPixels: 1e13
});
