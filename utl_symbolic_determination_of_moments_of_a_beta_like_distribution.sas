Symbolic determination of moments of a beta like distribution

I was gven the density below and was asked to compute the first
three moments. Mean, Stdev and Skewness


INPUT
=====

                 (  x**2  ( 1 - x**2 ) ) **2
  PDF(x)  = 105 * -----------------------------
                            8

  CDF(x) =  15*x**7/8 - 21*x**5/4 + 35*x**3/8

  Area under the PDF is 1
  CDF(0)  =  0
  CDF(1)  =  15/8  - 21/4  + 35/8  = (15 - 42 + 35)/8  = 1


  EXAMPLE OUTPUT

  I thought I would take the succesive derivatives of the moment generating function to calcualte the the formulas for the moments
  but the MGF was quite complex so I decided to just integrate to get standard moments.

  Moments of standard unit beta like distribution

                               SYMBOLIC
          1                    EXACT                 EMPERICAL CHECK
         /
  Mean   !  x * pdf(x)     =   35/64(0.546875)          0.5463287
        /
         0


          1
         /
 Stdev   !  x**2 * pdf(x)    =  1/3(0.33333)            0.3330003
        /
         0


          1
         /
 Skew    !  x**3 * pdf(x)    =  7/32(0.21875)           0.2185315
        /
         0

  Lets check the moments

   data moments;
     do x=0 to 1 by .001;
       mean= x    * (105 * (x**(2) * (1 - x**2) **(2))/8);
       std=  x**2 * (105 * (x**(2) * (1 - x**2) **(2))/8);
       skew= x**3 * (105 * (x**(2) * (1 - x**2) **(2))/8);
       drop x;
       output;
     end;
   run;quit;

   proc means data=cum mean stdev skewness;
   run;quit;

   Variable        Moments
   MEAN           0.5463287
   STD            0.3330003
   SKEW           0.2185315
   --------------------------

    |
    |            _  __
2.0 +  _ __   __| |/ _|
    | | '_ \ / _` | |_            *********
    | | |_) | (_| |  _|         ***       ***
    | | .__/ \__,_|_|         ***           **
    | |_|                    **              **
1.5 +                       **                **
    |                      **                  **
    |                     **                    **
    |                    **                      **
    |                  **                         **
1.0 +                 **                           **
    |                **                             *
    |               **                              **
    |              **                                **
    |             **                                  **
0.5 +            **      (  x**2  ( 1 - x**2 ) ) **2   *
    |          ***  105 * ---------------------------  **
    |         **                    8                   **
    |       ***                                          **
    |    ****                                             ***
0.0 + ****                                                  ***
    |
    --+-------+-------+-------+-------+-------+-------+-------+-
    0.000   0.144   0.288   0.432   0.576   0.720   0.864  1.008

                                  X

      |    15*x**7/8 - 21*x**5/4 + 35*x**3/8
      |          _  __
 1.00 +   ___ __| |/ _|                ******
      |  / __/ _` | |_              ****
      | | (_| (_| |  _|            **
      |  \___\__,_|_|             ***
      |                           **
 0.75 +                          **
      |                          **
      |                         **
      |                        **
      |                       **
 0.50 +                      **
      |                     **
      |                    **
      |                  **
      |                 **
 0.25 +                **
      |              ***
      |             **
      |           ***
      |       *****
 0.00 +********
      |
      -+---------+---------+---------+---------+-
     0.00      0.25      0.50      0.75      1.00

                           X
PROCESS
=======


%utl_submit_wps64("
options set=PYTHONHOME 'C:\Progra~1\Python~1.5\';
options set=PYTHONPATH 'C:\Progra~1\Python~1.5\lib\';
proc python;
submit;
from sympy import *;
import pandas as pd;
x, t = symbols('x t');

cdf=integrate(105 * x * (x**(2) * (1 - x**2) **(2))/8,(x));
print('CDF');
print(cdf);

mean=integrate(x * 105 * (x**(2) * (1 - x**2) **(2))/8,(x,0,1));
print('MEAN');
print(mean);

stdev=integrate(x**2 * 105 * (x**(2) * (1 - x**2) **(2))/8,(x,0,1));
print('STDEV');
print(stdev);

skewness=integrate(x**3 * 105 * (x**(2) * (1 - x**2) **(2))/8,(x,0,1));
print('SKEWNESS');
print(skewness);

endsubmit;
run;quit;
");

/*

  CDF        105*x**8/64 - 35*x**6/8 + 105*x**4/32

  MEAN       35/64

  STDEV      1/3

  SKEWNESS   7/32

*/

OUTPUT
======

  CDF        105*x**8/64 - 35*x**6/8 + 105*x**4/32

  MEAN       35/64
  STDEV      1/3
  SKEWNESS   7/32


*                _              _       _
 _ __ ___   __ _| | _____    __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \  / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/ | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|  \__,_|\__,_|\__\__,_|

;


                 (  x**2  ( 1 - x**2 ) ) **2
  PDF(x)  = 105 * -----------------------------
                            8


  PDF(X)  = 105 * x * (x**(2) * (1 - x**2) **(2))/8,(x))

*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;


%utl_submit_wps64("
options set=PYTHONHOME 'C:\Progra~1\Python~1.5\';
options set=PYTHONPATH 'C:\Progra~1\Python~1.5\lib\';
proc python;
submit;
from sympy import *;
import pandas as pd;
x, t = symbols('x t');

cdf=integrate(105 * x * (x**(2) * (1 - x**2) **(2))/8,(x));
print('CDF');
print(cdf);

mean=integrate(x * 105 * (x**(2) * (1 - x**2) **(2))/8,(x,0,1));
print('MEAN');
print(mean);

stdev=integrate(x**2 * 105 * (x**(2) * (1 - x**2) **(2))/8,(x,0,1));
print('STDEV');
print(stdev);

skewness=integrate(x**3 * 105 * (x**(2) * (1 - x**2) **(2))/8,(x,0,1));
print('SKEWNESS');
print(skewness);

endsubmit;
run;quit;
");


data moments;
  do x=0 to 1 by .001;
    mean= x    * (105 * (x**(2) * (1 - x**2) **(2))/8);
    std=  x**2 * (105 * (x**(2) * (1 - x**2) **(2))/8);
    skew= x**3 * (105 * (x**(2) * (1 - x**2) **(2))/8);
    drop x;
    output;
  end;
run;quit;



%utl_submit_wps64("
options set=PYTHONHOME 'C:\Progra~1\Python~1.5\';
options set=PYTHONPATH 'C:\Progra~1\Python~1.5\lib\';
proc python;
submit;
from sympy import *;
import pandas as pd;
x, t = symbols('x t');

cdf=integrate(exp(tx) * 105 * x * (x**(2) * (1 - x**2) **(2))/8,(x));
print('CDF');
print(cdf);

mean=integrate(x * 105 * (x**(2) * (1 - x**2) **(2))/8,(x,0,1));
print('MEAN');
print(mean);

stdev=integrate(x**2 * 105 * (x**(2) * (1 - x**2) **(2))/8,(x,0,1));
print('STDEV');
print(stdev);

skewness=integrate(x**3 * 105 * (x**(2) * (1 - x**2) **(2))/8,(x,0,1));
print('SKEWNESS');
print(skewness);

endsubmit;
run;quit;
");


