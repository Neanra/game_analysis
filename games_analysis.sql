USE games_info;

DROP TABLE IF EXISTS Base;
CREATE TEMPORARY TABLE Base SELECT DISTINCT Game_id, Platform, date(Install_DateTime) AS "Install_Date"
FROM installs WHERE (Game_id = "Tina's journey" OR Game_id = "Happy Farm") 
AND (Platform = "iOS" OR Platform = "Android") AND (Install_DateTime BETWEEN "2019-05-01" AND "2019-06-01");

DROP TABLE IF EXISTS FirstInstalls;
CREATE TEMPORARY TABLE FirstInstalls SELECT DISTINCT COUNT(Install_Type) AS "Total_First_Installs", Game_id, Platform, date(Install_DateTime) AS "Install_Date"
FROM installs WHERE (Game_id = "Tina's journey" OR Game_id = "Happy Farm") AND (Platform = "iOS" OR Platform = "Android") 
AND (Install_DateTime BETWEEN "2019-05-01" AND "2019-06-01") AND Install_Type = "First Install"
GROUP BY Game_id, Platform, date(Install_DateTime);

DROP TABLE IF EXISTS Reinstalls;
CREATE TEMPORARY TABLE Reinstalls SELECT DISTINCT COUNT(Install_Type) AS "Total_Reinstalls", Game_id, Platform, date(Install_DateTime) AS "Install_Date"
FROM installs WHERE (Game_id = "Tina's journey" OR Game_id = "Happy Farm") 
AND (Platform = "iOS" OR Platform = "Android") AND (Install_DateTime BETWEEN "2019-05-01" AND "2019-06-01") AND Install_Type = "Reinstall"
GROUP BY Game_id, Platform, date(Install_DateTime);

DROP TABLE IF EXISTS temp1;
CREATE TEMPORARY TABLE temp1 SELECT Base.Game_id, Base.Platform, Base.Install_Date, FirstInstalls.Total_First_Installs 
FROM Base LEFT JOIN FirstInstalls 
ON FirstInstalls.Game_id = Base.Game_id AND FirstInstalls.Platform = Base.Platform AND FirstInstalls.Install_Date = Base.Install_Date;

DROP TABLE IF EXISTS temp2;
CREATE TEMPORARY TABLE temp2 SELECT Base.Game_id, Base.Platform, Base.Install_Date, FirstInstalls.Total_First_Installs 
FROM Base RIGHT JOIN FirstInstalls 
ON FirstInstalls.Game_id = Base.Game_id AND FirstInstalls.Platform = Base.Platform AND FirstInstalls.Install_Date = Base.Install_Date;

DROP TABLE IF EXISTS temp;
CREATE TEMPORARY TABLE temp SELECT * FROM temp1 UNION SELECT * FROM temp2;

DROP TABLE IF EXISTS temp3;
CREATE TEMPORARY TABLE temp3 SELECT temp.Game_id, temp.Platform, temp.Install_Date, temp.Total_First_Installs, Reinstalls.Total_Reinstalls 
FROM temp LEFT JOIN Reinstalls 
ON temp.Game_id = Reinstalls.Game_id AND temp.Platform = Reinstalls.Platform AND temp.Install_Date = Reinstalls.Install_Date;

DROP TABLE IF EXISTS temp4;
CREATE TEMPORARY TABLE temp4 SELECT temp.Game_id, temp.Platform, temp.Install_Date, temp.Total_First_Installs, Reinstalls.Total_Reinstalls 
FROM temp RIGHT JOIN Reinstalls 
ON temp.Game_id = Reinstalls.Game_id AND temp.Platform = Reinstalls.Platform AND temp.Install_Date = Reinstalls.Install_Date;

SELECT Game_id, Platform, Install_Date, IFNULL(Total_First_Installs, 0) as Total_First_Installs, IFNULL(Total_Reinstalls, 0) as Total_Reinstalls 
FROM temp3 
UNION 
SELECT Game_id, Platform, Install_Date, IFNULL(Total_First_Installs, 0) as Total_First_Installs, IFNULL(Total_Reinstalls, 0) as Total_Reinstalls 
FROM temp4;