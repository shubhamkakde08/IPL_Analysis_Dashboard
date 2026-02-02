DAX QUERIES:

Season Winner = 
VAR SelectedSeason = SELECTEDVALUE(ipl_matches_data[season])   --2025

VAR FinalMatchDate = CALCULATE(max(ipl_matches_data[match_date]),
                               ipl_matches_data[season] = SelectedSeason)   --Max Date = 3 June

VAR FinalMatchWinner = CALCULATE(MAX(ipl_matches_data[match_winner]),   --Winner Team
                                 ipl_matches_data[season] = SelectedSeason,
                                 ipl_matches_data[match_date] = FinalMatchDate)

RETURN FinalMatchWinner
                  
------------------------------------------------------------------------------------------------------------------------------------
Season Winner Logo =
 VAR SelectedSeason = SELECTEDVALUE(ipl_matches_data[season])   --2025

VAR FinalMatchDate = CALCULATE(max(ipl_matches_data[match_date]),
                               ipl_matches_data[season] = SelectedSeason)   --Max Date = 3 June

VAR FinalMatchWinner = CALCULATE(MAX(ipl_matches_data[match_winner]),   --Winner Team
                                 ipl_matches_data[season] = SelectedSeason,
                                 ipl_matches_data[match_date] = FinalMatchDate)

RETURN 
LOOKUPVALUE(
    teams_data[image_url],
      teams_data[team_name], FinalMatchWinner)
------------------------------------------------------------------------------------------------------------------------------------
BLUE BACKGROUND
#A0D1FF
Runner Up =
VAR SelectedSeason = SELECTEDVALUE(ipl_matches_data[season])   --2025

VAR FinalMatchDate = CALCULATE(max(ipl_matches_data[match_date]),
                               ipl_matches_data[season] = SelectedSeason)   --Max Date = 3 June

VAR FinalMatchWinner = CALCULATE(MAX(ipl_matches_data[match_winner]),   --Winner Team
                                 ipl_matches_data[season] = SelectedSeason,
                                 ipl_matches_data[match_date] = FinalMatchDate)

VAR Team1 = CALCULATE(MAX(ipl_matches_data[team1]),   --Winner Team
                                 ipl_matches_data[season] = SelectedSeason,
                                 ipl_matches_data[match_date] = FinalMatchDate)

VAR Team2 = CALCULATE(MAX(ipl_matches_data[team2]),   --Winner Team
         ipl_matches_data[season] = SelectedSeason,
          ipl_matches_data[match_date] = FinalMatchDate)

RETURN
IF(FinalMatchWinner=Team1, Team2, Team1)
------------------------------------------------------------------------------------------------------------------------------------

Total 6's =
CALCULATE(COUNTROWS(ball_by_ball_data), ball_by_ball_data[batter_runs] = 6,
          KEEPFILTERS(VALUES(ipl_matches_data[season])))
------------------------------------------------------------------------------------------------------------------------------------
Total 4's = 
CALCULATE(COUNTROWS(ball_by_ball_data), ball_by_ball_data[batter_runs] = 4,
          KEEPFILTERS(VALUES(ipl_matches_data[season])))
------------------------------------------------------------------------------------------------------------------------------------

Total Teams = DISTINCTCOUNT(ipl_matches_data[team1])
------------------------------------------------------------------------------------------------------------------------------------

Centuries = 

VAR SelectedSeason = SELECTEDVALUE(ipl_matches_data[season])

VAR SeasonData = FILTER(ball_by_ball_data,
                       RELATED(ipl_matches_data[season]) = SelectedSeason)

VAR BtterRuns = 

      SUMMARIZE(SeasonData, ball_by_ball_data[match_id],
      ball_by_ball_data[batter], "TotalRuns", SUM(ball_by_ball_data[batter_runs]))

VAR CenturyCount = FILTER(BtterRuns, [TotalRuns] >=100)

RETURN COUNTROWS(CenturyCount)
------------------------------------------------------------------------------------------------------------------------------------

Half Centuries = 

VAR SelectedSeason = SELECTEDVALUE(ipl_matches_data[season])

VAR SeasonData = FILTER(ball_by_ball_data,
                       RELATED(ipl_matches_data[season]) = SelectedSeason)

VAR BtterRuns = 

      SUMMARIZE(SeasonData, ball_by_ball_data[match_id],
      ball_by_ball_data[batter], "TotalRuns", SUM(ball_by_ball_data[batter_runs]))

VAR CenturyCount = FILTER(BtterRuns, [TotalRuns] >=50 && [TotalRuns]<100)
RETURN COUNTROWS(CenturyCount)
------------------------------------------------------------------------------------------------------------------------------------

Total Venues =

CALCULATE(DISTINCTCOUNT(ipl_matches_data[venue]))
------------------------------------------------------------------------------------------------------------------------------------

Orange Cap Holder =
VAR SelectedSeason = SELECTEDVALUE(ipl_matches_data[season])

VAR SeasonDataOnly =
                    FILTER(ball_by_ball_data, RELATED(ipl_matches_data[season]=SelectedSeason))
------------------------------------------------------------------------------------------------------------------------------------

Orange Cap Holder = 

VAR SelectedSeason = SELECTEDVALUE(ipl_matches_data[season])

VAR SeasonDataOnly = 
               FILTER(ball_by_ball_data, RELATED(ipl_matches_data[season]) = SelectedSeason)

VAR RunSummary  =
                SUMMARIZE(SeasonDataOnly, ball_by_ball_data[batter], "Total Runs", SUM(ball_by_ball_data[batter_runs]))

VAR MaxRuns = MAXX(RunSummary, [Total Runs])

VAR TopScorer =
            CALCULATETABLE(VALUES(ball_by_ball_data[batter]), FILTER(RunSummary, [Total Runs]))

RETURN MAXX(TopScorer, ball_by_ball_data[batter])
------------------------------------------------------------------------------------------------------------------------------------


Orange Cap Holder Runs = 

VAR SelectedSeason = SELECTEDVALUE(ipl_matches_data[season])

VAR SeasonDataOnly = 
               FILTER(ball_by_ball_data, RELATED(ipl_matches_data[season]) = SelectedSeason)

VAR RunSummary  =
                SUMMARIZE(SeasonDataOnly, ball_by_ball_data[batter], "Total Runs", SUM(ball_by_ball_data[batter_runs]))

VAR MaxRuns = MAXX(RunSummary, [Total Runs])

RETURN MaxRuns
------------------------------------------------------------------------------------------------------------------------------------

Orange Cap Holder Team Name = 

VAR SelectedSeason = SELECTEDVALUE(ipl_matches_data[season])

VAR SeasonDataOnly = 
               FILTER(ball_by_ball_data, RELATED(ipl_matches_data[season]) = SelectedSeason)

VAR RunSummary  =
                SUMMARIZE(SeasonDataOnly, ball_by_ball_data[batter], "Total Runs", SUM(ball_by_ball_data[batter_runs]))

VAR MaxRuns = MAXX(RunSummary, [Total Runs])
VAR TopScorer =
            CALCULATETABLE(VALUES(ball_by_ball_data[batter]), FILTER(RunSummary, [Total Runs]))

VAR FullTeamName=
                    CALCULATE(MAX(ball_by_ball_data[team_batting], FILTER(SeasonDataOnly, 
                    ball_by_ball_data[batter] = MAXX(TopScorer)))

RETURN 
FullTeamName
------------------------------------------------------------------------------------------------------------------------------------

Orange Cap Image = 

VAR SelectedSeason = SELECTEDVALUE(ipl_matches_data[season])

VAR SeasonDataOnly = 
               FILTER(ball_by_ball_data, RELATED(ipl_matches_data[season]) = SelectedSeason)

VAR RunSummary  =
                SUMMARIZE(SeasonDataOnly, ball_by_ball_data[batter], "Total Runs", SUM(ball_by_ball_data[batter_runs]))

VAR MaxRuns = MAXX(RunSummary, [Total Runs])

VAR TopScorer =
            CALCULATETABLE(VALUES(ball_by_ball_data[batter]), FILTER(RunSummary, [Total Runs] = MaxRuns))

RETURN 

LOOKUPVALUE('players-data-updated'[player_image], 'players-data-updated'[player_name], MAXX(TopScorer, ball_by_ball_data[batter]))
------------------------------------------------------------------------------------------------------------------------------------

#b37400

PurpleCapHolder = 
VAR SelectedSeason = SELECTEDVALUE(ipl_matches_data[season])

-- Filter: wickets in selected season, exclude non-bowler dismissals
VAR SeasonWickets =
    FILTER(
            ball_by_ball_data,
            RELATED(ipl_matches_data[season] = SelectedSeason &&
            ball_by_ball_data[is_wicket] = TRUE() &&
            NOT ball_by_ball_data[wicket kind] IN { "run out", "retired hurt", "obstructing the field","reticed out"}
    )

---Summarize bowler and count wickets
VAR WicketSummary =
        SUMMARIZE(
                SeasonWickets,
                ball_by_ball_data[bowler],
                "WicketCount", COUNTROWS(
                    FILTER(SeasonWickets, ball_by_ball_data[bowler] = EARLIER (ball_by_ball_data[bowler]))
                )
        )

-- Find highest wicket count
VAR MaxWickets = MAXX(WicketSummary, [WicketCount])

-- Get the bowler(s) with that wicket count
VAR TopBowler =
    CALCULATETABLE(
        VALUES(ball_by_ball_data[bowler]),
        FILTER (WicketSummary, [WicketCount] = MaxWickets)
    )

--Return the name (if multiple, it picks one alphabetically) 
RETURN
    MAXX(TopBowler, ball_by_ball_data[bowler])
------------------------------------------------------------------------------------------------------------------------------------


PurpleCapWicketCount = 
VAR SelectedSeason = SELECTEDVALUE(ipl_matches_data[season])

--step 1: Filter valid bowler wickets in selected season
VAR SeasonWickets =
    FILTER(
        ball_by_ball_data,
        RELATED(ipl_matches_data[season]) = SelectedSeason &&
        ball_by_ball_data[is_wicket] = TRUE() &&
        NOT ball_by_ball_data[wicket_kind] IN { "run out", "retired hurt", "obstructing the field", "retired out"}
    )

-- Srep 2: Summazrize wickets per bowler 
VAR WicketSummary =
    SUMMARIZE(
        SeasonWickets,
        ball_by_ball_data[bowler],
        "WicketCount", COUNTROWS(
            FILTER(
                SeasonWickets,
                ball_by_ball_data[bowler] = EARLIER(ball_by_ball_data[bowler])
        )
    )
)

--Step 3: Get the Hghest Wicket Count
VAR MaxWickets = MAXX(WicketSummary, [WicketCount])

RETURN
    MaxWickets
------------------------------------------------------------------------------------------------------------------------------------

        
PurpleCapTeam = 
VAR SelectedSeason = SELECTEDVALUE(ipl_matches_data[season])

--step 1: Filter valid bowler wickets in selected season
VAR SeasonWickets =
    FILTER(
        ball_by_ball_data,
        RELATED(ipl_matches_data[season]) = SelectedSeason &&
        ball_by_ball_data[is_wicket] = TRUE() &&
        NOT ball_by_ball_data[wicket_kind] IN { 
            "run out", 
            "retired hurt", 
            "obstructing the field", 
            "retired out"
        }
    )

-- Srep 2: Summazrize Bowler & Team, Count Wicket Per Bowler
VAR WicketSummary =
    ADDCOLUMNS(
        SUMMARIZE(
        SeasonWickets,
        ball_by_ball_data[bowler],
        ball_by_ball_data[team_bowling]
        ),
        "WicketCount",
        COUNTROWS(
            FILTER(
                SeasonWickets,
                ball_by_ball_data[bowler] = EARLIER(ball_by_ball_data[bowler])
        )
    )
)

--Step 3: Max  Wicket 
VAR MaxWickets = MAXX(WicketSummary, [WicketCount])

--Return full Team Nameof the Top Wicket Taker
RETURN
   MAXX(
     FILTER(WicketSummary,[WicketCount] = MaxWickets),
     ball_by_ball_data[team_bowling]
   )
------------------------------------------------------------------------------------------------------------------------------------


PurpleCapImage = 
VAR SelectedSeason = SELECTEDVALUE(ipl_matches_data[season])

--step 1: Filter valid bowler wickets in selected season
VAR SeasonWickets =
    FILTER(
        ball_by_ball_data,
        RELATED(ipl_matches_data[season]) = SelectedSeason &&
        ball_by_ball_data[is_wicket] = TRUE() &&
        NOT ball_by_ball_data[wicket_kind] IN { 
            "run out", 
            "retired hurt", 
            "obstructing the field", 
            "retired out"
        }
    )

-- Srep 2: Summazrize Bowlerwise wicket count
VAR WicketSummary =
    ADDCOLUMNS(
        SUMMARIZE(
        SeasonWickets,
        ball_by_ball_data[bowler],
        ball_by_ball_data[team_bowling]
        ),
        "WicketCount",
        COUNTROWS(
            FILTER(
                SeasonWickets,
                ball_by_ball_data[bowler] = EARLIER(ball_by_ball_data[bowler])
        )
    )
)

--Step 3: Get Max Wicket Count 
VAR MaxWickets = MAXX(WicketSummary, [WicketCount])

--Step 4: Get the Bowler with Max Wicket
VAR TopBowler =
    CALCULATETABLE(
        VALUES(ball_by_ball_data[bowler]),
        FILTER(WicketSummary, [WicketCount] = MaxWickets)
    )

--Step 4: Return Image using LOOKUP from Player table
RETURN
   LOOKUPVALUE('players-data-updated'[player_image],
   'players-data-updated'[player_name], MAXX(TopBowler, ball_by_ball_data[bowler])
   )
------------------------------------------------------------------------------------------------------------------------------------

        
Top Fours Player Name = 

VAR SelectedSeason = SELECTEDVALUE(ipl_matches_data[season])

var SeasonFours = FILTER(ball_by_ball_data, RELATED(ipl_matches_data[season]) = SelectedSeason &&
                        ball_by_ball_data[batter_runs] = 4 )  

var FourSummary = SUMMARIZE(SeasonFours, ball_by_ball_data[batter], "FoursCount",
                        COUNTROWS(FILTER(SeasonFours, ball_by_ball_data[batter]= EARLIER(ball_by_ball_data[batter]))))

var MaxFours = MAXX(FourSummary, [FoursCount]) 

VAR TopFoursPlayer = CALCULATETABLE(VALUES(ball_by_ball_data[batter]),
                                FILTER(FourSummary, [FoursCount] = MaxFours))

RETURN MAXX(TopFoursPlayer, ball_by_ball_data[batter])

Top Fours Count = 

VAR SelectedSeason = SELECTEDVALUE(ipl_matches_data[season])

var SeasonFours = FILTER(ball_by_ball_data, RELATED(ipl_matches_data[season]) = SelectedSeason &&
                        ball_by_ball_data[batter_runs] = 4 )  

var FourSummary = SUMMARIZE(SeasonFours, ball_by_ball_data[batter], "FoursCount",
                        COUNTROWS(FILTER(SeasonFours, ball_by_ball_data[batter]= EARLIER(ball_by_ball_data[batter]))))

var MaxFours = MAXX(FourSummary, [FoursCount]) 

RETURN MaxFours
------------------------------------------------------------------------------------------------------------------------------------


Top Fours Player Team Name = 

VAR SelectedSeason = SELECTEDVALUE(ipl_matches_data[season])

var SeasonFours = FILTER(ball_by_ball_data, RELATED(ipl_matches_data[season]) = SelectedSeason &&
                        ball_by_ball_data[batter_runs] = 4 )  

var FourSummary = SUMMARIZE(SeasonFours, ball_by_ball_data[batter], "FoursCount",
                        COUNTROWS(FILTER(SeasonFours, ball_by_ball_data[batter]= EARLIER(ball_by_ball_data[batter]))))

var MaxFours = MAXX(FourSummary, [FoursCount]) 

VAR TopFoursPlayer = CALCULATETABLE(VALUES(ball_by_ball_data[batter]),
                                FILTER(FourSummary, [FoursCount] = MaxFours))

VAR BatterTeam =
    CALCULATE(MAX(ball_by_ball_data[team_batting]),
    FILTER(SeasonFours,ball_by_ball_data[batter]= MAXX(TopFoursPlayer, ball_by_ball_data[batter])))

RETURN BatterTeam
------------------------------------------------------------------------------------------------------------------------------------


        


Top Fours Player Image = 

VAR SelectedSeason = SELECTEDVALUE(ipl_matches_data[season])

var SeasonFours = FILTER(ball_by_ball_data, RELATED(ipl_matches_data[season]) = SelectedSeason &&
                        ball_by_ball_data[batter_runs] = 4 )  

var FourSummary = SUMMARIZE(SeasonFours, ball_by_ball_data[batter], "FoursCount",
                        COUNTROWS(FILTER(SeasonFours, ball_by_ball_data[batter]= EARLIER(ball_by_ball_data[batter]))))

var MaxFours = MAXX(FourSummary, [FoursCount]) 

VAR TopFoursPlayer = CALCULATETABLE(VALUES(ball_by_ball_data[batter]),
                                FILTER(FourSummary, [FoursCount] = MaxFours))

RETURN 
        LOOKUPVALUE(
            'players-data-updated'[player_image],
            'players-data-updated'[player_name], MAXX(TopFoursPlayer, ball_by_ball_data[batter]))
------------------------------------------------------------------------------------------------------------------------------------


Top Six Player Image = 

VAR SelectedSeason = SELECTEDVALUE(ipl_matches_data[season])

var SeasonFours = FILTER(ball_by_ball_data, RELATED(ipl_matches_data[season]) = SelectedSeason &&
                        ball_by_ball_data[batter_runs] = 6 )  

var FourSummary = SUMMARIZE(SeasonFours, ball_by_ball_data[batter], "FoursCount",
                        COUNTROWS(FILTER(SeasonFours, ball_by_ball_data[batter]= EARLIER(ball_by_ball_data[batter]))))

var MaxFours = MAXX(FourSummary, [FoursCount]) 

VAR TopFoursPlayer = CALCULATETABLE(VALUES(ball_by_ball_data[batter]),
                                FILTER(FourSummary, [FoursCount] = MaxFours))

RETURN 
        LOOKUPVALUE(
            'players-data-updated'[player_image],
            'players-data-updated'[player_name], MAXX(TopFoursPlayer, ball_by_ball_data[batter]))
------------------------------------------------------------------------------------------------------------------------------------


Top Six Player Team Name = 

VAR SelectedSeason = SELECTEDVALUE(ipl_matches_data[season])

var SeasonFours = FILTER(ball_by_ball_data, RELATED(ipl_matches_data[season]) = SelectedSeason &&
                        ball_by_ball_data[batter_runs] = 6 )  

var FourSummary = SUMMARIZE(SeasonFours, ball_by_ball_data[batter], "FoursCount",
                        COUNTROWS(FILTER(SeasonFours, ball_by_ball_data[batter]= EARLIER(ball_by_ball_data[batter]))))

var MaxFours = MAXX(FourSummary, [FoursCount]) 

VAR TopFoursPlayer = CALCULATETABLE(VALUES(ball_by_ball_data[batter]),
                                FILTER(FourSummary, [FoursCount] = MaxFours))

VAR BatterTeam =
    CALCULATE(MAX(ball_by_ball_data[team_batting]),
    FILTER(SeasonFours,ball_by_ball_data[batter]= MAXX(TopFoursPlayer, ball_by_ball_data[batter])))

RETURN BatterTeam
------------------------------------------------------------------------------------------------------------------------------------

Matches Played =

var SelectedSeasoon = SELECTEDVALUE( ipl_matches_data[season])

VAR Team1Matches = 
                    CALCULATE(COUNTROWS(ipl_matches_data),
                    USERELATIONSHIP(ipl_matches_data[team1], teams_data[team_name]),
                    ipl_matches_data[match_type] = "T20")
VAR Team2Matches = 
                    CALCULATE(COUNTROWS(ipl_matches_data),
                    USERELATIONSHIP(ipl_matches_data[team2], teams_data[team_name]),
                    ipl_matches_data[match_type] = "T20")

RETURN Team1Matches + Team2Matches
------------------------------------------------------------------------------------------------------------------------------------


Matches Won =

VAR SelectedSeason = SELECTEDVALUE(ipl_matches_data[season])

VAR CurrentTeam = SELECTEDVALUE(teams_data[team_name])

RETURN
CALCULATE(COUNTROWS(ipl_matches_data),
        ipl_matches_data[season] = SelectedSeason,
        ipl_matches_data[match_winner] = CurrentTeam,
        ipl_matches_data[match_type] = "T20")
------------------------------------------------------------------------------------------------------------------------------------


Matches Lost = 

var SelectedSeasoon = SELECTEDVALUE( ipl_matches_data[season])

VAR Team1LostMatches = 
                    CALCULATE(COUNTROWS(ipl_matches_data),
                    USERELATIONSHIP(ipl_matches_data[team1], teams_data[team_name]),
                    ipl_matches_data[match_type] = "T20",
                    NOT ISBLANK(ipl_matches_data[match_winner]),
                    ipl_matches_data[match_winner]<> ipl_matches_data[team1]
                    )
                    
VAR Team2LostMatches = 
                    CALCULATE(COUNTROWS(ipl_matches_data),
                    USERELATIONSHIP(ipl_matches_data[team2], teams_data[team_name]),
                    ipl_matches_data[match_type] = "T20",
                    NOT ISBLANK(ipl_matches_data[match_winner]),
                    ipl_matches_data[match_winner]<> ipl_matches_data[team2]
                    )

RETURN Team1Matches + Team2Matches
------------------------------------------------------------------------------------------------------------------------------------


No Result = 

var SelectedSeasoon = SELECTEDVALUE( ipl_matches_data[season])

VAR Team1Matches = 
                    CALCULATE(COUNTROWS(ipl_matches_data),
                    USERELATIONSHIP(ipl_matches_data[team1], teams_data[team_name]),
                    ipl_matches_data[match_type] = "T20",
                    ipl_matches_data[result] = "No Result")
VAR Team2Matches = 
                    CALCULATE(COUNTROWS(ipl_matches_data),
                    USERELATIONSHIP(ipl_matches_data[team2], teams_data[team_name]),
                    ipl_matches_data[match_type] = "T20",
                     ipl_matches_data[result] = "No Result")

RETURN Team1Matches + Team2Matches
------------------------------------------------------------------------------------------------------------------------------------

Tie Matches = 

var SelectedSeasoon = SELECTEDVALUE( ipl_matches_data[season])

VAR Team1Matches = 
                    CALCULATE(COUNTROWS(ipl_matches_data),
                    USERELATIONSHIP(ipl_matches_data[team1], teams_data[team_name]),
                    ipl_matches_data[match_type] = "T20",
                    ipl_matches_data[result] = "Tie")
VAR Team2Matches = 
                    CALCULATE(COUNTROWS(ipl_matches_data),
                    USERELATIONSHIP(ipl_matches_data[team2], teams_data[team_name]),
                    ipl_matches_data[match_type] = "T20",
                     ipl_matches_data[result] = "Tie")

RETURN Team1Matches + Team2Matches
------------------------------------------------------------------------------------------------------------------------------------

