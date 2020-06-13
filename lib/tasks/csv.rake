
namespace :csv do
  desc 'task1: append new rows'
  task task1: :environment do
    CsvDataAggregator.new.task1
  end
  desc 'task2: add payment mode'
  task task2: :environment do
    CsvDataAggregator.new.task2
  end
end
