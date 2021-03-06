class Submission::SemesterReport

  def initialize(start, final_start, final_end)
    @submissions = Submission.find_in_date(start, final_start)
    @finals = Submission.find_in_date(final_start, final_end)
  end

  def generate
    @semester_report = {}
    @finals_report = {}

    @submissions.each do |submission|
      generate_entry_for_report(@semester_report, submission)
    end

    @finals.each do |submission|
      generate_entry_for_report(@finals_report, submission)
    end

    return @semester_report, @finals_report
  end

  def semester_subtotal
    totals_for_report(@semester_report)
  end

  def finals_subtotal
    totals_for_report(@finals_report)
  end

  private

    # Given a report, sum up all entries into a total array
    def totals_for_report(report)
      total = {
        reader_scribe: 0,
        laptop_scribe: 0,
        reader: 0,
        scribe: 0,
        laptop: 0,
        extended: 0,
        regular: 0,
        no_show: 0,
        cancelled: 0,
        total: 0
      }

      report.each do |date, entry|
        entry.each do |k, v|
          total[k] += v
        end
      end

      total
    end

    # Add a submission to a report, hashed by date
    def generate_entry_for_report(report, submission)
      date_key = submission.start_time.to_date
      unless report.has_key?(date_key)
        report[date_key] = {
          reader_scribe: 0,
          laptop_scribe: 0,
          reader: 0,
          scribe: 0,
          laptop: 0,
          extended: 0,
          regular: 0,
          no_show: 0,
          cancelled: 0,
          total: 0
        }
      end

      regular = true
      report[date_key][:total] += 1

      if submission.no_show?
        report[date_key][:no_show] += 1
        report[date_key][:total] -= 1
      elsif submission.cancelled?
        report[date_key][:cancelled] += 1
        report[date_key][:total] -= 1
      else
        if submission.reader?
          regular = false
          if submission.scribe?
            report[date_key][:reader_scribe] += 1
          else
            report[date_key][:reader] += 1
          end
        end

        if submission.laptop?
          regular = false
          if submission.scribe?
            report[date_key][:laptop_scribe] += 1
          else
            report[date_key][:laptop] += 1
          end
        end

        if submission.scribe? && !submission.reader? && !submission.laptop?
          report[date_key][:scribe] += 1
          regular = false
        end

        if submission.extended?
          regular = false
          report[date_key][:extended] += 1
        end
      end

      report[date_key][:regular] += 1 if regular
    end
end
