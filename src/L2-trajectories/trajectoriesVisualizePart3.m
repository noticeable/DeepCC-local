%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% VISUALIZE 3: SHOW ALL MERGED TRACKLETS IN WINDOWS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(3)
if opts.dataset ~=2
    imshow(opts.reader.getFrame(opts.current_camera,endTime));
else
    imshow(opts.reader.getFrame(opts.current_scene, opts.current_camera,endTime));
end
hold on;

currentTrajectories = smoothTrajectories;
numTrajectories = length(currentTrajectories);

colors = distinguishable_colors(numTrajectories);
for k = 1:numTrajectories
    
    
    for i = 1 : length(currentTrajectories(k).tracklets)
        
        detections = currentTrajectories(k).tracklets(i).data;
        trackletCentersView = getBoundingBoxCenters(detections(:, 3:6));
        
        plot(trackletCentersView(:,1),trackletCentersView(:,2),'LineWidth',4,'Color',colors(k,:));
        hold on;
        
    end
    
end

hold off;
drawnow;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
