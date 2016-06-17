# =======================================================
# Script para rodar cross-validation no dataset mushroom
# Autores:
# 	Amandia Sá
# 	Bruno Gregório
# 	Paulo Freire

# Versão: 1.0
# Data: 17/06/2016
# =======================================================

#!/usr/bin/env python
import os
import subprocess
import fnmatch
import operator
import time

home_path = os.getcwd() + "/" # pega o caminho base
MLP = home_path + "./MLP" # caminho para o executavel
treinamento = home_path + "mushroom_treino_moda_" # nome base dos arquivos de treinamento
teste = home_path + "mushroom_teste_moda_" # nome base dos arquivos de teste
results_folder = home_path + "Resultados" # folder para colocar os resultados

def do_it():

	# leitura da quantidade de atributos, neuronios, taxa de aprendizado e erro
	# a camada de saida, para essa base, tem apenas um neuronio
	num_atributos = int(raw_input("Entre com o numero de atributos: ")) 
	num_inicial_neuronios = int(raw_input("Entre com o numero inicial de neuronios da camada escondida: "))
	num_final_neuronios = int(raw_input("Entre com o numero final de neuronios da camada escondida: "))
	taxa_aprendizado = float(raw_input("Entre com a taxa de aprendizado: "))
	erro = float(raw_input("Entre com o erro: "))

	if taxa_aprendizado > 1.0:
		taxa_aprendizado = 1.0
	elif taxa_aprendizado <= 0.0:
		taxa_aprendizado = 0.1
	
	# executa a rede neural no intervalo de neuronios definido pelo usuario
	while num_inicial_neuronios <= num_final_neuronios:
		num_TP = 0
		num_FP = 0
		i = 1
		while i <= 10:
			#complementa o nome do arquivo de teste
			teste_file = teste + str(i) + ".txt"

			# complementa o nome do arquivo de treinamento
			treinamento_file = treinamento + str(i) + ".txt"

			# arquivo de saida com a matriz de confusao
			saida = "saida_" + str(num_inicial_neuronios) + "_" + str(taxa_aprendizado) + "_" + str(erro) + "_" + str(i) +  ".txt" # arquivo de saida com  a matriz de confusao

			# controle de execucao (informacoes ficam no arquivo Done.txt)
			subprocess.call("echo Neuronios = " + str(num_inicial_neuronios) + ", Aprendizado = " + str(taxa_aprendizado) + ", Erro = " + str(erro) + ">>" + str(done), shell = True) 
			
			# marca inicio do processamento
			start_time = time.time()
			
			# executa a rede neural e salva o output no arquivo de saida
			subprocess.call(MLP + " " + str(num_atributos) + " " + str(num_inicial_neuronios) + " 1 " + teste_file + " " + treinamento_file + " " + str(taxa_aprendizado) + " " + str(erro) + " >> " + saida, shell = True)
			
			# obtem o tempo de execucao da rede
			elapsed_time = time.time() - start_time

			# extrai os valores de TP e FP da matriz de confusao
			# pega cada valor do arquivo de saida, transforma em inteiro e salva em um vetor (valores)
			valores = [int(line.rstrip('\n')) for line in open(saida)]
			num_TP = num_TP + valores[0] + valores[3]
			num_FP = num_FP + valores[1] + valores[2]

			# controle de execucao - marca em Done.txt o tempo de execucao da rede neural
			subprocess.call("echo Fim do processamento. Tempo total estimado = " + str(elapsed_time) + " >> " + done, shell = True)
			subprocess.call("echo >> " + done, shell = True)

			# coloca o arquivo de saida no folder Resultados
			subprocess.call("mv " + saida + " " + results_folder, shell = True)

			# vai pro proximo caso
			i = i + 1
		
		# nome do arquivo que tera a media de acertos e erros da rede no cross-validation
		saida_media = "saida_" + str(num_inicial_neuronios) + "_" + str(taxa_aprendizado) + "_" + str(erro) +  "_MEDIA.txt"
		
		# calcula a media de acertos e erros da rede
		media_TP = float(num_TP / (812 * 10.0))
		media_FP = float(num_FP / (812 * 10.0))

		# joga os resultados para o arquivo
		subprocess.call("echo " + " " + str(num_TP) + " " + str(media_TP) + " " + str(num_FP) + " " + str(media_FP) +  " >> " + saida_media, shell = True)
		
		# incrementa o numero de neuronios
		num_inicial_neuronios = num_inicial_neuronios + 1

	return

# criacao do folder Resultados e do arquivo de controle de execucao Done.txt
subprocess.call("rm -Rf " + results_folder, shell = True)
subprocess.call("mkdir " + results_folder, shell = True)
done = home_path + "Done.txt"
subprocess.call("rm " + done, shell = True)

# just
do_it()