require 'rubyXL'

class PicaReportImporter

  # These are symbolized version of the expected column headings of all the data we care about.
  # TODO: in the future, it might be nice to make these configurable by the user
  DESIRED_DATA = [
    :term, :subject, :course, :sect, :instructor, :enrollment,
    :item1_mean, :item2_mean, :item3_mean, :item4_mean,
    :item5_mean, :item6_mean, :item7_mean, :item8_mean
  ]

  RENAMES = { :sect => :section }

  def initialize(uploaded_file)
    @workbook = RubyXL::Parser.parse_buffer(uploaded_file.tempfile)
  end

  def evaluation_hashes
    sheet = @workbook.first

    # figure out the columns of the data from the headers
    column_header_indices = {}
    sheet[0].cells.each_with_index do |cell, i|
      column_header_indices[cell.value.downcase.to_sym] = i
    end

    evaluations = []

    sheet.each_with_index do |row, row_num|
      # skip the first row. It's just column headings
      next if row_num == 0

      evaluation = {}
      DESIRED_DATA.each do |data_type|
        cell = row.cells[column_header_indices[data_type]]

        data_type = RENAMES[data_type] if RENAMES[data_type]
        evaluation[data_type] = cell && cell.value
      end

      evaluations.push(evaluation)
    end

    evaluations
  end
end
