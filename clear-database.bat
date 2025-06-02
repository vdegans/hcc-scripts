@echo off
setlocal enabledelayedexpansion

:: Start log
echo Debugging Log - %date% %time% > debug_log.txt
echo Script started >> debug_log.txt

:: Echo starting container lookup
echo Finding container... >> debug_log.txt
docker ps -a --filter "name=haalcentraal-connector" --format "{{.ID}}" > container_id.txt 2>>debug_log.txt

:: Output contents of container_id.txt to the log
echo Contents of container_id.txt: >> debug_log.txt
type container_id.txt >> debug_log.txt

:: Check if any container IDs are retrieved and process each one
for /f "delims=" %%x in (container_id.txt) do (
    set CONTAINER_ID=%%x
    echo Processing container ID: !CONTAINER_ID! >> debug_log.txt

    if not "!CONTAINER_ID!"=="" (
        echo Attempting to stop container !CONTAINER_ID!... >> debug_log.txt
        docker stop !CONTAINER_ID! >> debug_log.txt 2>&1

        if !ERRORLEVEL! NEQ 0 (
            echo Failed to stop container !CONTAINER_ID!. >> debug_log.txt
        ) else (
            echo Successfully stopped container !CONTAINER_ID!. >> debug_log.txt
            echo Removing container !CONTAINER_ID!... >> debug_log.txt
            docker rm !CONTAINER_ID! >> debug_log.txt 2>&1

            if !ERRORLEVEL! NEQ 0 (
                echo Failed to remove container !CONTAINER_ID!. >> debug_log.txt
            ) else (
                echo Successfully removed container !CONTAINER_ID!. >> debug_log.txt
            )
        )
    ) else (
        echo No container ID found. >> debug_log.txt
    )
)

:: Echo starting volume lookup
echo Finding volumes... >> debug_log.txt
docker volume ls --filter "name=haalcentraal-connector" --format "{{.Name}}" > volume_name.txt 2>>debug_log.txt

:: Output contents of volume_name.txt to the log
echo Contents of volume_name.txt: >> debug_log.txt
type volume_name.txt >> debug_log.txt

:: Check if volume name is retrieved
if exist volume_name.txt (
    echo volume_name.txt exists >> debug_log.txt
    for /f "delims=" %%v in (volume_name.txt) do (
        set VOLUME_NAME=%%v
        echo Volume Name: !VOLUME_NAME! >> debug_log.txt
    )

    if not "!VOLUME_NAME!"=="" (
        echo Attempting to remove volume !VOLUME_NAME!... >> debug_log.txt
        docker volume rm !VOLUME_NAME! >> debug_log.txt 2>&1

        if !ERRORLEVEL! NEQ 0 (
            echo Failed to remove volume !VOLUME_NAME!! >> debug_log.txt
        ) else (
            echo Successfully removed volume !VOLUME_NAME!. >> debug_log.txt
        )
    ) else (
        echo No volume associated with "haalcentraal-connector" found. >> debug_log.txt
    )
) else (
    echo volume_name.txt does not exist or is empty. >> debug_log.txt
)

:: Clean up
del container_id.txt
del volume_name.txt

:: Pause the script
echo Pausing for review... >> debug_log.txt

echo Done. >> debug_log.txt
