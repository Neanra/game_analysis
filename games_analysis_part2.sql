USE games_info;

SELECT ins.Game_ID, ins.Platform, ins.Install_Date, SUM(pay.Payment_Amount) AS Total_Revenue FROM
(SELECT Game_ID, Platform, Device_ID, date(Install_DateTime) AS "Install_Date"
FROM installs WHERE (Game_id = "Tina's journey" OR Game_id = "Happy Farm") AND (Platform = "iOS" OR Platform = "Android") 
AND (Install_DateTime BETWEEN "2019-05-01" AND "2019-06-01") AND Install_Type = "First Install") AS ins
JOIN
(SELECT Game_ID, Platform, Device_ID, date(Payment_DateTime) AS "Payment_Date", Payment_Amount
FROM payments WHERE (Game_id = "Tina's journey" OR Game_id = "Happy Farm") AND (Platform = "iOS" OR Platform = "Android") 
AND (Payment_DateTime BETWEEN "2019-05-01" AND "2019-06-01")) AS pay
ON ins.Game_ID = pay.Game_ID AND ins.Platform = pay.Platform AND ins.Device_ID = pay.Device_ID AND ins.Install_Date = pay.Payment_Date
GROUP BY Game_ID, Platform, Install_Date
ORDER BY Install_Date;