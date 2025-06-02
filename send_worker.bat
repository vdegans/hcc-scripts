@echo off
setlocal

set id=%1
set "xmlfile=soap_body_%id%.xml"

echo Sending request ID: %id%

curl -s -o curl_output_%id%.txt -w "Request ID %id% - HTTP status: %%{http_code}\n" ^
 -X POST http://localhost:8080/api/haalcentraal_soap ^
 -H "Content-Type: text/xml;charset=UTF-8" ^
 -H "SOAPAction: http://www.egem.nl/StUF/sector/bg/0310/npsLk01" ^
 --data "@%xmlfile%"

REM Optionally show body for debugging:
REM type curl_output_%id%.txt

REM Clean up
del "%xmlfile%" >nul 2>&1
del curl_output_%id%.txt >nul 2>&1

endlocal
exit /b
