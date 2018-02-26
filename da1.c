//USING BOBBY NOT ATMEL
#include<iostream>
#include<stdio.h>
#include<cmath>

using namespace std;

int main()
{
  int num=36;
  int divisible=0;
  int nondivisible=0;

  int ten=1;

  printf("Divisible: \n");
  for (int i=0; i<300; i++)
    {
      if(num > 255)
	num = 0;

      if(num%5 == 0)
	{
	  printf("%X ",num);
	  divisible+=num;
	  
	  if ((ten % 10) == 0)
	    printf("\n");
	  
	  ten++;
	}
      num+=2;
    }

  printf("\n");
  ten = 1;
  num=36;

  printf("Not Divisible: \n");
  for (int i=0; i<300; i++)
    {
      if(num > 255)
        num = 0;

      if(num%5 != 0)
        {
          printf("%X ",num);
          nondivisible+=num;

          if ((ten % 10) == 0)
            printf("\n");

          ten++;
        }
      num+=2;
    }

  printf("\n");
  printf("SUM of divisible: %i\n",divisible);
  printf("SUM of non-divisible: %i\n", nondivisible);

  return 0;
}
