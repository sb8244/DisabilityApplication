class Submission::Colorer
  def initialize(submissions)
    @submissions = submissions
  end

  def color
    @submission_mapping = {}
    @color_index = 0
    count = {}

    # Construct the counter of alike submissions
    @submissions.each do |submission|
      key = key(submission)
      count[key] = 0 unless count.has_key?(key)
      count[key] += 1
    end

    # Construct the unique coloring of a key to a color
    color_mapping = {}
    @submissions.each do |submission|
      key = key(submission)
      color_mapping[key] = next_color if count[key] > 1 && !color_mapping.has_key?(key)
    end

    # Map the color for submissions that should have colors
    @submissions.each do |submission|
      key = key(submission)
      @submission_mapping[submission] = color_mapping[key] if color_mapping.has_key?(key)
    end

    submission_mapping
  end

  def submission_mapping
    @submission_mapping
  end

  def color_list
    ["#F3F315", "#947966", "#A55CA2", "#A45E67", "#80539E", "#897C40", "#6BAE9F", "#9773AE",
      "#556A9B", "#BB935B", "#749F70", "#635F93", "#5E8A91", "#904367", "#517D57", "#67B842",
      "#AD4F4E", "#63AE6D", "#B0B1B0", "#568098", "#B5B47D", "#73567D", "#4BAB5D", "#98B07D",
      "#94A873", "#667558", "#684C8C", "#84A051", "#9B7047", "#BC7B83", "#40A964", "#A15A98",
      "#6F74AB", "#A14A4E", "#A58EB2", "#95478B", "#9A956B", "#7B9469", "#BD6D43", "#427ABD",
      "#B7B4A3", "#65AD97", "#876C66", "#B986B7", "#917F99", "#78B647", "#6666B6", "#776881",
      "#867D41", "#B24945", "#4D5263", "#57BB7E", "#51B743", "#443F59", "#B38953", "#8851A6",
      "#629EA6", "#4E845F", "#5D6E5C", "#AE9695", "#434947", "#4D6BAB", "#627D48", "#9A9B7D",
      "#535D6F", "#79BD93", "#75A28D", "#A985BD", "#42465E", "#548689", "#BC6F6B", "#63B2B4",
      "#54BBA1", "#463FBD", "#B88564", "#596B81", "#57578A", "#A26D47", "#49BB8D", "#9297A1"]
  end

  private
    def next_color
      if @color_index < color_list.count
        color = color_list[@color_index]
      else
        color = random_color
      end
      @color_index += 1
      color
    end

    def key(submission)
      "#{submission.course_number} #{submission.professor.email} #{submission.start_time}"
    end

    def random_color
      "#%02X%02X%02X" % [rand(255/2) + (255/4), rand(255/2) + (255/4), rand(255/2) + (255/4)]
    end
end
