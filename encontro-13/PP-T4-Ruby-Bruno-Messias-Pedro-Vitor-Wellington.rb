# PP-T4-Ruby-Bruno-Messias-Pedro-Vitor-Wellington

class Semaforo
  def initialize(valor_inicial)
    @valor = valor_inicial
    @mutex = Mutex.new
    @condicao = ConditionVariable.new
  end

  def esperar
    @mutex.synchronize do
      while @valor == 0
        @condicao.wait(@mutex)
      end

      @valor -= 1
    end
  end

  def liberar
    @mutex.synchronize do
      @valor += 1
      @condicao.signal
    end
  end
end

def ler_numero(mensagem)
  print mensagem
  gets.chomp.to_f
end

def ler_inteiro(mensagem)
  print mensagem
  gets.chomp.to_i
end


puts "\nRESOLUCAO DE SISTEMA TRIANGULAR INFERIOR Lx=b"

n = ler_inteiro("\nDigite a ordem N do sistema: ")

while n < 1
  puts "Erro: N deve ser maior ou igual a 1."
  n = ler_inteiro("Digite novamente o valor de N: ")
end

matriz_l = Array.new(n) { Array.new(n, 0.0) }

vetor_b = Array.new(n, 0.0)

vetor_x = Array.new(n, 0.0)

puts "\nDigite os valores da matriz triangular inferior L:"

n.times do |i|
  (i + 1).times do |j|

    valor = ler_numero("L[#{i + 1}][#{j + 1}]: ")

    while i == j && valor == 0
      puts "Erro: o elemento da diagonal principal nao pode ser zero."
      valor = ler_numero("Digite novamente L[#{i + 1}][#{j + 1}]: ")
    end

    matriz_l[i][j] = valor
  end
end

puts "\nDigite os valores do vetor b:"

n.times do |i|
  vetor_b[i] = ler_numero("b[#{i + 1}]: ")
end

semaforo_somatorio = Semaforo.new(1)

semaforo_x = Semaforo.new(0)

somatorio = 0.0


puts "\nINICIANDO PROCESSAMENTO"

thread_somatorio = Thread.new do

  n.times do |i|

    semaforo_somatorio.esperar

    somatorio = 0.0

    i.times do |j|
      somatorio += matriz_l[i][j] * vetor_x[j]
    end
    puts "\nLinha #{i + 1}"
    puts "Thread Somatorio:"
    puts "Somatorio = #{somatorio}"

    semaforo_x.liberar
  end
end

thread_x = Thread.new do

  n.times do |i|

    semaforo_x.esperar

    vetor_x[i] =
      (vetor_b[i] - somatorio) /
      matriz_l[i][i]

    puts "\nThread X:"
    puts "x[#{i + 1}] = (#{vetor_b[i]} - #{somatorio}) / #{matriz_l[i][i]}"
    puts "x[#{i + 1}] = #{vetor_x[i]}"

    semaforo_somatorio.liberar
  end
end

thread_somatorio.join
thread_x.join

puts "\nRESULTADO FINAL"


vetor_x.each_with_index do |valor, i|
  puts "x[#{i + 1}] = #{valor}"
end

puts "\nProcessamento finalizado."