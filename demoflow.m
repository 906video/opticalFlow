function [vx1,vy1, estimatedI1] = demoflow(example,index)

addpath('mex');

% % we provide two sequences "car" and "table"
% % example = 'table';
% % example = 'car';
% % example = 'bird';
% % example = 'box';
% % example = 'stapler';

% % load the two frames
datadir = fullfile( fileparts( mfilename( 'fullpath' ) ), 'Data' );

filename1 = fullfile( datadir, sprintf( '%s%04d.jpg', example, index-1) );
im1 = im2double(imread(filename1));

% We try both JPG and PPM extensions, trying JPG first since it is
% the faster to load
filename = fullfile( datadir, sprintf( '%s%04d.jpg', example, index ) );
if exist( filename, 'file' )~=2
   error( 'SpaceCarving:ImageNotFound', ...
        'Could not find image %d (''%s%04d.jpg/.ppm'')', ...
        index, example, index );
end

im2 = im2double(imread(filename));

% set optical flow parameters (see Coarse2FineTwoFrames.m for the definition of the parameters)
alpha = 0.012;
% ratio = 0.467;
ratio = 0.7;
minWidth = 50;
nOuterFPIterations = 7;
nInnerFPIterations = 1;
nSORIterations = 30;

para1 = [alpha,ratio,minWidth,nOuterFPIterations,nInnerFPIterations,nSORIterations];

tic;
% [vx1,vy1,warpI21] = Coarse2FineTwoFrames(im1,im2,para1);
[vx1,vy1] = Coarse2FineTwoFrames(im1,im2,para1);
toc

% figure;imshow(im1);
% figure;imshow(warpI21);
% % title('alpha: '+ alpha + 'ratio: '+ ratio + 'minWidth: '+ minWidth);
% 
% % output gif
% clear volume;
% volume(:,:,:,1) = im1;
% volume(:,:,:,2) = im2;
% if exist('output','dir')~=7
%     mkdir('output');
% end
% frame2gif(volume,fullfile('output',[example '_input.gif']));
% volume(:,:,:,2) = warpI21;
% frame2gif(volume,fullfile('output',[example '_warp.gif']));
% 
% 
% % visualize flow field
% % clear flow;
% % flow(:,:,1) = vx1;
% % flow(:,:,2) = vy1;
% 
% 
% % imflow = flowToColor(flow);
% % figure;
% % imshow(imflow);
% % 
% % imwrite(imflow,fullfile('output',[example '_flow.jpg']),'quality',100);
% 
% [a,b] = size(vx1);
% estimatedI1 = zeros(a,b,3);
% 
% for i = 1:a
%     for j = 1:b
%         posx = round( i + vy1(i,j));
%         posy = round( j + vx1(i,j));
%         
%         posx = max( min(posx, a), 1);
%         posy = max( min(posy, b), 1);
%         
%         estimatedI1(i,j,:) = im2(posx, posy,:);
%         
%     end
% end
% 
% % figure;
% % imshow(estimatedI1);
% 
% volume(:,:,:,2) = estimatedI1;
% frame2gif(volume,fullfile('output',sprintf( '%sdifference%02dE%02d.gif', example, index-1, index)));
% 
% imwrite(estimatedI1,fullfile('output',sprintf( 'estimatedI%02d.jpg', example, index-1)));

% count = 0;
% for i=1:a
%     for j = 1:b 
%         if(warpI21(i,j,1) - warpI21(i,j,2) > 0.1)
%             count = count + 1;
%             warpI21(i,j,1) = 0;
%             warpI21(i,j,2) = 1;
%             warpI21(i,j,3) = 0;
%         end
%         
%         if(im1(i,j,1) - im1(i,j,2) > 0.1)
%             warpI21(i,j,:) = im1(i,j,:);
%         end
%         
% 
%     end
% end
% 
% figure;
% imshow(warpI21);
% filename_out = fullfile( datadir, sprintf( '%s%04dout.jpg', example, index) );
% imwrite(warpI21,filename_out,'quality',100);


% for i=1:a
%     for j = 1:b 
%         if(im1(i,j,1) - im1(i,j,2) > 0.1)
%             im1(i,j,1) = 0;
%             im1(i,j,2) = 1;
%             im1(i,j,3) = 0;
%         end
%         
%         if(im2(i,j,1) - im2(i,j,2) > 0.1)
%             im1(i,j,:) = im2(i,j,:);
%         end
%         
%     end
% end
% 
% figure;
% imshow(im1);
% imwrite(im1,fullfile('output',[example '_diffinput.jpg']),'quality',100);