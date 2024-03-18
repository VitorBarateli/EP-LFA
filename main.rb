class AFD
  MORSE_PARA_ALFABETO = {
    ".-" => "a", "-..." => "b", "-.-." => "c", "-.." => "d", " " => " ",
    "." => "e", "..-." => "f", "--." => "g", "...." => "h", "..--" => "u", 
    ".." => "i", ".---" => "j", "-.-" => "k", ".-.." => "l", "----" => "ch",
    "--" => "m", "-." => "n", "---" => "o", ".--." => "p", ".-.-." => "",
    "--.-" => "q", ".-." => "r", "..." => "s", "-" => "t",
    "..-" => "u", "...-" => "v", ".--" => "w", "-..-" => "x",
    "-.--" => "y", "--.." => "z", ".----" => "1", "..---" => "2",
    "...--" => "3", "....-" => "4", "....." => "5", "-...." => "6",
    "--..." => "7", "---.." => "8", "----." => "9", "-----" => "0",
    "--..--" => ",", "-....-" => "-", ".-.-.-" => "."
  }

  def proximo
    puts "\nEntre com o próximo símbolo:"
    gets.chomp
  end

  def iniciar
    frase_completa = ""
    
    loop do
      estado = "q0"
      caractere = ""
      puts "Máquina iniciou no estado: " + estado

      while true
        entrada = proximo
        caractere << entrada
        transicoes = transicoes(estado)
        transicao = transicoes.find { |trans| entrada.match(/#{trans[0]}/) }

        if transicao
          estado = transicao[1]
          if entrada.empty? && estado.start_with?('q')
            if MORSE_PARA_ALFABETO.key?(caractere)
              if estado == "q12"
                puts "Aceito, código morse existente"
                frase_completa << MORSE_PARA_ALFABETO[caractere]
                puts "Caractere correspondente: \"vazio\""
                break
              else
                puts "Aceito, código morse existente"
                frase_completa << MORSE_PARA_ALFABETO[caractere]
                puts "Caractere correspondente: #{MORSE_PARA_ALFABETO[caractere]}"
                break
              end
            else
              puts "Erro, código morse não existe"
              break
            end
          end
        else
          puts "Erro, código morse não existe"
          break
        end

        puts "Estado: " + estado
      end

      puts "\nDeseja continuar? (s/n)"
      resposta = gets.chomp.downcase
      puts "\n"
      break if resposta == 'n'
    end
    puts "\nFrase formada: #{frase_completa}"
  end

  def transicoes(estado)
    case estado
    when "q0"
      [["\\.", "q1"], ["-", "q6"], [" ", "q12"]]
    when "q1"
      [["\\.", "q2"], ["-", "q7"], ["", "q1"]]
    when "q2"
      [["\\.", "q3"], ["-", "q8"], ["", "q2"]]
    when "q3"
      [["\\.", "q4"], ["-", "q9"], ["", "q3"]]
    when "q4"
      [["\\.", "q5"], ["-", "q10"], ["", "q4"]]
    when "q5"
      [["", "q5"]]
    when "q6"
      [["-", "q7"], ["\\.", "q2"], ["", "q6"]]
    when "q7"
      [["-", "q8"], ["\\.", "q3"], ["", "q7"]]
    when "q8"
      [["-", "q9"], ["\\.", "q4"], ["", "q8"]]
    when "q9"
      [["-", "q10"], ["\\.", "q5"], ["", "q9"]]
    when "q10"
      [["", "q10"]]
    when "q12"
      [["", "q12"]]
    else
      []
    end
  end
end

adf = AFD.new()
adf.iniciar()