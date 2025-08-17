library("ggplot2")
library("tidyverse")
library("dplyr") #Using this to avail the PIPE operator to Clear out and subset between data-frames.
library("sqldf")
library("scales")
library("jtools")
library("interactions")
library("MASS")
library("knitr")
library("proto")
library("gsubfn")

#Importing the data from Dataset.


Characters <- read.csv('Final/characters.grivg.csv')
Games <- read.csv('Final/games.grivg.csv')
sexualization <- read.csv('Final/sexualization.grivg.csv')

view(Characters)
view(Games)
view(sexualization)

#renaming column name 'game' to 'game_id' which will later be used for merging

Characters <- rename(Characters,Game_Id=Game)

view(Characters)

#merging the two columns Characters and Games of unequal column length (with the argument all.x=TRUE)

CG <- merge(Characters, Games, by = c('Game_Id'), all.x= TRUE)

view(CG)

#merging the combined column(CG) with sexualization using the common 'id' column

CGS <- merge(CG, sexualization, by=c('Id'),all.x=TRUE) 

view(CGS)

##Data-cleaning

#Removing the unwanted columns using the 'PIPE' operator

CGS <- CGS %>%
  dplyr::select(-c(Id, Game_Id, Name, Age, Romantic_Interest, Title, Series, Sub.genre, Developer, Customizable_main, Protagonist,Protagonist_Non_Male, Total_team, female_team, Metacritic, Destructoid, IGN, GameSpot, X, Trophy, Total))

view(CGS)
summary(CGS)

#removing '%' from percentage values

CGS$Percentage_non_male <- as.numeric(sub("%","",CGS$Percentage_non_male))
CGS$Team_percentage <- as.numeric(sub("%","",CGS$Team_percentage))

summary(CGS)

#changing the month'-' value with '20' to make it a year (like 2021)

CGS$Release <- as.numeric(str_replace(CGS$Release,substr(CGS$Release,1,4),"20"))
head(CGS)
sum(is.na(CGS$Relevance))

#changing all capitalized values to lowercase values, replacing the gaps, punctuation with '_'

names(CGS) <- tolower(names(CGS))

CGSCleaned<- function(col) {
  if(is.character(col)){
    col <- tolower(col)
    col <- gsub("[[:punct:][:space:]]",'_',col)
  }
  print(col)
}

CGS <- CGS %>%
  mutate_all(CGSCleaned) #try lapply/sapply

head(CGS)
view(CGS)

summary(CGS)

<!-- gender           age_range            playable      sexualization     -->
  <!-- Length:637         Length:637         Min.   :0.0000   Min.   :0.00000   -->
  <!-- Class :character   Class :character   1st Qu.:0.0000   1st Qu.:0.00000   -->
  <!-- Mode  :character   Mode  :character   Median :0.0000   Median :0.00000   -->
  <!--                                       Mean   :0.1931   Mean   :0.08634   -->
  <!--                                       3rd Qu.:0.0000   3rd Qu.:0.00000   -->
  <!--                                       Max.   :1.0000   Max.   :3.00000   -->
  <!--   species              side            relevance            release     -->
  <!-- Length:637         Length:637         Length:637         Min.   :2012   -->
  <!-- Class :character   Class :character   Class :character   1st Qu.:2014   -->
  <!-- Mode  :character   Mode  :character   Mode  :character   Median :2017   -->
  <!--                                                          Mean   :2017   -->
  <!--                                                          3rd Qu.:2019   -->
  <!--                                                          Max.   :2022   -->
  <!--    genre            publisher           country            platform         -->
  <!-- Length:637         Length:637         Length:637         Length:637         -->
  <!-- Class :character   Class :character   Class :character   Class :character   -->
  <!-- Mode  :character   Mode  :character   Mode  :character   Mode  :character   -->
  
  
  
  <!--      pegi       relevant_males   relevant_no_males percentage_non_male -->
  <!-- Min.   : 3.00   Min.   : 0.000   Min.   : 0.000    Min.   :  0.00      -->
  <!-- 1st Qu.:12.00   1st Qu.: 5.000   1st Qu.: 2.000    1st Qu.: 28.00      -->
  <!-- Median :16.00   Median : 8.000   Median : 5.000    Median : 39.00      -->
  <!-- Mean   :14.19   Mean   : 8.105   Mean   : 4.929    Mean   : 38.28      -->
  <!-- 3rd Qu.:18.00   3rd Qu.:11.000   3rd Qu.: 7.000    3rd Qu.: 47.00      -->
  <!-- Max.   :18.00   Max.   :17.000   Max.   :14.000    Max.   :100.00      -->
  <!--   criteria           director         team_percentage  avg_reviews    -->
  <!-- Length:637         Length:637         Min.   : 0.0    Min.   :7.800   -->
  <!-- Class :character   Class :character   1st Qu.: 0.0    1st Qu.:8.700   -->
  <!-- Mode  :character   Mode  :character   Median : 0.0    Median :9.000   -->
  <!--                                       Mean   :10.9    Mean   :9.051   -->
  <!--                                       3rd Qu.:17.0    3rd Qu.:9.500   -->
  <!--                                       Max.   :67.0    Max.   :9.900   -->
  <!-- sexualized_clothing damsel.in.distress sexualized.cutscenes -->
  <!-- Min.   :0.00000     Min.   :0.00000    Min.   :0.00000      -->
  <!-- 1st Qu.:0.00000     1st Qu.:0.00000    1st Qu.:0.00000      -->
  <!-- Median :0.00000     Median :0.00000    Median :0.00000      -->
  <!-- Mean   :0.02983     Mean   :0.02826    Mean   :0.01727      -->
  <!-- 3rd Qu.:0.00000     3rd Qu.:0.00000    3rd Qu.:0.00000      -->
  <!-- Max.   :1.00000     Max.   :1.00000    Max.   :1.00000   -->
  
  ##end-data-cleaning
  
  ##EDA 
  
  numeric_vars <- CGS[,c(13,14,15,16,19,20)]

#categorical_vars <- names(CGS)[sapply(CGS, is.factor)]

for (column in numeric_vars) {
  hist_plot <- ggplot(CGS, aes_string(x = column)) +
    geom_histogram(fill = "darkblue", color = "black", bins = 20) +
    ggtitle(paste("Histogram of", column)) +
    theme_minimal()
  
  print(hist_plot)
}



for (column in categorical_vars) {
  bar_plot <- ggplot(data=CGS, mapping=aes(column)) +
    geom_bar(fill = "red", color = "black") 
  
  
  print(bar_plot)
}


##end-exploratory-data-analysis


#selecting protagonist with gender

protagonist_side <- sqldf("select gender from CGS where side='p';")

view(protagonist_side)

separated_ps <- protagonist_side %>%
  group_by(gender) %>%
  summarise(n=n())
view(separated_ps)           

###Which of the Female or non-Female characters are majorly associated w/ protagonists?
# Question 1

#using pie chart for visualization with scales package to represent 'percent'
pie(separated_ps$n,labels = percent(separated_ps$n / sum(separated_ps$n)),border='blue',main='pie-chart: %Gender v/s Protagonist',col = c("#1f78b4", "#33a02c", "#b3cde3", "#e5f5e0"))
legend("topleft", legend=separated_ps$gender,fill=c("#1f78b4", "#33a02c", "#b3cde3", "#e5f5e0"),cex = 0.7)


#female population is represented with 35.9% of total when associated with protagonists.
#In majority, Non-female characters are majorly associated with protagonists.

###end-question--------------------------------------------------------------------------------------

###Is there any noticeable correlation between the "Sexualization" of women characters and their "Side"?
# Question 2
#Changing the values - 0,1,2,3 to no,low,moderate & High sexualization for better understanding.

CGS$sexualization <- replace(CGS$sexualization, CGS$sexualization %in% c(0,1,2,3),c('no_sexualization','slight_sexualization','moderate_sexualization','high_sexualization'))
head(CGS)

side_sexualization <- data.frame(CGS$sexualization,CGS$side)
table(side_sexualization)
print(chisq.test(table(side_sexualization)))

###end-question--------------------------------------------------------------------------------------

#How does the representation of women characters vary across different "Countries" and "Platforms" in video games?
# Question 3

attach(CGS)

women <- sqldf("select platform, country from CGS where gender = 'female' ") 
women_count <- table(women$platform,women$country)

barplot(women_count,col=c("Red", "Blue", "Green", "Yellow", "Purple", "Orange", "Pink", "Brown", "black", "Gray", "Violet" ),ylab="Count ( women ) ", xlab="Country",beside=TRUE)

legend('topleft',legend=rownames(women_count),cex=0.69,fill=c("Red", "Blue", "Green", "Yellow", "Purple", "Orange", "Pink", "Brown", "black", "Gray", "Violet" ),text.width=10)


###end-question--------------------------------------------------------------------------------------

###Are there any discernible patterns in the reception and representation of women characters based on "Avg_Reviews" and "Country" or "Platform"?
# Question 4

female_genre <- sqldf("select genre from CGS where gender='female';")
barplot(table(female_genre),col=c('#000000','#282625','#4A4745','#77736E','#A7A3A0','#D5D4D2'),main='barplot of female distribution based on genre')

###end-question--------------------------------------------------------------------------------------

# What genres of video games tend to prioritize or feature a higher
# representation of women characters?
# Question 5

gender.genre <- data.frame(gender = CGS2$gender, genre = CGS2$genre)

ggplot(gender.genre, aes(x = gender)) + 
  geom_bar(aes(group = genre, fill = genre), position = "dodge") +
  ggtitle("Gender by Genre") + labs(x = "Gender")


###end-question---------------------------------------------------------------

# correlation between % of women in team and sexualization of female characters
#Question 6

ggplot(CGS2, aes(x = team_percentage, y = sexualization, col = director)) +
  geom_point() + 
  ggtitle("% of female team members vs # of misogynistic tropes") +
  labs(x = "% of women in game's team", y = "# of misogynistic tropes per character")

###end-question---------------------------------------------------------------

#  How has the representation of women characters in video games evolved over different "Release" years?
# Question 7

gender.release <- data.frame(gender = CGS2$gender, release = CGS2$release)

yearName <- paste0('year', gender.release$release)
year.split <- split(gender.release, yearName)

table12 <- table(year.split$year2012$gender)
table13 <- table(year.split$year2013$gender)
table14 <- table(year.split$year2014$gender)
table15 <- table(year.split$year2015$gender)
table16 <- table(year.split$year2016$gender)
table17 <- table(year.split$year2017$gender)
table18 <- table(year.split$year2018$gender)
table19 <- table(year.split$year2019$gender)
table20 <- table(year.split$year2020$gender)
table21 <- table(year.split$year2021$gender)
table22 <- table(year.split$year2022$gender)

year.data <- data.frame(m = c(as.numeric(table12)[2], as.numeric(table13)[2],
                              as.numeric(table14)[3], as.numeric(table15)[3], 
                              as.numeric(table16)[3], as.numeric(table17)[3], 
                              as.numeric(table18)[2], as.numeric(table19)[3], 
                              as.numeric(table20)[2], as.numeric(table21)[2], 
                              as.numeric(table22)[3]),
                        f = c(as.numeric(table12)[1], as.numeric(table13)[1],
                              as.numeric(table14)[2], as.numeric(table15)[2], 
                              as.numeric(table16)[2], as.numeric(table17)[2], 
                              as.numeric(table18)[1], as.numeric(table19)[2], 
                              as.numeric(table20)[1], as.numeric(table21)[1], 
                              as.numeric(table22)[2]),
                        nb = c(as.numeric(table12)[3], as.numeric(table13)[3],
                               as.numeric(table14)[4], as.numeric(table15)[4], 
                               0, as.numeric(table17)[4], as.numeric(table18)[3], 
                               0, as.numeric(table20)[3], as.numeric(table21)[3], 
                               as.numeric(table22)[4]),
                        c = c(0, 0, as.numeric(table14)[1],
                              as.numeric(table15)[1], as.numeric(table16)[1],
                              as.numeric(table17)[1], 0, as.numeric(table19)[1], 
                              0, 0, as.numeric(table22)[1]),
                        years = c(2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019,
                                  2020, 2021, 2022))

ggplot(year.data) + geom_line(aes(x = years, y = m, col = "male")) +
  geom_line(aes(x = years, y = f, col = "female")) +
  geom_line(aes(x = years, y = nb, col = "non-binary")) +
  geom_line(aes(x = years, y = c, col = "custom")) +
  ggtitle("Gender representation vs Years") + 
  labs(y = "Frequency of Gender", x = "Years")

###end-question---------------------------------------------------------------

# Are there noticeable trends in the portrayal of women characters, and how do these trends align with changes in "Avg_Reviews" over time?
#Question 8

ggplot(CGS2, aes(x = release)) +
  geom_bar(aes(group = sexualization, fill = sexualization)) +
  ggtitle("Sexualization by year")
###end-question---------------------------------------------------------------


##Understanding the relationship between different 'categorical' variables using "Interactions"

library(jtools)

#Categorizing the many variables into consolidated range
CGS<- CGS[CGS$age_range != 'infant',]
CGS$age_range[CGS$age_range=='child' | CGS$age_range=='teenager'] <- 'minors'
CGS$age_range[CGS$age_range=='young_adult' | CGS$age_range=='adult'] <- 'adults'
CGS$age_range[CGS$age_range=='elderly' | CGS$age_range=='middle_aged'] <- 'old'
 
CGS$gender <- factor(CGS$gender)
CGS$sexualization <- factor(CGS$sexualization)
CGS$age_range <- factor(CGS$age_range)

#fitting the variables with interactions as a linear model
fit_gsa <- lm(percentage_non_male ~ gender * sexualization, data=CGS)
summ(fit_gsa)

cat_plot(fit_gsa, pred = gender, modx = sexualization,plot.points = TRUE)


##understanding the relation between sexualization with platform, average reviews and relevance.
#fitting a linear model
model <- lm(sexualization ~ platform + avg_reviews, data = CGS)
model


##understanding the relation between sexualized clothing with platform, average review and relevance.
##Applying a binary logistic model while fitting with a generalised linear model.

platform_df <- as.factor(platform)

logistic_model <- glm(CGS$sexualized_clothing ~ CGS$platform+ avg_reviews + relevance, 
                      family = binomial, data = CGS)

summary(logistic_model)

AIC(logistic_model)

BIC(logistic_model)

#plotting the model with residuals and fitted-values.
<!-- plot(fitted(model), residuals(model), xlab = "Fitted Values", ylab = "Residuals",  -->
            <!--      main = "Residuals vs. Fitted Values", col = "blue", pch = 16) -->
  <!-- #abline(h = 0, col = "red", lty = 2) -->
  
  plot(logistic_model)

#performing analysis of variances between age range and average reviews to check if the mean average reviews are equal across all age range.

model_anova <- lm(avg_reviews ~ age_range, data = CGS)
anova(model_anova)

summary(model_anova)

#since the p-value is less than 0.5, the hull hypothesis can be rejected. This means that at least one age range has a different mean average reviews.

#fitting a logistic regression model to predict the cumulative odds of the different categories of an ordinal response variable (pegi rating) based on several other predictors (gender, age range, playable)

model_for_pegi <- polr(factor(pegi) ~ gender + age_range + playable, data = CGS)
summary(model_for_pegi)



