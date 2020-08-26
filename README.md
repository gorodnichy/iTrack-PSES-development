

# iTrack PSES
 
Full development Code for iTrack PSES Web App: Public Service Employee Survey (PSES) Results Interactive Tracker (https://itrack.shinyapps.io/PSES) - now released to public domain.

Re-use and contributions welcome!

## Raison d'etre behind the App
-------------

As per [TB PSES site](https://www.canada.ca/en/treasury-board-secretariat/services/innovation/public-service-employee-survey/2019-public-service-employee-survey-pses/about-2019-public-service-employee-survey.html
),  
The objective of the Public Service Employee Survey (PSES) is to provide information to support the continuous improvement of people management practices in the federal public service.
The survey results will allow federal departments and agencies to identify their areas of strength and concern related to people management practices, benchmark and track progress over time, and inform the development and refinement of action plans.
Better people management practices lead to better results for the public service, and in turn, better results for Canadians.

Unfortunately however, 
The PSES results, as  published on official TB site (https://www.canada.ca/en/treasury-board-secretariat/services/innovation/public-service-employee-survey.html)
are posted in text (html) mode only, separately for each department and each year.
This makes it rather difficult to use this results to conduct comprehensve multi-factor analysis, e.g.,  to answer such questions as:
- _Which Agency_ (or which is division within the same Agency) has the best resuls -- thus can be used as role model, and
which one has worst ones -- thus needing measured to improve the situation? (result variation analysis)
- _When_ (in which years)_ did  the performance improved / deteriorated in this Agency (or division within the Agency) ? (result dynamics analysis)
- _Which factors_ (which questions) are most likely the main contributors to the observed performance deteriotation or improvement ?  (result correlation analysis)

The iTrack PSES Web App is meant to resolve this limitation.
It introduces a novel 21-century style, data science driven, framework for presenting and analyzing PSES results, 
which provides a very intuative, as much automated as possible, way to obtain answers to above questions. 

The framework is illustrated using the PSES results from the author's home Agency/Directorate (https://itrack.shinyapps.io/PSES-CBSA-SE), 
the PSES results for which from 2008 to 2018 have been aggregated from multiple years and tracked over time and over the organization - compared  vertically
(ie. across the Org. Chart) and  horizontally (across the years) 

The original  plan was to make the iTrack PSES App fully automated for _all Public Service_ and _all years_, 
so that results can be tracked vertically and horizontally for any Public Service agency or department. 
This however has become harder than expected, due to large variation of questions structure accross the years and changes in organizational structures of the organizations.
So, the App is left as is. 

The Code is fully functional, albeit latest revisions have introduced some bugs (which should be easily detected and fixable)

The work is done at author's own time and initiative
in effort to contribute to Public Service performance, as well as means to practice various new concepts and techniques related to doing open responsible Data Science using R and R Studio.

## Acknowelegement

This work would not be possible without the
support of many  colleagues in my Agency and the open R Community. Kudos and big thanks to all of them!





