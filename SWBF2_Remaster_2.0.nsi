;An easy all-in-one Windows installer for the Mod "Star Wars Battlefront II Remaster"
;NSIS script written by Frogbull

;--------------------------------
;Include Modern UI

  !include MUI2.nsh
  !include nsDialogs.nsh

;--------------------------------
;General

  ;Icon, Name and file
  !define MUI_ICON "SWBF2_Remaster_Installer\icon.ico"
  BrandingText "Star Wars Battlefront II Remaster"
  Name "Star Wars Battlefront II Remaster 2.0"
  OutFile "SWBF2_Remaster_2.0.exe"

  ;Images
  !define MUI_WELCOMEFINISHPAGE_BITMAP "SWBF2_Remaster_Installer\welcome.bmp"
  !define MUI_HEADERIMAGE_BITMAP "SWBF2_Remaster_Installer\header.bmp"

  ;Default installation folder
  InstallDir "$PROGRAMFILES\LucasArts\Star Wars Battlefront II"
  
  ;Get installation folder from registry if available
  InstallDirRegKey HKCU "Software\SWBF2_Remaster" ""

  ;Request application privileges for Windows Vista
  RequestExecutionLevel user

;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING

;--------------------------------
Var CustomDialog

Var Btn_Retail
Var Btn_GOG
Var Btn_Steam
Var Btn_Origin

Var Image_Retail
Var ImageHandle_Retail
Var Image_GOG
Var ImageHandle_GOG
Var Image_Steam
Var ImageHandle_Steam
Var Image_Origin
Var ImageHandle_Origin

Function OnClick_Retail
  StrCpy $INSTDIR "$PROGRAMFILES\LucasArts\Star Wars Battlefront II"
  GetDlgItem $0 $HWNDPARENT 1
  ShowWindow $0 ${SW_SHOW}
  SendMessage $HWNDPARENT ${WM_COMMAND} 1 0
FunctionEnd

Function OnClick_GOG
  StrCpy $INSTDIR "C:\GOG Games\Star Wars - Battlefront 2"
  GetDlgItem $0 $HWNDPARENT 1
  ShowWindow $0 ${SW_SHOW}
  SendMessage $HWNDPARENT ${WM_COMMAND} 1 0
FunctionEnd

Function OnClick_Steam
  StrCpy $INSTDIR "$PROGRAMFILES\Steam\SteamApps\common\Star Wars Battlefront II"
  GetDlgItem $0 $HWNDPARENT 1
  ShowWindow $0 ${SW_SHOW}
  SendMessage $HWNDPARENT ${WM_COMMAND} 1 0
FunctionEnd

Function OnClick_Origin
  StrCpy $INSTDIR "C:\Origin Games\Star Wars - Battlefront 2"
  GetDlgItem $0 $HWNDPARENT 1
  ShowWindow $0 ${SW_SHOW}
  SendMessage $HWNDPARENT ${WM_COMMAND} 1 0
FunctionEnd

Function CustomPAGE
  !insertmacro MUI_HEADER_TEXT "Game Version" "Please select the version of your game (Retail or Digital Download)."
  nsDialogs::Create 1018
  Pop $CustomDialog

  ;--------------------------------
  ${NSD_CreateBitmap} 1% 8% 23% 65% ""
  Pop $Image_Retail
  ${NSD_SetStretchedImage} $Image_Retail "SWBF2_Remaster_Installer\btn_retail.bmp" $ImageHandle_Retail

  ${NSD_CreateButton} 1% 75% 23% 12% "CD/DVD Version"
  Pop $Btn_Retail
  ${NSD_OnClick} $Btn_Retail OnClick_Retail

  ;--------------------------------
  ${NSD_CreateBitmap} 26% 8% 23% 65% ""
  Pop $Image_GOG
  ${NSD_SetStretchedImage} $Image_GOG "SWBF2_Remaster_Installer\btn_gog.bmp" $ImageHandle_GOG

  ${NSD_CreateButton} 26% 75% 23% 12% "GOG Version"
  Pop $Btn_GOG
  ${NSD_OnClick} $Btn_GOG OnClick_GOG

  ;--------------------------------
	${NSD_CreateBitmap} 51% 8% 23% 65% ""
	Pop $Image_Steam
	${NSD_SetStretchedImage} $Image_Steam "SWBF2_Remaster_Installer\btn_steam.bmp" $ImageHandle_Steam

  ${NSD_CreateButton} 51% 75% 23% 12% "Steam Version"
  Pop $Btn_Steam
  ${NSD_OnClick} $Btn_Steam OnClick_Steam

  ;--------------------------------
  ${NSD_CreateBitmap} 76% 8% 23% 65% ""
  Pop $Image_Origin
  ${NSD_SetStretchedImage} $Image_Origin "SWBF2_Remaster_Installer\btn_origin.bmp" $ImageHandle_Origin

  ${NSD_CreateButton} 76% 75% 23% 12% "Origin Version"
  Pop $Btn_Origin
  ${NSD_OnClick} $Btn_Origin OnClick_Origin

  ;--------------------------------

  ; Hiding Back and Next Buttons
  GetDlgItem $0 $HWNDPARENT 3
  ShowWindow $0 ${SW_HIDE}
  GetDlgItem $0 $HWNDPARENT 1
  ShowWindow $0 ${SW_HIDE}

  ;--------------------------------

  nsDialogs::Show
  ${NSD_FreeImage} $ImageHandle_Retail
  ${NSD_FreeImage} $ImageHandle_GOG
  ${NSD_FreeImage} $ImageHandle_Steam
  ${NSD_FreeImage} $ImageHandle_Origin

FunctionEnd
;--------------------------------

;--------------------------------
  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_LICENSE "SWBF2_Remaster_Installer\SWBF2_Remaster_License.txt"
  !define MUI_PAGE_CUSTOMFUNCTION_PRE CustomPAGE
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_PAGE_FINISH
  !insertmacro MUI_UNPAGE_WELCOME
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  !insertmacro MUI_UNPAGE_FINISH

;--------------------------------
;Languages

  !insertmacro MUI_LANGUAGE "English"

;--------------------------------
;Installer Sections

Section "Unofficial Patch 1.3 r130" SecA

  SetOutPath "$INSTDIR"

  ;FILES HERE...
  file /r SWBF2_Remaster_Installer\files\SWBF2_1.3patch_r130\GameData
  
  ;Store installation folder
  WriteRegStr HKCU "Software\SWBF2_Remaster" "" $INSTDIR
  
  ;Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"

SectionEnd

;#########################################

Section "SWBF2 HD 1.2" SecB

  SetOutPath "$INSTDIR"

  ;FILES HERE...
  
  ;Store installation folder
  WriteRegStr HKCU "Software\SWBF2_Remaster" "" $INSTDIR
  
  ;Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"

SectionEnd

;#########################################

Section "2019 Graphics Mod 2.0" SecC

  SetOutPath "$INSTDIR"
  ;FILES HERE...
  file /r SWBF2_Remaster_Installer\files\HD_GraphicsMod_2.0\GameData

  ;Store installation folder
  WriteRegStr HKCU "Software\SWBF2_Remaster" "" $INSTDIR
  
  ;Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"

SectionEnd

;#########################################

Section "Improved Sides Mod 1.0" SecD

  SetOutPath "$INSTDIR"
  ;FILES HERE...
  file /r SWBF2_Remaster_Installer\files\SWBF2_ImprovedSides_1.0\GameData
  
  ;Store installation folder
  WriteRegStr HKCU "Software\SWBF2_Remaster" "" $INSTDIR
  
  ;Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"

SectionEnd

;#########################################

Section "Realistic & Rezzed Maps" SecE

  SetOutPath "$INSTDIR"
  ;FILES HERE...
  file /r SWBF2_Remaster_Installer\files\Harrisonfog_Maps\GameData
  
  ;Store installation folder
  WriteRegStr HKCU "Software\SWBF2_Remaster" "" $INSTDIR
  
  ;Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"

SectionEnd

;#########################################

Section /o "SWBFSpy Multiplayer Fix" SecF

  SetOutPath "$INSTDIR"
  ;FILES HERE...
  file /r SWBF2_Remaster_Installer\files\SWBF2_SWBFSpy\GameData
  
  ;Store installation folder
  WriteRegStr HKCU "Software\SWBF2_Remaster" "" $INSTDIR
  
  ;Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"

SectionEnd

;#########################################

;--------------------------------
;Descriptions

  ;Language strings
  LangString DESC_SecA ${LANG_ENGLISH} "Unofficial patch for the game, fixing most of the issues and problems left by original developers."
  LangString DESC_SecB ${LANG_ENGLISH} "Higher resolution support for menu and fixed multiplayer screen."
  LangString DESC_SecC ${LANG_ENGLISH} "Make your game more realistic and HD by adjusting color saturation, improving game lighting, sharpening the image, using a more subtle bloom."
  LangString DESC_SecD ${LANG_ENGLISH} "This mod will replace the stock sides (units) with upgraded player models, weapons and eventually vehicles."
  LangString DESC_SecE ${LANG_ENGLISH} "Realistic and movie accurate improved maps with HD textures, general re-design and optimized graphics."
  LangString DESC_SecF ${LANG_ENGLISH} "SWBFSpy is the replacement of the GameSpy Master Server, so you can browse servers and join them."

  ;Assign language strings to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${SecA} $(DESC_SecA)
    !insertmacro MUI_DESCRIPTION_TEXT ${SecB} $(DESC_SecB)
    !insertmacro MUI_DESCRIPTION_TEXT ${SecC} $(DESC_SecC)
    !insertmacro MUI_DESCRIPTION_TEXT ${SecD} $(DESC_SecD)
    !insertmacro MUI_DESCRIPTION_TEXT ${SecE} $(DESC_SecE)
    !insertmacro MUI_DESCRIPTION_TEXT ${SecF} $(DESC_SecF)
  !insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------
;Uninstaller Section

Section "Uninstall"

  ;FILES HERE...
  Delete "$INSTDIR\Uninstall.exe"
  RMDir "$INSTDIR"
  DeleteRegKey /ifempty HKCU "Software\SWBF2_Remaster"

SectionEnd