require "rails_helper"

RSpec.describe ExportMoviesJob do
  include ActiveJob::TestHelper
  let(:user) do
    create(:user)
  end
  let(:file_path) do
     "tmp/movies.csv"
  end

  subject(:job) do
    ExportMoviesJob.perform_later(user, file_path)
  end

  it 'queues the job' do
    expect do
      job
    end.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
  end

  it 'is in default queue' do
    expect(ExportMoviesJob.new.queue_name).to eq('default')
  end

  it 'executes perform' do
    expect_any_instance_of(MovieExporter).to receive(:call).with(user, file_path)
    perform_enqueued_jobs do
      job
    end
  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end