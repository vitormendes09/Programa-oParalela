require "parallel"
require "benchmark"

tarefa = ->(i) { sleep(0.5); "Tarefa #{i} concluída" }

tempo_serial = Benchmark.realtime do
  (1..4).map(&tarefa)
end

tempo_paralelo = Benchmark.realtime do
  Parallel.map(1..4, in_threads: 4, &tarefa)
end

puts "Serial:   #{tempo_serial.round(2)}s"
puts "Paralelo: #{tempo_paralelo.round(2)}s"