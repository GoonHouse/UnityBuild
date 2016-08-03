# UnityBuild
Build your unity applications in a way that people won't hate you for it! Takes care of annoying unity quirks such as:
* Building for all platforms being slow and boring by default.
* Inconsistencies in the unity build prompts.
* There not being a default command line argument for WebGL builds.
* When building from Windows, the Mac build is permissioned wrong.

# Installing
1. Clone this into the root of your unity project.
2. Modify `unitybuild.sh` so that `gamename` is equal to the executable name you want when you build, e.g. `YourGame.exe`.
3. _Potentially_ Modify `unitybuild.bat` so that `unitypath` is set to your unity install location.
4. Make sure your build settings are configured properly in unity. You should manually build at least once.

# Building
Using cygwin to run this script from the root of your project:
```
./unitybuild.sh buildName
```

This will create the following:
```
Builds/buildName/linux/YourGame.tar.gz
Builds/buildName/mac/YourGame.tar.gz
Builds/buildName/win32/YourGame.zip
Builds/buildName/win64/YourGame.zip
Builds/buildName/webgl/Release/*
Builds/buildName/webgl/TemplateData/*
Builds/buildName/webgl/index.html
Builds/buildName/YourGame-judges.zip
```

Each of the following will contain:
* **linux/YourGame.tar.gz** A folder named `YourGame` that contains the linux universal build.
* **mac/YourGame.tar.gz** `YourGame.app` with its permissions corrected.
* **win32/YourGame.zip** `YourGame.exe` and the accompanying `YourGame_Data`.
* **win64/YourGame.zip** `YourGame.exe` and the accompanying `YourGame_Data`.
* **webgl/** `index.html` and all the files for the web build of `YourGame`.
* **YourGame-judges.zip** The folders `linux`, `mac`, `win32`, `win64`, `webgl` with the files for each corresponding build sitting directly inside the folder.

# To Do
* Figure out the best way to make the enhanced `unitybuild.sh` run in regular ol' windows. Powershell? Wgetting a tar executable?!
* Maybe just make all the build things happen from inside our `UnityBuild.cs` file.
	* This will be difficult because the Unity.exe CLI build arguments expose features that aren't in the BuildPipeline / BuildOptions.
	* Heck.
* Have a copyfile list to import into the root.
* Make a fancy little webpage generator.
	* Inline the WebGL build as an expandable section.
	* Generate download links to the builds.
	* Inline a description / other misc copy from a template.