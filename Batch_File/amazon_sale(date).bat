@echo off

REM Define MySQL login credentials
set "HOST=your_host"
set "USER=user_name"
set "PASSWORD=your_password"
set "DATABASE=your_database"

REM Prompt the user to enter a date (format: YYYY-MM-DD)
echo Please enter a date (format: YYYY-MM-DD):
set /p BUY_DATE=

REM Validate the date format (simple check)
echo You entered: %BUY_DATE%

if "%BUY_DATE%"=="" (
    echo Error: No date entered!
    pause
    exit /b
)

REM Define the output CSV file path using the date (new file for each date)
set "OUTPUT_FILE=C:\Users\Muniyandi 20306\Desktop\Muns\E-Com\Batch_File\Save_Output_CSV\%BUY_DATE%.csv"

REM Construct the query using the input date

set "QUERY=SELECT * FROM Amazon_sale WHERE Order_date = '%BUY_DATE%' ORDER BY Order_date DESC;"


REM Ensure MySQL output is in CSV format with column headers and export to the CSV file
mysql -h %HOST% -u %USER% -p%PASSWORD% -D %DATABASE% --batch --column-names -e "%QUERY%" > "%OUTPUT_FILE%"

REM Check if the file was created successfully
if exist "%OUTPUT_FILE%" (
    echo Data exported successfully to: %OUTPUT_FILE%
) else (
    echo Error: Failed to create the CSV file.
)

REM End of batch file
pause
