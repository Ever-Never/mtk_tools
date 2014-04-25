@echo off
color 1f
mode con cols=58 lines=30
title MTK BOOT/RECOVERY ���/�������
:CHO
cls
@echo ********************************************************
@echo.
@echo               MTK BOOT/RECOVERY ���/�������
@echo.
@echo.                                               by suda
@echo ********************************************************
echo --------------------------------------------------------
echo �뽫boot.img/recovery.img���ڴ��ļ���
echo ѡ����Ӧѡ�����
echo ���������boot-new.img/recovery-new.img
echo ���߲�֧������·��
echo --------------------------------------------------------
echo.  [ѡ����Ž��в���]
echo --------------------------------------------------------
echo   1.���boot
echo   2.���boot
echo   3.���recovery		
echo   4.���recovery			
echo   0.�˳�����
echo. 
echo --------------------------------------------------------
echo.                            %date% %time%
set choice=
set /p choice= ѡ��[0-4]����:
IF NOT "%choice%"=="" SET choice=%choice:~0,2%
if /i "%choice%"=="0" EXIT
if /i "%choice%"=="1" goto unpack_boot
if /i "%choice%"=="2" goto repack_boot
if /i "%choice%"=="3" goto unpack_recovery
if /i "%choice%"=="4" goto repack_recovery
echo ѡ����Ч������������
ping 127.0.0.1 -n 2 >NUL
echo.
goto CHO

:unpack_boot
if not exist boot.img (echo.
echo δ����boot.img�ļ���,�����������˵�
ping 127.0.0.1 -n 2 >NUL
goto CHO
) 
if exist boot (rd /s /q boot)
echo ���ڽ��boot.img......
md boot
copy boot.img boot>NUL
cd boot
..\tools\bootimg.exe --unpack-bootimg
del boot-old.img
del boot.img 
cd ..
goto CHO

:repack_boot
if not exist boot (echo.
echo δ����boot�ļ���,�����������˵�
ping 127.0.0.1 -n 2 >NUL
goto CHO
) else echo.
echo ���ڴ��boot.img......
xcopy  /e/I/h/r/y/s "boot" "boot_bak">NUL
cd boot
..\tools\bootimg.exe --repack-bootimg
cd ..
move boot\boot-new.img .>NUL
rd /s /q boot
ren boot_bak boot
goto CHO

:unpack_recovery
if not exist recovery.img (echo.
echo δ����recovery.img�ļ���,�����������˵�
ping 127.0.0.1 -n 2 >NUL
goto CHO
) 
if exist recovery (rd /s /q recovery)
echo ���ڽ��recovery.img......
md recovery
copy recovery.img recovery\boot.img>NUL
cd recovery
..\tools\bootimg.exe --unpack-bootimg
del boot-old.img
del boot.img
cd ..
goto CHO

:repack_recovery
if not exist recovery (echo.
echo δ����recovery�ļ���,�����������˵�
ping 127.0.0.1 -n 2 >NUL
goto CHO
) else echo.
echo ���ڴ��recovery.img......
xcopy  /e/I/h/r/y/s "recovery" "recovery_bak">NUL
cd recovery
..\tools\bootimg.exe --repack-bootimg
cd ..
move recovery\boot-new.img .\recovery-new.img>NUL
rd /s /q recovery
ren recovery_bak recovery
goto CHO