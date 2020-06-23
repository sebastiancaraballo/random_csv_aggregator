require "csv"
require 'io/console'
require 'rubystats'

class TextDataAggregator
  PERCENTAGE = 0.8
  DEVIATION = 0.01
  CLASE = ['A','B', 'C'].freeze

  attr_reader :csv_path, :task5_path, :task6_path, :original_rows, :new_rows, :headers, :total_rows
  attr_accessor :obs

  def initialize
    @csv_path = 'public/text_mining_clustering_1.csv'
    @task5_path = 'public/task5.csv'
    @task6_path = 'public/task6.csv'
    @headers = CSV.open(@csv_path, "r", {:col_sep => "\t"}) { |csv| csv.readline }
    @original_rows = CSV.foreach(@csv_path).count
    @new_rows = (@original_rows * PERCENTAGE).to_i
    @total_rows = @original_rows + @new_rows
    @obs = 100
  end

  def task5
    # Copy existing data
    CSV.open(task5_path, "w", {:col_sep => "\t"}) do |new_file|
      CSV.foreach(csv_path, "r", {:col_sep => "\t"}) do |original_row|
        new_file << original_row
      end
    end

    CSV.open(task5_path, "a", {:col_sep => "\t"}) do |new_file|
      first = (new_rows / 3).to_i
      second = first * 2
      new_rows.times do |index|
        if index >= 0 && index < first
            new_file << concepts_A_row(1, 3)
        elsif index > first && index < second
            new_file << concepts_B_row(4, 6)
        else
            new_file << concepts_C_row(7, 9)
        end
      end
    end

    puts "TASK 5: Succesfully added new #{new_rows} random generated rows @ #{task5_path}!"
  end

  def task6
    task5
    new_headers = headers << ("clase")
    CSV.open(task6_path, "w", {:col_sep => "\t"}) do |new_file|
      new_file << new_headers
      index = 0
      first = (total_rows / 3).to_i
      second = first * 2
      CSV.foreach(task5_path, {headers: true, col_sep: "\t"}) do |original_row|
        if index >= 0 && index < first
          new_file << (original_row << CLASE[0])
        elsif index > first && index < second
          new_file << (original_row << CLASE[1])
        else
          new_file << (original_row << CLASE[2])
        end

        index = index + 1        
      end
    end

    puts "TASK 6: Succesfully added new column <clase> @ #{task6_path}!"
  end

  def concepts_A_row(start_num, end_num)
    @obs = @obs + 1
    company = 'documento' + @obs.to_s
    termino1 = rand(start_num..end_num).to_s
    termino2 = rand(start_num..end_num).to_s
    termino3 = 3.to_s
    termino4 = 4.to_s
    termino5 = rand(start_num..end_num).to_s
    termino6 = rand(start_num..end_num).to_s
    termino7 = rand(start_num..end_num).to_s
    termino8 = rand(start_num..end_num).to_s
    termino9 = rand(start_num..end_num).to_s
    termino10 = rand(start_num..end_num).to_s
    [company, termino1, termino2, termino3, termino4, termino5, termino6, termino7, termino8, termino9, termino10]
  end

  def concepts_B_row(start_num, end_num)
    @obs = @obs + 1
    company = 'documento' + @obs.to_s
    termino1 = rand(start_num..end_num).to_s
    termino2 = rand(start_num..end_num).to_s
    termino3 = rand(start_num..end_num).to_s
    termino4 = rand(start_num..end_num).to_s
    termino5 = rand(start_num..end_num).to_s
    termino6 = 6.to_s
    termino7 = 7.to_s
    termino8 = rand(start_num..end_num).to_s
    termino9 = rand(start_num..end_num).to_s
    termino10 = rand(start_num..end_num).to_s
    [company, termino1, termino2, termino3, termino4, termino5, termino6, termino7, termino8, termino9, termino10]
  end

  def concepts_C_row(start_num, end_num)
    @obs = @obs + 1
    company = 'documento' + @obs.to_s
    termino1 = rand(start_num..end_num).to_s
    termino2 = rand(start_num..end_num).to_s
    termino3 = rand(start_num..end_num).to_s
    termino4 = rand(start_num..end_num).to_s
    termino5 = rand(start_num..end_num).to_s
    termino6 = rand(start_num..end_num).to_s
    termino7 = rand(start_num..end_num).to_s
    termino8 = rand(start_num..end_num).to_s
    termino9 = 8.to_s
    termino10 = 9.to_s
    [company, termino1, termino2, termino3, termino4, termino5, termino6, termino7, termino8, termino9, termino10]
  end
end
