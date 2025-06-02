@echo off
setlocal enabledelayedexpansion

REM === CONFIGURATION ===
set URL=http://localhost:8080/api/haalcentraal_soap
set SOAP_ACTION=http://www.egem.nl/StUF/sector/bg/0310/npsLk01
set COUNT=100

REM === Arrays ===
set apps=LBA DEC_ZKN EXAMPLE_APP GWS
set bsns=999998778 555555021 999998791 999998353 999998328 999999618
set verwerkingssoorten=T V

REM === Generate and Launch Requests ===
for /L %%n in (1,1,%COUNT%) do (
    set /a "rand_app=!RANDOM! %% 4"
    set /a "rand_bsn=!RANDOM! %% 6"
    set /a "rand_verw=!RANDOM! %% 2"

    REM --- Get Random applicatie ---
    set i=0
    for %%a in (%apps%) do (
        if !i! EQU !rand_app! set "applicatie=%%a"
        set /a i+=1
    )

    REM --- Get Random bsn ---
    set i=0
    for %%b in (%bsns%) do (
        if !i! EQU !rand_bsn! set "bsn=%%b"
        set /a i+=1
    )

    REM --- Get Random verwerkingssoort ---
    set i=0
    for %%v in (%verwerkingssoorten%) do (
        if !i! EQU !rand_verw! set "verwerkingssoort=%%v"
        set /a i+=1
    )

    set id=%%n
    set xmlfile=soap_body_!id!.xml

    REM --- Write XML ---
    > "!xmlfile!" (
        echo ^<soapenv:Envelope xmlns:StUF="http://www.egem.nl/StUF/StUF0301" xmlns:ns="http://www.egem.nl/StUF/sector/bg/0310" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"^>
        echo    ^<soapenv:Header/^>
        echo    ^<soapenv:Body^>
        echo       ^<ns:npsLk01 xmlns:stuf="http://www.egem.nl/StUF/StUF0301"^>
        echo          ^<ns:stuurgegevens^>
        echo             ^<stuf:berichtcode^>Lk01^</stuf:berichtcode^>
        echo             ^<stuf:zender^>
        echo                ^<stuf:organisatie^>1234^</stuf:organisatie^>
        echo                ^<stuf:applicatie^>!applicatie!^</stuf:applicatie^>
        echo             ^</stuf:zender^>
        echo             ^<stuf:ontvanger^>
        echo                ^<stuf:organisatie^>NEDGR^</stuf:organisatie^>
        echo                ^<stuf:applicatie^>NEDMAG_VnA^</stuf:applicatie^>
        echo             ^</stuf:ontvanger^>
        echo             ^<stuf:referentienummer^>ref!id!^</stuf:referentienummer^>
        echo             ^<stuf:tijdstipBericht^>2024071608005200^</stuf:tijdstipBericht^>
        echo             ^<stuf:entiteittype^>NPS^</stuf:entiteittype^>
        echo          ^</ns:stuurgegevens^>
        echo          ^<ns:parameters^>
        echo             ^<stuf:mutatiesoort^>T^</stuf:mutatiesoort^>
        echo             ^<stuf:indicatorOvername^>V^</stuf:indicatorOvername^>
        echo          ^</ns:parameters^>
        echo          ^<ns:object stuf:entiteittype="NPS" stuf:sleutelVerzendend="LBA.00000142157" stuf:verwerkingssoort="!verwerkingssoort!"^>
        echo             ^<ns:inp.bsn^>!bsn!^</ns:inp.bsn^>
        echo          ^</ns:object^>
        echo       ^</ns:npsLk01^>
        echo    ^</soapenv:Body^>
        echo ^</soapenv:Envelope^>
    )

    REM --- Run worker in background ---
    start "" /B cmd /c send_worker.bat !id!
)

REM === Wait for all background tasks to finish ===
echo.
echo Waiting for background tasks to complete...
timeout /t 10 >nul
del soap_body_*.xml >nul 2>&1
echo Done!
endlocal
