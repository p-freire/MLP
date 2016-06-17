/*======================================================================
 * Classe para manipulação de strings.
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

#ifndef _STRING_H_
#define _STRING_H_

#include <stdio.h>
#include <string.h>

//**********************************************************************
// 							Classe String
//**********************************************************************
class String {
	private:
		char *string;

	public:
		//
		// Construtores
		//
		String() { this->string = NULL; }

		String(char *str) {
			this->string = NULL;
			set(str);
		}

		String(String *str) {
			this->string = NULL;
			set(str->toCharArray());
		}

		String(String &str) {
			this->string = NULL;
			set(str.toCharArray());
		}

		// Destrutor
		~String() { delete[] this->string; }

		//
        // Setters
        //
        void set() { this->string = NULL; }
		void set(String &str) {	set(str.toCharArray()); }
		void set(String *str) { set(str->toCharArray()); }

		void set(char *str) {
			if (this->string != NULL)
				delete[] this->string;

			this->string = new char[strlen(str) + 1];
			strcpy(this->string, str);
		}


        /* Pré-Condição: nenhuma
           Pós-Condição: imprime o conteúdo da string */
        void print() { printf("%s\n", this->string); }

		//
        // Sobrecargas
        //
		void operator+(String &str) { concat(str); }
		void operator=(char *str) {	set(str); }
		void operator=(String *str) { set(str); }
		void operator=(String &str) { set(str); }

        /* Pré-condição: nenhuma
           Pós-condição: retorna a quantidade de caracteres da string */
		int length() {
			if (this->string != NULL)
				return strlen(this->string);
			return -1;
		}

        /* Pré-condição: recebe uma variável (char*, String* ou String&) como parâmetro
           Pós-condição: concatena a string original com a string passada */
		void concat(String &str) { concat(str.toCharArray()); }
		void concat(String *str) { concat(str->toCharArray());}
		void concat(char *str) {
			if (this->string != NULL && str != NULL) {
				char *aux = new char[strlen(this->string) + strlen(str) + 1];
				strcpy(aux, this->string);
				strcat(aux, str);
				delete[] this->string;
				this->string = aux;
			} else if (str != NULL) {
				set(str);
			}
		}

        /* Pré-condição: nenhuma
           Pós-condição: altera todos os caracteres da string para letras maiúsculas */
		void toUpperCase() {
		    if (this->string != NULL) {
			char *aux = this->string;
			while (*aux != '\0') {
				if (*aux >= 97 && *aux <= 122)
					*aux = *aux - 32;
				aux++;
			}
		    }
		}

        /* Pré-condição: nenhuma
           Pós-condição: altera todos os caracteres da string para letras minúsculas */
		void toLowerCase() {
		    if (this->string != NULL) {
                char *aux = this->string;

                while (*aux != '\0') {
                    if (*aux >= 65 && *aux <= 90)
                        *aux = *aux + 32;
                    aux++;
                }
		    }
		}

        /* Pré-condição: recebe uma variável (char*, String* ou String&) como parâmetro
           Pós-condição: verifica se o parâmetro passado coincide com a variável string,
                         retornando 1 se positivo e 0 caso contrário */
		int equals(String &str) { return equals(str.toCharArray()); }
		int equals(String *str) { return equals(str->toCharArray());}
		int equals(char *str) {
			if (strcmp(this->string, str) == 0)
				return 1;
			else
				return 0;
		}

        /* Pré-condição: nenhuma
           Pós-condição: retorna a variável string como um char* */
		char *toCharArray() {
			return this->string;
		}

        /* Pré-condição: recebe um char como parâmetro
           Pós-condição: retorna a posição do parâmetro passado na string */
		int indexOf(char c) {
			if (this->string != NULL) {
				int pos = 0;
				char *aux = this->string;

				while (*aux != '\0') {
					if (*aux == c) {
						return pos;
					}
					pos++;
					aux++;
				}
			}
			return -1;
		}

        /* Pré-condição: recebe dois char* como parâmetro
           Pós-condição: altera os caracteres do primeiro parâmetro na string
                         para os caracteres do segundo parâmetro passado */
		void replace(char *src, char *dst) {
		    if (this->string != NULL) {
                char *aux = new char[length()+1];
                strcpy(aux, this->string);

                char *token = strtok(aux, src);
                delete[] this->string;
                this->string = NULL;

                if (token != NULL) {
                    concat(token);
                    while ((token = strtok(NULL, src)) != NULL) {
                        concat(dst);
                        concat(token);
                    }
                }
		    }
		}
};

#endif
