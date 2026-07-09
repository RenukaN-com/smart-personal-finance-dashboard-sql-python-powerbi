-- 01_Database_Setup.sql
CREATE DATABASE smartfinancedashboard;
USE smartfinancedashboard;

DESCRIBE finance_dashboard_dataset;


-- 01_Data_Validation.sql
USE smartfinancedashboard;

SELECT *
FROM finance_dashboard_dataset;

SELECT COUNT(*) AS Total_Transactions
FROM finance_dashboard_dataset;

DESCRIBE finance_dashboard_dataset;

SELECT DISTINCT Category
FROM finance_dashboard_dataset;

SELECT DISTINCT Source
FROM finance_dashboard_dataset;

SELECT DISTINCT Type
FROM finance_dashboard_dataset;

SELECT *
FROM finance_dashboard_dataset
WHERE Category IS NULL;

SELECT
Transaction_ID,
COUNT(*) AS Duplicate_Count
FROM finance_dashboard_dataset
GROUP BY Transaction_ID
HAVING COUNT(*) > 1;

SELECT
MIN(Date) AS Start_Date,
MAX(Date) AS End_Date
FROM finance_dashboard_dataset;

-- 02_Financial_Page.sql

SELECT
SUM(Amount_Abs) AS Total_Income
FROM finance_dashboard_dataset
WHERE Income_Expense='Income';

SELECT
SUM(Amount_Abs) AS Total_Expense
FROM finance_dashboard_dataset
WHERE Income_Expense='Expense';

SELECT

SUM(
CASE
WHEN Income_Expense='Income'
THEN Amount_Abs
ELSE 0
END
)

-

SUM(
CASE
WHEN Income_Expense='Expense'
THEN Amount_Abs
ELSE 0
END
)

AS Net_Savings
FROM finance_dashboard_dataset;

SELECT
ROUND(
(
SUM(
CASE
WHEN Income_Expense='Income'
THEN Amount_Abs
ELSE 0
END
)

-

SUM(
CASE
WHEN Income_Expense='Expense'
THEN Amount_Abs
ELSE 0
END
)

)

/

SUM(
CASE
WHEN Income_Expense='Income'
THEN Amount_Abs
ELSE 0
END
)

*100

,2)

AS Savings_Rate

FROM finance_dashboard_dataset;

SELECT
COUNT(Transaction_ID)
AS Total_Transactions
FROM finance_dashboard_dataset;

SELECT

Month,

SUM(
CASE
WHEN Income_Expense='Income'
THEN Amount_Abs
ELSE 0
END
) AS Total_Income,

SUM(
CASE
WHEN Income_Expense='Expense'
THEN Amount_Abs
ELSE 0
END
) AS Total_Expense

FROM finance_dashboard_dataset

GROUP BY Month,Month_Number

ORDER BY Month_Number;

SELECT

Month,

SUM(Net_Amount) AS Monthly_CashFlow

FROM finance_dashboard_dataset

GROUP BY Month,Month_Number

ORDER BY Month_Number;

SELECT

Month,

SUM(Running_Balance) AS Running_Balance

FROM finance_dashboard_dataset

GROUP BY Month,Month_Number

ORDER BY Month_Number;

SELECT

Income_Expense,

SUM(Amount_Abs) AS Total_Amount

FROM finance_dashboard_dataset

GROUP BY Income_Expense;

SELECT

MAX(Amount_Abs) AS Highest_Transaction

FROM finance_dashboard_dataset;

SELECT

MIN(Amount_Abs) AS Lowest_Transaction

FROM finance_dashboard_dataset;

SELECT

ROUND(AVG(Amount_Abs),2) AS Average_Transaction

FROM finance_dashboard_dataset;

SELECT

Month,

SUM(Amount_Abs) AS Income

FROM finance_dashboard_dataset

WHERE Income_Expense='Income'

GROUP BY Month,Month_Number

ORDER BY Income DESC

LIMIT 1;

SELECT

Month,

SUM(Amount_Abs) AS Expense

FROM finance_dashboard_dataset

WHERE Income_Expense='Expense'

GROUP BY Month,Month_Number

ORDER BY Expense DESC

LIMIT 1;

SELECT

ROUND(

SUM(
CASE
WHEN Income_Expense='Income'
THEN Amount_Abs
ELSE 0
END
)

-

SUM(
CASE
WHEN Income_Expense='Expense'
THEN Amount_Abs
ELSE 0
END
)

,2)

AS Total_Savings,

ROUND(

(

SUM(
CASE
WHEN Income_Expense='Income'
THEN Amount_Abs
ELSE 0
END
)

-

SUM(
CASE
WHEN Income_Expense='Expense'
THEN Amount_Abs
ELSE 0
END
)

)

/

SUM(
CASE
WHEN Income_Expense='Income'
THEN Amount_Abs
ELSE 0
END
)

*100

,2)

AS Savings_Rate

FROM finance_dashboard_dataset;

-- Page 2 – Spending Intelligence

SELECT
Category,
SUM(Amount_Abs) AS Total_Spending
FROM finance_dashboard_dataset
WHERE Income_Expense='Expense'
GROUP BY Category
ORDER BY Total_Spending DESC
LIMIT 1;

SELECT
Merchant,
SUM(Amount_Abs) AS Total_Spending
FROM finance_dashboard_dataset
WHERE Income_Expense='Expense'
GROUP BY Merchant
ORDER BY Total_Spending DESC
LIMIT 1;

SELECT
MAX(Amount_Abs) AS Highest_Transaction
FROM finance_dashboard_dataset
WHERE Income_Expense='Expense';

SELECT
Merchant,
COUNT(*) AS Total_Transactions
FROM finance_dashboard_dataset
WHERE Income_Expense='Expense'
GROUP BY Merchant
ORDER BY Total_Transactions DESC
LIMIT 1;

SELECT
Category,
SUM(Amount_Abs) AS Expense
FROM finance_dashboard_dataset
WHERE Income_Expense='Expense'
GROUP BY Category
ORDER BY Expense DESC;

SELECT
Category_Group,
SUM(Amount_Abs) AS Expense
FROM finance_dashboard_dataset
WHERE Income_Expense='Expense'
GROUP BY Category_Group
ORDER BY Expense DESC;

SELECT
Merchant,
COUNT(*) AS Frequency
FROM finance_dashboard_dataset
WHERE Income_Expense='Expense'
GROUP BY Merchant
ORDER BY Frequency DESC
LIMIT 10;

SELECT
Merchant,
SUM(Amount_Abs) AS Total_Spending
FROM finance_dashboard_dataset
WHERE Income_Expense='Expense'
GROUP BY Merchant
ORDER BY Total_Spending DESC
LIMIT 7;

SELECT
Merchant,
SUM(Amount_Abs) AS Total_Spending
FROM finance_dashboard_dataset
WHERE Income_Expense='Expense'
GROUP BY Merchant
ORDER BY Total_Spending DESC;

SELECT
Month,
SUM(Amount_Abs) AS Monthly_Spending
FROM finance_dashboard_dataset
WHERE Income_Expense='Expense'
GROUP BY Month, Month_Number
ORDER BY Month_Number;

SELECT
Month,
SUM(Amount_Abs) AS Monthly_Spending
FROM finance_dashboard_dataset
WHERE Income_Expense='Expense'
GROUP BY Month, Month_Number
ORDER BY Month_Number;

SELECT
Category,
ROUND(AVG(Amount_Abs),2) AS Average_Spending
FROM finance_dashboard_dataset
WHERE Income_Expense='Expense'
GROUP BY Category
ORDER BY Average_Spending DESC;

SELECT
Category,
COUNT(*) AS Total_Transactions
FROM finance_dashboard_dataset
WHERE Income_Expense='Expense'
GROUP BY Category
ORDER BY Total_Transactions DESC;

SELECT
Transaction_ID,
Merchant,
Category,
Amount_Abs
FROM finance_dashboard_dataset
WHERE Income_Expense='Expense'
ORDER BY Amount_Abs DESC
LIMIT 5;

SELECT
Merchant,
SUM(Amount_Abs) AS Total_Spending,
RANK() OVER(
ORDER BY SUM(Amount_Abs) DESC
) AS Merchant_Rank
FROM finance_dashboard_dataset
WHERE Income_Expense='Expense'
GROUP BY Merchant;

SELECT
COUNT(*) AS Total_Expense_Transactions,
SUM(Amount_Abs) AS Total_Expense,
ROUND(AVG(Amount_Abs),2) AS Average_Expense,
MAX(Amount_Abs) AS Highest_Expense,
MIN(Amount_Abs) AS Lowest_Expense
FROM finance_dashboard_dataset
WHERE Income_Expense='Expense';

-- Page 3 – Financial Behavior Analytics
SELECT
ROUND(AVG(Amount_Abs),2) AS Average_Daily_Spend
FROM finance_dashboard_dataset
WHERE Income_Expense='Expense';

SELECT
ROUND(AVG(Monthly_Spending),2) AS Average_Monthly_Spend
FROM
(
SELECT
Month,
SUM(Amount_Abs) AS Monthly_Spending
FROM finance_dashboard_dataset
WHERE Income_Expense='Expense'
GROUP BY Month, Month_Number
) AS MonthlyData;

SELECT
ROUND(
(
SUM(CASE WHEN Day_Type='Weekend' THEN Amount_Abs ELSE 0 END)
/
SUM(Amount_Abs)
)*100,2
) AS Weekend_Spend_Percentage
FROM finance_dashboard_dataset
WHERE Income_Expense='Expense';

SELECT
ROUND(COUNT(*)/COUNT(DISTINCT Date),2) AS Transactions_Per_Day
FROM finance_dashboard_dataset;

SELECT
Day_Name,
SUM(Amount_Abs) AS Total_Spending
FROM finance_dashboard_dataset
WHERE Income_Expense='Expense'
GROUP BY Day_Name
ORDER BY
FIELD(
Day_Name,
'Monday',
'Tuesday',
'Wednesday',
'Thursday',
'Friday',
'Saturday',
'Sunday'
);

SELECT
Transaction_Size,
COUNT(*) AS Total_Transactions
FROM finance_dashboard_dataset
GROUP BY Transaction_Size
ORDER BY
FIELD(
Transaction_Size,
'Small',
'Medium',
'Large',
'Very Large'
);

SELECT
Day_Type,
SUM(Amount_Abs) AS Total_Spending
FROM finance_dashboard_dataset
WHERE Income_Expense='Expense'
GROUP BY Day_Type;

SELECT
Month,
SUM(Amount_Abs) AS Monthly_Spending
FROM finance_dashboard_dataset
WHERE Income_Expense='Expense'
GROUP BY Month, Month_Number
ORDER BY Month_Number;

SELECT
Category_Group,
SUM(Amount_Abs) AS Total_Spending
FROM finance_dashboard_dataset
WHERE Income_Expense='Expense'
GROUP BY Category_Group
ORDER BY Total_Spending DESC;

SELECT
Day_Name,
SUM(Amount_Abs) AS Total_Spending
FROM finance_dashboard_dataset
WHERE Income_Expense='Expense'
GROUP BY Day_Name
ORDER BY Total_Spending DESC
LIMIT 1;

SELECT
Day_Name,
SUM(Amount_Abs) AS Total_Spending
FROM finance_dashboard_dataset
WHERE Income_Expense='Expense'
GROUP BY Day_Name
ORDER BY Total_Spending DESC
LIMIT 1;

SELECT
Day_Name,
SUM(Amount_Abs) AS Total_Spending
FROM finance_dashboard_dataset
WHERE Income_Expense='Expense'
GROUP BY Day_Name
ORDER BY Total_Spending DESC
LIMIT 1;

SELECT
Day_Name,
SUM(Amount_Abs) AS Total_Spending
FROM finance_dashboard_dataset
WHERE Income_Expense='Expense'
GROUP BY Day_Name
ORDER BY Total_Spending
LIMIT 1;

SELECT
Quarter,
SUM(Amount_Abs) AS Total_Spending
FROM finance_dashboard_dataset
WHERE Income_Expense='Expense'
GROUP BY Quarter
ORDER BY Quarter;

SELECT
Week_Number,
SUM(Amount_Abs) AS Weekly_Spending
FROM finance_dashboard_dataset
WHERE Income_Expense='Expense'
GROUP BY Week_Number
ORDER BY Week_Number;

SELECT
Day_Name,
COUNT(*) AS Total_Transactions
FROM finance_dashboard_dataset
GROUP BY Day_Name
ORDER BY
FIELD(
Day_Name,
'Monday',
'Tuesday',
'Wednesday',
'Thursday',
'Friday',
'Saturday',
'Sunday'
);

SELECT
Category_Group,
ROUND(AVG(Amount_Abs),2) AS Average_Transaction
FROM finance_dashboard_dataset
WHERE Income_Expense='Expense'
GROUP BY Category_Group
ORDER BY Average_Transaction DESC;

SELECT
Week_Number,
COUNT(*) AS Transactions
FROM finance_dashboard_dataset
GROUP BY Week_Number
ORDER BY Transactions DESC
LIMIT 1;

SELECT

COUNT(*) AS Total_Transactions,

ROUND(AVG(Amount_Abs),2) AS Average_Transaction,

MAX(Amount_Abs) AS Highest_Transaction,

MIN(Amount_Abs) AS Lowest_Transaction,

SUM(Amount_Abs) AS Total_Spending

FROM finance_dashboard_dataset

WHERE Income_Expense='Expense';

SELECT

Category_Group,

SUM(Amount_Abs) AS Total_Spending,

DENSE_RANK()
OVER(
ORDER BY SUM(Amount_Abs) DESC
) AS Spending_Rank

FROM finance_dashboard_dataset

WHERE Income_Expense='Expense'

GROUP BY Category_Group;

SELECT

Day_Type,

COUNT(*) AS Transactions,

SUM(Amount_Abs) AS Total_Spending,

ROUND(AVG(Amount_Abs),2) AS Average_Spending

FROM finance_dashboard_dataset

WHERE Income_Expense='Expense'

GROUP BY Day_Type;

-- Page 4 – Payment & Transaction Intelligence

SELECT
COUNT(*) AS Total_Transactions
FROM finance_dashboard_dataset;

SELECT
Source,
COUNT(*) AS Total_Transactions
FROM finance_dashboard_dataset
GROUP BY Source
ORDER BY Total_Transactions DESC
LIMIT 1;

SELECT
Type,
COUNT(*) AS Total_Transactions
FROM finance_dashboard_dataset
GROUP BY Type
ORDER BY Total_Transactions DESC
LIMIT 1;

SELECT
ROUND(AVG(Amount_Abs),2) AS Average_Transaction
FROM finance_dashboard_dataset;

SELECT
Source,
COUNT(*) AS Transactions,
SUM(Amount_Abs) AS Total_Amount
FROM finance_dashboard_dataset
GROUP BY Source
ORDER BY Total_Amount DESC;

SELECT
Type,
COUNT(*) AS Transactions,
SUM(Amount_Abs) AS Total_Amount
FROM finance_dashboard_dataset
GROUP BY Type;

SELECT
Source,
SUM(Amount_Abs) AS Total_Spending
FROM finance_dashboard_dataset
WHERE Income_Expense='Expense'
GROUP BY Source
ORDER BY Total_Spending DESC;

SELECT
Source,
SUM(Amount_Abs) AS Total_Income
FROM finance_dashboard_dataset
WHERE Income_Expense='Income'
GROUP BY Source
ORDER BY Total_Income DESC;

SELECT
Source,
Category,
SUM(Amount_Abs) AS Total_Spending
FROM finance_dashboard_dataset
WHERE Income_Expense='Expense'
GROUP BY Source,Category
ORDER BY Source;

SELECT
Month,
Source,
SUM(Amount_Abs) AS Total_Amount
FROM finance_dashboard_dataset
GROUP BY Month,Month_Number,Source
ORDER BY Month_Number;

SELECT
Merchant,
Source,
SUM(Amount_Abs) AS Total_Amount
FROM finance_dashboard_dataset
GROUP BY Merchant,Source
ORDER BY Total_Amount DESC;

SELECT
Merchant,
COUNT(*) AS Transactions
FROM finance_dashboard_dataset
GROUP BY Merchant
ORDER BY Transactions DESC
LIMIT 10;

SELECT
Merchant,
SUM(Amount_Abs) AS Total_Amount
FROM finance_dashboard_dataset
GROUP BY Merchant
ORDER BY Total_Amount DESC
LIMIT 10;

SELECT
Source,
Income_Expense,
SUM(Amount_Abs) AS Total_Amount
FROM finance_dashboard_dataset
GROUP BY Source,Income_Expense;

SELECT
Source,
ROUND(AVG(Amount_Abs),2) AS Average_Transaction
FROM finance_dashboard_dataset
GROUP BY Source
ORDER BY Average_Transaction DESC;
SELECT
Source,
MAX(Amount_Abs) AS Highest_Transaction
FROM finance_dashboard_dataset
GROUP BY Source;
SELECT
Transaction_Size,
COUNT(*) AS Transactions,
SUM(Amount_Abs) AS Total_Amount
FROM finance_dashboard_dataset
GROUP BY Transaction_Size;

SELECT
Source,
SUM(Amount_Abs) AS Total_Amount,
RANK()
OVER(
ORDER BY SUM(Amount_Abs) DESC
) AS Source_Rank
FROM finance_dashboard_dataset
GROUP BY Source;

SELECT
Merchant,
SUM(Amount_Abs) AS Total_Amount,
DENSE_RANK()
OVER(
ORDER BY SUM(Amount_Abs) DESC
) AS Merchant_Rank
FROM finance_dashboard_dataset
GROUP BY Merchant;

SELECT

COUNT(*) AS Total_Transactions,

SUM(Amount_Abs) AS Total_Amount,

ROUND(AVG(Amount_Abs),2) AS Average_Amount,

MAX(Amount_Abs) AS Highest_Amount,

MIN(Amount_Abs) AS Lowest_Amount

FROM finance_dashboard_dataset;

SELECT

Source,

COUNT(*) AS Total_Transactions,

SUM(Amount_Abs) AS Total_Amount,

ROUND(AVG(Amount_Abs),2) AS Average_Amount

FROM finance_dashboard_dataset

GROUP BY Source

ORDER BY Total_Amount DESC;

WITH SourceSummary AS
(
SELECT
Source,
SUM(Amount_Abs) AS Total_Amount
FROM finance_dashboard_dataset
GROUP BY Source
)

SELECT *
FROM SourceSummary
ORDER BY Total_Amount DESC;

SELECT
Transaction_ID,
Merchant,
Amount_Abs
FROM finance_dashboard_dataset
WHERE Amount_Abs >
(
SELECT AVG(Amount_Abs)
FROM finance_dashboard_dataset
);

CREATE VIEW vw_payment_summary AS

SELECT
Source,
SUM(Amount_Abs) AS Total_Amount,
COUNT(*) AS Transactions
FROM finance_dashboard_dataset
GROUP BY Source;