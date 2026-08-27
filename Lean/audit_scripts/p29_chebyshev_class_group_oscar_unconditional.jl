using Oscar

println("JULIA_VERSION=", VERSION)
println("OSCAR_PKG_VERSION=", pkgversion(Oscar))
println("HECKE_PKG_VERSION=", pkgversion(Hecke))
println("NEMO_PKG_VERSION=", pkgversion(Nemo))
flush(stdout)

set_verbosity_level(:ClassGroup, 1)
set_verbosity_level(:ClassGroupProof, 1)
set_verbosity_level(:UnitGroup, 1)

Qx, x = polynomial_ring(QQ, "x")
K, a = number_field(x^29 - 2, "a")
O = maximal_order(K)
println("MAXIMAL_ORDER_DISCRIMINANT=", discriminant(O))
println("EXPECTED_DISCRIMINANT=", big(2)^28 * big(29)^29)
@assert discriminant(O) == big(2)^28 * big(29)^29
flush(stdout)

println("CLASS_GROUP_CALL=class_group(O; GRH=false, redo=true)")
flush(stdout)
C, mC = class_group(O; GRH=false, redo=true)
println("CLASS_GROUP=", C)
println("CLASS_GROUP_ORDER=", order(C))
println("CLASS_GROUP_INVARIANTS=", elementary_divisors(C))
@assert order(C) == 1
println("UNCONDITIONAL_CLASS_GROUP_CERTIFIED=true")
flush(stdout)
