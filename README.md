# CAD-Model-PointCloud
.mat files of Point cloud of CAD models

### Sources:
1. Hawkeye
https://github.com/JaydenG1019/HawkEye-Data-Code
- Cars (first 10 only, the rest can be found at repository above)
<Orignally in .mat>

2. Priceton ModelNet
https://modelnet.cs.princeton.edu/
- Chairs
- Desks
- Dressers/Cabinets
<.off format>

3. GrabCAD Community
https://grabcad.com/library
- Robot Arms
- Dressers/Cabinets
<.step or .stl formats>

## Conversion to PointCloud 
To convert CAD models into PointCloud, we use [FreeCAD](https://www.freecadweb.org/)
0. For files in ".step" format whose objects are solid shape, skip step #1.
1. For files in ".off", ".stl" formats whose objects are meshes, first convert to solid objects.
  - Go to tab "View", select "Part" under "Workbench", a new tab called "Part" will show up
  - Select the mesh object 
  - Go to tab "Part", select "Create shape from mesh" to obtain a solid version of the object
2. 
  - Go to tab "View", select "Points" under "Workbench", a new tab called "Points" will show up
  - Select the shape object
  - Go to tab "Points", select "Convert to points" to obtain a point cloud version of the object


