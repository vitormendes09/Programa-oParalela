# PP-T3-Ruby-Bruno-Messias-Pedro-Vitor-Wellington

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

a = ler_numero("\nDigite o valor de a: ")

b = ler_numero("\nDigite o valor de b, diferente de zero: ")
while b == 0
  puts "Erro: b não pode ser zero."
  b = ler_numero("\nDigite novamente o valor de b: ")
end

n = ler_inteiro("\nDigite o valor de N, maior ou igual a 1: ")
while n < 1
  puts "Erro: N deve ser maior ou igual a 1."
  n = ler_inteiro("\nDigite novamente o valor de N: ")
end

tempo_soma = rand(1..10)
tempo_subtracao = rand(1..10)
tempo_multiplicacao = rand(1..10)
tempo_divisao = rand(1..10)

puts "\nTempos gerados:"
puts "Soma: #{tempo_soma} segundo(s)"
puts "Subtracao: #{tempo_subtracao} segundo(s)"
puts "Multiplicacao: #{tempo_multiplicacao} segundo(s)"
puts "Divisao: #{tempo_divisao} segundo(s)"

# Criação dos semáforos, soma começa liberado, outros bloqueados
semaforo_soma = Semaforo.new(1)
semaforo_subtracao = Semaforo.new(0)
semaforo_multiplicacao = Semaforo.new(0)
semaforo_divisao = Semaforo.new(0)

# Soma
thread_soma = Thread.new do
  n.times do |i|
    semaforo_soma.esperar

    sleep(tempo_soma)

    resultado = a + b
    puts "\nSequencia #{i + 1} - Soma: #{a} + #{b} = #{resultado}"

    semaforo_subtracao.liberar
  end
end

# Subtração
thread_subtracao = Thread.new do
  n.times do |i|
    semaforo_subtracao.esperar

    sleep(tempo_subtracao)

    resultado = a - b
    puts "\nSequencia #{i + 1} - Subtracao: #{a} - #{b} = #{resultado}"

    semaforo_multiplicacao.liberar
  end
end

# Multiplicação
thread_multiplicacao = Thread.new do
  n.times do |i|
    semaforo_multiplicacao.esperar

    sleep(tempo_multiplicacao)

    resultado = a * b
    puts "\nSequencia #{i + 1} - Multiplicacao: #{a} * #{b} = #{resultado}"

    semaforo_divisao.liberar
  end
end

# Divisão
thread_divisao = Thread.new do
  n.times do |i|
    semaforo_divisao.esperar

    sleep(tempo_divisao)

    resultado = a / b
    puts "\nSequencia #{i + 1} - Divisao: #{a} / #{b} = #{resultado}"

    # Libera a próxima sequência somente depois que a divisão terminar.
    semaforo_soma.liberar
  end
end

# A Thread principal aguarda as quatro Threads terminarem
thread_soma.join
thread_subtracao.join
thread_multiplicacao.join
thread_divisao.join

puts "\nProcessamento finalizado."