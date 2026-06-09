# PP-ListadeExercicios-Ruby-Bruno-Messias-Pedro-Vitor-Wellington
class Exercicio1

  def initialize
    @n = 4
    @m = 5
    @matriz = Array.new(@n) { Array.new(@m) }
    preencher_matriz_aleatoriamente
    imprimir_matriz
  end

  def preencher_matriz_aleatoriamente
    for i in 0...@n
      for j in 0...@m
        @matriz[i][j] = rand(1..20)
      end
    end
  end

  def imprimir_matriz
    puts "Matriz A (#{@n}x#{@m}):"
    for i in 0...@n
      for j in 0...@m
        print "#{@matriz[i][j].to_s.rjust(3)} "
      end
      puts
    end
  end

  def soma_colunas
    soma_colunas = []
    for j in 0...@m
      soma = 0
      for i in 0...@n
        soma += @matriz[i][j].abs   # |aij|
      end
      soma_colunas << soma
    end
    minimo = soma_colunas.min
    puts "Menor soma de coluna (com abs): #{minimo}"
    return minimo
  end

  def multiplica_linhas
    produto_linhas = []
    for i in 0...@n
      produto = 1
      for j in 0...@m
        produto *= @matriz[i][j]
      end
      produto_linhas << produto
    end
    maximo = produto_linhas.max
    puts "Maior produto de linha: #{maximo}"
    return maximo
  end

  def verifica_matriz
    if soma_colunas <= multiplica_linhas
      puts "Condicao Satisfeita"
    else
      puts "Condicao Nao Satisfeita"
    end
  end
end

class Exercicio2

  def initialize
    @n = 4
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

  def matriz_transposta
    transposta = Array.new(@n) { Array.new(@n) }
    for i in 0...@n
      for j in 0...@n
        transposta[j][i] = @matriz[i][j]
      end
    end
    return transposta
  end

  def multiplica_matrizes
    transposta = matriz_transposta
    resultado = Array.new(@n) { Array.new(@n, 0) }
    for i in 0...@n
      for j in 0...@n
        for k in 0...@n
          resultado[i][j] += @matriz[i][k] * transposta[k][j]
        end
      end
    end
    return resultado
  end

  def identidade?(matriz)
    for i in 0...@n
      for j in 0...@n
        if i == j && matriz[i][j] != 1
          return false
        elsif i != j && matriz[i][j] != 0
          return false
        end
      end
    end
    return true
  end

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
      @vetor[i] = gets.chomp.to_i
    end
    puts "Vetor original: #{@vetor.join(', ')}"
  end

  def organizar_vetor
    i = 0
    while i < @vetor.length
      esperado_par = i.even?
      elemento_par = @vetor[i].even?

      if esperado_par == elemento_par
        i += 1
      else
        j = i + 1
        while j < @vetor.length
          elemento_j_par = @vetor[j].even?
          if elemento_j_par == esperado_par
            @vetor[i], @vetor[j] = @vetor[j], @vetor[i]
            break
          end
          j += 1
        end
        i += 1
      end
    end
    puts "Vetor organizado: #{@vetor.join(', ')}"
  end
end

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

  def ordenar_decrescente
    for i in 0...@vetor.length
      for j in 0...(@vetor.length - 1 - i)
        if @vetor[j] < @vetor[j + 1]
          @vetor[j], @vetor[j + 1] = @vetor[j + 1], @vetor[j]
        end
      end
    end
  end
end

class Exercicio5

  def initialize
    @a = 0
    @b = 0
    ler_numeros
    imprimir_resultado
  end

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

  def calcular_potencia_recursiva(a, b)
    if b == 0
      return 1
    else
      return a * calcular_potencia_recursiva(a, b - 1)
    end
  end

  def imprimir_resultado
    resultado = calcular_potencia_recursiva(@a, @b)
    puts "#{@a}^#{@b} = #{resultado}"
  end
end

class Exercicio6

  def initialize
    @vetor = Array.new(20)
    preencher_vetor_manualmente
    organizar_recursivo(0, @vetor.length - 1)
    puts "Vetor organizado (compostos | não-compostos): #{@vetor.join(', ')}"
  end

  # Lê 20 naturais maiores que 1 do teclado
  def preencher_vetor_manualmente
    puts "Digite 20 números naturais maiores que 1:"
    i = 0
    while i < 20
      print "Número #{i + 1}: "
      num = gets.chomp.to_i
      if num <= 1
        puts "Número inválido. Digite um número natural maior que 1."
        next
      end
      @vetor[i] = num
      i += 1
    end
    puts "Vetor original: #{@vetor.join(', ')}"
  end

  def composto(numero)
    divisores = 0
    for i in 1..numero
      if numero % i == 0
        divisores += 1
      end
    end
    return divisores > 2 ? 1 : 0
  end

  def organizar_recursivo(inicio, fim)
    return if inicio >= fim   # caso base

    if composto(@vetor[inicio]) == 1
      organizar_recursivo(inicio + 1, fim)
    elsif composto(@vetor[fim]) == 0
      organizar_recursivo(inicio, fim - 1)
    else
      @vetor[inicio], @vetor[fim] = @vetor[fim], @vetor[inicio]
      organizar_recursivo(inicio + 1, fim - 1)
    end
  end
end

class Exercicio7

  def initialize
    @vetor = Array.new(50)
    preencher_vetor_aleatoriamente
    puts "Vetor: #{@vetor.join(', ')}"
    maior = definir_maior_recursivamente(@vetor, 0, @vetor[0])
    puts "O maior número do vetor é: #{maior}"
  end

  def preencher_vetor_aleatoriamente
    for i in 0...@vetor.length
      @vetor[i] = rand(1..100)
    end
  end

  def definir_maior_recursivamente(vetor, i, maior)
    return maior if i >= vetor.length

    maior = vetor[i] if vetor[i] > maior
    definir_maior_recursivamente(vetor, i + 1, maior)
  end
end

if __FILE__ == $0
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
      break
    else
      puts "\nOpção inválida. Tente novamente."
    end
  end
end