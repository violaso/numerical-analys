### SF1547 | Laboration 2.1

#### Nonlinear Model Fitting

1) > Unlike Newton's method, the Gauss–Newton algorithm can only be used to minimize a sum of squared function values, but it has the advantage that second derivatives, which can be challenging to compute, are not required.
    
    Newton's method finds the solution to a problem, whereas Guass-Newton finds the value closest to a solution. Since there's no single point where the three circles intersect, we use Gauss-Newton.

2) **Result**:
   - `P1: x0 = [ 40; 45 ]`
   - `P1: iterations_count = 12`
   - `P1 = [ 42.4134; 42.8719 ]`
   - `P2: x0 = [ 51; 21 ]`
   - `P2: iterations_count = 13`
   - `P2 = [ 42.4134; 42.8719 ]`
3)  The circles doesn't tangent the points for the same reason we use Gauss-Newton; we know that a point of intersection doesn't exist. Since convergence is not guaranteed, either the two points intersects or we get a false result. If both points are positioned within the area where the three circles overlap, we have a solution.

#### Numerical Integration

1) **Integral value**: `I = 2.797434948471088`
2) The trapezoidal of `h` seems to converge as `h -> 0` towards the value `I`.
   | _h_ | _T(h)_ | _E(h)_ |
   |-----|--------|--------|
   | 1.000000000000000 | 2.780238966157534 | 0.017195982313555 |
   | 0.500000000000000 | 2.793061333816656 | 0.004373614654432 |
   | 0.250000000000000 | 2.796336176773301 | 0.001098771697788 |
   | 0.125000000000000 | 2.797159904478355 | 0.000275043992733 |
   | 0.062500000000000 | 2.797366165255859 | 0.000068783215229 |
3) We expect the trapezoidal function to have an error of quadratic complexity `O(h^2)`. See figure.
4) Theoretically, the simpson function should have an error of quartic complexity `O(h^4)`.
   | _h_ | _S(h)_ | _E(h)_ |
   |-----|--------|--------|
   | 1.000000000000000 | 2.796301685687086 | 0.001133262784002 |
   | 0.500000000000000 | 2.797335456369697 | 0.000099492101392 |
   | 0.250000000000000 | 2.797427791092182 | 0.000007157378906 |
   | 0.125000000000000 | 2.797434480380040 | 0.000000468091048 |
   | 0.062500000000000 | 2.797434918848359 | 0.000000029622730 |
5) The figure shows that the implementations of the trapezoidal function and the simpson function is converging according to theory.

#### Generator 2

1) **Denominator**: `D = 1.764162781524843`
2) Trapezoidal takes 58.422501 seconds with `h = 70`.
   - _Nominator_: `N = 1.854947280986201e+04`
   - _Maximum magnetisation_: `m = 1.051460386996085e+04`
   - _Half interval error_: `e = 0.314248608039634`
   - _Half interval execution time_: `120.092675 seconds`
3) Simpson's takes 60.233439 seconds with the same `h = 70`.
   - _Nominator_: `N = 1.854989095229734e+04`
   - _Maximum magnetisation_: `m = 1.051484089028556e+04`
   - _Half interval error_: `e = 8.557087276130915e-04`
   - _Half interval execution time_: `125.135234 seconds`
   Simpson's rule is better as it calculates with a smaller error, taking the same time as the trapzoidial rule.

#### Robot arm

1) **Theta**: `th1 = 1.190051800421080` and `th2 = 0.380744526373817`
2) See code.
3) **Theta after 15 t.u.**: `(1.193094088523645, 0.303998255557669)`
   **Arm after 15 t.u.**: `(1.32293, 1.22885)`