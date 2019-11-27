#include <stdio.h>
#include <stdlib.h>
#include <math.h>

//Ubuntu 14.04
/*
Решение системы линейных алгебраических уравнений
методом Гаусса с выбором главного элемента и без
Предусмотрен ввод матрицы из файла
*/

void m_print (double **matr, int len, double *right);
void str_ch (double **matr, int len, int a, int b);
void matr_trian (double **matr, int len, double *right, double **matr_rev, int flag);
void m_get (double **matr, int a, int b);
void r_get (double *right, int i, double x);
int search_v (double **matr, int len, int counter, int start);
int search_n (double **matr, int len, int counter, int start);

int main (void)
{
    FILE *f = fopen ("in.txt", "r");
    FILE *g = fopen ("out.txt", "w");
    int n, flag1, flag2, x;

    //Ввод параметров && Создание матрицы
    printf ("0-without the main element \n1-with the main element \nFlag_1 == ");
    scanf ("%d", &flag1);
    printf ("0-input from file\n1-generation by initial number\nFlag_2 == ");
    scanf ("%d", &flag2);

    if (flag2 == 1) {
        printf ("Enter dimension and seed:\n");
        scanf ("%d %d", &n, &x);
    } else {
        fscanf (f, "%d", &n);
    }

    double **matr = (double**) malloc (n * sizeof (double*));
    for (int i = 0; i < n; i++) {
            matr [i] = (double*) malloc (n * sizeof (double));
        }
    double **matr_rev = (double**) malloc (n * sizeof (double*));
    double *right = (double*) malloc (n * sizeof (double));

    if (flag2 == 1) {
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                m_get (matr, i, j);
            }
        }
        for (int i = 0; i < n; i++) {
            r_get (right, i, x);
        }
        for (int i = 0; i < n; i++) {
            matr_rev [i] = calloc (n, sizeof (matr_rev));
            matr_rev [i][i] = 1;
        }
    } else {
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                fscanf (f, "%lf", &matr [i][j]);
            }
        }
        for (int i = 0; i < n; i++) {
            matr_rev [i] = calloc (n, sizeof (matr_rev));
            matr_rev [i][i] = 1.0;
        }
        for (int i = 0; i < n; i++) {
            fscanf (f, "%lf", &right [i]);
        }
    }
    printf("\nMatrix unput - DONE\n");

    //Вывод матрицы до начала преобразований
    printf ("\nMatrix before process: \n");
    m_print (matr, n, right);

    //Решение системы с помощью метода Гаусса
    matr_trian (matr, n, right, matr_rev, flag1);
    printf("Solving - DONE\n");

    int flag3 = 0;
    for (int i = 0; i < n; i++) {
        if (matr [i][i] == 0) {
            flag3 = 1;
        }
    }
    if (flag3 == 0) {
        //Вывод обратной матрицы
        printf ("\nRev matrix:\n");
        m_print (matr_rev, n, right);
        double det = 1;
        for (int i = 0; i < n; i++) {
            det *= matr [i][i];
        }
        //Вывод определителя
        printf ("\nDeterminant = %.10g\n\nSolution:\n", det);
        for (int i = 1; i <= n; i++) {
            right [i - 1] /= matr [i - 1][i - 1];
            if (right [i - 1] == -0) {
                right [i - 1] = 0;
            }
            printf ("x%d = %.10g\n", i, right [i - 1]);
            //fprintf (g, "%lf ", right [i - 1]);
        }
    } else {
        printf ("Error: Degen matrix");
    }
    printf("\nSolution output - DONE\n");
    //printf("\n%p\n", matr[1]);            Лажа!!!
    //Освобождение памяти
    for (int k = 0; k < n; k++) {
        free (matr [k]);
        free (matr_rev [k]);
    }
    printf("---------");
    free (matr);
    free (matr_rev);
    free (right);
    fclose (f);
    fclose (g);
    printf("\nMem free - DONE\n");
    return 0;
}

void str_ch (double **matr, int len, int a, int b)
{
    //Функция меняет строки местами
    for (int i = 0; i < len; i++) {
        double t = matr [a][i];
        matr [a][i] = matr [b][i];
        matr [b][i] = t;
    }
}

void matr_trian (double **matr, int len, double *right, double **matr_rev, int flag)
{
    //Решение методом Гаусса
    for (int i1 = 0, i2 = 0; i1 < len && i2 < len; i1++, i2++) {
        int max;
        if (flag == 0) {
            max = search_n (matr, len, i2, i1);
        } else {
            max = search_v (matr, len, i2, i1);
        }
        if (max == -1) return;
        str_ch (matr, len, max, i1);
        str_ch (matr_rev, len, max, i1);

        double t = right [max];
        right [max] = right [i1];
        right [i1] = t;
        //Приводим к верхнему треугольному виду
        for (int j = i1 + 1; j < len; j++) {
            if (matr [i1][i2] != 0) {
                double a = matr [j][i2] / matr [i1][i2];
                for (int k = i2; k < len; k++) {
                    matr [j][k] -= matr [i1][k] * a;
                }
                for (int k = 0; k < len; k++) {
                    matr_rev [j][k] -= matr_rev [i1][k] * a;
                }
                right [j] -= right [i1] * a;
            } else {
                i1--;
            }
        }
    }
    //Проверка на вырожденность
    for (int a = 0; a < len; a++) {
        if (matr [a][a] == 0) {
            return;
        }
    }
    //Приведение к диагональному виду
    for (int i = len - 1; i >= 0; i--) {
        for (int j = i - 1; j >= 0; j--) {
            right [j] -= right [i] * matr [j][i] / matr [i][i];
            for (int k = len - 1; k >= 0; k--) {
                matr_rev [j][k] -= matr_rev [i][k] * matr [j][i] / matr [i][i];
            }
            matr [j][i] = 0;
        }
    }
    for (int i = 0; i < len; i++) {
        for (int j = 0; j < len; j++) {
            matr_rev [i][j] /= matr [i][i];
        }
    }
}

void m_print (double **matr, int len, double *right)
{
    for (int i = 0; i < len; i++) {
        for (int j = 0; j < len; j++) {
            if (matr [i][j] == -0) {
                matr [i][j] = 0;
            }
            printf ("%.10g ", matr [i][j]);
        }
        printf ("| %.10g\n", right [i]);
    }
}

int search_v (double **matr, int len, int counter, int start)
{
    //С выбором главного элемента
    double max = matr [start][counter];
    int res = start;
    for (int i = start; i < len; i++) {
        if (abs (matr [i][counter]) > abs (max)) {
            res = i;
            max = matr [i][counter];
        }
    }
    return res;
}

int search_n (double **matr, int len, int counter, int start)
{
    //Без выбора главного элемента
    int i = 0;
    for (i = start; i < len && matr [i][counter] == 0; i++) {
        if (i + 1 == len) {
            return -1;
        }
    }
    return i;
}

void m_get (double **matr, int a, int b)
{
    //Ввод матрицы с помощью специальной формулы
    printf ("%d %d\n", a, b);
    double q = 1.001 - 2 * 0.001 * 6;
    if (a == b) {
        q -= 1.0;
        for (int i = 0, j = q; i < a + b; i++, q *= j);
        matr [a][b] = q;
        return;
    } else {
        for (int i = 0, j = q; i < a + b; i++, q *= j);
        q += 0.1 * (b - a);
        matr [a][b] = q;
        return;
    }
}

void r_get (double *right, int i, double x)
{
    //Ввод значений правой части с помощью специальной формулы
    printf ("%d\n", i);
    right [i] = x;// * exp (x / (i + 1)) * cos (x / (i + 1));
    return;
}
