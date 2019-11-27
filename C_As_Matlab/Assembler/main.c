#include "stdio.h"
#include "stdlib.h"
#include "math.h"

//ITERATION
int Num_it = 0;

//FUNCTIONS
double f1 (double x);
double f2 (double x);
double f3 (double x);
double f4 (double x);
double f5 (double x);
double f6 (double x);

double root (double (*pf)(double), double (*pg)(double), double, double, double);
double integral (double (*pf)(double), double, double, double);

int main (int argc, char **argv)
{
    double a1 = -10, b1 = -0.1;
    double a2 = -10, b2 = -0.1;
    double a3 = -10, b3 = -0.1;
    double e1 = 0.00002, e2 = 0.0002;
    double x1 = 0, x2 = 0, x3 = 0, y1 = 0, y2 = 0, y3 = 0, res = 0, q = 0;
    int it_1 = 0, it_2 = 0, it_3 = 0, i = 1;
    double arg_1, arg_2, arg_3;
//-------------------------------------------------------------------------------------------
    if (argc > 1)
    {
        while (i < argc)
        {
            if (!strcmp (argv [i], "-help"))
            {
                printf("\n-help  - Keys\n");
                printf("-it     - Iterations\n");
                printf("-in     - Intersection\n");
                printf("-t_r   - Test roots\n");
                printf("-t_i   - Test integrals\n");
                i++;
            }
//-------------------------------------------------------------------------------------------
            else if (!strcmp (argv [i], "-in"))//POINTS OF INTERSECTION
            {
                x1 = root (f1, f2, a1, b1, e1);
                x2 = root (f1, f3, a2, b2, e1);
                x3 = root (f2, f3, a3, b3, e1);

                printf ("Intersection:\n");
                printf ("f1 and f2: %lf\n", x1);
                printf ("f1 and f3: %lf\n", x2);
                printf ("f2 and f3: %lf\n", x3);
                i++;
            }
//-------------------------------------------------------------------------------------------
            else if (!strcmp (argv [i], "-t_i"))//INTEGRAL TESTING
            {
                arg_1 = atof (argv [i + 2]);
                arg_2 = atof (argv [i + 3]);
                arg_3 = atof (argv [i + 4]);

                printf ("Integral testing:\n");
                if (!strcmp (argv [i + 1], "f4")) q = integral (f4, arg_1, arg_2, arg_3);

                if (!strcmp (argv [i + 1], "f5")) q = integral (f5, arg_1, arg_2, arg_3);

                if (!strcmp (argv [i + 1], "f6")) q = integral (f6, arg_1, arg_2, arg_3);

                printf("Result: %lf\n", q);
                i += 6;
            }
//-------------------------------------------------------------------------------------------
            else if (!strcmp (argv[i], "-it"))//NUMBER OF ITERATIONS
            {
                x1 = root(f1, f3, a1, b1, e1);
                it_1 = Num_it;
                Num_it = 0;

                x2 = root(f2, f3, a2, b2, e1);
                it_2 = Num_it;
                Num_it = 0;

                x3 = root(f1, f2, a3, b3, e1);
                it_3 = Num_it;
                Num_it = 0;

                printf ("Iterations:\n");
                printf("f1 and f3: %d\n", it_1);
                printf("f2 and f3: %d\n", it_2);
                printf("f1 and f2: %d\n", it_3);
                i++;
            }
//-------------------------------------------------------------------------------------------
            else if (!strcmp (argv [i], "-t_r"))//ROOT TESTING
            {
                arg_1 = atof (argv [i + 3]);
                arg_2 = atof (argv [i + 4]);
                arg_3 = atof (argv [i + 5]);

                printf ("Root testing:\n");
                if ((!strcmp (argv [i + 1], "f4") && !strcmp (argv [i + 2], "f5")) || (!strcmp (argv [i + 1], "f5") && !strcmp (argv [i + 2], "f4")))
                    q = root (f4, f5, arg_1, arg_2, arg_3);

                if ((!strcmp (argv [i + 1], "f4") && !strcmp (argv [i + 2], "f6")) || (!strcmp (argv [i + 1], "f6") && !strcmp (argv [i + 2], "f4")))
                    q = root (f4, f6, arg_1, arg_2, arg_3);

                if ((!strcmp (argv [i + 1], "f5") && !strcmp (argv [i + 2], "f6")) || (!strcmp (argv [i + 1], "f6") && !strcmp (argv [i + 2], "f5")))
                    q = root (f5, f6, arg_1, arg_2, arg_3);

                printf("Result: %lf\n", q);
                i += 6;
            }
        }
    }
//-------------------------------------------------------------------------------------------
    x1 = root (&f1, &f2, a1, b1, e1);
    x2 = root (&f1, &f3, a2, b2, e1);
    x3 = root (&f2, &f3, a3, b3, e1);

    y1 = integral (f1, x1, x2, e2);
    y2 = integral (f2, x1, x3, e2);
    y3 = integral (f3, x2, x3, e2);

    res = y1 - y2 - y3;

    printf ("\nArea: %lf\n", res);

    return 0;
}

//ROOT FUNCTION
double root (double (*pf)(double), double (*pg)(double), double a, double b, double e)
{
    double x, z;
    while (fabs (b - a) > e)
    {
        x = pf (a) - pg (a);
        if (x <= 0)
        {
            z = pf ((a + b) / 2) - pg ((a + b) / 2);

            if (z > 0) b = (a + b) / 2;
            else if (z < 0) a = (a + b) / 2;
            else break;
        }
        else
        {
            z = pf ((a + b) / 2) - pg ((a + b) / 2);

            if (z < 0) b = (a + b) / 2;
            else if (z > 0) a = (a + b) / 2;
            else break;
        }
        Num_it += 3;

    }
    return (a + b) / 2;
}

//INTEGRAL FUNCTION
double integral (double (*pf)(double), double a, double b, double e)
{
    double h, dif = e + 1, i1 = 0, i2 = 0, n = 8;
    int i;

    if (a > b)
    {
        double t = a;
        a = b;
        b = t;
    }

    h = (b - a) / n;
    i1 = pf (a) + pf (b);
    i = 1;
    while (i < n / 2)
    {
        i1 += 2 * pf (a + 2 * h * i) + 4 * pf (a + 2 * h * i + h);
        i++;
    }
    i1 += 4 * pf (a + h);
    i1 *= h / 3;

    while (dif > e)
    {
        n *= 2;

        h = (b - a) / n;
        i2 = pf (a) + pf (b);
        i = 1;
        while (i < n / 2)
        {
            i2 += 2 * pf (a + 2 * h * i) + 4 * pf (a + 2 * h * i + h);
            i++;
        }
        i2 += 4 * pf (a + h);
        i2 *= h / 3;

        dif = abs (i2 - i1);
        i1 = i2;
    }

    return i2;

}























