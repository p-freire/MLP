/*======================================================================
 * Classe para a criação e manipulação dos neurônios da rede.
 *
 * Autores:
 * 			Amandia Sá
 * 			Bruno Gregório
 * 			Paulo Freire
 *
 * Versão: 1.0
 * Data: 17/06/2016
 * =====================================================================
 */

#ifndef _NEURON_H_
#define _NEURON_H_

#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <time.h>
#include "Vector.h"

//**********************************************************************
// 							Classe Neuron
//**********************************************************************
class Neuron
{
	private:
			Vector<double> *weights;

	public:
			// Construtor
			Neuron(int nweights)
			{
				weights = new Vector<double>();

				// Inicializa os pesos com valores aleatórios
				srand(time(NULL));
				for(int i = 0; i < nweights; i++)
				{
					weights->add( rand() / (RAND_MAX * 1.0) );
				}
			}

			// Destrutor
			~Neuron()
			{
				delete weights;
			}

			// Setters
			void setWeights(Vector<double> *inweights) { weights = inweights; }

			// Getters
			Vector<double> *getWeights() { return weights; }
			double getWeight(int pos) { return weights->get(pos); }

			/* Pré-Condição: recebe um double com o valor do potencial de ativação (net)
			   Pós-Condição: calcula a função de ativação (sigmóide) */
			double activationFunction(double net)
			{
				return (  1.0 / ( 1.0 + exp(-net) )  );
			}

			/* Pré-Condição: recebe um vetor com os dados de entrada da rede
			   Pós-Condição: retorna o potencial de ativação (net) */
			double net(Vector<double> *input)
			{
				double sum = 1.0 * weights->get(0); // bias
				for(int i = 1; i < weights->getSize(); i++)
				{
					// somatório (x * w)
					sum += input->get(i - 1) * weights->get(i);
				}
				return sum;
			}

			/* Pré-Condição: recebe um vetor com os dados de entrada da rede
			   Pós-Condição: calcula o potencial de ativação e chama a função de ativação */
			double execute(Vector<double> *input)
			{
				return activationFunction( net(input) );
			}
};

#endif
