function [ pixel_shift ] = compare( image, estimatedImage )
%COMPARE Summary of this function goes here
%   Detailed explanation goes here
    
image_logic = image(:,:,1) > 0.2;
image_est_logic = estimatedImage(:,:,1) > 0.2;
    
image_skeleton = bwmorph(image_logic, 'thin', Inf);
image_est_skeleton = bwmorph(image_est_logic, 'thin', Inf);

[rows, cols, ~] = size(image);
Diff = zeros(rows, cols);

border = 50;
left = border;
right = cols - border;
up = border;
down = rows - border;

 %% Calculate the distance
 for ii = up:1:down
     for ij = left:1:right
            if(image_skeleton(ii,ij)==1)
                mymin = 100;
                for indx = (ii-9):(ii+9)
                    for indy = (ij-9):(ij+9)
                        if image_est_skeleton(indx, indy) == 1
                            mymin = min(mymin, sqrt((ii-indx)*(ii-indx) + (ij-indy)*(ij-indy)));
                        end
                    end
                end
                Diff(ii,ij) = mymin;
            end
    end
end
    
count = 0;
distance = 0;
for ii = 1:rows
    for ij = 1:cols
        if Diff(ii,ij) ~= 0 && Diff(ii,ij) ~= 100
           distance = distance + Diff(ii,ij);
           count = count + 1;
        end
    end
end
    
if count == 0
    pixel_shift = 0;
else
    pixel_shift = distance / count;
end

    
end
