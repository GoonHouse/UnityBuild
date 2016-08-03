#!/bin/bash

# $1 = the build to make

gamename="YourGame";
projpath=`pwd -P`;
projpath="`cygpath -w "${projpath}"`";
unitypath="/cygdrive/c/Program Files/Unity/Editor/Unity.exe";

buildname="$1";
temppath="${projpath}\\TempBuilds\\${buildname}\\";
basepath="${projpath}\\Builds\\${buildname}\\";

buildargs="";
exbuildargs="-s ASSERTIONS=1 -logFile \"${projpath}build-${gamename}-${buildname}.log\" -projectPath \"${projpath}\" -batchmode -quit";

UnityBuild_Prepare(){
	if [ -d "${temppath}" ]; then
		echo "no temp";
		rm -rf "${temppath}";
	else
		echo "temp didn't exist";
	fi
	if [ -d "${basepath}" ]; then
		echo "no base";
		rm -rf "${basepath}";
	else
		echo "base didn't exist";
	fi
	mkdir -p "${temppath}linux" "${temppath}mac" "${temppath}win32" "${temppath}win64" "${temppath}webgl";
	mkdir -p "${basepath}linux" "${basepath}mac" "${basepath}win32" "${basepath}win64" "${basepath}webgl";
}

UnityBuild_BuildAll(){
	
	# linux
	buildargs+=" -buildLinuxUniversalPlayer \"${temppath}linux\\${gamename}\"";
	
	# mac
	buildargs+=" -buildOSXUniversalPlayer \"${temppath}mac\\${gamename}.app\"";
	
	# win32
	buildargs+=" -buildWindowsPlayer \"${temppath}win32\\${gamename}.exe\"";
	
	# win64
	buildargs+=" -buildWindows64Player \"${temppath}win64\\${gamename}.exe\"";
	
	# webgl
	buildargs+=" -executeMethod UnityBuild.Build_WebGL \"${temppath}webgl\"";
	
	echo -e "\"${unitypath}\" ${buildargs} ${exbuildargs}";
	
	bash -c "\"${unitypath}\" ${buildargs} ${exbuildargs}";
}

UnityBuild_Archive(){
	# linux
	mv "${temppath}linux" "${temppath}${gamename}";
	tar cvpzf "`cygpath -u \"${basepath}linux/${gamename}.tar.gz\"`" -C "${temppath}" "${gamename}";
	mv "${temppath}${gamename}" "${temppath}linux";
	
	# mac
	chmod +x "${temppath}mac\\${gamename}.app\\Contents\\MacOS\\${gamename}";
	tar cvpzf "`cygpath -u \"${basepath}mac/${gamename}.tar.gz\"`" -C "${temppath}mac" "${gamename}.app";
	
	# win
	rm -rf "${temppath}win32\\player_win_x86.pdb" "${temppath}win32\\player_win_x86_s.pdb";
	rm -rf "${temppath}win64\\player_win_x64.pdb" "${temppath}win64\\player_win_x64_s.pdb";
	cd "${temppath}win32";
	zip -r "${basepath}win32\\${gamename}.zip" ".";
	cd "${temppath}win64";
	zip -r "${basepath}win64\\${gamename}.zip" ".";
	cd "${projpath}";
	
	#webgl
	cp -R "${temppath}webgl" "${basepath}";
}

UnityBuild_Judges(){
	cd "${temppath}..";
	mv "${temppath}..\\${buildname}" "${temppath}..\\${gamename}";
	zip -r "${basepath}${gamename}-judges.zip" "${gamename}";
	mv "${temppath}..\\${gamename}" "${temppath}..\\${buildname}";
	cd "${projpath}";
}


UnityBuild_Prepare;

UnityBuild_BuildAll;

UnityBuild_Archive;

UnityBuild_Judges;