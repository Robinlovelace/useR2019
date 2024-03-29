# install.packages("WHO")

df = WHO::get_codes()
sel = grep("road", df$display)
dfr = df[sel,]

df1 = WHO::get_data("RS_198")

library(tmap)
data("World")
plot(World)
names(World)
head(World$name)
library(dplyr)
df1 = rename(df1, name = country)
World = left_join(World, df1)
World$name[is.na(World$value)]
tm_shape(shp = World) + tm_fill("value")

# not all have data - refactor names - rename...
World$name[is.na(World$value)]
df1$name[! df1$name %in% World$name] # mismatched names

cname = "Russia"
df1$name[grep(cname, df1$name)] = World$name[grep(cname, World$name)]
cname = "Britain|United King"
df1$name[grep(cname, df1$name)] = World$name[grep(cname, World$name)]
cname = "United States"
df1$name[grep(cname, df1$name)] = World$name[grep(cname, World$name)]
cname = "Venez"
df1$name[grep(cname, df1$name)] = World$name[grep(cname, World$name)]
cname = "Tanz"
df1$name[grep(cname, df1$name)] = World$name[grep(cname, World$name)]
cname = "Iran"
df1$name[grep(cname, df1$name)] = World$name[grep(cname, World$name)]
cname = "Bolivia"
df1$name[grep(cname, df1$name)] = World$name[grep(cname, World$name)]
cname = "Viet"
df1$name[grep(cname, df1$name)] = World$name[grep(cname, World$name)]

df1$name[! df1$name %in% World$name]

data("World")
World = left_join(World, df1)
World$name[is.na(World$value)]
tm_shape(shp = World) + tm_fill("value")

World = rename(World, `Road deaths\nper 100,000` = value)

# plot the result - thanks to tmap: 
# https://github.com/mtennekes/tmap
world_eck = tmaptools::set_projection(World, "eck4")
x = tm_shape(world_eck) +
  tm_borders("grey20") +
  tm_grid(projection="longlat", labels.size = .5, alpha = 0.2) +
  tm_fill("Road deaths\nper 100,000", n = 4, palette = "inferno", ) +
  tm_text("name", size="AREA") +
  tm_layout(bg.color = "lightblue")
x 
# +  tm_style_bw()
tmap::tmap_save(x, "road-casualties.png")
tmap::save_tmap(x, "road-casualties.svg")