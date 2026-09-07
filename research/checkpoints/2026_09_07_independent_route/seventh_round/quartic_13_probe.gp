setrand(1);
E=ellinit([0,-13,0,-507,0]);
print(["curve",[0,-13,0,-507,0],"rank",ellrank(E),"torsion",elltors(E)]);
print(["rational_points",ellratpoints(E,1000)]);
quit;
