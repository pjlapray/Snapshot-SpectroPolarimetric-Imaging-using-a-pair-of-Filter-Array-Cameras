# Spectral-and-Polarimetric-database
A database of spectral and polarimetric images acquired from stereoscopic acquisition system in visible region.
If you use images from this dataset, please cite the following paper:
Pierre-Jean Lapray, Barthélémy Heyrman, Dominique Ginhac, "Hardware-based smart camera for recovering high dynamic range video from multiple exposures," 
"S. Sattar, P.-J. Lapray, L. Aksas, A. Foulonneau & L. Bigué, “Snapshot SpectroPolarimetric Imaging using a pair of Filter Array Cameras“, Opt. Eng. (2022)."

The folder name "Geometric_corrected_database" contains "y" images acquired from the left CPFA camera with GG47 yellow (y) filter. The right images with name "bg" are captured using the right CPFA camera with a BG-39 blue-green (bg) filter. 

The images are pre-processed geometrically (until subsection 3.1 in the paper). The images are stored with name as depicted in Figure 8 of the paper.
There are stored as multipage tif files, the four pages correspond to 0, 45, 90, and 135 polarization angles respectively.

For Stokes, reflectance, and color transforms, the code scripts are given with respective title. 
Please respect the order of script execution indicated by the numbers.


