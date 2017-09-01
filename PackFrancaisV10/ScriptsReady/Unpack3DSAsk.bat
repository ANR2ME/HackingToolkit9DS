@echo off
cls
echo.
set CciName=%~n1
set CciExt=%~x1
set CciFull=%CciName%%CciExt%
set /p DecompressCode="D�compresser le fichier code.bin pour "%CciFull%" (n/o) : "
if /i "%DecompressCode%"=="Y" (SET ScriptCode=xutf) else (SET ScriptCode=xtf)
cls
echo.
echo Veuillez patienter, extraction de "%CciFull%" en cours...
echo.
md %1_Unpacked >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xtf 3ds %1 --header %1_Unpacked/HeaderNCCH.bin -0 %1_Unpacked/DecryptedPartition0.bin -1 %1_Unpacked/DecryptedPartition1.bin -2 %1_Unpacked/DecryptedPartition2.bin -6 %1_Unpacked/DecryptedPartition6.bin -7 %1_Unpacked/DecryptedPartition7.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xtf cxi %1_Unpacked/DecryptedPartition0.bin --header %1_Unpacked/HeaderNCCH0.bin --exh %1_Unpacked/DecryptedExHeader.bin --exh-auto-key --exefs %1_Unpacked/DecryptedExeFS.bin --exefs-auto-key --romfs %1_Unpacked/DecryptedRomFS.bin --romfs-auto-key --logo %1_Unpacked/LogoLZ.bin --plain %1_Unpacked/PlainRGN.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xtf cfa %1_Unpacked/DecryptedPartition1.bin --header %1_Unpacked/HeaderNCCH1.bin --romfs %1_Unpacked/DecryptedManual.bin --romfs-auto-key >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xtf cfa %1_Unpacked/DecryptedPartition2.bin --header %1_Unpacked/HeaderNCCH2.bin --romfs %1_Unpacked/DecryptedDownloadPlay.bin --romfs-auto-key >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xtf cfa %1_Unpacked/DecryptedPartition6.bin --header %1_Unpacked/HeaderNCCH6.bin --romfs %1_Unpacked/DecryptedN3DSUpdate.bin --romfs-auto-key >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xtf cfa %1_Unpacked/DecryptedPartition7.bin --header %1_Unpacked/HeaderNCCH7.bin --romfs %1_Unpacked/DecryptedO3DSUpdate.bin --romfs-auto-key >NUL 2>NUL
del %1_Unpacked\DecryptedPartition0.bin >NUL 2>NUL
del %1_Unpacked\DecryptedPartition1.bin >NUL 2>NUL
del %1_Unpacked\DecryptedPartition2.bin >NUL 2>NUL
del %1_Unpacked\DecryptedPartition6.bin >NUL 2>NUL
del %1_Unpacked\DecryptedPartition7.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xtf romfs %1_Unpacked/DecryptedRomFS.bin --romfs-dir %1_Unpacked/ExtractedRomFS >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xtf romfs %1_Unpacked/DecryptedManual.bin --romfs-dir %1_Unpacked/ExtractedManual >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xtf romfs %1_Unpacked/DecryptedDownloadPlay.bin --romfs-dir %1_Unpacked/ExtractedDownloadPlay >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xtf romfs %1_Unpacked/DecryptedN3DSUpdate.bin --romfs-dir %1_Unpacked/ExtractedN3DSUpdate >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xtf romfs %1_Unpacked/DecryptedO3DSUpdate.bin --romfs-dir %1_Unpacked/ExtractedO3DSUpdate >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -%ScriptCode% exefs %1_Unpacked/DecryptedExeFS.bin --exefs-dir %1_Unpacked/ExtractedExeFS --header %1_Unpacked/HeaderExeFS.bin >NUL 2>NUL
ren %1_Unpacked\ExtractedExeFS\banner.bnr banner.bin >NUL 2>NUL
ren %1_Unpacked\ExtractedExeFS\icon.icn icon.bin >NUL 2>NUL
copy %1_Unpacked\ExtractedExeFS\banner.bin %1_Unpacked/banner.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -x -t banner -f %1_Unpacked\banner.bin --banner-dir %1_Unpacked\ExtractedBanner\ >NUL 2>NUL
ren %1_Unpacked\ExtractedBanner\banner0.bcmdl banner.cgfx >NUL 2>NUL
del %1_Unpacked\banner.bin >NUL 2>NUL