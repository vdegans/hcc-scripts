@echo off
setlocal enabledelayedexpansion

REM Configuration
set URL=http://localhost:8080/api/haalcentraal_soap
set SOAP_ACTION=http://www.egem.nl/StUF/sector/bg/0310/npsLv01
set COUNT=20

REM Arrays
set apps=GWS LBA
set bsns=999998778 555555021 999998791 999998353 999998328 999999618
set mutatiesoort=T

REM Loop for requests
for /L %%i in (1,1,%COUNT%) do (

    REM Random app
    set /a "rand_app=!random! %% 2"
    set i=0
    for %%a in (%apps%) do (
        if !i! EQU !rand_app! set "applicatie=%%a"
        set /a i+=1
    )

    REM Random bsn
    set /a "rand_bsn=!random! %% 6"
    set i=0
    for %%b in (%bsns%) do (
        if !i! EQU !rand_bsn! set "bsn=%%b"
        set /a i+=1
    )

    REM Generate XML file
    set "xmlfile=soap_lv01_%%i.xml"
    > "!xmlfile!" (
        echo ^<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="http://www.egem.nl/StUF/sector/bg/0310" xmlns:StUF="http://www.egem.nl/StUF/StUF0301" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:gml="http://www.opengis.net/gml"^>
        echo    ^<soapenv:Header/^>
        echo    ^<soapenv:Body^>
        echo       ^<BG:npsLv01 xmlns:BG="http://www.egem.nl/StUF/sector/bg/0310" xmlns:StUF="http://www.egem.nl/StUF/StUF0301" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"^>
        echo          ^<BG:stuurgegevens^>
        echo             ^<StUF:berichtcode^>Lv01^</StUF:berichtcode^>
        echo             ^<StUF:zender^>
        echo                ^<StUF:organisatie^>0518^</StUF:organisatie^>
        echo                ^<StUF:applicatie^>!applicatie!^</StUF:applicatie^>
        echo             ^</StUF:zender^>
        echo             ^<StUF:ontvanger^>
        echo                ^<StUF:organisatie^>test1^</StUF:organisatie^>
        echo                ^<StUF:applicatie^>test^</StUF:applicatie^>
        echo             ^</StUF:ontvanger^>
        echo             ^<StUF:referentienummer^>ref%%i-!random!^</StUF:referentienummer^>
        echo             ^<StUF:tijdstipBericht^>20241014193057291^</StUF:tijdstipBericht^>
        echo             ^<StUF:entiteittype^>NPS^</StUF:entiteittype^>
        echo          ^</BG:stuurgegevens^>
        echo          ^<BG:parameters^>
        echo             ^<StUF:sortering^>1^</StUF:sortering^>
        echo             ^<StUF:indicatorVervolgvraag^>false^</StUF:indicatorVervolgvraag^>
        echo             ^<StUF:maximumAantal^>9^</StUF:maximumAantal^>
        echo          ^</BG:parameters^>
        echo          ^<BG:gelijk StUF:entiteittype="NPS"^>
        echo             ^<BG:inp.bsn^>!bsn!^</BG:inp.bsn^>
        echo          ^</BG:gelijk^>
        echo          ^<BG:scope^>
        echo             ^<BG:object StUF:entiteittype="NPS"^>
        echo                ^<BG:inp.bsn xsi:nil="true"/^>
        echo                ^<BG:inp.a-nummer xsi:nil="true"/^>
        echo                ^<BG:geslachtsnaam xsi:nil="true"/^>
        echo                ^<BG:voorvoegselGeslachtsnaam xsi:nil="true"/^>
        echo                ^<BG:voorletters xsi:nil="true"/^>
        echo                ^<BG:voornamen xsi:nil="true"/^>
        echo                ^<BG:aanduidingNaamgebruik xsi:nil="true"/^>
        echo                ^<BG:geslachtsnaamPartner xsi:nil="true"/^>
        echo                ^<BG:geslachtsaanduiding xsi:nil="true"/^>
        echo                ^<BG:geboortedatum xsi:nil="true"/^>
        echo                ^<BG:inp.geboorteplaats xsi:nil="true"/^>
        echo                ^<BG:inp.geboorteLand xsi:nil="true"/^>
        echo                ^<BG:overlijdensdatum xsi:nil="true"/^>
        echo                ^<BG:inp.overlijdenplaats xsi:nil="true"/^>
        echo                ^<BG:inp.overlijdenLand xsi:nil="true"/^>
        echo                ^<BG:verblijfsadres^>
        echo                   ^<BG:aoa.identificatie xsi:nil="true"/^>
        echo                   ^<BG:wpl.identificatie xsi:nil="true"/^>
        echo                   ^<BG:wpl.woonplaatsNaam xsi:nil="true"/^>
        echo                   ^<BG:aoa.woonplaatsWaarinGelegen^>
        echo                      ^<BG:wpl.identificatie xsi:nil="true"/^>
        echo                      ^<BG:wpl.woonplaatsNaam xsi:nil="true"/^>
        echo                   ^</BG:aoa.woonplaatsWaarinGelegen^>
        echo                   ^<BG:gor.identificatie xsi:nil="true"/^>
        echo                   ^<BG:opr.identificatie xsi:nil="true"/^>
        echo                   ^<BG:gor.openbareRuimteNaam xsi:nil="true"/^>
        echo                   ^<BG:gor.straatnaam xsi:nil="true"/^>
        echo                   ^<BG:aoa.postcode xsi:nil="true"/^>
        echo                   ^<BG:aoa.huisnummer xsi:nil="true"/^>
        echo                   ^<BG:aoa.huisletter xsi:nil="true"/^>
        echo                   ^<BG:aoa.huisnummertoevoeging xsi:nil="true"/^>
        echo                   ^<BG:inp.locatiebeschrijving xsi:nil="true"/^>
        echo                   ^<BG:begindatumVerblijf xsi:nil="true"/^>
        echo                ^</BG:verblijfsadres^>
        echo                ^<BG:inp.adresHerkomst xsi:nil="true"/^>
        echo                ^<BG:inp.burgerlijkeStaat xsi:nil="true"/^>
        echo                ^<BG:inp.gemeenteVanInschrijving xsi:nil="true"/^>
        echo                ^<BG:inp.datumInschrijving xsi:nil="true"/^>
        echo                ^<BG:inp.indicatieGeheim xsi:nil="true"/^>
        echo                ^<BG:ing.indicatieBlokkering xsi:nil="true"/^>
        echo                ^<BG:aanduidingStrijdigheidNietigheid xsi:nil="true"/^>
        echo                ^<StUF:tijdvakGeldigheid^>
        echo                   ^<StUF:beginGeldigheid xsi:nil="true"/^>
        echo                   ^<StUF:eindGeldigheid xsi:nil="true"/^>
        echo                ^</StUF:tijdvakGeldigheid^>
        echo                ^<StUF:tijdstipRegistratie xsi:nil="true"/^>
        echo                ^<BG:inp.heeftAlsNationaliteit StUF:entiteittype="NPSNAT"^>
        echo                   ^<BG:gerelateerde StUF:entiteittype="NAT"^>
        echo                      ^<BG:code xsi:nil="true"/^>
        echo                      ^<BG:omschrijving xsi:nil="true"/^>
        echo                   ^</BG:gerelateerde^>
        echo                   ^<BG:inp.redenVerkrijging xsi:nil="true"/^>
        echo                   ^<BG:inp.datumVerkrijging xsi:nil="true"/^>
        echo                   ^<BG:inp.redenVerlies xsi:nil="true"/^>
        echo                   ^<BG:inp.datumVerlies xsi:nil="true"/^>
        echo                ^</BG:inp.heeftAlsNationaliteit^>
        echo             ^</BG:object^>
        echo          ^</BG:scope^>
        echo       ^</BG:npsLv01^>
        echo    ^</soapenv:Body^>
        echo ^</soapenv:Envelope^>
    )

    REM Send request synchronously and show HTTP status
    echo Sending request %%i: applicatie=!applicatie!, bsn=!bsn!

    curl -s -o response_%%i.txt -w "Request %%i HTTP status: %%{http_code}\n" ^
        -X POST %URL% ^
        -H "Content-Type: text/xml;charset=UTF-8" ^
        -H "SOAPAction: %SOAP_ACTION%" ^
        --data "@!xmlfile!"

    rem Delete response file and XML request file
    del response_%%i.txt
    del !xmlFile!
)

echo All %COUNT% requests sent.
endlocal