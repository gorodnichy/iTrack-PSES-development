# source("PSES_plotFunctions.R")
source("PSES_functions.R")

image_smileys <- readPNG("feedback2.png")

#theme_set(theme_bw())
# theme_set(theme_gray())
# theme_set(theme_minimal()) 

# Read and Run PSES data ---- 
if (F) {
  source("readSED+QuestionMapping.R") # PSES-read-question-mapping.R")
}
if (F) {
  readPsesData()

  
  setkeyv(dtDepartments,PSES_ID_COLS)  
  dtRESULT <<- dtPSES[SURVEYR %in% c(2018)][
    selectDepts (id=myID), on=PSES_ID_COLS][
      dtQuestions, on="QUESTION"]
  
  
  ############################################################## #
  # TEST:  Depts_vs_Scores ------------------------------ 
  
  strTitle = dtQuestions[QUESTION=="Q42"]$Question
  strSubtitle = "(Number of responses is indicated in the box)"
  
  # dtRESULT <<- dtPSES[SURVEYR %in% c(2018)][
  #   dtDeptSelected, on=PSES_ID_COLS][
  #     dtQuestions[QUESTION %in% "Q42"], on="QUESTION"]
  
  dtRESULT <<- dtRESULT[QUESTION %in% "Q42"]
  
  # dtRESULT <<- dtRESULT[IDlevel <=  getLevel(id)+1]
  
  Depts_vs_Scores(input)
  
  ############################################################## #
  # TEST:  Questions_vs_Scores ----  
  
  strSubtitle <- paste(dtDepartments[as.list(id)]$pathString, "(coloured) vs. Public Service (black)")
  strTitle <- "Public Service Employee Survey Results"
  
  strCaptionCredits <-  paste0("Generated on ", format(Sys.time(), "%d %B, %Y"), " by iTrack\n License: Open Government Licence - Canada\n https://itrack.shinyapps.io/PSES")
  
  
  Questions_vs_Scores()
  
}


plotPSES.layout <- function (input) {
  ggplot(dtRESULT
         # dtRESULT[SURVEYR==input$year],
         # dtRESULT[IDlevel <=  getLevel(myID)+1],
         )  + 
    theme_bw() +
    # geom_text(aes(x,y, label=":("), data=data.table(x=40,y=ySmiley/2),size=6) +
    # geom_text(aes(x,y, label=":)"), data=data.table(x=60,y=ySmiley/2),size=6)  + 
    scale_x_continuous(breaks=(3:9)*10, limit=c(30,90)) +
    geom_vline(aes(xintercept=50), col="black", linetype=4) +
    labs(
      x="Score = Positive responses / All responses (%)",
      y=NULL,
      caption = paste0("License: Open Government Licence - Canada\n Generated", #  on ", format(Sys.time(), "%d %B, %Y"), 
                       " by iTrack (https://itrack.shinyapps.io/PSES)")
    ) 
}


################################################################### #
Depts_vs_Scores <-  function(input)  {
  

  
  if (T) {
    g <- plotPSES.layout(input) + 

      annotation_raster(image_smileys, xmin = 46, xmax = 54, ymin = 0.2, ymax = 1.8) +
      geom_vline(aes(xintercept=dtRESULT[SURVEYR==input$year & IDlevel==0]$SCORE100), linetype=4,  col="black") +
      #guides(colour = guide_legend("Public Service average")) +
      
      # geom_point(aes(SCORE100, Organization, col=SURVEYR),size=10, alpha=0.2) +
      geom_label(aes(SCORE100, Organization, 
                     label=ANSCOUNT,
                    fill=SURVEYR
                    ), alpha=0.2) +
      ##guides(fill = guide_legend("Theme")) + 
      ## scale_fill_brewer(palette = "Blues")  
      # guides(size="none") +
      # guides(colour="none") +
      # guides(fill="none")
    guides(fill= guide_legend("SURVEY YEAR")) + 
      theme(legend.position = "bottom")   
  }
  
  g
}



################################################################### #
Questions_vs_Scores <- function(input)  {
  # if (dtRESULT %>% nrow == 0)
  #   return (NULL)

    
    if (input$sortby =="name"){
      dtRESULT[ , Question.Abbreviated := reorder(Question.Abbreviated , nTheme )] 
    } else if (input$sortby =="number of responses"){
      dtRESULT[ , Question.Abbreviated := reorder(Question.Abbreviated, ANSCOUNT)]
    } else if (input$sortby =="score"){
      dtRESULT[ , Question.Abbreviated := reorder(Question.Abbreviated , -SCORE100) ]
    } else {
      dtRESULT[ , Question.Abbreviated := reorder(Question.Abbreviated , RANK100) ]
      
    }
    
 # dtRESULT[ , Question.Abbreviated := as.character(Question.Abbreviated)]
 # dtRESULT[ , Question.Abbreviated := reorder(Question.Abbreviated , -nTheme )] 
  
  # if (sortbyscore){
  #   dtRESULT[ , Question.Abbreviated := reorder(Question.Abbreviated , -SCORE100) ]
  # }else {
  #   #   dtRESULT[ , Question.Abbreviated := as.ordered(Question.Abbreviated )]
  #   dtRESULT[ , Question.Abbreviated := reorder(Question.Abbreviated , nTheme )] 
  # }

  
  # Show only for parents, not children
  #dtRESULT <<- dtRESULT[level <=  myLevel(id)]
  #   # Show only for children
  #dtRESULT <<- dtRESULT[level >=  myLevel(id)]
  
  g <-  plotPSES.layout()  + 
    guides(col= guide_legend("Theme")) + 
    theme(legend.position = "bottom")  +    
    annotation_raster(image_smileys, xmin = 46, xmax = 54, ymin = 0, ymax = 5) +
    
    geom_point(data=dtRESULT[IDlevel==getLevel(myID)],mapping=aes(SCORE100, Question.Abbreviated, col=as.ordered(Theme)) , size=7, alpha=0.8) +
    
    geom_label(data=dtRESULT[IDlevel==getLevel(myID)],mapping=aes(SCORE100, Question.Abbreviated, label=RANK100) ,  alpha=0.4) +
    
    geom_point(data=dtRESULT[IDlevel==0],mapping=aes(SCORE100, Question.Abbreviated), 
               size=7,  shape=3, col="black") + # shape=15)
    
    
    geom_point(data=dtRESULT[as.integer(IDlevel)>getLevel(myID)],mapping=aes(SCORE100, Question.Abbreviated, col=as.ordered(Theme)), size=2, alpha=0.1) 
  # + 
  #   
  #   geom_point(data=dtRESULT[level==myLevel(id)+2],mapping=aes(SCORE100, Question.Abbreviated, col=as.ordered(Theme)), size=1, alpha=0.6) 
  #   
  #   
  
  dtRESULT[ , Question.Abbreviated := as.character(Question.Abbreviated)]
  
  
  g
  
}


if(F) { # extra left -----
  
  ySmiley <- sort(dtRESULT$Organization)[as.integer(length(dtRESULT$Organization))]
  geom_text(aes(x,y, label=":("), data=data.table(x=40,y=ySmiley),size=6) +
    geom_text(aes(x,y, label=":)"), data=data.table(x=80,y=ySmiley),size=6) 
  
  
  
  
  if (F) {# Brrr does not work ...{
    if (sortbyscore){
      dtRESULT[ , Question.Abbreviated:= factor(Question.Abbreviated, levels = Question.Abbreviated[order(SCORE100)]) ]
    }else {
      dtRESULT$Question.Abbreviated <- factor(dtRESULT$Question.Abbreviated, levels = dtRESULT$Question.Abbreviated[order(dtRESULT$nTheme)])
      
    }
    
  }
  if (F) {
    dtRESULT$level <- factor(dtRESULT$level,  levels = order(dtRESULT$level,decreasing=T))
    
    # DOES NOT WORK
    dtRESULT$Question.Abbreviated <- ordered(dtRESULT$Question.Abbreviated, levels = dtRESULT$Question.Abbreviated[order(dtRESULT$nTheme)])
    
    # WORKS
    dtQuestions$Question.Abbreviated <- ordered(dtQuestions$Question.Abbreviated, levels = dtQuestions$Question.Abbreviated[order(dtQuestions$nTheme)])
  }
  
  
  
  #input$theme
  psesSED.plotThemeByTime_facets <- function(.dt, .strTheme) {
    
    
    dt <- .dt[Theme == .strTheme]; dt
    
    ggplot(dt) +  
      geom_hline(aes(yintercept=50), size=1, linetype=2, col="red") +
      
      geom_hline(aes(yintercept=Score, linetype=as.factor(2)),
                 data=dt[Year==2018 & Organization == "Public Service"],
                 size=2,  col="grey") +
      scale_linetype_discrete(name="", labels="Public Service average") +
      
      
      geom_line(aes(Year, Score),size=1,linetype=4,col="blue",
                data=dt[Organization == "SCIENCE AND ENGINEERING"]) + 
      
      geom_label(aes(Year, Score, # label=get("Total responses"))
                     fill=Organization, label=Score), 
                 data=dt[Organization != "Public Service"]) + 
      #scale_fill_brewer("blues", name="")+  
      scale_fill_discrete(name="") +
      
      #scale_fill_discrete(name="", labels=unique(dt$Organization) ) +
      #c("CBSA", "ISTB", "SED") )+
      theme(legend.position = "bottom")+
      facet_wrap(. ~ Question) +
      
      #guides(fill="none") +  
      guides(col="none") +  
      scale_x_continuous(limits=c(2010,2019),breaks=c(2011,2014,2018)) +
      # scale_y_continuous(limit=c(40,80)) +
      
      
      
      
      labs(
        #      y="Score = Positive responses / All responses",
        #      subtitle = paste0("Departments: ", myLEVEL1ID, "/",myLEVEL2ID, "/", myLEVEL3ID, "/", myLEVEL4ID, 
        #                       " (Number of respondents is provided in the box)"),
        #      caption = strCaptionCredits,
        title=.strTheme
      ) 
  }
  
  
  
  
  
  
}



# ALSO SEE examples: ------
# 
# 
if (F) {
#https://sebastiansauer.github.io/plotting_surveys/
ggplot(dtRESULT, aes(x = items)) +
  geom_bar(aes(fill = answer), position = "fill") 
  
}


if (F) {
#https://rmarkdown.rstudio.com/flexdashboard/examples.html
# highcharter
#
# https://beta.rstudioconnect.com/jjallaire/htmlwidgets-highcharter/htmlwidgets-highcharter.html
# also different title bar:
# http://jkunst.com/flexdashboard-highcharter-examples/pokemon/
# 
}