# Trabalho 1 - Paradigmas de Programação (Concorrência com Threads em Ruby)
# Autores: Bruno, Messias, Pedro, Vitor e Wellington

# Início do programa
# Process.pid retorna o ID do Processo principal gerenciado pelo Sistema Operacional.
puts "Thread principal iniciada (PID: #{Process.pid})"

# Thread.new cria e dispara uma nova thread (linha de execução) imediatamente.
# O bloco de código interno passa a rodar de forma assíncrona (em segundo plano).
thread1 = Thread.new do
  # Thread.current refere-se à thread atual que está executando este bloco.
  # .native_thread_id mostra o ID real que o Sistema Operacional deu para esta thread específica.
  puts "[Thread 1 - ID: #{Thread.current.native_thread_id}] Programacao Paralela"
end

# Cria e dispara a segunda thread, que rodará concorrentemente com a Thread 1 e a Principal.
thread2 = Thread.new do
  puts "[Thread 2 - ID: #{Thread.current.native_thread_id}] Sistemas de Informacao"
end

# IMPORTANTE: O método .join força a Thread Principal a parar e esperar.
# Ela só continuará a execução quando a thread1 e a thread2 terminarem suas tarefas.
thread1.join
thread2.join

# Esta linha só será impressa DEPOIS que as Threads 1 e 2 finalizarem, graças ao .join.
puts "Thread principal finalizada"