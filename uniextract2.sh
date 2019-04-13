#!/usr/bin/env playonlinux-bash
# Date : 2019-04-13T16:11:07
# Last revision : 2019-04-13T16:11:07
# Wine version used : 4.0
# Distribution used to test : Ubuntu 18.10
# Author : Benjamin Altpeter <hi@bn.al>
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Universal Extractor 2"
PREFIX="UniExtract2"
WINE_VERSION="4.0"

ZIP_URL="https://github.com/Bioruebe/UniExtract2/releases/download/v2.0.0-rc.2/UniExtractRC2.zip"
MD5="4a2e33cb505b03ddb7f43276001f7810"
ZIP_NAME="UniExtractRC2.zip"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Bioruebe" "https://github.com/Bioruebe/UniExtract2" "Benjamin Altpeter <hi@bn.al>" "$PREFIX"
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINE_VERSION"

INSTALL_DIR="$WINEPREFIX/drive_c/UniExtract2"

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

POL_Shortcut "UniExtract.exe" "$TITLE"

POL_SetupWindow_Close
exit
