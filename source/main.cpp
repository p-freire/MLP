/*======================================================================
 * 				Trabalho de Introdução às Redes Neurais
 * Implementação de uma Rede Multi-Layer Perceptron (MLP)
 *
 * Autores:
 * 			Amandia Sa
 * 			Bruno Gregorio
 * 			Paulo Freire
 *
 * Versão: 1.0
 * Data: 17/06/2016
 * =====================================================================
 */

#include <stdio.h>
#include "MLP.h"
#include "Neuron.h"
#include "Vector.h"
#include "String.h"

//
// Main
//
int main(int argc, char **argv)
{
	if(argc != 8)
	{
		printf("Usage:\n");
		printf("%s  nInput nHidden  nOutput  testFile  trainFile  learning_rate  tolerance\n", argv[0]);
		return -1;
	}

	// Lendo os parâmetros de entrada do algoritmo
	int ill = atoi( argv[1] );
	int hll = atoi( argv[2] );
	int oll = atoi( argv[3] );
	String *testFile  = new String( argv[4] );
	String *trainFile = new String( argv[5] );
	double eta        = atof( argv[6] );
	double tolerance  = atof( argv[7] );

	MLP *mlp = new MLP(ill, hll, oll, testFile, trainFile, eta, tolerance);
	mlp->train();   // treinando primeiro
	mlp->forward(); // rodando a rede MLP

	return 0;
}
