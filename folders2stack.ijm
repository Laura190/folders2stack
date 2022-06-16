/*
 * Macro template to process multiple images in a folder
 */

#@ File (label = "Input directory", style = "directory") input
#@ File (label = "Output directory", style = "directory") output
#@ String(label="Stack Name", description="Your name") name

// See also Process_Folder.py for a version of this code
// in the Python scripting language.

processFolder(input);

// function to scan folders/subfolders/files to find files with correct suffix
function processFolder(input) {
	list = getFileList(input);
	list = Array.sort(list);
	for (i = 0; i < list.length; i++) {
		if(File.isDirectory(input + File.separator + list[i]))
			File.openSequence(input + File.separator + list[i]);
	}
	numframes=(list.length)
	numslices=(nSlices)
	run("Concatenate...", "all_open open");
	run("Stack to Hyperstack...", "order=xyctz channels=1 slices="+numframes+" frames="+numslices+" display=Color");
	saveAs("Tiff", output + File.separator + name +".tif");
}