function loadImage(dateText) {

    // The date format is "MM/dd/yyyy", in string
    month = dateText.substring(0, 2);
    day = dateText.substring(3, 5);
    year = dateText.substring(6);


    $('img')[0].src = "http://" +
            image_base_url + "/" +
            year + month + "/" +
            year + month + day + "/" +
            year + month + day + "_0000.png";

}

function loadImageFail()
{
    //$('img').attr({"src":"./image/loadimagefail.jpg","width":254,"height":34});
    alert("Sorry, this image doesn't exist.")
}

function loadTable(dateText) {
    month = dateText.substring(0, 2);
    day = dateText.substring(3, 5);
    year = dateText.substring(6);



    date = year + month + day;
    files = new Array();
    for (i in fileTypes) {
        files.push(fileTypes[i][0] + date + fileTypes[i][1]);
    }

    $.get("servlet/Table", {year: year, month: month, day: day, files: files.toString()},
            function (data)
            {
                modifyTable(data);
            }
    );
}

function modifyTable(data) {
    var tdata = $('#tdata');
    url = "http://" +
            image_base_url + "/" +
            year + month + "/" +
            year + month + day + "/";

    $('.rdata').remove();

    for (var i = 0; i < data.length; i++) {
        if (data.charAt(i) == '0')
            continue;
        var name = files[i];
        var tr = $('<tr class=\"rdata\"\>');
        tr.append('<td>' + name + '</td>');
        tr.append('<td><a href=\"' + url + name + '\">link</a></td>');
        tr.append('<td/>');
        tdata.append(tr);
    }
}