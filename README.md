# game_analysis
1.
We need to find out how many users per day install the app for the first time and how many users reinstall it.
For the purposes of this task each unique device is treated as one user. The data must be grouped according to the following criteria:
* Game title
* Platform
* Date of installation

Only users matching these conditions must be taken into account:
* They play Tina's journey or Happy Farm
* They play on Android and iOS
* Installed the app between 2019-05-01 to 2019-06-01

The data, which is required to complete this task, may be taken from `installs` table. It's structure is as follows:
* Game_ID - game title, e.g.: "Tina's journey", "Happy Farm", "Secrets of the East", "Pirate Adventures".
* Platform - platform, e.g.: “Android”, “Facebook”, “iOS”.
* Device_ID - device ID, e.g.: “4992f28a11fb4370b4858d9ac4029e8f”.
* Install_DateTime - date and time of installation: “2019-02-01 19:00:45”.
* Install_Type - kind of installation: “First Install”, “Reinstall”.

SQL statement must yield a table, satisfying the conditions above and having the following structure:
* Game_ID - game title; according to the conditions, only Tina's journey and Happy Farm must be included
* Platform - platform, on which the user plays; according to the conditions, only Android and iOS must be included
* Install_Date - installation date; according to the conditions this must be between 2019-05-01 and 2019-06-01.
* Total_First_Installs - number of users who have installed the app for the first time within the specified period.
* Total_Reinstalls - number of users who have reinstalled the app within the specified period.

2.
We need to find out how much money the users pay within the first day since installation. This data must be grouped by the following criteria:
* Game title
* Platform
* Date of installation
Only users matching these conditions must be taken into account:
* They play Tina's journey or Happy Farm
* They play on Android and iOS
* Installed the app between 2019-05-01 to 2019-06-01

The data necessary to complete this task can be taken from the following two tables.

`payments` table

This table contains info on all payments by all users on all platforms. It's structure is as follows:
* Game_ID - game title, e.g.: "Tina's journey", "Happy Farm", "Secrets of the East", "Pirate Adventures".
* Platform - platform, e.g.: “Android”, “Facebook”, “iOS”.
* Device_ID - device ID, e.g.: “4992f28a11fb4370b4858d9ac4029e8f”.
* Payment_DateTime - date and time of the payment, e.g.: “2019-02-01 19:00:45”.
* Payment_Amount - payment amount, e.g.: “20.18”.

`installs` table

This table contains data on all installations of every app on every platform.
The moment of installation is when the app was launched for the first time by the user on a given platform.
For the purposes of this task, it may be assumed that every user installs the app on every platform no more than once in their lifetime.
The structure of the table is the same as in task 1.

SQL statement must yield a table, satisfying the conditions above and having the following structure:
* Game_ID - game title; according to the conditions, only Tina's journey and Happy Farm must be included
* Platform - platform, on which the user plays; according to the conditions, only Android and iOS must be included
* Install_Date - installation date; according to the conditions this must be between 2019-05-01 and 2019-06-01.
* Total_Revenue - total amount in USD, which users generate within the first day after installation.
