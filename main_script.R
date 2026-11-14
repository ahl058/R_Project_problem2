library(dplyr) # To execute, its necessary to install dplyr package, use the command install.packages('dplyr') in your console. 
adip_data <- read.table('adipodatav8.tsv',sep='\t',stringsAsFactors = TRUE, header=TRUE)


# In the following lines, we convert the variables into factor to make it easier to work with these variables
adip_data$mouse <- as.factor(adip_data$mouse)
adip_data$weeks <- as.factor(adip_data$weeks)
adip_data$image <- as.factor(adip_data$image)

#adip_data$mouse[which(adip_data$mouse=='3')] # Thats the way to invoke the elements. 


# Task 1. We've created a new data frame which is much easier to work with because it just have the
# m.id, which has in it the treatment and the week (so we don't have to work with those variables separately).
# it also has the nº of mouse, the nº of image for each mouse and values obtained in each image. 
adip_clean<- data.frame('m.id'=adip_data$m.id,'mouse'=adip_data$mouse,'image'=adip_data$image,'pixel2'=adip_data$pixel2)

# With the package dplyr we're going to modify that data frame we've created. 

adip_per_img <- adip_clean %>%
  
  # This will group the variables hierarchically so that later we can calculate the mean sorting by this order.
  group_by(m.id, mouse, image) %>%  
  
  # It creates a new data frame (which we'll be subtituted to adip_per_img) whith the columns we grouped by and with the new colum that we indicate, 
  # which operations we'll be executed with the whierarchy we indicate in the group_by
  summarise(total_img = sum(pixel2), mean_img = mean(pixel2), .groups = 'drop') 
  
# Is transformed into a data frame because group_by creates a tibble, which does not show decimal numbers. 

adip_per_img <- as.data.frame(adip_per_img)
 
# Task 2. Avrg adipocite size in the levels per image, per mouse, per group. The first one it's done above within the same
# summarise function to that of the sum of all measures per image. It is done like that because otherwise we'd have to make another group_by 
# and is less aesthetic. 
# Repeat the same operation as before for the next tasks. 
adip_per_mouse <- adip_clean %>%
  group_by(m.id, mouse) %>%
  summarise(mean_mouse = mean(pixel2), .groups = 'drop')
adip_per_mouse <- as.data.frame(adip_per_mouse)


adip_per_group <- adip_clean %>%
  group_by(m.id)%>%
  summarise(mean_group = mean(pixel2), .groups='drop')
adip_per_group <- as.data.frame(adip_per_group)





 





  
