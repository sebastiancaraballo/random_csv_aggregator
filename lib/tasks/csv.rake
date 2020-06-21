
namespace :csv do
  desc 'task1: append new rows'
  task task1: :environment do
    CsvDataAggregator.new.task1
  end
  desc 'task2: add payment mode'
  task task2: :environment do
    CsvDataAggregator.new.task2
  end
  desc 'task3: iris'
  task task3: :environment do
    IrisDataAggregator.new.task3
  end
  desc 'task4: empresas'
  task task4: :environment do
    CompanyDataAggregator.new.task4
  end
end
