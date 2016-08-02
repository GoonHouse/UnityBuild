# UnityBuild
Build your unity applications in a way that people won't hate you for it! Takes care of annoying unity quirks such as:
* Building for all platforms being slow and boring by default.
* Inconsistencies in the unity build prompts.
* There not being a default command line argument for WebGL builds.
* When building from Windows, the Mac build is permissioned wrong.

# Installing
1. Clone this into the root of your unity project.
2. Modify `build.bat` so that `gamename` is equal to the executable name you want when you build, e.g. `YourGame.exe`.
3. _Potentially_ Modify `build.bat` so that `unitypath` is set to your unity install location.
4. Make sure your build settings are configured properly in unity. You should manually build at least once.

# Building
## Step 1
In Windows Command Prompt, at the root of your project run:
```
>build temp
```
With the default settings, this will create:
```
.\Builds\temp\linux\*
.\Builds\temp\mac\*
.\Builds\temp\webgl\*
.\Builds\temp\win32\*
.\Builds\temp\win64\*
```
As if you had run the default build options for each of the platforms, creating two for windows.

You can also replace `buildname` in `build.bat` with a hardcoded build name like `temp`.

## Step 2
From Cygwin, at the root of your project:
```
$ ./makegood.sh temp YourGame beta5
```

This will create the following:
```
./Builds/beta5/linux/YourGame.tar.gz
./Builds/beta5/mac/YourGame.tar.gz
./Builds/beta5/win32/YourGame.zip
./Builds/beta5/win64/YourGame.zip
./Builds/beta5/Release/*
./Builds/beta5/TemplateData/*
./Builds/beta5/index.html
```

This can be uploaded directly to your website, or you could zip the entire folder and release it.

# To Do
* Wipe the temporary build directory.
* Make `makegood.sh` do what `build.bat` does so it can just be run from cygwin.
* Figure out the best way to make the enhanced `makegood.sh` run in regular ol' windows. Powershell? Wgetting a tar executable?!
* Maybe just make all the build things happen from inside our `UnityBuild.cs` file.
	* This will be difficult because the Unity.exe CLI build arguments expose features that aren't in the BuildPipeline / BuildOptions.
	* Heck.
* Generate a `judging.zip` for judges.
	* Have a copyfile list to import into the root.
* Make a fancy little webpage generator.
	* Inline the WebGL build as an expandable section.
	* Generate download links to the builds.
	* Inline a description / other misc copy from a template.