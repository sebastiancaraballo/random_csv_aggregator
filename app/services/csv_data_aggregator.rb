require "csv"
require 'io/console'
require 'rubystats'

class CsvDataAggregator
  PERCENTAGE = 0.8
  POSSIBLE_VALUES = ['NO COMPRO','COMPRO'].freeze
  MODO_PAGO = ['DEBITO','CREDITO'].freeze

  attr_reader :csv_path,
              :task1_path, :task2_path,
              :headers, :new_rows

  def initialize
    @csv_path = 'public/file.txt'
    @task1_path = 'public/task1.csv'
    @task2_path = 'public/task2.csv'
    @headers = CSV.open(@csv_path, "r", {:col_sep => "\t"}) { |csv| csv.readline }
    rows = CSV.foreach(@csv_path, headers: true).count
    @new_rows = (rows * PERCENTAGE).to_i
  end

  def task1
    # Copy existing data
    CSV.open(task1_path, "w", {:col_sep => "\t"}) do |new_file|
      CSV.foreach(csv_path, "r", {:col_sep => "\t"}) do |original_row|
        new_file << original_row
      end
    end
   
    # Add additional random data
    CSV.open(task1_path, "a", {:col_sep => "\t"}) do |new_file|
      new_rows.times { new_file << headers.map { |column| POSSIBLE_VALUES.sample } }
    end

    puts "TASK 1: Succesfully added #{(PERCENTAGE*100).to_i}% of random generated rows @ #{task1_path}!"
  end

  def task2
    task1
    new_headers = headers << "\t" + "ModoPago"
    CSV.open(task2_path, "w") do |new_file|
      new_file << new_headers
      CSV.foreach(task1_path) do |original_row|
        new_file << (original_row << "\t" + MODO_PAGO.sample)
      end
    end

    puts "TASK 2: Succesfully added new column ModoPago with random generated data @ #{task2_path}!"
  end
end
