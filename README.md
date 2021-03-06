# CAD-Model-PointCloud
.mat files of Point cloud of CAD models

## Conversion to PointCloud 
To convert CAD models into PointCloud, we use [FreeCAD](https://www.freecadweb.org/).
+ For files in ".off", ".stl" formats whose objects are meshes, first convert to solid objects.
+ For files in ".step" format whose objects are solid shape, skip step #1.


1. Create Shape from Mesh
    - Go to tab "View", select "Part" under "Workbench", a new tab called "Part" will show up
    - Select the mesh object 
    - Go to tab "Part", select "Create shape from mesh" to obtain a solid version of the object
2. Convert Shape to Points
    - Go to tab "View", select "Points" under "Workbench", a new tab called "Points" will show up
    - Select the shape object
    - Go to tab "Points", select "Convert to points" to obtain a point cloud version of the object
3. Save the point cloud as .pcd files
    - A MATLAB script "pcd2mat.m" is provided to convert the .pcd files into .mat format.
    - Notes: Transformations and/or scaling may be needed, depending on the original CAD models.


### Sources:
1. Hawkeye
https://github.com/JaydenG1019/HawkEye-Data-Code
- Cars (first 10 only, the rest can be found at repository above)
| Orignally in .mat |

2. Priceton ModelNet
https://modelnet.cs.princeton.edu/
- Chairs
- Desks
- Dressers/Cabinets
* .off format

3. GrabCAD Community
https://grabcad.com/library
- Robot Arms
- Dressers/Cabinets
* .step or .stl formats




