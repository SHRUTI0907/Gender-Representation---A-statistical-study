# Gender-Representation---A-statistical-study
statistical analysis of gender representation in video games using R programming, investigating character demographics, protagonist patterns, and sexualization trends across a comprehensive Kaggle dataset.

## Dataset Description

### Characters Dataset (characters.grivg.csv)
**Size:** 637 rows × 12 columns

| Column | Data Type | Description | Example Values |
| ------------- | ------------- | ------------- | ------------- |
| Name | String | Character name | Farah, Arthur Morgan |
| Gender | String | Character gender | Female, Male, Non-binary, Custom |
| Game | String | Game identifier/code | CODMW, RDR2 |
| Age | String/Integer | Character age | 27, Unknown |
| Age_range | String | Age category | Adult, Teenager, Child, Young adult, Middle-aged, Elderly, Infant, Unknown |
| Playable | Integer | Whether character is playable | 1 (Yes), 0 (No) |
| Sexualization | Integer | Sexualization score | 0-4 scale |
| Id | String | Unique character identifier | CODMW_Farah |
| Species | String | Character species | Human, Robot |
| Side | String | Character alignment | P (Protagonist), A (Antagonist), N (Neutral) |
| Relevance | String | Character importance | PA (Primary), SE (Secondary) |
| Romantic_Interest | String | Romance subplot involvement | Yes, No |

### Games Dataset (games.grivg.csv)
**Size:** 64 rows × 28 columns

| Column | Data Type | Description | Example Values |
| ------------- | ------------- | ------------- | ------------- |
| Game_Id | String | Unique game identifier | GTAV, RDR2 |
| Title | String | Full game title | Grand Theft Auto V |
| Release | String | Release date | Nov-13, Oct-18 |
| Series | String | Game series | GTA, Red Dead |
| Genre | String | Primary genre | Action-adventure, RPG |
| Sub-genre | String | Secondary genre classification | Open world, Shooter |
| Developer | String | Development studio | Rockstar North |
| Publisher | String | Publishing company | Rockstar Games |
| Country | String | Developer country code | USA, GBR, JPN |
| Platform | String | Gaming platform(s) | Multi, PC, Console |
| PEGI | Integer | Age rating | 12, 16, 18 |
| Customizable_main | String | Character customization available | Yes, No |
| Protagonist | Integer | Total number of protagonists | 1, 2, 3 |
| Protagonist_Non_Male | Integer | Number of non-male protagonists | 0, 1, 2 |
| Relevant_males | Integer | Number of relevant male characters | 3, 9, 12 |
| Relevant_no_males | Integer | Number of relevant non-male characters | 2, 5, 8 |
| Percentage_non_male | String | Percentage of non-male characters | 18%, 33% |
| Criteria | String | Selection criteria code | MS, FS |
| Director | String | Game director gender | M, F |
| Total_team | Integer | Total development team size | 5, 7, 12 |
| female_team | Integer | Number of female team members | 0, 1, 3 |
| Team_percentage | String | Percentage of female developers | 0%, 14% |
| Metacritic | Float | Metacritic review score | 9.7, 8.5 |
| Destructoid | Float | Destructoid review score | 9.0, 7.5 |
| IGN | Float | IGN review score | 10.0, 8.0 |
| GameSpot | Float | GameSpot review score | 9.0, 7.0 |
| Avg_Reviews | Float | Average review score | 9.4, 8.2 |

### Sexualization Dataset (sexualization.grivg.csv)
**Size:** 637 rows × 6 columns

| Column | Data Type | Description | Range |
| ------------- | ------------- | ------------- | ------------- |
| Id | String | Character identifier (matches characters.csv) | CODMW_Farah |
| Sexualized_clothing | Integer | Sexualized clothing indicator | 0 (No), 1 (Yes) |
| Trophy | Integer | Treated as trophy/prize indicator | 0 (No), 1 (Yes) |
| Damsel in Distress | Integer | Damsel in distress trope indicator | 0 (No), 1 (Yes) |
| Sexualized Cutscenes | Integer | Sexualized scenes indicator | 0 (No), 1 (Yes) |
| Total | Integer | Total sexualization score | 0-4 (sum of above metrics) |

## Key Statistics

| Metric | Value |
| ------------- | ------------- |
| Total Games Analyzed | 64 |
| Total Characters Analyzed | 637 |
| Gender Categories | Female, Male, Non-binary, Custom |
| Age Categories | 8 ranges (Infant to Elderly) |
| Sexualization Metrics | 4 distinct categories |
| Review Sources | 4 major publications |
