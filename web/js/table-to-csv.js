function exportTableToCSV($table, filename) {

    // if($table.find('tbody').children().length<=0){
    // var $rows = $table.find('tr:has(td),tr:has(th)'),
    var $rows = $table.find('tr:has(td):has(.export-checkbox:checked),tr:has(th)'),

        // Temporary delimiter characters unlikely to be typed by keyboard
        // This is to avoid accidentally splitting the actual contents
        tmpColDelim = String.fromCharCode(11), // vertical tab character
        tmpRowDelim = String.fromCharCode(0), // null character

        // actual delimiter characters for CSV format
        colDelim = '","',
        rowDelim = '"\r\n"',

        // Grab text from table into CSV formatted string
        csv = '"' + $rows.map(function (i, row) {
                var $row = $(row), $cols = $row.find('td,th');

                return $cols.map(function (j, col) {
                    var $col = $(col), text = $col.text();

                    return text.replace(/"/g, '""'); // escape double quotes

                }).get().join(tmpColDelim);

            }).get().join(tmpRowDelim)
                .split(tmpRowDelim).join(rowDelim)
                .split(tmpColDelim).join(colDelim) + '"',

        // Data URI
        csvData = 'data:application/csv;charset=utf-8,' + encodeURIComponent(csv);

    console.log(csv);

    if (window.navigator.msSaveBlob) { // IE 10+
        // alert('IE' + csv);
        window.navigator.msSaveOrOpenBlob(new Blob([csv], {type: "text/plain;charset=utf-8;"}), filename)
    }
    else {
        $(this).attr({'download': filename, 'href': csvData, 'target': '_blank'});

    }
}

function exportTableToCSVInStatistics($table, filename, total) {

    // if($table.find('tbody').children().length<=0){
    // var $rows = $table.find('tr:has(td),tr:has(th)'),
    var $rows = $table.find('tr:has(td),tr:has(th)'),

        // Temporary delimiter characters unlikely to be typed by keyboard
        // This is to avoid accidentally splitting the actual contents
        tmpColDelim = String.fromCharCode(11), // vertical tab character
        tmpRowDelim = String.fromCharCode(0), // null character

        // actual delimiter characters for CSV format
        colDelim = '","',
        rowDelim = '"\r\n"',

        // Grab text from table into CSV formatted string
        csv = '"' + $rows.map(function (i, row) {
                var $row = $(row), $cols = $row.find('td,th');

                return $cols.map(function (j, col) {
                    var $col = $(col), text = $col.text();

                    return text.replace(/"/g, '""'); // escape double quotes

                }).get().join(tmpColDelim);

            }).get().join(tmpRowDelim)
                .split(tmpRowDelim).join(rowDelim)
                .split(tmpColDelim).join(colDelim);

    // Data URI

    csv += rowDelim+'total' + colDelim + total + '"';
    csvData = 'data:application/csv;charset=utf-8,' + encodeURIComponent(csv);

    // console.log(csv);

    if (window.navigator.msSaveBlob) { // IE 10+
        // alert('IE' + csv);
        window.navigator.msSaveOrOpenBlob(new Blob([csv], {type: "text/plain;charset=utf-8;"}), filename)
    }
    else {
        $(this).attr({'download': filename, 'href': csvData, 'target': '_blank'});

    }
}