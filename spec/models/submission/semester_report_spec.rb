require 'spec_helper'

describe Submission::SemesterReport do

  describe "reports" do
    context "single submission" do
      it "no extended time" do
        submission = FactoryGirl.create(:submission, extended: false)

        reporter = Submission::SemesterReport.new(submission.start_time,
                                                  submission.start_time + 1.day,
                                                  submission.start_time + 1.day)
        semester, finals = reporter.generate

        expect(semester.count).to eq(1)
        expect(semester[submission.start_time.to_date][:extended]).to eq(0)
        expect(semester[submission.start_time.to_date][:total]).to eq(1)
      end

      it "has extended time" do
        submission = FactoryGirl.create(:submission, extended: true)

        reporter = Submission::SemesterReport.new(submission.start_time,
                                                  submission.start_time + 1.day,
                                                  submission.start_time + 1.day)
        semester, finals = reporter.generate

        expect(semester[submission.start_time.to_date][:extended]).to eq(1)
        expect(semester[submission.start_time.to_date][:total]).to eq(1)
      end

      it "has reader" do
        submission = FactoryGirl.create(:submission, reader: true, extended: false)

        reporter = Submission::SemesterReport.new(submission.start_time,
                                                  submission.start_time + 1.day,
                                                  submission.start_time + 1.day)
        semester, finals = reporter.generate

        expect(semester[submission.start_time.to_date][:reader]).to eq(1)
        expect(semester[submission.start_time.to_date][:total]).to eq(1)
      end

      it "has scribe" do
        submission = FactoryGirl.create(:submission, scribe: true, extended: false)

        reporter = Submission::SemesterReport.new(submission.start_time,
                                                  submission.start_time + 1.day,
                                                  submission.start_time + 1.day)
        semester, finals = reporter.generate

        expect(semester[submission.start_time.to_date][:scribe]).to eq(1)
        expect(semester[submission.start_time.to_date][:total]).to eq(1)
      end

      it "has laptop" do
        submission = FactoryGirl.create(:submission, laptop: true, extended: false)

        reporter = Submission::SemesterReport.new(submission.start_time,
                                                  submission.start_time + 1.day,
                                                  submission.start_time + 1.day)
        semester, finals = reporter.generate

        expect(semester[submission.start_time.to_date][:laptop]).to eq(1)
        expect(semester[submission.start_time.to_date][:total]).to eq(1)
      end

      it "has no show" do
        submission = FactoryGirl.create(:submission, no_show: true, extended: true)

        reporter = Submission::SemesterReport.new(submission.start_time,
                                                  submission.start_time + 1.day,
                                                  submission.start_time + 1.day)
        semester, finals = reporter.generate

        expect(semester[submission.start_time.to_date][:no_show]).to eq(1)
        expect(semester[submission.start_time.to_date][:total]).to eq(1)
        expect(semester[submission.start_time.to_date][:extended]).to eq(0)
      end

      it "has cancelled" do
        submission = FactoryGirl.create(:submission, cancelled: true, extended: true)

        reporter = Submission::SemesterReport.new(submission.start_time,
                                                  submission.start_time + 1.day,
                                                  submission.start_time + 1.day)
        semester, finals = reporter.generate

        expect(semester[submission.start_time.to_date][:cancelled]).to eq(1)
        expect(semester[submission.start_time.to_date][:total]).to eq(1)
        expect(semester[submission.start_time.to_date][:extended]).to eq(0)
      end

      it "has reader/scribe" do
        submission = FactoryGirl.create(:submission, reader: true, scribe: true, extended: false)

        reporter = Submission::SemesterReport.new(submission.start_time,
                                                  submission.start_time + 1.day,
                                                  submission.start_time + 1.day)
        semester, finals = reporter.generate

        expect(semester[submission.start_time.to_date][:reader_scribe]).to eq(1)
        expect(semester[submission.start_time.to_date][:reader]).to eq(0)
        expect(semester[submission.start_time.to_date][:scribe]).to eq(0)
        expect(semester[submission.start_time.to_date][:total]).to eq(1)
      end

      it "has laptop/scribe" do
        submission = FactoryGirl.create(:submission, laptop: true, scribe: true, extended: false)

        reporter = Submission::SemesterReport.new(submission.start_time,
                                                  submission.start_time + 1.day,
                                                  submission.start_time + 1.day)
        semester, finals = reporter.generate

        expect(semester[submission.start_time.to_date][:laptop_scribe]).to eq(1)
        expect(semester[submission.start_time.to_date][:laptop]).to eq(0)
        expect(semester[submission.start_time.to_date][:scribe]).to eq(0)
        expect(semester[submission.start_time.to_date][:total]).to eq(1)
      end
    end

    context "multiple submissions" do
      it "same date" do
        submission = FactoryGirl.create(:submission, extended: false)
        FactoryGirl.create(:submission, extended: true)

        reporter = Submission::SemesterReport.new(submission.start_time,
                                                  submission.start_time + 1.day,
                                                  submission.start_time + 1.day)
        semester, finals = reporter.generate

        expect(semester[submission.start_time.to_date][:extended]).to eq(1)
        expect(semester[submission.start_time.to_date][:total]).to eq(2)
      end

      it "different date" do
        submission = FactoryGirl.create(:submission, extended: true)
        FactoryGirl.create(:submission, extended: true, start_time: submission.start_time + 1.day)

        reporter = Submission::SemesterReport.new(submission.start_time,
                                                  submission.start_time + 1.day,
                                                  submission.start_time + 1.day)
        semester, finals = reporter.generate

        expect(semester[submission.start_time.to_date][:extended]).to eq(1)
        expect(semester[submission.start_time.to_date][:total]).to eq(1)

        expect(semester[submission.start_time.to_date + 1.day][:extended]).to eq(1)
        expect(semester[submission.start_time.to_date + 1.day][:total]).to eq(1)
      end
    end

    context "finals" do
      it "different dates" do
        submission = FactoryGirl.create(:submission, extended: true)
        FactoryGirl.create(:submission, extended: true, start_time: submission.start_time + 1.day)

        reporter = Submission::SemesterReport.new(submission.start_time - 1.day,
                                                  submission.start_time,
                                                  submission.start_time + 1.day)
        semester, finals = reporter.generate

        expect(finals[submission.start_time.to_date][:extended]).to eq(1)
        expect(finals[submission.start_time.to_date][:total]).to eq(1)
        expect(finals[submission.start_time.to_date + 1.day][:extended]).to eq(1)
        expect(finals[submission.start_time.to_date + 1.day][:total]).to eq(1)
      end
    end
  end

  describe "subtotal" do
    context "multiple submissions" do
      context "for semester" do
        it "same date" do
          submission = FactoryGirl.create(:submission, extended: false)
          FactoryGirl.create(:submission, extended: true)

          reporter = Submission::SemesterReport.new(submission.start_time,
                                                    submission.start_time + 1.day,
                                                    submission.start_time + 1.day)
          reporter.generate
          semester_subtotal = reporter.semester_subtotal

          expect(semester_subtotal[:extended]).to eq(1)
          expect(semester_subtotal[:total]).to eq(2)
        end

        it "different date" do
          submission = FactoryGirl.create(:submission, extended: true)
          FactoryGirl.create(:submission, extended: true, start_time: submission.start_time + 1.day)

          reporter = Submission::SemesterReport.new(submission.start_time,
                                                    submission.start_time + 1.day,
                                                    submission.start_time + 1.day)
          reporter.generate
          semester_subtotal = reporter.semester_subtotal

          expect(semester_subtotal[:extended]).to eq(2)
          expect(semester_subtotal[:total]).to eq(2)
        end
      end

      context "for final" do
        it "same date" do
          submission = FactoryGirl.create(:submission, extended: false)
          FactoryGirl.create(:submission, extended: true)

          reporter = Submission::SemesterReport.new(submission.start_time - 1.day,
                                                    submission.start_time,
                                                    submission.start_time + 1.day)
          reporter.generate
          final_subtotal = reporter.finals_subtotal
          expect(final_subtotal[:extended]).to eq(1)
          expect(final_subtotal[:total]).to eq(2)
        end
      end
    end
  end
end
