module.exports = (robot) ->
  GoogleSpreadsheets = require("google-spreadsheets")
  robot.respond /foo/i, (msg) ->
    GoogleSpreadsheets {
      key: '1uygvgPqy3K7xESphSmrkX6vi8eS2y30_8S5FrSfW_6o'
    }, (error, spreadsheet) ->
      msg.send "Oups! #{error}!" if error
      spreadsheet.worksheets[0].cells { range: 'R1C1:R5C5' }, (error, result) ->
        string = 'fake'
        console.log(result.cells)
        for row_number, row of result.cells
          console.log(row_number) if new RegExp(string).test row.value
