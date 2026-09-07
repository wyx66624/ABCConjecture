\\ Bounded rational-point probe, not a complete rational-point computation.
\\ The three unit representatives are essential when g=3.
default(parisizemax, 512000000);
encode(r) = [numerator(r),denominator(r)];
pointencode(p) = [encode(p[1]),encode(p[2])];
print(["header",version(),1000,1000]);
A = x^3-3*x-1;
B = 3*x*(x+1);
{
for(u=0,2,
  P = [B*(A+B),B*(B-3*A),(A+B)*(B-3*A)];
  for(j=1,3,
    if(poldegree(gcd(P[j],deriv(P[j]))) != 0,error("singular model"));
    pts = hyperellratpoints(P[j],[1000,1000]);
    for(k=1,#pts,
      if(pts[k][2]^2 != subst(P[j],x,pts[k][1]),error("invalid returned point"))
    );
    print(["curve",u,j,Vec(P[j]),apply(pointencode,pts)]);
  );
  oldA = A;
  A = -B;
  B = oldA+B;
);
}
print(["complete",9]);
quit;
