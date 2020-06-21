require "csv"
require 'io/console'
require 'rubystats'

class CompanyDataAggregator
  PERCENTAGE = 0.8
  DEVIATION = 0.01

  attr_reader :csv_path, :task4_path, :original_rows, :new_rows
  attr_accessor :obs

  def initialize
    @csv_path = 'public/empresas2.csv'
    @task4_path = 'public/task4.csv'
    @original_rows = CSV.foreach(@csv_path).count
    @new_rows = (@original_rows * PERCENTAGE).to_i
    @obs = 49
  end

  def task4
    # Copy existing data
    CSV.open(task4_path, "w") do |new_file|
      CSV.foreach(csv_path, "r") do |original_row|
        new_file << original_row
      end
    end

    # Add new data based on averages
    CSV.open(task4_path, "a") do |new_file|
      new_rows.times do
        line = CSV.readlines(csv_path)[rand(0..(original_rows-1))]
        type = line[5]
        case type
        when 'Quebro'
          new_file << (quebro << type)
        when 'NoQuebro'
          new_file << (noquebro << type)
        end
      end
    end
    puts "TASK 4: Succesfully added new #{new_rows} random generated rows @ #{task4_path}!"
  end

  def quebro
    @obs = @obs + 1
    flujo_de_caja_deuda_total = Rubystats::NormalDistribution.new(-0.0031, DEVIATION).rng.round(4).abs
    ingreso_neto_activo_total = Rubystats::NormalDistribution.new(-0.0026, DEVIATION).rng.round(4).abs
    activo_corriente_pasivo_corriente = Rubystats::NormalDistribution.new(0.0654, DEVIATION).rng.round(4).abs
    activo_corriente_ventas_netas =Rubystats::NormalDistribution.new(0.0192, DEVIATION).rng.round(4).abs
    [obs, flujo_de_caja_deuda_total, ingreso_neto_activo_total, activo_corriente_pasivo_corriente, activo_corriente_ventas_netas]
  end

  def noquebro
    @obs = @obs + 1
    flujo_de_caja_deuda_total = Rubystats::NormalDistribution.new(-0.0006, DEVIATION).rng.round(4).abs
    ingreso_neto_activo_total = Rubystats::NormalDistribution.new(0.0009, DEVIATION).rng.round(4).abs
    activo_corriente_pasivo_corriente = Rubystats::NormalDistribution.new(0.0821, DEVIATION).rng.round(4).abs
    activo_corriente_ventas_netas =Rubystats::NormalDistribution.new(0.0139, DEVIATION).rng.round(4).abs
    [obs, flujo_de_caja_deuda_total, ingreso_neto_activo_total, activo_corriente_pasivo_corriente, activo_corriente_ventas_netas]
  end
end
