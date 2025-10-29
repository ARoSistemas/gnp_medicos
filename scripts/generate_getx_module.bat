@echo off

REM Script to generate a new GetX module

REM --- SCRIPT SETUP ---
REM Change to the script's parent directory
cd /d "%~dp0.."

REM --- ARGUMENT PARSING ---
REM Default values
set "OUTPUT_DIR=lib\src\modules"
set "MODULE_NAME="

:parse_args
if "%~1"=="" goto :end_parse_args

if /i "%~1"=="-o" (
    set "OUTPUT_DIR=%~2"
    shift
    shift
    goto :parse_args
)

REM Assume the first non-flag argument is the module name
if not defined MODULE_NAME (
    set "MODULE_NAME=%~1"
    shift
    goto :parse_args
) else (
    echo Error: Unknown argument or duplicate module name: %1
    echo Usage: scripts\generate_getx_module.bat ^<module_name^> [-o ^<output_directory^>]
    exit /b 1
)

:end_parse_args

REM --- VALIDATION ---
REM Validate that the module name has been provided
if not defined MODULE_NAME (
    echo Error: You must provide the module name.
    echo Usage: scripts\generate_getx_module.bat ^<module_name^> [-o ^<output_directory^>]
    exit /b 1
)

REM --- EXECUTION ---
echo Generating module '%MODULE_NAME%' in '%OUTPUT_DIR%'...

REM Execute the Dart script with the corresponding arguments
dart run scripts/generate_module.dart --name "%MODULE_NAME%" --output "%OUTPUT_DIR%"
