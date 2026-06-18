# Lista de Exercícios - Paradigmas de Programação (Ruby)
# Autores: Bruno, Messias, Pedro, Vitor e Wellington

# ==============================================================================
# EXERCÍCIO 1: Manipulação de Matrizes e Condicionais (Min/Max)
# ==============================================================================
class Exercicio1
  def initialize
    @n = 4 # Número de linhas
    @m = 5 # Número de colunas
    # Cria uma matriz vazia N x M usando blocos do Ruby
    @matriz = Array.new(@n) { Array.new(@m) }
    preencher_matriz_aleatoriamente
    imprimir_matriz
  end

  # Preenche cada posição da matriz com números aleatórios entre 1 e 20
  def preencher_matriz_aleatoriamente
    for i in 0...@n
      for j in 0...@m
        @matriz[i][j] = rand(1..20)
      end
    end
  end

  # Imprime a matriz formatada na tela usando alinhamento à direita (rjust)
  def imprimir_matriz
    puts "Matriz A (#{@n}x#{@m}):"
    for i in 0...@n
      for j in 0...@m
        # .to_s converte para String; .rjust(3) garante que cada número ocupe 3 espaços
        print "#{@matriz[i][j].to_s.rjust(3)} "
      end
      puts # Pula de linha ao final de cada linha da matriz
    end
  end

  # Calcula a soma absoluta dos elementos de cada coluna e retorna a menor soma
  def soma_colunas
    soma_colunas = [] # Vetor que guardará o resultado da soma de cada coluna
    for j in 0...@m   # Percorre coluna por coluna primeiro
      soma = 0
      for i in 0...@n # Percorre as linhas daquela coluna
        soma += @matriz[i][j].abs   # .abs calcula o módulo |aij| (valor absoluto)
      end
      soma_colunas << soma # Adiciona a soma da coluna atual no vetor de resultados
    end
    minimo = soma_colunas.min # Encontra o menor valor contido no vetor de somas
    puts "Menor soma de coluna (com abs): #{minimo}"
    return minimo
  end

  # Calcula o produto dos elementos de cada linha e retorna o maior produto
  def multiplica_linhas
    produto_linhas = [] # Vetor que guardará o produto de cada linha
    for i in 0...@n     # Percorre linha por linha primeiro
      produto = 1       # Elemento neutro da multiplicação
      for j in 0...@m   # Percorre as colunas daquela linha
        produto *= @matriz[i][j]
      end
      produto_linhas << produto # Guarda o produto final da linha atual
    end
    maximo = produto_linhas.max # Encontra o maior valor contido no vetor de produtos
    puts "Maior produto de linha: #{maximo}"
    return maximo
  end

  # Regra de negócio: verifica se a menor soma de coluna é <= ao maior produto de linha
  def verifica_matriz
    if soma_colunas <= multiplica_linhas
      puts "Condicao Satisfeita"
    else
      puts "Condicao Nao Satisfeita"
    end
  end
end

# ==============================================================================
# EXERCÍCIO 2: Álgebra Linear - Verificação de Matriz Ortogonal (M x M^T = I)
# ==============================================================================
class Exercicio2
  def initialize
    @n = 4 # Matriz quadrada 4x4
    @matriz = Array.new(@n) { Array.new(@n) }
    preencher_matriz_aleatoriamente
    puts "Matriz M (#{@n}x#{@n}):"
    imprimir_matriz(@matriz)
  end

  def preencher_matriz_aleatoriamente
    for i in 0...@n
      for j in 0...@n
        @matriz[i][j] = rand(0..29)
      end
    end
  end

  def imprimir_matriz(matriz)
    for i in 0...matriz.length
      for j in 0...matriz[i].length
        print "#{matriz[i][j].to_s.rjust(4)} "
      end
      puts
    end
  end

  # Gera e retorna a matriz transposta (troca linhas por colunas: T[j][i] = M[i][j])
  def matriz_transposta
    transposta = Array.new(@n) { Array.new(@n) }
    for i in 0...@n
      for j in 0...@n
        transposta[j][i] = @matriz[i][j]
      end
    end
    return transposta
  end

  # Realiza a multiplicação de matrizes tradicional (Métrica O(n^3))
  def multiplica_matrizes
    transposta = matriz_transposta
    resultado = Array.new(@n) { Array.new(@n, 0) } # Inicializa a matriz com zeros
    for i in 0...@n     # Linha da matriz original
      for j in 0...@n   # Coluna da matriz transposta
        for k in 0...@n # Índice de colisão (produto escalar da linha i pela coluna j)
          resultado[i][j] += @matriz[i][k] * transposta[k][j]
        end
      end
    end
    return resultado
  end

  # Verifica se a matriz resultante é uma Matriz Identidade
  # (1 na diagonal principal e 0 nas demais posições)
  def identidade?(matriz)
    for i in 0...@n
      for j in 0...@n
        if i == j && matriz[i][j] != 1     # Se for diagonal e diferente de 1 -> Falso
          return false
        elsif i != j && matriz[i][j] != 0  # Se não for diagonal e diferente de 0 -> Falso
          return false
        end
      end
    end
    return true # Se passou por todo o laço sem falhar, é uma identidade
  end

  # Exibe os resultados e conclui se a matriz original é ortogonal
  def verifica_matriz_ortogonal
    resultado = multiplica_matrizes
    puts "\nM × M^T:"
    imprimir_matriz(resultado)
    if identidade?(resultado)
      puts "A matriz é ortogonal."
    else
      puts "A matriz não é ortogonal."
    end
  end
end

# ==============================================================================
# EXERCÍCIO 3: Reorganização de Vetor In-Place (Índice Par = Num Par / Ímpar = Num Ímpar)
# ==============================================================================
class Exercicio3
  def initialize
    @vetor = Array.new(20)
    preencher_vetor_manualmente
    organizar_vetor
  end

  def preencher_vetor_manualmente
    puts "Digite 20 números inteiros (10 pares e 10 ímpares, em qualquer ordem):"
    for i in 0...20
      print "Número #{i + 1}: "
      @vetor[i] = gets.chomp.to_i # Captura o input do teclado e converte para inteiro
    end
    puts "Vetor original: #{@vetor.join(', ')}"
  end

  # Algoritmo de permutação in-place para ajustar a paridade pelo índice
  def organizar_vetor
    i = 0
    while i < @vetor.length
      esperado_par = i.even?     # Verifica se o ÍNDICE atual é par (true/false)
      elemento_par = @vetor[i].even? # Verifica se o ELEMENTO no índice é par (true/false)

      if esperado_par == elemento_par
        # Se o elemento combina com o índice correto, avançamos o ponteiro
        i += 1
      else
        # Se estiver incorreto, procuramos à frente (ponteiro j) um número adequado para trocar
        j = i + 1
        while j < @vetor.length
          elemento_j_par = @vetor[j].even?
          # Se acharmos um elemento à frente que tem a paridade que o índice 'i' precisa:
          if elemento_j_par == esperado_par
            # Fazemos o Swap (troca de valores em Ruby sem precisar de variável auxiliar)
            @vetor[i], @vetor[j] = @vetor[j], @vetor[i]
            break # Interrompe a busca interna, pois já resolveu o índice 'i'
          end
          j += 1
        end
        i += 1 # Avança para avaliar o próximo índice
      end
    end
    puts "Vetor organizado: #{@vetor.join(', ')}"
  end
end

# ==============================================================================
# EXERCÍCIO 4: Algoritmo de Ordenação Decrescente (Bubble Sort Manual)
# ==============================================================================
class Exercicio4
  def initialize
    @vetor = Array.new(30)
    preencher_vetor_aleatoriamente
    puts "Vetor antes da ordenação:"
    imprimir_vetor
    ordenar_decrescente
    puts "Vetor após a ordenação (não-crescente):"
    imprimir_vetor
  end

  def preencher_vetor_aleatoriamente
    for i in 0...30
      @vetor[i] = rand(1..30)
    end
  end

  def imprimir_vetor
    puts @vetor.join(', ')
  end

  # Implementação clássica do Bubble Sort (Ordenação por Bolha) adaptado para decrescente
  def ordenar_decrescente
    for i in 0...@vetor.length
      # O limite (- 1 - i) impede comparações desnecessárias com os itens já ordenados no fim
      for j in 0...(@vetor.length - 1 - i)
        # Se o elemento atual for MENOR que o próximo, eles trocam de lugar (garante o decrescente)
        if @vetor[j] < @vetor[j + 1]
          @vetor[j], @vetor[j + 1] = @vetor[j + 1], @vetor[j]
        end
      end
    end
  end
end

# ==============================================================================
# EXERCÍCIO 5: Potenciação Recursiva Pura (a^b)
# ==============================================================================
class Exercicio5
  def initialize
    @a = 0
    @b = 0
    ler_numeros
    imprimir_resultado
  end

  # Garante as restrições via laços de validação (loop do ... break)
  def ler_numeros
    loop do
      print "Digite um número inteiro diferente de 0 (a): "
      @a = gets.chomp.to_i
      break if @a != 0
      puts "Valor inválido. 'a' deve ser diferente de 0."
    end
    loop do
      print "Digite um número inteiro maior ou igual a 0 (b): "
      @b = gets.chomp.to_i
      break if @b >= 0
      puts "Valor inválido. 'b' deve ser maior ou igual a 0."
    end
  end

  # Função Recursiva para calcular Potência
  def calcular_potencia_recursiva(a, b)
    if b == 0
      return 1 # CASO BASE: Todo número elevado a 0 é igual a 1. Interrompe a recursão.
    else
      # CASO RECURSIVO: Multiplica 'a' pelo resultado de a^(b-1)
      return a * calcular_potencia_recursiva(a, b - 1)
    end
  end

  def imprimir_resultado
    resultado = calcular_potencia_recursiva(@a, @b)
    puts "#{@a}^#{@b} = #{resultado}"
  end
end

# ==============================================================================
# EXERCÍCIO 6: Particionamento Recursivo (Compostos no Início / Primos no Fim)
# ==============================================================================
class Exercicio6
  def initialize
    @vetor = Array.new(20)
    preencher_vetor_manualmente
    # Inicia a recursão passando o primeiro índice (0) e o último (19)
    organizar_recursivo(0, @vetor.length - 1)
    puts "Vetor organizado (compostos | não-compostos): #{@vetor.join(', ')}"
  end

  def preencher_vetor_manualmente
    puts "Digite 20 números naturais maiores que 1:"
    i = 0
    while i < 20
      print "Número #{i + 1}: "
      num = gets.chomp.to_i
      if num <= 1
        puts "Número inválido. Digite um número natural maior que 1."
        next # Pula o resto do laço e refaz a iteração atual
      end
      @vetor[i] = num
      i += 1
    end
    puts "Vetor original: #{@vetor.join(', ')}"
  end

  # Função auxiliar: Retorna 1 se o número for composto, 0 se for primo (não-composto)
  def composto(numero)
    divisores = 0
    for i in 1..numero
      if numero % i == 0
        divisores += 1
      end
    end
    # Um número é composto se tiver mais do que 2 divisores (ele mesmo e 1)
    return divisores > 2 ? 1 : 0
  end

  # Algoritmo de dois ponteiros estruturado via recursão
  def organizar_recursivo(inicio, fim)
    return if inicio >= fim   # CASO BASE: Quando os ponteiros se cruzam, o vetor está particionado.

    if composto(@vetor[inicio]) == 1
      # Se o elemento do início já for composto, ele está no lugar certo. Avança o início.
      organizar_recursivo(inicio + 1, fim)
    elsif composto(@vetor[fim]) == 0
      # Se o elemento do fim for primo (não-composto), ele está no lugar certo. Recua o fim.
      organizar_recursivo(inicio, fim - 1)
    else
      # Se o do início for primo e o do fim for composto, ambos estão desalinhados. Fazemos o Swap.
      @vetor[inicio], @vetor[fim] = @vetor[fim], @vetor[inicio]
      # Move ambos os ponteiros e continua a recursão no restante do vetor
      organizar_recursivo(inicio + 1, fim - 1)
    end
  end
end

# ==============================================================================
# EXERCÍCIO 7: Busca do Maior Elemento com Recursão em Cauda
# ==============================================================================
class Exercicio7
  def initialize
    @vetor = Array.new(50)
    preencher_vetor_aleatoriamente
    puts "Vetor: #{@vetor.join(', ')}"
    # Dispara a recursão enviando o vetor, o índice inicial (0) e assume o primeiro item como o maior
    maior = definir_maior_recursivamente(@vetor, 0, @vetor[0])
    puts "O maior número do vetor é: #{maior}"
  end

  def preencher_vetor_aleatoriamente
    for i in 0...@vetor.length
      @vetor[i] = rand(1..100)
    end
  end

  # Algoritmo de varredura recursiva (Recursão em Cauda / Tail Recursion)
  def definir_maior_recursivamente(vetor, i, maior)
    return maior if i >= vetor.length # CASO BASE: Varreu todo o vetor, retorna o maior acumulado.

    # Se o elemento atual for maior que o histórico, atualiza a variável local 'maior'
    maior = vetor[i] if vetor[i] > maior
    
    # CASO RECURSIVO: Avança para o próximo índice (i + 1) passando o 'maior' atualizado
    definir_maior_recursivamente(vetor, i + 1, maior)
  end
end

# ==============================================================================
# BLOCO PRINCIPAL DO SISTEMA: Menu Iterativo de Linha de Comando (CLI)
# ==============================================================================
if __FILE__ == $0 # Esta linha garante que o código só roda se for executado diretamente
  loop do
    puts "\nEscolha um exercício para executar:"
    puts "1 - Exercício 1 (Matriz A, condição min/max)"
    puts "2 - Exercício 2 (Matriz ortogonal)"
    puts "3 - Exercício 3 (Vetor pares/ímpares por posição)"
    puts "4 - Exercício 4 (Vetor ordenado não-crescente)"
    puts "5 - Exercício 5 (Potência recursiva)"
    puts "6 - Exercício 6 (Vetor compostos/não-compostos recursivo)"
    puts "7 - Exercício 7 (Maior valor recursivo)"
    puts "0 - Sair"
    print "\nOpção: "
    opcao = gets.chomp

    case opcao
    when "1"
      puts "\n--- Exercício 1 ---"
      exercicio1 = Exercicio1.new
      exercicio1.verifica_matriz
    when "2"
      puts "\n--- Exercício 2 ---"
      exercicio2 = Exercicio2.new
      exercicio2.verifica_matriz_ortogonal
    when "3"
      puts "\n--- Exercício 3 ---"
      Exercicio3.new
    when "4"
      puts "\n--- Exercício 4 ---"
      Exercicio4.new
    when "5"
      puts "\n--- Exercício 5 ---"
      Exercicio5.new
    when "6"
      puts "\n--- Exercício 6 ---"
      Exercicio6.new
    when "7"
      puts "\n--- Exercício 7 ---"
      Exercicio7.new
    when "0"
      puts "\nEncerrando programa..."
      break # Quebra o 'loop do' infinito e fecha o script
    else
      puts "\nOpção inválida. Tente novamente."
    end
  end
end