rem @echo off
rem ת����ǰ�̷�
%~d0
rem �򿪵�ǰĿ¼
cd %~dp0
rem ��������JAR����·��
set SOURCEJAR=com.mmsns.ane.jar
set MainJar=mmsnsbillingane.jar
rem ������JAR����·��
set ExternalJar=mmsmsbilling1.2.2.jar
rem ������JAR������������
set packageName=com
set packageName2=mm
rem swc�ļ���
set SWC=MMANE-SNS.swc
echo =========== start make jar ==============
rem ������ʱĿ¼
md temp
rem ������ʱ�ļ�
rem copy %SOURCEJAR% %MainJar%
copy .\android-project\bin\%SOURCEJAR% .\temp\%MainJar% >nul
copy .\SDK1.2.2\libs\%ExternalJar% .\temp\ >nul
cd temp
rem ��ѹ��������
jar -xf %ExternalJar%
rem �ϲ���JAR��
jar -uf %MainJar% %packageName% 
rem �ϲ�����������
jar -uf %MainJar% %packageName2%
rem ������ȥane����Ŀ¼
copy %MainJar% ..\ane-build-path\android-ARM >nul
rem �������������ane����ģ�����android̫�鷳
xcopy assets\* ..\ /s/q/y >nul
pause
cd ..
rd /s/q temp
echo =========== jar make over,start build ane ==============
copy .\actionscript\bin\%SWC% .\ane-build-path >nul
mkdir .\ane-build-path\android-ARM\libs
mkdir .\ane-build-path\android-ARM\libs\armeabi
mkdir .\ane-build-path\android-ARM\libs\armeabi-v7a
copy .\SDK1.2.2\libs\armeabi\libsmsiap.so .\ane-build-path\android-ARM\libs\armeabi >nul
copy .\SDK1.2.2\libs\armeabi\libsmsiap.so .\ane-build-path\android-ARM\libs\armeabi-v7a >nul
cd ane-build-path
jar -xf %SWC%
move catalog.xml .\android-ARM\ >nul
move library.swf .\android-ARM\ >nul
echo ===========building ane now ===========================
rem build ane
set FLEX_SDK=D:\AIR_3.9
set FLEX_SDK_BIN= %FLEX_SDK%\bin
set FLEX_LIBS=%FLEX_SDK%\frameworks\libs
java -jar "%FLEX_SDK%\lib\adt.jar" -package -target ane com.mmsns.ane extension.xml -swc *.swc -platform Android-ARM -C Android-ARM . 
move com.mmsns.ane ..\ >nul
cd ..
echo =========build complete==========
echo =========���apk��ʱ��ǵð�mmiapĿ¼Ҳ�����ȥ�������������===
pause>nul