library(raster)
library(ncdf4)
library(maps)


# PLOTTING PARAMETERS
SMColors_r = rev(c(10,40,20,0,0,0,26,13,25,50,68,97,106,124,138,172,205,223,240,247,255,
		255,244,238,255,255,255,245,255,255,255,255))

SMColors_g = rev(c(0,0,5,10,25,40,102,129,175,190,202,225,235,235,236,245,255,245,236,215,
		189,160,117,80,90,124,158,179,196,215,235,255))

SMColors_b = rev(c(121,150,175,200,212,224,240,248,255,255,255,240,225,200,174,168,162,
		141,121,104,87,69,75,78,90,124,158,174,196,215,235,255))

MoistureRamp = colorRampPalette(rgb(
  red   = SMColors_r / 255.,
  green = SMColors_g / 255.,
  blue  = SMColors_b / 255.))


DifferenceRamp = colorRampPalette(c('darkred','red','white','blue','navy'))
SMcolours  = colorRampPalette(c('white',"peru","orange","yellow","forestgreen",'deepskyblue','navy','black'))

# COAST LINES
addCoastLines = function(Proj=PROJ_TARGET,Colour='darkgrey') {

## ---   if PROJ is lat-lon then plot the whole world coastline
if (length(grep('longlat',Proj)) != 1) {
        CountriesToPlot = c('Australia','New Zealand','Japan','Indonesia','India',
                            'Papua New Guinea','Thailand','China','Malaysia',
                            'Philippines','New Caledonia','Vietnam','Cambodia',
                            'Laos','North Korea','South Korea','Taiwan','Myanmar',
                            'Fiji','Solomon Islands','Vanuatu','Sri Lanka','Bangladesh')
        gobalLats = map('world',plot=F,region=CountriesToPlot)$y
        gobalLons = map('world',plot=F,region=CountriesToPlot)$x
} else {
        gobalLats = map('world',plot=F)$y
        gobalLons = map('world',plot=F)$x
}

### -- getting rid of the lat and lons with NAs
gLats = gobalLats[!is.na(gobalLats)]
gLons = gobalLons[!is.na(gobalLons)]

gLL   = SpatialPoints(cbind(gLons,gLats),proj4string = CRS('+proj=longlat +datum=WGS84'))
gNE   = spTransform(gLL,CRS(Proj))  # - change to the relavnt NEW projection e.g. PROJ_GEO, PROJ_AEA, ..

gE = coordinates(gNE)[,1]
gN = coordinates(gNE)[,2]

globalEastings  = gobalLons  # initialising arrays
globalNorthings = gobalLats

globalEastings[!is.na(gobalLons)]  = gE
globalNorthings[!is.na(gobalLats)] = gN

#
lines(globalEastings,globalNorthings,col=Colour)

}


#### common projections used in displaying rainfall grids
PROJ_LATLON = '+proj=longlat +datum=WGS84'
PROJ_AEA = '+proj=aea +lat_1=-18.0 +lat_2=-36.0 +lon_0=132 +lat_0=0 +datum=WGS84'
PROJ_GEO = '+proj=geos +lon_0=140.7 +h=35785863 +a=6378137.0 +b=6356752.3'

