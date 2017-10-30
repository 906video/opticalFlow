
datadir = fullfile( fileparts( mfilename( 'fullpath' ) ), 'Data' );

total_shift = zeros(100,1);
for i = 2:100
    [~,~, estimatedImage] = demoflow('bird', i);
    
    filename1 = fullfile( datadir, sprintf( '%s%04d.jpg', 'bird', i-1) );
    image = im2double(imread(filename1));
    
    total_shift(i) = compare( image, estimatedImage);
end

avg_shift = mean( total_shift(2:100) );


% filename = fullfile( datadir, sprintf( '%s%04d.jpg', 'bird', 1) );
% image = im2double(imread(filename));
% 
% color(image);

