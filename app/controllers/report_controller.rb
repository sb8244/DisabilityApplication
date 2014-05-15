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

    # Commit is the name of the submit button rails uses
    if params[:commit] == 'Generate Excel Report'
      workbook = Submission::SemesterReportXlsx.new(
        semester_report: @semester_report,
        semester_subtotal: @semester_subtotal,
        finals_report: @finals_report,
        finals_subtotal: @finals_subtotal
      )

      return send_data(
        workbook.generate,
        content_type: xlsx_mime,
        disposition: 'attachment',
        filename: "semester-report-#{DateTime.now.strftime("%Y-%m-%d")}.xlsx"
      )
    end
  end

  private

  def xlsx_mime
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
  end
end
