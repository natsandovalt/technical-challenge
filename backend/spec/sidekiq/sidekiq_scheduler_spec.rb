# frozen_string_literal: true

require 'rails_helper'
require 'fugit'

RSpec.describe 'sidekiq-scheduler' do
  sidekiq_file = File.join(Rails.root, 'config', 'schedule.yml')
  schedule = YAML.load_file(sidekiq_file)[:schedule]

  describe 'cron syntax' do
    schedule.each do |k, v|
      cron = v['cron']
      it "#{k} has correct cron syntax" do
        expect { Fugit.do_parse(cron) }.to_not raise_error
      end
    end
  end

  describe 'cron classes' do
    schedule.each do |k, v|
      klass = v['class']
      it "#{k} has #{klass} class in /sidekiq" do
        expect { klass.constantize }.to_not raise_error
      end
    end
  end

  describe 'job names' do
    schedule.each do |k, v|
      klass = v['class']
      it "#{k} has correct name" do
        expect(k).to eq(klass.underscore)
      end
    end
  end
end
