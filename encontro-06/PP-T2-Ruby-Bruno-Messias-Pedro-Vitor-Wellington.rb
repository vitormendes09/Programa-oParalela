# PP-T2-Ruby-Bruno-Messias-Pedro-Vitor-Wellington

def ler_numero(mensagem)
  print mensagem
  input = gets.chomp
  input.include?('.') ? input.to_f : input.to_i
end

a = ler_numero("Digite o valor de 'a': ")

b = 0
loop do
  b = ler_numero("Digite o valor de 'b': ")
  break if b != 0 
  puts "Erro: O valor de 'b' não pode ser zero. Tente novamente."
end

operacoes = [
  { nome: "SOMA", calculo: ->(x, y) { x + y } },
  { nome: "SUBTRACAO", calculo: ->(x, y) { x - y } },
  { nome: "MULTIPLICACAO", calculo: ->(x, y) { x * y } },
  { nome: "DIVISAO", calculo: ->(x, y) { x.to_f / y } }
]

threads = []

# Execução
operacoes.each do |op|
  threads << Thread.new do
    tempo_sono = rand(1..20)
    
    resultado = op[:calculo].call(a, b)
    
    resultado = resultado.to_i if resultado == resultado.to_i

    puts "\nEu sou a Thread #{op[:nome]} (#{resultado}) e vou dormir por #{tempo_sono} segundos!"
    
    # Coloca a thread para dormir
    sleep(tempo_sono)
    
    puts "\nEu sou a Thread #{op[:nome]} (#{resultado}). Já se passaram #{tempo_sono} segundos, então terminei!"
  end
end

# Aguarda todas as threads terminarem
threads.each(&:join)

puts "\nTodas as threads finalizaram com sucesso!"