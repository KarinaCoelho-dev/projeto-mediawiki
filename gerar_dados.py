# Gera 240 artigos ficticios para importacao no MediaWiki.
from pathlib import Path

TEMAS = ["Algoritmos", "Banco de Dados", "Redes de Computadores", "Engenharia de Software",
         "Sistemas Operacionais", "Seguranca da Informacao", "Desenvolvimento Web", "Inteligencia Artificial"]
raiz = Path(__file__).parent / "dados_ficticios"
for numero in range(1, 241):
    lote = (numero - 1) // 40 + 1
    pasta = raiz / f"lote{lote:02d}"
    pasta.mkdir(parents=True, exist_ok=True)
    tema = TEMAS[(numero - 1) % len(TEMAS)]
    proximo = (numero % 240) + 1
    texto = (f"'''Artigo ficticio {numero:03d} - {tema}'''\n\n"
             f"== Apresentacao ==\n"
             f"Este artigo de teste numero {numero:03d} foi criado exclusivamente para a atividade academica de Banco de Dados. "
             f"Todos os nomes, assuntos organizados e registros sao ficticios.\n\n"
             f"== Conteudo ==\n"
             f"A categoria abordada e {tema}. O objetivo e demonstrar a organizacao das paginas de uma wiki, "
             f"o armazenamento de revisoes e a consulta das ligacoes entre tabelas.\n\n"
             f"== Relacionamentos ==\n"
             f"Consulte tambem [[Projeto/Artigo_{proximo:03d}]] para estudar ligacoes internas.\n\n"
             f"[[Category:{tema}]]\n")
    (pasta / f"Artigo_{numero:03d}.txt").write_text(texto, encoding="utf-8")
print("Gerados 240 artigos ficticios em 6 lotes de 40.")
