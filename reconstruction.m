function reconstruction()
    example = 'bird';
%     num = 20;

% RotationMatrice = zeros(3,3,num);
% TranslationMatrice = zeros(3,1,num);

%     RotationMatrice(:,:,1) = [1, 0, 0; 0, 1, 0; 0, 0, 1];
%     TranslationMatrice(:,:,1) = [0, 0, 0]';

%     unit_length = 1;

datadir = fullfile( fileparts( mfilename( 'fullpath' ) ), 'Data' );
% for i = 1:num
    i = 3;
    [vx,vy] = demoflow(example, i);
    
    filename = fullfile( datadir, sprintf( '%s%04d.jpg', example, i) );
    image = im2double(imread(filename));
    
    [R, T] = getRotTrans(vx, vy, image);
    
%     RotationMatrice(:,:,i) = R;
%     TranslationMatrice(:,:,i) = T';
% end

% dataDir = fullfile( fileparts( mfilename( 'fullpath' ) ), 'Noise' );
% filename_pos = fullfile( dataDir, 'Pos.txt' );
% fid_pos = fopen(filename_pos, 'w');
% 
% for i = 1:num
%     fprintf(fid_pos, '%d\n%f\n%f\n%f\n', i,...
%             TranslationMatrice(1,1,i),...
%             TranslationMatrice(2,1,i),...
%             TranslationMatrice(3,1,i));
% end
% fclose(fid_pos);
% 
% 
% filename_rot = fullfile( dataDir, 'Rot.txt' );
% fid_rot = fopen(filename_rot, 'w');
% for i = 1:num
%     fprintf(fid_rot, '%d\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n',...
%             i,...
%             RotationMatrice(1,1,i), RotationMatrice(1,2,i), RotationMatrice(1,3,i),...
%             RotationMatrice(2,1,i), RotationMatrice(2,2,i), RotationMatrice(2,3,i),...
%             RotationMatrice(3,1,i), RotationMatrice(3,2,i), RotationMatrice(3,3,i));
% end
% fclose(fid_rot);
end

function [R, T] = getRotTrans(vx, vy, image)
    
    s = warning('error', 'MATLAB:nearlySingularMatrix');
    warning('error', 'MATLAB:DELETE:FileNotFound');
    
    try
        [R, T] = RotPosCal(vx, vy, image);
    catch 
        [R, T] = getRotTrans(vx, vy, image);
    end
    
    warning(s);
end