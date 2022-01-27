%%% load a pcd (point cloud data) file and save it as mat format
close all; clear; clc;

item = "desk";
loadaddr = strcat("F:\CADs\",item,"\");
saveaddr = loadaddr;


for idx = 8
    disp(strcat("loading ", item, " ", num2str(idx)));
    % mode 1: pcd -> mat
    % mode 2: display mat
    for mode = 1:2
        switch mode
            % convert pcd to mat
            case 1   
                filename = strcat(item,'_',num2str(idx));
                pcdpath = strcat(loadaddr, filename,".pcd");

                % load point cloud object
                ptCloud = pcread(pcdpath); 

                %pcshow(ptCloud);

                % extract the x,y,z's
                cart_v = double(ptCloud.Location); % use the variable name "cart_v" from Hawkeye

                % filtering
                %cart_v = cart_v(1:10:end,:);
                
                % transform and crop
                
                %temp = cart_v(:,2);
                %cart_v(:,2) = cart_v(:,3);
                %cart_v(:,3) = cart_v(:,2);
                %cart_v(:,3) = temp;
                %cart_v(:,2) = -cart_v(:,2);
                %{
                idx = find(cart_v(:,3)>0.0162);
                cart_v = cart_v(idx,:);
                %}
                

                % shift to origin
                dx = (min(cart_v(:,1)) + max(cart_v(:,1)))/2;
                dy = (min(cart_v(:,2)) + max(cart_v(:,2)))/2;
                cart_v(:,1) = cart_v(:,1) - dx;
                cart_v(:,2) = cart_v(:,2) - dy;
                cart_v(:,3) = cart_v(:,3) - min(cart_v(:,3)); % min(z) -> 0

                L = max(cart_v(:,1))-min(cart_v(:,1));
                W = max(cart_v(:,2))-min(cart_v(:,2));
                H = max(cart_v(:,3))-min(cart_v(:,3));
                disp("Dimensions before scaling (unitless)");
                disp(strcat("L=", num2str(L)," W=", num2str(W)," H=", num2str(H)));

                % scaling
                ratio = 3;%*1.2;%1 / L * (randi([40,45]) + rand()) * 10;
                cart_v = cart_v * ratio; % mm
                %cart_v(:,1) = cart_v(:,1) * 1.1; % mm
                %cart_v(:,2) = cart_v(:,2) * 2; % mm
                cart_v(:,3) = cart_v(:,3) *1.75; % mm
                
                L = max(cart_v(:,1))-min(cart_v(:,1));
                W = max(cart_v(:,2))-min(cart_v(:,2));
                H = max(cart_v(:,3))-min(cart_v(:,3));
                disp("Dimensions after scaling (m)");
                disp(strcat("L=", num2str(L/1000)," W=", num2str(W/1000)," H=", num2str(H/1000)));

                % saving
                disp("saving mat")
                save(strcat(saveaddr,filename,".mat"), 'cart_v');

        % display and check mat
        case 2
            filename = strcat(item,'_',num2str(idx));
            pcdpath = strcat(loadaddr, filename,".mat");

            cart_v = load(pcdpath).cart_v; % point cloud object

            f = scatter3plot(cart_v, item, idx);

            disp("saving image");
            saveas(f, strcat(saveaddr,filename), 'png');
            %disp(idx); 
        end
    end
end
disp("done");



%%
function f = scatter3plot(ptCloud,item,idx)
    ptCloud = ptCloud/1000; % scale to m
    step = 1;
    ptCloud = ptCloud(1:step:end,:);
    f = figure;
    scatter3(ptCloud(:,1),ptCloud(:,2),ptCloud(:,3),1,'filled','k');
    title(strcat(item," - ",num2str(idx)));
    axis equal; grid minor; 
    %xlim([-2,2]),ylim([0,4]), zlim([-0.45,1]);
    xlabel('x (m)'),ylabel('y (m)'),zlabel('z (m)')
    %view(0,90)
end

