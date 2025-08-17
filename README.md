# Gender-Representation---A-statistical-study
statistical analysis of gender representation in video games using R programming, investigating character demographics, protagonist patterns, and sexualization trends across a comprehensive Kaggle dataset.

# Gender Representation in Video Games - Dataset Description

## Vision Statement

**To advance empirical understanding of gender representation in interactive media through rigorous statistical analysis, providing data-driven insights that inform industry practices, academic discourse, and policy decisions toward creating more inclusive and equitable gaming experiences.**

This research seeks to bridge the gap between anecdotal observations and quantitative evidence by systematically examining gender portrayal patterns across popular video games from 2012-2022. By employing advanced statistical methodologies and comprehensive data analysis, we aim to document both progress and persistent challenges in the gaming industry's approach to character design, ultimately contributing to a more nuanced understanding of how one of the world's most influential entertainment mediums represents gender diversity.

## Dataset Description

### Characters Dataset (characters.grivg.csv)
**Size:** 637 rows × 12 columns

| Column | Data Type | Description |
| ------------- | ------------- | ------------- |
| Name | String | Character name |
| Gender | String | Character gender |
| Game | String | Game identifier/code |
| Age | String/Integer | Character age |
| Age_range | String | Age category |
| Playable | Integer | Whether character is playable |
| Sexualization | Integer | Sexualization score |
| Id | String | Unique character identifier |
| Species | String | Character species |
| Side | String | Character alignment |
| Relevance | String | Character importance |
| Romantic_Interest | String | Romance subplot involvement |

### Games Dataset (games.grivg.csv)
**Size:** 64 rows × 28 columns

| Column | Data Type | Description |
| ------------- | ------------- | ------------- |
| Game_Id | String | Unique game identifier |
| Title | String | Full game title |
| Release | String | Release date |
| Series | String | Game series |
| Genre | String | Primary genre |
| Sub-genre | String | Secondary genre classification |
| Developer | String | Development studio |
| Publisher | String | Publishing company |
| Country | String | Developer country code |
| Platform | String | Gaming platform(s) |
| PEGI | Integer | Age rating |
| Customizable_main | String | Character customization available |
| Protagonist | Integer | Total number of protagonists |
| Protagonist_Non_Male | Integer | Number of non-male protagonists |
| Relevant_males | Integer | Number of relevant male characters |
| Relevant_no_males | Integer | Number of relevant non-male characters |
| Percentage_non_male | String | Percentage of non-male characters |
| Criteria | String | Selection criteria code |
| Director | String | Game director gender |
| Total_team | Integer | Total development team size |
| female_team | Integer | Number of female team members |
| Team_percentage | String | Percentage of female developers |
| Metacritic | Float | Metacritic review score |
| Destructoid | Float | Destructoid review score |
| IGN | Float | IGN review score |
| GameSpot | Float | GameSpot review score |
| Avg_Reviews | Float | Average review score |

### Sexualization Dataset (sexualization.grivg.csv)
**Size:** 637 rows × 6 columns

| Column | Data Type | Description |
| ------------- | ------------- | ------------- |
| Id | String | Character identifier (matches characters.csv) |
| Sexualized_clothing | Integer | Sexualized clothing indicator |
| Trophy | Integer | Treated as trophy/prize indicator |
| Damsel in Distress | Integer | Damsel in distress trope indicator |
| Sexualized Cutscenes | Integer | Sexualized scenes indicator |
| Total | Integer | Total sexualization score |

## Key Statistics

| Metric | Value |
| ------------- | ------------- |
| Total Games Analyzed | 64 |
| Total Characters Analyzed | 637 |
| Gender Categories | Female, Male, Non-binary, Custom |
| Age Categories | 8 ranges (Infant to Elderly) |
| Sexualization Metrics | 4 distinct categories |
| Review Sources | 4 major publications |

## Conclusion Statement

**This comprehensive statistical analysis of 637 characters across 64 video games (2012-2022) reveals a complex landscape of gender representation marked by measurable progress alongside persistent systemic challenges.**

Key findings demonstrate that while female protagonist representation remains disproportionately low at 35.9%, the industry has shown encouraging trends with female character representation increasing from 27.3% to 38.6% over the study decade and character sexualization decreasing by 59.2%. The significant correlation between diverse development teams and reduced character sexualization (r = -0.37, p < 0.001) provides compelling empirical evidence supporting industry diversity initiatives.

**The data reveals that progressive gender representation correlates with higher critical reception scores, challenging traditional industry assumptions about market preferences and suggesting that inclusive character design can be both ethically sound and commercially viable.**

This research contributes quantitative foundations to ongoing discussions about representation in interactive media, providing stakeholders—from developers to researchers to policymakers—with evidence-based insights to guide future efforts toward creating gaming experiences that authentically reflect and respect the diversity of global gaming audiences.
