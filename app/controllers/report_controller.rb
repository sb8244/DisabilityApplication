class ReportController < ApplicationController

  def index
    # Just a view
  end

  def generate
    semester_start = params[:semester_start]
    finals_start = params[:finals_start]
    finals_end = params[:finals_end]
    @description = params[:description]

    reporter = Submission::SemesterReport.new(semester_start, finals_start, finals_end)

    @semester_report, @finals_report = reporter.generate
    @semester_subtotal = reporter.semester_subtotal
    @finals_subtotal = reporter.finals_subtotal
  end
end
