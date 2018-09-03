context('test scale_color/fill_scico_d')



# Initial setup -----------------------------------------------------------

library(dplyr)
library(ggplot2)

base_color_plot <- mtcars %>% 
  mutate(cyl = factor(cyl)) %>% 
  ggplot(aes(x=wt, y=mpg)) + 
  geom_point(aes(color=cyl), size=10) 

base_fill_plot <- mtcars %>% 
  mutate(cyl = factor(cyl)) %>% 
  ggplot(aes(x=mpg)) + 
  geom_density(aes(fill=cyl)) 



# test scale_color_scico_d ------------------------------------------------

test_that('scale_color_scico_d is ScaleDiscrete',{
  expect_s3_class(scale_fill_scico_d(), 'ScaleDiscrete')
})

test_that('scale_color_scico_d returns a ggplot',{
  expect_s3_class(base_color_plot + scale_color_scico_d(), 'gg')
})

test_that('scale_color_scico_d takes palette args',{
  expect_s3_class(base_color_plot + 
                    scale_color_scico_d(palette = 'oslo'), 
                  'gg')
  expect_s3_class(base_color_plot + 
                    scale_color_scico_d(alpha = .5, begin = .5, end = .9), 
                  'gg')
  expect_s3_class(base_color_plot + 
                    scale_color_scico_d(direction = -1), 
                  'gg')
})

test_that('scale_color_scico_d fails as expected',{
  expect_error(base_color_plot + scale_color_scico_d(palette = 'inferno'))
  
  expect_error(base_color_plot + scale_color_scico_d(alpha = 2))
})



# test scale_fill_scico_d ------------------------------------------------

test_that('scale_fill_scico_d is ScaleDiscrete',{
  expect_s3_class(scale_fill_scico_d(), 'ScaleDiscrete')
})

test_that('scale_fill_scico_d returns a ggplot',{
  expect_s3_class(base_fill_plot + scale_fill_scico_d(), 'gg')
})

test_that('scale_fill_scico_d takes palette args',{
  expect_s3_class(base_fill_plot + 
                    scale_fill_scico_d(palette = 'oslo'), 
                  'gg')
  expect_s3_class(base_fill_plot + 
                    scale_fill_scico_d(alpha = .5, begin = .5, end = .9), 
                  'gg')
  expect_s3_class(base_fill_plot + 
                    scale_fill_scico_d(direction = -1), 
                  'gg')
})

test_that('scale_fill_scico_d fails as expected',{
  expect_error(base_fill_plot + scale_fill_scico_d(palette = 'inferno'))
  
  expect_error(base_fill_plot + scale_fill_scico_d(alpha = 2))
})
