#include <iostream>
using namespace std;

	int main()
{
	setlocale(LC_ALL, "Portuguese");


//Inicializa��o de Vari�veis

	int vidas, tiros, mortes, status=0;
	float acertos;
	string nome;

//Entrada de dados
/*
	cout<<"Qual o nome do jogador?\n";
	cin>>nome;
	
	cout<<"Quantas vidas o jogador iniciar�?\n";
	cin>>vidas;
	
	while(vidas>=0)
{	
	
	cout<<"O jogador "<<nome<<" tem "<<vidas<<" vidas"<<endl;

	cout<<"O jogador j� morreu quantas vezes?\n";
	cin>>mortes;
	
	cout<<"Quantos tiros ele efetuou?\n";
	cin>>tiros;
	
	cout<<"Quantos tiros ele acertou?\n";
	cin>> acertos;

//Teste de condi��o
if(acertos>tiros){
	acertos=tiros;
	cout<<"Imposs�vel acertar mais tiros do que os disparados!";
}
	vidas = vidas - mortes + ((acertos)/2);
	
	if(vidas>=0)
{

	cout<<"\n O jogador est� vivo...\n ...por enquanto kkk\n";
	
}
	
}

	cout<<"\nGame Over\n";

system("pause");
return 0;
}
*/
	cout<<"Qual o nome do jogador?\n";
	cin>>nome;
	
	cout<<"Quantas vidas o jogador tem?\n";
	cin>>vidas;
	
	cout<<"O jogador "<<nome<<" tem "<<vidas<<" vidas"<<endl;

	cout<<"O jogador j� morreu quantas vezes?\n";
	cin>>mortes;

	cout<<"Quantos tiros ele sofreu?\n";
	cin>>tiros;
	
	status = vidas - mortes ;

if(tiros>=5)
{
	cout<<"Game Over, morreu por excessos de tiros.";
	status = -1;
}

	if(status<0)
{
	
	cout<<"\nGame Over\n";
}
	else
{
	cout<<"\n O jogador est� vivo...\n ...por enquanto kkk\n";
}



system("pause");
return 0;
}

