//check for correctness
	float eps = find_eps();
	
	int worked = 0;
	for (int i = 0; i < SIZE; i++)
	{
		float rel_error = my_abs( ( (A[i] + B[i]) - C[i]) /C[i]);

		if ( rel_error > eps)
		{
			printf("messed up on index %d\n", i);
			printf("Calculation did not work\n");
			worked = 1;
			break;
		}
	}

	if (worked == 0)
		printf("Congrats, everyting worked!\n");
