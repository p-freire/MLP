/*======================================================================
 * Classe para manipulação de vetores.
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

#ifndef _VECTOR_H_
#define _VECTOR_H_

#include <stdlib.h>
#include <stdio.h>
#include <math.h>

/* Definindo tipo genérico */
template <class Type>

//**********************************************************************
// 							Classe Vector
//**********************************************************************
class Vector {
	private:
		Type *elements;
		int size;

    public:
		//
        // Construtores
        //
        Vector() {
            this->elements = NULL;
            this->size = 0;
        }

		Vector(int num) {
            this->elements = NULL;
            this->size = 0;
            for(int i = 0; i < num; ++i)
				add(0);
        }

        // Destrutor
        ~Vector() {
            free(this->elements);
        }

        /* Pré-Condição: recebe como parâmetro um inteiro referente a posição no vetor
           Pós-Condição: retorna o elemento do vetor contido na posição passada por parâmetro */
        Type get(int pos) {
			if ( (pos >= 0) && (pos < this->size) ) {
				return this->elements[pos];
			}
		}

        /* Pré-Condição: nenhuma
           Pós-Condição: retorna o tamanho do vetor de elementos */
		int getSize() { return this->size; }

        /* Pré-Condição: recebe como parâmetro um elemento a ser armazenado no vetor
           Pós-Condição: adiciona ao vetor o elemento passado como parâmetro */
        void add(Type elements) {
            this->elements = (Type *) realloc(this->elements, (this->size + 1) * sizeof(Type));
            this->elements[this->size++] = elements;
        }

		/* Pré-Condição: recebe como parâmetro um elemento a ser armazenado no vetor e sua posição
           Pós-Condição: altera no vetor o elemento passado como parâmetro na posicao escolhida */
        void set(int pos, Type elements) {
            if ( (pos >= 0) && (pos < this->size) ) {
				this->elements[pos] = elements;
			}
        }

        /* Pré-Condição: recebe como parâmetro um inteiro referente a posição no vetor
           Pós-Condição: remove do vetor o elemento da posição passada */
        void remove(int pos) {
            if ( (pos >= 0) && (pos < this->size) ) {
				this->elements[pos] = this->elements[--this->size];
				this->elements = (Type *) realloc(this->elements,	sizeof(Type) * this->size);
			}
        }

		/* Pré-Condição: recebe um vetor de binário
		   Pós-Condição: devolve o valor inteiro correspondente */
		int binaryToInt() {
			int number = 0;
			
			for(unsigned int i=0; i < this->size; i++) {
				int elem = round(this->elements[i]);
				number += elem * pow(2,i);
			}

			return number;
		}
};

#endif
