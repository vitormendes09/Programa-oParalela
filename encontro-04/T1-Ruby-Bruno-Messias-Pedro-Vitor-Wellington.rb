# PP-T1-Ruby-Bruno-Messias-Pedro-Vitor-Wellington
# Início
puts "Thread principal iniciada (PID: #{Process.pid})"

# Thread.new cria novas treads t=0
thread1 = Thread.new do
  puts "[Thread 1 - ID: #{Thread.current.native_thread_id}] Programacao Paralela"
end

thread2 = Thread.new do
  puts "[Thread 2 - ID: #{Thread.current.native_thread_id}] Sistemas de Informacao"
end

# Join aguarda as threads terminarem
thread1.join
thread2.join

puts "Thread principal finalizada"
