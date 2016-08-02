/*
Relevant Article:
http://jonathanpeppers.com/Blog/automating-unity3d-builds-with-fake

Unity Reference:
https://docs.unity3d.com/Manual/CommandLineArguments.html
https://docs.unity3d.com/ScriptReference/BuildPipeline.html
https://docs.unity3d.com/ScriptReference/BuildOptions.html
https://docs.unity3d.com/ScriptReference/EditorUserBuildSettings.html
*/
using UnityEditor;
using System.Collections.Generic;

class UnityBuild {
	// Get all the scenes that are enabled.
	static string[] GetScenes(){
		var scenes = EditorBuildSettings.scenes;
		List<string> goodScenes = new List<string>();
		foreach( EditorBuildSettingsScene scene in scenes) {
			if( scene.enabled ) {
				goodScenes.Add(scene.path);
			}
		}
		return goodScenes.ToArray();
	}
	
	static void Build_WebGL(){
		string[] arguments = System.Environment.GetCommandLineArgs();
		int i = 0;
		string outPath = "";
		foreach( string s in arguments ){
			if( s == "UnityBuild.Build_WebGL" && arguments.Length-1 >= i+1 ){
				outPath = arguments[i+1];
			}
			i++;
		}
		
		BuildPipeline.BuildPlayer(GetScenes(), outPath, BuildTarget.WebGL, BuildOptions.None);
	}
}