# the first table

|             | N    | A\b                       | inv(A)*b                  |
|-------------|------|---------------------------|---------------------------|
| eiffel1.mat | 522  | 1.4606e-04 s = 146.06 µs  | 2.7411e-04 s = 274.41 µs  |
| eiffel2.mat | 798  | 4.6401e-04 s = 464.01 µs  | 0.0010 s = 1&nbsp;000 µs  |
| eiffel3.mat | 1122 | 0.0012 s = 1&nbsp;200 µs  | 0.0025 s = 2&nbsp;500 µs  |
| eiffel4.mat | 3184 | 0.0182 s = 18&nbsp;200 µs | 0.0444 s = 44&nbsp;400 µs |

# the second table

|             | Naiv         | LU          | Gles (ej LU) | Gles+LU    |
|-------------|--------------|-------------|--------------|------------|
| eiffel1.mat | 0.923002 s   | 0.304206 s  | 0.387095 s   | 0.037957 s |
| eiffel2.mat | 3.829454 s   | 0.902456 s  | 0.864064 s   | 0.073596 s |
| eiffel3.mat | 13.369861 s  | 2.235284 s  | 1.887173 s   | 0.168804 s |
| eiffel4.mat | 610.932927 s | 46.692336 s | 18.021481 s  | 2.161482 s |

*Varför går det snabbare att lösa problemet med LU-faktorisering? - för det är O(n<sup>3</sup>) istället för O(n<sup>4</sup>)
*Vilken metod löser problemet snabbast? (Med/utan LU? Full/gles lösare?) - LU+gles
*För vilken modell blir tidsvinsten störst? Varför? - den största, eftersom n<sup>3</sup> ökar mycket långsammare än n<sup>4</sup>