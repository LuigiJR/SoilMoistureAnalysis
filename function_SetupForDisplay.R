library(raster)
library(ncdf4)
library(maps)


#  Default geographic projection for lats and longs

PROJ_LATLON = '+proj=longlat +datum=WGS84'


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


