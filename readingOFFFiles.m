
%% --------------------------------------------------------------- preamble

clc; clear; clf; close all; format compact;

%% --------------------------------------------------------------- settings

fileID = fopen('dresser_0007.off');
% fileID = fopen('m218.off');

showVertices = 0;

%% ------------------------------------------------------------- processing

disp '>> Storing the structure ...';

dimRow = true;

vertexCount = [];  
faceCount = [];    
edgeCount = [];    
rowCount = 1;

vertexList{1} = [];
faceList{1} = [];
faceColorList{1} = [];

while (~feof(fileID))
    
    currLine = textscan(fileID,'%s',1,'Delimiter','\n');
    currRow = char(currLine{1});
    splittedRow = strsplit(currRow,' ');
    
    if (~strcmp(splittedRow(1),'#') && ~strcmp(splittedRow(1),'OFF'))
        
        splittedRow = str2double(splittedRow);
        
        if(dimRow)
            dimRow = false;
            
            vertexCount = splittedRow(1);
            faceCount = splittedRow(2);
            edgeCount = splittedRow(3);
        else
            if(rowCount <= vertexCount)
                
                vertexList{rowCount} = [splittedRow(1) splittedRow(2) splittedRow(3)];
                
            end
            if(vertexCount < rowCount && (rowCount-vertexCount) <= faceCount)
                
                if(splittedRow(1) == 3)
                    
                    faceList{rowCount-vertexCount} = [splittedRow(2) splittedRow(3) splittedRow(4)];
                    % faceColorList{rowCount-vertexCount} = [splittedRow(5) splittedRow(6) splittedRow(7) splittedRow(8)];
                    
                end
                if(splittedRow(1) == 4)
                    
                    faceList{rowCount-vertexCount} = [splittedRow(2) splittedRow(3) splittedRow(4) splittedRow(5)];
                    % faceColorList{rowCount-vertexCount} = [splittedRow(6) splittedRow(7) splittedRow(8) splittedRow(9)];
                    
                end
                
            end
            
            rowCount = rowCount +1;
            
            % progress
            if(mod(rowCount,10000)==0)
                disp('.');
            end
        end
        
    end
    
end

disp '>> Strucure stored';
disp '>>  ';
disp '>> Plot beginning';

figure(1); grid on; grid minor; axis equal;
hold on;

if(showVertices)
    for i=1:size(vertexList,2)
        
        currV = vertexList{i};
        plot3(currV(1),currV(2),currV(3),'ob');
        
    end
end

for j=1:size(faceList,2)
   
    currF = faceList{j};
    
    xCoo = [];
    yCoo = [];
    zCoo = [];
    for k=1:size(currF,2)
        xCoo = [xCoo vertexList{currF(k)+1}(1)];
        yCoo = [yCoo vertexList{currF(k)+1}(2)];
        zCoo = [zCoo vertexList{currF(k)+1}(3)];
    end
    xCoo = [xCoo xCoo(1)];
    yCoo = [yCoo yCoo(1)];
    zCoo = [zCoo zCoo(1)];
    
    plot3(xCoo, zCoo, yCoo); %<----
    
end


view(-140,12);
hold off;


