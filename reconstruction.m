example = 'bird';
[vx,vy] = demoflow(example);

essentialMatrix = essentialMatrix(vx,vy);

R = RotPosCal(essentialMatrix)