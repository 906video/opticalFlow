example = 'box';
[vx,vy] = demoflow(example);

[R, T] = RotPosCal(vx, vy);

fprintf( 'Rot:\n');
R
fprintf( 'Translation:\n');
T