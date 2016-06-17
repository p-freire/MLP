/*======================================================================
 * Implementacao de uma rede Multi-Layer Perceptron usando o algoritmo
 * Back-propagation.
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

#ifndef _MLP_H_
#define _MLP_H_

#include <stdio.h>
#include <time.h>
#include <math.h>
#include "Neuron.h"
#include "Vector.h"
#include "String.h"

//**********************************************************************
// 							Classe MLP
//**********************************************************************
class MLP
{
	private:
			int inputLayerLength;
			Vector<Neuron*> *hiddenLayer;
			Vector<Neuron*> *outputLayer;
			String *testFile;
			String *trainFile;
			double eta;
			double tolerance;

	public:
			// Construtor
			MLP (int inputLayerLength,	// tamanho da camada de entrada
				 int hiddenLayerLength, // tamanho da camada escondida
				 int outputLayerLength, // tamanho da camada de saída
				 String *testFile, 		// nome do arquivo de testes
				 String *trainFile, 	// nome do arquivo de treinamento
				 double eta, 			// valor da taxa de aprendizado
				 double tolerance )		// erro de tolerância
			{

				this->inputLayerLength  = inputLayerLength;
				this->testFile 			= testFile;
				this->trainFile 		= trainFile;
				this->eta 				= eta;
				this->tolerance 		= tolerance;

				// Criando os neurônios da camada escondida
				this->hiddenLayer = new Vector<Neuron*>();
				for (int i = 0; i < hiddenLayerLength; i++) {
					this->hiddenLayer->add( new Neuron(inputLayerLength + 1) ); // +1 pro bias
				}

				// Criando os neurônios da camada de saída
				this->outputLayer = new Vector<Neuron*>();
				for (int i = 0; i < outputLayerLength; i++) {
					this->outputLayer->add( new Neuron(hiddenLayerLength + 1) ); // +1 pro bias
				}
			}

			// Destrutor
			~MLP()
			{
				delete this->hiddenLayer;
				delete this->outputLayer;
			}

			//==========================================================
			// Fase forward: o sinal e os pesos são propagados através
			//        da rede, camada por camada, até a saída.
			//==========================================================
			void forward()
			{
				FILE *f;
				FILE *confusionFile;
				double weight;
				confusionFile = fopen("mat_confusao.txt", "w");

				// Faz a leitura do arquivo de teste
				if( !(f = fopen(this->testFile->toCharArray(),"rt")) )
				{
					printf("Erro na leitura do arquivo de teste!\n");
					return;
				}

				// Criando a matriz de confusão
				int N = int( pow(2.0, this->outputLayer->getSize()));
				Vector<int> *confusionMatrix = new Vector<int>(N*N);

				while ( !feof(f) )
				{

					// Lendo os parâmetros que serão utilizados como entrada da MLP
					Vector<double> *input = new Vector<double>( this->inputLayerLength );

					int outf = 0;
					for (int i = 0; i < this->inputLayerLength; i++)
					{
						outf = fscanf(f, "%lf", &weight);
						if(outf >= 0)
						{
							input->set(i, weight);
						}
					}

					// Testando final de arquivo (EOF)
					if(outf < 0)
						break;

					// Lendo a classe esperada da entrada para a matriz de confusão
					Vector<int> *y_expected = new Vector<int>();

					int aux;
					for (int i = 0;	i < this->outputLayer->getSize(); i++)
					{
						outf = fscanf(f, "%d", &aux);
						if(outf >= 0)
						{
							y_expected->add(aux);
						}
					}

					// Aplicando as entrada na MLP
					Vector<double> *hidden2outputLayer = new Vector<double>( this->hiddenLayer->getSize() );

					for (int i = 0; i < this->hiddenLayer->getSize(); i++)
					{
						Neuron *neuron = this->hiddenLayer->get(i);
						hidden2outputLayer->set(i, neuron->execute(input) );
					}

					// Aplicando o resultado da camada escondida na camada de saída
					Vector<double> *output = new Vector<double>( this->outputLayer->getSize() );

					for (int i = 0; i < this->outputLayer->getSize(); i++)
					{
						Neuron *neuron = this->outputLayer->get(i);
						output->set(i, neuron->execute(hidden2outputLayer) );
					}

					// Preenchendo a matriz de confusão
					int intOutput = output->binaryToInt();
					int intYexpec = y_expected->binaryToInt();
					confusionMatrix->set((intYexpec * N + intOutput), (confusionMatrix->get(intYexpec * N + intOutput) + 1));

					// Liberando memória
					delete input;
					delete y_expected;
					delete hidden2outputLayer;
					delete output;
				}

				// Imprimindo a matriz de confusão
				printf("\n----------------------------------\n\tMATRIZ DE CONFUSAO\n----------------------------------\n");
				fprintf(confusionFile, "\n----------------------------------\n\tMATRIZ DE CONFUSAO\n----------------------------------\n");
				for(unsigned int i=0; i<N; i++) {
					for(unsigned int j=0; j<N; j++)
					{
						printf("%d ", confusionMatrix->get(i*N+j) );
						fprintf(confusionFile, "%d ", confusionMatrix->get(i*N+j) );
					}
					printf("\n");
					fprintf(confusionFile, "\n");
				}
				fclose(confusionFile);
			}

			//==========================================================
			// Fase de treinamento: algoritmo do back-propagation, um
			// sinal de erro é produzido comparando a saída desejada com
			// a obtida. O erro é propagado através da rede.
			//==========================================================
			void train()
			{
				double total_error, prev_error = 9999999.0;
				double alpha = 1.0;
				int temp = 0;
				double aux;
				int counter = 0;
				FILE *weightsFile;
				weightsFile = fopen("pesos_finais.txt", "w");

				do
				{
					total_error = 0.0;
					FILE *f;

					// Lendo o arquivo de treinamento
					if( !(f = fopen(this->trainFile->toCharArray(),"rt")) )
					{
						printf("Erro na leitura do arquivo de teste!\n");
						return;
					}

					while ( !feof(f) )
					{

						// Lendo os parâmetros que serão utilizados como entrada da MLP
						Vector<double> *input = new Vector<double>();

						int outf = 0;
						for (int i = 0; i < this->inputLayerLength; i++)
						{
							outf = fscanf(f, "%lf", &aux);
							if(outf >= 0)
							{
								input->add(aux);
							}
						}

						// Testando final de arquivo (EOF)
						if(outf < 0)
							break;

						// Lendo o valor esperado dos dados de entrada
						Vector<double> *y_expected = new Vector<double>();

						for (int i = 0;	i < this->outputLayer->getSize(); i++)
						{
							outf = fscanf(f, "%lf", &aux);
							if(outf >= 0)
							{
								y_expected->add(aux);
							}
						}

						// Aplicando as entradas na MLP
						Vector<double> *hidden2outputLayer = new Vector<double>();

						for (int i = 0; i < this->hiddenLayer->getSize(); i++)
						{
							Neuron *neuron = this->hiddenLayer->get(i);
							hidden2outputLayer->add( neuron->execute(input) );
						}

						// Aplicando o resultado da camada escondida na camada de saída
						Vector<double> *output = new Vector<double>();

						for (int i = 0; i < this->outputLayer->getSize(); i++)
						{
							Neuron *neuron = this->outputLayer->get(i);
							output->add( neuron->execute( hidden2outputLayer ) );
						}

						// Calculando o delta da camada de saída (regra delta generalizada)
						Vector<double> *delta_o = new Vector<double>();

						for (int i = 0; i < this->outputLayer->getSize(); i++)
						{
							double error = y_expected->get(i) - output->get(i);					// sinal de erro
							double derivative = output->get(i) * ( 1.0 - output->get(i) );		// derivada da net

							delta_o->add( error * derivative );									// delta da camada de saída
							total_error += pow(error, 2.0);										// erro acumulado
						}

						// Calculando o delta da camada escondida (regra delta generalizada)
						Vector<double> *delta_h = new Vector<double>();

						for (int i = 0;	i < this->hiddenLayer->getSize(); i++)
						{
							double sum = 0.0;
							for (int j = 0; j < this->outputLayer->getSize(); j++)
							{
								Neuron *neuron = this->outputLayer->get(j);
								Vector<double> *weights = neuron->getWeights();

								// Somatório (delta_saída * pesos_saída)
								sum += delta_o->get(j) * weights->get(i);
							}

							// Delta_escondida = somatório(delta_saída * pesos_saída) * derivada_net-escondida
							delta_h->add( sum * hidden2outputLayer->get(i) * (1.0 - hidden2outputLayer->get(i)) );
						}

					   // Atualizando os pesos da camada de saída
					   for (int i=0; i < this->outputLayer->getSize();i++)
					   {
						   Neuron *neuron = this->outputLayer->get(i);
						   Vector<double> *weights = neuron->getWeights();

						   // Correção do peso do bias = (1 * peso_anterior + taxa_aprendizado * delta_saída * bias)
						   weights->set(0, (alpha * weights->get(0) + eta * delta_o->get(i) * 1.0) );

						   for (int j=1; j < weights->getSize(); j++)
						   {
							   // Correção dos pesos = (1 * peso_anterior + taxa_aprendizado * delta_saída * saída_camada_escondida)
							   weights->set(j, ( alpha * weights->get(j) + eta * delta_o->get(i) *	hidden2outputLayer->get(j-1) )  );
						   }
						   neuron->setWeights(weights);
					   }

					   // Atualizando os pesos da camada escondida
					   for (int i=0; i < this->hiddenLayer->getSize(); i++)
					   {
						   Neuron *neuron = this->hiddenLayer->get(i);
						   Vector<double> *weights = neuron->getWeights();

						   // Correção do peso do bias = (1 * peso_anterior + taxa_aprendizado * delta_escondida * bias)
						   weights->set(0, (alpha * weights->get(0) + eta * delta_h->get(i) * 1.0) );

						   for (int j=1; j < weights->getSize(); j++)
						   {
							   // Correção dos pesos = (1 * peso_anterior + taxa_aprendizado * delta_escondida * dados_entrada)
							   weights->set(j, (alpha * weights->get(j) + eta * delta_h->get(i) * input->get(j-1) ) );
						   }

						   neuron->setWeights(weights);
					   }

					   // Liberando memória
					   delete input;
					   delete y_expected;
					   delete hidden2outputLayer;
					   delete output;
					   delete delta_o;
					   delete delta_h;
					}
					fclose(f);

					//
					// Verificação do erro de saída: caso o erro se mantenha o mesmo
					// durante 1000 iterações, os pesos da rede são resetados
					//
					total_error = roundf(total_error * 10000.0) / 10000.0;
					if(prev_error == total_error)
					{
						++counter;
					}
					else
					{
						counter = 0;
						prev_error = total_error;
					}

					// Verificando as mil iterações
					if(counter == 1000)
					{
						prev_error = 999999.0;
						printf("\n\nResetando os pesos!\n\n");
						srand(time(NULL));
						counter = 0;
						++temp;

						// Resetando os pesos da camada escondida
						for(int i = 0; i < this->hiddenLayer->getSize(); ++i)
						{
							Neuron *neuron = this->hiddenLayer->get(i);
							Vector<double> *weights = neuron->getWeights();
							for(int j = 0; j < weights->getSize(); ++j)
								weights->set(j, rand() / (RAND_MAX * 1.0));
						}

						// Resetando os pesos da camada de saída
						for(int i = 0; i < this->outputLayer->getSize(); ++i)
						{
							Neuron *neuron = this->outputLayer->get(i);
							Vector<double> *weights = neuron->getWeights();
							for(int j = 0; j < weights->getSize(); ++j)
								weights->set(j, rand() / (RAND_MAX * 1.0));
						}
					}
					else
						printf("Total error: %lf\n", total_error);

				} while( total_error > tolerance );

				//
				// Imprimindo os pesos finais da rede MLP
				//
				fprintf(weightsFile, "\n----------------------\n");
				fprintf(weightsFile, "\nPesos finais da rede:\n");
				fprintf(weightsFile, "\n----------------------\n");
				fprintf(weightsFile, "\n\tCamada escondida:\n");
				for(int i = 0; i < this->hiddenLayer->getSize(); ++i)
				{
					fprintf(weightsFile, "\t\tNeuronio %d\n", i + 1);
					Neuron *neuron = this->hiddenLayer->get(i);
					Vector<double> *weights = neuron->getWeights();
					for(int j = 0; j < weights->getSize(); ++j)
						fprintf(weightsFile, "\t\t\t%lf\n", weights->get(j));
					fprintf(weightsFile, "\n");
				}
				fprintf(weightsFile, "\n----------------------\n");
				fprintf(weightsFile, "\n\tCamada de saida:\n");
				for(int i = 0; i < this->outputLayer->getSize(); ++i)
				{
					fprintf(weightsFile, "\t\tNeuronio %d\n", i + 1);
					Neuron *neuron = this->outputLayer->get(i);
					Vector<double> *weights = neuron->getWeights();
					for(int j = 0; j < weights->getSize(); ++j)
						fprintf(weightsFile, "\t\t\t%lf\n", weights->get(j));
					fprintf(weightsFile, "\n");
				}
				printf("\nNumero de reset de pesos = %d\n", temp);
				printf("\nCounter = %d\n", counter);
				fclose(weightsFile);
			}
};

#endif
