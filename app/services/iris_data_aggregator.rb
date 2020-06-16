require "csv"
require 'io/console'
require 'rubystats'

class IrisDataAggregator
  PERCENTAGE = 0.8
  DEVIATION = 0.3

  attr_reader :csv_path, :task3_path, :original_rows, :new_rows

  def initialize
    @csv_path = 'public/iris.csv'
    @task3_path = 'public/task3.csv'
    @original_rows = CSV.foreach(@csv_path).count
    @new_rows = (@original_rows * PERCENTAGE).to_i
  end

  def task3
    # Copy existing data
    CSV.open(task3_path, "w") do |new_file|
      CSV.foreach(csv_path, "r") do |original_row|
        new_file << original_row
      end
    end

    # Add new data based on averages from https://mohitatgithub.github.io/2018-02-16-Machine-Learning-with-Iris-dataset/
    CSV.open(task3_path, "a") do |new_file|
      new_rows.times do
        line = CSV.readlines(csv_path)[rand(0..(original_rows-1))]
        type = line[4]
        case type
        when 'Iris-setosa'
          new_file << (setosa << type)
        when 'Iris-versicolor'
          new_file << (versicolor << type)
        when 'Iris-virginica'
          new_file << (virginica << type)
        end
      end
    end
    puts "TASK 3: Succesfully added new #{new_rows} random generated rows @ #{task3_path}!"
  end

  def setosa
    sepallength = Rubystats::NormalDistribution.new(5.006, DEVIATION).rng.round(1).abs
    sepalwidth = Rubystats::NormalDistribution.new(3.418, DEVIATION).rng.round(1).abs
    petallength = Rubystats::NormalDistribution.new(1.464, DEVIATION).rng.round(1).abs
    petalwidth = Rubystats::NormalDistribution.new(0.244, DEVIATION).rng.round(1).abs
    [sepallength.to_s, sepalwidth.to_s, petallength.to_s, petalwidth.to_s]
  end

  def versicolor
    sepallength = Rubystats::NormalDistribution.new(5.936, DEVIATION).rng.round(1).abs
    sepalwidth = Rubystats::NormalDistribution.new(2.770, DEVIATION).rng.round(1).abs
    petallength = Rubystats::NormalDistribution.new(4.260, DEVIATION).rng.round(1).abs
    petalwidth = Rubystats::NormalDistribution.new(1.326, DEVIATION).rng.round(1).abs
    [sepallength.to_s, sepalwidth.to_s, petallength.to_s, petalwidth.to_s]
  end

  def virginica
    sepallength = Rubystats::NormalDistribution.new(6.588, DEVIATION).rng.round(1).abs
    sepalwidth = Rubystats::NormalDistribution.new(2.974, DEVIATION).rng.round(1).abs
    petallength = Rubystats::NormalDistribution.new(5.552, DEVIATION).rng.round(1).abs
    petalwidth = Rubystats::NormalDistribution.new(2.026, DEVIATION).rng.round(1).abs
    [sepallength.to_s, sepalwidth.to_s, petallength.to_s, petalwidth.to_s]
  end
end
