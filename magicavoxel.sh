#!/usr/bin/env playonlinux-bash
# Date : 2019-04-28T14:43:28
# Last revision : 2020-06-10T16:08:00
# Wine version used : 4.0
# Distribution used to test : Linux Mint 19.1
# Author : Benjamin Altpeter <hi@bn.al>
# Repo : https://github.com/baltpeter/playonlinux-scripts/
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="MagicaVoxel 0.99.5.1"
PREFIX="MagicaVoxel"
WINE_VERSION="4.0"

ZIP_URL="https://github.com/ephtracy/ephtracy.github.io/releases/download/0.99.5/MagicaVoxel-0.99.5.1-win32.zip"
MD5="8748e4eb1dd18faed21523ef7e7b1ab4"
ZIP_NAME="MagicaVoxel-0.99.5.1-win32.zip"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "ephtracy" "https://ephtracy.github.io/" "Benjamin Altpeter <hi@bn.al>" "$PREFIX"
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINE_VERSION"

INSTALL_DIR="$WINEPREFIX/drive_c/$PREFIX"

mkdir -p "$INSTALL_DIR"

if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    POL_SetupWindow_browse "Please select the installation file to run." "$TITLE"
    ARCHIVE="$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    cd "$INSTALL_DIR"
    POL_Download "$ZIP_URL" "$MD5"
    ARCHIVE="$INSTALL_DIR/$ZIP_NAME"
fi

POL_Wine_WaitBefore "$TITLE"
echo "unzip \"$ARCHIVE\" -d \"$INSTALL_DIR\""
unzip "$ARCHIVE" -d "$INSTALL_DIR" || POL_Debug_Error "Unable to extract archive."

POL_Shortcut "MagicaVoxel.exe" "$TITLE"

POL_SetupWindow_Close
exit
